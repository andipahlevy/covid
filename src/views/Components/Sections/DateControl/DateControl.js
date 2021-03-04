import React, { Component } from 'react';
// import {
// 	Row,
// } from 'reactstrap';
import DatePicker from 'react-datepicker';
import 'react-datepicker/dist/react-datepicker.css';
import {
	DropdownPeriod,
} from '../../../Components';

class DateControl extends Component {
	_isMounted = false;

	constructor(props) {
		super(props);
		this.handlePeriodChange = this.handlePeriodChange.bind(this);
		this.handleStartChange = this.handleStartChange.bind(this);
		this.handleEndChange = this.handleEndChange.bind(this);
		this.toggle = this.toggle.bind(this);
		this.state = {
			period: "",
			startDate: new Date(),
			endDate: new Date(),
			plant: ['KSP1','NSI1','PSU1','DWJ1','DWJ2','KUT1','ABL1','KWI1','TSS1','KJP1','KMP1','KPT1','KPK1','KPR1','NKP1','BAP1','KJP2'],
			modal: false,
			content: [],

			isLoading: false,
			error: null
		};
	}

	handlePeriodChange(period) {
		console.log(period)
		this.props.onPeriodChange(period,this.state.startDate,this.state.endDate)
	}

	handleStartChange(startDate) {
		this.props.onPeriodChange(this.state.period,startDate,this.state.endDate)
	}

	handleEndChange(endDate) {
		// this.setState({ endDate }, function() {
		// 	console.log("handleEndChange",this.state.period,this.state.startDate,this.state.endDate)
			this.props.onPeriodChange(this.state.period,this.state.startDate,endDate)
		// 	this.componentDidMount();
		// })
	}
	
	toggle() {
		this.setState({ modal: !this.state.modal });
	}

	async componentDidMount() {
		this._isMounted = true;
		this.setState({ isLoading: true });

		var d = new Date()
		console.log("componentDidMount", d.getSeconds(), d.getMilliseconds())

		if (this.state.period !== this.props.period ||
				this.state.startDate !== this.props.startDate ||
				this.state.endDate !== this.props.endDate) {
			console.log('restate')
			this.setState({ period: this.props.period, startDate: this.props.startDate, endDate: this.props.endDate })
		}

		if (this._isMounted) {
			this.setState({ isLoading: false });
		}
	}

	componentWillUnmount() {
		this._isMounted = false;
	}

	render() {
		const { isLoading, error } = this.state

		const { period, startDate, endDate } = this.state
		const { periodMode, viewMode } = this.props

		if (error) {
			return <p>{error.message}</p>;
		}

		if (isLoading) {
			return <p>Loading ...</p>;
		}

		let Content = []
		if (viewMode.match(/Period.*/)) {
			Content.push(
										<React.Fragment key={'ps'}>
											<DropdownPeriod
												key={'prd'}
												period={period}
												onPeriodChange={this.handlePeriodChange}
												periodMode={periodMode}
											/>
											&nbsp;
											&nbsp;
										</React.Fragment>
									)
		}

		if (viewMode.match(/Start.*/)) {
			Content.push(
										<React.Fragment key={'fs'}>
											<DatePicker
												key={'s'}
												selected={startDate}
												selectsStart
												startDate={startDate}
												endDate={endDate}
												onChange={this.handleStartChange}
												dateFormat="dd MMMM yyyy"
												//showMonthYearPicker
											/>
											&nbsp;
											-
											&nbsp;
										</React.Fragment>
									)
		}

		if (viewMode.match(/End.*/)) {
			Content.push(
										<React.Fragment key={'fe'}>
											<DatePicker
												key={'e'}
												selected={endDate}
												selectsEnd
												startDate={startDate}
												endDate={endDate}
												onChange={this.handleEndChange}
												dateFormat="dd MMMM yyyy"
												//showMonthYearPicker
											/>
										</React.Fragment>
									)
		}

		return (
			<div>
				{Content}
			</div>
		);
	}
}

export default DateControl;