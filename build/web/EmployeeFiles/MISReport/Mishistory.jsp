<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null,rsi=null,rs1=null,rs2=null;
GlobalFunctions gb =new GlobalFunctions();
OLTEncryption enc=new OLTEncryption();
String qry="",qry1="",qry2="";
String mComp="";
String mEmployeeName="",mEmployeeCode="",mDepartment="";
String mMemberID="", mDMemberID="",mIndentDate="",mDesignation="";
String mMemberType="", mDMemberType="", mMemberCode="", mDMemberCode="";
String mMemberName="", mDept="", mDegs="",mDesignation1="";
String mInst="",mtext="",mCurrDate="";
String mDepartment1="",mLeaveYearCode="",mNatureOfJob="";
String mValDate="",mDay="",mFromDate="",mToDate="",mCategoryCode="",mSex=""; 
String mPresentDays="",mLeaveCode="",mLeaveTaken="",mBalance="";

String mRegCode = "",mENROLLMENTNO="",mstudentname="", macademicyear="" ;
String mprogramcode="", mbranchcode="", mSEMESTER ="",mpaidamount="";
        String mFeeHead = "";
        String mAcademicYear = "";
        String mProgramCode = "";
        String mBranchCode = "";
        String mInstCode = "JIIT";
int flag=0;
int count=0;
qry="select to_Char(Sysdate,'dd-mm-yyyy') date1  from dual";
rs=db.getRowset(qry);
rs.next();
mCurrDate=rs.getString("date1");
if (session.getAttribute("CompanyCode")==null)
	mComp="";
else
	mComp=session.getAttribute("CompanyCode").toString().trim();

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
String mHead="",mpayableamount="";
String mqryacademicyear="",mqryprogramcode="",mqrybranchcode="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead=" ";

	if (session.getAttribute("academicyear")==null)
	mAcademicYear="";
else
	mAcademicYear=session.getAttribute("academicyear").toString().trim();

if (session.getAttribute("branchcode")==null)
	mBranchCode="";
else
	mBranchCode=session.getAttribute("branchcode").toString().trim();

if (session.getAttribute("programcode")==null)
	mProgramCode="";
else
	mProgramCode=session.getAttribute("programcode").toString().trim();


	if (request.getParameter("academicyear").toString().trim()==null)
{
	mqryacademicyear="";
}
else
{	
	mqryacademicyear=request.getParameter("academicyear").toString().trim();
}

