<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %> 
<%
	String qry="";
	DBHandler db=new DBHandler();
	ResultSet rs=null;

/*
	**********************************************************************************************************
	' *													   *
	' * File Name:	TotTitle.ASP		[For all users]						           *
	' * Author:	Ashok Kumar Singh 							           *
	' * Date:		21st April 2005
	' * Version:		1.1										   *
	' * Description:	TopBar 					   *
	' **********************************************************************************************
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

<body bgcolor="#ff8c00" cellpadding="0" cellspacing="0" scroll=0 nowrap topmargin=0 rightmargin=0 leftmargin=0 bottommargin=0 noscroll>
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
		}while(rs.next());
	  }
   }  
else
mMarqueeText="NO MESSAGE FOUND";

%>
<table width="100%" bgcolor="#ff8c00">
<tr valign=top>
<td align=left><img src="../Images/JIIT.JPG" width=50 height=50></td>
<td align=left><img src="../Images/SRSHeader1.jpg"><br><MARQUEE style="COLOR: #63756d; FONT-FAMILY: Arial; FONT-SIZE: x-small; FONT-STYLE: normal; FONT-VARIANT: normal; FONT-WEIGHT: bold; HEIGHT: 8px; WIDTH: 560px"    scrolldelay=225><%=mMarqueeText%></MARQUEE>
</td>
<td><%=mNickName%><br>
<A href="SignOut.jsp" target=_parent title="Close/Logout KIOSK Site">
  <font color=green face="Arial" size=2><b>Signout</b></font></A>&nbsp;<br>
</td>
</tr>
</table>
<%
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
 </body>
 </html>