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
			
			ba				: '',
			bagian			: '',
			name			: '',
			status			: '',
			start_date		: '',
			end_date		: '',
			duration		: 0,
			category		: '',
			reason			: '',
			condition		: '',
			condition_desc	: '',
			company_data	: []
		}
	}

	async componentDidMount() {
		fetch('http://localhost/covid-api/master/company.php')
        .then(response => response.json())
        .then(data => {
			if(data.code==200){
				this.setState({company_data: data.contents})
			}else{
				alert('Gagal get company');
			}
		});
	}

	componentWillUnmount() {
		this._isMounted = false;
	}
	
	handleStartDateChange = (e)=>{
		this.setState({start_date: e.target.value});
		this.setEndDate(e.target.value, this.state.duration)
	}
	
	handleDurationChange = (e)=>{
		this.setState({duration: e.target.value});
		this.setEndDate(this.state.start_date, e.target.value)
	}
	
	setEndDate = (a,b)=>{
		if(!a){
			return false
		}
		console.log('sd ',a,b)
		let date 	= new Date(a);
		let to 		= parseInt(date.getDate()) + (parseInt(b)-1)
		console.log(to)
		date.setDate(to);
		console.log(date)
		this.setState({end_date:this.formatDate(date)})
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
	
	handleBaChange = (e)=>{
		this.setState({ba:e.target.value})
	}	
	handleBagianChange = (e)=>{
		this.setState({bagian:e.target.value})
	}	
	handleNameChange = (e)=>{
		this.setState({name:e.target.value})
	}
	handleStatusChange = (e)=>{
		this.setState({status:e.target.value})
	}
	handleCategoryChange = (e)=>{
		this.setState({category:e.target.value})
	}
	handleReasonChange = (e)=>{
		this.setState({reason:e.target.value})
	}
	handleConditionChange = (e)=>{
		this.setState({condition:e.target.value})
	}
	handleConditionDescChange = (e)=>{
		this.setState({condition_desc:e.target.value})
	}
	
	save = ()=>{
		const requestOptions = {
			method: 'POST',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify(this.state)
		};
		fetch('http://localhost/covid-api/karantina/save.php', requestOptions)
			.then(response => response.json())
			.then(data => {
				if(data.code == 200){
					this.props.history.push('/karantina/outstanding');
				}else{
					alert(data.messages)
				}
				console.log(data)
			});
	}
	
	downloadRA = (e)=>{
		e.preventDefault();
      window.location.href=apiUri+'report/daily.php';
	}

	render() {
		

		return (<div className="app flex-row">
        <Container className="p-3">
          <Row className="justify-content-left">
            <Col md="12" lg="12" xl="12">
              <h3>Report Karantina</h3>
			  <br/>
			  <br/>
            </Col>
            <Col md="3" lg="3" xl="3">
              <Card className="text-black bg-default ">
                <CardBody className="p-4">
                  <h5 class="card-title">Daily Report</h5>
					<p class="card-text">Report karantina hari ini</p>
					<a href="#" onClick={this.downloadRA} class="btn btn-primary">Download</a>
                </CardBody>
              </Card>
            </Col>
            <Col md="3" lg="3" xl="3">
              <Card className="text-black bg-default ">
                <CardBody className="p-4">
                  <h5 class="card-title">Daily Summary Report</h5>
					<p class="card-text">Summary report hari ini</p>
					<a href="#" class="btn btn-primary disabled">Download</a>
                </CardBody>
              </Card>
            </Col>
            <Col md="3" lg="3" xl="3">
              <Card className="text-black bg-default ">
                <CardBody className="p-4">
                  <h5 class="card-title">Summary Report</h5>
					<p class="card-text">Summary report </p>
					<a href="#" class="btn btn-primary disabled">Download</a>
                </CardBody>
              </Card>
            </Col>
          </Row>
        </Container>
      </div>);
	}
}

export default DailyAssessmentInput;