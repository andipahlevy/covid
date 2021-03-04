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

function AmountNote({ noteAmount, curAmount, totAmount, satAmount }){
	return (
		<div>
			{(() => {
				switch(totAmount) {
					case '0':
						return (
							<Row>
								<Col xs="3">
									<p>Tidak ada pembelian</p>
								</Col>
							</Row>
						);
					case 'NaN':
						return (
							<Row>
								<Col xs="3">
									<p>Tidak ada pembelian</p>
								</Col>
							</Row>
						);
					default:
						return (
							<Row>
								<Col xs="3">
									<p>{noteAmount}</p>
								</Col>
								<Col xs="3">
									<p>{curAmount}{totAmount}{satAmount}</p>
								</Col>
							</Row>
						);
				}
			})()}
		</div>
	);
}

function QtyNote({ noteQty, totQty, satQty }){
	return (
		<div>
			{(() => {
				switch(totQty) {
					case '0':
						return null;
					case 'NaN':
						return null;
					default:
						return (
							<Row>
								<Col xs="3">
									<p>{noteQty}</p>
								</Col>
								<Col xs="3">
									<p>{totQty}{satQty}</p>
								</Col>
							</Row>
						);
				}
			})()}
		</div>
	);
}

function AvgNote({ noteAvg, curAvg, totAvg, satAvg }){
	return (
		<div>
			{(() => {
				switch(totAvg) {
					case '0':
						return null;
					case 'NaN':
						return null;
					default:
						return (
							<Row>
								<Col xs="3">
									<p>{noteAvg}</p>
								</Col>
								<Col xs="3">
									<p>{curAvg}{totAvg}{satAvg}</p>
								</Col>
							</Row>
						);
				}
			})()}
		</div>
	);
}

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

		var options = { year: 'numeric', month: 'long', day: 'numeric' };
		let startD = this.props.startDate
		const startDate = startD.toLocaleString('id', options)
		let endD = this.props.endDate
		const endDate = endD.toLocaleString('id', options)

		var formatter = new Intl.NumberFormat('en-US', {
			style: 'decimal',
			currency: 'IDR',
			minimumFractionDigits: 0,
			maximumFractionDigits: 2
		});
		const noteAmount = this.props.noteAmount
		const curAmount = this.props.curAmount
		const totAmount = formatter.format(this.props.totAmount)
		const satAmount = this.props.satAmount
		const noteQty = this.props.noteQty
		const satQty = this.props.satQty
		const totQty = formatter.format(this.props.totQty)
		const noteAvg = this.props.noteAvg
		const curAvg = this.props.curAvg
		const totAvg = formatter.format(this.props.totAvg)
		const satAvg = this.props.satAvg

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

									<p>Data selama periode antara {startDate} sampai {endDate} :</p>
									<AmountNote noteAmount={noteAmount} curAmount={curAmount} totAmount={totAmount} satAmount={satAmount} />
									<QtyNote noteQty={noteQty} totQty={totQty} satQty={satQty} />
									<AvgNote noteAvg={noteAvg} curAvg={curAvg} totAvg={totAvg} satAvg={satAvg} />

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
