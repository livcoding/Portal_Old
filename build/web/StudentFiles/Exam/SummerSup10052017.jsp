

<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.lang.*" %>
<%@ page errorPage="CommonFiles/ExceptionHandler.jsp" %> 
<%  

DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null,rsi=null,rs2=null;
GlobalFunctions gb =new GlobalFunctions();
String  qry1="",qry2="";
String mMemberID="";
String mMemberType="";
String mMemberName="";
String mMemberCode="",mInst="",mDMemberCode="",mWebEmail="";

ResultSet  StudentRecordSet=null; 	  
String qry="";
String mName ="";
String mEnrollment="";
String mInstituteCode="",mInstName="";
String mSID="";
String mSname="";
String mProg="";
String mBranch="";
long  FeeAmt=0;
String mSem="",mObjName="",mexamcode="",QryExam="",mPrevExmCode="",mComp="",Quota="";
String qrydebar="";
ResultSet  rsdebar=null;
int mSems=0;
int mFlag=0;	
String mAcad="",mColor="";
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
	if (session.getAttribute("InstituteCode")==null )
	{
		mInst="";
	}
	else
	{
	   mInst=session.getAttribute("InstituteCode").toString().trim();
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
}


if (session.getAttribute("MemberName")==null)
{
	mName="";
}
else
{
	mName=session.getAttribute("MemberName").toString().trim();
}


if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}

if (session.getAttribute("AcademicYearCode")==null)
{
	mAcad="";
}
else
{
	mAcad=session.getAttribute("AcademicYearCode").toString().trim();
}

//out.print(mAcad+"iksdfklsf");

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE> <%=mHead%> [Summer Semester Registration Form]</TITLE>
<script type="text/javascript" src="../js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="../css/sortabletable.css" />


<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
<script language="JavaScript" type ="text/javascript">
function FunCheck(cc,sno)
{
	var Srno=document.frm1.SrNo.value;
	var macad=document.frm.mAcad.value;
	//alert(macad+"--");
	var sum=0,ccc=0,x=0 , ac=0;
	for(i=1;i<=Srno;i++)
	{
		check=document.frm1["Checked"+i].checked ;

		if(check==true)
		{
	ac++;
			ccc=document.frm1["CourseCredit"+i].value;
				//alert(ccc+"CCCC");
			sum=sum+parseInt(ccc);
			
			//alert(document.frm1["ProjectSub"+i]+"LLL");
			if(document.frm1["ProjectSub"+i].value=='Y')
				{
					x++;
				}


		}


	}

if(ac>2 && macad=="1112")
	{
alert("Please Select only 2 subjects");
document.frm1["Checked"+sno].checked =false;
return false;
	}

	//alert(sum+"KKK");

//alert(sum+"KKK");
		if(x>1)
		{
		alert("You can select only One Project !");

		document.frm1["Checked"+sno].checked =false;
		return false;

		}


	if(sum>12)
	{
		alert("Maximum Course Credit Point allowed is 12 ");

		document.frm1["Checked"+sno].checked =false;
		return false;
	}
	
}

function CheckProgram()
	{
		
		var chk=document.frm1.Checked;
	
		var tt=false;	

		if(chk.length==undefined  )
		{
			if(chk.checked==true)
			{
				tt=true;
			}
			
		}

		for(var i=0;i<chk.length;i++)
		{
			
		
			if(chk[i].checked==true)
			{
				tt=true;
			}
			
		}
		if(tt==false)
			{
				alert('Please Select the Subject');
					return false;
			}
			
	}
</script>

</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 background="../../Images/Speciman.jpg">
<%

//if(!mAcad.equals("0910"))
//if(1==1)
//{

