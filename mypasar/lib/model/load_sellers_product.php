
<?php

    include_once("dbconnect.php");
    $productOwner = $_POST['productOwner'];

    $sqlloadproduct = "SELECT a.product_id,a.product_owner,a.product_name,a.user_email,a.product_desc,a.product_price,a.product_qty,a.product_state,a.product_loc,a.product_lat,a.product_long,a.product_date,
    b.product_id as image_has_product_id ,b.image_hash_name
    FROM tbl_product a left join product_has_image b ON a.product_id = b.product_id
    WHERE product_owner = '$productOwner' ORDER BY product_id";

    $result = $conn->query($sqlloadproduct);
    if ($result->num_rows > 0) {
        $response["products"] = array();
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
            array_push($response["products"],$prlist);
        }
        $response = array('codeResponse' => 200,'status' => 'success', 'data' => $response["products"],'count'=>$result->num_rows);
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