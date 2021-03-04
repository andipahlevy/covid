import React from "react";
import { BallClimbingDot } from 'react-pretty-loading';

	const LoadingSpinner = () => (
		<div className="container">
			<br></br>
			<br></br>
			<br></br>
			<BallClimbingDot loading={true} center width={100} />
		</div>
	);

export default LoadingSpinner;
