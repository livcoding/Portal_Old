<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
String mI="";
String mE="", mCh="", mch="";
String qry="";
String qry1="";
String mEmployeeID="";
String mEmployeeType="";
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInstitute="";
String mExam="";
String mexam="";
String mStatus="";
String mChoice="",mcolor="";
int kk1=0;

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

	String mHead="";
	if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
	else
	mHead="JIIT ";
%>

	<HTML>
	<head>
	<TITLE>#### <%=mHead%> [Subject Choice Submission/Not Submission ] </TITLE>
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



  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
		qry="Select WEBKIOSK.ShowLink('113','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	      RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{

		qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from PREVENTS WHERE nvl(APPROVED,'N')='N' and nvl(Deactive,'N')='N' ";
		rs=db.getRowset(qry);
		if (rs.next())
		mInstitute=rs.getString(1);
		else
		mInstitute="JIIT";
		mI=mInstitute;
		
		

	%>
	<form name="frm"  method="get">
	<input id="x" name="x" type=hidden>
	<table width="100%%" ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">Subject Choices [Submission /Not Submission] </font></td></tr>
	</TABLE>
	<table cellpadding=1 cellspacing=0 align=center rules=groups border=3>
	<!--Institute****-->
	<Input Type=hidden name=InstCode Value=<%=mInstitute%>>

	<!--*********Exam**********-->
	<tr><td><FONT color=black><FONT face=Arial size=2><STRONG>Exam Code</STRONG></FONT></FONT>
	&nbsp; &nbsp;
	<%
	qry="Select  nvl(PREREGEXAMID,' ') Exam from DEFAULTVALUES";
	rs=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
	%>
		<select name=Exam id="Exam" style="WIDTH: 120px">	
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
		<select name=Exam id="Exam" style="WIDTH: 120px">	
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
		}          //Closing of while
	%>
		</select>
<%
	 }         //closing of else
	
//--------------------------------------------------------------------------------
%>
	

	<FONT color=black><FONT face=Arial size=2><STRONG>Report Type</STRONG></FONT></FONT>
	<select name=mStatus  id="Report Type" style="WIDTH: 120px">
	<%
 	if(request.getParameter("mStatus")==null)
   	{
	%>			
		<OPTION Value=NS selected>Not Submitted</option>
		<OPTION Value=S>Submitted</option>
	<%
  	}
  	else 
  	{
		mStatus=request.getParameter("mStatus");
		if(mStatus.equals("S"))                      
		{
	%>
			<OPTION Value =S selected>Submitted</option>
			<OPTION Value =NS>Not Submitted</option>
		<%
      	}
		else if(mStatus.equals("NS") )
		{
		%>
			<OPTION Value =NS selected>Not Submitted</option>
			<OPTION Value =S>Submitted</option>
	<%
		}
    	}	
	%>
	</select>
	<INPUT Type="submit"  Value="&nbsp;OK&nbsp;"></td></tr>
	</table>
	</form>

