<?php
if(isset($_POST['adminpassed'])) {
$p_username = $_POST['username'];
$newpassword = $_POST['newpassword'];
$spc_password = base64_encode(addslashes($newpassword ));
$connect = mysqli_connect("localhost","shortland","password!","shortlando");
if (mysqli_connect_errno()) {
  echo "CANT CONNECT:" . mysqli_connect_error();
}
$leg = 10;
$salt = strtr(base64_encode(mcrypt_create_iv(16, MCRYPT_DEV_URANDOM)), '+', '.');
$salt = sprintf("$2a$%02d$", $leg) . $salt;
$enc_password = crypt($spc_password, $salt);
$update_pass = mysqli_query($connect, "UPDATE users SET password = '$enc_password', salt = '$salt' WHERE real_user = '$p_username'") or die(mysqli_error($connect));
echo "<center>Password Updated</center>";
}
require("cookie_login.php");
if(isset($_POST['newpassword'])) {
$le_new_pass = $_POST['newpassword'];
$spc_password = base64_encode(addslashes($le_new_pass));
$connect = mysqli_connect("localhost","shortland","password!","shortlando");
if (mysqli_connect_errno()) {
  echo "CANT CONNECT:" . mysqli_connect_error();
}
$leg = 10;
$salt = strtr(base64_encode(mcrypt_create_iv(16, MCRYPT_DEV_URANDOM)), '+', '.');
$salt = sprintf("$2a$%02d$", $leg) . $salt;
$enc_password = crypt($spc_password, $salt);
$update_pass = mysqli_query($connect, "UPDATE users SET password = '$enc_password', salt = '$salt' WHERE real_user = '$real_username'") or die(mysqli_error($connect));
echo "<center>Password Updated</center>";
}
///////////////
if(isset($_POST['bg'])) {
$connect = mysqli_connect("localhost","shortland","password!","shortlando");
if (mysqli_connect_errno()) {
  echo "CANT CONNECT:" . mysqli_connect_error();
}
$bge = $_POST['bg'];
$forme = $_POST['form'];
$bg = str_replace('#', '', $bge);
$form = str_replace('#', '', $forme);

$tope = $_POST['top'];
$bote = $_POST['bot'];
$top = str_replace('#', '', $tope);
$bot = str_replace('#', '', $bote);

$update_pass = mysqli_query($connect, "UPDATE style SET bg = '$bg', form = '$form', botbar = '$bot', topbar = '$top' WHERE user = '$real_username'") or die(mysqli_error($connect));
echo "<center>Styles Updated </center>";

echo "<script>
   if (top.location.href != self.location.href)
     {
     top.location.href = top.location.href;
     }
</script>";
}
///////////////
$con=mysqli_connect("localhost","shortlando","password!","shortlando");
if (mysqli_connect_errno())
  {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
  }
$result = mysqli_query($con,"SELECT bg, form FROM style WHERE user='$real_username'");
while($row = mysqli_fetch_array($result))
  {
echo "<style>
body {
background: #". $row['bg'] .";
}
form {
border: 1px solid black;
margin: 10px;
padding: 10px 10px;
border-radius: 5px;
background: #". $row['form'] .";
}

</style>";
  }

?>

<!DOCTYPE HTML>
<html>
    <head>
<meta charset="utf-8">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="viewport" content="width=device-width, initial-scale=.9, user-scalable=no"/>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>

 <script src="jquery.minicolors.js"></script>
<link rel="stylesheet" href="jquery.minicolors.css">
        

	<title>iPac-MG</title>					
</head>

<body>
	    
<!-- jQuery -->

	    <style>
@import url(http://fonts.googleapis.com/css?family=Lato);
*{
    -webkit-appearance: none;
    -moz-appearance: none;
    font-family: 'Lato', sans-serif !important;
}

#dpg { 
	-webkit-appearance: none;
	-moz-appearance: none;
	width: 200px;
	height: 22px;
	border: 1px solid black;
	border-radius: 5px;
	color: #000000;
        background-color:white;  
}

#submit{
    color: #000000;
    width: 100px;
    height: 22px;
    border-radius: 5px;
    background-color: #ffffff;
    border: 1px solid #000000;
}
#submit:hover, #submit:active{
    border-radius: 5px;
    background-color: #000000;
    border: 1px solid #ffffff;
    color:#ffffff;
}
#text {
    color: #000000;
    width: 200px;
    height: 22px;
    border: 1px solid black;
    border-radius: 5px;
}
#fancybox {
width: 90%;
height: 400px;
border: 1px solid black;
border-radius: 5px;
background-color: white;
resize: none;
font-size: 12px;
}


	    </style>
<center>
<form method='post'>

<p>Username: <b><?php echo $real_username ?></b></p>

<p>Email: <b><?php echo $real_email ?></b></p>

<p>Change Password: <input type='text' name='newpassword' id='text'/></p>

<input type='submit' id='submit' value='Update'/>
<br>

</form>

<br><br>

<form method='post'>
<b>Change Colors</b><br>
<?php $result = mysqli_query($con,"SELECT bg, form, topbar, botbar FROM style WHERE user='$real_username'");

while($row = mysqli_fetch_array($result))
  {
  
echo "<p>Background: <br><input type='text' name='bg' style='height:32px !important;' id='inline' data-inline='true' value='". $row['bg'] ."' readonly></p>";

echo "<p>Content: <br><input type='text' name='form' style='height:32px !important;' id='inline2' data-inline='true' value='". $row['form'] ."' readonly></p>";

echo "<p>Top Bar: <br><input type='text' name='top' style='height:32px !important;' id='inline3' data-inline='true' value='". $row['topbar'] ."' readonly></p>";

}
?>

<input type='submit' id='submit' value='Update'/>

</form>

</center>


<script>
$(document).ready( function() {
$("#inline").minicolors();
$("#inline2").minicolors();
$("#inline3").minicolors();
$("#inline4").minicolors();
});
</script>
