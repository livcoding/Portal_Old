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
String mEmployeeName="",mEmployeeCode="",mDepartment="";
String mMemberID="", mDMemberID="",mIndentDate="",mDesignation="";
String mMemberType="", mDMemberType="", mMemberCode="", mDMemberCode="";
String mMemberName="", mDept="", mDegs="",mDesignation1="";
String mInstitute="",mInst="",mtext="",mDate1="",mCurrDate="";
String mQuliRemarks="",mGender="",mCategory1="",mEmpType="";
String mIndentStatus="",mDesignationCode="",mQualiRemarks="";
ArrayList mQaliArrayList=new ArrayList();
int mSlno=0,flag=0;
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
<TITLE>#### <%=mHead%> [ Required Qualification for Man Power Indent] </TITLE>
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
			<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4>Required Qualification for Man Power Indent</FONT></u></b></td>
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
			%>
			<center>
			<table cellpadding="0" cellspacing="0" class="sort-table" id="table-1"  border="1">
			<tr bgcolor="#ff8c00">
				<td>&nbsp;<font color="white"><b>Slno</b></font></td>
				<td align="center">&nbsp;<font color="white"><b>Select</b></font></td>
				<td>&nbsp;<font color="white"><b>Qualification</b></font></td>
			</tr>
			<%
			try
			{
				if(request.getParameter("x")==null)
				{
					session.removeAttribute("Qualification");
					session.removeAttribute("Qualification");
					session.removeAttribute("QualiRemarks");
				}
				qry="Select QUALIFICATIONCODE, QUALIFICATION from QUALIFICATIONMASTER where nvl(DEACTIVE,'N')<>'Y'";
				//out.println(qry);
				rs=db.getRowset(qry);
				while(rs.next())
				{
					%>
					<tr>
						<td>&nbsp;<%=++mSlno%>.</td>
						<td align="center">&nbsp;<input type="checkbox" name="check<%=mSlno%>" value="N"></td>
						<td>&nbsp;<%=rs.getString("QUALIFICATION")%></td>
						<input type="hidden" value="<%=rs.getString("QUALIFICATION")%>" name="Quali<%=mSlno%>">
						<input type="hidden" value="<%=rs.getString("QUALIFICATIONCODE")%>" name="QualiCode<%=mSlno%>">
					</tr>
					<%
				}
			}catch(Exception e)
			{/*out.println("Exception e:-"+e);*/}		
		%>
		<tr>
			<td colspan=2><b>Remarks<br>(Max. 300 Chars.)</b></td><td><TEXTAREA NAME="QualiRemark" id="QualiRemark" ROWS="3" COLS="40"></TEXTAREA>
			</td>
		</tr>
		<tr>
			<td align="center"colspan=4><input style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 50px; HEIGHT: 23px; FONT-VARIANT: normal" type="submit" name="submit" value="Save"></center></td>
		</tr>
		</center>
		</table>		
		<input type="hidden" value="<%=mSlno%>" name="count">
		</form>
		<form name="frm2"  method="get" >
		<input id="x" name="x" type=hidden>
		<input id="y" name="y" type=hidden>
		<input type="hidden" value="<%=request.getParameter("count")%>" name="count">
		<%
		if(request.getParameter("x")!=null)
		{			
			if(request.getParameter("QualiRemark")==null)
				mQualiRemarks="";
			else
				mQualiRemarks=request.getParameter("QualiRemark");			
			if(mQualiRemarks.length()<=150)
			{			
				for(int i=1;i<(Integer.parseInt(request.getParameter("count"))+1);i++)
				{
					if(request.getParameter("check"+i)!=null)
					{					
						String qq=request.getParameter("Quali"+i);
						qq=qq+"***"+request.getParameter("QualiCode"+i)+"%%%";
						mQaliArrayList.add(qq);
						flag++;					
					}					
				}
				if(flag>0)
				{
					mSlno=0;
					session.setAttribute("Qualification",mQaliArrayList);
					mQaliArrayList=(ArrayList)session.getAttribute("Qualification");
					Iterator iter=mQaliArrayList.iterator();			
					%>				
					<center>
					<table cellpadding="0" cellspacing="0" border="1" width=60% rules="groups">
					<tr>
						<td align="center"><b>Select Main Qualification</b><hr></td>
					</tr>
					<tr>
						<td align="center">
						<select name="MainQuali" id="MainQuali">
						<%	
						while(iter.hasNext())
						{	
							String ses=(String)iter.next();								
							String ses1=ses.substring(0,ses.indexOf("***"));	
							String ses2=ses.substring(ses.indexOf("***")+3,ses.indexOf("%%%"));	
							%>
								<option Selected value="<%=ses2%>"><%=ses1%></option>
							<%
						}
						%>
						</select>
					<input type="submit" style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 150px; HEIGHT: 23px; FONT-VARIANT: normal"name="submit" value="Main Qualification">
					</tr>
					</table>
					</center>		
					<input type="hidden" value=<%=mQualiRemarks%> name="QualiRemarks">
					<%			
				}
				else
				{		
					out.print("<center><img src='images/Error1.jpg'> ");
					out.println("<font size=2 face='arial' color=red><b>Please fill the from properly....</center></b></font>");
				}
			}
			%>
			</form>
			<%
			if(request.getParameter("y")!=null)
			{
				String mMainQualification=request.getParameter("MainQuali");				
				mQualiRemarks="";
				if(request.getParameter("QualiRemarks")==null)
					mQualiRemarks="";
				else
					mQualiRemarks=request.getParameter("QualiRemarks");
				session.setAttribute("QualiRemarks",mQualiRemarks);
				session.setAttribute("MainQqali",mMainQualification);
				%>
				<script>
				window.close();
				</script>
				<%
			}		
		}		
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