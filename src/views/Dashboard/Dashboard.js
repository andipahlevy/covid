import React, { Component } from 'react';
import {
	Card,
	CardBody,
	CardHeader,
	Col,
	Collapse,
	Row,
	UncontrolledTooltip,
} from 'reactstrap';
import {
	ContentHeader,
	// WidgetTemplate,
} from '../Components';
import {
	pathAPIServer,
	pathAPPServer,
	// pathTemplateAvailable,
	// pathTemplateFavorite,
	pathReportAvailable,
	// pathReportFavorite,
} from '../Constants';

class Dashboard extends Component {
	_isMounted = false;

	constructor(props) {
		super(props);

		// this.toggleCollapseFT = this.toggleCollapseFT.bind(this);
		// this.toggleCollapseFR = this.toggleCollapseFR.bind(this);
		// this.toggleCollapseAT = this.toggleCollapseAT.bind(this);
		this.toggleCollapseAR = this.toggleCollapseAR.bind(this);
		this.state = {
			// collapseFT: true,
			// collapseFR: true,
			// collapseAT: true,
			collapseAR: true,

			dataUserID: 1,
			// bodyFT: [],
			// bodyFR: [],
			// bodyAT: [],
			bodyAR: [],
			isLoading: false,
			error: null
		};
	}

	loading = () => <div className="animated fadeIn pt-1 text-center">Loading...</div>

	// toggleCollapseFT = function() {
	// 	this.setState({ collapseFT: !this.state.collapseFT });
	// }

	// toggleCollapseFR = function() {
	// 	this.setState({ collapseFR: !this.state.collapseFR });
	// }

	// toggleCollapseAT = function() {
	// 	this.setState({ collapseAT: !this.state.collapseAT });
	// }

	toggleCollapseAR = function() {
		this.setState({ collapseAR: !this.state.collapseAR });
	}

