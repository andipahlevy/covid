import React, { Component } from "react";
import CheckboxTree from 'react-checkbox-tree';
import 'react-checkbox-tree/lib/react-checkbox-tree.css';

class CheckboxFormDivisi extends Component {

	constructor(props) {
		super(props);
		this.handleChkChange = this.handleChkChange.bind(this);
		this.handleExpChange = this.handleExpChange.bind(this);
	}

	handleChkChange(checked) {
		this.props.onCheckChange(checked);
	}

	handleExpChange(expanded) {
		this.props.onExpandChange(expanded);
	}

	render() {
		return (
			<CheckboxTree
				nodes={this.props.arrdivisi}
				checked={this.props.checked}
				expanded={this.props.expanded}
				onCheck={checked => this.handleChkChange(checked)}
				onExpand={expanded => this.handleExpChange(expanded)}
			/>
		);
	}
}

export default CheckboxFormDivisi;
