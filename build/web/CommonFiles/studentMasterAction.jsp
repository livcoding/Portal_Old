<%--
    Document   : studentMaster
    Created on : 23 Sep, 2015, 11:40:40 AM
    Author     : nipun.gupta
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
       
        <script>
          if(window.history.forward(1) != null)
window.history.forward(1);
        </script>

    </head>
    <body aLink=#ff00ff bgcolor="#fce9c5" rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
        <%
            CommonComboData ccd=new CommonComboData();
            //GlobalFunctions gb =new GlobalFunctions();
            DBHandler db = new DBHandler();
            String mMemberID = "", mMemberType = "", mMemberName = "", mMemberCode = "";
            String mDMemberCode = "", mDMemberType = "", mDept = "", mDesg = "", mInst = "", minst = "", mDMemberID = "";
            String qry = "", mEnOrNm = "", x = "", cInst = "", mCheck = "",institute="",mStr="";
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
                qry = "Select WEBKIOSK.ShowLink('387','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";
                RsChk1 = db.getRowset(qry);
                if (RsChk1.next() && RsChk1.getString("SL").equals("Y")) {
                    String [] mProg=request.getParameterValues("INSTITUTECODE");
		System.out.println("+++++++++"+mProg.length);

        %>

        <form name="studentMasterAction">
            <input type="hidden" name="x" id="x" >
         






                <div id="printable">
                    <div id="total">
                    </div>
                    <table class="sort-table" id="TblStdView" rules='ALL' style="width:auto;" cellSpacing=0 cellPadding=0  align=center border=1>

                        <thead id="gridhead">


                        </thead>
                        <tbody id="gridbody" style="width:auto;">

                        </tbody>
                    </table></div>

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