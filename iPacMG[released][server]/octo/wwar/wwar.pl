#!/usr/bin/perl

use CGI;

my $cgi;my $gameprefix;my $cgi;my $aa;my $bb;
my $cc;my $vs;my $hashe;my $hex;my $device;my $cap;my $game;my $cookie;my $pf;
my $rad;my $ip;my $uas;my $namnam;my $cgi;my $gameprefix;my $typoy;
my $gamey;my $vsy;my $capy;my $levely;my $cohy;my $puidlsy;my $atomlessy;my $buildy;
my $manamey;my $md5ww;my $md5www;my $ytp;my $md5wew;my $ytpy;my $html_template;my $read;
my $outy;my $user;my $type;my $name;my $typea;my $namea;my $mission;my $jid;my $cat;my $id;
#my $real_username; # no display when active
my $udid_;
my $udid;

BEGIN{
    $cgi = new CGI;
    $id = $cgi->param("id");
    $mission = $cgi->param("mission");
    $gameprefix = "wwar";
    $game = "wwar";
    
    sub input_cleaner {
        ($replace) = @_;
        $replace =~ s/'//g; $replace =~ s/"//g; $replace =~ s/\%//g; $replace =~ s/\*//g; $replace =~ s/\+//g; $replace =~ s/\.//g; $replace =~ s/\,//g; $replace =~ s/\(//g; $replace =~ s/\)//g; $replace =~ s/\~//g; $replace =~ s/\///g; $replace =~ s/\\//g;
        return "$replace";
    }
    if (($id =~ /('|"|\%|\*|\+|\.|\,|\(|\)|\~|\/|\\)/) || (!defined $id)){
        print $cgi->header(-type=>'text/html', -status=>'403 Forbidden');
    open(my $fh, '>>', 'mission_reports.txt');
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

require "../../cookie_login.pl";

use DBI;
use DBI();
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
#$dbh->disconnect(); # dont cancel this out unless you wont be using sql anymore

#print "$real_username - $id - $udid - $device - $pf - $game\n"; ## printed username only when removing my $real_username @ header

if($valid !~ "ok"){
    print "Invalid Access\n";
    exit;
}

my $sth2 = $dbh->prepare("SELECT bg, form FROM style WHERE user = ?");
$sth2->execute($real_username) or die "Couldn't execute statement: $DBI::errstr; stopped";

while ( my ($bg_a, $form_a) = $sth2->fetchrow_array() ) {
    $bg = $bg_a;
    $form = $form_a;
    $valid2 = "ok";
    
}
$dbh->disconnect();

if($valid2 =~ "ok"){
    $styling = "<style>
    * {
-webkit-appearance: none;
}
#submit {
width: 80px;
height:30px;
border: 1px solid black;
color: black;
background-color: white;
border-radius: 5px;
}
    body {
    margin: 0;
    padding: 0 0 0 0;
        background-color: \#$bg !important;
    }
    form {
    margin: 10px;
    padding: 10px 10px;
        background-color: \#$form !important;
        border-radius: 5px;
    border: 0px;
    }
    </style>";
}




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
    print "<HTML><HEAD><META HTTP-EQUIV=\"Content-Type\" CONTENT=\"application/xhtml+xml; charset=UTF-8\"/><TITLE>$real_username Loot Glitcher</TITLE></HEAD>\n";
    print $styling;
    my ($puid, $invid, $qty) = ($cgi->param("puid"), $cgi->param("invid"), $cgi->param("qty"));
    eval {
        my $game = new Storm8(udid => $udid, url => "http://${gameprefix}.storm8.com");
        print_form($game,$udid,$cat,$jid,$mission);
        
        if (!defined $puid || !defined $invid || !defined $qty) {
            ;
        } elsif($puid =~ /^[0-9]+$/ && $invid =~ /^[0-9]+$/ && $qty =~ /^[0-9]+$/) {
            print "<div class='msg'>\n";
            my ($ret, $before, $after) = @{$game->auto_sanction($puid,$invid,$qty)};
            if ($ret =~ /Failure:/){
                logger $ret;
                print "<h3>$ret</h3>\n";
            }
            if ($ret =~ /Loot:/){
                logger $loot;
                print "<h3>We've gotten something pretty!</h3>\n";
            } else {
                print "<div id='castle' style='background-color:white;border-radius:5px;padding-left:5px;padding-right:5px;border:2px black;'><br><center><h3> " . ($ret =~ /Success/ ? " It appears the glitch was successful.<br> " : " It appears the glitch was not successful.<br> ") . "<br></div></center></h3><br/>\n";
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
    my ($game, $udid, $cat, $jid, $mission) = @_;
    print "<CENTER>\n";
    print " <FORM METHOD='POST' ACTION='wwar.pl'>\n";
    print " <INPUT type='hidden' name='id' value='$id'/>\n";
    print " <LABEL FOR='puid'>Select a player to sanction</LABEL><br>\n";
    
    print " <SELECT name='puid' id='dps'>\n";
    my $profiles = $game->get_profile_urls;
    for my $puid (keys %$profiles){
        print " <OPTION value='$puid'>$profiles->{$puid}{name}</OPTION>\n";
    }
    print " </SELECT><br><br>\n";
    
    print " <div id='broken' style='display:none;'>\n";
    print " <LABEL FOR='invid'>Select the building</LABEL>\n";
    print " <SELECT name='invid'>\n";
    my $buildings = $game->get_buildings;
    for my $invid (sort { $a <=> $b } keys %$buildings){
        my ($name, $cost) = ($buildings->{$invid}{name}, $buildings->{$invid}{cost});
        print " 	<OPTION value='$invid'>&nbsp;&nbsp;&nbsp;$name ($cost)</OPTION>\n";
    }
    print " </SELECT>\n";
    print " <LABEL FOR='qty'>Type in a building quantity</LABEL>\n";
    print " <input type='text' id='resizer' name=\"qty\" value='1'/>\n";
    print " </div>\n";
    print " <label for='mission'>Select a mission to glitch</label><br>";
    
    print "
    <select name='mission' id='dps'>
    <option value='nan'>&bull;&bull;Tab 1 Missions&bull;&bull;</option>
    <option value='1'>Fend off Enemy Attack</option>
    <option value='2'>Hunt Down Enemies</option>
    <option value='3'>Train Armed Forces</option>
    <option value='4'>Seize Enemy</option>
    <option value='5'>Locate Enemy Camp</option>
    <option value='6'>Establish Base Defense</option>
    <option value='7'>Destroy Enemy Base</option>
    <option value='8'>Invade Enemy Territory</option>
    <option value='nan'>&bull;&bull;Tab 2 Missions&bull;&bull;</option>
    <option value='9'>Set up Military Camp</option>
    <option value='10'>Scout Out Enemy</option>
    <option value='11'>Sink Enemy Boats</option>
    <option value='12'>Intercept Shipment</option>
    <option value='13'>Ship Supplies to Troops</option>
    <option value='14'>Shoot Down Aircraft</option>
    <option value='15'>Investigate Wreckage</option>
    <option value='16'>Prepare Army to March</option>
    <option value='nan'>&bull;&bull;Tab 3 Missions&bull;&bull;</option>
    <option value='17'>Infiltrate Western Border</option>
    <option value='18'>Take out Western Forces</option>
    <option value='19'>Discover Reinforcements</option>
    <option value='20'>Repel Counterattack</option>
    <option value='21'>Bombard Enemy Defenses</option>
    <option value='22'>Destroy Enemy Lab</option>
    <option value='23'>Confiscate Bioweapons</option>
    <option value='24'>Destroy Power Centers</option>
    <option value='nan'>&bull;&bull;Tab 4 Missions&bull;&bull;</option>
    <option value='25'>Locate Submarines</option>
    <option value='26'>Set Mines in Ocean</option>
    <option value='27'>Secure Shoreline</option>
    <option value='28'>Protect Arriving Ships</option>
    <option value='29'>Level Enemy City</option>
    <option value='30'>Cut Off Enemy Oil Supply</option>
    <option value='31'>Air Raid</option>
    <option value='32'>Take out Supply Depots</option>
    <option value='nan'>&bull;&bull;Tab 5 Missions&bull;&bull;</option>
    <option value='33'>Gather Intelligence</option>
    <option value='34'>Deploy Ground Forces</option>
    <option value='35'>Surround Enemy Capital</option>
    <option value='36'>Send in Air Support</option>
    <option value='37'>Overcome Defense Forces</option>
    <option value='38'>Capture Key Infrastructure</option>
    <option value='39'>Cut Off Enemy Retreat</option>
    <option value='40'>Seize Enemy Capital</option>
    <option value='nan'>&bull;&bull;Tab 6 Missions&bull;&bull;</option>
    <option value='41'>Capture Enemy Fighters</option>
    <option value='42'>Locate Recon Centers</option>
    <option value='43'>Disrupt Communications</option>
    <option value='44'>Take out Base Patrols</option>
    <option value='45'>Perform Surprise Attack</option>
    <option value='46'>Capture Enemy Spies</option>
    <option value='47'>Locate Nuclear Silo</option>
    <option value='48'>Destroy Nuclear Facility</option>
    <option value='nan'>&bull;&bull;Tab 7 Missions&bull;&bull;</option>
    <option value='49'>Conquer Enemy Outpost</option>
    <option value='50'>Defend Position</option>
    <option value='51'>Set up Defensive Network</option>
    <option value='52'>Assemble Naval Fleet</option>
    <option value='53'>Attack Piracy Operation</option>
    <option value='54'>Conquer Costal Base</option>
    <option value='55'>Reinforce Ally Capital</option>
    <option value='56'>Force Enemy to Retreat</option>
    <option value='nan'>&bull;&bull;Tab 8 Missions&bull;&bull;</option>
    <option value='57'>Deploy Scout Planes</option>
    <option value='58'>Spread Fleet Position</option>
    <option value='59'>Launch Submarine Force</option>
    <option value='60'>Assault Enemy Fleet</option>
    <option value='61'>Repel Air Support</option>
    <option value='62'>Sink Enemys Flagship</option>
    <option value='63'>Scatter Enemys Fleet</option>
    <option value='64'>Reconvene Fleet</option>
    <option value='65'>Make Landfall</option>
    <option value='66'>Fortify Beachhead</option>
    <option value='67'>Storm Enemy Blockade</option>
    <option value='68'>Send Forces Inland</option>
    <option value='nan'>&bull;&bull;Tab 9 Missions&bull;&bull;</option>
    <option value='69'>Fortify Defensive Position</option>
    <option value='70'>Set-Up Operations Base</option>
    <option value='71'>Send Recon Choppers</option>
    <option value='72'>Identify Sniper Positions</option>
    <option value='73'>Employ Guerilla Tactics</option>
    <option value='74'>Prevent Enemy Ambush</option>
    <option value='75'>Deploy Defollant Planes</option>
    <option value='76'>Send in Heavy Artillery Customs Agent</option>
    <option value='77'>Sabotage Enemy Vehicles</option>
    <option value='78'>Demolish Enemy Base</option>
    <option value='79'>Take Military Prisoners</option>
    <option value='80'>Question Enemy Officer</option>
    <option value='nan'>&bull;&bull;Tab 10 Missions&bull;&bull;</option>
    <option value='81'>Collect Aerial Images</option>
    <option value='82'>Roll Out Infantry</option>
    <option value='83'>Flank Enemy Troops</option>
    <option value='84'>Disrupt Supply Lines</option>
    <option value='85'>Use Scorched Earth Policy</option>
    <option value='86'>Launch MRBMs from Sea</option>
    <option value='87'>Conduct Bombing Runs</option>
    <option value='88'>Engage in Aerial Combat</option>
    <option value='89'>Occupy Enemy City</option>
    <option value='90'>Establish Prisoner Camp</option>
    <option value='91'>Uncover Nuclear Program</option>
    <option value='92'>Destroy Research Facility</option>
    </select>";
    print "<style>
    input[type=\'text\']{
    color: #000000\;
    border-radius: 5px\;
    border: 1px solid black\;
    }
    </style><br><br>";
    print "<input id='submit' type='submit'  value='Glitch!'>";
    print "</FORM>\n";
    print "</CENTER>\n";
    
}

sub logger {
    my ($message) = @_;
    my $dbh = DBI->connect('DBI:mysql:shortlando:localhost', $username, $password)
    || die "Unable to connect to the database\n";
    my $sth = $dbh->prepare("INSERT INTO log(username,udid,pid,note) VALUES(?,?,?,?)");
    $sth->execute($real_username, $udid, $$, $message);
}

sub error {
    my ($message, $game) = @_;
    print "$message\n";
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
    my ($self, $sanctioninfo, $invinfo, $out) = @_;
    
$md5ww = Digest::MD5->new;
$md5ww->add($udid);
$md5ww->add(':' , 'pEarlhAbor156w' );
$pf = $md5ww->hexdigest;
$pf = uc($pf);
    
    if ($mission =~ /^(1)$/) {
        $cat = "1";
        $jid ="1";
    }
    if ($mission =~ /^(2)$/) {
        $cat = "1";
        $jid ="2";
    }
    if ($mission =~ /^(3)$/) {
        $cat = "1";
        $jid ="3";
    }
    if ($mission =~ /^(4)$/) {
        $cat = "1";
        $jid ="5";
    }
    if ($mission =~ /^(5)$/) {
        $cat = "1";
        $jid ="4";
    }
    if ($mission =~ /^(6)$/) {
        $cat = "1";
        $jid ="6";
    }
    if ($mission =~ /^(7)$/) {
        $cat = "1";
        $jid ="7";
    }
    if ($mission =~ /^(8)$/) {
        $cat = "1";
        $jid ="8";
    }
    ### tab 2
    if ($mission =~ /^(9)$/) {
        $cat = "2";
        $jid ="9";
    }
    if ($mission =~ /^(10)$/) {
        $cat = "2";
        $jid ="10";
    }
    if ($mission =~ /^(11)$/) {
        $cat = "2";
        $jid ="46";
    }
    if ($mission =~ /^(12)$/) {
        $cat = "2";
        $jid ="11";
    }
    if ($mission =~ /^(13)$/) {
        $cat = "2";
        $jid ="47";
    }
    if ($mission =~ /^(14)$/) {
        $cat = "2";
        $jid ="12";
    }
    if ($mission =~ /^(15)$/) {
        $cat = "2";
        $jid ="37";
    }
    if ($mission =~ /^(16)$/) {
        $cat = "2";
        $jid ="38";
    }
    ### tab 3
    if ($mission =~ /^(17)$/) {
        $cat = "3";
        $jid ="13";
    }
    if ($mission =~ /^(18)$/) {
        $cat = "3";
        $jid ="39";
    }
    if ($mission =~ /^(19)$/) {
        $cat = "3";
        $jid ="40";
    }
    if ($mission =~ /^(20)$/) {
        $cat = "3";
        $jid ="14";
    }
    if ($mission =~ /^(21)$/) {
        $cat = "3";
        $jid ="15";
    }
    if ($mission =~ /^(22)$/) {
        $cat = "3";
        $jid ="16";
    }
    if ($mission =~ /^(23)$/) {
        $cat = "3";
        $jid ="41";
    }
    if ($mission =~ /^(24)$/) {
        $cat = "3";
        $jid ="48";
    }
    ### tab 4
    if ($mission =~ /^(25)$/) {
        $cat = "4";
        $jid ="17";
    }
    if ($mission =~ /^(26)$/) {
        $cat = "4";
        $jid ="42";
    }
    if ($mission =~ /^(27)$/) {
        $cat = "4";
        $jid ="18";
    }
    if ($mission =~ /^(28)$/) {
        $cat = "4";
        $jid ="43";
    }
    if ($mission =~ /^(29)$/) {
        $cat = "4";
        $jid ="19";
    }
    if ($mission =~ /^(30)$/) {
        $cat = "4";
        $jid ="20";
    }
    if ($mission =~ /^(31)$/) {
        $cat = "4";
        $jid ="21";
    }
    if ($mission =~ /^(32)$/) {
        $cat = "4";
        $jid ="22";
    }
    if ($mission =~ /^(33)$/) {
        $cat = "5";
        $jid ="97";
    }
    if ($mission =~ /^(34)$/) {
        $cat = "5";
        $jid ="98";
    }
    if ($mission =~ /^(35)$/) {
        $cat = "5";
        $jid ="99";
    }
    if ($mission =~ /^(36)$/) {
        $cat = "5";
        $jid ="100";
    }
    if ($mission =~ /^(37)$/) {
        $cat = "5";
        $jid ="101";
    }
    if ($mission =~ /^(38)$/) {
        $cat = "5";
        $jid ="102";
    }
    if ($mission =~ /^(39)$/) {
        $cat = "5";
        $jid ="103";
    }
    if ($mission =~ /^(40)$/) {
        $cat = "5";
        $jid ="104";
    }
    ### tab 6
    if ($mission =~ /^(41)$/) {
        $cat = "6";
        $jid ="23";
    }
    if ($mission =~ /^(42)$/) {
        $cat = "6";
        $jid ="44";
    }
    if ($mission =~ /^(43)$/) {
        $cat = "6";
        $jid ="24";
    }
    if ($mission =~ /^(44)$/) {
        $cat = "6";
        $jid ="45";
    }
    if ($mission =~ /^(45)$/) {
        $cat = "6";
        $jid ="25";
    }
    if ($mission =~ /^(46)$/) {
        $cat = "6";
        $jid ="26";
    }
    if ($mission =~ /^(47)$/) {
        $cat = "6";
        $jid ="27";
    }
    if ($mission =~ /^(48)$/) {
        $cat = "6";
        $jid ="28";
    }
    ### tab 7
    if ($mission =~ /^(49)$/) {
        $cat = "7";
        $jid ="29";
    }
    if ($mission =~ /^(50)$/) {
        $cat = "7";
        $jid ="30";
    }
    if ($mission =~ /^(51)$/) {
        $cat = "7";
        $jid ="31";
    }
    if ($mission =~ /^(52)$/) {
        $cat = "7";
        $jid ="32";
    }
    if ($mission =~ /^(53)$/) {
        $cat = "7";
        $jid ="33";
    }
    if ($mission =~ /^(54)$/) {
        $cat = "7";
        $jid ="34";
    }
    if ($mission =~ /^(55)$/) {
        $cat = "7";
        $jid ="35";
    }
    if ($mission =~ /^(56)$/) {
        $cat = "7";
        $jid ="36";
    }
    ### tab 8
    if ($mission =~ /^(57)$/) {
        $cat = "8";
        $jid ="61";
    }
    if ($mission =~ /^(58)$/) {
        $cat = "8";
        $jid ="62";
    }
    if ($mission =~ /^(59)$/) {
        $cat = "8";
        $jid ="63";
    }
    if ($mission =~ /^(60)$/) {
        $cat = "8";
        $jid ="64";
    }
    if ($mission =~ /^(61)$/) {
        $cat = "8";
        $jid ="65";
    }
    if ($mission =~ /^(62)$/) {
        $cat = "8";
        $jid ="66";
    }
    if ($mission =~ /^(63)$/) {
        $cat = "8";
        $jid ="67";
    }
    if ($mission =~ /^(64)$/) {
        $cat = "8";
        $jid ="68";
    }
    if ($mission =~ /^(65)$/) {
        $cat = "8";
        $jid ="69";
    }
    if ($mission =~ /^(66)$/) {
        $cat = "8";
        $jid ="70";
    }
    if ($mission =~ /^(67)$/) {
        $cat = "8";
        $jid ="71";
    }
    if ($mission =~ /^(68)$/) {
        $cat = "8";
        $jid ="72";
    }
    ### tab 9
    if ($mission =~ /^(69)$/) {
        $cat = "9";
        $jid ="73";
    }
    if ($mission =~ /^(70)$/) {
        $cat = "9";
        $jid ="74";
    }
    if ($mission =~ /^(71)$/) {
        $cat = "9";
        $jid ="75";
    }
    if ($mission =~ /^(72)$/) {
        $cat = "9";
        $jid ="76";
    }
    if ($mission =~ /^(73)$/) {
        $cat = "9";
        $jid ="77";
    }
    if ($mission =~ /^(74)$/) {
        $cat = "9";
        $jid ="78";
    }
    if ($mission =~ /^(75)$/) {
        $cat = "9";
        $jid ="79";
    }
    if ($mission =~ /^(76)$/) {
        $cat = "9";
        $jid ="80";
    }
    if ($mission =~ /^(77)$/) {
        $cat = "9";
        $jid ="81";
    }
    if ($mission =~ /^(78)$/) {
        $cat = "9";
        $jid ="82";
    }
    if ($mission =~ /^(79)$/) {
        $cat = "9";
        $jid ="83";
    }
    if ($mission =~ /^(80)$/) {
        $cat = "9";
        $jid ="84";
    }
    ### tab 10
    if ($mission =~ /^(81)$/) {
        $cat = "10";
        $jid ="85";
    }
    if ($mission =~ /^(82)$/) {
        $cat = "10";
        $jid ="86";
    }
    if ($mission =~ /^(83)$/) {
        $cat = "10";
        $jid ="87";
    }
    if ($mission =~ /^(84)$/) {
        $cat = "10";
        $jid ="88";
    }
    if ($mission =~ /^(85)$/) {
        $cat = "10";
        $jid ="89";
    }
    if ($mission =~ /^(86)$/) {
        $cat = "10";
        $jid ="90";
    }
    if ($mission =~ /^(87)$/) {
        $cat = "10";
        $jid ="91";
    }
    if ($mission =~ /^(88)$/) {
        $cat = "10";
        $jid ="92";
    }
    if ($mission =~ /^(89)$/) {
        $cat = "10";
        $jid = "93";
    }
    if ($mission =~ /^(90)$/) {
        $cat = "10";
        $jid ="94";
    }
    if ($mission =~ /^(91)$/) {
        $cat = "10";
        $jid ="95";
    }
    if ($mission =~ /^(92)$/) {
        $cat = "10";
        $jid ="96";
    }
    
    my $CURL = "curl -s -b cookie/cookies_$udid -c cookie/cookies_$udid -L";
    my $baseurl = "http://wwar.storm8.com";
    my $url = "/missions.php?cat=$cat";
    `$CURL 'http://wwar.storm8.com/apoints.php?version=a1.56&udid=$udid&pf=$pf&model=Droid&sv=9A405'`;
    $out = `$CURL "${baseurl}${url}"`;
    
    my ($fsb, $arg) = ($out =~/missions\.php\?jid=$jid&cat=$cat&.*onclick=.*(fsb\d+)\('([^']+)'\);/);
    
    my ($js) = ($out =~ /function $fsb.*?{(.*?)}/ms);
    print "<!----JS Function: $js ---->";
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
    #   $action = $out->{url} . ($action =~ /^/ ? "" : "" ) . $action;
    
    $action = $self->{url} . ($action =~ /^\// ? "" : "/" ) . $action;
    #   $out = $self->{url} . ($out =~ /.\/\/\/\/\/\/\/\// ? "" : "" ) . $action;
    $action .= $arg;
    # not doing it, preparing only
    $out = "${baseurl}/${action}";
    $out =~ s/<!--//mg;
    $out =~ s/-->//mg;
    ## end constru
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
        select(undef,undef,undef,.050);
        my $start = sprintf("%i.%06i", gettimeofday());
        my $html = $self->request(
        "$action",
        "POST",
        "numberOfInv=1"
        );
        my $finish = sprintf("%i.%06i", gettimeofday());
        if ($HTML =~ /You looted/) {
            return "Loot: $1";
        }
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
        die "<center><div id='castle' style='background-color:white;border-radius:5px;padding-left:5px;padding-right:5px;border:2px black;'><h3><br>Possibly you don't have that mission unlocked yet. ( $id - $mission )<br><br></h3></div></center>\n";
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
    die "A valve seems to have failed. This is a critical error message, Please report it along with this: ERROR CODE 80410418 & 710102 \n" unless $resp->is_success;
    return $resp->content;
}

sub new {
    shift @_ if $_[0] eq "Storm8";
    my %game = @_;
    my $game = \%game;
    $game{ua} = new LWP::UserAgent;
    $game{ua}->cookie_jar({});
    $game{ua}->agent("Mozilla/5.0 (Linux; U; Android 2.2; en-us; Nexus One Build/FRF91) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1");
    push @{ $game{ua}->requests_redirectable }, 'POST';
    my $dbh = DBI->connect('DBI:mysql:shortlando:localhost', $username, $password)
    || die "Unable to connect to the database\n";
    my $sth = $dbh->prepare("SELECT cookie FROM accs WHERE udid = ? AND game = ? AND valid = 1");
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

$md5ww = Digest::MD5->new;
$md5ww->add($udid);
$md5ww->add(':' , 'pEarlhAbor156w' );
$pf = $md5ww->hexdigest;
$pf = uc($pf);

$htmz = qq{
<style>

#text {
color: #000000;
width: 200px;
height: 22px;
border-radius: 5px;
border: 1px solid black;
}

#dps {
-webkit-appearance: none;
-moz-appearance: none;
width: 200px;
height: 22px;
border: 1px solid black;
border-radius: 5px;
color: #000000;
background-color:white;
}

#submit {
color: #000000;
width: 100px;
height: 22px;
cursor: pointer;
border-radius: 5px;
background-color: #ffffff;
border: 1px solid black;
}
#submit:hover, #submit:active {
color: green;
}

* { padding: 0; margin: 0; outline: 0; }

</style>};
print $htmz;

$html_template = qq{<!DOCTYPE html>
    <html>
    
    <head>
    <meta name="viewport" content="user-scalable=no, width=device-width" />
    <meta http-equiv="content-type" content="application/xhtml+xml; charset=UTF-8" />
	</head>

<br><img src="images/home.png" value="Done" onclick="home()" form="" height="45" width="20%" /><img src="images/missions.png" value="Done" onclick="missions()" form="" height="45" width="20%" /><img src="images/fight.png" value="Done" onclick="attack()" form="" height="45" width="20%" /><img src="images/equipment.png" value="Done" onclick="equip()" form="" height="45" width="20%" /><img src="images/group.png" value="Done" onclick="recruit()" form="" height="45" width="20%" /><div id="frame"></div>
    
<body onload="login()"></script>

<script type="text/javascript">
function login()
{
document.getElementById('frame').innerHTML = '<iframe src="http://wwar.storm8.com/apoints.php?version=a1.56&udid=$udid&pf=$pf&model=Droid&sv=9A405" width="100%" height="550" style="background-color:black;" frameBorder="0"></iframe>';
}

function home()
{
document.getElementById('frame').innerHTML = '<iframe src="http://wwar.storm8.com/home.php" width="100%" height="550" style="background-color:black;" frameBorder="0"></iframe>';
}

function missions()
{
document.getElementById('frame').innerHTML = '<iframe src="http://wwar.storm8.com/missions.php" width="100%" height="550" style="background-color:black;" frameBorder="0"></iframe>';
}

function attack()
{
document.getElementById('frame').innerHTML = '<iframe src="http://wwar.storm8.com/fight.php" width="100%" height="550" style="background-color:black;" frameBorder="0"></iframe>';
}

function equip()
{
document.getElementById('frame').innerHTML = '<iframe src="http://wwar.storm8.com/equipment.php" width="100%" height="550" style="background-color:black;" frameBorder="0"></iframe>';
}

function recruit()
{
document.getElementById('frame').innerHTML = '<iframe src="http://wwar.storm8.com/group.php" width="100%" height="550" style="background-color:black;" frameBorder="0"></iframe>';
}

function heal()
{
document.getElementById('heal').innerHTML = '<iframe src="http://wwar.storm8.com/hospital.php?action=heal" width="0" height="0" style="background-color:black;" frameBorder="0"></iframe>';
}

function profile()
{
document.getElementById('frame').innerHTML = '<iframe src="http://wwar.storm8.com/profile.php" width="100%" height="550" style="background-color:black;" frameBorder="0"></iframe>';
}
</script>


<div id="heal"> </div>
    
    
    
    
    
    </body>
    </html>
};


print $html_template;