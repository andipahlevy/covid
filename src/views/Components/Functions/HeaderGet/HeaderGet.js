import React from 'react';

function HeaderGet(reportid,dataRecordset){

	switch(reportid) {
		
		case 1:
		case 2:
		case 3:
		case 4:

			return(
				[<tr key={reportid}>
					<th key={reportid+'ID'}>User ID</th>
					<th key={reportid+'Name'}>User Name</th>
					<th key={reportid+'Role'}>Role Name</th>
					<th key={reportid+'CreateDate'}>Create Date</th>
					<th key={reportid+'Status'}>Status</th>
				</tr>]
			);

		case 5:
		case 6:
		case 7:

			return(
				[<tr key={reportid}>
					<th key={reportid+'Plant'}>Plant</th>
					<th key={reportid+'Kode'}>Kode Vendor</th>
					<th key={reportid+'Nama'}>Nama Vendor</th>
					<th key={reportid+'MatCode'}>Kode Material</th>
					<th key={reportid+'Value'}>Value</th>
					<th key={reportid+'MatName'}>Nama Material</th>
				</tr>]
			);

		default:

			return null;

		}
}

export default HeaderGet;
