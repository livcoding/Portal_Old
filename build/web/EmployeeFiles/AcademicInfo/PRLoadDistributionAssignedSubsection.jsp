<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
ResultSet rs=null,rs1=null,rs2=null,rs3=null,rs5=null,rsc=null,rsl=null,rsm=null;

String mMemberID="",mDMemberID="",qry1="",mNameLML="",mvalue="",qrym="",mDept2=""; 
String mMemberName="",mProgramcode="";
String mMemberType="",mDMemberType="",mStudcnt="",mDis="",moldMerge="",moldMerge1="";
String mHead="",mOldEmp="",moldemp1="",mNameLMR="";
String mDMemberCode="",mMemberCode="",mFac="",mfac="",QryEleCode="";
String mInst="",mSection="",mSubsection="",mBasket="",mOfac="",mprogc="";
String qry="",Type="",mltp="",QrySemType="",mEmpid="",memp="",mName1="",mName2="";
String mName3="",mName4="",mName5="",mName6="",mComp="";
String mType="",mLTP="",mSubj="",mFaculty="",QryFaculty="",QryDept="",QryExam="",mSname="",mSeccount="",mPrCode="";
String mEmpIdv="", mMName5="", mMName6="";
String mFacv="",mTyp="",mEmpTyp="",mcmp="",mEcmp="",mDuration="",mClass="",mSendhod="";
String mMult="", mCapSubmit="Check to Save Load";
String [] mMultiFaculty=new String [1000];

String [] multiFac=(String [])session.getAttribute("MultiCumAddlFaculty");

int mL1=0, mT1=0, mP1=0, mlt1=0, mFlag2=0, mFlag1=0, mFlag11=0, mFlag111=0, CTR=0, ctr=0, x=0, msno=0;
int mL=0,mT=0,mP=0,mlt=0, mTotGlFac=0;
double mAssigned=0,mMin=0,mMax=0,mexcludeassign=0 ;
double mAssignedload=0,mMinload=0,mMaxload=0;

if (session.getAttribute("CompanyCode")==null)
	mComp="";
else
	mComp=session.getAttribute("CompanyCode").toString().trim();

if (session.getAttribute("InstituteCode")==null)
	mInst="";
else
	mInst=session.getAttribute("InstituteCode").toString().trim();

if (session.getAttribute("MemberID")==null)
	mMemberID="";
else
	mMemberID=session.getAttribute("MemberID").toString().trim();

if (session.getAttribute("MemberType")==null)
	mMemberType="";
else
	mMemberType=session.getAttribute("MemberType").toString().trim();

if (session.getAttribute("MemberCode")==null)
	mMemberCode="";
else
	mMemberCode=session.getAttribute("MemberCode").toString().trim();

if (session.getAttribute("MemberName")==null)
	mMemberName="";
else
	mMemberName=session.getAttribute("MemberName").toString().trim();

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";

if (session.getAttribute("TotalInGlobalMultiFac")==null)
	mTotGlFac=0;
else
	mTotGlFac=Integer.parseInt(session.getAttribute("TotalInGlobalMultiFac").toString().trim());

