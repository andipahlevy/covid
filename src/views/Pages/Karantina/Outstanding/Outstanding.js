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
import queryString from 'query-string';
import $ from "jquery"
$.DataTable = require('datatables.net-fixedcolumns');
// require('datatables.net-fixedcolumns');

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
			f_region: '',
			f_company: '',
			f_bagian: '',
			f_status: '',
			f_kategori: '',
			master_table: null,
			region_data: [],
			company_data: [],
			pilNonHO : ['ESTATE 1','ESTATE 2','ESTATE 3','MILL','BULKING','KARET'],
			pilHO : ['HEAD OFFICE'],
			pilBagian: ['HEAD OFFICE','ESTATE 1','ESTATE 2','ESTATE 3','MILL','BULKING','KARET']
		};
	}
	
	handleFRegionChange = (e)=>{
		// this.setState({isLoading:true})
		this.setState({f_region:e.target.value})
		if(e.target.value){
			// this.getCompany(e.target.value)
		}
		
	}
	
	getCompany(){
		fetch(apiUri+'master/company.php')
				.then(response => response.json())
				.then(data => {
					if(data.code==200){
						this.setState({company_data: data.contents})
					}else{
						alert('Gagal get company');
					}
					// this.setState({isLoading:false})
				})
				.catch((error) => {
					console.log(error)
					alert('Gagal mengambil data company. Mohon cek koneksi anda atau tunggu beberapa saat')
					// this.setState({isLoading:false})
				});	
	}
	
	handleFCompanyChange = (e)=>{
		let val = e.target.value
		this.setState({f_company:val}, ()=>{
			// if(val != ''){
				// if(val != 'TAP'){
					// this.setState({pilBagian:this.state.pilNonHO})
				// }else{
					// this.setState({pilBagian:this.state.pilHO})
				// }	
			// }
		})
	}
	
	handleFBagianChange = (e)=>{
		this.setState({f_bagian:e.target.value})
	}
	
	handleFStatusChange = (e)=>{
		this.setState({f_status:e.target.value})
	}
	
	handleFKategoriChange = (e)=>{
		this.setState({f_kategori:e.target.value})
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
	delDetail = (e,i)=>{
		let dis = this
		let del = window.confirm('Apakah anda akan menghapus data karantina dengan nama '+this.state.grid[i].name+' ?')
		if(del){
			this.setState({isLoading:true})
			fetch(apiUri+'karantina/delete.php?id='+this.state.grid[i].id)
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

	async componentDidMount() {
		let params = queryString.parse(this.props.location.search)
		if(params){
			console.log(params)
			this.setState({
					f_region: params.region,
					f_company: params.company,
					f_bagian: params.bagian,
					f_kategori: params.kategori,
					f_status: params.status,
				}, this.fetchData())
		}else{
			this.fetchData()
		}
		
		console.log('ReactDOM.findDOMNode(this.refs.cobaaja)')
		console.log(ReactDOM.findDOMNode(this.refs.cobaaja))
		$('.table-responsive').css('height',(window.innerHeight - 200)+'px')
		
		const script = document.createElement("link");
		script.href = "https://cdn.datatables.net/1.10.24/css/jquery.dataTables.min.css";
		script.rel = "stylesheet";
		document.body.appendChild(script);
		
		this.fetchRegion()
		
		this.getCompany()
		
		if(params.company){
			this.setState({f_company:params.company}, ()=>{
				if(params.company != 'TAP'){
					this.setState({pilBagian:this.state.pilNonHO})
				}else{
					this.setState({pilBagian:this.state.pilHO})
				}
			})
		}
		if(params.status){
			this.setState({f_status:params.status})
		}
		if(params.kategori){
			this.setState({f_kategori:params.kategori})
		}
	}
	
	fetchRegion(){
		fetch(apiUri+'master/region.php')
			.then(response => response.json())
			.then(data => {
				if(data.code==200){
					this.setState({region_data: data.contents})
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
	
	render_datatables(){
		let dis = this
		let table =  $('.table-karantina2').DataTable({
							scrollY:        350,
							scrollX:        true,
							scrollCollapse: true,
							// fixedHeader: true,
							"lengthChange": false,
							"paging":   false,
							fixedColumns: {
							  leftColumns: 5
							},
							"ordering": false,
							"info":     false,
							"columnDefs": [
								{
									"render": function ( data, type, row ) {
										return dis.nowrapCustom(data)
									},
									"targets": [0,1,2,3]
								},
								{
									"searchable": false,
									"orderable": false,
									"targets": 0
								}
							],
							initComplete: function () {
								// this.api().columns().every(function (k) {
									// if(k >= 0 && k < 4){
										// var column = this;
										// var input = document.createElement("input");
										// $(input).appendTo($(column.footer()).empty())
										// .on('change', function () {
											// column.search($(this).val(), false, false, true).draw();
										// }).attr('placeholder',' Cari');
									// }
								// });
								setTimeout(()=>{
									$('.dataTables_scrollBody').css('max-height','361px')
								},3000)
							}
						});
		table.on( 'order.dt search.dt', function () {
			table.column(0, {search:'applied', order:'applied'}).nodes().each( function (cell, i) {
				cell.innerHTML = i+1;
				
				$('.totku').html('Total '+parseInt(i+1)+' row data')
			} );
			
		} ).draw();
		// $('.table-karantina2 thead tr').clone(true).appendTo( '.table-karantina2 thead' );
		// $('.table-karantina2 thead').append( $('.table-karantina2 thead ').html() );
		// $('.table-karantina2 thead tr:eq(1) th').each( function (i) {
			// var title = $(this).text();
			// if(title =="Company" || title =="Bagian" || title =="Kategori Karantina" || title =="Status" || title =="Region"){
				// $('.trg-filter').html($('.trg-filter').html()+ '<br/><input type="text" class ="form-control col-md-3 tfsearch" placeholder="Search" />' );
		
				// $( 'input', this ).on( 'click change', function (event) {
						// if ( table.column(i).search() !== this.value ) {
							// table
								// .column(i)
								// .search( this.value )
								// .draw();
						// }
				// } );
			// }
			// else{
				// $(this).html( '<div style="width: auto;"></div>' );
			// }
		// } );
		
		this.setState({master_table:table})
	}
	
	
	fetchData = ()=>{
		let params = queryString.parse(this.props.location.search)
		console.log('sie,',params)
		let search = {
			region: params.region,
			company: params.company,
			bagian: params.bagian,
			status: params.status,
			kategori: params.kategori,
		}
		let params2 = queryString.stringify(search)
		console.log('params2',params2, apiUri+'karantina/get.php?'+params2)
		this.setState({isLoading:true})
		fetch(apiUri+'karantina/get.php?'+params2, { 
														method: "GET", 
													}
					)
        .then(response => response.json())
        .then(data => {
			if(data.code==200){
				this.setState({grid: data.contents},function(){
					this.render_datatables()
				})
			}
			this.setState({isLoading:false})
		})
		.catch((error) => {
			console.log(error)
			alert('Gagal mengambil data. Mohon cek koneksi anda atau tunggu beberapa saat')
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
			})
			.catch((error) => {
				console.log(error)
				alert('Gagal menyimpan. Mohon cek koneksi anda atau tunggu beberapa saat')
				this.setState({isLoading:false})
			});
	}
	
	nowrapCustom = (nama)=>{
		let spl = nama.split(' ')
		let final = '';
		spl.map((v,k)=>{
			if(k==2){
				final += '<br/>';
			}
			if(k>0){
				final += ' ';
			}
			final += v
		})
		return final
	}
	
	filter = ()=>{
		let search = {
			region: this.state.f_region,
			company: this.state.f_company,
			bagian: this.state.f_bagian,
			status: this.state.f_status,
			kategori: this.state.f_kategori,
		}
		// let params = queryString.parse(this.props.location.search)
		let params = queryString.stringify(search)
		console.log(params)
		window.location.href=window.location.origin+'/#/karantina/?'+params
		window.location.reload();
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
                
				<div className="row">
					<div className="col-md-3 p-3">
						<FormGroup>
						  <Label htmlFor="region">Region</Label>
						  <Input type="select" value={this.state.f_region} onChange={this.handleFRegionChange} name="region" id="region">
							<option></option>
							{
								this.state.region_data.map((item,i)=>{
									return <option>{item.region_name}</option>
								})
							}
						  </Input>
						</FormGroup>
					</div>
					<div className="col-md-3 p-3">
						<FormGroup>
						  <Label htmlFor="ba">Company</Label>
						  <Input type="select" value={this.state.f_company} onChange={this.handleFCompanyChange} name="ba" id="ba">
							<option></option>
							{
								this.state.company_data.map((item,i)=>{
									return <option>{item.comp_name}</option>
								})
							}
						  </Input>
						</FormGroup>
					</div>
					<div className="col-md-3 p-3">
						<FormGroup>
						  <Label htmlFor="bagian">Bagian</Label>
						  <Input type="select" name="bagian" id="bagian" value={this.state.f_bagian} onChange={this.handleFBagianChange}>
							<option></option>
							{
								this.state.pilBagian.map((item,i)=>{
									return <option>{item}</option>
								})
							}
						  </Input>
						</FormGroup>
					</div>
					<div className="col-md-3 p-3">
						<FormGroup>
						  <Label htmlFor="status">Status</Label>
						  <Input type="select" name="status" id="status" value={this.state.f_status} onChange={this.handleFStatusChange}>
							<option></option>
							<option>Karyawan</option>
							<option>Keluarga Karyawan</option>
							<option>Calon Karyawan</option>
							<option>Keluarga Calon Karyawan</option>
						  </Input>
						</FormGroup>
					</div>
					<div className="col-md-3 p-3">
						<FormGroup>
						  <Label htmlFor="category">Kategori Karantina</Label>
						  <Input type="select" name="category" id="category" value={this.state.f_kategori} onChange={this.handleFKategoriChange}>
							<option></option>
							<option>Karantina Sehat</option>
							<option>PDP</option>
							<option>ODP</option>
							<option>Positif Covid</option>
						  </Input>
						</FormGroup>
					</div>
					<div className="col-md-3 p-3">
						<FormGroup>
						  <br/>
						  <Button style={{marginTop:'7px'}} onClick={this.filter} color="success" active>{this.state.isLoading?'Please wait...':'Filter'}</Button>
						</FormGroup>
						
					</div>
				</div>
				
				 <table className="table-karantina2 text-nowrap stripe row-border order-column" style={{ width:'100%' }}>
                  <thead>
                  <tr>
                    <th></th>
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
						<tr key={i} {...{ "id": "trid-"+i }}>
							<td></td>
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
								<Button style={{ marginLeft:'5px' }} onClick={(e)=>this.delDetail(e,i)} color="danger" className="btn-sm" active><i className="fa fa-trash"></i></Button>
							</td>
						</tr>
					  )
				  }
                  </tbody>
				  
                </table>
				<div style={{ padding:'10px' }}><h6 className="totku">Total data { this.state.grid.length}</h6></div>
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