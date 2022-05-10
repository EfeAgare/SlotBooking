import {
	ADD_SLOT,
	FETCH_AVAILABLE_SLOTS,
	FETCH_AVAILABLE_SLOTS_LOADING,
} from "../actionTypes";

const initialState = {
	slots: [],
	isLoading: false,
	error: false,
};

export default function (state = initialState, action) {
	switch (action.type) {
		case ADD_SLOT: {
			return { ...state, isLoading: false, slots: action.payload };
		}

		case FETCH_AVAILABLE_SLOTS_LOADING:
			return {
				...state,
				isLoading: true,
			};

		case FETCH_AVAILABLE_SLOTS: {
			return {
				...state,
				slots: action.payload,
				isLoading: false,
			};
		}

		default:
			return state;
	}
}