%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [HOD Advance Load Distribution] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

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
	{	OLTEncryption enc=new OLTEncryption();
		mDMemberID=enc.decode(mMemberID);
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);

		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk=null;
	
		String QrySubjID="", mProjSubj="";
		String mEle="";
		String qrye="",sc="";
		ResultSet rse=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
		qry="Select WEBKIOSK.ShowLink('56','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if(RsChk.next() && RsChk.getString("SL").equals("Y"))
		{
  //----------------------

if (request.getParameter("PROJSUBJ")==null)
{
	mProjSubj="N";
}
else
{
	mProjSubj=request.getParameter("PROJSUBJ").toString().trim();
}

if (request.getParameter("SUBJID")==null)
{
	QrySubjID="";
}
else
{
	QrySubjID=request.getParameter("SUBJID").toString().trim();
}

if (request.getParameter("SUBJ")==null)
{
	mSubj="";
}
else
{
	mSubj=request.getParameter("SUBJ").toString().trim();
	//out.println(mSubj);
}
if (request.getParameter("TYPE")==null)
{
	mType="";
}
else
{
	mType=request.getParameter("TYPE").toString().trim();
}
if (request.getParameter("DEPT")==null)
{
	QryDept="";
}
else
{
	QryDept=request.getParameter("DEPT").toString().trim();
}

if (request.getParameter("ELECTIVECODE")==null || request.getParameter("ELECTIVECODE").equals("null"))
{
	QryEleCode="";
}
else
{
	QryEleCode=request.getParameter("ELECTIVECODE").toString().trim();
}

if (request.getParameter("LTP")==null)
{
	mLTP="";
}
else
{
	mLTP=request.getParameter("LTP").toString().trim();
}
if (request.getParameter("ELE")==null)
{
	mEle="";
}
else
{
	mEle=request.getParameter("ELE").toString().trim();
}
if (request.getParameter("BASKET")==null)
{
	mBasket="";
}
else
{
	mBasket=request.getParameter("BASKET").toString().trim();
}
if (request.getParameter("EXAM")==null)
{
	QryExam="";
}
else
{
	QryExam=request.getParameter("EXAM").toString().trim();
}
if (request.getParameter("SEM")==null)
{
	QrySemType="";
}
else
{
	QrySemType=request.getParameter("SEM").toString().trim();
}
qry="select subject from subjectmaster where INSTITUTECODE='"+mInst+"' AND SUBJECTID='"+QrySubjID+"' ";
rs=db.getRowset(qry);
if(rs.next())
mSname=rs.getString(1);		
mSname=gb.toTtitleCase(mSname);
if(mType.equals("C"))
  Type="Core";
else if(mType.equals("E"))
 Type="Elective";
else
 Type="Free Elective";

try
{
	qry1=" select nvl(LHOURS,0)L,nvl(THOURS,0)T,nvl(PHOURS,0)P, ";
	qry1+=" nvl(LCLASSES,0)L1,nvl(TCLASSES,0)T1,nvl(PCLASSES,0)P1 from SUBJECTWISELTPHOURS where ";
	qry1+=" institutecode='"+mInst+"' and EXAMCODE='"+QryExam+"' and ";
	qry1+=" SUBJECTID='"+QrySubjID+"' and BASKET='"+mBasket+"'  ";
	qry1+=" and NVL(DEACTIVE,'N')='N' ";

//	out.println(qry1);
	rsl=db.getRowset(qry1);

	
	if(rsl.next())
	{
		  mL1=rsl.getInt("L");
		  mT1=rsl.getInt("T");
		  mP1=rsl.getInt("P");
	
		  mL=rsl.getInt("L1");
		  mT=rsl.getInt("T1");
		  mP=rsl.getInt("P1");

		if(mLTP.equals("L"))
		{
		  mltp="Lecture";
		  mlt=mL;
		  mlt1=mL1;
		}
		else if(mLTP.equals("T"))
		{
		 mltp="Tutorial";
		 mlt=mT;
		 mlt1=mT1;	
		}
		else
		{
		 mltp="Practical";
		 mlt=mP;
		 mlt1=mP1;		
		}

	}
else
{

if(mType.equals("C"))
{
  qry="select nvl(L,0)L,nvl(T,0)T,nvl(P,0)P from programsubjecttagging where institutecode='"+mInst+"'  and SUBJECTID='"+QrySubjID+"' and examcode='"+QryExam+"' ";
  qry+=" and nvl(deactive,'N')='N' ";
  //out.println(qry);
  rs=db.getRowset(qry);
  if(rs.next())
  {	
  mL=rs.getInt("L");
  mT=rs.getInt("T");
  mP=(int)(rs.getInt("P")/2);				

  mL1=rs.getInt("L");
  mT1=rs.getInt("T");
  mP1=rs.getInt("P");				

  }	
}		
else if(mType.equals("E"))
{
  qry="select nvl(L,0)L,nvl(T,0)T,nvl(P,0)P from PR#ELECTIVESUBJECTS where institutecode='"+mInst+"' and examcode='"+QryExam+"' and SUBJECTID='"+QrySubjID+"' ";
  qry+=" and nvl(deactive,'N')='N' ";
  rs=db.getRowset(qry);
  if(rs.next())
  {	
  mL=rs.getInt("L");
  mT=rs.getInt("T");
  mP=(int)(rs.getInt("P")/2);			
	
  mL1=rs.getInt("L");
  mT1=rs.getInt("T");
  mP1=rs.getInt("P");				
  }	
}	
else 
{
  qry="select nvl(L,0)L,nvl(T,0)T,nvl(P,0)P from FREEELECTIVE where institutecode='"+mInst+"' and examcode='"+QryExam+"' and SUBJECTID='"+QrySubjID+"' ";
  qry+=" and nvl(deactive,'N')='N' ";
  rs=db.getRowset(qry);
  if(rs.next())
  {	
  mL=rs.getInt("L");
  mT=rs.getInt("T");
  mP=(int)(rs.getInt("P")/2);				

  mL1=rs.getInt("L");
  mT1=rs.getInt("T");
  mP1=rs.getInt("P");				
 }
}

if(mLTP.equals("L"))
{
  mltp="Lecture";
  mlt=mL;
  mlt1=1;
}
else if(mLTP.equals("T"))
{
 mltp="Tutorial";
 mlt=mT;
 mlt1=1;	
}
else
{
 mltp="Practical";
 mlt=mP;
 mlt1=2;		
}

} // closing of else
}
catch(Exception e)
{
}	

%>
<form name="frm1" method="post">
<input type=hidden name="xx" value="">
<table id=id1 width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Assign/Distribute Load to Faculty<B></TD>
</font></td></tr>
</TABLE>
<table id=idd2 cellpadding=1 cellspacing=0 width="100%" align=center rules=rows  border=3>
<tr><td align=center colspan=3>
<%
String mProject="";
if(mProjSubj.equals("Y"))
	mProject=" <FONT COLOR=NAVY><B>[Project Subject]</B></FONT>";
%>
<font face=arial color=navy size=2><b>HOD Load Distribution of Subject : </b>&nbsp;<font face=arial color=navy size=2><%=mSname%></font>&nbsp;(<%=mSubj%>) - <%=Type%> &nbsp; &nbsp; &nbsp; &nbsp;<font face=arial color=black size=2><b>LTP : </b></Font>&nbsp;<%=mltp%></Font> <%=mProject%> &nbsp; &nbsp;
</td></tr>

<tr><td align=left nowrap colspan=2>&nbsp; &nbsp; 
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
<font face=arial color=black size=2><b>Semester Type : </b></Font><select name=SEMTYPE id=SEM style="background-color:#C6D6FD; color:black; font-weight:normal">
<option selected value='<%=QrySemType%>'><%=QrySemType%></option>
</select>
</td></tr>

<tr><td align=left nowrap>&nbsp; &nbsp; 
<font face=arial color=black size=2><b>Class Duration : </b></Font>
<input readonly type=text name=Dura id=Dura value='<%=mlt1%>' style="background-color:#C6D6FD; color:black; font-weight:normal; text-align:right" maxlength=3 size=1>hrs
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
 <font face=arial color=black size=2><b>No. of Class in a Week : </b><input readonly type=text name=Class1 id=Class1 value='<%=mlt%>' style="background-color:#C6D6FD; color:black; font-weight:normal; text-align:right" maxlength=3 size=1>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
</td>
<td nowrap align=center><a style="cursor:hand" onClick="Help()" title="Need Help? Click Here"><B><Font color=mahroon>HELP?</Font></B></a></td>
<tr>
</table>
<TABLE width="100%" align=center rules=Rows class="sort-table" id="table-1" cellSpacing=0 cellPadding=0 border=1 rules=groups>
<thead>
<tr bgcolor="#C6D6FD">
<td align=middle><b><font color=black face=arial size=2>Section</font><b></td>
<td align=middle><b><font color=black face=arial size=2>SubSection</font><b></td>
<td align=middle><b><font color=black face=arial size=2>Load Status</font><b></td>
</tr>
</thead>
<tbody>
<%
	if(mType.equals("C"))
	{
		qry="SELECT DISTINCT b.subsectioncode subsectioncode, a.academicyear academicyear, a.programcode, a.taggingfor,a.sectionbranch sectionbranch,";
		qry+=" a.semester, a.semestertype,(SELECT COUNT (*) FROM programsubsectiontagging c  ";
		qry+=" WHERE c.institutecode = '"+mInst+"' AND c.examcode = '"+QryExam+"' AND B.SUBSECTIONCODE IS NOT NULL";
		qry+=" AND c.semestertype =DECODE ('"+QrySemType+"','ALL', c.semestertype,'"+QrySemType+"') AND NVL (c.deactive, 'N') = 'N' ";
		qry+=" AND c.academicyear = a.academicyear AND c.programcode = a.programcode AND c.sectionbranch = a.sectionbranch ";
		qry+=" AND c.semester = a.semester AND c.subsectiontype = 'C') cnt ";
		qry+=" FROM programsubsectiontagging a, pr#STUDENTSUBJECTCHOICE b  ,ProgramSubjecttagging c WHERE a.institutecode = '"+mInst+"' and a.INSTITUTECODE=c.INSTITUTECODE ";
		qry+=" AND a.examcode = c.examcode AND a.examcode = b.examcode AND b.subjecttype = 'C' AND a.examcode = '"+QryExam+"' ";
		qry+=" AND a.semestertype = DECODE ('"+QrySemType+"', 'ALL', a.semestertype, '"+QrySemType+"') AND NVL (a.deactive, 'N') = 'N' ";
		qry+=" AND a.academicyear = b.academicyear AND a.programcode = b.programcode AND a.sectionbranch = b.sectionbranch  ";
		qry+=" and a.academicyear=c.ACADEMICYEAR and a.programcode=c.programcode and b.SECTIONBRANCH=c.SECTIONBRANCH AND b.TAGGINGFOR=c.TAGGINGFOR ";
		qry+=" AND a.semester = b.semester and a.semester = c.semester And B.SubjectID = C.SubjectID ";
		qry+=" AND b.subjectid = '"+QrySubjID+"' AND a.subsectiontype = 'C'  AND B.SUBSECTIONCODE IS NOT NULL";
		qry+=" AND a.semestertype =  b.semestertype AND nvl(b.subjectrunning,'N')='Y'  ";
		qry+=" AND b.subjectid IN (SELECT d.subjectid FROM pr#departmentsubjecttagging d WHERE d.departmentcode = '"+QryDept+"' ";
		qry+=" AND d.sectionbranch = a.sectionbranch AND d.sectionbranch = b.sectionbranch)";
		qry+=" UNION ";
		qry+=" SELECT DISTINCT A.subsectioncode subsectioncode, a.academicyear academicyear, a.programcode, a.taggingfor,a.sectionbranch sectionbranch,";
		qry+=" a.semester, a.semestertype,(SELECT COUNT (*) FROM programsubsectiontagging c  ";
		qry+=" WHERE c.institutecode = '"+mInst+"' AND c.examcode = '"+QryExam+"' AND A.SUBSECTIONCODE IS NOT NULL";
		qry+=" AND c.semestertype =DECODE ('"+QrySemType+"','ALL', c.semestertype,'"+QrySemType+"') AND NVL (c.deactive, 'N') = 'N' ";
		qry+=" AND c.academicyear = a.academicyear AND c.programcode = a.programcode AND c.sectionbranch = a.sectionbranch ";
		qry+=" AND c.semester = a.semester AND c.institutecode = b.institutecode AND c.academicyear = b.academicyear AND c.subsectiontype = 'C') cnt ";
		qry+=" FROM programsubsectiontagging a, academicyearmaster b, ProgramSubjecttagging c WHERE a.institutecode = '"+mInst+"' and a.INSTITUTECODE=c.INSTITUTECODE ";
		qry+=" AND a.examcode = c.examcode AND c.basket = 'A' AND a.examcode = '"+QryExam+"' AND a.semestertype = DECODE ('"+QrySemType+"', 'ALL', a.semestertype, '"+QrySemType+"') AND NVL (a.deactive, 'N') = 'N' ";
		qry+=" AND a.academicyear = b.academicyear AND a.academicyear = c.academicyear AND a.programcode = c.programcode AND a.Semester = c.Semester and a.subsectiontype='C' AND NVL (b.currentyear, 'N') = 'Y'";
		qry+=" AND c.subjectid IN (SELECT d.subjectid FROM pr#departmentsubjecttagging d WHERE d.departmentcode='"+QryDept+"' AND d.sectionbranch = a.sectionbranch AND d.sectionbranch = a.sectionbranch)";
		qry+=" AND c.subjectid='"+QrySubjID+"'";
		qry+=" ORDER BY SECTIONBRANCH,ACADEMICYEAR,subsectioncode,PROGRAMCODE,TAGGINGFOR,SEMESTER,SEMESTERTYPE";
		//out.println(qry);
	}
	else if(mType.equals("E"))
	{
		qry="select distinct A.SUBSECTIONCODE subsectioncode, a.academicyear academicyear,";
		qry+="A.PROGRAMCODE,A.TAGGINGFOR,A.SECTIONBRANCH SECTIONBRANCH,A.SEMESTER, A.SEMESTERTYPE,";	
		qry+=" (Select count(*) from PROGRAMSUBSECTIONTAGGING C where C.institutecode='"+mInst+"' and C.examcode='"+QryExam+"' and ";
		qry+=" C.semestertype=decode('"+QrySemType+"','ALL',C.semestertype,'"+QrySemType+"') and nvl(C.deactive,'N')='N' and ";
		qry+=" C.ACADEMICYEAR=A.ACADEMICYEAR and C.PROGRAMCODE=A.PROGRAMCODE and C.SECTIONBRANCH=A.SECTIONBRANCH and";
		qry+=" C.SEMESTER=A.SEMESTER and C.SUBSECTIONTYPE='C' )cnt  from PROGRAMSUBSECTIONTAGGING A, ";
		qry+=" PR#ELECTIVESUBJECTS B where B.SUBJECTRUNNING='Y' and exists (SELECT 1 FROM pr#studentsubjectchoice C WHERE C.institutecode='"+mInst+"' AND C.EXAMCODE= '"+QryExam+"' AND c.semestertype = decode('"+QrySemType+"','ALL',C.semestertype,'"+QrySemType+"') AND NVL (c.deactive, 'N') = 'N' AND c.academicyear = a.academicyear AND c.programcode = a.programcode AND c.sectionbranch = a.sectionbranch AND c.semester = a.semester AND a.sectionbranch = b.sectionbranch AND c.subjectid = b.subjectid AND c.subjecttype = 'E') AND A.institutecode='"+mInst+"' and B.ELECTIVECODE='"+QryEleCode+"' AND A.examcode='"+QryExam+"' and ";
		qry+=" A.semestertype=decode('"+QrySemType+"','ALL',A.semestertype,'"+QrySemType+"') and nvl(A.deactive,'N')='N' and ";
		qry+=" A.ACADEMICYEAR=B.ACADEMICYEAR and A.PROGRAMCODE=B.PROGRAMCODE and A.EXAMCODE=B.EXAMCODE and A.SECTIONBRANCH=B.SECTIONBRANCH ";
		qry+=" AND A.SEMESTER=B.SEMESTER and B.SUBJECTID='"+QrySubjID+"' and A.SUBSECTIONTYPE='C' AND A.SUBSECTIONCODE IS NOT NULL";
		qry+=" and B.subjectid in (select D.subjectid from PR#DEPARTMENTSUBJECTTAGGING D ";
		qry+=" where  D.departmentcode ='"+QryDept+"'  and D.SECTIONBRANCH=A.SECTIONBRANCH and D.SECTIONBRANCH=B.SECTIONBRANCH) ";
		qry+=" UNION ";
		qry+=" SELECT DISTINCT A.subsectioncode subsectioncode, a.academicyear academicyear, a.programcode, a.taggingfor,a.sectionbranch sectionbranch,";
		qry+=" a.semester, a.semestertype,(SELECT COUNT (*) FROM programsubsectiontagging c  ";
		qry+=" WHERE c.institutecode = '"+mInst+"' AND c.examcode = '"+QryExam+"' AND A.SUBSECTIONCODE IS NOT NULL";
		qry+=" AND c.semestertype =DECODE ('"+QrySemType+"','ALL', c.semestertype,'"+QrySemType+"') AND NVL (c.deactive, 'N') = 'N' ";
		qry+=" AND c.academicyear = a.academicyear AND c.programcode = a.programcode AND c.sectionbranch = a.sectionbranch ";
		qry+=" AND c.semester = a.semester AND c.institutecode = b.institutecode AND c.academicyear = b.academicyear AND c.subsectiontype = 'C') cnt ";
		qry+=" FROM programsubsectiontagging a, academicyearmaster b, pr#electivesubjects c WHERE a.institutecode = '"+mInst+"' and a.INSTITUTECODE=c.INSTITUTECODE ";
		qry+=" AND a.examcode = c.examcode  AND a.examcode = '"+QryExam+"' AND a.semestertype = DECODE ('"+QrySemType+"', 'ALL', a.semestertype, '"+QrySemType+"') AND NVL (a.deactive, 'N') = 'N' ";
		qry+=" AND a.academicyear = b.academicyear AND a.academicyear = c.academicyear AND a.programcode = c.programcode AND a.Semester = c.Semester and a.subsectiontype='C' AND NVL (b.currentyear, 'N') = 'Y'";
		qry+=" AND c.subjectid IN (SELECT d.subjectid FROM pr#departmentsubjecttagging d WHERE d.departmentcode='"+QryDept+"' AND d.sectionbranch = a.sectionbranch AND d.sectionbranch = a.sectionbranch)";
		qry+=" AND c.subjectid='"+QrySubjID+"'";
		qry+=" ORDER BY SECTIONBRANCH,ACADEMICYEAR,subsectioncode,PROGRAMCODE,TAGGINGFOR,SEMESTER,SEMESTERTYPE";
		//out.print(qry);
	}
	
	rs1=db.getRowset(qry);
	ctr=0;
	String QryAcadYr="", TotAcadYr="", QryProgCode="", TotSemester="";
	while(rs1.next())
	{
		x++;
		mSeccount=rs1.getString("cnt");
		mSubsection=rs1.getString("subsectioncode");
		QryAcadYr=rs1.getString("academicyear");
		QryProgCode=rs1.getString("programcode");
		msno++;

		if(!mSection.equals(rs1.getString("SECTIONBRANCH")))
		{
			ctr=0;
			CTR++;
			//out.print(CTR);
			mSection=rs1.getString("SECTIONBRANCH");	
			mStudcnt="";
			int mStudCount=0;
			if(mType.equals("C"))
			{
				if(rs1.getString("semestertype").equals("REG"))
				{
					//out.println(rs1.getString("SECTIONBRANCH")+" "+mStudcnt);
				}
				else
				{
				}
			}		
			else if(mType.equals("E"))
			{
			}	
			%>
			<thead>
			<tr bgcolor=lightgrey>
			<td align="left"><B><%=mSection%></B></td>
			<td>&nbsp;</td>
			<td align=middle><B>&nbsp;</B></td>
			</tr>
			</thead>
			<%
			//out.print(mEmpIdv);
		}
		ctr++;
		mProgramcode=rs1.getString("PROGRAMCODE");
		%>
		<tbody>
		<tr>
		<td>&nbsp;</td>
		<td align="Left"><%=QryAcadYr%> - <%=mSubsection%>&nbsp;(<%=mProgramcode%>)</td> 
		<%
		qry="SELECT 'Y' FROM PR#HODLOADDISTRIBUTION WHERE INSTITUTECODE='"+mInst+"' AND COMPANYCODE='"+mComp+"' AND EXAMCODE='"+QryExam+"' AND ACADEMICYEAR='"+QryAcadYr+"' AND PROGRAMCODE='"+mProgramcode+"' AND TAGGINGFOR='"+rs1.getString("taggingfor")+"' AND SECTIONBRANCH='"+mSection+"' AND SUBSECTIONCODE='"+mSubsection+"' AND SEMESTER='"+rs1.getString("SEMESTER")+"' AND SEMESTERTYPE='"+QrySemType+"' AND BASKET='"+mBasket+"' AND SUBJECTID='"+QrySubjID+"' AND LTP='"+mLTP+"'";
		//out.print(qry);
		rs=db.getRowset(qry);
		if(rs.next())
		{
			%>
			<td align="center"><FONT Color=green face=verdana><B> Assigned </B></FONT></td>
			<%
		}
		else
		{
			%>
			<td align="center"><FONT Color=red face=verdana><B> Not Assigned </B></FONT></td>
			<%
		}
	} // closing of outer while
	%>
	</tbody>
	</table>
	</form>
	<%

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
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
}
catch(Exception e)
{
//	out.println(e);
}
%>
</body>
</html>