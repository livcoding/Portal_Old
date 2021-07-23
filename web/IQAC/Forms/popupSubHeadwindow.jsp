<%-- 
    Document   : popupSubHeadwindow
    Created on : Feb 7, 2015, 3:50:52 PM
    Author     : nipun.gupta
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
        <script src="../js/IQTest/FacultyQuestionHeadJS.js"></script>
        <script>
            $(document).ready(function() {
              getSubHeadData("<%= request.getParameter("parentheadid")%>");
            });
        </script>

    </head>
    <body>
        
        <%
            String noOfSubHead = request.getParameter("noofsubhead");
            String parentheadID = request.getParameter("parentheadid");
        %>
        <form name="masterform" >
            <table id="mastergrid1" style="width: 100%;font-size: 18px;text-align: center;" >
                <thead id="gridhead"><th style='width: 5%'></th><th style='width: 25%'>Head Code</th><th style='width: 25%'>Head Description</th><th style='width: 25%'>Weightage </th><th style='width: 20%'>Seq ID</th></thead>
            </table>

            <table id="mastergrid" style="width: 100%; font-size: 15px;text-align: center;word-wrap: break-word;overflow: scroll" >
                <%for (int x = 1; x <= Integer.parseInt(noOfSubHead); x++) {%>
                
                
                <tbody id="gridbody">
                    <tr><td style="width: 5%"><input type="checkbox" id="noofsubheadcheckbox<%=x%>"/></td><td style="width: 25%"><input type="hidden" id="headid<%=x%>" name="headid<%=x%>" value="0"><input type="text" id="headcode<%=x%>"/></td><td style="width: 25%"><input type="text" id="headdesc<%=x%>"/></td><td style="width: 25%"><input type="text" id="weigtage<%=x%>"/></td><td style="width: 20%"><input type="text" id="seqid<%=x%>"/></td>
                </tbody>
                <%}%>
                
            </table>
                <input type="button" title='Save Record'  class="button" id="finalSaveForm" style="cursor:pointer;margin-left: 60%" onclick="formsubmitsubHead(<%=noOfSubHead%>,'<%=parentheadID%>')" value="Save">
        
        </form>
    </body>
</html>
