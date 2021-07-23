<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 

<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="TIET ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Student Reaction Survey - Abusing Suggestions ] </TITLE>
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

DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null,rs2=null;
//GlobalFunctions gb =new GlobalFunctions();

String qry="";
String qry1="";

int mSNO=0;
String mMemberID="",mstudid="",mAbuse="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mOA="";

String mInst="";
String mEvent="";
String mExam="";
String mSubj="";
String mSubjCode="";
String mLTP="";
String mEMPID="";
String mPC="",mSB="",mSSC="";

try
{
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
	if (request.getParameter("ICD").toString().trim()==null)
	{
		mInst="";
	}
	else
	{	

		mInst=request.getParameter("ICD").toString().trim();
	}

	if (request.getParameter("SEC").toString().trim()==null)
	{
		mEvent="";
	}
	else
	{
		mEvent=request.getParameter("SEC").toString().trim();
	}

	if (request.getParameter("EC").toString().trim()==null)
	{
		mExam="";
	}	
	else
	{
		mExam=request.getParameter("EC").toString().trim();
	}	

	if (request.getParameter("SC").toString().trim()==null)
	{
		mSubjCode="";
	}
	else
	{
		mSubjCode=request.getParameter("SC").toString().trim();
	}

	if (request.getParameter("SID").toString().trim()==null)
	{
		mSubj="";
	}
	else
	{
		mSubj=request.getParameter("SID").toString().trim();
	}

	if (request.getParameter("LTP").toString().trim()==null)
	{
		mLTP="";
	}
	else
	{	
		mLTP=request.getParameter("LTP").toString().trim();
	}

	if (request.getParameter("EMPID").toString().trim()==null)
	{
		mEMPID="";
	}
	else
	{	
		mEMPID=request.getParameter("EMPID").toString().trim();
	}
if (request.getParameter("PC").toString().trim()==null)
	{
		mPC="";
	}
	else
	{	
		mPC=request.getParameter("PC").toString().trim();
	}
if (request.getParameter("SSC").toString().trim()==null)
	{
		mSSC="";
	}
	else
	{	
		mSSC=request.getParameter("SSC").toString().trim();
	}
if (request.getParameter("SB").toString().trim()==null)
	{
		mSB="";
	}
	else
	{	
		mSB=request.getParameter("SB").toString().trim();
	}


}
catch(Exception e)
{
	out.print("Error Exists!!!!!!!!");
}


