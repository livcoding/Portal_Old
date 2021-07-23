<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../../CommonFiles/ExceptionHandler.jsp" %>
<%
DBHandler db=new DBHandler();
GlobalFunctions gb=new GlobalFunctions();
ResultSet rs=null;
String qry="";
String mComp="",TRCOLOR="White";
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="",mInst="";
String mEmpID="",mEmpName="",mEmpCode="",QryEmp="",mRightsID="178";
int Count=0;

if(session.getAttribute("MemberID")==null)
{
	mMemberID="";
}
else
{
mMemberID=session.getAttribute("MemberID").toString().trim();
}
if(session.getAttribute("MemberType")==null)
{
	mMemberType="";
}
else
{
mMemberType=session.getAttribute("MemberType").toString().trim();
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
if(session.getAttribute("PageHeading")!=null && session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
		else
	mHead="JIIT";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Cancel Leave Request For NOC] </TITLE>

<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>


</head>
<body aLink=#ff00ff bgcolor='#fce9c5' topmargin=0 rightmargin=0 leftmargin=0 bottommargin=0 >
<%
try
{
	if(!mMemberID.equals("") && !mMemberCode.equals(""))
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
		qry="Select WEBKIOSK.ShowLink('162','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{
			qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from InstituteMaster Where nvl(Deactive,'N')='N' ";
			rs=db.getRowset(qry);
			if (rs.next())
				mInst=rs.getString(1);
			else
				mInst="JIIT";	
		%>
			<table id=id1 width="852" ALIGN=CENTER  topmargin=0 cellspacing=0 cellpadding=0 rightmargin=0 leftmargin=0 bottommargin=0 >
	<!-------------Page Heading and Marquee Message----------------------->
<%
try
{
	String mPageHeader="Cancel Leave Request for NOC", mMarqMsg="", CurrDate="";
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
</table>

		<form name="frm"  method="post"> 
		<input id="x" name="x" type=hidden>

		<table cellpadding=4 cellspacing=1 border=1 align=center >
		<tr>
		 <td>
		   <font face='arial' size=2 color=black ><strong> Employee </strong>
		   </font>
<%
	String mSrcType="D";

	if(mSrcType.equals("D"))
	{
		qry="select distinct nvl(A.EMPLOYEEID,' ')EMPLOYEEID, nvl(A.EMPLOYEENAME,' ')EMPLOYEENAME, nvl(A.EMPLOYEECODE,' ')EMPLOYEECODE from EMPLOYEEMASTER A,EMPLOYEELEAVING B where A.EMPLOYEEID=B.EMPLOYEEID and NVL(B.NODUESSTATUS,'D')='D' and NOT EXISTS (SELECT W.REQUESTID FROM WF#WORKFLOWDETAIL W WHERE W.REQUESTID=B.REQUESTID) "; 
	
	}
	else if(mSrcType.equals("H"))
	{
		qry="SELECT distinct nvl(EMPLOYEENAME,' ')EMPLOYEENAME,nvl(EMPLOYEEID,' ')EMPLOYEEID,EMPLOYEECODE  FROM V#STAFF  WHERE  DEPARTMENTCODE IN (SELECT DEPARTMENTCODE  FROM HODLIST WHERE EMPLOYEEID='"+mChkMemID+"' AND  NVL(DEACTIVE,'N')='N') AND EMPLOYEEID IN (SELECT EMPLOYEEID FROM EMPLOYEELEAVING where NVL(NODUESSTATUS,'D')='D') AND NVL(DEACTIVE,'N')='N' ORDER BY EMPLOYEENAME "; 
	}
	else if(mSrcType.equals("I"))
	{
		qry="select distinct nvl(A.EMPLOYEEID,' ')EMPLOYEEID,nvl(A.EMPLOYEENAME,' ')EMPLOYEENAME, ";
		qry=qry+" nvl(A.EMPLOYEECODE,' ')EMPLOYEECODE from EMPLOYEEMASTER A,EMPLOYEELEAVING B where A.EMPLOYEEID=B.EMPLOYEEID and B.EMPLOYEEID='"+mChkMemID+"' "; 
	}
	rs=db.getRowset(qry);
	%>
	<select name="EMPLOYEEID" tabindex=1 id="EMPLOYEEID" >
	<%   	
	if(request.getParameter("x")==null)
	{	
		while(rs.next())
		{
		 	mEmpID=rs.getString("EMPLOYEEID");
			if(QryEmp.equals(""))
			{
				QryEmp=mEmpID;
			}
		 	mEmpName=rs.getString("EMPLOYEENAME");
			mEmpCode=rs.getString("EMPLOYEECODE");
			%>
			<option value=<%=mEmpID%>><%=mEmpName%>(<%=mEmpCode%>)</option>
			<%
		}
	}
	else
	{
		while(rs.next())
		{
	   		mEmpID=rs.getString("EMPLOYEEID");
		   	mEmpName=rs.getString("EMPLOYEENAME");
		   	mEmpCode=rs.getString("EMPLOYEECODE");
			if(mEmpID.equals(request.getParameter("EMPLOYEEID").toString().trim()))
			{
				%>
	   			<option selected value=<%=mEmpID%>><%=mEmpName%>(<%=mEmpCode%>)</option>
		  		<%
		  	}
			else
      		{
				%>
	   			<option value=<%=mEmpID%>><%=mEmpName%>(<%=mEmpCode%>)</option>
				<%
			}
		}
	}
	%>
	</select>&nbsp;&nbsp;&nbsp;&nbsp;
	<input type=submit name=submit value="Submit" >
	</td>
	</tr>
	</table>
	<BR>
<%
	if(request.getParameter("x")!=null)
		{
			if(request.getParameter("EMPLOYEEID")==null)
				QryEmp="";
			else
				QryEmp=request.getParameter("EMPLOYEEID").toString().trim();

		}
	try
	{
		qry="SELECT nvl(B.EMPLOYEENAME,' ')EMPLOYEENAME,nvl(B.EMPLOYEEID,' ')EMPLOYEEID,nvl(to_char(A.REPORTINGDATE,'dd-mm-yyyy'),' ')REPORTINGDATE ,nvl(to_char(A.DATEOFRELIEVING,'dd-mm-yyyy'),' ')DATEOFRELIEVING, nvl(A.REMARKS,' ')REMARKS,decode(A.NOTICEDAYS,'',' ',A.NOTICEDAYS)NOTICEDAYS,decode(A.TYPE,'R','Resign','T','Transfer')TYPE FROM EMPLOYEELEAVING A,EMPLOYEEMASTER B WHERE A.EMPLOYEEID=B.EMPLOYEEID AND NVL(A.NODUESSTATUS,'D')='D' AND A.EMPLOYEEID='"+QryEmp+"' and NOT EXISTS (SELECT W.REQUESTID FROM WF#WORKFLOWDETAIL W WHERE W.REQUESTID=A.REQUESTID) ";
		//out.print(qry);
		rs=db.getRowset(qry);
		while(rs.next())
		{
		if(Count==0)
			{
		%>
		<table  width=100% ALIGN=CENTER bottommargin=0  topmargin=0>
		<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B><u>Available List</u> </B></TD>
		</font></td>	
		</table>
		<table class="sort-table" id="table-1" border=1 leftmargin=0 cellpadding=0 cellspacing=0 align=center width=90%>
		<thead>
		<tr bgcolor="#ff8c00">
		<td align=center ><font color=white><b>Staff</b></font></td>
		<td align=center ><font color=white><b>RequestDate</b></font></td>
		<td align=center ><font color=white><b>RelevingDate</b></font></td>
		<td align=center ><font color=white><b>Type</b></font></td>
		<td align=center ><font color=white><b>NoticeDays</b></font></td>
		<td align=center ><font color=white><b>Action !</b></font></td>
		</tr>
		</thead>
	<%
		Count++;
		}	
	%>
		<tbody>
		<tr>
		<td nowrap align=center ><%=rs.getString("EMPLOYEENAME")%></td>
		<td nowrap align=center ><%=rs.getString("REPORTINGDATE")%></td>
		<td nowrap align=center ><%=rs.getString("DATEOFRELIEVING")%></td>
		<td nowrap align=center ><%=rs.getString("TYPE")%>&nbsp;</td>
		<td nowrap align=center ><%=rs.getString("NOTICEDAYS")%>&nbsp;</td>
		<td nowrap align=center><a Title="Click to Cancel <%=rs.getString("EMPLOYEENAME")%>'s NOC Leave Request" href='RequestNOCCancelDetail.jsp?EID=<%=rs.getString("EMPLOYEEID")%>'><FONT COLOR=RED>Click To Cancel</FONT></a>
		</td>
		</tr>
		</tbody>
		<%
		}
		if(Count==0)
			{
				if(request.getParameter("x")!=null)
				{
					%><CENTER><%
					out.print(" &nbsp;&nbsp;&nbsp <br><br><font size=3 face='Arial' color='Red'><b>No Records Found !</b></font><br>");
					%></CENTER><%
				}
			}
		}//END OF TRY
		catch (Exception e)
		{
		//out.print("Exception" +e);
		}
//-----------------------------
//---Enable Security Page Level  
//-----------------------------
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
//out.print(e);
}
%>
</form>
</body>
</html>