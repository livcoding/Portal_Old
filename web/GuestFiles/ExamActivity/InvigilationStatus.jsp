<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rsDate=null,rs=null;
ResultSet rs1=null;
ResultSet rsTmp=null;
ResultSet rs2=null;
String QryExam="";
GlobalFunctions gb =new GlobalFunctions();
String qry="";
String qry2="";
String qry1="",mLTP="";
long mSNo=0;
long mTransDay =0;
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mFactID="",mDateFrom="",mDateTo="",mREmarks="",mEntryby="",mFacid="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="",mFac="",mEC="",mEF="";
String mMemberName="";
String mInst="";
String mComp="";
String mAprStatus="";
String mExam="",mSubject="",mexam="",mSubj="",mcolor="",mCode="",mES="",mSubj1="";
String mSection="",mSubsection="",mName1="",mName2="",mName3="",mName4="",mName5="";
String mSExam="",mFaculty="",mFaculty1="";
String mSES="";
String qryexam="",qrysubj="",qrysec="";
String mPrn="N";
String mSrcType="";
int mDiffInDays=0, mRights=0;
String Heading="";

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
if (request.getParameter("SrcType")==null)
{
	mSrcType="";
}
else
{
	mSrcType=request.getParameter("SrcType").toString().trim();
}

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Leave/Time Preference On Invigilation Duty ] </TITLE>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
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
</script>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">
function ChangeOptions(Exam,DataCombo,Faculty,SrcType1)
{
	if(SrcType1!='I')
	{
	removeAllOptions(Faculty);
	var optn = document.createElement("OPTION");
	optn.text='ALL';
	optn.value='ALL';
	Faculty.options.add(optn);
	for(i=0;i<DataCombo.options.length;i++)
      {	
		var v1;
		var pos;
		var exam;
		var eid;
		var len;
		var otext;
		var v1=DataCombo.options(i).value;
		len= v1.length;
		pos=v1.indexOf('***');
		exam=v1.substring(0,pos);
		eid=v1.substring(pos+3,len);
		if (exam==Exam)
		{ 	
			var optn = document.createElement("OPTION");
			optn.text=DataCombo.options(i).text;
			optn.value=eid;
			Faculty.options.add(optn);
		}
	}
	}
  }
  function removeAllOptions(selectbox)
  {
  var i;
  for(i=selectbox.options.length-1;i>=0;i--)
  {
	selectbox.remove(i);
  }
}
</SCRIPT>	

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

