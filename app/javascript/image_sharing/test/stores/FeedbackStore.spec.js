import { expect } from 'chai';
import { describe, it } from 'mocha';
import FeedbackStore from '../../stores/FeedbackStore';


describe('FeedbackStore', () => {
  const store = new FeedbackStore();
  const testName = 'this is a name';
  const testComments = 'this is a comment';

  it('should store name', () => {
    store.setName(testName);
    expect(store.userName).to.equal(testName);
  });

  it('should store comments', () => {
    store.setComments(testComments);
    expect(store.comments).to.equal(testComments);
  });
});
