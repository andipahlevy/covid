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

class CardTreePeriodDoughnut extends Component {

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
			
			let startD = this.props.startDate
			let startDate = startD.getFullYear() + "-" + ("0"+(startD.getMonth()+1)).slice(-2) + "-" + ("0" + startD.getDate()).slice(-2)
			let endD = this.props.endDate
			let endDate = endD.getFullYear() + "-" + ("0"+(endD.getMonth()+1)).slice(-2) + "-" + ("0" + endD.getDate()).slice(-2)
			var parAll = ''

			// console.log(this.props.viewMode)
			// if (this.props.viewMode === 'Input') {
			// 	let parDivisi = this.props.divisi.join()
			// 	parAll = '/' + startDate + '/' + endDate
			// } else if (this.props.viewMode === 'NusiraWorkshop') {
			// 	let parPlant = this.props.plant.join()
			// 	let parRoll = this.props.roll.join()
			// 	parAll = '/' + startDate + '/' + endDate + '/' + parPlant + '/' + parRoll
			// } else {
				parAll = '/' + startDate + '/' + endDate
			// }

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
					this.setState({
						columns: data.recordsets[5],
						rows: data2.recordsets[0],
						isLoading: false,
					})
					this.props.onFinish(data2.recordsets[0])
					this.props.onColumns(data.recordsets[5])
					this.props.forChart(data2.recordsets[1])
				}
			})
			.catch(error => this.setState({ error, isLoading: false }));

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
						height={365}
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
								if ( item.custom === 'thousands' ) {
									return (
										<Column key={item.name}
											dataField={item.name}
											caption={item.title}
											minWidth={item.width}
											dataType={item.type}
											visible={item.visible}
											fixed={varfixed}
											customizeText={customThousands}
										>
										</Column>
									);
								} else if ( item.custom === 'percentage' ) {
									return (
										<Column key={item.name}
											dataField={item.name}
											caption={item.title}
											minWidth={item.width}
											dataType={item.type}
											visible={item.visible}
											fixed={varfixed}
											customizeText={customPercentage}
										>
										</Column>
									);
								} else if ( item.custom === 'decimal' ) {
									return (
										<Column key={item.name}
											dataField={item.name}
											caption={item.title}
											minWidth={item.width}
											dataType={item.type}
											visible={item.visible}
											fixed={varfixed}
											customizeText={customDecimal}
										>
										</Column>
									);
								} else if ( item.custom === 'string' ) {
									return (
										<Column key={item.name}
											dataField={item.name}
											caption={item.title}
											minWidth={item.width}
											dataType={item.type}
											visible={item.visible}
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
											visible={item.visible}
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

export default CardTreePeriodDoughnut;
