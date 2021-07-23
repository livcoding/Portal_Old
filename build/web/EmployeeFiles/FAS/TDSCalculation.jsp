<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null,rsi=null,rs1=null,rs2=null;
GlobalFunctions gb =new GlobalFunctions();
OLTEncryption enc=new OLTEncryption();
String qry="",qry2="";
String mComp="";
String mEmployeeName="",mEmployeeCode="",mDepartment="";
String mMemberID="", mDMemberID="",mIndentDate="",mDesignation="";
String mMemberType="", mDMemberType="", mMemberCode="", mDMemberCode="";
String mMemberName="", mDept="", mDegs="",mDesignation1="";
String mtext="",mCurrDate="";
String mDepartment1="",mFinYear="";
String mYMDate="",STATUS="",mEDCODE="",mEmpCode="";
double mTotal=0,REBATEONTAX=0,mEarningTotal=0,mPay=0;
double mDeductionTotal=0,mdTotal=0;


double ADDITIONALCHARGES=0,TOTALINCOME=0,TOTALREBATE=0,TOTALTAX=0,TAXABLEFROMPREVINCOME=0,TOTALEARNING=0;
double REFUNDTAX=0,PARAMETERVALUE=0,TAXDEDUCTED=0,TAXDEDUCTEDINPREVCOMPANY=0,OTHERINCOME=0,PERQUISITEAMOUNT=0;


qry="select to_Char(Sysdate,'dd-mm-yyyy') date1  from dual";
rs=db.getRowset(qry);
rs.next();
mCurrDate=rs.getString("date1");
if (session.getAttribute("CompanyCode")==null)
	mComp="UNIV";
else
	mComp=session.getAttribute("CompanyCode").toString().trim();

if (session.getAttribute("MemberID")==null)
	mMemberID="";
else
	mMemberID=session.getAttribute("MemberID").toString().trim();

if (session.getAttribute("MemberType")==null)
	mMemberType="";
else
	mMemberType=session.getAttribute("MemberType").toString().trim();

if (session.getAttribute("MemberName")==null)
	mMemberName="";
else
	mMemberName=session.getAttribute("MemberName").toString().trim();

if (session.getAttribute("MemberCode")==null)
	mMemberCode="";
