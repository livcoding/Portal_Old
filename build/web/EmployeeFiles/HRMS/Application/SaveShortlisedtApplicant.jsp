<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null,rsi=null,rs1=null;
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
String mExp="",mMainQuali="",mInterviewCode="";
int counter=0,mSno=0;
int count=0,flag=0;

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
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
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
<body aLink="#ff00ff" bgcolor="#fce9c5" leftmargin="0" topmargin="0">
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
			%>
			<form name="frm"  method="post" action="SaveShortlistApplicantExcel.jsp" target=_new> 
			<center>
			<table align=center width="100%" bottommargin=0 topmargin=0>
			<tr>
				<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4>Short Listed Applicant</FONT></u></b></td>				
			</tr>
			</table>
			</center>
			<table>
			<tr>
				 <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="Submit" name="saveinxl" value="Save in Excel" style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 120px; HEIGHT: 20px; FONT-VARIANT: normal; cursor:hand; background-color:; border-width:1;"></td> 
			<tr>
			</table>
			<%			
			if(request.getParameter("InterviewCode")==null)
				mInterviewCode="";
			else
				mInterviewCode=request.getParameter("InterviewCode");
			//out.println("aaaaaa:-"+mInterviewCode);
			//out.print("conter:-"+request.getParameter("counter"));;;
			if(request.getParameter("counter")!=null)
				for(int i=1;i<=(Integer.parseInt(request.getParameter("counter")));i++)
				{			
					if(request.getParameter("check"+i)!=null)
					{
						if(request.getParameter("ApplicantName"+i)==null)
							mApplName="";
						else
							mApplName=request.getParameter("ApplicantName"+i);
						if(request.getParameter("Sex"+i)==null)
							mSex="";
						else
							mSex=request.getParameter("Sex"+i);			
						if(request.getParameter("FaterName"+i)==null)
							mFaterName="";
						else
							mFaterName=request.getParameter("FaterName"+i);			
						if(request.getParameter("Dob"+i)==null)
							mDob="";
						else
							mDob=request.getParameter("Dob"+i);
						if(request.getParameter("PresentSalary"+i)==null)
							mPresentSalary="";
						else	
							mPresentSalary=request.getParameter("PresentSalary"+i);
						if(request.getParameter("Marital"+i)==null)
							mMarital="";
						else
							mMarital=request.getParameter("Marital"+i);
						if(request.getParameter("DateofSub"+i)==null)
							mDateofSub="";
						else
							mDateofSub=request.getParameter("DateofSub"+i);
						if(request.getParameter("Applicantid"+i)==null)
							mApplicantid="";
						else	
							mApplicantid=request.getParameter("Applicantid"+i);	
						if(request.getParameter("PresentOrg"+i)==null)
							mPresentOrg="";
						else
							mPresentOrg=request.getParameter("PresentOrg"+i);
						if(request.getParameter("Exp"+i)==null)
							mExp="";
						else
							mExp=request.getParameter("Exp"+i);	
						if(request.getParameter("MainQuali"+i)==null)
							mMainQuali="";
						else
							mMainQuali=request.getParameter("MainQuali"+i);				
						try
						{
							qry="select 1 from HR#SHORTLISTAPPLICANT where INTERVIEWCODE='"+mInterviewCode+"' and APPLICANTID='"+mApplicantid+"'";  
							rs1=db.getRowset(qry);
							//out.print(qry);
							if(rs1.next())
							{
								//out.println("duplicate Entry");
							}
							else
							{
								qry="INSERT into HR#SHORTLISTAPPLICANT (INTERVIEWCODE,	APPLICANTID, ";
								qry=qry+"SHORTLISTEDSTATUS, ENTRYBY, ENTRYDATE) ";
								qry=qry+"VALUES ('"+mInterviewCode+"','"+mApplicantid+"','Y','"+mChkMemID+"',sysdate)";						
								//out.println(qry);
								int n=db.insertRow(qry);
								if(n>0)
									count++;
								else
								{
									flag++;
										//out.println("----Error----");
								}
							}							
						}catch(Exception e)
						{
							/*System.out.println("Exception e:-"+e);*/
						}
					}
				}
				%>	
				<input type="hidden" value="<%=mSno%>" name="counter">
			</table>
			</center>					
			<input type="hidden" value="<%=mSno%>" name="counter">
			<input type="hidden" value="<%=mInterviewCode%>" name="InterViewCode">
			<%
			//out.print("aaaaaa:-"+count);
			if(count>0)
			{
				%>
				<center><font face="arial" size="2" color="green"><b>Applicant Short-listed successfully...</b></font></center>
				<%
			}
			else
			{	
				%>
				<center><font face="arial" size="2" color="red"><b>Some/All Applicants Already Short-Listed</b></font></center>
				<%
			}
			%>
			<center>
			<table class="sort-table" id="table-1" cellpadding="0" cellspacing="0" border="2" width="90%">
			<tr bgcolor="#ff8c00">
				<td><font color="white"><b>Sno.</b></font></td>
				<td><font color="white"><b>Interview Type</b></font></td>	
				<td><font color="white"><b>Applicant Name</b></font></td>	
				<td><font color="white"><b>Gender</b></font></td>	
				<td><font color="white"><b>Date of Birth</b></font></td>
				<td><font color="white" title="Shortlist Status"><b>Status</b></font></td>				
			</tr>
			<%
			try
			{
				qry="select INTERVIEWDESC, APPLICANTNAME,DECODE(B.SEX,'',' ";
				qry=qry+"','F','Female','M','Male')SEX,NVL(TO_CHAR(B.DATEOFBIRTH,";
				qry=qry+"'DD-MM-YYYY'),' ')DATEOFBIRTH,decode(SHORTLISTEDSTATUS,'Y','Yes','N','No','null',' ')SHORTLISTEDSTATUS from ";				
				qry=qry+"HR#SHORTLISTAPPLICANT A,HR#APPLICATIONMASTER B,HR#INTERVIEWMASTER C where  ";
				qry=qry+"NVL(A.DEACTIVE,'N')<>'Y' AND NVL(B.DEACTIVE,'N')<>'Y' AND ";
				qry=qry+"NVL(C.DEACTIVE,'N')<>'Y' AND NVL(C.LOCKINTERVIEW,' ') <>'Y' ";
				qry=qry+"and A.INTERVIEWCODE=C.INTERVIEWCODE and ";
				qry=qry+"A.APPLICANTID=B.APPLICANTID AND ";
				qry=qry+"A.INTERVIEWCODE='"+mInterviewCode+"'";
				//out.println(qry);
				rs=db.getRowset(qry); 
				while(rs.next())
				{
					%>
					<tr bgcolor="white">
						<td>&nbsp;<%=++mSno%>.</td>
						<td>&nbsp;<%=rs.getString("INTERVIEWDESC")%></td>
						<td>&nbsp;<%=gb.toTtitleCase(rs.getString("APPLICANTNAME"))%></td>
						<td>&nbsp;<%=rs.getString("SEX")%></td>
						<td>&nbsp;<%=rs.getString("DATEOFBIRTH")%></td>
						<td>&nbsp;<%=rs.getString("SHORTLISTEDSTATUS")%></td>			
					</tr>
					<%
				}
			}catch(Exception e)
			{/*out.print("Exception e:-"+e);*/	}
			%>
			</table>
			</center>
		<%	
		}
		else
		{
			%>
			<br>
			<font color=red>
			<h3><br><img src='images/Error1.jpg'>Access Denied (authentication_failed) </h3><br><P>This page is not authorized/available for you.
			<br>For assistance, contact your network support team. 
			</font><br><br><br><br> 
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