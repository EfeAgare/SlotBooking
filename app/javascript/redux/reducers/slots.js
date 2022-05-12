import {
	ADD_SLOT,
	CREATE_SLOTS_LOADING,
	FETCH_AVAILABLE_SLOTS,
	FETCH_AVAILABLE_SLOTS_LOADING,
} from "../actionTypes";

const initialState = {
	slots: [],
	isLoading: false,
	slot: {},
	error: false,
};

export default function (state = initialState, action) {
	switch (action.type) {
		case ADD_SLOT: {
			return { ...state, isLoading: false, slot: action.payload, slots: [] };
		}

		case FETCH_AVAILABLE_SLOTS_LOADING:
		case CREATE_SLOTS_LOADING:
			return {
				...state,
				isLoading: true,
			};

		case FETCH_AVAILABLE_SLOTS: {
			return {
				...state,
				slots: action.payload,
				slot: {},
				isLoading: false,
			};
		}

		default:
			return state;
	}
}
