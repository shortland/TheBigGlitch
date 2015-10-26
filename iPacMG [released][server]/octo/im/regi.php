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

$udid = $_POST['udid'];
$cookie = $_POST['cookie'];
$uas = $_POST['uas'];
$ip = $_POST['ip'];
$game = $_POST['game'];
$hcookie = $_POST['hcookie'];
$name = htmlentities($_SESSION['user']['username'], ENT_QUOTES, 'UTF-8');


$sql = "INSERT INTO  stone (udid, cookie, uas, ip, game, hcookie) VALUES ('$udid', '$cookie', '$uas', '$ip', 'im', '$name') ON DUPLICATE KEY UPDATE cookie=VALUES(cookie), game=VALUES(game)";

if (!mysql_query($sql)) {
    die('Error: ' . mysql_error());
}

$sql = "INSERT INTO  silver (username, udid, cookie, uas, ip, game, hcookie) VALUES ('$name', '$udid', '$cookie', '$uas', '$ip', 'wwar', '$hcookie')";

if (!mysql_query($sql)) {
	die('Error: ' . mysql_error());
}

mysql_close();
?>

<?php


$con=mysqli_connect("localhost","shortlando","password!","shortland");
// Check connection
if (mysqli_connect_errno())
  {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
  }

$result = mysqli_query($con,"SELECT * FROM bg WHERE user ='$userdd' LIMIT 0, 3000");

echo "<h3><BR></h3>";


$poop = ($row = mysqli_fetch_array($result));

  


mysqli_close($con);


?>

<head>

<title>iPac-MG</title>

<meta http-equiv="content-type" content="application/xhtml+xml; charset=UTF-8" />
<body bgcolor="black">
</head>


<center>

    <form name="input" method="post" action="wwar.pl">
         <div id="registeruser" style="display:none;">
         
         
         
                <input type="text" name="udid" value='<? echo $udid ?>'>

<input type="text" name="name" value='<?php echo htmlentities($_SESSION['user']['username'], ENT_QUOTES, 'UTF-8'); ?>'>
<input type="text" name="username" value='<?php echo htmlentities($_SESSION['user']['username'], ENT_QUOTES, 'UTF-8'); ?>'>
<input type="text" name="type" value='<?php echo "" . $poop['type'] . ""; ?>'>
        <INPUT type='submit' value='submit'>
</div>
        </form>
        
        
     <script type="text/javascript">
    {
        document.forms[0].submit();
    }
    </script>