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
import { apiUri } from '../Constants';
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
		
	}
	
	

	render() {
			
			
			return (
				<div className="app flex-row">
				<Container className="p-5">
				  <Row className="justify-content-center">
					<Col md="7" lg="7" xl="7">
					<div id="cover-spin" style={{ display: this.state.isLoading ? 'block' : 'none' }}></div>
					<Card className="text-black bg-default ">
						<CardBody className="p-4">
							Welcome to Dashboard
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
