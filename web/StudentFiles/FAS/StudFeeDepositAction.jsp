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
 
<script language=javascript>

	function RefreshContents()
	{ 	
    	    document.frm.x.value='ddd';
    	    document.frm.submit();
	}

	function Validate()
	{
		if(document.frm1.TotalAmount.value=="" || document.frm1.TotalAmount.value==null)
		{
			alert("Please Enter the Fee Amount");
			frm1.TotalAmount.focus();
			return false;
		}

	}

</script>
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
String mInstituteCode="",mHostel="";
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
			<font size=4 face=arial color=#a52a2a><b>Pay Fee </b> </font>
			</td></tr>
			
			</table>


<TABLE cellpadding=2 WIDTH="80%" cellspacing=0 bordercolor=maroon align=center RULES=NONE border=1>
			<tr><td  align=left colspan=4>
			<font size=3 face=arial color=#a52a2a><u><b>Student Details : </b></u> </font>
			</td></tr>
			<tr> 
			 <td > <FONT face=Verdana size=2 color=darkmaroon><STRONG>Name  (Enrolment No.) </STRONG></FONT></td>
			 <td nowrap colspan=2> <FONT face=verdana size=2><B>: <%=mmMemberName%>(<%=mDMemberCode%>)</b></FONT>&nbsp;&nbsp; </FONT></td>
			 </TR>

			<tr><td>
			<FONT face=Verdana size=2 color=darkmaroon><STRONG>Academic Year  </STRONG><font color=black><b>:  <%=mAcadYear%></b></font></FONT>
			</td>
			<td>
			<FONT face=Verdana size=2 color=darkmaroon><STRONG>Program </STRONG><font color=black><b>: <%=mProCode%></b></font></FONT>
			</td>
			<td>
			<FONT face=Verdana size=2 color=darkmaroon><STRONG>Branch  </STRONG><font color=black><b>: <%=mBranCode%></b></font></FONT>
			</td></tr>
			<tr><td>
			<FONT face=Verdana size=2 color=darkmaroon><STRONG>Quota </STRONG><font color=black><b>: <%=mQuota%></b></font></FONT>
			</td><td>
			<FONT face=Verdana size=2 color=darkmaroon><STRONG>Current Sem  </STRONG><font color=black><b>: <%=mSem%></b></font></FONT>
			</td><td>
			<FONT face=Verdana size=2 color=darkmaroon><STRONG>Sem Type  </STRONG><font color=black><b>: <%=mSemType%></b></font></FONT>
			</td>

			<TR><td nowrap colspan=3> 
			<font size=2 face=verdana  color=darkmaroon><b>Make Fee Payment against Registration Code </b>
		
			<font size=2 face=verdana color=black  ><B>: <%=mRegCode%></b></FONT>
			</td> </tr> 
			</table>
			
				<input type=hidden name="academicyear" id="academicyear" value="<%=mAcadYear%>">
				<input type=hidden name="programcode" id="programcode" value="<%=mProCode%>">
				<input type=hidden name="branchcode" id="branchcode" value="<%=mBranCode%>">
				<input type=hidden name="semester" id="semester" value="<%=mSem%>">
				<input type=hidden name="STUDENTID" id="STUDENTID" value="<%=mStudID%>">
				<input type=hidden name="RegCode" id="RegCode" value="<%=mRegCode%>">
		

		<br>
			


			<TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=3 width="90%" border=1 >
			<thead>
			<tr bgcolor="#ff8c00">
		
			<td><b><font color="white" size=2><b>Fee Head Description</b></font></td>
			<td><b><font color="white" size=2><b>Fee Currency</font></b></td>
			<td><b><font color="white" size=2><b>Academic Year</font></b></td>
			<td><b><font color="white" size=2><b>Program</font></b></td>
			<td><b><font color="white" size=2><b>Branch</font></b></td>
			<td><b><font color="white" size=2><b> Fee Source</font></b></td>
			<td><b><font color="white" size=2><b>	Fee Amount</font></b></td>
		
			</tr>
			</thead>
			<tbody> 
			<tr bgcolor=white>
		<%

		qry="select B.COLLSEQID, NVL (a.feehead, ' ') feehead, NVL (b.feeheaddesc, ' ') feeheaddesc,       NVL (a.academicyear, ' ') academicyear,       NVL (a.programcode, ' ') programcode,       NVL (a.branchcode, ' ') branchcode, a.feeamount feeamount,       'Individual' feeSource,       NVL (c.currencydesc, ' ') currencydesc from feestructureindividual a, feeheads b, currencymaster c WHERE a.institutecode = '"+mInstituteCode+"'   AND a.currencycode = c.currencycode   AND a.institutecode = b.institutecode   AND a.feehead = b.feehead   AND a.companycode = '"+mCompanyCode+"'    AND a.academicyear = '"+mAcadYear+"'     AND a.programcode = '"+mProCode+"'   AND a.branchcode = '"+mBranCode+"'   AND a.semestertype = '"+mSemType+"'   AND a.semester = '"+mSem+"'    and a.STUDENTID='"+mStudID+"'   AND NVL (a.deactive, 'N') = 'N'   and NVL (b.deactive, 'N') = 'N'		 ANd (b.Feetype in (select Feetype From feeheads where 'Y' = '"+mHostel+"')     Or b.Feetype not in (select Feetype From feeheads where 'N' ='"+mHostel+"' ANd Feetype = 'H'))		union		SELECT B.COLLSEQID,nvl(a.feehead,' ')feehead  ,nvl(b.feeheaddesc,' ')feeheaddesc,nvl(a.Academicyear,' ')Academicyear,nvl(a.programcode,' ')programcode,nvl(a.branchcode,' ')branchcode,a.feeamount feeamount ,'Academic Year Wise' feeSource,nvl(c.CURRENCYDESC,' ')CURRENCYDESC    FROM feestructure a, feeheads b,CURRENCYMASTER c WHERE a.institutecode ='"+mInstituteCode+"' and a.CURRENCYCODE=c.CURRENCYCODE and a.INSTITUTECODE=b.INSTITUTECODE and a.FEEHEAD=b.FEEHEAD   AND a.companycode =  '"+mCompanyCode+"'   AND a.academicyear = '"+mAcadYear+"'   AND a.programcode = '"+mProCode+"'    AND a.branchcode = '"+mBranCode+"'   AND a.QUOTA = '"+mQuota+"'   AND a.semestertype = '"+mSemType+"'     and a.Semester='"+mSem+"'   AND NVL (a.deactive, 'N') = 'N'		 ANd (b.Feetype in (select Feetype From feeheads where 'Y' = '"+mHostel+"')     Or b.Feetype not in (select Feetype From feeheads where 'N' ='"+mHostel+"' ANd Feetype = 'H')) and NVL (b.deactive, 'N') = 'N' ORDER BY 1";		
	//out.print(qry);	
		rs=db.getRowset(qry);
		while(rs.next())
		{
			Total=Total+rs.getDouble("feeamount");

			%>
				<tr bgcolor=white >
			
				<td nowrap><font size=2 face=arial><b><%=rs.getString("feeheaddesc")%></b></font></td>
				<td nowrap><font size=2 face=arial><b><%=rs.getString("CURRENCYDESC")%></b></font></td>
				<td><font size=2 face=arial><b><%=rs.getString("Academicyear")%></b></font></td>
				<td><font size=2 face=arial><b><%=rs.getString("programcode")%></b></font></td>
				<td><font size=2 face=arial><b><%=rs.getString("branchcode")%></b></font></td>
				<td nowrap><font size=2 face=arial><b><%=rs.getString("FEESOURCE")%></b></font></td>
				<td align=right><font size=2 face=arial><b>INR <%=rs.getDouble("feeamount")%></b></font></td>
				
				</tr>
			<%
					
		}
		%>
		 <td colspan=7 align=right valign=top>
			&nbsp;&nbsp;&nbsp;	 
		 <font size=2 color=blue face=arial><b>Total Fees to be Paid :&nbsp;   &nbsp;INR <%=Total%> </b></font>		<br>
			<font size=2 color=blue face=arial><b>Total Amount : 
			<INPUT TYPE="text" NAME="TotalAmount"  id="TotalAmount" size=9 style="TEXT-ALIGN:right;" >
		 </td>
		  <tr>
		  <td colspan=7 align=right valign=top>
			<INPUT TYPE="submit" Value="Pay Fees" onclick="return Validate();">
			</td>
			</tr>
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
	<td valign=middle><br><br>
	<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">	<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br><FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>
	</td>
</tr>
</table>
</body>
</html>
