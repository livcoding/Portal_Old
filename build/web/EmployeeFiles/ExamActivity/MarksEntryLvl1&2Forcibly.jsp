<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%

        String mHead = "";
        if (session.getAttribute("PageHeading") != null && !session.getAttribute("PageHeading").equals("")) {
            mHead = session.getAttribute("PageHeading").toString().trim();
        } else {
            mHead = "JIIT ";
        }

%>
<html>
<head>
    <TITLE>#### <%=mHead%> [ Forcibly Marks Entry ] </TITLE>
	<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
    <script language="JavaScript" type ="text/javascript">
        <!--
        if (top != self) top.document.title = document.title;



        function kH(e)
        {
            var pK = document.all? window.event.keyCode:e.which;
            return pK != 13;
        }

        document.onkeypress = kH;
        if (document.layers) document.captureEvents(Event.KEYPRESS);

        -->

    </script>
    <SCRIPT LANGUAGE="JavaScript">
        <!-- Beginning of JavaScript -
         function Marks_Check(objtxtnew,mMax1,objtxtold)
         {
         
       
            if(objtxtnew.value!='' && objtxtnew.value.length>0)
                {
                   var newm=0.0;
                   var mMax=0.0;
                   var entry=objtxtnew.value;
                    if(parseFloat(entry)>=0)
                    {
                     newm=parseFloat(objtxtnew.value);
                     mMax=parseFloat(mMax1);
                        if(newm>mMax)
                            {
                               var mChoice=confirm('Marks must be <='+mMax);
                               if(mChoice)
                                   {
                                objtxtnew.value='';
                               
                                objtxtnew.focus;
                                   }
                                   else
                                       {
                                         /////
                                       }
                            }
                            else
                                {
                                    ///
                                }

                        }
         }
          else
            {
                alert('you can not left marks entry field blank!');
                objtxtnew.focus;
            }
         }

