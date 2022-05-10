import { configureStore } from "@reduxjs/toolkit";

import slotsReducer from "./reducers/slots";

const store = configureStore({
	reducer: {
		slots: slotsReducer,
	},
});

export default store;
