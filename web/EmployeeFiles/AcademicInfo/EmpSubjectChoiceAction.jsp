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
<TITLE>#### <%=mHead%> [ Employee Subject Choice (Pre Registration Process) ] </TITLE>

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
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
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet Rsd=null;
GlobalFunctions gb =new GlobalFunctions();
int kk1=0;
String qry="";
String x="",mySect="",mfactype="";
int mTotal=0;
int n=0;
String mName1="",mName2="",mName3="",mName4="",mName5="",mSu="";
String mELECTIVECODE="";
String mSubj="",mSubj1="";
String mL="", mT="", mP="",mSendhod="",mPrcode="";
String mL1="", mT1="", mP1="";
//int mL1=0, mT1=0, mP1=0;
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInst="";
String mECode="";
String mSType="",mWebEmail="";
int len=0,pos1=0,pos2=0,pos3=0,pos4=0,pos5=0;
String mtyp="";		
int mLink=0;		
			String qryss="";
			ResultSet rss=null;

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

if (request.getParameter("TotalCount")==null)
{
	mTotal=0;
}
else
{
	mTotal=Integer.parseInt(request.getParameter("TotalCount").toString().trim());
}

if (request.getParameter("InstCode")==null)
{
	mInst="";
}
else
{
	mInst=request.getParameter("InstCode").toString().trim();
}
if (request.getParameter("ExamCode")==null)
{
	mECode="";
}
else
{
	mECode=request.getParameter("ExamCode").toString().trim();
}
if (request.getParameter("radio1")==null)
{
	mSendhod="";
}
else
{
	mSendhod=request.getParameter("radio1").toString().trim();
}
if (request.getParameter("PREVENTCODE")==null)
{
	mPrcode="";
}
else
{
	mPrcode=request.getParameter("PREVENTCODE").toString().trim();
}

%>

			<center><font size=4 face=Verdana color=green>Subject Choice Submission History (LTP wise)</font>
			<hr>
			<table border=1 cellpadding=3 cellspacing=1 rules="All" align=center>
			<tr bgcolor=ff8c00>
			<td><b>Subject Code</b></td>
			<td><b>Lectute(L)</b></td>
			<td><b>Tutorial(T)</b></td>
			<td><b>Practical(P)</b></td>
			</tr>
		
