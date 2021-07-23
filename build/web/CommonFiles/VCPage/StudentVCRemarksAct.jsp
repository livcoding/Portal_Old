<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %> 
<%
OLTEncryption enc=new OLTEncryption();

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
   mHead=session.getAttribute("PageHeading").toString().trim();
else
   mHead="JIIT ";
	String mEnroll="",mSysDate="";
String qryn="";
ResultSet rsn=null;
String mFLAG="";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [Student VC Remarks] </TITLE>

<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>


<SCRIPT LANGUAGE="JavaScript">

function Validate()
{
if(document.frm1.Remarks.value=="")
	{
		alert("Please Fill the Remarks.. ");
		frm1.Remarks.focus();
		return false;
	}
}
	function Documentdisable()
	{
				if(document.frm1.ORemarks.checked==true)
					{
						document.frm1.OtherRemarks.value="";
						document.frm1.RemarksType.disabled=true;
						document.frm1.OtherRemarks.disabled=false;
					}
					else
					{
						document.frm1.OtherRemarks.value="";
						document.frm1.RemarksType.disabled=false;
						document.frm1.OtherRemarks.disabled=true;
					}
					if(document.frm1.ORelated.checked==true)
					{
						document.frm1.OtherRelated.value="";
						document.frm1.RelatedTo.disabled=true;
						document.frm1.OtherRelated.disabled=false;
					}
					else
					{
						document.frm1.OtherRelated.value="";
						document.frm1.RelatedTo.disabled=false;
						document.frm1.OtherRelated.disabled=true;
					}
		}
	
		function funremarks()	
				{
					if(document.frm1.ORemarks.checked==true)
					{
						document.frm1.OtherRemarks.value="";
						document.frm1.RemarksType.disabled=true;
						document.frm1.OtherRemarks.disabled=false;
					}
					else
					{
						document.frm1.OtherRemarks.value="";
						document.frm1.RemarksType.disabled=false;
						document.frm1.OtherRemarks.disabled=true;

					}
				}
				function funrelated()
				{
					if(document.frm1.ORelated.checked==true)
					{
						document.frm1.OtherRelated.value="";
						document.frm1.RelatedTo.disabled=true;
						document.frm1.OtherRelated.disabled=false;
					}
					else
					{
						document.frm1.OtherRelated.value="";
						document.frm1.RelatedTo.disabled=false;
						document.frm1.OtherRelated.disabled=true;
					}
				}

//-->
</SCRIPT>
</HEAD>
<%
String mMemberID="";
String mMemberType="";
String mMemberCode="",qry="";
DBHandler db=new DBHandler();
ResultSet rs=null;
String mWebEmail="";
String mInst="";

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
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}
%>

