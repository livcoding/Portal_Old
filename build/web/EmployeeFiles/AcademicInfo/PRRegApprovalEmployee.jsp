<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%

/*
' *******************************************************************************************
' *													   *
' * File Name:	PRRegApprovalEmployee.jsp [For Employee]						          *
' * Author:		Ashok Kumar Singh 							           *
' * Date:		27th Nov 2006
' * Version:		1.0									   *	
' *******************************************************************************************
*/

DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
String ML="",MT="",MP="";
String mNameL="",mNameT="",mNameP="",mName1="",mName2="",mName3="",mName4="",mName5="",mName6="";
String qry="",mWebEmail="",mDisabled="";
String qry1="",mexam="";
String mSType="",mstype="";
String mMemberID="";
String mMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInst="";
String minst="";
String mPCode="",mpcode="";
String mSem="";
String msem="";
String mSubj="";
String msubj="";
String mFaculty="";
String mfaculty="";

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
%>
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Approval of Faculty Subject Choices [Pre Registration Process ]</TITLE>
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
</script>

<SCRIPT LANGUAGE="JavaScript"> 
 function un_checkL()
{
  var id='L';
  var mMax=document.frm1.elements.length;
  for (var i = 1; i <= mMax; i++) 
  {
	var objnm=id+i;
	var  obj=document.getElementById(objnm);	
	if (obj!=null && obj.name == objnm && obj.disabled==false) 
	{ 
		obj.checked = document.frm1.allboxL.checked;
	}
  } 
}

 function un_checkT()
{
  var id='T';
  var mMax=document.frm1.elements.length;
  for (var i = 1; i <= mMax; i++) 
  {
	var objnm=id+i;
	var  obj=document.getElementById(objnm);	
	if (obj!=null && obj.name == objnm && obj.disabled==false) 
	{ 
		obj.checked = document.frm1.allboxT.checked;
	}
  } 
 }

 function un_checkP()
{
  var id='P';
  var mMax=document.frm1.elements.length;
  for (var i = 1; i <= mMax; i++) 
  {
	var objnm=id+i;
	var  obj=document.getElementById(objnm);	
	if (obj!=null && obj.name == objnm && obj.disabled==false) 
	{ 
		obj.checked = document.frm1.allboxP.checked;
	}
  } 
}
 </SCRIPT>

