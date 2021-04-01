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
	ButtonProcess,
} from '../../Components';
import {
	apiUri
} from '../../Constants';

class FormClass extends Component {
	_isMounted = false;

	constructor(props) {
		super(props);
		if(!localStorage.getItem('login')){
			this.props.history.push('/login');
		}
		this.state = {
			isLoading	: false,
			division_data	: [],
			division	: '',
			name	: '',
			nik	: '',
			location	: 'HEAD OFFICE',			
			base_url: apiUri,
		}
	}

	async componentDidMount() {
		this.setState({isLoading:true})
		fetch(apiUri+'master/division.php')
        .then(response => response.json())
        .then(data => {
			if(data.code==200){
				this.setState({division_data: data.contents})
			}else{
				alert('Gagal get region');
			}
			this.setState({isLoading:false})
		})
		.catch((error) => {
			console.log(error)
			alert('Gagal mengambil data. Mohon cek koneksi anda atau tunggu beberapa saat')
			this.setState({isLoading:false})
		});
	}

	componentWillUnmount() {
		this._isMounted = false;
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
	
	handleDivisionChange = (e)=>{
		this.setState({division:e.target.value})
	}
	handleNameChange = (e)=>{
		this.setState({name:e.target.value.toUpperCase()})
	}
	handleNikChange = (e)=>{
		this.setState({nik:e.target.value})
	}
	handleLocationChange = (e)=>{
		this.setState({gender:e.target.value})
	}
	
	handleSubmit = (event)=>{
		
		event.preventDefault();
		const requestOptions = {
			method: 'POST',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify(this.state)
		};
		this.setState({isLoading:true})
		fetch(apiUri+'employee/save.php', requestOptions)
			.then(response => response.json())
			.then(data => {
				if(data.code == 200){
					this.props.history.push('/employee/grid');
				}else{
					alert(data.messages)
				}
				console.log(data)
				this.setState({isLoading:false})
			})
			.catch((error) => {
				console.log(error)
				alert('Gagal menyimpan. Mohon periksa kembali form inputan')
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
                    <h1>Input Pegawai Baru</h1>
                    <p className="text-muted">Silahkan isi semua field pada form berikut.</p>
                   
                    <FormGroup>
                      <Label htmlFor="division">Divisi</Label>
                      <Input type="select" value={this.state.division} onChange={this.handleDivisionChange} name="region" id="region">
                        <option>-- Pilih --</option>
						{
							this.state.division_data.map((item,i)=>{
								return <option>{item.division_name}</option>
							})
						}
                      </Input>
                    </FormGroup>
					
					<FormGroup>
                      <Label htmlFor="nik">NIK Pegawai</Label>
                      <Input type="text" name="nik" id="nik" placeholder="Nik" required  value={this.state.nik} onChange={this.handleNikChange}/>
                    </FormGroup>
					
					<FormGroup>
                      <Label htmlFor="name">Nama</Label>
                      <Input type="text" name="name" id="name" placeholder="Nama" required  value={this.state.name} onChange={this.handleNameChange}/>
                    </FormGroup>
                    
					
					<FormGroup>
                      <Label htmlFor="location">Location</Label>
                      <Input type="text" name="location" id="location" value={this.state.location} readOnly onChange={this.handleLocationChange} placeholder="Lokasi" required />
                    </FormGroup>
					
					
					<Row>
                      <Col xs="6">
                        <Button onClick={this.save} color="success" active>{this.state.isLoading?'Menyimpan...':'Simpan'}</Button>
						<Link to="/employee/grid">
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

export default FormClass;