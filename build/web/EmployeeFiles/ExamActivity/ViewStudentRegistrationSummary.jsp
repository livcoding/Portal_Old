<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%

DBHandler db = new DBHandler();
ResultSet rs = null, rss = null;
GlobalFunctions gb = new GlobalFunctions();
String qry = "";
int CTR=0, TotStudAllow=0, TotStudConf=0, TotStudNotConf=0, TotalStudFeePaid=0, TotAllow=0, TotRegConf=0, TotRegNConf=0, TotFeePaid=0;
String mMemberID="", mDMemberID="", mMemberType="", mDMemberType="", mMemberCode="", mDMemberCode="", mMemberName="";
String mInst = "", mComp = "", mSrcType = "", mRightsID="", qsysdate="", mOldData="";
String mExam = "", qryexam="", mProgram="", mBranch="", mSemester="";
String mDept="", mDeptName="";

if (session.getAttribute("InstituteCode") == null) 
	mInst = "";
else
	mInst = session.getAttribute("InstituteCode").toString().trim();

if (session.getAttribute("CompanyCode") == null)
	mComp = "";
else
	mComp = session.getAttribute("CompanyCode").toString().trim();

if (session.getAttribute("MemberID") == null)
	mMemberID = "";
else
	mMemberID = session.getAttribute("MemberID").toString().trim();

if (session.getAttribute("MemberID") == null)
	mMemberID = "";
else
	mMemberID = session.getAttribute("MemberID").toString().trim();

if (session.getAttribute("MemberType") == null)
	mMemberType = "";
else
	mMemberType = session.getAttribute("MemberType").toString().trim();

if (session.getAttribute("MemberName") == null)
	mMemberName = "";
else
	mMemberName = session.getAttribute("MemberName").toString().trim();

if (session.getAttribute("MemberCode") == null)
	mMemberCode = "";
else
	mMemberCode = session.getAttribute("MemberCode").toString().trim();

if (request.getParameter("SrcType") == null)
	mSrcType = "A";
else
	mSrcType = request.getParameter("SrcType").toString().trim();

if (mSrcType.equals("I")) 
	mRightsID = "252";
else if (mSrcType.equals("A")) 
	mRightsID = "252";
else if (mSrcType.equals("H")) 
	mRightsID = "252";

String mHead = "";
if (session.getAttribute("PageHeading") != null && !session.getAttribute("PageHeading").equals(""))
	mHead = session.getAttribute("PageHeading").toString().trim();
else
	mHead = "JIIT ";

