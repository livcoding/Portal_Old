<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [Booked Room History By Admin] </TITLE>
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
	document.frm.x.value='ddd';
	}
	//-->
    </script>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

</head>

<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
OLTEncryption enc=new OLTEncryption();
try
{
	DBHandler db=new DBHandler();
	GlobalFunctions gb =new GlobalFunctions();
	ResultSet rs=null, rs1=null;
	String qry="", qry1="";
	String mRoomtype="", mRoomType="", mRoomFor="", mRoomfor="", mFaculty="", mFacultyName="";
	String mINSTITUTECODE="", QryType="", QryFaculty="", QryFor="";
	String mDate1="", mDate2="", mCurrDate="", mPrevDate="";
	int pos = 0;
	int SNo=0;	
	int kk=0;
	String mMemberID="", mDMemberID="", mName="", mWebEmail="";
	String mMemberType="",mDMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
	String mCanStat="";
	String mEMemberCode="",mBP="",mmBP="";

	qry="select to_Char(Sysdate,'dd-mm-yyyy') date1, to_Char((Sysdate-6),'dd-mm-yyyy') date2 from dual";
	rs=db.getRowset(qry);
	rs.next();
	mCurrDate=rs.getString("date1");
	mPrevDate=rs.getString("date2");

	if (session.getAttribute("WebAdminEmail")==null)
	{
		mWebEmail="";
	}	 
	else
	{
		mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
	}
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
		mINSTITUTECODE="";
	}
	else
	{
	mINSTITUTECODE=session.getAttribute("InstituteCode").toString().trim();
	}

	if (session.getAttribute("MemberName")==null)
	{
		mName="";
	}
	else
	{
		mName=session.getAttribute("MemberName").toString().trim();
	}

	if(!mMemberID.equals("") && !mMemberType.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	String mMacAddress =" "; //session.getAttribute("IPADD").toString().trim();

	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('96','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
  //----------------------
	try
	{	
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberID=enc.decode(mMemberID);
		mDMemberType=enc.decode(mMemberType);
	}
	catch(Exception e)
	{
		out.println(e.getMessage());
	}
%>
<form name="frm" method=get>
<input id="x" name="x" type=hidden>
<table width="100%" ALIGN=CENTER bottommargin=0 topmargin=0>
 <tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE:small; FONT-FAMILY: fantasy"><u><b><FONT SIZE=4>Booked Room History</FONT></b> [For Admin User]</u></font></td></tr></table>
<table width=100%  rules=groups cellspacing=1 cellpadding=1 align=center border=1>
<tr><td colspan=2 nowrap><font color=black face=arial size=2><STRONG>Room Type</STRONG></font>
<%
	qry="Select Distinct nvl(ROOMTYPE,' ') ROOMTYPE, NVL(ROOMTYPEDESC,' ')ROOMTYPEDESC from ROOMTYPE Where nvl(Deactive,'N')='N' order by ROOMTYPEDESC";
	rs=db.getRowset(qry);
//out.print(qry);
	%>
	<select name="RoomType" tabindex="0" id="RoomType" style="WIDTH: 120px">	
	<%   	
	if(request.getParameter("x")==null)
	{	
		QryType="ALL";
		%>	
			<OPTION selected value=ALL>ALL</option>
		<%
		while(rs.next())
		{
		 	mRoomType=rs.getString("ROOMTYPE");
		 	mRoomtype=rs.getString("ROOMTYPEDESC");
			%>
				<option value=<%=mRoomType%>><%=mRoomtype%></option>
			<%
		}
	}
	else
	{
		if (request.getParameter("RoomType").toString().trim().equals("ALL"))
 		{
			QryType="ALL";
		%>
	 		<OPTION selected value=ALL>ALL</option>
		<%
		}
		else
		{
		%>
			<OPTION value=ALL>ALL</option>
		<%
		}
	  while(rs.next())
	  {
		 	mRoomType=rs.getString("ROOMTYPE");
		 	mRoomtype=rs.getString("ROOMTYPEDESC");
	   	if(mRoomType.equals(request.getParameter("RoomType").toString().trim()))
	    {
		   QryType=mRoomType;
			%>
	    	<option selected value=<%=mRoomType%>><%=mRoomtype%></option>
		  <%
		  }	
	    else
      {		
	   	%>
	    <option  value=<%=mRoomType%>><%=mRoomtype%></option>
	   	<%
	    }	
	  }
  }
%>
</select>
<font color=black face=arial size=2><STRONG>Room For</STRONG></font>
<%
	qry="select NVL(ROOMFOR,' ')ROOMFOR,NVL(ROOMFORDESC,' ')ROOMFORDESC FROM ROOMFOR ";
	qry=qry+" WHERE NVL(DEACTIVE,'N')='N' ORDER BY ROOMFORDESC";
	rs=db.getRowset(qry);
//out.print(qry);
	%>
	<select name="RoomFor" tabindex="0" id="RoomFor" style="WIDTH: 120px">	
	<%   	
	if(request.getParameter("x")==null)
	{	
		QryFor="ALL";
		%>	
			<OPTION selected value=ALL>ALL</option>
		<%
		while(rs.next())
		{
		 	mRoomFor=rs.getString("ROOMFOR");
		 	mRoomfor=rs.getString("ROOMFORDESC");
			%>
				<option value=<%=mRoomFor%>><%=mRoomfor%></option>
			<%
		}
	}
	else
	{
		if (request.getParameter("RoomFor").toString().trim().equals("ALL"))
 		{
			QryFor="ALL";
		%>
	 		<OPTION selected value=ALL>ALL</option>
		<%
		}
		else
		{
		%>
			<OPTION value=ALL>ALL</option>
		<%
		}
	  while(rs.next())
	  {
		 	mRoomFor=rs.getString("ROOMFOR");
		 	mRoomfor=rs.getString("ROOMFORDESC");
	   	if(mRoomType.equals(request.getParameter("RoomFor").toString().trim()))
	    {
		   QryFor=mRoomType;
			%>
	    	<option selected value=<%=mRoomFor%>><%=mRoomfor%></option>
		  <%
		  }	
	    else
      {		
	   	%>
	    <option  value=<%=mRoomFor%>><%=mRoomfor%></option>
	   	<%
	    }	
	  }
  }
%>
</select>
<font color=black face=arial size=2><STRONG>Booked By</STRONG>
<%
  qry="select distinct nvl(A.EmployeeName,' ')EmpName, nvl(B.BookedBy,' ')EmpID from Employeemaster A, RoomBookingInfo B where A.EmployeeID=B.BookedBy and nvl(B.deactive,'N')='N' order by empName asc";
  rs=db.getRowset(qry);
  //out.print(qry);
	%>
	<select name="Faculty" tabindex="0" id="Faculty" style="WIDTH: 180px">	
	<%   	
	if(request.getParameter("x")==null)
	{	
		QryFaculty="ALL";
		%>	
			<OPTION selected value=ALL>ALL</option>
		<%
		while(rs.next())
		{
	   	mFaculty=rs.getString("EmpID");
	   	mFacultyName=rs.getString("EmpName");
			%>
				<option value=<%=mFaculty%>><%=mFacultyName%></option>
			<%
		}
	}
	else
	{
		if (request.getParameter("Faculty").toString().trim().equals("ALL"))
 		{
			QryFaculty="ALL";
		%>
	 		<OPTION selected value=ALL>ALL</option>
		<%
		}
		else
		{
		%>
			<OPTION value=ALL>ALL</option>
		<%
		}
		while(rs.next())
		{
	   		mFaculty=rs.getString("EmpID");
		   	mFacultyName=rs.getString("EmpName");
		   	if(mRoomType.equals(request.getParameter("Faculty").toString().trim()))
		{
			QryFaculty=mFaculty;
			%>
		    	<option selected value=<%=mFaculty%>><%=mFacultyName%></option>
			<%
		}
		else
		{
		   	%>
			<option value=<%=mFaculty%>><%=mFacultyName%></option>
			<%
		}
	}
  }
  %>
  </select></td></tr>
  <%
  if (request.getParameter("x")!=null)
  {
	mDate1=request.getParameter("TXT1").toString().trim();
	mDate2=request.getParameter("TXT2").toString().trim();
  }
  else
  {
	mDate1=mPrevDate;
	mDate2=mCurrDate;
  }
  %>
  <tr><td><font color=black face=arial size=2><STRONG>Booking Date From</font><font face=arialblack size=2 color=Green>&nbsp;&nbsp;(DD-MM-YYYY)&nbsp;</font></STRONG></font>&nbsp;<input Name=TXT1 Id=TXT1 Type=text maxlength=10 size=10 value='<%=mDate1%>'> <font color=black face=arial size=2><STRONG>To</STRONG></font> <input Name=TXT2 Name=TXT2 Type=text Value='<%=mDate2%>' maxlength=10 size=10>
  <INPUT id=submit1 style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 102px; HEIGHT: 23px; FONT-VARIANT: normal" type=submit size=5 value="View Detail" name=submit1></td></tr>
  </table>
  <table><tr><td align=center><font size=2 color=red face=arialblack>&nbsp;Hint: </font><font face=arialblack size=2 color=Green>In case of <b>Dates</b> remain blank, the whole booking detail will be displayed</font></td></tr></table>
  <%
  if(request.getParameter("x")!=null)
  {
	if(request.getParameter("RoomFor")==null)
	{
		QryFor="";
	}
	else
	{
		QryFor=request.getParameter("RoomFor").toString().trim();	
	}
	if(request.getParameter("RoomType")==null)
	{
		QryType="";
	}
	else
	{
		QryType=request.getParameter("RoomType").toString().trim();
	}
	if(request.getParameter("Faculty")==null)
	{
		QryFaculty="";
	}
	else
	{
		QryFaculty=request.getParameter("Faculty").toString().trim();
	}
	if (request.getParameter("TXT1")==null || request.getParameter("TXT1").equals(""))
		mDate1="";
	else
		mDate1=request.getParameter("TXT1").toString().trim();
	
	if (request.getParameter("TXT2")==null || request.getParameter("TXT2").equals(""))
		mDate2="";
	else
		mDate2=request.getParameter("TXT2").toString().trim();
  }
  if((!mDate1.equals("") && gb.iSValidDate(mDate1)==true ||mDate1.equals("")) && (!mDate2.equals("") && gb.iSValidDate(mDate2)==true ||mDate2.equals("")))
  {
	%>
	<TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="100%" border=0>
  	<thead>
	<tr bgcolor="#ff8c00">
	<td align=left Title="Click on SlNo. to sort"><b><font color=white>SlNo.</font></b></td>
	<td nowrap align=left Title="Click on Booked By to sort"><b><font color=white>Booked By</font></b></td>
	<td align=left Title="Click on Room No. to sort" nowrap><b><font color=white>Room No.</font></b></td>
	<td align=CENTER Title="Click on Request Date to sort" nowrap><b><font color=white>Description</font></b></td>
	<td align=CENTER Title="Click on Request Date to sort" nowrap><b><font color=white>Rqst. Date</font></b></td>
	<td align=CENTER Title="Click on Purpose to sort"><b><font color=white>Purpose</font></b></td>
	<td align=CENTER Title="Click on Booking Period to sort" nowrap><b><font color=white>Booking Period</font></b></td>
	<td align=CENTER Title="Click on Cancel to sort"><b><font color=white>Status</font></b></td>
	</tr>
	</thead>
	<tbody>
  	<%
		qry="select nvl(A.ROOMCODE,' ')RC, nvl(A.BOOKINGPURPOSE,' ' )BP, to_char(A.BOOKINGDATETIME,'DD-MM-YYYY')RD,";
		qry=qry+" to_char(A.BOOKINGFROMDATE,'DD-MM-YYYY')BDF, to_char(A.BOOKINGUPTODATE,'DD-MM-YYYY')BDT, ";
		qry=qry+" to_char(A.BOOKINGFROMTIME,'HH:MI PM')BTF, to_char(A.BOOKINGUPTOTIME,'HH:MI PM')BTT,";
		qry=qry+" nvl(A.CANCELLATIONSTATUS,'N')CanStat, nvl(B.ROOMDESC,' ')ROOMDESC, nvl(B.ROOMTYPE,' ')ROOMTYPE, nvl(B.ROOMFOR,' ')ROOMFOR, nvl(C.Employeename,' ')EmpName";
		qry=qry+" From ROOMBOOKINGINFO A, ROOMMASTER B, EMPLOYEEMASTER C Where ";
		qry=qry+" NVL(A.DEACTIVE,'N')='N' AND A.ROOMCODE=B.ROOMCODE AND NVL(B.DEACTIVE,'N')='N' AND C.EMPLOYEEID=A.BOOKEDBY";
		qry=qry+" and B.RoomType=Decode('"+QryType+ "','ALL',B.ROOMTYPE,'"+QryType+"')";
		qry=qry+" and B.RoomFor=Decode('"+QryFor+ "','ALL',B.ROOMFOR,'"+QryFor+"')";
		qry=qry+" and A.BookedBy=Decode('"+QryFaculty+ "','ALL',A.BOOKEDBY,'"+QryFaculty+"')";
		qry=qry+" and (trunc(A.BOOKINGFROMDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',A.BOOKINGFROMDATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
		qry=qry+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',A.BOOKINGFROMDATE,to_date('"+mDate2+"','dd-mm-yyyy')))";
		qry=qry+" or trunc(A.BOOKINGUPTODATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',A.BOOKINGUPTODATE,to_date('"+mDate1+"','dd-mm-yyyy')))";
		qry=qry+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',A.BOOKINGUPTODATE,to_date('"+mDate2+"','dd-mm-yyyy')))) ORDER BY BDF, BTF, BDT, BTT DESC";
		//qry=qry+" trunc(A.BOOKINGUPTODATE)>=trunc(sysdate) and";
		rs=db.getRowset(qry);
		//out.print(qry);
		SNo=0;
		while(rs.next())
		{	
			SNo++;
			String TRCOLOR="#F8F8F8";
			if(SNo%2==0)
				TRCOLOR="White";
			else
				TRCOLOR="#F8F8F8";
			mCanStat=rs.getString("CanStat");
			long mBookingPurpose=rs.getString("BP").length();
			String mData=rs.getString("BP");
			if(mCanStat.equals("N"))
			{
			%>
			<tr BGCOLOR='<%=TRCOLOR%>'>
			<td align=right><b><%=SNo%>.</b>&nbsp;&nbsp;</td>
			<td nowrap><FONT COLOR=BLACK><%=rs.getString("EmpName")%></FONT></td>
			<td><FONT COLOR=BLACK><%=rs.getString("ROOMDESC")%></FONT></td>
			<td><FONT COLOR=BLACK><%=rs.getString("ROOMTYPE")%> For <%=rs.getString("ROOMFOR")%></FONT></td>
			<td><FONT COLOR=BLACK><%=rs.getString("RD")%></FONT></td>
			<%
			if(mBookingPurpose >20)
			{
			String mBookPurp=mData.substring(0,20);
			%>
			<td nowrap><FONT COLOR=BLACK><%=mBookPurp%>...</FONT></td>
			<%
			}
			else	
			{
			%>
			<td nowrap><FONT COLOR=BLACK><%=rs.getString("BP")%></FONT></td>
			<%
			}
			%>	
			<td nowrap><FONT COLOR=BLACK><%=rs.getString("BDF")%> To <%=rs.getString("BDT")%>(<%=rs.getString("BTF")%> - <%=rs.getString("BTT")%>)</FONT></td>
			<td nowrap><FONT COLOR=BLACK>Not Cancelled</FONT></td>
			</tr>
			<%
			}
			else
			{
			%>
			<tr BGCOLOR='<%=TRCOLOR%>'>
			<td align=right><b><%=SNo%>.</b>&nbsp;&nbsp;</td>
			<td nowrap><FONT COLOR=RED><%=rs.getString("EmpName")%></FONT></td>
			<td><FONT COLOR=RED><%=rs.getString("ROOMDESC")%></FONT></td>
			<td><FONT COLOR=RED><%=rs.getString("ROOMTYPE")%> For <%=rs.getString("ROOMFOR")%></FONT></td>
			<td><FONT COLOR=RED><%=rs.getString("RD")%></FONT></td>
			<%
			if(mBookingPurpose >20)
			{
			String mBookPurp=mData.substring(0,20);
			%>
			<td nowrap><FONT COLOR=BLACK><%=mBookPurp%>...</FONT></td>
			<%
			}
			else	
			{
			%>
			<td nowrap><FONT COLOR=BLACK><%=rs.getString("BP")%></FONT></td>
			<%
			}
			%>	
			<td nowrap><FONT COLOR=RED><%=rs.getString("BDF")%> To <%=rs.getString("BDT")%>(<%=rs.getString("BTF")%> - <%=rs.getString("BTT")%>)</FONT></td>
			<td><FONT COLOR=RED><b>Cancelled</b></FONT></td>
			</tr>
			<%
			}
		}
		%>
		</tbody>
		</table>
		<script type="text/javascript">
		var st1 = new SortableTable(document.getElementById("table-1"),[,"CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString"]);
		</script>
		<%
	}
	else
	{
		out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Please Enter Valid Date!</font> <br>");
	}

  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
  }
  else
  {
  	%>
	<font color=red>
	<h3>	<br><img src='../../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font><br><br>
	<%
  }
  //-----------------------------
}
else
{
	out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font></b></center>");
}
}
catch(Exception e)
{
}
%>
</form>
</body>
</html>