<%@ page  language="java" import="java.sql.*,tietwebkiosk.*,java.util.*" %>
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
<TITLE>#### <%=mHead%> [ Grade Calculation Action ] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />


<script language=javascript>
function Validate(st,lt)
{
	//alert('statr'+st+"lt"+lt);
	var flag=0;
	for(var i=st;i<lt;i++ )
		{
			if(document.getElementById("grade"+i).value!=" ")
			{
				flag=1;
				//alert('Please Select Grades');
				//return false;
			}
		}
	if(flag==0)
	{
				alert('Please Select Grades!');
				return false;
		
	}
	//return false;
}

function ValidateMassCut(MassCut,rn,TotalMarks,NetMarks)
{
//alert(TotalMarks+'Please Select Grades'+MassCut);

var MarksEntered=document.getElementById("MassCuts"+rn).value;

//alert(MarksEntered+"dsd");
if(MarksEntered<0 || MarksEntered>20)
	{
		alert("Please Enter Mass Cut Marks Greater than  "+MassCut+" ");
		document.getElementById("MassCuts"+rn).value=MassCut;

		return false;	
	}
if(MarksEntered==0 || MarksEntered==" ")
	{
document.getElementById("MassCuts"+rn).value=0;
	}

var MarksAllow=TotalMarks-MarksEntered;
var TotalMasscut=NetMarks-MarksEntered;

document.getElementById("NetMarks"+rn).value=TotalMasscut;
document.getElementById("FinalMarks"+rn).value=MarksAllow;

}
</script>
<script language=javascript>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body aLink="#ff00ff" bgcolor="#fce9c5" leftmargin=0 topmargin=0>
<%
try
{
	GlobalFunctions gb =new GlobalFunctions();
	OLTEncryption enc=new OLTEncryption();
	DBHandler db=new DBHandler();
	ResultSet rssub=null,rs3=null,rsz=null,rss=null,rsBatchDate=null;
	String mMemberID="",mMemberType="",mMemberName="",mMemberCode="",mInst="",mComp="",mDMemberCode="",mCheckFstid="";
	int mCheck=0,mSNO=0,mCount1=0,mCount2=0;
	String qrysub="",mNam="",mDMemberType="",qry="",mExamCode="",mSubjectCode="",mNoStudent="";
	String mETOD="",mSem1="",aa="",qry3=null;
	String mSubjectID="",mExamCode1="",mSubcode="",mFSTID="",mFSTID1="";
	String mNext="",mPrev="",mColor="",qryz="",qrys="";
	ArrayList subevents=new ArrayList();
	double mSumMark=0.0,mTATotalMarks=0,mNetMarks=0;		
	int start=0,last=0,count=0;
	int NoStud=0;
	int mYesNo=0,fs=0;
	int mTotalMarks=0,mAttFrom=0,mAttTo=0,mSem=0;
	String qryTCount="",qryPCount="",MassCutCheck="N";
	ResultSet  rsTCount=null,rsPCount=null;
	long QryTotCls=0,QryTotPrs=0,QryPercAtt=0;
	double mMassCut1=0,mIntialMarks1=0,mMassCutMarks=0,mFinalMarks1=0,mFinalMarks11=0;



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

	if (session.getAttribute("InstituteCode")==null)
	{
		mInst="";
	}
	else
	{
		mInst=session.getAttribute("InstituteCode").toString().trim();
	}

	if (session.getAttribute("CompanyCode")==null)
	{
		mComp="";
	}
	else
	{
		mComp=session.getAttribute("CompanyCode").toString().trim();
	}

			
			if(request.getParameter("Subject")==null)
				mSubjectCode="";
			else
				mSubjectCode=request.getParameter("Subject").toString().trim();

			if(request.getParameter("checkctr")==null)
				mCheck=0;
			else
				mCheck=Integer.parseInt(request.getParameter("checkctr").trim());

			if(request.getParameter("ExamCode")==null)
				mExamCode="";
			else
				mExamCode=request.getParameter("ExamCode").toString().trim();		

			if(request.getParameter("NoStudent")==null)
				mNoStudent="";
			else
				mNoStudent=request.getParameter("NoStudent");

			if(request.getParameter("mCheckFstid")==null)
				mCheckFstid="";
			else
				mCheckFstid=request.getParameter("mCheckFstid").toString().trim();	

			if(request.getParameter("FS")==null)
				fs=0;
			else
				fs=Integer.parseInt(request.getParameter("FS").trim());
			

			if(request.getParameter("FSTID")==null)
				mFSTID="";
			else
				mFSTID=request.getParameter("FSTID").toString().trim();

							

	
mNext=request.getParameter("Next");
mPrev=request.getParameter("Previous");
			
//out.print("sdfsf"+mNext+"dfsf"+mPrev);



	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
	{
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);
		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mCode=enc.decode(mMemberCode);
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
			
		
			qrysub="select subject,subjectcode from subjectmaster where subjectID='"+mSubjectCode+"' and nvl(deactive,'N')='N' and INSTITUTECODE='"+mInst+"'";

			rssub=db.getRowset(qrysub);
			if(rssub.next())
			{
				mNam=rssub.getString("subject");
				mSubcode=rssub.getString("subjectcode");
			}
			else
			{
				mNam="";
				mSubcode="";
			}
			String name="",time="";
			String query123="select employeename,to_char(sysdate,'DD/MM/YYYY HH:MI:SS AM')dd from employeemaster where employeeid='"+mChkMemID+"'";

			rssub=db.getRowset(query123);
			if(rssub.next())
			{
				name=rssub.getString("employeename");
				time=rssub.getString("dd");
			}
			
			
			%>
			<form name="frm"  method="post"  > 

			<%
					//out.print(mCheckFstid+"fsdfmmzmcm+"+mNext);	
			if(mNext==null || mPrev==null)
			{
			for(int yy=1;yy<=mCheck;yy++)
			{				

				if(!(request.getParameter("FSTID"+yy)==null ) && (mCheckFstid!=null ) )
				{


					fs++;
					%>
					<INPUT TYPE="hidden" NAME="FSTID<%=yy%>" value="<%=request.getParameter("FSTID"+yy).toString().trim()%>">
					<%
					
					//out.print(request.getParameter("FSTID"+yy));
					if(mCheckFstid.equals("") || mCheckFstid==null )
				     	mCheckFstid="'"+request.getParameter("FSTID"+yy)+"'";					
					else
						mCheckFstid=mCheckFstid+", '"+request.getParameter("FSTID"+yy).toString().trim()+"' ";
				}

			}
				
				
			}	
				
				
				//out.print("12312"+mCheckFstid+"zxczczxc");
				%>

			<input id="x" name="x" type=hidden>
			<input id="checkctr" name="checkctr" type=hidden value=<%=mCheck%>>
			
			<table  width="100%" ALIGN=CENTER bottommargin=0  topmargin=0 cellspacing=0 cellpadding=0>
				<tr>
					<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: Verdana"><u><b>JPBS Grade Entry</b></u></font>
					</td>
				</tr>
			</TABLE> 
			<table align=center   width="100%" ALIGN=CENTER bottommargin=0  topmargin=0 cellspacing=0 cellpadding=0>
				<tr>
					<td>
						<Font face=arial size=2 color=navy><b>Co-Ordinator Name: </b></FONT><font face=verdana size=2 color=black><b><%=name%>&nbsp;(<%=mCode%>)</font></b>
					</td>
					<td colspan=3>
						<Font face=arial size=2 color=navy><b>Date & Time : </b></FONT><font face=verdana size=2 color=black><b><%=time%></font></b>
					</td>
				</tr>
				<tr>
					<td>
						<Font face=arial size=2 color=navy><b>Subject : </b></FONT>
						<font face=verdana size=2 color=black><b><%=mNam%>(<%=mSubcode%>)</font></b>
					</td>
					<td>
						<Font face=arial size=2 color=navy><b>ExamCode : </b></FONT>
						<font face=verdana size=2 color=black><b><%=mExamCode%></font></b>
					</td>
					</tr>
				<%
				if(request.getParameter("x")!=null)
				{
					if(request.getParameter("NoStudent")==null)
						mNoStudent="20";
					else
						mNoStudent=request.getParameter("NoStudent").toString().trim();
				}
				else
				{
					mNoStudent="20";
				}
					
				%>
				<tr>
				<td><Font face=arial size=2 color=navy><b>No. of students :</b></font>
				<input  type="text" name="NoStudent" size="3" maxlength="4"  value=<%=mNoStudent%>>&nbsp;&nbsp;  
				<font size=2 color=dark brownt face=verdana><b>Enter the No. of Students for Grade Entry   </b></td>
				</tr>
				<INPUT TYPE="hidden" NAME="Subject" ID="Subject" VALUE="<%=mSubjectCode%>">
				<INPUT TYPE="hidden" NAME="ExamCode" ID="ExamCode" VALUE="<%=mExamCode%>"> 
				<INPUT TYPE="hidden" NAME="mCheckFstid" ID="mCheckFstid" VALUE="<%=mCheckFstid%>"> 
				<INPUT TYPE="hidden" NAME="FS" ID="FS" VALUE="<%=fs%>"> 
				<tr><td align =center colspan=3> <INPUT TYPE="submit" value="View" > </td></tr>
				</table>
				</form>
			<%
//mCheckFstid is hidden 

			if(request.getParameter("x")!=null)
			{

			if(request.getParameter("FS")==null)
				fs=0;
			else
				fs=Integer.parseInt(request.getParameter("FS"));

			if(request.getParameter("SEMESTER")==null)
				mSem1="";
			else
				mSem1=request.getParameter("SEMESTER").toString().trim();
			if(request.getParameter("Subject")==null)
				mSubjectID="";
			else
				mSubjectID=request.getParameter("Subject").toString().trim();

			if(request.getParameter("ExamCode")==null)
				mExamCode1="";
			else
				mExamCode1=request.getParameter("ExamCode").toString().trim();

			if(request.getParameter("NoStudent")==null)
				mNoStudent="";
			else
				mNoStudent=request.getParameter("NoStudent").toString().trim();

		
			/*if(request.getParameter("mCheckFstid")==null)
				mCheckFstid="";
			else
				mCheckFstid=request.getParameter("mCheckFstid").toString().trim();*/

		//out.print(mExamCode1+"examcode"+mSubjectID+"subject"+mNoStudent+"fstid"+mCheckFstid+"mCheckFstid"+fs);	
		/***************************************************************************************************************/
			//out.print(fs+"FSFSF");
				
			if(fs>0 )
			{
				String breakslno=""; 
				String abc="SELECT BREAK#SLNO FROM gradecalculation c WHERE C.examcode='"+mExamCode1+"' AND  c.subjectid='"+mSubjectID+"' AND c.institutecode='"+mInst+"' AND NVL(GRADEFLAG,'N')='N' AND nvl(STATUS,'N')='D'";
//out.print(abc);

				ResultSet rsabc=db.getRowset(abc);
				if(rsabc.next())
				{
					 breakslno=rsabc.getString("BREAK#SLNO");
				}
				%><input type=hidden name="breakslno" id="breakslno" value="<%=breakslno%>"> <%
				
				String qryg="select 'Y' from grademaster where institutecode='"+mInst+"' and examcode='"+mExamCode1+"' and nvl(DEACTIVE,'N')='N' and RownUm=1";
				//out.print(qryg);
				ResultSet rsg=db.getRowset(qryg);
				if(rsg.next())
				{

					qry3="SELECT count(distinct enrollmentno)counts FROM (SELECT   a.eventsubevent, a.marksawarded2 marksawarded2,  ROUND (((a.marksawarded2 / a.maxmarks) * b.weightage),2)total, a.fstid fstid, a.studentid studentid, a.enrollmentno enrollmentno, a.studentname studentname FROM v#studenteventsubjectmarks a, v#exameventsubjecttagging b    WHERE a.fstid IN ("+mCheckFstid+") AND a.examcode = '"+mExamCode1+"' AND a.institutecode = '"+mInst+"'   AND a.institutecode = b.institutecode  AND a.examcode = b.examcode AND a.eventsubevent= b.eventsubevent AND a.studentid = b.studentid AND a.subjectid = '"+mSubjectID+"'  AND NVL (a.deactive, 'N') = 'N' AND NVL (a.LOCKED, 'N') = 'Y' AND a.subjectid = b.subjectid  AND NVL (a.deactive, 'N') = 'N' AND a.fstid = b.fstid  ORDER BY enrollmentno, studentname)";
				//out.print(qry3+"coasdsadasdasdaunt");
						rs3=db.getRowset(qry3);
						if(rs3.next())
						{
							String c1=rs3.getString(1);
							 count=Integer.parseInt(c1);

							 //out.print(count+"coasdsadasdasdaunt");
							
						}
						else if(count==0)
						{
							
							count=20;
			
						}
					
				%>	<center>
				<table cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td ><font size=4 color=dark brownt face=verdana><b>Total No. of Students &nbsp;:</b>	
					&nbsp;&nbsp; <b><%=count%>.</b></font></td>
				
				</tr>
				<!-- <TR>
				<td ><font size=2 color=dark brownt face=verdana><b>Note: Save the Grade after putting Grades </b></td>
				</TR> -->
				</table>
				
				</center>
				<%
		if(mNoStudent==null || mNoStudent.equals(""))
				NoStud=20;
			else
				NoStud=Integer.parseInt(mNoStudent);
	
			if (request.getParameter("StartIndex")==null)
					start=1;
				else
					start=Integer.parseInt(request.getParameter("StartIndex").trim());
				if (request.getParameter("LastIndex")==null)
				{
					last=20;
					if(request.getParameter("NoStudent")==null || request.getParameter("NoStudent").equals(""))
					{
						last=20;
						
					}
					else
					{
						
						try
						{
						last=Integer.parseInt(request.getParameter("NoStudent"));

						}
						catch(Exception e)
						{
							//System.out.println("Exception e"+e);
						}
						

					}
				}
				else
				{
					last=Integer.parseInt(request.getParameter("LastIndex").trim());
					
				}
			
	String mPage="";
	int mMassCuts=0;
				
				if (request.getParameter("Paging")==null)
					mPage="";
				else
					mPage=request.getParameter("Paging").trim();
				if(mPage.equals("add"))
				{
					
					start=start+NoStud;
					
					last=last+NoStud;
					
				}
				else if(mPage.equals("substract"))
				{
					
					start=start-NoStud;


					last=last-NoStud;

				}
			
		
				if(count < 1)
				{
					out.print(" <center><b><font size=4 face='Arial' color='Red'>Data Not Found... !</font>");
				}
				else
				{
					int sno=0;
					qry="select distinct a.eventsubevent,b.weightage";
					qry=qry+" from V#STUDENTEVENTSUBJECTMARKS a, ";
					qry=qry+" V#EXAMEVENTSUBJECTTAGGING b where  ";
					qry=qry+" a.fstid in("+mCheckFstid+") ";
					qry=qry+" and a.examcode='"+mExamCode1+"' and a.examcode=b.examcode and a.eventsubevent=b.eventsubevent and ";
					qry=qry+" a.studentid=b.studentid and a.institutecode='"+mInst+"' and a.institutecode=b.institutecode";
					qry=qry+" and a.subjectID='"+mSubjectID+"'   and nvl(a.DEACTIVE,'N')='N' and ";
					qry=qry+" nvl(a.LOCKED,'N')='Y' and a.subjectID=b.subjectID and nvl(a.DEACTIVE,'N')='N' ";
					qry=qry+" and a.fstid=b.fstid  order by a.eventsubevent";
				
					ResultSet rs=db.getRowset(qry);
					while(rs.next())
					{
						subevents.add(rs.getString("eventsubevent")+"$$$"+rs.getString("weightage"));
					}
					
					if(subevents.size()>0)
					{

						
					%>
				<form name="FrmGrade" method=post action="SaveGradeCalculationJPBS.jsp">
				
				
					
					<TABLE align=center rules=group  class="sort-table"   cellSpacing=1 cellPadding=1  border=1>
					<thead>
					<tr bgcolor="#ff8c00">							
						<td nowrap><Font color=white><b>SNo.</b></font></td>
					
						<td nowrap><Font color=white><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Student Name</b></font></td>
						<td nowrap><Font color=white><b>Enrollment No.</b></font></td>



						<%




						String qryadd="";
						String sumadd="",sumadd1="";
						String cccc="",dddd="",aaa="",TA="";
						int i=0;
						for( i=0; i<subevents.size();i++)
						{
								
							 aaa=(String)subevents.get(i);
							cccc=aaa.substring(0,aaa.indexOf("$$$"));
							dddd=aaa.substring(aaa.indexOf("$$$")+3,aaa.length());
							TA=cccc.substring(0,2);
							//out.print(cccc.substring(0,2)+"ddd");
							%><td Style="width:1;" ><Font color=white><b><%=cccc%> (<%=dddd%>)</b></font></td>
											
							<%
							
							
							
							
							if(aa.equals(""))
								aa="'"+cccc+"'";
							else
								aa=aa+",'"+cccc+"'";

							if(qryadd.equals(""))
							{
								qryadd=qryadd+"DECODE(Sum(Decode(xyz.EventSubEvent, '"+cccc+"', total,0)),'','Absent',Sum(Decode(xyz.EventSubEvent, '"+cccc+"', total,0)))  AB"+i+" ";	
								sumadd="NVL(Sum(Decode(xyz.EventSubEvent, '"+cccc+"', total,0)),'0')";
								if(TA.equals("TA") || TA.equals("T ") || TA.equals("T"))
								{
								sumadd1=sumadd1+"+"+"NVL(Sum(Decode(xyz.EventSubEvent, '"+cccc+"', total,0)) ,'0')";
								}
							
								
							}
							else
							{
								qryadd=qryadd+",DECODE(Sum(Decode(xyz.EventSubEvent, '"+cccc+"', total,0)),'','Absent',Sum(Decode(xyz.EventSubEvent, '"+cccc+"', total,0)))  AB"+i+" ";	
								sumadd=sumadd+"+"+"NVL(Sum(Decode(xyz.EventSubEvent, '"+cccc+"', total,0)) ,'0')";

								if(TA.equals("TA") || TA.equals("T ") || TA.equals("T"))
								{
								sumadd1=sumadd1+"+"+"NVL(Sum(Decode(xyz.EventSubEvent, '"+cccc+"', total,0)) ,'0')";
								}
								
							}							
						}		
						
						
								//out.print(cccc.substring(0,2)+"sds"  );
								qryz="select nvl(MASSCUTSAPPLICABLE,'N')MASSCUTSAPPLICABLE,NVL(NEGATIVEMASSCUTSALLOWED,'N')NEGATIVEMASSCUTSALLOWED,EXAMEVENTCODE  from exameventmaster where INSTITUTECODE='"+mInst+"' and  EXAMCODE='"+mExamCode1+"' ";
								//and EXAMEVENTCODE='"+cccc+"' ";
								//out.print(qryz);
								rsz=db.getRowset(qryz);
								while(rsz.next())
								{
									if(rsz.getString("MASSCUTSAPPLICABLE").equals("Y") && rsz.getString("NEGATIVEMASSCUTSALLOWED").equals("Y"))
									{
										MassCutCheck="Y";
										%>
										
										<td nowrap><Font color=white><b>Total Marks <br><%=rsz.getString("EXAMEVENTCODE")%></b></font></td>

										<td nowrap><Font color=white><b>Total <br>Attendance<br> in %</b></font></td>	

										<td nowrap><Font color=white><b>Mass <br>Cuts <br> <%=rsz.getString("EXAMEVENTCODE")%></b></font></td>	

													
										<td nowrap><Font color=white><b>Net<br> <%=rsz.getString("EXAMEVENTCODE")%><br>Marks</b></font></td>	

										<td align="center" nowrap><Font color=white><b>Total Marks<br>Out of 100<br>Minus</br>MassCuts</b></font></td>
										
										<%
									}
										
									
									
								}
								
								if(MassCutCheck.equals("N"))
								{
								%>
							
									<td align="center" nowrap><Font color=white><b>Total Marks<br>Out of 100</b></font></td>			
									<%
								}
										%>
						
						<INPUT TYPE="hidden" NAME="MassCutCheck" value="<%=MassCutCheck%>">
					
						<td align='center' nowrap><Font color=white><b>Grades</b></font></td>							
					</tr>
					</thead>
					<tbody>
					<%
					
					String qry2="Select semester,enrollmentno, studentname, studentid,fstid,"+qryadd+","+sumadd+"  Weightage ";
					if(!sumadd1.equals(""))
						{
					qry2+="	, "+sumadd1+" TAWeightage ";
						}					
					qry2+=" from ( select a.semester,";
					qry2+=" a.EventSubEvent EventSubEvent,a.MARKSAWARDED2 MARKSAWARDED2, round(((a.marksawarded2/a.maxmarks)*b.weightage),2) total,";
					qry2+=" a.fstid fstid, a.studentid studentid,a.enrollmentno enrollmentno, a.studentname studentname ";
					qry2+=" from V#STUDENTEVENTSUBJECTMARKS a, V#EXAMEVENTSUBJECTTAGGING b  where ";
					qry2+=" a.fstid in("+mCheckFstid+") and a.examcode='"+mExamCode1+"' and a.INSTITUTECODE='"+mInst+"'  AND A.INSTITUTECODE=B.INSTITUTECODE and a.examcode=b.examcode  and ";
					qry2+=" a.eventsubevent=b.eventsubevent and a.studentid=b.studentid and a.subjectID='"+mSubjectID+"'  ";
					qry2+=" and nvl(a.DEACTIVE,'N')='N' and nvl(a.LOCKED,'N')='Y' and a.subjectID=b.subjectID ";
					qry2+=" and nvl(a.DEACTIVE,'N')='N' and a.fstid=b.fstid and a.EVENTSUBEVENT in ("+aa+") ";
					qry2+=" order by enrollmentno,studentname)xyz group by semester,enrollmentno,studentname,studentid,fstid  order by enrollmentno, studentname   ";
					//out.print(qry2);
					String qryrow="";
					qryrow="select * from (select a.*, rownum rn from("+qry2+") a where rownum<='"+last+"') where rn>='"+start+"'";
					//out.print(qryrow);
					ResultSet rs2=db.getRowset(qryrow);
					while(rs2.next())
					{	
						
						
					String	mREGCONFIRMATIONDATE="";
		 			qry=" Select nvl(to_char(REGCONFIRMATIONDATE,'dd-mm-yyyy'),' ') REGCONFIRMATIONDATE  From StudentRegistration Where INSTITUTECODE='"+mInst+"'";
					qry=qry+" AND EXAMCODE='"+mExamCode1+"'";
					qry=qry+" AND SEMESTER='"+rs2.getString("SEMESTER")+"' AND NVL(SEMESTERTYPE,' ')='REG'";
					qry=qry+" AND STUDENTID='"+rs2.getString("studentid")+"'";					
					//qry=qry+" AND ACADEMICYEAR='"+rs2.getString("ACADEMICYEAR")+"'";
					//out.print(qry);
					rsBatchDate=db.getRowset(qry);
					 if(rsBatchDate.next())
					{
						if(rsBatchDate.getString("REGCONFIRMATIONDATE")==null) 
							mREGCONFIRMATIONDATE="";
						else
							mREGCONFIRMATIONDATE=rsBatchDate.getString(1);
					}
					else
					{
						mREGCONFIRMATIONDATE="";
					}
						
						
						sno=rs2.getInt("rn");
						mSem=rs2.getInt("semester");
						//out.print(request.getParameter("MassCut")+"sdsd");
						
					//	mTotalMarks=Integer.parseInt(rs2.getString("Weightage"));
							
						if(sno%2==0)
							mColor="lightpink";
						else if(sno%2==1)
							mColor="lightgrey";
						else
							mColor="";					
					

						%>
						<tr bgcolor=<%=mColor%>>
							<%
							String fstidstudid=rs2.getString("fstid")+"@@@"+rs2.getString("studentid")+"***";	
							String str="";	
							String check="checked";
							String mGrade1="";
							String qry8=" select nvl(a.FINALGRADE,' ')FINALGRADE,nvl(a.MASSCUTS,0)MASSCUTS, NVL(FINALMARKS,0)FINALMARKS ,NVL(INITIALMARKS,0)INITIALMARKS  ,studentid from STUDENTWISEGRADE a  WHERE a.EXAMCODE='"+mExamCode1+"' and a.fstid = '"+rs2.getString("fstid")+"'  and a.INSTITUTECODE='"+mInst+"' and a.BREAK#SLNO='"+breakslno+"' and a.STUDENTID='"+rs2.getString("studentid")+"' and nvl(a.DEACTIVE,'N')<>'Y' ";
							//out.print(qry8);
							ResultSet rs8=db.getRowset(qry8);
							if(rs8.next())
							{
								if(!rs8.getString("FINALGRADE").equals(" "))
								{
									str="selected";
									mGrade1=rs8.getString("FINALGRADE");
									
								}
								
								
								mMassCut1=rs8.getDouble("MASSCUTS");
								mFinalMarks1=rs8.getDouble("FINALMARKS");
								mIntialMarks1=rs8.getDouble("INITIALMARKS");
								check="checked";

								mFinalMarks11=0;
							}
							else
							{
								str="";
								check="checked";
								mMassCut1=0;
								mFinalMarks1=0;
								mFinalMarks11=1;
							}
								
							//out.print(mFinalMarks11+"sdfsf"+mFinalMarks1);
						if(mFinalMarks11==1 ||  mGrade1.equals(" ")  )
							{
								mFinalMarks1=rs2.getDouble("Weightage");
								mFinalMarks11=1;
							}
							
							if(!sumadd1.equals(""))
						{
							mTATotalMarks=rs2.getDouble("TAWeightage");
						}

//out.print("sdfsf"+mTATotalMarks);
							if(breakslno.equals(""))
								check="checked";
							
							
							
				

							%>
						
							<td align='right'><b><font size=2><%=rs2.getString("rn")%>.</font></b></td>
							<input type=hidden name="fstidstudid<%=rs2.getString("rn")%>" id="fstidstudid" value="<%=fstidstudid%>"> 
							
							 <input type="hidden" value ='Y' name='studentcheck<%=rs2.getString("rn")%>' > 
							<td  nowrap><font size=2><%=rs2.getString("studentname")%></font></td>
							<td align='center'><font size=2><%=rs2.getString("enrollmentno")%></font></td>				
							<%
							for(int j=0;j<i;j++)
							{
							%>
							<td align='right'><font size=2><%=rs2.getString("AB"+String.valueOf(j))%></font></td>	
							<%
														
							}
							//---- Attendance Total Classes Calculation 
														
							

							qryTCount="SELECT SUM (tcount)tcount FROM 	(select count(CLASSTIMEFROM)Tcount from V#STUDENTATTENDANCE where  SubjectID='"+mSubjectID+"'  and EXAMCODE='"+mExamCode1+"' and INSTITUTECODE='"+mInst+"' and nvl(DEACTIVE,'N')='N' 					 and STUDENTID='"+rs2.getString("studentid")+"' ";
							if(mSem==1 && !mREGCONFIRMATIONDATE.equals(""))
								{
								qryTCount=qryTCount+" and trunc(ATTENDANCEDATE)>=TO_Date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')";
								}
							qryTCount=qryTCount+"UNION all select COUNT (classtimefrom) tcount from STUDENTPREVATTENDENCE where subjectid = '"+mSubjectID+"'  AND examcode = '"+mExamCode1+"'  AND studentid = '"+rs2.getString("studentid")+"' and NVL (deactive, 'N') = 'N' and INSTITUTECODE='"+mInst+"' ";
							if(mSem==1 && !mREGCONFIRMATIONDATE.equals(""))
								{
								qryTCount=qryTCount+" and trunc(ATTENDANCEDATE)>=TO_Date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')";
								}
							qryTCount=qryTCount+" ) ";
							rsTCount=db.getRowset(qryTCount);
							//out.print(qryTCount);
							if(rsTCount.next())
								QryTotCls=rsTCount.getLong("Tcount");
							else
								QryTotCls=0;

				 
							 /* Attendance Total Present Classes */
							qryPCount="SELECT SUM (pcount) pcount					FROM (SELECT COUNT (*) pcount						  FROM v#studentattendance	 WHERE    subjectid = '"+mSubjectID+"'						     AND examcode = '"+mExamCode1+"'  AND studentid = '"+rs2.getString("studentid")+"'	  AND institutecode = '"+mInst+"' AND NVL (present, 'N') = 'Y' AND NVL (deactive, 'N') = 'N' ";
							if(mSem==1 && !mREGCONFIRMATIONDATE.equals(""))
								{
								qryPCount=qryPCount+" and trunc(ATTENDANCEDATE)>=TO_Date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')";
								}
							qryPCount=qryPCount+"  UNION ALL	SELECT COUNT (classtimefrom) pcount FROM studentprevattendence		 WHERE subjectid = '"+mSubjectID+"'  AND NVL (present, 'N') = 'Y'  AND examcode = '"+mExamCode1+"'  AND studentid = '"+rs2.getString("studentid")+"' AND NVL (deactive, 'N') = 'N'  AND institutecode ='"+mInst+"' ";
							if(mSem==1 && !mREGCONFIRMATIONDATE.equals(""))
								{
								qryPCount=qryPCount+" and trunc(ATTENDANCEDATE)>=TO_Date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')";
								}
							qryPCount=qryPCount+" )   ";
							rsPCount=db.getRowset(qryPCount);
							//out.print(qryPCount);
							if(rsPCount.next())
								QryTotPrs=rsPCount.getLong("Pcount");
							else
								QryTotPrs=0;

								
								try
								{
									if(QryTotCls==0)
										QryPercAtt=0;
									else
										QryPercAtt=((QryTotPrs*100)/QryTotCls);

							//	out.print(QryTotCls+"::"+QryTotPrs+" Tot Percentage - "+QryPercAtt);
								}
								catch(ArithmeticException e)
								{
									//out.print(e);
								}						
								
												
											
							qrys="SELECT  distinct A.EXAMEVENTCODE,nvl(A.MASSCUTSAPPLICABLE,'N')MASSCUTSAPPLICABLE,NVL(A.NEGATIVEMASSCUTSALLOWED,'N')NEGATIVEMASSCUTSALLOWED ,b.MASSCUTS FROM EXAMEVENTMASTER A,MASSCUTSCRITERIA B,V#STUDENTEVENTSUBJECTMARKS c WHERE							A.EXAMCODE='"+mExamCode1+"'  and b.EXAMCODE=c.EXAMCODE and a.EXAMCODE=c.EXAMCODE and c.STUDENTID='"+rs2.getString("studentid")+"'  and a.INSTITUTECODE=c.INSTITUTECODE and nvl(c.DEACTIVE,'N')='N' AND A.INSTITUTECODE='"+mInst+"' AND A.EXAMCODE=B.EXAMCODE AND A.EXAMEVENTCODE=B.EXAMEVENTCODE and a.INSTITUTECODE=b.INSTITUTECODE  	 and TO_NUMBER ("+QryPercAtt+") between TO_NUMBER (b.attendancepercentagefrom) and  TO_NUMBER (b.attendancepercentageto)   ";
								//and EXAMEVENTCODE='"+cccc+"' ";
							//out.print(qrys);
								rss=db.getRowset(qrys);
								if(rss.next())
								{
									if(rss.getString("MASSCUTSAPPLICABLE").equals("Y") && rss.getString("NEGATIVEMASSCUTSALLOWED").equals("Y"))
									{
										
												if(mMassCut1==0 )
												{
													mMassCutMarks=rss.getDouble("masscuts");
												}
												else
												{
													mMassCutMarks=mMassCut1;
												}
												
											
										//out.print(mMassCutMarks+"sdfsdf");

										mNetMarks=mTATotalMarks-mMassCutMarks;
										//if mFinalMarks1 is not saved first 
										if(mFinalMarks11==1 ||  mGrade1.equals(" ") )
										{
										mFinalMarks1=mFinalMarks1-mMassCutMarks;
										}
										
										%>
									
										<td align='center'> <font size=2> <%=mTATotalMarks%> </font></td>	


										<td align='center'> <font size=2> <%=QryPercAtt%> (%)</font></td>	

										<td nowrap><INPUT TYPE="text" NAME="MassCuts<%=rs2.getString("rn")%>" value=<%=mMassCutMarks%>  onchange="return ValidateMassCut(<%=rss.getString("MASSCUTS")%>,<%=rs2.getString("rn")%>,<%=rs2.getDouble("Weightage")%>,<%=mTATotalMarks%> );"  onBlur="return ValidateMassCut(<%=rss.getString("MASSCUTS")%>,<%=rs2.getString("rn")%>,<%=rs2.getDouble("Weightage")%>,<%=mTATotalMarks%> );" size=2></font></td>

										<td align='center'><INPUT TYPE="text" NAME="NetMarks<%=rs2.getString("rn")%>" value="<%=mNetMarks%>"  readonly size=2 ></td>	

		
										<td align='center'><INPUT TYPE="text" NAME="FinalMarks<%=rs2.getString("rn")%>" value="<%=mFinalMarks1%>"  readonly size=2 ></td>		
										 
										<%
										
									}
									
								}
							
							
								if(MassCutCheck.equals("N"))
								{
								%>
									<td align='center'><font size=2 color=blue><b><%=rs2.getDouble("Weightage")%><b></font></td>
									<INPUT TYPE="hidden" NAME="FinalMarks<%=rs2.getString("rn")%>" value="<%=rs2.getDouble("Weightage")%>">
								<%
								}
								%>

							<td>
								<select name=grade<%=rs2.getString("rn")%> >
								<option value=" " selected>Select</option>
									<%	
								

								String qry4=" Select DISTINCT grade from grademaster where institutecode='"+mInst+"' and examcode='"+mExamCode1+"' ORDER BY GRADE " ;
						
									ResultSet rs4=db.getRowset(qry4);
									//System.out.print("<br>"+mGrade1+"31111"+rs4.getString("grade"));
									while(rs4.next())
									{
										if(mGrade1.equals(rs4.getString("grade")))
										{
										
										%><option value=<%=rs4.getString("grade")%> <%=str%>><%=rs4.getString("grade")%></option><%
										}
										else
										{
										%><option value=<%=rs4.getString("grade")%>><%=rs4.getString("grade")%></option><%
										}
									}
									%>	
								</select>
							</td>					
						</tr><%		
										
					}
									
									//end of rs2.next
					}//end of if subevents
				
				
					else
					{	
					%>
						<br>
						<font color=red>
						<h3>	<br><img src='../../Images/Error1.jpg'>	Marks are not defined........ </h3><br>
						
						</font>	<br>	<br>	<br>	<br>  
					<%
					}	

										
					
					for(int yy=1;yy<=mCheck;yy++)
					{				

						if(!(request.getParameter("FSTID"+yy)==null ) && (mCheckFstid!=null ) )
						{


							fs++;
							%>
							<INPUT TYPE="hidden" NAME="FSTID<%=yy%>" value="<%=request.getParameter("FSTID"+yy).toString().trim()%>">
							<%
							//	out.print(request.getParameter("FSTID"+yy)+"FSFSF");
							
						}

					}
//out.print(mCheckFstid+"mCheckFstid");
					%>
						
					

					<input type="hidden" name="sno" id="sno" value="<%=sno%>"> 
					<INPUT TYPE="hidden" NAME="mCheckFstid" value="<%=mCheckFstid%>"> 
					<input id="checkctr" name="checkctr" type=hidden value=<%=mCheck%>>
					<input id="count" name="count" type=hidden value=<%=count%>>
					<input id="SEMESTER" name="SEMESTER" type=hidden value=<%=mSem1%>>
					<input id="NoStudent" name="NoStudent" type=hidden value=<%=mNoStudent%>>
					<INPUT TYPE="hidden" NAME="FS" ID="FS" VALUE="<%=fs%>"> 
					 <INPUT TYPE="hidden" NAME="Subject" ID="Subject" VALUE="<%=mSubjectID%>">
			        <INPUT TYPE="hidden" NAME="ExamCode" ID="ExamCode" VALUE="<%=mExamCode1%>">
					<tr><td	colspan=9 align=center><input type="submit" name="SaveGrade" value="Save Grade" onclick="return Validate(<%=start%>,<%=last%>)"> 
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<Font face=verdana color=green><b>  <%=start%>-<%=sno%> displayed out of total <%=count%> records.<b></font></td></tr>
					</tbody>
					</table>	
					</form>



					<table align=center cellspacing =1 cellpadding=8>
					<tr>
					 <!-- <td><input type="submit" name="Excel" value="Save In Excel"></td> -->
					 
					<%
						if(start!=1)
						{
							%>
							<form method="Post" Action="GradeCalculationActionJPBS.jsp">
							<input id="x" name="x" type=hidden>
							<INPUT TYPE="hidden" NAME="Paging" VALUE="substract">
							<INPUT TYPE="hidden" NAME="MassCutCheck" value="<%=MassCutCheck%>"> 
							<INPUT TYPE="hidden" NAME="mCheckFstid" value="<%=mCheckFstid%>"> 
							<INPUT TYPE="hidden" NAME="FS" ID="FS" VALUE="<%=fs%>"> 
							<INPUT TYPE="hidden" NAME="NoStudent" ID="NoStudent" VALUE=<%=mNoStudent%>>
							<input id="count" name="count" type=hidden value=<%=count%>>
							<input id="checkctr" name="checkctr" type=hidden value=<%=mCheck%>>
	    					<INPUT TYPE="hidden" NAME="FSTID" id="FSTID" value="<%=mCheckFstid%>">
							<INPUT TYPE="hidden" NAME="Subject" ID="Subject" VALUE="<%=mSubjectID%>">
							<INPUT TYPE="hidden" NAME="ExamCode" ID="ExamCode" VALUE="<%=mExamCode1%>">
							<INPUT TYPE="hidden" NAME="StartIndex" VALUE=<%=start%>>
							<INPUT TYPE="hidden" NAME="LastIndex" VALUE=<%=last%>>
							<td align="left">
							<INPUT TYPE="submit" value="Previous" name="Previous">
							</td>
						
						
							

							</form>
							<%
						}
						if(last<count)
						{
							%>
							<form method="Post" Action="GradeCalculationActionJPBS.jsp">
							<INPUT TYPE="hidden" NAME="Paging" VALUE="add">
							<input id="x" name="x" type=hidden>
							<INPUT TYPE="hidden" NAME="MassCutCheck" value="<%=MassCutCheck%>"> 
						    <INPUT TYPE="hidden" NAME="mCheckFstid" value="<%=mCheckFstid%>"> 
							<INPUT TYPE="hidden" NAME="FS" ID="FS" VALUE="<%=fs%>"> 
							<input id="checkctr" name="checkctr" type=hidden value=<%=mCheck%>>
						    <INPUT TYPE="hidden" NAME="FSTID" id="FSTID" value="<%=mCheckFstid%>">
							<input id="count" name="count" type=hidden value=<%=count%>>
							 <INPUT TYPE="hidden" NAME="Subject" ID="Subject" VALUE="<%=mSubjectID%>">
							<INPUT TYPE="hidden" NAME="ExamCode" ID="ExamCode" VALUE="<%=mExamCode1%>">
							<INPUT TYPE="hidden" NAME="StartIndex" VALUE=<%=start%>>
							<INPUT TYPE="hidden" NAME="LastIndex" VALUE=<%=last%>>
							<INPUT TYPE="hidden" NAME="NoStudent" ID="NoStudent" VALUE=<%=mNoStudent%>>
							
						
							<td align="right"><INPUT TYPE="submit" value="Next"  name="Next"></td>
							</form>
							<%
						}
							%>
						</tr>
						</table>
					<%	
					
				
				}//end of else count
				}
				else
				{
					%>
						<br>
						<font color=red>
						<h3>	<br><img src='../../Images/Error1.jpg'>	Grades are not defined </h3><br>
						
						</font>	<br>	<br>	<br>	<br>  
					<%
				}
			
			}
			else
				{
				out.print("Error");
				}

			/***************************************************************************************************************/
			//-----------------------------
			//---Enable Security Page Level  
			//-----------------------------
		}//end of x!=null
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
	else
	{
		out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}    
}

catch(Exception e)
{
	//out.print(e );
}
%>
</body>
</html>