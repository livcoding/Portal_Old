<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
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
<TITLE>#### <%=mHead%> [ HOD Load Distribution ] </TITLE>


<script>
if(window.history.forward(1) != null)
  window.history.forward(1);
</script>
</head>

<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
/*
	' 
*************************************************************************************************
	' *												
	' * File Name:	PRStudentAction.JSP		[For HOD]					
	' * Author:		Rituraj Tyagi
	' * Date:		01th May 2007								
	' * Version:		1.0								
	' * Description:	Pre Registration of Students
*************************************************************************************************
*/

DBHandler db=new DBHandler();

OLTEncryption enc=new OLTEncryption();

String qry="",mWebEmail="",EmpIDType="",qry1="",mSname="",Type="",mltp="";
String mSem="",mSem1="",mSemType="",mProg="",mBranch="",mSect="",mSubSect="",mTag="",mAcad="",mFactType="";
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
ResultSet rs=null,rs1=null,rse=null,rsi=null,rsee=null,rso=null,rso1=null,rsse=null,rsfstid=null,rs123456=null,rs88=null;
String mType="",mSendhod="",mPSS="",duration="";
String mEmpIdTemp="";
String mName1="",mName2="",mName3="",mName4="",mName5="",mSubjectType="",mMerge="";
String mName6="",mName7="",mName8="",mName9="",mName10="",moldnew="",mEid1="";
String fstidupdate="";
				int iii=0;
				int ii=0;
int  mTotalRec = 0;

String mChoice="", qryo="", moldPSS="";

String mExamCode="",mNameL="",mNameR="";

String mINSTITUTECODE="",mSemt="",mBasket="",mDuration="",mClass="";

String mEmployeeID="",mPc="",mOldsubsect="";

String mSUBJECTCODE="",mSubjectname="",mEmployeename="",mElective="",mEmp="",mLTP="",mDept="",mSUBJECTID="";

int kk=0;
int ctr=0;
int msno=0;
int ctr1=0;
int z=0;
int mpos4=0;
String moldsecbr="";
String mSectBranch="",mFac="";
String mSeccount="",mSubsection="",mSection="",mEname="",mNameLML="",mNameLMR="",mImMergeSec="";
int len=0,pos1=0,pos2=0,pos3=0,pos4=0,pos5=0,pos6=0;

String mAssign1="",mMin1="",mMax1="";

float mAssign=0,mAssign11=0,mMin=0,mMax=0,mweightage=0;

String mEid="",mETyp="",mEcmp="";

String mfrmtime="",mtotime="",mroomtype="",mPrCode="",mOldSubsection="";

int mFlag=0;

