import React, { Component } from 'react';
import { Col, Container, Row } from 'reactstrap';

class Maintenance extends Component {
  render() {
    return (
      <div className="app flex-row align-items-center">
        <Container>
          <Row className="justify-content-center">
            <Col md="6">
              <span className="clearfix">
                <h4 className="pt-3">Sorry..</h4>
                <p className="text-muted float-left">The report you are looking for is being updated.<br/>Please try again later.</p>
              </span>
            </Col>
          </Row>
        </Container>
      </div>
    );
  }
}

export default Maintenance;
