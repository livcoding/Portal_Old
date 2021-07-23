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
<TITLE>#### <%=mHead%> [ HOD Advance Load Distribution ] </TITLE>
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
	' 
*************************************************************************************************
	' *												
	' * File Name:	PRLoadDistributionByHODSaveAction.jsp		[For HOD Advance Load]					
	' * Author:		Vijay Kumar
	' * Date:		1st May 2009
	' * Version:	1.0
	' * Description:	Pre Registration of Students
*************************************************************************************************
*/
//out.print(((String [])session.getAttribute("MultiCumAddlFaculty"))[0]);
//out.print(((String [])session.getAttribute("MultiCumAddlFaculty"))[1]);

DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
OLTEncryption enc=new OLTEncryption();

ResultSet rs=null,rs1=null,rse=null,rsi=null,rsee=null,rso=null,rso1=null,rsse=null,rsfstid=null,rs123456=null,rs88=null;

String qry="",mWebEmail="",EmpIDType="",qry1="",mSname="",Type="",mltp="";
String mSem="",mSemType="",mProg="",mBranch="",mSect="",mSubSect="",mTag="",mAcad="",mFactType="";
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
String mType="",mSendhod="",mPSS="",duration="";
String mName1="",mName2="",mName3="",mName4="",mName5="",mSubjectType="",mMerge="";
String mName6="",mName7="",mName8="",mName9="",mName10="",moldnew="",mEid1="";
String fstidupdate="", fstidinsert="", id="";
String moldsecbr="";
String mSectBranch="",mFac="";
String mSeccount="",mSubsection="",mSection="",mEname="",mImMergeSec="";
String mAssign1="",mMin1="",mMax1="";
String mEid="",mETyp="",mEcmp="";
String mfrmtime="",mtotime="",mroomtype="",mPrCode="",mOldSubsection="";
String Fstid="", mMainSec="",mMergeSec="",mSub="";
String mChoice="", qryo="", moldPSS="";
String mNameR="", mNameLMR="";
String mComp="", mInst="",mSemt="",mBasket="",mDuration="",mClass="";
String mEmployeeID="",mPc="",mOldsubsect="";
String mSubjectname="",mEmployeename="",mEle="",QryEleCode="",mEmp="",mLTP="";
String mSubj="", mProjSubj="", QrySubjID="", QryExam="", QrySemType="", QryDept="", mDept2="";

float mAssign=0,mAssign11=0,mMin=0,mMax=0,mweightage=0;
int deln1=0, deln2=0, mClassSetVal=0;
int iii=0, ii=0, mTotalRec=0, kk=0, ctrLMR=0, ctr=0, msno=0, ctr1=0, z=0, mpos4=0;
int len=0,pos1=0,pos2=0,pos3=0,pos4=0,pos5=0,pos6=0, mTotGlFac=0;
int mFlag=0, mTotal=0, mDurationi=0, mClassi=0, mTotalassign=0, mlen=0,mpos1=0 ,mpos2=0,mpos3=0;

if (session.getAttribute("CompanyCode")==null)
	mComp="";
else
	mComp=session.getAttribute("CompanyCode").toString().trim();

if (session.getAttribute("WebAdminEmail")==null)
	 mWebEmail="";
else
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();

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

if (session.getAttribute("TotalInGlobalMultiFac")==null)
	mTotGlFac=0;
else
	mTotGlFac=Integer.parseInt(session.getAttribute("TotalInGlobalMultiFac").toString().trim());
