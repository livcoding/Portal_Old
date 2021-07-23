<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%

/*
' *******************************************************************************************
' *													   *
' * File Name:	PRRegApprovalActionEmp.jsp [For Employee]						          *
' * Author:		Ashok Kumar Singh 							           *
' * Date:		29th Nov 2006
' * Version:	1.0									   *	
' *******************************************************************************************
*/
DBHandler db=new DBHandler();
ResultSet rs=null;
String mNameL="",mNameT="",mNameP="",mName1="",mName2="",mName3="",mName4="",mName5="",mName6="";
String qry="",mWebEmail="",mDisabled="",mexam="";
String mstype="",	memsecbranch="";
String mMemberID="";
String mMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String minst="";
String mpcode="";
String msem="";
String msubj="";
String msubj="";
String mempid="";
String memptype="";

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

if (session.getAttribute("mExamCode")==null)
{
	mexam="";
}
else
{
	mexam=session.getAttribute("mExamCode").toString().trim();
}

if (session.getAttribute("mInst")==null)
{
	minst="";
}
else
{
	minst=session.getAttribute("mInst").toString().trim();
}


String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Approval Status of Faculty Subject Choices (Pre Registration Process) ] </TITLE>



<script>
if(window.history.forward(1) != null)
window.history.forward(1);
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
	%>
	<TABLE  cellSpacing=0 cellPadding=0 width="100%" border=1 rules=groups>
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
	if(request.getParameter("x")!=null)
	{

	mName1="FACID"+c;

	mName2="FACTYPE"+c;

	mName3="SUBJECTID"+c;

	mName4="SUBJTYPE"+c;

	mName5="SEM"+c;

	mName6="SECBRANCH"+c;

	mempid=request.getParameter(mName1);
	memptype=request.getParameter(mName2);
	msubj=request.getParameter(mName3);
	msubjtype=request.getParameter(mName4);
	msem=request.getParameter(mName5);
	memsecbranch=request.getParameter(mName6);
	qry="select LTP, nvl(SELECTEDSUBJECT,'N') SELECTEDSUBJECT F Where FacultyID=='"+mempid+"' and F.FacultyType='"++"'";
	qry=qry+" and F.ProgramCode='"+mpcode+"' and F.ExamCode='"+mexam+"'";
	qry=qry+" and F.InstituteCode='"+minst+"' and F.CHOICETYPE='"+mstype+"'";
	qry=qry+" and F.Semester='"+msem+"' and F.SUBJECTID='"+msubj+"' and nvl(F.Deactive,'N')='N'";	
	rs=db.getRowset(qry);


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