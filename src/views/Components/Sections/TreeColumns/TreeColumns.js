import React, { Component } from 'react';
import { 
	Column,
} from 'devextreme-react/tree-list';

class TreeColumns extends Component {

	render() {
		const { columns } = this.props
		console.log(columns)
		return (
			<>
				{
					columns.map((item, i) =>
						<Column key={item.name}
							dataField={item.name}
							caption={item.title}
							minWidth={item.width}
						>
						</Column>
					)
				}
			</>
		)
	}
}

export default TreeColumns;
