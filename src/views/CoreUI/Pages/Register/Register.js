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
  Row
} from 'reactstrap';

function validatenik(nik) {
  const nikerr = [];

  if (nik.length === 0) {
    nikerr.push("The nik can't be empty.");
  }

  return nikerr;
}

function validatepassword(password) {
  const passworderr = [];

  if (password.length === 0) {
    passworderr.push("The password can't be empty.");
  }
  // else if (password.length < 6) {
  //  passworderr.push("Password should be at least 6 characters long");
  // }

  return passworderr;
}

function validaterepassword(password,repassword) {
  const repassworderr = [];

  if (repassword.length === 0) {
    repassworderr.push("The password can't be empty.");
  }
  else if (password !== repassword) {
    repassworderr.push("The passwords don't match. Please try again.");
  }

  return repassworderr;
}

class Register extends Component {
  constructor(props) {
    super(props);
    this.state = {
      modal: false,
      nik: '',
      password: '',
      repassword: '',
      nikerr: [],
      passworderr: [],
      repassworderr: [],
    };
    this.handleNikChange = this.handleNikChange.bind(this);
    this.handlePasswordChange = this.handlePasswordChange.bind(this);
    this.handleRePasswordChange = this.handleRePasswordChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);

    this.toggle = this.toggle.bind(this);
  }
  
  toggle() {
    this.setState({
      modal: !this.state.modal,
    });
  }

  handleNikChange(event) {
    this.setState({nik: event.target.value});
  }

  handlePasswordChange(event) {
    this.setState({password: event.target.value});
  }

  handleRePasswordChange(event) {
    this.setState({repassword: event.target.value});
  }

  handleSubmit(event) {
    event.preventDefault();

    const { nik, password, repassword } = this.state;

    const nikerr = validatenik(nik);
    const passworderr = validatepassword(password);
    const repassworderr = validaterepassword(password,repassword);
    const errstate = nikerr.length+passworderr.length+repassworderr.length;

    this.setState({ nikerr, passworderr, repassworderr, errstate });

    if (errstate === 0) {
      this.props.history.push('/login');
    }
    else {
      return;
    }
  }

  render() {
    const { nikerr, passworderr, repassworderr } = this.state;
    return (
      <div className="app flex-row align-items-center">
        <Container>
          <Row className="justify-content-center">
            <Col md="9" lg="7" xl="6">
              <Card className="text-white bg-success mx-4">
                <CardBody className="p-4">
                  <Form onSubmit={this.handleSubmit}>
                    <h1>Register</h1>
                    <p className="text-muted">Create your account using your official company NIK.</p>
                    {/*
                    <InputGroup className="mb-3">
                      <InputGroupAddon addonType="prepend">
                        <InputGroupText>
                          <i className="icon-user"></i>
                        </InputGroupText>
                      </InputGroupAddon>
                      <Input type="text" placeholder="Username" autoComplete="username" />
                    </InputGroup>
                    */}
                    <InputGroup className="mb-3">
                      <InputGroupAddon addonType="prepend">
                        <InputGroupText>@</InputGroupText>
                      </InputGroupAddon>
                      <Input type="text" value={this.state.value} onChange={this.handleNikChange}
                      placeholder="NIK" autoComplete="nik" />
                    </InputGroup>
                    {nikerr.map(nikerr => (
                      <Alert key={nikerr} color='danger'>Error: {nikerr}</Alert>
                    ))}
                    <InputGroup className="mb-3">
                      <InputGroupAddon addonType="prepend">
                        <InputGroupText>
                          <i className="icon-lock"></i>
                        </InputGroupText>
                      </InputGroupAddon>
                      <Input type="password" value={this.state.value} onChange={this.handlePasswordChange}
                      placeholder="Password" autoComplete="new-password" />
                    </InputGroup>
                    {passworderr.map(passworderr => (
                      <Alert key={passworderr} color='danger'>Error: {passworderr}</Alert>
                    ))}
                    <InputGroup className="mb-4">
                      <InputGroupAddon addonType="prepend">
                        <InputGroupText>
                          <i className="icon-lock"></i>
                        </InputGroupText>
                      </InputGroupAddon>
                      <Input type="password" value={this.state.value} onChange={this.handleRePasswordChange}
                      placeholder="Repeat password" autoComplete="new-password" />
                    </InputGroup>
                    {repassworderr.map(repassworderr => (
                      <Alert key={repassworderr} color='danger'>Error: {repassworderr}</Alert>
                    ))}
                    <Row>
                      <Col xs="6">
                        {/*<Button type="submit" color="success" active>Create Account</Button>*/}
                        <Button onClick={this.toggle} color="success" active>Create Account</Button>
                          <Modal isOpen={this.state.modal} toggle={this.toggle}
                          className={'modal-success ' + this.props.className}>
                            <ModalHeader toggle={this.toggle}>Info</ModalHeader>
                            <ModalBody>
                              Due to Single Sign On policy, the registration of new users shall be done through Kiranalytics.
                              Please accept our apology for the inconvenience.
                            </ModalBody>
                            <ModalFooter>
                              <Button color="warning" onClick={this.toggle}>OK</Button>
                            </ModalFooter>
                          </Modal>
                      </Col>
                      <Col xs="6" className="text-right">
                        <Link to="/login">
                          <Button color="warning">Cancel</Button>
                        </Link>
                      </Col>
                    </Row>
                  </Form>
                </CardBody>
              </Card>
            </Col>
          </Row>
        </Container>
      </div>
    );
  }
}

export default Register;
