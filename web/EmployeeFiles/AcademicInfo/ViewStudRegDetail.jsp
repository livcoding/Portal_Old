<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%
DBHandler db = new DBHandler();
ResultSet rs = null;
GlobalFunctions gb = new GlobalFunctions();
String qry = "";
int CTR=0, TotStudCount=0;
String mMemberID="", mDMemberID="", mMemberType="", mDMemberType="", mMemberCode="", mDMemberCode="", mMemberName="";
String mInst = "", mComp = "", mSrcType = "", mRightsID="";
String mViewType="", qryexam="", mProgram="", mBranch="", mSemester="", mRegCode="", TopMessage="";

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
			if(request.getParameter("ViewType")==null)
				mViewType="";
			else
				mViewType=request.getParameter("ViewType").toString().trim();

			if(request.getParameter("ExamCode")==null)
				qryexam="";
			else
				qryexam=request.getParameter("ExamCode").toString().trim();

			if(request.getParameter("Program")==null)
				mProgram="";
			else
				mProgram=request.getParameter("Program").toString().trim();

			if(request.getParameter("Branch")==null)
				mBranch="";
			else
				mBranch=request.getParameter("Branch").toString().trim();

			if(request.getParameter("Sem")==null)
				mSemester="";
			else
				mSemester=request.getParameter("Sem").toString().trim();

			//out.print(mViewType+" "+qryexam+" "+mProgram+" "+mBranch+" "+mSemester);

			qry="Select RegCode from StudentRegistration where COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+qryexam+"'";
			rs=db.getRowset(qry);
			if(rs.next())
				mRegCode=rs.getString("RegCode");

			if(mViewType.equals("ALW"))
			{
				TopMessage="Registration Allowed";
				qry="Select nvl(EnrollmentNo,' ')EnrollmentNo, StudentName From StudentMaster "
                                        + "where institutecode='"+mInst+"' and nvl(deactive,'N')='N' and studentid in (select studentid from StudentRegistration where COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+qryexam+"' AND NVL(REGALLOW,'N')='Y' And ProgramCode='"+mProgram+"' And SectionBranch='"+mBranch+"' And Semester='"+mSemester+"') ORDER BY EnrollmentNo";
			}
			else if(mViewType.equals("CNF"))
			{
				TopMessage="Registration Confirmed";
				qry="Select nvl(EnrollmentNo,' ')EnrollmentNo, StudentName From StudentMaster"
                                        + " where institutecode='"+mInst+"' and nvl(deactive,'N')='N' and studentid in (select studentid from StudentRegistration "
                                        + "where COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+qryexam+"' AND NVL(REGALLOW,'N')='Y' AND NVL(REGCONFIRMATION,'N')='Y' And ProgramCode='"+mProgram+"' And SectionBranch='"+mBranch+"' And Semester='"+mSemester+"') ORDER BY EnrollmentNo";
			}
			else if(mViewType.equals("NCNF"))
			{
				TopMessage="Registration Not Confirmed";
				qry="Select nvl(EnrollmentNo,' ')EnrollmentNo, StudentName From StudentMaster "
                                        + "where institutecode='"+mInst+"' and nvl(deactive,'N')='N' and studentid in (select studentid from StudentRegistration where COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+qryexam+"' AND NVL(REGALLOW,'N')='Y' AND NVL(REGCONFIRMATION,'N')='N' And ProgramCode='"+mProgram+"' And SectionBranch='"+mBranch+"' And Semester='"+mSemester+"') ORDER BY EnrollmentNo";
			}
			else if(mViewType.equals("PAID"))
			{
				TopMessage="Fees Paid";
				qry="Select nvl(EnrollmentNo,' ')EnrollmentNo, StudentName From StudentMaster "
                                        + "where institutecode='"+mInst+"' and nvl(deactive,'N')='N' and studentid in (select studentid "
                                        + "from StudentRegistration where COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+qryexam+"' AND NVL(REGALLOW,'N')='Y' AND NVL(FEESPAID,'N')='Y' And ProgramCode='"+mProgram+"' And SectionBranch='"+mBranch+"' And Semester='"+mSemester+"') ORDER BY EnrollmentNo";
			}
			rs=db.getRowset(qry);
			%>
	            <table align=center>
                     <tr><td align="center">
                        <font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: Arial"><B><U>List of <%=TopMessage%> Students </U></b></font>
                    </td></tr>
                    </table>
			<BR>
			<table bgcolor="white" border=2 bordercolor="navy" align=center>
			<tr bgcolor=white>
			<td Nowrap><Font color=navy face=arial size=2><B>Registration Code - </B><%=mRegCode%></font></td>
			<td Nowrap><Font color=navy face=arial size=2><B>Program - </B><%=mProgram%></font></td>
			<td Nowrap><Font color=navy face=arial size=2><B>Branch - </B><%=mBranch%></font></td>
			</tr>
			</table>
			<BR>
			<table bgcolor=#fce9c5 class="sort-table" id="table-2" align=center topmargin=0 cellspacing=0 cellpadding=0 border=1>
			<%
			while (rs.next())
			{
				CTR++;
				if(CTR==1)
				{
					%>
					<THEAD>
					<TR bgcolor="#ff8c00">
					<TD align="center" nowrap><b><font color=white face=Arial size=2 title="Serial Number">SNo.</font></b></TD>
					<TD align="center" nowrap><b><font color=white face=Arial size=2 title="Serial Number">Enrollment No.</font></b></TD>
					<TD align="center" nowrap><b><font color=white face=Arial size=2 title="Serial Number">Student Name</font></b></TD>
					</TR>
					</THEAD>
					<TBODY>
					<%
				}
				%>
				<TR>
				<TD bgcolor=white align=left><Font face=Arial size=2><B><%=CTR%></B>.</Font></TD>
				<TD bgcolor=white align=left><Font face=Arial size=2><%=rs.getString("EnrollmentNo")%></Font></TD>
				<TD bgcolor=white align=left><Font face=Arial size=2><%=rs.getString("StudentName")%></Font></TD>
				</TR>
				<%
			}
			%>
			</TBODY>
			</TABLE>
			<%
			if(CTR==0)
			{
				%>
				<BR><BR><BR><Center><img src='../../Images/Error1.jpg'>&nbsp;<Font color=red face=Arial><B>Sorry! No such Data found</B></font></Center>
				<%
			}
			else
			{
				%>
				<form name="frm2" id="frm2" method="post" action="ViewStudRegSummaryInExcel.jsp?DataType=DET">
				<CENTER>
            	      <INPUT NAME="submit" Type="submit" Value="Get In Excel Format">
                  	<input type=hidden name='ViewType' id='ViewType' value="<%=mViewType%>">
                  	<input type=hidden name='ExamCode' id='ExamCode' value="<%=qryexam%>">
                  	<input type=hidden name='Program' id='Program' value="<%=mProgram%>">
                  	<input type=hidden name='Branch' id='Branch' value="<%=mBranch%>">
                  	<input type=hidden name='Sem' id='Sem' value="<%=mSemester%>">
				</CENTER>
				</form>
				<%
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
		//-----------------------------
		//---Enable Security Page Level
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