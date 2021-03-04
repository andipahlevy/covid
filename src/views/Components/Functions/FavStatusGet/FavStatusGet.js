async function FavStatusGet(path,userid,reportid){

	return await fetch(path + 'report/favorite/check/' + userid + '/' + reportid)
	.then(response => {
		if (response.ok) {
			return response.json();
		} else {
			throw new Error('Something went wrong...');
		}
	})
	.then(data => {
		return data.recordset
		// data.recordset.map((rs) => {
		// 	if (rs.FavStatus === 'A'){
		// 		const FavStatus = true
		// 		return FavStatus;
		// 	} else {
		// 		const FavStatus = false
		// 		return FavStatus;
		// 	}
		// })
	});
}

export default FavStatusGet;
