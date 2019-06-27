import React from 'react';
import { shallow } from 'enzyme';
import { expect } from 'chai';
import { describe, it } from 'mocha';
import Header from '../../components/Header';

describe('<Header/>', () => {
  const title = 'Title for test';
  const wrapper = shallow(<Header title={title} />);

  it('should have a header', () => {
    expect(wrapper.find('header')).to.have.lengthOf(1);
  });

  it('should show title', () => {
    expect(wrapper.find('h3').text()).to.equal(title);
  });

  it('should be at the center of the page', () => {
    expect(wrapper.find('Row')).to.have.lengthOf(1);
    expect(wrapper.find('Col').props().xs).to.deep.equal({ size: 4, offset: 4 });
    expect(wrapper.find('h3').props().className).to.equal('text-center');
  });
});
