import React, { Component } from "react";
import logo from "./logo.svg";
import "./App.css";

import Day22 from "./Day22";

class App extends Component {
    render() {
        return (
            <div className="App">
                <header className="App-header">
                    <img src={logo} className="App-logo" alt="logo" />
                    <h1 className="App-title">Welcome to React</h1>
                </header>
                <Day22 />
            </div>
        );
    }
}

export default App;
