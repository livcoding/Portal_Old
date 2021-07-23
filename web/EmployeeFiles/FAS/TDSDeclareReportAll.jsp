<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.*" %>
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
<TITLE>#### <%=mHead%> [ Tax Decleration and Deduction detail] </TITLE>


<script type="text/javascript" src="js/sortabletable.js"></script>
	<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
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
<script>
	if(window.history.forward(1) != null)
		window.history.forward(1);
</script>

</head>

<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="",mFinYear="";
String mDMemberCode="",mDDMemberType="",mDept="",mDesg="",mInst="",minst="",mDMemberID="";
String mExam="",mexam="",mAssYear="",mFacltyID="",mSubj="",msubj="";
String qry="",qry1="",qry2="",qry3="",x="",qrymEventsubevent="",mTDSCode="E";
int msno=0;
double mvalue=0,mMaxmarks=0,MyMax=0,mchkmarks=0;
String mmvalue="";

int ctr=0;
String mIC="",mEC="",mSC="",mList="",mOrder="",mFaculty=""; 
ResultSet rs=null,rstable=null,rs1=null;
String mMOP="",mName5="",mlistorder="";		

int kk=0;	
String msubeven="",mMarks="",mPerc="",mName1="",mMark="",mName2="",mName3="",mName4="",mName8="";
String mName6="",mName7="";		
String mFacltyID1="",mSubj1="",qrymAssYear="",assyear="",msubj1="";
String mType="";
int mRights=0;
String SubQry="",mySub="";
String mDMemberType="I",mASSESSMENTYEAR="";
String mComp="",mAssesmentYear="";			
String mStatus="",mDOB="";				
int sno=1;

String mEDICODE="",mEDesc="",mEDesc1="";
double mBasic=0.0,mTaxableIncome=0.0,mTAXPAYABLE=0.0,mTAXDEDUCTED=0.0,mAMOUNT=0.0;
double mTAXONTOTALINCOME=0.0,mTAXINCOMEAFTERDEDUCT=0.0,mDeducted=0.0;
String mSeniorCitizen="",mYearFrom="";

		String mSysdate="",mDateFrom="",mDateTo="",mFYear="",Panno="",Gender="", mFinYear1="";
String mSrCitizen="",Gender1="",QryFaculty="",mFacultyName="";
		int mEmpAge=0,mSeniorCitizenAge=0;
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
	ResultSet r=null,rs2=null,rs11=null;
	int i=0,w=0;


/*
	qry="Select TDSCODE From TDS#TDSMASTER Where COMPANYCODE='"+mComp+"' And SLTYPE='"+mDDMemberType+"'";

	r=db.getRowset(qry);	
	if( r.next() )
	{
	   mTDSCode=r.getString("TDSCODE");
	}	*/
	// ------------------------------
	// out.print(qry);
	// ------------------------------
      // -- Enable Security Page Level  
      // ------------------------------

	   mRights=168;


	qry="Select WEBKIOSK.ShowLink('"+mRights+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";	
      RsChk1= db.getRowset(qry);
	
	//out.print(qry);

	if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
	{
   
	try{



		qry="SELECT TDSCODE,to_char(FROMPERIOD,'dd-mm-yyyy')FROMPERIOD, to_char(TOPERIOD,'dd-mm-yyyy')TOPERIOD, NVL(STATUS,'N')STATUS ,NVL(ASSESSMENTYEAR,' ')ASSESSMENTYEAR , NVL(FINYEAR,' ')FINYEAR		FROM TDS#PARAMETER where COMPANYCODE='"+mComp+"' ";
		rs=db.getRowset(qry);
		if(rs.next())
		{
			
			mAssYear=rs.getString("ASSESSMENTYEAR");
			  mTDSCode=rs.getString("TDSCODE");
			%>
		<form name="frm" method=post action="TDSDeclareReportAllNext.jsp">
			<INPUT TYPE="hidden" NAME="mTDSCode" id="mTDSCode" value="<%=mTDSCode%>">
			<Table ALIGN=CENTER BottomMargin=0  Topmargin=0>
			<tr><TD align=middle>
			<font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana"><b>Tax Declaration Report for All</b></font>
		    </td>
			</tr>
			</table>

	
				
	<table bordercolor=maroon cellpadding=1 cellspacing=1  align=center rules=groups  border=1  >
				<input id="x" name="x" type=hidden>
				
		<tr>
		<td>
		<font face=arial size=2><STRONG>
		&nbsp;Employee Name [Code]
		</STRONG></FONT>
		</td>
	
		<td>
			
			<%
	qry="select distinct nvl(employeeid,' ')Faculty, nvl(employeename,' ')FacultyName,employeecode from employeemaster where ";
	qry=qry +" companycode='"+mComp+"' and nvl(deactive,'N')='N' and employeeid in (select employeeid from TDS#EDIDECLARATIONHEADER where COMPANYCODE='"+mComp+"' and  TDSCODE='"+mTDSCode+"' and ASSESSMENTYEAR='"+mAssYear+"' and nvl(freeze,'N')='Y' ) order by FacultyName ";
	//out.print(qry);
	rs=db.getRowset(qry);
	%>
	<select name="Faculty" tabindex="0" id="Faculty"  >
	<%   	
	if(request.getParameter("x")==null)
	{	
			QryFaculty="SELECT";
		%>	
			<OPTION selected value="SELECT">--SELECT--</option>
		<%
		while(rs.next())
		{
		 	mFaculty=rs.getString("Faculty");
		 	mFacultyName=rs.getString("FacultyName");
			%>
				<option value=<%=mFaculty%>><%=mFacultyName%> [ <%=rs.getString("employeecode")%> ] </option>
			<%
			
		}
	}
	else
	{
		if (request.getParameter("Faculty").toString().trim().equals("ALL"))
 		{
			QryFaculty="SELECT";
		%>
	 		<OPTION selected value="SELECT">--SELECT--</option>
		<%
		}
		else
		{
		%>
			<OPTION value="SELECT">--SELECT--</option>
		<%
		}
	  while(rs.next())
	  {
	   	mFaculty=rs.getString("Faculty");
	   	mFacultyName=rs.getString("FacultyName");
	   	if(mFaculty.equals(request.getParameter("Faculty").toString().trim()))
			{
		   QryFaculty=mFaculty;
				%>
	    		<option selected value=<%=mFaculty%>><%=mFacultyName%> [ <%=rs.getString("employeecode")%> ]</option>
		  	<%
		  }	
	    else
      {		
	   		%>
	    		<option  value=<%=mFaculty%>><%=mFacultyName%> [ <%=rs.getString("employeecode")%> ]</option>
	   		<%
	    }	
	  }
  }
%>
</select>

		</td>
		</tr>
		
		<tr>
		<td>
		<FONT face=Arial size=2><STRONG>&nbsp;Assessment Year  
		</td>
		<td>
		<input type=text Name="mAssessYear" readonly  tabindex="0" id="mAssessYear"  Value ="<%=mAssYear%>" size=8>
		</td>
		</tr>

			<INPUT TYPE="hidden" NAME="TDSCODE" ID="TDSCODE" VALUE="<%=mTDSCode%>">


		<tr>
		<td colspan=2 align=center>
			<INPUT TYPE="submit" value="Show" >
		</td>
		</tr>
		<%


		}

			

	}
    catch(Exception e)
	{
		 out.println("Error : ");
	}

	
    

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
