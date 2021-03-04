import React, { Component } from 'react';
import {
	Card,
	CardBody,
	CardHeader,
	Col,
	Row,
} from 'reactstrap';
import {
	ContentHeader,
	// FavoriteAdd,
	// FavStatusGet,
} from '../../../Components';
import {
	pathAPIServer,
	pathReportParams,
} from '../../../Constants';

import {
	// Column,
	DataTypeProvider,
	DataTypeProviderProps,
	FilteringState,
	GroupingState,
	IntegratedFiltering,
	IntegratedGrouping,
	// IntegratedPaging,
	IntegratedSorting,
	IntegratedSummary,
	// PagingState,
	SortingState,
	SummaryState,
} from "@devexpress/dx-react-grid";
import {
	ColumnChooser,
	DragDropProvider,
	Grid,
	GroupingPanel,
	// PagingPanel,
	// Table,
	TableColumnReordering,
	// TableColumnResizing,
	TableColumnVisibility,
	TableFilterRow,
	TableGroupRow,
	TableHeaderRow,
	TableSummaryRow,
	Toolbar,
	VirtualTable,
} from "@devexpress/dx-react-grid-bootstrap4";

const summaryCalculator = (type, rows, getValue) => {
	if (type === 'median') {
		if (!rows.length) {
			return null;
		}
		const sortedRows = rows.sort((a, b) => getValue(a) - getValue(b));
		if (rows.length % 2 === 1) {
			return getValue(sortedRows[(sortedRows.length + 1) / 2 - 1]);
		}
		const halfIndex = sortedRows.length / 2;
		return (getValue(sortedRows[halfIndex - 1]) + getValue(sortedRows[halfIndex])) / 2;    
	}
	if (type === 'weight') {
		if (!rows.length) {
			return null;
		}
		return rows.reduce(function (acc, row) {
			return acc + getValue(row);
		}, 0) / rows.reduce(function (acc, row) {
			if (getValue(row) === null) {
				return acc;
			}
			return acc + 1;
		}, 0)
		;
	}
	if (type === 'grand') {
		const grand = rows.reduce(function (acc, row) { return acc + getValue(row); }, 0)
		return grand;
	}
	const result = IntegratedSummary.defaultCalculator(type, rows, getValue)
	return result;
	// return IntegratedSummary.defaultCalculator(type, rows, getValue);
};

const messages = {
	median: 'Median',
	weight: 'Avg',
	grand: 'Sum',
};

const availableFilterOperations : string[] = [
	// 'equal', 'notEqual',
	'greaterThan', 'greaterThanOrEqual',
	'lessThan', 'lessThanOrEqual',
];

var currencyFormatter = new Intl.NumberFormat('en-US', {
	style: 'currency',
	currency: 'IDR',
	minimumFractionDigits: 0,
	maximumFractionDigits: 0
});

const CurrencyFormatter: React.ComponentType<DataTypeProvider.ValueFormatterProps> =
	({ value } : DataTypeProvider.ValueFormatterProps) =>
		{if (value !== null) {
			return <span>{currencyFormatter.format(value)}</span>;
		} else {
			return null;
		}}

const CurrencyTypeProvider: React.ComponentType<DataTypeProviderProps> =
	(props: DataTypeProviderProps) => (
		<DataTypeProvider
			formatterComponent={CurrencyFormatter}
			availableFilterOperations={availableFilterOperations}
			{...props}
		/>
);

var thousandsFormatter = new Intl.NumberFormat('en-US', {
	style: 'decimal',
	currency: 'IDR',
	minimumFractionDigits: 0,
	maximumFractionDigits: 0
});

const ThousandsFormatter: React.ComponentType<DataTypeProvider.ValueFormatterProps> =
	({ value } : DataTypeProvider.ValueFormatterProps) =>
		{if (value !== null) {
			return <span>{thousandsFormatter.format(value)}</span>;
		} else {
			return null;
		}}

