<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT";
%>
<HTML>
<head>
 <TITLE>#### <%=mHead%> [ Student Fee Paid Action  ] </TITLE>


<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
<script type="text/javascript" src="../js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="../css/sortabletable.css" />

</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
OLTEncryption enc=new OLTEncryption();

DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
ResultSet RsFee=null,rs=null,rs1=null,rs2=null;
String qry1="",qry="",qry2="",mWebEmail="";
String mMemberID="";
String mMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mmMemberName="";
String mCompanyCode="";
String mAcademicYearCode="";
String mProgramCode="";
String mBranchCode="";
String mCurrentSem="";
int mCurSem=0;
String mMS="",mRegCode="";
String mInstituteCode="",mHostel="",mTotalAmount="";
String mStudID="",mQuota="",mSem="",mAcadYear="",mProCode="",mBranCode="",mSemType="",mCat="",mSemFeeTranDet="";
double Total=0.0;

try
{
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
  

if (session.getAttribute("CompanyCode")==null)
{
	mCompanyCode="";
}
else
{
	mCompanyCode=session.getAttribute("CompanyCode").toString().trim();
}

if (request.getParameter("academicyear")==null)
{
	mAcadYear="";
}
else
{
	mAcadYear=request.getParameter("academicyear").toString().trim();
}


if (request.getParameter("programcode")==null)
{
	mProCode="";
}
else
{
	mProCode=request.getParameter("programcode").toString().trim();
}
if (request.getParameter("branchcode")==null)
{
	mBranCode="";
}
else
{
	mBranCode=request.getParameter("branchcode").toString().trim();
}
if (request.getParameter("semestertype")==null)
{
	mSemType="";
}
else
{
	mSemType=request.getParameter("semestertype").toString().trim();
}

if (request.getParameter("semester")==null)
{
	mSem="";
}
else
{
	mSem=request.getParameter("semester").toString().trim();
}
if (request.getParameter("STUDENTID")==null)
{
	mStudID="";
}
else
{
	mStudID=request.getParameter("STUDENTID").toString().trim();
}
if (request.getParameter("Quota")==null)
{
	mQuota="";
}
else
{
	mQuota=request.getParameter("Quota").toString().trim();
}
if (request.getParameter("Hostel")==null)
{
	mHostel="";
}
else
{
	mHostel=request.getParameter("Hostel").toString().trim();
}


if (request.getParameter("RegCode")==null)
{
	mRegCode="";
}
else
{
	mRegCode=request.getParameter("RegCode").toString().trim();
}


if (request.getParameter("TotalAmount")==null)
{
	mTotalAmount="";
}
else
{
	mTotalAmount=request.getParameter("TotalAmount");
}
//out.print(mTotalAmount+"ass");
if (session.getAttribute("InstituteCode")==null)
{
	mInstituteCode="";
}
else
{
	mInstituteCode=session.getAttribute("InstituteCode").toString().trim();
}
if(!mMemberID.equals("") && !mMemberCode.equals("") ) 
{
	try
	{			
		mDMemberCode=enc.decode(mMemberCode);
		mMemberID=enc.decode(mMemberID);
	}
	catch(Exception e)
	{
		out.println(e.getMessage());
	}

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('249','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
  //----------------------
	
		%>
		<form name=frm1 method=Post action="StudFeeDepositGateway.jsp">
			<TABLE align=center width="80%" rules=group cellspacing=1 cellpadding=3>
			<tr><td  align=center colspan=2>
			<font size=4 face=arial color=#a52a2a><b>Pay Gateways </b> </font>
			</td></tr>
			
			</table>
			<br>
			<TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=3 width="50%" border=1 >
			<thead>
			<tr bgcolor="#ff8c00">
		
			<td><b><font color="white" size=4><b>Bank Description</b></font></td>
					</tr>
			</thead>
			<tbody> 
			<tr bgcolor=white>
		<%
		qry="SELECT PGID,PGNUMBER,CONTACTADDRESS,CONTACTNUMBER,PGDESCRIPTION FROM PAYMENTGATEWAYMASTER WHERE NVL(DEACTIVE,'N')='N' ";
		//out.print(qry);	
		rs=db.getRowset(qry);
		while(rs.next())
		{
			%>
			<tr bgcolor=white >
			<td nowrap>
			<INPUT TYPE="image" SRC="../images/ar2.gif" width="10" height="10"> 
			 <font size=3 face="Comic sans MS"><b><a href="StudFeeDepositGateAction.jsp?Description=<%=rs.getString("PGDESCRIPTION")%>&amp;PGID=<%=rs.getString("PGID")%>" title="Pay Fees"  >     <b>  <%=rs.getString("PGDESCRIPTION")%> </b> </a>
			
			</b></font></td>
			</tr>
			<%					
		}
		%>
			
		  </tr>
		</tbody>
		</TABLE>
		</form>


<%
  //-----------------------------
  //-- Enable Security Page Level  
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

}
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}
}
catch(Exception e)
{
}
%>
<table ALIGN=Center VALIGN=TOP>
<tr>
	<td valign=middle><br><br><br><br><br>
	<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">	<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br><FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>
	</td>
</tr>
</table>
</body>
</html>
