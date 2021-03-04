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
// import { Bar, Doughnut, Line, Pie, Polar, Radar } from 'react-chartjs-2';
import { Doughnut } from 'react-chartjs-2';
// import ChartDataLabels from 'chartjs-plugin-datalabels';
import 'chartjs-plugin-datalabels';
import {
	CardTreePeriodDoughnut,
	ContentHeader,
	ButtonExcel,
	ButtonProcess,
} from '../../../Components';
import {
	pathAPIServer,
	pathReportDetail,
} from '../../../Constants';

class DailyAssessmentInput extends Component {
	_isMounted = false;

	constructor(props) {
		super(props);
		this.handleStartChange = this.handleStartChange.bind(this);
		this.handleColumnsData = this.handleColumnsData.bind(this);
		this.handleFinishData = this.handleFinishData.bind(this);
		this.handleChartData = this.handleChartData.bind(this);
		this.handleProcessClick = this.handleProcessClick.bind(this);
		this.state = {
			dataUserID: 1,
			dataTitle: '',
			pathHelp: '',
			dataReportID: 90,
			dataReport: [],
			dataExcel: [],
			dataColumns: [],
			dataChart: [],
			dataLabel: [],

			startDate: new Date(),
			endDate: new Date(),

			isLoading: false,
			error: null
		};
	}

	handleStartChange(startDate) {
		this.setState({ startDate: startDate, endDate: startDate });
	}

	handleColumnsData(data) {
		this.setState({ dataColumns: data });
	}

	handleFinishData(data) {
		this.setState({ dataExcel: data });
	}

	handleChartData(data) {
		var ArrChart = []
		var ArrLabel = []
		for (var i = 0, n = data.length; i < n; i++) {
				var s = data[i].CountLabel + ' (' + data[i].Percentage + '%)';
				var t = data[i].Percentage;
				ArrChart.push(t)
				ArrLabel.push(s)
		}

		this.setState({ dataChart: ArrChart, dataLabel: ArrLabel });
	}

	handleProcessClick(divisi) {
		this.setState({ isLoading: true }, function() {
			this.componentDidMount();
			this.setState({ isLoading: false }, function() {
			});
		})
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

		if (this._isMounted) {
			this.setState({ dataReport: dataReport.recordset, dataTitle: dataReport.recordset[0].Report_Name, isLoading: false });
		}
	}

	componentWillUnmount() {
		this._isMounted = false;
	}

	render() {
		const { isLoading, error, dataUserID, dataReport, dataReportID, dataTitle, dataExcel, dataColumns, dataChart, dataLabel,
						startDate, endDate } = this.state

		const data = {
			labels: dataLabel,
			datasets: [{
				backgroundColor: [
					'green',
					'red',
					'yellow',
				],
				data: dataChart,
			}],
		};

		const options = {
			maintainAspectRatio: false,
			tooltips: {
				callbacks: {
					label: function(tooltipItem, data) {
						// var dataset = data.datasets[tooltipItem.datasetIndex];
						// var value = dataset.data[tooltipItem.index];
						var datas = dataLabel[tooltipItem.index];
						// return datas+": "+ value + "%";
						return datas;
					}
				}
			},
			legend: {
				display: true,
				labels: {
					fontStyle: 'bold'
				},
				// position: 'right'
			},
			plugins: {
				datalabels: {
					display: false,
					// anchor: function(context) {
					// 	var index = context.dataIndex;
					// 	var value = index % 2;
					// 	return value === 1 ? 'end' : 'start'
					// },
					// backgroundColor: function(context) {
					// 	return context.dataset.backgroundColor;
					// },
					// borderColor: 'white',
					// borderRadius: 40,
					// borderWidth: 2,
					// color: 'white',
					// font: {
					// 	weight: 'bold'
					// },
					// formatter: (value) => {
					// 	let percentage = value+"%";
					// 	return percentage;
					// },
				}
			}
		}

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
					<Col xs="5">
						<Card>
							<CardBody>
								<div className="chart-wrapper">
									<Doughnut data={data} options={options} height={240}/>
								</div>
							</CardBody>
						</Card>
					</Col>
					<Col xs="7">

						{
							dataReport.map((item, i) =>
								<CardTreePeriodDoughnut
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
									forChart={this.handleChartData}
								/>
							)
						}

					</Col>
				</Row>

			</div>
		);
	}
}

export default DailyAssessmentInput;