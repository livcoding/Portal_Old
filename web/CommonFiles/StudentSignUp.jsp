<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %> 
<%
GlobalFunctions gb=new GlobalFunctions();
OLTEncryption enc=new OLTEncryption();
String mHead="",qry="", mInst="", mWebEmail="";
DBHandler db=new DBHandler();
ResultSet rs=null,rsi=null;

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
   mHead=session.getAttribute("PageHeading").toString().trim();
else
   mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Student Sign Up ] </TITLE>

<SCRIPT TYPE="text/javascript">
<!--
// copyright 1999 Idocs, Inc. http://www.idocs.com
// Distribute this script freely but keep this notice in place
function numbersonly(myfield, e, dec)
{
var key;
var keychar;

if (window.event)
   key = window.event.keyCode;
else if (e)
   key = e.which;
else
   return true;
keychar = String.fromCharCode(key);

// control keys
if ((key==null) || (key==0) || (key==8) || 
    (key==9) || (key==13) || (key==27) )
   return true;

// numbers
else if ((("0123456789abcdefghijklmnopqrstuvwxyz").indexOf(keychar) > -1))
   return true;

// decimal point jump
else if (dec && (keychar == "."))
   {
   myfield.form.elements[dec].focus();
   return false;
   }
else
   return false;
}

//-->
</SCRIPT>
<script>
<!--
  if(window.history.forward(1) != null)
  window.history.forward(1);
-->
</script>
<script language=javascript>
	<!--
	function RefreshContents()
	{
    	    document.SignupForm.x.value='ddd';
    	    document.SignupForm.submit();
	}
//-->
</script>

</head>
<%
String mEStudCD="", mStudCD="", mStudID="", mEStudID="", mUType="S", mEUType="", mPass="", mEPass="", mStudEmail="";
String mSName="", mPCode="", mBCode="", mSem="", mERole="", mStudPass="", mEStudPass="", mXYZ="", mComp="";
int mMaxPWD=20;
int mMinPWD=4;
int n1=0, n2=0;
qry="select to_Char(Sysdate,'yymihh') date1 from dual";
rs=db.getRowset(qry);
rs.next();
String mCurrDate=rs.getString("date1");

%>
<BODY aLink=#ff00ff bgcolor="#fce9c5" rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 scroll=auto>
<CENTER>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD align=middle><font color="#a52a2a" style="FONT-SIZE: large; FONT-FAMILY: VERDANA"><B>New User Registration / Sign Up Form</B></font></td></tr>
</TABLE>
<center>
<br>
<form Name="SignupForm" method="post">
<input id="x" name="x" type=hidden>
<table align=center border=2 bordercolordark="Black" bordercolor="Black" bordercolorlight="Black" rules=groups cellpadding=2 cellspacing=20>
<TBODY>
<TR>
<TD><FONT face=Arial size=4 color=black>Institute Code</FONT></td>
<td><SELECT id=Inst style="FONT-SIZE:small;WIDTH:125px;FONT-STYLE:normal;FONT-FAMILY:Arial;HEIGHT:25px;TEXT-ALIGN:center;FONT-VARIANT:normal" name="Inst">
	<OPTION value=JIIT selected>JIIT</OPTION>
      <OPTION value=JPBS>JBS</OPTION>
</SELECT></TD>
</TR>
<tr>
<td><FONT size=4 face=Arial color=black>User Type</FONT></td>
<td><SELECT id=UType style="FONT-SIZE:small;WIDTH:125px;FONT-STYLE:normal;FONT-FAMILY:Arial;HEIGHT:25px;TEXT-ALIGN:center;FONT-VARIANT:normal" name="UType">
	<OPTION selected value=S>Student</OPTION>
</SELECT></TD>
</tr>
<%
	if(request.getParameter("Enroll")!=null)
		mStudCD=request.getParameter("Enroll").toString().trim();
	else
		mStudCD="";
