
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
	
	$workorder_number = $_POST["workorder_number"];
	$wo_category_short_name = $_POST["wo_category_short_name"];
$projectQuery = $pdo->prepare("SELECT sum(qty) as sum FROM work_order_categories_items  WHERE workorder = ? AND wo_category_short_name = ? ");
$projectQuery->execute([$workorder_number,$wo_category_short_name]);
$count = $projectQuery->rowCount();
$projectRows = [];
if ($count > 0)
{
    while($rows = $projectQuery->fetch(PDO::FETCH_ASSOC))
    {
        $projectRows[] = $rows;
    }
}


echo json_encode(array("Response" => array("responseCode" => 200, "responseMessage" => "Query result success"), "project_data" => $projectRows));
?>

