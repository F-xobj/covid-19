import React, { Component } from "react";
import "./dashboard.css";
import Header from "../Header/header";
import Sidebar from "../SideBar/sidebar.jsx";
import Global from "../Global/global.jsx";
class Dashboard extends Component {
  constructor(props) {
    super(props);

    this.state = {};
  }

  render() {
    return (
      <div className="mainContainer">
        <Header />
        <div className="dashboardContainer">
          <div className="leftNavigation">
            <Sidebar />
          </div>
          <div className="rightContent">
            <Global />
          </div>
        </div>
        <footer></footer>
      </div>
    );
  }
}

export default Dashboard;
