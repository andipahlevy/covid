import React, { Component } from 'react';
import {
	Card,
	CardBody,
	CardHeader,
	Col,
	Row,
	// Table,
} from 'reactstrap';
import DatePicker from 'react-datepicker';
import 'react-datepicker/dist/react-datepicker.css';
import {
	// BodyGet,
	// BuyerSelect,
	// CompanySelect,
	ContentHeader,
	FavoriteAdd,
	FavStatusGet,
	// HeaderGet,
	DropdownPeriod,
	// SupplierSelect,
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
	IntegratedPaging,
	// IntegratedSelection,
	IntegratedSorting,
	IntegratedSummary,
	PagingState,
	// SelectionState,
	SortingState,
	SummaryState,
} from "@devexpress/dx-react-grid";
import {
	ColumnChooser,
	DragDropProvider,
	Grid,
	GroupingPanel,
	PagingPanel,
	Table,
	// TableColumnReordering,
	// TableColumnResizing,
	TableColumnVisibility,
	TableFilterRow,
	TableGroupRow,
	TableHeaderRow,
	TableSummaryRow,
	// TableSelection,
	Toolbar,
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
	if (type === 'summa') {
		if (!rows.length) {
			return null;
		}
		return rows.reduce(function (acc, row) { return acc + getValue(row); }, 0);		
	}
	const result = IntegratedSummary.defaultCalculator(type, rows, getValue)
	return result;
	// return IntegratedSummary.defaultCalculator(type, rows, getValue);
};

