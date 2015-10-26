#!/usr/bin/perlml

use CGI;

my $cgi;
my $udid;
my $gameprefix;
my $cgi;
my $udid;
my $aa;
my $bb;
my $cc;
my $vs;
my $hashe;
my $hex;
my $device;
my $cap;
my $game;
my $cookie;
my $pf;
my $rad;
my $ip;
my $uas;
my $namnam;
my $cgi;
my $udid;
my $gameprefix;
my $typoy;
my $gamey;
my $vsy;
my $capy;
my $levely;
my $cohy;
my $puidlsy;
my $atomlessy;
my $buildy;
my $manamey;
my $md5ww;
my $md5www;
my $ytp;
my $md5wew;
my $ytpy;
my $html_template;
my $read;
my $outy;
my $user;
my $type;
my $name;
my $typea;
my $namea;

BEGIN{
 $cgi = new CGI;
 $udid = $cgi->param("udid");
 $atomy = $cgi->param("atomy");
 $game = $cgi->param("game");
 $device = $cgi->param("device");
 $cookie = $cgi->param("cookie");
 $type = $cgi->param("type");
 $bb = $cgi->param("bb");
 $cc = $cgi->param("cc");
 $name = $cgi->param("name");
 $ip = $cgi->param("ip");
 $namnam = $cgi->param("namnam");
 $uas = $cgi->param("uas");
 $atom = (" ", "$atomy");
 $gameprefix = defined $cgi->param("game") ? $cgi->param("game") : "wwar";
 $type = defined $cgi->param("type") ? $cgi->param("type") : "1";
    if(!defined $udid){
	print $cgi->header(-type=>'text/html', -status=>'403 Forbidden');
	print "<h1>Invalid Access</h1>";
	exit;
    }

else {
	print $cgi->header(-type=>'text/html', -charset => 'UTF-8');
    }
    open(STDERR, ">&STDOUT");
}

use CGI;
use DBI;
use Data::Dumper;

my ($username, $password) = ('shortland', 'password!');
sub logger;
sub error;
$SIG{__WARN__} = sub { my $message = shift; logger "WARNING: $message"; die $message; };

sub main {
    print "<!DOCTYPE html PUBLIC \"-//WAPFORUM//DTD XHTML Mobile 1.0//EN\" \"http://www.wapforum.org/DTD/xhtml-mobile10.dtd\">\n";
    print "<HTML><HEAD><META HTTP-EQUIV=\"Content-Type\" CONTENT=\"application/xhtml+xml; charset=UTF-8\"/><TITLE>Glitcher</TITLE></HEAD>\n";
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
		print "<div id='derp' style='displlay:none;'><small> Results: " . ($ret =~ /Success/ ? " It appears Energy was not used (+) " : " It appears Energy has been used (-)<br> OR: The mission wasn't done at all...") . "</small></div><br />\n";
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
    print "<FORM METHOD='POST' ACTION='test.pl'>\n";
 print " <INPUT type='hidden' name='udid' value='$udid' />\n";
 print " <INPUT type='hidden' name='device' value='$device' />\n";
 print " <INPUT type='hidden' name='cookie' value='$cookie' />\n";
 print " <INPUT type='hidden' name='TYPE' value='$type' />\n";
 print " <INPUT type='hidden' name='bb' value='$bb' />\n";
 print " <INPUT type='hidden' name='cc' value='$cc' />\n";
 print " <INPUT type='hidden' name='vs' value='$vs' />\n";
 print " <INPUT type='hidden' name='ip' value='$ip' />\n";
 print " <INPUT type='hidden' name='uas' value='$ENV{HTTP_USER_AGENT}' />\n";
 print " <INPUT type='hidden' name='namnam' value='$namnam' />\n";
 print " <INPUT type='hidden' name='game' value='$gameprefix' />\n";
 
 
    print " <LABEL FOR='puid'>Select a player to sanction</LABEL>\n";
    print " <div class=\"dropdown\">";
    print " <SELECT name='puid'>\n";
    my $profiles = $game->get_profile_urls;
    for my $puid (keys %$profiles){
	print " 	<OPTION value='$puid'>&nbsp;&nbsp;&nbsp;$profiles->{$puid}{name} ($puid)</OPTION>\n";
    }
    print "</SELECT>\n";
    print "</div>";
    
    
    print "<div id='broken' style='display:none;'>\n";
    print " <LABEL FOR='invid'>Select the building</LABEL>\n";
    print " <SELECT name='invid'>\n";
    my $buildings = $game->get_buildings;
    for my $invid (sort { $a <=> $b } keys %$buildings){
	my ($name, $cost) = ($buildings->{$invid}{name}, $buildings->{$invid}{cost});
	print " 	<OPTION value='$invid'>&nbsp;&nbsp;&nbsp;$name ($cost)</OPTION>\n";
    }
    print " </SELECT>\n";
    print " <LABEL FOR='qty'>Type in a building quantity $name </LABEL>\n";
    print "<input type='text' id='resizer' name=\"qty\" value='1'/>\n";
    print "</div>";
    print "<br><br>\n";
    print "<INPUT TYPE='submit' HEIGHT='25' WIDTH='80' value='Run'>";
    print "</FORM>\n";
    print "</CENTER>\n";
}

