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
<TITLE>#### <%=mHead%> [ View Opted Faculty  ] </TITLE>
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
OLTEncryption enc=new OLTEncryption();
String qry="",mWebEmail="",EmpIDType="",qry1="";
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
String mInst="";
int msno=0;
String mSem="";
int mSemPlusOne=0;
String mExamCode="",mexamcode="",mexam="",mProg="",mBranch="",mName="", mBasket="";
String mINSTITUTECODE="";
String mEmployeeID="";
//String mSUBJECTCODE="";
String mEName="";
ResultSet rs=null,rs1=null;
try 
{  //1

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
if (session.getAttribute("InstituteCode")==null)
{
	mINSTITUTECODE="";
}
else
{
	mINSTITUTECODE=session.getAttribute("InstituteCode").toString().trim();
}
if (session.getAttribute("ProgramCode")==null)
{
	mProg="";
}
else
{
	mProg=session.getAttribute("ProgramCode").toString().trim();
}

if (session.getAttribute("BranchCode")==null)
{
	mBranch="";
}
else
{
	mBranch=session.getAttribute("BranchCode").toString().trim();
}

if (session.getAttribute("CurrentSem")==null)
{
	mSem="";
}
else
{
	mSem=session.getAttribute("CurrentSem").toString().trim();
	mSemPlusOne=(Integer.parseInt(mSem))+0;
}

if (session.getAttribute("MemberName")==null)
{
	mName="";
}
else
{
	mName=session.getAttribute("MemberName").toString().trim();
}
if(!mMemberID.equals("") && !mMemberType.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
{  //2

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mMacAddress =" "; //session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('33','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
//out.print("1223);	
  //----------------------
	try
	{	

		mDMemberCode=enc.decode(mMemberCode);
		mMemberID=enc.decode(mMemberID);
		mMemberType=enc.decode(mMemberType);
	}
	catch(Exception e)
	{
		out.println(e.getMessage());
	}
%>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Registered Subjects Faculty for Student</b></font>
</td>
</tr>
</table>
<form name="frm" method=get>
<input id="x" name="x" type=hidden>
<table width=95%  rules=groups cellspacing=1 cellpadding=1 align=center border=1>
<tr><td>&nbsp;&nbsp;<font color=black face=arial size=2><STRONG> Name:&nbsp;</STRONG></font><%=GlobalFunctions.toTtitleCase(mName)%>[<%=mDMemberCode%>]
	&nbsp; &nbsp; &nbsp; &nbsp; <font color=black face=arial size=2><STRONG>Course/Branch:&nbsp;</STRONG></font><%=mProg%>(<%=mBranch%>)
	&nbsp; &nbsp; &nbsp; &nbsp; <font color=black face=arial size=2><STRONG>Current Sem:&nbsp;</STRONG></font><%=mSemPlusOne%>
</td></tr>

<tr><td>&nbsp;&nbsp;<font color=black face=arial size=2><STRONG>Exam Code</STRONG></font>
<%
  qry="Select nvl(examcode,' ')examcode from exammaster where institutecode='"+mINSTITUTECODE+"' and nvl(deactive,'N')='N'";
  qry=qry+" and examcode in (Select ExamCode from V#StudentLtpDetail Where studentid='"+mMemberID+"' and institutecode='"+mINSTITUTECODE+"' And nvl(deactive,'N')='N' Group By ExamCode) ";
  qry=qry+" Group By examcode Order by examcode";		
// out.print(qry);
  rs=db.getRowset(qry);
%>
	<select name=exam tabindex="0" id="exam" style="WIDTH: 140px">	
<%   	
	
  	if(request.getParameter("x")==null)
	{	
		while(rs.next())
		{
		 mexamcode=rs.getString("examcode");
	%>
		<option selected value=<%=mexamcode%>><%=mexamcode%></option>
	<%		
		}
	 }
	else
	{
	   while(rs.next())
	   {
	     mexamcode=rs.getString("examcode");			
	   if(mexamcode.equals(request.getParameter("exam").toString().trim()))
	    {	
	  %>
	    <option selected value=<%=mexamcode%>><%=mexamcode%></option>
	  <%
	     }	
         else
          {		
	   %>
	    <option  value=<%=mexamcode%>><%=mexamcode%></option>
	   <%
	    }	
	   }
       }
    %>
</select>
&nbsp; &nbsp; &nbsp; &nbsp;
<input type="submit" value="Show"></td></tr>
</table></form>
<%
    if(request.getParameter("x")!=null)     
	 mexam=request.getParameter("exam");
	else
	mexam=mexamcode;
	
%>
  <table cellspacing=0 cellpading=0 align=middle border=1>
  <tr bgcolor="#c00000" >
  <td><b><font color=white face='arial'>SNo.</font></b></td>
  <td><b><font color=white face='arial'>Subject</font></b></td>	
  <td><b><font color=white face='arial'>Faculty(Lecture)</font></b></td>
  <td><b><font color=white face='arial'>Faculty(Tutorial)</font></b></td>
    <td><b><font color=white face='arial'>Faculty(Practical)</font></b></td>
  </tr>
<%

	//qry="select ";
/*
	qry="select distinct nvl(A.SUBJECT,' ')||'('||NVL(A.SUBJECTCODE,' ')||')' SUBJECT, ";
	qry=qry+" nvl(b.COURSECREDITPOINT,0)COURSECREDITPOINT, nvl(B.BASKET,'C')BASKET";
	qry=qry+" FROM V#STUDENTSUBJECTTAGGING A, PROGRAMSUBJECTTAGGING B WHERE A.EXAMCODE='"+mexam+"' ";
	qry=qry+" and A.studentid='"+mMemberID+"' and B.institutecode='"+mINSTITUTECODE+"' and ";
	qry=qry+" nvl(B.deactive,'N')='N' and B.SUBJECTID=A.SUBJECTID AND B.INSTITUTECODE=A.INSTITUTECODE and ";
	qry=qry+" nvl(A.deactive,'N')='N' and B.BASKET=A.BASKET AND A.EXAMCODE=B.EXAMCODE ";
	//qry=qry+" B.ACADEMICYEAR=A.ACADEMICYEAR AND B.TAGGINGFOR=A.TAGGINGFOR and ";
	//qry=qry+" Group By A.SUBJECT, A.SUBJECTCODE, B.COURSECREDITPOINT, B.BASKET ";
	qry=qry+" order by basket, COURSECREDITPOINT";
*/
String mLTP="",qry3="",qry2="",mSubjectID="";
ResultSet rs2=null,rs3=null;
qry="select studentid,subjectid,nvl(SUBJECT,' ')||'('||NVL(SUBJECTCODE,' ')||')' SUBJECT  from V#StudentltpDetail where EXAMCODE='"+mexam+"' and studentid='"+mMemberID+"' and institutecode='"+mINSTITUTECODE+"' group by studentid,subjectid,SUBJECT,SUBJECTCODE having count(*)>=1 ";


	rs1=db.getRowset(qry);
	//out.print(qry);
	msno=0;
	while(rs1.next())
	{
		msno++ ;
		mSubjectID=rs1.getString("subjectid");
	%>
	   <tr>
		<td><%=msno%>.</td>	
		<td>
			<%=rs1.getString("SUBJECT")%>
		</td>

		<td>
			<%
			qry1="select distinct EMPLOYEENAME,LTP FROM V#StudentltpDetail WHERE EXAMCODE='"+mexam+"' and studentid='"+mMemberID+"' and institutecode='"+mINSTITUTECODE+"' and subjectid='"+mSubjectID+"' and nvl(deactive,'N')='N'";
			rs=db.getRowset(qry1);
			//out.print(qry1);
			while(rs.next())
			{
				mLTP=rs.getString("LTP");
				%>
				
				<%
				if(mLTP.equals("L"))
				{
				%>
					<%=rs.getString("EMPLOYEENAME")%>
				<%
				}
				else
				{
				%>
					&nbsp;
				<%
				}
							
			}
				%>
		</td>
		<td>
				<%
			qry2="select distinct EMPLOYEENAME,LTP FROM V#StudentltpDetail WHERE EXAMCODE='"+mexam+"' and studentid='"+mMemberID+"' and institutecode='"+mINSTITUTECODE+"' and subjectid='"+mSubjectID+"'  and nvl(deactive,'N')='N'";
			rs2=db.getRowset(qry2);
			//out.print(qry2);
			while(rs2.next())
			{
				
				if(rs2.getString("LTP").equals("T"))
				{
				%>
					<%=rs2.getString("EMPLOYEENAME")%>
				<%
				}
				else
				{
				%>
					&nbsp;
				<%
				}
				
			}
		%>
		</td>
		<td>
		<%
			qry3="select distinct EMPLOYEENAME,LTP FROM V#StudentltpDetail WHERE EXAMCODE='"+mexam+"' and studentid='"+mMemberID+"' and institutecode='"+mINSTITUTECODE+"' and subjectid='"+mSubjectID+"' and  nvl(deactive,'N')='N' ";
			rs3=db.getRowset(qry3);
			//out.print(qry3);
			while(rs3.next())
			{
				if(rs3.getString("LTP").equals("P"))
				{
				%>
					<%=rs3.getString("EMPLOYEENAME")%>
				<%
				}
				else
				{
				%>
					&nbsp;
				<%
				}
			}
			%>
		</td>
	   </tr>	
    <%
	}
%>
 </table>		
<%	 		        
//}					

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
    		 //-----------------------------
  }   //2
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
}	//1	
catch(Exception e)
{
	out.print(qry);
}
%>
<br>
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

