import React, { Component } from 'react';
import TreeList, { 
	Column,
	ColumnChooser,
	ColumnFixing,
	HeaderFilter,
	Scrolling,
	SearchPanel,
	Selection,
} from 'devextreme-react/tree-list';
import { 
	Card, 
	CardBody, 
} from 'reactstrap';
import {
	pathAPIServer,
	pathReportParams,
} from '../../../Constants';
import './../../../../stylesTree.css';

class CardTreePeriod extends Component {

	constructor(props) {
		super(props);
		this.state = {
			isLoading: false,
			error: null,
			columns: [],
			rows: [],
			plant: [],
			startDate: new Date(),
			endDate: new Date(),
		};
		this.onDetailClick = this.onDetailClick.bind(this);
	}

	onDetailClick(e) {
		let startD = this.props.startDate
		let startDate = startD.getFullYear() + "-" + ("0"+(startD.getMonth()+1)).slice(-2) + "-" + ("0" + startD.getDate()).slice(-2)
		let endD = this.props.endDate
		let endDate = endD.getFullYear() + "-" + ("0"+(endD.getMonth()+1)).slice(-2) + "-" + ("0" + endD.getDate()).slice(-2)
	
		if (this.props.dataReportID === 31) {
			// console.log("/#/hr/hknedetail/"+startDate+"/"+endDate+"/"+e.row.data.ID)
			window.open("/#/hr/hknedetail/"+startDate+"/"+endDate+"/"+e.row.data.ID, "_blank")
		} else if (this.props.dataReportID === 39) {
			// console.log("/#/purchasing/batchsusutsupplierdetail/"+startDate+"/"+endDate+"/"+e.row.data.plant+"/"+e.row.data.kode_vendor)
			window.open("/#/purchasing/batchsusutsupplierdetail/"+startDate+"/"+endDate+"/"+e.row.data.plant+"/"+e.row.data.kode_vendor, "_blank")
		}
		e.event.preventDefault();
	}

