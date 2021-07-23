<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
String qry="",mfinalized="";
String mSemType="";
int ctr=0;
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInst="";
String mExam="";
String mName1="",mName2="",mName3="",mName4="",mName5="",mName6="",mName7="",mName8="", mName9="";
String mST="";

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
 
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Free Elective Subject to be Run by DOAA ] </TITLE>
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
<!--
	if(window.history.forward(1) != null)
	window.history.forward(1);
	//-->
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

	     //-----------------------------
	     //-- Enable Security Page Level  
	     //-----------------------------
		
		qry="Select WEBKIOSK.ShowLink('123','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
		  //----------------------
			if(request.getParameter("ExamCode")!=null)
				{
					if (request.getParameter("InstCode")==null)
						mInst="";
					else		
						mInst=request.getParameter("InstCode").toString().trim();

					if (request.getParameter("ExamCode")==null)
						mExam="";
					else
						mExam=request.getParameter("ExamCode").toString().trim();

				if (request.getParameter("finalized")==null)
						mfinalized="";
					else
						mfinalized=request.getParameter("finalized").toString().trim();

				

				if(request.getParameter("SemType")==null)
					mSemType="";
				else
					mSemType=request.getParameter("SemType").toString().trim();
						
					mST=request.getParameter("SubjectType").toString().trim();

				int mTot=0;

				if(request.getParameter("Total")==null )
					mTot=0;
				else
					mTot=Integer.parseInt(request.getParameter("Total").toString().trim());

				%>
				<center><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u>
				Free Elective Subject(s) Running Status by DOAA</u></b></font></center>
				<TABLE rules=all cellSpacing=0 cellPadding=0 border=1 align=center>
				<tr bgcolor='#e68a06'>
				 <th>Sno.</th>
				 <th>Subject Description</th>
				 <th>To Be Offered</th>
				 <%		
				//------------------------						
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

		 
					
					String mRunning="";
					String mSubjCode="",mSubjID="",mLastStatus="";
					int jk=0;


					for(int i=0;i<mTot;i++)
					{ 			
					    ctr++;										    
                
						mName1="SUBJCODE"+ctr;
						mName9="SUBJID"+ctr;
						mName2="RUNNING"+ctr;
						mName3="LASTSTATUS"+ctr;
						mSubjCode=request.getParameter(mName1).toString().trim();
						mSubjID=request.getParameter(mName9).toString().trim();
						mLastStatus=request.getParameter(mName3).toString().trim();
						mRunning=request.getParameter(mName2).toString().trim();
						%>
						<tr>
						<td>&nbsp;<%=ctr%></td>
						<td>&nbsp;<%=mSubjCode%></td>
						<%
						if (mLastStatus.equals(mRunning))
						   {
						      if(mRunning.equals("Y"))
							    {
								%>
								<td align=right><font color=green>Running</font></td>
								<%
							     }
							  else
							    {
								%>
									<td align=right><font color=Red>Not Running</font></td>
								<%
							    }
						   }
					
					   else if (mRunning.equals("Y") && !mLastStatus.equals(mRunning))
							  {							
								if(mST.equals("F"))
								  {
									qry="Update FREEELECTIVE b set SUBJECTRUNNING='Y' Where INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExam+"'";
									qry=qry+" And SubjectID='"+mSubjID+"' And (b.INSTITUTECODE,b.EXAMCODE) in (select PE.INSTITUTECODE,PE.ExamCode from PREVENTMASTER PE ";
									qry=qry+" Where PE.INSTITUTECODE='"+mInst+"' and PE.EXAMCODE='"+mExam+"' and nvl(PE.PRCOMPLETED,'N')='N' and ";
									qry=qry+" nvl(PE.PRREQUIREDFOR,'N')<>'S' and nvl(PE.FREEELECTIVERUNFINALIZED,'N')='N' and nvl(PE.DEACTIVE,'N')='N'";
									qry=qry+" And (PE.INSTITUTECODE, PE.PREVENTCODE) not in (Select D.INSTITUTECODE, D.PREVENTCODE ";
									qry=qry+" from PREVENTS D Where D.MEMBERTYPE<>'S' And nvl(D.LOADDISTRIBUTIONSTATUS,'N')='Y' and nvl(D.DEACTIVE,'N')='N') )";
									qry=qry+" And nvl(B.DEACTIVE,'N')='N'";
								  }
							  
								jk=db.update(qry);	
								if (jk>0)
								   {
									  //--------------//
									  //  Log Entry   //
								  	  //--------------//
									    db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"Sbject Running=[Y]", "ExamCode:"+ mExam +" Subject Code "+ mSubjCode+" SubjType:"+mST , "NO MAC Address" , mIPAddress);				
									   //--------------//						
									%>
									<td align=right><font color=green>Running</font></td>
									<%
								   }
								else
								   {
									%>
										<td>&nbsp;</td>
									<%
								   }
							   }


							else 
							 {
								if(mST.equals("F"))
								   {	
									qry="Update FREEELECTIVE b set SUBJECTRUNNING='N' Where INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExam+"'";
									qry=qry+" And SubjectID='"+mSubjID+"' And (b.INSTITUTECODE,b.EXAMCODE) in (select PE.INSTITUTECODE,PE.ExamCode from PREVENTMASTER PE ";
									qry=qry+" Where PE.INSTITUTECODE='"+mInst+"' and PE.EXAMCODE='"+mExam+"' and nvl(PE.PRCOMPLETED,'N')='N' and ";
									qry=qry+" nvl(PE.PRREQUIREDFOR,'N')<>'S' and nvl(PE.FREEELECTIVERUNFINALIZED,'N')='N' and nvl(PE.DEACTIVE,'N')='N'";
									qry=qry+" And (PE.INSTITUTECODE, PE.PREVENTCODE) not in (Select D.INSTITUTECODE, D.PREVENTCODE ";
									qry=qry+" from PREVENTS D Where D.MEMBERTYPE<>'S' and nvl(D.LOADDISTRIBUTIONSTATUS,'N')='Y' and nvl(D.DEACTIVE,'N')='N') )";
									qry=qry+" And nvl(B.DEACTIVE,'N')='N'";
								   }
								
								jk=db.update(qry);	
								if (jk>0)
								   {

									  //--------------//
									  //  Log Entry   //
								  	  //--------------//
									    db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"Sbject Running=[N]", "ExamCode:"+ mExam +" Subject Code "+ mSubjCode+" SubjType:"+mST , "NO MAC Address" , mIPAddress);				
									   //--------------//						

									%>
									<td align=right><font color=red>Not Running</font></td>
									<%
								   }
								else
								   {
									%>
										<td>&nbsp;</td>
									<%
								   }
							   }

						%>
					</tr>
					<%

					
					
					
					
					
  					} // closing of for loop
					

				if (mfinalized.equals("YES"))
					{
						qry="Update PREVENTMASTER B set B.FREEELECTIVERUNFINALIZED='Y' Where B.INSTITUTECODE='"+mInst+"' and";
						qry=qry+ " B.PRREQUIREDFOR<>'S' and b.INSTITUTECODE='"+mInst+"' and b.EXAMCODE='"+mExam+"' and nvl(b.PRCOMPLETED,'N')='N'";
						qry=qry+"  and nvl(b.DEACTIVE,'N')='N' and nvl(b.DEACTIVE,'N')='N'";						
						
						jk=db.update(qry);	
						if (jk>0)						
						{
							  //--------------//
							  //  Log Entry   //
						  	  //--------------//
							    db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"ELRunning Locked", "ExamCode:"+ mExam  , "NO MAC Address" , mIPAddress);				
							   //--------------//						

						%>
						<tr><td colspan=4><font color=Blue size=3><b>Free Elective Subjects to be Run have been Finalized/Freezed.<br> No further modification can take place.</font></td>
						<%	
						}
						else
						{
						%>
						<tr><td colspan=4><font color=Blue size=3><b>Free Elective Subjects to be Run has not been Finalized/Freezed<br> HOD Load Distribution can not take place until you finalized/Freezed the same.</font></td>
						<%	
						}
					}
					else
					{
						%>
						<tr><td colspan=4><font color=Blue size=3><b>Free Elective Subjects to be Run has not been Finalized/Freezed<br> HOD Load Distribution can not take place until you finalized/Freezed the same.</font></td>
						<%	
					}


			%>
			</TABLE>
			 <%

  		}// Closing of Exam Code is null
		else
		{
		%>
		<font color=red>
		<h3>	<br><img src='../../Images/Error1.jpg'>
		Pre- Registration Event has not been declared or Registration completed</FONT></P>
		 <%
		}

		  //-----------------------------
		  //-- Enable Security Page Level  
		  //-----------------------------

	    }  // if no rights assigned to the user
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
	} // closing of Session Time out check
	else
	{
		out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}      
} // closing of try
catch(Exception e)
{
}
%>
</body>
</html>  