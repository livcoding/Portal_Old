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
String mEmployeeName="",mEmployeeCode="",mDepartment="",mIndentNo="";
String mMemberID="", mDMemberID="",mIndentDate="",mDesignation="";
String mMemberType="", mDMemberType="", mMemberCode="", mDMemberCode="";
String mMemberName="", mDept="", mDegs="",mDesignation1="",mStatus="";
String mInstitute="",mInst="",mtext="",mDate1="",mCurrDate="",mBname="";
String mApprovedMan="",mRemarks="",mRequiredManPower="",mIndNo="";
String mAge="",mExp="";
int count=0,mValidation=0;
double mRequiredFaculty=0;
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
<TITLE>#### <%=mHead%> [ Approval for ManPower Indent Action ] </TITLE>
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
	function fun()
	{
		var val;
		val=document.frm.ApprovedMan.value;
		if(document.frm.Status.value=="C")
		{
			document.frm.ApprovedMan.disabled=true;
			document.frm.ApprovedMan.value='0';
		}
		else
		{
			document.frm.ApprovedMan.disabled=false;
			document.frm.ApprovedMan.value=val;
		}
	}
	function valueRemarks() 
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
		qry="Select WEBKIOSK.ShowLink('143','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	    RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
			// For Log Entry Purpose
			//--------------------------------------
			String mLogEntryMemberID="",mLogEntryMemberType="";
			if (session.getAttribute("LogEntryMemberID")==null ||	session.getAttribute("LogEntryMemberID").toString().trim().equals(""))
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
				<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4>Approval For ManPower Indent Action</FONT></u></b></td>
			</tr>
			</table>
			</center>
			<%
			qry="select distinct nvl(institutecode,' ')IC from INSTITUTEMASTER where nvl(DEACTIVE,'N')='N' ";
			rsi=db.getRowset(qry);
			while(rsi.next())
			{
				mInst=rsi.getString("IC");
			}			
			if(request.getParameter("x")==null)
			{
				if(request.getParameter("IndentNo")==null)
					mIndentNo="";
				else
					mIndentNo=request.getParameter("IndentNo");
				session.setAttribute("IntNo",mIndentNo);								
			}
			%>			
			<center>
			<table cellpadding="2" cellspacing="0" border=1 rules="groups" >
			<%			
			mIndNo=(String)session.getAttribute("IntNo");			
			try
			{
				qry="Select INDENTREFNO, to_char(INDENTDATE,'dd/mm/yyyy')INDENTDATE,to_char(REQUIREDDATE,'dd/mm/yyyy')REQUIREDDATE,nvl(A.REMARKS,' ')REMARKS, nvl(PLACEOFPOSTING,' ')PLACEOFPOSTING, TOTALEXPERIENCEREQ,E.EMPLOYEENAME EMPLOYEENAME,nvl(to_char(REQUIREDDATE,'dd/mm/yyyy'),' ')REQUIREDDATE,REQUIREDMANPOWER, nvl(GENDER,' ') GENDER, FROMAGEGROUP, nvl(TOAGEGROUP,0)TOAGEGROUP, B.EMPLOYEETYPEDESC,F.DEPARTMENT DEPARTMENT ,G.DESIGNATION DESIGNATION, C.EMPCATEGORYDESC EMPCATEGORYDESC,D.CATEGORY CATEGORY, nvl(JOBDESCRIPTION,' ')JOBDESCRIPTION from HR#MANPOWERINDENT A,EMPLOYEETYPEMASTER B,HR#EMPCATEGORYMASTER C,CATEGORYMASTER D,EMPLOYEEMASTER E ,DEPARTMENTMASTER F,DESIGNATIONMASTER G where INDENTBY='"+mChkMemID+"' and INDENTNO='"+mIndNo+"' and A.INDENTBY=E.EMPLOYEEID and A.INDENTDESIGNATIONCODE=G.DESIGNATIONCODE and A.INDENTDEPARTMENTCODE=F.DEPARTMENTCODE and A.EMPLOYEETYPE=B.EMPLOYEETYPE and A.EMPCATEGORYCODE=C.EMPCATEGORYCODE And A.CATEGORYCODE=D.CATEGORYCODE and nvl(A.DEACTIVE,' ')<>'Y' and nvl(B.DEACTIVE,' ')<>'Y' and nvl(D.DEACTIVE,' ')<>'Y' and nvl(C.DEACTIVE,' ')<>'Y' and nvl(E.DEACTIVE,' ')<>'Y' and nvl(F.DEACTIVE,' ')<>'Y' and nvl(G.DEACTIVE,' ')<>'Y'";
				//out.println(qry);
				rs=db.getRowset(qry);
				while(rs.next())
				{					
					%>
					<tr>
						<td colspan=4><font size="2" face="arial"><b>Indent By</b></font>
						<font size=2 color='navy'><b><%=rs.getString("EMPLOYEENAME")%></b></font>
						<font size="2" face="arial"><b>&nbsp;Department </b></font>
						<font size=2 color='navy'><b><%=GlobalFunctions.toTtitleCase(rs.getString("DEPARTMENT"))%></b></font>
						<font size="2" face="arial"><b>&nbsp;Designation</b></font> 
						<font size=2 color=navy><b><%=GlobalFunctions.toTtitleCase(rs.getString("DESIGNATION"))%></b></font><hr>
						</td>
					</tr>
					<tr>
						<td><font size="2" face="arial"><b>Indent Refrence No.  </b></font></td>
						<td><B>:</b> &nbsp;<%=rs.getString("INDENTREFNO")%></td>
						<td><font size="2" face="arial"><b>Indent date </b></font></td>
						<td><b>:</b> &nbsp;<%=rs.getString("INDENTDATE")%></td>
					</tr>
					<tr>					
						<td><font size="2" face="arial"><b>Require Date </b></font></td>
						<td><b>:</b> &nbsp;<%=rs.getString("REQUIREDDATE")%></td>
						<td><font size="2" face="arial"><b>Require ManPower  </b></font></td>
						<td><b>:</b> &nbsp;<%=rs.getString("REQUIREDMANPOWER")%></td>
					</tr>
					<tr>
						<td><font size="2" face="arial"><b>Req. Experience  </b></font></td>
						<%
						if(rs.getString("TOTALEXPERIENCEREQ").equals("0") || rs.getString("TOTALEXPERIENCEREQ").equals(""))						
							mExp="N/A";						
						else
							mExp=rs.getString("TOTALEXPERIENCEREQ")+"(Y)";
						%>
						<td><b>:</b> &nbsp;<%=mExp%></td>
						<td><font size="2" face="arial"><b>Req. Age From </b></font></td>
						<%
						if(rs.getString("TOAGEGROUP").equals("0") || rs.getString("TOAGEGROUP").equals(""))						
							mAge="N/A";						
						else
							mAge=rs.getString("TOAGEGROUP")+"(Y)";
						%>
						<td><b>:</b> &nbsp;<%=rs.getString("FROMAGEGROUP")%><font size="2" face="arial"><b> &nbsp;&nbsp;&nbsp;To </b></font><b>:</b> &nbsp;<%=mAge%></td>						
					</tr>
					<tr>
						<td><font size="2" face="arial"><b>Gender </b></font></td>
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
						<td><font size="2" face="arial"><b>Category </b></font></td>
						<td><b>:</b>  &nbsp;<%=GlobalFunctions.toTtitleCase(rs.getString("CATEGORY"))%></td>
					</tr>
					<tr>
						<td><font size="2" face="arial"><b>Emp. Category </b></font></td>
						<td><b>:</b>  &nbsp;<%=GlobalFunctions.toTtitleCase(rs.getString("EMPCATEGORYDESC"))%></td>					
						<td><font size="2" face="arial"><b>Emp. Type </b></font></td>
						<td><b>:</b>  &nbsp;<%=GlobalFunctions.toTtitleCase(rs.getString("EMPLOYEETYPEDESC"))%></td>
					</tr>
					<tr>
						<td><font size="2" face="arial"><b>Place Of Posting </b></font></td>
						<td colspan=3><b>:</b>  &nbsp;<%=GlobalFunctions.toTtitleCase(rs.getString("PLACEOFPOSTING"))%></td>
					</tr>
					<tr>
						<td><font size="2" face="arial"><b>Job Discription  </b></font></td>
						<td colspan=3><b>:</b> &nbsp;<%=GlobalFunctions.toTtitleCase(rs.getString("JOBDESCRIPTION"))%></td>
					</tr>
					<tr>
						<td><font size='2' face="arial"><b>Indent Remarks </b></font></td>
						<td colspan=3> <TEXTAREA NAME="remarks" ROWS="2" COLS="50" readonly><%=rs.getString("REMARKS")%></TEXTAREA></td>
					</tr>
					<%
					mRequiredManPower=rs.getString("REQUIREDMANPOWER");
				}
			%>
			</tr>			
			<%
			}catch(Exception e)
			{/*out.println("Exception e"+e);*/	}
			%>			
			<tr>
				<td><font size=2 face="arial"><b>Approve/Cancel</b></font></td>
				<td>
					<select name="Status" id="Status" onClick="return fun();">
						<%					
						if(request.getParameter("x")!=null)
						{							
							if(request.getParameter("Status")==null)
								mStatus="";
							else
								mStatus=request.getParameter("Status");							
							if(mStatus.equals("F"))
							{
								%>					 			
								<option value="F" Selected>Finalized</option>
								<option value="C">Cancel</option>
								<%
							}
							if(mStatus.equals("C"))
							{
								%>							 
								<option value="F">Finalized</option>
								<option value="C" selected>Cancel</option>
								<%
							}
						}
						else
						{
							%>	
							<option value="F">Finalized</option>
							<option value="C" >Cancel</option>
							<%
						}
						%>								
					</select>
				</td>
				<td nowrap colspan=2><font size=2 face="arial"><b>Approve ManPower</b></font>
				<%
					if(request.getParameter("x")!=null)
					{
						if(request.getParameter("ApprovedMan")==null)
							mApprovedMan="";
						else
							mApprovedMan=request.getParameter("ApprovedMan");
					}
					else
						mApprovedMan=mRequiredManPower;
				%>
				<input type="text" value="<%=mApprovedMan%>" maxlength=3 size=3 name="ApprovedMan" id="ApprovedMan" ></td>
			</tr>
			<tr>
				<td><font size="2" face="arial"><b> Remarks<br>(Max. 300 Chars.)</b></font></td>
				<%
					if(request.getParameter("x")!=null)
					{
						if(request.getParameter("Remarks")==null)
							mRemarks="";
						else
							mRemarks=request.getParameter("Remarks");
					}
					else
						mRemarks="";
				%>
				<td colspan=3><TEXTAREA NAME="Remarks" ROWS="2" COLS="50"><%=mRemarks%></TEXTAREA></td>
			</tr>
			<tr>
				<td colspan=2 align="right"><input style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 50px; HEIGHT: 23px; FONT-VARIANT: normal; cursor:hand; background-color:; border-width:1;" type="submit" name="save" value="Save" onClick="return valueRemarks()"></td>				
				<td colspan=2 align="left"><input style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 50px; HEIGHT: 23px; FONT-VARIANT: normal; cursor:hand; background-color:; border-width:1;" type="reset" name="reset" value="Reset">&nbsp;<input type="submit" name="save" value="Cancel" style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 55px; HEIGHT: 23px; FONT-VARIANT: normal; cursor:hand; background-color:; border-width:1;"></td>
			</tr>
			</TABLE>
			</center>
			<input type="hidden" value="<%=mRequiredManPower%>" name="RequiredManPower">		
			<%
			if(request.getParameter("x")!=null)
			{				
				if(request.getParameter("RequiredManPower")==null)
					mRequiredManPower="";
				else
					mRequiredManPower=request.getParameter("RequiredManPower");			
				if(request.getParameter("Remarks")==null)
					mRemarks="";
				else
					mRemarks=request.getParameter("Remarks");
				if(request.getParameter("Status")==null)
					mStatus="";
				else
					mStatus=request.getParameter("Status");
				if(request.getParameter("ApprovedMan")==null)
					mApprovedMan="";
				else
					mApprovedMan=request.getParameter("ApprovedMan");
				if(request.getParameter("save")==null)
					mBname="";
				else
					mBname=request.getParameter("save");
				if(mBname.equals("Save"))
				{				
					if(mStatus.equals("A")&& (mApprovedMan.equals("") || mApprovedMan.equals("0")))
						mValidation=5;
					if(!mApprovedMan.equals(""))
					{
						try
						{
							if(Integer.parseInt(mApprovedMan)<=0 ||	Integer.parseInt(mApprovedMan)>Integer.parseInt(mRequiredManPower))
								mValidation=2;
							else
								mValidation=0;					 
						}catch(Exception e)
						{ 
							//out.println("Exception e"+e);
							mValidation=1;
						}
					}
					if(mRemarks.length()>300)
						mValidation=3;
					if(mStatus.equals("P"))
						mValidation=4;
					if(mValidation==0)
					{
						try
						{
							qry="UPDATE HR#MANPOWERINDENT SET AUTORIZEDREMARKS='"+mRemarks+"', APPROVEDMANPOWER='"+mApprovedMan+"', AUTORIZEDSTATUS='"+mStatus+"', AUTORIZEDBY='"+mChkMemID+"', AUTORIZEDDATE=sysdate, DEACTIVE=' ',INDENTSTATUS='"+mStatus+"' where INDENTNO='"+mIndNo+"' ";
							//out.println(qry);
							int n=db.insertRow(qry);
							if(n>0)
							{
								out.print("<center><img src='../../../Images/Error1.jpg'>");
								out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Green'>Man Power Indent entered successfully...</font></center>");
								session.removeAttribute("IntNo");
								response.sendRedirect("ManPowerIndentApproval.jsp");
							}
							else
								out.println("------Error:-------");
						}catch(Exception e)
						{
							//out.println("Exception e"+e);
						}
					}
					else	if(mValidation==1)					  
							{
								out.print("<center><img src='../../../Images/Error1.jpg'>");
								out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='red'>Approve Man Power must be numeric...</font></center>");
							}
					else	if(mValidation==2)					  
							{
								out.print("<center><img src='../../../Images/Error1.jpg'>");
								out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='red'>Approved Man Power must be greater than zero or must be less than Required ManPower...</font></center>");
							}
					else	if(mValidation==3)					  
							{
								out.print("<center><img src='../../../Images/Error1.jpg'>");
								out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='red'>Remarks must be Less than 300 characters.</font></center>");
							}					
					else	if(mValidation==4)					  
							{
								out.print("<center><img src='../../../Images/Error1.jpg'>");
								out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='red'>Status must be other than Pending</font></center>");
							}
					else	if(mValidation==5)					  
							{
								out.print("<center><img src='../../../Images/Error1.jpg'>");
								out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='red'>Approve ManPower can not be blank</font></center>");
							}						
				}	
				else
				{
					response.sendRedirect("ManPowerIndentApproval.jsp");
				}
			}
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