<%
try
{
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{
		OLTEncryption enc=new OLTEncryption();
		mDMemberID=enc.decode(mMemberID);
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);
		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
		qry="Select WEBKIOSK.ShowLink('50','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{

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
	
		if (request.getParameter("TotalCount")!=null && Integer.parseInt(request.getParameter("TotalCount").toString().trim())>0)
		{  
			mTotal=Integer.parseInt(request.getParameter("TotalCount").toString().trim());
	//out.print(mTotal+"===========");
		String mFlag="Y";
		for (int TT1=1;TT1<=mTotal;TT1++)
		{
			mName3="SUBJECT"+String.valueOf(TT1).trim();  
			if (request.getParameter(mName3)!=null)
				mSu=request.getParameter(mName3).toString().trim();
			else
				mSu="";
			for (int TT2=1;TT2<=mTotal;TT2++)
			{    
				if (TT1!=TT2)
				{
					mName3="SUBJECT"+String.valueOf(TT2).trim();  
					if(mSu.equals(request.getParameter(mName3).toString().trim()))
					{
					  %>
						<p align=center><font color=red size=4>Choice of Subject must be unique.<br>
						Transaction aborted. </font><font size=4 color=blue><a href="EmpSubjectChoiceEntry.jsp">Continue...</a></font></p>
					  <%
						mFlag="N";
						TT1=mTotal+1;
						TT2=mTotal+1;
					}
				}
			}
		}

if (mFlag.equals("Y"))
 {
			if(mDMemberType.equals("E"))
			{
			 mfactype="I";	
			}
			else if(mDMemberType.equals("V"))
			{
			 mfactype="E";
			} 

			int mRecFlag=0;
			for (int i=1;i<=mTotal;i++)
			{  
				mRecFlag=0;
				mName3="SUBJECT"+String.valueOf(i).trim();  
				
				if (request.getParameter(mName3)!=null)

					mSu=request.getParameter(mName3).toString().trim();
				else
					mSu="";

				try
				{
					
				len=mSu.length();
				pos1=mSu.indexOf("***");					
				pos2=mSu.indexOf("///");
				pos3=mSu.indexOf("###");
				pos4=mSu.indexOf("---");
				pos5=mSu.indexOf("===");
				mSubj1=mSu.substring(0,pos1);
				mSType=mSu.substring(pos1+3,pos2).trim();
				mELECTIVECODE=mSu.substring(pos2+3,pos3);
				mL1=mSu.substring(pos3+3,pos4);
				mT1=mSu.substring(pos4+3,pos5);
				mP1=mSu.substring(pos5+3,len);

		qryss="select subjectcode from subjectmaster where subjectid='"+mSubj1+"' ";
		rss=db.getRowset(qryss);
		rss.next();
		 mSubj=rss.getString(1);



				if(Integer.parseInt(mL1)>0)
					mL="L";
				else
				 	mL="";
				if(Integer.parseInt(mT1)>0)
					mT="T";
				else
					mT="";
				if(Integer.parseInt(mP1)>0)
					mP="P";	
				else
					mP="";
				}
				catch(Exception e)
				{
				}

			if(mSType.equals("C")) mtyp="Core Subjects";
			if(mSType.equals("F")) mtyp="Free Elective Subjects";
			if(mSType.equals("E")) mtyp="Elective Subjects";

		qry="select SUBJECTID from PR#FACULTYSUBJECTCHOICES where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mECode+"'";
		qry=qry+ "  and CHOICE='"+i+"' and   FACULTYTYPE='"+mfactype+"' and FACULTYID='"+mDMemberID+"' and LTP='L' and nvl(deactive,'N')='N'";
		Rsd= db.getRowset(qry);
		
		if (Rsd.next())
		{
		qry=" delete from PR#FACULTYSUBJECTCHOICES  where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mECode+"'";
		qry=qry+ "  and CHOICE='"+i+"' and   FACULTYTYPE='"+mfactype+"' and FACULTYID='"+mDMemberID+"' ";
		qry=qry+"  and nvl(deactive,'N')='N'";
		//out.print(qry);
		int aa=db.insertRow(qry);
		if(aa>0)
		{
	 // Log Entry
	   //-----------------
               db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"Pre-Reg Subject Choice Entry", "ExamCode:"+mECode +" Subject:"+ mSubj1, "NO MAC Address" , mIPAddress);
	   //-----------------
		}
				
		}	
		 if(!mSu.equals("NONE"))
			{
			
				if(mL.equals("L") && !mSubj1.equals(""))
				{				
					mLink=1;
				qry="select SUBJECTID from PR#FACULTYSUBJECTCHOICES where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mECode+"'";
				qry=qry+ " and SUBJECTID='"+mSubj1+"' and CHOICE='"+i+"' and   FACULTYTYPE='"+mfactype+"' and FACULTYID='"+mDMemberID+"' and LTP='L' and nvl(deactive,'N')='N'";
					RsChk= db.getRowset(qry);
					if (RsChk.next())
					{
						mRecFlag=1;
					    %>				
					    <tr><td><%=mSubj%></td>
					    <td>&nbsp;Yes</td>
					    <%
					}
					else
					{

					  qry="Insert into PR#FACULTYSUBJECTCHOICES (INSTITUTECODE, EXAMCODE, CHOICE,SUBJECTID, FACULTYTYPE, FACULTYID, LTP, SUBJECTTYPE,ELECTIVECODE)";
					  qry=qry+" Values('"+mInst+"', '"+mECode+"','"+i+"', '"+mSubj1+"', '"+mfactype+"', '"+mDMemberID+"', 'L', '"+mSType+"',DEcode('"+mSType+"','E','"+mELECTIVECODE+"',NULL))";
					  n=db.insertRow(qry);
			//		out.print(qry);
					  if(n>0)
					  {
					  // Log Entry
					   //-----------------
			               db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"Pre-Reg Subject Choice Entry", "ExamCode:"+mECode +" Subject:"+ mSubj1+ " LTP=L", "NO MAC Address" , mIPAddress);
					   //-----------------
				 	    mRecFlag=1;
					    %>				
					    <tr><td><%=mSubj%></td>
					    <td>&nbsp;Yes</td>
					    <%
					   }
					}
				}
			
				if(mT.equals("T") && !mSubj1.equals(""))
				{
					mLink=2;				
					qry="select SUBJECTID from PR#FACULTYSUBJECTCHOICES where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mECode+"'";
					qry=qry+ " and SUBJECTID='"+mSubj1+"' and CHOICE='"+i+"' and  FACULTYTYPE='"+mfactype+"' and FACULTYID='"+mDMemberID+"' and LTP='T' and nvl(deactive,'N')='N'";
					RsChk= db.getRowset(qry);
					if (RsChk.next())
					{
						 if(mRecFlag==0)
						   {
							mRecFlag=2;
						   %>
							<tr><td><%=mSubj%></td>						
							<td>&nbsp;</td>
							<td>&nbsp;Yes</td>					
						   <%
						   }
						  else
						   {
							mRecFlag=2;
						   %>												
							<td>&nbsp;Yes</td>					
						   <%
						   }
					}
					else
					{
					  qry="Insert into PR#FACULTYSUBJECTCHOICES (INSTITUTECODE, EXAMCODE,CHOICE,SUBJECTID, FACULTYTYPE, FACULTYID, LTP, SUBJECTTYPE,ELECTIVECODE)";
					  qry=qry+" Values('"+mInst+"', '"+mECode+"','"+i+"','"+mSubj1+"', '"+mfactype+"', '"+mDMemberID+"', 'T', '"+mSType+"',DEcode('"+mSType+"','E','"+mELECTIVECODE+"',NULL))";

					  n=db.insertRow(qry);
					  if(n>0)
						{
					  // Log Entry
					   //-----------------
			               db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"Pre-Reg Subject Choice Entry", "ExamCode:"+mECode +" Subject:"+ mSubj1+ " LTP=T", "NO MAC Address" , mIPAddress);
					   //-----------------
						   if(mRecFlag==0)
						   {
							mRecFlag=2;
						   %>
							<tr><td><%=mSubj%></td>						
							<td>&nbsp;</td>
							<td>&nbsp;Yes</td>					
						   <%
						   }
						  else
						   {
							mRecFlag=2;
						   %>												
							<td>&nbsp;Yes</td>					
						   <%
						   }
						}
					}
				}
				if(mP.equals("P") && !mSubj1.equals(""))
				{		
					mLink=3;			
					qry="select SUBJECTID from PR#FACULTYSUBJECTCHOICES where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mECode+"'";
					qry=qry+ " and SUBJECTID='"+mSubj1+"' and CHOICE='"+i+"' and   FACULTYTYPE='"+mfactype+"'  And FACULTYID='"+mDMemberID+"' and LTP='P' and nvl(deactive,'N')='N'";
					RsChk= db.getRowset(qry);
					if (RsChk.next())
					{
						   if(mRecFlag==0)
						   {
							mRecFlag=3;
						   %>
							<tr><td><%=mSubj%></td>						
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;Yes</td>					
						   <%
						   }
						else if(mRecFlag==1)
						   {
							mRecFlag=3;
						   %>
							
							<td>&nbsp;</td>							
							<td>&nbsp;Yes</td>					
						   <%
						   }
						  else
						   {
							mRecFlag=3;
						   %>												
							<td>&nbsp;Yes</td>					
						   <%
					   	   }

					}
				 	else
					{
					   qry="Insert into PR#FACULTYSUBJECTCHOICES (INSTITUTECODE, EXAMCODE,CHOICE, SUBJECTID, FACULTYTYPE, FACULTYID, LTP, SUBJECTTYPE,ELECTIVECODE)";
					   qry=qry+" Values('"+mInst+"', '"+mECode+"','"+i+"','"+mSubj1+"', '"+mfactype+"', '"+mDMemberID+"', 'P', '"+mSType+"',DEcode('"+mSType+"','E','"+mELECTIVECODE+"',NULL))";
					   n=db.insertRow(qry);
					   if(n>0)
 				 	    {
					  // Log Entry
					   //-----------------
			               db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"Pre-Reg Subject Choice Entry", "ExamCode:"+mECode +" Subject:"+ mSubj1+ " LTP=P", "NO MAC Address" , mIPAddress);
					   //-----------------

						  if(mRecFlag==0)
						   {
							mRecFlag=3;
						   %>
							<tr><td><%=mSubj%></td>						
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;Yes</td>					
						   <%
						   }
						else if(mRecFlag==1)
						   {
							mRecFlag=3;
						   %>
							
							<td>&nbsp;</td>							
							<td>&nbsp;Yes</td>					
						   <%
						   }
						  else
						   {
							mRecFlag=3;
						   %>												
							<td>&nbsp;Yes</td>					
						   <%
					   	   }

					     }
					}
				}		
							
		} // closing of NONE
	} //closing of for loop
	%>
		</tr></table>
	<%
		if(mLink==1 || mLink==2 || mLink==3||mLink==3)
		{
	   %>
		<br><font size=4 color=Green>Your subject choice has been sbmitted. </font><br>
		<font size=4 color=Green>Click to enter your <a href="EmpSubjectDateTimePrefEntry.jsp">Day/Time Prefrence.</a>  </font>
	   <%
		}	
	if(mSendhod.equals("Y"))
	{
	    qry=" Update prevents set SENDTOHOD='Y',SENTBY='"+mDMemberID+"',SENTDATE=sysdate where institutecode='"+mInst+"' and ";
	    qry=qry+" PREVENTCODE='"+mPrcode+"' and MEMBERTYPE='"+mDMemberType+"' and MEMBERID='"+mDMemberID+"' ";	
	    int u=db.update(qry);
	    if(u>0)
	    {
	// Log Entry
	//-----------------
	  db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"Pre-Reg Subject Choice Entry-update", "ExamCode:"+mECode +" PrEventcode:"+mPrcode+"Subject:"+ mSubj1+ " LTP=P", "NO MAC Address" , mIPAddress);
	 //-----------------
	%>
	<b><font color=Green>
	<ui>Your Subject Chocice has been sent to HOD.<br>
	<ui>Now You can not change your choice using this form.
	</font><br></b>
   <%
	
	} // closing of if(u>0)


	} // closing of if(mSendhod.equals("Y"))

	} //closing of mFlag='Y'
//-----------------------------
//-- Enable Security Page Level  
//-----------------------------
		
		}
		else
		{
		out.print("No Record Selected...");
		} 
		}
		else
   		{
   %>
	<br>
	<font color=red>
	<h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
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
}
catch(Exception e)
{
 
}
%><br><br><br><br>
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