<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../CommonFiles/ExceptionHandler.jsp" %>
<%

	/*
	' **********************************************************************************************************
	' *													   *
	' * File Name:	SignUpMemberBulk.JSP		[For Employee]			   *
	' * Author:		Ashok Kumar Singh 						         *
	' * Date:		3rd Nov 2006	 							   *
	' * Version:		1.0									   *
	' **********************************************************************************************************
*/

String qry="";
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();
ResultSet rs=null;
String mQUOTA="",mquota="ALL";

String mMemberID="",mMemberType="",mMemberCode="",mAcad="",mPass="",macad="",mRole="", mInst="",mSem="";
int mMaxPWD=20;
int mMinPWD=5;
try
{
if (session.getAttribute("BASEINSTITUTECODE")==null)
{
	mInst="JIIT";
}
else
{
	mInst=session.getAttribute("BASEINSTITUTECODE").toString().trim();
}
if (session.getAttribute("MinPasswordLength")==null)
{
	mMinPWD=5;
}
else
{
	mMinPWD=Integer.parseInt(session.getAttribute("MinPasswordLength").toString().trim());
}
if (session.getAttribute("MaxPasswordLength")==null)
{
	mMaxPWD=20;
}
else
{
	mMaxPWD=Integer.parseInt(session.getAttribute("MaxPasswordLength").toString().trim());
}

}
catch(Exception e)
{
mMaxPWD=20;
mMinPWD=4;

}

if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
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
	String mHead="";
	if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
		   mHead=session.getAttribute("PageHeading").toString().trim();
	else
		   mHead="JIIT ";
%>
<HTML>
<head>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<TITLE>#### <%=mHead%> [ Student Bulk Signup ] </TITLE>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

