import React, { Component } from 'react';
import { Row, Col } from 'reactstrap';
import { observer, inject } from 'mobx-react';

@observer
@inject('stores')
class FeedbackForm extends Component {
  render() {
    const feedback = this.props.stores.feedbackStore;

    return (
      <form className='text-center'>
        <Row>
          <Col xs={{ size: 4, offset: 4 }}>
            <label htmlFor='name' id='nameLabel'>
              <p>Your Name:</p>
              <input
                type='text'
                id='name'
                onChange={(e) => {
                  feedback.setName(e.target.value);
                }}
                value={feedback.userName}
              />
            </label>

          </Col>
        </Row>
        <Row>
          <Col xs={{ size: 4, offset: 4 }}>
            <label htmlFor='comments' id='commentsLabel'>
              <p>Comments:</p>
              <textarea
                onChange={(e) => {
                  feedback.setComments(e.target.value);
                }}
                value={feedback.comments}
              />
            </label>
          </Col>
        </Row>
        <Row>
          <Col xs={{ size: 4, offset: 4 }}>
            <button type='submit' className='btn btn-primary'>Submit</button>
          </Col>
        </Row>
      </form>
    );
  }
}

export default FeedbackForm;
