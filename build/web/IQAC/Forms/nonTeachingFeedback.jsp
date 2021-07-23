<%-- 
    Document   : nonTeachingFeedback
    Created on : Apr 6, 2015, 12:58:42 PM
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
            #lowerGrid  tr:nth-child(even) {background: #F8F8F8;cursor:pointer;padding:8px; border:#999 1px solid; }
            #lowerGrid tr:nth-child(odd) {background: 	#EBF5FF;cursor:pointer;padding:8px; border:#999 1px solid; }
            #lowerGrid td { padding:5px; border:#999 1px solid; }
            #lowerGrid1 th { padding:5px; border:#999 1px solid; }
            #lowerGrid :hover, .applicantclass:focus, .applicantclass:active   {
                background: skyblue !important;}

        </style>
        <script src="../js/jquery/jquery-1.10.2.js"></script>
        <script src="../js/jquery/jquery-ui.js"></script>
        <script src="../js/jquery/yattable.js"></script>
        <script src="../js/jquery/numeric-1.0.js"></script>
        <script src="../js/IQTest/CommonServiceJs.js"></script>
        <script src="../js/IQTest/ComboJs.js"></script>
        <script src="../js/IQTest/nonTeachingFeedbackJS.js"></script>
        <script>
            $(document).ready(function() {
                 $(".date").datepicker({
                dateFormat: 'dd-mm-yy',
                changeMonth: true,
                changeYear: true,
                yearRange: '-100:+0'
            });
                getFeedBackID();
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
        ResultSet rs1=null;
       DBHandler db=new DBHandler();
       CommonComboData ccd=new CommonComboData();
         String mMemberID = "",mChkMemID="";
         String mMemberType ="",mChkMType="";
         String mMemberName = "",mRole="",mIPAddress="";
         String mMemberCode = "";
         String mRightsID = "",departmentNameDB="";
        
        
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
         String departmentCode=session.getAttribute("DepartmentCode").toString().trim();
         String memberName=session.getAttribute("MemberName").toString().trim();
         RsChk = null;
         
         String query="Select department from departmentmaster where departmentcode='"+departmentCode+"'";
         rs1=db.getRowset(query);
         if(rs1.next())
         {
           departmentNameDB=rs1.getString(1);
         }
         
         String qry = "Select WEBKIOSK.ShowLink('302','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";
         //out.print(qry);
         RsChk = db.getRowset(qry);
         if (RsChk.next() && RsChk.getString("SL").equals("Y")) {
        %>
        <form name="masterform" >
            <input type="hidden" id="compsession"  value="<%=mLoginComp%>"/>
            <input type="hidden" id="instsession"  value="<%=mInstitute%>"/>
            <input type="hidden" id="transactionID"  value="0"/>
            <input type="hidden" id="feedbackID"  value="0"/>
            <input type="hidden" id="entryBy"  value="<%=mChkMemID%>"/>
            
            
            <!-- Above Is  to handle  the session values   -->
            <div id="windowheader" class="ui-widget-header ui-corner-all div" style="width: 100%;height:28px"><div style="width: 60%;float: left;text-align: right;font-size: large">Non Teaching Feedback Transaction</div><div style="width: 35%;float: left;text-align: right;font-size: large">[Form:QA-SR-3]</div></div> 
            <div style="width: 99%; padding: 10px ;border: .3em solid;border-radius: 25px;" > 
                <table  id="commonmasterid" style="text-align: center;font-size: 18px; border:1px">
                    <tr>
                        <td style="text-align: right">Transaction Date<span class="req"> *</span> :</td><td style="text-align: left"><input type='text' name='transactionDate' id='transactionDate'  value='' maxlength='100' class='date' style='' title='Transaction Date' readonly/></td>
                    </tr> 
                    <tr>
                        <td style="text-align: right">Feedback ID<span class="req"> *</span> :</td><td style="text-align: left"><input type="text"  name='feedbackName' id='feedbackName'  class='textbox' style=''  title='Feedback Name' readonly></td>
                        <%--<td style="text-align: right">Department Name<span class="req"> *</span> :</td><td style="text-align: left"><select  name='departmentName' id='departmentName'  class='combo' style=''  title='Department Name'><%=ccd.commonJspCombo("{\"comboId\":\"departmentComboShortNameIsNotNull\"}")%></select></td>--%>
                        <%--<td style="text-align: right">Department Name<span class="req"> *</span> :</td><td style="text-align: left" id="dName"></td>--%>
                        <td style="text-align: right">Department Name<span class="req"> *</span> :</td><td style="text-align: left"><input type="text"  name='departmentName' id='departmentName'  class='textbox'  value="<%=departmentNameDB%>" style=''  title='Department Name' readonly></td>
                    </tr> 
                    
                    <tr>
                        <td style="text-align: right">Academic Year<span class="req"> *</span> :</td><td style="text-align: left"><select  name='academicYear' id='academicYear'  class='combo' style=''  title='Academic Year' onchange='getLowerGrid()'><%=ccd.commonJspCombo("{\"comboId\":\"academicyearcombo\"}")%></select></td>
                       <td style="text-align: right">Remarks :</td><td style='text-align: left'><input type='text' name='remarks' id='remarks' value='' maxlength='160' class='textbox'  title='Remarks'/></td>
                    </tr> 
                    <tr>
                        <td style="text-align: right">Member Name :</td><td style='text-align: left'><input type='text' name='memberName' id='memberName' value='<%=memberName%>' maxlength='160' class='textbox'  title='Member Name' readonly/></td>
                    </tr> 
                </table>
            </div>
            <div class="ui-widget-header ui-corner-all" style="text-align:left;width:100%;" id="finaldivsave">
                <input type="button" title='Save Record'  class="button" id="finalSaveForm" style="cursor:pointer;margin-left: 80%" onclick="formsubmit()" value="Save">
                <input type="button"  title='Reset Fields'  class="button" id="finalSaveForm" style="cursor:pointer;" onclick=" resetValues()" value="Reset">
                <input type="button" title='Exit Form'  class="button" id="finalSaveForm" style="cursor:pointer;" onClick="history.go(-1);" value="Exit"></div>
            <table id="mastergrid1" style="width: 100%;font-size: 18px;text-align: center;table-layout:fixed;" ><thead id="gridhead"></thead></table>
            <table id="mastergrid" style="width: 100%;font-size: 18px;text-align: left;table-layout:fixed;word-wrap: break-word" ><tbody id="gridbody"></tbody></table>
            <div class="ui-widget-header ui-corner-all" style="text-align:right;width:100%;" >
                <span id="TOT" style="font-size:15px;alignment-adjust: auto "> </span>
            </div>  
            <div  style="text-align:left;width:100%;" id="finalsave">
            <table id="lowerGrid1" style="width: 100%;font-size: 18px;text-align: center;table-layout:fixed;" ><thead id="gridLower"></thead></table>
            <table id="lowerGrid" style="width: 100%;font-size: 18px;text-align: center;table-layout:fixed;word-wrap: break-word" ><tbody id="gridLowerBody"></tbody></table>
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
