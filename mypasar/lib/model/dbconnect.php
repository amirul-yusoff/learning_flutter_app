<?php
    $servername = "172.16.0.24";
    $username = "root";
    $password = "mgcaoKYwfnr4omRCUloQ";
    $dbname = "mypasardb";

    // Create connection
    $conn = new mysqli($servername, $username, $password,$dbname);

// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}
?>