else
	mMemberCode=session.getAttribute("MemberCode").toString().trim();

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [TDS Calculation Sheet ] </TITLE>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css"/>
<script language=javascript>
<!--
function RefreshContents()
{ 	
	document.frm.x.value='ddd';
	document.frm.submit();
}
//-->
if(window.history.forward(1) != null)
window.history.forward(1);	
</script>
<STYLE>input {font-size:13px;}</STYLE>
</HEAD>
</head>
<body aLink="#ff00ff" bgcolor="#fce9c5" leftmargin="0" topmargin="0">
<%
try
{
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{	
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
		qry="Select WEBKIOSK.ShowLink('168','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
			%>
			<form name="frm"  method="post">
			<input id="x" name="x" type="hidden">
			<center>
			<table align=center width="100%" bottommargin=0 topmargin=0>
			<tr>
			<TD colspan=0 align=middle class=pageheading> <font  color="#a52a2a"  face=verdana size=4> <b><U>TDS Calculation Sheet </U></b> </font> </td>
			</tr>
			</table>
			</center>
			<%
			try
			{
				qry="select distinct nvl(A.EMPLOYEENAME,' ')EMPLOYEENAME,B.DEPARTMENT DEPARTMENT,C.DESIGNATION DESIGNATION,a.employeecode employeecode from EMPLOYEEMASTER A,DEPARTMENTMASTER B, DESIGNATIONMASTER C where A.employeeid='"+mChkMemID+"' and A.DEPARTMENTCODE=B.DEPARTMENTCODE and A.DESIGNATIONCODE=C.DESIGNATIONCODE and nvl(A.DEACTIVE,'N')='N' and nvl(B.DEACTIVE,'N')='N' and nvl(C.DEACTIVE,'N')='N' ";
				//out.println(qry);
				rs=db.getRowset(qry);
				if(rs.next())
				{
					mEmployeeName=rs.getString("EMPLOYEENAME");					
					mDepartment1=rs.getString("DEPARTMENT");
					mDesignation1=rs.getString("DESIGNATION");
					mEmpCode=rs.getString("employeecode");
				}
			}
			catch(Exception e)
			{
			}
			%>			
			<center>			
			<table align=center cellpadding="0" cellspacing="0" border="0" rules="groups" width=100%>
			<tr>
				<td colspan=8 align=center>&nbsp;&nbsp;	<b><FONT face=Arial size=2>Name  <font color="#00008b" face=times new roman size=2><b>&nbsp;<%=mEmployeeName%>-<%=mEmpCode%> </b></font>
				<b><FONT face=Arial size=2>&nbsp;&nbsp;Designation </font> </B>
				<font color="#00008b" face=times new roman><b> &nbsp;<%=GlobalFunctions.toTtitleCase(mDesignation1)%> </b></font>
				<b><FONT face=Arial size=2>&nbsp; Department </font></B><font color="#00008b" face=times new roman><b>&nbsp;&nbsp;<%=GlobalFunctions.toTtitleCase(mDepartment1)%></b></font><hr>
				</td>
			</tr>							
			</table>
			</center>
			<center>
			<table cellpadding="3" cellspacing="0" border=1 rules="groups">
			<tr>
			<td><font face="arial" size=2><b> Financial Year </b></font>
			<%
			//qry="select to_char(to_Date(YEARMONTH,'yyyymm'),'MON-YYYY')YEARMONTH, to_char(to_Date(YEARMONTH,'yyyymm'),'yyyymm')YEARMONTH1 ";
			//qry=qry+" From salary where COMPANYCODE='"+mComp+"' and EMPLOYEEID='"+mChkMemID+"' ORDER BY YEARMONTH1 desc ";
			qry="Select distinct  FINYEAR From TDS#DRAFTEDSUMMRY Where Type<>'R' AND EMPLOYEEID='"+mChkMemID+"' and COMPANYCODE='"+mComp+"'   ";
			//out.print(qry);
			rs=db.getRowset(qry);
			%>
			&nbsp;&nbsp;<select name="FINYEAR" id="FINYEAR">
			<%
			if(request.getParameter("x")==null)
			{
				while(rs.next())
				{
					//if(mFinYear.equals(""))
				//	{
						mFinYear=rs.getString("FINYEAR");
				//	}
					%>
					<option value=<%=rs.getString("FINYEAR")%>><%=rs.getString("FINYEAR")%></option>	
					<%
				}						
			}
			else
			{						
				while(rs.next())
				{
					if(request.getParameter("FINYEAR").equals(rs.getString("FINYEAR")))
					{
						%>
						<option value=<%=rs.getString("FINYEAR")%> selected><%=rs.getString("FINYEAR")%></option>	
						<%
					}
					else
					{
						%>
						<option value=<%=rs.getString("FINYEAR")%>><%=rs.getString("FINYEAR")%></option>	
						<%
					}
				}
			}
			%>
			</select>
			</TD>			
			<TD align="center"><input type="submit" name="show" value="Show" style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 60px; HEIGHT: 20px; FONT-VARIANT: normal; cursor:hand; background-color:transparent; border-width:1; border-color:black;"></TD>
			</TR>
			</table>
			</center>
			<%
			if(request.getParameter("x")!=null)
			{
				if(request.getParameter("FINYEAR")==null)
					mFinYear="";
				else
					mFinYear=request.getParameter("FINYEAR");
			
		

double BASICPAY=0;
		
			qry="Select a.EMPLOYEEID,nvl(PERQUISITEAMOUNT,0)PERQUISITEAMOUNT,nvl(OTHERINCOME,0)OTHERINCOME,nvl(TAXDEDUCTEDINPREVCOMPANY,0)TAXDEDUCTEDINPREVCOMPANY,nvl(TAXDEDUCTED,0)TAXDEDUCTED,nvl(a.PARAMETERVALUE,0)PARAMETERVALUE,nvl(REFUNDTAX ,0)REFUNDTAX ,nvl(TAXABLEFROMPREVINCOME,0)TAXABLEFROMPREVINCOME,TOTALTAX,nvl(REBATEONTAX,'')REBATEONTAX,EMPLOYEENAME,BASICPAY,b.EmployeeCode,Decode(a.STATUS,'D','Projected','F','Finalized') STATUS ,a.TOTALREBATE,a.TOTALEARNING,a.TOTALINCOME,a.ADDITIONALCHARGES From TDS#DRAFTTAXABLEDETAIL a,EMPLOYEEMASTER b where a.EMPLOYEEID=b.EMPLOYEEID And a.EMPLOYEEID='"+mChkMemID+"' And a.COMPANYCODE='"+mComp+"'  And a.FINYEAR='"+mFinYear+"' Order by EMPLOYEENAME";
			rs1=db.getRowset(qry);
			//out.print(qry);

			if(rs1.next())
			{
			   BASICPAY=rs1.getDouble("BASICPAY");
				PERQUISITEAMOUNT=rs1.getDouble("PERQUISITEAMOUNT");
				 OTHERINCOME=rs1.getDouble("OTHERINCOME");
				  TAXDEDUCTEDINPREVCOMPANY=rs1.getDouble("TAXDEDUCTEDINPREVCOMPANY");
				   //TAXDEDUCTED=rs1.getDouble("TAXDEDUCTED");
					PARAMETERVALUE=rs1.getDouble("PARAMETERVALUE");
					 REFUNDTAX=rs1.getDouble("REFUNDTAX");
					  TAXABLEFROMPREVINCOME=rs1.getDouble("TAXABLEFROMPREVINCOME");
					   TOTALTAX=rs1.getDouble("TOTALTAX");
					    REBATEONTAX=rs1.getDouble("REBATEONTAX");
						STATUS=rs1.getString("STATUS");
						 TOTALREBATE=rs1.getDouble("TOTALREBATE");
						  TOTALEARNING=rs1.getDouble("TOTALEARNING");
						   TOTALINCOME=rs1.getDouble("TOTALINCOME");
							ADDITIONALCHARGES=rs1.getDouble("ADDITIONALCHARGES");

			}

		String TDStomonth="",TDSfrommonth="",qry1="";
				
		qry1=" Select To_Char(TDSFROMMONTH,'YYYYMM')TDSFROMMONTH,To_Char(TDSTOMONTH,'YYYYMM') TDSTOMONTH    From TDS#ASSESSMENTYEAR b    Where FINANCIALYEARCODE='"+mFinYear+"' And b.COMPANYCODE ='"+mComp+"' ";
		rs1=db.getRowset(qry1);
		if(rs1.next())
			{
			TDSfrommonth=rs1.getString("TDSFROMMONTH");
			TDStomonth=rs1.getString("TDSTOMONTH");
			}


	qry="  Select Sum(a.EDAMOUNT) TAXDEDUCTED    From PayableSalary a    Where a.CompanyCode='"+mComp+"'	And a.EMPLOYEEID= '"+mChkMemID+"'    And YEARMONTH Between '"+TDSfrommonth+"' And '"+TDStomonth+"'     And EDID IN (Select EDID From TDS#EDDETAIL c    Where NVL(TDSFLAG,'N')='Y'    And COMPANYCODE ='"+mComp+"'    And FINYEAR='"+mFinYear+"'     And c.COMPANYCODE= a.COMPANYCODE) ";
//	out.print(qry);
	rs=db.getRowset(qry);
	if(rs.next())
		TAXDEDUCTED=rs.getDouble("TAXDEDUCTED");

			%>	
			<br>
			<table cellspacing=0 cellpadding=0 border=1 align=center rules=groups  width="65%">
			
			<tr>
			<td align=center>
			<FONT size=2 face=Arial color=black> Current Basic Pay : <%=BASICPAY%>
			&nbsp; &nbsp; &nbsp; &nbsp;
			<FONT size=2 face=Arial color=black>Status : <%=STATUS%>
			</td>
			</tr>
			
			<tr><br>
			<td align=left	 nowrap>
			
			
<table  align="left" border=0 cellSpacing=0 cellPadding=0 width="70%">

		<tr>
		<td  valign=top>
			<FONT size=2 face=Arial color=black>
			a) <U>Earnings</U></FONT>   
		</td>
		<td align=right  >

			<table  class="sort-table" id="table-1"  border=1 cellSpacing=0 cellPadding=0 ><thead>
			<tr align=middle bgcolor="#ff8c00">
				<td><P><STRONG><FONT color=white face=Arial>Head</FONT></STRONG></P></td>
				<td><STRONG><FONT color=white face=Arial>Regular Amount </FONT></STRONG> </td>
				<td><STRONG><FONT color=white face=Arial>Arrear Amount </FONT></STRONG> </td>
				<td><FONT color=white face=Arial><STRONG>Total Paid</STRONG></FONT></td>
			</tr></thead>
			<%
			qry="Select EMPLOYEEID,EDCODE,EDAMOUNT,ARREARAMOUNT,RECOVERYAMOUNT,EDID From TDS#DRAFTEDSUMMRY Where Type<>'R' AND EMPLOYEEID='"+mChkMemID+"'  and COMPANYCODE='"+mComp+"'  AND FINYEAR='"+mFinYear+"' and TYPEOFINCOME<>'O'  ";
		//	out.print(qry);
			rs=db.getRowset(qry);
	
			while(rs.next())
			{
				mTotal=0;
				mTotal=mTotal+(rs.getDouble("EDAMOUNT")+rs.getDouble("ARREARAMOUNT"));
				mEarningTotal+=mTotal;
				%>
				<tr>
					<td nowrap align="left"><%=rs.getString("EDCODE")%></td>
					<td noWrap align="right"><%=rs.getDouble("EDAMOUNT")%></td>
					<td noWrap align="right"><%=rs.getDouble("ARREARAMOUNT")%></td>
					<td noWrap align="right"><%=mTotal%></td>   
				</tr>
				<%
			}					
			%>


			<tr>
			<td colspan=4 align=right>
				<FONT size=2 face=Arial color=navy><b>
			Total Amount (Rs.) :</b></font>&nbsp;<b><FONT size=2 face=Arial><%=mEarningTotal%></font></b>
			</td>
			</tr>
			</table>
			
		</td>
		</tr>
		
<tr>
<td>
			<FONT size=2 face=Arial color=black>b) <U>Perquisite</U></FONT> 
</td>
<td align=right>
<%=PERQUISITEAMOUNT%>
</td>
</tr>

<tr>
<td valign=top>
			<FONT size=2 face=Arial color=black>c) <U>As Per 12BA</U></FONT> 
