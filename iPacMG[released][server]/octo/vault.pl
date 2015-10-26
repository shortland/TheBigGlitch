#!/usr/bin/perl

use Digest::MD5;
#use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
use CGI;
use File::Temp qw(tempfile);
use HTTP::Cookies;
use LWP::UserAgent;
use MIME::Base64;

$cgi = CGI->new;

print $cgi->header("text/html");
$id = $cgi->param('id');
$amount = $cgi->param('amount');

sub input_cleaner {
($replace) = @_;
$replace =~ s/'//g; $replace =~ s/"//g; $replace =~ s/\%//g; $replace =~ s/\*//g; $replace =~ s/\+//g; $replace =~ s/\.//g; $replace =~ s/\,//g; $replace =~ s/\(//g; $replace =~ s/\)//g; $replace =~ s/\~//g; $replace =~ s/\///g; $replace =~ s/\\//g;
#'
return "$replace"; 
}
$id = input_cleaner($id);
$amount = input_cleaner($amount);


if($amount < "9"){

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
};
  
}
print "
    \@import url(http://fonts.googleapis.com/css?family=Lato);
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
	line-height: 1;
	border: 1px solid black;
	border-radius: 5px;
	color: #000000;
        background-color:white;  
}

#submit {
    color: #000000;
    width: 100px;
    height: 22px;
    border-radius: 5px;
    background-color: #ffffff;
    border: 1px solid #000000;
}
#submit:hover, #submit:active{
    background-color: #000000;
    border: 1px solid #ffffff;
    color:#ffffff;
}
</style>";
print qq{<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>};
print qq{<form name='deposit'>
<b>Amount to Deposit: </b></br>
	<select id='dpg' name=\"amount\">
	<option value=\"10\">10B</option>
	<option value=\"20\">20B</option>
	<option value=\"30\">30B</option>
	<option value=\"40\">40B</option>
	<option value=\"50\">50B</option>
	<option value=\"60\">60B</option>
	<option value=\"70\">70B</option>
	<option value=\"80\">80B</option>
	<option value=\"90\">90B</option>
	<option value=\"100\">100B</option>
	<option value=\"200\">200B</option>
	<option value=\"300\">300B</option>
	<option value=\"400\">400B</option>
	<option value=\"500\">500B</option>
	<option value=\"600\">600B</option>
	<option value=\"700\">700B</option>
	<option value=\"800\">800B</option>
	<option value=\"900\">900B</option>
	<option value=\"1000\">1T</option>
	</select>
	
	<br></br>
	
	<button id='submit' type='button' onClick='bankit()'>Deposit!</button>
	
	<div id='result' style='color:red;'></div>
</form>
<BR><BR>


            <script>
            function bankit() {
		\$.ajax({
                   url  : 'vault.pl',
                   type : 'POST',
                   data : 'amount=' + document.deposit.dpg.value + '&id=$id',
                   cache: false
                   })
                   
                   document.getElementById("result").innerHTML = "<BR><BR>Depositing has begun, it may take awhile to complete. You may leave this section while vaulting occurs.<BR><BR>";
            }
            </script>


	};






$dbh->disconnect();
 
 }
if($amount > "9"){
require "../cookie_login.pl";

use DBI;
use DBI();
my $dbh = DBI->connect("DBI:mysql:database=shortlando;host=localhost",
			 "shortlando", "password!",
			 {'RaiseError' => 1});

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
    }
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

$out;
$CURL = "curl -s -b cookiez/cookie_$udid -c cookiez/cookie_$udid -L";

$baseurl = "http://$game.storm8.com";
$url = "\/bank.php";

`$CURL "http://$game.storm8.com/$end=$pf"`;
    $now = `$CURL "http://$game.storm8.com/home.php"`;

for $i (1 .. $amount){
    $out = `$CURL --data "depositAmount=1000000000&action=Deposit&sk=1" "${baseurl}${url}"`;
}
}