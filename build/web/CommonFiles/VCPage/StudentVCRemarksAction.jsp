<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %> 
<%
OLTEncryption enc=new OLTEncryption();
GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
   mHead=session.getAttribute("PageHeading").toString().trim();
else
   mHead="JIIT ";


%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [Student VC Remarks] </TITLE>

<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>


</HEAD>
<%
String mMemberID="";
String mMemberType="";
String mMemberCode="",qry="",qrys="";
ResultSet rs=null;
ResultSet rss=null;
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

<BODY aLink=#ff00ff bgcolor="#fce9c5" rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 scroll=auto>
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
  //----------------------
  String mMemType="";

if(request.getParameter("MEMTYPE")==null || request.getParameter("MEMTYPE").equals(""))
  {
	mMemType="";
  }
 else
 {
	mMemType=request.getParameter("MEMTYPE").toString().trim();
 }

String mHeading="";

	  if(mMemType.equals("S"))
		  mHeading="Students" ;
	  else
		  mHeading="Employees" ;
%>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: VERDANA"><U>Remarks for <%=mHeading%></U></font>
</td>
</tr>
</TABLE>
<BR><BR>
<%

String mEnroll="", mRemarks="",mInteractionDate="",mRemarksType="",mORemarks="",mOtherRemarks="" ;
String mRelatedTo="",mORelated="",mOtherRelated="";
String mStudid="",qry1="";
int mInteractionSlno=0;


if(request.getParameter("ENROLLMENT")==null || request.getParameter("ENROLLMENT").equals(""))
  {
	mEnroll="";
  }
 else
 {
	mEnroll=request.getParameter("ENROLLMENT").toString().trim();
 }

if(request.getParameter("InteractionDate")==null || request.getParameter("InteractionDate").equals(""))
  {
	mInteractionDate="";
  }
 else
 {
	mInteractionDate=request.getParameter("InteractionDate").toString().trim();
 }
 if(request.getParameter("RemarksType")==null || request.getParameter("RemarksType").equals(""))
  {
	mRemarksType="";
  }
 else
 {
	mRemarksType=request.getParameter("RemarksType").toString().trim();
 }
 if(request.getParameter("ORemarks")==null || request.getParameter("ORemarks").equals(""))
  {
	mORemarks="";
  }
 else
 {
	mORemarks=request.getParameter("ORemarks").toString().trim();
 }
if(mORemarks.equals("Y"))
{
mRemarksType=request.getParameter("OtherRemarks").toString().trim();
}
else
{
mRemarksType=request.getParameter("RemarksType").toString().trim();
}
/*
 if(request.getParameter("OtherRemarks")==null || request.getParameter("OtherRemarks").equals(""))
  {
	mOtherRemarks="";
  }
 else
 {
	mOtherRemarks=request.getParameter("OtherRemarks").toString().trim();
 }
 */
  if(request.getParameter("RelatedTo")==null || request.getParameter("RelatedTo").equals(""))
  {
	mRelatedTo="";
  }
 else
 {
	mRelatedTo=request.getParameter("RelatedTo").toString().trim();
 }
  if(request.getParameter("ORelated")==null || request.getParameter("ORelated").equals(""))
  {
	mORelated="";
  }
 else
 {
	mORelated=request.getParameter("ORelated").toString().trim();
 }

	if(mORelated.equals("Y"))
   {
	mRelatedTo=request.getParameter("OtherRelated").toString().trim();

   }
   else
   {
	mRelatedTo=request.getParameter("RelatedTo").toString().trim();

   }

 /*
  if(request.getParameter("OtherRelated")==null || request.getParameter("OtherRelated").equals(""))
  {
	mOtherRelated="";
  }
 else
 {
	mOtherRelated=request.getParameter("OtherRelated").toString().trim();
 }
 */
 if(request.getParameter("Remarks").toString()==null || request.getParameter("Remarks").toString().equals(""))
  {
	mRemarks="";
  }
 else
 {
	mRemarks=GlobalFunctions.replaceSignleQuot(request.getParameter("Remarks").toString().trim());
 }


