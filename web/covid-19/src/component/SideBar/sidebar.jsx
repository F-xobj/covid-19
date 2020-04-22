import React, { Component } from "react";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faGlobeAsia, faMapMarkedAlt } from "@fortawesome/free-solid-svg-icons";
import "./sidebar.css";
export default class Sidebar extends Component {
  render() {
    return (
      <div className="sidebarContainer">
        <div className="list">
          <div className="textWithIcon">
            <FontAwesomeIcon icon={faGlobeAsia} />
            <div className="text">Global</div>
          </div>
          <div className="textWithIcon">
            <FontAwesomeIcon icon={faMapMarkedAlt} />
            <div className="text">Local</div>
          </div>
        </div>
      </div>
    );
  }
}
