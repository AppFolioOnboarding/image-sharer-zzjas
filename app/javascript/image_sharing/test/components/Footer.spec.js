import React from 'react';
import { shallow } from 'enzyme';
import { expect } from 'chai';
import { describe, it } from 'mocha';
import Footer from '../../components/Footer';

describe('<Footer/>', () => {
  const wrapper = shallow(<Footer />);

  it('should have a footer', () => {
    expect(wrapper.find('footer')).to.have.lengthOf(1);
  });

  it('should show copyright', () => {
    expect(wrapper.find('p').text()).to.equal('Copyright: AppFolio Inc. Onboarding');
  });

  it('should show text with fontSize 10px', () => {
    expect(wrapper.find('p').props().style).to.deep.equal({ fontSize: '10px' });
  });

  it('should be at the center of the page', () => {
    expect(wrapper.find('MidFourCols')).to.have.lengthOf(1);
    expect(wrapper.find('p').props().className).to.equal('text-center');
  });
});
