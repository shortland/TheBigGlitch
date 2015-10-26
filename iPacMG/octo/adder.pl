#!/usr/bin/perl

use Digest::MD5;
use CGI;
use File::Temp qw(tempfile);
use HTTP::Cookies;
use LWP::UserAgent;
use MIME::Base64;

$cgi = CGI->new;

print $cgi->header("text/html");
$id = $cgi->param('id');

sub input_cleaner {
($replace) = @_;
$replace =~ s/'//g; $replace =~ s/"//g; $replace =~ s/\%//g; $replace =~ s/\*//g; $replace =~ s/\+//g; $replace =~ s/\.//g; $replace =~ s/\,//g; $replace =~ s/\(//g; $replace =~ s/\)//g; $replace =~ s/\~//g; $replace =~ s/\///g; $replace =~ s/\\//g;
return "$replace"; 
}
$id = input_cleaner($id);

require "../cookie_login.pl";

use DBI;
use DBI();
my $dbh = DBI->connect("DBI:mysql:database=shortlando;host=localhost",
			 "shortlando", "password!",
			 {'RaiseError' => 1});
my $sth = $dbh->prepare(<<End_SQL) or die "Couldn't prepare statement: $DBI::errstr; stopped";
select bg, form FROM style WHERE user = ?
End_SQL

$sth->execute($real_username) or die "Couldn't execute statement: $DBI::errstr; stopped";

while ( my ($bg, $form) = $sth->fetchrow_array() ){
print qq{
<style>
    \@import url(http://fonts.googleapis.com/css?family=Lato);
    *{
        -webkit-appearance: none;
        -moz-appearance: none;
        font-family: 'Lato', sans-serif !important;
    }
body {
background-color: \#$bg;
}
form {
margin: 5px;
padding: 10px;
background: \#$form;
border-radius:5px;
border: 1px solid black;
}
</style>};
  
}


    my $sth2 = $dbh->prepare("SELECT udid, game, device, pf FROM accs WHERE username = ? AND ID = ?");
    $sth2->execute($real_username, $id) or die "Couldn't execute statement: $DBI::errstr; stopped";
    while ( my ($udid_, $game_, $device_, $pf_) = $sth2->fetchrow_array() ) {
        $udid = $udid_;
        $game = $game_;
        $device = $device_;
        $pf = $pf_;
        $valid = "true";
    }
    
    if($valid !~ "true"){
        print "NOT TRUE";
        #die "ERR\n";
    }

	
 $dbh->disconnect();
 
if ($game =~ /^(wwar|im)$/) {

#############################
#############################
#############################
if ($game =~ /^(wwar)$/) {
if ($device =~ /^(ios)$/) {
###
$salt = "SnowLeopard154w";
$end ="index.php?premium=true&model=iPhone&sv=5.1.1&udid=$udid&pf";
###
}
if ($device =~ /^(droid)$/) {
###
$salt = "pEarlhAbor156w";
$end ="apoints.php?version=a1.56&model=Droid&sv=9A405&udid=$udid&pf";
###
}
}
#############################
#############################
#############################
if ($game =~ /^(im)$/) {
if ($device =~ /^(ios)$/) {
###
$salt = "UltraDoux174i";
$end ="index.php?premium=true&model=iPhone&sv=5.1.1&udid=$udid&pf";
###
}
if ($device =~ /^(droid)$/) {
###
$salt = "pr3m1umWat3r154i:12";
$end ="apoints.php?fpts=12&model=Droid&sv=2.2&version=a1.54&udid=$udid&pf";
###
}
}#############################
#############################
#############################
if ($game =~ /^(vl)$/) {
if ($device =~ /^(ios)$/) {
###
$salt = "f33ltl0sh4wn181v";
$end ="index.php?premium=true&model=iPhone&sv=5.1.1&udid=$udid&pf";
###
}
if ($device =~ /^(droid)$/) {
###
$salt = "S3wuEWSzsy154v:12";
$end ="apoints.php?fpts=12&model=Droid&sv=9A405&version=a1.54&udid=$udid&pf";
###
}
}
#############################
#############################
#############################
if ($game =~ /^(zl)$/) {
if ($device =~ /^(ios)$/) {
###
$salt = "RegisterToday143z";
$end ="index.php?premium=true&model=iPhone&sv=5.1.1&udid=$udid&pf";
###
}
if ($device =~ /^(droid)$/) {
###
$salt = "JiangShi156z";
$end ="apoints.php?version=a1.56&model=Droid&sv=9A405&udid=$udid&pf";
###
}
}
#############################
#############################
#############################
if ($game =~ /^(rl)$/) {
if ($device =~ /^(ios)$/) {
###
$salt = "thET1meforChillinGh4zp4zzd181r";
$end ="index.php?premium=true&model=iPhone&sv=5.1.1&udid=$udid&pf";
###
}
if ($device =~ /^(droid)$/) {
###
$salt = "comput3rSk1ll";
$end ="apoints.php?version=a1.56&model=Droid&sv=9A405&udid=$udid&pf";
###
}
}
#############################
#############################
#############################
if ($game =~ /^(kl)$/) {
if ($device =~ /^(ios)$/) {
###
$salt = "d4sV4sksksks181k";
$end ="index.php?premium=true&model=iPhone&sv=5.1.1&udid=$udid&pf";
###
}
if ($device =~ /^(droid)$/) {
###
$salt = "midDen9eard156k";
$end ="apoints.php?version=a1.56&model=Droid&sv=9A405&udid=$udid&pf";
###
}
}
#############################
#############################
#############################
if ($game =~ /^(nl)$/) {
if ($device =~ /^(ios)$/) {
###
$salt = "LibraryRoot103n";
$end ="index.php?premium=true&model=iPhone&sv=5.1.1&udid=$udid&pf";
###
}
if ($device =~ /^(droid)$/) {
###
$salt = "yAmat0t4keru156n";
$end ="apoints.php?version=a1.56&model=Droid&sv=9A405&udid=$udid&pf";
###
}
}



$CURL = "curl -s -b cookiez/cookie_$udid -c cookiez/cookie_$udid -L";
`$CURL 'http://$game.storm8.com/$end=$pf'`;

$baseurl = "http://$game.storm8.com";
$urly = "/home.php";
$outy = `$CURL "${baseurl}${urly}"`;
($code) = ($outy =~ /codeCode[^>]*>([^<]+)/);

$html_template = qq{<!DOCTYPE html>
    	<html>
    <head>   
	<title>iPac-MG</title>
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<script src="//code.jquery.com/jquery-1.10.2.js"></script>
	<meta name="viewport" content="width=device-width, initial-scale=.9, user-scalable=no"/>
	<body onload="add()">
    </head>
    <body>
	<center>
	
	<form>

	<b> Auto adding has begun.<br></br> Please login to your account and begin accepting the accounts that allie you. <br> </br> Note: You can only have 100 Maximum pending invites at a given moment!</b>

	</form>
	
<script>
function add()
{
document.getElementById('add').innerHTML = '<iframe src="$game/add.pl?code=$code" width="0px" height="0px" frameBorder="0"></iframe>';
}
</script>

	<div id='add'></div>
	
	</center>
    </body>
    	</html>
};


print $html_template;
}
if ($game =~ /^(zl|vl|rl|pl|kl|rbl|ro)$/) {
print "<center><form><br></br><b>Sorry, but this feature is not available with this game yet.</b><br></br><br></form></center>";
}