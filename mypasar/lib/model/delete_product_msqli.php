
<?php

    if (!isset($_POST)) {
        $response = array('status' => 'failed', 'data' => null);
        sendJsonResponse($response);
        die();
    }

    include_once("dbconnect.php");
    $prid = $_POST['prid'];
    $sqldelete = "DELETE FROM `tbl_product` WHERE product_id = '$prid'";
    if ($conn->query($sqldelete) === TRUE) {
        $response = array('codeResponse' => 200,'status' => 'success', 'data' => null);
        sendJsonResponse($response);
    } else {
        $response = array('codeResponse' => -100,'status' => 'failed', 'data' => null);
        sendJsonResponse($response);
    }

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>