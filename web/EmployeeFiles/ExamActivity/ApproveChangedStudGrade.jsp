



<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
        DBHandler db = new DBHandler();
        ResultSet rs = null, rss = null;
        GlobalFunctions gb = new GlobalFunctions();
        String qry = "";
        String mStatus = "";
        int ctr = 0;
        String mMemberID = "";
        String mDMemberID = "";
        String mMemberType = "";
        String mDMemberType = "";
        String mMemberCode = "";
        String mDMemberCode = "";
        String mMemberName = "";
        String mInstitute = "";
        String mExam = "", QryExam = "", QryStatus = "";
        String mName1 = "", mName2 = "", mName3 = "", mName4 = "";
        int mFlag = 0;
        String mProgCode = "", QryProgCode = "", QryAcadYr = "", mAcadYr = "", QryStudID = "", mStudID = "", QryGrdCrt = "";
        String mInst = "", mEmpID = "";
        String OldEnNo = "", OldSubj = "", OldLTPVal = "";
        String sname = "", qry2 = "", qry3 = "", qry4 = "";
        ResultSet rs2 = null, rs3 = null, rs4 = null;
        String Studid = "", mDetained = "";
        int Rejected = 0, mCount1 = 0;
        String mDateFrom = "", mDateTo = "";
        String param = "";
        if (request.getParameter("x") == null) {
            qry = "select to_char(sysdate-6,'dd-mm-yyyy'),to_char(sysdate,'dd-mm-yyyy') from dual";
            rs = db.getRowset(qry);
            if (rs.next()) {
                mDateFrom = rs.getString(1);
            }
            mDateTo = rs.getString(2);
        } else {

            if (request.getParameter("DATE1") == null && request.getParameter("DATE2") == null) {
                qry = "select to_char(sysdate-6,'dd-mm-yyyy'),to_char(sysdate,'dd-mm-yyyy') from dual";
                rs = db.getRowset(qry);
                if (rs.next()) {
                    mDateFrom = rs.getString(1);
                }
                mDateTo = rs.getString(2);
            } else {
                mDateFrom = request.getParameter("DATE1");
                mDateTo = request.getParameter("DATE2");
            }
        }
        if (session.getAttribute("MemberID") == null) {
            mMemberID = "";
        } else {
            mMemberID = session.getAttribute("MemberID").toString().trim();
        }

        if (session.getAttribute("MemberType") == null) {
            mMemberType = "";
        } else {
            mMemberType = session.getAttribute("MemberType").toString().trim();
        }

        if (session.getAttribute("MemberName") == null) {
            mMemberName = "";
        } else {
            mMemberName = session.getAttribute("MemberName").toString().trim();
        }

        if (session.getAttribute("MemberCode") == null) {
            mMemberCode = "";
        } else {
            mMemberCode = session.getAttribute("MemberCode").toString().trim();
        }

        String mHead = "";
        if (session.getAttribute("PageHeading") != null && !session.getAttribute("PageHeading").equals("")) {
            mHead = session.getAttribute("PageHeading").toString().trim();
        } else {
            mHead = "JIIT ";
        }
%>
<HTML>
    <head>
        <TITLE>#### <%=mHead%> [ Modified Grade Approval]</TITLE>
        <script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
        <script type="text/javascript" src="js/sortabletable.js"></script>
        <link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
        <SCRIPT LANGUAGE="JavaScript">
            function un_check()
            {
                for (var i = 0; i < document.frm1.elements.length; i++)
                {
                    var e = document.frm1.elements[i];
                    if ((e.name != 'allbox') && (e.type == 'checkbox'))
                    {
                        e.checked = document.frm1.allbox.checked;
                    }
                }
            }
            function disable(group)
            {
                //alert(group);
                if(group=='A')
                {

                    document.frm.ACAD.disabled=true;
                    document.frm.PROG.disabled=true;
                    document.frm.STUD.disabled=true;
                    document.frm.DATE1.disabled=true;
                    document.frm.DATE2.disabled=true;
                }
                else
                {
                    document.frm.ACAD.disabled=false;
                    document.frm.PROG.disabled=false;
                    document.frm.STUD.disabled=false;
                    document.frm.DATE1.disabled=false;
                    document.frm.DATE2.disabled=false;
                }
            }
            function validate()
            {
                
                var remarks=trim(document.frm1.Remarks.value,' ');
                //alert(remarks);
               // remarks=trim(remarks,chars);
                if(remarks == null || remarks == '' )
                 {
                     alert(" Remarks field should,t be blank..!")
                     return false;
                 }
                 return true;
              
                
            }
