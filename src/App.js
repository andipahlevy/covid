import React, { Component } from 'react';
import { HashRouter, Route, Switch } from 'react-router-dom';
// import { renderRoutes } from 'react-router-config';
import Loadable from 'react-loadable';
import './App.scss';
import '@devexpress/dx-react-grid-bootstrap4/dist/dx-react-grid-bootstrap4.css';

const loading = () => <div className="animated fadeIn pt-3 text-center">Loading...</div>;

// Containers
const DefaultLayout = Loadable({
	loader: () => import('./containers/DefaultLayout'),
	loading
});

// Pages
const Login = Loadable({
	loader: () => import('./views/Pages/Login'),
	loading
});

const Register = Loadable({
	loader: () => import('./views/Pages/Register'),
	loading
});

const Declaration = Loadable({
	loader: () => import('./views/Pages/Declaration'),
	loading
});

const DeclarationDone = Loadable({
	loader: () => import('./views/Pages/Done'),
	loading
});

const Page404 = Loadable({
	loader: () => import('./views/Pages/Page404'),
	loading
});

const Page500 = Loadable({
	loader: () => import('./views/Pages/Page500'),
	loading
});

class App extends Component {

	render() {
		return (
			<HashRouter>
					<Switch>
						<Route exact path="/login" name="Login Page" component={Login} />
						<Route exact path="/register" name="Register Page" component={Register} />
						<Route exact path="/declaration" name="Declaration" component={Declaration} />
						<Route exact path="/done" name="DeclarationDone" component={DeclarationDone} />
						<Route exact path="/404" name="Page 404" component={Page404} />
						<Route exact path="/500" name="Page 500" component={Page500} />
						<Route exact path="/dashboard" name="Dashboard" component={DefaultLayout} />
						
						<Route path="/hr" name="HR" component={DefaultLayout} />

						<Route path="/" name="Home" component={DefaultLayout} />
					</Switch>
			</HashRouter>
		);
	}
}

export default App;
