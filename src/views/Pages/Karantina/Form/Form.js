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
import { LoadingOverlay, Loader } from 'react-overlay-loader';
 
import 'react-overlay-loader/styles.css';

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
			company_data	: [],
			isLoading	: false,
		}
	}

	async componentDidMount() {
		fetch(apiUri+'master/company.php')
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
		this.setState({isLoading:true})
		fetch(apiUri+'karantina/save.php', requestOptions)
			.then(response => response.json())
			.then(data => {
				if(data.code == 200){
					this.props.history.push('/karantina/outstanding');
				}else{
					alert(data.messages)
				}
				console.log(data)
				this.setState({isLoading:false})
			});
	}

	render() {
		

		return (<div className="app flex-row">
        <Container className="p-5">
          <Row className="justify-content-center">
            <Col md="12" lg="12" xl="12">
			<LoadingOverlay style={{  }}> 
              <Card className="text-black bg-default ">
                <CardBody className="p-4">
                  <Form onSubmit={this.handleSubmit}>
                    <h1>Input Karantina Baru</h1>
                    <p className="text-muted">Silahkan input data terbaru.</p>
                   
                    <FormGroup>
                      <Label htmlFor="ba">Nama PT</Label>
                      <Input type="select" value={this.state.ba} onChange={this.handleBaChange} name="ba" id="ba">
                        <option>-- Pilih --</option>
						{
							this.state.company_data.map((item,i)=>{
								return <option>{item.comp_name}</option>
							})
						}
                      </Input>
                    </FormGroup>
                    
                    <FormGroup>
                      <Label htmlFor="bagian">Bagian</Label>
                      <Input type="select" name="bagian" id="bagian" value={this.state.bagian} onChange={this.handleBagianChange}>
                        <option>-- Pilih --</option>
                        <option>ESTATE 1</option>
                        <option>ESTATE 2</option>
                        <option>ESTATE 3</option>
                        <option>MILL</option>
                        <option>BULKING</option>
                      </Input>
                    </FormGroup>
					
					<FormGroup>
                      <Label htmlFor="name">Nama</Label>
                      <Input type="text" name="name" id="name" placeholder="Nama" required  value={this.state.name} onChange={this.handleNameChange}/>
                    </FormGroup>
                    
                    <FormGroup>
                      <Label htmlFor="status">Status</Label>
                      <Input type="select" name="status" id="status" value={this.state.status} onChange={this.handleStatusChange}>
                        <option>-- Pilih --</option>
                        <option>Karyawan</option>
                        <option>Keluarga Karyawan</option>
                        <option>Karyawan Baru</option>
                        <option>Keluarga Karyawan Baru</option>
                      </Input>
                    </FormGroup>
					
					<FormGroup>
                      <Label htmlFor="start_date">Mulai Karantina</Label>
                      <Input type="date" name="start_date" value={this.state.start_date} onChange={(event)=>this.handleStartDateChange(event)} placeholder="" />
                    </FormGroup>
					
					<FormGroup>
                      <Label htmlFor="dur">Lama Karantina</Label>
                      <Input type="number" name="duration" id="dur" value={this.state.duration} onChange={this.handleDurationChange} min="0" placeholder="Lama Karantina" required />
                    </FormGroup>
					
					<FormGroup>
                      <Label htmlFor="end_date">Selesai Karantina</Label>
                      <Input type="date" name="end_date" id="end_date" placeholder="" required  value={this.state.end_date} readOnly />
                    </FormGroup>
                    
                    <FormGroup>
                      <Label htmlFor="category">Kategori Karantina</Label>
                      <Input type="select" name="category" id="category" value={this.state.category} onChange={this.handleCategoryChange}>
                        <option>-- Pilih --</option>
                        <option>Karantina Sehat</option>
                        <option>PDP</option>
                        <option>ODP</option>
                        <option>Positif Covid</option>
                      </Input>
                    </FormGroup>
                    
					<FormGroup>
						<Label htmlFor="reason">Alasan Diarantina</Label>
						<Input type="textarea" name="reason" id="reason" rows="3"
                             placeholder="Alasan..."  value={this.state.reason} onChange={this.handleReasonChange}/>
					</FormGroup>
                    
                    <FormGroup>
                      <Label htmlFor="condition">Kondisi Kesehatan</Label>
                      <Input type="select" name="condition" id="condition" value={this.state.condition} onChange={this.handleConditionChange}>
                        <option>-- Pilih --</option>
                        <option>Sehat</option>
                        <option>Sakit</option>
                      </Input>
                    </FormGroup>
                    
                    <FormGroup>
                      <Label htmlFor="condition_desc">Jika sakit, keterangan</Label>
                      <Input type="textarea" name="condition_desc" id="condition_desc" rows="3"
                             placeholder="Alasan..."  value={this.state.condition_desc} onChange={this.handleConditionDescChange}/>
                    </FormGroup>
					
					<Row>
                      <Col xs="6">
                        <Button onClick={this.save} color="success" active>{this.state.isLoading?'Menyimpan...':'Simpan'}</Button>
						<Link to="/karantina/outstanding">
							<Button color="default" active>Batal</Button>
						</Link>
                      </Col>
                      
                    </Row>
                  </Form>
                </CardBody>
              </Card>
				<Loader loading={this.state.isLoading}/>
			  </LoadingOverlay>
			</Col>
          </Row>
        </Container>
      </div>);
	}
}

export default DailyAssessmentInput;