/* eslint-env mocha */
import React from 'react';
import { shallow } from 'enzyme';
import { expect } from 'chai';
import { describe, it } from 'mocha';
import sinon from 'sinon';
import { Provider } from 'mobx-react';
import FeedbackForm from '../../components/FeedbackForm';
import PostFeedbackService from '../../services/PostFeedbackService';

describe('<FeedbackForm />', () => {
  const testValue = 'Test string and this should bee uN1quE.';
  const mockStore = {
    userName: testValue,
    comments: testValue,
    setName: () => {},
    setComments: () => {}
  };

  const e = {
    target: {
      value: testValue
    }
  };

  const provider = mock => (
    <Provider stores={{
      feedbackStore: mock
    }}
    >
      <FeedbackForm />
    </Provider>
  );

  let wrapper;
  let setNameStub;
  let setCommentsStub;

  afterEach(() => {
    sinon.restore();
  });

  beforeEach(() => {
    wrapper = shallow(provider(mockStore)).dive().dive();
    setNameStub = sinon.stub(mockStore, 'setName');
    setCommentsStub = sinon.stub(mockStore, 'setComments');
  });


  it('should show everything at the center of the page', () => {
    expect(wrapper.find('MidFourCols')).to.have.lengthOf(3);
  });

  describe('Name field', () => {
    it('should show the label and text input', () => {
      expect(wrapper.find('#nameLabel').find('p').text()).to.equal('Your Name:');
      expect(wrapper.find('#nameLabel').find('input')).to.have.lengthOf(1);
    });

    it('should call store.setName on change', () => {
      wrapper.find('#nameLabel').find('input').props().onChange(e);
      sinon.assert.calledWith(setNameStub, testValue);
    });

    it('should show store.userName in input box', () => {
      mockStore.userName = `userName: ${testValue}`;
      wrapper.setProps(mockStore);
      expect(wrapper.find('#nameLabel').find('input').props().value)
        .to.equal(mockStore.userName);
    });
  });

  describe('Comments field', () => {
    it('should show the label and textarea', () => {
      expect(wrapper.find('#commentsLabel').find('p').text()).to.equal('Comments:');
      expect(wrapper.find('#commentsLabel').find('textarea')).to.have.lengthOf(1);
    });

    it('should call store.setComments on change', () => {
      wrapper.find('#commentsLabel').find('textarea').props().onChange(e);
      sinon.assert.calledWith(setCommentsStub, testValue);
    });

    it('should show store.comments in input box', () => {
      mockStore.comments = `comments: ${testValue}`;
      wrapper.setProps(mockStore);
      expect(wrapper.find('#commentsLabel').find('textarea').props().value)
        .to.equal(mockStore.comments);
    });
  });

  describe('Submit button', () => {
    it('should show the submit button', () => {
      expect(wrapper.find('button').text()).to.equal('Submit');
    });

    it('should show success alert when have name', () => {
      const alertStub = sinon.stub(window, 'alert');
      const testName = 'Test NaME';

      sinon.stub(PostFeedbackService.prototype, 'submitFeedback')
        .returns(Promise.resolve({ userName: testName }));

      wrapper.find('button').props().onClick().then(() => {
        sinon.assert.calledWith(alertStub, `Thanks, ${testName}! Your feedback is received.`);
      });
    });

    it('should show failure alert on submission error', () => {
      const alertStub = sinon.stub(window, 'alert');

      sinon.stub(PostFeedbackService.prototype, 'submitFeedback').returns(Promise.reject());

      wrapper.find('button').props().onClick().then(() => {
        sinon.assert.calledWith(alertStub, 'Something went wrong...');
      });
    });
  });
});
