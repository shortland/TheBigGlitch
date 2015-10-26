#!/usr/bin/perl

## This page checks to see if a user is logged in.
## If they are not logged in, they are presented with a login form.
## simply: include 'cookie_login.pl';
## Nothing more is necessary.
## This page is meant to run SQL Queries as-well. (since it's cookie protected)
## For example, two variables are already set: "$real_username" and "$real_email"
## So any page that has this page "included" can use $real_username and get the user's username... Ect…
## Go ahead and set more variables by fetching more stuff from DB

use CGI;
use MIME::Base64;
use DBI();
use DBI;
use CGI::Cookie;
use HTTP::Cookies;

BEGIN{
    $q = new CGI;
    {   $method = $q->param("method");
        if($method =~ "set"){
                $read_u_cookie = $q->param("u_cookie");
                $read_p_cookie = $q->param("p_cookie");
                $u_cookie = new CGI::Cookie(-name=>'u_cookie',-value=>$read_u_cookie,-path=>'/');
            	$p_cookie = new CGI::Cookie(-name=>'p_cookie',-value=>$read_p_cookie,-path=>'/');
                $url = "cookie_login.pl";
                print $q->header(-Location=>$url,-cookie=>[$u_cookie, $p_cookie],-type=>'text/html', -charset => 'UTF-8');
                
        } else {
#print $q->header(-type=>'text/html', -charset => 'UTF-8');
        }
    }
    open(STDERR, ">&STDOUT");
}

$method = $q->param("method");

%cookies = CGI::Cookie->fetch;
$got_u_cookie = $cookies{'u_cookie'}->value;
$got_p_cookie = $cookies{'p_cookie'}->value;


if(!defined $got_u_cookie && !defined $got_p_cookie){
print "<form action='n_login.php' method='post'>\n";
print "Username: <input type='text' name='username'/><br>\n";
print "Password: <input type='password' name='password'/><br>\n";
print "<input type='hidden' name='method' value='login'/>\n";
print "<input type='submit' value='Login'/><br>\n";
print "</form>\n";
exit;
}
$uc_safe =~ s/'//g;
$uc_safe =~ s/"//g; # php version adds slashes, perl removes the ', " in all.
$pc_safe =~ s/'//g;
$pc_safe =~ s/"//g;

# $dbh, & $sth have _random123164 extension bc/ they seem to trail into other files...

my $dbh_random123164 = DBI->connect("DBI:mysql:database=shortlando;host=localhost",
"shortland", "password!",
{'RaiseError' => 1});

my $sth_random123164 = $dbh_random123164->prepare("SELECT u_cookie, p_cookie, username, email, valid FROM users WHERE u_cookie = ? AND p_cookie = ?");
$sth_random123164->execute($got_u_cookie, $got_p_cookie) or die "Couldn't execute statement: $DBI::errstr; stopped";

while ( my ($u_cookie, $p_cookie, $username, $email, $user_valid) = $sth_random123164->fetchrow_array() ) {
  $real_username = decode_base64($username);
  $real_email = $email;
  $real_access = $user_valid;
  $valid = "ok";
}
$dbh_random123164->disconnect();

if (!defined $valid){
# Invalid, old, currupt cookies
# Force user to login again.
# print "error is in validation";
print "<script>window.location.href='n_login.php';</script>";
print "<form action='n_login.php' method='post'>\n";
print "Username: <input type='text' name='username'/><br>\n";
print "Password: <input type='password' name='password'/><br>\n";
print "<input type='hidden' name='method' value='login'/>\n";
print "<input type='submit' value='Login'/><br>\n";
print "</form>\n";
exit;
}

1;