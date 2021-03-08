import React, { Component } from 'react';
import { Link } from 'react-router-dom';
import {
	Alert,
  Button,
  Card,
  CardBody,
  Col,
  Container,
  Form,
  Input,
  InputGroup,
  InputGroupAddon,
  InputGroupText,
  Modal,
  ModalBody,
  ModalFooter,
  ModalHeader,
  Row,
  FormGroup,
  Label,
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
	apiUri
} from '../../../Constants';

class DailyAssessmentInput extends Component {
	_isMounted = false;

	constructor(props) {
		super(props);
		if(!localStorage.getItem('login')){
			this.props.history.push('/login');
		}
		this.state = {
			start_date		: '',
			end_date		: '',
			start_month		: '',
			end_month		: '',
		}
	}

	async componentDidMount() {
		
	}

	componentWillUnmount() {
		this._isMounted = false;
	}
	
	startDateChange = (e)=>{
		this.setState({start_date: e.target.value});
	}
	
	endDateChange = (e)=>{
		this.setState({end_date: e.target.value});
	}
	
	startMonthChange = (e)=>{
		this.setState({start_month: e.target.value});
	}
	
	endMonthChange = (e)=>{
		this.setState({end_month: e.target.value});
	}
	
	formatDate(date) {
		var d = new Date(date),
			month = '' + (d.getMonth() + 1),
			day = '' + d.getDate(),
			year = d.getFullYear();

		if (month.length < 2) 
			month = '0' + month;
		if (day.length < 2) 
			day = '0' + day;

		return [year, month, day].join('-');
	}
	
	
	
	downloadRA = (e)=>{
		e.preventDefault();
		window.location.href=apiUri+'report/daily.php';
	}
	
	downloadRB = (e)=>{
		e.preventDefault();
		if(!this.state.start_date || !this.state.end_date){
			alert('Pilih range periode terlebih dahulu');
		}else{
			window.location.href=apiUri+'report/daily_summary.php?start_date='+this.state.start_date+'&end_date='+this.state.end_date;	
		}
	}
	
	downloadRC = (e)=>{
		e.preventDefault();
		if(!this.state.start_month || !this.state.end_month){
			alert('Pilih range periode terlebih dahulu');
		}else{
			window.location.href=apiUri+'report/summary.php?start_month='+this.state.start_month+'&end_month='+this.state.end_month;	
		}
	}

	render() {
		

		return (<div className="app flex-row">
        <Container className="p-3">
          <Row className="justify-content-left">
            <Col md="12" lg="12" xl="12">
              <h3>Karantina Report</h3>
			  <br/>
			  <br/>
            </Col>
            <Col md="4" lg="4" xl="4">
              <Card className="text-black bg-default ">
                <CardBody className="p-4">
                  <h5 class="card-title">Daily Report</h5>
					<p class="card-text">Report karantina hari ini</p>
					<a href="#" onClick={this.downloadRA} class="btn btn-primary">Download</a>
                </CardBody>
              </Card>
            </Col>
            <Col md="8" lg="8" xl="8">
              <Card className="text-black bg-default ">
                <CardBody className="p-4">
                  <h5 class="card-title">Daily Summary Report</h5>
					<p class="card-text">Summary report</p>
					
					<InputGroup>
						<Input type="date" value={this.state.start_date} onChange={this.startDateChange} />
						<InputGroupAddon addonType="prepend"><InputGroupText>-</InputGroupText></InputGroupAddon>
						<Input type="date" value={this.state.end_date} onChange={this.endDateChange} />
						<InputGroupAddon addonType="prepend">
							<button className="btn btn-primary" onClick={this.downloadRB}>Download</button>
						</InputGroupAddon>
                    </InputGroup>
					
                </CardBody>
              </Card>
            </Col>
            <Col md="12" lg="12" xl="12">
              <Card className="text-black bg-default ">
                <CardBody className="p-4">
                  <h5 class="card-title">Summary Report</h5>
					<p class="card-text">Summary report </p>
					
					<InputGroup>
						<Input type="month" value={this.state.start_month} onChange={this.startMonthChange} />
						<InputGroupAddon addonType="prepend"><InputGroupText>-</InputGroupText></InputGroupAddon>
						<Input type="month" value={this.state.end_month} onChange={this.endMonthChange} />
						<InputGroupAddon addonType="prepend">
							<button className="btn btn-primary" onClick={this.downloadRC}>Download</button>
						</InputGroupAddon>
                    </InputGroup>
                </CardBody>
              </Card>
            </Col>
          </Row>
        </Container>
      </div>);
	}
}

export default DailyAssessmentInput;