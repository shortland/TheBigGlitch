<?php   


$uc_safe = addslashes($_COOKIE['u_cookie']);
$pc_safe = addslashes($_COOKIE['p_cookie']);
include 'cookie_login.php';
if (!isset($uc_safe) && !isset($pc_safe)){
echo "Not logged in.";
die();
}
define('DB_NAME', 'shortlando');
define('DB_USER', 'shortland');
define('DB_PASSWORD', 'password!');
define('DB_HOST', 'localhost');

$link = mysql_connect(DB_HOST, DB_USER, DB_PASSWORD);

if (!$link) {
    die('Could not connect: ' . mysql_error());
}    

$db_selected = mysql_select_db(DB_NAME, $link);

if (!db_selected) {
	die('Can\'t use ' . DB_NAME . ': ' . mysql_error());
}

$sql = "UPDATE users SET version = '11' WHERE username = '$real_username'";

if (!mysql_query($sql)) {
    die('Error: ' . mysql_error());
}

mysql_close();

/// END 

    
?>