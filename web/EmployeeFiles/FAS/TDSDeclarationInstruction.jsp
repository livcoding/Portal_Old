<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";

%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Tax Decleration Form/Screen] </TITLE>




<script type="text/javascript" src="js/sortabletable.js"></script>
	<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
	<script language="JavaScript" type ="text/javascript" src="../PersonalInfo/js/datetimepicker.js"></script>
<script>
	if(window.history.forward(1) != null)
	window.history.forward(1);
</script>

<script language=javascript>
<!--
	function RefreshContents()
	{ 	
    	document.frm.x.value='ddd';
    	document.frm.submit();
	}
//-->
</SCRIPT>

</head>

<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="",mFinYear="";
String mDMemberCode="",mDDMemberType="",mDept="",mDesg="",mInst="",minst="",mDMemberID="";
String mExam="",mexam="",mFacltyID="",mSubj="",msubj="";
String qry="",qry1="",qry2="",qry3="",x="",qrymEventsubevent="",mTDSCode="E";
int msno=0;
double mvalue=0,mMaxmarks=0,MyMax=0,mchkmarks=0;
String mmvalue="";
String mEdCode="",qrymEdCode="",mCatCode="";
int ctr=0;
String mIC="",mEC="",mSC="",mList="",mOrder="",mFaculty=""; 
ResultSet rsSub =null,rs=null,rss=null,rs1=null,rs2=null,rs3=null,rsfac=null,rse=null,rsm=null,rsi=null,rstable=null,rsTableData=null,rsTime=null;
String mMOP="",mName5="",mlistorder="",qrymCatCode="";		

int kk=0,sno=0;	
String msubeven="",mMarks="",mPerc="",mName1="",mMark="",mName2="",mName3="",mName4="",mName8="";
String mName6="",mName7="";		
String mFacltyID1="",mSubj1="",qrymFinYear="",finyear="",msubj1="";
String mType="";
int mRights=0;
String SubQry="",mySub="";
String mDMemberType="I",mCOMPASSESSMENT="";
String mComp="",mAssesmentYear="",mTDSDesc="",mFinancialYear="",mFINANCIALYEAR1="";			
String mSave="0",mEDTYPE="";			
String mAssYear="",qrymAssYear="";
		String mDeclAmt="",mActAmt="",SectionCode="";
	double mTotalSalary=0,mRecvDeclAmount=0;
	double mTaxAmount=0,mPaidTaxAmount=0,mTotalIncome=0;

  String mStatus="",mFreeze="",mTextReadonly="";


if (session.getAttribute("Designation")==null)
{
	mDesg="";
}
else
{
	mDesg=session.getAttribute("Designation").toString().trim();
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

if (session.getAttribute("DepartmentCode")==null)
{
	mDept="";
}
else
{
	mDept=session.getAttribute("DepartmentCode").toString().trim();
}

	if (request.getParameter("Type")==null)
{
	mType = "";
}
else
{
	mType = request.getParameter("Type").toString().trim();
}


if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}


if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}


