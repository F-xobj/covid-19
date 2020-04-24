import React, { Component } from "react";
import "./dashboard.css";
import Header from "../Header/header";
import Sidebar from "../SideBar/sidebar.jsx";
import Global from "../Global/global.jsx";
import Local from "../Local/local";
class Dashboard extends Component {
  constructor(props) {
    super(props);

    this.state = {
      displayGlobal: true,
    };
  }

  handelDisplay = (con) => {
    if (con) {
      this.setState({
        displayGlobal: true,
      });
    } else {
      this.setState({
        displayGlobal: false,
      });
    }
  };
  render() {
    return (
      <div className="mainContainer">
        <Header />
        <div className="dashboardContainer">
          <div className="leftNavigation">
            <Sidebar handelDisplay={this.handelDisplay} />
          </div>
          <div className="rightContent">
            {this.state.displayGlobal ? <Global /> : <Local />}
          </div>
        </div>
      </div>
    );
  }
}

export default Dashboard;
