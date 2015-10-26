#!/usr/bin/perlml

my $username;
my $accname;
my $udid;
my $ip;
my $game;
my $pcode;
my $name;


use v5.10;
use Digest::MD5;
use CGI;
use File::Temp qw(tempfile);
use HTTP::Cookies;
use LWP::UserAgent;
use MIME::Base64;



BEGIN{
    $cgi = new CGI;
    $flag = $cgi->param("flag");
    
    $ip = $cgi->param("ip");
    $pcode = $cgi->param("pcode");
    
    $name = $cgi->param("name");
    $tom = defined $cgi->param("tom") ? $cgi->param("tom") : "2";
    $gameprefix = defined $cgi->param("game") ? $cgi->param("game") : "im";
    if(!defined $name){
        print $cgi->header(-type=>'text/html', -status=>'403 Forbidden');
        
        
        exit;
    } else {
        print $cgi->header(-type=>'text/html', -charset => 'UTF-8');
    }
    open(STDERR, ">&STDOUT");
}
require "../cookie_login.pl";
$username = $real_username;
########UPDATES########
#first creation
##added funky loops to make a account do mission lots #
### added salt capabilities;get salt from udid
####random udid generator 
#####Udid logger to file
###### curl buy equipment 
#######stupid comments everywhere
########curl attack... (Not working)
#########Gawd damn peter this is a really 'smart' rest. LOL I kinda just realized it... 
#########so nasty.... looping nothing 600,000 times xD damn thats pretty cool idea lol


print "<title>iPac-IM 6</title>";

###no reason to require $name Param at first
###just need this page to default at begin block

###done beginner

$game = "im";
###start ugh the fugh

###Our very ugly nasty script to
###### create a new account 
###### Automission that account up to level 6
###### writes udid to udid.txt for safe keeping
# Includes 
# mission script
# attack gen skinner script
# buy equipment scrip
# LOTS of ugly ugly looping involved
# By Ilan K. & Peter M.
# 2013 All Rights kinda reserved lol.

###Begin open

###tom defines amount of times to run the entire script. 
## eg. $Tom = 6
## then 6 accounts will be made and run through this script
####MASTA LOOPA OP OVERLORD


if ($name =~ /^(shortland|Shortland|short|shortl4nd|Short|ipac|IPAC|iPac|Ipac)$/) {
    print "<br><br><br><br><br><br><h3>Sorry, Those Usernames are not allowed :P</h3>";
    exit 0;
}


