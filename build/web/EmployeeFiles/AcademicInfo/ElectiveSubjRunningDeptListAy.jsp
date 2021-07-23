<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null, rs1=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="";
int ctr=0;
int mData=0;
int mData1=0;
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mDept="",mdept="";
String mInstitute="",mInst="";
String mEXAM="", mSUBJ="", mSUBJID="", mSTYPE="", mSType="", mSEMTYPE="", mELECODE="", mWebEmail="";

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

if (request.getParameter("EXAM")==null)
{
	mEXAM="";
}
else
{
	mEXAM=request.getParameter("EXAM").toString().trim();
}

if (request.getParameter("SUBJ")==null)
{
	mSUBJ="";
}
else
{
	mSUBJ=request.getParameter("SUBJ").toString().trim();
}

if (request.getParameter("SUBJID")==null)
{
	mSUBJID="";
}
else
{
	mSUBJID=request.getParameter("SUBJID").toString().trim();
}

if (request.getParameter("STYPE")==null)
{
	mSTYPE="";
}
else
{
	mSTYPE=request.getParameter("STYPE").toString().trim();
}
 
if (request.getParameter("SEMTYPE")==null)
{
	mSEMTYPE="";
}
else
{
	mSEMTYPE=request.getParameter("SEMTYPE").toString().trim();
}