const ThousandsTypeProvider: React.ComponentType<DataTypeProviderProps> =
	(props: DataTypeProviderProps) => (
		<DataTypeProvider
			formatterComponent={ThousandsFormatter}
			availableFilterOperations={availableFilterOperations}
			{...props}
		/>
);

var decimalFormatter = new Intl.NumberFormat('en-US', {
	style: 'decimal',
	minimumFractionDigits: 2,
	maximumFractionDigits: 2
});

const DecimalFormatter: React.ComponentType<DataTypeProvider.ValueFormatterProps> =
	({ value } : DataTypeProvider.ValueFormatterProps) =>
		{if (value !== null) {
			return <span>{decimalFormatter.format(value)}</span>;
		} else {
			return null;
		}}

const DecimalTypeProvider: React.ComponentType<DataTypeProviderProps> =
	(props: DataTypeProviderProps) => (
		<DataTypeProvider
			formatterComponent={DecimalFormatter}
			availableFilterOperations={availableFilterOperations}
			{...props}
		/>
);

var percentageFormatter = new Intl.NumberFormat('en-US', {
	style: 'percent',
	minimumFractionDigits: 1,
	maximumFractionDigits: 1
});

const PercentageFormatter: React.ComponentType<DataTypeProvider.ValueFormatterProps> =
	({ value } : DataTypeProvider.ValueFormatterProps) =>
		{if (value !== null) {
			return <span>{percentageFormatter.format(value)}</span>;
		} else {
			return null;
		}}

const PercentageTypeProvider: React.ComponentType<DataTypeProviderProps> =
	(props: DataTypeProviderProps) => (
		<DataTypeProvider
			formatterComponent={PercentageFormatter}
			availableFilterOperations={availableFilterOperations}
			{...props}
		/>
);

const DateFormatter: React.ComponentType<DataTypeProvider.ValueFormatterProps> =
	({ value } : DataTypeProvider.ValueFormatterProps) =>
		{if (value !== null) {
			return <span>{(value.slice(0,10))}</span>;
		} else {
			return null;
		}}

const DateTypeProvider: React.ComponentType<DataTypeProviderProps> =
	(props: DataTypeProviderProps) => (
		<DataTypeProvider
			formatterComponent={DateFormatter}
			availableFilterOperations={availableFilterOperations}
			{...props}
		/>
);

const getColor = (amount: number) : string => {
	if (amount <= 2) {
		return '#34a209';
	}
	if (amount <= 4) {
		return '#dacc11';
	}
	return '#e61d17';
};

const ColorFormatter: React.ComponentType<DataTypeProvider.ValueFormatterProps> =
	({ value } : DataTypeProvider.ValueFormatterProps) => <b style={{ color: getColor(value) }}>{value}</b>;

const ColorTypeProvider: React.ComponentType<DataTypeProviderProps> =
	(props: DataTypeProviderProps) => (
		<DataTypeProvider
			formatterComponent={ColorFormatter}
			availableFilterOperations={availableFilterOperations}
			{...props}
		/>
);

const ViewNote = (note) => {
	if (note === '' || note === undefined) {
		return;
	} else {
		return (
			<p>{note.note}</p>
		);
	}
}

class CardReportPeriod extends Component {

	constructor(props) {
		super(props);
		this.state = {
			isLoading: false,
			error: null,

			// dataFav: null,
			columns: [],
			rows: [],
			grouping: [],
			groupSummaryItems: [],
			totalSummaryItems: [],
			tableColumnExtensions: [],
			pageSizes: [5, 10, 20],
			hiddenColumnNames: [],
			currencyColumns: [],
			thousandsColumns: [],
			decimalColumns: [],
			percentageColumns: [],
			dateColumns: [],
			colorColumns: [],
		};
		// this.changeSelection = selection => this.setState({ selection });
		this.changeSorting = sorting => this.setState({ sorting });
		this.hiddenColumnNamesChange = hiddenColumnNames => {
			this.setState({ hiddenColumnNames });
		};
		this.handleValueChange = this.handleValueChange.bind(this);
		// this.handleFavClick = this.handleFavClick.bind(this);
	}

