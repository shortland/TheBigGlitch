<?php
require("cookie_login.php");
?>
<!DOCTYPE HTML>
<html>
    <head>
<meta name="viewport" content="user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<script src="http://code.jquery.com/jquery-2.1.1.min.js"></script>
<meta content="minimum-scale=1.0, width=device-width, maximum-scale=0.6667, user-scalable=no" name="viewport" />
<meta name="viewport" content="width=device-width, height=device-height, initial-scale=.9, maximum-scale=1.0, target-densityDpi=device-dpi" />
	<title>iPac-MG</title>							
</head>
<body>
<?php
$con=mysqli_connect("localhost","shortlando","password!","shortlando");
// Check connection
if (mysqli_connect_errno())
  {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
  }

$result = mysqli_query($con,"SELECT bg, form FROM style WHERE user='$real_username'");

while($row = mysqli_fetch_array($result))
  {
  echo "

<style>
body {
background-color: ". $row['bg'] .";
background: ". $row['bg'] .";
}
form {
margin:10px;
padding:10px;
border-radius: 5px;
border: 1px solid black;
background-color: ". $row['form'] .";
background: ". $row['form'] .";
}

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
</style>";
}
mysqli_close($con);
?>
<center>
<form name="maker">
<p>Game:</p>

    <SELECT name='game' id='dpg'>
	<OPTION value='wwar'><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;WorldWar </p></OPTION>
	<OPTION value='im'><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;iMobsters </p></OPTION>
    </SELECT>
<br>
<br>
<p>Name:</p>

    <input type="text" name="name" id="text" size="30"/>  
<br>
<br>
<button id='submit' type='button' onClick='make_acc()'>Make Accounts</button>
  <br> <span id='result' style='color:red;'>(Makes 2 accounts)</span>
</form>

<form action="retrieve.php">
Retrieve Older Accounts
<br><BR>
<input id='submit' type="submit" name="submit" value="View"/> 
</form>



<script>
function make_acc() { // 6/$game.pl?username=$username&name=$name"
$.ajax({
                   url  : '6/' + document.maker.game.value + '.pl',
                   type : 'POST',
                   data : 'name=' + document.maker.text.value,
                   cache: false
                   })
                   
                   document.maker.text.value = "";
                   document.getElementById("result").innerHTML = "<BR><BR>Creation has begun, it may take awhile to complete. You may leave this section while creation occurs.<BR><BR>";
}


</script>




	</body>
</html>