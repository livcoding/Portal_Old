<%-- 
    Document   : conferenceTransaction
    Created on : May 20, 2015, 3:20:08 PM
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
            html, body{ margin: 0; border: 0 none; padding: 0;    height: 100%; min-height: 100%; overflow: hidden;   }
            html, body, #wrapper, #left, #right { height: 110%; min-height: 110%; margin-top: auto }
            #wrapper { margin: 0 auto; overflow: hidden; width: 960px;  }
            #mastergrid  tr:nth-child(even) {background: #F8F8F8;cursor:pointer;padding:8px; border:#999 1px solid; }
            #mastergrid tr:nth-child(odd) {background: 	#EBF5FF;cursor:pointer;padding:8px; border:#999 1px solid; }
            #mastergrid td { padding:5px; border:#999 1px solid; }
            #mastergrid1 th { padding:5px; border:#999 1px solid; text-wrap:normal; }
            #mastergrid :hover, .applicantclass:focus, .applicantclass:active   {
                background: skyblue !important;}

        </style>
        <script src="../js/jquery/jquery-1.10.2.js"></script>
        <script src="../js/jquery/jquery-ui.js"></script>
        <script src="../js/jquery/yattable.js"></script>
        <script src="../js/jquery/numeric-1.0.js"></script>
        <script src="../js/IQTest/CommonServiceJs.js"></script>
        <script src="../js/IQTest/ComboJs.js"></script>
        <script src="../js/IQTest/conferenceTransactionJS.js"></script>
        <script>
            $(document).ready(function() {
                $(".date").datepicker({
                    dateFormat: 'dd-mm-yy',
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '-100:+10'
                });
                getCommonMasterTable();

//                $(document).tooltip({
//                    track: true
//                });
//                $("#conferenceStartDate").datepicker({
//                    dateFormat: 'dd-mm-yy',
//                    minDate: 0,
//                    onSelect: function(selected) {
//                   $("#conferenceEndDate").datepicker("option", "minDate", selected)
//                    }
//                });
//                $("#conferenceEndDate").datepicker({
//                    // numberOfMonths: 2,
//                    dateFormat: 'dd-mm-yy',
//                    onSelect: function(selected) {
//                        $("#conferenceStartDate").datepicker("option", "maxDate", selected);
//                        
//                    }
//                   
//                });
//                //$('#conferenceEndDate').(selector);
//                
//                
//        $("#conferenceStartDate").datepicker({
//    minDate: 0,
//    maxDate: '+1Y+6M',
//    onSelect: function (dateStr) {
//        var min = $(this).datepicker('getDate'); // Get selected date
//        $("#conferenceEndDate").datepicker('option', 'minDate', min || '0'); // Set other min, default to today
//                        }
//                    });
//
//                    $("#conferenceEndDate").datepicker({
//                        minDate: '0',
//                        maxDate: '+1Y+6M',
//                        onSelect: function(dateStr) {
//                            var max = $(this).datepicker('getDate'); // Get selected date
//                            $('#datepicker').datepicker('option', 'maxDate', max || '+1Y+6M'); // Set other max, default to +18 months
//                            var start = $("#conferenceStartDate").datepicker("getDate");
//                            var end = $("#conferenceEndDate").datepicker("getDate");
//                            var days = (end - start) / (1000 * 60 * 60 * 24);
//                            $("#noOfDays").val(days);
//                        }
//                    });
$("#conferenceStartDate").datepicker({
    minDate:'-5Y',
    maxDate: '+1Y+6M',
    dateFormat: 'dd-mm-yy',
    onSelect: function (dateStr) {
        var min = $(this).datepicker('getDate'); // Get selected date
        $("#conferenceEndDate").datepicker('option', 'minDate', min || '0'); // Set other min, default to today
    }
});

$("#conferenceEndDate").datepicker({
    minDate:'-5Y',
    maxDate: '+1Y+6M',
    dateFormat: 'dd-mm-yy',
    onSelect: function (dateStr) {
        var max = $(this).datepicker('getDate'); // Get selected date
        $('#datepicker').datepicker('option', 'maxDate', max || '+1Y+6M'); // Set other max, default to +18 months
        var start = $("#conferenceStartDate").datepicker("getDate");
        var end = $("#conferenceEndDate").datepicker("getDate");
        var days = (end - start) / (1000 * 60 * 60 * 24)+1;
        $("#noOfDays").val(days);
    }
});
            });
        </script>
    </head><%
        String mInst = "", mComp = "", mSrcType = "";
        String mInstitute = "";
        request.getParameter("");
        ResultSet RsChk = null;
        DBHandler db = new DBHandler();
        CommonComboData ccd = new CommonComboData();
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
            //  out.println("nipun"+mMemberID+">>>>>"+mMemberCode+">>>>>"+mMemberName);
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
            <input type="hidden" id="conferenceID"  value="0"/>
            <input type="hidden" id="entryBy"  value="<%=mChkMemID%>"/>
            <!-- Above Is  to handle  the session values   -->
            <div id="windowheader" class="ui-widget-header ui-corner-all div" style="height:28px " >Performa For Approval Of Conference Details</div> 
            <div style="width: 99%; padding: 10px ;border: .3em solid;border-radius: 25px;" > 
                <table  id="commonmasterid" style="text-align: center;font-size: 18px; border:1px">
                    <tr>
                        <td style="text-align: right">Department Name<span class="req"> *</span> :</td><td style="text-align: left"><select  name='departmentName' id='departmentName'  class='combo' style=''  title='Department Name' onchange="getSelectGridData(0)"><%=ccd.commonJspCombo("{\"comboId\":\"departmentComboShortNameisNull\"}")%></select></td>
                        <td style="text-align: right">Proposed Conference Name<span class="req"> *</span> :</td><td style='text-align: left'><input type='text' name='proposedConferenceName' id='proposedConferenceName' value='' maxlength='160' class='textbox'  title='Proposed Conference Name'/></td>
                    </tr> 
                    <tr>
                        <td style="text-align: right" >Type Of Conference<span class="req"> *</span> :</td>
                        <td  style="text-align: left">
                            <select name="typeOfConference" class='combo' id="typeOfConference" title="Type Of Conference" >
                                <option value="0">Select Type Of Conference</option>
                                <option value="I">International</option>
                                <option value="N">National</option>
                            </select>
                        </td>
                        <td style="text-align: right">Specific Focus Area:</td><td style='text-align: left'><input type='text' name='specificFocusArea' id='specificFocusArea' value='' maxlength='60' class='textbox'  title='Specific Focus Area'/></td>
                    </tr> 
                    <tr>
                        <td style="text-align: right">Objectives :</td><td style='text-align: left'><input type='text' name='objectives' id='objectives' value='' maxlength='160' class='textbox'  title='Objectives'/></td>
                        <td style="text-align: right">Proposed Outcomes:</td><td style='text-align: left'><input type='text' name='proposedOutComes' id='proposedOutComes' value='' maxlength='160' class='textbox'  title='Proposed Outcomes'/></td>
                    </tr> 
                    <tr>
                        <td style="text-align: right">Proposed Budget<span class="req"> *</span> :</td><td style='text-align: left'><input type='text' name='proposedBudget' id='proposedBudget' value='' maxlength='12' class='number'  title='Proposed Budget' onchange="getValidateCost()"/></td>
                        <td style="text-align: right">Supporting Org. Name :</td><td style='text-align: left'><input type='text' name='supportingOrgName' id='supportingOrgName' value='' maxlength='60' class='textbox'  title='Supporting Org. Name'/></td>
                    </tr> 
                    <tr>
                        <td style="text-align: right">Supporting Org. Amount :</td><td style='text-align: left'><input type='text' name='supportingOrgAmount' id='supportingOrgAmount' value='' maxlength='12' class='number'  title='Supporting Org. Amount' onchange="getValidateAmount()"/></td>
                        <td style="text-align: right">Conference Start Date<span class="req"> *</span> :</td><td style="text-align: left"><input type='text' name='conferenceStartDate' id='conferenceStartDate'  value='' maxlength='10' class='textbox' style='width: 90px;' title='Conference Start Date'  readonly />
                            Conference End Date<span class="req"> *</span> :<input type='text' name='conferenceEndDate' id='conferenceEndDate'  value='' maxlength='10' class='textbox' style='width: 90px;' title='Conference End Date'   readonly />
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">No. Of Days :</td><td style='text-align: left'><input type='text' name='noOfDays' id='noOfDays' value='' maxlength='12' class='nondecimal'  title='No. Of Days' readonly/></td>
                        <td style="text-align: right">Expected Participants :</td><td style='text-align: left'><input type='text' name='expectedParticipants' id='expectedParticipants' value='' maxlength='5' class='nondecimal'  title='Expected Participants'/></td>
                    </tr> 
                    <tr>
                        <td style="text-align: right">Expected Papers:</td><td style='text-align: left'><input type='text' name='expectedPapers' id='expectedPapers' value='' maxlength='5' class='nondecimal'  title='Expected Papers'/></td>
                        <td style="text-align: right">No. Of Keynote Speakers<span class="req"> *</span> :</td><td style='text-align: left'><input type='text' name='noOfKeynoteSpeakers' id='noOfKeynoteSpeakers' value='' maxlength='5' class='nondecimal'  title='No. Of Keynote Speakers'/></td>
                    </tr> 
                    <tr>
                        <td style="text-align: right">Keynote Speaker Name<span class="req"> *</span> :</td><td style='text-align: left'><input type='text' name='keynoteSpeakerName' id='keynoteSpeakerName' value='' maxlength='160' class='textbox'  title='Keynote Speaker Name'/></td>
                        <td style="text-align: right">No. Of Invited Speakers :</td><td style='text-align: left'><input type='text' name='noOfInvitedSpeakers' id='noOfInvitedSpeakers' value='' maxlength='5' class='nondecimal'  title='No. Of Invited Speakers'/></td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Invited Speaker Name:</td><td style='text-align: left'><input type='text' name='invitedSpeakerName' id='invitedSpeakerName' value='' maxlength='160' class='textbox'  title='Invited Speaker Name'/></td>
                        <td style="text-align: right">No. Of Parallel Sessions:</td><td style='text-align: left'><input type='text' name='noOfParallelSessions' id='noOfParallelSessions' value='' maxlength='5' class='nondecimal'  title='No. Of Parallel Sessions'/></td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Tutorial With Conference:</td><td style='text-align: left'><input type='text' name='tutorialWithConference' id='tutorialWithConference' value='' maxlength='160' class='textbox'  title='Tutorial With Conference'/></td>
                        <td style="text-align: right" >Annual Event<span class="req"> *</span> :</td>
                        <td  style="text-align: left">
                            <select name="annualEvent" class='combo' id="annualEvent" title="Annual Event" >
                                <option value="0">Select Annual Event</option>
                                <option value="Y">Yes</option>
                                <option value="N">No</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Gain Area:</td><td style='text-align: left'><input type='text' name='gainArea' id='gainArea' value='' maxlength='160' class='textbox'  title='Gain Area'/></td>
                        <td style="text-align: right">Name Of Organizing Secretary<span class="req"> *</span> :</td><td style='text-align: left'><input type='text' name='nameOfOrganizingSecretary' id='nameOfOrganizingSecretary' value='' maxlength='60' class='textbox'  title='Name Of Organizing Secretary'/></td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Approval of HOD<span class="req"> *</span> :</td><td style="text-align: left"><input type='radio' name='approvalOfHOD' id='approvalOfHODY'  value='Y'  /> Yes<input type='radio' name='approvalOfHOD' id='approvalOfHODN'  value='N'  /> No</td>
                        <td style="text-align: right">Approval of VC<span class="req"> *</span> :</td><td td style="text-align: left"><input type='radio' name='approvalOfVC' id='approvalOfVCY'  value='Y'  /> Yes<input type='radio' name='approvalOfVC' id='approvalOfVCN'  value='N'  />No</td>
                    </tr>
                </table>
            </div>
            <div class="ui-widget-header ui-corner-all" style="text-align:left;width:100%;" id="finaldivsave">
                <span style="font-size: 14px;margin-left: 2%">Search :</span> <input type="text" class="textbox" id="searchbox" title='Type and Search Into Grid'style="width: 120px"/>
                <input type="button" title='Save Record'  class="button" id="finalSaveForm" style="cursor:pointer;margin-left: 60%" onclick="formsubmit()" value="Save">
                <input type="button"  title='Reset Fields'  class="button" id="finalSaveForm" style="cursor:pointer;" onclick=" resetValues()" value="Reset">
                <input type="button" title='Exit Form'  class="button" id="finalSaveForm" style="cursor:pointer;" onClick="history.go(-1);" value="Exit"></div>
            <table id="mastergrid1" style="width: 100%;font-size: 15px;text-align: center;table-layout:fixed;" ><thead id="gridhead"></thead></table>
            <table id="mastergrid" style="width: 100%;font-size: 15px;text-align: center;table-layout:fixed;word-wrap: break-word" ><tbody id="gridbody"></tbody></table>
            <div class="ui-widget-header ui-corner-all" style="text-align:right;width:100%;" >
                <span id="TOT" style="font-size:15px;alignment-adjust: auto "> </span>
                <select id="pagging"  title='Select No. of Records Per Page' onchange="getSelectGridData(0)"  style="text-align:left" ></select>
                <input type='button'  class='button' id="first" value='|< First'  title='Jump to the First Page'>
                <input type='button'  title='Go to the Prev. Page'  class='button' id="previous" value='< Previous'>
                <input type='button'  title='Go to the Next Page'  class='button' id="next" value='Next >'>
                <input type='button' title='Jump to the Last Page'  class='button' id="last" value='Last >|'>
            </div>  
        </form>
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
