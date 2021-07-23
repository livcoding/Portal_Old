<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %> 
<%
OLTEncryption enc=new OLTEncryption();
try
{
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
		if(request.getParameter("MEMTYPE")==null || request.getParameter("MEMTYPE").equals(""))
	  {
			mFLAG="";
	  }
	  else
	  {
		   mFLAG=request.getParameter("MEMTYPE").toString().trim();
	  }

String mHeading="";

	  if(mFLAG.equals("S"))
		  mHeading="Students" ;
	  else
		  mHeading="Employee" ;

  //----------------------
%>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">Remarks for <%=mHeading%></font>
</td>
</tr>
</TABLE>
<%
	String mInteractionDate1="",mInteractionDate2="";
	String mID="";

	  if(request.getParameter("ENROLLMENT")==null || request.getParameter("ENROLLMENT").equals(""))
	  {
			mEnroll="";
	  }
	  else
	  {
		   mEnroll=request.getParameter("ENROLLMENT").toString().trim().toUpperCase();;
	  }
	if(request.getParameter("InteractionDate1")==null || request.getParameter("InteractionDate1").equals(""))
	  {
			mInteractionDate1="";
	  }
	  else
	  {
		   mInteractionDate1=request.getParameter("InteractionDate1").toString().trim().toUpperCase();;
	  }
	if(request.getParameter("InteractionDate2")==null || request.getParameter("InteractionDate2").equals(""))
	  {
			mInteractionDate2="";
	  }
	  else
	  {
		   mInteractionDate2=request.getParameter("InteractionDate2").toString().trim().toUpperCase();;
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
qryn="select studentname,studentid from studentmaster where enrollmentno='"+mEnroll+"' and nvl(DEACTIVE,'N')='N' ";
	}
	else
	{
qryn="select employeename,employeeid from employeemaster where employeecode='"+mEnroll+"' and nvl(DEACTIVE,'N')='N' ";
	}
rsn=db.getRowset(qryn);
rsn.next();
mID=rsn.getString(2);
%>
<form name="frm2" action="StudentVCRemarksRep.jsp" method="post"> 
<input type=hidden name="y" id="y">
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"<b>View Existing Remarks/Comments(Query/View criteria)</b></font>
</td>
</tr>
</TABLE>
<table align=center cellpadding=0 border=1 cellspacing=0 width=80%>
<tr>
	<td align=center><b>Interaction Date</b></td>
		<td align=center><b>Sl No.</b></td>
			<td align=center><b>Related To</b></td>
				<td align=center><b>Remarks Type</b></td>
</tr>
<%
	qry="SELECT nvl(to_char(INTRACTIONDATE,'dd-mm-yyyy'),' ')INTRACTIONDATE,INTRACTIONSLNO, RELATEDTO,REMARKSTYPE,REMARKS FROM WEB#STUDENTVCREMARKS where institutecode='"+mInst+"' and memberid='"+mID+"' and membertype='"+mFLAG+"'  and trunc(INTRACTIONDATE) between  trunc(to_date('"+mInteractionDate1+"','dd-mm-yyyy') )  and trunc(to_date('"+mInteractionDate2+"','dd-mm-yyyy') )  ";
	qry=qry+" and entryBY='"+mChkMemID+"' order by 1,2 ";
	//qry=qry+"  order by 1,2";
	rs=db.getRowset(qry);
	
	while(rs.next())
	{
		
	%>
	<tr>
			<td align=center><a target="_new" href="VCRemarksUpdate.jsp?DATE=<%=rs.getString("INTRACTIONDATE")%>&amp;SLNO=<%=rs.getInt("INTRACTIONSLNO")%>&amp;MEMBERID=<%=mID%>&amp;MEMBERTYPE=<%=mFLAG%>"><%=rs.getString("INTRACTIONDATE")%><a></td>
		<td align=center ><%=rs.getInt("INTRACTIONSLNO")%></td>
		<td align=center><%=rs.getString("RELATEDTO")%></td>
				<td align=center><%=rs.getString("REMARKSTYPE")%></td>

	</tr>
	<%		
	}
%>
</table>


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
}catch(Exception e)
{
	//out.print(qry);
}
%>

</BODY>
</HTML>