<%-- 
    Document   : feedbackOfConference
    Created on : Aug 13, 2015, 11:00:12 AM
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
            #mastergrid_Budget  tr:nth-child(even) {background: #F8F8F8;cursor:pointer;padding:8px; border:#999 1px solid; }
            #mastergrid_Budget tr:nth-child(odd) {background: 	#EBF5FF;cursor:pointer;padding:8px; border:#999 1px solid; }
            #mastergrid_Budget td { padding:5px; border:#999 1px solid; }
            #mastergrid1_Budget th { padding:5px; border:#999 1px solid; text-wrap:normal; }
            #mastergrid_Budget :hover, .applicantclass:focus, .applicantclass:active   {
                background: skyblue !important;}
            #mastergrid_Feedback  tr:nth-child(even) {background: #F8F8F8;cursor:pointer;padding:8px; border:#999 1px solid; }
            #mastergrid_Feedback tr:nth-child(odd) {background: 	#EBF5FF;cursor:pointer;padding:8px; border:#999 1px solid; }
            #mastergrid_Feedback td { padding:5px; border:#999 1px solid; }
            #mastergrid1_Feedback th { padding:5px; border:#999 1px solid; text-wrap:normal; }
            #mastergrid_Feedback :hover, .applicantclass:focus, .applicantclass:active   {
                background: skyblue !important;}
            #recExpGrid  tr:nth-child(even) {background: #F8F8F8;cursor:pointer;padding:8px; border:#999 1px solid; }
            #recExpGrid tr:nth-child(odd) {background: 	#EBF5FF;cursor:pointer;padding:8px; border:#999 1px solid; }
            #recExpGrid td { padding:5px; border:#999 1px solid; }
            #recExpGrid1 th { padding:5px; border:#999 1px solid; text-wrap:normal; }
            #recExpGrid :hover, .applicantclass:focus, .applicantclass:active   {
                background: skyblue !important;}
            #conferenceNameTable  tr:nth-child(even) {background: #F8F8F8;cursor:pointer;padding:8px; border:#999 1px solid; }
            #conferenceNameTable tr:nth-child(odd) {background: 	#EBF5FF;cursor:pointer;padding:8px; border:#999 1px solid; }
            #conferenceNameTable :hover, .highlight:focus,highlight:active   {
                background: skyblue !important;}

        </style>
        <script src="../js/jquery/jquery-1.10.2.js"></script>
        <script src="../js/jquery/jquery-ui.js"></script>
        <script src="../js/jquery/yattable.js"></script>
        <script src="../js/jquery/numeric-1.0.js"></script>
        <script src="../js/IQTest/CommonServiceJs.js"></script>
        <script src="../js/IQTest/ComboJs.js"></script>
        <script src="../js/IQTest/feedbackOfConferenceJS.js"></script>
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
            });
        </script>
    </head><%
        String mInst = "", mComp = "", mSrcType = "";
        String mInstitute = "";
        request.getParameter("");
        ResultSet RsChk=null;
       DBHandler db=new DBHandler();
       CommonComboData ccd=new CommonComboData();
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
            <input type="hidden" id="conferenceID"  value="0"/>
            <input type="hidden" id="entryBy"  value="<%=mChkMemID%>"/>
            <input type="hidden" id="keyNoteSpeakersNo"  value="0"/>
            <input type="hidden" id="keyNoteSpeakersNames"  value="0"/>
            <input type="hidden" id="invitedSpeakerNo"  value="0"/>
            <input type="hidden" id="invitedSpeakerNames"  value="0"/>
            <input type="hidden" id="conferenceStartDate"  value="0"/>
            <input type="hidden" id="conferenceEndDate"  value="0"/>
            <input type="hidden" id="budgetID"  value="0"/>
            <input type="hidden" id="departmentCode"  value="0"/>
            <input type="hidden" id="feedbackID"  value="0"/>
            <!-- Above Is  to handle  the session values   -->
            <div id="windowheader" class="ui-widget-header ui-corner-all div" style="height:28px " >Feedback Of Conference</div> 
            <div style="width: 99%; padding: 10px ;border: .3em solid;border-radius: 25px;" > 
                <table  id="commonmasterid" style="text-align: center;font-size: 18px; border:1px">
                    <tr>
                        <td style="text-align: right;width:150px">Conference Name<span class="req"> *</span> :</td><td style='text-align: left'><input type='text' name='actualConferenceName' id='actualConferenceName' value='' maxlength='160' class='textbox'  title='Actual Conference Name' readonly tabindex="1"/></td>
                        <td style="text-align: right">Expenditure Code :</td><td style="text-align: left"><select  name='expenditureCode' id='expenditureCode'  class='combo' style=''  title='Expenditure Code' tabindex="9" onchange="getExpenditureName()"><%=ccd.commonJspCombo("{\"comboId\":\"expenditureCodeCombo\"}")%></select></td>
                        <td style="text-align: right">Receipt Code :</td><td style="text-align: left"><select  name='receiptCode' id='receiptCode'  class='combo' style=''  title='Receipt Code' onchange="getReceiptName()" tabindex="17"><%=ccd.commonJspCombo("{\"comboId\":\"receiptCodeCombo\"}")%></select></td>
                    </tr> 
                    <tr>
                        <td style="text-align: right" >Type Of Conference<span class="req"> *</span> :</td>
                        <td  style="text-align: left">
                            <select name="typeOfConference" class='combo' id="typeOfConference" title="Type Of Conference" tabindex="2">
                                <option value="0">Select Type Of Conference</option>
                                <option value="I">International</option>
                                <option value="N">National</option>
                            </select>
                        </td>
                        <td style="text-align: right">Expenditure Name  :</td><td style='text-align: left'><input type='text' name='expenditureName' id='expenditureName' value='' maxlength='160' class='textbox'  title='Expenditure Name' readonly tabindex="10" /></td>
                         <td style="text-align: right">Receipt Name:</td><td style='text-align: left'><input type='text' name='receiptName' id='receiptName' value='' maxlength='160' class='textbox'  title='Receipt Name' readonly tabindex="18"/></td>
                    </tr> 
                    <tr>
                        <td style="text-align: right">Org. Secretary<span class="req"> *</span>:</td><td style='text-align: left'><input type='text' name='organizingSecretary' id='organizingSecretary' value='' maxlength='60' class='textbox'  title='Name Of Organizing Secretary' tabindex="3"/></td>
                        <td style="text-align: right">Expenditure Type:</td><td style='text-align: left'><input type='text' name='expenditureType' id='expenditureType' value='' maxlength='60' class='textbox'  title='Expenditure Type' readonly tabindex="11"/></td>
                        <td style="text-align: right">Receipt Type:</td><td style='text-align: left'><input type='text' name='receiptType' id='receiptType' value='' maxlength='60' class='textbox'  title='Receipt Type' readonly tabindex="19"/></td>
                    </tr> 
                    <tr>
                        <td style="text-align: right">Supp. Org. Name :</td><td style='text-align: left'><input type='text' name='supportingOrgName' id='supportingOrgName' value='' maxlength='60' class='textbox'  title='Supporting Org. Name' tabindex="4"/></td>
                        <td style="text-align: right">Expenditure No.:</td><td style='text-align: left'><input type='text' name='expenditureNo' id='expenditureNo' value='' maxlength='5' class='nondecimal'  title='Expenditure No' onblur="getExpenditureAmount()" tabindex="12"/></td>
                        <td style="text-align: right">Receipt No :</td><td style='text-align: left'><input type='text' name='receiptNo' id='receiptNo' value='' maxlength='14' class='number'  title='Receipt No' onblur="getReceiptAmount()" tabindex="20"/></td>
                        
                    </tr> 
                    <tr>
                        <td style="text-align: right">Supp. Org. Amount :</td><td style='text-align: left'><input type='text' name='supportingOrgAmount' id='supportingOrgAmount' value='' maxlength='12' class='number'  title='Supporting Org. Amount' tabindex="5"/></td>
                        <td style="text-align: right">Expenditure Value:</td><td style='text-align: left'><input type='text' name='expenditureValue' id='expenditureValue' value='' maxlength='14' class='number'  title='Expenditure Value' onblur="getExpenditureAmount()" tabindex="13"/></td>
                       <td style="text-align: right">Receipt Value:</td><td style='text-align: left'><input type='text' name='receiptValue' id='receiptValue' value='' maxlength='14' class='number'  title='Receipt Value' onblur="getReceiptAmount()" tabindex="21"/></td>
                       
                         </td>
                    </tr>
                    <tr>
                       <td style="text-align: right">Department Name<span class="req"> *</span> :</td><td style="text-align: left"><Input type="text"  name='departmentName' id='departmentName'  class='textbox' style=''  title='Department Name' readonly tabindex="6"/></td>
                       <td style="text-align: right">Expenditure Amount:</td><td style='text-align: left'><input type='text' name='expenditureAmount' id='expenditureAmount' value='' maxlength='14' class='number'  title='Expenditure Amount' tabindex="14" readonly/></td> 
                       <td style="text-align: right">Receipt Amount:</td><td style='text-align: left'><input type='text' name='receiptAmount' id='receiptAmount' value='' maxlength='14' class='number'  title='Receipt Amount' tabindex="22" readonly/></td>
                       
                    </tr>
                   
                    <tr>
                        <td style="text-align: right">Specific Focus Area :</td><td style='text-align: left'><input type='text' name='specificFocusArea' id='specificFocusArea' value='' maxlength='60' class='textbox'  title='Specific Focus Area' tabindex="7"/></td>
                        <td style="text-align: right">Objectives :</td><td style="text-align: left"><Input type="text"  name='objectives' id='objectives' maxlength='160' class='textbox' style=''  title='Objectives' tabindex="15"/></td>
                        <td style="text-align: right">Actual Budget<span class="req"> *</span> :</td><td style="text-align: left"><Input type="text"  name='actualBudget' id='actualBudget' maxlength='14' class='number' style=''  title='Actual Budget' tabindex="23"/></td>
                        

                    </tr>
                    <tr>
                        
                        <td style="text-align: right">Approval of HOD<span class="req"> *</span> :</td><td style="text-align: left"><input type='radio' name='approvalOfHOD' id='approvalOfHODY'  value='Y'  /> Yes<input type='radio' name='approvalOfHOD' id='approvalOfHODN'  value='N' tabindex="8"/> No</td>
                        <td style="text-align: right">Approval of VC<span class="req"> *</span> :</td><td td style="text-align: left"><input type='radio' name='approvalOfVC' id='approvalOfVCY'  value='Y'  /> Yes<input type='radio' name='approvalOfVC' id='approvalOfVCN'  value='N' tabindex="16"/>No</td>
                        <td style="text-align: right">Actual Outcomes:</td><td style='text-align: left'><input type='text' name='actualOutComes' id='actualOutComes' value='' maxlength='160' class='textbox'  title='Actual Outcomes' tabindex="24"/></td>
                    </tr>
                </table>
            </div>
            <div  style="text-align:left;width:100%;" id="finalsave">
            <table id="recExpGrid1" style="width: 100%;font-size: 18px;text-align: center;table-layout:fixed;" ><thead id="recExpHead"></thead></table>
            <table id="recExpGrid" style="width: 100%;font-size: 18px;text-align: center;table-layout:fixed;word-wrap: break-word" ><tbody id="recExpGridBody"></tbody></table>
           </div>
            <div class="ui-widget-header ui-corner-all" style="text-align:left;width:100%;" id="finaldivsave">
                <input type="button" title='Save Record'  class="button" id="okForm" style="cursor:pointer;margin-left: 80%" onclick="displayGridData()" value="OK">
                <input type="button" title='Save Record'  class="button" id="finalSaveForm1" style="cursor:pointer" onclick="formsubmit()" value="Save">
                <input type="button"  title='Reset Fields'  class="button" id="finalSaveForm2" style="cursor:pointer;" onclick=" resetValues()" value="Reset">
                <input type="button" title='Exit Form'  class="button" id="finalSaveForm3" style="cursor:pointer;" onClick="history.go(-1);" value="Exit">
            </div>
             <div id="tabs">
                     <ul>
                         <li><a href="#tabs-1"><b>Conference Actual Budget</b></a></li>
                         <li><a href="#tabs-2"><b>Conference Feedback</b></a></li>
                     </ul>
                     <div id="tabs-1">
                         <div>
                             <table id="mastergrid1_Budget" style="width: 100%;font-size: 15px;text-align: center;table-layout:fixed;" ><thead id="gridhead_Budget"></thead></table>
                             <table id="mastergrid_Budget" style="width: 100%;font-size: 15px;text-align: center;table-layout:fixed;word-wrap: break-word" ><tbody id="gridbody_Budget"></tbody></table>
                         </div>

                     </div>
                     <div id="tabs-2">
                         <div>
                             <table id="mastergrid1_Feedback" style="width: 100%;font-size: 15px;text-align: center;table-layout:fixed;" ><thead id="gridhead_Feedback"></thead></table>
                             <table id="mastergrid_Feedback" style="width: 100%;font-size: 15px;text-align: left;table-layout:fixed;word-wrap: break-word" ><tbody id="gridbody_Feedback"></tbody></table>
                         </div>
                     </div>
                 </div>
            <div class="ui-widget-header ui-corner-all" style="width:100%;" >
               <select id="pagging"  title='Select No. of Records Per Page' onchange="getSelectGridData(0)"  style="margin-left: 80%" ></select>
            </div> 
            
        </form>
                        <div id="conferenceNames" title="Conference Names" style="overflow: auto;height: 300px">
                            <div class="ui-widget-header ui-corner-all" style="font-size:13px;text-align:left;width:100%;" >
                                Search:<input type="text" id="searchNames">
                                <span id="TOTAL" style="font-size:13px;alignment-adjust: auto;padding-left: 20%"> </span>
                                <select id="paggingPopUp"   onchange="getConferenceNames(0)"  style="text-align:left" ></select>
                            </div>  
                            <table style="width: 100%;font-size: 18px;text-align: center;" id="popupHeaderTable">
                                <thead id="popupHeader">
                                </thead>
                            </table>
                            <table style="width: 100%;font-size: 18px;" id="conferenceNameTable">
                                <tbody id="conferenceNamesBody">

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

