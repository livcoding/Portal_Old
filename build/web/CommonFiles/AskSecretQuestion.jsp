<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%  
String qry="",mWebEmail="";
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();

GlobalFunctions gb =new GlobalFunctions();

ResultSet rs=null, Rs=null;

String mMemberID="",mMemberType="",mMemberCode="",mCurDate="";
String mEmpName="",mCompCode="",mInst="",mEmpcode="";
String 	mQuestion="",mQType="",mOtherQues="",mAnsQ="",mSID="";
String mGuestName="",mGuestID="",mStudName="",mEnroll="";

try
{
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
	mCompCode="";
}
else
{
	mCompCode=session.getAttribute("CompanyCode").toString().trim();
}
//System.out.println(mCompCode);

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

if (session.getAttribute("WebAdminEmail")==null)
{
	 mWebEmail="";
}	 
else
{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
}

if (session.getAttribute("InstituteCode")==null)
{
    mInst="";
}
else
{
    mInst=session.getAttribute("InstituteCode").toString().trim();
}

if(request.getParameter("SID")==null ||request.getParameter("SID").toString().trim().equals(""))
	mSID="";
else
   	mSID=request.getParameter("SID").toString().trim();

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Secret Question] </TITLE>
<script language="JavaScript">
function disableText()
	{
   	var mQuestion;
	mQuestion=document.getElementById("Question").value;
	if(mQuestion!='OTHERS')
	{
	document.getElementById("OtherQ").disabled=true;
	}
	if(mQuestion=='OTHERS')
	{
	document.getElementById("OtherQ").disabled=false;
	}
	}

</script>
<script language="JavaScript">
   function validate()
	{
	var answer;
	var question;
	question=document.getElementById("OtherQ").value;
	answer=document.getElementById("AnsQ").value;
	question=trim(question);
	answer=trim(answer);
	if(question=="")
		{
	document.frm.OtherQ.focus();
	alert("Please, provide appropriate Question.You can't leave this field blank!");
	return false;
		}
	if(answer=="")
		{
		document.frm.AnsQ.focus();
	alert("Please, provide appropriate answer.You can't leave this field blank!");
	return false;
		}
		return true;
	}
	// Removes leading whitespaces
function LTrim( value ) {
	
	var re = /\s*((\S+\s*)*)/;
	return value.replace(re, "$1");
	
}

// Removes ending whitespaces
function RTrim( value ) {
	
	var re = /((\s*\S+)*)\s*/;
	return value.replace(re, "$1");
	
}

// Removes leading and ending whitespaces
function trim( value ) {
	
	return LTrim(RTrim(value));
	
}


	</script>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
