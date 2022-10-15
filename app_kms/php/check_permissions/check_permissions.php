
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
$assetList = $pdo->prepare("SELECT a.* ,b.name
FROM model_has_roles a
LEFT JOIN (
select *
FROM roles)  b 
ON a.role_id = b.id 
where model_id = ? ");
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


echo json_encode(array("responseCode" => 200, "responseMessage" => "Query result success", "project_data" => $assetRows));
?>