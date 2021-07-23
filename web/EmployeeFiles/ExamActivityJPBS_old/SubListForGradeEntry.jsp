<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String qry="";
ResultSet rs=null,rs1=null;
String mInst="", mComp="";
DBHandler db=new DBHandler();
int sno=0;
String mHead="",mExamcode="";
String mysubjcode="",mETOD="",mSem1="";

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
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
    	    document.frm.submit();
	}
//-->
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
String mName1="",mDept="",mRightsID="",mSrcType="";

if (session.getAttribute("MemberID")==null)
{
	mMemberID="";
}
else
{
	mMemberID=session.getAttribute("MemberID").toString().trim();
}
if (session.getAttribute("DepartmentCode")==null)
{
	mDept="";
}
else
{
	mDept=session.getAttribute("DepartmentCode").toString().trim();
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
if (request.getParameter("SrcType")==null)
{
	mSrcType="";
}
else
{
	mSrcType=request.getParameter("SrcType").toString().trim();
}
if(mSrcType.equals("A"))
	mRightsID="226";
else
mRightsID="227";

if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
	{
   mDMemberCode=enc.decode(mMemberCode);
   mDMemberType=enc.decode(mMemberType);
   String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
   String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
   String mIPAddress =session.getAttribute("IPADD").toString().trim();
   String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
   //out.print("mRole :"+mRole);
   ResultSet RsChk=null;
   //-----------------------------
   //-- Enable Security Page Level  
   //-----------------------------
   qry="Select WEBKIOSK.ShowLink('"+mRightsID+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
    RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
	%>
	<form name="frm"  method="post"  >
	<input id="x" name="x" type=hidden>
	<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><U>View of Subjects For Grade Entry</U></b></TD>
	</font></td></tr>
	</TABLE><BR>
   <table cellpadding=1 cellspacing=0 width="50%" align=center rules=groups border=3>
   <!--Institute-->
   <INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
   <tr>
   <td>
   <b>ExamCode</b>
   <select name=ExamCode tabindex="0" id="ExamCode" style="WIDTH: 130px" > 
   <%
   qry="select nvl(GRADEENTRYEXAMID,' ')  EXAMCODE from CompanyInstituteTagging Where InstituteCode='"+mInst+"' And CompanyCode='"+mLoginComp+"'";
		rs=db.getRowset(qry);
		if(request.getParameter("x")==null) 
		{
			while(rs.next())
			{  
			mECode=rs.getString("EXAMCODE");
			if(mecode.equals(""))
				mecode=rs.getString("EXAMCODE");
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
<td align="right"><input type=submit value="Continue" >
</td>
</tr>
</TABLE>
</FORM>
<%
	if(request.getParameter("ExamCode")==null)
		mExamcode=mecode;
	else
		mExamcode=request.getParameter("ExamCode").toString().trim();

%>
<table bgcolor=#fce9c5 class="sort-table" id="table-2" width='100%' align=center topmargin=0 cellspacing=0 cellpadding=0 border=1 >
<thead>
<tr bgcolor="#ff8c00">
<td ><b><font color=white>SNo.</font></b></td>
<td ><b><font color=white> Subject</font></b></td>
<td ><b><font color=white>Co-Ordinator</font></b></td>
<td ><b><font color=white> HOD </font></b></td>
<td ><b><font color=white> Status </font></b></td>
</tr>
</thead>
<tbody>
<%
qry="SELECT DISTINCT SUBJECTID,CORDFACULTYID,DEPARTMENTCODE,Subject,Faculty,Status FROM (SELECT DISTINCT A.FSTID,A.SUBJECTID, NVL(trim(A.CORDFACULTYID),NVL(trim(A.EMPLOYEEID),' '))CORDFACULTYID, decode(D.FINALIZED,'Y','Grade Entry Completed','Grade Entry Not Completed')Status,C.DEPARTMENTCODE DEPARTMENTCODE,NVL(B.subject,' ')||' ('|| NVL(B.subjectcode,' ')||')' Subject,NVL(C.EmployeeName,' ')||' ('|| NVL(C.EmployeeCode,' ')||')' Faculty FROM V#EXAMEVENTSUBJECTTAGGING A, SUBJECTMASTER B, EMPLOYEEMASTER C,GRADECALCULATION D WHERE A.INSTITUTECODE='"+mInst+"' AND A.EXAMCODE='"+mExamcode+"' AND NVL (a.deactive, 'N') = 'N' AND NVL(B.DEACTIVE,'N')='N' AND c.departmentcode =decode('"+mSrcType+"','A',c.departmentcode,'"+mDept+"') AND NVL(C.DEACTIVE,'N')='N' AND A.INSTITUTECODE=B.INSTITUTECODE AND A.SUBJECTID=B.SUBJECTID AND NVL(trim(A.CORDFACULTYID),NVL(trim(A.EMPLOYEEID),' '))=C.EMPLOYEEID AND A.INSTITUTECODE=D.INSTITUTECODE AND A.SUBJECTID=D.SUBJECTID AND A.EXAMCODE=D.EXAMCODE  AND A.FSTID NOT IN (SELECT FSTID FROM V#EXAMEVENTSUBJECTTAGGING WHERE NVL(LOCKED,'N')<>'Y') AND A.FSTID NOT IN (SELECT FSTID FROM STUDENTEVENTSUBJECTMARKS WHERE NVL(LOCKED,'N')<>'Y') AND A.FSTID IN(SELECT FSTID FROM (SELECT FSTID, SUM(Weightage) Weightage FROM (SELECT DISTINCT FSTID, NVL(EventSubEvent, ' ') EventSubEvent, NVL(Weightage,'0') Weightage FROM V#EXAMEVENTSUBJECTTAGGING WHERE InstituteCode='"+mInst+"' AND EXAMCODE='"+mExamcode+"' GROUP BY FSTID,EventSubEvent, Weightage)GROUP BY FSTID)WHERE Weightage=100))ORDER BY SUBJECT";
rs=db.getRowset(qry);
//out.print(qry);
while(rs.next())
		{
		sno++;
		%>
		<tr>
		<td><%=sno%>.</td>
		<td nowrap><%=rs.getString("Subject")%></td>
		<td nowrap><%=rs.getString("Faculty")%></td>
       <%
		qry="SELECT NVL(A.EMPLOYEENAME,' ')EMPLOYEENAME,NVL(A.EMPLOYEECODE,' ')EMPLOYEECODE FROM EMPLOYEEMASTER A, HODLIST B WHERE B.INSTITUTECODE='"+mInst+"' AND B.DEPARTMENTCODE='"+rs.getString("DEPARTMENTCODE")+"' AND NVL(B.DEACTIVE,'N')='N' AND NVL(A.DEACTIVE,'N')='N' AND A.EMPLOYEEID=B.EMPLOYEEID AND A.DEPARTMENTCODE=B.DEPARTMENTCODE";
		//out.print(qry);
		rs1=db.getRowset(qry);
		if(rs1.next())
		{
		  %>
		  <td nowrap><%=rs1.getString(1)%>(<%=rs1.getString(2)%>)</td>
		  <%
		}
		  else
			{
            %><td>&nbsp;</td><%
			}
         
			  if(rs.getString("Status").equals("Grade Entry Completed"))
				{
			 %><td nowrap><font color="green" face="Arial" ><b><%=rs.getString("Status")%></b></font></td><%
				}
			 else if(rs.getString("Status").equals("Grade Entry Not Completed"))
				{
               %><td nowrap><font color="red" face="Arial"><b><%=rs.getString("Status")%></b></font></td><%
				}
			
		%>
        </tr>
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