%>
<tr>
<td><FONT size=4 face=Arial color=black>Enrollment No</FONT></td>
<td><FONT face=Arial size=2>  <INPUT style="FONT-WEIGHT: bold; FONT-SIZE: x-small; WIDTH: 123px; FONT-FAMILY: Arial; HEIGHT: 22px" size=11 NAME="Enroll" SIZE=11 MAXLENGTH=10 onKeyPress="return numbersonly(this, event)"></FONT></td>
</tr>
<tr>
<tr><td colspan=2 align=center>
<font color="#ff4500" face="Times New Roman Greek">
<INPUT type="submit" onsubmit="ChkSingleQuot();" id=BTNSubmit style="FONT-SIZE: x-small; WIDTH: 74px; FONT-FAMILY: Arial; HEIGHT: 27px" size =23 value="Submit" name =BTNSubmit tabIndex=5>
<INPUT id=BTNReset type=reset value=Reset name=BTNReset style="FONT-SIZE: x-small; WIDTH: 74px; FONT-FAMILY: Arial; HEIGHT: 27px" size    =18 tabIndex=6> 
</td></tr>
</TBODY>
</table>
<%
try
{
if (request.getParameter("x")!=null) 
{
if(request.getParameter("Inst")!=null)
	mInst=request.getParameter("Inst").toString().trim();
else
	mInst="";
if(request.getParameter("UType")!=null)
	mUType=request.getParameter("UType").toString().trim();
else
	mUType="";
if(request.getParameter("Enroll")!=null)
	mStudCD=request.getParameter("Enroll").toString().trim();
else
	mStudCD="";
mStudCD=gb.replaceSignleQuot(mStudCD);

qry="SELECT nvl(COMPANYTAGGING,' ')COMPANYCODE FROM INSTITUTEMASTER WHERE INSTITUTECODE='"+mInst+"'";
rs=db.getRowset(qry);
//out.print(qry);
if(rs.next())
{
	mComp=rs.getString("COMPANYCODE");
}

if(!mStudCD.equals("") && mUType.equals("S"))
{
   qry="SELECT 'Y' FROM STUDENTMASTER WHERE INSTITUTECODE='"+mInst+"' AND ENROLLMENTNO='"+mStudCD+"'";
   rs=db.getRowset(qry);
   //out.print(qry);
   if(rs.next())
   {
	mXYZ=mStudCD.substring(0,3);  
	mStudPass=mCurrDate+mXYZ;
	mEStudPass=enc.encode(mStudPass);
	mEStudCD=enc.encode(mStudCD);
	mERole=enc.encode("STUD");
	mEUType=enc.encode(mUType);
	qry="SELECT STUDENTID SID, nvl(STUDENTNAME,' ')SName, nvl(PROGRAMCODE,' ')PCode, nvl(BRANCHCODE,' ')BCode, nvl(SEMESTER,0)Sem FROM STUDENTMASTER WHERE INSTITUTECODE='"+mInst+"' AND ENROLLMENTNO='"+mStudCD+"'";
	rs=db.getRowset(qry);
	//out.print(qry);
	if(rs.next())
	{
		mStudID=rs.getString("SID");
		mSName=rs.getString("SName");
		mPCode=rs.getString("PCode");
		mBCode=rs.getString("BCode");
		mSem=rs.getString("Sem");
	}
	mEStudID=enc.encode(mStudID);

	if(!mStudEmail.equals(" ") || !mStudEmail.equals(""))
	{

//----------------------------------------INSERT INTO MEMBERMASTER TABLE---------------------

		qry="SELECT 'Y' FROM MEMBERMASTER WHERE ORAID='"+mEStudID+"' AND ORATYP='"+mEUType+"' AND ORACD='"+mEStudCD+"'";
		rs=db.getRowset(qry);
		//out.print(qry);
		if(!rs.next())
		{
			//-----INSERT DATA HERE-------
			qry="INSERT INTO MEMBERMASTER(ORAID, ORATYP, ORAADM, ORAPW, ORACD, FIRSTLOGIN) VALUES ('"+mEStudID+"', '"+mEUType+"', '"+mERole+"', '"+mEStudPass+"', '"+mEStudCD+"', 'Y')";
			n1=db.insertRow(qry);
		}

		qry="SELECT nvl(STEMAILID,' ') SEMAIL FROM STUDENTPHONE WHERE STUDENTID='"+mStudID+"'";
		rs=db.getRowset(qry);
		//out.print(qry);
		if(rs.next())
		{
			mStudEmail=rs.getString("SEMAIL");
		}

//----------------------------------------INSERT INTO USERREQUEST TABLE---------------------

		qry="SELECT 'Y' FROM USERREQUEST WHERE USERID='"+mStudID+"' AND USERTYPE='"+mUType+"' AND USERCODE='"+mStudCD+"'";
		rs=db.getRowset(qry);
		//out.print(qry);
		if(!rs.next())
		{
			qry="INSERT INTO USERREQUEST(INSTITUTECODE, USERID, USERCODE, PASSWORD, USERTYPE, EMAIL, REQUESTDATE, ACTIVATIONSTATUS, COMPANYCODE) VALUES ('"+mInst+"', '"+mStudID+"', '"+mStudCD+"', '"+mStudPass+"', '"+mUType+"', '"+mStudEmail+"', sysdate, 'N', '"+mComp+"')";
			n2=db.insertRow(qry);
			if(n2>0)
			{
				%><br><LEFT><FONT COLOR=GREEN FACE=VERDANA SIZE=4>&nbsp; Your request has been sent successfully...<BR>Your will be received your 'User ID' and 'Password' on your email soon...</FONT></LEFT><br><%
			}
		}
		else
		{
			%><br><LEFT><FONT COLOR=RED FACE=VERDANA SIZE=4>&nbsp; Request for 'User ID' and 'Password' is already sent!</FONT></LEFT><br><%
		}
	}
	else
	{
		%><br><LEFT><FONT COLOR=RED FACE=VERDANA SIZE=4>&nbsp; Email Id does not exist in our database!</FONT></LEFT><br><%
	}
   }
   else
   {
	%><br><LEFT><FONT COLOR=RED FACE=VERDANA SIZE=4>&nbsp; No such Enrollment No. found!</FONT></LEFT><br><%
   }
}
else
{
	%><br><LEFT><FONT COLOR=RED FACE=VERDANA SIZE=4>&nbsp; Enrollment No. can't be left blank!</FONT></LEFT><br><%
}
}
}
catch(Exception e)
{
	//out.print(e);
}
%>
</FORM>
<hr>
<br>
<table ALIGN=Center VALIGN=TOP>
		<tr><td valign=middle><IMG style="WIDTH: 28px; HEIGHT: 28px" src="../Images/CampusConnectLogo.bmp">
		<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
		A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
		<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>  
		</td></tr></table>

</BODY></HTML>
