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
    
    $page = $_GET['_page'];
    $limit = $_GET['_limit'];
    $s = $pdo->prepare("SELECT * FROM daily_record");
    $s->execute();
    $allResp = $s->fetchAll(PDO::FETCH_ASSOC);
    // echo '<pre>';
    // var_dump($allResp);
    $total_results = $s->rowCount();
    $total_pages = ceil($total_results/$limit);
    


    $start = ($page-1)*$limit;

    $stmt = $pdo->prepare("SELECT * FROM daily_record ORDER BY daily_record_id DESC LIMIT $start, $limit");
    $stmt->execute();

    // set the resulting array to associative
    $stmt->setFetchMode(PDO::FETCH_OBJ);
    
    $results = $stmt->fetchAll();
       
    $conn = null;
    
    // var_dump($results);
    
    $no = $page > 1 ? $start+1 : 1;

    echo json_encode(array("Response" => array("responseCode" => $limit, "responseMessage" => $page,), "project_data" => $results));
?>