
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
	$employeeCode = $_POST["employeeCode"];

$projectQuery = $pdo->prepare("SELECT a.*
FROM project_registry a
LEFT JOIN (
SELECT project_code AS ProjectCodeFromProjectMember FROM project_member WHERE employee_code=? AND 
(is_pm1=1 OR is_pm2=1 OR is_pe1=1 OR is_pe2=1 OR is_se1=1 OR is_se2=1 OR is_hod=1 OR is_pd=1) 
GROUP BY project_code)  b 
ON a.Project_Code = b.ProjectCodeFromProjectMember 
Where b.ProjectCodeFromProjectMember IS NOT NULL");
$projectQuery->execute([$employeeCode]);
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