<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="CommonFiles/ExceptionHandler.jsp" %> 

<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>

<HTML>
<head>
<TITLE>#### <%=mHead%> [ DR/CR Advice Report ] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

</head>

<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%

/*
***************************************************************************************
	' * File Name:		SelfStudEmpDrCrAdvice.JSP	[For Students/Employee]			
	' * Developed By:	Rajiv Srivastava
	' * Date:			7th Dec 07								
	' * Description:	Current Student Debit/Credit Advice Detail
	' * Modified bny Ashok Kr Singh  Dated: 11.12.07
***************************************************************************************
*/

DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();
String qry="",qry1="",qry2="",qry3="",qry4="",qry5="",qry6="",mWebEmail="";
String mPrevDay="", mPrevMonth="", mPrevYear="", mCurrentDay="", mCurrentMonth="", mCurrentYear="";
int PrevDay=0,PrevMonth=0,PrevYear=0,CurrentDay=0, CurrentMonth=0,CurrentYear=0;
int FromDate=0;
int ToDate=0;
int PageSize=10;
String dam="";
String cam="";
String mFromDate="";
String mToDate="";
String Page="";
int start=0;
int last=0;int count=0;int dAmount=0; int cAmount=0; int diff=0;
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
String mSem="";
int mSemPlusOne=0;
String mProg="",mBranch="",mName="",mDesignation="",mDepartment="";
String mINSTITUTECODE="",mComp="",mSID="";
ResultSet Rs=null,rs=null,rs1=null;

//****************************************************************************//

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

	if (session.getAttribute("InstituteCode")==null)
	{
		mINSTITUTECODE="";
	}
	else
	{
		mINSTITUTECODE=session.getAttribute("InstituteCode").toString().trim();
	}

	if (session.getAttribute("ProgramCode")==null)
	{
		mProg="";
	}
	else
	{
		mProg=session.getAttribute("ProgramCode").toString().trim();
	}

	if (session.getAttribute("BranchCode")==null)
	{	
		mBranch="";
	}
	else
	{
		mBranch=session.getAttribute("BranchCode").toString().trim();
	}

	if (session.getAttribute("CurrentSem")==null)
	{
		mSem="";
	}
	else
	{
		mSem=session.getAttribute("CurrentSem").toString().trim();
		mSemPlusOne=(Integer.parseInt(mSem))+0;
	}

	if (session.getAttribute("MemberName")==null)
	{
		mName="";
	}
	else
	{
		mName=session.getAttribute("MemberName").toString().trim();
	}

	if (request.getParameter("StartIndex")==null)
	{
		start=1;
	}
	else
	{
		start=Integer.parseInt(request.getParameter("StartIndex").trim());
	}

	if (request.getParameter("LastIndex")==null)
	{
		last=PageSize;
	}
	else
	{
		last=Integer.parseInt(request.getParameter("LastIndex").trim());
	}

	if (request.getParameter("SID")==null)
	{
		mSID ="";
	}
	else
	{
		mSID =request.getParameter("SID").toString().trim();
	}
//*********************************************************************************

