import * as React from "react";
import Toolbar from "@mui/material/Toolbar";
import Typography from "@mui/material/Typography";
import { AppBar, CssBaseline } from "@mui/material";

const Header = ()  => {
	return (
		<React.Fragment>
			<CssBaseline />
			<AppBar position="relative">
				<Toolbar>
					<Typography variant="h6" color="inherit" noWrap>
						BookSlot
					</Typography>
				</Toolbar>
			</AppBar>
		</React.Fragment>
	);
}

export default Header;
