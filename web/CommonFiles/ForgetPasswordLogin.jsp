<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.net.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %> 
<%
GlobalFunctions gb=new GlobalFunctions();
OLTEncryption enc=new OLTEncryption();
String mHead="",qry="", mInst="";
DBHandler db=new DBHandler();
ResultSet rs=null,rsi=null;
String mWebEmail="Deepak.gupta@jiit.ac.in";
String mComp="";//mcmpcode="";
String ipAddress="",Today="";
int MAXHINT =0;

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
   mHead=session.getAttribute("PageHeading").toString().trim();
else
   mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Password Recovery ] </TITLE>
<SCRIPT TYPE="text/javascript">
// copyright 1999 Idocs, Inc. http://www.idocs.com
// Distribute this script freely but keep this notice in place
function numbersonly(myfield, e, dec)
{
var key;
var keychar;

if (window.event)
   key = window.event.keyCode;
else if (e)
   key = e.which;
else
   return true;
keychar = String.fromCharCode(key);

// control keys
if ((key==null) || (key==0) || (key==8) || 
    (key==9) || (key==13) || (key==27) )
   return true;

// numbers
else if ((("0123456789.").indexOf(keychar) > -1))
   return true;

// decimal point jump
else if (dec && (keychar == "."))
   {
   myfield.form.elements[dec].focus();
   return false;
   }
else
   return false;
}
//-->

</SCRIPT>
<script>
<!--
  if(window.history.forward(1) != null)
  window.history.forward(1);
-->
</script>


<script language=javascript>
	<!--
	function RefreshContents()
	{
    	    document.SignupForm.x.value='ddd';
    	    document.SignupForm.submit();
	}
//-->
</script>
</head>
<%
String mEStudCD="", mStudCD="", mStudID="", mEStudID="", mUType="S", mEUType="", mPass="", mEPass="", mStudEmail="";
String mSName="", mPCode="", mBCode="", mSem="", mERole="", mStudPass="", mEStudPass="", mXYZ="";
int mMaxPWD=20;
int mMinPWD=4;
int n1=0, n2=0;
qry="select to_Char(Sysdate,'yymihh') date1 from dual";
rs=db.getRowset(qry);
rs.next();
String mCurrDate=rs.getString("date1");

%>
<BODY on aLink=#ff00ff bgcolor="#fce9c5" rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 scroll=auto>
<CENTER>
<Table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD align=center><font color="#a52a2a" style="FONT-SIZE: large; FONT-FAMILY: VERDANA"><B>Password Recovery Page </B></font></td></tr>
</TABLE>
<center>
<br>
<form Name="form1" method="post">
<input id="x" name="x" type=hidden>
<table align=center border=2 bordercolordark="Black" bordercolor="Black" bordercolorlight="Black" rules=groups cellpadding=2 cellspacing=5>
<TBODY>
<TR>
<%
qry="select nvl(INSTITUTECODE,' ')INSTITUTECODE from institutemaster";
rs=db.getRowset(qry);
%>
<TD><FONT face=Arial size=4 color=black>Institute Code</FONT></td>
<td><SELECT id=Inst style="FONT-SIZE:small;WIDTH:125px;FONT-STYLE:normal;FONT-FAMILY:Arial;HEIGHT:25px;TEXT-ALIGN:center;FONT-VARIANT:normal" name="Inst">
<%
while(rs.next())
{
if(request.getParameter("x")==null)
	{
%>
	<OPTION value=<%=rs.getString("INSTITUTECODE")%>><%=rs.getString("INSTITUTECODE")%></OPTION>
   <%
	}else
	{if(request.getParameter("Inst").equals(rs.getString("INSTITUTECODE")))
	{%>
	<OPTION selected  value=<%=rs.getString("INSTITUTECODE")%>><%=rs.getString("INSTITUTECODE")%></OPTION>
	<%
}else{%>
	<OPTION   value=<%=rs.getString("INSTITUTECODE")%>><%=rs.getString("INSTITUTECODE")%></OPTION>

<%}

}}
%>
</SELECT></TD>
</TR>
<tr>
<td><FONT size=4 face=Arial color=black>User Type</FONT></td>
<td><SELECT id=UType style="FONT-SIZE:small;WIDTH:125px;FONT-STYLE:normal;FONT-FAMILY:Arial;HEIGHT:25px;TEXT-ALIGN:center;FONT-VARIANT:normal" name="UType">
	<OPTION selected value=S>Student</OPTION>
