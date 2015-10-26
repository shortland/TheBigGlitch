#!/usr/bin/perl

#use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
use CGI;
use v5.10;
use Digest::MD5;
use File::Temp qw(tempfile);
use HTTP::Cookies;
use LWP::UserAgent;
use MIME::Base64;
use DBI;
use DBI();
use Time::HiRes qw(gettimeofday);



$cgi = new CGI;
$data = $cgi->param("data");
$act = $cgi->param("act");
print $cgi->header(-type=>'text/html', -status=>'403 Forbidden');
require "cookie_login.pl";
$valid = $real_access;
#$real_username;

my $dbh = DBI->connect("DBI:mysql:database=shortlando;host=localhost",
			 "shortlando", "password!",
			 {'RaiseError' => 1});
my $sth = $dbh->prepare(<<End_SQL) or die "Couldn't prepare statement: $DBI::errstr; stopped";
select bg, form FROM style WHERE user = '$real_username'
End_SQL
$sth->execute() or die "Couldn't execute statement: $DBI::errstr; stopped";
while ( my ($bg, $form) = $sth->fetchrow_array() ){
print qq{
<script src="http://code.jquery.com/jquery-2.1.1.min.js"></script>
<style>
\@import url(http://fonts.googleapis.com/css?family=Lato);
*{
    -webkit-appearance: none;
    -moz-appearance: none;
    font-family: 'Lato', sans-serif !important;
}
body {
background-color: \#$bg;
}
form {
border: 1px solid black;
margin: 10px;
padding: 10px;
background: \#$form;
border-radius:5px;
}
</style>};
}
print "<center>";
if ($valid =~ /^(1)$/) {
print "<form>
<br>It appears you don't have permission here!<br> You can purchase Auto Mission on our website: <br><b>www.iPacMG.com</b><br> Features of Auto-Mission:<br> - Fully Automated Missions<br> - No limits on amount of accounts.<br> - Shut-down, Power-off, Turn off your internet, and Auto Mission will continue to run! (No need to run it in the background!).<br><br> Note: Supports Both WorldWar and iMobsters<br> Best of all, it's only \$30, single time payment.  <br>
</form>";
exit;
}
if ($valid !~ /^(2)$/) {
exit;
} # eh, that works lol.


if($act =~ /^(so)$/){
$shown = qq{
<br><br><span style='color:red;'>Account added, please edit it, and add a mission for it to do.</span>
};
}

print qq{
<style>
#spc, #spc2 {
display: none;
}
textarea {
width: 90%;
height: 300px;
border: 1px solid black;
border-radius: 5px;
background-color: white;
resize: none;
font-size: 12px;
}
.text {
width: 200px;
height: 22px;
border: 1px solid black;
border-radius:5px;
font-weight: bold;
}
#submit {
width: 100px;
height: 22px;
border: 1px solid black;
color: black;
background-color: white;
border-radius: 5px;
}
#submit:hover, #submit:active {
border: 1px solid white;
color: white;
background-color: black;
}
.dps { 
	-webkit-appearance: none;
	-moz-appearance: none;
	width: 200px;
	height: 22px;
	line-height: 1;
	border: 1px solid black;
	border-radius: 5px;
	color: #000000;
        background-color:white;  
}
</style>

<script type='text/javascript'>
function single() {
\$("#spc").fadeToggle("slow");
}
function bulk() {
\$("#spc2").fadeToggle("slow");
}

function make_account() {
\$.ajax({
                   url  : 'mission_add.pl',
                   type : 'POST',
                   data : 'game=' + document.getElementById("game_add").value + '&udid=' + document.getElementById("udid_add").value + '&method=1',
                   cache: false
                   }).done(function(){
window.location.href = 'missions.pl?act=so';
                           });

                   
}
function view_running() {
\$("#running").fadeToggle("slow");
}

</script>



<form>
<p>Add Accounts in:</p>
<button type='button' id='submit' onClick='single()'>Single-Add</button>
<br><br>
<div>Coming Soon</div>
<button type='button' id='submit' onClick='bulky()'>Bulk-Add</button>
<br><br><br>
<button type='button' id='submit' onClick='view_running()'>View Running</button>
$shown
<br><br>
</form>


<form id='spc' name='solo'>
    <p>UDID: (Spaces in the udid can mess it up!)</p>
    <input type="text" class='text' name="udid" id='udid_add' /><br/>
    <p>Game:</p>
    <SELECT name='game' id='game_add' class='dps'>
	  <OPTION value='wwar'>&nbsp;&nbsp;&nbsp;&nbsp; WorldWar </OPTION>
	  <OPTION value='im'>&nbsp;&nbsp;&nbsp;&nbsp; iMobsters </OPTION>
    </SELECT>
    <br><span id='response'></span><br>
    <button id='submit' type='button' onClick='make_account()'>Add Account</button> 
</form>


<form method='post' id='spc2'>
<p>Import Accounts (S8Dev Format)</p>
<textarea name='data'>name ### game ### device ### udid</textarea>
</form>
};


