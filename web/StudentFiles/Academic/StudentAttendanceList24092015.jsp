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
<TITLE>#### <%=mHead%> [ View Class Attendance ] </TITLE>
<script type="text/javascript" src="../js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="../css/sortabletable.css" />

<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
</script>
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
	' * File Name:	StudentAttendanceList.JSP		[For Students]					
	' * Author:		Vijay
	' * Date:		25th Jan 07								
	' * Version:		1.0								
	' * Description:	Current Student Attendance Detail
*************************************************************************************************
*/
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();
String qry="",qry1="",mWebEmail="",EmpIDType="";
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
String mInst="";
long mPresent=0, mL=0, mT=0, mP=0, mLP=0, mTP=0, mPP=0;
int msno=0;
String mSem="",QryExam="", QryType="";
int mSemPlusOne=0;
String mexamcode="",mexam="",mProg="",mBranch="",mName="", mBasket="", mEm;
long mPercL=0,mPercT=0,mPercP=0,mPercLT=0;
String mINSTITUTECODE="";
String mEmployeeID="";
String mEName="";
String mClassType="";
String mClasstype="";
ResultSet rs=null,rs1=null,rs2=null;

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
if (session.getAttribute("InstituteCode")==null)
{
	mINSTITUTECODE="";
}
else
{
	mINSTITUTECODE=session.getAttribute("InstituteCode").toString().trim();
}
if (session.getAttribute("ProgramCode")==null)
{
	mProg="";
}
else
{
	mProg=session.getAttribute("ProgramCode").toString().trim();
}

if (session.getAttribute("BranchCode")==null)
{
	mBranch="";
}
else
{
	mBranch=session.getAttribute("BranchCode").toString().trim();
}

if (session.getAttribute("CurrentSem")==null)
{
	mSem="";
}
else
{
	mSem=session.getAttribute("CurrentSem").toString().trim();
	mSemPlusOne=(Integer.parseInt(mSem))+0;
}

