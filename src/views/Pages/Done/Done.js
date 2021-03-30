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


class Done extends Component {
	constructor(props) {
		super(props);
		this.state = {
			kuy: false,
			name: '',
			score: 0,
			isLoading	: false,
		};
	}
	
	async componentDidMount() {
		console.log('this.props.location.state')
		console.log(this.props.location.state)
		let nm;
		let sc;
		console.log('this.props.location.state')
		console.log(atob(this.props.match.params.name))
		console.log(atob(this.props.match.params.score))
		// console.log(typeof(this.props.location.state))
		
		// if( typeof(this.props.location.state) !== 'undefined'){
			// localStorage.setItem('done.name', this.props.location.state.name);
			// localStorage.setItem('done.score', this.props.location.state.score);
			// this.setState({name:this.props.location.state.name, score: this.props.location.state.score, kuy: true})
		// }
		// else{
			// this.setState({name:localStorage.getItem('done.name'), score: localStorage.getItem('done.score'), kuy: true})
		// }
	}
	
	today = ()=>{
		var today = new Date();
		var dd = String(today.getDate()).padStart(2, '0');
		var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
		var yyyy = today.getFullYear();

		today = dd + '/' + mm + '/' + yyyy;
		return today
	}

	render() {
			let msg, msgColor
			let nm = atob(this.props.match.params.name)
			let sc = atob(this.props.match.params.score)
			if(nm != ''){
				if(sc >= 9){
					msg = `Dari hasil self declare anda, saudara ${nm} tidak direkomendasikan utk WFO hari ini tgl ${this.today()}`
					msgColor = 'red'
				}else{
					msg = `Dari hasil self declare anda, saudara ${nm} diizinkan untuk WFO hari ini tgl ${this.today()}`
					msgColor = 'green'
				}
			}
			
			return (
				<div className="app flex-row">
				<Container className="p-5">
				  <Row className="justify-content-center">
					<Col md="7" lg="7" xl="7">
					<div id="cover-spin" style={{ display: this.state.isLoading ? 'block' : 'none' }}></div>
					<Card className="text-black bg-default ">
						<CardBody className="p-4">
							<center>
								<h2>Semangat Pagi Insan TAP</h2>
								<br/>
								<p>
								Terima kasih sudah mengisi Self Declaration ini <br/>
								<span style={{ color:msgColor, fontWeight:'500' }}>{msg}</span> <br/>
								#staysafe <br/>
								#stayhealthy <br/>
								#bersamakitabisamelawancovid-19 <br/>
								</p>
							</center>
						</CardBody>
					  </Card>
					  
						
					</Col>
				  </Row>
				</Container>
			  </div>
			);
	  }
}

export default Done;
