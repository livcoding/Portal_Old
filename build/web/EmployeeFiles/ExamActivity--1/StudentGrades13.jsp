<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*,java.util.* ,java.math.* " %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%

String  qrydd="";  
String xAbsent ="";
String  Qryapimr="";  ResultSet rsiimr=null,rsQREY=null; int APIMCA=0 ,hhhh=0;
String tttt="",QREY="",mLTP=""; 
String	xMedical ="";
String	xUFM ="";
String	xDEBAR ="";
String XMedicalWITH="",qrycase="";
int  mAbsentc=0,mMedicalc=0,mUFMc=0,mDebarrc=0,mFcount=0,mProdatac=0;
String mHead="",weightageround="",weightageroundg="",msubsec="",mETOD ="",xFSTID="";
String FCALVALUE="";
String  qryttt=""; 
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
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 onload='initTable("table-1");return showAlert2();'>
<SCRIPT SRC="sortTable.js">
</SCRIPT>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: large; FONT-FAMILY: fantasy"><b>Grade Sheet..</b></TD>
</font></td></tr>
</TABLE>
<br>
<%
try
{
GlobalFunctions gb =new GlobalFunctions();
OLTEncryption enc=new OLTEncryption();
DBHandler db=new DBHandler();
String mCheckRadio="";
String  mMemberID="",mMemberType="",mMemberName="",mMemberCode="",mInst="";

String mDMemberCode="",mDMemberType="";
Set mGradeChecked=new HashSet();
Set mGradeUnChecked=new HashSet();
int mCount=0;
int pos2Init=0,pos2=0,pos3Init=0,pos20=0;
String mWeightageInit="",mWeightage="";
String mInitMarks="",mWe="";
int pos4Init=0,pos201=0;
String mMassCut="",mMass="",qryv="";
int pos2011=0,pos5Init=0;
int mCheck=0;
String mFST="",mfst="",mComp="",qry2="",qry1="";

String qryCAl="",CALVALUEAP="",CALVALUEF=""; 
String qryadd="";
String sumadd="",aa="",mName1="",ab="",mCheckFstid="" ;
int i=0;



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
	ResultSet RsChk=null ,rsttt=null ,rsdd=null,rscase=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
qryv="Select WEBKIOSK.ShowLink('146','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
RsChk= db.getRowset(qryv);
if (RsChk.next() && RsChk.getString("SL").equals("Y"))
 {
      if(request.getParameter("CHECKRADIO")==null)
		mCheckRadio="N";
	else
		mCheckRadio=request.getParameter("CHECKRADIO").toString().trim();

	if(request.getParameter("COUNT")==null)
		mCount=0;
	else
		mCount=Integer.parseInt(request.getParameter("COUNT").toString().trim());

	int len=0;
	int pos=0,pos1=0;
	int lenInit=0;
	int posInit=0,pos1Init=0;
	String mStudid="",mMarks="",mGrad="",mExamCode="";
	String mStudidInit="",mMarksInit="",mGradInit="",mSubjectCode="";
	String mName="",mRoll="",mNam="";
	int ctr=0;
	 
	String qry="",qrysub="";
	String mFCOUNT="" ,mICOUNT="";
	String mSc="";
	String mSem1="";

	ResultSet rs1=null,rs=null,rssub=null ,rsCal=null;
%>
<form name="frm"  method="post" action="SaveGradeCalculation.jsp" > 
<input id="x" name="x" type=hidden>
<%

	if(request.getParameter("ExamCode")==null)
		mExamCode="";
	else
		mExamCode=request.getParameter("ExamCode").toString().trim();

	if(request.getParameter("Subject")==null)
		mSubjectCode="";
	else
		mSubjectCode=request.getParameter("Subject").toString().trim();
	
	if(request.getParameter("SEMESTER")==null)
		mSem1="";
	else
		mSem1=request.getParameter("SEMESTER").toString().trim();

	if(request.getParameter("CTR")==null)
	mCheck=0;
	else
	mCheck=Integer.parseInt(request.getParameter("CTR").toString().trim());


	if(request.getParameter("FSTID")==null)
		xFSTID="";
	else
		xFSTID=request.getParameter("FSTID").toString().trim();

	
	if(request.getParameter("FCOUNT")==null)
		mFCOUNT="";
	else
		mFCOUNT=request.getParameter("FCOUNT").toString().trim();

	
	if(request.getParameter("ICOUNT")==null)
		mICOUNT="";
	else
		mICOUNT=request.getParameter("ICOUNT").toString().trim();


//out.print(mFCOUNT+"AAAA"+mICOUNT);


for(  i=1;i<=mCheck;i++)
{
	mName1="FSTID"+i;
	ab=request.getParameter(mName1);
%>
<INPUT TYPE="hidden" NAME="<%=mName1%>" value="<%=ab%>">
<%
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

}
// out.print(mCheckFstid+"DJFGHDJKLFG");

	qrysub="select subject,SUBJECTCODE from subjectmaster where subjectID='"+mSubjectCode+"' and nvl(deactive,'N')='N' ";
	//out.print(qrysub);
	rssub=db.getRowset(qrysub);
	if(rssub.next())
		{
	 		mNam=rssub.getString("subject");
			mSc=rssub.getString("SUBJECTCODE");

		}
		else
		{
			mNam="";
			mSc="";
		}
%>
<TABLE ALIGN=CENTER rules=COLUMNS rules=groups  cELLSPACING=0 BORDER=0>
<tr><td colspan=3><b>Co-ordinator Name/Member Name : </b><font color=dark brownt><b><%=mMemberName%>&nbsp;(<%=mDMemberCode%>)</font></b></td></tr>
<TR>
<TD><b>Exam Code :</b><%=mExamCode%></TD>
<TD nowrap ><b>&nbsp; Subject Code :</b><%=mNam%>&nbsp(<%=mSc%>)</TD>
</TR>
</TABLE>
<br>
<TABLE ALIGN=CENTER rules=COLUMNS CELLSPACING=0 BORDER=0>
<ol>
<%
qry="select question ,questionid from EXAMGRADEQUESTION where institutecode='"+mInst+"' and examcode='"+mExamCode+"' and nvl(DEACTIVE,'N')='N' order by questionid ";
rs=db.getRowset(qry);
while(rs.next())
{
%>
<TR>
<td><li><%=rs.getString("question")%>?&nbsp;Yes</br></td>
</tr>
<%
} // closing of while
%>
</table>
	<br>
<table align=center>
<tr>
<td align=center><b>General Information</B>
</td>
</tr>
</table>
<TABLE bgcolor=#fce9c5 class="sort-table"  width=76% ALIGN=CENTER rules=COLUMNS CELLSPACING=0 BORDER=1> 
<tr bgcolor="#ff8c00">
<TD ALIGN=CENTER><font color=white><b>Total<br>Students<B><font></TD>
<TD ALIGN=CENTER><font color=white><b>Pre-graded<br>Students<B><font></TD>
<TD ALIGN=CENTER><font color=white><b>Students<br>Considered<B><font></TD>
<TD ALIGN=CENTER><font color=white><b>Mean<B><font></TD>
<TD ALIGN=CENTER><font color=white><b>Standard<br>Deviation<B><font></TD>
</TR>
<%

int mTotalStudents=0,mStudentsRejected=0,mStudentsConsidered=0;
double mMean=0,mInitialAVGP=0,mFinalAVGP=0,mDeviation=0;


	ArrayList subevents=new ArrayList();

if(request.getParameter("CTR")==null)
	mCheck=0;
else
mCheck=Integer.parseInt(request.getParameter("CTR").toString().trim());
//Fstid 
if(request.getParameter("TOTALSTUDENTS")==null)
		mTotalStudents=0;
	else
		mTotalStudents=Integer.parseInt(request.getParameter("TOTALSTUDENTS").toString().trim());

	if(request.getParameter("STUDENTREJECTED")==null)
		mStudentsRejected=0;
	else
		mStudentsRejected=Integer.parseInt(request.getParameter("STUDENTREJECTED").toString().trim());

	if(request.getParameter("STUDENTCONSIDERED")==null)
		mStudentsConsidered=0;
	else
		mStudentsConsidered=Integer.parseInt(request.getParameter("STUDENTCONSIDERED").toString().trim());

	if(request.getParameter("MEAN")==null)
		mMean=0;
	else
		mMean=Double.parseDouble(request.getParameter("MEAN").toString().trim());

	if(request.getParameter("INITIALAVGP")==null)
		mInitialAVGP=0;
	else
		mInitialAVGP=gb.getRound(Double.parseDouble(request.getParameter("INITIALAVGP").toString().trim()),2);
	if(request.getParameter("FINALAVGP")==null)
		mFinalAVGP=0;
	else
		mFinalAVGP=gb.getRound(Double.parseDouble(request.getParameter("FINALAVGP").toString().trim()),2);

	if(request.getParameter("DEVIATION")==null)
		mDeviation=0;
	else
		mDeviation=gb.getRound(Double.parseDouble(request.getParameter("DEVIATION").toString().trim()),2);
	%>
		<TD ALIGN=CENTER><%=mTotalStudents%></TD>
		<TD ALIGN=CENTER><%=mStudentsRejected%></TD>
		<TD ALIGN=CENTER><%=mStudentsConsidered%></TD>
		<TD ALIGN=CENTER><%=mMean%></TD>
		<TD ALIGN=CENTER><%=mDeviation%></TD> 
		
</tr>
</table>
<br>
<table align=center>
<tr>
<td align=center><b>Grades</B>
</td>
</tr>
</table>
<TABLE bgcolor=#fce9c5 class="sort-table"  width=76% ALIGN=CENTER rules=COLUMNS CELLSPACING=0 BORDER=1> 
<thead>
<tr bgcolor="#ff8c00">
		<TD ALIGN=CENTER><font color=white><b>Grade<B></TD>
		<TD ALIGN=CENTER><font color=white><b>Normal Range(%) of marks<B></TD>
		<TD ALIGN=CENTER><font color=white><b>Initial Boundary  <B></TD>
		<TD ALIGN=CENTER><font color=white><b>Initial Count<B></TD>
		<TD ALIGN=CENTER><font color=white><b>Revised Boundary <B></TD>
		<TD ALIGN=CENTER><font color=white><b>Revised Count<B></TD>
</tr>
</thead>
<%



	qryCAl="select  distinct (select  Distinct CALCULATIONVALUE from grademaster where examcode='"+mExamCode+"' and  grade ='A+' ) CALAP,(select  Distinct CALCULATIONVALUE from grademaster where examcode='"+mExamCode+"' and  grade ='F' )  CALF from grademaster where examcode='"+mExamCode+"' and institutecode='"+mInst+"' " ;

rsCal =db.getRowset(qryCAl);
//out.print(qryCAl);
while(rsCal.next())
{
CALVALUEAP=rsCal.getString("CALAP");
	CALVALUEF=rsCal.getString("CALF");
}

 FCALVALUE = new Integer(CALVALUEF).toString();
//out.print(FCALVALUE+"FFFFFFFF"+CALVALUEF);

int len11=0,pos11=0,pos111=0,pos211=0,pos311=0,pos411=0;
String mGrade="",mRecommendedFrom="",mRecommendedTo="",GradeMasterLowerLimit="";
String InitialCount="",GradeMasterTotalCount="";
int icc=0;
int icf=0;
LinkedHashSet mGradeChecked1=(LinkedHashSet)session.getAttribute("GRADEMASTERSET");	
	if(mGradeChecked1==null)
	{
		mGradeChecked1=new LinkedHashSet();
	}
	Iterator it1=mGradeChecked1.iterator();
   while(it1.hasNext())	
   {
		String element = (String)it1.next();
		len11= element.length();
		pos11= element.indexOf("///");
		pos111=element.indexOf("***");
		pos211=element.indexOf("$$$");
		pos311=element.indexOf("%%%");
		pos411=element.indexOf("###");

		mGrade=element.substring(0,pos11);	



		if(mGrade.equals("D")){
		mRecommendedFrom="Remaining";
		}else {
		mRecommendedFrom=element.substring(pos11+3,pos111);
		}
		if(mGrade.equals("D")){
		mRecommendedTo=FCALVALUE;
		}else {
		mRecommendedTo=element.substring(pos111+3,pos211);
		}
		GradeMasterLowerLimit=element.substring(pos211+3,pos311);
		InitialCount=element.substring(pos311+3,pos411);
		GradeMasterTotalCount=element.substring(pos411+3,len11);
		icc=(int)Double.parseDouble(InitialCount);
		icf=(int)Double.parseDouble(GradeMasterTotalCount);
%>
<tr>
<%
if(!mGrade.equals("I")){	
%>



<TD ALIGN=center><%=mGrade%>&nbsp; </TD>




<TD ALIGN=right><%=mRecommendedFrom%>&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;</TD>
<TD ALIGN=right><%=mRecommendedTo%>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</TD>
<TD ALIGN=right><%=GradeMasterLowerLimit%>&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;</TD>
<!-- <TD ALIGN=right><%=InitialCount%>&nbsp; &nbsp; &nbsp; &nbsp;</TD>
<TD ALIGN=right><%=GradeMasterTotalCount%>&nbsp; &nbsp; &nbsp; &nbsp;</TD> -->
 <TD ALIGN=right><%=icc%>&nbsp; &nbsp; &nbsp; &nbsp;</TD>
<TD ALIGN=right><%=icf%>&nbsp; &nbsp; &nbsp; &nbsp;</TD> 

<%
}else{	
%>
<TD ALIGN=left>&nbsp; </TD>
<TD ALIGN=left>&nbsp; </TD>
<TD ALIGN=left>&nbsp; </TD>
<TD ALIGN=left>&nbsp; </TD>
<TD ALIGN=left>&nbsp; </TD>
<TD ALIGN=left>&nbsp; </TD>
</tr>
<%
}
   }// closing of while
%>
</table>
<TABLE bgcolor=#fce9c5 class="sort-table"  width=76% ALIGN=CENTER rules=COLUMNS CELLSPACING=0 BORDER=1 > 
<thead>
<tr bgcolor="#ff8c00"><td colspan=6><B>Pre-graded Students</B></td></tr></thead>
<tr><td align=left >F</td > <td ><%=mFCOUNT%></td>   </tr>
<tr><td align=left >I</td >  <td><%=mICOUNT%></td> </tr>
 </table>
<br>
 
<br>
<TABLE bgcolor=#fce9c5 class="sort-table"  width=76% ALIGN=CENTER rules=COLUMNS CELLSPACING=0 BORDER=1> 
<tr bgcolor="#ff8c00">		
	<TD colspan=4 ALIGN=CENTER ><strong><b><FONT SIZE="2" COLOR="black">Reasons for Pre-grading students</FONT><B></strong></TD>
	</tr>
	<TR>
		
		<TD ALIGN=CENTER ><b>Absent in T3 End Term exam(F)&nbsp;&nbsp;-&nbsp;($)<B></TD>
		<TD ALIGN=CENTER ><b>Approved Medical cases(I)&nbsp;&nbsp;-&nbsp;(#)<B></TD>
		<TD ALIGN=CENTER ><b>UFM(F)&nbsp;&nbsp;-&nbsp;(@)<B></TD>
		 
		<TD ALIGN=CENTER ><b>DEBAR(F)&nbsp;&nbsp;-&nbsp;(*)<B></TD>
		 
	 
	</TR>

	<%
	 

qrycase=" select  distinct a.Subjectid, b.SubjectCode, b.Subject,        (select count(c.studentid)         from   debarstudentdetail c         where  c.institutecode = '"+mInst+"'         and    c.Examcode = '"+mExamCode+"'         and    c.subjectid = '"+mSubjectCode+"'         and    nvl(c.absentcase,'N') = 'Y' and  c.fstid IN  ( "+xFSTID+" )       ) absent,        (select count(d.studentid)         from   debarstudentdetail d         where  d.institutecode = '"+mInst+"'         and    d.Examcode = '"+mExamCode+"'         and    d.subjectid = '"+mSubjectCode+"'         and    nvl(d.medicalcase,'N') = 'Y'    and   d.fstid IN  ( "+xFSTID+" )     ) Medical,        (select count(e.studentid)         from   debarstudentdetail e         where  e.institutecode = '"+mInst+"'         and    e.Examcode = '"+mExamCode+"'         and    e.subjectid = '"+mSubjectCode+"'         and    nvl(e.UFM,'N') = 'Y'  and  e.fstid IN  ( "+xFSTID+" )    ) UFM,        (select count(f.studentid)         from   debarstudentdetail f         where  f.institutecode = '"+mInst+"'         and    f.Examcode = '"+mExamCode+"'         and    f.subjectid = '"+mSubjectCode+"'         and    nvl(f.Prorata,'N') = 'Y' and  f.fstid IN  ( "+xFSTID+" )     ) ProRata,         (select count(g.studentid)         from   debarstudentdetail g         where  g.institutecode = '"+mInst+"'         and    g.Examcode = '"+mExamCode+"'         and    g.subjectid = '"+mSubjectCode+"'         and    nvl(g.Debar,'N') = 'Y'  and  g.fstid IN  ( "+xFSTID+" )     ) Debar        from    debarstudentdetail a, Subjectmaster b where   a.institutecode = '"+mInst+"' And     a.examcode = '"+mExamCode+"' And     a.subjectid = '"+mSubjectCode+"' and     a.fstid IN  ( "+xFSTID+" ) and     a.institutecode = b.Institutecode and     a.subjectid      = b.subjectid ";

rscase =db.getRowset(qrycase);
    //out.print("AAAAAA- "+qrycase);
while(rscase.next())
{
	  
    mAbsentc=rscase.getInt("absent");
	mMedicalc=rscase.getInt("Medical");
	mUFMc=rscase.getInt("UFM");
	mProdatac=rscase.getInt("ProRata");
	mDebarrc=rscase.getInt("Debar");
	mFcount =mAbsentc +mUFMc+mDebarrc;

}
 

	%>
	<TR>



 
		<TD ALIGN=CENTER ><%=mAbsentc%> <B></TD>
	<TD ALIGN=CENTER ><%=mMedicalc%> </TD>
		<TD ALIGN=CENTER ><b><%=mUFMc%> </TD>
	 
		<TD ALIGN=CENTER ><b><%=mDebarrc%> </TD>
		 
	</TR>
</table><BR>
<table align=center>
<tr>
<td align=center><b><FONT SIZE="4" COLOR="">Available Grades(Initial Boundary)</FONT></B>
</td></TR></TABLE>
<table align=center>
<tr>
<td align=right	 ><b> </B>
</td><td  bgcolor="red"><B>(Absent Students($),</B></td>

<td align=right	 ><b> </B>
</td ><td  bgcolor="green"><B>Medical Case Students(#),</B></td>
<td align=right ><b> </B>
</td><td  bgcolor="yellow"><B>UFM Students(@),</B></td>&nbsp;<td bgcolor="skyblue"><B>DEBAR Students(*)&nbsp;)</B></td>
</tr>
</table>

<TABLE bgcolor=#fce9c5  class="sort-table" id="table-11"  ALIGN=CENTER rules=COLUMNS CELLSPACING=0   BORDER=1> 
<tr>

<td  valign=top >
	<TABLE bgcolor=#fce9c5 class="sort-table" id="table-111"   ALIGN=right rules=COLUMNS CELLSPACING=0   BORDER=1> 

	<thead>
	<tr  bgcolor="#ff8c00">
		<td rowspan=2 Title="Sort on SlNo">
				<Font color=white><b>Sl. <BR> No.</b> </font> </font>
		</td>
	</tr>
	</thead>
		<tbody>

		<% 

int x = 1;
while (x < mTotalStudents+1) 
{
   %>
				<tr   >
			<td bgcolor=white >  <%=x%>  </td>
			</tr>
			
				<%
    x++;
}


			 
 %>

</tbody>
	</table>
	</td>
	<td>


		<TABLE bgcolor=#fce9c5 class="sort-table" id="table-1"   ALIGN=left rules=COLUMNS CELLSPACING=0   BORDER=1> 
		<thead>
	<tr bgcolor="#ff8c00">
 
	<td align=left ><b><font color=white >RollNo.</font></b></td>
	<td align=left ><b><font color=white >Sub<BR>Sec.</font></b></td>
 
	<td align=left ><b><font color=white >Student<BR>Name</font></b></td>
	<%





/*

qry="select distinct a.eventsubevent,b.weightage";
					qry=qry+" from V#STUDENTEVENTSUBJECTMARKS a, ";
					qry=qry+" V#EXAMEVENTSUBJECTTAGGING b where  ";
					
					qry=qry+"  a.examcode='"+mExamCode+"' and a.examcode=b.examcode and a.eventsubevent=b.eventsubevent and ";
					qry=qry+" a.studentid=b.studentid and a.institutecode='"+mInst+"' and a.institutecode=b.institutecode";
					qry=qry+" and a.subjectID='"+mSubjectCode+"'   and nvl(a.DEACTIVE,'N')='N' and ";
					qry=qry+" nvl(a.LOCKED,'N')='Y' and a.subjectID=b.subjectID and nvl(a.DEACTIVE,'N')='N' ";
					qry=qry+" and a.fstid=b.fstid  order by a.eventsubevent";
*/
	
					




//qry="SELECT DISTINCT a.eventsubevent, b.weightage           FROM v#studenteventsubjectmarks a,  v#exameventsubjecttagging b          WHERE  a.examcode = '"+mExamCode+"'            AND a.examcode = b.examcode          AND a.eventsubevent = b.eventsubevent            AND a.studentid = b.studentid            AND a.institutecode ='"+mInst+"'            AND a.institutecode = b.institutecode           AND a.subjectid = '"+mSubjectCode+"'            AND NVL (a.deactive, 'N') = 'N'          AND NVL (a.LOCKED, 'N') = 'Y'            AND a.subjectid = b.subjectid            AND NVL (a.deactive, 'N') = 'N'            AND a.fstid = b.fstid            order by b.weightage";




 

qry="SELECT DISTINCT a.eventsubevent, b.weightage, ";
qry=qry+"decode(a.eventsubevent,'TEST-1','TEST -1',1,'TEST-2', 2, 'TEST-3', 3,'TA#TA1',4,'TA#TA2',5,'TA#TA3',6,'TA#TA4',7,'TA#TA5',8,'TA',9) ordno";
qry=qry+" FROM v#studenteventsubjectmarks a, v#exameventsubjecttagging b ";
qry=qry+" WHERE a.examcode    =   '"+mExamCode+"' ";
qry=qry+" AND a.examcode      =   b.examcode ";
qry=qry+" AND a.eventsubevent =   b.eventsubevent ";
qry=qry+" AND a.studentid     =   b.studentid ";
qry=qry+" AND a.institutecode =   '"+mInst+"' ";
qry=qry+" AND a.institutecode =   b.institutecode ";
qry=qry+" AND a.subjectid     =   '"+mSubjectCode+"'  ";
qry=qry+" AND NVL (a.deactive, 'N') = 'N' ";
qry=qry+" AND NVL (a.LOCKED, 'N') = 'Y' ";
qry=qry+" AND a.subjectid = b.subjectid ";
qry=qry+" AND NVL (a.deactive, 'N') = 'N' ";
qry=qry+" AND a.fstid = b.fstid ";
qry=qry+" order by ordno";
 //out.print(qry);
				 rs=db.getRowset(qry);
				while(rs.next())
				{

				BigDecimal dg=new BigDecimal(rs.getString("Weightage"));
				dg=dg.setScale(0, BigDecimal.ROUND_HALF_DOWN);
				weightageroundg=dg.toString();

				subevents.add(rs.getString("eventsubevent")+"$$$"+weightageroundg);
				}
					
			   if(subevents.size()>0)
					{

						
					
				for( i=0; i<subevents.size();i++)
					{
								
							String aaa=(String)subevents.get(i);

							String cccc=aaa.substring(0,aaa.indexOf("$$$"));


QREY="select distinct LTP from facultysubjecttagging where subjectid = '"+mSubjectCode+"' and examcode='"+mExamCode+"' and institutecode='"+mInst+"' and nvl(projectsubject,'N')='Y' ";
 rsQREY=db.getRowset(QREY);
					if(rsQREY.next()){
					mLTP=rsQREY.getString("LTP");
					}

if(mLTP.equals("P")){
							  tttt=aaa.substring(8,aaa.indexOf("$$$"));
}else{
	  tttt=aaa.substring(0,aaa.indexOf("$$$"));

}


							
							String dddd=aaa.substring(aaa.indexOf("$$$")+3,aaa.length());
							
							%><td align=center ><Font color=white><b><%=tttt%> <BR> (<%=dddd%>)</b></font></td>
						<%
							
							
							if(aa.equals(""))
								aa="'"+cccc+"'";
							else
								aa=aa+",'"+cccc+"'";

							if(qryadd.equals(""))
							{
								qryadd=qryadd+" TRUNC(DECODE(Sum(Decode(xyz.EventSubEvent, '"+cccc+"', total,0)),' ','Absent',Sum(Decode(xyz.EventSubEvent, '"+cccc+"', total,0))),1)  AB"+i+" ";	
								sumadd="CEIL ( NVL(Sum(Decode(xyz.EventSubEvent, '"+cccc+"', total,0)),'0')";
								
							}
							else
							{
								qryadd=qryadd+",TRUNC(DECODE(Sum(Decode(xyz.EventSubEvent, '"+cccc+"', total,0)),' ','Absent',Sum(Decode(xyz.EventSubEvent, '"+cccc+"', total,0))) ,1) AB"+i+" ";	
								sumadd=sumadd+"+"+"NVL(Sum(Decode(xyz.EventSubEvent, '"+cccc+"', total,0)) ,'0')";
								
							}							
							}					
				
						
						//}
						sumadd=sumadd+" ) ";
						%>

						<!-- <td  align=center><b><font color=white >Test-1 + Test-2 + Test-3</font></b></td> -->
	<%if(mLTP.equals("P")){%>

<%}else{%>
<td  align=center><b><font color=white >T1+T2+T3</font></b></td>
<%}%>
<td  align=center><b><font color=white >Total Final<br>Marks</font></b></td>
<td align=center><b><font color=white >Final<br>Grade</font></b></td>
</tr>
</thead>
<tbody>
<%
	int ggg=0;
	 //out.print("AAAAAAA<br>BBBBBBBBB<BR>"+qryadd);
	mGradeChecked=(Set)session.getAttribute("GRADECHECKED");
	if(mGradeChecked==null)
	{
		mGradeChecked=new HashSet();
	}
    mGradeUnChecked=(Set)session.getAttribute("GRADEUNCHECKED");
    Iterator itun=mGradeUnChecked.iterator();
   	while(itun.hasNext())	
     {
		%><!-- <%=ggg++%>*************<BR><BR> --><%
		ctr++;
		String elementtopicInit = (String)itun.next();
	  	lenInit=elementtopicInit.length();
		posInit=elementtopicInit.indexOf("*****");
		pos1Init=elementtopicInit.indexOf("$$$$$");
		pos2Init=elementtopicInit.indexOf("?????");
		pos3Init=elementtopicInit.indexOf("#####");   
		pos4Init=elementtopicInit.indexOf("/////");
		pos5Init=elementtopicInit.indexOf("%%%%%");
		mStudidInit=elementtopicInit.substring(0,posInit);	
		mMarksInit=elementtopicInit.substring(posInit+5,pos1Init);
		mGradInit=elementtopicInit.substring(pos1Init+5,pos2Init);

		mWeightageInit=elementtopicInit.substring(pos2Init+5,pos3Init);
		mInitMarks=elementtopicInit.substring(pos3Init+5,pos4Init);
		mMassCut=elementtopicInit.substring(pos4Init+5,pos5Init);
		mFST=elementtopicInit.substring(pos5Init+5,lenInit);	
		 //out.print(mStudidInit);

	 qry2=" SELECT DISTINCT   studentname || (SELECT ' $'   FROM debarstudentdetail c  WHERE c.institutecode = '"+mInst+"'  AND c.examcode = '"+mExamCode+"'                    AND c.subjectid = '"+mSubjectCode+"'  AND NVL (c.absentcase, 'N') = 'Y' AND c.fstid IN  ("+xFSTID+" )  And c.studentid = xyz.studentID   Union All SELECT '   #'  FROM debarstudentdetail d  WHERE d.institutecode = '"+mInst+"'    AND d.examcode = '"+mExamCode+"'    AND d.subjectid =  '"+mSubjectCode+"' AND ( NVL (d.medicalcase, 'N') = 'Y'   )  AND d.fstid IN  ("+xFSTID+" )   And d.studentid = xyz.studentID  Union all  SELECT '   @'  FROM debarstudentdetail e  WHERE e.institutecode = '"+mInst+"'  AND e.examcode = '"+mExamCode+"'    AND e.subjectid = '"+mSubjectCode+"'   AND NVL (e.ufm, 'N') = 'Y'      AND e.fstid IN    ("+xFSTID+" )   And     e.studentid = xyz.studentID    union all    SELECT '   *'   FROM debarstudentdetail g    WHERE g.institutecode =  '"+mInst+"'   AND g.examcode =  '"+mExamCode+"'  AND g.subjectid = '"+mSubjectCode+"'  AND NVL (g.debar, 'N') = 'Y'    AND g.fstid IN ("+xFSTID+" )  And g.studentid = xyz.studentID )studentname,SUBSECTIONCODE, enrollmentno,  studentid,fstid,"+qryadd+","+sumadd+"  Weightage,CEIL (  NVL (SUM (DECODE (xyz.eventsubevent, 'TEST-1', total, 0)),   '0'   )       + NVL (SUM (DECODE (xyz.eventsubevent, 'TEST -1', total, 0)),  '0'  )         +  NVL (SUM (DECODE (xyz.eventsubevent, 'TEST-2', total, 0)),  '0'   )  + NVL (SUM (DECODE (xyz.eventsubevent, 'TEST-3', total, 0)),  '0' )) T1T2T3Total from ( select ";
					qry2+=" a.SUBSECTIONCODE  SUBSECTIONCODE ,a.EventSubEvent,a.MARKSAWARDED2 MARKSAWARDED2,  (((a.marksawarded2/a.maxmarks)*b.weightage)) total,";
					qry2+=" a.fstid fstid, a.studentid studentid,a.enrollmentno enrollmentno, a.studentname studentname ";
					qry2+=" from V#STUDENTEVENTSUBJECTMARKS a, V#EXAMEVENTSUBJECTTAGGING b  where ";
					qry2+=" a.studentid='"+mStudidInit+"'  and a.examcode='"+mExamCode+"' and a.INSTITUTECODE='"+mInst+"'  AND A.INSTITUTECODE=B.INSTITUTECODE and a.examcode=b.examcode  and ";
					qry2+=" a.eventsubevent=b.eventsubevent and a.studentid=b.studentid and a.subjectID='"+mSubjectCode+"'  ";
					qry2+=" and nvl(a.DEACTIVE,'N')='N' and nvl(a.LOCKED,'N')='Y' and a.subjectID=b.subjectID ";
					qry2+=" and nvl(a.DEACTIVE,'N')='N' and a.fstid=b.fstid and a.EVENTSUBEVENT in ("+aa+") ";
					qry2+=" order by enrollmentno,studentname)xyz group by enrollmentno,studentname,studentid,fstid ,SUBSECTIONCODE order by enrollmentno, studentname   ";
				      // out.print(qry2);
	rs=db.getRowset(qry2);
	if(rs.next())
	{
			mRoll=rs.getString("enrollmentno");


			mName=rs.getString("studentname");


			msubsec=rs.getString("SUBSECTIONCODE");
		%>


		<tr bgcolor=white>
	
		
		<td ><%=mRoll%></td>
		<td><%=msubsec%></td>
		
    <%
//Start of color coding for Debar students By mohit sharma 7/5/2013


	qrydd="  select nvl(absentcase,'N')Absent ,nvl(MEDICALCASE,'N')Medical ,nvl(medicalwithdrawal,'N')MedicalWITH,nvl(UFM,'N')UFM ,nvl(DEBAR,'N')DEBAR from  debarstudentdetail  WHERE  institutecode = '"+mInst+"'     AND  examcode = '"+mExamCode+"'   AND studentid='"+mStudidInit+"'    AND  subjectid = '"+mSubjectCode+"'   AND  fstid IN    ("+xFSTID+" )";
	 // out.print(qrydd);
	rsdd=db.getRowset(qrydd);
	if (rsdd.next())
	{
    xAbsent =rsdd.getString("Absent");
	xMedical =rsdd.getString("Medical");
	xUFM =rsdd.getString("UFM");
	xDEBAR =rsdd.getString("DEBAR");
	XMedicalWITH=rsdd.getString("MedicalWITH");
	
	   if(xAbsent.equals("Y"))
	{
	%>
	<td bgcolor="red">  <%=GlobalFunctions.toTtitleCase(mName)%> </td>
	<%
	}


		else if(xMedical.equals("Y") || XMedicalWITH.equals("Y"))
	{
	%>
	<td bgcolor="green"><%=GlobalFunctions.toTtitleCase(mName)%></td>
	<%
	}

		else if(xUFM.equals("Y"))
	{
	%>
	<td  bgcolor="yellow"><%=GlobalFunctions.toTtitleCase(mName)%></td>
	<%
	}

		else if(xDEBAR.equals("Y"))
	{
	%>
	<td bgcolor="skyblue"> <%=GlobalFunctions.toTtitleCase(mName)%></td>
	<%
	}

	else 
	{
	%>
	<td><%=GlobalFunctions.toTtitleCase(mName)%></td>
	<%
	
	}


	}
	else 
	{
	%>
	<td><%=GlobalFunctions.toTtitleCase(mName)%></td>
	<%
		xAbsent ="";
	xMedical ="";
	xUFM ="";
	xDEBAR ="";
	}
	
	
	//----end of color coding for debar student color

	for(int j=0;j<i;j++)
	{
	%>
	<td align=center><%=rs.getString("AB"+String.valueOf(j))%></td>	
	<%
	}


	BigDecimal d=new BigDecimal(rs.getString("Weightage"));
	d=d.setScale(0, BigDecimal.ROUND_HALF_UP);
	weightageround=d.toString();

	%>	
	

	<%if(mLTP.equals("P")){%>

<%}else{%>
<td align=center ><%=rs.getString("T1T2T3Total")%> </td>
<%}%>
	
	
<% 
	qryttt=" Select 'Y' from  debarstudentdetail where STUDENTID='"+mStudidInit+"' and (UFM='Y' OR ABSENTCASE='Y' OR DEBAR='Y') and examcode='"+mExamCode+"' and institutecode='"+mInst+"' and fstid IN  ("+xFSTID+" )";
rsttt=db.getRowset(qryttt);
//out.print(qryttt);
	if(rsttt.next())
	{
%>
	<td align=center >0</td>				
	


		<%

	}else{
%>
	<td align=center ><%=weightageround%></td>				
	


		<%
	}
			
		if(mCheckRadio.equals("Y"))
		{

		Iterator it=mGradeChecked.iterator();
 		while(it.hasNext())	
		   {
			
				String elementtopic = (String)it.next();
			  	len=elementtopic.length();
				pos=elementtopic.indexOf("*****");
				pos1=elementtopic.indexOf("$$$$$");
				pos2=elementtopic.indexOf("?????");
				pos20=elementtopic.indexOf("#####");
				pos201=elementtopic.indexOf("/////");
				pos2011=elementtopic.indexOf("%%%%%");

				mStudid=elementtopic.substring(0,pos);	
				mMarks=elementtopic.substring(pos+5,pos1);
				mGrad=elementtopic.substring(pos1+5,pos2);
			      mWeightage=elementtopic.substring(pos2+5,pos20);
				mWe=elementtopic.substring(pos20+5,pos201);
				mMass=elementtopic.substring(pos201+5,pos2011);	
				mfst=elementtopic.substring(pos2011+5,len);	

				if(mStudidInit.equals(mStudid))
			   {
			qry1=" select distinct NVL(A.GRADE,'N')GRADE from DEBARSTUDENTDETAIL a  WHERE a.EXAMCODE='"+mExamCode+"' and a.fstid = '"+mfst+"'  and a.INSTITUTECODE='"+mInst+"' and a.STUDENTID='"+mStudidInit+"' AND A.SUBJECTID='"+mSubjectCode+"' and nvl(a.DEACTIVE,'N')='N' AND (NVL(A.MEDICALCASE,'Y')='Y'    OR  NVL(A.ABSENTCASE,'N')='N' OR NVL(A.UFM,'N')='N' ) AND NVL(A.PRORATA,'N')='N' AND A.GRADE IS NOT NULL ";
						//	out.print(qry);
							rs1=db.getRowset(qry1);
							if(rs1.next())
							{

							%>
								<td align=center ><%=rs1.getString("GRADE")%> </td></tr>
							<%
							}
							else
				   {

hhhh=0;
Qryapimr="SELECT 'Y' FROM studentltpdetail    WHERE    studentid IN  ('"+rs.getString("studentid")+"')       AND nvl( IMPROVEMENT,'N')='Y' and  fstid in ("+xFSTID+")  ";
 rsiimr=db.getRowset(Qryapimr);
if(rsiimr.next()){
hhhh=8;

}

if(hhhh==8  &&( mGradInit.equals("A+") || mGradInit.equals("A"))){
	mGradInit="B+";

			%>
				<td align=center ><%=mGradInit%>  </td></tr>
			<%
}

else if(hhhh==8  &&   mGradInit.equals("F")){
	mGradInit="D";

			%>
				<td align=center ><%=mGradInit%>  </td></tr>
			<%
}

			
			else{
			%>
				<td align=center ><%=mGradInit%>  </td></tr>
			<%
			
			}


				   }
				break;
			   }
 // closing of for



		  } // closing of while
		} // closing of if mCheckRadio=Y
	else
	   {
hhhh=0;
Qryapimr="SELECT 'Y' FROM studentltpdetail    WHERE    studentid IN  ('"+rs.getString("studentid")+"')       AND nvl( IMPROVEMENT,'N')='Y' and  fstid in ("+xFSTID+")  ";
 rsiimr=db.getRowset(Qryapimr);
if(rsiimr.next()){
hhhh=8;

}


		 if(hhhh==8  &&   mGradInit.equals("F")){
	mGradInit="D";

			%>
				<td align=center ><%=mGradInit%> </td></tr>
			<%
}

			
			else{
			%>
				<td align=center ><%=mGradInit%> </td></tr>
			<%
			
			}



	   }
	}
    } // closing of while

					}
	qry="select to_char(sysdate,'dd-mm-yyyy hh:mi:ss PM') from dual";
	rs=db.getRowset(qry);
	rs.next();
	String mDat=rs.getString(1);
%>
	</tbody>
	</table>
<script type="text/javascript">
	var st1 = new SortableTable(document.getElementById("table-1"),[ "Number","CaseInsensitiveString"]);
	</script>


</td></tr>
	
</table>	
<!-- <script type="text/javascript">
var st1 = new SortableTable(document.getElementById("table-1"),["Number","Number","CaseInsensitiveString","CaseInsensitiveString","Number","Number","Number","Number","Number" ,"CaseInsensitiveString" ]);
</script> -->
<table width="98%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<input type=hidden name="INSTITUTECODE" id="INSTITUTECODE" value="<%=mInst%>">
<input type=hidden name="EXAMCODE" id="EXAMCODE" value="<%=mExamCode%>">
<input type=hidden name="SUBJECTCODE" id="SUBJECTCODE" value="<%=mSubjectCode%>">
<input type=hidden name="TOTALSTUDENTS" id="TOTALSTUDENTS" value="<%=mTotalStudents%>">
<input type=hidden name="STUDENTREJECTED" id="STUDENTREJECTED" value="<%=mStudentsRejected%>">
<input type=hidden name="STUDENTCONSIDERED" id="STUDENTCONSIDERED" value="<%=mStudentsConsidered%>">
<input type=hidden name="MEAN" id="MEAN" value="<%=mMean%>">
<input type=hidden name="INITIALAVGP" id="INITIALAVGP" value="<%=mInitialAVGP%>">
<input type=hidden name="FINALAVGP" id="FINALAVGP" value="<%=mFinalAVGP%>">
<input type=hidden name="DEVIATION" id="DEVIATION" value="<%=mDeviation%>">
<input type=hidden name="ETOD" id="ETOD" value="<%=mETOD%>">
<input type="hidden" name="SEMESTER" id="SEMESTER" value="<%=mSem1%>">
<input type=hidden name="CTR" id="CTR" value="<%=mCheck%>">
<TD align=center>
<font size=2 color="red" face=arial>
 &nbsp; &nbsp; &nbsp;
 </TD>
</font></td></tr>
		  
</TABLE>
</form>
<br>
<table width=76% align=center>
<tr>
<td align=left>
Name:-<br>
Signature of Course Co-ordinator:<br>
Submitted on..<%=mDat%>
</td>
<!-- <td align=right>*Detained Candidate 
</td> -->
</tr>

</tr>
</table>
<table width=80% align=center>
<tr>
<td nowrap align=center title="Click to Print" valign=top>
<table width=10% align=center border=2 bordercolor=magroon><tr><td align=center nowrap><font color=blue>
<b>Click  <a style="CURSOR:hand" onClick="window.print();"><img src="../../Images/printer.gif"></a> To Print</b></font></td></tr></table></td>
</tr>
</table>
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
	// out.print(e);
}
%>
