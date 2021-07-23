<%-- 
    Document   : projectMaster
    Created on : Apr 28, 2015, 2:02:35 PM
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
        <script src="../js/IQTest/projectMasterJS.js"></script>
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
    </head>


    <%
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
            <input type="hidden" id="projectID"  value="0"/>
            <input type="hidden" id="entryBy"  value="<%=mChkMemID%>"/>
            <!-- Above Is  to handle  the session values   -->
            <div id="windowheader" class="ui-widget-header ui-corner-all div" style="width: 100%;height:28px"><div style="width: 60%;float: left;text-align: right;font-size: large">Sponsored R&D Project</div><div style="width: 35%;float: left;text-align: right;font-size: large">[Form:QA-AR-2]</div></div> 
            <div style="width: 99%; padding: 10px ;border: .3em solid;border-radius: 25px;" > 
                <table  id="commonmasterid" style="text-align: center;font-size: 18px; border:1px">
                    <tr>
                        <td style="text-align: right">Project Code<span class="req"> *</span> :</td><td style='text-align: left'><input type='text' name='projectCode' id='projectCode' value='' maxlength='20' class='textbox'  title='Project Code'/></td>
                        <td style="text-align: right">Project Title<span class="req"> *</span> :</td><td style='text-align: left'><input type='text' name='projectTitle' id='projectTitle' value='' maxlength='100' class='textbox'  title='Project Title'/></td>
                    </tr> 
                    <tr>
                        <td style="text-align: right">Project Grant Amount<span class="req"> *</span> :</td><td style='text-align: left'><input type='text' name='projectGrandAmount' id='projectGrandAmount' value='' maxlength='14' class='number'  title='Project Grant Amount'/></td>
                        <td style="text-align: right">Principal investigator/Co-Investigator<span class="req"> *</span> :</td><td style='text-align: left'><input type='text' name='projectAuthority' id='projectAuthority' value='' maxlength='100' class='textbox'  title='Project Authority'/></td>
                    </tr> 
                    <tr>
                        <td style="text-align: right">Sponsoring Authority<span class="req"> *</span> :</td><td style='text-align: left'><input type='text' name='sponsoredAuthority' id='sponsoredAuthority' value='' maxlength='100' class='textbox'  title='Sponsored Authority'/></td>
                        <td style="text-align: right">Department Name<span class="req"> *</span> :</td><td style="text-align: left"><select  name='departmentName' id='departmentName'  class='combo' style=''  title='Department Name'><%=ccd.commonJspCombo("{\"comboId\":\"departmentComboShortNameisNull\"}")%></select></td>
                    </tr> 
                    <tr>
                        <td style="text-align: right" >Project Type<span class="req"> *</span> :</td>
                        <td  style="text-align: left">
                            <select name="projectType" class='combo' id="projectType" title="Project Type" >
                                <option value="0">Select Program Type</option>
                                <option value="R">[R]esearch</option>
                                <option value="C">[C]onsultancies</option>
                            </select>
                        </td>
                        <td style="text-align: right">Project API Score :</td><td style='text-align: left'><input type='text' name='projectAPIScore' id='projectAPIScore' value='' maxlength='3' class='number'  title='Project API Score'/></td>
                    </tr> 
                    <tr>
                        <td style="text-align: right">Project Status Date<span class="req"> *</span> :</td><td style='text-align: left'><input type='text' name='projectStatusAsOnDate' id='projectStatusAsOnDate' value='' maxlength='100' class='date'  title='Project Status As On Date' onchange="getCheckProjectStatusOnDate()"/></td>
                        <td style="text-align: right">Project(% of work)<span class="req"> *</span> :</td><td style="text-align: left"><input type='text' name='projectPerStatus' id='projectPerStatus'  value='' maxlength='3' class='number' style='width: 90px;' title='Project(% of work)'  onchange="getProjectStatus()"/>
                            Project Status<span class="req"> *</span> :<input type='text' name='projectStatus' id='projectStatus'  value='' maxlength='10' class='textbox' style='width: 90px;' title='Project Status'  readonly/>
                        </td>
                    </tr> 
                    <tr>
                        <td style="text-align: right">Project Start Date<span class="req"> *</span> :</td><td style="text-align: left"><input type='text' name='projectStartDate' id='projectStartDate'  value='' maxlength='100' class='date' style='' title='Project Start Date' readonly /></td>
                        <td style="text-align: right">Project End Date<span class="req"> *</span> :</td><td style="text-align: left"><input type='text' name='projectEndDate' id='projectEndDate'  value='' maxlength='100' class='date' style='' title='Project End Date' readonly onchange="getDuration()"/></td>
                    </tr>
                    <tr>
                        <td style="text-align: right">Project Remarks :</td><td style='text-align: left'><input type='text' name='projectRemarks' id='projectRemarks' value='' maxlength='160' class='textbox'  title='Project Remarks'/></td>
                        <td style="text-align: right">Duration Of Project(In Months)<span class="req"> *</span> :</td><td style='text-align: left'><input type='text' name='durationOfProject' id='durationOfProject' value='' maxlength='100' class='textbox'  title='Duration Of Project(In Months)'/></td>
                    </tr>
                    <tr>
                     <!--  <td style="text-align:right">Collaborative Institute:</td<td style='text-align:left'><input type='text' name='CollaborativeInstitute' id='CollaborativeInstitute' value='' maxlength='100' title='CollaborativeInstitute'/></td>-->
                        <td style="text-align: right">Collaborative Institute :</td><td style='text-align: left'><input type='text' name='CollaborativeInstitute' id='CollaborativeInstitute' value='' maxlength='100' class='textbox'  title='CollaborativeInstitute'/></td>

                    </tr>
                    <tr>
                         <td style="text-align: right">First Year(Amount) :</td><td style="text-align: left"><input type='text' name='one' id='one'  value='' maxlength='10' class='number' style='width: 90px;' title='first Year'/></td>
                        <td style="text-align: right">Second Year(Amount) :</td><td style="text-align: left"><input type='text' name='two' id='two'  value='' maxlength='10' class='number' style='width: 90px;' title='Second Year'/></td>
                        <td style="text-align: right">Third Year(Amount) :</td><td style="text-align: left"><input type='text' name='three' id='three'  value='' maxlength='10' class='number' style='width: 90px;' title='Third Year'/></td>
                        
                    </tr> 
                    <tr>
                        <td style="text-align: right">Active Y/N<span class="req"> *</span> :</td><td td style="text-align: left"><input type='radio' name='active' id='activeY'  value='Y'  /> Yes<input type='radio' name='active' id='activeN'  value='N' title="Active Y/N"  />No</td>
                        
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
