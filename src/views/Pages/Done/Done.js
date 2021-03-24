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
		// console.log(this.props.location.state)
		// console.log(typeof(this.props.location.state))
		if( typeof(this.props.location.state) !== 'undefined'){
			localStorage.setItem('done.name', this.props.location.state.name);
			localStorage.setItem('done.score', this.props.location.state.score);
			this.setState({name:this.props.location.state.name, score: this.props.location.state.score, kuy: true})
		}
		else{
			this.setState({name:localStorage.getItem('done.name'), score: localStorage.getItem('done.score'), kuy: true})
			
		}
	}
	
	

	render() {
			let msg, msgColor
			if(this.state.name != ''){
				if(this.state.score >= 9){
					msg = `Dari hasil self declare anda, saudara ${this.state.name} harus dikarantina`
					msgColor = 'red'
				}else{
					msg = `Dari hasil self declare anda, saudara ${this.state.name} diizinkan untuk WFO`
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
