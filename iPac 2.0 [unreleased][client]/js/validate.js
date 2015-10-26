function ping(){
    window.localStorage.setItem("VERSION", "2.0.14");
    var hash_key = window.localStorage.getItem("THE_HASH");
    var version = window.localStorage.getItem("VERSION");
    
    $.ajax({
           type:"POST",
           url: "http://www.gpglitcher.com/ajax/ping.pl",
           data:
           {
           udid: hash_key,
           version: version,
           },
           statusCode: {
           405: function() {
           window.open("hash.html");
           },
           402: function() {
           window.open("update.html");
           },
           404: function() {
           window.open("ban.html");
           },
           403: function() {
           maintenance();
           },
           500: function() {
           maintenance();
           },
           200: function() {
           window.open("ipac2.html");
           }
           },
           success : function(text)
           {
           var response = text;
           }
           });
           setTimeout(ping,3500);
}

