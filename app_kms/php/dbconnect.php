<?php
    $servername = "172.16.0.9";
    $username = "dbadmin";
    $password = 'D>Pq*]&{G8)3"6dg';
    $dbname = "jtdbv1";

    // Create connection
    $conn = new mysqli($servername, $username, $password,$dbname);

// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}