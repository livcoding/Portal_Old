<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../CommonFiles/ExceptionHandler.jsp" %> 
<%
try{
String mHead="";

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";

%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ List of Role assigned Members ] </TITLE>


<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
</script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<script language=javascript>
<!--
function RefreshContents()
{
   	document.frm.x.value='ddd';
	document.frm.x.value='ddd';
}
//-->

function MemberCode_onchange() 
{
	var mUserCode;
	mUserCode=frm.MemberCode.value;	 
	frm.MemberCode.value = mUserCode.toUpperCase();
}
</script>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
	OLTEncryption enc=new OLTEncryption();
	DBHandler db=new DBHandler();
	ResultSet rs1=null,rs=null,rs2=null;

	String mMType="",mEMType="";
	String mMMType="",mEMMType="", mEidType="";
	String qry="",qry1="",qry2="",mInst="", mMemHeading="", mPBorDDHeading="";
	String mMemberCode="";
	String mEMemberCode="";

	String mNewPass="";
	String mRetPass="";
	String mENewPass="";
	String mERetPass="";

	String mGetDefPwd="";
	String mEGetDefPwd="";
	String mEmpPwd="";
	String mEEmpPwd="",x="",mRoles="";
	String mStdPwd="",men="",mec="",mMRole1="",mMRole="";
	String mEStdPwd="",mRole="",mrole="",Mtype1="",Adm="",DAdm="",Mid="",DMid="",mdp="",mdb="";
	int kk=0;
	
// For Log Entry Purpose
//--------------------------------------
String mLogEntryMemberID="",mLogEntryMemberType="";

if (session.getAttribute("BASELOGINID")==null || session.getAttribute("BASELOGINID").toString().trim().equals(""))
	mLogEntryMemberID="";
else
	mLogEntryMemberID=session.getAttribute("BASELOGINID").toString().trim();


if (session.getAttribute("BASELOGINTYPE")==null || session.getAttribute("BASELOGINTYPE").toString().trim().equals(""))
	mLogEntryMemberType="";
else
	mLogEntryMemberType=session.getAttribute("BASELOGINTYPE").toString().trim();

if (session.getAttribute("BASEINSTITUTECODE")==null)
	mInst="JIIT";
else
	mInst=session.getAttribute("BASEINSTITUTECODE").toString().trim();
if(mInst.equals("JIIT"))
	mEidType="UNIV";
else
	mEidType="JPBS";
if (!mLogEntryMemberType.equals(""))
	mLogEntryMemberType=enc.decode(mLogEntryMemberType);

if (!mLogEntryMemberID.equals(""))
	mLogEntryMemberID=enc.decode(mLogEntryMemberID);

