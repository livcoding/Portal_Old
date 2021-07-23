<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>  
<%
        DBHandler db = new DBHandler();
        ResultSet rs = null;
        ResultSet rs1 = null;
        GlobalFunctions gb = new GlobalFunctions();
        int mSno = 0, TotInboxItem = 0;
        String qry = "", qry1 = "", mDepartmentCode = "", mDesigcode = "", mTime1 = "";
        String mColor = "Green", mComp = "", TRCOLOR = "White", mWebEmail = "";
        String mMemberID = "", mDMemberID = "", mMemberType = "", mDMemberType = "";
        String mMemberCode = "", mDMemberCode = "", mMemberName = "";
        String mInst = "", myFlag = "0";String examcode="";
        String mFactType = "", mDesig = "", mDepartment = "",minst="";
        int mChk = 0;
       
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
        <!-- Above Is  to handle  the session values   -->


              <!--tr><td colspan="3" width="300" style="color:red;">This cell is 300px wide</td>
<td colspan="2" width="400" style="color:blue;">This cell is 400px wide</td></ tr-->
                

                <div id="windowheader" class="ui-widget-header ui-corner-all div" style="height:95px" >
                    <FONT SIZE="2" COLOR="black" style="color:black">
                            Form:QA-AR-Form 7</FONT><br>
                         <B><FONT SIZE="4" COLOR="black" style="margin-left:30%" >Institute Academic Quality Assurance Cell
                         <FONT SIZE="2" COLOR="black" style="margin-left:10%" >Frequency: Every Year</FONT><br>
                          <B><FONT SIZE="4" COLOR="black" style="margin-left:20%">Academic(Research)</FONT><FONT SIZE="2" COLOR="black" style="margin-left:13%">Date-</FONT><br>
                          <B><FONT SIZE="4" COLOR="black" >FacultyFeedBackCount Report View</FONT></B>
                </div>
                <div style="width: 90%; padding: 10px ;border: .3em solid;border-radius: 25px;margin-left:8%;margin-rigth:5%" >
                    <table  id="commonmasterid" style="text-align: left;;font-size: 18px; border:1px;width: 100%;">
                        <tr>
                            <td style="text-align: right" width="10%">ExamCode<span class="req"> *</span> :</td>
                            <td width="40%"><select  name='examcode' id='examcode'  class='combo' style='width:80%'  title='Exam Code'>
                           <OPTION  Value =""><--Select Examcode--></option>
                          <% try
                        {
                    qry="Select Distinct NVL(examcode,' ')examcode from AP#FEEDBACKSUBJECTTAGGING where  nvl(Deactive,'N')='N'  order by examcode desc ";
                    rs=db.getRowset(qry);
                  
                        

                        
                        while(rs.next())
                        {
                            examcode=rs.getString("examcode");
                            
                           
                            %>
                            <OPTION  Value =<%=examcode%>><%=examcode%></option>
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
                            <td style="text-align: right" width="10%">LTP<span class="req"> *</span> :</td>
                            <td width="40%">
                                <select  name='LTP' id='LTP'  class='combo' style='width:80%'  title='LTP'>
                                    <option value="">Select LTP</option>
                                    <option value="ALL">ALL</option>
                                    <option value="L">L</option>
                                    <option value="P">P</option>
                                </select>
                                </td>  </tr>
                                <tr>
                                    <td colspan="3" nowrap>
                                        <font style="margin-left:4%">
                                Select Report Type
                               <input type="radio" name="Feedback" id="Feedback1" value="Y" > FeedBack Given
                               <input type="radio" name="Feedback" id="Feedback2" value="N">Not Given
                          </font>
                          </td>
                     
                       
                       
                            <td style="text-align: right"  colspan="4" nowrap>
<button name="submitButton_FacultyCount" id="submitButton_FacultyCount"  class="button" style="width:120px;height:25px;margin-left:140px;">Generate Report</button>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="reportpart"></div>