</td>
<td align=right>



<table  class="sort-table" id="table-1" align="center" border=1 cellSpacing=0 cellPadding=0 ><thead>
			<tr align=middle bgcolor="#ff8c00">
				<td><P><STRONG><FONT color=white face=Arial>Head</FONT></STRONG></P></td>
				<td><STRONG><FONT color=white face=Arial> Amount</FONT></STRONG> </td>
				<td><STRONG><FONT color=white face=Arial>Exemption<br>Amount</FONT></STRONG> </td>
				<td><FONT color=white face=Arial><STRONG>After<br>Rebate</STRONG></FONT></td>
			</tr></thead>
			
			<%
double mAfterRebate=0,sum=0,mRedAmount=0,mExAmount=0;

		qry="Select edcode redcode, edamount redamount, yearlyexemption ryearlyexemption From TDS#DRAFTEDSUMMRY Where  EMPLOYEEID='"+mChkMemID+"'  and COMPANYCODE='"+mComp+"'  AND FINYEAR='"+mFinYear+"'  and  parametercode IS NOT NULL AND TYPE = 'R' ";
			//out.print(qry);
			rs=db.getRowset(qry);
			while(rs.next())
			{
				
				
				
				mRedAmount=rs.getDouble("redamount");
				mExAmount=rs.getDouble("ryearlyexemption");

				if(mRedAmount<mExAmount)
				{
					//mExAmount=0;
					mAfterRebate=0 ;
				}
				else
				{
					//mExAmount=rs.getDouble("ryearlyexemption");
					mAfterRebate=mRedAmount - mExAmount;
				}

				
				
				%>
				<tr>
				<td><%=rs.getString("redcode")%>  </td>
				
				<td><%=mRedAmount%>  </td>
				
				
				<td><%=mExAmount%>   </td>
				
				<td><%=mAfterRebate%>   </td>

				</tr>
				<%
					sum=sum+mAfterRebate;
			}
			%>
				<tr>
			<td colspan=4 align=right>
				<FONT size=2 face=Arial color=navy><b>
			Total Amount (Rs.) :</b></font>&nbsp;<b><FONT size=2 face=Arial><%=sum%></font></b>
			</td>
			</tr>

				</table>