<script>
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
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
OLTEncryption enc=new OLTEncryption();
try
{
if(!mMemberID.equals("") &&  !mMemberCode.equals("") && !mMemberName.equals("")) 
{
	try
	{	
 	    mDMemberCode=enc.decode(mMemberCode);
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

	qry="Select WEBKIOSK.ShowLink('56','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
        RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------
	
	qry1="Select nvl(PREREGEXAMID,' ') ExamID from DefaultValues";
	rs1=db.getRowset(qry1);
	if (rs1.next())
	   {
		mexam=rs1.getString(1);
	   }

		

%>

<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<tr><TD colspan=0 align=middle><font color="#0000ff" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">Approval For Faculty Subject Choice [Pre Registration Process]</TD>
</font></td></tr>
</TABLE>
<table cellpadding=2 cellspacing=0 align=center rules=groups border=1 WIDTH=100%>

<!--Institute-->
<tr><td><FONT color=black><FONT face=Arial size=2><STRONG>Institute</STRONG></FONT></FONT>
<%
try
{ 
	qry="Select Distinct NVL(INSTITUTECODE,' ') IC from InstituteMaster where nvl(Deactive,'N')='N'";
	rs=db.getRowset(qry);
	if (request.getParameter("x")==null)
	{
		%>
		<select name=ICCode tabindex="0" id="ICCode" style="WIDTH: 70px">	
		<%   
		while(rs.next())
		{
			mInst=rs.getString("IC");
			if(minst.equals(""))
 			minst=mInst;
			%>
			<OPTION selected Value =<%=mInst%>><%=mInst%></option>
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name=ICCode tabindex="0" id="ICCode" style="WIDTH: 70px">	
		<%
		while(rs.next())
		{
			mInst=rs.getString("IC");
			if(mInst.equals(request.getParameter("ICCode").toString().trim()))
 			{
				minst=mInst;
				%>
				<OPTION selected Value =<%=mInst%>><%=mInst%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mInst%>><%=mInst%></option>
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
	out.println(e.getMessage());
}
%>
<!--Program**********-->
&nbsp; &nbsp;<FONT color=black>&nbsp;<FONT face=Arial size=2><STRONG>Program</STRONG></FONT>&nbsp; </FONT>
<%
try
{ 
	qry="Select Distinct nvl(A.PROGRAMCODE,' ') PROGRAMCODE from PROGRAMMASTER A, PR#FACULTYSUBJECTCHOICES P";
	qry=qry+"  where A.ProgramCode=P.ProgramCode and P.ExamCode='"+mexam+"' and nvl(P.Deactive,'N')='N'";
	qry=qry+" and nvl(A.Deactive,'N')='N' order by PROGRAMCODE";
//	out.print(qry);
	rs=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		%>	
		<select name=Program tabindex="0" id="Program" style="WIDTH: 88px">	
		<%
		while(rs.next())
		{
			mPCode=rs.getString("PROGRAMCODE");
			if(mPCode.equals(""))
 			{
			mpcode=mPCode;
			%>
			<OPTION selected Value =<%=mPCode%>><%=mPCode%></option>
			<%			
			}
			else
			{
			%>
			<OPTION Value =<%=mPCode%>><%=mPCode%></option>
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
		<select name=Program tabindex="0" id="Program" style="WIDTH: 88px">	
		<%
		while(rs.next())
		{
			mPCode=rs.getString("PROGRAMCODE");
			if(mPCode.equals(request.getParameter("Program").toString().trim()))
 			{
				mpcode=mPCode;
				%>
				<OPTION selected Value =<%=mPCode%>><%=mPCode%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mPCode%>><%=mPCode%></option>
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
	out.println(e.getMessage());
}
%>
</td>


<!--ExamCode**************-->
<td><FONT color=black><FONT face=Arial size=2><STRONG>ExamCode</STRONG></FONT>&nbsp;</FONT>
<select name=ExamCode tabindex="0" id="ExamCode " style="WIDTH: 140px">			
<OPTION selected Value =<%=mexam%>><%=mexam%></option>
</td>
</tr>
<tr>
<!--SubjectType****-->
 <td colspan=2><FONT color=black><FONT face=Arial size=2><STRONG>Subject Type</STRONG></FONT></FONT>
<%
try
{ 
	qry="Select 'E' SCode, 'Elective' SType from dual Union Select 'C' SCode, 'Core' SType from dual order by SType Desc";
	rs=db.getRowset(qry);
	if (request.getParameter("x")==null)
	{
		%>
		<select name='SType' tabindex="0" id='SType' style="WIDTH: 80px">	
		<%   
		while(rs.next())
		{
			mSType=rs.getString("SCode");
			if(mstype.equals(""))
 			mstype=mSType;
			%>
			<OPTION selected Value =<%=mSType%>><%=rs.getString("SType")%></option>
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name='SType' tabindex="0" id='SType' style="WIDTH: 80px">	
		<%
		while(rs.next())
		{
			mstype=rs.getString("SCode");
			if(mstype.equals(request.getParameter("SType").toString().trim()))
 			{
				%>
				<OPTION selected Value=<%=mstype%>><%=rs.getString("SType")%></option>
				<%			
		     	}
		     	else
		      {
				%>
				<OPTION Value=<%=mstype%>><%=rs.getString("SType")%></option>		      	
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
   out.println(e.getMessage());
}
%>
<!--SUBJECT**************-->
&nbsp; &nbsp; &nbsp; <FONT color=black><FONT face=Arial size=2><STRONG>Subject</STRONG></FONT></FONT>
<%
try
{ 
	qry1="Select Distinct P.SUBJECTID SubjectID, S.SUBJECTCODE SubjectCode, nvl(S.Subject,' ')||' ['||P.SUBJECTCODE||']' Subj from PR#FACULTYSUBJECTCHOICES P, SubjectMaster S where nvl(P.SELECTEDSUBJECT,'N')='N' ";
	qry1=qry1+" and nvl(P.Deactive,'N')='N' and nvl(S.Deactive,'N')='N' and P.subjectid=S.SubjectID and P.ExamCode='"+mexam+"' and FSTIDGENERATED is null order by Subj";
//	out.print(qry1);
	rs1=db.getRowset(qry1);
	if (request.getParameter("x")==null) 
	{
		%>
		<select name='Subject' tabindex="0" id="Subject" style="WIDTH: 380px">	
		<%   
		while(rs1.next())
		{
			mSubj=rs1.getString("SubjectID");
			if(mSubj.equals(""))
 			{msubj=mSubj;
			%>
			<OPTION selected Value =<%=mSubj%>><%=rs1.getString("Subj")%></option>
			<%			
			}
			else
			{	
			%>
			<OPTION Value =<%=mSubj%>><%=rs1.getString("Subj")%></option>
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
		<select name='Subject' tabindex="0" id="Subject" style="WIDTH: 380px">	
		<%
	
		while(rs1.next())
		{
			mSubj=rs1.getString("SubjectID");
			if(mSubj.equals(request.getParameter("Subject").toString().trim()))
 			{
				msubj=mSubj;
				%>
				<OPTION selected Value =<%=mSubj%>><%=rs1.getString("Subj")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mSubj%>><%=rs1.getString("Subj")%></option>
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
	out.println(e.getMessage());
}
%>
</td>
</tr>
<tr>
<!--Faculty***********-->
 <td><FONT color=black><FONT face=Arial size=2><STRONG>Faculty</STRONG></FONT></FONT>
<%
try
{ 
	qry="select Distinct nvl(A.EMPLOYEEID,' ') EMPLOYEEID,nvl(A.EMPLOYEENAME,' ') EMPLOYEENAME from v#Staff A , PR#FACULTYSUBJECTCHOICES B";
	qry=qry +" Where A.EmployeeID=B.FacultyID and B.ExamCode='"+mexam+"' and nvl(B.SELECTEDSUBJECT,'N')='N' and nvl(B.Deactive,'N')='N' and nvl(A.Deactive,'N')='N'";
	qry=qry +" and B.FSTIDGENERATED is null order by EMPLOYEENAME ";

	rs=db.getRowset(qry);
	if (request.getParameter("x")==null)
	{
		%>
		<select name=Faculty tabindex="0" id="Faculty" style="WIDTH: 275px">	
		<OPTION Value=ALL selected>ALL</option>

		<%   
		while(rs.next())
		{
			mFaculty=rs.getString("EMPLOYEEID");
			%>
			<OPTION Value =<%=mFaculty%>><%=rs.getString("EMPLOYEENAME")%></option>
			<%			

		  }
	  
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name=Faculty tabindex="0" id="Faculty" style="WIDTH: 275px">	
		<%
		if(request.getParameter("Faculty").toString().trim().equals("ALL"))
 			{
				%>
				<OPTION selected Value =ALL>ALL</option>
				<%			
		     	}
		     	else
		      {
				%>
		      		<OPTION Value =ALL>ALL</option>
		      	<%			
		   	}
		while(rs.next())
		{
			mFaculty=rs.getString("EMPLOYEEID");
			if(mFaculty.equals(request.getParameter("Faculty").toString().trim()))
 			{
				mfaculty=mFaculty;
				%>
				<OPTION selected Value =<%=mFaculty%>><%=rs.getString("EMPLOYEENAME")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mFaculty%>><%=rs.getString("EMPLOYEENAME")%></option>
		      	<%			
		   	}
		}
	}
}
catch (Exception e)
{
	out.print(e.getMessage());
}
		%>
		</select>
		</td>
	
	
<!--Semester**********-->
 <td><FONT color=black><FONT face=Arial size=2><STRONG>Semester</STRONG></FONT></FONT>
<%
	qry="select Distinct Semester from PR#FACULTYSUBJECTCHOICES  Where nvl(SELECTEDSUBJECT,'N')='N'";
	qry=qry+" and nvl(Deactive,'N')='N' and FSTIDGENERATED is null and ExamCode='"+mexam+"' order by 1 ";
	rs=db.getRowset(qry);
	if (request.getParameter("x")==null)
	{
		%>
		<select name=Semester tabindex="0" id="Semester" style="WIDTH: 80px">	
		<%   
		
		while(rs.next())
		{
		    if(mSem.equals(""))			
			{
			%>
			<OPTION Selected Value =<%=rs.getString("Semester")%>><%=rs.getString("Semester")%></option>
			<%			
			}
			else
			{
			%>
			<OPTION Value =<%=rs.getString("Semester")%>><%=rs.getString("Semester")%></option>
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
		<select name=Semester tabindex="0" id="Faculty" style="WIDTH: 80px">	
		<%
		while(rs.next())
		{
			mSem=rs.getString("SEMESTER");
			if(mSem.equals(request.getParameter("Semester").toString().trim()))
 			{
		 	    %>
				<OPTION selected Value =<%=mSem%>><%=rs.getString("Semester")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mSem%>><%=rs.getString("Semester")%></option>
		      	<%			
		   	}
		}
		%>
		</select>
	  	<%
	 }
%> 
<INPUT Type="submit" Value="Show/Refresh"></td></tr>
</form></table>
<TABLE  cellSpacing=0 cellPadding=0 width="100%" border=1 rules=groups>
<form name=frm1 action="PRRegApprovalActionEmp.jsp" method=post>
<tr bgcolor='#c00000'>
 <td><b><font color=white>Sno</font></td>
 <td><b><font color=white>Faculty Name</font></td>
 <td><b><font color=white>Sem</font></td>
 <td><b><font color=white>Section Branch</font></td>
 <td><b><font color=white size=2><input onClick="un_checkL()" type="checkbox" id='allboxL' name='allboxL' value='Y'>(L Type) All</font></td>
 <td><b><font color=white size=2><input onClick="un_checkT()" type="checkbox" id='allboxT' name='allboxT' value='Y'>(T Type) All</font></td>
 <td><b><font color=white size=2><input onClick="un_checkP()" type="checkbox" id='allboxP' name='allboxP' value='Y'>(P Type) All</font></td>
</tr>
 <%
//------------------  

if(request.getParameter("x")!=null)
{
msubj=request.getParameter("Subject").toString().trim();

mfaculty=request.getParameter("Faculty").toString().trim();
mpcode=request.getParameter("Program").toString().trim();
mexam=request.getParameter("ExamCode").toString().trim();
minst=request.getParameter("ICCode").toString().trim();
mSType=request.getParameter("SType").toString().trim();
mSem=request.getParameter("Semester").toString().trim();
int mCounter=0;

qry="select decode(LTP,'L',1,'T',2,3) LTPSNO, nvl(SELECTEDSUBJECT,'N') SELECTEDSUBJECT, F.FacultyType, F.FacultyID EmployeeID, V.EmployeeCode, V.EmployeeName,F.SECTIONBRANCH, F.SEMESTER, F.SUBJECTID, F.LTP, F.CHOICETYPE ";
qry=qry+" from PR#FACULTYSUBJECTCHOICES F, V#Staff V Where V.EmployeeID=F.FacultyID and V.EMPLOYEETYPE=F.FacultyType ";
qry=qry+" and F.ProgramCode='"+mpcode+"' and F.ExamCode='"+mexam+"'";
qry=qry+" and F.InstituteCode='"+minst+"' and F.CHOICETYPE='"+mSType+"'";
qry=qry+" and F.Semester='"+mSem+"' and F.Subjectid='"+msubj+"' and F.FacultyID=Decode('"+mfaculty+"','ALL',F.FacultyID,'"+mfaculty+"')";
qry=qry+" and nvl(F.Deactive,'N')='N' and nvl(V.Deactive,'N')='N' order by EmployeeName,EmployeeID,SEMESTER,SECTIONBRANCH,SubjectID,LTPSNO";
String x="",y="",z="";
long c=0;

rs=db.getRowset(qry);

while (rs.next())
{
	
	if(x.equals("") || !x.equals(rs.getString("EmployeeID")) || !y.equals(rs.getString("SECTIONBRANCH")) || !z.equals(rs.getString("SEMESTER")))
	{
		
	  if(!x.equals(""))
	   {	
		if(MT.equals(""))
		{	
		MT="T";
		%>
		<td align=center>-</td>
		<%
		}

		if(MP.equals(""))
		{	
		MP="P";
		%>
		<td align=center>-</td>
		<%
		}
		%>
			</tr>
		<%
		}
		x=rs.getString("EmployeeID");
		y=rs.getString("SECTIONBRANCH");
		z=rs.getString("SEMESTER");
		c++;
		ML="";
		MT="";
		MP="";
		mName1="FACID"+c;
		mName2="FACTYPE"+c;
		mName3="SUBJECTID"+c;
		mName4="SUBJTYPE"+c;
		mName5="SEM"+c;
		mName6="SECBRANCH"+c;
	%>
	 	<tr><td><%=c%></td><td><%=rs.getString("EmployeeName")%></td><td><%=rs.getString("SEMESTER")%></td><td><%=rs.getString("SECTIONBRANCH")%></td>		

		<INPUT type=hidden value=<%=rs.getString("EmployeeID")%> name=<%=mName1%> id=<%=mName1%>>
		<INPUT type=hidden value=<%=rs.getString("FACULTYTYPE")%> name=<%=mName2%> id=<%=mName2%>>
		<INPUT type=hidden value=<%=rs.getString("SUBJECTID")%> name=<%=mName3%> id=<%=mName3%>>
		<INPUT type=hidden value=<%=rs.getString("CHOICETYPE")%> name=<%=mName4%> id=<%=mName4%>>
		<INPUT type=hidden value=<%=rs.getString("SECTIONBRANCH")%> name=<%=mName5%> id=<%=mName5%>>
		<INPUT type=hidden value=<%=rs.getString("SECTIONBRANCH")%> name=<%=mName6%> id=<%=mName6%>>
	<%
	}
	mDisabled=" ";
      if(rs.getString("SELECTEDSUBJECT").equals("Y"))
	   {
		mDisabled="Checked Disabled";
	    }

	if(rs.getString("LTP").equals("L"))
	{	  
		mNameL="L"+c;
		ML="L";
		%>
		<TD><input <%=mDisabled%> type=CheckBox Name=<%=mNameL%> id=<%=mNameL%> Value='Y'>Approve(L)</TD>		
		<%	
	}
	else if(rs.getString("LTP").equals("T"))
	{
		mNameT="T"+c;
		MT="T";
		if(ML.equals(""))
		{	
		ML="L";
		%>
		<td align=center>-</td>
		<%
		}
		%>
		<TD><input <%=mDisabled%>  type=CheckBox Name=<%=mNameT%> id=<%=mNameT%> Value='Y'>Approve(T)</TD>
		<%
	}
	else if(rs.getString("LTP").equals("P"))
	{
		mNameP="P"+c;
		MP="P";
		if(ML.equals(""))
		{
		%>
		<td align=center>-</td>
		<%
		}
		if(MT.equals(""))
		{
		MT="T";
		%>
		<td align=center>-</td>
		<%
		}
		%>	
		<TD><input <%=mDisabled%> type=CheckBox Name=<%=mNameP%> id=<%=mNameP%> Value='Y'>Approve(P)</TD>		
		<%
	}
  }  
	if(!x.equals(""))
		{
		if(MT.equals(""))
		{	
		MT="T";
		%>
		<td align=center>-</td>
		<%
		}
	
		if(MP.equals(""))
		{	
		MP="P";
		%>
		<td align=center>-</td>
		<%
		}
	
		%>
			</tr>
		<INPUT type=hidden id=mExamCode name=mExamCode value=<%=minst%>>
		<INPUT type=hidden id=mInstCode name=mInstCode value=<%=mexam%>>
		<tr><td colspan=7 align=Right><hr><input Type="Submit" Value="Approv Subject Now"></td></tr>
		<%
		}
	
		%>
</form>
</TABLE>

<%

}
//----------

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