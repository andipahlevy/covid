import React, { Component } from 'react';
import {
	Card,
	CardBody,
	CardHeader,
	Col,
	Row,
	Modal,
	ModalBody,
	ModalHeader,
} from 'reactstrap';
import DatePicker from 'react-datepicker';
import 'react-datepicker/dist/react-datepicker.css';
import {
	ButtonExcel,
	ButtonProcess,
	CardTreePeriod,
	ContentHeader,
	DropdownDivisi,
} from '../../../Components';
import {
	pathAPIServer,
	pathReportDetail,
} from '../../../Constants';

class DailyAssessment extends Component {
	_isMounted = false;

	constructor(props) {
		super(props);
		this.handleStartChange = this.handleStartChange.bind(this);
		this.handleDivisiChange = this.handleDivisiChange.bind(this);
		this.handleExpandChange = this.handleExpandChange.bind(this);
		this.handleColumnsData = this.handleColumnsData.bind(this);
		this.handleFinishData = this.handleFinishData.bind(this);
		this.handleProcessClick = this.handleProcessClick.bind(this);
		this.toggle = this.toggle.bind(this);
		this.state = {
			dataUserID: 1,
			dataTitle: '',
			pathHelp: '',
			dataReportID: 84,
			dataReport: [],
			dataExcel: [],
			dataColumns: [],

			startDate: new Date(),
			endDate: new Date(),
			divisi: [],
			urldivisi: '',
			expand: [],
			modal: false,

			isLoading: false,
			error: null
		};
	}

	handleStartChange(startDate) {
		this.setState({ startDate: startDate, endDate: startDate});	
	}

	handleDivisiChange(checked) {
		this.setState({ divisi: checked });
	}

	handleExpandChange(expanded) {
		this.setState({ expand: expanded });
	}

	handleColumnsData(data) {
		this.setState({ dataColumns: data });
	}

	handleFinishData(data) {
		this.setState({ dataExcel: data });
	}

	handleProcessClick() {
		if (this.state.divisi.length === 0) {
			this.setState({ modal: !this.state.modal });
		} else {
			this.setState({ isLoading: true, isManual: true }, function() {
				this.componentDidMount();
				this.setState({ isLoading: false }, function() {
				});
			})
		}
	}

	toggle() {
		this.setState({ modal: !this.state.modal });
	}

	async componentDidMount() {
		this._isMounted = true;
		this.setState({ isLoading: true });

		const dataReportID = this.state.dataReportID

		let responseReport = await fetch(pathAPIServer + pathReportDetail + dataReportID);
		let dataReport = await responseReport.json();

		var urldivisi = '';

		if (this.state.divisi.length === 0) {
			urldivisi = encodeURIComponent('DUMMY');
		} else {
			urldivisi = encodeURIComponent(this.state.divisi);
		}

		if (this._isMounted) {
			this.setState({ urldivisi: urldivisi, dataReport: dataReport.recordset,
											dataTitle: dataReport.recordset[0].Report_Name, isLoading: false });
		}
	}

	componentWillUnmount() {
		this._isMounted = false;
	}

	render() {
		const { isLoading, error, dataUserID, dataReport, dataReportID, dataTitle, dataExcel, dataColumns,
						startDate, endDate, divisi, urldivisi } = this.state

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
								<DropdownDivisi
									divisi={divisi}
									onCheckedChange={this.handleDivisiChange}
									onExpandedChange={this.handleExpandChange}
								/>
								&emsp;
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
								<Modal isOpen={this.state.modal} toggle={this.toggle} className={'modal-danger modal-sm'}>
									<ModalHeader toggle={this.toggle}>Warning</ModalHeader>
									<ModalBody>
										Divisi can't be empty.
									</ModalBody>
								</Modal>
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
									divisi={urldivisi}
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

export default DailyAssessment;