<BODY aLink=#ff00ff bgcolor="#fce9c5" rightmargin=0 leftmargin=0 topmargin=0  onLoad="Documentdisable();">
<%
if(!mMemberID.equals("") || !mMemberType.equals("") || !mMemberCode.equals(""))
{

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('188','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
		if(request.getParameter("FLAG")==null || request.getParameter("FLAG").equals(""))
	  {
			mFLAG="";
	  }
	  else
	  {
		   mFLAG=request.getParameter("FLAG").toString().trim();
	  }

String mHeading="";

	  if(mFLAG.equals("S"))
		  mHeading="Students" ;
	  else
		  mHeading="Employee" ;

  //----------------------
%>
<table  cellspacing=0 cellpadding=0 width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: VERDANA">Remarks for <%=mHeading%></font>
</td>
</tr>
</TABLE>
<%
	  if(request.getParameter("Enrollment")==null || request.getParameter("Enrollment").equals(""))
	  {
			mEnroll="";
	  }
	  else
	  {
		   mEnroll=request.getParameter("Enrollment").toString().trim().toUpperCase();;
	  }

if(mFLAG.equals("S"))
 {
qry="select 'y' from studentmaster where enrollmentno='"+mEnroll+"' and nvl(DEACTIVE,'N')='N' ";
 }
 else
 {
qry="select 'y' from employeemaster where employeecode='"+mEnroll+"' and nvl(DEACTIVE,'N')='N' ";
 }
rs=db.getRowset(qry);
if(rs.next())
{

qry="select to_char(sysdate,'dd-mm-yyyy') from dual";
rs=db.getRowset(qry);
rs.next();
mSysDate=rs.getString(1);

if(mFLAG.equals("S"))
	{
qryn="select studentname from studentmaster where enrollmentno='"+mEnroll+"' and nvl(DEACTIVE,'N')='N' ";
	}
	else
	{
qryn="select employeename from employeemaster where employeecode='"+mEnroll+"' and nvl(DEACTIVE,'N')='N' ";
	}
rsn=db.getRowset(qryn);
rsn.next();
%>
<form name="frm2" action="StudentVCRemarksRep.jsp" method="post"> 
<input type=hidden name="y" id="y">
<table cellspacing=0 cellpadding=0 width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: VERDANA"<b>View Existing Remarks/Comments(Query/View criteria)</b></font>
</td>
</tr>
</TABLE>
<table cellspacing=0 cellpadding=0 align=center rules=groups border=1 width=70%>
<tr>
<td><FONT FACE=VERDANA SIZE=2><b>Interaction date between</b>
<input readonly type=text value="<%=mSysDate%>" name=InteractionDate1 size=10  maxlength=10 onchange="return iSValidDate(InteractionDate1.value);" >&nbsp;<a href="javascript:NewCal('InteractionDate1','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>
</td>
<td>
<FONT FACE=VERDANA SIZE=2><b>and </b></td>
<td>
<input readonly type=text value="<%=mSysDate%>" name=InteractionDate2 size=10  maxlength=10 onchange="return iSValidDate(InteractionDate2.value);" >&nbsp;<a href="javascript:NewCal('InteractionDate2','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>
</td>
<td><input type=submit value=submit></td>
</tr>
</table>
<input type=hidden name="ENROLLMENT" id="ENROLLMENT" VALUE="<%=mEnroll%>">
<input type=hidden name="MEMTYPE" id="MEMTYPE" VALUE="<%=mFLAG%>">
</form>


<br>
<form name="frm1" action="StudentVCRemarksAction.jsp" method="post"> 
<input type=hidden name="x" id="x">
<table cellspacing=0 cellpadding=0 width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: VERDANA"<b>Compose New Remarks/Comment</b></font>
</td>
</tr>
</TABLE>
<table cellspacing=0 cellpadding=0 align=center rules=groups border=1 width=98%>
<tr>
<%
	if(mFLAG.equals("S"))
	{
%>
<td><FONT FACE=VERDANA SIZE=2><b>Enrollment No.</b></td>
<%
	}
	else
	{
%>
<td><FONT FACE=VERDANA SIZE=2><b>Employee Code</b></td>
<%
	}
%>

<td><%=mEnroll%></td>
<%
	if(mFLAG.equals("S"))
	{
%>
<td><FONT FACE=VERDANA SIZE=2><b>Student Name:</b>&nbsp;&nbsp;
<%
	}
	else
	{
%>
<td><FONT FACE=VERDANA SIZE=2><b>Employee Name:</b>&nbsp;&nbsp;
<%
	}
%>
<%=rsn.getString(1)%>
</tr>
<tr>
<td><FONT FACE=VERDANA SIZE=2><b>Interaction Date</b></td>
<td>
<input readonly type=text value="<%=mSysDate%>" name=InteractionDate size=10  maxlength=10 onchange="return iSValidDate(InteractionDate.value);" >&nbsp;<a href="javascript:NewCal('InteractionDate','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>
&nbsp; &nbsp; &nbsp; &nbsp;
<FONT FACE=VERDANA SIZE=2><b>Remarks Type</b>
<td>
<select name="RemarksType" style=width="150px" >
<%
   qry="select REMARKSTYPE FROM WEB#REMARKSTYPE WHERE INSTITUTECODE='"+mInst+"' AND NVL(DEACTIVE,'N')='N' ";
   rs=db.getRowset(qry);
   while(rs.next())
   {
%>
	<option value="<%=rs.getString("REMARKSTYPE")%>"><%=rs.getString("REMARKSTYPE")%></option>
<%
   }
%>
</select>&nbsp; &nbsp; <FONT FACE=VERDANA SIZE=2><b>Others</b>
<input type="checkbox" name=ORemarks value="Y" onClick="funremarks();">
<input type=text name=OtherRemarks maxlength=60 size=20>
</td>
</tr>
<tr>
<td><FONT FACE=VERDANA SIZE=2><b>Related To</b></td>
<td COLSPAN=5>
<select name="RelatedTo" style=width="250px" >
<%
qry="select RELATEDTO FROM WEB#RELATEDTO WHERE INSTITUTECODE='"+mInst+"' AND NVL(DEACTIVE,'N')='N' ";
rs=db.getRowset(qry);
while(rs.next())
{
	%>
	<option value="<%=rs.getString("RELATEDTO")%>"><%=rs.getString("RELATEDTO")%></option>
	<%
}
%>
</select>&nbsp; &nbsp; <FONT FACE=VERDANA SIZE=2><b>Others</b>
<input type="checkbox" name=ORelated value="Y" onClick="funrelated();">
<input type=text name=OtherRelated maxlength=60 size=20>
</td>
</tr>
<TR>
<td colspan=4 align=center>
<textarea name="Remarks" maxlength=2000 style="WIDTH: 800px; HEIGHT: 170px" rows=13></textarea>
</td>
</TR>
<tr>
<td colspan=4 align=center>
<input type=submit value="Submit" onClick="return Validate();" >&nbsp; &nbsp; &nbsp;
<input type="Reset" value="Cancel">
<input type=hidden name="ENROLLMENT" id="ENROLLMENT" VALUE="<%=mEnroll%>">
<input type=hidden name="MEMTYPE" id="MEMTYPE" VALUE="<%=mFLAG%>">

</td>
</tr>
</table>
</form>
<%
  
} // if  if(rs.next())
else
{
	out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp;<b><font size=3 face='Arial' color='Red'>Please check the Enrollment no./Employeecode</font>");
}


  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
  }
  else
  {
   %>
<br>	<font color=red>
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
out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp'>Login</a> to continue</font> <br>");
}
%>

</BODY>
</HTML>