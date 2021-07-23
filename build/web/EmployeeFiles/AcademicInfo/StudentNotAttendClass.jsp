<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%

DBHandler db = new DBHandler();
ResultSet rs = null, rss = null;
GlobalFunctions gb = new GlobalFunctions();
String qry = "";
int CTR=0, TotStudAllow=0, TotStudConf=0, TotStudNotConf=0, TotalStudFeePaid=0, TotAllow=0, TotRegConf=0, TotRegNConf=0, TotFeePaid=0;
String mMemberID="", mDMemberID="", mMemberType="", mDMemberType="", mMemberCode="", mDMemberCode="", mMemberName="";
String mInst = "", mComp = "", mSrcType = "", mRightsID="", qsysdate="", mOldData="";
String mExam = "", qryexam="", mProgram="", mBranch="", mSemester="";
String mDept="", mDeptName="",QrySemType="",mSemType="";

if (session.getAttribute("InstituteCode") == null) 
	mInst = "";
else
	mInst = session.getAttribute("InstituteCode").toString().trim();

if (session.getAttribute("CompanyCode") == null)
	mComp = "";
else
	mComp = session.getAttribute("CompanyCode").toString().trim();

if (session.getAttribute("MemberID") == null)
	mMemberID = "";
else
	mMemberID = session.getAttribute("MemberID").toString().trim();

if (session.getAttribute("MemberID") == null)
	mMemberID = "";
else
	mMemberID = session.getAttribute("MemberID").toString().trim();

if (session.getAttribute("MemberType") == null)
	mMemberType = "";
else
	mMemberType = session.getAttribute("MemberType").toString().trim();

if (session.getAttribute("MemberName") == null)
	mMemberName = "";
else
	mMemberName = session.getAttribute("MemberName").toString().trim();

if (session.getAttribute("MemberCode") == null)
	mMemberCode = "";
else
	mMemberCode = session.getAttribute("MemberCode").toString().trim();

if (request.getParameter("SrcType") == null)
	mSrcType = "A";
else
	mSrcType = request.getParameter("SrcType").toString().trim();

 if (mSrcType.equals("I")) {
            mRightsID = "83";
        }
        if (mSrcType.equals("A")) {
            mRightsID = "87";
        }
        if (mSrcType.equals("H")) {
            mRightsID = "84";
        }

String mHead = "";
if (session.getAttribute("PageHeading") != null && !session.getAttribute("PageHeading").equals(""))
	mHead = session.getAttribute("PageHeading").toString().trim();
else
	mHead = "JIIT ";

%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [Student Not Attended Class] </TITLE>
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



</script>
<script>
if(window.history.forward(1) != null)
	window.history.forward(1);

</script>

<SCRIPT language=javascript>

function AlertMe()
{

//alert(dd.twait.value+"LL");
dd.twait.value='';
}
</script>

