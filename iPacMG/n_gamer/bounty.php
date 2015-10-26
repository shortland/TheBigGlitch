<?php
$pre_post = file_get_contents("php://input");
$POST_DATA = base64_encode($pre_post);
header("Location: gamer.pl?p=bounty.php?" . $_SERVER['QUERY_STRING'] . "&POST_IT=" . $POST_DATA);
echo "DERPPPPY";
?>