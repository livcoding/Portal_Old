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
String mExam="",mexam="",mExamid="",mFacltyID="",mSubj="",msubj="";
String qry="",qry1="",qry2="",qry3="",x="",qrymEventsubevent="",mTDSCode="E";
int msno=0;
double mvalue=0,mMaxmarks=0,MyMax=0,mchkmarks=0;
String mmvalue="";

int ctr=0;
String mIC="",mEC="",mSC="",mList="",mOrder="",mFaculty=""; 
ResultSet rsSub =null,rs=null,rss=null,rs1=null,rs2=null,rs3=null,rsfac=null,rse=null,rsm=null,rsi=null,rstable=null,rsTableData=null,rsTime=null;
String mMOP="",mName5="",mlistorder="";		

int kk=0;	
String msubeven="",mMarks="",mPerc="",mName1="",mMark="",mName2="",mName3="",mName4="",mName8="";
String mName6="",mName7="";		
String mFacltyID1="",mSubj1="",qrymExamid="",examidm="",msubj1="";
String mType="";
int mRights=0;
String SubQry="",mySub="";
String mDMemberType="I",mCOMPASSESSMENT="";
String mComp="",mAssesmentYear="";			
String mSave="0";				


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
	ResultSet r=null;

	qry="Select TDSCODE From TDS#TDSMASTER Where COMPANYCODE='"+mComp+"' And SLTYPE='"+mDDMemberType+"'";

	r=db.getRowset(qry);	
	if( r.next() )
	{
	   mTDSCode=r.getString("TDSCODE");
	}	
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
	else if(mType.equals("I"))
	{
	   mRights=168;
	}

	qry="Select WEBKIOSK.ShowLink('"+mRights+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";	
      RsChk1= db.getRowset(qry);
	
	//out.print(qry);

	if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
	{
   
	  //----------------------
		%>	
	<Table ALIGN=CENTER BottomMargin=0  Topmargin=0>
		<tr><TD align=middle>
			<font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Tax Decleration Form/Screen</b></font>
		    </td>
		</tr>
	</table>

	<form name="frm" method=post>
	<table cellpadding=1 cellspacing=0  align=center rules=groups border=3>
		<input id="x" name="x" type=hidden>
		<tr><td nowrap>
		<%
		if(!mDesg.equals("DEAN"))
		{
		%>
			<font color=Green face=arial size=2><STRONG>&nbsp;<%=mMemberName%> [<%=mDMemberCode%>]
			&nbsp;: &nbsp; &nbsp;<%=GlobalFunctions.toTtitleCase(mDesg)%>&nbsp; (<%=mDept%>)
		<%
		}
		else
		{
		%>
			<font color=Green face=arial size=2><STRONG>&nbsp;<%=mMemberName%> [<%=mDMemberCode%>]
			&nbsp;: &nbsp; &nbsp;<%=mDesg%>&nbsp; (<%=mDept%>)
		<%
		}
		%>
		<!-- Institute **************** ********************** *******************-->
		<INPUT Type="Hidden" Name="Type" id="Type" Value="<%=mType%>">
		<INPUT Type="Hidden" Name="Inst" id=Inst Value=<%=mInst%>>
		<%
			qry="select distinct nvl(institutecode,' ')IC from INSTITUTEMASTER where nvl(DEACTIVE,'N')='N' ";
			rsi=db.getRowset(qry); 
			while(rsi.next())
			{
				mInst=rsi.getString("IC");
			}
	%>
	</td>
</tr>
<tr>
<td nowrap>
	<!--************************************* TDS#ASSESSMENTYEAR  ********************************-->
	<FONT color=black><FONT face=Arial size=2><STRONG>&nbsp;Financial Year : </STRONG></FONT></FONT>
	<%  
	try
	{ 
	qry="Select FINANCIALYEARCODE ||' ('||COMPANYCODE||')' COMPASSESSMENT From FINANCIALYEARMASTER Where Nvl(CLOSED,'N')='N' And Nvl(deactive,'N')='N' order by 1 desc ";  
	rs=db.getRowset(qry);
	%>					
		<Select Name="COMPASSESSMENT"  tabindex="0" id="COMPASSESSMENT" style="WIDTH: 250px">		
		<%
		if (request.getParameter("x")==null)
		  {
			while(rs.next())
			{
				mExamid=rs.getString("COMPASSESSMENT");
				if(examidm.equals(""))
				{
					examidm=mExamid;
					qrymExamid=mExamid;
					%>	
					<option  Value =<%=mExamid%>><%=mExamid%></option>
					<%	
					}
					else
					{
					%>
					<option  Value =<%=mExamid%>><%=mExamid%></option>
					<%	
					}		
			}		
		}		
		else
		{
			while(rs.next())
			{
				mExamid=rs.getString("COMPASSESSMENT");				
				if(mExamid.equals(request.getParameter("COMPASSESSMENT").toString().trim()))
 				{
				  	qrymExamid=mExamid;
					%>
					<option selected Value =<%=mExamid%>><%=mExamid%></option>
				<%			
			     }
			     else
		      	{
				%>
		      		<option Value =<%=mExamid%>><%=mExamid%></option>
		      	<%			
		   		}
			}		
	 	}

		%>
			</select>
		<%

 	}    
	catch(Exception e)
	{
	    // out.println("Before Facultyid 1"+e.getMessage());
	    //
	}

//********************FacltyID Combo(FacultyID)*************/
try
{
	if(mType.equals("D"))
	{
		qry="select B.EmployeeID,B.employeename employeename ";
		qry=qry+" From V#Staff B  where  EmployeeType='"+mDMemberType+"' And Nvl(Deactive,'N')='N' order by B.employeename ";
	}
	else if(mType.equals("H"))
	{
		qry="select b.EmployeeID, B.employeename employeename from V#Staff B where EmployeeType='"+mDMemberType+"' and employeeid in (select employeeid from V#STAFF where departmentcode='"+mDept+"') ";
		qry=qry+"and nvl(deactive,'N')='N'   order by b.employeename ";  	
	}
	else if(mType.equals("I"))
	{
		qry="select b.EmployeeID,B.employeename employeename from V#Staff B where ";
		qry=qry+" EmployeeType='"+mDMemberType+"' and employeeid='"+mDMemberID+"' ";
		qry=qry+"and nvl(deactive,'N')='N'  order by  b.employeename ";  
	}

	rse=db.getRowset(qry);

%>
<select name=FacultyIDShow tabindex="0" id="FacultyIDShow" style="WIDTH: 250px">
<%
	if (request.getParameter("x")==null) 
	{
	%>
		
	<%   

		while(rse.next())
		{
			mFacltyID=rse.getString("EmployeeID");
			if(qrymEventsubevent.equals(""))	
			{		
				qrymEventsubevent=mFacltyID;
			%>
			<OPTION selected Value = <%=mFacltyID%>><%=rse.getString("employeename")%></option>
			<%	
			}
			
			else
			{
			%>
			<OPTION  Value = <%=mFacltyID%>><%=rse.getString("EMPLOYEENAME")%></option>
			<%	
			}	
		}
	}
	else
	{
		while(rse.next())
		{
			mFacltyID=rse.getString("EmployeeID");
			if(mFacltyID.equals(request.getParameter("FacultyIDShow").toString().trim()))
 			{
				qrymEventsubevent=mFacltyID;
			%>
			 <OPTION selected value= <%=mFacltyID%>> <%=rse.getString("EMPLOYEENAME")%> </option>
				<%			
		    }
		    else
		      {
				%>
				
		      	<OPTION Value= <%=mFacltyID%> > <%=rse.getString("EMPLOYEENAME")%> </option>
		      	<%			
		   	}
		}
	 }

	

	%>
		</select>
 	<%
	}
	catch(Exception e)
	{
		//out.print("error After faculty id " + e);
	}	
%>
	</td>
</tr>
<tr>
	<td nowrap align=center>
	<INPUT Type="submit" Value="Show/Refresh">
	</td>
</tr>

	</table>
	    </form>
	<%	
	 	
//*************** TO SHOW WHAT WE SELECT *****************
	
if(request.getParameter("FacultyIDShow")!=null)
	mFaculty=request.getParameter("FacultyIDShow").toString().trim();
else
	mFaculty=qrymEventsubevent;

if(request.getParameter("COMPASSESSMENT")!=null)
	mCOMPASSESSMENT=request.getParameter("COMPASSESSMENT").toString().trim();
else
	mCOMPASSESSMENT=qrymExamid;

mComp="";
mAssesmentYear="";

int mPos1 = mCOMPASSESSMENT.indexOf("(");

if (mPos1>0)
   mAssesmentYear=mCOMPASSESSMENT.substring(0,mPos1);   
   
 

int mPos2 = mCOMPASSESSMENT.indexOf(")");
if (mPos2>0)
   mComp=mCOMPASSESSMENT.substring(mPos1+1,mPos2);

  
try
  {
	double mTotalSalary=0,mRecvDeclAmount=0;
	double mTaxAmount=0,mPaidTaxAmount=0,mTotalIncome=0;

  	%>
	<hr>
		Emloyee Name : <%=mFaculty%>
		Assesment Year (Company Code) : <%=mCOMPASSESSMENT%><br>
		Total Income (Salary) Rs. :  <%=mTotalIncome%><br>
		Total Expectable Amount / Income Rs.: <%=mTaxAmount%>
		&nbsp; &nbsp; &nbsp; &nbsp; 
		Total Paid tax Amount Rs. : <%=mPaidTaxAmount%>
		<!--Recceived Decleration Total .: <%=mRecvDeclAmount%><br>-->
<hr>
<form Name=TDS Action='TDSDecleration.jsp' method=post >
<table width='100%' cellpadding=0 cellspacing=0>
<tr><td colspan=3>
	<Font face='verdana' size=2 color='Blue'>
		<b>Add/Edit decleration for the above assesment year</b></font>
	<hr>
    </td>
<tr>
	<td align=center><Font face='verdana' size=2><b>EDI Type</b></font></td>
	<td align=center><Font face='verdana' size=2><b>Decleration Date</b></font></td>
	<td align=center><Font face='verdana' size=2><b>Decleration Amount Rs.</b></font></td>
</Tr>
<%

qry=" Select b.SECTIONCODE, b.SHORTNAME, b.SECTIONDESC, b.SEQUENCEID , a.SECTIONCODE PSectionCode, a.SHORTNAME PSectionShortName, a.SECTIONDESC PSectionDesc, a.SEQUENCEID PSectionSeqID,EDITYPE, EDICODE From TDS#SECTIONMASTER A, TDS#SECTIONMASTER B , TDS#TDSSECTIONTAGGING C Where C.COMPANYCODE=A.COMPANYCODE And A.TDSCODE=C.TDSCODE And  C.FINYEAR='"+mFinYear+"' And  C.SECTIONCODE = A.SECTIONCODE  And B.PARENTSECTIONCODE = A.SECTIONCODE(+) And A.COMPANYCODE='" + mComp + "' And A.TDSCODE='"+mTDSCode+"' And B.COMPANYCODE='" + mComp + "' And b.TDSCODE='"+mTDSCode+"' And Nvl(A.deactive,'N')='N' And Nvl(C.deactive,'N')='N'  And  Nvl(B.deactive,'N')='N' order by  b.SEQUENCEID,a.SEQUENCEID  ";
out.print(qry);
rstable = db.getRowset(qry);  		
mSave = "0";
while (rstable.next())
	{
		mSave="1";
		%>
		<tr>
		<td align='Center'><%=rstable.getString("SECTIONCODE")%></td>
		<td align='Center'><%=rstable.getString("SHORTNAME")%></td>
		<td align='Center'>Rs. <Input maxlength=10 size=10 Type=Text ID='<%=rstable.getString("SECTIONCODE")%>' Name='<%=rstable.getString("SECTIONCODE")%>'></td>
		</tr>
		<%
	}





if(mSave.equals("1"))
{
%>
<tr><td colspan=2>
	<td align=center>
		<Font face='verdana' size=2><b><Input Type='Submit' Value='Save'></b></font>
	</td>
</tr>
<%
mSave="0";
}
%>
</form>
</table>
	<%	
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
