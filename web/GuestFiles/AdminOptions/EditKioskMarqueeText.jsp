<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
try
{
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="", qry1="";

String mMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mDesc1="";
long mPriority1=0;
String Date11="",Date22="";
String mMText="", mMType="", mDate1="", mDate2="", mInst="";
String mDesc="", Date1="", Date2="", mApplicant="", mActive="", mStatus="";
long  mPriority=0;
String mlevel="";
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

	if (request.getParameter("INST").toString().trim()==null)
	{
		mInst="";
	}
	else
	{
		mInst=request.getParameter("INST").toString().trim();
	}

	if (request.getParameter("MTEXT").toString().trim()==null)
	{
		mMText="";
	}
	else
	{	
		mMText=request.getParameter("MTEXT").toString().trim();
	}

	if (request.getParameter("ACTV").toString().trim()==null)
	{
		mActive="";
	}
	else
	{
		mActive=request.getParameter("ACTV").toString().trim();
	}

	if (request.getParameter("MTYPE").toString().trim()==null)
	{
		mMType="";
	}
	else
	{
		mMType=request.getParameter("MTYPE").toString().trim();
	}
	if(mMType.equals("A"))
		mApplicant="Admin";
	else if(mMType.equals("E"))
		mApplicant="Employee";
	else if(mMType.equals("G"))
		mApplicant="Guest";
	else if(mMType.equals("S"))
		mApplicant="Student";
	else if(mMType.equals("V"))
		mApplicant="Visitor";

	// mMLevel=Long.parseLong(request.getParameter("MLEVEL").toString().trim());
	
	   mlevel=request.getParameter("MLEVEL").toString().trim();	
	
	if (request.getParameter("MDATE1").toString().trim()==null)
	{
		mDate1="";
	}
	else
	{
		mDate1=request.getParameter("MDATE1").toString().trim();
	}

	if (request.getParameter("MDATE2").toString().trim()==null)
	{
		mDate2="";
	}
	else
	{
		mDate2=request.getParameter("MDATE2").toString().trim();
	}
	String mHead="";
	if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
		mHead=session.getAttribute("PageHeading").toString().trim();
	else
		mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [Edit Webkiosk Marquee Text]</TITLE>
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
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
	OLTEncryption enc=new OLTEncryption();
	if(!mMemberID.equals("") && !mMemberCode.equals("")) 
	{
	mDMemberCode=enc.decode(mMemberCode);
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('101','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
  //----------------------
// For Log Entry Purpose
//--------------------------------------
String mLogEntryMemberID="",mLogEntryMemberType="";

if (session.getAttribute("LogEntryMemberID")==null || session.getAttribute("LogEntryMemberID").toString().trim().equals(""))
	mLogEntryMemberID="";
else
	mLogEntryMemberID=session.getAttribute("LogEntryMemberID").toString().trim();


if (session.getAttribute("LogEntryMemberType")==null || session.getAttribute("LogEntryMemberType").toString().trim().equals(""))
	mLogEntryMemberType="";
else
	mLogEntryMemberType=session.getAttribute("LogEntryMemberType").toString().trim();

if (mLogEntryMemberType.equals(""))
	mLogEntryMemberType=mMemberType;

if (mLogEntryMemberID.equals(""))
	mLogEntryMemberID=mMemberID;


if (!mLogEntryMemberType.equals(""))
	mLogEntryMemberType=enc.decode(mLogEntryMemberType);

if (!mLogEntryMemberID.equals(""))
	mLogEntryMemberID=enc.decode(mLogEntryMemberID);

//--------------------------------------
%>
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD colspan=0 align=middle ><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Edit Marquee Message</b></font></td>
</tr>
</TABLE>
		
<%	
	qry1="select nvl(INSTITUTECODE,' ')IC, nvl(TEXTDATA,' ')TA, nvl(APPLICABLEFOR,' ')AF, nvl(MSGPRIORITY,0)MP, to_char(DISPLAYFROM,'dd-mm-yyyy')DF, to_char(DISPLAYTILL,'dd-mm-yyyy')DT, nvl(ACTIVE,'N')ACT ";
	qry1=qry1+" from KIOSKMARQUEETEXT where INSTITUTECODE='"+mInst+"' and APPLICABLEFOR='"+mMType+"' and to_char(DISPLAYFROM,'dd-mm-yyyy')='"+mDate1+"' and to_char(DISPLAYTILL,'dd-mm-yyyy')='"+mDate2+"'";
	//qry1=qry1+" and MSGPRIORITY='"+mlevel+"' and ACTIVE='"+mActive+"'";
	rs1=db.getRowset(qry1);
	//out.print(qry1);
   
	if(rs1.next())
	{
	%>	
		<table cellpadding=2 cellspacing=0 align=center rules=groups width=90% border=2>
    <tr>
		<input type=hidden name="INST" id="INST" value="<%=mInst%>">
            <input type=hidden name="MTYPE" id="MTYPE" value="<%=mMType%>">
            <input type=hidden name="MTEXT" id="MTEXT" value="<%=mMText%>">
            <input type=hidden name="MLEVEL" id="MLEVEL" value="<%=mlevel%>">
            <input type=hidden name="ACTV" id="ACTV" value="<%=mActive%>">
            <input type=hidden name="MDATE1" id="MDATE1" value="<%=mDate1%>">
            <input type=hidden name="MDATE2" id="MDATE1" value="<%=mDate2%>">
 <td nowrap><FONT color=black face=Arial size=2><STRONG>&nbsp;Edit Marquee For :</STRONG></FONT>&nbsp;<FONT color=black face=Times New Roman size=3><%=mApplicant%></FONT>

      	
<font color=black face=arial size=2>&nbsp;&nbsp;<STRONG>Display From</font>
<font face=arialblack size=2 color=Green>&nbsp;(DD-MM-YYYY)&nbsp;</font></STRONG>

</font>&nbsp;<input Name=TXT1 Id=TXT1 Type=text maxlength=10 size=10 value='<%=mDate1%>'> 

<font color=black face=arial size=2>&nbsp;&nbsp;<STRONG>To</STRONG>&nbsp;&nbsp;</font>

<input Name=TXT2 Name=TXT2 Type=text Value='<%=mDate2%>' maxlength=10 size=10></td></tr>

<tr><td nowrap><FONT color=black face=Arial size=2><STRONG>&nbsp;Message Text</STRONG></FONT>&nbsp;&nbsp;

<INPUT ID="MarqueeText" Name="MarqueeText" style="WIDTH: 475px;" maxLength=100 value="<%=mMText%>"></td></tr>

<tr><td valign=top><FONT color=black face=Arial size=2><STRONG>&nbsp;Priority No.</STRONG></FONT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

<INPUT ID="MarqueeTextPriority" Name="MarqueeTextPriority" style="WIDTH: 30px;" maxLength=2 value="<%=mlevel%>">&nbsp;&nbsp;

<FONT color=black><FONT face=Arial size=2><STRONG>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Active Message Text?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</STRONG></FONT></FONT>
<%
if(mActive.equals("N"))
{
%>
	<select name=Active tabindex="0" id="Active" style="WIDTH: 60px">	
	<%
	if(request.getParameter("Active")==null)
	{
		mActive="N";
	%>
		<option value="N" Selected>No</option>
		<option value="Y">Yes</option>
	<%
	}
	else
	{
		if(request.getParameter("Active").toString().trim().equals("Y"))
		{
			mActive="Y";
		%>
			<option value="Y">Yes</option>
		<%
		}
		else
		{
		%>
			<option value="Y">Yes</option>
		<%
		}	
		if(request.getParameter("Active").toString().trim().equals("N"))
		{
			mActive="N";
		%>
			<option value="N" Selected>No</option>
		<%
		}
		else
		{
		%>
			<option value="N">No</option>
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
	<select name=Active tabindex="0" id="Active" style="WIDTH: 60px">	
	<%
	if(request.getParameter("Active")==null)
	{
		mActive="N";
	%>
		<option value="Y">Yes</option>
	<%
	}
	else
	{
		if(request.getParameter("Active").toString().trim().equals("Y"))
		{
			mActive="Y";
		%>
			<option value="Y">Yes</option>
		<%
		}
		else
		{
		%>
			<option value="Y">Yes</option>
		<%
		}	
	}
	%>
 	</select>	
	<%
	}
	%>
 	</td></tr>

<tr><td align=center><INPUT id=submit1 style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 102px; HEIGHT: 23px; FONT-VARIANT: normal" type=submit size=5 value="Save" name=submit1>

<INPUT id=submit1 style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 102px; HEIGHT: 23px; FONT-VARIANT: normal" type=Reset size=5 value="Cancel" name=Reset></td></tr>

</TABLE></form>

	<%
		if(request.getParameter("x")!=null)
		{
		try
		{
		//mPriority1=Long.parseLong(request.getParameter("MLEVEL"));
			mlevel=request.getParameter("MLEVEL").toString().trim();
			Date11=request.getParameter("MDATE1").toString().trim();
			Date22=request.getParameter("MDATE2").toString().trim();
			mDesc=request.getParameter("MarqueeText").toString().trim();
			mDesc=gb.replaceSignleQuot(mDesc);
			mActive=request.getParameter("ACTV").toString().trim();

			mStatus=request.getParameter("Active").toString().trim();
			mPriority=Long.parseLong(request.getParameter("MarqueeTextPriority").toString().trim());
			Date1=request.getParameter("TXT1").toString().trim();
			Date2=request.getParameter("TXT2").toString().trim();
			
			if(mPriority >0)
			{							
				qry="Update KIOSKMARQUEETEXT set TEXTDATA='"+mDesc+"', MSGPRIORITY='"+mPriority+"', ACTIVE='"+mStatus+"', ";
				qry=qry+" DISPLAYFROM=to_date('"+Date1+"','dd-mm-yyyy'), DISPLAYTILL=to_date('"+Date2+"','dd-mm-yyyy')";
				qry=qry+" where INSTITUTECODE='"+mInst+"' and APPLICABLEFOR='"+mMType+"' and MSGPRIORITY='"+mlevel+"' ";
				qry=qry+" and (trunc(DISPLAYFROM) between trunc(decode(to_date('"+Date11+"','DD-MM-YYYY'),'',DISPLAYFROM,to_date('"+Date11+"','DD-MM-YYYY')))";
				qry=qry+" and trunc(decode(to_date('"+Date22+"','DD-MM-YYYY'),'',DISPLAYFROM,to_date('"+Date22+"','DD-MM-YYYY')))";
				qry=qry+" or trunc(DISPLAYTILL) between trunc(decode(to_date('"+Date11+"','DD-MM-YYYY'),'',DISPLAYTILL,to_date('"+Date11+"','DD-MM-YYYY')))";
				qry=qry+" and trunc(decode(to_date('"+Date22+"','DD-MM-YYYY'),'',DISPLAYTILL,to_date('"+Date22+"','DD-MM-YYYY')))) ";
				qry=qry+" and ACTIVE='"+mActive+"'";
				//out.print(qry);
				int n=db.update(qry);
				if(n>0)
				{
					//----------- Log Entry
		  			//-----------------
					db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"EDIT KIOSK MARQUEE TEXT", "Applicable for: : "+mMType+" Display from : "+ Date1+"Upto :"+Date2, "No MAC Address" , mIPAddress);
					//-----------------
					response.sendRedirect("KioskMarqueeText.jsp");
				}
				else
				{
					out.print("<br><img src='../../Images/Error1.jpg'>");
					out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Error while edit marquee message</font> <br>");
				}
			}
			else
			{
				out.print("<br><img src='../../Images/Error1.jpg'>");
				out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Please Enter Valid Message Text Priority No. (i.e. Numeric and > '0')</font> <br>");
			}
		}
		catch(Exception e)
		{}
		}
	}  // CLOSING OF RS1.NEXT
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
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Message Priority can not be left blank!</font> <br>");
}
%>
</body>
</html>