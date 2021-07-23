<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*" %>
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
<TITLE>#### <%=mHead%> [ Attendance Status  ] </TITLE>



<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />




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

String  mTfrom1="",mTupto1="",Type1="";


int Ctr1=0;
String mName11="",mSID1="",mRollno1="";
String mName12="",mName13="",mName14="";
     String mName15="",mName16="",mName17="",mName18="",mAttDate="",mSelf1="";
String mPresent1="", mFstid1="",  mStudentID1="",     mEmployeeid1=""  ;

String minst="";
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
			


if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}

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
    <form id="frm">
<center><font size=4 face=arial  color="#a52a2a">Attendance Status</font></center>
<hr>
<table border=1 cellpadding=3 cellspacing=1 rules="All" align=center class="sort-table" id="table-1" >
<tr bgcolor=ff8c00>
<td><font color="White"><b><b>SNo.</b></td>	
<td><font color="White"><b><b>Enrollment No.</b></td>
<td><font color="White"><b><b>Student Name</b></td>	
<td><font color="White"><b><b>Status</b></td>
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

      qry="Select WEBKIOSK.ShowLink('82','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      
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
	if(mMemberType.equals("E"))
	    mMemberType="I";
	else if(mMemberType.equals("S"))
	    mMemberType="S";
	else
	    mMemberType="E";

String mDTExtraupto="",mDTExtrafrom="";

