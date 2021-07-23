<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*,java.util.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%@page contentType="text/html"%>
<body aLink=#ff00ff bgcolor=#fce9c5>
<%
try
{
	GlobalFunctions gb =new GlobalFunctions();
	OLTEncryption enc=new OLTEncryption();
	DBHandler db=new DBHandler();
	ResultSet rs=null, rssub=null, rsm=null;
	String mMemberID="",mMemberType="",mDMemberType="",mMemberName="",mMemberCode="",mInst="",mDMemberCode="",mCheckFstid="";
        String mComp="", mSelf="", mIC="", mEC="", mSC="", mList="", mOrder="", mEvent="", mSE="", qry="", qry1="", mMOP="";
        int len=0, pos=0, ctr=0;
        double mWeight=0, mMaxmarks=0;
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

        if(session.getAttribute("Click")!=null)
            mSelf=session.getAttribute("Click").toString().trim();
        else
            mSelf="";
        if(session.getAttribute("InstCode")!=null)
            mIC=session.getAttribute("InstCode").toString().trim();
        else
            mIC="";
        if(session.getAttribute("Exam")!=null)
            mEC=session.getAttribute("Exam").toString().trim();
        else
            mEC="";
        if(session.getAttribute("Subject")!=null)
            mSC=session.getAttribute("Subject").toString().trim();
        else
            mSC="";
        if(session.getAttribute("listorder")!=null)
            mList=session.getAttribute("listorder").toString().trim();
        else
            mList="EnrollNo";
        if(session.getAttribute("order")!=null)
            mOrder=session.getAttribute("order").toString().trim();
        else
            mOrder="";
        if(session.getAttribute("Event")!=null)
            mEvent=session.getAttribute("Event").toString().trim();
        else
            mEvent="";

        len=mEvent.length();
        pos=mEvent.indexOf("#");
        if(pos>0)
        {
           mSE=mEvent.substring(0,pos);
        }
        else
        {
            mSE=mEvent.toString().trim();
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
		qry="Select WEBKIOSK.ShowLink('399','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{
			response.setContentType("application/vnd.ms-excel");
			//response.setContentType("application/msword");
			//response.setHeader("Content-Disposition","attachment; filename=GradeCalculationBeforedraft.xls");
			%>
			<table ALIGN=CENTER bottommargin=0  topmargin=0>
				<tr>
					<TD colspan=7 align=middle>
					<font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Marks Entry Student List</b></font>
					</td>
				</tr>
			</TABLE>
                        <br>
			<%
                        /***************************************************************************************************************/
			String mSubcode="", qrysub="", mNam="";
			qrysub="select subject,subjectcode from subjectmaster where InstituteCode='"+mIC+"' and subjectID='"+mSC+"' and nvl(deactive,'N')='N' ";
			//System.out.println(qrysub);
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
			<table rules="groups">
			<tr>
                        <td>&nbsp;</td>
                        <%
                        if(mSelf.equals("Self"))
                        {
                            %>
                            <td nowrap colspan="1"><b>Faculty Name : </td>
                            <%
                        }
                        else
                        {
                            %>
                            <td nowrap colspan="1"><b>Coordinator Name : </td>
                            <%
                        }
                        %>
			<td nowrap colspan="4"><font color=dark brownt><%=name%>&nbsp;(<%=mCode%>)</font></td>
                        </tr>
                        <tr>
                        <td>&nbsp;</td>
			<td nowrap colspan="1"><b>Date & Time : </td>
			<td nowrap colspan="4"><font color=dark brownt><%=time%></font></td>
			</tr>
			<tr>
                        <td>&nbsp;</td>
			<td nowrap colspan="1"><b>Subject : </td>
			<td nowrap colspan="4"><font color=dark brownt><%=mNam%>(<%=mSubcode%>)</font></td>
			</tr>
			<tr>
                        <td>&nbsp;</td>
			<td nowrap colspan="1"><b>Exam Code : </td>
			<td nowrap colspan="4"><font color=dark brownt><%=mEC%></font></td>
			</tr>
			<tr>
                        <td>&nbsp;</td>
			<td nowrap colspan="1"><b>Event-Subevent : </td>
			<td nowrap colspan="4"><font color=dark brownt><%=mEvent%></font></td>
                        </tr>
			<tr><td colspan="6">&nbsp;</td></tr>
			<%
                        if(mSelf.equals("Self"))
                        {
                            qry="select fstid,nvl(studentid,' ')studentid,nvl(studentname,' ')StudentName, nvl(enrollmentno,' ')EnrollNo, nvl(semester,0)Semester,";
                            qry=qry+" nvl(programcode,' ')||' ('||nvl(SECTIONBRANCH,' ')||' - '||subsectioncode||')' Course from V#EXAMEVENTSUBJECTTAGGING ";
                            qry=qry+" where institutecode='"+mIC+"' and nvl(DEACTIVE,'N')='N' and nvl(PROCEEDSECOND,'N')='N' and nvl(locked,'N')='N' and nvl(PUBLISHED,'N')='N' and ";
                            qry=qry+" examcode='"+mEC+"' and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P' ) and subjectID='"+mSC+"' ";
                            //qry=qry+" AND employeeid='"+mChkMemID+"' and facultytype=decode('"+mDMemberType+"','E','I','E')";
                            qry=qry+" AND ((EMPLOYEEID=(Select '"+mChkMemID+"' EmployeeID from dual)) OR (fstid in (select fstid from FACULTYSUBJECTTAGGING where companycode='"+mComp+"' and institutecode='"+mIC+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mChkMemID+"')) and facultytype=decode('"+mDMemberType+"','E','I','E'))";
                            //qry=qry+" AND employeeid in (Select '"+mChkMemID+"' EmployeeID from dual UNION Select EmployeeID from FacultySubjectTagging where FSTID in (SELECT FSTID FROM MULTIFACULTYSUBJECTTAGGING WHERE COMPANYCODE='"+mComp+"' and INSTITUTECODE='"+mIC+"' and FACULTYTYPE=decode('"+mDMemberType+"','E','I','E') and EMPLOYEEID='"+mChkMemID+"')) and facultytype=decode('"+mDMemberType+"','E','I','E')";
                            qry=qry+" AND EVENTSUBEVENT='"+mEvent+"' " ;
                            qry=qry+" GROUP BY fstid,studentid,StudentName,enrollmentno,Semester, programcode,SECTIONBRANCH, subsectioncode";
                            qry=qry+" order by "+mList+ " "+mOrder+ " ";

                            qry1="select WEIGHTAGE, MARKSORPERCENTAGE, MAXMARKS from V#EXAMEVENTSUBJECTTAGGING  ";
                            qry1+=" where institutecode='"+mIC+"' and  examcode='"+mEC+"' ";
                            qry1+=" AND ((EMPLOYEEID=(Select '"+mChkMemID+"' EmployeeID from dual)) OR (fstid in (select fstid from FACULTYSUBJECTTAGGING where companycode='"+mComp+"' and institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mChkMemID+"')) and facultytype=decode('"+mDMemberType+"','E','I','E'))";
                            qry1+=" And EVENTSUBEVENT='"+mEvent+"' and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P') and subjectID='"+mSC+"' AND  NVL (deactive, 'N') = 'N' ";

                        }
                	else if(!mSelf.equals("Self"))
                        {
                            qry="select fstid,nvl(studentid,' ')studentid,nvl(studentname,' ')StudentName, nvl(enrollmentno,' ')EnrollNo, nvl(semester,0)Semester,";
                            qry=qry+" nvl(programcode,' ')||' ('||nvl(SECTIONBRANCH,' ')||' - '||subsectioncode||')' Course from V#EXAMEVENTSUBJECTTAGGING ";
                            qry=qry+" where institutecode='"+mIC+"' and nvl(DEACTIVE,'N')='N' and nvl(PROCEEDSECOND,'N')='N' and nvl(locked,'N')='N' and nvl(PUBLISHED,'N')='N' and ";
                            qry=qry+" examcode='"+mEC+"'  and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P' ) and subjectID='"+mSC+"' ";
                            qry=qry+" And EVENTSUBEVENT='"+mEvent+"' " ;
                            qry=qry+" AND FSTID IN (SELECT FSTID FROM EX#SUBJECTGRADECOORDINATOR WHERE COMPANYCODE='"+mComp+"' and INSTITUTECODE='"+mIC+"' and FACULTYTYPE=decode('"+mDMemberType+"','E','I','E') and FACULTYID='"+mChkMemID+"')";
                            qry=qry+" GROUP BY fstid,studentid,StudentName,enrollmentno,Semester, programcode,SECTIONBRANCH, subsectioncode";
                            qry=qry+" order by "+mList+ " "+mOrder+ " ";

                            qry1="select  WEIGHTAGE, MARKSORPERCENTAGE, MAXMARKS from V#EXAMEVENTSUBJECTTAGGING  ";
                            qry1+=" where institutecode='"+mIC+"' and  examcode='"+mEC+"' ";
                            qry1+=" And EVENTSUBEVENT='"+mEvent+"'  ";
                            qry1+=" and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P') and subjectID='"+mSC+"' AND  NVL (deactive, 'N') = 'N'";
                	}
                        //System.out.println(qry);
                        rsm=db.getRowset(qry1);
                        if(rsm.next())
                        {
                                mMOP=rsm.getString("MARKSORPERCENTAGE");
                                mMaxmarks=rsm.getDouble("MAXMARKS");
                                mWeight=rsm.getDouble("WEIGHTAGE");
                        }
                        if(mMOP.equals("M"))
                        {
                                %>
                                <tr><td colspan='5' align='center' nowrap>
                                <FONT color=navy face=Arial size=2><STRONG>Mode of Entry:&nbsp;</STRONG>Marks</FONT>
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <FONT color=navy face=Arial size=2><STRONG>Maximum Marks: </STRONG><%=mMaxmarks%></FONT>
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <FONT color=navy face=Arial size=2><STRONG>Weightage: </STRONG><%=mWeight%></FONT>
                                </td></tr>
                                <%
                        }
                        else
                        {
                                %>
                                <tr><td colspan='5' align='center' nowrap>
                                <FONT color=navy face=Arial size=2><STRONG>Mode of Entry:&nbsp;</STRONG></FONT>Percentage
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <FONT color=navy face=Arial size=2><STRONG>Maximum Marks:&nbsp;</STRONG><%=mMaxmarks%></FONT>
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <FONT color=navy face=Arial size=2><STRONG>Weightage: </STRONG><%=mWeight%></FONT>
                                </td></tr>
                                <%
                        }
                        %>
                        </table>
                        <%
                        //System.out.println(qry);
                        rs = db.getRowset(qry);
                        %>
                        <Table ALIGN="center"  rules="groups" border=1 BGCOLOR="white">
                        <%
                        while(rs.next())
                        {
                            ctr++;
                            if(ctr==1)
                            {
                                %>
                                <tr bgcolor="#ff8c00" height=60px>
                                    <td align="center" nowrap colspan=6><font face=arial size=3 color=blue><STRONG>Student Label for Marks Entry (Before Saving)</STRONG></font></td>
                                </tr>
                                <tr bgcolor="#ff8c00" height=60px>
                                    <td align="left" nowrap><font face=arial size=3 color=white><STRONG>Sr. No.</STRONG></font></td>
                                    <td align="left" nowrap><font face=arial size=3 color=white><STRONG>Enrollment No.</STRONG></font></td>
                                    <td align="left" nowrap><font face=arial size=3 color=white><STRONG>Student Name</STRONG></font></td>
                                    <td align="left" nowrap><font face=arial size=3 color=white><STRONG><%=mEvent%> Marks</STRONG></font></td>
                                    <td align="left" nowrap><font face=arial size=3 color=white><STRONG>Course(Section/Branch)</STRONG></font></td>
                                    <td align="left" nowrap><font face=arial size=3 color=white><STRONG>Sem.</STRONG></font></td>
                                </tr>
                                <%
                            }
                            %>
                            <tr>
                                <td align="right" nowrap><font face=arial size=2><%=ctr%>. &nbsp; &nbsp;</font></td>
                                <td align="left" nowrap><font face=arial size=2><%=rs.getString("EnrollNo")%></font></td>
                                <td align="left" nowrap><font face=arial size=2><%=rs.getString("StudentName")%></font></td>
                                <td align="center" nowrap><font face=arial size=2 bgcolor=white>&nbsp;</font></td>
                                <td align="left" nowrap><font face=arial size=2><%=rs.getString("Course")%></font></td>
                                <td align="center" nowrap><font face=arial size=2><%=rs.getString("Semester")%></font></td>
                            </tr>
                            <%
                        }
                        %>
                        </Table>
                        <table align="center">
			<tr><td colspan="6">&nbsp;</td></tr>
                        <tr height=100px>
                        <td align="left" nowrap colspan=2><font face=arial size=3 color=black><STRONG>Enter 'A' - for Absent</STRONG></font></td>
                        <td align="center" nowrap colspan=2><font face=arial size=3 color=black><STRONG>Enter 'D' - for Detained</STRONG></font></td>
                        <td align="right" nowrap colspan=2><font face=arial size=3 color=black><STRONG>Enter Marks Between '0' to '<%=mMaxmarks%>'</STRONG></font></td>
                        </tr>
                        </Table>
                        <%
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