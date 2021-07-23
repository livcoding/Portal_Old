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
<TITLE>#### <%=mHead%> [ Re-Pre Registration Subject Choice Confirmation ] </TITLE>
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
</script>

<script>
if(window.history.forward(1) != null)
	window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
/*
	' 
*************************************************************************************************
	' *												
	' * File Name:	PRStudentActionSecond.jsp		[For Students]					
	' * Author:		Vijay Kumar
	' * Date:		25th Oct 2008
	' * Version:	1.0								
	' * Description:	Pre Registration of Students [Back & Curr Core+Elective+Free Elective Subject Re-Choice.]
*************************************************************************************************
*/

DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();
String qry="",mWebEmail="",EmpIDType="";
String mSemType="",mProg="",mBranch="",mSect="",mSubSect="",mTag="",mAcad="",mFactType="";
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
int mSem=0, MinForDBasket=0, MaxForDBasket=0, mErrFlag=0;
ResultSet rs=null,rs1=null,Rsd1=null, rsMaxSubjLmt=null;
String mName1="",mName2="",mName3="",mName4="",mName5="",mName6="",mName7="",mName8="",mName9="",mName10="",mSubjectType="",mPrcode="";
String mChk="", mSubjType="", mSubjId="", mSubjName="", mElecCode="";
int mSemester=0, mTotalRec=0, MaxSubjFlag=0, MaxSubjTknFlag=0, mLimitExceeded=0;
double mMinCrLmt=0, mMaxCrLmt=0, mCourseCrPtTkn=0, mCourseCrPt=0;
String mBasket="", mChoice="1";
String mExamCode="";
String mInst="";
String mEmployeeID="";
String mSUBJECTID="",mEmployeename="",mElective="",msendtohod="";
String mEName=" ";
int aa1=0, n=0, kk=0;
String Flag="N";
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


if (request.getParameter("mSem")==null)
{
	mSem=0;
}
else
{
	mSem=Integer.parseInt(request.getParameter("mSem").toString().trim());
}
if (request.getParameter("SemType")==null)
{
	mSemType="";
}
else
{
	mSemType=request.getParameter("SemType").toString().trim();
}

if (request.getParameter("mProg")==null)
{
	mProg="";
}
else
{
	mProg=request.getParameter("mProg").toString().trim();
}
if (request.getParameter("mBranch")==null)
{
	mBranch="";
}
else
{
	mBranch=request.getParameter("mBranch").toString().trim();
}
if (request.getParameter("mSect")==null)
{
	mSect="";
}
else
{
	mSect=request.getParameter("mSect").toString().trim();
}
	
if (request.getParameter("mTag")==null)
{
	mTag="";
}
else
{
	mTag=request.getParameter("mTag").toString().trim();
}

if (request.getParameter("mAcad")==null)
{
	mAcad="";
}
else
{
	mAcad=request.getParameter("mAcad").toString().trim();
}

msendtohod="N";

if (request.getParameter("ExamCode")==null)
{
	mExamCode="";
}
else
{
	mExamCode=request.getParameter("ExamCode").toString().trim();
}

if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();   
}
if (request.getParameter("PREVENTCODE")==null)
{
	mPrcode="";
}
else
{
	mPrcode=request.getParameter("PREVENTCODE").toString().trim();
}
if (request.getParameter("TotalCCPAld")==null)
{
	mCourseCrPtTkn=0;
}
else
{
	mCourseCrPtTkn=Double.parseDouble(request.getParameter("TotalCCPAld").toString().trim());
}

