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

$udida = $_POST["udid"];
$udide = stripslashes($udida);
$udidq = str_replace("'", "", $udide);
$udid = str_replace('"', '', $udidq);

$gamea = $_POST["game"];
$gamee = stripslashes($gamea);
$gameq = str_replace("'", "", $gamee);
$game = str_replace('"', '', $gameq);

$namea = $_POST["name"];
$namee = stripslashes($namea);
$nameq = str_replace("'", "", $namee);
$name = str_replace('"', '', $nameq);

$devicea = $_POST["device"];
$devicee = stripslashes($devicea);
$deviceq = str_replace("'", "", $devicee);
$device = str_replace('"', '', $deviceq);

$ipa = $_SERVER["REMOTE_ADDR"];
$ip = stripslashes($ipa);

$uasa = $_SERVER["HTTP_USER_AGENT"];
$uase = stripslashes($uasa);
$uasq = str_replace("'", "", $uase);
$uas = str_replace('"', '', $uasq);


$sql = "INSERT INTO  accs (accname, udid, username, game, device, ip, uas) VALUES ('$name', '$udid', '$real_username', '$game', '$device', '$ip', '$uas')";

if (!mysql_query($sql)) {
    die('Invalid input');
}

$sql2 = "INSERT INTO  accs2 (accname, udid, username, game, device, ip) VALUES ('$name', '$udid', '$real_username', '$game', '$device', '$ip')";

if (!mysql_query($sql2)) {
    die('Invalid input');
}


mysql_close();
?>
<META http-equiv="refresh" content="0;URL=new.php">
