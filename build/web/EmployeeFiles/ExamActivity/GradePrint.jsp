<%--
    Document   : GradeCalculationsupple
    Created on : 23 Dec, 2017, 2:54:03 PM
    Author     : VIVEK.SONI
    Modification Weightage Hard Coded to 100
--%>
<!--Date 13.01.2018  -->

<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String qry="";
ResultSet rs=null;
String qrys="";
ResultSet rss=null;
ResultSet rss1=null;
String mInst="", mComp=""; 
int mSno1=0;
String mNames="";
DBHandler db=new DBHandler();
String mDefault="";
int ctr=0;
String mHead="";
String mysubjcode="",mETOD="",mSem1="",mExamid="";
session.setAttribute("GRADEMASTERSET",null);
session.setAttribute("GRADEINITIALCOUNT",null);
session.setAttribute("GRADECHECKED",null);
session.setAttribute("GRADEUNCHECKED",null);
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT";
	qry="Select Distinct NVL(INSTITUTECODE,' ')IC from v#SRSEVENTS WHERE nvl(deactive,'N')='N' ";
	rs=db.getRowset(qry);
	while(rs.next())
	{
		mInst=rs.getString("IC");
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
    	    DOCUMENT.WRITE('THE VALUE IS = ' +x);
    	    document.frm.submit();
	}
//-->
</script>
<script language=javascript>
function checkradio()
{
	var val;
	val=document.frm1.jss.value;
	var mNames;
	var val1=parseInt(val);
	var i=1;
	
	while(i<=val1)
	{
		mNames="RADIO"+i;

		if(document.frm1[mNames][0].checked==false)
		{
			alert('Please select the Yes option to Proceed');
			return false;
		}
		else
		{
		
		}
		i++;
	}
	var ret=checkBox();
	
	return ret;
}

function checkBox()
{
	var val;
	val=document.frm1.checkctr.value;
	var mNames;
	var val1=parseInt(val);
	var i=1;
	while(i<=val1)
	{
		mNames="FSTID"+i;
		if(document.frm1[mNames].checked==true)
		{
			return true;
		}
		
		i++;
	}
	alert('Please select the atleast one checkbox');

	return false;
}
</script>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
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
String mEC="",mSC="";
String mName1="";

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

String mLoginComp="";


