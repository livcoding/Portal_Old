<%-- 
    Document   : StudentEnrollnDOBValidation
    Created on : Apr 6, 2015, 2:38:52 PM
    Author     : Gyanendra.Bhatt
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
        <link rel="stylesheet" href="../css/jquery-ui.css">
        <script src="../js/jquery/jquery-1.10.2.js"></script>
        <script src="../js/jquery/jquery-ui.js"></script>
        <link rel="stylesheet" href="../css/style.css">
        <style>
body { font-size: 62.5%; }
label, input { display:block; }
input.text { margin-bottom:12px; width:95%; padding: .4em; }
fieldset { padding:0; border:0; margin-top:25px; }
h1 { font-size: 1.2em; margin: .6em 0; }

.ui-dialog .ui-state-error { padding: .3em; }
.validateTips { border: 1px solid transparent; padding: 0.3em; }
</style>
<script>
$(function() {
var dialog, 
// From http://www.whatwg.org/specs/web-apps/current-work/multipage/states-of-the-type-attribute.html#e-mail-state-%28type=email%29
emailRegex = /(\d{1,2})[\/-](\d{1,2})[\/-](\d{2,4})/,
name = $( "#name"),
enroll = $( "#enroll"),
dob = $( "#dob"),
allFields = $( [] ).add( name ).add(enroll).add(dob),
tips = $( ".validateTips" );
function updateTips(t){
tips
.text( t )
.addClass( "ui-state-highlight" );
setTimeout(function() {
tips.removeClass( "ui-state-highlight", 1500 );
}, 500 );
}
function checkLength( o, n, min, max ) {
if ( o.val().length > max || o.val().length < min ) {
o.addClass( "ui-state-error" );
updateTips( "Length of " + n + " must be between " +
min + " and " + max + "." );
return false;
} else {
return true;
}
}
function checkLength1( o, n, min ) {
if ( o.val().length < min ) {
o.addClass( "ui-state-error" );
updateTips( "Length of Date Of Birth must be  " +
min + "." );
return false;
} else {
return true;
}
}

function checkRegexp( o, regexp, n ) {
if ( !( regexp.test( o.val() ) ) ) {
o.addClass( "ui-state-error" );
updateTips( n );
return false;
} else {
return true;
}
}


$("#StudentValidForm").keypress(function(e)
{
if(e.which == 13){

var valid = true;
allFields.removeClass( "ui-state-error" );
//valid = valid && checkLength( name, "name", 3, 16 );
valid = valid && checkLength( enroll, "enroll", 6, 16 );
valid = valid && checkLength1( dob, "dob", 10 );
valid = valid && checkRegexp( dob, emailRegex, "Date Of Birth should be in dd-mm-yyyy format." );
//valid = valid && checkRegexp( name, /^[a-z]([0-9a-z_\s])+$/i, "Username may consist of a-z, 0-9, underscores, spaces and must begin with a letter." );
valid = valid && checkRegexp( dob, emailRegex, "eg. 01-12-1981" );
//valid = valid && checkRegexp( dob, /^([0-9a-zA-Z])+$/, "Password field only allow : a-z 0-9" );
if ( valid ) {
try{
    var studData={}

        studData.enroll=$("#enroll").val();
        studData.dob=$("#dob").val();
       var jdata=[];
        jdata[0]=studData;
       // jdata[1]=studData;
      //  alert("/rest/IQACFormServices/studentvalidation?jdata="+JSON.stringify(jdata)+"");
  // var jsondata=JSON.stringify(jdata).replace("{","opencurly");
    //     jsondata=jsondata.replace("}","closecurly");
     var encoded = encodeURIComponent(JSON.stringify(jdata));
    $.ajax({
        url:"/rest/IQACFormServices/studentvalidation?jdata="+encoded+"",
        type:"GET",
        contentType:"application/json",
        success:function(e){
          //  alert("#####"+e.result+"$$$$");
            if(e.result=='Y')
            {
                var studid=e.studentid.substr(4,e.studentid.length);
          jQuery('<form action="ParentFeedbackTransaction.jsp" method="post"><input type=hidden name=studentid id=studentid value='+studid+'></form>').appendTo('body').submit().remove();
            }
            else
            {
                alert(e.result);
                return false;
            }
         },
        error : function (){
            alert("Please Fill Correct Information");
    return false;
    }

    });


return false;

//$("#StudentValidForm").attr("action", "ParentFeedbackTransaction.jsp");
//dialog.dialog( "close" );
}catch(e){
    alert(e);
}

}
return valid;
}
});




function addUser() {
   // alert("Gyan");

var valid = true;
allFields.removeClass( "ui-state-error" );
//valid = valid && checkLength( name, "name", 3, 16 );
valid = valid && checkLength( enroll, "enroll", 6, 16 );
valid = valid && checkLength1( dob, "dob", 10 );
valid = valid && checkRegexp( dob, emailRegex, "Date Of Birth should be in dd-mm-yyyy format." );
//valid = valid && checkRegexp( name, /^[a-z]([0-9a-z_\s])+$/i, "Username may consist of a-z, 0-9, underscores, spaces and must begin with a letter." );
valid = valid && checkRegexp( dob, emailRegex, "eg. 01-12-1981" );
//valid = valid && checkRegexp( dob, /^([0-9a-zA-Z])+$/, "Password field only allow : a-z 0-9" );
if ( valid ) {
try{
    var studData={}
   
        studData.enroll=$("#enroll").val();
        studData.dob=$("#dob").val();
       var jdata=[];
        jdata[0]=studData;
      //var jsondata=JSON.stringify(jdata).replace("{","opencurly");
       //  jsondata=jsondata.replace("}","closecurly");
       // jdata[1]=studData;
      //  alert("/rest/IQACFormServices/studentvalidation?jdata="+JSON.stringify(jdata)+"");
       var encoded = encodeURIComponent(JSON.stringify(jdata));
    $.ajax({
        url:"/rest/IQACFormServices/studentvalidation?jdata="+encoded+"",
        type:"GET",
        contentType:"application/json",
        success:function(e){
          //  alert("#####"+e.result+"$$$$");
            if(e.result=='Y')
            {
                var studid=e.studentid.substr(4,e.studentid.length);
          jQuery('<form action="ParentFeedbackTransaction.jsp" method="post"><input type=hidden name=studentid id=studentid value='+studid+'></form>').appendTo('body').submit().remove();
            }
            else
            {
                alert(e.result);
                return false;
            }
         },
        error : function (){
            alert("Please Fill Correct Information");
    return false;
    }

    });


return false;
 
//$("#StudentValidForm").attr("action", "ParentFeedbackTransaction.jsp");
//dialog.dialog( "close" );
}catch(e){
    alert(e);
}

}
return valid;
}

dialog = $( "#dialog-form" ).dialog({
autoOpen: false,
height: 300,
width: 350,
modal: true,
buttons: {
"Submit": addUser,
Cancel: function() {
   
dialog.dialog( "close" );
}
},
close: function() { jQuery('<form action="../MENU.jsp" method="post"></form>').appendTo('body').submit().remove();
//form[ 0 ].reset();
allFields.removeClass( "ui-state-error" );
}
});

$(document).ready(function() {
    dialog.dialog( "open" );
 
});
});
</script>
    </head>
    <body >
       <div id="dialog-form" title="Parent Validation For Students">
<p class="validateTips">All form fields are required.</p>
<form  id="StudentValidForm" name="StudentValidForm" >
<fieldset>
<!--label for="Student Name">Student Name</label>
<input type="text" name="name" id="name" value="" class="text ui-widget-content ui-corner-all"-->
<label for="email">Enrollment No</label>
<input type="text" name="enroll" id="enroll" value="" class="text ui-widget-content ui-corner-all">
<label for="Date Of Birth">Date Of Birth<font color="red" size="1">&nbsp;(DD-MM-YYYY)</font></label>
<input type="text" name="dob" id="dob" value="" class="text ui-widget-content ui-corner-all">
<!-- Allow form submission with keyboard without duplicating the dialog button -->
</fieldset>

<input type="submit" id="SubmitButton" name="SubmitButton"  style="position:absolute; top:-1000px">
</form>

</div>

<!--button id="create-user">Create new user</button-->
</body>
</html>
    </body>
</html>
