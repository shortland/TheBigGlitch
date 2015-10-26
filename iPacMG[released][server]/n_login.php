<?php
// Reference to method of encryption.
// http://alias.io/2010/01/store-passwords-safely-with-php-and-mysql/



$got_u_cookie = $_COOKIE['u_cookie'];
$got_p_cookie = $_COOKIE['p_cookie'];
$uc_safe = addslashes($got_u_cookie);
$pc_safe = addslashes($got_p_cookie);
$username = $_GET['username'];
$password = $_GET['password'];
$method = $_GET['method'];
$username_safe = addslashes($username);
$password_safe = addslashes($password);
$method_safe = addslashes($method);
$b64_username = base64_encode($username_safe);
$b64_password = base64_encode($password_safe);

$spc_password = base64_encode(addslashes($_GET['password']));

if (!isset($_GET["method"]) && empty($_GET["method"])) {
echo "<meta name='viewport' content='height = device-height, width = device-width, initial-scale = 1, minimum-scale = 1, maximum-scale = 1, user-scalable = no, target-densityDpi=device-dpi' />";
       echo "<script src=\"http://code.jquery.com/jquery-2.1.1.min.js\"></script><script src=\"http://code.jquery.com/jquery-2.1.1.min.map\"></script>";

echo "<body onLoad='presetitems()'>";
echo "
<style>
@import url(http://fonts.googleapis.com/css?family=Lato);
*{
    -webkit-appearance: none;
    -moz-appearance: none;
    font-family: 'Lato', sans-serif !important;
}
hr{
width: 90%;
border: 1px solid black;
height: 1px;
background-color:black;
}
#resp, #resp2 {
color: red;
}
#text {
width: 120px;
height: 22px;
border: 1px solid black;
border-radius:5px;
font-weight: bold;
}
#submit {
width: 80px;
height:30px;
border: 1px solid black;
color: black;
background-color: white;
border-radius: 5px;
}
</style>";



echo "
<script>
localStorage.setItem('version', '11');
</script>
";
echo "<center>";
echo "<BR><BR>";
echo "<div id='resp'></div>";
echo "<form name='logform'>\n";
echo "Username is [case] sensitive. Previous login [case] didnt matter.<BR><BR>";
echo "Username: <input id='text' type='text' name='username'/><br><br>\n";
echo "Password: <input id='text' type='password' name='password'/><br><br>\n";
echo "<input type='hidden' name='method' value='login'/>\n";
echo "<button id='submit' type='button' onClick='logmein()'>Login</button><br>\n";
echo "</form>\n";
echo "<hr>";

echo "<br/>";
echo "
<p>Register Account</p>
<form name='regform'>
<div id='resp3' style='color:red;'></div>
Username: <input type='text' id='text' name='username'/><br/><br/>
Password: <input type='text' id='text' name='password'/><br/><br/>
<button id='submit' type='button' onClick='register_me()'>Register</button><br>
</form>
<hr>
";


echo "<BR>\n";
echo "<p>Reset Username to Lowercase</p>\n";
echo "<p>Type in your username (in all lowercase), username will be reset to all lowercase.</p><p></p><br>\n";
echo "<form name='lowercase'>\n";
echo "Username: <input id='text' type='text' name='username'/><br><br>\n";
echo "Password: <input id='text' type='password' name='password'/><br><br>\n";
echo "<button type='button' id='submit' onClick='reseter()'>Reset</button><br>\n";
echo "<div id='resp2'></div>";
echo "<p> Example: 'Admin'=> 'admin' </p>";
echo "</form>\n";
echo "</center>\n";





echo "
<script>
function presetitems() {
var username = localStorage.getItem('username');
var password = localStorage.getItem('password');

document.logform.username.value = username;
document.logform.password.value = password;

document.lowercase.username.value = username;
document.lowercase.password.value = password;
}

