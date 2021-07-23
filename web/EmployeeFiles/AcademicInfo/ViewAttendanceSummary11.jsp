<%@ page language="java" import="java.sql.*,java.math.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%

        DBHandler db = new DBHandler();
        ResultSet rs = null;
        ResultSet rs1 = null;
        ResultSet rs2 = null;
		double xL=0,xT=0,xP=0;
		String qertu="";
        ResultSet rsAtt = null, rsRowNum = null, RsChk1 = null, rsdt = null,rsyyyy=null,rsqertu=null;
        GlobalFunctions gb = new GlobalFunctions();
        String qry = "";

        String qry2 = "",mREGCONFIRMATIONDATE1="",qrtyyy="";
        String qry1 = "", mLTP = "";
        long mSNo = 0, dt = 0;
        String mMemberID = "";
        String mDMemberID = "";
        String mMemberType = "";
        String mDMemberType = "";
        String mMemberCode = "";
        String mDMemberCode = "", mtime1 = "", mtime2 = "";
        String mMemberName = "";
        String mInstitute = "",mSpecialApproval="";
        String mExam = "", mSubject = "", mexam = "", mSubj = "", mGroup = "", TRCOLOR = "#F8F8F8", mcolor = "", mCode = "", mES = "", mSubj1 = "";
        String mSection = "", mSubsection = "", mName1 = "", mName2 = "", mName3 = "", mName4 = "", mName5 = "", mName6 = "", mName7 = "";
        String mSExam = "",mREGCONFIRMATIONDATE="";
        String mSES = "";
        String qryexam = "", qrysubj = "", qrysec = "";
        String mPrn = "N", qsysdate = "";
        String mDate = "", mType = "", mltp1 = "";
        String mRollno = "", mName = "", mradio1 = "";
        String mDTfrom = "";
        String mDTupto = "",QryType="R";
        int Ctr = 0, mDiffInDate = 0,mREGCONFIRMATIONDATE1int =0;
        int LFST = 0, TFST = 0, PFST = 0, mRowNum = 4;
        double QryTotCls = 0, QryTotPrs = 0, mTotLCls = 0, mTotTCls = 0, mTotLPrs = 0, mTotTPrs = 0, mTLTCls = 0, mTLTPrs = 0, mPercAtt = 0;
        //BigDecimal QryPercAtt1=0.00 ;
        BigDecimal  bd=new  BigDecimal("0.00");


		 BigDecimal  QryPracPercDecimal=new  BigDecimal("0.00");
         BigDecimal  QryPercDecimal=new  BigDecimal("0.00");
        //*******Take QryPercAtt variable to double before it's the long data type
        double QryPercAtt = 0;
		
        String mtimepicker1 = "";
        String mtimepicker2 = "", mRightsID = "";
        String mInst = "", mComp = "", mSrcType = "",mColor="",QryAcad="",QryProgramCode="";
        if (session.getAttribute("InstituteCode") == null) {
            mInst = "";
        } else {
            mInst = session.getAttribute("InstituteCode").toString().trim();
        }
        mInstitute = mInst;
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
        if (request.getParameter("SrcType") == null) {
            mSrcType = "";
        } else {
            mSrcType = request.getParameter("SrcType").toString().trim();
        }
        if (mSrcType.equals("I")) {
            mRightsID = "83";
        }
        if (mSrcType.equals("A")) {
            mRightsID = "87";
        }
        if (mSrcType.equals("H")) {
            mRightsID = "84";
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
        <TITLE>#### <%=mHead%> [ Subjectwise Students Class Attendance ] </TITLE>

        <script type="text/javascript" src="js/sortabletable.js"></script>
        <link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

        <script language="JavaScript" type ="text/javascript">
       	function AlertMe()
		{

			dd.twait.value='';
		}

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
        <SCRIPT TYPE="text/javascript">

            // copyright 1999 Idocs, Inc. http://www.idocs.com
            // Distribute this script freely but keep this notice in place
            function numbersonly(myfield, e, dec)
            {
                var key;
                var keychar;

                if (window.event)
                    key = window.event.keyCode;
                else if (e)
                    key = e.which;
                else
                    return true;
                keychar = String.fromCharCode(key);

                // control keys
                if ((key==null) || (key==0) || (key==8) ||
                    (key==9) || (key==13) || (key==27) )
                    return true;

                // numbers
                else if ((("0123456789").indexOf(keychar) > -1))
                    return true;

                // decimal point jump
                else if (dec && (keychar == "."))
                {
                    myfield.form.elements[dec].focus();
                    return false;
                }
                else
                    return false;
            }
            //-->

        </SCRIPT>

        <script language="JavaScript" type ="text/javascript">
            function rad_check()
            {

                var p=0;
                var a=0;

                for (var i = 0; i < document.frm1.elements.length; i++)
                {
                    var e=document.frm1.elements[i];
                    if ((e.name != 'allbox') && (e.type == 'radio') && (e.value=='P') && (e.checked==true)  )
                    {
                        p++;
                    }
                    else if((e.name != 'allbox1') && (e.type == 'radio') && (e.value=='A') && (e.checked==true))
                    {
                        a++;
                    }
                }
                if(p>0 && a>0)
                {
                    document.frm1.allbox.checked=false;
                    document.frm1.allbox1.checked=false;
                }
                else if(p>0 && a<=0)
                {
                    document.frm1.allbox.checked=true;
                    document.frm1.allbox1.checked=false;
                }
                else if (a>0 && p<=0)
                {
                    document.frm1.allbox.checked=false;
                    document.frm1.allbox1.checked=true;
                }
                else if(a<=0 && p<=0)
                {
                    document.frm1.allbox.checked=false;
                    document.frm1.allbox1.checked=false;
                }
            }
        </script>
        <script type="text/javascript" src="js/TimePicker.js"></script>
        <SCRIPT LANGUAGE="JavaScript">
            function un_check()
            {
                var mFlag=0;
                for (var i = 0; i < document.frm1.elements.length; i++)
                {
                    var e = document.frm1.elements[i];
                    if ((e.name != 'allbox') && (e.type == 'radio') &&(e.value=='P'))
                    {
                        e.checked = document.frm1.allbox.checked;
                        if (mFlag==0 && document.frm1.allbox.checked==true)
                        {
                            document.frm1.allbox1.checked=false;
                            mFlag=1;
                        }
                    } } }
        </SCRIPT>

        <SCRIPT LANGUAGE="JavaScript">
            function un_check1()
            {
                var mFlag=0;
                for (var i = 0; i < document.frm1.elements.length; i++)
                {
                    var e = document.frm1.elements[i];
                    if ((e.name != 'allbox1') && (e.type == 'radio') &&(e.value=='A'))
                    {
                        e.checked = document.frm1.allbox1.checked;
                    }

                    if (mFlag==0 && document.frm1.allbox1.checked==true)
                    {
                        document.frm1.allbox.checked=false;
                        mFlag=1;
                    }

                }
            }
        </SCRIPT>
        <SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">
            function ChangeOptions(Exam,DataCombo,Subject,DataComboSec,Section,DataComboSub,SubSection)
            {
                // alert("in Function");
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
                //alert("in Section");
                removeAllOptions(Section);
                mflag=0;
                var optns = document.createElement("OPTION");
                optns.text='ALL';
                optns.value='ALL';
                Section.options.add(optns);
                ssec='ALL';

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
                //alert("in Sub Section");
                removeAllOptions(SubSection);
                var optns1 = document.createElement("OPTION");
                optns1.text='ALL';
                optns1.value='ALL';
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

                    if (exams==Exam && subj==scs1 && ssec=='ALL')
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
                //alert("in ChangeSubject");
                var mflag=0;
                var ssec='?';

                removeAllOptions(Section);
                mflag=0;
                var optns = document.createElement("OPTION");
                optns.text='ALL';
                optns.value='ALL';
                Section.options.add(optns);
                ssec='ALL';

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
                optns1.text='ALL';
                optns1.value='ALL';
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
                optns1.text='ALL';
                optns1.value='ALL';
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

                    if (exams==Exam && subj==scs1 && ssec=='ALL')
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
    <body onload="AlertMe()" aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
        <%
        try {
            if (!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) {
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
                if (RsChk.next() && RsChk.getString("SL").equals("Y")) {

                    qry = "select to_Char(Sysdate,'dd-mm-yyyy') date1 from dual";

                    rs = db.getRowset(qry);

                    if (rs.next()) {
                        qsysdate = rs.getString(1);
                    } else {
                        qsysdate = "";
                    }

                    //----------------------
%>
        <form name="frm"  method="post">
            <input id="x" name="x" type=hidden>
            <table align=center><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: Arial"><B>Student Wise Class Attendance  / Co-ordinator Wise Student Attendance List!</b></font></TABLE>
            <table id=id2 cellpadding=1 cellspacing=1  align=center rules=groups border=2>
                <!--Institute****-->
                <Input Type=hidden name=InstCode Value=<%=mInstitute%>>
                <tr><td nowrap>
                        <FONT color=black face=Arial size=2><b>Exam Code</b></FONT>
                        <%
                    try {

					// changes in qry done by satendra 

                          qry=" Select Exam, EXAMPERIODFROM ,EXAMPERIODTO,((TO_char(   EXAMPERIODTO, 'YYYYMMDD')) - (TO_char(examperiodfrom , 'YYYYMMDD')))  ddd  from (";
				qry+=" Select nvl(EXAMCODE,' ') Exam,  EXAMPERIODFROM ,EXAMPERIODTO,((TO_char(   EXAMPERIODTO, 'YYYYMMDD')) - (TO_char(examperiodfrom , 'YYYYMMDD')))  ddd  from EXAMMASTER Where INSTITUTECODE='"+mInst+"' AND nvl(LOCKEXAM,'N')='N' AND ";
            	      qry+=" nvl(Deactive,'N')='N' and nvl(EXCLUDEINATTENDANCE,'N')='N' ";
				qry+=" and examcode in (Select examcode from facultysubjecttagging where fstid in (select fstid from studentattendance))";
	                  //qry+=" and examcode in (select EXAMCODEFORATTENDNACEENTRY from COMPANYINSTITUTETAGGING Where InstituteCode='" + mInst + "' And CompanyCode='" + mComp + "') ";
      	            qry+="order by examperiodfrom DESC";
				qry+=") where rownum<15"; 
                           



                        //out.print(qry);
                        rs = db.getRowset(qry);
                        if (request.getParameter("x") == null) {
                        %>
                        <Select Name=Exam tabindex="0" id="Exam" style="WIDTH: 120px" onclick="ChangeOptions(Exam.value,DataCombo,Subject,DataComboSec,Section,DataComboSub,SubSection);" onChange="ChangeOptions(Exam.value,DataCombo,Subject,DataComboSec,Section,DataComboSub,SubSection);">
                            <%
                                while (rs.next()) {
                                    mExam = rs.getString("Exam");
                                    if (mexam.equals("")) {
                                        mexam = mExam;
                                        qryexam = mExam;
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
                        <select name=Exam tabindex="0" id="Exam" style="WIDTH: 120px" onclick="ChangeOptions(Exam.value,DataCombo,Subject,DataComboSec,Section,DataComboSub,SubSection);" onChange="ChangeOptions(Exam.value,DataCombo,Subject,DataComboSec,Section,DataComboSub,SubSection);">
                            <%
                                while (rs.next()) {
                                    mExam = rs.getString("Exam");
                                    if (mExam.equals(request.getParameter("Exam").toString().trim())) {
                                        mexam = mExam;
                                        qryexam = mExam;
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
                        &nbsp;

                        <!--******************DataCombo for Subject   **************-->
<%
                    try {
//out.print(mSrcType+"mSrcType");
                        if (mSrcType.equals("I")) {
                            qry = "Select nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
                            qry = qry + " from facultysubjecttagging A,SUBJECTMASTER B";
                            qry = qry + " where a.employeeid='" + mDMemberID + "'  and a.InstituteCode='"+mInst+"' and a.InstituteCode=b.InstituteCode ";
                            qry = qry + " and A.fstid not in (select fstid from STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) And InstituteCode='" + mInst + "' and ";
                            qry = qry + " Nvl(deactive,'N')='N' and facultyid<>'" + mDMemberID + "') AND A.SUBJECTID=B.SUBJECTID";
                            qry = qry + " union ";
                            qry = qry + " Select nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
                            qry = qry + " from facultysubjecttagging A,SUBJECTMASTER B";
                            qry = qry + " where a.InstituteCode='"+mInst+"' and a.InstituteCode=b.InstituteCode AND ((a.employeeid = '" + mDMemberID + "')          OR  a.fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='" + mComp + "' and institutecode='" + mInst + "' and facultytype=decode('" + mDMemberType + "','E','I','E') and employeeid='" + mDMemberID + "' UNION (SELECT fstid    FROM v#ex#subjectgradecoordinator                      WHERE institutecode ='"+mInst+"'                        AND coordinatorid = '" + mDMemberID + "'   )     )    )";
                            qry = qry + " and A.fstid not in (select fstid from STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) And InstituteCode='" + mInst + "' and ";
                            qry = qry + " Nvl(deactive,'N')='N' and facultyid<>'" + mDMemberID + "') AND A.SUBJECTID=B.SUBJECTID";
                            qry = qry + " union ";
                            qry = qry + " Select nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
                            qry = qry + " from  facultysubjecttagging A,SUBJECTMASTER B where A.employeeid='"+mDMemberID+"' and a.InstituteCode='"+mInst+"' and a.InstituteCode=b.InstituteCode AND A.fstid in (select fstid from ";
                            qry = qry + " STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
                            qry = qry + " nvl(deactive,'N')='N' and facultyid='" + mDMemberID + "' And InstituteCode='" + mInst + "') AND A.SUBJECTID=B.SUBJECTID ";
                            qry = qry + " order by subject";
                        }
                        if (mSrcType.equals("A") || mSrcType.equals("H")) {
                            qry = "Select distinct nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
                            qry = qry + " from facultysubjecttagging A, SUBJECTMASTER B where A.SUBJECTID=B.SUBJECTID And a.INSTITUTECODE=b.INSTITUTECODE And a.INSTITUTECODE='" + mInst + "'  AND nvl(a.PROJECTSUBJECT,'N')='N' and A.FSTID in (select fstid from V#STUDENTATTENDANCE where nvl(deactive,'N')='N'   UNION (SELECT fstid    FROM v#ex#subjectgradecoordinator                      WHERE  institutecode ='"+mInst+"'                        AND coordinatorid = '" + mDMemberID + "'   )) order by subject asc";
                        }
                     // out.print(qry);
                        rs = db.getRowset(qry);


                        if (request.getParameter("x") == null) {
                        %>
                        <Select Name=DataCombo id="DataCombo" style="WIDTH:0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">		
                            <%
                        while (rs.next()) {
                            mExam = rs.getString("subjectid");
                            mCode = rs.getString("examcode");
                            mES = mCode + "***" + mExam;
                            %>
                            <OPTION Value=<%=mES%>><%=rs.getString("subject")%></option>
                            <%
                        }
                            %>
                        </select>
                        <%
                    } else {
                        %>
                        <Select Name=DataCombo id="DataCombo" style="WIDTH:0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">		
                            <%
                        while (rs.next()) {
                            mExam = rs.getString("subjectid");
                            mCode = rs.getString("examcode");
                            mES = mCode + "***" + mExam;

                            if (mExam.equals(request.getParameter("DataCombo").toString().trim())) {
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

                        <FONT color=black face=Arial size=2><b>Subject</b>&nbsp;  </FONT>
                        <%
                    if (mSrcType.equals("I")) {
                        qry = "Select nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
                        qry = qry + " from facultysubjecttagging A, SUBJECTMASTER B";
                        qry = qry + " where a.employeeid='" + mDMemberID + "' and a.InstituteCode='"+mInst+"' and a.InstituteCode=b.InstituteCode";
                        qry = qry + " and A.fstid not in (select fstid from STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
                        qry = qry + " nvl(deactive,'N')='N' and facultyid<>'" + mDMemberID + "' And InstituteCode='" + mInst + "') AND A.SUBJECTID=B.SUBJECTID and A.EXAMCODE='" + qryexam + "' AND nvl(a.PROJECTSUBJECT,'N')='N' ";
                        qry = qry + " union ";
                        qry = qry + " Select nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
                        qry = qry + " from facultysubjecttagging A, SUBJECTMASTER B";
                        qry = qry + " where a.InstituteCode='"+mInst+"' and a.InstituteCode=b.InstituteCode AND ((a.employeeid = '" + mDMemberID + "')          OR  a.fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='" + mComp + "' and institutecode='" + mInst + "' AND  employeeid = '" + mDMemberID + "' and facultytype=decode('" + mDMemberType + "','E','I','E')   UNION (SELECT fstid    FROM v#ex#subjectgradecoordinator                      WHERE examcode='"+qryexam+"' and institutecode ='"+mInst+"'      AND coordinatorid = '" + mDMemberID + "'   )  ) ) ";
                        qry = qry + " and A.fstid not in (select fstid from STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
                        qry = qry + " nvl(deactive,'N')='N' and facultyid<>'" + mDMemberID + "' And InstituteCode='" + mInst + "') AND A.SUBJECTID=B.SUBJECTID and A.EXAMCODE='" + qryexam + "' AND nvl(a.PROJECTSUBJECT,'N')='N'";
                        qry = qry + " union ";
                        qry = qry + " Select  nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
                        qry = qry + " from  facultysubjecttagging A,SUBJECTMASTER B where A.employeeid='"+mDMemberID+"' and a.InstituteCode='"+mInst+"' and a.InstituteCode=b.InstituteCode AND A.fstid in (select fstid from ";
                        qry = qry + " STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
                        qry = qry + " nvl(deactive,'N')='N' and facultyid='" + mDMemberID + "' And InstituteCode='" + mInst + "')AND A.SUBJECTID=B.SUBJECTID ";
                        qry = qry + " and A.EXAMCODE='" + qryexam + "' AND nvl(a.PROJECTSUBJECT,'N')='N' order by subject";
                    }
                    if (mSrcType.equals("A") || mSrcType.equals("H")) {

                        qry = "Select distinct nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
                        qry = qry + " from facultysubjecttagging A, SUBJECTMASTER B where A.SUBJECTID=B.SUBJECTID And a.INSTITUTECODE=b.INSTITUTECODE And a.INSTITUTECODE='" + mInst + "' and A.EXAMCODE='" + qryexam + "' AND nvl(a.PROJECTSUBJECT,'N')='N' and A.FSTID in (select fstid from V#STUDENTATTENDANCE where examcode='" + qryexam + "' and nvl(deactive,'N')='N' UNION (SELECT fstid    FROM v#ex#subjectgradecoordinator                      WHERE examcode ='" + qryexam + "'      AND institutecode ='"+mInst+"'                        AND coordinatorid = '" + mDMemberID + "'   )) order by subject asc";
                    }
                   // out.print(qry);
                    rs = db.getRowset(qry);


                        %>
                        <select name=Subject tabindex="0" id="Subject" onclick="ChangeSubject(Exam.value,Subject.value,DataComboSec,Section,DataComboSub,SubSection);" onChange="ChangeSubject(Exam.value,Subject.value,DataComboSec,Section,DataComboSub,SubSection);">
                            <%
                    if (request.getParameter("x") == null) {
                        while (rs.next()) {
                            if (mSubj1.equals("")) {
                                mSubj1 = rs.getString("subjectid");
                                qrysubj = mSubj1;
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
                                        qrysubj = mSubj1;
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
                </select></td></tr>
                &nbsp;
              
			   
			    <tr><td>
                        <!******************Group/Section**************-->
                        <FONT color=black><FONT face=Arial size=2><STRONG>Section</STRONG>&nbsp;</FONT></FONT>
                        <%
                    try {
                        if (mSrcType.equals("I")) {
                            qry1 = "select 'ALL' section from dual union all";
                            qry1 = qry1 + " select nvl(SECTIONBRANCH,' ') Section from facultysubjecttagging where ";//facultytype=decode('" + mDMemberType + "','E','I','E') and";
                            qry1 = qry1 + " employeeid='" + mDMemberID + "' AND INSTITUTECODE='"+mInst+"' and";
                            qry1 = qry1 + " examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' or nvl(FINALIZED,'N')='Y' or NVL(DEACTIVE,'N')='Y')";
                            qry1 = qry1 + " and institutecode='" + mInst + "'  and examcode='" + qryexam + "' and subjectid='" + qrysubj + "' Group By nvl(SECTIONBRANCH,' ')";
                            qry1 = qry1 + " UNION";
                            qry1 = qry1 + " select nvl(SECTIONBRANCH,' ') Section from facultysubjecttagging where   INSTITUTECODE='"+mInst+"' and ";//facultytype=decode('" + mDMemberType + "','E','I','E') and";
                            qry1 = qry1 + " ((employeeid = '" + mDMemberID + "')          OR      fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='" + mComp + "' and institutecode='" + mInst + "' and facultytype=decode('" + mDMemberType + "','E','I','E') and employeeid='" + mDMemberID + "'    UNION (SELECT fstid    FROM v#ex#subjectgradecoordinator                      WHERE examcode ='" + qryexam + "'                         AND subjectid = '" + qrysubj + "'                        AND institutecode ='"+mInst+"'                        AND coordinatorid = '" + mDMemberID + "' )      ) ) and";
                            qry1 = qry1 + " examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' or nvl(FINALIZED,'N')='Y' or NVL(DEACTIVE,'N')='Y')";
                            qry1 = qry1 + " and examcode='" + qryexam + "' and subjectid='" + qrysubj + "' Group By nvl(SECTIONBRANCH,' ') order by Section";
                        }
                        if (mSrcType.equals("A") || mSrcType.equals("H")) {

                            qry1 = "select 'ALL' section from dual union all";
                            qry1 = qry1 + " select distinct nvl(SECTIONBRANCH,' ') Section from facultysubjecttagging where institutecode='" + mInst + "'  and ";
                            //qry1=qry1+" and";
                            qry1 = qry1 + " examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' or nvl(FINALIZED,'N')='Y' or NVL(DEACTIVE,'N')='Y')";
                            qry1 = qry1 + "and institutecode='" + mInst + "'  and examcode='" + qryexam + "' and subjectid='" + qrysubj  + "' Group By nvl(SECTIONBRANCH,' ')";
                            qry1 = qry1 + " UNION";
                            qry1 = qry1 + " select nvl(SECTIONBRANCH,' ') Section from facultysubjecttagging where  institutecode='" + mInst + "' and ";
                            qry1 = qry1 + " fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='" + mComp + "' and institutecode='" + mInst + "'   UNION (SELECT fstid    FROM v#ex#subjectgradecoordinator                      WHERE examcode ='" + qryexam + "'                         AND subjectid = '" + qrysubj + "'                        AND institutecode ='"+mInst+"'                        AND coordinatorid = '" + mDMemberID + "' )    ) and";
                            qry1 = qry1 + " examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' or nvl(FINALIZED,'N')='Y' or NVL(DEACTIVE,'N')='Y')";
                            qry1 = qry1 + " and institutecode='" + mInst + "'  and examcode='" + qryexam + "' and subjectid='" + qrysubj + "' Group By nvl(SECTIONBRANCH,' ') order by Section";
                        }
                  //  out.print(qry1);

                        rs1 = db.getRowset(qry1);

                        if (request.getParameter("x") == null) {
                        %>
                        <select name=Section tabindex="0" id="Section" style="WIDTH: 90px" onclick="ChangeSection(Exam.value,Subject.value,Section.value,DataComboSub,SubSection);" onChange="ChangeSection(Exam.value,Subject.value,Section.value,DataComboSub,SubSection);">
                            <%
                                while (rs1.next()) {
                                    mSubj = rs1.getString("Section");

                                    qrysec = mSubj;
                            %>
                            <OPTION Value =<%=mSubj%>><%=rs1.getString("Section")%></option>
                            <%
                                }
                            %>
                        </select>
                        <%
                            } else {
                        %>
                        <select name=Section tabindex="0" id="Section" style="WIDTH: 90px" onclick="ChangeSection(Exam.value,Subject.value,Section.value,DataComboSub,SubSection);" onChange="ChangeSection(Exam.value,Subject.value,Section.value,DataComboSub,SubSection);">
                            <%
                                while (rs1.next()) {
                                    mSubj = rs1.getString("Section");
                                    if (mSubj.equals(request.getParameter("Section").toString().trim())) {
                                        qrysec = mSubj;
                            %>
                            <OPTION selected Value =<%=mSubj%>><%=rs1.getString("Section")%></option>
                            <%
                                } else {
                            %>
                            <OPTION Value =<%=mSubj%>><%=rs1.getString("Section")%></option>
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

                    try {
                        if (mSrcType.equals("I")) {
                            qry1 = " select nvl(SECTIONBRANCH,' ') Section,nvl(subjectid,' ')subjectid,nvl(EXAMCODE,' ')examcode from  facultysubjecttagging where  ";
                            qry1 = qry1 + "  employeeid='" + mDMemberID + "' and institutecode='" + mInst + "'  and ";//facultytype=decode('" + mDMemberType + "','E','I','E') and
                            qry1 = qry1 + " examcode not in (select examcode from exammaster where InstituteCode='" + mInst + "' and nvl(LOCKEXAM,'N')='Y' ";
                            qry1 = qry1 + " or nvl(FINALIZED,'N')='Y' or NVL(DEACTIVE,'N')='Y' )  Group by SECTIONBRANCH ,subjectid,EXAMCODE";
                            qry1 = qry1 + " UNION";
                            qry1 = qry1 + " select nvl(SECTIONBRANCH,' ') Section,nvl(subjectid,' ')subjectid,nvl(EXAMCODE,' ')examcode from  facultysubjecttagging where InstituteCode='" + mInst + "' and   ";
                            qry1 = qry1 + " ((employeeid = '" + mDMemberID + "')          OR  fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='" + mComp + "' and institutecode='" + mInst + "'  and employeeid='" + mDMemberID + "'   UNION (SELECT fstid    FROM v#ex#subjectgradecoordinator                      WHERE  institutecode ='"+mInst+"'                        AND coordinatorid = '" + mDMemberID + "' )  ) ) and "; //facultytype=decode('" + mDMemberType + "','E','I','E') 
                            qry1 = qry1 + " examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
                            qry1 = qry1 + " or nvl(FINALIZED,'N')='Y' or NVL(DEACTIVE,'N')='Y' )  Group by SECTIONBRANCH ,subjectid,EXAMCODE";
                            qry1 = qry1 + " order by Section";
                        }
                        if (mSrcType.equals("A") || mSrcType.equals("H")) {
                            qry1 = " select nvl(SECTIONBRANCH,' ') Section,nvl(subjectid,' ')subjectid,nvl(EXAMCODE,' ')examcode from  facultysubjecttagging where  ";
                            // qry1 = qry1 + " examcode='" + qryexam + "'and ";
                            qry1 = qry1 + " InstituteCode='" + mInst + "' and  examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
                            qry1 = qry1 + " or nvl(FINALIZED,'N')='Y' or NVL(DEACTIVE,'N')='Y' )  Group by SECTIONBRANCH ,subjectid,EXAMCODE";
                            qry1 = qry1 + " UNION";
                            qry1 = qry1 + " select nvl(SECTIONBRANCH,' ') Section,nvl(subjectid,' ')subjectid,nvl(EXAMCODE,' ')examcode from  facultysubjecttagging where InstituteCode='" + mInst + "' and ";
                            // qry1 = qry1 + " examcode='" + qryexam + "' and fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='" + mComp + "' and institutecode='" + mInst + "') and ";
                            qry1 = qry1 + " fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='" + mComp + "' and institutecode='" + mInst + "'    UNION (SELECT fstid    FROM v#ex#subjectgradecoordinator                      WHERE                         institutecode ='"+mInst+"'                        AND coordinatorid = '" + mDMemberID + "' )  ) and ";
                            //qry1 = qry1 + " examcode not in (select examcode from exammaster where examcode='" + qryexam + "' and nvl(LOCKEXAM,'N')='Y' ";
                            qry1 = qry1 + " examcode not in (select examcode from exammaster where InstituteCode='" + mInst + "' and  nvl(LOCKEXAM,'N')='Y' ";
                            qry1 = qry1 + " or nvl(FINALIZED,'N')='Y' or NVL(DEACTIVE,'N')='Y' )  Group by SECTIONBRANCH ,subjectid,EXAMCODE";
                            qry1 = qry1 + " order by Section";
                        }

                     // out.print(qry1);
                        rs1 = db.getRowset(qry1);
                        if (request.getParameter("x") == null) {
                        %>
                        <select name=DataComboSec tabindex="0" id="DataComboSec" style="WIDTH: 0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">		
                            <%
                            while (rs1.next()) {
                                mSubj = rs1.getString("subjectid");
                                mSExam = rs1.getString("examcode");
                                mSES = mSExam + "***" + mSubj + "///" + rs1.getString("Section");

                            %>
                            <OPTION Value =<%=mSES%>><%=rs1.getString("Section")%></option>

                            <%
                            }
                            %>
                        </select>
                        <%
                        } else {
                        %>
                        <select name=DataComboSec tabindex="0" id="DataComboSec" style="WIDTH:0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">		
                            <%
                            while (rs1.next()) {
                                mSubj = rs1.getString("subjectid");
                                mSExam = rs1.getString("examcode");
                                mSES = mSExam + "***" + mSubj + "///" + rs1.getString("Section");

                                if (mSES.equals(request.getParameter("DataComboSec").toString().trim())) {
                            %>
                            <OPTION selected Value =<%=mSES%>><%=rs1.getString("Section")%></option>
                            <%
                                } else {
                            %>
                            <OPTION Value =<%=mSES%>><%=rs1.getString("Section")%></option>
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
                        <!******************Sub Group/Sub Section**************-->
                        &nbsp;<FONT color=black><FONT face=Arial size=2><STRONG>Sub Sec.</STRONG></FONT></FONT>
                        <%
                    try {
                        if (mSrcType.equals("I")) {
                            qry1 = "Select SUBSECTIONCODE SubSection from  facultysubjecttagging where  ";
                            qry1 = qry1 + " employeeid='" + mDMemberID + "' and institutecode='" + mInst + "'  and ";//facultytype=decode('" + mDMemberType + "','E','I','E') and
                            qry1 = qry1 + " examcode not in (select examcode from exammaster where InstituteCode='" + mInst + "' and nvl(LOCKEXAM,'N')='Y' ";
                            qry1 = qry1 + " and nvl(FINALIZED,'N')='Y' and NVL(DEACTIVE,'N')='Y' )  ";
                            qry1 = qry1 + "   and examcode='" + qryexam + "' and subjectid='" + qrysubj + "'";
                            qry1 = qry1 + " and sectionbranch=decode('" + qrysec + "','ALL',sectionbranch,'" + qrysec + "') Group By SUBSECTIONCODE";
                            qry1 = qry1 + " UNION";
                            qry1 = qry1 + " Select SUBSECTIONCODE SubSection from  facultysubjecttagging where    institutecode='" + mInst + "' and ";
                            qry1 = qry1 + " ((employeeid = '" + mDMemberID + "')          OR  fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='" + mComp + "' and institutecode='" + mInst + "'  and employeeid='" + mDMemberID + "'   UNION (SELECT fstid    FROM v#ex#subjectgradecoordinator                      WHERE examcode ='" + qryexam + "'                         AND subjectid = '" + qrysubj + "'                        AND institutecode ='"+mInst+"'                        AND coordinatorid = '" + mDMemberID + "' and sectionbranch=decode('" + qrysec + "','ALL',sectionbranch,'" + qrysec + "')  ) ) ) and ";//facultytype=decode('" + mDMemberType + "','E','I','E')
                            qry1 = qry1 + " examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
                            qry1 = qry1 + " and nvl(FINALIZED,'N')='Y' and NVL(DEACTIVE,'N')='Y' )  ";
                            qry1 = qry1 + " and examcode='" + qryexam + "' and institutecode='" + mInst + "' and   subjectid='" + qrysubj + "'";
                            qry1 = qry1 + " and sectionbranch=decode('" + qrysec + "','ALL',sectionbranch,'" + qrysec + "') Group By SUBSECTIONCODE order by SubSection ";
                        }
                        if (mSrcType.equals("A") || mSrcType.equals("H")) {
                            qry1 = "Select SUBSECTIONCODE SubSection from  facultysubjecttagging where  ";
                            //qry1=qry1+" facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"' and ";
                            qry1 = qry1 + " institutecode='" + mInst + "' and examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
                            qry1 = qry1 + " and nvl(FINALIZED,'N')='Y' and NVL(DEACTIVE,'N')='Y' )  ";
                            qry1 = qry1 + "  and examcode='" + qryexam + "' and subjectid='" + qrysubj + "'";
                            qry1 = qry1 + " and sectionbranch=decode('" + qrysec + "','ALL',sectionbranch,'" + qrysec + "') Group By SUBSECTIONCODE";
                            qry1 = qry1 + " UNION";
                            qry1 = qry1 + " Select SUBSECTIONCODE SubSection from  facultysubjecttagging where  institutecode='" + mInst + "' and ";
                            //qry1 = qry1 + " facultytype=decode('" + mDMemberType + "','E','I','E') and fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='" + mComp + "' and institutecode='" + mInst + "') and ";
                            qry1 = qry1 + " fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where  companycode='" + mComp + "' and institutecode='" + mInst + "'  UNION (SELECT fstid    FROM v#ex#subjectgradecoordinator                      WHERE examcode ='" + qryexam + "'                         AND subjectid = '" + qrysubj + "'                        AND institutecode ='"+mInst+"'                        AND coordinatorid = '" + mDMemberID + "' and sectionbranch=decode('" + qrysec + "','ALL',sectionbranch,'" + qrysec + "')  ) ) and ";
                            qry1 = qry1 + " examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
                            qry1 = qry1 + " and nvl(FINALIZED,'N')='Y' and NVL(DEACTIVE,'N')='Y' )  ";
                            qry1 = qry1 + " and institutecode='" + mInst + "' and examcode='" + qryexam + "' and subjectid='" + qrysubj + "'";
                            qry1 = qry1 + " and sectionbranch=decode('" + qrysec + "','ALL',sectionbranch,'" + qrysec + "') Group By SUBSECTIONCODE order by SubSection ";
                        }
                        // out.print(qry1);


                        rs1 = db.getRowset(qry1);
                        if (request.getParameter("x") == null) {
                        %>
                        <select name=SubSection tabindex="0" id="SubSection" style="WIDTH: 90px">
                            <option Selected value='ALL'>ALL</option>
                            <%
                                while (rs1.next()) {
                                    mSubj = rs1.getString("SubSection");
                            %>
                            <OPTION Value =<%=mSubj%>><%=rs1.getString("SubSection")%></option>
                            <%
                                }
                            %>
                        </select>
                        <%
                            } else {
                        %>
                        <select name=SubSection tabindex="0" id="SubSection" style="WIDTH: 90px">
                            <%
                                if ("ALL".equals(request.getParameter("SubSection").toString().trim())) {
                            %>
                            <OPTION selected Value =ALL>ALL</option>
                            <%                            } else {
                            %>
                            <OPTION Value =ALL>ALL</option>
                            <%                            }


                                while (rs1.next()) {
                                    mSubj = rs1.getString("SubSection");
                                    if (mSubj.equals(request.getParameter("SubSection").toString().trim())) {
                            %>
                            <OPTION selected Value =<%=mSubj%>><%=rs1.getString("SubSection")%></option>
                            <%
                                                            } else {
                            %>
                            <OPTION Value =<%=mSubj%>><%=rs1.getString("SubSection")%></option>
                            <%
                                    }
                                }
                            %>
                        </select>
                        <%
                        }
                    } catch (Exception e) {
                    }

                    //*************DataComboSub************
                    try {
                        if (mSrcType.equals("I")) {
                            qry1 = "Select SUBSECTIONCODE SubSection,nvl(SECTIONBRANCH,' ') Section,nvl(Examcode,' ')examcode,nvl(subjectid,' ')subjectid from  facultysubjecttagging where   ";
                            qry1 = qry1 + " institutecode='" + mInst + "' and employeeid='" + mDMemberID + "' and "; //facultytype=decode('" + mDMemberType + "','E','I','E') and
                            qry1 = qry1 + " examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
                            qry1 = qry1 + " and nvl(FINALIZED,'N')='Y' and NVL(DEACTIVE,'N')='Y' ) ";
                            qry1 = qry1 + " Group By SUBSECTIONCODE ,nvl(SECTIONBRANCH,' ') ,nvl(Examcode,' '),nvl(subjectid,' ')";
                            qry1 = qry1 + " UNION";
                            qry1 = qry1 + " Select SUBSECTIONCODE SubSection,nvl(SECTIONBRANCH,' ') Section,nvl(Examcode,' ')examcode,nvl(subjectid,' ')subjectid from  facultysubjecttagging where ";
                            qry1 = qry1 + "  institutecode='" + mInst + "' AND ((employeeid = '" + mDMemberID + "')          OR   fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='" + mComp + "' and institutecode='" + mInst + "'  and employeeid='" + mDMemberID + "'   UNION (SELECT fstid    FROM v#ex#subjectgradecoordinator                      WHERE  institutecode ='"+mInst+"'                        AND coordinatorid = '" + mDMemberID + "' )) ) and ";
                            qry1 = qry1 + " examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
                            qry1 = qry1 + " and nvl(FINALIZED,'N')='Y' and NVL(DEACTIVE,'N')='Y' ) ";
                            qry1 = qry1 + " Group By SUBSECTIONCODE ,nvl(SECTIONBRANCH,' ') ,nvl(Examcode,' '),nvl(subjectid,' ') order by SubSection ";
                        }
                        if (mSrcType.equals("A") || mSrcType.equals("H")) {
                            qry1 = "Select SUBSECTIONCODE SubSection,nvl(SECTIONBRANCH,' ') Section,nvl(Examcode,' ')examcode,nvl(subjectid,' ')subjectid from  facultysubjecttagging where  institutecode='" + mInst + "' and ";
                            //qry1=qry1+" facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"' and ";
                            // qry1 = qry1 + " examcode='" + qryexam + "' and examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
                            qry1 = qry1 + " examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
                            qry1 = qry1 + " and nvl(FINALIZED,'N')='Y' and NVL(DEACTIVE,'N')='Y' ) ";
                            qry1 = qry1 + " Group By SUBSECTIONCODE ,nvl(SECTIONBRANCH,' ') ,nvl(Examcode,' '),nvl(subjectid,' ')";
                            qry1 = qry1 + " UNION";
                            qry1 = qry1 + " Select SUBSECTIONCODE SubSection,nvl(SECTIONBRANCH,' ') Section,nvl(Examcode,' ')examcode,nvl(subjectid,' ')subjectid from  facultysubjecttagging where InstituteCode='" + mInst + "' and ";
                            //qry1 = qry1 + " facultytype=decode('" + mDMemberType + "','E','I','E') and fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='" + mComp + "' and institutecode='" + mInst + "') and ";
                            qry1 = qry1 + " fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='" + mComp + "' and institutecode='" + mInst + "'  UNION (SELECT fstid    FROM v#ex#subjectgradecoordinator                      WHERE  institutecode ='"+mInst+"'                        AND coordinatorid = '" + mDMemberID + "' ) ) and ";
                            qry1 = qry1 + " examcode not in (select examcode from exammaster where InstituteCode='" + mInst + "' and nvl(LOCKEXAM,'N')='Y' ";
                            qry1 = qry1 + " and nvl(FINALIZED,'N')='Y' and NVL(DEACTIVE,'N')='Y' ) ";
                            qry1 = qry1 + " Group By SUBSECTIONCODE ,nvl(SECTIONBRANCH,' ') ,nvl(Examcode,' '),nvl(subjectid,' ') order by SubSection ";
                        }
                        //out.print(qry1);
                        rs1 = db.getRowset(qry1);
                        if (request.getParameter("x") == null) {
                        %>
                        <select name=DataComboSub tabindex="0" id="DataComboSub" style="WIDTH: 0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">		
                            <%
                            while (rs1.next()) {
                                mSubj = rs1.getString("subjectid");
                                mSExam = rs1.getString("examcode");
                                mSES = mSExam + "***" + mSubj + "///" + rs1.getString("Section") + "*****" + rs1.getString("SubSection");
                            %>
                            <OPTION Value =<%=mSES%>><%=rs1.getString("SubSection")%></option>
                            <%
                            }
                            %>
                        </select>
                        <%
                        } else {
                        %>
                        <select name=DataComboSub tabindex="0" id="DataComboSub" style="WIDTH: 0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">		
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
                        %>
			   
			   
			   
			   
			   <tr>
			   <td align=center>			   
			   <INPUT Type="submit" Value="Show/Refresh"></td></tr>

            </table>
        </form>

<form name="dd" id="dd">
<center>
<input style="width:200px;font-size:20px;
	color:red;font-weight:bold;BORDER-LEFT: c00000 0px solid;BORDER-TOP: c00000 0px solid;
	BORDER-RIGHT: c00000 0px solid;BORDER-BOTTOM: c00000 0px solid ; background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden;"  name="twait" readonly id="twait" type="text" value="Please Wait.......">
</center>
</form>
        <%
	String QryEmpID="",QrySemType="",QrySecBr="",QrySubSec="";
                    if (request.getParameter("x") != null) {
                        mExam = request.getParameter("Exam").toString().trim();

                        mSubject = request.getParameter("Subject").toString().trim();

                        //mLTP=request.getParameter("LTP").toString().trim();
                        mSection = request.getParameter("Section").toString().trim();

                        mSubsection = request.getParameter("SubSection").toString().trim();
                        //out.print(mExam+" "+mSubject+" "+mLTP+" "+mSection+" "+mSubsection);
%>


        <form name="frm1"  method="post" action="">
<table border=1 bgcolor=#fce9c5  leftmargin=0 cellpadding=0 cellspacing=0 align=center>
<tr>
<td  valign=top >
	<table border=1 bgcolor=#fce9c5 class="sort-table" leftmargin=0 cellpadding=0 cellspacing=0 align=center>
	<thead>
	<tr  bgcolor="#ff8c00">
		<td rowspan=2 Title="Sort on SlNo" style="height:30px" >
				<font color="White" face="arial" size=2><b>Sr.<br>No.</b><br>&nbsp;</font>
		</td>
	</tr>
	</thead>
		<tbody>
<%
			String TRCOLOR1="";
		int j=0;


                            qry = "select distinct nvl(d.enrollmentno,' ')enrollmentno,nvl(d.studentname,' ')studentname, NVL(c.studentid,' ')studentid,";
                            qry = qry + " NVL(A.SECTIONBRANCH,' ')sectionbranch, nvl(B.SEMESTER,1) SEMESTER, To_Char(decode(c.SPECIALAPPROVAL,'Y',c.SUBJECTREGISTRATIONDATE,b.REGCONFIRMATIONDATE),'DD-MM-YYYY') REGCONFIRMATIONDATE ,nvl(c.SPECIALAPPROVAL,'N')SPECIALAPPROVAL ,";
							 qry = qry + " A.SECTIONBRANCH SECBR,  NVL(a.SEMESTERTYPE,' ')SEMESTERTYPE ";
							 qry = qry + " from facultysubjecttagging a , STUDENTLTPDETAIL c,STUDENTREGISTRATION B ,studentmaster d ";
                            qry = qry + " Where a.fstid=c.fstid and c.studentid=d.studentid and NVL(d.deactive,'N')='N' AND NVL(a.deactive,'N')='N' ";
                            qry = qry + " AND B.INSTITUTECODE=A.INSTITUTECODE";
                            qry = qry + " AND B.EXAMCODE=A.EXAMCODE";
                             qry = qry + " AND b.EXAMCODE='"+mExam +"'";
                            //qry = qry + " AND a.EXAMCODE='"+mExam +"'";
                            //qry = qry + " AND d.EXAMCODE='"+mExam +"'";
                            qry = qry + " AND B.ACADEMICYEAR=A.ACADEMICYEAR";
                            qry = qry + " AND B.STUDENTID=c.STUDENTID and a.InstituteCode='" + mInst + "'";
                            //qry=qry+" and (A.EMPLOYEEID in (select '"+mDMemberID+"' from Dual ";
                            //qry=qry+" where not exists (select 'y' from STUDATTENDANCEBYSPECIALFACULTY ssf Where ";
                            //------------OR-------------

				if (mSrcType.equals("I"))
				{
                       	    qry=qry+" and A.FSTID in ((select FSTID from facultysubjecttagging where employeeid='"+mDMemberID+"' and examcode='"+mExam+"' and subjectid='"+mSubject+"'  UNION (SELECT FSTID  FROM    V#EX#SUBJECTGRADECOORDINATOR WHERE  examcode = '"+mExam+"'  AND subjectid = '"+mSubject+"' AND INSTITUTECODE = '"+mInst+"' AND COORDINATORID = '"+mDMemberID+"' AND fstid IN ( SELECT fstid  FROM facultysubjecttagging    WHERE examcode = '"+mExam+"'    AND subjectid = '"+mSubject+"'  AND institutecode = '"+mInst+"' ))  ) UNION (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='"+mComp+"' and institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"' and fstid in (select fstid from facultysubjecttagging where examcode='"+mExam+"' and subjectid='"+mSubject+"')))";
				}
                     
							 
							qry=qry+" and A.SECTIONBRANCH=decode('"+mSection+"','ALL',A.SECTIONBRANCH,'"+mSection+"') and A.SUBSECTIONCODE=decode('"+mSubsection+"','ALL',A.SUBSECTIONCODE,'"+mSubsection+"') ";
							qry = qry + " and A.SUBJECTID='" + mSubject + "'";
                            //qry=qry+" and A.LTP in ('"+mLTP+"')";
                            //qry = qry + " and A.ExamCode='" + mExam + "'  ";
                            qry = qry + " order by enrollmentno";

								ResultSet rs12=db.getRowset(qry);

while(rs12.next())
		{		
	j++;
						if(j%2==0)
							TRCOLOR1="White";
						else
							TRCOLOR1="#F8F8F8";

				%>
				<tr  bgcolor="<%=TRCOLOR1%>" >
			<td  style="height:26px" >		
			<font size=2 face=arial> <%=j%> 
			</font>
			</td>
			</tr>
			
				<%
		}
		%>
	</tbody>
	</table>
	</td>


	<td>
	<table  bgcolor=#fce9c5 class="sort-table" id="table-1" border=2 leftmargin=0 cellpadding=0 cellspacing=0 align=center >
			<thead>
                    <tr bgcolor="#ff8c00" style="height:30px">
                       
                        <td rowspan=2 Title="Sort on Enrollment No" nowrap><font color="White"><b>Roll No.</b></font></td>
                        <td rowspan=2 Title="Class Student Name"><font color="White"><b>Name</b></font></td>
                        <td rowspan=2 Title="Sort on Section/Subsection"><font color="White"><b>Section<br>(SubSec.)</b></font></td>
                        <%
                            if (mSrcType.equals("I")) {
                                qry = "Select DISTINCT A.LTP, DECODE(A.LTP,'L',1,'T',2,'P',3,4)LTPSEQ from facultysubjecttagging A where A.INSTITUTECODE='" + mInst + "'  and A.EXAMCODE='" + mExam + "' and A.SubjectID='" + mSubject + "' and NVL(A.PROJECTSUBJECT,'N')='N' ORDER BY LTPSEQ";
                            }
                            if (mSrcType.equals("A") || mSrcType.equals("H")) {
                                qry = "Select DISTINCT A.LTP, DECODE(A.LTP,'L',1,'T',2,'P',3,4)LTPSEQ from facultysubjecttagging A where A.INSTITUTECODE='" + mInst + "'  and A.EXAMCODE='" + mExam + "' and A.SubjectID='" + mSubject + "' and NVL(A.PROJECTSUBJECT,'N')='N' ORDER BY LTPSEQ";
                            }
                            rs = db.getRowset(qry);
                            // out.print(qry);
                            int count = 0;
                            boolean flag1 = false;
                            while (rs.next()) {
                                if (rs.getString(1).equals("L")) {
                                    flag1 = true;
                                    count++;
                                } else if (rs.getString(1).equals("T") && flag1 == true) {
                                    count = count + 2;
                                } else {
                                    count++;
                                }
                            }
                            // out.print(count);
%>
                        <td Colspan="<%=count%>" Title="Student % Attendance" align="center" nowrap><font color="White"><b>% Attendance Till Today</b></font></td>
                    </tr>
                    <tr bgcolor="#ff8c00">
                        <%

                            if (mSrcType.equals("I")) {
                                qry = "Select DISTINCT A.LTP, DECODE(A.LTP,'L',1,'T',2,'P',3,4)LTPSEQ from facultysubjecttagging A where A.INSTITUTECODE='" + mInst + "' and A.EXAMCODE='" + mExam + "' and A.SubjectID='" + mSubject + "' and NVL(A.PROJECTSUBJECT,'N')='N' ORDER BY LTPSEQ";
                            }
                            if (mSrcType.equals("A") || mSrcType.equals("H")) {
                                qry = "Select DISTINCT A.LTP, DECODE(A.LTP,'L',1,'T',2,'P',3,4)LTPSEQ from facultysubjecttagging A where A.INSTITUTECODE='" + mInst + "'  and A.EXAMCODE='" + mExam + "' and A.SubjectID='" + mSubject + "' and NVL(A.PROJECTSUBJECT,'N')='N' ORDER BY LTPSEQ";
                            }
                            rs = db.getRowset(qry);
                          // out.print(qry);
                            boolean flag = false;
                            while (rs.next()) {
                                if (rs.getString(1).equals("L")) {
                                    flag = true;
                        %><td rowspan=2 Align=center Title="Student Lecture % Attendance"><font color="White"><b><%=rs.getString(1)%></b></font></td><%
                                        } else if (rs.getString(1).equals("T") && flag == true) {
                        %><td rowspan=2 Align=center Title="Student Lecture % Attendance"><font color="White"><b><%=rs.getString(1)%></b></font></td>
                        <td rowspan=2 Align=center Title="Student Lecture And Tutorial % Attendance"><font color="White"><b>L+T</b></font></td>
                        <%
                                        } else {
                        %><td rowspan=2 Align=center Title="Student Lecture % Attendance"><font color="White"><b><%=rs.getString(1)%></b></font></td><%
                                }
                            }
                        %>
                    </tr>
                </thead>
                <tbody>
                    <%
					
                            qry = "select distinct  DECODE (d.enrollmentno,NULL,d.RANKNO,d.ENROLLMENTNO )enrollmentno,nvl(d.studentname,' ')studentname, NVL(c.studentid,' ')studentid,";
                            qry = qry + " NVL(A.SECTIONBRANCH,' ') sectionbranch, nvl(B.SEMESTER,1) SEMESTER, To_Char(decode(c.SPECIALAPPROVAL,'Y',c.SUBJECTREGISTRATIONDATE,b.REGCONFIRMATIONDATE),'DD-MM-YYYY') REGCONFIRMATIONDATE ,nvl(to_char(b.REGCONFIRMATIONDATE,'yyyymmdd'),' ') REGCONFIRMATIONDATE1,nvl(c.SPECIALAPPROVAL,'N')SPECIALAPPROVAL ,";
                         qry = qry + " A.SECTIONBRANCH SECBR,  NVL(a.SEMESTERTYPE,' ')SEMESTERTYPE ";
                         qry = qry + ",  A.AcademicYear AcademicYear,A.ProgramCode ProgramCode from facultySubjectTagging a ,STUDENTLTPDETAIL c,STUDENTREGISTRATION B ,studentmaster d";
                            qry = qry + " Where a.fstid=c.fstid and c.studentid=d.studentid and NVL(d.deactive,'N')='N' AND NVL(a.deactive,'N')='N' ";
                            qry = qry + " AND B.INSTITUTECODE=A.INSTITUTECODE";
                            qry = qry + " AND B.EXAMCODE=A.EXAMCODE";
                             qry = qry + " AND b.EXAMCODE='"+mExam +"'";
                           // qry = qry + " AND a.EXAMCODE='"+mExam +"'";
                            //qry = qry + " AND d.EXAMCODE='"+mExam +"'";
                            qry = qry + " AND B.ACADEMICYEAR=A.ACADEMICYEAR";
                            qry = qry + " AND B.STUDENTID=c.STUDENTID and a.InstituteCode='" + mInst + "' ";
                            //qry=qry+" and (A.EMPLOYEEID in (select '"+mDMemberID+"' from Dual ";
                            //qry=qry+" where not exists (select 'y' from STUDATTENDANCEBYSPECIALFACULTY ssf Where ";
                            //------------OR-------------

				if (mSrcType.equals("I"))
				{
                       	    qry=qry+" and A.FSTID in ((select FSTID from facultysubjecttagging where employeeid='"+mDMemberID+"' and examcode='"+mExam+"' and subjectid='"+mSubject+"'  UNION (SELECT FSTID  FROM    V#EX#SUBJECTGRADECOORDINATOR WHERE  examcode = '"+mExam+"'  AND subjectid = '"+mSubject+"' AND INSTITUTECODE = '"+mInst+"' AND COORDINATORID = '"+mDMemberID+"' AND fstid IN ( SELECT fstid  FROM facultysubjecttagging    WHERE examcode = '"+mExam+"'    AND subjectid = '"+mSubject+"'  AND institutecode = '"+mInst+"' ))  ) UNION (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='"+mComp+"' and institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"' and fstid in (select fstid from facultysubjecttagging where examcode='"+mExam+"' and subjectid='"+mSubject+"')))";
				}
                     
							 
							 qry=qry+" and A.SECTIONBRANCH=decode('"+mSection+"','ALL',A.SECTIONBRANCH,'"+mSection+"') and A.SUBSECTIONCODE=decode('"+mSubsection+"','ALL',A.SUBSECTIONCODE,'"+mSubsection+"') ";
							 qry = qry + " and A.SUBJECTID='" + mSubject + "'";
                            //qry=qry+" and A.LTP in ('"+mLTP+"')";
                            //qry = qry + " and A.ExamCode='" + mExam + "'  ";
                                qry = qry + " order by enrollmentno";
                      //out.print(qry); // and a.enrollmentno='11103510'
							  String mStudentid="";
                            ResultSet rs11 = db.getRowset(qry);
                            while (rs11.next()) {
								double mPresent=0, mL=0, mT=0, mP=0, mLP=0, mTP=0, mPP=0;

								double mPercL=0,mPercT=0,mPercP=0,mPercLT=0;
								if(!mStudentid.equals(rs11.getString("studentid")))
								{		
									mStudentid=rs11.getString("studentid");

                                Ctr++;
                                if (Ctr % 2 == 0) {
                                    TRCOLOR = "White";
                                } else {
                                    TRCOLOR = "#F8F8F8";
                                }

                                mRollno = rs11.getString("enrollmentno").toString().trim();
								xL=0;
                                mName = rs11.getString("studentname").toString().trim();
                                mName1 = "Present" + String.valueOf(Ctr).trim();
                                mName2 = "Absent" + String.valueOf(Ctr).trim();
                                mName3 = "Fstid" + String.valueOf(Ctr).trim();
                                mName4 = "StudID" + String.valueOf(Ctr).trim();
                                mName5 = "Employeeid" + String.valueOf(Ctr).trim();
                                mName6 = "Enrollment" + String.valueOf(Ctr).trim();
                                mName7 = "SNo" + String.valueOf(Ctr).trim();
								

								//QryEmpID=rs11.getString("EMPLOYEEID").toString().trim();

					            QrySemType=rs11.getString("SEMESTERTYPE").toString().trim();
								QrySecBr=rs11.getString("SECBR").toString().trim();
								//QrySubSec=rs11.getString("SUBSEC").toString().trim();
									QryAcad=rs11.getString("AcademicYear").toString().trim();
								QryProgramCode=rs11.getString("ProgramCode").toString().trim();	
								
							mSpecialApproval=rs11.getString("SPECIALAPPROVAL");
								mREGCONFIRMATIONDATE1=rs11.getString("REGCONFIRMATIONDATE1");

								if(rs11.getString("REGCONFIRMATIONDATE")==null)
									mREGCONFIRMATIONDATE=" ";
								else
									mREGCONFIRMATIONDATE=rs11.getString("REGCONFIRMATIONDATE");

                    %>
                    <tr bgcolor=<%=TRCOLOR%> style="height:26px">
                  
                        <td><%=mRollno%></td>
                        <td nowrap><%=GlobalFunctions.toTtitleCase(mName)%></td>
                        <td><%=rs11.getString("sectionbranch")%></td>

                        <%


String mLFSTID="";
String mTFSTID="";
String mPFSTID="";
String prevLFSTID="";
String prevTFSTID="";
String prevPFSTID="";
  mMemberID=mStudentid;
String mINSTITUTECODE=mInst;
String QryExam=mExam;
int QrySem=rs11.getInt("SEMESTER");
mREGCONFIRMATIONDATE1int=0;
//----------------------------------------special case -----------------------------//

if(mSpecialApproval.equals("Y"))
	QrySem=1;
else
	QrySem=QrySem;

  mREGCONFIRMATIONDATE1int = Integer.parseInt(mREGCONFIRMATIONDATE1); 

//-----------------  1314  B.T DUAL  JIIT J128------

if( (mINSTITUTECODE.equals("JIIT") || mINSTITUTECODE.equals("J128")) && (QryProgramCode.equals("B.T") || QryProgramCode.equals("DUAL"))
&& QryAcad.equals("1314") && 9==8	)
					{
				QrySem=1;





if(QrySem==1 && mREGCONFIRMATIONDATE1int<=(20130816)    ){
	mREGCONFIRMATIONDATE="16-08-2013";
	//out.print(mREGCONFIRMATIONDATE1int+"20130816");

}else if(QrySem==1 && mREGCONFIRMATIONDATE1int >(20130816)   ){
	//out.print(mREGCONFIRMATIONDATE1int+"20130816"+"****1111111111*******"+mREGCONFIRMATIONDATE+"    &nbsp;&nbsp;&nbsp;&nbsp;"); 
//	mREGCONFIRMATIONDATE=mREGCONFIRMATIONDATE+1;
 	
qrtyyy="select to_char(to_date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')+1,'dd-mm-yyyy')Regdate from dual";
rsyyyy=db.getRowset(qrtyyy);
if(rsyyyy.next()){
mREGCONFIRMATIONDATE=rsyyyy.getString("Regdate");
//out.print(mREGCONFIRMATIONDATE1int+"20130816"+"*****22222222222******"+mREGCONFIRMATIONDATE);
}

}



					 
					}else  if( (mINSTITUTECODE.equals("JPBS") ) && (QryProgramCode.equals("MBA"))
&& QryAcad.equals("1314") && 5==7	)	{
					
					QrySem=QrySem;

//out.print("*************************************");



if(QrySem==1 && mREGCONFIRMATIONDATE1int<=(20130630)    ){
	mREGCONFIRMATIONDATE="30-06-2013";
	//out.print(mREGCONFIRMATIONDATE1int+"20130630");

}else if(QrySem==1 && mREGCONFIRMATIONDATE1int >(20130630)   ){
	//out.print(mREGCONFIRMATIONDATE1int+"20130816"+"****1111111111*******"+mREGCONFIRMATIONDATE+"    &nbsp;&nbsp;&nbsp;&nbsp;"); 
//	mREGCONFIRMATIONDATE=mREGCONFIRMATIONDATE+1;
 	
qrtyyy="select to_char(to_date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')+1,'dd-mm-yyyy')Regdate from dual";
rsyyyy=db.getRowset(qrtyyy);
if(rsyyyy.next()){
mREGCONFIRMATIONDATE=rsyyyy.getString("Regdate");
//out.print(mREGCONFIRMATIONDATE1int+"20130816"+"*****22222222222******"+mREGCONFIRMATIONDATE);
}

}

					
					
					
					
					}
					else
					{
				QrySem=QrySem;
				mREGCONFIRMATIONDATE=mREGCONFIRMATIONDATE;
					}






//----------------------------------------special case -----------------------------//



qry1="select  LTP,fstid from V#StudentLTPDetail a where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"' AND INSTITUTECODE='"+mINSTITUTECODE+"' and a.studentid='"+mMemberID+"' group by LTP,fstid";

 
rs1=db.getRowset(qry1);
	while(rs1.next())
		{
		if(rs1.getString("LTP").equals("L"))			
			mLFSTID=rs1.getString("fstid");			
		else if(rs1.getString("LTP").equals("T"))
			mTFSTID=rs1.getString("fstid");	
		else if(rs1.getString("LTP").equals("P"))	
			mPFSTID=rs1.getString("fstid");
		}


qry1="select distinct fstid from StudentPrevAttendence a where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"' AND  a.LTP='L' ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"' and a.studentid='"+mMemberID+"' and  trunc(attendancedate)=(select max(trunc(attendancedate)) from StudentPrevAttendence a where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"'  AND  a.LTP='L' and INSTITUTECODE='"+mINSTITUTECODE+"' and a.studentid='"+mMemberID+"' ) ";
rs1=db.getRowset(qry1);
	while(rs1.next())
		{
		prevLFSTID=rs1.getString("fstid");			
		}

qry1="select distinct fstid from StudentPrevAttendence a where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"' AND  a.LTP='T' ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"' and a.studentid='"+mMemberID+"'and  trunc(attendancedate)=(select max(trunc(attendancedate)) from StudentPrevAttendence a where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"'  AND  a.LTP='T' and INSTITUTECODE='"+mINSTITUTECODE+"' and a.studentid='"+mMemberID+"' ) ";
//out.println(qry1);
rs1=db.getRowset(qry1);
	while(rs1.next())
		{
		prevTFSTID=rs1.getString("fstid");			
		}

	qry1="select distinct fstid from StudentPrevAttendence a where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"' AND  a.LTP='P' ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"' and a.studentid='"+mMemberID+"' and  trunc(attendancedate)=(select max(trunc(attendancedate)) from StudentPrevAttendence a where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"'  AND  a.LTP='P' and INSTITUTECODE='"+mINSTITUTECODE+"' and a.studentid='"+mMemberID+"' ) ";
rs1=db.getRowset(qry1);
	while(rs1.next())
		{
		prevPFSTID=rs1.getString("fstid");			
		}




long mNotAttendedAttendance=0;


// Process for L Type
mNotAttendedAttendance=0;
qry=" SELECT   nvl(count(pcount ),0)  pcount FROM (select distinct  CLASSTIMEFROM Pcount from V#STUDENTATTENDANCE a where SubjectID= '"+mSubject+"'  and LTP='L' and EXAMCODE= '"+QryExam+"'  AND  ( A.FSTID='"+mLFSTID+"'   OR (A.FSTID  IN ( SELECT b.mergewithfstid FROM FacultySubjecttagging b where  b.examcode='"+QryExam+"' and b.institutecode='"+mINSTITUTECODE+"' and b.SUBJECTID='"+mSubject+"' and  b.LTP='L' and b.FSTID='"+mLFSTID+"')))  ";  qry=qry+" and (("+QrySem+">1) or ("+QrySem+"=1 and trunc(A.attendancedate) >=trunc(TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))))  and a.studentid<>'"+mMemberID+"' ";
 qry=qry+" and trunc(a.classtimefrom)<  NVL((SELECT min(trunc(c.classtimefrom)) from v#STUDENTATTENDANCE c where c.studentid='"+mMemberID+"' and c.SubjectID= '"+mSubject+"'  and c.LTP='L' and c.EXAMCODE= '"+mExam+"' and c.institutecode='"+mINSTITUTECODE+"' ),a.classtimefrom)";
qry=qry+" and INSTITUTECODE='"+mINSTITUTECODE+"'   and nvl(DEACTIVE,'N')='N' and trunc(a.classtimefrom)<  NVL((                              SELECT min(trunc(c.classtimefrom)) from STUDENTPREVATTENDENCE c where  c.studentid='"+mMemberID+"' and  c.SubjectID= '"+mSubject+"'  and c.LTP='L' and c.EXAMCODE= '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"' ),a.classtimefrom) ";
qry=qry+" and (('"+QrySem+"'='1' and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy')) ";
qry=qry+"   or ("+QrySem+">1)        )   )";
//out.print(qry+"****"+mMemberID);
//if(mMemberID.equals("J1281100708"))

//out.print(qry+"******"+mMemberID);
rs1=db.getRowset(qry);
  
//out.print("aaa1");
while(rs1.next())
		{
		mNotAttendedAttendance=rs1.getLong("pcount");
			
		}

qry=" select count( distinct CLASSTIMEFROM) tot  from V#StudentAttendance  a where SubjectID= '"+mSubject+"'  and LTP='L' and EXAMCODE=  '"+QryExam+"' ";
qry=qry+"  AND  A.FSTID='"+prevLFSTID+"'   and INSTITUTECODE='"+mINSTITUTECODE+"'   and a.studentid<>'"+mMemberID+"' ";
qry=qry+" and not exists (select 1 from STUDENTPREVATTENDENCE c where c.studentid='"+mMemberID+"' and c.SubjectID= '"+mSubject+"'  and c.LTP='L' and c.EXAMCODE= '"+mExam+"' and c.institutecode='"+mINSTITUTECODE+"' and  trunc(c.CLASSTIMEFROM)= trunc(a.CLASSTIMEFROM))";
qry=qry+"  and trunc(a.attendancedate)<(  select min(c.attendancedate)  from STUDENTPREVATTENDENCE c where  c.SubjectID= '"+mSubject+"' and c.studentid='"+mMemberID+"' ";
qry=qry+"  and c.LTP='L' and c.EXAMCODE=  '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"'   and c.fstid='"+prevLFSTID+"' ) ";
qry=qry+"    and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(a.ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',a.ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";     

//if(mMemberID.equals("J1281100708"))
	
rs1=db.getRowset(qry);

while(rs1.next())
		{
		mNotAttendedAttendance=mNotAttendedAttendance+rs1.getLong("tot");
			
		}

 
qry1="SELECT   count(pcount ) pcount FROM (select distinct  CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"' AND  a.ltp='L' and a.studentid='"+mMemberID+"'   ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) )   ";
qry1=qry1+" UNION   ";
qry1=qry1+" select   distinct CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE where  subjectid ='"+mSubject+"'     AND ltp ='L'    ";
qry1=qry1+" AND examcode =  '"+QryExam+"'   AND studentid = '"+mMemberID+"'   ";       
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) )   ";
qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mINSTITUTECODE+"'  )";       
//if(mMemberID.equals("J1281100708"))
	//out.print(qry1+"*******"+mMemberID);

 

rs1=db.getRowset(qry1);
while(rs1.next())
		{
		mL=rs1.getLong("pcount");
			
		}

		 //out.print(mL+"**---**"+mNotAttendedAttendance);


qry1="SELECT   count(pcount ) pcount , to_Char(CLASSTIMEFROM,'dd-mm-yyyy') CLASSTIMEFROMX  FROM (select distinct CLASSTIMEFROM , CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+mSubject+"' and nvl(PRESENT,'N')='N' and EXAMCODE= '"+QryExam+"' AND  a.ltp='L' and a.studentid='"+mMemberID+"'   ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) )   ";
qry1=qry1+" UNION   ";
qry1=qry1+" select   distinct CLASSTIMEFROM  pcount  ,CLASSTIMEFROM from STUDENTPREVATTENDENCE where  subjectid ='"+mSubject+"' and nvl(PRESENT,'N')='N'    AND ltp ='L'    ";
qry1=qry1+" AND examcode =  '"+QryExam+"'   AND studentid = '"+mMemberID+"'   ";       
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) )   ";
qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mINSTITUTECODE+"'  ) group by CLASSTIMEFROM ,pcount";       
//if(mMemberID.equals("J1281100708"))
	//out.print(qry1+"*******"+mMemberID);

 

rs1=db.getRowset(qry1);
while(rs1.next())
		{
	qertu=" select 'Y' from ATTENDANCESPECIALAPPROVAL where INSTITUTECODE ='"+mINSTITUTECODE+"'  and EXAMCODE ='"+QryExam+"' and SUBJECTID ='"+mSubject+"' and STUDENTID ='"+mMemberID+"'  and  ((TO_DATE ('"+rs1.getString("CLASSTIMEFROMX")+"', 'dd-MM-yyyy') BETWEEN FROMPERIOD AND TOPERIOD ) OR (TO_DATE ('"+rs1.getString("CLASSTIMEFROMX")+"', 'dd-MM-yyyy')                BETWEEN FROMPERIOD AND TOPERIOD ) OR (FROMPERIOD between TO_DATE ('"+rs1.getString("CLASSTIMEFROMX")+"', 'dd-MM-yyyy') and                    TO_DATE('"+rs1.getString("CLASSTIMEFROMX")+"', 'dd-MM-yyyy')) OR (TOPERIOD between TO_DATE ('"+rs1.getString("CLASSTIMEFROMX")+"', 'dd-MM-yyyy') and                    TO_DATE('"+rs1.getString("CLASSTIMEFROMX")+"', 'dd-MM-yyyy')))      ";


rsqertu=db.getRowset(qertu);
///System.out.println(qertu+"**"+mMemberID);
if(rsqertu.next()){


	xL++;
}
}

mL=mL+mNotAttendedAttendance;
mL=mL-xL;
xL=0;



qry1="SELECT   count(pcount ) pcount FROM (select distinct   CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"' AND   a.ltp='L' and a.studentid='"+mMemberID+"' and nvl(a.present,'N')='Y' ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";
qry1=qry1+" UNION   ";
qry1=qry1+" select  distinct  CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE where  subjectid ='"+mSubject+"'     AND ltp ='L'    ";
qry1=qry1+" AND examcode =  '"+QryExam+"'   AND studentid = '"+mMemberID+"' and nvl(present,'N')='Y' "; 
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) )   ";
qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mINSTITUTECODE+"' )";       
//if(mMemberID.equals("J1281100708"))
//	out.print(qry1);;
rs1=db.getRowset(qry1);

while(rs1.next())
		{
		mLP=rs1.getLong("pcount");
			
		}





//-- For T

mNotAttendedAttendance=0;
qry=" SELECT   nvl(count(pcount ),0)  pcount FROM (select  distinct CLASSTIMEFROM Pcount from V#STUDENTATTENDANCE a where SubjectID= '"+mSubject+"'  and LTP='T' and EXAMCODE= '"+QryExam+"'  AND  ( A.FSTID='"+mTFSTID+"'   OR (A.FSTID IN ( SELECT b.mergewithfstid FROM FacultySubjecttagging b where  b.examcode='"+QryExam+"' and b.institutecode='"+mINSTITUTECODE+"' and b.SUBJECTID='"+mSubject+"' and  b.LTP='T' and b.FSTID='"+mTFSTID+"')))  ";                           
qry=qry+" and (("+QrySem+">1) or ("+QrySem+"=1 and trunc(A.attendancedate) >= trunc(TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))))  and a.studentid<>'"+mMemberID+"' ";

 qry=qry+" and trunc(a.classtimefrom)< NVL( (SELECT min(trunc(c.classtimefrom)) from v#STUDENTATTENDANCE c where c.studentid='"+mMemberID+"' and c.SubjectID= '"+mSubject+"'  and c.LTP='T' and c.EXAMCODE= '"+mExam+"' and c.institutecode='"+mINSTITUTECODE+"' ),a.classtimefrom)";
 qry=qry+" and INSTITUTECODE='"+mINSTITUTECODE+"'   and nvl(DEACTIVE,'N')='N' and trunc(a.classtimefrom)< NVL((   SELECT min(trunc(c.classtimefrom)) from STUDENTPREVATTENDENCE c where  c.studentid='"+mMemberID+"' and  c.SubjectID= '"+mSubject+"'  and c.LTP='T' and c.EXAMCODE= '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"' ),a.classtimefrom) ";
qry=qry+" and (('"+QrySem+"'='1' and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy')) ";
qry=qry+"   or ("+QrySem+">1)        )   ) ";
rs1=db.getRowset(qry);

//out.print(qry+"****"+mMemberID);
while(rs1.next())
		{
		mNotAttendedAttendance=rs1.getLong("pcount");
		//out.print("mNotAttendedAttendance  First"+mNotAttendedAttendance);		
		}

 qry=" select count( distinct CLASSTIMEFROM) tot  from V#StudentAttendance  a where SubjectID= '"+mSubject+"'  and LTP='T' and EXAMCODE=  '"+QryExam+"' ";
qry=qry+"  AND  A.FSTID='"+prevTFSTID+"'   and INSTITUTECODE='"+mINSTITUTECODE+"'   and a.studentid<>'"+mMemberID+"' ";
 qry=qry+" and not exists (select 1 from STUDENTPREVATTENDENCE c where c.studentid='"+mMemberID+"' and c.SubjectID= '"+mSubject+"'  and c.LTP='T' and c.EXAMCODE= '"+mExam+"' and c.institutecode='"+mINSTITUTECODE+"' and  trunc(c.CLASSTIMEFROM)= trunc(a.CLASSTIMEFROM))";
qry=qry+"  and trunc(a.attendancedate)<(  select min(c.attendancedate)  from STUDENTPREVATTENDENCE c where  c.SubjectID= '"+mSubject+"' and c.studentid='"+mMemberID+"' ";
qry=qry+"  and c.LTP='T' and c.EXAMCODE=  '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"'   and c.fstid='"+prevTFSTID+"' )  ";
qry=qry+"    and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(a.ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',a.ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";     

rs1=db.getRowset(qry);
//out.print(qry+"****"+mMemberID);
while(rs1.next())
		{
		mNotAttendedAttendance=mNotAttendedAttendance+rs1.getLong("tot");
		}
qry1="SELECT   count(pcount ) pcount FROM (select  distinct CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"' AND  a.ltp='T' and a.studentid='"+mMemberID+"'   ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) )   ";
qry1=qry1+" UNION   ";
qry1=qry1+" select distinct   CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE where  subjectid ='"+mSubject+"'     AND ltp ='T'    ";
qry1=qry1+" AND examcode =  '"+QryExam+"'   AND studentid = '"+mMemberID+"'   ";   
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) )   ";
qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mINSTITUTECODE+"'  )";       

//out.print("aaa3"+qry1);
rs1=db.getRowset(qry1);
while(rs1.next())
		{
		mT=rs1.getLong("pcount");
		//out.print("MT"+mT);
			
		}
mT=mT+mNotAttendedAttendance;




qry1="SELECT   count(pcount ) pcount ,to_Char(CLASSTIMEFROM,'dd-mm-yyyy') CLASSTIMEFROMX  FROM (select  distinct CLASSTIMEFROM pcount,CLASSTIMEFROM from V#STUDENTATTENDANCE a   where SubjectID= '"+mSubject+"' and nvl(PRESENT,'N')='N'  and nvl(PRESENT,'N')='N' and EXAMCODE= '"+QryExam+"' AND  a.ltp='T' and a.studentid='"+mMemberID+"'   ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) )   ";
qry1=qry1+" UNION   ";
qry1=qry1+" select distinct   CLASSTIMEFROM  pcount,CLASSTIMEFROM from STUDENTPREVATTENDENCE where  subjectid ='"+mSubject+"' and nvl(PRESENT,'N')='N'  and nvl(PRESENT,'N')='N'   AND ltp ='T'    ";
qry1=qry1+" AND examcode =  '"+QryExam+"'   AND studentid = '"+mMemberID+"'   ";   
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) )   ";
qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mINSTITUTECODE+"'  ) group by CLASSTIMEFROM ,pcount ";       

//out.print("aaa3"+qry1);
rs1=db.getRowset(qry1);
while(rs1.next())
		{
		qertu=" select 'Y' from ATTENDANCESPECIALAPPROVAL where INSTITUTECODE ='"+mINSTITUTECODE+"'  and EXAMCODE ='"+QryExam+"' and SUBJECTID ='"+mSubject+"' and STUDENTID ='"+mMemberID+"'   and  ((TO_DATE ('"+rs1.getString("CLASSTIMEFROMX")+"', 'dd-MM-yyyy') BETWEEN FROMPERIOD AND TOPERIOD ) OR (TO_DATE ('"+rs1.getString("CLASSTIMEFROMX")+"', 'dd-MM-yyyy')                BETWEEN FROMPERIOD AND TOPERIOD ) OR (FROMPERIOD between TO_DATE ('"+rs1.getString("CLASSTIMEFROMX")+"', 'dd-MM-yyyy') and                    TO_DATE('"+rs1.getString("CLASSTIMEFROMX")+"', 'dd-MM-yyyy')) OR (TOPERIOD between TO_DATE ('"+rs1.getString("CLASSTIMEFROMX")+"', 'dd-MM-yyyy') and                    TO_DATE('"+rs1.getString("CLASSTIMEFROMX")+"', 'dd-MM-yyyy')))     ";


rsqertu=db.getRowset(qertu);
///System.out.println(qertu+"**"+mMemberID);
if(rsqertu.next()){


	xT++;
}
			
		}

mT=mT-xT;

xT=0;
//out.print(mREGCONFIRMATIONDATE+"********************************"+mRollno);

qry1="SELECT   count(pcount ) pcount FROM (select distinct  CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"' and a.ltp='T' and a.studentid='"+mMemberID+"' and nvl(a.present,'N')='Y' ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) )  ";
qry1=qry1+" UNION   ";
qry1=qry1+" select  distinct  CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE where  subjectid ='"+mSubject+"'     AND ltp ='T'    ";
qry1=qry1+" AND examcode =  '"+QryExam+"'   AND studentid = '"+mMemberID+"' and nvl(present,'N')='Y' ";       
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) )   ";
qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mINSTITUTECODE+"' )";       

rs1=db.getRowset(qry1);
  //out.print("aaa4"+qry1);
while(rs1.next())
		{
		mTP=rs1.getLong("pcount");
			
		}



//		For P

mNotAttendedAttendance=0;
qry=" SELECT   nvl(count(pcount ),0)  pcount FROM (select distinct  CLASSTIMEFROM Pcount from V#STUDENTATTENDANCE a where SubjectID= '"+mSubject+"'  and LTP='P' and EXAMCODE= '"+QryExam+"'  AND  ( A.FSTID='"+mPFSTID+"'   OR ( A.FSTID IN ( SELECT b.mergewithfstid FROM FacultySubjecttagging b where  b.examcode='"+QryExam+"' and b.institutecode='"+mINSTITUTECODE+"' and b.SUBJECTID='"+mSubject+"' and  b.LTP='P' and b.FSTID='"+mPFSTID+"')))  ";                            
qry=qry+" and (("+QrySem+">1) or ("+QrySem+"=1 and trunc(A.attendancedate) >=trunc(TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))))  and a.studentid<>'"+mMemberID+"' ";
 qry=qry+" and trunc(a.classtimefrom)<  NVL((SELECT min(trunc(c.classtimefrom)) from v#STUDENTATTENDANCE c where c.studentid='"+mMemberID+"' and c.SubjectID= '"+mSubject+"'  and c.LTP='P' and c.EXAMCODE= '"+mExam+"' and c.institutecode='"+mINSTITUTECODE+"' ),a.classtimefrom)";
qry=qry+" and INSTITUTECODE='"+mINSTITUTECODE+"'   and nvl(DEACTIVE,'N')='N' and trunc(a.classtimefrom)<  NVL((   SELECT min(trunc(c.classtimefrom)) from STUDENTPREVATTENDENCE c where  c.studentid='"+mMemberID+"' and  c.SubjectID= '"+mSubject+"'  and c.LTP='P' and c.EXAMCODE= '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"' ),a.classtimefrom) ";
qry=qry+" and (('"+QrySem+"'='1' and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy')) ";
qry=qry+"   or ("+QrySem+">1)        )   )  ";
rs1=db.getRowset(qry);
//out.print(qry);
//out.print("aaa1");
while(rs1.next())
		{
		mNotAttendedAttendance=rs1.getLong("pcount");
			
		}

 qry=" select count( distinct CLASSTIMEFROM) tot  from V#StudentAttendance  a where SubjectID= '"+mSubject+"'  and LTP='P' and EXAMCODE=  '"+QryExam+"' ";
qry=qry+"  AND  A.FSTID='"+prevPFSTID+"'   and INSTITUTECODE='"+mINSTITUTECODE+"'   and a.studentid<>'"+mMemberID+"' ";
qry=qry+" and not exists (select 1 from STUDENTPREVATTENDENCE c where c.studentid='"+mMemberID+"' and c.SubjectID= '"+mSubject+"'  and c.LTP='P' and c.EXAMCODE= '"+mExam+"' and c.institutecode='"+mINSTITUTECODE+"' and  trunc(c.CLASSTIMEFROM)= trunc(a.CLASSTIMEFROM))";
qry=qry+"  and trunc(a.attendancedate)<(  select min(c.attendancedate)  from STUDENTPREVATTENDENCE c where  c.SubjectID= '"+mSubject+"' and c.studentid='"+mMemberID+"' ";
qry=qry+"  and c.LTP='P' and c.EXAMCODE=  '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"'   and c.fstid='"+prevPFSTID+"' )  ";
qry=qry+"    and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(a.ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',a.ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";     

//out.print(qry);
rs1=db.getRowset(qry);

//out.print("aaa1");
while(rs1.next())
		{
		mNotAttendedAttendance=mNotAttendedAttendance+rs1.getLong("tot");
			
		}
qry1="SELECT   count(pcount ) pcount FROM (select distinct CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"' and a.ltp='P' and a.studentid='"+mMemberID+"'   ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) )  ";
qry1=qry1+" UNION   ";
qry1=qry1+" select  distinct  CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE where  subjectid ='"+mSubject+"'     AND ltp ='P'    ";
qry1=qry1+" AND examcode =  '"+QryExam+"'   AND studentid = '"+mMemberID+"'   ";       
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) )   ";
qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mINSTITUTECODE+"' )";       
//out.print(qry1);


rs1=db.getRowset(qry1);
while(rs1.next())
		{
		mP=rs1.getLong("pcount");
			
		}



mP=mP+mNotAttendedAttendance;



qry1="SELECT   count(pcount ) pcount,to_Char(CLASSTIMEFROM,'dd-mm-yyyy') CLASSTIMEFROMX  FROM (select distinct CLASSTIMEFROM pcount ,CLASSTIMEFROM from V#STUDENTATTENDANCE a   where SubjectID= '"+mSubject+"' and nvl(PRESENT,'N')='N' and EXAMCODE= '"+QryExam+"' and a.ltp='P' and a.studentid='"+mMemberID+"'   ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) )  ";
qry1=qry1+" UNION   ";
qry1=qry1+" select  distinct  CLASSTIMEFROM  pcount ,CLASSTIMEFROM from STUDENTPREVATTENDENCE where  subjectid ='"+mSubject+"'  and nvl(PRESENT,'N')='N'   AND ltp ='P'    ";
qry1=qry1+" AND examcode =  '"+QryExam+"'   AND studentid = '"+mMemberID+"'   ";       
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) )   ";
qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mINSTITUTECODE+"' ) group by CLASSTIMEFROM , pcount ";       
//out.print(qry1);


rs1=db.getRowset(qry1);
while(rs1.next())
		{
		 
			
		


		qertu=" select 'Y' from ATTENDANCESPECIALAPPROVAL where INSTITUTECODE ='"+mINSTITUTECODE+"'  and EXAMCODE ='"+QryExam+"' and SUBJECTID ='"+mSubject+"' and STUDENTID ='"+mMemberID+"'  and  ((TO_DATE ('"+rs1.getString("CLASSTIMEFROMX")+"', 'dd-MM-yyyy') BETWEEN FROMPERIOD AND TOPERIOD ) OR (TO_DATE ('"+rs1.getString("CLASSTIMEFROMX")+"', 'dd-MM-yyyy')                BETWEEN FROMPERIOD AND TOPERIOD ) OR (FROMPERIOD between TO_DATE ('"+rs1.getString("CLASSTIMEFROMX")+"', 'dd-MM-yyyy') and                    TO_DATE('"+rs1.getString("CLASSTIMEFROMX")+"', 'dd-MM-yyyy')) OR (TOPERIOD between TO_DATE ('"+rs1.getString("CLASSTIMEFROMX")+"', 'dd-MM-yyyy') and                    TO_DATE('"+rs1.getString("CLASSTIMEFROMX")+"', 'dd-MM-yyyy')))       ";


rsqertu=db.getRowset(qertu);
///System.out.println(qertu+"**"+mMemberID);
if(rsqertu.next()){


	xP++;
}

		}

mP=mP-xP;

xP=0;

qry1="SELECT   count(pcount ) pcount FROM (select  distinct CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"'  and a.ltp='P' and a.studentid='"+mMemberID+"' and nvl(a.present,'N')='Y' ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) )  ";
qry1=qry1+" UNION   ";
qry1=qry1+" select  distinct  CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE where  subjectid ='"+mSubject+"'     AND ltp ='P'    ";
qry1=qry1+" AND examcode =  '"+QryExam+"'   AND studentid = '"+mMemberID+"' and nvl(present,'N')='Y' ";     
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) )   ";
qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mINSTITUTECODE+"'  )" ;       
//out.print(qry1);
rs1=db.getRowset(qry1);

while(rs1.next())
		{
		mPP=rs1.getLong("pcount");
			
		}




if(mL>0)
{
		mPercL=Math.ceil(((mLP*100)/mL));
					//out.print(mLP+"sdff"+mL);
		%>
		
	<td align=left><a Title="View Date wise Lecture Attendance" target=_New href='ViewDatewiseLecAttendance.jsp?EXAM=<%=QryExam%>&amp;CTYPE=<%=QryType%>&amp;SC=<%=mSubject%>&amp;LTP=L&amp;SEC=<%=QrySecBr%>&amp;SUBSEC=<%=QrySubSec%>&amp;SEMESTERTYPE=<%=QrySemType%>&amp;mMemberID=<%=mMemberID%>&amp;prevLFSTID=<%=prevLFSTID%>&amp;mLFSTID=<%=mLFSTID%>'><font color=blue><b><%=mPercL%></a>%</font></td>
<%
		
}


if(mT>0)
{

//out.print(mLP+"+"+mTP+"-------------------"+mL+"+"+mT+"**"+mMemberID);
		mPercT=Math.ceil((mTP*100)/mT);
		mPercLT=Math.ceil(((mLP+mTP)*100)/(mL+mT));

		%>
		
		<td align=left><a Title="View Date wise Tutorial Attendance" target=_New href='ViewDatewiseLecAttendance.jsp?EXAM=<%=QryExam%>&amp;CTYPE=<%=QryType%>&amp;SC=<%=mSubject%>&amp;LTP=T&amp;SEC=<%=QrySecBr%>&amp;SUBSEC=<%=QrySubSec%>&amp;SEMESTERTYPE=<%=QrySemType%>&amp;mMemberID=<%=mMemberID%>&amp;prevTFSTID=<%=prevTFSTID%>&amp;mTFSTID=<%=mTFSTID%>'><font color=blue><b><%=mPercT%></a>%</td>
		
		<td align=left><a Title="View Date wise Lecture + Tutorial Attendance" target=_New href='ViewDatewiseLecAttendance.jsp?EXAM=<%=QryExam%>&amp;CTYPE=<%=QryType%>&amp;SC=<%=mSubject%>&amp;LTP=LT&amp;SEC=<%=QrySecBr%>&amp;SUBSEC=<%=QrySubSec%>&amp;SEMESTERTYPE=<%=QrySemType%>&amp;mMemberID=<%=mMemberID%>&amp;prevTFSTID=<%=prevTFSTID%>&amp;prevLFSTID=<%=prevLFSTID%>&amp;mLFSTID=<%=mLFSTID%>&amp;mTFSTID=<%=mTFSTID%>'><font color=blue><b><%=mPercLT%></a>%</td>
		<%
		
}

if(mP>0)
{
		mPercP=Math.ceil((mPP*100)/mP);
		
		%>
		<td align=left><a Title="View Date wise Practical Attendance" target=_New href='ViewDatewiseLecAttendance.jsp?EXAM=<%=QryExam%>&amp;CTYPE=<%=QryType%>&amp;SC=<%=mSubject%>&amp;LTP=P&amp;SEC=<%=QrySecBr%>&amp;SUBSEC=<%=QrySubSec%>&amp;SEMESTERTYPE=<%=QrySemType%>&amp;mMemberID=<%=mMemberID%>&amp;prevPFSTID=<%=prevPFSTID%>&amp;mPFSTID=<%=mPFSTID%>'><font color=blue><b><%=mPercP%></a>%</td>
		<%
		
}

mL=0;
mT=0;
mP=0;
mLP=0;
mTP=0;
mPP=0;
%>
</tr>	
<%
 

 
 }
       }
                    %>


           </tbody>
			</table>
			<script type="text/javascript">
			var st1 = new SortableTable(document.getElementById("table-1"),["Number", "CaseInsensitiveString", "CaseInsensitiveString", "CaseInsensitiveString", "Number", "Number"]);
			</script>

			

<td></tr>


</table>




            <table align=center bgcolor=white  border=1>
                <tr>
                    <td align=middle><font color=blue face=arial size=3><b>Total Student(s) - <%=Ctr%></b></font></td>
                </tr>
            </table>
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
		//out.print("qry "+e.getMessage());
		//out.print("qry "+qry);
        }
        %>
    </body>
</html>