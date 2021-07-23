<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String qry="";
ResultSet rs=null;
String qrys="";
ResultSet rss=null;
ResultSet rss1=null;
int mSno1=0;
String mNames="";
DBHandler db=new DBHandler();
String mInst="",mDefault="";
int ctr=0;
String mHead="";
String mysubjcode="",mETOD="";
String qrysub="",mNam="",mSc="",mCheckFstid="",mWeightageInit="",qry2="",qryi=""; 
ResultSet rssub=null,rs2=null,rsi=null;

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";

	qry="Select Distinct NVL(INSTITUTECODE,' ')IC from v#SRSEVENTS WHERE nvl(deactive,'N')='N' ";
	//out.println(qry);
	rs=db.getRowset(qry);
	if(rs.next())
	{
		mInst=rs.getString("IC");
	}
	else
	{
		mInst="JIIT";
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
<form name="frm1"  method="post" >
<input id="y" name="y" type=hidden>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Grade Calculation Report</b></TD>
</font></td></tr>
</TABLE>
<%
/*
    qry="select GRADEENTRYEXAMID  from DEFAULTVALUES ";
	rs=db.getRowset(qry);
	if(rs.next())
	{
		mDefault=rs.getString("GRADEENTRYEXAMID");
	}
*/
%>
<table cellpadding=1 cellspacing=0 width="98%" align=center rules=groups border=3>

<!--Institute-->
<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>

<tr><td colspan=3><b>CoOrdinator Name/Member name : </b><font color=dark brownt><b><%=mMemberName%>&nbsp;(<%=mDMemberCode%>)</font></b></td></tr>
<tr>
<td>
	<b>ExamCode</b>
	<%
	qry="select distinct examcode from gradecalculation ";
		//out.println("dddd"+qry);%>
	 <select name=ExamCode tabindex="0" id="ExamCode" style="WIDTH: 130px" > 
	<%

		rs=db.getRowset(qry);
		if (request.getParameter("y")==null) 
		{
			while(rs.next())
			{  
			mECode=rs.getString("EXAMCODE");
			if(mECode.equals(""))
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
   &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp;
<%
	if(request.getParameter("ETOD")==null)
	{
	%>
	 <input type=RADIO name=ETOD id=ETOD VALUE="N" checked=true ><b>Normal</b>
	 <input type=RADIO name=ETOD id=ETOD VALUE="E" ><b>EtoD</b>
	<%
	}
	else if(request.getParameter("ETOD").toString().trim().equals("N"))
	{
	%>
	 <input type=RADIO name=ETOD id=ETOD VALUE="N" checked=true ><b>Normal</b>
	 <input type=RADIO name=ETOD id=ETOD VALUE="E" ><b>EtoD</b>
	<%
	}	
	else
		{
		%>
	 <input type=RADIO name=ETOD id=ETOD VALUE="N" ><b>Normal</b>
	 <input type=RADIO name=ETOD id=ETOD VALUE="E" checked=true ><b>EtoD</b>
	<%
		}
		%>
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type=submit value="Continue" >
</td>
</tr>
</TABLE>
</FORM>
<%
	if(request.getParameter("y")!=null)
	{
	mDefault=request.getParameter("ExamCode").toString().trim();
	mETOD=request.getParameter("ETOD").toString().trim();

%>
<form name="frm"  method="post"  action="GradePrintAction.jsp">
<input id="x" name="x" type=hidden>
<table cellpadding=1 cellspacing=0 width="98%" align=center rules=groups border=3>
<!--Institute-->
<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
<INPUT Type="Hidden" Name=ExamCode id=ExamCode Value=<%=mDefault%>>
<INPUT Type="Hidden" Name=ETOD id=ETOD Value=<%=mETOD%>>

<tr>
<td>
	<b>Subject</b>
	    <%
	
qry="select distinct A.SEMESTER,A.subjectID SUBJECTID,B.subject||'('|| B.SUBJECTCODE ||')' SUBJECT from ( select distinct SEMESTER,subjectID,fstid from ";
qry=qry+" facultysubjecttagging AA where institutecode='"+mInst+"' and examcode='"+mDefault+"' ";
qry=qry+" and employeeid='"+mChkMemID+"' and  (LTP='L' or ( LTP='P' and exists (select 1 from programsubjecttagging where examcode='"+mDefault+"' and institutecode='"+mInst+"' and subjectid=aa.subjectid and L=0 and p>0 )) OR (LTP='E' and PROJECTSUBJECT='Y' and exists (select 1 from programsubjecttagging where examcode='"+mDefault+"' and institutecode='"+mInst+"' and subjectid=aa.subjectid and L=0 and p>0 )))";
qry=qry+" union ";
qry=qry+" select distinct SEMESTER,subjectID,fstid from V#EX#SUBJECTGRADECOORDINATOR where institutecode='"+mInst+"' and ";
qry=qry+" examcode='"+mDefault+"' and COORDINATORID='"+mChkMemID+"' ";
qry=qry+" MINUS ";
qry=qry+" select distinct SEMESTER, subjectID,fstid from V#EX#SUBJECTGRADECOORDINATOR  ";
qry=qry+" where  employeeid='"+mChkMemID+"' and examcode='"+mDefault+"'  and COORDINATORID<>'"+mChkMemID+"' ) A,subjectmaster B where A.subjectID=B.subjectID order by SUBJECTID";
//out.print(qry);
%>
		
		
		<select name=Subject tabindex="0" id="Subject" style="WIDTH: 310px" > 
	<%

//qry=qry+" AND fstid in (select fstid from EX#GRADESUBJECTBREAKUP where  employeeid='"+mChkMemID+"')" ;
rs=db.getRowset(qry);
out.print(qry);
if (request.getParameter("x")==null) 
{
	while(rs.next())
	{  

		    mSCode=rs.getString("SUBJECTID")+"***"+rs.getString("SEMESTER");
		    if(mscode.equals(""))
		   %>
		   <OPTION Value =<%=mSCode%>><%=rs.getString("SUBJECT")%>&nbsp;Sem-<%=rs.getString("SEMESTER")%></option>
		   <%			
		}
	} // closing of if 
else
{
	while(rs.next())
	{
		mSCode=rs.getString("SUBJECTID")+"***"+rs.getString("SEMESTER");
		if(mSCode.equals(request.getParameter("Subject").toString().trim()))
		{
%>
			<OPTION selected Value =<%=mSCode%>><%=rs.getString("SUBJECT")%>&nbsp;Sem-<%=rs.getString("SEMESTER")%></option>
	<%
	}
	else
	{
%>
		<OPTION Value =<%=mSCode%>><%=rs.getString("SUBJECT")%>&nbsp;Sem-<%=rs.getString("SEMESTER")%></option>
<%
	}
  } //closing of while
} // closing of else
%>
</select>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<input type=submit value="Continue" >
</td>
</tr>
</TABLE>
</FORM>
<%
	} // closong of if("y")
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