	async componentDidMount() {
		this._isMounted = true;
		this.setState({ isLoading: true });

		// // Favorite templates
		// var bodyFT = []

		// await fetch(pathAPIServer + pathTemplateFavorite + this.state.dataUserID)
		// .then(response => {
		// 	if (response.ok) {
		// 		return response.json();
		// 	} else {
		// 		throw new Error('FT Something went wrong...');
		// 	}
		// })
		// .then(data => {
		// 	bodyFT = data.recordset.map((rs) => {
		// 		return(
		// 			<Col key={rs.Template_ID} sm="6" md="2">
		// 				<WidgetTemplate
		// 					style={{ height: 170 }}
		// 					command='Edit'
		// 					icon={rs.Template_Icon}
		// 					color={rs.Template_Color}
		// 					header={rs.Template_Name}
		// 					id={rs.Template_ID}
		// 					link={pathAPPServer + 'template/current/' + rs.Template_ID}
		// 					>{rs.Header}
		// 				</WidgetTemplate>
		// 			</Col>
		// 		)
		// 	})
		// })
		// .catch(error => this.setState({ error, isLoading: false }));

		// // Favorite reports
		// var Category = ""
		// var Cardful = []

		// await fetch(pathAPIServer + pathReportFavorite + this.state.dataUserID)
		// .then(response => {
		// 	if (response.ok) {
		// 		return response.json();
		// 	} else {
		// 		throw new Error('FR Something went wrong...');
		// 	}
		// })
		// .then(data => {
		// 	for (let i = 0; i < data.recordset.length; i++) {
		// 		var Table = []
		// 		if (Category !== data.recordsets[0][i].Category_Name) {
		// 			Table.push(<CardHeader key={'ch'+i+'-'+data.recordsets[0][i].Category_ID}>{data.recordsets[0][i].Category_Name}
		// 									</CardHeader>)
		// 			let Content = []
		// 			for (let j = i; j < data.recordset.length; j++) {
		// 				if (j === i) {
		// 					Content.push(
		// 						<Row key={'r'+i+'-'+data.recordsets[0][j].Report_ID}>
		// 							<UncontrolledTooltip placement="top" target={'i'+i+'-'+data.recordsets[0][j].Report_ID}>
		// 								Click to open report
		// 							</UncontrolledTooltip>
		// 							<a href={pathAPPServer + data.recordsets[0][j].Report_Link}
		// 								id={'i'+i+'-'+data.recordsets[0][j].Report_ID}>
		// 								<font color="009000">&#9656;&nbsp;{data.recordsets[0][j].Report_Name}</font>
		// 							</a>
		// 						</Row>
		// 					)
		// 					i = j
		// 				} else if (Category === data.recordsets[0][j].Category_Name) {
		// 					Content.push(
		// 						<Row key={'r'+i+'-'+data.recordsets[0][j].Report_ID}>
		// 							<UncontrolledTooltip placement="top" target={'i'+i+'-'+data.recordsets[0][j].Report_ID}>
		// 								Click to open report
		// 							</UncontrolledTooltip>
		// 							<a href={pathAPPServer + data.recordsets[0][j].Report_Link}
		// 								id={'i'+i+'-'+data.recordsets[0][j].Report_ID}>
		// 								<font color="009000">&#9656;&nbsp;{data.recordsets[0][j].Report_Name}</font>
		// 							</a>
		// 						</Row>
		// 					)
		// 					i = j
		// 				} else if (Category !== data.recordsets[0][j].Category_Name) {
		// 					i = j - 1
		// 					j = data.recordset.length - 1
		// 				} else {
		// 				}
		// 				Category = data.recordsets[0][j].Category_Name
		// 			}
		// 			Table.push(<CardBody key={'cb'+i+'-'+data.recordsets[0][i].Category_ID}>{Content}</CardBody>)
		// 		} else {
		// 		}
		// 		Category = data.recordsets[0][i].Category_Name
		// 		if (Table.length !== 0) {
		// 			Cardful.push(
		// 										<Col xs="12" sm="6" md="4" key={'cf'+i+'-'+data.recordsets[0][i].Category_ID}>
		// 											<Card key={i}>
		// 												{Table}
		// 											</Card>
		// 										</Col>
		// 									)
		// 		}
		// 	}
		// })
		// .catch(error => this.setState({ error, isLoading: false }));

		// // Available templates
		// var bodyAT = []

		// await fetch(pathAPIServer + pathTemplateAvailable + this.state.dataUserID)
		// .then(response => {
		// 	if (response.ok) {
		// 		return response.json();
		// 	} else {
		// 		throw new Error('AT Something went wrong...');
		// 	}
		// })
		// .then(data => {
		// 	bodyAT = data.recordset.map((rs) => {
		// 		return(
		// 			<Col key={rs.Template_ID} sm="6" md="2">
		// 				<WidgetTemplate
		// 					style={{ height: 170 }}
		// 					command='Open'
		// 					icon={rs.Template_Icon}
		// 					color={rs.Template_Color}
		// 					header={rs.Template_Name}
		// 					id={rs.Template_ID}
		// 					link={pathAPPServer + 'template/available/' + rs.Template_ID}
		// 					>{rs.Header}
		// 				</WidgetTemplate>
		// 			</Col>
		// 		)
		// 	})
		// })
		// .catch(error => this.setState({ error, isLoading: false }));

		// Available reports
		var CategoryAv = ""
		var CardfulAv = []

		await fetch(pathAPIServer + pathReportAvailable + this.state.dataUserID)
		.then(response => {
			if (response.ok) {
				return response.json();
			} else {
				throw new Error('AR Something went wrong...');
			}
		})
		.then(data => {
			for (let i = 0; i < data.recordset.length; i++) {
				var TableAv = []
				if (CategoryAv !== data.recordsets[0][i].Category_Name) {
					TableAv.push(<CardHeader key={'ch'+i+'-'+data.recordsets[0][i].Category_ID}>{data.recordsets[0][i].Category_Name}
											</CardHeader>)
					let Content = []
					for (let j = i; j < data.recordset.length; j++) {
						if (j === i) {
							Content.push(
								<Row key={'r'+i+'-'+data.recordsets[0][j].Report_ID}>
									<UncontrolledTooltip placement="top" target={'i'+i+'-'+data.recordsets[0][j].Report_ID}>
										Click to open report
									</UncontrolledTooltip>
									<a href={pathAPPServer + data.recordsets[0][j].Report_Link}
										id={'i'+i+'-'+data.recordsets[0][j].Report_ID}>
										<font color="009000">&#9656;&nbsp;{data.recordsets[0][j].Report_Name}</font>
									</a>
								</Row>
							)
							i = j
						} else if (CategoryAv === data.recordsets[0][j].Category_Name) {
							Content.push(
								<Row key={'r'+i+'-'+data.recordsets[0][j].Report_ID}>
									<UncontrolledTooltip placement="top" target={'i'+i+'-'+data.recordsets[0][j].Report_ID}>
										Click to open report
									</UncontrolledTooltip>
									<a href={pathAPPServer + data.recordsets[0][j].Report_Link}
										id={'i'+i+'-'+data.recordsets[0][j].Report_ID}>
										<font color="009000">&#9656;&nbsp;{data.recordsets[0][j].Report_Name}</font>
									</a>
								</Row>
							)
							i = j
						} else if (CategoryAv !== data.recordsets[0][j].Category_Name) {
							i = j - 1
							j = data.recordset.length - 1
						} else {
						}
						CategoryAv = data.recordsets[0][j].Category_Name
					}
					TableAv.push(<CardBody key={'cb'+i+'-'+data.recordsets[0][i].Category_ID}>{Content}</CardBody>)
				} else {
				}
				CategoryAv = data.recordsets[0][i].Category_Name
				if (TableAv.length !== 0) {
					CardfulAv.push(
												<Col xs="12" sm="6" md="4" key={'cf'+i+'-'+data.recordsets[0][i].Category_ID}>
													<Card key={i}>
														{TableAv}
													</Card>
												</Col>
												)
				}
			}
		})
		.catch(error => this.setState({ error, isLoading: false }));

		if (this._isMounted) {
			// this.setState({ bodyFT: bodyFT, bodyFR: Cardful, bodyAT: bodyAT, bodyAR: CardfulAv, isLoading: false });
			this.setState({ bodyAR: CardfulAv, isLoading: false });
		}
	}

