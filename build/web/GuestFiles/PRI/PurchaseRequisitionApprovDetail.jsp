<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
try{
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
String mHead="";
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberID="",mDMemberCode="",mDMemberType="";
String mInst="";
String qry="";
String qry1="";
String qrys="";
String qryi="";
ResultSet rsi=null;
ResultSet rss=null;
ResultSet rs=null;
ResultSet rsd1=null;
String qryd1="";
String mDepartmentCode="",mCompanyCode="",mItemCode="",mPocketCode="";
String qryc="",qrysi="",qryl="",qryp="";
ResultSet rsci=null,rssi=null,rsl=null,rsp=null,rsc=null;

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
		qry="Select WEBKIOSK.ShowLink('156','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
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
	<form name="frm"  method="post" >
	<input id="x" name="x" type=hidden>
<br>
<table align=center bottommargin=0 width=100% cellspacing=0 cellpadding=0 topmargin=0 border=0 >
<tr>
<td align=center>
<b>Approve Purchase Requisition</b>
</td>
</tr>
</table>
<br>
<%
	String mCCc="",mSc="",mPrn="",mPrd="",mSitc="",mLc="",mRe="",mPRNO="";

			if(request.getParameter("PRNO")==null)
				mPRNO="";
			else
				mPRNO=request.getParameter("PRNO").toString().trim();

			if(request.getParameter("DEPARTMENTCODE")==null)
				mDepartmentCode="";
			else
				mDepartmentCode=request.getParameter("DEPARTMENTCODE").toString().trim();

			if(request.getParameter("POCKETCODE")==null)
				mPocketCode="";
			else
				mPocketCode=request.getParameter("POCKETCODE").toString().trim();
			
			if(request.getParameter("ITEMCODE")==null)
				mItemCode="";
			else
				mItemCode=request.getParameter("ITEMCODE").toString().trim();


qry="SELECT COSTCENTRECODE,STORECODE,nvl(PRREFERENCENO,' ')PRREFERENCENO,nvl(to_char(PRREFERENCEDATE,'dd-mm-yyyy'),' ')PRREFERENCEDATE,SITECODE, ";
qry=qry+" LOCATIONCODE,nvl(REMARKS,' ')REMARKS from PRMASTER where companycode='"+mCompanyCode+"' and  ";
qry=qry+" PRNO='"+mPRNO+"'  and nvl(DEACTIVE,'N')='N' ";
//qry=qry+" and DEPARTMENTCODE='"+mDepartmentCode+"' ";
rs=db.getRowset(qry);
if(rs.next())
{				

	mCCc=rs.getString("COSTCENTRECODE");
	mSc=rs.getString("STORECODE");
	mPrn=rs.getString("PRREFERENCENO");
	mPrd=rs.getString("PRREFERENCEDATE");
	mSitc=rs.getString("SITECODE");
	mLc=rs.getString("LOCATIONCODE");
	mRe=rs.getString("REMARKS");


	qryc="select costcentrename from costcentremaster where costcentrecode='"+mCCc+"' and nvl(DEACTIVE,'N')='N' ";
	rsc=db.getRowset(qryc);
	rsc.next();
	

	qrys="select storedescription from storemaster where storecode='"+mSc+"' and nvl(DEACTIVE,'N')='N' ";
	rss=db.getRowset(qrys);
	rss.next();

	qrysi="select sitename from sitemaster where sitecode='"+mSitc+"' and nvl(DEACTIVE,'N')='N' ";
	rssi=db.getRowset(qrysi);
	rssi.next();

	qryl="select locationname from locationmaster where locationcode='"+mLc+"' and nvl(DEACTIVE,'N')='N' ";
	rsl=db.getRowset(qryl);
	rsl.next();

	qryp="select pocketdescription from pocketmaster where pocketcode='"+mPocketCode+"' and nvl(DEACTIVE,'N')='N' ";
	rsp=db.getRowset(qryp);
	rsp.next();

	qryi="SELECT nvl(MAKE,' ')MAKE,nvl(DETAILDESCRIPTION,' ')DETAILDESCRIPTION,nvl(UOM,' ')UOM,"; 
	qryi=qryi+" nvl(REQUESTEDQTY,0)REQUESTEDQTY,nvl(REMARKS,' ')REMARKS,NVL(to_char(REQUIREDDATE,'dd-mm-yyyy'),' ')REQUIREDDATE ";
	qryi=qryi+"FROM PRDETAIL where companycode='"+mCompanyCode+"' and PRNO='"+mPRNO+"' and ITEMCODE='"+mItemCode+"' and ";
	qryi=qryi+" POCKETCODE='"+mPocketCode+"' and nvl(DEACTIVE,'N')='N' ";
	rsi=db.getRowset(qryi);
	rsi.next();
%>
<TABLE bgcolor=#fce9c5  class="sort-table"  width=98% ALIGN=CENTER rules=COLUMNS CELLSPACING=0 BORDER=1> 
<tr>
<td><b>PRNO.</B>&nbsp; <%=mPRNO%></td>
<td><b>Cost Center</B>&nbsp;<%=rsc.getString("costcentrename")%></td> 
<td><b>Store</B>&nbsp;<%=rss.getString("storedescription")%></td>
</tr>
<tr>
<td>
<b>PR Ref No</B>&nbsp;<%=mPrn%></td>
<td><b>PR Ref Date</B>&nbsp;<%=mPrd%></td>
<td><b>Site</B>&nbsp;<%=rssi.getString("sitename")%> 
</td> 
</tr>
<tr>
<td><b>Location</B>&nbsp; <%=rsl.getString("locationname")%></td>
<td><b>Item Code</B>&nbsp;<%=mItemCode%> </td>
<td><b>Pocket Code</B>&nbsp;<%=rsp.getString("pocketdescription")%></td>

</tr>
<tr>
<td colspan=3><B>Remarks</b>&nbsp;<%=mRe%></td>

</tr>
<tr>
<td>
<b>Make</B>&nbsp; <%=rsi.getString("MAKE")%>
</td><td>
<b>Qty Required</b>&nbsp;<%=rsi.getDouble("REQUESTEDQTY")%>&nbsp; &nbsp;
<b>A/U</b>&nbsp;<%=rsi.getString("UOM")%></td>
<td>
<b>Req. Date</b>&nbsp;<%=rsi.getString("REQUIREDDATE")%></td>
</tr>	
<tr>
<td colspan=3>
<b>Remarks</b>&nbsp;<%=rsi.getString("REMARKS")%>
</td>
</tr>
<tr>
<td colspan=3>
<b>Detail Desc.</b>&nbsp;<%=rsi.getString("DETAILDESCRIPTION")%>
</td>
</tr>
</table>
<%
}// closing of if
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

