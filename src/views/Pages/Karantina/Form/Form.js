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
			// this.props.history.push('/login');
		}
		this.state = {
			
			region			: '',
			ba				: '',
			bagian			: '',
			name			: '',
			status			: '',
			location		: '',
			start_date		: '',
			end_date		: '',
			duration		: 1,
			category		: '',
			reason			: '',
			condition		: '',
			condition_desc	: '',
			company_data	: [],
			region_data		: [],
			isLoading	: false,
			displayConditionDesc	: 'none',
			pilNonHO : ['ESTATE 1','ESTATE 2','ESTATE 2','MILL','BULKING','KARET'],
			pilHO : ['HEAD OFFICE'],
			pilBagian: []
		}
	}

	async componentDidMount() {
		this.setState({isLoading:true})
		fetch(apiUri+'master/region.php')
        .then(response => response.json())
        .then(data => {
			if(data.code==200){
				this.setState({region_data: data.contents})
			}else{
				alert('Gagal get region');
			}
			this.setState({isLoading:false})
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
		let to 		= parseInt(date.getDate()) + (parseInt(b))
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
	
	handleRegionChange = (e)=>{
		let dis = this
		let val = e.target.value
		this.setState({isLoading:true})
		this.setState({region:e.target.value},()=>{
			fetch(apiUri+'master/company.php?region='+val)
				.then(response => response.json())
				.then(data => {
					if(data.code==200){
						dis.setState({company_data: data.contents})
					}else{
						alert('Gagal get company');
					}
					this.setState({isLoading:false})
				});
		})
	}	
	
	handleBaChange = (e)=>{
		let dis = this
		let val = e.target.value
		this.setState({ba:e.target.value}, ()=>{
			if(val != 'HEAD OFFICE'){
				dis.setState({pilBagian:dis.state.pilNonHO})
			}else{
				dis.setState({pilBagian:dis.state.pilHO})
			}
		})
	}	
	handleBagianChange = (e)=>{
		this.setState({bagian:e.target.value})
	}	
	handleNameChange = (e)=>{
		this.setState({name:e.target.value.toUpperCase()})
	}
	handleLocationChange = (e)=>{
		this.setState({location:e.target.value})
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
		let val = e.target.value
		let dis = this
		this.setState({condition:e.target.value}, ()=>{
			if(val =='Sakit'){
				dis.setState({displayConditionDesc:'block'})
			}else{
				dis.setState({displayConditionDesc:'none'})
			}
		})
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
			<div id="cover-spin" style={{ display: this.state.isLoading ? 'block' : 'none' }}></div>
			<Card className="text-black bg-default ">
                <CardBody className="p-4">
                  <Form onSubmit={this.handleSubmit}>
                    <h1>Input Karantina Baru</h1>
                    <p className="text-muted">Silahkan isi semua field pada form berikut.</p>
                   
                    <FormGroup>
                      <Label htmlFor="region">Region</Label>
                      <Input type="select" value={this.state.region} onChange={this.handleRegionChange} name="region" id="region">
                        <option>-- Pilih --</option>
						{
							this.state.region_data.map((item,i)=>{
								return <option>{item.region_name}</option>
							})
						}
                      </Input>
                    </FormGroup>
					
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
						{
							this.state.pilBagian.map((item,i)=>{
								return <option>{item}</option>
							})
						}
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
                        <option>Calon Karyawan</option>
                        <option>Keluarga Calon Karyawan</option>
                      </Input>
                    </FormGroup>
                    
                    <FormGroup>
                      <Label htmlFor="location">Lokasi Karantina</Label>
                      <Input type="select" name="location" id="location" value={this.state.location} onChange={this.handleLocationChange}>
                        <option>-- Pilih --</option>
                        <option>Dalam Kebun</option>
                        <option>Luar Kebun</option>
                      </Input>
                    </FormGroup>
					
					<FormGroup>
                      <Label htmlFor="start_date">Mulai Karantina</Label>
                      <Input type="date" name="start_date" value={this.state.start_date} onChange={(event)=>this.handleStartDateChange(event)} placeholder="" />
                    </FormGroup>
					
					<FormGroup>
                      <Label htmlFor="dur">Lama Karantina</Label>
                      <Input type="number" name="duration" id="dur" value={this.state.duration} onChange={this.handleDurationChange} min="1" placeholder="Lama Karantina" required />
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
						<Label htmlFor="reason">Alasan Dikarantina</Label>
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
                    
                    <FormGroup style={{display:this.state.displayConditionDesc}}>
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
				
			</Col>
          </Row>
        </Container>
      </div>);
	}
}

export default DailyAssessmentInput;