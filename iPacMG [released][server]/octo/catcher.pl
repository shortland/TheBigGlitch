#!/usr/bin/perl

#cookie is gotten here, and inserted here, no bs php middleman.
#no printing in the page, header is @ bottom of page, would cause error.

use DBI;
use CGI;
use Digest::MD5;
use File::Temp qw(tempfile);
use HTTP::Cookies;
use LWP::UserAgent;
use MIME::Base64;


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
my $name;
BEGIN{
    $cgi = new CGI;
    $id = $cgi->param("id");
    $url = $cgi->param("url");
    
    ##
    $sent_u_cookie = $cgi->param("u_cookie");
    $sent_p_cookie = $cgi->param("p_cookie");
    if(!defined $id){
        print $cgi->header(-type=>'text/html', -status=>'403 Forbidden');
        exit;
    } else {
        
    }
    open(STDERR, ">&STDOUT");
}


require "../cookie_login.pl";



sub input_cleaner {
($replace) = @_;
$replace =~ s/'//g; $replace =~ s/"//g; $replace =~ s/\%//g; $replace =~ s/\*//g; $replace =~ s/\+//g; $replace =~ s/\.//g; $replace =~ s/\,//g; $replace =~ s/\(//g; $replace =~ s/\)//g; $replace =~ s/\~//g; $replace =~ s/\///g; $replace =~ s/\\//g;
return "$replace"; 
}

if (($id =~ /('|"|\%|\*|\+|\.|\,|\(|\)|\~|\/|\\)/) || (!defined $id)){
print $cgi->header(-type=>'text/html', -status=>'403 Forbidden');
open(my $fh, '>>', 'catcher_reports.txt');
print $fh "
>>>>>>>>>>\n
ID  ERROR\n $ENV{HTTP_USER_AGENT}\n $ENV{HTTP_REFERER}\n $ENV{QUERY_STRING}\n $ENV{REMOTE_ADDR}\n $udid\n $atomy\n $game\n $delay\n $device\n $name\n $gotping\n $atom\n $gameprefix\n
>>>>>>>>>>\n\n";
close $fh;
$id = input_cleaner($id);
}
#'"


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
$dbh->disconnect();
if($valid !~ "true"){
print $cgi->header(-type=>'text/html', -status=>'403 Forbidden');
print "ERR\n";
}

#############################;'
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

$ua = new LWP::UserAgent;
$ua->cookie_jar({});
use Data::Dumper;
$ua->get("http://$game.storm8.com/$end=$pf");
$cookie = encode_base64($ua->cookie_jar->as_string);

my $dbh = DBI->connect("DBI:mysql:database=shortlando;host=localhost",
"shortland", "password!",
{'RaiseError' => 1});

my $sth = $dbh->prepare("UPDATE accs SET cookie = ?, pf = ? WHERE username = ? AND ID = ?");
$sth->execute($cookie, $pf, $real_username, $id) or die "Couldn't execute statement: $DBI::errstr; stopped";
$dbh->disconnect();
# $url = 

if(!defined $url) {
$urlz = "tool.pl?id=$id"; # normal glitcher
}
if($url =~ "loot"){
if($game =~ "im"){
$urlz = "im/wwar.pl?id=$id"; # im loot glitcher
}
if($game =~ "wwar"){
$urlz = "wwar/wwar.pl?id=$id"; # wwar loot glitcher
}
}
if($url =~ "gamer"){
$urlz = "../../gamer.pl?id=$id&u_cookie=$sent_u_cookie&p_cookie=$sent_p_cookie"; # gamer
}

print $cgi->header(-location=>$urlz,-type=>'text/html', -charset => 'UTF-8');