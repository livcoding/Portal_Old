<%--
    Document   : StudentTaggHistory
    
--%>

<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%

	/*
	' **********************************************************************************************************
	' *													   *
	' * File Name:	AttendanceRegister.JSP		[For Employee]			   *
	' * Author:		Mohit Sharma						         *
	' * Date:		12 Sep 2012	 							   *
	' * Version:		1.0									   *
	' **********************************************************************************************************
*/

String qry="",mWebEmail="",MSUBID="",mqryacademicyear="",mDateFrom="",mDateTo="";
String mSTUDID="",mFSTID="",mATTTYPE="",mEXAMCODE="",mLTP="",mBRANCH="",mSUBSEC="",mAcademicYear="";
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();
GlobalFunctions gb =new GlobalFunctions();
ResultSet rs=null,rs1=null, EmployeeRecordSet=null,rsImage=null,rs2=null;
String SName="",CAddress1 ="", CAddress2="",CAddress3="", CDistrict="",CPin="",CCity="",CState="";
String PAddress1 ="", PAddress2="",PAddress3="", PDistrict="", PPin="",qry1="", PCity="",PState="",EnrollmentNo="",FatherName="",HusbandName="", MotherName="";
String DOB="",DOJ="",Grade="", Dept="", Desig="", Category="",AccountNo="", BankName="",PFNO="", PANNO="",PassportNo="";
String pPhone ="",cPhone ="",pCell="" ,pEmail="",PassportValidUpto ="", PassportIssueFrom="",pIssueDate="";
String mMemberID="",mMemberType="",mMemberCode="";


String mSubj="", mSubjID="", mCtype="", mProg="",mSec="",mSub="";
String mExam="", mFaculty="",  mDate1="", mDate2="";
String  mTotal="";
String mAttendanceDate="", mClassFrom="", mClassUpto="",mInst="",qry2="",moldDate="",mStatus="",mColor="",mColor1="",mName="";
String mCType="", mRightsID="82";
double mPerc=0, mTotalStrength=0, mTotalPresent=0;



int mSNO=0;


if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}

if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
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
if (session.getAttribute("WebAdminEmail")==null)
{
	 mWebEmail="";
}
else
{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
}

//--------

	if (request.getParameter("ACAD").toString().trim()==null)
   {
	mqryacademicyear="";
   }
   else
   {
	mqryacademicyear=request.getParameter("ACAD").toString().trim();
    }


	if (request.getParameter("STUDID").toString().trim()==null)
   {
	mSTUDID="";
   }
   else
   {
	mSTUDID=request.getParameter("STUDID").toString().trim();
    }

	if (request.getParameter("FSTID").toString().trim()==null)
   {
	mFSTID="";
   }
   else
   {
	mFSTID=request.getParameter("FSTID").toString().trim();
    }

		if (request.getParameter("EXAMCODE").toString().trim()==null)
   {
	mEXAMCODE="";
   }
   else
   {
	mEXAMCODE=request.getParameter("EXAMCODE").toString().trim();
    }
		if (request.getParameter("LTP").toString().trim()==null)
   {
	mLTP="";
   }
   else
   {
	mLTP=request.getParameter("LTP").toString().trim();
    }
		if (request.getParameter("BRANCH").toString().trim()==null)
   {
	mBRANCH="";
   }
   else
   {
	mBRANCH=request.getParameter("BRANCH").toString().trim();
    }
		if (request.getParameter("SUBSEC").toString().trim()==null)
   {
	mSUBSEC="";
   }
   else
   {
	mSUBSEC=request.getParameter("SUBSEC").toString().trim();
    }


				if (request.getParameter("SUBID").toString().trim()==null)
   {
	MSUBID="";
   }
   else
   {
	MSUBID=request.getParameter("SUBID").toString().trim();
    }

		////out.print(mSTUDID+"rgret"+mFSTID+"tertert"+mATTTYPE+"reter"+mEXAMCODE+"eryey"+mLTP+"rey"+mBRANCH+"eryey"+mSUBSEC+"eryer");
