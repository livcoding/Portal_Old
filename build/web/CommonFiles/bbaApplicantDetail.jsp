<%-- 
    Document   : bbaApplicantDetail
    Created on : 22 Jul, 2020, 2:28:36 PM
    Author     : anoop.tiwari
--%>

<!DOCTYPE html>
<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %>
<%@page import="jilit.db.CommonComboData"%>
<%
    String mHead = "", mInstCode = "";
    String mCandCode = "", MName = "";
    String mCandName = "";
    String URL = "";

    if (session.getAttribute("PageHeading") != null && !session.getAttribute("PageHeading").equals("")) {
        mHead = session.getAttribute("PageHeading").toString().trim();
    } else {
        mHead = "JIIT ";
    }
%>
<HTML>
    <head>
        <style type="text/css" media="print">

            @media print
            {
                @page { size: landscape; }
                #non-printable { display: none; }
                #printable {
                    display: block;
                    width: 100%;
                    height: 100%;
                }
            }
        </style>
        <script type="text/javascript" src="js/sortabletable.js"></script>
        <script type="text/javascript" src="js/json2.js"></script>
        <link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

        <TITLE>JIIT </TITLE>
        <script src="../IQAC/js/jquery/jquery-1.10.2.js"></script>
        <script src="../IQAC/js/jquery/jquery-ui.js"></script>
        <script src="../IQAC/js/jquery/yattable.js"></script>
        <script src="../IQAC/js/jquery/numeric-1.0.js"></script>
        <script src="../IQAC/js/IQTest/CommonServiceJs.js"></script>
        <script src="../IQAC/js/IQTest/ComboJs.js"></script>
        <script src="js/bbaApplicantDetailJS.js"></script>
        <script>
            $(document).ready(function() {

                getCommonMasterTable();
            });
        </script>

    </head>
    <body aLink=#ff00ff bgcolor="#fce9c5" rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
        <%
            CommonComboData ccd = new CommonComboData();
            //GlobalFunctions gb =new GlobalFunctions();
            DBHandler db = new DBHandler();
            String mMemberID = "", mMemberType = "", mMemberName = "", mMemberCode = "";
            String mDMemberCode = "", mDMemberType = "", mDept = "", mDesg = "", mInst = "", minst = "", mDMemberID = "";
            String qry = "", mEnOrNm = "", x = "", cInst = "", mCheck = "", institute = "";
            int msno = 0;
            ResultSet rs = null;
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

            if (session.getAttribute("InstituteCode") == null) {
                mInstCode = "JIIT";
            } else {
                mInstCode = session.getAttribute("InstituteCode").toString().trim();
            }
            session.setAttribute("INSCODE", " ");
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
                qry = "Select WEBKIOSK.ShowLink('390','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";
                RsChk1 = db.getRowset(qry);
                if (RsChk1.next() && RsChk1.getString("SL").equals("Y")) {

        %>

        <form name="employeeMaster">
            <div id="non-printable">
                <table cellpadding=2 cellspacing=2 align=center rules=groups border=1 style="table-layout:fixed;">
                    <tr><td align="center" colspan='4' bgcolor='#c00000'><font color=white><b>BBA Applicant Detail</b></font></td></tr>
                    <tr>
                        <td style="text-align: right">Admission Year<span class="req"><font color='red'> *</font></span> :</td><td style="text-align: left"><select  name='admissionYear' id='admissionYear'  class='combo' style=''  title='Admission Year'><%=ccd.commonJspCombo("{\"comboId\":\"bbaadmissionYearCombo\"}")%></select></td>
                        <td style="text-align: right">Application Type<span class="req"><font color='red'> *</font></span>:</td><td style="text-align: left">
                            <select  name='applicationType' id='applicationType'  class='combo' style=''  title='Application Type'>
                                <option value='0'>Select Application Type</option>
                                <option value='ALL'>All</option>
                                <option value='ON'>Online</option>
                                <option value='OF'>Offline</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Sort By<span class="req"><font color='red'> *</font></span>:</td><td style="text-align: left">
                            <select  name='sortBy' id='sortBy'  class='combo' style=''  title='Sort By'>
                                <option value='0'>Select Sort By</option>
                                <option value='ASN'>Application SL No</option>
                                <option value='AN'>Application No</option>
                                <option value='SN'>Student Name</option>
                            </select>
                        </td>
                       <td colspan="2" align="right"><input type="button" id="submitReport" value="Submit"  style="margin-right: 35%" onclick="generateReportBBAApplicantDetail()"></td>
                    </tr>
                </table>
            </div>
            <div id="printable">
                <div id="total">
                </div>
                <table class="sort-table" id="TblStdView" rules='ALL' style="width:auto;" cellSpacing=0 cellPadding=0  align=center border=1>
                    <thead id="gridhead">
                    </thead>
                    <tbody id="gridbody" style="width:auto;">
                    </tbody>
                </table>
            </div>
        </form>



        <%                //-----------------------------
            //-- Enable Security Page Level
            //-----------------------------
        } else {
        %>
        <br>
        <font color=red>
        <h3>	<br><img src='../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
        <P>	This page is not authorized/available for you.
            <br>For assistance, contact your network support team.
            </font>	<br>	<br>	<br>	<br>
            <%           }
                    //-----------------------------




                } else {
                    out.print("<br><img src='Images/Error1.jpg'>");
                    out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='index.jsp'>Login</a> to continue</font> <br>");
                }

            %>
    </body>
</html>