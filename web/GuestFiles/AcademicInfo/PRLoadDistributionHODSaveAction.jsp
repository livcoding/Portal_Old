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
ResultSet rs=null,rs1=null,rse=null,rsi=null,rsee=null,rso=null,rso1=null;
String mType="",mSendhod="",mPSS="";

String mName1="",mName2="",mName3="",mName4="",mName5="",mSubjectType="",mMerge="";
String mName6="",mName7="",mName8="",mName9="",mName10="",moldnew="",mEid1="";

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
	<td><b>Status</b></td>
	</tr>
<%

	if(mType.equals("C"))
	{
	qry="select distinct SUBSECTIONCODE subsectioncode,seqid,";
	qry=qry+"A.ACADEMICYEAR,A.PROGRAMCODE,A.TAGGINGFOR,A.SECTIONBRANCH SECTIONBRANCH,A.SEMESTER,";
	qry=qry+" A.SEMESTERTYPE,";
	qry=qry+" (Select count(*) from PROGRAMSUBSECTIONTAGGING C where C.institutecode='"+mINSTITUTECODE+"' and C.examcode='"+mExamCode+"' and ";
	qry=qry+" C.semestertype=decode('"+mSem1+"','ALL',C.semestertype,'"+mSem1+"') and nvl(C.deactive,'N')='N' and ";
	qry=qry+" C.ACADEMICYEAR=A.ACADEMICYEAR and C.PROGRAMCODE=A.PROGRAMCODE and C.SECTIONBRANCH=A.SECTIONBRANCH and";
	qry=qry+" C.SEMESTER=A.SEMESTER and C.SUBSECTIONTYPE='C')cnt from PROGRAMSUBSECTIONTAGGING A, ";
	qry=qry+" PROGRAMSCHEME B where A.institutecode='"+mINSTITUTECODE+"' and A.examcode='"+mExamCode+"' and ";
	qry=qry+" A.semestertype=decode('"+mSem1+"','ALL',A.semestertype,'"+mSem1+"') and nvl(A.deactive,'N')='N' and ";
	qry=qry+" A.ACADEMICYEAR=B.ACADEMICYEAR and A.PROGRAMCODE=B.PROGRAMCODE and A.SECTIONBRANCH=B.SECTIONBRANCH and";
	qry=qry+" A.SEMESTER=B.SEMESTER and B.SUBJECTID='"+mSUBJECTID+"' and A.SUBSECTIONTYPE='C' ";
	qry=qry+" and B.subjectid in (select D.subjectid from PR#DEPARTMENTSUBJECTTAGGING D ";
	qry=qry+" where  D.departmentcode ='"+mDept+"'  and D.SECTIONBRANCH=A.SECTIONBRANCH and D.SECTIONBRANCH=B.SECTIONBRANCH) ";
	qry=qry+" order by A.SECTIONBRANCH,seqid,subsectioncode, ";
	qry=qry+" A.ACADEMICYEAR,A.PROGRAMCODE,A.TAGGINGFOR,A.SEMESTER,";
	qry=qry+" A.SEMESTERTYPE";
	}
	else if(mType.equals("E"))
	{

qry="select distinct SUBSECTIONCODE subsectioncode,seqid, ";
qry=qry+"A.ACADEMICYEAR,A.PROGRAMCODE,A.TAGGINGFOR,A.SECTIONBRANCH SECTIONBRANCH,A.SEMESTER,";
qry=qry+" A.SEMESTERTYPE,";
qry=qry+" (Select count(*) from PROGRAMSUBSECTIONTAGGING C where C.institutecode='"+mINSTITUTECODE+"' and C.examcode='"+mExamCode+"' and ";
qry=qry+" C.semestertype=decode('"+mSem1+"','ALL',C.semestertype,'"+mSem1+"') and nvl(C.deactive,'N')='N' and ";
qry=qry+" C.ACADEMICYEAR=A.ACADEMICYEAR and C.PROGRAMCODE=A.PROGRAMCODE and C.SECTIONBRANCH=A.SECTIONBRANCH and";

qry=qry+" C.SEMESTER=A.SEMESTER and C.SUBSECTIONTYPE='E' )cnt from PROGRAMSUBSECTIONTAGGING A, ";
qry=qry+" PR#ELECTIVESUBJECTS B where B.SUBJECTRUNNING='Y' AND A.institutecode='"+mINSTITUTECODE+"' and B.ELECTIVECODE='"+mElective+"' and  A.examcode='"+mExamCode+"' and ";
qry=qry+" A.semestertype=decode('"+mSem1+"','ALL',A.semestertype,'"+mSem1+"') and nvl(A.deactive,'N')='N' and ";
	qry=qry+" A.ACADEMICYEAR=B.ACADEMICYEAR and A.PROGRAMCODE=B.PROGRAMCODE and A.EXAMCODE=B.EXAMCODE and A.SECTIONBRANCH=B.SECTIONBRANCH ";
	qry=qry+" AND A.SEMESTER=B.SEMESTER and B.SUBJECTID='"+mSUBJECTID+"' and A.SUBSECTIONTYPE='E' ";
	qry=qry+" and B.subjectid in (select D.subjectid from PR#DEPARTMENTSUBJECTTAGGING D ";
	qry=qry+" where  D.departmentcode ='"+mDept+"'  and D.SECTIONBRANCH=A.SECTIONBRANCH and D.SECTIONBRANCH=B.SECTIONBRANCH) ";
	qry=qry+" order by A.SECTIONBRANCH,seqid,subsectioncode, ";
	qry=qry+" A.ACADEMICYEAR,A.PROGRAMCODE,A.TAGGINGFOR,A.SEMESTER,";
	qry=qry+" A.SEMESTERTYPE";
	}
	else
	{
	qry="select distinct SUBSECTIONCODE subsectioncode,seqid, ";
	qry=qry+"A.ACADEMICYEAR,A.PROGRAMCODE,A.TAGGINGFOR,A.SECTIONBRANCH SECTIONBRANCH,A.SEMESTER,";
	qry=qry+" A.SEMESTERTYPE,";
	qry=qry+" (Select count(*) from PROGRAMSUBSECTIONTAGGING C where C.institutecode='"+mINSTITUTECODE+"' and C.examcode='"+mExamCode+"' and ";
	qry=qry+" C.semestertype=decode('"+mSem1+"','ALL',C.semestertype,'"+mSem1+"') and nvl(C.deactive,'N')='N' and ";
	qry=qry+" C.ACADEMICYEAR=A.ACADEMICYEAR and C.PROGRAMCODE=A.PROGRAMCODE and C.SECTIONBRANCH=A.SECTIONBRANCH and";
	qry=qry+" C.SEMESTER=A.SEMESTER and C.SUBSECTIONTYPE='F' )cnt from PROGRAMSUBSECTIONTAGGING A, ";
	qry=qry+" FREEELECTIVE B where B.SUBJECTRUNNING='Y' AND A.institutecode='"+mINSTITUTECODE+"' and A.examcode='"+mExamCode+"' and ";
	qry=qry+" A.semestertype=decode('"+mSem1+"','ALL',A.semestertype,'"+mSem1+"') and nvl(A.deactive,'N')='N' and ";
	qry=qry+" A.ACADEMICYEAR=B.ACADEMICYEAR and A.PROGRAMCODE=B.PROGRAMCODE and A.EXAMCODE=B.EXAMCODE and A.SECTIONBRANCH=B.SECTIONBRANCH ";
	qry=qry+" AND A.SEMESTER=B.SEMESTER and B.SUBJECTID='"+mSUBJECTID+"' and A.SUBSECTIONTYPE='F' ";
	qry=qry+" and B.subjectid in (select D.subjectid from PR#DEPARTMENTSUBJECTTAGGING D ";
	qry=qry+" where  D.departmentcode ='"+mDept+"'  and D.SECTIONBRANCH=A.SECTIONBRANCH and D.SECTIONBRANCH=B.SECTIONBRANCH) ";
	qry=qry+" order by A.SECTIONBRANCH,seqid,subsectioncode, ";
	qry=qry+" A.ACADEMICYEAR,A.PROGRAMCODE,A.TAGGINGFOR,A.SEMESTER,";
	qry=qry+" A.SEMESTERTYPE";
	}
	rs1=db.getRowset(qry);
	//ctr=0;
	String mChkFac[]=new String[200];
	int x=0;

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

		    
			mMerge=request.getParameter(mNameLML).toString().trim();
			
			if(mMerge.equals("NONE"))
			{
				mMerge=request.getParameter(mNameLMR).toString().trim();
			}
			
		    
			  mEmp=request.getParameter(mNameL).toString().trim();
			
			if(mEmp.equals("NONE"))
			{
				mEmp=request.getParameter(mNameR).toString().trim();
			}
			if(!mEmp.equals("NONE"))
			{
						
				if(!mMerge.equals("NONE"))
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
	
			if(mfound==0 || x==0)
			{
				mChkFac[x]=mEid;
				x++;
	
	if(mType.equals("C"))
	{
	qry1="select distinct SUBSECTIONCODE subsectioncode, seqid,";
	qry1=qry1+"A.ACADEMICYEAR,A.PROGRAMCODE,A.TAGGINGFOR,A.SECTIONBRANCH SECTIONBRANCH,A.SEMESTER,";
	qry1=qry1+" A.SEMESTERTYPE,";
	qry1=qry1+" (Select count(*) from PROGRAMSUBSECTIONTAGGING C where C.institutecode='"+mINSTITUTECODE+"' and C.examcode='"+mExamCode+"' and ";
	qry1=qry1+" C.semestertype=decode('"+mSem1+"','ALL',C.semestertype,'"+mSem1+"') and nvl(C.deactive,'N')='N' and ";
	qry1=qry1+" C.ACADEMICYEAR=A.ACADEMICYEAR and C.PROGRAMCODE=A.PROGRAMCODE and C.SECTIONBRANCH=A.SECTIONBRANCH and";
	qry1=qry1+" C.SEMESTER=A.SEMESTER and C.SUBSECTIONTYPE='C' )cnt from PROGRAMSUBSECTIONTAGGING A, ";
	qry1=qry1+" PROGRAMSCHEME B where A.institutecode='"+mINSTITUTECODE+"' and A.examcode='"+mExamCode+"' and ";
	qry1=qry1+" A.semestertype=decode('"+mSem1+"','ALL',A.semestertype,'"+mSem1+"') and nvl(A.deactive,'N')='N' and ";
	qry1=qry1+" A.ACADEMICYEAR=B.ACADEMICYEAR and A.PROGRAMCODE=B.PROGRAMCODE and A.SECTIONBRANCH=B.SECTIONBRANCH and";
	qry1=qry1+" A.SEMESTER=B.SEMESTER and B.SUBJECTID='"+mSUBJECTID+"' and A.SUBSECTIONTYPE='C' ";
	qry1=qry1+" and B.subjectid in (select D.subjectid from PR#DEPARTMENTSUBJECTTAGGING D ";
	qry1=qry1+" where  D.departmentcode ='"+mDept+"'  and D.SECTIONBRANCH=A.SECTIONBRANCH and D.SECTIONBRANCH=B.SECTIONBRANCH) ";
	qry1=qry1+" order by A.SECTIONBRANCH,seqid,subsectioncode, ";
	qry1=qry1+" A.ACADEMICYEAR,A.PROGRAMCODE,A.TAGGINGFOR,A.SEMESTER,";
	qry1=qry1+" A.SEMESTERTYPE";
	}
	else if(mType.equals("E"))
	{
	qry1="select distinct SUBSECTIONCODE subsectioncode,seqid, ";
	qry1=qry1+"A.ACADEMICYEAR,A.PROGRAMCODE,A.TAGGINGFOR,A.SECTIONBRANCH SECTIONBRANCH,A.SEMESTER,";
	qry1=qry1+" A.SEMESTERTYPE,";
	qry1=qry1+" (Select count(*) from PROGRAMSUBSECTIONTAGGING C where C.institutecode='"+mINSTITUTECODE+"' and C.examcode='"+mExamCode+"' and ";
	qry1=qry1+" C.semestertype=decode('"+mSem1+"','ALL',C.semestertype,'"+mSem1+"') and nvl(C.deactive,'N')='N' and ";
	qry1=qry1+" C.ACADEMICYEAR=A.ACADEMICYEAR and C.PROGRAMCODE=A.PROGRAMCODE and C.SECTIONBRANCH=A.SECTIONBRANCH and";
	qry1=qry1+" C.SEMESTER=A.SEMESTER and C.SUBSECTIONTYPE='E' )cnt from PROGRAMSUBSECTIONTAGGING A, ";
	qry1=qry1+" PR#ELECTIVESUBJECTS B where B.SUBJECTRUNNING='Y' and A.institutecode='"+mINSTITUTECODE+"' and B.ELECTIVECODE='"+mElective+"' and  A.examcode='"+mExamCode+"' and ";
	qry1=qry1+" A.semestertype=decode('"+mSem1+"','ALL',A.semestertype,'"+mSem1+"') and nvl(A.deactive,'N')='N' and ";
	qry1=qry1+" A.ACADEMICYEAR=B.ACADEMICYEAR and A.PROGRAMCODE=B.PROGRAMCODE and A.EXAMCODE=B.EXAMCODE and A.SECTIONBRANCH=B.SECTIONBRANCH ";
	qry1=qry1+" AND A.SEMESTER=B.SEMESTER and B.SUBJECTID='"+mSUBJECTID+"' and A.SUBSECTIONTYPE='E' ";
	qry1=qry1+" and B.subjectid in (select D.subjectid from PR#DEPARTMENTSUBJECTTAGGING D ";
	qry1=qry1+" where  D.departmentcode ='"+mDept+"'  and D.SECTIONBRANCH=A.SECTIONBRANCH and D.SECTIONBRANCH=B.SECTIONBRANCH) ";
	qry1=qry1+" order by A.SECTIONBRANCH,seqid,subsectioncode, ";
	qry1=qry1+" A.ACADEMICYEAR,A.PROGRAMCODE,A.TAGGINGFOR,A.SEMESTER,";
	qry1=qry1+" A.SEMESTERTYPE";
	}
	else
	{
	qry1="select distinct SUBSECTIONCODE subsectioncode,seqid, ";
	qry1=qry1+"A.ACADEMICYEAR,A.PROGRAMCODE,A.TAGGINGFOR,A.SECTIONBRANCH SECTIONBRANCH,A.SEMESTER,";
	qry1=qry1+" A.SEMESTERTYPE,";
	qry1=qry1+" (Select count(*) from PROGRAMSUBSECTIONTAGGING C where C.institutecode='"+mINSTITUTECODE+"' and C.examcode='"+mExamCode+"' and ";
	qry1=qry1+" C.semestertype=decode('"+mSem1+"','ALL',C.semestertype,'"+mSem1+"') and nvl(C.deactive,'N')='N' and ";
	qry1=qry1+" C.ACADEMICYEAR=A.ACADEMICYEAR and C.PROGRAMCODE=A.PROGRAMCODE and C.SECTIONBRANCH=A.SECTIONBRANCH and";
	qry1=qry1+" C.SEMESTER=A.SEMESTER and C.SUBSECTIONTYPE='F' )cnt from PROGRAMSUBSECTIONTAGGING A, ";
	qry1=qry1+" FREEELECTIVE B where B.SUBJECTRUNNING='Y' and A.institutecode='"+mINSTITUTECODE+"' and A.examcode='"+mExamCode+"' and ";
	qry1=qry1+" A.semestertype=decode('"+mSem1+"','ALL',A.semestertype,'"+mSem1+"') and nvl(A.deactive,'N')='N' and ";
	qry1=qry1+" A.ACADEMICYEAR=B.ACADEMICYEAR and A.PROGRAMCODE=B.PROGRAMCODE and A.EXAMCODE=B.EXAMCODE and A.SECTIONBRANCH=B.SECTIONBRANCH ";
	qry1=qry1+" AND A.SEMESTER=B.SEMESTER and B.SUBJECTID='"+mSUBJECTID+"'  and A.SUBSECTIONTYPE='F' ";
	qry1=qry1+" and B.subjectid in (select D.subjectid from PR#DEPARTMENTSUBJECTTAGGING D ";
	qry1=qry1+" where  D.departmentcode ='"+mDept+"'  and D.SECTIONBRANCH=A.SECTIONBRANCH and D.SECTIONBRANCH=B.SECTIONBRANCH) ";
	qry1=qry1+" order by A.SECTIONBRANCH,seqid,subsectioncode, ";
	qry1=qry1+" A.ACADEMICYEAR,A.PROGRAMCODE,A.TAGGINGFOR,A.SEMESTER,";
	qry1=qry1+" A.SEMESTERTYPE";
	}

	rsi=db.getRowset(qry1);
	ctr1=0;
	mweightage=0;
	String mSection1="";
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

			mMerge=request.getParameter(mNameLML).toString().trim();

			if(mMerge.equals("NONE"))
			{
				mMerge=request.getParameter(mNameLMR).toString().trim();
			}
	
				mEmp=request.getParameter(mNameL).toString().trim();
		
			if(mEmp.equals("NONE"))
			{
				mEmp=request.getParameter(mNameR).toString().trim();
			}

			if(!mEmp.equals("NONE"))
			{
						
				if(!mMerge.equals("NONE"))
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


	if(mFlag==1)
	{

	qry=" select employeename from V#STAFF where employeeid='"+mFac+"' ";
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
	qry="select distinct SUBSECTIONCODE subsectioncode,seqid,";
	qry=qry+"A.ACADEMICYEAR,A.PROGRAMCODE,A.TAGGINGFOR,A.SECTIONBRANCH SECTIONBRANCH,A.SEMESTER,";
	qry=qry+" A.SEMESTERTYPE,";
	qry=qry+" (Select count(*) from PROGRAMSUBSECTIONTAGGING C where C.institutecode='"+mINSTITUTECODE+"' and C.examcode='"+mExamCode+"' and ";
	qry=qry+" C.semestertype=decode('"+mSem1+"','ALL',C.semestertype,'"+mSem1+"') and nvl(C.deactive,'N')='N' and ";
	qry=qry+" C.ACADEMICYEAR=A.ACADEMICYEAR and C.PROGRAMCODE=A.PROGRAMCODE and C.SECTIONBRANCH=A.SECTIONBRANCH and";
	qry=qry+" C.SEMESTER=A.SEMESTER and C.SUBSECTIONTYPE='C' )cnt from PROGRAMSUBSECTIONTAGGING A, ";
	qry=qry+" PROGRAMSCHEME B where A.institutecode='"+mINSTITUTECODE+"' and A.examcode='"+mExamCode+"' and ";
	qry=qry+" A.semestertype=decode('"+mSem1+"','ALL',A.semestertype,'"+mSem1+"') and nvl(A.deactive,'N')='N' and ";
	qry=qry+" A.ACADEMICYEAR=B.ACADEMICYEAR and A.PROGRAMCODE=B.PROGRAMCODE and A.SECTIONBRANCH=B.SECTIONBRANCH and";
	qry=qry+" A.SEMESTER=B.SEMESTER and B.SUBJECTID='"+mSUBJECTID+"' and A.SUBSECTIONTYPE='C' ";
	qry=qry+" and B.subjectid in (select D.subjectid from PR#DEPARTMENTSUBJECTTAGGING D ";
	qry=qry+" where  D.departmentcode ='"+mDept+"'  and D.SECTIONBRANCH=A.SECTIONBRANCH and D.SECTIONBRANCH=B.SECTIONBRANCH) ";
	qry=qry+" order by A.SECTIONBRANCH,seqid,subsectioncode, ";
	qry=qry+" A.ACADEMICYEAR,A.PROGRAMCODE,A.TAGGINGFOR,A.SEMESTER,";
	qry=qry+" A.SEMESTERTYPE";
	}
	else if(mType.equals("E"))
	{
	qry="select distinct SUBSECTIONCODE subsectioncode, seqid, ";
	qry=qry+"A.ACADEMICYEAR,A.PROGRAMCODE,A.TAGGINGFOR,A.SECTIONBRANCH SECTIONBRANCH,A.SEMESTER,";
	qry=qry+" A.SEMESTERTYPE,";
	qry=qry+" (Select count(*) from PROGRAMSUBSECTIONTAGGING C where C.institutecode='"+mINSTITUTECODE+"' and C.examcode='"+mExamCode+"' and ";
	qry=qry+" C.semestertype=decode('"+mSem1+"','ALL',C.semestertype,'"+mSem1+"') and nvl(C.deactive,'N')='N' and ";
	qry=qry+" C.ACADEMICYEAR=A.ACADEMICYEAR and C.PROGRAMCODE=A.PROGRAMCODE and C.SECTIONBRANCH=A.SECTIONBRANCH and";
	qry=qry+" C.SEMESTER=A.SEMESTER and C.SUBSECTIONTYPE='E' )cnt from PROGRAMSUBSECTIONTAGGING A, ";
	qry=qry+" PR#ELECTIVESUBJECTS B where B.SUBJECTRUNNING='Y' and  A.institutecode='"+mINSTITUTECODE+"' and B.ELECTIVECODE='"+mElective+"' and  A.examcode='"+mExamCode+"' and ";
	qry=qry+" A.semestertype=decode('"+mSem1+"','ALL',A.semestertype,'"+mSem1+"') and nvl(A.deactive,'N')='N' and ";
	qry=qry+" A.ACADEMICYEAR=B.ACADEMICYEAR and A.PROGRAMCODE=B.PROGRAMCODE and A.EXAMCODE=B.EXAMCODE and A.SECTIONBRANCH=B.SECTIONBRANCH ";
	qry=qry+" AND A.SEMESTER=B.SEMESTER and B.SUBJECTID='"+mSUBJECTID+"' and A.SUBSECTIONTYPE='E' ";
	qry=qry+" and B.subjectid in (select D.subjectid from PR#DEPARTMENTSUBJECTTAGGING D ";
	qry=qry+" where  D.departmentcode ='"+mDept+"'  and D.SECTIONBRANCH=A.SECTIONBRANCH and D.SECTIONBRANCH=B.SECTIONBRANCH) ";
	qry=qry+" order by A.SECTIONBRANCH,seqid,subsectioncode, ";
	qry=qry+"A.ACADEMICYEAR,A.PROGRAMCODE,A.TAGGINGFOR,A.SEMESTER,";
	qry=qry+" A.SEMESTERTYPE";
	}
	else
	{
	qry="select distinct SUBSECTIONCODE subsectioncode,seqid, ";
	qry=qry+"A.ACADEMICYEAR,A.PROGRAMCODE,A.TAGGINGFOR,A.SECTIONBRANCH SECTIONBRANCH,A.SEMESTER,";
	qry=qry+" A.SEMESTERTYPE,";
	qry=qry+" (Select count(*) from PROGRAMSUBSECTIONTAGGING C where C.institutecode='"+mINSTITUTECODE+"' and C.examcode='"+mExamCode+"' and ";
	qry=qry+" C.semestertype=decode('"+mSem1+"','ALL',C.semestertype,'"+mSem1+"') and nvl(C.deactive,'N')='N' and ";
	qry=qry+" C.ACADEMICYEAR=A.ACADEMICYEAR and C.PROGRAMCODE=A.PROGRAMCODE and C.SECTIONBRANCH=A.SECTIONBRANCH and";
	qry=qry+" C.SEMESTER=A.SEMESTER and C.SUBSECTIONTYPE='F' )cnt from PROGRAMSUBSECTIONTAGGING A, ";
	qry=qry+" FREEELECTIVE B where B.SUBJECTRUNNING='Y' and A.institutecode='"+mINSTITUTECODE+"' and A.examcode='"+mExamCode+"' and ";
	qry=qry+" A.semestertype=decode('"+mSem1+"','ALL',A.semestertype,'"+mSem1+"') and nvl(A.deactive,'N')='N' and ";
	qry=qry+" A.ACADEMICYEAR=B.ACADEMICYEAR and A.PROGRAMCODE=B.PROGRAMCODE and A.EXAMCODE=B.EXAMCODE and A.SECTIONBRANCH=B.SECTIONBRANCH ";
	qry=qry+" AND A.SEMESTER=B.SEMESTER and B.SUBJECTID='"+mSUBJECTID+"'  and A.SUBSECTIONTYPE='F' ";
	qry=qry+" and B.subjectid in (select D.subjectid from PR#DEPARTMENTSUBJECTTAGGING D ";
	qry=qry+" where  D.departmentcode ='"+mDept+"'  and D.SECTIONBRANCH=A.SECTIONBRANCH and D.SECTIONBRANCH=B.SECTIONBRANCH) ";
	qry=qry+" order by A.SECTIONBRANCH,seqid,subsectioncode, ";
	qry=qry+"A.ACADEMICYEAR,A.PROGRAMCODE,A.TAGGINGFOR,A.SEMESTER,";
	qry=qry+" A.SEMESTERTYPE";
	}

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


			mMerge=request.getParameter(mNameLML).toString().trim();

			if(mMerge.equals("NONE"))
			{
				mMerge=request.getParameter(mNameLMR).toString().trim();
			}
			mEmp=request.getParameter(mNameL).toString().trim();

			if(mEmp.equals("NONE"))
			{
				mEmp=request.getParameter(mNameR).toString().trim();
			}
			if(!mEmp.equals("NONE"))
			{
				Fstid=db.GenerateFSTID(mINSTITUTECODE);
							
				if(!mMerge.equals("NONE"))
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

			qry1="select employeename from V#STAFF where employeeid='"+mEid+"' ";
			rse=db.getRowset(qry1);
			if (rse.next())
			mEid1=rse.getString("employeename");
		   %>
			<tr>
			<td><%=rs1.getString("SECTIONBRANCH")%></td>
			<td><%=mSubSect%></td>
			<td><%=mEid1%></td>
			<td><font color=green>Saved</font></td>
			</tr>
		   <% 
		//	}		

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


		mMerge=request.getParameter(mNameLML).toString().trim();

		if(mMerge.equals("NONE"))
		{
			mMerge=request.getParameter(mNameLMR).toString().trim();
		}
		mEmp=request.getParameter(mNameL).toString().trim();
		if(mEmp.equals("NONE"))
		{
			mEmp=request.getParameter(mNameR).toString().trim();
		}
		
	if(!mEmp.equals("NONE"))
	{
		if(!mMerge.equals("NONE"))
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
		
		if(!mMerge.equals("NONE"))
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
		qry="update PR#HODLOADDISTRIBUTION set FACULTYTYPE='"+mETyp+"',FACULTYID='"+mEid+"', ";
		qry=qry+"  REQROOMTYPE='"+mroomtype+"', MERGEWITHFSTID='"+mImMergeSec+"' , ";
		qry=qry+"  DURATIONOFCLASS='"+mDuration+"', ";
		qry=qry+"  NOOFCLASSINAWEEK='"+mClass+"' ,ENTRYDATE=sysdate where INSTITUTECODE='"+mINSTITUTECODE+"' and ";
		qry=qry+"  COMPANYCODE='"+mEcmp+"' and EXAMCODE='"+mExamCode+"' and ACADEMICYEAR='"+mAcad+"' ";
		qry=qry+"  and PROGRAMCODE='"+mProg+"' and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mSectBranch+"' ";
		qry=qry+"  and SUBSECTIONCODE='"+mSubSect+"' and SEMESTER='"+mSem+"' and SEMESTERTYPE='"+mSemt+"' ";
		qry=qry+" and BASKET='"+mBasket+"' and SUBJECTID='"+mSUBJECTID+"'  and LTP='"+mLTP+"'  ";
		int n=db.update(qry);
	
		qry1="select employeename from V#STAFF where employeeid='"+mEid+"' ";
		rse=db.getRowset(qry1);

		if (rse.next())
		mEid1=rse.getString("employeename");
	  %>
		<tr>
		<td><%=rs1.getString("SECTIONBRANCH")%></td>
		<td><%=mSubSect%></td>
		<td><%=mEid1%></td>
		<td>Modified</td>
		</tr>
		<%
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
  db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"Pre Reg. Load Distribution ", "ExamCode:"+mExamCode+" SubjectID:"+mSUBJECTID+"Depatrment Running:"+ mDept, "NO MAC Address" , mIPAddress);
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