<%
			if (request.getParameter("InstCode")!=null)
			mI=request.getParameter("InstCode").toString().trim();

			if (request.getParameter("Exam")!=null)
			mE=request.getParameter("Exam").toString().trim();
			
			if (request.getParameter("mStatus")!=null)
			mStatus=request.getParameter("mStatus").toString().trim();

	
		if(mStatus.equals("S"))
		{
			%>
			<form name="frm1"  method="post">
			<input id="y" name="y" type=hidden>
			<table cellpadding=1 cellspacing=0 align=center rules=groups border=3>
			<tr>
			<!--*********No Of Choices**********-->
			 &nbsp; <td><FONT color=black><FONT face=Arial size=2><STRONG>No of Choice</STRONG></FONT></FONT>
			
	<%

	qry="Select distinct nvl(choice,0)Choice  from PR#FACULTYSUBJECTCHOICES where nvl(DEACTIVE,'N')='N'";
	rs=db.getRowset(qry);

	if (request.getParameter("y")==null) 
	{           
		%>
			<select name="Choice"  id="Choice"  style="WIDTH: 60px">	
		<%   
		while(rs.next())
		{
			mCh=rs.getString("Choice");
			if(mch.equals(""))
 			mch=mCh;
			%>
			<OPTION Value =<%=mCh%>><%=rs.getString("Choice")%></option>
			<%
		}
		%>
		</select>
		<%
	}
	else 
	{
		%>	
		<select name="Choice" id="Choice" style="WIDTH: 60px">	
		<%
		while(rs.next())
		{
			mCh=rs.getString("Choice");
			if(mCh.equals(request.getParameter("Choice").toString().trim()))
 			{
				mch=mCh;
				%>
				<OPTION selected Value =<%=mCh%>><%=rs.getString("Choice")%></option>
				<%			
		     	}
		     	else 
		      {
				%>
		      	<OPTION Value =<%=mCh%>><%=rs.getString("Choice")%></option>
		      	<%			
		   	}
		}   //Closing of while

		%>
  

		</select>
	  	<%
	 }         


%>

	  	
			<INPUT Type="submit"  Value="&nbsp;OK&nbsp;"></td></tr>

			</table></form>

			<%
			}	
				if(mStatus.equals("S"))
				{
					if (request.getParameter("Choice")!=null)
					{
					mCh=request.getParameter("Choice").toString().trim();
					}
					else
					{
					mCh="";
					}
				%>

			<table bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=columns topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center width="100%">
			<thead>
			 <tr bgcolor="#ff8c00">
			  <td align=center><b><font color=white>Faculty</font></td>
			  <td align=center><b><font color=white>Department</font></td>
			  <td align=center><b><font color=white>Designation</font></td>
			  <td align=center><b><font color=white>No Of Choice</font></td>
			 </tr>
			</thead>
			<tbody>
			<%
			qry1="select distinct nvl(A.INSTITUTECODE,' ')INSTITUTECODE, nvl(A.EXAMCODE,' ')EXAMCODE, nvl(B.EMPLOYEENAME,' ')EMPLOYEENAME,nvl(A.FACULTYID,' ')FACULTYID,nvl(A.CHOICE,0)CHOICE ,nvl(B.DEPARTMENTCODE,' ')DEPARTMENTCODE, nvl(B.DESIGNATIONCODE,' ')DESIGNATIONCODE from prevents c ,PR#FACULTYSUBJECTCHOICES A,V#STAFFSTUDENT B";
			qry1=qry1+" where A.institutecode='"+mI+"' and A.examcode='"+mE+"' and  A.FACULTYID=B.EMPLOYEEID and A.Choice="+mCh+"";
			//out.print(qry1);
			rs1=db.getRowset(qry1);
			while(rs1.next()) 
			{
		 		kk1++;
				%>
				<tr>
				<td nowrap><font color=<%=mcolor%>>&nbsp;<%=rs1.getString("EMPLOYEENAME")%></font></td>
				<td nowrap><font color=<%=mcolor%>>&nbsp;<%=rs1.getString("DEPARTMENTCODE")%></font></td>
				<td nowrap><font color=<%=mcolor%>>&nbsp;<%=rs1.getString("DESIGNATIONCODE")%></font></td>
				<td nowrap><font color=<%=mcolor%>>&nbsp;<%=rs1.getString("CHOICE")%></font></td>
				</tr>		
				<%
			} 		//Closing of while
			
		}	//if	
	      else if(mStatus.equals("NS"))
		{
			%>
			<table bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=columns topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center width="100%">
			<thead>
			  <tr bgcolor="#ff8c00">
			  <td align=center><b><font color=white>Faculty</font></td>
			  <td align=center><b><font color=white>Department</font></td>
			  <td align=center><b><font color=white>Designation</font></td>
			  </tr>
			</thead>
			<tbody>
			<%
			qry1="select distinct nvl(B.EMPLOYEENAME,' ')EMPLOYEENAME, nvl(B.DEPARTMENTCODE,' ')DEPARTMENTCODE,nvl(B.DESIGNATIONCODE,' ')DESIGNATIONCODE ";
			qry1=qry1+" From V#STAFFSTUDENT B,PREVENTS C WHERE nvl(B.DEACTIVE,'N')='N' and nvl(C.DEACTIVE,'N')='N' and (C.MEMBERID,C.MEMBERTYPE)";
			qry1=qry1+" NOT IN (SELECT FACULTYID,FACULTYTYPE FROM PR#FACULTYSUBJECTCHOICES A where A.institutecode='"+mI+"' and A.EXAMCODE='"+mE+"' and nvl(A.DEACTIVE,'N')='N')";
			//out.print(qry1);
			rs1=db.getRowset(qry1);
			while(rs1.next()) 
			{
		 		kk1++;
				%>
				<tr>
				<td nowrap><font color=<%=mcolor%>>&nbsp;<%=rs1.getString("EMPLOYEENAME")%></font></td>
				<td nowrap><font color=<%=mcolor%>>&nbsp;<%=rs1.getString("DEPARTMENTCODE")%></font></td>
				<td nowrap><font color=<%=mcolor%>>&nbsp;<%=rs1.getString("DESIGNATIONCODE")%></font></td>
				</tr>		
				<%
			} 		//Closing of while
		}//else
	
	%>
		</tbody>
		</table>	
		<script type="text/javascript">
		var st1 = new SortableTable(document.getElementById("table-1"),["CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString"]);
		</script>
		<br><font color=Green><strong>Total Record &nbsp;:&nbsp;</strong></font><%=kk1%>

	<%
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
</body>
</html>















