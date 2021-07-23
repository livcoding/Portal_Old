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
String mCostCentre="",mStore="",mPrrefno="",mPrrefdate="";
String mSite="",mLocation="",mRemarks="",mItemCategory="" ;
String qryd="",mDate="";
ResultSet rsd=null;
ResultSet rs=null;
int  flag=0;
int  flag1=0;
String mDepartmentCode="",mCompanyCode="";
String mPRNO="";

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
<body aLink=#ff00ff bgcolor='#fce9c5' rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 onload="Disab();">
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

			qryd="select to_char(sysdate,'dd-mm-yyyy') from dual ";
			rsd=db.getRowset(qryd);
			rsd.next();
			mDate=rsd.getString(1);

	  //----------------------
		if(request.getParameter("CostCentre")==null)
			mCostCentre="";
		else
			mCostCentre=request.getParameter("CostCentre").toString().trim();

		if(request.getParameter("Store")==null)
			mStore="";
		else
			mStore=request.getParameter("Store").toString().trim();
	
		if(request.getParameter("Prrefno")==null)
			mPrrefno="";
		else
			mPrrefno=request.getParameter("Prrefno").toString().trim();
		if(request.getParameter("Prrefdate")==null || request.getParameter("Prrefdate").equals(" ") || request.getParameter("Prrefdate").equals(""))
		{
			mPrrefdate="";
			flag=1;	
		}
		else
		{
			mPrrefdate=request.getParameter("Prrefdate").toString().trim();
			if(gb.iSValidDate(mPrrefdate))
			{
				flag=1;		
			}	
			else
			{
				mPrrefdate="";
				flag=0;
			}
		}

		if(request.getParameter("Site")==null)
			mSite="";
		else
			mSite=request.getParameter("Site").toString().trim();

		if(request.getParameter("Location")==null)
			mLocation="";
		else
			mLocation=request.getParameter("Location").toString().trim();

		if(request.getParameter("Remarks")==null)
			mRemarks="";
		else
			mRemarks=GlobalFunctions.replaceSignleQuot(request.getParameter("Remarks").toString().trim());

		if(request.getParameter("PRNO")==null)
				mPRNO="";
		else
				mPRNO=request.getParameter("PRNO").toString().trim();
		
 if(flag!=0)
 {	
qry=" update PRMASTER set PRDATE=sysdate,COSTCENTRECODE='"+mCostCentre+"',";
qry=qry+" STORECODE='"+mStore+"',LOCATIONCODE='"+mLocation+"',SITECODE='"+mSite+"', ";
qry=qry+" PRREFERENCENO='"+mPrrefno+"', PRREFERENCEDATE=to_date('"+mPrrefdate+"','dd-mm-yyyy'),REMARKS='"+mRemarks+"', ";
qry=qry+" ENTRYBY='"+mChkMemID+"',ENTRYDATE=sysdate where companycode='"+mCompanyCode+"' and ";
qry=qry+" PRNO='"+mPRNO+"' and departmentcode='"+mDepartmentCode+"'  ";
int n=db.update(qry);
//out.print(qry);
if(n>0)
{
	response.sendRedirect("PurchaseRequisition.jsp");
	out.print("<font size=3 color=green>Record Updated successfully</font>");
}
else
{
	out.print("<font size=3 color=red>Error while saving record...</font>");
}

 }// closing of flag
else
	{
		out.println("<center><font face=arial size=2 color=red><b>Invalid date.....</b></font></center>");
		out.println("<center><font face=arial size=2 color=red><b>Valid date format is 'DD-MM-YYYY'.....</b><br><a href=PurchaseRequisition.jsp><b>BACK</b></a></font></center>");
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
	out.print(e);
}
%>
</body>
</html>