if (request.getParameter("programcode").toString().trim()==null)
{
	mqryprogramcode="";
}
else
{	
	mqryprogramcode=request.getParameter("programcode").toString().trim();
}
if (request.getParameter("branchcode").toString().trim()==null)
{
	mqrybranchcode="";
}
else
{	
	mqrybranchcode=request.getParameter("branchcode").toString().trim();
}
//---------------------ADDED CODE On 23/05/2011 by mohit sharma

	//out.print(mqrybranchcode + "---" + mqryprogramcode + "---" + mqryacademicyear  );
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Employee Leave Information] </TITLE>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css"/>
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
{	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{	
		mDMemberID=enc.decode(mMemberID);
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);
		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk=null;
		//-----------------------------------------------------------------------------------------------------------------
		//-- Enable Security Page Level  @mohit----------------------------------------------------------------------------
		//-----------------------------------------------------------------------------------------------------------------
		qry="Select WEBKIOSK.ShowLink('303','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	 	RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
		%>
		<form name="frm"  method="post">
			<input id="x" name="x" type="hidden">
			<center>
			<table align=center width="100%" bottommargin=0 topmargin=0>
			<tr>
			<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4>AcademicYear/ProgramCode/BranchCode Wise MIs_History</FONT></u></b></td>
			</tr>
			</table>
			</center>

<center>
			<table align=center cellpadding="0" cellspacing="0" border="0" rules="groups">
			<tr>
				<td colspan=8><hr>
				<b><FONT face=Arial size=2>&nbsp;&nbsp;Academic Year: </font><%=mqryacademicyear%></B>
				<!-- <font color="#00008b" face=times new roman size=2><b>&nbsp;<%=mEmployeeName%> </b></font> -->
				<b><FONT face=Arial size=2>&nbsp;&nbsp;Program Code: </font> <%=mqryprogramcode%></B>
				<!-- <font color="#00008b" face=times new roman><b> &nbsp;<%=GlobalFunctions.toTtitleCase(mDesignation1)%> </b></font> -->
				<b><FONT face=Arial size=2>&nbsp; Branch Code: </font><%=mqrybranchcode%></B><hr>
				</td>
			</tr>							
			</table>
			</center>
			
			<center>
			<font face="Arial" size=3><u><b>(AcademicYear/ProgramCode/BranchCode Wise) Mis_History</b></u></font>
			<br>
			</br>
			</center>
			<TABLE frame=box style="FONT-FAMILY: Arial; FONT-SIZE: x-small"  border=1 bordercolor=Black bordercolordark=White cellpadding=2 cellspacing=0 width="100%">
			<TR bgcolor="#ff8c00">
				<TH><font face="Arial" size=2 color="white">Sl No.</font> </TH>
				<TH><font face="Arial" size=2 color="white">Enrollment no.</font> </TH>
				<TH><font face="Arial" size=2 color="white">Student Name</font></TH>
				<TH><font face="Arial" size=2 color="white">Academic Year</font></TH>
				<TH><font face="Arial" size=2 color="white">Program Code</font></TH>
				<TH><font face="Arial" size=2 color="white">Branch Code</font></TH>
				<TH><font face="Arial" size=2 color="white">Semester</font> </TH>
				<TH><font face="Arial" size=2 color="white">Payable amount</font></TH>
				<TH><font face="Arial" size=2 color="white">Paid amount</font></TH>
			</TR>
			<%
			try
			{
				qry="SELECT   a.enrollmentno, a.studentname, a.semester,  SUM (b.feeamount) payableamount, SUM (b.paidamount)paidamount FROM studentmaster a, studentfeesummary b,studentregistration c WHERE a.studentid = b.studentid   and b.studentid=c.studentid  AND NVL (a.deactive, 'N') = 'N' AND a.academicyear = '"+mqryacademicyear+"'     AND a.programcode = '"+mqryprogramcode+"' AND  a.branchcode = '"+mqrybranchcode+"' GROUP BY a.enrollmentno,a.studentname,a.semester ORDER BY a.enrollmentno,a.studentname, a.semester";	
				//out.println(qry);
				rs=db.getRowset(qry);
				while (rs.next())      
				{  
					mENROLLMENTNO=rs.getString("ENROLLMENTNO");					
					mstudentname=rs.getString("studentname");					
					mSEMESTER=rs.getString("SEMESTER");
					mpaidamount=rs.getString("paidamount");
					mpayableamount=rs.getString("payableamount");
			%>			
			<center>
			<TR bgcolor="white">
							<TD align="center">&nbsp;<b><%=++count%></b></TD>
							<TD bgcolor=white align=center><a href="misstudent.jsp?ViewType=CNF&amp;ENROLLMENTNO=<%=rs.getString("ENROLLMENTNO")%>&amp;studentname=<%=rs.getString("studentname")%>&amp;SEM ESTER=<%=rs.getString("SEMESTER")%>" target=_new><Font face=Arial color=blue size=2><%=mENROLLMENTNO%></Font></a></TD>

                           
						   <TD bgcolor=white align=center><a
						   href="misstudent.jsp?ViewType=CNF&amp;ENROLLMENTNO=<%=rs.getString("ENROLLMENTNO")%>&amp;studentname=<%=rs.getString("studentname")%>&amp;SEMESTER=<%=rs.getString("SEMESTER")%>" target=_new><Font face=Arial color=blue size=2><%=mstudentname%></Font></a></TD>

						   <TD bgcolor=white align=center><a 
						   href="misstudent.jsp?ViewType=CNF&amp;ENROLLMENTNO=<%=rs.getString("ENROLLMENTNO")%>&amp;studentname=<%=rs.getString("studentname")%>&amp;SEMESTER=<%=rs.getString("SEMESTER")%>" target=_new><Font face=Arial color=blue size=2><%=mqryacademicyear%></Font></a></TD>
 
						  <TD align="center">&nbsp;<%=mqryprogramcode%></TD>
						  <TD align="center">&nbsp;<%=mqrybranchcode%></TD>
						  <TD bgcolor=white align=center><Font face=Arial color=blue size=2><%=mSEMESTER%></Font></a></TD>
							
						  <TD align="center">&nbsp;<%=mpayableamount%></TD>
						  <TD align="center">&nbsp;<%=mpaidamount%></TD>			
						  </TR>   
			<%				
				}
			}
			catch(Exception e)
			{
				
			}
			
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
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}
}
catch(Exception e)
{	
	//out.print("Exception e"+e); 
}
%>

</form>
</body>
</html>