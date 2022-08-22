<?php
use Carbon\Carbon;

    if (isset($_POST["productOwner"]) && 
    isset($_POST["userEmail"]) && 
    isset($_POST["productName"]) && 
    isset($_POST["productDesc"]) && 
    isset($_POST["productPrice"]) && 
    isset($_POST["productQty"]) && 
    isset($_POST["productState"]) && 
    isset($_POST["productLoc"]) && 
    isset($_POST["productLat"]) && 
    isset($_POST["productLong"]) ) {
    require_once('config.ini.php');
	
    $productOwner = $_POST["productOwner"];
    $userEmail = $_POST["userEmail"];
    $productName = $_POST["productName"];
    $productDesc = $_POST["productDesc"];
    $productPrice = $_POST["productPrice"];
    $productQty = $_POST["productQty"];
    $productState = $_POST["productState"];
    $productLoc = $_POST["productLoc"];
    $productLat = $_POST["productLat"];
    $productLong = $_POST["productLong"];
    $productDate = new DateTime();
	
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
	$insertQuery = $pdo->prepare("INSERT INTO tbl_product 
    (product_owner,product_name,user_email,product_desc,product_price,product_qty,product_state,product_loc,product_lat,product_long,product_date)
    VALUES(?,?,?,?,?,?,?,?,?,?,?)");
    $insertQuery->execute([$productOwner,$userEmail,$productName,$productDesc,$productPrice,$productQty,$productState,$productLoc,$productLat,$productLong,$productDate->format("Y/m/d H:i:s")]);
    echo json_encode(array("responseCode" => 200,"responseMessage"=>"Insert successful"));
    // echo json_encode(array("Response" => array("responseCode" => 200, "responseMessage" => "Insert successful")));

} else {
    echo json_encode(array("responseCode" => -100,"responseMessage"=>"Incomplete Information Posted"));
    // echo json_encode(array("Response" => array("responseCode" => -100, "responseMessage" => "Incomplete Information Posted")));
}
?>
