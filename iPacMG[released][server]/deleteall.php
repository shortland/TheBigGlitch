<?php 
    require("cookie_login.php"); 
?> 
<?php

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

$sql = 'DELETE FROM storage WHERE username = "'.$real_username.'";';

if (!mysql_query($sql)) {
    die('Error: ' . mysql_error());
}
mysql_close();
?>
<META http-equiv="refresh" content="0;URL=retrieve.php">

