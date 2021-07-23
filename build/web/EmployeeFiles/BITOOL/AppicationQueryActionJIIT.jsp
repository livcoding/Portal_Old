<%@ page language="java" import="java.sql.*,jpalumni.*" %>
<%
/*
	' ********************************************************************************
	' *													   *
	' * File Name:	AppicationQueryActionJIIT.JSP		[For Students]				  
	' * Author:		ANKUR VERMA							      
	' * Date (Modified on):	6 Apr 2011						      
	' * Version:		1.1										
	' * Description:	Displays Application form status
	' **********************************************************************************
*/

ResultSet RSS=null, StudentRecordSet=null,StudentInst=null,rs1=null,rs=null,rsStatus=null; 	  
	DBHandler db=new DBHandler();
String qry="",qry1="";
String mName ="";
String mAIEE ="";
String mAppl="";
String mValue="";
String mInstituteCode="";
String MCOUNSELLINGID="2011";
String mCat="";
String mWRONGAIEEEROLL="";
String mApplicationID="";
String mRejected="",mRemarks="";
String mConfirm="",mLoginID="";
int mApply=0,mInst2=0,mInst1=0,mInst3=0;
String mWrongDD="N",mAppStatus="";
String mailID="jiitinformation@jiit.ac.in";
String mQryType="",mAppSlno="",qryStatus="";
String mQualExam="", mOtherCat="",mPhoto="",mFormRecvd="",mFRecevied="";
String AppliedFor="",mAPPName="";
double mSumNScore=0,mSumNScoreOut=0,m12Per=0.0;
double mNriScore=0.0,mNriScoreOut=0.0,mNRIPerc=0.0;
int ctr=0,ctr1=0;

try
{
	if(request.getParameter("QryType")!=null && request.getParameter("QryType").toString().equals("A"))
		{
		mValue=request.getParameter("TXT1").toString().trim();
		mQryType="A";
		}
	else if (request.getParameter("QryType")!=null && request.getParameter("QryType").toString().equals("R"))
		{
		mValue=request.getParameter("TXT2").toString().trim();
		mQryType="R";
		}
	else if (request.getParameter("QryType")!=null && request.getParameter("QryType").toString().equals("D"))
		{
		mValue=request.getParameter("TXT3").toString().trim();
		mQryType="D";
		}
	else if (request.getParameter("QryType")!=null && request.getParameter("QryType").toString().equals("L1"))
	{
	mValue=request.getParameter("TXT5").toString().trim();
	mQryType="L1";
	}
	else if (request.getParameter("QryType")!=null && request.getParameter("QryType").toString().equals("L2"))
		{
		mValue=request.getParameter("TXT6").toString().trim();
		mQryType="L2";
		}
	else if (request.getParameter("QryType")!=null && request.getParameter("QryType").toString().equals("N1"))
		{
		mValue=request.getParameter("TXT7").toString().trim();
		mQryType="N1";
		}
	else if (request.getParameter("QryType")!=null && request.getParameter("QryType").toString().equals("N2"))
		{
		mValue=request.getParameter("TXT8").toString().trim();
		mQryType="N2";
		}
	else if (request.getParameter("QryType")!=null && request.getParameter("QryType").toString().equals("M1"))
		{
		mValue=request.getParameter("TXT9").toString().trim();
		mQryType="M1";
		}
	else if (request.getParameter("QryType")!=null && request.getParameter("QryType").toString().equals("M2"))
		{
		mValue=request.getParameter("TXT10").toString().trim();
		mQryType="M2";
		}
else if (request.getParameter("QryType")!=null && request.getParameter("QryType").toString().equals("P1"))
		{
		mValue=request.getParameter("TXT11").toString().trim();
		mQryType="P1";
		}
	else if (request.getParameter("QryType")!=null && request.getParameter("QryType").toString().equals("P2"))
		{
		mValue=request.getParameter("TXT12").toString().trim();
		mQryType="P2";
		}
	else
		{
		mValue=request.getParameter("TXT4").toString().trim();
		mQryType="P";
		}

	//out.print(mQryType+ " XXXX  "+mValue);

	mInstituteCode=request.getParameter("InstCode");

	//out.print(mQryType+"asdasd");
	%>
	<html>
	<head>
	<title>Student Examination Result</title>
     <!--  <link href="../Resources/CSS/style.css" rel="stylesheet" type="text/css" /> -->
	<script language="JavaScript" type ="text/javascript">
			if(window.history.forward(1) != null)
			window.history.forward(1);
	</script>
	</head>
	<body topmargin=5 rightmargin=0 leftmargin=0 bottommargin=0 bgcolor="#FFE5BC"  >
	<center>
	<% 
	//	out.print(mQryType+"ddsss");
 if(mQryType.equals("P") || mQryType.equals("D") )  
	{
				
					qry1=	" select a.APPLICATIONNO APPLICATIONNO,a.APPLICATIONSLNO APPLICATIONSLNO, nvl(a.FIRSTNAME,' ')||' ' ||nvl(a.MIDDLENAME,' ')||' '||nvl(a.LASTNAME,' ') name,  to_char(a.DATEOFBIRTH,'yyyymmdd') DATEOFBIRTH,nvl(YEARPASSED,' ')YEARPASSED,decode( a.PERCENTAGE,' ','Percentage not provided',a.PERCENTAGE ) PERCENTAGE from    C#PHARMACYAPPMASTER a   where ( a.APPLICATIONNO='" +  mValue + "'  or a.ROLLNOIN12TH='" +  mValue + "') and a.COUNSELLINGID='"+MCOUNSELLINGID+"'   ";
					//out.print(qry1+"222");
					rs1=db.getRowset(qry1);
					if(rs1.next())
					{
							mAppSlno=rs1.getString("APPLICATIONSLNO");

						
						%>
						 <br><br><br><hr>
						  <center>
						  <h1><font color=Green size=6>
						  Your Application has been recieved. 
						  <br><br>
						 <table align=center width='60%' cellspacing=2 cellpadding=2>
							<tr><td>
							<font color=Black size=2 face='Verdana'>
							<b>Applicant Name </td>
							<td><font color=Black size=2 face='Verdana'><b> : <%=rs1.getString("name")%> </b>
							</td>
							</tr>
							<tr>
							<td><font color=Black size=2 face='Verdana'>
							<b>Application No.   </b></td>
							<td><font color=Black size=2 face='Verdana'>
							<b>: <%=rs1.getString("APPLICATIONNO")%> </b>
							</font>
							</tr>
							
							<tr>							
							<td><font color=Black size=2 face='Verdana'>
							<b>12th Percentage %  </td>
							<td><font color=Black size=2 face='Verdana'>
							<b>: <%=rs1.getDouble("PERCENTAGE")%>&nbsp; </b>
							</td>
							</tr>
							<tr>
							<td><font color=Black size=2 face='Verdana'>
							<b>Priority of Chioce(s)  </b>  
							</td>
							<td nowrap><font color=Black size=2 face='Verdana'>	<b>	</b>
							<%
							qry="select distinct nvl(institutecode,' ')institutecode,decode(programcode,'B.T','BT-BIOTECH','DUAL','DUAL-BIOTECH',' ',programcode )BRANCHCODE ,nvl(PREFERENCE,0)PREFERENCE from C#PHARMACYBRANCHPREFERENCE  where COUNSELLINGID='"+MCOUNSELLINGID+"' and  APPLICATIONSLNO='"+mAppSlno+"'  order by  PREFERENCE ";
						//	out.print(qry);
							rs=db.getRowset(qry);
							while(rs.next())
									{
								ctr++;
									 %>
									 
								<b><%=ctr%>) Institute :<%=rs.getString("institutecode")%>&nbsp;  Branch :<%=rs.getString("BRANCHCODE")%> </b><BR>
									
									
									<%
									}
										 %>
							</td>						
							</tr>
							<tr>
							<td colspan=2><font color=red size=2 face='Verdana'>
								<%
							qry="select distinct SUBJECTNAME, MAXMARKS, MARKSOBTAINED from C#PHARMACYSCORE  where COUNSELLINGID='"+MCOUNSELLINGID+"' and  APPLICATIONSLNO='"+mAppSlno+"'  ";
							rs=db.getRowset(qry);
							//out.print(qry);
							if(!rs.next())
									{
									 %>
									 
									<b> 
									<p>Your Application has been kept pending till 10+2 results are provided.
  <br> Email 10+2 Results to <a href="mailto: neeraj.sharma@jiit.ac.in "> <font color=green>neeraj.sharma@jiit.ac.in  </font></a> before last date of application and send photo copy of the results to the Institute by post.
									</P>
									</b><BR>
									
									<%
									}
										 %>
							</td>
							</tr>

								

							</table>
							<%
								if( rs1.getInt("YEARPASSED")<2009)
						{
							%>
						<font color=red size=3 face='Verdana'>
							<b>Your Application has been rejected because your DOB is earlier than 1st Oct 1990.
						</b></font>
							<%
						}
					}
					
				//}
		else
		{

			%>
				<br><br><br><hr>
				<center>
				<h1><font color=red size=6>
						
				<br>Please enter correct Roll No as filled in the application form or your correct Application No. <br>OR<br>
				No record exists of this Application No. / Date of Birth. Please check details of delivery from postal/courrier authorities.
				</font></h1>
				<br>
				<font color=Black size=2 face='Verdana'></font>
				<hr>
				<br>
			<%
				
			}
  	     
	}// Closing of Pharma Course Qry
