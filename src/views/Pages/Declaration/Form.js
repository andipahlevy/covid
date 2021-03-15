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
  FormGroup,
  Label,
  Row
} from 'reactstrap';
import { apiUri } from '../../Constants';
import $ from "jquery"

function sysdate() {
	var d = new Date(),
		month = '' + (d.getMonth() + 1),
		day = '' + d.getDate(),
		year = d.getFullYear();

	if (month.length < 2) 
		month = '0' + month;
	if (day.length < 2) 
		day = '0' + day;

	return [year, month, day].join('-');
}

class Declare extends Component {
	constructor(props) {
		super(props);
		this.state = {
			name: '',
			nik: '',
			declaration_date: sysdate(),
			location: '',
			temperature: '',
			ques: [],
			score: 0,
			isLoading	: false,
		};
		this.handleNameChange = this.handleNameChange.bind(this);
		this.handleNikChange = this.handleNikChange.bind(this);
		this.handleLocationChange = this.handleLocationChange.bind(this);
		this.handleTemperatureChange = this.handleTemperatureChange.bind(this);
	}
	
	async componentDidMount() {
		this.setState({isLoading:true})
		fetch(apiUri+'declaration/getQuestions.php')
        .then(response => response.json())
        .then(data => {
			if(data.code==200){
				this.setState({ques: data.contents},()=>{
					console.log($("form").serializeArray())
				})
				
			}else{
				alert('Gagal get region');
			}
			this.setState({isLoading:false})
		});
	}
	
	handleNameChange = (e)=>{
		this.setState({name:e.target.value.toUpperCase()})
	}
	
	handleNikChange = (e)=>{
		this.setState({nik:e.target.value.toUpperCase()})
	}
	
	handleLocationChange = (e)=>{
		this.setState({location:e.target.value.toUpperCase()})
	}
	
	handleTemperatureChange = (e)=>{
		this.setState({temperature:e.target.value.toUpperCase()})
	}
	
	handleFillAnswer = (e, i )=>{
		let st = [...this.state.ques]
		let item = st[i]
		item.answer = e.target.value
		st[i] = item
		this.setState({ques: st})
	}
	
	handleSubmit = (event)=>{
		event.preventDefault();
		const requestOptions = {
			method: 'POST',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify(this.state)
		};
		this.setState({isLoading:true})
		fetch(apiUri+'declaration/save.php', requestOptions)
			.then(response => response.json())
			.then(data => {
				if(data.code == 200){
					this.props.history.push({
					  pathname: '/done',
					  state: {
						score: data.score,
						name: this.state.name
					  }
					});
				}else{
					alert(data.messages)
				}
				console.log(data)
				this.setState({isLoading:false})
			});
	}