//-----------
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT";
%>
<HTML>
<head>
<TITLE>####<%=mHead%>[Student Batch History ]</TITLE>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<link rel="stylesheet" href="../CSSS/style.css" type="text/css" media="screen, projection, tv" />
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<link type="text/css" rel="StyleSheet" href="css/style.css" />
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<link rel="stylesheet" href="css/style-print.css" type="text/css" media="print" />

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body   topmargin=4 rightmargin=0 leftmargin=0 bottommargin=0 bgColor="#fce9c5">


<form name="frm" method="post" >
<input id="x" name="x" type=hidden>
<%
if(!mMemberID.equals("") || !mMemberCode.equals(""))
{
mMemberID=enc.decode(mMemberID);
mMemberCode=enc.decode(mMemberCode);

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
    //-- Enable Security Page Level

    %>
    <table ALIGN=CENTER bottommargin=0 width="100%"  topmargin=0>
<tr ALIGN=CENTER>
<TD ALIGN=CENTER><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"> <b><U>Student Batch History</U> </b></TD>
</font>
</td>
</tr>
</TABLE>


    <%
    qry="Select WEBKIOSK.ShowLink('82','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
    RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
		try
		{

String mSnm="", mENo="",mSubject="";
qry="select StudentName, Enrollmentno from StudentMaster where StudentID='"+mSTUDID+"'  and INSTITUTECODE='"+mInst+"'";
rs1=db.getRowset(qry);
if(rs1.next())
{
mSnm=rs1.getString(1);
mENo=rs1.getString(2);
}

qry="select subject||'('|| subjectcode ||')' subject From subjectmaster where subjectid='"+ MSUBID +"'  and INSTITUTECODE='"+mInst+"'";
	rs1=db.getRowset(qry);
	if(rs1.next())
	{
		mSubject=rs1.getString(1);
	}
%>




<table width="100%">
<tr><td align=center>
 <font color="#00008b">Subject Code: <b><%=mSubject%></B> &nbsp; &nbsp; LTP: <B><%=GlobalFunctions.getLTPDescWSQ(mLTP)%></B></font>
</td></tr></table>
 <TABLE align="center" rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="100%" border=1 >
<thead><BR>
    <%
String mStCellNo="",mStEmail="";

qry="SELECT DISTINCT  NVL(STCELLNO,' ')STCELLNO, NVL(STEMAILID,' ')STEMAILID  " +
        "FROM STUDENTPHONE A WHERE A.STUDENTID='"+mSTUDID+"' ";
		rs2=db.getRowset(qry);
		if(rs2.next())
			{
				mStCellNo= rs2.getString("STCELLNO");
					mStEmail=rs2.getString("STEMAILID");
			}
		//out.print("<br><font color=red size=3> <B>Attendance entry is missing for this student   <B></font><br>");
		out.print("<center><font color=green size=3><B> Student Name: <B>"+GlobalFunctions.toTtitleCase(mSnm)+" ["+mENo+"]     MobileNo. : </B> "+mStCellNo+" , <B>Email-ID : </B>"+ mStEmail +" </center>");
        %>
<tr bgcolor="#c00000" align=center >
 <td Title="Click on SNo to sort"><b><font color="White">SNo</font></b></td>
 <td Title="Click on Date to Sort"><b><font color="White">Previous Faculty</font></b></td>
 <td Title="Click on Attendance by to Sort"><b><font color="White">Previous Batch</font></b></td>
 <td align=center Title="Click on Status to Sort"><b><font color="White">Student Name</font></b></td>

  <td align=center Title="Click on Status to Sort"><b><font color="White">New FAculty</font></b></td>
  <td Title="Click on Attendance by to Sort"><b><font color="White">New Batch</font></b></td>

<!--  <td Title="Click on Class Type to Sort"><b><font color="White">Attendance Status</font></b></td>
 <td Title="Click on Class Type to Sort"><b><font color="White">Marks Status</font></b></td>
 <td Title="Click on Transfer Type to Sort"><b><font color="White">Transfer Date</font></b></td> -->
  
</tr>
</thead>
<tbody>
<% mSNO=0;
String mPrevEmp="",mNewEmp="";
qry="SELECT nvl(PREVEMPLOYEEID,' ')PREVEMPLOYEEID, nvl(PREVFSTID,' ')PREVFSTID, nvl(PREVSUBSECTION,' ' )PREVSUBSECTION, nvl(NEWEMPLOYEEID,' ')NEWEMPLOYEEID, nvl(NEWFSTID,' ')NEWFSTID, nvl(NEWSUBSECTION,' ')NEWSUBSECTION,nvl(ATTTRANSFERREDSTATUS,' ')ATTTRANSFERREDSTATUS   , " +
        " to_char(ATTTRNASFERREDDATE,'dd-mm-yyyy')ATTTRNASFERREDDATE , nvl(MARKSTRANSFERREDSTATUS,' ')MARKSTRANSFERREDSTATUS " +
        ", to_char(MARKSTRANSFERREDDATE,'dd-mm-yyyy') MARKSTRANSFERREDDATE" +
        " FROM STUDENTTAGGINGHISTORY WHERE SUBJECTID ='"+MSUBID+"' AND STUDENTID='"+mSTUDID+"' AND EXAMCODE = '"+mEXAMCODE+"'  and INSTITUTECODE='"+mInst+"' ";
//out.print(qry);
rs1=db.getRowset(qry);
		while(rs1.next())
		{		mSNO++;



    qry1="SELECT A.EMPLOYEENAME ||' - '|| A.EMPLOYEECODE  EMPLOYEENAME ,A.EMPLOYEEID   FROM EMPLOYEEMASTER A WHERE " +
            "A.EMPLOYEEID='"+rs1.getString("PREVEMPLOYEEID")+"' and nvl(a.deactive,' ')='N' " +
            "AND NVL(a.DEACTIVE,'N')='N' ";
    rs=db.getRowset(qry1);
if(rs.next())
mPrevEmp= rs.getString("EMPLOYEENAME");

    qry1="SELECT A.EMPLOYEENAME ||' - '|| A.EMPLOYEECODE  EMPLOYEENAME1 ,A.EMPLOYEEID   FROM EMPLOYEEMASTER " +
            "A WHERE A.EMPLOYEEID='"+rs1.getString("NEWEMPLOYEEID")+"' and nvl(a.deactive,' ')='N' " +
            "AND NVL(a.DEACTIVE,'N')='N' ";
    rs=db.getRowset(qry1);
if(rs.next())
mNewEmp= rs.getString("EMPLOYEENAME1");

			%>
			<tr>
			<td align=center NOWRAP><%=mSNO%>.</td>
			<td align=center NOWRAP><%=mPrevEmp%></td>
			<td align=center NOWRAP><%=rs1.getString("PREVSUBSECTION")%></td>

            	<td align=center NOWRAP><%=mSnm%></td>

				<td align=center NOWRAP><%=mNewEmp%></td>
				<td align=center NOWRAP><%=rs1.getString("NEWSUBSECTION")%></td>



            </tr>
			 <%


	}





/*
select ENROLLMENTNO, STUDENTNAME, CLASSTIMEFROM, PRESENT, ENTRYBYFACULTYID, ENTRYBYFACULTYNAME from v#STUDENTATTENDANCE a
 WHERE subjectid = '090088'
   AND studentid = '00011200301'
   AND examcode = '2014EVESEM'
   and institutecode='JIIT'
   and a.LTP='L'*/
%>
</tbody>
</TABLE>
<script type="text/javascript">
var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString","CaseInsensitiveString","Number","Number"]);
</script>

<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD colspan=0 align=middle ><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><b>Student Lecture Attendance Detail</b></font></td>
</tr>
</table>

 <TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="100%" border=1 >
<thead>
<tr bgcolor="#c00000">
 <td Title="Click on SNo to sort"><b><font color="White">SNo</font></b></td>
 <td Title="Click on Date to Sort"><b><font color="White">Date</font></b></td>
 <td Title="Click on Attendance by to Sort"><b><font color="White">Attendance By</font></b></td>
 <td align=center Title="Click on Status to Sort"><b><font color="White">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Status</font></b></td>
 <td Title="Click on Class Type to Sort"><b><font color="White">Class Type</font></b></td>
</tr>
</thead>
<tbody>

    <input type="hidden" name="MSUBID" id="MSUBID" value="<%=MSUBID%>">
        <input type="hidden" name="mSTUDID" id="mSTUDID" value="<%=mSTUDID%>">
            <input type="hidden" name="mEXAMCODE" id="mEXAMCODE" value="<%=mEXAMCODE%>">
                     <input type="hidden" name="mLTP" id="mLTP" value="<%=mLTP%>">


    <%
    int sno=0;

    qry="select FSTID, ENROLLMENTNO, STUDENTNAME,  to_Char(CLASSTIMEFROM,'dd-mm-rrrr hh:mi am') CLASSTIMEFROM , PRESENT, " +
            "ENTRYBYFACULTYID, ENTRYBYFACULTYNAME, nvl(a.attendancetype,' ')attendancetype        , to_char(a.ATTENDANCEDATE,'yyyymmdd')ddd from v#STUDENTATTENDANCE a  " +
            " WHERE SUBJECTID ='"+MSUBID+"' AND STUDENTID='"+mSTUDID+"' AND EXAMCODE = '"+mEXAMCODE+"'  and INSTITUTECODE='"+mInst+"' " +
            "  and a.LTP='"+mLTP+"' order by ddd ";
//out.print(qry);
    rs=db.getRowset(qry);
    while(rs.next())
        {

        sno++;

         	if(rs.getString("ATTENDANCETYPE").equals("R"))
			mCtype="Regular";
		else
			mCtype="Extra";


			if(rs.getString("PRESENT").equals("Y"))
			{
				mStatus="Present";
				mColor="Green";
			}
         else
             {
             mStatus="Absent";
				mColor="Red";
             }

        %>
        <tr>
        <td><%=sno%></td>
        <td> <%=rs.getString("CLASSTIMEFROM")%>  </td>
        <td> <%=rs.getString("ENTRYBYFACULTYNAME")%>  </td>
        <td align=center NOWRAP><font color=<%=mColor%>><B><%=mStatus%></B></font></td>
		<td><%=mCtype%></td>
        </tr>
        <%
        }

    %>

</tbody>
</table>

    <table align=center bgcolor=white width="100%"  cellmargin=0 bottommargin=0 border=1>

    <tr ALIGN=CENTER>
       <!--   <td  colspan="3">
              <input type="SUBMIT" value=" Transfer " />
          </td>
-->
        <td  colspan="0"><input type="button" value=" Print this page "
           onclick="window.print();return false;"/>
           </td>

           </table>

     </form>
<%
/*

if(request.getParameter("MSUBID")==null)
    MSUBID="";
    else
        MSUBID=request.getParameter("MSUBID");


if(request.getParameter("mSTUDID")==null)
    mSTUDID="";
    else
        mSTUDID=request.getParameter("mSTUDID");


if(request.getParameter("mEXAMCODE")==null)
    mEXAMCODE="";
    else
        mEXAMCODE=request.getParameter("mEXAMCODE");


if(request.getParameter("mLTP")==null)
    mLTP="";
    else
        mLTP=request.getParameter("mLTP");


int n=0;

qry="SELECT   INSTITUTECODE, FACULTYTYPE, A.ENTRYBYFACULTYID EMPLOYEEID,    EXAMCODE, ACADEMICYEAR, PROGRAMCODE, " +
        "   TAGGINGFOR, SECTIONBRANCH, SUBSECTIONCODE,    nvl(SEMESTER,0)SEMESTER , SEMESTERTYPE, BASKET, " +
        "   SUBJECTID, LTP,               STUDENTID,    ATTENDANCEDATE, CLASSTIMEFROM, CLASSTIMEUPTO," +
        "   ATTENDANCETYPE, PRESENT,    FSTID FROM v#studentattendance a WHERE subjectid = '"+MSUBID+"'   AND studentid = '"+mSTUDID+"'" +
        "   AND examcode = '"+mEXAMCODE+"'   AND institutecode = '"+mInst+"'   AND a.ltp = '"+mLTP+"' ";
rs=db.getRowset(qry);
out.print(qry);
while(rs.next())
    {



  qry1="INSERT INTO STUDENTPREVATTENDENCE (   INSTITUTECODE, FACULTYTYPE, EMPLOYEEID,    EXAMCODE, ACADEMICYEAR, PROGRAMCODE, " +
          "   TAGGINGFOR, SECTIONBRANCH, SUBSECTIONCODE, " +
          "   SEMESTER, SEMESTERTYPE, BASKET, " +
          "   SUBJECTID, LTP, ENTRYBY,    ENTRYDATE,SUBJECTTYPE,     STUDENTID,    ATTENDANCEDATE, CLASSTIMEFROM, CLASSTIMEUPTO, " +
          "   ATTENDANCETYPE, PRESENT,     FSTID) " +
          "VALUES ('"+rs.getString("INSTITUTECODE")+"'  ,'"+rs.getString("FACULTYTYPE")+"' , '"+rs.getString("EMPLOYEEID")+"' , " +
          " '"+rs.getString("EXAMCODE")+"'    ,'"+rs.getString("ACADEMICYEAR")+"'  ,'"+rs.getString("PROGRAMCODE")+"' , '"+rs.getString("TAGGINGFOR")+"' , " +
          " '"+rs.getString("SECTIONBRANCH")+"' ,'"+rs.getString("SUBSECTIONCODE")+"'  ,"+rs.getInt("SEMESTER")+" , '"+rs.getString("SEMESTERTYPE")+"' , " +
          " '"+rs.getString("BASKET")+"' ,'"+rs.getString("SUBJECTID")+"' , '"+rs.getString("LTP")+"' , '"+mChkMemID+"' , SYSDATE  , 'C','"+rs.getString("STUDENTID")+"' ," +
          " TO_CHAR('"+rs.getString("ATTENDANCEDATE")+"','DD-MM-YYYY') , TO_CHAR('"+rs.getString("CLASSTIMEFROM")+"','DD-MM-YYYY HH24:MI') ,TO_CHAR('"+rs.getString("CLASSTIMEUPTO")+"','DD-MM-YYYY HH24:MI') , " +
          "   '"+rs.getString("ATTENDANCETYPE")+"' , '"+rs.getString("PRESENT")+"' ,'"+rs.getString("FSTID")+"' ) " ;
out.print(qry1);

 n=db.insertRow(qry1);


    }

if(n>0)
{
    out.print("<center> <font color=green face=arial size=2> <b> Data Transfered Successfully </b> </font>   </center>");
    }



*/

    }
    catch(Exception e)
    {
      //out.print(e.getMessage());
    }

    }

    else
    {
	%>




	<br>
	<font color=red>
	<h3><br><img src='.../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team.
	</font><br><br><br><br>
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

	<center><!--
	<table align=center><tr><td align=left>
	<IMG style="WIDTH: 75px; HEIGHT: 50px" src="../../Images/CampusLynx.png">
	<FONT size =4 style="FONT-FAMILY: cursive"><b>CampusLynx</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
	A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
	<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>
	</td></tr></table> -->
	</body>
	</Html>