//--------------------------------------
String mIPAddress=session.getAttribute("IPADD").toString().trim();
		
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

	%>
		<form name="frm">
		<input id="x" name="x" type=hidden>
		<table ALIGN=CENTER bottommargin=0 topmargin=0>
		<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>List of Member and their Roles[For Active User]</b></font></td></tr>
		</table>
		
		<!*********--Institute--************>
		<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
		<table cellpadding=5 align=center rules=groups border=2>
		<tr><td callspan=2>&nbsp;<FONT color=black><FONT face=Arial size=2><STRONG>Member Type</STRONG>&nbsp;</FONT></td>
		<td><select ID=MType Name=MType>		

		<%
	
			if(request.getParameter("MType")==null)
			{
		%>
			<option value="E" selected>Employee</option>
			<option value="S"> Student</option>
			
      	<%
			}
			else
			{
				
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
		  	}
	 %>
	 	</select>
		</td>
		<td callspan=2>&nbsp;&nbsp;<FONT color=black><FONT face=Arial size=2><STRONG>Assigned Role</STRONG>&nbsp;&nbsp;&nbsp;&nbsp;</FONT></FONT></td>
	<%
		qry="Select Distinct NVL(ROLENAME,' ')Role ,nvl(roledescription,' ')roledescription from WEBKIOSKROLEMASTER WHERE nvl(deactive,'N')='N' order by roledescription asc ";
		rs=db.getRowset(qry);
		if (request.getParameter("x")==null)
		{
	%>
			<td><select name=MRole tabindex="0" id="MRole">	
			<OPTION selected value=ANY>ANY</option>

	<%   
			while(rs.next())
			{
				mRole=rs.getString("Role");
				if(mrole.equals(""))
 				mrole=mRole;
				%>
				<OPTION  Value =<%=mRole%>><%=rs.getString("roledescription")%></option>
				<%			
			}
			%>
			</select></td>
			<%
		}
		else
		{
			%>	
			<td><select name=MRole tabindex="0" id="MRole">	
			<%
			if(request.getParameter("MRole").toString().trim().equals("ANY"))
	 		{
		%>
	 			<OPTION selected value=ANY>ANY</option>
		<%
			}
			else
			{
		%>
				<OPTION value=ANY>ANY</option>
		<%
			}
			while(rs.next())
			{
				mRole=rs.getString("Role");
				if(mRole.equals(request.getParameter("MRole").toString().trim()))
 				{
					mrole=mRole;
					%>
					<OPTION selected Value =<%=mRole%>><%=rs.getString("roledescription")%></option>
					<%			
		     		}
			     	else
			      {
					%>
		      		<OPTION Value =<%=mRole%>><%=rs.getString("roledescription")%></option>
		      		<%			
			   	}
			}
			%>
			</select></td>
		  	<%
	 	}
		%>
 		<td colspan=2 align=center><INPUT Type="submit" Value="List/View" </td></tr>
		</table>
		</form>
		<%
            mMType=request.getParameter("MType").toString().trim();
		if(mMType.equals("E"))
		{
			mMemHeading="Employee Code";
			mPBorDDHeading="Designation - Department";
		}
		else if(mMType.equals("S"))
		{
			mMemHeading="Enrollment No";
			mPBorDDHeading="Program - Branch";
		}
            Mtype1=enc.encode(mMType);
		mMRole=request.getParameter("MRole").toString().trim();
		mMRole1=enc.encode(mMRole);
		String mAny=enc.encode("ANY");
		%>
		<table bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=groups topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center>	
		<thead>
		<tr bgcolor="#ff8c00">
		<td><font color=white><b>S.No</b></td>
		<td><font color=white><b><%=mMemHeading%></b></td>
           	<td><font color=white><b>Member Name</b></td>
		<td><font color=white><b>Assigned Role</b></td>
           	<td><font color=white><b><%=mPBorDDHeading%></b></td>
		</tr>
		</thead>
		<tbody>	
		<%
		if(mMType.equals("S"))
     		{		
			qry1="Select nvl(enrollmentno,' ')enrollmentno,nvl(STUDENTNAME,' ')STUDENTNAME,";
			qry1=qry1+" nvl(programcode,' ')programcode,nvl(branchcode,' ')branchcode from STUDENTMASTER";
			qry1=qry1+" where InstituteCode='"+mInst+"' order by STUDENTNAME asc ";
			rs1=db.getRowset(qry1);
			while(rs1.next())
			{
				kk++;
				men=rs1.getString("STUDENTNAME");
				mec=rs1.getString("enrollmentno");
				mdp=rs1.getString("programcode");
				mdb=rs1.getString("branchcode");

				qry="select nvl(ORAID,' ')ORAID,nvl(ORACD,' ')ORACD,nvl(ORAADM,' ')ORAADM from membermaster where nvl(Deactive,'N')='N'";
				qry=qry+" and ORACD='"+enc.encode(mec)+"' and ORATYP='"+Mtype1+"' and ORAADM=decode('"+mMRole1+"','"+mAny+"',ORAADM,'"+mMRole1+"')";
				rs=db.getRowset(qry);
            		if(rs.next())
				{
					mRoles=rs.getString("ORAADM");
					mRoles=enc.decode(mRoles);
					qry="Select nvl(roledescription,' ')roledescription from WEBKIOSKROLEMASTER WHERE ROLENAME='"+mRoles+"'";
					//out.print(qry);
					rs2=db.getRowset(qry);
					if(rs2.next())
						mRoles=rs2.getString("roledescription");
					%>
     				     	<tr>
					<td align=right><%=kk%>. &nbsp; &nbsp; &nbsp; &nbsp;</td>
					<td align=right><%=mec%>&nbsp; &nbsp; &nbsp; &nbsp;</td>
					<td><%=GlobalFunctions.toTtitleCase(men)%></td>
      		     		<td><%=GlobalFunctions.toTtitleCase(mRoles)%></td>
					<td align=center><%=mdp%> <b>&mdash;</b> <%=mdb%></td>
					</tr>
					<%
				}
			}
		}
		else 
     		{	
			qry1="Select nvl(A.employeecode,' ')employeecode,nvl(A.EMPLOYEENAME,' ')EMPLOYEENAME,";
			qry1=qry1+" nvl(C.department,' ')departmentcode,nvl(B.designation,' ')designationcode from V#STAFF A, DESIGNATIONMASTER B, DEPARTMENTMASTER C";
	     		qry1=qry1+" where A.CompanyCode IN (Select nvl(COMPANYTAGGING,'UNIV') from InstituteMaster where InstituteCode='"+ mInst +"' And nvl(Deactive,'N')='N')";
			qry1=qry1+" AND A.DEPARTMENTCODE=C.DEPARTMENTCODE AND A.DESIGNATIONCODE=B.DESIGNATIONCODE ";
			qry1=qry1+" and A.EMPLOYEEID LIKE '%"+mEidType+"%' order by EMPLOYEENAME asc";
		      rs1=db.getRowset(qry1); 
			//out.print(qry1);
  			while(rs1.next())
			{
				kk++;
				men=rs1.getString("EMPLOYEENAME");
			      mec=rs1.getString("employeecode");
				mdb=rs1.getString("departmentcode");
				mdb=GlobalFunctions.toTtitleCase(mdb);
				mdp=rs1.getString("designationcode");
				mdp=GlobalFunctions.toTtitleCase(mdp);

				qry="select nvl(ORAID,' ')ORAID,nvl(ORACD,' ')ORACD,nvl(ORAADM,' ')ORAADM from membermaster where nvl(Deactive,'N')='N'";
				qry=qry+" and ORACD='"+enc.encode(mec)+"' and ORATYP='"+Mtype1+"' and ORAADM=decode('"+mMRole1+"','"+mAny+"',ORAADM,'"+mMRole1+"')";
				rs=db.getRowset(qry);
            		if(rs.next())
				{
					mRoles=rs.getString("ORAADM");
					mRoles=enc.decode(mRoles);
					qry="Select nvl(roledescription,' ')roledescription from WEBKIOSKROLEMASTER WHERE ROLENAME='"+mRoles+"'";
					rs2=db.getRowset(qry);
					if(rs2.next())
						mRoles=rs2.getString("roledescription");
					%>
     				     	<tr>
					<td align=right><%=kk%>. &nbsp; &nbsp; &nbsp; &nbsp;</td>
					<td align=right><%=mec%>&nbsp; &nbsp; &nbsp; &nbsp;</td>
					<td><%=GlobalFunctions.toTtitleCase(men)%></td>
      		     		<td><%=GlobalFunctions.toTtitleCase(mRoles)%></td>
					<td align=left><%=mdp%> <b>&mdash;</b> <%=mdb%></td>
					</tr>
					<%
				}
			}
		}
		%>
		</tbody>	
		</table>

		<script type="text/javascript">
		var st1 = new SortableTable(document.getElementById("table-1"),["Number","Number","CaseInsensitiveString", "CaseInsensitiveString", "CaseInsensitiveString"]);
		</script>
		<%
	}  // closing of outer if
}
catch(Exception e)
{
//out.print("eeeeeeeeeee");
}		
%>         
<table ALIGN=Center VALIGN=TOP>
<br><tr>
<td valign=middle>
<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">	<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT>
</td>
</tr>
</table>
<BR>
</body>
</html>