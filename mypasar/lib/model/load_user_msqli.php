<?php

include_once("dbconnect.php");

$userId = $_POST['user_id'];
$sqluser = "SELECT user_id,user_name,user_email,user_phone,user_password,user_address,user_datareg,otp FROM tbl_users WHERE user_id = '$userId'";

$result = $conn->query($sqluser);
if ($result->num_rows > 0) {
while ($row = $result->fetch_assoc()) {
    $userlist = array();
    $userlist['user_id'] = $row['user_id'];
    $userlist['user_email'] = $row['user_name'];
    $userlist['user_name'] = $row['user_email'];
    $userlist['user_phone'] = $row['user_phone'];
    $userlist['user_address'] = $row['user_address'];
    // $userlist['user_datareg'] = $row['user_datereg'];
    $userlist['otp'] = $row['otp'];
    // $userlist['credit'] = $row['user_credit'];
    $response = array('status' => 'success', 'data' => $userlist);
    sendJsonResponse($response);
    }
}else{
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

?>