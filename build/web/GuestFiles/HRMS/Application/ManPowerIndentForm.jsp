<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../../CommonFiles/ExceptionHandler.jsp" %>
<%@ page import="java.util.ArrayList,java.util.Iterator" %>
<%
DBHandler db=new DBHandler();
ResultSet rs=null,rsi=null;
GlobalFunctions gb =new GlobalFunctions();
OLTEncryption enc=new OLTEncryption();
String qry="";
String mComp="JIIT";
int mSno=0,mIntNo=100,flag=0;
String mEmployeeName="",mEmployeeCode="",mDepartment="";
String mMemberID="", mDMemberID="",mIndentDate="",mDesignation="";
String mMemberType="", mDMemberType="", mMemberCode="", mDMemberCode="";
String mMemberName="", mDept="", mDegs="",mDesignation1="";
String mInstitute="",mInst="",mtext="";
String mDate1="", mDate2="", mCurrDate="",mEmpCategory="";
String mQualification="",mCategory="",mEmployeeType="";
String mIndentReferenceNo="",mRequireDate="",mRequireManPower="";
String mRequireExp="",mDepartment1="",mStatus="";
String mPlacePosting="",mJobDiscription="",mRemarks="";
String mAgeFrom="",mAgeTo="",mDepartmentCode="";
String mQuliRemarks="",mGender="",mCategory1="",mEmpType="";
String mIndentStatus="P",mDesignationCode="";
ArrayList mQaliArrayList=new ArrayList();
int mSlno=0,mVlaidation=0,mStudent=0,mFaculty=0,mRequiredFaculty=0,count=0;
qry="select to_Char(Sysdate,'dd-mm-yyyy') date1  from dual";
rs=db.getRowset(qry);
rs.next();
mCurrDate=rs.getString("date1");
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
<TITLE>#### <%=mHead%> [ Man Power Indent] </TITLE>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="../css/sortabletable.css" />
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
	function QuestionTextChanged() 
	{
		if(document.frm.Remarks.value.length > 300) 
		{
			document.frm.Remarks.value = document.frm.Remarks.value.substr(0,300); 
			alert("You can not enter the remarks more than 300 characters");
			return false;
		}
	} 
