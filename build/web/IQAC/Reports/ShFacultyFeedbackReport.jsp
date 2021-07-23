<%--
    Document   : NonTechingStaffFeedback
    Created on : May 27, 2015, 10:36:01 AM
    Author     : Gyanendra.Bhatt
--%>
<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%
        DBHandler db = new DBHandler(); 
        ResultSet rs = null;
        ResultSet rs1 = null;
        GlobalFunctions gb = new GlobalFunctions();
        int mSno = 0, TotInboxItem = 0;
        String qry = "", qry1 = "", mDepartmentCode = "", mDesigcode = "", mTime1 = "";
        String mColor = "Green", mComp = "", TRCOLOR = "White", mWebEmail = "";
        String mMemberID = "", mDMemberID = "", mMemberType = "", mDMemberType = "";
        String mMemberCode = "", mDMemberCode = "", mMemberName = "";
        String mInst = "", myFlag = "0";
        String mFactType = "", mDesig = "", mDepartment = "";
        int mChk = 0;
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

        if (session.getAttribute("Designation") == null) {
            mDesig = "";
        } else {
            mDesig = session.getAttribute("Designation").toString().trim();
        }
        if (session.getAttribute("DesignationCode") == null) {
            mDesigcode = "";
        } else {
            mDesigcode = session.getAttribute("DesignationCode").toString().trim();
        }

        if (session.getAttribute("DepartmentCode") == null) {
            mDepartmentCode = "";
        } else {
            mDepartmentCode = session.getAttribute("DepartmentCode").toString().trim();
        }
        if (session.getAttribute("Department") == null) {
            mDepartment = "";
        } else {
            mDepartment = session.getAttribute("Department").toString().trim();
        }



        String mTime = "";
        qry = "Select to_char(Sysdate,'DD-Mon-yyyy HH:MI:SS PM') mTime,to_char(Sysdate,'DD-Mon-yyyy') mTime1 from Dual";
        rs = db.getRowset(qry);
        if (rs.next()) {
            mTime = rs.getString("mTime");
            mTime1 = rs.getString("mTime1");
        } else {
            mTime = "";
            mTime1 = "";
        }
        String mHead = "";

        if (session.getAttribute("PageHeading") != null && !session.getAttribute("PageHeading").equals("")) {
            mHead = session.getAttribute("PageHeading").toString().trim();
        } else {
            mHead = "JIIT ";
        }

        try {

            if (!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) {
                OLTEncryption enc = new OLTEncryption();
                mDMemberID = enc.decode(mMemberID);
                mDMemberCode = enc.decode(mMemberCode);
                mDMemberType = enc.decode(mMemberType);
                if (mDMemberType.equals("E")) {
                    mFactType = "I";
                } else {
                    mFactType = "E";
                }
                String mChkMemID = enc.decode(session.getAttribute("MemberID").toString().trim());
                String mChkMType = enc.decode(session.getAttribute("MemberType").toString().trim());
                String mIPAddress = session.getAttribute("IPADD").toString().trim();
                String mRole = enc.decode(session.getAttribute("ROLENAME").toString().trim());
                ResultSet RsChk = null;
             //   out.print(mDMemberID + "@@@@@" + mComp + "###" + mInst + "$$$$$" + mDepartment + "^^^^" + mDesig + "%%%%%" + mDepartmentCode + "****" + mDesigcode);

%>
<!DOCTYPE HTML>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../css/Style.css">
        <link rel="stylesheet" href="../css/jquery-ui.css"/>
        <style type="text/css">
            html, body{ margin: 0; border: 0 none; padding: 0;    }
            html, body, #wrapper, #left, #right {  margin-top: auto }
            #wrapper { margin: 0 auto;  width: 960px;  }
            #mastergrid  tr:nth-child(even) {background: #F8F8F8;cursor:pointer;padding:8px; border:#999 1px solid; }
            #mastergrid tr:nth-child(odd) {background: 	#EBF5FF;cursor:pointer;padding:8px; border:#999 1px solid; }
            #mastergrid td { padding:5px; border:#999 1px solid; }
            #mastergrid1 th { padding:5px; border:#999 1px solid; }
            #mastergrid :hover, .applicantclass:focus, .applicantclass:active{background: skyblue !important;}

        </style>
        <script src="../js/jquery/jquery-1.10.2.js"></script>
        <script src="../js/jquery/jquery-ui.js"></script>
        <script src="../js/jquery/yattable.js"></script>
        <script src="../js/IQTest/jQuery.print.js"></script>
        <script src="../js/IQTest/IQACReport.js"></script>

    </head>


    <body>
        <!-- Above Is  to handle  the session values   -->
        <div id="windowheader" class="ui-widget-header ui-corner-all div" style="height:95px;" >
            <input type="hidden" name="SessionComapany" id="sessioncompany" value="<%=mComp%>"/>
            <input type="hidden" name="SessionInstitute" id="sessioninstitute" value="<%=mInst%>"/>
            <input type="hidden" name="SessionLoginid" id="sessionloginid" value="<%=mDMemberID%>"/>
            <input type="hidden" name="SessionDesigCode" id="sessiondesigcode" value="<%=mDesigcode%>"/>
            <input type="hidden" name="SessionDepartCode" id="sessiondepartcode" value="<%=mDepartmentCode%>"/>
            <input type="hidden" name="SessionDepartment" id="sessiondepartment" value="<%=mDepartment%>"/>


            <FONT SIZE="2" COLOR="black" style="margin-left:70%;">
            Form:QA-SR-3</FONT><br>
            <B><FONT SIZE="4" COLOR="black" style="margin-left:33%;" >Institute Academic Quality Assurance Cell</FONT></B>
            <FONT SIZE="2" COLOR="black" style="margin-left:10%;" >Frequency-Every Year</FONT><br>
            <B><FONT SIZE="4" COLOR="black" style="margin-left:34%;">Stakeholder Relationship</FONT><FONT SIZE="2" COLOR="black" style="margin-left:20%">Date-<%=mTime1%></FONT></B><br>
            <B><FONT SIZE="4" COLOR="black" style="margin-left:5%;" >Faculty Feedback Transaction Report</FONT></B>
         </div>
        <br>   <br>
            <div style="width:80%; padding: 10px ;border: .3em solid;border-radius: 25px;margin-left:10%;margin-right:10%;" >
            <table  id="commonmasterid" style="text-align: left;font-size: 18px; border:1px;width:100%">
         
                <tr>
                     <td width="10%" align="right" nowrap>Institute Code<span class="req"> *</span> :</td>
                    <td width="40%">
                        <select  name='Institute' id='Institute'  class='combo' style='width:100%'  title='Institute'>
                            <option value="">Select Institute</option>
                            <%qry="select distinct institutecode,institutename from institutemaster a,AP#FACULTYSHFEEDBACKHEADER b where a.institutecode=b.INSTITUTEID ";
                            rs=db.getRowset(qry);
                            while(rs.next())
                            {
                            %>
                            <option value="<%=rs.getString("institutecode")%>"><%=rs.getString("institutename")%></option>
                            <%
                            }


                            %>
                        </select>
                    </td>
                     <td width="10%" align="right" nowrap>Feedback Id<span class="req"> *</span> :</td>
                    <td width="40%">
                        <select  name='feedbackid' id='feedbackid'  class='combo' style='width:100%'  title='Feedbackid'>
                            <option value="">Select Feedback Id</option>
                        </select>
                    </td>
                    </tr>
                    <tr>
                     <td width="10%" align="right" nowrap>Acadmic Year Id<span class="req"> *</span> :</td>
                    <td width="40%">
                         <select  name='acdyear' id='acdyear'  class='combo' style='width:100%'  title='Acadmic Year'>
                            <option value="">Select Acadmic Year</option>
                          </select>
                    </td>
                 </tr>
                <tr><td style="text-align: right;" width="100%" colspan="4" nowrap>
                        <button name="submitbutton_ShFaculty" id="submitbutton_ShFaculty"  class="button" style="width:120px;height:25px;margin-left:140px;">Generate Report</button>
                    </td>
                </tr>
         </table>
        </div>
        <br>
        <div id="reportpart"></div>
    </body>
</html>
<%} else {
                out.print("<br><img src='../../Images/Error1.jpg'>");
                out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
            }
        } catch (Exception e) {
        }%>