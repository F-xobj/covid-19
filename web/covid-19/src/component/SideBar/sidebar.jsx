import React, { Component } from "react";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faGlobeAsia, faMapMarkedAlt } from "@fortawesome/free-solid-svg-icons";
import "./sidebar.css";
export default class Sidebar extends Component {
  constructor(props) {
    super(props);

    this.state = {
      displayGlobal: true,
    };
  }
  render() {
    return (
      <div className="sidebarContainer">
        <div className="list">
          <div
            className="textWithIcon"
            onClick={() => this.props.handelDisplay(true)}
          >
            <FontAwesomeIcon icon={faGlobeAsia} />
            <div className="text">Global</div>
          </div>
          <div
            className="textWithIcon"
            onClick={() => this.props.handelDisplay(false)}
          >
            <FontAwesomeIcon icon={faMapMarkedAlt} />
            <div className="text">Local</div>
          </div>
        </div>
      </div>
    );
  }
}
