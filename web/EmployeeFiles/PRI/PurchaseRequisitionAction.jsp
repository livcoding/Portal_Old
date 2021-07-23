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
String mFl="";
String mCostCentre="",mStore="",mPrrefno="",mPrrefdate="";
String mSite="",mLocation="",mRemarks="",mItemCategory="" ;
String mMajorHead1="",mItemHead1="",mItemSubHead1="",mItemCode1="";
String mPartRefMake="",mPartMake="",mItemType1="",mQtyReq="";
String mAU="",mReqDate="",mRemarks1="",mDetailDesc="";
String mDepartmentCode="",mCompanyCode="";

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

			String qryd="",mDate="";
			ResultSet rsd=null;

			qryd="select to_char(sysdate,'dd-mm-yyyy') from dual ";
			rsd=db.getRowset(qryd);
			rsd.next();
			mDate=rsd.getString(1);




	int  flag=0;
	int  flag1=0;

		if(request.getParameter("NewPR")==null)
			mNewPR="N";
		else
			mNewPR=request.getParameter("NewPR").toString().trim();

	if(mNewPR.equals("NPR"))
	{
		

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

		if(request.getParameter("Prrefdate")==null || request.getParameter("Prrefdate").equals(""))
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

		} // closing of if NPR(new PR)
		else
		{
			if(request.getParameter("PRNO")==null)
				mPRNO="";
			else
				mPRNO=request.getParameter("PRNO").toString().trim();
		}
		

		if(request.getParameter("ItemCategory")==null)
			mItemCategory="";
		else
			mItemCategory=request.getParameter("ItemCategory").toString().trim();

		if(request.getParameter("MajorHead")==null)
			mMajorHead1="";
		else
			mMajorHead1=request.getParameter("MajorHead").toString().trim();

		if(request.getParameter("ItemHead")==null)
			mItemHead1="";
		else
			mItemHead1=request.getParameter("ItemHead").toString().trim();

		if(request.getParameter("ItemSubHead")==null)
			mItemSubHead1="";
		else
			mItemSubHead1=request.getParameter("ItemSubHead").toString().trim();

		if(request.getParameter("ItemCode")==null)
			mItemCode1="";
		else
			mItemCode1=request.getParameter("ItemCode").toString().trim();

		if(request.getParameter("PartRefMake")==null)
			mPartRefMake="";
		else
			mPartRefMake=request.getParameter("PartRefMake").toString().trim();

		if(request.getParameter("PartMake")==null)
			mPartMake="";
		else
			mPartMake=request.getParameter("PartMake").toString().trim();

		if(request.getParameter("ItemType")==null)
			mItemType1="";
		else
			mItemType1=request.getParameter("ItemType").toString().trim();

		if(request.getParameter("QtyReq")==null)
			mQtyReq="";
		else
			mQtyReq=request.getParameter("QtyReq").toString().trim();

		if(request.getParameter("AU")==null)
			mAU="";
		else
			mAU=request.getParameter("AU").toString().trim();

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
			mDetailDesc=request.getParameter("DetailDesc").toString().trim();
/*
	if(mPartRefMake.equals(""))
		mPartMake1=mPartMake;
	else
		mPartMake1=mPartRefMake;
*/

