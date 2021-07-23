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
int sno=1,mEmpAge=0,mSeniorCitizenAge=0;

String mEDICODE="",mEDesc="",mEDesc1="",mSrCitizen="";
double mBasic=0.0,mTaxableIncome=0.0,mTAXPAYABLE=0.0,mTAXDEDUCTED=0.0,mAMOUNT=0.0;
double mTAXONTOTALINCOME=0.0,mTAXINCOMEAFTERDEDUCT=0.0,mDeducted=0.0;
String mSeniorCitizen="",mYearFrom="";

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


String CADDRESS3="",CADDRESS2="",CADDRESS1="",mPan="",CCITY="",CDISTRICT="",CSTATE="",EDICODE ="",EDITYPE="",DECLARATIONAMOUNT1="",ACTUALAMOUNT1="",RecAmt="",sectionCode="";
String CPIN="",mGender="",FINANCIALYEAR1="",mDeclareDate="",SrCitizen="",mFinancialYear ="",mAssessYear ="";
String mParaDesc="",mParaValue="",mFYear="",Faculty="";

			String mDesigCode="",mEmpCode="",mEmpName="";

if(request.getParameter("mAssessYear")==null)
	mAssessYear="";
else
	mAssessYear=request.getParameter("mAssessYear");


if(request.getParameter("mTDSCode")==null)
	mTDSCode="";
else
	mTDSCode=request.getParameter("mTDSCode");


if(request.getParameter("Faculty")==null)
	Faculty="";
else
	Faculty=request.getParameter("Faculty");


qry=" select nvl(a.PANNO,' ')PANNO  , nvl(b.CADDRESS1,' ')CADDRESS1, nvl(b.CADDRESS2,' ')CADDRESS2, nvl(b.CADDRESS3,' ')CADDRESS3, nvl(b.CCITY,' ')CCITY, nvl(b.CDISTRICT,' ')CDISTRICT, nvl(b.CSTATE,' ')CSTATE,nvl(decode(b.CPIN,'0','',b.CPIN),' ')CPIN,decode(c.sex,'M','Male','F','Female',c.sex)sex,nvl(to_char(c.DateofBirth, 'dd-mm-yyyy'),'N')DOB ,nvl(c.EMPLOYEENAME,' ')EMPLOYEENAME, nvl(d.DESIGNATION,' ')DESIGNATION,nvl(c.EMPLOYEECODE,' ')EMPLOYEECODE    from employeedetail a ,employeeaddress b,employeemaster c,DESIGNATIONMASTER d  where a.EMPLOYEEID='"+Faculty+"' and c.companycode='"+mComp+"' and a.EMPLOYEEID=b.EMPLOYEEID and a.EMPLOYEEID=c.EMPLOYEEID and b.EMPLOYEEID=c.EMPLOYEEID and d.DESIGNATIONCODE=c.DESIGNATIONCODE ";
//out.print(qry);
rs=db.getRowset(qry);
 if(rs.next())
			{
			 mPan=rs.getString("PANNO");
			 CADDRESS1=rs.getString("CADDRESS1");
			 CADDRESS2=rs.getString("CADDRESS2");
			 CADDRESS3=rs.getString("CADDRESS3");
			 CCITY=rs.getString("CCITY");
			 CDISTRICT=rs.getString("CDISTRICT");
			 CSTATE=rs.getString("CSTATE");
			 CPIN=rs.getString("CPIN");
			 mGender=rs.getString("sex");
			 mDOB=rs.getString("DOB");
			mEmpName=rs.getString("EMPLOYEENAME");
			mEmpCode=rs.getString("EMPLOYEECODE");
			mDesigCode=rs.getString("DESIGNATION");
			}


	


