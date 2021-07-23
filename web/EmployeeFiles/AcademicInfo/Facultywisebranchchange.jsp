<%--
    Document   : Facultywisebranchchange
    Created on : Aug 1, 2011, 10:45:22 AM
    Author     : ankur.verma
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" import="java.sql.*,java.math.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%
        DBHandler db = new DBHandler();
        ResultSet rs = null, rs1 = null, rsBatchDate = null;
        GlobalFunctions gb = new GlobalFunctions();
        String qry = "", qry1 = "", mLTP = "";
        String mMemberID = "", mDMemberID = "",mcheck="";
        String mMemberType = "", mDMemberType = "";
        String mMemberCode = "", mDMemberCode = "",academicyear="";
        String mMemberName = "", mExam = "", mSubject = "", mexam = "", mSubj = "", mColor = "", mCode = "", mES = "", mSubj1 = "";
        String mSection = "", mSubsection = "", mSExam = "", mSES = "";
        String QryExam = "", QrySubj = "", QryLTP = "", QrySecBr = "", QrySubSec = "", QryStID = "", QryFSTID = "";
        String mltp1 = "", mRollno = "", mStName = "",mSems ="";
        String mInst = "", mComp = "", mDate1 = "", mDate2 = "", mFacultyName = "", mFaculty = "",mDept="",
        QryFaculty = "", mREGCONFIRMATIONDATE = "";
        int i=0;int j=0;
