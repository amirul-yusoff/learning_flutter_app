
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
	
$assetList = $pdo->prepare("SELECT a.id,a.device_name,a.description,a.serial_number,
b.asset_id,b.assign_to,b.updated_at,
c.employee_code,c.employee_name,c.id as members_tbl_id
FROM jtdbv1.asset_list a 
left join (
SELECT asset_id,assign_to,updated_at,id as asset_tbl_id
FROM jtdbv1.asset_list_assign 
GROUP BY id DESC)  b 
 ON a.id = b.asset_id 
LEFT JOIN jtdbv1.members c 
 ON b.assign_to = c.id
--   WHERE device_name = 'JTINHQLP00008'
Group by asset_id");
$assetList->execute();
$count = $assetList->rowCount();
if ($count > 0)
{
    while($rows = $assetList->fetch(PDO::FETCH_ASSOC))
    {
        $assetRows[] = $rows;
    }
}


echo json_encode(array("Response" => array("responseCode" => 200, "responseMessage" => "Query result success"), "project_data" => $assetRows));
?>