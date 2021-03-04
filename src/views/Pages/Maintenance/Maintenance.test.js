import React from 'react';
import ReactDOM from 'react-dom';
import Maintenance from './Maintenance';

it('renders without crashing', () => {
  const div = document.createElement('div');
  ReactDOM.render(<Maintenance />, div);
  ReactDOM.unmountComponentAtNode(div);
});
