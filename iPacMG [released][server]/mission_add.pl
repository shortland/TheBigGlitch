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
$method = $cgi->param("method");
$udid = $cgi->param("udid");
$game = $cgi->param("game");
$data = $cgi->param("data");
print $cgi->header(-type=>'text/html', -status=>'200 Forbidden');
require "cookie_login.pl";

my $dbh = DBI->connect("DBI:mysql:database=shortlando;host=localhost",
			 "shortlando", "password!",
			 {'RaiseError' => 1});
if($method =~ "1") {
my $sth = $dbh->prepare(<<End_SQL) or die "Couldn't prepare statement: $DBI::errstr; stopped";
INSERT INTO auto (username, udid, game) VALUES ('$real_username', '$udid', '$game');
End_SQL
$sth->execute() or die "Couldn't execute statement: $DBI::errstr; stopped";
#print "Added Account $udid for $real_username";
}