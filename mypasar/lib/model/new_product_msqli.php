
<?php
    include_once("dbconnect.php");
    $productOwner = $_POST['productOwner'];
    $userEmail = $_POST['userEmail'];
    $productName = $_POST['productName'];
    $productDesc = $_POST['productDesc'];
    $productPrice = $_POST['productPrice'];
    $productQty = $_POST['productQty'];
    $productState = $_POST['productState'];
    $productLoc = $_POST['productLoc'];
    $productLat = $_POST['productLat'];
    $productLong = $_POST['productLong'];
    $date = date_create()->format('Y-m-d H:i:s');
    $encoded_string = $_POST['image'];

    $sqlinsert = "INSERT INTO tbl_product (product_owner,product_name,user_email,product_desc,product_price,product_qty,product_state,product_loc,product_lat,product_long,product_date) 
    VALUES('$productOwner','$productName','$userEmail','$productDesc','$productPrice','$productQty','$productState','$productLoc','$productLat','$productLong','$date')";

    if ($conn->query($sqlinsert) === TRUE) {

        $fileID_hasimage = mysqli_insert_id($conn);
        $filename__hasimage = sha1($_POST["userEmail"].$fileID_hasimage);

        $decoded_string = base64_decode($encoded_string);
        $filename = $filename__hasimage;
        // $path = 'http://smsapp.jatitinggi.com:30080/upload/Test/'.$filename.'.png';
        $path = '../images/products/'.$filename.'.png';
        $is_written = file_put_contents($path, $decoded_string);
        // echo "update image";
       

        $sqlinsert_product_has_image = "INSERT INTO product_has_image (product_id,image_hash_name,upload_by,created_at,path) 
        VALUES('$fileID_hasimage','$filename__hasimage','$productOwner','$date','$path')";
        // echo "update table product_has_image";
            if ($conn->query($sqlinsert_product_has_image) === TRUE) {
                // echo "New record created successfully";
            } else {
                // echo "Error: " . $sqlinsert_product_has_image . "<br>" . $conn->error;
            }
        $response = array('code'=>200,'status' => 'New record created successfully', 'data' => $sqlinsert);
        sendJsonResponse($response);
    } else {
        $response = array('code'=>-100,'status' => 'New record failed to creat', 'data'=>$sqlinsert);
        sendJsonResponse($response);
        // echo "Error: " . $sqlinsert . "<br>" . $conn->error;
    }

    

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>