
<?php

include_once("dbconnect.php");

$sqlloadproduct = "SELECT Project_ID,Project_Code,Project_Short_name,Project_Status
FROM project_registry WHERE Project_Status = 'Work In Progress' || Project_Status = 'Active' || Project_Status = 'TOC/CPC' || Project_Status = 'CC/CMGD' ";

$result = $conn->query($sqlloadproduct);
if ($result->num_rows > 0) {
    $response["projectList"] = array();
    while ($row = $result->fetch_assoc()) {
        $prlist = array();
        $prlist['Project_Code'] = $row['Project_Code'];
        $prlist['Project_ID'] = $row['Project_ID'];
        array_push($response["projectList"],$prlist);
    }
    $response = array('codeResponse' => 200,'status' => 'success', 'data' => $response["projectList"],'count'=>$result->num_rows);
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