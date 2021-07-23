<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mInst="", mHead="";
if (session.getAttribute("BASEINSTITUTECODE")==null)
	mInst="JUIT";
else
	mInst=session.getAttribute("BASEINSTITUTECODE").toString().trim();
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead=mInst+" ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ List of Webkiosk Member Password ] </TITLE>
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
	ResultSet rsFindPwd=null;
	ResultSet rs=null;
	ResultSet rs1=null,rsi=null;

	String mMType="",mEMType="";
	String mMMType="",mEMMType="";
	String qry="",qry1="",qry2="",mComp="";
	String mMemberCode="";
	String mEMemberCode="";


	String mNewPass="";
	String mRetPass="";
	String mENewPass="";
	String mERetPass="";

	String mGetDefPwd="";
	String mEGetDefPwd="";
	String mEmpPwd="";
	String mEEmpPwd="";
	String mStdPwd="";
	String mEStdPwd="",mLoginIDFrSes="";
	
	int mMaxPWD=20;
	int mMinPWD=5;

try
{
  try
  {
	if (session.getAttribute("MaxPasswordLength")==null)
	{
		mMaxPWD=20;
	}
	else
	{
		mMaxPWD=Integer.parseInt(session.getAttribute("MaxPasswordLength").toString().trim());		 
	}

	if (session.getAttribute("MinPasswordLength")==null)
	{
		mMinPWD=4;
	}
	else
	{
		mMinPWD=Integer.parseInt(session.getAttribute("MinPasswordLength").toString().trim());		 
	}
   }
   catch(Exception e)
   {
	mMaxPWD=20;
	mMinPWD=4;
   }
	
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
//out.print("Inst Code - "+session.getAttribute("BASEINSTITUTECODE"));

qry="Select nvl(COMPANYTAGGING,'JUIT')COMP from InstituteMaster where InstituteCode='"+ mInst +"' And nvl(Deactive,'N')='N'";
//	out.print(qry);
rs=db.getRowset(qry);
if(rs.next())
{
	mComp=rs.getString("COMP");
}
if (!mLogEntryMemberType.equals(""))
	mLogEntryMemberType=enc.decode(mLogEntryMemberType);

if (!mLogEntryMemberID.equals(""))
	mLogEntryMemberID=enc.decode(mLogEntryMemberID);


//--------------------------------------
String mIPAddress=session.getAttribute("IPADD").toString().trim();
if(mInst.equals("JIIT"))
	mLoginIDFrSes="asklJIITADMINaskl";
else if(mInst.equals("JPBS"))
	mLoginIDFrSes="asklJPBSADMINaskl";
else if	(mInst.equals("J128"))
	mLoginIDFrSes="asklJ128ADMINaskl";
else
	mLoginIDFrSes="asklADMINaskl";
//out.print(mLogEntryMemberID+" - "+mLoginIDFrSes);

	if(mLogEntryMemberID.equals(mLoginIDFrSes) && mLogEntryMemberType.equals("A")) 
	{

		%>
		<form name="frm">
		<input id="x" name="x" type=hidden>
		<table width="100%" ALIGN=CENTER bottommargin=0 topmargin=0>
		<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>List of Webkiosk Member Password</b></font><br><font color="#a52a2a" style="FONT-SIZE: small; FONT-FAMILY: fantasy">[Admin Users Only]</font></td></tr>
		</table>
		
		<!*********--Institute--************>
		<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
		<table cellpadding=5 align=center rules=groups border=2 style="WIDTH: 330px; HEIGHT: 100px">
		<tr><td callspan=2><FONT color=black>&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Member Type</STRONG>&nbsp;&nbsp;&nbsp;&nbsp;</FONT></FONT></td>
		<td><select ID=MType Name=MType style="WIDTH: 165px">		
		<%
		if(request.getParameter("MType")==null)
		{
			%>
			<option value="S" Selected>Student</option>
	     		<!--<option value="E">Employee</option>
      		<option value="A">Admin</option>
			<option value="G">Guest</option>
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
/*
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
			if(request.getParameter("MType").toString().trim().equals("G"))
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
			if(request.getParameter("MType").toString().trim().equals("A"))
			{
				%>
				<option value="A" Selected>Admin</option>
				<%
			}
			else
			{
				%>
				<option value="A">Admin</option>
				<%
			}
*/
		}
		%>
	 	</select>
		</td></tr><br>
		<tr>
	 	<td><FONT color=black>&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Member Code</STRONG></FONT>&nbsp;&nbsp;&nbsp; </FONT></td>
		 <td><INPUT ID="MemberCode" Name="MemberCode" LANGUAGE=javascript onchange="MemberCode_onchange();" style="WIDTH: 165px; HEIGHT: 25px" maxLength=50><FONT size=3 color=RED>*&nbsp;</FONT></td>
		</tr><tr>	
		<tr><td colspan=2 align=center><INPUT Type="submit" Value="Reset Password" onclick="RefreshContents();">&nbsp;<INPUT Type="reset" Value="Cancel"></td></tr>
		</table>
		</form>
		<%
		if(request.getParameter("x")!=null)
		{
			if (request.getParameter("MType")==null)
			{
				mMType="";
			}
			else
			{
				mMType=request.getParameter("MType").toString().trim();
			}
			if(request.getParameter("MemberCode")==null)
			{
				mMemberCode="";
			}
			else
			{
				mMemberCode=request.getParameter("MemberCode").toString().trim().toUpperCase();
			}
			if(!mMemberCode.equals(""))
			{
				if(mMType.equals("E"))
				{
					qry="SELECT 'Y' FROM EMPLOYEEMASTER WHERE EMPLOYEECODE='"+mMemberCode+"' AND COMPANYCODE='"+mComp+"' AND NVL(DEACTIVE,'N')='N'";
				}
				else if(mMType.equals("S"))
				{
					qry="SELECT 'Y' FROM STUDENTMASTER WHERE ENROLLMENTNO='"+mMemberCode+"' AND INSTITUTECODE='"+mInst+"' AND NVL(DEACTIVE,'N')='N'";
				}
				else if(mMType.equals("G"))
				{
					qry="SELECT 'Y' FROM GUEST WHERE GUESTCODE='"+mMemberCode+"' AND COMPANYCODE='"+mComp+"' AND NVL(DEACTIVE,'N')='N'";
				}
				else
				{
					qry="";
				}

				rs=db.getRowset(qry);
				if(rs.next())
				{
					mEMemberCode=enc.encode(mMemberCode);
					mEMType=enc.encode(mMType);
					qry="Select nvl(ORAPW,' ')ORAPW FROM MEMBERMASTER Where trim(ORATYP)='"+mEMType+"' and trim(ORACD)='"+mEMemberCode+"'";
					//out.print(mMType+" "+mMemberCode+" "+qry);
					rsFindPwd=db.getRowset(qry);
					if(rsFindPwd.next() && !rsFindPwd.getString("ORAPW").equals(" "))			  
					{
						%><br>
						<TABLE align=center calspan=0 cellSpacing=0 cellPadding=1 width="50%" border=0 >
						 <tr><td align=center><b><font color="#00008b">Your Password is: <%=enc.decode(rsFindPwd.getString("ORAPW"))%></font></b></td></tr>
						</TABLE>
						<%
					}
					else
					{
						out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Password Not Found! Kindly Reset Password...</font></b></center>");
					}
				}
				else
				{
					out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Invalid Member Code!</font></b></center>");
				}
			}
			else
			{
				out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Field(s) can't be empty</font></b></center>");
			}
		}
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
<br><br><br>
<hr>
<table ALIGN=Center VALIGN=TOP>
<tr><td valign=middle>
<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">	<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT>
</td></tr>
</table>
<BR>
</body>
</html>