String Fstid="";
int mTotal=0;
int mDurationi=0;
int mClassi=0;
int mTotalassign=0;
int mlen=0,mpos1=0 ,mpos2=0,mpos3=0;
String mMainSec="",mMergeSec="",mSub="";

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
try 
{  //1
if(!mMemberID.equals("") && !mMemberType.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
{  //2

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mMacAddress =" "; //session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('56','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
//-------------------------------------
//----- For Log Entry Purpose
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
	try
	{	
		mDMemberCode=enc.decode(mMemberCode);
		mMemberID=enc.decode(mMemberID);
		mMemberType=enc.decode(mMemberType);
	}
	catch(Exception e)
	{
		// out.println(e.getMessage());
	}

	if (request.getParameter("TotalRec")!=null && Integer.parseInt(request.getParameter("TotalRec").toString().trim())>0)
	{  
	//3

	mTotalRec =Integer.parseInt(request.getParameter("TotalRec").toString().trim());
	

	if (request.getParameter("SUBJECTID")==null)
	{
		mSUBJECTID="";
	}
	else
	{
		mSUBJECTID=request.getParameter("SUBJECTID").toString().trim();
	}

	if (request.getParameter("DURATION")==null)
	{
		mDuration="";
	}
	else
	{
		mDuration=request.getParameter("DURATION").toString().trim();
	}

	if (request.getParameter("NOOFCLASS")==null)
	{
		mClass="";
	}
	else
	{
		mClass=request.getParameter("NOOFCLASS").toString().trim();
	}


	if (request.getParameter("SEMTYPE")==null)
	{
		mSem1="";
	}
	else
	{
		mSem1=request.getParameter("SEMTYPE").toString().trim();
	}
	
	if (request.getParameter("TYPE")==null)
	{
	  mType="";
	}
	else
	{
	   mType=request.getParameter("TYPE").toString().trim();
	}

	if (request.getParameter("EXAM")==null)
	{
	   mExamCode="";
	}
	else
	{
	   mExamCode=request.getParameter("EXAM").toString().trim();
	}

	if (request.getParameter("INSTITUTE")==null)
	{
		mINSTITUTECODE="";
	}
	else
	{
		mINSTITUTECODE=request.getParameter("INSTITUTE").toString().trim();
	}

	if (request.getParameter("LTP")==null)
	{
		mLTP="";
	}
	else
	{
		mLTP=request.getParameter("LTP").toString().trim();
	}

	if (request.getParameter("DEPARTMENT")==null)
	{
		mDept="";
	}
	else
	{
		mDept=request.getParameter("DEPARTMENT").toString().trim();
	}

	if (request.getParameter("SUBJECT")==null)
	{
		mSUBJECTCODE="";
	}
	else
	{
		mSUBJECTCODE=request.getParameter("SUBJECT").toString().trim();
	}
	
	if (request.getParameter("BASKET")==null)
	{
		mBasket="";
	}
	else
	{
		mBasket=request.getParameter("BASKET").toString().trim();
	}
	if (request.getParameter("ELECTIVECODE")==null || request.getParameter("ELECTIVECODE").equals("null"))
	{
		mElective="";
	}
	else
	{
		mElective=request.getParameter("ELECTIVECODE").toString().trim();
	}
	
	mDurationi=Integer.parseInt(mDuration);
	mClassi=Integer.parseInt(mClass);
	mTotal=mDurationi*mClassi;

qry="select subject from subjectmaster where SUBJECTID='"+mSUBJECTID+"' ";
rs=db.getRowset(qry);
if(rs.next())
mSname=rs.getString(1);		

if(mType.equals("C"))
  Type="Core";
else if(mType.equals("E"))
 Type="Elective";
else
 Type="Free Elective";

if(mLTP.equals("L"))
{
  mltp="Lecture";
}
else if(mLTP.equals("T"))
{
 mltp="Tutorial";
}
else
{
 mltp="Practical";
}
%>
	<center><font size=4 color=green>Load Distribution Status</font></center>
	<hr>
	<table id=idd2 cellpadding=1 cellspacing=0 width="90%" align=center rules=rows  border=1>
	<tr><td align=center colspan=3>
	<b>HOD Load Distribution of Subject : </b><%=mSname%>&nbsp;(<%=mSUBJECTCODE%>)- <%=Type%> &nbsp; &nbsp;<b>LTP:</b>&nbsp;<%=mltp%>
      &nbsp; <b>Running Dept : </b><%=mDept%>
	</td>	
	</tr>
	</table>
	<table border=1 cellpadding=0 cellspacing=0 rules="rows" align=center width=90%>
	<tr bgcolor=ff8c00>
	<td><b>Section</b></td>	
	<td><b>Subsection</b></td>	
	<td><b>Employee Name</b></td>
	<td><b>No. Of <BR>Class/Week</b></td>
	<td><b>Sets</b></td>
	<td><b>Status</b></td>
	</tr>
<%
//ccc
	if(mType.equals("C"))
	{
		qry="SELECT DISTINCT b.subsectioncode subsectioncode, a.academicyear, a.programcode, a.taggingfor,a.sectionbranch sectionbranch, a.semester, a.semestertype,(SELECT COUNT (*) FROM programsubsectiontagging c WHERE c.institutecode = '"+mINSTITUTECODE+"' AND c.examcode = '"+mExamCode+"' AND c.semestertype =DECODE ('"+mSem1+"','ALL', c.semestertype,'"+mSem1+"') AND NVL (c.deactive, 'N') = 'N'  AND c.academicyear = a.academicyear AND c.programcode = a.programcode  AND c.sectionbranch = a.sectionbranch AND c.semester = a.semester  and c.subsectioncode is not null AND c.subsectiontype = 'C') cnt FROM programsubsectiontagging a, pr#studentsubjectchoice b, programsubjecttagging c  WHERE b.subsectioncode is not null and a.institutecode = '"+mINSTITUTECODE+"' AND a.institutecode = c.institutecode  AND a.examcode = c.examcode AND a.examcode = b.examcode AND b.subjecttype = 'C' AND a.examcode = '"+mExamCode+"' AND a.semestertype = DECODE ('"+mSem1+"', 'ALL', a.semestertype, '"+mSem1+"') AND NVL (a.deactive, 'N') = 'N' AND a.academicyear = b.academicyear AND a.programcode = b.programcode AND a.sectionbranch = b.sectionbranch  AND a.academicyear = c.academicyear AND a.programcode = c.programcode  AND b.sectionbranch = c.sectionbranch AND b.taggingfor = c.taggingfor AND a.semester = b.semester AND a.semester = c.semester AND b.subjectid = '"+mSUBJECTID+"' AND a.subsectiontype = 'C' AND a.semestertype = b.semestertype AND NVL (b.subjectrunning, 'N') = 'Y'  AND b.subjectid IN (SELECT d.subjectid FROM pr#departmentsubjecttagging d WHERE d.departmentcode = '"+mDept+"' AND d.sectionbranch = a.sectionbranch AND d.sectionbranch = b.sectionbranch) UNION SELECT DISTINCT a.subsectioncode subsectioncode,a.academicyear, a.programcode, a.taggingfor,a.sectionbranch sectionbranch, a.semester, a.semestertype,(SELECT COUNT (*) FROM programsubsectiontagging c WHERE c.institutecode = '"+mINSTITUTECODE+"' AND c.examcode = '"+mExamCode+"' AND c.semestertype =DECODE ('"+mSem1+"','ALL', c.semestertype,'"+mSem1+"') AND NVL (c.deactive, 'N') = 'N'  AND c.academicyear = a.academicyear AND c.programcode = a.programcode  AND c.sectionbranch = a.sectionbranch AND c.semester = a.semester And c.InstituteCode=b.InstituteCode And c.academicyear=b.academicyear and c.subsectioncode is not null AND c.subsectiontype = 'C') cnt  FROM programsubsectiontagging a,AcademicYearmaster b,programsubjecttagging c WHERE a.institutecode ='"+mINSTITUTECODE+"' AND a.institutecode = c.institutecode  AND a.examcode = c.examcode  AND c.Basket = 'A' AND a.examcode = '"+mExamCode+"'  AND a.semestertype = DECODE ('"+mSem1+"', 'ALL', a.semestertype, '"+mSem1+"') AND NVL (a.deactive, 'N') = 'N' AND a.academicyear = b.academicyear AND a.academicyear = c.academicyear AND a.programcode = c.programcode AND a.semester = c.semester AND a.subsectiontype = 'C'  AND NVL(b.CURRENTYEAR, 'N') = 'Y' AND c.subjectid = '"+mSUBJECTID+"' and a.subsectioncode is not null   AND c.subjectid IN ( SELECT d.subjectid  FROM pr#departmentsubjecttagging d WHERE d.departmentcode = '"+mDept+"' AND d.sectionbranch = a.sectionbranch AND d.sectionbranch = a.sectionbranch) order by sectionbranch,academicyear";
		
		
	}
	else if(mType.equals("E"))
	{
		
		
		qry="SELECT DISTINCT subsectioncode subsectioncode,  a.academicyear, a.programcode, a.taggingfor, a.sectionbranch sectionbranch, a.semester, a.semestertype, (SELECT COUNT (*)   FROM programsubsectiontagging c   WHERE c.institutecode = '"+mINSTITUTECODE+"' AND c.examcode = '"+mExamCode+"' AND c.semestertype = a.semestertype AND c.semestertype = DECODE ('"+mSem1+"', 'ALL', c.semestertype, '"+mSem1+"') AND NVL (c.deactive, 'N') = 'N' AND c.academicyear = a.academicyear  AND c.programcode = a.programcode AND c.sectionbranch = a.sectionbranch AND c.semester = a.semester AND c.subsectiontype = 'C') cnt FROM programsubsectiontagging a, pr#electivesubjects b WHERE b.subjectrunning = 'Y' AND EXISTS (SELECT 1 FROM pr#studentsubjectchoice c WHERE c.institutecode = '"+mINSTITUTECODE+"' AND c.examcode = '"+mExamCode+"' AND c.semestertype = DECODE ('"+mSem1+"', 'ALL', c.semestertype, '"+mSem1+"' ) AND NVL (c.deactive, 'N') = 'N' AND c.academicyear = a.academicyear AND c.programcode = a.programcode AND c.sectionbranch = a.sectionbranch AND c.semester = a.semester  AND a.sectionbranch = b.sectionbranch AND NVL (c.subjectrunning, 'N') = 'Y' AND c.subjectid = b.subjectid AND c.subjecttype = 'E') AND a.institutecode = '"+mINSTITUTECODE+"' AND b.electivecode = '"+mElective+"' AND a.examcode = '"+mExamCode+"' AND a.semestertype = DECODE ('"+mSem1+"', 'ALL', a.semestertype, '"+mSem1+"') AND NVL (a.deactive, 'N') = 'N' AND a.academicyear = b.academicyear AND a.programcode = b.programcode  AND a.examcode = b.examcode  AND a.sectionbranch = b.sectionbranch AND a.semester = b.semester AND b.subjectid = '"+mSUBJECTID+"' AND a.subsectiontype = 'C' AND b.subjectid IN (SELECT d.subjectid FROM pr#departmentsubjecttagging d WHERE d.departmentcode = '"+mDept+"' AND d.sectionbranch = a.sectionbranch AND d.sectionbranch = b.sectionbranch) ORDER BY a.sectionbranch,subsectioncode,a.academicyear,a.programcode,a.taggingfor, a.semester,a.semestertype";
		
		
		
		
	}
	else
	{
		qry="SELECT DISTINCT subsectioncode subsectioncode, a.academicyear, a.programcode, a.taggingfor, a.sectionbranch sectionbranch, a.semester, a.semestertype, (SELECT COUNT (*)   FROM programsubsectiontagging c   WHERE c.institutecode = '"+mINSTITUTECODE+"' AND c.examcode = '"+mExamCode+"' AND c.semestertype = a.semestertype AND c.semestertype = DECODE ('"+mSem1+"', 'ALL', c.semestertype, '"+mSem1+"') AND NVL (c.deactive, 'N') = 'N' AND c.academicyear = a.academicyear  AND c.programcode = a.programcode AND c.sectionbranch = a.sectionbranch AND c.semester = a.semester AND c.subsectiontype = 'C') cnt FROM programsubsectiontagging a, pr#electivesubjects b WHERE b.subjectrunning = 'Y' AND EXISTS (SELECT 1 FROM pr#studentsubjectchoice c WHERE c.institutecode = '"+mINSTITUTECODE+"' AND c.examcode = '"+mExamCode+"' AND c.semestertype = DECODE ('"+mSem1+"', 'ALL', c.semestertype, '"+mSem1+"' ) AND NVL (c.deactive, 'N') = 'N' AND c.academicyear = a.academicyear AND c.programcode = a.programcode AND c.sectionbranch = a.sectionbranch AND c.semester = a.semester  AND a.sectionbranch = b.sectionbranch AND NVL (c.subjectrunning, 'N') = 'Y' AND c.subjectid = b.subjectid AND c.subjecttype = 'E') AND a.institutecode = '"+mINSTITUTECODE+"' AND b.electivecode = '"+mElective+"' AND a.examcode = '"+mExamCode+"' AND a.semestertype = DECODE ('"+mSem1+"', 'ALL', a.semestertype, '"+mSem1+"') AND NVL (a.deactive, 'N') = 'N' AND a.academicyear = b.academicyear AND a.programcode = b.programcode  AND a.examcode = b.examcode  AND a.sectionbranch = b.sectionbranch AND a.semester = b.semester AND b.subjectid = '"+mSUBJECTID+"' AND a.subsectiontype = 'C' AND b.subjectid IN (SELECT d.subjectid FROM pr#departmentsubjecttagging d WHERE d.departmentcode = '"+mDept+"' AND d.sectionbranch = a.sectionbranch AND d.sectionbranch = b.sectionbranch) ORDER BY a.sectionbranch,subsectioncode,a.academicyear,a.programcode,a.taggingfor, a.semester,a.semestertype";
	}
	rs1=db.getRowset(qry);
	//ctr=0;
	String mChkFac[]=new String[200];
	int x=0;
//out.println(qry);
	while(rs1.next())
	{		
			mSeccount=rs1.getString("cnt");
			mSubsection=rs1.getString("subsectioncode");
			
			if(!mSection.equals(rs1.getString("SECTIONBRANCH")))
			{
			ctr=1;
				mSection=rs1.getString("SECTIONBRANCH");	
			}
		    else
			  ctr++;
			 
			mNameL=mSection+"***L///"+String.valueOf(ctr).trim()+"###"+mSeccount ; 
			mNameR=mSection+"***R///"+String.valueOf(ctr).trim()+"###"+mSeccount ;  
			mNameLML=mSection+"***L///"+String.valueOf(ctr).trim()+"###"+mSeccount+"merge";    
			mNameLMR=mSection+"***R///"+String.valueOf(ctr).trim()+"###"+mSeccount+"merge";   

		   /* out.println("1111"+mNameLML);
			out.println("asdf"+request.getParameter(mNameLML));*/
			
			
			mMerge=request.getParameter(mNameLML);
			
			
			
			//out.println("1111"+mMerge);
			if(mMerge!=null &&  mMerge.equals("NONE"))
			{
				mMerge=request.getParameter(mNameLMR);
			}
			else
		{
mMerge="";
		}
			
		   // out.println("<br>"+mMerge);
			  mEmp=request.getParameter(mNameL);
			
			if(mEmp!=null && mEmp.equals("NONE"))
			{
				mEmp=request.getParameter(mNameR).toString().trim();
			}
			else
		{
mEmp="";
		}

			if(!mEmp.equals("NONE") && !mEmp.equals(""))
			{
				//out.println("1werqer");		
				if(!mMerge.equals("NONE") && !mMerge.equals(""))
				{	
				mlen=mMerge.length();
				mpos1=mMerge.indexOf("***");
				mpos2=mMerge.indexOf("///");
				mpos3=mMerge.indexOf("###");
				mMainSec=mMerge.substring(0,mpos1);
				mSub=mMerge.substring(mpos1+3,mpos2);
				mMergeSec=mMerge.substring(mpos2+3,mpos3);
				mPc=mMerge.substring(mpos3+3,mlen);
				}
	
				len=mEmp.length();
				pos1=mEmp.indexOf("***");	
				pos2=mEmp.indexOf("*****");
				pos3=mEmp.indexOf("/////");
				pos4=mEmp.indexOf("///");
				pos5=mEmp.indexOf("###");
				pos6=mEmp.indexOf("$$$$");

				mEid=mEmp.substring(0,pos1);
				mETyp=mEmp.substring(pos2+5,pos3);
				mEcmp=mEmp.substring(pos3+5,pos6);
				mAssign1=mEmp.substring(pos1+3,pos4);
				mMin1=mEmp.substring(pos4+3,pos5);
				mMax1=mEmp.substring(pos5+3,pos2);
								
				mAssign=Float.parseFloat(mAssign1);
				mMin=Float.parseFloat(mMin1);
				mMax=Float.parseFloat(mMax1);

			int mfound=0;
			for(int jp=0;jp<x;jp++)	
			{
				if(mChkFac[jp].equals(mEid))
				{
				mfound=1;
				break;
				}
			}	
	//out.println("adfsdafasdfasdfsdafasd");
			if(mfound==0 || x==0)
			{
				mChkFac[x]=mEid;
				x++;
	
	if(mType.equals("C"))
	{
	
	qry1="SELECT DISTINCT b.subsectioncode subsectioncode, a.academicyear, a.programcode, a.taggingfor,a.sectionbranch sectionbranch, a.semester, a.semestertype,(SELECT COUNT (*) FROM programsubsectiontagging c WHERE c.institutecode = '"+mINSTITUTECODE+"' AND c.examcode = '"+mExamCode+"' AND c.semestertype =DECODE ('"+mSem1+"','ALL', c.semestertype,'"+mSem1+"') AND NVL (c.deactive, 'N') = 'N'  AND c.academicyear = a.academicyear AND c.programcode = a.programcode  AND c.sectionbranch = a.sectionbranch AND c.semester = a.semester  and c.subsectioncode is not null AND c.subsectiontype = 'C') cnt FROM programsubsectiontagging a, pr#studentsubjectchoice b, programsubjecttagging c  WHERE b.subsectioncode is not null and a.institutecode = '"+mINSTITUTECODE+"' AND a.institutecode = c.institutecode  AND a.examcode = c.examcode AND a.examcode = b.examcode AND b.subjecttype = 'C' AND a.examcode = '"+mExamCode+"' AND a.semestertype = DECODE ('"+mSem1+"', 'ALL', a.semestertype, '"+mSem1+"') AND NVL (a.deactive, 'N') = 'N' AND a.academicyear = b.academicyear AND a.programcode = b.programcode AND a.sectionbranch = b.sectionbranch  AND a.academicyear = c.academicyear AND a.programcode = c.programcode  AND b.sectionbranch = c.sectionbranch AND b.taggingfor = c.taggingfor AND a.semester = b.semester AND a.semester = c.semester AND b.subjectid = '"+mSUBJECTID+"' AND a.subsectiontype = 'C' AND a.semestertype = b.semestertype AND NVL (b.subjectrunning, 'N') = 'Y'  AND b.subjectid IN (SELECT d.subjectid FROM pr#departmentsubjecttagging d WHERE d.departmentcode = '"+mDept+"' AND d.sectionbranch = a.sectionbranch AND d.sectionbranch = b.sectionbranch) UNION SELECT DISTINCT a.subsectioncode subsectioncode, a.academicyear, a.programcode, a.taggingfor,a.sectionbranch sectionbranch, a.semester, a.semestertype,(SELECT COUNT (*) FROM programsubsectiontagging c WHERE c.institutecode = '"+mINSTITUTECODE+"' AND c.examcode = '"+mExamCode+"' AND c.semestertype =DECODE ('"+mSem1+"','ALL', c.semestertype,'"+mSem1+"') AND NVL (c.deactive, 'N') = 'N'  AND c.academicyear = a.academicyear AND c.programcode = a.programcode  AND c.sectionbranch = a.sectionbranch AND c.semester = a.semester And c.InstituteCode=b.InstituteCode And c.academicyear=b.academicyear and c.subsectioncode is not null AND c.subsectiontype = 'C') cnt  FROM programsubsectiontagging a,AcademicYearmaster b,programsubjecttagging c WHERE a.institutecode ='"+mINSTITUTECODE+"' AND a.institutecode = c.institutecode  AND a.examcode = c.examcode  AND c.Basket = 'A' AND a.examcode = '"+mExamCode+"'  AND a.semestertype = DECODE ('"+mSem1+"', 'ALL', a.semestertype, '"+mSem1+"') AND NVL (a.deactive, 'N') = 'N' AND a.academicyear = b.academicyear AND a.academicyear = c.academicyear AND a.programcode = c.programcode AND a.semester = c.semester AND a.subsectiontype = 'C'  AND NVL(b.CURRENTYEAR, 'N') = 'Y' and a.subsectioncode is not null AND c.subjectid = '"+mSUBJECTID+"'  AND c.subjectid IN ( SELECT d.subjectid  FROM pr#departmentsubjecttagging d WHERE d.departmentcode = '"+mDept+"' AND d.sectionbranch = a.sectionbranch AND d.sectionbranch = a.sectionbranch) order by sectionbranch,academicyear";
	}
	else if(mType.equals("E"))
	{
qry1="SELECT DISTINCT subsectioncode subsectioncode,  a.academicyear, a.programcode, a.taggingfor, a.sectionbranch sectionbranch, a.semester, a.semestertype, (SELECT COUNT (*)   FROM programsubsectiontagging c   WHERE c.institutecode = '"+mINSTITUTECODE+"' AND c.examcode = '"+mExamCode+"' AND c.semestertype = a.semestertype AND c.semestertype = DECODE ('"+mSem1+"', 'ALL', c.semestertype, '"+mSem1+"') AND NVL (c.deactive, 'N') = 'N' AND c.academicyear = a.academicyear  AND c.programcode = a.programcode AND c.sectionbranch = a.sectionbranch AND c.semester = a.semester AND c.subsectiontype = 'C') cnt FROM programsubsectiontagging a, pr#electivesubjects b WHERE b.subjectrunning = 'Y' AND EXISTS (SELECT 1 FROM pr#studentsubjectchoice c WHERE c.institutecode = '"+mINSTITUTECODE+"' AND c.examcode = '"+mExamCode+"' AND c.semestertype = DECODE ('"+mSem1+"', 'ALL', c.semestertype, '"+mSem1+"' ) AND NVL (c.deactive, 'N') = 'N' AND c.academicyear = a.academicyear AND c.programcode = a.programcode AND c.sectionbranch = a.sectionbranch AND c.semester = a.semester  AND a.sectionbranch = b.sectionbranch AND NVL (c.subjectrunning, 'N') = 'Y' AND c.subjectid = b.subjectid AND c.subjecttype = 'E') AND a.institutecode = '"+mINSTITUTECODE+"' AND b.electivecode = '"+mElective+"' AND a.examcode = '"+mExamCode+"' AND a.semestertype = DECODE ('"+mSem1+"', 'ALL', a.semestertype, '"+mSem1+"') AND NVL (a.deactive, 'N') = 'N' AND a.academicyear = b.academicyear AND a.programcode = b.programcode  AND a.examcode = b.examcode  AND a.sectionbranch = b.sectionbranch AND a.semester = b.semester AND b.subjectid = '"+mSUBJECTID+"' AND a.subsectiontype = 'C' AND b.subjectid IN (SELECT d.subjectid FROM pr#departmentsubjecttagging d WHERE d.departmentcode = '"+mDept+"' AND d.sectionbranch = a.sectionbranch AND d.sectionbranch = b.sectionbranch) ORDER BY a.sectionbranch,subsectioncode,a.academicyear,a.programcode,a.taggingfor, a.semester,a.semestertype";
	}
	else
	{
//		out.print("ddddddddddddddddddd654");
	qry1="SELECT DISTINCT subsectioncode subsectioncode,  a.academicyear, a.programcode, a.taggingfor, a.sectionbranch sectionbranch, a.semester, a.semestertype, (SELECT COUNT (*)   FROM programsubsectiontagging c   WHERE c.institutecode = '"+mINSTITUTECODE+"' AND c.examcode = '"+mExamCode+"' AND c.semestertype = a.semestertype AND c.semestertype = DECODE ('"+mSem1+"', 'ALL', c.semestertype, '"+mSem1+"') AND NVL (c.deactive, 'N') = 'N' AND c.academicyear = a.academicyear  AND c.programcode = a.programcode AND c.sectionbranch = a.sectionbranch AND c.semester = a.semester AND c.subsectiontype = 'C') cnt FROM programsubsectiontagging a, pr#electivesubjects b WHERE b.subjectrunning = 'Y' AND EXISTS (SELECT 1 FROM pr#studentsubjectchoice c WHERE c.institutecode = '"+mINSTITUTECODE+"' AND c.examcode = '"+mExamCode+"' AND c.semestertype = DECODE ('"+mSem1+"', 'ALL', c.semestertype, '"+mSem1+"' ) AND NVL (c.deactive, 'N') = 'N' AND c.academicyear = a.academicyear AND c.programcode = a.programcode AND c.sectionbranch = a.sectionbranch AND c.semester = a.semester  AND a.sectionbranch = b.sectionbranch AND NVL (c.subjectrunning, 'N') = 'Y' AND c.subjectid = b.subjectid AND c.subjecttype = 'E') AND a.institutecode = '"+mINSTITUTECODE+"' AND b.electivecode = '"+mElective+"' AND a.examcode = '"+mExamCode+"' AND a.semestertype = DECODE ('"+mSem1+"', 'ALL', a.semestertype, '"+mSem1+"') AND NVL (a.deactive, 'N') = 'N' AND a.academicyear = b.academicyear AND a.programcode = b.programcode  AND a.examcode = b.examcode  AND a.sectionbranch = b.sectionbranch AND a.semester = b.semester AND b.subjectid = '"+mSUBJECTID+"' AND a.subsectiontype = 'C' AND b.subjectid IN (SELECT d.subjectid FROM pr#departmentsubjecttagging d WHERE d.departmentcode = '"+mDept+"' AND d.sectionbranch = a.sectionbranch AND d.sectionbranch = b.sectionbranch) ORDER BY a.sectionbranch,subsectioncode,a.academicyear,a.programcode,a.taggingfor, a.semester,a.semestertype";
	}

	rsi=db.getRowset(qry1);
	ctr1=0;
	mweightage=0;
	String mSection1="";
//out.println("1111"+qry1+"<br>");
//out.println("sssssssssssssssssssssssssssssssssssssssssssssssssss");
	while(rsi.next())
	{  
		msno++;

			mSeccount=rsi.getString("cnt");
			mSubsection=rsi.getString("subsectioncode");
			if(!mSection1.equals(rsi.getString("SECTIONBRANCH")))
			{
			ctr1=1;
			mSection1=rsi.getString("SECTIONBRANCH");	
			}
		    else
			 ctr1++;
			 
			mNameL=mSection1+"***L///"+String.valueOf(ctr1).trim()+"###"+mSeccount ; 
			mNameR=mSection1+"***R///"+String.valueOf(ctr1).trim()+"###"+mSeccount ;  
			mNameLML=mSection1+"***L///"+String.valueOf(ctr1).trim()+"###"+mSeccount+"merge";    
			mNameLMR=mSection1+"***R///"+String.valueOf(ctr1).trim()+"###"+mSeccount+"merge";   

			mMerge=request.getParameter(mNameLML);

			if(mMerge!=null && mMerge.equals("NONE"))
			{
				mMerge=request.getParameter(mNameLMR).toString().trim();
			}
			else
		{	
				mMerge="";
		}
	
				mEmp=request.getParameter(mNameL);
		
			if(mEmp!=null && mEmp.equals("NONE"))
			{
				mEmp=request.getParameter(mNameR).toString().trim();
			}
			else
		{
				mEmp="";
		}

			if(!mEmp.equals("NONE") && !mEmp.equals(""))
			{
						
				if(!mMerge.equals("NONE") && !mMerge.equals(""))
				{	
				mlen=mMerge.length();
				mpos1=mMerge.indexOf("***");
				mpos2=mMerge.indexOf("///");
				mpos3=mMerge.indexOf("###");
				mMainSec=mMerge.substring(0,mpos1);
				mSub=mMerge.substring(mpos1+3,mpos2);
				mMergeSec=mMerge.substring(mpos2+3,mpos3);
				mPc=mMerge.substring(mpos3+3,mlen);

				}
	
				len=mEmp.length();
				pos1=mEmp.indexOf("***");	
				pos2=mEmp.indexOf("*****");
				pos3=mEmp.indexOf("/////");
				pos4=mEmp.indexOf("///");
				pos5=mEmp.indexOf("###");
				pos6=mEmp.indexOf("$$$$");

				mFac=mEmp.substring(0,pos1);
				mETyp=mEmp.substring(pos2+5,pos3);
				mEcmp=mEmp.substring(pos3+5,pos6);
				mAssign1=mEmp.substring(pos1+3,pos4);
				mMin1=mEmp.substring(pos4+3,pos5);
				mMax1=mEmp.substring(pos5+3,pos2);

				mAssign=Float.parseFloat(mAssign1);
				mMin=Float.parseFloat(mMin1);
				mMax=Float.parseFloat(mMax1);

				mAcad=rsi.getString("ACADEMICYEAR");
				mProg=rsi.getString("PROGRAMCODE");
				mTag=rsi.getString("TAGGINGFOR");
				mSectBranch=rsi.getString("SECTIONBRANCH");
				mSubSect=rsi.getString("SUBSECTIONCODE");
				mSem=rsi.getString("SEMESTER");
				mSemt=rsi.getString("SEMESTERTYPE");

		qry="select A.FACULTYID FACULTYID from PR#HODLOADDISTRIBUTION A  where A.institutecode='"+mINSTITUTECODE+"' ";
		qry=qry+" and A.examcode='"+mExamCode+"' and A.SUBJECTID='"+mSUBJECTID+"' and A.LTP='"+mLTP+"' ";
		qry=qry+" and A.SECTIONBRANCH='"+mSectBranch+"' and A.subsectioncode='"+mSubSect+"' and nvl(A.deactive,'N')='N' ";		
		qry=qry+" and A.semestertype='"+mSemt+"' and A.FACULTYTYPE='"+mETyp+"' and A.ACADEMICYEAR='"+mAcad+"' ";
		qry=qry+" and A.PROGRAMCODE in ('"+mProg+"') and A.TAGGINGFOR='"+mTag+"' and A.SEMESTER='"+mSem+"' ";
		qry=qry+" and A.FACULTYID='"+mFac+"' ";
			//out.println(qry);
			rso=db.getRowset(qry);
			if(rso.next())
			{
			  mAssign11=0;
			}
			else
			{
			mAssign11=mAssign;

	//	!mOldsectionbranch.equals(rsi.getString("SECTIONBRANCH"))					
		if(mEid.equals(mFac) && mMerge.equals("NONE") && !mOldsubsect.equals(rsi.getString("SUBSECTIONCODE")) )
	
		{
			mweightage=mweightage+mTotal;
			mOldsubsect=rsi.getString("SUBSECTIONCODE");

		}
		
		if((mweightage+mAssign11)>mMax)
		{
			mFlag=1;
			break;
		}
			
	 } // closing of else	
	
		}  // closing of if if(!mEmp.equals("NONE"))
	
		} // closing of inner while(rsi)

	} // closing of mfound==0

			if(mFlag==1)
			{
				break;
			}

          }  // closing of if if(!mEmp.equals("NONE"))

	} //closing of outer while(rs1).....

//out.println("hello");
	if(mFlag==1)
	{

	qry=" select employeename from V#STAFF where employeeid='"+mFac+"' and  COMPANYCODE='"+mEcmp+"'";
	//out.print(qry);
	rsee=db.getRowset(qry);
	if(rsee.next())
	mEname=rsee.getString(1);

	%>	
	<br>
	<font color=red><b>
	<br><img src='../Images/Error1.jpg'>
	Assigned Work Load of <%=mEname%> is <%=mAssign%><br>
	&nbsp; &nbsp; &nbsp; Work Load must be between <%=mMin%> and <%=mMax%>.  
	</font><br></b>
	<%
	}
	else
	{
	msno=0;
	ctr=0;

	
	if(mType.equals("C"))
	{
		qry="SELECT DISTINCT b.subsectioncode subsectioncode, a.academicyear, a.programcode, a.taggingfor,a.sectionbranch sectionbranch, a.semester, a.semestertype,(SELECT COUNT (*) FROM programsubsectiontagging c WHERE c.institutecode = '"+mINSTITUTECODE+"' AND c.examcode = '"+mExamCode+"' AND c.semestertype =DECODE ('"+mSem1+"','ALL', c.semestertype,'"+mSem1+"') AND NVL (c.deactive, 'N') = 'N'  AND c.academicyear = a.academicyear AND c.programcode = a.programcode  AND c.sectionbranch = a.sectionbranch AND c.semester = a.semester  and c.subsectioncode is not null AND c.subsectiontype = 'C') cnt FROM programsubsectiontagging a, pr#studentsubjectchoice b, programsubjecttagging c  WHERE b.subsectioncode is not null and a.institutecode = '"+mINSTITUTECODE+"' AND a.institutecode = c.institutecode  AND a.examcode = c.examcode AND a.examcode = b.examcode AND b.subjecttype = 'C' AND a.examcode = '"+mExamCode+"' AND a.semestertype = DECODE ('"+mSem1+"', 'ALL', a.semestertype, '"+mSem1+"') AND NVL (a.deactive, 'N') = 'N' AND a.academicyear = b.academicyear AND a.programcode = b.programcode AND a.sectionbranch = b.sectionbranch  AND a.academicyear = c.academicyear AND a.programcode = c.programcode  AND b.sectionbranch = c.sectionbranch AND b.taggingfor = c.taggingfor AND a.semester = b.semester AND a.semester = c.semester AND b.subjectid = '"+mSUBJECTID+"' AND a.subsectiontype = 'C' AND a.semestertype = b.semestertype AND NVL (b.subjectrunning, 'N') = 'Y'  AND b.subjectid IN (SELECT d.subjectid FROM pr#departmentsubjecttagging d WHERE d.departmentcode = '"+mDept+"' AND d.sectionbranch = a.sectionbranch AND d.sectionbranch = b.sectionbranch) UNION SELECT DISTINCT a.subsectioncode subsectioncode, a.academicyear, a.programcode, a.taggingfor,a.sectionbranch sectionbranch, a.semester, a.semestertype,(SELECT COUNT (*) FROM programsubsectiontagging c WHERE c.institutecode = '"+mINSTITUTECODE+"' AND c.examcode = '"+mExamCode+"' AND c.semestertype =DECODE ('"+mSem1+"','ALL', c.semestertype,'"+mSem1+"') AND NVL (c.deactive, 'N') = 'N'  AND c.academicyear = a.academicyear AND c.programcode = a.programcode  AND c.sectionbranch = a.sectionbranch AND c.semester = a.semester And c.InstituteCode=b.InstituteCode And c.academicyear=b.academicyear and c.subsectioncode is not null AND c.subsectiontype = 'C') cnt  FROM programsubsectiontagging a,AcademicYearmaster b,programsubjecttagging c WHERE a.institutecode ='"+mINSTITUTECODE+"' AND a.institutecode = c.institutecode  AND a.examcode = c.examcode  AND c.Basket = 'A' AND a.examcode = '"+mExamCode+"'  AND a.semestertype = DECODE ('"+mSem1+"', 'ALL', a.semestertype, '"+mSem1+"') AND NVL (a.deactive, 'N') = 'N' AND a.academicyear = b.academicyear AND a.academicyear = c.academicyear AND a.programcode = c.programcode AND a.semester = c.semester AND a.subsectiontype = 'C'  AND NVL(b.CURRENTYEAR, 'N') = 'Y'  AND c.subjectid = '"+mSUBJECTID+"' and a.subsectioncode is not null   AND c.subjectid IN ( SELECT d.subjectid  FROM pr#departmentsubjecttagging d WHERE d.departmentcode = '"+mDept+"' AND d.sectionbranch = a.sectionbranch AND d.sectionbranch = a.sectionbranch) order by sectionbranch,academicyear";

	}
	else if(mType.equals("E"))
	{
		qry="SELECT DISTINCT subsectioncode subsectioncode,  a.academicyear, a.programcode, a.taggingfor, a.sectionbranch sectionbranch, a.semester, a.semestertype, (SELECT COUNT (*)   FROM programsubsectiontagging c   WHERE c.institutecode = '"+mINSTITUTECODE+"' AND c.examcode = '"+mExamCode+"' AND c.semestertype = a.semestertype AND c.semestertype = DECODE ('"+mSem1+"', 'ALL', c.semestertype, '"+mSem1+"') AND NVL (c.deactive, 'N') = 'N' AND c.academicyear = a.academicyear  AND c.programcode = a.programcode AND c.sectionbranch = a.sectionbranch AND c.semester = a.semester AND c.subsectiontype = 'C') cnt FROM programsubsectiontagging a, pr#electivesubjects b WHERE b.subjectrunning = 'Y' AND EXISTS (SELECT 1 FROM pr#studentsubjectchoice c WHERE c.institutecode = '"+mINSTITUTECODE+"' AND c.examcode = '"+mExamCode+"' AND c.semestertype = DECODE ('"+mSem1+"', 'ALL', c.semestertype, '"+mSem1+"' ) AND NVL (c.deactive, 'N') = 'N' AND c.academicyear = a.academicyear AND c.programcode = a.programcode AND c.sectionbranch = a.sectionbranch AND c.semester = a.semester  AND a.sectionbranch = b.sectionbranch AND NVL (c.subjectrunning, 'N') = 'Y' AND c.subjectid = b.subjectid AND c.subjecttype = 'E') AND a.institutecode = '"+mINSTITUTECODE+"' AND b.electivecode = '"+mElective+"' AND a.examcode = '"+mExamCode+"' AND a.semestertype = DECODE ('"+mSem1+"', 'ALL', a.semestertype, '"+mSem1+"') AND NVL (a.deactive, 'N') = 'N' AND a.academicyear = b.academicyear AND a.programcode = b.programcode  AND a.examcode = b.examcode  AND a.sectionbranch = b.sectionbranch AND a.semester = b.semester AND b.subjectid = '"+mSUBJECTID+"' AND a.subsectiontype = 'C' AND b.subjectid IN (SELECT d.subjectid FROM pr#departmentsubjecttagging d WHERE d.departmentcode = '"+mDept+"' AND d.sectionbranch = a.sectionbranch AND d.sectionbranch = b.sectionbranch) ORDER BY a.sectionbranch,subsectioncode,a.academicyear,a.programcode,a.taggingfor, a.semester,a.semestertype";
	}
	else
	{
		qry="SELECT DISTINCT subsectioncode subsectioncode,  a.academicyear, a.programcode, a.taggingfor, a.sectionbranch sectionbranch, a.semester, a.semestertype, (SELECT COUNT (*)   FROM programsubsectiontagging c   WHERE c.institutecode = '"+mINSTITUTECODE+"' AND c.examcode = '"+mExamCode+"' AND c.semestertype = a.semestertype AND c.semestertype = DECODE ('"+mSem1+"', 'ALL', c.semestertype, '"+mSem1+"') AND NVL (c.deactive, 'N') = 'N' AND c.academicyear = a.academicyear  AND c.programcode = a.programcode AND c.sectionbranch = a.sectionbranch AND c.semester = a.semester AND c.subsectiontype = 'C') cnt FROM programsubsectiontagging a, pr#electivesubjects b WHERE b.subjectrunning = 'Y' AND EXISTS (SELECT 1 FROM pr#studentsubjectchoice c WHERE c.institutecode = '"+mINSTITUTECODE+"' AND c.examcode = '"+mExamCode+"' AND c.semestertype = DECODE ('"+mSem1+"', 'ALL', c.semestertype, '"+mSem1+"' ) AND NVL (c.deactive, 'N') = 'N' AND c.academicyear = a.academicyear AND c.programcode = a.programcode AND c.sectionbranch = a.sectionbranch AND c.semester = a.semester  AND a.sectionbranch = b.sectionbranch AND NVL (c.subjectrunning, 'N') = 'Y' AND c.subjectid = b.subjectid AND c.subjecttype = 'E') AND a.institutecode = '"+mINSTITUTECODE+"' AND b.electivecode = '"+mElective+"' AND a.examcode = '"+mExamCode+"' AND a.semestertype = DECODE ('"+mSem1+"', 'ALL', a.semestertype, '"+mSem1+"') AND NVL (a.deactive, 'N') = 'N' AND a.academicyear = b.academicyear AND a.programcode = b.programcode  AND a.examcode = b.examcode  AND a.sectionbranch = b.sectionbranch AND a.semester = b.semester AND b.subjectid = '"+mSUBJECTID+"' AND a.subsectiontype = 'C' AND b.subjectid IN (SELECT d.subjectid FROM pr#departmentsubjecttagging d WHERE d.departmentcode = '"+mDept+"' AND d.sectionbranch = a.sectionbranch AND d.sectionbranch = b.sectionbranch) ORDER BY a.sectionbranch,subsectioncode,a.academicyear,a.programcode,a.taggingfor, a.semester,a.semestertype";
	}
//out.println(qry);
	rs1=db.getRowset(qry);
	ctr=0;

//	String FstidArray[][]=new String[200][200];
mSection="";
	while(rs1.next())
	{
		msno++;
		mName4="OLDNEW"+String.valueOf(msno).trim();
			
		if(request.getParameter(mName4)==null)
		moldnew="";
		else
		moldnew=request.getParameter(mName4).toString();

		if(moldnew.equals("N"))
		{  
			mSeccount=rs1.getString("cnt");
			mSubsection=rs1.getString("subsectioncode");
			if(!mSection.equals(rs1.getString("SECTIONBRANCH")))
			{
			ctr=1;
			mSection=rs1.getString("SECTIONBRANCH");	
			}
		    else
			 ctr++;
			 
			mNameL=mSection+"***L///"+String.valueOf(ctr).trim()+"###"+mSeccount ; 
			mNameR=mSection+"***R///"+String.valueOf(ctr).trim()+"###"+mSeccount ;  
			mNameLML=mSection+"***L///"+String.valueOf(ctr).trim()+"###"+mSeccount+"merge";    
			mNameLMR=mSection+"***R///"+String.valueOf(ctr).trim()+"###"+mSeccount+"merge";   


			mMerge=request.getParameter(mNameLML);

			if(mMerge!=null &&  mMerge.equals("NONE"))
			{
				mMerge=request.getParameter(mNameLMR).toString().trim();
			}
			else
				 mMerge="";
			mEmp=request.getParameter(mNameL);

			if(mEmp!=null && mEmp.equals("NONE"))
			{
				mEmp=request.getParameter(mNameR).toString().trim();
			}
			else
				mEmp="";
			if(!mEmp.equals("NONE") && !mEmp.equals(""))
			{
				
							
				if(!mMerge.equals("NONE") && !mMerge.equals(""))
				{	
				mlen=mMerge.length();
				mpos1=mMerge.indexOf("***");
				mpos2=mMerge.indexOf("///");
				mpos3=mMerge.indexOf("###");
				mpos4=mMerge.indexOf("$$$");
				mMainSec=mMerge.substring(0,mpos1);
				mSub=mMerge.substring(mpos1+3,mpos2);
				mMergeSec=mMerge.substring(mpos2+3,mpos3);
				mPc=mMerge.substring(mpos3+3,mpos4);
				moldsecbr=mMerge.substring(mpos4+3,mlen);

				moldPSS=mPc+mMainSec+mMergeSec;
				}

				len=mEmp.length();
				pos1=mEmp.indexOf("***");	
				pos2=mEmp.indexOf("*****");
				pos3=mEmp.indexOf("/////");
				pos4=mEmp.indexOf("///");
				pos5=mEmp.indexOf("###");
				pos6=mEmp.indexOf("$$$$");

				mEid=mEmp.substring(0,pos1);
				mETyp=mEmp.substring(pos2+5,pos3);
				mEcmp=mEmp.substring(pos3+5,pos6);
				mAssign1=mEmp.substring(pos1+3,pos4);
				mMin1=mEmp.substring(pos4+3,pos5);
				mMax1=mEmp.substring(pos5+3,pos2);
				
				mAcad=rs1.getString("ACADEMICYEAR");
				mProg=rs1.getString("PROGRAMCODE");
				mTag=rs1.getString("TAGGINGFOR");
				mSectBranch=rs1.getString("SECTIONBRANCH");
				mSubSect=rs1.getString("SUBSECTIONCODE");
				mSem=rs1.getString("SEMESTER");
				mSemt=rs1.getString("SEMESTERTYPE");

				mPSS=rs1.getString("PROGRAMCODE")+mSection+mSubSect;

			if(!mMerge.equals("NONE"))
			{	
				if(mMainSec.equals(mSectBranch) && mSub.equals(mSubSect))
				{
					qryo="select fstid from PR#HODLOADDISTRIBUTION where institutecode='"+mINSTITUTECODE+"' and examcode='"+mExamCode+"' and ";
					qryo=qryo+" SUBJECTID='"+mSUBJECTID+"'  and programcode='"+mPc+"'  and sectionbranch='"+moldsecbr+"' and ";
					qryo=qryo+" subsectioncode='"+mMergeSec+"' and LTP='"+mLTP+"'  and Semestertype='REG' ";
					rso1=db.getRowset(qryo);	
					if(rso1.next())
					{
						mImMergeSec=rso1.getString("fstid");
					}
					else
					{
						mImMergeSec="";
					}
				}
				else
				{
					mImMergeSec="";
				}
			} 	//closing of if(!mMerge.equals("NONE"))
			else
			{
				mImMergeSec="";
			}


			qry=" select  nvl(REQROOMTYPE,' ') roomtype from PR#FACULTYSUBJECTCHOICES ";
			qry=qry+" where institutecode='"+mINSTITUTECODE+"' and examcode='"+mExamCode+"'";
			qry=qry+" and SUBJECTID='"+mSUBJECTID+"' and facultytype='"+mETyp+"' and facultyid='"+mEid+"' ";
			qry=qry+" and LTP='"+mLTP+"' and subjecttype='"+mType+"' ";
			//out.println(qry);
			rs=db.getRowset(qry);
			if(rs.next())
			{
			  if(mroomtype.equals(""))
			  {	
 				mroomtype="";
		        }
				mroomtype=rs.getString("roomtype").trim();
		      }
			else
			{
				mroomtype="";
			}	
			
			/*String id=mLTP+mSectBranch+mSubSect;
			
			String qry88="select 'Y' from Temp#pr#loaddistribution a where  SUBJECTID='"+mSUBJECTID+"' and LTP='"+mLTP+"' and SECTIONBRANCH='"+mSectBranch+"' and SUBSECTIONCODE='"+mSubSect+"' and sessionid='"+id+"' and EMPLOYEEID='"+mEid+"'";
			//out.println(qry88);
			rs88=db.getRowset(qry88);
			if(!rs88.next())
			{*/
				try{
			String qry12323=" select 'y' from PR#HODLOADDISTRIBUTION where INSTITUTECODE='"+mINSTITUTECODE+"' and COMPANYCODE='"+mEcmp+"' and FACULTYTYPE='"+mETyp+"' and  FACULTYID='"+mEid+"' and  EXAMCODE ='"+mExamCode+"' and ACADEMICYEAR='"+mAcad+"' and PROGRAMCODE='"+mProg+"' and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mSectBranch+"' and SUBSECTIONCODE='"+mSubSect+"' and SEMESTER='"+mSem+"' and SEMESTERTYPE='"+mSemt+"' and BASKET='"+mBasket+"' and SUBJECTID='"+mSUBJECTID+"' and LTP='"+mLTP+"'";
			//out.println(qry12323);
			rs123456=db.getRowset(qry12323);
			if(!rs123456.next())
			{
				Fstid=db.GenerateFSTID(mINSTITUTECODE);
			qry="insert into PR#HODLOADDISTRIBUTION (INSTITUTECODE, COMPANYCODE, FACULTYTYPE, ";
			qry=qry+" FACULTYID, EXAMCODE, ACADEMICYEAR, PROGRAMCODE, TAGGINGFOR, SECTIONBRANCH, ";
			qry=qry+" SUBSECTIONCODE, SEMESTER, SEMESTERTYPE, BASKET, SUBJECTID, LTP,REQROOMTYPE, ";
			qry=qry+"  DEPARTMENTRUNNIG, DURATIONOFCLASS, NOOFCLASSINAWEEK, ";
			qry=qry+"  STATUS, ENTRYBY, ENTRYDATE,FSTID,MERGEWITHFSTID,SUBJECTTYPE,ELECTIVECODE) values  ";
			qry=qry+" ('"+mINSTITUTECODE+"','"+mEcmp+"','"+mETyp+"','"+mEid+"','"+mExamCode+"',	'"+mAcad+"', ";
			qry=qry+" '"+mProg+"','"+mTag+"','"+mSectBranch+"','"+mSubSect+"','"+mSem+"','"+mSemt+"', ";
			qry=qry+" '"+mBasket+"','"+mSUBJECTID+"','"+mLTP+"','"+mroomtype+"', ";	
			qry=qry+" '"+mDept+"','"+mDuration+"','"+mClass+"','D','"+mChkMemID+"',sysdate,'"+Fstid+"','"+mImMergeSec+"','"+mType+"','"+mElective+"'  ) ";
			int n=db.insertRow(qry);
			//out.println(qry);
			
			
			qry="";
			qry="select FACULTYID from PR#HODLOADDISTRIBUTION  where fstid='"+mImMergeSec+"'";
			//out.println(qry);
			rs=db.getRowset(qry);	
			while(rs.next())
			{
				mEmpIdTemp=rs.getString("FACULTYID");
				
			}
			//out.println(Fstid+"Fstid");
			 String id=mLTP+mSectBranch+mSubSect;
			qry="";
			//qry="select a.EMPLOYEEID,a.FACULTYTYPE,a.NOFHRS from Temp#pr#loaddistribution a where COMPANYCODE='"+mEcmp+"' and SUBJECTID='"+mSUBJECTID+"' and LTP='"+mLTP+"' and SECTIONBRANCH='"+mSectBranch+"' and SUBSECTIONCODE='"+mSubSect+"' and sessionid='"+id+"'";
			qry="";
			qry="delete from Temp#pr#loaddistribution  where  SUBJECTID='"+mSUBJECTID+"' and LTP='"+mLTP+"' and SECTIONBRANCH='"+mSectBranch+"' and SUBSECTIONCODE='"+mSubSect+"' and sessionid='"+id+"' and EMPLOYEEID='"+mEid+"' and academicyear='"+mAcad+"' and programcode='"+mProg+"'";
			//out.println(qry);
			int n12=db.insertRow(qry);
			qry="select a.EMPLOYEEID,a.FACULTYTYPE,a.NOFHRS,a.FACULTYSET, a.CLASSINAWEEK,nvl(a.set1,'0')set1,nvl(a.SET2,'0')set2,nvl(a.SET3,'0')set3 from Temp#pr#loaddistribution a where  SUBJECTID='"+mSUBJECTID+"' and LTP='"+mLTP+"' and SECTIONBRANCH='"+mSectBranch+"' and SUBSECTIONCODE='"+mSubSect+"' and sessionid='"+id+"' and academicyear='"+mAcad+"' and programcode='"+mProg+"'";
			//out.print(qry);
			rs=db.getRowset(qry);
			while(rs.next())
			{
				
				if(!mEid.equals(rs.getString("EMPLOYEEID")));
				{
					qry="INSERT INTO MULTIFACULTYSUBJECTTAGGING (";
					qry=qry+" INSTITUTECODE, COMPANYCODE, FSTID, FACULTYTYPE, EMPLOYEEID, NOFHRS,ENTRYBY,  ENTRYDATE, DEACTIVE,FACULTYSET, CLASSINAWEEK,SET1,SET2,SET3)";
					qry=qry+" VALUES ('"+mINSTITUTECODE+"','"+mEcmp+"','"+Fstid+"','"+rs.getString("FACULTYTYPE")+"','"+rs.getString("EMPLOYEEID")+"' , '"+rs.getString("NOFHRS")+"','"+mChkMemID+"', sysdate,'N','"+rs.getString("FACULTYSET")+"','"+rs.getString("CLASSINAWEEK")+"','"+rs.getString("set1")+"','"+rs.getString("set2")+"','"+rs.getString("set3")+"')";		
					//out.println(qry);
					int n1=db.insertRow(qry);
					//int ii=0;
					if(ii==0)
					{
						/*String qry123234=" update PR#HODLOADDISTRIBUTION set NOOFCLASSINAWEEK='"+rs.getString("set1") +"' where INSTITUTECODE='"+mINSTITUTECODE+"' and COMPANYCODE='"+mEcmp+"' and FACULTYTYPE='"+mETyp+"' and  FACULTYID='"+mEid+"' and  EXAMCODE ='"+mExamCode+"' and ACADEMICYEAR='"+mAcad+"' and PROGRAMCODE='"+mProg+"' and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mSectBranch+"' and SUBSECTIONCODE='"+mSubSect+"' and SEMESTER='"+mSem+"' and SEMESTERTYPE='"+mSemt+"' and BASKET='"+mBasket+"' and SUBJECTID='"+mSUBJECTID+"' and LTP='"+mLTP+"' and fstid='"+Fstid+"'";
						//out.println(qry123234);
						int n10=db.insertRow(qry123234);*/
						ii=1;
				}

				}
			
			}
				qry="delete  from Temp#pr#loaddistribution a where  SUBJECTID='"+mSUBJECTID+"' and LTP='"+mLTP+"' and SECTIONBRANCH='"+mSectBranch+"' and SUBSECTIONCODE='"+mSubSect+"' and sessionid='"+id+"' and academicyear='"+mAcad+"' and programcode='"+mProg+"'";
				//out.println(qry);
				int n1=db.insertRow(qry);
			
			}
			
			}catch(Exception e)
			{
				//out.println(e+"ssss");
			}
			qry1="select employeename from V#STAFF where employeeid='"+mEid+"' and  COMPANYCODE='"+mEcmp+"' ";
			
			rse=db.getRowset(qry1);
			if (rse.next())
			mEid1=rse.getString("employeename");
			qry="select DURATIONOFCLASS,NOOFCLASSINAWEEK from PR#HODLOADDISTRIBUTION where institutecode='"+mINSTITUTECODE+"' and COMPANYCODE='"+mEcmp+"' and  SUBJECTID='"+mSUBJECTID+"' and sectionbranch='"+mSectBranch+"' and  LTP='"+mLTP+"' and semestertype='"+mSemt+"' and FACULTYID='"+mEid+"' order by DURATIONOFCLASS ";
//out.println("123 "+qry);
			rse=db.getRowset(qry);	
			if(rse.next())
			{
				duration=rse.getString("NOOFCLASSINAWEEK");
			}
		   %>
			<tr>
			<td><%=rs1.getString("SECTIONBRANCH")%></td>
			 <td><%=mSubSect%></td> 
			<td><%=mEid1%></td>
			<td><%=duration%></td>
			<td>SET-1</td>
			<td><font color=green>Saved</font></td>
			</tr>
		   <% 
			//qry="select b.EMPLOYEENAME,a.NOFHRS from FACULTYSUBJECTTAGGING a,V#STAFF b  where a.EMPLOYEEID=b.EMPLOYEEID	and a.COMPANYCODE =b.COMPANYCODE and a.FSTID='"+Fstid+"'";
			String qry23=" select fstid from PR#HODLOADDISTRIBUTION where INSTITUTECODE='"+mINSTITUTECODE+"' and COMPANYCODE='"+mEcmp+"' and FACULTYTYPE='"+mETyp+"' and  FACULTYID='"+mEid+"' and  EXAMCODE ='"+mExamCode+"' and ACADEMICYEAR='"+mAcad+"' and PROGRAMCODE='"+mProg+"' and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mSectBranch+"' and SUBSECTIONCODE='"+mSubSect+"' and SEMESTER='"+mSem+"' and SEMESTERTYPE='"+mSemt+"' and BASKET='"+mBasket+"' and SUBJECTID='"+mSUBJECTID+"' and LTP='"+mLTP+"'";
			rs123456=db.getRowset(qry23);
			if(rs123456.next())
			{
			
			qry="select b.EMPLOYEENAME,a.CLASSINAWEEK,a.FACULTYSET from MULTIFACULTYSUBJECTTAGGING a,V#STAFF b  where a.EMPLOYEEID=b.EMPLOYEEID	and a.FSTID='"+rs123456.getString("fstid")+"' and  b.COMPANYCODE='"+mEcmp+"' and  nvl(a.deactive,'N')='N' and nvl(b.deactive,'N')='N'";
			//out.println(qry);
			rsse=db.getRowset(qry);
			while (rsse.next())
			{
				%><tr>
				<td><%=rs1.getString("SECTIONBRANCH")%></td>
				<td><%=mSubSect%></td> 
				<td><%=rsse.getString("EMPLOYEENAME")%></td>
				<td><%=rsse.getString("CLASSINAWEEK")%></td>
				<td><%=rsse.getString("FACULTYSET")%></td>
				<td><font color=green>Saved</font></td>
				</tr>
				<%
			}
			}
			/*}
			else
				{
				out.println("please Select Different Employee id ");
				break;
				}*/
			

	}  // closing of if if(!mEmp.equals("NONE"))
	else
	{
		
	}
}   //closing of moldnew="N"
else
{
		mSeccount=rs1.getString("cnt");
		mSubsection=rs1.getString("subsectioncode");
		if(!mSection.equals(rs1.getString("SECTIONBRANCH")))
			{
			ctr=1;
			mSection=rs1.getString("SECTIONBRANCH");	
			}
		    else
			 ctr++;
			 
			mNameL=mSection+"***L///"+String.valueOf(ctr).trim()+"###"+mSeccount ; 
			mNameR=mSection+"***R///"+String.valueOf(ctr).trim()+"###"+mSeccount ;  
			mNameLML=mSection+"***L///"+String.valueOf(ctr).trim()+"###"+mSeccount+"merge";    
			mNameLMR=mSection+"***R///"+String.valueOf(ctr).trim()+"###"+mSeccount+"merge";   

		/*out.println("mNameL"+mNameL);
		out.println("mNameR<br>"+mNameL);
		out.println("mNameLML<br>"+mNameL);
		out.println("mNameLMR<br>"+mNameL);*/
		mMerge=request.getParameter(mNameLML);
		//out.println("<br>"+mMerge);
		if(mMerge!=null && mMerge.equals("NONE"))
		{
			mMerge=request.getParameter(mNameLMR).toString().trim();
		}
		else
			mMerge="";
		mEmp=request.getParameter(mNameL);
		//out.println(mEmp);
		if(mEmp!=null &&  mEmp.equals("NONE"))
		{
			mEmp=request.getParameter(mNameR).toString().trim();
		}
		else
			mEmp="";
		//out.println(mEmp);
	if(!mEmp.equals("NONE") && !mEmp.equals(""))
	{
		if(!mMerge.equals("NONE") && !mMerge.equals(""))
				{	

				mlen=mMerge.length();
				mpos1=mMerge.indexOf("***");
				mpos2=mMerge.indexOf("///");
				mpos3=mMerge.indexOf("###");
				mpos4=mMerge.indexOf("$$$");

				mMainSec=mMerge.substring(0,mpos1);
				mSub=mMerge.substring(mpos1+3,mpos2);
				mMergeSec=mMerge.substring(mpos2+3,mpos3);

				mPc=mMerge.substring(mpos3+3,mpos4);

				moldsecbr=mMerge.substring(mpos4+3,mlen);

				}

			len=mEmp.length();
			pos1=mEmp.indexOf("***");	
			pos2=mEmp.indexOf("*****");
			pos3=mEmp.indexOf("/////");	
			pos4=mEmp.indexOf("///");
			pos5=mEmp.indexOf("###");
			pos6=mEmp.indexOf("$$$$");

			mEid=mEmp.substring(0,pos1);
			mETyp=mEmp.substring(pos2+5,pos3);
			mEcmp=mEmp.substring(pos3+5,pos6);
			mAssign1=mEmp.substring(pos1+3,pos4);
			mMin1=mEmp.substring(pos4+3,pos5);
			mMax1=mEmp.substring(pos5+3,pos2);
	
			
			mAcad=rs1.getString("ACADEMICYEAR");
			mProg=rs1.getString("PROGRAMCODE");
			mTag=rs1.getString("TAGGINGFOR");
			mSectBranch=rs1.getString("SECTIONBRANCH");
			mSubSect=rs1.getString("SUBSECTIONCODE");
			mSem=rs1.getString("SEMESTER");
			mSemt=rs1.getString("SEMESTERTYPE");
		
		if(!mMerge.equals("NONE") || !mMerge.equals(""))
			{	
				if(mMainSec.equals(mSectBranch) && mSub.equals(mSubSect))
				{
					qryo="select fstid from PR#HODLOADDISTRIBUTION where institutecode='"+mINSTITUTECODE+"' and examcode='"+mExamCode+"' and ";
					qryo=qryo+" SUBJECTID='"+mSUBJECTID+"'  and programcode='"+mPc+"' and sectionbranch='"+moldsecbr+"' and ";
					qryo=qryo+" subsectioncode='"+mMergeSec+"' and semestertype='REG' and LTP='"+mLTP+"' ";
					rso1=db.getRowset(qryo);	
					if(rso1.next())
					{
						mImMergeSec=rso1.getString("fstid");
					}
					else
					{
						mImMergeSec="";
					}
				}
				else
				{
					mImMergeSec="";
				}
			} 	//closing of if(!mMerge.equals("NONE"))
			else
			{
				mImMergeSec="";
			}
		qry=" select  nvl(REQROOMTYPE,' ') roomtype from PR#FACULTYSUBJECTCHOICES ";
		qry=qry+" where institutecode='"+mINSTITUTECODE+"' and examcode='"+mExamCode+"'";
		qry=qry+" and SUBJECTID='"+mSUBJECTID+"'  and facultytype='"+mETyp+"' and facultyid='"+mEid+"' ";
		qry=qry+" and LTP='"+mLTP+"' and subjecttype='"+mType+"' ";
		//out.println(qry);
		rs=db.getRowset(qry);
		if(rs.next())
		{
 			if(mroomtype.equals(""))
			{	
			mroomtype="";
			}
			mroomtype=rs.getString("roomtype").trim();
		}
		else
		{
		mroomtype="";
		}	
		
		/*String id=mLTP+mSectBranch+mSubSect;
			
			String qry88="select 'Y' from Temp#pr#loaddistribution a where  SUBJECTID='"+mSUBJECTID+"' and LTP='"+mLTP+"' and SECTIONBRANCH='"+mSectBranch+"' and SUBSECTIONCODE='"+mSubSect+"' and sessionid='"+id+"' and EMPLOYEEID='"+mEid+"'";
			//out.println(qry88);
			rs88=db.getRowset(qry88);
			if(!rs88.next())
			{*/
		
		
		
		qry="update PR#HODLOADDISTRIBUTION set FACULTYTYPE='"+mETyp+"',FACULTYID='"+mEid+"', ";
		qry=qry+"  REQROOMTYPE='"+mroomtype+"', MERGEWITHFSTID='"+mImMergeSec+"' , ";
		qry=qry+"  DURATIONOFCLASS='"+mDuration+"', ";//NOOFCLASSINAWEEK='"+mClass+"' ,
		qry=qry+"   ENTRYDATE=sysdate where INSTITUTECODE='"+mINSTITUTECODE+"' and ";
		qry=qry+"  COMPANYCODE='"+mEcmp+"' and EXAMCODE='"+mExamCode+"' and ACADEMICYEAR='"+mAcad+"' ";
		qry=qry+"  and PROGRAMCODE='"+mProg+"' and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mSectBranch+"' ";
		qry=qry+"  and SUBSECTIONCODE='"+mSubSect+"' and SEMESTER='"+mSem+"' and SEMESTERTYPE='"+mSemt+"' ";
		qry=qry+" and BASKET='"+mBasket+"' and SUBJECTID='"+mSUBJECTID+"'  and LTP='"+mLTP+"'  ";
		//out.println(qry);
		int n=db.update(qry);
		try
		{
			/***/
			
		

			
		qry=" select fstid from PR#HODLOADDISTRIBUTION where INSTITUTECODE='"+mINSTITUTECODE+"' and ";
		qry=qry+"  COMPANYCODE='"+mEcmp+"' and EXAMCODE='"+mExamCode+"' and ACADEMICYEAR='"+mAcad+"' ";
		qry=qry+"  and PROGRAMCODE='"+mProg+"' and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mSectBranch+"' ";
		qry=qry+"  and SUBSECTIONCODE='"+mSubSect+"' and SEMESTER='"+mSem+"' and SEMESTERTYPE='"+mSemt+"' ";
		qry=qry+" and BASKET='"+mBasket+"' and SUBJECTID='"+mSUBJECTID+"'  and LTP='"+mLTP+"' ";
//		out.println(qry);
		rsfstid=db.getRowset(qry);
		while(rsfstid.next())
		{
			
			//out.println("dddddddddddddddddddddddddddddddddddd");
			
			fstidupdate =rsfstid.getString("fstid");
			//out.println("dddddddddddddddddddddddddddddddddddd");
		}
			
			
			
			if(n>0)
			{
			
			//out.println((String [])session.getAttribute("MultiFaculti"));
			 String id=mLTP+mSectBranch+mSubSect;
			 //out.println(id+123);
			qry="";
			// COMPANYCODE='"+mEcmp+"' and
			qry="select 'Y' from Temp#pr#loaddistribution a where SUBJECTID='"+mSUBJECTID+"' and LTP='"+mLTP+"' and SECTIONBRANCH='"+mSectBranch+"' and SUBSECTIONCODE='"+mSubSect+"' and sessionid='"+id+"'  and academicyear='"+mAcad+"' and programcode='"+mProg+"'";
//			out.print(qry);
			rs=db.getRowset(qry);
			if(rs.next())
			

			/**/
			{
			qry="delete MULTIFACULTYSUBJECTTAGGING where FSTID='"+fstidupdate+"'";
			//out.println("dddddddddddddddddddddddddddddddddddd"+fstidupdate);
			//out.println(qry);
			int ndel=db.insertRow(qry);
			qry="";
			qry="delete from Temp#pr#loaddistribution  where  SUBJECTID='"+mSUBJECTID+"' and LTP='"+mLTP+"' and SECTIONBRANCH='"+mSectBranch+"' and SUBSECTIONCODE='"+mSubSect+"' and sessionid='"+id+"' and EMPLOYEEID='"+mEid+"' and academicyear='"+mAcad+"' and programcode='"+mProg+"'";
			//out.println(qry);
			int n13=db.insertRow(qry);
			qry="";
			qry="select a.EMPLOYEEID,a.FACULTYTYPE,a.NOFHRS,a.FACULTYSET, a.CLASSINAWEEK ,nvl(a.set1,'0')set1,nvl(a.set2,'0')set2,nvl(a.set3,'0')set3 from Temp#pr#loaddistribution a where  SUBJECTID='"+mSUBJECTID+"' and LTP='"+mLTP+"' and SECTIONBRANCH='"+mSectBranch+"' and SUBSECTIONCODE='"+mSubSect+"' and sessionid='"+id+"'  and academicyear='"+mAcad+"' and programcode='"+mProg+"'";
			//out.print(qry);
			rs=db.getRowset(qry);
			while(rs.next())
			{
				//out.println(mEid+"<br>");
				//out.println(rs.getString("EMPLOYEEID"));
				if(!mEid.equals(rs.getString("EMPLOYEEID")));
				{
				qry="INSERT INTO MULTIFACULTYSUBJECTTAGGING (";
				qry=qry+" INSTITUTECODE, COMPANYCODE, FSTID, FACULTYTYPE, EMPLOYEEID, NOFHRS,ENTRYBY,  ENTRYDATE, DEACTIVE,FACULTYSET, CLASSINAWEEK,set1,set2,set3)";
				qry=qry+" VALUES ('"+mINSTITUTECODE+"','"+mEcmp+"','"+fstidupdate+"','"+rs.getString("FACULTYTYPE")+"','"+rs.getString("EMPLOYEEID")+"' , '"+rs.getString("NOFHRS")+"','"+mChkMemID+"', sysdate,'N','"+rs.getString("FACULTYSET")+"','"+rs.getString("CLASSINAWEEK")+"','"+rs.getString("set1")+"','"+rs.getString("set2")+"','"+rs.getString("set3")+"')";		
//				out.println(qry);
				int n1=db.insertRow(qry);

					if(iii==0)
					{
						/*String qry231=" update PR#HODLOADDISTRIBUTION set NOOFCLASSINAWEEK='"+rs.getString("set1") +"'  where INSTITUTECODE='"+mINSTITUTECODE+"' and COMPANYCODE='"+mEcmp+"' and FACULTYTYPE='"+mETyp+"' and  FACULTYID='"+mEid+"' and  EXAMCODE ='"+mExamCode+"' and ACADEMICYEAR='"+mAcad+"' and PROGRAMCODE='"+mProg+"' and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mSectBranch+"' and SUBSECTIONCODE='"+mSubSect+"' and SEMESTER='"+mSem+"' and SEMESTERTYPE='"+mSemt+"' and BASKET='"+mBasket+"' and SUBJECTID='"+mSUBJECTID+"' and LTP='"+mLTP+"' and fstid='"+fstidupdate+"'";
//						out.println(qry231);
						int n111=db.insertRow(qry231);*/
						iii=1;
					}
				
				
				}
			}
			/*qry="select Temp#pr#loaddistribution a where COMPANYCODE='"+mEcmp+"' and SUBJECTID='"+mSUBJECTID+"' and LTP='"+mLTP+"' and SECTIONBRANCH='"+mSectBranch+"' and SUBSECTIONCODE='"+mSubSect+"' and sessionid='"+id+"'";*/
			//COMPANYCODE='"+mEcmp+"' and
			
			qry="delete from Temp#pr#loaddistribution  where  SUBJECTID='"+mSUBJECTID+"' and LTP='"+mLTP+"' and SECTIONBRANCH='"+mSectBranch+"' and SUBSECTIONCODE='"+mSubSect+"' and sessionid='"+id+"' and academicyear='"+mAcad+"' and programcode='"+mProg+"'";
			//out.println(qry);
			int n17=db.insertRow(qry);
			/**/
			}
			/***/
			}
				
		}	
		catch(Exception e)
		{
			//out.println(e);
		}
		
		
		
		
		qry1="select employeename from V#STAFF where employeeid='"+mEid+"' and COMPANYCODE='"+mEcmp+"' ";
		rse=db.getRowset(qry1);
		//out.println(qry1);
		if (rse.next())
		mEid1=rse.getString("employeename");
		qry="select DURATIONOFCLASS,NOOFCLASSINAWEEK from PR#HODLOADDISTRIBUTION where institutecode='"+mINSTITUTECODE+"' and COMPANYCODE='"+mEcmp+"' and  SUBJECTID='"+mSUBJECTID+"' and sectionbranch='"+mSectBranch+"' and  LTP='"+mLTP+"' and semestertype='"+mSemt+"' and PROGRAMCODE='"+mProg+"' and FACULTYID='"+mEid+"' and DEPARTMENTRUNNIG='"+mDept+"' order by DURATIONOFCLASS ";
//out.println("123 "+qry);
			rse=db.getRowset(qry);	
			if(rse.next())
			{
				duration=rse.getString("NOOFCLASSINAWEEK");
			}
	  %>
		<tr>
		<td><%=rs1.getString("SECTIONBRANCH")%></td>
		<td><%=mSubSect%></td>
		<td><%=mEid1%></td>
		<td><%=duration%></td>
		<td> SET-1</td>
		<td>Modified</td>
		</tr>
		<% 
		String qry23=" select fstid from PR#HODLOADDISTRIBUTION where INSTITUTECODE='"+mINSTITUTECODE+"' and COMPANYCODE='"+mEcmp+"' and FACULTYTYPE='"+mETyp+"' and  FACULTYID='"+mEid+"' and  EXAMCODE ='"+mExamCode+"' and ACADEMICYEAR='"+mAcad+"' and PROGRAMCODE='"+mProg+"' and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mSectBranch+"' and SUBSECTIONCODE='"+mSubSect+"' and SEMESTER='"+mSem+"' and SEMESTERTYPE='"+mSemt+"' and BASKET='"+mBasket+"' and SUBJECTID='"+mSUBJECTID+"' and LTP='"+mLTP+"' and DEPARTMENTRUNNIG='"+mDept+"' ";
			//out.println(qry23);
			rs123456=db.getRowset(qry23);
			if(rs123456.next())
			{
			
			qry="select b.EMPLOYEENAME,a.CLASSINAWEEK,a.FACULTYSET from MULTIFACULTYSUBJECTTAGGING a,V#STAFF b  where a.EMPLOYEEID=b.EMPLOYEEID	and a.FSTID='"+rs123456.getString("fstid")+"' and  b.COMPANYCODE='"+mEcmp+"' and  nvl(a.deactive,'N')='N' and nvl(b.deactive,'N')='N'";
			//out.println(qry);
			rsse=db.getRowset(qry);
			while (rsse.next())
			{
				%><tr>
				<td><%=rs1.getString("SECTIONBRANCH")%></td>
				<td><%=mSubSect%></td> 
				<td><%=rsse.getString("EMPLOYEENAME")%></td>
				<td><%=rsse.getString("CLASSINAWEEK")%></td>
				<td><%=rsse.getString("FACULTYSET")%></td>
				<td><font color=black>Modified</font></td>
				</tr>
				<%
			}
			}			
			/*}
			else
		{
				out.println("check the code");
		}*/

	  
	 
		
  	}  // closing of if  if(!mEmp.equals("NONE"))
	else
	{
			mAcad=rs1.getString("ACADEMICYEAR");
			mProg=rs1.getString("PROGRAMCODE");
			mTag=rs1.getString("TAGGINGFOR");
			mSectBranch=rs1.getString("SECTIONBRANCH");
			mSubSect=rs1.getString("SUBSECTIONCODE");
			mSem=rs1.getString("SEMESTER");
			mSemt=rs1.getString("SEMESTERTYPE");
	
		qry=" delete from PR#HODLOADDISTRIBUTION where ";
		qry=qry+"  INSTITUTECODE='"+mINSTITUTECODE+"' and ";
		qry=qry+"  EXAMCODE='"+mExamCode+"' and ACADEMICYEAR='"+mAcad+"' ";
		qry=qry+"  and PROGRAMCODE='"+mProg+"' and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mSectBranch+"' ";
		qry=qry+"  and SUBSECTIONCODE='"+mSubSect+"' and SEMESTER='"+mSem+"' and SEMESTERTYPE='"+mSemt+"' ";
		qry=qry+" and BASKET='"+mBasket+"' and SUBJECTID='"+mSUBJECTID+"'  and LTP='"+mLTP+"' ";
		int n=db.insertRow(qry);
		}    // closing of else 
	  } // closing of else moldnew
	} //closing of while.....

		} // CLOSING OF ELSE

		// Log Entry
			//-----------------
  db.saveTransLog(mINSTITUTECODE,mLogEntryMemberID,mLogEntryMemberType ,"Pre Reg. Load Distribution ", "ExamCode:"+mExamCode+" SubjectID:"+mSUBJECTID+"Depatrment Running:"+ mDept, "NO MAC Address" , mIPAddress);
		     //-----------------



	 } //3
	 else
	 {
		out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>No Record Found...!</font> <br>");	
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
}  //2
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
}	//1	
catch(Exception e)
{
	//out.print(e);
	out.print("No Item Selected...");
}
%>
<table ALIGN=Center VALIGN=TOP>
		<tr>
		<td valign=middle>
		<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">
		<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
		A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
		<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>  
		</td></tr></table>
</body>
</html>


