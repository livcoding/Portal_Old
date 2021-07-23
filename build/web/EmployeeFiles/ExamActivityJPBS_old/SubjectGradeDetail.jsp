<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null,rss=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="";
String mStatus="";
int ctr=0;
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInst="";
String mExam="",QryExam="", QrySub="";
String mName1="",mName2="";
int mFlag=0;
String sname="",qry2="",qry3="",qry4="";
ResultSet rs2=null,rs3=null,rs4=null;
String 	Studid="",mDetained="",SubjectCode="";
int Rejected=0,mCount1=0;

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
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Grade Approval By DOAA ]</TITLE>

<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<SCRIPT LANGUAGE="JavaScript"> 
function un_check()
{
 for (var i = 0; i < document.frm1.elements.length; i++) 
 {
  var e = document.frm1.elements[i]; 
  if ((e.name != 'allbox') && (e.type == 'checkbox')) 
  { 
   e.checked = document.frm1.allbox.checked;
  }
 }
}
</SCRIPT>

<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
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
<script>
	if(window.history.forward(1) != null)
	window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
try
{
	OLTEncryption enc=new OLTEncryption();

	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{
		mDMemberID=enc.decode(mMemberID);
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

		qry="Select WEBKIOSK.ShowLink('147','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
		  //----------------------
				
				String  SubjectName="";
				
				if(request.getParameter("ExamCode")==null)
				{
					QryExam="";
				}
				else
				{
					QryExam=request.getParameter("ExamCode").toString().trim();	
				}
				if(request.getParameter("Subject")==null)
				{
					QrySub="";
				}
				else
				{
					QrySub=request.getParameter("Subject").toString().trim();	
				}
				
				qry="select subjectcode,subject from subjectmaster where subjectid='"+QrySub+"' and INSTITUTECODE ='"+mInst+"' ";
				rs=db.getRowset(qry);
				if(rs.next())
				{
					SubjectCode=rs.getString("subjectcode");
					SubjectName=rs.getString("subject");
				}

				%>
				<form name="frm" method="post" >
				<input id="x" name="x" type=hidden>
				<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
				<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: Verdana"><STRONG><u>Student Wise Grade</u></STRONG></TD>
				</font></td></tr>

				<tr><TD colspan=0 align=middle><font color="#a52a2a" Face=verdana size=3 ><STRONG>Subject Name : <%=SubjectName%>&nbsp;(<%=SubjectCode%>)</STRONG></TD>
				</font></td>
				</tr>
				<tr>
				<TD colspan=0 align=middle><font color="#a52a2a" Face=verdana size=3><STRONG>Exam Code : <%=QryExam%></STRONG></TD>
				</font></td>
				</tr>

				</TABLE>
				
				<%	
				/*
				String mETOD="";
				if(request.getParameter("ETOD")==null)
			    {
					mETOD="N";
				} 
				else
			    { 
					mETOD=request.getParameter("ETOD").toString().trim();
				}   
				*/
				

			

				qry="select A.STUDENTID,B.STUDENTNAME,b.enrollmentno enrollmentno,A.FINALGRADE,A.FINALMARKS  from studentwisegrade A,STUDENTMASTER B where A.examcode='"+QryExam+"' and a.INSTITUTECODE ='"+mInst+"'  AND A.STUDENTID=B.STUDENTID AND A.INSTITUTECODE=B.INSTITUTECODE AND A.BREAK#SLNO IN(SELECT BREAK#SLNO FROM GRADECALCULATION WHERE examcode='"+QryExam+"'  AND SUBJECTID='"+QrySub+"' and INSTITUTECODE ='"+mInst+"'  )";
				qry=qry+" Order by ENROLLMENTNO";
				//out.println(qry);
				rs=db.getRowset(qry);
				rss=db.getRowset(qry);
				if(rs.next())
				{
				%>
				<form Name=frm1 ID=frm1 Action="" Method=Post>
				<table valign=top class="sort-table" id="table-1" border=1 width="100%" cellpadding=0 cellspacing=0 align=center rules=none>
				<THEAD>
				<tr bgcolor='#e68a06'>
				<td><font color="white"><b>SrNo</b></font></td>
				<td align=left Title="Student Name"><font color="white"><b>Student name</b></font></td>
				
				<td align=left Title="Enrollment No" ><font color="white"><b>Enrollment No</b></font></td>
				
				<td align=left Title="Final Marks"><font color="white"><b>Final Marks</b></font></td>
				<td align=left Title="Final Grades"><font color="white"><b>Final Grade</b></font></td> 
				</tr>
				</thead>
				<tbody>
				<%
				}
				else
				{
					%><Center><%
					out.print("<br><img src='../../Images/Error1.jpg'>");
					out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>No Such Record Found...</font> <br>");
					%></Center><%
				}
				String mColor="";
				int mChoice=0;
				String mLastStatus="";
				String mCol1="LightGrey";
				String OldmELECTIVECODE="";
				String mCol2="#ffffff";
				String mSubjCode="", mSubjName="", mE2DType="", mEDate="", TRCOLOR="#F8F8F8";
				while(rss.next())
				{
					
					ctr++;
					
					%>
					<tr BGCOLOR='<%=TRCOLOR%>'>
					
					<td align=right><%=ctr%>.&nbsp;</td>
					<td nowrap><%=rss.getString("STUDENTNAME")%></td>
					<td nowrap><%=rss.getString("ENROLLMENTNO")%></td>
					<td nowrap><%=rss.getString("FINALMARKS")%></td>
					<td nowrap><%=rss.getString("FINALGRADE")%></td>
					</tr>
					<%
				}
				%>
				</tbody>
				</TABLE>
				<script type="text/javascript">
				var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString","Number","CaseInsensitiveString","CaseInsensitiveString"]);
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
			<h3><br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
			<P>This page is not authorized/available for you.
			<br>For assistance, contact your network support team. 
			</font><br>	<br>	<br>	<br> 
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
	//out.println(qry);
}
%>
</body>
</html>