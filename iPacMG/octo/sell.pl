#!/usr/bin/perl

use CGI;
#use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
use File::Temp qw(tempfile);
use HTTP::Cookies;
use LWP::UserAgent;
use MIME::Base64;

#my $cgi; my $build; my $amount; my $udid; my $game; my $device; my $htmz; my $css; my $real_username; my $udid_; my $device_; my $game_; my $valid;

BEGIN{
    $cgi = new CGI;
    $build = $cgi->param("build");
    $amount = $cgi->param("amount");
    $id = $cgi->param("id");
    
sub input_cleaner {
($replace) = @_;
$replace =~ s/'//g; $replace =~ s/"//g; $replace =~ s/\%//g; $replace =~ s/\*//g; $replace =~ s/\+//g; $replace =~ s/\.//g; $replace =~ s/\,//g; $replace =~ s/\(//g; $replace =~ s/\)//g; $replace =~ s/\~//g; $replace =~ s/\///g; $replace =~ s/\\//g;
return "$replace"; 
}
$id = input_cleaner($id);
    
if(defined $blank){
} else {
    print $cgi->header(-type=>'text/html', -charset => 'UTF-8');
}
open(STDERR, ">&STDOUT");
}

print qq{

<style>
    \@import url(http://fonts.googleapis.com/css?family=Lato);
    *{
        -webkit-appearance: none;
        -moz-appearance: none;
        font-family: 'Lato', sans-serif !important;
    }
#text {
color: #333;
width: 200px;
height: 22px;
border-radius: 5px;
border: 1px solid black;
}
#dps {
-webkit-appearance: none;
-moz-appearance: none;
width: 200;
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
border-radius: 5px;
background-color: #ffffff;
border: 1px solid #000000;
}
#submit:hover{
border-radius: 5px;
background-color: #ffffff;
border: 1px solid #006600;
color:#66FF33;
}
</style>

};
require "../cookie_login.pl";

