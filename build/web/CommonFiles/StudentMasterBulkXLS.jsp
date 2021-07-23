<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../CommonFiles/ExceptionHandler.jsp" %>
<%
try
{  //1
DBHandler db=new DBHandler();
ResultSet rs6=null;
OLTEncryption enc=new OLTEncryption();
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
String mInst="";
int mFlag=0;
String qryt="",mTs="";
ResultSet rst=null;
int kk=0;
String qry6="";
String mStrInst="", mStrAcademicYear="", mStrProgramCode11="", mStrBranchCode11="", mStrExamCode11="",mQuota11="",inst="";

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
if (session.getAttribute("BASEINSTITUTECODE")==null)
{
	mInst="JIIT";
}
else
{
	mInst=session.getAttribute("BASEINSTITUTECODE").toString().trim();
}
	String mHead="";
	if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
		   mHead=session.getAttribute("PageHeading").toString().trim();
	else
		   mHead="JIIT";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Student Master Bulk XLS ] </TITLE>
<script language="JavaScript" type ="text/javascript">
<!--
  if (top != self) top.document.title = document.title;
-->
</script>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%@page contentType="text/html"%>
	   	<%
		response.setContentType("application/vnd.ms-excel");
		%>
<form name="save" >
<!-- <table align=center>
<tr><td><U><FONT  face='arial' color=darkbrown size=4>Student Password Creation.</FONT></U>
</td></tr>
</table> -->
<hr>
<h1><font size=3>Student Master Bulk File Generated.</font></h1>
<!--Institute-->
<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
<%
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
else
	mLoginIDFrSes="asklJ128ADMINaskl";
         //out.print("anoop----"+mLogEntryMemberID+"------hii---"+mLoginIDFrSes);
	//if(mLogEntryMemberID.equals(mLoginIDFrSes) && mLogEntryMemberType.equals("A"))
