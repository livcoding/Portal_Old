<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
ResultSet rs2=null;
String mI="";
String mE="";
GlobalFunctions gb =new GlobalFunctions();
String mL="",mT="",mP="",mCurPRCode="";
String qry="";
String qry1="";
String x="",t="",mfactype="";
int ctr=0;
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInstitute="",mInst="";
String mExam="";
String mexam="";
String mLTP="",msg="",mStatus="",mL1="",mT1="",mP1="";
String mSubj="",mSentToHOD="",mType="",Heading="",qry2="";
String mSubjType="",mFaculty="",mChoice="",mChoice1="",mcolor="";
int kk1=0,mFlag=0;
int mRights=0;


if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}

if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}

if (session.getAttribute("InstituteCode")==null)
{
	mInstitute="";
}
else
{
	mInstitute=session.getAttribute("InstituteCode").toString().trim();
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

if (request.getParameter("Type")==null)
{
	mType="";
}
else
{
	mType=request.getParameter("Type").toString().trim();
}

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [List of Subject assigned by respective HOD] </TITLE>
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
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
try
{
if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{	
		OLTEncryption enc=new OLTEncryption();
		mDMemberID=enc.decode(mMemberID);
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);
		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk=null;
if(mType.equals("D"))
	{
	   mRights=121;
	  Heading="DOAA.";	
	}
	else if(mType.equals("H"))
	{
	   mRights=122;
	  Heading="HOD";	
	}

	
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
qry="Select WEBKIOSK.ShowLink('"+mRights+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
RsChk= db.getRowset(qry);
if (RsChk.next() && RsChk.getString("SL").equals("Y"))
  	{



//-------------------------------------------------
qry="select nvl(EmployeeName,' ')EN, nvl(EmployeeCode,' ')EC from EmployeeMaster where EmployeeID='"+mChkMemID+"' and nvl(Deactive,'N')='N'";
rs=db.getRowset(qry);
while(rs.next())
{
mFaculty=rs.getString("EN");
}
	//--------------------------------------------------------
	//----------------------
	
		qry= " Select 'y', PREVENTCODE from PREVENTS WHERE INSTITUTECODE='"+ mInstitute +"' AND (PREVENTCODE) IN (SELECT  PREVENTCODE from PREVENTMASTER WHERE INSTITUTECODE='" + mInstitute +"'";
		qry=qry+ " and NVL(APPROVED,'N')='N' and nvl(PRCOMPLETED,'N')='N' and nvl(PRBROADCAST,'N')='Y' and PRREQUIREDFOR='E'";
		qry=qry+" AND NVL(DEACTIVE,'N')='N') and MEMBERTYPE='E' and MEMBERID='"+mDMemberID+"'";
		qry=qry+" and trunc(sysdate) between trunc(EVENTFROM) and trunc(EVENTTO) and nvl(DEACTIVE,'N')='N'";
		rs=db.getRowset(qry);
		if(rs.next())
		{		
			mCurPRCode=rs.getString("PREVENTCODE");

%>
	<form name="frm"  method="get">
	<input id="x" name="x" type=hidden>
	<table width="100%%" ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">List of Subject which load Distribution has not been Assigned by 	<%=Heading%></font></td></tr>
	</TABLE>
	<table cellpadding=1 cellspacing=0 width="88%" align=center rules=groups border=3>
	<!--Institute****-->
<Input Type=hidden name=InstCode Value=<%=mInstitute%>>
<INPUT Type="hidden" Name=Type id=Type Value=<%=mType%>>

<!--*********Exam**********-->
<tr><td><FONT color=black><FONT face=Arial size=2><STRONG>Exam Code</STRONG></FONT></FONT>
&nbsp; &nbsp;
<%
	qry="Select  nvl(PREREGEXAMID,' ') Exam from COMPANYINSTITUTETAGGING Where COMPANYCODE='"+mComp+"' And INSTITUTECODE='"+mInst+"'";
	rs=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		%>
		<select name=Exam tabindex="0" id="Exam" style="WIDTH: 120px">	
		<%   
		while(rs.next())
		{
			mExam=rs.getString("Exam");
			if(mE.equals(""))
 			mE=mExam;
			%>
			<OPTION Value =<%=mExam%>><%=rs.getString("Exam")%></option>
			<%
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name=Exam tabindex="0" id="Exam" style="WIDTH: 120px">	
		<%
		while(rs.next())
		{
			mExam=rs.getString("Exam");
			if(mExam.equals(request.getParameter("Exam").toString().trim()))
 			{
				mE=mExam;
				%>
				<OPTION selected Value =<%=mExam%>><%=rs.getString("Exam")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mExam%>><%=rs.getString("Exam")%></option>
		      	<%			
		   	}
		}
		%>
		</select></td>
	  	<%
	 }
%>
<td><FONT color=black><FONT face=Arial size=2><STRONG>Choice</STRONG></FONT></FONT>
<select name=Choice tabindex="0" id="Report Type" style="WIDTH: 150px">
<% 	if(request.getParameter("Choice")==null)
   	{
 %>			
	<OPTION Value =D selected>Distributed</option>
	<OPTION Value =ND>Not Distributed</option>
<%
  	}
  else
  	 {
	mChoice=request.getParameter("Choice");
	if(mChoice.equals("D"))
	{
%>
	<OPTION Value =D selected>Distributed</option>
	<OPTION Value =ND>Not Distributed</option>
<%
      }
	
	else if(mChoice.equals("ND"))
	{
	%>
	<OPTION Value =ND selected>Not Distributed</option>
	<OPTION Value =D>Distributed</option>
	<%		
	}
    }	
	
%>
</select>
</td>
&nbsp &nbsp;
<td><INPUT Type="submit" Value="&nbsp;OK&nbsp;">
</td>
</tr>
</table>
</form>

<table bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=columns topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center width="100%">
<thead>
<tr bgcolor="#ff8c00">
 <td align=center><b><font color=white>Academic Year</font></td>
 <td align=center><b><font color=white>Program Code</font></td>
 <td align=center><b><font color=white>Tagging For</font></td>
 <td align=center><b><font color=white>Section/Branch</font></td>
 <td align=center><b><font color=white>Subject</font></td>
 <td align=center><b><font color=white>LTP</font></td>
</tr>
</thead>
<tbody>

<%

	if (request.getParameter("InstCode")!=null)
		mI=request.getParameter("InstCode").toString().trim();

	if (request.getParameter("Exam")!=null)
		mE=request.getParameter("Exam").toString().trim();

	if (request.getParameter("Choice")!=null)
		mChoice1=request.getParameter("Choice").toString().trim();
	try
	{

	//out.print(mType);
if(mType.equals("D"))
{
	if(mChoice1.equals("ND"))
	{
	
	qry1="select nvl(A.INSTITUTECODE,' ')INSTITUTECODE, nvl(A.EXAMCODE,' ')EXAMCODE, nvl(A.ACADEMICYEAR,' ')ACADEMICYEAR, nvl(A.PROGRAMCODE,' ')PROGRAMCODE,nvl(A.TAGGINGFOR,' ')TAGGINGFOR, nvl(A.SECTIONBRANCH,' ')SECTIONBRANCH,nvl(B.SUBJECTCODE,' ') SUBJECTCODE ,nvl(A.SUBJECTID,' ') SUBJECTID , nvl(A.L,' ')L,nvl(A.T,' ')T,nvl(A.P,' ')P,nvl(B.subject,' ')subject from PROGRAMSUBJECTTAGGING A,subjectmaster B";
	qry1=qry1+" where A.institutecode='"+mI+"' and A.examcode='"+mE+"' and nvl(A.DEACTIVE,'N')='N'and A.subjectid=B.subjectid ORDER BY B.SUBJECT";
	//out.print(qry1);
	}
	else
	if(mChoice1.equals("D"))
	{
	qry1="(select nvl(A.INSTITUTECODE,' ')INSTITUTECODE, nvl(A.EXAMCODE,' ')EXAMCODE, nvl(A.ACADEMICYEAR,' ')ACADEMICYEAR, nvl(A.PROGRAMCODE,' ')PROGRAMCODE,nvl(A.TAGGINGFOR,' ')TAGGINGFOR, nvl(A.SECTIONBRANCH,' ')SECTIONBRANCH,nvl(A.SUBJECTID,' ') SUBJECTID ,nvl(B.SUBJECTCODE,' ') SUBJECTCODE , nvl(B.subject,' ')subject from PROGRAMSUBJECTTAGGING A,subjectmaster B";
	qry1=qry1+" where A.institutecode='"+mI+"' and A.examcode='"+mE+"' and nvl(A.DEACTIVE,'N')='N'and A.subjectid=B.subjectid)";
	qry1=qry1+" MINUS ";
	qry1=qry1+"(select nvl(A.INSTITUTECODE,' ')INSTITUTECODE, nvl(A.EXAMCODE,' ')EXAMCODE, nvl(A.ACADEMICYEAR,' ')ACADEMICYEAR, nvl(A.PROGRAMCODE,' ')PROGRAMCODE,";
	qry1=qry1+"nvl(A.TAGGINGFOR,' ')TAGGINGFOR, nvl(A.SECTIONBRANCH,' ')SECTIONBRANCH,nvl(A.SUBJECTID,' ') SUBJECTID , nvl(B.subject,' ')subject from PR#HODLOADDISTRIBUTION A,subjectmaster B";
	qry1=qry1+" where A.institutecode='"+mI+"' and A.examcode='"+mE+"' and nvl(A.DEACTIVE,'N')='N'and A.subjectid=B.subjectid)";
//	out.print(qry1);
}
}
if(mType.equals("H"))
{
if(mChoice1.equals("ND"))
	{
	qry1="select nvl(A.INSTITUTECODE,' ')INSTITUTECODE, nvl(A.EXAMCODE,' ')EXAMCODE, nvl(A.ACADEMICYEAR,' ')ACADEMICYEAR, nvl(A.PROGRAMCODE,' ')PROGRAMCODE,nvl(A.TAGGINGFOR,' ')TAGGINGFOR, nvl(B.SUBJECTCODE,' ') SUBJECTCODE ,nvl(A.SECTIONBRANCH,' ')SECTIONBRANCH,nvl(A.SUBJECTID,' ') SUBJECTID , nvl(A.L,' ')L,nvl(A.T,' ')T,nvl(A.P,' ')P,nvl(B.subject,' ')subject from PROGRAMSUBJECTTAGGING A,subjectmaster B";
	qry1=qry1+" where A.institutecode='"+mI+"' and A.examcode='"+mE+"' and nvl(A.DEACTIVE,'N')='N'and A.subjectid=B.subjectid";
	qry1=qry1+" and A.subjectid in ";
	qry1=qry1+" (Select subjectid from facultysubjecttagging where examcode ";
	qry1=qry1+" in (Select ExamCode from PROGRAMSUBJECTTAGGING)";
	qry1=qry1+"  and employeeid in (select Employeeid ";
	qry1=qry1+" from EMPLOYEEMASTER where DEPARTMENTCODE in (select DEPARTMENTCODE from ";
	qry1=qry1+" hodlist where employeeid='"+mDMemberID+"' and nvl(deactive,'N')='N')) )";
   
	//out.print(qry1);

}
	else
	if(mChoice1.equals("D"))
	{
	qry1="select nvl(A.INSTITUTECODE,' ')INSTITUTECODE, nvl(A.EXAMCODE,' ')EXAMCODE, nvl(A.ACADEMICYEAR,' ')ACADEMICYEAR, nvl(A.PROGRAMCODE,' ')PROGRAMCODE,nvl(A.TAGGINGFOR,' ')TAGGINGFOR, nvl(A.SECTIONBRANCH,' ')SECTIONBRANCH,nvl(A.SUBJECTID,' ') SUBJECTID ,nvl(B.SUBJECTCODE,' ') SUBJECTCODE , nvl(B.subject,' ')subject from PROGRAMSUBJECTTAGGING A,subjectmaster B";
	qry1=qry1+" where A.institutecode='"+mI+"' and A.examcode='"+mE+"' and nvl(A.DEACTIVE,'N')='N'and A.subjectid=B.subjectid ";
	qry1=qry1+" and A.subjectid in ";
	qry1=qry1+" (Select subjectid from facultysubjecttagging where examcode ";
	qry1=qry1+" in (Select ExamCode from PROGRAMSUBJECTTAGGING)";
	qry1=qry1+"  and employeeid in (select Employeeid ";
	qry1=qry1+" from EMPLOYEEMASTER where DEPARTMENTCODE in (select DEPARTMENTCODE from ";
	qry1=qry1+" hodlist where employeeid='"+mDMemberID+"' and nvl(deactive,'N')='N')) )";
    	qry1=qry1+" MINUS ";
	qry1=qry1+"select nvl(A.INSTITUTECODE,' ')INSTITUTECODE, nvl(A.EXAMCODE,' ')EXAMCODE, nvl(A.ACADEMICYEAR,' ')ACADEMICYEAR, nvl(A.PROGRAMCODE,' ')PROGRAMCODE,";
	qry1=qry1+"nvl(A.TAGGINGFOR,' ')TAGGINGFOR, nvl(A.SECTIONBRANCH,' ')SECTIONBRANCH,nvl(A.SUBJECTID,' ') SUBJECTID, nvl(B.SUBJECTCODE,' ') SUBJECTCODE, nvl(B.subject,' ')subject from PR#HODLOADDISTRIBUTION A,subjectmaster B";
	qry1=qry1+" where A.institutecode='"+mI+"' and A.examcode='"+mE+"' and nvl(A.DEACTIVE,'N')='N'and A.subjectid=B.subjectid";
	//out.print(qry1);
	}
}

	rs1=db.getRowset(qry1);
	while(rs1.next()) 
	  {  	 

		if(mChoice1.equals("ND"))
		{
			mL=rs1.getString("L");
			mT=rs1.getString("T");
			mP=rs1.getString("P");
		}

		if(mChoice1.equals("D"))
		{
		qry="Select nvl(L,' ')L,nvl(T,' ')T,nvl(P,' ')P	from PROGRAMSUBJECTTAGGING";
		rs=db.getRowset(qry);
		qry2="Select nvl(LTP,' ')LTP from PR#HODLOADDISTRIBUTION ";
		rs2=db.getRowset(qry2);
		}
		kk1++;

			mcolor="Black";
			%>
			<tr>
			<td nowrap><font color=<%=mcolor%>>&nbsp;<%=rs1.getString("ACADEMICYEAR")%></font></td>
			<td nowrap><font color=<%=mcolor%>>&nbsp;<%=rs1.getString("PROGRAMCODE")%></font></td>
			<td nowrap><font color=<%=mcolor%>>&nbsp;<%=rs1.getString("TAGGINGFOR")%></font></td>
			<td nowrap><font color=<%=mcolor%>>&nbsp;<%=rs1.getString("SECTIONBRANCH")%></font></td>
			<td nowrap><font color=<%=mcolor%>><%=rs1.getString("subject")%> (<%=rs1.getString("SUBJECTCODE")%>)</font></td>
			<%
		if(mChoice1.equals("ND"))
		{
			if(!mL.equals("0"))
			{
			mL1="L";
			}
			else
			{ 
			mL1="";
			}
                 
			if(!mT.equals("0"))
			{
			mT1=mL1+"T"; 
                  }
			else
			{
			mT1=mL1;
			}
			if(!mP.equals("0"))
			{
			mP1=mT1+"P"; 
                  }
			else
			{
			mP1=mT1;
			}
      
			%>
			<td nowrap><font color=<%=mcolor%>>&nbsp;<%=mP1%></font></td>
			<%
			}
			%>
			</tr>		
			<%  		

	  } //closing of while
   } //closing of try
	catch(Exception e)
	{
	
	}	


		
%>
</tbody>
		</table>	
<script type="text/javascript">
var st1 = new SortableTable(document.getElementById("table-1"),["CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString"]);
</script>
<br><font color=Green><strong>Total Record &nbsp;:&nbsp;</strong></font><%=kk1%>
<%
//} //closing of x==null
//-----------------------------
//---Enable Security Page Level  
//-----------------------------
  	}
	else
	{
	%>
		<font color=red>
		<h3><br><img src='../../Images/Error1.jpg'>
		Pre- Registration Event has not been declared or Registration completed</FONT></P>
	<%
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











