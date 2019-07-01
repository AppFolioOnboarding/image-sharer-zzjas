import React from 'react';
import { shallow } from 'enzyme';
import { expect } from 'chai';
import { describe, it } from 'mocha';
import { Provider } from 'mobx-react';
import App from '../../components/App';
import FeedbackForm from '../../components/FeedbackForm';

describe('<App/>', () => {
  const provider = (
    <Provider stores={{
      feedbackStore: 'Test store'
    }}
    >
      <App />
    </Provider>
  );
  const wrapper = shallow(provider).dive().dive();

  it('should have a header with correct title', () => {
    expect(wrapper.find('Header').props().title).to.equal('Tell us what you think');
  });

  it('should have a footer', () => {
    expect(wrapper.find('Footer')).to.have.lengthOf(1);
  });

  it('should have a FeedbackForm', () => {
    expect(wrapper.find(FeedbackForm).dive()).to.have.lengthOf(1);
    expect(wrapper.find(FeedbackForm).dive().props().stores.feedbackStore)
      .to.equal('Test store');
  });
});
