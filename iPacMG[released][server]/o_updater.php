<?php 

    // First we execute our common code to connection to the database and start the session 
    require("o_common.php"); 
     
    // At the top of the page we check to see whether the user is logged in or not 
    if(empty($_SESSION['user'])) 
    { 
	// If they are not, we redirect them to the login page. 
	header("Location: o_login.php"); 
	 
	// Remember that this die statement is absolutely critical.  Without it, 
	// people can view your members-only content without logging in. 
	die("Redirecting to o_login.php"); 
    } 
   
if(!empty($_POST)) { 
if($_POST['password'] != $_POST['password2']){

echo "
<style>
#submit {
width: 80px;
height:30px;
border: 1px solid black;
color: black;
background-color: white;
border-radius: 5px;
}
</style>
";
echo "<form>";
echo "<input id='submit' type='submit' value='Go Back'>";
echo "</form>";
die("Passwords do not match");

} else {
$email = htmlentities($_SESSION['user']['email'], ENT_QUOTES, 'UTF-8');
$username = htmlentities($_SESSION['user']['username'], ENT_QUOTES, 'UTF-8');
$spc_username = base64_encode(addslashes($username));
$spc_password = base64_encode(addslashes($_POST['password']));

$connect = mysqli_connect("localhost","shortland","password!","shortlando");
if (mysqli_connect_errno()) {
  echo "CANT CONNECT:" . mysqli_connect_error();
}
// auto has salt username fix
$user = mysqli_query($connect, "SELECT salt FROM users WHERE username= '$username'") or die(mysqli_error($connect)); 
while($row3 = mysqli_fetch_array($user)){
$old_salt = $row3['salt'];
}
$missions_user = mysqli_query($connect, "UPDATE auto SET username = '$username' WHERE username = '$old_salt'") or die(mysqli_error($connect)); 

$leg = 10;
$salt = strtr(base64_encode(mcrypt_create_iv(16, MCRYPT_DEV_URANDOM)), '+', '.');
$salt = sprintf("$2a$%02d$", $leg) . $salt;
$enc_password = crypt($spc_password, $salt);

$register_user = mysqli_query($connect, "UPDATE users SET username = '$spc_username', real_user = '$username', password = '$enc_password', salt = '$salt', version = '11' WHERE username = '$username'") or die(mysqli_error($connect)); 

header("Location: n_login.php"); 

}
} 

?>

<style>
* {
-webkit-appearance: none;
}
#resp {
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

</style>
<meta name='viewport' content='height = device-height, width = device-width, initial-scale = 1, minimum-scale = 1, maximum-scale = 1, user-scalable = no, target-densityDpi=device-dpi' />



<form method="post"> 

<input type="hidden" name="email" value="<?php echo htmlentities($_SESSION['user']['email'], ENT_QUOTES, 'UTF-8'); ?>" /> 

     <br />
    
    <b>Username: <?php echo htmlentities($_SESSION['user']['username'], ENT_QUOTES, 'UTF-8'); ?></b>
    <p>The new application is <b>username</b> case-sensitive, meaning capitals in your username will affect if you login or not. Above is your username, take in mind which letters are capitals (if any).</p>
    <b> Change Password:</b><br><br>
New Password:    <input id='text' type="text" name="password" width="80%" height="30px" value="" /><br /><br>
Type Again:    <input id='text' type="text" name="password2" width="80%" height="30px" value="" />
    <br /><br>
<input id='submit' type="submit" name="submit"  value="Update" />  
    <br>

</form>