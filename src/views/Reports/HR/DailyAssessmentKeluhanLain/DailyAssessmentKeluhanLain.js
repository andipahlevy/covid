import React, { Component } from 'react';
import {
	Card,
	CardBody,
	CardHeader,
	Col,
	Row,
} from 'reactstrap';
import DatePicker from 'react-datepicker';
import 'react-datepicker/dist/react-datepicker.css';
import {
	CardTreePeriod,
	ContentHeader,
	ButtonExcel,
	ButtonProcess,
} from '../../../Components';
import {
	pathAPIServer,
	pathReportDetail,
} from '../../../Constants';

class DailyAssessmentKeluhanLain extends Component {
	_isMounted = false;

	constructor(props) {
		super(props);
		this.handleStartChange = this.handleStartChange.bind(this);
		this.handleColumnsData = this.handleColumnsData.bind(this);
		this.handleFinishData = this.handleFinishData.bind(this);
		this.handleProcessClick = this.handleProcessClick.bind(this);
		this.state = {
			dataUserID: 1,
			dataTitle: '',
			pathHelp: '',
			dataReportID: 85,
			dataReport: [],
			dataExcel: [],
			dataColumns: [],

			startDate: new Date(),
			endDate: new Date(),

			isLoading: false,
			error: null
		};
	}

	handleStartChange(startDate) {
		this.setState({ startDate: startDate, endDate: startDate});	
	}

	handleProcessClick(plant) {
		this.setState({ isLoading: true }, function() {
			this.componentDidMount();
			this.setState({ isLoading: false }, function() {
			});
		})
	}

	handleColumnsData(data) {
		this.setState({ dataColumns: data });
	}

	handleFinishData(data) {
		this.setState({ dataExcel: data });
	}

	async componentDidMount() {
		this._isMounted = true;
		this.setState({ isLoading: true });

		const dataReportID = this.state.dataReportID

		let responseReport = await fetch(pathAPIServer + pathReportDetail + dataReportID);
		let dataReport = await responseReport.json();

		if (this._isMounted) {
			this.setState({ dataReport: dataReport.recordset, dataTitle: dataReport.recordset[0].Report_Name, isLoading: false });
		}
	}

	componentWillUnmount() {
		this._isMounted = false;
	}

	render() {
		const { isLoading, error, dataUserID, dataReport, dataReportID, dataTitle, dataExcel, dataColumns,
						startDate, endDate } = this.state

		if (error) {
			return <p>{error.message}</p>;
		}

		if (isLoading) {
			return <p>Loading ...</p>;
		}

		return (
			<div className="animated fadeIn">

				<Row>
					<Col xs="12">
						<Card>
							<CardHeader>
								<ContentHeader
									dataTitle={dataTitle}
									pathHelp=''
								/>
							</CardHeader>
							<CardBody>
								<DatePicker
									selected={startDate}
									dateFormat="d MMMM yyyy"
									placeholderText="Select start date"
									selectsStart
									startDate={startDate}
									endDate={endDate}
									onChange={this.handleStartChange}
									showMonthDropdown
									showYearDropdown
									dropdownMode="select"
								/>
								&emsp;
								<ButtonProcess
									onClick={this.handleProcessClick}
								/>
								&emsp;
								<ButtonExcel
									dataTitle={dataTitle}
									dataExcel={dataExcel}
									dataColumns={dataColumns}
									dataReportID={dataReportID}
								/>
							</CardBody>
						</Card>
					</Col>
				</Row>

				<Row>
					<Col xs="12">

						{
							dataReport.map((item, i) =>
								<CardTreePeriod
									key={i}
									dataTitle={item.Report_Name}
									pathHelp=''
									pathReport={item.Report_API}
									dataUserID={dataUserID}
									dataReportID={item.Report_ID}
									viewMode={item.Report_Table}
									paramsList={item.Report_Params}
									startDate={startDate}
									endDate={endDate}
									onFinish={this.handleFinishData}
									onColumns={this.handleColumnsData}
								/>
							)
						}

					</Col>
				</Row>
			</div>
		);
	}
}

export default DailyAssessmentKeluhanLain;