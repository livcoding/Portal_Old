<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<% 
/*
	' **********************************************************************************************************
	' * File Name:	SalaryDetails.jsp		[For Employee]						           *
	' * Author:		Ashok Kumar Singh 							           *
	' * Date:		1st Feb 2008								   *
	' * Version:	2.0								   *	
	' **********************************************************************************************************	
*/

String msm="",msmv="",sql="";
int i=0,j=0;
String mComp="UNIV";
String mStudCode="",mEStudCode="",mStudType="",mEStudType="",mStudEmail="",mStudID="",mEStudID="";
String mMemberID="", mDMemberID="",mIndentDate="",mDesignation="";
String mMemberType="", mDMemberType="", mMemberCode="", mDMemberCode="";
String mMemberName="", mDept="", mDegs="",mDesignation1="";
String mInstitute="",mInst="",mtext="",mCurrDate="";
String mDepartment1="";
String mLeaveCode="",mFromDate="",mToDate="";
String qry="select to_Char(Sysdate,'dd-mm-yyyy') date1  from dual";
DBHandler db=new DBHandler(); 
ResultSet rs=null,rst=null;
rs=db.getRowset(qry);
rs.next();
mCurrDate=rs.getString("date1");

if (session.getAttribute("MemberID")==null)
	mMemberID="";
else
	mMemberID=session.getAttribute("MemberID").toString().trim();
	
if (session.getAttribute("MemberType")==null)
	mMemberType="";
else
	mMemberType=session.getAttribute("MemberType").toString().trim();

if (session.getAttribute("MemberName")==null)
	mMemberName="";
else
	mMemberName=session.getAttribute("MemberName").toString().trim();
if (session.getAttribute("MemberCode")==null)
	mMemberCode="";
else
	mMemberCode=session.getAttribute("MemberCode").toString().trim();

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<Html>
<head>
<title>Undelivered Webkiosk ID & Password</title> 
<script language=javascript>
<!--
function funNulChk()
{ 	
	if(document.frm.enroll.value=='')
	{
		alert('Enrollment No. can't be left blank!');
	}
}
//-->
</script>
</head>
<body  topmargin=0 rightmargin=0 leftmargin=0 bottommargin=0 bgColor=#fce9c5>
<%
try
{
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{
		OLTEncryption enc=new OLTEncryption();
		mDMemberID=enc.decode(mMemberID);
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);
		%>
		<form name="frm" method="post">
		<input id="x" name="x" type=hidden>
		<table ALIGN=CENTER bottommargin=0 topmargin=0>
		<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">Undelivered Webkiosk ID & Password</font></td></tr>
		</table>
		<table cellpadding=5 align=center rules=groups border=2>
		<%
		if(request.getParameter("enroll")==null)
			mStudCode="";
		else
			mStudCode=request.getParameter("enroll").toString().trim();
		if(request.getParameter("email")==null)
			mStudEmail="";
		else
			mStudEmail=request.getParameter("email").toString().trim();
		%>
		<tr><td align=center nowrap><B><Font size=2 color=navy face=arial>Enter Enrollment No. </font></B>&nbsp;<input type=text name="enroll" value="<%=mStudCode%>" size=12>&nbsp; &nbsp;<B><Font size=2 color=navy face=arial>Email ID </font></B>&nbsp;<input type=text name="email" value="<%=mStudEmail%>" size=12>&nbsp; &nbsp;<input type=submit value="OK" onclick="funNulChk()"></td></tr>
		</table>
		</form>
		<%
		if(request.getParameter("x")!=null)
		{
			if(request.getParameter("enroll")==null)
				mStudCode="";
			else
				mStudCode=request.getParameter("enroll").toString().trim();

			if(request.getParameter("email")==null)
				mStudEmail="";
			else
				mStudEmail=request.getParameter("email").toString().trim();

			if(!mStudCode.equals(""))
				mEStudCode=enc.encode(mStudCode);
	
			if(!mEStudCode.equals("") && !mStudEmail.equals(""))
			{
				qry="Select nvl(ORAID,' ')ORAID, nvl(ORATYP,' ')ORATYP from membermaster where ORACD='"+mEStudCode+"'";
				rs=db.getRowset(qry);
				//out.print(qry);
				if(rs.next())
				{
					mEStudType=rs.getString("ORATYP");
					mStudType=enc.decode(mEStudType);
					if(mStudType.equals("S"))
					{
						qry="Update MEMBERMASTER SET EMAIL='"+mStudEmail+"', STATUS='N' where ORACD='"+mEStudCode+"'";
						//out.print(qry);
						int n=db.update(qry);
						if(n>0)
						{
							out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Green'>Email ID Updated...</font> <br>");
						}
					}
				}
				else
				{
					out.print("<br><img src='../../Images/Error1.gif'>");
					out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Invalid Enrollment No.</font> <br>");
				}
			}
			else
			{
				out.print("<br><img src='../../Images/Error1.gif'>");
				out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Enrollment No or Email Id can't be left blank!</font> <br>");
			}      
		}
	}
	else
	{
		out.print("<br><img src='../../Images/Error1.gif'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}      
}
catch(Exception e)
{
	out.print("error");
}
%>
<br>
<center><p align=center>
&nbsp;&nbsp;&nbsp;<HR align=center color=black noshade scrollleft="10" style="BACKGROUND-POSITION-X: 10px; HEIGHT: 2px; VERTICAL-ALIGN: middle; WIDTH: 650px">
<br>
<FONT size =5 style="FONT-FAMILY: cursive">
<b>Campus Connect</b></FONT>&nbsp;&nbsp;<FONT size =2  face=cursive> ... an <b>IRP</b> Solution<br>
A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
</body>
</Html>