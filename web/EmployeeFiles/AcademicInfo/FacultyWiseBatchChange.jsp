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
<TITLE>#### <%=mHead%> [ Coordinator Wise Student List ] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />



</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%

GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="",mDept="",mDesg="",mInst="",minst="",mComp="",mDMemberID="";
String mExamID="",mexam="",mExamid="",QryExamid="",mSubEventCode="",mSubj="",msubj="";
String qry="",mDualMarks="",MOM="",Dt1="",Dt2="",mEE="";
double mAllowedWeightage=0,MaxAW=100;
int msno=0, len=0, pos=0, ctr=0;
String mCurDate="", mExamsubevent="",mExamevent="";
ResultSet rs=null,rss=null,rs1=null,rs2=null;
String msubeven="",mMarks="",mPerc="",mName1="",mSem="",mMark="",mName2="",mName3="";
boolean flag=false;
try
{

	if (session.getAttribute("CompanyCode")==null)
	{
		mComp="";
	}
	else
	{
		mComp=session.getAttribute("CompanyCode").toString().trim();
	}

	if (session.getAttribute("InstituteCode")==null)
	{
		mInst="";
	}
	else
	{
		mInst=session.getAttribute("InstituteCode").toString().trim();
	}

	if (session.getAttribute("Designation")==null)
	{
		mDesg="";
	}
	else
	{
		mDesg=session.getAttribute("Designation").toString().trim();
	}

	if (session.getAttribute("DepartmentCode")==null)
	{
		mDept="";
	}
	else
	{
		mDept=session.getAttribute("DepartmentCode").toString().trim();
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
		qry="Select WEBKIOSK.ShowLink('217','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
  //----------------------
			mDMemberCode=enc.decode(mMemberCode);
			mDMemberType=enc.decode(mMemberType);
			mDMemberID=enc.decode(mMemberID);
			%>
			<form name="frm" method="post" >
			<input id="x" name="x" type=hidden>
			<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
			<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana"><B>Coordinator Wise Student List </B></TD>
			</font></td></tr>
			</TABLE>
			 <table cellpadding=1 cellspacing=0  align=center rules=groups border=2>

			<!-- <tr><td colspan=2 align=center>&nbsp;<font color=navy face=arial size=2><STRONG>Employee : &nbsp;</STRONG></font><font color=black face=arial size=2><%=mMemberName%>[<%=mDMemberCode%>]
			&nbsp; &nbsp; &nbsp;<font color=navy face=arial size=2><STRONG>Department : &nbsp;</STRONG></font><%=GlobalFunctions.toTtitleCase(mDept)%>
			&nbsp; &nbsp; &nbsp;<font color=navy face=arial size=2><STRONG>Designation : &nbsp;</STRONG></font><%=GlobalFunctions.toTtitleCase(mDesg)%>
			<hr></td></tr>  -->


		<!--*********Exam**********-->
			<td><FONT color=black><FONT face=Arial size=2><STRONG>Exam Code</STRONG></FONT></FONT>
			<select name=Exam tabindex="1" id="Exam">
			<%
			try
			{
			 qry="SELECT EXAMCODE from(";
	qry=qry+" Select nvl(EXAMCODE,' ') EXAMCODE , EXAMPERIODFROM from EXAMMASTER Where InstituteCode='"+mInst+"' AND ";
	qry=qry+" nvl(Deactive,'N')='N' and Nvl(LOCKEXAM,'N')='N' and nvl(EXCLUDEINATTENDANCE,'N')='N' ";
	qry=qry+" and (examcode in (select ExamCode from facultysubjecttagging where employeeid='"+mDMemberID+"'and InstituteCode='"+mInst+"'  AND  fstid in (select fstid from studentltpdetail where InstituteCode='"+mInst+"' ))";
	qry=qry+" OR examcode in (select ExamCode from MultiFacultysubjecttagging where employeeid='"+mDMemberID+"' AND  fstid in (select fstid from studentltpdetail where InstituteCode='"+mInst+"' )))";
	qry=qry+" order by EXAMPERIODFROM DESC)";
//out.print(qry);

			 rs=db.getRowset(qry);
			 if (request.getParameter("x")==null)
			 {
				 while(rs.next())
				 {
					 mExamid=rs.getString("EXAMCODE");
					 if(QryExamid.equals(""))
 					 {
						QryExamid=mExamid;
						%>
						<OPTION selected Value =<%=mExamid%>><%=rs.getString("EXAMCODE")%></option>
						<%
					 }
					 else
					 {
						%>
						<OPTION Value =<%=mExamid%>><%=rs.getString("EXAMCODE")%></option>
						<%
					 }
				}
			}
			else
			{
				while(rs.next())
				{
					mExamid=rs.getString("EXAMCODE");
					if(mExamid.equals(request.getParameter("Exam")))
	 				{
						QryExamid=mExamid;
						%>
						<OPTION selected Value =<%=mExamid%>><%=rs.getString("EXAMCODE")%></option>
						<%
					}
					else
					{
						%>
						<OPTION Value =<%=mExamid%>><%=rs.getString("EXAMCODE")%></option>
						<%
					}
				}
			 }
		     }
		     catch(Exception e)
	     	     {
		    	//out.println(e.getMessage());
				  }
		     %>
	           </select>&nbsp;&nbsp;
			<input type=hidden name="Exam" id="Exam" value="<%=mExamid%>">

			<INPUT Type="submit" Value="&nbsp; OK &nbsp;">
			</td>
			</tr>
			</table>
			</form>
			<%
			if(request.getParameter("x")!=null)
			{
				if (request.getParameter("Exam")==null)
				{
					mExamID="";
				}
				else
				{
					mExamID=request.getParameter("Exam").toString().trim();

				}
			%>
			<form name="frm1" method=post >
			<input type=hidden name="y" id="y">
			<input type=hidden name="x" id="x">
			<input type=hidden name="Exam" id="Exam" value='<%=mExamID%>'>
			<table cellpadding=1 cellspacing=0  align=center rules=groups border=2>
		<!--*********Exam Event Code**********-->

		<!--********Subject*****-->
			<tr><td >
			<%
			qry="Select distinct subject, subjectID From (";
		 	qry=qry+"(select A.FSTID, nvl(B.subject,' ')||'('|| nvl(B.subjectcode,' ')||')' subject , A.subjectID subjectID from facultysubjecttagging A, ";
			qry=qry+" subjectmaster B where (A.LTP='L' OR A.LTP='T' OR A.LTP='P' ) " +
                    "  and A.examcode='"+mExamID+"'  and a.INSTITUTECODE='"+mInst+"' and A.facultytype=decode('"+mDMemberType+"','E','I','E') ";
			qry=qry+" and A.INSTITUTECODE=B.INSTITUTECODE and A.subjectID=B.subjectID and nvl(A.deactive,'N')='N' and nvl(B.Deactive,'N')='N'";
			qry=qry+" and a.SUBJECTID not IN (SELECT DISTINCT SUBJECTID FROM GRADECALCULATION WHERE" +
                    " examcode='"+mExamID+"' and INSTITUTECODE='"+mInst+"'  ";
			qry=qry+" and NVL(STATUS,'D')='F') AND   a.subjectid IN ( SELECT b.subjectid  " +
                    "  FROM pr#departmentsubjecttagging b      WHERE b.examcode = '"+mExamID+"'" +
                    " AND b.institutecode = '"+mInst+"'  and b.DEPARTMENTCODE='"+mDept+"' " +
                    "  AND NVL (b.deactive, 'N') = 'N') GROUP BY A.FSTID, nvl(B.subject,' ')||'('|| nvl(B.subjectcode,' ')||')' , A.subjectID)";
				qry=qry+" ) ";
			//out.print(qry);
			rss=db.getRowset(qry);

			%>
			<FONT color=black><FONT face=Arial size=2><STRONG>Subject</STRONG></FONT></FONT>
			&nbsp;&nbsp;&nbsp;<select name=Subject tabindex="0" id="Subject">
			<%
			try
			{
				if (request.getParameter("y")==null)
				{
					while(rss.next())
					{
						mSubj=rss.getString("SubjectID");
						if(msubj.equals(""))
			 			msubj=mSubj;
						%>
						<OPTION Value =<%=mSubj%>><%=rss.getString("Subject")%></option>
						<%


					}
				}
				else
				{
					while(rss.next())
					{
						mSubj=rss.getString("SubjectID");
						if(mSubj.equals(request.getParameter("Subject").toString().trim()))
			 			{
							msubj=mSubj;
							%>
							<OPTION selected Value =<%=mSubj%>><%=rss.getString("Subject")%></option>
							<%
		     				}
					     	else
		      			{
							%>
		      				<OPTION Value =<%=mSubj%>><%=rss.getString("Subject")%></option>
					      	<%
					   	}
					}
				}
			}
			catch(Exception e)
			{
				//out.print(qry);
			}
			%>
			</select>
			&nbsp;&nbsp;
			<INPUT Type="submit" Value="&nbsp; View &nbsp;">

			</td>
			</tr>
			</table>


			<%

			//out.println("Exam Code :"+mExamID+" Subject :"+mSubj+" Event :"+mEventCode);
			if(request.getParameter("y")!=null)
			{
				//out.println("Exam Code"+mExamID);
				if(request.getParameter("Exam")!=null  && request.getParameter("Subject")!=null )
				{

					mExamID=request.getParameter("Exam").toString().trim();
					mSubj=request.getParameter("Subject").toString().trim();


				//*******************************************************************
					qry="Select distinct FSTID FROM (";
		 			qry=qry+"(select A.FSTID, nvl(B.subject,' ')||'('|| nvl(B.subjectcode,' ')||')' subject , A.subjectID subjectID from facultysubjecttagging A, ";
					qry=qry+" subjectmaster B where (A.LTP='L' OR a.LTP = 'P' OR a.LTP = 'T')" +
                            " and   A.examcode='"+mExamID+"' and A.facultytype=decode('"+mDMemberType+"','E','I','E') ";
					qry=qry+" and a.INSTITUTECODE='"+mInst+"'  and A.INSTITUTECODE=B.INSTITUTECODE and A.subjectID=B.subjectID and nvl(A.deactive,'N')='N' and nvl(B.Deactive,'N')='N'";
					qry=qry+" and a.SUBJECTID not IN (SELECT DISTINCT SUBJECTID FROM GRADECALCULATION WHERE examcode='"+mExamID+"' and INSTITUTECODE='"+mInst+"' ";
					qry=qry+" and NVL(STATUS,'D')='F') AND A.SUBJECTID='"+mSubj+"' GROUP BY A.FSTID, nvl(B.subject,' ')||'('|| nvl(B.subjectcode,' ')||')' , A.subjectID)";
					qry=qry+" ) order by fstid";
					rss=db.getRowset(qry);
					//out.print(qry);
					%>
					<br><br>
					<table valign=top bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0  topmargin=0 cellspacing=0 cellpadding=0 border=1 RULES=NONE width="90%" align=center >
						<thead>
						<tr bgcolor="#ff8c00">
                            
						<td ><font color="White"><b>Check &nbsp;|&nbsp;Employee Name </b></font></td>

                      
                        <td >
                            <table border="0">
                               <tr>
                                   <td width="80px"> <font color="White" size="2" face="arial"><b>Check All</td>
                                   <td width="80px" > <font color="White" size="2" face="arial"><b>Strenght</td>
                                   <td width="80px" > <font color="White" size="2" face="arial"><b>Program</td>
                                   <td width="80px" > <font color="White" size="2" face="arial" ><b>Section/SubSect.</td>
                                   
                               </tr>
                            </table>
                      <!--
                      <font color="White">
                      <b>&nbsp;&nbsp;Check All&nbsp;|&nbsp;Strenght&nbsp;|&nbsp;Program&nbsp;|&nbsp;Sec/SubSec
                      </b></font>
                        -->
                       </td>
						<!-- <td ><font color="White"><b>(Sec/SubSec)</b></font></td>
						<td ><font color="White"><b> Students Name</b></font></td> -->
						</tr>
						</thead>
						<tbody>

					<%
					String QryFSTID="",qry1="",mEmpName="",mSecBranch="",mSubCode="",mEmpId="",mProg="";
					int Count=0,Ctr=0,mCount=0,Sum=0;
					while(rss.next())
					{
						if(QryFSTID.equals(""))
							QryFSTID="'"+rss.getString(1)+"'";
						else
							QryFSTID=QryFSTID+",'"+rss.getString(1)+"'";

					}
					%>
					<tr>
					<td valign=top >
					<table>
					<%
                    String mcheck="";

					qry="select distinct nvl(B.EMPLOYEENAME,' ')||' ('||B.EMPLOYEECODE||')' EMPNM,B.EMPLOYEEID EMPLOYEEID FROM" +
                            " FACULTYSUBJECTTAGGING A, V#STUDENTLTPDETAIL B WHERE A.EMPLOYEEID=B.EMPLOYEEID " +
                            "AND A.FSTID=B.FSTID  AND  a.INSTITUTECODE='"+mInst+"'  " +
                            "and A.INSTITUTECODE=B.INSTITUTECODE and   nvl(B.deactive,'N')='N' " +
                            "AND NVL(B.STUDENTDEACTIVE,'N')='N' and A.SUBJECTID=B.SUBJECTID " +
                            "AND	A.FSTID in ("+QryFSTID+") order by EMPNM,B.EMPLOYEEID ";
					//out.println(qry);
					rs2=db.getRowset(qry);
						while(rs2.next())
							{
								/*
                             qry1="SELECT 'Y' FROM FACULTYSUBJECTTAGGING WHERE  INSTITUTECODE='"+mInst+"' AND SUBJECTID='"+mSubject+"'" +
                                 " AND SECTIONBRANCH=decode('"+mSection+"','ALL',sectionbranch,'"+mSection+"') AND " +
                                 " SUBSECTIONCODE=decode('"+mSubsection+"','ALL',SUBSECTIONCODE,'"+mSubsection+"') " +
                                 " AND EMPLOYEEID='"+rs.getString("EMPLOYEEID")+"' ";
                                 rs1=db.getRowset(qry1);
                                 if(rs1.next())*/
                                     mcheck="checked";
                                 //else
                                   //  mcheck="";

                            %>
									<tr>
                                      
									<%
										if(!mEmpId.equals(rs2.getString("EMPLOYEEID")))
										{
											mEmpId=rs2.getString("EMPLOYEEID");
											flag=true;
											%>
                                              <td>
										   <INPUT TYPE="CHECKBOX" NAME="Facultychk" <%=mcheck%>
                             value="<%=mEmpId%>" >
											&nbsp;&nbsp;
											<font size=2><%=rs2.getString("EMPNM")%>
											</td>
										<%
										}
										else
										{
											flag=false;
											%>
											<td>&nbsp;''</td>
											<%
										}
											%>

									</tr>
									<%
							}
					%>
					</table>
					</td>


<%
String mEmpId1="";
out.print(mEmpId+"mEmpId");
					qry1="select b.employeeid,  nvl(B.EMPLOYEENAME,' ')||' ('||B.EMPLOYEECODE||')' EMPNM," +
                            "nvl(B.PROGRAMCODE,'')PROGRAMCODE, nvl(A.SECTIONBRANCH,' ')SECBR, " +
                            "nvl(A.SUBSECTIONCODE,'')SUBSEC,b.FSTID FSTID FROM FACULTYSUBJECTTAGGING A, V#STUDENTLTPDETAIL B WHERE " +
                            "A.EMPLOYEEID=B.EMPLOYEEID  AND		A.SECTIONBRANCH=B.SECTIONBRANCH  " +
                            "AND A.PROGRAMCODE=B.PROGRAMCODE AND  nvl(B.deactive,'N')='N' AND" +
                            " NVL(B.STUDENTDEACTIVE,'N')='N' AND	A.SUBSECTIONCODE=B.SUBSECTIONCODE " +
                            "AND A.SEMESTER=B.SEMESTER  and a.INSTITUTECODE='"+mInst+"' " +
                            " and A.INSTITUTECODE=B.INSTITUTECODE AND A.FSTID=B.FSTID AND" +
                            " A.FSTID in ("+QryFSTID+") group by b.employeeid,B.EMPLOYEENAME,B.EMPLOYEECODE," +
                            "B.PROGRAMCODE,A.SECTIONBRANCH,A.SUBSECTIONCODE,B.FSTID" +
                            " ORDER BY EMPNM, SECBR, SUBSEC,PROGRAMCODE";
					rs1=db.getRowset(qry1);
					//out.print(qry1);
					%>
					<td valign=top>
					<table border="0" >
					<%
					while(rs1.next())
					{
						Ctr++;


                       

                        qry="select count(studentid)COUNT1 FROM V#STUDENTLTPDETAIL  where" +
                                "  FSTID='"+rs1.getString("FSTID")+"' " +
                                " AND INSTITUTECODE='"+mInst+"' " +
                                "and  nvl(deactive,'N')='N' AND NVL(STUDENTDEACTIVE,'N')='N'  ";
							//out.println(qry);
							rs=db.getRowset(qry);
							%>
							<tr>
							<%
							while(rs.next())
							{
                                 if(!mEmpId1.equals(rs1.getString("EMPLOYEEID")))
										{
                                      mEmpId1=rs1.getString("EMPLOYEEID");
								Count=rs.getInt("COUNT1");
								
									mCount=rs.getInt("COUNT1");
									%>
                                    <td width="80px" align="center">
                           <INPUT TYPE="checkbox" NAME="regbatch<%=Ctr%>"
                           id="regbatch<%=Ctr%>" checked value="Y">
                                    </td>
									<td  width="80px" align="center" ><font size=2>[<%=Count%>]</font></td>									<%

								

									mProg=rs1.getString("PROGRAMCODE");
									flag=true;
									%>
									<td ALIGN='CENTER'  width="80px"><font size=2><%=rs1.getString("PROGRAMCODE")%>
									</font></td>
									<%
								

								
									mSecBranch=rs1.getString("SECBR");
									mSubCode=rs1.getString("SUBSEC");
								
									%>

									<td ALIGN='CENTER'  width="80px" ><font size=2>
									(<%=rs1.getString("SECBR")%>-<%=rs1.getString("SUBSEC")%>)</font></td>
									<%
								

                            }
							}
                           
								%>
						</tr>

						<%
					}
					//out.print("Subject"+mSubj);
					%>
					</table>

					<table >
					<tr><td align='center'><font color=Green size=3><b>Total Students: <%=Ctr%> </b></font>
					</td></tr>
					</table>
					<input type=hidden name="Subject" id="Subject" value="<%=mSubj%>">

					<input type=hidden name="FSTID" id="FSTID" value="<%=QryFSTID%>">
					<input type=hidden name='INSTITUTECODE' id='INSTITUTECODE' value='<%=mInst%>'>
					</form>

					<%
				} // Mandatory Items cannot be null
				else
				{
					out.print("<br><img src='../../Images/Error1.jpg'>");
					out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> All Items are mandatory</font> <br>");
				}
			}
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
			</font>	<br>	<br>	<br>	<br>
			<%
		}
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
%>