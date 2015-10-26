<?php 
    require("cookie_login.php"); 
?><?php

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
background: \#". $row['bg'] .";
}
form {
border: 1px solid black;
margin: 10px;
padding: 10px 10px;
border-radius: 5px;
background: \#". $row['form'] .";
}

</style>";
  }
mysqli_close($con);
?>

<!DOCTYPE HTML>
<html>
    <head>
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">

<meta name="viewport" content="width=device-width, initial-scale=.9, user-scalable=no"/>

	<title>iPac-MG</title>		
    
	
					
</head>

<body>
	    <script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
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


<?php
$con=mysqli_connect("localhost","shortland","password!","shortlando");
// Check connection
if (mysqli_connect_errno())
  {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
  }

$result = mysqli_query($con,"SELECT * FROM storage WHERE username ='". $real_username . "'LIMIT 0, 3000");

echo "<form action='deleteall.php'>";
  echo "<input type='submit' id='submit' value='Clear All'/>";
echo "</form><BR>";
echo "Data presented in 'S8Dev' format.<br>[ name ### game ### device ### udid ]<br>";
echo "<textarea id='fancybox'>";
while($row = mysqli_fetch_array($result))
  {

  echo $row['name'];
  echo " ### ";
  echo $row['game'];
  echo " ### ";
  echo "android";
  echo " ### ";
  echo $row['udid'];
  echo "&#13;&#10;";

  }

echo "</textarea>";
mysqli_close($con);
?>


 
 <br />  <br /><br />  <br />  <br />  <br />  <br />  <br />  <br />  <br /><br />  <br />  <br />  <br />  <br />  <br />  <br />  <br /><br />  <br />  <br />  <br />  <br />  <br />  <br />  <br /><br />  <br />  <br />  <br />  <br />  <br />  <br />  <br /><br />  <br />  <br />  <br />  <br />  <br />  <br />  <br /><br />  <br />  <br />  <br />  <br />  <br />  <br />  <br /><br />  <br />  <br />  <br />  <br />  <br />  <br />  <br /><br />  <br />  <br />  <br />  <br />  <br />  <br />  <br /><br />  <br />  <br />  <br />  <br />  <br />  <br />  <br /><br />  <br />  <br />  <br />  <br />  <br />  <br />  <br /><br />  <br />  <br />  <br />  <br />  <br />  <br />  <br /><br />  <br />  <br />  <br />  <br />  <br />  <br />  <br /><br />  <br />  <br />  <br />  <br />  <br />  <br />  <br />  <br />  <br />  <br />  <br />  <br />  <br />  <br /><br />  <br />  <br />  <br />  <br />  <br />  <br />  <br /><br />  <br />  <br />  <br />  <br />  <br />  <br />  <br /><br />  <br />  <br />  <br />  <br />  <br />  <br />  <br /><br />  <br />  <br />  <br />  <br />  <br />  <br />  <br /><br />  <br />  <br />  <br />  <br />  <br />  <br />  <br /><br />  <br />  <br />  <br />  <br />  <br />  <br />  <br /><br />  <br />  <br />  <br />  <br />  <br />  <br />  <br /><br />  <br />  <br />  <br />  <br />  <br />  <br />  <br /><br />  <br />  <br />  <br />  <br />  <br />  <br />  <br /><br />  <br />  <br />  <br />  <br />  <br />  <br />  <br /><br />  <br />  <br />  <br />
	</body>
</html>