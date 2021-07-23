<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.net.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
	String qry="",insname="";
	DBHandler db=new DBHandler();
	ResultSet rs=null;

   /****************************************************************************************
	' *													   *
	' * File Name:	TotTitle.ASP		[For all users]						           *
	' * Author:	mohit sharma					           *
	' * Date:		4/28/2012
	' * Version:	1.1										   *
	' * Description:	TopBar 					   *
	**********************************************************************************************
*/
%>
<Html>
<head>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
<title></title>
 <style fprolloverstyle>A:hover {text-color: white}
</style> 
<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function scrollit(seed) {
var m1 = "Jaypee Institute of Information Technology";
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
<style type="text/css">
/* Remove margins from the 'html' and 'body' tags, and ensure the page takes up full screen height */
html, body {height:100%; margin:0; padding:0;}
/* Set the position and dimensions of the background image. */
#page-background {position:fixed; top:0; left:0; width:100%; height:100%;}
#back{position:fixed; z-index:1; top:0; left:0; width:13%; height:100%;}
/* Specify the position and layering for the content that needs to appear in front of the background image. Must have a higher z-index value than the background image. Also add some padding to compensate for removing the margin from the 'html' and 'body' tags. */
#content {position:fixed; z-index:2; top:0; left:13%; width:85%; height:100%;}
#contents {position:fixed; z-index:2; top:0; left:0%; width:13%; height:100%;}
#st1{font-size:220%; vertical-align:top;}
#st2{font-size:80%;}
#st3{font-size:100%;}
 .sg
 {
	 vertical-align:top;
	
 }
</style>
<script>
var myVar=setInterval(function(){myTimer()},100);

function myTimer() {
    var d = new Date();
    document.getElementById("demo").innerHTML = d.toLocaleTimeString();
}
</script>
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
	mInst="BFGI";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}

%>
<body cellpadding="0" cellspacing="0" scroll=0 nowrap topmargin=0 rightmargin=0 leftmargin=0 bottommargin=0 noscroll onLoad="scrollit(150)">
<div id="page-background"><img src="../images2/newframe/frm2-4.jpg" width="100%" height="100%" alt=""></div>
<div id="back"><img src="../images2/newframe/frm2-5.jpg" width="100%" height="100%" alt=""></div>
<%
if(!mMemberID.equals("") && !mMemberType.equals(""))
{
	try
	{

		OLTEncryption enc=new OLTEncryption();
		mMemberType=enc.decode(mMemberType);
	
		qry = "Select TEXTDATA from KIOSKMARQUEETEXT where nvl(ACTIVE,'Y')='Y' and nvl(APPLICABLEFOR,'A') in ('A','"+ mMemberType+"') and InstituteCode='" + mInst +"' and to_char(sysdate,'yyyymmddhh24miss')  between to_char(DISPLAYFROM,'yyyymmddhh24miss') and to_char(DISPLAYTILL,'yyyymmddhh24miss') order by MSGPRIORITY";
 		rs=db.getRowset(qry) ;
		//out.print(qry);
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
		//background="../Images/Topbar.JPG"
		
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
<div id="contents">
<table width="75%" height="74%" valign=top align=left cellspacing="0" cellpadding="0">
<tr height="24%">
<td width="25%"></td>
<td width="75%">
</td>
</tr >
<tr height="76%">
<td width="25%"></td>
<td width="75%">
<!-- <img src="../images2/newframe/logob.png" height="100%" width="100%"> -->
</td>
</tr>
</table>
</div>


<div id="content">
<table cellspacing="0" cellpadding="0" width="100%" height="94%" >
<tr height="85%">
<%		
qry=" select institutename  from InstituteMaster where InstituteCode='"+mInst+"' ";
	 rs=db.getRowset(qry) ;
	 //System.out.print(qry+"************");
  
   if(rs.next())
		{
	   insname=rs.getString("institutename") ;
		}

		insname="         "+insname;
%>
<td align="center"><font id="st1"  size=1 face="impact"  align=center> <CENTER><%=insname%></CENTER></Font><BR><MARQUEE style="COLOR: #63756d; FONT-FAMILY: Arial; FONT-SIZE:normal; FONT-STYLE: normal; FONT-VARIANT: normal; FONT-WEIGHT: bold; HEIGHT: 15px; WIDTH: 625px"    scrolldelay=225><%=mMarqueeText%></FONT> </MARQUEE>
<td valign=top><p align="right" bgcolor=black><FONT id="st2" COLOR=WHITE ><FONT  face="COMIC SANS MS" SIZE="2" COLOR="white">
<script>message=new Date()
h=message.getHours()
if((h < 12) && (h >= 6))
{document.write("<FONT SIZE=2 color=#225A6B><B>Good Morning</B></FONT>")}  
if((h >= 12) && (h < 17))
{document.write("<FONT SIZE=2 color=#225A6B><B>Good Afternoon</B></FONT>")}  
if((h >= 17) && (h <= 23))
{document.write("<FONT SIZE=2 color=#225A6B><B>Good Evening</B></FONT>")}  
 </script></font><FONT  face="COMIC SANS MS" SIZE="2" COLOR="#225A6B"><B><BR><%=mNickName%><B><p color=white id="demo" align=right></p></B></B></FONT>
<!-- <A href="SignOut.jsp" target=_parent title="Close/Logout KIOSK Site">
<font color=white face="Arial" size=2 ><b>Signout</b></font></A> --></p><td>
</tr>
<tr height=5% width=100%>
<td width=78%><MARQUEE style="COLOR: #63756d; FONT-FAMILY: Arial; FONT-SIZE: x-small; FONT-STYLE: normal; FONT-VARIANT: normal; FONT-WEIGHT: bold; HEIGHT: 8px; WIDTH: 625px"    scrolldelay=225></MARQUEE>
</td>
</tr>
</table>
</div>
<!-- <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=10,0,0,0" width="1159" height="85">
<param name="movie" value="chhsupdatred.swf" />
<param name="quality" value="best" />
<param name="menu" value="true" />
<param name="allowScriptAccess" value="sameDomain" />
<embed src="chhsupdatred.swf" quality="best" menu="true" width="1159" height="85" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" allowScriptAccess="sameDomain" />
</object> -->
</body>
</html>