</HEAD>
<BODY bgcolor="#fce9c5" rightmargin=5 leftmargin=1 topmargin=1 bottommargin=0 scroll=auto>
<%
try
{

// For Log Entry Purpose
//--------------------------------------
String mLogEntryMemberID="",mLogEntryMemberType="";

if (session.getAttribute("BASELOGINID")==null || session.getAttribute("BASELOGINID").toString().trim().equals(""))
	mLogEntryMemberID="";
else
	mLogEntryMemberID=session.getAttribute("BASELOGINID").toString().trim();

if (session.getAttribute("BASELOGINTYPE")==null || session.getAttribute("BASELOGINTYPE").toString().trim().equals(""))
	mLogEntryMemberType="";
else
	mLogEntryMemberType=session.getAttribute("BASELOGINTYPE").toString().trim();

if (!mLogEntryMemberType.equals(""))
	mLogEntryMemberType=enc.decode(mLogEntryMemberType);

if (!mLogEntryMemberID.equals(""))
	mLogEntryMemberID=enc.decode(mLogEntryMemberID);


//--------------------------------------
String mIPAddress=session.getAttribute("IPADD").toString().trim();
String mLoginIDFrSes="";
if(mInst.equals("JIIT"))
	mLoginIDFrSes="asklJIITADMINaskl";
else if(mInst.equals("JPBS"))
	mLoginIDFrSes="asklJPBSADMINaskl";
else if	(mInst.equals("J128"))
	mLoginIDFrSes="asklJ128ADMINaskl";
else
	mLoginIDFrSes="asklADMINaskl";
//out.print(mLogEntryMemberID+" - "+mLoginIDFrSes);
	if(mLogEntryMemberID.equals(mLoginIDFrSes) && mLogEntryMemberType.equals("A"))

	{


%>
<center><U><FONT face='arial' color=darkbrown size=4>New Students Signup Screen </FONT></U>
<TABLE cellSpacing=2 cellPadding=3 width="100%" border=2 rules="groups" bordercolor=black>
  <TR style="BACKGROUND-COLOR: maroon">
    <TD><FONT style="BACKGROUND-COLOR: #800000" face=arial color=ivory>Role To be Assigned</FONT></TD>
    <TD colspan=4><FONT style="BACKGROUND-COLOR: #800000" face=arial color=snow>Criteria for Students - All or Selected</FONT></TD></TR>
  <TR>
  <form name=frm1 action="AdminLinkNewAdmissionAction.jsp" method=post>
<input id="x" name="x" type=hidden>
<td><b> Role to be assigned</b>
<%
qry="select RoleName,nvl(ROLEDESCRIPTION,'ROLENAME') ROLEDESCRIPTION,nvl(rolename,' ')||' ('|| nvl(ROLEDESCRIPTION,'ROLENAME')||')' roledesc ";
qry=qry+" from webkioskrolemaster where nvl(deactive,'N')='N' and ROLEFORMEMBERTYPE='S'";
rs=db.getRowset(qry);
%>
<select style="WIDTH: 155px;" name=RoleName id=RoleName>

<%
if(request.getParameter("x")==null)
	{
		while(rs.next())
		{
			mRole=rs.getString("RoleName");
			if(mRole.equals(""))
			{
		//	macad=mAcad;
		%>
		   <OPTION  selected value=<%=rs.getString("RoleName")%>><%=rs.getString("roledesc")%></OPTION>
		<%
			}
			else
			{
		%>
		    <OPTION  value=<%=rs.getString("RoleName")%>><%=rs.getString("roledesc")%></OPTION>

		<%
			}
		}
	 }
	else
	{	while(rs.next())
		{
			mRole=rs.getString("RoleName");
			if(mRole.equals(request.getParameter("RoleName").toString().trim()))
			{
			%>
			  <OPTION  selected value=<%=rs.getString("RoleName")%>><%=rs.getString("roledesc")%></OPTION>
			<%
			}
			else
			{
			%>
			  <OPTION   value=<%=rs.getString("RoleName")%>><%=rs.getString("roledesc")%></OPTION>
			<%
			}
		}
	}

	%>
	</SELECT>
</td>
<td>
<b>Academic Year</b>
<select style="WIDTH: 155px;" name=Academicyear id=Academicyear>
<%
	qry="select academicyear academicyear  from ACADEMICYEARMASTER where nvl(deactive,'N')='N' and institutecode='"+mInst+"'";

//-----Commented by Rituraj
	//qry="select max(academicyear)academicyear  from ACADEMICYEARMASTER where nvl(deactive,'N')='N'  ";
	//qry=qry+" union select max(academicyear)academicyear  from ACADEMICYEARMASTER where nvl(deactive,'N')='N'  and ";
 	//qry=qry+" academicyear<(select max(academicyear)academicyear  from ACADEMICYEARMASTER where nvl(deactive,'N')='N'   ) order by academicyear desc ";
//-------------------------

	rs=db.getRowset(qry);
	if(request.getParameter("x")==null)
	{
		while(rs.next())
		{
			mAcad=rs.getString("academicyear");
			if(macad.equals(""))
			{
			macad=mAcad;
		%>
		   <OPTION  selected value=<%=rs.getString("academicyear")%>><%=rs.getString("academicyear")%></OPTION>
		<%
			}
			else
			{
		%>
			   <OPTION   value=<%=rs.getString("academicyear")%>><%=rs.getString("academicyear")%></OPTION>
		<%
			}
		}
	 }
	else
	{	while(rs.next())
		{
			mAcad=rs.getString("academicyear");
			if(mAcad.equals(request.getParameter("Academicyear").toString().trim()))
			{ macad=mAcad;
			%>
			<OPTION  selected value=<%=rs.getString("academicyear")%>><%=rs.getString("academicyear")%></OPTION>
			<%
			}
			else
			{
			%>
			<OPTION  value=<%=rs.getString("academicyear")%>><%=rs.getString("academicyear")%></OPTION>
			<%
			}
		}
	}
	%>
	</SELECT>
</td>



<td>
<b>Semester</b>
<select style="WIDTH: 155px;" name=Semester id=Semester>
<%
        qry="select  distinct   semester from  studentmaster where institutecode='"+mInst+"' and semester is not null order by semester asc";
	//qry="select distinct academicyear  from ACADEMICYEARMASTER where nvl(deactive,'N')='N' and institutecode='"+mInst+"'";

//-----Commented by Rituraj
	//qry="select max(academicyear)academicyear  from ACADEMICYEARMASTER where nvl(deactive,'N')='N'  ";
	//qry=qry+" union select max(academicyear)academicyear  from ACADEMICYEARMASTER where nvl(deactive,'N')='N'  and ";
 	//qry=qry+" academicyear<(select max(academicyear)academicyear  from ACADEMICYEARMASTER where nvl(deactive,'N')='N'   ) order by academicyear desc ";
//-------------------------

	rs=db.getRowset(qry);
	if(request.getParameter("x")==null)
	{
		while(rs.next())
		{
			mSem=rs.getString("semester");
			if(mSem.equals(""))
			{
			mSem=mSem;
		%>
		   <OPTION  selected value=<%=rs.getString("semester")%>><%=rs.getString("semester")%></OPTION>
		<%
			}
			else
			{
		%>
			   <OPTION   value=<%=rs.getString("semester")%>><%=rs.getString("semester")%></OPTION>
		<%
			}
		}
	 }
	else
	{	while(rs.next())
		{
			mSem=rs.getString("semester");
			if(mSem.equals(request.getParameter("Semester").toString().trim()))
			{ mSem=mSem;
			%>
			<OPTION  selected value=<%=rs.getString("semester")%>><%=rs.getString("semester")%></OPTION>
			<%
			}
			else
			{
			%>
			<OPTION  value=<%=rs.getString("semester")%>><%=rs.getString("semester")%></OPTION>
			<%
			}
		}
	}
	%>
	</SELECT>
</td>










<td>
<b>Quota</b>
<select style="WIDTH: 155px;" name="QUOTA" id="QUOTA">
<%
	qry="SELECT distinct nvl(QUOTA,' ')QUOTA  FROM STUDENTMASTER where nvl(deactive,'N')='N' and institutecode='"+mInst+"' order by quota";

//-----Commented by Rituraj
	//qry="select max(academicyear)academicyear  from ACADEMICYEARMASTER where nvl(deactive,'N')='N'  ";
	//qry=qry+" union select max(academicyear)academicyear  from ACADEMICYEARMASTER where nvl(deactive,'N')='N'  and ";
 	//qry=qry+" academicyear<(select max(academicyear)academicyear  from ACADEMICYEARMASTER where nvl(deactive,'N')='N'   ) order by academicyear desc ";
//-------------------------

	rs=db.getRowset(qry);
	if(request.getParameter("x")==null)
	{
		while(rs.next())
		{
			mQUOTA=rs.getString("QUOTA");
			if(mquota.equals("ALL"))
			{
			mquota=mQUOTA;
		%>
		   <OPTION  selected value="ALL">ALL</OPTION>
		<%
			}
			else
			{
		%>
			   <OPTION   value="<%=rs.getString("QUOTA")%>"><%=rs.getString("QUOTA")%></OPTION>
		<%
			}
		}
	 }
	else
	{

		if("ALL".equals(request.getParameter("QUOTA").toString().trim()))
 		{
			%>
			<OPTION selected Value="ALL">ALL</option>
			<%
		}
		else
		{
			%>
			<OPTION Value ="ALL">ALL</option>
			<%
		}
		while(rs.next())
		{
			mQUOTA=rs.getString("QUOTA");
			if(mQUOTA.equals(request.getParameter("QUOTA").toString().trim()))
			{ mquota=mQUOTA;
			%>
			<OPTION  selected value="<%=rs.getString("QUOTA")%>"><%=rs.getString("QUOTA")%></OPTION>
			<%
			}
			else
			{
			%>
			<OPTION  value="<%=rs.getString("QUOTA")%>"><%=rs.getString("QUOTA")%></OPTION>
			<%
			}
		}
	}
	%>
	</SELECT>

</td>
	<tr>
	<TD>
      <INPUT id=ChkAllSudent type=radio checked name=ChkAllSudent title='LoginID for All Students' value =A>Login for all Students
      &nbsp;<font color=red><b>or</b></font>&nbsp;<br>
	<INPUT id=ChkAllSudent title='For selected Students-Program wise' type=radio value=S name=ChkAllSudent>
      Selected Students-Program based only
      <br>
	&nbsp;<input type="Submit" value="Create LoginID Now" name=btn1>
<br><font color=red>*</font><font color=green>Password Length must be between <%=mMinPWD%> to <%=mMaxPWD%></font>
	</td>
	<td colspan=3>
	<SELECT id=ProgramCode style="WIDTH: 750px; HEIGHT: 200px" multiple size=2 name=ProgramCode>
	<%
	qry="Select PROGRAMCODE, PROGRAMNAME from ProgramMaster where INSTITUTECODE='"+mInst+"' and nvl(DEACTIVE,'N')='N' order by PROGRAMNAME ";
	rs=db.getRowset(qry);
	while(rs.next())
	{
	%>
	<OPTION value=<%=rs.getString("PROGRAMCODE")%>><%=rs.getString("PROGRAMNAME")%>-<%=rs.getString("PROGRAMCODE")%></OPTION>
	<%
	}
	%>
	</SELECT>
	</TD>

	</TR>
	</form>
  </TABLE></P>
<%
}
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
  }
}
catch(Exception e)
{
//out.print("abcd"+qry);
}
%>
<hr><table ALIGN=Center VALIGN=TOP>
	<tr>
		<td valign=middle>
		<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">	<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT>
		</td>
	</tr>
	</table>
</body>
</html>

