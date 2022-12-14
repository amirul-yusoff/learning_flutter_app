
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
	

$projectQuery = $pdo->prepare("SELECT *
FROM  project_registry
LEFT JOIN(
    SELECT max( project_member.project_member_id) as maxProjectMemeberID, project_member.role,  project_member.project_code
    FROM  project_member
    where  project_member.role = 'Project Engineer'
    group by  project_member.project_code DESC  
)t2
ON  project_registry.Project_Code = t2.project_code
LEFT JOIN  project_member t1
ON t2.maxProjectMemeberID = t1.project_member_id

LEFT JOIN(
    SELECT max(id) as maxProjectEOTID ,project_id
    FROM  project_eots
    group by  project_eots.project_id DESC
)t3
ON  project_registry.Project_ID = t3.project_id
LEFT JOIN  project_eots t4
ON t3.maxProjectEOTID = t4.id

WHERE 
( project_registry.Project_Status = 'Work In Progress'
and t1.role = 'Project Engineer'
and t1.status = 'Active'
and  project_registry.Project_Commencement_Date != 'NULL'
and  project_registry.Project_Commencement_Date != '0000-00-00'
and  project_registry.Project_Close_Date != 'NULL'
and  project_registry.Project_Close_Date != '0000-00-00'
and  project_registry.Project_Close_Date <= DATE(NOW() + INTERVAL 3 MONTH))
ORDER BY
 project_registry.Project_Close_Date DESC");
$projectQuery->execute();
$count = $projectQuery->rowCount();
if ($count > 0)
{
    while($rows = $projectQuery->fetch(PDO::FETCH_ASSOC))
    {
        $projectRows[] = $rows;
    }
}


echo json_encode(array("Response" => array("responseCode" => 200, "responseMessage" => "Query result success"), "project_data" => $projectRows));
?>