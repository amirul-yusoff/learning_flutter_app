<?php

if (isset($_POST["email"]) && isset($_POST["password"])) {
    require_once('config.ini.php');
	$dsn = "mysql:host=".DB_SERVER.";dbname=".DB_DATABASE.";charset=utf8mb4";
	$options = [
		PDO::ATTR_EMULATE_PREPARES   => false, // turn off emulation mode for "real" prepared statements
		PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION, //turn on errors in the form of exceptions
		PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC, //make the default fetch be an associative array
	];
	try {
		$pdo = new PDO($dsn, DB_USER, DB_PASS, $options);
	} catch (Exception $e) {
		error_log($e->getMessage());
		exit('Something weird happened'); //something a user can understand
	}

	$user_email = $_POST["email"];
	$user_password = $_POST["password"];
	$validLoginUsernameAndPassword = 0;
	$validLoginUsername = 0;
	// Check if SHA1
	$user_password = sha1($_POST["password"]);

	$stmt = $pdo->prepare("SELECT user_id, user_email, user_name, user_phone, user_password, user_address, user_datareg, otp FROM tbl_users WHERE user_email = ? AND user_password = ?");
	$stmt->execute([$user_email, $user_password]);
	$validLoginUsernameAndPassword = $stmt->rowCount();

	if ($validLoginUsernameAndPassword == 0) {
		$stmt = $pdo->prepare("SELECT user_id, user_email, user_name, user_phone, user_password, user_address, user_datareg, otp FROM tbl_users WHERE user_email = ?");
		$stmt->execute([$user_email]);
		$validLoginUsername = $stmt->rowCount();

		if ($validLoginUsername == 1) {
			echo json_encode(array("Response" => array("responseCode" => -100, "responseMessage" => "Wrong password")));
		}
		if ($validLoginUsername == 0) {
			echo json_encode(array("Response" => array("responseCode" => -100, "responseMessage" => "Credential Not Found")));
		}

	} else {
		$rowData = $stmt->fetch(PDO::FETCH_ASSOC);
		$rowData = json_encode($rowData);
		echo json_encode(array("responseCode" => 200,"responseMessage"=>"Credential Found", "data" => $rowData));
		// echo json_encode(array("Response" => array("responseCode" => 200, "responseMessage" => "Credential Found"), "data" => $rowData));
	}

	
}  else {
    echo json_encode(array("Response" => array("responseCode" => -100, "responseMessage" => "Username and password cannot be empty")));
}
?>