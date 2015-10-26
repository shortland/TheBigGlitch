#!/usr/bin/perlml


### we get a cookie here, then we move to inserter to place cookie into db
###### inserter is cookie protected (php) this is perl, not protected, just gets a cookie.
use DBI;
use CGI;
use v5.10;
use Digest::MD5;
use CGI;
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
    $udid = $cgi->param("udid");
    $name = $cgi->param("name");
        $username = $cgi->param("username");
        
    $game = "im";
    if(!defined $udid){
	print $cgi->header(-type=>'text/html', -status=>'403 Forbidden');
	print "<h1>Type in your account UDID to login.</h1>";
		print "<form name=\"input\" method=\"post\" action=\"tooly.pl\">";
		print "UDID: <input type=\"text\" name=\"udid\" placeholder=\" UDID\">";
	print "<div id=\"hidden\" style=\"display:none\;\">";
	print "<input type=\"text\" name=\"name\" value=\"$name\">";
	print "Name:  <input type=\"text\" name=\"username\" value=\"$username\">";
	print "</div>";
	print " <input type=\"image\" src=\"images/start.png\" HEIGHT=\"20\" WIDTH=\"40\" BORDER=\"0\" >";
		print "</form>";
	exit;
    } else {
	print $cgi->header(-type=>'text/html', -charset => 'UTF-8');
    }
    open(STDERR, ">&STDOUT");
}

##input udid
### get PF
$md5ww = Digest::MD5->new;
$md5ww->add($udid);
$md5ww->add(':' , 'pr3m1umWat3r154i:12' );
$pf = $md5ww->hexdigest;
$pf = uc($pf);


##input udid and pf
### get cookie



my $ua = new LWP::UserAgent;
$ua->cookie_jar({});
use Data::Dumper;
$ua->get("http://im.storm8.com/apoints.php?fpts=12&version=a1.54&udid=$udid&pf=$pf&model=Droid&sv=2.2");
my $cookie = encode_base64($ua->cookie_jar->as_string);




	print "<form name=\"input\" method=\"post\" action=\"regi.php\">";
	
		    print "<div id=\"registeruser\" style=\"display:none\;\">";
			print "UDID: <input type=\"text\" name=\"udid\" value=\"$udid\">";
		print "Cookie: <input type=\"text\" name=\"cookie\" value=\"$cookie\">";
					
			print "UAS:  <input type=\"text\" name=\"uas\" value=\"$ENV{HTTP_USER_AGENT}\">";
			print "IP:  <input type=\"text\" name=\"ip\" value=\"$ENV{REMOTE_ADDR}\">";
			print "Game:  <input type=\"text\" name=\"game\" value=\"$game\">";
		print "Name:  <input type=\"text\" name=\"name\" value=\"$name\">";
				print "Name:  <input type=\"text\" name=\"username\" value=\"$username\">";
			print "H-Cookie:  <input type=\"text\" name=\"hcookie\" value=\"$ENV{HTTP_COOKIE}\">";
			print "<input type=\"submit\" value=\"Go\">";
			
		print "</div>";
		
		print "</form>";


   print "
    <script type=\"text/javascript\">
    {
	document.forms[0].submit();
    }
    </script> ";
   