print qq{
<form>
<p>Server Status: <span style='color:green;'>ONLINE</p><p style='color:green;'>Automissions is currently online.</p></span>
</form>
};



print "<span id='running' style='display:none;'>";

my $dbh = DBI->connect("DBI:mysql:database=shortlando;host=localhost",
			 "shortlando", "password!",
			 {'RaiseError' => 1});
my $sth0 = $dbh->prepare(<<End_SQL) or die "Couldn't prepare statement: $DBI::errstr; stopped";
SELECT batch FROM auto WHERE username = '$real_username' GROUP BY batch;
End_SQL
$sth0->execute() or die "Couldn't execute statement: $DBI::errstr; stopped";
while ( my ($batch_names) = $sth0->fetchrow_array() ){
if($batch_names =~ /^(NOT-A-BATCH)$/)
{
# do nada
}
else 
{
push(@batches, $batch_names);
}
}

my $sth1 = $dbh->prepare(<<End_SQL) or die "Couldn't prepare statement: $DBI::errstr; stopped";
SELECT batch FROM auto WHERE username = '$real_username' GROUP BY batch;
End_SQL
$sth1->execute() or die "Couldn't execute statement: $DBI::errstr; stopped";
while ( my ($batch) = $sth1->fetchrow_array() ){

if($batch =~ "NOT-A-BATCH")
{

my $sth2 = $dbh->prepare(<<End_SQL) or die "Couldn't prepare statement: $DBI::errstr; stopped";
SELECT mission, game, udid, time, last_exec FROM auto WHERE batch = '$batch' AND username = '$real_username'
End_SQL
$sth2->execute() or die "Couldn't execute statement: $DBI::errstr; stopped";
while ( my ($mission, $game, $udid, $time, $last_exec) = $sth2->fetchrow_array() ){

$last_exec_m = $last_exec / 60;
$current_time = gettimeofday();
$current_time_m = $current_time / 60;
$next_time = $last_exec_m + $time;
$next_run_s = $next_time - $current_time_m;
$next_run =  sprintf "%.2f", $next_run_s; # minutes is result.
$time_list = qq{
	<select name='time' id='time_$udid' class='dps'>
<option value='5'>5 Minutes</option>
<option value='10'>10 Minutes</option>
<option value='15'>15 Minutes</option>
<option value='20'>20 Minutes</option>
<option value='25'>25 Minutes</option>
<option value='30'>30 Minutes</option>
<option value='45'>45 Minutes</option>
<option value='60'>60 Minutes</option>
<option value='120'>120 Minutes (2H)</option>
<option value='180'>180 Minutes (3H)</option>
<option value='240'>240 Minutes (4H)</option>
<option value='300'>300 Minutes (5H)</option>
<option value='420'>420 Minutes (7H)</option>
	</select>
};
if($game =~ /^(im)$/)
{
$missions_list = qq{<select name='mission' id='mission_$udid' class='dps'>
<option value='nan'>&bull;&bull;Tab 1 Missions&bull;&bull;</option>
<option value='1'>#1 Shoplifting</option>
<option value='2'>#2 Street Mugging</option>
<option value='3'>#3 Breaking and Entering</option>
<option value='4'>#4 Grand Theft Auto</option>
<option value='5'>#5 Liquor Store Robbery</option>
<option value='6'>#6 Start Protection Racket</option>
<option value='7'>#7 Museum Heist</option>
<option value='8'>#8 Electronic Store Robbery</option>
<option value='nan'> &bull;&bull;Tab 2 Missions&bull;&bull;</option>
<option value='9'>#9 Liquor Smuggling</option>
<option value='10'>#10 Prison Break</option>
<option value='11'>#11 Jewelry Store Robbery</option>
<option value='12'>#12 Infiltrate Mob Base</option>
<option value='13'>#13 Knock off Mob Member</option>
<option value='14'>#14 Bank Robbery</option>
<option value='15'>#15 Hide Illegal Goods</option>
<option value='16'>#16 Take Out Snitch</option>
<option value='nan'> &bull;&bull;Tab 3 Missions&bull;&bull;</option>
<option value='17'>#17 Steal Weapons From Mob</option>
<option value='18'>#18 Sell Arms Underground</option>
<option value='19'>#19 Extorst Local Businesses</option>
<option value='20'>#20 Burn Police Station</option>
<option value='21'>#21 Plant Evidence on Mob</option>
<option value='22'>#22 Bribe Police</option>
<option value='23'>#23 Manufacture Fake Money</option>
<option value='24'>#24 Bomb Mob's Shipment</option>
<option value='nan'> &bull;&bull;Tab 4 Missions&bull;&bull;</option>
<option value='25'>#25 Hi-Jack a Bank Truck</option>
<option value='26'>#26 Bribe Judge to Drop Case</option>
<option value='27'>#27 Take Out Prosecutor</option>
<option value='28'>#28 Protect Godfather</option>
<option value='29'>#29 Survive Bloody Shootout</option>
<option value='30'>#30 Destroy Weapon Supply</option>
<option value='31'>#31 Bootlegging Racket</option>
<option value='32'>#32 Take Out FBI Squad</option>
<option value='nan'>&bull;&bull;Tab 5 Missions&bull;&bull;</option>
<option value='33'>#33 Burn Down Casino</option>
<option value='34'>#34 Drive Mob off your Turf</option>
<option value='35'>#35 Expand Yur Influence</option>
<option value='36'>#36 Eliminate Harbor Security</option>
<option value='37'>#37 Escape FBI Lockdown</option>
<option value='38'>#38 Rig City Election</option>
<option value='39'>#39 Destroy Shipment Trucks</option>
<option value='nan'>&bull;&bull;Tab 6 Missions&bull;&bull;</option>
<option value='40'>#40 Blow up Archives</option>
<option value='41'>#41 Import Illegal Goods</option>
<option value='42'>#42 Hide Imports from FBI</option>
<option value='43'>#43 Drive out Russian Mob</option>
<option value='44'>#44 Bribe ATF Agents</option>
<option value='45'>#45 Blow Up Rival Mob HQ</option>
<option value='46'>#46 Eliminate Enemy Don</option>
<option value='nan'>&bull;&bull;Tab 7 Missions&bull;&bull;</option>
<option value='47'>#47 Sell Counterfeit Goods</option>
<option value='48'>#48 Takeover Escort Service</option>
<option value='49'>#49 Confront Local Crimelord</option>
<option value='50'>#50 Hide Bodies in Desert</option>
<option value='51'>#51 Rig Boxing Match</option>
<option value='52'>#52 Burn Down Dance Club</option>
<option value='53'>#53 Ally with Hotel Magnate</option>
<option value='54'>#54 Bribe Zoning Committee</option>
<option value='55'>#55 Sabotage Rivals Casino</option>
<option value='56'>#56 Fix Games in Your Favor</option>
<option value='57'>#57 Launder Gambling Money</option>
<option value='58'>#58 Doublecross Partner</option>
<option value='nan'>&bull;&bull;Tab 8 Missions&bull;&bull;</option>
<option value='59'>#59 Recruit Local Muscle</option>
<option value='60'>#60 Distribute Bottleg Movies</option>
<option value='61'>#61 Sell Fake Passports</option>
<option value='62'>#62 Run Off Local Gangs</option>
<option value='63'>#63 Rough-Up Untruly Star</option>
<option value='64'>#64 Extort Nightclub Owner</option>
<option value='65'>#65 Arrange Sporting Victory</option>
<option value='66'>#66 Blackmail Famous Actor</option>
<option value='67'>#67 Threaten Studio Execs</option>
<option value='68'>#68 Takeover Movie Studio</option>
<option value='69'>#69 Demolish Rival Studio</option>
<option value='70'>#70 Produce Awarded Drama</option>
<option value='nan'>&bull;&bull;Tab 9 Missions&bull;&bull;</option>
<option value='71'>#71 Recruit Crooked Cops</option>
<option value='72'>#72 Ransack Village</option>
<option value='73'>#73 Ransome Tourists</option>
<option value='74'>#74 Intercept Money Transfer</option>
<option value='75'>#75 Cultivate Local Crops</option>
<option value='76'>#76 Bribe Customs Agent</option>
<option value='77'>#77 Ship Goods to Hollywood</option>
<option value='78'>#78 Ally With Insurgents</option>
<option value='79'>#79 Blackmail Corrupt Politico</option>
<option value='80'>#80 Raise Water Prices</option>
<option value='81'>#81 Setup Smuggling Cartel</option>
<option value='82'>#82 Support Political Group</option>
	</select>};
}
if($game =~ /^(wwar)$/)
{
$missions_list = qq{<select name='mission' id='mission_$udid' class='dps'> 
<option value='nan'>&bull;&bull;Tab 1 Missions&bull;&bull;</option>
<option value='1'>#1 Fend off Enemy Attack</option>
<option value='2'>#2 Hunt Down Enemies</option>
<option value='3'>#3 Train Armed Forces</option>
<option value='4'>#4 Seize Enemy</option>
<option value='5'>#5 Locate Enemy Camp</option>
<option value='6'>#6 Establish Base Defense</option>
<option value='7'>#7 Destroy Enemy Base</option>
<option value='8'>#8 Invade Enemy Territory</option>
<option value='nan'>&bull;&bull;Tab 2 Missions&bull;&bull;</option>
<option value='9'>#9 Set up Military Camp</option>
<option value='10'>#10 Scout Out Enemy</option>
<option value='11'>#11 Sink Enemy Boats</option>
<option value='12'>#12 Intercept Shipment</option>
<option value='13'>#13 Ship Supplies to Troops</option>
<option value='14'>#14 Shoot Down Aircraft</option>
<option value='15'>#15 Investigate Wreckage</option>
<option value='16'>#16 Prepare Army to March</option>
<option value='nan'>&bull;&bull;Tab 3 Missions&bull;&bull;</option>
<option value='17'>#17 Infiltrate Western Border</option>
<option value='18'>#18 Take out Western Forces</option>
<option value='19'>#19 Discover Reinforcements</option>
<option value='20'>#20 Repel Counterattack</option>
<option value='21'>#21 Bombard Enemy Defenses</option>
<option value='22'>#22 Destroy Enemy Lab</option>
<option value='23'>#23 Confiscate Bioweapons</option>
<option value='24'>#24 Destroy Power Centers</option>
<option value='nan'>&bull;&bull;Tab 4 Missions&bull;&bull;</option>
<option value='25'>#25 Locate Submarines</option>
<option value='26'>#26 Set Mines in Ocean</option>
<option value='27'>#27 Secure Shoreline</option>
<option value='28'>#28 Protect Arriving Ships</option>
<option value='29'>#29 Level Enemy City</option>
<option value='30'>#30 Cut Off Enemy Oil Supply</option>
<option value='31'>#31 Air Raid</option>
<option value='32'>#32 Take out Supply Depots</option>
<option value='nan'>&bull;&bull;Tab 5 Missions&bull;&bull;</option>
<option value='33'>#33 Gather Intelligence</option>
<option value='34'>#34 Deploy Ground Forces</option>
<option value='35'>#35 Surround Enemy Capital</option>
<option value='36'>#36 Send in Air Support</option>
<option value='37'>#37 Overcome Defense Forces</option>
<option value='38'>#38 Capture Key Infrastructure</option>
<option value='39'>#39 Cut Off Enemy Retreat</option>
<option value='40'>#40 Seize Enemy Capital</option>
<option value='nan'>&bull;&bull;Tab 6 Missions&bull;&bull;</option>
<option value='41'>#41 Capture Enemy Fighters</option>
<option value='42'>#42 Locate Recon Centers</option>
<option value='43'>#43 Disrupt Communications</option>
<option value='44'>#44 Take out Base Patrols</option>
<option value='45'>#45 Perform Surprise Attack</option>
<option value='46'>#46 Capture Enemy Spies</option>
<option value='47'>#47 Locate Nuclear Silo</option>
<option value='48'>#48 Destroy Nuclear Facility</option>
<option value='nan'>&bull;&bull;Tab 7 Missions&bull;&bull;</option>
<option value='49'>#49 Conquer Enemy Outpost</option>
<option value='50'>#50 Defend Position</option>
<option value='51'>#51 Set up Defensive Network</option>
<option value='52'>#52 Assemble Naval Fleet</option>
<option value='53'>#53 Attack Piracy Operation</option>
<option value='54'>#54 Conquer Costal Base</option>
<option value='55'>#55 Reinforce Ally Capital</option>
<option value='56'>#56 Force Enemy to Retreat</option>
<option value='nan'>&bull;&bull;Tab 8 Missions&bull;&bull;</option>
<option value='57'>#57 Deploy Scout Planes</option>
<option value='58'>#58 Spread Fleet Position</option>
<option value='59'>#59 Launch Submarine Force</option>
<option value='60'>#60 Assault Enemy Fleet</option>
<option value='61'>#61 Repel Air Support</option>
<option value='62'>#62 Sink Enemys Flagship</option>
<option value='63'>#63 Scatter Enemys Fleet</option>
<option value='64'>#64 Reconvene Fleet</option>
<option value='65'>#65 Make Landfall</option>
<option value='66'>#66 Fortify Beachhead</option>
<option value='67'>#67 Storm Enemy Blockade</option>
<option value='68'>#68 Send Forces Inland</option>
<option value='nan'>&bull;&bull;Tab 9 Missions&bull;&bull;</option>
<option value='69'>#69 Fortify Defensive Position</option>
<option value='70'>#70 Set-Up Operations Base</option>
<option value='71'>#71 Send Recon Choppers</option>
<option value='72'>#72 Identify Sniper Positions</option>
<option value='73'>#73 Employ Guerilla Tactics</option>
<option value='74'>#74 Prevent Enemy Ambush</option>
<option value='75'>#75 Deploy Defollant Planes</option>
<option value='76'>#76 Send in Heavy Artillery Customs Agent</option>
<option value='77'>#77 Sabotage Enemy Vehicles</option>
<option value='78'>#78 Demolish Enemy Base</option>
<option value='79'>#79 Take Military Prisoners</option>
<option value='80'>#80 Question Enemy Officer</option>
<option value='nan'>&bull;&bull;Tab 10 Missions&bull;&bull;</option>
<option value='81'>#81 Collect Aerial Images</option>
<option value='82'>#82 Roll Out Infantry</option>
<option value='83'>#83 Flank Enemy Troops</option>
<option value='84'>#84 Disrupt Supply Lines</option>
<option value='85'>#85 Use Scorched Earth Policy</option>
<option value='86'>#86 Launch MRBMs from Sea</option>
<option value='87'>#87 Conduct Bombing Runs</option>
<option value='88'>#88 Engage in Aerial Combat</option>
<option value='89'>#89 Occupy Enemy City</option>
<option value='90'>#90 Establish Prisoner Camp</option>
<option value='91'>#91 Uncover Nuclear Program</option>
<option value='92'>#92 Destroy Research Facility</option>
	</select>};
}
		print qq{<form name='$udid'>
		<input type='hidden' id='game_$udid' value='$game'>
				<b>Account: $udid</b> 
			<hr>
				<p>Mission: # $mission </p>
			 	<p>Executed: Every $time Minutes </p>
			 	<p>Next Run in: $next_run Minutes </p>
			 	
			 	<button id='submit' type='button' onClick='edit_this_a("$udid")'>Edit</button>
			 		
			 		<div id='account_edit_$udid' style='display:none;'>
			 		<!--- edit mission & time & add to - old/new batch --->
			 		<hr>
			 		<p>Change Mission:</p> 
			 		$missions_list
			 		<p>Change Execution Time:</p> 	
			 		$time_list
			 		<p>Place into Batch:</p>
			 		
			 		<p>Type in batch name to place account into. (Leave blank for no batch. If a new batch, type a new batch name to put account into the batch. If a pre-existing batch, type in the existing batch name)</p><input type='text' class='text' placeholder='Batch Name' id='batch_$udid'>	
			 		
			 		<br><br>
			 		<button type='button' onClick='edit_account_data("$udid")' id='submit'>Save</button>
			 		<div id='cram_$udid' style='color:red;display:none;'>Saved, Updated information will appear after refresh of this page.</div>
			 		</div>
			</form>
		};
	}
} 
else 
{
my $dbh = DBI->connect("DBI:mysql:database=shortlando;host=localhost",
			 "shortlando", "password!",
			 {'RaiseError' => 1});
my $sth3 = $dbh->prepare(<<End_SQL) or die "Couldn't prepare statement: $DBI::errstr; stopped";
SELECT count(*) count 
FROM auto 
WHERE batch = '$batch' 
AND username = '$real_username' 
GROUP BY batch
End_SQL
$sth3->execute() or die "Couldn't execute statement: $DBI::errstr; stopped";
while ( my ($batch_amount_) = $sth3->fetchrow_array() ){
	$batch_amount = $batch_amount_;
}	

my $sth3 = $dbh->prepare(<<End_SQL) or die "Couldn't prepare statement: $DBI::errstr; stopped";
SELECT mission, game, time, last_exec 
FROM auto 
WHERE batch = '$batch' 
AND username = '$real_username'
LIMIT 1 
End_SQL
$sth3->execute() or die "Couldn't execute statement: $DBI::errstr; stopped";
while ( my ($mission, $game, $time, $last_exec) = $sth3->fetchrow_array() ){

$last_exec_m = $last_exec / 60;
$current_time = gettimeofday();
$current_time_m = $current_time / 60;
$next_time = $last_exec_m + $time;
$next_run_s = $next_time - $current_time_m;
$next_run =  sprintf "%.2f", $next_run_s; # minutes is result.
$time_list = qq{
	<select name='time' id='time_$batch' class='dps'>
<option value='5'>5 Minutes</option>
<option value='10'>10 Minutes</option>
<option value='15'>15 Minutes</option>
<option value='20'>20 Minutes</option>
<option value='25'>25 Minutes</option>
<option value='30'>30 Minutes</option>
<option value='45'>45 Minutes</option>
<option value='60'>60 Minutes</option>
<option value='120'>120 Minutes (2H)</option>
<option value='180'>180 Minutes (3H)</option>
<option value='240'>240 Minutes (4H)</option>
<option value='300'>300 Minutes (5H)</option>
<option value='420'>420 Minutes (7H)</option>
	</select>
};
if($game =~ /^(im)$/)
{
$missions_list = qq{<select name='mission' id='mission_$batch' class='dps'>
<option value='nan'>&bull;&bull;Tab 1 Missions&bull;&bull;</option>
<option value='1'>#1 Shoplifting</option>
<option value='2'>#2 Street Mugging</option>
<option value='3'>#3 Breaking and Entering</option>
<option value='4'>#4 Grand Theft Auto</option>
<option value='5'>#5 Liquor Store Robbery</option>
<option value='6'>#6 Start Protection Racket</option>
<option value='7'>#7 Museum Heist</option>
<option value='8'>#8 Electronic Store Robbery</option>
<option value='nan'> &bull;&bull;Tab 2 Missions&bull;&bull;</option>
<option value='9'>#9 Liquor Smuggling</option>
<option value='10'>#10 Prison Break</option>
<option value='11'>#11 Jewelry Store Robbery</option>
<option value='12'>#12 Infiltrate Mob Base</option>
<option value='13'>#13 Knock off Mob Member</option>
<option value='14'>#14 Bank Robbery</option>
<option value='15'>#15 Hide Illegal Goods</option>
<option value='16'>#16 Take Out Snitch</option>
<option value='nan'> &bull;&bull;Tab 3 Missions&bull;&bull;</option>
<option value='17'>#17 Steal Weapons From Mob</option>
<option value='18'>#18 Sell Arms Underground</option>
<option value='19'>#19 Extorst Local Businesses</option>
<option value='20'>#20 Burn Police Station</option>
<option value='21'>#21 Plant Evidence on Mob</option>
<option value='22'>#22 Bribe Police</option>
<option value='23'>#23 Manufacture Fake Money</option>
<option value='24'>#24 Bomb Mob's Shipment</option>
<option value='nan'> &bull;&bull;Tab 4 Missions&bull;&bull;</option>
<option value='25'>#25 Hi-Jack a Bank Truck</option>
<option value='26'>#26 Bribe Judge to Drop Case</option>
<option value='27'>#27 Take Out Prosecutor</option>
<option value='28'>#28 Protect Godfather</option>
<option value='29'>#29 Survive Bloody Shootout</option>
<option value='30'>#30 Destroy Weapon Supply</option>
<option value='31'>#31 Bootlegging Racket</option>
<option value='32'>#32 Take Out FBI Squad</option>
<option value='nan'>&bull;&bull;Tab 5 Missions&bull;&bull;</option>
<option value='33'>#33 Burn Down Casino</option>
<option value='34'>#34 Drive Mob off your Turf</option>
<option value='35'>#35 Expand Yur Influence</option>
<option value='36'>#36 Eliminate Harbor Security</option>
<option value='37'>#37 Escape FBI Lockdown</option>
<option value='38'>#38 Rig City Election</option>
<option value='39'>#39 Destroy Shipment Trucks</option>
<option value='nan'>&bull;&bull;Tab 6 Missions&bull;&bull;</option>
<option value='40'>#40 Blow up Archives</option>
<option value='41'>#41 Import Illegal Goods</option>
<option value='42'>#42 Hide Imports from FBI</option>
<option value='43'>#43 Drive out Russian Mob</option>
<option value='44'>#44 Bribe ATF Agents</option>
<option value='45'>#45 Blow Up Rival Mob HQ</option>
<option value='46'>#46 Eliminate Enemy Don</option>
<option value='nan'>&bull;&bull;Tab 7 Missions&bull;&bull;</option>
<option value='47'>#47 Sell Counterfeit Goods</option>
<option value='48'>#48 Takeover Escort Service</option>
<option value='49'>#49 Confront Local Crimelord</option>
<option value='50'>#50 Hide Bodies in Desert</option>
<option value='51'>#51 Rig Boxing Match</option>
<option value='52'>#52 Burn Down Dance Club</option>
<option value='53'>#53 Ally with Hotel Magnate</option>
<option value='54'>#54 Bribe Zoning Committee</option>
<option value='55'>#55 Sabotage Rivals Casino</option>
<option value='56'>#56 Fix Games in Your Favor</option>
<option value='57'>#57 Launder Gambling Money</option>
<option value='58'>#58 Doublecross Partner</option>
<option value='nan'>&bull;&bull;Tab 8 Missions&bull;&bull;</option>
<option value='59'>#59 Recruit Local Muscle</option>
<option value='60'>#60 Distribute Bottleg Movies</option>
<option value='61'>#61 Sell Fake Passports</option>
<option value='62'>#62 Run Off Local Gangs</option>
<option value='63'>#63 Rough-Up Untruly Star</option>
<option value='64'>#64 Extort Nightclub Owner</option>
<option value='65'>#65 Arrange Sporting Victory</option>
<option value='66'>#66 Blackmail Famous Actor</option>
<option value='67'>#67 Threaten Studio Execs</option>
<option value='68'>#68 Takeover Movie Studio</option>
<option value='69'>#69 Demolish Rival Studio</option>
<option value='70'>#70 Produce Awarded Drama</option>
<option value='nan'>&bull;&bull;Tab 9 Missions&bull;&bull;</option>
<option value='71'>#71 Recruit Crooked Cops</option>
<option value='72'>#72 Ransack Village</option>
<option value='73'>#73 Ransome Tourists</option>
<option value='74'>#74 Intercept Money Transfer</option>
<option value='75'>#75 Cultivate Local Crops</option>
<option value='76'>#76 Bribe Customs Agent</option>
<option value='77'>#77 Ship Goods to Hollywood</option>
<option value='78'>#78 Ally With Insurgents</option>
<option value='79'>#79 Blackmail Corrupt Politico</option>
<option value='80'>#80 Raise Water Prices</option>
<option value='81'>#81 Setup Smuggling Cartel</option>
<option value='82'>#82 Support Political Group</option>
	</select>};
}
if($game =~ /^(wwar)$/)
{
$missions_list = qq{<select name='mission' id='mission_$batch' class='dps'>
<option value='nan'>&bull;&bull;Tab 1 Missions&bull;&bull;</option>
<option value='1'>#1 Fend off Enemy Attack</option>
<option value='2'>#2 Hunt Down Enemies</option>
<option value='3'>#3 Train Armed Forces</option>
<option value='4'>#4 Seize Enemy</option>
<option value='5'>#5 Locate Enemy Camp</option>
<option value='6'>#6 Establish Base Defense</option>
<option value='7'>#7 Destroy Enemy Base</option>
<option value='8'>#8 Invade Enemy Territory</option>
<option value='nan'>&bull;&bull;Tab 2 Missions&bull;&bull;</option>
<option value='9'>#9 Set up Military Camp</option>
<option value='10'>#10 Scout Out Enemy</option>
<option value='11'>#11 Sink Enemy Boats</option>
<option value='12'>#12 Intercept Shipment</option>
<option value='13'>#13 Ship Supplies to Troops</option>
<option value='14'>#14 Shoot Down Aircraft</option>
<option value='15'>#15 Investigate Wreckage</option>
<option value='16'>#16 Prepare Army to March</option>
<option value='nan'>&bull;&bull;Tab 3 Missions&bull;&bull;</option>
<option value='17'>#17 Infiltrate Western Border</option>
<option value='18'>#18 Take out Western Forces</option>
<option value='19'>#19 Discover Reinforcements</option>
<option value='20'>#20 Repel Counterattack</option>
<option value='21'>#21 Bombard Enemy Defenses</option>
<option value='22'>#22 Destroy Enemy Lab</option>
<option value='23'>#23 Confiscate Bioweapons</option>
<option value='24'>#24 Destroy Power Centers</option>
<option value='nan'>&bull;&bull;Tab 4 Missions&bull;&bull;</option>
<option value='25'>#25 Locate Submarines</option>
<option value='26'>#26 Set Mines in Ocean</option>
<option value='27'>#27 Secure Shoreline</option>
<option value='28'>#28 Protect Arriving Ships</option>
<option value='29'>#29 Level Enemy City</option>
<option value='30'>#30 Cut Off Enemy Oil Supply</option>
<option value='31'>#31 Air Raid</option>
<option value='32'>#32 Take out Supply Depots</option>
<option value='nan'>&bull;&bull;Tab 5 Missions&bull;&bull;</option>
<option value='33'>#33 Gather Intelligence</option>
<option value='34'>#34 Deploy Ground Forces</option>
<option value='35'>#35 Surround Enemy Capital</option>
<option value='36'>#36 Send in Air Support</option>
<option value='37'>#37 Overcome Defense Forces</option>
<option value='38'>#38 Capture Key Infrastructure</option>
<option value='39'>#39 Cut Off Enemy Retreat</option>
<option value='40'>#40 Seize Enemy Capital</option>
<option value='nan'>&bull;&bull;Tab 6 Missions&bull;&bull;</option>
<option value='41'>#41 Capture Enemy Fighters</option>
<option value='42'>#42 Locate Recon Centers</option>
<option value='43'>#43 Disrupt Communications</option>
<option value='44'>#44 Take out Base Patrols</option>
<option value='45'>#45 Perform Surprise Attack</option>
<option value='46'>#46 Capture Enemy Spies</option>
<option value='47'>#47 Locate Nuclear Silo</option>
<option value='48'>#48 Destroy Nuclear Facility</option>
<option value='nan'>&bull;&bull;Tab 7 Missions&bull;&bull;</option>
<option value='49'>#49 Conquer Enemy Outpost</option>
<option value='50'>#50 Defend Position</option>
<option value='51'>#51 Set up Defensive Network</option>
<option value='52'>#52 Assemble Naval Fleet</option>
<option value='53'>#53 Attack Piracy Operation</option>
<option value='54'>#54 Conquer Costal Base</option>
<option value='55'>#55 Reinforce Ally Capital</option>
<option value='56'>#56 Force Enemy to Retreat</option>
<option value='nan'>&bull;&bull;Tab 8 Missions&bull;&bull;</option>
<option value='57'>#57 Deploy Scout Planes</option>
<option value='58'>#58 Spread Fleet Position</option>
<option value='59'>#59 Launch Submarine Force</option>
<option value='60'>#60 Assault Enemy Fleet</option>
<option value='61'>#61 Repel Air Support</option>
<option value='62'>#62 Sink Enemys Flagship</option>
<option value='63'>#63 Scatter Enemys Fleet</option>
<option value='64'>#64 Reconvene Fleet</option>
<option value='65'>#65 Make Landfall</option>
<option value='66'>#66 Fortify Beachhead</option>
<option value='67'>#67 Storm Enemy Blockade</option>
<option value='68'>#68 Send Forces Inland</option>
<option value='nan'>&bull;&bull;Tab 9 Missions&bull;&bull;</option>
<option value='69'>#69 Fortify Defensive Position</option>
<option value='70'>#70 Set-Up Operations Base</option>
<option value='71'>#71 Send Recon Choppers</option>
<option value='72'>#72 Identify Sniper Positions</option>
<option value='73'>#73 Employ Guerilla Tactics</option>
<option value='74'>#74 Prevent Enemy Ambush</option>
<option value='75'>#75 Deploy Defollant Planes</option>
<option value='76'>#76 Send in Heavy Artillery Customs Agent</option>
<option value='77'>#77 Sabotage Enemy Vehicles</option>
<option value='78'>#78 Demolish Enemy Base</option>
<option value='79'>#79 Take Military Prisoners</option>
<option value='80'>#80 Question Enemy Officer</option>
<option value='nan'>&bull;&bull;Tab 10 Missions&bull;&bull;</option>
<option value='81'>#81 Collect Aerial Images</option>
<option value='82'>#82 Roll Out Infantry</option>
<option value='83'>#83 Flank Enemy Troops</option>
<option value='84'>#84 Disrupt Supply Lines</option>
<option value='85'>#85 Use Scorched Earth Policy</option>
<option value='86'>#86 Launch MRBMs from Sea</option>
<option value='87'>#87 Conduct Bombing Runs</option>
<option value='88'>#88 Engage in Aerial Combat</option>
<option value='89'>#89 Occupy Enemy City</option>
<option value='90'>#90 Establish Prisoner Camp</option>
<option value='91'>#91 Uncover Nuclear Program</option>
<option value='92'>#92 Destroy Research Facility</option>
	</select>};
}

		print qq{
			<form>
			<input type='hidden' id='game_$batch' value='$game'>
				<b>Batch: $batch</b>
			<hr>
				<p>Count: $batch_amount Accounts </p>
				<p>Mission: # $mission </p>
			 	<p>Executed: Every $time Minutes </p>
			 	<p>Next Run in: $next_run Minutes </p>
			 	<button id='submit' type='button' onClick='edit_this_b("$batch")'>Edit</button>
			 		<div id='batch_edit_$batch' style='display:none;'>
			 		<!--- edit mission & time in frame && batch name --->
			 		<hr>
			 			<p>Change Mission:</p>
			 			$missions_list
			 			<p>Change Execution Time:</p> 	
			 			$time_list
			 			
			 			<BR><BR><button type='button' onClick='edit_batch_data("$batch")' id='submit'>Save</button>
			 		</div>
			 <hr>
			 	<p>View Accounts In $batch</p>
			 	<button id='submit' type='button' onClick='view_accounts("$batch")'>Show Accounts</button>
			 	<br><br>
			 	<div id='cramy_$batch' style='display:none;color:red;'>Saved, Updated information will appear after refresh of this page.</div>
			 		<div id='batch_show_$batch' style='display:none;'>
			 		<p><b>UDIDs in Batch $batch</b></p>
			 		<!--- show each indv acc --->
				};
				
my $sth4 = $dbh->prepare(<<End_SQL) or die "Couldn't prepare statement: $DBI::errstr; stopped";
SELECT udid FROM auto WHERE username = '$real_username'	AND batch = '$batch'
End_SQL
$sth4->execute() or die "Couldn't execute statement: $DBI::errstr; stopped";
while ( my ($udid) = $sth4->fetchrow_array() ){
	print "<p>$udid</p>";
}
			
				
	print qq{</div>
			</form>
		};
	}
}

				}