</head>
<body aLink=#ff00ff bgcolor='#fce9c5' rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
try
{
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

		if(mSrcType.equals("A"))
		{
			mRights=93;
			Heading="Admin.";	
		}
		else if(mSrcType.equals("H"))
		{
			mRights=94;
			Heading="DepartmentWise";	
		}
		else
		{
			mRights=95;
			Heading="Individual Member";	
		}
	
		qry="Select WEBKIOSK.ShowLink('"+mRights+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	  	{
			//-----------------------------
			//-- Enable Security Page Level  
			//-----------------------------
			%>
			<form name="frm"  method="get" >
			<input id="x" name="x" type=hidden>
			<table id=id1 width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
			<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Invigilation Duty Time Preference Status (<%=Heading%>)</b></TD>
			</font></td></tr>
			</TABLE>
			<table id=idd2 cellpadding=1 cellspacing=0 align=center rules=groups border=2>
			<!--Institute****-->
			<INPUT Type="hidden" Name=SrcType id=SrcType Value=<%=mSrcType%>>
			<Input Type=hidden name=InstCode Value=<%=mInst%>>
<!--*********Exam**********-->
			<tr><td><FONT color=black face=Arial size=2><b>&nbsp;Exam Code</b></FONT>
			<%
			try
			{ 
				if(mSrcType.equals("A"))
				{
					qry="Select Distinct nvl(EXAMCODE,' ') Exam from V#INVIGILATIONTIMEPREF Where InstituteCode='"+mInst+"'";
					qry=qry+" order by Exam";
				}
				else if(mSrcType.equals("H"))
				{
					qry="Select Distinct nvl(EXAMCODE,' ') Exam from V#INVIGILATIONTIMEPREF  Where InstituteCode='"+mInst+"'";
					qry=qry+" And INVIGILATORID in (select Employeeid ";
					qry=qry+" from EMPLOYEEMASTER where DEPARTMENTCODE in (select DEPARTMENTCODE from ";
					qry=qry+" hodlist where employeeid='"+mDMemberID+"' and nvl(deactive,'N')='N') )";
					qry=qry+" order by Exam Desc";
				}
				else
				{
					qry="Select Distinct nvl(EXAMCODE,' ') Exam from V#INVIGILATIONTIMEPREF where  InstituteCode='"+mInst+"' And INVIGILATORID='"+mDMemberID+"' ";
					qry=qry+" order by Exam Desc";
				}
				//out.print(qry);
				rs=db.getRowset(qry);
				if (request.getParameter("x")==null) 
				{
					%>
					<Select Name=Exam tabindex="0" id="Exam" style="WIDTH: 120px" onclick="ChangeOptions(Exam.value,DataCombo,Faculty,SrcType.value);" onChange="ChangeOptions(Exam.value,DataCombo,Faculty,SrcType.value);">	
					<%
					while(rs.next())
					{
						mExam=rs.getString("Exam");
						if(mexam.equals(""))
 						{
							mexam=mExam;
							qryexam=mExam;
							QryExam=mExam;
							%>
							<OPTION Selected Value =<%=mExam%>><%=rs.getString("Exam")%></option>
							<%
						}
						else
						{
							%>
							<OPTION Value =<%=mExam%>><%=rs.getString("Exam")%></option>
							<%
						}
					}
					%>
					</select>
					<%
				}
				else
				{
					%>
					<select name=Exam tabindex="0" id="Exam" style="WIDTH: 120px" onclick="ChangeOptions(Exam.value,DataCombo,Faculty,SrcType.value);" onChange="ChangeOptions(Exam.value,DataCombo,Faculty,SrcType.value);">	
					<%
					while(rs.next())
					{
						mExam=rs.getString("Exam");
						if(mExam.equals(request.getParameter("Exam").toString().trim()))
 						{
							mexam=mExam;
							qryexam=mExam;
							QryExam=mExam;
							%>
							<OPTION selected Value =<%=mExam%>><%=rs.getString("Exam")%></option>
							<%
					     	}
		     				else
					      {
							%>
		      				<OPTION Value =<%=mExam%>><%=rs.getString("Exam")%></option>
					      	<%
					   	}
					}
					%>
					</select>
				  	<%
				 }
			}    
			catch(Exception e)
			{
				// out.println(qry);
			}
//***********************DataComboFac*************
			try
			{
				if(mSrcType.equals("A"))
				{
					qry=" Select Distinct  A.INVIGILATORID FacultyID, nvl(A.EMPLOYEENAME,' ') EmployeeName,A.examcode exam ";
					qry=qry+" from V#INVIGILATIONTIMEPREF A where A.InstituteCode='"+mInst+"' order by examcode,facultyid ";
				}
				else if(mSrcType.equals("H"))
				{
					qry=" Select Distinct A.INVIGILATORID FacultyID, nvl(A.EMPLOYEENAME,' ') EmployeeName,A.examcode exam ";
					qry=qry+" from V#INVIGILATIONTIMEPREF A where  A.InstituteCode='"+mInst+"' And A.INVIGILATORID in (select Employeeid ";
					qry=qry+" from EMPLOYEEMASTER where DEPARTMENTCODE in (select DEPARTMENTCODE from ";
					qry=qry+" hodlist where employeeid='"+mDMemberID+"' and nvl(deactive,'N')='N'))  order by examcode,facultyid ";
				}
				else
				{
					qry=" Select Distinct A.INVIGILATORID FacultyID, nvl(A.EMPLOYEENAME,' ') EmployeeName,A.examcode exam ";
					qry=qry+" from V#INVIGILATIONTIMEPREF A where  A.InstituteCode='"+mInst+"' And A.INVIGILATORID='"+mDMemberID+"' ";
				}
				//out.print(qry);
				rs=db.getRowset(qry);
				%>
				<select name=DataCombo tabindex="1" id="DataCombo" style="WIDTH:0px">
				<%
				if (request.getParameter("x")==null) 
				{
					while(rs.next())
					{
						mFaculty1=rs.getString("FacultyID");
						mEC=rs.getString("exam");
 						mEF=mEC+"***"+mFaculty1; 	
						%>
						<OPTION Value ='<%=mEF%>'><%=rs.getString("EmployeeName")%></option>
						<%
					}
				}
				else
				{
					while(rs.next())
					{
						mFaculty1=rs.getString("FacultyID");
						mEC=rs.getString("exam");
			 			mEF=mEC+"***"+mFaculty1; 	
						if (mEF.equals(request.getParameter("DataCombo").toString().trim()))
						{
							%>
							<OPTION selected Value ='<%=mEF%>'><%=rs.getString("EmployeeName")%></option>
							<%
						}
						else
						{
							%>
				      		<OPTION Value ='<%=mEF%>'><%=rs.getString("EmployeeName")%></option>
					     		<%
					   	}
					}
				}
			}
			catch(Exception e)
			{
				//out.print("error occured"+qry);	
			}	
			%>
			</select>
<!-----***************Faculty**********************-->
			<FONT color=black face=Arial size=2>&nbsp; &nbsp; &nbsp;<b>Invigilator &nbsp;</b></FONT>
			<%
			if(mSrcType.equals("A"))
			{
				qry=" Select Distinct  A.INVIGILATORID FacultyID, nvl(A.EMPLOYEENAME,' ') EmployeeName ";
				qry=qry+" from V#INVIGILATIONTIMEPREF A where  A.InstituteCode='"+mInst+"' And EXAMCODE='"+qryexam+"' order by EmployeeName";
			}
			else if(mSrcType.equals("H"))
			{
				qry=" Select Distinct  A.INVIGILATORID FacultyID, nvl(A.EMPLOYEENAME,' ') EmployeeName ";
				qry=qry+" from V#INVIGILATIONTIMEPREF A where EXAMCODE='"+qryexam+"' and  A.InstituteCode='"+mInst+"' And ";
				qry=qry+" A.INVIGILATORID in ((select Employeeid from EMPLOYEEMASTER where DEPARTMENTCODE in (select DEPARTMENTCODE from ";
				qry=qry+" hodlist where employeeid='"+mDMemberID+"' and nvl(deactive,'N')='N')) union (select STAFFID from OTHERSTAFFLOADTAGGING where nvl(deactive,'N')='N')) order by EmployeeName";
			}
			else
			{
				qry=" Select Distinct  A.INVIGILATORID FacultyID, nvl(A.EMPLOYEENAME,' ') EmployeeName ";
				qry=qry+" from V#INVIGILATIONTIMEPREF A where  A.InstituteCode='"+mInst+"' And A.INVIGILATORID='"+mDMemberID+"' ";
				qry=qry+" AND EXAMCODE='"+qryexam+"' order by EmployeeName";
			} 
			//out.print(qry);
			rs=db.getRowset(qry);
			%>
			<select name=Faculty tabindex="1" id="Faculty" style="WIDTH: 330px">
			<% 
			if (request.getParameter("x")==null) 
			{
				if(!mSrcType.equals("I"))
				{
					%>
					<option value='ALL' selected>ALL</option>
					<%
				}
				while(rs.next())
				{
					if(mFaculty.equals(""))
					{
						mFaculty=rs.getString("FacultyID");
						%>
						<OPTION Value ='<%=mFaculty%>'><%=rs.getString("EmployeeName")%></option>
						<%
					}
					else
					{
 						%>
						<OPTION Value ='<%=rs.getString("FacultyID")%>'><%=rs.getString("EmployeeName")%></option>
						<%
					}
				}
			}
			else
			{
				if(!mSrcType.equals("I"))
				{
					if(request.getParameter("Faculty").equals("ALL"))
					{
						%>
						<option value='ALL' selected>ALL</option>				
						<%	
					}
					else
					{
						%>
						<option value='ALL'>ALL</option>				
						<%
					}		
				}
				while(rs.next())
				{
					mFaculty=rs.getString("FacultyID");
					if (mFaculty.equals(request.getParameter("Faculty").toString().trim()))
					{			
						%>
						<OPTION selected Value ='<%=mFaculty%>'><%=rs.getString("EmployeeName")%></option>
						<%
					}
					else
					{
						%>
			      		<OPTION Value ='<%=mFaculty%>'><%=rs.getString("EmployeeName")%></option>
			     			<%			
				   	}
				}
			}
			%>
			</select>
			</td></tr>
			<tr>	
			<%
			qry1="select to_char(Sysdate,'dd-MM-yyyy') CurDate from dual";
			rsDate=db.getRowset(qry1);
			String mSysDate="";
			if(rsDate.next())
				mSysDate=rsDate.getString(1);

			if(request.getParameter("TXT1")==null||request.getParameter("TXT1").equals(""))
				mDateFrom=mSysDate;	
			else
				mDateFrom=request.getParameter("TXT1").toString().trim();	

			if(request.getParameter("TXT2")==null||request.getParameter("TXT2").equals(""))
				mDateTo=mSysDate;
			else
				mDateTo=request.getParameter("TXT2").toString().trim();

			%>
			<td><FONT color=black face=Arial size=2>&nbsp;<b>Leave/Time Pref. on Invigilation Duty From 
			<input Name=TXT1 Id=TXT1 Type=text maxlength=10 size=10 value='<%=mDateFrom%>' READONLY><a href="javascript:NewCal('TXT1','ddmmyyyy')"><img src="../images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>
			 to 
			<input Name=TXT2 Name=TXT2 Type=text Value='<%=mDateTo%>' maxlength=10 size=10 READONLY><a href="javascript:NewCal('TXT2','ddmmyyyy')"><img src="../images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>
			</b></FONT>
			<font color=darkgreen size=2><INPUT Type="submit" Value="Show/Refresh">
			</font></td></tr>
			</table>
			<td></tr>
			</table>
			</form>
			<%	
			if(request.getParameter("x")!=null)
			{
				mExam=request.getParameter("Exam").toString().trim();

				if(request.getParameter("Faculty")==null||request.getParameter("Faculty").equals(""))
					mFactID=mFaculty;
				else
					mFactID=request.getParameter("Faculty").toString().trim();	

				if(request.getParameter("TXT1")==null||request.getParameter("TXT1").equals(""))
					mDateFrom=mSysDate;	
				else
					mDateFrom=request.getParameter("TXT1").toString().trim();	

				if(request.getParameter("TXT2")==null||request.getParameter("TXT2").equals(""))
					mDateTo=mSysDate;
				else
			           	mDateTo=request.getParameter("TXT2").toString().trim();
			}

				qry="SELECT to_date('"+mDateTo+"','dd-mm-yyyy')-to_date('"+mDateFrom+"','dd-mm-yyyy') DiffInDays from dual";
				//out.print(qry);
				rs=db.getRowset(qry);
				if(rs.next())
					mDiffInDays=rs.getInt("DiffInDays");

				if(mDiffInDays>=0)
				{
					// Show /Refresh data here
					%>
					<p Align=center><font color=darkbrown size2 face='verdana'><b>Invigilation  Duty Leave/Holiday Request Status</b></font>
					<table bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=group/s topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center >	
					<thead>
					<tr bgcolor="#ff8c00">
					<td nowrap Title="Click to Sort on SlNo" align=center><font color="White"><b>Sr No</b></font></td>
					<td nowrap Title="Click to Sort on Invigilator"><font color="White"><b>Invigilator Name</b></font></td>
					<td nowrap Title="Click to Sort on Date"><font color="White"><b>Period of Leave/Time Preference</b></font></td>	
					<td nowrap Title="Click to Sort on Approved"><font color="White"><b>Approved</b></font></td>	
					<td nowrap Title="Click to Sort on Remarks"><font color="White"><b>Remarks</b></font></td>
					<td nowrap Title="Click to Sort on Remarks"><font color="White"><b>Entry By</b></font></td>
					</tr>
					</thead>
					<tbody>
					<%
					if(mSrcType.equals("A"))
					{
						qry="Select Distinct A.ENTRYBY EntryBy, A.INVIGILATORID FacultyID,to_char(A.PREFROMDATE,'dd-mm-yyyy') ||' to '||to_char(A.PRETODATE,'dd-mm-yyyy') || '( '||decode(A.DUTYHOLIDAY,'Y','Full Day Leave/Holiday',to_char(A.PREFFROMTIME,'hh:mi PM')||' to '|| to_char(A.PRETOTIME,'hh:mi PM'))||' )' Tim , ";	qry=qry+" nvl(A.REMARKS,' ') REMARKS, nvl(A.APPROVED,'N')APPROVED,nvl(A.EMPLOYEENAME,' ') EmployeeName"; 
						qry=qry+" from V#INVIGILATIONTIMEPREF A where A.INSTITUTECODE='"+mInst+"'  and  A.INVIGILATORID=decode('"+mFactID+"','ALL',A.INVIGILATORID,'"+mFactID+"')"; 
						qry=qry+" and A.EXAMCODE='"+mExam+"' and nvl(A.DEACTIVE,'N')='N' and ";
						qry=qry+" (trunc(A.PREFROMDATE) BETWEEN trunc(to_date('"+mDateFrom+"','dd-mm-yyyy')) ";
						qry=qry+" and trunc(to_date('"+mDateTo+"','dd-mm-yyyy')) ";
						qry=qry+" or trunc(A.PRETODATE) BETWEEN trunc(to_date('"+mDateFrom+"','dd-mm-yyyy')) ";
						qry=qry+" and trunc(to_date('"+mDateTo+"','dd-mm-yyyy')))";
					}
					else if(mSrcType.equals("H"))
					{
						qry="Select Distinct A.ENTRYBY EntryBy,A.INVIGILATORID FacultyID,to_char(A.PREFROMDATE,'dd-mm-yyyy') ||' to '||to_char(A.PRETODATE,'dd-mm-yyyy') || '( '||decode(A.DUTYHOLIDAY,'Y','Full Day Leave/Holiday',to_char(A.PREFFROMTIME,'hh:mi PM')||' to '|| to_char(A.PRETOTIME,'hh:mi PM'))||' )' Tim , ";
						qry=qry+" nvl(A.REMARKS,' ') REMARKS, nvl(A.APPROVED,'N')APPROVED,nvl(A.EMPLOYEENAME,' ') EmployeeName"; 
						qry=qry+" from V#INVIGILATIONTIMEPREF A where A.INSTITUTECODE='"+mInst+"'";
						qry=qry+" and A.INVIGILATORID =decode('"+mFactID+"','ALL',A.INVIGILATORID,'"+mFactID+"') and A.EXAMCODE='"+mExam+"'"; 
						qry=qry+" and A.INVIGILATORID in ((select Employeeid ";
						qry=qry+" from EMPLOYEEMASTER where DEPARTMENTCODE in (select DEPARTMENTCODE from ";
						qry=qry+" hodlist where employeeid='"+mDMemberID+"' and nvl(deactive,'N')='N')) ";
						qry=qry+" union (select STAFFID from OTHERSTAFFLOADTAGGING where nvl(deactive,'N')='N')) and nvl(A.DEACTIVE,'N')='N' and ";
						qry=qry+" (trunc(A.PREFROMDATE) BETWEEN trunc(to_date('"+mDateFrom+"','dd-mm-yyyy')) ";
						qry=qry+" and trunc(to_date('"+mDateTo+"','dd-mm-yyyy')) ";
						qry=qry+" or trunc(A.PRETODATE) BETWEEN trunc(to_date('"+mDateFrom+"','dd-mm-yyyy')) ";
						qry=qry+" and trunc(to_date('"+mDateTo+"','dd-mm-yyyy')))";
					}
					else
					{
						qry="Select Distinct A.ENTRYBY EntryBy,A.INVIGILATORID FacultyID,to_char(A.PREFROMDATE,'dd-mm-yyyy') ||' to '||to_char(A.PRETODATE,'dd-mm-yyyy') || '( '||decode(A.DUTYHOLIDAY,'Y','Full Day Leave/Holiday',to_char(A.PREFFROMTIME,'hh:mi PM')||' to '|| to_char(A.PRETOTIME,'hh:mi PM'))||' )' Tim , ";
						qry=qry+" nvl(A.REMARKS,' ') REMARKS, nvl(A.APPROVED,'N')APPROVED,nvl(A.EMPLOYEENAME,' ') EmployeeName"; 
						qry=qry+" from V#INVIGILATIONTIMEPREF A, EMPLOYEEMASTER B where A.INSTITUTECODE='"+mInst+"'";
					      qry=qry+" and  A.INVIGILATORID ='"+mDMemberID+"' and A.EXAMCODE='"+mExam+"'"; 
						qry=qry+" and nvl(A.DEACTIVE,'N')='N' and A.COMPANYCODE=B.COMPANYCODE AND A.INVIGILATORID=B.EMPLOYEEID";
						qry=qry+" (trunc(A.PREFROMDATE) BETWEEN trunc(to_date('"+mDateFrom+"','dd-mm-yyyy')) ";
						qry=qry+" and trunc(to_date('"+mDateTo+"','dd-mm-yyyy')) ";
					      qry=qry+" or trunc(A.PRETODATE) BETWEEN trunc(to_date('"+mDateFrom+"','dd-mm-yyyy')) ";
					      qry=qry+" and trunc(to_date('"+mDateTo+"','dd-mm-yyyy')))";
					}
					//out.print(qry);
					rs1=db.getRowset(qry);	
			 		int Ctr=0;
					while(rs1.next())
					{
						Ctr++;
						mcolor="Black";
						%>
						<tr>
						<td align=center><font color=<%=mcolor%>><%=Ctr%>.</font></td>
						<td nowrap><font color=<%=mcolor%>><%=rs1.getString("EmployeeName")%></font></td>
						<td nowrap><font color=<%=mcolor%>><%=rs1.getString("Tim")%></font></td>
						<%
						if(rs1.getString("APPROVED").equals("Y"))
							mAprStatus="Yes";
						else
							mAprStatus="No";		
						%>
						<td align=center><font color=<%=mcolor%>><%=mAprStatus%></font></td>	
						<td><font color=<%=mcolor%>>&nbsp;<%=rs1.getString("REMARKS")%></font></td>
						<%
						mEntryby=rs1.getString("EntryBy");
						mFacid=rs1.getString("FacultyID");
						if(mEntryby.equals(mFacid))
						{
							%>
							<td nowrap><font color=<%=mcolor%>>&nbsp;SELF</font></td>	
							<%	
						}
						else
						{
							qry="select employeename from employeemaster where employeeid='"+mEntryby+"' And CompanyCode='"+mComp+"'";
							rs=db.getRowset(qry);	
							if(rs.next())
							{
								%>
								<td nowrap><font color=<%=mcolor%>>&nbsp;<%=rs.getString("employeename")%></font></td>	
								<%
							}
							else		
							{
								qry="select studentname from studentmaster where studentid='"+mEntryby+"' And InstituteCode='"+mInst+"'";
								rs=db.getRowset(qry);	
								if(rs.next())
								{
									%>
									<td nowrap><font color=<%=mcolor%>>&nbsp;<%=rs.getString("studentname")%></font></td>	
									<%
								}
								else		
								{
									qry2="select nvl(GuestName,' ')GuestName from Guest where GuestID='"+mEntryby+"' And CompanyCode='"+mInst+"'";
									rs=db.getRowset(qry2);	
									if(rs.next())
									{
										%>
										<td nowrap><font color=<%=mcolor%>>&nbsp;<%=rs.getString("GuestName")%></font></td>	
										<%
									}
								}
							}
						}
						%>
						</tr>		
						<%          						
					 }	
					%>
					</tbody>
					</table>	
					<script type="text/javascript">
					var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString"]);
					</script>
					<%
				}	// Validate Date
				else
				{
					out.print("<br><img src='../../Images/Error1.jpg'>");
					out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Valid Date Format is DD-MM-YYYY only</font> <br>");
				}

			//-----------------------------
			//---Enable Security Page Level  
			//-----------------------------
		}
		else
		{
			%>
			<br>
			<font color=red>
			<h3>	<br><img src='../../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
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
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to Continue</font> <br>");
	}      
}
catch(Exception e)
{
}
%>
</body>
</html>