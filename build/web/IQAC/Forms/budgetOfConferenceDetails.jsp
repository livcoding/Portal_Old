<%-- 
    Document   : budgetOfConferenceDetails
    Created on : 10 JUN, 2017, 4:08:50 PM
    Author     : ASHISH KUMAr
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
        <script src="../js/IQTest/budgetOfConferenceDetailsJS.js"></script>
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
            <input type="hidden" id="organizingSecretaryName"  value="0"/>
            <input type="hidden" id="hodApproval"  value="0"/>
            <input type="hidden" id="vcApproval"  value="0"/>
            <input type="hidden" id="budgetID"  value="0"/>
            <input type="hidden" id="departmentCode"  value="0"/>
            <!-- Above Is  to handle  the session values   -->
            <div id="windowheader" class="ui-widget-header ui-corner-all div" style="height:28px " >Budget Of Conference Details</div> 
            <div style="width: 99%; padding: 10px ;border: .3em solid;border-radius: 25px;" > 
                <table  id="commonmasterid" style="text-align: center;font-size: 18px; border:1px">
                    <tr>
                        <td style="text-align: right">Department Name<span class="req"> *</span> :</td><td style="text-align: left"><Input type="text"  name='departmentName' id='departmentName'  class='textbox' style=''  title='Department Name' readonly/></td>
                        <td style="text-align: right">Proposed Conference Name<span class="req"> *</span> :</td><td style='text-align: left'><input type='text' name='proposedConferenceName' id='proposedConferenceName' value='' maxlength='160' class='textbox'  title='Proposed Conference Name' readonly/></td>
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

                        <td style="text-align: right">Supporting Org. Name :</td><td style='text-align: left'><input type='text' name='supportingOrgName' id='supportingOrgName' value='' maxlength='60' class='textbox'  title='Supporting Org. Name'/></td>
                    </tr> 
                    <tr>
                        <td style="text-align: right">Supporting Org. Amount :</td><td style='text-align: left'><input type='text' name='supportingOrgAmount' id='supportingOrgAmount' value='' maxlength='12' class='number'  title='Supporting Org. Amount'/></td>
                        <td style="text-align: right">Receipt Type:</td><td style='text-align: left'><input type='text' name='receiptType' id='receiptType' value='' maxlength='60' class='textbox'  title='Supporting Org. Name'/></td>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Receipt Code:</td><td style="text-align: left"><select  name='receiptCode' id='receiptCode'  class='combo' style=''  title='Receipt Code' onchange="getReceiptName()"><%=ccd.commonJspCombo("{\"comboId\":\"receiptCodeCombo\"}")%></select></td>
                        <td style="text-align: right">Receipt Name:</td><td style='text-align: left'><input type='text' name='receiptName' id='receiptName' value='' maxlength='160' class='textbox'  title='Receipt Name'/></td>
                    </tr> 
                    <tr>
                        <td style="text-align: right">Receipt No. :</td><td style='text-align: left'><input type='text' name='receiptNo' id='receiptNo' value='' maxlength='5' class='nondecimal'  title='Receipt No' onblur="getReceiptAmount()"/></td>
                        <td style="text-align: right">Receipt Value :</td><td style='text-align: left'><input type='text' name='receiptValue' id='receiptValue' value='' maxlength='14' class='number'  title='Receipt Value' onblur="getReceiptAmount()"/></td>
                    </tr> 
                    <tr>
                        <td style="text-align: right">Receipt Amount :</td><td style='text-align: left'><input type='text' name='receiptAmount' id='receiptAmount' value='' maxlength='14' class='number'  title='Receipt Amount'/></td>
                        <td style="text-align: right">Expenditure Type:</td><td style='text-align: left'><input type='text' name='expenditureType' id='expenditureType' value='' maxlength='60' class='textbox'  title='Expenditure Type'/></td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Expenditure Code:</td><td style="text-align: left"><select  name='expenditureCode' id='expenditureCode'  class='combo' style=''  title='Expenditure Code' onchange="getExpenditureName()"><%=ccd.commonJspCombo("{\"comboId\":\"expenditureCodeCombo\"}")%></select></td>
                        <td style="text-align: right">Expenditure Name :</td><td style='text-align: left'><input type='text' name='expenditureName' id='expenditureName' value='' maxlength='160' class='textbox'  title='Expenditure Name'/></td>
                    </tr> 
                    <tr>
                        <td style="text-align: right">Expenditure No.:</td><td style='text-align: left'><input type='text' name='expenditureNo' id='expenditureNo' value='' maxlength='5' class='nondecimal'  title='Expenditure No' onblur="getExpenditureAmount()"/></td>
                        <td style="text-align: right">Expenditure Value :</td><td style='text-align: left'><input type='text' name='expenditureValue' id='expenditureValue' value='' maxlength='14' class='number'  title='Expenditure Value' onblur="getExpenditureAmount()"/></td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Expenditure Amount:</td><td style='text-align: left'><input type='text' name='expenditureAmount' id='expenditureAmount' value='' maxlength='14' class='number'  title='Expenditure Amount'/></td>
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