<br>
</td>
</tr>



<tr>
<td>
			<FONT size=2 face=Arial color=black>d) <U>Other Income (If any)</U></FONT> 
</td>
<td align=right>
<%=OTHERINCOME%>
</td>
</tr>


<tr>
<td nowrap>
			<FONT size=2 face=Arial color=black>e) <U>Taxable income from Previous Income (if any)</U></FONT> 
</td>
<td align=right>
<%=TAXABLEFROMPREVINCOME%>
</td>
</tr>


<tr>
<td>
			<FONT size=2 face=Arial color=black>f)&nbsp; <U>Total Income</U></FONT> 
</td>
<td align=right>
<%=TOTALINCOME%>
</td>
</tr>


<tr>
<td colspan=2 align=center>
<FONT size=2 face=Arial color=black>-----------------Exemption--------------------
</td>
</tr>

<tr>
<td valign=top>
		<FONT size=2 face=Arial color=black>g) <U>Total Exemption</U></FONT> 
</td>
<td align=right >

<table  class="sort-table" id="table-1" align="center" border=1 cellSpacing=0 cellPadding=0 ><thead>
			<tr align=middle bgcolor="#ff8c00">
				<td><P><STRONG><FONT color=white face=Arial>Section</FONT></STRONG></P></td>
				<td><STRONG><FONT color=white face=Arial> Total Saving  </FONT></STRONG> </td>
				<td><STRONG><FONT color=white face=Arial>Limit</FONT></STRONG> </td>
				<td><FONT color=white face=Arial><STRONG>Rebate</STRONG></FONT></td>
			</tr></thead>

