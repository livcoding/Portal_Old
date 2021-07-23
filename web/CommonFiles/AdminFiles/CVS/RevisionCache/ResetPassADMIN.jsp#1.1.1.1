
<!-- Parents Password single reset  Date 12.04.2018-->

<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";

%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Reset Password of WEBKIOSK Member ] </TITLE>
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
	ResultSet rs=null;
	ResultSet rs1=null,rsi=null;

	String mMType="",mEMType="";
	String mMMType="",mEMMType="";
	String qry="",qry1="",qry2="",mInst="", mComp="";
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
	int mPwdLength=0;

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


//out.print("Inst Code - "+mLogEntryMemberID);


if (session.getAttribute("BASEINSTITUTECODE")==null)
	mInst="JIIT";
else
	mInst=session.getAttribute("BASEINSTITUTECODE").toString().trim();



qry="Select nvl(COMPANYTAGGING,'UNIV')COMP from InstituteMaster where " +
        "InstituteCode='"+ mInst +"' And nvl(Deactive,'N')='N'";

rs=db.getRowset(qry);
if(rs.next())
{
	mComp=rs.getString("COMP");
}


if (!mLogEntryMemberType.equals(""))
	mLogEntryMemberType=enc.decode(mLogEntryMemberType);

if (!mLogEntryMemberID.equals(""))
	mLogEntryMemberID=enc.decode(mLogEntryMemberID);


//out.print("sdsd");


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
		<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: VERDANA"><b>Reset Webkiosk Password</b></font><br><font color="#a52a2a" style="FONT-SIZE: small; FONT-FAMILY: VERDANA">[Admin Users Only -]</font></td></tr>
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
	     		<option value="E">Employee</option>
      		<option value="A">Admin</option>
			<option value="G">Guest</option>
                        <option value="P">Parent</option>
      		<!--<option value="V">Visitor</option>-->
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
                        if(request.getParameter("MType").toString().trim().equals("P"))
			{
			%>
				 <option value="P">Parent</option>
			<%
			}
			else
			{
			%>
				 <option value="P">Parent</option>
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

					if(mMType.equals("E") || mMType.equals("V") || mMType.equals("G") || mMType.equals("I"))
				{
					//mMType=request.getParameter("MType").toString().trim();
					qry1="select MINRANGE from PARAMETERS where MODULENAME='SIS' and PARAMETERID='B1.5'";
				}
				else
				{
					//mMType=request.getParameter("MType").toString().trim();
					qry1="select MINRANGE from PARAMETERS where MODULENAME='SIS' and PARAMETERID='B1.4'";
				}
				rs1=db.getRowset(qry1);
				//out.print(qry1);
				rs1.next();
				mPwdLength=rs1.getInt("MINRANGE");


				qry="select webkiosk.GeneratePWD("+mPwdLength+") PWD from dual";
				rs=db.getRowset(qry);
				if(rs.next())
					mNewPass=rs.getString("PWD").toUpperCase();
			}
			if(request.getParameter("MemberCode")==null)
			{
				mMemberCode="";
			}
			else
			{
				mMemberCode=request.getParameter("MemberCode").toString().trim();
			}
			if(!mMemberCode.equals(""))
			{
				if(mMType.equals("E"))
				{
					qry="SELECT 'Y' FROM EMPLOYEEMASTER WHERE EMPLOYEECODE='"+mMemberCode+"' AND COMPANYCODE='"+mComp+"' AND NVL(DEACTIVE,'N')='N'";
				}
				else if(mMType.equals("S") ||mMType.equals("P"))
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
			//	out.print(qry);
				rs=db.getRowset(qry);
				if(rs.next())
				{
					mEMemberCode=enc.encode(mMemberCode);
					mEMType=enc.encode(mMType);
					mENewPass=enc.encode(mNewPass);
					qry="update MEMBERMASTER set ORAPW='"+mENewPass+"' , PWD='', EMAIL='',MEMCODE='',MEMNAME='' Where trim(ORATYP)='"+mEMType+"' and trim(ORACD)='"+mEMemberCode+"'";
					//out.print(mMemberCode+"::"+qry);
					int n=db.update(qry);		
					if(n>0)			  
					{
						// Log Entry
		  				//-----------------
						    db.saveTransLog(mInst,"ADMIN","A" ,"FORCIBLY RESET PASSWORD", "Member Code : "+mMemberCode+" Member Type : "+ mMType, "No MAC Address" , mIPAddress);
						//-----------------
						out.print("<center><b><font size=3 face='Arial' color='Green'>Password reset successfully</font></b></center>");
						%><br>
						<TABLE align=center calspan=0 cellSpacing=0 cellPadding=1 width="50%" border=0 >
						 <tr><td align=center><b><font color="#00008b">New Default Password is: <%=mNewPass%></font></b></td></tr>
						</TABLE>
						<%
					}
					else
					{
						out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Please select valid Member Type or enter valid Member Code</font></b></center>");
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
<BR>
</body>
</html>