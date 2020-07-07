import React from "react"
import { PieChart } from 'svg-charts-react'

export default class NetworkUsage extends React.Component {

  constructor(props) {
    super(props);

    this.state = {
      data: props.data
    }
  }

  render () {
    return (
      <div style={{width: '25rem'}}>
        <PieChart data={this.state.data} />
      </div>
    );
  }
}