<%
String SECTION="";
int sno=0;
qry="Select SECTIONCODE,nvl(TOTALSAVING,0)TOTALSAVING,nvl(TOTALMAXLIMIT,0)TOTALMAXLIMIT,nvl(MAXIMUMLIMIT,0)MAXIMUMLIMIT,EMPLOYEEID From TDS#DRAFTSECTIONMASTER Where COMPANYCODE='"+mComp+"' And EMPLOYEEID='"+mChkMemID+"' And FINYEAR='"+mFinYear+"' order by sectioncode";
//out.print(qry);
rs1=db.getRowset(qry);
while(rs1.next())
			{
			%>
			   <tr>
				<td><%=rs1.getString("SECTIONCODE")%>  </td>
				<td><%=rs1.getString("TOTALSAVING")%>  </td>
				<td><%=rs1.getString("TOTALMAXLIMIT")%>   </td>
				<td><%=rs1.getString("MAXIMUMLIMIT")%>   </td>
			 
				<%
				qry1="Select distinct SECTIONCODE,AMOUNT,EDITYPE,EDICODE From TDS#DRAFTSECTIONDETAIL a  Where a.COMPANYCODE='"+mComp+"'   And a.EMPLOYEEID='"+mChkMemID+"' And SECTIONCODE='"+rs1.getString("SECTIONCODE")+"' And a.FINYEAR='"+mFinYear+"'  order by  EDICODE";
				//out.print(qry1);
				rs=db.getRowset(qry1);
				while(rs.next())
				{
					sno++;

					if(!SECTION.equals(rs.getString("SECTIONCODE")))
					{
					%>
					<tr>
					<td>&nbsp; &nbsp; </td>
					<td> &nbsp; &nbsp; </td>
					<td><b><U>Investment </U></b> </td>
					<td><b><U>Amount</U> </b> </td>

					</tr>
					
					<%
						SECTION=rs.getString("SECTIONCODE");
					}
					


					if(rs.getString("EDITYPE").equals("E"))
					{
						qry2="SELECT EDCODE FROM EDMASTER WHERE COMPANYCODE='"+mComp+"' and  EDID= '"+rs.getString("EDICODE")+"' ";
						rs2=db.getRowset(qry2);

						if(rs2.next())
							mEDCODE=rs2.getString("EDCODE");
					}

					else
					{
						mEDCODE=rs.getString("EDICODE");
					}

					%>
					<tr>
					<td>&nbsp; &nbsp;
					</td>
					<td> &nbsp;&nbsp;
					</td>
					<td> <%=mEDCODE%>
					</td>

					<td>	 <%=rs.getString("AMOUNT")%>
					</td>
					</tr>
					<%
				}


					%>
			 </tr>
	
			<%
			}


	%>

