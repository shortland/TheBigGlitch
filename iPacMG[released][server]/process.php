<?php 

/*

user always goes here first.  

// localstorage, if local storage version = 11, then go to new_login.php
else, updater.php (user changes password & version is updated — local storage sets version = 11.)


*/

?>

<meta name='viewport' content='height = device-height, width = device-width, initial-scale = 1, minimum-scale = 1, maximum-scale = 1, user-scalable = no, target-densityDpi=device-dpi' />


<br>
<br>
<center>
Loading...
</center>


<script>
var version = localStorage.getItem('version');
/*
if(version == "11"){
*/
window.location.href = "n_login.php";
/*
} else {
window.location.href = "o_updater.php";
}
*/
</script>