OLTEncryption enc=new OLTEncryption();
if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
  {
	mDMemberCode=enc.decode(mMemberCode);
	mDDMemberType=enc.decode(mMemberType);
	mDMemberID=enc.decode(mMemberID);		
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk1=null;
	ResultSet r=null;

	
	// ------------------------------
	// out.print(qry);
	// ------------------------------
      // -- Enable Security Page Level  
      // ------------------------------

	if(mType.equals("D"))
	{
	   mRights=166;
	}
	else if(mType.equals("H"))
	{
	   mRights=167; 	
	}
	else 
		//if(mType.equals("I"))
	{
	   mRights=168;
	}



	qry="Select WEBKIOSK.ShowLink('"+mRights+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";	
      RsChk1= db.getRowset(qry);
	
	//out.print(qry);

	if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
	{
try
{
%><br>
<br><br>
<br>
	
	

<TABLE valign=top align=center rules=GROUPS bordercolor=maroon  cellSpacing=1 cellPadding=1 width="100%" border=1 >
<thead>
<tr bgcolor="#ff8c00"><td colspan=6 align=center ><Font face='arial' size=4 color='white'><b>Tax Declaration Instructions</b></font>
    </td>
	</tr>
</thead>	
<%
		

String mSysdate="",mDateFrom="",mDateTo="",mFYear="",Panno="",mFREEZE="",mTimeOver="",mDaysLeft="";	
		
		qry="SELECT to_char(FROMPERIOD,'dd-mm-yyyy')FROMPERIOD, to_char(TOPERIOD,'dd-mm-yyyy')TOPERIOD, NVL(STATUS,'N')STATUS ,NVL(ASSESSMENTYEAR,' ')ASSESSMENTYEAR , NVL(FINYEAR,' ')FINYEAR	,nvl(TDSCODE,' ')TDSCODE  ,(TOPERIOD-trunc(sysdate+1))DAYCOUNT	FROM TDS#PARAMETER where COMPANYCODE='"+mComp+"' and trunc(SYSDATE) >= trunc(fromperiod)  and  trunc(SYSDATE) <= trunc(toperiod) ";
		//out.print(qry);
rs=db.getRowset(qry);
if(rs.next())
		{
		mDateFrom=rs.getString("FROMPERIOD");
		mDateTo=rs.getString("TOPERIOD");
		mStatus=rs.getString("STATUS");
		mAssYear=rs.getString("ASSESSMENTYEAR");
		mFYear=rs.getString("FINYEAR");
		mTDSCode=rs.getString("TDSCODE");
		mDaysLeft=rs.getString("DAYCOUNT");

		}

qry1="select 'Y' from tds#parameter where trunc(SYSDATE) >= trunc(fromperiod)  and  trunc(SYSDATE) <= trunc(toperiod) and COMPANYCODE='"+mComp+"'  ";
rs1=db.getRowset(qry1);
if(!rs1.next())
	mTimeOver="Y";
else
	mTimeOver="N";

String mFinYear1= "20"+mFYear.substring(0,2)+"-20"+mFYear.substring(2,4);
//out.print(mFinYear1+"fsf");

 qry1="select nvl(FREEZE,'N')FREEZE  from TDS#EDIDECLARATIONHEADER where  COMPANYCODE='"+mComp+"' and  TDSCODE='"+mTDSCode+"' and ASSESSMENTYEAR='"+mAssYear+"' and EMPLOYEEID='"+mDMemberID+"' ";
rs1=db.getRowset(qry1);
if(rs1.next())
{
	mFREEZE=rs1.getString("FREEZE");
}
else
	{
		mFREEZE="X";
	}
%><br>


	<tr><td><font face=arial size=2><br>
		<UL>
			<LI>Declaration of Financial Year <b><u><%=mFinYear1%></u></b> Assessment Year <b><u><%=mAssYear%></u></b>
			<LI>Submission Date From <b><u><%=mDateFrom%></u></b>  to <b><u><%=mDateTo%></u></b>  .
			<LI>Fill up the investment details as per the form attached and take the print-out duly signed should be submitted to account department.
			<li>If you have any queries  please contact Accounts Department.
		</UL>
		</font>

	</td></tr>

<tr><td><font face=arial color=red size=2><marquee  behavior=alternate  scrolldelay=200 ><b>
		<UL>
		<%
		if(mFREEZE.equals("X"))
		{
		%>
			<LI>You have not submitted your investment details for income-tax.Only <%=mDaysLeft%> days left	
			<%
		}
		else if(mFREEZE.equals("N"))
		{
			%>
			<LI>Please submit your investment detail and take a print-out for submission
				Only <%=mDaysLeft%> days left
				<%
		}
	
		if(mTimeOver.equals("Y"))
		{	
				%>
		
			<LI>Sorry you have missed submission of investment declaration.  Please contact  
				Accounts department for the same.
				<%
		}
				%>

		</UL>
		</marquee>
		</font>
</td></tr>

</table>


<br>	
<TABLE valign=top align=center rules=GROUPS bordercolor=maroon cellSpacing=1 cellPadding=1 width="100%" border=1 >
<thead>
<tr bgcolor="#ff8c00"><td colspan=6 align=center >
<a href="TDSDeclaration.jsp" title="Click to Enter TDS Deatails ">
		<font face=arial size=4 color=white ><b>Declaration Form/Investment Form
		</font></a>
    </td>
	</tr>
</thead>	
	</table>
		
	
<%
}
catch(Exception e)
		{
		out.print(e+"sdfsdf");
		}
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
%>
</body>
</html>