if (session.getAttribute("MemberName")==null)
{
	mName="";
}
else
{
	mName=session.getAttribute("MemberName").toString().trim();
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
	qry="Select WEBKIOSK.ShowLink('88','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------
	try
	{	

		mDMemberCode=enc.decode(mMemberCode);
		mMemberID=enc.decode(mMemberID);
		mMemberType=enc.decode(mMemberType);
	}
	catch(Exception e)
	{
		out.println(e.getMessage());
	}
%>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Student Attendance</b></font>
</td>
</tr>
</table>
<form name="frm" method=get>
<input id="x" name="x" type=hidden>
<table width=100%  rules=groups cellspacing=1 cellpadding=1 align=center border=1>
<tr><td><font color=black face=arial size=2><STRONG> Name:&nbsp;</STRONG></font><%=GlobalFunctions.toTtitleCase(mName)%>[<%=mDMemberCode%>]</td>
<td><font color=black face=arial size=2><STRONG>Course/Branch:&nbsp;</STRONG></font><%=mProg%>(<%=mBranch%>)</td>
<td><font color=black face=arial size=2><STRONG>Current Semester:&nbsp;</STRONG></font><%=mSemPlusOne%></td></tr>
<tr>
	<td><font color=black face=arial size=2><STRONG>Exam Code</STRONG></font>
<%
		qry="SELECT DISTINCT EXAMCODE FROM(select distinct nvl(examcode,' ')examcode,EXAMPERIODFROM  from exammaster where institutecode='"+mINSTITUTECODE+"'";
	qry=qry+" and nvl(EXCLUDEINATTENDANCE,'N')='N' and nvl(deactive,'N')='N' ";
	qry=qry+" and examcode in ( select EXAMCODEFORATTENDNACEENTRY from CompanyInstituteTagging where institutecode='"+mINSTITUTECODE+"') ";
	qry=qry+" and examcode in ( select examcode from V#StudentAttendance where StudentID='"+mMemberID+"' AND institutecode='"+mINSTITUTECODE+"' group by examcode)  UNION  ALL                SELECT DISTINCT NVL (examcode, ' ') examcode, examperiodfrom           FROM exammaster          WHERE institutecode = '"+mINSTITUTECODE+"'            AND NVL (excludeinattendance, 'N') = 'N'            AND NVL (deactive, 'N') = 'N'            AND examcode IN (SELECT examcodeforattendnaceentry                               FROM companyinstitutetagging                              WHERE institutecode = '"+mINSTITUTECODE+"')            AND examcode IN (                    SELECT   examcode                        FROM studentprevattendence                       WHERE studentid = '"+mMemberID+"'                         AND institutecode = '"+mINSTITUTECODE+"'                    GROUP BY examcode)                     AND ROWNUM <= 1       ORDER BY examperiodfrom DESC)   ";
	//out.print(qry);
  	rs=db.getRowset(qry);

  rs=db.getRowset(qry);
//out.print(qry);
%>
	<select name=exam tabindex="0" id="exam" style="WIDTH: 140px">	
<%   	
 	if(request.getParameter("x")==null)
	{
		while(rs.next())
		{
		 	mexamcode=rs.getString("examcode");
			if(QryExam.equals(""))
 			{			
			QryExam=mexamcode;
			%>
			<OPTION Selected Value =<%=mexamcode%>><%=mexamcode%></option>
			<%
			}
			else
			{
		%>
			<option value=<%=mexamcode%>><%=mexamcode%></option>
		<%
			}
		}
	}
	else
	{
		while(rs.next())
	  {
	   mexamcode=rs.getString("examcode");			
	   if(mexamcode.equals(request.getParameter("exam").toString().trim()))
	   {	
			QryExam=mexamcode;
	   %>
	    <option selected value=<%=mexamcode%>><%=mexamcode%></option>
	 	 <%
	   }	
     else
     {		
	   %>
	    <option  value=<%=mexamcode%>><%=mexamcode%></option>
	   <%
	   }	
	  }
  }
 %>
 </select>
</td>
<td colspan=2><font color=black face=arial size=2><STRONG>Class Type</STRONG></font>
<%
  qry="select distinct nvl(attendancetype,'R')attendancetype from V#studentattendance where StudentID='"+mMemberID+"' AND institutecode='"+mINSTITUTECODE+"' AND nvl(deactive,'N')='N' UNION select distinct nvl(attendancetype,'R')attendancetype from STUDENTPREVATTENDENCE where StudentID='"+mMemberID+"' AND institutecode='"+mINSTITUTECODE+"' AND nvl(deactive,'N')='N' ";
  rs=db.getRowset(qry);
//out.print(qry);
	%>
	<select name="ClassType" tabindex="0" id="ClassType" style="WIDTH: 100px">	
	<%   	
      if(request.getParameter("x")==null)
	{	
			QryType="ALL";
		%>	
			<OPTION selected value=ALL>ALL</option>
		<%
		while(rs.next())
		{
		 	mClasstype=rs.getString("attendancetype");
			if(mClasstype.equals("R"))
				mClassType="Regular";
			else
				mClassType="Extra";
			%>
				<option value=<%=mClasstype%>><%=mClassType%></option>
			<%
			
		}
	}
	else
	{
		if (request.getParameter("ClassType").toString().trim().equals("ALL"))
 		{
			QryType="ALL";
		%>
	 		<OPTION selected value=ALL>ALL</option>
		<%
		}
		else
		{
		%>
			<OPTION value=ALL>ALL</option>
		<%
		}
	  while(rs.next())
	  {
	   	mClasstype=rs.getString("attendancetype");			
	   	if(mClasstype.equals(request.getParameter("ClassType").toString().trim()))
	       {
		   QryType=mClasstype;
	    	   if(mClasstype.equals("R"))
			mClassType="Regular";
		   else
			mClassType="Extra";
					
		%>
	    	<option selected value=<%=mClasstype%>><%=mClassType%></option>
		  <%
		    }	
	      else
      	{		
      	if(mClasstype.equals("R"))
					mClassType="Regular";
				else
					mClassType="Extra";
	   	%>
	    <option  value=<%=mClasstype%>><%=mClassType%></option>
	   	<%
	    }	
	  }
  }
%>
</select>
<input type="submit" value="View Attendance"></td></tr>
</table></form>
<%
if(request.getParameter("x")!=null)
  {

			if(request.getParameter("exam")==null)
				QryExam="";
			else
				QryExam=request.getParameter("exam").toString().trim();	
	
	 		if(request.getParameter("ClassType")==null)
			{
				QryType="";
			}
			else
			{
				QryType=request.getParameter("ClassType").toString().trim();
			}
}
%>
<TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="98%" border=1 >
<thead>
<tr bgcolor="#c00000">
 <td Title="Click on SNo to sort"><b><font color="White">SNo</font></b></td>
 <td Title="Click on Subject to Sort"><b><font color="White">Subject</font></b></td>
 <td  Title="Click on Lecture+Tutorial(%) to Sort"><b><font color="White">Lecture+Tutorial(%)</font></b></td> 
 <td align=center Title="Click on Lecture(%) to Sort"><b><font color="White">Lecture(%)</font></b></td> 
 <td align=center Title="Click on Tutorial(%) to Sort"><b><font color="White">Tutorial(%)</font></b></td> 
 <td align=center Title="Click on Practical(%) to Sort"><b><font color="White">Practical(%)</font></b></td> 
</tr>
</thead>
<tbody>
<%
	qry="select distinct nvl(SUBJECT,' ') ||' - '|| NVL(SUBJECTCODE,' ') Subject , SUBJECTID";
	qry=qry+" FROM V#STUDENTATTENDANCE WHERE EXAMCODE='"+QryExam+"' and ATTENDANCETYPE=Decode('"+QryType+ "','ALL',ATTENDANCETYPE,'"+QryType+"')";
	qry=qry+" and STUDENTID='"+mMemberID+"' and INSTITUTECODE='"+mINSTITUTECODE+"' and nvl(DEACTIVE,'N')='N'";
	rs=db.getRowset(qry);
	msno=0;
	while(rs.next())
	{
		msno++ ;

	
	%>
	<tr>
		<td><%=msno%></td>	
		<td><%=rs.getString("SUBJECT")%></td>
	<%
		/*qry1="select NVL(LTP,' ')LTP, count(*)Tcount from V#STUDENTATTENDANCE where SubjectID='"+rs.getString("SubjectID")+"' and EXAMCODE='"+QryExam+"' and ATTENDANCETYPE=Decode('"+QryType+ "','ALL',ATTENDANCETYPE,'"+QryType+"')";
		qry1=qry1+" and STUDENTID='"+mMemberID+"' and INSTITUTECODE='"+mINSTITUTECODE+"' and nvl(DEACTIVE,'N')='N' Group By LTP";
		qry1=qry1+" union all select NVL(LTP,' ')LTP, count(*)Tcount from STUDENTPREVATTENDENCE where SubjectID='"+rs.getString("SubjectID")+"' and EXAMCODE='"+QryExam+"' and ATTENDANCETYPE=Decode('"+QryType+ "','ALL',ATTENDANCETYPE,'"+QryType+"')";
		qry1=qry1+" and STUDENTID='"+mMemberID+"' and INSTITUTECODE='"+mINSTITUTECODE+"' and nvl(DEACTIVE,'N')='N' Group By LTP";
*/



/*-----------------------------------QRY CHANGE BY GYAN Start--------------------------------------*/

/*qry1="SELECT   NVL (ltp, ' ') ltp, sum (tcount) tcount from (select NVL(LTP,' ')LTP, count(*)Tcount from V#STUDENTATTENDANCE where SubjectID='"+rs.getString("SubjectID")+"' and EXAMCODE='"+QryExam+"' and ATTENDANCETYPE=Decode('"+QryType+ "','ALL',ATTENDANCETYPE,'"+QryType+"')";
		qry1=qry1+" and STUDENTID='"+mMemberID+"' and INSTITUTECODE='"+mINSTITUTECODE+"' and nvl(DEACTIVE,'N')='N' Group By LTP";
		qry1=qry1+" union all select NVL(LTP,' ')LTP, count(*)Tcount from STUDENTPREVATTENDENCE where SubjectID='"+rs.getString("SubjectID")+"' and EXAMCODE='"+QryExam+"' and ATTENDANCETYPE=Decode('"+QryType+ "','ALL',ATTENDANCETYPE,'"+QryType+"')";
		qry1=qry1+" and STUDENTID='"+mMemberID+"' and INSTITUTECODE='"+mINSTITUTECODE+"' and nvl(DEACTIVE,'N')='N' Group By LTP)GROUP BY ltp";
*/
/*-----------------------------------QRY CHANGE BY GYAN END--------------------------------------*/

qry1="  SELECT NVL (c.LTP, ' ') LTP,( SELECT Count( Distinct a.CLASSTIMEFROM) TotalL   FROM V#STUDENTATTENDANCE a     WHERE exists (select null from v#studentltpdetail b where b.subjectid='"+rs.getString("SubjectID")+"'   And b.examcode='"+QryExam+"' AND b.STUDENTID = '"+mMemberID+"'   AND b.INSTITUTECODE = '"+mINSTITUTECODE+"' and b.ltp=a.ltp  and b.fstid=a.fstid and rownum =1 group by b.fstid)        AND a.EXAMCODE = '"+QryExam+"'  AND a.ATTENDANCETYPE =  DECODE ('"+QryType+ "', 'ALL', a.ATTENDANCETYPE, 'ALL')       AND a.INSTITUTECODE = '"+mINSTITUTECODE+"'   AND NVL (a.DEACTIVE, 'N') = 'N'   And A.LTP = c.ltp         ) tcount     FROM V#STUDENTATTENDANCE c WHERE c.SubjectID = '"+rs.getString("SubjectID")+"' AND c.EXAMCODE ='"+QryExam+"' AND c.ATTENDANCETYPE =    DECODE ('"+QryType+ "', 'ALL', c.ATTENDANCETYPE, 'ALL')   AND c.STUDENTID = '"+mMemberID+"'    AND c.INSTITUTECODE = '"+mINSTITUTECODE+"'   AND NVL (c.DEACTIVE, 'N') = 'N' GROUP BY LTP   UNION ALL    SELECT NVL (c.LTP, ' ') LTP,( SELECT Count( Distinct a.CLASSTIMEFROM) TotalL   FROM STUDENTPREVATTENDENCE a WHERE exists (select null from STUDENTPREVATTENDENCE b where b.subjectid='"+rs.getString("SubjectID")+"'   And b.examcode='"+QryExam+"' AND b.STUDENTID = '"+mMemberID+"'    AND b.INSTITUTECODE = 'JUIT' and b.ltp=a.ltp  and b.fstid=a.fstid and rownum =1 group by b.fstid)    AND a.EXAMCODE = '"+QryExam+"'   AND a.ATTENDANCETYPE =  DECODE ('"+QryType+ "', 'ALL', a.ATTENDANCETYPE, 'ALL')    AND a.INSTITUTECODE = '"+mINSTITUTECODE+"'  AND NVL (a.DEACTIVE, 'N') = 'N'  And A.LTP = c.ltp      ) tcount FROM STUDENTPREVATTENDENCE c  WHERE c.SubjectID = '"+rs.getString("SubjectID")+"' AND c.EXAMCODE = '"+QryExam+"' AND c.ATTENDANCETYPE =   DECODE ('"+QryType+ "', 'ALL', c.ATTENDANCETYPE, 'ALL')  AND c.STUDENTID = '"+mMemberID+"'  AND c.INSTITUTECODE = '"+mINSTITUTECODE+"'  AND NVL (c.DEACTIVE, 'N') = 'N'  GROUP BY LTP";

	rs1=db.getRowset(qry1);
	out.print(qry1+"<br>");
		while(rs1.next())
		{
			if(rs1.getString("LTP").equals("L"))
			{
				mL=rs1.getLong("Tcount");
			}	
			if(rs1.getString("LTP").equals("T"))
			{
				mT=rs1.getLong("Tcount");
			}	
			if(rs1.getString("LTP").equals("P"))
			{
				mP=rs1.getLong("Tcount");
			}
		}
		/*qry1="select NVL(LTP,' ')LTP, count(*)Pcount from V#STUDENTATTENDANCE where SubjectID='"+rs.getString("SubjectID")+"' and EXAMCODE='"+QryExam+"' and ATTENDANCETYPE=Decode('"+QryType + "','ALL',ATTENDANCETYPE,'"+ QryType +"')";
		qry1=qry1+" and STUDENTID='"+mMemberID+"' and INSTITUTECODE='"+mINSTITUTECODE+"' and nvl(PRESENT,'N')='Y' and nvl(DEACTIVE,'N')='N' Group By LTP";
		qry1=qry1+" union all select NVL(LTP,' ')LTP, count(*)Pcount from STUDENTPREVATTENDENCE where SubjectID='"+rs.getString("SubjectID")+"' and EXAMCODE='"+QryExam+"' and ATTENDANCETYPE=Decode('"+QryType + "','ALL',ATTENDANCETYPE,'"+ QryType +"') ";
		qry1=qry1+" and STUDENTID='"+mMemberID+"' and INSTITUTECODE='"+mINSTITUTECODE+"' and nvl(PRESENT,'N')='Y' and nvl(DEACTIVE,'N')='N' Group By LTP ";*/
		qry1="SELECT   NVL (ltp, ' ') ltp, sum (Pcount) Pcount from (select NVL(LTP,' ')LTP, count(*)Pcount from V#STUDENTATTENDANCE where SubjectID='"+rs.getString("SubjectID")+"' and EXAMCODE='"+QryExam+"' and ATTENDANCETYPE=Decode('"+QryType + "','ALL',ATTENDANCETYPE,'"+ QryType +"')";
		qry1=qry1+" and STUDENTID='"+mMemberID+"' and INSTITUTECODE='"+mINSTITUTECODE+"' and nvl(PRESENT,'N')='Y' and nvl(DEACTIVE,'N')='N' Group By LTP";
		qry1=qry1+" union all select NVL(LTP,' ')LTP, count(*)Pcount from STUDENTPREVATTENDENCE where SubjectID='"+rs.getString("SubjectID")+"' and EXAMCODE='"+QryExam+"' and ATTENDANCETYPE=Decode('"+QryType + "','ALL',ATTENDANCETYPE,'"+ QryType +"') ";
		qry1=qry1+" and STUDENTID='"+mMemberID+"' and INSTITUTECODE='"+mINSTITUTECODE+"' and nvl(PRESENT,'N')='Y' and nvl(DEACTIVE,'N')='N' Group By LTP )GROUP BY ltp";
		//out.print(qry1);
		rs1=db.getRowset(qry1);
	
		
		while(rs1.next())
		{
			if(rs1.getString("LTP").equals("L"))
			{
				mLP=rs1.getLong("Pcount");
			}	
			if(rs1.getString("LTP").equals("T"))
			{
				mTP=rs1.getLong("Pcount");
			}	
			if(rs1.getString("LTP").equals("P"))
			{
				mPP=rs1.getLong("Pcount");
			}
		}
if(mL>0)
{
		mPercL=((mLP*100)/mL);
		mPercLT=((mLP+mTP)*100)/(mL+mT);

		if(mPercLT<50)
		{
			
		%>
		<td align=center><a Title="View Date wise Lecture + Tutorial Attendance" target=_New href='ViewDatewiseLecTecAttendance.jsp?EXAM=<%=QryExam%>&amp;CTYPE=<%=QryType%>&amp;SC=<%=rs.getString("SUBJECTID")%>&amp;LTP=LT'><font color=red><%=mPercL%></font></a></td>
		<%
		}
		else
		{
			//out.print(mPercLT+"sdff");
		%>
		<td align=center><a Title="View Date wise Lecture + Tutorial Attendance" target=_New href='ViewDatewiseLecTecAttendance.jsp?EXAM=<%=QryExam%>&amp;CTYPE=<%=QryType%>&amp;SC=<%=rs.getString("SUBJECTID")%>&amp;LTP=LT'><%=mPercLT%></a></td>
		<%
		}


		if(mPercL<50)
		{
			
		%>
		<td align=center><a Title="View Date wise Lecture Attendance" target=_New href='ViewDatewiseLecAttendance.jsp?EXAM=<%=QryExam%>&amp;CTYPE=<%=QryType%>&amp;SC=<%=rs.getString("SUBJECTID")%>&amp;LTP=L'><font color=red><%=mPercL%></font></a></td>
		<%
		}
		else
		{
			//out.print(mPercLT+"sdff");
		%>
		<td align=center><a Title="View Date wise Lecture Attendance" target=_New href='ViewDatewiseLecAttendance.jsp?EXAM=<%=QryExam%>&amp;CTYPE=<%=QryType%>&amp;SC=<%=rs.getString("SUBJECTID")%>&amp;LTP=L'><%=mPercL%></a></td>
		<%
		}
}
else
{
%>
<td>&nbsp;</td>
<td>&nbsp;</td>
<%
}
if(mT>0)
{
		mPercT=((mTP*100)/mT);
		if(mPercT<=50)
		{
		%>
		<td align=center><a Title="View Date wise Tutorial Attendance" target=_New href='ViewDatewiseTutAttendance.jsp?EXAM=<%=QryExam%>&amp;CTYPE=<%=QryType%>&amp;SC=<%=rs.getString("SUBJECTID")%>&amp;LTP=T'><font color=red><%=mPercT%></font></a></td>
		<%
		}
		else
		{
		%>
		<td align=center><a Title="View Date wise Tutorial Attendance" target=_New href='ViewDatewiseTutAttendance.jsp?EXAM=<%=QryExam%>&amp;CTYPE=<%=QryType%>&amp;SC=<%=rs.getString("SUBJECTID")%>&amp;LTP=T'><%=mPercT%></a></td>
		<%
		}
}
else
{
%>
<td>&nbsp;</td>
<%
}
if(mP>0)
{
		mPercP=((mPP*100)/mP);
		if(mPercP<=50)
		{
		%>
		<td align=center><a Title="View Date wise Practical Attendance" target=_New href='ViewDatewiseLabAttendance.jsp?EXAM=<%=QryExam%>&amp;CTYPE=<%=QryType%>&amp;SC=<%=rs.getString("SUBJECTID")%>&amp;LTP=P'><font color=red><%=mPercP%></font></a></td>
		<%
		}
		else
		{
		%>
		<td align=center><a Title="View Date wise Practical Attendance" target=_New href='ViewDatewiseLabAttendance.jsp?EXAM=<%=QryExam%>&amp;CTYPE=<%=QryType%>&amp;SC=<%=rs.getString("SUBJECTID")%>&amp;LTP=P'><%=mPercP%></a></td>
		<%
		}
}
else
{
%>
<td>&nbsp;</td>
<%
}
mL=0;
mT=0;
mP=0;
mLP=0;
mTP=0;
mPP=0;
%>
</tr>	
<%
}
%>
</tbody>
</table>		
<table><tr><td><font size=2 color=red face=verdana><B>&nbsp;Hint:</B> </font>
 <UL>
	<font face="verdana" size=2 color=Green><LI>
	<B>If the '%' attendance of Lecture, Tutorial or Practical is less than 50%, It will appear in red color.</B> 
	<LI><B>By clicking on '%' link you can view attendance datewise.</B>
	<LI><B>In case of any doubt, contact respective faculty.</B></font>
 </UL>

</font></td></tr>


<tr><td><font size=2 color=red face=verdana><B>&nbsp;Note:</B>
 <UL>
	<font face="verdana" size=2 color=black>
	<LI><B>Attendance of Monday to Wednesday  will be updated by Saturday of the current week. </B> 
	<LI><B>Attendance of Thursday to Saturday will be updated by Wednesday of the following week. </B>
</font>
 </UL>
</td></tr>


</table>
<script type="text/javascript">
var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString"]);
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
	<P>	This page is not authorized/available to you.
	<br>For assistance, contact your network support team. 
	</font>	<br>	<br>	<br>	<br> 
   <%
	}
    		 //-----------------------------
}   //2
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
}	//1	
catch(Exception e)
{
	//out.print(qry);
}
%>
</body>
</html>