print qq{				
<script type='text/javascript'>
	function view_accounts(batch) {
		\$('#batch_show_' + batch).fadeToggle('slow');
	}

	function edit_this_b(batch) {
		\$('#batch_edit_' + batch).fadeToggle('slow');
	}
	function edit_this_a(udid) {
		\$('#account_edit_' + udid).fadeToggle('slow');
	}		
	function edit_account_data(udid) {
\$.ajax({
                   url  : 'mission_edit.pl',
                   type : 'POST',
                   data : 'mission=' + document.getElementById("mission_" + udid).value + '&time=' + document.getElementById("time_" + udid).value + '&batch=' + document.getElementById("batch_" + udid).value + '&udid=' + udid + '&game=' + document.getElementById("game_" + udid).value,
                   cache: false
                   }).done(function(){
\$('#cram_' + udid).fadeToggle('slow');
                           });

                   
}
	function edit_batch_data(batch) {
\$.ajax({
                   url  : 'mission_edit.pl',
                   type : 'POST',
                   data : 'mission=' + document.getElementById("mission_" + batch).value + '&time=' + document.getElementById("time_" + batch).value + '&batch=' + batch + '&game=' + document.getElementById("game_" + batch).value,
                   cache: false
                   }).done(function(){
\$('#cramy_' + batch).fadeToggle('slow');
                           });

                   
}
	
</script>	
};			
		


print "</span>";

print "<br><br>";
print "<br><br>";
print "<br><br>";
print "<br><br>";
print "<br><br>";
print "<br><br>";
print "<br><br>";
print "<br><br>";
print "<br><br>";
print "<br><br>";
print "<br><br>";
print "<br><br>";