try
{
	OLTEncryption enc=new OLTEncryption();
	if(!mMemberID.equals("") && !mMemberCode.equals("")) 
	{
	mDMemberCode=enc.decode(mMemberCode);

%>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">SRS Event Suggestion</TD>
</font></td></tr>
</TABLE>
<%
String mEnm="";
qry="select EmployeeName from EmployeeMaster where EmployeeID='"+mEMPID+"'";
rs1=db.getRowset(qry);
if(rs1.next())
{
mEnm=rs1.getString(1);
}
%>
 <font color="#00008b">Subject Code: <b><%=mSubjCode%></B> &nbsp; &nbsp;Faculty Name: <B><%=mEnm%></B> &nbsp; &nbsp; LTP: <B><%=mLTP%></B>
 
</font> 
 
<%
qry="SELECT distinct trim(SUGGESTION) sugg, ABUSINGLEVEL from SRSEVENTSUGGESTION A, ";
qry=qry+" ABUSINGWORDS B where A.fstid in (select fstid from facultysubjecttagging  ";
qry=qry+" where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mExam+"' and  ";
qry=qry+" SUBJECTID='"+mSubj+"' And EmployeeID='"+mEMPID+"' ";
qry=qry+" and  LTP in ("+mLTP+") and sectionbranch='"+mSB+"' and Programcode='"+mPC+"' ";
qry=qry+" and subsectioncode='"+mSSC+"' ) ";
qry=qry+" and A.SUGGESTION is not null and nvl(A.deactive,'N')='N'";
qry=qry+" and nvl(B.deactive,'N')='N'  and NVL(A.ISABUSING,'N')='N' AND ";
qry=qry+" upper(SUGGESTION) like '%'||upper(ABUSINGWORD)||'%' and A.SRSEVENTCODE='"+mEvent+"' ";

//qry="SELECT distinct trim(SUGGESTION) sugg,  ABUSINGLEVEL from SRSEVENTSUGGESTION A, ABUSINGWORDS B where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mExam+"'";
//qry=qry+"and SRSEVENTCODE='"+mEvent+"'";
//qry=qry+" and SUBJECTID='"+mSubj+"' And EmployeeID='"+mEMPID+"' and  "+mLTP+" like '%'||LTP||'%'  and SUGGESTION is not null and nvl(A.deactive,'N')='N' and nvl(B.deactive,'N')='N' and sectionbranch='"+mSB+"' and Programcode='"+mPC+"' and subsectioncode='"+mSSC+"' and upper(SUGGESTION) like '%'||upper(ABUSINGWORD)||'%'";
//out.print(qry);
rs1=db.getRowset(qry);
mSNO=0;
while(rs1.next())
{ if(mSNO==0)
  {	
%>
<form name="frm" method=post>
<TABLE  rules=Rows cellSpacing=1 cellPadding=1 width="100%" border=1 >
<tr>
 <td><b><font color="#00008b">SNo</font></b></td>
 <td><b><font color="#00008b">Suggestion</font></b></td>
</tr>

<%
}
mSNO++;
%>

<tr>
<td><%=mSNO%></td>
<td><%=rs1.getString("sugg")%></td>
</tr>
<%
	
} 
if(mSNO>0)
{	
%>
<tr><td colspan=2>
<FONT color=black><FONT face=Arial size=2><STRONG>Approve and hide all abusing suggestions:</STRONG></FONT></FONT>
<select name=Abuse tabindex="0" id="Abuse" style="WIDTH: 50px">	
<OPTION Value =No selected>No</option>
<OPTION Value =Yes>Yes</option>
</select>

<INPUT TYPE=SUBMIT VALUE=SUBMIT></TD></TR>	
</TABLE>
</form>
<%
}
	mAbuse=request.getParameter("Abuse").toString().trim();
	if(mAbuse!=null)
	{
	 if(mAbuse.equals("Yes"))
	{
		qry="UPDATE SRSEVENTS SET APPROVED='Y' ,APPROVEBY='"+mEMPID+"' , ";
		qry=qry +" APPROVEDDATE=SYSDATE where fstid in (select fstid from facultysubjecttagging  ";
		qry=qry+" where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mExam+"' and  ";
		qry=qry+" SUBJECTID='"+mSubj+"' And EmployeeID='"+mEMPID+"' ";
		qry=qry+" and  LTP in ("+mLTP+") and sectionbranch='"+mSB+"' and Programcode='"+mPC+"' ";
		qry=qry+" and subsectioncode='"+mSSC+"' ) ";
		qry=qry+" and SRSEVENTCODE='"+mEvent+"'";
		int n=db.update(qry);

		qry="SELECT distinct trim(SUGGESTION) sugg,STUDENTID,ABUSINGLEVEL from SRSEVENTSUGGESTION A, ";
		qry=qry+" ABUSINGWORDS B where A.fstid in (select fstid from facultysubjecttagging  ";
		qry=qry+" where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mExam+"' and  ";
		qry=qry+" SUBJECTID='"+mSubj+"' And EmployeeID='"+mEMPID+"' ";
		qry=qry+" and  LTP in ("+mLTP+") and sectionbranch='"+mSB+"' and Programcode='"+mPC+"' ";
		qry=qry+" and subsectioncode='"+mSSC+"' ) ";
		qry=qry+" and A.SUGGESTION is not null and nvl(A.deactive,'N')='N'";
		qry=qry+" and nvl(B.deactive,'N')='N' and NVL(A.ISABUSING,'N')='N' and  ";
		qry=qry+" upper(SUGGESTION) like '%'||upper(ABUSINGWORD)||'%' and A.SRSEVENTCODE='"+mEvent+"' ";

		//qry="SELECT distinct studentid from SRSEVENTSUGGESTION A ";
		//qry=qry+"  where A.fstid in (select fstid from facultysubjecttagging  ";
		//qry=qry+" where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mExam+"' and  ";
		//qry=qry+" SUBJECTID='"+mSubj+"' And EmployeeID='"+mEMPID+"' ";
		//qry=qry+" and  LTP in ("+mLTP+") and sectionbranch='"+mSB+"' and Programcode='"+mPC+"' ";
		//qry=qry+" and subsectioncode='"+mSSC+"' ) ";
		//qry=qry+" and nvl(A.deactive,'N')='N' and A.SRSEVENTCODE='"+mEvent+"' ";
		rs2=db.getRowset(qry);
		while(rs2.next())
		{
			mstudid=rs2.getString("studentid");
			qry="UPDATE srseventsuggestion SET ISABUSING='Y'  ";
			qry=qry+" where fstid in (select fstid from facultysubjecttagging  ";
			qry=qry+" where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mExam+"' and  ";
			qry=qry+" SUBJECTID='"+mSubj+"' And EmployeeID='"+mEMPID+"' ";
			qry=qry+" and  LTP in ("+mLTP+") and sectionbranch='"+mSB+"' and Programcode='"+mPC+"' ";
			qry=qry+" and subsectioncode='"+mSSC+"' ) ";
			qry=qry+" and SRSEVENTCODE='"+mEvent+"' and studentid='"+mstudid+"'  and SUGGESTION='"+rs2.getString("sugg")+"'";
			//out.print(qry);
			int n1=db.update(qry);
		}
		out.print("<FONT FACE='ARIAL' SIZE=2 COLOR='GREEN'>Suggestions approved...</FONT>");
	 }
	else
	{
	out.print("Suggestions not approved...");
      }
     }
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

<table cellpading=0 cellspacing=0 width=100%>  	
 <TR><TD COLSPAN=2 ALIGN=CENTER><b>For Better Security <a onClick="window.close();"><u><font color=green>Close</font></u> this window </a></TD><TR>
</table>


</body>
</html>