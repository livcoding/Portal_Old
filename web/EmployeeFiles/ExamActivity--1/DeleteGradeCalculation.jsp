<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String qry="";
ResultSet rs=null;
int mSno1=0;
DBHandler db=new DBHandler();
String mInst="";
int ctr=0;
String mHead="",mName1="";
String mExamCode="",mSubjectid="",mBR="";
String qry1="",FS="";
ResultSet rs1=null;
String mysubjcode="";
String qryss="";
ResultSet rss=null;



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
String mSCode="",mscode="";



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
	qry="Select Distinct NVL(INSTITUTECODE,' ')IC from INSTITUTEMASTER WHERE nvl(deactive,'N')='N' ";
	rs=db.getRowset(qry);
	while(rs.next())
	{
		mInst=rs.getString("IC");
		
	}


%>
<input id="x" name="x" type=hidden>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Delete Calculated Grade</b></TD>
</font></td></tr>
</TABLE>
<%

		
	if(request.getParameter("ExamCode")==null)
		mExamCode="";
	else
		mExamCode=request.getParameter("ExamCode").toString().trim();

	if(request.getParameter("Subject")==null)
		mSubjectid="";
	else
		mSubjectid=request.getParameter("Subject").toString().trim();
	
	qry=" select 'y', BREAK#SLNO from gradecalculation where examcode='"+mExamCode+"' and subjectid='"+mSubjectid+"' ";
	qry=qry+" and status='D' and entryby='"+mChkMemID+"'";
//out.print(qry);
	rs=db.getRowset(qry);
	while(rs.next())
	{
			if(mBR.equals(""))
			{
				mBR="'"+rs.getString("BREAK#SLNO")+"'";
			}
			else
			{
				mBR=mBR+",'"+rs.getString("BREAK#SLNO")+"'";
			}
	
	} // closing of while 

	qry1="select fstid from EX#GRADESUBJECTBREAKUP where BREAK#SLNO in ("+mBR+") and employeeid='"+mChkMemID+"' ";
	rs1=db.getRowset(qry1);
	while(rs1.next())
	{
		if(FS.equals(""))
		{
			FS="'"+rs1.getString("fstid")+"'";
		}
		else
		{
			FS=FS+",'"+rs1.getString("fstid")+"'";
		}

	}

%>
<form name="frm1"  method="post" action="DeleteGradeCalculationAction.jsp" >
<input id="y" name="y" type=hidden>

<TABLE align=center rules=group border=1 cellspacing=0 width=98%>
<TR>
<TD>&nbsp;</TD>
<TD><b>Subject Code</b></TD>
<TD><b>Programe Code</b></TD>
<TD><b>Section Branch</b></TD>
<TD><b>SubSection Code</b></TD>
<TD><b>Semester<b></TD>
</TR>
<%
qry="select distinct fstid,programcode,SECTIONBRANCH,SUBSECTIONCODE,SEMESTER from ";
qry=qry+" facultysubjecttagging where institutecode='"+mInst+"' and ExamCode='"+mExamCode+"' ";
qry=qry+" and fstid in("+FS+") and subjectid='"+mSubjectid+"' and nvl(deactive,'N')='N' ";
rs=db.getRowset(qry);	
while(rs.next())
{

	ctr++;
	mName1="FSTID"+ctr;
	qryss="select  subjectcode from subjectmaster where subjectid='"+mSubjectid+"'";
	rss=db.getRowset(qryss);	
	if(rss.next())
	{
		mysubjcode=rss.getString(1);	
	}
%>
 <TR>
<TD><INPUT checked TYPE="hidden" NAME="<%=mName1%>" ID="<%=mName1%>" VALUE="<%=rs.getString("fstid")%>"></TD> 
<TD><%=mysubjcode%></TD>
<TD><%=rs.getString("programcode")%></TD>
<TD><%=rs.getString("SECTIONBRANCH")%></TD>
<TD><%=rs.getString("SUBSECTIONCODE")%></TD>
<TD><%=rs.getString("SEMESTER")%></TD>
</TR>
<%
}
%>
<tr>
<td  align=center colspan=6>
<input type=submit value="Delete Grades" >
</td>
</tr>
<input type="hidden" name="ExamCode" id="ExamCode" value="<%=mExamCode%>">
<input type="hidden" name="Subject" id="Subject" value="<%=mSubjectid%>">
<input type="hidden" name="CTR" id="CTR" value="<%=ctr%>">
</table>
</FORM>		  
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