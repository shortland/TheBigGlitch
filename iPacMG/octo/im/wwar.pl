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
    $gameprefix = "im";
    $game = "im";
    
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
                print "<h3>We've gotten something shiney!</h3>\n";
            } else {
                print "<div id='castle' style='background-color:white;border-radius:5px;padding-left:5px;padding-right:5px;border:2px black;'><br><center><h3> " . ($ret =~ /Success/ ? " It appears the glitch was successful.<br> (if mission wasnt done, check if you have the required equipment)<br> " : " It appears the glitch was not successful.<br> ") . "<br></div></center></h3><br/>\n";
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
    # print "<div id='castle' style='background-color:white;border-radius:5px;padding-left:5px;padding-right:5px;border:2px black;'><h3><br>For the time being, please do not use deathchasers over 45,000 deaths, as it's been shown to cause some issues.<br></br></h3></div><BR><BR>";
    
    #print "<div id='castle' style='background-color:white;border-radius:5px;padding-left:5px;padding-right:5px;border:2px black;'><h3><br>Old delay conversion to new delay: example; (.01 = 1) (.20 = 20)<br></br></h3></div>";
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
    <option value='1'>Shoplifting</option>
    <option value='2'>Street Mugging</option>
    <option value='3'>Breaking and Entering</option>
    <option value='4'>Grand Theft Auto</option>
    <option value='5'>Liquor Store Robbery</option>
    <option value='6'>Start Protection Racket</option>
    <option value='7'>Museum Heist</option>
    <option value='8'>Electronic Store Robbery</option>
    <option value='nan'>&bull;&bull;Tab 2 Missions&bull;&bull;</option>
    <option value='9'>Liquor Smuggling</option>
    <option value='10'>Prison Break</option>
    <option value='11'>Jewelry Store Robbery</option>
    <option value='12'>Infiltrate Mob Base</option>
    <option value='13'>Knock off Mob Member</option>
    <option value='14'>Bank Robbery</option>
    <option value='15'>Hide Illegal Goods</option>
    <option value='16'>Take Out Snitch</option>
    <option value='nan'>&bull;&bull;Tab 3 Missions&bull;&bull;</option>
    <option value='17'>Steal Weapons From Mob</option>
    <option value='18'>Sell Arms Underground</option>
    <option value='19'>Extorst Local Businesses</option>
    <option value='20'>Burn Police Station</option>
    <option value='21'>Plant Evidence on Mob</option>
    <option value='22'>Bribe Police</option>
    <option value='23'>Manufacture Fake Money</option>
    <option value='24'>Bomb Mobs Shipment</option>
    <option value='nan'>&bull;&bull;Tab 4 Missions&bull;&bull;</option>
    <option value='25'>Hi-Jack a Bank Truck</option>
    <option value='26'>Bribe Judge to Drop Case</option>
    <option value='27'>Take Out Prosecutor</option>
    <option value='28'>Protect Godfather</option>
    <option value='29'>Survive Bloody Shootout</option>
    <option value='30'>Destroy Weapon Supply</option>
    <option value='31'>Bootlegging Racket</option>
    <option value='32'>Take Out FBI Squad</option>
    <option value='nan'>&bull;&bull;Tab 5 Missions&bull;&bull;</option>
    <option value='33'>Burn Down Casino</option>
    <option value='34'>Drive Mob off your Turf</option>
    <option value='35'>Expand Yur Influence</option>
    <option value='36'>Eliminate Harbor Security</option>
    <option value='37'>Escape FBI Lockdown</option>
    <option value='38'>Rig City Election</option>
    <option value='39'>Destroy Shipment Trucks</option>
    <option value='nan'>&bull;&bull;Tab 6 Missions&bull;&bull;</option>
    <option value='40'>Blow up Archives</option>
    <option value='41'>Import Illegal Goods</option>
    <option value='42'>Hide Imports from FBI</option>
    <option value='43'>Drive out Russian Mob</option>
    <option value='44'>Bribe ATF Agents</option>
    <option value='45'>Blow Up Rival Mob HQ</option>
    <option value='46'>Eliminate Enemy Don</option>
    <option value='nan'>&bull;&bull;Tab 7 Missions&bull;&bull;</option>
    <option value='47'>Sell Counterfeit Goods</option>
    <option value='48'>Takeover Escort Service</option>
    <option value='49'>Confront Local Crimelord</option>
    <option value='50'>Hide Bodies in Desert</option>
    <option value='51'>Rig Boxing Match</option>
    <option value='52'>Burn Down Dance Club</option>
    <option value='53'>Ally with Hotel Magnate</option>
    <option value='54'>Bribe Zoning Committee</option>
    <option value='55'>Sabotage Rivals Casino</option>
    <option value='56'>Fix Games in Your Favor</option>
    <option value='57'>Launder Gambling Money</option>
    <option value='58'>Doublecross Partner</option>
    <option value='nan'>&bull;&bull;Tab 8 Missions&bull;&bull;</option>
    <option value='59'>Recruit Local Muscle</option>
    <option value='60'>Distribute Bottleg Movies</option>
    <option value='61'>Sell Fake Passports</option>
    <option value='62'>Run Off Local Gangs</option>
    <option value='63'>Rough-Up Untruly Star</option>
    <option value='64'>Extort Nightclub Owner</option>
    <option value='65'>Arrange Sporting Victory</option>
    <option value='66'>Blackmail Famous Actor</option>
    <option value='67'>Threaten Studio Execs</option>
    <option value='68'>Takeover Movie Studio</option>
    <option value='69'>Demolish Rival Studio</option>
    <option value='70'>Produce Awarded Drama</option>
    <option value='nan'>&bull;&bull;Tab 9 Missions&bull;&bull;</option>
    <option value='71'>Recruit Crooked Cops</option>
    <option value='72'>Ransack Village</option>
    <option value='73'>Ransome Tourists</option>
    <option value='74'>Intercept Money Transfer</option>
    <option value='75'>Cultivate Local Crops</option>
    <option value='76'>Bribe Customs Agent</option>
    <option value='77'>Ship Goods to Hollywood</option>
    <option value='78'>Ally With Insurgents</option>
    <option value='79'>Blackmail Corrupt Politico</option>
    <option value='80'>Raise Water Prices</option>
    <option value='81'>Setup Smuggling Cartel</option>
    
    <option value='82'>Support Political Group</option>
    </select>";
    print "<style>
#submit {
width: 80px;
height:30px;
border: 1px solid black;
color: black;
background-color: white;
border-radius: 5px;
}
    input[type=\'text\']{
    color: #333\;
    width: 200px\;
    height: 22px\;
    padding-left: 1px\;
    padding-right: 1px\;
    transition: box-shadow 320ms\;
    box-shadow: 0px 0px 8px 10px rgba(0,0,0,0.1)\;
    border-radius: 2px\;
    font-size: 15px\;
    border: 0px\;
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
    $md5ww->add(':' , 'pr3m1umWat3r154i:12' );
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
        $jid ="4";
    }
    if ($mission =~ /^(5)$/) {
        $cat = "1";
        $jid ="5";
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
        $jid ="11";
    }
    if ($mission =~ /^(12)$/) {
        $cat = "2";
        $jid ="12";
    }
    if ($mission =~ /^(13)$/) {
        $cat = "2";
        $jid ="17";
    }
    if ($mission =~ /^(14)$/) {
        $cat = "2";
        $jid ="13";
    }
    if ($mission =~ /^(15)$/) {
        $cat = "2";
        $jid ="25";
    }
    if ($mission =~ /^(16)$/) {
        $cat = "2";
        $jid ="14";
    }
    if ($mission =~ /^(17)$/) {
        $cat = "3";
        $jid ="15";
    }
    if ($mission =~ /^(18)$/) {
        $cat = "3";
        $jid ="26";
    }
    if ($mission =~ /^(19)$/) {
        $cat = "3";
        $jid ="27";
    }
    if ($mission =~ /^(20)$/) {
        $cat = "3";
        $jid ="16";
    }
    if ($mission =~ /^(21)$/) {
        $cat = "3";
        $jid ="28";
    }
    if ($mission =~ /^(22)$/) {
        $cat = "3";
        $jid ="29";
    }
    if ($mission =~ /^(23)$/) {
        $cat = "3";
        $jid ="18";
    }
    if ($mission =~ /^(24)$/) {
        $cat = "3";
        $jid ="19";
    }
    if ($mission =~ /^(25)$/) {
        $cat = "4";
        $jid ="20";
    }
    if ($mission =~ /^(26)$/) {
        $cat = "4";
        $jid ="33";
    }
    if ($mission =~ /^(27)$/) {
        $cat = "4";
        $jid ="21";
    }
    if ($mission =~ /^(28)$/) {
        $cat = "4";
        $jid ="22";
    }
    if ($mission =~ /^(29)$/) {
        $cat = "4";
        $jid ="35";
    }
    if ($mission =~ /^(30)$/) {
        $cat = "4";
        $jid ="23";
    }
    if ($mission =~ /^(31)$/) {
        $cat = "4";
        $jid ="24";
    }
    if ($mission =~ /^(32)$/) {
        $cat = "4";
        $jid ="30";
    }
    if ($mission =~ /^(33)$/) {
        $cat = "5";
        $jid ="31";
    }
    if ($mission =~ /^(34)$/) {
        $cat = "5";
        $jid ="32";
    }
    if ($mission =~ /^(35)$/) {
        $cat = "5";
        $jid ="41";
    }
    if ($mission =~ /^(36)$/) {
        $cat = "5";
        $jid ="42";
    }
    if ($mission =~ /^(37)$/) {
        $cat = "5";
        $jid ="34";
    }
    if ($mission =~ /^(38)$/) {
        $cat = "5";
        $jid ="44";
    }
    if ($mission =~ /^(39)$/) {
        $cat = "5";
        $jid ="47";
    }
    if ($mission =~ /^(40)$/) {
        $cat = "6";
        $jid ="48";
    }
    if ($mission =~ /^(41)$/) {
        $cat = "6";
        $jid ="38";
    }
    if ($mission =~ /^(42)$/) {
        $cat = "6";
        $jid ="50";
    }
    if ($mission =~ /^(43)$/) {
        $cat = "6";
        $jid ="51";
    }
    if ($mission =~ /^(44)$/) {
        $cat = "6";
        $jid ="40";
    }
    if ($mission =~ /^(45)$/) {
        $cat = "6";
        $jid ="53";
    }
    if ($mission =~ /^(46)$/) {
        $cat = "6";
        $jid ="56";
    }
    if ($mission =~ /^(47)$/) {
        $cat = "7";
        $jid ="61";
    }
    if ($mission =~ /^(48)$/) {
        $cat = "7";
        $jid ="62";
    }
    if ($mission =~ /^(49)$/) {
        $cat = "7";
        $jid ="63";
    }
    if ($mission =~ /^(50)$/) {
        $cat = "7";
        $jid ="64";
    }
    if ($mission =~ /^(51)$/) {
        $cat = "7";
        $jid ="65";
    }
    if ($mission =~ /^(52)$/) {
        $cat = "7";
        $jid ="66";
    }
    if ($mission =~ /^(53)$/) {
        $cat = "7";
        $jid ="67";
    }
    if ($mission =~ /^(54)$/) {
        $cat = "7";
        $jid ="68";
    }
    if ($mission =~ /^(55)$/) {
        $cat = "7";
        $jid ="69";
    }
    if ($mission =~ /^(56)$/) {
        $cat = "7";
        $jid ="70";
    }
    if ($mission =~ /^(57)$/) {
        $cat = "7";
        $jid ="71";
    }
    if ($mission =~ /^(58)$/) {
        $cat = "7";
        $jid ="72";
    }
    if ($mission =~ /^(59)$/) {
        $cat = "8";
        $jid ="73";
    }
    if ($mission =~ /^(60)$/) {
        $cat = "8";
        $jid ="74";
    }
    if ($mission =~ /^(61)$/) {
        $cat = "8";
        $jid ="75";
    }
    if ($mission =~ /^(62)$/) {
        $cat = "8";
        $jid ="76";
    }
    if ($mission =~ /^(63)$/) {
        $cat = "8";
        $jid ="77";
    }
    if ($mission =~ /^(64)$/) {
        $cat = "8";
        $jid ="78";
    }
    if ($mission =~ /^(65)$/) {
        $cat = "8";
        $jid ="79";
    }
    if ($mission =~ /^(66)$/) {
        $cat = "8";
        $jid ="80";
    }
    if ($mission =~ /^(67)$/) {
        $cat = "8";
        $jid ="81";
    }
    if ($mission =~ /^(68)$/) {
        $cat = "8";
        $jid ="82";
    }
    if ($mission =~ /^(69)$/) {
        $cat = "8";
        $jid ="83";
    }
    if ($mission =~ /^(70)$/) {
        $cat = "8";
        $jid ="84";
    }
    if ($mission =~ /^(71)$/) {
        $cat = "9";
        $jid ="85";
    }
    if ($mission =~ /^(72)$/) {
        $cat = "9";
        $jid ="86";
    }
    if ($mission =~ /^(73)$/) {
        $cat = "9";
        $jid ="87";
    }
    if ($mission =~ /^(74)$/) {
        $cat = "9";
        $jid ="88";
    }
    if ($mission =~ /^(75)$/) {
        $cat = "9";
        $jid ="89";
    }
    if ($mission =~ /^(76)$/) {
        $cat = "9";
        $jid ="90";
    }
    if ($mission =~ /^(77)$/) {
        $cat = "9";
        $jid ="91";
    }
    if ($mission =~ /^(78)$/) {
        $cat = "9";
        $jid ="92";
    }
    if ($mission =~ /^(79)$/) {
        $cat = "9";
        $jid ="93";
    }
    if ($mission =~ /^(80)$/) {
        $cat = "9";
        $jid ="94";
    }
    if ($mission =~ /^(81)$/) {
        $cat = "9";
        $jid ="95";
    }
    if ($mission =~ /^(82)$/) {
        $cat = "9";
        $jid ="96";
    }
    
    my $CURL = "curl -s -b cookie/cookies_$udid -c cookie/cookies_$udid -L";
    my $baseurl = "http://im.storm8.com";
    my $url = "/missions.php?cat=$cat";
    `$CURL 'http://im.storm8.com/apoints.php?fpts=12&version=a1.54&udid=$udid&pf=$pf&model=Droid&sv=2.2'`;
    $out = `$CURL "${baseurl}${url}"`;
    
    my ($fsb, $arg) = ($out =~/missions\.php\?jid=$jid&cat=$cat&.*onclick=.*(fsb\d+)\('([^']+)'\);/);
    
    my ($js) = ($out =~ /function $fsb.*?{(.*?)}/ms);
    print "<!----JS Function: $js ---->";
    my @vals = split ',', $1 if $js =~ /b=new Array\(([\d,]+)\)/;
    my @use = split ',', $1 if $js =~ /p=new Array\(([\d,]+)\)/;
    die "Error: unable to fetch correct ee and usage meter: STORM8
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
$md5ww->add(':' , 'pr3m1umWat3r154i:12' );
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
    


