<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
try
{ 
	String mHead="";

	if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
		mHead=session.getAttribute("PageHeading").toString().trim();
	else
		mHead="JIIT ";

	String mSCellNo="", mPCellNo="", mSTelNo="", mPTelNo="", mSEmail="",mPEmail="";
	String mInst="", mComp="", mWebEmail="";
	String mMem="", mMemID="", mDID="";
	String qry="";
	String mScellNo="", mSStd="", mStelNo="", mCPNo="";
	String mSemail="",mDMemC="",mInstC="",mMemberID="",mMemberType="";
	int n=0;
	String x="";
	ResultSet rs=null,rsi=null;
	DBHandler db=new DBHandler();
	GlobalFunctions gb =new GlobalFunctions();
	if (session.getAttribute("WebAdminEmail")==null)
	{
		mWebEmail="";
	}
	else
	{
		mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
	}

	if (session.getAttribute("InstituteCode")==null)
	{
		mInstC="";
	}
	else
	{
		mInstC=session.getAttribute("InstituteCode").toString().trim();
	}

	if (session.getAttribute("CompanyCode")==null)
	{
		mComp="";
	}
	else
	{
		mComp=session.getAttribute("CompanyCode").toString().trim();
	}

	if(session.getAttribute("MemberCode")==null)
	{
		mMem="";	
	}
	else
	{
		mMem=session.getAttribute("MemberCode").toString().trim();
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

	if (session.getAttribute("MemberID")!=null && session.getAttribute("MemberCode")!=null)
	{
		OLTEncryption enc=new OLTEncryption();
		mDID=enc.decode(session.getAttribute("MemberID").toString().trim());
		mDMemC=enc.decode(session.getAttribute("MemberCode").toString().trim());

		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk=null;

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

		//-----------------------------
		//-- Enable Security Page Level  
		//-----------------------------
		qry="Select WEBKIOSK.ShowLink('48','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      	RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{
		  //----------------------
			qry="select nvl(PHONENOS,' ') CPNo, nvl(CELLNO,' ') SCell,nvl(EMAILID,' ') sEmail from GUEST where GUESTID='" +mDID+ "'";
			rs=db.getRowset(qry);
			if(rs.next())
			{
				if (rs.getString("SCell")==null)
					mSCellNo="";
				else
				   	mSCellNo=rs.getString("SCell");

				if(rs.getString("CPNo")==null)
					 mCPNo="";
				else
					mCPNo=rs.getString("CPNo");

				if(rs.getString("sEmail")==null)
					mSEmail=rs.getString("sEmail");
				else
					mSEmail=rs.getString("sEmail");
			}
			%>
			<html>
			<head>
			<title>#### <%=mHead%> [ Change Contact information ]</title>
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
			<script language="JavaScript" type ="text/javascript">
			<!-- 
			if (top != self) top.document.title = document.title;
			-->
			</script>
			</head>
			<body topmargin=0 rightmargin=0 leftmargin=10 bottommargin=0 bgcolor=#fce9c5>
			<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
			<tr>
			<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Change Guest Contact Information</B></font>
			</td>
			</tr>
			</TABLE>
			<form name="frm" method="get">
			<input id="x" name="x" type=hidden>

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
			<TABLE cellspacing=0  cellpadding=1 frame =box align="center" border=1 style="FONT-FAMILY: Arial; 
			FONT-SIZE: x-small" borderColor=black borderColorDark=white width=100%>
			<TR align="middle" bgcolor="#ff8c00">
			<TD colspan="2"><P align=center><FONT color=white face=Arial size=2><STRONG>&nbsp;Faculty Contact Detail (Current)</STRONG></FONT></P></TD>
			<TD colspan="2"><P align=center><FONT color=white face=Arial size=2><STRONG>&nbsp;Faculty Contact Detail (New)</STRONG></FONT></P></TD>
			</TR>
			<TR>
				<TD><FONT color=black face=Arial size=2>&nbsp;Cell/Mobile</FONT></TD>
				<td><FONT color=black>&nbsp;<%=mSCellNo%> </FONT>&nbsp;</td>
				<TD><FONT color=black face=Arial size=2>&nbsp;Cell/Mobile</FONT></TD>
				<td><INPUT ID="SCellNo" Name="SCellNo" Type="text" value="<%=mSCellNo%>" style="WIDTH: 160px; HEIGHT: 22px" maxLength=30></td>
			</TR>
			<TR>
				<TD><FONT color=black face=Arial size=2>&nbsp;Correspondence Phone</FONT></TD>
				<td><FONT color=black>&nbsp;<%=mCPNo%></FONT>&nbsp;</td>
				<TD><FONT color=black face=Arial size=2>&nbsp;Correspondence Phone</FONT></td>
				<TD><INPUT ID="CPN" Name="CPN" Type="text" value="<%=mCPNo%>" style="WIDTH: 160px; HEIGHT: 22px" maxLength=50></td>
			</TR>
			<TR>
				<TD><FONT color=black face=Arial size=2>&nbsp;E-Mail</FONT></TD>
				<td><FONT color=black>&nbsp;<%=mSEmail%></FONT>&nbsp;</td>
				<TD><FONT color=black face=Arial size=2>&nbsp;E-Mail</FONT></TD>
				<td><INPUT ID="SEMail" Name="SEMail" Type="text" value="<%=mSEmail%>" style="WIDTH: 160px; HEIGHT: 22px" maxLength=60><font color=red>*</font></td>
			</TR>
			<TR><td colspan=4 align=center><INPUT Type="submit" Value="Save"></td></TR>
			</TABLE></form>
			<%
			if (request.getParameter("x")!=null)
			{
				if(request.getParameter("SCellNo")==null)
					mScellNo="";
				else
					mScellNo=GlobalFunctions.replaceSignleQuot(request.getParameter("SCellNo").toString().trim());	

				if(request.getParameter("CPN")==null)
					mCPNo="";
				else
					mCPNo=GlobalFunctions.replaceSignleQuot(request.getParameter("CPN").toString().trim());

				if(request.getParameter("SEMail")==null)
					mSemail="";
				else
					mSemail=GlobalFunctions.replaceSignleQuot(request.getParameter("SEMail").toString().trim());

				//out.print(mScellNo+" "+mCPNo+" "+mSemail);

				if(!mSemail.equals(""))
				{
			 	   try
				   {
		 	         	qry="SELECT 'Y' FROM GUEST where GUESTID='"+mDID+"'";
					rs=db.getRowset(qry);
					if (rs.next())
					{
		 				qry="update GUEST set CELLNO='"+mScellNo+"',PHONENOS='"+mCPNo+"', ";
						qry=qry +" EMAILID='"+mSemail+"' WHERE GUESTID='"+mDID+"' ";
						n=db.update(qry);
					}
					else
					{
						qry=" Insert into GUEST (COMPANYCODE, GUESTID, PHONENOS, EMAILID, CELLNO)";
						qry=qry+" Values('"+mComp+"', '"+mDID+"', '"+mCPNo+"', '"+mSemail+"', '"+mScellNo+"')";
						n =db.insertRow(qry);
					}
					//out.print(qry);
					if(n>0)
					{
					// Log Entry
			  		   //-----------------
					    db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"EDIT GUEST PERSONAL INFORMATION", "Member Code :"+ mDMemC, "No MAC Address" , mIPAddress);
					   //-----------------
						out.print("<b><font size=3 face='Arial' color='Green'><center>Information changed successfully</center></font></b><br>");
						response.sendRedirect("GuestModifyEmailIDTelephone.jsp");
					}
				   }
				   catch(Exception e)
				   {
					//out.print(e);
				   }
				}
				else
				{
					out.print("<br><img src='../../Images/Error1.jpg'>");
					out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>E-Mail can't be left blank</font></b><br>");
				}
			}
		  //-----------------------------
		  //-- Enable Security Page Level  
		  //-----------------------------
		}
		else
		{
			%>
			<br>
			<font color=red>
			<h3>	<br><img src='../../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
			<P>	This page is not authorized/available for you.
			<br>For assistance, contact your network support team. <br><br><br>
			</font>
			<%
		}
	  //-----------------------------
	}
	else
	{
		%>
		<br>Session timeout! Please <a href="../index.jsp">Login</a> to continue...
		 <%
	}
	%>
	<br><br><br><br><br><br><br><br><br><br><br><br>
	<center>
	<table ALIGN=Center VALIGN=TOP>
	<tr>
	<td valign=middle>
	<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">
	<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
	A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
	<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>  
	</td></tr></table></body>
	<%
}
catch(Exception e)
{
	//out.print("E R R O R");
}
%>
</html>