</head>
<body onload="AlertMe()" aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
try
{
	if (!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
	{
      	OLTEncryption enc = new OLTEncryption();
		mDMemberID = enc.decode(mMemberID);
            mDMemberCode = enc.decode(mMemberCode);
            mDMemberType = enc.decode(mMemberType);

		// out.print(mDMemberType);

            String mChkMemID = enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType = enc.decode(session.getAttribute("MemberType").toString().trim());
            String mIPAddress = session.getAttribute("IPADD").toString().trim();
            String mRole = enc.decode(session.getAttribute("ROLENAME").toString().trim());
            ResultSet RsChk = null;
            //-----------------------------
            //-- Enable Security Page Level
            //-----------------------------
            qry = "Select WEBKIOSK.ShowLink('" + mRightsID + "','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";
            //out.print(qry);
            RsChk = db.getRowset(qry);
            if (RsChk.next() && RsChk.getString("SL").equals("Y")) 
		{
			qry = "select to_Char(Sysdate,'dd-mm-yyyy hh:mi PM') date1 from dual";
			rs = db.getRowset(qry);
			if (rs.next()) 
			{
                  	qsysdate = rs.getString(1);
			}
			else
			{
                        qsysdate = "";
                  }
			//----------------------
			%>
			<form name="frm1" id="frm1" method="get">
            	<input id="x" name="x" type=hidden>
				  <Input Type=hidden name="SrcType" Value=<%=mSrcType%>>
	            <table align=center><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: Arial"><B><U>Student Not Attended Classes </U></b></font></TABLE>
      	      <table id=id2 cellpadding=1 cellspacing=1  align=center rules=groups border=2>

            	<!--****Exam Code****-->

			<tr><td nowrap>
			<FONT color=black face=Arial size=2><b>Exam Code</b></FONT>
                	<%
                  try
			{
				
				//*************01/02/2010 added in the qry=NVL(LOCKEXAM,'N')='N'****************
				
				qry = " Select REGCODE RegCode, ExamCode Exam, EXAMPERIODFROM FROM (";
				qry += " Select A.REGCODE REGCODE, A.ExamCode ExamCode, B.EXAMPERIODFROM EXAMPERIODFROM from StudentRegistration A, ExamMaster B";
				qry += " Where A.INSTITUTECODE=B.INSTITUTECODE  AND NVL(LOCKEXAM,'N')='N' and A.EXAMCODE=B.EXAMCODE AND B.INSTITUTECODE='"+mInst+"' AND nvl(B.Deactive,'N')='N'";
				qry += " Group By A.REGCODE, A.ExamCode, B.EXAMPERIODFROM order by EXAMPERIODFROM DESC) where rownum<=8 order by 2 desc";
				//out.print(qry);
				rs = db.getRowset(qry);
				if (request.getParameter("x") == null) 
					{
                        	%>
	                        <Select Name=Exam tabindex="0" id="Exam" style="WIDTH: 120px">
      				<%
                              while (rs.next()) 
					{
                                    mExam = rs.getString("Exam");
                                    if (qryexam.equals("")) 
						{
							qryexam = mExam;
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
            		      <select name=Exam tabindex="0" id="Exam" style="WIDTH: 120px">
					<%
					while (rs.next())
					{
                                   	mExam = rs.getString("Exam");
	                        	if (mExam.equals(request.getParameter("Exam").toString().trim())) 
						{
	                              	qryexam = mExam;
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
			catch (Exception e)
			{
                       	// out.println("Error Msg");
			}
			%>
			&nbsp;
		




<font color=black face=arial size=2><STRONG>&nbsp; &nbsp; Academic Year</STRONG></font>
	<%
String mAcadYr="",QryAcadYr="";

	  qry="select 'ALL' AcademicYear from dual union all (Select Distinct AcademicYear from StudentRegistration where institutecode='"+mInst+"' and studentid in (select studentid from studentltpdetail where nvl(DEACTIVE,'N')='N' ) ) Order By AcademicYear Desc";
	  rs=db.getRowset(qry);
	  //out.print(qry);
	%>
	<select name=ACAD tabindex="0" id="ACAD" style="WIDTH: 120px">
	<%
	try
	{
 	if(request.getParameter("x")==null)
	{
		while(rs.next())
		{
		 	mAcadYr=rs.getString("AcademicYear");
			if(QryAcadYr.equals(""))
 			{			
				QryAcadYr=mAcadYr;
				%>
				<OPTION Selected Value =<%=mAcadYr%>><%=mAcadYr%></option>
				<%
			}
			else
			{
				%>
				<option value=<%=mAcadYr%>><%=mAcadYr%></option>
				<%
			}
		}
	}
	else
	{
		while(rs.next())
		{
		   mAcadYr=rs.getString("AcademicYear");			
		   if(mAcadYr.equals(request.getParameter("ACAD").toString().trim()))
		   {	
			QryAcadYr=mAcadYr;
			%>
			<option selected value=<%=mAcadYr%>><%=mAcadYr%></option>
	 		<%
		   }
		   else
		   {
			%>
			<option  value=<%=mAcadYr%>><%=mAcadYr%></option>
			<%
		   }
		}
	}
	}
	catch(Exception e)
	{
	}
	%>
	</select>
&nbsp; &nbsp;
		<font color=black face=arial size=2><STRONG>&nbsp; &nbsp; Program Code</STRONG></font>
	<%
String mProgCode="",QryProgCode="";


	  qry=" select 'ALL' ProgramCode from dual union all (Select Distinct ProgramCode from StudentRegistration where institutecode='"+mInst+"' and  studentid in (select studentid from studentltpdetail where nvl(DEACTIVE,'N')='N' ) and PROGRAMCODE not LIKE 'PHD%') Order By ProgramCode";
	  rs=db.getRowset(qry);
	  //out.print(qry);
	%>
	<select name="PROG" tabindex="0" id="PROG" style="WIDTH: 120px">
	<%
	try
	{
 	if(request.getParameter("x")==null)
	{
		while(rs.next())
		{
		 	mProgCode=rs.getString("ProgramCode");
			if(QryProgCode.equals(""))
 			{			
				QryProgCode=mProgCode;
				%>
				<OPTION Selected Value =<%=mProgCode%>><%=mProgCode%></option>
				<%
			}
			else
			{
				%>
				<option value=<%=mProgCode%>><%=mProgCode%></option>
				<%
			}
		}
	}
	else
	{
		while(rs.next())
		{
		   mProgCode=rs.getString("ProgramCode");			
		   if(mProgCode.equals(request.getParameter("PROG").toString().trim()))
		   {	
			QryProgCode=mProgCode;
			%>
			<option selected value=<%=mProgCode%>><%=mProgCode%></option>
	 		<%
		   }
		   else
		   {
			%>
			<option  value=<%=mProgCode%>><%=mProgCode%></option>
			<%
		   }
		}
	}
	}
	catch(Exception e)
	{
	}
	%>
	</select>
	


			</td>
			</TR>
			<TR>
			<td>
<FONT color=black face=Arial size=2><b> Semester Type </b></FONT>
<select name=SemType id=SemType>
<%

if(request.getParameter("SemType")==null)
{
	if(QrySemType.equals(""))
		QrySemType=mSemType;
	%>
	
	<option value='REG'>REG</option>          
	<option selected value='RWJ'>RWJ-SAP</option>
		<option  value='SUP'>SUP</option>
	<%
}
else
{
	mSemType=request.getParameter("SemType").toString().trim();
	QrySemType=mSemType;
	if(mSemType.equals("ALL"))
	{
		%>
		<!--<option selected value='ALL'>ALL</option>-->
		<option value='REG'>REG</option>
		<option value='RWJ'>RWJ-SAP</option>
		<option selected value='SUP'>SUP</option>
 		<%
	}
	else if(mSemType.equals("REG"))
	{
		%>
		<!--<option value='ALL'>ALL</option>-->
		<option selected value='REG'>REG</option>
	   	<option value='RWJ'>RWJ-SAP</option>
		<option  value='SUP'>SUP</option>
 		<%
	}	
	else if(mSemType.equals("SUP"))
	{
		%>
		<!--<option value='ALL'>ALL</option>-->
		<option value='REG'>REG</option>
	  	<option  value='RWJ'>RWJ-SAP</option>
		<option  selected value='SUP'>SUP</option>
		<%
	}


else 
	{
		%>
		<!--<option value='ALL'>ALL</option>-->
		<option value='REG'>REG</option>
	  	<option selected value='RWJ'>RWJ-SAP</option>
		<option  value='SUP'>SUP</option>
		<%
	}

}
%>
			</select>
			&nbsp; &nbsp; &nbsp;<Input Type=submit name=submit value="Show/Refresh"/>		</TD>
			</tr></table>
			</form>
			<BR>
			<!--<CENTER><Font face=arial size=2 color=navy><B>Attendance Not Done </B></FONT></CENTER> -->
			<%

if(request.getParameter("x")!=null)
			{

%>
<form name="dd" id="dd">
<center>
<input style="width:210px;font-size:20px; 
	color:red;font-weight:bold;BORDER-LEFT: c00000 0px solid;BORDER-TOP: c00000 0px solid;
	BORDER-RIGHT: c00000 0px solid;BORDER-BOTTOM: c00000 0px solid ; background-color:transparent"  name="twait" id="twait" readonly type="text" value="Please Wait.......">
</center>
</form>

<form name="frm" >
	<%
			if(request.getParameter("Exam")==null)
				qryexam=qryexam;
			else
				qryexam=request.getParameter("Exam").toString().trim();

if(request.getParameter("SrcType")==null)
				mSrcType="";
			else
				mSrcType=request.getParameter("SrcType").toString().trim();

if(request.getParameter("SemType")==null)
				mSemType="";
			else
				mSemType=request.getParameter("SemType").toString().trim();
			//out.print("Default Exam Code - "+qryexam);

			if(request.getParameter("ACAD")==null)
			QryAcadYr="";
		else
			QryAcadYr=request.getParameter("ACAD").toString().trim();	

		if(request.getParameter("PROG")==null)
			QryProgCode="";
		else
			QryProgCode=request.getParameter("PROG").toString().trim();	

String mSubject="",QryEmpID="",qry2="",OldEnNo="",OldEnNo1="",QryExam="",mREGCONFIRMATIONDATE="",OldSubj="",OldLTPVal="";
ResultSet rsBatchDate=null;
ResultSet rs11=null,rs1=null;
String mStudentid="",qry1="";
int CTR1=0,Ctr=0;

long QryTotCls=0, QryTotPrs=0 ;
long mCutOffVal=0,QryPercAtt=0;


qry="select distinct A.Studentid Studentid, A.StudentName StudentName, A.EnrollmentNo EnrollmentNo, A.FSTID FSTID, A.SUBJECTID SUBJECTID, A.SUBJECTCODE SUBJECTCODE, A.SUBJECT SUBJECT, A.LTP LTP, A.SEMESTER SEMESTER, A.SECTIONBRANCH SECBR, A.SUBSECTIONCODE SUBSEC,a.ACADEMICYEAR,NVL(a.SEMESTERTYPE,' ')SEMESTERTYPE,a.employeeid ,A.PROGRAMCODE From v#studentltpdetail A";
qry=qry+" where  A.ExamCode='"+qryexam+"' and A.PROGRAMCODE not LIKE 'PHD%' and nvl(A.STUDENTDEACTIVE,'N')='N' and nvl(A.DEACTIVE,'N')='N'   and A.INSTITUTECODE='"+mInst+"' and A.ACADEMICYEAR=decode('"+QryAcadYr+"','ALL',A.ACADEMICYEAR,'"+QryAcadYr+"') and A.programcode=decode('"+QryProgCode+"','ALL',A.programcode,'"+QryProgCode+"')  ";
		
			
			                         if(mSemType.equals("RWJ"))
									qry=qry+" AND A.SEMESTERTYPE IN ('RWJ', 'SAP') ";
								else  if(mSemType.equals("REG"))
									qry=qry+" AND A.SEMESTERTYPE IN ('REG') ";
			                    else
			                      qry=qry+" AND A.SEMESTERTYPE IN ('SUP') ";
			
			
			
			qry=qry+" AND NVL(A.PROJECTSUBJECT,'N')<>'Y'  and a.subject NOT LIKE '%PROJECT%' ";

qry=qry+"UNION ALL select distinct A.Studentid Studentid, A.StudentName StudentName, A.EnrollmentNo EnrollmentNo, A.FSTID FSTID, A.SUBJECTID SUBJECTID, A.SUBJECTCODE SUBJECTCODE, A.SUBJECT SUBJECT, A.LTP LTP, A.SEMESTER SEMESTER, A.SECTIONBRANCH SECBR, A.SUBSECTIONCODE SUBSEC,a.ACADEMICYEAR,NVL(a.SEMESTERTYPE,' ')SEMESTERTYPE,a.employeeid ,A.PROGRAMCODE From v#studentltpdetail A";
qry=qry+" where  A.ExamCode='"+qryexam+"' and A.PROGRAMCODE not LIKE 'PHD%' and nvl(A.STUDENTDEACTIVE,'N')='N' and nvl(A.DEACTIVE,'N')='N'   and A.INSTITUTECODE='"+mInst+"' and A.ACADEMICYEAR=decode('"+QryAcadYr+"','ALL',A.ACADEMICYEAR,'"+QryAcadYr+"') and A.programcode=decode('"+QryProgCode+"','ALL',A.programcode,'"+QryProgCode+"')  ";
		
			
			                         if(mSemType.equals("RWJ"))
									qry=qry+" AND A.SEMESTERTYPE IN ('RWJ', 'SAP') ";
								else  if(mSemType.equals("REG"))
									qry=qry+" AND A.SEMESTERTYPE IN ('REG') ";
			                    else
			                      qry=qry+" AND A.SEMESTERTYPE IN ('SUP')  AND NVL (a.projectsubject, 'N') <> 'Y'            and a.subject  LIKE 'PROJECT MANAGEMENT'       ORDER BY enrollmentno, subject, ltp, fstid  ";

					rs11=db.getRowset(qry);
					rs=db.getRowset(qry);
		//	out.print(qry); 
			//and a.enrollmentno='10102290' 
			String QryLTPVal="";
			QryExam=qryexam;

	//	if(rs.next())
			

			while(rs11.next())
			{
				
			if(!OldEnNo.equals(rs11.getString("EnrollmentNo")) || !OldSubj.equals(rs11.getString("SUBJECTID")) )
			{
						//CTR++;
						OldEnNo=rs11.getString("EnrollmentNo");
						OldSubj=rs11.getString("SUBJECTID");
				
			
				
				
				Ctr++;
				mSubject=rs11.getString("SUBJECTID");
				
				//out.print(mSubject);

				mStudentid=rs11.getString("Studentid");
				QryLTPVal=rs11.getString("LTP");
				if(QryLTPVal.equals("L") || QryLTPVal.equals("T"))
					QryLTPVal="'L','T'";
				else
					QryLTPVal="'P'";

				QrySemType=rs11.getString("SEMESTERTYPE").toString().trim();
				//QryEmpID=rs11.getString("employeeid").toString().trim();



			/*		qry2=" Select distinct nvl(to_char(REGCONFIRMATIONDATE,'dd-mm-yyyy'),' ') REGCONFIRMATIONDATE  From StudentRegistration Where INSTITUTECODE='"+mInst+"'";
					qry2=qry2+" AND EXAMCODE='"+QryExam+"' ";
					qry2=qry2+" AND SEMESTER='"+rs11.getString("SEMESTER")+"' AND NVL(SEMESTERTYPE,' ')='REG' ";
					qry2=qry2+" AND STUDENTID='"+rs11.getString("STUDENTID")+"' ";					
					qry2=qry2+" AND ACADEMICYEAR='"+rs11.getString("ACADEMICYEAR")+"' ";
//out.print(qry2);
					rsBatchDate=db.getRowset(qry2);
					 if(rsBatchDate.next())
					{
						if(rsBatchDate.getString("REGCONFIRMATIONDATE")==null) 
							mREGCONFIRMATIONDATE="";
						else
							mREGCONFIRMATIONDATE=rsBatchDate.getString(1);
					}
					else
					{
						mREGCONFIRMATIONDATE="";
					}
*/
				//out.print(QryLTPVal);
				if(Ctr==1)
				{
					%>
					<TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 border=1>
					<thead>
					<tr bgcolor="#ff8c00">
					 <td nowrap align=left><b><font color="White">SNo.</font></b></td> 
					 <td nowrap align=left><b><font color="White">Student</font></b></td> 
					 <td nowrap align=left><b><font color="White">Subject</font></b></td> 
					 <td nowrap align=center><b><font color="White">LTP</font></b></td> 
					 <td nowrap align=center><b><font color="White">Attendance (%)</font></b></td> 
					</tr>
					</thead>
					<tbody>
					<%
				}



String mLFSTID="";
String mTFSTID="";
String mPFSTID="";
String prevLFSTID="";
String prevTFSTID="";
String prevPFSTID="";
  mMemberID=mStudentid;
String mINSTITUTECODE=mInst;

int QrySem=rs11.getInt("SEMESTER");
/*
qry1="SELECT   count(pcount ) pcount FROM (select distinct  CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"' AND  a.ltp IN ("+QryLTPVal+") and a.studentid='"+mMemberID+"'   ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) )   ";
qry1=qry1+" UNION   ";
qry1=qry1+" select   distinct CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE where  subjectid ='"+mSubject+"'     AND ltp IN ("+QryLTPVal+")    ";
qry1=qry1+" AND examcode =  '"+QryExam+"'   AND studentid = '"+mMemberID+"'   ";       
qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mINSTITUTECODE+"'  )";       
//if(mMemberID.equals("J1281100708"))
//	out.print(qry1);
rs1=db.getRowset(qry1);
while(rs1.next())
		{
		QryTotCls=rs1.getLong("pcount");
		}
*/

qry1="SELECT   count(pcount ) pcount FROM (select distinct   CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"' AND   a.ltp IN ("+QryLTPVal+") and a.studentid='"+mMemberID+"' and nvl(a.present,'N')='Y' ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N'  ";
qry1=qry1+" UNION   ";
qry1=qry1+" select  distinct  CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE where  subjectid ='"+mSubject+"'     AND ltp IN ("+QryLTPVal+")    ";
qry1=qry1+" AND examcode =  '"+QryExam+"'   AND studentid = '"+mMemberID+"' and nvl(present,'N')='Y' ";       
qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mINSTITUTECODE+"' )";       
//if(mMemberID.equals("J1281100708"))
//	out.print(qry1);;
rs1=db.getRowset(qry1);

while(rs1.next())
		{
		QryTotPrs=rs1.getLong("pcount");
			
		}	

		QryPercAtt	=QryTotPrs;	
				
/*		
				try
				{
					if(QryTotCls==0)
						QryPercAtt=0;
					else
						QryPercAtt=Math.round((QryTotPrs*100)/QryTotCls);

				//	out.print(QryTotCls+" "+QryTotPrs+" Tot Percentage - "+QryPercAtt);
				}
				catch(ArithmeticException e)
				{
					//out.print(e);
				}
*/
				//out.print("<br>"+mCutOffVal+"xxxx"+QryPercAtt+"QryPercAtt::"+QryTotPrs+"QryTotPrs::"+QryTotCls+"QryTotCls::");
				if(QryPercAtt<=mCutOffVal)
				{
					//out.print("SSS"+rs.getString("SUBJECT"));
					%>
					<tr>
					
					<%
					if(!OldEnNo1.equals(rs11.getString("EnrollmentNo")))
					{
							CTR++;
						OldEnNo1=rs11.getString("EnrollmentNo");
							%>
						<td align=right><%=CTR%>. &nbsp; &nbsp; &nbsp; </td>
						<td nowrap>
						<%=rs11.getString("StudentName")%> &nbsp; [<%=rs11.getString("EnrollmentNo")%>]
					<%	
					}
					else
					{
						%>
						<td align=right> &nbsp; </td>
						<td nowrap>
						--</td>
					<%	
						
					}

						%>
						
						
						<td nowrap><%=rs11.getString("SUBJECT")%> &nbsp; [<%=rs11.getString("SUBJECTCODE")%>]</td>
						<%
						if(QryLTPVal.equals("'P'"))
						{
							%>
							<td nowrap align=center>P</td>
							<td nowrap align=center><%=QryPercAtt%></td>
							<%
						}
						else
						{
							%>
							<td nowrap align=center>L and/or T</td>
							<td nowrap align=center><%=QryPercAtt%></td>
							<%
						}
					

					
					
					%>
					</tr>	
					<%
				}
			}
			}

			%>
			</TABLE>

<%
	if(Ctr==0)
	{
		%>

 <Table align=center cellpadding=0 cellspacing=0 border=1 bordercolor=transparent><tr bgcolor=transparent><td align=center><font color=red>No Record Found..</a></font></TD></TR></TABLE> 
			</form>

			
			

			<%
	}
	else
				{
	%>

 <Table align=center cellpadding=0 cellspacing=0 border=1 bordercolor=transparent><tr bgcolor=transparent><td align=center><font color=blue><a style="cursor:hand" onClick="window.print();"><img width=30 height=30 src="../../Images/printer.gif">Click to Print</a></font></TD></TR></TABLE> 
			</form>

			
			

			<%}
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
} catch (Exception e)
{
}
%>
</body>
</html>