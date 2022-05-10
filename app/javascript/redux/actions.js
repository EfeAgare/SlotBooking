import baseApi from "../components/API/baseApi";
import {
	FETCH_AVAILABLE_SLOTS_LOADING,
	ADD_SLOT,
	FETCH_AVAILABLE_SLOTS,
} from "./actionTypes";

export const addSlot = (content) => ({
	type: ADD_SLOT,
	payload: content,
});

export const fetchSlots = (content) => ({
	type: FETCH_AVAILABLE_SLOTS,
	payload: content,
});

export const fetchAvailableSlots = (data) => async (dispatch) => {
	dispatch({ type: FETCH_AVAILABLE_SLOTS_LOADING });

	try {
		const response = await baseApi.get("/slot", {
			params: data,
		});

		return dispatch(fetchSlots(response.data));
	} catch ({ response }) {
		console.log(response);
	}
};
