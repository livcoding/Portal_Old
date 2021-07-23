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
<TITLE>#### <%=mHead%> [ Printing approval of Student Reaction Survey  ] </TITLE>

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<hr>
<%

DBHandler db=new DBHandler();
ResultSet RsChk=null;
OLTEncryption enc=new OLTEncryption();
String qry="",mWebEmail="";
String qry1="",qry2="";
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
int mSNO=0;

String mInst="";
String minst="";
String mName1="";	


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



try 
{  //1
if(!mMemberID.equals("") && !mMemberType.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
{  //2

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mMacAddress =" "; //session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('26','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
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
	int  mTotalRec = 0;
	String mradio="";
	String mINSTITUTECODE="";
	String mFROMDATE="";
	String mTODATE="";
	String mFROMTIME="";
	String mUPTOTIME="";
	String mTEXT="";
	
	int kk=0;
	int kk1=0;

		 if(request.getParameter("radio")==null ||(request.getParameter("radio").toString().trim()).equals(""))
		 {
			// mradio="" ;	
			out.print("<br><img src='../../Images/Error1.jpg'>");
			out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Please select a room for booking.!</font> <br>");

		 }		
		 else
		 {
			mradio= request.getParameter("radio").toString().trim();		
		  
		mINSTITUTECODE= request.getParameter("INSTITUTECODE");
		mFROMDATE=request.getParameter("FROMDATE");
		mTODATE=request.getParameter("TODATE");
		mFROMTIME=request.getParameter("FROMTIME");
		mUPTOTIME=request.getParameter("UPTOTIME");
		if(request.getParameter("TEXT")==null ||(request.getParameter("TEXT").toString().trim()).equals(""))
		 {
			//mTEXT="" ;	
			out.print("<br><img src='../../Images/Error1.jpg'>");
			out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Please enter the purpose of booking.!</font> <br>");

		 }		
		 else
		 {
			mTEXT=request.getParameter("TEXT").toString().trim();		
		// }		
		if(mradio!=null)
		{

		qry="Select 'Y' from ROOMBOOKINGINFO";
		qry=qry+" Where  INSTITUTECODE='"+mINSTITUTECODE+"' and ROOMCODE='"+mradio+"'";
		qry=qry+" And to_char(BOOKINGFROMDATE,'dd-MM-yyyy')='" +mFROMDATE+ "' and to_char(BOOKINGUPTODATE,'dd-mm-yyyy') ='" +mTODATE+ "'";
		qry=qry+" And to_char(BOOKINGFROMTIME,'dd-MM-yyyy HH:MI PM')='"+mFROMTIME+"' and to_char(BOOKINGUPTOTIME,'dd-MM-yyyy HH:MI PM')='"+mUPTOTIME+"' ";
				
	      RsChk= db.getRowset(qry);
		if (RsChk.next())
		   {
			%>
		<p align=center>
			<font color='green' size=3 face='arial'>Room is already booked for the period <%=mFROMDATE%> to <%=mTODATE%> <br></font>
			</p>
		 <%
		  }
		else
		  {
			qry="insert into ROOMBOOKINGINFO (INSTITUTECODE, ROOMCODE, BOOKINGPURPOSE, BOOKINGFROMDATE, ";
			qry=qry+" BOOKINGUPTODATE, BOOKINGFROMTIME, BOOKINGUPTOTIME,  ";
			qry=qry+" BOOKEDBY, BOOKINGDATETIME ) values ('"+mINSTITUTECODE+"','"+mradio+"','"+mTEXT+"', ";
			qry=qry+" To_date('" +mFROMDATE+ "','dd-MM-yyyy'),To_date('" +mTODATE+ "','dd-MM-yyyy'), ";
			qry=qry+" to_date('"+mFROMTIME+"','dd-MM-yyyy HH:MI PM'),to_date('"+mUPTOTIME+"','dd-MM-yyyy HH:MI PM'),'"+mMemberID+"',sysdate) ";

			int n=db.insertRow(qry);
			if (n>0)
			{
			   // Log Entry
	  		   //-----------------
			    db.saveTransLog(mINSTITUTECODE,mLogEntryMemberID,mLogEntryMemberType ,"ROOM BOOKING", "Booked RoomCode : "+mradio +" for "+ mFROMTIME, "No MAC Address" , mIPAddress);
			   //-----------------
		 	   %>
			   <p align=center>
			   <font color='green' size=3 face='arial'>Room has been booked for the Period <%=mFROMDATE%> To <%=mTODATE%> <br>Time From <%=mFROMTIME%> to <%=mUPTOTIME%><br> Purpose of Booking:<%=mTEXT%></font>
			   </p>
			   <%
			}			
		   }
		}
		}
		
	} //------ closing of else.........

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
	out.print("No Item Selected...");
//	out.println(e.getMessage());
}
%>
<br>
<hr>
<table ALIGN=Center VALIGN=Bottom>
		<tr>
		<td valign=middle>
		<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">
		<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
		A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
		<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>  
		</td></tr></table>
</body>
</html>