</td>

<tr>

<td colspan=4 align=right>


<FONT size=2 face=Arial color=navy><b>
			Total Rebate (Rs.) :</b></font>&nbsp;<b><FONT size=2 face=Arial><%=TOTALREBATE%></font></b>
</td>

</tr>

</table>


<br>
<tr>
<td>
			<FONT size=2 face=Arial color=black>h) <U>Income After Exemption(f-g)</U></FONT> 
</td>
<td align=right>
<%=(TOTALINCOME)-(TOTALREBATE)%>
</td>
</tr>

<tr>
<td colspan=2 align=center>
<FONT size=2 face=Arial color=black>-----------------Tax Detail--------------------
</td>
</tr>

<tr>
<td>
			<FONT size=2 face=Arial color=black>i) &nbsp;<U>Tax On Total Income</U></FONT> 
</td>
<td align=right>
<%=TOTALTAX%>
</td>
</tr>

<tr>
<td>
			<FONT size=2 face=Arial color=black>j) &nbsp;<U>Rebate u/s 87</U></FONT> 
</td>
<td align=right>
<%=REBATEONTAX%>
</td>
</tr>


<tr>
<td>
			<FONT size=2 face=Arial color=black>k) &nbsp;<U>Other Charges On Tax(if any)</U></FONT> 
</td>
<td align=right>
<%=ADDITIONALCHARGES%>
</td>
</tr>


<tr>
<td>
			<FONT size=2 face=Arial color=black>l) <U>Payble Tax(i+k -j)</U></FONT> 
</td>
<td align=right>
<%=((TOTALTAX)+(ADDITIONALCHARGES)-(REBATEONTAX))%>
</td>
</tr>
	
			

<tr>
<td colspan=2 align=center>
<FONT size=2 face=Arial color=black>-----------------Tax Deducted--------------------
</td>
</tr>


<tr>
<td>
			<FONT size=2 face=Arial color=black>m) &nbsp; <U>Tax Deducted In Previous Company(if any)</U></FONT> 
</td>
<td align=right>
<%=TAXDEDUCTEDINPREVCOMPANY%>
</td>
</tr>



<tr>
<td>
			<FONT size=2 face=Arial color=black>n) <U>Tax Deducted In Salary </U></FONT> 
</td>
<td align=right>
<%=TAXDEDUCTED%>
</td>
</tr>


<tr>
<td>
			<FONT size=2 face=Arial color=black>o) &nbsp;<U>Total Tax Deducted (m+n)</U></FONT> 
</td>
<td align=right>
<%=((TAXDEDUCTED)+(TAXDEDUCTEDINPREVCOMPANY))%>

</td>
</tr>


<tr>
<td>
			<FONT size=2 face=Arial color=black>p)&nbsp;<U> Balance Tax (l-o) </U></FONT> 
</td>
<td align=right>
<%=((TOTALTAX)+(ADDITIONALCHARGES)-(REBATEONTAX)) - ((TAXDEDUCTED)+(TAXDEDUCTEDINPREVCOMPANY))%>
</td>
</tr>


<tr>
<td>
			<FONT size=2 face=Arial color=black>q) &nbsp;<U>Refund Tax (if any)</U></FONT> 
</td>
<td align=right>
<%=REFUNDTAX%>
</td>
</tr>



	<style type="text/css">
				@media print 
				{
				input#btnPrint 
				{
					display: none;
				}
				}
				</style>
		
		<tr>
		<td align="center" colspan=2><br>
			<input type="button" name='submit'  id="btnPrint"  onClick='window.print()' value='Click To Print'>
		</td>
		</tr>



</td>
<tr>
<table>
			<%

		}

		}
		else
		{
			%>
				<br>
				<font color=red>
				<h3><br><img src='../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
				<P>	This page is not authorized/available for you.
				<br>For assistance, contact your network support team. 
				</font>	<br>	<br>	<br>	<br> 
			<%
		}
		//-----------------------------
	}
	else
	{
		out.print("<br><img src='images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}
}
catch(Exception e)
{	
	/*out.print("Exception e"+e);	*/
}
%>
</form>
</body>
</html>