if(!mRemarks.equals(""))
		   {
	if(mMemType.equals("S"))
   {
 qry="select studentid from studentmaster where enrollmentno='"+mEnroll+"' and nvl(DEACTIVE,'N')='N' ";
   }
   else
   {
 qry="select employeeid from employeemaster where employeecode='"+mEnroll+"' and nvl(DEACTIVE,'N')='N' ";
  }
 rs=db.getRowset(qry);
 if(rs.next())
	 mStudid=rs.getString(1);

qrys="select 'y' from WEB#STUDENTVCREMARKS where INSTITUTECODE='"+mInst+"' and memberid='"+mStudid+"' and  MEMBERTYPE='"+mMemType+"' and INTRACTIONDATE=to_date('"+mInteractionDate+"','dd-mm-yyyy') and  RELATEDTO='"+mRelatedTo+"' and REMARKSTYPE='"+mRemarksType+"' and remarks=decode('"+mRemarks+"','',null,'"+mRemarks+"') ";
rss=db.getRowset(qrys);

if(!rss.next())
	   {

qry="select max(INTRACTIONSLNO) from  WEB#STUDENTVCREMARKS where INSTITUTECODE='"+mInst+"' and memberid='"+mStudid+"' and INTRACTIONDATE=to_date('"+mInteractionDate+"','dd-mm-yyyy') ";
qry=qry+" and MEMBERTYPE='"+mMemType+"'  ";
rs=db.getRowset(qry);
if(rs.next())
{
	mInteractionSlno=rs.getInt(1)+1;
}
else
{
	mInteractionSlno=1;
}


if(mORemarks.equals("Y"))
 {
	qry1="INSERT INTO WEB#REMARKSTYPE(INSTITUTECODE, REMARKSTYPE,ENTRYDATE, ENTRYBY)VALUES('"+mInst+"' ,'"+mRemarksType+"' ,sysdate, '"+mChkMemID+"' )";
	int n1=db.insertRow(qry1);
if(n1>0)
{
}
else
{
	out.print("<CENTER><font color=RED size=4 FACE=VERDANA><b>Error while saving record..</b></font>");
}
  } // closing of if(mORemarks.equals("Y"))


if(mORelated.equals("Y"))
   {
qry="INSERT INTO WEB#RELATEDTO(INSTITUTECODE, RELATEDTO,ENTRYDATE, ENTRYBY)VALUES('"+mInst+"' ,'"+mRelatedTo+"' ,sysdate, '"+mChkMemID+"' )";
	int n2=db.insertRow(qry);
if(n2>0)
{
}
else
{
	out.print("<CENTER><font color=RED size=4 FACE=VERDANA><b>Error while saving record..</b></font>");
}
   } // closing of if(mORelated.equals("Y"))



qry="INSERT INTO WEB#STUDENTVCREMARKS(INSTITUTECODE, MEMBERID, MEMBERTYPE,INTRACTIONDATE, INTRACTIONSLNO, RELATEDTO,   REMARKSTYPE, REMARKS, ENTRYDATE,ENTRYBY) VALUES ('"+mInst+"','"+mStudid+"','"+mMemType+"',to_date('"+mInteractionDate+"','dd-mm-yyyy') ,'"+mInteractionSlno+"' ,'"+mRelatedTo+"','"+mRemarksType+"','"+mRemarks+"' ,sysdate ,'"+mChkMemID+"' ) ";
int n=db.insertRow(qry);


if(n>0)
{
	out.print("<CENTER><font color=Green size=4 FACE=VERDANA><b>Record Saved successfully...</b></font><CENTER>");
}
else
{
	out.print("<CENTER><font color=red size=4 FACE=VERDANA><b>Error while saving record..</b></font><CENTER>");
}
	   }  // closing of if(!rss.next())

	   else
		   {
	out.print("<CENTER><font color=Green size=4 FACE=VERDANA><b>Record Saved successfully...</b></font>");

		   }
	   }
	   else
	{
	out.print("<CENTER><font color=RED size=4 FACE=VERDANA><b>Kindly Fill the Remarks you want to save . </b></font>");

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