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
String qrys="";
ResultSet rss=null;
ResultSet rs=null;
ResultSet rsd1=null;
String qryd1="";
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

<script language=javascript>

function RefreshContents()
{ 	
	document.frm.x.value='ddd';
    	document.frm.submit();
}
//-->
</script>
<script>

function IsNumeric()
{
   var ValidChars = "0123456789-";
   var Char;
   var Char1;
if(document.frm.ReqDate.value.length>1)
{
	for (i=0; i<document.frm.ReqDate.value.length; i++) 
	{ 
	  Char1 = document.frm.ReqDate.value.charAt(i); 
      if (ValidChars.indexOf(Char1) == -1) 
      {
			alert('Please Enter the valid date format in Required date field i.e DD-MM-YYYY.'); 
			document.frm.ReqDate.value="";
			frm.ReqDate.focus();
			return false;
        }
	 } // closing of for
} // closing of if
var ValidChars1 = "0123456789.";
var Char2;
for (i=0; i<document.frm.QtyReq.value.length; i++) 
{ 
	  Char2 = document.frm.QtyReq.value.charAt(i); 
      if (ValidChars1.indexOf(Char2) == -1) 
      {
			alert('Please Enter the numeric value only in Qty Required field.'); 
			document.frm.QtyReq.value="";
			frm.QtyReq.focus();
			return false;
        }
 } // closing of for

if(document.frm.QtyReq.value=="")
{
	alert('Please insert the quantity required value.');
	frm.QtyReq.focus();
	return false;	
}

if(document.frm.AU.value=="")
{
	alert('You can not left UOM field blank.');
	frm.AU.focus();
	return false;	
}


if(document.frm.ReqDate.value!="" && document.frm.ReqDate.value!=" ")
{
var dt=document.frm.ReqDate.value;
var dt2=document.frm.SDate.value;

	len=dt.length;
	i=dt.indexOf("-");
	dtDD=dt.substring(0,i);
	dt=dt.substring(i+1,len);
	len=dt.length;
	i=dt.indexOf("-");
	dtMM=dt.substring(0,i);
	dtYY=dt.substring(i+1,len);

	len=dt2.length;
	i=dt2.indexOf("-");
	dt2DD=dt2.substring(0,i);
	dt2=dt2.substring(i+1,len);
	len=dt2.length;
	i=dt2.indexOf("-");
	dt2MM=dt2.substring(0,i);
	dt2YY=dt2.substring(i+1,len);
	
	var date1=new Date(dtYY,dtMM-1,dtDD);
	var date2=new Date(dt2YY,dt2MM-1,dt2DD);
	
	if(dt=="" || dt2=="")
	{
		alert("Please Enter valid Date");
		return false;

	}
	else if(date2>date1)
	{

		alert(" Required Date should be greater than today date");
		return false;
	}
	else
	{
		return true;
	}
}



  }
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
			qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from InstituteMaster Where nvl(Deactive,'N')='N' ";
			rs=db.getRowset(qry);
			if (rs.next())
				mInst=rs.getString(1);
			else
				mInst="JIIT";	

			String qryd="",mDate="";
			ResultSet rsd=null;

			qryd="select to_char(sysdate,'dd-mm-yyyy') from dual ";
			rsd=db.getRowset(qryd);
			rsd.next();
			mDate=rsd.getString(1);

	  //----------------------
%>
<br>
 <table align=center width=98% bottommargin=0 cellspacing=0 cellpadding=0 topmargin=0 border=0 >
<tr>
<td align=center>
<b>Edit Purchase Requisition Detail</b>
</td>
</tr>
<td align=right>
<a href="PurchaseRequisitionApprove.jsp"><font><b>BACK</b></font><a>
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


qry="SELECT nvl(MAKE,' ')MAKE,nvl(DETAILDESCRIPTION,' ')DETAILDESCRIPTION,UOM, ";
qry=qry+" REQUESTEDQTY,APPROVEDQTY,nvl(REMARKS,' ')REMARKS,nvl(to_char(REQUIREDDATE,'dd-mm-yyyy'),' ')REQUIREDDATE ";
qry=qry+" FROM PRDETAIL where companycode='"+mCC+"' and PRNO='"+mPRNO+"' and ";
qry=qry+" itemcode='"+mIC+"' and pocketcode='"+mPC+"' and nvl(DEACTIVE,'N')='N' ";
rs=db.getRowset(qry);

