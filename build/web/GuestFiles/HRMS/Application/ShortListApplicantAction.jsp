<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null,rsi=null,rs1=null;
GlobalFunctions gb =new GlobalFunctions();
OLTEncryption enc=new OLTEncryption();
String qry="";
String mComp="JIIT";
String mEmployeeName="",mEmployeeCode="",mDepartment="";
String mMemberID="", mDMemberID="",mIndentDate="",mDesignation="";
String mMemberType="", mDMemberType="", mMemberCode="", mDMemberCode="";
String mMemberName="", mDept="", mDegs="",mDesignation1="";
String mInstitute="",mInst="",mtext="",mCurrDate="";
String mDesignationCode="",mDepartmentCode="",mApplicantName="";
String mDepartment1="",mDate1="",mDate2="",mValue="";
String mDeg="",mEmpType="",mIndentNumber="";
String mINST="",mComp1="",mSelectApplicant="",mCriteria="";
String mDate11="",mDate12="",mShotlistCriteria="";
String mDesig="",mEmpType1="",mIndent="",mShortListWholeApplicant="";
String mNoTopApplicant="",mOrderBy="",mAsending="",mMonths="",mIntCode="";
String temp="";
int counter=0,mSno=0,mReqExpmonth=0,mTotalExpInYear=0;
int flag=0,count=0;
int mApplicantNo=0,mExpInMonth=0,mExpInYear=0,mInterMonths=0;
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
<TITLE>#### <%=mHead%> [ Short List Applicant Action] </TITLE>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
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
<Script language= javaScript >
function allChecked()
{
	for(var i =0; i < document.frm1.elements.length;i++)
	{				
		var e=document.frm1.elements[i];				    
		if((e.name!="allCheck") && (e.type=="checkbox"))
		{ 
			e.checked = document.frm1.allCheck.checked;
		}
	}
}
function Checked()
{
	document.frm1.allCheck.checked=false;
	var j=0;
	for(var i=0;i<document.frm1.elements.length;i++)
	{
		var e=document.frm1.elements[i];
		if((e.type=="checkbox")&&(e.checked==false))
			++j;					 				
	}
	if(j==1)
	{
		document.frm1.allCheck.checked=true;
		return false;
	}
}
function fun1()
{	
	var k=0;
	for(var i =0; i < document.frm1.elements.length;i++)
	{
		var e=document.frm1.elements[i];			
		if(e.type=="checkbox")			     
			if(e.checked==true)
				k++;						
	}
	if(k==0)
	{
		alert("Please select any check box");
		return false;
	} 	  			
}//end of fun1();
</script>								
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
		qry="Select WEBKIOSK.ShowLink('149','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	    RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
			%>
			<form name="frm1"  method="post" action="SaveShortlisedtApplicant.jsp">
			<center>
			<table align=center width="100%" bottommargin=0 topmargin=0>
			<tr>
				<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4>List of Applicant for Short List </FONT></u></b></td>
			</tr>
			</table>
			</center>
			<table>
			<tr>
				<!-- <td>&nbsp;&nbsp;&nbsp;<input type="Submit" name="saveinxl" value="Save in Excel" style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 120px; HEIGHT: 20px; FONT-VARIANT: normal; cursor:hand; background-color:; border-width:1;"></td> -->
				<td><b>Interview Code </b></td>
				<td>
					<select name="InterviewCode" id="InterviewCode" style= "font-size: 10pt; font-family: Times New Roman; font-weight: normal;">
					<%
					try
					{
						qry="select INTERVIEWDESC,INTERVIEWCODE FROM HR#INTERVIEWMASTER WHERE NVL(DEACTIVE,'N')<>'Y' AND NVL(LOCKINTERVIEW,' ')<>'Y' ORDER BY INTERVIEWCODE DESC";
						rs=db.getRowset(qry);
						//out.print(qry);
						while(rs.next())
						{
							if(temp.equals(""))
							{
								temp=rs.getString("INTERVIEWDESC");
								%>
								<option value="<%=rs.getString("INTERVIEWCODE")%>" selected><%=rs.getString("INTERVIEWDESC")%></option>
								<%
							}
							else
							{
								%>
								<option value="<%=rs.getString("INTERVIEWCODE")%>"><%=rs.getString("INTERVIEWDESC")%></option>
								<%
							}
						}
					}catch(Exception e)
					{
						/*out.print("Exception e:-"+e);*/
					}
					%>
					</select>				
				</td>
			</tr>
			</table>
			<%			
			if(request.getParameter("INST")==null)
				mINST="";
			else
				mINST=request.getParameter("INST");
			if(request.getParameter("Comp")==null)
				mComp1="";
			else
				mComp1=request.getParameter("Comp");			
			if(request.getParameter("Criteria")==null)
				mCriteria="";
			else
				mCriteria=request.getParameter("Criteria");		
			if(mCriteria.equals("AllApplicant"))
			{
				mInterMonths=10000;
				//out.print("all");
			}
			else if(mCriteria.equals("notInterViewed"))
			{
				//out.print("not interviewed");
				mInterMonths=0;
				/*if(request.getParameter("Months")==null)
					mMonths="";
				else
					mMonths=request.getParameter("Months");		
				try
				{
					mInterMonths=Integer.parseInt(mMonths);
				}catch(Exception e)
				{
					flag++;
					out.print("Exception e:-"+e);
				}*/
			}
			else if(mCriteria.equals("BeforeInterviewed"))
			{
				//out.print("Before Interviewed");
				if(request.getParameter("Months")==null)
					mMonths="";
				else
					mMonths=request.getParameter("Months");		
				try
				{
					mInterMonths=Integer.parseInt(mMonths);
				}catch(Exception e)
				{
					flag++;
					//out.print("Exception e:-"+e);
				}
			}
			if(request.getParameter("TXT1")==null)
				mDate11="";
			else
				mDate11=request.getParameter("TXT1");
			if(request.getParameter("TXT2")==null)
				mDate12="";
			else
				mDate12=request.getParameter("TXT2");
			if(request.getParameter("ShotlistCriteria")==null)
				mShotlistCriteria="";
			else
				mShotlistCriteria=request.getParameter("ShotlistCriteria");		
			if(request.getParameter("Designation")==null)
				mDesig="";
			else
				mDesig=request.getParameter("Designation");
			if(request.getParameter("EmpType")==null)
				mEmpType1="";
			else
				mEmpType1=request.getParameter("EmpType");
			if(request.getParameter("Indent")==null)
				mIndent="";
			else
				mIndent=request.getParameter("Indent");
			if(request.getParameter("ShortListWholeApplicant")==null)
				mShortListWholeApplicant="";
			else
				mShortListWholeApplicant=request.getParameter("ShortListWholeApplicant");			
			if(mShortListWholeApplicant.equals("TopApplicant"))
			{
				if(request.getParameter("NoTopApplicant")==null)
					mNoTopApplicant="";
				else
				{
					mNoTopApplicant=request.getParameter("NoTopApplicant");
					try
					{
						mApplicantNo=Integer.parseInt(mNoTopApplicant);
						//mApplicantNo=mApplicantNo+1;
						//System.out.println("aaaa:-"+mNoTopApplicant);	
					}catch(Exception e)
					{
						flag++;
						//System.out.println("Exception e:-"+e);						
					}
				}
			}
			else
				mNoTopApplicant="";
			if(request.getParameter("OrderBy")==null)
				mOrderBy="";
			else
				mOrderBy=request.getParameter("OrderBy");
			if(mNoTopApplicant.equals(""))
				if(request.getParameter("Asending")==null)
					mAsending="asc";
				else
					mAsending="DESC";
			else									
			{
				if(request.getParameter("Asending")==null)
					mAsending="asc";
				else
					mAsending=request.getParameter("Asending");
				//mOrderBy="TOTALMONTHEXPERIANCE";				
			}
			if(flag==0)
			{
				if(mIndent.equals(""))
				{
					try
					{					
						/*qry="SELECT * FROM (Select A.APPLICANTID APPLICANTID,";
						qry=qry+"NVL(B.TOTALMONTHEXPERIANCE,'0')TOTALMONTHEXPERIANCE,";
						qry=qry+"A.APPLICANTNAME,to_char(DATEOFSUBMISSION,'dd-mm-yyyy')";
						qry=qry+"DATESUB,nvl(to_char(DATEOFBIRTH,'dd-mm-yyyy'),' ')"; 
						qry=qry+"DATEOFBIRTH,FATHERHUSBANDNAME,PRESENTORGANISATION";
						qry=qry+",PRESENTSALARY,decode(SEX,'M','Male','F','Female',SEX)";
						qry=qry+"SEX,decode(MARITALSTATUS,'M','Married','U','Unmarried',";
						qry=qry+"MARITALSTATUS)MARITALSTATUS,DECODE(D.QUALIFICATION,'',' ',D.QUALIFICATION)QUALIFICATIONCODE ";
						qry=qry+"from HR#APPLICATIONMASTER A,V#HR#APPLICANTEXPERIANCE B,QUALIFICATIONMASTER D,";
						qry=qry+"HR#APPLICANTQUALIFICATION E where nvl(A.DEACTIVE,' ')<>'Y' ";
						qry=qry+"AND to_date(DATEOFSUBMISSION,'dd-mm-rrrr') between ";
						qry=qry+"decode(to_date('"+mDate11+"','dd-mm-rrrr'),'',to_date(DATEOFSUBMISSION,'dd-mm-rrrr'),";
						qry=qry+"to_date('"+mDate11+"','dd-mm-yyyy')) AND decode(to_date('"+mDate12+"','dd-mm-rrrr'),'',to_date(DATEOFSUBMISSION,'dd-mm-rrrr'),";
						qry=qry+"to_date('"+mDate12+"','dd-mm-yyyy')) AND B.APPLICANTID(+)=A.APPLICANTID ";
						qry=qry+"and E.APPLICANTID(+)=A.APPLICANTID and E.MAINQUALIFICATION(+)='Y'";
						qry=qry+"AND D.QUALIFICATIONCODE(+)=E.QUALIFICATIONCODE ";
						qry=qry+"and A.DESIGNATIONCODE=decode('"+mDesig+"','',A.DESIGNATIONCODE,'"+mDesig+"') ";
						qry=qry+"and A.EMPLOYEETYPE=decode('"+mEmpType1+"','',A.EMPLOYEETYPE,'"+mEmpType1+"') ";
						qry=qry+"AND NOT EXISTS (select 1 From HR#APPLICATIONMASTER X, HR#INTERVIEWMASTER Y, ";
						qry=qry+"HR#INTERVIEWRESULT Z Where Z.COMPANYCODE=Y.COMPANYCODE ";
						qry=qry+"AND Z.INSTITUTECODE=Y.INSTITUTECODE AND ";
						qry=qry+"Z.INTERVIEWCODE=Y.INTERVIEWCODE and ";
						qry=qry+"NVL(Y.DEACTIVE,'N')<>'Y' AND NVL(Z.DEACTIVE,'N')<>'Y' AND ";
						qry=qry+"NVL(Y.LOCKINTERVIEW,'N')<>'Y' ";
						qry=qry+"AND X.APPLICANTID=Z.APPLICANTID AND ";
						qry=qry+"A.APPLICANTID=X.APPLICANTID ";
						qry=qry+"AND INTERVIEWDATE<=ADD_MONTHS(SYSDATE,-"+mInterMonths+")) ";
						qry=qry+" and rownum <= decode('"+mApplicantNo+"','0','100','"+mApplicantNo+"')";
						qry=qry+"order by TOTALMONTHEXPERIANCE desc ) ";
						qry=qry+"ORDER BY "+mOrderBy+" "+mAsending+" ";*/
						qry="SELECT * FROM (Select A.APPLICANTID APPLICANTID,";
						qry=qry+"NVL(B.EXPERIENCEINMONTHS,'0')EXPERIENCEINMONTHS,";
						qry=qry+"A.APPLICANTNAME,to_char(A.DATEOFSUBMISSION,'dd-mm-yyyy')";
						qry=qry+"DATESUB,nvl(to_char(A.DATEOFBIRTH,'dd-mm-yyyy'),' ')"; 
						qry=qry+"DATEOFBIRTH,nvl(A.FATHERNAME,' ')FATHERNAME,A.PRESENTORGANISATION";
						qry=qry+",A.PRESENTSALARY,decode(A.SEX,'M','Male','F','Female',SEX)";
						qry=qry+"SEX,decode(A.MARITALSTATUS,'M','Married','U','Unmarried',";
						qry=qry+"A.MARITALSTATUS)MARITALSTATUS,DECODE(D.QUALIFICATION,' ',' ',D.QUALIFICATION)QUALIFICATION ";
						qry=qry+"from HR#APPLICATIONMASTER A,HR#APPLICANTEXPERIENCE B,QUALIFICATIONMASTER D,";
						qry=qry+"HR#APPLICANTQUALIFICATION E where nvl(A.DEACTIVE,'N')<>'Y' AND trunc(A.DATEOFSUBMISSION) between to_date('"+mDate11+"','dd-mm-yyyy') AND to_date('"+mDate12+"','dd-mm-yyyy') AND B.APPLICANTID(+)=A.APPLICANTID ";
						qry=qry+"and E.APPLICANTID(+)=A.APPLICANTID and E.MAINQUALIFICATION(+)='Y'";
						qry=qry+"AND D.QUALIFICATIONCODE(+)=E.QUALIFICATIONCODE ";
						qry=qry+"and A.DESIGNATIONCODE=decode('"+mDesig+"',' ',A.DESIGNATIONCODE,'"+mDesig+"') ";
						qry=qry+"and A.EMPLOYEETYPE=decode('"+mEmpType1+"',' ',A.EMPLOYEETYPE,'"+mEmpType1+"') ";
						qry=qry+"AND NOT EXISTS (select 1 From HR#APPLICATIONMASTER X, HR#INTERVIEWMASTER Y, ";
						qry=qry+"HR#INTERVIEWRESULT Z Where Z.COMPANYCODE=Y.COMPANYCODE ";
						qry=qry+"AND Z.INSTITUTECODE=Y.INSTITUTECODE AND ";
						qry=qry+"Z.INTERVIEWCODE=Y.INTERVIEWCODE and ";
						qry=qry+"NVL(Y.DEACTIVE,'N')<>'Y' AND NVL(Z.DEACTIVE,'N')<>'Y' AND ";
						qry=qry+"NVL(Y.LOCKINTERVIEW,'N')<>'Y' ";
						qry=qry+"AND X.APPLICANTID=Z.APPLICANTID AND ";
						qry=qry+"A.APPLICANTID=X.APPLICANTID ";
						qry=qry+"AND INTERVIEWDATE<=ADD_MONTHS(SYSDATE,-"+mInterMonths+")) ";
						qry=qry+" and rownum <= decode('"+mApplicantNo+"','0','100','"+mApplicantNo+"')";
						qry=qry+"order by EXPERIENCEINMONTHS desc ) ";
						qry=qry+"ORDER BY "+mOrderBy+" "+mAsending+" ";
						
						//out.print(qry);
						
						rs=db.getRowset(qry);
						
						while(rs.next())
						{	
							if(count==0)
							{
						
								%>
								<center>
								<table class="sort-table" id="table-1" cellpadding="0" cellspacing="0" border="2">
								<tr bgcolor="#ff8c00">
									<td><font color="white"><b>Sno.</b></font></td>
									<td><font color="white"><b><input type="checkbox" name="allCheck" value="all" id="allCheck" onClick="allChecked();">Check</b></font></td>
									<td><font color="white"><b>Applicant&nbsp;Name</b></font></td>
									<td><font color="white"><b>Father's&nbsp;Name</b></font></td> 
									<td nowrap align="center"><font color="white"><b>Main&nbsp;Qualification</b></font></td> 
									<td><font color="white"><b>Gender</b></font></td>
									<td><font color="white"><b>Experience</b></font></td> 
									<td><font color="white"><b>Date&nbsp;of&nbsp;Birth</b></font></td>
									<!-- <td><font color="white"><b>Current&nbsp;Org.</b></font></td>
									<td><font color="white"><b>Present&nbsp;Salary</b></font></td> -->
									<td><font color="white"><b>Marital&nbsp;Status</b></font></td>			
									<td><font color="white"><b>Sub.&nbsp;Date&nbsp;&nbsp;</b></font></td>
								</tr>
								<%
								count++;
							}
							%>
							<tr>
								<td><%=++mSno%>.</td>
								<td><input type="checkbox" value="<%=mSno%>" name="check<%=mSno%>" onClick="Checked();"></td>
								<td NOWRAP title="Click to View Detail of <%=gb.toTtitleCase(rs.getString("APPLICANTNAME"))%>">&nbsp;<a target=_new href="ViewDetailApplicant.jsp?AD=<%="!!!~~~"+rs.getString("APPLICANTID")+"^^^***"%>"><font color="blue"><b><%=gb.toTtitleCase(rs.getString("APPLICANTNAME"))%></b></font></a></td>
								<td nowrap>&nbsp;<%=gb.toTtitleCase(rs.getString("FATHERNAME"))%></td> 
								<td nowrap>&nbsp;<%=gb.toTtitleCase(rs.getString("QUALIFICATION"))%></td>
								<td>&nbsp;<%=gb.toTtitleCase(rs.getString("SEX"))%></td>	
								<%								
								mTotalExpInYear=Integer.parseInt(rs.getString("EXPERIENCEINMONTHS"));							
								mExpInYear=mTotalExpInYear/12;							
								mExpInMonth=mTotalExpInYear%12;
								%>
								<td nowrap>&nbsp;Year&nbsp;<%=mExpInYear%>&nbsp;Month&nbsp;<%=mExpInMonth%></td>
								<td>&nbsp;<%=rs.getString("DATEOFBIRTH")%></td>
								<!-- <td>&nbsp;<%//=gb.toTtitleCase(rs.getString("PRESENTORGANISATION"))%></td>
								<td>&nbsp;<%//=gb.toTtitleCase(rs.getString("PRESENTSALARY"))%></td> -->
								<td>&nbsp;<%=gb.toTtitleCase(rs.getString("MARITALSTATUS"))%></td>
								<td>&nbsp;<%=gb.toTtitleCase(rs.getString("DATESUB"))%></td>
								<input type="hidden" name="ApplicantName<%=mSno%>" value="<%=gb.toTtitleCase(rs.getString("APPLICANTNAME"))%>">
								<input type="hidden" name="Sex<%=mSno%>" value="<%=gb.toTtitleCase(rs.getString("SEX"))%>">
								<input type="hidden" name="FaterName<%=mSno%>" value="<%=gb.toTtitleCase(rs.getString("FATHERNAME"))%>"> 
								<input type="hidden" name="Dob<%=mSno%>" value="<%=gb.toTtitleCase(rs.getString("DATEOFBIRTH"))%>">
								<input type="hidden" name="PresentSalary<%=mSno%>" value="<%=gb.toTtitleCase(rs.getString("PRESENTSALARY"))%>">
								<input type="hidden" name="Marital<%=mSno%>" value="<%=gb.toTtitleCase(rs.getString("MARITALSTATUS"))%>">
								<input type="hidden" name="DateofSub<%=mSno%>" value="<%=gb.toTtitleCase(rs.getString("DATESUB"))%>">
								<input type="hidden" name="Applicantid<%=mSno%>" value="<%=rs.getString("APPLICANTID")%>">
								<input type="hidden" name="PresentOrg<%=mSno%>" value="<%=gb.toTtitleCase(rs.getString("PRESENTORGANISATION"))%>">
								<input type="hidden" name="Exp<%=mSno%>" value="Year <%=mExpInYear%> Month <%=mExpInMonth%>">
								<input type="hidden" name="MainQuali<%=mSno%>" value="<%=gb.toTtitleCase(rs.getString("QUALIFICATION"))%>">
							</tr>
						<%
						}
						if(count>0)
						{
							%>
							<tr>
								<td colspan="20" align="center"><input type="submit" name="shortList" value="Short-Listed Selected Applicants" style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 230px; HEIGHT: 23px; FONT-VARIANT: normal; cursor:hand; background-color:; border-width:1;" onclick="return fun1();"></td>
							</tr>
							</table>
							</center>
							<input type="hidden" name="counter" value="<%=mSno%>" >
							<%
						}
					}catch(Exception e)
					{/*out.print("Exception e:-"+e);*/}
				}
				else
				{								
					mIntCode=mIndent.substring(mIndent.indexOf("&&&")+3,mIndent.length());
					qry="SELECT * FROM(SELECT	NVL(E.EXPERIENCEINMONTHS,'0')EXPERIENCEINMONTHS,F.APPLICANTID,";
					qry=qry+"F.APPLICANTNAME,nvl(F.FATHERNAME,' ')FATHERNAME,to_char(F.DATEOFSUBMISSION,'dd-mm-yyyy')DATESUB,";
					qry=qry+"nvl(to_char(F.DATEOFBIRTH,'dd-mm-yyyy'),' ')DATEOFBIRTH,";
					qry=qry+"F.PRESENTORGANISATION,F.PRESENTSALARY, ";
					qry=qry+"decode(SEX,'M','Male','F','Female',F.SEX)SEX,";
					qry=qry+"decode(F.MARITALSTATUS,'M','Married','U','Unmarried',F.MARITALSTATUS)MARITALSTATUS,";
					qry=qry+"D.QUALIFICATION QUALIFICATION FROM HR#MANPOWERINDENT A,HR#MANPOWERQUALIFICATION B,";
					qry=qry+"QUALIFICATIONMASTER D,HR#APPLICATIONMASTER F,HR#APPLICANTEXPERIENCE E,";
					qry=qry+"HR#APPLICANTQUALIFICATION G WHERE NVL(A.DEACTIVE,'N')<>'Y' ";
					qry=qry+"AND NVL(D.DEACTIVE,'N')<>'Y'AND NVL(F.DEACTIVE,'N')<>'Y' ";
					qry=qry+"AND AUTORIZEDSTATUS='F' AND B.MAINQUALIFICATION='Y' ";
					qry=qry+"AND G.MAINQUALIFICATION='Y' AND A.INDENTNO='"+mIntCode+"' ";
					qry=qry+"AND B.QUALIFICATIONCODE=G.QUALIFICATIONCODE AND round(A.TOTALEXPERIENCEREQ*12)<=NVL(E.EXPERIENCEINMONTHS,'0') ";
					qry=qry+"AND E.APPLICANTID(+)=F.APPLICANTID AND G.APPLICANTID(+)=F.APPLICANTID ";
					qry=qry+"AND A.INDENTNO=B.INDENTNO AND A.INDENTDEPARTMENTCODE=F.DEPARTMENTCODE ";
					qry=qry+"AND A.INDENTDESIGNATIONCODE=F.DESIGNATIONCODE AND A.EMPLOYEETYPE=F.EMPLOYEETYPE ";
					qry=qry+"AND B.QUALIFICATIONCODE=D.QUALIFICATIONCODE ";
					qry=qry+"AND F.SEX=DECODE(A.GENDER,'A',SEX,A.GENDER) ";
					qry=qry+"AND trunc(F.DATEOFSUBMISSION) between to_date('"+mDate11+"','dd-mm-yyyy') AND to_date('"+mDate12+"','dd-mm-yyyy')";
					qry=qry+"AND NOT EXISTS (select 1 From HR#APPLICATIONMASTER X, HR#INTERVIEWMASTER Y, ";
					qry=qry+"HR#INTERVIEWRESULT Z Where Z.COMPANYCODE=Y.COMPANYCODE ";
					qry=qry+"AND Z.INSTITUTECODE=Y.INSTITUTECODE AND Z.INTERVIEWCODE=Y.INTERVIEWCODE ";
					qry=qry+"AND X.APPLICANTID=Z.APPLICANTID AND ";
					qry=qry+"F.APPLICANTID=X.APPLICANTID AND ";
					qry=qry+"Z.INTERVIEWCODE=Y.INTERVIEWCODE and NVL(Y.DEACTIVE,'N')<>'Y' ";
					qry=qry+"AND NVL(Z.DEACTIVE,'N')<>'Y' AND ";
					qry=qry+"NVL(Y.LOCKINTERVIEW,'N')<>'Y'";
					qry=qry+"AND INTERVIEWDATE<=ADD_MONTHS(SYSDATE,-"+mInterMonths+")) ";
					qry=qry+" and rownum <= decode('"+mApplicantNo+"','0','100','"+mApplicantNo+"') order by EXPERIENCEINMONTHS desc";
					qry=qry+") ORDER BY "+mOrderBy+" "+mAsending+" ";

					//out.print(qry);
					/*qry="SELECT * FROM(SELECT	NVL(E.TOTALMONTHEXPERIANCE,'0')TOTALMONTHEXPERIANCE,F.APPLICANTID,";
					qry=qry+"F.APPLICANTNAME,to_char(F.DATEOFSUBMISSION,'dd-mm-yyyy')DATESUB,";
					qry=qry+"nvl(to_char(F.DATEOFBIRTH,'dd-mm-yyyy'),' ')DATEOFBIRTH,";
					qry=qry+"F.FATHERHUSBANDNAME,F.PRESENTORGANISATION,F.PRESENTSALARY, ";
					qry=qry+"decode(SEX,'M','Male','F','Female',F.SEX)SEX,";
					qry=qry+"decode(F.MARITALSTATUS,'M','Married','U','Unmarried',F.MARITALSTATUS)MARITALSTATUS,";
					qry=qry+"D.QUALIFICATION QUALIFICATION FROM HR#MANPOWERINDENT A,HR#MANPOWERQUALIFICATION B,";
					qry=qry+"QUALIFICATIONMASTER D,HR#APPLICATIONMASTER F,V#HR#APPLICANTEXPERIANCE E,";
					qry=qry+"HR#APPLICANTQUALIFICATION G WHERE NVL(A.DEACTIVE,'N')<>'Y' ";
					qry=qry+"AND NVL(D.DEACTIVE,'N')<>'Y'AND NVL(F.DEACTIVE,'N')<>'Y' ";
					qry=qry+"AND AUTORIZEDSTATUS='F' AND B.MAINQUALIFICATION='Y' ";
					qry=qry+"AND G.MAINQUALIFICATION='Y' AND A.INDENTNO='"+mIntCode+"' ";
					qry=qry+"AND B.QUALIFICATIONCODE=G.QUALIFICATIONCODE AND round(A.TOTALEXPERIENCEREQ*12)<=NVL(E.TOTALMONTHEXPERIANCE,'0') ";
					qry=qry+"AND E.APPLICANTID(+)=F.APPLICANTID AND G.APPLICANTID(+)=F.APPLICANTID ";
					qry=qry+"AND A.INDENTNO=B.INDENTNO AND A.INDENTDEPARTMENTCODE=F.DEPARTMENTCODE ";
					qry=qry+"AND A.INDENTDESIGNATIONCODE=F.DESIGNATIONCODE AND A.EMPLOYEETYPE=F.EMPLOYEETYPE ";
					qry=qry+"AND B.QUALIFICATIONCODE=D.QUALIFICATIONCODE ";
					qry=qry+"AND F.SEX=DECODE(A.GENDER,'A',SEX,A.GENDER) ";
					qry=qry+"AND to_date(DATEOFSUBMISSION,'dd-mm-rrrr') ";
					qry=qry+"between decode(to_date('"+mDate11+"','dd-mm-rrrr'),'',to_date(DATEOFSUBMISSION,'dd-mm-rrrr'),";
					qry=qry+"to_date('"+mDate11+"','dd-mm-yyyy')) AND decode(to_date('"+mDate12+"','dd-mm-rrrr'),'',";
					qry=qry+"to_date(DATEOFSUBMISSION,'dd-mm-rrrr'),to_date('"+mDate12+"','dd-mm-yyyy')) ";
					qry=qry+"AND NOT EXISTS (select 1 From HR#APPLICATIONMASTER X, HR#INTERVIEWMASTER Y, ";
					qry=qry+"HR#INTERVIEWRESULT Z Where Z.COMPANYCODE=Y.COMPANYCODE ";
					qry=qry+"AND Z.INSTITUTECODE=Y.INSTITUTECODE AND Z.INTERVIEWCODE=Y.INTERVIEWCODE ";
					qry=qry+"AND X.APPLICANTID=Z.APPLICANTID AND ";
					qry=qry+"F.APPLICANTID=X.APPLICANTID AND ";
					qry=qry+"Z.INTERVIEWCODE=Y.INTERVIEWCODE and NVL(Y.DEACTIVE,'N')<>'Y' ";
					qry=qry+"AND NVL(Z.DEACTIVE,'N')<>'Y' AND ";
					qry=qry+"NVL(Y.LOCKINTERVIEW,'N')<>'Y'";
					qry=qry+"AND INTERVIEWDATE<=ADD_MONTHS(SYSDATE,-"+mInterMonths+")) ";
					qry=qry+" and rownum <= decode('"+mApplicantNo+"','0','100','"+mApplicantNo+"') order by TOTALMONTHEXPERIANCE desc";
					qry=qry+") ORDER BY "+mOrderBy+" "+mAsending+" ";*/
					//out.print(qry);
					rs=db.getRowset(qry);
					while(rs.next())
					{
						if(count==0)
						{
							%>
							<center>
							<table class="sort-table" id="table-1" cellpadding="0" cellspacing="0" border="2">
							<tr bgcolor="#ff8c00">
								<td><font color="white"><b>Sno.</b></font></td>
								<td><font color="white"><b><input type="checkbox" name="allCheck" value="all" id="allCheck" onClick="allChecked();">Check</b></font></td>
								<td><font color="white"><b>Applicant&nbsp;Name</b></font></td>
								<td><font color="white"><b>Father's&nbsp;Name</b></font></td> 
								<td nowrap align="center"><font color="white"><b>Main&nbsp;Qualification</b></font></td> 
								<td><font color="white"><b>Gender</b></font></td>
								<td><font color="white"><b>Experience</b></font></td> 
								<td><font color="white"><b>Date&nbsp;of&nbsp;Birth</b></font></td>
								<!-- <td><font color="white"><b>Current&nbsp;Org.</b></font></td>
								<td><font color="white"><b>Present&nbsp;Salary</b></font></td> -->
								<td><font color="white"><b>Marital&nbsp;Status</b></font></td>			
								<td><font color="white"><b>Sub.&nbsp;Date&nbsp;&nbsp;</b></font></td>
							</tr>
							<%
							count++;
						}
						%>
						<tr>
							<td><%=++mSno%>.</td>
							<td><input type="checkbox" value="<%=mSno%>" name="check<%=mSno%>" onClick="Checked();"></td>
							<td NOWRAP title="Click to View Detail of <%=gb.toTtitleCase(rs.getString("APPLICANTNAME"))%>">&nbsp;<a target=_new href="ViewDetailApplicant.jsp?AD=<%="!!!~~~"+rs.getString("APPLICANTID")+"^^^***"%>"><font color="blue"><b><%=gb.toTtitleCase(rs.getString("APPLICANTNAME"))%></b></font></a></td>
							 <td nowrap>&nbsp;<%=gb.toTtitleCase(rs.getString("FATHERNAME"))%></td>
							<td nowrap>&nbsp;<%=gb.toTtitleCase(rs.getString("QUALIFICATION"))%></td>
							<td>&nbsp;<%=gb.toTtitleCase(rs.getString("SEX"))%></td>		
							<%
							mExpInYear=Integer.parseInt(rs.getString("EXPERIENCEINMONTHS"));
							mExpInYear=mExpInYear/12;
							mExpInMonth=mExpInYear%12;								
							%>
							<td>&nbsp;Year&nbsp;<%=mExpInYear%>&nbsp;Month&nbsp;<%=mExpInMonth%></td>
							<td>&nbsp;<%=rs.getString("DATEOFBIRTH")%></td>
							<!-- <td>&nbsp;<%//=gb.toTtitleCase(rs.getString("PRESENTORGANISATION"))%></td>
							<td>&nbsp;<%//=gb.toTtitleCase(rs.getString("PRESENTSALARY"))%></td> -->
							<td>&nbsp;<%=gb.toTtitleCase(rs.getString("MARITALSTATUS"))%></td>
							<td>&nbsp;<%=gb.toTtitleCase(rs.getString("DATESUB"))%></td>
							<input type="hidden" name="ApplicantName<%=mSno%>" value="<%=gb.toTtitleCase(rs.getString("APPLICANTNAME"))%>">
							<input type="hidden" name="Sex<%=mSno%>" value="<%=gb.toTtitleCase(rs.getString("SEX"))%>">
							<input type="hidden" name="FaterName<%=mSno%>" value="<%=gb.toTtitleCase(rs.getString("FATHERNAME"))%>"> 
							<input type="hidden" name="Dob<%=mSno%>" value="<%=gb.toTtitleCase(rs.getString("DATEOFBIRTH"))%>">
							<input type="hidden" name="PresentSalary<%=mSno%>" value="<%=gb.toTtitleCase(rs.getString("PRESENTSALARY"))%>">
							<input type="hidden" name="Marital<%=mSno%>" value="<%=gb.toTtitleCase(rs.getString("MARITALSTATUS"))%>">
							<input type="hidden" name="DateofSub<%=mSno%>" value="<%=gb.toTtitleCase(rs.getString("DATESUB"))%>">
							<input type="hidden" name="Applicantid<%=mSno%>" value="<%=rs.getString("APPLICANTID")%>">
							<input type="hidden" name="PresentOrg<%=mSno%>" value="<%=gb.toTtitleCase(rs.getString("PRESENTORGANISATION"))%>">
							<input type="hidden" name="Exp<%=mSno%>" value="Year <%=mExpInYear%> Month <%=mExpInMonth%>">
							<input type="hidden" name="MainQuali<%=mSno%>" value="<%=gb.toTtitleCase(rs.getString("QUALIFICATION"))%>">
						</tr>
						<%
					}
					if(count>0)
					{
						%>
						<tr>
							<td colspan="20" align="center"><input type="submit" name="shortList" value="Short-Listed Selected Applicants" style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 230px; HEIGHT: 23px; FONT-VARIANT: normal; cursor:hand; background-color:; border-width:1;" onclick="return fun1();"></td>
						</tr>
						</table>
						</center>
						<input type="hidden" name="counter" value="<%=mSno%>" >
						<%
					}
				}
				if(count==0)
					out.print("<center><font face='arial' size=2 color=red><b>No record found.</b></font></center><center><a href='ShortListApplicant.jsp'>Back</a></center>");
			}	
			else
				out.print("<center><font face='arial' size=2 color=red><b>Please Fill the form properly</b></font></center><center><a href='ShortListApplicant.jsp'>Back</a></center>");							
		}
		else
		{
			%>
			<br>
			<font color=red>
			<h3><br><img src='images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
			<P> This page is not authorized/available for you.
			<br>For assistance, contact your network support team. 
			</font><br><br><br><br> 
			<%
		}
		//-----------------------------
	}
	else
	{
		out.print("<br><img src='images/Error1.jpg'>");
		out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}
}
catch(Exception e)
{/*out.print("Exception e"+e);*/}
%>
</form>
</body>
</html>