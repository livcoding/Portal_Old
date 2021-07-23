<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%
DBHandler db=new DBHandler();
ResultSet Rs=null, rs=null,rsi=null,rs1=null;
GlobalFunctions gb =new GlobalFunctions();
OLTEncryption enc=new OLTEncryption();
int mWFSeq=0;
String qry="",mRID="";
String mMemberID="", mDMemberID="";
String mMemberType="", mDMemberType="", mMemberCode="", mDMemberCode="";
String mMemberName="", mDT="";
String mInst="";
String memID="", mEmpName ="",mEmpCode ="",memType="",msbj="",DT ="";

if (session.getAttribute("InstituteCode")==null)
	mInst="JIIT";
else
	mInst=session.getAttribute("InstituteCode").toString().trim();

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
<TITLE>#### <%=mHead%> [ Read Information Message First Time ] </TITLE>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<script language=javascript>
	if(window.history.forward(1) != null)
		window.history.forward(1);	
</script>
<STYLE>input {font-size:13px;}</STYLE>
</HEAD>
</head>
<body aLink="#ff00ff" bgcolor="#fce9c5" leftmargin="0" topmargin="0">
<hr>
<table align=center width='100%'>
<tr>
<td><b>Member Name: <%=mMemberName%></b></td>
<td><b>Member Code: <%=enc.decode(mMemberCode)%></b></td>
</tr>
</table>
<hr>

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

		qry="Select WEBKIOSK.ShowLink('164','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	        RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
			
			%>
	
			<table border=1 bgcolor=white>
			<tr bgcolor=Brown>
			<td><font color=white face='Verdana'><b>Sno</b></font></td>
			<td><font color=white face='Verdana'><b>Message From</b></font></td>
			<td><font color=white face='Verdana'><b>Subject</b></font></td>
			<td><font color=white face='Verdana'><b>Date Time</b></font></td>
			<td><font color=white face='Verdana'><b>Delete?</b></font></td>
			</tr>

			<%
			int cc=0;
			qry="SELECT trim(MSGFROMUSERD)||trim(MSGFROMMEMBERTYPE)||trim(to_char(MSGDATETIME,'yyyymmddhh24missss')) rid, MSGFROMUSERD, MSGFROMMEMBERTYPE, MSGSUBJECT, MSGTEXT, to_char(MSGDATETIME,'dd-Mon-yyyy HH:MI PM') DT , nvl(READLASTTIME,'N') FROM MESSAGESLIST Where  INSTITUTECODE='"+mInst+"' And MSGTOUSERD='"+ mDMemberID+"' And MSGTOMEMBERTYPE='"+mDMemberType+"' And nvl(DEACTIVE,'N')='N' Order By  DT Desc";
			RsChk=db.getRowset(qry);
			
			try
			{
			while (RsChk.next())
			{
			//out.print(qry);	
	
				memID=RsChk.getString("MSGFROMUSERD");

				memType=RsChk.getString("MSGFROMMEMBERTYPE").trim();

				msbj=RsChk.getString("MSGSUBJECT");

				DT = RsChk.getString("DT");

				mRID=RsChk.getString("RID");

				if(memType.equals("E"))
				{
				    qry="SELECT nvl(EMPLOYEENAME,' ')ENAME, nvl(EMPLOYEECODE,' ')ECODE from V#EmployeeList WHERE EMPLOYEEID='"+memID+"'";
				}
				else if(memType.equals("S"))
				{
					qry="SELECT nvl(STUDENTNAME,' ')ENAME, nvl(ENROLLMENTNO,' ')ECODE from  V#StudentList WHERE StudentID='"+memID+"' And INSTITUTECODE='"+mInst+"'";
				}
				else  if(memType.equals("G"))
				{
					qry="SELECT nvl(GuestNAME,' ')ENAME, nvl(GuestID,' ')ECODE from  V#GuestList WHERE GuestID='"+memID+"' And INSTITUTECODE='"+mInst+"'";
				}
				Rs=db.getRowset(qry);
				 
				
				if(Rs.next())
				{
					 
					mEmpName = Rs.getString("ENAME");
					mEmpCode = Rs.getString("ECODE");					 
					cc++;
					%>
					<tr>
					<td><font color=black face='Verdana' size=2><%=cc%></font></td>
					<td><font color=black face='Verdana' size=2><%=mEmpName%> (<%=mEmpCode%>)</font></td>
					<td><A href='ReadINBOXMsgAction.jsp?mrid=<%=mRID%>' Title='Click to view Detailled'><font color=black face='Verdana' size=2><%=msbj%></font></a></td>
					<td><font color=black face='Verdana' size=2><%=DT%></font></td>
					<td><font color=black face='Verdana' size=2><a href='DeleteINBOXMsg.jsp?mrid=<%=mRID%>'>Delete</A></font></td>
					</tr>
					<%		
				}
			}
			}
			catch(Exception e){ }
				%>

				</table>
				<%


		}
		else
		{
			%>
			<br>
			<font color=red>
			<h3><br><img src='../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br><P>This page is not authorized/available for you.
			<br>For assistance, contact your network support team. 
			</font><br><br><br><br> 
			<%
		}
		//-----------------------------
	}
	else
	{
		out.print("<br><img src='../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}
}
catch(Exception e)
{	
	//out.print("Exception e"+qry);	
}
%>
</form>
</body>
</html>