 <%--
    Document   : IT Services

    Author     : Vivek Soni
--%>


<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%@page import="jilit.db.CommonComboData"%>
<%
  CommonComboData ccd=new CommonComboData();

        DBHandler db = new DBHandler(); 
        ResultSet rs = null;
        ResultSet rs1 = null;
        GlobalFunctions gb = new GlobalFunctions();
        int mSno = 0, TotInboxItem = 0;
        String qry = "", qry1 = "", mDepartmentCode = "", mDesigcode = "", mTime1 = "",date="",mExamid="",Feedbackid="",mEmpcode="";
        String mColor = "Green", mComp = "", TRCOLOR = "White", mWebEmail = "";
        String mMemberID = "", mDMemberID = "", mMemberType = "", mDMemberType = "",minstcode="";
        String mMemberCode = "", mDMemberCode = "", mMemberName = "";
        String mInst = "", myFlag = "0";String examcode="",instcode="";
        String mFactType = "", mDesig = "", mDepartment = "",minst="",xexamcode="",feedbackcode="",mfeedbackcid="";
        int mChk = 0;
       if (session.getAttribute("InstituteCode")==null)
	{
		mInst="";
	}
	else
	{
		mInst=session.getAttribute("InstituteCode").toString().trim();
	}
    if(session.getAttribute("Employeecode")==null) {
mEmpcode="";

      }else
{

mEmpcode=session.getAttribute("Employeecode").toString().trim();

}
//out.print(mEmpcode);




        //   out.print(mDMemberID + "@@@@@" + mComp + "###" + mInst + "$$$$$" + mDepartment + "^^^^" + mDesig + "%%%%%" + mDepartmentCode + "****" + mDesigcode);

%>



<!DOCTYPE HTML>

<html>
   <head>
			<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
			<link rel="stylesheet" href="../css/Style.css">
			<link rel="stylesheet" href="../css/jquery-ui.css"/>

			<style type="text/css">
				html, body{ margin: 0; border: 0 none; padding: 0;    }
				html, body, #wrapper, #left, #right {  margin-top: auto }
				#wrapper { margin: 0 auto;  width: 960px;  }
				#mastergrid  tr:nth-child(even) {background: #F8F8F8;cursor:pointer;padding:8px; border:#999 1px solid; }
				#mastergrid tr:nth-child(odd) {background: 	#EBF5FF;cursor:pointer;padding:8px; border:#999 1px solid; }
				#mastergrid td { padding:5px; border:#999 1px solid; }
				#mastergrid1 th { padding:5px; border:#999 1px solid; }
				#mastergrid :hover, .applicantclass:focus, .applicantclass:active{background: skyblue !important;}

			</style>
			<script src="../js/jquery/jquery-1.10.2.js"></script>
			<script src="../js/jquery/jquery-ui.js"></script>
			<script src="../js/jquery/yattable.js"></script>
			<script src="../js/IQTest/jQuery.print.js"></script>
            <script src="../js/IQTest/IQACReport.js"></script>

            </head> 
<body>
       
                <div id="windowheader" class="ui-widget-header ui-corner-all div" style="height:95px" >
                    <FONT SIZE="2" COLOR="black" style="color:black">
                            Form:QA-AR-Form 7</FONT><br>
                         <B><FONT SIZE="4" COLOR="black" style="margin-left:30%" >Institute Academic Quality Assurance Cell
                         <FONT SIZE="2" COLOR="black" style="margin-left:10%" >Frequency: Every Year</FONT><br>
                          <B><FONT SIZE="4" COLOR="black" style="margin-left:20%">Academic(Research)</FONT><FONT SIZE="2" COLOR="black" style="margin-left:13%">Date-</FONT><br>
                          <B><FONT SIZE="4" COLOR="black" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                          Feedback IT Services Summary Report View</FONT></B>
                </div>
                <div style="width: 90%; padding: 10px ;border: .3em solid;border-radius: 25px;margin-left:8%;margin-rigth:5%" >
                   <!-- <form name="frm1" method="post">
                    <input id="xx" name="xx" type=hidden>  -->
                    <table  id="commonmasterid" style="text-align: left;;font-size: 18px; border:1px;width: 100%;">

                        <tr>
                             <td style="text-align: right" width="10%">Institute Code<span class="req"> *</span> :</td>
                            <td width="25%"><select  name='instcode' id='instcode'  class='combo' style='width:50%'  title='instcode'>
                           <OPTION  Value ="NONE"><--Select Inst--></option>
                           <OPTION  Value ="ALL">ALL</option> 
                          <% try
                        {
                    qry="Select  distinct nvl(INSTITUTECODE,'')INSTITUTECODE from institutemaster ";
                    rs=db.getRowset(qry);




                        while(rs.next())
                        {
                            instcode=rs.getString("INSTITUTECODE");


                            %>
                            <OPTION  Value =<%=instcode%>><%=instcode%></option>
                            <%
                        }
                        %>

                        <%


                }
                catch(Exception e)
                {
                    //out.println(e.getMessage());
}%>}

                           </select>

                            </td>
                            
                           <!---------new aded------------------------------->

                           <td style="text-align: center" width="10%">EventCode<span class="req"> *</span> :</td>
                            <td width="40%">
         <select  name='EventCombo' id='EventCombo'  class='combo' style='width:80%'  title='Exam Code'>
                          <%=ccd.commonJspCombo("{\"comboId\":\"EventCombo\"}")%></select>

                            </td> 
                            
          <input type="hidden"  value='<%=mEmpcode%>' name="userid" id="userid">
                                
 <td align="left"  style="text-align: center"  colspan="4" nowrap >
 



          &nbsp; &nbsp; &nbsp;
<button name="submitButton_FacultySummary" id="ITServicesSummary"  class="button" style="width:120px;height:25px;margin-left:120px;">Generate Report</button>
                            </td>
                        </tr>
                    </table>
                    <!--</form> -->
                </div>
               <div id="reportpart"></div>
