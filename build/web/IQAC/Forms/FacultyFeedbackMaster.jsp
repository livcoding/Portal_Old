<%-- 
    Document   : FacultyFeedbackMaster
    Created on : Jan 21, 2015, 10:41:30 AM
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
            #mastergrid1 th { padding:5px; border:#999 1px solid; }
            #mastergrid :hover, .applicantclass:focus, .applicantclass:active   {
                background: skyblue !important;}

        </style>
        <script src="../js/jquery/jquery-1.10.2.js"></script>
        <script src="../js/jquery/jquery-ui.js"></script>
        <script src="../js/jquery/yattable.js"></script>
         <script src="../js/IQTest/ComboJs.js"></script>
         <script src="../js/IQTest/FacultyFeedBackMasterJS.js"></script>
        <script>
            $(document).ready(function() {
                
                $(".date").datepicker({
                dateFormat: 'dd-mm-yy',
                changeMonth: true,
                changeYear: true,
                yearRange: '-100:+0'
            });
            getCommonMasterTable();
                
                $(document).tooltip({
                    track: true
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
            <input type="hidden" id="compsession"  value="UNIV"/>
            <input type="hidden" id="instsession"  value="JIIT"/>
            <input type="hidden" id="feedbackid"  value="0"/>
            <input type="hidden" id="entryBy"  value="<%=mChkMemID%>"/>
            <!-- Above Is  to handle  the session values   -->
            <div id="windowheader" class="ui-widget-header ui-corner-all div" style="height:28px " >Faculty Feedback Master</div> 
            <div style="width: 99%; padding: 10px ;border: .3em solid;border-radius: 25px;" > 
                <table  id="commonmasterid" style="text-align: left;font-size: 18px; border:1px">
                <tr>
                    <td style="text-align: right">Exam Code<span class="req"> *</span> :</td><td><select  name='examcode' id='examcode'  class='combo' style=''  title='Exam Code'><%=ccd.commonJspCombo("{\"comboId\":\"examcode\"}")%></select></td>
                </tr>   
                <tr>
                   <td style="text-align: right">Feedback Code<span class="req"> *</span> :</td><td><input type='text' name='feedbackcode' id='feedbackcode' value='' maxlength='20' class='textbox' style='' title='Feedback Code'/></td>
                   <td style="text-align: right">Feedback Description<span class="req"> *</span> :</td><td><input type='text' name='feedbackdesc' id='feedbackdesc' value='' maxlength='100' class='textbox' style='' title='Feedback Description'/></td>
                </tr>
                <tr>
                   <td style="text-align: right">EventFrom Date<span class="req"> *</span> :</td><td><input type='text' name='eventfromdate' id='eventfromdate'  value='' maxlength='100' class='date' style='' title='EventFrom Date' readonly/></td>
                   <td style="text-align: right">EventTo Date<span class="req"> *</span> :</td><td><input type='text' name='eventtodate' id='eventtodate'  value='' maxlength='100' class='date' style='' title='EventTo Date' readonly/></td>
                </tr>
                <tr>
                   <td style="text-align: right"></td><td><input type="checkbox" id="eventcompleted" name="eventcompleted" value="N">Event Completed<br></td>
                   <td style="text-align: right"></td><td><input type="checkbox" id="eventbroadcast" name="eventbroadcast" value="N">Event Broadcast</td>
                </tr>
                <tr>
                   <td style="text-align: right">Feedback Remarks<span class="req"> *</span> :</td><td><input type='text' name='feedbackremarks' id='feedbackremarks' value='' maxlength='100' class='textbox' style='' title='Feedback Remarks'/></td>
                </tr>
                </table>

            </div>
            <div class="ui-widget-header ui-corner-all" style="text-align:left;width:100%;" id="finaldivsave">
                <span style="font-size: 14px;margin-left: 2%">Search :</span> <input type="text" class="textbox" id="searchbox" title='Type and Search Into Grid'style="width: 120px"/>
                <input type="button" title='Save Record'  class="button" id="finalSaveForm" style="cursor:pointer;margin-left: 60%" onclick="formsubmit()" value="Save">
                <input type="button"  title='Reset Fields'  class="button" id="finalSaveForm" style="cursor:pointer;" onclick=" resetValues()" value="Reset">
                <input type="button" title='Exit Form'  class="button" id="finalSaveForm" style="cursor:pointer;" onClick="history.go(-1);" value="Exit"></div>
            <table id="mastergrid1" style="width: 100%;font-size: 18px;text-align: center;" ><thead id="gridhead"></thead></table>
            <table id="mastergrid" style="width: 100%; font-size: 15px;text-align: center;word-wrap: break-word;overflow: scroll" ><tbody id="gridbody"></tbody></table>
            <div class="ui-widget-header ui-corner-all" style="text-align:right;width:100%;" >
                <span id="TOT" style="font-size:15px;alignment-adjust: auto "> </span>
                <select id="pagging"  title='Select No. of Records Per Page' onchange="getSelectGridData(0)"  style="text-align:left" ></select>
                <input type='button'  class='button' id="first" value='|< First'  title='Jump to the First Page' >
                <input type='button'  title='Go to the Prev. Page'  class='button' id="previous" value='< Previous' >
                <input type='button'  title='Go to the Next Page'  class='button' id="next" value='Next >' >
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
                            }

                           
                                else {
                 out.print("<br><img src='../../Images/Error1.jpg'>");
                                out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
                            }
                        %>
    </body>
</html>

