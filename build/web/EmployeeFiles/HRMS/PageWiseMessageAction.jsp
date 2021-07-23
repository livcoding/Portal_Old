<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="";
int n=0;
double mPAID=0,mLWP=0,mTotalLvDays=0;
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInst="", mComp="";
String mWebEmail="";
String mRightsID="",QryRights="",mEventFrom="",mEventTo="",mCurDate="",mMessFrom="";
String mMessTo="",mMarquee="",mPrior="",mStaff="",mStudent="",mEmployee="",mRelated="";

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
if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}

if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}

if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
}

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Leave Request ] </TITLE>
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
</script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<script language=javascript>
	<!--
	function RefreshContents()
	{ 	
    	    document.frm.x.value='ddd';
    	    document.frm.submit();
	}
//-->
</script>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
try
{
	OLTEncryption enc=new OLTEncryption();
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{
		mDMemberID=enc.decode(mMemberID);
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);
		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk=null;

		qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from institutemaster WHERE nvl(Deactive,'N')='N' ";
		rs=db.getRowset(qry);
		if(rs.next())
			mInst=rs.getString(1);	
		else
			mInst="JIIT";
		
	//-----------------------------
	  //-- Enable Security Page Level  
	  //-----------------------------
	  
		qry="Select WEBKIOSK.ShowLink('169','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
		  //----------------------
		  	%>
			<form name="frm"  method="post">
			<input id="x" name="x" type=hidden>
			<br><br>
			<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
			<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: Large; FONT-FAMILY: fantasy"><b>Rights ID Action !!!</b></font></td></tr>
			</TABLE>
			<br>
	<%
 	            // For Log Entry 
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
					
					
	if(request.getParameter("Rights")!=null)
		QryRights=request.getParameter("Rights").toString().trim();
		else
			QryRights="";

	if(request.getParameter("Marquee")!=null)
			mMarquee=request.getParameter("Marquee").toString().trim();
		else
			mMarquee="";

		if(request.getParameter("EventFrom")!=null)
				mEventFrom=request.getParameter("EventFrom").toString().trim();
				else
				mEventFrom="";
			
		if(request.getParameter("EventTo")!=null)
			mEventTo=request.getParameter("EventTo").toString().trim();
			else
			mEventTo="";
				
		if(request.getParameter("MessFrom")!=null)
			mMessFrom=request.getParameter("MessFrom").toString().trim();
			else
			mMessFrom="";		
			
		if(request.getParameter("MessTo")!=null)
				mMessTo=request.getParameter("MessTo").toString().trim();				
				else
				mMessTo="";

		if(request.getParameter("Staff")!=null)
				mStaff=request.getParameter("Staff").toString().trim();				
				else
				mStaff="";

		if(request.getParameter("Employee")!=null)
				mEmployee=request.getParameter("Employee").toString().trim();				
					else
				mEmployee="";

		if(request.getParameter("Student")!=null)
				mStudent=request.getParameter("Student").toString().trim();				
					else
				mStudent="";


		if((mStaff.equals("V")) && (mStudent.equals("S")) && (mEmployee.equals("E")))
			{
				mRelated=mStudent + mStaff + mEmployee;
			}
		else if((mStaff.equals("V")) && (mStudent.equals("S")))
			{
				mRelated=mStaff	+ mStudent;
			}
		else if((mStudent.equals("S")) && (mEmployee.equals("E")))
			{
				mRelated=mEmployee	+ mStudent;
			}
		else if((mEmployee.equals("E")) && (mStaff.equals("V")))
			{
			mRelated=mEmployee + mStaff; 
			}
		else if(mEmployee.equals("E"))
			{
			mRelated=mEmployee;
			}
		else if(mStaff.equals("V"))
			{
			mRelated=mStaff;
			}
		else if(mStudent.equals("S"))
			{
			mRelated=mStudent;
			}

			if(!QryRights.equals(""))
			{
			qry="SELECT 'Y' from PAGEBASEDMEESSAGES where RIGHTSID='"+QryRights+"' "; 
			rs=db.getRowset(qry);
			
			if(!rs.next())
			{
			   qry="INSERT INTO PAGEBASEDMEESSAGES (RIGHTSID, MARQUEEMESSAGE, RELATEDTO, EVENTFROMDATETIME, EVENTTODATETIME, MESSAGEFLASHFROMDATETIME,MESSAGEFLASHUPTODATETIME) VALUES ( '"+QryRights+"','"+mMarquee+"','"+mRelated+"',(to_date('"+mEventFrom+"','dd-mm-yyyy')),(to_date('"+mEventTo+"','dd-mm-yyyy')) ,(to_date('"+mMessFrom+"','dd-mm-yyyy')) ,(to_date('"+mMessTo+"','dd-mm-yyyy')))";
				n=db.insertRow(qry);
				if(n>0)
					{
					// Log Entry
					//-----------------
 					db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType,"INSERT RIGHTSID ", "RightsID :"+QryRights+" Marquee Message :"+mMarquee, "NO MAC ADDRESS",  mIPAddress);
					//-----------------	
					response.sendRedirect("PageWiseMessageEntry.jsp?Rights="+QryRights+"&x=");
					}
				else
					{
						%><CENTER><%
						out.print("<img src='../../Images/Error1.jpg'>");
						out.print("<font size=4 color=red face='arial'><b>Error while saving record...</b></font>");
						%></CENTER><%
					}
								
			}//End of !rs.next
		else 
			{
				qry="UPDATE PAGEBASEDMEESSAGES SET  RIGHTSID='"+QryRights+"', MARQUEEMESSAGE='"+mMarquee+"',RELATEDTO='"+mRelated+"',    EVENTFROMDATETIME=(to_date('"+mEventFrom+"','dd-mm-yyyy')), EVENTTODATETIME=(to_date('"+mEventTo+"','dd-mm-yyyy')), MESSAGEFLASHFROMDATETIME=(to_date('"+mMessFrom+"','dd-mm-yyyy')),MESSAGEFLASHUPTODATETIME=(to_date('"+mMessTo+"','dd-mm-yyyy')) where  RIGHTSID='"+QryRights+"' ";
				int m=db.update(qry);
				if(m>0)
					{	
					// Log Entry
					//-----------------
					db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType,"UPDATE RIGHTSID ", "RightsID :"+QryRights+" Marquee Message :"+mMarquee, "NO MAC ADDRESS",  mIPAddress);	
					response.sendRedirect("PageWiseMessageEntry.jsp?Rights="+QryRights+"&x=");
					}
				else
					{
						%><CENTER><%
						out.print("<img src='../../Images/Error1.jpg'>");
						out.print("<font size=4 color=red face='arial'><b>Error while saving record...</b></font>");
						%></CENTER><%
					}
				}
		}//End of !QryRights
		else
			{
			%><CENTER><%
			out.print("<img src='../../Images/Error1.jpg'>");
			out.print("<br>&nbsp;&nbsp;&nbsp <font size=4 face='Arial' color='Red'><b>RightsID Should not be Empty ! &nbsp; Kindly review the criteria...</b></font>");
			%></CENTER><%
			}
			//-----------------------------
			//-- Enable Security Page Level  
			//-----------------------------
		}//end of RsChk
 	else
   		{
		%>
			<br>
			<font color=red>
			<h3><br><img src='../../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
			<P>This page is not authorized/available for you.
			<br>For assistance, contact your network support team. 
			</font><br><br><br><br> 
   		<%
  		}
		//-----------------------------
	}
	else
	{
		out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}      
}//try end
catch(Exception e)
{
	out.print(" Error is there!!!!");
}
%>
<br><br>
<table ALIGN=Center VALIGN=TOP>
<tr>
<td valign=middle>
<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">
<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>  
</td></tr></table>
</form>
</body>
</html>