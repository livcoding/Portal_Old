<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="TIET ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Student Reaction Survey Submition Count ] </TITLE>
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
    	    document.frm.submit();
	}
//-->
</script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
String qry="",mWebEmail="";
String myLTP="",mChkvalue="";
int mSNO=0;
String mMemberID="";
String mMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mSRSEventCode="";
int mCounter=0;
String mDate1="";
String mDate2="";
String msrseventcode="";
String mCurDate1="";


qry="select to_Char(Sysdate,'dd-mm-yyyy') date1 from dual";
rs=db.getRowset(qry);
rs.next();
mCurDate1=rs.getString(1);

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

if (session.getAttribute("MemberName")==null)
{
	mMemberName="";
}
else
{
	mMemberName=session.getAttribute("MemberName").toString().trim();
}

if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
}

OLTEncryption enc=new OLTEncryption();

try
{
if(!mMemberID.equals("") && !mMemberType.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
{
	try
	{	
		mDMemberCode=enc.decode(mMemberCode);
	}
	catch(Exception e)
	{
		
	}

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('49','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------

%>
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<table width="100%" ALIGN=CENTER border=0 bottommargin=0  topmargin=0>
<tr><td align=center><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Datewise SRS Count</b></font></td></tr></table>
<table width="100%" ALIGN=CENTER border=3 bottommargin=0  topmargin=0>
<tr>
<!--SRSEventCode****-->
 <td nowrap colspan=2><FONT color=black><FONT face=Arial size=2><STRONG>SRS Event Code</STRONG></FONT></FONT>
<%
	 qry=" Select Distinct nvl(SRSEventCode,' ') SRSEVENTCODE,entrydate from srseventmaster where srseventcode in ( ";
	qry=qry+" Select Distinct nvl(SRSEventCode,' ') SRSEVENTCODE from SRSEVENTS Where nvl(Deactive,'N')='N' )";
	qry=qry+" order by entrydate desc ";
	rs=db.getRowset(qry);
	if (request.getParameter("x")==null)
	{
		%>
		<select name=SRSEventCode tabindex="0" id="SRSEventCode" style="WIDTH: 150px">	
		<%   
		while(rs.next())
		{
			mSRSEventCode=rs.getString("SRSEVENTCODE");
			if(msrseventcode.equals(""))
			{
 			msrseventcode=mSRSEventCode;
			%>
			<OPTION selected Value =<%=mSRSEventCode%>><%=mSRSEventCode%></option>
			<%			
			}
			else
			{
				%>
			<OPTION  Value =<%=mSRSEventCode%>><%=mSRSEventCode%></option>
			<%			
			}
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name=SRSEventCode tabindex="0" id="SRSEventCode" style="WIDTH: 150px">	
		<%
		while(rs.next())
		{
			mSRSEventCode=rs.getString("SRSEventCode");
			if(mSRSEventCode.equals(request.getParameter("SRSEventCode").toString().trim()))
 			{
				msrseventcode=mSRSEventCode;
				%>
				<OPTION selected Value =<%=mSRSEventCode%>><%=mSRSEventCode%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mSRSEventCode%>><%=mSRSEventCode%></option>
		      	<%			
		   	}
		}
		%>
		</select>
	  	<%
	 }    

if (request.getParameter("x")!=null)
	
	{
		mDate1=mDate1=request.getParameter("MDATE1").toString().trim();
		mDate2=request.getParameter("MDATE2").toString().trim();

	}
else
{
mDate1=mCurDate1;
mDate2=mCurDate1;
}

%>

&nbsp;<b>SRS From (<font color=green size=1>DD-MM-YYYY</font>)&nbsp;</b><INPUT TYPE="TEXT" NAME=MDATE1 size=9 ID=MDATE1 VALUE=<%=mDate1%> maxlength=10> <b>to </b>
<INPUT TYPE="TEXT" NAME=MDATE2 size=9 ID=MDATE2 VALUE=<%=mDate2%> maxlength=10>
<INPUT TYPE="submit" NAME=btn1 ID=btn1 VALUE=Refresh> 
</TD>
</tr>
</form>
</TABLE>

<%
if (request.getParameter("SRSEventCode")!=null)
	msrseventcode=request.getParameter("SRSEventCode").toString().trim();
if (request.getParameter("MDATE1")!=null)
	mDate1=request.getParameter("MDATE1").toString().trim();
if (request.getParameter("MDATE2")!=null)
	mDate2=request.getParameter("MDATE2").toString().trim();


if (GlobalFunctions.iSValidDate(mDate1)==true && GlobalFunctions.iSValidDate(mDate2))
{
  qry="select To_char(entrydate,'dd-mm-yyyy'),Count(distinct studentid),trunc(Entrydate) from SRSEventSuggestion Where SRSEVEntCode='"+ msrseventcode +"'";
  qry=qry=qry+" and trunc(entrydate) between to_date('"+mDate1 +"','dd-MM-yyyy') and To_date('"+mDate2 +"','DD-MM-yyyy')";
  qry=qry=qry+"  Group by Trunc(EntryDate),To_char(entrydate,'dd-mm-yyyy') order by 3";
//   out.print(qry);
  rs=db.getRowset(qry);
  long mTot=0;
	int kk=0;
	%>
	<center>
	<table border=1>	<br><br><tr bgcolor=#ff8c00>
	
		<td><font color=white><b>SRS Date</b></td>
		<td><font color=white><b>No. of Students Responded</b></td>
		</tr>
	<%
		while(rs.next())
		{
			%>
			<tr><td><%=rs.getString(1)%></td>
				<td align=right><%=rs.getLong(2)%></td>
			</tr>
			<%
			mTot=mTot+rs.getLong(2);
		}


	%><tr><td colspan=2 align=right><b>Total: <%=mTot%></b></td></tr>
		<TR><TD COLSPAN=2 ALIGN=CENTER><b>Click to print Now</b>&nbsp; &nbsp; <a onClick="window.print();"><img  src=../../Images/printer.gif border=0></a></TD><TR>
	</table>





		
	<%

}  // if valide date then
else
{

	out.print("<br><img src='../../Images/Error1.jpg'>"+" Invalid Date<br>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Valid Date Format: DD-MM-YYYY</font> <br>");


}

 //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
  }
  else
   {
   %>
	<br>
	<font color=red>
	<h3>	<br><img src='../../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font>	<br>	<br>	<br>	<br>
   <%
	
	
   }


  //-----------------------------
}
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
}		
catch(Exception e)
{
}
%>

<table ALIGN=Center VALIGN=TOP>
		<tr>
		<td valign=middle><br>

<br>
		<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">
		<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
		A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
		<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>  
		</td></tr></table>
</body>
</html>