	componentWillUnmount() {
		this._isMounted = false;
	}

	render() {
		// const titleFT = 'Favorite Templates';
		// const helpFT = '';
		// const titleFR = 'Favorite Reports';
		// const helpFR = '';
		// const titleAT = 'Available Templates';
		// const helpAT = '';
		const titleAR = 'Available Reports';
		const helpAR = '';

		// const { isLoading, error, bodyFT, bodyFR, bodyAT, bodyAR } = this.state
		const { isLoading, error, bodyAR } = this.state

		if (error) {
			return <p>{error.message}</p>;
		}

		if (isLoading) {
			return <p>Loading ...</p>;
		}

		return (
			<div className="animated fadeIn">
				<Row>
					<Col xs="12">

						{/*Favorite Templates*/}
						{/*
						<Card>
							<CardHeader>
								<ContentHeader
									dataTitle={titleFT}
									pathHelp={helpFT}
									collapseType="collapseFT"
									arrowFT={this.state.collapseFT}
									collapseFT={this.toggleCollapseFT.bind(this)}
								/>
							</CardHeader>
							<Collapse isOpen={this.state.collapseFT}>
								<CardBody>
									<Row>
										{bodyFT}
									</Row>
								</CardBody>
							</Collapse>
						</Card>
						*/}
					
						{/*Favorite Reports*/}
						{/*
						<Card>
							<CardHeader>
								<ContentHeader
									dataTitle={titleFR}
									pathHelp={helpFR}
									collapseType="collapseFR"
									arrowFR={this.state.collapseFR}
									collapseFR={this.toggleCollapseFR.bind(this)}
								/>
							</CardHeader>
							<Collapse isOpen={this.state.collapseFR}>
								<CardBody>
									<Row>
										{bodyFR}
									</Row>
								</CardBody>
							</Collapse>
						</Card>
						*/}

						{/*Available Templates*/}
						{/*
						<Card>
							<CardHeader>
								<ContentHeader
									dataTitle={titleAT}
									pathHelp={helpAT}
									collapseType="collapseAT"
									arrowAT={this.state.collapseAT}
									collapseAT={this.toggleCollapseAT.bind(this)}
								/>
							</CardHeader>
							<Collapse isOpen={this.state.collapseAT}>
								<CardBody>
									<Row>
										{bodyAT}
									</Row>
								</CardBody>
							</Collapse>
						</Card>
						*/}

						{/*Available Reports*/}
						<Card>
							<CardHeader>
								<ContentHeader
									dataTitle={titleAR}
									pathHelp={helpAR}
									collapseType="collapseAR"
									arrowAR={this.state.collapseAR}
									collapseAR={this.toggleCollapseAR.bind(this)}
								/>
							</CardHeader>
							<Collapse isOpen={this.state.collapseAR}>
								<CardBody>
									<Row>
										{bodyAR}
									</Row>
								</CardBody>
							</Collapse>
						</Card>

					</Col>
				</Row>
			</div>
		);
	}
}

export default Dashboard;
