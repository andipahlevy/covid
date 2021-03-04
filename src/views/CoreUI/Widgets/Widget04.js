import React, { Component } from 'react';
import PropTypes from 'prop-types';
import {
  Card,
  CardBody,
  CardFooter,
  CardLink,
  // CardTitle,
} from 'reactstrap';
import classNames from 'classnames';
import { mapToCssModules } from 'reactstrap/lib/utils';

const propTypes = {
  command: PropTypes.string,
  header: PropTypes.string,
  icon: PropTypes.string,
  link: PropTypes.string,
  color: PropTypes.string,
  children: PropTypes.node,
  className: PropTypes.string,
  cssModule: PropTypes.object,
  invert: PropTypes.bool,
};

const defaultProps = {
  command: 'Info',
  header: '123',
  icon: 'icon-people',
  link: '#',
  color: 'info',
  children: '123',
  invert: false,
};

class Widget04 extends Component {
  render() {
    const { header, className, cssModule, command, icon, color, link, children, invert, ...attributes } = this.props;
    const card = { style: '', bgColor: 'bg-' + color };

    if (invert) {
      card.style = 'text-white';
      card.bgColor = 'bg-' + color;
    }

    const classes = mapToCssModules(classNames(className, card.style, card.bgColor), cssModule);

    return (
      <Card className={classes} outline color={color} {...attributes}>
        <CardBody>
          <div className="h7 mb-0" style={{ color: '#FFF' }}>{header}</div>
        </CardBody>
        <CardFooter color={color}>
          <CardLink className="h7 mb-0" href={link}>{command}</CardLink>
        </CardFooter>
        <CardFooter color={color}>
          <CardLink className="h7 mb-0" href={link}>{command}</CardLink>
        </CardFooter>
      </Card>
    );

  }
}

Widget04.propTypes = propTypes;
Widget04.defaultProps = defaultProps;

export default Widget04;