</SELECT></TD>
</tr>
<%
	if(request.getParameter("Enroll")!=null)
		mStudCD=request.getParameter("Enroll").toString().trim();
	else
		mStudCD="";
%>
<tr>
<td><FONT size=4 face=Arial color=black>Enrollment No</FONT></td>
<td><FONT face=Arial size=2>  <INPUT value="<%=mStudCD%>" style="FONT-WEIGHT: bold; FONT-SIZE: x-small; WIDTH: 123px; FONT-FAMILY: Arial; HEIGHT: 22px" size=11 NAME="Enroll" SIZE=11 MAXLENGTH=10 onKeyPress="return numbersonly(this, event);"></FONT></td>
</tr>
<tr>
<tr><td colspan=2 align=center>
<font color="#ff4500" face="Times New Roman Greek">
<INPUT type="submit" id=BTNSubmit style="FONT-SIZE: x-small; WIDTH: 74px; FONT-FAMILY: Arial; HEIGHT: 27px" size =23 value="Submit" name =BTNSubmit tabIndex=5>
<INPUT id=BTNReset type=reset value=Reset name=BTNReset style="FONT-SIZE: x-small; WIDTH: 74px; FONT-FAMILY: Arial; HEIGHT: 27px" size    =18 tabIndex=6> 
</td></tr>
</TBODY>
</table>
</form>
<%


