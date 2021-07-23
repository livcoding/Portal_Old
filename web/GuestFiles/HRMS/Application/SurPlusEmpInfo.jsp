<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null,rsi=null;
GlobalFunctions gb =new GlobalFunctions();
OLTEncryption enc=new OLTEncryption();
String qry="";
String mComp="JIIT";
int mSno=0;
String mFacultyName="",mFaculty="",QryFaculty="";
String QryReason="";
String mMemberID="", mDMemberID="";
String mMemberType="", mDMemberType="";
String mMemberCode="", mDMemberCode="";
String mMemberName="";
String mDept="", mDegs="";
String mInstitute="",mInst="",mtext="";
String mDate="", mCurrDate="",mRightsID="144";

qry="select to_Char(Sysdate,'dd-mm-yyyy') date1  from dual";
rs=db.getRowset(qry);
rs.next();
mCurrDate=rs.getString("date1");

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

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Surplus Staff Entry ] </TITLE>
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

 //----------------------
%>
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>

	<table id=id1 width="852" ALIGN=CENTER  topmargin=0 cellspacing=0 cellpadding=0 rightmargin=0 leftmargin=0 bottommargin=0 >
 <!-------------Page Heading and Marquee Message----------------------->
<%
try
{
	String mPageHeader="Surplus Staff Entry", mMarqMsg="", CurrDate="";
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
</table>
<table cellpadding=2 cellspacing=0 width="100%" align=center rules=groups border=1>
<!*********--Institute--************>
<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
<%
	qry="select distinct nvl(institutecode,' ')IC from INSTITUTEMASTER where nvl(DEACTIVE,'N')='N' ";
	rsi=db.getRowset(qry);
	while(rsi.next())
	{
		mInst=rsi.getString("IC");
	}
%>
<tr><td colspan=2><font color=black face=arial size=2><STRONG>Staff &nbsp;</STRONG>
<%
	qry="select distinct nvl(EMPLOYEEID,' ')Faculty, nvl(EMPLOYEENAME,' ')FacultyName from EMPLOYEEMASTER where DEPARTMENTCODE in (select DEPARTMENTCODE from ";
	qry=qry +" hodlist where employeeid='"+mChkMemID+"' and nvl(deactive,'N')='N') and nvl(deactive,'N')='N' order by FacultyName ";

	//out.print(qry);
	rs=db.getRowset(qry);
	%>
	<select name="Faculty" tabindex="0" id="Faculty" style="WIDTH: 230px" >
	<%   	
	if(request.getParameter("x")==null)
	{	
		while(rs.next())
		{
		 	mFaculty=rs.getString("Faculty");
			if(QryFaculty.equals(""))
			{
				QryFaculty="mFaculty";
			}
		 	mFacultyName=rs.getString("FacultyName");
			%>
				<option value=<%=mFaculty%>><%=mFacultyName%></option>
			<%
			
		}
	}
	else
	{
		while(rs.next())
		{
	   		mFaculty=rs.getString("Faculty");
			QryFaculty="mFaculty";
		   	mFacultyName=rs.getString("FacultyName");
		   	if(mFaculty.equals(request.getParameter("Faculty").toString().trim()))
			{
			   QryFaculty=mFaculty;
			   %>
	    			<option selected value=<%=mFaculty%>><%=mFacultyName%></option>
		  	   <%
		  	}
			else
      		{		
	   		   %>
	    			<option  value=<%=mFaculty%>><%=mFacultyName%></option>
	   		   <%
		}	
	}
}
%>
</select>
&nbsp; &nbsp;<b><font color=black face=arial size=2>Surplus From</font> <font size=2 color=teal><b>(DD-MM-YYYY)</b></font>&nbsp; 
<%
if (request.getParameter("x")!=null)
{
	mDate=request.getParameter("TXT").toString().trim();
}
else
{
	mDate=mCurrDate;
}

%>
<input Name=TXT Id=TXT Type=text maxlength=10 size=8 value='<%=mDate%>' READONLY><a href="javascript:NewCal('TXT','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>
</td></tr>
<tr><td colspan=2><b>Reason/Remarks (Maximum 300 Characters) </b><br>
	<TextArea Name='TEXT' Id='TEXT' maxlength=300 cols=68 rows=3></TextArea>
<FONT color=red>*</FONT>
<INPUT id=submit1 style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 50px; HEIGHT: 23px; FONT-VARIANT: normal" type=submit size=5 value="Save" name=submit1></td></tr>
</table>
<%	
	if(request.getParameter("x")!=null)
	{
		if (request.getParameter("Faculty")!=null)
			QryFaculty=request.getParameter("Faculty").toString().trim();
		else
			QryFaculty="";

		if (request.getParameter("TEXT")!=null)
			QryReason=request.getParameter("TEXT").toString().trim();
		else
			QryReason="";

		if (request.getParameter("TXT")!=null)
			mDate=request.getParameter("TXT").toString().trim();
		else
			mDate=mCurrDate;

		qry="Select TO_CHAR(SURPLUSDATE,'DD-MM-YYYY')SURPLUSDATE, NVL(REASON,' ')REASON, NVL(SURPLUSFROMDEPARTMENT,' ')SURPLUSFROMDEPARTMENT, NVL(SURPLUSFROMDESIGNATION,' ')SURPLUSFROMDESIGNATION from HR#SURPLUSSTAFF where EMPLOYEEID='"+QryFaculty+"'";
		rs= db.getRowset(qry);		  
		if (!rs.next())
		{
		   if(!QryReason.equals(""))
		   {
			QryReason=GlobalFunctions.replaceSignleQuot(QryReason);

			qry="Select nvl(A.DEPARTMENTCODE,' ') DEPARTMENTCODE, nvl(B.DEPARTMENT,' ')DEPARTMENTNAME, nvl(A.DESIGNATIONCODE,' ') DESIGNATIONCODE, nvl(C.DESIGNATION,' ')DESIGNATIONNAME ";
			qry=qry+" FROM EMPLOYEEMASTER A, DEPARTMENTMASTER B, DESIGNATIONMASTER C Where A.COMPANYCODE='"+mComp+"' ";
			qry=qry+" and A.EMPLOYEEID='"+QryFaculty+"' AND A.DEPARTMENTCODE=B.DEPARTMENTCODE AND A.DESIGNATIONCODE=C.DESIGNATIONCODE";
			//out.print(qry);
			rs= db.getRowset(qry);		  
			if (rs.next())
			{
				mDept=rs.getString("DEPARTMENTCODE");
				mDegs=rs.getString("DESIGNATIONCODE");
			}
 			qry="INSERT INTO HR#SURPLUSSTAFF (INSTITUTECODE, COMPANYCODE, EMPLOYEEID, SURPLUSDATE, REASON, SURPLUSFROMDEPARTMENT, SURPLUSFROMDESIGNATION, DEACTIVE, ENTRYBY, ENTRYDATE) ";
			qry=qry+" VALUES ('"+mInst+"','"+mComp+"','"+QryFaculty+"',(to_date('"+mDate+"','dd-mm-yyyy')),'"+QryReason+"','"+mDept+"','"+mDegs+"','N','"+mDMemberID+"',SYSDATE)";
			int n=db.insertRow(qry);
			//out.print(qry);
			if(n>0)
			{
				%><CENTER><%
				out.print("<img src='../../../Images/Error1.jpg'>");
				out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Green'>Selected Staff surplused successfully...</font> <br>");
				%></CENTER><%
			   // Log Entry
			   //-----------------
				db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"SURPLUS STAFF ENTRY BY HOD LOGIN", "Staff ID : "+QryFaculty+" DEPT : "+ mDept+" DEGS : "+ mDegs, "No MAC Address" , mIPAddress);
			   //-----------------
			}
		   }
		   else
		   {
			   %><CENTER><%
			   out.print("<img src='images/Error1.jpg'>");
			   out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Reason/Remarks for Surplus can't be Empty!</font> <br>");
			   %></CENTER><%
		   }	
		}
		else
		{
			%><CENTER><%
			out.print("<img src='images/Error1.jpg'>");
			out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Select Staff has already been Surplused!</font> <br>");
			%></CENTER><%
		}	
	}  //----------- closing of (request.getParameter("x")!=null)
	//else
	// Show Table in all cases
	qry=" SELECT B.EMPLOYEEID EMPLOYEEID, nvl(A.EMPLOYEENAME,' ')EMPLOYEENAME, to_char(B.SURPLUSDATE,'dd-mm-yyyy')SURPLUSDATE, nvl(B.REASON,' ')Remarks, ";
	qry=qry+" C.DEPARTMENT SDept, D.DESIGNATION SDegs FROM EMPLOYEEMASTER A, HR#SURPLUSSTAFF B, DEPARTMENTMASTER C, DESIGNATIONMASTER D"; 
	qry=qry+" Where B.INSTITUTECODE='"+mInst+"' and B.COMPANYCODE='"+mComp+"' "; 
	qry=qry+" And B.ENTRYBY='"+mDMemberID+"' and nvl(B.DEACTIVE,'N')='N' AND A.EMPLOYEEID=B.EMPLOYEEID";
	qry=qry+" and B.SURPLUSFROMDEPARTMENT=C.DEPARTMENTCODE AND B.SURPLUSFROMDESIGNATION =D.DESIGNATIONCODE";
	//out.print(qry);
    	rs= db.getRowset(qry);
	%>
	<table align=center width="100%" bottommargin=0 topmargin=0>
	<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4> List of Surplus Staff </FONT></u></b></font></td></tr>
	</table>
	<table class="sort-table" id="table-1" border=1 cellpadding=0 cellspacing=0 align=center>
		<thead>
			<tr bgcolor="#ff8c00">
				<td nowrap><font color=white><B><img alt="Delete?" src="../../../Images/Delete.jpg"></B></font></td>
				<td nowrap><font color=white><B>SurPlus Staff</B></font></td>
				<td nowrap><font color=white><B>Designation</B></font></td>
				<td nowrap><font color=white><B>Department</B></font></td>
				<td nowrap><font color=white><B>SurPlus From</B></font></td>						
				<td nowrap><font color=white><B>Reason</B></font></td>
			</tr>
		</thead>
		<tbody>
		<%
	mSno=0;
	String mRemarks="";
	while (rs.next())
	{
		mSno++;
		mRemarks=rs.getString("Remarks");
		if (rs.getString("Remarks").length()>25)
		mRemarks=mRemarks.substring(0,25)+"...";
		String mColor="Black";
		%>
		<tr>
		<td align=center title="Do you want to Delete a Surplus Staff Info? Cilck 'x' to Delete"><font color=<%=mColor%>><a href='DeleteSurPlusEmpInfo.jsp?Inst=<%=mInst%>&amp;Comp=<%=mComp%>&amp;Emp=<%=rs.getString("EMPLOYEEID")%>'><font color=blue><img alt="Delete" src="../../../Images/Delete.jpg"></font></a></font></td>
		<td><font color=<%=mColor%>><%=rs.getString("EMPLOYEENAME")%></font></td>					
		<td><font color=<%=mColor%>><%=GlobalFunctions.toTtitleCase(rs.getString("SDegs"))%></font></td>
		<td><font color=<%=mColor%>><%=GlobalFunctions.toTtitleCase(rs.getString("SDept"))%></font></td>
		<td><font color=<%=mColor%>><%=rs.getString("SURPLUSDATE")%></font></td>
		<td title="<%=rs.getString("Remarks")%>"><font color=<%=mColor%>><%=mRemarks%></font></td>
		</tr>
		<%
	}
	%>
	</tbody>
	</table>
	<script type="text/javascript">
	var st1 = new SortableTable(document.getElementById("table-1"),[,"CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString"]);
	</script>
	<%
	//-----------------------------
	//---Enable Security Page Level  
	//-----------------------------
	}
	else
	{
		%>
		<br>
		<font color=red>
		<h3>	<br><img src='images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
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
	//out.print("Catch Block");	
}
%>
</form>
</body>
</html>