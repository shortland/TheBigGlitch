<?php
    
    /*
if($_SERVER['REMOTE_ADDR'] !== '67.80.166.248')//$_SERVER['REMOTE_ADDR'] !== '184.187.132.78' || 
{
    echo "<br/><br/><br/><br/><center>Server Maintenance, Sorry for the inconvenience.</center>";
    die();
}*/
    
$uc_safe = addslashes($_COOKIE['u_cookie']);
$pc_safe = addslashes($_COOKIE['p_cookie']);
include 'cookie_login.php';
if (!isset($uc_safe) && !isset($pc_safe))
{
	echo "Not logged in.";
	die();
}

function generateRandomString($length = 20) 
{
	$characters = 'abcdefghijklmnopqrstuvwxyz0123456789';
	$randomString = '';
	for ($i = 0; $i < $length; $i++) 
	{
		$randomString .= $characters[rand(0, strlen($characters) - 1)];
	}
	return $randomString;
}


$con=mysqli_connect("localhost","shortlando","password!","shortlando");

if (mysqli_connect_errno())
{
	echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

$result = mysqli_query($con,"SELECT bg, form FROM style WHERE user='$real_username'");

while($row = mysqli_fetch_array($result))
{
echo "
<script type='text/javascript'>
	localStorage.setItem('u_cookie', '" . $uc_safe . "');
	localStorage.setItem('p_cookie', '" . $pc_safe . "');
</script>
<style>
@import url(http://fonts.googleapis.com/css?family=Lato);
*
{
	-webkit-appearance: none;
	-moz-appearance: none;
	font-family: 'Lato', sans-serif !important;
}
body 
{
	background-color: ". $row['bg'] .";
	background: ". $row['bg'] .";
}
#fruits, form, tr
{
	background-color: ". $row['form'] .";
	background: ". $row['form'] .";
}
</style>";
}
mysqli_close($con);
?>
<!DOCTYPE HTML>
<html>
	<head><meta http-equiv="Content-Type" content="text/html; charset=windows-31j">
		<script src="http://code.jquery.com/jquery-2.1.1.min.js"></script>
		<script src="http://code.jquery.com/jquery-2.1.1.min.map"></script>
		<meta name="viewport" content="user-scalable=no" />
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<meta content="minimum-scale=1.0, width=device-width, maximum-scale=0.6667, user-scalable=no" name="viewport" />
		<meta name="viewport" content="width=device-width, height=device-height, initial-scale=.9, maximum-scale=1.0, target-densityDpi=device-dpi" />
		<title>iPac-MG</title>
		<!-- for android -->
		<div style="display:none;">
			<iframe src="update.php" frameborder="0px" width="0px" height="0px"></iframe>
		</div>
		<script type="text/javascript">
		$(window).ready(function()
		{
			$('#fruits').click(function()
			{
				$('#saver').fadeToggle();
			});
			var isit = localStorage.getItem('adidshowthenewthing')
			if(!isit)
			{
				$('#didntshow').fadeIn();
				localStorage.setItem('adidshowthenewthing', 'yes');
			}
			else
			{
				
			}
		});
		
		</script>
		<style>
		#fruits
		{
			width: 55px;
			height: 40px;
			border: 1px solid black;
			font-size: 100%;
			font-weight: bold;
		}
		form
		{
			width: 90%;
			margin: 20px;
			border-radius: 0px;
			border: 1px solid black;
			padding-bottom: 20px;
		}
		input[type='text']
		{
			border-radius: 0px;
			height: 25px;
			width: 90%;
			font-weight: bold;
			border: 1px solid black;
		}
		select
		{
			width: 90%;
			height: 25px;
			padding: 2px;
			font-size: 100%;
			border: 1px solid black;
			border-radius: 0px;
			color: #000000;
			background-color: white;  
		}
		input[type='submit']
		{
			height: 40px;
			width: 60px;
			font-weight: bold;
			border: 1px solid black;
			background-color: #FFFFFF;
			border-radius: 0px;
		}
		button
		{
			font-weight: bold;
			border: 1px solid black;
			background-color: #FFFFFF;
			border-radius: 0px;
			padding: 0px;
			text-align: center;
		}
		</style>
	</head>
	<body>
	<center>

		<br/>
		<div style='display: none; color: red;' id='didntshow'><br/><br/>Press the play button to open experimental gamer. Can auto-spend skill points!</div>
		<button type='button' id='fruits'>+</button>
		<br/><br/>

		<form action="save.php"  method="post" id='saver' style='display: none;'>
			<h3> Add Account </h3>
			<input type="hidden" name="username" value="<?php echo htmlentities($_SESSION['user']['username'], ENT_QUOTES, 'UTF-8'); ?>" />
			<b>Name:</b>
			<br/>
			<input type="text" name="name" width="90%" height="30px" value="" />
			<br/><br/>
			<b>UDID:</b>
			<br/>
			<input type="text" name="udid" width="90%" height="30px" value="<?php echo generateRandomString(); ?>" /><br />
			<br/>

			<b>Game:</b><br/>
			<select name='game'>
				<option value='wwar'>&nbsp;&nbsp;&nbsp;&nbsp;WorldWar </option>
				<option value='im'>&nbsp;&nbsp;&nbsp;&nbsp; iMobsters </option>
				<option value='kl'>&nbsp;&nbsp;&nbsp;&nbsp; Kingdoms </option> 
				<option value='rl'>&nbsp;&nbsp;&nbsp;&nbsp; Racing </option> 
				<option value='zl'>&nbsp;&nbsp;&nbsp;&nbsp; Zombies</option>
				<option value='vl'>&nbsp;&nbsp;&nbsp;&nbsp; Vampires </option>
			</select>
			<br/><br/>

			<b>UDID Type:</b><br/>
			<select name='device'>
				<option value='droid'>&nbsp;&nbsp;&nbsp;&nbsp; Android </option>
				<option value='ios'>&nbsp;&nbsp;&nbsp;&nbsp; iOS </option>
			</select>

			<br/><br/>
			<input type="submit" value="Add"/> 
		</form>




		<?php
		$con=mysqli_connect("localhost","shortland","password!","shortlando");
		// Check connection
		if (mysqli_connect_errno())
		{
			echo "Failed to connect to MySQL: " . mysqli_connect_error();
		}

		$result = mysqli_query($con,"SELECT * FROM accs WHERE username ='". $real_username. "'LIMIT 100");

		echo "<table width='100%;'>";

		while($row = mysqli_fetch_array($result))
		{
			echo "
			<tr>
				<td width='55px'>
					<img id='img' style='border-radius:10px;width:45px !important;height:45px;margin:5px;' src='images/" . $row['game'] . ".png' />
				</td>

				<td>
					Name: <div><input type='text' value='" . $row['accname'] . "' style='border:0px;' disabled></div>
						<div style='height:1px;width:90%;background-color:#000000;'></div>
					UDID: <div><input type='text' value='" . $row['udid'] . "' style='border:0px;' disabled></div>
				</td>

				<td style='width:50px !important;'>
					<center>
						<div><button type='button' style='width:40px !important;height:40px !important;' onClick='show_menu(this.id)' id='" . $row['ID'] . "'>+</button></div>
						<div style='height:4px;'></div>
						<div><button type='button' style='width:40px !important;height:40px !important;' onClick='launch_gamer(this.id)' id='" . $row['ID'] . "'>Play</button></div>
					</center>
				</td>
			</tr>
			<tr>
				<td>
					<!-- b1 -->
				</td>

				<td>
					<!-- b2 -->
					<center>
						<div id='hidden_content_" . $row['ID'] . "' style='display:none;'>
							<br/><br/>
								<button style='width: 80%;height:40px;' id='" . $row['ID'] . "' onClick='close_menu(this.id)'>Close Menu</button>
							<br/><br/>
								<button style='width: 80%;height:40px;' onClick='goto_tool(" . $row['ID'] . ")'>Glitcher</button>
							<br/><br/>
								<button style='width: 80%;height:40px;' onClick='goto_loot(" . $row['ID'] . ")'>LootGlitcher</button>
							<br/><br/>
								<button style='width: 80%;height:40px;' onClick='goto_autosell(" . $row['ID'] . ")'>Auto-Seller</button>
							<br/><br/>
								<button style='width: 80%;height:40px;' onClick='goto_autoadd(" . $row['ID'] . ")'>Auto-Add</button>
							<br/><br/>
								<button style='width: 80%;height:40px;' onClick='goto_vaulter(" . $row['ID'] . ")'>Vaulter</button>
							<br/><br/>
								<button style='width: 80%;height:40px;' onClick='deleteacc(" . $row['ID'] . ")'>Delete</button>
							<br/><br/>
						</div>
					</center>
				</td>

				<td>
					<!-- b3 -->
				</td>
			</tr>
			<tr>
				<td>
					<!-- c1 -->
				</td>

				<td>
					<!-- c2 -->
				</td>

				<td>
					<!-- c3 -->
				</td>
			</tr>
			";
		}
		  
		echo "</table>";


		mysqli_close($con);
		?>

		<div style='height: 300px;'></div>
	</center>

	<script>
	function show_menu(this_id)
	{
		$("#hidden_content_" + this_id).fadeToggle();
	}

	function close_menu(this_id)
	{
		$("#hidden_content_" + this_id).fadeToggle();
	}

	function goto_tool(acc_id)
	{
		window.location.href = 'octo/catcher.pl?id=' + acc_id;
	}

	function goto_loot(acc_id)
	{
		window.location.href = 'octo/catcher.pl?url=loot&id=' + acc_id;
	}

	function goto_autosell(acc_id)
	{
		window.location.href = 'octo/sell.pl?id=' + acc_id;
	}

	function goto_autoadd(acc_id)
	{
		window.location.href = 'octo/adder.pl?id=' + acc_id;
	}

	function goto_vaulter(acc_id)
	{
		window.location.href = 'octo/vault.pl?id=' + acc_id;
	}

	function launch_gamer(acc_id)
	{
		var ucookie = localStorage.getItem('u_cookie');
		var pcookie = localStorage.getItem('p_cookie')
		top.location.href = 'octo/catcher.pl?url=gamer&id=' + acc_id + '&u_cookie=' + ucookie + '&p_cookie=' + pcookie;
	}

	function deleteacc(this_id) {
	$.ajax({
	                   url  : 'delete.php',
	                   type : 'POST',
	                   data : 'id=' + this_id,
	                   cache: false
	                   }).done(function(data, statusText, xhr){
	                           var status = xhr.status;
	                           if (status == '200'){
	                           window.location.href = "new.php";
	                           }
	                           });
	}

	</script>
	</body>
</html>