/*
        function Marks_Check(objchknew,objtxtnew,mMax1,objchkold,objtxtold)
        {
            var print;
            if(objchkold.value=='D')
                print='Detained';
            else
                print='Absent';

            if(objchkold.value=='N' && objtxtnew.value=='')
            {
                alert('you can not left marks entry field blank! Previous marks is '+ objtxtold.value +'.');

            }
            else
            {

                if(objtxtnew.value!='' && objtxtnew.value.length>0)
                {
                    var oldm=0.0;
                    var newm=0.0;
                    var mMax=0.0;
                    var mNewS='';
                    var entry=objtxtnew.value;
                    if(parseFloat(entry)>=0)
                    {
                        mNewS=objtxtnew.value;
                        oldm=parseFloat(objtxtold.value);
                        ///alert("oldm :"+oldm);
                        newm=parseFloat(objtxtnew.value);
                        //alert("newm :"+newm);
                        mMax=parseFloat(mMax1);
                        if(objchkold.value=='D' || objchkold.value=='A')
                        {
                            if(newm<=mMax)
                            //		if(oldm<=mMax1)
                            {
                                var mChoice=confirm('Now, Student has been '+print+'! Do You want to remove Old '+print+' Flag? with New Marks : '+ newm +' ?');
                                if(mChoice)
                                {
                                    objchknew.checked=false;
                                    objchkold.value='N';
                                    objtxtold.value=newm ;
                                    objtxtnew.value=newm;
                                    objtxtnew.focus;
                                }
                                else
                                {
                                    objtxtnew.value='';
                                    objchknew.focus;
                                }

                            }
                            else
                            {
                                alert('Marks must be <='+mMax);
                                objtxtnew.value='';
                                objtxtnew.focus;
                            }

                        }
                        else if(objchkold.value=='N' && newm!=oldm && newm<=mMax)
                        {
                            var mChoice=confirm('Old marks :'+oldm+'  does not match with new: '+newm+' Replace Old Marks :'+oldm+' with New Marks : '+ newm+' ?');
                            if(mChoice)
                            {
                                objtxtold.value=newm;
                                objchknew.checked=false;
                                objchkold.value='N';
                                objtxtnew.value=newm;
                                objtxtnew.focus;

                            }
                            else
                            {
                                objtxtnew.value='';
                                objtxtnew.focus;
                            }
                        }
                        else if(objchkold.value=='N' && newm==oldm)
                        {
                            objchknew.checked=false;
                            objtxtnew.focus;
                        }
                        else if(newm>mMax)
                        {
                            alert('Marks must be <='+mMax);
                            objtxtnew.value='';
                            objtxtnew.focus;

                        }
                    }
                    else
                    {
                        alert('Invalid Marks!');
                        objtxtnew.value='';
                        objtxtnew.focus;
                    }
                }
            }
        }

        function detained_check(objchknew,objtxtnew,objchkold,objtxtold,mFlag)
        {
            var print;

            if(mFlag=='D')
                print='Detained';
            else
                print='Absent';
            //alert("New :"+objchknew.value);
            //alert("Old :"+objchkold.value);

            if(objchknew.value!='N')
            {
                if(objchkold.value==mFlag)
                {

                    objtxtold.value='-1';
                    objtxtnew.value='';
                    objchknew.checked=true;
                    objchknew.focus;
                }
                else
                {
                    var mChoice=confirm('Old Marks is : '+objtxtold.value +' Do you want to '+print+' Students (old and new marks will be removed)?');
                    if(mChoice)
                    {
                        objtxtold.value='-1';
                        objtxtnew.value='';
                        //objchknew.checked=true;
                        objchkold.value=mFlag;
                        //	objchkn//	oew.focus;
                        objtxtnew.disabled=true;
                    }
                    else
                    {
                        //	objchknew.checked=false;
                        //	objchknew.focus;
                    }
                }
            }
            else   ///objchknew.value=='N'
            {
                if(objchkold.value=='N')
                {
                    //	objchknew.checked=false;
                    //	objchknew.focus;
                }
                else
                {
                    var mChoice=confirm('Student already '+print+'! Do you want to remove '+print+' flag and enter marks?');
                    if(mChoice)
                    {
                        //	objchknew.checked=false;
                        objchkold.value='N';
                        //	objchknew.focus;
                        objtxtnew.disabled=false;
                        // objtxtold.focus;
                    }
                    else
                    {
                        //	objchknew.checked=true;
                        //	objchknew.focus;
                    }
                }
            }


        }*/

        function ChangeOpt(mevent,DataComboSubject,Subject)
        {
            // alert("aaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
            var mflag=0;
            var ssec='?';
            removeAllOptions(Subject);
            mflag=0;

    <%--var optn = document.createElement("OPTION");
            optn.text='ALL';
            optn.value='All';
            Subject.options.add(optn);--%>

                    for(i=0;i<DataComboSubject.options.length;i++)
                    {
                        var v1s;
                        var pos1;
                        var pos2;
                        var exams;
                        var events;
                        var lens;
                        var subjects;
                        var otexts;
                        var v1s=DataComboSubject.options(i).value;
                        lens=v1s.length ;
                        pos1=v1s.indexOf('***');
                        //pos2=v1s.indexOf('///');
                        //exams=v1s.substring(0,pos1);
                        events=v1s.substring(0,pos1);
                        //events=v1s.substring(pos1+3,pos2);

                        subjects=v1s.substring(pos1+3,lens);
                        if ( mevent==events)
                        {
                            var optns = document.createElement("OPTION");
                            optns.text=DataComboSubject.options(i).text;
                            optns.value=subjects;
                            Subject.options.add(optns);
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



                if(window.history.forward(1) != null)
                    window.history.forward(1);

                // - End of JavaScript - -->
    </SCRIPT>



</head>

<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 onkeydown="if(event.keyCode==13){event.keyCode=9;return event.keyCode}"  onload="ChangeOpt(Event.value,ComboSubject,Subject);">
<%
        GlobalFunctions gb = new GlobalFunctions();
        DBHandler db = new DBHandler();
        String mMemberID = "", mMemberType = "", mMemberName = "", mMemberCode = "";
        String mDMemberCode = "", mDMemberType = "", mDept = "", mDesg = "", mInst = "", mComp = "", mDMemberID = "";
        String mExam = "", mexam = "", mExamid = "", mEventsubevent = "", mSubj = "", msubj = "";
        String qry = "", qry1 = "", x = "", qrymevent = "";
        int msno = 0;
        double mvalue = 0, mMaxmarks = 0, MyMax = 0, mchkmarks = 0;
        String mmvalue = "", qrys = "";
        int ctr = 0;
        String mIC = "", mEC = "", mSC = "", mList = "", mOrder = "", mEvent = ""; //,mExamsubevent="",mExamevent="";
        ResultSet rs = null, rss = null, rs1 = null, rs2 = null, rs3 = null, rse = null, rsm = null;
        String mMOP = "", mName5 = "", mlistorder = "";
        double mWeight = 0;
        int kk = 0;
        String msubeven = "", mMarks = "", mPerc = "", mName1 = "", mMark = "", mName2 = "", mName3 = "", mName4 = "", mName8 = "", mName9 = "";
        String mName6 = "", mName7 = "", mStatus = "", mPrint = "", mSE = "", mChk1 = "", mChk2 = "", mValue = "", meven = "";


//out.println("Global Maximum Inactive Interval of Session in Seconds is : " +session.getMaxInactiveInterval()); 
        session.setMaxInactiveInterval(10800);
//out.println("Special Maximum Inactive Interval of Session in Seconds is : " +session.getMaxInactiveInterval()); 

        if (session.getAttribute("CompanyCode") == null) {
            mComp = "";
        } else {
            mComp = session.getAttribute("CompanyCode").toString().trim();
        }

        if (session.getAttribute("InstituteCode") == null) {
            mInst = "";
        } else {
            mInst = session.getAttribute("InstituteCode").toString().trim();
        }


        if (session.getAttribute("Designation") == null) {
            mDesg = "";
        } else {
            mDesg = session.getAttribute("Designation").toString().trim();
        }

        if (session.getAttribute("Department") == null) {
            mDept = "";
        } else {
            mDept = session.getAttribute("Department").toString().trim();
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

        OLTEncryption enc = new OLTEncryption();
        if (!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) {
            mDMemberCode = enc.decode(mMemberCode);
            mDMemberType = enc.decode(mMemberType);
            mDMemberID = enc.decode(mMemberID);

            String mChkMemID = enc.decode(session.getAttribute("MemberID").toString().trim());
            String mChkMType = enc.decode(session.getAttribute("MemberType").toString().trim());
            String mIPAddress = session.getAttribute("IPADD").toString().trim();
            String mRole = enc.decode(session.getAttribute("ROLENAME").toString().trim());
            ResultSet RsChk1 = null;

            //-----------------------------
            //-- Enable Security Page Level
            //-----------------------------

            qry = "Select WEBKIOSK.ShowLink('236','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";
            RsChk1 = db.getRowset(qry);
            if (RsChk1.next() && RsChk1.getString("SL").equals("Y")) {
                //----------------------



%>
<form name="frm"  method="POST" >
    <input id="x" name="x" type=hidden>
    <table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD colspan=0 align=middle >
<font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana">   Forcibly Marks Entry <br>(After completing marks entry by the concerened faculty/co-ordinator.)</TD></font></td></tr></TABLE>
    <table   cellpadding=1 cellspacing=0 width="95%" align=center rules=groups border=1>
        <tr><td><font color=Green face=arial size=2><STRONG><%=mMemberName%>[<%=mDMemberCode%>]&nbsp;&nbsp; : &nbsp;<%=GlobalFunctions.toTtitleCase(mDesg)%>&nbsp; (<%=GlobalFunctions.toTtitleCase(mDept)%>)
        </td></tr>
        <tr><td>	<INPUT TYPE='HIDDEN' Name=InstCode tabindex="1" id="InstCode" VALUE=<%=mInst%>>
                <!--*********Exam**********-->
                <FONT color=black><FONT face=Arial size=2><STRONG>Exam Code</STRONG></FONT></FONT>
                <%
        try {
            qry = "Select distinct NVL(GRADEENTRYEXAMID,' ')GRADEENTRYEXAMID from COMPANYINSTITUTETAGGING Where InstituteCode='" + mInst + "' And CompanyCode='" + mComp + "'";
            rs = db.getRowset(qry);
            //out.print(qry);
            if (request.getParameter("x") == null) {
                %>
                <select name=Exam tabindex="2" id="Exam" style="WIDTH: 125px">
                    <%
                        while (rs.next()) {
                            mExamid = rs.getString("GRADEENTRYEXAMID");
                    %>
                    <OPTION selected Value =<%=mExamid%>><%=mExamid%></option>
                    <%
                        }
                    %>
                </select>
                <%
                    } else {
                %>
                <select name=Exam tabindex="2" id="Exam" style="WIDTH: 125px">
                    <%
                        while (rs.next()) {
                            mExamid = rs.getString("GRADEENTRYEXAMID");
                            if (mExamid.equals(request.getParameter("Exam").toString().trim())) {
                    %>
                    <OPTION selected Value =<%=mExamid%>><%=mExamid%></option>
                    <%
                        } else {
                    %>
                    <OPTION Value =<%=mExamid%>><%=mExamid%></option>
                    <%
                            }
                        }
                    %>
                </select>
                <%
            }

        } catch (Exception e) {
            //out.println(e.getMessage());
            }
                %>
                &nbsp;&nbsp;<FONT color=black><FONT face=Arial size=2><STRONG>Event-Subevent</STRONG></FONT></FONT>
                <%    try {


            qry = "select EVENTSUBEVENT from V#EXAMEVENTSUBJECTTAGGING a where ";
            // qry=qry+" trunc(sysdate) between trunc(FROMDATE) and trunc(TODATE) aND  ";
            // qry = qry + " CORDFACULTYTYPE=decode('" + mDMemberType + "','E','I','E') and CORDFACULTYID='" + mDMemberID + "' ";
            qry = qry + " fstid in (select fstid from studenteventsubjectmarks b where ";
            qry = qry + " nvl(locked,'N')='Y' and a.eventsubevent=b.eventsubevent ) and nvl(deactive,'N')='N' ";
            qry = qry + " and nvl(locked,'N')='N'  AND ExamCODE='" + mExamid + "'";
            qry = qry + " and nvl(PUBLISHED,'N')='Y' ";
            //qry=qry+" and nvl(PROCEEDSECOND,'N')='Y' and nvl(deactive,'N')='N'  GROUP BY EVENTSUBEVENT";
            qry = qry + " and nvl(deactive,'N')='N'  GROUP BY EVENTSUBEVENT ORDER BY EVENTSUBEVENT";

            rse = db.getRowset(qry);
            //out.print(qry);
            if (request.getParameter("x") == null) {
                %>
                <select name=Event tabindex="3" id="Event" style="WIDTH: 145px" onclick="ChangeOpt(Event.value,ComboSubject,Subject);" onchange="ChangeOpt(Event.value,ComboSubject,Subject);">
                    <%
                                   while (rse.next()) {
                                       mEventsubevent = rse.getString("EVENTSUBEVENT").toString().trim();
                                       if (meven.equals("")) {
                                           meven = mEventsubevent;
                                           qrymevent = mEventsubevent;
                    %>
                    <OPTION Value ="<%=mEventsubevent%>"><%=rse.getString("EVENTSUBEVENT")%></option>
                    <%
                        } else {
                    %>
                    <OPTION Value ="<%=mEventsubevent%>"><%=rse.getString("EVENTSUBEVENT")%></option>
                    <%
                                       }
                                   }
                    %>
                </select>
                <%

                               } else {
                %>
                <select name=Event tabindex="3" id="Event" style="WIDTH: 145px" onclick="ChangeOpt(Event.value,ComboSubject,Subject);" onchange="ChangeOpt(Event.value,ComboSubject,Subject);">
                    <%
                                   while (rse.next()) {
                                       mEventsubevent = rse.getString("EVENTSUBEVENT").toString().trim();

                                       if (mEventsubevent.equals(request.getParameter("Event").toString().trim())) {
                                           qrymevent = mEventsubevent;
                    %>
                    <OPTION selected Value ="<%=mEventsubevent%>"><%=rse.getString("EVENTSUBEVENT")%></option>
                    <%
                        } else {
                    %>
                    <OPTION Value ="<%=mEventsubevent%>"><%=rse.getString("EVENTSUBEVENT")%></option>
                    <%
                                       }
                                   }
                    %>
                </select>
                <%
            }

        } catch (Exception e) {
            //out.print("error");
            }
                %>

                &nbsp;&nbsp;<FONT color=black><FONT face=Arial size=2><STRONG>Order By</STRONG></FONT></FONT>
                <select name=listorder tabindex="5" id="listorder" style="WIDTH: 120px">
                    <% 	if (request.getParameter("listorder") == null) {
                    %>
                    <OPTION Value =Enrollmentno selected>Enrollment no.</option>
                    <OPTION Value =Studentname>Student Name</option>
                    <OPTION Value =Subsectioncode >Subsection/Group</option>
                    <%    } else {
        mlistorder = request.getParameter("listorder");
        if (mlistorder.equals("Enrollmentno")) {
                    %>
                    <OPTION Value =Enrollmentno selected>Enrollment no.</option>
                    <OPTION Value =Studentname >Student Name</option>
                    <OPTION Value =Subsectioncode >Subsection/Group</option>
                    <%            } else if (mlistorder.equals("Studentname")) {
                    %>
                    <OPTION Value =Enrollmentno >Enrollment no.</option>
                    <OPTION Value =Studentname selected>Student Name</option>
                    <OPTION Value =Subsectioncode >Subsection/Group</option>
                    <%            } else if (mlistorder.equals("Subsectioncode")) {
                    %>
                    <OPTION Value =Enrollmentno >Enrollment no.</option>
                    <OPTION Value =Studentname >Student Name</option>
                    <OPTION Value =Subsectioncode selected >Subsection/Group</option>
                    <%               }

        }
                    %>

                </select>
                <select name=order tabindex="6" id="order" style="WIDTH: 95px">

                <% 	if (request.getParameter("order") == null) {
                %>
                <OPTION Value =Asc selected>Ascending</option>
                <OPTION Value =Desc>Descending</option>

                <%    } else {
        mlistorder = request.getParameter("order");
        if (mlistorder.equals("Asc")) {
                %>
                <OPTION Value =Asc selected>Ascending</option>
                <OPTION Value =Desc>Descending</option>

                <%        } else {
                %>
                <OPTION Value =Asc >Ascending</option>
                <OPTION Value =Desc selected>Descending</option>

                <%               }
        }
                %>

        </td></tr>

        <!--********Subject*****-->
        <tr>
            <td>

                <FONT color=black><FONT face=Arial size=2><STRONG>Subject</STRONG></FONT></FONT>
                <%
        try {

            qry = "select EVENTSUBEVENT,subject ||' ( '||subjectcode||' )' subject,subjectID from V#EXAMEVENTSUBJECTTAGGING a where ";
            //qry=qry+" trunc(sysdate) between trunc(FROMDATE) and trunc(TODATE) AND ";
            //qry = qry + " CORDFACULTYTYPE=decode('" + mDMemberType + "','E','I','E') and CORDFACULTYID='" + mDMemberID + "' ";
            qry = qry + " fstid in (select fstid from studenteventsubjectmarks b where ";
            qry = qry + "  nvl(locked,'N')='Y' and a.eventsubevent=b.eventsubevent ) and nvl(deactive,'N')='N' ";
            qry = qry + " and nvl(locked,'N')='N' and eventsubevent='" + qrymevent + "' AND ExamCODE='" + mExamid + "'";
            //qry=qry+" and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P') and nvl(PROCEEDSECOND,'N')='Y' GROUP BY subject||' ( '||subjectcode||' )',subjectID";
            qry = qry + " and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P') and nvl(PUBLISHED,'N')='Y' GROUP BY EVENTSUBEVENT,subject||' ( '||subjectcode||' )',subjectID order By subject";

            // out.print(qry);

            rss = db.getRowset(qry);
            if (request.getParameter("x") == null) {
                %>
                <select name=Subject tabindex="4" id="Subject" style="WIDTH: 550px">

                    <%
                        while (rss.next()) {
                            mSubj = rss.getString("SubjectID");

                    %>
                    <OPTION Value =<%=mSubj%>><%=rss.getString("Subject")%></option>
                    <%
                        }
                    %>
                </select>
                <%
                    } else {
                %>
                <select name=Subject tabindex="4" id="Subject" style="WIDTH: 550px">

                    <%

                        while (rss.next()) {
                            mSubj = rss.getString("SubjectID");
                            if (mSubj.equals(request.getParameter("Subject").toString().trim())) {

                    %>
                    <OPTION selected Value =<%=mSubj%>><%=rss.getString("Subject")%></option>
                    <%
                       } else {
                    %>
                    <OPTION Value =<%=mSubj%>><%=rss.getString("Subject")%></option>
                    <%
                            }
                        }
                    %>
                </select>
                <%
            }
        } catch (Exception e) {
        }
        /*----------------------------------------------DataCombo for subject------------------------------*/

        qry = "select EVENTSUBEVENT,subject ||' ( '||subjectcode||' )' subject,subjectID from V#EXAMEVENTSUBJECTTAGGING a where ";
        //qry=qry+" trunc(sysdate) between trunc(FROMDATE) and trunc(TODATE) AND ";
        //qry = qry + " CORDFACULTYTYPE=decode('" + mDMemberType + "','E','I','E') and CORDFACULTYID='" + mDMemberID + "' ";
        qry = qry + " fstid in (select fstid from studenteventsubjectmarks b where ";
        qry = qry + "  nvl(locked,'N')='Y' and a.eventsubevent=b.eventsubevent ) and nvl(deactive,'N')='N' ";
        qry = qry + " and nvl(locked,'N')='N' AND ExamCODE='" + mExamid + "'";
        //qry=qry+" and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P') and nvl(PROCEEDSECOND,'N')='Y' GROUP BY subject||' ( '||subjectcode||' )',subjectID";
        qry = qry + " and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P') and nvl(PUBLISHED,'N')='Y' GROUP BY EVENTSUBEVENT,subject||' ( '||subjectcode||' )',subjectID order By subject";

        // out.print(qry);
        rss = db.getRowset(qry);
                %>

                <select name=ComboSubject  id="ComboSubject" style="WIDTH: 0px">

                    <%
        //rss.beforeFirst();
        if (request.getParameter("x") == null) {

            while (rss.next()) {

                mValue = rss.getString(1) + "***" + rss.getString(3);


                    %>
                    <OPTION Value =<%=mValue%>><%=rss.getString("subject")%></OPTION>
                    <%
                        }

                    } else {
                        while (rss.next()) {
                            mValue = rss.getString(1) + "***" + rss.getString(3);
                            if (request.getParameter("ComboSubject").equals(mValue)) {
                    %>
                    <OPTION Value =<%=mValue%> selected><%=rss.getString("subject")%></OPTION>
                    <%
                               } else {
                    %>
                    <OPTION Value =<%=mValue%> ><%=rss.getString("subject")%></OPTION>
                    <%
                }

            }
        }
                    %>
                </select>
                <%
        /***********************************************************End of DataCombo of Subject**********************************/
                %>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<INPUT Type="submit" tabindex="7" Value="Submit">
        </td></tr>
</table></form>
<%        int tabctrtxt = 7;
        int tabctrchk = 1000;
        if (request.getParameter("x") != null) {
            if (request.getParameter("Subject") != null && request.getParameter("Event") != null && request.getParameter("Exam") != null) {
                mIC = request.getParameter("InstCode").toString().trim();
                mEC = request.getParameter("Exam").toString().trim();
                mSC = request.getParameter("Subject").toString().trim();
                mList = request.getParameter("listorder").toString().trim();
                mOrder = request.getParameter("order").toString().trim();
                mEvent = request.getParameter("Event").toString().trim();

                int len = 0;
                int pos = 0;
                len = mEvent.length();
                pos = mEvent.indexOf("#");
                if (pos > 0) {
                    mSE = mEvent.substring(0, pos);
                } else {
                    mSE = mEvent;
                }
                try {
                    qrys = "select nvl(detainedstatus,'A')detainedstatus from exameventmaster ";
                    qrys = qrys + " where institutecode='" + mIC + "' and  examcode='" + mEC + "' and  exameventcode='" + mSE + "' ";
                    //out.print(qrys);

                    ResultSet rsStatus = db.getRowset(qrys);
                    if (rsStatus.next()) {
                        mStatus = rsStatus.getString("detainedstatus");
                    //out.print("mStatus :"+mStatus);
                    }
                } catch (Exception e) {
                }
                if (mStatus.equals("D")) {
                    mPrint = "Detained";
                } else if (mStatus.equals("A")) {
                    mPrint = "Absent";
                } else {
                    mPrint = "Absent/Detained";
                }


                qry = "select  WEIGHTAGE, MARKSORPERCENTAGE, MAXMARKS from V#EXAMEVENTSUBJECTTAGGING  ";
                qry = qry + " where institutecode='" + mIC + "' and  examcode='" + mEC + "'";// and CORDFACULTYID ='" + mDMemberID + "'";
                qry = qry + " And EVENTSUBEVENT='" + mEvent + "' and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P') and subjectID='" + mSC + "'"; //and CORDFACULTYTYPE=decode('" + mDMemberType + "','E','I','E')
                //out.print(qry);
                rsm = db.getRowset(qry);
                if (rsm.next()) {
                    mMOP = rsm.getString("MARKSORPERCENTAGE");


                    mMaxmarks = rsm.getDouble("MAXMARKS");
                    mWeight = rsm.getDouble("WEIGHTAGE");
                }

                if (mMOP.equals("M")) {
                    MyMax = mMaxmarks;
                } else {
                    MyMax = 100;
                }
//out.print(mMOP);

                try {
                    /*
                    qry="select fstid,nvl(studentid,' ')studentid,nvl(studentname,' ')studentname, ";
                    qry=qry+" nvl(enrollmentno,' ')enrollmentno,nvl(semester,0)semester,subsectioncode, ";
                    qry=qry+ "nvl(programcode,' ')programcode,nvl(SECTIONBRANCH,' ')SECTIONBRANCH from V#EXAMEVENTSUBJECTTAGGING a ";
                    qry=qry+" where institutecode='"+mIC+"' and nvl(PROCEEDSECOND,'N')='Y' and nvl(locked,'N')='N' and ";
                    qry=qry+" EVENTSUBEVENT='"+mEvent+"' and nvl(a.DEACTIVE,'N')='N' and  ";
                    qry=qry+" examcode='"+mEC+"' and employeeid='"+mDMemberID+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and (ltp='L' OR PROJECTSUBJECT='Y') and subjectID='"+mSC+"' and ";
                    qry=qry+"  exists (select studentid from V#STUDENTEVENTSUBJECTMARKS b where b.fstid=a.fstid and b.EVENTSUBEVENT=a.EVENTSUBEVENT and a.studentid=b.studentid and nvl(b.LOCKED,'N')='N' and (b.LTP='L' OR PROJECTSUBJECT='Y')) ";
                    qry=qry+"  GROUP BY fstid,nvl(studentid,' '),nvl(studentname,' '), ";
                    qry=qry+"  nvl(enrollmentno,' '),nvl(semester,0),subsectioncode, ";
                    qry=qry+"  nvl(programcode,' '),nvl(SECTIONBRANCH,' ') ";
                    qry=qry+"  order by "+mList+ " "+mOrder+ " ,enrollmentno " ;
                     */

                    if (mMOP.equals("M")) {
%>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Mode of Entry:&nbsp;</STRONG></FONT>Marks
&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Maximum Marks:</STRONG></FONT><%=mMaxmarks%>
&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Weightage:</STRONG></FONT><%=mWeight%>
<%
            } else {
%>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Mode of Entry:&nbsp;</STRONG></FONT>Percentage
&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Maximum Marks:&nbsp;</STRONG></FONT><%=mMaxmarks%>
&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Weightage:</STRONG></FONT><%=mWeight%>
<%
            }

%>	
<table  cellspacing=0 cellpadding=0 width=98% border=1 align=center>
    <form name="frm1"  method="post" action="MarksEntryLvl1&2ForciblyAction.jsp">
        <tr  bgcolor="#ff8c00">
        <td><b><font color=white>SNo.</font></b></td>
        <td><b><font color=white>Enroll. No</font></b></td>
        <td><b><font color=white>Student Name</font></b></td>
        <td align="center"><b><font color=white><%=mPrint%></font></b></td>
        <td align=center><b><font color=white> Marks</font></b></td>
        <td nowrap><b><font color=white>Course(Section Branch)</font></b></td>
        <td><b><font color=white>Sem.</font></b></td>
        <%

            qry = "select fstid,nvl(studentid,' ')studentid,nvl(studentname,' ')studentname, ";
            qry = qry + " nvl(enrollmentno,' ')enrollmentno,nvl(semester,0)semester,subsectioncode, ";
            qry = qry + "nvl(programcode,' ')programcode,nvl(SECTIONBRANCH,' ')SECTIONBRANCH from V#EXAMEVENTSUBJECTTAGGING a ";
            //qry=qry+" where institutecode='"+mIC+"' and nvl(PROCEEDSECOND,'N')='Y' and nvl(locked,'N')='N' and ";
            qry = qry + " where institutecode='" + mIC + "' and nvl(PUBLISHED,'N')='Y' and nvl(locked,'N')='N' and ";
            qry = qry + " EVENTSUBEVENT='" + mEvent + "' and nvl(a.DEACTIVE,'N')='N' and  ";
            qry = qry + " Examcode='" + mEC + "' and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P') and subjectID='" + mSC + "' and ";//and CORDFACULTYID='" + mDMemberID + "' and CORDFACULTYTYPE=decode('" + mDMemberType + "','E','I','E')
            qry = qry + " Exists (select studentid from V#STUDENTEVENTSUBJECTMARKS b where b.fstid=a.fstid and b.EVENTSUBEVENT=a.EVENTSUBEVENT and a.studentid=b.studentid and nvl(b.LOCKED,'N')='Y' and (NVL(b.DETAINED,'N')='M') and (b.LTP='L' OR (B.LTP='E' AND B.PROJECTSUBJECT='Y') OR B.LTP='P')) ";
            qry = qry + " GROUP BY fstid,nvl(studentid,' '),nvl(studentname,' '), ";
            qry = qry + " nvl(enrollmentno,' '),nvl(semester,0),subsectioncode, ";
            qry = qry + " nvl(programcode,' '),nvl(SECTIONBRANCH,' ') ";
            qry = qry + " order by " + mList + " " + mOrder + " ,enrollmentno ";
            //out.println(qry);
            rs1 = db.getRowset(qry);
            msno = 0;
            ctr = 0;

            while (rs1.next()) {
                ctr++;
                msno++;
                tabctrtxt++;
                tabctrchk++;
                mName1 = "Semester" + String.valueOf(ctr).trim();
                mName2 = "Studentid" + String.valueOf(ctr).trim();
                mName3 = "Marks" + String.valueOf(ctr).trim();
                mName4 = "Detained" + String.valueOf(ctr).trim();
                mName5 = "Fstid" + String.valueOf(ctr).trim();
        %>
        <tr>
            <td><%=msno%>.</td>
            <td><%=rs1.getString("enrollmentno")%></td>
            <td><%=GlobalFunctions.toTtitleCase(rs1.getString("studentname"))%></td>

            <%
                qry = "Select nvl(MARKSAWARDED2,-1)OLDMARKSAWARDED2,nvl(MARKSAWARDED1,-1)OLDMARKSAWARDED1, ";
                qry = qry + " nvl(DETAINED2,'N') OLDDETAINED2, NVL(DETAINED,'N') OLDDETAINED1 from V#STUDENTEVENTSUBJECTMARKS ";
                qry = qry + " where INSTITUTECODE='" + mIC + "' and EXAMCODE='" + mEC + "' and ";
                qry = qry + " EVENTSUBEVENT='" + mEvent + "' and   ";
                qry = qry + " fstid='" + rs1.getString("fstid") + "' and STUDENTID='" + rs1.getString("studentid") + "' ";

                rs3 = db.getRowset(qry);
                x = "";
                kk = 0;
                if (mMOP.equals("P")) {
                    x = "%";
                }
                if (rs3.next()) {
                    //out.print("::::::::::::::"+rs3.getString("OLDDETAINED1"));
                    mName6 = "OLDMARKSAWARDED" + String.valueOf(ctr).trim();
                    mName7 = "OLDDETAINED" + String.valueOf(ctr).trim();
                    mName8 = "Chkmarks" + String.valueOf(ctr).trim();
                    mName9 = "ChkmarksOld" + String.valueOf(ctr).trim();
                    %>
    <%--------------------------------

                    if ((rs3.getString("OLDDETAINED1")).equals("D") || (rs3.getString("OLDDETAINED1")).equals("A")|| (rs3.getString("OLDDETAINED1")).equals("M")) {
                        //**************************************************************
                        if (mStatus.equals("B")) {
                            if ((rs3.getString("OLDDETAINED1")).equals("D")) {
            %>
            <td align=center>
                <select name='<%=mName4%>' id='<%=mName4%>' onchange="return	detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');" onclick="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');">
                    <option value="N">NA</option>
                    <option value="A">Absent</option>
                    <option selected value="D">Detained</option>
            </select></td>
            <%
                        } else if ((rs3.getString("OLDDETAINED1")).equals("A")) {
            %>
            <td align=center>
                <select name='<%=mName4%>' id='<%=mName4%>' onchange="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');" onclick="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');">
                    <option value="N">NA</option>
                    <option selected value="A">Absent</option>
                    <option  value="D">Detained</option>
            </select></td>
            <%
                        }
                         else if ((rs3.getString("OLDDETAINED1")).equals("M")) {
            %>
            <td align=center>
                <select name='<%=mName4%>' id='<%=mName4%>' onchange="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');" onclick="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');">
                    <option value="N">NA</option>
                    <option selected value="A">MakeUp</option>
                    <option  value="D">Detained</option>
            </select></td>
            <%
                        }
                                                       else {
            %>
            <td align=center>
                <select name='<%=mName4%>' id='<%=mName4%>' onchange="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');" onclick="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');">
                    <option selected value="N">NA</option>
                    <option  value="A">Absent</option>
                    <option  value="D">Detained</option>
            </select></td>
            <%
                        }

                    }//end of mStatus
                    else if (mStatus.equals("D")) {

                        if ((rs3.getString("OLDDETAINED1")).equals("D")) {
            %><td align=center>
                <select name='<%=mName4%>' id='<%=mName4%>' onchange="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');" onclick="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');">
                    <option  value="N">NA</option>
                    <option selected value="D">Detained</option>
            </select></td>
            <%
            } else {
            %><td align=center>
                <select name='<%=mName4%>' id='<%=mName4%>' onchange="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');" onclick="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');">
                    <option selected value="N">NA</option>
                    <option value="D">Detained</option>
            </select></td>
            <%
                        }
                    } else if (mStatus.equals("A")) {

                        if ((rs3.getString("OLDDETAINED1")).equals("A")) {
            %><td align=center>
                <select name='<%=mName4%>' id='<%=mName4%>' onchange="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');" onclick="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');">
                    <option  value="N">NA</option>
                    <option selected value="A">Absent</option>
            </select></td>
            <%
            } if ((rs3.getString("OLDDETAINED1")).equals("M")) {
            %><td align=center>
                <select name='<%=mName4%>' id='<%=mName4%>' onchange="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');" onclick="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');">
                    <option  value="N">NA</option>
                    <option selected value="A">Make Up</option>
            </select></td>
            <%
                        }
                        else {
            %><td align=center>
                <select name='<%=mName4%>' id='<%=mName4%>' onchange="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');" onclick="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');">
                    <option selected value="N">NA</option>
                    <option value="A">Absent</option>
            </select></td>
            <%
                        }
                    } else {

            %>
            <td align=center>
                <select name='<%=mName4%>' id='<%=mName4%>' onchange="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');" onclick="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');">
                    <option selected value="N">NA</option>
                    <option value="A">Absent</option>
                </select>
            </td>
            <%
                    }
                    //******************************************************************
%>
            <td align=center><input tabindex="<%=tabctrtxt%>" type=text name='<%=mName3%>' id='<%=mName3%>'  style="WIDTH: 50px; height: 20px;" maxlength=7 onBlur="Marks_Check(<%=mName4%>,<%=mName3%>,<%=MyMax%>,<%=mName7%>,<%=mName8%>);"  onChange="Marks_Check(<%=mName4%>,<%=mName3%>,<%=MyMax%>,<%=mName7%>,<%=mName8%>);"><%=x%></td>
            <%
                }//end of rs3.getString("OLDDETAINED1");
                else { ------------------------------------------------------------------------------%>


                <%
                    if (mMOP.equals("P")) {
                        mvalue = gb.getRound((rs3.getDouble("OLDMARKSAWARDED1") * 100) / mMaxmarks, 2);
                    } else {
                        mvalue = rs3.getDouble("OLDMARKSAWARDED1");
                    }
                    if (mvalue < 0) {
                        mmvalue = "";
                    } else {
                        mmvalue = String.valueOf(mvalue);
                    }
            %>
            <%---


                    if (mStatus.equals("B")) {
            %><td align=center>
                <select name='<%=mName4%>' id='<%=mName4%>' onchange="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');" onclick="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');">
                    <option selected value="N">NA</option>
                    <option value="A">Absent</option>
                    <option value="D">Detained</option>
            </select></td>
            <%
                } else if (mStatus.equals("D")) {
            %><td align=center>
                <select name='<%=mName4%>' id='<%=mName4%>' onchange="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');" onclick="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');">
                    <option selected value="N">NA</option>
                    <option value="D">Detained</option>
            </select></td>
            <%
                } else {
            %><td align=center>
                <select name='<%=mName4%>' id='<%=mName4%>' onchange="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');" onclick="return detained_check(<%=mName4%>,<%=mName3%>,<%=mName7%>,<%=mName8%>,'<%=mStatus%>');">
                    <option selected value="N">NA</option>
                    <option value="A">Absent</option>
            </select></td>
            <%
                }
            %>        --------------------------------------------------------%>

            <td align="center"><%=mPrint%></td>
            <td align=center> <input tabindex="<%=tabctrtxt%>" type=text name='<%=mName3%>' id='<%=mName3%>' value='<%=mmvalue%>' style="WIDTH: 50px; height: 20px;" maxlength=7 onBlur="Marks_Check(<%=mName3%>,<%=MyMax%>,<%=mName8%>);" <%--onChange="Marks_Check(<%=mName3%>,<%=MyMax%>,<%=mName8%>);"--%> ><%=x%></td>
            <%
                //}//endof Else
              //  if (rs3.getString("OLDDETAINED1").equals("D") || rs3.getString("OLDDETAINED1").equals("A")) {
                    if (rs3.getString("OLDDETAINED1").equals("M")) {
                    mchkmarks = -1;
                } else if (mMOP.equals("P")) {
                    mchkmarks = gb.getRound((rs3.getDouble("OLDMARKSAWARDED1") * 100) / mMaxmarks, 2);
                } else {
                    mchkmarks = rs3.getDouble("OLDMARKSAWARDED1");
                }


            %>
            <input type=hidden name='<%=mName1%>' id='<%=mName1%>' value=<%=rs1.getString("semester")%>>
            <input type=hidden name='<%=mName2%>' id='<%=mName2%>' value=<%=rs1.getString("studentid")%>>
          
            <input type=hidden name='<%=mName5%>' id='<%=mName5%>' value=<%=rs1.getString("fstid")%>>
            <input type=hidden name='<%=mName7%>' id='<%=mName7%>' value=<%=rs3.getString("OLDDETAINED1")%>>
            <input type=hidden name='<%=mName8%>' id='<%=mName8%>' value=<%=mchkmarks%>>
            <input type=hidden name='<%=mName9%>' id='<%=mName9%>' value=<%=mchkmarks%>>
            <%
                // out.print("mName8:::::"+mName8);
                }//end of rs3.next()
%>
            <td>&nbsp; <%=rs1.getString("programcode")%>&nbsp;(<%=rs1.getString("SECTIONBRANCH")%>)</td>
            <td><%=rs1.getString("semester")%></td>
        </tr>
        <%
            }//end of While
            if (ctr > 0) {
        %>
        <tr><td colspan=7 align=center>
        <input type="submit" tabindex="<%=tabctrtxt%>" Value="Save Forcibly Marks Entry"></td></tr>
        <%
            }//end of rs1.next()
            else {
            }
        } catch (Exception e) {
            //out.print("error"+qry);
        }
        %>


        <input type=hidden name='institute' id='institute' value="<%=mIC%>">
        <input type=hidden name='Exam' id='Exam' value="<%=mEC%>">
        <input type=hidden name='EventSubevent' id='EventSubevent' value="<%=mEvent%>">
        <input type=hidden name='TotalCount' id='TotalCount' value="<%=ctr%>">
        <input type=hidden name='MaxMarks' id='MaxMarks' value="<%=mMaxmarks%>">
        <input type=hidden name='subjectcode' id='subjectcode' value="<%=mSC%>">
        <input type=hidden name='Marksorpercentage' id='Marksorpercentage' value="<%=mMOP%>">
        <input type=hidden name='Status' id='Status' value="<%=mStatus%>">
</form></table>
<%

            } else {
                out.print("<br><img src='../../Images/Error1.jpg'>");
                out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Mandatory items(Event,Subject,Exam.,etc.) must be entered. </font> <br>");
            }

        }
    //-----------------------------
    //-- Enable Security Page Level
    //-----------------------------
    } else {
%>
<br>
<font color=red>
    <h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
    <P>	This page is not authorized/available for you.
    <br>For assistance, contact your network support team.
</font>	<br>	<br>	<br>	<br>
<%            }
//-----------------------------


        } else {
            out.print("<br><img src='../../Images/Error1.jpg'>");
            out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
        }


%>
