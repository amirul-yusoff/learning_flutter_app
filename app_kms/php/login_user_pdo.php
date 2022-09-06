<?php

if (isset($_POST["username"]) && isset($_POST["password"])) {
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

	$username = $_POST["username"];
	$password = $_POST["password"];
	
	// Check if SHA1
	$password = sha1($_POST["password"]);


	$password_verify = 0;
	$usernameVerify = '';
	$row = [];
	$projectRows = [];
	$stmt = $pdo->prepare("SELECT * FROM members WHERE username = ?");
	$stmt->execute([$username]);
	$user = $stmt->fetch();
	if ($user && password_verify($_POST['password'], $user['password']))
		{
			$password_verify = 1;
			$usernameVerify = $username;
		} else {
			$password_verify = 0;
	}

	if($password_verify == 0){
		$password = sha1($_POST["password"]);
		$checkSha = $pdo->prepare("SELECT id,employee_name, employee_code, firstname, mbr_email, lastname, nickname, department, position, username,  status, isdelete FROM members WHERE username = ? AND password = ?");
		$checkSha->execute([$username, sha1($_POST["password"])]);
		$validLogin = $checkSha->rowCount();

		if ($validLogin >= 1) {
			$usernameVerify = $username;
		}
	}

	// $validLogin = $stmt->rowCount();
	// $validLoginSha = 0;
	// if ($validLogin >= 1) {
	// 	$stmt = $pdo->prepare("SELECT id,employee_name, employee_code, firstname, mbr_email, lastname, nickname, department, position, username,  status, isdelete FROM members WHERE username = ? AND password = ?");
	// 	$stmt->execute([$username,$password]);
	// 	$row = $stmt->fetch(PDO::FETCH_ASSOC);
	// 	if ($row == FALSE) {
	// 		echo json_encode(array("responseCode" => 200,"responseMessage"=>"Credential Found (not sha)", "data" => $row , "countUser"=>$validLogin));

	// 	}else {
	// 		echo json_encode(array("responseCode" => 200,"responseMessage"=>"Credential Found (not Enc)", "data" => $row , "countUser"=>$validLogin));
	// 	}
	// }


	// if($validLogin >=1 ){

	// 	//checkSha
	// 	$stmt = $pdo->prepare("SELECT id,employee_name, employee_code, firstname, mbr_email, lastname, nickname, department, position, username,  status, isdelete FROM members WHERE username = ? AND password = ?");
	// 	$stmt->execute([$username, $password]);
	// 	$validLogin = $stmt->rowCount();
	// 	if($validLogin == 1){
	// 		while($rows = $stmt->fetch(PDO::FETCH_ASSOC))
	// 		{
	// 			$rowData[] = $rows;
	// 		}
	// 	}

	// 	echo json_encode(array("responseCode" => 200,"responseMessage"=>"Credential Found", "data" => $rowData));

	// }else{
	// 	echo json_encode(array("Response" => array("responseCode" => -100, "responseMessage" => "Wrong password")));
	// }
		// echo json_encode(array("responseCode" => 200,"responseMessage"=>"Credential Found", "data" => $row , "username"=>$usernameVerify));

		if ($usernameVerify == NULL) {
			echo json_encode(array("responseCode" => -100,"responseMessage"=>"Credential Not Found", "data" => $row ));
		}else {
			$user = $pdo->prepare("SELECT * FROM members  WHERE username = ?");
			$user->execute([$usernameVerify]);
			$count = $user->rowCount();
			if ($count > 0)
			{
				while($rows = $user->fetch(PDO::FETCH_ASSOC))
				{
					$projectRows[] = $rows;
				}
			}
			echo json_encode(array("responseCode" => 200,"responseMessage"=>"Credential Found", "projectRows" => $projectRows , "username"=>$usernameVerify));
		}

}  else {
    echo json_encode(array("Response" => array("responseCode" => -100, "responseMessage" => "Username and password cannot be empty")));
}
?>