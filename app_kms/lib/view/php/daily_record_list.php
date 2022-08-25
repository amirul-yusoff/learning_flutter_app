
<?php

include_once("dbconnect.php");

$sqlloadproduct = "SELECT 
daily_record_id,
serial_no,
project_code,
daily_record_date,
-- start_time,
-- end_time,
-- shift,
-- rain_start_time,
-- rain_end_time,
-- record_by,
-- record_date,
-- site_activity,
-- -- problem,
-- solution,
-- isdelete,
-- sync,
-- longitude,
-- latitude,
-- status,
-- is_idle,
-- is_late,
-- is_late,
-- approved_by_pe,
-- review_comment,
-- pe_approval_date,
-- approved_by_pm,
-- created_at,
updated_at
FROM daily_record ORDER BY daily_record_id DESC";

$result = $conn->query($sqlloadproduct);

if ($result->num_rows > 0) {
    $dailyRecord["dailyRecord"] = array();
    while ($row = $result->fetch_assoc()) {
        $prlist = array();
        $prlist['daily_record_id'] = $row['daily_record_id'];
        $prlist['serial_no'] = $row['serial_no'];
        $prlist['project_code'] = $row['project_code'];
        // $prlist['daily_record_date'] = $row['daily_record_date'];
        // $prlist['start_time'] = $row['start_time'];
        // $prlist['end_time'] = $row['end_time'];
        // $prlist['shift'] = $row['shift'];
        // $prlist['rain_start_time'] = $row['rain_start_time'];
        // $prlist['rain_end_time'] = $row['rain_end_time'];
        // $prlist['record_by'] = $row['record_by'];
        // $prlist['record_date'] = $row['record_date'];
        // $prlist['site_activity'] = $row['site_activity'];
        // $prlist['problem'] = $row['problem'];
        // $prlist['solution'] = $row['solution'];
        // $prlist['isdelete'] = $row['isdelete'];
        // $prlist['sync'] = $row['sync'];
        // $prlist['longitude'] = $row['longitude'];
        // $prlist['latitude'] = $row['latitude'];
        // $prlist['status'] = $row['status'];
        // $prlist['is_idle'] = $row['is_idle'];
        // $prlist['is_late'] = $row['is_late'];
        // $prlist['is_late'] = $row['is_late'];
        // $prlist['approved_by_pe'] = $row['approved_by_pe'];
        // $prlist['review_comment'] = $row['review_comment'];
        // $prlist['pe_approval_date'] = $row['pe_approval_date'];
        // $prlist['approved_by_pm'] = $row['approved_by_pm'];
        // $prlist['created_at'] = $row['created_at'];
        // $prlist['updated_at'] = $row['updated_at'];
        array_push($dailyRecord["dailyRecord"],$prlist);
    }
    $response = array('codeResponse' => 200,'status' => 'success', 'data' => $dailyRecord["dailyRecord"],'count'=>$result->num_rows);
    sendJsonResponse($response);
}else{
    $response = array('codeResponse' => -100,'status' => 'failed', 'data' => null,'count'=>0);
    sendJsonResponse($response);
}



    

function sendJsonResponse($sentArray)
{
header('Content-Type: application/json');
echo json_encode($sentArray);
}
?>