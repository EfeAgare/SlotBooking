import React from "react";
import { Route, Routes, BrowserRouter } from "react-router-dom";
import Header from "./common/Header";
import Home from "./Home";

const App = () => {
	return (
		<BrowserRouter>
			<Header />
			<Routes>
				<Route exact path="/" element={<Home />} />
			</Routes>
		</BrowserRouter>
	);
};

export default App;
