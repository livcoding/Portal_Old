<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*,java.util.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
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
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Student Wise Grade</b></TD>
</font></td></tr>
</TABLE>
<%
try
{
GlobalFunctions gb =new GlobalFunctions();
OLTEncryption enc=new OLTEncryption();
DBHandler db=new DBHandler();

String  mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="";
String mInst="",mExamCode="",mSubjectCode="";
int mTotalStudents=0,mStudentsRejected=0,mStudentsConsidered=0;
double mMean=0,mInitialAVGP=0,mFinalAVGP=0,mDeviation=0;
int len11=0,pos11=0,pos111=0,pos211=0,pos311=0,pos411=0;
String mGrade="",mRecommendedFrom="",mRecommendedTo="",GradeMasterLowerLimit="",mFst="";
String InitialCount="",GradeMasterTotalCount="";	
int mCheck=0;
String mName1="",abc="",qry="",qry1="",qry2="",qry3="",qry4="",qry5="",qry6="",qry8="";
ResultSet rs5=null,rs6=null;
String mSemType="",mSem="",mETOD="",mSem1="";

Connection con = null;
Statement st = null;
int mStatus=0;
int mError=0;

int pos2Init=0,pos2=0,pos3Init=0,pos20=0;
String mWeightageInit="",mWeightage="";
int pos4Init=0,pos201=0;
String mMassCut="",mMass="";
String mInitMarks="",mWe="";
String mName11="",abc1="";



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
		String mFType="";
	
				if (mDMemberType.equals("E"))
					mFType="I";
				else if(mDMemberType.equals("V"))
					mFType="E";

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

String mSave="";

if(request.getParameter("Save")==null)
	mSave="N";
else
	mSave=request.getParameter("Save").toString().trim();

if(mSave.equals("Y"))
{

	if(request.getParameter("CTR")==null)
		mCheck=0;
	else
	mCheck=Integer.parseInt(request.getParameter("CTR").toString().trim());

	
	
	if(request.getParameter("SEMESTER")==null)
		mSem1="";
	else
	mSem1=request.getParameter("SEMESTER").toString().trim();

	if(request.getParameter("INSTITUTECODE")==null)
		mInst="";
	else
		mInst=request.getParameter("INSTITUTECODE").toString().trim();

	if(request.getParameter("EXAMCODE")==null)
		mExamCode="";
	else
		mExamCode=request.getParameter("EXAMCODE").toString().trim();

	if(request.getParameter("SUBJECTCODE")==null)
		mSubjectCode="";
	else
		mSubjectCode=request.getParameter("SUBJECTCODE").toString().trim();
	
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
	
	if(request.getParameter("ETOD")==null)
		mETOD="";
	else
		mETOD=request.getParameter("ETOD").toString().trim();

String qrysl="";
ResultSet rssl=null;
String mBreakSlno="",mSubjectCode1="",qryss="";
ResultSet rss=null; 

qryss="select subjectcode from  subjectmaster where subjectid='"+mSubjectCode+"' ";
rss=db.getRowset(qryss);
rss.next();
mSubjectCode1=rss.getString(1);
if(mExamCode!=null && !mExamCode.equals(""))
		{
DBConn co = null;
try
  {
	co = new DBConn();
	con = co.DBConOpen();

	st = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	con.setAutoCommit(false);

qrysl="Select Lpad(nvl(MAX(TO_NUMBER(SUBSTR(BREAK#SLNO,6,3))),0)+1,3,'0') ";
qrysl=qrysl+" From V#EX#GRADESUBJECTBREAKUP  where Examcode='"+mExamCode+"' and subjectid='"+mSubjectCode+"'  ";
rssl=db.getRowset(qrysl);

if(rssl.next())
{
	mBreakSlno=mSubjectCode1+rssl.getString(1);
}

for(int i=1;i<=mCheck;i++)
{

	mName1="FSTID"+i;
	abc=request.getParameter(mName1);

qry6="select 'y' from EX#GRADESUBJECTBREAKUP where FSTID='"+abc+"' and EMPLOYEEID='"+mChkMemID+"'  ";
rs6=db.getRowset(qry6);
 
if(rs6.next())
{
	mStatus=1;
}
else
{
	
	
	if(abc.equals("null") || abc.equals("") || abc==null)
	{
	
	}
	else
	{
	
	qry8="UPDATE EXAMEVENTSUBJECTTAGGING set LOCKED='Y' WHERE FSTID='"+abc+"' ";
	qry8=qry8+" AND nvl(PUBLISHED,'N')='Y' and nvl(PROCEEDSECOND,'N')='Y' AND ";
	qry8=qry8+" nvl(DEACTIVE,'N')='N' ";
	st.addBatch(qry8);	
			
		qry1="INSERT INTO EX#GRADESUBJECTBREAKUP(FSTID, BREAK#SLNO, ETOD,FACULTYTYPE, EMPLOYEEID) ";
		qry1=qry1+" VALUES ('"+abc+"' ,'"+mBreakSlno+"' ,'"+mETOD+"','"+mFType+"','"+mChkMemID+"' ) ";
		st.addBatch(qry1);
// out.print(qry1);
		
	}		
}
} // closing of for


if(mStatus==0)
 {
qry2="INSERT INTO GRADECALCULATION (INSTITUTECODE, EXAMCODE, SUBJECTID,BREAK#SLNO, ";
qry2=qry2+" TOTALSTUDENT, REJECTEDSTUDENT, STUDENTCONSIDERED, MEAN, INITIALAVGP,AVGP, ";
qry2=qry2+" DEVIATION,GRADEFLAG,ENTRYBY,ENTRYDATE,STATUS ) ";
qry2=qry2+" VALUES ('"+mInst+"' ,'"+mExamCode+"' ,'"+mSubjectCode+"' ,'"+mBreakSlno+"' , ";
qry2=qry2+" '"+mTotalStudents+"' ,'"+mStudentsRejected+"' ,'"+mStudentsConsidered+"' ,";
qry2=qry2+" '"+mMean+"' ,'"+mInitialAVGP+"' ,'"+mFinalAVGP+"', '"+mDeviation+"','"+mETOD+"','"+mChkMemID+"',SYSDATE,'D') ";
st.addBatch(qry2);
	//out.print(qry2);
	LinkedHashSet mGradeChecked=(LinkedHashSet)session.getAttribute("GRADEMASTERSET");	
	if(mGradeChecked==null)
	{
		mGradeChecked=new LinkedHashSet();
	}
	Iterator it=mGradeChecked.iterator();
   while(it.hasNext())	
   {
		String element = (String)it.next();
		len11=element.length();
		pos11=element.indexOf("///");
		pos111=element.indexOf("***");
		pos211=element.indexOf("$$$");
		pos311=element.indexOf("%%%");
		pos411=element.indexOf("###");

		mGrade=element.substring(0,pos11);	
		mRecommendedFrom=element.substring(pos11+3,pos111);
		mRecommendedTo=element.substring(pos111+3,pos211);
		GradeMasterLowerLimit=element.substring(pos211+3,pos311);
		InitialCount=element.substring(pos311+3,pos411);
		GradeMasterTotalCount=element.substring(pos411+3,len11);
// if(Double.parseDouble(mRecommendedFrom)>0 && Double.parseDouble(mRecommendedTo)>0 )
// {
	
	qry3="INSERT INTO GRADECALCULATIONGRADES(INSTITUTECODE, EXAMCODE, SUBJECTID,BREAK#SLNO,GRADE, ";
	qry3=qry3+" RECOMMENDEDFROM,RECOMMENDEDTO,STANDEREDLOWERLIMIT, INITIALCOUNT,FINALCOUNT,GRADEFLAG)  ";
	qry3=qry3+" VALUES ('"+mInst+"' ,'"+mExamCode+"' ,'"+mSubjectCode+"' ,'"+mBreakSlno+"' , ";
	qry3=qry3+" '"+mGrade+"' ,'"+mRecommendedFrom+"' ,'"+mRecommendedTo+"' ,'"+GradeMasterLowerLimit+"' , ";
	qry3=qry3+" '"+InitialCount+"' ,'"+GradeMasterTotalCount+"','"+mETOD+"') ";
  
	st.addBatch(qry3);
	//out.print(qry3);	
 //  } // closing of if
} // closing of while

int len=0;
int pos=0,pos1=0;
int lenInit=0;
int posInit=0,pos1Init=0;
String mStudid="",mMarks="",mGrad="";
String mStudidInit="",mMarksInit="",mGradInit="";
String mName="";

int pos2011=0,pos5Init=0;
String mFST="",mfst="";

Set mGradeChecked1=new HashSet();
Set mGradeUnChecked=new HashSet();

	mGradeChecked1=(Set)session.getAttribute("GRADECHECKED");
	if(mGradeChecked1==null)
	{
		mGradeChecked1=new HashSet();
	}
    mGradeUnChecked=(Set)session.getAttribute("GRADEUNCHECKED");
    Iterator itun=mGradeUnChecked.iterator();
   	while(itun.hasNext())	
   {
		
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

	    Iterator iti=mGradeChecked1.iterator();
//System.out.println(mFST);
 	    while(iti.hasNext())	
		 {
				String elementtopic = (String)iti.next();

//out.print(elementtopic+"<br>");
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
/*
qry5="select fstid,semester,semestertype from V#studentLTpDetail where institutecode='"+mInst+"' and ";
qry5=qry5+" examcode='"+mExamCode+"'  and subjectid='"+mSubjectCode+"' and studentid='"+mStudid+"' and (LTP='L' OR PROJECTSUBJECT='Y') ";
qry5=qry5+" and nvl(DEACTIVE,'N')='N' ";
rs5=db.getRowset(qry5);
if(rs5.next())
{
	mFst=rs5.getString("fstid");
}
else
{
}
*/
qry4="INSERT INTO STUDENTWISEGRADE(INSTITUTECODE,EXAMCODE,FSTID,BREAK#SLNO, STUDENTID, ";
qry4=qry4+" INITIALMARKS,INITIALGRADE, ";
qry4=qry4+" FINALMARKS,FINALGRADE,ENTRYBY,ENTRYDATE,DOCMODE,MASSCUTS,GRADEFLAG) ";
qry4=qry4+" VALUES ('"+mInst+"','"+mExamCode+"','"+mfst+"' ,'"+mBreakSlno+"', ";
qry4=qry4+" '"+mStudid+"' ,'"+mInitMarks+"' ,'"+mGradInit+"' , ";
qry4=qry4+" '"+mMarksInit+"' ,'"+mGrad+"','"+mChkMemID+"',SYSDATE,'D','"+mMassCut+"','"+mETOD+"') ";
st.addBatch(qry4);
		break;
	   } // closing of if
  } // closing of while
		
  } // closing of while

//***************************student grades to save*****************

int updateCounts[] = st.executeBatch();
if(updateCounts.length>0)
 {
	mError=1;


	// Log Entry
	//-----------------
    db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"Grade Entry ", "ExamCode: "+mExamCode+ " subjectid :  "+mSubjectCode+" MemberID :"+mChkMemID,"NO MAC Address",mIPAddress);
	//-----------------


	%>
	<br>
	<br>
<table width=100%>
<TR>
<td align=center>
<a href="StudentGrades1.jsp?ExamCode=<%=mExamCode%>&amp;SEMESTER=<%=mSem1%>&amp;Subject=<%=mSubjectCode%>&amp;TOTALSTUDENTS=<%=mTotalStudents%>&amp;STUDENTREJECTED=<%=mStudentsRejected%>&amp;STUDENTCONSIDERED=<%=mStudentsConsidered%>&amp;MEAN=<%=mMean%>&amp;DEVIATION=<%=mDeviation%>&amp;INITIALAVGP=<%=mInitialAVGP%>&amp;FINALAVGP=<%=mFinalAVGP%>&amp;CHECKRADIO=Y" target=_new >
<!-- 
<a href="StudentGrades1.jsp?ExamCode=<%=mExamCode%>&amp;Subject=<%=mSubjectCode%>&amp;CHECKRADIO=Y " > 
-->
<font color=green><b>Record Saved succesfully.............<br>
Click here to view and take print out of result.</b></font></a>
</td>
</tr>
</table>
<%
 }
 else
 {
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Error While Saving Record...... </font> <br>");
	
 }

 } // closing of mStauts==0
 if(mStatus==1)
 {
	 %>
<br>
	<br>
<table width=100%>
<TR>
<td align=center>
<a href="StudentGrades1.jsp?ExamCode=<%=mExamCode%>&amp;SEMESTER=<%=mSem1%>&amp;Subject=<%=mSubjectCode%>&amp;TOTALSTUDENTS=<%=mTotalStudents%>&amp;STUDENTREJECTED=<%=mStudentsRejected%>&amp;STUDENTCONSIDERED=<%=mStudentsConsidered%>&amp;MEAN=<%=mMean%>&amp;DEVIATION=<%=mDeviation%>&amp;INITIALAVGP=<%=mInitialAVGP%>&amp;FINALAVGP=<%=mFinalAVGP%>&amp;CHECKRADIO=Y" target=_new >
<!--
<a href="StudentGrades1.jsp?ExamCode=<%=mExamCode%>&amp;Subject=<%=mSubjectCode%>&amp;CHECKRADIO=Y " >
-->
<font color=green><b>Record Saved succesfully.............<br>
Click here to view and take print out of result.</b></font></a>
</td>
</tr>
</table>
<%
	  }

con.commit();
con.close();
co.DBConClose();
}

	catch(Exception e)
	{
		con.close();
		co.DBConClose();
		//out.print(e);
	}
		}

		mExamCode=null;
 //**************Closing of mSave=Y
	}
	else
	{
   %>
	<br>
	<font color=red>
	<h3><br><img src='../../Images/Error1.jpg'>
	<font color=red><b>Grade not saved.....<br>
	First check the save marks checkbox and than save.
	</b></font></a>
	</font><br>  
   <%
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
/*
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}
*/
}
catch(Exception e)
{
	//out.print(e);
}
%>
