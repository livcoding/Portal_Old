
<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../CommonFiles/ExceptionHandler.jsp" %>  
<%  

	String qry="";
	DBHandler db=new DBHandler();
	ResultSet rs=null;
%>
<html>
<head>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
<title>Stretched Background Image</title>
<style type="text/css">
/* Remove margins from the 'html' and 'body' tags, and ensure the page takes up full screen height */
html, body {height:100%; margin:0; padding:0;}
/* Set the position and dimensions of the background image. */
#page-background {position:fixed; top:0; left:0; width:100%; height:100%;}
/* Specify the position and layering for the content that needs to appear in front of the background image. Must have a higher z-index value than the background image. Also add some padding to compensate for removing the margin from the 'html' and 'body' tags. */
#content {position:relative; z-index:1; padding:0px;}
 .sg
 {
	 vertical-align:top;
	
 }
</style>
<!-- The above code doesn't work in Internet Explorer 6. To address this, we use a conditional comment to specify an alternative style sheet for IE 6 -->
<!--[if IE 6]>
<style type="text/css">
html {overflow-y:hidden;}
body {overflow-y:auto;}
#page-background {position:absolute; z-index:-1;}
#content {position:static;padding:10px;}
</style>
<![endif]-->
 <style fprolloverstyle>A:hover {text-color: #FDB813}

</style> 


<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function scrollit(seed) {



var m1 = "";
var msg=m1;
var out = " ";
var c = 1;
if (seed > 100) {
seed--;
cmd="scrollit("+seed+")";
timerTwo=window.setTimeout(cmd,100);
}
else if (seed <= 100 && seed > 0) {
for (c=0 ; c < seed ; c++) {
out+=" ";
}
out+=msg;
seed--;
window.status=out;
cmd="scrollit("+seed+")";
timerTwo=window.setTimeout(cmd,100);
}
else if (seed <= 0) {
if (-seed < msg.length) {
out+=msg.substring(-seed,msg.length);
seed--;
window.status=out;
cmd="scrollit("+seed+")";
timerTwo=window.setTimeout(cmd,100);
}
else {
window.status=" ";
timerTwo=window.setTimeout("scrollit(100)",75);
}
}
}
// End -->
</SCRIPT> 
</head>
<%
String mNickName="", mMemberType="",mMemberID="";
String  mMarqueeText="",mInst="";

if (session.getAttribute("MemberID")==null)
{
	mMemberID="";
}
else
{
	mMemberID=session.getAttribute("MemberID").toString().trim();
}

if (session.getAttribute("MemberType")==null)
{
	mMemberType="";
}
else
{
	mMemberType=session.getAttribute("MemberType").toString().trim();
}


if (session.getAttribute("NickName")==null)
{
	mNickName="";
}
else
{
	mNickName=session.getAttribute("NickName").toString().trim();
}

if (session.getAttribute("InstituteCode")==null)
{
	mInst="JIIT";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}

%>
<body cellpadding="0"  onLoad="scrollit(150)">
<div id="page-background" align="right"><img src="../images2/newframe/frm1-12.jpg" width="113%" height="100%" alt="" align="center"></div>
<div id="content">
<%
if(!mMemberID.equals("") && !mMemberType.equals(""))
{
	try
	{
		OLTEncryption enc=new OLTEncryption();
		mMemberType=enc.decode(mMemberType);
	
		qry = "Select TEXTDATA from KIOSKMARQUEETEXT where nvl(ACTIVE,'Y')='Y' and nvl(APPLICABLEFOR,'A') in ('A','"+ mMemberType+"') and InstituteCode='" + mInst +"' and to_char(sysdate,'yyyymmddhh24miss')  between to_char(DISPLAYFROM,'yyyymmddhh24miss') and to_char(DISPLAYTILL,'yyyymmddhh24miss') order by MSGPRIORITY";
 		rs=db.getRowset(qry) ;
		if (rs.next())
		{	
			if  (rs.getString(1)==null)
				mMarqueeText="No Text";
			else
			{
				mMarqueeText = "";		
	      		do 
				{
					if (mMarqueeText.equals(""))
					    	mMarqueeText=rs.getString(1).toUpperCase();
					else					
						mMarqueeText=mMarqueeText+"  ###   "+rs.getString(1).toUpperCase();
				}
				while(rs.next());
			}
		}
		else
		{
			mMarqueeText="NO MESSAGE FOUND";
		}
		%>	<%
	}
	catch(Exception e)
	{
		out.print("<b>Unable to load this page! Please login again to continue...</b>");
	}
}
else
{
	out.print("<br><img src='../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
}
%>
</div>
</body>
</html>
