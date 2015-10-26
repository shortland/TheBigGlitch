<?php
$uc_safe = addslashes($_COOKIE['u_cookie']);
$pc_safe = addslashes($_COOKIE['p_cookie']);
include 'cookie_login.php';
if (!isset($uc_safe) && !isset($pc_safe)){
echo "Not logged in.";
die();
}
?>
<!DOCTYPE HTML>
<html>
    <head>
<meta name="viewport" content="height = device-height, width = device-width, initial-scale = 1, minimum-scale = 1, maximum-scale = 1, user-scalable = no, target-densityDpi=device-dpi" />
    <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
    <script src="https://code.jquery.com/ui/1.11.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="hamburger.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="hamburger.css"/>
<title>iPac-MG</title>
<?php
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
@import url(http://fonts.googleapis.com/css?family=Lato);
*{	
    padding: 0; margin: 0; outline: 0;
    -webkit-appearance: none;
    -moz-appearance: none;
    font-family: 'Lato', sans-serif !important;
}
body {
padding: 0; margin: 0; outline: 0;
background-color: #". $row['bg'] .";
}
#viewer
{	
	/*height: 1000px;*/
	width: 100% !important;
	overflow-y: visible !important;
	padding-top: 60px;
        overflow-x: hidden;
        position: relative;
}
header {
background-color: #". $row['topbar'] .";
}
/*
#content {
	    /*background-color: #". $row['bg'] .";*/
	    background-color: lightblue;
}
*/

#botbar {
position:fixed;
right:0px;
bottom:0px;
z-index:140;
opacity:1.0;
background-color: #". $row['botbar'] .";
font-size:100%;
font-color:black;
color:black;
width:100%;
height:10%;
border-top: 1px solid black;
}
#topbb {
position:fixed;
top:0px;
left:0px;
height:20px;
width:100%;
background-color: #". $row['topbar'] .";
border-bottom:1px solid lightgrey;
z-index:999999;
}
form {
margin: 10px;
padding: 10px 10px;
background: #". $row['form'] .";
}
button {
height: 50px;
width: 100%;
border: 0px;
background-color: white;
font-size: 100%;
color: black;
text-align: center;
opacity: 1.0;
border-bottom: 1px solid black;
}
button:hover {
color: lightblue;
}
button:active {
color: lightblue;
background-color:black;
}
</style>";
$bg_color = $row['bg'];
  }
?>
</head>
<body onLoad="goto('new')">
	<!--- old container --->
<script type="text/javascript">
function goto(page)
{	
	window.scrollTo(0, 0);
	$("#viewer").html("<center>Loading</center>");
	
        jQuery('#container').unbind('touchmove');
        jQuery("#container").animate({"marginLeft": ["-1", 'easeOutExpo']}, {
            duration: 700,
            complete: function () {
                jQuery('#content').css('width', 'auto');
                jQuery('#contentLayer').css('display', 'none');
                jQuery('nav').css('opacity', 0);
                jQuery('#content').css('min-height', 'auto');

            }
        });
	
	$("#viewer").html("<iframe src='" + page + ".php' width='100%' height='100%' style='border-bottom:1px solid black;overflow-y: visible !important;background-color:#<?php echo $bg_color ?>' frameBorder='0'>Loading</iframe>");	
}
function reload() 
{
	location.href = location.href+'?p='+ Math.random();
}
</script>



    <nav>
        <ul>
            <li><span style='height:20px;'></span></li>
            <li><button type='button' onClick='goto("home")'>News</button></li>
            <li><button type='button' onClick='goto("new")'>Main</button></li>
            <li><button type='button' onClick='goto("level6")'>Level 6</button></li>
            <li><button type='button' onClick='goto("calc")'>Mission</button></li>
            <li><button type='button' onClick='goto("more")'>Settings</button></li>
            <li><button type='button' onClick='reload()'>Reload</button></li>
        </ul>
    </nav>
	<div id="contentLayer"></div>
	<span id='topbb'></span>
	
	<div id='container' style='height: 100%;overflow-y:visible !important;'>
		<header>
        <div id="hamburger">
            <div></div>
            <div></div>
            <div></div>
        </div>
		</header>
		<div id="viewer" width="100%" ></div> 
	</div> <!--- container --->
</body>
</html>