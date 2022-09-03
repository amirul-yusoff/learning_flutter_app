
<?php

include_once("dbconnect.php");

$sqlloadproduct = "SELECT id,device_name,buy_date,description,warranty_start,warranty_end,supplier,po_name,created_by,ram,capacity,processor,serial_number,department
FROM asset_list ORDER BY id";

$result = $conn->query($sqlloadproduct);
if ($result->num_rows > 0) {
    $response["assetList"] = array();
    while ($row = $result->fetch_assoc()) {
        $prlist = array();
        $prlist['id'] = $row['id'];
        $prlist['device_name'] = $row['device_name'];
        $prlist['buy_date'] = $row['buy_date'];
        $prlist['description'] = $row['description'];
        $prlist['warranty_start'] = $row['warranty_start'];
        $prlist['warranty_end'] = $row['warranty_end'];
        $prlist['supplier'] = $row['supplier'];
        $prlist['po_name'] = $row['po_name'];
        $prlist['created_by'] = $row['created_by'];
        $prlist['ram'] = $row['ram'];
        $prlist['capacity'] = $row['capacity'];
        $prlist['processor'] = $row['processor'];
        $prlist['serial_number'] = $row['serial_number'];
        $prlist['department'] = $row['department'];
        array_push($response["assetList"],$prlist);
    }
    $response = array('codeResponse' => 200,'status' => 'success', 'data' => $response["assetList"],'count'=>$result->num_rows);
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