int i=1;
       if(i==1)
	{ //2

//if(request.getParameter("StdPwd").toString().trim().length()>=mMinPWD && request.getParameter("StdPwd").toString().trim().length()<=mMaxPWD )
//{
	try
	{
	if (session.getAttribute("mStrInst") == null)
            {
                mStrInst = "";
            }
        else
            {
                mStrInst = session.getAttribute("mStrInst").toString().trim();
            }
        if (session.getAttribute("mStrAcademicYear") == null)
            {
                mStrAcademicYear = "";
            }
        else
            {
                mStrAcademicYear = session.getAttribute("mStrAcademicYear").toString().trim();
            }
        if (session.getAttribute("mStrProgramCode11") == null)
            {
                mStrProgramCode11 = "";
            }
        else
            {
                mStrProgramCode11 = session.getAttribute("mStrProgramCode11").toString().trim();
            }
        if (session.getAttribute("mStrBranchCode11") == null)
            {
                mStrBranchCode11 = "";
            }
        else
            {
                mStrBranchCode11 = session.getAttribute("mStrBranchCode11").toString().trim();
            }
         if (session.getAttribute("mStrExamCode11") == null)
            {
                mStrExamCode11 = "";
            }
        else
            {
                mStrExamCode11 = session.getAttribute("mStrExamCode11").toString().trim();
            }
        if (session.getAttribute("mQuota11") == null)
            {
                mQuota11 = "";
            }
        else
            {
                mQuota11 = session.getAttribute("mQuota11").toString().trim();
            }
        if (session.getAttribute("inst") == null)
            {
                inst = "";
            }
        else
            {
                inst = session.getAttribute("inst").toString().trim();
            }



	%>

	<TABLE cellSpacing=1 cellPadding=1  border=1 rules="groups" align=center bordercolor=black>
				<thead>
				<TR >
				<td><FONT face=arial color=black><B>Sno</b></font></td>
				<TD><FONT face=arial color=black><B>Institute Code</B></FONT></TD>
				<TD><FONT face=arial color=black><B>Academic Year</B></FONT></TD>
				<TD><FONT face=arial color=black><B>Enrollment No</FONT></TD>
                                <TD><FONT face=arial color=black><B>Student Name</FONT></TD>
				<TD><FONT face=arial color=black><B>Program Code</FONT></TD>
	                        <TD><FONT face=arial color=black><B>Branch Code</FONT></TD>
                                <TD><FONT face=arial color=black><B>Subsection Code</FONT></TD>
                                <TD><FONT face=arial color=black><B>Semester</B></FONT></TD>
				<TD><FONT face=arial color=black><B>Deactive</B></FONT></TD>
				<TD><FONT face=arial color=black><B>Date of Birth</FONT></TD>
                                <TD><FONT face=arial color=black><B>Father Name</FONT></TD>
				<TD><FONT face=arial color=black><B>Quota</FONT></TD>
	                        <TD><FONT face=arial color=black><B>Reg Confirmation</FONT></TD>
                                <TD><FONT face=arial color=black><B>Phone Number</FONT></TD>
                                <TD><FONT face=arial color=black><B>Mail ID</FONT></TD>
                                <TD><FONT face=arial color=black><B>Current Address</FONT></TD>
				<TD><FONT face=arial color=black><B>Permanent Address</FONT></TD>
	                        <TD><FONT face=arial color=black><B>Exam Code</FONT></TD>
                                <TD><FONT face=arial color=black><B>Gender</FONT></TD>
				<TR>
				</thead>
	<%
		
		       qry6="select distinct NVL(A.INSTITUTECODE,'')  INSTITUTECODE,NVL(A.ACADEMICYEAR,'') ACADEMICYEAR,NVL(A.ENROLLMENTNO,'N/A') ENROLLMENTNO,NVL(A.STUDENTNAME,'') STUDENTNAME";
                       qry6=qry6+",NVL(A.PROGRAMCODE,'') PROGRAMCODE,NVL(A.BRANCHCODE,'') BRANCHCODE,NVL(A.SUBSECTIONCODE,'N/A') SUBSECTIONCODE,NVL(A.SEMESTER,'') SEMESTER,NVL( A.DEACTIVE,'N' )  DEACTIVESTATUS,";
                       qry6=qry6+"to_char(A.DATEOFBIRTH,'dd-mm-yyyy') DATEOFBIRTH,NVL(A.FATHERNAME,'') FATHERNAME,NVL(A.QUOTA,'') QUOTA,NVL(B.REGCONFIRMATION,'N/A') REGISTRATIONCONFIRMATION ,NVL(C.STCELLNO,'')";
                       qry6=qry6+" STUDENTPHONENUMBER,NVL(C.STEMAILID,'') STUDENTEMAILID ,D.CADDRESS1||','||D.CADDRESS2||','||D.CADDRESS3||','||D.CDISTRICT||','";
                       qry6=qry6+"||D.CSTATE AS CURRENTADDRESS,D.PADDRESS1||','||D.PADDRESS2||','||D.PADDRESS3||','||D.PDISTRICT||','||D.PSTATE AS PURMANENTADDRESS,";
                       qry6=qry6+" NVL(B.EXAMCODE,'') EXAMCODE, NVL(A.SEX,'') SEX  from studentmaster A,STUDENTREGISTRATION B , STUDENTPHONE C ,STUDENTADDRESS D where A.INSTITUTECODE IN ("+session.getAttribute("mStrInst").toString()+") AND";
                       qry6=qry6+" A.ACADEMICYEAR IN ("+session.getAttribute("mStrAcademicYear").toString()+") AND  A.PROGRAMCODE IN ("+session.getAttribute("mStrProgramCode11").toString()+") AND  A.BRANCHCODE IN ("+session.getAttribute("mStrBranchCode11").toString()+")  AND";
                       qry6=qry6+"     b.EXAMCODE IN ("+session.getAttribute("mStrExamCode11").toString()+") AND   A.QUOTA IN ("+session.getAttribute("mStrQuota11").toString()+")  ";
                         if(session.getAttribute("gender") != null)
                             {
                                    qry6=qry6+" AND A.SEX='"+session.getAttribute("gender").toString().trim()+"'";
                             }
                        if(session.getAttribute("deactive") != null)
                             {
                                   qry6=qry6+" AND  NVL(A.DEACTIVE,'N')='"+session.getAttribute("deactive").toString().trim()+"'";
                             }
                        if(session.getAttribute("regConfirmation") != null)
                              {
                                   qry6=qry6+" AND b.regconfirmation='"+session.getAttribute("regConfirmation").toString().trim()+"'";
                              }
                       qry6=qry6+" AND  A.STUDENTID =B.STUDENTID";
                       qry6=qry6+" AND A.STUDENTID =C.STUDENTID(+) AND A.STUDENTID =D.STUDENTID(+) AND A.ACADEMICYEAR=B.ACADEMICYEAR";
		rs6=db.getRowset(qry6);
//out.print(qry);
		while (rs6.next())
		{
			kk++;
			%>

				<tr>
					<td ><%=kk%>.</td>
					<td ><%=rs6.getString(1)%></td>
					<td ><%=rs6.getString(2)%></td>
                                        <td ><%=rs6.getString(3)%></td>
					<td ><%=rs6.getString(4)%></td>
					<td ><%=rs6.getString(5)%></td>
					<td ><%=rs6.getString(6)%></td>
                                        <td ><%=rs6.getString(7)%></td>
                                        <td ><%=rs6.getString(8)%></td>
					<td ><%=rs6.getString(9)%></td>
                                        <td ><%=rs6.getString(10)%></td>
					<td ><%=rs6.getString(11)%></td>
					<td ><%=rs6.getString(12)%></td>
					<td ><%=rs6.getString(13)%></td>
                                        <td ><%=rs6.getString(14)%></td>
                                        <td ><%=rs6.getString(15)%></td>
					<td ><%=rs6.getString(16)%></td>
                                        <td ><%=rs6.getString(17)%></td>
					<td ><%=rs6.getString(18)%></td>
					<td ><%=rs6.getString(19)%></td>
					</tr>

			<%
		}







	}
	catch(Exception e)
	{
	//	out.print(qry+"error");
	}
	%>


</form>
	<%
/*}
else
{
out.print("<br><img src='../../Images/Error1.jpg'>");
out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Password length must be between "+mMinPWD+ " to " +mMaxPWD +" </font> <br>");
out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'><a href='SignUpStudents.jsp'><img src='../../Images/Back.jpg' border=0></a></font> <br>");

}*/

}  //2
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
}
}	//1
catch(Exception e)
{
	//out.print("dddd");
}
%>
</body>
</html>