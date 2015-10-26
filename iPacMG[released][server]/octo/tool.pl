#!/usr/bin/perlml

use CGI;

my $cgi; my $gotping; my $newping; my $udid; my $gameprefix;
my $udid; my $aa; my $bb; my $cc; my $as; my $hashe;
my $hex; my $device; my $cap; my $game; my $cookie; my $user;
my $pf; my $rad; my $ip; my $uas; my $namnam; my $cgi; my $udid;
my $gameprefix; my $typoy; my $gamey; my $vsy; my $capy; my $levely;
my $cohy; my $puidlsy; my $atomlessy; my $buildy; my $manamey; my $md5ww;
my $md5www; my $ytp; my $md5wew; my $ytpy; my $html_template; my $read;
my $outy; my $user; my $type; my $name; my $typea; my $namea; my $id;
my $udid_; my $game_; my $device_; my $pf_; my $cookie_; my $bg; my $bg_a; my $form; my $form_a;  my $valid;
my $id; #my $real_username;

BEGIN{
    $cgi = new CGI;
    $id = $cgi->param("id");

require "../cookie_login.pl";

sub input_cleaner {
    ($replace) = @_;
    $replace =~ s/'//g; $replace =~ s/"//g; $replace =~ s/\%//g; $replace =~ s/\*//g; $replace =~ s/\+//g; $replace =~ s/\.//g; $replace =~ s/\,//g; $replace =~ s/\(//g; $replace =~ s/\)//g; $replace =~ s/\~//g; $replace =~ s/\///g; $replace =~ s/\\//g;
    return "$replace";
}

if (($id =~ /('|"|\%|\*|\+|\.|\,|\(|\)|\~|\/|\\)/) || (!defined $id)){
print $cgi->header(-type=>'text/html', -status=>'403 Forbidden');
open(my $fh, '>>', 'tool_reports.txt');
print $fh "
>>>>>>>>>>>>>>>\n
 ID  ERROR\n $ENV{HTTP_USER_AGENT}\n $ENV{HTTP_REFERER}\n $ENV{QUERY_STRING}\n $ENV{REMOTE_ADDR}\n $udid\n $atomy\n $game\n $delay\n $device\n $name\n $gotping\n $atom\n $gameprefix\n
>>>>>>>>>>>>>>>\n\n";
 close $fh;
 $id = input_cleaner($id);
 }
else {
	print $cgi->header(-type=>'text/html', -charset => 'UTF-8');

     }
    open(STDERR, ">&STDOUT");
 	
 my $dbh = DBI->connect("DBI:mysql:database=shortlando;host=localhost",
 "shortland", "password!",
    {'RaiseError' => 1});
 my $sth = $dbh->prepare("SELECT udid, game, device, pf, cookie FROM accs WHERE username = ? AND ID = ?");
 $sth->execute($real_username, $id) or die "Couldn't execute statement: $DBI::errstr; stopped";
 
 while ( my ($udid_, $game_, $device_, $pf_, $cookie_) = $sth->fetchrow_array() ) {
     $udid = $udid_;
     $game = $game_;
     $gameprefix = $game_;
     $device = $device_;
     $pf = $pf_;
     $cookie = $cookie_;
     $valid = "ok";
 }
 $dbh->disconnect();
 
  my $sth2 = $dbh->prepare("SELECT bg, form FROM style WHERE user = ?");
 $sth2->execute($real_username) or die "Couldn't execute statement: $DBI::errstr; stopped";
 
 while ( my ($bg_a, $form_a) = $sth2->fetchrow_array() ) {
     $bg = $bg_a;
     $form = $form_a;
     $valid2 = "ok";
     
 }
 $dbh->disconnect();

if($valid2 =~ "ok"){
print "<style>
    \@import url(http://fonts.googleapis.com/css?family=Lato);
    *{
        -webkit-appearance: none;
        -moz-appearance: none;
        font-family: 'Lato', sans-serif !important;
    }

body {
margin: 0;
padding: 0 0 0 0;
background-color: $bg;
}
form {
margin: 10px;
padding: 10px 10px;
background-color: $form;
border-radius: 5px;
border: 0px;
}
</style>";
}

 if($valid !~ "ok"){
 print "Invalid Access\n";
 exit;
 }
 
 #print $real_username;
}
# use strict;
# use warnings;
use CGI;
use DBI;
use Data::Dumper;




my ($username, $password) = ('shortland', 'password!');
sub logger;
sub error;
$SIG{__WARN__} = sub { my $message = shift; logger "WARNING: $message"; die $message; };

sub main {
    print "<!DOCTYPE html PUBLIC \"-//WAPFORUM//DTD XHTML Mobile 1.0//EN\" \"http://www.wapforum.org/DTD/xhtml-mobile10.dtd\">\n";
    print "<HTML><HEAD><META HTTP-EQUIV=\"Content-Type\" CONTENT=\"application/xhtml+xml; charset=UTF-8\"/><TITLE> $game </TITLE><script src=\"http:\/\/code.jquery.com\/jquery-2.1.1.min.js\"></script></HEAD>\n";
    my ($puid, $invid, $qty) = ($cgi->param("puid"), $cgi->param("invid"), $cgi->param("qty"));
    eval {
	my $game = new Storm8(udid => $udid, url => "http://${gameprefix}.storm8.com");
	print_form($game,$udid);
	if (!defined $puid || !defined $invid || !defined $qty) {
	    ;
	} elsif($puid =~ /^[0-9]+$/ && $invid =~ /^[0-9]+$/ && $qty =~ /^[0-9]+$/) {
	    print "<div class='msg'>\n";
	    my ($ret, $before, $after) = @{$game->auto_sanction($puid,$invid,$qty)};
	    if ($ret =~ /Failure:/){
		logger $ret;
		print "<h3>$ret</h3>\n";
	    } else {
		print "<center><form><H3>Glitch has: " . ($ret =~ /Success/ ? "Succeeded" : "failed, Try again.") . "</H3></form></center><br />\n";
	    }
	    print "Cash Before : $before, Cash After: $after<br />\n" if defined $before && $before > 0;
	    print "</div>\n";
	} else {
	    print "<b>Bad data: ($puid, $invid, $qty)</b>\n";
	}
    };
    my $error = $@;
    error($error) if $error;
}

sub print_form {
    my ($game, $udid) = @_;
    print "<CENTER>\n";
    print "<FORM METHOD='POST' ACTION='tool.pl'>\n";
    print "<input type='hidden' name='id' value='$id'>";
    print " <LABEL FOR='puid' style='color:black !important;'>Select a player to sanction </LABEL><br>\n";
    print " <SELECT name='puid' id='ddp'>\n";
    my $profiles = $game->get_profile_urls;
    for my $puid (keys %$profiles){
	print " 	<OPTION value='$puid'>&nbsp;&nbsp;&nbsp;$profiles->{$puid}{name} ($puid)</OPTION>\n";
    }
    print " </SELECT>\n";
    print " <BR />\n";
    print " <LABEL FOR='invid' style='color:black !important;'>Select the building </LABEL><br>\n";
    print " <SELECT name='invid' id='ddp'>\n";
    my $buildings = $game->get_buildings;
    for my $invid (sort { $a <=> $b } keys %$buildings){
	my ($name, $cost) = ($buildings->{$invid}{name}, $buildings->{$invid}{cost});
	print " 	<OPTION value='$invid'>&nbsp;&nbsp;&nbsp;$name ($cost)</OPTION>\n";
    }
    print " </SELECT>\n";
    print " <BR />\n";
    print " <LABEL FOR='qty' style='color:black !important;'>Type in a building quantity  </LABEL><BR>\n";
    print "<input type='tel' name=\"qty\" value='$atom'/>\n
    <br></br>
";
    #print " <INPUT type='text' name='qty' value='$atom' />\n";
    print "
<style>
 input[type='text'], input[type='tel']{
    color: #000000\;
    width: 200px\;
    height: 22px\;
    border: 1px solid black\;
    border-radius: 5px\;
}
</style>";

    print "<INPUT TYPE='submit' value='Glitch!'>";

print qq{
<br><br>
<button type='button' onClick='showsell()' id='submit'> + </button>
<div id='sellers' style='display:none;'>
<iframe src='sell.pl?id=$id' frameBorder='0' style='width:100%;height:200px;border-radius:10px;'></iframe>
</div>
<script>
function showsell() {
\$('#sellers').fadeToggle('slow');
}
</script>
};
    print "</CENTER>\n";
}

sub logger {
    my ($message, $user) = @_;
    my $dbh = DBI->connect('DBI:mysql:shortlando:localhost', $username, $password)
	    || die "Unable to connect to the database\n";
     my $sth = $dbh->prepare("INSERT INTO log(udid,pid,note,username) VALUES(?,?,?,?)");
     $sth->execute($udid, $$, $message, $real_username);
}

sub error {
    my ($message, $game) = @_;
    print "Error: $message\n";
    if(defined $game){
	logger "Error: " . Dumper($game->{responses});
	logger "Error (LastResp): " . Dumper($game->{lastresp})
	if defined $game->{lastresp};
    }
}
    print "</FORM>\n";
main;

package Storm8;
use DBI;
use MIME::Base64;
use HTTP::Cookies;
use HTTP::Request;
use LWP::UserAgent;
use File::Temp qw(tempfile);
use MIME::Base64;
use Time::HiRes qw(gettimeofday);

sub login {
    my ($self) = @_;
    my ($cookie, $game) = ($self->{cookie}, $self->{game});
    if(defined $cookie){
	my ($fh, $fname) = tempfile();
	print $fh "#LWP-Cookies-1.0\n";
	print $fh decode_base64($cookie);
	$fh->flush();
	$self->{ua}->cookie_jar->load($fname);
    } else {
	die "Please contact support to reinitialize your account\n";
    }
}

sub get_profile_urls {
    my ($self, $puid) = @_;
    my $ret = {};
    my $url = ${self}->{url} . "/ajax/getNewsFeedStories.php?selectedTab=fight";
    my $html = $self->request($url);
    while ($html =~ m#/(profile\.php\?puid=(\d+)\&[^"'\\]*)[^>]+>([^<]+)#mg) {
	my ($url, $puid, $name) = ("$self->{url}/$1", $2, $3);
    next unless defined $name && $name =~ /\S/;
    $ret->{$puid}{url} = $url;
    $ret->{$puid}{name} = $name;
}
die "ERROR: PUID $puid not found(Appears the person is no longer on your newsfeed)\n" if defined $puid && ! defined $ret->{$puid};
return defined $puid ? $ret->{$puid}{url} : $ret;
}

sub get_buildings {
    my ($self) = @_;
    my $ret = {};
    my $url = $self->{url} . "/investment.php";
    my $html = $self->request($url);
    my ($name, $id, $cost);
    while ($html =~ m#<table[^>]*>(.*?)</table>#mgis) {
	my $table = $1;
    ($name) = ($table =~ /div class="reName"[^>]*>([^<]*)/);
    ($id) = ($table =~ /\Winv_id=(\d+)/);
    my ($cell) = ($table =~ m#<td class="reBuyAction"(.*?)</td>#ms);
    if (defined $cell) {
	($cost) = ($cell =~ /class="cash[^>]*>(.*?)<\/div>/);
    }
    $cost =~ s/\s*<.*?>\s*//g if defined $cost;
    $ret->{$id} = { name => $name, cost => $cost } if
	defined $name && $name =~ /\S/ &&
	defined $id &&
	defined $cost && $cost =~ /^\$?[\d,]/
	}
return $ret;
}

sub get_bounty_url {
    my ($self, $profileurl) = @_;
    my $html = $self->request($profileurl);
    my ($bounty) = ($html =~ /(bounty\.php\?hitlist_id=\d+\&[^'"]+)/);
    die "Bounty not found" unless defined $bounty;
    return "$self->{url}/$bounty";
}

sub get_sanction_info {
    my ($self, $url) = @_;
    my $ret = {};
    my $html = $self->request($url);
    
    # Update current - this is global
    $self->{cashCurrent} = get_current($html);
    
    # Get the minimum for the bounty
    my ($minimum) = ($html =~ /minimum \S+ amount is.*>\$?([\d,]*)<\/span>/);
    die "Minimum bounty not found" unless defined $minimum;
    $minimum =~ s/,//g;
    $ret->{minimum} = $minimum;
    
    # Their code has a nasty trick, which we have to duplicate
    my @vals = split ',', $1 if $html =~ /b=new Array\(([\d,]+)\)/;
    my @use = split ',', $1 if $html =~ /p=new Array\(([\d,]+)\)/;
    die "This site needs to be updated to handle new countermeasures ($#vals, $#use)\n"
    if $#vals < 1 || $#use < 1;
    my ($add) = ($html =~ /onsubmit="[^']+'([0-9a-f]+)'/);
    die "This site needs to be updated to handle new countermeasures\n"
    unless defined $add;
    my $action = "";
    for my $i (0 .. $#use) {
	if ($use[$i]){
	    $action = chr($vals[$i]) . $action;
	} else {
	    $action .= chr($vals[$i]);
	}
    }
    $action .= $add;
    $action = $self->{url} . ($action =~ /^\// ? "" : "/" ) . $action;
    $ret->{url} = $action;
    
    my ($submit) = ($html =~ /type="submit" value="([^"]+)"/);
    die "Submit text not found" unless defined $submit;
    $submit =~ s/ /+/g;
    $ret->{submit} = $submit;
    
    return $ret;
}

sub glitch {
    my ($self, $sanctioninfo, $invinfo) = @_;
    die "Bad Data" unless $invinfo->{qty} > 0 && $invinfo->{id} > 0;
    my $cash = $self->{cashCurrent};
    pipe my $reader, my $writer;
    my $pid = fork;
    defined $pid or die "Couldn't fork: $!";
    if($pid){ # Parent
	# Run the sanction
	my ($sanction, $purchase);
	my ($sanctioncash, $purchasecash);
	{
	    my $start = sprintf("%i.%06i", gettimeofday());
	    $sanction = $self->request(
	    $sanctioninfo->{url},
	    "POST",
	    "bountyValue=$sanctioninfo->{minimum}\&action=$sanctioninfo->{submit}"
	    );
	    my $finish = sprintf("%i.%06i", gettimeofday());
	    my $diff = $finish - $start;
	    $sanctioncash = get_current($sanction);
	    $self->{sanctionCost} = $sanctioninfo->{minimum};
	    main::logger "Sanction Started: $start";
	    main::logger "Sanction Finished: $finish";
	    main::logger "Sanction Elapsed Time: $diff";
	    main::logger "Cash after sanction: $sanctioncash";
	}
	# Handle the child
	close $writer;
	{
	    my $start = <$reader>; chomp $start;
	    my $finish = <$reader>; chomp $finish;
	    my $diff = $finish - $start;
	    local $/ = undef;
	    $purchase = <$reader>;
	    $purchasecash = get_current($purchase);
	    my $spent = $cash - $purchasecash;
	    main::logger "Purchase Started: $start";
	    main::logger "Purchase Finished: $finish";
	    main::logger "Purchase Elapsed Time: $diff";
	    main::logger "Cash after purchase: $purchasecash";
	}
	close $reader;
	# Process the results
	my $victory = ($sanction =~ /span class="success"/);
	my $expected = $cash - $sanctioninfo->{minimum};
	$self->{previousCash} = $cash;
	my $current = $self->{currentCash} = get_current($self->request($self->{url} . "/home.php"));
	main::logger "At the start: $cash; After purchase: $purchasecash; After sanction: $sanctioncash";
	main::logger "Victory detected: " . ($victory ? "Yes" : "No");
	main::logger "Expected and Current Agree: " . ($expected == $current ? "Yes" : "No");
	if ($expected != $current) {
	    main::logger "Purchase HTML: $purchase";
	    main::logger "Sanction HTML: $sanction";
	}
	if ($sanction =~ /class="fail">Failure:<\/span>([^<]+)<\/div>/) {
	    return "Failure: $1";
	}
	return ($expected == $current ? "Success" : "Failure");
    } else {	    # Child
	close $reader;
#	select(undef,undef,undef,.0001);
	my $start = sprintf("%i.%06i", gettimeofday());
	my $html = $self->request(
	"http://${gameprefix}.storm8.com/investment.php?action=buy&inv_id=$invinfo->{id}",
	"POST",
	"numberOfInv=$invinfo->{qty}"
	);
	my $finish = sprintf("%i.%06i", gettimeofday());
	print $writer "$start\n$finish\n$html\n";
	close $writer;
	exit;
    }
}

sub auto_sanction {
    my ($game, $puid, $invid, $invqty) = @_;
    my $ret = ["Glitch didn't run",0,0,""];
    eval {
	eval {
	    my $profile = $game->get_profile_urls($puid);
	    my $bounty = $game->get_bounty_url($profile);
	    my $sanctioninfo = $game->get_sanction_info($bounty);
	    $ret->[0] = $game->glitch($sanctioninfo, { id => $invid, qty => $invqty });
	    $ret->[1] = $game->{cashPrevious};
	    $ret->[2] = $game->{cashCurrent};
	};
	my $error = $@;
	main::error($error, $game) if $error;
    };
    my $error = $@;
    main::error($error) if $error;
    return $ret;
}


sub get_current {
    my ($html) = @_;
    if ($html =~ /"cash":.*?"value":(\d+)/) {
	return "$1";
    } else {
	die "Couldn't find cashCurrent";
    }
}

sub request {
    my ($self, $url, $method, $data) = @_;
    my $func = (caller(1))[3];
    $method = "GET" unless defined $method;
    die "Internal error; invalid request of $method\n" unless $method =~ (/^(GET|POST)$/);
    my $req = new HTTP::Request($method => $url);
    if(defined $data){
	$req->header('Content-Type' => 'application/x-www-form-urlencoded');
	$req->content($data);
    }
    $req->referer($self->{last_url}) if defined $self->{last_url};
    $self->{last_url} = $url;
    my $resp = $self->{ua}->request($req);
    $self->{"responses"}{$func} = $resp->content;
    $self->{"lastresp"} = ($resp->is_success ? undef : $resp);
    die "<option>ERORR S8</option></select><BR>\n" unless $resp->is_success;
    return $resp->content;
}

sub new {
    shift @_ if $_[0] eq "Storm8";
    my %game = @_;
    my $game = \%game;
    $game{ua} = new LWP::UserAgent;
    $game{ua}->cookie_jar({});
    $game{ua}->agent("Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; WOW64; Trident/5.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; .NET 4.0C; .NET 4.0E)");
    push @{ $game{ua}->requests_redirectable }, 'POST';
    my $dbh = DBI->connect('DBI:mysql:shortlando:localhost', $username, $password)
    || die "Unable to connect to the database\n";
    my $sth = $dbh->prepare("SELECT cookie FROM accs WHERE udid = ? AND game = ? AND valid = 1");
    $sth->execute($udid,$gameprefix);
    $game{cookie} = ($sth->fetchrow_array())[0];
    die "Sorry, but it seems like thats not correct, $udid $gameprefix please try again.\n" unless defined $game{cookie};
    bless $game, "Storm8";
    $game->login;
    return $game;
}

# vim:set ts=2:


use v5.10;
use Digest::MD5;
use CGI;
use File::Temp qw(tempfile);
use HTTP::Cookies;
use LWP::UserAgent;
use MIME::Base64;

$cgi = new CGI;
$id = $cgi->param("id");



sub input_cleaner {
    ($replace) = @_;
    $replace =~ s/'//g; $replace =~ s/"//g; $replace =~ s/\%//g; $replace =~ s/\*//g; $replace =~ s/\+//g; $replace =~ s/\.//g; $replace =~ s/\,//g; $replace =~ s/\(//g; $replace =~ s/\)//g; $replace =~ s/\~//g; $replace =~ s/\///g; $replace =~ s/\\//g;
    return "$replace";
}

if (($id =~ /('|"|\%|\*|\+|\.|\,|\(|\)|\~|\/|\\)/) || (!defined $id)){
print $cgi->header(-type=>'text/html', -status=>'403 Forbidden');
open(my $fh, '>>', 'tool_reports.txt');
print $fh "
>>>>>>>>>>>>>>>\n
 ID  ERROR\n $ENV{HTTP_USER_AGENT}\n $ENV{HTTP_REFERER}\n $ENV{QUERY_STRING}\n $ENV{REMOTE_ADDR}\n $udid\n $atomy\n $game\n $delay\n $device\n $name\n $gotping\n $atom\n $gameprefix\n
>>>>>>>>>>>>>>>\n\n";
 close $fh;
 $id = input_cleaner($id);
 }


require "../cookie_login.pl";

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

$md5ww = Digest::MD5->new;
$md5ww->add($udid);
$md5ww->add(':' , $salt );
$pf = $md5ww->hexdigest;
$pf = uc($pf);


$html_temp = qq{<!DOCTYPE html>
    <html>
    <head>
    <meta name="viewport" content="width=device-width, height=device-height, user-scalable=no">
    <meta http-equiv="content-type" content="application/xhtml+xml; charset=UTF-8" />
<style>

* { padding: 0; margin: 0; outline: 0; }

#ddp { 
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

input[type=submit], #submit {
    color: #000000;
    font-size:100%;
    width: 80px;
    height: 30px;
    cursor: pointer;
    border-radius: 5px;
    background-color: #ffffff;
    border: 1px solid #000000;
}
input[type=submit]:hover, #submit:hover{
    background-color: #000000;
    border: 1px solid #ffffff;
    color:#ffffff;
}
body
{
color:white;
}
div#iframe_container { 
width:100%; 
overflow-x:auto; 
-webkit-overflow-scrolling: touch;
}
</style>


<br>
<br></div></center>
<div id='blackspace' style='height:5px;width:100%;background-color:#000000;'></div><img src="pics/home.png" value="Done" onclick="home()" height="45" width="20%" /><img src="pics/missions.png" value="Done" onclick="missions()" form="" height="45" width="20%" /><img src="pics/fight.png" value="Done" onclick="attack()" form="" height="45" width="20%" /><img src="pics/equipment.png" value="Done" onclick="equip()" form="" height="45" width="20%" /><img src="pics/group.png" value="Done" onclick="recruit()" form="" height="45" width="20%" />




<div id="iframe_container"><div id="frame"></div></div>
<div id='blackspace' style='height:15px;width:100%;background-color:#000000;'></div>
<body onload="javascript:lead()">

<script>
function lead()
{
login();
CallButton();
}
</script>

<script type="text/javascript">
setTimeout("CallButton()",1500)
function CallButton()
{
window.scrollTo(0, 0);
document.getElementById('frame').innerHTML = '<iframe src="http://$game.storm8.com/$end=$pf" width="100%" height="550" style="background-color:black;align:middle;overflow-y: visible !important;" frameBorder="0"></iframe>';	
}
</script>


<script type="text/javascript">
function login()
{
document.getElementById('frame').innerHTML = '<iframe src="http://$game.storm8.com/$end=$pf" width="100%" height="550" style="background-color:black;overflow-y: visible !important;" frameBorder="0"></iframe>';
setTimeout(home, 2000);
}
function home()
{
document.getElementById('frame').innerHTML = '<iframe src="http://$game.storm8.com/home.php" width="100%" height="550" style="background-color:black;overflow-y: visible !important;" frameBorder="0"></iframe>';
}
function missions()
{
document.getElementById('frame').innerHTML = '<iframe src="http://$game.storm8.com/missions.php" width="100%" height="550" style="background-color:black;overflow-y: visible !important;" frameBorder="0"></iframe>';
}
function attack()
{
document.getElementById('frame').innerHTML = '<iframe src="http://$game.storm8.com/fight.php" width="100%" height="550" style="background-color:black;overflow-y: visible !important;" frameBorder="0"></iframe>';
}
function equip()
{
document.getElementById('frame').innerHTML = '<iframe src="http://$game.storm8.com/equipment.php" width="100%" height="550" style="background-color:black;overflow-y: visible !important;" frameBorder="0"></iframe>';
}
function recruit()
{
document.getElementById('frame').innerHTML = '<iframe src="http://$game.storm8.com/group.php" width="100%" height="550" style="background-color:black;overflow-y: visible !important;" frameBorder="0"></iframe>';
}
function profile()
{
document.getElementById('frame').innerHTML = '<iframe src="http://wwar.storm8.com/profile.php" width="100%" height="550" style="background-color:black;overflow-y: visible !important;" frameBorder="0"></iframe>';
}
function heal()
{
document.getElementById('heal').innerHTML = '<iframe src="$game\_heal.html" width="1px" height="1px" frameBorder="0"></iframe>';
}
function healone()
{
document.getElementById('healone').innerHTML = '<iframe src="http://$game.storm8.com/hospital.php?action=heal" width="1px" height="1px" frameBorder="0"></iframe>';
}
</script>
<BR><BR><BR><BR><BR><BR><BR>
<div id="heal" style='display:none;'></div>

<div id="healone" style='display:none;'></div>
    </body>
    </html>
};


print $html_temp;