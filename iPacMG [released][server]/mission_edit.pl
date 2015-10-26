#!/usr/bin/perl

use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
use CGI;
use v5.10;
use Digest::MD5;
use File::Temp qw(tempfile);
use HTTP::Cookies;
use LWP::UserAgent;
use MIME::Base64;
use DBI;
use DBI();

$cgi = new CGI;
$mission = $cgi->param("mission");
$time = $cgi->param("time");
$batch = $cgi->param("batch");
$udid = $cgi->param("udid");
$game = $cgi->param("game");

sub input_cleaner {
($replace) = @_;
$replace =~ s/'//g; $replace =~ s/"//g; $replace =~ s/\%//g; $replace =~ s/\*//g; $replace =~ s/\+//g; $replace =~ s/\.//g; $replace =~ s/\,//g; $replace =~ s/\(//g; $replace =~ s/\)//g; $replace =~ s/\~//g; $replace =~ s/\///g; $replace =~ s/\\//g;
return "$replace"; 
}
$mission = input_cleaner($mission);
$time = input_cleaner($time);
$batch = input_cleaner($batch);
$udid = input_cleaner($udid);
$game = input_cleaner($game);



if($game =~ /^(wwar)$/){

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

}
if($game =~ /^(im)$/){

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

}

print $cgi->header(-type=>'text/html', -status=>'200');
require "cookie_login.pl";

my $dbh = DBI->connect("DBI:mysql:database=shortlando;host=localhost",
			 "shortlando", "password!",
			 {'RaiseError' => 1});

if($udid =~ /^()$/){ #probs a batch

my $sth = $dbh->prepare(<<End_SQL) or die "Couldn't prepare statement: $DBI::errstr; stopped";
UPDATE auto SET mission = ?, time = ?, jid = ?, cat = ? WHERE batch = ? AND username = ?
End_SQL
$sth->execute($mission, $time, $jid, $cat, $batch, $real_username) or die "Couldn't execute statement: $DBI::errstr; stopped";

exit;
}

else {
if($batch =~ /^()$/){$batch = "NOT-A-BATCH";};
my $sth = $dbh->prepare(<<End_SQL) or die "Couldn't prepare statement: $DBI::errstr; stopped";
UPDATE auto SET mission = ?, time = ?, batch = ?, jid = ?, cat = ? WHERE udid = ? AND username = ? LIMIT 1;
End_SQL
$sth->execute($mission, $time, $batch, $jid, $cat, $udid, $real_username) or die "Couldn't execute statement: $DBI::errstr; stopped";
print "acc";
}










