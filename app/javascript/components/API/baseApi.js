import axios from "axios";

// Solve Can't verify CSRF token authenticity. ActionController::InvalidAuthenticityToken

const CSRFtoken = document.querySelector('[name="csrf-token"]') || {
	content: "no-csrf-token",
};

export default axios.create({
	baseURL: `http://localhost:3000/api/v1`,
	headers: {
		"Content-Type": "application/json",
		common: {
			"X-CSRF-Token": CSRFtoken.content,
		},
	},
});
