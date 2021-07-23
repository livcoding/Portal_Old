<%-- 
    Document   : EmployeePFTDSReport
    Created on : May 24, 2011, 12:46:01 PM
    Author     : ankur.verma
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
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
        <TITLE>#### <%=mHead%> [ Tax Decleration Form/Screen] </TITLE>
      

        <script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
        <script type="text/javascript" src="js/sortabletable.js"></script>
        <link type="text/css" rel="StyleSheet" href="css/sortabletable.css"/>
        <script language="JavaScript" type ="text/javascript" src="../PersonalInfo/js/datetimepicker.js"></script>
        <script>
            if(window.history.forward(1) != null)
                window.history.forward(1);
        </script>

        <script language=javascript>
            <!--
            function RefreshContents()
            {
                document.frm.x.value='ddd';
                document.frm.submit();
            }
            //-->
        </SCRIPT>


    </head>

    <body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
        <%
        GlobalFunctions gb = new GlobalFunctions();
        DBHandler db = new DBHandler();
        String mMemberID = "", mMemberType = "", mMemberName = "", mMemberCode = "", mFinYearCode = "";
        String mDMemberCode = "", mDDMemberType = "", mDept = "", mDesg = "", mInst = "", mDMemberID = "";
        String qry = "", qry1 = "", mType = "", mComp = "";
        int mRights;
        ResultSet rst = null, rs = null, rs1 = null;
        String msmv = "", msm1 = "", msm2 = "", msm = "", mSmv = "";
        String mFaculty = "", mFacultyName = "";

        String qrya = "", qry2 = "";
        ResultSet rsa = null;
        //   out.print(mFromPeriod+"sdfsfsf"+mToPeriod+"mTypeDed"+mTypeDed);
        String mOpenDT = "", mdate = "";
        double mSadd = 0, mSumfirst = 0;

        double sumAmount = 0, sumamt = 0, sumAmount1 = 0, mTotalopbalance = 0;
        String qryd = "";



        if (session.getAttribute("Designation") == null) {
            mDesg = "";
        } else {
            mDesg = session.getAttribute("Designation").toString().trim();
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

        if (session.getAttribute("DepartmentCode") == null) {
            mDept = "";
        } else {
            mDept = session.getAttribute("DepartmentCode").toString().trim();
        }

        if (request.getParameter("Type") == null) {
            mType = "";
        } else {
            mType = request.getParameter("Type").toString().trim();
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


        OLTEncryption enc = new OLTEncryption();
        if (!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) {
            mDMemberCode = enc.decode(mMemberCode);
            mDDMemberType = enc.decode(mMemberType);
            mDMemberID = enc.decode(mMemberID);
            String mChkMemID = enc.decode(session.getAttribute("MemberID").toString().trim());
            String mChkMType = enc.decode(session.getAttribute("MemberType").toString().trim());
            String mIPAddress = session.getAttribute("IPADD").toString().trim();
            String mRole = enc.decode(session.getAttribute("ROLENAME").toString().trim());
            ResultSet RsChk1 = null;
            ResultSet r = null;
            String mFromPeriod = "", mToPeriod = "", mFinYear = "", mTypeDed = "", mEmpID = "";

            // ------------------------------
            // out.print(qry);
            // ------------------------------
            // -- Enable Security Page Level
            // ------------------------------

            mRights = 257;


            qry = "Select WEBKIOSK.ShowLink('" + mRights + "','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";
            RsChk1 = db.getRowset(qry);

            //out.print(qry);

            if (RsChk1.next() && RsChk1.getString("SL").equals("Y")) {
        %>
        <Table ALIGN=CENTER BottomMargin=0  Topmargin=0>
            <tr><TD align=middle>
                    <font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana"><b><u>Employee PF/TDS Report</u> </b></font>
                </td>
            </tr>
        </table>
        <form name="frm" method=post>
            <table  bordercolor=maroon cellpadding=0 cellspacing=0  align=center rules=groups  border=0  >
                <input id="x" name="x" type=hidden>

                <tr>
                    <td >
                        <font face=arial size=2 color="BLUE" ><STRONG> <%=mMemberName.toUpperCase()%> (<%=mDMemberCode%>) </STRONG></FONT>
                    </td>
                    <td>&nbsp; &nbsp; &nbsp; &nbsp;
                        <font  face=arial size=2><STRONG>Designation
                    </TD>
                    <TD>
                        <font face=arial size=2 color="BLUE"><STRONG>: <%=GlobalFunctions.toTtitleCase(mDesg)%> </STRONG></FONT>

                    </td>

                </tr>
            </table>
            <hr>
            <table  bordercolor=maroon cellpadding=5 cellspacing=0  align=center rules=groups  border=1  >
                <tr>


                    <td nowrap><font color=black face=arial size=2><STRONG>Faculty&nbsp;</STRONG>
                        <%


            qry = "select distinct nvl(employeeid,' ')Faculty, nvl(employeename,' ')FacultyName from " +
                    " EmployeeMaster where ";
            qry = qry + "  companycode='" + mComp + "' and nvl(deactive,'N')='N'  " +
                    " order by FacultyName ";
            //out.print(qry);
            rs = db.getRowset(qry);
                        %>
                        <select name="Faculty" tabindex="0" id="Faculty" style="WIDTH: 230px" >
                            <%
            if (request.getParameter("x") == null) {

                            %>
                            <OPTION selected value="NONE">Select Faculty</option>
                            <%
                                while (rs.next()) {
                                    mFaculty = rs.getString("Faculty");
                                    mFacultyName = rs.getString("FacultyName");
                            %>
                            <option value="<%=mFaculty%>"><%=mFacultyName%></option>
                            <%

                                }
                            } else {

                            %>
                            <OPTION selected value="NONE">Select Faculty</option>
                            <%

                                    while (rs.next()) {
                                        mFaculty = rs.getString("Faculty");
                                        mFacultyName = rs.getString("FacultyName");
                                        if (mFaculty.equals(request.getParameter("Faculty").toString().trim())) {

                            %>
                            <option selected value="<%=mFaculty%>"><%=mFacultyName%></option>
                            <%
                            } else {
                            %>
                            <option  value="<%=mFaculty%>"><%=mFacultyName%></option>
                            <%
                    }
                }
            }



                            %>
                        </select>

                    </td>



                    <td >
                        <%

            qry = "select NVL(EDID,' ')EDID,NVL(EDCODE,' ')EDCODE,NVL(EDDESCRIPTION ,' ')EDDESCRIPTION " +
                    " from Edmaster  where companycode='" + mComp + "' AND edcode in ('PF','TDS')";
          //  out.print(qry);
            rs = db.getRowset(qry);
                        %>
                        <font face=arial size=2><STRONG>&nbsp;Type of Deduction</STRONG></FONT>

                        <select name="TypeDed" id="TypeDed">

                            <%
            try {

                if (request.getParameter("x") == null) {
                    while (rs.next()) {
                            %>
                            <option value="<%=rs.getString("EDID")%>"><%=rs.getString("EDDESCRIPTION")%>--<%=rs.getString("EDCODE")%></option>
                            <%
                                                  }
                                              } else {

                                                  while (rs.next()) {
                                                      if (request.getParameter("TypeDed").equals(rs.getString("EDID"))) {
                            %>
                            <option selected value="<%=rs.getString("EDID")%>"><%=rs.getString("EDDESCRIPTION")%>--<%=rs.getString("EDCODE")%></option>
                            <%
                            } else {

                            %>
                            <option value="<%=rs.getString("EDID")%>"><%=rs.getString("EDDESCRIPTION")%>--<%=rs.getString("EDCODE")%></option>
                            <%

                        }
                    }
                }

            } catch (Exception e) {
                //out.println("Exception e:-"+e);
            }
                            %>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td colspan="4" align="center">
                        <input type="submit" name="submit" value="Submit">

                    </td>
                </tr>
            </table>
        </form>


        <%
            if (request.getParameter("x") != null) {
                String msmvt = "", msmt1 = "", msmt2 = "", msmt = "", mSmvt = "";
                mEmpID = request.getParameter("Faculty");
                mTypeDed = request.getParameter("TypeDed");
        %>

        <form name="frm2" method="post">
            <input type="hidden" name="y" id="y">
            <input type="hidden" name="x" id="x">

            <input type="hidden" name="Faculty" id="Faculty" value="<%=mEmpID%>">
            <input type="hidden" name="TypeDed" id="TypeDed" value="<%=mTypeDed%>">

            <table  bordercolor=maroon cellpadding=5 cellspacing=0  align=center rules=groups  border=1  >
            <tr><br>
                <td><font face=arial size=2><STRONG>&nbsp;Financial Year </STRONG></FONT>
                    <%
            qry = "select nvl(FINANCIALYEARCODE,' ')FINANCIALYEARCODE  from  Financialyearmaster a " +
                    "where a.COMPANYCODE='" + mComp + "' ORDER BY A.FINANCIALYEARCODE DESC";
            rs = db.getRowset(qry);
                    %>
                    <select name="FinYearCode" id="FinYearCode">
                        <%
            try {
                while (rs.next()) {
                    if (request.getParameter("y") == null) {
                        if (mFinYearCode.equals("")) {
                            mFinYearCode = rs.getString("FINANCIALYEARCODE");
                        }
                        %>
                        <option value="<%=rs.getString("FINANCIALYEARCODE")%>"><%=rs.getString("FINANCIALYEARCODE")%></option>
                        <%
                                } else {
                                    if (request.getParameter("FinYearCode").equals(rs.getString("FINANCIALYEARCODE"))) {
                        %>
                        <option selected value="<%=request.getParameter("FinYearCode")%>"><%=request.getParameter("FinYearCode")%></option>
                        <%
                            } else {

                        %>
                        <option value="<%=rs.getString("FINANCIALYEARCODE")%>"><%=rs.getString("FINANCIALYEARCODE")%></option>
                        <%

                        }
                    }
                }
            } catch (Exception e) {
                //out.println("Exception e:-"+e);
            }
                        %>
                    </select>


                </td>

                <td ><font face=arial size=2><STRONG>&nbsp;From Period </STRONG></FONT>

                    <%
try{
            qry = "Select distinct YearMonth ,to_char(to_date('01'||yearmonth,'ddyyyymm'),'MON-YYYY')yearmm " +
                    "from payablesalary where CompanyCode='" + mComp + "'" +
                    " and EmployeeID='" + mEmpID + "' order by YearMonth DESC";
            //out.print(qry);
%>
                    <select name="FromPeriod" id="FromPeriod" >
                        <%
            rst = db.getRowset(qry);
            while (rst.next()) {
                msmv = rst.getString(1);
                //out.print(msmv);
                msm = rst.getString(2);

                //msm=MonthName[Integer.parseInt(msmv.substring(5,6))]+" "+msmv.substring(0,4);

                if (request.getParameter("y") == null) {
                    if (mSmv.equals("")) {
                        mSmv = msmv;
                        %>
                        <OPTION selected Value ="<%=msmv%>"><%=msm%></option>
                        <%
                                    } else {
                        %>
                        <OPTION Value ="<%=msmv%>"><%=msm%></option>
                        <%
                                }
                            } else {
                                if (request.getParameter("FromPeriod").equals(rst.getString(1))) {
                        %>
                        <OPTION selected Value ="<%=msmv%>"><%=msm%></option>
                        <%
                            } else {
                        %>
                        <OPTION  Value ="<%=msmv%>"><%=msm%></option>
                        <%
                    }
                }
            }
                 }
catch (Exception e)
    {
    out.print(e);
    }
     %>
                    </select>
                </TD>
                <TD>
                    <font face=arial size=2><STRONG>&nbsp;To Period </STRONG></FONT>
                    &nbsp;
                    <%
 qry1 = "Select distinct YearMonth YearMonth," +
         " to_char(to_date('01'||yearmonth,'ddyyyymm'),'MON-YYYY')yearmm " +
                        " from payablesalary where CompanyCode='" + mComp + "'" +
                        " and EmployeeID='" + mEmpID + "'" +
                        " order by YearMonth DESC";
            // out.print(qry);

           try {
               
                    %>
                    <select name="ToPeriod" id="ToPeriod" >
                        <%
                        rs1 = db.getRowset(qry1);
                        while (rs1.next()) {

                            msmvt = rs1.getString(1).toString().trim();
                            msmt = rs1.getString(2);

                            mSmvt = msmvt;
                            if (request.getParameter("y") == null) {


                        %>
                        <OPTION selected Value ="<%=msmvt%>"><%=msmt%></option>
                        <%

                        } else {
                            if (request.getParameter("ToPeriod").equals(rst.getString(1))) {
                        %>
                        <OPTION selected Value ="<%=msmvt%>"><%=msmt%></option>
                        <%
                         } else {
                        %>
                        <OPTION  Value ="<%=msmvt%>"><%=msmt%></option>
                        <%
                        }

                    }
                }
            } catch (Exception e) {
                out.print(e);
            }
                        %>
                    </select>

                    
                </td>

            </tr>

            <tr><td align="center" colspan="3"><input type="submit" name="submit" value="Show" > </td></tr>
</table>
        </form>
        <%
            if (request.getParameter("Faculty") != null) {


                mEmpID = request.getParameter("Faculty");
                mTypeDed = request.getParameter("TypeDed");
                mFinYear = request.getParameter("FinYearCode");
                mFromPeriod = request.getParameter("FromPeriod");
                mToPeriod = request.getParameter("ToPeriod");






                qry = "select  a.COMPANYCODE,A.EMPLOYEEID,to_char(A.OPENINGDATE,'dd-mm-yyyy')OPENINGDATE,to_char(a.OPENINGDATE,'yyyymm')opendt,A.EDID," +
                        " A.OPENNINGBALANCE from EDOpeningBalance a , EDMASTER b " +
                        " where a.CompanyCode='" + mComp + "' and a.EmployeeID='" + mEmpID + "'  and a.EDID='" + mTypeDed + "'" +
                        "  and a.COMPANYCODE=b.COMPANYCODE and  a.EDID=b.EDID ";
                out.print(qry);
                rs = db.getRowset(qry);
                if (rs.next()) {
                    mOpenDT = rs.getString("opendt");
                } else {
                    qryd = "select to_char(to_date('" + mFromPeriod + "','rrrrmm')-1,'dd-mm-yyyy')datee from dual";
                    out.print(qryd);
                    rs1 = db.getRowset(qryd);
                    if (rs1.next()) {
                        mOpenDT = rs1.getString("datee");
                    }
                }

                /*--as on selected date sum---*/
                qry1 = "select SUM(sum(decode(prflag,'R',nvl(edamount,0)+nvl(arrearamount,0),0))- sum(decode(prflag,'P',nvl(edamount,0)+nvl(arrearamount,0),0))) sumadd " +
                        " from Payablesalary A, EDMASTER b where   A.employeeid    ='" + mEmpID + "'" +
                        " AND     A.COMPANYCODE   ='" + mComp + "' " +
                        " AND     A.EDID          = B.EDID " +
                        " AND     A.COMPANYCODE   = B.COMPANYCODE " +
                        " AND     A.EDID          ='" + mTypeDed + "'" +
                        " and     A.yearmonth     <=  " + mOpenDT + " " +
                        " And     A.yearmonth     >=  " + mFromPeriod + "" +
                        " group by a.yearmonth order by A.yearmonth desc ";
                rst = db.getRowset(qry1);
                //    out.print(qry1);
                if (rst.next()) {
                    mSadd = rst.getDouble("sumadd");
                }
                //---------------------------------------------------------------------//

                /*--as on one month from selected date sum---*/
                qrya = "SELECT   SUM (  SUM (DECODE (prflag,'R', NVL (edamount, 0) + NVL (arrearamount, 0), 0) )- " +
                        " SUM (DECODE (prflag,'P', NVL (edamount, 0) + NVL (arrearamount, 0),0))) sumarrd1 " +
                        "   FROM payablesalary a, edmaster b   WHERE a.employeeid   ='" + mEmpID + "' " +
                        "     AND a.companycode = '" + mComp + "'     AND a.edid = b.edid" +
                        "     AND a.companycode = b.companycode" +
                        "     AND a.edid = '" + mTypeDed + "'     AND a.yearmonth < " + mFromPeriod + "    GROUP BY a.yearmonth" +
                        " ORDER BY a.yearmonth DESC ";
                //out.print(qrya);
                rsa = db.getRowset(qrya);
                if (rsa.next()) {
                    mSumfirst = rsa.getDouble("sumarrd1");
                }


                //summing the fas on selected date + open.balanace +
                double mopbalance = rs.getDouble("OPENNINGBALANCE");
                mopbalance = mopbalance + mSumfirst;



                qry2 = "select sum( sum(decode(prflag,'R',nvl(edamount,0)+nvl(arrearamount,0),0))- sum(decode(prflag,'P',nvl(edamount,0)+nvl(arrearamount,0),0))) sumarrd " +
                        " from Payablesalary A, EDMASTER b where   A.employeeid    ='" + mEmpID + "'" +
                        " AND     A.COMPANYCODE   ='" + mComp + "' " +
                        " AND     A.EDID          = B.EDID " +
                        " AND     A.COMPANYCODE   = B.COMPANYCODE " +
                        " AND     A.EDID          ='" + mTypeDed + "'" +
                        " and      A.yearmonth     >=   " + mFromPeriod + " and A.yearmonth    <=  " + mToPeriod + " " +
                        " group by a.yearmonth order by A.yearmonth desc ";
                //out.print(qry2);
                ResultSet rst2 = db.getRowset(qry2);
                if (rst2.next()) {
                    sumAmount1 = rst2.getDouble("sumarrd");
                }

                mTotalopbalance = mopbalance + sumAmount1;
        %>
        <form name="frm3" method="post" >
        <input type="hidden" name="y" id="y">
        <input type="hidden" name="x" id="x">
        <input type="hidden" name="Faculty" id="Faculty" value="<%=mEmpID%>">
        <input type="hidden" name="TypeDed" id="TypeDed" value="<%=mTypeDed%>">
        <input type="hidden" name="FinYearCode" id="FinYearCode" value="<%=mFinYear%>">
        <input type="hidden" name="TypeDed" id="TypeDed" value="<%=mTypeDed%>">



        <input type="hidden" name="FromPeriod" id="FromPeriod" value="<%=mFromPeriod%>">
        <input type="hidden" name="ToPeriod" id="ToPeriod" value="<%=mToPeriod%>">

        <table width="100%" align="center"><hr>

            <tr><td align="center"><font face="verdana" color="#a52a2a" size="2"> <B><U>Available Details</U> </b> </font> </td></tr>
        </table>

        <TABLE ALIGN="CENTER"  CELLPADDING="1" CELLSPACING="1" BORDER="1" bgcolor=#fce9c5 class="sort-table" id="table-1">


            <tr  bgcolor="#ff8c00"><td><font size="2" color="white"><b>Summary Detail </b></td>
            <td><font size="2" color="white" ><b> Amount  <img SRC="images/Rs.jpg.png" > . </b> </td></tr>
            <TR>
                <TD>Opening Balance as on <%=mdate%> </TD>
                <TD><b> <%=mopbalance%> <img SRC="images/Rs.jpg.png" > </b></TD>
            </TR>
            <TR>
                <TD>For the Selected Period</TD>
                <TD><b> <%=sumAmount1%> </b> <img SRC="images/Rs.jpg.png" > </TD>
            </TR>

            <TR>
                <TD><font size="2">Total Amount </TD>
                <TD><font size="2" color="blue"><b> <%=mTotalopbalance%>  </b>
                <img SRC="images/Rs.jpg.png" >  </TD>
            </TR>

            <TBODY>


            </TBODY>



        </TABLE>





        <%


            /*
            qry1="select a.EDAmount,a.yearmonth, to_char(to_date('01'||a.yearmonth,'ddyyyymm'),'MON-YYYY')yearmm , SUM (nvl(a.edamount,0) + nvl(a.arrearamount,0)) sumarr from Payablesalary A, EDMASTER b where A.employeeid='" + mDMemberID + "'  AND A.COMPANYCODE='" + mComp + "' AND A.EDID=B.EDID" +
            " AND A.COMPANYCODE=B.COMPANYCODE AND A.EDID='"+mTypeDed+"'" +
            " and A.yearmonth<="+mFromPeriod+" and A.yearmonth>="+mToPeriod+"" +
            " group by   a.EDAmount,a.yearmonth,(A.EDAMOUNT+A.ARREARAMOUNT)" +
            " order by A.yearmonth desc";*/

            qry1 = "select a.yearmonth, to_char(to_date('01'||a.yearmonth,'ddyyyymm'),'MON-YYYY')yearmm , " +
                    " sum(decode(prflag,'R',nvl(edamount,0)+nvl(arrearamount,0),0))- sum(decode(prflag,'P',nvl(edamount,0)+nvl(arrearamount,0),0)) sumarr " +
                    " from Payablesalary A, EDMASTER b where   A.employeeid    ='" + mEmpID + "'" +
                    " AND     A.COMPANYCODE   ='" + mComp + "' " +
                    " AND     A.EDID          = B.EDID " +
                    " AND     A.COMPANYCODE   = B.COMPANYCODE " +
                    " AND     A.EDID          ='" + mTypeDed + "'" +
                    " and     A.yearmonth     >=   " + mFromPeriod + " and A.yearmonth    <=  " + mToPeriod + " " +
                    " group by a.yearmonth order by A.yearmonth desc ";
            //out.print(qry1);
            rst = db.getRowset(qry1);

        %>
        <br>

        <table width="100%" align="center"><hr>

            <tr><td align="center"><font face="verdana" color="#a52a2a" size="2"> <B><U>Available Tax Details</U> </b> </font> </td></tr>
        </table>
        <TABLE ALIGN="CENTER" CELLPADDING="1" CELLSPACING="1" BORDER="1" bgcolor=#fce9c5 class="sort-table" id="table-1">

            <THEAD>
                <tr  bgcolor="#ff8c00" ><td><font size="2" color="white"><b>Month </b></td>
                    <td><font size="2" color="white"><b> Tax Deducted<img SRC="images/Rs.jpg.png" > . </b> </td>

                </tr>
            </THEAD>
            <TBODY>
                <%
            while (rst.next()) {
                sumamt = rst.getDouble("sumarr");
                sumAmount = sumAmount + sumamt;
                %>
                <TR>
                    <TD> <%=rst.getString("yearmm")%> </TD>
                    <TD><b> <%=rst.getString("sumarr")%> <img SRC="images/Rs.jpg.png" > </b></TD>
                </TR>
                <%
            }
                %>
                <TR>
                    <TD  ALIGN="right" ><font size="2"> Total Amount</font></td>
                    <td align="left"><font size="2" color="blue"><b><%=sumAmount%> <img SRC="images/Rs.jpg.png" ></b> </TD>
                </TR>

            </TBODY>


        </TABLE>

        <%


                }//y


            }//x

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
    </body>
</html>