const messages = {
	median: 'Median',
	summa: 'Summa',
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
	minimumFractionDigits: 0,
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
	minimumFractionDigits: 2,
	maximumFractionDigits: 2
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

class CardReport extends Component {

	constructor(props){
		super(props);
		this.state = {
			dataUserID: 0,
			dataReportID: 0,
			dataFav: null,
			isLoading: false,
			error: null,

			columns: [],
			rows: [],
			grouping: [],
			groupSummaryItems: [],
			totalSummaryItems: [],
			tableColumnExtensions: [],
			columnOrder: [],
			pageSizes: [5, 10, 20],
			hiddenColumnNames: [],
			currencyColumns: [],
			thousandsColumns: [],
			decimalColumns: [],
			percentageColumns: [],

			startDate: new Date(),
			endDate: new Date(),

			result: 0
		};
		this.handleFavClick = this.handleFavClick.bind(this);
		this.handleStartChange = this.handleStartChange.bind(this);
		this.handleEndChange = this.handleEndChange.bind(this);
		this.updateData = this.updateData.bind(this);
		// this.changeColumnOrder = this.changeColumnOrder.bind(this);
		// this.changeSelection = selection => this.setState({ selection });
		this.changeSorting = sorting => this.setState({ sorting });
		this.hiddenColumnNamesChange = hiddenColumnNames => {
			this.setState({ hiddenColumnNames });
		};
	}

	// changeColumnOrder(newOrder) {
	// 	this.setState({ columnOrder: newOrder });
	// }

	updateData() {
		this.setState({ isLoading: true });

		const pathReport = this.props.pathReport
		const dataUserID = this.props.dataUserID
		const dataReportID = this.props.dataReportID

		let startD = this.state.startDate
		let startDate = startD.getFullYear() + "-" + ("0"+(startD.getMonth()+1)).slice(-2) + "-" + ("0" + startD.getDate()).slice(-2)
		let endD = this.state.endDate
		let endDate = endD.getFullYear() + "-" + ("0"+(endD.getMonth()+1)).slice(-2) + "-" + ("0" + endD.getDate()).slice(-2)

		// console.log(pathAPIServer + pathReportParams + dataReportID)
		fetch(pathAPIServer + pathReportParams + dataReportID)
		.then(response => {
			if (response.ok) {
				return response.json();
			} else {
				throw new Error('Something went wrong...');
			}
		})
		.then(data => {
			const ArrayKolom = data.recordsets[4]
			var ArrCur = []
			var ArrTho = []
			var ArrDec = []
			var ArrPct = []
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
					}					
			}
			this.setState({
				columns: data.recordsets[0],
				groupSummaryItems: data.recordsets[1],
				totalSummaryItems: data.recordsets[2],
				tableColumnExtensions: data.recordsets[3],
				currencyColumns: ArrCur,
				thousandsColumns: ArrTho,
				decimalColumns: ArrDec,
				percentageColumns: ArrPct,
			})
		})
		.catch(error => this.setState({ error, isLoading: false }));

		// console.log(pathAPIServer + pathReport + '/' + startDate + '/' + endDate)
		fetch(pathAPIServer + pathReport + '/' + startDate + '/' + endDate)
		.then(response => {
			if (response.ok) {
				return response.json();
			} else {
				throw new Error('Something went wrong...');
			}
		})
		.then(data => {

			// console.log(data.recordset)
			this.setState({ rows: data.recordset })

			FavStatusGet(pathAPIServer,dataUserID,dataReportID)
			.then(data => {
				this.setState({ dataFav: data[0].FavStatus, isLoading: false,
					dataUserID: dataUserID, dataReportID: dataReportID })
			})
			.catch(error => this.setState({ error, isLoading: false }));
		})
		.catch(error => this.setState({ error, isLoading: false }));
	}

	handleFavClick(fav) {
		this.setState({ dataFav: fav })
	}

	handleStartChange(date) {
		(date > this.state.endDate)
			// ? this.setState({ startDate: this.state.endDate })
			// : this.setState({ startDate: date })
			?	this.setState({ startDate: this.state.endDate }, function () {
				// console.log(this.state.startDate)
				this.updateData()
			})
			:	this.setState({ startDate: date }, function () {
				// console.log(this.state.startDate);
				this.updateData()
			})
	}

	handleEndChange(date) {
		(date < this.state.startDate)
			// ? this.setState({ endDate: this.state.startDate })
			// : this.setState({ endDate: date })
			?	this.setState({ endDate: this.state.startDate }, function () {
				// console.log(this.state.endDate);
				this.updateData()
			})
			:	this.setState({ endDate: date }, function () {
				// console.log(this.state.endDate);
				this.updateData()
			})
	}

	async componentDidMount() {
		this.updateData()
	}

	render() {
		const { isLoading, error, rows, columns, pageSizes, //grouping,
					hiddenColumnNames, tableColumnExtensions,
					currencyColumns, thousandsColumns, decimalColumns, percentageColumns,
					totalSummaryItems, groupSummaryItems, } = this.state

		if (error) {
			return <p>{error.message}</p>;
		}

		if (isLoading) {
			return <p>Loading ...</p>;
		}

		return (

			<Card>
				<CardHeader>
					<ContentHeader
						dataTitle={this.props.dataTitle}
						pathHelp={this.props.pathHelp}
					/>
				</CardHeader>
				<Row>
					<Col xs="12">
						<CardBody>
							<Row>
								<Col xs="9">
									<DropdownPeriod />
									&emsp;
									<DatePicker
										selected={this.state.startDate}
										dateFormat="d MMMM yyyy"
										placeholderText="Select start date"
										selectsStart
										startDate={this.state.startDate}
										endDate={this.state.endDate}
										onChange={this.handleStartChange}
										showMonthDropdown
										showYearDropdown
										dropdownMode="select"
									/>
									&emsp;
									-
									&emsp;
									<DatePicker
										selected={this.state.endDate}
										dateFormat="d MMMM yyyy"
										placeholderText="Select end date"
										selectsEnd
										startDate={this.state.startDate}
										endDate={this.state.endDate}
										onChange={this.handleEndChange}
										showMonthDropdown
										showYearDropdown
										dropdownMode="select"
									/>

								</Col>
								<Col xs="3">
									<FavoriteAdd
										dataUserID={this.state.dataUserID}
										dataReportID={this.state.dataReportID}
										dataFav={this.state.dataFav}
										onFavClick={this.handleFavClick}
									/>
								</Col>
							</Row>
							<Row>
								<Col xs="12">
									&emsp;
								</Col>
							</Row>
							<Row>
								<Col xs="12">

									<Grid
										rows={rows}
										columns={columns}
									>
										<FilteringState
											defaultFilters={[
												// { columnName: 'saleDate', value: '2016-02' }
											]}
										/>
										<SortingState
											defaultSorting={[
												// { columnName: 'product', direction: 'asc' },
												// { columnName: 'saleDate', direction: 'asc' },
											]}
										/>

										{/*<SelectionState />*/}

										<GroupingState
											defaultGrouping={[
												// { columnName: 'product' }
											]}
											// grouping={grouping}
											defaultExpandedGroups={[
												// 'EnviroCare Max'
											]}
										/>
										<SummaryState
											totalItems={totalSummaryItems}
											groupItems={groupSummaryItems}
										/>
										<PagingState />

										<IntegratedFiltering />
										<IntegratedGrouping />
										<IntegratedSummary
											calculator={summaryCalculator}
										/>
										<IntegratedSorting />
										<IntegratedPaging />
										{/*<IntegratedSelection />*/}

										<CurrencyTypeProvider for={currencyColumns} />
										<ThousandsTypeProvider for={thousandsColumns} />
										<DecimalTypeProvider for={decimalColumns} />
										<PercentageTypeProvider for={percentageColumns} />

										<DragDropProvider />

										<Table columnExtensions={tableColumnExtensions}/>
										{/*<TableSelection showSelectAll={true} />*/}
										<TableHeaderRow showSortingControls={true} />
										<TableColumnVisibility
											hiddenColumnNames={hiddenColumnNames}
											onHiddenColumnNamesChange={this.hiddenColumnNamesChange}
										/>
										<TableFilterRow showFilterSelector={true} />
										<PagingPanel pageSizes={pageSizes} />

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

								</Col>
							</Row>
						</CardBody>
					</Col>
				</Row>
			</Card>

		);
	}
}

export default CardReport;
