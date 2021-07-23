<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*,java.util.* ,java.math.* " %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
String  qrycase="",mAbsentc="",mMedicalc="",mUFMc="",mProdatac="",mDebarrc="";


int COUNTFI=0,RounDCount=0;
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT";
%>
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

<script language=javascript>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

<SCRIPT LANGUAGE="JavaScript">
<!--
function TextBoxValidation()
{
	var val=1;
//	if(document.frm.CHECKRADIO[0].checked==true)
//	{
		var a=document.frm.ZZ.value;
		//alert(a);
		a=parseInt(a);
		var arr=new Array();

		while(val<=a)
		{
			var ss='LOWERLIMIT'+val;
			
			arr[val]=document.frm[ss].value;
			if(arr[val]==0)
			{
				alert("Please insert the value greater than zero.");
				return false;
			}
			document.frm[ss].disabled=false;
			val++;
		}
		for(var x=1;x<=arr.length;x++)
		{	
		//	alert(x+'=='+arr.length);
			for(var z=x+1;z<=arr.length;z++)
			{
				//alert(arr[z]+'='+arr[x]);
				if(parseInt(arr[z])>parseInt(arr[x]))
				{
					//alert(arr[z]+'='+arr[x]);
					alert("Please insert the value in descending order greater than zero.");
				
					return false;
				}
			}
		}	
//	}

	return true;
}
/*
function LimitDisable()
{      
	var val=1;
	if(document.frm.CHECKRADIO[0].checked==true)
	{
		var a=document.frm.ZZ.value;
		var arr=new Array();
		while(val<=a)
		{
			var ss='LOWERLIMIT'+val;
			//alert(ss);
			document.frm[ss].disabled=false;
			val++;
		}
	}
	else
	{
		var a=document.frm.ZZ.value;
		alert(5);
		while(val<=a)
		{
			var ss='LOWERLIMIT'+val;
			//alert(ss);
			document.frm[ss].disabled=true;
			val++;
		}
	}
}
*/
function isNumber(e)
{
	var unicode=e.charCode? e.charCode : e.keyCode

	if (unicode!=8)
	{ //if the key isn't the backspace key (which we should allow)
		if ((unicode<48||unicode>57) && unicode!=46) //if not a number
		return false //disable key press
	}
}
//-->
</SCRIPT>

<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0  >
<%
try
{
GlobalFunctions gb =new GlobalFunctions();

OLTEncryption enc=new OLTEncryption();
DBHandler db=new DBHandler();
int mFlag=0;
String qry="",qryg="",qry1="";
ResultSet rs=null,rs1=null,rsss=null;


ResultSet   rscase=null;
String  mMemberID="",mMemberType="",mMemberName="",mMemberCode="",mFst="";
String mDMemberCode="",mDMemberType="",mInst="";
String mExamCode="";
int mSno=0;
String mName="";
String mSubjectCode="";
String mSubject="",mFstid="";
String mStudentname="";
int len=0,pos=0;
String qryfs="",qrysub="",qrym="";
ResultSet rsfs=null,rsg=null,rssub=null,rsm=null;
String mNameLower="";
String mGrad="",GML="";
String mInitialCount1="";
String mCheckRadio=""; 
int sno=0;
double mLowerLimit=0;
double 	GradeMasterTempLoWerLimit=0;
double GradeMasterLowerLimit=0;
// double GradeMasterTotalCount=0;
double mAVGPFinal=0;
double mAVGPFinal11=0;
double mAVGPNEW=0;
String mPrevValueNew1="";
String GradeMatserStudentIDChecked="",GradeMatserStudentIDInitial="";
String StudentGradeCalculationMarks1="",StudentGradeCalculationMarks2="";
//ArrayList GradeMatserStudentIDArray=new ArrayList();
//ArrayList  =new ArrayList();
Set GradeMatserStudentIDArray=new HashSet();
Set GradeMatserStudentIDArrayInit=new HashSet();
String mSem1="";
LinkedHashSet GradeMasterSet=new LinkedHashSet();

String mGrad1="";
String mWeigh="",mNam="";
double mMassCut=0;
String GradeMasterSetMerge="",mComp="";


String mDebarGrade="",mDebarWeight="",mDebarStudID="";

int mCount1=0;
int mCount2=0;

double mGlobalMean=0;
double mSumMark=0;
double mStudentMean=0;
double mStudentGradeCalculationMean=0;
double mStudentMeanSum=0;
double mDeviationwithoutround=0;
double mDeviation=0;
double HighGradeCalcLimit=0;
double LowGradeCalcLimit=0;
double mMin=0;
double mMax=0;
double mPrevValue=0;
double mPrevValueNew=0;
double Marksawarded2=0;
double mMarksawarded2=0;
double mLimit=0;
double mInitialCount=0;
double mAVGP=0;
double mInitialAVGP=0;
double mInitialAVGP11=0;
int ctr=0;
int mConsidered=0;
int Rejected=0,DRejected=0,DERejected=0;
String mValid="";
String qry2="",qry3="",qry4="";
String Studid="",mDetained="",GradeInitialCount="";
ResultSet rs2=null,rs3=null,rs4=null;
double StudentGradeCalculationMarksAwarded1=0;
double StudentGradeCalculationMarks=0;
//ArrayList StudentGradeCalculationStudentID=new ArrayList();
//ArrayList mGradeInitialCount=new ArrayList();
Set mGradeInitialCount=new HashSet();
String mCheckFstid="";
String mName111="";
String abc="";
String mETOD="";
int mYesNo=0;
String mChkYes="";
int mFlagy=0;
int ok=0;
int fault=0;
int mCheck=0;
String mName1="";
String ab="";
String mName11="",mChkYes1="";
int fs=0;
int fa=0;
int mSNO11=0;
int rr=0,tt=0,mtotStudent=0;
String mNameLower11="";
double abc1=0;
LinkedList Inorder=new LinkedList();
SortedSet Order=new TreeSet();
Double d1=null,dx1=null,dx2=null;
String mNameLower1="";
String mBoolean="";
double GradeMasterLowerLimit1=0;
int zz=0;
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



if (session.getAttribute("CompanyCode")==null)
{
 	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}
if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}

