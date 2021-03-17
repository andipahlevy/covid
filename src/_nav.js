export default {
	items: [
		{
			name: 'Dashboard',
			url: '/dashboard',
			icon: 'icon-home',
			badge: {
				variant: 'warning',
				text: 'HOME',
			},
		},
		// {
		//   title: true,
		//   name: 'Theme',
		//   wrapper: {            // optional wrapper object
		//     element: '',        // required valid HTML5 element tag
		//     attributes: {}        // optional valid JS object with JS API naming ex: { className: "my-class", style: { fontFamily: "Verdana" }, id: "my-id"}
		//   },
		//   class: ''             // optional class names space delimited list for title item ex: "text-center"
		// },
		// {
		//   name: 'Colors',
		//   url: '/theme/colors',
		//   icon: 'icon-drop',
		// },
		// {
		// 	divider: true,
		// },
		{
			title: true,
			name: 'Karantina',
			wrapper: {
				element: '',
				attributes: {},
			},
		},
		
		{
			name: 'Outstanding Karantina',
			icon: 'icon-flag',
			url: '/karantina/outstanding',
		},
		{
			title: true,
			name: 'Available Reports',
			wrapper: {
				element: '',
				attributes: {},
			},
		},
		/*
		{
			name: 'HR',
			url: '/hr',
			icon: 'icon-people',
			// badge: {
			// 	variant: 'warning',
			// 	text: 'NEW',
			// },
			children: [
				{
					name: 'Daily Assessment',
					icon: 'icon-people',
					badge: { variant: 'warning', text: 'MORE', },
					children: [
						{
							name: 'Detail',
							url: '/hr/dailyassessment',
							icon: 'icon-people',
						},
						{
							name: 'Input',
							url: '/hr/dailyassessmentinput',
							icon: 'icon-people',
						},
						{
							name: 'Kondisi Keluarga Sakit',
							url: '/hr/dailyassessmentkondisikeluarga',
							icon: 'icon-people',
						},
						{
							name: 'Kondisi/Kasus di Lingkungan',
							url: '/hr/dailyassessmentkondisilingkungan',
							icon: 'icon-people',
						},
						{
							name: 'Lingkungan COVID',
							url: '/hr/dailyassessmentlingkungancovid',
							icon: 'icon-people',
						},
						{
							name: 'Rekap Input',
							url: '/hr/dailyassessmentrekap',
							icon: 'icon-people',
						},
						{
							name: 'Resiko',
							url: '/hr/dailyassessmentresiko',
							icon: 'icon-people',
						},
						{
							name: 'Tidak Sehat',
							url: '/hr/dailyassessmenttidaksehat',
							icon: 'icon-people',
						},
					],
				},
			],
		},
		*/
		{
			name: 'Karantina Report',
			icon: 'icon-calendar',
			url: '/karantina/report',
		},
		{
			name: 'Self Declarations Report',
			icon: 'icon-calendar',
			url: '/report/declaration',
		},
	],
};
