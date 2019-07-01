import React from 'react';
import { Row, Col } from 'reactstrap';

const MidFourCols = props => (
  <Row>
    <Col xs={{ size: 4, offset: 4 }}>
      {props.children}
    </Col>
  </Row>
);

export default MidFourCols;

