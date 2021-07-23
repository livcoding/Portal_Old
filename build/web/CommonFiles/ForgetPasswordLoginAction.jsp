<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %> 
<%
GlobalFunctions gb=new GlobalFunctions();
OLTEncryption enc=new OLTEncryption();
String mHead="",qry="", mWebEmail="";
DBHandler db=new DBHandler();
ResultSet rs=null,rsi=null;
String mInst="",mUserType="",mEnrollment="",mFName="",mDob="",mStudentId="",mPassword="",mFullName="";
String mop="";
String swaid="", answer="",email="";

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
   mHead=session.getAttribute("PageHeading").toString().trim();
else
   mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Password Recovery ] </TITLE>
</head>
<BR><BR><BR><BR><BR><HR>
<%
try
{
if(request.getParameter("InstituteCode")==null)
	mInst="";
else
	mInst=request.getParameter("InstituteCode").toString().trim();

//out.print(mInst);
email=mInst.equals("J128")?"meenakshi.sharma@jiit.ac.in":"deepak.gupta@jiit.ac.in";

if(request.getParameter("UserType")==null)
	mUserType="";
else
	mUserType=request.getParameter("UserType").toString().trim();
if(request.getParameter("EnrollmentNo")==null)
	mEnrollment="";
else
	mEnrollment=request.getParameter("EnrollmentNo").toString().trim();
if(request.getParameter("fname")==null)
	mFName="";
else
	mFName=request.getParameter("fname").toString().trim();
if(request.getParameter("dob")==null)
	mDob="";
else
	mDob=request.getParameter("dob").toString().trim();
if(request.getParameter("option")==null)
	mop="";
else
	mop=request.getParameter("option").toString().trim();

mFullName=mFName.toUpperCase();

if(!mEnrollment.equals("") && mUserType.equals("S") && mop.equals("b"))
{
// ---------------------------------------------------
// Process if Option-1 is applied to recover password
// ---------------------------------------------------

  qry="select studentid from StudentMaster where nvl(ENROLLMENTNO,'*')='"+mEnrollment+"' AND INSTITUTECODE='"+mInst+"'  And (NVL(DEACTIVE,'N')='N' OR (NVL(PROGRAMCOMPLETED,'N')='Y' AND NVL(DEACTIVE,'N')='Y' ))";
  rs=db.getRowset(qry);
  if(rs.next())
  {
	mStudentId=rs.getString("STUDENTID");

	if(request.getParameter("ans")==null)
		answer="";
	else
		answer=request.getParameter("ans").toString().trim();

	answer=answer.toUpperCase();
	
	
	qry="SELECT ANSWER from ASKEDSECRETQUESTION WHERE INSTITUTECODE='"+mInst+"' And MEMBERTYPE='S' and MEMBERID ='"+mStudentId+"'";
	mStudentId=enc.encode(mStudentId);
	rs=db.getRowset(qry);
	if(rs.next())
	{
		swaid=rs.getString("ANSWER");	
		swaid=swaid.toUpperCase();
		if(swaid.equals(answer))
		{
			//-----Recover Password Here
			//--------------------------
			qry="select * from membermaster where ORAID='"+mStudentId+"'";
			//out.print(qry);
			rs=db.getRowset(qry);
			if(rs.next())
			{
				mPassword=rs.getString("ORAPW");
				mPassword=enc.decode(mPassword);
				%>
				<CENTER><font color="green" size="5">Your password is <b><%=mPassword%><b></font></CENTER>
				<center><br><br><br><br>
				Read your password and <a href='../index.jsp'>Login Now/Close this window</a> immediatly for security reason!
				</center>
				<%
			}
			else
		      {
				%>
				<CENTER><font color="red" size="5">You have not signed up for Webkiosk Login! Please contact to System Administrator...</font>
				<br><br><a href='ForgetPasswordLogin.jsp'><font color=red face='verdana'><b>Try More ...</b></font></a></CENTER>
				<%
			 }
		}
		else
		{
	      	%>
			<CENTER><font color="red" size="5">Wrong answer of the secrted question! Try more or go with another option.</font>
			<br><br><a href='ForgetPasswordLogin.jsp'><font color=red face='verdana'><b>Try More ...</b></font></a></CENTER>
			<%
		}
	}
	else
	{
	%>
	<CENTER><font color="red" size="5">You have not submited your secret question to recover the password! Please go with other Option(s)</font></CENTER>
	<br>Please Write a message to <font color=blue><%=email%></font> with following details : -</CENTER>
	<BR>
	<table align=center>
	<tr><td><font color="maroon" size="3">1. Your Full Name</font></td></tr>
	<tr><td><font color="maroon" size="3">2. Father's Full Name</font></td></tr>
	<tr><td><font color="maroon" size="3">3. Date of Birth (format - dd-mm-yyyy)</font></td></tr>
	<tr><td><font color="maroon" size="3">4. Enrollment No.</font></td></tr>
	<tr><td><font color="maroon" size="3">5. Admission Year</font></td></tr>
	<tr><td><font color="maroon" size="3">6. Branch</font></td></tr>
	<tr><td><font color="maroon" size="3">7. Final SGPA/CGPA</font></td></tr>
	</table>
	</font>
      <BR><CENTER><a href=ForgetPasswordLogin.jsp><img src='../Images/Back.jpg' border=0></a></CENTER>
	<%
	}
  }
  else
  {
	%>
	<font color="red" size="4">
	<CENTER>Invalid Enrollment number found!!<br>Please Write a message to <font color=blue><%=email%></font> with following details : -</CENTER>
	<BR>
	<table align=center>
	<tr><td><font color="maroon" size="3">1. Your Full Name</font></td></tr>
	<tr><td><font color="maroon" size="3">2. Father's Full Name</font></td></tr>
	<tr><td><font color="maroon" size="3">3. Date of Birth (format - dd-mm-yyyy)</font></td></tr>
	<tr><td><font color="maroon" size="3">4. Enrollment No.</font></td></tr>
	<tr><td><font color="maroon" size="3">5. Admission Year</font></td></tr>
	<tr><td><font color="maroon" size="3">6. Branch</font></td></tr>
	<tr><td><font color="maroon" size="3">7. Final SGPA/CGPA</font></td></tr>
	</table>
	</font>
      <BR><CENTER><a href=ForgetPasswordLogin.jsp><img src='../Images/Back.jpg' border=0></a></CENTER>
	<%
  }
//-------------- clsoing of option-2
}
else if (!mEnrollment.equals("") && mUserType.equals("S") && mop.equals("a"))
{
//out.print(mInst+" ,"+mUserType+", "+mEnrollment+", "+mFName+","+mDob);
qry="select NVL(STUDENTID,' ')STUDENTID from studentmaster where INSTITUTECODE='"+mInst+"' AND ENROLLMENTNO='"+mEnrollment+"' AND STUDENTNAME='"+mFullName+"' AND DATEOFBIRTH=to_date('"+mDob+"','dd/mm/yyyy')AND (NVL(DEACTIVE,'N')='N' OR (NVL(PROGRAMCOMPLETED,'N')='Y' AND NVL(DEACTIVE,'N')='Y' ))";
//out.print(qry);
rs=db.getRowset(qry);
if(rs.next())
{
mStudentId=rs.getString("STUDENTID");
mStudentId=enc.encode(mStudentId);

//out.print("mStudentId :"+mStudentId);
qry="select * from membermaster where ORAID='"+mStudentId+"'";
//out.print(qry);
rs=db.getRowset(qry);
if(rs.next())
{
mPassword=rs.getString("ORAPW");
mPassword=enc.decode(mPassword);
}
else
{
	%>
	<CENTER><font color="red" size="5">You have not signed up for Webkiosk Login! Please contact to System Administrator...</font></CENTER>
	<%
}
%>

				<CENTER><font color="green" size="5">Your password is <b><%=mPassword%><b></font></CENTER>
				<center><br><br><br><br>
				Read your password and <a href='../index.jsp'>Login Now/Close this window</a> immediatly for security reason!
				</center>
<%
}//if(rs.next())
else
{
	%>
	<font color="red" size="4">
	<CENTER>Your Name and Date of Birth doesn't match with our record!<br>Please Write a message to <font color=blue><%=email%></font> with following details : -</CENTER>
	<BR>
	<table align=center>
	<tr><td><font color="maroon" size="3">1. Your Full Name</font></td></tr>
	<tr><td><font color="maroon" size="3">2. Father's Full Name</font></td></tr>
	<tr><td><font color="maroon" size="3">3. Date of Birth (format - dd-mm-yyyy)</font></td></tr>
	<tr><td><font color="maroon" size="3">4. Enrollment No.</font></td></tr>
	<tr><td><font color="maroon" size="3">5. Admission Year</font></td></tr>
	<tr><td><font color="maroon" size="3">6. Branch</font></td></tr>
	<tr><td><font color="maroon" size="3">7. Final SGPA/CGPA</font></td></tr>
	</table>
	</font>
      <BR><CENTER><a href=ForgetPasswordLogin.jsp><img src='../Images/Back.jpg' border=0></a></CENTER>
	<%
}
}
else
{
	%>
	<font color="red" size="4">
	<CENTER><br>Please Write a message to <font color=blue><%=email%></font> with following details : -</CENTER>
	<BR>
	<table align=center>
	<tr><td><font color="maroon" size="3">1. Your Full Name</font></td></tr>
	<tr><td><font color="maroon" size="3">2. Father's Full Name</font></td></tr>
	<tr><td><font color="maroon" size="3">3. Date of Birth (format - dd-mm-yyyy)</font></td></tr>
	<tr><td><font color="maroon" size="3">4. Enrollment No.</font></td></tr>
	<tr><td><font color="maroon" size="3">5. Admission Year</font></td></tr>
	<tr><td><font color="maroon" size="3">6. Branch</font></td></tr>
	<tr><td><font color="maroon" size="3">7. Final SGPA/CGPA</font></td></tr>
	</table>
	</font>
	<%


}

}
catch(Exception e)
{
}
%>
<hr>
<br>
<table ALIGN=Center VALIGN=TOP>
		<tr><td valign=middle><IMG style="WIDTH: 28px; HEIGHT: 28px" src="../Images/CampusConnectLogo.bmp">
		<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
		A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
		<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>  
		</td></tr></table>

<BODY on aLink=#ff00ff bgcolor="#fce9c5" rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 scroll=auto>
</HTML>
