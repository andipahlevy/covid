import React, { Component } from 'react';
import { Link } from 'react-router-dom';
import { Button, Input, Badge, Card, Container, CardBody, CardHeader, Col, Pagination, PaginationItem, PaginationLink, Row, Table,
Modal,
  ModalBody,
  ModalFooter,
  ModalHeader } from 'reactstrap';
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
	pathAPIServer,
	pathReportDetail,
} from '../../../Constants';

class DailyAssessmentInput extends Component {
	_isMounted = false;

	constructor(props) {
		super(props);
		
		this.state = {
			grid: [],
			willUpdate: [],
			descs: [],
			edited: 0,
			modalo: false,
			detail: [],
			isLoading: false
		};
	}
	
	toggle = ()=> {
		this.setState({
		  modalo: !this.state.modalo,
		});
	  }
	  
	viewDetail = (e,i)=>{
		this.setState({detail: []},this.toggle())
		
		
		fetch('http://localhost/covid-api/karantina/detail.php?id='+this.state.grid[i].id)
        .then(response => response.json())
        .then(data => {
			if(data.code==200){
				this.setState({detail: data.contents})
			}
		});
	}

	async componentDidMount() {
		this.fetchData()
	}
	
	fetchData = ()=>{
		fetch('http://localhost/covid-api/karantina/get.php')
        .then(response => response.json())
        .then(data => {
			if(data.code==200){
				this.setState({grid: data.contents})
			}
		});
	}
	
	handleSurveyDateChange = (e,i)=>{
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
	
	handleConditionChange = (e, i )=>{
		let val = e.target.value
		if(this.state.edited >= 0){
			console.log('nie')
			
			if(val != 'Pilih'){
				this.setState({edited: (this.state.edited+1)})
				let ceki = this.state.willUpdate.filter(will => will.id == this.state.grid[i].id)
				if(ceki.length==0){
					this.state.willUpdate.push({
						id: this.state.grid[i].id,
						survey_date: this.state.grid[i].survey_date,
						condition: val,
						condition_desc: this.state.grid[i].con_desc,
					})	
				}
			}else{
				if(this.state.edited > 0){
					this.deleteWillUpdate(this.state.grid[i].id)
					this.setState({edited: (this.state.edited-1)})
				}
			}
		}
		
		console.log('Edited: ',this.state.edited)
		console.log(val, i)
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
		item.con_desc = e.target.value
		st[i] = item
		this.setState({grid: st})
		
		let idx = this.state.grid[i].id
		let ceki = this.state.willUpdate.filter(will => will.id == this.state.grid[i].id)
		if(ceki.length > 0){
			let wu = [...this.state.willUpdate]
			const index = wu.findIndex(p =>{
				return p.id === idx
			})
			wu[index].condition_desc = e.target.value
			this.setState({willUpdate: wu})
		}
	}

	componentWillUnmount() {
		this._isMounted = false;
	}
	
	save = ()=>{
		this.setState({isLoading:true})
		const requestOptions = {
			method: 'POST',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify(this.state.willUpdate)
		};
		let dis = this
		fetch('http://localhost/covid-api/karantina/update.php', requestOptions)
			.then(response => response.json())
			.then(data => {
				if(data.code == 200){
					dis.fetchData()
				}else{
					alert(data.messages)
				}
				console.log(data)
				this.setState({isLoading:false})
			});
	}

	render() {
		// if (this.state.isLoading) {
			// return <p>Loading ...</p>;
		// }
		return (<div className="app flex-row">
        <Container className="p-3">
          <Row className="justify-content-center">
            <Col md="12" lg="12" xl="12">
              <Card>
              <CardHeader>
				<Link to="/karantina/form">
					<Button color="success" active><i className="fa fa-plus"></i> Tambah Data Karantina</Button>
                </Link>
				<Button color="primary" active onClick={this.save} className="float-right" style={{display: this.state.willUpdate.length>0?'block':'none'}}><i className="fa fa-save"></i> {this.state.isLoading?'Menyimpan':'Simpan'}</Button>
              </CardHeader>
              <CardBody>
				<h3>Data Karantina</h3>
                <Table responsive>
                  <thead>
                  <tr>
                    <th>Business Area</th>
                    <th>Bagian</th>
                    <th>Nama</th>
                    <th>Status</th>
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
							<td>{item.company}</td>
							<td>{item.bagian}</td>
							<td>{item.name}</td>
							<td>{item.status}</td>
							<td>{item.start_date}</td>
							<td>{item.end_date}</td>
							<td>{item.category}</td>
							<td>{item.reason}</td>
							<td>
								<Input type="date" defaultValue={item.survey_date} max={item.survey_date_max} min={item.min_start_date} onChange={(event)=>this.handleSurveyDateChange(event, i)} placeholder="" />
							</td>
							<td>
								{item.condition ? (<Badge color="success">{item.condition}</Badge>): (<Input type="select" onChange={(event)=>this.handleConditionChange(event, i)}><option>Pilih</option>
                        <option>Sehat</option>
                        <option>Sakit</option></Input>)}
							</td>
							<td>{item.condition_desc ? item.condition_desc : (<Input type="text" onChange={(event)=>this.handleConditionDescChange(event, i)}/>)}</td>
							<td>
								<Button onClick={(e)=>this.viewDetail(e,i)} color="success" className="btn-sm" active><i className="fa fa-eye"></i></Button>
							</td>
						</tr>
					  )
				  }
                  </tbody>
                </Table>
				<Modal isOpen={this.state.modalo} toggle={this.toggle}
                          className={'modal-success ' + this.props.className}>
                            <ModalHeader toggle={this.toggle}>Info Riwayat Declare</ModalHeader>
                            <ModalBody>
							{this.state.detail.length == 0 ? 'Please wait...' : ''}
								<Table responsive>
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

export default DailyAssessmentInput;