qry="SELECT MINCREDITPOINT MINCRPT, MAXCREDITPOINT MAXCRPT FROM PR#PROGRAMMINMAXCP WHERE INSTITUTECODE='"+mInst+"' AND (EXAMCODE,REGCODE) in ";
qry=qry+" (SELECT  ExamCode,REGCODE from PREVENTMASTER WHERE INSTITUTECODE='"+mInst+"' and nvl(PRCOMPLETED,'N')='N' and nvl(PRBROADCAST,'N')='Y' and PRREQUIREDFOR='S' AND NVL(DEACTIVE,'N')='N')";
qry=qry+" AND ACADEMICYEAR='"+mAcad+"' AND PROGRAMCODE='"+mProg+"' AND TAGGINGFOR='"+mTag+"' AND SECTIONBRANCH='"+mSect+"' AND SEMESTER="+mSem+"";
rs=db.getRowset(qry);
if(rs.next())
{
	mMinCrLmt=rs.getDouble(1);
	mMaxCrLmt=rs.getDouble(2);
}
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

		qry=" SELECT nvl(SUBSECTIONCODE,' ')SUBSECTIONCODE FROM STUDENTMASTER WHERE STUDENTID='"+mChkMemID+"'";
		Rsd1=db.getRowset(qry);
		if(Rsd1.next())
		{
			mSubSect=Rsd1.getString(1);
		}

		//-----------------------------
		//-- Enable Security Page Level  
		//-----------------------------

		qry="Select WEBKIOSK.ShowLink('109','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	      RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{
			//-------------------------------------
			//----- For Log Entry Purpose
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
				//out.println(e.getMessage());
			}
			if (request.getParameter("TotalRec")!=null && Integer.parseInt(request.getParameter("TotalRec").toString().trim())>0)
			{	//3
				mTotalRec =Integer.parseInt(request.getParameter("TotalRec").toString().trim());
				String mFlag="Y";
				//---------------------------------------------------------------
				// Validateinf Choice - If duplicate entry redirect to prev page
				//---------------------------------------------------------------
				for (int TT1=1;TT1<=mTotalRec;TT1++)
				{
					mName1="CHK"+String.valueOf(TT1).trim(); 
					mName3="SEMTYP"+String.valueOf(TT1).trim(); 
					mName8="ELCODE"+String.valueOf(TT1).trim(); 
					mName9="BASKET"+String.valueOf(TT1).trim(); 
					mName10="CHOICE"+String.valueOf(TT1).trim(); 
					if (request.getParameter(mName1)==null)
						mChk="N";
					else
						mChk=request.getParameter(mName1).toString().trim();
					mSemType=request.getParameter(mName3).toString().trim();
					if(request.getParameter(mName8)==null)
					{
						mElecCode="";
					}
					else
					{
						mElecCode=request.getParameter(mName8).toString().trim();
					}
					mBasket=request.getParameter(mName9).toString().trim();
					if (request.getParameter(mName10)==null)
						mChoice="";
					else
						mChoice=request.getParameter(mName10).toString().trim();
					if(mBasket.equals("B") && !mElecCode.equals("") && mSemType.equals("REG") && mChk.equals("Y"))
					{
						for (int TT2=1;TT2<=mTotalRec;TT2++)
						{
							if (TT1!=TT2)
							{
								mName8="ELCODE"+String.valueOf(TT2).trim(); 
								mName10="CHOICE"+String.valueOf(TT2).trim(); 
								if(mElecCode.equals(request.getParameter(mName8).toString().trim()))
								{
									if(mChoice.equals(request.getParameter(mName10).toString().trim()))
									{
										%>
										<p align=center><font color=red size=4>Choice of Elective Subject for Current Semester must be unique.<br>
										Transaction aborted. </font><font size=4 color=blue><a href="PRStudentEntrySecond.jsp">Continue...</a></font></p>
										<%
										mFlag="N";
										TT1=mTotalRec+1;
										TT2=mTotalRec+1;
									}
								}
							}
						}
					}
				}
				%>
				<center><font size=4 color=navy>Registration Status</font></center>
				<table border=1 cellpadding=3 cellspacing=1 rules="All" align=center>
				<tr bgcolor=ff8c00>
				<td><font color=white><b>Subject (Subject Code)</b></font></td>
				<td><font color=white><b>Subject Type</b></font></td>
				<td><font color=white><b>CCP</b></font></td>
				<td><font color=white><b>Choice</b></font></td>
				<td><font color=white><b>Pre-Reg. Status</b></font></td>
				</tr>
				<%
				if (mFlag.equals("Y"))
				{
					if(mCourseCrPtTkn>=mMinCrLmt && mCourseCrPtTkn<=mMaxCrLmt)
					{
						for (kk=1;kk<=mTotalRec ;kk++)
						{
							mName1="CHK"+String.valueOf(kk).trim(); 
							mName2="SEM"+String.valueOf(kk).trim(); 
							mName3="SEMTYP"+String.valueOf(kk).trim(); 
							mName4="SUBJTYP"+String.valueOf(kk).trim(); 
							mName5="SUBJID"+String.valueOf(kk).trim(); 
							mName6="SUBJ"+String.valueOf(kk).trim(); 
							mName7="CCP"+String.valueOf(kk).trim(); 
							mName8="ELCODE"+String.valueOf(kk).trim();
							mName9="BASKET"+String.valueOf(kk).trim(); 
							mName10="CHOICE"+String.valueOf(kk).trim(); 
							try
							{
								if (request.getParameter(mName1)==null)
									mChk="N";
								else
									mChk=request.getParameter(mName1).toString().trim();
								mSemester=Integer.parseInt(request.getParameter(mName2).toString().trim());
								mSemType=request.getParameter(mName3).toString().trim();
								mSubjType=request.getParameter(mName4).toString().trim();
								mSubjId=request.getParameter(mName5).toString().trim();
								mSubjName=request.getParameter(mName6).toString().trim();
								mCourseCrPt=Double.parseDouble(request.getParameter(mName7).toString().trim());
								if(request.getParameter(mName8)==null)
								{
									mElecCode="";
								}
								else
								{
									mElecCode=request.getParameter(mName8).toString().trim();
								}
								mBasket=request.getParameter(mName9).toString().trim();
								if (request.getParameter(mName10)==null)
									mChoice="";
								else
									mChoice=request.getParameter(mName10).toString().trim();
								//out.print(mElecCode);
							}
							catch(Exception e)
							{
							}
							if(mBasket.equals("D") && !mElecCode.equals("") && mChk.equals("Y"))
							{
								for(int msem=1;msem<=mSem;msem++)
								{
									qry="Select MINSUBJECT MinSubj, MAXSUBJECT MaxSubj From BasketMaster Where INSTITUTECODE='"+mInst+"' And ACADEMICYEAR='"+mAcad+"' And PROGRAMCODE='"+mProg+"' And TAGGINGFOR='"+mTag+"' And SECTIONBRANCH='"+mSect+"' And SEMESTER="+msem+" And BASKET='D'";
									rsMaxSubjLmt=db.getRowset(qry);
									out.print(qry);
									if(rsMaxSubjLmt.next())
									{
										MinForDBasket=rsMaxSubjLmt.getInt("MinSubj");
										MaxForDBasket=rsMaxSubjLmt.getInt("MaxSubj");
									}
									if(mSemester==msem)
									{
										MaxSubjFlag++;
									}
									if(MaxSubjFlag<=MinForDBasket || MaxSubjFlag>=MaxForDBasket)
									{
										MaxSubjTknFlag++;
									}
								}
							}
							if(mSubjType.equals("C"))
								mSubSect=mSubSect;
							else
								mSubSect="";

							if(mSubjType.equals("E"))
								mElecCode=mElecCode;
							else
								mElecCode="";

							if(MaxSubjTknFlag==0)
							{
								if(mChk.equals("Y") && (mChoice!=null || !mChoice.equals("")))
								{
									qry="select 'Y' from PR#STUDENTSUBJECTCHOICE where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mExamCode+"'";
									qry=qry+" and ACADEMICYEAR='"+mAcad+"' and PROGRAMCODE='"+mProg+"' and TAGGINGFOR='"+mTag+"' and ";
									qry=qry+" SECTIONBRANCH='"+mSect+"' and SUBJECTID='"+mSubjId+"' and STUDENTID='"+mChkMemID+"'";
									Rsd1= db.getRowset(qry);
									//out.print(qry);
									if (Rsd1.next())
									{
										qry="UPDATE PR#STUDENTSUBJECTCHOICE SET CHOICE2="+mChoice+" where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mExamCode+"'";
										qry=qry+" and ACADEMICYEAR='"+mAcad+"' and PROGRAMCODE='"+mProg+"' and TAGGINGFOR='"+mTag+"' and ";
										qry=qry+" SECTIONBRANCH='"+mSect+"' and SUBJECTID='"+mSubjId+"' and STUDENTID='"+mChkMemID+"'";
										aa1=db.update(qry);
									}
									else
									{
										qry="INSERT INTO PR#STUDENTSUBJECTCHOICE ( INSTITUTECODE, EXAMCODE, ACADEMICYEAR, PROGRAMCODE, TAGGINGFOR,";
										qry=qry+" SECTIONBRANCH,SEMESTER, STUDENTID, SUBJECTID, SEMESTERTYPE, ELECTIVECODE, CHOICE2, SUBSECTIONCODE, ENTRYDATE,ENTRYBY,SUBJECTTYPE)";
										qry=qry+" VALUES ('"+mInst+"','"+mExamCode+"','"+mAcad+"','"+mProg+"','"+mTag+"','"+mSect+"','"+mSemester+"',";
										qry=qry+" '"+mMemberID+"','"+mSubjId+"','"+mSemType+"','"+mElecCode+"','"+mChoice+"', '"+mSubSect+"', sysdate,'"+mMemberID+"','"+mSubjType+"')";
										n=db.insertRow(qry);
									}
									if(aa1>0)
									{
										out.print(qry);
										db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"STUDENT PRE REGISTRATION CHOICE2", "Exam Code : "+mExamCode +"Academic Year : "+ mAcad+ "Program Code : "+mProg+"Subject : "+mSubjName, "NO MAC Address" , mIPAddress);
										%>
										<tr><td><%=mSubjName%></td>
										<td align=center><%=mSubjType%></td>
										<td align=center><%=mCourseCrPt%></td>
										<td align=center><%=mChoice%></td>
										<td align=center><font color=Green>Updated</font></td></tr>
										<%
									}
									else
									{
										mErrFlag++;
									}
									if(n>0)
									{
										out.print(qry);
										db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"STUDENT PRE REGISTRATION CHOICE2", "Exam Code : "+mExamCode +"Academic Year : "+ mAcad+ "Program Code : "+mProg+"Subject : "+mSubjName, "NO MAC Address" , mIPAddress);
										%>
										<tr><td><%=mSubjName%></td>
										<td align=center><%=mSubjType%></td>
										<td align=center><%=mCourseCrPt%></td>
										<td align=center><%=mChoice%></td>
										<td align=center><font color=Green>Submitted</font></td></tr>
										<%
									}
									else
									{
										mErrFlag++;
									}
									//out.print("ERROR - "+mErrFlag+" ERRORFREE - "+n);
								}
							}
							else
							{
								mLimitExceeded++;
							}
						}
					}
					else
					{
						%><CENTER><img src='../../Images/Error1.jpg'><b><font size=3 face='Arial' color='Red'> Your Course Credit Points must be within the permissible limit [between <%=mMinCrLmt%> and <%=mMaxCrLmt%>] !</font></CENTER><%
					}

					if(mLimitExceeded>0)
					{
						%><CENTER><img src='../../Images/Error1.jpg'><b><font size=3 face='Arial' color='Red'> Total Elective Subject (without preference) chosen by you must be within the permissible limit!</font></CENTER><%
					}

					%>
					<tr><td colspan=5 align=center><Font color=green face=verdana size=4><B>Total Course Credit Point Taken By You : <%=mCourseCrPtTkn%><b></font></td></tr>
					</table>
					<marquee scrolldelay=125 behavior=alternate><font color=red><b>NOTE:- <font color=red size=2>&nbsp; &nbsp; # After Submitting your Choice for Regular and BackPaper,you need to send your choice to HOD for Approval.</font>
					</marquee>
					<%
					if(msendtohod.equals("Y"))
					{
						qry="Update PREVENTS set SENDTOHOD='Y',SENTBY='"+mMemberID+"',SENTDATE=sysdate";
					     	qry=qry +" where institutecode='"+mInst+"' and PREVENTCODE='"+mPrcode+"' and MEMBERID='"+mMemberID+"' and MEMBERTYPE='"+mChkMType+"'";
						int an=db.update(qry);
						if(an>0)
						{
							// Log Entry
							//-----------------
							db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"Pre-Registration Subject Choices Send To HOD", "ExamCode: "+mExamCode+ "Preventcode: "+mPrcode+" MemberID :"+mMemberID ,"NO MAC Address",mIPAddress);
							//-----------------
						}
						%>
						<b><font color=Green>
						<ui>Your Subject Chocice has been sent to HOD.<br>
						<ui>Now You can not change your choice using this form.
						</font><br></b>
						<%
					}
				}
			} //3
			else
			{
				out.print("<br><img src='../../Images/Error1.jpg'>");
				out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>No subject found or choice given by you!</font> <br>");	
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
			<h3>	<br><img src='../../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
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
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> No Item Selected...</font> <br>");
	//out.print(e.getMessage()+ " - " +e);
}
%><br>
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