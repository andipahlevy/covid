import React, { Component } from 'react';
import ReactDOM from 'react-dom'
import { Link } from 'react-router-dom';
import { Button, Input, Badge, Card, Container, CardBody, CardHeader, Col, Pagination, PaginationItem, PaginationLink, Row, Table,
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
} from '../../../Components';
import {
	apiUri
} from '../../../Constants';

import $ from "jquery"

class Outstanding extends Component {
	_isMounted = false;

	constructor(props) {
		super(props);
		if(!localStorage.getItem('login')){
			// this.props.history.push('/login');
		}
		this.state = {
			grid: [],
			willUpdate: [],
			descs: [],
			edited: 0,
			modalo: false,
			modalConfirm: false,
			detail: [],
			isLoading: false,
			detailName: '',
			detailEndDate: '',
			gridHeight: 'auto',
			akanSelesaiKarantina: [],
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
	  
	viewDetail = (e,i)=>{
		this.setState({detail: [], detailName:'', detailEndDate:''},this.toggle())
		let dis = this
		fetch(apiUri+'karantina/detail.php?id='+this.state.grid[i].id)
        .then(response => response.json())
        .then(data => {
			if(data.code==200){
				this.setState({detail: data.contents, detailName:dis.state.grid[i].name, detailEndDate:dis.state.grid[i].end_date})
			}
		});
	}

	async componentDidMount() {
		this.fetchData()
		console.log('ReactDOM.findDOMNode(this.refs.cobaaja)')
		console.log(ReactDOM.findDOMNode(this.refs.cobaaja))
		$('.table-responsive').css('height',(window.innerHeight - 200)+'px')
	}
	
	fetchData = ()=>{
		this.setState({isLoading:true})
		fetch(apiUri+'karantina/get.php')
        .then(response => response.json())
        .then(data => {
			if(data.code==200){
				this.setState({grid: data.contents})
			}
			this.setState({isLoading:false})
		});
	}
	
	handleSurveyDateChange_x = (e,i)=>{
		if(this.state.grid[i].survey_date_ori != e.target.value){
			let st = [...this.state.grid]
			let item = st[i]
			item.survey_date = e.target.value
			item.condition = null
			item.condition_desc = null
			st[i] = item
			this.setState({grid: st})
		}else{
			this.deleteWillUpdate(this.state.grid[i].id)
			let st = [...this.state.grid]
			let item = st[i]
			item.survey_date = e.target.value
			item.condition = item.condition_ori
			item.condition_desc = item.condition_desc_ori
			st[i] = item
			this.setState({grid: st})
		}
	}
	
	handleSurveyDateChange = (e,i)=>{
		let val = e.target.value
		let dis = this
		this.setState({isLoading:true})
		fetch(apiUri+'karantina/getOne.php?id='+this.state.grid[i].id+'&survey_date='+e.target.value)
        .then(response => response.json())
        .then(data => {
			if(data.code==200){
				if(data.contents){
					let tofetch = data.contents[0]
					let st = [...dis.state.grid]
					let item = st[i]
					item.survey_date = val
					item.condition = tofetch.condition
					item.condition_desc = tofetch.condition_desc
					st[i] = item
					dis.setState({grid: st})
				}else{
					let st = [...dis.state.grid]
					console.log(st)
					let item = st[i]
					console.log(item)
					item.survey_date = val
					item.condition = ''
					item.condition_desc = ''
					st[i] = item
					dis.setState({grid: st})
				}
			}else{
				alert(data.messages)
			}
			this.setState({isLoading:false})
		});
	}
	
	handleCategoryChange = (e, i )=>{
		let st = [...this.state.grid]
		let item = st[i]
		item.category = e.target.value
		st[i] = item
		this.setState({grid: st})
	}
	
	handleConditionChange = (e, i )=>{
		let st = [...this.state.grid]
		let item = st[i]
		item.condition = e.target.value
		st[i] = item
		this.setState({grid: st})
	}
	
	deleteWillUpdate(idToDelete) {
		this.setState(prevState => {
			const willUpdate = prevState.willUpdate.filter(will => will.id !== idToDelete);
			return { willUpdate };
		});
	}
	
	handleConditionDescChange = (e, i )=>{
		let st = [...this.state.grid]
		let item = st[i]
		item.condition_desc = e.target.value
		st[i] = item
		this.setState({grid: st})
	}
	
	handleLocationChange = (e,i)=>{
		let st = [...this.state.grid]
		let item = st[i]
		item.location = e.target.value
		st[i] = item
		this.setState({grid: st})
	}
	
	handleEndDateChange = (e,i)=>{
		let st = [...this.state.grid]
		let item = st[i]
		item.end_date = e.target.value
		st[i] = item
		this.setState({grid: st})
	}

	componentWillUnmount() {
		this._isMounted = false;
	}
	
	beforeSave = ()=>{
		let dis = this
		const oldState = dis.state.grid
		const getWill = oldState.filter(will => will.condition === 'Selesai Karantina');
		
		this.setState({akanSelesaiKarantina:getWill}, this.toggle2())		
		
	}
	
	save = ()=>{
		this.setState({isLoading:true})
		const requestOptions = {
			method: 'POST',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify(this.state.grid)
		};
		let dis = this
		fetch(apiUri+'karantina/update.php', requestOptions)
			.then(response => response.json())
			.then(data => {
				if(data.code == 200){
					const oldState = dis.state.grid
					const index = oldState.findIndex(p =>{
						return p.condition === 'Selesai Karantina'
					})
					console.log('indx')
					console.log(index)
					if(index >= 0){
						oldState.splice(index,1)
						dis.setState({grid: oldState});	
					}
				}else{
					alert(data.messages)
				}
				console.log(data)
				this.setState({isLoading:false})
				this.toggle2()
			});
	}

	render() {
		// if (this.state.isLoading) {
			// return <p>Loading ...</p>;
		// }
		return (<div className="app flex-row" ref="cobaaja">
		
        <Container className="p-3">
          <Row className="justify-content-center">
            <Col md="12" lg="12" xl="12">
              <Card>
              <CardHeader>
				<Link to="/karantina/form">
					<Button color="success" active><i className="fa fa-plus"></i> Tambah Data Karantina</Button>
                </Link>
				<Button color="primary" active onClick={this.beforeSave} className="float-right" style={{display: this.state.willUpdate.length>0?'block':'block'}}><i className="fa fa-save"></i> {this.state.isLoading?'Updating...':'Update'}</Button>
              </CardHeader>
              <CardBody>
			  <div id="cover-spin" style={{ display: this.state.isLoading ? 'block' : 'none' }}></div>
			  
				<h3>Data Karantina</h3>
                <Table className="table-karantina" responsive>
                  <thead>
                  <tr>
                    <th>Region</th>
                    <th>Company</th>
                    <th>Bagian</th>
                    <th>Nama</th>
                    <th>Status</th>
                    <th>Lokasi Karantina</th>
                    <th>Mulai Karantina</th>
                    <th>Selesai Karantina</th>
                    <th>Kategori Karantina</th>
                    <th>Alasan Dikarantina</th>
                    <th>Tanggal Declare</th>
                    <th>Kondisi Kesehatan</th>
                    <th>Keterangan</th>
                    <th>Detail</th>
                  </tr>
                  </thead>
                  <tbody>
                  {
					  this.state.grid.map((item, i)=>
						<tr key={i}>
							<td>{item.region}</td>
							<td>{item.company}</td>
							<td>{item.bagian}</td>
							<td>{item.name.toUpperCase()}</td>
							<td>{item.status}</td>
							<td>
								<Input type="select" className="combo_wrap" value={item.location} onChange={(event)=>this.handleLocationChange(event, i)}>
									<option>Dalam Kebun</option>
									<option>Luar Kebun</option>
								</Input>
							</td>
							<td>{item.start_date}</td>
							<td>
								<Input type="date" value={item.end_date} min={item.start_date_formated} onChange={(event)=>this.handleEndDateChange(event, i)} placeholder="" />
							</td>
							<td>
								<Input type="select" className="combo_wrap" value={item.category} onChange={(event)=>this.handleCategoryChange(event, i)}>
									<option>Karantina Sehat</option>
									<option>PDP</option>
									<option>ODP</option>
									<option>Positif Covid</option>
								</Input>
							</td>
							<td>{item.reason}</td>
							<td>
								<Input type="date" defaultValue={item.survey_date} max={item.survey_date_max} min={item.min_start_date} onChange={(event)=>this.handleSurveyDateChange(event, i)} placeholder="" />
							</td>
							<td>
								<Input type="select" className="combo_wrap" value={item.condition} onChange={(event)=>this.handleConditionChange(event, i)}>
									<option></option>
									<option>Sehat</option>
									<option>Sakit</option>
									<option>Selesai Karantina</option>
								</Input>
							</td>
							<td><Input type="text" style={{ display: item.condition=='Sakit' ? 'block' : 'none' }} className="combo_wrap" value={item.condition_desc} onChange={(event)=>this.handleConditionDescChange(event, i)}/></td>
							<td>
								<Button onClick={(e)=>this.viewDetail(e,i)} color="success" className="btn-sm" active><i className="fa fa-eye"></i></Button>
							</td>
						</tr>
					  )
				  }
                  </tbody>
                </Table>
				<Modal isOpen={this.state.modalConfirm} toggle={this.toggle2}
                          className={'modal-success modal-lg ' + this.props.className}>
                            <ModalHeader toggle={this.toggle2}>Konfirmasi</ModalHeader>
                            <ModalBody>
								<h3>Apakah anda yakin untuk memproses data?</h3>
								<br/>
								{ this.state.akanSelesaiKarantina.length>0 ? (<p className="text-muted">Berikut adalah data dengan status selesai karantina yang akan diproses</p>) : ''}
								<Table responsive style={{display:this.state.akanSelesaiKarantina.length==0?'none':'inline-table', width:'100%'}}>
								  <thead>
								  <tr>
									<th>Region</th>
									<th>Company</th>
									<th>Bagian</th>
									<th>Nama</th>
									<th>Status</th>
								  </tr>
								  </thead>
								  <tbody>
								  {
									  this.state.akanSelesaiKarantina.map((item, i)=>
										<tr key={i}>
											<td>{item.region}</td>
											<td>{item.company}</td>
											<td>{item.bagian}</td>
											<td>{item.name}</td>											
											<td style={{ color:'green' }}>Selesai Karantina</td>											
										</tr>
									  )
								  }
								  </tbody>
								</Table>
                            </ModalBody>
                            <ModalFooter>
								<Button color="default" onClick={this.toggle2}>Tutup</Button>
								<Button color="primary" onClick={this.save}>Proses</Button>
                            </ModalFooter>
                          </Modal>
				<Modal isOpen={this.state.modalo} toggle={this.toggle}
                          className={'modal-success ' + this.props.className}>
                            <ModalHeader toggle={this.toggle}>Info Riwayat Declare</ModalHeader>
                            <ModalBody>
							{this.state.detail.length == 0 ? 'Please wait...' : ''}
								
								<Table className="tbl-header-popup">
									<tr>
										<th>Nama</th>
										<td>: {this.state.detailName}</td>
									</tr>
									<tr>
										<th>Tanggal Selesai Karantina</th>
										<td>: {this.state.detailEndDate}</td>
									</tr>
								</Table>
								
								<Table responsive style={{display:this.state.detail.length==0?'none':'inline-table', width:'100%'}}>
								  <thead>
								  <tr>
									<th>Tanggal Declare</th>
									<th>Kondisi</th>
									<th>Keterangan</th>
								  </tr>
								  </thead>
								  <tbody>
								  {
									  this.state.detail.map((item, i)=>
										<tr key={i}>
											<td>{item.survey_date}</td>
											<td>{item.condition}</td>
											<td>{item.condition_desc}</td>
											
										</tr>
									  )
								  }
								  </tbody>
								</Table>
								
                            </ModalBody>
                            <ModalFooter>
                              <Button color="warning" onClick={this.toggle}>OK</Button>
                            </ModalFooter>
                          </Modal>
						  
                {/*
				<Pagination>
                  <PaginationItem>
                    <PaginationLink previous tag="button"></PaginationLink>
                  </PaginationItem>
                  <PaginationItem active>
                    <PaginationLink tag="button">1</PaginationLink>
                  </PaginationItem>
                  <PaginationItem>
                    <PaginationLink tag="button">2</PaginationLink>
                  </PaginationItem>
                  <PaginationItem>
                    <PaginationLink tag="button">3</PaginationLink>
                  </PaginationItem>
                  <PaginationItem>
                    <PaginationLink tag="button">4</PaginationLink>
                  </PaginationItem>
                  <PaginationItem>
                    <PaginationLink next tag="button"></PaginationLink>
                  </PaginationItem>
                </Pagination>	
				*/}
              </CardBody>
            </Card>
            </Col>
          </Row>
		  
  
        </Container>
      </div>)

		
	}
}

export default Outstanding;