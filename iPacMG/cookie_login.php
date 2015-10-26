<?php
// This page checks to see if a user is logged in.
// If they are not logged in, they are presented with a login form.
// simply: include 'cookie_login.php';
// Nothing more is necessary.
// This page is meant to run SQL Queries as-well. (since it's cookie protected)
// For example, two variables are already set: "$real_username" and "$real_email"
// So any page that has this page "included" can use $real_username and get the user's username... Ect...
// Go ahead and set more variables by fetching more stuff from DB


echo "

<meta name='viewport' content='height = device-height, width = device-width, initial-scale = 1, minimum-scale = 1, maximum-scale = 1, user-scalable = no, target-densityDpi=device-dpi' />

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
</style>";


if(!isset($_COOKIE['u_cookie']) && !isset($_COOKIE['p_cookie'])){
echo "
<script>
  if (top.location.href != self.location.href) {
     top.location.href = self.location.href;
    }
</script>
";

echo "<style>

#topbb {
position:fixed;
top:0px;
left:0px;
height:20px;
width:100%;
background-color:lightblue;
border-bottom:1px solid black;
z-index:999999;
}

</style>";

echo "<span id='topbb'></span>";
echo "<BR><BR><BR>";
echo "<center>";
echo "<form action='n_login.php' method='POST'>\n";
echo "<input id='text' type='hidden' name='username'/><br><br>\n";
echo "<input id='text' type='hidden' name='password'/><br><br>\n";
echo "<input type='hidden' name='method' value='login'/>\n";
echo "<input id='submit' type='submit' value='Next'/><br>\n";
echo "</form>\n";
echo "</center>";
die();
}
$uc_safe = addslashes($_COOKIE['u_cookie']);
$pc_safe = addslashes($_COOKIE['p_cookie']);
$connect = mysqli_connect("localhost","shortland","password!","shortlando");
if (mysqli_connect_errno()) {
  echo "CANT CONNECT:" . mysqli_connect_error();
}
$check = mysqli_query($connect, "SELECT `u_cookie`, `p_cookie`, `username`, `email` FROM `users` WHERE `u_cookie` = '$uc_safe' AND `p_cookie` = '$pc_safe'") or die(mysqli_error($connect));
// Get the salt by username, use salt to hash the password. then check if new hashed password is == to the stored password.
while($row = mysqli_fetch_array($check)) {
  // use these variables in files that have THIS file included. no need to do mysql queries to get username ect.
  $real_username = base64_decode($row['username']);
  $real_email = $row['email'];
  $valid = "ok";
}
if (!isset($valid)){
// Invalid, old, currupt cookies
// Force user to login again.


echo "
<script>
  if (top.location.href != self.location.href) {
     top.location.href = self.location.href;
    }
</script>
";

echo "<style>

#topbb {
position:fixed;
top:0px;
left:0px;
height:20px;
width:100%;
background-color:lightblue;
border-bottom:1px solid black;
z-index:999999;
}

</style>";

echo "<span id='topbb'></span>";
echo "<BR><BR><BR>";
echo "<center>";
echo "<form action='n_login.php' method='POST'>\n";
echo "<input id='hidden' type='hidden' name='username'/><br><br>\n";
echo "<input id='hidden' type='hidden' name='password'/><br><br>\n";
echo "<input type='hidden' name='method' value='login'/>\n";
echo "<input id='submit' type='submit' value='Next'/><br>\n";
echo "</form>\n";
echo "</center>";
die();
}
?>