if(mSTYPE.equals("E"))
{
if (request.getParameter("ELECODE")==null)
{
	mELECODE=" ";
}
else
{
	mELECODE=request.getParameter("ELECODE").toString().trim();
}
}
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Elective Subject Running Department List] </TITLE>
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

		qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from institutemaster WHERE nvl(Deactive,'N')='N' ";
		rs=db.getRowset(qry);
		if(rs.next())
			mInstitute=rs.getString(1);	
		else
			mInstitute="JIIT";
	     //-----------------------------
	     //-- Enable Security Page Level  
	     //-----------------------------
		
		mInst=mInstitute;

		qry="Select WEBKIOSK.ShowLink('120','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
			
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
		  //----------------------

			qry=" SELECT distinct a.EXAMCODE from PREVENTMASTER a WHERE a.INSTITUTECODE='"+ mInst+"'  and nvl(a.PRCOMPLETED,'N')='N' and nvl(a.PRBROADCAST,'N')='Y'";
			qry=qry+" AND NVL(PRREQUIREDFOR,'S')<>'S' AND NVL(a.DEACTIVE,'N')='N' And (a.INSTITUTECODE, a.PREVENTCODE) In ";
			qry=qry+" (select b.INSTITUTECODE, b.PREVENTCODE from PREVENTS b where nvl(B.DEACTIVE,'N')='N'";
			qry=qry+" And NVL(B.MEMBERTYPE,'N')<>'S' GROUP BY b.INSTITUTECODE, b.PREVENTCODE)";
			rs= db.getRowset(qry);			
			//out.print(qry);
			if(rs.next())
			{		
				%>
				<form name="frm"  method="get" >
				<input id="x" name="x" type=hidden>
				<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
				<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>View Elective Subject(s) Department</B></TD>
				</font></td></tr>
				</TABLE>
				<table align=center rules=groups border=3>
				<tr>
				 <td><font color="#00008b" face=arial size=2><STRONG>Exam Code : </STRONG></FONT>&nbsp;<FONT color="#00008b" face=Times New Roman size=3><%=mEXAM%></FONT>&nbsp; &nbsp; &nbsp;</td>
				 <td><font color="#00008b" face=arial size=2><STRONG>Subject Code : </STRONG></FONT>&nbsp;<FONT color="#00008b" face=Times New Roman size=3><%=mSUBJ%></FONT>&nbsp; &nbsp; &nbsp;</td>
				 <%
				  if(mSTYPE.equals("E"))
					mSType="Elective";
				 %>
				 <td><font color="#00008b" face=arial size=2><STRONG>Subject Type : </STRONG></FONT>&nbsp;<FONT color="#00008b" face=Times New Roman size=3><%=mSType%></FONT>&nbsp; &nbsp; &nbsp;</td>
				 <td><font color="#00008b" face=arial size=2><STRONG>Semester Type : </STRONG></FONT>&nbsp;<FONT color="#00008b" face=Times New Roman size=3><%=mSEMTYPE%></FONT></td>
				</tr></table>
				<TABLE rules=all cellSpacing=0 cellPadding=0 border=1 align=center>
				<tr bgcolor='#e68a06'>
				 <th><font color=white>SNo.</font></th>
				 <th><font color=white>Department</font></th>
				 <th><font color=white>Program</font></th>
				 <th><font color=white>Acad.Year</font></th>
				 <th><font color=white>Section Branch</font></th>
				<%
				if (mSTYPE.equals("E"))
				{
					qry="Select A.EXAMCODE EC, A.ACADEMICYEAR AY, A.PROGRAMCODE PG, A.SECTIONBRANCH SB, NVL(B.DEPARTMENTCODE,' ')DEPTCODE ";
					qry=qry+" FROM PR#ELECTIVESUBJECTS A, PR#DEPARTMENTSUBJECTTAGGING B where nvl(A.SUBJECTRUNNING,'N')='Y' and nvl(A.DEACTIVE,'N')='N'";
					qry=qry+" AND A.SUBJECTID=B.SUBJECTID ";
					qry=qry+" AND A.INSTITUTECODE=B.INSTITUTECODE ";
					qry=qry+" AND A.EXAMCODE=B.EXAMCODE ";
					qry=qry+" AND A.ACADEMICYEAR=B.ACADEMICYEAR ";
					qry=qry+" AND A.PROGRAMCODE=B.PROGRAMCODE";
					qry=qry+" AND A.TAGGINGFOR=B.TAGGINGFOR ";
					qry=qry+" AND A.SECTIONBRANCH=B.SECTIONBRANCH ";
					qry=qry+" AND A.INSTITUTECODE='"+mInst+"' AND A.EXAMCODE='"+mEXAM+"' AND A.SUBJECTID='"+mSUBJID+"'";
				}
				/*else if (mSTYPE.equals("F"))
 				{
					qry="Select A.EXAMCODE EC, A.ACADEMICYEAR AY, A.PROGRAMCODE PG, A.SECTIONBRANCH SB, NVL(B.DEPARTMENTCODE,' ')DEPTCODE ";
					qry=qry+" FROM FREEELECTIVE A, PR#DEPARTMENTSUBJECTTAGGING B where nvl(A.SUBJECTRUNNING,'N')='Y' and nvl(A.DEACTIVE,'N')='N'";
					qry=qry+" AND A.SUBJECTID=B.SUBJECTID ";
					qry=qry+" AND A.INSTITUTECODE=B.INSTITUTECODE ";
					qry=qry+" AND A.EXAMCODE=B.EXAMCODE ";
					qry=qry+" AND A.ACADEMICYEAR=B.ACADEMICYEAR ";
					qry=qry+" AND A.PROGRAMCODE=B.PROGRAMCODE";
					qry=qry+" AND A.TAGGINGFOR=B.TAGGINGFOR ";
					qry=qry+" AND A.SECTIONBRANCH=B.SECTIONBRANCH ";
					qry=qry+" AND A.INSTITUTECODE='"+mInst+"' AND A.EXAMCODE='"+mEXAM+"' AND A.SUBJECTID='"+mSUBJID+"'";
				}*/
				//out.print(qry);
				rs=db.getRowset(qry);
				String mColor="";
				int mChoice=0;
				String mCol1="LightGrey";
				String OldmELECTIVECODE="";
				String mCol2="white";

				while(rs.next())
				{ 
					mDept=rs.getString("DEPTCODE");
					qry="Select department DeptName from DepartmentMaster where DepartmentCode='"+mDept+"'";
					rs1=db.getRowset(qry);
					if(rs1.next())
						mdept=rs1.getString(1);
					mData=1;
					ctr++;
					if (!mELECODE.equals(OldmELECTIVECODE))
					{
					   if (mChoice==0)
						mChoice=1 ;
					   else
						mChoice=0 ;
					   OldmELECTIVECODE=mELECODE;
					}
					if (mChoice==0) 
						mColor=mCol1;
					else
					      mColor=mCol2;
					%>
					<tr bgcolor="<%=mColor%>">
					<td align=right><%=ctr%>&nbsp; &nbsp;</td>
					<td align=center><%=mdept%></td>
					<td align=center><%=rs.getString("PG")%></td>
					<td align=center><%=rs.getString("AY")%></td>
					<td align=center><%=rs.getString("SB")%></td>
					</tr>
					<%
				}
			%>
			</form>
			</TABLE>
			<%
			}
			else
			{
			%>
			<font color=red>
			<h3>	<br><img src='../../Images/Error1.jpg'> Pre- Registration Event has not been declared</FONT></P>
			<%
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
			<h3><br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
			<P>This page is not authorized/available for you.
			<br>For assistance, contact your network support team. 
			</font><br><br><br><br>
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
%><br><br><br><br><br><br>
<table ALIGN=Center VALIGN=TOP>
		<tr>
		<td valign=middle>
		<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">
		<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
		A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
		<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>  
		</td></tr></table>
</body>
</html>