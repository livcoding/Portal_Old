<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
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
String mMemberID="";
String mMemberType="";
String mMemberCode="",qry="", qry1="", qry2="", Qry="";
String mMCode="";
String mEMCode="";
String mOldRole="", mEmpRole="", mrole="", mMRole="", QryRole="", mMType="", mEMType="";
String mDEmpRole="", mEmpType="", mDEmpType="";
String mNewRole="", mCurrRole="", mECurrRole="";
String mENewRole="",mInst="";
String mName="", mCode="";
DBHandler db=new DBHandler();
ResultSet rs=null, rs1=null, rs2=null,rsi=null, rss=null;
String mWebEmail="";

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

if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
}

%>
<BODY aLink=#ff00ff bgcolor="#fce9c5" rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 scroll=auto>
<%
if(!mMemberID.equals("") || !mMemberType.equals("") || !mMemberCode.equals(""))
{
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
	//--------------------------------

	//-------------------------------
	//-- Enable Security Page Level  
	//-------------------------------
	qry="Select WEBKIOSK.ShowLink('38','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
	  //----------------------
	  %>
		<form method="get" name="frm">
		<input id="x" name="x" type=hidden>
		<TABLE width="80%" ALIGN=CENTER bottommargin=0  topmargin=0>
		<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Update/Change Wev Kiosk Member Role</b></font><font color="#a52a2a" style="FONT-SIZE: small; FONT-FAMILY: fantasy"></font></td></tr>
		</TABLE>
		
		
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
		<table align=center rules=groups border=2 style="WIDTH: 100%;">
		<tr><td callspan=2><FONT color=black>&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Member Type</STRONG>&nbsp;</FONT></FONT></td>
		<td><select ID=MType Name=MType style="WIDTH: 150px">
		<%
		if(request.getParameter("MType")==null)
		{
			%>
			<option value="S">Student</option>
			<option value="E" Selected>Employee</option>
			<!--<option value="G">Guest</option>		
		  <option value="V">Visitor</option>-->
			<%
		}
		else
		{
			if(request.getParameter("MType").toString().trim().equals("S"))
			{
				%>
				<option value="S" Selected>Student</option>
				<%
			}
			else
			{
				%>
				<option value="S">Student</option>
				<%
			}	
			if(request.getParameter("MType").toString().trim().equals("E"))
			{
				%>
				<option value="E" Selected>Employee</option>
				<%
			}
			else
			{
				%>
				<option value="E">Employee</option>
				<%
			}
/*		if(request.getParameter("MType").toString().trim().equals("G"))
			{
				%>
				<option value="G" Selected>Guest</option>
				<%
			}
			else
			{
				%>
				<option value="G">Guest</option>
				<%
			}	
			if(request.getParameter("MType").toString().trim().equals("V"))
			{
				%>
				<option value="V" Selected>Visitor</option>
				<%
			}
			else
			{
				%>
				<option value="V">Visitor</option>
				<%
			}*/
		}
		%>
 		</select></td>
		<td><STRONG>&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2 color=black>Member Code</FONT></STRONG></FONT></td>
		<%
		if(request.getParameter("x")==null)
		mMCode="";
		else
		mMCode=request.getParameter("MemberCode").toString().trim();
		%>
		<td><INPUT ID="MemberCode" Name="MemberCode" Type="text" value="<%=mMCode%>" style="WIDTH: 100px; HEIGHT: 22px"><FONT color=red>* </FONT></td>
		<td><INPUT Type="submit" Value="Show/Refresh" onClick="RefreshContents();"></td></tr>
		</table>
		</form> 
		<%
		if(request.getParameter("x")!=null)
		{
			if (request.getParameter("MemberCode")==null || request.getParameter("MemberCode").equals(""))
			{
	  		mMCode="";
				mEMCode="";
			}
			else
			{
				mMCode=request.getParameter("MemberCode").toString().trim();
				mEMCode=enc.encode(mMCode);
			}

			if (request.getParameter("MType")==null)
			{
				mMType="";
				mEMType="";
			}
			else
			{
				mMType=request.getParameter("MType").toString().trim();
				mEMType=enc.encode(mMType);
			}
		
			if(!mMCode.equals("") && !mMType.equals(""))
			{
				qry="select nvl(ORAADM,' ')Role, ORAID, nvl(ORATYP,' ')Type from membermaster ";
				qry=qry+" where ORACD='"+mEMCode+"' and ORATYP='"+mEMType+"' and nvl(DEACTIVE,'N')='N'";
				//out.print(qry);
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
						if(rs1.next())
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

						<form method="post" name="frmm"> 					
						<input id="y" name="y" type=hidden>
						<table cellpadding=0 align=center rules=groups border=1 style="WIDTH: 470px;">
						<tr><td colspan=1><FONT color=black>&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Selected Member</STRONG></FONT></FONT></td>
						<%
						if(mDEmpType.equals("E"))
						{
							Qry="select nvl(EMPLOYEECODE,' ')MC, nvl(EMPLOYEENAME,' ')MN from employeemaster where EMPLOYEECODE='"+mMCode+"'";
						}
						else if(mDEmpType.equals("S"))
						{
							Qry="select nvl(ENROLLMENTNO,' ')MC, nvl(STUDENTNAME,' ')MN from studentmaster where ENROLLMENTNO='"+mMCode+"'";
						}
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
						qry="Select Distinct NVL(ROLENAME,' ')RoleName, nvl(ROLEDESCRIPTION,' ')RoleDesc from WEBKIOSKROLEMASTER WHERE ROLEFORMEMBERTYPE='"+mMType+"' and nvl(deactive,'N')='N' order by RoleDesc asc";
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
						if(request.getParameter("y")!=null && request.getParameter("x")!=null)					
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
								qry="update MEMBERMASTER set ORAADM='"+mENewRole+"' Where trim(ORATYP)='"+mEMType+"' and trim(ORACD)='"+mEMCode+"'";
								//qry=qry+" and trim(ORAADM)='"+mEmpRole+"'";
								int n=db.update(qry);
								//out.print(qry);
								if(n>0)			  
								{
									qry2="select nvl(ROLEDESCRIPTION,' ')NEWROLE from WEBKIOSKROLEMASTER where ROLENAME='"+mNewRole+"'";
									rs2=db.getRowset(qry2);
									rs2.next();
									String mNRole=rs2.getString("NEWROLE");
									%>
									<hr><table align=center width=100%> <tr bgcolor="skyblue"><td align=left>
									<font size=3 face='Arial' color="#006600"><b><%=mCode%>'s Role changed successfully...</b></font>
									</td></tr></table>
									<TABLE align=center calspan=0 cellSpacing=0 cellPadding=1 width="80%" border=0 >
									<tr>
									 <td align=left><b><font color="#00008b">Previous Role was: </font></b><font color="#00008b">&nbsp;&nbsp;<%=mOldRole%></font></td></tr>
									<tr>
									 <td align=left><b><font color="#00008b">New Role is: </font></b><font color="#00008b">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=mNRole%></font></td></tr>
									</TABLE>			
									<hr>
									<%
									db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"CHANGE MEMBER WEBKIOSK ROLE", "Member Code : "+mMCode, "No MAC Address" , mIPAddress);
								}
								else
								{
									 out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp<b><font size=3 face='Arial' color='Red'>Error while changing New Role</b></center>");
								}
								//--------------------------
							}
						}
						
//-----End of Second Table's Scope-----//
					}      // ------------closing of if(rs.next())
					else
					{
			   		out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>No such member found against this Member Type !</font></b></center>");
					}
				}
				catch(Exception e)
				{
					//out.print("Error in upper try");
				}
			}	//---------closing of if(!mMCode.equals(""))
			else
			{
				out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Member Code can't be left blank !</font></b></center>");
			}

		}  //--------------closing of request.getParameter("x")!=null
 	//-----------------------------
	//-- Enable Security Page Level  
  	//-----------------------------
	}
	else
	{
  	%>
		<br><font color=red>
		<h3><br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
		<P>This page is not authorized/available for you.
		<br>For assistance, contact your network support team. 
		</font><br><br><br><br>
  	<%
	}
  	//-----------------------------
}
else
{
	out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp'>Login</a> to continue</font>");
}
%>
	<table ALIGN=Center VALIGN=TOP>
	<tr>
	<td valign=middle><br>
	<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">	<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br><FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href="mailto:webkiosk@jiit.ac.in ">webkiosk@jiit.ac.in</A></FONT>
	</td>
	</tr>
	</table>
</BODY>
</HTML>