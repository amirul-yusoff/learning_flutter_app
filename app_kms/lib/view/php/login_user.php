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

	$stmt = $pdo->prepare("SELECT id,employee_name, employee_code, firstname, mbr_email, lastname, nickname, department, position, username,  status, isdelete FROM members WHERE username = ? AND password = ?");
	$stmt->execute([$username, $password]);
	$validLogin = $stmt->rowCount();

	if ($validLogin == 0) {
		// If fails on sha1 login, does bcrypt verification
		$stmtBcrypt = $pdo->prepare("SELECT id,employee_name, employee_code, firstname, mbr_email, lastname, nickname, department, position, username,  status, isdelete, password FROM members WHERE username = ?");
		$stmtBcrypt->execute([$username]);
		$checkBcrypt = $stmtBcrypt->rowCount();
		while($rowBcrypt = $stmtBcrypt->fetch(PDO::FETCH_ASSOC)) {
			$password = $rowBcrypt['password'];
			if (password_verify($_POST["password"], $password)) {
				$stmt = $pdo->prepare("SELECT id,employee_name, employee_code, firstname, mbr_email, lastname, nickname, department, position, username,  status, isdelete FROM members WHERE username = ?");
				$stmt->execute([$username]);
				$validLogin = $stmt->rowCount();
			} else {
				$validLogin = 0;
			}
		}

	}else{
		echo json_encode(array("responseCode" => 200,"responseMessage"=>"Credential Found Using Hash", "data" => $rowData));
	}

	if ($validLogin && $validLogin > 0)
	{
		while($rowData = $stmt->fetch(PDO::FETCH_ASSOC))
		{
			$stmt2 = $pdo->prepare("SELECT employee_code FROM permission WHERE employee_code = ? AND module_id = '7'");
			$employeCode = $rowData['employee_code'];
			$stmt2->execute([$employeCode]);
			$checkPermissionQuery = $stmt2->rowCount();

			echo json_encode(array("responseCode" => 200,"responseMessage"=>"Credential Found Using Encypt", "data" => $rowData));
			$stmt2 = null;
		}
		$stmt = null;

    }
    else
	{
		echo json_encode(array("responseCode" => -100,"responseMessage"=>"Account not found", "data" => $rowData));
    }
}  else {
    echo json_encode(array("Response" => array("responseCode" => -100, "responseMessage" => "Username and password cannot be empty")));
}
?>