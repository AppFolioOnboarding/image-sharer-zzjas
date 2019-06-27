import React from 'react';
import { shallow } from 'enzyme';
import { expect } from 'chai';
import { describe, it } from 'mocha';
import { Provider } from 'mobx-react';
import App from '../../components/App';

describe('<App/>', () => {
  const wrapper = shallow(
    <Provider stores={{}}>
        <App/>
    </Provider>).dive().dive();

  it('should have a footer', () => {
    expect(wrapper.find('Footer')).to.have.lengthOf(1);
  });
});