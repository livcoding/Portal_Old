<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [Attendance of Previous Day  ] </TITLE>

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<%
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
OLTEncryption enc=new OLTEncryption();
String qry="",mWebEmail="";
String qry1="", qry2="";
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
int mSNO=0;
ResultSet rs=null,rs1=null,RsChk1=null;
String mInst="";
String mSID="";
String minst="",mSuggest="",mExam="",mmMemberType="";
String mName1="",mName2="",mName3="",mName4="",mName5="",mName6="";
	String mSelf="";
	int mTotalRec = 0;
	String Name="";
	String mApproved="";
	String mINSTITUTECODE="";
	String mFstid="";
	String mDate="";
	String mType="";
	String mStudentID="";
	String mPresent="";
	String mAbsent="";
	int kk=0;
	int TotalRec=0;
	int Ctr=0;
	String mName="";
	String Date="";
	String Type="";
	String Remarks=" ";	
	String mEmployeeid="";
	String mTfrom="";
	String mTupto="";
	String mRollno="";
	String mName7="";
	String mSno="";
			
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
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<center><font size=4> Status</font></center>
<hr>
<%
try 
{  //1
if(!mMemberID.equals("") && !mMemberType.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
{  //2

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mMacAddress =" "; //session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('82','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------
	try
	{	
		mDMemberCode=enc.decode(mMemberCode);
		mMemberID=enc.decode(mMemberID);
		mMemberType=enc.decode(mMemberType);
	}
	catch(Exception e)
	{
		out.println(e.getMessage());
	}
	if (request.getParameter("TotalRec")!=null && Integer.parseInt(request.getParameter("TotalRec").toString().trim())>0)
	{ 	//3
		mTotalRec=Integer.parseInt(request.getParameter("TotalRec").toString().trim());
		for (kk=1;kk<=mTotalRec;kk++)
		{  			
			
			mName3="Fstid"+String.valueOf(kk).trim();
			mName5="Employeeid"+String.valueOf(kk).trim();
			
 			mFstid= request.getParameter(mName3);
			mEmployeeid=request.getParameter(mName5);	
				
			Date=request.getParameter("ADATE");
			Type=request.getParameter("ATYPE");
			mTfrom=request.getParameter("Timefrom");
			mTupto=request.getParameter("Timeupto");
			
			if(mEmployeeid.equals(mMemberID))
			mSelf="Y";
			else
			mSelf="N";
if(request.getParameter("mTextname")==null)
			mSuggest=" ";	
		 else
			mSuggest=GlobalFunctions.replaceSignleQuot(request.getParameter("mTextname").toString().trim());
			if(mSuggest.length()>250)
				mSuggest=mSuggest.substring(0,249);
			if(mMemberType.equals("E"))
			  mmMemberType="I";
			else if(mMemberType.equals("S"))
				mmMemberType="S";
			else
				mmMemberType="E";
		qry=" insert into STUDENTATTENDANCEEXCUSED (FSTID, ATTENDANCEDATE, CLASSTIMEFROM, ";
		qry=qry+" CLASSTIMEUPTO, ATTENDANCETYPE, SELFATTENDANCE, ENTRYBYFACULTYID, ";
		qry=qry+" ENTRYBYFACULTYTYPE, ENRTYDATE, REMARKS ) ";
		qry=qry+" values('"+mFstid+"',To_date('"+Date+ "','dd-MM-yyyy'),To_date('"+mTfrom+"','dd-MM-yyyy HH:MI PM'), "; 
		qry=qry+" To_date('"+mTupto+"','dd-MM-yyyy HH:MI PM'),'"+Type+"','"+mSelf+"','"+mMemberID+"', ";
		qry=qry+" '"+mmMemberType+"',sysdate,'"+mSuggest+"')";
		int n=db.insertRow(qry);
	   	

		//out.print(qry);
	 } // closing of for
response.sendRedirect("DailyStudentAttendanceEntry.jsp");

    } //3
     else
   {
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" <b><font size=3 face='Arial' color='Red'>Please Mark the Excuse first !</font>");
	//out.print("<p><a href=DailyStudentAttendanceEntry.jsp><img src='../../Images/Back.jpg' border=0 ></a></p>");  

	}

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

}  //2
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
}	//1	
catch(Exception e)
{
	//out.print("No Item Selected..."+qry);
//	out.println(e.getMessage());
}
%>
<table ALIGN=Center VALIGN=TOP>
		<tr>
		<td valign=middle>
		<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">
		<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
		A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
		<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>  
		</td></tr></table>
</body>
</html>