if(mNewPR.equals("NPR"))
{
if(!mAU.equals("") && !mQtyReq.equals("") && !mMajorHead1.equals("") && !mMajorHead1.equals("NONE") & !mItemHead1.equals("") && !mItemHead1.equals("NONE") && !mMajorHead1.equals("") && !mItemSubHead1.equals("NONE") && !mItemCode1.equals("") && !mItemCode1.equals("NONE"))
{
 if(flag!=0 && flag1!=0)
 {	

//if(request.getParameter("SAVE").toString().trim().equals("Save/Refresh"))
//{
	try
	{
	co = new DBConn();
	con = co.DBConOpen();
	st = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	con.setAutoCommit(false);

mPRNO=db.GeneratePRNO(mCompanyCode,mDate);
%>
<input type=hidden name=PRNO id=PRNO value="<%=mPRNO%>">
<%
//session.setAttribute("SESSIONPRNO",mPRNO);

qry=" INSERT INTO PRMASTER(COMPANYCODE,PRNO,PRDATE,COSTCENTRECODE,STORECODE,LOCATIONCODE, ";
qry=qry+" SITECODE,PRREFERENCENO,PRREFERENCEDATE,REMARKS, ";
qry=qry+" ENTRYBY,ENTRYDATE, DOCMODE,PRSTATUS, DEPARTMENTCODE)VALUES ( ";
qry=qry+" '"+mCompanyCode+"' ,'"+mPRNO+"' ,sysdate,'"+mCostCentre+"' ,'"+mStore+"' ,'"+mLocation+"',";
qry=qry+" '"+mSite+"','"+mPrrefno+"' ,to_date('"+mPrrefdate+"','dd-mm-yyyy') ,'"+mRemarks+"' ,'"+mChkMemID+"' , ";
qry=qry+" sysdate,'D' ,'P','"+mDepartmentCode+"') ";
st.addBatch(qry);

qry1="INSERT INTO PRDETAIL(COMPANYCODE,PRNO,ITEMCODE,POCKETCODE,PRDATE,MAKE,DETAILDESCRIPTION, ";
qry1=qry1+" UOM, REQUESTEDQTY,REMARKS,REQUIREDDATE,APPROVEDQTY,ENTRYBY,ENTRYDATE) ";
qry1=qry1+" VALUES('"+mCompanyCode+"','"+mPRNO+"','"+mItemCode1+"','"+mItemType1+"',sysdate,";
qry1=qry1+" '"+mPartMake+"' ,'"+mDetailDesc+"','"+mAU+"' ,'"+mQtyReq+"','"+mRemarks1+"', ";
qry1=qry1+" to_date('"+mReqDate+"','dd-mm-yyyy'),'"+mQtyReq+"','"+mChkMemID+"',sysdate ) ";
st.addBatch(qry1);
int updateCounts[] = st.executeBatch();
if(updateCounts.length>0)
 {
	mFl="N";
	con.commit();
	con.close();
	co.DBConClose();
  response.sendRedirect("PurchaseRequisition.jsp?FLAG=N"+"&PRNO="+mPRNO);
 }
	}
	catch(Exception e)
	{
		con.close();
		co.DBConClose();
	}
}// closing of flag
else
	{
		out.println("<center><font face=arial size=2 color=red><b>Invalid date.....</b></font></center>");
		out.println("<center><font face=arial size=2 color=red><b>Valid date format is 'DD-MM-YYYY'.....</b></font></center>");
	}

} // closing of if mandatory items check
else
{
out.print("<font color=red><b>Please select the mandatory items</b>");
}
%>
<TABLE bgcolor=#fce9c5 class="sort-table"  width=98% ALIGN=CENTER rules=COLUMNS CELLSPACING=0 BORDER=1> 
	<thead>
	<tr bgcolor="#ff8c00">
		<TD ALIGN=CENTER><font color=white><b>Sno.<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>PRNO.<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>ItemCode<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>ItemDescription<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Make<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Req.Qty(UOM)<B><font></TD>
	</tr>
	</thead>
<%
qry=" select distinct A.PRNO,A.ItemCode,B.itemdescription,nvl(A.make,' ')make,A.UOM,A.REQUESTEDQTY from PRDETAIL A,itemcatalogue B ";
qry=qry+" where A.PRNO in (select Prno from PRMASTER where prno='"+mPRNO+"' and  departmentcode='"+mDepartmentCode+"') and A.itemcode=B.itemCode ";
qry=qry+" and nvl(A.DEACTIVE,'N')='N' AND NVL(B.DEACTIVE,'N')='N' order by A.PRNO,A.ITemcode";
rs=db.getRowset(qry);
int ctr=0;
	while(rs.next())
	{	
		ctr++;
	%>
		<tr>		
			<td><%=ctr%></td>
			<td>&nbsp;<%=rs.getString("PRNO")%></td>
			<td>&nbsp;<%=rs.getString("ItemCode")%></td>
			<td NOWRAP>&nbsp;<%=rs.getString("itemdescription")%></td>
			<td NOWRAP>&nbsp;<%=rs.getString("make")%></td>
			<td>&nbsp;<%=rs.getString("REQUESTEDQTY")%>&nbsp;<%=rs.getString("UOM")%></td>
				
		</tr>
	<%
	}// closing of while


} // closing of NPR
else
{
	
	if(!mAU.equals("") && !mQtyReq.equals("") && !mMajorHead1.equals("") && !mMajorHead1.equals("NONE") & !mItemHead1.equals("") && !mItemHead1.equals("NONE") && !mMajorHead1.equals("") && !mItemSubHead1.equals("NONE") && !mItemCode1.equals("") && !mItemCode1.equals("NONE"))
	{
if(flag1!=0)
{
String qryd11="";
ResultSet rsd11=null;


qryd11="select POCKETCODE from PRDETAIL where COMPANYCODE='"+mCompanyCode+"' and PRNO='"+mPRNO+"' and nvl(DEACTIVE,'N')='N' ";
//qryd11=qryd11+" ITEMCODE='"+mItemCode1+"'   ";
rsd11=db.getRowset(qryd11);
rsd11.next();
//out.print(qryd11);
qryd1="select 'y',POCKETCODE from PRDETAIL where COMPANYCODE='"+mCompanyCode+"' and PRNO='"+mPRNO+"' and ";
qryd1=qryd1+" ITEMCODE='"+mItemCode1+"'  and nvl(DEACTIVE,'N')='N' ";
rsd1=db.getRowset(qryd1);
if(!rsd1.next())
{
	/*
	qry1="INSERT INTO PRDETAIL(COMPANYCODE,PRNO,ITEMCODE,POCKETCODE,PRDATE,MAKE,DETAILDESCRIPTION, ";
	qry1=qry1+" UOM, REQUESTEDQTY,REMARKS,REQUIREDDATE,APPROVEDQTY,ENTRYBY,ENTRYDATE) ";
	qry1=qry1+" VALUES('"+mCompanyCode+"','"+mPRNO+"','"+mItemCode1+"','"+mItemType1+"',sysdate,";
	qry1=qry1+" '"+mPartMake+"' ,'"+mDetailDesc+"','"+mAU+"' ,'"+mQtyReq+"','"+mRemarks1+"', ";
	qry1=qry1+" to_date('"+mReqDate+"','dd-mm-yyyy'),'"+mQtyReq+"','"+mChkMemID+"',sysdate ) ";
	*/
	qry1="INSERT INTO PRDETAIL(COMPANYCODE,PRNO,ITEMCODE,POCKETCODE,PRDATE,MAKE,DETAILDESCRIPTION, ";
	qry1=qry1+" UOM, REQUESTEDQTY,REMARKS,REQUIREDDATE,APPROVEDQTY,ENTRYBY,ENTRYDATE) ";
	qry1=qry1+" VALUES('"+mCompanyCode+"','"+mPRNO+"','"+mItemCode1+"','"+rsd11.getString("POCKETCODE")+"',sysdate,";
	qry1=qry1+" '"+mPartMake+"' ,'"+mDetailDesc+"','"+mAU+"' ,'"+mQtyReq+"','"+mRemarks1+"', ";
	qry1=qry1+" to_date('"+mReqDate+"','dd-mm-yyyy'),'"+mQtyReq+"','"+mChkMemID+"',sysdate ) ";

	int a=db.insertRow(qry1);
mFl="O";
response.sendRedirect("PurchaseRequisition.jsp?FLAG=O"+"&PRNO="+mPRNO);	

} // closing of if(!rsd.next()) 
else
{
	mFl="O";
	response.sendRedirect("PurchaseRequisition.jsp?FLAG=O"+"&PRNO="+mPRNO);	
}
}// closing of flag
else
	{
		out.println("<center><font face=arial size=2 color=red><b>Invalid date.....</b></font></center>");
		out.println("<center><font face=arial size=2 color=red><b>Valid date format is 'DD-MM-YYYY'.....</b></font></center>");
	}

}
else
{
out.print("<font color=red><b>Please select the mandatory items</b>");
out.print("<br><br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<a href=PurchaseRequisition.jsp><b>BACK</b></a><br>");
}
%>
<br>
<TABLE bgcolor=#fce9c5 class="sort-table"  width=98% ALIGN=CENTER rules=COLUMNS CELLSPACING=0 BORDER=1> 
	<thead>
	<tr bgcolor="#ff8c00">
		<TD ALIGN=CENTER><font color=white><b>Sno.<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>PRNO.<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>ItemCode<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>ItemDescription<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Make<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Req.Qty(UOM)<B><font></TD>
	</tr>
	</thead>
<%
qry=" select distinct A.PRNO,A.ItemCode,B.itemdescription,nvl(A.make,' ')make,A.UOM,A.REQUESTEDQTY from PRDETAIL A,itemcatalogue B ";
qry=qry+" where A.PRNO in (select Prno from PRMASTER where prno='"+mPRNO+"' and departmentcode='"+mDepartmentCode+"') and A.itemcode=B.itemCode ";
qry=qry+"  AND nvl(A.DEACTIVE,'N')='N' AND NVL(B.DEACTIVE,'N')='N' order by A.PRNO,A.ITemcode";
rs=db.getRowset(qry);
int ctr=0;
	while(rs.next())
	{	
		ctr++;
	%>
		<tr>		
			<td><%=ctr%></td>
			<td>&nbsp;<%=rs.getString("PRNO")%></td>
			<td>&nbsp;<%=rs.getString("ItemCode")%></td>
			<td NOWRAP>&nbsp;<%=rs.getString("itemdescription")%></td>
			<td NOWRAP>&nbsp;<%=rs.getString("make")%></td>
			<td>&nbsp;<%=rs.getString("REQUESTEDQTY")%>&nbsp;<%=rs.getString("UOM")%></td>
				
		</tr>
	<%
	}// closing of while

	
} // closing of else
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