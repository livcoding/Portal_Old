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
<TITLE>#### <%=mHead%> [ Student listing by their SGPA/CGPA ] </TITLE>
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
-->
</SCRIPT>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="",mInst="",mDMemberID="";
String mExam="",mexam="",qry="",mField="",mSubj="",msubj="";
int ctr=0;
double mValue1=0, mValue2=0;
String mSValue1="", mSValue2="";
ResultSet rs=null,RsChk1=null;
String mlistorder="",mctr="",mExamID="",mFieldName ="";	
String mIC="",mSC="",mEC="", mList="",mOrder="";

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
 
 
	OLTEncryption enc=new OLTEncryption();
try{
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
	{
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);
		mDMemberID=enc.decode(mMemberID);
		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		RsChk1=null;

		  //-----------------------------
		  //-- Enable Security Page Level  
		  //-----------------------------
		qry="Select WEBKIOSK.ShowLink('66','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      	RsChk1= db.getRowset(qry);
		if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
		   {
		  //----------------------


	
%>
	<form name="frm"  method="get" >
	<input id="x" name="x" type=hidden>
	<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">Subject cum SGPA/CGPA wise Students list</TD>
	</font></td></tr>
	</TABLE>

	<table cellpadding=1 cellspacing=0 align=center rules=groups border=1>
	<!--Institute****-->
	<%  
	qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from institutemaster WHERE nvl(Deactive,'N')='N' ";
	rs=db.getRowset(qry);
	if (rs.next())
	{
	mInst=rs.getString("InstCode");
	}
	else
	mInst="";
%>
<Input name="InstCode" Type=Hidden id="InstCode" Value=<%=mInst%>>	

<!--*********Exam**********-->
<tr><td>
&nbsp;&nbsp;<FONT color=black><FONT face=Arial size=2><STRONG>Exam Code</STRONG></FONT></FONT>
<%  
	try
	{
		qry="select distinct nvl(ExamCode,' ') GRADEENTRYEXAMID,examperiodfrom FROM ExamMaster A where nvl(Deactive,'N')='N' and Exists (Select ExamCode From STUDENTRESULTDETAIL#Pub B Where B.ExamCode=A.ExamCode and RowNum<=1) order by examperiodfrom  desc "; 
		//out.print(qry);
		rs=db.getRowset(qry);
		if (request.getParameter("x")==null)
		{
			%>
			<select name=Exam tabindex="0" id="Exam" style="WIDTH: 130px">	
			<%
			while(rs.next())
			{
			mExamID=rs.getString("GRADEENTRYEXAMID");
			if(mEC.equals(""))
 			{			
				mEC=mExamID;
				%>
				<OPTION Selected Value =<%=mExamID%>><%=mExamID%></option>
				<%
			}
			else
			{
				%>
				<option value=<%=mExamID%>><%=mExamID%></option>
				<%
			}
			}
			%>
			</select>
			<%
		}
	else
	{
		%>	
			<select name=Exam tabindex="0" id="Exam" style="WIDTH: 130px">	
		<%
			while(rs.next())
			{
				mExamID=rs.getString("GRADEENTRYEXAMID");
				if(mExamID.equals(request.getParameter("Exam").toString().trim()))
 				{
				%>
					<OPTION selected Value =<%=mExamID%>><%=mExamID%></option>
				<%			
			     	}
			     	else
		      	{
				%>
		      		<OPTION Value =<%=mExamID%>><%=mExamID%></option>
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
	    //out.println(e.getMessage());
	}
%>
</td>
<td>
<!--SUBJECT**************-->
<FONT color=black><FONT face=Arial size=2><STRONG>Subject</STRONG></FONT></FONT>
<%
	try
	{
	qry="select subject ||' ( '||subjectCode||' )' subject,subjectID from SubjectMaster ";
	qry=qry+" where SubjectID in (select SUBJECTID From STUDENTRESULT#Pub GROUP BY SUBJECTID)";  
	qry=qry+" and nvl(Deactive,'N')='N' ";//GROUP BY subject ||' ( '||subjectID||' )' ,subjectID";	
	rs=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		%>
		<select name=Subject tabindex="0" id="Subject" style="WIDTH: 370px">	
		<OPTION Value=ALL>ALL</option>
		<%   
		while(rs.next())
		{
			mSubj=rs.getString("SubjectID");
			if(msubj.equals(""))
 			msubj=mSubj;
			%>
			<OPTION Value =<%=mSubj%>><%=rs.getString("Subject")%></option>
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name=Subject tabindex="0" id="Subject" style="WIDTH: 370px">	
		<%
		if(request.getParameter("Subject").toString().trim().equals("ALL"))
			{
			%>
			<OPTION Selected Value=ALL>ALL</option>
			<%
			}
		else
			{
			%>
			<OPTION Value=ALL>ALL</option>
			<%
			}
		while(rs.next())
		{
			mSubj=rs.getString("SubjectID");
			if(mSubj.equals(request.getParameter("Subject").toString().trim()))
 			{
				msubj=mSubj;
				%>
				<OPTION selected Value =<%=mSubj%>><%=rs.getString("Subject")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mSubj%>><%=rs.getString("Subject")%></option>
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
</td>
</tr>
<!--Criteria Field-->
<tr><td colspan=2><FONT color=black><FONT face=Arial size=2><STRONG>&nbsp;&nbsp;Apply Criteria on </STRONG></FONT></FONT>
<select name=DBField tabindex="0" id="DBField" style="WIDTH: 110px">
<% 	if(request.getParameter("DBField")==null)
   	{
 %>			
	<OPTION Value =EarnedCredit selected>Earned Credit</option>
	<OPTION Value =SGPAPOINTS>SGPA Points</option>
	<OPTION Value =CGPAPOINTS>CGPA Points</option>
<%
  	} 
  else
   {
	mlistorder=request.getParameter("DBField");
	if(mlistorder.equals("EarnedCredit"))
	{
%>
	<OPTION Value =EarnedCredit selected>Earned Credit</option>
	<OPTION Value =SGPAPOINTS>SGPA Points</option>
	<OPTION Value =CGPAPOINTS>CGPAPoints</option> 
<%
      }
	else if(mlistorder.equals("SGPAPOINTS"))
	{
	%>
		<OPTION Value =EarnedCredit >Earned Credit</option>
		<OPTION Value =SGPAPOINTS selected>SGPA Points</option>
		<OPTION Value =CGPAPOINTS>CGPA Points</option> 
	<%		
	}
	else if(mlistorder.equals("CGPAPOINTS"))
	{
	%>
		<OPTION Value =EarnedCredit >Earned Credit</option>
		<OPTION Value =SGPAPOINTS>SGPA Points</option>
		<OPTION Value =CGPAPOINTS selected >CGPA Points</option> 
	<%		
	}

    }		
%>
</select>
<%
	if(request.getParameter("mValue1")==null||request.getParameter("mValue1").toString().trim().equals(""))
		mSValue1="";
	else
		mSValue1=request.getParameter("mValue1").toString().trim();

	if (request.getParameter("mValue2")==null||request.getParameter("mValue2").toString().trim().equals(""))
		mSValue2="";
	else
		mSValue2=request.getParameter("mValue2").toString().trim();
%>


&nbsp;&nbsp;&nbsp;
<FONT color=black><FONT face=Arial size=2><STRONG>Criteria Value from <input Type="Text" Value="<%=mSValue1%>" id=mValue1 Name=mValue1 style="WIDTH: 70px; height: 20px;" maxlength=7 >
 To <input Type="Text" Value="<%=mSValue2%>" id=mValue2 Name=mValue2 style="WIDTH: 70px; height: 20px;" maxlength=7 >
</strong></font></font></td></tr>
<tr><td colspan=2>&nbsp;
<FONT color=black><FONT face=Arial size=2><STRONG>List order in </STRONG></FONT></FONT>
<select name=listorder tabindex="0" id="listorder" style="WIDTH: 120px">
<% 	if(request.getParameter("listorder")==null)
   	{
 %>			
	<OPTION Value =Enrollmentno selected>Enrollment no.</option>
	<OPTION Value =Studentname>Student Name</option>
	<OPTION Value =CF >Criteria Field</option>
<%
  	}
  else
   {
	mlistorder=request.getParameter("listorder");
	if(mlistorder.equals("Enrollmentno"))
	{
%>
	<OPTION Value =Enrollmentno selected>Enrollment no.</option>
	<OPTION Value =Studentname >Student Name</option>
	<OPTION Value =CF >Criteria Field</option> 
<%
      }
	else if(mlistorder.equals("Studentname"))
	{
	%>
		<OPTION Value =Enrollmentno >Enrollment no.</option>
		<OPTION Value =Studentname selected>Student Name</option>
		<OPTION Value =CF >Criteria Field</option> 
	<%		
	}
	else if(mlistorder.equals("CF"))
	{
	%>
		<OPTION Value =Enrollmentno >Enrollment no.</option>
		<OPTION Value =Studentname >Student Name</option>
		<OPTION Value =CF selected >Criteria Field</option> 
	<%		
	}

    }		
%>
</select>
<select name=order tabindex="0" id="order" style="WIDTH: 105px">	

<% 	if(request.getParameter("order")==null)
   	{
 %>			
	<OPTION Value =Asc selected>Ascending</option>
	<OPTION Value =Desc>Descending</option>

<%
  	}
  else
   {
	mlistorder=request.getParameter("order");
	if(mlistorder.equals("Asc"))
	{
%>
	<OPTION Value =Asc selected>Ascending</option>
	<OPTION Value =Desc>Descending</option>

<%
      }
	else 
	{
	%>
		<OPTION Value =Asc >Ascending</option>
		<OPTION Value =Desc selected>Descending</option>

	<%		
	}
    }		
%>



</select>
<INPUT Type="submit" Value="Submit"></td></tr>
		</table></form>
	<%	
	if(request.getParameter("x")!=null)
	  {
	     if( request.getParameter("Subject")!=null && request.getParameter("Exam")!=null && request.getParameter("InstCode")!=null)
		  {
			mIC=request.getParameter("InstCode").toString().trim();
			mEC=request.getParameter("Exam").toString().trim();
			mSC=request.getParameter("Subject").toString().trim();
			mList=request.getParameter("listorder").toString().trim();
			mOrder=request.getParameter("order").toString().trim();
			mField=request.getParameter("DBField").toString().trim();		
			
			if(mList.equals("CF"))
				mList=mField;


			if(request.getParameter("mValue1").toString().trim().equals(""))
				mValue1=0;
			else
				mValue1=Double.parseDouble(request.getParameter("mValue1").toString().trim());

			if (request.getParameter("mValue2").toString().trim().equals(""))
				mValue2=-1;
			else	
				mValue2=Double.parseDouble(request.getParameter("mValue2").toString().trim());

			if (mValue2>=0)
			{	
				qry="select nvl(StudentName,' ') StudentName, nvl(EnrollmentNo,' ') EnrollmentNo,nvl(c.SUBJECTcode,' ') Subj, nvl(GRADE,' ') GRADE, nvl(GRADEPOINT,0) GRADEPOINT , ";
				qry=qry+" nvl(COURSECREDITPOINT,0) COURSECREDITPOINT, nvl(EARNEDCREDIT,0) EARNEDCREDIT, nvl(SGPAPOINTS,0) SGPAPOINTS, nvl(CGPAPOINTS,0) CGPAPOINTS, nvl(FAIL,' ') Fail";
				qry=qry+"  from STUDENTRESULTDETAIL#Pub A, StudentMaster B, SUBJECTMASTER C  Where A.StudentID=b.StudentID and  A.InstituteCode=b.InstituteCode   ";
				qry=qry+" and A.institutecode='"+mIC+"' and A.ExamCode='"+mEC+"' and subjectID=Decode('"+mSC+"','ALL',subjectID,'"+mSC+"')"; 
				qry=qry+" and  A.institutecode=c.institutecode and a.fstid in (select fstid from facultysubjecttagging where institutecode='"+mIC+"' and examcode='"+mEC+"' and subjectID=Decode('"+mSC+"','ALL',subjectid,'"+mSC+"'))";
				qry=qry+" and A."+mField+ " Between "+mValue1 +" and "+mValue2 +" order by "+mList +"   "+mOrder+" ,subjectcode,enrollmentno ";
			}
			else
			{
				qry="select nvl(StudentName,' ') StudentName, nvl(EnrollmentNo,' ') EnrollmentNo,nvl(c.SUBJECTCODE,' ') Subj, nvl(GRADE,' ') GRADE, nvl(GRADEPOINT,0) GRADEPOINT , ";
				qry=qry+" nvl(COURSECREDITPOINT,0) COURSECREDITPOINT, nvl(EARNEDCREDIT,0) EARNEDCREDIT, nvl(SGPAPOINTS,0) SGPAPOINTS, nvl(CGPAPOINTS,0) CGPAPOINTS, nvl(FAIL,' ') Fail";
				qry=qry+"  from STUDENTRESULTDETAIL#PUB A, StudentMaster B, SUBJECTMASTER C Where A.StudentID=b.StudentID and  A.InstituteCode=b.InstituteCode   ";
				qry=qry+" and A.institutecode='"+mIC+"' and A.examcode='"+mEC+"' and subjectid=Decode('"+mSC+"','ALL',subjectid,'"+mSC+"')";
				qry=qry+" and  A.institutecode=c.institutecode and a.fstid in (select fstid from facultysubjecttagging where institutecode='"+mIC+"' and examcode='"+mEC+"' and subjectID=Decode('"+mSC+"','ALL',subjectid,'"+mSC+"'))";
				qry=qry+" and A."+mField+ " >="+mValue1 +" order by "+mList +"   "+mOrder+" , subjectcode,enrollmentno ";

			}
			//out.print(qry);
			rs=db.getRowset(qry);
			%>
			<table cellspacing=0 cellpadding=0 width=125% border=1 align=center>
			<form name="frm1"  method="post">
			<tr bgcolor="#c00000">
			<td><b><font color=white>SNo.</font></b></td>
			<td nowrap><b><font color=white>Enroll. No</font></b></td>
			<td nowrap><b><font color=white>Student name</font></b></td>
			<td><b><font color=white>Grade</font></b></td>
			<td><b><font color=white>Grade Points</font></b></td>
			<td><b><font color=white>Course Credit<font></b></td>
			<td><b><font color=white>Earned Credit<font></b></td>
			<td><b><font color=white>SGPA<font></b></td>
			<td><b><font color=white>CGGPA<font></b></td>
			<td><b><font color=white>Subject</font></b></td>
			</tr>	
			<%
			while (rs.next())
			{
				ctr++;
				mctr=String.valueOf(ctr).trim();				    	
				if(ctr%2==0)
				{
				%>
				<tr bgcolor="white">
				<%
				}
				else
				{
				%>
				<tr bgcolor="#F1F1F1">
				<%
				}
				%>
				<td><%=ctr%></td>
				<td NoWrap><%=rs.getString("EnrollmentNo")%></td>
				<td NoWrap><%=GlobalFunctions.toTtitleCase(rs.getString("StudentName"))%></td>
				<td><%=rs.getString("GRADE")%></td>
				<td><%=rs.getDouble("GRADEPOINT")%></td>
				<td><%=rs.getDouble("COURSECREDITPOINT")%></td>
				<td><%=rs.getDouble("EARNEDCREDIT")%></td>
				<td><%=rs.getDouble("SGPAPOINTS")%></td>
				<td><%=rs.getDouble("CGPAPOINTS")%></td>	
				<td><%=rs.getString("Subj")%></td>
				</tr>
				<%
			}
			%>
			</table>	
			<%
			}
			else
			{
				out.print("<br><img src='../../Images/Error1.jpg'>");
				out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Mandatory items(Subject,ExamCode,etc.) must be entered. </font> <br>");
			}
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