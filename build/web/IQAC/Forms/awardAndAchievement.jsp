<%-- 
    Document   : awardAndAchievement
    Created on : Jul 23, 2015, 12:29:29 PM
    Author     : nipun.gupta
--%>

<%@ page language="java" import="java.sql.*,java.math.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="jilit.db.CommonComboData"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../css/Style.css">
        <link rel="stylesheet" href="../css/jquery-ui.css"/>
        <style type="text/css">
            html, body{ margin: 0; border: 0 none; padding: 0;    height: 100%; min-height: 100%; overflow: scroll;   }
            html, body, #wrapper, #left, #right { height: 110%; min-height: 110%; margin-top: auto }
            #wrapper { margin: 0 auto; overflow: hidden; width: 960px;  }
            #mastergrid  tr:nth-child(even) {background: #F8F8F8;cursor:pointer;padding:8px; border:#999 1px solid; }
            #mastergrid tr:nth-child(odd) {background: 	#EBF5FF;cursor:pointer;padding:8px; border:#999 1px solid; }
            #mastergrid td { padding:5px; border:#999 1px solid; }
            #mastergrid1 th { padding:5px; border:#999 1px solid;word-wrap: break-word }
            #mastergrid :hover, .applicantclass:focus, .applicantclass:active   {
                background: skyblue !important;}
           
            #facultyNamestable  tr:nth-child(even) {background: #F8F8F8;cursor:pointer;padding:8px; border:#999 1px solid; }
            #facultyNamestable tr:nth-child(odd) {background: 	#EBF5FF;cursor:pointer;padding:8px; border:#999 1px solid; }
            #facultyNamestable :hover, .highlight:focus,highlight:active   {
                background: skyblue !important;}

        </style>
        <script src="../js/jquery/jquery-1.10.2.js"></script>
        <script src="../js/jquery/jquery-ui.js"></script>
        <script src="../js/jquery/yattable.js"></script>
        <script src="../js/jquery/jquery.blockUI.js"></script>
        <script src="../js/jquery/numeric-1.0.js"></script>
        <script src="../js/IQTest/ComboJs.js"></script>
        <script src="../js/IQTest/awardAndAchievementJS.js"></script>
        <script>
            $(document).ready(function() {
                $(".date").datepicker({
                    dateFormat: 'dd-mm-yy',
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '-100:+0'
                });
                getCommonMasterTable();

//                $(document).tooltip({
//                    track: true
//                });
                $("#awardAchievementFromDate").datepicker({
                    dateFormat: 'dd-mm-yy',
                    //numberOfMonths: 2,
                    minDate: 0,
                    onSelect: function(selected) {

                        $("#awardAchievementToDate").datepicker("option", "minDate", selected)
                    }
                });
                $("#awardAchievementToDate").datepicker({
                    // numberOfMonths: 2,
                    dateFormat: 'dd-mm-yy',
                    onSelect: function(selected) {
                        $("#awardAchievementFromDate").datepicker("option", "maxDate", selected)
                    }
                });
            });
        </script>
    </head><%
        String mInst = "", mComp = "", mSrcType = "";
        String mInstitute = "";
        request.getParameter("");
        CommonComboData ccd = new CommonComboData();
        ResultSet RsChk = null;
        DBHandler db = new DBHandler();
        String mMemberID = "", mChkMemID = "";
        String mMemberType = "", mChkMType = "";
        String mMemberName = "", mRole = "", mIPAddress = "";
        String mMemberCode = "";
        String mRightsID = "";

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

        String mLoginComp = "";

        if (session.getAttribute("LoginComp") == null) {
            mLoginComp = "";
        } else {
            mLoginComp = session.getAttribute("LoginComp").toString().trim();
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
        String mHead = "";
        if (session.getAttribute("PageHeading") != null && !session.getAttribute("PageHeading").equals("")) {
            mHead = session.getAttribute("PageHeading").toString().trim();
        } else {
            mHead = "JIIT ";
        }

    %>
    <body >
        <%
            if (!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) {
                OLTEncryption enc = new OLTEncryption();
                String mDMemberID = enc.decode(mMemberID);
                String mDMemberCode = enc.decode(mMemberCode);
                String mDMemberType = enc.decode(mMemberType);

                mChkMemID = enc.decode(session.getAttribute("MemberID").toString().trim());
                mChkMType = enc.decode(session.getAttribute("MemberType").toString().trim());
                mIPAddress = session.getAttribute("IPADD").toString().trim();
                mRole = enc.decode(session.getAttribute("ROLENAME").toString().trim());
                RsChk = null;

                String qry = "Select WEBKIOSK.ShowLink('302','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";
                //out.print(qry);
                RsChk = db.getRowset(qry);
                if (RsChk.next() && RsChk.getString("SL").equals("Y")) {
        %>
        <form name="masterform" >
            <input type="hidden" id="compsession"  value="<%=mLoginComp%>"/>
            <input type="hidden" id="instsession"  value="<%=mInstitute%>"/>
            <input type="hidden" id="entryBy"  value="<%=mChkMemID%>"/>
            <input type="hidden" id="awardAchievementID"  value="0"/>
            <!-- Above Is  to handle  the session values   -->
            <div id="windowheader" class="ui-widget-header ui-corner-all div" style="width: 100%;height:28px"><div style="width: 60%;float: left;text-align: right;font-size: large">Award & Achievement</div><div style="width: 35%;float: left;text-align: right;font-size: large">[Form:QA-AR-5]</div></div> 
            <div style="width: 99%; padding: 10px ;border: .3em solid;border-radius: 25px;" > 
                <table  id="commonmasterid" style="text-align: center;font-size: 18px; border:1px">
                    <tr>
                        <td style="text-align: right">Transaction Date<span class="req"> *</span> :</td><td style="text-align: left"><input type='text' name='transactionDate' id='transactionDate'  value='' maxlength='100' class='date' style='' title='Transaction Date' readonly/></td>
                        <td style="text-align: right">Award/Achmt. Title<span class="req"> *</span> :</td><td style='text-align: left'><input type='text' name='awardAchievementTitle' id='awardAchievementTitle' value='' maxlength='100' class='textbox'  title='Award/Achmt. Title'/></td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Award/Achmt. (Org. Body)<span class="req"> *</span> :</td><td style='text-align: left'><input type='text' name='organizingBody' id='organizingBody' value='' maxlength='100' class='textbox'  title='Award/Achmt. (Organizing Body)'/></td>
                        <td style="text-align: right">Award/Achmt. Event :</td><td style='text-align: left'><input type='text' name='awardAchievementEventName' id='awardAchievementEventName' value='' maxlength='100' class='textbox'  title='Award/Achmt. Event Name'/></td>
                    </tr>
                    <tr>
                        <td style="text-align: right" >Nature Of Award/Achmt.<span class="req"> *</span> :</td>
                        <td  style="text-align: left">
                            <select name="natureOfAwardAchievement" class='combo' id="natureOfAwardAchievement" title='Nature Of Award/Achmt.'>
                                <option value="0">Select Award/Achmt. Nature</option>
                                <option value="S">State Award</option>
                                <option value="N">National Award</option>
                                <option value="I">International Award</option>
                            </select>
                        </td>
                       <td style="text-align: right">Venue :</td><td style='text-align: left'><input type='text' name='venue' id='venue' value='' maxlength='100' class='textbox'  title='Venue'/></td>
                    </tr> 
                    <tr>
                        <td style="text-align: right">Award Position(If Any) :</td><td style='text-align: left'><input type='text' name='allIndiaRank' id='allIndiaRank' value='' maxlength='4' class='nondecimal'  title='All India Rank' placeholder="Rank"/></td>
                        <td style="text-align: right">Award/Achmt. Year<span class="req"> *</span> :</td><td style='text-align: left'><input type='text' name='awardAchievementYear' id='awardAchievementYear' value='' maxlength='4' class='nondecimal'  title='Award/Achmt. Year'/></td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Department Name<span class="req"> *</span> :</td><td style="text-align: left"><select  name='departmentCombo' id='departmentCombo'  class='combo' style=''  title='Department Name' onchange="getVisible()"><%=ccd.commonJspCombo("{\"comboId\":\"departmentComboShortNameisNull\"}")%></select></td>
                        <td style="text-align: right">Cash Prize(If Any) :</td><td style='text-align: left'><input type='text' name='awardAchievementRemarks' id='awardAchievementRemarks' value='' maxlength='100' class='textbox'  title='Award/Achmt. Remarks'/></td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Prize :</td><td style="text-align: left">
                             <select name="prize" class='combo' id="prize" title='Nature Of Prize.'>
                                <option value="0">Select Prize Grade</option>
                                <option value="F">I</option>
                                <option value="S">II</option>
                                <option value="T">III</option>
                            </select>



                        </td>>
                    </tr>
                </table>
            </div>

            <div style="height: 150px;" >
                <table id="awardAndAchievementTable" style="width: 100%;font-size: 18px;text-align: center;">
                    <tr class="_thead">

                        <th style="width:5%;word-spacing:normal">S No.</th>
                        <th style="width:10%">Faculty/Student</th>
                        <th style="width:40%">Faculty/Student Name</th>
                        <th style="width:40%">Department Name</th>
                        <th style="width:5%"><img src="../js/jquery/add.png" title="Add New Row" style="cursor:pointer" class="addAwardAndAchievementRow" id="addAwardAndAchievementRow1"/></th>

                    </tr>
                    <tbody class="awardAndAchievementRow1">
                        <tr>
                            <td id="row1">1.</td>
                    <input type="hidden" name="memberID" id="memberID1" value="0" maxlength="20" class="textbox" style="width:90%" />
                    <input type="hidden" name="memberType" id="memberType1" value="" maxlength="20" class="textbox" style="width:90%" />
                    <input type="hidden" name="departmentCode" id="departmentCode1" value="" maxlength="20" class="textbox" style="width:90%" />
                    <td><label name="choose" id="choose1" style="width:90%"></label></td>
                    <td><input type="text" name="memberName" id="memberName1" value="" maxlength="100" class="textbox" style="width:90%" readonly/></td>
                    <td><input type="text" name="departmentName" id="departmentName1" value="" maxlength="100" class="textbox" style="width:85%"/></td>
                    <td><img src="../js/jquery/minus.png"  title="Delete Current Row" style="cursor:pointer" class="dAwardAndAchievementRow" id="dAwardAndAchievementRow1"/></td>
                    </tr>
                    </tbody>   
                </table>
            </div>
            <div class="ui-widget-header ui-corner-all" style="text-align:left;width:100%;" id="finaldivsave">
                <span style="font-size: 14px;margin-left: 2%">Search :</span> <input type="text" class="textbox" id="searchbox" title='Type and Search Into Grid'style="width: 120px"/>
                <input type="button" title='Save Record'  class="button" id="finalSaveForm" style="cursor:pointer;margin-left: 60%" onclick="formsubmit()" value="Save">
                <input type="button"  title='Reset Fields'  class="button" id="finalResetForm" style="cursor:pointer;" onclick=" resetValues()" value="Reset">
                <input type="button" title='Exit Form'  class="button" id="finalExitForm" style="cursor:pointer;" onClick="history.go(-1);" value="Exit"></div>
            <table id="mastergrid1" style="width: 100%;font-size: 18px;text-align: center;table-layout:fixed;" ><thead id="gridhead"></thead></table>
            <table id="mastergrid" style="width: 100%;font-size: 18px;text-align: center;table-layout:fixed;word-wrap: break-word" ><tbody id="gridbody"></tbody></table>
            <div class="ui-widget-header ui-corner-all" style="text-align:right;width:100%;" >
                <span id="TOT" style="font-size:15px;alignment-adjust: auto "> </span>
                <select id="pagging"  title='Select No. of Records Per Page' onchange="getSelectGridData(0)"  style="text-align:left" ></select>
                <input type='button'  class='button' id="first" value='|< First'  title='Jump to the First Page'>
                <input type='button'  title='Go to the Prev. Page'  class='button' id="previous" value='< Previous'>
                <input type='button'  title='Go to the Next Page'  class='button' id="next" value='Next >'>
                <input type='button' title='Jump to the Last Page'  class='button' id="last" value='Last >|'>
            </div>  
        </form>
        <div id="facultyNames" title="Faculty/Student Names" style="overflow: auto;height: 300px">
            <div class="ui-widget-header ui-corner-all" style="font-size:13px;text-align:left;width:100%;" >
                Search:<input type="text" id="searchNames">
                <select name="member" id="member" style="text-align:left" onchange="getStudentsInfo()">
                    <option value="F">Faculty</option>
                    <option value="S">Student</option>    
                </select>
                <span id="TOTAL" style="font-size:13px;alignment-adjust: auto;padding-left: 20%"> </span>
                <select id="paggingPopUp"   onchange="getMemberNames(0)"  style="text-align:left" ></select>
            </div>  
            <table style="width: 100%;font-size: 18px;text-align: center;" id="popupHeaderTable">
                <thead id="popupHeader">
                </thead>
            </table>
            <table style="width: 100%;font-size: 18px;" id="facultyNamestable">
                <tbody id="facultyNamesBody">
                    <tr><td style="text-align: left"></td></tr>
                </tbody>
            </table>
        </div>
        <%} else {
        %>
        <br>
        <font color=red>
        <h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
        <P>	This page is not authorized/available for you.
            <br>For assistance, contact your network support team. 
            </font>	<br>	<br>	<br>	<br>  
            <%                }
                } else {
                    out.print("<br><img src='../../Images/Error1.jpg'>");
                    out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
                }
            %>
    </body>
</html>