try 
{ //1
	if(!mMemberID.equals("") && !mMemberType.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
	{ //2
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

			qry="SELECT PREVENTCODE FROM PREVENTMASTER A WHERE INSTITUTECODE='"+ mInst+"' AND EXAMCODE='"+QryExam+"' AND NVL(DEACTIVE,'N')='N' AND NVL(PRCOMPLETED,'N')='N' AND NVL(PRREQUIREDFOR,'E')='E'";
			//out.println(qry);
			ResultSet rdddd= db.getRowset(qry);
			if(rdddd.next())
			{
				mPrCode=rdddd.getString("PREVENTCODE");
				//out.println(mPrCode);
			}

			if (request.getParameter("TotalRec")!=null && Integer.parseInt(request.getParameter("TotalRec").toString().trim())>0)
			{ //3

				mTotalRec =Integer.parseInt(request.getParameter("TotalRec").toString().trim());

				if (request.getParameter("SUBJECTID")==null)
					QrySubjID="";
				else
					QrySubjID=request.getParameter("SUBJECTID").toString().trim();

				if (request.getParameter("DURATION")==null)
					mDuration="";
				else
					mDuration=request.getParameter("DURATION").toString().trim();

				if (request.getParameter("NOOFCLASS")==null)
					mClass="";
				else
					mClass=request.getParameter("NOOFCLASS").toString().trim();

				if (request.getParameter("NOOFCLASS")==null)
					mClassSetVal=0;
				else
					mClassSetVal=Integer.parseInt(request.getParameter("NOOFCLASS").toString().trim());

				if (request.getParameter("TYPE")==null)
					mType="";
				else
					mType=request.getParameter("TYPE").toString().trim();

				if (request.getParameter("EXAM")==null)
					QryExam="";
				else
					QryExam=request.getParameter("EXAM").toString().trim();

				if (request.getParameter("INSTITUTE")==null)
					mInst="";
				else
					mInst=request.getParameter("INSTITUTE").toString().trim();

				if (request.getParameter("LTP")==null)
					mLTP="";
				else
					mLTP=request.getParameter("LTP").toString().trim();

				if (request.getParameter("RunningDept")==null)
					QryDept="";
				else
					QryDept=request.getParameter("RunningDept").toString().trim();

				if (request.getParameter("SUBJECT")==null)
					mSubj="";
				else
					mSubj=request.getParameter("SUBJECT").toString().trim();
	
				if (request.getParameter("BASKET")==null)
					mBasket="";
				else
					mBasket=request.getParameter("BASKET").toString().trim();

				if (request.getParameter("ELECTIVECODE")==null || request.getParameter("ELECTIVECODE").equals("null"))
					QryEleCode="";
				else
					QryEleCode=request.getParameter("ELECTIVECODE").toString().trim();
	
				if (request.getParameter("PROJSUBJ")==null)
					mProjSubj="N";
				else
					mProjSubj=request.getParameter("PROJSUBJ").toString().trim();

				//out.println(mSubj);

				if (request.getParameter("ELE")==null)
					mEle="";
				else
					mEle=request.getParameter("ELE").toString().trim();

				if (request.getParameter("BASKET")==null)
					mBasket="";
				else
					mBasket=request.getParameter("BASKET").toString().trim();

				if (request.getParameter("SEMTYPE")==null)
					QrySemType="";
				else
					QrySemType=request.getParameter("SEMTYPE").toString().trim();

				mDurationi=Integer.parseInt(mDuration);
				mClassi=Integer.parseInt(mClass);
				mTotal=mDurationi*mClassi;

				if(mType.equals("C"))
				 Type="Core";
				else if(mType.equals("E"))
				 Type="Elective";
				else
				 Type="Free Elective";

				if(mLTP.equals("L"))
				 mltp="Lecture";
				else if(mLTP.equals("T"))
				 mltp="Tutorial";
				else
				 mltp="Practical";

				%>
				<table id=id1 width="100%" ALIGN=CENTER bottommargin=0 topmargin=0>
				<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Load Distribution Status<B></TD>
				</font></td></tr>
				</TABLE>
				<table id=idd2 cellpadding=1 cellspacing=0 width="100%" align=center rules=rows border=3>
				<tr><td align=center colspan=3>
				<%
				qry="select subject from subjectmaster where INSTITUTECODE='"+mInst+"' AND SUBJECTID='"+QrySubjID+"' ";
				rs=db.getRowset(qry);
				if(rs.next())
					mSname=rs.getString(1);		

				mSname=gb.toTtitleCase(mSname);

				String mProject="";
				if(mProjSubj.equals("Y"))
					mProject=" <FONT COLOR=NAVY><B>[Project Subject]</B></FONT>";
				%>
				<font face=arial color=navy size=2><b>HOD Load Distribution of Subject : </b>&nbsp;<font face=arial color=navy size=2><%=mSname%></font>&nbsp;(<%=mSubj%>) - <%=Type%> &nbsp; &nbsp; &nbsp; &nbsp;<font face=arial color=black size=2><b>LTP : </b></Font>&nbsp;<%=mltp%></Font> <%=mProject%> &nbsp; &nbsp;
				</td></tr>

				<tr><td align=left nowrap>&nbsp; &nbsp; 
				<font face=arial color=black size=2><b>Running Department : </b></font><select name=DEPT id=DEPT style="background-color:#C6D6FD; color:black; font-weight:normal">
				<%
				String qryu="select Department from departmentmaster where departmentcode='"+QryDept+"' and nvl(deactive,'N')='N'";
				ResultSet rssss= db.getRowset(qryu);
				if(rssss.next())
					mDept2=rssss.getString("Department");
				%>
				<option selected name="RunningDept" value='<%=QryDept%>'><%=mDept2%> (<%=QryDept%>)</option>
				</select>

				&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
				<font face=arial color=black size=2><b>Exam Code : </b></Font><select name=EXAM id=EXAM style="background-color:#C6D6FD; color:black; font-weight:normal">
				<option selected value='<%=QryExam%>'><%=QryExam%></option>
				</select>
				&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
				<font face=arial color=black size=2><b>Semester Type : </b></Font><select name=SEM id=SEM style="background-color:#C6D6FD; color:black; font-weight:normal">
				<option selected value='<%=QrySemType%>'><%=QrySemType%></option>
				</select>
				</td></tr>

				<tr><td align=left nowrap>&nbsp; &nbsp; 
				<font face=arial color=black size=2><b>Class Duration : </b></Font>
				<input readonly type=text name=Dura id=Dura value='<%=mDuration%>' style="background-color:#C6D6FD; color:black; font-weight:normal; text-align:right" maxlength=3 size=1>hrs
				 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
				 <font face=arial color=black size=2><b>No. of Class in a Week : </b><input readonly type=text name=Class1 id=Class1 value='<%=mClass%>' style="background-color:#C6D6FD; color:black; font-weight:normal; text-align:right" maxlength=3 size=1>
				 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
				</td><tr>
				</table>

				<TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="100%" border=1 rules=groups>
				<thead>
				<tr bgcolor="#C6D6FD">
				<td align=middle nowrap><b><font color=black face=arial size=2>Acad.<BR>Year</font><b></td>
				<td align=middle nowrap><b><font color=black face=arial size=2>Prog.<BR>Code</font><b></td>
				<td align=middle><b><font color=black face=arial size=2>Section</font><b></td>
				<td align=middle><b><font color=black face=arial size=2>SubSection</font><b></td>
				<td align=middle><b><font color=black face=arial size=2>Employee Name</font><b></td>
				<td align=middle nowrap><b><font color=black face=arial size=2>No. of <BR>Class per Week</font><b></td>
				<td align=middle><b><font color=black face=arial size=2>Set <BR>Assigned</font><b></td>
				<td align=middle><b><font color=black face=arial size=2>Status</font><b></td>
				</tr>
				</thead>
				<tbody>
				<%
				//ccc
				if(mType.equals("C"))
				{
					qry="SELECT DISTINCT b.subsectioncode subsectioncode, a.academicyear academicyear, a.programcode, a.taggingfor,a.sectionbranch sectionbranch,";
					qry+=" a.semester, a.semestertype,to_char((SELECT COUNT (*) FROM programsubsectiontagging cc  ";
					qry+=" WHERE cc.institutecode = '"+mInst+"' AND cc.examcode = '"+QryExam+"' AND B.SUBSECTIONCODE IS NOT NULL";
					qry+=" AND cc.semestertype =DECODE ('"+QrySemType+"','ALL', cc.semestertype,'"+QrySemType+"') AND NVL (cc.deactive, 'N') = 'N' ";
					qry+=" AND cc.academicyear = a.academicyear AND cc.programcode = a.programcode AND cc.sectionbranch = a.sectionbranch AND cc.semester = a.semester AND cc.subsectiontype = 'C'";
					qry+=" AND cc.academicyear = b.academicyear AND cc.programcode = b.programcode AND cc.semester = b.semester AND cc.sectionbranch = b.sectionbranch";
					qry+=" AND cc.academicyear = c.academicyear AND cc.programcode = c.programcode AND cc.semester = c.semester AND cc.sectionbranch = c.sectionbranch ))cnt";
					qry+=" FROM programsubsectiontagging a, pr#STUDENTSUBJECTCHOICE b  ,ProgramSubjecttagging c WHERE a.institutecode = '"+mInst+"' AND a.institutecode = b.institutecode AND b.institutecode = c.institutecode AND c.institutecode = a.institutecode";
					qry+=" AND a.examcode = c.examcode AND a.examcode = b.examcode AND b.subjecttype = 'C' AND a.examcode = '"+QryExam+"' ";
					qry+=" AND a.semestertype = DECODE ('"+QrySemType+"', 'ALL', a.semestertype, '"+QrySemType+"') AND NVL (a.deactive, 'N') = 'N' ";
					qry+=" AND a.academicyear = b.academicyear AND a.programcode = b.programcode AND a.sectionbranch = b.sectionbranch  ";
					qry+=" and a.academicyear=c.ACADEMICYEAR and a.programcode=c.programcode and b.SECTIONBRANCH=c.SECTIONBRANCH AND b.TAGGINGFOR=c.TAGGINGFOR ";
					qry+=" AND a.semester = b.semester and a.semester = c.semester and a.taggingfor=c.taggingfor and a.SECTIONBRANCH=c.SECTIONBRANCH And B.SubjectID = C.SubjectID ";
					qry+=" AND b.subjectid = '"+QrySubjID+"' AND C.BASKET='"+mBasket+"' AND a.subsectiontype = 'C'  AND B.SUBSECTIONCODE IS NOT NULL";
					qry+=" AND a.semestertype =  b.semestertype AND nvl(b.subjectrunning,'N')='Y'  ";
					qry+=" AND b.subjectid IN (SELECT d.subjectid FROM pr#departmentsubjecttagging d WHERE d.departmentcode = '"+QryDept+"' ";
					qry+=" AND d.sectionbranch = a.sectionbranch AND d.sectionbranch = b.sectionbranch)";
					qry+=" UNION ";
					qry+=" SELECT DISTINCT A.subsectioncode subsectioncode, a.academicyear academicyear, a.programcode, a.taggingfor,a.sectionbranch sectionbranch,";
					qry+=" a.semester, a.semestertype,to_char((SELECT COUNT (*) FROM programsubsectiontagging c  ";
					qry+=" WHERE c.institutecode = '"+mInst+"' AND c.examcode = '"+QryExam+"' AND A.SUBSECTIONCODE IS NOT NULL";
					qry+=" AND c.semestertype =DECODE ('"+QrySemType+"','ALL', c.semestertype,'"+QrySemType+"') AND NVL (c.deactive, 'N') = 'N' ";
					qry+=" AND c.academicyear = a.academicyear AND c.programcode = a.programcode AND c.sectionbranch = a.sectionbranch ";
					qry+=" AND c.semester = a.semester AND c.institutecode = b.institutecode AND c.academicyear = b.academicyear AND c.subsectiontype = 'C')) cnt ";
					qry+=" FROM programsubsectiontagging a, academicyearmaster b, ProgramSubjecttagging c WHERE a.institutecode = '"+mInst+"' AND a.institutecode = b.institutecode AND b.institutecode = c.institutecode AND c.institutecode = a.institutecode";
					qry+=" AND a.examcode = c.examcode AND c.basket = 'A' AND a.examcode = '"+QryExam+"' AND a.semestertype = DECODE ('"+QrySemType+"', 'ALL', a.semestertype, '"+QrySemType+"') AND NVL (a.deactive, 'N') = 'N' ";
					qry+=" AND a.academicyear = b.academicyear AND a.academicyear = c.academicyear AND a.programcode = c.programcode AND a.Semester = c.Semester and a.taggingfor=c.taggingfor and a.SECTIONBRANCH=c.SECTIONBRANCH and a.subsectiontype='C' AND NVL (b.currentyear, 'N') = 'Y'";
					qry+=" AND c.subjectid IN (SELECT d.subjectid FROM pr#departmentsubjecttagging d WHERE d.departmentcode='"+QryDept+"' AND d.sectionbranch = a.sectionbranch AND d.sectionbranch = a.sectionbranch)";
					qry+=" AND c.subjectid='"+QrySubjID+"' AND C.BASKET='"+mBasket+"' ";
					qry+=" AND A.INSTITUTECODE='"+mInst+"' and A.INSTITUTECODE=b.Institutecode and c.INSTITUTECODE=b.Institutecode";
					qry+=" ORDER BY SECTIONBRANCH,ACADEMICYEAR,subsectioncode,PROGRAMCODE,TAGGINGFOR,SEMESTER,SEMESTERTYPE";
				}
				else if(mType.equals("E"))
				{
					qry="	select distinct A.SUBSECTIONCODE subsectioncode, a.academicyear academicyear, A.PROGRAMCODE,A.TAGGINGFOR,A.SECTIONBRANCH SECTIONBRANCH,";
					qry+=" a.semester, a.semestertype,to_char((SELECT COUNT (*) FROM programsubsectiontagging cc  ";
					qry+=" WHERE cc.institutecode = '"+mInst+"' AND cc.examcode = '"+QryExam+"' ";//AND B.SUBSECTIONCODE IS NOT NULL";
					qry+=" AND cc.semestertype =DECODE ('"+QrySemType+"','ALL', cc.semestertype,'"+QrySemType+"') AND NVL (cc.deactive, 'N') = 'N' ";
					qry+=" AND cc.academicyear = a.academicyear AND cc.programcode = a.programcode AND cc.sectionbranch = a.sectionbranch AND cc.semester = a.semester AND cc.subsectiontype = 'C'";
					qry+=" AND cc.academicyear = b.academicyear AND cc.programcode = b.programcode AND cc.semester = b.semester AND cc.sectionbranch = b.sectionbranch ))cnt";
					qry+=" from PROGRAMSUBSECTIONTAGGING A, PR#ELECTIVESUBJECTS B where B.SUBJECTRUNNING='Y' and exists (SELECT 1 FROM pr#studentsubjectchoice C WHERE C.institutecode='"+mInst+"' AND C.EXAMCODE= '"+QryExam+"' AND c.semestertype = decode('"+QrySemType+"','ALL',C.semestertype,'"+QrySemType+"') AND NVL (c.deactive, 'N') = 'N' AND c.academicyear = a.academicyear AND c.programcode = a.programcode AND c.sectionbranch = a.sectionbranch AND c.semester = a.semester AND a.sectionbranch = b.sectionbranch AND c.subjectid = b.subjectid AND c.subjecttype = 'E') AND A.institutecode='"+mInst+"' and B.ELECTIVECODE='"+QryEleCode+"' AND A.examcode='"+QryExam+"' and ";
					qry+=" A.semestertype=decode('"+QrySemType+"','ALL',A.semestertype,'"+QrySemType+"') and nvl(A.deactive,'N')='N' and ";
					qry+=" A.ACADEMICYEAR=B.ACADEMICYEAR and A.PROGRAMCODE=B.PROGRAMCODE and A.EXAMCODE=B.EXAMCODE and A.SECTIONBRANCH=B.SECTIONBRANCH ";
					qry+=" AND A.SEMESTER=B.SEMESTER and B.SUBJECTID='"+QrySubjID+"' AND B.BASKET='"+mBasket+"' and A.SUBSECTIONTYPE='C' AND A.SUBSECTIONCODE IS NOT NULL";
					qry+=" and B.subjectid in (select D.subjectid from PR#DEPARTMENTSUBJECTTAGGING D ";
					qry+=" where  D.departmentcode ='"+QryDept+"'  and D.SECTIONBRANCH=A.SECTIONBRANCH and D.SECTIONBRANCH=B.SECTIONBRANCH) ";
					//qry+=" order by A.SECTIONBRANCH, A.ACADEMICYEAR, subsectioncode, A.PROGRAMCODE, A.TAGGINGFOR, A.SEMESTER, A.SEMESTERTYPE";
					qry+=" UNION ";
					qry+=" SELECT DISTINCT A.subsectioncode subsectioncode, a.academicyear academicyear, a.programcode, a.taggingfor,a.sectionbranch sectionbranch,";
					qry+=" a.semester, a.semestertype,to_char((SELECT COUNT (*) FROM programsubsectiontagging c  ";
					qry+=" WHERE c.institutecode = '"+mInst+"' AND c.examcode = '"+QryExam+"' AND A.SUBSECTIONCODE IS NOT NULL";
					qry+=" AND c.semestertype =DECODE ('"+QrySemType+"','ALL', c.semestertype,'"+QrySemType+"') AND NVL (c.deactive, 'N') = 'N' ";
					qry+=" AND c.academicyear = a.academicyear AND c.programcode = a.programcode AND c.sectionbranch = a.sectionbranch ";
					qry+=" AND c.semester = a.semester AND c.institutecode = b.institutecode AND c.academicyear = b.academicyear AND c.subsectiontype = 'C')) cnt ";
					qry+=" FROM programsubsectiontagging a, academicyearmaster b, pr#electivesubjects c WHERE a.institutecode = '"+mInst+"' AND a.institutecode = b.institutecode AND b.institutecode = c.institutecode AND c.institutecode = a.institutecode";
					qry+=" AND a.examcode = c.examcode  AND a.examcode = '"+QryExam+"' AND a.semestertype = DECODE ('"+QrySemType+"', 'ALL', a.semestertype, '"+QrySemType+"') AND NVL (a.deactive, 'N') = 'N' ";
					qry+=" AND a.academicyear = b.academicyear AND a.academicyear = c.academicyear AND a.programcode = c.programcode AND a.Semester = c.Semester and a.taggingfor=c.taggingfor and a.SECTIONBRANCH=c.SECTIONBRANCH and a.subsectiontype='C' AND NVL (b.currentyear, 'N') = 'Y'";
					qry+=" AND c.subjectid IN (SELECT d.subjectid FROM pr#departmentsubjecttagging d WHERE d.departmentcode='"+QryDept+"' AND d.sectionbranch = a.sectionbranch AND d.sectionbranch = a.sectionbranch)";
					qry+=" AND c.subjectid='"+QrySubjID+"' AND C.BASKET='"+mBasket+"' ";
					qry+=" ORDER BY SECTIONBRANCH,ACADEMICYEAR,subsectioncode,PROGRAMCODE,TAGGINGFOR,SEMESTER,SEMESTERTYPE";
					//out.print(qry);
				}
				rs1=db.getRowset(qry);
				//out.print(qry);
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

ctrLMR=ctr-1;

					mNameR=mSection+"***R///"+String.valueOf(ctr).trim()+"###"+mSeccount ; 
					//mNameLMR=mSection+"***R///"+String.valueOf(ctrLMR).trim()+"###"+mSeccount+"merge"; 
					mNameLMR=mSection+"***R///"+String.valueOf(ctr).trim()+"###"+mSeccount+"merge"; 
					mMerge=request.getParameter(mNameLMR);

					if(mMerge!=null && !mMerge.equals("NONE"))
					{
						mMerge=request.getParameter(mNameLMR);
					}
					else
					{
						mMerge="";
					}
			
					mEmp=request.getParameter(mNameR);
					if(mEmp!=null && !mEmp.equals("NONE"))
					{//out.print(request.getParameter(mNameR).toString().trim()+"<br>"+mNameR+"<br>");

						mEmp=request.getParameter(mNameR).toString().trim();
					}
					else
					{
						mEmp="";
					}
					//out.print("EMP - "+mEmp);
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
						//out.println(mfound+" adfsdafasdfasdfsdafasd "+x);
						if(mfound==0 || x==0)
						{
							mChkFac[x]=mEid;
							x++;
							if(mType.equals("C"))
							{
								qry1="SELECT DISTINCT b.subsectioncode subsectioncode, a.academicyear academicyear, a.programcode, a.taggingfor,a.sectionbranch sectionbranch,";
								qry1+=" a.semester, a.semestertype,to_char((SELECT COUNT (*) FROM programsubsectiontagging cc  ";
								qry1+=" WHERE cc.institutecode = '"+mInst+"' AND cc.examcode = '"+QryExam+"' AND B.SUBSECTIONCODE IS NOT NULL";
								qry1+=" AND cc.semestertype =DECODE ('"+QrySemType+"','ALL', cc.semestertype,'"+QrySemType+"') AND NVL (cc.deactive, 'N') = 'N' ";
								qry1+=" AND cc.academicyear = a.academicyear AND cc.programcode = a.programcode AND cc.sectionbranch = a.sectionbranch AND cc.semester = a.semester AND cc.subsectiontype = 'C'";
								qry1+=" AND cc.academicyear = b.academicyear AND cc.programcode = b.programcode AND cc.semester = b.semester AND cc.sectionbranch = b.sectionbranch";
								qry1+=" AND cc.academicyear = c.academicyear AND cc.programcode = c.programcode AND cc.semester = c.semester AND cc.sectionbranch = c.sectionbranch ))cnt";
								qry1+=" FROM programsubsectiontagging a, pr#STUDENTSUBJECTCHOICE b  ,ProgramSubjecttagging c WHERE a.institutecode = '"+mInst+"' AND a.institutecode = b.institutecode AND b.institutecode = c.institutecode AND c.institutecode = a.institutecode";
								qry1+=" AND a.examcode = c.examcode AND a.examcode = b.examcode AND b.subjecttype = 'C' AND a.examcode = '"+QryExam+"' ";
								qry1+=" AND a.semestertype = DECODE ('"+QrySemType+"', 'ALL', a.semestertype, '"+QrySemType+"') AND NVL (a.deactive, 'N') = 'N' ";
								qry1+=" AND a.academicyear = b.academicyear AND a.programcode = b.programcode AND a.sectionbranch = b.sectionbranch  ";
								qry1+=" and a.academicyear=c.ACADEMICYEAR and a.programcode=c.programcode and b.SECTIONBRANCH=c.SECTIONBRANCH AND b.TAGGINGFOR=c.TAGGINGFOR ";
								qry1+=" AND a.semester = b.semester and a.semester = c.semester and a.taggingfor=c.taggingfor and a.SECTIONBRANCH=c.SECTIONBRANCH And B.SubjectID = C.SubjectID ";
								qry1+=" AND b.subjectid = '"+QrySubjID+"' AND C.BASKET='"+mBasket+"' AND a.subsectiontype = 'C'  AND B.SUBSECTIONCODE IS NOT NULL";
								qry1+=" AND a.semestertype =  b.semestertype AND nvl(b.subjectrunning,'N')='Y'  ";
								qry1+=" AND b.subjectid IN (SELECT d.subjectid FROM pr#departmentsubjecttagging d WHERE d.departmentcode = '"+QryDept+"' ";
								qry1+=" AND d.sectionbranch = a.sectionbranch AND d.sectionbranch = b.sectionbranch)";
								qry1+=" UNION ";
								qry1+=" SELECT DISTINCT A.subsectioncode subsectioncode, a.academicyear academicyear, a.programcode, a.taggingfor,a.sectionbranch sectionbranch,";
								qry1+=" a.semester, a.semestertype,to_char((SELECT COUNT (*) FROM programsubsectiontagging c  ";
								qry1+=" WHERE c.institutecode = '"+mInst+"' AND c.examcode = '"+QryExam+"' AND A.SUBSECTIONCODE IS NOT NULL";
								qry1+=" AND c.semestertype =DECODE ('"+QrySemType+"','ALL', c.semestertype,'"+QrySemType+"') AND NVL (c.deactive, 'N') = 'N' ";
								qry1+=" AND c.academicyear = a.academicyear AND c.programcode = a.programcode AND c.sectionbranch = a.sectionbranch ";
								qry1+=" AND c.semester = a.semester AND c.institutecode = b.institutecode AND c.academicyear = b.academicyear AND c.subsectiontype = 'C')) cnt ";
								qry1+=" FROM programsubsectiontagging a, academicyearmaster b, ProgramSubjecttagging c WHERE a.institutecode = '"+mInst+"' AND a.institutecode = b.institutecode AND b.institutecode = c.institutecode AND c.institutecode = a.institutecode";
								qry1+=" AND a.examcode = c.examcode AND c.basket = 'A' AND a.examcode = '"+QryExam+"' AND a.semestertype = DECODE ('"+QrySemType+"', 'ALL', a.semestertype, '"+QrySemType+"') AND NVL (a.deactive, 'N') = 'N' ";
								qry1+=" AND a.academicyear = b.academicyear AND a.academicyear = c.academicyear AND a.programcode = c.programcode AND a.Semester = c.Semester and a.taggingfor=c.taggingfor and a.SECTIONBRANCH=c.SECTIONBRANCH and a.subsectiontype='C' AND NVL (b.currentyear, 'N') = 'Y'";
								qry1+=" AND c.subjectid IN (SELECT d.subjectid FROM pr#departmentsubjecttagging d WHERE d.departmentcode='"+QryDept+"' AND d.sectionbranch = a.sectionbranch AND d.sectionbranch = a.sectionbranch)";
								qry1+=" AND c.subjectid='"+QrySubjID+"' AND C.BASKET='"+mBasket+"'";
								qry1+=" AND A.INSTITUTECODE='"+mInst+"' and A.INSTITUTECODE=b.Institutecode and c.INSTITUTECODE=b.Institutecode";
								qry1+=" ORDER BY SECTIONBRANCH,ACADEMICYEAR,subsectioncode,PROGRAMCODE,TAGGINGFOR,SEMESTER,SEMESTERTYPE";
								//out.print("ddddddddddddddddddd");
							}
							else if(mType.equals("E"))
							{
								///out.print("ddddddddddddddddddd123");
//---------
								qry1=" select distinct A.SUBSECTIONCODE subsectioncode, a.academicyear academicyear, A.PROGRAMCODE,A.TAGGINGFOR,A.SECTIONBRANCH SECTIONBRANCH,";
								qry1+=" a.semester, a.semestertype,to_char((SELECT COUNT (*) FROM programsubsectiontagging cc  ";
								qry1+=" WHERE cc.institutecode = '"+mInst+"' AND cc.examcode = '"+QryExam+"' ";//AND B.SUBSECTIONCODE IS NOT NULL";
								qry1+=" AND cc.semestertype =DECODE ('"+QrySemType+"','ALL', cc.semestertype,'"+QrySemType+"') AND NVL (cc.deactive, 'N') = 'N' ";
								qry1+=" AND cc.academicyear = a.academicyear AND cc.programcode = a.programcode AND cc.sectionbranch = a.sectionbranch AND cc.semester = a.semester AND cc.subsectiontype = 'C'";
								qry1+=" AND cc.academicyear = b.academicyear AND cc.programcode = b.programcode AND cc.semester = b.semester AND cc.sectionbranch = b.sectionbranch ))cnt";
								qry1+=" from PROGRAMSUBSECTIONTAGGING A, PR#ELECTIVESUBJECTS B where B.SUBJECTRUNNING='Y' and exists (SELECT 1 FROM pr#studentsubjectchoice C WHERE C.institutecode='"+mInst+"' AND C.EXAMCODE= '"+QryExam+"' AND c.semestertype = decode('"+QrySemType+"','ALL',C.semestertype,'"+QrySemType+"') AND NVL (c.deactive, 'N') = 'N' AND c.academicyear = a.academicyear AND c.programcode = a.programcode AND c.sectionbranch = a.sectionbranch AND c.semester = a.semester AND a.sectionbranch = b.sectionbranch AND c.subjectid = b.subjectid AND c.subjecttype = 'E') AND A.institutecode='"+mInst+"' and B.ELECTIVECODE='"+QryEleCode+"' AND A.examcode='"+QryExam+"' and ";
//----------
								qry1+=" A.semestertype=decode('"+QrySemType+"','ALL',A.semestertype,'"+QrySemType+"') and nvl(A.deactive,'N')='N' and ";
								qry1+=" A.ACADEMICYEAR=B.ACADEMICYEAR and A.PROGRAMCODE=B.PROGRAMCODE and A.EXAMCODE=B.EXAMCODE and A.SECTIONBRANCH=B.SECTIONBRANCH ";
								qry1+=" AND A.SEMESTER=B.SEMESTER and B.SUBJECTID='"+QrySubjID+"' AND B.BASKET='"+mBasket+"' and A.SUBSECTIONTYPE='C' AND A.SUBSECTIONCODE IS NOT NULL";
								qry1+=" and B.subjectid in (select D.subjectid from PR#DEPARTMENTSUBJECTTAGGING D ";
								qry1+=" where  D.departmentcode ='"+QryDept+"'  and D.SECTIONBRANCH=A.SECTIONBRANCH and D.SECTIONBRANCH=B.SECTIONBRANCH) ";
								//qry1+=" order by A.SECTIONBRANCH, A.ACADEMICYEAR, subsectioncode, A.PROGRAMCODE, A.TAGGINGFOR, A.SEMESTER, A.SEMESTERTYPE";
								qry1+=" UNION ";
								qry1+=" SELECT DISTINCT A.subsectioncode subsectioncode, a.academicyear academicyear, a.programcode, a.taggingfor,a.sectionbranch sectionbranch,";
								qry1+=" a.semester, a.semestertype,to_char((SELECT COUNT (*) FROM programsubsectiontagging c  ";
								qry1+=" WHERE c.institutecode = '"+mInst+"' AND c.examcode = '"+QryExam+"' AND A.SUBSECTIONCODE IS NOT NULL";
								qry1+=" AND c.semestertype =DECODE ('"+QrySemType+"','ALL', c.semestertype,'"+QrySemType+"') AND NVL (c.deactive, 'N') = 'N' ";
								qry1+=" AND c.academicyear = a.academicyear AND c.programcode = a.programcode AND c.sectionbranch = a.sectionbranch ";
								qry1+=" AND c.semester = a.semester AND c.institutecode = b.institutecode AND c.academicyear = b.academicyear AND c.subsectiontype = 'C')) cnt ";
								qry1+=" FROM programsubsectiontagging a, academicyearmaster b, pr#electivesubjects c WHERE a.institutecode = '"+mInst+"' AND a.institutecode = b.institutecode AND b.institutecode = c.institutecode AND c.institutecode = a.institutecode";
								qry1+=" AND a.examcode = c.examcode  AND a.examcode = '"+QryExam+"' AND a.semestertype = DECODE ('"+QrySemType+"', 'ALL', a.semestertype, '"+QrySemType+"') AND NVL (a.deactive, 'N') = 'N' ";
								qry1+=" AND a.academicyear = b.academicyear AND a.academicyear = c.academicyear AND a.programcode = c.programcode AND a.Semester = c.Semester and a.taggingfor=c.taggingfor and a.SECTIONBRANCH=c.SECTIONBRANCH and a.subsectiontype='C' AND NVL (b.currentyear, 'N') = 'Y'";
								qry1+=" AND c.subjectid IN (SELECT d.subjectid FROM pr#departmentsubjecttagging d WHERE d.departmentcode='"+QryDept+"' AND d.sectionbranch = a.sectionbranch AND d.sectionbranch = a.sectionbranch)";
								qry1+=" AND c.subjectid='"+QrySubjID+"' AND C.BASKET='"+mBasket+"'";
								qry1+=" AND A.INSTITUTECODE='"+mInst+"' and A.INSTITUTECODE=b.Institutecode and c.INSTITUTECODE=b.Institutecode";
								qry1+=" ORDER BY SECTIONBRANCH,ACADEMICYEAR,subsectioncode,PROGRAMCODE,TAGGINGFOR,SEMESTER,SEMESTERTYPE";
							}
							//out.print(qry1);
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
			 
								mNameR=mSection1+"***R///"+String.valueOf(ctr1).trim()+"###"+mSeccount ; 
							//	out.print(mNameR+"<br>");
								//mNameLMR=mSection1+"***R///"+String.valueOf(ctr1).trim()+"###"+mSeccount+"merge"; 
								mNameLMR=mSection1+"***R///"+String.valueOf(ctr1).trim()+"###"+mSeccount+"merge"; 

								mMerge=request.getParameter(mNameLMR);

								if(mMerge!=null && !mMerge.equals("NONE"))
								{
									mMerge=request.getParameter(mNameLMR).toString().trim();
								}
								else
								{
									mMerge="";
								}
	
								mEmp=request.getParameter(mNameR);
		
								if(mEmp!=null && !mEmp.equals("NONE"))
								{
									mEmp=request.getParameter(mNameR).toString().trim();
							//	out.print(mNameR+"<br>");
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
						//out.print(mMax1+"**************************"+"<br>");
						//out.print(mEmp.substring(pos1+3,pos4)+"<br>");
									mMin=Float.parseFloat(mMin1);
									mMax=Float.parseFloat(mMax1);

									mAcad=rsi.getString("ACADEMICYEAR");
									mProg=rsi.getString("PROGRAMCODE");
									mTag=rsi.getString("TAGGINGFOR");
									mSectBranch=rsi.getString("SECTIONBRANCH");
									mSubSect=rsi.getString("SUBSECTIONCODE");
									mSem=rsi.getString("SEMESTER");
									mSemt=rsi.getString("SEMESTERTYPE");

									qry="select A.FACULTYID FACULTYID from PR#HODLOADDISTRIBUTION A where A.institutecode='"+mInst+"' ";
									qry+=" and A.examcode='"+QryExam+"' and A.SUBJECTID='"+QrySubjID+"' and A.LTP='"+mLTP+"' ";
									qry+=" and A.SECTIONBRANCH='"+mSectBranch+"' and A.subsectioncode='"+mSubSect+"' and nvl(A.deactive,'N')='N' ";		
									qry+=" and A.semestertype='"+mSemt+"' and A.FACULTYTYPE='"+mETyp+"' and A.ACADEMICYEAR='"+mAcad+"' ";
									qry+=" and A.PROGRAMCODE in ('"+mProg+"') and A.TAGGINGFOR='"+mTag+"' and A.SEMESTER='"+mSem+"' ";
									qry+=" and A.FACULTYID='"+mFac+"' ";
									//out.println(qry);
									rso=db.getRowset(qry);
									if(rso.next())
									{
										mAssign11=0;
									}
									else
									{
										mAssign11=mAssign;

										//!mOldsectionbranch.equals(rsi.getString("SECTIONBRANCH"))					
										if(mEid.equals(mFac) && mMerge.equals("NONE") && !mOldsubsect.equals(rsi.getString("SUBSECTIONCODE")) )
										{
											mweightage=mweightage+mTotal;
											mOldsubsect=rsi.getString("SUBSECTIONCODE");
										}
										if((mweightage+mAssign11)>mMax)
										{//out.print("Gyan"+mweightage+"###"+mAssign11+"@@@@"+mMax);
											mFlag=1;
											break;
										}
									 } // closing of else	
								} // closing of if if(!mEmp.equals("NONE"))
							} // closing of inner while(rsi)
						} // closing of mfound==0
						if(mFlag==1)
						{
							break;
						}
					} // closing of if if(!mEmp.equals("NONE"))
				} //closing of outer while(rs1).....
				//out.println("hello");
				/*if(mFlag==1)
				{
					qry="Select employeename from V#STAFF where employeeid='"+mFac+"' and COMPANYCODE='"+mEcmp+"'";
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
				{*/
					msno=0;
					ctr=0;
					if(mType.equals("C"))
					{
						qry="SELECT DISTINCT b.subsectioncode subsectioncode, a.academicyear academicyear, a.programcode, a.taggingfor,a.sectionbranch sectionbranch,";
						qry+=" a.semester, a.semestertype,to_char((SELECT COUNT (*) FROM programsubsectiontagging cc  ";
						qry+=" WHERE cc.institutecode = '"+mInst+"' AND cc.examcode = '"+QryExam+"' AND B.SUBSECTIONCODE IS NOT NULL";
						qry+=" AND cc.semestertype =DECODE ('"+QrySemType+"','ALL', cc.semestertype,'"+QrySemType+"') AND NVL (cc.deactive, 'N') = 'N' ";
						qry+=" AND cc.academicyear = a.academicyear AND cc.programcode = a.programcode AND cc.sectionbranch = a.sectionbranch AND cc.semester = a.semester AND cc.subsectiontype = 'C'";
						qry+=" AND cc.academicyear = b.academicyear AND cc.programcode = b.programcode AND cc.semester = b.semester AND cc.sectionbranch = b.sectionbranch";
						qry+=" AND cc.academicyear = c.academicyear AND cc.programcode = c.programcode AND cc.semester = c.semester AND cc.sectionbranch = c.sectionbranch ))cnt";
						qry+=" FROM programsubsectiontagging a, pr#STUDENTSUBJECTCHOICE b  ,ProgramSubjecttagging c WHERE a.institutecode = '"+mInst+"' AND a.institutecode = b.institutecode AND b.institutecode = c.institutecode AND c.institutecode = a.institutecode";
						qry+=" AND a.examcode = c.examcode AND a.examcode = b.examcode AND b.subjecttype = 'C' AND a.examcode = '"+QryExam+"' ";
						qry+=" AND a.semestertype = DECODE ('"+QrySemType+"', 'ALL', a.semestertype, '"+QrySemType+"') AND NVL (a.deactive, 'N') = 'N' ";
						qry+=" AND a.academicyear = b.academicyear AND a.programcode = b.programcode AND a.sectionbranch = b.sectionbranch  ";
						qry+=" and a.academicyear=c.ACADEMICYEAR and a.programcode=c.programcode and b.SECTIONBRANCH=c.SECTIONBRANCH AND b.TAGGINGFOR=c.TAGGINGFOR ";
						qry+=" AND a.semester = b.semester and a.semester = c.semester and a.taggingfor=c.taggingfor and a.SECTIONBRANCH=c.SECTIONBRANCH And B.SubjectID = C.SubjectID ";
						qry+=" AND b.subjectid = '"+QrySubjID+"' AND C.BASKET='"+mBasket+"' AND a.subsectiontype = 'C'  AND B.SUBSECTIONCODE IS NOT NULL";
						qry+=" AND a.semestertype =  b.semestertype AND nvl(b.subjectrunning,'N')='Y'  ";
						qry+=" AND b.subjectid IN (SELECT d.subjectid FROM pr#departmentsubjecttagging d WHERE d.departmentcode = '"+QryDept+"' ";
						qry+=" AND d.sectionbranch = a.sectionbranch AND d.sectionbranch = b.sectionbranch)";
						qry+=" UNION ";
						qry+=" SELECT DISTINCT A.subsectioncode subsectioncode, a.academicyear academicyear, a.programcode, a.taggingfor,a.sectionbranch sectionbranch,";
						qry+=" a.semester, a.semestertype,to_char((SELECT COUNT (*) FROM programsubsectiontagging c  ";
						qry+=" WHERE c.institutecode = '"+mInst+"' AND c.examcode = '"+QryExam+"' AND A.SUBSECTIONCODE IS NOT NULL";
						qry+=" AND c.semestertype =DECODE ('"+QrySemType+"','ALL', c.semestertype,'"+QrySemType+"') AND NVL (c.deactive, 'N') = 'N' ";
						qry+=" AND c.academicyear = a.academicyear AND c.programcode = a.programcode AND c.sectionbranch = a.sectionbranch ";
						qry+=" AND c.semester = a.semester AND c.institutecode = b.institutecode AND c.academicyear = b.academicyear AND c.subsectiontype = 'C')) cnt ";
						qry+=" FROM programsubsectiontagging a, academicyearmaster b, ProgramSubjecttagging c WHERE a.institutecode = '"+mInst+"' AND a.institutecode = b.institutecode AND b.institutecode = c.institutecode AND c.institutecode = a.institutecode";
						qry+=" AND a.examcode = c.examcode AND c.basket = 'A' AND a.examcode = '"+QryExam+"' AND a.semestertype = DECODE ('"+QrySemType+"', 'ALL', a.semestertype, '"+QrySemType+"') AND NVL (a.deactive, 'N') = 'N' ";
						qry+=" AND a.academicyear = b.academicyear AND a.academicyear = c.academicyear AND a.programcode = c.programcode AND a.Semester = c.Semester and a.taggingfor=c.taggingfor and a.SECTIONBRANCH=c.SECTIONBRANCH and a.subsectiontype='C' AND NVL (b.currentyear, 'N') = 'Y'";
						qry+=" AND c.subjectid IN (SELECT d.subjectid FROM pr#departmentsubjecttagging d WHERE d.departmentcode='"+QryDept+"' AND d.sectionbranch = a.sectionbranch AND d.sectionbranch = a.sectionbranch)";
						qry+=" AND c.subjectid='"+QrySubjID+"' AND C.BASKET='"+mBasket+"'";
						qry+=" AND A.INSTITUTECODE='"+mInst+"' and A.INSTITUTECODE=b.Institutecode and c.INSTITUTECODE=b.Institutecode";
						qry+=" ORDER BY SECTIONBRANCH,ACADEMICYEAR,subsectioncode,PROGRAMCODE,TAGGINGFOR,SEMESTER,SEMESTERTYPE";
					}
					else if(mType.equals("E"))
					{
						qry="	select distinct A.SUBSECTIONCODE subsectioncode, a.academicyear academicyear, A.PROGRAMCODE,A.TAGGINGFOR,A.SECTIONBRANCH SECTIONBRANCH,";
						qry+=" a.semester, a.semestertype,to_char((SELECT COUNT (*) FROM programsubsectiontagging cc  ";
						qry+=" WHERE cc.institutecode = '"+mInst+"' AND cc.examcode = '"+QryExam+"' ";//AND B.SUBSECTIONCODE IS NOT NULL";
						qry+=" AND cc.semestertype =DECODE ('"+QrySemType+"','ALL', cc.semestertype,'"+QrySemType+"') AND NVL (cc.deactive, 'N') = 'N' ";
						qry+=" AND cc.academicyear = a.academicyear AND cc.programcode = a.programcode AND cc.sectionbranch = a.sectionbranch AND cc.semester = a.semester AND cc.subsectiontype = 'C'";
						qry+=" AND cc.academicyear = b.academicyear AND cc.programcode = b.programcode AND cc.semester = b.semester AND cc.sectionbranch = b.sectionbranch ))cnt";
						qry+=" from PROGRAMSUBSECTIONTAGGING A, PR#ELECTIVESUBJECTS B where B.SUBJECTRUNNING='Y' and exists (SELECT 1 FROM pr#studentsubjectchoice C WHERE C.institutecode='"+mInst+"' AND C.EXAMCODE= '"+QryExam+"' AND c.semestertype = decode('"+QrySemType+"','ALL',C.semestertype,'"+QrySemType+"') AND NVL (c.deactive, 'N') = 'N' AND c.academicyear = a.academicyear AND c.programcode = a.programcode AND c.sectionbranch = a.sectionbranch AND c.semester = a.semester AND a.sectionbranch = b.sectionbranch AND c.subjectid = b.subjectid AND c.subjecttype = 'E') AND A.institutecode='"+mInst+"' and B.ELECTIVECODE='"+QryEleCode+"' AND A.examcode='"+QryExam+"' and ";
						qry+=" A.semestertype=decode('"+QrySemType+"','ALL',A.semestertype,'"+QrySemType+"') and nvl(A.deactive,'N')='N' and ";
						qry+=" A.ACADEMICYEAR=B.ACADEMICYEAR and A.PROGRAMCODE=B.PROGRAMCODE and A.EXAMCODE=B.EXAMCODE and A.SECTIONBRANCH=B.SECTIONBRANCH ";
						qry+=" AND A.SEMESTER=B.SEMESTER and B.SUBJECTID='"+QrySubjID+"' AND B.BASKET='"+mBasket+"' and A.SUBSECTIONTYPE='C' AND A.SUBSECTIONCODE IS NOT NULL";
						qry+=" and B.subjectid in (select D.subjectid from PR#DEPARTMENTSUBJECTTAGGING D ";
						qry+=" where  D.departmentcode ='"+QryDept+"'  and D.SECTIONBRANCH=A.SECTIONBRANCH and D.SECTIONBRANCH=B.SECTIONBRANCH) ";
						//qry+=" order by A.SECTIONBRANCH, A.ACADEMICYEAR, subsectioncode, A.PROGRAMCODE, A.TAGGINGFOR, A.SEMESTER, A.SEMESTERTYPE";
						qry+=" UNION ";
						qry+="  SELECT DISTINCT A.subsectioncode subsectioncode, a.academicyear academicyear, a.programcode, a.taggingfor,a.sectionbranch sectionbranch,";
						qry+=" a.semester, a.semestertype,to_char((SELECT COUNT (*) FROM programsubsectiontagging c  ";
						qry+=" WHERE c.institutecode = '"+mInst+"' AND c.examcode = '"+QryExam+"' AND A.SUBSECTIONCODE IS NOT NULL";
						qry+=" AND c.semestertype =DECODE ('"+QrySemType+"','ALL', c.semestertype,'"+QrySemType+"') AND NVL (c.deactive, 'N') = 'N' ";
						qry+=" AND c.academicyear = a.academicyear AND c.programcode = a.programcode AND c.sectionbranch = a.sectionbranch ";
						qry+=" AND c.semester = a.semester AND c.institutecode = b.institutecode AND c.academicyear = b.academicyear AND c.subsectiontype = 'C')) cnt ";
						qry+=" FROM programsubsectiontagging a, academicyearmaster b, pr#electivesubjects c WHERE a.institutecode = '"+mInst+"' AND a.institutecode = b.institutecode AND b.institutecode = c.institutecode AND c.institutecode = a.institutecode";
						qry+=" AND a.examcode = c.examcode  AND a.examcode = '"+QryExam+"' AND a.semestertype = DECODE ('"+QrySemType+"', 'ALL', a.semestertype, '"+QrySemType+"') AND NVL (a.deactive, 'N') = 'N' ";
						qry+=" AND a.academicyear = b.academicyear AND a.academicyear = c.academicyear AND a.programcode = c.programcode AND a.Semester = c.Semester and a.taggingfor=c.taggingfor and a.SECTIONBRANCH=c.SECTIONBRANCH and a.subsectiontype='C' AND NVL (b.currentyear, 'N') = 'Y'";
						qry+=" AND c.subjectid IN (SELECT d.subjectid FROM pr#departmentsubjecttagging d WHERE d.departmentcode='"+QryDept+"' AND d.sectionbranch = a.sectionbranch AND d.sectionbranch = a.sectionbranch)";
						qry+=" AND c.subjectid='"+QrySubjID+"' AND C.BASKET='"+mBasket+"'";
						qry+=" AND A.INSTITUTECODE='"+mInst+"' and A.INSTITUTECODE=b.Institutecode and c.INSTITUTECODE=b.Institutecode";
						qry+=" ORDER BY SECTIONBRANCH,ACADEMICYEAR,subsectioncode,PROGRAMCODE,TAGGINGFOR,SEMESTER,SEMESTERTYPE";
					}
					//out.println(qry);
					rs1=db.getRowset(qry);
					ctr=0;

					//String FstidArray[][]=new String[200][200];
					mSection="";
					while(rs1.next())
					{
						msno++;
						mName4="OLDNEW"+String.valueOf(msno).trim();

						if(request.getParameter(mName4)==null)
							moldnew="";
						else
							moldnew=request.getParameter(mName4).toString();
						//out.print(moldnew);

//-----------------------------------------------------------------------------------
//----------------------------START OF moldnew.equals("N")---------------------------
//-----------------------------------------------------------------------------------
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
ctrLMR=ctr-1;
							mNameR=mSection+"***R///"+String.valueOf(ctr).trim()+"###"+mSeccount ; 
							//mNameLMR=mSection+"***R///"+String.valueOf(ctrLMR).trim()+"###"+mSeccount+"merge"; 
							//mNameLMR=mSection+"***R///"+String.valueOf(ctr).trim()+"###"+mSeccount+"merge"; 
							mNameLMR=mSection+"***R///"+String.valueOf(ctr).trim()+"###"+mSeccount+"merge"; 

							mMerge=request.getParameter(mNameLMR);

							if(mMerge!=null && !mMerge.equals("NONE"))
							{
								mMerge=request.getParameter(mNameLMR).toString().trim();
							}
							else
								mMerge="";

							mEmp=request.getParameter(mNameR);

							if(mEmp!=null && !mEmp.equals("NONE"))
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
//out.print("Merge - "+mMerge);
								if(!mMerge.equals("NONE"))
								{
									if(mMainSec.equals(mSectBranch) && mSub.equals(mSubSect))
									{
										qryo="select fstid from PR#HODLOADDISTRIBUTION where institutecode='"+mInst+"' and examcode='"+QryExam+"' and ";
										qryo+=" SUBJECTID='"+QrySubjID+"' and AcademicYear='"+mAcad+"' and programcode='"+mPc+"' and sectionbranch='"+moldsecbr+"' and ";
										qryo+=" subsectioncode='"+mMergeSec+"' and LTP='"+mLTP+"' and Semestertype='REG' ";
								//	out.print(qryo);
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
								qry="Select nvl(REQROOMTYPE,' ') roomtype from PR#FACULTYSUBJECTCHOICES ";
								qry+=" where institutecode='"+mInst+"' and examcode='"+QryExam+"'";
								qry+=" and SUBJECTID='"+QrySubjID+"' and facultytype='"+mETyp+"' and facultyid='"+mEid+"' ";
								qry+=" and LTP='"+mLTP+"' and subjecttype='"+mType+"' ";
								//	out.println(qry);
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
								try
								{
									String qry12323="Select 'y' from PR#HODLOADDISTRIBUTION where INSTITUTECODE='"+mInst+"' and COMPANYCODE='"+mEcmp+"' and FACULTYTYPE='"+mETyp+"' and FACULTYID='"+mEid+"' and EXAMCODE ='"+QryExam+"' and ACADEMICYEAR='"+mAcad+"' and PROGRAMCODE='"+mProg+"' and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mSectBranch+"' and SUBSECTIONCODE='"+mSubSect+"' and SEMESTER='"+mSem+"' and SEMESTERTYPE='"+mSemt+"' and BASKET='"+mBasket+"' and SUBJECTID='"+QrySubjID+"' and LTP='"+mLTP+"'";
									//out.println(qry12323);
									rs123456=db.getRowset(qry12323);
									if(!rs123456.next())
									{
										Fstid=db.GenerateFSTID(mInst);
										qry="INSERT INTO PR#HODLOADDISTRIBUTION (INSTITUTECODE, COMPANYCODE, FACULTYTYPE, ";
										qry+=" FACULTYID, EXAMCODE, ACADEMICYEAR, PROGRAMCODE, TAGGINGFOR, SECTIONBRANCH, ";
										qry+=" SUBSECTIONCODE, SEMESTER, SEMESTERTYPE, BASKET, SUBJECTID, LTP,REQROOMTYPE, ";
										qry+=" DEPARTMENTRUNNIG, DURATIONOFCLASS, NOOFCLASSINAWEEK, ";
										qry+=" STATUS, ENTRYBY, ENTRYDATE,FSTID,MERGEWITHFSTID,SUBJECTTYPE,ELECTIVECODE) values ";
										qry+=" ('"+mInst+"','"+mEcmp+"','"+mETyp+"','"+mEid+"','"+QryExam+"',	'"+mAcad+"', ";
										qry+=" '"+mProg+"','"+mTag+"','"+mSectBranch+"','"+mSubSect+"','"+mSem+"','"+mSemt+"', ";
										qry+=" '"+mBasket+"','"+QrySubjID+"','"+mLTP+"','"+mroomtype+"', ";	
										qry+=" '"+QryDept+"','"+mDuration+"','"+mClass+"','D','"+mChkMemID+"',sysdate,'"+Fstid+"','"+mImMergeSec+"','"+mType+"','"+QryEleCode+"' ) ";
										int n=0;//out.println(qry+"<BR>");
										n=db.insertRow(qry);
										

										qry="Select fstid from PR#HODLOADDISTRIBUTION where INSTITUTECODE='"+mInst+"' and ";
										qry+=" COMPANYCODE='"+mEcmp+"' and EXAMCODE='"+QryExam+"' and ACADEMICYEAR='"+mAcad+"' ";
										qry+=" and PROGRAMCODE='"+mProg+"' and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mSectBranch+"' ";
										qry+=" and SUBSECTIONCODE='"+mSubSect+"' and SEMESTER='"+mSem+"' and SEMESTERTYPE='"+mSemt+"' ";
										qry+=" and BASKET='"+mBasket+"' and SUBJECTID='"+QrySubjID+"' and LTP='"+mLTP+"' ";
										//out.println(qry+"<br>");
										rsfstid=db.getRowset(qry);
										while(rsfstid.next())
										{
											//out.println("dddddddddddddddddddddddddddddddddddd");
											fstidinsert =rsfstid.getString("fstid");
											//out.println("dddddddddddddddddddddddddddddddddddd");
										}
										if(n>0)
										{
//----------------------------
//-Insert Global Multi/Addl Faculty Here
//----------------------------
											//qry="Select * from multifacultysubjecttagging where InstituteCode='"+mInst+"' AND CompanyCode='"+mComp+"' AND FSTID IN (SELECT FSTID FROM PR#HODLOADDISTRIBUTION WHERE InstituteCode='"+mInst+"' AND CompanyCode='"+mComp+"' AND EXAMCODE='"+QryExam+"' AND SUBJECTID='"+QrySubjID+"' AND LTP='"+mLTP+"' and SECTIONBRANCH='"+mSectBranch+"' and SUBSECTIONCODE='"+mSubSect+"' and AcademicYear='"+mAcad+"' and ProgramCode='"+mProg+"')";
											//out.print(qry);
											qry="delete multifacultysubjecttagging where InstituteCode='"+mInst+"' AND CompanyCode='"+mComp+"' AND FSTID IN (SELECT FSTID FROM PR#HODLOADDISTRIBUTION WHERE InstituteCode='"+mInst+"' AND CompanyCode='"+mComp+"' AND EXAMCODE='"+QryExam+"' AND SUBJECTID='"+QrySubjID+"' AND LTP='"+mLTP+"' and SECTIONBRANCH='"+mSectBranch+"' and SUBSECTIONCODE='"+mSubSect+"' and AcademicYear='"+mAcad+"' and ProgramCode='"+mProg+"')";
											deln2=db.update(qry);
											//out.print(qry+"<br>");

											qry="Select FACULTYTYPE, EMPLOYEEID, NOFHRS, DATETIME, FACULTYSET, nvl(CLASSINAWEEK,'')CLASSINAWEEK, NVL(SET1,0)SET1, NVL(SET2,0)SET2, NVL(SET3,0)SET3, INSERTFROMGLOBAL, ACADEMICYEAR, PROGRAMCODE FROM temp#pr#loaddistribution";
											qry+=" WHERE SUBJECTID='"+QrySubjID+"' and LTP='"+mLTP+"' and SECTIONBRANCH='"+mSectBranch+"' and SUBSECTIONCODE='"+mSubSect+"' and AcademicYear='"+mAcad+"' and ProgramCode='"+mProg+"'";
											ResultSet rstrst=db.getRowset(qry);
											//out.print(qry);
											while(rstrst.next())
											{
												qry="Select 'Y' FROM MULTIFACULTYSUBJECTTAGGING WHERE INSTITUTECODE='"+mInst+"' AND COMPANYCODE='"+mEcmp+"' AND FSTID='"+fstidupdate+"' AND FACULTYTYPE='"+rstrst.getString("FACULTYTYPE")+"' AND EMPLOYEEID='"+rstrst.getString("EMPLOYEEID")+"'";
												ResultSet chkMulti=db.getRowset(qry);
												if(chkMulti.next())
												{
													qry="delete multifacultysubjecttagging where InstituteCode='"+mInst+"' AND CompanyCode='"+mComp+"' AND FSTID='"+fstidupdate+"' AND FACULTYTYPE='"+rstrst.getString("FACULTYTYPE")+"' AND EMPLOYEEID='"+rstrst.getString("EMPLOYEEID")+"'";
													//out.print(qry+"<br><br>");
													deln2=db.update(qry);

													qry="INSERT INTO MULTIFACULTYSUBJECTTAGGING (INSTITUTECODE, COMPANYCODE, FSTID, FACULTYTYPE, EMPLOYEEID, NOFHRS,ENTRYBY, ENTRYDATE, DEACTIVE,FACULTYSET, CLASSINAWEEK,SET1,SET2,SET3)";
													qry+=" VALUES ('"+mInst+"','"+mEcmp+"','"+fstidinsert+"',";
													qry+=" '"+rstrst.getString("FACULTYTYPE")+"','"+rstrst.getString("EMPLOYEEID")+"' , '"+rstrst.getString("NOFHRS")+"','"+mChkMemID+"', sysdate,'N','"+rstrst.getString("FACULTYSET")+"','"+rstrst.getString("CLASSINAWEEK")+"','"+rstrst.getString("set1")+"','"+rstrst.getString("set2")+"','"+rstrst.getString("set3")+"')";		
													//out.print(qry+"<br>");
													int n1=db.insertRow(qry);
												}
												else
												{
													qry="INSERT INTO MULTIFACULTYSUBJECTTAGGING (INSTITUTECODE, COMPANYCODE, FSTID, FACULTYTYPE, EMPLOYEEID, NOFHRS,ENTRYBY, ENTRYDATE, DEACTIVE,FACULTYSET, CLASSINAWEEK,SET1,SET2,SET3)";
													qry+=" VALUES ('"+mInst+"','"+mEcmp+"','"+fstidinsert+"',";
													qry+=" '"+rstrst.getString("FACULTYTYPE")+"','"+rstrst.getString("EMPLOYEEID")+"' , '"+rstrst.getString("NOFHRS")+"','"+mChkMemID+"', sysdate,'N','"+rstrst.getString("FACULTYSET")+"','"+rstrst.getString("CLASSINAWEEK")+"','"+rstrst.getString("set1")+"','"+rstrst.getString("set2")+"','"+rstrst.getString("set3")+"')";		
													//out.print(qry+"<br>");
													int n1=db.insertRow(qry);
												}
											}
										}
										//-----Comment removed as on 09/12/2009-------
										int Set1Val=0;
										qry="SELECT nvl(SET1,1)SET1 from MULTIFACULTYSUBJECTTAGGING WHERE INSTITUTECODE='"+mInst+"' and COMPANYCODE='"+mEcmp+"' and fstid='"+fstidupdate+"'";
										//out.print(qry);
										ResultSet rsSet1=db.getRowset(qry);
										if(rsSet1.next())
											Set1Val=rsSet1.getInt("SET1");
										else
											Set1Val=mClassSetVal;

										qry="UPDATE PR#HODLOADDISTRIBUTION set NOOFCLASSINAWEEKFORSET1="+Set1Val+" WHERE INSTITUTECODE='"+mInst+"' and COMPANYCODE='"+mEcmp+"' and FACULTYTYPE='"+mETyp+"' and FACULTYID='"+mEid+"' and EXAMCODE ='"+QryExam+"' and ACADEMICYEAR='"+mAcad+"' and PROGRAMCODE='"+mProg+"' and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mSectBranch+"' and SUBSECTIONCODE='"+mSubSect+"' and SEMESTER='"+mSem+"' and SEMESTERTYPE='"+mSemt+"' and BASKET='"+mBasket+"' and SUBJECTID='"+QrySubjID+"' and LTP='"+mLTP+"' and fstid='"+fstidupdate+"'";
										//out.print(qry);
										int n10=db.update(qry);
										//--------------------------------------------
									}
								}
								catch(Exception e)
								{
									//out.println(e+"ssss");
								}
								qry1="select employeename||' ('||employeecode||')' employeename from V#STAFF where employeeid='"+mEid+"' and COMPANYCODE='"+mEcmp+"' ";
								rse=db.getRowset(qry1);
								if (rse.next())
									mEid1=rse.getString("employeename");

								qry="select DURATIONOFCLASS,NVL(NOOFCLASSINAWEEKFORSET1, 1) NOOFCLASSINAWEEK FROM PR#HODLOADDISTRIBUTION where INSTITUTECODE='"+mInst+"' and COMPANYCODE='"+mEcmp+"' and FACULTYTYPE='"+mETyp+"' and FACULTYID='"+mEid+"' and EXAMCODE ='"+QryExam+"' and ACADEMICYEAR='"+mAcad+"' and PROGRAMCODE='"+mProg+"' and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mSectBranch+"' and SUBSECTIONCODE='"+mSubSect+"' and SEMESTER='"+mSem+"' and SEMESTERTYPE='"+mSemt+"' and BASKET='"+mBasket+"' and SUBJECTID='"+QrySubjID+"' and LTP='"+mLTP+"'";
								//qry="select DURATIONOFCLASS,NOOFCLASSINAWEEK from PR#HODLOADDISTRIBUTION where institutecode='"+mInst+"' and COMPANYCODE='"+mEcmp+"' and SUBJECTID='"+QrySubjID+"' and sectionbranch='"+mSectBranch+"' and LTP='"+mLTP+"' and semestertype='"+mSemt+"' and FACULTYID='"+mEid+"' order by DURATIONOFCLASS ";
								//out.println("<br>"+qry+"<br>");
								rse=db.getRowset(qry);	
								if(rse.next())
								{
									duration=rse.getString("NOOFCLASSINAWEEK");
								}
								%>
								<tr>
								<td align=center nowrap><B><%=rs1.getString("academicyear")%></B></td>
								<td align=center nowrap><B><%=rs1.getString("programcode")%></B></td>
								<td align=center><B><%=rs1.getString("SECTIONBRANCH")%></B></td>
								<td align=center><B><%=mSubSect%></B></td> 
								<td align=LEFT><%=mEid1%></td>
								<td align=center><%=duration%> day(s)</td>
								<td align=center>SET-1</td>
								<td align=center><font color=darkgreen><B>Saved</B></font></td>
								</tr>
								<%
								//qry="select b.EMPLOYEENAME,a.NOFHRS from FACULTYSUBJECTTAGGING a,V#STAFF b where a.EMPLOYEEID=b.EMPLOYEEID and a.COMPANYCODE =b.COMPANYCODE and a.FSTID='"+fstidinsert+"'";
								String qry23="Select fstid from PR#HODLOADDISTRIBUTION where INSTITUTECODE='"+mInst+"' and COMPANYCODE='"+mEcmp+"' and FACULTYTYPE='"+mETyp+"' and FACULTYID='"+mEid+"' and EXAMCODE ='"+QryExam+"' and ACADEMICYEAR='"+mAcad+"' and PROGRAMCODE='"+mProg+"' and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mSectBranch+"' and SUBSECTIONCODE='"+mSubSect+"' and SEMESTER='"+mSem+"' and SEMESTERTYPE='"+mSemt+"' and BASKET='"+mBasket+"' and SUBJECTID='"+QrySubjID+"' and LTP='"+mLTP+"'";
								rs123456=db.getRowset(qry23);
								if(rs123456.next())
								{
									qry="select B.EMPLOYEENAME||' ('||B.EMPLOYEECODE||')' EMPLOYEENAME,nvl(CLASSINAWEEK,'')CLASSINAWEEK,a.FACULTYSET from MULTIFACULTYSUBJECTTAGGING a,V#STAFF b where a.EMPLOYEEID=b.EMPLOYEEID	and a.FSTID='"+rs123456.getString("fstid")+"' and b.COMPANYCODE='"+mEcmp+"' and nvl(a.deactive,'N')='N' and nvl(b.deactive,'N')='N'";
									//out.println("<BR>"+qry+"<BR>");
									rsse=db.getRowset(qry);
									while (rsse.next())
									{
										%>
										<tr bgcolor=#F8F8F8>
										<!--<tr bgcolor=lightgrey>-->
										<td colspan=2>&nbsp;</td>
										<td align=center colspan=2>Multiple/Additional Faculty in <%=rs1.getString("SECTIONBRANCH")%>-<%=mSubSect%> <!--<img src='../../Images/arrow_cool.gif'>--> <B>&rarr;</td>
										<td align=LEFT><%=rsse.getString("EMPLOYEENAME")%></td>
										<td align=center><%=rsse.getString("CLASSINAWEEK")%> day(s)</td>
										<td align=center><%=rsse.getString("FACULTYSET")%></td>
										<td align=center><font color=darkgreen><B>Saved</B></font></td>
										</tr>
										<%
									}
								}
							} // closing of if if(!mEmp.equals("NONE"))
							else
							{
							}
//-----------------------------------------------------------------------------------
//----------------------------END OF moldnew.equals("N")-----------------------------
//-----------------------------------------------------------------------------------

						} //closing of moldnew="N"
						else
						{

//-----------------------------------------------------------------------------------
//----------------------------START OF moldnew.equals("O")---------------------------
//-----------------------------------------------------------------------------------
							mSeccount=rs1.getString("cnt");
							mSubsection=rs1.getString("subsectioncode");
							if(!mSection.equals(rs1.getString("SECTIONBRANCH")))
							{
								ctr=1;
								mSection=rs1.getString("SECTIONBRANCH");	
							}
							else
								ctr++;
ctrLMR=ctr-1;	
							mNameR=mSection+"***R///"+String.valueOf(ctr).trim()+"###"+mSeccount ; 
							//mNameLMR=mSection+"***R///"+String.valueOf(ctrLMR).trim()+"###"+mSeccount+"merge"; 
							//mNameLMR=mSection+"***R///"+String.valueOf(ctr).trim()+"###"+mSeccount+"merge"; 
							mNameLMR=mSection+"***R///"+String.valueOf(ctr).trim()+"###"+mSeccount+"merge"; 

							mMerge=request.getParameter(mNameLMR);
							//out.println("<br>"+mMerge);
							if(mMerge!=null && !mMerge.equals("NONE"))
							{
								mMerge=request.getParameter(mNameLMR).toString().trim();
							}
							else
								mMerge="";
							mEmp=request.getParameter(mNameR);
							//out.println("Vijay - "+mEmp);
							if(mEmp!=null && !mEmp.equals("NONE"))
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

//out.print("Merger Batch - "+mMerge);
								if(!mMerge.equals("NONE") || !mMerge.equals(""))
								{
									if(mMainSec.equals(mSectBranch) && mSub.equals(mSubSect))
									{
										qryo="select fstid from PR#HODLOADDISTRIBUTION where institutecode='"+mInst+"' and examcode='"+QryExam+"' and ";
										qryo+=" SUBJECTID='"+QrySubjID+"' and programcode='"+mPc+"' and sectionbranch='"+moldsecbr+"' and ";
										qryo+=" subsectioncode='"+mMergeSec+"' and semestertype='REG' and LTP='"+mLTP+"' ";
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
								qry="Select nvl(REQROOMTYPE,' ') roomtype from PR#FACULTYSUBJECTCHOICES ";
								qry+=" where institutecode='"+mInst+"' and examcode='"+QryExam+"'";
								qry+=" and SUBJECTID='"+QrySubjID+"' and facultytype='"+mETyp+"' and facultyid='"+mEid+"' ";
								qry+=" and LTP='"+mLTP+"' and subjecttype='"+mType+"' ";
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
								int N=0;
								qry="SELECT 'Y' FROM PR#HODLOADDISTRIBUTION WHERE INSTITUTECODE='"+mInst+"' and COMPANYCODE='"+mEcmp+"' and EXAMCODE='"+QryExam+"' and ACADEMICYEAR='"+mAcad+"' and PROGRAMCODE='"+mProg+"' and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mSectBranch+"' and SUBSECTIONCODE='"+mSubSect+"' and SEMESTER='"+mSem+"' and SEMESTERTYPE='"+mSemt+"' and BASKET='"+mBasket+"' and SUBJECTID='"+QrySubjID+"' and LTP='"+mLTP+"'";
								//out.print(qry);
								rs=db.getRowset(qry);
								if(rs.next())
								{
									qry="update PR#HODLOADDISTRIBUTION set FACULTYTYPE='"+mETyp+"',FACULTYID='"+mEid+"', ";
									qry+=" REQROOMTYPE='"+mroomtype+"', MERGEWITHFSTID='"+mImMergeSec+"' , ";
									qry+=" DURATIONOFCLASS='"+mDuration+"', NOOFCLASSINAWEEK='"+mClass+"' ,";
									qry+=" ENTRYDATE=sysdate where INSTITUTECODE='"+mInst+"' and ";
									qry+=" COMPANYCODE='"+mEcmp+"' and EXAMCODE='"+QryExam+"' and ACADEMICYEAR='"+mAcad+"' ";
									qry+=" and PROGRAMCODE='"+mProg+"' and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mSectBranch+"' ";
									qry+=" and SUBSECTIONCODE='"+mSubSect+"' and SEMESTER='"+mSem+"' and SEMESTERTYPE='"+mSemt+"' ";
									qry+=" and BASKET='"+mBasket+"' and SUBJECTID='"+QrySubjID+"' and LTP='"+mLTP+"' ";
									N=db.update(qry);
									//out.print(qry);
								}
								try
								{
									qry="Select fstid from PR#HODLOADDISTRIBUTION where INSTITUTECODE='"+mInst+"' and ";
									qry+=" COMPANYCODE='"+mEcmp+"' and EXAMCODE='"+QryExam+"' and ACADEMICYEAR='"+mAcad+"' ";
									qry+=" and PROGRAMCODE='"+mProg+"' and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mSectBranch+"' ";
									qry+=" and SUBSECTIONCODE='"+mSubSect+"' and SEMESTER='"+mSem+"' and SEMESTERTYPE='"+mSemt+"' ";
									qry+=" and BASKET='"+mBasket+"' and SUBJECTID='"+QrySubjID+"' and LTP='"+mLTP+"' ";
									//out.println(qry);
									rsfstid=db.getRowset(qry);
									while(rsfstid.next())
									{
										//out.println("dddddddddddddddddddddddddddddddddddd");
										fstidupdate =rsfstid.getString("fstid");
										//out.println("dddddddddddddddddddddddddddddddddddd");
									}
									if(N>0)
									{
//----------------------------
//-Update Global Multi/Addl Faculty Here
//----------------------------
										try
										{
											qry="SELECT 'Y' FROM temp#pr#loaddistribution WHERE SUBJECTID='"+QrySubjID+"' and LTP='"+mLTP+"'";
											qry+=" and SECTIONBRANCH='"+mSectBranch+"' and SUBSECTIONCODE='"+mSubSect+"' and AcademicYear='"+mAcad+"' and ProgramCode='"+mProg+"'";
											//out.print(qry);
											ResultSet rstrst=db.getRowset(qry);
											if(rstrst.next())
											{
												qry="delete multifacultysubjecttagging where InstituteCode='"+mInst+"' AND CompanyCode='"+mComp+"' AND FSTID='"+fstidupdate+"'";
												//out.print(qry+"<br><br>");
												deln2=db.update(qry);
											}

											qry="Select FACULTYTYPE, EMPLOYEEID, NOFHRS, DATETIME, FACULTYSET, nvl(CLASSINAWEEK,'')CLASSINAWEEK, nvl(SET1,0)SET1, nvl(SET2,0)SET2, nvl(SET3,0)SET3, INSERTFROMGLOBAL, ACADEMICYEAR, PROGRAMCODE FROM temp#pr#loaddistribution";
											qry+=" WHERE SUBJECTID='"+QrySubjID+"' and LTP='"+mLTP+"' and SECTIONBRANCH='"+mSectBranch+"' and SUBSECTIONCODE='"+mSubSect+"' and AcademicYear='"+mAcad+"' and ProgramCode='"+mProg+"'";
											//out.print(qry);
											rstrst=db.getRowset(qry);
											while(rstrst.next())
											{
												qry="Select 'Y' FROM MULTIFACULTYSUBJECTTAGGING WHERE INSTITUTECODE='"+mInst+"' AND COMPANYCODE='"+mEcmp+"' AND FSTID='"+fstidupdate+"' AND FACULTYTYPE='"+rstrst.getString("FACULTYTYPE")+"' AND EMPLOYEEID='"+rstrst.getString("EMPLOYEEID")+"'";
												ResultSet chkMulti=db.getRowset(qry);
												//out.print(qry+"<br><br>");
												if(chkMulti.next())
												{
													qry="delete multifacultysubjecttagging where InstituteCode='"+mInst+"' AND CompanyCode='"+mComp+"' AND FSTID='"+fstidupdate+"' AND FACULTYTYPE='"+rstrst.getString("FACULTYTYPE")+"' AND EMPLOYEEID='"+rstrst.getString("EMPLOYEEID")+"'";
													//out.print(qry+"<br><br>");
													deln2=db.update(qry);

													qry="INSERT INTO MULTIFACULTYSUBJECTTAGGING (INSTITUTECODE, COMPANYCODE, FSTID, FACULTYTYPE, EMPLOYEEID, NOFHRS,ENTRYBY, ENTRYDATE, DEACTIVE,FACULTYSET, CLASSINAWEEK,SET1,SET2,SET3)";
													qry+=" VALUES ('"+mInst+"','"+mEcmp+"','"+fstidupdate+"',";
													qry+=" '"+rstrst.getString("FACULTYTYPE")+"','"+rstrst.getString("EMPLOYEEID")+"' , '"+rstrst.getString("NOFHRS")+"','"+mChkMemID+"', sysdate,'N','"+rstrst.getString("FACULTYSET")+"','"+rstrst.getString("CLASSINAWEEK")+"','"+rstrst.getString("set1")+"','"+rstrst.getString("set2")+"','"+rstrst.getString("set3")+"')";		
													//out.println(qry+"<br>");
													int n1=db.insertRow(qry);
												}
												else
												{
													qry="INSERT INTO MULTIFACULTYSUBJECTTAGGING (INSTITUTECODE, COMPANYCODE, FSTID, FACULTYTYPE, EMPLOYEEID, NOFHRS,ENTRYBY, ENTRYDATE, DEACTIVE,FACULTYSET, CLASSINAWEEK,SET1,SET2,SET3)";
													qry+=" VALUES ('"+mInst+"','"+mEcmp+"','"+fstidupdate+"',";
													qry+=" '"+rstrst.getString("FACULTYTYPE")+"','"+rstrst.getString("EMPLOYEEID")+"' , '"+rstrst.getString("NOFHRS")+"','"+mChkMemID+"', sysdate,'N','"+rstrst.getString("FACULTYSET")+"','"+rstrst.getString("CLASSINAWEEK")+"','"+rstrst.getString("set1")+"','"+rstrst.getString("set2")+"','"+rstrst.getString("set3")+"')";		
													//out.print(qry+"<br>");
													int n1=db.insertRow(qry);
												}
											}
										}
										catch(Exception e)
										{
											//out.print(e+"ABCDEF"+qry);
										}
										//-----Comment removed as on 09/12/2009-------
										int Set1Val=0;
										qry="SELECT nvl(SET1,1)SET1 from MULTIFACULTYSUBJECTTAGGING WHERE INSTITUTECODE='"+mInst+"' and COMPANYCODE='"+mEcmp+"' and fstid='"+fstidupdate+"'";
										//out.print(qry);
										ResultSet rsSet1=db.getRowset(qry);
										if(rsSet1.next())
											Set1Val=rsSet1.getInt("SET1");
										else
											Set1Val=mClassSetVal;

										qry="UPDATE PR#HODLOADDISTRIBUTION set NOOFCLASSINAWEEKFORSET1="+Set1Val+" WHERE INSTITUTECODE='"+mInst+"' and COMPANYCODE='"+mEcmp+"' and FACULTYTYPE='"+mETyp+"' and FACULTYID='"+mEid+"' and EXAMCODE ='"+QryExam+"' and ACADEMICYEAR='"+mAcad+"' and PROGRAMCODE='"+mProg+"' and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mSectBranch+"' and SUBSECTIONCODE='"+mSubSect+"' and SEMESTER='"+mSem+"' and SEMESTERTYPE='"+mSemt+"' and BASKET='"+mBasket+"' and SUBJECTID='"+QrySubjID+"' and LTP='"+mLTP+"' and fstid='"+fstidupdate+"'";
										//out.print(qry);
										int n10=db.update(qry);										
										//--------------------------------------------
									}
								}
								catch(Exception e)
								{
									//out.println(e);
								}
								qry1="select employeename||' ('||employeecode||')' employeename from V#STAFF where employeeid='"+mEid+"' and COMPANYCODE='"+mEcmp+"' ";
								rse=db.getRowset(qry1);
								//out.println(qry1);
								if (rse.next())
									mEid1=rse.getString("employeename");
	
								qry="select  nvl(DURATIONOFCLASS,'')DURATIONOFCLASS, NVL(NOOFCLASSINAWEEKFORSET1,1)NOOFCLASSINAWEEK from PR#HODLOADDISTRIBUTION where institutecode='"+mInst+"' and COMPANYCODE='"+mEcmp+"' and SUBJECTID='"+QrySubjID+"' and sectionbranch='"+mSectBranch+"' and LTP='"+mLTP+"' and semestertype='"+mSemt+"' and ACADEMICYEAR='"+mAcad+"' and PROGRAMCODE='"+mProg+"' and FACULTYID='"+mEid+"' and DEPARTMENTRUNNIG='"+QryDept+"' order by DURATIONOFCLASS ";
							//out.println("123 "+qry);
								rse=db.getRowset(qry);	
								if(rse.next())
								{
									duration=rse.getString("NOOFCLASSINAWEEK");
								}
								%>
								<tr>
								<td align=center nowrap><B><%=rs1.getString("academicyear")%></B></td>
								<td align=center nowrap><B><%=rs1.getString("programcode")%></B></td>
								<td align=center><B><%=rs1.getString("SECTIONBRANCH")%></B></td>
								<td align=center><B><%=mSubSect%></B></td>
								<td align=LEFT><%=mEid1%></td>
								<td align=center><%=duration%> day(s)</td>
								<td align=center>SET-1</td>
								<td align=center><font color=darkgreen><B>Modified</B></font></td>
								</tr>
								<% 
								String qry23="Select fstid from PR#HODLOADDISTRIBUTION where INSTITUTECODE='"+mInst+"' and COMPANYCODE='"+mEcmp+"' and FACULTYTYPE='"+mETyp+"' and FACULTYID='"+mEid+"' and EXAMCODE ='"+QryExam+"' and ACADEMICYEAR='"+mAcad+"' and PROGRAMCODE='"+mProg+"' and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mSectBranch+"' and SUBSECTIONCODE='"+mSubSect+"' and SEMESTER='"+mSem+"' and SEMESTERTYPE='"+mSemt+"' and BASKET='"+mBasket+"' and SUBJECTID='"+QrySubjID+"' and LTP='"+mLTP+"' and DEPARTMENTRUNNIG='"+QryDept+"' ";
								//out.println(qry23);
								rs123456=db.getRowset(qry23);
								if(rs123456.next())
								{
									qry="select B.EMPLOYEENAME||' ('||B.EMPLOYEECODE||')' EMPLOYEENAME, nvl(a.CLASSINAWEEK,'')CLASSINAWEEK, A.FACULTYSET from MULTIFACULTYSUBJECTTAGGING A, V#STAFF B WHERE A.EMPLOYEEID=B.EMPLOYEEID	and A.FSTID='"+rs123456.getString("fstid")+"' and B.COMPANYCODE='"+mEcmp+"' and nvl(A.DEACTIVE,'N')='N' and nvl(B.DEACTIVE,'N')='N'";
									//out.println(qry);
									rsse=db.getRowset(qry);
									while (rsse.next())
									{
										%>
										<tr bgcolor=#F8F8F8>
										<!--<tr bgcolor=lightgrey>-->
										<td colspan=2>&nbsp;</td>
										<td align=center colspan=2>Multiple/Additional Faculty in <%=rs1.getString("SECTIONBRANCH")%>-<%=mSubSect%> <!--<img src='../../Images/arrow_cool.gif'>--> <B>&rarr;</B></td>
										<td align=LEFT><%=rsse.getString("EMPLOYEENAME")%></td>
										<td align=center><%=rsse.getString("CLASSINAWEEK")%> day(s)</td>
										<td align=center><%=rsse.getString("FACULTYSET")%></td>
										<td align=center><font color=darkgreen><B>Modified</B></font></td>
										</tr>
										<%
									}
								}			
						 	} // closing of if if(!mEmp.equals("NONE"))

//--------------Start of Delete Load----------------
/*
							else
							{
								mAcad=rs1.getString("ACADEMICYEAR");
								mProg=rs1.getString("PROGRAMCODE");
								mTag=rs1.getString("TAGGINGFOR");
								mSectBranch=rs1.getString("SECTIONBRANCH");
								mSubSect=rs1.getString("SUBSECTIONCODE");
								mSem=rs1.getString("SEMESTER");
								mSemt=rs1.getString("SEMESTERTYPE");

								qry="select 'Y' FROM MULTIFACULTYSUBJECTTAGGING where INSTITUTECODE='"+mInst+"' AND COMPANYCODE='"+mComp+"' AND FSTID IN (";
								qry+=" SELECT FSTID FROM PR#HODLOADDISTRIBUTION WHERE INSTITUTECODE='"+mInst+"' and ";
								qry+=" EXAMCODE='"+QryExam+"' and ACADEMICYEAR='"+mAcad+"' ";
								qry+=" and PROGRAMCODE='"+mProg+"' and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mSectBranch+"' ";
								qry+=" and SUBSECTIONCODE='"+mSubSect+"' and SEMESTER='"+mSem+"' and SEMESTERTYPE='"+mSemt+"' ";
								qry+=" and BASKET='"+mBasket+"' and SUBJECTID='"+QrySubjID+"' and LTP='"+mLTP+"' )";
								ResultSet rrss=db.getRowset(qry);
								//out(1111111111111);
								if(rrss.next())
								{
									qry="delete MULTIFACULTYSUBJECTTAGGING where INSTITUTECODE='"+mInst+"' AND COMPANYCODE='"+mComp+"' AND FSTID IN (";
									qry+=" SELECT FSTID FROM PR#HODLOADDISTRIBUTION WHERE INSTITUTECODE='"+mInst+"' and ";
									qry+=" EXAMCODE='"+QryExam+"' and ACADEMICYEAR='"+mAcad+"' ";
									qry+=" and PROGRAMCODE='"+mProg+"' and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mSectBranch+"' ";
									qry+=" and SUBSECTIONCODE='"+mSubSect+"' and SEMESTER='"+mSem+"' and SEMESTERTYPE='"+mSemt+"' ";
									qry+=" and BASKET='"+mBasket+"' and SUBJECTID='"+QrySubjID+"' and LTP='"+mLTP+"' )";
									int nnn=0;
									//nnn=db.update(qry);
									//out.println(qry);
									if(nnn>0)
									{
										qry=" delete PR#HODLOADDISTRIBUTION where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+QryExam+"' and ACADEMICYEAR='"+mAcad+"' ";
										qry+=" and PROGRAMCODE='"+mProg+"' and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mSectBranch+"' ";
										qry+=" and SUBSECTIONCODE='"+mSubSect+"' and SEMESTER='"+mSem+"' and SEMESTERTYPE='"+mSemt+"' ";
										qry+=" and BASKET='"+mBasket+"' and SUBJECTID='"+QrySubjID+"' and LTP='"+mLTP+"' ";
										int nN=db.update(qry);
										//out.println(qry);
									}
								}
								else
								{
									qry=" delete PR#HODLOADDISTRIBUTION where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+QryExam+"' and ACADEMICYEAR='"+mAcad+"' ";
									qry+=" and PROGRAMCODE='"+mProg+"' and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mSectBranch+"' ";
									qry+=" and SUBSECTIONCODE='"+mSubSect+"' and SEMESTER='"+mSem+"' and SEMESTERTYPE='"+mSemt+"' ";
									qry+=" and BASKET='"+mBasket+"' and SUBJECTID='"+QrySubjID+"' and LTP='"+mLTP+"' ";
									int n=db.update(qry);
									//out.println(qry);
								}
							} // closing of else 
*/
//--------------End of Delete Load----------------

						} // closing of else moldnew
//-----------------------------------------------------------------------------------
//----------------------------END OF moldnew.equals("O")-----------------------------
//-----------------------------------------------------------------------------------
						String id1=mLTP+rs1.getString("sectionbranch")+rs1.getString("subsectioncode")+rs1.getString("academicyear")+rs1.getString("programcode");

						qry="delete Temp#pr#loaddistribution where SESSIONID='"+id1+"' AND SUBJECTID='"+QrySubjID+"' and LTP='"+mLTP+"'";
						//out.println(qry);
						int nN1=db.update(qry);

					} //closing of while.....

				//} // CLOSING OF ELSE
				// Log Entry
				//-----------------
				 db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"Pre Reg. Load Distribution ", "ExamCode:"+QryExam+" SubjectID:"+QrySubjID+"Depatrment Running:"+ QryDept, "NO MAC Address" , mIPAddress);
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
			//session.setAttribute("MultiCumAddlFaculty",null);
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
	} //2
	else
	{
		out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	} 
}	//1	
catch(Exception e)
{
	//out.print(e);
	//out.print("No Item Selected...");
}
%>
</tbody>
</table>
<CENTER><table align=center>
<tr bgcolor="#C6D6FD">
<td><a title="Click to go Back" href="PRLoadDistributionByHODAction.jsp?PROJSUBJ=<%=mProjSubj%>&amp;SUBJID=<%=QrySubjID%>&amp;SUBJ=<%=mSubj%>&amp;ELECTIVECODE=<%=QryEleCode%>&amp;BASKET=<%=mBasket%>&amp;PRCODE=<%=mPrCode%>&amp;SEM=<%=QrySemType%>&amp;ELE=<%=mEle%>&amp;SUBNAME=<%=mSname%>&amp;EXAM=<%=QryExam%>&amp;TYPE=<%=mType%>&amp;DEPT=<%=QryDept%>&amp;LTP=<%=mLTP%>"><img src="images\2aniarr4.gif"></a></td>
<td><input type='submit' name='submit' value='Close' title="Click to Close this Window!" onclick='window.close();' style="background-color:#C6D6FD; font-size=18; color:003300; font-weight:bold; width:58px; height:40px;"></td>
</tr>
</table></center>
<!--<input type='submit' name='submit' value='Back' title="Click to go Back!" onclick="GoBack()" style="background-color:#C6D6FD; color:black; font-weight:bold; width:60px;">-->

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