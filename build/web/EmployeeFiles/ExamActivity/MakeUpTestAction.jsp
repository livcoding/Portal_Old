<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";

%>

<html>
<head>
<TITLE>#### <%=mHead%> [ Marks Entry by Dean of Academic Affairs (DOAA)]</TITLE>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
</script>


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

<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
String mDesg="",mDept="",mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="",mDMemberID="",mTotalRec="",mFstid="";
int ctr=0;
int mTotalCount=0;
int kkk=0;
String mName1="",mName2="",mSemester="",mStudentid="",mINSTITUTECODE="",mEventsubevent="";
String mExam="",mName3="",mSubject="",mSID="",mName4="",mDetained="",mProceed="",mName5="";;
double mMax=0,mMax1=0;
double mMarks=0,mOldmarks=0;
ResultSet rs=null,RsChk=null;
String qry="",mShowMarks="",mOlddetained="",mShowMarksold="",mName8="",mEmployeecode="";
String mFacultytype="",mMakeup="",mStatus="",mPrint="";
String mMOP="",mName6="",mName7="",mFlag="",flag="";
double mpercmarks=0;//,mMarks1=0;
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

	try{
	OLTEncryption enc=new OLTEncryption();
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
	{
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);
		mDMemberID=enc.decode(mMemberID);
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk1=null;

  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------

	qry="Select WEBKIOSK.ShowLink('103','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk1= db.getRowset(qry);
	if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
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

		
%>

		<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD colspan=0 align=middle class=pageheading>Marks Updation(By DOAA)</TD>
	</font></td></tr>
	</TABLE>	
			<hr>
			<table align='center' width='70%'>
			<tr><td bgcolor=red>&nbsp;&nbsp;&nbsp</td><td>Error/Notentered</td>
			<td bgcolor=Green>&nbsp;&nbsp;&nbsp</td><td>Marks saved/Modified</td>
			<td bgcolor="#3399cc">&nbsp;&nbsp;&nbsp</td><td>Detained/Absent</td>
			</tr></table>

			<table border=1 cellpadding=0 cellspacing=0 rules="All" align=center width=90%>
			<tr bgcolor=ff8c00>
			<td><b>Student name</b></td>
			<td><b>Flag</b></td>
			<td><b>Status</b></td>
			</tr>
	<%
			mINSTITUTECODE=request.getParameter("institute");
			mEventsubevent=request.getParameter("EventSubevent");
			mExam=request.getParameter("Exam");			
			
			mStatus=request.getParameter("Status");
		
     	    if(request.getParameter("TotalCount")!=null && Integer.parseInt(request.getParameter("TotalCount").toString().trim())>0)
		{ 
			mTotalCount =Integer.parseInt(request.getParameter("TotalCount").toString().trim());
			for (ctr=1;ctr<=mTotalCount;ctr++)
		  {			
			mName1="Detab"+String.valueOf(ctr).trim();
			mName2="Makeup"+String.valueOf(ctr).trim();
			mName3="Studentid"+String.valueOf(ctr).trim();
			mName4="Fstid"+String.valueOf(ctr).trim();
			mName5="SUBJECTCODE"+String.valueOf(ctr).trim();

			mFstid=request.getParameter(mName4);
			mStudentid=request.getParameter(mName3);
			mSubject=request.getParameter(mName5);

			if (request.getParameter(mName1)==null || request.getParameter(mName1).equals("N"))
			{
				mDetained="N";
			}
			else if(mStatus.equals("D"))
			{
				mDetained="D";
			} 
			else 
			{
				mDetained="A";
			} 
			if (request.getParameter(mName2)==null || request.getParameter(mName2).equals("N"))
			{
				mMakeup="N";
			}
			else
			{
				mMakeup="M";
			}
			if(mDetained.equals("D"))
			 mPrint="Deatined";
			else if(mDetained.equals("A"))
			mPrint="Absent";
			else
			mPrint="&nbsp;";
 	
		if(mMakeup.equals("M"))
		{
		   qry="update STUDENTEVENTSUBJECTMARKS set MARKSAWARDED1=NULL,DETAINED='M', ";
		   qry=qry+" MARKSAWARDED2=NULL,DETAINED2='M',entrydate=sysdate where fstid='"+mFstid+"' and eventsubevent='"+mEventsubevent+"' ";
		   qry=qry+" and studentid='"+mStudentid+"' ";
		   int n=db.update(qry);	
		   qry="Select WEBKIOSK.getMemberName('"+mStudentid+"','S') SL from dual" ;
		   RsChk= db.getRowset(qry);
		   if(RsChk.next())
		   {
			 mSID=RsChk.getString(1);	
		   }
		%>
		   <tr>
			<td><%=GlobalFunctions.toTtitleCase(mSID)%></td>	
			<td>MakeUp</font></td>	
			<td><font color=green>Updated</font></td>		
		   </tr>	
		<%
		}
		else
		{
		    qry="update STUDENTEVENTSUBJECTMARKS set MARKSAWARDED1=NULL,DETAINED='"+mDetained+"', ";
		    qry=qry+" MARKSAWARDED2=NULL,DETAINED2='"+mDetained+"',entrydate=sysdate where fstid='"+mFstid+"' and eventsubevent='"+mEventsubevent+"' ";
                qry=qry+" and studentid='"+mStudentid+"' ";
		    int n=db.update(qry);	
		    qry="Select WEBKIOSK.getMemberName('"+mStudentid+"','S') SL from dual" ;
		    RsChk= db.getRowset(qry);
		    if(RsChk.next())
		    {
		       mSID=RsChk.getString(1);	
		    }
		%>
		<tr>
			<td><%=GlobalFunctions.toTtitleCase(mSID)%></td>	
			<td><font color="#3399cc"><%=mPrint%></font></td>	
			<td><font color=green>Updated</font></td>		
		   </tr>	
		<%	
		}
		
	    }	 //----------closing of for loop
	  
	  // Log Entry
	   //-----------------
	               db.saveTransLog(mINSTITUTECODE,mLogEntryMemberID,mLogEntryMemberType ,"MAKEUP TEST ENTRY UPDATION BY DOAA", "ExamCode: "+mExam +"EventSubevent :"+ mEventsubevent+ "SubjectCode :"+mSubject+"Fstid :"+mFstid , "NO MAC Address" , mIPAddress);
	   //-----------------
	%>
		</table> 
	<%
	 //---------closing of totalcount loop  	
	}
	else
	{
	out.print("No record entered...");
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
//---------closing of session loop
	}
	else
	{
		out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}
//------------------try
     	}
	catch(Exception e)
	{
	}	
%>