	async componentDidMount() {
		this._isMounted = true;
		this.setState({ isLoading: true });

		// console.log(pathAPIServer + pathReportParams + this.props.dataReportID)
		await fetch(pathAPIServer + pathReportParams + this.props.dataReportID)
		.then(response => {
			if (response.ok) {
				return response.json();
			} else {
				throw new Error('Something went wrong while getting report parameters. Please contact the administrator.');
			}
		})
		.then(data => {
			
			if (this.props.startDate !== undefined) {
				var startD = this.props.startDate
				var startDate = startD.getFullYear() + "-" + ("0"+(startD.getMonth()+1)).slice(-2) + "-" + ("0" + startD.getDate()).slice(-2)
			}
			if (this.props.endDate !== undefined) {
				var endD = this.props.endDate
				var endDate = endD.getFullYear() + "-" + ("0"+(endD.getMonth()+1)).slice(-2) + "-" + ("0" + endD.getDate()).slice(-2)
			}
			var parAll = ''

			// console.log(this.props.viewMode)
			if (this.props.viewMode === 'Buyer') {
				let parBuyer = this.props.buyer.join()
				parAll = '/' + startDate + '/' + endDate + '/' + parBuyer
			} else if (this.props.viewMode === 'PlantBuyer') {
				let parPlant = this.props.plant.join()
				let parBuyer = this.props.buyer.join()
				parAll = '/' + startDate + '/' + endDate + '/' + parPlant + '/' + parBuyer
			} else if (this.props.viewMode === 'PlantOption') {
				let parPlant = this.props.plant.join()
				let parOpt = this.props.opt
				parAll = '/' + startDate + '/' + endDate + '/' + parPlant + '/' + parOpt
			} else if (this.props.viewMode === 'OptionTwoChecks') {
				let parOpt = this.props.opt
				let parOptAll = encodeURIComponent(this.props.optAll)
				parAll = '/' + startDate + '/' + endDate + '/' + parOpt + '/' + parOptAll
			} else if (this.props.viewMode === 'PlantOptionTwoChecks') {
				let parPlant = this.props.plant.join()
				let parOpt = this.props.opt
				let parOptAll = encodeURIComponent(this.props.optAll)
				parAll = '/' + startDate + '/' + endDate + '/' + parPlant + '/' + parOpt + '/' + parOptAll
			} else if (this.props.viewMode === 'Warehouse') {
				let parPlant = this.props.plant.join()
				let parWH = this.props.warehouse.join()
				parAll = '/' + startDate + '/' + endDate + '/' + parPlant + '/' + parWH
			} else if (this.props.viewMode === 'Divisi') {
				let parDivisi = this.props.divisi
				parAll = '/' + startDate + '/' + endDate + '/' + parDivisi
			} else if (this.props.plant === undefined && this.props.startDate === undefined) {
				parAll = ''
			} else if (this.props.plant === undefined) {
				parAll = '/' + startDate + '/' + endDate
			} else if (this.props.plant.length === 0) {
				parAll = '/' + startDate + '/' + endDate + '/DUM'
			} else {
				let parPlant = this.props.plant.join()
				parAll = '/' + startDate + '/' + endDate + '/' + parPlant
			}

			// console.log(pathAPIServer + this.props.pathReport + parAll)
			fetch(pathAPIServer + this.props.pathReport + parAll)
			.then(response => {
				if (response.ok) {
					return response.json();
				} else {
					throw new Error('Something went wrong while getting report data. Please contact the administrator.');
				}
			})
			.then(data2 => {
				if (this._isMounted) {
					// console.log(data.recordsets[5])
					// console.log(data2.recordset)
					this.setState({
						columns: data.recordsets[5],
						rows: data2.recordset,
						isLoading: false,
					})
					if (this.props.plant === undefined) {
						this.props.onFinish(data2.recordset)
						this.props.onColumns(data.recordsets[5])
					} else if (this.props.plant.length === 0) {
					} else {
						this.props.onFinish(data2.recordset)
						this.props.onColumns(data.recordsets[5])
					}
				}
			})
			.catch(error => this.setState({ error, isLoading: false }));

			// if (this.props.viewMode === 'Warehouse') {
			// 	let parPlant = this.props.plant.join()
			// 	let parWH = this.props.warehouse.join()
			// 	// console.log(pathAPIServer + this.props.pathReport + '/' + startDate + '/' + endDate + '/' + parPlant)
			// 	fetch(pathAPIServer + this.props.pathReport + '/' + startDate + '/' + endDate + '/' + parPlant + '/' + parWH)
			// 	.then(response => {
			// 		if (response.ok) {
			// 			return response.json();
			// 		} else {
			// 			throw new Error('Something went wrong while getting report data. Please contact the administrator.');
			// 		}
			// 	})
			// 	.then(data2 => {
			// 		if (this._isMounted) {
			// 			this.setState({
			// 				columns: data.recordsets[5],
			// 				rows: data2.recordset,
			// 				isLoading: false,
			// 			})
			// 			this.props.onFinish(data2.recordset)
			// 			this.props.onColumns(data.recordsets[5])
			// 		}
			// 	})
			// 	.catch(error => this.setState({ error, isLoading: false }));

			// } else if (this.props.viewMode === 'Buyer') {
			// 	let parBuyer = this.props.buyer.join()
			// 	// console.log(pathAPIServer + this.props.pathReport + '/' + startDate + '/' + endDate + '/' + parBuyer)
			// 	fetch(pathAPIServer + this.props.pathReport + '/' + startDate + '/' + endDate + '/' + parBuyer)
			// 	.then(response => {
			// 		if (response.ok) {
			// 			return response.json();
			// 		} else {
			// 			throw new Error('Something went wrong while getting report data. Please contact the administrator.');
			// 		}
			// 	})
			// 	.then(data2 => {
			// 		if (this._isMounted) {
			// 			this.setState({
			// 				columns: data.recordsets[5],
			// 				rows: data2.recordset,
			// 				isLoading: false,
			// 			})
			// 			this.props.onFinish(data2.recordset)
			// 			this.props.onColumns(data.recordsets[5])
			// 		}
			// 	})
			// 	.catch(error => this.setState({ error, isLoading: false }));

			// } else if (this.props.viewMode === 'PlantBuyer') {
			// 	let parPlant = this.props.plant.join()
			// 	let parBuyer = this.props.buyer.join()
			// 	// console.log(pathAPIServer + this.props.pathReport + '/' + startDate + '/' + endDate + '/' + parPlant + '/' + parBuyer)
			// 	fetch(pathAPIServer + this.props.pathReport + '/' + startDate + '/' + endDate + '/' + parPlant + '/' + parBuyer)
			// 	.then(response => {
			// 		if (response.ok) {
			// 			return response.json();
			// 		} else {
			// 			throw new Error('Something went wrong while getting report data. Please contact the administrator.');
			// 		}
			// 	})
			// 	.then(data2 => {
			// 		if (this._isMounted) {
			// 			this.setState({
			// 				columns: data.recordsets[5],
			// 				rows: data2.recordset,
			// 				isLoading: false,
			// 			})
			// 			this.props.onFinish(data2.recordset)
			// 			this.props.onColumns(data.recordsets[5])
			// 		}
			// 	})
			// 	.catch(error => this.setState({ error, isLoading: false }));

			// } else if (this.props.plant === undefined) {
			// 	// console.log(pathAPIServer + this.props.pathReport + '/' + startDate + '/' + endDate)
			// 	fetch(pathAPIServer + this.props.pathReport + '/' + startDate + '/' + endDate)
			// 	.then(response => {
			// 		if (response.ok) {
			// 			return response.json();
			// 		} else {
			// 			throw new Error('Something went wrong while getting report data. Please contact the administrator.');
			// 		}
			// 	})
			// 	.then(data2 => {
			// 		if (this._isMounted) {
			// 			this.setState({
			// 				columns: data.recordsets[5],
			// 				rows: data2.recordset,
			// 				isLoading: false,
			// 			})
			// 			this.props.onFinish(data2.recordset)
			// 			this.props.onColumns(data.recordsets[5])
			// 		}
			// 	})
			// 	.catch(error => this.setState({ error, isLoading: false }));

			// } else if (this.props.plant.length === 0) {
			// 	// console.log(pathAPIServer + this.props.pathReport + '/' + startDate + '/' + endDate + '/DUM')
			// 	fetch(pathAPIServer + this.props.pathReport + '/' + startDate + '/' + endDate + '/DUM')
			// 	.then(response => {
			// 		if (response.ok) {
			// 			return response.json();
			// 		} else {
			// 			throw new Error('Something went wrong while getting report data. Please contact the administrator.');
			// 		}
			// 	})
			// 	.then(data2 => {
			// 		if (this._isMounted) {
			// 			this.setState({
			// 				columns: data.recordsets[5],
			// 				rows: data2.recordset,
			// 				isLoading: false,
			// 			})
			// 		}
			// 	})
			// 	.catch(error => this.setState({ error, isLoading: false }));

			// } else {
			// 	let parPlant = this.props.plant.join()
			// 	// console.log(pathAPIServer + this.props.pathReport + '/' + startDate + '/' + endDate + '/' + parPlant)
			// 	fetch(pathAPIServer + this.props.pathReport + '/' + startDate + '/' + endDate + '/' + parPlant)
			// 	.then(response => {
			// 		if (response.ok) {
			// 			return response.json();
			// 		} else {
			// 			throw new Error('Something went wrong while getting report data. Please contact the administrator.');
			// 		}
			// 	})
			// 	.then(data2 => {
			// 		if (this._isMounted) {
			// 			this.setState({
			// 				columns: data.recordsets[5],
			// 				rows: data2.recordset,
			// 				isLoading: false,
			// 			})
			// 			this.props.onFinish(data2.recordset)
			// 			this.props.onColumns(data.recordsets[5])
			// 		}
			// 	})
			// 	.catch(error => this.setState({ error, isLoading: false }));
			// }
		})
		.catch(error => this.setState({ error, isLoading: false }));
	}

