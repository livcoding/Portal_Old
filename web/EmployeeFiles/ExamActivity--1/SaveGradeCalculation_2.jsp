<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<script language=javascript>
if(window.history.forward(1) != null)
window.history.forward(1);

function validate()
{
	var temp="";
	var count="";
	temp=document.frm.temp.value;
	count=document.frm.count.value;
	//alert(temp+";;;;;;;;;"+count);
	if(temp!=count && temp!=0)
	{
		alert("Some of the Grades are Not Assigned");
		return false;
	}

//	return false;
}
</script>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Student Wise Grade</b></TD>
</font></td></tr>
</TABLE>
<%
try
{
	GlobalFunctions gb =new GlobalFunctions();
	OLTEncryption enc=new OLTEncryption();
	DBHandler db=new DBHandler();
	String  mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
	String mDMemberCode="",mDMemberType="";
	String mInst="",mExamCode="",mSubjectCode="",qryy="";
	int mTotalStudents=0,mStudentsRejected=0,mStudentsConsidered=0;
	double mMean=0,mInitialAVGP=0,mFinalAVGP=0,mDeviation=0;
	int len11=0,pos11=0,pos111=0,pos211=0,pos311=0,pos411=0;
	String mRecommendedFrom="",mRecommendedTo="",GradeMasterLowerLimit="",mFst="";
	String InitialCount="",GradeMasterTotalCount="";	
	int mCheck=0;
	String mName1="",abc="",qry="",qry1="",qry2="",qry3="",qry4="",qry5="",qry6="",qry8="";
	ResultSet rs5=null,rs6=null,rsy=null;
	String mSemType="",mSem="",mETOD="N",mSem1="";
	Connection con = null;
	Statement st = null;
	int mStatus=0;
	int mError=0;
	int pos2Init=0,pos2=0,pos3Init=0,pos20=0;
	int count=0;
		int mCount=0,fs=0,mStudentCount=0;
	String mWeightageInit="",mWeightage="";
	int pos4Init=0,pos201=0,mSend=0;
	String mMassCut="",mMass="";
	String mInitMarks="",mWe="";
	String mName11="",abc1="";
	String Stdidclub="",mBreakSlno="",mFstid="''";

	String qrysl="";
				ResultSet rssl=null;
				String mSubjectCode1="",qryss="";
				ResultSet rss=null; 
		String grade="";
		String Studid="";
		String Fstid="";
		String mGrade="";
		String marks="";

	if (session.getAttribute("InstituteCode")==null)
	{
		mInst="";
	}
	else
	{
		mInst=session.getAttribute("InstituteCode").toString().trim();
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
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
	{
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
		qry="Select WEBKIOSK.ShowLink('146','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	    RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{
			String mFType="";
			if (mDMemberType.equals("E"))
				mFType="I";
			else if(mDMemberType.equals("V"))
				mFType="E";
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

			String mSave="",mCheckFstid="";

			if(request.getParameter("Save")==null)
				mSave="N";
			else
				mSave=request.getParameter("Save").toString().trim();

			//if(mSave.equals("Y"))
					

				if(request.getParameter("FS")==null)
					fs=0;
				else
					fs=Integer.parseInt(request.getParameter("FS"));


				if(request.getParameter("checkctr")==null)
					mCheck=0;
				else
					mCheck=Integer.parseInt(request.getParameter("checkctr").toString().trim());

				if(request.getParameter("count")==null)
					mCount=0;
				else
					mCount=Integer.parseInt(request.getParameter("count").toString().trim());

				if(request.getParameter("mCheckFstid")==null)
					mCheckFstid="";
				else
					mCheckFstid=request.getParameter("mCheckFstid").toString().trim();	
				//out.print(mCheckFstid+"asdasdasd");


				
				if(request.getParameter("ExamCode")==null)
					mExamCode="";
				else
					mExamCode=request.getParameter("ExamCode").toString().trim();

				if(request.getParameter("Subject")==null)
					mSubjectCode="";
				else
					mSubjectCode=request.getParameter("Subject").toString().trim();

		
				if(request.getParameter("SEMESTER")==null)
					mSem1="";
				else
					mSem1=request.getParameter("SEMESTER").toString().trim();
				int sno=0;
				if(request.getParameter("sno")==null)
					sno=0;
				else
					sno=Integer.parseInt(request.getParameter("sno"));
				
				if(request.getParameter("breakslno")==null)
					mBreakSlno="";
				else
					mBreakSlno=request.getParameter("breakslno").trim();
			
		
			if(mCheckFstid!=null)
			{
				
				if(mExamCode!=null && !mExamCode.equals(""))
				{
					DBConn co = null;
					try
					{
						co = new DBConn();
						con = co.DBConOpen();

						st = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
						con.setAutoCommit(false);
						
				String qrychk="select 'Y' from V#EX#GRADESUBJECTBREAKUP where  Examcode='"+mExamCode+"' and subjectid='"+mSubjectCode+"' and InstituteCode='"+mInst+"'  ";
				//out.print(qrychk);
				ResultSet rsck=db.getRowset(qrychk);
				if (!rsck.next())
				{
						
						qrysl="Select Lpad(nvl(MAX(TO_NUMBER(SUBSTR(BREAK#SLNO,6,3))),0)+1,3,'0') ";
						qrysl=qrysl+" From V#EX#GRADESUBJECTBREAKUP  where Examcode='"+mExamCode+"' and subjectid='"+mSubjectCode+"' and InstituteCode='"+mInst+"'  ";
						//out.println(qrysl);
						rssl=db.getRowset(qrysl);
						if(rssl.next() && mBreakSlno.equals(""))
						{
							mBreakSlno=mSubjectCode+rssl.getString(1);
						}
						//out.println(mBreakSlno);
						String qrySEL="SELECT Fstid from EX#GRADESUBJECTBREAKUP where BREAK#SLNO='"+mBreakSlno+"' and employeeid='"+mChkMemID+"'";
						//out.println(qrySEL);
						ResultSet rssSEL=db.getRowset(qrySEL);
						while(rssSEL.next())
						{
							mStatus=1;
							String qryupdate="update EXAMEVENTSUBJECTTAGGING set LOCKED='N' WHERE FSTID='"+rssSEL.getString("FSTID")+"' ";
							qryupdate=qryupdate+" AND nvl(PUBLISHED,'N')='Y' and nvl(PROCEEDSECOND,'N')='Y' AND ";
							qryupdate=qryupdate+" nvl(DEACTIVE,'N')='N' ";

							//out.print(qryupdate+"EXAMEVENTSUBJECTTAGGING");
							st.addBatch(qryupdate);
						}
						String  delquery="delete from EX#GRADESUBJECTBREAKUP where BREAK#SLNO='"+mBreakSlno+"' and employeeid='"+mChkMemID+"'";
						st.addBatch(delquery);
					
					try
						{
							
					
							for(int i=1;i<=fs;i++)
							{
								//out.print(request.getParameter("FSTID"+i)+"iiiii"+fs);
								if(!(request.getParameter("FSTID"+i)==null )  )
								{

								mName1=request.getParameter("FSTID"+i).toString().trim();	
											
										
								//mName1=request.getParameter("FSTID"+i).toString().trim();
																
								//out.print("sdfsfs"+mName1);
																
									//if( mName1!=null || !mName1.equals("") )
									//{
									
								
									qry8="update EXAMEVENTSUBJECTTAGGING set LOCKED='Y' WHERE FSTID='"+mName1+"' ";
									qry8=qry8+" AND nvl(PUBLISHED,'N')='Y' and nvl(PROCEEDSECOND,'N')='Y' AND ";
									qry8=qry8+" nvl(DEACTIVE,'N')='N' ";
								//	 out.print(qry8);
									st.addBatch(qry8);	
														
									
										qry6="select 'y' from EX#GRADESUBJECTBREAKUP where FSTID='"+mName1+"' and BREAK#SLNO='"+mBreakSlno+"'  ";
											rs6=db.getRowset(qry6);
											// out.println(abc);
											if(!rs6.next())
											{
												qry1="INSERT INTO EX#GRADESUBJECTBREAKUP(FSTID, BREAK#SLNO, ETOD,FACULTYTYPE, EMPLOYEEID) ";
												qry1=qry1+" VALUES ('"+mName1+"' ,'"+mBreakSlno+"' ,'"+mETOD+"','"+mFType+"','"+mChkMemID+"' ) ";
												st.addBatch(qry1);
											//out.print(qry1);
												mStatus=1;
											}
											
												
									//}		
								}
							  } // closing of for
						//}
								
						}
						catch(Exception e)
						{
							//out.println(e);
						}


					}//RSCHK.NEXT
		
					// changes ankur 
					else
					{
							String qryck="Select BREAK#SLNO  From V#EX#GRADESUBJECTBREAKUP  where Examcode='"+mExamCode+"' and subjectid='"+mSubjectCode+"' and InstituteCode='"+mInst+"'  ";
							//out.println(qryck);
							ResultSet rsk=db.getRowset(qryck);
								if(rsk.next() )
								{
									mBreakSlno=rsk.getString("BREAK#SLNO").toString().trim();
								}
								//out.println(mBreakSlno);
								String qrySEL="SELECT Fstid from EX#GRADESUBJECTBREAKUP where BREAK#SLNO='"+mBreakSlno+"' and employeeid='"+mChkMemID+"'";
										//out.println(qrySEL);
										ResultSet rssSEL=db.getRowset(qrySEL);
										while(rssSEL.next())
										{
											mStatus=1;
											String qryupdate="update EXAMEVENTSUBJECTTAGGING set LOCKED='N' WHERE FSTID='"+rssSEL.getString("FSTID")+"' ";
											qryupdate=qryupdate+" AND nvl(PUBLISHED,'N')='Y' and nvl(PROCEEDSECOND,'N')='Y' AND ";
											qryupdate=qryupdate+" nvl(DEACTIVE,'N')='N' ";
										//	out.print(qryupdate);
											st.addBatch(qryupdate);
										}
										
									

						try
							{

							for(int i=1;i<=fs;i++)
							{
								//	out.print(request.getParameter("FSTID"+i)+"sdffsf32323sdfsdsda"+fs);

								if(request.getParameter("FSTID"+i)!=null )  
								{
									mName1=request.getParameter("FSTID"+i).toString().trim();
															
								//out.print("ELSE PArt"+mName1);
															
									//if( mName1!=null || !mName1.equals("") )
									//{
										qry8="update EXAMEVENTSUBJECTTAGGING set LOCKED='Y' WHERE FSTID='"+mName1+"' ";
										qry8=qry8+" AND nvl(PUBLISHED,'N')='Y' and nvl(PROCEEDSECOND,'N')='Y' AND ";
										qry8=qry8+" nvl(DEACTIVE,'N')='N' ";
										// out.print(qry8);
										st.addBatch(qry8);	
										
											qry6="select 'Y' from EX#GRADESUBJECTBREAKUP where FSTID='"+mName1+"' and BREAK#SLNO='"+mBreakSlno+"'  ";
											rs6=db.getRowset(qry6);
											// out.println("<br>"+qry6);
											if(!rs6.next())
											{
												qry1="INSERT INTO EX#GRADESUBJECTBREAKUP(FSTID, BREAK#SLNO, ETOD,FACULTYTYPE, EMPLOYEEID) ";
												qry1=qry1+" VALUES ('"+mName1+"' ,'"+mBreakSlno+"' ,'"+mETOD+"','"+mFType+"','"+mChkMemID+"' ) ";
											//	out.print(qry1);
												st.addBatch(qry1);
											 //out.print(qry1);
											}
											else
											{
												mStatus=1;
											}
									
									//}		
							    }
						    } // closing of for
						 }
						catch(Exception e)
						{
						//out.println(e);
						}
					}

//***************************Student grades to save in SDTUDENTWISEGRADE***************** 

 
if(mStatus==1)
{
	/*****************************************************/
	for(int yy =1; yy<=sno;yy++)
	{
		if(request.getParameter("studentcheck"+yy)==null)
		{	
						
		}
		else
		{
			//out.print("elsese");
			count++;
			//out.println(count);
			if(request.getParameter("fstidstudid"+yy)==null)
			{
				grade="";
			}
			else
			{
				grade=request.getParameter("fstidstudid"+yy);
				Fstid=grade.substring(0,grade.indexOf("@@@"));
				Studid=grade.substring(grade.indexOf("@@@")+3,grade.indexOf("***"));
				if(Stdidclub.equals(""))
					Stdidclub="'"+Studid+"'";
				else
					Stdidclub=Stdidclub+",'"+Studid+"'";
				marks=grade.substring(grade.indexOf("***")+3,grade.length());	
			}
			if(request.getParameter("grade"+yy)==null)
			{
				mGrade="N";
			}
			else
			{
				mGrade=request.getParameter("grade"+yy);			
			}
			
//out.print(mGrade+"JIIT1314");
if(!mGrade.equals(" ") && !mGrade.equals("N") )

	{
			String qry12="select 'Y' FROM STUDENTWISEGRADE WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExamCode+"' AND FSTID='"+Fstid+"' AND BREAK#SLNO='"+mBreakSlno+"' AND STUDENTID='"+Studid+"' ";
		
			ResultSet rsk=db.getRowset(qry12);
			if(!rsk.next())
			{

				qry4="INSERT INTO STUDENTWISEGRADE(INSTITUTECODE,EXAMCODE,FSTID,BREAK#SLNO, STUDENTID, ";
				qry4=qry4+" INITIALMARKS,INITIALGRADE, ";
				qry4=qry4+" FINALMARKS,FINALGRADE,ENTRYBY,ENTRYDATE,DOCMODE,ETOD) ";
				qry4=qry4+" VALUES ('"+mInst+"','"+mExamCode+"','"+Fstid+"' ,'"+mBreakSlno+"', ";
				qry4=qry4+" '"+Studid+"' ,'"+marks+"' ,'"+mGrade+"' , ";
				qry4=qry4+" '"+marks+"' ,'"+mGrade+"','"+mChkMemID+"',SYSDATE,'D','"+mETOD+"') ";
				//out.println(count+":insert:::STAUS=1"+qry4);
				st.addBatch(qry4);
			}
			else
			{
				
				qry4="UPDATE STUDENTWISEGRADE SET INITIALGRADE='"+mGrade+"', INITIALMARKS='"+marks+"' ,FINALMARKS='"+marks+"',FINALGRADE='"+mGrade+"',ENTRYBY ='"+mChkMemID+"',ENTRYDATE=SYSDATE WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExamCode+"' AND FSTID='"+Fstid+"' AND BREAK#SLNO='"+mBreakSlno+"' AND STUDENTID='"+Studid+"'  ";
			//	out.println(count+"::::updateSTAUS=1"+qry4);
				st.addBatch(qry4);
			
			}
	}
	  }//END OF ELSE
	%>
	  <input type="hidden" name="Stdidclub" value=<%=Stdidclub%>>
	<input type="hidden"  name="mCheckFstid" value="<%=mCheckFstid%>">
	<input type="hidden" name="Subject" value=<%=mSubjectCode%>>
	<%
	}//END OF FOR
	//out.println(count);




	String qrycalc="SELECT 'Y' FROM GRADECALCULATION  where INSTITUTECODE='"+mInst+"' and EXAMCODE ='"+mExamCode+"' and  SUBJECTID = '"+mSubjectCode+"' and BREAK#SLNO ='"+mBreakSlno+"' ";
	ResultSet rscalc=db.getRowset(qrycalc);
//out.print(qrycalc+"<br>");
	if(rscalc.next())
	{
	qry2="update GRADECALCULATION set TOTALSTUDENT='"+sno+"' ,ENTRYBY='"+mChkMemID+"' ,ENTRYDATE=sysdate where INSTITUTECODE='"+mInst+"' and EXAMCODE ='"+mExamCode+"' and  SUBJECTID = '"+mSubjectCode+"' and BREAK#SLNO ='"+mBreakSlno+"'";
	//out.println(qry2);
	st.addBatch(qry2);	
	}
	else
	{
	
	qry2="INSERT INTO GRADECALCULATION (INSTITUTECODE, EXAMCODE, SUBJECTID,BREAK#SLNO, TOTALSTUDENT,";
	qry2=qry2+" GRADEFLAG,ENTRYBY,ENTRYDATE,STATUS ) ";
	qry2=qry2+" VALUES ('"+mInst+"' ,'"+mExamCode+"' ,'"+mSubjectCode+"' ,'"+mBreakSlno+"'  ";
	qry2=qry2+" ,'"+sno+"', '"+mETOD+"','"+mChkMemID+"',SYSDATE,'D') ";
//out.println(count+"::::"+qry2);
	int j=db.insertRow(qry2);
	}
	
	try
	{
		int updateCounts[] = st.executeBatch();
		//out.println(updateCounts.length);
		if(updateCounts.length>0)
		{
		


		// mError=1;
		// mSend=1;
		 // Log Entry
		 //-----------------
		 db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"Grade Entry ", "ExamCode: "+mExamCode+ " subjectid :  "+mSubjectCode+" MemberID :"+mChkMemID,"NO MAC Address",mIPAddress);
		 //-----------------
	
	//		out.println(updateCounts.length+"as211");
	
		
	
	/*RequestDispatcher rd=request.getRequestDispatcher("GradeCalculationAction.jsp?Subject="+mSubjectCode+"&ExamCode="+mExamCode+"&mCheckFstid="+mCheckFstid+"&checkctr="+mCheck+"&count="+mCount+"&FS="+fs+"&x=");
	rd.forward(request,response);*/
		}
		else
		{
			//out.print("Errore");
		}
		
	}
	catch(Exception e)
	{
		out.println("e"+e);
		e.printStackTrace();
	}
	/*------------------------------------------------*/


}//end of if status



if(mStatus==0)
{

for(int yy =1; yy<=sno;yy++)
{

	if(request.getParameter("studentcheck"+yy)==null)
	{
		//out.print("NULL Styudentid");
	}
	else
	{
		count++;

		
		//out.println(count);
		if(request.getParameter("fstidstudid"+yy)==null)
		{
			grade="";
		}
		else
		{
			grade=request.getParameter("fstidstudid"+yy);
			Fstid=grade.substring(0,grade.indexOf("@@@"));						
			Studid=grade.substring(grade.indexOf("@@@")+3,grade.indexOf("***"));								
			marks=grade.substring(grade.indexOf("***")+3,grade.length());	
		}
		if(request.getParameter("grade"+yy)==null)
		{
			mGrade="";
		}
		else
		{
			mGrade=request.getParameter("grade"+yy);			
		}

	if(!mGrade.equals(" ") && !mGrade.equals("N") )
	{
		
		String qryck="select 'Y' FROM STUDENTWISEGRADE WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExamCode+"' AND FSTID='"+Fstid+"' AND BREAK#SLNO='"+mBreakSlno+"' AND STUDENTID='"+Studid+"' ";
			//out.print("<BR>mStatus=0"+qrychk);
			ResultSet rsk=db.getRowset(qryck);
			if(!rsk.next())
			{
				qry4="INSERT INTO STUDENTWISEGRADE(INSTITUTECODE,EXAMCODE,FSTID,BREAK#SLNO, STUDENTID, ";
				qry4=qry4+" INITIALMARKS,INITIALGRADE, ";
				qry4=qry4+" FINALMARKS,FINALGRADE,ENTRYBY,ENTRYDATE,DOCMODE,ETOD) ";
				qry4=qry4+" VALUES ('"+mInst+"','"+mExamCode+"','"+Fstid+"' ,'"+mBreakSlno+"', ";
				qry4=qry4+" '"+Studid+"' ,'"+marks+"' ,'"+mGrade+"' , ";
				qry4=qry4+" '"+marks+"' ,'"+mGrade+"','"+mChkMemID+"',SYSDATE,'D','"+mETOD+"') ";
				//out.println(count+"::::"+qry4+"<br>");
			
				st.addBatch(qry4);
			}
			else
			{

				


				qry4="UPDATE STUDENTWISEGRADE SET INITIALGRADE='"+mGrade+"', FINALGRADE='"+mGrade+"', INITIALMARKS='"+marks+"' ,FINALMARKS='"+marks+"',ENTRYBY ='"+mChkMemID+"',ENTRYDATE=SYSDATE WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExamCode+"' AND FSTID='"+Fstid+"' AND BREAK#SLNO='"+mBreakSlno+"' AND STUDENTID='"+Studid+"'  ";
				//out.println(count+"::::updateSTAUS=1"+qry4);
				st.addBatch(qry4);
			}
	}
	}//end of else
}//end of For




String qrycalc="SELECT 'Y' FROM GRADECALCULATION  where INSTITUTECODE='"+mInst+"' and EXAMCODE ='"+mExamCode+"' and  SUBJECTID = '"+mSubjectCode+"' and BREAK#SLNO ='"+mBreakSlno+"'  ";
	ResultSet rscalc=db.getRowset(qrycalc);
	//out.print(qrycalc+"<br>");
	if(rscalc.next())
	{
	qry2="update GRADECALCULATION set TOTALSTUDENT='"+sno+"' ,ENTRYBY='"+mChkMemID+"' ,ENTRYDATE=sysdate where INSTITUTECODE='"+mInst+"' and EXAMCODE ='"+mExamCode+"' and  SUBJECTID = '"+mSubjectCode+"' and BREAK#SLNO ='"+mBreakSlno+"'";
	//out.println(qry2);
	st.addBatch(qry2);	
	}
	else
	{
	
	qry2="INSERT INTO GRADECALCULATION (INSTITUTECODE, EXAMCODE, SUBJECTID,BREAK#SLNO, TOTALSTUDENT,";
	qry2=qry2+" GRADEFLAG,ENTRYBY,ENTRYDATE,STATUS ) ";
	qry2=qry2+" VALUES ('"+mInst+"' ,'"+mExamCode+"' ,'"+mSubjectCode+"' ,'"+mBreakSlno+"'  ";
	qry2=qry2+" ,'"+sno+"', '"+mETOD+"','"+mChkMemID+"',SYSDATE,'D') ";
	//out.println(count+"::::"+qry2);
	int j=db.insertRow(qry2);
	}
//***************************student grades to save*****************
try
{
	int updateCounts[] = st.executeBatch();//out.println(updateCounts.length);
	if(updateCounts.length>0)
	{	
		
		// Log Entry
		//-----------------
	    db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"Grade Entry ", "ExamCode: "+mExamCode+ " subjectid :  "+mSubjectCode+" MemberID :"+mChkMemID,"NO MAC Address",mIPAddress);
		//-----------------
		 mSend=1;


		/*	RequestDispatcher rd=request.getRequestDispatcher("GradeCalculationAction.jsp?Subject="+mSubjectCode+"&ExamCode="+mExamCode+"&mCheckFstid="+mCheckFstid);
		rd.forward(request,response);*/

			%>	
			<table width=100%>
			<TR>
			<td align=center>
			</td>
			</tr>
			</table>
			<%
    }
	else
	{
		out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Error While Saving Record...... </font> <br>");
	 }

	 
}
catch(Exception e)
 {
	out.print(e);
 }
} // closing of mStauts==0




con.commit();
con.close();
co.DBConClose();

}
//end of try connection
catch(Exception e)
{
	con.close();
	co.DBConClose();
	out.print(e);
}

}
//end of EXAMCODE != NULL
//action="TempPagesecond.jsp"

qryss="select count(studentid) from  studentwisegrade where  InstituteCode='"+mInst+"' and  examcode='"+mExamCode+"' and BREAK#SLNO='"+mBreakSlno+"' ";
rss=db.getRowset(qryss);
rss.next();
mStudentCount=rss.getInt(1);			



if(mCount > mStudentCount)
{
	//System.out.print(mCount+"mCount:::mStudentCount"+mStudentCount);
//response.sendRedirect("GradeCalculationAction.jsp?Subject="+mSubjectCode+"&ExamCode="+mExamCode+"&mCheckFstid="+mCheckFstid+"&checkctr="+mCheck+"&count="+mCount+"&FS="+fs+"&NoStudent="+mStudentCount+"&x=");
%>
<br>
<center><a href="GradeCalculationAction.jsp?Subject=<%=mSubjectCode%>&amp;ExamCode=<%=mExamCode%>&amp;mCheckFstid=<%=mCheckFstid%>&amp;checkctr=<%=mCheck%>&amp;count=<%=mCount%>&amp;FS=<%=fs%>&amp;NoStudent=<%=mStudentCount%>&amp;x='1'">
<font face=verdana size=4>Click to Enter More Grades </a>
</center>
</br>
<%
}
//out.print(mCount+"sdfsf"+mStudentCount);
if(mCount==mStudentCount)
{
	


%>

	<form name="frm" method="post" action="TempPagesecond.jsp">

	<input type="hidden" name="ExamCode" value=<%=mExamCode%>>
	 <input type="hidden" name="Stdidclub" value=<%=Stdidclub%>>
	<input type="hidden"  name="mCheckFstid" value="<%=mCheckFstid%>">
	<input type="hidden" name="SEMESTER" value=<%=mSem1%>>
	<input type="hidden" name="BREAKSLNO" value=<%=mBreakSlno%>>
 	<input type="hidden" name="Subject" value=<%=mSubjectCode%>> 
	<%
	String mNam="";
	String mSc="";
	String time="",mSubjectID="";
	String qrysub="select subject,SUBJECTCODE,Subjectid ,to_char(sysdate,'DD/MM/YYYY-HH:MI:SS-AM')dd from subjectmaster where subjectID='"+mSubjectCode+"'  and INSTITUTECODE='"+mInst+"' and nvl(deactive,'N')='N' ";
	//out.print(qrysub);
	ResultSet rssub=db.getRowset(qrysub);
	if(rssub.next())
	{
	 		mNam=rssub.getString("subject");
			mSc=rssub.getString("SUBJECTCODE");
			mSubjectID=rssub.getString("SUBJECTID");
			time=rssub.getString("dd");
	}
	else
	{
			mNam="";
			mSc="";
			time="";
	}
//out.print(mCheckFstid+"mCheckFstidmCheckFstid");
%>
 <input type="hidden" name="time" value=<%=time%>>
<TABLE ALIGN=CENTER rules=COLUMNS rules=groups  cELLSPACING=0 BORDER=0>
<tr><td><b>Coordinator/Member Name : </b><font color=dark brown><b><%=mMemberName%>&nbsp;(<%=mDMemberCode%>)</font></b></td>
<TD><b> Date & Time :<font color=dark brownt><%=time%></font></b></TD>
</tr>
<TR>
		<TD><b>Exam Code :<font color=dark brown><%=mExamCode%></font></b></TD>
		<TD nowrap ><b>&nbsp; Subject Code :
		<font color=dark brown><%=mNam%>&nbsp(<%=mSc%>)</font></b></TD>
</TR>
	
 
<!--  <tr><td align=center colspan=3><a  href="GradeCalculationAction.jsp?Subject=<%=mSubjectID%>&ExamCode=<%=mExamCode%>&mCheckFstid=<%=mCheckFstid%>&checkctr=<%=mCheck%>&count=<%=mCount%>" ><b>Click Back to Enter more Grade</b></a></td></tr>  -->


</TABLE>
<br>
 <TABLE bgcolor=#fce9c5 class="sort-table" id="table-1" ALIGN=CENTER rules=COLUMNS CELLSPACING=0 width=76% BORDER=1> 
<thead>
<tr bgcolor="#ff8c00">
	<td><b><font color=white>SNo.</font></b></td>
	<td><b><font color=white >Roll No.</font></b></td>
	<td><b><font color=white >Student Name</font></b></td>
	<td><b><font color=white >FinalMarks</font></b></td>
	<td><b><font color=white >FinalGrade</font></b></td>
</tr>
</thead>
<tbody>
</tbody>
<%
int temp=0;	
count=0;
String query="select b.ENROLLMENTNO,b.STUDENTNAME,a.FINALMARKS,nvl(a.FINALGRADE,' ')FINALGRADE,nvl(a.FINALGRADE,' ')FINALGRADE1 from STUDENTWISEGRADE a , Studentmaster b WHERE a.EXAMCODE='"+mExamCode+"' and a.fstid in ("+mCheckFstid+")  and a.INSTITUTECODE='"+mInst+"' and a.INSTITUTECODE=b.INSTITUTECODE and a.BREAK#SLNO='"+mBreakSlno+"' and a.STUDENTID=b.STUDENTID and nvl(a.DEACTIVE,'N')<>'Y' and nvl(b.DEACTIVE,'N')<>'Y' order by b.ENROLLMENTNO,studentname";	
ResultSet rslist=db.getRowset(query);
//out.println(query+"asdadasd2515454545");
while(rslist.next())
{

	%>
	<tr >
	<td><b><%=++count%> .</b></td>
	<td>&nbsp;<%=rslist.getString("ENROLLMENTNO")%></b></td>
	<td>&nbsp;<%=rslist.getString("STUDENTNAME")%></b></td>
	<td>&nbsp;<%=rslist.getString("FINALMARKS")%></b></td>
	<td>&nbsp;<%=rslist.getString("FINALGRADE")%></b></td>	
		<%
	if(rslist.getString("FINALGRADE1").equals(" ") )
				++temp;		
	%>
	</tr>	
	<%
}
//out.println(temp);
%>

<INPUT TYPE="hidden" NAME="temp" value=<%=temp%>>
<INPUT TYPE="hidden" NAME="count" value=<%=count%>>

</table>	
<script type="text/javascript">
var st1 = new SortableTable(document.getElementById("table-1"),["Number","Number","Number","Number","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","Number"]);
</script>
<br>
<table width=76% align=center>
<tr>
<td align=left>
<b>Name:-<br>
Signature of Instructor:<br>
Submitted on..</b>
</td>
<td align=right><b>*Detained Candidate </b>
</td>
</tr>

</tr>
</table>
<table align=center>
<tr>
<td nowrap align=center title="Click to Print" valign=top>
<table width=10% align=center border=2 bordercolor=magroon><tr><td align=center nowrap><font color=blue>
<b>Click  <a style="CURSOR:hand" onClick="window.print();"><img src="../../Images/printer.gif"></a> To Print</b></font></td></tr>
</table>

<td nowrap align=center title="Click To Save In Excel" valign=top>
<input type="submit" name="Excel" value="Save In Execl">
</td>
<td nowrap align=center title="Click To Freeze" valign=top>
<input type="submit" name="finalsave" value="Freeze" onClick="return validate();">
</td>
</tr>
</table>
</form>

<%
}


}
else
{
   %>
	<br>
	<font color=red>
	<h3><br><img src='../../Images/Error1.jpg'>
	<font color=red><b>Grade not saved.....<br>
	</b></font></a>
	</font><br>  
   <%
}

//-----------------------------
//---Enable Security Page Level  
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

} // closing of if(!mMemberID.equals(""))
 //-----------------------------
/*
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}
*/
}
catch(Exception e)
{
	out.print(e);
}
%>