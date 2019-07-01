import React, { Component } from 'react';
import { observer, inject } from 'mobx-react';
import MidFourCols from './MidFourCols';

@inject('stores')
@observer
class FeedbackForm extends Component {
  render() {
    const feedback = this.props.stores.feedbackStore;

    return (
      <form className='text-center'>
        <MidFourCols>
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
        </MidFourCols>
        <MidFourCols>
          <label htmlFor='comments' id='commentsLabel'>
            <p>Comments:</p>
            <textarea
              onChange={(e) => {
                feedback.setComments(e.target.value);
              }}
              value={feedback.comments}
            />
          </label>
        </MidFourCols>
        <MidFourCols>
          <button type='submit' className='btn btn-primary'>Submit</button>
        </MidFourCols>
      </form>
    );
  }
}

export default FeedbackForm;
