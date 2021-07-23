<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>

<html>
    <head>
        <script language="javascript">

        </script>

        <%
        String StudentName = "", EnrollmentNo = "", qry = "";
        ResultSet rs = null, rs1 = null;
        DBHandler db = new DBHandler();
        String mStudID = "", mInst = "";

        String mBRANCHCODE = "", mcaddress1 = "", mcaddress2 = "", mcaddress3 = "", mcDistrict = "", mcPIN = "", mcCity = "";
        String mcState = "", mpaddress1 = "", mpaddress2 = "", mpaddress3 = "", mpDistrict = "", mpPIN = "", mpCity = "";
        String mpState = "", mENROLLMENTNO = "", mFATHERNAME = "";

        String mStudentTel = "", DOB = "", mGender = "";

        String mSCellNo = "", mPCellNo = "", mSTelNo = "", mPTelNo = "", mSEmail = "", mPEmail = "", qry1 = "";
        ResultSet rs2 = null;

        String mMemberID = "";
        String mDMemberID = "";
        String mMemberType = "";
        String mDMemberType = "";
        String mMemberCode = "";
        String mDMemberCode = "", mtime1 = "", mtime2 = "";
        String mMemberName = "", mComp = "", StudentID = "";

        String Remark = "", ResultDetail = "", DateReceive = "", InvestDetail = "", InvestYN = "", Treatment = "",
                Suggest = "", CompDetail = "", ResultYN = "", CompDate = "", CompNo = "", RefNo = "", FollowAdvice = "";


        if (request.getParameter("StudentID") == null) {
            StudentID = "";
        } else {
            StudentID = request.getParameter("StudentID");
        }

        String CompaNo = "", RefeNo = "";

        if (request.getParameter("CompaNo") == null) {
            CompaNo = "";
        } else {
            CompaNo = request.getParameter("CompaNo");
        }

        if (request.getParameter("RefeNo") == null) {
            RefeNo = "";
        } else {
            RefeNo = request.getParameter("RefeNo");
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

        String mHead = "";
        if (session.getAttribute("PageHeading") != null && !session.getAttribute("PageHeading").equals("")) {
            mHead = session.getAttribute("PageHeading").toString().trim();
        } else {
            mHead = " ";
        }



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

                
                qry = "Select WEBKIOSK.ShowLink('260','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";
                RsChk = db.getRowset(qry);
                if (RsChk.next() && RsChk.getString("SL").equals("Y")) {

                    String mStudName = "", mRemark = "", mResultDetail = "", mDateReceive = "", mInvestDetail = "", mInvestYN = "", mTreatment = "",
                            mSuggest = "", mCompDetail = "", mResultYN = "", mCompDate = "", mCompNo = "", mRefNo = "", mFollowAdvice = "";



                    qry1 = "select distinct  studentid,enrollmentno,Studentname ,INSTITUTECODE " +
                            " from studentmaster where StudentID='" + StudentID + "' " +
                            " and nvl(deactive,'N')='N' ";
//out.print(qry1);
                    rs1 = db.getRowset(qry1);
                    if (rs1.next()) {
                        mStudName = rs1.getString("Studentname");
                        EnrollmentNo = rs1.getString("enrollmentno");
                        mInst = rs1.getString("INSTITUTECODE");
                    }

                    qry = "SELECT TO_CHAR(COMPLAINTDATE,'DD-MM-YYYY')COMPLAINTDATE, NVL(COMPLAINTDESC,' ')COMPLAINTDESC," +
                            " COMPLAINTNO, FOLLOWADVICE, " +
                            " INVESTIGATIONDESC, INVESTIGATIONRERUIRED, nvl(TO_CHAR(RECEIVEDDATE,'DD-MM-YYYY'),' ')RECEIVEDDATE," +
                            " REFNO, nvl(REMARKS,' ')REMARKS, nvl(RESULTDESC,' ')RESULTDESC,    " +
                            " RESULTRECEIVED, STUDENTID, SUGGESTION,    TREATMENTDESC FROM STUDENTTREATMENTDETAIL " +
                            " WHERE  STUDENTID='" + StudentID + "'  and  REFNO='" + RefeNo + "' AND COMPLAINTNO='" + CompaNo + "'  ";
//out.print(qry);
                    rs = db.getRowset(qry);
                    if (rs.next()) {
                        mRemark = rs.getString("REMARKS");
                        mResultDetail = rs.getString("RESULTDESC");
                        mDateReceive = rs.getString("RECEIVEDDATE");
                        mInvestDetail = rs.getString("INVESTIGATIONDESC");
                        mInvestYN = rs.getString("INVESTIGATIONRERUIRED");
                        mTreatment = rs.getString("TREATMENTDESC");
                        mSuggest = rs.getString("SUGGESTION");
                        mCompDetail = rs.getString("COMPLAINTDESC");
                        mResultYN = rs.getString("RESULTRECEIVED");
                        mCompDate = rs.getString("COMPLAINTDATE");
                        mCompNo = rs.getString("COMPLAINTNO");
                        mRefNo = rs.getString("REFNO");
                        mFollowAdvice = rs.getString("FOLLOWADVICE");

                    }

                    String mCurDate = "";

                    qry = "select to_char(sysdate,'dd-mm-yyyy')currdate from dual ";
                    rs1 = db.getRowset(qry);
                    if (rs1.next()) {
                        mCurDate = rs1.getString("currdate");
                    }

                    if (mCompDate.equals("") || mCompDate == null) {
                        mCompDate = mCurDate;
                    } else {
                        mCompDate = mCompDate;
                    }


                    if (mFollowAdvice.equals("Y")) {
                        mFollowAdvice = "checked";
                    } else {
                        mFollowAdvice = "";
                    }

                    String mInvestSel = "", mInvestNSel = "", mSel = "";

                    if (mInvestYN.equals("Y")) {
                        mInvestSel = "Selected";
                    } else if (mInvestYN.equals("N")) {
                        mInvestNSel = "Selected";
                    } else {
                        mSel = "Selected";
                    }




                    String mResultYSel = "", mResultNSel = "", mResultSel = "";

                    if (mResultYN.equals("Y")) {
                        mResultYSel = "Selected";
                    } else if (mResultYN.equals("N")) {
                        mResultNSel = "Selected";
                    } else {
                        mResultSel = "Selected";
                    }




                    String mRef1 = "", mRef = "", mcheck1 = "", mcheck = "";

                    if (request.getParameter("ChkRef") == "2") {
                        mcheck = "checked";
                    } else {
                        mcheck1 = "checked";
                    }


        %>
        <TITLE>#### <%=mHead%>  </TITLE>
        <link type="text/css" rel="StyleSheet" href="css/style.css" />

    </head>
    <BODY STYLE="width:60px;height:80px"  vLink=#00000b link=#00000b bgcolor="#fce9c5" leftMargin=1 topMargin=0 marginheight="0" marginwidth="0" >
        <link  rel="stylesheet" type="text/css" href="css/style.css">
        <div id="header" align="center">
            <table align=center border=0 cellpadding=0 cellspacing=0>
                <tr><td align=center>
                        <h1>Complaint Detail</h1>

                </td></tr>
            </table>
        </div>
        <form name="frm1" method=post >
            <input type="hidden" name="x" id="x" >
            <input type="hidden" name="StudentID" id="StudentID" value="<%=StudentID%>">
                <input type="hidden" name="EnrollmentNo" id="EnrollmentNo" value="<%=EnrollmentNo%>">
                    <input type="hidden" name="InstCode" id="InstCode" value="<%=mInst%>">
            <br>
            <table border=1  rules=none align=center  width="70%" topmargin=0 cellspacing=0 cellpadding=2 borderColor="#D98242" >
                <tr>
                    <td class="labelcell" align="center">
                    Student Name : <%=mStudName%> &nbsp; &nbsp; &nbsp; Enrollment No : <%=EnrollmentNo%>

                </tr>
            </table>
            <br>
            <table border=1  rules=none align=center  width="70%" topmargin=0 cellspacing=0 cellpadding=5 borderColor="#D98242" >
                <tr>

                    <td class="labelcell">
                        <input type="radio" name="ChkRef" id="ChkRef" value="1" <%=mcheck1%>  >&nbsp;Ref.No <b>REF-</b>
                        <input type="text" value="<%=mRefNo%>" id="RefNo" name="RefNo" size="15" maxlength="50" />
                        OR
                        <input type="radio" name="ChkRef" id="ChkRef" value="2" <%=mcheck%> >&nbsp;Ref.No

                        <%
                    qry = "select distinct refno from   STUDENTTREATMENTDETAIL " +
                            " WHERE  STUDENTID='" + StudentID + "'  ";
                    //   out.print(qry);
                    rs = db.getRowset(qry);
                        %>
                        <select name="ChkRefCom" id="ChkRefCom" >
                            <OPTION selected Value ='N'>-Select-</option>
                            <%


                    if (request.getParameter("x") == null) {
                        while (rs.next()) {
                            mRef1 = rs.getString("refno").toString().trim();
                            if (mRef.equals("")) {
                                mRef = mRef1;
                            %>
                            <OPTION   Value="<%=mRef1%>"><%=rs.getString("refno")%></option>
                            <%
                             } else {
                            %>
                            <OPTION Value="<%=mRef1%>"><%=rs.getString("refno")%></option>
                            <%
                             }
                         } // closing of while
                     } // closing of if
                     else {
                         while (rs.next()) {
                             mRef1 = rs.getString("refno").toString().trim();
                             if (mRef1.equals(request.getParameter("ChkRefCom").toString().trim())) {
                                 mRef = mRef1;
                            %>
                            <OPTION selected Value="<%=mRef1%>"><%=rs.getString("refno")%></option>
                            <%
                            } else {
                            %>
                            <OPTION Value ="<%=mRef1%>"><%=rs.getString("refno")%></option>
                            <%
                            }
                        } // closing of while
                    } // closing of else
%>
                        </select>


                    </td>

                    <!--   <td class="labelcell" >
        &nbsp;Complaint No.<input type="text" value="<%=mCompNo%>" id="CompNo" name="CompNo" maxlength="3" size="10"/></td>
                    -->
                    <td class="labelcell">
                        &nbsp;Complaint Date <input type="text" value="<%=mCompDate%>" id="CompDate" size="10" name="CompDate"/>
                        <font size="1" > (dd-mm-yyyy)</font>
                    </td>
                </tr>
            </table>
            <br>
            <table border=1  rules=none align=center width="70%"
                   topmargin=0 cellspacing=0 cellpadding=2 borderColor="#D98242" >
                <tr>

                    <td class="labelcell">

                        Complaint:
                    </td>
                    <td>
                        &nbsp;&nbsp;<textarea id="CompDetail" name="CompDetail"  rows="" cols="35"    ><%=mCompDetail%> </textarea>
                    </td>
                </tr>
                <tr>
                    <td class="labelcell">
                        Treatment:
                    </td>
                    <td>
                        &nbsp;&nbsp;<textarea id="Treatment" name="Treatment" rows="" cols="35" ><%=mTreatment%></textarea>
                    </td>
                </tr>
                <tr>
                    <td class="labelcell">
                        Suggestion  &nbsp;&nbsp;&nbsp;&nbsp;      Follow Advice
                        <input type="checkbox" value="Y" name="FollowAdvice"  <%=mFollowAdvice%>  id="FollowAdvice"> Yes
                    </td>
                    <td>
                        &nbsp;&nbsp;<textarea id="Suggest" name="Suggest" rows="" cols="35"><%=mSuggest%></textarea>
                    </td>
                </tr>
                <tr>
                    <td class="labelcell">
                        Investigation Required  &nbsp;
                        <select  name="InvestYN" id="InvestYN" >
                            <option <%=mSel%>  value='S'><-Select-></option>
                            <option <%=mInvestSel%> value='Y'>YES</option>
                            <option <%=mInvestNSel%> value='N'>NO</option>
                        </select> Yes
                    </td>

                    <td>&nbsp;&nbsp;<textarea id="InvestDetail" name="InvestDetail" rows="" cols="35"><%=mInvestDetail%></textarea>
                    </td>
                </tr>



            </table>
            <br>



            <table width="70%" border=1  rules=groups align=center
                   topmargin=0 cellspacing=0 cellpadding=2 borderColor="#D98242" >
                <tr>

                    <td class="labelcell" colspan="4">
                        <h2><center>Investigation Result Detail</center></h2>
                    </td>
                </tr>
                <tr>
                    <td class="labelcell">
                    Result Received &nbsp;</td>
                    <td><select  name="ResultYN" id="ResultYN" >
                            <option <%=mResultSel%> value='S'>-Select-</option>
                            <option <%=mResultYSel%> value='Y'>YES</option>
                        <option <%=mResultNSel%> value='N'>NO</option></select>
                    </td>
                    <td class="labelcell" align="right">
                        Date of Receive&nbsp;<font size="1" >(dd-mm-yyyy)</font>
                    </td>
                    <td >
                        <input type="text" id="DateReceive" name="DateReceive" size="8" value="<%=mDateReceive%>">
                    </td>
                </tr>
                <tr>
                    <td class="labelcell">
                    Result Detail </td>
                    <td colspan="4">
                        <input type="text" id="ResultDetail" name="ResultDetail"
                               style="width:490px" value="<%=mResultDetail%>" maxlength="160" />
                    </td>
                </tr>
            </table>
            <BR>
            <table width="70%" border=1  rules="groups" align=center   topmargin=0 cellspacing=0 cellpadding=2 borderColor="#D98242">
                <tr>
                    <td class="labelcell" >
                    Remark  </td>
                    <td  >&nbsp;   &nbsp; &nbsp;  &nbsp;   &nbsp;<textarea id="Remark" name="Remark" rows="" cols="50" ><%=mRemark%></textarea>
                    </td>
                </tr>
            </table>
            <br>
            <table width="70%" border=0  rules=rows align=center   topmargin=0 cellspacing=0 cellpadding=2 borderColor="#D98242">
                <tr> <td colspan="5" align="center"><input type=Submit  border= "3px" name="submit" id="submit"
                                                                   value="&nbsp; Save &nbsp;" onClick="return Validate();" >
                </td></tr>
            </table>
        </form>
        <form name="frm2">
            <%
                    if (request.getParameter("x") != null) {


                        //out.print(request.getParameter("ChkRef")+"LLLL");


                        if (request.getParameter("RefNo") == null || request.getParameter("RefNo") == "") {
                            RefNo = request.getParameter("ChkRefCom");
                        } else {
                            RefNo = request.getParameter("RefNo");
                        }


                        FollowAdvice = request.getParameter("FollowAdvice");



                        qry1 = "select count(refno)dd from studenttreatmentdetail a where a.REFNO='" + RefNo + "'" +
                                " and STUDENTID='" + StudentID + "' ";
                        // out.print(qry1);
                        rs = db.getRowset(qry1);
                        if (rs.next()) {
                            CompNo = rs.getString("dd");
                        }

                        CompNo = CompNo + 1;


                        CompDate = request.getParameter("CompDate");
                        Remark = request.getParameter("Remark");
                        ResultDetail = request.getParameter("ResultDetail");
                        DateReceive = request.getParameter("DateReceive");
                        ResultYN = request.getParameter("ResultYN");
                        InvestDetail = request.getParameter("InvestDetail");
                        InvestYN = request.getParameter("InvestYN");
                        Suggest = request.getParameter("Suggest");
                        Treatment = request.getParameter("Treatment");
                        CompDetail = request.getParameter("CompDetail");

                        String qryi = "";
                        int mflag=0;
                        qry = "SELECT 'Y' ENTRYDATE FROM STUDENTTREATMENTDETAIL WHERE STUDENTID='" + StudentID + "' AND" +
                                " REFNO ='" + RefNo + "' AND  COMPLAINTNO='" + CompNo + "' ";
                        //    out.print(qry);
                        rs = db.getRowset(qry);
                        if (!rs.next()) {
                            qryi = "INSERT INTO STUDENTTREATMENTDETAIL (" +
                                    " STUDENTID, REFNO, COMPLAINTNO, " +
                                    " COMPLAINTDATE, COMPLAINTDESC, TREATMENTDESC, " +
                                    " SUGGESTION, FOLLOWADVICE, INVESTIGATIONRERUIRED, " +
                                    " INVESTIGATIONDESC, RESULTRECEIVED, RECEIVEDDATE, " +
                                    " RESULTDESC, REMARKS, ENTRYBY, " +
                                    " ENTRYDATE) " +
                                    " VALUES ( '" + StudentID + "' , '" + RefNo + "'  ,'" + CompNo + "'  , to_date('" + CompDate + "','dd-mm-yyyy') , " +
                                    " '" + CompDetail + "' , '" + Treatment + "' , '" + Suggest + "' , '" + FollowAdvice + "' , " +
                                    " '" + InvestYN + "' , '" + InvestDetail + "' , '" + ResultYN + "' , to_date('" + DateReceive + "','dd-mm-yyyy') , " +
                                    " '" + ResultDetail + "' ,'" + Remark + "' ,'" + mChkMemID + "' ,sysdate )";
                            //  out.print(qryi);
                            int n = db.insertRow(qryi);
                            if (n > 0) {
                                mflag=1;
                                out.print("<center> <font face=verdana color=green size=2> Record Saved Successfully... </font> </center>");

                            } else {
                                out.print("<center> <font face=verdana color=red size=2> Error in Saving... </font> </center>");
                            }
                        } else {

                            qryi = "UPDATE STUDENTTREATMENTDETAIL " +
                                    "SET    COMPLAINTDATE         = to_date('" + CompDate + "','dd-mm-yyyy') ," +
                                    "       COMPLAINTDESC         = '" + CompDetail + "'  ," +
                                    "       ENTRYBY               = '" + mChkMemID + "'," +
                                    "       ENTRYDATE             = sysdate," +
                                    "       FOLLOWADVICE          =  '" + FollowAdvice + "' ," +
                                    "       INVESTIGATIONDESC     = '" + InvestDetail + "' ," +
                                    "       INVESTIGATIONRERUIRED = '" + InvestYN + "'," +
                                    "       RECEIVEDDATE          = to_date('" + DateReceive + "','dd-mm-yyyy')  ," +
                                    "       REMARKS               = '" + Remark + "' ," +
                                    "       RESULTDESC            = '" + ResultDetail + "' ," +
                                    "       RESULTRECEIVED        = '" + ResultYN + "' ," +
                                    "       SUGGESTION            =  '" + Suggest + "'   ," +
                                    "       TREATMENTDESC         = '" + Treatment + "' " +
                                    "WHERE  STUDENTID             = '" + StudentID + "'   " +
                                    "AND    REFNO                 = '" + RefNo + "' " +
                                    "AND    COMPLAINTNO           = '" + CompNo + "' ";
                            int x = db.update(qryi);
                            if (x > 0) {
                                 mflag=1;
                                out.print("<center> <font face=verdana color=green size=2> Record Updated Successfully... </font> </center>");

                            } else {
                                out.print("<center> <font face=verdana color=red size=2> Error in Saving... </font> </center>");
                            }

                        }

                        if(mflag==1)
                            {

 //InstCode="+mIC+"&Exam="+mEC+"&Subject="+mSC+"&Event="+mEvent+"&Section="+mSecBranch+"&EXAMTYPECODE="+mExamTypeCode+"&x=1&y=1");

              response.sendRedirect("MedicalDetail.jsp?EnrollmentNo="+EnrollmentNo+"&InstCode="+mInst+"&x=1");
              
                            }


                    }
            %>
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
            //out.print("error");
        }
        %>
    </body>
</html>




