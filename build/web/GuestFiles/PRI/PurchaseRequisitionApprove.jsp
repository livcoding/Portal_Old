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
String mName1="";

Connection con = null;
Statement st = null;
DBConn co = null;


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

if(document.frm1.Prrefdate.value.length>1)
{
for (i=0; i<document.frm1.Prrefdate.value.length; i++) 
{ 

	  Char = document.frm1.Prrefdate.value.charAt(i); 
      if (ValidChars.indexOf(Char) == -1) 
      {
			alert('Please Enter the valid date format in PR Ref. date field i.e DD-MM-YYYY.'); 
			document.frm1.Prrefdate.value="";
			frm1.Prrefdate.focus();
			return false;
        }
 } // closing of for
} // closing of if 
 } // closing of IsNumeric
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
	<form name="frm"  method="post" >
	<input id="x" name="x" type=hidden>
<table align=center bottommargin=0 width=100% cellspacing=0 cellpadding=0 topmargin=0 border=0 >
<tr>
<td align=center>
<b>Approve Purchase Requisition</b>
</td>
</tr>
</table>
<br>
	<table align=center bottommargin=0 cellspacing=0 cellpadding=2 topmargin=0 border=1 rule=rows width="50%">
	<tr>
<%
	String mNewPR1="";
%>
	<td align=center> 
	<b>PRNO.</B> &nbsp;
	<select name="PRNO" id="PRNO" style="WIDTH: 110px"> 
	<%
		qry="select distinct prno from prmaster where nvl(DEACTIVE,'N')='N' and nvl(DOCMODE,'N')='F' order by 1 ";
		rs=db.getRowset(qry);
		if (request.getParameter("x")==null) 
		{
			while(rs.next())
			{
				Mprno=rs.getString("prno");
		%>
			<option value=<%=Mprno%>><%=rs.getString("prno")%></option>
		<%	
			}
		}
			else
			{
				while(rs.next())
				{	
					Mprno=rs.getString("prno");
					if(Mprno.equals(request.getParameter("PRNO")))
					{
					%>
						<option selected value=<%=Mprno%>><%=rs.getString("prno")%></option>
					<%
					}
					else
					{

					%>
						<option value=<%=Mprno%>><%=rs.getString("prno")%></option>
					<%
					}
				}
			} // closing of else
		%>
		</select>&nbsp;
		<input type=submit value="Show/Refresh">
		</td>
		</tr>
		</table>
		</form>
	<%
		if(request.getParameter("x")!=null)
		{
			
			if(request.getParameter("PRNO")==null)
				mPRNO="";
			else
				mPRNO=request.getParameter("PRNO").toString().trim();

String mCCc="",mSc="",mPrn="",mPrd="",mSitc="",mLc="",mRe="";

qry="SELECT COSTCENTRECODE,STORECODE,nvl(PRREFERENCENO,' ')PRREFERENCENO,nvl(to_char(PRREFERENCEDATE,'dd-mm-yyyy'),' ')PRREFERENCEDATE,SITECODE, ";
qry=qry+" LOCATIONCODE,nvl(REMARKS,' ')REMARKS from PRMASTER where companycode='"+mCompanyCode+"' and  ";
qry=qry+" PRNO='"+mPRNO+"' and nvl(DOCMODE,'N')='F' and nvl(DEACTIVE,'N')='N' ";
qry=qry+" and DEPARTMENTCODE='"+mDepartmentCode+"' ";
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
%>
	<form name="frm1"  method="post" action="PurchaseRequisitionApproveEdit.jsp">
	<input id="y" name="y" type=hidden>
	<table align=center bottommargin=0 cellspacing=0 cellpadding=2 topmargin=0 border=1 rules=rows width="98%">
	<tr>
	<td>
		<b>Cost Center</B> 
	 <select name="CostCentre" id="CostCentre" style="WIDTH: 120px">
	 <%
			qry="select distinct costcentrecode,costcentrename from costcentremaster where nvl(DEACTIVE,'N')='N' order by costcentrename ";
			rs=db.getRowset(qry);
		if (request.getParameter("x")==null) 
		{
			while(rs.next())
			{
				mCentreCode=rs.getString("costcentrecode");
				if(mCCc.equals(mCentreCode))
				{
				%>
					<option selected value=<%=mCentreCode%>><%=rs.getString("costcentrename")%></option>
				<%	
				} // closing of if
				else
				{
					%>
					<option  value=<%=mCentreCode%>><%=rs.getString("costcentrename")%></option>
				<%	
				} // closing of else
				} // closing of while
			}
			else
			{
				while(rs.next())
				{	
					mCentreCode=rs.getString("costcentrecode");
					if(mCCc.equals(mCentreCode))
					{
					//if(mCentreCode.equals(request.getParameter("CostCentre")))
				//	{
					%>
						<option selected value=<%=mCentreCode%>><%=rs.getString("costcentrename")%></option>
					<%
					}
					else
					{
					%>
						<option value=<%=mCentreCode%>><%=rs.getString("costcentrename")%></option>
					<%
					}
				}
			} // closing of else
		%>
		</select>
		</td>
		<td>
		  <b>Store</B> 
		<select name="Store" id="Store" style="WIDTH: 140px">
		  <%
			qry="select distinct storecode,storedescription from storemaster where nvl(DEACTIVE,'N')='N' order by 2  ";
			rs=db.getRowset(qry);
			if (request.getParameter("x")==null) 
			{
				while(rs.next())
				{
					mStoreCode=rs.getString("storecode");
					if(mSc.equals(mStoreCode))
					{
				%>
					<option selected value=<%=mStoreCode%>><%=rs.getString("storedescription")%></option>
				<%	
					} 
					else
					{
				%>
					<option value=<%=mStoreCode%>><%=rs.getString("storedescription")%></option>
				<%	
					}
				} // closing of while 
			}
			else
			{
				while(rs.next())
				{	
					mStoreCode=rs.getString("storecode");
					if(mSc.equals(mStoreCode))
				//  if(mStoreCode.equals(request.getParameter("Store")))
					{
					%>
						<option selected value=<%=mStoreCode%>><%=rs.getString("storedescription")%></option>
					<%
					}
					else
					{
					%>
						<option value=<%=mStoreCode%>><%=rs.getString("storedescription")%></option>
					<%
					}
				}
			} // closing of else
		%>
		</select>
	<%	
			if(mPrn.equals(""))// || mPrn==null)
				mPrn="";
			else
				mPrn=mPrn;
	%>
</td>
<td>
		<b>PR Ref No</B>&nbsp;<input value="<%=mPrn%>" type=text name="Prrefno" id="Prrefno" size=25>

		</td>
	</tr>
<tr>
<td>
<b>PR Ref Date</B> 
<input type=text value="<%=mPrd%>" name="Prrefdate" id="Prrefdate" size=13 maxlength=10>
</td><td>
	  <b>Site</B> &nbsp; 
		<select name="Site" id="Site" style="WIDTH: 140px">
		  <%
			qry="select distinct sitecode,sitename from sitemaster where nvl(DEACTIVE,'N')='N' order by 2";
			rs=db.getRowset(qry);
			if (request.getParameter("x")==null) 
			{
				while(rs.next())
				{
					mSiteCode=rs.getString("sitecode");
					if(mSitc.equals(mSiteCode))
					{
				%>
					<option selected value=<%=mSiteCode%>><%=rs.getString("sitename")%></option>
				<%	
					}
					else
					{
				%>
					<option value=<%=mSiteCode%>><%=rs.getString("sitename")%></option>
				<%	
					}
				} // closing of while 
			}
			else
			{
				while(rs.next())
				{	
					mSiteCode=rs.getString("sitecode");
					if(mSitc.equals(mSiteCode))
					// if(mSiteCode.equals(request.getParameter("Site")))
					{
					%>
						<option selected value=<%=mSiteCode%>><%=rs.getString("sitename")%></option>
					<%
					}
					else
					{
					%>
						<option value=<%=mSiteCode%>><%=rs.getString("sitename")%></option>
					<%
					}
				}
			} // closing of else
		%>
		</select>
		</td><td>
		&nbsp;<b>Location</B> &nbsp;&nbsp;
		<select name="Location" id="Location" style="WIDTH: 200px">
		  <%
			qry="select distinct locationcode,locationname from locationmaster where nvl(DEACTIVE,'N')='N' order by 2";
			rs=db.getRowset(qry);
			if (request.getParameter("x")==null) 
			{
				while(rs.next())
				{
					mLocationCode=rs.getString("locationcode");
					if(mLc.equals(mLocationCode))
					{
				%>
					<option selected value=<%=mLocationCode%>><%=rs.getString("locationname")%></option>
				<%	
					}
					else
					{
				%>
						<option  value=<%=mLocationCode%>><%=rs.getString("locationname")%></option>
				<%	
					}
				} // closing of while
			}
			else
			{
				while(rs.next())
				{	
					mLocationCode=rs.getString("locationcode");
					if(mLc.equals(mLocationCode))
					//if(mLocationCode.equals(request.getParameter("Location")))
					{
					%>
						<option selected value=<%=mLocationCode%>><%=rs.getString("locationname")%></option>
					<%
					}
					else
					{
					%>
						<option value=<%=mLocationCode%>><%=rs.getString("locationname")%></option>
					<%
					}
				}
			} // closing of else
		%>
		</select>
</td>
</tr>
<tr>
<td colspan=3><B>Remarks</b>
  <input type=text value="<%=mRe%>" name="Remarks" id="Remarks" size=103%>
</td>
<input type=hidden name="PRNO" value=<%=mPRNO%>>
</tr>
<tr>
<td align=center colspan=3>
  <input type=submit value=&nbsp;Save&nbsp; onclick="return IsNumeric();">
</td>
</tr>
</table>
</form>

<form name="frm2"  method="post" action="PurchaseApproveAct.jsp">
<input id="y1" name="y1" type=hidden>

<TABLE bgcolor=#fce9c5 class="sort-table"  width=98% ALIGN=CENTER rules=COLUMNS CELLSPACING=0 BORDER=1> 
	<thead>
	<tr bgcolor="#ff8c00">
		<TD ALIGN=CENTER><font color=white><b>Sno.<B><font></TD>
	<!--	<TD ALIGN=CENTER><font color=white><b>Approved<B><font></TD> -->
		<TD ALIGN=CENTER><font color=white><b>ItemCode<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>ItemDescription<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>PocketCode<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Make<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Req.Qty(UOM)<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Edit<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Delete<B><font></TD>

	</tr>
 </thead>
<%
qry=" select distinct A.PRNO,A.POCKETCODE POCKETCODE,C.POCKETDESCRIPTION ,A.ItemCode,B.itemdescription,nvl(A.make,' ')make,A.UOM,A.REQUESTEDQTY from PRDETAIL A,itemcatalogue B,POCKETMASTER C ";
qry=qry+" where A.PRNO='"+mPRNO+"' and A.itemcode=B.itemCode AND A.POCKETCODE=C.POCKETCODE ";
qry=qry+"  AND nvl(C.DEACTIVE,'N')='N' AND nvl(A.DEACTIVE,'N')='N' AND NVL(B.DEACTIVE,'N')='N' order by A.PRNO,A.ITemcode";
rs=db.getRowset(qry);
int ctr=0;
	while(rs.next())
	{	
		ctr++;
		mName1="APPROVED"+String.valueOf(ctr);
	%>
		<tr>		
			<td><%=ctr%></td>
		<!--<td align=center><input type=checkbox name=<%=mName1%> id=<%=mName1%>></td>-->
		<!--<td>&nbsp;<%=rs.getString("ItemCode")%></td>-->
<td title="click to view detail">&nbsp;<a target=_NEW href="PurchaseRequisitionApprovDetail.jsp?PRNO=<%=mPRNO%>&amp;DEPARTMENTCODE=<%=mDepartmentCode%>&amp;POCKETCODE=<%=rs.getString("POCKETCODE")%>&amp;ITEMCODE=<%=rs.getString("ItemCode")%>"><%=rs.getString("ItemCode")%></a></td>
		<td>&nbsp;<%=rs.getString("itemdescription")%></td>
			<td NOWRAP>&nbsp;<%=rs.getString("POCKETDESCRIPTION")%></td>
			<td NOWRAP>&nbsp;<%=rs.getString("make")%></td>
			<td>&nbsp;<%=rs.getString("REQUESTEDQTY")%>&nbsp;<%=rs.getString("UOM")%></td>
			<td NOWRAP><a href="EditPurchaseRequisitionAppDet.jsp?PRNO=<%=mPRNO%>&amp;ITEMCODE=<%=rs.getString("ItemCode")%>&amp;POCKETCODE=<%=rs.getString("POCKETCODE")%>&amp;COMPANYCODE=<%=mCompanyCode%>">Edit</a></td>
			<td NOWRAP><a href="PurchaseRequisitionAppDeactive.jsp?PRNO=<%=mPRNO%>&amp;ITEMCODE=<%=rs.getString("ItemCode")%>&amp;POCKETCODE=<%=rs.getString("POCKETCODE")%>&amp;COMPANYCODE=<%=mCompanyCode%>">Delete</a></td>
		</tr>
	<%
		} // closing of while
	%>	
<tr>
<td colspan=8 align=center>

<input type=radio name=Final value="C"><b>Cancel</b>
<input type=radio name=Final checked=true value="A"><b>Approve</b>&nbsp;&nbsp;

	<input type=submit value="Approve Selected PR">
</td>
</tr>
<input type=hidden name="CTR" value="<%=ctr%>">
<input type=hidden name="PRN" value="<%=mPRNO%>">
<input type=hidden name="CMP" value="<%=mCompanyCode%>">

		</table>
		</form>
	<%
} // closing of rs.next()
else
{
	out.print("<b><font color=red>Sorry No Record Found.....</font></b>");
	
}
 } // closing of if request.getParameter("x")!=null

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

