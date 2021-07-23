<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String qry="";
ResultSet rs=null;
String qrys="",qry2="",qry3="";
ResultSet rss=null,rs2=null,rs3=null;
int mSno1=0;
String mNames="";
DBHandler db=new DBHandler();
String mInst="",mDefault="";
String mHead="";
int ctr=0;
String mName1="",mName2="",mName3="",mName4="",mName5="";
String mlistorder="";
String mList="",mOrder="";
double 	mCutmark=0;
double mCutmark1=0;

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";

	qry="Select Distinct NVL(INSTITUTECODE,' ')IC from INSTITUTEMASTER WHERE nvl(deactive,'N')='N' ";
	rs=db.getRowset(qry);
	while(rs.next())
	{
		mInst=rs.getString("IC");
	}

	qry="select GRADEENTRYEXAMID  from DEFAULTVALUES ";
	rs=db.getRowset(qry);
	if(rs.next())
	{
		mDefault=rs.getString("GRADEENTRYEXAMID");
	}

%>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) 
  top.document.title = document.title;
//-->
</script>
<script language=javascript>
if(window.history.forward(1) != null)
window.history.forward(1);
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
<SCRIPT LANGUAGE="JavaScript">
<!--
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
<SCRIPT LANGUAGE="JavaScript">
<!--
	
	 function Marks_Check(objtxt)
 {
	
var mMax=100;
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
				objchk.checked=false;
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
//-->
</SCRIPT>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 onkeydown="if(event.keyCode==13){event.keyCode=9;return event.keyCode}">
<%
try
{
OLTEncryption enc=new OLTEncryption();
int mFlag=0;
String  mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="";
String mECode="",mecode="";
int mSno=0;
String mName="";
String mSCode="",mscode="";
String mSC="",mEC="";
double mcut=0;
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

%>
<form name="frm"  method="post" >
<input id="x" name="x" type=hidden>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>MassCuts Entry</b></TD>
</font></td></tr>
</TABLE>
<table cellpadding=1 cellspacing=0 width="95%" align=center rules=groups border=3>

<!--Institute-->
<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>

<tr>
<td>
	<b>ExamCode</b>
	 <select name=ExamCode tabindex="0" id="ExamCode" style="WIDTH: 140px" > 
	<%
		qry="select nvl(GRADEENTRYEXAMID,' ') EXAMCODE from defaultvalues ";

		rs=db.getRowset(qry);
		if (request.getParameter("x")==null) 
		{
			while(rs.next())
			{  
			mECode=rs.getString("EXAMCODE");
			if(mecode.equals(""))
			%>
			<OPTION Value =<%=mECode%>><%=rs.getString("EXAMCODE")%></option>
			<%			
		}
	} // closing of if 
else
{
	while(rs.next())
	{
	mECode=rs.getString("EXAMCODE");

	if(mECode.equals(request.getParameter("ExamCode").toString().trim()))
	{
%>
			<OPTION selected Value =<%=mECode%>><%=rs.getString("EXAMCODE")%></option>
	<%
	}
	else
	{
%>
		<OPTION Value =<%=mECode%>><%=rs.getString("EXAMCODE")%></option>
<%
	}
  } //closing of while
} // closing of else

	%>
	</select>
</td>
<td>
	<b>Subject</b>
	 <select name=Subject tabindex="0" id="Subject" style="WIDTH: 300px" > 
	<%
	qry="select distinct A.subjectID SUBJECTID,B.subject||'('|| B.SUBJECTCODE ||')' SUBJECT from ( select subjectID,fstid from ";
	qry=qry+" Facultysubjecttagging where institutecode='"+mInst+"' and examcode='"+mDefault+"' ";
	qry=qry+" And EmployeeID='"+mChkMemID+"' and (LTP='L' OR PROJECTSUBJECT='Y') ";
	qry=qry+" union ";
	qry=qry+" select distinct subjectID,fstid from V#EX#SUBJECTGRADECOORDINATOR where institutecode='"+mInst+"' and ";
	qry=qry+" examcode='"+mDefault+"' and COORDINATORID='"+mChkMemID+"' ";
	qry=qry+" MINUS ";
	qry=qry+" select distinct subjectID,fstid from V#EX#SUBJECTGRADECOORDINATOR  ";
	qry=qry+" where  employeeid='"+mChkMemID+"' and COORDINATORID<>'"+mChkMemID+"' ) A,subjectmaster B where A.subjectID=B.subjectID ";

	rs=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		while(rs.next())
		{  
			mSCode=rs.getString("SUBJECTID");
			if(mscode.equals(""))
	%>
			<OPTION Value =<%=mSCode%>><%=rs.getString("SUBJECT")%></option>
	<%			
		}
	} // closing of if 
else
{
	while(rs.next())
	{
	// mSCode=rs.getString("SUBJECTID")+"***"+rs.getString("FSTID");
	mSCode=rs.getString("SUBJECTID");
	if(mSCode.equals(request.getParameter("Subject").toString().trim()))
	{
%>
			<OPTION selected Value =<%=mSCode%>><%=rs.getString("SUBJECT")%></option>
	<%
	}
	else
	{
%>
		<OPTION Value =<%=mSCode%>><%=rs.getString("SUBJECT")%></option>
<%
	}
  } //closing of while
} // closing of else
%>
</select>
</td>
</tr>
<tr>
<td colspan=2>
<FONT color=black><FONT face=Arial size=2><STRONG>List order in:</STRONG></FONT></FONT>
<select name=listorder  id="listorder" style="WIDTH: 120px">
<% 	if(request.getParameter("listorder")==null)
   	{
 %>			
	<OPTION Value =Enrollmentno selected>Enrollment no.</option>
	<OPTION Value =Studentname>Student Name</option>
	<OPTION Value =Subsectioncode >Subsection/Group</option>
<%
  	}
  else
   {
	mlistorder=request.getParameter("listorder");
	if(mlistorder.equals("Enrollmentno"))
	{
%>
	<OPTION Value =Enrollmentno selected>Enrollment no.</option>
	<OPTION Value =Studentname >Student Name</option>
	<OPTION Value =Subsectioncode >Subsection/Group</option> 
<%
      }
	else if(mlistorder.equals("Studentname"))
	{
	%>
		<OPTION Value =Enrollmentno >Enrollment no.</option>
		<OPTION Value =Studentname selected>Student Name</option>
		<OPTION Value =Subsectioncode >Subsection/Group</option> 
	<%		
	}
	else if(mlistorder.equals("Subsectioncode"))
	{
	%>
		<OPTION Value =Enrollmentno >Enrollment no.</option>
		<OPTION Value =Studentname >Student Name</option>
		<OPTION Value =Subsectioncode selected >Subsection/Group</option> 
	<%		
	}

    }		
%>
</select>
&nbsp; &nbsp;
<select name=order  id="order" style="WIDTH: 95px">	

<% 	if(request.getParameter("order")==null)
   	{
 %>			
	<OPTION Value =Asc selected>Ascending</option>
	<OPTION Value =Desc>Descending</option>

<%
  	}
  else
   {
	mlistorder=request.getParameter("order");
	if(mlistorder.equals("Asc"))
	{
%>
	<OPTION Value =Asc selected>Ascending</option>
	<OPTION Value =Desc>Descending</option>

<%
      }
	else 
	{
	%>
		<OPTION Value =Asc >Ascending</option>
		<OPTION Value =Desc selected>Descending</option>

	<%		
	}
    }		
%>
</select>
&nbsp; &nbsp; &nbsp; &nbsp;
<FONT color=black><FONT face=Arial size=2><STRONG>Cut marks from whole class :</STRONG></FONT></FONT>
<%
if(request.getParameter("cutmark")==null || request.getParameter("cutmark").toString().equals(""))
{
%>
<input type=text name="cutmark" id="cutmark" maxlength=4 size=3 onkeypress="return isNumber(event)">
<%
}
else
{
mcut=Double.parseDouble(request.getParameter("cutmark").toString().trim());
%>
<input type=text name="cutmark" id="cutmark" value="<%=mcut%>" maxlength=4 size=3 onkeypress="return isNumber(event)">
<%
}
%>
&nbsp; &nbsp; &nbsp; &nbsp; 
<input type=submit value="Continue" onClick="return checkradio()">
</td>
</tr>
</table>
</form>
<%
if(request.getParameter("x")!=null)
   {
	if(request.getParameter("Subject")!=null)
	{

		mEC=request.getParameter("ExamCode").toString().trim();
		mSC=request.getParameter("Subject").toString().trim();
		mList=request.getParameter("listorder").toString().trim();
		mOrder=request.getParameter("order").toString().trim();
		if(request.getParameter("cutmark")==null || request.getParameter("cutmark").toString().equals(""))
			mCutmark=0;
		else
			mCutmark=Double.parseDouble(request.getParameter("cutmark").toString().trim());
%>
		<table cellspacing=0 cellpadding=0 width=98% border=1 align=center>
		<form name="frm1"  method="post" action="GradeMassCutsAction.jsp">
		<tr bgcolor="#c00000">
		<td><b><font color=white>SNo.</font></b></td>
		<td><b><font color=white>Enroll. No</font></b></td>
		<td><b><font color=white>Student name</font></b></td>
		<td align=center><b><font color=white>Marks</font></b></td>
		<td><b><font color=white>Course (Section-Branch)<font></b></td>
		<td><b><font color=white>Sem.<font></b></td>
		</tr>	
<%


qry2="select distinct a.institutecode,a.fstid,a.programcode,a.sectionbranch,a.subsectioncode,a.ExamCode,a.Semester,a.semestertype,a.subjectid,a.studentid studentid,";
qry2=qry2+" a.enrollmentno, ";
qry2=qry2+" a.studentname from V#STUDENTEVENTSUBJECTMARKS a, ";
qry2=qry2+" V#EXAMEVENTSUBJECTTAGGING b where  ";
qry2=qry2+" a.fstid in(  ";
qry2=qry2+" select distinct fstid from ( select distinct subjectid,fstid from ";
qry2=qry2+" facultysubjecttagging where institutecode='"+mInst+"' and examcode='"+mEC+"' ";
qry2=qry2+" and employeeid='"+mChkMemID+"' and (LTP='L' or PROJECTSUBJECT='Y')and nvl(DEACTIVE,'N')='N' and subjectid='"+mSC+"' ";
qry2=qry2+" union ";
qry2=qry2+" select distinct subjectid,fstid from V#EX#SUBJECTGRADECOORDINATOR where institutecode='"+mInst+"' and ";
qry2=qry2+" examcode='"+mEC+"' and COORDINATORID='"+mChkMemID+"' and subjectID='"+mSC+"' ";
qry2=qry2+" MINUS ";
qry2=qry2+" select distinct subjectID,fstid from V#EX#SUBJECTGRADECOORDINATOR  ";
qry2=qry2+" where  employeeid='"+mChkMemID+"' and COORDINATORID<>'"+mChkMemID+"' and subjectID='"+mSC+"' )) ";
qry2=qry2+" and a.examcode='"+mEC+"' and a.examcode=b.examcode and a.eventsubevent=b.eventsubevent and ";
qry2=qry2+" a.studentid=b.studentid ";
qry2=qry2+" and a.subjectID='"+mSC+"'  and nvl(a.DEACTIVE,'N')='N' and ";
qry2=qry2+" nvl(a.LOCKED,'N')='Y' and a.subjectID=b.subjectID and nvl(a.DEACTIVE,'N')='N' ";
qry2=qry2+" and a.fstid=b.fstid ";
qry2=qry2+" group by a.institutecode,a.fstid,a.programcode,a.sectionbranch,a.subsectioncode,a.ExamCode,a.Semester,a.semestertype,a.subjectID,a.studentid, ";
qry2=qry2+" a.enrollmentno,a.studentname  order by "+mList+ " "+mOrder+ " ,a.enrollmentno ";
//out.print(qry2);
rs2=db.getRowset(qry2);
while(rs2.next())
{
	ctr++;
	mName1="Semester"+String.valueOf(ctr).trim();  
	mName2="Studentid"+String.valueOf(ctr).trim();
	mName3="Marks"+String.valueOf(ctr).trim();
	mName5="Fstid"+String.valueOf(ctr).trim();
%>	
	<tr>
	<td><%=ctr%></td>
	<td><%=rs2.getString("enrollmentno")%></td>
	<td><%=GlobalFunctions.toTtitleCase(rs2.getString("studentname"))%></td>
	<%

	qry3="select nvl(MASSCUTS,0)MASSCUTS from EX#STUDENTMASSCUTS where fstid='"+rs2.getString("fstid")+"' and studentid='"+rs2.getString("studentid")+"' and nvl(DEACTIVE,'N')='N' ";
	rs3=db.getRowset(qry3);
	if(rs3.next())
	{
		mCutmark1=rs3.getDouble("MASSCUTS");
		mFlag=1;
%>
	<td align=center><input type=text name='<%=mName3%>' id='<%=mName3%>' value=<%=mCutmark1%> style="WIDTH: 40px; height: 20px;" maxlength=7  onkeypress="return isNumber(event)" onBlur="Marks_Check(<%=mName3%>);" onchange="Marks_Check(<%=mName3%>);"></td>
<%
	}
else
{
if(mCutmark==0.0 )
	{
	%>
	<td align=center><input type=text name='<%=mName3%>' id='<%=mName3%>' value="" style="WIDTH: 40px; height: 20px;" maxlength=7  onkeypress="return isNumber(event)" onBlur="Marks_Check(<%=mName3%>);" onchange="Marks_Check(<%=mName3%>);"></td>
	<%
	}
	else 
	{
	%>
	<td align=center><input type=text name='<%=mName3%>' id='<%=mName3%>' value=<%=mCutmark%> style="WIDTH: 40px; height: 20px;" maxlength=7  onkeypress="return isNumber(event)" onBlur="Marks_Check(<%=mName3%>);" onchange="Marks_Check(<%=mName3%>);"></td>
	<%
	}
}
	
	
	%>
	<td><%=rs2.getString("programcode")%>&nbsp;(<%=rs2.getString("SECTIONBRANCH")%>)</td>
	<td><%=rs2.getString("semester")%></td>
	</tr>
	<input type=hidden name='<%=mName1%>' id='<%=mName1%>' value='<%=rs2.getString("semester")%>'>
	<input type=hidden name='<%=mName2%>' id='<%=mName2%>' value='<%=rs2.getString("studentid")%>'>	
	<input type=hidden name='<%=mName5%>' id='<%=mName5%>' value='<%=rs2.getString("fstid")%>'>
<%
		
}

%>
		<tr><td colspan=8 align=center>
		<INPUT Type="submit"   Value="Save Marks"></td></tr>
		<input type=hidden name='institute' id='institute' value=<%=mInst%>>
		<input type=hidden name='Exam' id='Exam' value=<%=mEC%>>
		<input type=hidden name='TotalCount' id='TotalCount' value=<%=ctr%>>
		<input type=hidden name='subjectcode' id='subjectcode' value=<%=mSC%>>
		</form><table>	
	<%

			}
		} // closing of request.getParameter("x")!=null

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
// 	out.print(e);
}
%>