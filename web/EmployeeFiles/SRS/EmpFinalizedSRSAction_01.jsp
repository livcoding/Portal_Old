<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="TIET ";
%>
<HTML>
<HEAD>
<TITLE>#### <%=mHead%> [ Student Reaction Survey (SRS) Finalization ] </TITLE>
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
</script>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</HEAD>

<style type="text/css"> 
body {scrollbar-3dlight-color:#ffd700;
scrollbar-arrow-color:#ff0; 
scrollbar-base-color:=:#000ff0;
scrollbar-darkshadow-color:#000000; 
scrollbar-face-color:#de6400; 
scrollbar-highlight-color:#9900005;
scrollbar-shadow-color:#f0f} 
</style> 

<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%

DBHandler db=new DBHandler();
//GlobalFunctions gb =new GlobalFunctions();
		OLTEncryption enc=new OLTEncryption();
String qry="",mWebEmail="";
String qry1="",mLTP="",myLTP="", qry2="";
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
int mSNO=0;
ResultSet rs=null,rs1=null;
ResultSet RsFSTID=null;
int More=1;
int mLevel=0;
String mInst="";
String minst="";
String mName1="",mName2="",mName3="",mName4="",mName5="",mName6="",mName7="",mName8="",mName9="",mName10="";


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



%>
 
<center><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Finalization Status</B></font></center>
<hr>
<table border=1 cellpadding=3 cellspacing=1 rules="All" align=center>
<tr bgcolor="#ff8c00">
<td><b><FONT COLOR=WHITE>Program</FONT></b></td>
<td NOWRAP><b><FONT COLOR=WHITE>Section-Subsection</FONT></b></td>
<td><b><FONT COLOR=WHITE>Subject</FONT></b></td>
<td><b><FONT COLOR=WHITE>LTP</FONT></b></td>
<td><b><FONT COLOR=WHITE>Faculty</FONT></b></td>
<td><b><FONT COLOR=WHITE>Status</FONT></b></td>
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
	qry="Select WEBKIOSK.ShowLink('47','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
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
	String mApproved="";
	String mExamCode="";
	String mINSTITUTECODE="";
	String mEmployeeID="";
	String mPROGRAMCODE="";
	String mSUBJECTCODE="";
	String mSUBJECTID="";
	String mSRSEVENTCODE="";
	String mSec="", mSubSec="";
	String mEName=" ";
	int kk=0;
	int kk1=0;
	
	if (request.getParameter("TotalRec")!=null && Integer.parseInt(request.getParameter("TotalRec").toString().trim())>0)
	{  //3
	mTotalRec =Integer.parseInt(request.getParameter("TotalRec").toString().trim());
	for (kk=1;kk<=mTotalRec ;kk++)
	{
		mName1="EmployeeID_"+String.valueOf(kk).trim(); 		 		
		mName2="PROGRAMCODE_"+String.valueOf(kk).trim(); 		 		
		mName3="SUBJECTCODE_"+String.valueOf(kk).trim(); 		 		
		mName4="LTP_"+String.valueOf(kk).trim(); 		 		
		mName5="Approved_"+String.valueOf(kk).trim(); 		 		
		mName6="ExamCode_"+String.valueOf(kk).trim(); 		 		
		mName7="EmployeeNM_"+String.valueOf(kk).trim(); 		 		
		mName8="Section_"+String.valueOf(kk).trim();
		mName9="SubSection_"+String.valueOf(kk).trim();
		mName10="SUBJECTID_"+String.valueOf(kk).trim(); 		 		
		mApproved= request.getParameter(mName5);
		if (request.getParameter(mName6)==null)
			mExamCode= "";
		else
			mExamCode= request.getParameter(mName6);
		
		mINSTITUTECODE= request.getParameter("INSTITUTECODE");
		mSRSEVENTCODE=request.getParameter("SRSEVENTCODE");
		mEmployeeID= request.getParameter(mName1);
		mPROGRAMCODE= request.getParameter(mName2);
		mSUBJECTCODE= request.getParameter(mName3);
		mSUBJECTID= request.getParameter(mName10);
		mSec= request.getParameter(mName8);
		mSubSec= request.getParameter(mName9);

		if(request.getParameter(mName4)==null)
			mLTP= "";
		else
			mLTP= request.getParameter(mName4).toString().trim();
			

		myLTP="";
		for (int kkk=0;kkk<mLTP.length();kkk++)
		{		
			if (kkk==0)
				myLTP="'"+mLTP.substring(kkk,kkk+1)+"'";
			else
				myLTP=myLTP+",'"+mLTP.substring(kkk,kkk+1)+"'";			
		}
		mLTP= myLTP;
		mEName= request.getParameter(mName7);
		int n=0;
		if(mApproved!=null)
		{

				kk1++;

				qry = " select FSTID,ltp from FacultySubjectTagging Where INSTITUTECODE='"+mINSTITUTECODE+"'";
				qry = qry +"  AND EXAMCODE='" + mExamCode + "' and  PROGRAMCODE='"+ mPROGRAMCODE + "'";
				qry = qry +" AND SUBJECTID='"+mSUBJECTID+"' AND  EmployeeID='"+mEmployeeID+"'";
				qry = qry +" And SectionBranch='"+mSec+"' and SubSectionCode='"+mSubSec+"' And LTP IN("+mLTP+")";
				//out.print(qry);
				RsFSTID = db.getRowset(qry);
				while(RsFSTID.next())
		  		{
				 qry="UPDATE SRSEVENTS SET Finalized='Y' ,FINALIZEDBY='"+mMemberID+"' , ";
				 qry=qry +" FINALIZEDDATE=SYSDATE WHERE FSTID='"+RsFSTID.getString(1)+"' and SRSEVENTCODE='"+mSRSEVENTCODE+"' and nvl(Approved,'N')='Y'";
				 n=db.update(qry);
				// Log Entry
	  		   //-----------------
			    db.saveTransLog(mINSTITUTECODE,mLogEntryMemberID,mLogEntryMemberType ,"SRS FINALIZATION", mSRSEVENTCODE+" "+mSUBJECTCODE+" "+mEmployeeID+" "+mSec+"-"+mSubSec+" "+RsFSTID.getString("ltp"), "No MAC Address" , mIPAddress);
			   //-----------------
				
			//	db.saveTransLog(mINSTITUTECODE,mMemberID,mMemberType,"SRS Finalized",mSRSEVENTCODE+" "+mSUBJECTCODE+" "+mEmployeeID+" "+mSec+"-"+mSubSec+" "+RsFSTID.getString("ltp"), mMacAddress ,mIPAddress );
				}
	
		}
			if (n>0)
			{
				%>
				<tr><td><%=mPROGRAMCODE%></td><td><%=mSec%>-<%=mSubSec%></td><td><%=mSUBJECTCODE%>&nbsp; &nbsp; &nbsp;&nbsp;</td><td><%=GlobalFunctions.getSortedLTPSQ(mLTP)%></td><td><font size=2><%=mEName%></font></td><td><font color=Green>Finalized</font></td></tr>
				<%
			}
			else
			{
			%>
				<tr><td><%=mPROGRAMCODE%></td><td><%=mSec%>-<%=mSubSec%></td><td><%=mSUBJECTCODE%>&nbsp; &nbsp; &nbsp;&nbsp;</td><td><%=GlobalFunctions.getSortedLTPSQ(mLTP)%></td><td><font size=2><%=mEName%></font></td><td><font color=Green>Not Finalized</font></td></tr>
			<%
			}

	   }
//	}

  	  
 
%>
</table>
<h3 align=center>
<%=kk1%> SRSs have been approved (see above status) <br>
</h3>

<%
	
 	} //3
	else
	{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Please select approved check box to finalize the respective SRS!</font> <br>");
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
