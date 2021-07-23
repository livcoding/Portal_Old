<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %> 
<%
OLTEncryption enc=new OLTEncryption();
GlobalFunctions gb =new GlobalFunctions();

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
String qrys="";
ResultSet rss=null;
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
String mDate="",mSLNO="";
String mRelate="",mRemarktyp="",mRemark="";
String mRemarksType="",mRelatedTo="";

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
		if(request.getParameter("MEMBERTYPE")==null || request.getParameter("MEMBERTYPE").equals(""))
	  {
			mFLAG="";
	  }
	  else
	  {
		   mFLAG=request.getParameter("MEMBERTYPE").toString().trim();
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
	

	  if(request.getParameter("MEMBERID")==null || request.getParameter("MEMBERID").equals(""))
	  {
			mEnroll="";
	  }
	  else
	  {
		   mEnroll=request.getParameter("MEMBERID").toString().trim().toUpperCase();
	  }

	if(request.getParameter("DATE")==null || request.getParameter("DATE").equals(""))
	  {
			mDate="";
	  }
	  else
	  {
		   mDate=request.getParameter("DATE").toString().trim().toUpperCase();
	  }

	if(request.getParameter("SLNO")==null || request.getParameter("SLNO").equals(""))
	  {
			mSLNO="";
	  }
	  else
	  {
		   mSLNO=request.getParameter("SLNO").toString().trim();
	  }



	if(request.getParameter("RELATEDTO")==null || request.getParameter("RELATEDTO").equals(""))
	  {
			mRelatedTo="";
	  }
	  else
	  {
		   mRelatedTo=request.getParameter("RELATEDTO").toString().trim().toUpperCase();
	  }

	if(request.getParameter("REMARKSTYPE")==null || request.getParameter("REMARKSTYPE").equals(""))
	  {
			mRemarksType="";
	  }
	  else
	  {
		   mRemarksType=request.getParameter("REMARKSTYPE").toString().trim();
	  }

if(request.getParameter("Remarks")==null || request.getParameter("Remarks").equals(""))
	  {
			mRemark="";
	  }
	  else
	  {
		   mRemark=GlobalFunctions.replaceSignleQuot(request.getParameter("Remarks").toString().trim());
	  }

if(mFLAG.equals("S"))
 {
qry="select 'y' from studentmaster where studentid='"+mEnroll+"' and nvl(DEACTIVE,'N')='N' ";
 }
 else
 {
qry="select 'y' from employeemaster where employeeid='"+mEnroll+"' and nvl(DEACTIVE,'N')='N' ";
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
qryn="select studentname from studentmaster where studentid='"+mEnroll+"' and nvl(DEACTIVE,'N')='N' ";
	}
	else
	{
qryn="select employeename from employeemaster where employeeid='"+mEnroll+"' and nvl(DEACTIVE,'N')='N' ";
	}
rsn=db.getRowset(qryn);
rsn.next();
%>
<form name="frm1" action="StudentVCRemarksAction.jsp" method="post"> 
<input type=hidden name="x" id="x">
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"<b>Update Remarks/Comment</b></font>
</td>
</tr>
</TABLE>
<%
	if(!mRemark.equals(""))
		   {


qry="update WEB#STUDENTVCREMARKS set remarks='"+mRemark+"',entrydate=sysdate,entryby='"+mChkMemID+"'   where institutecode='"+mInst+"' and memberid='"+mEnroll+"' and membertype='"+mFLAG+"' and INTRACTIONDATE=to_date('"+mDate+"','dd-mm-yyyy') and INTRACTIONSLNO='"+mSLNO+"' ";

int n=db.update(qry);


if(n>0)
{
	out.print("<font color=Green size=4><b>Record updated successfully...</b></font>");
}
else
{
	out.print("<font color=red size=4><b>Error while saving record..</b></font>");
}


}
else
	{
		out.print("<font color=red size=4><b>Kindly Fill the Remarks you want to save . </b></font>");

	}

%>
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
}
catch(Exception e)
{
}
%>

</BODY>
</HTML>