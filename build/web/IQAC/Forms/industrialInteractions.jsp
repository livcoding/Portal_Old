<%-- 
    Document   : industrialInteractions
    Created on : Mar 3, 2015, 10:29:48 AM
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
            #mastergrid1 th { padding:5px; border:#999 1px solid; }
            #mastergrid :hover, .applicantclass:focus, .applicantclass:active   {
                background: skyblue !important;}


        </style>
        <script src="../js/jquery/jquery-1.10.2.js"></script>
        <script src="../js/jquery/jquery-ui.js"></script>
        <script src="../js/jquery/yattable.js"></script>
        <script src="../js/jquery/numeric-1.0.js"></script>
        <script src="../js/IQTest/CommonServiceJs.js"></script>
        <script src="../js/IQTest/ComboJs.js"></script>
        <script src="../js/IQTest/industrialInteractionsJS.js"></script>
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
            });
        </script>
    </head><%
         String mInst = "", mComp = "", mSrcType = "";
        String mInstitute = "";
        request.getParameter("");
        CommonComboData ccd=new CommonComboData();
        ResultSet RsChk=null;
       DBHandler db=new DBHandler();
         String mMemberID = "",mChkMemID="";
         String mMemberType ="",mChkMType="";
         String mMemberName = "",mRole="",mIPAddress="";
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

		String mLoginComp="";

