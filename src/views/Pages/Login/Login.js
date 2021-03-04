import React, { Component } from 'react';
// import { Link } from 'react-router-dom';
import {
	Alert,
	Button,
	Card,
	CardBody,
	CardGroup,
	Col,
	Container,
	Form,
	Input,
	InputGroup,
	InputGroupAddon,
	InputGroupText,
	Row
} from 'reactstrap';
import {
	pathAPIServer,
	pathUserCheck,
} from '../../Constants';

function validatenik(nik) {
	var nikerr = [];
	var re = new RegExp("^[0-9]+$");

	if (nik.length === 0) {
		nikerr = ["The NIK can't be empty."];
	} else if (re.test(nik)) {
	} else {
		nikerr = ["The NIK should only contain numbers."]
	}

	return nikerr;
}

function validatepassword(password) {
	var passworderr = [];

	if (password.length === 0) {
		passworderr = ["The password can't be empty."];
	}

	return passworderr;
}

async function validatelogin(nik,password) {
	var loginerr = [];

	console.log(pathAPIServer + pathUserCheck + nik + '/' + password);
	await fetch(pathAPIServer + pathUserCheck + nik + '/' + password)
	.then(response => {
		if (response.ok) {
			return response.json()
		} else {
			loginerr = ["Something went wrong.. Please try again."];
		}
	})
	.then(data => {
		if (data.recordset[0].ValidLogin === 1) {
		} else {
			loginerr = ["The NIK and password don't match. Please recheck and try again."];
		}
	})
	.catch(error => loginerr = ["Something went wrong. Please try again."])

	return loginerr;
}

class Login extends Component {
	constructor(props) {
		super(props);
		this.state = {
			nik: '',
			password: '',
			nikerr: [],
			passworderr: [],
			loginerr: [],
		};

		this.handleNikChange = this.handleNikChange.bind(this);
		this.handlePasswordChange = this.handlePasswordChange.bind(this);
		this.handleSubmit = this.handleSubmit.bind(this);
	}
	
	handleNikChange(event) {
		this.setState({nik: event.target.value});
	}

	handlePasswordChange(event) {
		this.setState({password: event.target.value});
	}

	async handleSubmit(event) {
		// event.preventDefault();

		const { nik, password } = this.state;

		var loginerr = [];
		var nikerr = validatenik(nik);
		var passworderr = validatepassword(password);

		if (nikerr.length === 0 && passworderr.length === 0) {
			loginerr = await validatelogin(nik,password);
		}
		var errstate = nikerr.length+passworderr.length+loginerr.length;

		this.setState({ nikerr, passworderr, loginerr, errstate });

		if (errstate === 0) {
			this.props.history.push('/dashboard');
		}
		else {
			return;
		}
	}

	render() {
		const { nikerr, passworderr, loginerr } = this.state;
		return (
			<div className="app flex-row align-items-center">
				<Container>
					<Row className="justify-content-center">
						<Col md="8">
							<CardGroup>
								<Card className="p-4">
									<CardBody>
										<Form onSubmit={this.handleSubmit}>
											<h1>Login</h1>
											<p className="text-muted">Sign in to your account</p>
											<InputGroup className="mb-3">
												<InputGroupAddon addonType="prepend">
													<InputGroupText>
														<i className="icon-user"></i>
													</InputGroupText>
												</InputGroupAddon>
												<Input type="text" value={this.state.value} onChange={this.handleNikChange}
												placeholder="NIK" autoComplete="nik" />
											</InputGroup>
											{nikerr.map(nikerr => (
												<Alert key={nikerr} color='danger'>Error: {nikerr}</Alert>
											))}
											<InputGroup className="mb-4">
												<InputGroupAddon addonType="prepend">
													<InputGroupText>
														<i className="icon-lock"></i>
													</InputGroupText>
												</InputGroupAddon>
												<Input type="password" value={this.state.value} onChange={this.handlePasswordChange}
												placeholder="Password" autoComplete="current-password" />
											</InputGroup>
											{passworderr.map(passworderr => (
												<Alert key={passworderr} color='danger'>Error: {passworderr}</Alert>
											))}
											<Row>
												<Col xs="6">
													<Button type="submit" color="success" className="px-4">Login</Button>
												</Col>
												{/*
												<Col xs="6" className="text-right">
													<Link to="/forgot">
														<Button color="link" className="px-0">Forgot password?</Button>
													</Link>
												</Col>
												*/}
											</Row>
											<p></p>
											{loginerr.map(loginerr => (
												<Alert key={loginerr} color='danger'>Error: {loginerr}</Alert>
											))}
										</Form>
									</CardBody>
								</Card>
								<Card className="text-white bg-success py-5 d-md-down-none" style={{ width: '44%' }}>
									<CardBody className="text-center">
										<div>
											<h2>Sign up</h2>
											<p></p>
											<p>You must be registered to use this program.
											Due to our single sign-on policy, the registration of new users shall be done through Kiranalytics.
											Please accept our apology for the inconvenience.</p>
											{/*<p></p>
											<Link to="/register">
												<Button color="success" className="mt-3" active tabIndex={-1}>Register Now!</Button>
											</Link>*/}
										</div>
									</CardBody>
								</Card>
							</CardGroup>
						</Col>
					</Row>
				</Container>
			</div>
		);
	}
}

export default Login;
