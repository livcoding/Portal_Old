<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%

DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="", qry1="";

int mSNO=0;
String mMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";


String mSubj="", mStatus="", mCtype="", mSID="",mDate1="",mDate2="";
String mExam="", mColor="",mColor1="", mSec="", mSubSec="";
String mLTP="";
String mTotal="";
String mStudID="",mRightsID="";
String mCType="ALL",mInst="";
try
{
if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
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



String QryFSTID="",QrySemType="";

	if (request.getParameter("FSTID")==null)
	{
		QryFSTID="";
	}
	else
	{	
		QryFSTID=request.getParameter("FSTID").toString().trim();
	}

	if (request.getParameter("SEMESTERTYPE")==null)
	{
		QrySemType="";
	}
	else
	{	
		QrySemType=request.getParameter("SEMESTERTYPE").toString().trim();
	}




	if (request.getParameter("EXAM")==null)
	{
		mExam="";
	}
	else
	{	
		mExam=request.getParameter("EXAM").toString().trim();
	}

	if (request.getParameter("SID")==null)
	{
		mSID="";
	}
	else
	{
		mSID=request.getParameter("SID").toString().trim();
	}

	if (request.getParameter("SC")==null)
	{
		mSubj="";
	}
	else
	{
		mSubj=request.getParameter("SC").toString().trim();
	}

	if (request.getParameter("LTP")==null)
	{
		mLTP="";
	}
	else
	{	
		mLTP=request.getParameter("LTP").toString().trim();
	}
   // out.print(mLTP);
	if (request.getParameter("SEC")==null)
	{
		mSec="";
	}
	else
	{	
		mSec=request.getParameter("SEC").toString().trim();
	}

	if (request.getParameter("SUBSEC")==null)
	{
		mSubSec="";
	}
	else
	{	
		mSubSec=request.getParameter("SUBSEC").toString().trim();
	}

	if (request.getParameter("Date1")==null)
	{
		mDate1="";
	}
	else
	{	
		mDate1=request.getParameter("Date1").toString().trim();
	}

	if (request.getParameter("Date2")==null)
	{
		mDate2="";
	}
	else
	{	
		mDate2=request.getParameter("Date2").toString().trim();
	}
	if (request.getParameter("RightsID")==null)
            mRightsID="";
	else
            mRightsID=request.getParameter("RightsID").toString().trim();

//out.println(mDate1 +"  "+mDate2);

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [Student Attendance Report (Day wise Absent/Present)]</TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />



<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
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
	qry="Select WEBKIOSK.ShowLink('"+mRightsID+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
			if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------

%>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD colspan=0 align=middle ><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana"><b>Day wise Student Attendance (Absent/Present)</b></font></td>
</tr>
</TABLE>
<%
String mSnm="", mENo="",mSubject="";
qry="select StudentName, Enrollmentno from StudentMaster where StudentID='"+mSID+"' and institutecode='"+mInst+"'";
rs1=db.getRowset(qry);
if(rs1.next())
{
mSnm=rs1.getString(1);
mENo=rs1.getString(2);
}

qry="select subject||'('|| subjectcode ||')' subject From subjectmaster where subjectid='"+ mSubj +"' and institutecode='"+mInst+"' ";
rs1=db.getRowset(qry);
if(rs1.next())
{
	mSubject=rs1.getString(1);
}

%>
<table width="100%">
<tr><td align=center>
 <font color="#00008b" size=3>Student Name: <B><%=GlobalFunctions.toTtitleCase(mSnm)%> [<%=mENo%>]</B></font><br>
 <font color="#00008b" size=3>Subject Code: <b><%=mSubject%></B> &nbsp; &nbsp; LTP: <B><%=GlobalFunctions.getLTPDescWSQ(mLTP)%></B></font>
</td></tr></table>
 <TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="70%" border=1 >
<thead>
<tr bgcolor="#ff8c00">
 <td align=center Title="Click on SNo to sort"><b><font color="White">SNo</font></b></td>
 <td align=center Title="Click on Date to Sort"><b><font color="White">Date</font></b></td>
 <td align=center Title="Click on Attendance by to Sort"><b><font color="White">Attendance By</font></b></td> 
 <td align=center Title="Click on Status to Sort"><b><font color="White">Status</font></b></td>
 <%
if(mLTP.equals("LT"))
    {
     %><td align=center Title=""><b><font color="White">LTP</font></b></td> <%
    }
 %>
</tr>
</thead>
<tbody>
<% String mREGCONFIRMATIONDATE="";
 ResultSet rsBatchDate=null;
 int mSem=0;
	qry=" Select nvl(to_char(a.REGCONFIRMATIONDATE,'dd-mm-yyyy'),' ') REGCONFIRMATIONDATE,a.semester  From StudentRegistration a , studentmaster b Where a.INSTITUTECODE='"+mInst+"'";
					qry=qry+" AND a.EXAMCODE='"+mExam+"'";
					qry=qry+"and a.STUDENTID='"+mSID+"' and  a.INSTITUTECODE=b.INSTITUTECODE and a.studentid=b.studentid ";					
					//out.print(qry);
					rsBatchDate=db.getRowset(qry);
					 if(rsBatchDate.next())
					{
						mREGCONFIRMATIONDATE=rsBatchDate.getString(1);
						mSem=rsBatchDate.getInt("semester");
					}


	qry="select Distinct  ltp, to_date(CLASSTIMEFROM,'DD-MM-YYYY hh-mi PM')AttTime, to_char(CLASSTIMEFROM,'DD-MM-YYYY hh-mi PM')ADateTime, to_char(ATTENDANCEDATE,'DD-MM-YYYY')ADate, nvl(ENTRYBYFACULTYNAME,' ')EName,semester semester	,to_char(ATTENDANCEDATE,'YYYYmmdd')AADate,decode(LTP,'L','Lecture','T','Tutorial','P','Practical','N') LTP1 from V#STUDENTATTENDANCE a";
	qry=qry+" where a.EXAMCODE='"+mExam+"' ";
//	qry=qry+"  and A.FSTID='"+QryFSTID+"'		";  
qry=qry+" and (   a.employeeid = '"+mChkMemID+"'          OR (a.fstid IN (                      SELECT b.fstid                        FROM multifacultysubjecttagging b                       WHERE a.fstid = b.fstid                             AND b.employeeid = '"+mChkMemID+"')             )) ";
				
	qry=qry+" and a.ATTENDANCETYPE=Decode('"+mCType + "','ALL',a.ATTENDANCETYPE,'"+ mCType +"')";
	qry=qry+" and a.SUBJECTID='"+mSubj+"' and  a.institutecode='"+mInst+"' ";
	if(mLTP.equals("LT"))
        qry=qry+" and a.LTP in ('L','T')   AND  A.semestertype='"+QrySemType+"' " ;
	else
        qry=qry+" and a.LTP='"+mLTP+"'   AND  A.semestertype='"+QrySemType+"'	";
	qry=qry+" and SECTIONBRANCH=decode('"+mSec+"','ALL',SECTIONBRANCH,'',SECTIONBRANCH,'"+mSec+"') and SUBSECTIONCODE=decode('"+mSubSec+"','ALL',SECTIONBRANCH,'',SECTIONBRANCH,'"+mSubSec+"')";
	if(mSem==1)
		{
		qry=qry+" and trunc(a.ATTENDANCEDATE)>=TO_Date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')";
		}
	qry=qry+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy'))) ";
	qry=qry+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy'))) ";
	qry=qry+" and nvl(a.DEACTIVE,'N')='N'  UNION";
	qry=qry+" select Distinct ltp,to_date(CLASSTIMEFROM,'DD-MM-YYYY hh-mi PM')AttTime, to_char(CLASSTIMEFROM,'DD-MM-YYYY hh-mi PM')ADateTime, to_char(ATTENDANCEDATE,'DD-MM-YYYY')ADate, E.EMPLOYEENAME EName ,s.semester  semester ,to_char(ATTENDANCEDATE,'YYYYmmdd')AADate,decode(LTP,'L','Lecture','T','Tutorial','P','Practical','N') LTP1  from STUDENTPREVATTENDENCE s,EMPLOYEEMASTER e ";
	qry=qry+" where S.EXAMCODE='"+mExam+"' AND S.STUDENTID='"+mSID+"' ";
	qry=qry+" and S.ATTENDANCETYPE=Decode('"+mCType + "','ALL',ATTENDANCETYPE,'"+ mCType +"')";
	qry=qry+" and S.SUBJECTID='"+mSubj+"'";
	qry=qry+" and (   S.employeeid = '"+mChkMemID+"'          OR (S.fstid IN (                      SELECT b.fstid                        FROM multifacultysubjecttagging b                       WHERE S.fstid = b.fstid                             AND b.employeeid = '"+mChkMemID+"')             )) ";				
//	qry=qry+"  and s.FSTID='"+QryFSTID+"'		";  
	if(mSem==1)
		{
		qry=qry+" and trunc(s.ATTENDANCEDATE)>=TO_Date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')";
		}
	qry=qry+" and s.EMPLOYEEID = e.EMPLOYEEID";
	if(mLTP.equals("LT"))
        qry=qry+" and S.LTP in ('L','T')   AND  s.semestertype='"+QrySemType+"' ";
	else
        qry=qry+" and S.LTP='"+mLTP+"'  AND  s.semestertype='"+QrySemType+"'	";
	qry=qry+" and nvl(s.DEACTIVE,'N')='N'  order by AADate  ";
	rs1=db.getRowset(qry);
//	out.print(qry);
	mSNO=0;	
	while(rs1.next())
		{
		mSNO++;

		

		qry="select to_char(CLASSTIMEFROM,'DD-MM-YYYY HH:MI PM')||' - '||to_char(CLASSTIMEUPTO,'HH:MI PM') ADate, nvl(ENTRYBYFACULTYNAME,' ')EName, nvl(PRESENT,'N')Status,decode(LTP,'L','Lecture','T','Tutorial','P','Practical','N') LTP from V#STUDENTATTENDANCE A ";
		qry=qry+" where EXAMCODE='"+mExam+"' and institutecode='"+mInst+"' ";
		qry=qry+" and ATTENDANCETYPE=Decode('"+mCType + "','ALL',ATTENDANCETYPE,'"+ mCType +"')";
		qry=qry+" and SUBJECTID='"+mSubj+"' and STUDENTID='"+mSID+"'";
		qry=qry+" and (   a.employeeid = '"+mChkMemID+"'          OR (a.fstid IN (                      SELECT b.fstid                        FROM multifacultysubjecttagging b                       WHERE a.fstid = b.fstid                             AND b.employeeid = '"+mChkMemID+"')             )) ";
		if(mLTP.equals("LT"))
	        qry=qry+" and LTP in ('L','T')   AND semestertype='"+QrySemType+"' " ;
      	else
	        qry=qry+" and LTP='"+mLTP+"'   AND semestertype='"+QrySemType+"' ";
		qry=qry+" and SECTIONBRANCH=decode('"+mSec+"','ALL',SECTIONBRANCH,'',SECTIONBRANCH,'"+mSec+"') and SUBSECTIONCODE=decode('"+mSubSec+"','ALL',SECTIONBRANCH,'',SECTIONBRANCH,'"+mSubSec+"')";
		qry=qry+" and CLASSTIMEFROM=to_date('"+rs1.getString("ADateTime")+"','DD-MM-YYYY hh-mi PM')";
		qry=qry+" and nvl(DEACTIVE,'N')='N' UNION ";
		qry=qry+" select to_char(CLASSTIMEFROM,'DD-MM-YYYY HH:MI PM')||' - '||to_char(CLASSTIMEUPTO,'HH:MI PM') ADate, E.EMPLOYEENAME ENAME, nvl(PRESENT,'N')Status,decode(LTP,'L','Lecture','T','Tutorial') LTP from STUDENTPREVATTENDENCE S, EMPLOYEEMASTER E ";
		qry=qry+" where S.EXAMCODE='"+mExam+"'";
		qry=qry+" and S.ATTENDANCETYPE=Decode('"+mCType + "','ALL',ATTENDANCETYPE,'"+ mCType +"')";
		qry=qry+" and S.SUBJECTID='"+mSubj+"' and S.STUDENTID='"+mSID+"'";
qry=qry+" and (   S.employeeid = '"+mChkMemID+"'          OR (S.fstid IN (                      SELECT b.fstid                        FROM multifacultysubjecttagging b                       WHERE S.fstid = b.fstid                             AND b.employeeid = '"+mChkMemID+"')             )) ";				
		if(mLTP.equals("LT"))
	        qry=qry+" and S.LTP in ('L','T')   AND  s.semestertype='"+QrySemType+"' " ;
      	else
	        qry=qry+" and S.LTP='"+mLTP+"'  AND  s.semestertype='"+QrySemType+"' ";
		qry=qry+" and S.CLASSTIMEFROM=to_date('"+rs1.getString("ADateTime")+"','DD-MM-YYYY hh-mi PM')";
		qry= qry+" and E.EMPLOYEEID = S.employeeid  ";
		qry=qry+" and nvl(S.DEACTIVE,'N')='N' ";
		rs=db.getRowset(qry);
		//out.print(qry);
		if(rs.next())
		{
			if(rs.getString("Status").equals("Y"))
			{
				mStatus="Present";
				mColor="Green";
			}
			else
			{
				mStatus="Absent";
				mColor="RED";
			}


				if(rs.getString("LTP").equals("Lecture"))
			{
				//mStatus="Present";
				mColor1="blue";
			}
			else
			{
				//mStatus="Absent";
				mColor1="green";
			}


			%>
			<tr>
			<td align=center NOWRAP><%=mSNO%>.</td>
			<td align=center NOWRAP><%=rs.getString("ADate")%></td>
			<td align=center NOWRAP><%=rs.getString("EName")%></td>
			<td align=center NOWRAP><font color=<%=mColor%>><B><%=mStatus%></B></font></td>
            <%
            if(mLTP .equals("LT"))
            {
            %>
            <td align=center Title=""><b><font color="<%=mColor1%>"><%=rs.getString("LTP")%></font></b></td>
            <%
            }
		    %></tr>
			<%
		}
		else
		{
				qry="select to_char(CLASSTIMEFROM,'DD-MM-YYYY HH:MI PM')||' - '||to_char(CLASSTIMEUPTO,'HH:MI PM') ADate, nvl(ENTRYBYFACULTYNAME,' ')EName, nvl(PRESENT,'N')Status,decode(LTP,'L','Lecture','T','Tutorial','P','Practical','N') LTP from V#STUDENTATTENDANCE A ";
		qry=qry+" where EXAMCODE='"+mExam+"' and institutecode='"+mInst+"'";
		qry=qry+" and ATTENDANCETYPE=Decode('"+mCType + "','ALL',ATTENDANCETYPE,'"+ mCType +"')";
		qry=qry+" and SUBJECTID='"+mSubj+"' and STUDENTID='"+mSID+"'";
qry=qry+" and (   a.employeeid = '"+mChkMemID+"'          OR (a.fstid IN (                      SELECT b.fstid                        FROM multifacultysubjecttagging b                       WHERE a.fstid = b.fstid                             AND b.employeeid = '"+mChkMemID+"')             )) ";  
		if(mLTP.equals("LT"))
	        qry=qry+" and LTP in ('L','T')   AND  semestertype='"+QrySemType+"'" ;
      	else
	        qry=qry+" and LTP='"+mLTP+"' AND  semestertype='"+QrySemType+"' ";
		qry=qry+" and SECTIONBRANCH=decode('"+mSec+"','ALL',SECTIONBRANCH,'',SECTIONBRANCH,'"+mSec+"') and SUBSECTIONCODE=decode('"+mSubSec+"','ALL',SECTIONBRANCH,'',SECTIONBRANCH,'"+mSubSec+"')";
		qry=qry+" and CLASSTIMEFROM=to_date('"+rs1.getString("ADateTime")+"','DD-MM-YYYY hh-mi PM')";
		qry=qry+" and nvl(DEACTIVE,'N')='N' ";
		//out.print(qry);
		rs=db.getRowset(qry);
			if(!rs.next())
			{
				mStatus="Absent";
				mColor="RED";
				%>
				<tr>
				<td align=center><%=mSNO%>.</td>
				<td align=center><%=GlobalFunctions.toTtitleCase(rs1.getString("ADateTime"))%></td>
				<td align=center><%=rs1.getString("EName")%></td>
				<td align=center><font color=<%=mColor%>><B><%=mStatus%></B></font></td>
			    <%
		     if(mLTP.equals("LT"))
			  {
			   %>
			   <td align=center Title=""><b><font color="green"><%=rs1.getString("LTP1")%></font></b></td>
			   <%
			  }
				%>	
				</tr>
				<%
			}

		}
		
	}
%>
</tbody>
</TABLE>
<script type="text/javascript">
var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString","CaseInsensitiveString","Number","Number"]);
</script>

<%
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
}		
catch(Exception e)
{
}
%>
</body>
</html>