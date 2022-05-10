import React, { useState } from "react";
import { Button, Container, Stack, TextField, Typography } from "@mui/material";
import DateInput from "./common/DateInput";
import Divider from "@mui/material/Divider";
import { connect, useDispatch } from "react-redux";
import { fetchAvailableSlots } from "../redux/actions";

const Home = () => {
	const [duration, setDuration] = useState("");
	const [date, setDate] = useState(null);
	const dispatch = useDispatch();

	const onChange = (e) => {
		const re = /^[0-9\b]+$/;
		if (e.target.value === "" || re.test(e.target.value)) {
			setDuration(e.target.value);
		}
	};

	const handleSubmit = () => {
		const data = {
			date: date,
			duration: duration,
		};
		dispatch(fetchAvailableSlots(data));
	};

	return (
		<Container maxWidth="md">
			<Typography
				component="h1"
				variant="h2"
				align="center"
				color="text.primary"
				gutterBottom
			>
				Book Slot
			</Typography>
			<Typography variant="h5" align="center" color="text.secondary" paragraph>
				Simply connecting supply chains end-to-end
			</Typography>
			<Stack
				sx={{ pt: 4 }}
				direction={{ xs: "column", sm: "row" }}
				spacing={{ xs: 1, sm: 2, md: 4 }}
				justifyContent="center"
				divider={<Divider orientation="vertical" flexItem />}
			>
				<DateInput date={date} setDate={setDate} />
				<TextField
					id="standard-basic"
					label="duration in minutes"
					variant="standard"
					size="small"
					value={duration}
					onChange={onChange}
				/>
				<Button
					variant="outlined"
					size="small"
					type="submit"
					onClick={handleSubmit}
					// disabled={!!date && !!duration ? false : true}
				>
					Show available slots
				</Button>
			</Stack>
		</Container>
	);
};

export default Home;
