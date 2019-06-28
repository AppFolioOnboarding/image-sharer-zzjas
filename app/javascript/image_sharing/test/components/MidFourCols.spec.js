import React from 'react';
import { shallow } from 'enzyme';
import { expect } from 'chai';
import { describe, it } from 'mocha';
import MidFourCols from '../../components/MidFourCols';

describe('<MidFourCols/>', () => {
  const wrapper = shallow(<MidFourCols />);

  it('should be at the center of the page', () => {
    expect(wrapper.find('Row')).to.have.lengthOf(1);
    expect(wrapper.find('Col').props().xs).to.deep.equal({ size: 4, offset: 4 });
  });
});
