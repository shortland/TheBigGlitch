#!/usr/bin/perlml

use v5.10;
use Digest::MD5;
use CGI;
use File::Temp qw(tempfile);
use HTTP::Cookies;
use LWP::UserAgent;
use MIME::Base64;
use HTTP::Request;
use DBI;
use DBI();
use MIME::Base64;
use CGI::Cookie;

BEGIN{
    $q = new CGI;
        $udid = $q->param("udid");
	$game = $q->param("game");
	$device = $q->param("device");
	$p = $q->param("p");
	$POST_IT = $q->param("POST_IT");

if(!defined $p){
$cookie = new CGI::Cookie(-name=>'ACC_CK',-value=>$udid);
$cookie2 = new CGI::Cookie(-name=>'GAME',-value=>$game);
print $q->header(-cookie=>[$cookie, $cookie2], -type=>'text/html', -charset => 'UTF-8');
} else {
%cookieszz = CGI::Cookie->fetch;
$lecook = $cookieszz{'ACC_CK'}->value;
$legame = $cookieszz{'GAME'}->value;

$cookie = new CGI::Cookie(-name=>'ACC_CK',-value=>$lecook);
$cookie2 = new CGI::Cookie(-name=>'GAME',-value=>$legame);
print $q->header(-cookie=>[$cookie, $cookie2],-type=>'text/html', -charset => 'UTF-8');
}

    open(STDERR, ">&STDOUT");
}


if(!defined $udid){
%cookieszz = CGI::Cookie->fetch;
$udid = $cookieszz{'ACC_CK'}->value;
$game = $cookieszz{'GAME'}->value;
}

if ($game =~ /^(wwar)$/) {
if ($device =~ /^(ios)$/) {
$salt = "SnowLeopard154w";
$end ="index.php?premium=true&model=iPhone&sv=5.1.1&udid=$udid&pf";
}
if ($device =~ /^(droid)$/) {
$salt = "pEarlhAbor156w";
$end ="apoints.php?version=a1.56&model=Droid&sv=9A405&udid=$udid&pf";
}
}
if ($game =~ /^(im)$/) {
if ($device =~ /^(ios)$/) {
$salt = "UltraDoux174i";
$end ="index.php?premium=true&model=iPhone&sv=5.1.1&udid=$udid&pf";
}
if ($device =~ /^(droid)$/) {
$salt = "pr3m1umWat3r154i:12";
$end ="apoints.php?fpts=12&model=Droid&sv=2.2&version=a1.54&udid=$udid&pf";
}
}
if ($game =~ /^(vl)$/) {
if ($device =~ /^(ios)$/) {
$salt = "f33ltl0sh4wn181v";
$end ="index.php?premium=true&model=iPhone&sv=5.1.1&udid=$udid&pf";
}
if ($device =~ /^(droid)$/) {
$salt = "S3wuEWSzsy154v:12";
$end ="apoints.php?fpts=12&model=Droid&sv=9A405&version=a1.54&udid=$udid&pf";
}
}
if ($game =~ /^(zl)$/) {
if ($device =~ /^(ios)$/) {
$salt = "RegisterToday143z";
$end ="index.php?premium=true&model=iPhone&sv=5.1.1&udid=$udid&pf";
}
if ($device =~ /^(droid)$/) {
$salt = "JiangShi156z";
$end ="apoints.php?version=a1.56&model=Droid&sv=9A405&udid=$udid&pf";
}
}
if ($game =~ /^(rl)$/) {
if ($device =~ /^(ios)$/) {
$salt = "thET1meforChillinGh4zp4zzd181r";
$end ="index.php?premium=true&model=iPhone&sv=5.1.1&udid=$udid&pf";
}
if ($device =~ /^(droid)$/) {
$salt = "comput3rSk1ll";
$end ="apoints.php?version=a1.56&model=Droid&sv=9A405&udid=$udid&pf";
}
}
if ($game =~ /^(kl)$/) {
if ($device =~ /^(ios)$/) {
$salt = "d4sV4sksksks181k";
$end ="index.php?premium=true&model=iPhone&sv=5.1.1&udid=$udid&pf";
}
if ($device =~ /^(droid)$/) {
$salt = "midDen9eard156k";
$end ="apoints.php?version=a1.56&model=Droid&sv=9A405&udid=$udid&pf";
}
}
if ($game =~ /^(nl)$/) {
if ($device =~ /^(ios)$/) {
$salt = "LibraryRoot103n";
$end ="index.php?premium=true&model=iPhone&sv=5.1.1&udid=$udid&pf";
}
if ($device =~ /^(droid)$/) {
$salt = "yAmat0t4keru156n";
$end ="apoints.php?version=a1.56&model=Droid&sv=9A405&udid=$udid&pf";
}
}


my $dbh = DBI->connect("DBI:mysql:database=shortlando;host=localhost",
                         "shortland", "password!",
                         {'RaiseError' => 1});
my $sth = $dbh->prepare("SELECT `cookie` FROM `accs` WHERE `udid` = ? AND `game` = ?");
$sth->execute($udid, $game) or die "Couldn't execute statement: $DBI::errstr; stopped";

while ( my ($cookie) = $sth->fetchrow_array() ) {
     $raw_cookie_string = decode_base64($cookie);
}
$dbh->disconnect();

$raw_cookie_string =~ s/Set-Cookie3: //g;

