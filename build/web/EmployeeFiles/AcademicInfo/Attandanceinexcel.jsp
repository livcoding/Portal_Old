<%@ page language="java" import="java.sql.*,java.math.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%

        DBHandler db = new DBHandler();
        ResultSet rs = null;
        ResultSet rs1 = null;
        ResultSet rs2 = null;
        ResultSet rsAtt = null, rsRowNum = null, RsChk1 = null, rsdt = null;
        GlobalFunctions gb = new GlobalFunctions();
        String qry = "";
        String qry2 = "";
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
        int Ctr = 0, mDiffInDate = 0;
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
        String mInst = "", mComp = "", mSrcType = "",mColor="";
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







         if (session.getAttribute("SrcType") == null) {
            mSrcType = "";
        } else {
            mSrcType = session.getAttribute("SrcType").toString().trim();
        }


          if (session.getAttribute("EXAM") == null) {
            mExam = "";
        } else {
            mExam = session.getAttribute("EXAM").toString().trim();
        }
          if (session.getAttribute("SUBJECT") == null) {
            mSubject = "";
        } else {
            mSubject = session.getAttribute("SUBJECT").toString().trim();
        }
          if (session.getAttribute("SECTION") == null) {
            mSection = "";
        } else {
            mSection = session.getAttribute("SECTION").toString().trim();
        }
          if (session.getAttribute("SUBSECTION") == null) {
            mSubsection = "";
        } else {
            mSubsection = session.getAttribute("SUBSECTION").toString().trim();
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

        

       
        
        <script>
            if(window.history.forward(1) != null)
                window.history.forward(1);
        </script>
    </head>
    <body onload="AlertMe()" aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>

         <table align=center><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: Arial"><B>Student Wise Class Attendance  / Co-ordinator Wise Student Attendance List </b></font></TABLE>

        <%@page contentType="text/html"%>
	   	<%
		response.setContentType("application/vnd.ms-excel");
		
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
            //   out.print(qry);
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

	String QryEmpID="",QrySemType="",QrySecBr="",QrySubSec="";
                  
                        
                        //out.print(mExam+" "+mSubject+" "+mLTP+" "+mSection+" "+mSubsection);
       %>
       <form name="frm1" method=post action="Attandanceinexcel.jsp">
            <table bgcolor=#fce9c5 class="sort-table" id="table-1" width='70%' bottommargin=0 rules=rows topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center>
                <thead>
                    <tr bgcolor="#ff8c00">
                        <td rowspan=2 Title="Sort on SlNo"><font color="White"><b>Sr.<br>No.</b></font></td>
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
                        <td Colspan="<%=count%>" Title="Sort on Student % Attendance" align="center" nowrap><font color="White"><b>(%) Attendance Till Today</b></font></td>
                    </tr>

                </thead>
                 
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
                <tbody
                <tr></tr>
                    <%

                            qry = "select distinct nvl(A.enrollmentno,' ')enrollmentno,nvl(A.studentname,' ')studentname, NVL(A.studentid,' ')studentid,";
                            qry = qry + " NVL(A.SECTIONBRANCH,' ')|| '('||A.SUBSECTIONCODE||')' sectionbranch, nvl(B.SEMESTER,1) SEMESTER, To_Char(b.REGCONFIRMATIONDATE,'DD-MM-YYyy') REGCONFIRMATIONDATE ,nvl(b.SPECIALAPPROVAL,'N')SPECIALAPPROVAL ,";
                            qry = qry + " A.SECTIONBRANCH SECBR, A.SUBSECTIONCODE SUBSEC, NVL(a.SEMESTERTYPE,' ')SEMESTERTYPE ";
                            qry = qry + " from V#STUDENTLTPDETAIL A,STUDENTREGISTRATION B ";
                            qry = qry + " Where NVL(a.studentdeactive,'N')='N' AND NVL(a.deactive,'N')='N' ";
                            qry = qry + " AND B.INSTITUTECODE=A.INSTITUTECODE";
                            qry = qry + " AND B.EXAMCODE=A.EXAMCODE";
                            qry = qry + " AND b.EXAMCODE='"+mExam +"'";
                            qry = qry + " AND a.EXAMCODE='"+mExam +"'";
                            //qry = qry + " AND d.EXAMCODE='"+mExam +"'";
                            qry = qry + " AND B.ACADEMICYEAR=A.ACADEMICYEAR";
                            qry = qry + " AND B.STUDENTID=A.STUDENTID and a.InstituteCode='" + mInst + "'";
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
                            qry = qry + " and A.ExamCode='" + mExam + "'  ";
                                qry = qry + " order by EnrollmentNo";
                      //  out.print(qry); // and a.enrollmentno='11103510'
							  String mStudentid="";
                            ResultSet rs11 = db.getRowset(qry);
                            while (rs11.next()) {
								long mPresent=0, mL=0, mT=0, mP=0, mLP=0, mTP=0, mPP=0;

								long mPercL=0,mPercT=0,mPercP=0,mPercLT=0;
								if(!mStudentid.equals(rs11.getString("studentid")))
								{
									mStudentid=rs11.getString("studentid");

                                Ctr++;
                                if (Ctr % 2


                                                                                                                      == 0) {
                                    TRCOLOR = "White";
                                } else {
                                    TRCOLOR = "#F8F8F8";
                                }

                                mRollno = rs11.getString("enrollmentno").toString().trim();
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
								QrySubSec=rs11.getString("SUBSEC").toString().trim();

							mSpecialApproval=rs11.getString("SPECIALAPPROVAL");

								if(rs11.getString("REGCONFIRMATIONDATE")==null)
									mREGCONFIRMATIONDATE=" ";
								else
									mREGCONFIRMATIONDATE=rs11.getString("REGCONFIRMATIONDATE");

                    %>
                    
                    <tr bgcolor=<%=TRCOLOR%>>
                        <td><%=Ctr%>.</td>
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



//----------------------------------------special case -----------------------------//

if(mSpecialApproval.equals("Y"))
	QrySem=1;
else
	QrySem=QrySem;

//----------------------------------------special case -----------------------------//



/*qry1="select distinct fstid from V#StudentLTPDetail a where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"' AND  a.LTP='L' ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"' and a.studentid='"+mMemberID+"' ";
rs1=db.getRowset(qry1);
	while(rs1.next())
		{
		mLFSTID=rs1.getString("fstid");
		}

qry1="select distinct fstid from V#StudentLTPDetail a where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"' AND  a.LTP='T' ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"' and a.studentid='"+mMemberID+"' ";
//out.println(qry1);
rs1=db.getRowset(qry1);
	while(rs1.next())
		{
		mTFSTID=rs1.getString("fstid");
		}

		qry1="select distinct fstid from V#StudentLTPDetail a where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"' AND  a.LTP='P' ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"' and a.studentid='"+mMemberID+"' ";
rs1=db.getRowset(qry1);
	while(rs1.next())
		{
		mPFSTID=rs1.getString("fstid");
		}
*/

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
qry=" SELECT   nvl(count(pcount ),0)  pcount FROM (select distinct  CLASSTIMEFROM Pcount from V#STUDENTATTENDANCE a where SubjectID= '"+mSubject+"'  and LTP='L' and EXAMCODE= '"+QryExam+"'  AND  ( A.FSTID='"+mLFSTID+"'   OR (A.FSTID  IN ( SELECT b.mergewithfstid FROM FacultySubjecttagging b where  b.examcode='"+QryExam+"' and b.institutecode='"+mINSTITUTECODE+"' and b.SUBJECTID='"+mSubject+"' and  b.LTP='L' and b.FSTID='"+mLFSTID+"')))  ";  qry=qry+" and (("+QrySem+">1) or ("+QrySem+"=1 and trunc(A.attendancedate) >= trunc(TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))))  and a.studentid<>'"+mMemberID+"' ";
 qry=qry+" and trunc(a.classtimefrom)<  NVL((SELECT min(trunc(c.classtimefrom)) from v#STUDENTATTENDANCE c where c.studentid='"+mMemberID+"' and c.SubjectID= '"+mSubject+"'  and c.LTP='L' and c.EXAMCODE= '"+mExam+"' and c.institutecode='"+mINSTITUTECODE+"' ),a.classtimefrom)";
qry=qry+" and INSTITUTECODE='"+mINSTITUTECODE+"'   and nvl(DEACTIVE,'N')='N' and trunc(a.classtimefrom)<  NVL((                              SELECT min(trunc(c.classtimefrom)) from STUDENTPREVATTENDENCE c where  c.studentid='"+mMemberID+"' and  c.SubjectID= '"+mSubject+"'  and c.LTP='L' and c.EXAMCODE= '"+QryExam+"' and c.institutecode='"+mINSTITUTECODE+"' ),a.classtimefrom) ";
qry=qry+" and (('"+QrySem+"'='1' and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy')) ";
qry=qry+"   or ("+QrySem+">1)        )   )";
//out.print(qry);
//if(mMemberID.equals("J1281100708"))
//	out.print(qry);
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
//if(mMemberID.equals("J1281100708"))
//	out.print(qry);
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
qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mINSTITUTECODE+"'  )";
//if(mMemberID.equals("J1281100708"))
//	out.print(qry1);



rs1=db.getRowset(qry1);
while(rs1.next())
		{
		mL=rs1.getLong("pcount");

		}
mL=mL+mNotAttendedAttendance;

qry1="SELECT   count(pcount ) pcount FROM (select distinct   CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"' AND   a.ltp='L' and a.studentid='"+mMemberID+"' and nvl(a.present,'N')='Y' ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";
qry1=qry1+" UNION   ";
qry1=qry1+" select  distinct  CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE where  subjectid ='"+mSubject+"'     AND ltp ='L'    ";
qry1=qry1+" AND examcode =  '"+QryExam+"'   AND studentid = '"+mMemberID+"' and nvl(present,'N')='Y' ";
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

//out.print("aaa1");
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
rs1=db.getRowset(qry);

while(rs1.next())
		{
		mNotAttendedAttendance=mNotAttendedAttendance+rs1.getLong("tot");
		}
qry1="SELECT   count(pcount ) pcount FROM (select  distinct CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"' AND  a.ltp='T' and a.studentid='"+mMemberID+"'   ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) )   ";
qry1=qry1+" UNION   ";
qry1=qry1+" select distinct   CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE where  subjectid ='"+mSubject+"'     AND ltp ='T'    ";
qry1=qry1+" AND examcode =  '"+QryExam+"'   AND studentid = '"+mMemberID+"'   ";
qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mINSTITUTECODE+"'  )";


rs1=db.getRowset(qry1);
while(rs1.next())
		{
		mT=rs1.getLong("pcount");
		//out.print("MT"+mT);

		}
mT=mT+mNotAttendedAttendance;

qry1="SELECT   count(pcount ) pcount FROM (select distinct  CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"' and a.ltp='T' and a.studentid='"+mMemberID+"' and nvl(a.present,'N')='Y' ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) )  ";
qry1=qry1+" UNION   ";
qry1=qry1+" select  distinct  CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE where  subjectid ='"+mSubject+"'     AND ltp ='T'    ";
qry1=qry1+" AND examcode =  '"+QryExam+"'   AND studentid = '"+mMemberID+"' and nvl(present,'N')='Y' ";
qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mINSTITUTECODE+"' )";

rs1=db.getRowset(qry1);

while(rs1.next())
		{
		mTP=rs1.getLong("pcount");

		}



//		For P

mNotAttendedAttendance=0;
qry=" SELECT   nvl(count(pcount ),0)  pcount FROM (select distinct  CLASSTIMEFROM Pcount from V#STUDENTATTENDANCE a where SubjectID= '"+mSubject+"'  and LTP='P' and EXAMCODE= '"+QryExam+"'  AND  ( A.FSTID='"+mPFSTID+"'   OR ( A.FSTID IN ( SELECT b.mergewithfstid FROM FacultySubjecttagging b where  b.examcode='"+QryExam+"' and b.institutecode='"+mINSTITUTECODE+"' and b.SUBJECTID='"+mSubject+"' and  b.LTP='P' and b.FSTID='"+mPFSTID+"')))  ";
qry=qry+" and (("+QrySem+">1) or ("+QrySem+"=1 and trunc(A.attendancedate) >= trunc(TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))))  and a.studentid<>'"+mMemberID+"' ";
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
qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mINSTITUTECODE+"' )";
//out.print(qry1);


rs1=db.getRowset(qry1);
while(rs1.next())
		{
		mP=rs1.getLong("pcount");

		}
mP=mP+mNotAttendedAttendance;

qry1="SELECT   count(pcount ) pcount FROM (select  distinct CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+mSubject+"' and EXAMCODE= '"+QryExam+"'  and a.ltp='P' and a.studentid='"+mMemberID+"' and nvl(a.present,'N')='Y' ";
qry1=qry1+" and INSTITUTECODE='"+mINSTITUTECODE+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) )  ";
qry1=qry1+" UNION   ";
qry1=qry1+" select  distinct  CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE where  subjectid ='"+mSubject+"'     AND ltp ='P'    ";
qry1=qry1+" AND examcode =  '"+QryExam+"'   AND studentid = '"+mMemberID+"' and nvl(present,'N')='Y' ";
qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mINSTITUTECODE+"'  )" ;
//out.print(qry1);
rs1=db.getRowset(qry1);

while(rs1.next())
		{
		mPP=rs1.getLong("pcount");

		}




if(mL>0)
{
		mPercL=Math.round(((mLP*100)/mL));


			//out.print(mPercLT+"sdff");
		%>


	<td align=left><font color=blue><b><%=mPercL%></a></font></td>
<%

}

if(mT>0)
{
		mPercT=Math.round((mTP*100)/mT);
		mPercLT=Math.round(((mLP+mTP)*100)/(mL+mT));

		%>

		<td align=left><font color=blue><b><%=mPercT%></a></td>

		<td align=left><font color=blue><b><%=mPercLT%></a></td>
		<%

}

if(mP>0)
{
		mPercP=Math.round((mPP*100)/mP);

		%>
		<td align=left><font color=blue><b><%=mPercP%></a></td>
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
                var st1 = new SortableTable(document.getElementById("table-1"),["Number", "Number", "CaseInsensitiveString","CaseInsensitiveString","Number"]);
            </script>
            <table align=center bgcolor=white width=50% cellmargin=0 bottommargin=0 border=1>
                <tr><td></td><td></td><td></td><td></td>
                    <td align=middle><font color=blue face=arial size=3><b><%=Ctr%>-Total Student(s)</b></font></td>


                </tr>

            </table>
           
        </form>
        <%
                    
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