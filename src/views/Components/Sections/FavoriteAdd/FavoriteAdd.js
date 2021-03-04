import React, { Component } from 'react';
import {
	Col,
	Button,
} from 'reactstrap';
import {
	pathAPIServer
} from '../../../Constants';

class FavoriteAdd extends Component {

	constructor(props) {
		super(props);
		this.handleFavoriteClick = this.handleFavoriteClick.bind(this);
		this.state = {
			isLoading: true
		};
	}

	handleFavoriteClick(event) {
		this.props.onFavClick(!this.props.dataFav);

		fetch(pathAPIServer + 'report/favorite/update/' + this.props.dataUserID + '/' + this.props.dataReportID)
		.then(response => {
			if (response.ok) {
				return response.json();
			} else {
				throw new Error('Something went wrong...');
			}
		})
		.catch(error => this.setState({ error }));
	}

	render() {
		const isFavorite = this.props.dataFav
		
		let favoriteButton;

		if (isFavorite) {
			favoriteButton = <Button size="sm" onClick={this.handleFavoriteClick} color="warning">Remove from Favorite</Button>
		}
		else {
			favoriteButton = <Button size="sm" onClick={this.handleFavoriteClick} color="success">Add to Favorite</Button>
		}

		return (
			<Col col="2" className="mb-3 mb-xl-0 text-center">
				{favoriteButton}
			</Col>
		);
	}
}

export default FavoriteAdd;
