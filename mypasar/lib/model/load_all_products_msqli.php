<?php

if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");
$userId = $_POST['user_id'];
if ($userId == 0 || $userId  == '' || $userId  == '0') {
    $sqlloadproduct = "SELECT a.product_id,a.product_owner,a.product_name,a.user_email,a.product_desc,a.product_price,a.product_qty,a.product_state,a.product_loc,a.product_lat,a.product_long,a.product_date,
    b.product_id as image_has_product_id ,b.image_hash_name,c.user_id,c.user_name
    FROM tbl_product a 
    left join product_has_image b ON a.product_id = b.product_id
    left join mypasardb.tbl_users c ON a.product_owner = c.user_id
    ORDER BY product_id";

} else {
    $sqlloadproduct = "SELECT a.product_id,a.product_owner,a.product_name,a.user_email,a.product_desc,a.product_price,a.product_qty,a.product_state,a.product_loc,a.product_lat,a.product_long,a.product_date,
    b.product_id as image_has_product_id ,b.image_hash_name,c.user_id,c.user_name
    FROM tbl_product a 
    left join product_has_image b ON a.product_id = b.product_id
    left join mypasardb.tbl_users c ON a.product_owner = c.user_id
    WHERE product_owner = '$userId' ORDER BY product_id";
}

$result = $conn->query($sqlloadproduct);
if ($result->num_rows > 0) {
    $products["products"] = array();
while ($row = $result->fetch_assoc()) {
        $prlist = array();
        $prlist['product_id'] = $row['product_id'];
        $prlist['product_owner'] = $row['product_owner'];
        $prlist['product_name'] = $row['product_name'];
        $prlist['user_email'] = $row['user_email'];
        $prlist['product_desc'] = $row['product_desc'];
        $prlist['product_price'] = $row['product_price'];
        $prlist['product_qty'] = $row['product_qty'];
        $prlist['product_state'] = $row['product_state'];
        $prlist['product_loc'] = $row['product_loc'];
        $prlist['product_lat'] = $row['product_lat'];
        $prlist['product_long'] = $row['product_long'];
        $prlist['product_date'] = $row['product_date'];
        $prlist['image_hash_name'] = $row['image_hash_name'];
        $prlist['user_join_username'] = $row['user_name'];
        array_push($products["products"],$prlist);
    }
    $response = array('status' => 'success', 'data' => $products);
    sendJsonResponse($response);
}else{
    $response = array('status' => 'failed', 'data' => $sqlloadproduct);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

?>