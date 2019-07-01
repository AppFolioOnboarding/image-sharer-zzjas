import React, { Component } from 'react';
import PropTypes from 'prop-types';
import MidFourCols from './MidFourCols';

class Header extends Component {
  static propTypes = {
    title: PropTypes.string.isRequired
  };

  render() {
    const title = this.props.title;
    return (
      <MidFourCols>
        <header>
          <h3 className='text-center'>
            {title}
          </h3>
        </header>
      </MidFourCols>
    );
  }
}

export default Header;
