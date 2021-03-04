import React from 'react';
import DefaultLayout from './containers/DefaultLayout';

const Login = React.lazy(() => import('./views/Pages/Login'));

const Dashboard = React.lazy(() => import('./views/Dashboard'));

const Maintenance = React.lazy(() => import('./views/Pages/Maintenance'));

//HR
const DailyAssessment = React.lazy(() => import('./views/Reports/HR/DailyAssessment'));
const DailyAssessmentInput = React.lazy(() => import('./views/Reports/HR/DailyAssessmentInput'));
const DailyAssessmentKeluhanLain = React.lazy(() => import('./views/Reports/HR/DailyAssessmentKeluhanLain'));
const DailyAssessmentKondisiKeluarga = React.lazy(() => import('./views/Reports/HR/DailyAssessmentKondisiKeluarga'));
const DailyAssessmentKondisiLingkungan = React.lazy(() => import('./views/Reports/HR/DailyAssessmentKondisiLingkungan'));
const DailyAssessmentLingkunganCOVID = React.lazy(() => import('./views/Reports/HR/DailyAssessmentLingkunganCOVID'));
const DailyAssessmentPabrikKeluhanLain = React.lazy(() => import('./views/Reports/HR/DailyAssessmentPabrikKeluhanLain'));
const DailyAssessmentPabrikKondisiKeluarga = React.lazy(() => import('./views/Reports/HR/DailyAssessmentPabrikKondisiKeluarga'));
const DailyAssessmentPabrikKondisiLingkungan = React.lazy(() => import('./views/Reports/HR/DailyAssessmentPabrikKondisiLingkungan'));
const DailyAssessmentRekap = React.lazy(() => import('./views/Reports/HR/DailyAssessmentRekap'));
const DailyAssessmentResiko = React.lazy(() => import('./views/Reports/HR/DailyAssessmentResiko'));
const DailyAssessmentShift = React.lazy(() => import('./views/Reports/HR/DailyAssessmentShift'));
const DailyAssessmentTidakSehat = React.lazy(() => import('./views/Reports/HR/DailyAssessmentTidakSehat'));

/*karantina*/
const KarantinaForm = React.lazy(() => import('./views/Pages/Karantina/Form'));
const KarantinaOutstanding = React.lazy(() => import('./views/Pages/Karantina/Outstanding'));

const routes = [
	{ path: '/', exact: true, name: 'Home', component: Dashboard },
	{ path: '/login', name: 'Login', component: Login },
	{ path: '/dashboard', exact: true, name: 'Dashboard', component: Dashboard },
	{ path: '/maintenance', exact: true, name: 'Maintenance', component: Maintenance },

	{ path: '/hr/dailyassessment', exact: true, name: 'DailyAssessment', component: DailyAssessment },
	{ path: '/hr/dailyassessmentinput', exact: true, name: 'DailyAssessmentInput', component: DailyAssessmentInput },
	{ path: '/hr/dailyassessmentkeluhanlain', exact: true, name: 'DailyAssessmentKeluhanLain', component: DailyAssessmentKeluhanLain },
	{ path: '/hr/dailyassessmentkondisikeluarga', exact: true, name: 'DailyAssessmentKondisiKeluarga', component: DailyAssessmentKondisiKeluarga },
	{ path: '/hr/dailyassessmentkondisilingkungan', exact: true, name: 'DailyAssessmentKondisiLingkungan', component: DailyAssessmentKondisiLingkungan },
	{ path: '/hr/dailyassessmentlingkungancovid', exact: true, name: 'DailyAssessmentLingkunganCOVID', component: DailyAssessmentLingkunganCOVID },
	{ path: '/hr/dailyassessmentpabrikkeluhanlain', exact: true, name: 'DailyAssessmentPabrikKeluhanLain', component: DailyAssessmentPabrikKeluhanLain },
	{ path: '/hr/dailyassessmentpabrikkondisikeluarga', exact: true, name: 'DailyAssessmentPabrikKondisiKeluarga', component: DailyAssessmentPabrikKondisiKeluarga },
	{ path: '/hr/dailyassessmentpabrikkondisilingkungan', exact: true, name: 'DailyAssessmentPabrikKondisiLingkungan', component: DailyAssessmentPabrikKondisiLingkungan },
	{ path: '/hr/dailyassessmentrekap', exact: true, name: 'DailyAssessmentRekap', component: DailyAssessmentRekap },
	{ path: '/hr/dailyassessmentresiko', exact: true, name: 'DailyAssessmentResiko', component: DailyAssessmentResiko },
	{ path: '/hr/dailyassessmentshift', exact: true, name: 'DailyAssessmentShift', component: DailyAssessmentShift },
	{ path: '/hr/dailyassessmenttidaksehat', exact: true, name: 'DailyAssessmentTidakSehat', component: DailyAssessmentTidakSehat },
	
	{ path: '/karantina/form', exact: true, name: 'karantina.form', component: KarantinaForm },
	{ path: '/karantina/outstanding', exact: true, name: 'karantina.outstanding', component: KarantinaOutstanding },

];

export default routes;