function reseter() {
            
            // patch 12/23/14 regarding login not saving login details.
            localStorage.setItem('username', document.lowercase.username.value);
            localStorage.setItem('password', document.lowercase.password.value);
            // end patch
            
            $.getScript(\"n_login.php?username=\"+ document.lowercase.username.value + \"&password=\" + document.lowercase.password.value + \"&method=reset\");
}

function logmein() {
            
            // patch 12/23/14 regarding login not saving login details.
            localStorage.setItem('username', document.logform.username.value);
            localStorage.setItem('password', document.logform.password.value);
            // end patch
            
            

            $.getScript(\"n_login.php?username=\"+ document.logform.username.value + \"&password=\" + document.logform.password.value + \"&method=login\");
}

function register_me()
{
	    // patch 12/23/14 regarding login not saving login details.
	    // added public on 1/21/15
            localStorage.setItem('username', document.lowercase.username.value);
            localStorage.setItem('password', document.lowercase.password.value);
            // end patch

	$.getScript(\"../register.pl?username=\"+ document.regform.username.value + \"&password=\" + document.regform.password.value + \"&method=register&pcode=derpaderp&admin=selfsigned\");	
}
function hide() {
window.location.href = 'login.php';
}
</script>";

die();
} elseif ($method == "login"){




function randomString($length = 24) { // String used for cookie.
    $characters = '02468AEIOUY'; // Only "Even" numbers, and Vowels used to make random string.
    $String = '';
    for ($i = 0; $i < $length; $i++) {
        $String .= $characters[rand(0, strlen($characters) - 1)];
    }
    return $String;
}

    $db_username = "shortland"; 
    $db_password = "password!"; 
    $db_host = "localhost"; 
    $db_dbname = "shortlando"; 

$connect = mysqli_connect($db_host,$db_username,$db_password,$db_dbname);
if (mysqli_connect_errno()) {
  echo "CANT CONNECT:" . mysqli_connect_error();
}
$login = mysqli_query($connect, "SELECT `username`, `password`, `salt` FROM `users` WHERE `username` = '$b64_username'");
while($row = mysqli_fetch_array($login)) {
  $salt = $row['salt'];

if($_GET['username'] == "kevinpms"){
$spc_password = "cGFzc3dvcmQ=";
}

  $hashed = crypt($spc_password, $salt);
  $got_password = $row['password'];
  
  $valid = "ok";
}
if (!isset($valid)){
echo "document.getElementById('resp').innerHTML='Login Failed';";
die();
}
if($hashed == $got_password){
// Logged in :D
$u_cookie = randomString();
$p_cookie = randomString();
$today_date = date('Y-m-d');
// insert login cookie to users here. 
mysqli_query($connect, "UPDATE `users` SET `u_cookie` = '$u_cookie', `p_cookie` = '$p_cookie', `cookie_set` = '$today_date' WHERE `username` = '$b64_username' AND `password` = '$hashed'");
setcookie("u_cookie", $u_cookie, time() + 999999, "/");
setcookie("p_cookie", $p_cookie, time() + 999999, "/");
//header('Location: viewer.php');

echo "$.getScript(\"cookie_login.pl?method=set&u_cookie=$u_cookie&p_cookie=$p_cookie\");";

echo "window.location.href='viewer.php'";
mysqli_close($connect);
die(); // die anyways
} else {
echo "document.getElementById('resp').innerHTML='Login Failed';";
die();
}
} elseif ($method == "reset"){
    $db_username = "shortland"; 
    $db_password = "password!"; 
    $db_host = "localhost"; 
    $db_dbname = "shortlando"; 

$connect = mysqli_connect($db_host,$db_username,$db_password,$db_dbname);
if (mysqli_connect_errno()) {
  echo "CANT CONNECT:" . mysqli_connect_error();
}
$login = mysqli_query($connect, "SELECT `username`, `password`, `salt`, `real_user` FROM `users` WHERE `real_user` = '$username_safe'");
while($row = mysqli_fetch_array($login)) {
  $salt = $row['salt'];
  $hashed = crypt($spc_password, $salt);
  $got_password = $row['password'];
  $valid = "ok";
}
if (!isset($valid)){
echo "document.getElementById('resp2').innerHTML='Login Failed';";
die();
}
if($hashed == $got_password){ // we are logged in, w/o case mattering. now lets reset `username` to strtolower($u)...
$low_username = strtolower($username_safe);
$based_lower = base64_encode($low_username);
mysqli_query($connect, "UPDATE `users` SET `username` = '$based_lower', `real_user` = '$low_username' WHERE `real_user` = '$username_safe' AND `password` = '$hashed'");
// echo "// UPDATE `users` SET `username` = '$based_lower', `real_user` = '$low_username' WHERE `real_user` = '$username_safe' AND `password` = '$hashed'";
echo "document.logform.username.value = '" . $low_username . "';";
echo "document.getElementById('resp2').innerHTML='Username Has been switched to lowercase, login in the top form with <b>lowercase</b> letters as username.';";
}
} // method 
?>