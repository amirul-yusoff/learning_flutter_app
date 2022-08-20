<?php
use Carbon\Carbon;

if (isset($_POST["name"]) && isset($_POST["email"]) && isset($_POST["password"]) ) {
    require_once('config.ini.php');
	
    $name = $_POST["name"];
    $email = $_POST["email"];
    $password = sha1($_POST["password"]);
    $otp = rand();
    $na = "na";
    $user_datareg = new DateTime();
	
    $responseArray = array();
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

	//  Code to check sum of DR work done
	$insertQuery = $pdo->prepare("INSERT INTO 
    tbl_users 
    (user_email,user_name,user_password,
    user_phone,user_address,otp,user_datareg) 
    VALUES(?,?,?,?,?,
    ?,?)");
    $insertQuery->execute([$email,$name,$password,$na,$na,$otp,$user_datareg->format("Y/m/d H:i:s")]);
    echo json_encode(array("responseCode" => 200,"responseMessage"=>"Insert successful"));
    // echo json_encode(array("Response" => array("responseCode" => 200, "responseMessage" => "Insert successful")));

} else {
    echo json_encode(array("responseCode" => -100,"responseMessage"=>"Incomplete Information Posted"));
    // echo json_encode(array("Response" => array("responseCode" => -100, "responseMessage" => "Incomplete Information Posted")));
}
?>
