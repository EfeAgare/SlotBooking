import React from "react";
import { TextField } from "@material-ui/core";
import { AdapterDateFns } from "@mui/x-date-pickers/AdapterDateFns";
import { LocalizationProvider } from "@mui/x-date-pickers/LocalizationProvider";
import { DatePicker } from "@mui/x-date-pickers/DatePicker";

export default function DateInput({ date, setDate }) {

	return (
		<LocalizationProvider dateAdapter={AdapterDateFns}>
			<DatePicker
				disablePast
				label="Pick a date"
				value={date}
				onChange={(newValue) => {
					setDate(newValue);
				}}
				renderInput={(params) => <TextField {...params} />}
			/>
		</LocalizationProvider>
	);
}