if(!defined $build){
    use DBI;
    use DBI();
    my $dbh = DBI->connect("DBI:mysql:database=shortlando;host=localhost",
    "shortland", "password!",
    {'RaiseError' => 1});
    
    my $sth = $dbh->prepare("SELECT udid, game, device FROM accs WHERE username = ? AND ID = ?");
    $sth->execute($real_username, $id) or die "Couldn't execute statement: $DBI::errstr; stopped";
    while ( my ($udid_, $game_, $device_) = $sth->fetchrow_array() ) {
        $udid = $udid_;
        $game = $game_;
        $device = $device_;
        $valid = "true";
    }
    
    if($valid !~ "true"){
        print "NOT TRUE";
        #die "ERR\n";
    }
    
    #print $real_username;
    
    my $sth2 = $dbh->prepare("SELECT bg, form FROM style WHERE user = ?");
    $sth2->execute($real_username) or die "Couldn't execute statement: $DBI::errstr; stopped";
    while ( my ($bg_, $form_) = $sth2->fetchrow_array() ) {
    print "
    <style>
    body {
    background-color: \#$bg_;
    }
    form {
    border: 1px solid black;
    background: \#$form_;
    border-radius:5px;
    padding: 10px;
    }
    
    </style>
    ";
    }
    
    $dbh->disconnect();
    
    print qq{<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>};
    print "<form name='seller'>";
    if ($game =~ /^(wwar)$/) {
            print "Building Type: <br>
            <select id='dps' name=\"build\">
            <option value=\"1\">Supply Depot</option>
            <option value=\"2\">Bunker</option>
            <option value=\"3\">Refinery</option>
            <option value=\"4\">Barracks</option>
            <option value=\"5\">Guard Tower</option>
            <option value=\"6\">Weapons Factory</option>
            <option value=\"7\">Anti Aircraft Launcher</option>
            <option value=\"8\">Power Plant</option>
            <option value=\"9\">Turret</option>
            <option value=\"10\">Air Field</option>
            <option value=\"11\">LandMine Field</option>
            <option value=\"12\">Oil Rig</option>
            <option value=\"13\">Communications Center</option>
            <option value=\"14\">Military Research Lab</option>
            <option value=\"15\">Nuclear Testing Facility</option>
            <option value=\"16\"></option>
            <option value=\"17\">Solar Satellite Network</option>
            <option value=\"18\">Automatic Sentry Guns</option>
            <option value=\"19\"></option>
            <option value=\"20\">Fusion Reactor</option>
            <option value=\"21\">Costal Cannons</option>
            </select><br><br>
            ";}
            
            if ($game =~ /^(im)$/) {
                print "Building Type: <BR><select id='dps' name=\"build\">
                <option value=\"1\">Street Vendor</option>
                <option value=\"2\">Shack</option>
                <option value=\"3\">Convenience Store</option>
                <option value=\"4\">Restaurant</option>
                <option value=\"5\">Night Club</option>
                <option value=\"6\">Luxury Condos</option>
                <option value=\"7\">Shopping Mall</option>
                <option value=\"8\">Resort Hotel</option>
                <option value=\"9\">Office Tower</option>
                <option value=\"10\">Casino</option>
                <option value=\"11\">Amusement Park</option>
                <option value=\"12\">Horse Racing Circuit</option>
                <option value=\"13\">Professional Basketball Team</option>
                <option value=\"14\">Television Studio</option>
                <option value=\"15\">Auction House</option>
                <option value=\"16\">Record Label</option>
                </select><br><br>
                ";
            }
            if ($game =~ /^(rl)$/) {
                print "Building Type: <BR><select id='dps' name=\"build\">
                <option value=\"1\">Parking Space</option>
                <option value=\"2\">Used Car Lot</option>
                <option value=\"12\">Discount Brand Gas Station</option>
                <option value=\"3\">Convenience Store</option>
                <option value=\"4\">Condo</option>
                <option value=\"5\">Car Wash Service</option>
                <option value=\"13\">Premium Brand Gas</option>
                <option value=\"6\">Parking Garage</option>
                <option value=\"7\">Fuel Storage Silos</option>
                <option value=\"14\">Chop Shop</option>
                <option value=\"9\">Automotive Electronics Store</option>
                <option value=\"10\">Beach House</option>
                <option value=\"11\">Import Car Dealership</option>
                <option value=\"15\">Custom Mod Shop</option>
                <option value=\"16\">Luxury Car Showroom</option>
                </select><br><br>
                ";
            }
            
            if ($game =~ /^(vl)$/) {
                print "Building Type: <BR><select id='dps' name=\"build\">
                <option value=\"1\">Stray Dog</option>
                <option value=\"2\">Wolf</option>
                <option value=\"3\">Human</option>
                <option value=\"4\">Police</option>
                <option value=\"5\">Hunter</option>
                <option value=\"6\">Cultist</option>
                <option value=\"7\">Zombie</option>
                <option value=\"8\">Gargoyle</option>
                <option value=\"9\">Demon</option>
                <option value=\"10\">Werewolf</option>
                <option value=\"11\">Vampire</option>
                <option value=\"12\">Grave Digger</option>
                <option value=\"13\">Flesh Hungry Beast</option>
                <option value=\"14\">Ankou</option>
                </select><br><br>
                ";
            }
            if ($game =~ /^(zl)$/) {
                print "Building Type: <BR><select id='dps' name=\"build\">
                <option value=\"10001\">Human Disguise</option>
                <option value=\"10002\">Falling Cage</option>
                <option value=\"10003\">Collapsing Manhole</option>
                <option value=\"10004\">Graveyard Trap</option>
                <option value=\"10005\">Dark Room</option>
                <option value=\"10006\">Hijacked Taxi Cab</option>
                <option value=\"11017\">Solarium</option>
                <option value=\"10007\">Fake Door</option>
                <option value=\"10008\">Park Sinkhole</option>
                <option value=\"10009\">Fake Office</option>
                <option value=\"10010\">Collapsing Walls</option>
                <option value=\"10011\">Hijacked Bus</option>
                <option value=\"11011\">Fake Hospital</option>
                <option value=\"11017\">Barricaded Church</option>
                <option value=\"10012\">Collapsing Building</option>
                </select><br><br>
                ";
            }
            print "Amount:<br><input id='text' type='tel' name='amount'/><br><br>";
            
            print "<button id='submit' type='button' onClick='sell()' >Sell!</button>";
            print "<span id='result' style='color:red;'></span>";
            print "</form>";
            
            print qq{
            <div id='sell_field' style='display:none !important;'></div>
            
            <script>
            function sell() {
		\$.ajax({
                   url  : 'sell.pl',
                   type : 'POST',
                   data : 'build=' + document.seller.dps.value + '&amount=' + document.seller.text.value + '&id=$id',
                   cache: false
                   })
                   
                   document.seller.text.value = "0";
                   document.getElementById("result").innerHTML = "<BR><BR>Selling has begun, it may take awhile to complete. You may leave this section while selling occurs.<BR><BR>";
            }
            </script>
            
            
            };
            
}
if(defined $build){

require "../cookie_login.pl";

    use DBI;
    use DBI();
    my $dbh = DBI->connect("DBI:mysql:database=shortlando;host=localhost",
    "shortland", "password!",
    {'RaiseError' => 1});
    
    my $sth = $dbh->prepare("SELECT udid, game, device, pf FROM accs WHERE username = ? AND ID = ?");
    $sth->execute($real_username, $id) or die "Couldn't execute statement: $DBI::errstr; stopped";
    while ( my ($udid_, $game_, $device_, $pf_) = $sth->fetchrow_array() ) {
        $udid = $udid_;
        $game = $game_;
        $device = $device_;
        $pf = $pf_;
        $valid = "true";

    }
    
    if($valid !~ "true"){
        print "NOT TRUE";
        die "ERR\n";
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


my $ua = new LWP::UserAgent;
$ua->cookie_jar({});
use Data::Dumper;
$ua->get("http://$game.storm8.com/$end=$pf");
my $cookie = encode_base64($ua->cookie_jar->as_string);

$out;
$CURL = "curl -s -b cookiez/cookie_$udid -c cookiez/cookie_$udid -L";
$baseurl = "http://$game.storm8.com";
$url = "\/investment.php\?action=sell&inv_id=$build";
 `$CURL "http://$game.storm8.com/$end=$pf"`;
for $j (0 .. 600000){}
$now = `$CURL "http://$game.storm8.com/home.php"`;

for $i (1 .. $amount){
    for $j (0 .. 600000){}
    $out = `${CURL} "${baseurl}${url}"`;
}
($cash) = ($out =~ /cashCurrent[^>]*>([^<]+)/);
#print "Cash is now $cash \n";
($casha) = ($now =~ /cashCurrent[^>]*>([^<]+)/);

}