int TotalRec1=0;    
	TotalRec1 =Integer.parseInt(request.getParameter("TotalRec1").toString().trim());

	if ( (request.getParameter("TotalRec")!=null && Integer.parseInt(request.getParameter("TotalRec").toString().trim())>0) || (TotalRec1>0) )
	{ 	//3
		mTotalRec=Integer.parseInt(request.getParameter("TotalRec").toString().trim());
		
	
		Date=request.getParameter("ADATE");
			
			mTfrom=request.getParameter("Timefrom");
			mTupto=request.getParameter("Timeupto");
			mINSTITUTECODE= request.getParameter("INSTITUTE");	
			Type=request.getParameter("ATYPE");


         /* left attenadance */
            

              
				if(request.getParameter("mDTExtrafrom")==null)
				mDTExtrafrom="";
				else					
				mDTExtrafrom=request.getParameter("mDTExtrafrom");
						
				if(request.getParameter("mDTExtraupto")==null)
				mDTExtraupto="";
				else					
				mDTExtraupto=request.getParameter("mDTExtraupto");
	
		
		
		for (kk=1;kk<=mTotalRec;kk++)
		{  			
			mName1="Present"+String.valueOf(kk).trim(); 	
			mName2="Absent"+String.valueOf(kk).trim(); 
			mName3="Fstid"+String.valueOf(kk).trim();
			mName4="StudID"+String.valueOf(kk).trim();
	      		mName5="Employeeid"+String.valueOf(kk).trim();
		//	mName6="Enrollment"+String.valueOf(kk).trim();
			mName7="SNo"+String.valueOf(kk).trim();
		

		
			mPresent=request.getParameter(mName1);
			mFstid= request.getParameter(mName3);
			mStudentID= request.getParameter(mName4);
			mEmployeeid=request.getParameter(mName5);	
			//mRollno=request.getParameter(mName6);
			mSno=request.getParameter(mName7);			
			
			
						
			if(mEmployeeid.equals(mMemberID))
			mSelf="Y";
			else
			mSelf="N";
				
		

			if(mPresent!=null || mAbsent!=null)
			{  //4
			  qry="select 'y' from studentattendance where fstid='"+mFstid+"' and studentid='"+mStudentID+"' ";
			  qry=qry+" and ATTENDANCEDATE=To_date('"+Date+ "','dd-MM-yyyy') and CLASSTIMEFROM=To_date('"+mTfrom+"','dd-MM-yyyy HH24:MI') ";
			  qry=qry+" and CLASSTIMEUPTO=To_date('"+mTupto+"','dd-MM-yyyy HH24:MI') ";
			   qry=qry+" and ATTENDANCETYPE='"+Type+"' ";	
               //            out.print(qry);
	               rs=db.getRowset(qry);	
			  if(!rs.next())
			  {	
                    	if(mPresent.equals("P"))
				{
					qry="Insert into Studentattendance (FSTID, STUDENTID, ATTENDANCEDATE, ";
					qry=qry+"  CLASSTIMEFROM, CLASSTIMEUPTO, ATTENDANCETYPE, PRESENT, ";
					qry=qry+" SELFATTENDANCE, ENTRYBYFACULTYID, ENTRYBYFACULTYTYPE, ";
					qry=qry+" ENRTYDATE, REMARKS )";
					qry=qry+" values('"+mFstid+"','"+mStudentID+"',To_date('"+Date+ "','dd-MM-yyyy'),To_date('"+mTfrom+"','dd-MM-yyyy HH24:MI'),To_date('"+mTupto+"','dd-MM-yyyy HH24:MI'),'"+Type+"', ";
					qry=qry+" 'Y','"+mSelf+"','"+mMemberID+"','"+mMemberType+"',sysdate,'"+Remarks+"') ";
					//out.print(qry);
					int n=db.insertRow(qry);
				
					qry="Select nvl(Studentname,' ')Studentname ,nvl(Enrollmentno,' ')Enrollmentno from  Studentmaster where nvl(Deactive,'N')='N' AND STUDENTID='"+mStudentID+"' " ;
					RsChk1= db.getRowset(qry);
					if(RsChk1.next())
			      		{
			 		  mSID=RsChk1.getString(1);	
					  mRollno=RsChk1.getString(2);	
					}
					%>
					<tr>
					<td><%=++Ctr%></td>
					<td><%=mRollno%></td>
					<td><%=GlobalFunctions.toTtitleCase(mSID)%></td>
					<td><font color=green>Present</font></td>
					<tr>
				<%	
				}
				else 
				{
					qry="Insert into Studentattendance (FSTID, STUDENTID, ATTENDANCEDATE, ";
					qry=qry+"  CLASSTIMEFROM, CLASSTIMEUPTO, ATTENDANCETYPE, PRESENT, ";
					qry=qry+" SELFATTENDANCE, ENTRYBYFACULTYID, ENTRYBYFACULTYTYPE, ";
					qry=qry+" ENRTYDATE, REMARKS )";
					qry=qry+" values('"+mFstid+"','"+mStudentID+"',To_date('"+Date+ "','dd-MM-yyyy'),To_date('"+mTfrom+"','dd-MM-yyyy HH24:MI'),To_date('"+mTupto+"','dd-MM-yyyy HH24:MI'),'"+Type+"',";
					qry=qry+" 'N','"+mSelf+"','"+mMemberID+"','"+mMemberType+"',sysdate,'"+Remarks+"') ";
					int n1=db.insertRow(qry);

					qry="Select nvl(Studentname,' ')Studentname ,nvl(Enrollmentno,' ')Enrollmentno from  Studentmaster where nvl(Deactive,'N')='N' AND STUDENTID='"+mStudentID+"' " ;
					RsChk1= db.getRowset(qry);
					if(RsChk1.next())
			      		{
			 		  mSID=RsChk1.getString(1);	
					  mRollno=RsChk1.getString(2);	
					}
				%>
					<tr>
					<td><%=++Ctr%></td>
					<td><%=mRollno%></td>
					<td><%=GlobalFunctions.toTtitleCase(mSID)%></td>
					<td><font color=red>Absent</font></td>
					</tr>
				<%
				}	
		} 
		
		
		
		//--------------------------extra 
		/*
if(!mInst.equals("JPBS"))
				{
		if(!mDTExtrafrom.equals(""))
				{

				  qry="select 'y' from studentattendance where fstid='"+mFstid+"' and studentid='"+mStudentID+"' ";
			  qry=qry+" and ATTENDANCEDATE=To_date('"+Date+ "','dd-MM-yyyy') and CLASSTIMEFROM=To_date('"+mDTExtrafrom+"','dd-MM-yyyy HH:MI PM') ";
			  qry=qry+" and CLASSTIMEUPTO=To_date('"+mDTExtraupto+"','dd-MM-yyyy HH:MI PM') ";
			   qry=qry+" and ATTENDANCETYPE='E' ";		
			//   out.print(qry);
	               rs=db.getRowset(qry);	
			  if(!rs.next())
			  {	
                    	if(mPresent.equals("P"))
				{
					qry="Insert into Studentattendance (FSTID, STUDENTID, ATTENDANCEDATE, ";
					qry=qry+"  CLASSTIMEFROM, CLASSTIMEUPTO, ATTENDANCETYPE, PRESENT, ";
					qry=qry+" SELFATTENDANCE, ENTRYBYFACULTYID, ENTRYBYFACULTYTYPE, ";
					qry=qry+" ENRTYDATE, REMARKS )";
					qry=qry+" values('"+mFstid+"','"+mStudentID+"',To_date('"+Date+ "','dd-MM-yyyy'),To_date('"+mDTExtrafrom+"','dd-MM-yyyy HH:MI PM'),To_date('"+mDTExtraupto+"','dd-MM-yyyy HH:MI PM'),'E', ";
					qry=qry+" 'Y','"+mSelf+"','"+mMemberID+"','"+mMemberType+"',sysdate,'"+Remarks+"') ";
					
					int v=db.insertRow(qry);
				
					
				
				}
				else 
				{
					qry="Insert into Studentattendance (FSTID, STUDENTID, ATTENDANCEDATE, ";
					qry=qry+"  CLASSTIMEFROM, CLASSTIMEUPTO, ATTENDANCETYPE, PRESENT, ";
					qry=qry+" SELFATTENDANCE, ENTRYBYFACULTYID, ENTRYBYFACULTYTYPE, ";
					qry=qry+" ENRTYDATE, REMARKS )";
					qry=qry+" values('"+mFstid+"','"+mStudentID+"',To_date('"+Date+ "','dd-MM-yyyy'),To_date('"+mDTExtrafrom+"','dd-MM-yyyy HH:MI PM'),To_date('"+mDTExtraupto+"','dd-MM-yyyy HH:MI PM'),'E',";
					qry=qry+" 'N','"+mSelf+"','"+mMemberID+"','"+mMemberType+"',sysdate,'"+Remarks+"') ";
					int b=db.insertRow(qry);
					
				}	
			}
		
				}
				}*/
		
		
		// closing of select if
    } // closing of if 4
} // closing of for

%>
</table>
<%

//out.print(TotalRec1+"-----------");
  if(TotalRec1>0)
                {




      for (int jj=1;jj<=TotalRec1;jj++)
  {

if(jj==1)
	  {
	%>
	<table border=1 cellpadding=3 cellspacing=1 rules="All" align=center class="sort-table" id="table-1" >

	  <tr bgcolor="#ff8c00" >
                    <td align="CENTER"  colspan="10" Title="AVAILABLE LIST " nowrap><font color="White" ><b>Available List of Students Missed Attendance.</b></font></td>
            </tr>

<tr bgcolor=ff8c00>
<td><font color="White"><b><b>SNo.</b></td>	
<td><font color="White"><b><b>Enrollment No.</b></td>
<td><font color="White"><b><b>Student Name</b></td>	
<td><font color="White"><b><b>Status</b></td>
</tr>
	<%
	  }




  	mName11="PresentP"+String.valueOf(jj).trim();

                        	mName12="PREVFSTID"+String.valueOf(jj).trim();
                            mName13="STUDENTID"+String.valueOf(jj).trim();
                             mName14="EMPID"+String.valueOf(jj).trim();
                             	mName15="ATTDATE"+String.valueOf(jj).trim();
                            mName16="CTIMEIN"+String.valueOf(jj).trim();
                             mName17="CTIMEOUT"+String.valueOf(jj).trim();
                             mName18="ATTTYPE"+String.valueOf(jj).trim();



   	mPresent1=request.getParameter(mName11);
			mFstid1= request.getParameter(mName12);
			mStudentID1= request.getParameter(mName13);
			mEmployeeid1=request.getParameter(mName14);
mAttDate=request.getParameter(mName15);
                mTfrom1=request.getParameter(mName16);
                mTupto1=request.getParameter(mName17);
                Type1=request.getParameter(mName18);

                	if(mEmployeeid1.equals(mMemberID))
			mSelf1="Y";
			else
			mSelf1="N";



	  qry="select 'y' from studentattendance where fstid='"+mFstid1+"' and studentid='"+mStudentID1+"' ";
			  qry=qry+" and ATTENDANCEDATE=To_date('"+mAttDate+ "','dd-MM-yyyy') and CLASSTIMEFROM=To_date('"+mTfrom1+"','dd-MM-yyyy HH24:MI') ";
			  qry=qry+" and CLASSTIMEUPTO=To_date('"+mTupto1+"','dd-MM-yyyy HH24:MI') ";
			   qry=qry+" and ATTENDANCETYPE='"+Type1+"' ";
                      //  out.print(qry);
	               rs=db.getRowset(qry);
			  if(!rs.next())
			  {
                    	if(mPresent1.equals("P"))
				{
					qry="Insert into Studentattendance (FSTID, STUDENTID, ATTENDANCEDATE, ";
					qry=qry+"  CLASSTIMEFROM, CLASSTIMEUPTO, ATTENDANCETYPE, PRESENT, ";
					qry=qry+" SELFATTENDANCE, ENTRYBYFACULTYID, ENTRYBYFACULTYTYPE, ";
					qry=qry+" ENRTYDATE, REMARKS )";
					qry=qry+" values('"+mFstid1+"','"+mStudentID1+"',To_date('"+mAttDate+ "','dd-MM-yyyy'),To_date('"+mTfrom1+"','dd-MM-yyyy HH24:MI'),To_date('"+mTupto1+"','dd-MM-yyyy HH24:MI'),'"+Type1+"', ";
					qry=qry+" 'Y','"+mSelf1+"','"+mMemberID+"','"+mMemberType+"',sysdate,'"+Remarks+"') ";
			//out.print(qry);
					int n1=db.insertRow(qry);

					qry="Select nvl(Studentname,' ')Studentname ,nvl(Enrollmentno,' ')Enrollmentno " +
                            "from  Studentmaster where nvl(Deactive,'N')='N' AND STUDENTID='"+mStudentID1+"' " ;
					RsChk1= db.getRowset(qry);
					if(RsChk1.next())
			      		{
			 		  mSID1=RsChk1.getString(1);
					  mRollno1=RsChk1.getString(2);
					}
					%>
					<tr>
					<td><%=++Ctr1%></td>
					<td><%=mRollno1%></td>
					<td><%=GlobalFunctions.toTtitleCase(mSID1)%></td>
					<td><font color=green>Present</font></td>
					<tr>
				<%
				}
				else
				{
					qry="Insert into Studentattendance (FSTID, STUDENTID, ATTENDANCEDATE, ";
					qry=qry+"  CLASSTIMEFROM, CLASSTIMEUPTO, ATTENDANCETYPE, PRESENT, ";
					qry=qry+" SELFATTENDANCE, ENTRYBYFACULTYID, ENTRYBYFACULTYTYPE, ";
					qry=qry+" ENRTYDATE, REMARKS )";
					qry=qry+" values('"+mFstid1+"','"+mStudentID1+"',To_date('"+mAttDate+ "','dd-MM-yyyy'),To_date('"+mTfrom1+"','dd-MM-yyyy HH24:MI'),To_date('"+mTupto1+"','dd-MM-yyyy HH24:MI'),'"+Type1+"',";
					qry=qry+" 'N','"+mSelf1+"','"+mMemberID+"','"+mMemberType+"',sysdate,'"+Remarks+"') ";
				//		out.print(qry);
                    int n2=db.insertRow(qry);

					qry="Select nvl(Studentname,' ')Studentname ,nvl(Enrollmentno,' ')Enrollmentno from " +
                            " Studentmaster where nvl(Deactive,'N')='N' AND STUDENTID='"+mStudentID1+"' " ;
					RsChk1= db.getRowset(qry);
					if(RsChk1.next())
			      		{
			 		  mSID1=RsChk1.getString(1);
					  mRollno1=RsChk1.getString(2);
					}
				%>
					<tr>
					<td><%=++Ctr1%></td>
					<td><%=mRollno1%></td>
					<td><%=GlobalFunctions.toTtitleCase(mSID1)%></td>
					<td><font color=red>Absent</font></td>
					</tr>
				<%
				}
		}


        



                }
      }
    	/*--------------------------------------------------*/




// Log Entry
	  		   //-----------------
			    db.saveTransLog(mINSTITUTECODE,mLogEntryMemberID,mLogEntryMemberType ,"ATTENCANCE ENTRY BY RESPECTIVE FACULTY", "Attendance DateTime From: "+mTfrom +"Upto :"+mTupto+ "Class Type : "+Type , "No MAC Address" , mIPAddress);
			   //-----------------
%>
	</table>
<%
	
	} //3
	else
	{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" <b><font size=3 face='Arial' color='Red'>Please make the attendance first !</font>&nbsp; &nbsp; &nbsp;" +
            "<a href=NewDailyStudentAttendanceEntry.jsp><img src='../../Images/Back.jpg' border=0 ></a><br><br> ");
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
out.print("No Item Selected..."+qry);
	out.println(e.getMessage());
}
%>
    </form>
</body>
</html>
