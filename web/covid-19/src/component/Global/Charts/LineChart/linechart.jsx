import React, { Component } from "react";
import Highcharts from "highcharts/highstock";
import HighchartsReact from "highcharts-react-official";

class LineChart extends Component {
  constructor(props) {
    super(props);
    this.state = {
      options: {
        chart: {
          type: "spline",
        },
        title: {
          text: "",
        },
        series: [
          {
            data: [
              100,
              0,
              50,
              100,
              0,
              100,
              100,
              0,
              100,
              100,
              0,
              100,
              100,
              0,
              100,
            ],
          },
        ],
      },
    };
    console.log("from constructor", this.state.options);
  }
  componentDidMount() {
    this.getData();
  }
  getData = () => {
    let data = this.state.options;
    let newdata = data.series[0].data.map((val) => {
      return val * 50;
    });
    data.series[0].data = newdata;
    this.setState({
      options: data,
    });
  };
  render() {
    return (
      <div>
        <HighchartsReact
          highcharts={Highcharts}
          options={this.state.options}
          key={Math.random()}
        />
      </div>
    );
  }
}

export default LineChart;
