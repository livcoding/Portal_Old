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
String mHODDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInst="";
String mExam="",mHODMemberID="";
String mName1="",mName2="",mName3="",mName4="",mName5="",mName6="",mName7="",mName8="",mName9="";


String mELECTIVECODE="";
String mSubjType="";
String mST="",mDepartmentCode="";

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
 if (session.getAttribute("DepartmentCode")==null)
{
	mDepartmentCode="";
}
else
{
	mDepartmentCode=session.getAttribute("DepartmentCode").toString().trim();
}
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Approval of Running Elective Subject(s) by DOAAA ] </TITLE>
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

				if (request.getParameter("EID")==null)
						mHODMemberID="";
					else
						mHODMemberID=request.getParameter("EID").toString().trim();

				if(request.getParameter("SemType")==null)
					mSemType="";
				else
					mSemType=request.getParameter("SemType").toString().trim();
						
					mST="E";

				int mTot=0;

				if(request.getParameter("Total")==null )
					mTot=0;
				else
					mTot=Integer.parseInt(request.getParameter("Total").toString().trim());

				%>
				<center><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u>
				Approval of Running Elective Subject(s) by DOAA</u></b></font></center>
				<TABLE rules=all cellSpacing=0 cellPadding=0 border=1 align=center>
				<tr bgcolor='#e68a06'>
				 <th>Sno.</th>
				 <th>Subject Code</th>
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
					String mProg="";
					String mTagg="";
					String mSectionBranch="";
					String mAcademic="";


	 				String mColor="";
					int mChoice=0;
					String mCol1="LightGrey";
					String OldmELECTIVECODE="";
					String mCol2="#ffffff",mPreventcode="";
					int jk=0;

					ResultSet rs=null;



