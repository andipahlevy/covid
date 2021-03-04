import React, { Component } from 'react';
import {
	Button,
} from 'reactstrap';

class ButtonProcess extends Component {

	constructor(props) {
		super(props);
		this.handleProcClick = this.handleProcClick.bind(this);
	}

	handleProcClick() {
		// console.log('handleProcClick',this.props.plant)
		var plant = this.props.plant
		this.props.onClick(plant);
	}

	render() {
		return (
			<Button id={this.props.id} onClick={this.handleProcClick} color="success">Process</Button>
		);
	}
}

export default ButtonProcess;