if(rs.next())
{
	mMM=rs.getString("MAKE");
		mDD=rs.getString("DETAILDESCRIPTION");
			mUOMM=rs.getString("UOM");
				mRQM=rs.getDouble("REQUESTEDQTY");
					mAQM=rs.getDouble("APPROVEDQTY");
						mRM=rs.getString("REMARKS");
							mRDM=rs.getString("REQUIREDDATE");
	}
%>
<table align=center bottommargin=0 cellspacing=0 cellpadding=2 topmargin=0 border=1 rule=rows width="98%">
<tr>
<td colspan=3>
<b>Make &nbsp;</B> 
<input type=text value="<%=mMM%>" name="PartMake" id="PartMake" size=28>
&nbsp; 
	<b>Qty Required</b>&nbsp;&nbsp;
	<input type=text value="<%=mRQM%>" name="QtyReq" id="QtyReq" size=6><font color=red>*</font>
	&nbsp;<b>A/U</b>
	<input type=text readonly value="<%=mUOMM%>" name="AU" id="AU" size=5><font color=red>*</font>
	&nbsp;
	<%
		String qryd11="";
		ResultSet rsd11=null;

	qryd11=" select to_char(sysdate,'dd-mm-yyyy') from dual";
	rsd11=db.getRowset(qryd11);
	rsd11.next();

	%>
	<input type=hidden name="SDate"  value="<%=rsd11.getString(1)%>" id="SDate">
	<b>Req. Date</b>
	<input type=text name="ReqDate" value="<%=mRDM%>" id="ReqDate" size=11>
	</td>
</tr>
<tr>
<td colspan=3>
<b>Remarks</b>
<input type=text name="Remarks1" id="Remarks1" value="<%=mRM%>" size=26>
&nbsp;
<b>Detail Desc.</b>&nbsp;
<input type=text name="DetailDesc" value="<%=mDD%>" id="DetailDesc" size=59>
</td>
</tr>
<tr>
	<td align=center colspan=3>
	<input type=submit name="SAVE" value="Save/Refresh" onClick="return IsNumeric();">
	</td>
</tr>
	</table>
</form>
<%
if(request.getParameter("y")!=null)
{
	int  flag=0;
	int  flag1=0;

		

		if(request.getParameter("PartMake")==null)
			mPartMake="";
		else
			mPartMake=request.getParameter("PartMake").toString().trim();

		if(request.getParameter("QtyReq")==null)
			mQtyReq="";
		else
			mQtyReq=request.getParameter("QtyReq").toString().trim();

		if(request.getParameter("ReqDate")==null || request.getParameter("ReqDate").equals("") || request.getParameter("ReqDate").equals(" "))
		{
			mReqDate="";
			flag1=1;
		}
		else
		{
		mReqDate=request.getParameter("ReqDate").toString().trim();
			if(gb.iSValidDate(mReqDate))
			{
				flag1=1;		
			}	
			else
			{
				mReqDate="";
			}
		}
		
		if(request.getParameter("Remarks1")==null)
			mRemarks1="";
		else
			mRemarks1=GlobalFunctions.replaceSignleQuot(request.getParameter("Remarks1").toString().trim());

		if(request.getParameter("DetailDesc")==null)
			mDetailDesc="";
		else
			mDetailDesc=GlobalFunctions.replaceSignleQuot(request.getParameter("DetailDesc").toString().trim());


qry=" update PRDETAIL set PRDATE=sysdate, ";
qry=qry+" MAKE='"+mPartMake+"',DETAILDESCRIPTION='"+mDetailDesc+"',";
qry=qry+" REQUESTEDQTY='"+mQtyReq+"',REMARKS='"+mRemarks1+"',REQUIREDDATE=to_date('"+mReqDate+"','dd-mm-yyyy'), ";
qry=qry+" APPROVEDQTY='"+mQtyReq+"',ENTRYBY='"+mChkMemID+"',ENTRYDATE=sysdate where companycode='"+mCC+"' ";
qry=qry+" and PRNO='"+mPRNO+"' and itemcode='"+mIC+"' and pocketcode='"+mPC+"' and nvl(DEACTIVE,'N')='N' ";
int n=db.update(qry);
//out.print(qry);
if(n>0)
{
	response.sendRedirect("PurchaseRequisitionApprove.jsp");
}
else
{
	out.print("<font color=red><b>Error While Updating record..</b></font>");
}

 } // closing of if
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