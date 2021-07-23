<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
 <TITLE>#### <%=mHead%> [ View Sent SRS (Student Reaction Survey) ] </TITLE>
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
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
OLTEncryption enc=new OLTEncryption();
String qry="";
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
ResultSet rs1=null;
String qry1="",mWebEmail="";
int mSNO=0;
int mData=0;
String mMemberID="";
String mMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mmMemberName="";
String mCompanyCode="";
String mAcademicYearCode="";
String mProgramCode="";
String mBranchCode="";
String mCurrentSem="";
int mCurSem=0;
String mMS="";
String mInstituteCode="";
String mMaxSemester="";

String mSCode="";
try
{
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
	mmMemberName=GlobalFunctions.toTtitleCase(mMemberName.trim());
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
	mCompanyCode="";
}
else
{
	mCompanyCode=session.getAttribute("CompanyCode").toString().trim();
}

if (session.getAttribute("AcademicYearCode")==null)
{
	mAcademicYearCode="";
}
else
{
	mAcademicYearCode=session.getAttribute("AcademicYearCode").toString().trim();
}

if (session.getAttribute("ProgramCode")==null)
{
	mProgramCode="";
}
else
{
	mProgramCode=session.getAttribute("ProgramCode").toString().trim();
}

if (session.getAttribute("BranchCode")==null)
{
	mBranchCode="";
}
else
{
	mBranchCode=session.getAttribute("BranchCode").toString().trim();
}

if (session.getAttribute("CurrentSem")==null)
{
	mCurrentSem="";
}
else
{
	mCurrentSem=session.getAttribute("CurrentSem").toString().trim();
}

