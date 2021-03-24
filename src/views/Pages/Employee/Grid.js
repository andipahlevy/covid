import React, { Component } from 'react';
import ReactDOM from 'react-dom'
import { Link } from 'react-router-dom';
import { Form, Button, Input, Badge, Card, Container, CardBody, CardHeader, Col, Pagination, PaginationItem, PaginationLink, Row, Table,
Modal,
  ModalBody,
  ModalFooter,
  ModalHeader,
  FormGroup,
  Label, } from 'reactstrap';
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

import $ from "jquery"
$.DataTable = require('datatables.net');

class Employee extends Component {
	_isMounted = false;

	constructor(props) {
		super(props);
		if(!localStorage.getItem('login')){
			this.props.history.push('/login');
		}
		this.state = {
			grid: [],
			modalo: false,
			isLoading: false,
			gridHeight: 'auto',
			
			division_data	: [],
			division	: '',
			name	: '',
			nik	: '',
			location	: 'HEAD OFFICE',
			updateTarget	: null,
		};
	}
	
	toggle = ()=> {
		this.setState({
		  modalo: !this.state.modalo,
		});
	  }
	
	toggle2 = ()=> {
		this.setState({
		  modalConfirm: !this.state.modalConfirm,
		});
	  }

	async componentDidMount() {
		this.fetchData()
		console.log('ReactDOM.findDOMNode(this.refs.cobaaja)')
		console.log(ReactDOM.findDOMNode(this.refs.cobaaja))
		$('.table-responsive').css('height',(window.innerHeight - 220)+'px')
		
		// const script = document.createElement("link");
		// script.href = "assets/css/jquery.dataTables.min.css";
		// script.rel = "stylesheet";
		// document.body.appendChild(script);
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
			body: JSON.stringify({
				name: this.state.name,
				nik: this.state.nik,
				division: this.state.division,
				location: this.state.location,
			})
		};
		this.setState({isLoading:true})
		fetch(apiUri+'employee/update.php', requestOptions)
			.then(response => response.json())
			.then(data => {
				if(data.code == 200){
					alert('Sukses mengubah data');
					this.toggle()
					
					let st = [...this.state.grid]
					let item = st[this.state.updateTarget]
					item.label = this.state.name
					item.div = this.state.division
					st[this.state.updateTarget] = item
					this.setState({grid: st})
					
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
	
	render_datatables(){
		let table =  $('.table-employee').DataTable({
							fixedHeader: true,
							"lengthChange": false,
							"paging":   false,
							"ordering": false,
							"info":     false
						});
		$('.table-employee thead tr').clone(true).appendTo( '.table-employee thead' );
		$('.table-employee thead tr:eq(1) th').each( function (i) {
			var title = $(this).text();
			if(title !="Aksi"){
				$(this).html( '<input type="text" class ="form-control tfsearch" placeholder="Search" />' );
		
				$( 'input', this ).on( 'click change', function (event) {
						if ( table.column(i).search() !== this.value ) {
							table
								.column(i)
								.search( this.value )
								.draw();
						}
				} );
			}
			else{
				$(this).html( '<div style="width: auto;"></div>' );
			}
		} );
	}
	
	fetchData = ()=>{
		this.setState({isLoading:true})
		fetch(apiUri+'declaration/getEmployees.php')
        .then(response => response.json())
        .then(data => {
			this.setState({grid: data},function(){
				this.render_datatables()
			})
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
	
	modify = (e,i)=>{
		if(this.state.division_data.length < 1){
			this.setState({isLoading:true, updateTarget: i})
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
		this.setState({division: this.state.grid[i].div, name:this.state.grid[i].label, nik:this.state.grid[i].nik},this.toggle())
	}
	
	delete = (e,i)=>{
		let dis = this
		let del = window.confirm('Apakah anda akan menghapus data karyawan dengan nik '+this.state.grid[i].nik+' ?')
		if(del){
			this.setState({isLoading:true})
			fetch(apiUri+'employee/delete.php?nik='+this.state.grid[i].nik)
			.then(response => response.json())
			.then(data => {
				if(data.code==200){
					$('#trid-'+i).remove()
					alert('Berhasil menghapus data');	
				}else{
					alert('Proses hapus gagal');
				}
				this.setState({isLoading:false})
			})
			.catch((error) => {
				console.log(error)
				alert('Gagal memproses data')
				this.setState({isLoading:false})
			});	
		}
		
	}

	render() {
		return (<div className="app flex-row" ref="cobaaja">
		
        <Container className="p-3">
          <Row className="justify-content-center">
            <Col md="12" lg="12" xl="12">
              <Card>
              <CardHeader>
				<Link to="/employee/form">
					<Button color="success" active><i className="fa fa-plus"></i> Tambah Data Pegawai</Button>
                </Link>
              </CardHeader>
              <CardBody>
			  <div id="cover-spin" style={{ display: this.state.isLoading ? 'block' : 'none' }}></div>
			  
				<h3>Data Pegawai</h3>
                <Table className="table-employee text-nowrap" responsive>
                  <thead>
                  <tr>
                    <th>NIK</th>
                    <th>Nama</th>
                    <th>Lokasi</th>
                    <th>Divisi</th>
                    <th>Aksi</th>
                  </tr>
                  </thead>
                  <tbody>
                  {
					  this.state.grid.map((item, i)=>
						<tr key={i} {...{ "id": "trid-"+i }}>
							<td>{item.nik}</td>
							<td>{item.label}</td>
							<td>{item.location}</td>
							<td>{item.div}</td>
							<td>
								<Button onClick={(e)=>this.modify(e,i)} color="success" className="btn-sm" active title="Edit"><i className="fa fa-edit"></i></Button>
								<Button style={{ marginLeft:'5px' }} onClick={(e)=>this.delete(e,i)} color="danger" className="btn-sm" active title="Hapus"><i className="fa fa-trash"></i></Button>
							</td>
						</tr>
					  )
				  }
                  </tbody>
                </Table>
				
				<Modal isOpen={this.state.modalo} toggle={this.toggle}
				  className={'modal-success ' + this.props.className}>
					<ModalHeader toggle={this.toggle}>Edit Data</ModalHeader>
					<ModalBody>
						<Form onSubmit={this.handleSubmit}>
							<h1>Edit Data</h1>
							<p className="text-muted">Silahkan isi semua field pada form berikut.</p>
							
							<FormGroup>
							  <Label htmlFor="nik">NIK Pegawai</Label>
							  <Input type="text" readOnly name="nik" id="nik" placeholder="Nik" required  value={this.state.nik} onChange={this.handleNikChange}/>
							</FormGroup>
							
							<FormGroup>
							  <Label htmlFor="name">Nama</Label>
							  <Input type="text" name="name" id="name" placeholder="Nama" required  value={this.state.name} onChange={this.handleNameChange}/>
							</FormGroup>
							
						   
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
							  <Label htmlFor="location">Location</Label>
							  <Input type="text" name="location" id="location" value={this.state.location} readOnly onChange={this.handleLocationChange} placeholder="Lokasi" required />
							</FormGroup>
							
							
							<Row>
								<Col xs="6">
									<Button onClick={this.save} color="success" active>{this.state.isLoading?'Menyimpan...':'Simpan'}</Button>
								</Col>
							</Row>
						  </Form>
					</ModalBody>
					<ModalFooter>
					  <Button color="warning" onClick={this.toggle}>Tutup</Button>
					</ModalFooter>
				  </Modal>
						  
              </CardBody>
            </Card>
            </Col>
          </Row>
		  
  
        </Container>
      </div>)

		
	}
}

export default Employee;