sub logger {
    my ($message) = @_;
    #my $dbh = DBI->connect('DBI:mysql:shortlando:shortlando.db.11519665.hostedresource.com', $username, $password)
    #	    || die "Unable to connect to the database\n";
    # my $sth = $dbh->prepare("INSERT INTO log(udid,pid,note) VALUES(?,?,?)");
    # $sth->execute($udid, $$, $message);
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
die "PUID $puid not found\n" if defined $puid && ! defined $ret->{$puid};
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
###
###
### NEW SHIT
###
###

###
### changed $html to $out because different function idk if these subs and in arrays affect it.
### all in single dropdown, 1.2.3.4.5.6.7.8.9... if missionnumber=1 then cat=1 and jid =3.


sub get_mission_info {
my ($udid, $outed, $out, $jid, $cat) = @_;
 
   $md5ww = Digest::MD5->new;
   $md5ww->add($udid);
   $md5ww->add(':' , 'pEarlhAbor156w' );
   $pf = $md5ww->hexdigest;
   $pf = uc($pf);

   my $CURL = "curl -s -b cookies -c cookies -L";
   my $baseurl = "http://wwar.storm8.com";
   my $url = "/missions.php?cat=1";
   `$CURL 'http://wwar.storm8.com/apoints.php?version=a1.56&udid=$udid&pf=$pf&model=Droid&sv=9A405'`;
   $out = `$CURL "${baseurl}${url}"`;
   my ($fsb, $arg) = ($out =~/\/missions\.php\?jid=3&cat=1&.*onclick=.*(fsb\d+)\('([^']+)'\);/);
   my ($js) = ($out =~ /function $fsb.*?{(.*?)}/ms);
   my @vals = split ',', $1 if $js =~ /b=new Array\(([\d,]+)\)/;
   my @use = split ',', $1 if $js =~ /p=new Array\(([\d,]+)\)/;
   die "Error: unable to fetch correct valve and usage meter: STORM8
($#vals, $#use)\n"
       if #$vals < 1 || #$use < 1;
   my $action = "";
   for my $i (0 .. $#use)
   {
       if ($use[$i]){
	   $action = chr($vals[$i]) . $action;
       } else {
	   $action .= chr($vals[$i]);
       }
   }
   $action .= $arg;
   $action = $self->{url} . ($action =~ /^\// ? "" : "/" ) . $action;
   $ret->{url} = $action;
  
   ## us doing it
   #$outed = "${baseurl}/${action}";
   ## On second thought, just call $action.
   $out =~ s/<!--//mg;
   $out =~ s/-->//mg;

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
    my ($self, $sanctioninfo, $invinfo, $out, $glitchaction) = @_;
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
	select(undef,undef,undef,.001);
	my $start = sprintf("%i.%06i", gettimeofday());
	
    ### the purchase of buildings  
    
### OLD IMPRO HERE
   
	my $html = $self->request(
	"$glitchaction",
	"POST",
	"numberOfInv=1" 
	);
	### extra data in post mode text via charles mode. nothing being posted in missions, its all via url
    #### end purchase of building(S)	
	
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
	die "It appears your not a high enough level. Error at ";
    }
}

sub request {
    my ($self, $url, $method, $data, $outed) = @_;
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
    die "A valve has failed.\n <br> Connection issue with Storm8 \n" unless $resp->is_success;
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
    my $sth = $dbh->prepare("SELECT cookie FROM stone WHERE udid = ? AND game = ? AND valid = 1");
    $sth->execute($udid,$gameprefix);
    $game{cookie} = ($sth->fetchrow_array())[0];
    die "Sorry, but it seems like thats not correct, please try again.\n" unless defined $game{cookie};
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



# print $cgi->header("text/html");

$udid = $cgi->param('udid');


$aa = $cgi->param('aa');
$bb = $cgi->param('bb');
$cc = $cgi->param('cc');
$vs = $cgi->param('vs');
$device = $cgi->param('device');
$hashe = $cgi->param('hashe');
$hex = $cgi->param('hex');
$cap = $cgi->param('cap');
$name = $cgi->param("name");
$type = $cgi->param("type");




$typoy = defined $cgi->param("typo") ? $cgi->param("typo") : "droid";

$gamey = defined $cgi->param("game") ? $cgi->param("game") : "wwar";

$vsy = defined $cgi->param("vs") ? $cgi->param("vs") : "1.0.5";

$capy = defined $cgi->param("cap") ? $cgi->param("cap") : "YELLOW";


$md5ww = Digest::MD5->new;
$md5ww->add($udid);
$md5ww->add(':' , 'pEarlhAbor156w' );
$pf = $md5ww->hexdigest;
$pf = uc($pf);

$md5www = Digest::MD5->new;
$md5www->add($udid);
$md5www->add(':' , 'dounce' );
$ytp = $md5www->hexdigest;
$ytp = uc($ytp);

$md5wew = Digest::MD5->new;
$md5wew->add($udid);
$md5wew->add(':' , 'dunce' );
$ytpy = $md5wew->hexdigest;
$ytpy = uc($ytpy);

use DBI;
use DBI();
my $dbhx = DBI->connect("DBI:mysql:database=shortlando;host=localhost",
			 "shortlando", "password!",
			 {'RaiseError' => 1});


my $sthx = $dbhx->prepare(<<End_SQL) or die "Couldn't prepare statement: $DBI::errstr; stopped";
select bg, form FROM style WHERE user = '$username'
End_SQL

$sthx->execute() or die "Couldn't execute statement: $DBI::errstr; stopped";

while ( my ($bg, $form) = $sthx->fetchrow_array() ){
$htmz = qq{
<body bgcolor="\#$bg">
<style>
form {
margin: 10px;
padding: 10px 10px;
background: \#$form;
}
input[type='text']{
    color: #333;
    width: 50%;
    height: 22px;
    left: 50%;
    top: 50%;
    padding-left: 1px;
    padding-right: 1px;
    transition: box-shadow 320ms;
    box-shadow: 0px 0px 8px 10px rgba(0,0,0,0.1);
    border-radius: 5px;
    font-size: 15px;
    border: 0px;
}
input[type='text']:focus {
    outline: 0px;
    outline-offset: 0px;
    box-shadow: 0px 0px 1px 5px rgba(0,0,0,0.12);
}
input:-moz-placeholder {
    color: #000000;
}


h1 {
	font-family: 'Alegreya SC', serif; 
 }
div {
	font-family: 'Alegreya SC', serif; 
 }	      
p {
	font-family: 'Alegreya SC', serif; 
 }

.dropdown p {
    display: inline-block;
    font-weight: bold;
    font-size:200%;
    background-color:white;   
}

.dropdown select { 
	-webkit-appearance: none;
	-moz-appearance: none;
	background: url('arrow.png') no-repeat;
	background-position: 90% 7px;
	width: 50%;
	height: 30px;
	padding: 5px;
	font-size: 16px;
	line-height: 1;
	border: 1px;
	border-radius: 5px;
	color: #000000;
    background-color:white;  
}

/* top elements */
* { padding: 0; margin: 0; outline: 0; }

body {
    margin: 0;	   padding: 0 0 0 0;}
input[type=submit] {
    color: #000000;
    font:2.4em Futura, ‘Century Gothic’, AppleGothic, sans-serif;
    font-size:100%;
    width: 80px;
    height: 30px;
    cursor: pointer;
    border-radius: 5px;
    background-color: #ffffff;
    border: 3px solid #000000;
}
input[type=submit]:hover{
    border-radius: 5px;
    background-color: #ffffff;
    border: 3px solid #006600;
    color:#66FF33;
}
img:hover{
	background:rgba(0,0,0);
	text-align:center;
	opacity:0.4;
	-webkit-transition: opacity .25s ease;
}
input[type=image]:hover{
    border-radius: 15px;
    border:3px solid #ffffff;
    color:#ffffff;
}
input[type=image]{
    border-radius: 15px;
    border:3px solid #000000;
    color:#ffffff;
}
input[type=reset], 
	#resetButtonID,
	.resetButtonClass-Name {
  
}

input[type=reset]:hover,
	#resetButtonID:hover,
	.resetButtonClass-Name:hover {
   
}

input[type=reset]:active,
	#resetButtonID:active,
	.resetButtonClass-Name:active {
 }

input[type=reset]:focus,
	#resetButtonID:focus,
	.resetButtonClass-Name:focus {
   
}
</style>};
print $htmz
  
 }	
 $dbhx->disconnect();

### None Changing variables, why need definition? (change device type only folder mobile/mobile-a###
#$devicetype = ('index');
#$gametype = ('wwar');
#$game = ('$gamez');

#if ($devicetype !~ /^(aindex|index)$/) {
#    print "Please select a Device";
#    exit 0;
#}

#if ($gametype !~ /^(wwar|im|kl|rl|vl|zl|nl|pl|rol)$/) {
#    print "Please choose a valid game";
#    exit 0;
#}

my $ua = new LWP::UserAgent;
$ua->cookie_jar({});
use Data::Dumper;
$ua->get("http://wwar.storm8.com/apoints.php?version=a1.56&udid=$udid&pf=$pf&model=Droid&sv=9A405");
my $cookie = encode_base64($ua->cookie_jar->as_string);


#print "$cookie \n";

$html_template = qq{<!DOCTYPE html>
    <html>
    
    <head>
    <meta name="viewport" content="user-scalable=no, width=device-width" />
    <meta http-equiv="content-type" content="application/xhtml+xml; charset=UTF-8" />
	</head>

<br><img src="images/home.png" value="Done" onclick="home()" form="" height="45" width="20%" /><img src="images/missions.png" value="Done" onclick="missions()" form="" height="45" width="20%" /><img src="images/fight.png" value="Done" onclick="attack()" form="" height="45" width="20%" /><img src="images/equipment.png" value="Done" onclick="equip()" form="" height="45" width="20%" /><img src="images/group.png" value="Done" onclick="recruit()" form="" height="45" width="20%" /><div id="frame"></div> 
</center>
<body onload="javascript:lead()">

<script>
function lead()
{

login();
toggle_visibility('foo');

}
</script>


<script type="text/javascript">
<!--
    function toggle_visibility(id) {
       var e = document.getElementById(id);
       if(e.style.display == 'none')
	  e.style.display = 'block';
       else
	  e.style.display = 'none';
    }
//-->
</script>

<script type="text/javascript">
function login()
{
document.getElementById('frame').innerHTML = '<iframe src="http://wwar.storm8.com/apoints.php?version=a1.56&udid=$udid&pf=$pf&model=Droid&sv=9A405" width="100%" height="550" style="background-image: url(1.jpg);" frameBorder="0"></iframe>';
}
</script><script type="text/javascript">
function home()
{
document.getElementById('frame').innerHTML = '<iframe src="http://wwar.storm8.com/home.php" width="100%" height="550" style="background-image: url(1.jpg);" frameBorder="0"></iframe>';
}
</script><script type="text/javascript">
function missions()
{
document.getElementById('frame').innerHTML = '<iframe src="http://wwar.storm8.com/missions.php" width="100%" height="550" style="background-image: url(1.jpg);" frameBorder="0"></iframe>';
}
</script><script type="text/javascript">
function attack()
{
document.getElementById('frame').innerHTML = '<iframe src="http://wwar.storm8.com/fight.php" width="100%" height="550" style="background-image: url(1.jpg);" frameBorder="0"></iframe>';
}
</script><script type="text/javascript">
function equip()
{
document.getElementById('frame').innerHTML = '<iframe src="http://wwar.storm8.com/equipment.php" width="100%" height="550" style="background-image: url(1.jpg);" frameBorder="0"></iframe>';
}
</script><script type="text/javascript">
function recruit()
{
document.getElementById('frame').innerHTML = '<iframe src="http://wwar.storm8.com/group.php" width="100%" height="550" style="background-image: url(1.jpg);" frameBorder="0"></iframe>';
}
</script><script type="text/javascript">
function heal()
{
document.getElementById('heal').innerHTML = '<iframe src="http://wwar.storm8.com/hospital.php?action=heal" width="0" height="0" style="background-image: url(1.jpg);" frameBorder="0"></iframe>';
}
</script><script type="text/javascript">
function profile()
{
document.getElementById('frame').innerHTML = '<iframe src="http://wwar.storm8.com/profile.php" width="100%" height="550" style="background-image: url(1.jpg);" frameBorder="0"></iframe>';
}
</script>


<div id="heal"> </div>



<!-----<form>Account details: <br><small><tiny>Name: $manamey<br>Level: $levely<br>CoH: $cohy<br>Last Sanctioned: $puidlsy<br>Last Amount: $atomlessy<br>Last Building: $buildy</tiny></small></form>----->

<form>Private Info:<br><small><tiny>Name: $namnam<br>Game: $gamey <br> Device Type: $typoy <br> UDID: $udid <br> PF: $pf <br>Valid: $ytpy<br>ID: $ytp<br>Version: $vsy<br>CAP: $capy</tiny></small></form>
    </body>
    </html>
};


print $html_template;