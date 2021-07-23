<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
try
{
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
String mHead="";
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberID="",mDMemberCode="",mDMemberType="";
String mInst="";
String qry="";
ResultSet rs=null;
String Mprno="";
String mPRNO="";
String mDepartmentCode="",mCompanyCode="";
String mDate1="", mDate2="";

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
{
	mHead=session.getAttribute("PageHeading").toString().trim();
}
else
{
	mHead="JIIT ";
}
if (session.getAttribute("MemberID")==null)
{
	mMemberID="";
}
else
{
	mMemberID=session.getAttribute("MemberID").toString().trim();
}
if (session.getAttribute("CompanyCode")==null)
{
	mCompanyCode="";
}
else
{
	mCompanyCode=session.getAttribute("CompanyCode").toString().trim();
}

if (session.getAttribute("MemberType")==null)
{
	mMemberType="";
}
else
{
	mMemberType=session.getAttribute("MemberType").toString().trim();
}
if (session.getAttribute("DepartmentCode")==null)
{
	mDepartmentCode="";
}
else
{
	mDepartmentCode=session.getAttribute("DepartmentCode").toString().trim();
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
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Purchase Requisition Report ] </TITLE>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
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
	if(window.history.forward(1)!=null)
	window.history.forward(1);	
</script>
</head>
<body aLink=#ff00ff bgcolor='#fce9c5' rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
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
		qry="Select WEBKIOSK.ShowLink('156','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
		qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from InstituteMaster Where nvl(Deactive,'N')='N' ";
		rs=db.getRowset(qry);
			if (rs.next())
				mInst=rs.getString(1);
			else
				mInst="JIIT";

		String mCurDate="",mPervDate="";
		qry="select to_Char(SysDate-7,'dd-mm-yyyy')date1, to_Char(SysDate,'dd-mm-yyyy')date2 from dual";
		rs=db.getRowset(qry);
		rs.next();
		mPervDate=rs.getString("date1");
		mCurDate=rs.getString("date2");

		//----------------------
	%>
	<form name="frm"  method="post" >
	<input id="x" name="x" type=hidden>
	<table align=center bottommargin=0 width=100% cellspacing=0 cellpadding=0 topmargin=0 border=0 >
	<tr>
	<td align=center>
	<font color="#a52a2a" style="FONT-SIZE:medium; FONT-FAMILY: fantasy">Purchase Requisition Report</font>
	</td>
	</tr>
	</table>
	<BR>
	<%
	if (request.getParameter("x")!=null)
	{
	mDate1=request.getParameter("DATE1").toString().trim();
	mDate2=request.getParameter("DATE2").toString().trim();
	}
	else
	{
	mDate1=mPervDate;
	mDate2=mCurDate;
	}
	%>
	<TABLE rules=none cellSpacing=0 cellPadding=0 border=1 align=center>
	<tr><td nowrap><font color=black face=arial font size=2><b><b>Entry Date From</b></font><font color=green face=arialblack font size=2><b> (DD-MM-YYYY)&nbsp;</b></font></td>
	<td><INPUT TYPE="text" NAME=DATE1 ID=DATE1 size=9 tabindex=1 VALUE='<%=mDate1%>'
	onTextChange="ChangeOnLeaveStatus()" READONLY><a href="javascript:NewCal('DATE1','ddmmyyyy')"><img src="images/timepicker.gif" width="22" height="22" border="0" alt="Pick a Date"></a>
	</td><td><b>&nbsp;to&nbsp;</b></td>
	<td><INPUT TYPE="text" NAME=DATE2 ID=DATE2 size=9 tabindex=1 VALUE='<%=mDate2%>'
	onTextChange="ChangeOnLeaveStatus()" READONLY><a href="javascript:NewCal('DATE2','ddmmyyyy')"><img src="images/timepicker.gif" width="22" height="22" border="0" alt="Pick a Date"></a>
	</td>
	<TD>&nbsp;&nbsp;<INPUT  style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 50px; HEIGHT: 23px; FONT-VARIANT: normal; cursor:hand; border-width:1;" TYPE="submit"  VALUE="View" ></TD> 
	</tr>
	</table>
	<br>
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
		
	qry="select PRNO,to_Char(ENTRYDATE,'DD-MM-YYYY')ENTRYDATE FROM PRMASTER where ENTRYDATE between to_date('"+mDate1+"','dd-mm-yyyy') and to_date('"+mDate2+"','dd-mm-yyyy') and nvl(DEACTIVE,'N')='N' and nvl(DOCMODE,'A')='A' order by PRNO";
	//out.print(qry);
	rs=db.getRowset(qry);
	if(rs.next())
	{			
	%>
	<table align=center  cellspacing=0 cellpadding=0  border=1 rules=NONE >
	<tr>
	<td align=center> 
	<b>PRNO.</B>&nbsp;
	<select name="PRNO" id="PRNO" style="WIDTH: 110px"> 
	<%
		if(request.getParameter("x")==null) 
		{
			while(rs.next())
			{
				Mprno=rs.getString("PRNO");
			%>
			<option value=<%=Mprno%>><%=rs.getString("PRNO")%></option>
			<%	
			}
		}
		else
		 {
			while(rs.next())
			{	
				Mprno=rs.getString("PRNO");
				if(Mprno.equals(request.getParameter("PRNO")))
					{
					%>
					<option selected value=<%=Mprno%>><%=rs.getString("PRNO")%></option>
					<%
					}
				else
					{
					%>
					<option value=<%=Mprno%>><%=rs.getString("PRNO")%></option>
					<%
					}
				}
			} // closing of else
	%>
		</select>&nbsp;
		<input  style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 50px; HEIGHT: 23px; FONT-VARIANT: normal; cursor:hand; border-width:1;" type=submit id=submit value="Show">
		</td>
		</tr>
		</table>
		</form>
	<%
		if(request.getParameter("PRNO")==null)
			mPRNO="";
		else
			mPRNO=request.getParameter("PRNO").toString().trim();

		%>
		<form name="frm"  method="post" >
		<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
		<tr><TD align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><u>Available List</u></TD>
		</font></td>	
		</table>
		<TABLE bgcolor=#fce9c5 class="sort-table"  width=98% ALIGN=CENTER rules=COLUMNS CELLSPACING=0 BORDER=1> 
		<thead>
		<tr bgcolor="#ff8c00">
		<TD ALIGN=CENTER><font color=white><b>Sno.<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>ItemCode<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>ItemDescription<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>PocketCode<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Make<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Req.Qty(UOM)<B><font></TD>
		</tr>
		</thead>
		<tbody>
		<%		
	qry=" select distinct A.PRNO,A.POCKETCODE POCKETCODE,C.POCKETDESCRIPTION ,A.ItemCode,B.itemdescription,nvl(A.make,' ')make,A.UOM,A.REQUESTEDQTY from PRDETAIL A,itemcatalogue B,POCKETMASTER C ";
	qry=qry+" where A.PRNO='"+mPRNO+"'  and A.itemcode=B.itemCode AND A.POCKETCODE=C.POCKETCODE ";
	qry=qry+"  AND nvl(C.DEACTIVE,'N')='N' AND nvl(A.DEACTIVE,'N')='N' AND NVL(B.DEACTIVE,'N')='N' order by A.PRNO,A.ITemcode";
	//out.print(qry);
	rs=db.getRowset(qry);
	int ctr=0;
	while(rs.next())
	{	
		ctr++;
	%>
		<tr>		
		<td><%=ctr%></td>
		<td title="click to view detail">&nbsp;<a target=_NEW href="PurchaseRequisitionApprovDetail.jsp?PRNO=<%=mPRNO%>&amp;DEPARTMENTCODE=<%=mDepartmentCode%>&amp;POCKETCODE=<%=rs.getString("POCKETCODE")%>&amp;ITEMCODE=<%=rs.getString("ItemCode")%>"><%=rs.getString("ItemCode")%></a></td>
		<td nowrap>&nbsp;<%=rs.getString("itemdescription")%></td>
		<td NOWRAP>&nbsp;<%=rs.getString("POCKETDESCRIPTION")%></td>
		<td NOWRAP>&nbsp;<%=rs.getString("make")%></td>	<td>&nbsp;<%=rs.getString("REQUESTEDQTY")%>&nbsp;<%=rs.getString("UOM")%></td>
		</tr>
	<%
	} // closing of while
	%>
	</tbody>
	</table>
	</form>
	<%
}// closing of rs.next()
	else
	{
	%><CENTER><%
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <font size=3 face='Arial' color='Red'><b>No such record found...</b></font><br>");
	%></CENTER><%
	}
}//closing of if request.getParameter("x")!=null
//-----------------------------
//---Enable Security Page Level  
//-----------------------------
}
else
{
   %>
	<br>
	<font color=red>
	<h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font>	<br>	<br>	<br>	<br>  
   <%
}
//-----------------------------
}
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
}
catch(Exception e)
{
	//out.print("Exception "+e);
}
%>
</body>
</html>
