<?php

header("Content-Type: application/json");

// connect to the CS309 database
$db = mysqli_connect("localhost", "group08", "password", "CS309");

if (mysqli_connect_errno()) {
	die("Database connection failed" .
		mysqli_connect_error() .
		" (" . mysqli_connect_errno() . ")"
	);
}

// make sure we have all of the required arguments
if (!array_key_exists("league", $_GET) || !array_key_exists("user", $_GET) ||
	!array_key_exists("player", $_GET)) {
	die("'league' argument is required");
}

// find the name of the league the user wants, this
// will then be used to determine the name of the draft table 
// for that league
$query  = "SELECT * FROM leagues WHERE id={$_GET["league"]}";

$result = mysqli_query($db, $query);
if (!$result) {
	die("Database query failed with errer: " . mysqli_error($db));
}

$league = mysqli_fetch_assoc($result);
$draft_table = $league["name"] . "_draft";

// parse this league to make sure the given user is a member
$user_found = False;
for ($i = 0; $i < 5; $i++) {
	$key = "member" . $i;
	$user_id = $league[$key];

	// ignore empty user slots
	if ($user_id == $_GET["user"]) {
		$user_found = true;
		break;
	}
}

if ($_GET["user"] == 0) {
	$user_found = True;
}

// throw an error if the user is not a member of the given league
if (!$user_found) {
	echo json_encode(
		array(
			"error" => True,
			"error_msg" => "PLAYER_NOT_MEMBER"
		)
	);

	exit();
}

// next we need to check if the given player has already been drafted
$query = "SELECT * FROM {$draft_table} WHERE user_id={$_GET["user"]} AND id={$_GET["player"]}";

$result = mysqli_query($db, $query);
if ($result) {
	if (mysqli_fetch_assoc($result)) {
		echo json_encode(
			array(
				"error" => True,
				"error_msg" => "PLAYER_ALREADY_DRAFTED"
			)
		);

		exit();
	}
} else {
	die("Database query failed with errer: " . mysqli_error($db));
}

// we now know the player is free for the taking
$query = "UPDATE {$draft_table} SET user_id={$_GET["user"]} WHERE id={$_GET["player"]}";

$result = mysqli_query($db, $query);
if (!$result) {
	die("Database query failed with errer: " . mysqli_error($db));
}

// finished without error
echo json_encode(
	array(
		"error" => False
	)
);

mysqli_close($db);

?>