if (session.getAttribute("InstituteCode")==null)
{
	mInstituteCode="";
}
else
{
	mInstituteCode=session.getAttribute("InstituteCode").toString().trim();
}
if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
{
	try
	{			
		mDMemberCode=enc.decode(mMemberCode);
		mMemberID=enc.decode(mMemberID);
	}
	catch(Exception e)
	{
		out.println(e.getMessage());
	}

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('37','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------

%>

<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">SRS Submission Summary</TD>
</font></td></tr>
</TABLE>
<table cellpadding=1 cellspacing=0 align=center rules=groups border=3>
<tr>
 <td><FONT color=black>&nbsp; <FONT face=Arial size=2><STRONG>Name(Enrolment No.) :</STRONG></FONT>&nbsp;&nbsp;&nbsp; </FONT></td>
 <td nowrap><FONT color=black>&nbsp; <FONT face=Arial size=2><%=mmMemberName%>(<%=mDMemberCode%>)</FONT>&nbsp;&nbsp;&nbsp; </FONT></td>
 <td><FONT color=black>&nbsp; <FONT face=Arial size=2><STRONG>Program-Branch :</STRONG></FONT>&nbsp;&nbsp;&nbsp; </FONT></td>
 <td><FONT color=black>&nbsp; <FONT face=Arial size=2><%=mProgramCode%>-<%=mBranchCode%></FONT>&nbsp;&nbsp;&nbsp; </FONT></td>
 </tr>
 <tr>
 <td><FONT color=black>&nbsp; <FONT face=Arial size=2><STRONG>Academic Year :</STRONG></FONT>&nbsp;&nbsp;&nbsp; </FONT></td>
 <td><FONT color=black>&nbsp; <FONT face=Arial size=2><%=mAcademicYearCode%></FONT>&nbsp;&nbsp;&nbsp; </FONT></td>
 <td><FONT color=black>&nbsp; <FONT face=Arial size=2><STRONG>Current Semester :</STRONG></FONT>&nbsp;&nbsp;&nbsp; </FONT></td>
 <td><FONT color=black>&nbsp; <FONT face=Arial size=2><%=mCurrentSem%></FONT>&nbsp;&nbsp;&nbsp; </FONT></td>
 </tr>
 <tr> 
 <td><FONT color=black>&nbsp; <FONT face=Arial size=2><STRONG>Show SRS for Semester :</STRONG></FONT>&nbsp;&nbsp;&nbsp; </FONT></td>
 
	<%
	try
	{ 
		if (mCurrentSem.equals("")) 
		mCurSem=1;
		
		else
		mCurSem=Integer.parseInt(mCurrentSem);

		if(request.getParameter("MaxSemester")==null)
		{
			%>	
			<td><select name=MaxSemester tabindex="0" id="MaxSemester" style="WIDTH: 70px">
			<OPTION selected value=ALL>ALL</option>
			<%   
			for(int kk=1;kk<=mCurSem;kk++)
			{
			%>
			<OPTION Value =<%=String.valueOf(kk).trim()%>><%=kk%></option>
			<%
			}
			%>
			</select>
			<%
		}
		else
		{
			%>	
			 <td><select  name=MaxSemester tabindex="0" id="MaxSemester" style="WIDTH: 70px">	
			<%   

			if (request.getParameter("MaxSemester").toString().trim().equals("ALL"))
	 		{
			%>
			 <OPTION selected value=ALL>ALL</option>
			<%
			}
			else
			{
			%>
	 		 <OPTION value=ALL>ALL</option>
			<%
			}
			for(int k1=1;k1<=mCurSem;k1++)
			{
			if(String.valueOf(k1).trim().equals(request.getParameter("MaxSemester").toString().trim()))
			{ 
				mMS=String.valueOf(k1).trim();	
				%>
				<OPTION selected Value =<%=mMS%>><%=mMS%></option>
				<%			
			}
			else
			{
			%>
			<OPTION Value =<%=String.valueOf(k1).trim()%>><%=k1%></option>
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
&nbsp;&nbsp;&nbsp;&nbsp;<INPUT Type="submit" Value="Display/Refresh"></td></tr>
</table></form>
<TABLE rules=Rows cellSpacing=0 cellPadding=0 width="100%" border=1 >
<TR bgcolor="#c00000">
 <td><b><font color="white">Sem</font>&nbsp;&nbsp;</td>
 <td><b><font color="white">Subject (Sub. Code)</font></td>
 <td><b><font color="white">LTP&nbsp;&nbsp;&nbsp;</font></td>
 <td><b><font color="white">Faculty Name</font></td>
 <td align=center><b><font color="white">SRS Date</font></td>
</tr>

<%

mMS=request.getParameter("MaxSemester").toString().trim();

qry1 = "Select to_char(SEMESTER) Sem, LTP LTP, to_char(EntryDate,'dd-Mon-yyyy') EntryDate, SUBJECTID, ";
qry1 = qry1 + " Subject||'('||SubjectCode||')' Subj, EmployeeID, nvl(EMPLOYEENAME,' ') EName";
qry1 = qry1 + " From V#SRSEVENTSUGGESTION Where trim(InstituteCode)='"+mInstituteCode+"'";
qry1 = qry1 + " and STUDENTID='"+mMemberID+"' and (FSTID) IN (SELECT fstid FROM STUDENTLTPDETAIL SS WHERE STUDENTID='"+mMemberID+"'AND NVL(DEACTIVE,'N')='N' )";

qry1 = qry1 + " and to_char(SEMESTER)=Decode('"+mMS + "','ALL',to_char(SEMESTER),'"+ mMS +"') order by SEMESTER,SubjectID,EmployeeID";

//qry1 = "Select to_char(A.SEMESTER) Sem, A.LTP LTP, to_char(A.EntryDate,'dd-Mon-yyyy') EntryDate, B.Subject||'('||A.SubjectCode||')' Subj, A.EmployeeID, nvl(C.EMPLOYEENAME,' ') EName From V#SRSEVENTSUGGESTION A, SUBJECTMASTER B, EMPLOYEEMASTER C Where trim(A.InstituteCode)='"+mInstituteCode+"' And A.InstituteCode=B.InstituteCode and A.STUDENTID='"+mMemberID+"' and A.SubjectCode=B.SubjectCode and  A.EmployeeID=C.EmployeeID and to_char(A.SEMESTER)=Decode('"+mMS + "','ALL',to_char(A.SEMESTER),'"+ mMS +"')";

		rs1=db.getRowset(qry1);
		mSNO=0;
		String pSem="", pSubj="",pEmpid="",pLTP="",pEntryDate="",pEmpname="",pEmpName="";
		while(rs1.next())
		{
					 
		 if ( pSem.equals("") && pSubj.equals("") && pEmpid.equals(""))
		  {
			 pSem=rs1.getString("Sem");
			 pSubj=rs1.getString("Subj");
			 pEmpid=rs1.getString("EmployeeID");
			 pEntryDate=rs1.getString("EntryDate");
			 pEmpname=rs1.getString("EName");
			 pEmpName=GlobalFunctions.toTtitleCase(pEmpname.trim());
			 pLTP=rs1.getString("LTP");
		  }
		 else
		 {
	 
			if(pSem.equals(rs1.getString("Sem")) && pSubj.equals(rs1.getString("Subj")) && pEmpid.equals(rs1.getString("EmployeeID")))
			 {
				pLTP=pLTP+rs1.getString("LTP");
			 }
			else
			{
			 mSNO++;			
			%>
			<tr>
			 <td><%=pSem%></td>
			 <td><%=pSubj%></td>
			 <td><%=GlobalFunctions.getSordtedLTPWSQ(pLTP)%></td>
			 <td><%=pEmpName%></td>
			 <td align=center><%=pEntryDate%></td>
			</tr>
		<%
			 pSem=rs1.getString("Sem");
			 pSubj=rs1.getString("Subj");
			 pEmpid=rs1.getString("EmployeeID");
			 pEntryDate=rs1.getString("EntryDate");
			 pEmpname=rs1.getString("EName");
			 pEmpName=GlobalFunctions.toTtitleCase(pEmpname.trim());
			 pLTP=rs1.getString("LTP");
			}
		 }
		} 
if(!pSem.equals(""))	
{		 mSNO++;

%>
<tr>
 <td><%=pSem%></td> 
 <td><%=pSubj%></td>
 <td><%=GlobalFunctions.getSordtedLTPWSQ(pLTP)%></td>
 <td><%=pEmpName%></td>
 <td align=center><%=pEntryDate%></td>

</tr>
<%
}
mData=mSNO;
%>
</TABLE>
<table><tr><td align=center><font size=2><b><%=mData%></b> SRSs have been submitted </font></td></tr></table>
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
	<h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font>	<br>	<br>	<br>	<br>
   <%
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
<table ALIGN=Center VALIGN=TOP>
<tr>
	<td valign=middle><br><br>
	<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">	<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br><FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>
	</td>
</tr>
</table>
</body>
</html>