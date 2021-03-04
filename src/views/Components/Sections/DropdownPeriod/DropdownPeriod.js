import React, { Component } from 'react';
import {
	Button,
	ButtonDropdown,
	DropdownItem,
	DropdownMenu,
	DropdownToggle,
	UncontrolledTooltip,
} from 'reactstrap';

class DropdownPeriod extends Component {

	constructor(props) {
		super(props);

		this.toggle = this.toggle.bind(this);
		this.handlePeriodClick = this.handlePeriodClick.bind(this);
		this.state = {
			dropdownOpen: false,
			dropdownSelected: '',
			tooltipPeriod: 'Click to select the period type',
			tooltipDaily: 'Select any date as the start and end of the period freely.',
			tooltipMonthly: 'Select the month, and the period will span from day 1 until the end of the month.',
		};
	}

	toggle() {
		this.setState({
			dropdownOpen: !this.state.dropdownOpen,
		});
	}

	handlePeriodClick(event) {
		this.setState({
			dropdownOpen: !this.state.dropdownOpen,
			dropdownSelected: event.target.innerText,
		});
		this.props.onPeriodChange(event.target.innerText);
	}

	componentDidMount() {
    this._isMounted = true;

    if (this._isMounted) {
			if (this.state.dropdownSelected === '') {
				this.setState({ dropdownSelected: this.props.period });
			}
    }
	}

  componentWillUnmount() {
    this._isMounted = false;
  }

	render() {
		const { tooltipPeriod, tooltipDaily, tooltipMonthly } = this.state

		if (this.props.periodMode !== '') {
			return (
				<Button id={'Tooltip-Period'}>{this.props.periodMode}
					<UncontrolledTooltip placement="top" target={'Tooltip-Period'}>
						The report is on a {this.props.periodMode} basis.
					</UncontrolledTooltip>
				</Button>
			);
		} else {
			return (
				<ButtonDropdown isOpen={this.state.dropdownOpen} toggle={this.toggle} id={'Tooltip-Period'}>
					<UncontrolledTooltip placement="top" target={'Tooltip-Period'}>
						{tooltipPeriod}
					</UncontrolledTooltip>
					<DropdownToggle caret>{this.state.dropdownSelected}</DropdownToggle>
					<DropdownMenu>
						<DropdownItem onClick={this.handlePeriodClick} id={'Tooltip-Daily'}>Daily</DropdownItem>
						<UncontrolledTooltip placement="top" target={'Tooltip-Daily'}>
							{tooltipDaily}
						</UncontrolledTooltip>
						<DropdownItem onClick={this.handlePeriodClick} id={'Tooltip-Monthly'}>Monthly</DropdownItem>
						<UncontrolledTooltip placement="top" target={'Tooltip-Monthly'}>
							{tooltipMonthly}
						</UncontrolledTooltip>
					</DropdownMenu>
				</ButtonDropdown>
			);
		}

	}
}

export default DropdownPeriod;