try
{
	OLTEncryption enc=new OLTEncryption();
	if(!mMemberID.equals("") && !mMemberCode.equals("")) 
	{
	mDMemberCode=enc.decode(mMemberCode);
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
qry="Select WEBKIOSK.ShowLink('270','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{



%>
<form name="frm" method=post>
		<input id="mAcad" name="mAcad" value="<%=mAcad%>" type=hidden>

			<input id="x" name="x" type=hidden>
			<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
			<tr>
			<TD align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><u><b>SUMMER SEMESTER
			
			</b></U>
			</font>
			</td>
			</tr>
			</table>
			<table rules=groups cellspacing=1 cellpadding=1 align=center border=1>
			<tr><td><font color=#00008b face=arial size=2><STRONG>&nbsp; Name:&nbsp;</STRONG></font><font face="Vardana"><%=GlobalFunctions.toTtitleCase(mName)%> [<%=mDMemberCode%>]</font>
			&nbsp;&nbsp;<font color=#00008b face=arial size=2><STRONG>Course/Branch:&nbsp;</STRONG></font><font face="Vardana"><%=mProg%>(<%=mBranch%>)</font>
			&nbsp;&nbsp;<font color=#00008b face=arial size=2><STRONG>Current Semester:&nbsp;</STRONG></font><font face="Vardana"><%=mSem%></font></td></tr>
			<tr><td ALIGN=CENTER><HR><font color=#00008b face=arial size=2><STRONG>&nbsp; Exam Code</STRONG></font>
			<%
			qry="select distinct nvl(examcode,' ')examcode, EXAMPERIODFROM from exammaster where institutecode='"+mInst+"' AND eXAMCODE LIKE '%SUMM%' and nvl(deactive,'N')='N' and nvl(LOCKEXAM,'N')='N'  and  trunc(sysdate) >= trunc(examperiodfrom) and trunc(sysdate) <=trunc(examperiodto)   order by examcode Desc";
			//out.println(qry);
			rs=db.getRowset(qry);
			%>
			<select name="exam" tabindex="0" id="exam" style="WIDTH: 200px">	
			<option selected value='' > << Select Exam Code  >>  </option>
			<%
			if(request.getParameter("x")==null)
			{
				while(rs.next())
				{
				 	mexamcode=rs.getString("examcode");
					if(mexamcode.equals(""))
						QryExam=mexamcode;
					%>
					<option value=<%=mexamcode%>><%=mexamcode%></option>
					<%
				}
			}
			else
			{
				while(rs.next())
				{
			   		mexamcode=rs.getString("examcode");			
					if(mexamcode.equals(request.getParameter("exam").toString().trim()))
					{
						QryExam=mexamcode;
						%>
					    	<option selected value=<%=mexamcode%>><%=mexamcode%></option>
						<%
					}
					else
					{
					    	%>
			    			<option  value=<%=mexamcode%>><%=mexamcode%></option>
			   			<%
					}
				}
			}
			%>
			</select>
			&nbsp;<input type="submit" value="Show">
			
			<br>
<br>	
	
			
			</td></tr>
			</table>
			</form>
			<%
			if(request.getParameter("x")!=null)
			{
				

				if(request.getParameter("exam")==null)
				{
					QryExam="";
				}
				else
				{
					 QryExam=request.getParameter("exam").toString().trim();
				}
			
		qry="Select EnrollmentNo enrollmentno,Studentname Name, StudentID , Semester, nvl(ProgramCODE,'UNK') ProgramCode, nvl(BranchCode,'UNK') BranchCode,quota From StudentMaster where studentid='"+mChkMemID+"' and InstiTuteCode='"+mInst+"'";
		//out.print(qry);
	 
  StudentRecordSet = db.getRowset(qry); 	
  if (StudentRecordSet.next())
  { 
	mEnrollment=StudentRecordSet.getString("enrollmentno");
	mSID=StudentRecordSet.getString("StudentID");
	mSname=StudentRecordSet.getString("Name");
	mProg=StudentRecordSet.getString("ProgramCode");
	mBranch=StudentRecordSet.getString("BranchCode");
	mSem=StudentRecordSet.getString("Semester");
	Quota=StudentRecordSet.getString("quota");
  }
//  out.print("sdfsdfsfsfd");

//*********12-03-2010***********************

int mMaxsem=0;
double mMinsem=5.2;

qry1=" SELECT max(semester)sem FROM STUDENTSGPACGPA  WHERE studentid = '"+mChkMemID+"' and institutecode = '"+mInst+"' ";  
rs1=db.getRowset(qry1);
if(rs1.next())
	mMaxsem=rs1.getInt("sem");


String mSumRegCode="";
long mSupFees=0;

qry="SELECT PREVEXAMCODE, SUPREGCODE FROM EXAMMASTER where InstiTuteCode='"+mInst+"' and examcode='"+QryExam+"' and NVL(LOCKEXAM,'N')='N'";
//out.println(qry);
rs=db.getRowset(qry);
if(rs.next())
{
	mPrevExmCode=rs.getString("PREVEXAMCODE");
	mSumRegCode=rs.getString("SUPREGCODE");
}
//*********12-03-2010***********************

/*qry="SELECT 'Y' FROM DEBARSTUDENTDETAIL WHERE EXAMCODE='"+mPrevExmCode+"' AND INSTITUTECODE='"+mInst+"' AND studentid='"+mChkMemID+"' and NVL(REGISTEREDSTATUS,'N')='N'";
//out.print(qry);
rs=db.getRowset(qry);
//rs1=db.getRowset(qry);
if(!rs.next())
{*/

%>
	

	
<form name="frm1" method=post action="SummerSupAction.jsp">
	<TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="100%" border=1 >
	<tr bgcolor=#ff8c00>
	<td><FONT COLOR=WHITE><b>Enrollment No</b></font></td>
	<td><FONT COLOR=WHITE><b>Student Name</b></font></td>
	<td><FONT COLOR=WHITE><b>Programme</b></font></td>
	<td><FONT COLOR=WHITE><b>Branch</b></font></td>
	<td><FONT COLOR=WHITE><b>Semester</b></font></td>
	</tr>
	<tr bgcolor='white'>
	<td><FONT COLOR=black><b><%=mEnrollment%></b></font></td>
	<td><FONT COLOR=black><b><%=mSname%></b></font></td>
	<td><FONT COLOR=black><b><%=mProg%></b></font></td>
	<td><FONT COLOR=black><b><%=mBranch%></b></font></td>
	<td><FONT COLOR=black><b><%=mSem%></b></font></td>
	</tr>

<INPUT TYPE="hidden" NAME="EnrollmentNo" ID="EnrollmentNo" value="<%=mEnrollment%>">

<INPUT TYPE="hidden" NAME="StudentID" ID="StudentID" value="<%=mSID%>">

<INPUT TYPE="hidden" NAME="Name" ID="Name" value="<%=mSname%>">

<INPUT TYPE="hidden" NAME="ProgramCode" ID="ProgramCode" value="<%=mProg%>">

<INPUT TYPE="hidden" NAME="BranchCode" ID="BranchCode" value="<%=mBranch%>">

<INPUT TYPE="hidden" NAME="Semester" ID="Semester" value="<%=mSem%>">

<INPUT TYPE="hidden" NAME="quota" ID="quota" value="<%=Quota%>">


<INPUT TYPE="hidden" NAME="SumRegCode" ID="SumRegCode" value="<%=mSumRegCode%>">

<INPUT TYPE="hidden" NAME="SumExamCode" ID="SumExamCode" value="<%=QryExam%>">

<INPUT TYPE="hidden" NAME="PrevExmCode" ID="PrevExmCode" value="<%=mPrevExmCode%>">

<INPUT TYPE="hidden" NAME="mMaxsem" ID="mMaxsem" value="<%=mMaxsem%>">



	<Tr bgcolor=white>
		<td COLSPAN=5><b>&nbsp;&nbsp;</td>
	</Tr>

	<TR><TD COLSPAN=5>
	<TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="100%" border=1 >
	<TR BGCOLOR=#ff8c00>
	<TD><FONT COLOR=WHITE><b>Sr.No</b></FONT></TD>
		<TD><FONT COLOR=WHITE><b>Subject Type</b></FONT></TD>
	<TD><FONT COLOR=WHITE><b>Subject Code</FONT></TD>
	<TD><FONT COLOR=WHITE><b>Subject Name</FONT></TD>
	<TD><FONT COLOR=WHITE><b>Semester</FONT></TD>
	<TD><FONT COLOR=WHITE><b>Grade</FONT></TD>
	<TD><FONT COLOR=WHITE><b>Credits</FONT></TD>
	<TD><FONT COLOR=WHITE><b>Fee Amount </FONT></TD>
	<TD align=center><FONT COLOR=WHITE><b>Click to Select</b><sup>*</sup></FONT></TD>
	</TR>
     <%
	int sno=0,mFLAG=0;
	double ctot=0;
	String Checked="";
/*
qry="SELECT DISTINCT C.enrollmentno en2, c.subjectid subjectid, c.subject,                c.subjectcode, c.semester, ' ' grade, a.coursecreditpoint,                a.supfees           FROM offersubjecttagging a,                DEBARSTUDENTDETAIL b,                 v#studentltpdetail c          WHERE a.institutecode = '"+ mInst +"'         AND  C.STUDENTID=B.STUDENTID             AND c.subjectid = a.subjectid            AND b.subjectid = a.subjectid            AND c.subjectid = b.subjectid            AND NVL (b.DEBAR, 'N') = 'Y' AND NVL(b.REGISTEREDSTATUS,'N')='N'            AND a.examcode = '"+QryExam+"'                       AND NVL (C.deactive, 'N') = 'N'                        AND a.institutecode = C.institutecode                        AND a.institutecode = b.institutecode                        AND a.institutecode = c.institutecode                        AND c.institutecode = b.institutecode                        AND NVL (C.deactive, 'N') = 'N'            AND C.studentid = '"+mChkMemID+"' AND (C.studentid, C.subjectid) IN (                  SELECT studentid, subjectid                     FROM debarstudentdetail                    WHERE examcode = '"+mPrevExmCode+"'                        AND studentid ='"+mChkMemID+"'                      AND institutecode = '"+ mInst +"'                      ) union ";*/


// Elective subjects
qry="SELECT DISTINCT NVL(en2,'N') en2, NVL(subjectid,'N') subjectid,NVL(subject,' ')subject,NVL( subjectcode,' ')subjectcode               , NVL( semester,'0')semester , NVL(GRADE,' ') grade,NVL(  coursecreditpoint, '0')coursecreditpoint,              NVL( supfees,'0')   supfees,             NVL(BASKET,'N') basket  FROM ( ";


if(Integer.parseInt(mSem)>=7)
				{
/*Change by Gyan at 25jun,2015*/
qry=qry+"SELECT DISTINCT nvl(c.enrollmentno,'N') en2, NVL(b.subjectid,'N') subjectid, NVL(b.subject,'N')subject,NVL( b.subjectcode,'N')subjectcode, NVL(c.semester,'0')semester, NVL(' ',' ') grade, NVL(a.coursecreditpoint,'0')coursecreditpoint,                NVL(a.supfees,'0')supfees   ,decode(a.BASKET,'A','CORE','B','ELECTIVE','D','ELECTIVE','',a.BASKET)BASKET         FROM offersubjecttagging a, studentmaster  c, subjectmaster b          WHERE a.institutecode = '"+ mInst +"'               AND b.subjectid = a.subjectid            and a.INSTITUTECODE=b.INSTITUTECODE  AND a.examcode ='"+QryExam+"'  AND NVL (c.deactive, 'N') = 'N'            AND a.institutecode = c.institutecode            AND NVL (a.deactive, 'N') = 'N'            AND c.studentid ='"+mChkMemID+"'              and a.BASKET in ('D','B')         union   ";
				}
qry=qry+" SELECT DISTINCT  nvl(c.enrollmentno,'N') en2, NVL(C.subjectid,'N') subjectid, NVL(C.subject,'N')subject,NVL( C.subjectcode,'N')subjectcode, NVL(c.semester,'0')semester, NVL(' ',' ') grade, NVL(a.coursecreditpoint,'0')coursecreditpoint,                NVL(a.supfees,'0')supfees   ,decode(a.BASKET,'A','CORE','B','ELECTIVE','D','ELECTIVE','',a.BASKET)BASKET      FROM offersubjecttagging a,                 v#studentltpdetail c          WHERE a.institutecode =  '"+ mInst +"'            AND c.subjectid = a.subjectid            AND a.examcode ='"+QryExam+"'             AND NVL (c.deactive, 'N') = 'N'            AND a.institutecode = c.institutecode                     AND NVL (a.deactive, 'N') = 'N'            AND c.studentid = '"+mChkMemID+"'             AND (c.studentid, c.subjectid) IN (                   SELECT studentid, subjectid                     FROM debarstudentdetail                    WHERE examcode = '"+mPrevExmCode+"'                          AND studentid = '"+mChkMemID+"'                       AND institutecode = '"+ mInst +"' AND NVL (GRADE, 'N') = 'F' )                      and                          (c.studentid, c.subjectid) not IN (                SELECT studentid, subjectid                     FROM studentresult                    WHERE studentid = '"+mChkMemID+"'                       AND institutecode =  '"+ mInst +"'  ) union ";


qry=qry+"SELECT DISTINCT nvl(V.enrollmentno,'N') en2, NVL(C.subjectid,'N') subjectid, NVL(C.subject,'N')subject,NVL( C.subjectcode,'N')subjectcode, NVL(B.semester,'0')semester, NVL(B.GRADE,' ') grade, NVL(a.coursecreditpoint,'0')coursecreditpoint,                NVL(a.supfees,'0')supfees   ,decode(a.BASKET,'A','CORE','B','ELECTIVE','D','ELECTIVE','',a.BASKET)BASKET FROM offersubjecttagging a, studentresult b, studentmaster v,subjectmaster c WHERE a.institutecode = '"+ mInst +"' AND v.studentid = b.studentid AND v.studentid = v.studentid AND C.subjectid = a.subjectid AND B.subjectid = a.subjectid AND C.subjectid = B.subjectid AND NVL (b.fail, 'N') = 'Y'  and a.examcode = '"+QryExam+"' and nvl(v.DEACTIVE,'N')='N'  AND A.INSTITUTECODE=V.INSTITUTECODE AND A.INSTITUTECODE=B.INSTITUTECODE AND  A.INSTITUTECODE=C.INSTITUTECODE AND C.INSTITUTECODE=B.INSTITUTECODE  AND NVL(V.DEACTIVE,'N')='N'  AND V.studentid = '"+mChkMemID+"' and nvl(a.deactive, 'N') = 'N'  ";

//     and c.ACADEMICYEAR in ('0910','0809','0708','0607')            AND 

/*union SELECT DISTINCT v.enrollmentno en2, c.subjectid subjectid, c.subject,                c.subjectcode, B.semester, b.grade, a.coursecreditpoint,          a.supfees,decode(a.BASKET,'A','CORE','B','ELECTIVE','D','ELECTIVE','',a.BASKET)BASKET  FROM offersubjecttagging a, studentresult b, studentmaster v,subjectmaster c WHERE a.institutecode = '"+ mInst +"' AND v.studentid = b.studentid AND v.studentid = v.studentid and nvl(v.DEACTIVE,'N')='N' AND NVL(V.DEACTIVE,'N')='N' AND C.subjectid = a.subjectid AND C.subjectid = B.subjectid AND a.examcode = '"+QryExam+"' AND A.INSTITUTECODE=V.INSTITUTECODE AND A.INSTITUTECODE=B.INSTITUTECODE AND A.INSTITUTECODE=V.INSTITUTECODE AND A.INSTITUTECODE=C.INSTITUTECODE AND A.INSTITUTECODE=V.INSTITUTECODE AND C.INSTITUTECODE=B.INSTITUTECODE AND  b.GRADE not in ('A','A+','B+')  AND V.studentid = '"+mChkMemID+"'   and V.STUDENTID IN ( SELECT A.STUDENTID FROM STUDENTSGPACGPA A,STUDENTMASTER B  WHERE A.semester="+mMaxsem+" AND A.STUDENTID=B.STUDENTID AND CGPA< "+mMinsem+" )
*/
qry=qry+" union SELECT DISTINCT v.enrollmentno en2, c.subjectid subjectid, c.subject,                 c.subjectcode, B.semester, 'Not Registered' grade, a.coursecreditpoint,                a.supfees,decode(a.BASKET,'A','CORE','B','ELECTIVE','D','ELECTIVE','',a.BASKET)BASKET FROM offersubjecttagging a, nrstudentfailsubjects b,studentmaster v,subjectmaster c WHERE a.institutecode = '"+ mInst +"' AND v.studentid = b.studentid AND v.studentid = v.studentid and nvl(v.DEACTIVE,'N')='N' AND NVL(a.DEACTIVE,'N')='N' AND a.subjectid = b.subjectid AND a.subjectid = b.subjectid  and a.examcode ='"+QryExam+"' and a.subjectid=c.subjectid and a.subjectid=b.subjectid and a.institutecode=c.institutecode and a.institutecode=v.institutecode AND NVL(REGISTERED,'N')='N' AND V.studentid = '"+mChkMemID+"'  ) ";
qry=qry+" ORDER BY basket,coursecreditpoint DESC";

//out.print(qry);
	
	String sss="";
        StudentRecordSet = db.getRowset(qry); 	
int SrNo=0;
	while (StudentRecordSet.next())
	{
		
		FeeAmt=StudentRecordSet.getLong("SUPFEES");
		sss=StudentRecordSet.getString("Subject");




		//aaa=sss.Contains("PROJECT");

		//	out.print(aaa+"LL");
		
		SrNo++;


	sno++;
	ctot+=StudentRecordSet.getDouble("CourseCreditPoint");
	
		qry1="SELECT 'Y' FROM SUPPLEMENTARYSUBJECTTAGGING WHERE INSTITUTECODE='"+ mInst +"' AND EXAMCODE='"+QryExam+"' AND  STUDENTID='"+mChkMemID+"' AND  SUBJECTID='"+StudentRecordSet.getString("subjectid")+"' ";	
	// out.print(qry1);
		rs1=db.getRowset(qry1);
		if(rs1.next())
		{
			mFLAG=1;
		}

		if(StudentRecordSet.getString("basket").equals("ELECTIVE"))
			mColor="LIGHTpink";
		else
			mColor="";

//out.print("878676767");
	%>
	
	
	
	
	<TR bgcolor="<%=mColor%>">
	<TD><b><%=sno%></b></TD>
	<TD><b><%=StudentRecordSet.getString("basket")%></b></TD>
	<TD><b><%=StudentRecordSet.getString("SubjectCode")%></b></TD>
	<TD><b><%=StudentRecordSet.getString("Subject")%></b></TD>
	<TD><b><%=StudentRecordSet.getInt("Semester")%></b></TD>
	<TD><b><%=StudentRecordSet.getString("Grade")%></b></TD>
	
	<TD align=right><b><%=StudentRecordSet.getDouble("CourseCreditPoint")%></b></TD>
	<%
		if(mFLAG==1)
		{ 
			Checked="checked ";
		}
		else
		{
			Checked=" ";
		}
		%>
		<TD align=right><b><%=FeeAmt%></b></TD>
	<TD align=center>  
	
	<INPUT TYPE="checkbox" NAME="Checked<%=sno%>" <%=Checked%> id="Checked" onClick="FunCheck('<%=StudentRecordSet.getDouble("CourseCreditPoint")%>','<%=sno%>')">
	
	</TD>
	<input type="hidden" name="CourseCredit<%=sno%>" id="CourseCredit<%=sno%>" value="<%=StudentRecordSet.getDouble("CourseCreditPoint")%>" >

<input type="hidden" name="SupFees<%=sno%>" id="SupFees<%=sno%>" value="<%=FeeAmt%>" >

<input type="hidden" name="sno" id="sno" value="<%=sno%>">
<input type="hidden" name="SubjectID<%=sno%>" id="SubjectID<%=sno%>" value="<%=StudentRecordSet.getString("subjectid")%>">
		<%
	qry2="select 'Y' from subjectmaster where subjectid='"+StudentRecordSet.getString("subjectid")+"'  and institutecode='"+ mInst +"' AND SUBJECT LIKE '%PROJECT%'  and subjectcode not in ('10B11PD611') ";
			// out.print(qry2);
		rs2=db.getRowset(qry2);
		if(rs2.next())
		{
			%>
					<input type="hidden" name="ProjectSub<%=sno%>" id="ProjectSub<%=sno%>" value="Y" >
			<%
		}
			else
			{
			%>
					<input type="hidden" name="ProjectSub<%=sno%>" id="ProjectSub<%=sno%>" value="N" >
			<%
			}
%>
	</TR>
	<%
	mFLAG=0;
		

		


	}
	%>
<input type="hidden" name="SrNo" id="SrNo" value="<%=SrNo%>">
	<tr><TD colspan=7 align=right><b><%=ctot%></b></td>
	<TD>&nbsp; &nbsp;</TD><TD>&nbsp; &nbsp;</TD>
	</tr>
	 <!-- <tr><TD colspan=6 align=right><B>Total No. of Subject(s) Registered: </B></td>
	<TD  align=center>_______</TD>
	</tr> -->
	<tr><TD colspan=8 align=right><font size=2><B><!-- Payment @Rs. <%=mSupFees%> per subject: -->&nbsp;&nbsp; </B></font>&nbsp;</td>
	<TD align=center> <INPUT TYPE="submit" value="Click To Register" onclick="return CheckProgram();"> </TD>
	</tr> 

	</TABLE>
	</TD></TR>
	</TABLE>


	
<% 





		/*	}
			else
				{
				out.print("<center><font size=2 face=verdana color=red><b>Supplimentary Registration Done</b></font></center>");

				}*/

 // }
  
			/*}
			else
				{
					out.print("<center><font size=3 face=verdana color=red><b>Due to you being debarred in a certain exam you are not allowed<br> to register for the same !</b></font></center>");
				}*/

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
	}   //2
	else
	{
		out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}      
}	//1	
catch(Exception e)
{
}
//}

%>
  </body>
</html>
