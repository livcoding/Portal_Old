<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<!--<%=request.getContextPath()%>-->
<%
try
{

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";

%>



<html>
<head>
<TITLE>#### <%=mHead%> [ Event-Wise Project Marks Entry Forcibly After Finalization] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
</script>

 <script language="javascript">
function kH(e) {

var pK = document.all? window.event.keyCode:e.which;
return pK != 13;
}

document.onkeypress = kH;
if (document.layers) document.captureEvents(Event.KEYPRESS);
</script>


<script language=javascript>
<!--
function RefreshContents()
{ 	
    document.frm.x.value='ddd';
    document.frm.submit();
}
function Marks_Check(objtxt,mMax)
{
	if(objtxt.value!='' && objtxt.value.length>0)
	{
	 	var entry=objtxt.value;
		if(parseFloat(entry)>=0 )
		{
			if(objtxt.value>mMax)
			{
				alert('Marks Must be <='+mMax);
				objtxt.value='';
				objtxt.focus;
			}
		 	else if(objtxt.value<=mMax)
			{
				objtxt.focus;
			}
		}
		else
		{
			alert('Invalid Marks!');
			objtxt.value='';
		  	objtxt.focus;
		}
	}
}
function showAlert()
{
	if(document.frm1("Proceed").checked==true)
	{
		alert('Once You will check and Lock , You cannot enter marks of the rest students further');
	}
	else
	{
		alert('You cannot proceed for Grade Entry until you check it and Lock it.');
	}
}
//-->
</SCRIPT>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 onkeydown="if(event.keyCode==13){event.keyCode=9;return event.keyCode}">
<%
GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
ResultSet rsse=null;
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="",mDept="",mDeptCode="",mDesg="", mComp="", minst="", mInst="",mDMemberID="";
String mExamid="",mEventsubevent="",mSubj="";
String qry="",x="";
int msno=0, len =0, pos=0;
String mSE="", mSPMarks1="", mSPMarks2="", mSMarks="";
double mAvgMarks=0, mWeight=0, mMaxmarks=0,MyMax=0;
int ctr=0, mGroupID=1;
String mStatus="";
String mIC="",mEC="",mSC="",mList="",mOrder="",mEvent="", mExamsubevent="",mExamevent="";
ResultSet rs=null,rss=null,rs1=null,rs2=null,rs3=null,rse=null,rsm=null;
String mMOP="",mlistorder="",mctr="",qrys="",mSelf="Self";		
String mName1="",mName2="",mName3="",mName4="",mName5="";

session.setAttribute("Click",mSelf);

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

if (session.getAttribute("DepartmentCode")==null)
{
	mDeptCode="";
}
else
{
	mDeptCode=session.getAttribute("DepartmentCode").toString().trim();
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
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}

if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
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

		qry="Select WEBKIOSK.ShowLink('244','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	      RsChk1= db.getRowset(qry);
		if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
		{
	  //----------------------
	%>
	<form name="frm"  method="get" >
	<input id="x" name="x" type=hidden>
	<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><B>Event/Sub Event wise Project Marks Project Marks Entry Forcibly (After Finalization)</B></font></TD></tr>
	</TABLE>

                <table cellpadding=1 cellspacing=0 align=center rules=groups border=3>
                <tr><td><font color=Green face=arial size=2><STRONG><%=mMemberName%>[<%=mDMemberCode%>]
                &nbsp;&nbsp; : &nbsp;<%=GlobalFunctions.toTtitleCase(mDesg)%>&nbsp; (<%=GlobalFunctions.toTtitleCase(mDept)%>)
                </td></tr>
                <!--Institute****-->
                <tr><td><FONT color=black><FONT face=Arial size=2><STRONG>Institute</STRONG></FONT></FONT>
                <%
                try
                {
                    qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from institutemaster Where InstituteCode='"+mInst+"' and nvl(Deactive,'N')='N' ";
                    rs=db.getRowset(qry);
                    if (request.getParameter("x")==null)
                    {
                        %>
                        <select name=InstCode tabindex="1" id="InstCode" style="WIDTH: 80px">
                        <%
                        while(rs.next())
                        {
                            mInst=rs.getString("InstCode");
                            if(mInst.equals(""))
                                minst=mInst;
                            %>
                            <OPTION selected Value =<%=mInst%>><%=mInst%></option>
                            <%
                        }
                        %>
                        </select>
                        <%
                     }
                     else
                     {
                        %>
                        <select name=InstCode tabindex="1" id="InstCode" style="WIDTH: 80px">
                        <%
                        while(rs.next())
                        {
                            mInst=rs.getString("InstCode");
                            if(mInst.equals(request.getParameter("InstCode").toString().trim()))
                            {
                                %>
                                <OPTION selected Value =<%=mInst%>><%=mInst%></option>
                                <%
                            }
                            else
                            {
                                %>
                                <OPTION Value =<%=mInst%>><%=mInst%></option>
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
                %>
                <!--*********Exam**********-->
                &nbsp;&nbsp;<FONT color=black><FONT face=Arial size=2><STRONG>Exam Code</STRONG></FONT></FONT>
                <%
                    try
                    {
                        qry="Select distinct NVL(GRADEENTRYEXAMID,' ')GRADEENTRYEXAMID from COMPANYINSTITUTETAGGING Where InstituteCode='"+mInst+"' And CompanyCode='"+mComp+"'";
                        //out.print(qry);
                        rs=db.getRowset(qry);
                        if (request.getParameter("x")==null)
                        {
                            %>
                            <select name=Exam tabindex="2" id="Exam" style="WIDTH: 229px">
                            <OPTION selected Value="NONE"><b><-- Select an Exam Code --></b></option>
                            <%
                            while(rs.next())
                            {
                                mExamid=rs.getString("GRADEENTRYEXAMID");
                                %>
                                <OPTION Value =<%=mExamid%>><%=mExamid%></option>
                                <%
                            }
                            %>
                            </select>
                            <%
                        }
                        else
                        {
                            %>
                            <select name=Exam tabindex="2" id="Exam" style="WIDTH: 229px">
                            <OPTION Value="NONE"><b><-- Select an Exam Code --></b></option>
                            <%
                            while(rs.next())
                            {
                                mExamid=rs.getString("GRADEENTRYEXAMID");
                                if(mExamid.equals(request.getParameter("Exam").toString().trim()))
                                {
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
                    %>
                    &nbsp;&nbsp;<FONT color=black><FONT face=Arial size=2><STRONG>Event-Subevent</STRONG></FONT></FONT>
                    <%
                    try
                    {
                        qry="select EVENTSUBEVENT from V#EXAMEVENTSUBJECTTAGGING where ";
                        qry=qry+" trunc(sysdate) between trunc(FROMDATE) and trunc(TODATE) and facultytype=decode('"+mDMemberType+"','E','I','E')";
                        qry=qry+" AND (fstid) in ((select fstid from  facultysubjecttagging where facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid IN (SELECT EMPLOYEEID FROM EMPLOYEEMASTER WHERE DEPARTMENTCODE='"+mDeptCode+"') and nvl(deactive,'N')='N' AND LTP='E' AND PROJECTSUBJECT='Y'))";
				qry=qry+" and nvl(locked,'N')='N' and nvl(PUBLISHED,'N')='Y' ";
                        qry=qry+"GROUP BY EVENTSUBEVENT ORDER BY EVENTSUBEVENT";
                        //out.print(qry);
                        rse=db.getRowset(qry);

                        if (request.getParameter("x")==null)
                        {
                            %>
                            <select name="Event" tabindex="3" id="Event" style="WIDTH: 215px">
                            <OPTION selected Value="NONE"><b><-- Select an Event-Subevent --></b></option>
                            <%
                            while(rse.next())
                            {
                                mEventsubevent=rse.getString("EVENTSUBEVENT").toString().trim();
                                %>
                                <OPTION Value ="<%=mEventsubevent%>"><%=mEventsubevent%></option>
                                <%
                            }
                            %>
                            </select>
                            <%
                        }
                        else
                        {
                            %>
                            <select name="Event" tabindex="3" id="Event" style="WIDTH: 215px">
                            <OPTION Value="NONE"><b><-- Select an Event-Subevent --></b></option>
                            <%
                            while(rse.next())
                            {
                                mEventsubevent=rse.getString("EVENTSUBEVENT").toString().trim();
                                if(mEventsubevent.equals(request.getParameter("Event").toString().trim()))
                                {
                                    %>
                                    <OPTION selected Value ="<%=mEventsubevent%>"><%=mEventsubevent%></option>
                                    <%
                                }
                                else
                                {
                                    %>
                                    <OPTION Value ="<%=mEventsubevent%>"><%=mEventsubevent%></option>
                                    <%
                                }
                            }
                            %>
                            </select>
                            <%
                        }
                        //out.println("Subevent"+mEventsubevent);
                    }
                    catch(Exception e)
                    {
                        //out.print("error");
                    }
                    %>
                    </td></tr>
                    <tr><td>
                    <!--SUBJECT**************-->
                    <FONT color=black><FONT face=Arial size=2><STRONG>Subject</STRONG></FONT></FONT>
                    <%
                    try
                    {
                        qry="select subject||' ( '||subjectcode||' )' subject, subjectID from V#EXAMEVENTSUBJECTTAGGING where ";
                        qry=qry+" trunc(sysdate) between trunc(FROMDATE) and trunc(TODATE) and facultytype=decode('"+mDMemberType+"','E','I','E')";
                        qry=qry+" AND (fstid) in ((select fstid from  facultysubjecttagging where facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid IN (SELECT EMPLOYEEID FROM EMPLOYEEMASTER WHERE DEPARTMENTCODE='"+mDeptCode+"') and nvl(deactive,'N')='N' AND LTP='E' AND PROJECTSUBJECT='Y'))";
                        qry=qry+" and nvl(locked,'N')='N' and nvl(PUBLISHED,'N')='Y' ";
                        qry=qry+" GROUP BY subject||' ( '||subjectcode||' )',subjectID";
                        //out.print(qry);
                        rss=db.getRowset(qry);
                        if (request.getParameter("x")==null)
                        {
                                %>
                                <select name=Subject tabindex="4" id="Subject" style="WIDTH: 400px">
                                <%
                                while(rss.next())
                                {
                                        mSubj=rss.getString("SubjectID");
                                        if(mSC.equals(""))
                                        mSC=mSubj;
                                        %>
                                        <OPTION Value =<%=mSubj%>><%=rss.getString("Subject")%></option>
                                        <%
                                }
                                %>
                                </select>
                                <%
                        }
                        else
                        {
                                %>
                                <select name=Subject tabindex="4" id="Subject" style="WIDTH: 400px">
                                <%
                                while(rss.next())
                                {
                                        mSubj=rss.getString("SubjectID");
                                        if(mSubj.equals(request.getParameter("Subject").toString().trim()))
                                        {
                                                mSC=mSubj;
                                                %>
                                                <OPTION selected Value =<%=mSubj%>><%=rss.getString("Subject")%></option>
                                                <%
                                        }
                                        else
                                      {
                                                %>
                                        <OPTION Value =<%=mSubj%>><%=rss.getString("Subject")%></option>
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
                    <FONT color=black><FONT face=Arial size=2><STRONG>&nbsp; List order in:</STRONG></FONT></FONT>
                    <select name=listorder tabindex="5" id="listorder" style="WIDTH: 125px">
                    <%
                    if(request.getParameter("listorder")==null)
                    {
                        %>
                        <OPTION Value =EnrollNo selected>Enrollment No.</option>
                        <!--<OPTION Value =Studentname>Student Name</option>
                        <OPTION Value =Subsectioncode >Subsection/Group</option>-->
                        <%
                    }
                    else
                    {
                        mlistorder=request.getParameter("listorder");
                        if(mlistorder.equals("EnrollNo"))
                        {
                            %>
                            <OPTION Value =EnrollNo selected>Enrollment No.</option>
                            <!--<OPTION Value =Studentname>Student Name</option>
                            <OPTION Value =Subsectioncode>Subsection/Group</option>-->
                            <%
                        }
                    }
                    %>
                    </select>
                    <select name=order tabindex="6" id="order" style="WIDTH: 105px">
                    <%
                    if(request.getParameter("order")==null)
                    {
                        %>
                        <OPTION Value =Asc selected>Ascending</option>
                        <!--<OPTION Value =Desc>Descending</option>-->
                        <%
                    }
                    else
                    {
                        mlistorder=request.getParameter("order");
                        if(mlistorder.equals("Asc"))
                        {
                            %>
                            <OPTION Value =Asc selected>Ascending</option>
                            <!--<OPTION Value =Desc>Descending</option>-->
                            <%
                        }
                    }
                    %>
                    </select>
                    </td></tr>
                    <tr><td align=center><INPUT Type="submit" Value="Show/Refresh"></td></tr>
                </table>
                </form>
<%
int tabctrtxt=7;
int tabctrchk=1000;		
if(request.getParameter("x")!=null)
{
	if(request.getParameter("Subject")!=null && request.getParameter("Event")!=null && request.getParameter("Exam")!=null)
      {
		mIC=request.getParameter("InstCode").toString().trim();
		mEC=request.getParameter("Exam").toString().trim();
		mSC=request.getParameter("Subject").toString().trim();
		mList=request.getParameter("listorder").toString().trim();
		mOrder=request.getParameter("order").toString().trim();
		mEvent=request.getParameter("Event").toString().trim();	
		//out.println(mSC);
		len=mEvent.length();
		pos=mEvent.indexOf("#");
		if(pos>0)
		{
			mSE=mEvent.substring(0,pos);
		}
		else
		{
			mSE=mEvent.toString().trim();
		}

		try
		{
		qrys="select nvl(detainedstatus,'A')detainedstatus from exameventmaster ";  
		qrys=qrys+" where institutecode='"+mIC+"' and  examcode='"+mEC+"' and  exameventcode='"+mSE+"' ";
		//out.println("dfs "+qrys);
		ResultSet rsStatus=db.getRowset(qrys);
		if(rsStatus.next())
		{
			mStatus=rsStatus.getString("detainedstatus");	
		}
		}
		catch(Exception e)
		{
		}

		if(!mEC.equals("NONE") && !mEvent.equals("NONE"))
		{
            	qry="select WEIGHTAGE, MARKSORPERCENTAGE, MAXMARKS from V#EXAMEVENTSUBJECTTAGGING  ";
                  qry=qry+" where institutecode='"+mIC+"' and  examcode='"+mEC+"' ";
                  qry=qry+" AND EMPLOYEEID IN (SELECT EMPLOYEEID FROM EMPLOYEEMASTER WHERE DEPARTMENTCODE='"+mDeptCode+"')";
                  qry=qry+" And EVENTSUBEVENT='"+mEvent+"' AND LTP='E' AND PROJECTSUBJECT='Y' and subjectID='"+mSC+"' AND  NVL (deactive, 'N') = 'N' ";
		//out.print(qry);
		rsm=db.getRowset(qry);
		if(rsm.next())
		{
			mMOP=rsm.getString("MARKSORPERCENTAGE");
			mMaxmarks=rsm.getDouble("MAXMARKS");
			mWeight=rsm.getDouble("WEIGHTAGE");		
		}		
		
		if (mMOP.equals("M"))
			MyMax=mMaxmarks;
		else	
			MyMax=100;

		%>	
		<form name="frm1"  method="post" action="ProjMarksEntryForciblyAction.jsp">
		<%
		//len=mEvent.length();
		//pos=mEvent.indexOf("#");
		//mExamevent=mEvent.substring(0,pos);
		//mExamsubevent=mEvent.substring(pos+1,len);
		try
		{
			qry="select fstid,nvl(studentid,' ')studentid,nvl(studentname,' ')StudentName, nvl(enrollmentno,' ')EnrollNo, nvl(semester,0)Semester,";
			qry=qry+ " nvl(programcode,' ')||' ('||nvl(SECTIONBRANCH,' ')||' - '||subsectioncode||')' Course from V#EXAMEVENTSUBJECTTAGGING ";
			qry=qry+" where institutecode='"+mIC+"' and nvl(DEACTIVE,'N')='N' and nvl(locked,'N')='N' and nvl(PUBLISHED,'N')='Y' and ";
			qry=qry+" examcode='"+mEC+"' AND LTP='E' AND PROJECTSUBJECT='Y' and subjectID='"+mSC+"' ";
      	      qry=qry+" AND EMPLOYEEID IN (SELECT EMPLOYEEID FROM EMPLOYEEMASTER WHERE DEPARTMENTCODE='"+mDeptCode+"')";
	            qry=qry+" AND EVENTSUBEVENT='"+mEvent+"' and nvl(GROUPIDNO,1)="+mGroupID+"" ;
			qry=qry+" GROUP BY fstid,studentid,StudentName,enrollmentno,Semester, programcode,SECTIONBRANCH, subsectioncode";
			qry=qry+" order by "+mList+ " "+mOrder+ " ";
		//out.print(qry);
		rs1=db.getRowset(qry);
		msno=0;
		ctr=0;
		//out.print(mMOP);
		//out.print(mMaxmarks);
		while(rs1.next())
		{
			ctr++;
			if(ctr==1)
			{
				if(mMOP.equals("M"))
				{
					%>
					<CENTER><FONT face=Arial size=2 color=navy><STRONG>Maximum Marks (Full Marks for Evaluation) : </STRONG><%=mMaxmarks%></FONT>
					&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2 color=navy><STRONG>Weightage in Percentage : </STRONG><%=mWeight%></FONT></CENTER>
					<%
				}
				else
				{
					%>
					<CENTER><FONT face=Arial size=2 color=navy><STRONG>Maximum Marks (Full Marks for Evaluation) : </STRONG><%=mMaxmarks%></FONT>
					&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2 color=navy><STRONG>Weightage in Percentage : </STRONG><%=mWeight%></CENTER></FONT>
					<%
				}
				%>
				<table bgcolor=#fce9c5 class="sort-table" id="table-1" cellspacing=0 cellpadding=0 width=98% border=1 align=center>
				<thead>
				<tr bgcolor="#ff8c00" height=40px>
				<td align=center><b><font color=white face=arial size=2>SNo.</font></b></td>
				<td align=center><b><font color=white face=arial size=2>Enroll. No</font></b></td>
				<td align=left><b><font color=white face=arial size=2>Student Name</font></b></td>
				<td align=center><b><font color=white face=arial size=2 nowrap>Marks Allotted<BR> out of <%=mMaxmarks%><br>By Faculty-1</font></b></td>
				<td align=center><b><font color=white face=arial size=2 nowrap>Marks Allotted<BR> out of <%=mMaxmarks%><br>By Faculty-2</font></b></td>
				<td align=center><b><font color=white face=arial size=2 nowrap>Marks Final Allotted<BR> out of <%=mMaxmarks%><BR>AVG. of 1 & 2</font></b></td>
				<!--<td align=left><b><font color=white face=arial size=2>Course <BR>(Section-Sub Section)<font></b></td>-->
				<!--<td align=center><b><font color=white face=arial size=2>Sem.<font></b></td>-->
				<%
				qry="Select Distinct A.EventSubEvent, nvl(A.WEIGHTAGE,0)WEIGHTAGE, nvl(A.MAXMARKS,0)MAXMARKS, to_date(A.FROMDATE,'dd-mm-yyyy')FDate, to_date(A.TODATE,'dd-mm-yyyy')TDate from ExamEventSubjectTagging A Where A.FSTID IN (SELECT F.FSTID FROM FACULTYSUBJECTTAGGING F WHERE F.examcode='"+mEC+"' AND F.LTP='E' AND F.PROJECTSUBJECT='Y' and F.subjectID='"+mSC+"') AND A.FSTID IN (SELECT B.FSTID FROM STUDENTEVENTSUBJECTMARKS B WHERE NVL(B.LOCKED,'N')='Y' AND A.FSTID=B.FSTID AND A.EVENTSUBEVENT=B.EVENTSUBEVENT) AND A.EVENTSUBEVENT NOT IN ('"+mEvent+"') ORDER BY FDate, TDate";
				//out.print(qry);
				rs2=db.getRowset(qry);
				while(rs2.next())
				{
					%><td align=center nowrap><b><font color=white face=arial size=2><%=rs2.getString("EventSubEvent")%> Marks <BR>Allotted<BR>out of <%=rs2.getString("MAXMARKS")%><font></b></td><%
				}
				%>
				</tr>	
				</thead>
				<tbody>
				<%
			}
			tabctrtxt++;
			tabctrchk++;
			mctr=String.valueOf(ctr).trim();
		    	msno++;
			mName1="Semester"+String.valueOf(ctr).trim();  
			mName2="Studentid"+String.valueOf(ctr).trim();
			mName3="Marks"+String.valueOf(ctr).trim();
			mName4="Detained"+String.valueOf(ctr).trim();
			mName5="Fstid"+String.valueOf(ctr).trim();
			%>	
			<tr>
			<td align=right><%=msno%>.&nbsp; &nbsp; &nbsp; </td>
			<td><%=rs1.getString("EnrollNo")%></td>
			<td><%=GlobalFunctions.toTtitleCase(rs1.getString("studentname"))%></td>
			<%
		
//---------------------------------------------Start of Proj Marks I & II--------------------------------------

                qry="Select nvl(PROJMARKS1,-1)PROJMARKS1, nvl(PROJDETAINED1,'N') PROJDETAINED1 from STUDENTEVENTPROJECTMARKS1";
		    qry=qry+" where fstid='"+rs1.getString("fstid")+"' and EVENTSUBEVENT='"+mEvent+"' and STUDENTID='"+rs1.getString("studentid")+"' ";
		    rs2=db.getRowset(qry);
                if(rs2.next())
                {
                    mSPMarks1 = rs2.getString("PROJMARKS1");
                    if(mSPMarks1.equals("-1"))
                        mSPMarks1 = rs2.getString("PROJDETAINED1");
                        if(mSPMarks1.equals("N"))
                            mSPMarks1 = "";
                }
                else
                {
                    mSPMarks1 = "";
                }
                qry="Select nvl(PROJMARKS2,-1)PROJMARKS2, nvl(PROJDETAINED2,'N') PROJDETAINED2 from STUDENTEVENTPROJECTMARKS2";
		    qry=qry+" where fstid='"+rs1.getString("fstid")+"' and EVENTSUBEVENT='"+mEvent+"' and STUDENTID='"+rs1.getString("studentid")+"' ";
		    rs2=db.getRowset(qry);
		    //out.print(qry);
                if(rs2.next())
                {
                    mSPMarks2 = rs2.getString("PROJMARKS2");
                    if(mSPMarks2.equals("-1"))
                        mSPMarks2= rs2.getString("PROJDETAINED2");
                        if(mSPMarks2.equals("N"))
                            mSPMarks2 = "";
                }
                else
                {
                    mSPMarks2 = "";
                }

//---------------------------------------------End of Proj Marks I & II--------------------------------------

//---------------------------------------------Start of Proj Marks Final-------------------------------------

                qry="Select nvl(MARKSAWARDED1,-1)MARKSAWARDED1, ";
		    qry=qry+" nvl(DETAINED,'N') DETAINED from V#STUDENTEVENTSUBJECTMARKS ";
		    qry=qry+" where INSTITUTECODE='"+mIC+"' and EXAMCODE='"+mEC+"' and ";
		    qry=qry+" EVENTSUBEVENT='"+mEvent+"' and ";
		    qry=qry+" fstid='"+rs1.getString("fstid")+"' and STUDENTID='"+rs1.getString("studentid")+"' ";
		    //out.print(qry);
		    rs2=db.getRowset(qry);
                if(rs2.next())
                {
                    mSMarks = rs2.getString("MARKSAWARDED1");
                    if(mSMarks.equals("-1"))
                        mSMarks = rs2.getString("DETAINED");
                        if(mSMarks.equals("N"))
                            mSMarks = "";
                }
                else if((mSPMarks1.equals("A") && mSPMarks2.equals("A")) || (mSPMarks1.equals("D") && mSPMarks2.equals("D")))
                {
                    mSMarks="0";
                }
                else if((!mSPMarks1.equals("A") || !mSPMarks1.equals("D")) && (mSPMarks2.equals("A") || mSPMarks2.equals("D")))
                {
                    mSMarks=""+Double.parseDouble(mSPMarks1);
                }
                else if((mSPMarks1.equals("A") || mSPMarks1.equals("D")) && (!mSPMarks2.equals("A") || !mSPMarks2.equals("D")))
                {
                    mSMarks=""+Double.parseDouble(mSPMarks2);
                }
                else
                {
                    mSMarks="";
                }
		    try
		    {
		    	if(!mSPMarks1.equals("") && !mSPMarks2.equals("") && mSMarks.equals("") && !mSMarks.equals("A") && !mSPMarks1.equals("D") && !mSPMarks2.equals("A") && !mSPMarks2.equals("D") && Double.parseDouble(mSPMarks1)>=0 && Double.parseDouble(mSPMarks2)>=0)
			{
				mAvgMarks=(Double.parseDouble(mSPMarks1) + Double.parseDouble(mSPMarks2))/2;
				mSMarks=mAvgMarks+"";
			}
		    }
		    catch(Exception e)
		    {
			//out.print(e+qry);
		    }

//---------------------------------------------End of Proj Marks Final---------------------------------------

		    x="";
		    if(mMOP.equals("P"))
		    x="%";
		    if(mSPMarks1.equals(""))
			mSPMarks1="&nbsp;";
		    if(mSPMarks2.equals(""))
			mSPMarks2="&nbsp;";
		    %>
		    <td align=center><%=mSPMarks1%></td>
		    <td align=center><%=mSPMarks2%></td>
		    <td align=center><input tabindex="<%=tabctrtxt%>" type=text name='<%=mName3%>' id='<%=mName3%>' value="<%=mSMarks%>" style="WIDTH: 40px; height: 20px; text-align:right; width:35px; font-size:10px; color:navy;" maxlength=5 onBlur="Marks_Check(<%=mName3%>,<%=MyMax%>);"  onchange="Marks_Check(<%=mName3%>,<%=MyMax%>);"><%=x%></td>
		    <!--<td><%=rs1.getString("Course")%></td>-->
		    <!--<td align=center><%=rs1.getString("semester")%></td>-->
		    <%
			qry="Select Distinct A.EventSubEvent, nvl(A.WEIGHTAGE,0)WEIGHTAGE, to_date(A.FROMDATE,'dd-mm-yyyy')FDate, to_date(A.TODATE,'dd-mm-yyyy')TDate from ExamEventSubjectTagging A Where A.FSTID IN (SELECT F.FSTID FROM FACULTYSUBJECTTAGGING F WHERE F.examcode='"+mEC+"' AND F.LTP='E' AND F.PROJECTSUBJECT='Y' and F.subjectID='"+mSC+"') AND A.FSTID IN (SELECT B.FSTID FROM STUDENTEVENTSUBJECTMARKS B WHERE NVL(B.LOCKED,'N')='Y' AND A.FSTID=B.FSTID AND A.EVENTSUBEVENT=B.EVENTSUBEVENT) AND A.EVENTSUBEVENT NOT IN ('"+mEvent+"') ORDER BY FDate, TDate";
			//out.print(qry);
			rs2=db.getRowset(qry);
			while(rs2.next())
			{
	                qry="Select nvl(MARKSAWARDED1,-1)MARKSAWARDED1, ";
			    qry=qry+" nvl(DETAINED,'N') DETAINED from V#STUDENTEVENTSUBJECTMARKS ";
			    qry=qry+" where INSTITUTECODE='"+mIC+"' and EXAMCODE='"+mEC+"' and ";
			    qry=qry+" EVENTSUBEVENT='"+rs2.getString("EventSubEvent")+"' and ";
			    qry=qry+" fstid='"+rs1.getString("fstid")+"' and STUDENTID='"+rs1.getString("studentid")+"' ";
			    //out.print(qry);
			    rs3=db.getRowset(qry);
      	          if(rs3.next())
			    {
				if(rs3.getString("MARKSAWARDED1").equals("-1"))
				{
					%>
					<td align=center>&nbsp;</td>
					<%
				}
				else
				{
					%>
					<td align=center><%=rs3.getString("MARKSAWARDED1")%></td>
					<%
				}
			    }
			    else
			    {
				%>
				<td align=center>&nbsp;</td>
				<%
			    }
			}
		    %>
		    </tr>
		    <input type=hidden name='<%=mName1%>' id='<%=mName1%>' value='<%=rs1.getString("semester")%>'>
		    <input type=hidden name='<%=mName2%>' id='<%=mName2%>' value='<%=rs1.getString("studentid")%>'>	
		    <input type=hidden name='<%=mName5%>' id='<%=mName5%>' value='<%=rs1.getString("fstid")%>'>
		    <%
		}
		%>
		</tbody>
		</table>
		<%
	}
	catch(Exception e)
	{
		//out.print("error");
	}
	session.setAttribute("Click",mSelf);
	%>
	<table align=center>
	<tr><td colspan=8 align=center>
	<%
	if(ctr>0)
	{
		%>
		<INPUT Type="submit"  tabindex="<%=tabctrtxt%>" Value="Save Marks"></td></tr>
		<%
	}
	else
	{
		out.print("<img src='../../Images/Error1.jpg'><b><font size=3 face='Arial' color='Red'> One of the following possible errors occured :<br><br><font size=2 face='Verdana' color='Red'><li>Either you are not authorized to proceed or project marks finalization is pending to lock/publish...</font></font> <br>");
	}
	%>
	</td></tr>
	<table>	
	<input type=hidden name='institute' id='institute' value="<%=mIC%>">
	<input type=hidden name='Exam' id='Exam' value="<%=mEC%>">
	<input type=hidden name='EventSubevent' id='EventSubevent' value="<%=mEvent%>">
	<input type=hidden name='TotalCount' id='TotalCount' value="<%=ctr%>">
     	<input type=Hidden name='MaxMarks' id='MaxMarks' value="<%=mMaxmarks%>">
	<input type=hidden name='subjectcode' id='subjectcode' value="<%=mSC%>">
	<input type=hidden name='Marksorpercentage' id='Marksorpercentage' value="<%=mMOP%>">
	<input type=hidden name='Status' id='Status' value="<%=mStatus%>">
	</form>
	<%
	}
	else
      {
      	out.print(" &nbsp;&nbsp;&nbsp <img src='../../Images/Error1.jpg'><b><font size=3 face='Arial' color='Red'> Please select an Exam Code and Event-Subevent ! </font> <br>");
	}
	}
	else
	{
		out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Mandatory items(Event,Subject,Exam.,etc.) must be entered. </font> <br>");

	}
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



}
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
}
catch(Exception e)
{
// out.print("aaaaaaaaaaaaa");
}
%>