qry=" SELECT m.preventcode      preventcode         FROM preventmaster m             WHERE m.institutecode = '"+mInst+"'  AND m.examcode ='"+mExam+"'            AND NVL (m.prcompleted, 'N') = 'N'			   AND NVL (m.prrequiredfor, 'N') <> 'E'               AND NVL (m.deactive, 'N') = 'N'";
rs=db.getRowset(qry);
if(rs.next())
					{
	mPreventcode=rs.getString("preventcode");
					}

					for(int i=0;i<mTot;i++)
					{ 
						
						ctr++;
						mName1="SUBJCODE"+ctr;
						mName2="RUNNING"+ctr;
						mName3="ELECTIVE"+ctr;
						mName4="LASTSTATUS"+ctr;
						mName5="PRGCODE"+ctr;
						mName6="TAGGINGFOR"+ctr;
						mName7="SECIONBRANCH"+ctr;
						mName8="ACYEAR"+ctr;
						mName9="SUBJID"+ctr;


						mSubjCode=request.getParameter(mName1).toString().trim();

						mLastStatus=request.getParameter(mName4).toString().trim();

						mRunning=request.getParameter(mName2).toString().trim();
					
						mProg=request.getParameter(mName5).toString().trim();
						
						mTagg=request.getParameter(mName6).toString().trim();
					
						mSectionBranch=request.getParameter(mName7).toString().trim();
						
						mAcademic=request.getParameter(mName8).toString().trim();
						
						mSubjID=request.getParameter(mName9).toString().trim();
						
//out.print(mSubjCode+"sdfsdadfsa");

							  if(request.getParameter(mName3)!=null)
								mELECTIVECODE=request.getParameter(mName3).toString().trim();
							  else
								mELECTIVECODE="";

						if (!mELECTIVECODE.equals(OldmELECTIVECODE))
							{
							   if (mChoice==0)
								mChoice=1 ;
							   else
								mChoice=0 ;
							   OldmELECTIVECODE=mELECTIVECODE;
							}

						if (mChoice==0) 
							mColor=mCol1;
						else
						      mColor=mCol2;
						%>
						<tr bgcolor="<%=mColor%>">
						<td>&nbsp;<%=ctr%></td>
						<td>&nbsp;<%=mSubjCode%></td>
						<%
						   if (mELECTIVECODE.equals(" "))
					      	     {
						%>
							<td><%=mSubjCode%></td>
						<%
						     }
						    else	
							{		
						%>
							<td><%=mSubjCode%>&nbsp;(<%=mELECTIVECODE%>)&nbsp;</td>
						<%		
							}
						
							if (mLastStatus.equals(mRunning))
							  {
								 if(mRunning.equals("Y"))
								  {
									%>
									<td align=right><font color=green>Approved</font></td>
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
							
								//out.print(mST);
								if(mST.equals("E"))
								  {
									qry="Update PR#ELECTIVESUBJECTS B set SUBJECTRUNNING='Y' Where B.INSTITUTECODE='"+mInst+"' AND B.EXAMCODE='"+mExam+"'";
									qry=qry+" And B.SubjectID='"+mSubjID+"' And (b.INSTITUTECODE,b.EXAMCODE) in (select PE.INSTITUTECODE,PE.ExamCode from PREVENTMASTER PE ";
									qry=qry+" Where PE.INSTITUTECODE='"+mInst+"' and PE.EXAMCODE='"+mExam+"' and nvl(PE.PRCOMPLETED,'N')='N' and nvl(PE.PRBROADCAST,'N')='Y' ";
									qry=qry+" and nvl(PE.PRREQUIREDFOR,'N')<>'S' and nvl(PE.DEACTIVE,'N')='N'";
									qry=qry+" And (PE.INSTITUTECODE, PE.PREVENTCODE) in (Select D.INSTITUTECODE, D.PREVENTCODE ";
									qry=qry+" from PREVENTS D Where D.MEMBERTYPE<>'S' and MEMBERID='"+mHODMemberID+"'  and nvl(D.LOADDISTRIBUTIONSTATUS,'N')='N' and nvl(D.DEACTIVE,'N')='N') )";
									qry=qry+" And nvl(B.DEACTIVE,'N')='N'";
									out.print(qry);
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
								if(mST.equals("E"))
								   {	
									qry="Update PR#ELECTIVESUBJECTS B set SUBJECTRUNNING='N' Where B.INSTITUTECODE='"+mInst+"' AND B.EXAMCODE='"+mExam+"'"; 
									qry=qry+" And B.SubjectID='"+mSubjID+"' And (b.INSTITUTECODE,b.EXAMCODE) in (select PE.INSTITUTECODE,PE.ExamCode from PREVENTMASTER PE ";
									qry=qry+" Where PE.INSTITUTECODE='"+mInst+"' and PE.EXAMCODE='"+mExam+"' and nvl(PE.PRCOMPLETED,'N')='N' and nvl(PE.PRBROADCAST,'N')='Y' ";
									qry=qry+" and nvl(PE.PRREQUIREDFOR,'N')<>'S' and nvl(PE.DEACTIVE,'N')='N'";
									qry=qry+" And (PE.INSTITUTECODE, PE.PREVENTCODE) in (Select D.INSTITUTECODE, D.PREVENTCODE ";
									qry=qry+" from PREVENTS D Where D.MEMBERTYPE<>'S' and MEMBERID='"+mHODMemberID+"' And nvl(D.LOADDISTRIBUTIONSTATUS,'N')='N' and nvl(D.DEACTIVE,'N')='N') )";
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

			//out.print(mfinalized);
				if (mfinalized.equals("YES"))
					{
						qry="Update PREVENTS B set APPROVED='Y', APPROVEDBY='"+mDMemberID+"', APPROVALDATE=sysdate Where B.INSTITUTECODE='"+mInst+"'";
						qry=qry+ " And B.MEMBERTYPE<>'S' and B.MEMBERID='"+mHODMemberID+"' and nvl(B.LOADDISTRIBUTIONSTATUS,'N')='N'";
						qry=qry+ " And (b.INSTITUTECODE,b.PREVENTCODE) in (select PE.INSTITUTECODE,PE.PREVENTCODE from PREVENTMASTER PE ";
						qry=qry+" Where PE.INSTITUTECODE='"+mInst+"' and PE.EXAMCODE='"+mExam+"' and nvl(PE.PRCOMPLETED,'N')='N' and nvl(PE.PRBROADCAST,'N')='Y' ";
						qry=qry+" and nvl(PE.PRREQUIREDFOR,'N')<>'S' and nvl(PE.DEACTIVE,'N')='N') And nvl(B.DEACTIVE,'N')='N'";
//out.print(qry);
						jk=db.update(qry);	
						if (jk>0)
						//if(1==1)	
						{
							  //--------------//
							  //  Log Entry   //
						  	  //--------------//
							    db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"ELRunning Approved", "ExamCode:"+ mExam  , "NO MAC Address" , mIPAddress);				
							   //--------------//	
							  
									String rrr="";
									// PopulateElectiveRunning(String pInstituteCode,String pPREventCode,String ExamCode,String pEmployeeID)
	
	//out.print(mInst+" ---- "+mPreventcode+" -- "+mExam+"  --  "+mHODMemberID);						
							
							rrr=db.PopulateElectiveRunning(mInst,mPreventcode ,mExam, mHODMemberID);

		//out.print(" ==== ");

							String HoaID="";
							String HoaIDtype="";
							String DpeCode="";
							/*qry="Select ORAID,ORATYP from MEMBERMASTER where  ORAADM='"+enc.encode("HOD_E")+"'";
							//out.println(qry);
							ResultSet rs=db.getRowset(qry);
							while(rs.next())
							{
									HoaID=enc.decode(rs.getString("ORAID"));
									HoaIDtype=enc.decode(rs.getString("ORATYP"));
							}*/
							qry="Select employeeid from hodlist where  departmentcode='"+mDepartmentCode+"'";
							//out.println(qry);
							 rs=db.getRowset(qry);
							while(rs.next())
							{
								HoaID=rs.getString("employeeid");
								
							}
							HoaIDtype="E";
							qry="Select DEPARTMENT from departmentMASTER where  DEPARTMENTCODE='"+mDepartmentCode+"'";
							//out.println(qry);
							ResultSet rs1=db.getRowset(qry);
							if(rs1.next())
							{
									mDepartmentCode=rs1.getString("DEPARTMENT");
									mDepartmentCode=gb.replaceSignleQuot(mDepartmentCode);
									
							}
							qry="";
							qry="INSERT into MESSAGESLIST (INSTITUTECODE,MSGFROMUSERD,MSGFROMMemberType,MSGToUSERD,MSGToMemberType,MSGSUBJECT ,MSGTEXT,MSGDATETIME)values('"+mInst+"','"+mChkMemID+"','"+mChkMType+"','"+mHODMemberID+"','"+HoaIDtype+"','ELECTIVE SUBJECT HAS BEEN APPROVED BY DOAA("+mDepartmentCode+")','ELECTIVE SUBJECT HAS BEEN APPROVED BY DOAA("+mDepartmentCode+")',sysdate)";
							//out.println(qry);
							jk=db.update(qry);

						%>
						<tr><td colspan=4><font color=Blue size=3><b>Elective Subjects to be Run has been Approved<br> No further modification can take place.</font></td>
						<%	
						}
						else
						{
						%>
						<tr><td colspan=4><font color=Blue size=3><b>Elective Subjects to be Run has not been Approved<br> HOD Load Distribution can not take place untile you approved the same.</font></td>
						<%	
						}
					}
					else
					{
						%>
						<tr><td colspan=4><font color=Blue size=3><b>Elective Subjects to be Run has not been approved<br> HOD Load Distribution can not take place untile you approved the same.</font></td>
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
//out.print("error ");
}
%>
</body>
</html>