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

	function RefreshContents()
	{ 	
    	document.frm.x.value='ddd';
    	document.frm.submit();
	}

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
		String mDeclAmt="",mActAmt="";
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

try{		

		
String	TDSCODE=request.getParameter("TDSCODE");

String	AYEAR=request.getParameter("AYEAR");
String	EDTYPE=request.getParameter("EDTYPE");

String	EDICODE=request.getParameter("EDICODE");
String	FINYEAR=request.getParameter("FINYEAR");
int	   PARAMETERID=Integer.parseInt(request.getParameter("PARAMETERID"));

String	DATATYPE=request.getParameter("DATATYPE");

String	PARAMETERDESC=request.getParameter("PARAMETERDESC").toString().trim();
//out.print("5555555");

   %>
		<Table ALIGN=CENTER BottomMargin=0  Topmargin=0>
		<tr><TD align=middle>
			<font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana"><b>TDS Decleration Investment Form</b></font>
		    </td>
		</tr>
	</table>

	<form name="frm" method=post>
		<table cellpadding=1 cellspacing=1  align=center rules=groups  border=1  >
		<input id="x" name="x" type=hidden>

		<input id="TDSCODE" name="TDSCODE" value="<%=TDSCODE%>" type=hidden>
		<input id="AYEAR" name="AYEAR" value="<%=AYEAR%>"  type=hidden>
		<input id="EDTYPE" name="EDTYPE" value="<%=EDTYPE%>"  type=hidden>
		<input id="EDICODE" name="EDICODE" value="<%=EDICODE%>"  type=hidden>
		<input id="FINYEAR" name="FINYEAR" value="<%=FINYEAR%>" type=hidden>
		<input id="PARAMETERID" name="PARAMETERID" value="<%=PARAMETERID%>" type=hidden>

		<input id="PARAMETERDESC" name="PARAMETERDESC" value="<%=PARAMETERDESC%>" type=hidden>
		<input id="DATATYPE" name="DATATYPE" value="<%=DATATYPE%>" type=hidden>
			
			
		<tr>
		<td>
		<font face=arial size=2><STRONG>
		&nbsp;Employee Name
		</STRONG></FONT>
		</td>
	
		<%
		if(!mDesg.equals("DEAN"))
		{
		%>
			<td  ><input type=text name="Employeename" value="<%=mMemberName%> [<%=mDMemberCode%>]" readonly size=40>
			</td>
			<td>
			<font  face=arial size=2><STRONG>Designation 
			</TD>
			<TD>
			<input type=text name="Designation" size=30 value="<%=GlobalFunctions.toTtitleCase(mDesg)%>(<%=mDept%>)" readonly >
			</td>
		<%
		}
		else
		{
		%>
			<td>
			<input type=text name="Employeename" value="<%=mMemberName%> [<%=mDMemberCode%>]" readonly size=40 >
			</td>
			<td>
			<font  face=arial size=2><STRONG>Designation
			</TD>
			<TD>
			<input type=text name="Designation" size=30 value="<%=GlobalFunctions.toTtitleCase(mDesg)%>(<%=mDept%>)" readonly ></td>
		<%
		}
		%>
		<!-- Institute **************** ********************** *******************-->
		<INPUT Type="Hidden" Name="Type" id="Type" Value="<%=mType%>">
		<INPUT Type="Hidden" Name="Inst" id=Inst Value=<%=mInst%>>
		
	
</tr>

<tr>


<td>
<FONT face=Arial size=2><STRONG>&nbsp;Assessment Year  
</td>
<td>
<Select Name="ASSESYEAR"  tabindex="0" id="ASSESYEAR" >		
			<option selected Value ="<%=AYEAR%>"><%=AYEAR%></option>
</select>
</strong>
</font>

</td>
<td nowrap>

	<FONT color=black><FONT face=Arial size=2><STRONG>Financial Year  </STRONG></FONT>
	
	</TD>
	<TD>
	<Select Name="FINANCIALYEAR"  tabindex="0" id="FINANCIALYEAR" >		
	<option selected Value ="<%=FINYEAR%>"><%=FINYEAR%></option>
	</td>

</tr>

<tr>
<td nowrap>

	<FONT color=black><FONT face=Arial size=2><STRONG><%=PARAMETERDESC%>   </STRONG></FONT>
	
	</TD>
	<TD>
	<INPUT TYPE=TEXT Name="PARAMETERVALUE"   id="PARAMETERVALUE" MAXLENGTH=75 SIZE=10 >		
	<%
		if(DATATYPE.equals("D"))
	{	%>
			<font face=arial size=1 color=green><b>DD-MM-YYYY</b></font>
			<%
	}
	
		%>
	</td>

	<TD>
	<INPUT TYPE="submit" Name="Save"   Value="Save" >		

	</td>

</tr>


	</table>
	</form>


<%
if(request.getParameter("x")!=null)
	{
		String mParaValue="";

		if(request.getParameter("PARAMETERVALUE")==null)
			mParaValue="N";
		else
			mParaValue=request.getParameter("PARAMETERVALUE");

		if(!mParaValue.equals("N") && !mParaValue.equals(""))
		{

		qry="SELECT  'Y' FROM TDS#DECLARATIONPARADETAIL WHERE COMPANYCODE='"+mComp+"' AND TDSCODE='"+TDSCODE+"' AND ASSESSMENTYEAR='"+AYEAR+"' AND  EDITYPE='"+EDTYPE+"' AND EDICODE='"+EDICODE+"' AND PARAMETERID="+PARAMETERID+" ";
		//out.print(qry);
		rs=db.getRowset(qry);
		if(!rs.next())
		{	
			qry1="INSERT INTO TDS#DECLARATIONPARADETAIL (   COMPANYCODE, TDSCODE, ASSESSMENTYEAR,    EDITYPE, EDICODE, PARAMETERID,    FINYEAR, EMPLOYEEID, PARAMETERVALUE,    DEACTIVE, ENTRYBY, ENTRYDATE) VALUES ('"+mComp+"' ,'"+TDSCODE+"' ,'"+AYEAR+"' ,'"+EDTYPE+"', '"+EDICODE+"', "+PARAMETERID+" ,'"+FINYEAR+"' ,'"+mChkMemID+"' ,'"+mParaValue+"','N' , '"+mChkMemID+"' ,sysdate)";
			//out.print(qry1);
			int z=db.insertRow(qry1);
			if(z>0)
				out.print("<center><font face=arial color=green size=2 ><b> Record Saved Successfully</b></font> ");
			else
				out.print("<center><font face=arial color=red size=2 ><b> Error in Saving</b></font> ");
				

		}
		else
		{
			qry1="UPDATE TDS#DECLARATIONPARADETAIL SET    PARAMETERVALUE = '"+mParaValue+"', ENTRYBY=  '"+mChkMemID+"',       ENTRYDATE      = sysdate	WHERE  COMPANYCODE='"+mComp+"' AND TDSCODE='"+TDSCODE+"' AND ASSESSMENTYEAR='"+AYEAR+"' AND  EDITYPE='"+EDTYPE+"' AND EDICODE='"+EDICODE+"' AND PARAMETERID="+PARAMETERID+" ";
			//out.print(qry1);
			int y=db.update(qry1);
			if(y>0)
			out.print("<center><font face=arial color=green size=2 ><b> Record Updated Successfully</b></font> ");
			else
				out.print("<center><font face=arial color=red size=2 ><b> Error in Saving</b></font> ");
		
		}



		}
		else
		{
				out.print("<center><font face=arial color=red size=2 ><b>Please enter the data properly</b></font> ");
		}

		
	}
%>
<TABLE valign=top align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 width="70%" cellPadding=1 border=1 >
<thead>
<tr><td colspan=6 align=center ><Font face='verdana' size=3 color='Blue'><b>Available List</b></font>
    </td>
<tr bgcolor="#ff8c00" >
		<td align=center><Font face='verdana' size=2><b>Sr.No.</b></font></td>
		<td align=center><Font face='verdana' size=2><b>Parameter Desc</b></font></td>
		<td align=center><Font face='verdana' size=2><b>Parameter Value</b></font></td>
</tr>
</thead>
<%
qry="SELECT COMPANYCODE, TDSCODE, ASSESSMENTYEAR,    EDITYPE, EDICODE, PARAMETERID,    FINYEAR, EMPLOYEEID, PARAMETERVALUE, DEACTIVE, ENTRYBY, ENTRYDATE FROM TDS#DECLARATIONPARADETAIL WHERE EMPLOYEEID='"+mChkMemID+"' AND COMPANYCODE='"+mComp+"' AND TDSCODE='"+TDSCODE+"' AND ASSESSMENTYEAR='"+AYEAR+"' AND  EDITYPE='"+EDTYPE+"' AND EDICODE='"+EDICODE+"'  AND PARAMETERID="+PARAMETERID+" ";
rs=db.getRowset(qry);
if(rs.next())
	{
	sno++;
		%>
		<tr>
			<td align=center><%=sno%></td>	
			<td align=center><%=PARAMETERDESC%></td>	
			<td align=center><%=rs.getString("PARAMETERVALUE")%></td>	
		</tr>
		<%
	}
%>
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