if (session.getAttribute("LoginComp")==null)
{
	mLoginComp="";
}
else
{
	mLoginComp=session.getAttribute("LoginComp").toString().trim();
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
	%>
	<form name="frm"  method="post"  >
	<input id="xx" name="xx" type=hidden>
	<table ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana"><b>View Saved/Freezed Grades</b></TD>
	</font></td></tr>
	</TABLE>

<table cellpadding=3 cellspacing=0  align=center rules=groups border=1>
<!--Institute-->
<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>

<tr><td colspan=3 align=center><b>CoOrdinator Name/Member name : </b><font color=dark brownt><b><%=mMemberName%>&nbsp;(<%=mDMemberCode%>)</font></b></td></tr>
<tr>
<td align=center>
	<b>ExamCode</b>
	 <select name=ExamCode tabindex="0" id="ExamCode" style="WIDTH: 130px" > 
	<%
//***********************01/02/2010 qry=LockExam='N'**********************

//qry="select nvl(GRADEENTRYEXAMID,' ')  EXAMCODE from CompanyInstituteTagging Where InstituteCode='"+mInst+"' And CompanyCode='"+mLoginComp+"'";
qry="SELECT  distinct NVL(EXAMCODE,' ')EXAMCODE FROM EXAMMASTER Where InstituteCode='"+mInst+"' AND NVL(LOCKEXAM,'N')='N'	and examcode in(select examcode from gradecalculation Where InstituteCode='"+mInst+"' ) ORDER BY 1 DESC";
		//out.println(qry);
		rs=db.getRowset(qry);
		
		if (request.getParameter("xx")==null) 
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
</select> &nbsp;&nbsp;<INPUT Type="submit" Value="&nbsp; OK &nbsp;">
</td>
</tr>
</table>
<form>

<%
	if(request.getParameter("xx")!=null)
	{
	   if(request.getParameter("ExamCode")!=null && !request.getParameter("ExamCode").equals("NONE"))
	   {
		mExamid=request.getParameter("ExamCode").toString().trim();
		mDefault=mExamid;
		%>
	<form name="frm"  method="post" >
			<input id="xx" name="xx" type=hidden>
		<input id="x" name="x" type=hidden>
				<input type=hidden value=<%=mInst%>id="InstCode" name="InstCode">
		<input type=hidden value=<%=mExamid%> id="ExamCode" name="ExamCode">
<table cellpadding=3 cellspacing=0  align=center rules=groups border=1>
<tr><br><br>
<td align=center>
<b>Subject</b>

<%
/*qry="select distinct A.subjectID SUBJECTID,B.subject||'('|| B.SUBJECTCODE ||')' SUBJECT from ( select distinct subjectID,fstid from ";
qry=qry+" facultysubjecttagging aa where institutecode='"+mInst+"' and examcode='"+mDefault+"' ";
qry=qry+" and employeeid='"+mChkMemID+"' and (LTP='L' or ( LTP='P' and exists (select 1 from programsubjecttagging where examcode='"+mDefault+"' and institutecode='"+mInst+"' and subjectid=aa.subjectid and L=0 and p>0 )) OR (LTP='E' and PROJECTSUBJECT='Y' and exists (select 1 from programsubjecttagging where examcode='"+mDefault+"' and institutecode='"+mInst+"' and subjectid=aa.subjectid and L=0 and p>0 )))";//(LTP='L' OR PROJECTSUBJECT='Y')";
qry=qry+" union ";
qry=qry+" select distinct subjectID,fstid from V#EX#SUBJECTGRADECOORDINATOR where institutecode='"+mInst+"' and ";
qry=qry+" examcode='"+mDefault+"' and COORDINATORID='"+mChkMemID+"' ";
qry=qry+" MINUS ";
qry=qry+" select distinct subjectID,fstid from V#EX#SUBJECTGRADECOORDINATOR  ";
qry=qry+" where  employeeid='"+mChkMemID+"' and COORDINATORID<>'"+mChkMemID+"' ) A,subjectmaster B where A.subjectID=B.subjectID ";
//out.println(qry);
*/

qry="select distinct A.subjectID SUBJECTID,B.subject||'('|| B.SUBJECTCODE ||')' SUBJECT from ( select distinct subjectID,fstid from ";
qry=qry+" facultysubjecttagging aa where institutecode='"+mInst+"' and examcode='"+mDefault+"'  AND NVL(DEACTIVE,'N')='N' ";
qry=qry+" and employeeid='"+mChkMemID+"' and (LTP='L' or ( LTP='P' and exists (select 1 from programsubjecttagging where examcode='"+mDefault+"' and institutecode='"+mInst+"' and subjectid=aa.subjectid and L=0 and p>0 )) OR (LTP='E' and PROJECTSUBJECT='Y' and exists (select 1 from programsubjecttagging where examcode='"+mDefault+"' and institutecode='"+mInst+"' and subjectid=aa.subjectid and L=0 and p>0 )))";
qry=qry+" union ";
qry=qry+" select distinct subjectID,fstid from V#EX#SUBJECTGRADECOORDINATOR where institutecode='"+mInst+"' and ";
qry=qry+" examcode='"+mDefault+"' and COORDINATORID='"+mChkMemID+"' ";
qry=qry+" union ";
qry=qry+" select distinct subjectID,fstid from V#EXAMEVENTSUBJECTTAGGING WHERE institutecode='"+mInst+"' and ";
qry=qry+" examcode='"+mDefault+"' and CORDFACULTYID='"+mChkMemID+"' AND NVL(DEACTIVE,'N')='N'";
qry=qry+" MINUS ";
qry=qry+" (select distinct subjectID,fstid from V#EX#SUBJECTGRADECOORDINATOR  ";
qry=qry+" where  employeeid='"+mChkMemID+"' and COORDINATORID<>'"+mChkMemID+"' ";
qry=qry+" union ";
qry=qry+" select distinct subjectID,fstid from V#EXAMEVENTSUBJECTTAGGING WHERE institutecode='"+mInst+"' and ";
qry=qry+" examcode='"+mDefault+"' and CORDFACULTYID<>'"+mChkMemID+"' AND NVL(DEACTIVE,'N')='N') ) A,subjectmaster B where A.subjectID=B.subjectID AND institutecode='"+mInst+"' ";
//out.println(qry);
rs=db.getRowset(qry);
%><select name=Subject tabindex="1" id="Subject" > <%

	if (request.getParameter("x")==null) 
	{
		while(rs.next())
		{  
		    mSCode=rs.getString("SUBJECTID");
			//if(mSCode.equals(""))
		   %>
		   <OPTION Value ="<%=mSCode%>"><%=rs.getString("SUBJECT")%></option>
		   <%			
		}
	} // closing of if 
else
{
	while(rs.next())
	{
		mSCode=rs.getString("SUBJECTID");
		if(mSCode.equals(request.getParameter("Subject").toString().trim()))
		{
%>
			<OPTION selected Value ="<%=mSCode%>"><%=rs.getString("SUBJECT")%></option>
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
 <input type=HIDDEN name=ETOD id=ETOD VALUE="N" checked=true ><!--<b>Normal</b>-->
 <input type=HIDDEN name=ETOD id=ETOD VALUE="E" ><!--<b>EtoD</b>-->
</td>
</tr>
<tr>

	<td colspan=2 align=center>
	<input type=submit value="Continue" >
</td>
</tr>
</TABLE>
</FORM>
<%
	if(request.getParameter("x")!=null)
		{
			mEC=request.getParameter("ExamCode").toString().trim();
			mSC=request.getParameter("Subject").toString().trim();
			mETOD=request.getParameter("ETOD").toString().trim();


 


qry="select 'y' from v#exameventsubjecttagging a where  a.examcode='"+mEC+"' and ";
qry=qry+" a.subjectid='"+mSC+"' and a.institutecode='"+mInst+"' and a.CORDFACULTYID='"+mChkMemID+"' and exists ";
qry=qry+" (select 'y' from v#studenteventsubjectmarks b where b.examcode='"+mEC+"' and ";
qry=qry+" b.subjectid='"+mSC+"' and nvl(b.locked,'N')='N' and  a.examcode=b.examcode and ";
qry=qry+" a.subjectid=b.subjectid and a.fstid=b.fstid and a.studentid=b.studentid AND b.institutecode='"+mInst+"' and b.institutecode=a.institutecode )";
//out.print(qry);
rs=db.getRowset(qry);
if(!rs.next())
{
qry="Select nvl(A.EVENTSUBEVENT,' ') EVENTSUBEVENT,nvl(A.WEIGHTAGE,0) WEIGHTAGE  from V#EXAMEVENTSUBJECTTAGGING A ";
qry=qry+" WHERE A.INSTITUTECODE='"+mInst+"' AND A.EXAMCODE='"+mEC+"' AND A.SUBJECTID='"+mSC+"' ";
qry=qry+" and A.CORDFACULTYID='"+mChkMemID+"' Group By A.EVENTSUBEVENT, A.WEIGHTAGE ORDER BY EVENTSUBEVENT,nvl(A.WEIGHTAGE,0)";
//out.print(qry);
rs=db.getRowset(qry);

double  mAllowedWeightage=0;
double  MaxAW=100;

while(rs.next())
{
  //mAllowedWeightage=mAllowedWeightage+rs.getDouble("WEIGHTAGE");
    mAllowedWeightage=100;
}
mAllowedWeightage=MaxAW-mAllowedWeightage;
//out.println(mAllowedWeightage);
if(mAllowedWeightage==0.0)
{
%>
<form name="frm1"  method="post" action="GradeCalculationAction.jsp" >
<input id="y" name="y" type=hidden>
<table>

<TABLE align=center rules=group border=1 cellspacing=0 >
<%
int count=0;
//qry="select subjectid,BREAK#SLNO,TOTALSTUDENT,decode(NVL(FINALIZED,'N'),'Y','<font color=green>Saved</font>','N','<font color=red>Draft Saved</font>',NVL(FINALIZED,'N')) status1,decode(NVL(STATUS,'D'),'A','<font color=green>Approved</font>','<font color=red>Pending</font>') status2 from GRADECALCULATION where examcode='"+mEC+"' and institutecode='"+mInst+"' and GRADEFLAG='N' and subjectid='"+mSC+"'";
qry="select subjectid,BREAK#SLNO,TOTALSTUDENT,decode(NVL(FINALIZED,'N'),'Y','<font color=green>Saved</font>','N','<font color=red>Draft Saved</font>',NVL(FINALIZED,'N')) status1,decode(NVL(STATUS,'D'),'A','<font color=green>Approved</font>','<font color=red>Pending</font>') status2 , NVL(FINALIZED,'N') status from GRADECALCULATION where examcode='"+mEC+"' and institutecode='"+mInst+"' and GRADEFLAG='N' and subjectid='"+mSC+"'";
//----------------------------added by satendra------------------------------------------------------------------//
qry="select subjectid, break#slno, totalstudent,decode(status1,'Draft Saved','Not Saved',locked) status1,status2, status ";
qry=qry+"from(SELECT subjectid, break#slno, totalstudent,DECODE (NVL (finalized, 'N'),'Y', 'Saved', 'N', 'Draft Saved', NVL (finalized, 'N')    ) status1, ";
qry=qry+"DECODE (NVL (status, 'D'), 'A', 'Approved', 'Pending') status2,NVL (finalized, 'N') status,( ";
qry=qry+"SELECT distinct decode(NVL(LOCKED, 'N'),'Y','Freezed Grade','N','Draft Saved') FROM exameventsubjecttagging ";
qry=qry+" WHERE fstid IN (SELECT DISTINCT fstid FROM (SELECT DISTINCT fstid FROM facultysubjecttagging aa WHERE institutecode='"+mInst+"' ";
qry=qry+" AND examcode='"+mEC+"'  AND employeeid = '"+mChkMemID+"' AND (   ltp = 'L'   OR (    ltp = 'P' ";
 qry=qry+"AND EXISTS (  SELECT 1  FROM programsubjecttagging    WHERE examcode='"+mEC+"'  AND institutecode='"+mInst+"' ";
 qry=qry+"AND subjectid = aa.subjectid   AND l = 0     AND p > 0)  )  OR (    ltp = 'P'   AND projectsubject = 'Y'   AND EXISTS ( ";
qry=qry+" SELECT 1 FROM programsubjecttagging    WHERE examcode='"+mEC+"' AND institutecode='"+mInst+"'  AND subjectid =  aa.subjectid   AND l = 0     AND p > 0) )) ";
qry=qry+" AND subjectid='"+mSC+"' UNION  SELECT DISTINCT fstid  FROM v#ex#subjectgradecoordinator  WHERE institutecode='"+mInst+"' ";
qry=qry+" AND examcode='"+mEC+"'   AND coordinatorid = '"+mChkMemID+"' AND subjectid='"+mSC+"'  UNION   SELECT DISTINCT fstid FROM v#exameventsubjecttagging ";
qry=qry+" WHERE institutecode='"+mInst+"'       AND examcode='"+mEC+"' AND cordfacultyid = '"+mChkMemID+"'     AND subjectid='"+mSC+"'   AND NVL (deactive, 'N') = 'N' ";
qry=qry+" MINUS  SELECT DISTINCT fstid FROM v#ex#subjectgradecoordinator WHERE examcode='"+mEC+"' AND employeeid ='"+mChkMemID+"'  AND coordinatorid <> '"+mChkMemID+"' ";
qry=qry+" AND subjectid='"+mSC+"'))   ) locked FROM gradecalculation WHERE examcode='"+mEC+"'   AND institutecode='"+mInst+"'  AND gradeflag = 'N' AND subjectid='"+mSC+"' ) ";

//---------------------------added by satendra-------------------------------------------------------------------//


//out.println(qry);
ResultSet rssss=db.getRowset(qry);
int ok=0;
while(rssss.next())
{
if (count==0)
{
%>
<TR bgcolor=orange>
<TD><font color="white"><B>Sno.</B></font></TD>
<TD><font color="white"><b>Batch</b></font></TD>
<TD><font color="white"><b>No.of Student</b></font></TD>
<TD><font color="white"><b>Subject</b></font></TD>
<TD><font color="white"><b>Entry Status</b></font></TD>
<TD><font color="white"><b>Approval Status</b></font></TD>
</TR>
<%
}
ok=1;
String  mNam="",mSc="";
String qrysub="select subject,SUBJECTCODE from subjectmaster where subjectID='"+rssss.getString("subjectid")+"' and institutecode='"+mInst+"'  and nvl(deactive,'N')='N' ";

	ResultSet rssub=db.getRowset(qrysub);
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
 

%><TR bgcolor=white>
<TD><B><%=++count%>.</B></TD>
<TD></b><A target=_child HREF="GradePrintAction.jsp?ExamCode=<%=mEC%>&ETOD=<%=mETOD%>&Subject=<%=mSC%>&bno=<%=rssss.getString("BREAK#SLNO")%>&status=<%=rssss.getString("status")%>">Batch - <%=count%> </A></b></TD>
<TD></b><%=rssss.getString("totalstudent")%></b></TD>
<TD></b><%=mNam%>(<%=mSc%>)</b></TD>
<TD></b><%=rssss.getString("status1")%></b></TD>
<TD></b><%=rssss.getString("status2")%></b></TD>
</TR><%


}



%>






</table>
<%
if (ok==0)
{
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Grade Entry is has not been done!</font> <br>");
}



}
else
{
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Events of 100 weightage has not been declared or Marks Entry is incomelete!</font> <br>");
}



} // closing of !rs.next
else
{
out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Events of 100 weightage has not been declared or Marks Entry is incomelete! </font> <br>");
}

		}// closing of request.getParameter("x)!=null
//-----------------------------
//---Enable Security Page Level  
//-----------------------------

}
	   else
	   {
		out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Please Select an Exam Code !</font> <br>");
	   }
	}
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
//out.print(e+qry);
}
%>