try
{

int mValid=0;

if (request.getParameter("x")!=null) 
{
      // Stop if other than A-Z, a-Z and 0-9 characters found


	for(int ii=0;ii<mStudCD.length();ii++)
	{

		if (mStudCD.charAt(ii)>=65 && mStudCD.charAt(ii)<=90)
		{
		  mValid=1;	
		}
		else if (mStudCD.charAt(ii)>=97 && mStudCD.charAt(ii)<=122)
		{
		  mValid=1;	
		}

		else if (mStudCD.charAt(ii)>=48 && mStudCD.charAt(ii)<=57)
		{
		  mValid=1;	
		}
		else
		{
		mValid=0;	
		break;
		}	
	}

	String mChkSttring=mStudCD.toUpperCase();

	int start = mChkSttring.indexOf("INSERT");

	if (start<0)
		start = mChkSttring.indexOf("UPDATE");
	if (start<0)
		start = mChkSttring.indexOf("DELETE");
	if (start<0)
		start = mChkSttring.indexOf("TRUNCATE");
	if (start<0)
		start = mChkSttring.indexOf("DROP");
	if (start<0)
		start = mChkSttring.indexOf("CREATE");
	if (start<0)
		start = mChkSttring.indexOf("ALTER");
	
	
	// Make Invalid If any DML string found
        if (start>=0)
	   mValid=0;

}


if (request.getParameter("x")!=null && mValid>0) 
{

	if(request.getParameter("Inst")!=null)
	mInst=request.getParameter("Inst").toString().trim();
    else
	mInst="";

    qry="Select nvl(COMPANYTAGGING,'UNIV') from InstituteMaster where InstituteCode='"+ mInst +"' And nvl(Deactive,'N')='N'";
		rs=db.getRowset(qry);
		if (rs.next())
		   mComp=rs.getString(1);
		else
		   mComp="";
		//System.out.print(mComp);
		qry="SELECT NVL(IPVELOCITYCOUNT,-1)COUNT FROM COMPANYINSTITUTETAGGING WHERE COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"'";
		rs=db.getRowset(qry);
		if(rs.next())
        MAXHINT=rs.getInt(1);
		else
        MAXHINT=-1;
		if(MAXHINT!=-1)
        {
		try
			{
				if (request.getHeader("HTTP_X_FORWARDED_FOR") == null) 
				{
					ipAddress= request.getRemoteAddr();
				}
				else 
				{
					ipAddress= request.getHeader("HTTP_X_FORWARDED_FOR");
				}
			}
			catch(Exception e){}
		int count=1;
	     qry="SELECT NVL(NOOFHITS,0)NOOFHITS FROM IPVELOCITYCHECK WHERE IPADDRESS='"+ipAddress+"' AND WEBMODULE='WEBKIOSK' AND ACTIONDATE=TO_DATE(TO_CHAR(sysdate,'DD-MM-YYYY'),'DD-MM-YYYY')";
		 rs=db.getRowset(qry);
		 if(rs.next())
		{
         int mNOOFHITS=rs.getInt(1);
		 if(mNOOFHITS < MAXHINT)
			{
			 mNOOFHITS++;
         qry="UPDATE IPVELOCITYCHECK SET  NOOFHITS='"+mNOOFHITS+"'WHERE IPADDRESS='"+ipAddress+"' AND WEBMODULE='WEBKIOSK' AND ACTIONDATE=TO_DATE(TO_CHAR(sysdate,'DD-MM-YYYY'),'DD-MM-YYYY')";
		 db.update(qry);
			}
			else
			{
         response.sendRedirect("PassRecErrorPage.jsp");
		}
		}
		else
		{
		qry="INSERT INTO IPVELOCITYCHECK(IPADDRESS, WEBMODULE, ACTIONDATE, NOOFHITS) VALUES('"+ipAddress+"','WEBKIOSK',TO_DATE(TO_CHAR(sysdate,'DD-MM-YYYY'),'DD-MM-YYYY'),'"+count+"')";
		db.insertRow(qry);
		}
		}






if(request.getParameter("UType")!=null)
	mUType=request.getParameter("UType").toString().trim();
else
	mUType="";
if(request.getParameter("Enroll")!=null)
	mStudCD=request.getParameter("Enroll").toString().trim();
else
	mStudCD="";
mStudCD=gb.replaceSignleQuot(mStudCD);



/*qry="SELECT nvl(COMPANYTAGGING,' ')COMPANYCODE FROM INSTITUTEMASTER WHERE INSTITUTECODE='"+mInst+"'";
rs=db.getRowset(qry);
//out.print(qry);
if(rs.next())
{
	mComp=rs.getString("COMPANYCODE");
}*/
qry="SELECT 'Y' FROM MEMBERMASTER WHERE ORACD='"+enc.encode(mStudCD)+"'";
rs=db.getRowset(qry);
//out.print(qry);
if(rs.next())
{
int mAcadYear=0;
String ProgComp="";
if(!mStudCD.equals(""))
{
	mAcadYear=Integer.parseInt(mStudCD.substring(0,2).toString().trim());
}

qry="SELECT nvl(PROGRAMCOMPLETED,'N')ProgComp FROM STUDENTMASTER WHERE INSTITUTECODE='"+mInst+"' AND ENROLLMENTNO='"+mStudCD+"'";
rs=db.getRowset(qry);
//out.print(qry);
if(rs.next())
{
	ProgComp=rs.getString("ProgComp");
}
if(1==1)
{
if(!mStudCD.equals("") && mUType.equals("S"))
{
   qry="SELECT 'Y' FROM STUDENTMASTER WHERE INSTITUTECODE='"+mInst+"' AND ENROLLMENTNO='"+mStudCD+"'";
   rs=db.getRowset(qry);
   //out.print(qry);
   if(rs.next())
   {
	%>
<form name="from2" action="ForgetPasswordLoginAction.jsp" method="POST">
<input id="InstituteCode" name="InstituteCode" value="<%=mInst%>" type=hidden>
<input id="UserType" name="UserType" value="<%=mUType%>" type=hidden>
<input id="EnrollmentNo" name="EnrollmentNo" value="<%=mStudCD%>" type=hidden>
<table align=center border=2 bordercolordark="Black" bordercolor="Black" bordercolorlight="Black" rules=groups cellpadding=2 cellspacing=5>
<TBODY>
<tr><td align=center><font size=4 color="#a52a2a"><b>Password Recovery Options</b></font></td></tr>
<%
String mdisp="", mChk="", mOptOne="";
if(mAcadYear>=5 && ProgComp.equals("N"))
{
	mdisp="disabled";
	mChk="";
	mOptOne="disabled";
}
else
{
	mdisp="";
	mChk="checked";
	mOptOne="";
}
%>
<tr bgcolor=gray><td><font color=white><b>Option-1</b></font><input type="radio" <%=mdisp%> name="option" id="option" value="a" <%=mChk%> ><font color=white><b>Your Full Name(as per institute record) and Date of Birth</b></font></input>
<BR>
<table bgcolor=gray width='100%'>
<tr bgcolor=gray><td><font color='white'><b>Full Name :</b></font></td>
<td><input size="30" type="text" name="fname" id="fname" <%=mdisp%>></td>
</tr>
<tr bgcolor=gray><td><font color='white'><b>DOB :</b></font></td>
<td><input type="text" name="dob" id="dob" <%=mdisp%>><br><font color="white">* Format(dd/mm/yyyy or dd-mm-yyyy)</font></td>
</tr>
</table></td>
</tr>
<%
String quest="";
if(!mStudCD.equals("") && mUType.equals("S"))
{
   qry="SELECT QUESTION,ANSWER From ASKEDSECRETQUESTION WHERE INSTITUTECODE='"+mInst+"' And MEMBERTYPE='S' and MEMBERID in (select studentid from StudentMaster where nvl(ENROLLMENTNO,'*')='"+mStudCD+"' AND INSTITUTECODE='"+mInst+"')";
   rs=db.getRowset(qry);
   // out.print(qry);
    if(rs.next())
	{
		quest=rs.getString("QUESTION");
	}
}
if(quest.equals(""))
{
	mdisp="disabled";
}
else
{
	mdisp="";
}
if(mOptOne.equals("disabled"))
{
	mChk="checked";
}
else
{
	mChk="";
}
%>
<tr bgcolor=LightGrey ><td><b>Option-2</b><input type="radio" name="option" id="option" value="b" <%=mdisp%>><b>Your secret question and answer submitted earlier</b></input>
<br>
<table bgcolor=LightGrey width='100%'>
<tr><td><font color=red><b>Question :</b></font></td>
<td><input type="hidden" name="question" id="question" value='<%=quest%>'  /><font color=red><b><%=quest%></b></font></td>
</tr>
<tr><td><font color=Green><b>Answer :</b></font></td>
<td><input type="text" name="ans" size="60" id="ans"/ <%=mdisp%>></td>
</tr>
</table></td>
</tr>


<%mWebEmail=mInst.equals("J128")?"meenakshi.sharma@jiit.ac.in":mWebEmail;%>

<tr bgcolor=LightSteelBlue ><td><b>Option-3</b></font><input type="radio" name="option" id="option" value="c" <%=mChk%>><b>Send mail to web-support team <A href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></b></input></td></tr>
<tr><td align="center"><input  type="submit" name="submit" id="submit" value="Submit" /></td></tr>
</TBODY>
</table>
</form>
	<%
   }
   else
   {
	%><br><LEFT><FONT COLOR=RED FACE=VERDANA SIZE=4>&nbsp; No such Enrollment No. found!</FONT></LEFT><br><%
   }
}
else
{
	%><br><LEFT><FONT COLOR=RED FACE=VERDANA SIZE=4>&nbsp; Enrollment No. can't be left blank!</FONT></LEFT><br><%
}
}
else
{
	%><br><LEFT><FONT COLOR=RED FACE=VERDANA SIZE=4>&nbsp; Please Contact to System Administrator!</FONT></LEFT><br><%
}
}
else
{
	%><br><LEFT><FONT COLOR=RED FACE=VERDANA SIZE=4>&nbsp; You have not signed up for Webkiosk Login! Please Contact to System Administrator...!</FONT></LEFT><br><%
}
}
}
catch(Exception e)
{
	//out.print(e);
}
%>

<hr>
<br>
<table align=center><tr><td align=left>
<IMG  src="../../Images/CampusLynx.png">
</td>
<td >
<FONT size =4 style="FONT-FAMILY: ARIal"><b>Campus Lynx</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT> 	
</td>
</tr>
</table>


</BODY></HTML>