$CURL = "curl -s --user-agent 'Mozilla/5.0 (Linux; Android 4.1.1; Nexus 7 Build/JRO03D) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.166 Safari/535.19' --referer 'http://$game.storm8.com/${p}.php?$ENV{QUERY_STRING};' --cookie '$raw_cookie_string' ";
$new_ENV = $ENV{QUERY_STRING};
$new_ENV =~ s/p\=//g;
#$new_ENV =~ s/&/?/g;

if(!defined $p){
$response = `$CURL 'http://$game.storm8.com/home.php'`;
} else {
if(!defined $POST_IT){
$response = `$CURL 'http://$game.storm8.com/$new_ENV'`;
}else{
$decoded_data = decode_base64($POST_IT);
$decoded_data =~ s/\'//g; #'
$new_ENV =~ s/&POST_IT=$POST_IT//g;
$response = `$CURL --data-urlencode '$decoded_data' 'http://$game.storm8.com/$new_ENV'`;
}
}

# REMOVE ADS
$response =~ s/opacity: 1.0;/display: none;/g;
$response =~ s/font-weight: normal; font-size: 10pt;/display: none;/g;

$response =~ s/#&setTab0Badge=&changeApplicationBadge=0&setTab4Badge=//g;
$response =~ s/window\.onload\ \=\ function\(\)\ \{\ window\.location\.href\ \=\ \"\"\;\}//g; #"

$response =~ s/\/hospital\.php\?/gamer\.pl\?p\=hospital\.php\?/g;
$response =~ s/\/hospital\.php/gamer\.pl\?p\=hospital\.php\?/g;
$response =~ s/\/profile\.php\?/gamer\.pl\?p\=profile\.php\?/g;
$response =~ s/\/profile\.php/gamer\.pl\?p\=profile\.php\?/g;
$response =~ s/\/missions\.php\?/gamer\.pl\?p\=missions\.php\?/g;
$response =~ s/\/missions\.php/gamer\.pl\?p\=missions\.php\?/g;
$response =~ s/\/fight\.php\?/gamer\.pl\?p\=fight\.php\?/g;
$response =~ s/\/fight\.php/gamer\.pl\?p\=fight\.php\?/g;
$response =~ s/\/hitlist\.php\?/gamer\.pl\?p\=hitlist\.php\?/g;
$response =~ s/\/hitlist\.php/gamer\.pl\?p\=hitlist\.php\?/g;
$response =~ s/\/bank\.php\?/gamer\.pl\?p\=bank\.php\?/g;
$response =~ s/\/bank\.php/gamer\.pl\?p\=bank\.php\?/g;
$response =~ s/\/group\.php\?/gamer\.pl\?p\=group\.php\?/g;
$response =~ s/\/group\.php/gamer\.pl\?p\=group\.php\?/g;
$response =~ s/\/group_member\.php\?/gamer\.pl\?p\=group_member\.php\?/g;
$response =~ s/\/group_member\.php/gamer\.pl\?p\=group_member\.php\?/g;
$response =~ s/\/bounty\.php\?/gamer\.pl\?p\=bounty\.php\?/g;
$response =~ s/\/bounty\.php/gamer\.pl\?p\=bounty\.php\?/g;
$response =~ s/\/group_leader\.php\?/gamer\.pl\?p\=group_leader.php\.php\?/g;
$response =~ s/\/group_leader\.php/gamer\.pl\?p\=group_leader.php\.php\?/g;
$response =~ s/\/setting\.php\?/gamer\.pl\?p\=setting\.php\?/g;
$response =~ s/\/setting\.php/gamer\.pl\?p\=setting\.php\?/g;

#$response =~ s/(.*)\.php/gamer\.pl\?p\=(.*)\.php/g;


$response =~ s/\/favor\.php\?/gamer\.pl\?p\=favor\.php\?/g;
$response =~ s/\/t\.php\?/gamer\.pl\?p\=home\.php\?/g;
$response =~ s/\/t\.php/gamer\.pl\?p\=home\.php\?/g;

##ajax feed
$response =~ s/ajax\/getNewsFeedStories\.php\?selectedTab\=/gamer\.pl\?p=ajax\/getNewsFeedStories\.php\?selectedTab\=/g;

print "<style>body {background-color: black !important;}</style>";
print $response;

# curl -s --user-agent 'Mozilla/5.0 (Linux; Android 4.1.1; Nexus 7 Build/JRO03D) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.166 Safari/535.19' --referer 'http://im.storm8.com/.php?udid=mynewudid3&device=droid&game=im;' --cookie ''  --data '' 'http://im.storm8.com/udid=mynewudid3&device=droid&game=im'
#print qq{<script>alert("$CURL --data '$decoded_data' 'http://$game.storm8.com/$new_ENV'");</script>};

print qq{
<img src='' alt='HOME' style='z-index:1000;width:20%;height:45px;background-color:black;position:fixed;bottom:0px;left:0%;' onClick="p('home')"/>
<img src='' alt='MISSION' style='z-index:1000;width:20%;height:45px;background-color:black;position:fixed;bottom:0px;left:20%;' onClick="p('missions')"/>
<img src='' alt='ATTACK' style='z-index:1000;width:20%;height:45px;background-color:black;position:fixed;bottom:0px;left:40%;' onClick="p('fight')"/>
<img src='' alt='UNITS' style='z-index:1000;width:20%;height:45px;background-color:black;position:fixed;bottom:0px;left:60%;' onClick="p('equipment')"/>
<img src='' alt='RECRUIT' style='z-index:1000;width:20%;height:45px;background-color:black;position:fixed;bottom:0px;left:80%;' onClick="p('group')"/>

<script type='text/javascript'>

function p(the_page) {
	window.location = 'gamer.pl?p=' + the_page + '.php';
}

</script>
};