%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Course-Branch wise Student Registration Summary] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

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
	if (!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
	{
      	OLTEncryption enc = new OLTEncryption();
		mDMemberID = enc.decode(mMemberID);
            mDMemberCode = enc.decode(mMemberCode);
            mDMemberType = enc.decode(mMemberType);

		// out.print(mDMemberType);

            String mChkMemID = enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType = enc.decode(session.getAttribute("MemberType").toString().trim());
            String mIPAddress = session.getAttribute("IPADD").toString().trim();
            String mRole = enc.decode(session.getAttribute("ROLENAME").toString().trim());
            ResultSet RsChk = null;
            //-----------------------------
            //-- Enable Security Page Level
            //-----------------------------
            qry = "Select WEBKIOSK.ShowLink('" + mRightsID + "','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";
            //out.print(qry);
            RsChk = db.getRowset(qry);
            if (RsChk.next() && RsChk.getString("SL").equals("Y")) 
		{
			qry = "select to_Char(Sysdate,'dd-mm-yyyy hh:mi PM') date1 from dual";
			rs = db.getRowset(qry);
			if (rs.next()) 
			{
                  	qsysdate = rs.getString(1);
			}
			else
			{
                        qsysdate = "";
                  }
			//----------------------
			%>
			<form name="frm1" id="frm1" method="get">
            	<input id="x" name="x" type=hidden>
	            <table align=center><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: Arial"><B><U>Student Registration Summary</U></b></font></TABLE>
      	      <table id=id2 cellpadding=1 cellspacing=1  align=center rules=groups border=2>

            	<!--****Exam Code****-->

			<tr><td nowrap>
			<FONT color=black face=Arial size=2><b>Registration Code</b></FONT>
                	<%
                  try
			{
				
				//*************01/02/2010 added in the qry=NVL(LOCKEXAM,'N')='N'****************
				
				qry = " Select REGCODE RegCode, ExamCode Exam, EXAMPERIODFROM FROM (";
				qry += " Select A.REGCODE REGCODE, A.ExamCode ExamCode, B.EXAMPERIODFROM EXAMPERIODFROM from StudentRegistration A, ExamMaster B";
				qry += " Where A.INSTITUTECODE=B.INSTITUTECODE  AND NVL(LOCKEXAM,'N')='N' and A.EXAMCODE=B.EXAMCODE AND B.INSTITUTECODE='"+mInst+"' AND nvl(B.Deactive,'N')='N'";
				qry += " Group By A.REGCODE, A.ExamCode, B.EXAMPERIODFROM order by EXAMPERIODFROM DESC) where rownum<=8 order by 2 desc";
				//out.print(qry);
				rs = db.getRowset(qry);
				if (request.getParameter("x") == null) 
					{
                        	%>
	                        <Select Name=Exam tabindex="0" id="Exam" style="WIDTH: 120px">
      				<%
                              while (rs.next()) 
					{
                                    mExam = rs.getString("Exam");
                                    if (qryexam.equals("")) 
						{
							qryexam = mExam;
							%>
							<OPTION Selected Value =<%=mExam%>><%=rs.getString("RegCode")%></option>
							<%
						}
						else
						{
							%>
							<OPTION Value =<%=mExam%>><%=rs.getString("RegCode")%></option>
							<%
						}
                              }
					%>
	                        </select>
      	                  <%
            		}
				else
				{
		            	%>
            		      <select name=Exam tabindex="0" id="Exam" style="WIDTH: 120px">
					<%
					while (rs.next())
					{
                                   	mExam = rs.getString("Exam");
	                        	if (mExam.equals(request.getParameter("Exam").toString().trim())) 
						{
	                              	qryexam = mExam;
      			                  %>
                        			<OPTION selected Value =<%=mExam%>><%=rs.getString("RegCode")%></option>
			                        <%
                  			}
						else
						{
			            		%>
                  			      <OPTION Value =<%=mExam%>><%=rs.getString("RegCode")%></option>
			                        <%
						}
                        	}
					%>
		                  </select>
            		      <%
                        }
			}
			catch (Exception e)
			{
                       	// out.println("Error Msg");
			}
			%>
			&nbsp;
			<Input Type=submit name=submit value="Show/Refresh"/>
			</td></tr></table>
			<BR>
			<CENTER><Font face=arial size=2 color=navy><B>Summary as on : <U><%=qsysdate%></U></B></FONT></CENTER>
			<table bgcolor=#fce9c5 class="sort-table" id="table-2" align=center topmargin=0 cellspacing=0 cellpadding=0 border=1 rules=rows>
			<%

			if(request.getParameter("Exam")==null)
				qryexam=qryexam;
			else
				qryexam=request.getParameter("Exam").toString().trim();

			//out.print("Default Exam Code - "+qryexam);

			qry="SELECT DISTINCT PROGRAMCODE, SECTIONBRANCH, SEMESTER FROM STUDENTREGISTRATION WHERE COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+qryexam+"' AND NVL(REGALLOW,'N')='Y' ORDER BY PROGRAMCODE, SECTIONBRANCH, SEMESTER";
			//out.print(qry);
			rs=db.getRowset(qry);
			while(rs.next())
			{
				if(CTR==0)
				{
					%>
					<THEAD>
					<TR bgcolor="#ff8c00">
					<TD align="center" nowrap><b><font color=white face=Arial size=2 title="Serial Number">SNo.</font></b></TD>
					<TD align="center" nowrap><b><font color=white face=Arial size=2 title="Program Running in the selected Exam Code">Program</font></b></TD>
					<TD align="center" nowrap><b><font color=white face=Arial size=2 title="Branch Running in the selected Exam Code / Program">Branch</font></b></TD>
					<TD align="center" nowrap><b><font color=white face=Arial size=2 title="Semester Running in the selected Exam Code / Program / Branch">Semester</font></b></TD>
					<TD align="center" nowrap><b><font color=white face=Arial size=2 title="Total Student whose RegAllow='Y'">Total Student</font></b></TD>
					<TD align="center" nowrap><b><font color=white face=Arial size=2 title="Total Student whose RegConfirmation='Y'">Registered</font></b></TD>
					<TD align="center" nowrap><b><font color=white face=Arial size=2 title="Total Student whose RegConfirmation='N'">Not Registered</font></b></TD>
					<TD align="center" nowrap><b><font color=white face=Arial size=2 title="Total Student whose Fee is Paid">Fee Paid</font></b></TD>
					</TR>
					</THEAD>
					<TBODY>
					<%
				}
				mProgram=rs.getString(1);
				mBranch=rs.getString(2);
				mSemester=rs.getString(3);

				qry="select count(*)TotStudAllow from StudentRegistration Where COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+qryexam+"' AND NVL(REGALLOW,'N')='Y' And ProgramCode='"+mProgram+"' And SectionBranch='"+mBranch+"' And Semester='"+mSemester+"' Group By PROGRAMCODE, SECTIONBRANCH, SEMESTER ";
				//out.print(qry);
				rss=db.getRowset(qry);
				if(rss.next())
					TotStudAllow=rss.getInt("TotStudAllow");

				qry="select count(*)TotStudConf from StudentRegistration Where COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+qryexam+"' AND NVL(REGALLOW,'N')='Y' AND NVL(REGCONFIRMATION,'N')='Y' And ProgramCode='"+mProgram+"' And SectionBranch='"+mBranch+"' And Semester='"+mSemester+"' Group By PROGRAMCODE, SECTIONBRANCH, SEMESTER ";
				//out.print(qry);
				rss=db.getRowset(qry);
				if(rss.next())
					TotStudConf=rss.getInt("TotStudConf");

				qry="select count(*)TotStudNotConf from StudentRegistration Where COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+qryexam+"' AND NVL(REGALLOW,'N')='Y' AND NVL(REGCONFIRMATION,'N')='N' And ProgramCode='"+mProgram+"' And SectionBranch='"+mBranch+"' And Semester='"+mSemester+"' Group By PROGRAMCODE, SECTIONBRANCH, SEMESTER ";
				//out.print(qry);
				rss=db.getRowset(qry);
				if(rss.next())
					TotStudNotConf=rss.getInt("TotStudNotConf");

				qry="select count(*)TotalStudFeePaid from StudentRegistration Where COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+qryexam+"' AND NVL(REGALLOW,'N')='Y' AND NVL(FEESPAID,'N')='Y' And ProgramCode='"+mProgram+"' And SectionBranch='"+mBranch+"' And Semester='"+mSemester+"' Group By PROGRAMCODE, SECTIONBRANCH, SEMESTER ";
				//out.print(qry);
				rss=db.getRowset(qry);
				if(rss.next())
					TotalStudFeePaid=rss.getInt("TotalStudFeePaid");

				CTR++;

				%>
				<TR>
				<TD bgcolor=white align=left><Font face=Arial size=2><B><%=CTR%></B>.</Font></TD>
				<%
				if(!mOldData.equals(mProgram))
				{
					mOldData=mProgram;
					%>
					<TD bgcolor=white align=left><Font face=Arial size=2><%=mProgram%></Font></TD>
					<%
				}
				else
				{
					%>
					<TD bgcolor=white align=left><Font face=Arial size=2>&nbsp;</Font></TD>
					<%
				}
				%>
				<TD bgcolor=white align=left><Font face=Arial size=2><%=mBranch%></Font></TD>
				<TD bgcolor=white align=center><Font face=Arial size=2><%=mSemester%></Font></TD>
				<TD bgcolor=white align=center><a href="ViewStudRegDetail.jsp?ViewType=ALW&amp;ExamCode=<%=qryexam%>&amp;Program=<%=mProgram%>&amp;Branch=<%=mBranch%>&amp;Sem=<%=mSemester%>" target=_new><Font face=Arial color=blue size=2><%=TotStudAllow%></Font></a></TD>
				<TD bgcolor=white align=center><a href="ViewStudRegDetail.jsp?ViewType=CNF&amp;ExamCode=<%=qryexam%>&amp;Program=<%=mProgram%>&amp;Branch=<%=mBranch%>&amp;Sem=<%=mSemester%>" target=_new><Font face=Arial color=blue size=2><%=TotStudConf%></Font></a></TD>
				<TD bgcolor=white align=center><a href="ViewStudRegDetail.jsp?ViewType=NCNF&amp;ExamCode=<%=qryexam%>&amp;Program=<%=mProgram%>&amp;Branch=<%=mBranch%>&amp;Sem=<%=mSemester%>" target=_new><Font face=Arial color=blue size=2><%=TotStudNotConf%></Font></a></TD>
				<TD bgcolor=white align=center><a href="ViewStudRegDetail.jsp?ViewType=PAID&amp;ExamCode=<%=qryexam%>&amp;Program=<%=mProgram%>&amp;Branch=<%=mBranch%>&amp;Sem=<%=mSemester%>" target=_new><Font face=Arial color=blue size=2><%=TotalStudFeePaid%></Font></a></TD>
				</TR>
				<%
				TotAllow=TotAllow+TotStudAllow;
				TotRegConf=TotRegConf+TotStudConf;
				TotRegNConf=TotRegNConf+TotStudNotConf;
				TotFeePaid=TotFeePaid+TotalStudFeePaid;

				TotStudAllow=0;
				TotStudConf=0;
				TotStudNotConf=0;
				TotalStudFeePaid=0;
			}
			%>
			<TR>
			<TD bgcolor=white align=right colspan=4><Font Color=Black face=Arial size=2><B>Total Count - </B></Font></TD>
			<TD bgcolor=white align=center><Font Color=Blue face=Arial size=2><B><%=TotAllow%></B></Font></TD>
			<TD bgcolor=white align=center><Font Color=Green face=Arial size=2><B><%=TotRegConf%></B></Font></TD>
			<TD bgcolor=white align=center><Font Color=Red face=Arial size=2><B><%=TotRegNConf%></B></Font></TD>
			<TD bgcolor=white align=center><Font Color=Green face=Arial size=2><B><%=TotFeePaid%></B></Font></TD>
			</TR>
			</TBODY>
			</TABLE>
			<Table align=center cellpadding=0 cellspacing=0 border=1 bordercolor=transparent><tr bgcolor=transparent><td align=center><font color=blue><a style="cursor:hand" onClick="window.print();"><img width=30 height=30 src="../../Images/printer.gif"></a></font></TD></TR></TABLE>
			</form>

			<form name="frm2" id="frm2" method="post" action="ViewStudRegSummaryInExcel.jsp?DataType=SUM">
			<CENTER>
                  <INPUT NAME="submit" Type="submit" Value="Get In Excel Format">
                  <input type=hidden name='ExamCode' id='ExamCode' value="<%=qryexam%>">
			</CENTER>
			</form>

			<%

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
	}
	else
	{
           	out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
      }
} catch (Exception e)
{
}
%>
</body>
</html>