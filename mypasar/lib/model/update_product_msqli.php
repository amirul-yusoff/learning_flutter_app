
<?php
    include_once("dbconnect.php");
    $prid = $_POST['prid'];
    $productOwner = $_POST['userid'];
    $productName = $_POST['prname'];
    $productDesc = $_POST['prdesc'];
    $productPrice = $_POST['prprice'];
    $productQty = $_POST['prqty'];
    $date = date_create()->format('Y-m-d H:i:s');

    $sqlupdate = "UPDATE tbl_product SET product_name='$productName', product_desc ='$productDesc', product_price='$productPrice',product_qty='$productQty',updated_at='$date' WHERE  product_id = '$prid'";
    $result = $conn->query($sqlupdate);
    

    if (isset($_POST["image"])) {
        $sqlchecker = "SELECT product_id FROM product_has_image WHERE  product_id = '$prid'";
        $result = $conn->query($sqlchecker);
        $encoded_string = $_POST['image'];
        $fileID_hasimage = mysqli_insert_id($conn);
        $filename__hasimage = sha1($_POST["userid"].$date);

        $decoded_string = base64_decode($encoded_string);
        $filename = $filename__hasimage;
        // $path = 'http://smsapp.jatitinggi.com:30080/upload/Test/'.$filename.'.png';
        $path = '../images/products/'.$filename.'.png';
        $is_written = file_put_contents($path, $decoded_string);
        // echo "update image";

        if ($result->num_rows >= 1) {
            $sqlupdate = "UPDATE product_has_image SET image_hash_name='$filename', upload_by='$productOwner', created_at='$date' WHERE  product_id = '$prid'";
            $result = $conn->query($sqlupdate);
            
                if ($conn->query($sqlupdate) === TRUE) {
                    // echo "New record created successfully";
                } else {
                    // echo "Error: " . $sqlinsert_product_has_image . "<br>" . $conn->error;
                }
                $response = array('code'=>200,'status' => 'New record created successfully update image', 'data' => $sqlupdate);
        }else {
            $sqlinsert_product_has_image = "INSERT INTO product_has_image (product_id,image_hash_name,upload_by,created_at,path) 
            VALUES('$fileID_hasimage','$filename__hasimage','$productOwner','$date','$path')";
            // echo "update table product_has_image";
                if ($conn->query($sqlinsert_product_has_image) === TRUE) {
                    // echo "New record created successfully";
                } else {
                    // echo "Error: " . $sqlinsert_product_has_image . "<br>" . $conn->error;
                }
                $response = array('code'=>200,'status' => 'else', 'data' => $sqlinsert_product_has_image);
        }
        
    }else{
        $response = array('code'=>200,'status' => 'no image selected', 'data' => $prid);
    }

    sendJsonResponse($response);

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>