if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
	{
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
qry="Select WEBKIOSK.ShowLink('146','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
    RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{


if(request.getParameter("checkctr")==null)
	mCheck=0;
else
mCheck=Integer.parseInt(request.getParameter("checkctr").toString().trim());

if(request.getParameter("SNO")==null)
	mSNO11=0;
else
	mSNO11=Integer.parseInt(request.getParameter("SNO").toString().trim());

%>
 <form name="frm"  method="post" action="GradeCalculationAction.jsp" > 
<input id="x" name="x" type=hidden>
<input id="checkctr" name="checkctr" type=hidden value=<%=mCheck%>>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Grade Calculation</b></TD>
</font></td></tr>
</TABLE>    

<%
	int mSNO=0;
	if(request.getParameter("ExamCode")==null)
		mExamCode="";
	else
		mExamCode=request.getParameter("ExamCode").toString().trim();

	if(request.getParameter("Subject")==null)
		mSubjectCode="";
	else
		mSubjectCode=request.getParameter("Subject").toString().trim();

	if(request.getParameter("ETOD")==null)
		mETOD="";
	else
		mETOD=request.getParameter("ETOD").toString().trim();

	if(request.getParameter("SEMESTER")==null)
		mSem1="";
	else
		mSem1=request.getParameter("SEMESTER").toString().trim();

	
%>
	<INPUT TYPE=HIDDEN NAME=ETOD ID=ETOD VALUE="<%=mETOD%>">
	<input type="hidden" name="SEMESTER" id="SEMESTER" value="<%=mSem1%>">

<%
qrysub="select subject from subjectmaster where subjectID='"+mSubjectCode+"' and nvl(deactive,'N')='N' ";
rssub=db.getRowset(qrysub);
if(rssub.next())
		{
	mNam=rssub.getString("subject");
		}
		else
		{
		mNam="";
		}
if(request.getParameter("CHECKRADIO")==null)
		mCheckRadio="N";
	else
		mCheckRadio=request.getParameter("CHECKRADIO").toString().trim();

		if(mCheckRadio.equals("Y"))
		{
			if(request.getParameter("SNO")==null)
				mSNO=0;
			else
				mSNO=Integer.parseInt(request.getParameter("SNO").toString().trim());
		}
%>
	<input type=hidden name="ExamCode" id="ExamCode" value="<%=mExamCode%>"> 
	<input type=hidden name="Subject" id="Subject" value="<%=mSubjectCode%>"> 
	<input type=hidden name="ETOD" id="ETOD" value="<%=mETOD%>"> 
<%
	if(request.getParameter("jss")==null)
		mYesNo=0;
	else
		mYesNo=Integer.parseInt(request.getParameter("jss").toString().trim());

for(int y=1;y<=mYesNo;y++)
{
	mName="RADIO"+y;
	mChkYes=request.getParameter(mName).toString().trim();
	if(mChkYes.equals("Y"))
	{
		ok++;
	}
	else
	{
		fault++;
	}
}	



for(int yy=1;yy<=mCheck;yy++)
{
	mName111="FSTID"+yy;
	
	mChkYes1=request.getParameter(mName111);
	if(mChkYes1==null || mChkYes1.equals("") || mChkYes1.equals("null"))
//	if(mChkYes1==null || mChkYes1.equals(""))
	{
		fs++;
	}
	else
	{
		fa++;
	}
}	


if(fault==0 && fa>0)
{
	
for(int i=1;i<=mCheck;i++)
{
	
	mName1="FSTID"+i;

	ab=request.getParameter(mName1);
%>
<INPUT TYPE="hidden" NAME="<%=mName1%>" value="<%=ab%>">
<%
	/*
	if(ab!=null)
	{
		if(i==1)
		{
			mCheckFstid=" '"+ab+"' ";
		}
		else
		{
			mCheckFstid=mCheckFstid+", '"+ab+"' ";
		}
	}
	*/
	if(ab==null || ab.equals("null") || ab.equals(""))
	{
	}
	else
	{
		if(mCheckFstid.equals(""))
		{
			mCheckFstid=" '"+ab+"' ";
		}
		else
		{
			mCheckFstid=mCheckFstid+", '"+ab+"' ";
		}
	}
} // closing of for

/*
String aa[]=request.getParameterValues("CHECKFSTID");
for(int i=0;i<aa.length;i++)
{
	if(i==0)
	{
			mCheckFstid=" '"+aa[i]+"' ";
	}
	else
	{
		mCheckFstid=mCheckFstid+", '"+aa[i]+"' ";
	}
}
*/
	qryg="select 'y' from grademaster where institutecode='"+mInst+"' and examcode='"+mExamCode+"' and nvl(DEACTIVE,'N')='N' ";
	rsg=db.getRowset(qryg);
	if(rsg.next())
	{

qry="select count(distinct a.studentid)cnt,";
qry=qry+" ceil(sum((a.marksawarded2/a.maxmarks)*b.weightage) )SumMark ";
qry=qry+" from V#STUDENTEVENTSUBJECTMARKS a, ";
qry=qry+" V#EXAMEVENTSUBJECTTAGGING b where  ";
qry=qry+" a.fstid in("+mCheckFstid+") ";
qry=qry+" and (('"+mETOD+"'='N' and a.semestertype<>(select semestertype from semestertype where institutecode='"+mInst+"' ";
qry=qry+" and nvl(ETOD,'N')='Y'))  or ('"+mETOD+"'='E' and a.semestertype<>(select semestertype from semestertype where ";
qry=qry+" institutecode='"+mInst+"' and  nvl(ETOD,'N')='Y'))) ";
qry=qry+" and a.examcode='"+mExamCode+"' and a.examcode=b.examcode and a.eventsubevent=b.eventsubevent and ";
qry=qry+" a.studentid=b.studentid ";
qry=qry+" and a.subjectID='"+mSubjectCode+"'  and nvl(a.DEACTIVE,'N')='N' and ";
qry=qry+" nvl(a.LOCKED,'N')='Y' and a.subjectID=b.subjectID and nvl(a.DEACTIVE,'N')='N' ";
qry=qry+" and a.fstid=b.fstid ";
qry=qry+"    and a.STUDENTID not in (select c.studentid from DEBARSTUDENTDETAIL c where    C.EXAMCODE='"+mExamCode+"'  AND   c.subjectid ='"+mSubjectCode+"' and c.SUBJECTID=a.SUBJECTID   and c.INSTITUTECODE='"+mInst+"' AND C.INSTITUTECODE=A.INSTITUTECODE   AND A.STUDENTID=C.STUDENTID AND      NVL(C.PRORATA,'N')='N' AND (NVL(C.MEDICALCASE,'Y')='Y' OR  NVL(C.ABSENTCASE,'N')='N' OR NVL(C.UFM,'N')='N' ) AND  C.GRADE IS NOT NULL   ) ";
//qry=qry+" group by a.studentid, ";
//out.print(qry);
rs=db.getRowset(qry);
//out.print(qry+"");
if(rs.next())
{

	mCount1=rs.getInt("cnt");
	mSumMark=rs.getDouble("SumMark");

}
else
{
	mCount2=0;
}
//out.print(mCount1+"FGFG");
 

qry="select count(distinct a.studentid)cnt,";
qry=qry+" ceil(sum((a.marksawarded2/a.maxmarks)*b.weightage))SumMark ";
qry=qry+" from V#STUDENTEVENTSUBJECTMARKS a, ";
qry=qry+" V#EXAMEVENTSUBJECTTAGGING b where  ";
qry=qry+" a.fstid in("+mCheckFstid+") ";
qry=qry+" and (('"+mETOD+"'='N' and a.semestertype<>(select semestertype from semestertype where institutecode='"+mInst+"' ";
qry=qry+" and nvl(ETOD,'N')='Y'))  or ('"+mETOD+"'='E' and a.semestertype<>(select semestertype from semestertype where ";
qry=qry+" institutecode='"+mInst+"' and  nvl(ETOD,'N')='Y'))) ";
qry=qry+" and a.examcode='"+mExamCode+"' and a.examcode=b.examcode and a.eventsubevent=b.eventsubevent and ";
qry=qry+" a.studentid=b.studentid ";
qry=qry+" and a.subjectID='"+mSubjectCode+"'  and nvl(a.DEACTIVE,'N')='N' and ";
qry=qry+" nvl(a.LOCKED,'N')='Y' and a.subjectID=b.subjectID and nvl(a.DEACTIVE,'N')='N' ";
qry=qry+" and a.fstid=b.fstid ";
//out.print(qry);
rs=db.getRowset(qry);
if(rs.next())
{
mtotStudent=rs.getInt("cnt");
}



//FI Counr

qry2="select a.institutecode,a.ExamCode,a.Semester,a.semestertype,a.subjectID,a.studentid studentid,";
qry2=qry2+" a.enrollmentno,ceil(sum((a.marksawarded2/a.maxmarks)*b.weightage))marksawarded2, ";
qry2=qry2+" a.studentname,sum(b.weightage)weightage from V#STUDENTEVENTSUBJECTMARKS a, ";
qry2=qry2+" V#EXAMEVENTSUBJECTTAGGING b where  ";
qry2=qry2+" a.fstid in("+mCheckFstid+") ";
qry2=qry2+" and (('"+mETOD+"'='N' and a.semestertype<>(select semestertype from semestertype where institutecode='"+mInst+"' ";
qry2=qry2+" and nvl(ETOD,'N')='Y'))  or ('"+mETOD+"'='E' and a.semestertype<>(select semestertype from semestertype where ";
qry2=qry2+" institutecode='"+mInst+"' and nvl(ETOD,'N')='Y'))) ";
qry2=qry2+" and a.examcode='"+mExamCode+"' and a.examcode=b.examcode and a.eventsubevent=b.eventsubevent and ";
qry2=qry2+" a.studentid=b.studentid ";
qry2=qry2+" and a.subjectID='"+mSubjectCode+"'  and nvl(a.DEACTIVE,'N')='N' and ";
qry2=qry2+" nvl(a.LOCKED,'N')='Y' and a.subjectID=b.subjectID and nvl(a.DEACTIVE,'N')='N' ";
qry2=qry2+" and a.fstid=b.fstid ";
qry2=qry2+" group by a.institutecode,a.ExamCode,a.Semester,a.semestertype,a.subjectID,a.studentid, ";
qry2=qry2+" a.enrollmentno,a.studentname";
qry2=qry2+"  having (ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage) )<30 )  ";

qry2=qry2+" OR ( a.STUDENTID  in (select c.studentid from DEBARSTUDENTDETAIL c where    C.EXAMCODE='"+mExamCode+"'  AND   c.subjectid ='"+mSubjectCode+"' and c.SUBJECTID=a.SUBJECTID   and c.INSTITUTECODE='"+mInst+"' AND C.INSTITUTECODE=A.INSTITUTECODE   AND A.STUDENTID=C.STUDENTID  AND NVL(C.PRORATA,'N')='N'  AND  (NVL(C.MEDICALCASE,'Y')='Y' OR  NVL(C.ABSENTCASE,'N')='N' OR NVL(C.UFM,'N')='N' ) AND C.GRADE IS NOT NULL   ) ) ";
rs2=db.getRowset(qry2);
//out.print(qry2);
while(rs2.next())
{
	  COUNTFI++;
}
///out.print("NJKGSD"+mtotStudent+COUNTFI);













//

qry="select count(distinct studentid)cnt from V#EXAMEVENTSUBJECTTAGGING where ";
qry=qry+" fstid in("+mCheckFstid+") ";
qry=qry+" and subjectID='"+mSubjectCode+"'  and nvl(DEACTIVE,'N')='N' ";
rs=db.getRowset(qry);
//out.print("\nnext\n");
//out.print(qry);
if(rs.next())
{
	mCount2=rs.getInt("cnt");
}
else
{
	mCount2=0;
}

if(mtotStudent>0 && mCount2>0)
		{
if(mtotStudent==mCount2)
{
//String sname="";
String mySubjectCode="";
rsss=db.getRowset(qry);
qry="select subjectcode from subjectmaster where subjectid='" + mSubjectCode + "' and institutecode='"+mInst+"'";
rsss=db.getRowset(qry);
if(rsss.next())
{
	mySubjectCode=rsss.getString(1);
}
//out.print(mySubjectCode);
		
%>
<input id="CHECKFSTID" name="CHECKFSTID" type=hidden value=<%=mCheckFstid%>>
<br>
<TABLE ALIGN=CENTER rules=COLUMNS rules=groups WIDTH=76% CELLSPACING=0 BORDER=1>
<tr><td colspan=3><b>Co-ordinator Name/Member name : </b><font color=dark brownt><b><%=mMemberName%>&nbsp;(<%=mDMemberCode%>)</font></b></td></tr>
	<TR>
		<TD nowrap><b>Exam Code: </b><%=mExamCode%></TD>
		<TD nowrap><b>Subject: </b><%=mNam%>&nbsp(<%=mySubjectCode%>)</TD>
	</TR>
	</TABLE>
	<br>
<%

	mValid="Y";
	mGlobalMean=mSumMark/mCount1;
      mGlobalMean=gb.getRound(mGlobalMean,2);

//out.print(mGlobalMean+"mGlobalMean"+mSumMark+"mSumMark"+mCount1);
//***********************************************
qry2="select a.institutecode,a.ExamCode,a.Semester,a.semestertype,a.subjectID,a.studentid studentid,";
qry2=qry2+" a.enrollmentno,ceil(sum((a.marksawarded2/a.maxmarks)*b.weightage))marksawarded2, ";
qry2=qry2+" a.studentname,sum(b.weightage)weightage from V#STUDENTEVENTSUBJECTMARKS a, ";
qry2=qry2+" V#EXAMEVENTSUBJECTTAGGING b where  ";
qry2=qry2+" a.fstid in("+mCheckFstid+") ";
qry2=qry2+" and (('"+mETOD+"'='N' and a.semestertype<>(select semestertype from semestertype where institutecode='"+mInst+"' ";
qry2=qry2+" and nvl(ETOD,'N')='Y'))  or ('"+mETOD+"'='E' and a.semestertype<>(select semestertype from semestertype where ";
qry2=qry2+" institutecode='"+mInst+"' and nvl(ETOD,'N')='Y'))) ";
qry2=qry2+" and a.examcode='"+mExamCode+"' and a.examcode=b.examcode and a.eventsubevent=b.eventsubevent and ";
qry2=qry2+" a.studentid=b.studentid ";
qry2=qry2+" and a.subjectID='"+mSubjectCode+"'  and nvl(a.DEACTIVE,'N')='N' and ";
qry2=qry2+" nvl(a.LOCKED,'N')='Y' and a.subjectID=b.subjectID and nvl(a.DEACTIVE,'N')='N' ";
qry2=qry2+" and a.fstid=b.fstid ";
qry2=qry2+" group by a.institutecode,a.ExamCode,a.Semester,a.semestertype,a.subjectID,a.studentid, ";
qry2=qry2+" a.enrollmentno,a.studentname";
rs2=db.getRowset(qry2);
//out.print(qry2);
String sname="";
while(rs2.next())
{
		ctr=ctr++;

	mMarksawarded2=rs2.getDouble("marksawarded2");
	Studid=rs2.getString("studentid");




//debar students
	//int DRejected=0;
qry1=" select distinct NVL(A.GRADE,'N')GRADE from DEBARSTUDENTDETAIL a  WHERE a.EXAMCODE='"+mExamCode+"'   and a.INSTITUTECODE='"+mInst+"' and a.STUDENTID='"+Studid+"' AND A.SUBJECTID='"+mSubjectCode+"' and  NVL(A.PRORATA,'N')='N' AND nvl(a.DEACTIVE,'N')='N' AND (NVL(A.MEDICALCASE,'Y')='Y' OR  NVL(A.ABSENTCASE,'N')='N' OR NVL(A.UFM,'N')='N' ) AND A.GRADE IS NOT NULL ";
//out.print(qry1);
			rs1=db.getRowset(qry1);
			if(rs1.next())
			{
				DRejected++; 
				Rejected++;

				mDebarGrade=rs1.getString("GRADE");
				StudentGradeCalculationMarksAwarded1=mMarksawarded2;
			}
			else
			{
					mDebarGrade="N";
			StudentGradeCalculationMarksAwarded1=mMarksawarded2;
			}

//int DERejected=0;
	qry3="select DECODE(NVL(DETAINED,'N'),'D',1,'A',2,3),nvl(Detained,'N')Detained,enrollmentno  from V#STUDENTEVENTSUBJECTMARKS where institutecode='"+mInst+"' ";
	qry3=qry3+" and examcode='"+mExamCode+"' and subjectID='"+mSubjectCode+"' and ";
	qry3=qry3+" studentid='"+Studid+"' and nvl(LOCKED,'N')='Y' ";
	// qry3=qry3+" and nvl(DETAINED,'N')<>'N' and RowNum=1 ";
	qry3=qry3+" and nvl(DETAINED,'N') in ('D','A','M') ORDER BY 1";
//out.print("Detained"+qry3);
	rs3=db.getRowset(qry3);
	
	if(rs3.next())
		{



			mDetained=rs3.getString("Detained");
			/*
			mDetained=mDetained+rs3.getString(2);
		//out.print(mDetained+"=="+mDetained+"<br>");
			mDetained=rs3.getString("Detained");
			*/





			if(mDetained.equals("D"))
			{
				//Rejected++; 
				DERejected++;
//out.print("rer"+Rejected);

				StudentGradeCalculationMarksAwarded1=mMarksawarded2;
			}
			else 
			{ 
				if(mDetained.equals("A"))
				{
				StudentGradeCalculationMarksAwarded1=mMarksawarded2;
				}
			}
			if(mDetained.equals("M"))
			{
					qry4="select ParameterValue from Parameters where CompanyCode='JIIT' ";
					qry4=qry4+" and ModuleName='SIS' and ParameterID='C1.3' and ";
					qry4=qry4+" RowNum=1 ";
					rs4=db.getRowset(qry4);
					if(rs4.next())
					{
						mLimit=rs4.getDouble(1);
				
						if(mMarksawarded2>mLimit)
						{
							mLimit=mLimit;
						}
						else
						{
							mLimit=mMarksawarded2;
						}
					} // closing of rs4
					else
					{	
						mLimit=mMarksawarded2;
					}	

					StudentGradeCalculationMarksAwarded1=mLimit;

			}  // closing of mDeatined 'M'
		} // CLOSING OF IF 
		else
		{



			mDetained="N";
			StudentGradeCalculationMarksAwarded1=mMarksawarded2;
			
		}
//- -------------------------Masscuts
//-----StudentGradeCalculationMarks=StudentGradeCalculationMarksAwarded1-MassCuts;
//*****StudentGradeCalculationMarks=StudentGradeCalculationMarksAwarded1-0;
// *****************************************

	mStudentMean=mGlobalMean-StudentGradeCalculationMarksAwarded1;
	mStudentMeanSum=mStudentMean*mStudentMean;
	mStudentGradeCalculationMean=mStudentGradeCalculationMean+mStudentMeanSum;
	

	
//out.print(mStudentMean+":mStudentMean:"+"<BR>"+mStudentMeanSum+":mStudentMeanSum:"+":mStudentGradeCalculationMean:"+mStudentGradeCalculationMean+"<BR>");




} // closing of while rs2

//********** General Information Deviation*********************

	 mDeviationwithoutround=Math.sqrt(mStudentGradeCalculationMean/(mCount1-1));
	 mDeviation=gb.getRound(mDeviationwithoutround,2);

//out.print(mDeviationwithoutround+"mDeviationwithoutround"+mDeviation+"mDeviation"+"<BR>");
%>  
	<TABLE ALIGN=CENTER rules=COLUMNS WIDTH=76% CELLSPACING=0 BORDER=1>
	<TR>
		<TD ALIGN=CENTER><b>Grade<B></TD>
		<TD ALIGN=CENTER><b>Suggested Range<B></TD>
		<TD ALIGN=CENTER><b>Initial Boundary <B></TD>
		<TD ALIGN=CENTER><b>Initial Count<B></TD>
		<TD ALIGN=CENTER><b>Revised Boundary <B></TD>
		
		<TD ALIGN=CENTER><b>Revised Count<B></TD>
	</TR>
	<%
//*******to check the order of insserted values in selected lower limit
//out.print(mSNO+"mSNO");
for(int aaa=1;aaa<=mSNO;aaa++)
	{
		mNameLower1="LOWERLIMIT"+aaa;
		if(mCheckRadio.equals("Y"))
		{
			try{
			if(request.getParameter(mNameLower1)==null || request.getParameter(mNameLower1).equals(""))
			{
				GradeMasterLowerLimit1=0;
			}
			else
			{
				GradeMasterLowerLimit1=Double.parseDouble(request.getParameter(mNameLower1).toString().trim());
			}
			}
			catch(Exception e)
		{}
if(GradeMasterLowerLimit1!=0.0)
			{
		//	out.print(GradeMasterLowerLimit1+"<br>");
			 d1=new Double(GradeMasterLowerLimit1);
			Inorder.addFirst(d1);
			Order.add(d1);
			}
		}
	}

Iterator i11 = Order.iterator();
Iterator i21 = Inorder.iterator();
while(i11.hasNext() && i21.hasNext())
{
	//out.print(i11.next());
	dx1=(Double)i11.next();
	dx2=(Double)i21.next();

	//if(fx1!=k && fx2!=k )
	//{
			//out.print(dx1+"dx1"+dx2+"<br>");
	

	if(dx1!=dx2)
	{
		mCheckRadio="N";
		mBoolean="G";
	}
	
	//}
}


int mTOT=mtotStudent - Rejected ;
//out.print("Mohit"+mTOT);
double Acount=0,B_count=0,Bcount=0;
double  Per10=0,mC10=0 ,Count10=0;
int Marks10=0 ;

int mB20=0,mCalValue=0;
int MarksB20=0;
double CountB20=0;
int PerB20=0;


int MarksB25=0,PerB25=0;
double CountB25=0;


int MarksC25=0,PerC25=0;
double CountC25=0;


int MarksC15=0,PerC15=0;
double CountC15=0;


int MarksD5=0,PerD5=0;
double CountD5=0;

int Marks80=0,Marks30=0,PerMedical=0,MarksMedical=0;

int CountA10=0,CountB220=0,CountB225=0,CountC225=0,CountC115=0,Per80=0,Per30=0,CountD15=0;

	//qry1="select distinct GRADEPOINTS,GRADE,nvl(HIGHGRADECALCLIMIT,0)HIGHGRADECALCLIMIT,nvl(LOWGRADECALCLIMIT,0)LOWGRADECALCLIMIT from grademaster where institutecode='"+mInst+"' and examcode='"+mExamCode+"' and nvl(DEACTIVE,'N')='N' and  HIGHGRADECALCLIMIT is not null and nvl(HIDEINGRADESHEET,'N')='N'  order by GRADE";

	qry1="SELECT DISTINCT gradepoints, grade,     CALCULATIONTYPE, CALCULATIONVALUE                          FROM grademaster          WHERE institutecode = '"+mInst+"'          AND examcode = '"+mExamCode+"'                       AND NVL (deactive, 'N') = 'N'                                     and CALCULATIONTYPE is not null       ORDER BY gradepoints desc";
	//out.print(qry1);
	rs1=db.getRowset(qry1);
	while(rs1.next())
	{

		mCalValue=rs1.getInt("CALCULATIONVALUE");
		
		sno++;
double mRecommendedTo=0;
double mRecommendedFrom=0;
double InitialCount=0;
int GradeMasterTotalCount=0;
//mInitialCount=0;
mGrad=rs1.getString("GRADE");

if(mPrevValue==0)
	mPrevValue=1000;
else
	mPrevValue=mInitialCount;

//out.print(mInitialCount+"mInitialCount"+mPrevValue);
	//	LowGradeCalcLimit=rs1.getDouble("LOWGRADECALCLIMIT");
	//	HighGradeCalcLimit=rs1.getDouble("HIGHGRADECALCLIMIT");
		mNameLower="LOWERLIMIT"+sno;
		if(mCheckRadio.equals("Y"))
		{
			try
			{

			if(request.getParameter(mNameLower)==null || request.getParameter(mNameLower).equals(""))
			{
				GradeMasterLowerLimit=0;
			}
			else
			{
				GradeMasterLowerLimit=Double.parseDouble(request.getParameter(mNameLower).toString().trim());
			}
		}
			catch(Exception e)
		{}
			GradeMasterTempLoWerLimit=GradeMasterLowerLimit;
		
			if(mPrevValueNew==0)
			{
				mPrevValueNew=1000;
			}
				GradeMasterTotalCount=0;
		} 

	
	
	
	
	
	%>
	
		<TR>
		
		
		<TD ALIGN=left><%=rs1.getString("GRADE")%></TD>

<TD ALIGN=center>
<%
	if(rs1.getString("GRADE").equals("A+"))
		{

out.print(""+mCalValue); 

	}

	if(rs1.getString("GRADE").equals("A"))
		{

out.print("Top-"+mCalValue); 

	}
if(rs1.getString("GRADE").equals("B+"))
		{

out.print("Next-"+mCalValue); 

	}

	if(rs1.getString("GRADE").equals("B"))
		{

out.print("Next-"+mCalValue); 

	}

	if(rs1.getString("GRADE").equals("C+"))
		{

out.print("Next-"+mCalValue); 

	}
	if(rs1.getString("GRADE").equals("C"))
		{

out.print("Next-"+mCalValue); 

	}
if(rs1.getString("GRADE").equals("D"))
		{

out.print("Remaining"); 

	}

if(rs1.getString("GRADE").equals("F"))
		{

out.print("29"); 

	}


if(rs1.getString("GRADE").equals("I"))
		{

out.print("-"); 

	}


if(rs1.getString("GRADE").equals("X"))
		{

out.print("-"); 

	}


%>
</TD>



<%
if(rs1.getString("CALCULATIONTYPE").equals("F") && rs1.getString("GRADE").equals("A+") )
		{
qry2="select a.institutecode,a.ExamCode,a.Semester,a.semestertype,a.subjectID,a.studentid studentid,";
qry2=qry2+" a.enrollmentno,ceil(sum((a.marksawarded2/a.maxmarks)*b.weightage))marksawarded2, ";
qry2=qry2+" a.studentname,sum(b.weightage)weightage from V#STUDENTEVENTSUBJECTMARKS a, ";
qry2=qry2+" V#EXAMEVENTSUBJECTTAGGING b where  ";
qry2=qry2+" a.fstid in("+mCheckFstid+") ";
qry2=qry2+" and (('"+mETOD+"'='N' and a.semestertype<>(select semestertype from semestertype where institutecode='"+mInst+"' ";
qry2=qry2+" and nvl(ETOD,'N')='Y'))  or ('"+mETOD+"'='E' and a.semestertype<>(select semestertype from semestertype where ";
qry2=qry2+" institutecode='"+mInst+"' and nvl(ETOD,'N')='Y'))) ";
qry2=qry2+" and a.examcode='"+mExamCode+"' and a.examcode=b.examcode and a.eventsubevent=b.eventsubevent and ";
qry2=qry2+" a.studentid=b.studentid ";
qry2=qry2+" and a.subjectID='"+mSubjectCode+"'  and nvl(a.DEACTIVE,'N')='N' and ";
qry2=qry2+" nvl(a.LOCKED,'N')='Y' and a.subjectID=b.subjectID and nvl(a.DEACTIVE,'N')='N' ";
qry2=qry2+" and a.fstid=b.fstid ";
//qry2=qry2+" and a.STUDENTID not in (select c.studentid from DEBARSTUDENTDETAIL c where    C.EXAMCODE='"+mExamCode+"'  AND   c.subjectid ='"+mSubjectCode+"' and c.SUBJECTID=a.SUBJECTID   and c.INSTITUTECODE='"+mInst+"' AND C.INSTITUTECODE=A.INSTITUTECODE   AND A.STUDENTID=C.STUDENTID AND NVL(C.PRORATA,'N')='N' AND    (NVL(C.MEDICALCASE,'Y')='Y' OR  NVL(C.ABSENTCASE,'N')='N' OR NVL(C.UFM,'N')='N' )  AND C.GRADE IS NOT NULL   ) ";
qry2=qry2+" AND a.studentid NOT IN (    SELECT c.studentid    FROM debarstudentdetail c      WHERE c.examcode = '"+mExamCode+"'      AND c.subjectid = '"+mSubjectCode+"'     AND c.subjectid = a.subjectid      AND c.institutecode = '"+mInst+"'     AND c.institutecode = a.institutecode                         AND a.studentid = c.studentid    AND c.grade IS NOT NULL     And c.grade in ('F','I','X')) ";
qry2=qry2+" group by a.institutecode,a.ExamCode,a.Semester,a.semestertype,a.subjectID,a.studentid, ";
qry2=qry2+" a.enrollmentno,a.studentname";
qry2=qry2+"  having ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage) )>=80   ";
rs2=db.getRowset(qry2);
//out.print(qry2);
while(rs2.next())
{
	  Per80++;
}
Marks80=80;

//out.print("NJKGSD"+mtotStudent+"LKSHAJKLFH"+COUNTFI+"GSDHGS"+Per80);
%>


<TD ALIGN=CENTER><%=Marks80%></td>
<TD ALIGN=CENTER><%=Per80%></td>
<%
//	out.print(Marks80+"LL"+Per80);

mInitialCount=Marks80;

		}

//out.print("NJKGSD"+mtotStudent+"LKSHAJKLFH"+COUNTFI+"GSDHGS"+Per80);

double  mTotalcalculation=((mtotStudent)-(COUNTFI+Per80)) ;
 Count10=  mTotalcalculation*mCalValue/100;
 Count10=Math.round(Count10);

//BigDecimal d=new BigDecimal(Count10);
     //   d=d.setScale(0, BigDecimal.ROUND_HALF_UP);
       



//out.print("COUNT CACU"+d);

if(rs1.getString("CALCULATIONTYPE").equals("P") && rs1.getString("GRADE").equals("A") )
		{
//MARKS CALCULATION 

qry2="SELECT    institutecode, examcode, semester, semestertype,subjectid,         studentid , enrollmentno,        marksawarded2,         studentname, weightage FROM (         SELECT    a.institutecode, a.examcode, a.semester, a.semestertype, a.subjectid,         a.studentid studentid, a.enrollmentno,         ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)               ) marksawarded2,         a.studentname, SUM (b.weightage) weightage    FROM v#studenteventsubjectmarks a, v#exameventsubjecttagging b   WHERE  a.fstid in("+mCheckFstid+")     AND (   (    'N' = 'N'              AND a.semestertype <>                      (SELECT semestertype                         FROM semestertype                        WHERE institutecode = '"+mInst+"'  AND NVL (etod, 'N') = 'Y')             )          OR (    'N' = 'E'              AND a.semestertype <>                      (SELECT semestertype                         FROM semestertype                        WHERE institutecode ='"+mInst+"'  AND NVL (etod, 'N') = 'Y')             )         )     AND a.examcode ='"+mExamCode+"'     AND a.examcode = b.examcode     AND a.eventsubevent = b.eventsubevent     AND a.studentid = b.studentid     AND a.subjectid = '"+mSubjectCode+"'      AND NVL (a.deactive, 'N') = 'N'     AND NVL (a.LOCKED, 'N') = 'Y'     AND a.subjectid = b.subjectid     AND NVL (a.deactive, 'N') = 'N'    AND a.fstid = b.fstid   ";
qry2=qry2+" GROUP BY a.institutecode,         a.examcode,         a.semester,         a.semestertype,         a.subjectid,         a.studentid,         a.enrollmentno,         a.studentname  HAVING ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)) < 80     AND ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)) >= 30     ORDER BY marksawarded2 DESC) WHERE ROWNUM<= "+Count10+" ORDER BY marksawarded2";
rs2=db.getRowset(qry2);

while(rs2.next())
{
 Per10++;
	
	if(Per10==1)
	Marks10=rs2.getInt("marksawarded2")	;
}
 
//out.print(Count10+"lkhgdfhgjkdfgyhdfiogy");

//iNTIAL COUNT 
qry="SELECT    institutecode, examcode, semester, semestertype,subjectid,         studentid , enrollmentno,        marksawarded2,         studentname, weightage FROM (         SELECT    a.institutecode, a.examcode, a.semester, a.semestertype, a.subjectid,         a.studentid studentid, a.enrollmentno,         ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)             ) marksawarded2,         a.studentname, SUM (b.weightage) weightage    FROM v#studenteventsubjectmarks a, v#exameventsubjecttagging b   WHERE  a.fstid in("+mCheckFstid+")     AND (   (    'N' = 'N'              AND a.semestertype <>                      (SELECT semestertype                         FROM semestertype                        WHERE institutecode = '"+mInst+"'  AND NVL (etod, 'N') = 'Y')             )          OR (    'N' = 'E'              AND a.semestertype <>                      (SELECT semestertype                         FROM semestertype                        WHERE institutecode ='"+mInst+"'  AND NVL (etod, 'N') = 'Y')             )         )     AND a.examcode ='"+mExamCode+"'     AND a.examcode = b.examcode     AND a.eventsubevent = b.eventsubevent     AND a.studentid = b.studentid     AND a.subjectid = '"+mSubjectCode+"'      AND NVL (a.deactive, 'N') = 'N'     AND NVL (a.LOCKED, 'N') = 'Y'     AND a.subjectid = b.subjectid     AND NVL (a.deactive, 'N') = 'N'    AND a.fstid = b.fstid  ";


//qry=qry+" and a.STUDENTID not in (select c.studentid from DEBARSTUDENTDETAIL c where    C.EXAMCODE='"+mExamCode+"'  AND   c.subjectid ='"+mSubjectCode+"' and c.SUBJECTID=a.SUBJECTID   and c.INSTITUTECODE='"+mInst+"' AND C.INSTITUTECODE=A.INSTITUTECODE   AND A.STUDENTID=C.STUDENTID AND NVL(C.PRORATA,'N')='N' AND    (NVL(C.MEDICALCASE,'Y')='Y' OR  NVL(C.ABSENTCASE,'N')='N' OR NVL(C.UFM,'N')='N' )  AND C.GRADE IS NOT NULL   ) ";

qry=qry+" AND a.studentid NOT IN (    SELECT c.studentid    FROM debarstudentdetail c      WHERE c.examcode = '"+mExamCode+"'      AND c.subjectid = '"+mSubjectCode+"'     AND c.subjectid = a.subjectid      AND c.institutecode = '"+mInst+"'     AND c.institutecode = a.institutecode                         AND a.studentid = c.studentid    AND c.grade IS NOT NULL     And c.grade in ('F','I','X')) ";



qry=qry+" GROUP BY a.institutecode,         a.examcode,         a.semester,         a.semestertype,         a.subjectid,         a.studentid,         a.enrollmentno,         a.studentname  HAVING ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)) < 80     AND ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)) > 30     AND ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)) >= "+Marks10+" AND ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)) < "+Marks80+"   ORDER BY marksawarded2 DESC) ORDER BY marksawarded2   ";
//out.print(qry);
rs=db.getRowset(qry);
while(rs.next())
			{
CountA10++;
			}
%>
<TD ALIGN=CENTER> <%=Marks10%></td>
<TD ALIGN=CENTER><%=CountA10%>

</td>
<%
	
mInitialCount=Marks10;

		}



if(rs1.getString("CALCULATIONTYPE").equals("P") && rs1.getString("GRADE").equals("B+") )
		{/*
qry2="select a.institutecode,a.ExamCode,a.Semester,a.semestertype,a.subjectID,a.studentid studentid,";
qry2=qry2+" a.enrollmentno,round(sum((a.marksawarded2/a.maxmarks)*b.weightage),2)marksawarded2, ";
qry2=qry2+" a.studentname,sum(b.weightage)weightage from V#STUDENTEVENTSUBJECTMARKS a, ";
qry2=qry2+" V#EXAMEVENTSUBJECTTAGGING b where  ";
qry2=qry2+" a.fstid in("+mCheckFstid+") ";
qry2=qry2+" and (('"+mETOD+"'='N' and a.semestertype<>(select semestertype from semestertype where institutecode='"+mInst+"' ";
qry2=qry2+" and nvl(ETOD,'N')='Y'))  or ('"+mETOD+"'='E' and a.semestertype<>(select semestertype from semestertype where ";
qry2=qry2+" institutecode='"+mInst+"' and nvl(ETOD,'N')='Y'))) ";
qry2=qry2+" and a.examcode='"+mExamCode+"' and a.examcode=b.examcode and a.eventsubevent=b.eventsubevent and ";
qry2=qry2+" a.studentid=b.studentid ";
qry2=qry2+" and a.subjectID='"+mSubjectCode+"'  and nvl(a.DEACTIVE,'N')='N' and ";
qry2=qry2+" nvl(a.LOCKED,'N')='Y' and a.subjectID=b.subjectID and nvl(a.DEACTIVE,'N')='N' ";
qry2=qry2+" and a.fstid=b.fstid ";
qry2=qry2+" group by a.institutecode,a.ExamCode,a.Semester,a.semestertype,a.subjectID,a.studentid, ";
qry2=qry2+" a.enrollmentno,a.studentname";
qry2=qry2+"   having ROUND (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage), 2 )<80 and        ROUND (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage), 2 ) >30   and   ROUND (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage), 2 ) < "+Marks10+"       order by marksawarded2 desc      ";*/

  CountB20=  mTotalcalculation*mCalValue/100;

CountB20=Math.round(CountB20);


//marks count

qry2="SELECT    institutecode, examcode, semester, semestertype,subjectid,         studentid , enrollmentno,        marksawarded2,         studentname, weightage FROM (         SELECT    a.institutecode, a.examcode, a.semester, a.semestertype, a.subjectid,         a.studentid studentid, a.enrollmentno,         ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)               ) marksawarded2,         a.studentname, SUM (b.weightage) weightage    FROM v#studenteventsubjectmarks a, v#exameventsubjecttagging b   WHERE  a.fstid in("+mCheckFstid+")     AND (   (    'N' = 'N'              AND a.semestertype <>                      (SELECT semestertype                         FROM semestertype                        WHERE institutecode = '"+mInst+"'  AND NVL (etod, 'N') = 'Y')             )          OR (    'N' = 'E'              AND a.semestertype <>                      (SELECT semestertype                         FROM semestertype                        WHERE institutecode ='"+mInst+"'  AND NVL (etod, 'N') = 'Y')             )         )     AND a.examcode ='"+mExamCode+"'     AND a.examcode = b.examcode     AND a.eventsubevent = b.eventsubevent     AND a.studentid = b.studentid     AND a.subjectid = '"+mSubjectCode+"'      AND NVL (a.deactive, 'N') = 'N'     AND NVL (a.LOCKED, 'N') = 'Y'     AND a.subjectid = b.subjectid     AND NVL (a.deactive, 'N') = 'N'    AND a.fstid = b.fstid   ";
qry2=qry2+" GROUP BY a.institutecode,         a.examcode,         a.semester,         a.semestertype,         a.subjectid,         a.studentid,         a.enrollmentno,         a.studentname  HAVING ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)) < 80     AND ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)) > 30   and   ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage) ) < "+Marks10+" ORDER BY marksawarded2 DESC) WHERE ROWNUM<= "+CountB20+" ORDER BY marksawarded2";
rs2=db.getRowset(qry2);
//out.print(qry2);
while(rs2.next())
{
	PerB20++;
	
	if(PerB20==1)
	MarksB20=rs2.getInt("marksawarded2")	;
	
}

  //out.print(Per10*mCalValue/100);

  //initial count
qry="SELECT    institutecode, examcode, semester, semestertype,subjectid,         studentid , enrollmentno,        marksawarded2,         studentname, weightage FROM (         SELECT    a.institutecode, a.examcode, a.semester, a.semestertype, a.subjectid,         a.studentid studentid, a.enrollmentno,         ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)               ) marksawarded2,         a.studentname, SUM (b.weightage) weightage    FROM v#studenteventsubjectmarks a, v#exameventsubjecttagging b   WHERE  a.fstid in("+mCheckFstid+")     AND (   (    'N' = 'N'              AND a.semestertype <>                      (SELECT semestertype                         FROM semestertype                        WHERE institutecode = '"+mInst+"'  AND NVL (etod, 'N') = 'Y')             )          OR (    'N' = 'E'              AND a.semestertype <>                      (SELECT semestertype                         FROM semestertype                        WHERE institutecode ='"+mInst+"'  AND NVL (etod, 'N') = 'Y')             )         )     AND a.examcode ='"+mExamCode+"'     AND a.examcode = b.examcode     AND a.eventsubevent = b.eventsubevent     AND a.studentid = b.studentid     AND a.subjectid = '"+mSubjectCode+"'      AND NVL (a.deactive, 'N') = 'N'     AND NVL (a.LOCKED, 'N') = 'Y'     AND a.subjectid = b.subjectid     AND NVL (a.deactive, 'N') = 'N'    AND a.fstid = b.fstid  ";

	//qry=qry+" and a.STUDENTID not in (select c.studentid from DEBARSTUDENTDETAIL c where    C.EXAMCODE='"+mExamCode+"'  AND   c.subjectid ='"+mSubjectCode+"' and c.SUBJECTID=a.SUBJECTID   and c.INSTITUTECODE='"+mInst+"' AND C.INSTITUTECODE=A.INSTITUTECODE   AND A.STUDENTID=C.STUDENTID AND NVL(C.PRORATA,'N')='N' AND    (NVL(C.MEDICALCASE,'Y')='Y' OR  NVL(C.ABSENTCASE,'N')='N' OR NVL(C.UFM,'N')='N' )  AND C.GRADE IS NOT NULL   ) ";


qry=qry+" AND a.studentid NOT IN (    SELECT c.studentid    FROM debarstudentdetail c      WHERE c.examcode = '"+mExamCode+"'      AND c.subjectid = '"+mSubjectCode+"'     AND c.subjectid = a.subjectid      AND c.institutecode = '"+mInst+"'     AND c.institutecode = a.institutecode                         AND a.studentid = c.studentid    AND c.grade IS NOT NULL     And c.grade in ('F','I','X')) ";



qry=qry+" GROUP BY a.institutecode,         a.examcode,         a.semester,         a.semestertype,         a.subjectid,         a.studentid,         a.enrollmentno,         a.studentname  HAVING ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)) < 80     AND ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)) > 30     AND ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage) ) >= "+MarksB20+" AND ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage) ) < "+Marks10+" ORDER BY marksawarded2 DESC) ORDER BY marksawarded2";
//out.print(qry);
rs=db.getRowset(qry);
while(rs.next())
			{
CountB220++;
			}
%>
<TD ALIGN=CENTER>  <%=MarksB20%></td>
<td ALIGN=CENTER><%=CountB220%> 
</td>

<%
	
mInitialCount=MarksB20;
		}

if(rs1.getString("CALCULATIONTYPE").equals("P") && rs1.getString("GRADE").equals("B") )
		{
	

  CountB25=  mTotalcalculation*mCalValue/100;
  	//out.print(mTotalcalculation+"fsdfsd"+mCalValue+"hghfgsdf"+CountB25);  
	  CountB25=Math.round(CountB25);


qry2="SELECT    institutecode, examcode, semester, semestertype,subjectid,         studentid , enrollmentno,        marksawarded2,         studentname, weightage FROM (         SELECT    a.institutecode, a.examcode, a.semester, a.semestertype, a.subjectid,         a.studentid studentid, a.enrollmentno,         ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)                ) marksawarded2,         a.studentname, SUM (b.weightage) weightage    FROM v#studenteventsubjectmarks a, v#exameventsubjecttagging b   WHERE  a.fstid in("+mCheckFstid+")     AND (   (    'N' = 'N'              AND a.semestertype <>                      (SELECT semestertype                         FROM semestertype                        WHERE institutecode = '"+mInst+"'  AND NVL (etod, 'N') = 'Y')             )          OR (    'N' = 'E'              AND a.semestertype <>                      (SELECT semestertype                         FROM semestertype                        WHERE institutecode ='"+mInst+"'  AND NVL (etod, 'N') = 'Y')             )         )     AND a.examcode ='"+mExamCode+"'     AND a.examcode = b.examcode     AND a.eventsubevent = b.eventsubevent     AND a.studentid = b.studentid     AND a.subjectid = '"+mSubjectCode+"'      AND NVL (a.deactive, 'N') = 'N'     AND NVL (a.LOCKED, 'N') = 'Y'     AND a.subjectid = b.subjectid     AND NVL (a.deactive, 'N') = 'N'    AND a.fstid = b.fstid    ";


qry2=qry2+"GROUP BY a.institutecode,         a.examcode,         a.semester,         a.semestertype,         a.subjectid,         a.studentid,         a.enrollmentno,         a.studentname  HAVING ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage) ) < 80     AND ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)  ) > 30   and   ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)  ) < "+MarksB20+" ORDER BY marksawarded2 DESC) WHERE ROWNUM<= "+CountB25+" ORDER BY marksawarded2";

rs2=db.getRowset(qry2);
//out.print(qry2);
while(rs2.next())
{
	PerB25++;
	
	if(PerB25==1)
	MarksB25=rs2.getInt("marksawarded2")	;
	
}




qry="SELECT    institutecode, examcode, semester, semestertype,subjectid,         studentid , enrollmentno,        marksawarded2,         studentname, weightage FROM (         SELECT    a.institutecode, a.examcode, a.semester, a.semestertype, a.subjectid,         a.studentid studentid, a.enrollmentno,         ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)               ) marksawarded2,         a.studentname, SUM (b.weightage) weightage    FROM v#studenteventsubjectmarks a, v#exameventsubjecttagging b   WHERE  a.fstid in("+mCheckFstid+")     AND (   (    'N' = 'N'              AND a.semestertype <>                      (SELECT semestertype                         FROM semestertype                        WHERE institutecode = '"+mInst+"'  AND NVL (etod, 'N') = 'Y')             )          OR (    'N' = 'E'              AND a.semestertype <>                      (SELECT semestertype                         FROM semestertype                        WHERE institutecode ='"+mInst+"'  AND NVL (etod, 'N') = 'Y')             )         )     AND a.examcode ='"+mExamCode+"'     AND a.examcode = b.examcode     AND a.eventsubevent = b.eventsubevent     AND a.studentid = b.studentid     AND a.subjectid = '"+mSubjectCode+"'      AND NVL (a.deactive, 'N') = 'N'     AND NVL (a.LOCKED, 'N') = 'Y'     AND a.subjectid = b.subjectid     AND NVL (a.deactive, 'N') = 'N'    AND a.fstid = b.fstid  ";


	//qry=qry+" and a.STUDENTID not in (select c.studentid from DEBARSTUDENTDETAIL c where    C.EXAMCODE='"+mExamCode+"'  AND   c.subjectid ='"+mSubjectCode+"' and c.SUBJECTID=a.SUBJECTID   and c.INSTITUTECODE='"+mInst+"' AND C.INSTITUTECODE=A.INSTITUTECODE   AND A.STUDENTID=C.STUDENTID AND NVL(C.PRORATA,'N')='N' AND    (NVL(C.MEDICALCASE,'Y')='Y' OR  NVL(C.ABSENTCASE,'N')='N' OR NVL(C.UFM,'N')='N' )  AND C.GRADE IS NOT NULL   ) ";



qry=qry+" AND a.studentid NOT IN (    SELECT c.studentid    FROM debarstudentdetail c      WHERE c.examcode = '"+mExamCode+"'      AND c.subjectid = '"+mSubjectCode+"'     AND c.subjectid = a.subjectid      AND c.institutecode = '"+mInst+"'     AND c.institutecode = a.institutecode                         AND a.studentid = c.studentid    AND c.grade IS NOT NULL     And c.grade in ('F','I','X')) ";


qry=qry+" GROUP BY a.institutecode,         a.examcode,         a.semester,         a.semestertype,         a.subjectid,         a.studentid,         a.enrollmentno,         a.studentname  HAVING ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage) ) < 80     AND ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage) ) > 30     AND ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage) ) >= "+MarksB25+" AND ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage) ) < "+MarksB20+" ORDER BY marksawarded2 DESC) ORDER BY marksawarded2";
//out.print(qry);
rs=db.getRowset(qry);
while(rs.next())
			{
CountB225++;
			}
%>
 <TD ALIGN=CENTER> <%=MarksB25%></td>


<td ALIGN=CENTER><%=CountB225%> 

</td>
<%
	
	
mInitialCount=MarksB25;

		}



if(rs1.getString("CALCULATIONTYPE").equals("P") && rs1.getString("GRADE").equals("C+") )
		{
/*qry2="select a.institutecode,a.ExamCode,a.Semester,a.semestertype,a.subjectID,a.studentid studentid,";
qry2=qry2+" a.enrollmentno,round(sum((a.marksawarded2/a.maxmarks)*b.weightage),2)marksawarded2, ";
qry2=qry2+" a.studentname,sum(b.weightage)weightage from V#STUDENTEVENTSUBJECTMARKS a, ";
qry2=qry2+" V#EXAMEVENTSUBJECTTAGGING b where  ";
qry2=qry2+" a.fstid in("+mCheckFstid+") ";
qry2=qry2+" and (('"+mETOD+"'='N' and a.semestertype<>(select semestertype from semestertype where institutecode='"+mInst+"' ";
qry2=qry2+" and nvl(ETOD,'N')='Y'))  or ('"+mETOD+"'='E' and a.semestertype<>(select semestertype from semestertype where ";
qry2=qry2+" institutecode='"+mInst+"' and nvl(ETOD,'N')='Y'))) ";
qry2=qry2+" and a.examcode='"+mExamCode+"' and a.examcode=b.examcode and a.eventsubevent=b.eventsubevent and ";
qry2=qry2+" a.studentid=b.studentid ";
qry2=qry2+" and a.subjectID='"+mSubjectCode+"'  and nvl(a.DEACTIVE,'N')='N' and ";
qry2=qry2+" nvl(a.LOCKED,'N')='Y' and a.subjectID=b.subjectID and nvl(a.DEACTIVE,'N')='N' ";
qry2=qry2+" and a.fstid=b.fstid ";
qry2=qry2+" group by a.institutecode,a.ExamCode,a.Semester,a.semestertype,a.subjectID,a.studentid, ";
qry2=qry2+" a.enrollmentno,a.studentname";
qry2=qry2+"   having ROUND (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage), 2 )<80 and        ROUND (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage), 2 ) >30   and   ROUND (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage), 2 ) < "+MarksB20+"       order by marksawarded2 desc      ";
*/


  CountC25=  mTotalcalculation*mCalValue/100;
  CountC25=Math.round(CountC25);

qry2="SELECT    institutecode, examcode, semester, semestertype,subjectid,         studentid , enrollmentno,        marksawarded2,         studentname, weightage FROM (         SELECT    a.institutecode, a.examcode, a.semester, a.semestertype, a.subjectid,         a.studentid studentid, a.enrollmentno,         ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)              ) marksawarded2,         a.studentname, SUM (b.weightage) weightage    FROM v#studenteventsubjectmarks a, v#exameventsubjecttagging b   WHERE  a.fstid in("+mCheckFstid+")     AND (   (    'N' = 'N'              AND a.semestertype <>                      (SELECT semestertype                         FROM semestertype                        WHERE institutecode = '"+mInst+"'  AND NVL (etod, 'N') = 'Y')             )          OR (    'N' = 'E'              AND a.semestertype <>                      (SELECT semestertype                         FROM semestertype                        WHERE institutecode ='"+mInst+"'  AND NVL (etod, 'N') = 'Y')             )         )     AND a.examcode ='"+mExamCode+"'     AND a.examcode = b.examcode     AND a.eventsubevent = b.eventsubevent     AND a.studentid = b.studentid     AND a.subjectid = '"+mSubjectCode+"'      AND NVL (a.deactive, 'N') = 'N'     AND NVL (a.LOCKED, 'N') = 'Y'     AND a.subjectid = b.subjectid     AND NVL (a.deactive, 'N') = 'N'    AND a.fstid = b.fstid ";

qry2=qry2+" GROUP BY a.institutecode,         a.examcode,         a.semester,         a.semestertype,         a.subjectid,         a.studentid,         a.enrollmentno,         a.studentname  HAVING ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)) < 80     AND ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage) ) > 30   and   ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)  ) < "+MarksB25+" ORDER BY marksawarded2 DESC) WHERE ROWNUM<= "+CountC25+" ORDER BY marksawarded2";
rs2=db.getRowset(qry2);
//out.print(qry2);
while(rs2.next())
{
	PerC25++;
	
	if(PerC25==1)
	MarksC25=rs2.getInt("marksawarded2")	;
	
}



qry="SELECT    institutecode, examcode, semester, semestertype,subjectid,         studentid , enrollmentno,        marksawarded2,         studentname, weightage FROM (         SELECT    a.institutecode, a.examcode, a.semester, a.semestertype, a.subjectid,         a.studentid studentid, a.enrollmentno,         ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)               ) marksawarded2,         a.studentname, SUM (b.weightage) weightage    FROM v#studenteventsubjectmarks a, v#exameventsubjecttagging b   WHERE  a.fstid in("+mCheckFstid+")     AND (   (    'N' = 'N'              AND a.semestertype <>                      (SELECT semestertype                         FROM semestertype                        WHERE institutecode = '"+mInst+"'  AND NVL (etod, 'N') = 'Y')             )          OR (    'N' = 'E'              AND a.semestertype <>                      (SELECT semestertype                         FROM semestertype                        WHERE institutecode ='"+mInst+"'  AND NVL (etod, 'N') = 'Y')             )         )     AND a.examcode ='"+mExamCode+"'     AND a.examcode = b.examcode     AND a.eventsubevent = b.eventsubevent     AND a.studentid = b.studentid     AND a.subjectid = '"+mSubjectCode+"'      AND NVL (a.deactive, 'N') = 'N'     AND NVL (a.LOCKED, 'N') = 'Y'     AND a.subjectid = b.subjectid     AND NVL (a.deactive, 'N') = 'N'    AND a.fstid = b.fstid    ";


	//qry=qry+" and a.STUDENTID not in (select c.studentid from DEBARSTUDENTDETAIL c where    C.EXAMCODE='"+mExamCode+"'  AND   c.subjectid ='"+mSubjectCode+"' and c.SUBJECTID=a.SUBJECTID   and c.INSTITUTECODE='"+mInst+"' AND C.INSTITUTECODE=A.INSTITUTECODE   AND A.STUDENTID=C.STUDENTID  AND NVL(C.PRORATA,'N')='N'  AND    (NVL(C.MEDICALCASE,'Y')='Y' OR  NVL(C.ABSENTCASE,'N')='N' OR NVL(C.UFM,'N')='N' ) AND C.GRADE IS NOT NULL   ) ";

	qry=qry+" AND a.studentid NOT IN (    SELECT c.studentid    FROM debarstudentdetail c      WHERE c.examcode = '"+mExamCode+"'      AND c.subjectid = '"+mSubjectCode+"'     AND c.subjectid = a.subjectid      AND c.institutecode = '"+mInst+"'     AND c.institutecode = a.institutecode                         AND a.studentid = c.studentid    AND c.grade IS NOT NULL     And c.grade in ('F','I','X')) ";

qry=qry+"	GROUP BY a.institutecode,         a.examcode,         a.semester,         a.semestertype,         a.subjectid,         a.studentid,         a.enrollmentno,         a.studentname  HAVING ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)) < 80     AND ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)) > 30     AND ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)) >= "+MarksC25+" AND ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)) < "+MarksB25+" ORDER BY marksawarded2 DESC) ORDER BY marksawarded2";
//out.print(qry);
rs=db.getRowset(qry);
while(rs.next())
			{
CountC225++;
			}
%>
 <TD ALIGN=CENTER>   <%=MarksC25%></td>


<td ALIGN=CENTER><%=CountC225%> 

</td>
<%
	

mInitialCount=MarksC25;
		}

if(rs1.getString("CALCULATIONTYPE").equals("P") && rs1.getString("GRADE").equals("C") )
		{


  CountC15=  mTotalcalculation*mCalValue/100;

CountC15=Math.round(CountC15);

qry2="SELECT    institutecode, examcode, semester, semestertype,subjectid,         studentid , enrollmentno,        marksawarded2,         studentname, weightage FROM (         SELECT    a.institutecode, a.examcode, a.semester, a.semestertype, a.subjectid,         a.studentid studentid, a.enrollmentno,         ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)               ) marksawarded2,         a.studentname, SUM (b.weightage) weightage    FROM v#studenteventsubjectmarks a, v#exameventsubjecttagging b   WHERE  a.fstid in("+mCheckFstid+")     AND (   (    'N' = 'N'              AND a.semestertype <>                      (SELECT semestertype                         FROM semestertype                        WHERE institutecode = '"+mInst+"'  AND NVL (etod, 'N') = 'Y')             )          OR (    'N' = 'E'              AND a.semestertype <>                      (SELECT semestertype                         FROM semestertype                        WHERE institutecode ='"+mInst+"'  AND NVL (etod, 'N') = 'Y')             )         )     AND a.examcode ='"+mExamCode+"'     AND a.examcode = b.examcode     AND a.eventsubevent = b.eventsubevent     AND a.studentid = b.studentid     AND a.subjectid = '"+mSubjectCode+"'      AND NVL (a.deactive, 'N') = 'N'     AND NVL (a.LOCKED, 'N') = 'Y'     AND a.subjectid = b.subjectid     AND NVL (a.deactive, 'N') = 'N'    AND a.fstid = b.fstid  ";



qry2=qry2+" GROUP BY a.institutecode,         a.examcode,         a.semester,         a.semestertype,         a.subjectid,         a.studentid,         a.enrollmentno,         a.studentname  HAVING ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)) < 80     AND ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)) > 30   and   ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage) ) < "+MarksC25+" ORDER BY marksawarded2 DESC) WHERE ROWNUM<= "+CountC15+" ORDER BY marksawarded2";

rs2=db.getRowset(qry2);
//out.print(qry2);
while(rs2.next())
{
	PerC15++;
	
	if(PerC15==1)
	MarksC15=rs2.getInt("marksawarded2")	;
	
}

qry="SELECT    institutecode, examcode, semester, semestertype,subjectid,         studentid , enrollmentno,        marksawarded2,         studentname, weightage FROM (         SELECT    a.institutecode, a.examcode, a.semester, a.semestertype, a.subjectid,         a.studentid studentid, a.enrollmentno,         ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)              ) marksawarded2,         a.studentname, SUM (b.weightage) weightage    FROM v#studenteventsubjectmarks a, v#exameventsubjecttagging b   WHERE  a.fstid in("+mCheckFstid+")     AND (   (    'N' = 'N'              AND a.semestertype <>                      (SELECT semestertype                         FROM semestertype                        WHERE institutecode = '"+mInst+"'  AND NVL (etod, 'N') = 'Y')             )          OR (    'N' = 'E'              AND a.semestertype <>                      (SELECT semestertype                         FROM semestertype                        WHERE institutecode ='"+mInst+"'  AND NVL (etod, 'N') = 'Y')             )         )     AND a.examcode ='"+mExamCode+"'     AND a.examcode = b.examcode     AND a.eventsubevent = b.eventsubevent     AND a.studentid = b.studentid     AND a.subjectid = '"+mSubjectCode+"'      AND NVL (a.deactive, 'N') = 'N'     AND NVL (a.LOCKED, 'N') = 'Y'     AND a.subjectid = b.subjectid     AND NVL (a.deactive, 'N') = 'N'    AND a.fstid = b.fstid  ";

	//qry=qry+" and a.STUDENTID not in (select c.studentid from DEBARSTUDENTDETAIL c where    C.EXAMCODE='"+mExamCode+"'  AND   c.subjectid ='"+mSubjectCode+"' and c.SUBJECTID=a.SUBJECTID   and c.INSTITUTECODE='"+mInst+"' AND C.INSTITUTECODE=A.INSTITUTECODE   AND A.STUDENTID=C.STUDENTID  AND NVL(C.PRORATA,'N')='N' AND    (NVL(C.MEDICALCASE,'Y')='Y' OR  NVL(C.ABSENTCASE,'N')='N' OR NVL(C.UFM,'N')='N' ) AND C.GRADE IS NOT NULL   ) ";


qry=qry+" AND a.studentid NOT IN (    SELECT c.studentid    FROM debarstudentdetail c      WHERE c.examcode = '"+mExamCode+"'      AND c.subjectid = '"+mSubjectCode+"'     AND c.subjectid = a.subjectid      AND c.institutecode = '"+mInst+"'     AND c.institutecode = a.institutecode                         AND a.studentid = c.studentid    AND c.grade IS NOT NULL     And c.grade in ('F','I','X')) ";

qry=qry+" GROUP BY a.institutecode,         a.examcode,         a.semester,         a.semestertype,         a.subjectid,         a.studentid,         a.enrollmentno,         a.studentname  HAVING ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)) < 80     AND ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)) > 30     AND ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)) >= "+MarksC15+" AND ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)) < "+MarksC25+" ORDER BY marksawarded2 DESC) ORDER BY marksawarded2";
//out.print(qry);
rs=db.getRowset(qry);
while(rs.next())
			{
CountC115++;
			}
%>
 <TD ALIGN=CENTER>   <%=MarksC15%></td>


<td ALIGN=CENTER><%=CountC115%> 

</td>
<%
	mInitialCount=MarksC15;
	
		}



if(rs1.getString("CALCULATIONTYPE").equals("P") && rs1.getString("GRADE").equals("D") )
		{


  CountD5=  mTotalcalculation*mCalValue/100;

CountD5=Math.round(CountD5);

qry2="SELECT    institutecode, examcode, semester, semestertype,subjectid,         studentid , enrollmentno,        marksawarded2,         studentname, weightage FROM (         SELECT    a.institutecode, a.examcode, a.semester, a.semestertype, a.subjectid,         a.studentid studentid, a.enrollmentno,         ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)             ) marksawarded2,         a.studentname, SUM (b.weightage) weightage    FROM v#studenteventsubjectmarks a, v#exameventsubjecttagging b   WHERE  a.fstid in("+mCheckFstid+")     AND (   (    'N' = 'N'              AND a.semestertype <>                      (SELECT semestertype                         FROM semestertype                        WHERE institutecode = '"+mInst+"'  AND NVL (etod, 'N') = 'Y')             )          OR (    'N' = 'E'              AND a.semestertype <>                      (SELECT semestertype                         FROM semestertype                        WHERE institutecode ='"+mInst+"'  AND NVL (etod, 'N') = 'Y')             )         )     AND a.examcode ='"+mExamCode+"'     AND a.examcode = b.examcode     AND a.eventsubevent = b.eventsubevent     AND a.studentid = b.studentid     AND a.subjectid = '"+mSubjectCode+"'      AND NVL (a.deactive, 'N') = 'N'     AND NVL (a.LOCKED, 'N') = 'Y'     AND a.subjectid = b.subjectid     AND NVL (a.deactive, 'N') = 'N'    AND a.fstid = b.fstid  ";


qry2=qry2+" GROUP BY a.institutecode,         a.examcode,         a.semester,         a.semestertype,         a.subjectid,         a.studentid,         a.enrollmentno,         a.studentname  HAVING ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)) < 80     AND ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)) >= 30   and   ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage) ) < "+MarksC15+" ORDER BY marksawarded2 DESC) WHERE ROWNUM<= "+CountD5+" ORDER BY marksawarded2";

rs2=db.getRowset(qry2);
//out.print("DFSFS"+qry2);
while(rs2.next())
{
	PerD5++;
	
	if(PerD5==1)
	MarksD5=rs2.getInt("marksawarded2")	;
	
}


qry="SELECT    institutecode, examcode, semester, semestertype,subjectid,         studentid , enrollmentno,        marksawarded2,         studentname, weightage FROM (         SELECT    a.institutecode, a.examcode, a.semester, a.semestertype, a.subjectid,         a.studentid studentid, a.enrollmentno,         ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)                ) marksawarded2,         a.studentname, SUM (b.weightage) weightage    FROM v#studenteventsubjectmarks a, v#exameventsubjecttagging b   WHERE  a.fstid in("+mCheckFstid+")     AND (   (    'N' = 'N'              AND a.semestertype <>                      (SELECT semestertype                         FROM semestertype                        WHERE institutecode = '"+mInst+"'  AND NVL (etod, 'N') = 'Y')             )          OR (    'N' = 'E'              AND a.semestertype <>                      (SELECT semestertype                         FROM semestertype                        WHERE institutecode ='"+mInst+"'  AND NVL (etod, 'N') = 'Y')             )         )     AND a.examcode ='"+mExamCode+"'     AND a.examcode = b.examcode     AND a.eventsubevent = b.eventsubevent     AND a.studentid = b.studentid     AND a.subjectid = '"+mSubjectCode+"'      AND NVL (a.deactive, 'N') = 'N'     AND NVL (a.LOCKED, 'N') = 'Y'     AND a.subjectid = b.subjectid     AND NVL (a.deactive, 'N') = 'N'    AND a.fstid = b.fstid    ";

	//qry=qry+" and a.STUDENTID not in (select c.studentid from DEBARSTUDENTDETAIL c where    C.EXAMCODE='"+mExamCode+"'  AND   c.subjectid ='"+mSubjectCode+"' and c.SUBJECTID=a.SUBJECTID   and c.INSTITUTECODE='"+mInst+"' AND C.INSTITUTECODE=A.INSTITUTECODE   AND A.STUDENTID=C.STUDENTID  AND NVL(C.PRORATA,'N')='N'  AND    (NVL(C.MEDICALCASE,'Y')='Y' OR  NVL(C.ABSENTCASE,'N')='N' OR NVL(C.UFM,'N')='N' )AND C.GRADE IS NOT NULL   ) ";

qry=qry+" AND a.studentid NOT IN (    SELECT c.studentid    FROM debarstudentdetail c      WHERE c.examcode = '"+mExamCode+"'      AND c.subjectid = '"+mSubjectCode+"'     AND c.subjectid = a.subjectid      AND c.institutecode = '"+mInst+"'     AND c.institutecode = a.institutecode                         AND a.studentid = c.studentid    AND c.grade IS NOT NULL     And c.grade in ('F','I','X')) ";



qry=qry+" GROUP BY a.institutecode,         a.examcode,         a.semester,         a.semestertype,         a.subjectid,         a.studentid,         a.enrollmentno,         a.studentname  HAVING ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)) < 80     AND ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)) >= 30      AND ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage)) < "+MarksC15+" ORDER BY marksawarded2 DESC) ORDER BY marksawarded2";
//out.print("D"+qry);
rs=db.getRowset(qry);
while(rs.next())
			{
CountD15++;
			}
%>
 <TD ALIGN=CENTER>  <%=MarksD5%></td>


<td ALIGN=CENTER><%=CountD15%>

</td>
<%
//	if(MarksD5!=0.0 || MarksD5!=0)
		mInitialCount=MarksD5;

		}


if(rs1.getString("CALCULATIONTYPE").equals("F") && rs1.getString("GRADE").equals("F") )
		{
qry2="select a.institutecode,a.ExamCode,a.Semester,a.semestertype,a.subjectID,a.studentid studentid,";
qry2=qry2+" a.enrollmentno,ceil(sum((a.marksawarded2/a.maxmarks)*b.weightage))marksawarded2, ";
qry2=qry2+" a.studentname,sum(b.weightage)weightage from V#STUDENTEVENTSUBJECTMARKS a, ";
qry2=qry2+" V#EXAMEVENTSUBJECTTAGGING b where  ";
qry2=qry2+" a.fstid in("+mCheckFstid+") ";
qry2=qry2+" and (('"+mETOD+"'='N' and a.semestertype<>(select semestertype from semestertype where institutecode='"+mInst+"' ";
qry2=qry2+" and nvl(ETOD,'N')='Y'))  or ('"+mETOD+"'='E' and a.semestertype<>(select semestertype from semestertype where ";
qry2=qry2+" institutecode='"+mInst+"' and nvl(ETOD,'N')='Y'))) ";
qry2=qry2+" and a.examcode='"+mExamCode+"' and a.examcode=b.examcode and a.eventsubevent=b.eventsubevent and ";
qry2=qry2+" a.studentid=b.studentid ";
qry2=qry2+" and a.subjectID='"+mSubjectCode+"'  and nvl(a.DEACTIVE,'N')='N' and ";
qry2=qry2+" nvl(a.LOCKED,'N')='Y' and a.subjectID=b.subjectID and nvl(a.DEACTIVE,'N')='N' ";
qry2=qry2+" and a.fstid=b.fstid ";
qry2=qry2+" group by a.institutecode,a.ExamCode,a.Semester,a.semestertype,a.subjectID,a.studentid, ";
qry2=qry2+" a.enrollmentno,a.studentname";
qry2=qry2+"  having (ceil (SUM ((a.marksawarded2 / a.maxmarks) * b.weightage) )<30 )  ";

qry2=qry2+" OR ( a.STUDENTID  in (select c.studentid from DEBARSTUDENTDETAIL c where    C.EXAMCODE='"+mExamCode+"'  AND   c.subjectid ='"+mSubjectCode+"' and c.SUBJECTID=a.SUBJECTID   and c.INSTITUTECODE='"+mInst+"' AND C.INSTITUTECODE=A.INSTITUTECODE   AND A.STUDENTID=C.STUDENTID  AND NVL(C.PRORATA,'N')='N' AND     NVL(c.GRADE,'N')='F' AND  (NVL(C.MEDICALCASE,'Y')='Y' OR  NVL(C.ABSENTCASE,'N')='N' OR NVL(C.UFM,'N')='N' ) AND C.GRADE IS NOT NULL   ) ) ";
rs2=db.getRowset(qry2);
//out.print(qry2);
while(rs2.next())
{
	  Per30++;
}
Marks30=0;

	mInitialCount=Marks30;
%>
<TD ALIGN=CENTER><%=Marks30%></td>
<TD ALIGN=CENTER><%=Per30%></td>
<%
	

		}



if(rs1.getString("CALCULATIONTYPE").equals("F") && rs1.getString("GRADE").equals("I") )
		{
qry2="select a.institutecode,a.ExamCode,a.Semester,a.semestertype,a.subjectID,a.studentid studentid,";
qry2=qry2+" a.enrollmentno,ceil(sum((a.marksawarded2/a.maxmarks)*b.weightage))marksawarded2, ";
qry2=qry2+" a.studentname,sum(b.weightage)weightage from V#STUDENTEVENTSUBJECTMARKS a, ";
qry2=qry2+" V#EXAMEVENTSUBJECTTAGGING b where  ";
qry2=qry2+" a.fstid in("+mCheckFstid+") ";
qry2=qry2+" and (('"+mETOD+"'='N' and a.semestertype<>(select semestertype from semestertype where institutecode='"+mInst+"' ";
qry2=qry2+" and nvl(ETOD,'N')='Y'))  or ('"+mETOD+"'='E' and a.semestertype<>(select semestertype from semestertype where ";
qry2=qry2+" institutecode='"+mInst+"' and nvl(ETOD,'N')='Y'))) ";
qry2=qry2+" and a.examcode='"+mExamCode+"' and a.examcode=b.examcode and a.eventsubevent=b.eventsubevent and ";
qry2=qry2+" a.studentid=b.studentid ";
qry2=qry2+" and a.subjectID='"+mSubjectCode+"'  and nvl(a.DEACTIVE,'N')='N' and ";
qry2=qry2+" nvl(a.LOCKED,'N')='Y' and a.subjectID=b.subjectID and nvl(a.DEACTIVE,'N')='N' ";
qry2=qry2+" and a.fstid=b.fstid ";
	
	qry2=qry2+" and a.STUDENTID  in (select c.studentid from DEBARSTUDENTDETAIL c where    C.EXAMCODE='"+mExamCode+"'  AND   c.subjectid ='"+mSubjectCode+"' and c.SUBJECTID=a.SUBJECTID   and c.INSTITUTECODE='"+mInst+"' AND C.INSTITUTECODE=A.INSTITUTECODE   AND A.STUDENTID=C.STUDENTID AND NVL(C.PRORATA,'N')='N' AND     NVL(c.GRADE,'N')='I' AND  (NVL(C.MEDICALCASE,'Y')='Y' OR  NVL(C.ABSENTCASE,'N')='N' OR NVL(C.UFM,'N')='N' )  AND C.GRADE IS NOT NULL   )";

qry2=qry2+" group by a.institutecode,a.ExamCode,a.Semester,a.semestertype,a.subjectID,a.studentid, ";
qry2=qry2+" a.enrollmentno,a.studentname";


rs2=db.getRowset(qry2);
//out.print(qry2);
while(rs2.next())
{
	  PerMedical++;
}
MarksMedical=0;

	mInitialCount=MarksMedical;
%>
<TD ALIGN=CENTER>-</td>
<!-- <TD ALIGN=CENTER><%=MarksMedical%></td> -->
<TD ALIGN=CENTER><%=PerMedical%></td>
<%
	

		}

	if(mCheckRadio.equals("Y"))
		{
			try{
			if(request.getParameter(mNameLower)==null || request.getParameter(mNameLower).equals(""))
			{
				GradeMasterLowerLimit=0;
			}
			else
			{
				GradeMasterLowerLimit=Double.parseDouble(request.getParameter(mNameLower).toString().trim());
			}
 
	}
			catch(Exception e)
		{}
		if(GradeMasterLowerLimit==0.0)
		{
	%>
<!--	<TD ALIGN=CENTER ><input style="text-align:right" readonly type="text" name="<%=mNameLower%>" id="<%=mNameLower%>" size=3 maxlength=5 onkeypress="return isNumber(event)"></TD> -->
		<TD ALIGN=CENTER >0 </TD>
	<%		
		}
	else
	{
		zz++;
%>
		<TD ALIGN=CENTER ><input style="text-align:right" value=<%=GradeMasterLowerLimit%> type="text" size=3  name="<%=mNameLower%>" maxlength=5 id="<%=mNameLower%>"  onkeypress="return isNumber(event)"></TD>
	<%
	}
		} 
		else
		{
		if(rs1.getString("GRADE").equals("F") )
			{

			%>
		 <TD ALIGN=CENTER >   <input type="text" style="text-align:right" name="<%=mNameLower%>" id="<%=mNameLower%>"  size=3 maxlength=5    >  </TD>
	<%
			}
			else				if(rs1.getString("GRADE").equals("I") )
			{

			%>
		 <TD ALIGN=CENTER > - </TD>

<!-- <TD ALIGN=CENTER >   <input type="text" style="text-align:right" name="<%=mNameLower%>" id="<%=mNameLower%>"  size=3 maxlength=5  value="<%=MarksMedical%>" disabled >  </TD> -->

	<%
			}
			else
			{
				zz++;
	%>
		<TD ALIGN=CENTER ><input type="text" style="text-align:right" name="<%=mNameLower%>" id="<%=mNameLower%>"  size=3 maxlength=5 onkeypress="return isNumber(event)"></TD>
	<% }
			
		}

		//mInitialCount=(mRecommendedFrom+mRecommendedTo)/2;
		mInitialCount1=""+mInitialCount;

if(mCheckRadio.equals("Y"))
{
	GML=""+GradeMasterLowerLimit;
	mPrevValueNew1=""+mPrevValueNew;
	GradeInitialCount=mGrad+"***"+mInitialCount1+"///"+GML+"$$$"+mPrevValueNew1;
	mGradeInitialCount.add(GradeInitialCount);
	session.setAttribute("GRADEINITIALCOUNT",mGradeInitialCount);
}
else
{
		GradeInitialCount=mGrad+"***"+mInitialCount1+"///???$$$%%%";
		mGradeInitialCount.add(GradeInitialCount);
		session.setAttribute("GRADEINITIALCOUNT",mGradeInitialCount);
}		

//out.print(GradeMasterTotalCount+"GradeMasterTotalCount<br>");
// Qyery for Populate Grade..........................................
if(!rs1.getString("GRADE").equals("I"))
		{
%>
	<%@ include file="StudentGradeCalculation.jsp"%>
<%
		}
	
//******************************************************************
if(mCheckRadio.equals("Y"))
{
	mPrevValueNew=GradeMasterLowerLimit;
	mAVGPNEW=mAVGPNEW+(GradeMasterTotalCount*(rs1.getDouble("GRADEPOINTS"))) ;
}

	if(mCheckRadio.equals("Y"))
	{
		
		if(GradeMasterTotalCount==0)
		{
	%>
			<TD ALIGN=CENTER>&nbsp;</TD></TR>
	<%
		}
else
		{
%>
	<TD ALIGN=CENTER><%=GradeMasterTotalCount%></TD>		</TR>
<%
		}
	}
	else	
	{
%>
	<TD ALIGN=CENTER>&nbsp;</TD> 		</TR>
<%
	}
	

//int CountA10=0,CountB220=0,CountB225=0,CountC225=0,CountC115=0,Per80=0,Per30=0,CountD15=0;
	
if(rs1.getString("CALCULATIONTYPE").equals("F") && rs1.getString("GRADE").equals("A+") )
		{
	
	
GradeMasterSetMerge=rs1.getString("GRADE")+"///"+mCalValue+"***"+Marks80+"$$$"+Per80+"%%%"+GradeMasterLowerLimit+"###"+GradeMasterTotalCount;

		}
if(rs1.getString("CALCULATIONTYPE").equals("P") && rs1.getString("GRADE").equals("A") )
		{
	

GradeMasterSetMerge=rs1.getString("GRADE")+"///"+mCalValue+"***"+Marks10+"$$$"+CountA10+"%%%"+GradeMasterLowerLimit+"###"+GradeMasterTotalCount;

		}
if(rs1.getString("CALCULATIONTYPE").equals("P") && rs1.getString("GRADE").equals("B+") )
		{
	
GradeMasterSetMerge=rs1.getString("GRADE")+"///"+mCalValue+"***"+MarksB20+"$$$"+CountB220+"%%%"+GradeMasterLowerLimit+"###"+GradeMasterTotalCount;

		}
if(rs1.getString("CALCULATIONTYPE").equals("P") && rs1.getString("GRADE").equals("B") )
		{

GradeMasterSetMerge=rs1.getString("GRADE")+"///"+mCalValue+"***"+MarksB25+"$$$"+CountB225+"%%%"+GradeMasterLowerLimit+"###"+GradeMasterTotalCount;

		}
if(rs1.getString("CALCULATIONTYPE").equals("P") && rs1.getString("GRADE").equals("C+") )
		{


GradeMasterSetMerge=rs1.getString("GRADE")+"///"+mCalValue+"***"+MarksC25+"$$$"+CountC225+"%%%"+GradeMasterLowerLimit+"###"+GradeMasterTotalCount;

		}

if(rs1.getString("CALCULATIONTYPE").equals("P") && rs1.getString("GRADE").equals("C") )
		{


GradeMasterSetMerge=rs1.getString("GRADE")+"///"+mCalValue+"***"+MarksC15+"$$$"+CountC115+"%%%"+GradeMasterLowerLimit+"###"+GradeMasterTotalCount;

		}

if(rs1.getString("CALCULATIONTYPE").equals("P") && rs1.getString("GRADE").equals("D") )
		{


GradeMasterSetMerge=rs1.getString("GRADE")+"///"+mCalValue+"***"+MarksD5+"$$$"+CountD15+"%%%"+GradeMasterLowerLimit+"###"+GradeMasterTotalCount;

		}
	
if(rs1.getString("CALCULATIONTYPE").equals("F") && rs1.getString("GRADE").equals("F") )
		{

GradeMasterSetMerge=rs1.getString("GRADE")+"///"+mCalValue+"***"+Marks30+"$$$"+Per30+"%%%"+GradeMasterLowerLimit+"###"+GradeMasterTotalCount;

		}


if(rs1.getString("CALCULATIONTYPE").equals("F") && rs1.getString("GRADE").equals("I") )
		{

GradeMasterSetMerge=rs1.getString("GRADE")+"///"+mCalValue+"***"+MarksMedical+"$$$"+PerMedical+"%%%"+GradeMasterLowerLimit+"###"+GradeMasterTotalCount;

		}

//GradeMasterSetMerge=rs1.getString("GRADE")+"///"+SuggestedRange+"***"+InitialBoundary+"$$$"+InitialCount+"%%%"+GradeMasterLowerLimit+"###"+GradeMasterTotalCount;
GradeMasterSet.add(GradeMasterSetMerge);

//out.print("<br> GradeMasterSet:"+GradeMasterSet);

session.setAttribute("GRADEMASTERSET",GradeMasterSet);
} // closing of while  grade points)

  mInitialAVGP=mAVGP/(mCount1-Rejected);
if(mCheckRadio.equals("Y"))
{
	mAVGPFinal=mAVGPNEW/(mCount1-Rejected) ;
} 
%>
	<input type="hidden" name="ZZ" id="ZZ" value="<%=zz%>">
	<input type=hidden name="SNO" id="SNO" value="<%=sno%>">
	</TABLE>
	<br>
	<TABLE ALIGN=CENTER rules=COLUMNS WIDTH=76% CELLSPACING=0 BORDER=1>
<B>Note: 1. Computation of Grade form 'A' to 'D' exclude students awarded (A<sup>+</sup> , F and I) Grades.</B><BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<B>2. Debar students included in 'F' Grade.</B>
</Table>

<br>

	<br>
	<TABLE ALIGN=CENTER rules=COLUMNS WIDTH=76% CELLSPACING=0 BORDER=1>
	<TR>
		<TD ALIGN=CENTER><b>Total<br>Students<B></TD>
		<TD ALIGN=CENTER><b>Rejected<br>Students<B></TD>
		<TD ALIGN=CENTER><b>Students<br>Considered<B></TD>
		<TD ALIGN=CENTER><b>Mean<B></TD>
		<TD ALIGN=CENTER><b>Standard<br>Deviation<B></TD>
		<!-- <TD ALIGN=CENTER><b>Initial<br>AVGP<B></TD>
		<TD ALIGN=CENTER><b>AVGP<B></TD> -->
	</TR>
	<TR>
		<TD ALIGN=CENTER><%=mtotStudent%></TD>
		<!-- <TD ALIGN=CENTER><%=Rejected%>(Debarr-<%=DRejected%>Detained-<%=DERejected%>)</TD> -->
		<TD ALIGN=CENTER><%=Rejected%></TD>
				<!-- <TD ALIGN=CENTER><%=Rejected%>(Debarr -<%=DRejected%>,Detained -<%=DERejected%>)</TD> -->
		<%
		 mConsidered=mtotStudent-Rejected;

		mInitialAVGP11=gb.getRound(mInitialAVGP,2);
		%>
		<TD ALIGN=CENTER><%=mConsidered%></TD>
		<TD ALIGN=CENTER><%=mGlobalMean%></TD>
		<TD ALIGN=CENTER><%=mDeviation%></TD>
	<!-- 	<TD ALIGN=CENTER><%=mInitialAVGP11%></TD> -->
		<%

			if(mCheckRadio.equals("Y"))
		{
mAVGPFinal11=gb.getRound(mAVGPFinal,2);
		%>
		<!-- <TD ALIGN=CENTER><%=mAVGPFinal11%></TD></TR> -->
		<%
		}
		else
		{
		%>
		<!-- <TD ALIGN=CENTER>&nbsp;</TD></TR> -->
		<%
			}

		%>

	</TABLE>


	<BR><BR>
	<TABLE ALIGN=CENTER rules=COLUMNS WIDTH=76% CELLSPACING=0 BORDER=1>
	<TR>
		<TD ALIGN=CENTER bgcolor=white ><b>Student Case&nbsp;(Identified by)<B></TD>
		<TD ALIGN=CENTER bgcolor=lightblue><b>Absent&nbsp;($)<B></TD>
		<TD ALIGN=CENTER bgcolor=lightgreen><b>Medical&nbsp;(#)<B></TD>
		<TD ALIGN=CENTER bgcolor="#FFFF99"><b>UFM&nbsp;(@)<B></TD>
		<TD ALIGN=CENTER bgcolor=lightgrey><b>PRORATA&nbsp;(~)<B></TD>
		<TD ALIGN=CENTER bgcolor=pink><b>DEBARR&nbsp;(*)<B></TD>
		<!-- <TD ALIGN=CENTER><b>Initial<br>AVGP<B></TD>
		<TD ALIGN=CENTER><b>AVGP<B></TD> -->
	</TR>

	<%
	//	//mCheckFstid     mInst     mExamCode  mSubjectCode

qrycase="select  distinct a.Subjectid, b.SubjectCode, b.Subject,        (select count(c.studentid)         from   debarstudentdetail c         where  c.institutecode = '"+mInst+"'         and    c.Examcode = '"+mExamCode+"'         and    c.subjectid = '"+mSubjectCode+"'         and    nvl(c.absentcase,'N') = 'Y'        ) absent,        (select count(d.studentid)         from   debarstudentdetail d         where  d.institutecode = '"+mInst+"'         and    d.Examcode = '"+mExamCode+"'         and    d.subjectid = '"+mSubjectCode+"'         and    nvl(d.medicalcase,'N') = 'Y'        ) Medical,        (select count(e.studentid)         from   debarstudentdetail e         where  e.institutecode = '"+mInst+"'         and    e.Examcode = '"+mExamCode+"'         and    e.subjectid = '"+mSubjectCode+"'         and    nvl(e.UFM,'N') = 'Y'        ) UFM,        (select count(f.studentid)         from   debarstudentdetail f         where  f.institutecode = '"+mInst+"'         and    f.Examcode = '"+mExamCode+"'         and    f.subjectid = '"+mSubjectCode+"'         and    nvl(f.Prorata,'N') = 'Y'        ) ProRata,         (select count(g.studentid)         from   debarstudentdetail g         where  g.institutecode = '"+mInst+"'         and    g.Examcode = '"+mExamCode+"'         and    g.subjectid = '"+mSubjectCode+"'         and    nvl(g.Debar,'N') = 'Y'        ) Debar        from    debarstudentdetail a, Subjectmaster b where   a.institutecode = '"+mInst+"' And     a.examcode = '"+mExamCode+"' And     a.subjectid = '"+mSubjectCode+"' and     a.fstid IN  ( "+mCheckFstid+" ) and     a.institutecode = b.Institutecode and     a.subjectid      = b.subjectid ";

rscase =db.getRowset(qrycase);
//out.print(qrycase);
while(rscase.next())
{
	  
    mAbsentc=rscase.getString("absent");
	mMedicalc=rscase.getString("Medical");
	mUFMc=rscase.getString("UFM");
	mProdatac=rscase.getString("ProRata");
	mDebarrc=rscase.getString("Debar");


}



	%>
	<TR>




		<TD ALIGN=CENTER bgcolor=white><b>Count <B></TD>
		<TD ALIGN=CENTER bgcolor=lightblue><%=mAbsentc%> <B></TD>
	<TD ALIGN=CENTER bgcolor=lightgreen><%=mMedicalc%> </TD>
		<TD ALIGN=CENTER bgcolor="#FFFF99"><b><%=mUFMc%> </TD>
		<TD ALIGN=CENTER bgcolor=lightgrey><%=mProdatac%><B></TD>
		<TD ALIGN=CENTER bgcolor=pink><b><%=mDebarrc%> </TD>
		<!-- <TD ALIGN=CENTER><b>Initial<br>AVGP<B></TD>
		<TD ALIGN=CENTER><b>AVGP<B></TD> -->
	</TR>
</table>
<br>
<table width=80% align=center>
<TR>
<td align=left>
 
<a href="StudentGrades1.jsp?ExamCode=<%=mExamCode%>&amp;SEMESTER=<%=mSem1%>&amp;Subject=<%=mSubjectCode%>&amp;TOTALSTUDENTS=<%=mtotStudent%>&amp;STUDENTREJECTED=<%=Rejected%>&amp;STUDENTCONSIDERED=<%=mConsidered%>&amp;MEAN=<%=mGlobalMean%>&amp;DEVIATION=<%=mDeviation%>&amp;INITIALAVGP=<%=mInitialAVGP11%>&amp;FINALAVGP=<%=mAVGPFinal11%>&amp;CHECKRADIO=<%=mCheckRadio%>&amp;CTR=<%=mCheck%>" target=_new >
<b><IMG SRC="images/arrow_cool.gif" WIDTH="23" HEIGHT="13" BORDER="0" ALT="">Click to view Student Grades(Initial Boundary)</b></a> 
</td>
<td align=center>
<!-- <b>Selected Lower Limit </b> -->
<%
	
	if(mCheckRadio.equals("Y"))
	{
%>
<input type=hidden name=CHECKRADIO id=CHECKRADIO VALUE="Y" checked=true >
<!-- <b>Yes</b><input type=radio name=CHECKRADIO id=CHECKRADIO VALUE="N" onClick="LimitDisable()" ><b>No</b>-->
<%
}
else
{
%>
<input type=hidden name=CHECKRADIO id=CHECKRADIO checked=true VALUE="Y" >
<!-- <b>Yes</b><input type=radio name=CHECKRADIO id=CHECKRADIO VALUE="N"  onClick="LimitDisable()"><b>No</b> -->
<%
}
%>
&nbsp; 
<!-- <input type=submit value="Grade Calculation" onClick="return TextBoxValidation();"> -->
<input type=submit value="Grade Calculation" >
</td>
</tr>
</table>

</form>
<%
//out.print(qry2);


	
//out.print(mInitialCount+"hghg"+mPrevValue+"mCheckRadio"+mCheckRadio+"mPrevValueNew1"+mPrevValueNew1+"ctr"+mDebarGrade);
//out.println(GradeMatserStudentIDArrayInit);

		if(mBoolean.equals("G"))
{
		out.print("<br><img src='../../Images/Error1.jpg'>");
out.print("<font color=red size=4>Please Insert Lower Limit in Descending Order</font>");
}


	%>
 <form name="frm11"  method="post" action="ConfirmSaveGradeCalculation.jsp" > 

<!-- <form name="frm11" method="post" action="SaveGradeCalculation.jsp" > -->
<input id="y" name="y" type=hidden>
<%
		
for(int ii=1;ii<=mCheck;ii++)
{
	mName11="FSTID"+ii;
	abc=request.getParameter(mName11);
	if(abc!=null)
	{
%>
<input type=hidden name="FSTID<%=ii%>" id="FSTID<%=ii%>" value="<%=abc%>">
<%
	}
}


	%>
<table width="98%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<input type=hidden name="INSTITUTECODE" id="INSTITUTECODE" value="<%=mInst%>">
<input type=hidden name="EXAMCODE" id="EXAMCODE" value="<%=mExamCode%>">
<input type=hidden name="SUBJECTCODE" id="SUBJECTCODE" value="<%=mSubjectCode%>">
<input type=hidden name="TOTALSTUDENTS" id="TOTALSTUDENTS" value="<%=mtotStudent%>">
<input type=hidden name="STUDENTREJECTED" id="STUDENTREJECTED" value="<%=Rejected%>">
<input type=hidden name="STUDENTCONSIDERED" id="STUDENTCONSIDERED" value="<%=mConsidered%>">
<input type=hidden name="MEAN" id="MEAN" value="<%=mGlobalMean%>">
<input type=hidden name="INITIALAVGP" id="INITIALAVGP" value="<%=mInitialAVGP%>">
<input type=hidden name="FINALAVGP" id="FINALAVGP" value="<%=mAVGPFinal%>">
<input type=hidden name="DEVIATION" id="DEVIATION" value="<%=mDeviation%>">
<input type=hidden name="CTR" id="CTR" value="<%=mCheck%>">
<input type=hidden name="SNO" id="SNO" value="<%=sno%>">
<input type=hidden name="ETOD" id="ETOD" value="<%=mETOD%>">
<input type="hidden" name="SEMESTER" id="SEMESTER" value="<%=mSem1%>">

<%
//out.print(mAVGPFinal+"vvvvv"+mAVGPFinal+"vvvvv"+mCheckRadio);
if(mAVGPFinal!=0 || mAVGPFinal!=0.0 && mCheckRadio.equals("Y"))
{

%>
<TD align=center>
<input type=submit value="Continue" >
</TD>
<%
}
%>
</font></td></tr>
</TABLE>
</form>
<%


} // closing of if(mCount1==mCount2
else
{
	mValid="N";
//	out.print("Some of the Students marks has not been locked");
	out.print("<br><font color=red size=5>Some of the Students marks has not been locked</font>");
}

} // closing of if(mCount1>0 && mCount2>0)
else
{
out.print("<br><font color=red size=5>Students marks has not been entered or locked.First locked and then proceede.</font>");

}

	} // closing of if grade not inserted in grade matser
	else
		{
		out.print("<br><font color=red size=5>Please insert the grade value in grade master first and than proceede</font>");
		}
} // closing of if mFlag
	else
		{
		if(fault!=0)
			{
				out.print("<br><font color=red size=5>Please select all the option yes</font>");
			}
		else
			{
				out.print("<br><font color=red size=5>Please select atleast one of the section for grade population</font>");
			}
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

} // closing of if(!mMemberID.equals(""))
 //-----------------------------
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}    
}
  catch(Exception e)
{
	//out.print(e );
}
%>