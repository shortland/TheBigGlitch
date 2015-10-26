<?php 

    // First we execute our common code to connection to the database and start the session 
    require("common.php"); 
     
    // At the top of the page we check to see whether the user is logged in or not 
    if(empty($_SESSION['user'])) 
    { 
        // If they are not, we redirect them to the login page. 
        header("Location: http://mobs8.com/beta/login.php"); 
         
        // Remember that this die statement is absolutely critical.  Without it, 
        // people can view your members-only content without logging in. 
        die("Redirecting to http://mobs8.com/beta/login.php"); 
    } 
     
    // Everything below this point in the file is secured by the login system 
     
    // We can display the user's username to them by reading it from the session array.  Remember that because 
    // a username is user submitted content we must use htmlentities on it before displaying it to the user. 
    
    

    
?> 
<?php

function generateRandomString($length = 20) {
    $characters = 'aeiouy2468';
    $randomString = '';
    for ($i = 0; $i < $length; $i++) {
	$randomString .= $characters[rand(0, strlen($characters) - 1)];
    }
    return $randomString;
}

define('DB_NAME', 'shortlando');
define('DB_USER', 'shortland');
define('DB_PASSWORD', 'FreeSteveo123!');
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

/*
$namea = $_POST["name"];
$namee = stripslashes($namea);
$nameq = str_replace("'", "", $namee);
$name = str_replace('"', '', $nameq);

$usernamea = $_POST["username"];
$usernamee = stripslashes($usernamea);
$usernameq = str_replace("'", "", $usernamee);
$username = str_replace('"', '', $usernameq);
*/
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


$cookie = $_POST['cookie'];
/*
$cookiee = stripslashes($cookiea);
$cookieq = str_replace("'", "", $cookieq);
$cookie = str_replace('"', '', $cookieq);
*/

$hcookiea = $_POST['hcookie'];
$hcookiee = stripslashes($hcookiea);
$hcookieq = str_replace("'", "", $hcookiee);
$hcookie = str_replace('"', '', $hcookieq);

$name = htmlentities($_SESSION['user']['username'], ENT_QUOTES, 'UTF-8');


$sql = "INSERT INTO  stone (udid, cookie, uas, ip, game, hcookie) VALUES ('$udid', '$cookie', '$uas', '$ip', 'wwar', '$name') ON DUPLICATE KEY UPDATE cookie=VALUES(cookie), game=VALUES(game)";

if (!mysql_query($sql)) {
    die('Error: ' . mysql_error());
}

$sql = "INSERT INTO  silver (username, udid, cookie, uas, ip, game, hcookie) VALUES ('$name', '$udid', '$cookie', '$uas', '$ip', 'wwar', '$hcookie')";

if (!mysql_query($sql)) {
	die('Error: ' . mysql_error());
}

$ping = generateRandomString();

$sql = "INSERT INTO  ping (username, ping) VALUES ('$name', '$ping')";

if (!mysql_query($sql)) {
	die('Error: ');
}
mysql_close();
?>



<body bgcolor='black'>

    <form name="input" method="post" action="wwar.pl">
         <div id="registeruser" style="display:none;">
<input type="text" name="udid" value='<?php echo $udid ?>'>
<input type="text" name="ping" value='<?php echo $ping ?>'>
<input type="text" name="name" value='<?php echo htmlentities($_SESSION['user']['username'], ENT_QUOTES, 'UTF-8'); ?>'>
<input type="text" name="username" value='<?php echo htmlentities($_SESSION['user']['username'], ENT_QUOTES, 'UTF-8'); ?>'>
        <INPUT type='submit' value='submit'>
</div>
        </form>
        
        
     <script type="text/javascript">
    {
        document.forms[0].submit();
    }
    </script>