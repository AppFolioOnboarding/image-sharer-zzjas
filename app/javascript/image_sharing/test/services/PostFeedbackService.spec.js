import { expect } from 'chai';
import { describe, it } from 'mocha';
import nock from 'nock';
import PostFeedbackService from '../../services/PostFeedbackService';

describe('PostFeedbackService', () => {
  it('should post to correct path with correct params', () => {
    const testOrigin = 'http://example.com';
    const postService = new PostFeedbackService();
    const windowMock = {
      location: {
        origin: testOrigin
      }
    };
    const testBody = {
      some: 'thing',
      something: 'else'
    };

    nock(testOrigin)
      .post('/api/feedbacks', testBody)
      .reply(200, { received: true });

    return postService
      .submitFeedback(testBody, windowMock)
      .then((res) => {
        expect(res.received).to.equal(true);
      });
  });
});
