import React, { Component } from 'react';
import { Badge, Button } from 'reactstrap';

class ContentHeader extends Component {

	render() {
		// const collapseType = this.props.collapseType
		switch(this.props.collapseType) {
			case 'collapseFT':
				return (
					<div>
						<i className="fa fa-align-justify"></i><strong> {this.props.dataTitle}</strong>
						<div className="card-header-actions">
							<Button color="link" className="card-header-action btn-minimize"
								onClick={this.props.collapseFT}>
								{this.props.arrowFT ? (
									<i className="icon-arrow-up"></i>
								) : (
									<i className="icon-arrow-down"></i>
								)}
							</Button>
							&nbsp;
							{/*link untuk guide*/}
							<Badge
								className="mr-1"
								href={this.props.pathHelp}
								color="warning">
								help
							</Badge>
						</div>
					</div>
				);
			case 'collapseFR':
				return (
					<div>
						<i className="fa fa-align-justify"></i><strong> {this.props.dataTitle}</strong>
						<div className="card-header-actions">
							<Button color="link" className="card-header-action btn-minimize"
								onClick={this.props.collapseFR}>
								{this.props.arrowFR ? (
									<i className="icon-arrow-up"></i>
								) : (
									<i className="icon-arrow-down"></i>
								)}
							</Button>
							&nbsp;
							{/*link untuk guide*/}
							<Badge
								className="mr-1"
								href={this.props.pathHelp}
								color="warning">
								help
							</Badge>
						</div>
					</div>
				);
			case 'collapseAT':
				return (
					<div>
						<i className="fa fa-align-justify"></i><strong> {this.props.dataTitle}</strong>
						<div className="card-header-actions">
							<Button color="link" className="card-header-action btn-minimize"
								onClick={this.props.collapseAT}>
								{this.props.arrowAT ? (
									<i className="icon-arrow-up"></i>
								) : (
									<i className="icon-arrow-down"></i>
								)}
							</Button>
							&nbsp;
							{/*link untuk guide*/}
							<Badge
								className="mr-1"
								href={this.props.pathHelp}
								color="warning">
								help
							</Badge>
						</div>
					</div>
				);
			case 'collapseAR':
				return (
					<div>
						<i className="fa fa-align-justify"></i><strong> {this.props.dataTitle}</strong>
						<div className="card-header-actions">
							<Button color="link" className="card-header-action btn-minimize"
								onClick={this.props.collapseAR}>
								{this.props.arrowAR ? (
									<i className="icon-arrow-up"></i>
								) : (
									<i className="icon-arrow-down"></i>
								)}
							</Button>
							&nbsp;
							{/*link untuk guide*/}
							<Badge
								className="mr-1"
								href={this.props.pathHelp}
								color="warning">
								help
							</Badge>
						</div>
					</div>
				);
			default:
				switch(this.props.pathHelp){
					case '':
						return (
							<div>
								<i className="fa fa-align-justify"></i><strong> {this.props.dataTitle}</strong>
							</div>
						);
					default:
						return (
							<div>
								<i className="fa fa-align-justify"></i><strong> {this.props.dataTitle}</strong>
								<div className="card-header-actions">
									<Badge
										className="mr-1"
										href={this.props.pathHelp}
										color="warning">
										help
									</Badge>
								</div>
							</div>
						);
				}
		}
	}
}

export default ContentHeader;
