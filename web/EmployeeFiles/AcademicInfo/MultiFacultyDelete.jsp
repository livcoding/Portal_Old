<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%

DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
ResultSet rs2=null;
ResultSet rsAtt=null, rsRowNum=null, RsChk1=null, rsdt=null;
GlobalFunctions gb=new GlobalFunctions();
String qry="";
String qry2="",mREGCONFIRMATIONDATE="";
String qry1="",mLTP="";
long mSNo=0,dt=0;
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="",mtime1="",mtime2="";
String mMemberName="";
String mInstitute="";
String mInst="", mComp="", mRightsID="",mLoginComp="",mDept="";
if (session.getAttribute("DepartmentCode")==null)
	{
		mDept="";
	}
	else
	{
		mDept=session.getAttribute("DepartmentCode").toString().trim();
	}

if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}

mInstitute=mInst;

if (session.getAttribute("LoginComp")==null)
{
	mLoginComp="";
}
else
{
	mLoginComp=session.getAttribute("LoginComp").toString().trim();
}

if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}



if (session.getAttribute("MemberID")==null)
{
	mMemberID="";
}
else
{
	mMemberID=session.getAttribute("MemberID").toString().trim();
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

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead=" ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Subjectwise Students Class Attendance ] </TITLE>

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
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body  onload="AlertMe()" aLink=#ff00ff  bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
try
{
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{	OLTEncryption enc=new OLTEncryption();
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
	qry="Select WEBKIOSK.ShowLink('259','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
 	RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
		
		
  //----------------------
String mAddFaculty="",FSTID="";
int mflag=0;


if(request.getParameter("FSTID")==null)	
FSTID="";
else
FSTID=request.getParameter("FSTID").toString().trim();

if(request.getParameter("EMPLOYEEID")==null)	
mAddFaculty="";
else
mAddFaculty=request.getParameter("EMPLOYEEID").toString().trim();



			qry="select 'Y' from MULTIFACULTYSUBJECTTAGGING where INSTITUTECODE='"+mInst+"' and COMPANYCODE='"+mComp+"' and FSTID='"+FSTID+"' and EMPLOYEEID='"+mAddFaculty+"' ";
			rs1=db.getRowset(qry);
			if(rs1.next())
				{
					qry2="delete from MULTIFACULTYSUBJECTTAGGING where INSTITUTECODE='"+mInst+"' and COMPANYCODE='"+mComp+"' and FSTID='"+FSTID+"' and EMPLOYEEID='"+mAddFaculty+"' ";
					//out.print(qry2);
					int a=db.update(qry2);
					if(a>0)
						mflag=1;
					else
						mflag=0;	
				}

		if(mflag==1)
			  out.print("<center> <font face=verdana  color=green size=3>Record Deleted Successfully !</font>   </center>");

%><center><a href="javascript:window.close()"><FONT SIZE=2 COLOR=BLUE FACE=VERDANA>Close this Window</FONT></a></center>

<%

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
	 //out.print("error");	
}
%>
</body>
</html>