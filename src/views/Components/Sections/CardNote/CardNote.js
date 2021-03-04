import React, { Component } from 'react';
import {
	Card,
	CardBody,
	CardHeader,
	Col,
	Row,
} from 'reactstrap';
import {
	ContentHeader,
} from '../../../Components';

class CardNote extends Component {

	constructor(props){
		super(props);
		this.state = {
			isLoading: false,
			error: null,
		};
	}

	async componentDidMount() {
		this.setState({ isLoading: true });



		this.setState({ isLoading: false });
	}

	render() {
		const { isLoading, error } = this.state

		// var options = { year: 'numeric', month: 'long', day: 'numeric' };
		// let startD = this.props.startDate
		// const startDate = startD.toLocaleString('id', options)
		// let endD = this.props.endDate
		// const endDate = endD.toLocaleString('id', options)

		// var formatter = new Intl.NumberFormat('en-US', {
		// 	style: 'decimal',
		// 	currency: 'IDR',
		// 	minimumFractionDigits: 0,
		// 	maximumFractionDigits: 0
		// });
		// const totAmount = formatter.format(this.props.totAmount)
		// const totQty = formatter.format(this.props.totQty)
		// const avgPrice = formatter.format(this.props.totAmount/this.props.totQty)

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
								<Col xs="12">

									<p>Data selama periode antara <strong>startDate</strong> sampai <strong>endDate</strong> :</p>
									<Row>
										<Col xs="3">
											<p>Total value pembelian :</p>
										</Col>
										<Col xs="3">
											<p>Rp <strong>totAmount</strong></p>
										</Col>
									</Row>
									<Row>
										<Col xs="3">
											<p>Total volume pembelian :</p>
										</Col>
										<Col xs="3">
											<p><strong>totQty</strong> liter</p>
										</Col>
									</Row>
									<Row>
										<Col xs="3">
											<p>Harga rata-rata per liter :</p>
										</Col>
										<Col xs="3">
											<p>Rp <strong>avgPrice</strong> per liter</p>
										</Col>
									</Row>

								</Col>
							</Row>
						</CardBody>
					</Col>
				</Row>
			</Card>

		);
	}
}

export default CardNote;