	componentWillUnmount() {
		this._isMounted = false;
	}

	render() {
		const { isLoading, error, rows, columns } = this.state

		if (error) {
			return <p>{error.message}</p>;
		}

		if (isLoading) {
			return <p>Loading ...</p>;
		}
		
		if (this.props.viewMode === 'Detail') {

			return (

				<Card>
					<CardBody>

						<TreeList
							dataSource={rows}
							showRowLines={true}
							showBorders={true}
							columnAutoWidth={true}
							wordWrapEnabled={true}
							allowColumnReordering={true}
							allowColumnResizing={true}
							columnResizingMode={'widget'}
							rowAlternationEnabled={true}
							defaultExpandedRowKeys={[]}
							defaultSelectedRowKeys={[]}
							keyExpr={'ID'}
							parentIdExpr={'parent'}
							id={'ID'}
							// height={360}
						>
							<Scrolling mode={'standard'} />
							<SearchPanel visible={true} width={250} />
							<HeaderFilter visible={true} />
							<Selection mode={'single'} />
							<ColumnChooser enabled={true} />
							<ColumnFixing enabled={true} />

							<Column
								caption='Detail'
								type={'buttons'}
								width={60}
								buttons={[{
									hint: 'Detail',
									icon: 'search',
									visible: true,
									onClick: this.onDetailClick}]}
							/>

							{
								columns.map((item, i) => {
									if (item.fixed === 'true') {
										var varfixed = true;
									}
									if (item.visible === 'false') {
										var varvis = false;
									}
									if (item.custom === 'thousands') {
										return (
											<Column key={item.name}
												dataField={item.name}
												caption={item.title}
												minWidth={item.width}
												dataType={item.type}
												visible={varvis}
												fixed={varfixed}
												customizeText={customThousands}
											>
											</Column>
										);
									} else if (item.custom === 'percentage') {
										return (
											<Column key={item.name}
												dataField={item.name}
												caption={item.title}
												minWidth={item.width}
												dataType={item.type}
												visible={varvis}
												fixed={varfixed}
												customizeText={customPercentage}
											>
											</Column>
										);
									} else if (item.custom === 'decimal') {
										return (
											<Column key={item.name}
												dataField={item.name}
												caption={item.title}
												minWidth={item.width}
												dataType={item.type}
												visible={varvis}
												fixed={varfixed}
												customizeText={customDecimal}
											>
											</Column>
										);
									} else if (item.custom === 'string') {
										return (
											<Column key={item.name}
												dataField={item.name}
												caption={item.title}
												minWidth={item.width}
												dataType={item.type}
												visible={varvis}
												fixed={varfixed}
											>
											</Column>
										);
									} else {
										return (
											<Column key={item.name}
												dataField={item.name}
												caption={item.title}
												minWidth={item.width}
												dataType={item.type}
												visible={varvis}
												fixed={varfixed}
												customizeText={customText}
											>
											</Column>
										);
									}
								})
							}

						</TreeList>

					</CardBody>
				</Card>
			);

		} else {

			return (

				<Card>
					<CardBody>

						<TreeList
							dataSource={rows}
							showRowLines={true}
							showBorders={true}
							columnAutoWidth={true}
							wordWrapEnabled={true}
							allowColumnReordering={true}
							allowColumnResizing={true}
							columnResizingMode={'widget'}
							rowAlternationEnabled={true}
							defaultExpandedRowKeys={[]}
							defaultSelectedRowKeys={[]}
							keyExpr={'ID'}
							parentIdExpr={'parent'}
							id={'ID'}
							// height={360}
							height={540}
						>
							<Scrolling mode={'standard'} />
							<SearchPanel visible={true} width={250} />
							<HeaderFilter visible={true} />
							<Selection mode={'single'} />
							<ColumnChooser enabled={true} />
							<ColumnFixing enabled={true} />

							{
								columns.map((item, i) => {
									if (item.fixed === 'true') {
										var varfixed = true;
									}
									if (item.visible === 'false') {
										var varvis = false;
									}
									if (item.custom === 'thousands') {
										return (
											<Column key={item.name}
												dataField={item.name}
												caption={item.title}
												minWidth={item.width}
												dataType={item.type}
												visible={varvis}
												fixed={varfixed}
												customizeText={customThousands}
											>
											</Column>
										);
									} else if (item.custom === 'percentage') {
										return (
											<Column key={item.name}
												dataField={item.name}
												caption={item.title}
												minWidth={item.width}
												dataType={item.type}
												visible={varvis}
												fixed={varfixed}
												customizeText={customPercentage}
											>
											</Column>
										);
									} else if (item.custom === 'decimal') {
										return (
											<Column key={item.name}
												dataField={item.name}
												caption={item.title}
												minWidth={item.width}
												dataType={item.type}
												visible={varvis}
												fixed={varfixed}
												customizeText={customDecimal}
											>
											</Column>
										);
									} else if (item.custom === 'string') {
										return (
											<Column key={item.name}
												dataField={item.name}
												caption={item.title}
												minWidth={item.width}
												dataType={item.type}
												visible={varvis}
												fixed={varfixed}
											>
											</Column>
										);
									} else if (item.custom === 'date') {
										return (
											<Column key={item.name}
												dataField={item.name}
												caption={item.title}
												minWidth={item.width}
												dataType={item.type}
												visible={varvis}
												fixed={varfixed}
												customizeText={customDate}
											>
											</Column>
										);
									} else {
										return (
											<Column key={item.name}
												dataField={item.name}
												caption={item.title}
												minWidth={item.width}
												dataType={item.type}
												visible={varvis}
												fixed={varfixed}
												customizeText={customText}
											>
											</Column>
										);
									}
								})
							}

						</TreeList>

					</CardBody>
				</Card>
			);

		}

	}
}

