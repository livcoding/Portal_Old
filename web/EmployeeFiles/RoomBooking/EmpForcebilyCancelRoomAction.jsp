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
<TITLE>#### <%=mHead%> [ Room Cancellation ] </TITLE>

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

</head>

<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
	OLTEncryption enc=new OLTEncryption();
try
{
	DBHandler db=new DBHandler();
	ResultSet rs=null, rs1=null;
	String qry="", qry1="";
	int SNo=0;	
	int kk=0;
	int mFlag=0;
	String mCanceled="", mRCode="", mBkP="", mBkD="", mBkF="", mBkT="";
	String mName1="", mName2="", mName3="", mName4="", mName5="", mName6="";
	String mMemberID="";
	String mMemberType="";
	String mMemberCode="";
	String mEMemberCode="",mINSTITUTECODE="";

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

	if(!mMemberID.equals("") && !mMemberType.equals("")) 
	{
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	String mMacAddress =" "; //session.getAttribute("IPADD").toString().trim();

	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('28','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
  //----------------------
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

	if (request.getParameter("SNo")!=null && Integer.parseInt(request.getParameter("SNo").toString().trim())>0)
	{
	   SNo=Integer.parseInt(request.getParameter("SNo").toString().trim());
	   for (kk=1;kk<=SNo;kk++)
	   {
			mName1="checked_"+String.valueOf(kk).trim();
			mName2="RoomNo_"+String.valueOf(kk).trim();
			mName3="BookingPurpose_"+String.valueOf(kk).trim();
			mName4="BookingDate_"+String.valueOf(kk).trim();
			mName5="BookingFrom_"+String.valueOf(kk).trim();
			mName6="BookingTo_"+String.valueOf(kk).trim();

			mINSTITUTECODE==request.getParameter("INSTITUTE");
		if (request.getParameter(mName1)==null)
			mCanceled="";
		else
			mCanceled=request.getParameter(mName1);
		if (request.getParameter(mName2)==null)
			mRCode="";
		else
			mRCode=request.getParameter(mName2);
		if (request.getParameter(mName3)==null)
			mBkP="";
		else
			mBkP=request.getParameter(mName3);

		if (request.getParameter(mName4)==null)
			mBkD="";
		else
			mBkD=request.getParameter(mName4);

		if (request.getParameter(mName5)==null)
			mBkF="";
		else
			mBkF=request.getParameter(mName5);

		if (request.getParameter(mName6)==null)
			mBkT="";
		else
			mBkT=request.getParameter(mName6);

		//-----------------------------		
		//-----Update command to Cancel
		//-----------------------------

		if(mCanceled.equals("Y"))
		{
			qry="UPDATE ROOMBOOKINGINFO SET CANCELLATIONSTATUS='Y', CANCELLEDBY='"+mChkMemID+"', ";
			qry=qry+" CANCELLATIONDATE=SYSDATE WHERE ROOMCODE='"+mRCode+"' AND trunc(BOOKINGUPTODATE)>=trunc(sysdate) and NVL(DEACTIVE,'N')='N'";
			qry=qry+" and to_date(BOOKINGUPTOTIME,'dd-mm-yyyy hh mi pm')>=to_date(sysdate,'dd-mm-yyyy hh mi pm') and NVL(DEACTIVE,'N')='N'";
			qry=qry+" and BOOKINGPURPOSE='"+mBkP+"'";
			int n=db.update(qry);
			out.print(qry);
					if(n>0)						  
					{
			 			mFlag++;
//---- Log Entry
//-----------------
    db.saveTransLog(mINSTITUTECODE,mLogEntryMemberID,mLogEntryMemberType ,"CANCEL ROOM BOOKING", "Cancelled RoomCode :"+mRCode, "No MAC Address" , mIPAddress);
//-----------------
					}
				}
	   }							
			if(mFlag!=0)
			{
				out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp<b><font size=3 face='Arial' color='Green'>Room cancelled successfully.</b></center>");
				%>
					<table align=center>
						<tr><td>
		 					<a href ="EmpCancelRoomBooking.jsp"><img border=0 src='../../Images/Back.jpg'></a>
						</td></tr>
					</table>
				<%
		//	response.sendRedirect("EmpCancelRoomBooking.jsp");  	    
			}
			else
			{
				out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp<b><font size=3 face='Arial' color='Red'>Error while room cancellation.<br>Please select desired Room to be cancelled.</b></center>");
				%>
					<table align=center>
						<tr><td>
		 					<a href ="EmpCancelRoomBooking.jsp"><img border=0 src='../../Images/Back.jpg'></a>
						</td></tr>
					</table>
				<%
			}
	}
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	}
 	else
  {
   %>
	<font color=red>
	<h3><br><img src='../../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
	<P>This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font><br><br>
   <%
	}
  //-----------------------------
	}
	else
	{
	out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font></b></center>");
	}
}
catch(Exception e)
{
}
%>
</table>
</body>
</html>