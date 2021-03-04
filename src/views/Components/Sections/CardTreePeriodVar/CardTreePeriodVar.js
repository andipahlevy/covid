import React, { Component } from 'react';
// import { Template } from 'devextreme-react/core/template';
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

class CardTreePeriodVar extends Component {

	constructor(props) {
		super(props);
		this.state = {
			isLoading: false,
			error: null,
			columns: [],
			columnsBefore: [],
			columnsLoop: [],
			columnsAfter: [],
			rows: [],
			plant: [],
		};
	}

	async componentDidMount() {
		this._isMounted = true;
		this.setState({ isLoading: true });

		if (this.props.hold === undefined) {
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

				if (this.props.viewMode === 'Plastik') {
					// console.log(pathAPIServer + this.props.pathReport + '/' + this.props.plastic + '/' + startDate + '/' + endDate + '/DUM')
					fetch(pathAPIServer + this.props.pathReport + '/' + this.props.plastic + '/' + startDate + '/' + endDate + '/DUM')
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
								columnsBefore: data.recordsets[6],
								columnsLoop: data2.recordsets[1],
								columnsAfter: data.recordsets[8],
								rows: data2.recordsets[0],
								isLoading: false,
							})
						}
					})
					.catch(error => this.setState({ error, isLoading: false }));

				} else if (this.props.viewMode === 'Depo') {
					let parDepo = this.props.urldepo
					let parOpt = this.props.opt
					// console.log(pathAPIServer + this.props.pathReport + '/' + startDate + '/' + endDate + '/' + parDepo + '/' + parOpt)
					fetch(pathAPIServer + this.props.pathReport + '/' + startDate + '/' + endDate + '/' + parDepo + '/' + parOpt)
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
								columns: data2.recordsets[1],
								rows: data2.recordsets[0],
								isLoading: false,
							})
							this.props.onFinish(data2.recordsets[0])
							this.props.onColumns(data2.recordsets[1])
						}
					})
					.catch(error => this.setState({ error, isLoading: false }));

				} else if (this.props.viewMode === 'Package') {
					let parPackage = this.props.urlpack
					// console.log(pathAPIServer + this.props.pathReport + '/' + startDate + '/' + endDate + '/' + parPackage)
					fetch(pathAPIServer + this.props.pathReport + '/' + startDate + '/' + endDate + '/' + parPackage)
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
								columns: data2.recordsets[1],
								rows: data2.recordsets[0],
								isLoading: false,
							})
							this.props.onFinish(data2.recordsets[0])
							this.props.onColumns(data2.recordsets[1])
						}
					})
					.catch(error => this.setState({ error, isLoading: false }));

				} else if (this.props.viewMode === 'Plant') {
					let parPlant = this.props.plant.join()
					// console.log(pathAPIServer + this.props.pathReport + '/' + startDate + '/' + endDate + '/' + parPlant)
					fetch(pathAPIServer + this.props.pathReport + '/' + startDate + '/' + endDate + '/' + parPlant)
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
								columns: data2.recordsets[1],
								rows: data2.recordsets[0],
								isLoading: false,
							})
							this.props.onFinish(data2.recordsets[0])
							this.props.onColumns(data2.recordsets[1])
						}
					})
					.catch(error => this.setState({ error, isLoading: false }));

				} else if (this.props.viewMode === 'Option') {
					let parOpt = this.props.opt
					// console.log(pathAPIServer + this.props.pathReport + '/' + startDate + '/' + endDate + '/' + parOpt)
					fetch(pathAPIServer + this.props.pathReport + '/' + startDate + '/' + endDate + '/' + parOpt)
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
								columns: data2.recordsets[1],
								rows: data2.recordsets[0],
								isLoading: false,
							})
							this.props.onFinish(data2.recordsets[0])
							this.props.onColumns(data2.recordsets[1])
						}
					})
					.catch(error => this.setState({ error, isLoading: false }));

				} else if (this.props.viewMode === 'PlantOptionTwoChecks') {
					let parPlant = this.props.plant.join()
					let parOpt = this.props.opt
					let parOptAll = encodeURIComponent(this.props.optAll)
					let parAll = '/' + startDate + '/' + endDate + '/' + parPlant + '/' + parOpt + '/' + parOptAll
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
								columns: data2.recordsets[1],
								rows: data2.recordsets[0],
								isLoading: false,
							})
							this.props.onFinish(data2.recordsets[0])
							this.props.onColumns(data2.recordsets[1])
						}
					})
					.catch(error => this.setState({ error, isLoading: false }));

				} else if (this.props.viewMode === 'PlantVendorMatgrMat') {
					let parPlant = this.props.plant.join()
					let parVendor = this.props.vendor.join()
					let parMat = this.props.material.join()
					let parMatgr = this.props.materialgroup
					let parAll = '/' + startDate + '/' + endDate + '/' + parPlant + '/' + parVendor + '/' + parMatgr + '/' + parMat
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
								columns: data2.recordsets[1],
								rows: data2.recordsets[0],
								isLoading: false,
							})
							this.props.onFinish(data2.recordsets[0])
							this.props.onColumns(data2.recordsets[1])
						}
					})
					.catch(error => this.setState({ error, isLoading: false }));

				} else if (this.props.viewMode === 'Divisi') {
					let parDivisi = encodeURIComponent(this.props.divisi)
					// console.log(pathAPIServer + this.props.pathReport + '/' + startDate + '/' + endDate + '/' + parDivisi)
					fetch(pathAPIServer + this.props.pathReport + '/' + startDate + '/' + endDate + '/' + parDivisi)
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
								columns: data2.recordsets[1],
								rows: data2.recordsets[0],
								isLoading: false,
							})
							this.props.onFinish(data2.recordsets[0])
							this.props.onColumns(data2.recordsets[1])
						}
					})
					.catch(error => this.setState({ error, isLoading: false }));

				} else if (this.props.viewMode === 'Compact') {
					// let parPlant = this.props.plant.join()
					// console.log(pathAPIServer + this.props.pathReport + '/' + startDate + '/' + endDate)
					// fetch(pathAPIServer + this.props.pathReport + '/' + startDate + '/' + endDate + '/' + parPlant)
					fetch(pathAPIServer + this.props.pathReport + '/' + startDate + '/' + endDate)
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
								columns: data2.recordsets[1],
								rows: data2.recordsets[0],
								isLoading: false,
							})
							this.props.onFinish(data2.recordsets[0])
							this.props.onColumns(data2.recordsets[1])
						}
					})
					.catch(error => this.setState({ error, isLoading: false }));
				}
			})
			.catch(error => this.setState({ error, isLoading: false }));
		} else {
			this.setState({ isLoading: false });
		}
	}

	componentWillUnmount() {
		this._isMounted = false;
	}

	render() {
		const { isLoading, error, rows, columns, columnsBefore, columnsLoop, columnsAfter } = this.state

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
						height={360}
					>
						<Scrolling mode={'standard'} />
						<SearchPanel visible={true} width={250} />
						<HeaderFilter visible={true} />
						<Selection mode={'single'} />
						<ColumnChooser enabled={true} />
						<ColumnFixing enabled={true} />

						{
							columnsBefore.map((item, i) => {
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

						{
							columnsLoop.map((item, i) => {
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

						{
							columnsAfter.map((item, i) => {
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

export default CardTreePeriodVar;
