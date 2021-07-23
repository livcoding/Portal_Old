<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*,java.util.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%@page contentType="text/html"%> 
<body>
<%
try
{
	GlobalFunctions gb =new GlobalFunctions();
	OLTEncryption enc=new OLTEncryption();
	DBHandler db=new DBHandler();
	ResultSet rssub=null;
	String mMemberID="",mMemberType="",mMemberName="",mMemberCode="",mInst="",mComp="",mDMemberCode="",mCheckFstid="";
	int mCheck=0,mSNO11=0,mSNO=0,mCount1=0,mCount2=0;
	String qrysub="",mNam="",mCheckRadio="",mDMemberType="",qry="",mExamCode="",mSubjectCode="",mETOD="",mSem1="",aa="";
	ArrayList subevents=new ArrayList();
	double mSumMark=0.0;		
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

	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
	{
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);
		String mCode=enc.decode(mMemberCode);
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
			response.setContentType("application/vnd.ms-excel");
			//response.setContentType("application/msword");
			response.setHeader("Content-Disposition","attachment; filename=GradeCalculationBeforedraft.xls");
			if(request.getParameter("checkctr")==null)
				mCheck=0;
			else
				mCheck=Integer.parseInt(request.getParameter("checkctr").toString().trim());

			if(request.getParameter("SNO")==null)
				mSNO11=0;
			else
				mSNO11=Integer.parseInt(request.getParameter("SNO").toString().trim());
			%>
			
			<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
				<tr>
					<TD colspan=7 align=middle>
					<font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Grade Calculation</b></font>
					</td>
				</tr>
			</TABLE>    
			<%			
			if(request.getParameter("ExamCode")==null)
				mExamCode="";
			else
				mExamCode=request.getParameter("ExamCode").toString().trim();

			if(request.getParameter("Subject")==null)
				mSubjectCode="";
			else
				mSubjectCode=request.getParameter("Subject").toString().trim();

			if(request.getParameter("ETOD")==null)
				mETOD="";
			else
				mETOD=request.getParameter("ETOD").toString().trim();
			if(request.getParameter("SEMESTER")==null)
				mSem1="";
			else
				mSem1=request.getParameter("SEMESTER").toString().trim();
			/***************************************************************************************************************/
			String mSubcode="";
			qrysub="select subject,subjectcode from subjectmaster where subjectID='"+mSubjectCode+"' and InstituteCode='"+mInst+"' and nvl(deactive,'N')='N' ";
			//out.println(qrysub);
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
			//out.println(query123);
			rssub=db.getRowset(query123);
			if(rssub.next())
			{
				name=rssub.getString("employeename");
				time=rssub.getString("dd");
			}
			%>
			<table>
				<tr>
					<td colspan='4'>
						<b>CoOrd. Name/Member name : </b><font color=dark brownt><b><%=name%>&nbsp;(<%=mCode%>)</font></b>
					</td>
					<td colspan='3'>
						<b>Date & Time : </b><font color=dark brownt><b><%=time%></font></b>
					</td>
				</tr>
				<tr>
					<td colspan='4'>
						<b>Subject : </b>
						<font color=dark brownt><b><%=mNam%>(<%=mSubcode%>)</font></b>
					</td>
					<td colspan='3'>
						<b>ExamCode : </b>
						<font color=dark brownt><b><%=mExamCode%></font></b>
					</td>
				<tr>
				<tr>
					<td colspan='7' align='center'>
						
						<font color=dark brownt><b>[  Before Draft Save  ]</font></b>
					</td>					
				<tr>
				</table>
			<%
			if(request.getParameter("CHECKRADIO")==null)
				mCheckRadio="N";
			else
				mCheckRadio=request.getParameter("CHECKRADIO").toString().trim();
			if(mCheckRadio.equals("Y"))
			{
				if(request.getParameter("SNO")==null)
					mSNO=0;
				else
					mSNO=Integer.parseInt(request.getParameter("SNO").toString().trim());
			}
			int mYesNo=0,fs=0;
			if(request.getParameter("jss")==null)
				mYesNo=0;
			else
				mYesNo=Integer.parseInt(request.getParameter("jss").toString().trim());
			//out.println(mYesNo);
			for(int yy=1;yy<=mCheck;yy++)
			{				
				if(!(request.getParameter("FSTID"+yy)==null ))
				{					
					if(mCheckFstid.equals(""))
						mCheckFstid=" '"+request.getParameter("FSTID"+yy)+"' ";				
					else
						mCheckFstid=mCheckFstid+", '"+request.getParameter("FSTID"+yy)+"' ";
				}
			}	
			if(!mCheckFstid.equals(""))
			{
				String qryg="select 'y' from grademaster where institutecode='"+mInst+"' and examcode='"+mExamCode+"' and nvl(DEACTIVE,'N')='N' and RownUm=1";
				//out.print(qryg);
				ResultSet rsg=db.getRowset(qryg);
				if(rsg.next())
				{
					int sno=0;
					qry="select distinct a.eventsubevent,b.weightage";
					qry=qry+" from V#STUDENTEVENTSUBJECTMARKS a, ";
					qry=qry+" V#EXAMEVENTSUBJECTTAGGING b where  ";
					qry=qry+" a.fstid in("+mCheckFstid+") ";
					qry=qry+" and (('"+mETOD+"'='N' and a.semestertype not in (select semestertype from semestertype where institutecode='"+mInst+"' ";
					qry=qry+" and nvl(ETOD,'N')='Y'))  or ('"+mETOD+"'='E' and a.semestertype not in (select semestertype from semestertype where ";
					qry=qry+" institutecode='"+mInst+"' and  nvl(ETOD,'N')='Y'))) ";
					qry=qry+" and a.examcode='"+mExamCode+"' and a.examcode=b.examcode and a.eventsubevent=b.eventsubevent and ";
					qry=qry+" a.studentid=b.studentid and a.INSTITUTECODE=b.INSTITUTECODE and a.institutecode='"+mInst+"' ";
					qry=qry+" and a.subjectID='"+mSubjectCode+"'  and nvl(a.DEACTIVE,'N')='N' and ";
					qry=qry+" nvl(a.LOCKED,'N')='Y' and a.subjectID=b.subjectID and nvl(a.DEACTIVE,'N')='N' ";
					qry=qry+" and a.fstid=b.fstid  order by a.eventsubevent";
					//qry=qry+" group by a.studentid, ";
					//out.println(qry);
					ResultSet rs=db.getRowset(qry);
					while(rs.next())
					{
						subevents.add(rs.getString("eventsubevent")+"$$$"+rs.getString("weightage"));
					}
					%><TABLE align=center  cellSpacing=1 cellPadding=1 width="100%" border=1>
					<tr bgcolor='Lightyellow'>
							
							<td width='5%'><b>Sno.</b></td>							
							<td width='30%'><b>Stduent Name</b></td>
							<td width='15%'><b>Enrollment No.</b></td>
							<%
							String qryadd="";
						String sumadd="";
						int i=0;
						for( i=0; i<subevents.size();i++)
						{
							String aaa=(String)subevents.get(i);
							String cccc=aaa.substring(0,aaa.indexOf("$$$"));
							String dddd=aaa.substring(aaa.indexOf("$$$")+3,aaa.length());
							
							//String bb=subevents.get(i).subString(subevents.get(i).indexOf("$$$")+3,subevents.get(i).length());
							//out.println(cccc + ""+ dddd);
							%><td><b><%=cccc%>  &nbsp; (<%=dddd%>)</b></td><%
							if(aa.equals(""))
								aa="'"+cccc+"'";
							else
								aa=aa+",'"+cccc+"'";
							if(qryadd.equals(""))
							{
								qryadd=qryadd+"DECODE(Sum(Decode(xyz.EventSubEvent, '"+cccc+"', total,0)),'','Absent',Sum(Decode(xyz.EventSubEvent, '"+cccc+"', total,0)))  AB"+i+" ";	
								sumadd="NVL(Sum(Decode(xyz.EventSubEvent, '"+cccc+"', total,0)),'0')";
							}
							else
							{
								qryadd=qryadd+",DECODE(Sum(Decode(xyz.EventSubEvent, '"+cccc+"', total,0)),'','Absent',Sum(Decode(xyz.EventSubEvent, '"+cccc+"', total,0)))  AB"+i+" ";	
								sumadd=sumadd+"+"+"NVL(Sum(Decode(xyz.EventSubEvent, '"+cccc+"', total,0)) ,'0')";
							}								
						}					
											
						//out.println(qryadd+"<br>"+sumadd);
						%>						
						
						<td align="center"><b>Total Weightage<br>Out of 100 </b></td>
						<td align='center'><b>Grades</b></td>							
					</tr>
					<%
					//String qry2="Select enrollmentno, studentname, studentid,fstid,Sum(Decode(xyz.EventSubEvent, 'T1', MARKSAWARDED2,0)) T1,";
					String qry2="Select enrollmentno, studentname, studentid,fstid,"+qryadd+","+sumadd+"  Weitage from ( select ";
					qry2+=" a.EventSubEvent,a.MARKSAWARDED2 MARKSAWARDED2, round(((a.marksawarded2/a.maxmarks)*b.weightage),2) total,";
					qry2+=" a.fstid fstid, a.studentid studentid,a.enrollmentno enrollmentno, a.studentname studentname ";
					qry2+=" from V#STUDENTEVENTSUBJECTMARKS a, V#EXAMEVENTSUBJECTTAGGING b  where ";
					qry2+=" a.fstid in("+mCheckFstid+") and (('"+mETOD+"'='N' and a.semestertype not in (select semestertype  ";
					qry2+="	from semestertype where institutecode='"+mInst+"' and nvl(ETOD,'N')='Y')) or ('"+mETOD+"'='E'   ";
					qry2+=" and a.semestertype not in (select semestertype from semestertype where institutecode='"+mInst+"' and ";
					qry2+=" nvl(ETOD,'N')='Y'))) and a.examcode='"+mExamCode+"' and a.examcode=b.examcode  and ";
					qry2+=" a.eventsubevent=b.eventsubevent and a.studentid=b.studentid and a.subjectID='"+mSubjectCode+"'  ";
					qry2+=" and nvl(a.DEACTIVE,'N')='N' and nvl(a.LOCKED,'N')='Y' and a.subjectID=b.subjectID ";
					qry2+=" and nvl(a.DEACTIVE,'N')='N' AND  a.institutecode='"+mInst+"' and a.institutecode=b.institutecode and a.fstid=b.fstid and a.EVENTSUBEVENT in ("+aa+") ";
					qry2+=" order by enrollmentno, studentname)xyz group by enrollmentno,studentname,studentid,fstid  order by enrollmentno, studentname   ";
					ResultSet rs2=db.getRowset(qry2);
					//out.print(qry2);
					//String sname="";
					while(rs2.next())
					{
						%>
						<tr>
							<td><b><%=++sno%>.</b></td>							
							<td>&nbsp;<%=rs2.getString("studentname")%></td>
							<td>&nbsp;<%=rs2.getString("enrollmentno")%></td>								
							<%for(int j=0;j<i;j++){%>
							
							<td align='right'><%=rs2.getString("AB"+String.valueOf(j))%></td>				
							<%}%>	
							<td align='center'><%=rs2.getString("Weitage")%></td>				
							
							<td>
								<select name=grade width="10%" >
									<option value="" selected>Select</option>
									<%														
									String str="";	
									String mGrade1="";
									String qry8=" select nvl(a.FINALGRADE,' ')FINALGRADE from STUDENTWISEGRADE a  WHERE a.EXAMCODE='"+mExamCode+"' and a.fstid = '"+rs2.getString("fstid")+"'  and a.INSTITUTECODE='"+mInst+"' and a.BREAK#SLNO=(SELECT BREAK#SLNO FROM gradecalculation c WHERE C.examcode='"+mExamCode+"' AND  c.subjectid='"+mSubjectCode+"' AND c.institutecode='"+mInst+"' AND GRADEFLAG='N' AND STATUS='D') and a.STUDENTID='"+rs2.getString("studentid")+"' and nvl(a.DEACTIVE,'N')<>'Y' ";
									//System.out.println(qry8);
									ResultSet rs8=db.getRowset(qry8);
									if(rs8.next())
									{
										if(!rs8.getString("FINALGRADE").equals(" "))
										{
											str="selected";
											mGrade1=rs8.getString("FINALGRADE");
										}
									}
									else
									{
										str="";
									}
									
									String qry4=" Select grade from grademaster where institutecode='"+mInst+"' and examcode='"+mExamCode+"'";
									ResultSet rs4=db.getRowset(qry4);
									while(rs4.next())
									{
										if(mGrade1.equals(rs4.getString("grade")))
										{
											%><option value="<%=rs4.getString("grade")%>" <%=str%>><%=rs4.getString("grade")%></option><%
										}
										else
										{
											%><option value="<%=rs4.getString("grade")%>" ><%=rs4.getString("grade")%></option><%
										}
									}
									%>	
								</select>
							</td>							
						</tr>
						<%						
					}
					%>							
					</table>
					<%					
				}
			}
			/***************************************************************************************************************/
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