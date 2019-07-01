import React, { Component } from 'react';
import MidFourCols from './MidFourCols';

class Footer extends Component {
  /* Implement your Footer component here */
  render() {
    return (
      <MidFourCols>
        <footer>
          <p className='text-center' style={{ fontSize: '10px' }}>
            Copyright: AppFolio Inc. Onboarding
          </p>
        </footer>
      </MidFourCols>
    );
  }
}

export default Footer;
