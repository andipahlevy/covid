import React, { Component } from 'react';
import { Link } from 'react-router-dom';
import { Button, Badge, Card, Container, CardBody, CardHeader, Col, Pagination, PaginationItem, PaginationLink, Row, Table } from 'reactstrap';
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
			
		};
	}

	async componentDidMount() {
		fetch('http://localhost/report-app-subco-api/api/karantina/get')
        .then(response => response.json())
        .then(data => {
			if(data.code==200){
				this.setState({grid: data.contents})
			}
		});
	}

	componentWillUnmount() {
		this._isMounted = false;
	}

	render() {
		return (<div className="app flex-row">
        <Container className="p-3">
          <Row className="justify-content-center">
            <Col md="12" lg="12" xl="12">
              <Card>
              <CardHeader>
				<Link to="/karantina/form">
					<Button color="success" active><i className="fa fa-plus"></i> Tambah Data Karantina</Button>
                </Link>
              </CardHeader>
              <CardBody>
				<p><h3>Data Karantina</h3></p>
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
                    <th>Kondisi Kesehatan</th>
                    <th>Declare</th>
                    <th>Detail</th>
                  </tr>
                  </thead>
                  <tbody>
                  {
					  this.state.grid.map((item, i)=>
						<tr>
							<td>{item.Ba}</td>
							<td>{item.Bagian}</td>
							<td>{item.name}</td>
							<td>{item.status}</td>
							<td>{item.start_date.date.replace('00:00:00.000000','')}</td>
							<td>{item.end_date.date.replace('00:00:00.000000','')}</td>
							<td>{item.Category}</td>
							<td>
							{item.condition=='Sehat' ? (<Badge color="success">{item.condition}</Badge>): (<Badge color="warning">{item.condition}</Badge>)}
							</td>
							<td>
								<Button color="primary" className="btn-sm" active><i className="fa fa-plus"></i></Button>
							</td>
							<td>
								<Button color="success" className="btn-sm" active><i className="fa fa-eye"></i></Button>
							</td>
						</tr>
					  )
				  }
                  </tbody>
                </Table>
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