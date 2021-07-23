<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../../CommonFiles/ExceptionHandler.jsp" %>
<%@ page import="java.util.ArrayList,java.util.Iterator" %>
<%
DBHandler db=new DBHandler();
ResultSet rs=null,rsi=null;
GlobalFunctions gb =new GlobalFunctions();
OLTEncryption enc=new OLTEncryption();
String qry="";
String mComp="JIIT";
int mSno=0,mIntNo=100,flag=0;
String mEmployeeName="",mEmployeeCode="",mDepartment="";
String mMemberID="", mDMemberID="",mIndentDate="",mDesignation="";
String mMemberType="", mDMemberType="", mMemberCode="", mDMemberCode="";
String mMemberName="", mDept="", mDegs="",mDesignation1="";
String mInstitute="",mInst="",mtext="";
String mDate1="", mDate2="", mCurrDate="",mEmpCategory="";
String mQualification="",mCategory="",mEmployeeType="";
String mIndentReferenceNo="",mRequireDate="",mRequireManPower="";
String mRequireExp="",mDepartment1="",mStatus="";
String mPlacePosting="",mJobDiscription="",mRemarks="";
String mAgeFrom="",mAgeTo="",mDepartmentCode="";
String mQuliRemarks="",mGender="",mCategory1="",mEmpType="";
String mIndentStatus="",mDesignationCode="";
String mIntendNo="",mMainQuali="";
String mAge="",mExp="";
ArrayList mQaliArrayList=new ArrayList();
int mSlno=0;
qry="select to_Char(Sysdate,'dd-mm-yyyy') date1  from dual";
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
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Qualification of Man Power Indent] </TITLE>
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
</script>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
<STYLE>input {font-size:13px;}</STYLE>
</HEAD>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
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
		qry="Select WEBKIOSK.ShowLink('141','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	    RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
			// For Log Entry Purpose
			//--------------------------------------
			String mLogEntryMemberID="",mLogEntryMemberType="";
			if (session.getAttribute("LogEntryMemberID")==null || session.getAttribute("LogEntryMemberID").toString().trim().equals(""))
				mLogEntryMemberID="";
			else
				mLogEntryMemberID=session.getAttribute("LogEntryMemberID").toString().trim();
			if (session.getAttribute("LogEntryMemberType")==null || session.getAttribute("LogEntryMemberType").toString().trim().equals(""))
				mLogEntryMemberType="";
			else
				mLogEntryMemberType=session.getAttribute("LogEntryMemberType").toString().trim();
			if (mLogEntryMemberType.equals(""))
				mLogEntryMemberType=mMemberType;
			if (mLogEntryMemberID.equals(""))
				mLogEntryMemberID=mMemberID;
			if (!mLogEntryMemberType.equals(""))
				mLogEntryMemberType=enc.decode(mLogEntryMemberType);
			if (!mLogEntryMemberID.equals(""))
				mLogEntryMemberID=enc.decode(mLogEntryMemberID);
			//--------------------------------------
			%>
			<form name="frm"  method="get" >
			<input id="x" name="x" type=hidden>
			<center>
			<table align=center width="100%" bottommargin=0 topmargin=0>
			<tr>	
				<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4>Qualification of Man Power Indent</FONT></u></b></td>
			</tr>
			</table>
			</center>
			<%
				qry="select distinct nvl(institutecode,' ')IC from INSTITUTEMASTER where nvl(DEACTIVE,'N')='N' ";
				rsi=db.getRowset(qry);
				while(rsi.next())				
					mInst=rsi.getString("IC");
				if(request.getParameter("IntendNo")==null)
					mIntendNo="";
				else
					mIntendNo=request.getParameter("IntendNo");
				%>
				<center>
				<table width="90%" cellpadding="0" cellspacing="0" border=1 rules="groups">
				<%												
				try
				{
					qry="Select INDENTREFNO, to_char(INDENTDATE,'dd/mm/yyyy')INDENTDATE,to_char(REQUIREDDATE,'dd/mm/yyyy')REQUIREDDATE,nvl(A.REMARKS,' ')REMARKS, nvl(PLACEOFPOSTING,' ')PLACEOFPOSTING, TOTALEXPERIENCEREQ,E.EMPLOYEENAME EMPLOYEENAME,nvl(to_char(REQUIREDDATE,'dd/mm/yyyy'),' ')REQUIREDDATE,REQUIREDMANPOWER, nvl(GENDER,' ') GENDER, FROMAGEGROUP, nvl(TOAGEGROUP,0)TOAGEGROUP, B.EMPLOYEETYPEDESC,F.DEPARTMENT DEPARTMENT ,G.DESIGNATION DESIGNATION, C.EMPCATEGORYDESC EMPCATEGORYDESC,D.CATEGORY CATEGORY, nvl(JOBDESCRIPTION,' ')JOBDESCRIPTION, nvl(A.APPROVEDMANPOWER,0)APPROVEDMANPOWER,nvl(E.EMPLOYEENAME,' ')AUTORIZEDBY,nvl(to_char(A.AUTORIZEDDATE,'dd/mm/yyyy'),' ')AUTORIZEDDATE,nvl(A.AUTORIZEDREMARKS,' ')AUTORIZEDREMARKS,nvl(A.AUTORIZEDSTATUS,' ')AUTORIZEDSTATUS from HR#MANPOWERINDENT A,EMPLOYEETYPEMASTER B,HR#EMPCATEGORYMASTER C,CATEGORYMASTER D,EMPLOYEEMASTER E ,DEPARTMENTMASTER F,DESIGNATIONMASTER G where INDENTBY='"+mChkMemID+"' and INDENTNO='"+mIntendNo+"' and A.INDENTBY=E.EMPLOYEEID and A.INDENTDESIGNATIONCODE=G.DESIGNATIONCODE and A.INDENTDEPARTMENTCODE=F.DEPARTMENTCODE and A.EMPLOYEETYPE=B.EMPLOYEETYPE and A.EMPCATEGORYCODE=C.EMPCATEGORYCODE And A.CATEGORYCODE=D.CATEGORYCODE and nvl(A.DEACTIVE,' ')<>'Y' and nvl(B.DEACTIVE,' ')<>'Y' and nvl(D.DEACTIVE,' ')<>'Y' and nvl(C.DEACTIVE,' ')<>'Y' and nvl(E.DEACTIVE,' ')<>'Y' and nvl(F.DEACTIVE,' ')<>'Y' and nvl(G.DEACTIVE,' ')<>'Y'";
					//out.println(qry);
					rs=db.getRowset(qry);
					while(rs.next())
					{											
						%>
						<tr>	
							<td colspan=4><font size="2" face="arial"><b>&nbsp;Indent By</b></font>
							<font size=2 color='navy'><b><%=rs.getString("EMPLOYEENAME")%></b></font>
							<font size="2" face="arial"><b>&nbsp;&nbsp;Department </b></font>
							<font size=2 color='navy'><b><%=GlobalFunctions.toTtitleCase(rs.getString("DEPARTMENT"))%></b></font>
							<font size="2" face="arial"><b>&nbsp;&nbsp;Designation</b></font> 
							<font size=2 color=navy><b><%=GlobalFunctions.toTtitleCase(rs.getString("DESIGNATION"))%></b></font><hr>
							</td>
						</tr>
						<tr>
							<td><font size="2" face="arial"><b>&nbsp;Indent Refrence No.  </b></font></td>
							<td><B>:</b> &nbsp;<%=rs.getString("INDENTREFNO")%></td>
							<td><font size="2" face="arial"><b>&nbsp;Indent date </b></font></td>
							<td><b>:</b> &nbsp;<%=rs.getString("INDENTDATE")%></td>
						</tr>
						<tr>					
							<td><font size="2" face="arial"><b>&nbsp;Require Date </b></font></td>
							<td><b>:</b> &nbsp;<%=rs.getString("REQUIREDDATE")%></td>
							<td><font size="2" face="arial"><b>&nbsp;Require ManPower  </b></font></td>
							<td><b>:</b> &nbsp;<%=rs.getString("REQUIREDMANPOWER")%></td>
						</tr>
						<tr>
							<td><font size="2" face="arial"><b>&nbsp;Req. Experience  </b></font></td>
							<%
							if(rs.getString("TOTALEXPERIENCEREQ").equals("0") || rs.getString("TOTALEXPERIENCEREQ").equals(""))						
								mExp="N/A";						
							else
								mExp=rs.getString("TOTALEXPERIENCEREQ")+"(Y)";
							%>
							<td><b>:</b> &nbsp;<%=mExp%></td>
							<td><font size="2" face="arial"><b>&nbsp;Req. Age From </b></font></td>
							<%
							if(rs.getString("TOAGEGROUP").equals("0") || rs.getString("TOAGEGROUP").equals(""))						
								mAge="N/A"+"(Y)";						
							else
								mAge=rs.getString("TOAGEGROUP")+"(Y)";
							%>
							<td><b>:</b> &nbsp;<%=rs.getString("FROMAGEGROUP")%>(Y)<font size="2" face="arial"><b> &nbsp;&nbsp;&nbsp;To </b></font><b>:</b> &nbsp;<%=mAge%></td>
						</tr>
						<tr>
							<td><font size="2" face="arial"><b>&nbsp;Gender </b></font></td>
							<%
							if(rs.getString("GENDER").equals("A"))
							{
								%>
									<td><b>:</b> &nbsp;Both</td>
								<%
							}
							else if(rs.getString("GENDER").equals("M"))
							{
								%>
									<td><b>:</b> &nbsp;Male</td>
								<%
							}
							else if(rs.getString("GENDER").equals("F"))
							{
								%>
									<td><b>:</b> &nbsp;Female</td>
								<%
							}	
							%>
							<td><font size="2" face="arial"><b>&nbsp;Category </b></font></td>
							<td><b>:</b>  &nbsp;<%=GlobalFunctions.toTtitleCase(rs.getString("CATEGORY"))%></td>
						</tr>
						<tr>
							<td><font size="2" face="arial"><b>&nbsp;Emp. Category </b></font></td>
							<td><b>:</b>  &nbsp;<%=GlobalFunctions.toTtitleCase(rs.getString("EMPCATEGORYDESC"))%></td>					
							<td><font size="2" face="arial"><b>&nbsp;Emp. Type </b></font></td>
							<td><b>:</b>  &nbsp;<%=GlobalFunctions.toTtitleCase(rs.getString("EMPLOYEETYPEDESC"))%></td>
						</tr>
						<tr>
							<td><font size="2" face="arial"><b>&nbsp;Place Of Posting </b></font></td>
							<td colspan=3><b>:</b>  &nbsp;<%=GlobalFunctions.toTtitleCase(rs.getString("PLACEOFPOSTING"))%></td>
						</tr>
						<tr>
							<td><font size="2" face="arial"><b>&nbsp;Job Discription  </b></font></td>
							<td colspan=3><b>:</b> &nbsp;<%=GlobalFunctions.toTtitleCase(rs.getString("JOBDESCRIPTION"))%></td>
						</tr>
						<tr>
							<td><font size='2' face="arial"><b>&nbsp;Indent Remarks </b></font></td>
							<td colspan=3> <TEXTAREA NAME="remarks" ROWS="3" COLS="50" readonly><%=rs.getString("REMARKS")%></TEXTAREA></td>
						</tr>
						<%
						if(rs.getString("AUTORIZEDSTATUS").equals("C"))
						{
							%>
							<tr>
								<td><font size="2" face="arial"><b>&nbsp;Approved By  </b></font></td>
								<td><B>:</b> &nbsp;<%=rs.getString("AUTORIZEDBY")%></td>
								<td><font size="2" face="arial"><b>&nbsp;Approved Date  </b></font></td>
								<td><b>:</b> &nbsp;<%=rs.getString("AUTORIZEDDATE")%></td>
							</tr>
							<tr>					
								<td><font size="2" face="arial"><b>&nbsp;Approved ManPower</b></font></td>
								<td><b>:</b> &nbsp;</td>
								<td><font size="2" face="arial"><b>&nbsp;Approved Status</b></font></td>
								<td><b>:</b> &nbsp;<font color="red">Canceled</font></td>
							</tr>
							<tr>
								<td><font size='2' face="arial"><b>&nbsp;Approved Remarks </b></font></td>
								<td colspan=3> <TEXTAREA NAME="remarks" ROWS="3" COLS="50" readonly><%=rs.getString("AUTORIZEDREMARKS")%></TEXTAREA></td>
							</tr>
							<%						
						}
						else if(rs.getString("AUTORIZEDSTATUS").equals("F"))
						{
							%>
							<tr>
								<td><font size="2" face="arial"><b>&nbsp;Approved By  </b></font></td>
								<td><B>:</b> &nbsp;<%=rs.getString("AUTORIZEDBY")%></td>
								<td><font size="2" face="arial"><b>&nbsp;Approved Date  </b></font></td>
								<td><b>:</b> &nbsp;<%=rs.getString("AUTORIZEDDATE")%></td>
							</tr>
							<tr>					
								<td><font size="2" face="arial"><b>&nbsp;Approved ManPower</b></font></td>
								<td><b>:</b> &nbsp;<%=rs.getString("APPROVEDMANPOWER")%></td>
								<td><font size="2" face="arial"><b>&nbsp;Approved Status</b></font></td>
								<td><b>:</b> &nbsp;<font color="green">Finalized</font></td>
							</tr>
							<tr>
								<td><font size='2' face="arial"><b>&nbsp;Approved Remarks </b></font></td>
								<td colspan=3> <TEXTAREA NAME="remarks" ROWS="3" COLS="50" readonly><%=rs.getString("AUTORIZEDREMARKS")%></TEXTAREA></td>
							</tr>
						<%	
						}
						else if(rs.getString("AUTORIZEDSTATUS").equals("A"))
						{
							%>
							<tr>
								<td colspan=4><font size='2' face="arial" color="red"><b><center>&nbsp;Your request is not approved till now... </center></b></font></td>						
							</tr>
							<%
						}						
					}			
			}catch(Exception e)
			{/*out.println("Exception e"+e);*/	}
			%>
			</table>
			</center>
			<center>
			<table cellpadding="0" cellspacing="0" width="75%" class="sort-table" id="table-1" border='1'>
				<tr bgcolor="#ff8c00">
					<td>&nbsp;Slno</td>
					<td>&nbsp;Qualification</td>
					<td>&nbsp;Remarks</td>
					<td>&nbsp;Main Qualification</td>
				</tr>
				<%
				try
				{					
					qry="Select A.QUALIFICATIONCODE, NVL(A.REMARKS,' ')REMARKS,B.QUALIFICATION QUALIFICATION, nvl(MAINQUALIFICATION,' ')MAINQUALIFICATION from HR#MANPOWERQUALIFICATION A,QUALIFICATIONMASTER B where INDENTNO='"+mIntendNo+"' AND A.QUALIFICATIONCODE=B.QUALIFICATIONCODE order by MAINQUALIFICATION desc";
					//out.println(qry);
					rs=db.getRowset(qry);
					while(rs.next())
					{
						%>
						<tr>
							<td>&nbsp;<%=++mSlno%>.</td>
							<td>&nbsp;<%=rs.getString("QUALIFICATION")%></td>
							<td>&nbsp;<%=rs.getString("REMARKS")%></td>
							<%
							if(rs.getString("MAINQUALIFICATION").equals("Y"))
								mMainQuali="Y";
							else if(rs.getString("MAINQUALIFICATION").equals(" "))
								mMainQuali="N";
							else
								mMainQuali=" ";
							%>
							<td>&nbsp;<%=mMainQuali%></td>
						</tr>
						<%								 
					}
				}catch( Exception e )
					{		/*out.println("Exception e:-"+e);*/			}
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
			<h3>	<br><img src='../../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
			<P>	This page is not authorized/available for you.
			<br>For assistance, contact your network support team. 
			</font>	<br>	<br>	<br>	<br> 
			<%
		}
		//-----------------------------
	}
	else
	{
		out.print("<br><img src='../../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}
}
catch(Exception e)
{
	//out.print("Catch Block");	
}
%>
</form>
</body>
</html>