	handleValueChange(valTotal) {
		this.props.onValueChange(valTotal);
	}
	
	// handleFavClick(fav) {
	// 	this.setState({ dataFav: fav })
	// }

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
			const ArrayKolom = data.recordsets[4]
			var ArrCur = []
			var ArrTho = []
			var ArrDec = []
			var ArrPct = []
			var ArrDte = []
			var ArrCol = []
			for (var i = 0, n = ArrayKolom.length; i < n; i++) {
					var s = ArrayKolom[i].Kolom;
					var t = ArrayKolom[i].Format;
					if (t==="currency") {
						ArrCur.push(s)
					} else if (t==="thousands") {
						ArrTho.push(s)
					} else if (t==="decimal") {
						ArrDec.push(s)
					} else if (t==="percentage") {
						ArrPct.push(s)
					}	else if (t==="date") {
						ArrDte.push(s)
					}	else if (t==="color") {
						ArrCol.push(s)
					}
			}

			let startD 		= (this.props.startDate !== undefined)
										? this.props.startDate
										: new Date()
			let startDate = startD.getFullYear() + "-" + ("0"+(startD.getMonth()+1)).slice(-2) + "-" + ("0" + startD.getDate()).slice(-2)

			let endD 			= (this.props.endDate !== undefined)
										? this.props.endDate
										: new Date()
			let endDate 	= endD.getFullYear() + "-" + ("0"+(endD.getMonth()+1)).slice(-2) + "-" + ("0" + endD.getDate()).slice(-2)

			let startDt 	= (this.props.startDt !== undefined)
										? this.props.startDt
										: new Date()

			let endDt 		= (this.props.endDt !== undefined)
										? this.props.endDt
										: new Date()

			let companyID	= (this.props.companyID !== undefined)
										? this.props.companyID
										: undefined

