<%@ page language="java" import="java.sql.*,tietwebkiosk.*,javax.servlet.http.HttpServletRequest" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
try
{
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
String mHead="";
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberID="",mDMemberCode="",mDMemberType="";
String mDepartmentCode="",mCompanyCode="";
String qry="",qryd="",qryd1="";
ResultSet rs=null;
int mCnt=0;
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
if (session.getAttribute("DepartmentCode")==null)
{
	mDepartmentCode="";
}
else
{
	mDepartmentCode=session.getAttribute("DepartmentCode").toString().trim();
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
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Leave Request Approval ] </TITLE>

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
		qry="Select WEBKIOSK.ShowLink('158','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{

String mPRN="";
String mCmp="";
String mFinal="";
int mCtr=0;
		if(request.getParameter("Final")==null)
			mFinal="";
		else
			mFinal=request.getParameter("Final").toString().trim();

		if(request.getParameter("CTR")==null)
			mCtr=0;
		else
			mCtr=Integer.parseInt(request.getParameter("CTR").toString().trim());


		if(request.getParameter("PRN")==null)
			mPRN="";
		else
			mPRN=request.getParameter("PRN").toString().trim();

		if(request.getParameter("CMP")==null)
			mCmp="";
		else
			mCmp=request.getParameter("CMP").toString().trim();

if(mFinal.equals("A"))
{
qry="update PRMASTER set DOCMODE='A',approvedby='"+mChkMemID+"',approveddate=sysdate where companycode='"+mCmp+"' and PRNO='"+mPRN+"' and nvl(Deactive,'N')='N' ";
int n =db.update(qry);
if(n>0)
	{
		response.sendRedirect("PurchaseRequisitionApprove.jsp");
	}
	else
	{
			out.print("<font color=red>Error while saving Record...</font");
	}
}
else
{

qry="update PRMASTER set DOCMODE='C',approvedby='"+mChkMemID+"',approveddate=sysdate where companycode='"+mCmp+"' and PRNO='"+mPRN+"' and nvl(Deactive,'N')='N' ";
int n =db.update(qry);
if(n>0)
	{
		response.sendRedirect("PurchaseRequisitionApprove.jsp");
	}
	else
	{
			out.print("<font color=red>Error while saving Record...</font");
	}
/*
for(int a1=1;a1<=mCtr;a1++)
{
qry="select count(*)cnt from PRDETAIL where companycode='"+mCmp+"' and PRNO='"+mPRN+"' and nvl(DEACTIVE,'N')='N' ";
rs=db.getRowset(qry);
rs.next();
mCnt=rs.getInt("cnt");
if(mCnt>1)
{	
qryd="delete from PRDETAIL where  companycode='"+mCmp+"' and PRNO='"+mPRN+"' and nvl(DEACTIVE,'N')='N' and rownum=1";
int a=db.update(qryd);	
}
else
{
	qryd="update PRDETAIL set Deactive='Y' where  companycode='"+mCmp+"' and PRNO='"+mPRN+"' and nvl(DEACTIVE,'N')='N' ";
    int a=db.update(qryd);	
	if(a>0)
	{
	qryd1="update PRMAster set Deactive='Y' where  companycode='"+mCmp+"' and PRNO='"+mPRN+"' and nvl(DEACTIVE,'N')='N' ";
	int b=db.update(qryd1);	  
	}
}	
 mCnt=0;
} // closing of for
*/
	//response.sendRedirect("PurchaseRequisitionApprove.jsp");
	}
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

}
%>
</body>
</html>

