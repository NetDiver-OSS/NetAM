import React from "react"
import {PieChart} from "react-minimal-pie-chart";

export default class NetworkUsage extends React.Component {

  constructor(props) {
    super(props);

    this.state = {
      data: props.data
    }
  }

  render () {
    return (
      <PieChart
        data={this.state.data}

        style={{
          fontFamily:
            '"Nunito Sans", -apple-system, Helvetica, Arial, sans-serif',
          fontSize: '8px',
        }}

        radius={30}
        lineWidth={15}

        segmentsStyle={{ transition: 'stroke .3s', cursor: 'pointer' }}

        label={
          ({ dataEntry }) => Math.round(dataEntry.percentage) + '%'
        }
        labelStyle={(index) => ({
          fill: this.state.data[index].color,
          fontSize: '5px',
          fontFamily: 'sans-serif',
        })}

        labelPosition={60}
        rounded

        animate
      />
    );
  }
}