			// console.log(this.props.paramsList)
			if (this.props.paramsList === 'materialtype,sumtype,datetype,from,to' || 
					this.props.paramsList === 'sumtype,datetype,from,to') {

				// console.log(pathAPIServer + this.props.pathReport + '/' + startDate + '/' + endDate)
				fetch(pathAPIServer + this.props.pathReport + '/' + startDate + '/' + endDate)
				.then(response => {
					if (response.ok) {
						return response.json();
					} else {
						throw new Error('Something went wrong while getting report data. Please contact the administrator.');
					}
				})
				.then(data2 => {
					// FavStatusGet(pathAPIServer,this.props.dataUserID,this.props.dataReportID)
					// .then(data3 => {
					if (this._isMounted) {
						this.setState({
							// dataFav: data3[0].FavStatus,
							columns: data.recordsets[0],
							groupSummaryItems: data.recordsets[1],
							totalSummaryItems: data.recordsets[2],
							tableColumnExtensions: data.recordsets[3],
							currencyColumns: ArrCur,
							thousandsColumns: ArrTho,
							decimalColumns: ArrDec,
							percentageColumns: ArrPct,
							dateColumns: ArrDte,
							colorColumns: ArrCol,
							rows: data2.recordset,
							isLoading: false,
						})
					}
					// })
					if (data2.recordsets[1] !== undefined) {
						let arrTotal = data2.recordsets[1]
						let objTotal = arrTotal.reduce((acc, val) => {
															return acc + val;
														});
						let valTotal = (objTotal.GrandTotal === null)
														? 0
														: objTotal.GrandTotal
						this.handleValueChange(valTotal)
					}
				})
				.catch(error => this.setState({ error, isLoading: false }));

			} else if (this.props.paramsList === 'from,to') {

				// console.log(pathAPIServer + this.props.pathReport + '/' + startDate + '/' + endDate)
				fetch(pathAPIServer + this.props.pathReport + '/' + startDate + '/' + endDate)
				.then(response => {
					if (response.ok) {
						return response.json();
					} else {
						throw new Error('Something went wrong while getting report data. Please contact the administrator.');
					}
				})
				.then(data2 => {
					// FavStatusGet(pathAPIServer,this.props.dataUserID,this.props.dataReportID)
					// .then(data3 => {
					if (this._isMounted) {
						this.setState({
							// dataFav: data3[0].FavStatus,
							columns: data.recordsets[0],
							groupSummaryItems: data.recordsets[1],
							totalSummaryItems: data.recordsets[2],
							tableColumnExtensions: data.recordsets[3],
							currencyColumns: ArrCur,
							thousandsColumns: ArrTho,
							decimalColumns: ArrDec,
							percentageColumns: ArrPct,
							dateColumns: ArrDte,
							colorColumns: ArrCol,
							rows: data2.recordset,
							isLoading: false,
						})
					}
					// })
					if (data2.recordsets[1] !== undefined) {
						let arrTotal = data2.recordsets[1]
						let objTotal = arrTotal.reduce((acc, val) => {
															return acc + val;
														});
						let valTotal = (objTotal.GrandTotal === null)
														? 0
														: objTotal.GrandTotal
						this.handleValueChange(valTotal)
					}
				})
				.catch(error => this.setState({ error, isLoading: false }));

			} else if (this.props.paramsList === 'from,to,id') {

				// console.log(pathAPIServer + this.props.pathReport + '/' + startDt + '/' + endDt + '/' + companyID)
				fetch(pathAPIServer + this.props.pathReport + '/' + startDt + '/' + endDt + '/' + companyID)
				.then(response => {
					if (response.ok) {
						return response.json();
					} else {
						throw new Error('Something went wrong while getting report data. Please contact the administrator.');
					}
				})
				.then(data2 => {
					this.props.onFinish(data2.recordset)
					this.props.onColumns(data.recordsets[5])
					// FavStatusGet(pathAPIServer,this.props.dataUserID,this.props.dataReportID)
					// .then(data3 => {
					if (this._isMounted) {
						this.setState({
							// dataFav: data3[0].FavStatus,
							columns: data.recordsets[0],
							groupSummaryItems: data.recordsets[1],
							totalSummaryItems: data.recordsets[2],
							tableColumnExtensions: data.recordsets[3],
							currencyColumns: ArrCur,
							thousandsColumns: ArrTho,
							decimalColumns: ArrDec,
							percentageColumns: ArrPct,
							dateColumns: ArrDte,
							colorColumns: ArrCol,
							rows: data2.recordset,
							isLoading: false,
						})
					}
					// })
					if (data2.recordsets[1] !== undefined) {
						let arrTotal = data2.recordsets[1]
						let objTotal = arrTotal.reduce((acc, val) => {
															return acc + val;
														});
						let valTotal = (objTotal.GrandTotal === null)
														? 0
														: objTotal.GrandTotal
						this.handleValueChange(valTotal)
					}
				})
				.catch(error => this.setState({ error, isLoading: false }));

			} else if (this.props.paramsList === 'from,to,plant,vendor') {

				let parPlant = this.props.plant
				let parVendor = this.props.vendor

				// console.log(pathAPIServer + this.props.pathReport + '/' + startDt + '/' + endDt + '/' + companyID)
				fetch(pathAPIServer + this.props.pathReport + '/' + startDt + '/' + endDt + '/' + parPlant + '/' + parVendor)
				.then(response => {
					if (response.ok) {
						return response.json();
					} else {
						throw new Error('Something went wrong while getting report data. Please contact the administrator.');
					}
				})
				.then(data2 => {
					this.props.onFinish(data2.recordset)
					this.props.onColumns(data.recordsets[5])
					// FavStatusGet(pathAPIServer,this.props.dataUserID,this.props.dataReportID)
					// .then(data3 => {
					if (this._isMounted) {
						this.setState({
							// dataFav: data3[0].FavStatus,
							columns: data.recordsets[0],
							groupSummaryItems: data.recordsets[1],
							totalSummaryItems: data.recordsets[2],
							tableColumnExtensions: data.recordsets[3],
							currencyColumns: ArrCur,
							thousandsColumns: ArrTho,
							decimalColumns: ArrDec,
							percentageColumns: ArrPct,
							dateColumns: ArrDte,
							colorColumns: ArrCol,
							rows: data2.recordset,
							isLoading: false,
						})
					}
					// })
					if (data2.recordsets[1] !== undefined) {
						let arrTotal = data2.recordsets[1]
						let objTotal = arrTotal.reduce((acc, val) => {
															return acc + val;
														});
						let valTotal = (objTotal.GrandTotal === null)
														? 0
														: objTotal.GrandTotal
						this.handleValueChange(valTotal)
					}
				})
				.catch(error => this.setState({ error, isLoading: false }));

			} else if (this.props.paramsList === 'from,to,plant') {

				var parPlant = this.props.plant.join()

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
							columns: data.recordsets[0],
							groupSummaryItems: data.recordsets[1],
							totalSummaryItems: data.recordsets[2],
							tableColumnExtensions: data.recordsets[3],
							currencyColumns: ArrCur,
							thousandsColumns: ArrTho,
							decimalColumns: ArrDec,
							percentageColumns: ArrPct,
							dateColumns: ArrDte,
							colorColumns: ArrCol,
							rows: data2.recordset,
							isLoading: false,
						})
					}
					if (data2.recordsets[1] !== undefined) {
						let arrTotal = data2.recordsets[1]
						let objTotal = arrTotal.reduce((acc, val) => {
															return acc + val;
														});
						let valTotal = (objTotal.GrandTotal === null)
														? 0
														: objTotal.GrandTotal
						this.handleValueChange(valTotal)
					}
				})
				.catch(error => this.setState({ error, isLoading: false }));
			
			} else if (this.props.paramsList === 'from,to,plant,machine') {

				let parPlant = this.props.plant.join()
				let parMachine = this.props.machine.join()

				// console.log(pathAPIServer + this.props.pathReport + '/' + startDate + '/' + endDate + '/' + parPlant  + '/' + parMachine)
				fetch(pathAPIServer + this.props.pathReport + '/' + startDate + '/' + endDate + '/' + parPlant  + '/' + parMachine)
				.then(response => {
					if (response.ok) {
						return response.json();
					} else {
						throw new Error('Something went wrong while getting report data. Please contact the administrator.');
					}
				})
				.then(data2 => {
					this.props.onFinish(data2.recordset)
					this.props.onColumns(data.recordsets[5])
					if (this._isMounted) {
						this.setState({
							columns: data.recordsets[0],
							groupSummaryItems: data.recordsets[1],
							totalSummaryItems: data.recordsets[2],
							tableColumnExtensions: data.recordsets[3],
							currencyColumns: ArrCur,
							thousandsColumns: ArrTho,
							decimalColumns: ArrDec,
							percentageColumns: ArrPct,
							dateColumns: ArrDte,
							colorColumns: ArrCol,
							rows: data2.recordset,
							isLoading: false,
						})
					}
					if (data2.recordsets[1] !== undefined) {
						let arrTotal = data2.recordsets[1]
						let objTotal = arrTotal.reduce((acc, val) => {
															return acc + val;
														});
						let valTotal = (objTotal.GrandTotal === null)
														? 0
														: objTotal.GrandTotal
						this.handleValueChange(valTotal)
					}
				})
				.catch(error => this.setState({ error, isLoading: false }));

			} else if (this.props.paramsList === 'from,to,plant,machine,parts') {

				let parPlant = this.props.plant.join()
				let parMachine = this.props.machine.join()
				let parPart = this.props.part.join()

				// console.log(pathAPIServer + this.props.pathReport + '/' + startDate + '/' + endDate + '/' + parPlant + '/' + parMachine + '/' + parPart)
				fetch(pathAPIServer + this.props.pathReport + '/' + startDate + '/' + endDate + '/' + parPlant + '/' + parMachine + '/' + parPart)
				.then(response => {
					if (response.ok) {
						return response.json();
					} else {
						throw new Error('Something went wrong while getting report data. Please contact the administrator.');
					}
				})
				.then(data2 => {
					this.props.onFinish(data2.recordset)
					this.props.onColumns(data.recordsets[5])
					if (this._isMounted) {
						this.setState({
							columns: data.recordsets[0],
							groupSummaryItems: data.recordsets[1],
							totalSummaryItems: data.recordsets[2],
							tableColumnExtensions: data.recordsets[3],
							currencyColumns: ArrCur,
							thousandsColumns: ArrTho,
							decimalColumns: ArrDec,
							percentageColumns: ArrPct,
							dateColumns: ArrDte,
							colorColumns: ArrCol,
							rows: data2.recordset,
							isLoading: false,
						})
					}
					if (data2.recordsets[1] !== undefined) {
						let arrTotal = data2.recordsets[1]
						let objTotal = arrTotal.reduce((acc, val) => {
															return acc + val;
														});
						let valTotal = (objTotal.GrandTotal === null)
														? 0
														: objTotal.GrandTotal
						this.handleValueChange(valTotal)
					}
				})
				.catch(error => this.setState({ error, isLoading: false }));
			}
		})
		.catch(error => this.setState({ error, isLoading: false }));
	}

	componentWillUnmount() {
		this._isMounted = false;
	}

	render() {
		const { isLoading, error, rows, columns, //pageSizes,//grouping,
					hiddenColumnNames, tableColumnExtensions,
					currencyColumns, thousandsColumns, decimalColumns,
					percentageColumns, dateColumns, colorColumns,
					totalSummaryItems, groupSummaryItems } = this.state

		if (error) {
			return <p>{error.message}</p>;
		}

		if (isLoading) {
			return <p>Loading ...</p>;
		}

		if (this.props.viewMode === 'NoHeader') {

			return (

				<Card>
					<CardBody>
						<Grid
							rows={rows}
							columns={columns}
						>
							<DragDropProvider />

							<FilteringState
								defaultFilters={[
									// { columnName: 'saleDate', value: '2016-02' }
								]}
							/>
							<IntegratedFiltering />

							<SortingState
								defaultSorting={[
									// { columnName: 'product', direction: 'asc' },
									// { columnName: 'saleDate', direction: 'asc' },
								]}
							/>
							<IntegratedSorting />

							<GroupingState
								defaultGrouping={[
									// { columnName: 'product' }
								]}
								// grouping={grouping}
								defaultExpandedGroups={[
									// 'EnviroCare Max'
								]}
							/>
							<IntegratedGrouping />

							<SummaryState
								totalItems={totalSummaryItems}
								groupItems={groupSummaryItems}
							/>
							<IntegratedSummary
								calculator={summaryCalculator}
							/>

							{/*<PagingState />
							<IntegratedPaging />*/}

							<CurrencyTypeProvider for={currencyColumns} />
							<ThousandsTypeProvider for={thousandsColumns} />
							<DecimalTypeProvider for={decimalColumns} />
							<PercentageTypeProvider for={percentageColumns} />
							<DateTypeProvider for={dateColumns} />

							<VirtualTable columnExtensions={tableColumnExtensions}/>
							<TableColumnReordering
								defaultOrder={columns.map(column => column.name)}
							/>
							{/*<TableSelection showSelectAll={true} />*/}
							<TableHeaderRow showSortingControls={true} />
							<TableColumnVisibility
								hiddenColumnNames={hiddenColumnNames}
								onHiddenColumnNamesChange={this.hiddenColumnNamesChange}
							/>
							<TableFilterRow showFilterSelector={true} />
							{/*<PagingPanel pageSizes={pageSizes} />*/}

							<TableGroupRow
								showColumnsWhenGrouped
							/>
							<TableSummaryRow
								messages={messages}
							/>
							<Toolbar />
							<ColumnChooser />
							<GroupingPanel showSortingControls={true} />

						</Grid>
					</CardBody>
				</Card>
			);

		} else if (this.props.viewMode === 'NoGroupNoFilter') {

			return (

				<Card>
					<CardBody>
						<ViewNote
							note={this.props.note}
						/>
						<Grid
							rows={rows}
							columns={columns}
						>
							<DragDropProvider />
							<SortingState
								defaultSorting={[
									// { columnName: 'product', direction: 'asc' },
									// { columnName: 'saleDate', direction: 'asc' },
								]}
							/>
							<SummaryState
								totalItems={totalSummaryItems}
								groupItems={groupSummaryItems}
							/>

							<IntegratedSummary
								calculator={summaryCalculator}
							/>
							<IntegratedSorting />

							<CurrencyTypeProvider for={currencyColumns} />
							<ThousandsTypeProvider for={thousandsColumns} />
							<DecimalTypeProvider for={decimalColumns} />
							<PercentageTypeProvider for={percentageColumns} />
							<DateTypeProvider for={dateColumns} />
							<ColorTypeProvider for={colorColumns} />

							<VirtualTable columnExtensions={tableColumnExtensions}/>
							<TableColumnReordering
								defaultOrder={columns.map(column => column.name)}
							/>
							{/*<TableColumnResizing
								defaultColumnWidths={tableColumnExtensions}
							/>*/}
							<TableHeaderRow showSortingControls={true} />

							<TableSummaryRow
								messages={messages}
							/>

						</Grid>
					</CardBody>
				</Card>
			);

		} else if (this.props.viewMode === 'Compact') {

			return (

				<Card>
					<CardBody>
						<Grid
							rows={rows}
							columns={columns}
						>
							<SortingState
								defaultSorting={[
									// { columnName: 'product', direction: 'asc' },
								]}
							/>
							<SummaryState
								totalItems={totalSummaryItems}
							/>

							<IntegratedSummary
								calculator={summaryCalculator}
							/>
							<IntegratedSorting />

							<CurrencyTypeProvider for={currencyColumns} />
							<ThousandsTypeProvider for={thousandsColumns} />
							<DecimalTypeProvider for={decimalColumns} />
							<PercentageTypeProvider for={percentageColumns} />
							<DateTypeProvider for={dateColumns} />

							<DragDropProvider />

							<VirtualTable columnExtensions={tableColumnExtensions}/>
							<TableColumnReordering
								defaultOrder={columns.map(column => column.name)}
							/>
							<TableHeaderRow showSortingControls={true} />
							
							<TableSummaryRow
								messages={messages}
							/>

						</Grid>
					</CardBody>
				</Card>
			);

		} else if (this.props.viewMode === 'Detail') {

			return (

				<Card>
					<CardHeader>
						<Row>
							<Col xs="12">
								<ContentHeader
									dataTitle={this.props.dataTitle}
									pathHelp={this.props.pathHelp}
								/>
							</Col>
						</Row>
					</CardHeader>
					<CardBody>
						<Grid
							rows={rows}
							columns={columns}
						>
							<SortingState
								defaultSorting={[
									// { columnName: 'product', direction: 'asc' },
								]}
							/>
							<SummaryState
								totalItems={totalSummaryItems}
							/>

							<IntegratedSummary
								calculator={summaryCalculator}
							/>
							<IntegratedSorting />

							<CurrencyTypeProvider for={currencyColumns} />
							<ThousandsTypeProvider for={thousandsColumns} />
							<DecimalTypeProvider for={decimalColumns} />
							<PercentageTypeProvider for={percentageColumns} />
							<DateTypeProvider for={dateColumns} />

							<DragDropProvider />

							<VirtualTable columnExtensions={tableColumnExtensions}/>
							<TableColumnReordering
								defaultOrder={columns.map(column => column.name)}
							/>
							<TableHeaderRow showSortingControls={true} />
							
							<TableSummaryRow
								messages={messages}
							/>

						</Grid>
					</CardBody>
				</Card>
			);

		}
	}
}

export default CardReportPeriod;
