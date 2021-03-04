import React from 'react';
import {
	Badge,
} from 'reactstrap';
import {
	ParsedDateGet,
} from '../../../Components';

function BodyGet(reportid,dataRecordset){

	switch(reportid) {
		
		case 1:
		case 2:
		case 3:
		case 4:

			let body4 = dataRecordset.map((rs) => {
				const isActive = {
					A: <Badge pill color="success">Active</Badge>,
					N: <Badge pill color="danger">Inactive</Badge>,
					X: <Badge pill color="danger">Error</Badge>,
					default: <Badge pill color="danger">Empty</Badge>,
				};
				const createDate = ParsedDateGet(rs.User_CreateDate);

				return(
					<tr key={reportid+''+rs.User_ID}>
						<React.Fragment>
							<td key={reportid+''+rs.User_ID+'ID'}>{rs.User_ID}</td>
							<td key={reportid+''+rs.User_ID+'Name'}>{rs.Employee_Name}</td>
							<td key={reportid+''+rs.User_ID+'Role'}>{rs.Role_Name}</td>
							<td key={reportid+''+rs.User_ID+'CreateDate'}>{createDate}</td>
							<td key={reportid+''+rs.User_ID+'Status'}>{isActive[rs.User_Status]}</td>
						</React.Fragment>
					</tr>
				)
			})

			return body4;

		case 5:
		case 6:
		case 7:

			let body7 = dataRecordset.map((rs) => {
				return(
					<tr key={reportid+''+rs.nama_vendor_po}>
						<React.Fragment>
							<td key={reportid+''+rs.nama_vendor_po+'Plant'}>{rs.plant}</td>
							<td key={reportid+''+rs.nama_vendor_po+'Kode'}>{rs.kode_vendor_po}</td>
							<td key={reportid+''+rs.nama_vendor_po+'Nama'}>{rs.nama_vendor_po}</td>
							<td key={reportid+''+rs.nama_vendor_po+'MatCode'}>{rs.material_code_po}</td>
							<td key={reportid+''+rs.nama_vendor_po+'Value'}>{rs.total_amount}</td>
							<td key={reportid+''+rs.nama_vendor_po+'MatName'}>{rs.material_name_po}</td>
						</React.Fragment>
					</tr>
				)
			})

			return body7;

		default:

			return null;

		}
}

export default BodyGet;