function trim(str, chars) {
	return ltrim(rtrim(str, chars), chars);
}

function ltrim(str, chars) {
	chars = chars || "\\s";
	return str.replace(new RegExp("^[" + chars + "]+", "g"), "");
}

function rtrim(str, chars) {
	chars = chars || "\\s";
	return str.replace(new RegExp("[" + chars + "]+$", "g"), "");
}
        </SCRIPT>

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
    <%
        if (request.getParameter("x") != null) {
            param = request.getParameter("gradecriteria");
        //out.print("param:::"+param);
        } else {
            param = "A";
        }
    %>
    <body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 onload="disable('<%=param%>');">
        <%
        try {
            OLTEncryption enc = new OLTEncryption();
            String Q1 = "checked", Q2 = "";

            if (!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) {
                mDMemberID = enc.decode(mMemberID);
                mDMemberCode = enc.decode(mMemberCode);
                mDMemberType = enc.decode(mMemberType);
                String mChkMemID = enc.decode(session.getAttribute("MemberID").toString().trim());
                String mChkMType = enc.decode(session.getAttribute("MemberType").toString().trim());
                String mIPAddress = session.getAttribute("IPADD").toString().trim();
                String mRole = enc.decode(session.getAttribute("ROLENAME").toString().trim());
                ResultSet RsChk = null;

                qry = "Select Distinct NVL(InstituteCode,' ')InstituteCode from InstituteMASTER WHERE nvl(Deactive,'N')='N' ";
                rs = db.getRowset(qry);
                if (rs.next()) {
                    mInstitute = rs.getString(1);
                } else {
                    mInstitute = "JIIT";
                }

                //-----------------------------
                //-- Enable Security Page Level
                //-----------------------------

                qry = "Select WEBKIOSK.ShowLink('246','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";
                RsChk = db.getRowset(qry);
                //out.print(qry);
                if (RsChk.next() && RsChk.getString("SL").equals("Y")) {
                    //----------------------
%>
        <form name="frm" method="post" >
            <input id="x" name="x" type=hidden>
            <table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
                <tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium;"><STRONG>Modified Grade Approval</STRONG></TD>
                </font></td></tr>
            </TABLE>
            <table cellpadding=1 cellspacing=0 align=center rules=groups border=3>

                <!--Institute****-->
                <INPUT name=InstCode TYPE=HIDDEN id="InstCode" VALUE='<%=mInstitute%>'>

                <!--*********Exam**********-->
                <%
                    if (request.getParameter("gradecriteria") == null) {
                        QryGrdCrt = "A";
                    } else {
                        QryGrdCrt = request.getParameter("gradecriteria").toString().trim();
                    }
                    if (QryGrdCrt.equals("O")) {
                        Q1 = "";
                        Q2 = "checked";
                    } else {
                        Q1 = "checked";
                        Q2 = "";
                    }
                %>
                <tr>
                <td><input type=radio name="gradecriteria" Value="A" <%=Q1%> onclick="disable('A');"><Font color=black face=arial size=2><STRONG>&nbsp;View All Requests</STRONG></font>
                <hr>
                </td>
                </tr>
                <tr>
                    <td nowrap><input type=radio name="gradecriteria" Value="O" <%=Q2%> onclick="disable('O');"><Font color=black face=arial size=2><STRONG>&nbsp;View Selected Requests</STRONG></font><br><br>
                     &nbsp;&nbsp;&nbsp;
                        <font color=black face=arial size=2><STRONG>Academic Year</STRONG></font>
                        <%
                    qry = "Select Distinct AcademicYear from StudentMaster where studentid in (select studentid from UPDREQ#STUDENTWISEGRADE) UNION (Select 'ALL' AcademicYear from dual )Order By AcademicYear Desc";
                    rs = db.getRowset(qry);
                    //out.print(qry);
%>
                        <select name=ACAD tabindex="0" id="ACAD" style="WIDTH: 60px">
                            <%
                    try {

                        if (request.getParameter("x") == null) {

                            while (rs.next()) {
                                mAcadYr = rs.getString("AcademicYear");
                                if (mAcadYr.equals("ALL")) {
                                    QryAcadYr = mAcadYr;
                            %>
                            <OPTION Selected Value =<%=mAcadYr%>><%=mAcadYr%></option>
                            <%
                                        } else {
                            %>
                            <option value=<%=mAcadYr%>><%=mAcadYr%></option>
                            <%
                                        }
                                    }
                                } else {

                                    while (rs.next()) {
                                        mAcadYr = rs.getString("AcademicYear");

                                        if (request.getParameter("ACAD") == null) {
                            %><option  value=<%=mAcadYr%>><%=mAcadYr%></option><%
                            } else if (mAcadYr.equals(request.getParameter("ACAD").toString().trim())) {

                                QryAcadYr = mAcadYr;
                            %>
                            <option selected value=<%=mAcadYr%>><%=mAcadYr%></option>
                            <%
                            } else {

                            %>
                            <option  value=<%=mAcadYr%>><%=mAcadYr%></option>
                            <%
                                }
                            }
                        }
                    } catch (Exception e) {
                    }
                            %>
                        </select>

                        <font color=black face=arial size=2><STRONG> Program Code</STRONG></font>
                        <%
                    qry = "Select Distinct ProgramCode from StudentMaster where studentid in (select studentid from UPDREQ#STUDENTWISEGRADE) UNION (Select 'ALL' ProgramCode from dual ) Order By ProgramCode ";
                    rs = db.getRowset(qry);
                    //out.print(qry);
%>
                        <select name="PROG" tabindex="0" id="PROG" style="WIDTH: 60px">
                            <%
                    try {
                        if (request.getParameter("x") == null) {
                            while (rs.next()) {
                                mProgCode = rs.getString("ProgramCode");
                                if (mProgCode.equals("ALL")) {
                                    QryProgCode = mProgCode;
                            %>
                            <OPTION Selected Value =<%=mProgCode%>><%=mProgCode%></option>
                            <%
                                        } else {
                            %>
                            <option value=<%=mProgCode%>><%=mProgCode%></option>
                            <%
                                        }
                                    }
                                } else {
                                    while (rs.next()) {
                                        mProgCode = rs.getString("ProgramCode");
                                        if (request.getParameter("PROG") == null) {
                            %><option  value=<%=mProgCode%>><%=mProgCode%></option><%
                            } else if (mProgCode.equals(request.getParameter("PROG").toString().trim())) {
                                QryProgCode = mProgCode;
                            %>
                            <option selected value=<%=mProgCode%>><%=mProgCode%></option>
                            <%
                            } else {
                            %>
                            <option  value=<%=mProgCode%>><%=mProgCode%></option>
                            <%
                                }
                            }
                        }
                    } catch (Exception e) {
                    }
                            %>
                        </select>
                        <font color=black face=arial size=2><STRONG> Enrollment No.</STRONG></font>
                        <%
                    qry = "Select Distinct StudentID, EnrollmentNo from StudentMaster where studentid in (select studentid from UPDREQ#STUDENTWISEGRADE) UNION (Select 'ALL' StudentID, 'ALL' EnrollmentNo from dual ) Order By EnrollmentNo desc";
                    rs = db.getRowset(qry);
                    //out.print(qry);
%>
                        <select name="STUD" tabindex="0" id="STUD" style="WIDTH:85px">
                            <%
                    try {
                        if (request.getParameter("x") == null) {
                            while (rs.next()) {
                                mStudID = rs.getString("StudentID");
                                if (mStudID.equals("ALL")) {
                                    QryStudID = mStudID;
                            %>
                            <OPTION Selected Value =<%=mStudID%>><%=rs.getString("EnrollmentNo")%></option>
                            <%
                                        } else {
                            %>
                            <option value=<%=mStudID%>><%=rs.getString("EnrollmentNo")%></option>
                            <%
                                        }
                                    }
                                } else {
                                    while (rs.next()) {
                                        mStudID = rs.getString("StudentID");
                                        if (request.getParameter("STUD") == null) {
                            %><option  value=<%=mStudID%>><%=rs.getString("EnrollmentNo")%></option><%
                            } else if (mStudID.equals(request.getParameter("STUD").toString().trim())) {
                                QryStudID = mStudID;
                            %>
                            <option selected value=<%=mStudID%>><%=rs.getString("EnrollmentNo")%></option>
                            <%
                            } else {
                            %>
                            <option  value=<%=mStudID%>><%=rs.getString("EnrollmentNo")%></option>
                            <%
                                }
                            }
                        }
                    } catch (Exception e) {
                    }
                            %>
                        </select><br><br>&nbsp;&nbsp;&nbsp;
                        <font color=black face=arial font size=2><b>Request Date From</b>&nbsp;<INPUT TYPE="text" NAME=DATE1 ID=DATE1 size=9 tabindex=1 VALUE='<%=mDateFrom%>' readonly
                                                                                                     ><a href="javascript:NewCal('DATE1','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>
                        <b>To&nbsp;</b></font><INPUT TYPE="text" NAME=DATE2 ID=DATE2 size=9 tabindex=2
                                              VALUE='<%=mDateTo%>' readonly><a href="javascript:NewCal('DATE2','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a><br><br>
                <hr></td></tr>
                <tr>
                    <!--*********Pending/Approved**********-->
                    <td align=center><font color=black face=arial size=2><STRONG>Request Status</STRONG></font>
                        <select name="Status" tabindex="0" id="Status" style="WIDTH: 95px" >
                            <%
                    if (request.getParameter("x") == null) {
                        QryStatus = "D";
                            %>
                            <OPTION value=A>Approved</option>
                            <OPTION value=D SELECTED>Pending</option>
                            <OPTION value=B >Both</option>
                            <%
                            } else {
                                if (request.getParameter("Status").toString().trim().equals("A")) {
                            %>
                            <OPTION selected value=A>Approved</option>
                            <OPTION value=D>Pending</option>
                            <OPTION value=B >Both</option>
                            <%                                } else if (request.getParameter("Status").toString().trim().equals("D")) {
                            %>
                            <OPTION value=A>Approved</option>
                            <OPTION selected value=D>Pending</option>
                            <OPTION value=B >Both</option>
                            <%                                } else //(request.getParameter("Status").toString().trim().equals("B"))
                                {
                            %>
                            <OPTION value=A>Approved</option>
                            <OPTION  value=D>Pending</option>
                            <OPTION selected value=B >Both</option>
                            <%                        }
                    }
                            %>
                        </select>
                        &nbsp;&nbsp;&nbsp;
                <INPUT Type="submit" Value="Show/Refresh"></td></tr>
            </table>
        </form>
        <%
                    if (request.getParameter("gradecriteria") == null) {
                        QryGrdCrt = "A";
                    } else {
                        QryGrdCrt = request.getParameter("gradecriteria").toString().trim();
                    }
                    // out.print("::::::::"+QryGrdCrt);
                    if (QryGrdCrt.equals("O")) {
                        if (request.getParameter("ACAD") == null) {
                            QryAcadYr = "";
                        } else {
                            QryAcadYr = request.getParameter("ACAD").toString().trim();
                        }
                        if (request.getParameter("PROG") == null) {
                            QryProgCode = "";
                        } else {
                            QryProgCode = request.getParameter("PROG").toString().trim();
                        }
                        if (request.getParameter("STUD") == null) {
                            QryStudID = "";
                        } else {
                            QryStudID = request.getParameter("STUD").toString().trim();
                        }
                        if (request.getParameter("DATE1") == null) {
                            mDateFrom = "";
                        } else {
                            mDateFrom = request.getParameter("DATE1").toString().trim();
                        }
                        if (request.getParameter("DATE2") == null) {
                            mDateTo = "";
                        } else {
                            mDateTo = request.getParameter("DATE2").toString().trim();
                        }
                    } else {
                        QryAcadYr = "";
                        QryProgCode = "";
                        QryStudID = "";
                        mDateFrom = "";
                        mDateTo = "";
                    }
                    if (request.getParameter("Status") == null) {
                        QryStatus = "D";
                    } else {
                        QryStatus = request.getParameter("Status").toString().trim();
                    }

//--------------------------------------------------
//--------------------------------------------------
                    qry = "select Distinct a.TRANSID,a.FSTID,a.OLDGRDAE,a.NEWGRADE,D.EMPLOYEENAME ENAME, A.EXAMCODE EXAMCODE,C.SUBJECTID SUBJECTID, B.SUBJECTCODE SUBJCODE, B.SUBJECT SUBJNAME,nvl(a.APPROVALREQUESTREMARKS,' ')remarks,Decode(nvl(APPROVALFLAG,'N'),'Y','YES','NO')Finalized, Decode(APPROVALFLAG,'D','Pending','A','Approved','F','Finalized','Pending')STATUS, ";
                    qry = qry + " nvl(to_char(A.ENTRYDATE,'DD-MM-YYYY HH:MM:SS'),' ')ENTRYDATE From UPDREQ#STUDENTWISEGRADE A, SUBJECTMASTER B, FACULTYSUBJECTTAGGING C, EMPLOYEEMASTER D ";
                    qry = qry + " Where A.ENTRYBY=D.EMPLOYEEID AND A.INSTITUTECODE=B.INSTITUTECODE AND B.SUBJECTID=C.SUBJECTID AND A.FSTID=C.FSTID AND A.INSTITUTECODE=C.INSTITUTECODE AND NVL(A.APPROVALFLAG,'D')=DECODE('" + QryStatus + "','B',nvl(A.APPROVALFLAG,'D'),'" + QryStatus + "')";
                    if (QryGrdCrt.equals("O")) {
                        qry = qry + " AND trunc(a.entrydate) between trunc(To_Date('" + mDateFrom + "','DD-MM-YYYY')) and  trunc(To_Date('" + mDateTo + "','DD-MM-YYYY')) and A.STUDENTID IN (SELECT STUDENTID FROM STUDENTREGISTRATION WHERE ACADEMICYEAR=DECODE('" + QryAcadYr + "','ALL',ACADEMICYEAR,'" + QryAcadYr + "') AND PROGRAMCODE=DECODE('" + QryProgCode + "','ALL',PROGRAMCODE,'" + QryProgCode + "') AND STUDENTID=DECODE('" + QryStudID + "','ALL',STUDENTID,'" + QryStudID + "'))";
                    }
                    qry = qry + " Order by SubjName";
                    //out.println(qry);
                    rs = db.getRowset(qry);
                    rss = db.getRowset(qry);
                    if (rs.next()) {
        %>
        <form Name=frm1 ID=frm1 Action="GradeApprovalAction.jsp" Method=Post>
            <input id="x" name="x" type=hidden>
            <table valign=top class="sort-table" id="table-1" border=1 width="100%" cellpadding=0 cellspacing=0 align=center rules=none>
                <THEAD>
                    <tr bgcolor='#e68a06'>
                        <%
            if (QryStatus.equals("D") || QryStatus.equals("B")) {
                        %>
                        <td align=left ><b><font color="white">&nbsp;<input onClick="un_check()" type="checkbox" id='allbox' name='allbox' value='Y'></font><font color="white">Approve?</font></b></td>
                        <%} else {
                        %>
                        <td align=left ><b><font color="white">Status</font></b></td>
                        <%}%>
                        <td><font color="white"><b>SrNo</b></font></td>
                        <td align=left Title="Subject Name [Subject Code]"><font color="white"><b>Subject</b></font></td>

                        <td align=left Title="Student Count" ><font color="white"><b>Changed By</b></font></td>

                        <td align=left Title="Grade Entry Date"><font color="white"><b>Changed Date/Time</b></font></td>
                        <td align=left Title="Grade Entry Date"><font color="white"><b>Old Grade</b></font></td>
                        <td align=left Title="Grade Entry Date"><font color="white"><b>New Grade</b></font></td>
                        <td align=left Title="Grade Entry Date"><font color="white"><b>Remarks</b></font></td>
                    </tr>
                </thead>
                <tbody>
                    <input type=hidden Name='InstCode' ID='InstCode' value='<%=mInstitute%>'>
                    <input type=hidden Name='ExamCode' ID='ExamCode' value='<%=rs.getString("EXAMCODE")%>'>

                    <%
        } else {
                    %><Center><%
            out.print("<br><img src='../../Images/Error1.jpg'>");
            out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>No Such Request Found...!</font> <br>");
                    %></Center><%
                    }
                    String mColor = "";
                    int mChoice = 0;
                    String mLastStatus = "";
                    String mCol1 = "LightGrey";
                    String OldmELECTIVECODE = "";
                    String mCol2 = "#ffffff";
                    String mSubjCode = "", mSubjName = "", mE2DType = "", mEDate = "", TRCOLOR = "#F8F8F8";
                    while (rss.next()) {
                        mSubjCode = rss.getString("SUBJECTID");
                        mStatus = rss.getString("Status");
                        mSubjName = rss.getString("SubjName");
                        mE2DType = rss.getString("Finalized");
                        mEDate = rss.getString("EntryDate");
                        ctr++;
                        if (ctr % 2 == 0) {
                            TRCOLOR = "White";
                        } else {
                            TRCOLOR = "#F8F8F8";
                        }

                        mName1 = "Checked_" + String.valueOf(ctr).trim();
                        mName2 = "SubjCode_" + String.valueOf(ctr).trim();
                        mName3 = "TransId_" + String.valueOf(ctr).trim();
                        mName4 = "FSTID_" + String.valueOf(ctr).trim();
                    %>
                    <tr BGCOLOR='<%=TRCOLOR%>'>
                        <input type=hidden Name=<%=mName2%> ID=<%=mName2%> value='<%=mSubjCode%>'>
                        <input type=hidden Name=<%=mName3%> ID=<%=mName3%> value='<%=rss.getString("TRANSID")%>'>
                        <input type=hidden Name=<%=mName4%> ID=<%=mName4%> value='<%=rss.getString("FSTID")%>'>
                        <%
                        if (mStatus.equals("Approved")) {
                        %>
                        <td align=left nowrap><%--<input type='checkbox' name='<%=mName1%>' id='<%=mName1%>' disabled value='A'>--%><FONT COLOR=GREEN>Approved</FONT></td>
                        <%                        } else if (mStatus.equals("Pending")) {
                            mFlag++;
                        %>
                        <td align=left nowrap>&nbsp;<input type='checkbox' name='<%=mName1%>' id='<%=mName1%>' value='D' title="Check to approve!"><!--<FONT COLOR=red>Pending</FONT>--></td>
                        <%
                        }
                        %>
                        <td align=right><%=ctr%>.&nbsp;&nbsp;</td>
                        <td nowrap title="Click to view details!"><a href="#" onclick="javascript:window.open('SubjectDetail.jsp?id=<%=rss.getString("FSTID")%>&amp;tsid=<%=rss.getString("TRANSID")%>&amp;subject=<%=GlobalFunctions.toTtitleCase(mSubjName)%> [<%=rss.getString("SUBJCODE")%>]','','scrollbars=NO,dialog=true,height=325,width=700,left=200,top=300');"><%=GlobalFunctions.toTtitleCase(mSubjName)%> [<%=rss.getString("SUBJCODE")%>]</a></td>

                        <td nowrap><%=rss.getString("ENAME")%></td>

                        <td nowrap><%=mEDate%></td>
                        <td nowrap align="center"><%=rss.getString("OLDGRDAE")%></td>
                        <td nowrap align="center"><%=rss.getString("NEWGRADE")%></td>
                        <%
                        
                        if (!rss.getString("remarks").equals(" ") && rss.getString("remarks").length() > 8) {%>
                        <td nowrap align="left" title="Click to view remarks!"><a href="#" onclick="javascript:window.open('RemarksDetail.jsp?message=<%=rss.getString("TRANSID")%>','','scrollbars=NO,dialog=true,height=200,width=400,left=500,top=300');"><%=rss.getString("remarks").substring(0, 8)%>...</a></td>
                        <%} else if (!rss.getString("remarks").equals(" ") && rss.getString("remarks").length() <= 8) {%>
                        <td nowrap align="left" title="Click to view remarks!"><a href="#" onclick="javascript:window.open('RemarksDetail.jsp?message=<%=rss.getString("TRANSID")%>','','scrollbars=NO,dialog=true,height=200,width=400,left=500,top=300');"><%=rss.getString("remarks")%></a></td>
                        <%} else {%>
                        <td nowrap align="left"><%=rss.getString("remarks")%></td>
                        <%}%>
                    </tr>
                    <%
                    }
                    %>
                </tbody>
            </table>
            <!--<script type="text/javascript">
                var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString","Number","CaseInsensitiveString","CaseInsensitiveString"]);
                </script>-->
                <%

                    if (mFlag > 0) {
            %>
            <table valign=top border=1 width="100%" cellpadding=0 cellspacing=0 align=center rules=none bgcolor=white>
                <tr bgcolor=white><td colspan=5 nowrap><font color=black face=arial size=2><STRONG>Remarks : </STRONG><input type="text" name="Remarks" id="Remarks" size=80 maxlength="160px"><font color="red">*</font></td></tr>
                <TR BGCOLOR='#e68a06'><TD colspan=5 ALIGN=CENTER><INPUT Type="submit" name="Submit" id="Submit" Value="Approve" ONCLICK="return validate();" /></TD></TR>
            </table>
            <input type=hidden Name='TotalCount' ID='TotalCount' value='<%=ctr%>'>
        </form>
        <%
                    }
//-----------------------------
//-- Enable Security Page Level  
//-----------------------------
                } else {
        %>
        <br>
        <font color=red>
            <h3><br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
            <P>This page is not authorized/available for you.
            <br>For assistance, contact your network support team.
        </font><br>	<br>	<br>	<br>
        <%                }
            //-----------------------------
            } else {
                out.print("<br><img src='../../Images/Error1.jpg'>");
                out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
            }
        } catch (Exception e) {
            //out.println(qry);
        }
        %>
    </body>
</html>