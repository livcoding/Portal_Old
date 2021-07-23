<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
try
{
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
String mHead="";
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberID="",mDMemberCode="",mDMemberType="";
String mInst="";
String qry="";
String qry1="";
String qryd="";
String qryd1="";
ResultSet rss=null;
ResultSet rs=null;
ResultSet rsd=null;
ResultSet rsd1=null;

String mCentreCode="",mStoreCode="",mSiteCode="",mLocationCode="";
String mMajorHead="",mItemHead="",mItemSubHead="",mItemCode="",mPartRef="";
String mItemType="";
String mDataItemHead="",mDataItemSubHead="",mDataItemCode="";
String mMajoor="";
String mIteem="";
String mIteemSub="";
String mItemPartRef="";
String Mprno="";
String mNewPR="",mPRNO="";
String mPartMake1="";
int mfla=0;
String mCostCentre="",mStore="",mPrrefno="",mPrrefdate="";
String mSite="",mLocation="",mRemarks="",mItemCategory="" ;
String mMajorHead1="",mItemHead1="",mItemSubHead1="",mItemCode1="";
String mPartRefMake="",mPartMake="",mItemType1="",mQtyReq="";
String mAU="",mReqDate="",mRemarks1="",mDetailDesc="";
String mDepartmentCode="",mCompanyCode="";
String mIC="",mPC="",mCC="" ;
String mIMH="",mIHM="",mISHM="";
String mMM="",mDD="",mUOMM="",mRM="",mRDM="";
double mRQM=0,mAQM=0;
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
		qry="Select WEBKIOSK.ShowLink('157','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{
			qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from InstituteMaster Where nvl(Deactive,'N')='N' ";
			rs=db.getRowset(qry);
			if (rs.next())
				mInst=rs.getString(1);
			else
				mInst="JIIT";
			
			
	  //----------------------
%>
<br>
 <table align=center width=98% bottommargin=0 cellspacing=0 cellpadding=0 topmargin=0 border=0 >
<tr>
<td align=center>
<b>Deactive Purchase Requisition</b>
</td>
</tr>
<td align=right>
<a href="EditPurchaseRequisition.jsp"><font><b>BACK</b></font><a>
</td>
</tr>
</table>
<br>
<form name="frm"  method="post" >
<input id="y" name="y" type=hidden>
<%
		if(request.getParameter("PRNO")==null)
			mPRNO="";
		else
			mPRNO=request.getParameter("PRNO").toString().trim();

		if(request.getParameter("ITEMCODE")==null)
			mIC="";
		else
			mIC=request.getParameter("ITEMCODE").toString().trim();

		if(request.getParameter("POCKETCODE")==null)
			mPC="";
		else
			mPC=request.getParameter("POCKETCODE").toString().trim();

		if(request.getParameter("COMPANYCODE")==null)
			mCC="";
		else
			mCC=request.getParameter("COMPANYCODE").toString().trim();

qry="select count(*)cnt from PRDETAIL where companycode='"+mCC+"' and PRNO='"+mPRNO+"' and nvl(DEACTIVE,'N')='N' ";
// qry=qry+" and itemcode='"+mIC+"' and pocketcode='"+mPC+"'  ";
rs=db.getRowset(qry);
rs.next();
mCnt=rs.getInt("cnt");
out.print(mCnt);
if(mCnt>1)
{	
	qryd="delete from PRDETAIL where  companycode='"+mCC+"' and PRNO='"+mPRNO+"' and nvl(DEACTIVE,'N')='N' ";
	qryd=qryd+" and itemcode='"+mIC+"' and pocketcode='"+mPC+"'  ";
	
	int a=db.update(qryd);	
	if(a>0)
	{
	response.sendRedirect("EditPurchaseRequisition.jsp");
	}
	else
	{
		out.print("<font color=red>Error while deleting record...</font>");
	}
}
else
{
	qryd="update PRDETAIL set Deactive='Y' where  companycode='"+mCC+"' and PRNO='"+mPRNO+"' and nvl(DEACTIVE,'N')='N' ";
    qryd=qryd+" and itemcode='"+mIC+"' and pocketcode='"+mPC+"'  ";
	int a=db.update(qryd);	
	if(a>0)
	{
	qryd1="update PRMAster set Deactive='Y' where  companycode='"+mCC+"' and PRNO='"+mPRNO+"' and nvl(DEACTIVE,'N')='N' ";
	//out.print(qryd1);
	int b=db.update(qryd1);	  
	response.sendRedirect("EditPurchaseRequisition.jsp");
	}
	else
	{
		out.print("<font color=red>Error while deleting record...</font>");
	}
}
%>
	</form>
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

}
%>
</body>
</html>