<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
 <% 
/*	' **********************************************************************************************************
	' *													   *
	' * File Name:	StudentMedicalHistoryByAdmin.jsp		[For Students]						           *
	' * Author:		Vijay Kumar							           *
	' * Date:		14th JUL 2009						   *
	' * Version:	1.0							   *
	' * Description:	Student Medical History
	' **********************************************************************************************************
*/
%>
<html>
<head>
<TITLE>#### <%=mHead%> [ View/Edit Student Medical History] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<style fprolloverstyle>A:hover {color: #FF0000; font-size: 14pt; font-weight: bold}
</style>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<% 
String dd1="";
String qry="";
String mMemberID="";
String mMemberType="", mInst="";
String mMemberCode="", mMemberName="", mDMemberCode="", mSID="", mName="", mMsg="";
ResultSet rs=null,rs1=null;
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();

if (request.getParameter("SID")==null)
{
	mSID="";
}
else
{
	mSID=request.getParameter("SID").toString().trim();
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
if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}

if(!mMemberID.equals("") && !mMemberType.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
{  //2

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mMacAddress =" "; //session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
	  //-----------------------------
	  //-- Enable Security Page Level  
	  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('248','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
		%>		
		<form name=frm id=frm Action="StudentMedicalHistoryActionByAdmin.jsp">
		<input id="x" name="x" type=hidden>
		<input id="SID" name="SID" type=hidden value="<%=mSID%>">
			<%
			if(request.getAttribute("message")==null)
				mMsg="";
			else
				mMsg=(String)request.getAttribute("message");
			if(mMsg.equals("Msg1"))
			{
				%>
				<CENTER><b><font size=3 face='Arial' color='Green'>Medical Form is submitted successfully...</font></b><br><br></CENTER>
				<%
			}
			else if(mMsg.equals("Msg2"))
			{
				%>
				<CENTER><b><font size=3 face='Arial' color='Green'>Medical Form is updated successfully...</font></b><br><br></CENTER>
				<%
			}
		  //----------------------
		try
		{	
			mDMemberCode=enc.decode(mMemberCode);
			mMemberID=enc.decode(mMemberID);
			mMemberType=enc.decode(mMemberType);
		}
		catch(Exception e)
		{
			out.println(e.getMessage());
		}


			qry = "SELECT ENROLLMENTNO ENROLLMENTNO,STUDENTNAME STUDENTNAME FROM STUDENTMASTER where StudentId='"+mSID+"'";
			//out.print(qry);
			rs=db.getRowset(qry);
			if(rs.next())
			{
			%>
			<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
			  <tr>
			   <td align=left><font color="#a52a2a" style="FONT-SIZE: medium"><b>Student Medical Form</b></font>
			   </td>
			   <td align=right><font color=brown><b>Login User :&nbsp; &nbsp;<%=mMemberName%> [Emp. Code: <%=mDMemberCode%>]</b></font>
			   </td>
			  </tr>
			</table>
			<center>
			<FONT color="#a52a2a" face=Arial size=3><STRONG>View/Edit Student Medical History</strong></font>
			<br>
			<font face=Arial size=2 color=navy><b><STRONG>Student Name : <%=rs.getString("STUDENTNAME")%>&nbsp;&nbsp;Enrollment No : <%=rs.getString("ENROLLMENTNO")%></STRONG></b></font>
			<br>
			</center>
			<%
			}
			%>
			<br>
			<%
			String mRoomNo="", mAllergicToDrug="", mHOAddition="", mPsychiatricIllness="", mPITreatment="", mTypeOfPITreatment="", mHypertension="";
			String mDiabetesMellitus="", mBronchialAsthma="", mAllergicBronchites="", mConvulsioris="", mCongentialDiease="";
			String mAnyMajorOrAccidental="", mAnyDrugIntake="", mAnyOther="";
			String mChkTyp1="", mChkTyp2="", mChkTyp3="", mChkTyp4="";

			qry="Select A.StudentName SName, A.EnrollmentNo EnrollNo, nvl(B.HOSTELROOMNO,'No') RoomNo, NVL(B.PRS_HOALLERGICTODRUG,'No')PRS_HOALLERGICTODRUG,";
			qry+=" NVL(B.PRS_HOADDITION,'No')PRS_HOADDITION, NVL(B.PRS_HOPSYCHIATRICILLNESS,'No')PRS_HOPSYCHIATRICILLNESS,";
			qry+=" NVL(B.PRS_PI_ONTREATMENT,'No')PRS_PI_ONTREATMENT, nvl(B.PRS_PI_TYPEOFTREATMENT,'No')PRS_PI_TYPEOFTREATMENT, NVL(B.PST_HOHYPERTENSION,'No')PST_HOHYPERTENSION,";
			qry+=" NVL(B.PST_HODIABETESMELLITUS,'No')PST_HODIABETESMELLITUS, NVL(B.PST_HOBRINICALASTHAMA,'No')PST_HOBRINICALASTHAMA,";
			qry+=" NVL(B.PST_HOALLERGICBRONCHITES,'No')PST_HOALLERGICBRONCHITES, NVL(B.PST_HOCONVULSIORISORFITS,'No')PST_HOCONVULSIORISORFITS,";
			qry+=" NVL(B.PST_HOANYCONGENTIALDIEASES,'No')PST_HOANYCONGENTIALDIEASES, NVL(B.HOANYMAJORSURGERYORACCIDENT,'No')HOANYMAJORSURGERYORACCIDENT,";
			qry+=" NVL(B.HOANYDRUGINTAKE,'No')HOANYDRUGINTAKE, NVL(B.ANYOTHER,'No')ANYOTHER";
			qry+=" from StudentMaster A, StudentMedicalHistory B Where A.STUDENTID=B.STUDENTID AND B.studentid='"+mSID+"'";
			//out.print(qry);
			rs1=db.getRowset(qry);
			if(rs1.next())
			{
				mRoomNo=rs1.getString("RoomNo").trim();
				mAllergicToDrug=rs1.getString("PRS_HOALLERGICTODRUG").trim();
				mHOAddition=rs1.getString("PRS_HOADDITION").trim();
				mPsychiatricIllness=rs1.getString("PRS_HOPSYCHIATRICILLNESS").trim();
				mPITreatment=rs1.getString("PRS_PI_ONTREATMENT").trim();
				mTypeOfPITreatment=rs1.getString("PRS_PI_TYPEOFTREATMENT").trim();
				mHypertension=rs1.getString("PST_HOHYPERTENSION").trim();
				mDiabetesMellitus=rs1.getString("PST_HODIABETESMELLITUS").trim();
				mBronchialAsthma=rs1.getString("PST_HOBRINICALASTHAMA").trim();
				mAllergicBronchites=rs1.getString("PST_HOALLERGICBRONCHITES").trim();
				mConvulsioris=rs1.getString("PST_HOCONVULSIORISORFITS").trim();
				mCongentialDiease=rs1.getString("PST_HOANYCONGENTIALDIEASES").trim();
				mAnyMajorOrAccidental=rs1.getString("HOANYMAJORSURGERYORACCIDENT").trim();
				mAnyDrugIntake=rs1.getString("HOANYDRUGINTAKE").trim();
				mAnyOther=rs1.getString("ANYOTHER").trim();
			}
			if(mTypeOfPITreatment.equals("Schilzophrenia"))
				mChkTyp1="checked";
			else if(mTypeOfPITreatment.equals("Maniac Desression"))
				mChkTyp2="checked";
			else if(mTypeOfPITreatment.equals("Anxiety Neurosis"))
				mChkTyp3="checked";
			else if(mTypeOfPITreatment.equals("Depresion"))
				mChkTyp4="checked";
			%>
			<table align=center width=90% cellpadding=1 border=1 cellspacing=0>
			<tr>
			<td align=left><Font color=navy face=arial size=3><b>Hostel/Room No. : </b></font></td>
			<td nowrap><INPUT ID="RoomNo" Name="RoomNo" Type="text" value="<%=mRoomNo%>" style="WIDTH: 160px; HEIGHT: 22px" maxLength=30></td>
			</tr>
			<tr>
			<td colspan=2><Font color=black face=arial size=3><b><U>Present Complaint </U></b></font></td>
			</tr>

			<tr>
			<td nowrap><Font color=black face=arial size=2><b>&nbsp; Any History of Allergic to Drug : </b></font></td>
			<td nowrap><INPUT ID="txtPrstC1" Name="txtPrstC1" Type="text" value="<%=mAllergicToDrug%>" style="WIDTH: 300px; HEIGHT: 22px" maxLength=50></td>
			</tr>

			<tr>
			<td nowrap><Font color=black face=arial size=2><b>&nbsp; History of Addition : </b></font></td>
			<td nowrap><INPUT ID="txtPrstC2" Name="txtPrstC2" Type="text" value="<%=mHOAddition%>" style="WIDTH: 300px; HEIGHT: 22px" maxLength=50></td>
			</tr>

			<tr>
			<td valign=top><Font color=black face=arial size=2><b>&nbsp; Psychiatric illness : </b></font></td>
			<td nowrap><INPUT ID="txtPrstC3" Name="txtPrstC3" Type="text" value="<%=mPsychiatricIllness%>" style="WIDTH: 300px; HEIGHT: 22px" maxLength=50>
			<BR>
			<Font color=black face=arial size=2><b>&nbsp;On Treatment?</b></font>&nbsp; <INPUT ID="txtPrstC3a" Name="txtPrstC3a" Type="text" value="<%=mPITreatment%>" style="WIDTH: 300px; HEIGHT: 22px" maxLength=50>
			<BR>
			<Font color=black face=arial size=2><b>&nbsp;Related to - </b></font>
			&nbsp; <INPUT ID="PrstC3a1" Name="PrstC3a1" Type="radio" value="Schilzophrenia" <%=mChkTyp1%>><font face=arial size=2 color=navy><B>Schilzophrenia</B></font>
			&nbsp; <INPUT ID="PrstC3a1" Name="PrstC3a1" Type="radio" value="Maniac Desression" <%=mChkTyp2%>><font face=arial size=2 color=navy><B>Maniac Desression</B></font>
			&nbsp; <INPUT ID="PrstC3a1" Name="PrstC3a1" Type="radio" value="Anxiety Neurosis" <%=mChkTyp3%>><font face=arial size=2 color=navy><B>Anxiety Neurosis</B></font>
			&nbsp; <INPUT ID="PrstC3a1" Name="PrstC3a1" Type="radio" value="Depresion" <%=mChkTyp4%>><font face=arial size=2 color=navy><B>Depresion</B></font>
			</td>
			</tr>

			<tr>
			<td colspan=2><Font color=black face=arial size=3><b><U>Past History </U></b></font></td>
			</tr>

			<tr>
			<td nowrap><Font color=black face=arial size=2><b>&nbsp; Hypertension : </b></font></td>
			<td nowrap><INPUT ID="txtPastC1" Name="txtPastC1" Type="text" value="<%=mHypertension%>" style="WIDTH: 300px; HEIGHT: 22px" maxLength=50></td>
			</tr>

			<tr>
			<td nowrap><Font color=black face=arial size=2><b>&nbsp; Diabetes Mellitus : </b></font></td>
			<td nowrap><INPUT ID="txtPastC2" Name="txtPastC2" Type="text" value="<%=mDiabetesMellitus%>" style="WIDTH: 300px; HEIGHT: 22px" maxLength=50></td>
			</tr>

			<tr>
			<td nowrap><Font color=black face=arial size=2><b>&nbsp; Bronchial Asthma : </b></font></td>
			<td nowrap><INPUT ID="txtPastC3" Name="txtPastC3" Type="text" value="<%=mBronchialAsthma%>" style="WIDTH: 300px; HEIGHT: 22px" maxLength=50></td>
			</tr>

			<tr>
			<td nowrap><Font color=black face=arial size=2><b>&nbsp; Allergic Bronchites : </b></font></td>
			<td nowrap><INPUT ID="txtPastC4" Name="txtPastC4" Type="text" value="<%=mAllergicBronchites%>" style="WIDTH: 300px; HEIGHT: 22px" maxLength=50></td>
			</tr>

			<tr>
			<td nowrap><Font color=black face=arial size=2><b>&nbsp; Convulsioris or Fits : </b></font></td>
			<td nowrap><INPUT ID="txtPastC5" Name="txtPastC5" Type="text" value="<%=mConvulsioris%>" style="WIDTH: 300px; HEIGHT: 22px" maxLength=50></td>
			</tr>

			<tr>
			<td nowrap><Font color=black face=arial size=2><b>&nbsp; Any Congential Dieases : </b></font></td>
			<td nowrap><INPUT ID="txtPastC6" Name="txtPastC6" Type="text" value="<%=mCongentialDiease%>" style="WIDTH: 300px; HEIGHT: 22px" maxLength=50></td>
			</tr>

			<tr>
			<td nowrap><BR><Font color=black face=arial size=2><b>History of any major Surgery or Accident<BR>(in which there was loss of consciousness) : </b></font></td>
			<td nowrap><BR><INPUT ID="txtMajorComp" Name="txtMajorComp" Type="text" value="<%=mAnyMajorOrAccidental%>" style="WIDTH: 300px; HEIGHT: 22px" maxLength=50></td>
			</tr>

			<tr>
			<td nowrap><BR><Font color=black face=arial size=2><b>History of any Drug Intake : </b></font></td>
			<td nowrap><BR><INPUT ID="txtDrugIntake" Name="txtDrugIntake" Type="text" value="<%=mAnyDrugIntake%>" style="WIDTH: 300px; HEIGHT: 22px" maxLength=50></td>
			</tr>

			<tr>
			<td colspan=2><BR><Font color=black face=arial size=2><b>Other History (If Any) : </b></font>
			&nbsp; <INPUT ID="AnyOther" Name="AnyOther" Type="text" value="<%=mAnyOther%>" style="WIDTH: 600px; HEIGHT: 22px" maxLength=250></td>
			</tr>
			</table>
			<table align=center><tr><td nowrap><input type=submit name=submit value=SUBMIT style="background-color:transparent;border-color:navy;color:navy"></td>&nbsp; &nbsp;<td nowrap><input type=reset name=reset value=CLEAR style="background-color:transparent;border-color:navy;color=navy"></td></tr></table>
			</form>
			<%

//-----------------------------
//-- Enable Security Page Level  
//-----------------------------
	 }
	else
	{
		%>
		<br>
		<font color=red>
		<h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
		<P>	This page is not authorized/available for you.
		<br>For assistance, contact your network support team. 
		</font>	<br>	<br>	<br>	<br> 
		<%
	}
//-----------------------------
}   //2
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
%>
</body>
</Html>