<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.regex.*,Com.Jiit.TnP.*;" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp,java.lang.ArrayIndexOutOfBoundsException" %>
<%-- 
    Document   : ForStudentMessage
    Created on : Aug 30, 2014, 10:36:17 AM
    Author     : Gyanendra.Bhatt
--%>
<%!    Pattern p = Pattern.compile("^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\\.[a-zA-Z]{2,4}$");
    Matcher m;

    public boolean validateEmail(String email) {
        boolean b = false;
        try {
            m = p.matcher(email);
            b = m.matches();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return b;
    }
%>
<%
        int hh = 0;
        DBHandler db = new DBHandler();
        OLTEncryption enc = new OLTEncryption();
        String qrytt = "", Selected = "", stopmsg = "";
        String QERCLORR = "";
        String QERCLORRN = "";
        String qrysel = "";
        String xBcklog = "", xNoBcklog = "";
        String xgaplog = "", xNogaplog = "";
        int rsum = 0, ssum = 0, tsum = 0, usum = 0, vsum = 0, wsum = 0, i = 0, j = 0, k = 0, l = 0, m = 0, o = 0;
        String QrySet = "", QrySetC = "", QrySetCC = "", qry4 = "", qry2 = "", qry3 = "", xSet = "", mCritvales = "", mcolor = "#F2F2F2", QERCLOR = "", andor = "";
        String QryIns = "", msg = "", date1 = "", date2 = "", msgid1 = "Msg", smsg = "", msgid = "";
        ResultSet rs = null, rsSet = null, rsIns = null, rs4 = null, rsQERCLORR = null, rsQERCLORRN = null, rssel = null;
        ResultSet rst = null;
        ResultSet rsf = null;
        ResultSet rsd = null;
        ResultSet rs1 = null, rsQERCLOR = null, rs5 = null;
        ResultSet rs2 = null;
        ResultSet rsc = null;
        String qry = "", qryc = "", mSUBB = "", mSUBN = "", mLTP = "", qry1 = "", academic = "", academicyear = "", mMemberName = "";
        String qryt = "", Event = "", Programcode = "", Companycode = "";
        GlobalFunctions gb = new GlobalFunctions();
        String mRegCode = "", event = "", Academicyear = "";
        String mEXAMCODE = "", mSubjID = "", DataSublist = "", mProgCode = "", QryProgCode = "", companycode = "";
        String mAcademicYear = "", program = "", programcode = "";
        String mProgramCode = "";
        String mInstCode = "";
        String mreg = "", mSemester = "";
        String mHOSTELTYPE = "", macade = "", mbranc = "", sem = "", semester = "", branch = "", branchcode = "";
        String mprog = "", enddate = "", fromdate = "";
        String mBranchCode = "", msid = "", mCode = "", mES = "", mSubj1 = "", qrysubj = "", Subject = "", mMemberType = "", mMemberCode = "";
        int n = 0, countI = 0, csst = 1;
        String qryx = "", mLTP1 = "", Branch = "", mProgram = "", mMemberID = "";
        ResultSet rsx = null, rs3 = null, RsF = null;
        String reqAction = "", qryF = "", mAcadmeicYear = "", mChkMemID = "";
        String mInst = "", mSubject = "", minst = "", qrys = "", Semester = "", qry5 = "";
        int rsum80t1 = 0, rsum80t2 = 0, rsum80t3 = 0, ssum70t1 = 0, ssum70t2 = 0, ssum70t3 = 0, tsum60t1 = 0, tsum60t2 = 0, tsum60t3 = 0,
                usum50t1 = 0, usum50t2 = 0, usum50t3 = 0, vsum40t1 = 0, vsum40t2 = 0, vsum40t3 = 0, wsum30t1 = 0, wsum30t2 = 0, wsum30t3 = 0;
        int count = 0, Flag = 0, slno = 0;
        String deletemessage = "";
        deletemessage = request.getParameter("deletemessage") == null ? "" : request.getParameter("deletemessage").trim();
        String event1 = "", company = "", mName = "", mDMemberCode = "";

        int ttsum1 = 0, ttsum2 = 0, ttsum3 = 0;

        if (session.getAttribute("InstituteCode") == null) {
            mInst = "";
        } else {
            mInst = session.getAttribute("InstituteCode").toString().trim();
        }
        if (session.getAttribute("CurrentSem") == null) {
            mSemester = "";
        } else {
            mSemester = session.getAttribute("CurrentSem").toString().trim();
        }
        if (session.getAttribute("BranchCode") == null) {
            mBranchCode = "";
        } else {
            mBranchCode = session.getAttribute("BranchCode").toString().trim();
        }
        if (session.getAttribute("AcademicYearCode") == null) {
            mAcadmeicYear = "";
        } else {
            mAcadmeicYear = session.getAttribute("AcademicYearCode").toString().trim();
        }
        if (session.getAttribute("ProgramCode") == null) {
            mProgram = "";
        } else {
            mProgram = session.getAttribute("ProgramCode").toString().trim();
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





        if (session.getAttribute("MemberName") == null) {
            mName = "";
        } else {
            mName = session.getAttribute("MemberName").toString().trim();
        }


        try {
            if (!mMemberID.equals("") && !mMemberType.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) {  //2

                mChkMemID = enc.decode(session.getAttribute("MemberID").toString().trim());
                String mChkMType = enc.decode(session.getAttribute("MemberType").toString().trim());
                String mIPAddress = session.getAttribute("IPADD").toString().trim();
                String mMacAddress = " "; //session.getAttribute("IPADD").toString().trim();
                String mRole = enc.decode(session.getAttribute("ROLENAME").toString().trim());
                ResultSet RsChk = null;
                //-----------------------------
                //-- Enable Security Page Level
                //-----------------------------
                qry = "Select WEBKIOSK.ShowLink('276','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";
                RsChk = db.getRowset(qry);
                if (RsChk.next() && RsChk.getString("SL").equals("Y")) {
                    //----------------------
                    try {

                        mDMemberCode = enc.decode(mMemberCode);
                        mMemberID = enc.decode(mMemberID);
                        mMemberType = enc.decode(mMemberType);
                    } catch (Exception e) {
                        out.println(e.getMessage());
                    }
//out.print(mChkMemID+"--"+mMemberID);
%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html;" charset="UTF-8">
        <title>Employee Page</title>
        <link type="text/css" rel="StyleSheet" href="css/Css_ForStudentMessage.css" />
        <script type="text/javascript" src="js/Css_ForStudentMessage.js"></script>
        <script type="text/javascript" src="sh/jquery-1.4.2.min.js"></script>
        <script type="text/javascript" src="sh/jquery.searchabledropdown-1.0.8.min.js"></script>
        <script type="text/javascript" src="js/sortabletable.js"></script>
        <script src="jquery/jquery-1.10.2.js"></script>
        <script src="jquery/jquery-ui.js"></script>
        <link rel="stylesheet" href="css/jquery-ui.css">
        <script src="js/jquery-1.10.2.js"></script>
        <script src="js/jquery-ui.js"></script>
        <link rel="stylesheet" href="css/style.css">
        <script language='JavaScript' type='text/JavaScript'>

            //disabe right click
            var tenth = '';

            function ninth() {
                if (document.all) {
                    (tenth);
                    // alert("Right Click Disable");
                    return false;
                }
            }

            function twelfth(e) {
                if (document.layers || (document.getElementById && !document.all)) {
                    if (e.which == 2 || e.which == 3) {
                        (tenth);
                        return false;
                    }
                }
            }
            if (document.layers) {
                document.captureEvents(Event.MOUSEDOWN);
                document.onmousedown = twelfth;
            } else {
                document.onmouseup = twelfth;
                document.oncontextmenu = ninth;
            }
            document.oncontextmenu = new Function(' return false')


            $(function() {
                $("#save_button").click(function () {
                    if($("#j").val()>0)
                    {

                        $( ".popUp_SAVE" ).dialog({
                            dialogClass: "noClose",
                            position: { my: "center top", at: "center top", of: window },
                            autoOpen: true,
                            closeOnEscape: false,
                            modal: true,
                            draggable: false,
                            hide: {
                                effect: "explode",
                                duration: 1000
                            }});
                    }});
            });


            function depeletePopup (msg) {
                $( ".popUp_DELETE" ).dialog({
                    dialogClass: "noClose",
                    position: { my: "center top", at: "center top", of: window },
                    autoOpen: true,
                    closeOnEscape: false,
                    modal: true,
                    draggable: false,
                    hide: {
                        effect: "explode",
                        duration: 1000
                    }});
            }
        </script>
        <script language="javascript" type="text/javascript">
            /* disable f5*/
            $(document).bind('keydown keyup', function(e) {
                if(e.which === 116) {
                    console.log('blocked');
                    return false;
                }
                if(e.which === 82 && e.ctrlKey) {
                    console.log('blocked');
                    return false;
                }
            });
        </script>

        <script type="text/javascript">
$(document).ready(function(){
    $("#msg").blur(function(){
        var msgLength=$("#msg").val().length;
     //alert(msgLength);
        if(msgLength>=291)
        {
          
                var diff=msgLength-291;
                alert("Message length should be less than or equals to 300!Please adjust the extra or minimize the "+diff+" characters");
                return false;
         }
    });
 });


            $(document).ready(function(){
                $("#back").html("<input type=button style='background-color:#88000 ;border-color:black;font-weight:Bold; FONT-FAMILY: Arial; FONT-SIZE: 10pt;color: black; HEIGHT: 25px; VERTICAL-ALIGN: top; WIDTH: 95px;margin-right:2.5%' value=<<<Back>");
                $('#back').click(function(){
                    parent.history.back();
                    return false;
                });
            });
            $(document).ready(function(){
                //alert("Gyan");
                var deleteRow=$("#dMsg").val();

                $("#showdeletemessage").text(""+deleteRow+"").show();
                $( "#showdeletemessage" ).text(""+deleteRow+"").show().fadeOut(5000);
                //document.getElementById("dMsg").value="";
            });

            $(document).ready(function(){
                //alert("Gyan");
                var saveRow=$("#sMsg").val();
                // alert(deleteRow);
                $("#showsuccessmessage").text(""+saveRow+"").show();
                $( "#showsuccessmessage" ).text(""+saveRow+"").show().fadeOut(5000);
                //document.getElementById("sMsg").value="";
            });

            $(document).ready(function(){
                //alert("Gyan");
                var saveRow=$("#stopmsg").val();
                // alert(deleteRow);
                $("#showstopmessage").text(""+saveRow+"").show();
                $( "#showstopmessage" ).text(""+saveRow+"").show().fadeOut(1000);
                //document.getElementById("sMsg").value="";
            });


            function getCurrentDateTime()
            {
                var currentDate;
                var retDateTime;
                currentDate = new Date();
                retDateTime=""+currentDate.getDate()+currentDate.getMonth()+currentDate.getFullYear()+currentDate.getHours()+currentDate.getMinutes()+currentDate.getSeconds();
                return retDateTime;
            }


            /*--------------select box for academic year-------------------------*/


            $(document).ready(function(){
                $("#Inst").click(function(){
                    $.ajax({
                        type: 'POST',
                        timeout: 50000,
                        url: 'Info_StudentMessage.jsp?sid=1&instid='+$("#Inst").val(),
                        beforeSend: function(){
                         $("#Academic_Year").append("Please Wait...");
                        },
                        success: function(res) {
                            var res=res.split("@");

                            $("#Academic_Year").empty();
                            $("#Academic_Year").append(res[0]);
                            document.getElementById("years").value=res[1];

                        },
                        error : function (){
                            alert("Error to get academicyear");
                        }
                    });
                });});


            /*--------------select box for academic year-------------------------*/

            /*--------------select box for program code-------------------------*/
            $(document).ready(function(){
                $("#Academic_Year").click(function(){
                    $.ajax({
                        type: 'POST',
                        timeout: 50000,
                       url: 'Info_StudentMessage.jsp?sid=2&instid='+$("#Inst").val()+'&academicyear='+$("#Academic_Year").val(),
                        success: function(res) {
                            var res=res.split("@");
                            $("#prog").empty();
                            $("#prog").append(res[0]);
                            document.getElementById("programs").value=res[1];

                        },
                        error : function (){
                            alert("Error to get program code");
                        }
                    });
                });});

            /*--------------select box for program code-------------------------*/
   /*--------------select box for branch code-------------------------*/
            $(document).ready(function(){
                $("#prog").click(function(){
                    $.ajax({
                        type: 'POST',
                        timeout: 50000,
                        url: 'Info_StudentMessage.jsp?sid=3&instid='+$("#Inst").val()+'&academicyear='+$("#Academic_Year").val()+'&program='+$("#prog").val(),
                        beforeSend: function(){
                         $("#Branch_Code").append("Please Wait...");
                        },
                        success: function(res) {
                            var res=res.split("@");
                            //alert(res[0]+"#"+res[1]);
                            //     document.getElementById("programs").value=res[1];
                            $("#Branch_Code").empty();
                            $("#Branch_Code").append(res[0]);
                            document.getElementById("branches").value=res[1];

                        },
                        error : function (){
                            alert("Error to get program code");
                        }
                    });
                });});

            /*--------------select box for branch code-------------------------*/



        </script>
        <script type="text/javascript">
            $(function() {
                $( "#date1" ).datepicker();
            });
            $(function() {
                $( "#date2" ).datepicker();
            });
        </script>



    </head>
    <body>
        <div id="back" name="back"></div>
        <div id="heading" name="Heading">
            <center>
                <h1>Create Company Detail For Students</h1>
            </center>
        </div>
        <div id="form-body1" name="Form_Body" align="center">
            <div class="popUp_SAVE" title="Please Wait..." style="display:none;">
                <p>Please wait ,while your record is saving.</p>
            </div>
            <div class="popUp_DELETE" title="Please Wait..." style="display:none;">
                <p>Please wait ,while your record is deleting.</p>
            </div>
            <form name="Student_Detail" id="stud_detail" action="ForStudentMessage.jsp" method="post"  onsubmit="return stop_reload();">
                <input type="hidden" name="y" id="y">
                <br>
                <table class="Entry_Form">
                    <tr>
                        <td valign="top" algin="right" class="headingsTD" nowrap height="120px;" ><font class="Formheadings">Institute</font><font color="red" size="2">*</font></td>
                        <td algin="left" valign="top" width="40%" height="120px;"><font class="Formheadings">&nbsp;&nbsp;&nbsp;&nbsp;</font>
                            <Select name="Institute" id="Inst" MULTIPLE style="width:72px;" onclick="return allInst();">
                                <option  id="all_inst" name="all_inst" value="">All</option>
                                <%
           qry = "select distinct  nvl(INSTITUTECODE,'') INSTITUTECODE from studentmaster";
           rs = db.getRowset(qry);
           if (request.getParameter("y") == null) {
               while (rs.next()) {
                   ++n;
                                %>
                                <option  value="<%=rs.getString("INSTITUTECODE").trim()%>" id="insti<%=n%>" name="insti"><%=rs.getString("INSTITUTECODE").trim()%></option>
                                <%
                                    }
                                } else {
                                    while (rs.next()) {
                                        ++n;
                                %>
                                <option  value="<%=rs.getString("INSTITUTECODE").trim()%>" id="insti<%=n%>" name="insti"><%=rs.getString("INSTITUTECODE").trim()%></option>
                                <%
               }
           }

                                %>
                            </Select>
                            <input type="hidden" name="N" id="N" value="<%=n%>">
                            <input type="hidden" name="j" id="j" value="">
                        </td>
                        <td valign="top" algin="right" class="headingsTD" nowrap height="120px;" ><font class="Formheadings">Academic Year</font><font color="red" size="2">*</font></td>
                        <td align="left" valign="top" width="40%" height="120%" height="120px;"  >
                            <font class="Formheadings">&nbsp;&nbsp;&nbsp;&nbsp;</font>
                            <Select name="AcademicYear" id="Academic_Year" MULTIPLE style="width:72px;" onclick="return allAcademic();">
                                <option  value="" name="all_year" id="all_year">All</option>
                                <%n = 0;
           qry = "SELECT  academicyear  FROM (select  distinct academicyear from studentmaster   order by academicyear desc) where rownum<=10";
           rs = db.getRowset(qry);
           if (request.getParameter("y") == null) {
               while (rs.next()) {
                   ++n;
                                %>
                                <option  value="<%=rs.getString("academicyear").trim()%>" name="acad_year" id="acad_year<%=n%>"><%=rs.getString("academicyear").trim()%></option>
                                <%
                                     }
                                 } else {
                                     while (rs.next()) {
                                         ++n;
                                %>
                                <option  value="<%=rs.getString("academicyear").trim()%>" name="acad_year" id="acad_year<%=n%>"><%=rs.getString("academicyear").trim()%></option>
                                <%
               }
           }

                                %>
                            </Select>
                            <input type="hidden" name="years" id="years" value="<%=n%>">
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" algin="right" class="headingsTD" nowrap height="120px;" ><font class="Formheadings">Program Code</font><font color="red" size="2">*</font></td>
                        <td algin="left" valign="top" width="40%" height="120px;"  ><font class="Formheadings">&nbsp;&nbsp;&nbsp;&nbsp;</font>
                            <Select name="Program" id="prog" MULTIPLE style="width:72px;" onclick="return allProgram();">
                                <option value="" name="all_prog" id="all_prog">All</option>
                                <%try {
               n = 0;
               qry = " select distinct nvl(programcode,'') programcode from studentmaster  order by programcode";
               rs = db.getRowset(qry);
               if (request.getParameter("y") == null) {
                   while (rs.next()) {
                       ++n;

                                %>
                                <option  value="<%=rs.getString("programcode").trim() == null ? "" : rs.getString("programcode").trim()%>" name="prog" id="prog<%=n%>"><%=rs.getString("programcode").trim() == null ? "" : rs.getString("programcode").trim()%></option>
                                <%
                                     }
                                 } else {
                                     while (rs.next()) {
                                         ++n;
                                %>
                                <option value="<%=rs.getString("programcode").trim() == null ? "" : rs.getString("programcode").trim()%>" name="prog" id="prog<%=n%>"><%=rs.getString("programcode").trim() == null ? "" : rs.getString("programcode").trim()%></option>
                                <%
                   }
               }
           } catch (Exception e) {
               out.print("Error is " + e);
           }
                                %>
                            </Select>
                        <input type="text" name="xyz" id="xyz" value="">
                        <input type="hidden" name="programs" id="programs" value="<%=n%>">
                        </td>
                        
                        <td valign="top" algin="right" class="headingsTD" nowrap height="120px;" ><font class="Formheadings">Branch Code</font><font color="red" size="2">*</font></td>

                        <td align="left" valign="top" width="40%" height="120px;" >
                            <font class="Formheadings">&nbsp;&nbsp;&nbsp;&nbsp;</font>
                            <Select name="BranchCode" id="Branch_Code" MULTIPLE style="width:72px;" onclick="return allBranch();">
                                <option nmae="all_branch" id="all_branch" value="">All</option>
                                <%try {
               n = 0;
               qry = " select distinct nvl(branchcode,'') branchcode from studentmaster order by branchcode";
               rs = db.getRowset(qry);
               if (request.getParameter("y") == null) {
                   while (rs.next()) {
                       ++n;
                                %>
                                <option  value="<%=rs.getString("branchcode").trim()%>" name="branch" id="branch<%=n%>" ><%=rs.getString("branchcode").trim()%></option>
                                <%
                                     }
                                 } else {
                                     while (rs.next()) {
                                         ++n;
                                %>
                                <option  value="<%=rs.getString("branchcode").trim()%>" name="branch" id="branch<%=n%>"><%=rs.getString("branchcode").trim()%></option>
                                <%
                   }
               }
           } catch (Exception e) {
               out.print("Error is " + e);
           }
                            %></Select>
                           <input type="hidden" name="wsx" id="wsx" value="">
                            <input type="hidden" name="branches" id="branches" value="<%=n%>">
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" algin="right" class="headingsTD" nowrap height="120px;"><font class="Formheadings">Message Box</font><font color="red" size="2">*</font></td>
                        <td algin="left" valign="top" width="80%" colspan="4" height="120px;"><font class="Formheadings">&nbsp;&nbsp;&nbsp;</font>
                            <textarea rows="6" cols="53" name="Message" id="msg"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" algin="right" class="headingsTD" nowrap  ><font class="Formheadings">Display From Date</font><font color="red" size="2">*</font></td>
                        <td algin="left" valign="top" width="40%" height="30px;"  ><font class="Formheadings">&nbsp;&nbsp;&nbsp;&nbsp;</font>
                            <input type="text" name="date1" id="date1"class="dates" onblur="return iSValidSubmissionDate1(date1.value);"/>

                        </td>
                        <td valign="top" algin="right" class="headingsTD" nowrap  ><font class="Formheadings">To Date</font><font color="red" size="2">*</font></td>
                        <td align="left" valign="top" nowrap>
                            <font class="Formheadings">&nbsp;&nbsp;&nbsp;&nbsp;</font>
                            <input type="text" name="date2" id="date2" class="dates" onblur="return iSValidSubmissionDate2(date2.value);"/> <font class="SubHeadings">(DD-MM-YYYY)</font>
                        </td>
                    </tr>
                </table>
                <br>
                <div id="footer" name="Footer">
                    <center>
                        <input type="button" name="SaveButton" id="save_button" value="Save" class="lastbutton" onclick="return validate(); ">
                        <input type="Reset" name="ResetButton" id="reset_button" class="lastbutton" value="Reset">
                    </center>
                </div>

            </form>

            <%try {
               if (request.getParameter("y") != null) {
                   qry = "select nvl(to_char(max(to_number(substr(messageid,'4')))+1),'0') messageid from TP#STUDENTMESSAGE";
                   //out.print(qry);
                   rs = db.getRowset(qry);
                   if (rs.next()) {
                       msgid = msgid1 + rs.getString("messageid");
                   }
                   String institute[] = request.getParameterValues("Institute");
                   for (i = 0; i < institute.length; i++) {
                       if (!institute[i].equals("")) {
                           String academicYear[] = request.getParameterValues("AcademicYear");
                           for (j = 0; j < academicYear.length; j++) {
                               if (!academicYear[j].equals("")) {
                                   String programCode[] = request.getParameterValues("Program");
                                   for (k = 0; k < programCode.length; k++) {
                                       if (!programCode[k].equals("")) {
                                           String branchCode[] = request.getParameterValues("BranchCode");
                                           for (l = 0; l < branchCode.length; l++) {

                                               if (!branchCode[l].equals("")) { //out.print("INSTITUTE : "+institute[i]+" ACADEMIC YEAR : "+academicYear[j]+" Program Code : "+programCode[k]+" Branch Code : "+branchCode[l]+"<br>");
                                                   msg = request.getParameter("Message") == null ? "" : request.getParameter("Message").trim();
                                                   date1 = request.getParameter("date1") == null ? "" : request.getParameter("date1").trim();
                                                   date2 = request.getParameter("date2") == null ? "" : request.getParameter("date2").trim();
                                                   qry = "SELECT  'Y'   FROM TP#STUDENTMESSAGE A  where A.MESSAGEID='" + msgid + "' and A.ACADEMICYEARCODE='" + academicYear[j] + "'" +
                                                           " and A.BRANCHCODE='" + branchCode[l] + "' and A.INSTITUTECODE='" + institute[i] + "' and A.PROGRAMCODE='" + programCode[k] + "'";
                                                   // out.print(qry);
                                                   rs = db.getRowset(qry);
                                                   if (!rs.next()) {
                                                       qry1 = "INSERT INTO TP#STUDENTMESSAGE ( TODATE, PROGRAMCODE, MESSAGEID, MESSAGEDETAIL," +
                                                               " INSTITUTECODE, FROMDATE,ENTRYDATE,ENTRYBY,DEACTIVE, BRANCHCODE, " +
                                                               "ACADEMICYEARCODE) values(to_date('" + date2 + "','dd-mm-yyyy'),'" + programCode[k] + "','" + msgid + "','" + msg + "'" +
                                                               ",'" + institute[i] + "',to_date('" + date1 + "','dd-mm-yyyy'),sysdate,'" + mChkMemID + "','N','" + branchCode[l] + "'" +
                                                               ",'" + academicYear[j] + "') ";
                                                     //  out.print(qry1);
                                                       m = db.insertRow(qry1);
                                                   }
                                               }
                                           }
                                       }
                                   }
                               }
                           }
                       }
                   }


                   if (m > 0) {
                       smsg = "Your message has been saved successfully";
                   // out.print("<center><font color=green></font></center>");
                   } else if (o > 0) {
                       stopmsg = "This message already created";
            %>
            <input type="hidden" name="stopmsg" id="stopmsg" value="<%=stopmsg%>"/>
            <div id="showstopmessage" align="center" style="color:red;" ></div><%
                }%>




            <input type="hidden" name="sMsg" id="sMsg" value="<%=smsg%>"/>
            <div id="showsuccessmessage" align="center" style="color:green;" ></div>
            <%
    }%>

            <div id="heading" name="Heading">
                <center>
                    <h1>Your All messages For Students</h1>
                </center>
            </div>
            <div id="old_msg" name="OldMsg">
                <table name="ForUpdateMsg" id="forupdate_msg" align="center" rules="all" border="1" width="80%" style="table-layout:fixed;">
                    <tr>
                        <th align="left" width="5%">Sr No.</th>
                        <th align="left" width="55%">Message</th>
                        <th align="left" width="10%">Delete</th>
                    </tr>
                    <%i = 0;
    qry = "SELECT distinct nvl(MESSAGEDETAIL,'') MESSAGEDETAIL,nvl(MESSAGEID,'') msgid  FROM TP#STUDENTMESSAGE" +
            " WHERE entryby='" + mChkMemID + "'  order by to_number(substr(msgid,4)) asc ";
    //out.print(qry);
    rs = db.getRowset(qry);
    while (rs.next()) {
        ++i;
        String msg_detail = rs.getString("MESSAGEDETAIL") == null ? "" : rs.getString("MESSAGEDETAIL").trim();
        String msg_id = rs.getString("msgid") == null ? "" : rs.getString("msgid").trim();
                    %><tr>
                        <td align="left" width="5%">
                            <%=i%>
                        </td><td align="left" width="65%" style="overflow: hidden;"><%=msg_detail%></td>
                        <input type="hidden" name="msg_det" id="msg_det<%=i%>" value="<%=msg_id%>"/>
                        <td align="left" width="10%" >
                        <a href="" id="msgDelete<%=i%>" name="msgDelete" onclick="deleteMsg(msg_det<%=i%>.value),depeletePopup(msgDelete<%=i%>);">delete</a></td>
                    </tr><%
    }%><input type="hidden" name="msg_no" id="msg_no" value="<%=i%>"/>
                </table>
            </div>
            <input type="hidden" name="dMsg" id="dMsg" value="<%=deletemessage%>"/>
            <div id="showdeletemessage" align="center" style="color:green;" ></div>
            <%deletemessage = "";
           //out.print("<center><font color=green>"+deletemessage+"</font></center>");
           } catch (Exception e) {
               out.print("Error for getting values : " + e);
           }
            %>
        </div>

        <%//-----------------------------
    //---Enable Security Page Level
    //-----------------------------
    } else {
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
        } catch (Exception e) {
        }

    %></body>
</html>
