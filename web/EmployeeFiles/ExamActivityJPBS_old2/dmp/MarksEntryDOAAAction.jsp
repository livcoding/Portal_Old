<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="TIET ";

%>
<html>
<head>
<TITLE>#### <%=mHead%> [ Marks Entry by Dean of Academic Affairs (DOAA)]</TITLE>
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
String mFacultytype="";
String mMOP="",mName6="",mName7="",mFlag="",flag="";
double mpercmarks=0;//,mMarks1=0;
if (session.getAttribute("Designation")==null)
{
	mDesg="";
}
else
{
	mDesg=session.getAttribute("Designation").toString().trim();
}
							
if (session.getAttribute("Department")==null)
{
	mDept="";
}
else
{
	mDept=session.getAttribute("Department").toString().trim();
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

	qry="Select WEBKIOSK.ShowLink('64','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
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
	<center><font size=4 font color="#a52a2a" >Marks Updation(By DOAA)</font></center>
			
			<hr>
			<table align='center' width='70%'>
			<tr><td bgcolor=red>&nbsp;&nbsp;&nbsp</td><td>Error/Notentered</td>
			<td bgcolor=Green>&nbsp;&nbsp;&nbsp</td><td>Marks saved/Modified</td>
			<td bgcolor="#3399cc">&nbsp;&nbsp;&nbsp</td><td>Detained</td>
			</tr></table>

			<table border=1 cellpadding=0 cellspacing=0 rules="All" align=center width=90%>
			<tr bgcolor=ff8c00>
			<td><b>Student name</b></td>
			<td><b>Semester</b></td>
			<td><b>Marks1(Old)</b></td>
			<td><b>Marks2(New)</b></td>
			<td><b>Status</b></td>
			</tr>

<%

			mINSTITUTECODE=request.getParameter("institute");
			mEventsubevent=request.getParameter("EventSubevent");
			mExam=request.getParameter("Exam");			
			mMax=Double.parseDouble(request.getParameter("MaxMarks"));
			mSubject=request.getParameter("subjectcode");
			mMOP=request.getParameter("Marksorpercentage"); 	
			mEmployeecode=request.getParameter("Employeecode");
			mFacultytype=request.getParameter("Facultytype");
     		   	// out.print(mMOP);
			if(mMOP.equals("P")) 
      		{       
			mMax1=mMax;
			mMax=100;
			}
			if(request.getParameter("Proceed")!=null)
				mProceed="Y";
			else
				mProceed="N";

		if(request.getParameter("TotalCount")!=null && Integer.parseInt(request.getParameter("TotalCount").toString().trim())>0)
		{ 
			mTotalCount =Integer.parseInt(request.getParameter("TotalCount").toString().trim());
			 flag="N";
			mFlag="N";
			for (ctr=1;ctr<=mTotalCount;ctr++)
		{			

			mName1="Semester"+String.valueOf(ctr).trim();  
			mName2="Studentid"+String.valueOf(ctr).trim();
			mName3="Marks"+String.valueOf(ctr).trim();
			mName4="Detained"+String.valueOf(ctr).trim();
			mName5="Fstid"+String.valueOf(ctr).trim();
			//mName6="OLDMARKSAWARDED"+String.valueOf(ctr).trim();
			mName8="Chkmarks"+String.valueOf(ctr).trim();
			mName7="OLDDETAINED"+String.valueOf(ctr).trim();
			try{
			if(request.getParameter(mName8)==null || request.getParameter(mName8).equals("") || request.getParameter(mName8).equals("-1"))
			{	
			mOldmarks=-1;
			mShowMarksold="";
			}
			else
			{
			mOldmarks=Double.parseDouble(request.getParameter(mName8));
		
			mShowMarksold=String.valueOf(mOldmarks);
			}
			}
			catch(Exception e)
			{
				mOldmarks=-1;
				mShowMarksold="";
			}   
		
			if (request.getParameter(mName7)==null || request.getParameter(mName7).equals("N"))
			{
				mOlddetained="N";
			}
			else
			{
				mOlddetained="Y";
			} 
			mSemester=request.getParameter(mName1);
			mStudentid=request.getParameter(mName2);
			try{
			if(request.getParameter(mName3)==null || request.getParameter(mName3).equals(""))
			{	
			mMarks=-1;
			mShowMarks="";
			}
			else
			{
			mMarks=Double.parseDouble(request.getParameter(mName3));
			mShowMarks=String.valueOf(mMarks);
			}
			}
			catch(Exception e)
			{
				mMarks=-1;
				mShowMarks="";
			}
			
			if (request.getParameter(mName4)==null)
			{
				mDetained="N";
			}
			else
			{
				mDetained="Y";
			}
			mFstid=request.getParameter(mName5);
			

		if(mOlddetained!=mDetained || mOldmarks!=mMarks)	
		{	kkk++;
			mFlag="Y";
			
		try{	
       	if(mDetained.equals("N") && (mMax<mMarks || mMarks<0))
		{	
		  qry="Select WEBKIOSK.getMemberName('"+mStudentid+"','S') SL from dual" ;
		  RsChk= db.getRowset(qry);
		  if(RsChk.next())
		  mSID=RsChk.getString(1);	
		 %>
			<tr>
			<td><%=GlobalFunctions.toTtitleCase(mSID)%></td>
			<td><%=mSemester%></td>
			<%
							if(mOlddetained.equals("Y"))
							{
						%>
						<td>Detained</td>
						<%
							}
							else if(mOlddetained.equals("N"))

							{
						%>
						<td><%=mShowMarksold%></td>
						<%
							}
						%>
	
			<td><%=mShowMarks%></td>
			<td><font color=red>(Not entered)</font></td>
			</tr>
	       <%	
		} 
		else
		{	//--1
			if(mMOP.equals("P"))
			{
					mpercmarks=(mMarks*mMax1)/100 ;
					if(mDetained.equals("Y"))
		  			{
					   qry="update STUDENTEVENTSUBJECTMARKS set MARKSAWARDED1=null,DETAINED='Y', ";
					   qry=qry+" MARKSAWARDED2=NULL,DETAINED2='Y' "; 
					   qry=qry+" where fstid='"+mFstid+"' and eventsubevent='"+mEventsubevent+"' ";
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
						<td><%=mSemester%></td>
						<%
							if(mOlddetained.equals("Y"))
							{
						%>
						<td>Detained</td>
						<%
							}
							else if(mOlddetained.equals("N"))

							{
						%>
						<td><%=mShowMarksold%></td>
						<%
							}
						%>

						<td>Detained </td> 
						<td><font color="#3399cc">(Updated)</font></td>
						</tr>
	      			<%
					   }	
					    else
					    {		
					       qry="update STUDENTEVENTSUBJECTMARKS set DETAINED=null,MARKSAWARDED1='"+mpercmarks+"', ";
					  	 qry=qry+" DETAINED2=null,MARKSAWARDED2='"+mpercmarks+"' where fstid='"+mFstid+"' and eventsubevent='"+mEventsubevent+"' ";
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
						<td><%=mSemester%></td>
					<%
							if(mOlddetained.equals("Y"))
							{
						%>
						<td>Detained</td>
						<%
							}
							else if(mOlddetained.equals("N"))

							{
						%>
						<td><%=mShowMarksold%></td>
						<%
							}
						%>
	
						<td><%=mMarks%></td>
						<td><font color=green>(Updated)</font></td>
						</tr>
	      			<%
	                       	     }
					
				
			  }	//------MOP=P
				else
				{    //-----------2 if Marks type then
				
				
					if(mDetained.equals("Y"))
		  			{
					   qry="update STUDENTEVENTSUBJECTMARKS set MARKSAWARDED1=NULL,DETAINED='Y', ";
					   qry=qry+" MARKSAWARDED2=NULL,DETAINED2='Y' where fstid='"+mFstid+"' and eventsubevent='"+mEventsubevent+"' ";
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
						<td><%=mSemester%></td>
						<%
							if(mOlddetained.equals("Y"))
							{
						%>
						<td>Detained</td>
						<%
							}
							else if(mOlddetained.equals("N"))

							{
						%>
						<td><%=mShowMarksold%></td>
						<%
							}
						%>
						<td>Detained</td> 
						<td><font color="#3399cc">(Updated)</font></td>
						</tr>
					<%
				   	}	
					    else
					    {		
					       qry="update STUDENTEVENTSUBJECTMARKS set DETAINED=null,MARKSAWARDED1='"+mMarks+"', ";
					  	 qry=qry+" DETAINED2=null,MARKSAWARDED2='"+mMarks+"' where fstid='"+mFstid+"' and eventsubevent='"+mEventsubevent+"' ";
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
						<td><%=mSemester%></td>
				
						<%
							if(mOlddetained.equals("Y"))
							{
						%>
						<td>Detained</td>
						<%
							}
							else if(mOlddetained.equals("N"))

							{
						%>
						<td><%=mShowMarksold%></td>
						<%
							}
						%>

						<td><%=mShowMarks%></td>
						<td><font color=green>(Updated)</font></td>
						</tr>
	      			<%
	                       	     }
					
		  }  //-------closing of mMOP else 2
		} //----else 1
	    }
		catch(Exception e)
		{	
		}
		
		} //------closing of comparision loop
		
		else
		{
		flag="Y";
		//out.print("No Changes in any marks of the Database.");
		}
	   }    //----------closing of for loop
// Log Entry
	  		   //-----------------
		
                db.saveTransLog(mINSTITUTECODE,mLogEntryMemberID,mLogEntryMemberType ,"MARKS UPDATION BY DOAA", "ExamCode: "+mExam +"EventSubevent :"+ mEventsubevent+ "SubjectCode :"+mSubject+"Fstid :"+mFstid +"MaxMarks : "+mMax, "NO MAC Address" , mIPAddress);
			   //-----------------
	%>
	</table> 
<%
	if(kkk<=0)
		out.print(" &nbsp;&nbsp;&nbsp <br><b><font size=3 face='Arial' color='Red'> No Changes in any marks of students in the Database. </font><br> <br>");
		
	else if(flag.equals("Y"))
	 	{
			  out.print(" &nbsp;&nbsp;&nbsp <br><b><font size=3 face='Arial' color='Red'> No Changes in any marks of rest of the students. </font><br> <br>");
			  qry=" Delete from STUDENTWISEGRADE ";
                    qry=qry+" where INSTITUTECODE='"+mINSTITUTECODE+"' and ExamCode='"+mExam+"' ";
			  qry=qry+" and SubjectCode='"+mSubject+"' ";			 
		 	   int a1=db.update(qry);

			   qry="Delete from  GRADECALCULATIONGRADES   ";
                    qry=qry+" where INSTITUTECODE='"+mINSTITUTECODE+"' and ExamCode='"+mExam+"' ";
			  qry=qry+" and SubjectCode='"+mSubject+"' "; 
			 int a2=a1+db.update(qry);
	
			  qry=" Delete from GRADECALCULATION ";
                    qry=qry+" where INSTITUTECODE='"+mINSTITUTECODE+"' and ExamCode='"+mExam+"' ";
			  qry=qry+" and SubjectCode='"+mSubject+"' ";
			  a2=a2+db.update(qry);

			  if (a2>1)
			  {
		  %>
				<br><hr><p><font color=Green size=4><ul><li>Marks Entry Completed! .
				Student subject Grades should be reexecuted or calculated since marks have been changed.	
				
				</ul></font><hr>
				
		  <%
			  }
			}
	

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