try
{//1

	//-----------------------------------------------------------------------
	//----------------------- Enable Security Page Level --------------------  
	//----------------------------------------------------------------------- 

	qry="Select COMPANYTAGGING From InstituteMaster Where InstituteCode='"+mINSTITUTECODE+"'";
	Rs= db.getRowset(qry);
	if (Rs.next())
		{
		  mComp=Rs.getString("COMPANYTAGGING");
		}

	if(!mMemberID.equals("") && !mMemberType.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{  //2
		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mMacAddress =" "; 
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk=null;
		
		qry="Select WEBKIOSK.ShowLink('151','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";

		  RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{//3
			try
			{	
				mDMemberCode=enc.decode(mMemberCode);
				mMemberID=enc.decode(mMemberID);
				mMemberType=enc.decode(mMemberType);
			}

			catch(Exception e)
			{
				//out.println(e.getMessage());
			}
%>
	<FORM METHOD=POST ACTION="SelfStudEmpDrCrAdvice.jsp">
	<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
	 <tr>
	  <TD align=middle><font color="#a52a2a" style="FONT-SIZE: medium"><b>Debit/Credit Advice</b></font>
	  </td>
	 </tr>
	</table>

	<table width=100%  rules=groups cellspacing=1 cellpadding=1 align=center border=1>
	 <tr>
	  <td><font color=black face=arial size=2> 
<%
//********************************************************************************
	//--------------------------------------------------------------------------
	//------------------------ Enable Login Identification ---------------------  
	//-------------------------------------------------------------------------- 
%>
		<STRONG>Name:&nbsp;	</STRONG></font><%=GlobalFunctions.toTtitleCase(mName)%>[<%=mDMemberCode%>]
	  </td>
<%
	  if(mMemberType.equals("S"))
	  {	
%>
	<td><font color=black face=arial size=2>														<STRONG>Course/Branch:&nbsp;
		</STRONG></font><%=mProg%>(<%=mBranch%>)
	</td>

	<td><font color=black face=arial size=2>
		<STRONG>Current Semester:&nbsp;
		</STRONG></font><%=mSemPlusOne%>
	</td>
	</tr>
<%
	  }

	  else if(mMemberType.equals("E"))
	  {	
		qry="Select nvl(a.EMPLOYEECODE,' ') EMPLOYEECODE, nvl(a.EMPLOYEENAME, ' ') EMPLOYEENAME, ";
		qry=qry+" nvl(b.DESIGNATION,' ') DESIGNATION, nvl(c.DEPARTMENT,' ') DEPARTMENT from ";
		qry=qry+" EmployeeMaster a, DESIGNATIONMASTER b, DEPARTMENTMASTER c Where a.EmployeeID='"+mChkMemID+"'";
		qry=qry+" and a.DESIGNATIONCODE=b.DESIGNATIONCODE and a.DEPARTMENTCODE=c.DEPARTMENTCODE";
	
		rs=db.getRowset(qry);
	
		if(rs.next())
		{
			if (rs.getString("DESIGNATION") ==null)
				mDesignation="";
			else
				mDesignation=rs.getString("DESIGNATION");

			if (rs.getString("DEPARTMENT")==null)
				mDepartment="";
			else
				mDepartment=rs.getString("DEPARTMENT");
%>
		<td><font color=black face=arial size=2>														<STRONG>Department:&nbsp;
			</STRONG></font><%=GlobalFunctions.toTtitleCase(mDepartment)%>
		</td>

		<td><font color=black face=arial size=2>
			<STRONG>Designation:&nbsp;
			</STRONG></font><%=GlobalFunctions.toTtitleCase(mDesignation)%>
		</td>
	   </tr>
<%
   //*******************************************************************************
	    }
      }
%>
	   <tr>
	    <td colspan="8" class="tablecell" align="left"><b>Report Between Date: &nbsp;</b>
<%
   // ***************************** FROM DATE TNTRY ********************************

		String mcurrentDay="";
		int currentDay=0;

		try 
		{
			qry="SELECT to_char(sysdate,'dd') DT from dual";
			rs=db.getRowset(qry);			
			if (rs.next())
			{			
				mcurrentDay=rs.getString("DT");
			}
				currentDay=Integer.parseInt(mcurrentDay);
		}

		catch(Exception e)
		{
			//out.println(e.getMessage());
		}

		if(request.getParameter("PrevDay")==null)
		{
			mPrevDay="";
			PrevDay=currentDay;
		}
		else
		{
			mPrevDay=request.getParameter("PrevDay").trim();
			PrevDay=Integer.parseInt(mPrevDay);
		}
%>
	<select name="PrevDay" id="PrevDay" style="WIDTH: 50px" class="inputfield" onkeydown="if(event.keyCode==13){event.keyCode=9;return event.keyCode}">
<%
		for(int i=1;i<=31;i++)
		{
			if(i==PrevDay)
			{
%>		
				<option SELECTED value="<%=i%>"> <%=i%> </option>
<%
			}
			else
			{
%>			<option value="<%=i%>"><%=i%></option>
<%	
			}	
		}
%>	
	</select>
<%
		String mcurrentMonth="";
		int currentMonth=0;
		int lastMonth=0;

		try 
		{
			qry="SELECT to_char(sysdate,'mm') MN from dual";
			rs=db.getRowset(qry);	
			
			if (rs.next())
			{			
				mcurrentMonth=rs.getString("MN");
			}
				currentMonth=Integer.parseInt(mcurrentMonth);
				lastMonth=currentMonth-1;
			}

		catch(Exception e)
		{
			//out.println(e.getMessage());
		}

	if(request.getParameter("PrevMonth")==null)
	{
		mPrevMonth="";
		PrevMonth=lastMonth;
	}
	else
	{
		mPrevMonth=request.getParameter("PrevMonth");
		PrevMonth=Integer.parseInt(mPrevMonth);
	}
%>
	&nbsp; &nbsp;<select size="1" name="PrevMonth" id="PrevMonth" class="inputfield" onkeydown="if(event.keyCode==13){event.keyCode=9;return event.keyCode}">
	  <option <%if(PrevMonth==1){out.println("selected");}%> value="01">Jan</option>
	  <option <%if(PrevMonth==2){out.println("selected");}%> value="02">Feb</option>
	  <option <%if(PrevMonth==3){out.println("selected");}%> value="03">Mar</option>
	  <option <%if(PrevMonth==4){out.println("selected");}%> value="04">Apr</option>
	  <option <%if(PrevMonth==5){out.println("selected");}%> value="05">May</option>
	  <option <%if(PrevMonth==6){out.println("selected");}%> value="06">June</option>
	  <option <%if(PrevMonth==7){out.println("selected");}%> value="07">July</option>
	  <option <%if(PrevMonth==8){out.println("selected");}%> value="08">Aug</option>
	  <option <%if(PrevMonth==9){out.println("selected");}%> value="09">Sept</option>
	  <option <%if(PrevMonth==10){out.println("selected");}%> value="10">Oct</option>
	  <option <%if(PrevMonth==11){out.println("selected");}%> value="11">Nov</option>
	  <option <%if(PrevMonth==12){out.println("selected");}%> value="12">Dec</option>	
	</select>
<%
		String mcurrentYear="";
		int currentYear=0;
		int lastYear=0;

		try 
		{
			qry="SELECT to_char(sysdate,'yyyy') YR from dual";
			rs=db.getRowset(qry);			
			if (rs.next())
			{			
				mcurrentYear=rs.getString("YR");
			}
				currentYear=Integer.parseInt(mcurrentYear);
				lastYear=currentYear-1;
			}

		catch(Exception e)
		{
			//out.println(e.getMessage());
		}

		if(request.getParameter("PrevYear")==null)
		{
			mPrevYear="";
			PrevYear=currentYear;
		}
		else
		{
			mPrevYear=request.getParameter("PrevYear").trim();
			PrevYear=Integer.parseInt(mPrevYear);
		}
%>
	&nbsp;&nbsp;<select size="1" name="PrevYear" id="PrevYear" class="inputfield" onkeydown="if(event.keyCode==13){event.keyCode=9;return event.keyCode}">
	  <option value="<%=lastYear%>"><%=lastYear%></option> 
	  <option selected value="<%=currentYear%>"><%=currentYear%></option> 
	</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b> to </b>&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
<%
	//********************************* TO DATE ENTRY ******************************
	
			if(request.getParameter("CurrentDay")==null)
			{
				mCurrentDay="";
				CurrentDay=currentDay;
			}
			else
			{
				mCurrentDay=request.getParameter("CurrentDay").trim();
				CurrentDay=Integer.parseInt(mCurrentDay);
			}
%>
	<select name="CurrentDay" id="CurrentDay" style="WIDTH: 50px" class="inputfield" onkeydown="if(event.keyCode==13){event.keyCode=9;return event.keyCode}">
<%
			for(int i=1;i<=31;i++)
			{
				if(i==CurrentDay)
				{
%>			
					<option SELECTED value="<%=i%>"> <%=i%> </option>
<%
				}
				else
				{
%>		
					<option value="<%=i%>"><%=i%></option>
<%	
				}	
			}
%>	
	</select>
<%
			if(request.getParameter("CurrentMonth")==null)
			{
				mCurrentMonth="";
				CurrentMonth=currentMonth;
			}
			else
			{
				mCurrentMonth=request.getParameter("CurrentMonth").trim();
				CurrentMonth=Integer.parseInt(mCurrentMonth);
			}
%>
	&nbsp; &nbsp;<select size="1" name="CurrentMonth" id="CurrentMonth" class="inputfield" onkeydown="if(event.keyCode==13){event.keyCode=9;return event.keyCode}">
	  <option <%if(CurrentMonth==1){out.println("selected");}%> value="01">Jan</option>
	  <option <%if(CurrentMonth==2){out.println("selected");}%> value="02">Feb</option>
	  <option <%if(CurrentMonth==3){out.println("selected");}%> value="03">Mar</option>
	  <option <%if(CurrentMonth==4){out.println("selected");}%> value="04">Apr</option>
	  <option <%if(CurrentMonth==5){out.println("selected");}%> value="05">May</option>
	  <option <%if(CurrentMonth==6){out.println("selected");}%> value="06">June</option>
	  <option <%if(CurrentMonth==7){out.println("selected");}%> value="07">July</option>
	  <option <%if(CurrentMonth==8){out.println("selected");}%> value="08">Aug</option>
	  <option <%if(CurrentMonth==9){out.println("selected");}%> value="09">Sept</option>
	  <option <%if(CurrentMonth==10){out.println("selected");}%> value="10">Oct</option>
	  <option <%if(CurrentMonth==11){out.println("selected");}%> value="11">Nov</option>
	  <option <%if(CurrentMonth==12){out.println("selected");}%> value="12">Dec</option>
    </select>
<%
		if(request.getParameter("CurrentYear")==null)
		{
			mCurrentYear="";
			CurrentYear=currentYear;
		}
		else
		{
			mCurrentYear=request.getParameter("CurrentYear").trim();
			CurrentYear=Integer.parseInt(mCurrentYear);
		}
%>
	&nbsp;&nbsp;<select size="1" name="CurrentYear" id="CurrentYear" class="inputfield" onkeydown="if(event.keyCode==13){event.keyCode=9;return event.keyCode}">
	  <option value="<%=lastYear%>"><%=lastYear%></option>
	  <option selected value="<%=currentYear%>"><%=currentYear%></option> 
	</select>
	&nbsp;&nbsp;&nbsp;<input type="submit" value="View/Refresh"></td></tr>
	</table>
<%
			mFromDate=""+PrevDay+"/"+PrevMonth+"/"+PrevYear;
			mToDate=""+CurrentDay+"/"+CurrentMonth+"/"+CurrentYear;

				if (request.getParameter("Paging")==null)
				{
					Page="";
				}
				else
				{
					Page=request.getParameter("Paging").trim();
				}
		
				if(Page.equals("add"))
				{
					start=start+PageSize;
					last=last+PageSize;
				}
				else if(Page.equals("substract"))
				{
					start=start-PageSize;
					last=last-PageSize;
				}
		
			qry="select 'y' from dual where to_date('"+mFromDate+"','dd/mm/yyyy') < to_date('"+mToDate+"','dd/mm/yyyy')";

			rs=db.getRowset(qry);

			qry1="Select count(*) count from SLDRCRADVICE ";
			qry1=qry1+" Where COMPANYCODE='"+mComp+"' And INSTITUTECODE='"+mINSTITUTECODE+"' And SLTYPE='"+mMemberType+"' and SLCODE ='"+mMemberID+"'";
			qry1=qry1+" And nvl(DEACTIVE,'N')<>'Y' AND ADVICEDATE  between to_date('"+mFromDate+"','dd/mm/yyyy') AND to_date('"+mToDate+"','dd/mm/yyyy')order by ADVICEDATE desc" ;
			
			rs=db.getRowset(qry1);
			if(rs.next())
			{
				String cnt=rs.getString(1);
				count=Integer.parseInt(cnt);
			}
			if(count<1)
			{
				out.print(" <center><b><font size=4 face='Arial' color='Red'>Debit/Credit Advice Not Found!</font>");
			}
			else
		    {
		  	qry2="select to_char(ADVICEDATE,'dd/mm/yyyy') ADVICEDATE, REASON, FROMOTHERS, FROMLOCATION, FROMDEPARTMENT, FROMCOSTCENTRECODE, nvl(AMOUNT,0) AMOUNT,";
			qry2=qry2+" FROMWHERE,decode(ADVICETYPE,'D','Debit','Credit')  ADVICETYPE , decode(STATUS,'F','Executed','Not Executed') STATUS from SLDRCRADVICE ";
			qry2=qry2+" Where COMPANYCODE='"+mComp+"' And INSTITUTECODE='"+mINSTITUTECODE+"' And SLTYPE='"+mMemberType+"' and SLCODE ='"+mMemberID+"'";
			qry2=qry2+" And nvl(DEACTIVE,'N')<>'Y' AND ADVICEDATE  between to_date('"+mFromDate+"','dd/mm/yyyy') AND	to_date('"+mToDate+"','dd/mm/yyyy')";

			qry3="select * from (select a.*, rownum rn from("+qry2+") a where rownum<='"+last+"') where	rn>='"+start+"'";
%>
	<TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="100%" border=1 >
	<thead>
	 <tr bgcolor="#ff8c00">
	  <td align=center Title="Click on Advice Date to sort"><b><font  color="White">Date</font></b></td>
	  <td align=center Title="Click on Location to Sort"><b><font color="White">Location</font></b></td>
	  <td align=center Title="Click on Reason to Sort"><b><font color="White">Reason </font></b></td> 
	  <td align=center Title="Click on Advice Type to Sort"><b><font color="White">Advice Type </font></b></td> 
	  <td align=center Title="Click on Amount to Sort"><b><font color="White">Amount</font></b></td> 
	  <td align=center Title="Click on Status to Sort"><b><font color="White">Status</font></b></td> 
	 </tr>
	</thead>
	<tbody>
<%
				String from="";
				rs=db.getRowset(qry3);
			
				while(rs.next())
				{
%>				
					<tr>
	                 <td class="tablecell"> &nbsp;<%=rs.getString("ADVICEDATE")%></td>
<%
					qry6="";
					if(rs.getString("FROMWHERE").equals("L"))
					{
						qry6=" select nvl(B.LOCATIONNAME,'') mNAME from LOCATIONMASTER B  where COMPANYCODE='"+mComp+"'";	
						qry6=qry6+" and b.LOCATIONCODE='"+rs.getString("FROMLOCATION")+"'";
					}	
					else if(rs.getString("FROMWHERE").equals("D"))
					{
						qry6=" select nvl(C.DEPARTMENT,'') mNAME from DEPARTMENTMASTER C where COMPANYCODE='"+mComp+"' and c.DEPARTMENTCODE='"+rs.getString("FROMDEPARTMENT")+"' ";
					}
					else if(rs.getString("FROMWHERE").equals("C"))
					{
						qry6=" select nvl(D.COSTCENTRENAME,'') mNAME from COSTCENTREMASTER D where COMPANYCODE='"+mComp+"' and d.COSTCENTRECODE='"+rs.getString("FROMCOSTCENTRECODE")+"' ";
					}
					if (!qry6.equals(""))
						{
							rs1=db.getRowset(qry6);
							while(rs1.next())
							{
								from=rs1.getString("mNAME");
							}
						}
					else
						{
							from=rs.getString("FROMOTHERS");                
						}
%>
					 <td	class="tablecell"> &nbsp;<%=from%></td>
					 <td	class="tablecell"> &nbsp;<%=rs.getString("REASON")%></td>
					 <td class="tablecell"> &nbsp;<%=rs.getString("ADVICETYPE")%></td>
					 <td class="tablecell"> &nbsp;<%=rs.getString("AMOUNT")%></td>
<%					 
					 if (rs.getString("STATUS").equals("Executed"))	
					 {
%>
					 <td class="tablecell"> &nbsp;<A title='Click here to explore Dr/Cr detail.' href='DetailSelfStudEmpDrCrAdvice.jsp?mMType=<%=mMemberType%>&amp;SID=<%=mSID%>' target='_new'>&nbsp;<%=rs.getString("STATUS")%></td>
<%
					 }
					 else
					 {
%>
					 <td class="tablecell"> &nbsp;<%=rs.getString("STATUS")%></td>
<%					  
					 }
%>
					</tr>	
<%
				}
%>
	</tbody>
	</table>
	</form>

	<table width="100%">
	 <tr>
<%	
				if(start!=1)
				{
%>
	<FORM METHOD=POST ACTION="SelfStudEmpDrCrAdvice.jsp">
		<INPUT TYPE="hidden" NAME="Paging" VALUE="substract">
		<input type="hidden" Name="MemberName" value="<%=mName%>">
		<input id="hidden" name="MemberCode" type=hidden value="<%=mDMemberCode%>">
		<input id="hidden" name="ProgramCode" type=hidden value="<%=mProg%>">
		<input id="hidden" name="BranchCode" type=hidden value="<%=mBranch%>">
		<input id="hidden" name="ProgramCode" type=hidden value="<%=mDesignation%>">
		<input id="hidden" name="BranchCode" type=hidden value="<%=mDepartment%>">
		<input type="hidden" Name="CurrentSem" value="<%=mSemPlusOne%>">
		<input type="hidden" Name="PrevDay" value="<%=PrevDay%>">
		<input type="hidden" Name="PrevMonth" value="<%=PrevMonth%>">
		<input type="hidden" Name="PrevYear" value="<%=PrevYear%>">
		<input type="hidden" Name="CurrentDay" value="<%=CurrentDay%>">
		<input type="hidden" Name="CurrentMonth" value="<%=CurrentMonth%>">
		<input type="hidden" Name="CurrentYear" value="<%=CurrentYear%>">
		<input type="hidden" Name="FromDate" value="<%=mFromDate%>">
		<input type="hidden" Name="ToDate" value="<%=mToDate%>">
		<INPUT TYPE="hidden" NAME="StartIndex" VALUE="<%=start%>">
		<INPUT TYPE="hidden" NAME="LastIndex" VALUE="<%=last%>">
		<td align="left"><INPUT TYPE="submit" value="Previous" class="submitbutton"></td>
	</FORM>
<%
				}
				if(last < count)
				{
%>		
	<FORM METHOD=POST ACTION="SelfStudEmpDrCrAdvice.jsp">
		<INPUT TYPE="hidden" NAME="Paging" VALUE="add">
		<input type="hidden" Name="MemberName" value="<%=mName%>">
		<input id="hidden" name="MemberCode" type=hidden value="<%=mDMemberCode%>">
		<input id="hidden" name="ProgramCode" type=hidden value="<%=mProg%>">
		<input id="hidden" name="BranchCode" type=hidden value="<%=mBranch%>">
		<input id="hidden" name="ProgramCode" type=hidden value="<%=mDesignation%>">
		<input id="hidden" name="BranchCode" type=hidden value="<%=mDepartment%>">
		<input type="hidden" Name="CurrentSem" value="<%=mSemPlusOne%>">
		<input type="hidden" Name="PrevDay" value="<%=PrevDay%>">
		<input type="hidden" Name="PrevMonth" value="<%=PrevMonth%>">
		<input type="hidden" Name="PrevYear" value="<%=PrevYear%>">
		<input type="hidden" Name="CurrentDay" value="<%=CurrentDay%>">
		<input type="hidden" Name="CurrentMonth" value="<%=CurrentMonth%>">
		<input type="hidden" Name="CurrentYear" value="<%=CurrentYear%>">
		<input type="hidden" Name="FromDate" value="<%=mFromDate%>">
		<input type="hidden" Name="ToDate" value="<%=mToDate%>">
		<INPUT TYPE="hidden" NAME="StartIndex" VALUE=<%=start%>>
		<INPUT TYPE="hidden" NAME="LastIndex" VALUE=<%=last%>>
		<td align="right"><INPUT TYPE="submit" value="Next" class="submitbutton"></td>
	</FORM>
<%
				}
%>
	  </tr>
	</table>

	<script type="text/javascript">
	var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString"]);
	</script>

	<table width=100%  rules=groups cellspacing=1 cellpadding=1 align=center border=0>
<%
		qry4="select nvl(SUM(nvl(AMOUNT,0)),0) AMOUNT from SLDRCRADVICE where ADVICETYPE = 'D' AND ADVICEDATE  between to_date('"+mFromDate+"','dd/mm/yyyy') AND to_date('"+mToDate+"','dd/mm/yyyy')";
		qry4=qry4+" and COMPANYCODE='"+mComp+"' And INSTITUTECODE='"+mINSTITUTECODE+"' And SLTYPE='"+mMemberType+"' and SLCODE ='"+mMemberID+"'";

		rs=db.getRowset(qry4);

			while(rs.next())
				{
%>
	<tr>
	<td><font color=black face=arial size=2> 
		<STRONG>Debit Amount:&nbsp;	</STRONG></font><%=rs.getString("AMOUNT")%>
<%				dam=rs.getString("AMOUNT");
					dAmount=Integer.parseInt(dam);
				}
%>
	</td>
	</tr>
<%
		qry5="select nvl(SUM(nvl(AMOUNT,0)),0) AMOUNT from SLDRCRADVICE where ADVICETYPE = 'C' AND ADVICEDATE  between to_date('"+mFromDate+"','dd/mm/yyyy') AND to_date('"+mToDate+"','dd/mm/yyyy')";
		qry5=qry5+" and COMPANYCODE='"+mComp+"' And INSTITUTECODE='"+mINSTITUTECODE+"' And SLTYPE='"+mMemberType+"' and SLCODE ='"+mMemberID+"'";

		rs=db.getRowset(qry5);

			while(rs.next())
				{
%>
	<tr>
	<td><font color=black face=arial size=2>														<STRONG>Credit Amount:&nbsp; </STRONG></font><%=rs.getString("AMOUNT")%>
<%
					cam=rs.getString("AMOUNT");
					cAmount=Integer.parseInt(cam);
				}
%>
	</td>
	</tr>

	<tr>
	<td><font color=black face=arial size=2>
		<STRONG>Balance:&nbsp;
		</STRONG></font>
<%
					diff = dAmount-cAmount;
					out.println(diff);
%>
	<STRONG>(
<%
				if(dAmount>cAmount)
				{
					out.print(" Debit");
				}
				else
				{
					out.print(" Credit");
				}
%>
	)</STRONG>
	</td>
	</tr>
	</table>
<%
		    }
		}//3
	else
		{

		//-----------------------------------------------------
		//--------------- Enable Security Links ---------------  
		//-----------------------------------------------------
		
		//********** closing of Webkiosk Showlink if***********
%>
		<br>
		<font color=red>
		<h3>	<br><img src='../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
		<P>	This page is not authorized/available to you.
		<br>For assistance, contact your network support team. 
		</font>	<br>	<br>	<br>	<br> 
<%
		}
	}//2
	else
	{
		out.print("<br><img src='../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}    
}//1
catch(Exception e)
{
	//out.println(e.getMessage());
}
%>
</body>
</html>