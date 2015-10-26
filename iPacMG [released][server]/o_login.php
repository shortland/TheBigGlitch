<?php 


$model = $_GET['model'];
$platform = $_GET['platform'];
$version = $_GET['version'];
$cordova = $_GET['cordova'];
$uuid = $_GET['uuid'];
$uuidp = $_POST['uuid'];

    // First we execute our common code to connection to the database and start the session 
    require("o_common.php"); 
     
    // This variable will be used to re-display the user's username to them in the 
    // login form if they fail to enter the correct password.  It is initialized here 
    // to an empty value, which will be shown if the user has not submitted the form. 
    $submitted_username = ''; 
     
    // This if statement checks to determine whether the login form has been submitted 
    // If it has, then the login code is run, otherwise the form is displayed 
    if(!empty($_POST)) 
    { 
	// This query retreives the user's information from the database using 
	// their username. 
	$query = " 
	    SELECT 
		id, 
		username, 
		password, 
		salt, 
		email 
	    FROM users 
	    WHERE 
		username = :username 
	"; 
	 
	// The parameter values 
	$query_params = array( 
	    ':username' => $_POST['username'] 
	); 
	 
	try 
	{ 
	    // Execute the query against the database 
	    $stmt = $db->prepare($query); 
	    $result = $stmt->execute($query_params); 
	} 
	catch(PDOException $ex) 
	{ 
	    // Note: On a production website, you should not output $ex->getMessage(). 
	    // It may provide an attacker with helpful information about your code.  
	    die("Failed to run query: " . $ex->getMessage()); 
	} 
	 
	// This variable tells us whether the user has successfully logged in or not. 
	// We initialize it to false, assuming they have not. 
	// If we determine that they have entered the right details, then we switch it to true. 
	$login_ok = false; 
	 
	// Retrieve the user data from the database.  If $row is false, then the username 
	// they entered is not registered. 
	$row = $stmt->fetch(); 
	if($row) 
	{ 
	    // Using the password submitted by the user and the salt stored in the database, 
	    // we now check to see whether the passwords match by hashing the submitted password 
	    // and comparing it to the hashed version already stored in the database. 
	    $check_password = hash('sha256', $_POST['password'] . $row['salt']); 
	    for($round = 0; $round < 65536; $round++) 
	    { 
		$check_password = hash('sha256', $check_password . $row['salt']); 
	    } 
	     
	    if($check_password === $row['password']) 
	    { 
		// If they do, then we flip this to true 
		$login_ok = true; 
	    } 
	} 


	// If the user logged in successfully, then we send them to the private members-only page 
	// Otherwise, we display a login failed message and show the login form again 
	if($login_ok) 
	{ 
	    // Here I am preparing to store the $row array into the $_SESSION by 
	    // removing the salt and password values from it.  Although $_SESSION is 
	    // stored on the server-side, there is no reason to store sensitive values 
	    // in it unless you have to.  Thus, it is best practice to remove these 
	    // sensitive values first. 
	    unset($row['salt']); 
	    unset($row['password']); 
	     
	    // This stores the user's data into the session at the index 'user'. 
	    // We will check this index on the private members-only page to determine whether 
	    // or not the user is logged in.  We can also use it to retrieve 
	    // the user's details. 
	    $_SESSION['user'] = $row; 
	     
	    // Redirect the user to the private members-only page. 
            header("location: o_updater.php");
	    die("Redirecting to: o_updater.php");
	} 
	else 
	{ 
	    // Tell the user they failed 
	    print("<script>function show() { document.getElementById('resp').innerHTML= 'Login Failed <b>Have you already reset your password?</b> <form action=\'n_login.php\'> <input id=\'submit\' type=\'submit\' value=\'Yes\'></form></center>'; }</script>"); 
	     
	    // Show them their username again so all they have to do is enter a new 
	    // password.  The use of htmlentities prevents XSS attacks.  You should 
	    // always use htmlentities on user submitted values before displaying them 
	    // to any users (including the user that submitted them).  For more information: 
	    // http://en.wikipedia.org/wiki/XSS_attack 
	    $submitted_username = htmlentities($_POST['username'], ENT_QUOTES, 'UTF-8'); 
	} 
    } 
?>
<meta name='viewport' content='height = device-height, width = device-width, initial-scale = 1, minimum-scale = 1, maximum-scale = 1, user-scalable = no, target-densityDpi=device-dpi' />
<body onLoad='show()'>
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
<BR><BR>
<center>
<h3>Please Login:</h3>
<div id='resp'></div>
<form action='o_login.php' method='post'>
Username: <input id='text' type='text' name='username'/>
<br><br>
Password: <input id='text' type='password' name='password'/>
<br><br>
<input id='submit' type='submit' value='Login'/>
</form>
</center>




</body>