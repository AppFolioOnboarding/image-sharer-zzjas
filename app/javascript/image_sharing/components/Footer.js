import { Row, Col } from 'reactstrap';
import React, { Component } from 'react';

class Footer extends Component {
  /* Implement your Footer component here */
  render() {
    return (
      <footer>
        <Row>
          <Col xs={{ size: 4, offset: 4 }}>
            <p className='text-center' fontSize="10px">Copyright: AppFolio Inc. Onboarding</p>
          </Col>
        </Row>
      </footer>
    );
  }
}

export default Footer;