if (session.getAttribute("LoginComp")==null)
{
	mLoginComp="";
}
else
{
	mLoginComp=session.getAttribute("LoginComp").toString().trim();
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
            <input type="hidden" id="transactionID"  value="0"/>
            <input type="hidden" id="entryBy"  value="<%=mChkMemID%>"/>
            <!-- Above Is  to handle  the session values   -->
            <div id="windowheader" class="ui-widget-header ui-corner-all div" style="height:28px " >Industrial Interactions Details</div> 
            <div style="width:100%; padding: 10px ;border: .3em solid;border-radius: 25px;" > 
                <table id="commonmasterid" style="text-align: center;font-size: 18px; border:1px;width: 100%">
                 <tr>
                   <td style="text-align: right">Transaction Date<span class="req"> *</span> :</td><td style="text-align: left"><input type='text' name='transactionDate' id='transactionDate'  value='' maxlength='100' class='date' style='' title='Transaction Date' readonly/></td>
                   <td style="text-align: right">Department Name<span class="req"> *</span> :</td><td style="text-align: left"><select  name='departmentName' id='departmentName'  class='combo' style=''  title='Department Name'><%=ccd.commonJspCombo("{\"comboId\":\"departmentComboShortNameisNull\"}")%></select></td>
                 </tr> 
                <tr>
                    <td style="text-align: right">Other Industry Related Activities To Be Conducted By Department<span class="req"> *</span> :</td><td style='text-align: left'><input type='text' name='industryRelatedActivity' id='industryRelatedActivity' value='' maxlength='160' class='textbox'  title='Details of Industry Related Activity'/></td>
                    <td style="text-align: right">Details of Industry Sponsored R&D Lab.At Institute<span class="req"> *</span> :</td><td style='text-align: left'><input type='text' name='rdLab' id='rdLab' value='' maxlength='160' class='textbox'  title='Details of R&D Lab at Institute'/></td>
                    
                </tr> 
                 <tr>
                    <td style="text-align: right">Details Of Collaborative Degree Program in Department<span class="req"> *</span> :</td><td style='text-align: left'><input type='text' name='collaborativeDegree' id='collaborativeDegree' value='' maxlength='160' class='textbox'  title='Details of Collaborative Degree'/></td>
                    <td style="text-align: right">Details Of Authorship & Attribution Of Joint Article,Publications,and Presentations<span class="req"> *</span> :</td><td style='text-align: left'><input type='text' name='authorshipAttribution' id='authorshipAttribution' value='' maxlength='160' class='textbox'  title='Details of Authorship & Attribution'/></td>
                 </tr> 
                <tr>
                    <td style="text-align: right">Details Of Industry Support For Education Conferences and Meetings/Social Events<span class="req"> *</span> :</td><td style='text-align: left'><input type='text' name='industrySupport' id='industrySupport' value='' maxlength='160' class='textbox'  title='Details of Industry Support'/></td>
                    <td style="text-align: right">Details Of Gift & Compensation Received By Any Teaching/Non-Teaching Staff<span class="req"> *</span> :</td><td style='text-align: left'><input type='text' name='giftCompensation' id='giftCompensation' value='' maxlength='160' class='textbox'  title='Details of Gift & Compensation'/></td>
                </tr> 
                 <tr>
                    <td style="text-align: right">Details of Industry Sponsored Scholarship/Fellowships for Students<span class="req"> *</span> :</td><td style='text-align: left'><input type='text' name='scholarship' id='scholarship' value='' maxlength='160' class='textbox'  title='Details of Scholarship/Fellowship'/></td>
                    <td style="text-align: right">Remarks :</td><td style="text-align: left"><input type='text' name='programRemarks' id='programRemarks'  value='' maxlength='160' class='textbox' style='' title='Remarks' /></td>
                 </tr>
                <tr>
                    <td style="text-align: right">Approval of HOD<span class="req"> *</span> :</td><td style="text-align: left"><input type='radio' name='approvalOfHOD' id='approvalOfHODY'  value='Y'  /> Yes<input type='radio' name='approvalOfHOD' id='approvalOfHODN'  value='N'  /> No</td>
                    <td style="text-align: right">Approval of VC<span class="req"> *</span> :</td><td style="text-align: left"><input type='radio' name='approvalOfVC' id='approvalOfVCY'  value='Y'  /> Yes<input type='radio' name='approvalOfVC' id='approvalOfVCN'  value='N'  />No</td>
                </tr>
                
                </table>
            </div>
                 <div id="tabs">
                     <ul>
                         <li><a href="#tabs-1"><b>Details Of Guest Lecture By Industrial Experts</b></a></li>
                         <li><a href="#tabs-2"><b>Industrial Visits And Tours</b></a></li>
                         <li><a href="#tabs-3"><b>Details Of Industry-Led Training And Education</b></a></li>
                     </ul>
                     <div id="tabs-1">
                         <div style="height: 150px;" >
                             <table id="guestLectureTable" style="width: 100%;font-size: 15px;text-align: center;">
                                 <tr class="_thead">

                                     <th style="width:3%;word-spacing:normal">S No.</th>
                                     <th style="width:19%">Guest Lecture Name</th>
                                     <th style="width:15%">Topic</th>
                                     <th style="width:15%">From Date</th>
                                     <th style="width:15%">To Date</th>
                                     <th style="width:15%">No. Of Participants</th>
                                     <th style="width:15%">Remarks</th>
                                     <th style="width:3%"><img src="../js/jquery/add.png" title="Add New Row" style="cursor:pointer" class="addGuestLectureRow" id="addGuestLectureRow1"/></th>

                                 </tr>
                                 <tbody class="guestLectureRow1">
                                     <tr>
                                         <td id="firstRow1">1.</td>
                                 <input type="hidden" name="guestLectureID" id="guestLectureID1" value="0" maxlength="50" class="textbox" style="width:90%" />
                                 <td><input type="text" name="guestLectureName" id="guestLectureName1" value="" maxlength="50" class="textbox" style="width:90%" /></td>
                                 <td><input type="text" name="topic" id="topic1" value="" maxlength="160" class="textbox" style="width:85%"/></td>
                                 <td><input type="text" name="glFromDate" id="glFromDate1" value="" maxlength="10" class="date" style="width:85%" /></td>
                                 <td><input type="text" name="glToDate" id="glToDate1" value="" maxlength="10" class="date" style="width:85%" /></td>
                                 <td><input type="text" name="guestLectureNoOfParticipants" id="guestLectureNoOfParticipants1" value="" maxlength="5" class="nondecimal" style="width:85%"/></td>
                                 <td><input type="text" name="guestLectureRemarks" id="guestLectureRemarks1" value="" maxlength="160" class="textbox" style="width:85%"/></td>
                                 <td><img src="../js/jquery/minus.png"  title="Delete Current Row" style="cursor:pointer" class="dGuestLectureRow" id="dGuestLectureRow1"/></td>
                                 </tr>
                                 </tbody>   
                             </table>
                         </div>

                     </div>
                     <div id="tabs-2">
                         <div style="height: 150px;" >
                             <table id="industryVisitedTable" style="width: 100%;font-size: 15px;text-align: center;">
                                 <tr class="_thead">

                                     <th style="width:3%;word-spacing:normal">S No.</th>
                                     <th style="width:19%">Name of Industry Visited/Tours</th>
                                     <th style="width:15%">Tour Details</th>
                                     <th style="width:15%">From Date</th>
                                     <th style="width:15%">To Date</th>
                                     <th style="width:15%">No. Of Participants</th>
                                     <th style="width:15%">Remarks</th>
                                     <th style="width:3%"><img src="../js/jquery/add.png" title="Add New Row" style="cursor:pointer" class="addIndustryVisitedRow" id="addIndustryVisitedRow1"/></th>

                                 </tr>
                                 <tbody class="industryVisitedRow1">
                                     <tr>
                                         <td id="SecondRow1">1.</td>
                                 <input type="hidden" name="industryVisitedNameID" id="industryVisitedNameID1" value="0" maxlength="50" class="textbox" style="width:90%" />
                                 <td><input type="text" name="industryVisitedName" id="industryVisitedName1" value="" maxlength="160" class="textbox" style="width:90%" /></td>
                                 <td><input type="text" name="tourDetails" id="tourDetails1" value="" maxlength="160" class="textbox" style="width:85%"/></td>
                                 <td><input type="text" name="ivFromDate" id="ivFromDate1" value="" maxlength="10" class="date" style="width:85%" /></td>
                                 <td><input type="text" name="ivToDate" id="ivToDate1" value="" maxlength="10" class="date" style="width:85%" /></td>
                                 <td><input type="text" name="industryVisitedNoOfParticipants" id="industryVisitedNoOfParticipants1" value="" maxlength="5" class="nondecimal" style="width:85%"/></td>
                                 <td><input type="text" name="industryVisitedRemarks" id="industryVisitedRemarks1" value="" maxlength="160" class="textbox" style="width:85%"/></td>
                                 <td><img src="../js/jquery/minus.png"  title="Delete Current Row" style="cursor:pointer" class="dIndustryVisitedRow" id="dIndustryVisitedRow1"/></td>
                                 </tr>
                                 </tbody>   
                             </table>
                         </div>

                     </div>
                     <div id="tabs-3">
                         <div style="height: 150px;" >
                             <table id="industryLedTrainingTable" style="width: 100%;font-size: 15px;text-align: center;">
                                 <tr class="_thead">

                                     <th style="width:3%;word-spacing:normal">S No.</th>
                                     <th style="width:19%">Industry-Led Training Name</th>
                                     <th style="width:15%">Topic of the Training</th>
                                     <th style="width:15%">From Date</th>
                                     <th style="width:15%">To Date</th>
                                     <th style="width:15%">No. Of Participants</th>
                                     <th style="width:15%">Remarks</th>
                                     <th style="width:3%"><img src="../js/jquery/add.png" title="Add New Row" style="cursor:pointer" class="addIndustryLedTrainingRow" id="addIndustryLedTrainingRow1"/></th>

                                 </tr>
                                 <tbody class="industryLedTrainingRow1">
                                     <tr>
                                         <td id="ThirdRow1">1.</td>
                                 <input type="hidden" name="industryLedTrainingID" id="industryLedTrainingID1" value="0" maxlength="50" class="textbox" style="width:90%" />
                                 <td><input type="text" name="industryLedTrainingName" id="industryLedTrainingName1" value="" maxlength="50" class="textbox" style="width:90%" /></td>
                                 <td><input type="text" name="topicOfTheTraining" id="topicOfTheTraining1" value="" maxlength="160" class="textbox" style="width:85%"/></td>
                                 <td><input type="text" name="itFromDate" id="itFromDate1" value="" maxlength="10" class="date" style="width:85%" /></td>
                                 <td><input type="text" name="itToDate" id="itToDate1" value="" maxlength="10" class="date" style="width:85%" /></td>
                                 <td><input type="text" name="industryLedTrainingNoOfParticipants" id="industryLedTrainingNoOfParticipants1" value="" maxlength="5" class="nondecimal" style="width:85%"/></td>
                                 <td><input type="text" name="industryLedTrainingRemarks" id="industryLedTrainingRemarks1" value="" maxlength="160" class="textbox" style="width:85%"/></td>
                                 <td><img src="../js/jquery/minus.png"  title="Delete Current Row" style="cursor:pointer" class="dIndustryLedTrainingRow" id="dIndustryLedTrainingRow1"/></td>
                                 </tr>
                                 </tbody>   
                             </table>
                         </div>
                     </div>
                 </div>
               <div class="ui-widget-header ui-corner-all" style="text-align:left;width:100%;" id="finaldivsave">
                <span style="font-size: 14px;margin-left: 2%">Search :</span> <input type="text" class="textbox" id="searchbox" title='Type and Search Into Grid'style="width: 120px"/>
                <input type="button" title='Save Record'  class="button" id="finalSaveForm" style="cursor:pointer;margin-left: 60%" onclick="formsubmit()" value="Save">
                <input type="button"  title='Reset Fields'  class="button" id="finalSaveForm" style="cursor:pointer;" onclick=" resetValues()" value="Reset">
                <input type="button" title='Exit Form'  class="button" id="finalSaveForm" style="cursor:pointer;" onClick="history.go(-1);" value="Exit"></div>
            <table id="mastergrid1" style="width: 100%;font-size: 18px;text-align: center;table-layout:fixed;" ><thead id="gridhead"></thead></table>
            <table id="mastergrid" style="width: 100%;font-size: 18px;text-align: center;table-layout:fixed;word-wrap: break-word" ><tbody id="gridbody"></tbody></table>
            <div class="ui-widget-header ui-corner-all" style="text-align:right;width:100%;" >
                <span id="TOT" style="font-size:15px;alignment-adjust: auto "> </span>
                <select id="pagging" title='Select No. of Records Per Page' onchange="getGridData(0)"  style="text-align:left" ></select>
                <input type='button'  class='button' id="first" value='|< First'  title='Jump to the First Page' onclick='showList(0)'>
                <input type='button'  title='Go to the Prev. Page'  class='button' id="previous" value='< Previous' onclick='showList(" + (pr - plimit) + ")'>
                <input type='button'  title='Go to the Next Page'  class='button' id="next" value='Next >' onclick='showList(" + (pr + plimit) + ")'>
                <input type='button' title='Jump to the Last Page'  class='button' id="last" value='Last >|'  onclick='showList(" + (page * plimit - plimit) + ")'>
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

