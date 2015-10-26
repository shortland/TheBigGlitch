<?php
$uc_safe = addslashes($_COOKIE['u_cookie']);
$pc_safe = addslashes($_COOKIE['p_cookie']);
include 'cookie_login.php';
if (!isset($uc_safe) && !isset($pc_safe)){
echo "Not logged in.";
die();
}

$ida = $_POST['id'];
$ide = stripslashes($ida);
$idq = str_replace("'", "", $ide);
$id = str_replace('"', '', $idq);

    $db_username = "shortland"; 
    $db_password = "password!"; 
    $db_host = "localhost"; 
    $db_dbname = "shortlando"; 

$connect = mysqli_connect($db_host,$db_username,$db_password,$db_dbname);
if (mysqli_connect_errno()) {
  echo "CANT CONNECT:" . mysqli_connect_error();
}
mysqli_query($connect, "DELETE FROM accs WHERE id = '$id' AND username = '$real_username' LIMIT 1;");

mysqli_close();

//echo "DELETE FROM accs WHERE id = '$id' AND username = '$real_username' LIMIT 1;";

?>