//ERROR

//IN CASE OF APPLICATION NO ENTERED
	else if(mQryType.equals("L1") || mQryType.equals("L2")||mQryType.equals("N1") || mQryType.equals("N2")|| mQryType.equals("M1") || mQryType.equals("M2") || mQryType.equals("P1") || mQryType.equals("P2"))  
	{
		String mProg="";
		
		
		if (mQryType.equals("L1") || mQryType.equals("L2"))
		{
			mProg="LTE";
			qry1=	" select a.APPLICATIONNO APPLICATIONNO,a.APPLICATIONSLNO APPLICATIONSLNO, nvl(a.FIRSTNAME,' ')||' ' ||nvl(a.MIDDLENAME,' ')||' '||nvl(a.LASTNAME,' ') name,  to_char(a.DATEOFBIRTH,'dd-mm-yyyy') DATEOFBIRTH,nvl(a.DIPLOMEINSTREAM,' ')DIPLOMEINSTREAM  from C#LATERALAPPMASTER a  where  (   A.ROLLNOIN12TH = '" +  mValue + "'        OR  A.applicationno =      '" +  mValue + "'  ) and		A.counsellingid='"+MCOUNSELLINGID+"'   ";

		}
		else if (mQryType.equals("N1") || mQryType.equals("N2"))
		{
			mProg="NRI";

			qry1=	" select a.APPLICATIONNO APPLICATIONNO,a.APPLICATIONSLNO APPLICATIONSLNO, nvl(a.FIRSTNAME,' ')||' ' ||nvl(a.MIDDLENAME,' ')||' '||nvl(a.LASTNAME,' ') name,  to_char(a.DATEOFBIRTH,'dd-mm-yyyy') DATEOFBIRTH , nvl(PERCENTAGEOF10TH,0)PERCENTAGEOF10TH, nvl(PERCENTAGE,0)PERCENTAGE  from C#NRIAPPLICATIONMASTER a  where  (  a.ROLLNOIN12TH = '" +  mValue + "'        OR  a.applicationno =      '" +  mValue + "'  ) and  a.counsellingid='"+MCOUNSELLINGID+"'    ";
		}
		else if (mQryType.equals("M1") || mQryType.equals("M2")) 
		{
		mProg="MTECH";

		qry1=	" select a.APPLICATIONNO APPLICATIONNO,a.APPLICATIONSLNO APPLICATIONSLNO, nvl(a.FIRSTNAME,' ')||' ' ||nvl(a.MIDDLENAME,' ')||' '||nvl(a.LASTNAME,' ') name,  to_char(a.DATEOFBIRTH,'dd-mm-yyyy') DATEOFBIRTH ,nvl(a.APPLICABLEFOR,'N')APPLICABLEFOR,nvl(ROLLNOIN12TH,'N')ROLLNOIN12TH  from C#PGAPPLICATIONMASTER a where  (   a.ROLLNOIN12TH = '" +  mValue + "'        OR  a.applicationno =      '" +  mValue + "'  ) and  a.counsellingid='"+MCOUNSELLINGID+"'   ";
		}
			else if (mQryType.equals("P1") || mQryType.equals("P2")) 
		{
		mProg="PHD";

		qry1=	" select a.APPLICATIONNO APPLICATIONNO,a.APPLICATIONSLNO APPLICATIONSLNO, nvl(a.FIRSTNAME,' ')||' ' ||nvl(a.MIDDLENAME,' ')||' '||nvl(a.LASTNAME,' ') name,  to_char(a.DATEOFBIRTH,'dd-mm-yyyy') DATEOFBIRTH , nvl(CHOICEOFINSTITUTE,' ')CHOICEOFINSTITUTE, nvl(CHOICEOFPROGRAM,' ')CHOICEOFPROGRAM, nvl(NATIONALLEVELEXAMPASSED,' ')NATIONALLEVELEXAMPASSED, nvl(CHOICEOFINSTITUTE2,' ')CHOICEOFINSTITUTE2, nvl(CHOICEOFINSTITUTE3,' ')CHOICEOFINSTITUTE3, nvl(ELIGIBLE,' ')ELIGIBLE  from C#PHDAPPLICATIONMASTER a where  a.counsellingid='"+MCOUNSELLINGID+"'  and ";
		if(mQryType.equals("P2") )
		qry1=qry1+"		a.DATEOFBIRTH=to_Date('" +  mValue + "', 'dd/mm/yyyy')  ";
		else
		qry1=qry1+"	a.applicationno =      '" +  mValue + "'    ";
		
		}
		//out.print(qry1+"	SDFSDF");
				rs1=db.getRowset(qry1);
				//out.print(rs1.next()+"sdf");
	    if(rs1.next())
		{
			// out.println("sdf");
			mAppSlno=rs1.getString("APPLICATIONSLNO");
			
			
			mAPPName=rs1.getString("name");
		//	out.print(mAppSlno);
						%>
						 <br>
						  <center>
						  <h1><font color=Green  FACE="verdana" size=4>
							 Your Application has been recieved.
							 <%
								 if(mProg.equals("NRI"))
									{
								%>
								<!-- (For JIIT,NOIDA)
								<br>
								<font color=red size=2>Note:</font>
								<font color=black size=2>For
							application status of JUIT,Waknaghat or JUET,Guna Please check with respective Institutes.
							</font> -->
								<%	
									}
								%><hr>
							<br><br>

						 <table align=center  width="40%" cellspacing=0 cellpadding=0>
							<tr><td>
							<font color=Black size=2 face='Verdana'>
							<b>Applicant Name </td>
							<td><font color=Black size=2 face='Verdana'><b> : <%=rs1.getString("name")%> </b>
							</td></tr>
							<tr>
							<td><font color=Black size=2 face='Verdana'>
							<b>Application No.   </b></td>
							<td><font color=Black size=2 face='Verdana'>
							<b>: <%=rs1.getString("APPLICATIONNO")%> </b>
							</font>
							</td></tr>
							<tr>
							<td><font color=Black size=2 face='Verdana'>
							<b>Date of Birth   
							</td>
							<td><font color=Black size=2 face='Verdana'>
							<b>: <%=rs1.getString("DATEOFBIRTH")%> </b>
							</td>
							</tr>
							</table>
							<table align=center  width="60%" cellspacing=3 cellpadding=3>
							<%
							
							if(mProg.equals("LTE"))
							{
							 %>
							<tr>
							
							<td valign=top>
								 <%
							qry="select distinct nvl(EXAMINATIONCODE,' ')EXAMINATIONCODE,nvl(PERCENTAGE,0)PERCENTAGE from C#LATERALQUALIFICATION  where COUNSELLINGID='"+MCOUNSELLINGID+"' and  APPLICATIONSLNO='"+mAppSlno+"' ";
							out.print(qry);
							rs=db.getRowset(qry);
							rs1=db.getRowset(qry);
							if(rs1.next())
							{
							while(rs.next())
							{
								m12Per=rs.getDouble("PERCENTAGE");

								//out.print(m12Per+"asas"+(m12Per<60));
								if(m12Per<60 && !rs.getString("EXAMINATIONCODE").equals("DIPLOMA"))
								{%>
									<font color=red size=2 face='Verdana'><b>You do not meet the Eligibility requirement in that your marks in <%=rs.getString("EXAMINATIONCODE")%> before Diploma are less than 60%.
									</b></font><br><br>
									<%
								}

							//	if(rs.getString("EXAMINATIONCODE").equals("DIPLOMA"))
							//	{
									%>
									<font color=Black size=2 face='Verdana'><b>Stream : &nbsp;&nbsp;<%=rs.getString("EXAMINATIONCODE")%>:-</b>
									</font>
									
									<%
	
									//	out.print(rs.getString("DIPLOMEINSTREAM")+"");
									if(	rs1.getString("DIPLOMEINSTREAM").equals("N"))
									{
										%>
									 <font color=red size=2 face='Verdana'><b>
										Stream of Qualifying exam before Diploma not provided & hence application is not accepted.Please e-mail details to <a href="mailto: neeraj.sharma@jiit.ac.in "> neeraj.sharma@jiit.ac.in  </a> ,
										<a href="mailto: jyoti.jha@jiit.ac.in "> jyoti.jha@jiit.ac.in  </a> 
										</b></font><br><br> 
							
									<%
									}
									else 
									{
										%>
								 	<font color=Black size=2 face='Verdana'>
									<b> <%=rs1.getString("DIPLOMEINSTREAM")%> </b>&nbsp;&nbsp;<br><br>
							 
									<%
									}
									 if(rs.getString("PERCENTAGE").equals("0"))
									{
										%>

											<font color=red size=2 face='Verdana'>
									<b>Percentage in qualifying  exam of the Diploma, not provided & hence application rejected. Please e-mail details to <a href="mailto: neeraj.sharma@jiit.ac.in "> neeraj.sharma@jiit.ac.in  </font></a>,
										<a href="mailto: jyoti.jha@jiit.ac.in "> jyoti.jha@jiit.ac.in  </a> </b>&nbsp;&nbsp;<br>		<br>	
										<%
									}
									
								//}
								

						

			
							}
							}
							else
							{

							qry1="select distinct nvl(BTECHINSTREAM,'N')BTECHINSTREAM,nvl(CGPAPER1SEM,0)CGPAPER1SEM, nvl(CGPAPER2SEM,0)CGPAPER2SEM,nvl(PERCENTAGEIN12TH,0)PERCENTAGEIN12TH  from C#LATERALFIRSTYEARRESULT  where COUNSELLINGID='"+MCOUNSELLINGID+"' and  APPLICATIONSLNO='"+mAppSlno+"' ";
							//out.print(qry);
							rs1=db.getRowset(qry1);
							if(rs1.next())
							{
								
									%><br><br>
									<font color=Black size=2 face='Verdana'><b>Stream :&nbsp;B.TECH&nbsp; &nbsp;&nbsp; :- 
									<%
									if(rs1.getString("BTECHINSTREAM").equals("N"))
									{
										%><font color=red size=2 face='Verdana'><b>
										Stream of Qualifying exam before B.Tech (1st-year) not provided & hence application is not accepted.Please e-mail details to <a href="mailto: neeraj.sharma@jiit.ac.in "> neeraj.sharma@jiit.ac.in  </a> ,
										<a href="mailto: jyoti.jha@jiit.ac.in "> jyoti.jha@jiit.ac.in  </a> 
										</b></font>
										<%
									}
									else
									{
										%>

									<%=rs1.getString("BTECHINSTREAM")%>
									
									<%
									}
									%>
									
									</b>
									</font>
									<%
									if(rs1.getString("CGPAPER1SEM").equals("0"))
									{
										%><br>	<font color=red size=2 face='Verdana'><b>1 Semester :- CGPA/Marks not Provided </b>
										</font>
										<%
									}
										
										if(rs1.getString("CGPAPER2SEM").equals("0"))
									{
										%><br>	<font color=red size=2 face='Verdana'><b>2 Semester :- CGPA/Marks not Provided  </b>
										</font>	
										<%
									}
										if(rs1.getString("PERCENTAGEIN12TH").equals("0"))
									{
										%><br>	<font color=red size=2 face='Verdana'><b>Percentage in 12th :- Percentage not Provided </b>
										</font>	
										<%
									}
									
									

								
								%>
								<br><br>	<font color=red size=2 face='Verdana'><b>Provisionally allowed to take Entrance Exam but results shall be valid only after submission of the documents, confirming eligibility.<b></font>
							
								<%
							}
							}
							
							
								 %>
								

							</td>
							
							
							
							</tr>
							
							</table>
							
							<table align=center cellspacing=0 border=1 bordercolor="#D98242" cellpadding=3> 
								
								
								<thead>
								<tr><td colspan=4 align=center><B>Priority of Chioce(s)</td></tr>
								<tr>
								<td><B> Institute
								</td>
								<td><B> Branch 
								</td>
								</tr>
								</thead>
							
							<%
							qry="select distinct nvl(institutecode,' ')institutecode,nvl(BRANCHCODE,' ')BRANCHCODE,nvl(PREFERENCE,0)PREFERENCE from C#LATERALBRANCHPREFERENCE  where COUNSELLINGID='"+MCOUNSELLINGID+"' and  APPLICATIONSLNO='"+mAppSlno+"' order by  PREFERENCE ";
							//out.print(qry);
							rs=db.getRowset(qry);
							while(rs.next())
							{
									 %>
									 
									<tr>
									<td>
									<%=rs.getString("INSTITUTECODE")%>
									</td>
									
									<td>
									<%=rs.getString("BRANCHCODE")%>
									</td></tr>
									<%
									
							}
										 %>
										 </table>
							
							<!-- <tr>
							<td COLSPAN=2 align=CENTER ><font color=Green size=4 face='Verdana'>
							<b>Generate your  ADMIT CARD <A HREF="LATERALAdmitCard.jsp?name=<%=mAPPName%>" TARGET="NEW"
							> Cilck To Generate</A>
							</b>  
							</td>
							</tr>

							<TR>
							<TD align=left COLSPAN=2>
								<p><font color=RED size=4 face='Verdana'><BR>Instructions :
							<font color=BLACK size=4 face='Verdana'>
Please print the admit card. Affix your recent photograph & get it
certified by a person of Repute, For eg. Principal of Educational
Institution, Gazetted officer or carry a Photo-ID Proof like Driving
License or Passport.</p>
<P><font color=RED size=4 face='Verdana'>Note: </FONT>Carry adequate writing instruments.
Your Roll No. will be allotted on reporting at Examination Center.</p>
</FONT>
							
							</TD>
							</TR> -->

							</TABLE>
							<%
							}
							
							 if(mProg.equals("NRI"))
							{
								// out.print(rs1.getString("PERCENTAGEOF10TH"));

								if(rs1.getString("PERCENTAGEOF10TH").equals("0") || rs1.getString("PERCENTAGE").equals("0"))
								{
									%>
								<center>
								<font color=red size=2 face='Verdana'>
										<b>Your Application has been kept pending till 10+2 Results are Provided.
e-mail 10+2 Results to <a href="mailto: neeraj.sharma@jiit.ac.in "> neeraj.sharma@jiit.ac.in  </a>  before the last date of application and send photo copy of the results to the Institute by post.
</b></center>
									<%
								}
								%>

					
							
							<table align=center border=0    cellspacing=1 cellpadding=3>

					


							<tr>
							<td><font color=Black size=2 face='Verdana'>
							<b>% in best of 4(Eligible)* Subjects :</b>
							</td>
							<td>
							<%
								qry="SELECT SUBJECTID, SCORE, OUTOF FROM C#NRISCORE  where COUNSELLINGID='"+MCOUNSELLINGID+"' and  APPLICATIONSLNO='"+mAppSlno+"' ";
							rs=db.getRowset(qry);
							while(rs.next())
									{
									 mNriScore=rs.getDouble("SCORE");
									 mNriScoreOut=rs.getDouble("OUTOF");
										
									mSumNScore=mSumNScore+mNriScore;
									mSumNScoreOut=mSumNScoreOut+mNriScoreOut;
	
									//out.print(mSumNScore+"mSumNScore"+mSumNScoreOut);
									mNRIPerc=(mSumNScore*100)/mSumNScoreOut;
									
									}
									 %>
									 
									<font color=Black size=2 face='Verdana'>	<b> <%=mNRIPerc%>  </b><BR>
									
									
							</td>
							</tr>
							</table>
							<!-- <table align=center    cellspacing=1 cellpadding=3>
							<tr><td>
<font size=2 color=black face=verdana><b>In case ' * '  Only those subjects taken into account as authorized and
shown in the application form.<br>In case of any change ,Please contact  to neeraj.sharma@jiit.ac.in</b></font>
</td></tr>
<tr><td>
						 <font size=2 color=red face=verdana><b>Note:</b></font>
</td></tr>
<tr><td>
						 <font size=2 color=black face=verdana><b>
						 (i) Merit List shall be put up around 2nd week of June,2011
						 <br>  &nbsp; &nbsp;   &nbsp;Please view website regularly & do not send reminders.
						 <br>
						 (ii) Selected Candidates shall be informed through 
						 Email<br> &nbsp; &nbsp;   &nbsp; (Whose Email Id's Provided) and also through courier letters
						 </td></tr>
						 </table> -->
							<%
							}
							
							if(mProg.equals("MTECH"))
							{
							AppliedFor=rs1.getString("APPLICABLEFOR");
							

							qry="select nvl(GATESCORE,0)GATESCORE, nvl(marks,0)marks  from C#PGGATEEXAMDETAILS where COUNSELLINGID='"+MCOUNSELLINGID+"' and  APPLICATIONSLNO='"+mAppSlno+"'  ";
							rs=db.getRowset(qry);
							if(rs.next())
								{
									if(rs.getString("GATESCORE").equals("0") || rs.getString("marks").equals("0"))
									{
										%>
										<center>
										<font face=verdana color=red size=2> 
										Gate score card not attached or complet details not available for consideration for merit under GATE. Please Contact  <a href="mailto: neeraj.sharma@jiit.ac.in "> neeraj.sharma@jiit.ac.in  </a> 
										</font>
										</center>
										<%
									}
								}
								
								
								%>
							<table align=center cellspacing=0 border=1 bordercolor="#D98242" cellpadding=3> 
								
								
								<thead>
								<tr><td colspan=4 align=center><B>Priority of Chioce(s)</td></tr>
								<tr>
								<td><B> Institute
								</td>
								<td><B> Program Type
								</td>
								<td> <B>Program 
								</td>
								<td><B> Branch 
								</td>
								</tr>
								</thead>

								<%
							qry="select nvl(PROGRAMTYPE,' ')PROGRAMTYPE, nvl(PROGRAMCODE,' ')PROGRAMCODE, nvl(BRANCHCODE ,' ')BRANCHCODE,nvl(INSTITUTECODE,' ')INSTITUTECODE  from C#PGBRANCHPREFERENCE where COUNSELLINGID='"+MCOUNSELLINGID+"' and  APPLICATIONSLNO='"+mAppSlno+"' order by PREFERENCE  ";
							rs=db.getRowset(qry);
							while(rs.next())
								{
									%><tr>
									<td>
									<%=rs.getString("INSTITUTECODE")%>
									</td>
									<td>
									<%=rs.getString("PROGRAMTYPE")%>
									</td>
									<td>
									<%=rs.getString("PROGRAMCODE")%>
									</td>
									<td>
									<%=rs.getString("BRANCHCODE")%>
									</td></tr>
									<%
								}
							%>
							</table>
							<%

							/*qry="SELECT 'Y' FROM  STUDENTMASTER a,feetransaction b,c#pgapplicationmaster c WHERE a.INSTITUTECODE='JIIT' AND NVL(a.DEACTIVE,'N')='N' AND a.PROGRAMCODE='M.T' AND a.ACADEMICYEAR='1011' and  COUNSELLINGID='"+MCOUNSELLINGID+"' and  APPLICATIONSLNO='"+mAppSlno+"'  and a.tempenrollmentno=c.applicationslno and a.studentid=b.studentid ";
							//out.print(qry);
							rs=db.getRowset(qry);
							if(rs.next())
								{*/
									%>
									<!-- <tr>
							<td align=center ><font color=Green size=2 face='Verdana'>
							<b>Fees has been paid</b>  
							</td>
							</tr> -->
									<%
							//	}

							if (AppliedFor.equals("GATE"))
								{
							 %>
							<!-- <tr>
							<td><font color=Black size=2 face='Verdana'>
							<b>Gate Exam Qualified 
							</td>
							<td><font color=Black size=2 face='Verdana'>
							<b>:  </b>
							</td>
							</tr> -->
							<!-- <br>
							<tr>
							<td align=left ><font color=Green size=2 face='Verdana'>
							<P><b>1. Your candidature have been approved under <%=AppliedFor%> category.  </b>  </p>
							</td>
							</tr>
							<tr>
							<td align=left ><font color=Green size=2 face='Verdana'>
							<P><b>2. You have been selected for <%=mProg%> Program.</b>  </p>
							</td>
							</tr>
							<tr>
							<td align=left ><font color=green size=2 face='Verdana'><b></b> -->
							

							
							<%
							qry1="select distinct nvl(institutecode,' ')institutecode, nvl(PROGRAMTYPE,' ')PROGRAMTYPE,nvl(BRANCHCODE,' ')BRANCHCODE ,nvl(PROGRAMCODE,' ')PROGRAMCODE from C#PGBRANCHALLOTED where COUNSELLINGID='"+MCOUNSELLINGID+"' and  APPLICATIONSLNO='"+mAppSlno+"'   ";
						//	out.print(qry1+"asds");
							rs1=db.getRowset(qry1);
							if (rs1.next())
									{
									
									 %>
									 
									<b>&nbsp;  &nbsp;  (a) Institute :<%=rs1.getString("institutecode")%>
									<br>&nbsp;  &nbsp; (b) Branch  : <%=rs1.getString("BRANCHCODE")%> </b> 
									
									
									<%
									}
										 %>
						<!-- 	</td>						
									</tr>
							<tr>
							<td align=left ><font color=Green size=2 face='Verdana'>
							<P><b>		3. An admission offer letter has been sent to you  through  E-mail and Courier.</p>
							</b>  
							</td>
							</tr> -->
							<%
								}
								else if (AppliedFor.equals("PGET"))
								{
									%>
									<!-- <tr>
							<td align=CENTER ><font color=Green size=4 face='Verdana'>
							<b> You are entitled for <%=AppliedFor%>- 2011 .  </b>  
							</td>
							</tr> -->
							
							<!-- <tr>
							<td align=CENTER ><font color=Green size=4 face='Verdana'>
							<b>Generate your ADMIT CARD  <A HREF="PGETAdmitCard.jsp?name=<%=rs1.getString("name")%>" TARGET="NEW"
							> Cilck To Generate</A>
							</b>  
							</td>
							</tr>
					
							
							<TR>
							<TD align=left>
								<p><font color=RED size=4 face='Verdana'><BR>Instructions :
							<font color=BLACK size=4 face='Verdana'>
Please print the admit card. Affix your recent photograph & get it
certified by a person of Repute, For eg. Principal of Educational
Institution, Gazetted officer or carry a Photo-ID Proof like Driving
License or Passport.</p>
<P><font color=RED size=4 face='Verdana'>Note: </FONT>Carry adequate writing instruments.
Your Roll No. will be allotted on reporting at Examination Center.</p>
</FONT>
							
							</TD>
							</TR> -->


							
							

					
									<%
								}
								else if (AppliedFor.equals("N"))
								{
										%>
										<TR>
							<TD align=center>
								<p><BR>
								<font color=green size=4 face='Verdana'>
								Please Visit Same Link again after 15th may 2011
for further details on Admission/PGET</p>
								</FONT>
							</TD>
							</TR>
										<%
								}

							}
							
								 if(mProg.equals("PHD"))
							{
								// out.print(rs1.getString("PERCENTAGEOF10TH"));
								qry="select nvl(PERCENTAGEOFMARKS,0)PERCENTAGEOFMARKS  from C#PHDQUALIFICATIONDETAILS where COUNSELLINGID='"+MCOUNSELLINGID+"' and  APPLICATIONSLNO='"+mAppSlno+"' ";
								//out.print(qry);
								rs=db.getRowset(qry);
								if(rs.next())
								{
								if(rs.getString("PERCENTAGEOFMARKS").equals("0") )
								{
									%>
								<center>
								<font color=red size=2 face='Verdana'>
										<b>Your Application has been kept pending till 10+2 Results are Provided.
e-mail 10+2 Results to <a href="mailto: neeraj.sharma@jiit.ac.in "> neeraj.sharma@jiit.ac.in  </a> , 
										<a href="mailto: jyoti.jha@jiit.ac.in "> jyoti.jha@jiit.ac.in  </a>  before the last date of application and send photo copy of the results to the Institute by post.
</b></center>
									<%
								}
								}
								else
								{
										%>
								<center>
								<font color=red size=2 face='Verdana'>
										<b>Your Application has been kept pending till 10+2 Results are Provided.
e-mail 10+2 Results to <a href="mailto: neeraj.sharma@jiit.ac.in "> neeraj.sharma@jiit.ac.in  </a> ,
										<a href="mailto: jyoti.jha@jiit.ac.in "> jyoti.jha@jiit.ac.in  </a>  before the last date of application and send photo copy of the results to the Institute by post.
</b></center>
									<%
								}

								if(rs1.getString("ELIGIBLE").equals("N"))
								{
									%>
									<center nowrap><br><br>
									<font color=red size=2 face='Verdana'><b>
Your Application form has been rejected because you do not have full fill the Eligibilty Criteria , You can check the Eligibility Criteria <a href="http://www.jiit.ac.in/uploads/PhD%20Test%20%20procedure-Web-16-02-11.pdf">
Click Here
</a>
or email to <a href="mailto: jyoti.jha@jiit.ac.in "> jyoti.jha@jiit.ac.in  </a>
</b>
									</center>
									<%
								}
								else
								{
								%>

								<Table align=center>
								<tr><td align=center><font color=green size=2 face='Verdana'><b>
								Choice of institute--<%=rs1.getString("CHOICEOFINSTITUTE")%> &nbsp; <%=rs1.getString("CHOICEOFINSTITUTE2")%> &nbsp; <%=rs1.getString("CHOICEOFINSTITUTE3")%>  
								</td>
								</tr>
								<tr><td align=center><font color=green size=2 face='Verdana'><b>
								Choice of program--<%=rs1.getString("CHOICEOFPROGRAM")%>  
								</td></tr>
								<tr><td align=center><br>
								<%
									if(rs1.getString("NATIONALLEVELEXAMPASSED").equals("OTHERS") ||
									rs1.getString("NATIONALLEVELEXAMPASSED").equals("OTHER"))
								{
									%>
											<font color=green size=2 face='Verdana'><b>
											Please Visit Same Link again after 6th June 2011
											for further details on Exam/Admitcard
											</b>
											</font>

									<%
								}
								else
								{
										%>
											<font color=green size=2 face='Verdana'><b>
											Exam exempted because you are qualified in <%=rs1.getString("NATIONALLEVELEXAMPASSED")%> <br>Please Visit Same Link again after 6th June 2011
												for further details on Interview
											</b>
											</font>

									<%
								}
									%>
								</td></tr>
							</table>	
				
							<% 	}
								//CHOICEOFPROGRAM, NATIONALLEVELEXAMPASSED, CHOICEOFINSTITUTE2, CHOICEOFINSTITUTE3, ELIGIBLE

							}

							 %>
							</table>
							<%
				
				}
		else
		{
			 if(mProg.equals("PHD"))
			{
			%>
			<center>
			<font color=red size=4 face='Verdana'>
			<br><br><hR>
	Please enter correct Date of Birth as filled in the application form or your correct Application No.
		<br>
		 OR <br>
No record exists of this Application No. / Date of Birth.<br> Please check details of delivery from postal/courrier authorities.<hr>
</font><center>
<%
			}
			else
			{
				%>
			<center>
			<font color=red size=4 face='Verdana'>
			<br><br><hR>
	Please enter correct 10+2 Roll No. as filled in the application form or your correct Application No.
		<br>
		 OR <br>
No record exists of this Application No. / Roll No.<br> Please check details of delivery from postal/courrier authorities.<hr>
</font><center>
<%

			}
	
  	     
	}// Closing of LET/NRI/MTECH Course Qry
	}

// Opening of Application Form Online status
else
	{
	String mOp="";
	if ( !mValue.equals("")  )
//	if((mValue.substring(0,1).equals("C") || mValue.substring(0,1).equals("D") || mValue.substring(0,1).equals("I") || mValue.substring(0,1).equals("T") ) || (mValue.length()==8 &&  mValue.substring(0,1).equals("2") ) )
	{
		//	out.print(mValue+"sdfsfsfsf");

//  mAppStatus = db.GetAppID(mQryType, mValue);


 qryStatus="Select  nvl(COUNSELLING.GetApplicationStatus('"+MCOUNSELLINGID+"','" + mQryType  + "','" + mValue  + "'),'*')STATUS FROM DUAL ";
 //out.print(qryStatus+"dfsdf");
 rsStatus=db.getRowset(qryStatus);

  if(rsStatus.next())
	mAppStatus=rsStatus.getString("STATUS");

if(mAppStatus.equals("*"))
	mAppStatus=" ";
else
	mAppStatus="<left><font Color=red size=2 face=verdana> <b>Following Data not Found or Incorrectly Submited/Filled </b></left><p align=left><b>"+mAppStatus+"</b></font>";


//out.print(mAppStatus+"asdasd");

	  qry = "Select nvl(FIRSTNAME,' ')||' '|| nvl(MIDDLENAME,' ')||' '||nvl(LASTNAME,' ') Name,nvl(APPLICATIONNO,'N')APPLICATIONNO  ,nvl(CATEGORYCODE,'Not filled in the Application Form') CATEGORYCODE,to_char(nvl(DATEOFBIRTH,sysdate),'dd-Mon-yyyy') DATEOFBIRTH, to_char(SYSDATE,'dd-Mon-yyyy') CURDATE , ApplicationID,NVL(QUALIFIEDEXAMFROMHP,'N')QUALIFIEDEXAMFROMHP, NVL(OTHERCATEGORY,'N')OTHERCATEGORY,nvl(PHOTOGRAPHFILENAME,'N')PHOTOGRAPHFILENAME,NVL(FORMRECVD,'N')FORMRECVD  From C#APPLICATIONMASTER a where (APPLICATIONNO='" + mValue  + "' OR APPLICATIONID in (select APPLICATIONID from C#APPLICATIONMASTERDETAIL b where ROLLNOOFAIEEE='" +  mValue + "' and COUNSELLINGID='"+MCOUNSELLINGID+"' and ( (substr(a.APPLICATIONNO,1,1) in ('C','D') and NVL (onlineconfirmation, 'N') = 'Y')  or substr(a.APPLICATIONNO,1,1) not in ('C','D')              ))) and COUNSELLINGID='"+MCOUNSELLINGID+"'  ";	
	  	  StudentRecordSet = db.getRowset(qry); 	
	// out.print(qry);  

	  if (StudentRecordSet.next())
		{
		  
		  //out.print(StudentRecordSet.getString("ApplicationNo")+"sfssdfsdfsdf");
		
	if(!StudentRecordSet.getString("ApplicationNo").equals("TEMP") && !StudentRecordSet.getString("ApplicationNo").equals("N")) 
	{
		//if(StudentRecordSet.getString("ApplicationNo").substring(0,1).equals("D") || StudentRecordSet.getString("ApplicationNo").substring(0,1).equals("I") || StudentRecordSet.getString("ApplicationNo").substring(0,1).equals("C")) 
  		// {
			
   			mApplicationID=StudentRecordSet.getString("ApplicationID");
	       qry="Select APPLIEDINSTITUTECODE, nvl(ROLLNOOFAIEEE,'UNK') ROLLNOOFAIEEE, NVL(WRONGAIEEEROLL,'N') WRONGAIEEEROLL, nvl(REJECTED,'N') REJECTED, nvl(Remark,' ') Remarks,nvl(ONLINECONFIRMATION,'N') ONLINECONFIRMATION   from C#APPLICATIONMASTERDETAIL where COUNSELLINGID='"+MCOUNSELLINGID+"' and APPLICATIONID='"+mApplicationID+"'";
		// out.print(qry);
		 StudentInst=db.getRowset(qry);      
		 while(StudentInst.next())
		     {
				if(StudentInst.getString("APPLIEDINSTITUTECODE").equals("JIIT"))
					mInst1=1;
				else if(StudentInst.getString("APPLIEDINSTITUTECODE").equals("JUIT"))
					mInst2=2;
				else if(StudentInst.getString("APPLIEDINSTITUTECODE").equals("JIET"))
					mInst3=3;
			 }
			
	     mApply=mInst2+mInst1+mInst3;
		
  if(mApply > 0)  //No Institutes Found....
   {

				
			qry="Select APPLIEDINSTITUTECODE, nvl(ROLLNOOFAIEEE,'UNK') ROLLNOOFAIEEE, NVL(WRONGAIEEEROLL,'N') WRONGAIEEEROLL, nvl(REJECTED,'N') REJECTED, nvl(Remark,' ') Remarks,nvl(ONLINECONFIRMATION,'N') ONLINECONFIRMATION   from C#APPLICATIONMASTERDETAIL where COUNSELLINGID='"+MCOUNSELLINGID+"' and APPLICATIONID='"+mApplicationID+"'";
			//out.print(qry);
			StudentInst=db.getRowset(qry);      
			StudentInst.next();
				//out.print(StudentRecordSet.getString("DATEOFBIRTH")+"assa");
				//if(!StudentRecordSet.getString("DATEOFBIRTH").equals(StudentRecordSet.getString("CURDATE")))  
		// {	   
	//	out.print("sdfsdf");			
			
				mName = StudentRecordSet.getString("Name");      
				mAppl=StudentRecordSet.getString("APPLICATIONNO");     
			
				mCat=StudentRecordSet.getString("CATEGORYCODE").toString().trim();	
				mQualExam=StudentRecordSet.getString("QUALIFIEDEXAMFROMHP");
				mOtherCat=StudentRecordSet.getString("OTHERCATEGORY");
				mPhoto=StudentRecordSet.getString("PHOTOGRAPHFILENAME");
				mFormRecvd=StudentRecordSet.getString("FORMRECVD");
				
				mWRONGAIEEEROLL=StudentInst.getString("WRONGAIEEEROLL");
				mAIEE = StudentInst.getString("ROLLNOOFAIEEE");      
				mRejected=StudentInst.getString("REJECTED");
				mRemarks=StudentInst.getString("REMARKS");
				mConfirm=StudentInst.getString("ONLINECONFIRMATION");
				

				mWrongDD="N";
		
				

		if(mAIEE.length()!=8 || !mAIEE.substring(0,1).equals("2") || mAIEE.equals("UNK"))
			mAIEE="<font color=red size=2 face=verdana>"+mAIEE+" (Invalid AIEEE Roll Number)</font>";
		else
			mAIEE=mAIEE;

	

		if(mQualExam.equals("Y") && mOtherCat.equals("HP"))
			{
				if(!mCat.substring(0,1).equals("N"))
					mCat="<font size=2 face=verdana > "+mCat+"  &nbsp; <br>  Quota :   "+mOtherCat+" </font>";
				else
					mCat="<font size=2 face=verdana color=red> "+mCat+" </font> &nbsp; <br> <font size=2 face=verdana > Quota :   "+mOtherCat+" </font>";


			}
		else if (mCat.substring(0,1).equals("N"))
			{
			mCat="<font size=2 face=verdana color=red > "+mCat+"  </font>";
			}
		else
			{
			mCat=mCat;
			}

		

		if((!mAppl.substring(0,1).equals("D")  || !mAppl.substring(0,1).equals("C")) && mPhoto.equals("N"))
			mPhoto="<font color=red size=2 face=verdana>Photo is Missing</font>";
		else
			mPhoto=" ";

			if(mAppl.substring(0,1).equals("C") && mFormRecvd.equals("N") )
				mFRecevied="<font face=verdana size=2 color=red><b>Hard Copy of the Application Form not yet  received</b></font>";
			else
				mFRecevied="<font face=verdana size=2 color=green><b>Hard Copy of the Application Form received</b></font>";


		if(mRejected.equals("N"))
	    {
		//	if(mAIEE.length()==8 &&  mAIEE.substring(0,1).equals("2"))
			//{	
				//IF APPLICATION NO STARTS WITH 'D' DEMAND DRAFT
				if(mAppl.substring(0,1).equals("D")  )
				{ 
			 	qry ="Select nvl(WRONGDD,'N')WRONGDD From C#APPLICATIONDDMASTER Where  nvl(WRONGDD,'N') ='Y' and APPLICATIONID='" + mApplicationID+ "' and COUNSELLINGID='"+MCOUNSELLINGID+"' and Nvl(DDRECCEIVED,'N')='Y'";	
				//out.print(qry);
			 	RSS = db.getRowset(qry); 	  					
				if (RSS.next())
				{
				mWrongDD=RSS.getString(1);
				}
				

				//Your DD has been received but it is Incorrect/Invalid

				qry ="Select nvl(sum(nvl(AMOUNT,0)),0) amt From C#APPLICATIONDDMASTER Where APPLICATIONID='" + mApplicationID+ "' and COUNSELLINGID='"+MCOUNSELLINGID+"' and Nvl(DDRECCEIVED,'N')='Y' and nvl(WRONGDD,'N')='N'";		  				
			 	RSS = db.getRowset(qry); 	  					
			
				if(mWrongDD.equals("N"))  //Your DD has been received but it is Incorrect/Invalid

				   {
					 //out.print("fsdf");


					//out.print(qry);
				    if ( mAppl.substring(0,1).equals("D"))
						{
						 	qry ="Select nvl(sum(nvl(AMOUNT,0)),0) amt From C#APPLICATIONDDMASTER Where APPLICATIONID='" + mApplicationID+ "' and COUNSELLINGID='"+MCOUNSELLINGID+"' and Nvl(DDRECCEIVED,'N')='Y' and nvl(WRONGDD,'N')='N'";		  				
						 	RSS = db.getRowset(qry); 	  								
						 	if (RSS.next() && RSS.getDouble(1)>=800)		    		
						     	mOp="Y";		   
						  	else
								mOp="N";	
							


						 }

					else
						{
					     	mOp="R";		   
						}	
						%>
						<br><br><br><hr>
						<% 
					if(mRejected.equals("N"))
					  {	 
							

							if(mOp.equals("R"))
							    {
									%>
									<font color=green size=6><b>Your Application Form has been received.</b></font>
									<br>
									<%
								}
							else if(mOp.equals("Y"))
								{
								%>
								<font color=Green size=6><b>Your DD has been received and Application has been registered... </b></font>
								<%
								}
							else if(mOp.equals("N"))
								{
								%>
								<font color=Red size=6><b>Your DD for the amount of Rs. 800/- has not been received <br> and hence your application is still kept as pending</b></font>
								<%
								}
								%>
							<hr>
							<table align=center width='60%'>
							<tr><td><br><br>
							<font color=Black size=2 face='Verdana'>
							<b>Applicant Name : <%=mName%> </b><br>
							<b>AIEEE Roll Number: <%=mAIEE%></b><br>
							<b><br>Application Number: <%=mAppl%></b><br>
							<b>Category : <%=mCat%></b></font>
							<br><br>
							<table border=1><tr><td align=center>
							<font color=darkbrown FACE='VERDANA' size=2><b>You have Applied for following Institute(s)<br></b></font><font color=GREEN FACE='VERDANA' size=4>
							
							<%	
							if (mInst1==1)
							{
							%>
							  JIIT 		&nbsp;&nbsp;					<%
							}
							if (mInst2==2)
							{
							%>
							  JUIT &nbsp;&nbsp;
							<%
							}
							if (mInst3==3)
							{
							%>
							 JIET&nbsp;&nbsp;
							<%
							}
							%></FONT></td></tr></table>
							</td></tr>
						<tr><td><%=mAppStatus%></td></tr>

						<tr><td><br><font face=verdana><b>In case of any variation in Application Number/AIEEE Roll Number or spelling mistake please inform the admission cell through email at <a href="mailto:<%=mailID%>"><%=mailID%></a></b> .</font><br><br>
						</td></tr>
						<%
						}//if(mRejected.equals("N"))
					
					}//mWrongDD.equals("N"))  //Your DD has been received but it is Incorrect/Invalid
					else
					{
							 
							%>
							<br><br>
							<font color=Black size=2 face='Verdana'>	
							<font color=Red size=6><b>Your DD has been received but it is Incorrect/Invalid and being returned...</b></font>
							<hr><table align=center width='60%'>
							<tr><td><%=mAppStatus%></td></tr><br><br>							 
							</table>
							<br><font size=2 color=red><b>The reason for the rejection of Demand Draft have been<BR> intimated in the letter sent to you by post.Please resolve, before last date of submission of application.<!-- <a href="mailto:registrar@jiit.ac.in">registrar@jiit.ac.in -->
								</font></b>			
							
						<%  	

					}
				}
				// Online TRransaction form Accepted
				else if(mAppl.substring(0,1).equals("C") )
				{
							
					qry="select  nvl(a.APPLICATIONID,' ')APPLICATIONID,nvl(c.TRANSACTIONSTATUS,'N')TRANSACTIONSTATUS   from C#APPLICATIONMASTER a,C#ONLINEAPPLICATIONDETAIL b ,C#TRANSACTIONMASTER c  where a.APPLICATIONID='" + mApplicationID+ "' and a.COUNSELLINGID='"+MCOUNSELLINGID+"'  and a.COUNSELLINGID=b.COUNSELLINGID and a.APPLICATIONID=b.APPLICATIONID and a.COUNSELLINGID=c.COUNSELLINGID and a.APPLICATIONID=c.APPLICATIONID and b.APPLICATIONID=c.APPLICATIONID and nvl(c.TRANSACTIONSTATUS,'N')='A' ";
					//and nvl(c.TRANSACTIONSTATUS,'N')='A' and  nvl(a.APPLICATIONNO,'N')<>'TEMP' ";
					//out.print(qry);
					rs=db.getRowset(qry);
					if(rs.next())
					{
						
						if(mRejected.equals("N"))
					   {
						
						if(rs.getString("TRANSACTIONSTATUS").equals("A"))
						{
							%>
							<BR>
							<font color=green size=6><b>Your Application has been registered Successfully...</b></font>
							<%
						}
						else
						{
							%>
							<BR>
							<font color=red size=6><b>Your Application has not been registered...</b></font>
							<%
						}
							%><BR><BR>
							<b><%=mFRecevied%></b>

						<hr>
							<table align=center width='60%'>
							<tr><td><br><br>
							<font color=Black size=2 face='Verdana'>
							<b>Applicant Name : <%=mName%> </b><br>
							<b>AIEEE Roll Number: <%=mAIEE%></b><br>
							<b><br>Application Number: <%=mAppl%></b><br>
							<b>Category : <%=mCat%></b><br>
							
							<br><br>
							<table border=1><tr><td align=center>
							<font color=darkbrown FACE='VERDANA' size=2><b>You have Applied for following Institute(s)<br></b></font><font color=GREEN FACE='VERDANA' size=4>
						
							<%	
							if (mInst1==1)
							{
							%>
							  JIIT &nbsp;&nbsp; 
							<%
							}
							if (mInst2==2)
							{
							%>
							  JUIT &nbsp;&nbsp;
							<%
							}
							if (mInst3==3)
							{
							%>
							 JIET &nbsp;
							<%
							}
							%></FONT></td></tr></table>
							</td></tr>
							<tr><td><%=mAppStatus%></td></tr>
						<tr><td><br><font face=verdana><b>In case of any variation in Application Number/AIEEE Roll Number or spelling mistake please inform the admission cell through email at   <a href="mailto:<%=mailID%>"><%=mailID%></a></b> .</font><br><br>
						</td></tr>
<%
					   }
					}
					else
					{
						%>
						<BR>
							<font color=red size=6><b>Your Transaction of Rs. 800/-  not done Successfully..</b></font>
						<%
					}

				}
				//IF APPLICATIONNO IS NUMERIC 
			else if(!mAppl.substring(0,1).equals("D") || !mAppl.substring(0,1).equals("C") || mAppl.length() >0 )
				  {
						  
					
					%>
							<font color=green size=6><b>Your Application Form has been received.</b></font>
							<br>
							<hr>
							<table align=center width='60%'>
							<tr><td ><br><br>
							<font color=Black size=2 face='Verdana'>
							<b>Applicant Name : <%=mName%> </b><br>
							<b>AIEEE Roll Number: <%=mAIEE%></b><br>
							<b><br>Application Number: <%=mAppl%></b><br>
							<b>Category : <%=mCat%></b></font><br>
							<b><%=mPhoto%><b/>
							<br><br>
							<table border=1><tr><td align=center>
							<font color=darkbrown FACE='VERDANA' size=2><b>You have Applied for following Institute(s)<br></b></font><font color=GREEN FACE='VERDANA' size=4>
						
							<%	
								//out.print(mInst1+"adasd"+mInst2+"sdsd"+mInst3);
							if (mInst1==1)
							{
							%>
							  JIIT 		&nbsp;&nbsp;					<%
							}
							if (mInst2==2)
							{
							%>
							  JUIT &nbsp;&nbsp;
							<%
							}
							if (mInst3==3)
							{
							%>
							 JIET &nbsp;&nbsp;
							<%
							}
							%></FONT></td></tr></table>
							</td></tr>
						<tr><td><%=mAppStatus%></td></tr>

						<tr><td><br><font face=verdana><b>In case of any variation in Application Number/AIEEE Roll Number or spelling mistake please inform the admission cell through email at <a href="mailto:<%=mailID%>"><%=mailID%></a></b> .</font><br><br>
						</td></tr>
					<%

				  }

			 

		}	
		else if(mRejected.equals("Y"))
		{
						%>
							<font color=Red size=6><b>Your Application has been Rejected...</b></font>
							<hr><table align=center width='60%'>
							<tr><td>
							<font color=Black size=2 face='Verdana'>
							<b>Applicant Name : <%=mName%> </b><br>
							<b>AIEEE Roll Number: <%=mAIEE%></b><br>
							<b>Application Number: <%=mAppl%></b><br>
							<b>Category : <%=mCat%></b></font><BR><br>
							</td></tr>							
							<tr><td><table border=1><tr><td align=center>							<br>
							<font color=darkbrown size=2 FACE='VERDANA'><b>You have Applied for following Institute(s)<br></b></font><font color=GREEN FACE='VERDANA' size=4>
							
							<%	
							if (mInst1==1)
							{
							%>
							  JIIT&nbsp;&nbsp;
							<%
							}
							if (mInst2==2)
							{
							%>
							  JUIT &nbsp;&nbsp;
							<%
							}
							if (mInst3==3)
							{
							%>
							 JIET &nbsp;
							<%
							}
							%></FONT></td></tr>
							
							
							</table>
							</td></tr>
							<tr><td><%=mAppStatus%></td></tr>
							
							<tr><td class="tablecell"><b><u>Remarks:</u></b>

							<%=mRemarks%>
							<br><br><font face=verdana><b>In case of any variation in Application Number/AIEEE Roll Number or spelling mistake please inform the admission cell through email at  <a href="mailto:<%=mailID%>"><%=mailID%></a></b></font> .
							</td></tr>
						<%
			}
					

		
						%>	
				</table>
				<hr>
				</h1>
				<%
			}//	     if APPLIED INSTITUTE ==0 No Institutes Found....
			else
			{
			
							mName = StudentRecordSet.getString("Name");
						      
							mAppl=StudentRecordSet.getString("APPLICATIONNO");            
							mCat=StudentRecordSet.getString("CATEGORYCODE");
							
								%>
							<br><br>
							<font color=Black size=2 face='Verdana'>	
							<font color=Red size=5><b>Your Application has been Rejected.</b></font>
							<bR><h1><font color=red size=5><br>Preference for Institutes has not been given.</font></h1>
							<hr><table align=center width='60%'>
							<tr><td><br><br>
							<font color=Black size=2 face='Verdana'>
							<b>Applicant Name : <%=mName%> </b><br>
							<b>AIEEE Roll Number: <%=mAIEE%></b><br>
							<b>Application Number: <%=mAppl%></b><br>
							<b>Category : <%=mCat%></b></font><BR>
							</td></tr>

							
							
							<tr><td><b><u>Remarks:</u></b><br>
							<%=mRemarks%>
							</td></tr>
							<tr><td><%=mAppStatus%></td></tr>
							</table>
							<br><font size=2 color=red><b>Please get your Application accepted by sending the data for which your<br>
								application has been rejected to the email id <a href="mailto:<%=mailID%>"><%=mailID%>
								</font></b>			
							<%

			}
	//}//(StudentRecordSet.getString("ApplicationNo").equals("TEMP"))
	//	else
	//	{
				%>	<!-- <br><br><hr>
					<center>
					<h1><font color=red size=6>
					Incomplete Application ! <br>You have not submitted Application with DD details or through Credit Card .
					</font></h1>
					<br>
					<font color=Black size=2 face='Verdana'></font>
					<hr>
					<br> -->
					<%

		//}

		}//(StudentRecordSet.getString("ApplicationNo").equals("TEMP"))
		else
		{
			%>	<br><br><hr>
					<center>
					<h1><font color=red size=4>
					PLEASE RECHECK YOUR APPLICATION NUMBER
					<br>>OR
					APPLICATION NOT YET RECEIVED
					<br>OR
					APPLICATION MAY BE UNDER PROCESS CHECK AFTER FEW DAYS

					</font></h1>
					<br>
					<font color=Black size=2 face='Verdana'></font>
					<hr>
					<br>
					<%
		}

	   }
	   //IF DATA DOES NOT EXISTS IN MASTER AND MASTERDETAIL TABLE 
		else //	  if (StudentRecordSet.next())
		{
			

				 if(request.getParameter("QryType").toString().equals("A"))
					{
				%>
					<br><br><hr>
					<center>
					<h1><font color=red size=4>
					PLEASE RECHECK YOUR APPLICATION NUMBER
					<br>OR<BR>
					APPLICATION NOT YET RECEIVED
					<br>OR<BR>
					APPLICATION MAY BE UNDER PROCESS CHECK AFTER FEW DAYS
					</font></h1>
					<br>
					<font color=Black size=2 face='Verdana'></font>
					<hr>
					<br>
					<%
					}
				else
				{
				%>
					<br><br><br><hr>
					<center>
					<h1><font color=red size=4>
					PLEASE RECHECK YOUR AIEEE ROLL NUMBER
					<br>OR<BR>
					 APPLICATION NOT YET RECEIVED
					<br>OR</BR>
					 APPLICATION MAY BE UNDER PROCESS CHECK AFTER FEW DAYS
					</font></h1>
					<br>
					<font color=Black size=2 face='Verdana'></font>
					<hr>
					<br>
					<%

				}


	
				
		}

}//if (request.getParameter("txtValue")!=null && !mValue.equals(""))
else
{
	%>
	<br><br><br><hr>
	<center>
	<h1><font color=red size=6><br>Please enter Correct Application Number/AIEEE Roll Number.</font></h1>
	<hr>
	<br>
	<!-- <font face=verdana size=2><b>In case of any variation in Application Number/AIEEE Roll Number or spelling mistake <br>please inform the admission cell through email at  <a href="mailto:registrar@jiit.ac.in">registrar@jiit.ac.in</a></b></font> .
	 --><%

}
}//mQryType.equals("D")
}//clsing of try
catch(Exception e)
{
//out.print(e+"Error");
}
%>
 <center>
 <BR><BR>
	<A href="AppicationQueryJIIT.jsp"><font face=verdana size=5 ><b>Go Back </b></b></A>
	</center>
<br><br>

<br><br>
<TABLE WIDTH=100%><TR><td VALIGN=BOTTOM>
<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../Images/CampusConnectLogo.bmp"> <FONT style="FONT-FAMILY: cursive" 
size=4><B>Campus Lynx</B></FONT>   <FONT style="FONT-FAMILY: cursive" 
size=2>... an <B>IRP</B> Solution</FONT><BR>A product of <STRONG>JIL Information 
Technology Ltd.</STRONG></FONT><BR><FONT size=2>For your comments or suggestions 
please send an email at <A tabIndex=8 href="mailto:jiiterp@jiit.ac.in">jiiterp@jiit.ac.in</A></FONT> 
</td></tr></table></td></tr></table></</CENTER>

  </body>
</html>
