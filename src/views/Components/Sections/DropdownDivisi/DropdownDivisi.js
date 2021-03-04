import React, { Component } from 'react';
import {
	ButtonDropdown,
	DropdownMenu,
	DropdownToggle,
} from 'reactstrap';
import { CheckboxFormDivisi } from "../../../Components";
import './dropdownwidth.css';
import {
	pathAPIServer,
	pathDivisi,
} from '../../../Constants';

class DropdownDivisi extends Component {

	constructor(props) {
		super(props);
		this.toggle = this.toggle.bind(this);
		this.handleCheckChange = this.handleCheckChange.bind(this);
		this.handleExpandChange = this.handleExpandChange.bind(this);
		this.state = {
			dropdownOpen: false,
			arrdivisi: [],
			checked: [],
			expanded: [],
		};
	}

	toggle() {
		this.setState({
			dropdownOpen: !this.state.dropdownOpen,
		});
	}

	handleCheckChange(checked) {
		this.setState({ checked }, function() {
			this.props.onCheckedChange(checked);
		})
	}

	handleExpandChange(expanded) {
		this.setState({ expanded }, function() {
			this.props.onExpandedChange(expanded);
		});
	}

	componentDidMount() {
		this._isMounted = true;

		var arrdivisi = [];

		if (this.state.arrdivisi.length === 0) {

			var divisi = '';
			var childdivisi = [];

			fetch(pathAPIServer + pathDivisi)
			.then(response => {
				if (response.ok) {
					return response.json();
				} else {
					throw new Error('Something went wrong...');
				}
			})
			.then(data => {
				for (var idxDivisi = 0, lenDivisi = data.recordsets[0].length; idxDivisi < lenDivisi; idxDivisi++) {
					divisi = data.recordsets[0][idxDivisi].divisi;
					childdivisi.push(
													{ value: divisi, label: divisi }
												);
				};

				arrdivisi.push(
											{
												value: 'ALL', label: 'ALL', children: childdivisi
											}
										)

				if (this._isMounted) {
					this.setState({ arrdivisi: arrdivisi, checked: this.props.divisi, expanded: this.props.expand });
				}
			})

		} else {

			if (this._isMounted){
				this.setState({ checked: this.props.divisi, expanded: this.props.expand });
			}

		}
	}

	componentWillUnmount() {
		this._isMounted = false;
	}

	render() {
		const { isLoading, error, checked, expanded, arrdivisi } = this.state

		if (error) {
			return <p>{error.message}</p>;
		}

		if (isLoading) {
			return <p>Loading ...</p>;
		}

		return (
				<ButtonDropdown isOpen={this.state.dropdownOpen} toggle={this.toggle}>
					<DropdownToggle caret>Divisi</DropdownToggle>
					<DropdownMenu
						modifiers={{
							setMaxHeight: {
								enabled: true,
								order: 890,
								fn: (data) => {
									return {
										...data,
										styles: {
											...data.styles,
											overflow: 'auto',
											maxHeight: 300,
											width: 500
										},
									};
								},
							},
						}}
					>
						<CheckboxFormDivisi
							arrdivisi={arrdivisi}
							checked={checked}
							expanded={expanded}
							onCheckChange={this.handleCheckChange}
							onExpandChange={this.handleExpandChange}
						/>
					</DropdownMenu>
				</ButtonDropdown>
		);
	}
}

export default DropdownDivisi;
