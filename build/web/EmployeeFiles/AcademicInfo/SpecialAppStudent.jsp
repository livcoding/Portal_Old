<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 

<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT";

//if( System.IO.File.Exists(""))
%>
<HTML>
<head>
<link type="text/css" rel="StyleSheet" href="css/style.css" />
<TITLE>#### <%=mHead%> [ Change Time Table ] </TITLE>


<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

<script language=javascript>

	function RefreshContents()
	{
    	    document.frm.x.value='ddd';
    	    document.frm.submit();
	}
//-->
</SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">
function ChangeOptions(Exam,DataSubject,DataCombo,Subject,Student)
{


     removeAllOptions(Subject);
	var QrySubject='';
     for(i=0;i<DataSubject.options.length;i++)
       {
		var v1;
		var pos;
		var ec;
		var ev;
		var len;
		var otext;
		var v1=DataSubject.options(i).value;
		len= v1.length ;
		pos=v1.indexOf('***');
		ec=v1.substring(0,pos);
		ev=v1.substring(pos+3,len);
		if (ec==Exam)
		 {
			var optn = document.createElement("OPTION");
			optn.text=DataSubject.options(i).text;
			optn.value=ev;
			if (QrySubject=='') QrySubject=ev;
			Subject.options.add(optn);

		}

	 }


       alert(DataCombo.options.length);
 	    removeAllOptions(Student);
	    for(i=0;i<DataCombo.options.length;i++)
	      {
			var v1s;
			var pos1;
			var pos2;
			var exams;
			var evs;
			var lens;
			var sc;
			var otexts;
			var v1s=DataCombo.options(i).value;
			lens= v1s.length ;
			pos1=v1s.indexOf('***');
			pos2=v1s.indexOf('///')
			exams=v1s.substring(0,pos1);
			evs=v1s.substring(pos1+3,pos2);
			sc=v1s.substring(pos2+3,lens);

		if (exams==Exam && QrySubject==evs)
		 {
			var optns = document.createElement("OPTION");
			optns.text=DataCombo.options(i).text;
			optns.value=sc;
			Student.options.add(optns);
		}

	 }
  	}
// ----------click Subject on SubjectSubSubject------------

function ChangeOptions1(Exam,QrySubject,DataCombo,Student)
{
     	removeAllOptions(Student);
//alert(QrySubject);
	for(i=0;i<DataCombo.options.length;i++)
       {
			var v1s1;
			var pos11;
			var pos21;
			var exams1;
			var evs1;
			var lens1;
			var sc1;
			var otexts1;
			var v1s1=DataCombo.options(i).value;

			lens1= v1s1.length ;
			pos11=v1s1.indexOf('***');
			pos21=v1s1.indexOf('///');
			exams1=v1s1.substring(0,pos11);
			evs1=v1s1.substring(pos11+3,pos21);
			sc1=v1s1.substring(pos21+3,lens1);
			if (exams1==Exam && QrySubject==evs1)
	    	 {
               //  alert(sc1+" --- "+Exam);

				var optns1 = document.createElement("OPTION");
				optns1.text=DataCombo.options(i).text;
				optns1.value=sc1;

				Student.options.add(optns1);
			}
		 }
   }


function removeAllOptions(selectbox)
{
var i;
	for(i=selectbox.options.length-1;i>=0;i--)
	{
		selectbox.remove(i);
	}
}

</SCRIPT>

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>


<body aLink=#ff00ff rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="",mDept="",mDesg="",mInst="",mComp="", mDMemberID="";
String mExam="",mexam="",mExamid="",mSubject="",mSubj="",msubj="";
String qry="",qry1="",x="",QryEventSubevent="";
int msno=0;
double mvalue=0,mMaxmarks=0,MyMax=0,mchkmarks=0;
String mmvalue="";
int ctr=0;
String mIC="",mEC="",mSC="",mList="",mOrder="",mEvent=""; //,mExamsubevent="",mExamevent="";
ResultSet rs=null,rss=null,rs1=null,rs2=null,rs3=null,rse=null,rsm=null,rsi=null;
String mMOP="",mName5="",mlistorder="";
int kk=0;
String msubeven="",mMarks="",mPerc="",mName1="",mMark="",mName2="",mName3="",mName4="",mName8="";
String mName6="",mName7="", TRCOLOR="White";
String mSubject1="",mSubj1="",QryExam="",examidm="",msubj1="",mSubject2=""  ;


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
if (session.getAttribute("Designation")==null)
{
	mDesg="";
}
else
{
	mDesg=session.getAttribute("Designation").toString().trim();
}