	render() {
			return (
				<div className="app flex-row">
				<Container className="p-5">
				 <Form onSubmit={this.handleSubmit}>
				  <Row className="justify-content-center">
					<Col md="7" lg="7" xl="7">
					<div id="cover-spin" style={{ display: this.state.isLoading ? 'block' : 'none' }}></div>
					<Card className="text-black bg-default ">
						<CardBody className="p-4">
							<h2>Semangat Pagi Insan TAP</h2>
							<br/>
							<p className="text-muted">Di tengah merebaknya virus COVID19 (Novel Coronavirus), maka manajemen perlu mengetahui lebih lanjut kondisi dari setiap karyawan HO (Head Office) yang memiliki keluhan ataupun masalah kesehatan pada hari ini atau dalam 1 minggu terakhir ini.
		Langkah ini dilakukan sebagai  wujud kepedulian serta tindakan pencegahan dan solusi agar seluruh karyawan TAP Group selalu dalam keadaan sehat dan tetap dapat beraktivitas seperti biasa.</p>

							<p className="text-muted">Salam, <br/>
		Manajemen Triputra Agro Persada</p>
							<p className="text-muted">Kami Berkomitmen untuk Memastikan Setiap Karyawan dalam Kondisi Sehat dan Siap Bekerja</p>
							
							<p style={{color:'red'}}>* Required</p>
						</CardBody>
					  </Card>
					  
					<Card className="text-black bg-default ">
						<CardBody className="p-4">
							<FormGroup>
							  <Label htmlFor="region">Nama <span style={{ color:'red' }}>*</span></Label>
							  <Input type="text" name="name" id="name" placeholder="Your answer" required value={this.state.value} onChange={this.handleNameChange}/>
							</FormGroup>								
						</CardBody>
					</Card>
					<Card className="text-black bg-default ">
						<CardBody className="p-4">
							<FormGroup>
							  <Label htmlFor="region">NIK <span style={{ color:'red' }}>*</span></Label>
							  <Input type="number" name="nik" id="nik" placeholder="Your answer" required  value={this.state.value} onChange={this.handleNikChange}/>
							</FormGroup>								
						</CardBody>
					</Card>
					<Card className="text-black bg-default ">
						<CardBody className="p-4">
							<FormGroup>
							  <Label htmlFor="region">Tanggal Declare <span style={{ color:'red' }}>*</span></Label>
							  <Input type="date" name="declaration_date" id="declaration_date" placeholder="Date" value={this.state.declaration_date} required readOnly/>
							</FormGroup>								
						</CardBody>
					</Card>
					<Card className="text-black bg-default ">
						<CardBody className="p-4">
							<FormGroup>
								<Label htmlFor="region">Lokasi kerja saat ini <span style={{ color:'red' }}>*</span></Label>
								<FormGroup check className="radio">
									<Input  value={this.state.value} onChange={this.handleLocationChange} required className="form-check-input" type="radio" id="location1" name="location" value="wfh" />
									<Label check className="form-check-label" htmlFor="location1">WFH</Label>
								</FormGroup>
								<FormGroup check className="radio">
									<Input value={this.state.value} onChange={this.handleLocationChange} required className="form-check-input" type="radio" id="location2" name="location" value="wfo" />
									<Label check className="form-check-label" htmlFor="location2">WFO</Label>
								</FormGroup>
							</FormGroup>								
						</CardBody>
					</Card>
					<Card className="text-black bg-default ">
						<CardBody className="p-4">
							<FormGroup>
							  <Label htmlFor="region">Berapa suhu tubuh anda saat ini <span style={{ color:'red' }}>*</span></Label>
							  <Input type="number" name="temperature" id="temperature" placeholder="Your answer" required  value={this.state.value} onChange={this.handleTemperatureChange}/>
							</FormGroup>								
						</CardBody>
					</Card>
					
					{this.state.ques.map((item, index) => (
						<Card className="text-black bg-default " key={index}>
							<CardBody className="p-4">
								<FormGroup>
								  <Label htmlFor="region">{ item.label } <span style={{ color:'red' }}>*</span></Label>
								{item.type == 'text' ? <Input onChange={(event)=>this.handleFillAnswer(event, index)} type="text" name="name" id="name" placeholder="Your answer" required />
								  : item.type == 'radio' ? (
									<FormGroup>
										<FormGroup check className="radio">
											<Input required onChange={(event)=>this.handleFillAnswer(event, index)} className="form-check-input" type="radio" id={item.id+'_answer1'} name={item.id+'_answer'} value="ya" />
											<Label check className="form-check-label" htmlFor={item.id+'_answer1'}>Ya</Label>
										</FormGroup>
										<FormGroup check className="radio">
											<Input required onChange={(event)=>this.handleFillAnswer(event, index)} className="form-check-input" type="radio" id={item.id+'_answer2'} name={item.id+'_answer'} value="tidak" />
											<Label check className="form-check-label" htmlFor={item.id+'_answer2'}>Tidak</Label>
										</FormGroup>
									</FormGroup>
								  )
								  : "error, please contact admin"}
								  
								</FormGroup>								
							</CardBody>
						</Card>
					))}
					
					
					<Row>
					  <Col xs="6">
						<Button onClick={this.save} color="success" active>{this.state.isLoading?'Menyimpan...':'Simpan'}</Button>
					  </Col>
					  
					</Row>
						
					</Col>
				  </Row>
				 </Form>
				</Container>
			  </div>
			);
	  }
}

export default Declare;
