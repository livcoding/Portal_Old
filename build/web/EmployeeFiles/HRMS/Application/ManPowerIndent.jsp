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
String mIndentStatus="P",mDesignationCode="",mesg="",mRightsID="141";
ArrayList mQaliArrayList=new ArrayList();
int mSlno=0,mVlaidation=0,mStudent=0,mFaculty=0,mRequiredFaculty=0,count=0;
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
<TITLE>#### <%=mHead%> [ Man Power Indent] </TITLE>
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
	function QuestionTextChanged() 
	{
		if(document.frm.Remarks.value.length > 300) 
		{
			document.frm.Remarks.value = document.frm.Remarks.value.substr(0,300); 
			alert("You can not enter the remarks more than 300 characters");
			return false;
		}
	} 
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
		qry="Select WEBKIOSK.ShowLink('"+mRightsID+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
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
			session.removeAttribute("Qualification");
			session.removeAttribute("Qualification");
			session.removeAttribute("QualiRemarks");
			%>
			<form name="frm2" method="post" action="ManPowerIndentForm.jsp">		
			<center>
	
	<table id=id1 width="852" ALIGN=CENTER  topmargin=0 cellspacing=0 cellpadding=0 rightmargin=0 leftmargin=0 bottommargin=0 >
				
<!-------------Page Heading and Marquee Message----------------------->
<%
try
{
	String mPageHeader="Man Power Indent", mMarqMsg="", CurrDate="";
	qry="Select to_char(sysdate,'dd-mm-yyyy')CurrDate from dual";
	rs=db.getRowset(qry);
	if(rs.next())
	{
		CurrDate=rs.getString("CurrDate");
	}
	qry="Select nvl(A.MARQUEEMESSAGE,' ')MarqMsg FROM PAGEBASEDMEESSAGES A WHERE A.RIGHTSID='"+mRightsID+"' and A.RELATEDTO LIKE '%E%' and to_date('"+CurrDate+"','dd-mm-yyyy') between MESSAGEFLASHFROMDATETIME and MESSAGEFLASHUPTODATETIME and nvl(DEACTIVE,'N')='N'";
	rs=db.getRowset(qry);
	//out.print(qry);
	if(rs.next())
	{
		mMarqMsg=rs.getString("MarqMsg");
		%>
		<tr><td width=100% bgcolor="#A53403" style="FONT-WEIGHT:bold; FONT-SIZE:smaller; WIDTH:100%; HEIGHT:15px; FONT-VARIANT:small-cap; filter:progid:DXImageTransform.Microsoft.Gradient(startColorStr='Orange', endColorStr='#A53403', gradientType='0'"><marquee behavior="" scrolldelay=100 width=100%><font color="white" face=arial size=2><STRONG><%=mMarqMsg%></STRONG></font></marquee></b></td><tr>
		<%
	}
	qry="Select nvl(B.PAGEHEADER,'"+mPageHeader+"')PageHeader FROM WEBKIOSKRIGHTSMASTER B WHERE B.RIGHTSID='"+mRightsID+"' and B.RELATEDTO LIKE '%E%'";
	rs=db.getRowset(qry);
	//out.print(qry);
	if(rs.next())
	{
		mPageHeader=rs.getString("PageHeader");
		%>
		<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4> <%=mPageHeader%> </FONT></u></b></font></td></tr>
		<%
	}
	else
	{
		%>
		<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4> <%=mPageHeader%> </FONT></u></b></font></td></tr>
		<%
	}
}
catch(Exception e)
{}
%>
<!-------------Page Heading and Marquee Message----------------------->
				<tr>
				<td align="right" width=33%><input type="submit" name="ADD" id="ADD" value="Add ManPower Indent" style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 170px; HEIGHT: 23px; FONT-VARIANT: normal; cursor:hand; border-width:1 ; filter:progid:DXImageTransform.Microsoft.Gradient(startColorStr='#ff8c00', endColorStr='White', gradientType='0'"></td>
			</tr>
			</table>
			</center>
			</form>
			<form name="frm1"  method="post" action="ManPowerIndentApprovalBySelf.jsp">			
			<script>
				function allChecked()
				{
					for(var i =0; i < document.frm1.elements.length;i++)
					{						
						var e=document.frm1.elements[i];					
						if((e.name!="allCheck") && (e.type=="checkbox"))
							e.checked = document.frm1.allCheck.checked;
					}
				}
				function Checked()
				{
					document.frm1.allCheck.checked=false;
					var j=0;
					for(var i=0;i<document.frm1.elements.length;i++)
					{
						var e=document.frm1.elements[i];
						if((e.type=="checkbox")&&(e.checked==false))
							++j;					 				
					}
					if(j==1)
					{
						document.frm1.allCheck.checked=true;
						return false;
					}
				}
				function fun()
				{
					var k=0;
					for(var i =0; i < document.frm1.elements.length;i++)
					{
						var e=document.frm1.elements[i];									
						if(e.type=="checkbox"){
							if(e.checked==true)
								k++;		
						}
					}					
					if(k==0)
					{
						alert("Please select any check box");
						return false;
					} 	  			
				}
			</script>
			<%	
			qry="select distinct nvl(institutecode,' ')IC from INSTITUTEMASTER where nvl(DEACTIVE,'N')='N' ";
			rsi=db.getRowset(qry);
			while(rsi.next())
				mInst=rsi.getString("IC");		
			if(request.getAttribute("message")==null)
				mesg="";
			else
				mesg=(String)request.getAttribute("message");			
			if(mesg.equals("10")){				
				out.println("<center><font size=2 face='arial' color=green><b>Request for Man Power Indent save Successfully </b></font></center>");
			}
			else if(mesg.equals("20"))
			{
				out.print("<center><img src='../../../Images/Error1.jpg'> ");
				out.println("<font size=2 face='arial' color=red><b>Error while saving </center></b></font>");
			}
			else if(mesg.equals("1"))
			{
				//out.print("<center><img src='../../../Images/Error1.jpg'>");
				out.print("<center><b><font size=2 face='Arial' color='Green'>Approved Successfully....</font></center>");
			}
			else if(mesg.equals("2"))
			{
				out.print("<center><img src='../../../Images/Error1.jpg'>");
				out.print("&nbsp;&nbsp;&nbsp <b><font size=2 face='Arial' color='red'>Problem in Approval....</font></center>");
			}
			else if(mesg.equals("3"))
			{
				out.print("<center><img src='../../../Images/Error1.jpg'>");
				out.print("&nbsp;&nbsp;&nbsp <b><font size=2 face='Arial' color='red'>Please select any checkbox....</font></center>");
			}
			else if(mesg.equals("11"))
			{				
				out.print("<center><b><font size=2 face='Arial' color='Green'>Canceled Successfully....</font></center>");
			}
			else if(mesg.equals("12"))
			{
				out.print("<center><img src='../../../Images/Error1.jpg'>");
				out.print("&nbsp;&nbsp;&nbsp <b><font size=2 face='Arial' color='red'>Problem in Cancelation....</font></center>");
			}
			else if(mesg.equals("13"))
			{
				out.print("<center><img src='../../../Images/Error1.jpg'>");
				out.print("&nbsp;&nbsp;&nbsp <b><font size=2 face='Arial' color='red'>Please select any checkbox....</font></center>");
			}
			%>
				<center>
				<table class="sort-table" id="table-1" cellpadding="0"	cellspacing="0" border='1' width="60%">
					<tr bgcolor="#ff8c00">
						<td nowrap><font color="white"><b>Sr.<br>No.</b></font></td>
						<td nowrap>&nbsp;<font color="white"><b>Indent Refrence No.</b></font></td>
						<td nowrap>&nbsp;<font color="white"><b>Indent Date</b></font></td>
						<td nowrap>&nbsp;<font color="white"><b>Require Date</b></font></td>
						<td nowrap>&nbsp;<font color="white"><b>Indent<br>&nbsp;Status</b></font></td>
						<td nowrap>&nbsp;<font color="white"><b>Approve?<br>&nbsp;<input type="checkbox" value="N" name="allCheck" onClick="allChecked()">&nbsp;&nbsp;All</b></font></td>
					</tr>
			<%
			try
			{			
				qry="Select INDENTNO, INDENTREFNO, to_char(INDENTDATE,'dd/mm/yyyy')INDENTDATE,decode(INDENTSTATUS,'P',1,'F','2','A',3,'C',4)INDENTSTATUS,to_char(REQUIREDDATE,'dd/mm/yyyy')REQUIREDDATE from HR#MANPOWERINDENT where INDENTBY='"+mChkMemID+"' and to_date(REQUIREDDATE,'dd/mm/yyyy')>=To_date(sysdate,'dd/mm/yyyy') order by INDENTSTATUS, INDENTNO";
				//out.println(qry);
				rs=db.getRowset(qry);
				while(rs.next())
				{
					if(count==0)
						count++;								
					if(rs.getString("INDENTSTATUS").equals("1"))
						mStatus="Pending";					
					else if(rs.getString("INDENTSTATUS").equals("3"))
						mStatus="Approved";
					else if(rs.getString("INDENTSTATUS").equals("4"))
						mStatus="Canceled";
					else if(rs.getString("INDENTSTATUS").equals("2"))
						mStatus="Finalized";
					%>
						<tr>
							<td>&nbsp;<%=++mSlno%>.</td>
							<td>&nbsp;<a title="Click to show details" target=_new  href="IndentQualification.jsp?&IntendNo=<%=rs.getString("INDENTNO")%>"><font color='blue'><b><%=rs.getString("INDENTREFNO")%></B></FONT></A></td>
							<td>&nbsp;<%=rs.getString("INDENTDATE")%></td>
							<td>&nbsp;<%=rs.getString("REQUIREDDATE")%></td>
						<%
						if(rs.getString("INDENTSTATUS").equals("1"))
						{
							%>
								<td>&nbsp;<font color=blue><b><%=mStatus%></b></font></td>
								<td>&nbsp;<input type="checkbox" value="Y" size="3" name="check<%=mSlno%>" onClick="Checked()">
								<INPUT TYPE="HIDDEN" name="IntNo<%=mSlno%>" value="<%=rs.getString("INDENTNO")%>"</td>
							<%
						}
						else if(rs.getString("INDENTSTATUS").equals("2"))
						{
							%>
								<td>&nbsp;<font color=Green><b><%=mStatus%></b></font></td>
								<td>&nbsp;&nbsp;&nbsp;--<!-- <input type="checkbox" value="Z" readonly name="chec" > --></td>
							<%				
						}
						else if(rs.getString("INDENTSTATUS").equals("3"))
						{
							%>
								<td>&nbsp;<font color=black><b><%=mStatus%></b></font></td>
								<td>&nbsp;&nbsp;&nbsp;--<!-- <input type="checkbox" value="Z" readonly name="chec" > --></td>
							<%				
						}
						else if(rs.getString("INDENTSTATUS").equals("4"))
						{
							%>
								<td>&nbsp;<font color=red><b><%=mStatus%></b></font></td>
								<td>&nbsp;&nbsp;&nbsp;--<!-- <input type="checkbox" value="Z" readonly name="chec" > --></td>
							<%				
						}
					%>																	
						</tr>
					<%
				}
				%>
					<tr>
						<td colspan=6 align="center"><input type="submit" name="mApprove" value="Approve"  style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 70px; HEIGHT: 23px; FONT-VARIANT: normal; cursor:hand; border-width:1;" onclick="return fun();"> 
						<input type="submit" name="mApprove" value="Cancel"  style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 70px; HEIGHT: 23px; FONT-VARIANT: normal; cursor:hand; border-width:1;" onclick="return fun();"> </td>
					</tr>
				<table>
				</center>
				<input type="hidden" value="<%=mSlno%>" name="counter">
				<%				
				if(mesg.equals("")&& count==0)
				{
					out.print("<center><img src='../../../Images/Error1.jpg'>");
					out.print("&nbsp;&nbsp;&nbsp <b><font size=2 face='Arial' color='red'>Sorry no record present</font></center>");
				}
				%>
				</form>
				<%				
			}
			catch(Exception e)
			{}
		}
		else
		{
			%>
				<br>
				<font color=red>
				<h3>	<br><img src='../../../Images/Error1.jpg'Access Denied (authentication_failed) </h3><br>
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
</body>
</html>