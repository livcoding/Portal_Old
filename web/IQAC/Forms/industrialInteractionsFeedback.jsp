<%-- 
    Document   : industrialInteractionsFeedback
    Created on : Mar 12, 2015, 10:43:50 AM
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
        <script src="../js/IQTest/industrialInteractionsFeedbackJS.js"></script>
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
$("#startDate").datepicker({
                     dateFormat: 'dd-mm-yy',
        //numberOfMonths: 2,
          minDate: '-5Y',

        onSelect: function(selected) {
            
          $("#endDate").datepicker("option","minDate", selected)
        }
    });
    $("#endDate").datepicker({ 
       // numberOfMonths: 2,
       dateFormat: 'dd-mm-yy',
        onSelect: function(selected) {
           $("#startDate").datepicker("option","maxDate", selected)
        }
    });  
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
            <input type="hidden" id="entryBy"  value="<%=mChkMemID%>"/>
            <!-- Above Is  to handle  the session values   -->
            <div id="windowheader" class="ui-widget-header ui-corner-all div" style="height:28px " >Industrial Interactions Feedback Form</div> 
            <div style="width: 99%; padding: 10px ;border: .3em solid;border-radius: 25px;" > 
                <table  id="commonmasterid" style="text-align: center;font-size: 18px; border:1px">
                  <tr>
                      <td style="text-align: right;font-size: 12px">Interactions Details<span class="req"> *</span> :</td><td style="text-align: left"><select  name='transactionID' id='transactionID'  class='combo' style=''  title='Transaction ID' onchange="getData()"><%=ccd.commonJspCombo("{\"comboId\":\"transactionIDCombo\"}")%></select></td>
                   <td style="text-align: right;font-size: 12px">Transaction Date<span class="req"> *</span> :</td><td style="text-align: left"><input type='text' name='transactionDate' id='transactionDate'  value='' maxlength='100' class='date' style='' title='Transaction Date' readonly/></td>
                  </tr> 
                  <tr>
                      <td style="text-align: right;font-size: 12px">Department Name<span class="req"> *</span> :</td><td style="text-align: left"><input type="text"  name='departmentName' id='departmentName'  class='textbox' style=''  title='Department Name' readonly></td>
                    <td style="text-align: right;font-size: 12px" >Program Type<span class="req"> *</span> :</td>
                    <td  style="text-align: left">
                        <select name="programType" class='combo' id="programType" title="Program Type" >
                                <option value="0">Select Program Type</option>
                                <option value="W">Work Shop</option>
                                <option value="S">Special Course</option>
                                <option value="G">Guest Lecture</option>
                                <option value="F">Faculty Development Program</option>
                              </select>
                    </td>
                </tr> 
                <tr>
                    <td style="text-align: right;font-size: 12px">Title of the Program<span class="req"> *</span> :</td><td style='text-align: left'><input type='text' name='titleOfTheProgram' id='titleOfTheProgram' value='' maxlength='160' class='textbox'  title='Title of the Program'/></td>
                   <td style="text-align: right">Start Date<span class="req"> *</span> :</td><td style="text-align: left"><input type='text' name='startDate' id='startDate'  value='' maxlength='10' class='textbox' style='width: 90px;' title='Start Date'  readonly/>
                        End Date<span class="req"> *</span> :<input type='text' name='endDate' id='endDate'  value='' maxlength='10' class='textbox' style='width: 90px;' title='End Date'  readonly/>
                    </td>
                    
                  </tr> 
                  <tr>
                    <td style="text-align: right;font-size: 12px" >Feedback Of Speaker<span class="req"> *</span> :</td>
                    <td  style="text-align: left">
                        <select name="speakerFeedback" class='combo' id="speakerFeedback" title="Feedback Of Speaker" >
                                <option value="0">Select Feedback</option>
                                <option value="1">Fair</option>
                                <option value="2">Good</option>
                                <option value="3">Very Good</option>
                                <option value="4">Excellent</option>
                                <option value="5">Outstanding</option>
                              </select>
                    </td>
                   <td style="text-align: right;font-size: 12px" >Guest Participants Feedback<span class="req"> *</span> :</td>
                    <td  style="text-align: left">
                        <select name="guestParticipantsFeedback" class='combo' id="guestParticipantsFeedback" title="Guest Participants Feedback" >
                                <option value="0">Select Feedback</option>
                                <option value="1">Fair</option>
                                <option value="2">Good</option>
                                <option value="3">Very Good</option>
                                <option value="4">Excellent</option>
                                <option value="5">Outstanding</option>
                              </select>
                    </td>
                    
                  </tr> 
                  <tr>
                   <td style="text-align: right;font-size: 12px">Industrial Visit Feedback<span class="req"> *</span> :</td><td style='text-align: left'><input type='text' name='industrialVisitFeedback' id='industrialVisitFeedback' value='' maxlength='160' class='textbox'  title='Industrial Visit Feedback'/></td>
                   <td style="text-align: right;font-size: 12px" >Feedback Of Participants<span class="req"> *</span> :</td>
                    <td  style="text-align: left">
                        <select name="feedbackOfParticipants" class='combo' id="feedbackOfParticipants" title="Feedback Of Participants" >
                                <option value="0">Select Feedback</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                              </select>
                    </td>
                    
                  </tr>
                  <tr>
                      <td style="text-align: right;font-size: 12px" >Feedback Of Industry<span class="req"> *</span> :</td>
                    <td  style="text-align: left">
                        <select name="feedbackOfIndustry" class='combo' id="feedbackOfIndustry" title="Feedback Of Industry" >
                                <option value="0">Select Feedback</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                              </select>
                    </td>
                    <td style="text-align: right;font-size: 12px">Industrial Suggestions<span class="req"> *</span> :</td><td style='text-align: left'><input type='text' name='industrialSuggestions' id='industrialSuggestions' value='' maxlength='160' class='textbox'  title='Industrial Suggestions'/></td>
                    
                </tr> 
                 <tr>
                     <td style="text-align: right;font-size: 12px" >Overall Project Feedback<span class="req"> *</span> :</td>
                    <td  style="text-align: left">
                        <select name="overallProjectFeedback" class='combo' id="overallProjectFeedback" title="Overall Project Feedback">
                                <option value="0">Select Feedback</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                              </select>
                    </td>
                    <td style="text-align: right;font-size: 12px" >Feedback Of PI/CO-PI<span class="req"> *</span> :</td>
                    <td  style="text-align: left">
                        <select name="feedbackOfPICOPI" class='combo' id="feedbackOfPICOPI" title="Feedback Of PI/CO-PI">
                                <option value="0">Select Feedback</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                              </select>
                    </td>
                    
                </tr> 
                <tr>
                    <td style="text-align: right;font-size: 12px">Project Suggestions<span class="req"> *</span> :</td><td style='text-align: left'><input type='text' name='projectSuggestions' id='projectSuggestions' value='' maxlength='160' class='textbox'  title='Project Suggestions'/></td>
                    <td style="text-align: right;font-size: 12px" >Instructor Feedback<span class="req"> *</span> :</td>
                    <td  style="text-align: left">
                        <select name="instructorFeedback" class='combo' id="instructorFeedback" title="Instructor Feedback">
                                <option value="0">Select Feedback</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                              </select>
                    </td>
                    
                </tr> 
                <tr>
                    <td style="text-align: right;font-size: 12px" >Participants Feedback<span class="req"> *</span> :</td>
                    <td  style="text-align: left">
                        <select name="industryLedParticipantsFeedback" class='combo' id="industryLedParticipantsFeedback" title="Participants Feedback">
                                <option value="0">Select Feedback</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                              </select>
                    </td>
                   <td style="text-align: right;font-size: 12px">Resource Person Feedback<span class="req"> *</span> :</td><td style='text-align: left'><input type='text' name='resourcePersonFeedback' id='resourcePersonFeedback' value='' maxlength='160' class='textbox'  title='Resource Person Feedback'/></td>
                   
                </tr> 
                <tr>
                   <td style="text-align: right;font-size: 12px">Industry Led Suggestions<span class="req"> *</span> :</td><td style='text-align: left'><input type='text' name='industryLedSuggestions' id='industryLedSuggestions' value='' maxlength='160' class='textbox'  title='Industry Led Suggestions'/></td>
                   <td style="text-align: right;font-size: 12px">Remarks :</td><td style='text-align: left'><input type='text' name='remarks' id='remarks' value='' maxlength='160' class='textbox'  title='Remarks'/></td>
                </tr> 
                </table>
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
                <select id="pagging"  title='Select No. of Records Per Page' onchange="getSelectGridData(0)"  style="text-align:left" ></select>
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
                            }

                           
                                else {
                 out.print("<br><img src='../../Images/Error1.jpg'>");
                                out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
                            }
                        %>
    </body>
</html>