qry="SELECT to_char(FROMPERIOD,'dd-mm-yyyy')FROMPERIOD, to_char(TOPERIOD,'dd-mm-yyyy')TOPERIOD, NVL(STATUS,'N')STATUS ,NVL(ASSESSMENTYEAR,' ')ASSESSMENTYEAR , NVL(FINYEAR,' ')FINYEAR,NVL(TDSCODE,' ')TDSCODE		FROM TDS#PARAMETER where  companycode='"+mComp+"' and ASSESSMENTYEAR ='"+mAssessYear+"' and TDSCODE='"+mTDSCode+"' ";
rs=db.getRowset(qry);
if(rs.next())
		{
		
		//mAssessYear=rs.getString("ASSESSMENTYEAR");
		mFinancialYear=rs.getString("FINYEAR");
		//mTDSCode=rs.getString("TDSCODE");

	 FINANCIALYEAR1= "20"+mFinancialYear.substring(0,2)+"-20"+mFinancialYear.substring(2,4);
		

	if(mDOB.equals("N"))
			{
				mSeniorCitizen="N";
			}
		else
			{
				qry2=" Select to_char(YearFrom,'dd-mm-yyyy')YearFrom   From   FinancialYearMaster         Where         CompanyCode    = '"+mComp+"' And FinancialYearCode ='"+mFinancialYear+"'  ";
				rs2=db.getRowset(qry2);
				if(rs2.next())
					mYearFrom=rs2.getString("YearFrom");

				
				qry1="select To_Number(SubStr((COMMON.Period(TO_DATE('"+mDOB+"' ,'DD-MM-YYYY'), TO_DATE('"+mYearFrom+"','DD-MM-YYYY'),'YYMMDD')),1,2))age  from employeemaster where employeeid='"+mChkMemID+"' ";
				//out.print(qry1);
				rs1=db.getRowset(qry1);
				if(rs1.next())
					mEmpAge=rs1.getInt("age");


				qry=" Select    nvl(SeniorCitizenAge,0)SeniorCitizenAge    From         Tds#AssessmentYear   Where     to_char(to_number(Substr(AssessmentYear,3,2))-1)||Substr(AssessmentYear,3,2) = '"+mFinancialYear+"'  And         CompanyCode     = '"+mComp+"' And RowNum  = 1";
				rs=db.getRowset(qry);
				if(rs.next())
					mSeniorCitizenAge=rs.getInt("SeniorCitizenAge");

				
					if(mEmpAge>=mSeniorCitizenAge)
						mSeniorCitizen="Y";
					else
						mSeniorCitizen="N";
				


			}







 qry1="select COMPANYCODE, TDSCODE, ASSESSMENTYEAR, EMPLOYEEID, to_char(DECLARATIONDATE,'dd-mm-yyyy')DECLARATIONDATE, FINYEAR  from TDS#EDIDECLARATIONHEADER where  COMPANYCODE='"+mComp+"' and  TDSCODE='"+mTDSCode+"' and ASSESSMENTYEAR='"+mAssessYear+"' and EMPLOYEEID='"+Faculty+"' AND NVL(FREEZE,'N')='Y' ";
rs1=db.getRowset(qry1);
if(rs1.next())
		{
			mDeclareDate=rs1.getString("DECLARATIONDATE");
	
%>

<br>
<table cellpadding=1 cellspacing=0  align=center BORDER=1 width="80%" >
		<input id="x" name="x" type=hidden>
		<tr>
		<td ALIGN=CENTER COLSPAN=2>
		<font size=3 face=arial ><b>TAX DECLARATION FORM
		</td>
		</tr>
		
		<tr>			
		
			<td><font color=black face=arial size=2><STRONG>Name of  Employee &nbsp;
			</td>
			<td>
			<font color=black face=arial size=2><STRONG><%=mEmpName%> 
			
			</strong></font>
			</td>
		
		</tr>
<tr><td >
<font color=black face=arial size=2><STRONG>Employee Code </strong>
</font>
</td>
<td >
<font color=black face=arial size=2><STRONG> <%=mEmpCode%>
</font>
</td>
</tr>

<tr><td >
<font color=black face=arial size=2><STRONG>
Designation</strong>
</font>
</td>
<td >
<font color=black face=arial size=2><STRONG> <%=mDesigCode%>
</font>
</td>
</tr>

<tr><td >
<font color=black face=arial size=2><STRONG>Pan No. </strong>
</td>
<td>
<font color=black face=arial size=2><STRONG> <%=mPan%>&nbsp;    </strong></font>
</font>
</td></tr>

<tr><td >
<font color=black face=arial size=2><STRONG>Financial Year </strong>
</td>
<td>
<font color=black face=arial size=2><STRONG>  <%=FINANCIALYEAR1%>   </strong></font>
</font>
</td></tr>

<tr><td >
<font color=black face=arial size=2><STRONG>Date of Declaration </strong>
</td>
<td>
<font color=black face=arial size=2><STRONG>  <%=mDeclareDate%>   </strong></font>
</font>
</td></tr>

<tr><td >
<font color=black face=arial size=2><STRONG>Sr Citizen</strong>
</td>
<%
if(mSeniorCitizen.equals("Y"))
		mSrCitizen="YES";
	else
		mSrCitizen="NO";

		%>

<td>
<font color=black face=arial size=2><STRONG>   <%=mSrCitizen%> &nbsp;   </strong></font>
</font>
</td></tr>


<tr><td >
<font color=black face=arial size=2><STRONG>Male / Female</strong>
</td>
<td>
<font color=black face=arial size=2><STRONG>  <%=mGender%>   </strong></font>
</font>
</td></tr>

</table>
<br>


<table cellpadding=0 cellspacing=0 border=1 align=center  rules=groups   width="80%">

<tr>
<td><font face=arial size=3><b>SNo  &nbsp; Proposed Tax Saving Investment/Payments 
</font>
</td>
<td><font face=arial size=3><b>
Amount
</td>
</tr>
<tr><td colspan=3><hr></td></tr>

<%

	qry2="SELECT  nvl(a.PARAMETERVALUE,' ')PARAMETERVALUE,nvl(b.PARAMETERDESC,' ')PARAMETERDESC FROM TDS#DECLARATIONPARADETAIL a,TDS#EDIDECLARATIONPARA b WHERE a.COMPANYCODE='"+mComp+"' AND a.TDSCODE='"+mTDSCode+"' AND a.ASSESSMENTYEAR='"+mAssessYear+"' AND  a.employeeid='"+Faculty+"' and a.COMPANYCODE=b.COMPANYCODE and a.TDSCODE=b.TDSCODE and a.ASSESSMENTYEAR=b.ASSESSMENTYEAR and a.EDITYPE=b.EDITYPE and a.EDICODE=b.EDICODE and a.PARAMETERID=b.PARAMETERID    ";
	//out.print(qry2);
		rs2=db.getRowset(qry2);
		if(rs2.next())
			{
			mParaValue=rs2.getString("PARAMETERVALUE").toString().trim();
			mParaDesc=rs2.getString("PARAMETERDESC").toString().trim();
			}


//913201021449  

qry="SELECT distinct a.COMPANYCODE, a.TDSCODE, a.ASSESSMENTYEAR,    a.EMPLOYEEID, a.EDITYPE, a.CATEGORYCODE,    a.EDICODE, nvl(decode(a.DECLARATIONAMOUNT,'0',' ',a.DECLARATIONAMOUNT),' ')DECLARATIONAMOUNT, a.FINYEAR,    a.ACTUALRECEIVED, nvl(a.FINAL,' ')FINAL,    nvl(decode(a.actualamount,'0',' ',a.actualamount),' ')actualamount, a.EXEMPTEDAMOUNT,b.SECTIONCODE,b.SECTIONDESC,b.DECLARATIONSEQID,c.SEQUENCEID FROM TDS#EDIDECLARATIONDETAIL a,TDS#SECTIONMASTER b, TDS#TDSSECTIONTAGGING c where a.companycode =  '"+mComp+"'     AND a.tdscode =  '"+mTDSCode+"'        AND a.finyear = '"+mFinancialYear+"'     and a.EMPLOYEEID='"+Faculty+"'     and a.ASSESSMENTYEAR='"+mAssessYear+"'      and a.EDITYPE=c.EDITYPE     and  a.EDICODE=c.EDICODE     and a.COMPANYCODE=c.COMPANYCODE     and a.FINYEAR=c.FINYEAR     and a.TDSCODE=c.TDSCODE     and a.COMPANYCODE=b.COMPANYCODE     and a.TDSCODE=b.TDSCODE     and b.COMPANYCODE=c.COMPANYCODE     and b.TDSCODE=c.TDSCODE     and b.SECTIONCODE=c.SECTIONCODE order by b.DECLARATIONSEQID,c.SEQUENCEID ";



//out.print(qry);
rs=db.getRowset(qry);

while(rs.next())
		{


		 EDICODE  =rs.getString("EDICODE").toString().trim();
		EDITYPE=rs.getString("EDITYPE").toString().trim();

		DECLARATIONAMOUNT1=rs.getString("DECLARATIONAMOUNT");
		ACTUALAMOUNT1=rs.getString("actualamount");

		if(mStatus.equals("F"))
			RecAmt=ACTUALAMOUNT1;
		else
			RecAmt=DECLARATIONAMOUNT1;
					

		if(!sectionCode.equals(rs.getString("SECTIONCODE").toString().trim()))
			{
				ctr++;
				%>
				<tr><td colspan=2><font color=black face=arial size=2>
				<strong><%=ctr%>.&nbsp;&nbsp;
				
				<U><%=rs.getString("SECTIONDESC").toString().trim()%></u>
				</strong></font>
				<br></td>
				</tr>

				<%
				sectionCode=rs.getString("SECTIONCODE").toString().trim();
			}
			
		


		if(EDITYPE.equals("I"))
			{
				
				qry1="SELECT NVL (edidescription, ' ') edidescription,  NVL (b.otherparameter, 'N') otherinvestparameter ,nvl(a.otherparameter,'N')otherparameter  FROM tds#edideclaration a ,    tds#investrebatemaster b  WHERE a.companycode = '"+rs.getString("COMPANYCODE")+"'    AND a.tdscode ='"+rs.getString("TDSCODE")+"' and a.EDITYPE='"+EDITYPE+"'  AND a.edicode =  '"+EDICODE+"'   and a.COMPANYCODE=b.COMPANYCODE   and a.TDSCODE=b.TDSCODE   and a.EDICODE=b.INVESTREBATECODE    ";
				//out.print(qry1);
				rs1=db.getRowset(qry1);
				if(rs1.next())
				{
						%>
		<tr>
		<td >
						<%
						//Others Investment ,Please Specify 
		if(rs1.getString("OTHERInvestPARAMETER").equals("Y") )
		{
	
				
	
	qry2="SELECT decode(INVESTMENTAMOUNT,0,' ',INVESTMENTAMOUNT)INVESTMENTAMOUNT,nvl(INVESTMENTDESC,' ')INVESTMENTDESC,decode(ACTUALAMOUNT,'0',' ',ACTUALAMOUNT)ACTUALAMOUNT FROM TDS#OTHERDECLARATION WHERE 	 COMPANYCODE='"+mComp+"' AND TDSCODE='"+mTDSCode+"' AND ASSESSMENTYEAR='"+mAssessYear+"' and  EMPLOYEEID='"+Faculty+"' and nvl(ADDITIONALINFO,'N')<>'Y' ";
//		out.print(qry2);
	rs2=db.getRowset(qry2);
	rs11=db.getRowset(qry2);
			
	if(rs11.next())		
		{	
						%>
				<UL>
				<LI>
				<font size=2  FACE=ARIAL color=blue><b><%=rs1.getString("edidescription")%></b></font>
				</ul>	
						
						
						<TABLE valign=top align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1  cellPadding=1 border=1 >
			<thead>
			<tr><!-- <td colspan=6 align=center ><Font face='ari' size=2 color='Blue'><b>Details </b></font>
				</td>
			 --><tr bgcolor="#ff8c00" >
					<td align=center><Font face='ARIAL' size=1><b>SrNo</b></font></td>
					<td align=center><Font face='ARIAL' size=1><b>Investment Description</b></font></td>
					<td align=center><Font face='ARIAL' size=1><b>Investment Amount</b></font></td>
							<%
					
				if(mStatus.equals("F"))
				  {
				%>
						<td align=center><Font face='ARIAL' size=1><b>Actual Amount</b></font></td>
				<%}
					%>
			</tr>

			</thead>

			<tbody>
				
				<%
				while(rs2.next() )
				{	
					i++;
					%>
				<tr>
				<td><%=i%> </td>
				<td> <%=rs2.getString("INVESTMENTDESC")%> </td>
				<td> <%=rs2.getString("INVESTMENTAMOUNT")%></td>
						<%
				if(mStatus.equals("F"))
				  {
				%>
					<td><%=rs2.getString("ACTUALAMOUNT")%> </td>
				<%
				  }
					%>
				</tr>
				<%
				}
				%>
	
				</TBODY>
			</TABLE>
		<%
		}
			
		}
		else
		{
			%>
			<UL>
							<LI> &nbsp;<font color=black face=arial size=2><%=rs1.getString("edidescription")%></font>&nbsp;&nbsp;
						</UL>
			<%
		}
		
	 if(rs1.getString("OTHERPARAMETER").equals("Y"))
			{	
					
						%>	
							<UL>
							<LI><font color=black face=arial size=2><%=rs1.getString("edidescription")%></font>
						<li>
							<FONT face=Arial color=blue size=2><STRONG><%=mParaDesc%>   
							<%=mParaValue%></STRONG></FONT>

							</UL>
						<%			
						
			}
		%>
	</td>
	<td>
		<%
		if(!rs1.getString("OTHERInvestPARAMETER").equals("Y") )
		{
		%>
		
				 <img SRC="images/Rs.jpg.png" > 
			<font color=black face=arial size=2><%=RecAmt%></font> 
			<%
		}
			%>&nbsp;
	</td>
	</tr>
				<%
	}
			}



			if(EDITYPE.equals("E"))		
			{

			//	out.print(EDITYPE+"EDITYPExxxx");
					qry1="SELECT NVL (a.edidescription, ' ') edidescription, NVL (a.otherparameter, 'N') otherparameter,NVL(B.CATEGORYDESCRIPTION,' ')CATEGORYDESCRIPTION  FROM tds#edideclaration a,TDS#EDRates b WHERE a.companycode = '"+rs.getString("COMPANYCODE")+"'  AND a.tdscode ='"+rs.getString("TDSCODE")+"' AND a.edicode = '"+EDICODE+"' and a.EDITYPE='"+EDITYPE+"' and b.CATEGORYCODE='"+rs.getString("CATEGORYCODE")+"'  and a.COMPANYCODE=b.COMPANYCODE and a.EDICODE=b.EDICODE and a.EDITYPE=b.EDITYPE and a.FINYEAR=b.FINYEAR";
			//		out.print(qry1);
				rs1=db.getRowset(qry1);
				if(rs1.next())
				{
					%>
						<tr>
						<td>
						<%
						if(rs1.getString("OTHERPARAMETER").equals("Y"))
						{
									%>		
							<UL>
								<LI>&nbsp;<font color=black face=arial size=2><%=rs1.getString("edidescription")%> &nbsp;&nbsp <%=rs1.getString("CATEGORYDESCRIPTION")%></font>
									
							<LI><FONT color=black><FONT face=Arial color=blue size=2><STRONG><%=mParaDesc%>   </STRONG>
							<%=mParaValue%></FONT>
							</UL>	
						<%			
						}
						else
						{
								%>
							<UL>
								<LI>&nbsp;<font color=black face=arial size=2><%=rs1.getString("edidescription")%> &nbsp;&nbsp <%=rs1.getString("CATEGORYDESCRIPTION")%>
							
								
								</font>
							</UL>
						<%
						}
						%>
						</td>
						<td><img SRC="images/Rs.jpg.png" > 
							<font color=black face=arial size=2><%=RecAmt%></font>
							 						
						</td>
						</tr>
							<%
				}

			}
		
			
				
			
		

		}
		%>


		<tr>
		<td>
		<%
		qry2="SELECT decode(INVESTMENTAMOUNT,0,' ',INVESTMENTAMOUNT)INVESTMENTAMOUNT,nvl(INVESTMENTDESC,' ')INVESTMENTDESC,decode(ACTUALAMOUNT,'0',' ',ACTUALAMOUNT)ACTUALAMOUNT FROM TDS#OTHERDECLARATION WHERE 	 COMPANYCODE='"+mComp+"' AND TDSCODE='"+mTDSCode+"' AND ASSESSMENTYEAR='"+mAssessYear+"' and  EMPLOYEEID='"+Faculty+"' and nvl(ADDITIONALINFO,'N')='Y' ";
//		out.print(qry2);
	rs2=db.getRowset(qry2);
	rs11=db.getRowset(qry2);
			
	if(rs11.next())		
		{	
						%>	<TABLE valign=top align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1  cellPadding=1 border=1 >
			<thead>
			<tr bgcolor="#ff8c00"><td colspan=6 align=center ><Font face='arial' size=2 color='black'><b>Additional Information if any </b></font>
				</td>
					<tr bgcolor="#ff8c00" >
					<td align=center><Font face='ARIAL' size=1><b>SrNo</b></font></td>
					<td align=center><Font face='ARIAL' size=1><b>Investment Description</b></font></td>
					<td align=center><Font face='ARIAL' size=1><b>Investment Amount</b></font></td>
							<%
					
				if(mStatus.equals("F"))
				  {
				%>
						<td align=center><Font face='ARIAL' size=1><b>Actual Amount</b></font></td>
				<%}
					%>
			</tr>
			</thead>

			<tbody>
				
				<%
				while(rs2.next() )
				{	
					w++;
					%>
				<tr>
				<td><%=w%> </td>
				<td> <%=rs2.getString("INVESTMENTDESC")%> </td>
				<td> <%=rs2.getString("INVESTMENTAMOUNT")%></td>
						<%
				if(mStatus.equals("F"))
				  {
				%>
					<td><%=rs2.getString("ACTUALAMOUNT")%> </td>
				<%
				  }
					%>
				</tr>
				<%
				}
				%>
	
				</TBODY>
			</TABLE>
		<%
		}
%>
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
		<tr>
		<td align="right" colspan=2><br> <br> <font color=black face=arial size=2>
		(Signature of Employee)</font>
		</td>
		</tr>
		</table>
		<%
		}

		else
			{
				 out.println("<BR><center><font face=arial color=red size=2><b>Please Freeze the Tax Declaration !</b></font>  </center>");
			}

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
