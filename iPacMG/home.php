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

$con=mysqli_connect("localhost","shortland","password!","shortlando");
if (mysqli_connect_errno())
  {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
  }
$result = mysqli_query($con,"SELECT bg, form, topbar, botbar FROM style WHERE user='$real_username'");
while($row = mysqli_fetch_array($result))
  {
echo "
	<style>
body {
padding: 0; margin: 0; outline: 0;
background-color: #". $row['bg'] .";
 }
	</style>
 ";
 };

echo "<html>";
echo "<script type=\"text/javascript\" src=\"http://code.jquery.com/jquery-latest.js\"></script>";
echo "<head>";
echo "</head>";
echo "
<style>
@import url(http://fonts.googleapis.com/css?family=Lato);
*{
    -webkit-appearance: none;
    -moz-appearance: none;
    font-family: 'Lato', sans-serif !important;
}
</style>
";
echo "</body>";
    echo "<center>";
    echo "<br><h3>Welcome back " . $real_username . "</h3>";
    echo "<br/><br/>";
	echo "<p>iPacMG is now free to use! No purchase is necessary spread the word! (you can register your own account[s] at the login page!)</p>";
    echo "</center>";
echo "</body>";

echo "<html>";

?>