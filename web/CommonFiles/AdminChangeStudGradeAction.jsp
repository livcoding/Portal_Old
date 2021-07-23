

<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="CommonFiles/ExceptionHandler.jsp" %> 

<%
        String mHead = "";
        if (session.getAttribute("PageHeading") != null && !session.getAttribute("PageHeading").equals("")) {
            mHead = session.getAttribute("PageHeading").toString().trim();
        } else {
            mHead = "JIIT ";
        }
%>
<HTML>
<head>
    <TITLE>#### <%=mHead%> [ View Student Grade Card (Eventwise) ] </TITLE>
    <script type="text/javascript" src="js/sortabletable.js"></script>
    <link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
 

    <script>
        if(window.history.forward(1) != null)
            window.history.forward(1);
    </script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
    <%
        /*
        '
         *************************************************************************************************
        ' *
        ' * File Name:	AdminChangeStudGrade.JSP		[For Admin]
        ' * Author:		Vijay Kumar
        ' * Date:		4th Jun 2009
        ' * Version:	1.0
        ' * Description:	Grade Card of Students
         *************************************************************************************************
         */
        DBHandler db = new DBHandler();
        OLTEncryption enc = new OLTEncryption();
        String qry = "", mWebEmail = "", EmpIDType = "";
        String qry1 = "", qry2 = "";
        String mMemberID = "", mMemberType = "", mMemberCode = "", mMemberName = "", mDMemberCode = "";
        String mInst = "", mGFlag = "";
        String QryExam = "", mExamCode = "", mProg = "", mBranch = "", mSem = "", mName = "";
        String mINSTITUTECODE = "";
        String mEmployeeID = "";
        String mSUBJECTCODE = "", ABC = "";
        String mEName = "", mSID = "", mEntryBy = "";
        ResultSet rs = null, rs1 = null, rs2 = null, rss1 = null;

        if (session.getAttribute("WebAdminEmail") == null) {
            mWebEmail = "";
        } else {
            mWebEmail = session.getAttribute("WebAdminEmail").toString().trim();
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
       if (request.getParameter("INSCODE")==null)
        {
	        mINSTITUTECODE ="";
        }
        else
       {
	       mINSTITUTECODE =request.getParameter("INSCODE").toString().trim();
        }
        if (session.getAttribute("ProgramCode") == null) {
            mProg = "";
        } else {
            mProg = session.getAttribute("ProgramCode").toString().trim();
        }

        if (session.getAttribute("BranchCode") == null) {
            mBranch = "";
        } else {
            mBranch = session.getAttribute("BranchCode").toString().trim();
        }

        if (session.getAttribute("CurrentSem") == null) {
            mSem = "";
        } else {
            mSem = session.getAttribute("CurrentSem").toString().trim();
        }

        if (session.getAttribute("MemberName") == null) {
            mName = "";
        } else {
            mName = session.getAttribute("MemberName").toString().trim();
        }

        if (request.getParameter("SID") == null) {
            mSID = "";
        } else {
            mSID = request.getParameter("SID").toString().trim();
        }

        try {  //1
            if (!mMemberID.equals("") && !mMemberType.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) {  //2

                String mChkMemID = enc.decode(session.getAttribute("MemberID").toString().trim());
                String mChkMType = enc.decode(session.getAttribute("MemberType").toString().trim());
                String mIPAddress = session.getAttribute("IPADD").toString().trim();
                String mMacAddress = " "; //session.getAttribute("IPADD").toString().trim();
                String mRole = enc.decode(session.getAttribute("ROLENAME").toString().trim());
                ResultSet RsChk = null;
                //-----------------------------
                //-- Enable Security Page Level
                //-----------------------------
                qry = "Select WEBKIOSK.ShowLink('159','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";
                RsChk = db.getRowset(qry);
                if (RsChk.next() && RsChk.getString("SL").equals("Y")) {
                    //----------------------
                    try {
                        mDMemberCode = enc.decode(mMemberCode);
                        mMemberID = enc.decode(mMemberID);
                        mMemberType = enc.decode(mMemberType);
                    } catch (Exception e) {
                        //out.println(e.getMessage());
                    }


                    String mSnm = "", mENo = "";
                    String mProgr = "", mBran = "";
                    int mSem1 = 0;
                    int mFlag = 0;
                    qry = "select StudentName, Enrollmentno ,semester,programcode,branchcode from StudentMaster where StudentID='" + mSID + "'";
                    rs1 = db.getRowset(qry);
                    if (rs1.next()) {
                        mSnm = rs1.getString("StudentName");
                        mENo = rs1.getString("Enrollmentno");
                        mSem1 = rs1.getInt("semester");
                        mProgr = rs1.getString("programcode");
                        mBran = rs1.getString("branchcode");
                    }
    %>
    <table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
        <tr><TD align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Changed Status of Student Grade</b></font></td></tr>
    </table>
    <BR>
    <table rules=groups cellspacing=1 cellpadding=1 align=center border=1>
        <tr><td NOWRAP><font color=black face=arial size=2><STRONG>&nbsp; Name:&nbsp;</STRONG></font><font face="Vardana"><%=GlobalFunctions.toTtitleCase(mSnm)%> [<%=mENo%>]</font>
                &nbsp; &nbsp; &nbsp; &nbsp;<font color=black face=arial size=2><STRONG>Course/Branch:&nbsp;</STRONG></font><font face="Vardana"><%=mProgr%>(<%=mBran%>)</font>
        &nbsp; &nbsp; &nbsp; &nbsp;<font color=black face=arial size=2><STRONG>Current Semester:&nbsp;</STRONG></font><font face="Vardana"><%=mSem1%></font></td></tr>
    </TABLE<br>
    <%
            int SNO = 0, mTot = 0;
            String mObjName = "", mBRKNO = "", mFSTID = "";
            String mSBJID = "", mOGrd = "", mNGrd = "";
            String QryTransID = "", mRemToAppr = "";
            String mTransID = "";

            if (request.getParameter("Tot") == null) {
                mTot = 0;
            } else {
                mTot = Integer.parseInt(request.getParameter("Tot").toString().trim());
            }


            for (SNO = 1; SNO <= mTot; SNO++) {
                mObjName = "SUBJ" + SNO;
                if (request.getParameter(mObjName) == null) {
                    mSBJID = "";
                } else {
                    mSBJID = request.getParameter(mObjName).toString().trim();
                }

                mObjName = "OLDGRADE" + SNO;
                if (request.getParameter(mObjName) == null) {
                    mOGrd = "";
                } else {
                    mOGrd = request.getParameter(mObjName).toString().trim();
                }

                mObjName = "NEWGRADE" + SNO;
                if (request.getParameter(mObjName) == null) {
                    mNGrd = "";
                } else {
                    mNGrd = request.getParameter(mObjName).toString().trim();
                }

                mObjName = "FSTID" + SNO;
                if (request.getParameter(mObjName) == null) {
                    mFSTID = "";
                } else {
                    mFSTID = request.getParameter(mObjName).toString().trim();
                }

                mObjName = "BRKNO" + SNO;
                if (request.getParameter(mObjName) == null) {
                    mBRKNO = "";
                } else {
                    mBRKNO = request.getParameter(mObjName).toString().trim();
                }

                if (request.getParameter("RemToAppr") == null) {
                    mRemToAppr = "";
                } else {
                    mRemToAppr = GlobalFunctions.replaceSignleQuot(request.getParameter("RemToAppr").toString().trim());
                }

                qry = "Select distinct EXAMCODE from FacultySubjectTagging where fstid='" + mFSTID + "'";
                ResultSet rssr = db.getRowset(qry);
                if (rssr.next()) {
                    mExamCode = rssr.getString(1);
                }


                if (!mNGrd.equals(mOGrd)) {
                    /*qry="SELECT nvl(TRANSID,'0')TRANSID from UPDREQ#STUDENTWISEGRADE where INSTITUTECODE='"+mINSTITUTECODE+"' ORDER BY TRANSID DESC";
                    //out.print(qry);
                    ResultSet rrss=db.getRowset(qry);
                    if(rrss.next())
                    {
                    QryTransID=rrss.getString(1);
                    mTransID=Integer.parseInt(QryTransID)+1;
                    }
                    if(mTransID==0)
                    mTransID=1;*/

                    qry = "SELECT 'Y' from UPDREQ#STUDENTWISEGRADE where INSTITUTECODE='" + mINSTITUTECODE + "' AND FSTID='" + mFSTID + "' And STUDENTID='" + mSID + "' ";
                    //out.print(qry);
                    ResultSet rrss = db.getRowset(qry);
                    int n = 0;
                    if (rrss.next()) {
                        qry = "UPDATE UPDREQ#STUDENTWISEGRADE SET TRANSDATE=SYSDATE, OLDGRDAE='" + mOGrd + "', NEWGRADE='" + mNGrd + "', APPROVALREQUESTREMARKS='" + mRemToAppr + "', ENTRYBY='" + mMemberID + "', ENTRYDATE=SYSDATE";
                        qry += " WHERE INSTITUTECODE='" + mINSTITUTECODE + "' AND FSTID='" + mFSTID + "' And STUDENTID='" + mSID + "'";
                        n = db.update(qry);
                    } else {
                        mTransID = db.GenerateGradeModificationNo(mINSTITUTECODE);
                        //out.print("mTransID ::"+mTransID);
                        qry = "INSERT INTO UPDREQ#STUDENTWISEGRADE (INSTITUTECODE, TRANSID, TRANSDATE, EXAMCODE, FSTID, BREAK#SLNO, STUDENTID, OLDGRDAE, NEWGRADE, APPROVALREQUESTREMARKS,APPROVALFLAG, ENTRYBY, ENTRYDATE)";
                        qry += " VALUES('" + mINSTITUTECODE + "','" + mTransID + "',sysdate,'" + mExamCode + "','" + mFSTID + "','" + mBRKNO + "','" + mSID + "','" + mOGrd + "','" + mNGrd + "','" + mRemToAppr + "','A','" + mMemberID + "',sysdate)";
                        n = db.insertRow(qry);
                    }
                    //out.print(qry);
                    mFlag += n;
                    if (n > 0) {

  //---- Log Entry
                        //-----------------
                        db.saveTransLog(mINSTITUTECODE, mMemberID, mMemberType, "Grdae Changed (Provisonal)", " For FSTID:" + mFSTID + " SubjID:" + mSBJID + " StudID : " + mSID + " Old " + mOGrd + " New:" + mNGrd, "No MAC Address", mIPAddress);
                    //-----------------

qry="Update STUDENTWISEGRADE Set FINALGRADE='"+mNGrd+"' Where FSTID='"+mFSTID+"' And BREAK#SLNO='"+mBRKNO+"' And STUDENTID='"+mSID+"'";
//	out.print(qry);
	
	int n1=db.update(qry);

	  if (n1>0)
	  {
		//---- Log Entry
	  	//-----------------
     	      db.saveTransLog(mInst,mMemberID,mMemberType,"Grdae Changed" ,  " For FSTID:"+mFSTID +" SubjID:"+mSBJID+" StudID : "+mSID+ " Old "+mOGrd+" New:"+mNGrd , "No MAC Address" , mIPAddress);
		//-----------------
	  }


                      
                    }





                }
            }

            if (mFlag > 0) {
    %>
    <table border=1 bordercolor=orange cellpadding=1 cellspacing=1 rules="All" align=center>
    <tr bgcolor=ff8c00>
        <td><b><Font color=white face=arial>Subject</font></b></td>
        <td><b><Font color=white face=arial>Old Grade</font></b></td>
        <td><b><Font color=white face=arial>New Grade</font></b></td>
        <td><b><Font color=white face=arial>Approval Status</font></b></td>
        <td><b><Font color=white face=arial>Changed By</font></b></td>
    </tr>
    <%

        for (SNO = 1; SNO <= mTot; SNO++) {
            mObjName = "SUBJ" + SNO;
            if (request.getParameter(mObjName) == null) {
                mSBJID = "";
            } else {
                mSBJID = request.getParameter(mObjName).toString().trim();
            }

            mObjName = "OLDGRADE" + SNO;
            if (request.getParameter(mObjName) == null) {
                mOGrd = "";
            } else {
                mOGrd = request.getParameter(mObjName).toString().trim();
            }

            mObjName = "NEWGRADE" + SNO;
            if (request.getParameter(mObjName) == null) {
                mNGrd = "";
            } else {
                mNGrd = request.getParameter(mObjName).toString().trim();
            }

            mObjName = "FSTID" + SNO;
            if (request.getParameter(mObjName) == null) {
                mFSTID = "";
            } else {
                mFSTID = request.getParameter(mObjName).toString().trim();
            }

            mObjName = "BRKNO" + SNO;
            if (request.getParameter(mObjName) == null) {
                mBRKNO = "";
            } else {
                mBRKNO = request.getParameter(mObjName).toString().trim();
            }


            qry = "select Distinct A.EXAMCODE EXAMCODE,A.OLDGRDAE,A.NEWGRADE, B.SUBJECTID SUBJECTID,B.SUBJECTCODE SUBJCODE, B.SUBJECT SUBJNAME, decode(A.APPROVALFLAG,'A','Approved','C','Cancelled','D','Pending','F','Finalized','Not Approved')Status, nvl(A.ENTRYBY,' ') ENTRYBY";
            qry = qry + " from UPDREQ#STUDENTWISEGRADE A, SUBJECTMASTER B, facultysubjecttagging c where a.institutecode = c.institutecode AND a.FSTID=c.FSTID AND b.institutecode = c.institutecode AND b.subjectid = c.subjectid And A.INSTITUTECODE='" + mINSTITUTECODE + "'";
            qry = qry + " And A.EXAMCODE='" + mExamCode + "' And A.BREAK#SLNO='" + mBRKNO + "' And A.STUDENTID='" + mSID + "' And A.FSTID='" + mFSTID + "' And A.OLDGRDAE='" + mOGrd + "' And A.NEWGRADE='" + mNGrd + "'  Order by SUBJNAME";
            rs = db.getRowset(qry);
          //  out.print(qry);
            String mApprovedBy = "", mEMPName = "";
            while (rs.next()) {
                mEntryBy = rs.getString("ENTRYBY");
                qry = "Select nvl(EMPLOYEENAME,' ') EName FROM EMPLOYEEMASTER WHERE EMPLOYEEID='" + mEntryBy + "'";
                rs1 = db.getRowset(qry);
                if (rs1.next()) {
                    mEMPName = rs1.getString("EName");
                } else {
                    mEMPName = " ";
                }
    %>
    <tr>
        <td align=left><%=rs.getString("SUBJNAME")%></td>
        <td align=left><%=rs.getString("OLDGRDAE")%></td>
        <td align=left><%=rs.getString("NEWGRADE")%></td>

        <%
                        if (rs.getString("Status").equals("Approved")) {
        %>
        <td align=center><font color=green><%=rs.getString("Status")%></font></td>
        <%
        } else if (rs.getString("Status").equals("Finalized")) {
        %>
        <td align=center><font color=green><%=rs.getString("Status")%></font></td>
        <%
        } else if (rs.getString("Status").equals("Cancelled")) {
        %>
        <td align=center><font color=green><%=rs.getString("Status")%></font></td>
        <%
        } else {
        %>
        <td align=center><font color=red><%=rs.getString("Status")%></font></td>
        <%
                        }
                        if (!mEMPName.equals(" ")) {
        %>
        <td align=left><%=mEMPName%></td>
    </tr>
    <%
        } else {
    %>
    <td>&nbsp;</td>
    </tr>
    <%                }
            }
        }

    %>
    </table><BR><BR><CENTER><font color=Green Size=4 face='Verdana'>Student Grade(s) changed successfully !</font></CENTER>
    <%
    } else {
    %>
    <BR><BR><BR><BR></CENTER><font color=Red Size=4 face='Verdana'>Please change atleast one grade to proceed! </font></CENTER>
    <%            }
        //-----------------------------
        //-- Enable Security Page Level
        //-----------------------------
        }//3
        else {
    %>
    <br>
    <font color=red>
        <h3>	<br><img src='../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
        <P>	This page is not authorized/available for you.
        <br>For assistance, contact your network support team.
    </font>	<br>	<br>	<br>	<br>
    <%                }
            //-----------------------------
            } //2
            else {
                out.print("<br><img src='../Images/Error1.jpg'>");
                out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
            }
        } //1
        catch (Exception e) {
        }
    %>
</body>
</html>