# wtf, I dont remember writting this LOL...
#one upon a time I enjoyed the wild wild west idk 18007672121 is the phone number to call me at its wliw21 support hot line, they can assist you their, although will plead for a pledge of at least $25 before giving away a complimentary give away. Then they will say thank you, and continue to broadcast bullshit crapy shit on their tv station.

$html_template = qq{<!DOCTYPE html>
    <html>
    
    <head>
    <meta name="viewport" content="user-scalable=no, width=device-width" />
    <meta http-equiv="content-type" content="application/xhtml+xml; charset=UTF-8" />
    </head>
    
    
    <br><img src="images/home.png" value="Done" onclick="home()" form="" height="45" width="20%" /><img src="images/missions.png" value="Done" onclick="missions()" form="" height="45" width="20%" /><img src="images/fight.png" value="Done" onclick="attack()" form="" height="45" width="20%" /><img src="images/equipment.png" value="Done" onclick="equip()" form="" height="45" width="20%" /><img src="images/group.png" value="Done" onclick="recruit()" form="" height="45" width="20%" /><div id="frame"></div> 
    
    <body onload="login()">
    
    <script>
    function login()
    {
        document.getElementById('frame').innerHTML = '<iframe src="http://im.storm8.com/apoints.php?fpts=12&version=a1.54&udid=$udid&pf=$pf&model=Droid&sv=2.2" width="100%" height="550" style="background-color:black;" frameBorder="0"></iframe>';
setTimeout(home, 1000);
    }

    function home()
    {
        document.getElementById('frame').innerHTML = '<iframe src="http://im.storm8.com/home.php" width="100%" height="550" style="background-color:black;" frameBorder="0"></iframe>';
    }

    function missions()
    {
        document.getElementById('frame').innerHTML = '<iframe src="http://im.storm8.com/missions.php" width="100%" height="550" style="background-color:black;" frameBorder="0"></iframe>';
    }

    function attack()
    {
        document.getElementById('frame').innerHTML = '<iframe src="http://im.storm8.com/fight.php" width="100%" height="550" style="background-color:black;" frameBorder="0"></iframe>';
    }

    function equip()
    {
        document.getElementById('frame').innerHTML = '<iframe src="http://im.storm8.com/equipment.php" width="100%" height="550" style="background-color:black;" frameBorder="0"></iframe>';
    }

    function recruit()
    {
        document.getElementById('frame').innerHTML = '<iframe src="http://im.storm8.com/group.php" width="100%" height="550" style="background-color:black;" frameBorder="0"></iframe>';
    }

    function heal()
    {
        document.getElementById('heal').innerHTML = '<iframe src="http://im.storm8.com/hospital.php?action=heal" width="0" height="0" style="background-color:black;" frameBorder="0"></iframe>';
    }
 
    function profile()
    {
        document.getElementById('frame').innerHTML = '<iframe src="http://im.storm8.com/profile.php" width="100%" height="550" style="background-color:black;" frameBorder="0"></iframe>';
    }
    </script>
    
    
    <div id="heal"></div>
    
    
    
 
    
    </body>
    </html>
};


print $html_template;

