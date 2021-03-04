import React, { Component } from 'react';
import PropTypes from 'prop-types';
import {
  Button,
  ButtonToolbar,
  Card,
  CardBody,
  CardFooter,
  UncontrolledTooltip,
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

class WidgetReport extends Component {
  render() {
    const {
      order,
      header,
      className,
      cssModule,
      color,
      linkremove,
      linkup,
      linkdown,
      children,
      invert,
      ...attributes
    } = this.props;
    const card = { style: '', bgColor: 'bg-' + color };

    if (invert) {
      card.style = 'text-white';
      card.bgColor = 'bg-' + color;
    }

    const classes = mapToCssModules(classNames(className, card.style, card.bgColor), cssModule);

    return (
      <Card className={classes} outline color={color} {...attributes}>
        <CardBody>
          <div className="h7 mb-0" color="FFFFFF">{header}</div>
        </CardBody>
        <CardFooter color={color}>
          <ButtonToolbar className="justify-content-between">
            <UncontrolledTooltip placement="top" target={"Left"+order}>Move report 1 position to the left</UncontrolledTooltip>
            <a href={linkup} id={"Left"+order}><Button size="sm" block outline color="danger">
              <i className="fa fa-arrow-left"></i>
            </Button></a>

            <UncontrolledTooltip placement="top" target={"Remove"+order}>Remove report from current template</UncontrolledTooltip>
            <a href={linkremove} id={"Remove"+order}><Button size="sm" block outline color="danger">
               <i className="fa fa-times"></i>
            </Button></a>

            <UncontrolledTooltip placement="top" target={"Right"+order}>Move report 1 position to the right</UncontrolledTooltip>
            <a href={linkdown} id={"Right"+order}><Button size="sm" block outline color="danger">
              <i className="fa fa-arrow-right"></i>
            </Button></a>
          </ButtonToolbar>
        </CardFooter>
      </Card>
    );

  }
}

WidgetReport.propTypes = propTypes;
WidgetReport.defaultProps = defaultProps;

export default WidgetReport;