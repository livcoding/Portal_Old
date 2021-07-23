<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../../CommonFiles/ExceptionHandler.jsp" %>
<%
DBHandler db=new DBHandler();
ResultSet rs=null,rsi=null;
GlobalFunctions gb =new GlobalFunctions();
OLTEncryption enc=new OLTEncryption();
String qry="";
String mComp="JIIT";
String mEmployeeName="",mEmployeeCode="",mDepartment="";
String mMemberID="", mDMemberID="",mIndentDate="",mDesignation="";
String mMemberType="", mDMemberType="", mMemberCode="", mDMemberCode="";
String mMemberName="", mDept="", mDegs="",mDesignation1="";
String mInstitute="",mInst="",mtext="";
String mDesignationCode="",mDepartmentCode="",mApplicantName="";
String mDepartment1="",mDate1="",mDate2="",mValue="";
String mApplName="",mSex="",mFaterName="",mDob="",mPresentSalary="";
String mMarital="",mDateofSub="",mApplicantid="",mPresentOrg="";
String mExp="",mMainQuali="",mInterViewCode="";
int counter=0,mSno=0;
int mTotalExpInYear=0,mExpInYear=0,mExpInMonth=0;

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
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Save Short List Applicant ] </TITLE>
<script language=javascript>
<!--
function RefreshContents()
{ 	
	document.frm.x.value='ddd';
	document.frm.submit();
}
//-->
if(window.history.forward(1) != null)
window.history.forward(1);	
</script>
<STYLE>input {font-size:13px;}</STYLE>
</HEAD>
</head>
<body>
<%
try
{
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{	
		mDMemberID=enc.decode(mMemberID);
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);
		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk=null;
		//-----------------------------
		//-- Enable Security Page Level  
		//-----------------------------
		qry="Select WEBKIOSK.ShowLink('149','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	    RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
			response.setContentType("application/vnd.ms-excel;"); 
			//out.print(request.getParameter("InterViewCode"));
			if(request.getParameter("InterViewCode")==null)
				mInterViewCode="";
			else
				mInterViewCode=request.getParameter("InterViewCode");
			%>
			<center>
			<table border=1>
			<tr>
				<td align="center" colspan="10"><font face="arial" size="4"><b>Short Listed Applicant</b></td>
			</tr>
			<tr>
				<td><b>Sno.</b></font></td>				
				<td><b>Applicant&nbsp;Name</b></font></td>
				<td><b>Father's&nbsp;Name</b></font></td>
				<td><b>Main&nbsp;Qualification</b></font></td>
				<td><b>Gender</b></font></td>
				<td><b>Experience</b></font></td>
				<td><b>Date&nbsp;of&nbsp;Birth</b></font></td>
				<!-- <td><b>Current&nbsp;Org.</b></font></td>
				<td><b>Present&nbsp;Salary</b></font></td> -->
				<td><b>Marital&nbsp;Status</b></font></td>
				<td><b>Sub.&nbsp;Date&nbsp;&nbsp;</b></font></td>	
				<td><b>Status</b></font></td>	
			</tr>
			<%
			try
			{
				/*qry="select APPLICANTNAME,DECODE(B.SEX,'',' ','F','Female','M','Male')SEX,";
				qry=qry+"NVL(B.FATHERHUSBANDNAME,' ')FATHERHUSBANDNAME,";
				qry=qry+"NVL(TO_CHAR(B.DATEOFSUBMISSION,'DD-MM-YYYY'),' ')DATESUB,";
				qry=qry+"NVL(TO_CHAR(B.DATEOFBIRTH,'DD-MM-YYYY'),' ')DATEOFBIRTH,nvl(E.QUALIFICATION,' ') QUALIFICATION ,";
				qry=qry+"DECODE(B.MARITALSTATUS,'',' ','M','Married','U','Unmarried')MARITALSTATUS,";
				qry=qry+"decode(SHORTLISTEDSTATUS,'',' ','Y','Yes','N','No')SHORTLISTEDSTATUS,";
				qry=qry+"nvl(C.TOTALMONTHEXPERIANCE,'0') TOTALMONTHEXPERIANCE from HR#SHORTLISTAPPLICANT A,HR#APPLICATIONMASTER B,V#HR#APPLICANTEXPERIANCE C,HR#APPLICANTQUALIFICATION D,";
				qry=qry+"QUALIFICATIONMASTER E where  NVL(A.DEACTIVE,'N')<>'Y' ";
				qry=qry+"AND NVL(B.DEACTIVE,'N')<>'Y' AND NVL(E.DEACTIVE,'N')<>'Y' ";
				qry=qry+"AND A.APPLICANTID=B.APPLICANTID AND C.APPLICANTID(+)=A.APPLICANTID";
				qry=qry+" AND D.APPLICANTID(+)=A.APPLICANTID AND E.QUALIFICATIONCODE(+)=D.QUALIFICATIONCODE ";
				qry=qry+"AND INTERVIEWCODE='"+mInterViewCode+"' order by TOTALMONTHEXPERIANCE desc";*/
				qry="select APPLICANTNAME,DECODE(B.SEX,'',' ','F','Female','M','Male')SEX,";
				qry=qry+"NVL(B.FATHERNAME,' ')FATHERNAME,";
				qry=qry+"NVL(TO_CHAR(B.DATEOFSUBMISSION,'DD-MM-YYYY'),' ')DATESUB,";
				qry=qry+"NVL(TO_CHAR(B.DATEOFBIRTH,'DD-MM-YYYY'),' ')DATEOFBIRTH,nvl(E.QUALIFICATION,' ') QUALIFICATION ,";
				qry=qry+"DECODE(B.MARITALSTATUS,'',' ','M','Married','U','Unmarried')MARITALSTATUS,";
				qry=qry+"decode(SHORTLISTEDSTATUS,'',' ','Y','Yes','N','No')SHORTLISTEDSTATUS,";
				qry=qry+"nvl(C.EXPERIENCEINMONTHS,'0') EXPERIENCEINMONTHS from HR#SHORTLISTAPPLICANT A,HR#APPLICATIONMASTER B,HR#APPLICANTEXPERIENCE C,HR#APPLICANTQUALIFICATION D,";
				qry=qry+"QUALIFICATIONMASTER E where  NVL(A.DEACTIVE,'N')<>'Y' ";
				qry=qry+"AND NVL(B.DEACTIVE,'N')<>'Y' AND NVL(E.DEACTIVE,'N')<>'Y' ";
				qry=qry+"AND A.APPLICANTID=B.APPLICANTID AND C.APPLICANTID(+)=A.APPLICANTID";
				qry=qry+" AND D.APPLICANTID(+)=A.APPLICANTID AND E.QUALIFICATIONCODE(+)=D.QUALIFICATIONCODE ";
				qry=qry+"AND INTERVIEWCODE='"+mInterViewCode+"' order by EXPERIENCEINMONTHS desc";
				//out.print(qry);
				rs=db.getRowset(qry);
				while(rs.next())
				{
					%>
					<tr>
						<td><%=++mSno%>.</td>
						<td nowrap>&nbsp;<%=gb.toTtitleCase(rs.getString("APPLICANTNAME"))%></td>
						<td nowrap>&nbsp;<%//=gb.toTtitleCase(rs.getString("FATHERHUSBANDNAME"))%></td>
						<td align="center" nowrap>&nbsp;<%=gb.toTtitleCase(rs.getString("QUALIFICATION"))%></td>	
						<td>&nbsp;<%=rs.getString("SEX")%></td>
						<%															
						mTotalExpInYear=Integer.parseInt(rs.getString("EXPERIENCEINMONTHS"));							
						mExpInYear=mTotalExpInYear/12;							
						mExpInMonth=mTotalExpInYear%12;
						%>
						<td nowrap>Year&nbsp;<%=mExpInYear%>&nbsp;Month&nbsp;<%=mExpInMonth%></td>								
						<td>&nbsp;<%=rs.getString("DATEOFBIRTH")%></td>
						<!-- <td>&nbsp;<%//=mPresentOrg%></td>
						<td>&nbsp;<%//=mPresentSalary%></td> -->
						<td>&nbsp;<%=gb.toTtitleCase(rs.getString("MARITALSTATUS"))%></td>
						<td>&nbsp;<%=rs.getString("DATESUB")%></td>	
						<td>&nbsp;<%=gb.toTtitleCase(rs.getString("SHORTLISTEDSTATUS"))%></td>	
					</tr>
					<%					
				}
			}catch(Exception e)
			{
				/*out.print("Exception e:-"+e);*/				
			}
			%>				
		</table>
		</center>			
		<input type="hidden" value="<%=mSno%>" name="counter">
		<%	
		}
		else
		{
			%>
				<br>
				<font color=red>
				<h3><br><img src='images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
				<P>	This page is not authorized/available for you.
				<br>For assistance, contact your network support team. 
				</font>	<br>	<br>	<br>	<br> 
			<%
		}
		//-----------------------------
	}
	else
	{
		out.print("<br><img src='images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}
}
catch(Exception e)
{	
	/*out.print("Exception e"+e);	*/
}
%>
</form>
</body>
</html>