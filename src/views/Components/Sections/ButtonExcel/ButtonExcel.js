import React, { Component } from 'react';
// import * as ReactDOM from 'react-dom';
import {
	Button,
} from 'reactstrap';
import {
	ExcelExport,
	ExcelExportColumn,
	// ExcelExportColumnGroup
} from '@progress/kendo-react-excel-export';

class ButtonExcel extends Component {
	_exporter;
	export = () => {
		this._exporter.save();
	}

	render() {
		const { dataTitle, dataExcel, dataColumns } = this.props
		const dataTitleXlsx = dataTitle+".xlsx"

		return (
			<React.Fragment>
				<Button id={this.props.id} onClick={this.export} color="success">Excel</Button>
				<ExcelExport
					data={dataExcel}
					fileName={dataTitleXlsx}
					ref={(exporter) => { this._exporter = exporter; }}
				>
					{
						dataColumns.map((item, i) =>
							{
								if (item.type === 'date') {
									return (
										<ExcelExportColumn
											key={i}
											field={item.name}
											title={item.title}
											cellOptions={{ format: 'm/d/yy' }}
										/>
									);
								} else if (item.custom === 'thousands') {
									return (
										<ExcelExportColumn
											key={i}
											field={item.name}
											title={item.title}
											cellOptions={{ format: '#,##0' }}
										/>
									);
								} else if (item.custom === 'decimal') {
									return (
										<ExcelExportColumn
											key={i}
											field={item.name}
											title={item.title}
											cellOptions={{ format: '#,##0.0' }}
										/>
									);
								} else if (item.custom === 'percentage') {
									return (
										<ExcelExportColumn
											key={i}
											field={item.name}
											title={item.title}
											cellOptions={{ format: '#,##0.0%' }}
										/>
									);
								} else {
									return (
										<ExcelExportColumn
											key={i}
											field={item.name}
											title={item.title}
										/>
									);
								}
							}
						)
					}
				</ExcelExport>
			</React.Fragment>
		);
	}
}

export default ButtonExcel;
