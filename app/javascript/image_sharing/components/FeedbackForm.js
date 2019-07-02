import React, { Component } from 'react';
import { observer, inject } from 'mobx-react';
import MidFourCols from './MidFourCols';
import PostFeedbackService from '../services/PostFeedbackService';

@inject('stores')
@observer
class FeedbackForm extends Component {
  submitFeedback(feedback) {
    const postBody = {
      userName: feedback.userName,
      comments: feedback.comments
    };
    const postService = new PostFeedbackService();
    return postService.submitFeedback(postBody)
      .then(res => window.alert(`Thanks, ${res.userName}! Your feedback is received.`))
      .catch(() => window.alert('Something went wrong...'));
  }

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
          <button
            type='submit'
            className='btn btn-primary'
            onClick={() => this.submitFeedback(feedback)}
          >
            Submit
          </button>
        </MidFourCols>
      </form>
    );
  }
}

export default FeedbackForm;
