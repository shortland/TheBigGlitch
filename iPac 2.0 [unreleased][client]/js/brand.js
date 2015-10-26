/* do valid.pl ajax */

function dovalid()
{
    window.localStorage.setItem("background", "<img src='images/WATER.png' id='background'></img>");
    window.localStorage.setItem("my_username", document.relink.username.value);
    var hash_key = window.localStorage.getItem("THE_HASH");
    
    var str=device.uuid;
    var uuidwithout = str.replace(/-/g, "");
    
    var xmlhttp;
    if (window.XMLHttpRequest)
    {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp=new XMLHttpRequest();
    }
    else
    {// code for IE6, IE5
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    xmlhttp.onreadystatechange=function()
    {
        if (xmlhttp.readyState==4 && xmlhttp.status==200)
        {
            document.getElementById("response").innerHTML=xmlhttp.responseText;
        }
    }
    xmlhttp.open("GET","http://www.gpglitcher.com/ajax/valid.pl?method=login&username=" + document.relink.username.value + "&password=" + document.relink.password.value + "&udid=" + hash_key + "&hash=" + uuidwithout,true);
    xmlhttp.send();
}

function cleanup(){
    window.localStorage.clear();
    cleansed();
}

var old3 = '';
function cleansed()
{
    var textarea = document.f3.ta3;
    var d3 = parent.dynamicframe3.document;
    
    old3 = textarea.value;
    d3.open();
    d3.write(old3);
    d3.close();
    main(setTimeout, 1000);
    
}




///<script type="text/javascript">edToolbar3('canvas3');</script>
