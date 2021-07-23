<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String temp="";
String qry="";
ResultSet rs=null;
String qrys="";
ResultSet rss=null;
ResultSet rss1=null;
String mInst="", mComp="";
int mSno1=0;
String mNames="";
DBHandler db=new DBHandler();
String mDefault="";
int ctr=0;
String mHead="", mExamid="";
String mysubjcode="",mETOD="",mSem1="",mLoginComp="";
session.setAttribute("GRADEMASTERSET",null);
session.setAttribute("GRADEINITIALCOUNT",null);
session.setAttribute("GRADECHECKED",null);
session.setAttribute("GRADEUNCHECKED",null);
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT";

%>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) 
  top.document.title = document.title;
//-->
</script>
<script language=javascript>
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
<script language=javascript>
function checkradio(temp)
{
	if(temp=='')
	{
	var val;
	val=document.frm1.jss.value;
	var mNames;
	var val1=parseInt(val);
	var i=1;
	
	while(i<=val1)
	{
		mNames="RADIO"+i;

		if(document.frm1[mNames][0].checked==false)
		{
			alert('Please select the Yes option to Proceed');
			return false;
		}
		else
		{
		
		}
		i++;
	}
	var ret=checkBox();
	
	return ret;
	}
}

function checkBox()
{
	var val;
	val=document.frm1.checkctr.value;
	var mNames;
	var val1=parseInt(val);
	var i=1;
	while(i<=val1)
	{
		mNames="FSTID"+i;
		if(document.frm1[mNames].checked==true)
		{
			return true;
		}
		
		i++;
	}
	alert('Please select the atleast one checkbox');

	return false;
}
</script>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
try
{
OLTEncryption enc=new OLTEncryption();
int mFlag=0;
String  mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="";
String mECode="",mecode="", mDesg="", mDept="";
int mSno=0;
String mName="";
String mSCode="",mscode="";
String mEC="",mSC="";
String mName1="";

if (session.getAttribute("Designation")==null)
{
	mDesg="";
}
else
{
	mDesg=session.getAttribute("Designation").toString().trim();
}
							
if (session.getAttribute("Department")==null)
{
	mDept="";
}
else
{
	mDept=session.getAttribute("Department").toString().trim();
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
if (session.getAttribute("LoginComp")==null)
{
	mLoginComp="";
}
else
{
	mLoginComp=session.getAttribute("LoginComp").toString().trim();
}


if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
{
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
   qry="Select WEBKIOSK.ShowLink('146','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
  // out.print(qry);
   RsChk= db.getRowset(qry);
   if (RsChk.next() && RsChk.getString("SL").equals("Y"))
   {
	%>
	<form name="frm0" method="post" >
	<input id="xx" name="xx" type=hidden>
	<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana"><u>Grade Calculation</u></b></TD>
	</font></td></tr>
	</TABLE>
	<table cellpadding=1 cellspacing=0 width="100%" align=center rules=groups border=3>
	<tr><td colspan=2 align=center>&nbsp;<font color=navy face=arial size=2><STRONG>Employee : &nbsp;</STRONG></font><font color=black face=arial size=2><%=mMemberName%>[<%=mDMemberCode%>]
	&nbsp; &nbsp; &nbsp;<font color=navy face=arial size=2><STRONG>Department : &nbsp;</STRONG></font><%=GlobalFunctions.toTtitleCase(mDept)%>
	&nbsp; &nbsp; &nbsp;<font color=navy face=arial size=2><STRONG>Designation : &nbsp;</STRONG></font><%=GlobalFunctions.toTtitleCase(mDesg)%>
	<hr></td></tr>

	<!--Institute****-->
	<tr><td colspam=2 align=center><FONT color=black><FONT face=Arial size=2><STRONG>Institute</STRONG></FONT></FONT>
	&nbsp; &nbsp;<select name=InstCode tabindex="0" id="InstCode">
	<OPTION selected Value =<%=mInst%>><%=mInst%></option>
	</select>
	&nbsp; &nbsp; &nbsp;
	<FONT color=black face=Arial size=2><STRONG>Exam Code</STRONG></FONT>
	<%
	
//*********************************************CHANGE THE QUERY 27/01/2010****************************************


	qry=" Select nvl(EXAMCODE,' ') Exam from EXAMMASTER Where INSTITUTECODE='"+mInst+"' AND";
	qry+=" nvl(Deactive,'N')='N' AND NVL(LOCKEXAM,'N')='N' and examcode in (Select examcode from facultysubjecttagging)";
     qry+=" and examcode in (select nvl(examcode,' ')examcode from v#studenteventsubjectmarks Where InstituteCode='" + mInst + "' And CompanyCode='" + mLoginComp + "') ";
	qry+=" order by Exam DESC";
	
	//out.print(qry);
	rs=db.getRowset(qry);
	%>
	<select name="ExamCode" tabindex="0" id="ExamCode">	
	<%
	try
	{ 
		if (request.getParameter("xx")==null)
		{
			%>
			<OPTION selected Value="NONE"><b><-- Select an Exam Code --></b></option>
			<%
			while(rs.next())
			{
				mExamid=rs.getString("Exam");
				%>
				<OPTION Value =<%=mExamid%>><%=mExamid%></option>
				<%
			}
		}
		else
		{
			%>
			<OPTION Value="NONE"><b><-- Select an Exam Code --></b></option>
			<%
	 		while(rs.next())
			{
				mExamid=rs.getString("Exam");
				if(mExamid.equals(request.getParameter("ExamCode").toString().trim()))
				{
					%>
					<OPTION selected Value =<%=mExamid%>><%=mExamid%></option>
					<%			
				}
			     	else
			      {
					%>
		     			<OPTION Value =<%=mExamid%>><%=mExamid%></option>
		     			<%			
			   	}
		 	}
		}
	}
	catch(Exception e)
	{
		//out.println(e.getMessage());
	}
	%>
	</select>
	&nbsp; &nbsp; &nbsp;
	<INPUT Type="submit" Value="&nbsp; OK &nbsp;">
	</tr></td>
	</table>
	</form>
	<%
//-----------------------------
//---Enable Security Page Level  
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
//out.print(e+qry);
}
%>