</head>
<body  topmargin=4 rightmargin=0 leftmargin=0 bottommargin=0 bgColor="#fce9c5" onload="disableText();">
<% 
if(!mMemberID.equals("") || !mMemberCode.equals(""))
{
mMemberID=enc.decode(mMemberID);
mMemberCode=enc.decode(mMemberCode);
	
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;

if(mChkMType.equals("E"))
		{	
		qry="SELECT COMPANYCODE,EMPLOYEENAME,EMPLOYEECODE FROM EMPLOYEEMASTER where EMPLOYEEID='"+mChkMemID+"' and COMPANYCODE='"+mCompCode+"' ";
		//out.println(qry);
		rs=db.getRowset(qry);
		if(rs.next())
		   {
			mEmpName=rs.getString("EMPLOYEENAME");
			mEmpcode=rs.getString("EMPLOYEECODE");
		   }
		%>
		<p align=center><font color="black" face="Verdana"size=3><b>Employee Name<b></font>&nbsp;
				<font color="#a52a2a" face="Verdana" size=3><%=mEmpName%></font>&nbsp;
				<font color="black" face="Verdana" size=3><b>Employee Code<b></font>
				<font color="#a52a2a" face="Verdana" size=3><%=mEmpcode%></font>&nbsp;
		</p>
		<%
		}
		else if(mChkMType.equals("G"))
		{	
		qry="SELECT GUESTID, GUESTNAME FROM GUEST where GUESTID='"+mChkMemID+"' and COMPANYCODE='"+mCompCode+"' ";
		rs=db.getRowset(qry);
		if(rs.next())
			{
			mGuestName=rs.getString("GUESTNAME");
			mGuestID=rs.getString("GUESTID");
			}
		%>
		<p align=center><font color="black" size=2><b>Guest Name<b></font>&nbsp;
				<font color="#a52a2a" size=2><%=mGuestName%></font>&nbsp;
				<font color="black" face="Verdana" size=3><b>
				Guest ID<b></font>
				<font color="#a52a2a" face="Verdana" size=3><%=mGuestID%></font>&nbsp
		</p>
		<%
		}
		else if(mChkMType.equals("S"))
		{
		qry="SELECT ENROLLMENTNO,STUDENTNAME FROM STUDENTMASTER where STUDENTID='"+mChkMemID+"' AND INSTITUTECODE='"+mInst+"' ";	
		rs=db.getRowset(qry);
		if(rs.next())
			{
				mStudName=rs.getString("STUDENTNAME");
				mEnroll=rs.getString("ENROLLMENTNO");
			}
				%>
		<p align=center><font color="black" size=3 face='Verdana'><b>Student Name<b></font>&nbsp;
				<font color="#a52a2a" size=3 face='Verdana'><%=mStudName%></font>&nbsp;
				<font color="black" size=3 face='Verdana'><b>Enrollment No.<b></font>
				<font color="#a52a2a" size=3 face='Verdana'><%=mEnroll%></font>&nbsp;
		</p>
		<%
		}
		%>

	
	<form name="frm"  method="post" onsubmit="return validate();">
	<input id="x" name="x" type=hidden>
	<table id=id1 width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD align=middle><font color="#a52a2a" size=3 face='Verdana'><b>Secret Question (useful when you forget your webkiosk password)</b></font></TD>
	</font></td></tr>
	</TABLE>
	<br>
	<TABLE rules=none cellSpacing=2 cellPadding=4 border=1  align=center >
	<tr>
	<td>
	<font color="Black" face='arial' size=2><b>Select Secret Question</b></font>&nbsp;&nbsp;&nbsp;&nbsp;
	<select size="1" name="Question" style="FONT-FAMILY: Verdana" tabindex=1 onchange="disableText();" onblur="disableText();">                
    <OPTION value="What is the name of your first school?" selected 
      >What is the name of your first school?
	<OPTION value="What is your favourite pass-time?">What is your favourite pass-time?
	<OPTION value="What is your mother's maiden name?">What is your mother's maiden name?
	<OPTION value="What is your favourite food?">What is your favourite food?
	<OPTION value="What is your exact time of birth?">What is your exact time of birth?
	<option value="What is your fathers middle name?" >What is your father's middle name?					<option value="Who was your childhood hero?" >Who was your childhood hero?
	<option value="What is your favorite pastime?" >What is your favorite pastime?
	<option value="What is your all-time favorite sports team?" >What is your all-time favorite sports team?	<option value="What  was your first car or bike?" >What  was your first car or bike?	
	<option value="Where did you first meet your spouse?" >Where did you first meet your spouse?
	<option value="What is your pets name?" >What is your pet's name?
    <option value="OTHERS">Others</option>
    </select><font color=red>*</font>
<td>
</tr>
<tr>
<td>
<font color="Black" face='arial' size=2><b>Secret Question(If Others)</b></font>
<input type='text' name="OtherQ" id="OtherQ" size=70 tabindex=2>
</td>
</tr>
<tr>
<td>
	<font color="Black" face='arial' size=2><b>Answer of Secret Question</b></font>
<input type='text' name="AnsQ" id="AnsQ" size=70 tabindex=3><font color=red>*</font>
</td>
</tr>
<tr>
<TD align=center><INPUT TYPE="submit"  VALUE="Save">&nbsp;&nbsp;
<INPUT TYPE="reset"  VALUE="Reset"></TD> 
</tr>
</table>
</form>
<%
if(request.getParameter("x")!=null)
	{

		if(request.getParameter("Question")==null)
		{
			mQuestion="";
		}
		else
		{
			mQuestion=request.getParameter("Question").toString().trim();
            mQuestion=gb.replaceSignleQuot(mQuestion);
			mQType="L";
		}
		if(request.getParameter("Question").equals("OTHERS"))
		{
			mQuestion=request.getParameter("OtherQ").toString().trim();
			mQuestion=gb.replaceSignleQuot(mQuestion);
			mQType="O";
		}

		if(request.getParameter("AnsQ")==null)
		{
			mAnsQ="";
		}
		else
		{
			mAnsQ=request.getParameter("AnsQ").toString().trim();
			mAnsQ=gb.replaceSignleQuot(mAnsQ);
	
		}

if(mChkMType.equals("E") || mChkMType.equals("G"))
		{
			qry="select 'Y' from ASKEDSECRETQUESTION where CompanyCode='"+mCompCode+"' and MemberID='"+mChkMemID+"' and MemberType='"+mChkMType+"'";
			rs=db.getRowset(qry);
			if(rs.next())
			{
				qry="Update ASKEDSECRETQUESTION set  QUESTION='"+mQuestion+"', QUESTYIONTYPE='"+mQType+"',ANSWER='"+mAnsQ+"' Where CompanyCode='"+mCompCode+"'	and MemberID='"+mChkMemID+"' and MemberType='"+mChkMType+"'";
				int n=db.update(qry);
				if(n>0)
				{
					%>
						<p align=center>
						<font size=2 color=green face='Verdana'><b>Secret question for <%=mEmpName%> (<%=mEmpcode%>) has been saved/change.<br>
						Now you can  use this question to reset you password 
						</font>
						</p>
					<%
						
				}
				else
				{
					%><CENTER><%
						out.print("<img src='../Images/Error1.jpg'>");
						out.print("<font size=2 color=red face='Verdana'><b>Error while saving record...</b></font>");
					%></CENTER><%
				}
			}
			else
			{
				qry="Insert into ASKEDSECRETQUESTION (COMPANYCODE, INSTITUTECODE, MEMBERID,    MEMBERTYPE, QUESTION, QUESTYIONTYPE,ANSWER) values ('"+mCompCode+"','"+mInst+"','"+mChkMemID+"','"+mChkMType+"','"+mQuestion+"','"+mQType+"','"+mAnsQ+"') ";
				int m=db.insertRow(qry);
				if(m>0)
				{
					
					%>
						<p align=center>
						<font size=2 color=green face='Verdana'><b>Secret question for <%=mEmpName%> (<%=mEmpcode%>) has been saved/change.<br>
						Now you can  use this question to reset you password 
						</font>
						</p>
					<%
				}
				else
				{
					%><CENTER><%
						out.print("<img src='../Images/Error1.jpg'>");
						out.print("<font size=2 color=red face='Verdana'><b>Error while saving record...</b></font>");
					%></CENTER><%
				}
			}

		}
else if(mChkMType.equals("S"))
		{			
			qry="select 'Y' from ASKEDSECRETQUESTION where INSTITUTECODE='"+mInst+"' and MemberID='"+mChkMemID+"' and MemberType='"+mChkMType+"'";
			rs=db.getRowset(qry);
			if(rs.next())
			{
				qry="Update ASKEDSECRETQUESTION set  QUESTION='"+mQuestion+"', QUESTYIONTYPE='"+mQType+"',ANSWER='"+mAnsQ+"' Where CompanyCode='"+mCompCode+"'	and MemberID='"+mChkMemID+"' and MemberType='"+mChkMType+"'";
				int n=db.update(qry);
				if(n>0)
				{
					response.sendRedirect("../StudentFiles/StudentPage.jsp");
					%>
						<p align=center>
						<font size=2 color=green face='Verdana'><b>Secret question for <%=mStudName%> (<%=mEnroll%>) has been saved/change.<br>
						Now you can  use this question to reset you password 
						</font>
						</p>
					<%
						
				}
				else
				{
					%><CENTER><%
						out.print("<img src='../Images/Error1.jpg'>");
						out.print("<font size=2 color=red face='Verdana'><b>Error while saving record...</b></font>");
					%></CENTER><%
				}
			}
			else
			{
				qry="Insert into ASKEDSECRETQUESTION (COMPANYCODE, INSTITUTECODE, MEMBERID,    MEMBERTYPE, QUESTION, QUESTYIONTYPE,ANSWER) values ('"+mCompCode+"','"+mInst+"','"+mChkMemID+"','"+mChkMType+"','"+mQuestion+"','"+mQType+"','"+mAnsQ+"') ";
				int m=db.insertRow(qry);
				if(m>0)
				{
					response.sendRedirect("../StudentFiles/StudentPage.jsp");
					%>
						<p align=center>
						<font size=2 color=green face='Verdana'><b>Secret question for <%=mStudName%> (<%=mEnroll%>) has been saved/change.<br>
						Now you can  use this question to reset you password 
						</font>
						</p>
					<%
				}
				else
				{
					%><CENTER><%
						out.print("<img src='../Images/Error1.jpg'>");
						out.print("<font size=2 color=red face='Verdana'><b>Error while saving record...</b></font>");
					%></CENTER><%
				}
			}
		}



//-----------------------------
//-- Enable Security Page Level  
//-----------------------------

//-----------------------------

	}
}
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
}
}//end of try
catch(Exception e)
{
//	out.println(e.getMessage());
}

%>
<br><br>
<center>
	<table ALIGN=Center VALIGN=TOP>
	<tr>
	<td valign=middle>
	<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">
	<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
	A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
	<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT> 		</td></tr></table>
</body>
</Html>
