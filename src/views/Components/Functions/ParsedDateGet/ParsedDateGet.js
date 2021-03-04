function ParsedDateGet(date){
	date = String(date).split('T');
	var days = String(date[0]).split('-');
	var hours = String(date[1]).split(':');
	return [(days[2]), '/', (days[1]), '/', (days[0]), ' ',
					(hours[0]), ':', (hours[1])];
}

export default ParsedDateGet;