function customText(cellInfo,item) {
	// console.log(cellInfo)
	// console.log(item)
	// console.log(typeof cellInfo.value)
	// console.log(Number.isInteger(cellInfo.value))
	// console.log(!Number.isInteger(cellInfo.value))
	// console.log(cellInfo.valueText)
	// console.log(cellInfo.valueText.indexOf('%'))
	if (cellInfo.valueText === '') {
		return `${(cellInfo.valueText)}`;
	} else if (typeof cellInfo.value === 'string') {
		return `${(cellInfo.valueText)}`;
	} else if (typeof cellInfo.value === 'number') {
		if (Number.isInteger(cellInfo.value)) {
			var intFormatter = new Intl.NumberFormat('en-US', {
				style: 'decimal',
				minimumFractionDigits: 0,
				maximumFractionDigits: 0
			});
			return `${intFormatter.format(cellInfo.valueText)}`;
		} else if (!Number.isInteger(cellInfo.value)) {
			var decFormatter = new Intl.NumberFormat('en-US', {
				style: 'decimal',
				minimumFractionDigits: 1,
				maximumFractionDigits: 2
			});			
			return `${decFormatter.format(cellInfo.valueText)}`;
		}
	} else {
		return `${(cellInfo.valueText)}`;
	}
}

function customPercentage(cellInfo) {
	var percentageFormatter = new Intl.NumberFormat('en-US', {
		style: 'percent',
		minimumFractionDigits: 1,
		maximumFractionDigits: 1
	});
	if (cellInfo.valueText === '') {
		return `${(cellInfo.valueText)}`;
	} else {
		return `${percentageFormatter.format(cellInfo.valueText)}`;
	}
}

function customThousands(cellInfo) {
	var thousandsFormatter = new Intl.NumberFormat('en-US', {
		style: 'decimal',
		currency: 'IDR',
		minimumFractionDigits: 0,
		maximumFractionDigits: 0
	});
	if (cellInfo.valueText === '') {
		return `${(cellInfo.valueText)}`;
	} else {
		return `${thousandsFormatter.format(cellInfo.valueText)}`;
	}
}

function customDecimal(cellInfo) {
	var decimalFormatter = new Intl.NumberFormat('en-US', {
		style: 'decimal',
		minimumFractionDigits: 1,
		maximumFractionDigits: 2
	});
	if (cellInfo.valueText === '') {
		return `${(cellInfo.valueText)}`;
	} else {
		return `${decimalFormatter.format(cellInfo.valueText)}`;
	}
}

function customDate(cellInfo) {
	var dateFormatter = new Intl.DateTimeFormat('en-US');
	if (cellInfo.valueText === '') {
		return `${(cellInfo.valueText)}`;
	} else {
		return `${dateFormatter.format(cellInfo.valueText)}`;
	}
}

export default CardTreePeriod;
