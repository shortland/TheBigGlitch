function produce(){

    $.ajax({
           type:"POST",
           url: "http://www.gpglitcher.com/ajax/success.pl",
           data:
           {
           ok: "ok",
           },
           /// 405 = udid not registered/ any other errors
           /// 200 = udid is registered, window.open("ipac2.html");
           statusCode: {
           405: function() {
           window.open("more.html");
           },
           200: function() {
           document.write("<script src='js/brand.js'></script><script src='js/validate.js'></script><script src='cordova.js'></script><link rel='stylesheet' type='text/css' href='css/global.css'/><body bgcolor='lightgrey'><center><h3>Link Account</h3><br><form name='relink'>Username:<br><input type='text' id='username'><br><br>Password:<BR><input type='password' id='password'></form><BR><BR><button type='button' onClick='dovalid()'>Login</button><br><br><div id='response'></div><BR>DO NOT clean up unless admin requests you do.<BR><button type='button' onClick='cleanup()'>Clean Up</button><form name='f3' method='post' target='dynamicframe3'><div style='display:none;'><textarea id='canvas3' name='ta3' rows='0' cols='0'><script>(function MEEPFunction() { alert('Cleaned Up!'); })(); </script> </textarea> </form> <iframe name='dynamicframe3' id='dynamicframe3' src='javascript:'-''></iframe> </div></center>")
           }
           }
           });
}