if (session.getAttribute("Department")==null)
{
	mDept="";
}
else
{
	mDept=session.getAttribute("Department").toString().trim();
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

	OLTEncryption enc=new OLTEncryption();
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);
		mDMemberID=enc.decode(mMemberID);

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk1=null;

  //-----------------------------
  //-- Enable Security Page Level
  //-----------------------------

	qry="Select WEBKIOSK.ShowLink('85','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk1= db.getRowset(qry);
	if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
	{
  //----------------------
%>
	<form name="frm" method=post>
	<input id="x" name="x" type=hidden>
	<table ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD align=middle><font  face="Comic Sans MS" color="#a52a2a"  size=4 ><b><u>Special Student Approval</u></b><font size=3></font</font></td></tr>
	</table>
	<table cellpadding=6 cellspacing=1 align=center rules=groups border=1    borderColor=#a52a2a borderColorDark=white>
	<tr><td bgcolor=#a52a2a>&nbsp; <font color=white face=arial size=3><STRONG><%=mMemberName%> [<%=mDMemberCode%>]
	&nbsp;: &nbsp; &nbsp;<%=GlobalFunctions.toTtitleCase(mDesg)%>&nbsp; [<%=GlobalFunctions.toTtitleCase(mDept)%>]

	<!--Institute****-->

	</td></tr>
	<tr><td>
<!--*********Exam**********-->
	<FONT color=black><FONT face=Arial size=2><STRONG>&nbsp; Exam Code</STRONG></FONT></FONT>
<%


	try
	{
		qry=" Select GRADEENTRYEXAMID from (";
		qry+=" Select distinct nvl(EXAMCODE,' ') GRADEENTRYEXAMID , EXAMPERIODFROM from EXAMMASTER " +
                "Where INSTITUTECODE='"+mInst+"' AND nvl(lockexam,'N')='N' AND nvl(Deactive,'N')='N' ";
		qry+=" and examcode in (Select examcode from facultysubjecttagging where INSTITUTECODE='"+mInst+"' )";
      	qry+=" order by EXAMPERIODFROM DESC";
		qry+=") where rownum<8";
		rs=db.getRowset(qry);
		//out.print(qry);
		if (request.getParameter("x")==null)
		{
		%>
			<select name=Exam tabindex="0" id="Exam" style="WIDTH:150px" onclick="ChangeOptions(Exam.value,DataSubject,DataCombo,Subject,Student);" onChange="ChangeOptions(Exam.value,DataSubject,DataCombo,Subject,Student);">
		<%
			while(rs.next())
			{
               //mEventcode=rs.getstring("ExamEeventSubevent");
				mExamid=rs.getString("GRADEENTRYEXAMID");
				if(QryExam.equals(""))
				{
					QryExam=mExamid;
					%>
					<OPTION selected Value =<%=mExamid%>><%=mExamid%></option>
					<%
				}
				else
				{
					%>
					<OPTION  Value =<%=mExamid%>><%=mExamid%></option>
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
			<select name=Exam tabindex="0" id="Exam" style="WIDTH: 150px" onclick="ChangeOptions(Exam.value,DataSubject,DataCombo,Subject,Student);" onChange="ChangeOptions(Exam.value,DataSubject,DataCombo,Subject,Student);">
			<%
			while(rs.next())
			{
				mExamid=rs.getString("GRADEENTRYEXAMID");

				if(mExamid.equals(request.getParameter("Exam").toString().trim()))
 				{
					QryExam=mExamid;
					%>
					<OPTION selected Value =<%=mExamid%>><%=mExamid%></option>
					<%
			     	}
			     	else
		      	{
					%>
		      		<OPTION Value =<%=mExamid%>><%=mExamid%></option>
		      		<%
		   		}
			}
			%>
			</select>
		  	<%
		}
 	}
	catch(Exception e)
	{
	    //out.println(e.getMessage());
	}
//********************DataSubject Combo*************/

	try
	{
/*	qry="select distinct A.EMPLOYEEID, A.EMPLOYEENAME, A.EMPLOYEECODE ,aa.examcode from  EMPLOYEEMASTER A ,facultysubjecttagging AA  where ";
	qry+=" A.EMPLOYEEID=aa.employeeid and  aa.INSTITUTECODE='"+mInst+"'" +
            " and aa.facultytype=decode('"+mDMemberType+"','E','I','E') and nvl(a.deactive,'N')='N'" +
            " AND aa.employeeid='"+mDMemberID+"' ";
*/

   qry=" Select Distinct nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
	qry=qry+" from  facultysubjecttagging A,SUBJECTMASTER B where  ";
	//qry=qry+" A.facultytype=decode('"+mDMemberType+"','E','I','E') and ";
	qry=qry+" A.institutecode='"+mInst+"' and A.examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
	qry=qry+" and nvl(FINALIZED,'N')='Y' and NVL(DEACTIVE,'N')='Y' )  AND NVL (A.deactive, 'N') = 'N'  AND NVL (B.deactive, 'N') = 'N' AND A.Institutecode=B.Institutecode AND A.SUBJECTID=B.SUBJECTID";
	qry=qry+" order by subject";
    
	rse=db.getRowset(qry);
	//out.print(qry);
	if (request.getParameter("x")==null)
	{
		%>
		<select name=DataSubject tabindex="0" id="DataSubject" style="WIDTH: 0px">
		<%
		while(rse.next())
		{
			mSubject1=rse.getString("examcode")+"***"+rse.getString("subjectid").toString().trim();
			%>
			<OPTION SELECTED Value ="<%=mSubject1%>"><%=rse.getString("subject")%></option>
			<%
		}
		%>
		</select>
		<%
	}
	else
	{
		%>
		<select name=DataSubject tabindex="0" id="DataSubject" style="WIDTH: 0px">
		<%
		while(rse.next())
		{
			mSubject1=rse.getString("examcode")+"***"+rse.getString("subjectid").toString().trim();
			if(mSubject1.equals(request.getParameter("DataSubject").toString().trim()))
 			{
				%>
				<OPTION selected Value ="<%=mSubject1%>"><%=rse.getString("subject")%></option>
				<%
		     	}
		     	else
		      {
				%>
		      	<OPTION Value ="<%=mSubject1%>"><%=rse.getString("subject")%></option>
			     	<%
		   	}
		}
		%>
		</select>
	  	<%
	 }

	}
	catch(Exception e)
	{
		//out.print("error");
	}
	//********************Subject Combo************/

	%>
	&nbsp;&nbsp;<FONT color=black><FONT face=Arial size=2><STRONG>Subject </STRONG></FONT></FONT>
	<%
    String QryEMPLOYEEID="";

	try
	{

//out.print(request.getParameter("Faculty")+"LLLLL");



    	qry=" Select Distinct nvl(A.subjectid,'N') subjectid, nvl(B.subjectcode,'N') subjectcode,B.subject sbj, " +
                "nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
	qry=qry+" from  facultysubjecttagging A,SUBJECTMASTER B where  ";
	//qry=qry+"  A.facultytype=decode('"+mDMemberType+"','E','I','E') and ";
	qry=qry+" A.institutecode='"+mInst+"' and A.examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
	qry=qry+" and nvl(FINALIZED,'N')='Y' and NVL(DEACTIVE,'N')='Y' ) AND A.institutecode=B.institutecode AND A.SUBJECTID=B.SUBJECTID";
	qry=qry+" and A.EXAMCODE='"+QryExam+"'  AND NVL (A.deactive, 'N') = 'N'            AND NVL (B.deactive, 'N') = 'N' order by subject";
	//out.print(qry);
	rse=db.getRowset(qry);
out.print(qry);
	if (request.getParameter("x")==null)
	{
           %>
		<select name="Subject" tabindex="0" id="Subject" onclick="ChangeOptions1(Exam.value,Subject.value,DataCombo,Student);"
            onChange="ChangeOptions1(Exam.value,Subject.value,DataCombo,Student);" >
        <%
		while(rse.next())
            {
                 mSubject=rse.getString("subjectid");

				if(mSubject2.equals(""))
				{
					mSubject2=mSubject;
					%>
					<OPTION selected Value ="<%=mSubject%>"><%=rse.getString("subject")%></option>
					<%
				}
				else
				{
					%>
					<OPTION  Value ="<%=mSubject%>"><%=rse.getString("subject")%></option>
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
		<select name="Subject" tabindex="0" id="Subject" onclick="ChangeOptions1(Exam.value,Subject.value,DataCombo,Student);"
            onChange="ChangeOptions1(Exam.value,Subject.value,DataCombo,Student);" >
        <%
		while(rse.next())
		{
			mSubject=rse.getString("subjectid").toString().trim();

			if(mSubject.equals(request.getParameter("Subject").toString().trim()))
 			{mSubject2=mSubject;
			%>
				<OPTION selected Value ="<%=mSubject%>"><%=rse.getString("subject")%></option>
				<%
		     	}
		     	else
		      {
				%>
		      	<OPTION Value ="<%=mSubject%>"><%=rse.getString("subject")%></option>
		      	<%
		   	}
		}
		%>
		</select>
		<%
	 }

	}
	catch(Exception e)
	{
		out.print(e+"error");
	}






//******************DataCombo Subject********************/
try
{
	/*qry="select A.subject ||' ( '||A.subjectcode||' )' subject,A.subjectID,A.examcode,A.eventsubevent from V#STUDENTEVENTSUBJECTMARKS A where ";
	qry+=" a.INSTITUTECODE='"+mInst+"'  and (A.fstid) in (";
	qry+=" select AA.fstid from facultysubjecttagging AA where aa.INSTITUTECODE='"+mInst+"'  and facultytype=decode('"+mDMemberType+"','E','I','E') and nvl(deactive,'N')='N' AND employeeid='"+mDMemberID+"'  AND (LTP='L' or LTP='P' OR NVL(PROJECTSUBJECT,'N')='Y')";
	qry+=" UNION select AA.fstid from MultiFacultySubjectTagging aa where aa.INSTITUTECODE='"+mInst+"' and aa.COMPANYCODE='"+mComp+"'" +
            " and aa.EMPLOYEEID='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
	//qry+=" UNION select AA.fstid from Ex#SubjectGradeCoordinator aa where aa.INSTITUTECODE='"+mInst+"' and aa.COMPANYCODE='"+mComp+"' and aa.FACULTYID='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
	//qry+=" UNION select AA.fstid from StudentEventProjectMarks1 aa where aa.MARKS1ENTRYBY='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
	//qry+=" UNION select AA.fstid from StudentEventProjectMarks2 aa where aa.MARKS2ENTRYBY='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
	//qry+=" UNION select AA.fstid from StudentEventSubjectMarks aa where aa.INSTITUTECODE='"+mInst+"'  and aa.ENTRYBY='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
	qry+=" ) and nvl(A.PUBLISHED,'N')='Y' ";
	qry+=" GROUP BY A.subject ||' ( '||A.subjectcode||' )',A.subjectID,A.examcode,A.eventsubevent order by examcode, eventsubevent ";
*/



	qry=" select Distinct STUDENTID, ENROLLMENTNO, STUDENTNAME,subjectid,examcode from  v#studentltpdetail where  " +
            " institutecode='"+mInst+"' and fstid in (select fstid from facultysubjecttagging where institutecode='"+mInst+"' " +
            "  and   NVL(DEACTIVE,'N')='N' )  and  NVL(DEACTIVE,'N')='N'  and NVL(STUDENTDEACTIVE,'N')='N' order by ENROLLMENTNO";
	out.print(qry);
	//out.print(qry);
	rss=db.getRowset(qry);
	if (request.getParameter("x")==null)
	{
		%>
		<select name=DataCombo tabindex="0" id="DataCombo" style="WIDTH:0px">
		<%
		while(rss.next())
		{
			mSubj1=rss.getString("examcode")+"***"+rss.getString("subjectid").toString().trim()+"///"+rss.getString("STUDENTID");

			if(msubj.equals(""))
 			msubj=mSubj1;
			%>
			<OPTION Value ="<%=mSubj1%>"><%=rss.getString("STUDENTNAME")%> - <%=rss.getString("ENROLLMENTNO")%></option>
			<%
		}
		%>
		</select>
		<%
	}
	else
	{
		%>
		<select name="DataCombo" tabindex="0" id="DataCombo" style="WIDTH: 0px">
		<%
		while(rss.next())
		{
		mSubj1=rss.getString("examcode")+"***"+rss.getString("subjectid").toString().trim()+"///"+rss.getString("STUDENTID");

			if(mSubj1.equals(request.getParameter("DataCombo").toString().trim()))
 			{
				msubj=mSubj1;
				%>
				 <OPTION selected Value ="<%=mSubj1%>"><%=rss.getString("STUDENTNAME")%> - <%=rss.getString("ENROLLMENTNO")%></option>
				<%
		     	}
		     	else
		      {
				%>
			     	<OPTION Value ="<%=mSubj1%>"><%=rss.getString("STUDENTNAME")%> - <%=rss.getString("ENROLLMENTNO")%></option>
		      	<%
		   	}
		}
		%>
		</select>
	  	<%
	 }
 }
catch(Exception e)
{
	out.print(e+" LLLLLLLL");
}
%>





	</td></tr>
<tr><td>





<!--SUBJECT**************-->
&nbsp; &nbsp;
<FONT color=black><FONT face=Arial size=2><STRONG>&nbsp; &nbsp; Student</STRONG></FONT></FONT>
<%

	try
	{/*
	qry="select A.subject ||' ( '||A.subjectcode||' )' subject, A.subjectID from V#STUDENTEVENTSUBJECTMARKS A where ";
	qry+=" a.INSTITUTECODE='"+mInst+"'  and  (A.fstid) in (";
	qry+=" select AA.fstid from facultysubjecttagging AA where aa.INSTITUTECODE='"+mInst+"'  and " +
            "facultytype=decode('"+mDMemberType+"','E','I','E') and nvl(deactive,'N')='N' AND" +
            " employeeid='"+mDMemberID+"'  AND (LTP='L' or LTP='P' OR NVL(PROJECTSUBJECT,'N')='Y')";
	qry+=" UNION select AA.fstid from MultiFacultySubjectTagging aa where aa.INSTITUTECODE='"+mInst+"' " +
            "and aa.COMPANYCODE='"+mComp+"' and aa.EMPLOYEEID='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
	//qry+=" UNION select AA.fstid from Ex#SubjectGradeCoordinator aa where aa.INSTITUTECODE='"+mInst+"' and aa.COMPANYCODE='"+mComp+"' and aa.FACULTYID='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
	//qry+=" UNION select AA.fstid from StudentEventProjectMarks1 aa where aa.MARKS1ENTRYBY='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
	//qry+=" UNION select AA.fstid from StudentEventProjectMarks2 aa where aa.MARKS2ENTRYBY='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
	//qry+=" UNION select AA.fstid from StudentEventSubjectMarks aa where aa.INSTITUTECODE='"+mInst+"'  and  aa.ENTRYBY='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
	qry=qry+" )and nvl(PUBLISHED,'N')='Y' and eventsubevent='"+QryEventSubevent+"' and examcode='"+QryExam+"' ";
	qry=qry+" GROUP BY A.subject ||' ( '||A.subjectcode||' )',A.subjectID ";
	qry=qry+" order by subject";
*/

/*
   qry=" select distinct A.subjectid, A.subject ||' ( '||A.subjectcode||' )' subject, A.subjectcode,aa.EXAMCODE,aa.EMPLOYEEID from subjectmaster A " +
           ",facultysubjecttagging AA where A.subjectid=aa.subjectid and aa.INSTITUTECODE='"+mInst+"'  " +
           "   and aa.INSTITUTECODE=a.INSTITUTECODE" +
           "  and nvl(a.deactive,'N')='N'  " ;
   if((request.getParameter("Faculty")!=null ) || (request.getParameter("Exam")!=null))
       {
       qry=qry+" and aa.EMPLOYEEID ='"+request.getParameter("Faculty")+"' and aa.examcode= '"+ request.getParameter("Exam")+"' ";
       }
       qry=qry+" union select distinct  A.subjectid, a.subject || ' ( ' || a.subjectcode || ' )' subject , " +
           "A.subjectcode,aa.EXAMCODE,aa.EMPLOYEEID  from subjectmaster A " +
           ",facultysubjecttagging AA,TTM#TIMETABLEDATA b where aa.INSTITUTECODE='"+mInst+"' " +
           " and  nvl(a.deactive,'N')='N' " +
           " and aa.FSTID=b.FSTID  and b.INSTITUTECODE=aa.INSTITUTECODE and a.INSTITUTECODE=aa.INSTITUTECODE" ;
       if((request.getParameter("Faculty")!=null ) || (request.getParameter("Exam")!=null))
       {
       qry=qry+" and aa.EMPLOYEEID ='"+request.getParameter("Faculty")+"' and aa.examcode= '"+ request.getParameter("Exam")+"' ";
       }
        qry=qry+" and A.subjectid=aa.subjectid  and aa.SUBJECTID=b.SUBJECTID order by subject ";

        */


	qry=" select Distinct STUDENTID, ENROLLMENTNO, STUDENTNAME from  v#studentltpdetail where  " +
            " institutecode='"+mInst+"' and fstid in (select fstid from facultysubjecttagging where institutecode='"+mInst+"' " +
            "  and    NVL(DEACTIVE,'N')='N' )  and examcode='"+QryExam+"' and subjectid=decode('"+mSubject2+"','ALL',subjectid,'"+mSubject2+"')   and  NVL(DEACTIVE,'N')='N'  and NVL(STUDENTDEACTIVE,'N')='N' order by ENROLLMENTNO";
	out.print(qry);
	rss=db.getRowset(qry);
	if (request.getParameter("x")==null)
	{
		%>
		<select name="Student" tabindex="0" id="Student"  style="WIDTH: 530px">
		<%
		while(rss.next())
		{
			mSubj=rss.getString("STUDENTID").toString().trim();
			if(msubj1.equals(""))
 			msubj1=mSubj;
			%>
			<OPTION selected Value="<%=mSubj%>"><%=rss.getString("STUDENTNAME")%> - <%=rss.getString("ENROLLMENTNO")%></option>
			<%
		}
		%>
		</select>
		<%
	}
	else
	{
		%>
		<select name="Student" tabindex="0" id="Student" style="WIDTH: 530px">
		<%
		while(rss.next())
		{
			mSubj=rss.getString("STUDENTID").toString().trim();
			if(mSubj.equals(request.getParameter("Student").toString().trim()))
 			{
				msubj1=mSubj;
				%>
				<OPTION selected Value ="<%=mSubj%>"><%=rss.getString("STUDENTNAME")%> - <%=rss.getString("ENROLLMENTNO")%></option>
				<%
		     	}
		     	else
		      {
				%>
		      	<OPTION Value ="<%=mSubj%>"><%=rss.getString("STUDENTNAME")%> - <%=rss.getString("ENROLLMENTNO")%></option>
		      	<%
		   	}
		}
		%>
		</select>
	  	<%
	 }
	}
	catch(Exception e)
	{
	}
	%>

</td>
</tr>

<TR>
    <TD ALIGN="left">


&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
<FONT color=black><FONT face=Arial size=2><STRONG>LTP </STRONG></FONT></FONT>

<%
String mltp1 ="";
/*
	qry="Select Distinct LTP ,decode(nvl(LTP,' '),'L','Lecture','T','Tutorial','P','Practical','E','Project') LtpDesc,";
	qry=qry+" decode(nvl(LTP,' '),'L','1','T','2','P','3','4') orderltp ";
	qry=qry+" from  facultysubjecttagging A where a.fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='"+mComp+"' and institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"') and A.fstid not in (select fstid from  ";
	qry=qry+" STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
	qry=qry+" nvl(deactive,'N')='N' and facultyid<>'"+mDMemberID+"') ";//and  A.EXAMCODE='"+qryexam+"' " ;
	qry=qry+" union ";
	qry=qry+" Select Distinct LTP ,decode(nvl(LTP,' '),'L','Lecture','T','Tutorial','P','Practical','E','Project') LtpDesc,";
	qry=qry+" decode(nvl(LTP,' '),'L','1','T','2','P','3','4') orderltp ";
	qry=qry+" from  facultysubjecttagging A where A.employeeid='"+mDMemberID+"' and A.fstid not in (select fstid from  ";
	qry=qry+" STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
	qry=qry+" nvl(deactive,'N')='N' and facultyid<>'"+mDMemberID+"') ";//and A.EXAMCODE='"+qryexam+"' " ;
	qry=qry+" union ";
	qry=qry+" Select Distinct LTP ,decode(nvl(LTP,' '),'L','Lecture','T','Tutorial','P','Practical','E','Project') LtpDesc ,";
	qry=qry+" decode(nvl(LTP,' '),'L','1','T','2','P','3','4') orderltp ";
	qry=qry+" from  facultysubjecttagging A where A.fstid in (select fstid from ";
	qry=qry+" STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
	qry=qry+" nvl(deactive,'N')='N' and facultyid='"+mDMemberID+"') ";//and A.EXAMCODE='"+qryexam+"' ";
	qry=qry+" ORDER BY orderltp ";

    */
    qry="SELECT DISTINCT  aa.LTP ,decode(nvl(aa.LTP,' '),'L','Lecture','T','Tutorial','P','Practical','E','Project') LtpDesc,decode(nvl(aa.LTP,' '),'L','1','T','2','P','3','4') orderltp " +
            "           FROM subjectmaster a, facultysubjecttagging aa          WHERE a.subjectid = aa.subjectid" +
            "            AND aa.institutecode = '"+mInst+"'            AND aa.institutecode = a.institutecode" +
            "            AND NVL (a.deactive, 'N') = 'N' UNION SELECT DISTINCT aa.LTP ,decode(nvl(aa.LTP,' '),'L','Lecture','T','Tutorial','P'," +
            " 'Practical','E','Project') LtpDesc,decode(nvl(aa.LTP,' '),'L','1','T','2','P','3','4') orderltp " +
            "           FROM subjectmaster a, facultysubjecttagging aa,                ttm#timetabledata b" +
            "          WHERE aa.institutecode = '"+mInst+"'            AND NVL (a.deactive, 'N') = 'N'" +
            "            AND aa.fstid = b.fstid            AND aa.employeeid = b.employeeid" +
            "            AND b.institutecode = aa.institutecode            AND a.institutecode = aa.institutecode" +
            "            AND a.subjectid = aa.subjectid            AND aa.subjectid = b.subjectid                   ORDER BY orderltp ";
	rs=db.getRowset(qry);

//	out.print(qry);

%>
	<select name=LTP tabindex="0" id="LTP" style="WIDTH: 90px" >
<%
if (request.getParameter("x")==null)
{
	while(rs.next())
	{
		mltp1=rs.getString("LTP");
		if(mltp1.equals("L"))
		{
	 		%>
			<OPTION selected Value ='<%=mltp1%>'><%=rs.getString("LtpDesc")%></option>
			<%
		}
		else
		{
	 		%>
			<OPTION Value ='<%=mltp1%>'><%=rs.getString("LtpDesc")%></option>
			<%
		}
	}
}
else
{
		while(rs.next())
		{
			mltp1=rs.getString("LTP");
			if (mltp1.equals(request.getParameter("LTP").toString().trim()))
			{
			%>
			<OPTION selected Value ='<%=mltp1%>'><%=rs.getString("LtpDesc")%></option>
			<%
		}
		else
		{
			%>
      		<OPTION Value ='<%=mltp1%>'><%=rs.getString("LtpDesc")%></option>
	     		<%
	   	}
	}
}
%>
</select>



    </TD>
</TR>

<tr><td>
<INPUT Type="submit" Value="Show/Refresh">&nbsp;&nbsp;
	</td></tr>
	</table></form>
	<%

    String Faculty="";

String TTID="",QrySubjID="",mLTP="",start="",SubQry="",mySub="",qrysub="",mstr="",aaa="";

ResultSet rstable=null,rsTableData=null,rsSub=null,rssub1=null;


    if(request.getParameter("x")!=null)
		{
		if(request.getParameter("Exam")!=null)
			mEC=request.getParameter("Exam").toString().trim();
		else
			mEC="";

		if(request.getParameter("Subject")!=null)
			mSC=request.getParameter("Subject").toString().trim();
		else
			mSC="";

		if(request.getParameter("Faculty")!=null)
			Faculty=request.getParameter("Faculty").toString().trim();
		else
			Faculty="";

        if(request.getParameter("LTP")!=null)
			mLTP=request.getParameter("LTP").toString().trim();
		else
			mLTP="";

        %>
        <form name="frm22" >


        <%
try{

%>


	<%
	}

catch(Exception e)
	{
		 out.println("Error : "+e.getMessage());
	}


	}// closing of request.getParameter("x")
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


}
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}
%>
</body>
</html>