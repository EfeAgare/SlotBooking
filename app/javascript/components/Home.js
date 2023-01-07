import React, { useState } from "react";
import {
	Button,
	Container,
	Stack,
	TextField,
	Typography,
	Grid,
	Box,
} from "@mui/material";
import DateInput from "./common/DateInput";
import Divider from "@mui/material/Divider";
import { useDispatch, useSelector } from "react-redux";
import { createSlot, fetchAvailableSlots } from "../redux/actions";

const Home = () => {
	const [duration, setDuration] = useState("");
	const [date, setDate] = useState(null);
	const dispatch = useDispatch();

	const slots = useSelector((state) => state.slots);

	const onChange = (e) => {
		const re = /^[0-9\b]+$/;
		if (e.target.value === "" || re.test(e.target.value)) {
			setDuration(e.target.value);
		}
	};

	const fetchSlots = () => {
		const data = {
			date: date,
			duration: duration,
		};

		dispatch(fetchAvailableSlots(data));
	};

	const handleSubmit = (slot) => {
		const data = {
			date: date,
			duration: duration,
			slot: slot[0],
		};

		dispatch(createSlot(data));
	};

	return (
		<>
			<Box
				sx={{
					bgcolor: "background.paper",
					pt: 8,
					pb: 5,
				}}
			>
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
					<Typography
						variant="h5"
						align="center"
						color="text.secondary"
						paragraph
					>
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
							onClick={fetchSlots}
							disabled={!!date && !!duration ? false : true}
						>
							Show available slots
						</Button>
					</Stack>
				</Container>
			</Box>
			<Container sx={{ py: 1 }} maxWidth="md">
				{slots.isLoading ? (
					<Grid container spacing={4}>
						<Typography>Loading</Typography>
					</Grid>
				) : null}

				<Grid container spacing={4}>
					{!slots.isLoading && slots.slots.length > 0
						? slots.slots.map((slot) => (
							<Grid item key={slot}>
								<Button variant="outlined" onClick={() => handleSubmit(slot)}>
									{slot[0]}
								</Button>
							</Grid>
						))
						: null}
				</Grid>

				<Grid container spacing={4}>
					{!slots.isLoading && Object.keys(slots.slot).length !== 0
						? slots.slot.length !== 1 ?
							<Grid item >
								<Typography>{slots.slot[0]} - </Typography> <Typography> {slots.slot[1]} Booked</Typography>
							</Grid>
							: <Grid item>
								<Typography>{slots.slot}</Typography>
							</Grid>
						: null}
				</Grid>
			</Container>
		</>
	);
};

export default Home;
