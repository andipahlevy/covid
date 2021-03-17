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
} from '../../Components';
import {
	apiUri
} from '../../Constants';

class DailyAssessmentInput extends Component {
	_isMounted = false;

	constructor(props) {
		super(props);
		if(!localStorage.getItem('login')){
			// this.props.history.push('/login');
		}
		this.state = {
			date		: '',
		}
	}

	async componentDidMount() {
		
	}

	componentWillUnmount() {
		this._isMounted = false;
	}
	
	dateChange = (e)=>{
		this.setState({date: e.target.value});
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
		window.location.href=apiUri+'report/selfDeclare.php';
	}
	
	render() {
		

		return (<div className="app flex-row">
        <Container className="p-3">
          <Row className="justify-content-left">
            <Col md="12" lg="12" xl="12">
              <h3>Self Declaration Report</h3>
			  <br/>
			  <br/>
            </Col>
            <Col md="8" lg="8" xl="8">
              <Card className="text-black bg-default ">
                <CardBody className="p-4">
                  <h5 class="card-title">Daily Report</h5>
					<p class="card-text">Download</p>
					
					<InputGroup>
						<Input type="date" value={this.state.date} onChange={this.dateChange} />
						<InputGroupAddon addonType="prepend">
							<button className="btn btn-primary" onClick={this.downloadRA}>Download</button>
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