String mStudCount="",mSemT="";




      if (session.getAttribute("InstituteCode") == null) {
            mInst = "";
        } else {
            mInst = session.getAttribute("InstituteCode").toString().trim();
        }
        if (session.getAttribute("CompanyCode") == null) {
            mComp = "";
        } else {
            mComp = session.getAttribute("CompanyCode").toString().trim();
        }

        if (session.getAttribute("MemberID") == null) {
            mMemberID = "";
        } else {
            mMemberID = session.getAttribute("MemberID").toString().trim();
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

if (session.getAttribute("DepartmentCode")==null)
	{
		mDept="";
	}
	else
	{
		mDept=session.getAttribute("DepartmentCode").toString().trim();
	}
        String mHead = "";
        if (session.getAttribute("PageHeading") != null && !session.getAttribute("PageHeading").equals("")) {
            mHead = session.getAttribute("PageHeading").toString().trim();
        } else {
            mHead = "JIIT ";
        }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <TITLE>#### <%=mHead%> [ Faculty Wise Branch Change ] </TITLE>

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
        <script type="text/javascript" src="js/TimePicker.js"></script>
        <SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">
            function ChangeOptions(Exam,DataCombo,Subject,DataComboSec,Section,DataComboSub,SubSection)
            {
                removeAllOptions(Subject);
                var subj='?';
                var mflag=0;
                var ssec='?';
                for(i=0;i<DataCombo.options.length;i++)
                {
                    var v1;
                    var pos;
                    var exam;
                    var sc;
                    var len;
                    var otext;
                    var v1=DataCombo.options[i].value;
                    len= v1.length ;
                    pos=v1.indexOf('***');
                    exam=v1.substring(0,pos);
                    sc=v1.substring(pos+3,len);
                    if (exam==Exam)
                    { 	if(mflag==0)
                        {
                            subj=sc;
                            mflag=1;
                        }
                        var optn = document.createElement("OPTION");
                        optn.text=DataCombo.options[i].text;
                        optn.value=sc;
                        Subject.options.add(optn);
                    }
                }
                removeAllOptions(Section);
                mflag=0;
                var optns = document.createElement("OPTION");
                optns.text='-Select-';
                optns.value='-Select-';
                Section.options.add(optns);
                ssec='-Select-';
                for(i=0;i<DataComboSec.options.length;i++)
                {
                    var v1s;
                    var pos1;
                    var pos2;
                    var exams;
                    var scs;
                    var lens;
                    var scse;
                    var otexts;
                    var v1s=DataComboSec.options[i].value;
                    lens= v1s.length ;
                    pos1=v1s.indexOf('***');
                    pos2=v1s.indexOf('///')
                    exams=v1s.substring(0,pos1);
                    scs=v1s.substring(pos1+3,pos2);
                    scse=v1s.substring(pos2+3,lens);
                    if (exams==Exam && subj==scs)
                    {
                        var optns = document.createElement("OPTION");
                        optns.text=DataComboSec.options[i].text;
                        optns.value=scse;
                        Section.options.add(optns);
                    }
                }
                removeAllOptions(SubSection);
                var optns1 = document.createElement("OPTION");
                optns1.text='-Select-';
                optns1.value='-Select-';
                SubSection.options.add(optns1);
                for(i=0;i<DataComboSub.options.length;i++)
                {
                    var v1s1;
                    var pos1;
                    var pos2;
                    var pos3;
                    var exams1;
                    var scs1;
                    var lens1;
                    var scse1;
                    var otexts1;
                    var subsec;
                    var v1s1=DataComboSub.options[i].value;

                    lens1= v1s1.length ;
                    pos11=v1s1.indexOf('***');
                    pos21=v1s1.indexOf('///');
                    pos3=v1s1.indexOf('*****');
                    exams=v1s1.substring(0,pos11);
                    scs1=v1s1.substring(pos11+3,pos21);
                    scse1=v1s1.substring(pos21+3,pos3);
                    subsec=v1s1.substring(pos3+5,lens1);
                    if (exams==Exam && subj==scs1 && ssec=='-Select-')
                  












                    {

                        var optns1 = document.createElement("OPTION");
                        optns1.text=DataComboSub.options[i].text;
                        optns1.value=subsec;
                        SubSection.options.add(optns1);
                    }
                }
            }
            //********Click event on subject**********
            function ChangeSubject(Exam,subj,DataComboSec,Section,DataComboSub,SubSection)
            {
                var mflag=0;
                var ssec='?';
                removeAllOptions(Section);
                mflag=0;
                var optns = document.createElement("OPTION");
                optns.text='-Select-';
                optns.value='-Select-';
                Section.options.add(optns);
                ssec='-Select-';
                for(i=0;i<DataComboSec.options.length;i++)
                {
                    var v1s;
                    var pos1;
                    var pos2;
                    var exams;
                    var scs;
                    var lens;
                    var scse;
                    var otexts;
                    var v1s=DataComboSec.options[i].value;
                    lens= v1s.length ;
                    pos1=v1s.indexOf('***');
                    pos2=v1s.indexOf('///')
                    exams=v1s.substring(0,pos1);
                    scs=v1s.substring(pos1+3,pos2);
                    scse=v1s.substring(pos2+3,lens);
                    if (exams==Exam && subj==scs)
                    {
                        var optns = document.createElement("OPTION");
                        optns.text=DataComboSec.options[i].text;
                        optns.value=scse;
                        Section.options.add(optns);
                    }
                }
                removeAllOptions(SubSection);
                var optns1 = document.createElement("OPTION");
                optns1.text='-Select-';
                optns1.value='-Select-';
                SubSection.options.add(optns1);
                for(i=0;i<DataComboSub.options.length;i++)
                {
                    var v1s1;
                    var pos1;
                    var pos2;
                    var pos3;
                    var exams1;
                    var scs1;
                    var lens1;
                    var scse1;
                    var otexts1;
                    var subsec;
                    var v1s1=DataComboSub.options[i].value;

                    lens1= v1s1.length ;
                    pos11=v1s1.indexOf('***');
                    pos21=v1s1.indexOf('///');
                    pos3=v1s1.indexOf('*****');
                    exams=v1s1.substring(0,pos11);
                    scs1=v1s1.substring(pos11+3,pos21);
                    scse1=v1s1.substring(pos21+3,pos3);
                    subsec=v1s1.substring(pos3+5,lens1);

                    if (exams==Exam && subj==scs1)// && ssec=='ALL')
                    {
                        var optns1 = document.createElement("OPTION");
                        optns1.text=DataComboSub.options[i].text;
                        optns1.value=subsec;
                        SubSection.options.add(optns1);
                    }
                }
            }
            //************click event on section***********
            function ChangeSection(Exam,subj,ssec,DataComboSub,SubSection)
            {
                removeAllOptions(SubSection);
                var optns1 = document.createElement("OPTION");
                optns1.text='-Select-';
                optns1.value='-Select-';
                SubSection.options.add(optns1);

                for(i=0;i<DataComboSub.options.length;i++)
                {
                    var v1s1;
                    var pos1;
                    var pos2;
                    var pos3;
                    var exams1;
                    var scs1;
                    var lens1;
                    var scse1;
                    var otexts1;
                    var subsec;
                    var v1s1=DataComboSub.options[i].value;

                    lens1= v1s1.length ;
                    pos11=v1s1.indexOf('***');
                    pos21=v1s1.indexOf('///');
                    pos3=v1s1.indexOf('*****');
                    exams=v1s1.substring(0,pos11);
                    scs1=v1s1.substring(pos11+3,pos21);
                    scse1=v1s1.substring(pos21+3,pos3);
                    subsec=v1s1.substring(pos3+5,lens1);

                    if (exams==Exam && subj==scs1 && ssec=='-Select-')
                    {
                        var optns1 = document.createElement("OPTION");
                        optns1.text=DataComboSub.options[i].text;
                        optns1.value=subsec;
                        SubSection.options.add(optns1);
                    }
                    else if(exams==Exam && subj==scs1 && ssec==scse1)
                    {
                        var optns1 = document.createElement("OPTION");
                        optns1.text=DataComboSub.options[i].text;
                        optns1.value=subsec;
                        SubSection.options.add(optns1);
                    }
                }
            }
            function removeAllOptions(selectbox)
            {
                var i;
                for(i=selectbox.options.length-1;i>=0;i--)
                {
                    selectbox.remove(i);
                }
            }
        </SCRIPT>
        <script>
            if(window.history.forward(1) != null)
                window.history.forward(1);
        </script>
    </head>
    <body   aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
        <%
        try {
            if (!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) {
                OLTEncryption enc = new OLTEncryption();
                mDMemberID = enc.decode(mMemberID);
                mDMemberCode = enc.decode(mMemberCode);
                mDMemberType = enc.decode(mMemberType);

                String mChkMemID = enc.decode(session.getAttribute("MemberID").toString().trim());
                String mChkMType = enc.decode(session.getAttribute("MemberType").toString().trim());
                String mIPAddress = session.getAttribute("IPADD").toString().trim();
                String mRole = enc.decode(session.getAttribute("ROLENAME").toString().trim());
                ResultSet RsChk = null;
                //-----------------------------
                //-- Enable Security Page Level
                //-----------------------------
                qry = "Select WEBKIOSK.ShowLink('259','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";
                RsChk = db.getRowset(qry);
                if (RsChk.next() && RsChk.getString("SL").equals("Y")) {
                    //----------------------
%>
        <form name="frm" method="post">
        <input id="x" name="x" type=hidden>
            <input type="hidden" name="y" id="y">



        <center><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana"><B>
        Faculty Wise Batch Change</b></font></center>
        <table  cellpadding=2 cellspacing=3  bordercolor=maroon  align=center
                rules=groups border=1 width="80%" >
            <!--Institute****-->

            <tr><td nowrap >
                    <FONT color=black face=Arial size=2><b>Exam Code</b></FONT>
                </td><td colspan="8">
                    <%
                    try {
                        qry = " Select Exam from (";
                        qry += " Select nvl(EXAMCODE,' ') Exam, EXAMPERIODFROM from EXAMMASTER Where INSTITUTECODE='" + mInst + "' AND";
                        qry += "   EXAMCODE NOT LIKE ('%SUP%' ) AND EXAMCODE NOT LIKE ('%SUM%' ) AND   NVL(LOCKEXAM,'N')='N' AND  nvl(Deactive,'N')='N' and nvl(EXCLUDEINATTENDANCE,'N')='N' ";
                        qry += " and examcode in (Select examcode from facultysubjecttagging " +
                                ")";
                        qry += " order by EXAMPERIODFROM DESC";
                        qry += ") where rownum<8";
                  //  out.print(qry);
                        rs = db.getRowset(qry);
                        if (request.getParameter("x") == null) {
                    %>
                    <Select Name=Exam tabindex="0" id="Exam" onclick="ChangeOptions(Exam.value,DataCombo,Subject,DataComboSec,Section,DataComboSub,SubSection);" onChange="ChangeOptions(Exam.value,DataCombo,Subject,DataComboSec,Section,DataComboSub,SubSection);">
                        <%
                            while (rs.next()) {
                                mExam = rs.getString("Exam");
                                if (mexam.equals("")) {
                                    mexam = mExam;
                                    QryExam = mExam;
                        %>
                        <OPTION Selected Value =<%=mExam%>><%=rs.getString("Exam")%></option>
                        <%
                            } else {
                        %>
                        <OPTION Value =<%=mExam%>><%=rs.getString("Exam")%></option>
                        <%
                                }
                            }
                        %>
                    </select>
                    <%
                        } else {
                    %>
                    <select name=Exam tabindex="0" id="Exam" onclick="ChangeOptions(Exam.value,DataCombo,Subject,DataComboSec,Section,DataComboSub,SubSection);" onChange="ChangeOptions(Exam.value,DataCombo,Subject,DataComboSec,Section,DataComboSub,SubSection);">
                        <%
                        while (rs.next()) {
                            mExam = rs.getString("Exam");
                            if (mExam.equals(request.getParameter("Exam").toString().trim())) {
                                mexam = mExam;
                                QryExam = mExam;
                        %>
                        <OPTION selected Value =<%=mExam%>><%=rs.getString("Exam")%></option>
                        <%
                            } else {
                        %>
                        <OPTION Value =<%=mExam%>><%=rs.getString("Exam")%></option>
                        <%
                            }
                        }
                        %>
                    </select>
                    <%
                        }
                    } catch (Exception e) {
                        // out.println("Error Msg");
                    }
                    %>
                </td>
            </tr>

            <!--*********Exam*****************DataComboSubject**************-->
        <%
                    try {

                        /*		qry="Select nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
                        qry=qry+" From  facultysubjecttagging A,SUBJECTMASTER B where (   (a.employeeid = '"+mDMemberID+"')       OR (a.fstid IN ( SELECT C.fstid                        FROM multifacultysubjecttagging C                       WHERE a.fstid = C.fstid                             AND C.employeeid = '"+mDMemberID+"')             )      ) and A.fstid not in (select fstid from  ";
                        qry=qry+" STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) And InstituteCode='"+mInst+"' and a.InstituteCode='"+mInst+"' and a.InstituteCode=b.InstituteCode   and ";
                        qry=qry+" Nvl(deactive,'N')='N' and facultyid<>'"+mDMemberID+"') AND A.SUBJECTID=B.SUBJECTID  and a.INSTITUTECODE=b.INSTITUTECODE and a.INSTITUTECODE='"+mInst+"'  ";
                        qry=qry+" union ";
                        qry=qry+" Select nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
                        qry=qry+" from  facultysubjecttagging A,SUBJECTMASTER B where A.fstid in (select fstid from ";
                        qry=qry+" STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
                        qry=qry+" nvl(deactive,'N')='N' and facultyid='"+mDMemberID+"' And InstituteCode='"+mInst+"') and  A.employeeid='"+mDMemberID+"' and a.InstituteCode='"+mInst+"' and a.InstituteCode=b.InstituteCode  AND A.SUBJECTID=B.SUBJECTID ";
                        qry=qry+" order by subject";
                         */

                        qry = "SELECT   NVL (a.subjectid, ' ') subjectid,NVL (b.subjectcode, ' ') subjectcode, a.examcode," +
                                " NVL (b.subject, ' ') || ' (' || b.subjectcode || ') ' subject FROM facultysubjecttagging a, " +
                                " subjectmaster b WHERE   a.subjectid = b.subjectid  AND NVL (A.deactive, 'N') = 'N'  and " +
                                " NVL (B.deactive, 'N') = 'N'     AND  " +
                                "   a.institutecode = '" + mInst + "'      AND a.institutecode = b.institutecode  AND a.subjectid IN ( SELECT C.subjectid" +
                            "                     FROM pr#departmentsubjecttagging C" +
                            "                    WHERE C.institutecode ='" + mInst + "'" +
                            "  AND C.DEPARTMENTCODE='"+mDept+"' " +
                            "                      AND NVL (C.deactive, 'N') = 'N')   " +
                                " UNION   SELECT   NVL (a.subjectid, ' ') subjectid,  NVL (b.subjectcode, ' ') subjectcode, " +
                                " a.examcode,  NVL (b.subject, ' ') || ' (' || b.subjectcode || ') ' subject" +
                                "   FROM facultysubjecttagging a, subjectmaster b   WHERE   a.fstid IN (SELECT fstid" +
                                "       FROM multifacultysubjecttagging WHERE  NVL (deactive, 'N') = 'N'" +
                                " AND institutecode = '" + mInst + "' )" +
                                "  AND a.subjectid = b.subjectid AND NVL (A.deactive, 'N') = 'N' AND NVL (B.deactive, 'N') = 'N'" +
                                " AND   a.institutecode ='" + mInst + "' " +
                                " AND a.institutecode = b.institutecode  AND a.subjectid IN ( SELECT C.subjectid" +
                            "                     FROM pr#departmentsubjecttagging C" +
                            "                    WHERE C.institutecode ='" + mInst + "'" +
                            "  AND C.DEPARTMENTCODE='"+mDept+"' " +
                            "                      AND NVL (C.deactive, 'N') = 'N') ORDER BY subject";

                     //  out.print(qry);
                        rs = db.getRowset(qry);
                        //out.print(qry);
                        if (request.getParameter("x") == null) {
            %>
            <Select Name=DataCombo id="DataCombo"  style="WIDTH:0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">
                <%
                while (rs.next()) {
                    mSubj = rs.getString("subjectid");
                    mCode = rs.getString("examcode");
                    mES = mCode + "***" + mSubj;
                %>
                <OPTION Value=<%=mES%>><%=rs.getString("subject")%></option>
                <%
                }
                %>
            </select>
            <%
            } else {
            %>
            <Select Name=DataCombo id="DataCombo"  style="WIDTH:0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">
                <%
                while (rs.next()) {
                    mSubj = rs.getString("subjectid");
                    mCode = rs.getString("examcode");
                    mES = mCode + "***" + mSubj;
                    if (mExam.equals(request.getParameter("Subject").toString().trim())) {
                %>
                <OPTION selected Value=<%=mES%>><%=rs.getString("subject")%></option>
                <%
                    } else {
                %>
                <OPTION Value=<%=mES%>><%=rs.getString("subject")%></option>
                <%
                    }
                }
                %>
            </select>
            <%
                        }
                    } catch (Exception e) {
                        // out.println("Error Msg");
                    }
//----***************Subject**********************
%>

            <tr><td nowrap>
                    <FONT color=black face=Arial size=2><b>Subject</b> </FONT>
                </td>
                <td colspan="8" >
                    <%
                    /*		qry="Select nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
                    qry=qry+" from  facultysubjecttagging A,SUBJECTMASTER B where ((A.employeeid='"+mDMemberID+"') OR (A.FSTID IN (SELECT B.FSTID FROM MULTIFACULTYSUBJECTTAGGING B WHERE A.FSTID=B.FSTID AND B.EMPLOYEEID='"+mDMemberID+"')))  ";
                    qry=qry+" and A.fstid not in (select fstid from STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
                    qry=qry+" nvl(deactive,'N')='N' and facultyid<>'"+mDMemberID+"' And InstituteCode='"+mInst+"') AND A.SUBJECTID=B.SUBJECTID and A.EXAMCODE='"+QryExam+"'  AND a.institutecode ='"+mInst+"'     and a.INSTITUTECODE=b.INSTITUTECODE  " ;
                    qry=qry+" union ";
                    qry=qry+" Select  nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
                    qry=qry+" from  facultysubjecttagging A,SUBJECTMASTER B where A.fstid in (select fstid from ";
                    qry=qry+" STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
                    qry=qry+" nvl(deactive,'N')='N' and facultyid='"+mDMemberID+"' And InstituteCode='"+mInst+"')AND A.SUBJECTID=B.SUBJECTID ";
                    qry=qry+" and A.EXAMCODE='"+QryExam+"'  AND a.institutecode ='"+mInst+"'     and a.INSTITUTECODE=b.INSTITUTECODE order by subject";
                     */


                    qry = "SELECT   NVL (a.subjectid, ' ') subjectid,NVL (b.subjectcode, ' ') subjectcode, a.examcode," +
                            " NVL (b.subject, ' ') || ' (' || b.subjectcode || ') ' subject FROM facultysubjecttagging a, " +
                            " subjectmaster b WHERE   a.subjectid = b.subjectid  AND NVL (A.deactive, 'N') = 'N' AND " +
                            " NVL (B.deactive, 'N') = 'N'     AND a.examcode = '" + QryExam + "' " +
                            "  AND a.institutecode = '" + mInst + "'      AND a.institutecode = b.institutecode AND a.subjectid IN ( SELECT C.subjectid" +
                            "                     FROM pr#departmentsubjecttagging C" +
                            "                    WHERE C.institutecode ='" + mInst + "'" +
                            "  AND C.DEPARTMENTCODE='"+mDept+"' " +
                            "                      AND NVL (C.deactive, 'N') = 'N')    " +
                            " UNION   SELECT   NVL (a.subjectid, ' ') subjectid,  NVL (b.subjectcode, ' ') subjectcode, " +
                            " a.examcode,  NVL (b.subject, ' ') || ' (' || b.subjectcode || ') ' subject" +
                            "   FROM facultysubjecttagging a, subjectmaster b   WHERE    a.fstid IN (SELECT fstid" +
                            "       FROM multifacultysubjecttagging WHERE  NVL (deactive, 'N') = 'N'" +
                            " AND institutecode = '" + mInst + "' )     AND a.subjectid IN ( SELECT C.subjectid" +
                            "                     FROM pr#departmentsubjecttagging C" +
                            "                    WHERE C.examcode = '" + QryExam + "'" +
                            "                      AND C.institutecode ='" + mInst + "'" +
                            "  AND C.DEPARTMENTCODE='"+mDept+"' " +
                            "                      AND NVL (C.deactive, 'N') = 'N')" +
                            "  AND a.subjectid = b.subjectid AND NVL (A.deactive, 'N') = 'N' AND NVL (B.deactive, 'N') = 'N'" +
                            " AND a.examcode = '" + QryExam + "' AND a.institutecode ='" + mInst + "' " +
                            " AND a.institutecode = b.institutecode  ORDER BY subject";

                    rs = db.getRowset(qry);
//  out.print(qry);
%>
                    <select name=Subject tabindex="0" id="Subject" onclick="ChangeSubject(Exam.value,Subject.value,DataComboSec,Section,DataComboSub,SubSection);" onChange="ChangeSubject(Exam.value,Subject.value,DataComboSec,Section,DataComboSub,SubSection);">
                        <%
                    if (request.getParameter("x") == null) {
                        while (rs.next()) {
                            if (mSubj1.equals("")) {
                                mSubj1 = rs.getString("subjectid");
                                QrySubj = mSubj1;
                        %>
                        <OPTION selected Value ='<%=mSubj1%>'><%=rs.getString("subject")%></option>
                        <%
                                } else {
                        %>
                        <OPTION Value ='<%=rs.getString("subjectid")%>'><%=rs.getString("subject")%></option>
                        <%
                                }
                            }
                        } else {
                            while (rs.next()) {
                                mSubj1 = rs.getString("subjectid");
                                if (mSubj1.equals(request.getParameter("Subject").toString().trim())) {
                                    QrySubj = mSubj1;
                        %>
                        <OPTION selected Value ='<%=mSubj1%>'><%=rs.getString("subject")%></option>
                        <%
                        } else {
                        %>
                        <OPTION Value ='<%=mSubj1%>'><%=rs.getString("subject")%></option>
                        <%
                            }
                        }
                    }
                        %>
                    </select>
                </td>
                </tr>
                <tr>
                <td>
                    <FONT color=black><FONT face=Arial size=2><STRONG>LTP </STRONG></FONT></FONT>
                </td>
                <td>
                    <%
                    qry = "Select Distinct LTP ,decode(nvl(LTP,' '),'L','Lecture','T','Tutorial','P','Practical','E','Project') LtpDesc,";
                    qry = qry + " decode(nvl(LTP,' '),'L','1','T','2','P','3','4') orderltp ";
                    qry = qry + " from facultysubjecttagging A where a.institutecode = '" + mInst + "' and NVL (A.deactive, 'N') = 'N'";
                    qry = qry + "  AND A.LTP <> 'E'  ORDER BY orderltp ";
                    rs = db.getRowset(qry);
                    //out.print(qry);
%>
                    <select name=LTP tabindex="0" id="LTP">
                        <%
                    if (request.getParameter("x") == null) {
                        while (rs.next()) {
                            mltp1 = rs.getString("LTP");
                            if (QryLTP.equals("")) {
                                QryLTP = mltp1;
                            }
                            if (mltp1.equals("L")) {
                        %>
                        <OPTION selected Value ='<%=mltp1%>'><%=rs.getString("LtpDesc")%></option>
                        <%
                                } else {
                        %>
                        <OPTION Value ='<%=mltp1%>'><%=rs.getString("LtpDesc")%></option>
                        <%
                                }
                            }
                        } else {
                            while (rs.next()) {
                                mltp1 = rs.getString("LTP");
                                if (QryLTP.equals("")) {
                                    QryLTP = mltp1;
                                }
                                if (mltp1.equals(request.getParameter("LTP").toString().trim())) {
                        %>
                        <OPTION selected Value ='<%=mltp1%>'><%=rs.getString("LtpDesc")%></option>
                        <%
                        } else {
                        %>
                        <OPTION Value ='<%=mltp1%>'><%=rs.getString("LtpDesc")%></option>
                        <%
                            }
                        }
                    }
                        %>
                    </select>
            </td>
           <td colspan="2">
                    <!******************Group/Section**************-->
                    <FONT color=black><FONT face=Arial size=2><STRONG>Section</STRONG>&nbsp;</FONT></FONT>
                </td>
                <td  colspan="2">
                    <%
                    try {
                        /*qry1="select 'ALL' section from dual union all";
                        qry1=qry1+" select nvl(A.SECTIONBRANCH,' ') Section from facultysubjecttagging A where   ";
                        qry1=qry1+" ( OR (A.FSTID IN (SELECT B.FSTID" +
                        " FROM MULTIFACULTYSUBJECTTAGGING B WHERE A.FSTID=B.FSTID " +
                        " )))";
                        qry1=qry1+" and A.examcode='"+QryExam+"' and A.subjectid='"+QrySubj+"'" +
                        " and a.institutecode ='"+mInst+"'   Group By nvl(A.SECTIONBRANCH,' ') order by Section";
                         */

                        /*          qry1="select DISTINCT nvl(A.SECTIONBRANCH,' ') Section" +
                        " from facultysubjecttagging A where    A.examcode='"+QryExam+"' " +
                        "    and A.subjectid=decode('"+QrySubj+"','ALL',subjectid,'"+QrySubj+"') " +
                        "  and a.institutecode ='"+mInst+"' " +
                        " UNION select DISTINCT nvl(A.SECTIONBRANCH,' ') Section" +
                        " from facultysubjecttagging A where    A.examcode='"+QryExam+"' " +
                        "    and A.subjectid=decode('"+QrySubj+"','ALL',subjectid,'"+QrySubj+"') and a.institutecode ='"+mInst+"' " +
                        " AND A.FSTID IN (" +
                        "select B.FSTID  from MULTIfacultysubjecttagging B where" +
                        "    B.institutecode ='"+mInst+"'  )    order by Section    ";
                         */

                        qry1 = qry1 + "select '-Select-' section from dual union  select Distinct nvl(SECTIONBRANCH,' ') Section from  facultysubjecttagging where  ";
                        //qry1=qry1+"  facultytype=decode('"+mDMemberType+"','E','I','E') and ";
                        qry1 = qry1 + " institutecode='" + mInst + "'   and examcode  in (select examcode from exammaster where institutecode='" + mInst + "' and nvl(LOCKEXAM,'N')='N' ";
                        qry1 = qry1 + " and nvl(FINALIZED,'N')='N' and NVL(DEACTIVE,'N')='N' ) ";
                        qry1 = qry1 + " and examcode='" + QryExam + "' and subjectid=decode('" + QrySubj + "','ALL',subjectid,'" + QrySubj + "') order by Section";
                        //         out.print(qry1);
                        rs1 = db.getRowset(qry1);
                        if (request.getParameter("x") == null) {
                    %>
                    <select name="Section" tabindex="0" id="Section" onclick="ChangeSection(Exam.value,Subject.value,Section.value,DataComboSub,SubSection);" onChange="ChangeSection(Exam.value,Subject.value,Section.value,DataComboSub,SubSection);">
                        <%
                            while (rs1.next()) {
                                mSubj = rs1.getString("Section");
                                QrySecBr = mSubj;
                        %>
                        <OPTION Value ="<%=mSubj%>"><%=rs1.getString("Section")%></option>
                        <%
                            }
                        %>
                    </select>
                    <%
                        } else {
                    %>
                    <select name="Section" tabindex="0" id="Section" onclick="ChangeSection(Exam.value,Subject.value,Section.value,DataComboSub,SubSection);" onChange="ChangeSection(Exam.value,Subject.value,Section.value,DataComboSub,SubSection);">
                        <%
                        while (rs1.next()) {
                            mSubj = rs1.getString("Section");
                            if (mSubj.equals(request.getParameter("Section").toString().trim())) {
                                QrySecBr = mSubj;
                        %>
                        <OPTION selected Value ="<%=mSubj%>"><%=rs1.getString("Section")%></option>
                        <%
                            } else {
                        %>
                        <OPTION Value ="<%=mSubj%>"><%=rs1.getString("Section")%></option>
                        <%
                            }
                        }
                        %>
                    </select>
                    <%
                        }
                    } catch (Exception e) {
                    }
                    //**********************DataComboSec***************
                    try { /*
                        qry1="select nvl(A.SECTIONBRANCH,' ') Section,nvl(A.subjectid,' ')subjectid,nvl(A.EXAMCODE,' ')examcode from  facultysubjecttagging A where";
                        qry1=qry1+" ( or (A.FSTID IN(SELECT B.FSTID FROM MULTIFACULTYSUBJECTTAGGING B WHERE " +
                        " A.FSTID=B.FSTID )))";
                        qry1=qry1+" AND a.institutecode ='"+mInst+"'   Group by SECTIONBRANCH ,subjectid,EXAMCODE";
                        qry1=qry1+" order by Section";
                         */

                        /* qry1="select DISTINCT nvl(A.SECTIONBRANCH,' ') Section" +
                        " from facultysubjecttagging A where   " +
                        "     a.institutecode ='"+mInst+"' " +
                        "UNION select DISTINCT nvl(A.SECTIONBRANCH,' ') Section" +
                        " from facultysubjecttagging A where  " +
                        "   a.institutecode ='"+mInst+"'  and  A.FSTID IN (" +
                        " select B.FSTID from MULTIfacultysubjecttagging B where" +
                        "    B.institutecode ='"+mInst+"'  )     order by Section    ";
                         */
                        qry1 = " select Distinct nvl(SECTIONBRANCH,' ') Section,nvl(subjectid,' ')subjectid,nvl(EXAMCODE,' ')examcode from  facultysubjecttagging where  ";
                        //qry1=qry1+"  facultytype=decode('"+mDMemberType+"','E','I','E') and ";
                        qry1 = qry1 + " institutecode='" + mInst + "' AND  examcode in (select examcode from exammaster where institutecode='" + mInst + "' and  nvl(LOCKEXAM,'N')='N' ";
                        qry1 = qry1 + " and nvl(FINALIZED,'N')='N' and NVL(DEACTIVE,'N')='N' ) ";
                        qry1 = qry1 + " order by Section";
                        //out.print(qry1);
                        //out.print(qry1);
                        rs1 = db.getRowset(qry1);
                        if (request.getParameter("x") == null) {
                    %>
                    <select name="DataComboSec" tabindex="0" id="DataComboSec"  style="WIDTH:0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">
                        <%
                       while (rs1.next()) {
                           mSubj = rs1.getString("subjectid");
                           mSExam = rs1.getString("examcode");
                           mSES = mSExam + "***" + mSubj + "///" + rs1.getString("Section");
                        %>
                        <OPTION Value ="<%=mSES%>"><%=rs1.getString("Section")%></option>
                        <%
                       }
                        %>
                    </select>
                    <%
                   } else {
                    %>
                    <select name="DataComboSec" tabindex="0" id="DataComboSec"  style="WIDTH:0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">
                        <%
                        while (rs1.next()) {
                            mSubj = rs1.getString("subjectid");
                            mSExam = rs1.getString("examcode");
                            mSES = mSExam + "***" + mSubj + "///" + rs1.getString("Section");

                            if (mSES.equals(request.getParameter("Section").toString().trim())) {
                        %>
                        <OPTION selected Value ="<%=mSES%>"><%=rs1.getString("Section")%></option>
                        <%
                            } else {
                        %>
                        <OPTION Value ="<%=mSES%>"><%=rs1.getString("Section")%></option>
                        <%
                            }
                        }
                        %>
                    </select>
                    <%
                        }
                    } catch (Exception e) {
                    }
                    %>
                </td>

<!---Start Academicyear column---->

 <td colspan="2">
 <!--%=request.getParameter("x")+"#####"+request.getParameter("y")+"$$$$"%-->
<%try{%>                    <!******************Academicyear**************-->
                    <FONT color="black"><FONT face=Arial size=2><STRONG>Academic Year</STRONG>&nbsp;</FONT></FONT>
                </td>
                <td  colspan="2">
				<select name="acedamicyear" id="acedamicyear">
				<option selected  value="">-Select- </option>
<%
qry="select distinct nvl(ACADEMICYEAR,'') ACADEMICYEAR from facultysubjecttagging   order by 1  desc";
 rs=db.getRowset(qry);
while(rs.next()){
   if (request.getParameter("x") == null) {
   %><option value="<%=rs.getString("ACADEMICYEAR")%>"><%=rs.getString("ACADEMICYEAR")%></option><%
   }else
	   {
   if(request.getParameter("acedamicyear").equals(rs.getString("ACADEMICYEAR")))
	   {
   %><option selected  value="<%=rs.getString("ACADEMICYEAR")%>"><%=rs.getString("ACADEMICYEAR")%></option><%
   }else
	   {
   %><option   value="<%=rs.getString("ACADEMICYEAR")%>"><%=rs.getString("ACADEMICYEAR")%></option><%
   }

   }
   } %>

				</select>
	<%}catch(Exception e)
	{
				out.print(e);
				}%>
				</td>





<!----End Academicyear column---->








                <!******************Sub Group/Sub Section**************-->
                <td>
                    <FONT color=black><FONT face=Arial size=2><STRONG>Sub Sec.</STRONG></FONT></FONT>
                </td> <td colspan="2">
                    <%
                    try {
                        /*	qry1="Select A.SUBSECTIONCODE SubSection from facultysubjecttagging A where";
                        qry1=qry1+" ((A.employeeid='"+mDMemberID+"') or (A.FSTID IN(SELECT B.FSTID FROM MULTIFACULTYSUBJECTTAGGING B WHERE A.FSTID=B.FSTID AND B.EMPLOYEEID='"+mChkMemID+"')))";
                        qry1=qry1+" and A.examcode='"+QryExam+"' and A.subjectid='"+QrySubj+"'";
                        qry1=qry1+" and A.sectionbranch=decode('"+QrySecBr+"','ALL',A.sectionbranch,'"+QrySecBr+"') AND a.institutecode ='"+mInst+"'   Group By A.SUBSECTIONCODE order by SubSection ";
                         */

                        qry1 = "Select Distinct SUBSECTIONCODE SubSection from  facultysubjecttagging where  ";
                        //qry1=qry1+"  facultytype=decode('"+mDMemberType+"','E','I','E') and ";
                        qry1 = qry1 + " institutecode='" + mInst + "' AND examcode  in (select examcode from exammaster where institutecode='" + mInst + "' and nvl(LOCKEXAM,'N')='N' ";
                        qry1 = qry1 + " and nvl(FINALIZED,'N')='N' and NVL(DEACTIVE,'N')='N' )  ";
                        qry1 = qry1 + " and examcode='" + QryExam + "' and subjectid=decode('" + QrySubj + "','ALL',subjectid,'" + QrySubj + "') ";
                        qry1 = qry1 + " and sectionbranch=decode('" + QrySecBr + "','ALL',sectionbranch,'" + QrySecBr + "') order by SubSection ";
                       // out.print(qry1);
                        rs1 = db.getRowset(qry1);
                        if (request.getParameter("x") == null) {
                    %>
                    <select name=SubSection tabindex="0" id="SubSection">
                        <option Selected value='N'>-Select-</option>
                        <%
                            while (rs1.next()) {
                                mSubsection = rs1.getString("SubSection");
                        %>
                        <OPTION Value ="<%=mSubsection%>"><%=rs1.getString("SubSection")%></option>
                        <%
                            }
                        %>
                    </select>
                    <%
                        } else {
                    %>
                    <select name=SubSection tabindex="0" id="SubSection">
                        <%
                        if ("ALL".equals(request.getParameter("SubSection").toString().trim())) {
                        %>
                        <OPTION selected Value =N>-Select-</option>
                        <%                        } else {
                        %>
                        <OPTION Value =N>-Select-</option>
                        <%                        }
                        while (rs1.next()) {
                            mSubsection = rs1.getString("SubSection");
                            if (mSubsection.equals(request.getParameter("SubSection").toString().trim())) {
                        %>
                        <OPTION selected Value ="<%=mSubsection%>"><%=rs1.getString("SubSection")%></option>
                        <%
                            } else {
                        %>
                        <OPTION Value ="<%=mSubsection%>"><%=rs1.getString("SubSection")%></option>
                        <%
                            }
                        }
                        %>
                    </select>
                    <%
                        }
                    } catch (Exception e) {
                    }


				  if(request.getParameter("SemType")==null)
			mSemT="";
		else
		mSemT=request.getParameter("SemType").toString().trim();
				  %>




				 <FONT color=black><FONT face=Arial size=2><b>Semester Type : </b>

				 <select name="SemType" id="SemType" style="WIDTH: 50px"  >
	<%
	if(request.getParameter("SemType")==null)
	{
	%>
	   <option  selected value='ALL'>ALL </option>
	   <option  value='REG'>REG</option>
	   <option value='RWJ'>RWJ</option>
	   <option value='SAP'>SAP</option>
	   <option value='GIP'>GIP</option>
	<%
	}
	else
	{


		if(mSemT.equals("ALL"))
		{
		%>
			<option selected value='ALL'>ALL </option>
	            <option value='REG'>REG</option>
		      <option value='RWJ'>RWJ</option>
			  <option value='SAP'>SAP</option>
			  <option value='GIP'>GIP</option>

 		<%
		}
		else if(mSemT.equals("REG"))
		{
		%>
			<option value='ALL'>ALL </option>
			<option selected value='REG'>REG</option>
	   		<option value='RWJ'>RWJ</option>
			<option value='SAP'>SAP</option>
			<option value='GIP'>GIP</option>
 		<%
		}
		else if(mSemT.equals("RWJ"))
		{
		%>
			<option value='ALL'>ALL </option>
			<option value='REG'>REG</option>
	  	      <option selected value='RWJ'>RWJ</option>
			  <option value='SAP'>SAP</option>
			  <option value='GIP'>GIP</option>
		<%
		}
		else if(mSemT.equals("SAP"))
		{
		%>
			<option value='ALL'>ALL </option>
			<option value='REG'>REG</option>
	  	      <option value='RWJ'>RWJ</option>
			  <option selected value='SAP'>SAP</option>
			  <option value='GIP'>GIP</option>
		<%
		}
		else if(mSemT.equals("GIP"))
		{
		%>
			<option value='ALL'>ALL </option>
			<option value='REG'>REG</option>
	  	      <option value='RWJ'>RWJ</option>
			  <option value='SAP'>SAP</option>
			  <option selected value='GIP'>GIP</option>
		<%
		}
		else
		{
		%>
			<option selected value='ALL'>ALL </option>
			<option value='REG'>REG</option>
	  	      <option  value='RWJ'>RWJ</option>
			  <option value='SAP'>SAP</option>
			  <option value='GIP'>GIP</option>
		<%
		}
	}



%>
</select>



<%

                    //*************DataComboSub************
                    try {
                        /*			qry1="Select A.SUBSECTIONCODE SubSection, nvl(A.SECTIONBRANCH,' ') Section, nvl(A.Examcode,' ')examcode, nvl(A.SubjectID,' ')subjectid from  facultysubjecttagging A where ";
                        qry1=qry1+" ((A.employeeid='"+mDMemberID+"') or (A.FSTID IN(SELECT B.FSTID FROM MULTIFACULTYSUBJECTTAGGING B WHERE A.FSTID=B.FSTID AND B.EMPLOYEEID='"+mChkMemID+"')))";
                        qry1=qry1+" AND a.institutecode ='"+mInst+"'   Group By A.SUBSECTIONCODE ,nvl(A.SECTIONBRANCH,' ') ,nvl(A.Examcode,' '),nvl(A.SubjectID,' ') order by SubSection ";
                         */
                        qry1 = "Select Distinct SUBSECTIONCODE SubSection,nvl(SECTIONBRANCH,' ') Section,nvl(Examcode,' ')examcode," +
                                "nvl(subjectid,' ')subjectid from  facultysubjecttagging where  ";
                        //qry1=qry1+"  facultytype=decode('"+mDMemberType+"','E','I','E') and ";
                        qry1 = qry1 + " institutecode='" + mInst + "' AND  examcode  in (select examcode from exammaster " +
                                "where institutecode='" + mInst + "' and nvl(LOCKEXAM,'N')='N' ";
                        qry1 = qry1 + " and nvl(FINALIZED,'N')='N' and NVL(DEACTIVE,'N')='N' ) ";
                        qry1 = qry1 + " order by SubSection ";
						//out.print(qry1);
                        rs1 = db.getRowset(qry1);
                        if (request.getParameter("x") == null) {
                    %>
                    <select name=DataComboSub tabindex="0" id="DataComboSub"  style="WIDTH:0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">
                        <%
                        while (rs1.next()) {
                            mSubj = rs1.getString("subjectid");
                            mSExam = rs1.getString("examcode");
                            mSES = mSExam + "***" + mSubj + "///" + rs1.getString("Section") + "*****" + rs1.getString("SubSection");
                        %>
                        <OPTION Value ="<%=mSES%>"><%=rs1.getString("SubSection")%></option>
                        <%
                        }
                        %>
                    </select>
                    <%
                    } else {
                    %>
                    <select name=DataComboSub tabindex="0" id="DataComboSub"  style="WIDTH:0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">
                        <%
                        while (rs1.next()) {
                            mSubj = rs1.getString("subjectid");
                            mSExam = rs1.getString("examcode");
                            mSES = mSExam + "***" + mSubj + "///" + rs1.getString("Section") + "*****" + rs1.getString("SubSection");
                            if (mSES.equals(request.getParameter("DataComboSub").toString().trim())) {
                        %>
                        <OPTION selected Value =<%=mSES%>><%=rs1.getString("SubSection")%></option>
                        <%
                            } else {
                        %>
                        <OPTION Value =<%=mSES%>><%=rs1.getString("SubSection")%></option>
                        <%
                            }
                        }
                        %>
                    </select>
                    <%
                        }
                    } catch (Exception e) {
                    }



//out.print(request.getParameter("SemType").toString().trim());


				%>


				</td>


            </tr>
            <tr><td align=center colspan="9"><input type="submit" value="Show"></td></tr>
        </table>
        </form>

<%
if(request.getParameter("x")!=null)
{

       mExam=request.getParameter("Exam").toString().trim();
	   mSubject=request.getParameter("Subject").toString().trim();
	   mLTP=request.getParameter("LTP").toString().trim();
	   mSection=request.getParameter("Section").toString().trim();
	   mSubsection=request.getParameter("SubSection").toString().trim();
	   academicyear=request.getParameter("acedamicyear").toString().trim();
	   mSems =request.getParameter("SemType").toString().trim();





%>

<form name="form" method="post">
<input type="hidden" name="y" id="y">
    <!--input type="hidden" name="x" id="x"-->


<input type="hidden" name="SemType" value="<%=mSems%>">

<input type="hidden" name="Exam" value="<%=mExam%>">
    <input type="hidden" name="Subject" value="<%=mSubject%>">
        <input type="hidden" name="LTP" value="<%=mLTP%>">
            <input type="hidden" name="Section" value="<%=mSection%>">
                <input type="hidden" name="SubSection" value="<%=mSubsection%>">
              <input type="hidden" name="academicyear" value="<%=academicyear%>">
    <TABLE border='1' align="center" class="sort-table" id="table-1" width="70%">
					<TR>
							<TD colspan=2 align=center	>
							<font size=3 face=arial color=red> Faculty Wise Batch Change for Regular Batches</font>
							</TD>
							</TR>
					<TR bgcolor="#ff8c00">
						<TD align="center"><B> Faculty Name </B></TD>
                        <TD align="center"><B> Batches </B></TD>
					</TR>
					<TR>
						<TD width="50%" valign="top">
							<TABLE border='1' width="100%" class="sort-table" id="table-1" cellpadding=1 cellspacing=0>
							<TR bgcolor="#ff8c00">
								<TD>
                                 <b>Select</b>
                                </TD>
								<TD><B>Faculty Name</B></TD>
								<TD><B>Faculty Code</B></TD>
							</TR>

                            <%
                          /*  qry="SELECT nvl(EMPLOYEECODE,' ')EMPLOYEECODE,nvl(EMPLOYEENAME,' ')EMPLOYEENAME," +
                                    " nvl(EMPLOYEEID,' ')EMPLOYEEID  FROM EMPLOYEEMASTER WHERE " +
                                    " COMPANYCODE='"+mComp+"' and employeetype='TEC' AND NVL(DEACTIVE,'N')='N'" +
                                    " and departmentcode in ( SELECT B.departmentcode   FROM " +
                                    " PR#DEPARTMENTSUBJECTTAGGING B WHERE  B.DEPARTMENTCODE='"+mDept+"' and b.ACADEMICYEAR='"+academicyear+"' AND " +
                                    "B.INSTITUTECODE='"+mInst+"'" +
                                    " AND NVL(B.DEACTIVE,'N')='N' AND b.SUBJECTID='"+mSubject+"' " +
                                    " and b.SECTIONBRANCH=decode('"+mSection+"','ALL',sectionbranch,'"+mSection+"') )" +
                            //  new change after registration(start) -28-01-2016
							" UNION ALL SELECT   NVL (employeecode, ' ') employeecode, NVL (employeename, ' ') employeename,"+
							"NVL (employeeid, ' ') employeeid    FROM employeemaster   WHERE companycode = 'UNIV'   AND EMPLOYEETYPE='NTEC' "+
							"	AND NVL (deactive, 'N') = 'N'"+
								 // new change after registration(end) -28-01-2016
							" order by employeename "  ; */
							qry="SELECT nvl(EMPLOYEECODE,' ')EMPLOYEECODE,nvl(EMPLOYEENAME,' ')EMPLOYEENAME, nvl(EMPLOYEEID,' ')EMPLOYEEID FROM EMPLOYEEMASTER WHERE COMPANYCODE='UNIV' and employeetype='TEC' AND NVL(DEACTIVE,'N')='N' and departmentcode in ( SELECT B.departmentcode FROM PR#DEPARTMENTSUBJECTTAGGING B  WHERE B.DEPARTMENTCODE='"+mDept+"' AND B.INSTITUTECODE='"+mInst+"'    AND NVL(B.DEACTIVE,'N')='N'   AND b.SUBJECTID='"+mSubject+"')  union all SELECT NVL (GuestID, ' ') employeecode,  NVL (Guestname, ' ') employeename, NVL (Guestid, ' ') employeeid   FROM Guest WHERE  Guesttype = 'T' AND NVL (deactive, 'N') = 'N'  AND departmentcode IN ( SELECT b.departmentcode       FROM pr#departmentsubjecttagging b        WHERE b.departmentcode = '"+mDept+"'  AND b.institutecode = '"+mInst+"'      AND NVL (b.deactive, 'N') = 'N'  AND b.subjectid = '"+mSubject+"')";
                          //out.print(qry+"<br>");
                            rs=db.getRowset(qry);
                            while(rs.next())
                                { i++;

                                 qry1="SELECT 'Y' FROM FACULTYSUBJECTTAGGING WHERE  INSTITUTECODE='"+mInst+"' and ACADEMICYEAR='"+academicyear+"' " +
                                         " AND EXAMCODE='"+mExam+"'   AND  SUBJECTID='"+mSubject+"'" +
                                 " AND SECTIONBRANCH=decode('"+mSection+"','ALL',sectionbranch,'"+mSection+"') AND " +
                                 " SUBSECTIONCODE=decode('"+mSubsection+"','ALL',SUBSECTIONCODE,'"+mSubsection+"') " +
                                 " AND EMPLOYEEID='"+rs.getString("EMPLOYEEID")+"' and ltp='"+mLTP+"' and SEMESTERTYPE=decode('"+mSems+"','ALL',SEMESTERTYPE,'"+mSems+"') ";
                                 rs1=db.getRowset(qry1);
                              //out.print(qry1+"<br>");
                                 if(rs1.next())
									{
                                     mcheck="checked";
									mColor="pink";
									}
                                 else
									{
                                     mcheck="";
									 mColor="";
									}


                             %>

                            <TR BGCOLOR="<%=mColor%>">
                                <td>
                            <INPUT TYPE="CHECKBOX" NAME="Facultychk"  id="Facultychk" <%=mcheck%>
 value="<%=rs.getString("EMPLOYEEID")%>" >
                               </td>
                                <TD><%=rs.getString("EMPLOYEENAME")%></TD>
                                <TD><%=rs.getString("EMPLOYEECODE")%></TD>
                            </TR>
                            <%
                                }
                            %>


                            </TABLE>
                        </TD>

                        <TD width="50%" valign="TOP">

                            <TABLE border='1' width="100%" class="sort-table" id="table-1">

							<TR bgcolor="#ff8c00">
                                <TD NOWRAP>All Check</TD>
								<TD><B>Prog.Code</B></TD>
								<TD><B>Section</B></TD>
								<TD><B>SubSect</B></TD>
                                <TD><B>Count(Stud)</B></TD>
							</TR>



                                <%

qry1="SELECT DISTINCT  a.EMPLOYEEID,nvl(A.PROGRAMCODE,' ')PROGRAMCODE, nvl(A.SUBJECTID,' ')SUBJECTID," +
        " nvl(C.SUBJECTCODE,' ')SUBJECTCODE,nvl(C.SUBJECT,' ')SUBJECT,nvl(a.SECTIONBRANCH,' ')SECTIONBRANCH," +
        " nvl(a.SUBSECTIONCODE,' ')SUBSECTIONCODE" +
        " FROM FACULTYSUBJECTTAGGING  A,SUBJECTMASTER C" +
        " WHERE A.EXAMCODE='"+mExam+"' AND A.ACADEMICYEAR='"+academicyear+"' and  a.SEMESTERTYPE=decode('"+mSems+"','ALL',a.SEMESTERTYPE,'"+mSems+"')   " +
        " AND A.SUBJECTID='"+mSubject+"' AND A.LTP='"+mLTP+"' " +
        " AND A.SECTIONBRANCH=decode('"+mSection+"','ALL',sectionbranch,'"+mSection+"')" +
        " AND A.SUBSECTIONCODE=decode('"+mSubsection+"','ALL',SUBSECTIONCODE,'"+mSubsection+"') " +
        " AND NVL(A.DEACTIVE,'N')='N' AND NVL(C.DEACTIVE,'N')='N' " +
        " AND A.INSTITUTECODE='"+mInst+"' AND A.SUBJECTID=C.SUBJECTID AND A.INSTITUTECODE=C.INSTITUTECODE " +
        " AND A.SUBJECTID  IN ( SELECT B.SUBJECTID  FROM PR#DEPARTMENTSUBJECTTAGGING B WHERE " +
        " B.EXAMCODE='"+mExam+"'  AND B.INSTITUTECODE='"+mInst+"' AND B.DEPARTMENTCODE='"+mDept+"' AND NVL(B.DEACTIVE,'N')='N'  )" +
        " UNION SELECT DISTINCT  a.EMPLOYEEID,A.PROGRAMCODE,A.SUBJECTID,C.SUBJECTCODE,C.SUBJECT,a.SECTIONBRANCH," +
        " a.SUBSECTIONCODE  FROM FACULTYSUBJECTTAGGING  A,SUBJECTMASTER C WHERE A.EXAMCODE='"+mExam+"'  and    a.SEMESTERTYPE=decode('"+mSems+"','ALL',a.SEMESTERTYPE,'"+mSems+"')   " +
        " AND NVL(A.DEACTIVE,'N')='N' AND  NVL(C.DEACTIVE,'N')='N' AND A.INSTITUTECODE='"+mInst+"' " +
        " AND A.SUBJECTID='"+mSubject+"' AND A.LTP='"+mLTP+"' AND A.SECTIONBRANCH=decode('"+mSection+"','ALL',sectionbranch,'"+mSection+"') " +
        " AND A.SUBSECTIONCODE=decode('"+mSubsection+"','ALL',SUBSECTIONCODE,'"+mSubsection+"') AND A.SUBJECTID=C.SUBJECTID" +
        " AND A.INSTITUTECODE=C.INSTITUTECODE  " +
        " ORDER BY SUBJECTID";

//out.print(qry1);
rs1=db.getRowset(qry1);
while(rs1.next())
    { j++;
                                %>
                                 <input type="hidden" name="mSect<%=j%>" id="mSect<%=j%>"
                               value="<%=rs1.getString("SECTIONBRANCH")%>">

                               <input type="hidden" name="mSubSect<%=j%>" id="mSubSect<%=j%>"
                               value="<%=rs1.getString("SUBSECTIONCODE")%>">

                               <input type="hidden" name="mProg<%=j%>" id="mProg<%=j%>"
                               value="<%=rs1.getString("PROGRAMCODE")%>">
                            <TR >
								<TD>
                               <INPUT TYPE="checkbox" NAME="regbatch<%=j%>" id="regbatch<%=j%>" checked value="Y">

                                </TD>


                                <TD><B><%=rs1.getString("PROGRAMCODE")%></B></TD>
								<TD><B><%=rs1.getString("SECTIONBRANCH")%></B></TD>
								<TD><B><%=rs1.getString("SUBSECTIONCODE")%></B></TD>
                                <%
                                qry=" SELECT COUNT(STUDENTID)studcount  FROM v#STUDENTLTPDETAIL A" +
                                        " WHERE a.examcode = '"+mExam+"' and a.INSTITUTECODE='"+mInst+"' " +
                                        " AND  a.subjectid = '"+mSubject+"' AND a.SEMESTERTYPE=decode('"+mSems+"','ALL',a.SEMESTERTYPE,'"+mSems+"')   " +
                                        " AND a.sectionbranch = DECODE ('"+rs1.getString("SECTIONBRANCH")+"', 'ALL', sectionbranch,'"+rs1.getString("SECTIONBRANCH")+"')" +
                                        " AND a.subsectioncode =DECODE ('"+rs1.getString("SUBSECTIONCODE")+"','ALL', subsectioncode,'"+rs1.getString("SUBSECTIONCODE")+"' )" +
                                        "  AND NVL (a.deactive, 'N') = 'N' " +
                                        " AND NVL (A.deactive, 'N') = 'N' AND NVL(A.STUDENTDEACTIVE,'N')='N'" +
                                        "            AND a.institutecode = '"+mInst+"'  AND A.LTP='"+mLTP+"'      ";
								//out.print(qry);
                                rs=db.getRowset(qry);
                                if(rs.next())
                                    {
                                    mStudCount=rs.getString("studcount");
                                    }
                                %>
								<TD><B><%=mStudCount%></B></TD>
							</TR>


                            <%
                            }

%>
<input type="hidden" name="BatchCount"  id="BatchCount" value="<%=j%>">
                         </TABLE>
                           </TD>

                      </TR>
                      <TR ALIGN="CENTER" >
                          <TD ALIGN="CENTER"  COLSPAN="5">
                         <INPUT TYPE="SUBMIT" NAME="SAVE" ID="SAVE" VALUE="SAVE">
                      </TD></TR>
                      </TABLE>

</form>
    <% }
    int mFlag=0;   String mSBatchChk="",mSect="",mSubSect="",mProg="";
    //  out.print(request.getParameter("y")+"**"+mFlag);
       if(request.getParameter("y")!=null)
           {
%>
<form name="FRM">
    <%
//out.print("dd"+request.getParameter("academicyear"));
       mExam=request.getParameter("Exam").toString().trim();
	   mSubject=request.getParameter("Subject").toString().trim();
	   mLTP=request.getParameter("LTP").toString().trim();
	   mSection=request.getParameter("Section").toString().trim();
	   mSubsection=request.getParameter("SubSection").toString().trim();
mSems =request.getParameter("SemType").toString().trim();
 academicyear =request.getParameter("academicyear")==null?"":request.getParameter("academicyear").toString().trim();
//out.print("dd"+academicyear);


 if(request.getParameter("Facultychk")!=null)
                   {
                        mFaculty=request.getParameter("Facultychk");
						//out.print(request.getParameter("Facultychk"));
                   }
               else
                   {
                    mFaculty="";
                   }
       // out.print(request.getParameter("Facultychk")+"mFac");
int mCount=Integer.parseInt( request.getParameter("BatchCount"));
//out.print(mCount);
        for (int  k=1; k<=mCount ;k++)
            {



               if(request.getParameter("regbatch"+k)!=null)
                   {
                        mSBatchChk=request.getParameter("regbatch"+k);
                   }
               else
                   {
                    mSBatchChk="";
                   }
                //  out.print(mSBatchChk+"DDDd"+mFaculty);
               %>
                <input type="hidden" name="Facultychk<%=k%>" id="Facultychk<%=k%>" value="<%=mFaculty%>">
               <input type="hidden" name="regbatch<%=k%>" id="regbatch<%=k%>" value="<%=mSBatchChk%>">
               <%

            if(mSBatchChk.equals("Y"))
                {
               if(request.getParameter("mSect"+k)!=null)
                   {
                        mSect=request.getParameter("mSect"+k);
                   }
               else
                   {
                   mSect="";
                   }

               if(request.getParameter("mProg"+k)!=null)
                   {
                        mProg=request.getParameter("mProg"+k);
                   }
               else
                   {
                   mProg="";
                   }

               if(request.getParameter("mSubSect"+k)!=null)
                   {
                        mSubSect=request.getParameter("mSubSect"+k);
                   }
               else
                   {
                   mSubSect="";
                   }

              //out.print("<BR>mSect:"+mSect+":mSubSect:"+mSubSect+":mProg:"+mProg);

               qry=" SELECT 'Y'  FROM facultysubjecttagging A " +
                 " WHERE a.ltp='"+mLTP+"' and a.examcode = '"+mExam+"' AND a.SEMESTERTYPE=decode('"+mSems+"','ALL',a.SEMESTERTYPE,'"+mSems+"')   " +
                 " AND  a.subjectid = '"+mSubject+"' " +
                 " AND a.sectionbranch = DECODE ('"+mSect+"', 'ALL', sectionbranch,'"+mSect+"') " +
                 " AND a.subsectioncode =DECODE ('"+mSubSect+"','ALL', subsectioncode,'"+mSubSect+"' )" +
                 " and a.programcode='"+mProg+"' " +
                 " AND NVL (a.deactive, 'N') = 'N' and a.INSTITUTECODE='"+mInst+"' " ;
             out.println(qry);
               rs=db.getRowset(qry);
               if (rs.next())
                   {
                    qry1="update facultysubjecttagging set employeeid='"+mFaculty+"', entrydate=sysdate," +
                            " entryby='"+mChkMemID+"' " +
                            " where ltp='"+mLTP+"' and INSTITUTECODE='"+mInst+"' and programcode='"+mProg+"'  and examcode = '"+mExam+"' and subjectid = '"+mSubject+"' " +
                            " AND sectionbranch = DECODE ('"+mSect+"', 'ALL', sectionbranch,'"+mSect+"')" +
                            " AND subsectioncode =DECODE ('"+mSubSect+"','ALL', subsectioncode,'"+mSubSect+"' ) " +
                            " AND NVL (deactive, 'N') = 'N' AND SEMESTERTYPE=decode('"+mSems+"','ALL',SEMESTERTYPE,'"+mSems+"')  ";

                  // out.print("<br>"+qry1);
                    int x=db.update(qry1);
                    if (x>0)
                      mFlag=1;

                    mcheck="";

                   }

               }
            }
    if(mFlag==1)
        out.print("<center> <font face=verdana  color=green size=2>Record Updated Successfully !</font>   </center>");
%>
<TABLE border='1' width="100%" class="sort-table" id="table-1" cellpadding=1 cellspacing=0>

							<TR bgcolor="#ff8c00">

								<TD><B>Faculty Name</B></TD>
								<TD><B>Faculty Code</B></TD>


                                <TD><B>Prog.Code</B></TD>
								<TD><B>Section</B></TD>
								<TD><B>SubSect</B></TD>
							</TR>
                            <%
                            qry="SELECT distinct a.EMPLOYEENAME,a.EMPLOYEECODE,a.SUBJECT,a.SUBJECTCODE,A.PROGRAMCODE," +
        "A.SECTIONBRANCH,A.SUBSECTIONCODE  FROM v#studentltpdetail a WHERE a.ltp = '"+mLTP+"'" +
        "   AND a.examcode = '"+mExam+"'   AND a.subjectid = '"+mSubject+"'" +
        "   AND a.sectionbranch = DECODE ('"+mSect+"', 'ALL', sectionbranch, '"+mSect+"')" +
        "   AND a.subsectioncode = DECODE ('"+mSubSect+"', 'ALL', subsectioncode, '"+mSubSect+"')" +
        "   AND a.programcode = '"+mProg+"'" +
        "   AND NVL (a.deactive, 'N') = 'N' AND a.SEMESTERTYPE=decode('"+mSems+"','ALL',a.SEMESTERTYPE,'"+mSems+"')   ";
						//out.print(qry);
rs=db.getRowset(qry);
while(rs.next())
    {
    %>
    <tr >
        <td> <%=rs.getString("EMPLOYEENAME")%> </td>
        <td> <%=rs.getString("EMPLOYEECODE")%> </td>
        <td> <%=rs.getString("PROGRAMCODE")%> </td>
        <td> <%=rs.getString("SECTIONBRANCH")%> </td>
             <td> <%=rs.getString("subsectioncode")%> </td>
    </tr>
    <%
    }
                               %>

                            <Tr>

                                </tr>
<%

mFlag=0;
%>
<input type="hidden" name="SemType"  value="<%=mSems%>">

<input type="hidden" name="Exam" value="<%=mExam%>">
    <input type="hidden" name="Subject" value="<%=mSubject%>">
        <input type="hidden" name="LTP" value="<%=mLTP%>">
            <input type="hidden" name="Section" value="<%=mSection%>">
                <input type="hidden" name="SubSection" value="<%=mSubsection%>">
				<input type="hidden" name="academicyear" value="<%=academicyear%>">


</form>
<%






           }






                //-----------------------------
                //---Enable Security Page Level
                //-----------------------------
                } else {
        %>
        <br>
        <font color=red>
            <h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
            <P>	This page is not authorized/available for you.
            <br>For assistance, contact your network support team.
        </font>	<br>	<br>	<br>	<br>
        <%                }
            //-----------------------------
            } else {
                out.print("<br><img src='../../Images/Error1.jpg'>");
                out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
            }
        } catch (Exception e) {
            // out.print("error"+qry1);
        }
        %>
    </body>
</html>
