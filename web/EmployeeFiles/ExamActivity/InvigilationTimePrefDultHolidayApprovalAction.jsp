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
<TITLE>#### <%=mHead%> [ Leave approval on Invigilation Duty ] </TITLE>

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<%
DBHandler db=new DBHandler();
//GlobalFunctions gb =new GlobalFunctions();
OLTEncryption enc=new OLTEncryption();
String qry="",mWebEmail="";
String qry1="",mLTP="",myLTP="", qry2="";
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
int mSNO=0;
ResultSet rs=null,rs1=null;
ResultSet RsFSTID=null,rs3=null;
int More=1;
int mLevel=0;
String mInst="",mEmpname="";
String minst="";
String mName1="",mName2="",mName3="",mName4="",mName5="",mName6="";

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
<center><font size=4>Approval Status </font></center>
<hr>
<table border=1 cellpadding=3 cellspacing=1 rules="All" align=center>
<tr bgcolor=ff8c00>
<td><b>Invigilator Name</b></td>
<td><b>Status</b></td>
</tr>
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
	qry="Select WEBKIOSK.ShowLink('92','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
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
	String mApproved="";
	String mExamCode="";
	String mINSTITUTECODE="";
	String mEmployeeID="";
	String mPROGRAMCODE="";
	String mSUBJECTCODE="";
	String mSRSEVENTCODE="";
	String mINVIGILATORTYPE="";

	String mSec="", mSubSec="";
	String mEName="",mPrefromtime="",mTotime="";
	int kk=0;
	int kk1=0;
	
	if (request.getParameter("TotalRec")!=null && Integer.parseInt(request.getParameter("TotalRec").toString().trim())>0)
	{  //3
	mTotalRec =Integer.parseInt(request.getParameter("TotalRec").toString().trim());
	for (kk=1;kk<=mTotalRec ;kk++)
	{
			mName1="Approved_"+String.valueOf(kk).trim(); 
			mName2="EmployeeID_"+String.valueOf(kk).trim(); 
			mName3="Prefromtime_"+String.valueOf(kk).trim(); 				
			mName4="Totime_"+String.valueOf(kk).trim(); 
			mName5="Type_"+String.valueOf(kk).trim(); 
			mName6="Ename_"+String.valueOf(kk).trim(); 
		if (request.getParameter(mName1)==null)
			{
				mApproved="N";
			}
			else
			{
				mApproved="Y";
			}
		mINSTITUTECODE= request.getParameter("INSTITUTECODE");
		mEmployeeID= request.getParameter(mName2);
		mPrefromtime= request.getParameter(mName3);
		mTotime= request.getParameter(mName4);
		mINVIGILATORTYPE=request.getParameter(mName5);
		mEmpname=request.getParameter(mName6);
		qry="select nvl(EXAMCODE,' ')ExamCode from INVIGILATIONTIMEPREF where Institutecode='"+mINSTITUTECODE+"'";
		qry=qry+" and Invigilatorid='"+mEmployeeID+"' and to_char(PREFROMDATE,'dd-mm-yyyy')='"+mPrefromtime+"'";
		qry=qry+" and to_char(PRETODATE,'dd-mm-yyyy')='"+mTotime+"' and INVIGILATORTYPE='"+mINVIGILATORTYPE+"'";
		rs3=db.getRowset(qry);
		//out.print(qry);
		if(rs3.next())
			mExamCode=rs3.getString(1);
		if(mApproved.equals("Y"))
		{	
		
			qry="update INVIGILATIONTIMEPREF set Approved='Y',approveddate=sysdate,approvedby='"+mMemberID+"' where ";
			qry=qry+" institutecode='"+mINSTITUTECODE+"' and EXAMCODE='"+mExamCode+"' and ";
			qry=qry+" INVIGILATORID='"+mEmployeeID+"' and trunc(PREFROMDATE)=trunc(to_date('"+mPrefromtime+"','dd-mm-yyyy')) and trunc(PRETODATE)=trunc(to_date('"+mTotime+"','dd-mm-yyyy')) ";		
			int n=db.update(qry);	
			//out.print(qry);
// Log Entry
		   //-----------------
			    db.saveTransLog(mINSTITUTECODE,mLogEntryMemberID,mLogEntryMemberType ,"INVIGILATION DUTY APPROVAL", "DutyApproval,EmployeeID:"+mEmployeeID +" ExamCode:"+mExamCode +" FromDate:"+mPrefromtime +" ToDate:"+mTotime, "No MAC Address" , mIPAddress);
			   //-----------------

		
		}
		else
		{
			qry="update INVIGILATIONTIMEPREF set Approved=NULL,approveddate=NULL,approvedby=NULL where ";
			qry=qry+" institutecode='"+mINSTITUTECODE+"' and EXAMCODE='"+mExamCode+"' and ";
			qry=qry+" INVIGILATORID='"+mEmployeeID+"' and trunc(PREFROMDATE)=trunc(to_date('"+mPrefromtime+"','dd-mm-yyyy')) and trunc(PRETODATE)=trunc(to_date('"+mTotime+"','dd-mm-yyyy')) ";		
			int n=db.update(qry);	
			//out.print(qry);
	         //-------- Log Entry
		   //-----------------
		     db.saveTransLog(mINSTITUTECODE,mLogEntryMemberID,mLogEntryMemberType ,"INVIGILATION DUTY APPROVAL", "Duty Unapproval,EmployeeID:"+mEmployeeID +" ExamCode:"+mExamCode +" FromDate:"+mPrefromtime +" ToDate:"+mTotime, "No MAC Address" , mIPAddress);
			   //-----------------
		}
		%>
			<tr>
			<td><font size=2><%=mEmpname%></font></td>
		<%
			if(mApproved.equals("Y"))
			{
		%>		
			<td><font color=green>Approved</font></td>				
		<%
			}
			else
			{	
		%>		
			<td><font color=red>Not Approved</font></td>				
			</tr>
		<%		
			}


		}
	%>
		</table>
	<%
 	} //3
	else
	{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Please select the check box to approv the respective request!</font> <br>");
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
	out.print("No Item Selected...");
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