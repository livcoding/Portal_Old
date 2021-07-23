<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
OLTEncryption enc=new OLTEncryption();
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Employee Web Page Title ] </TITLE>
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
</script>
<script language=javascript>
	<!--
	function RefreshContents()
	{
    	document.frm.x.value='ddd';
	document.frm.x.value='ddd';
	}
	//-->
    </script>

<script>
<!--
  if(window.history.forward(1) != null)
  window.history.forward(1);
-->
</script>
</HEAD>
<%
String mMemberID="";
String mMemberType="";
String mMemberCode="",qry="";
String mMCode="";
String mEMCode="";
String mPageTitle="";
String mDPageTitle="";
String mNewTitle="";
String mENewTitle="",mInst="";

DBHandler db=new DBHandler();
ResultSet rs=null,rsi=null;
String mWebEmail="";

if (session.getAttribute("WebAdminEmail")==null)
{
 mWebEmail="";
} 
else
{
 mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
}

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

if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
}

%>
<BODY aLink=#ff00ff bgcolor="#fce9c5" rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 scroll=auto>
<%
if(!mMemberID.equals("") || !mMemberType.equals("") || !mMemberCode.equals(""))
{
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
	//-------------------------------
	//-- Enable Security Page Level  
	//-------------------------------
	qry="Select WEBKIOSK.ShowLink('67','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
	  //----------------------
	  %>
		<form name="frm">
		<input id="x" name="x" type=hidden>
		<TABLE width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
		<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Web Page Heading/Title</b></font><br><font color="#a52a2a" style="FONT-SIZE: small; FONT-FAMILY: fantasy">(Applicable for Employee Page only)</font></td></tr>
		</TABLE>
		
		
<!*********--Institute--************>
<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
<%
	qry="select distinct nvl(institutecode,' ')IC from INSTITUTEMASTER where nvl(DEACTIVE,'N')='N' ";
	rsi=db.getRowset(qry);
	while(rsi.next())
	{
		mInst=rsi.getString("IC");
	}
%>
		<table align=center rules=groups border=2 style="WIDTH: 280px;">
		<br><br><br><tr>
		<td><STRONG>&nbsp;<FONT face=Arial size=2 color=black>Employee Code</FONT></STRONG></FONT></td>
		<%
		if(request.getParameter("x")==null)
		mMCode="";
		else
		mMCode=request.getParameter("EmployeeCode").toString().trim();
		%>
		<td><INPUT ID="EmployeeCode" Name="EmployeeCode" Type="text" value="<%=mMCode%>" style="WIDTH: 100px; HEIGHT: 22px"><FONT color=red>* </FONT>
		<INPUT Type="submit" Value="&nbsp;OK&nbsp;"></td>
		</tr>
		</table>
		</form> 
	<%
		if(request.getParameter("x")!=null)
		{
		if (request.getParameter("EmployeeCode")==null || request.getParameter("EmployeeCode").equals(""))
		{
	  		mMCode="";
			mEMCode="";
		}
		else
		{
			mMCode=request.getParameter("EmployeeCode").toString().trim();
			mEMCode=enc.encode(mMCode);
		}

		
		if(!mMCode.equals(""))
		{
			qry="select nvl(PAGEHEADING,' ') PAGEHEADING,ORAID from membermaster ";
			qry=qry+" where ORACD='"+mEMCode+"' and nvl(DEACTIVE,'N')='N'";
			rs=db.getRowset(qry);
			try
			{
				if(rs.next())
				{	
					if(rs.getString("PAGEHEADING")==null || rs.getString("PAGEHEADING").equals(" "))
					{
						mDPageTitle="No Title";
				   	}
					else
					{
						mPageTitle=rs.getString("PAGEHEADING");
						mDPageTitle=enc.decode(mPageTitle);
					}
		//******Start of Second Table's Scope***********
					
				%>
				<form name="frmm" method=get action="WebPageTitleAction.jsp"> 
				<input id="y" name="y" type=hidden>
					<table align=center rules=groups border=1 style="WIDTH: 500px;">
					<tr>
					<td>&nbsp;<STRONG><FONT face=Arial size=2 color=black>Existing Heading</FONT></STRONG></FONT></td>
					<td><%=mDPageTitle%></td>
					</tr><tr>
					<td>&nbsp;<STRONG><FONT face=Arial size=2 color=black>New Heading</FONT></STRONG></FONT></td>
					<td><INPUT ID="NewTitle" Name="NewTitle" Type="text" style="WIDTH: 300px; HEIGHT: 22px">
					<INPUT Type="submit" Value="Save"> </td>
					</tr>
					
					<%
					if (request.getParameter("NewTitle")==null || request.getParameter("NewTitle").equals(""))
					{
						mNewTitle="";
						mENewTitle="";
						out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Please Enter New Heading/Title</font></b></center>");

					}
					else
					{
						mNewTitle=request.getParameter("NewTitle").toString().trim();
						mENewTitle=enc.encode(mNewTitle);
					}
				%>
				</table>  
					<input type=hidden name='ORACD' id='ORACD' value='<%=mEMCode%>'>
					<input type=hidden name='OLDTITLE' id='OLDTITLE' value='<%=mDPageTitle%>'>
					<input type=hidden name='NewTitle' id='NewTitle' value='<%=mENewTitle%>'>
					<input type=hidden name='INSTITUTECODE' id='INSTITUTECODE' value='<%=mInst%>'>

             			</form> 
				<%	
				//******End of Second Table's Scope***********
				}      // ------------closing of if(rs.next()
				else
				{
				   out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Employee Code not found...</font></b></center>");
				}
			}
			catch(Exception e)
			{
			//	out.print("Error in upper try");
			}
		}   //---------closing of if(!mMCode.equals(""))
		else
		{
		out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Employee Code can't be empty</font></b></center>");
		}

		}  //--------------closing of request.getParameter("x")!=null
 //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	}
	else
	{
   	%>
	<br><font color=red>
	<h3><br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font><br><br><br><br>
  	<%
	}
  //-----------------------------
}
else
{
out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp'>Login</a> to continue</font> <br>");
}
%>
<br><br><br><br><br><br><br><table ALIGN=Center VALIGN=TOP>
		<tr>
		<td valign=middle>
		<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">
		<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
		A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
		<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>  
		</td></tr></table>
</BODY>
</HTML>