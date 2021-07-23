<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../CommonFiles/ExceptionHandler.jsp" %> 
<%
try
{
	OLTEncryption enc=new OLTEncryption();
	String mHead="";
	if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
		mHead=session.getAttribute("PageHeading").toString().trim();
	else
		mHead="JIIT ";
	%>
	<HTML>
	<head>
	<TITLE>#### <%=mHead%> [ Change Web Kiosk Member Role ] </TITLE>
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
		function RefreshContents1()
		{
			document.frmm.y.value='ddd';
			document.frmm.submit();
		}
	//-->
	</script>
	<script>
	<!--
	  if(window.history.forward(1) != null)
	  window.history.forward(1);
	-->
	</script>
	</HEAD>
	<%
	String mEID="", mMemberType="", mMemberID="";
	String qry="", qry1="", qry2="", Qry="";
	String mMCode="", mEMCode="";
	String mOldRole="", mEmpRole="", mrole="", mMRole="", QryRole="";
	String mDEmpRole="", mEmpType="", mDEmpType="";
	String mNewRole="", mENewRole="",mInst="";
	String mName="", mCode="";
	String mWebEmail="", mDNO="";
	String mLogEntryMemberID="",mLogEntryMemberType="";
	DBHandler db=new DBHandler();
	ResultSet rs=null, rs1=null, rs2=null,rsi=null, rss=null;
	if (request.getParameter("DNO")==null)
	{
		mDNO="";
	}
	else
	{
		mDNO=request.getParameter("DNO").toString().trim();
	}
	if (request.getParameter("EID")==null)
	{
		mEID="";
	}
	else
	{
		mEID=request.getParameter("EID").toString().trim();
	}

// For Log Entry Purpose
//--------------------------------------

	if (session.getAttribute("BASELOGINID")==null || session.getAttribute("BASELOGINID").toString().trim().equals(""))
		mLogEntryMemberID="";
	else
		mLogEntryMemberID=session.getAttribute("BASELOGINID").toString().trim();

	if (session.getAttribute("BASELOGINTYPE")==null || session.getAttribute("BASELOGINTYPE").toString().trim().equals(""))
		mLogEntryMemberType="";
	else
		mLogEntryMemberType=session.getAttribute("BASELOGINTYPE").toString().trim();

	qry="select nvl(employeecode,' ')EC from employeemaster where employeeid='"+mEID+"'";
	rs=db.getRowset(qry);
	//out.print(qry);
	if(rs.next())
	{
		mMCode=rs.getString("EC");
		mEMCode=enc.encode(mMCode);
	}
	if (!mLogEntryMemberType.equals(""))
		mLogEntryMemberType=enc.decode(mLogEntryMemberType);

	if (!mLogEntryMemberID.equals(""))
		mLogEntryMemberID=enc.decode(mLogEntryMemberID);
//--------------------------------------
%>
<BODY aLink=#ff00ff bgcolor="#fce9c5" rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 scroll=auto>
<%
String mLoginIDFrSes="";
if(mInst.equals("JIIT"))
	mLoginIDFrSes="asklJIITADMINaskl";
else if(mInst.equals("JPBS"))
	mLoginIDFrSes="asklJPBSADMINaskl";
else	
	mLoginIDFrSes="asklADMINaskl";
//out.print(mLogEntryMemberID+" - "+mLoginIDFrSes);
	if(mLogEntryMemberID.equals(mLoginIDFrSes) && mLogEntryMemberType.equals("A")) 
	{
		String mIPAddress=session.getAttribute("IPADD").toString().trim();

	// For Log Entry Purpose
	//--------------------------------------

		if (session.getAttribute("LogEntryMemberID")==null || session.getAttribute("LogEntryMemberID").toString().trim().equals(""))
			mLogEntryMemberID="";
		else
			mLogEntryMemberID=session.getAttribute("LogEntryMemberID").toString().trim();

		if (session.getAttribute("LogEntryMemberType")==null || session.getAttribute("LogEntryMemberType").toString().trim().equals(""))
			mLogEntryMemberType="";
		else
			mLogEntryMemberType=session.getAttribute("LogEntryMemberType").toString().trim();

		if (session.getAttribute("BASEINSTITUTECODE")==null)
			mInst="JIIT";
		else
			mInst=session.getAttribute("BASEINSTITUTECODE").toString().trim();

		if (mLogEntryMemberType.equals(""))
			mLogEntryMemberType=mMemberType;

		if (mLogEntryMemberID.equals(""))
			mLogEntryMemberID=mMemberID;

		if (!mLogEntryMemberType.equals(""))
			mLogEntryMemberType=enc.decode(mLogEntryMemberType);

		if (!mLogEntryMemberID.equals(""))
			mLogEntryMemberID=enc.decode(mLogEntryMemberID);
	//--------------------------------
	  %>
		<form method="get" name="frm">
		<input id="x" name="x" type=hidden>
		<input Type=hidden name=DNO id=DNO value="<%=mDNO%>">
		<input Type=hidden name=EID id=EID value="<%=mEID%>">
		<Table align=center width=90%>
		<tr bgcolor=orange><td align=right><font color=RED><b><marquee scrolldelay=100 behavior=alternate>A D M I N</marquee></b></font></td></tr></table>
		<TABLE width="80%" ALIGN=CENTER bottommargin=0  topmargin=0>
		<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Update/Change Member Web Kiosk Role</b></font><font color="#a52a2a" style="FONT-SIZE: small; FONT-FAMILY: fantasy"></font></td></tr>
		</TABLE>
		<table width=100%><tr><td align=right> &nbsp; &nbsp; &nbsp;<a href='IndvDeptEmpRoleTitleInfo.jsp?DNO=<%=mDNO%>'><font color=GREEN><b>Back...</b></font></a> &nbsp; &nbsp; &nbsp;</td></tr></table>
<!*********--Institute--************>
		<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
		<%
		qry="select nvl(ORAADM,' ')Role, ORAID, nvl(ORATYP,' ')Type from membermaster ";
		qry=qry+" where ORACD='"+mEMCode+"' and nvl(DEACTIVE,'N')='N'";
		rs=db.getRowset(qry);
		try
		{
			if(rs.next())
			{
				if(rs.getString("Role")==null || rs.getString("Role").equals(""))
				{
					mDEmpRole="Role yet Not Assigned";
				}
				else
				{
					mEmpRole=rs.getString("Role");
					mDEmpRole=enc.decode(mEmpRole);
				}
				qry1="select nvl(ROLEDESCRIPTION,' ')OLDROLE from WEBKIOSKROLEMASTER where ROLENAME='"+mDEmpRole+"'";
				rs1=db.getRowset(qry1);
				rs1.next();
				mOldRole=rs1.getString("OLDROLE");
				
				if(rs.getString("Type")==null || rs.getString("Type").equals(""))
				{
					mDEmpType=" ";
				}
				else
				{
					mEmpType=rs.getString("Type");
					mDEmpType=enc.decode(mEmpType);
				}
				%>
<!--Start of Second Table's Scope-->
				<table cellpadding=0 align=center rules=groups border=1 style="WIDTH: 470px;">
				<tr><td colspan=1><FONT color=black>&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Selected Member</STRONG></FONT></FONT></td>
				<%
				Qry="select nvl(EMPLOYEECODE,' ')MC, nvl(EMPLOYEENAME,' ')MN from employeemaster where EMPLOYEECODE='"+mMCode+"'";
				rss=db.getRowset(Qry);
				if(rss.next())
				{
					mName=rss.getString("MC");
					mCode=rss.getString("MN");
				}
				
				%>
				<td><b><font color="#00008b" face=times new roman><%=mCode%> [<%=mName%>]</font>&nbsp;&nbsp;</b></td></tr>
				<tr><td><FONT color=black>&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Current Role</STRONG></FONT></FONT></td>
				<td><b><font color="#00008b" face=times new roman><%=mOldRole%></font>&nbsp;&nbsp;</b></td></tr>
				<tr><td><FONT color=black>&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>New Role</STRONG></FONT></FONT></td>
				<%
				qry="Select Distinct NVL(ROLENAME,' ')RoleName, nvl(ROLEDESCRIPTION,' ')RoleDesc from WEBKIOSKROLEMASTER WHERE ROLEFORMEMBERTYPE='E' and nvl(deactive,'N')='N' order by RoleDesc asc";
				rs=db.getRowset(qry);
				//out.print(qry);
				%>
				<td><select name="KIOSKROLE" tabindex="0" id="KIOSKROLE" style="WIDTH: 300px">
				<%
			 	if(request.getParameter("KIOSKROLE")==null)
				{
					while(rs.next())
					{
					 	mrole=rs.getString("RoleName");
					 	mMRole=rs.getString("RoleDesc");
						if(QryRole.equals(""))
 						{			
							QryRole=mrole;
							%>
							<OPTION Selected Value =<%=mrole%>><%=mMRole%></option>
							<%
						}
						else
						{
							%>
							<option value=<%=mrole%>><%=mMRole%></option>
							<%
						}
					}
				}
				else
				{
					while(rs.next())
					{
						mrole=rs.getString("RoleName");
					 	mMRole=rs.getString("RoleDesc");
						if(mrole.equals(request.getParameter("KIOSKROLE").toString().trim()))
						{
							QryRole=mrole;
							%>
							<option selected value=<%=mrole%>><%=mMRole%></option>
							<%
						}
						else
						{
	   					%>
				   		<option  value=<%=mrole%>><%=mMRole%></option>
							<%
						}
	  				}
 			 	}
 				%>
				</select></td></tr>
				<tr><td colspan=2 align=center><INPUT Type="submit" Value="Change Role" onClick="RefreshContents1();"></td></tr>
				<input type=hidden name='ORATYPE' id='ORATYPE' value='<%=mEmpType%>'>
				<input type=hidden name='ORACD' id='ORACD' value='<%=mEMCode%>'>
				<input type=hidden name='ORAADMOLD' id='ORAADMOLD' value='<%=mEmpRole%>'>
				<input type=hidden name='ORAADMNEW' id='ORAADMNEW' value='<%=mNewRole%>'>
				<input type=hidden name='INSTCODE' id='INSTCODE' value='<%=mInst%>'>
				</table>
				</form>
				<%
				if(request.getParameter("x")!=null)					
				{
					if (request.getParameter("KIOSKROLE")==null || request.getParameter("KIOSKROLE").equals(""))
					{
						mNewRole="";
						mENewRole="";
						out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Please Select New Role!</font></b></center>");
					}
					else
					{
						mNewRole=request.getParameter("KIOSKROLE").toString().trim();
						mENewRole=enc.encode(mNewRole);
						
						// Update Role Here
						//--------------------------
						qry="update MEMBERMASTER set ORAADM='"+mENewRole+"' Where trim(ORACD)='"+mEMCode+"' and trim(ORAADM)='"+mEmpRole+"'";
						int n=db.update(qry);
						//out.print(qry);
						if(n>0)			  
						{
							qry2="select nvl(ROLEDESCRIPTION,' ')NEWROLE from WEBKIOSKROLEMASTER where ROLENAME='"+mNewRole+"'";
							rs2=db.getRowset(qry2);
							rs2.next();
							String mNRole=rs2.getString("NEWROLE");
						%>
							<hr></table>
							<TABLE align=center calspan=0 cellSpacing=0 cellPadding=1 width="75%" border=0 >
							<tr bgcolor='lightblue'><td align=center>
							<font size=3 face='Arial' color='green'><b>Role changed successfully...</b></font>
							</td></tr>
							<tr></tr>
							<tr>
							 <td align=left><b><font color="#00008b">Previous Role was: </font></b><font color="#00008b">&nbsp;&nbsp;<%=mOldRole%></font></td></tr>
							<tr>
							 <td align=left><b><font color="#00008b">New Role is: </font></b><font color="#00008b">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=mNRole%></font></td></tr>
							</TABLE>			
							<hr>
						<%
db.saveTransLog(mInst,"ADMIN","A" ,"CHANGE MEMBER WEBKIOSK ROLE", "Member Code : "+mMCode, "No MAC Address" , mIPAddress);
						}
						else
						{
							 out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp<b><font size=3 face='Arial' color='Red'>Error while changing New Role</b></center>");
						}
						//--------------------------
					}
				}
			}
			else
			{
				 out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp<b><font size=3 face='Arial' color='Red'>Login ID is not created !</b></center>");
			}					
		}
		catch(Exception e)
		{
		}
	}
	else
	{
		out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp'>Login</a> to continue</font>");
	}
}
catch(Exception e)
{
}
%>
<table ALIGN=Center VALIGN=TOP>
<tr>
<td valign=middle><br><br>
<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp"><FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br><FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href="mailto:webkiosk@jiit.ac.in ">webkiosk@jiit.ac.in</A></FONT>
</td></tr></table>
</BODY>
</HTML>