</script>
<STYLE>input {font-size:13px;}</STYLE>
</HEAD>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
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
		qry="Select WEBKIOSK.ShowLink('141','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	    RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
			// For Log Entry Purpose
			//--------------------------------------
			String mLogEntryMemberID="",mLogEntryMemberType="";
			if (session.getAttribute("LogEntryMemberID")==null || session.getAttribute("LogEntryMemberID").toString().trim().equals(""))
				mLogEntryMemberID="";
			else
				mLogEntryMemberID=session.getAttribute("LogEntryMemberID").toString().trim();
			if (session.getAttribute("LogEntryMemberType")==null || session.getAttribute("LogEntryMemberType").toString().trim().equals(""))
				mLogEntryMemberType="";
			else
				mLogEntryMemberType=session.getAttribute("LogEntryMemberType").toString().trim();
			if (mLogEntryMemberType.equals(""))
				mLogEntryMemberType=mMemberType;
			if (mLogEntryMemberID.equals(""))
				mLogEntryMemberID=mMemberID;
			if (!mLogEntryMemberType.equals(""))
				mLogEntryMemberType=enc.decode(mLogEntryMemberType);
			if (!mLogEntryMemberID.equals(""))
				mLogEntryMemberID=enc.decode(mLogEntryMemberID);
			//--------------------------------------
			%>
			<form name="frm"  method="post" action="ManPowerIndentAction.jsp">
			<input id="x" name="x" type=hidden>
			<center>
			<table align=center width="100%" bottommargin=0 topmargin=0>
			<tr>
				<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4>Man Power Indent</FONT></u></b></td>
			</tr>
			</table>
			</center>
			<%	
			qry="select distinct nvl(institutecode,' ')IC from INSTITUTEMASTER where nvl(DEACTIVE,'N')='N' ";
			rsi=db.getRowset(qry);
			while(rsi.next())
				mInst=rsi.getString("IC");
			try
			{
				qry="select distinct B.DEPARTMENTCODE DEPARTMENTCODE,C.DESIGNATIONCODE DESIGNATIONCODE,nvl(A.EMPLOYEENAME,' ')EMPLOYEENAME, nvl(A.EMPLOYEECODE,' ')EMPLOYEECODE ,B.DEPARTMENT DEPARTMENT,C.DESIGNATION DESIGNATION from EMPLOYEEMASTER A,DEPARTMENTMASTER B, DESIGNATIONMASTER C where A.employeeid='"+mChkMemID+"' and A.DEPARTMENTCODE=B.DEPARTMENTCODE and A.DESIGNATIONCODE=C.DESIGNATIONCODE and nvl(A.DEACTIVE,'N')='N' and nvl(B.DEACTIVE,'N')='N' and nvl(C.DEACTIVE,'N')='N' ";
				//out.println(qry);
				rs=db.getRowset(qry);
				if(rs.next())
				{
					mEmployeeName=rs.getString("EMPLOYEENAME");
					mEmployeeCode=rs.getString("EMPLOYEECODE");
					mDepartment1=rs.getString("DEPARTMENT");
					mDesignation1=rs.getString("DESIGNATION");
					mDesignationCode=rs.getString("DESIGNATIONCODE");
					mDepartmentCode=rs.getString("DEPARTMENTCODE");
				}
				qry="Select count(Studentid)Studentid from STUDENTMASTER where (INSTITUTECODE, ACADEMICYEAR, PROGRAMCODE, branchcode) in (Select INSTITUTECODE, ACADEMICYEAR, PROGRAMCODE, SECTIONBRANCH from BRANCHDEPTTAGGING where DEPARTMENTCODE='"+mDepartmentCode+"')";
				//out.println(qry);
				rs=db.getRowset(qry);
				if(rs.next())
					mStudent=rs.getInt("Studentid");
				qry="Select count(EMPLOYEEID)EMPLOYEEID from EMPLOYEEMASTER Where DEPARTMENTCODE='"+mDepartmentCode+"' and nvl(Deactive,' ')<>'Y'";
				//out.println(qry);
				rs=db.getRowset(qry);
				if(rs.next())
					mFaculty=rs.getInt("EMPLOYEEID");
				mRequiredFaculty=(mStudent/15)-mFaculty;
				if(mRequiredFaculty<0)
					mRequiredFaculty=0;
			}catch(Exception e)
				{	 /*out.println("Exception e:-"+e);*/	}
			%>
			<script>
				function fun()
				{
					var DeptCode=document.frm.DeptCode.value;										
					window.open('CaluclateRequFaculty.jsp?DeptCode='+DeptCode,'','width=350,height=175,top=160,left=250');
				}
			</script>
			<center>
			<table width=99%>
			<tr>
				<td nowrap>
					<font face="arial" size="2"><b>No. of Student : </b></font> <%=mStudent%>
					<font face="arial" size="2"><b>&nbsp; &nbsp; &nbsp;No. of Faculty : </b></font> <%=mFaculty%>
					<font face="arial" size="2"><b>&nbsp; &nbsp; &nbsp;Req. Additional Faculty : </b></font> <%=mRequiredFaculty%>
				</td>
				<td nowrap>
					<table border=1 cellpadding="0" cellspacing="0"><tr><td nowrap align="center"><font face="arial" size="2"><b><a title="Calculate Required Faculty" onClick="fun();"  style="FONT-WEIGHT:; FONT-SIZE:; FLOAT: none; WIDTH: 160px; HEIGHT: 19px; FONT-VARIANT: normal; cursor:hand; border-width:0 ; filter:progid:DXImageTransform.Microsoft.Gradient(startColorStr='#ff8c00', endColorStr='White', gradientType='0'">Calculate Req. Faculty</a></td></tr></table>
					<input type="hidden" value=<%=mDepartmentCode%> name="DeptCode">
				</td>
			</tr> 
			</table>
			</center>
			<center>
			<table align=center cellpadding="0" cellspacing="0" rules="groups"  border="1" width=99%>
			<tr>
				<td colspan=8><font color="#00008b" face=times new roman size=2><b><%=mEmployeeName%> </b></font>
				<b><FONT face=Arial size=2> Designation </font> </B>
				<font color="#00008b" face=times new roman><b><%=GlobalFunctions.toTtitleCase(mDesignation1)%> </b></font>
				<b><FONT face=Arial size=2> Department </font></B><font color="#00008b" face=times new roman><b><%=GlobalFunctions.toTtitleCase(mDepartment1)%></b></font>
				<hr></td>
			</tr>
			<tr>	
				<td nowrap align=left><b><FONT face=Arial size=2>Indent Reference No.</font></B></td>
				<%					
					if(request.getParameter("IndentReferenceNo")==null)
						mIndentReferenceNo="";
					else
						mIndentReferenceNo=request.getParameter("IndentReferenceNo");
				%>
				<td><input type="text" name="IndentReferenceNo" maxlength="30" size=16 value="<%=mIndentReferenceNo%>" onkeydown="if(event.keyCode==13){event.keyCode=13;return event.keyCode}" ><font size=2 color=red>*</font></td>
				<td><b><FONT face=Arial size=2>Indent Date</font></td>
				<%
					if (request.getParameter("TXT1")!=null)
					{
						mDate1=request.getParameter("TXT1").toString().trim();
						mDate2=request.getParameter("TXT2").toString().trim();
					}
					else
					{
						mDate1=mCurrDate;
						mDate2=mCurrDate;
					}
				%>
				<td><input Name=TXT1 Id=TXT1 Type=text maxlength=10 size=8 value='<%=mDate1%>' READONLY onkeydown="if(event.keyCode==13){event.keyCode=13;return event.keyCode}" ><a href="javascript:NewCal('TXT1','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date" onkeydown="if(event.keyCode==13){event.keyCode=13;return event.keyCode}" ></a></td>
				<td><b><FONT face=Arial size=2>Req. Date</font></b></td>
				<td><input Name=TXT2 Id=TXT2 Type=text maxlength=10 size=8 value='<%=mDate2%>' READONLY onkeydown="if(event.keyCode==13){event.keyCode=13;return event.keyCode}" ><a href="javascript:NewCal('TXT2','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date" onkeydown="if(event.keyCode==13){event.keyCode=13;return event.keyCode}" ></a></td>
			</tr>
			<tr>	
				<td align=left><b><FONT face=Arial size=2>Require Man Power </font></B></td>
				<%
					if(request.getParameter("RequireManPower")==null)
						mRequireManPower="1";
					else
						mRequireManPower=request.getParameter("RequireManPower");
				%>
				<td><input type="text" name="RequireManPower" maxlength="3" size="16" value="<%=mRequireManPower%>" onkeydown="if(event.keyCode==13){event.keyCode=13;return event.keyCode}" </td>
				<td><b><FONT face=Arial size=2>Experience </font></b></td>
				<%
					if(request.getParameter("RequireExp")==null)
						mRequireExp="0.0";
					else
						mRequireExp=request.getParameter("RequireExp");
				%>
				<td><input type="text" name="RequireExp" maxlength="4" size="8" value="<%=mRequireExp%>" onkeydown="if(event.keyCode==13){event.keyCode=13;return event.keyCode}" ></td>
				<td><b><FONT face=Arial size=2>Age From </font></B></td>
				<%
					if(request.getParameter("AgeFrom")==null)
						mAgeFrom="18";
					else
						mAgeFrom=request.getParameter("AgeFrom");
					if(request.getParameter("AgeTo")==null)
						mAgeTo="";
					else
						mAgeTo=request.getParameter("AgeTo");
				%>
				<td><input type="text" name="AgeFrom" maxlength="2" size="2" value="<%=mAgeFrom%>" onkeydown="if(event.keyCode==13){event.keyCode=13;return event.keyCode}" ><b><FONT face=Arial size=2>To</font></b>
				<input type="text" name="AgeTo" maxlength="2" size="2" value="<%=mAgeTo%>" onkeydown="if(event.keyCode==13){event.keyCode=13;return event.keyCode}" ></td>
			</tr>						
			<tr>	
				<td align=left><b><FONT face=Arial size=2>Gender </font></B></td>
				<td><select name="Gender" id="Gender" style="WIDTH: 120px" onkeydown="if(event.keyCode==13){event.keyCode=13;return event.keyCode}" >
				<%
					if(request.getParameter("Gender")==null)
					{	
						%>
						<option selected value="A">Both</option>
						<option value="M">Male</option>
						<option value="F">Female</option>			
						<%
					}
					else
					{
						mGender=request.getParameter("Gender");
						if(mGender.equals("A"))
						{
							%>
								<option Selected value="A">Both</option>
								<option value="M">Male</option>
								<option value="F">Female</option>			
							<%
						}
						if(mGender.equals("M"))
						{
							%>
								<option value="A">Both</option>
								<option Selected value="M">Male</option>
								<option value="F">Female</option>			
							<%
						}
						if(mGender.equals("F"))
						{
							%>
								<option value="A">Both</option>
								<option value="M">Male</option>
								<option Selected value="F">Female</option>			
							<%
						}
					}
					%>
				</select>
				</td>
				<td><b><FONT face=Arial size=2>Category </font></b></td>
				<td colspan=3>
					<select name="Category1" id="Category1" style="WIDTH: 250px" onkeydown="if(event.keyCode==13){event.keyCode=13;return event.keyCode}" >
					<%
						try
						{
							qry="select CATEGORYCODE, CATEGORY from CATEGORYMASTER where nvl(DEACTIVE,'N')='N' ";
							rs=db.getRowset(qry);
							while(rs.next())
							{
								if(request.getParameter("x")==null)
								{
									if(mCategory.equals(""))
									{
										mCategory=rs.getString("CATEGORYCODE");
										%>
											<option value="<%=rs.getString("CATEGORYCODE")%>" selected><%=rs.getString("CATEGORY")%></option>
										<%
									}
									else
									{
										%>
											<option value="<%=rs.getString("CATEGORYCODE")%>"><%=rs.getString("CATEGORY")%></option>
										<%
									}
								}
								else
								{
									if(rs.getString("CATEGORYCODE").equals(request.getParameter("Category1")))
									{
										%>
											<option  selected value="<%=rs.getString("CATEGORYCODE")%>"><%=rs.getString("CATEGORY")%></option>
										<%
									}
									else
									{
										%>
											<option value="<%=rs.getString("CATEGORYCODE")%>"><%=rs.getString("CATEGORY")%></option>
										<%
									}
								}
							}						
					}catch(Exception e)
						{/*System.out.println("Exception e :- "+e);*/		}
				%>					
					</select>			
				</td>
			</tr>
			<tr>	
				<td align=left><b><FONT face=Arial size=2>Emp. Category </font></b></td>
				<td>
					<select name="EmpCategory" id="EmpCategory" style="WIDTH: 120px" onkeydown="if(event.keyCode==13){event.keyCode=13;return event.keyCode}" >
					<%
						try
						{
							qry="select EMPCATEGORYCODE, EMPCATEGORYDESC from HR#EMPCATEGORYMASTER where nvl(DEACTIVE,'N')='N'";
							rs=db.getRowset(qry);
							while(rs.next())
							{
								if(request.getParameter("x")==null)
								{
									if(mEmpCategory.equals(""))
									{
										mEmpCategory=rs.getString("EMPCATEGORYCODE");
										%>
											<option value="<%=rs.getString("EMPCATEGORYCODE")%>" selected><%=rs.getString("EMPCATEGORYDESC")%></option>
										<%
									}
									else
									{
										%>
											<option value="<%=rs.getString("EMPCATEGORYCODE")%>"><%=rs.getString("EMPCATEGORYDESC")%></option>
										<%
									}
								}
								else
								{
									if(rs.getString("EMPCATEGORYCODE").equals(request.getParameter("EmpCategory")))
									{
										%>
											<option Selected value="<%=rs.getString("EMPCATEGORYCODE")%>"><%=rs.getString("EMPCATEGORYDESC")%></option>
										<%
									}
									else
									{
										%>
											<option value="<%=rs.getString("EMPCATEGORYCODE")%>"><%=rs.getString("EMPCATEGORYDESC")%></option>
										<%
									}
								}
							}
						}catch(Exception e)
							{/*System.out.println("Exception e :- "+e);*/}
				%>	
					</select>			
				</td>
				<td><b><FONT face=Arial size=2>Emp. Type </font></B></td>
				<td colspan=3><select name="EmpType" id="EmpType" style="WIDTH: 250px" onkeydown="if(event.keyCode==13){event.keyCode=13;return event.keyCode}" >
				<%
					try
					{
						qry="select EMPLOYEETYPE, EMPLOYEETYPEDESC from EMPLOYEETYPEMASTER where nvl(DEACTIVE,'N')='N'";
						rs=db.getRowset(qry);
						while(rs.next())
						{
							if(request.getParameter("x")==null)
							{
								if(mEmployeeType.equals(""))
								{							
									mEmployeeType=rs.getString("EMPLOYEETYPE");
									%>
										<option value="<%=rs.getString("EMPLOYEETYPE")%>" selected><%=rs.getString("EMPLOYEETYPEDESC")%></option>
									<%
								}
								else
								{
									%>
										<option	value="<%=rs.getString("EMPLOYEETYPE")%>"><%=rs.getString("EMPLOYEETYPEDESC")%></option>
									<%
								}
							}
							else
							{
								if(rs.getString("EMPLOYEETYPE").equals(request.getParameter("EmpType")))
								{
									%>
										<option value="<%=rs.getString("EMPLOYEETYPE")%>" selected><%=rs.getString("EMPLOYEETYPEDESC")%></option>
									<%
								}
								else
								{
									%>
										<option value="<%=rs.getString("EMPLOYEETYPE")%>" ><%=rs.getString("EMPLOYEETYPEDESC")%></option>
									<%
								}
							}
						}
					}catch(Exception e)
						{/*System.out.println("Exception e :- "+e);*/		}
				%>								
					</select>
				</td>
				
			</tr>
			<tr>
				<td align=left><b>Place of Posting </B></td>
				<%
					if(request.getParameter("PlacePosting")==null)
						mPlacePosting="";
					else
						mPlacePosting=request.getParameter("PlacePosting");
				%>
				<td nowrap colspan=5><input type="text" name="PlacePosting" maxlength="60" size="60" value="<%=mPlacePosting%>" onkeydown="if(event.keyCode==13){event.keyCode=13;return event.keyCode}" ></td>
			</tr>
			<tr>
				<td><b><FONT face=Arial size=2>Job Discription </font></B></td>
				<%
					if(request.getParameter("JobDiscription")==null)
						mJobDiscription="";
					else
						mJobDiscription=request.getParameter("JobDiscription");
				%>
				<td colspan=5><input type="text" name="JobDiscription" maxlength="100" size="60" value="<%=mJobDiscription%>"><a title="Click to add Qualifications" target=_new href="ManPowerIndentQualification.jsp" onkeydown="if(event.keyCode==13){event.keyCode=13;return event.keyCode}" ><FONT face=Arial size=2 color=blue><b>Req. Qualification</b></font></td>
			</tr>
			<tr>
				<td align=left><b><FONT face=Arial size=2>Reason/Remarks<br>(Max. 300 Chars.)</font></b></td>
				<%
					if(request.getParameter("Remarks")==null)
						mRemarks="";
					else
						mRemarks=request.getParameter("Remarks");
				%>
				<td colspan=5><TextArea Name='Remarks' Id='Remarks' cols=45 rows=3 onkeydown="if(event.keyCode==13){event.keyCode=13;return event.keyCode}"  ><%=mRemarks%></TextArea>&nbsp;<INPUT id="submit" style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 50px; HEIGHT: 23px; FONT-VARIANT: normal; cursor:hand; background-color:; border-width:1;" type="submit" size=5 value="Save" name="submit" onkeydown="if(event.keyCode==13){event.keyCode=13;return event.keyCode}" onClick="return QuestionTextChanged()">&nbsp;<INPUT id="Cancel" style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 55px; HEIGHT: 23px; FONT-VARIANT: normal; cursor:hand; background-color:; border-width:1;" type="submit"  value="Cancel" name="submit" onkeydown="if(event.keyCode==13){event.keyCode=13;return event.keyCode}" onClick="return QuestionTextChanged()"></td>
			</tr>
			</table>
			</center>
			<input type="hidden" value="<%=mEmployeeName%>" name="EmployeeName">
			<input type="hidden" value="<%=mDepartmentCode%>" name="Department">
			<input type="hidden" value="<%=mDesignationCode%>" name="Designation">
			<input type="hidden" value="<%=mCurrDate%>" name="CurrDate">
			<INPUT Type="Hidden" Name="Inst"  Value=<%=mInst%>>
			<%
			if(request.getAttribute("Vlaidation")==null)
				mVlaidation=0;
			else
				mVlaidation=Integer.parseInt((String)request.getAttribute("Vlaidation"));			
			//out.println("mVlaidation"+mVlaidation);
			if(mVlaidation==31)
			{
				out.print("<center><img src='images/Error1.jpg'> ");
				out.println("<font size=2 face='arial' color=red><b>Indent Reference Number cann't be dublicate</center></b></font>");
			}
			else if(mVlaidation==11)
			{
				out.print("<center><img src='images/Error1.jpg'> ");
				out.println("<font size=2 face='arial' color=red><b>Indent Reference Number cann't be blank</center></b></font>");
			}				
			else if(mVlaidation==10)
			{
				out.print("<center><img src='images/Error1.jpg'> ");
				out.println("<font size=2 face='arial' color=red><b>Required Date must be greater than Indent Date </center></b></font>");
			}
			else if(mVlaidation==19)
			{
				out.print("<center><img src='images/Error1.jpg'> ");
				out.println("<font size=2 face='arial' color=red><b>Man Power can not  be blank and greater than Zero</center></b></font>");
			}
			else if(mVlaidation==9)
			{
				out.print("<center><img src='images/Error1.jpg'> ");
				out.println("<font size=2 face='arial' color=red><b>Man Power must be numeric</center></b></font>");
			}
			else if(mVlaidation==18)
			{
				out.print("<center><img src='images/Error1.jpg'> ");
				out.println("<font size=2 face='arial' color=red><b>Experience can not  be blank</center></b></font>");
			}
			else if(mVlaidation==28)
			{
				out.print("<center><img src='images/Error1.jpg'> ");
				out.println("<font size=2 face='arial' color=red><b>Experience must not  be greater than 99</center></b></font>");
			}
			else if(mVlaidation==8)
			{
				out.print("<center><img src='images/Error1.jpg'> ");
				out.println("<font size=2 face='arial' color=red><b>Experience must be numeric</center></b></font>");
			}
			else if(mVlaidation==17)
			{
				out.print("<center><img src='images/Error1.jpg'> ");
				out.println("<font size=2 face='arial' color=red><b>From Age can not be blank</center></b></font>");
			}
			else if(mVlaidation==20)
			{
				out.print("<center><img src='images/Error1.jpg'> ");
				out.println("<font size=2 face='arial' color=red><b>From Age can not less than 18</center></b></font>");
			}
			else if(mVlaidation==7)
			{
				out.print("<center><img src='images/Error1.jpg'> ");
				out.println("<font size=2 face='arial' color=red><b>From Age must be numeric</center></b></font>");
			}
			else if(mVlaidation==6)
			{
				out.print("<center><img src='images/Error1.jpg'> ");
				out.println("<font size=2 face='arial' color=red><b>To Age must be numeric</center></b></font>");
			}
			else if(mVlaidation==4)
			{
				out.print("<center><img src='images/Error1.jpg'> ");
				out.println("<font size=2 face='arial' color=red><b>To Age must be greater than From Age</center></b></font>");
			}
			else if(mVlaidation==3)
			{
				out.print("<center><img src='images/Error1.jpg'> ");
				out.println("<font size=2 face='arial' color=red><b>Please Enter Main Qualification</center></b></font>");
			}
			else if(mVlaidation==2)
			{
				out.print("<center><img src='images/Error1.jpg'> ");
				out.println("<font size=2 face='arial' color=red><b>Please Select Qualification</center></b></font>");				
			}
			else if(mVlaidation==1)
			{
				out.print("<center><img src='images/Error1.jpg'> ");
				out.println("<font size=2 face='arial' color=red><b>Please Enter Less than 300 Characters</center></b></font>");
			}					
		}
		else
		{
			%>
				<br>
				<font color=red>
				<h3>	<br><img src='images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
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
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}
}
catch(Exception e)
{
	//out.print("Catch Block");	
}
%>
</form>
</body>
</html>