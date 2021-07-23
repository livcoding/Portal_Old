<%--
    Document   : ParentReport
    Created on : Apr 13, 2015, 10:34:48 AM
    Author     : Gyanendra.Bhatt+Biju Bhargav
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>


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
        <script src="../js/IQTest/PublicationReportJS.js"></script>
        <!--script src="../js/IQTest/IQACReport.js"></script-->
    </head>


    <body>
        <!-- Above Is  to handle  the session values   -->
        <div id="windowheader" class="ui-widget-header ui-corner-all div" style="height:95px;" >
            <FONT SIZE="2" COLOR="black" style="margin-left:70%;">
            Form:QA-SR-6</FONT><br>
            <B><FONT SIZE="4" COLOR="black" style="margin-left:33%;" >Institute Academic Quality Assurance Cell</FONT></B>
            <FONT SIZE="2" COLOR="black" style="margin-left:14%;" >Frequency-Every Semester Jan/July</FONT><br>
            <B><FONT SIZE="4" COLOR="black" style="margin-left:24%;">Academic (Research)</FONT><FONT SIZE="2" COLOR="black" style="margin-left:22%">Date-</FONT></B><br>
            <B><FONT SIZE="4" COLOR="black" > <u>Summary of  Publications</u></FONT></B>

        </div>
        <br>   <br>
        <div style="width: 90%; padding: 10px ;border: .3em solid;border-radius: 25px;margin-left:4%" >
            <table  id="commonmasterid" style="text-align: left;font-size: 18px; border:1px;width:90%">
                <tr>
                    <td style="text-align: right" width="10%">Company<span class="req"> *</span> :</td>
                    <td width="40%">
                        <select  name='company' id='company'  class='combo' style='width:100%'  title='Company Code'>
                            <option value="" selected>Select Company</option>
                            <%
                            DBHandler db=new DBHandler();
                            String qry="";
                            ResultSet rs=null;
                            try
                            {
                            qry="select distinct nvl(a.companycode,'')companycode,nvl(a.companyname,'') companyname from companymaster a,ap#arpublicationtrn b where a.COMPANYCODE=b.COMPANYID";
                            rs=db.getRowset(qry);
                            while(rs.next()){
                                String company=rs.getString("COMPANYCODE");
                                String companyname=rs.getString("companyname");
                            %>
                            <option value="<%=company %>"> <%=company %> </option>
                            <%

                            }
                            }catch(Exception e){
                                e.printStackTrace();
                               }

                            %>
                        </select>
                        <% //out.print(qry); %>
                    </td>
                    <td style="text-align: right" width="10%" >Institute<span class="req"> *</span> :</td>
                    <td width="40%" >
                        <select  name='institute' id='institute'  class='combo' style='width:100%'  title='Institute'>
                            <option value="">Select Institute</option>
                       </select>
                    </td>
                </tr>
                <tr>
                    <td width="10%" align="right" nowrap>Publication Year<span class="req"> *</span> :</td>
                    <td width="40%">
                    <select  name='publicationyear' id='publicationyear'  class='combo' style='width:50%'  title='Publication Year'>
                            <option value="">Select Publication Year</option> <!-- select distinct ACADEMICYEAR from ACADEMICYEARMASTER -->
                    </select>
                    </td>
                    <td width="10%" align="right" nowrap>Department<span class="req"> *</span> :</td>
                    <td width="40%">
                    <select  name='Department' id='Department'  class='combo' style='width:70%'  title='Department'>
                            <option value="">Select Department </option> <!-- select distinct ACADEMICYEAR from ACADEMICYEARMASTER -->
                    </select>
                    </td>
                </tr>
                <tr><td width="10%" align="right" nowrap>Report<span class="req"> *</span> :</td><td width="40%" align="left" nowrap>
                        &nbsp;&nbsp;&nbsp;Publication Wise<input type="radio" name="wise" id="wise1" value="P">
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Faculty Wise<input type="radio" name="wise" id="wise2" value="F">
                    </td>
               </tr>
                  <tr>
                    <td style="text-align: center;" width="100%" colspan="4" nowrap>
                    <div id="Public"> <font id="publ" size="2" >Publication<span class="req"> *</span> :</font>
                    <select  name='Publication' id='Publication'  class='combo' style='width:50%'  title='Publication'>
                    <option selected value="">Select Publication</option>

                    <%--
                    qry="select distinct nvl(a.publicationid,'') publicationid,nvl(a.publicationcode,'') publicationcode," +
                            "nvl(a.title,'') title  from ap#publicationmaster a,ap#arpublicationtrnauthor b where " +
                            "a.PUBLICATIONID=b.PUBLICATIONID and a.PUBLICATIONCODE=b.PUBLICATIONCODE and a.COMPANYID=b.COMPANYID" +
                            " order by publicationcode";
                    rs=db.getRowset(qry);
                    while(rs.next())
                    {%>
                    <option value=<%=rs.getString("publicationid")%>><%=rs.getString("publicationcode")+"-"+rs.getString("title")%></option>
                    <%}

                   --%>
                    </select></div>
                    <div id="fac">
                    <font id="staff" size="2" >Faculty<span class="req"> *</span> :</font>
                     <select  name='Faculty' id='Faculty'  class='combo'  style='width:25%'  title='Faculty'>
                            <option value="">Select Faculty</option>
                     </select></div>
                    </td>  
                        <!--button name="submitbutton" id="submitbutton"  class="button" style="width:120px;height:25px;margin-left:140px;">Generate Report</button-->
                    </td>
                </tr>
            </table>
        </div>
        <br>
        <div id="reportpart"></div>
    </body>
</html>
