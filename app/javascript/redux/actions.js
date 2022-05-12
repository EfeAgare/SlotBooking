import baseApi from "../components/API/baseApi";
import {
	FETCH_AVAILABLE_SLOTS_LOADING,
	ADD_SLOT,
	FETCH_AVAILABLE_SLOTS,
	FETCH_AVAILABLE_SLOTS_ERROR,
	CREATE_SLOTS_LOADING,
	CREATE_SLOTS_ERROR,
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
		dispatch({ type: FETCH_AVAILABLE_SLOTS_ERROR });
	}
};

export const createSlot = (data) => async (dispatch) => {
	dispatch({ type: CREATE_SLOTS_LOADING });

	try {
		const response = await baseApi.post("/slot", data);

		return dispatch(addSlot(response.data));
	} catch ({ response }) {
		dispatch({ type: CREATE_SLOTS_ERROR });
	}
};
