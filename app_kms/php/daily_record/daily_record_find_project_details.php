
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
	
	$projectCode = $_POST["project_code"];
$projectQuery = $pdo->prepare("SELECT 
`jtdbv1`.`project_registry`.`Project_ID` AS `Project_ID`,
`jtdbv1`.`project_registry`.`license_company` AS `license_company`,
`jtdbv1`.`project_registry`.`consultant` AS `consultant`,
`jtdbv1`.`project_registry`.`awarded_party` AS `awarded_party`,
`jtdbv1`.`project_registry`.`po_value` AS `po_value`,
`jtdbv1`.`project_registry`.`vendor_bulk_private` AS `vendor_bulk_private`,
`jtdbv1`.`project_registry`.`PO_file` AS `PO_file`,
`jtdbv1`.`project_registry`.`po_no` AS `po_no`,
`jtdbv1`.`project_registry`.`client_pic` AS `client_pic`,
`jtdbv1`.`project_registry`.`Project_Code` AS `Project_Code`,
`jtdbv1`.`project_registry`.`Project_Short_name` AS `Project_Short_name`,
`jtdbv1`.`project_registry`.`project_type` AS `project_type`,
`jtdbv1`.`project_registry`.`project_team` AS `project_team`,
`jtdbv1`.`project_registry`.`Project_Status` AS `Project_Status`,
`jtdbv1`.`project_registry`.`Project_Client` AS `Project_Client`,
`jtdbv1`.`project_registry`.`MainCon1` AS `MainCon1`,
`jtdbv1`.`project_registry`.`Maincon2` AS `Maincon2`,
`jtdbv1`.`project_registry`.`Project_Title` AS `Project_Title`,
`jtdbv1`.`project_registry`.`Project_Contract_No` AS `Project_Contract_No`,
`jtdbv1`.`project_registry`.`project_tender_no` AS `project_tender_no`,
`jtdbv1`.`project_registry`.`tender_id` AS `tender_id`,
`jtdbv1`.`project_registry`.`project_contract_period` AS `project_contract_period`,
`jtdbv1`.`project_registry`.`Project_PO_No` AS `Project_PO_No`,
`jtdbv1`.`project_registry`.`contract_original_value` AS `contract_original_value`,
`jtdbv1`.`project_registry`.`contract_vo_value` AS `contract_vo_value`,
`jtdbv1`.`project_registry`.`Tarikh_Pesanan` AS `Tarikh_Pesanan`,
`jtdbv1`.`project_registry`.`Project_Commencement_Date` AS `Project_Commencement_Date`,
`jtdbv1`.`project_registry`.`Project_Completion_Date` AS `Project_Completion_Date`,
`jtdbv1`.`project_registry`.`contract_eot` AS `contract_eot`,
`jtdbv1`.`project_registry`.`Project_Close_Date` AS `Project_Close_Date`,
`jtdbv1`.`project_registry`.`Project_Liquidity_And_Damages` AS `Project_Liquidity_And_Damages`,
`jtdbv1`.`project_registry`.`Project_Defect_Liability_Period` AS `Project_Defect_Liability_Period`,
`jtdbv1`.`project_registry`.`project_client_gm` AS `project_client_gm`,
`jtdbv1`.`project_registry`.`project_client_kj` AS `project_client_kj`,
`jtdbv1`.`project_registry`.`Project_Client_Manager` AS `Project_Client_Manager`,
`jtdbv1`.`project_registry`.`Project_Client_Engineer` AS `Project_Client_Engineer`,
`jtdbv1`.`project_registry`.`Project_Client_Supervisor` AS `Project_Client_Supervisor`,
`jtdbv1`.`project_registry`.`project_client_foman` AS `project_client_foman`,
`jtdbv1`.`project_registry`.`Project_Prepared_by` AS `Project_Prepared_by`,
`jtdbv1`.`project_registry`.`Project_Date_Prepared` AS `Project_Date_Prepared`,
`jtdbv1`.`project_registry`.`Project_Important_Note` AS `Project_Important_Note`,
`jtdbv1`.`project_registry`.`Retention` AS `Retention`,
`jtdbv1`.`project_registry`.`EntryDate` AS `EntryDate`,
`jtdbv1`.`project_registry`.`zone_code` AS `zone_code`,
`jtdbv1`.`project_registry`.`location` AS `location`,
`jtdbv1`.`project_registry`.`latitude` AS `latitude`,
`jtdbv1`.`project_registry`.`longitude` AS `longitude`,
`jtdbv1`.`project_registry`.`isdelete` AS `isdelete`,
`jtdbv1`.`project_registry`.`Project_Coordinator` AS `Project_Coordinator`,
`jtdbv1`.`project_registry`.`Project_Supervisor` AS `Project_Supervisor`,
`jtdbv1`.`project_registry`.`created_at` AS `created_at`,
`jtdbv1`.`project_registry`.`updated_at` AS `updated_at`,
`jtdbv1`.`project_registry`.`project_gross_profit` AS `project_gross_profit`,
`jtdbv1`.`project_registry`.`client_address_finance` AS `client_address_finance`,
`t2`.`pmName` AS `pmName`,
`t2`.`pmCode` AS `pmCode`,
`t2`.`pmStaffCode` AS `pmStaffCode`,
`t2`.`is_pm1` AS `is_pm1`,
`t3`.`peName` AS `peName`,
`t3`.`peCode` AS `peCode`,
`t3`.`peStaffCode` AS `peStaffCode`,
`t3`.`is_pe1` AS `is_pe1`,
`t4`.`seName` AS `seName`,
`t4`.`seCode` AS `seCode`,
`t4`.`seStaffCode` AS `seStaffCode`,
`t4`.`is_se1` AS `is_se1`,
`t5`.`pdName` AS `pdName`,
`t5`.`pdCode` AS `pdCode`,
`t5`.`pdCode` AS `pdStaffCode`,
`t5`.`is_pd` AS `is_pd`,
`t6`.`hodName` AS `hodName`,
`t6`.`hodCode` AS `hodCode`,
`t6`.`hodStaffCode` AS `hodStaffCode`,
`t6`.`is_hod` AS `is_hod`
FROM
(((((`jtdbv1`.`project_registry`
LEFT JOIN (SELECT 
	`jtdbv1`.`project_member`.`employee_name` AS `pmName`,
		`jtdbv1`.`project_member`.`project_code` AS `pmCode`,
		`jtdbv1`.`project_member`.`employee_code` AS `pmStaffCode`,
		`jtdbv1`.`project_member`.`is_pm1` AS `is_pm1`
FROM
	`jtdbv1`.`project_member`
WHERE
	(`jtdbv1`.`project_member`.`is_pm1` = '1')
GROUP BY `jtdbv1`.`project_member`.`project_code` DESC) `t2` ON ((`jtdbv1`.`project_registry`.`Project_Code` = `t2`.`pmCode`)))
LEFT JOIN (SELECT 
	`jtdbv1`.`project_member`.`employee_name` AS `peName`,
		`jtdbv1`.`project_member`.`project_code` AS `peCode`,
		`jtdbv1`.`project_member`.`employee_code` AS `peStaffCode`,
		`jtdbv1`.`project_member`.`is_pe1` AS `is_pe1`
FROM
	`jtdbv1`.`project_member`
WHERE
	(`jtdbv1`.`project_member`.`is_pe1` = '1')
GROUP BY `jtdbv1`.`project_member`.`project_code` DESC) `t3` ON ((`jtdbv1`.`project_registry`.`Project_Code` = `t3`.`peCode`)))
LEFT JOIN (SELECT 
	`jtdbv1`.`project_member`.`employee_name` AS `seName`,
		`jtdbv1`.`project_member`.`project_code` AS `seCode`,
		`jtdbv1`.`project_member`.`employee_code` AS `seStaffCode`,
		`jtdbv1`.`project_member`.`is_se1` AS `is_se1`
FROM
	`jtdbv1`.`project_member`
WHERE
	(`jtdbv1`.`project_member`.`is_se1` = '1')
GROUP BY `jtdbv1`.`project_member`.`project_code` DESC) `t4` ON ((`jtdbv1`.`project_registry`.`Project_Code` = `t4`.`seCode`)))
LEFT JOIN (SELECT 
	`jtdbv1`.`project_member`.`employee_name` AS `pdName`,
		`jtdbv1`.`project_member`.`project_code` AS `pdCode`,
		`jtdbv1`.`project_member`.`employee_code` AS `pdStaffCode`,
		`jtdbv1`.`project_member`.`is_pd` AS `is_pd`
FROM
	`jtdbv1`.`project_member`
WHERE
	(`jtdbv1`.`project_member`.`is_pd` = '1')
GROUP BY `jtdbv1`.`project_member`.`project_code` DESC) `t5` ON ((`jtdbv1`.`project_registry`.`Project_Code` = `t5`.`pdCode`)))
LEFT JOIN (SELECT 
	`jtdbv1`.`project_member`.`employee_name` AS `hodName`,
		`jtdbv1`.`project_member`.`project_code` AS `hodCode`,
		`jtdbv1`.`project_member`.`employee_code` AS `hodStaffCode`,
		`jtdbv1`.`project_member`.`is_hod` AS `is_hod`
FROM
	`jtdbv1`.`project_member`
WHERE
	(`jtdbv1`.`project_member`.`is_hod` = '1')
GROUP BY `jtdbv1`.`project_member`.`project_code` DESC) `t6` ON ((`jtdbv1`.`project_registry`.`Project_Code` = `t6`.`hodCode`)))
Where `jtdbv1`.`project_registry`.`Project_Code`=?
ORDER BY `jtdbv1`.`project_registry`.`Project_Close_Date` DESC");
$projectQuery->execute([$projectCode]);
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