$tim = "1";

   for my $i (1 .. $tim){
{

@set = ('0' ..'9', 'A' .. 'Z');
$udid = join '' => map $set[rand @set], 1 .. 16;

### $udid made from rand string gen
### new udid for each run through
$md5ww = Digest::MD5->new;
$md5ww->add($udid);
$md5ww->add(':' , 'pr3m1umWat3r154i:12' );
$pf = $md5ww->hexdigest;
$pf = uc($pf);
 
#








my $out;
my $CURL = "curl -s -b cookies/cookie_$udid -c cookies/cookie_$udid -L";
my $baseurl = "http://im.storm8.com";
my $url = "/missions.php?cat=1";
my $urlz = "/fight.php";
my $urll = "/choose_name.php?ref=%2Ffight.php&strings=story&hideTabBar=true";

#print "$CURL 'http://wwar.storm8.com/apoints.php?version=a1.56&udid=$udid&pf=$pf&model=Droid&sv=9A405f'";
   `$CURL 'http://im.storm8.com/apoints.php?fpts=12&version=a1.54&udid=$udid&pf=$pf'`;
   $out = `$CURL "${baseurl}${url}"`;
   for my $j (0 .. 600000){}

    `$CURL 'http://im.storm8.com/missions.php'`;
    $out = `$CURL "${baseurl}${url}"`;
####For Loop...


   for my $i (1 .. 37){
   for my $j (0 .. 600000){}
##DATA FOR MISSIONS##Need top curl-out##
   my ($fsb, $arg) = ($out =~/\/missions\.php\?jid=1&cat=1&.*onclick=.*(fsb\d+)\('([^']+)'\);/);
  ## print "FSB: $fsb, Arg: $arg\n";
   #print "Loading... Done message will appear when completed.";
   my ($js) = ($out =~ /function $fsb.*?{(.*?)}/ms);
#   print "<!----JS Function: $js ---->";
   my @vals = split ',', $1 if $js =~ /b=new Array\(([\d,]+)\)/;
   my @use = split ',', $1 if $js =~ /p=new Array\(([\d,]+)\)/;
   die "This site needs to be updated to handle new countermeasures
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
   $out = `$CURL "${baseurl}${action}"`;
   #`$action`;
   #print "$out ==-== $action ";
}

`$CURL 'http://im.storm8.com/fight.php'`;

`$CURL 'http://im.storm8.com/choose_name.php?ref=%2Ffight.php&strings=story&hideTabBar=true'`;

`$CURL 'http://im.storm8.com/choose_name.php?ref=%2Ffight.php&name=$name&action=Choose+This+Name'`;

`$CURL 'http://im.storm8.com/choose_name.php?ref=%2Ffight.php&name=Bob&action=Choose+This+Name'`;

`$CURL 'http://im.storm8.com/choose_class.php?class=1&uid=33130208&action=Choose+This+Class'`;

`$CURL 'http://im.storm8.com/register2.php?setUserClass=1&promote=&hideTabBar=true'`;

`$CURL 'http://im.storm8.com/register2.php?promote=&action=Continue'`;

`$CURL 'http://im.storm8.com/equipment.php'`;

`$CURL "http://im.storm8.com/equipment.php?action=buy&iid=3&cat=1"`;

`$CURL 'http://im.storm8.com/missions.php'`;

   for my $i (1 .. 5){
   for my $j (0 .. 600000){}
##DATA FOR MISSIONS##Need top curl-out##
   my ($fsb, $arg) = ($out =~/\/missions\.php\?jid=3&cat=1&.*onclick=.*(fsb\d+)\('([^']+)'\);/);
  ## print "FSB: $fsb, Arg: $arg\n";
   #print "Loading... Done message will appear when completed.";
   my ($js) = ($out =~ /function $fsb.*?{(.*?)}/ms);
#   print "<!----JS Function: $js ---->";
   my @vals = split ',', $1 if $js =~ /b=new Array\(([\d,]+)\)/;
   my @use = split ',', $1 if $js =~ /p=new Array\(([\d,]+)\)/;
   die "This site needs to be updated to handle new countermeasures
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
   $out = `$CURL "${baseurl}${action}"`;
   #`$action`;
   #print "$out ==-== $action ";
}


# Buy Revolver
`$CURL 'http://im.storm8.com/equipment.php'`;

`$CURL "http://im.storm8.com/equipment.php?action=buy&iid=6&cat=1"`;

`$CURL "http://im.storm8.com/equipment.php?action=buy&iid=100&cat=3"`;



   for my $i (1 .. 2){
   for my $j (0 .. 600000){}
##DATA FOR MISSIONS##Need top curl-out##
   my ($fsb, $arg) = ($out =~/\/missions\.php\?jid=8&cat=1&.*onclick=.*(fsb\d+)\('([^']+)'\);/);
  ## print "FSB: $fsb, Arg: $arg\n";
   #print "Loading... Done message will appear when completed.";
   my ($js) = ($out =~ /function $fsb.*?{(.*?)}/ms);
#   print "<!----JS Function: $js ---->";
   my @vals = split ',', $1 if $js =~ /b=new Array\(([\d,]+)\)/;
   my @use = split ',', $1 if $js =~ /p=new Array\(([\d,]+)\)/;
   die "This site needs to be updated to handle new countermeasures
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
   $out = `$CURL "${baseurl}${action}"`;
   #`$action`;
   #print "$out ==-== $action ";
}

`$CURL "http://im.storm8.com/fight.php"`;

{
    $outz = `$CURL "${baseurl}${urlz}"`;
    
for my $i (1 .. 4){
   for my $j (0 .. 600000){}
##DATA FOR MISSIONS##Need top curl-out##
   my ($fsb, $arg) = ($outz =~/\/fight\.php\?action=fight&rivalId=0&pos=1&.*onclick=.*(fsb0)\('([^']+)'\);/);
  ## print "FSB: $fsb, Arg: $arg\n";
#   print "<BR>";
   my ($js) = ($outz =~ /function $fsb.*?{(.*?)}/ms);
#   print "<!----JS Function: $js ---->";
   my @vals = split ',', $1 if $js =~ /b=new Array\(([\d,]+)\)/;
   my @use = split ',', $1 if $js =~ /p=new Array\(([\d,]+)\)/;
   die "This site needs to be updated to handle new countermeasures
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
   $out = `$CURL "${baseurl}${action}"`;
   #`$action`;
   #print "$out ==-== $action ";
}
}

}
}

use DBI;
use strict;
use DBI();
my $dbh = DBI->connect("DBI:mysql:database=shortlando;host=localhost",
                         "shortland", "password!",
                         {'RaiseError' => 1});


  $dbh->do("INSERT INTO  storage (username, name, udid, ip, game, pcode) VALUES ('$username', '$name', '$udid', '$ip', '$game', '$pcode')");
  $dbh->disconnect();


print "<FORM>";
print "<BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><H3>";
print "<style>
input[type=\'text\']{

    color: #333;
    width: 80%;
    height: 20px;
    left: 50%;
    top: 50%;
    padding-left: 1px;
    padding-right: 1px;

    transition: box-shadow 320ms;

    box-shadow: 0px 0px 8px 10px rgba(0,0,0,0.1);

    border-radius: 2px;
    font-size: 15px;
    border: 0px;
}

input[type=\'text\']:focus {

    outline: 0px;
    outline-offset: 0px;
    box-shadow: 0px 0px 1px 5px rgba(0,0,0,0.12);
}

input:-moz-placeholder {
    color: #000000;
}
</style>";
print "<link rel=\"stylesheet\" type=\"text/css\" media=\"screen\" href=\"images/css.css\" />";
print "<br>";
print "<h3>UDID:</h3> <input type=\'text\' id=\'resizer\' value=\"$udid\"name=\"name\"placeholder='udid'>";
print "<BR><BR><BR><BR><BR><BR><BR><BR><BR><BR></H3></form";


print "<meta name=\"apple-mobile-web-app-capable\" content=\"yes\">
<meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\">
<link rel=\"stylesheet\" type=\"text/css\" media=\"screen\" href=\"css.css\" />
<meta name=\"viewport\" content=\"width=device-width\, initial-scale=\.9\, user-scalable=no\"/>";

