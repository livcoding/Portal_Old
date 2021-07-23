<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
GlobalFunctions gb =new GlobalFunctions();
int mSno=0, count=0;
String qry="",qry1="";
String mColor="",mComp="",TRCOLOR="White";
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInst="";
String mFacultyName="",mFaculty="", mMsg="";
String QryFaculty="",mEID="",mENM="",mcolor="";
String mCurDate="",mDate1="",mDate2="",mPrevDate="" ;

qry="select to_Char(Sysdate,'dd-mm-yyyy')date1 from dual";
rs=db.getRowset(qry);
rs.next();
mCurDate=rs.getString("date1");


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

if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Self Leave Status] </TITLE>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<SCRIPT LANGUAGE="JavaScript"> 
function un_check()
{
 for (var i = 0; i < document.frm1.elements.length; i++) 
 {
  var e = document.frm1.elements[i]; 
  if ((e.name != 'allbox') && (e.type == 'checkbox')) 
  { 
   e.checked = document.frm1.allbox.checked;
  }
 }
}
</SCRIPT>
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
</script>
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
</head>
<body aLink=#ff00ff bgcolor='#fce9c5' rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
try
{
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{
		OLTEncryption enc=new OLTEncryption();
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
		qry="Select WEBKIOSK.ShowLink('173','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
			 //----------------------
	%>
	<form name="frm"  method="post" >
	<input id="x" name="x" type=hidden>
	<table id=id1 width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Self Leave Status</B></TD>
	</font></td></tr>
	</TABLE>
	<%
	if (request.getParameter("x")!=null)
	{
	mDate1=request.getParameter("DATE1").toString().trim();
	mDate2=request.getParameter("DATE2").toString().trim();
	}
	else
	{
	mDate1=mCurDate;
	mDate2=mCurDate;
	}
	%>
	<TABLE rules=none cellSpacing=0 cellPadding=4 border=2 align=center >
	<tr><td nowrap><font color=black face=arial font size=2><b><b>Leave Request From</b></font><font color=green face=arialblack font size=2><b> (DD-MM-YYYY)&nbsp;</b></font></td>
	<td><INPUT TYPE="text" NAME=DATE1 ID=DATE1 size=9 tabindex=1 VALUE='<%=mDate1%>'
	onTextChange="ChangeOnLeaveStatus()" READONLY><a href="javascript:NewCal('DATE1','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>
	</td><td><b>&nbsp;to&nbsp;</b></td>
	<td><INPUT TYPE="text" NAME=DATE2 ID=DATE2 size=9 tabindex=2
	VALUE='<%=mDate2%>'onTextChange="ChangeOnLeaveStatus()" READONLY><a href="javascript:NewCal('DATE2','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>&nbsp;</td>
	<TD><INPUT TYPE="submit"  VALUE="View Status"></TD> 
	</tr>
	</table>
	</form>
	<%
	if (request.getParameter("x")!=null)
	{
	if(request.getParameter("DATE1")==null)
		mDate1="";
	else
		mDate1=request.getParameter("DATE1").toString().trim();
	
	if(request.getParameter("DATE2")==null)
		mDate2="";
	else
		mDate2=request.getParameter("DATE2").toString().trim();
	}	
	%>
	<table  width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B><u>Available List</u> </B></TD>
	</font></td>	
	</table>
	<table class="sort-table" id="table-1" border=1 leftmargin=0 cellpadding=0 cellspacing=0 align=center width=90%>
	<thead>
	<tr bgcolor="#ff8c00">
	<td align=left rowspan=2 nowrap><font color=white><B>SrNo</B></font></td>
	<td align=left rowspan=2 nowrap><font color=white><B>RequestID</B></font></td>
	<td align=center rowspan=2 nowrap><font color=white><B>Leave<br>Code</B></font></td>
	<td align=center nowrap colspan=2><font color=white><B>Period</B></font></td>
	<td align=center rowspan=2 nowrap><font color=white><B>Purpose of Leave</B></font></td>
	<td align=center rowspan=2 nowrap Title="See Approval Status"><b><font color="white"></font><font color="white">Status</font></b></td>
	</tr>
	<tr bgcolor="#ff8c00">
	<td align=center nowrap><font color=white><B>Start Date</B></font></td>
	<td align=center nowrap><font color=white><B>End Date</B></font></td>
	</tr>
	</thead>
	<tbody>
	<%
		//System.out.println("aaa"+mDate1+" "+mDate2);
		qry="Select Distinct nvl(REQUESTID,' ')REQUESTID,LEAVECODE LEAVE,to_char(STARTDATE,'dd-mm-yyyy')SDATE, "; 
		qry=qry+" nvl(to_char(ENDDATE,'dd-mm-yyyy'),'')EDATE,";
		qry=qry+" nvl(PURPOSEOFLEAVE,' ')POL,";
		qry=qry+" decode(STATUS,'A','Approved','C','Canceled','Pending')STATUS FROM  LEAVEREQUEST  where  "; 
		qry=qry+"EMPLOYEEID='"+mChkMemID+"' and COMPANYCODE='"+mComp+"' and ENTRYDATE between to_date('"+mDate1+"','dd-mm-yyyy') ";
		qry=qry+" and to_date('"+mDate2+"','dd-mm-yyyy') ORDER BY REQUESTID ";
		//out.print(qry);
		rs=db.getRowset(qry);
			String mPOL="";
		while(rs.next())
		{
			mPOL=rs.getString("POL");
			if(mPOL.length()>=15)
			mPOL=mPOL.substring(0,15)+"....";
			
			%>	
			<tr>
			<td nowrap align=left><%=++mSno%></td>	
			<td nowrap align=left><%=rs.getString("REQUESTID")%></td>	
			<td nowrap align=left><%=rs.getString("LEAVE")%></td>	
			<td nowrap align=center><%=rs.getString("SDATE")%></td>	
			<td nowrap align=center><%=rs.getString("EDATE")%></td>
				<td nowrap align=center>&nbsp;<a Title="View Message Details '<%=rs.getString("POL")%>' "><font color=blue><%=mPOL%></font></a></td>
			<td nowrap align=center><font color=blue> <%=rs.getString("STATUS")%></font></td>
			</tr>
			<%
		}
		%>
		</tbody>
		</table>
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
	<h3><br><img src='../../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
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
	//out.print("Exception "+e);
}
%>
</body>
</html>
