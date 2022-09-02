
<?php

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
	
$employeeID = $_POST["employeeID"];
$assetList = $pdo->prepare("SELECT a.* ,b.device_name
FROM asset_list_assign a 
left join (
SELECT device_name ,id 
FROM asset_list)  b 
ON a.asset_id = b.id 
WHERE assign_to = ? AND is_return = 0");
$assetList->execute([$employeeID]);
$count = $assetList->rowCount();
$assetRows = [];
if ($count > 0)
{
    while($rows = $assetList->fetch(PDO::FETCH_ASSOC))
    {
        $assetRows[] = $rows;
    }
}


echo json_encode(array("Response" => array("responseCode" => 200, "responseMessage" => "Query result success"), "project_data" => $assetRows));
?>