<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.regex.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp,java.lang.ArrayIndexOutOfBoundsException" %>
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
        String qrytt = "", Selected = "";
        String QERCLORR = "";
        String QERCLORRN = "";
        String qrysel = "";
        String xBcklog = "", xNoBcklog = "";
        String xgaplog = "", xNogaplog = "";
        int rsum = 0, ssum = 0, tsum = 0, usum = 0, vsum = 0, wsum = 0;
        String QrySet = "", QrySetC = "", QrySetCC = "", qry4 = "", checkInst = "", qry2 = "", qry3 = "", xSet = "", mCritvales = "", mcolor = "#F2F2F2", QERCLOR = "", andor = "";
        String QryIns = "", studid = "";
        ResultSet rs = null, rsSet = null, rsIns = null, rs4 = null, rsQERCLORR = null, rsQERCLORRN = null, rssel = null;
        ResultSet rst = null;
        ResultSet rsf = null;
        ResultSet rsd = null;
        ResultSet rs1 = null, rsQERCLOR = null, rs5 = null;
        ResultSet rs2 = null;
        ResultSet rsc = null;
        String qry = "", qryc = "", mSUBB = "", mSUBN = "", mLTP = "", qry1 = "", inst = "", institute = "", academic = "", academicyear = "";
        String qryt = "", Event = "", Programcode = "", Companycode = "";
        GlobalFunctions gb = new GlobalFunctions();
        String mRegCode = "", event = "", Academicyear = "";
        String mEXAMCODE = "", mSubjID = "", DataSublist = "", mProgCode = "", QryProgCode = "", companycode = "";
        String mAcademicYear = "", program = "", programcode = "";
        String mProgramCode = "";
        String mInstCode = "";
        String mreg = "", mInstCode1 = "";
        String mHOSTELTYPE = "", macade = "", mbranc = "", sem = "", semester = "", branch = "", branchcode = "";
        String mprog = "", enddate = "", fromdate = "";
        String mBranchCode = "", msid = "", mCode = "", mES = "", mSubj1 = "", qrysubj = "", Subject = "";
        int n = 0, countI = 0, csst = 1;
        String qryx = "", mLTP1 = "", Branch = "";
        ResultSet rsx = null, rs3 = null, RsF = null;
        String reqAction = "", qryF = "";
        String mInst = "", mSubject = "", minst = "", qrys = "", Semester = "", qry5 = "", studentid = "";
        int rsum80t1 = 0, rsum80t2 = 0, rsum80t3 = 0, ssum70t1 = 0, ssum70t2 = 0, ssum70t3 = 0, tsum60t1 = 0, tsum60t2 = 0, tsum60t3 = 0,
                usum50t1 = 0, usum50t2 = 0, usum50t3 = 0, vsum40t1 = 0, vsum40t2 = 0, vsum40t3 = 0, wsum30t1 = 0, wsum30t2 = 0, wsum30t3 = 0;
        int count = 0, Flag = 0, slno = 0;

        String event1 = "", company = "";
        Event = request.getParameter("event12") == null ? "" : request.getParameter("event12").trim();
        Companycode = request.getParameter("company12") == null ? "" : request.getParameter("company12").trim();

        String studCat = request.getParameter("studentCatagory") == null ? "" : request.getParameter("studentCatagory").trim();
        //  out.print(event1+"----"+company);
        //qryF=" execute TP.POPTPQUALIFICATION ";
        //int xn=db.update(qryF);

//out.print(qry);



        int ttsum1 = 0, ttsum2 = 0, ttsum3 = 0;

        if (session.getAttribute("InstituteCode") == null) {
            mInst = "";
        } else {
            mInst = session.getAttribute("InstituteCode").toString().trim();
        }

%>
<HTML>
    <head>
        <TITLE>#### JIIT [Querry Criteria]</TITLE>
        <script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>


        <!-- jsProgressBarHandler core -->

        <script type="text/javascript">

            function enable_text()
            {
                if(document.getElementById("checkbox1").checked === true)
                {
                    document.getElementById("textbox1").disabled = false;
                }
                else{
                    document.getElementById("textbox1").disabled = true;
                }
            }



            /*Change By gyan(Start....)*/
            function select_All()
            {
                var slno_Total=document.getElementById("slno").value;
                var select_All=document.getElementById("all_Select").checked;
                if(select_All==true)
                {
                    for (var i=1;i<=slno_Total;i++)
                    {
                        document.getElementById("Select"+i).checked=true;
                    }
                }else if(select_All==false)
                {
                    for (var i=1;i<=slno_Total;i++)
                    {
                        document.getElementById("Select"+i).checked=false;
                    }
                }
            }






            /*change by gyan(End.....)*/











        </script>





        <script type="text/javascript" src="js/sortabletable.js"></script>
        <link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
        <script type="text/javascript" src="sh/jquery-1.4.2.min.js"></script>

        <script type="text/javascript" src="sh/jquery.searchabledropdown-1.0.8.min.js"></script>
        <script type="text/javascript">
            function getCurrentDateTime()
            {
                var currentDate;
                var retDateTime;
                currentDate = new Date();
                retDateTime=""+currentDate.getDate()+currentDate.getMonth()+currentDate.getFullYear()+currentDate.getHours()+currentDate.getMinutes()+currentDate.getSeconds();
                return retDateTime;
            }



            try{
                $(document).ready(function(){
                    $("#back").html("<input type=button style='background-color:#88000 ;border-color:black;font-weight:Bold; FONT-FAMILY: Arial; FONT-SIZE: 10pt;color: black; HEIGHT: 25px; VERTICAL-ALIGN: top; WIDTH: 95px;margin-right:2.5%' value=<<<Back>");
                    $('#back').click(function(){
                        parent.history.back();
                        return false;
                    });
                });

                window.onload =function(){
                    //alert($("#event").val()+"@@@@@@"+$("#companycode").val());
                    $.get("Set_QueryCriteria.jsp",{set:$("#Set").val(),event:$("#event").val(),comp:$("#companycode").val(),dt:getCurrentDateTime()},successfunction1);
                    forInstitute();
                }
            }catch(e)
            {
                alert(e);
            }

            function successfunction1(response)
            {
                if (response) {

                    var x=response+"";
                    //
                    if(x==""){}
                    else{
                        var arrayofSelectedset=x.split("@");
                        var selectedSet=arrayofSelectedset[0].replace(/^\s+|\s+$/gm,'');
                        var arrayOfStrings = arrayofSelectedset[3].split("$");
                        //  alert(selectedSet);
                        var y=$("#x").val();
                        $("select#Set").empty();

                        //$('select#Set').append("<option  value=\"" + "" + "\">" +"Select"+ "</option>");
                        for(var i=0;i<arrayOfStrings.length-1;i++){
                            var t=arrayOfStrings[i];
                            // alert(t+"@##"+selectedSet);

                            if(t==selectedSet)
                            {
                                $('select#Set').append("<option selected   value=\"" + selectedSet + "\">" + selectedSet+ "</option>");
                            }else{
                                $('select#Set').append("<option   value=\"" + t + "\">" + t+ "</option>");
                            }
                        }
                    }
                }

            }


            /*-----------------------End Function for set Criteria--------------------------------*/







            $(document).ready(function(){
                $("#value").html($("select#event :selected").text() + " (VALUE: " + $("select#event").val() + ")");
                $("select").change(function(){
                    $("#value").html(this.options[this.selectedIndex].text + " (VALUE: " + this.value + ")");

                    if(this.id=="event"){
                        //alert(this.id+"...."+this.value);
                        $.get("addcompanycode.jsp",{event:$("select#event").val(),dt:getCurrentDateTime()},successfunction);
                    }

                });
            });
            function successfunction(response)
            {
                if (response) {

                    var x=response+"";
                    //alert(x);
                    if(x==""){}
                    else{
                        var arrayOfStrings = x.split("$");
                        //alert(arrayOfStrings);
                        $("select#companycode").empty();
                        $('select#companycode').append("<option value=\"" + "" + "\">" +"Select"+ "</option>");
                        for(var i=0;i<arrayOfStrings.length-1;i++){
                            var t=arrayOfStrings[i];
                            $('select#companycode').append("<option selected value=\"" + t + "\">" + t+ "</option>");
                        }
                    }
                }

            }

            function vari()
            {
                var i=document.getElementById("event").value;
                var j=document.getElementById("companycode").value;
                var msg="";
                var k=0
                if(i==(""))
                {
                    msg="Event can not be left blank\n";
                    k++;
                }
                if(j==(""))
                {
                    msg=msg+"Company can not be left blank\n";
                    k++;
                }
                if(k>0)
                {
                    alert(msg);
                    return false;
                }
            }


        </script>
        <script type="text/javascript">

            function enable_text()
            {
                if(document.getElementById("checkbox1").checked === true)
                {
                    document.getElementById("textbox1").disabled = false;
                }
                else{
                    document.getElementById("textbox1").disabled = true;
                }
            }
        </script>

        <script>
            function verif(){
                try{

                    var n=0;
                    var messag="";
                    var insitute=false;

                    var i=document.getElementById("Set").value;
                    var studcat=document.getElementById("studentCatagory").value;
                    var check=document.getElementById("check").value;
                    //alert(check);
                    var insti="";
                    for(var j=0;j<check;j++)
                    {
                        insitute=document.getElementById("checkinst"+j).checked;

                        if(insitute==true){
                            // alert(j);
                            insti=document.getElementById("checkinst"+j).value;
                            //  alert(insti);
                            document.getElementById("insti"+j).value=insti;

                        }
                    }
                    if(insti=="")
                    {
                        n++;
                        messag="Select a Institue!";

                    }


                    if(i=="")
                    {
                        n++;
                        messag="Select a criteria!";
                    }
                    if(studcat=="")
                    {
                        n++;
                        messag="Select a Catagory!";
                    }


                    if(n>0)
                    {
                        alert(messag);
                        return false;
                    }else{

                        return true;
                    }
                }catch(e){
                    alert("ERRRRRRRRR : "+e);
                }}
        </script>



        <script type="text/javascript">
            var ray={
                ajax:function(st)
                {
                    this.show('load');
                },
                show:function(el)
                {
                    this.getID(el).style.display='';
                },
                getID:function(el)
                {
                    return document.getElementById(el);
                }
            }
        </script>
        <style type="text/css">
            #load{
                z-index:2;
                width:20%;
                height:40px;
                border-collapse:collapse;
                background:transparent;
                text-align:center;
                line-height:40px;
                font-family:"Trebuchet MS", verdana, arial,tahoma;
                font-size:15px;
                color:green;

            }
        </style>


    </head>
    <body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 id="criteriaBody" name="criteriaBody" leftmargin=0 topmargin=0 bottommargin=0  >

        <form name="frm"  method="post" >
            <script type="text/javascript">

                function enable_text()
                {
                    if(document.getElementById("checkbox1").checked === true)
                    {
                        document.getElementById("textbox1").disabled = false;
                    }
                    else{
                        document.getElementById("textbox1").disabled = true;
                    }
                }


                function enable_text2()
                {
                    if(document.getElementById("checkbox2").checked === true)
                    {
                        document.getElementById("textbox2").disabled = false;
                    }
                    else{
                        document.getElementById("textbox2").disabled = true;
                    }
                }

            </script>
            <input id="x" name="x" type=hidden>

            <div id="back" name="back" style="width:5%;margin-left:86%;"></div>

            <br>
            <table cellpadding=3 cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="95%" bgcolor="white">
                <tr bgcolor="silver">
                    <td colspan=0 align=middle>
                <font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><FONT SIZE="4" COLOR=""><B>T&P Querry Criteria </B></FONT></font></td></tr>
            </table>
            <br>
            <table cellpadding=3 cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="95%" bgcolor="white">

                <tr bgcolor="silver">
                    <td align="right"  >
                    <FONT face=Arial size=2><STRONG>Event:</STRONG></FONT></td><td><font style="margin-left:5%" size="3" color="white"><strong><%=Event%></strong></font></td>


                    <td nowrap align=right>
                    <FONT face=Arial size=2 ><STRONG>Company:</STRONG></FONT><font color=red face=arial size=2></td><td><font style="margin-left:5%" size="3" color="white"><strong><%=Companycode%></strong></font></td>

                </tr>
            </table>
            <%
        try {


            %>
            <br>
            <input type=hidden name="event" id="event" value="<%=Event%>"/>
            <input type=hidden name="companycode" id="companycode" value="<%=Companycode%>"/>
        </form>
        <form name=frm3 method=post id="frm3" onsubmit="return ray.ajax()"   >
            <input type=hidden name="event" id="event" value="<%=Event%>"/>
            <input type=hidden name="companycode" id="companycode" value="<%=Companycode%>"/>
            <%
                // if(request.getParameter("x")!=null) {


            %>

            <input type="hidden" name="x">
            <input type="hidden" name="xx">
            <table cellpadding=3 cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="95%" bgcolor="white">

                <tr bgcolor="silver">
                    <!-- <td class=tablecell align ="right"><B>Backlog Allowed:&nbsp;&nbsp;<input type="checkbox" name="checkbox1" id="checkbox1" value="Y" onclick="enable_text()">
    </B></td><td><INPUT TYPE="text"   name="textbox1" id="textbox1" disabled   style="background-color:#88000 ;border-color:black;font-weight:Bold; FONT-FAMILY: Arial; FONT-SIZE: 10pt;color: black; HEIGHT: 25px; VERTICAL-ALIGN: top; WIDTH: 50px" ></td>
    <td class=tablecell align ="right"><B>Gap Allowed:&nbsp;&nbsp;<input type="checkbox" name="checkbox2" id="checkbox2" value="Y" onclick="enable_text2()">
    </B></td><td><INPUT TYPE="text"   name="textbox2" id="textbox2" disabled   style="background-color:#88000 ;border-color:black;font-weight:Bold; FONT-FAMILY: Arial; FONT-SIZE: 10pt;color: black; HEIGHT: 25px; VERTICAL-ALIGN: top; WIDTH: 50px" ></td> -->
<%
                //out.print(QrySet);
%>
                    <td class=tablecell align ="right" ><B>Set Criteria: </B></td><td align="Left">
                        <SELECT name="Set" id="Set" style="border-color:black;font-weight:Bold; FONT-FAMILY: Arial; FONT-SIZE: 10pt;color: black; HEIGHT: 25px; VERTICAL-ALIGN: top; WIDTH: 95px">
                            <OPTION VALUE="" ><-Select-></OPTION>
                            <%	QrySet = " select distinct  cset from TP#ELIGIBILITYCRITERIA where eventcode='" + Event + "' and companycode='" + Companycode + "' order by cset  ";
//System.out.print(QrySet);
                rsSet = db.getRowset(QrySet);
                if(request.getParameter("x")==null)
                {
                while(rsSet.next())
                {
                %> <OPTION  VALUE=<%=rsSet.getString("cset")%>><%=rsSet.getString("cset")%> </OPTION>

                            <%
                }}else    if (request.getParameter("x") != null) {
                    QrySet = " select distinct  cset from TP#ELIGIBILITYCRITERIA where eventcode='" + Event + "' and companycode='" + Companycode + "'  and cset='"+request.getParameter("Set").trim()+"' order by cset  ";

				//	System.out.print(QrySet);
                    rsSet = db.getRowset(QrySet);

					//System.out.print("***"+QrySet);
                    while (rsSet.next()) {
                            %><OPTION SELECTED VALUE=<%=request.getParameter("Set").trim()%>><%=request.getParameter("Set").trim()%></OPTION>
                            <%
                                }

                                QrySet = " select distinct  cset from TP#ELIGIBILITYCRITERIA where" +
                                        " eventcode='" + Event + "' and companycode='" + Companycode + "' and cset<>'" + request.getParameter("Set").trim() + "' order by cset  ";
                                //System.out.print(QrySet);
                                rsSet = db.getRowset(QrySet);
                                while (rsSet.next()) {
                            %> <OPTION  VALUE=<%=rsSet.getString("cset")%>><%=rsSet.getString("cset")%></OPTION> 

                            <%
                    }
                }

                            %>
                            <!-- <OPTION VALUE="ALL"  >ALL</OPTION> -->
                    </SELECT></td>
                    <td class=tablecell align ="right"><B>Students Catagory :  </B></td>
                    <td align="Left">
                        <SELECT name="studentCatagory" id="studentCatagory" style="border-color:black;font-weight:Bold; FONT-FAMILY: Arial; FONT-SIZE: 10pt;color: black; HEIGHT: 25px; VERTICAL-ALIGN: top; WIDTH: 95px">
                            <%if (request.getParameter("x") == null) {%>
                            <OPTION VALUE="" ><-Select-></OPTION>
                            <OPTION VALUE="ALL" >All</OPTION>
                            <OPTION VALUE="I" >Intrested</OPTION>
                            <OPTION VALUE="N" >Not Intrested</OPTION>
                            <OPTION VALUE="P" >Pending</OPTION>
                            <OPTION VALUE="X" >Others</OPTION>
                            <%} else if (request.getParameter("x") != null) {
    if (studCat.equals("I")) {%>
                            <OPTION VALUE="" ><-Select-></OPTION>
                            <OPTION VALUE="ALL" >All</OPTION>
                            <OPTION VALUE="I" SELECTED>Intrested</OPTION>
                            <OPTION VALUE="N" >Not Intrested</OPTION>
                            <OPTION VALUE="P" >Pending</OPTION>
                            <OPTION VALUE="X" >Others</OPTION>
                            <%} else if (studCat.equals("N")) {%>
                            <OPTION VALUE="" ><-Select-></OPTION>
                            <OPTION VALUE="ALL" >All</OPTION>
                            <OPTION VALUE="I" >Intrested</OPTION>
                            <OPTION VALUE="N" SELECTED>Not Intrested</OPTION>
                            <OPTION VALUE="P" >Pending</OPTION>
                            <OPTION VALUE="X" >Others</OPTION>
                            <%} else if (studCat.equals("P")) {%>
                            <OPTION VALUE="" ><-Select-></OPTION>
                            <OPTION VALUE="ALL" >All</OPTION>
                            <OPTION VALUE="I" >Intrested</OPTION>
                            <OPTION VALUE="N" >Not Intrested</OPTION>
                            <OPTION VALUE="P" SELECTED>Pending</OPTION>
                            <OPTION VALUE="X" >Others</OPTION>
                            <%} else if (studCat.equals("X")) {%>
                            <OPTION VALUE="" ><-Select-></OPTION>
                            <OPTION VALUE="ALL" >All</OPTION>
                            <OPTION VALUE="I" >Intrested</OPTION>
                            <OPTION VALUE="N" >Not Intrested</OPTION>
                            <OPTION VALUE="P" >Pending</OPTION>
                            <OPTION VALUE="X" SELECTED>Others</OPTION>
                            <%} else if (studCat.equals("ALL")) {%>
                            <OPTION VALUE=""  ><-Select-></OPTION>
                            <OPTION VALUE="ALL"  SELECTED>All</OPTION>
                            <OPTION VALUE="I" >Intrested</OPTION>
                            <OPTION VALUE="N" >Not Intrested</OPTION>
                            <OPTION VALUE="P" >Pending</OPTION>
                            <OPTION VALUE="X" >Others</OPTION>
                            <%} else {%><OPTION SELECTED VALUE="" ><-Select-></OPTION>
                            <OPTION VALUE="ALL" >All</OPTION>
                            <OPTION VALUE="I" >Intrested</OPTION>
                            <OPTION VALUE="N" >Not Intrested</OPTION>
                            <OPTION VALUE="P" >Pending</OPTION>
                            <OPTION VALUE="X" >Others</OPTION><%}
}%>
                            <!-- <OPTION VALUE="ALL"  >ALL</OPTION> -->
                    </SELECT></td>


                    <td class=tablecell align ="right">
                        <B>&nbsp;Institute :&nbsp;</B>
                    </td>
                    <td>


                        <%
                qry = " select distinct Institutecode from  TP#INSTITUTE where companycode='" + Companycode + "' and eventcode='" + Event + "' ";
            //   System.out.print(qry);
                rs = db.getRowset(qry);
                if (request.getParameter("xx") == null) {
                    while (rs.next()) {
                        %><input type="hidden" name="insti" id="insti<%=count%>" value="">
                        <font color="black" face=Verdana size=2><input type="checkbox" name="checkinst" id="checkinst<%=count%>" <%=Selected%>    value="<%=rs.getString(1).toString().trim()%>"   ><STRONG><%=rs.getString(1).toString().trim()%></STRONG></font>&nbsp;

                        <% count++;
                            }
                        } else if (request.getParameter("xx") != null) {

                            while (rs.next()) {
                                String insti[] = request.getParameterValues("insti");
                                //  out.print(insti[1]);
%>
                        <input type="hidden" name="insti" id="insti<%=count%>" value="">
                        <%
                              if (insti[count].equals("")) {
                        %>
                        <font color="black" face=Verdana size=2><input type="checkbox" name="checkinst" id="checkinst<%=count%>"     value="<%=rs.getString(1).toString().trim()%>"   ><STRONG><%=rs.getString(1).toString().trim()%></STRONG></font>&nbsp;
                        <%
                        } else if (((!insti[count].equals("")) && (!insti[count].equals("JUET")) && (!insti[count].equals("J128")) && (!insti[count].equals("JUIT")) && (!insti[count].equals("JIIT")))) {
                        %>
                        <font color="black" face=Verdana size=2><input type="checkbox" name="checkinst" id="checkinst<%=count%>"  checked    value="<%=insti[count]%>"   ><STRONG><%=insti[count]%></STRONG></font>&nbsp;
                        <%
                              }
                              if (insti[count].equals("JUIT")) {
                                  checkInst = insti[count];
                                  Selected = "checked";
                        %>
                        <font color="black" face=Verdana size=2><input type="checkbox" name="checkinst" id="checkinst<%=count%>" <%=Selected%>    value="<%=checkInst%> "   ><STRONG><%=checkInst%></STRONG></font>&nbsp;
                        <%
                              }%>

                        <%

                              if (insti[count].equals("JIIT")) {
                                  checkInst = insti[count];
                                  Selected = "checked";
                        %>
                        <font color="black" face=Verdana size=2><input type="checkbox" name="checkinst" id="checkinst<%=count%>" <%=Selected%>    value="<%=checkInst%> "   ><STRONG><%=checkInst%></STRONG></font>&nbsp;
                        <%
                              }

                        %>
                        <!--font color="black" face=Verdana size=2><input type="checkbox" name="checkinst" id="checkinst<%=count%>" <%=Selected%>    value="<%=checkInst%> "   ><STRONG><%=checkInst%></STRONG></font-->&nbsp;
                        <%

                              if (insti[count].equals("JUET")) {
                                  checkInst = insti[count];
                                  Selected = "checked";
                        %>
                        <font color="black" face=Verdana size=2><input type="checkbox" name="checkinst" id="checkinst<%=count%>" <%=Selected%>    value="<%=checkInst%> "   ><STRONG><%=checkInst%></STRONG></font>&nbsp;
                        <%
                              }

                              if (insti[count].equals("J128")) {
                                  checkInst = insti[count];
                                  Selected = "checked";
                        %>
                        <font color="black" face=Verdana size=2><input type="checkbox" name="checkinst" id="checkinst<%=count%>" <%=Selected%>    value="<%=checkInst%> "   ><STRONG><%=checkInst%></STRONG></font>&nbsp;
                        <%
                              }
                              if (!checkInst.equals(insti[count])) {
                                  checkInst = rs.getString(1).toString().trim();
                                  Selected = "";
                        %>
                        <!--font color="black" face=Verdana size=2><input type="checkbox" name="checkinst" id="checkinst<%=count%>" <%=Selected%>    value="<%=checkInst%> "   ><STRONG><%=checkInst%></STRONG></font-->&nbsp;
                        <%
                              }%>


                        <%
                        %>

                        <%

                                count++;

                            }
                        }
                        %><INPUT TYPE="HIDDEN" NAME="CHECK" id="check" value="<%=count%>" >
                    </td>

                    <td class=tablecell>
                        &nbsp; <input type="submit" name="submitbutton" id="submitbutton" style=" background-color:#88000 ;border-color:black;font-weight:Bold;FONT-FAMILY:Arial; FONT-SIZE: 10pt;color: black; HEIGHT: 25px; VERTICAL-ALIGN: top; WIDTH: 95px "  value="Submit" tabindex=88 onclick="return verif();" > &nbsp;
                    </td>

            </tr></table>
            <input type=hidden name="event" id="event" value="<%=Event%>"/>
            <input type=hidden name="companycode" id="companycode" value="<%=Companycode%>"/>
        </form>
        <form name=frm2  method=post action="ChooseHeader.jsp" target="_New" onsubmit="window.open('', this.target,    'width=500,height=700,resizable,scrollbars=yes'); return true;" >
            <input type="hidden" name="xxx">

            <center>
                <div id="load" style="display:none;" align="center">Loading... Please wait</div>
            </center>




            <%

                if (request.getParameter("xx") != null) {
            %>
            <!--progress Bar Start--------------------------------->
 <%

                 hh = 1;

                 qryF = " select 'Y' from  TP#STUDENTQUALIFICATION   ";
                 RsF = db.getRowset(qryF);
                 //if (RsF.next())
                 if (1 == 1) {

                     Companycode = request.getParameter("companycode") == null ? "" : request.getParameter("companycode").toString().trim();
                     Event = request.getParameter("event") == null ? "" : request.getParameter("event").toString().trim();

                     // out.print("***************/*/*/*/*/*/*/*/");

                     //String mInstCode = "";
                     String[] mInstCodes = request.getParameterValues("checkinst");

                     for (int j = 0; j < mInstCodes.length; j++) {
                         if (j == 0) {
                             mInstCode = mInstCode + "'" + mInstCodes[j] + "'";
                             mInstCode1 = mInstCode1 + mInstCodes[j];
                         } else {
                             mInstCode = mInstCode + ",'" + mInstCodes[j] + "'";
                             mInstCode1 = mInstCode1 + "/" + mInstCodes[j] + "";
                         }
                     }

                     xSet = request.getParameter("Set") == null ? "" : request.getParameter("Set").toString().trim();
                     mInstCode1 = mInstCode1.toString().trim();
                     mInstCode = mInstCode.toString().trim();

//out.print(mInstCode);
%>

            <table cellpadding=3 cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="95%" bgcolor="white">
                <tr bgcolor="silver">
                    <td  bgcolor="#F2F2F2"><B>Student(s) In Criteria </B></td>
                    <td  bgcolor="red"><B>Not Intrested student(s) </B></td>
                    <td bgcolor="#95EE95"><B>Intrested  student(s)</B></td>
                    <td  bgcolor="#FFD000"><B>Special Case student(s) </B></td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="Special Approval (Add Student)" onClick="window.open('SpecialApproval.jsp?id7=<%=request.getParameter("companycode")%>&id8=<%=request.getParameter("event")%>','parameterswindow')"/> </td></tr></table>
            <br>
            <table cellpadding=3 cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="95%" bgcolor="white">
                <!--tr bgcolor="" align="left">
    <td nowrap colspan="11" align="center"><font  face=arial size=2 color="#a52a2a" ><STRONG><u>Selected Institutes :&nbsp;&nbsp;<%=mInstCode1%></u></STRONG></td>
                </tr-->
                <tr bgcolor="silver" align="left">
                    <th nowrap><font  face=arial size=2 color="#a52a2a" align="left"><STRONG><INPUT TYPE="checkbox" id="all_Select"  NAME="all_Select" onclick="return select_All();">Select All</STRONG></font></th>
                    <th nowrap><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>S/No.</STRONG></font></th>
                    <th nowrap><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Institute</STRONG></font></th>
                    <th nowrap><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Academic Year</STRONG></font></th>
                    <th nowrap><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Enrollment</STRONG></font></th>
                    <th nowrap><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Student</STRONG></font></th>
                    <th nowrap><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Program</STRONG></font></th>
                    <th nowrap><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Branch</STRONG></font></th>
                    <th ><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Date Of Birth</STRONG>
                    <br>(DD-MM-YYYY)</font></th>
                    <th nowrap><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>CGPA</STRONG></font></th>
                    <th nowrap ><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Semester</STRONG></font></th>
                    <!--<th><font  face=arial size=2 color="#a52a2a"><STRONG>Modify</STRONG></font></th>
                    <th><font  face=arial size=2 color="#a52a2a"><STRONG>Delete</STRONG></font></th> -->
                </tr>

                <%
            try {

                //criteria query......................
                
                
                qry = " select  NVL(studenttpid,'') studentid,nvl(Institutecode,'') Institutecode,nvl(Academicyear,'') Academicyear,   (to_char(dateofbirth,'dd-mm-yyyy')) dateofbirth," +
                        "nvl(Enrollmentno,'') Enrollmentno, nvl(Studentname,'') Studentname,nvl(programcode,'') programcode,nvl(branchcode,'') branchcode," +
                        "nvl(sectioncode,'') sectioncode,nvl(SUBSECTIONCODE,'') SUBSECTIONCODE,to_char(nvl(semester,'')) semester  , Decode(Status,'X',Null,Status) Status,CGPA  from ( ";
                qry = qry + " SELECT  nvl(k.institutecode||k.studentid,'') studenttpid,nvl(k.Institutecode,'')Institutecode,nvl(Academicyear,'') Academicyear," +
                        "nvl(Enrollmentno,'')Enrollmentno,nvl(Studentname,'') Studentname,nvl(programcode,'') programcode,nvl(branchcode,'') branchcode," +
                        "nvl(sectioncode,'') sectioncode,nvl(SUBSECTIONCODE,'')SUBSECTIONCODE,to_char(nvl(k.semester,'')) semester , 'X' Status,  dateofbirth , " +
                        "s.CGPA  from v#studentmaster k ,v#STUDENTSGPACGPA s where k.institutecode||k.studentid=s.institutecode||s.studentid and " +
                        "s.semester=(Select max(semester) from v#STUDENTSGPACGPA v where v.institutecode||v.studentid =k.institutecode||k.studentid) " +
                        "and nvl(k.deactive,'N')='N' and k.institutecode IN (" + mInstCode + ") and k.studentid IS NOT NULL ";
                qry5 = " select  distinct cset from  TP#ELIGIBILITYCRITERIA where companycode='" + Companycode + "' and eventcode='" + Event + "' and cset=decode('" + xSet + "','ALL',cset,'" + xSet + "' )  ";
                rs5 = db.getRowset(qry5);
                //out.print(qry5+"<br>");
                while (rs5.next()) {

                    csst++;
                    qry2 = " select CRITERIAID ,CRITERIAOPERATORBEFORE  ,slno  from  TP#ELIGIBILITYCRITERIA where companycode='" + Companycode + "' and eventcode='" + Event + "' and cset='" + rs5.getString("cset") + "' ";
                    rs2 = db.getRowset(qry2);
                    //out.print(qry2+"<br>");
                    while (rs2.next()) {
                        mCritvales = "";

                        qry4 = " select CRITERIAID ,CRITERIATABLE ,CRITERIAFIELD  from TP#CRITERIAMASTER where criteriaid='" + rs2.getString("CRITERIAID") + "' ";
                        rs4 = db.getRowset(qry4);
                        if (rs4.next()) {
                            qry3 = " select nvl(CRITERIAVALUE,'') CRITERIAVALUE,nvl(SUBSLNO,'') SUBSLNO  from  TP#ELIGIBILITYCRITERIAVALUE  where companycode='" + Companycode + "' and eventcode='" + Event + "' and cset='" + rs5.getString("cset") + "'  and  criteriaid='" + rs2.getString("CRITERIAID") + "' and    slno='" + rs2.getString("slno") + "'  ";
                            rs3 = db.getRowset(qry3);
                            while (rs3.next()) {//out.print(qry3);
                                if (mCritvales.equals("")) {
                                    mCritvales = mCritvales + "'" + rs3.getString("CRITERIAVALUE") + "'";
                                } else {
                                    mCritvales = mCritvales + ",'" + rs3.getString("CRITERIAVALUE") + "'";
                                }

                            }

                            qry=qry+" and exists (select NVL(institutecode||studentid,'') studentid from " ;
                            if( rs4.getString("CRITERIATABLE").equals("V#STUDENTSGPACGPA")){
                                qry=qry +rs4.getString("CRITERIATABLE") + " g where  k.institutecode||k.studentid = g.institutecode||g.studentid and g.SEMESTER=(select max(semester) from V#STUDENTSGPACGPA t  where  k.institutecode || k.studentid =t.institutecode ||t.studentid) and ";
                            }else{
                                  qry=qry + rs4.getString("CRITERIATABLE") + " g where  k.institutecode||k.studentid = g.institutecode||g.studentid and ";
                                    }
                          
                         //   qry = qry + " and exists (select NVL(institutecode||studentid,'') studentid from " + rs4.getString("CRITERIATABLE") + " g where k.institutecode||k.studentid=g.institutecode||g.studentid   ";
                            qry3 = " select nvl(CRITERIAVALUE,'') CRITERIAVALUE,nvl(SUBSLNO,'') SUBSLNO  from  TP#ELIGIBILITYCRITERIAVALUE " +
                                    " where companycode='" + Companycode + "' and eventcode='" + Event + "' and cset='" + rs5.getString("cset") + "' " +
                                    " and  criteriaid='" + rs2.getString("CRITERIAID") + "' and    slno='" + rs2.getString("slno") + "'  ";
                            rs3 = db.getRowset(qry3);
                            if (rs3.next()) {
                                //	out.print("QRYY3"+qry3+"<br>");
                                if (rs4.getString("CRITERIAFIELD").equals("YEAROFPASSING")) {

                                    qry = qry + "  1=1     ";
                                //out.print("456Gyan Bhatt"+"\n");
                                } else if ((rs4.getString("CRITERIAFIELD").equals("FAIL"))) {

                                    qry = qry + "  1=1   ";
                                //out.print("123GYAN"+"\n");
                                } else {
                                    //out.print(mCritvales+"\n");

                                    qry = qry + "   " + rs4.getString("CRITERIAFIELD") + " " + rs2.getString("CRITERIAOPERATORBEFORE") + "  (" + mCritvales + ")       ";

                                }
                                qry = qry + "  ) and   not exists(select NVL(institutecode||studentid,'') studentid from TP#REGISTRATIONDETAIL g where k.institutecode||k.studentid=g.institutecode||g.studentid )    ";

                                //out.print(rs2.getString("CRITERIAID").equals("PROGRAM"));
                                if (rs2.getString("CRITERIAID").equals("PROGRAM")) {
                                    qry = qry + " and " + rs4.getString("CRITERIAFIELD") + " " + rs2.getString("CRITERIAOPERATORBEFORE") + "  (" + mCritvales + ")";


                                }

                            //qry=qry+" ";

                            }
                        }
                    }//out.print(qry);
                }
                //if(csst>=3){
                //	 qry=qry+" )  ";
                //	}
                qry = qry + " union SELECT nvl(b.institutecode||b.studentid,'') studenttpid ,   NVL (b.institutecode, '') institutecode,  NVL (b.academicyear, '') academicyear, " +
                        "  NVL (b.enrollmentno, '') enrollmentno,  NVL (b.studentname, '') studentname, NVL (b.programcode, '') programcode,  " +
                        " NVL (b.branchcode, '') branchcode, NVL (b.sectioncode, '') sectioncode,   NVL (b.subsectioncode, '') subsectioncode, " +
                        "to_char(NVL (b.semester, '')) semester ,'X' Status,  dateofbirth ,s.cGPA";
                qry = qry + "     FROM TEMP#TPSTUDENTMASTER a,v#studentmaster b ,v#STUDENTSGPACGPA s   where a.institutecode||a.studentid =s.institutecode||s.studentid and " +
                        "s.semester=(Select max(semester) from v#STUDENTSGPACGPA v where a.institutecode||a.studentid =v.institutecode||v.studentid) and  a.companycode='" + Companycode + "'  and a.EVENTCODE='" + Event + "' ";

                qry = qry + " union     SELECT nvl(b.institutecode||b.studentid,'') studenttpid ,   NVL(b.institutecode, '') institutecode,NVL(b.academicyear, '') academicyear," +
                        "NVL(b.enrollmentno, '') enrollmentno,  NVL(b.studentname,'' ) studentname, NVl(b.programcode, '') programcode," +
                        "   NVL (b.branchcode, '') branchcode, NVL (b.sectioncode, '') sectioncode,   NVL (b.subsectioncode, '') subsectioncode, " +
                        "to_char(NVL (b.semester, '')) semester ,NVL (a.STATUS, 'X') Status , dateofbirth,s.cgpa";
              
                qry = qry + "     FROM TP#REGISTRATIONDETAIL a, v#studentmaster b,v#STUDENTSGPACGPA s where a.institutecode||a.studentid= s.institutecode||s.studentid and s.semester=(Select max(semester)" +
                        " from v#STUDENTSGPACGPA v where v.institutecode||v.studentid = a.institutecode||a.studentid) and a.institutecode||a.studentid= b.institutecode||b.studentid and a.INSTITUTECODE=b.INSTITUTECODE  and a.ACADEMICYEAR=b.ACADEMICYEAR " +
                        " and a.PROGRAMCODE=b.PROGRAMCODE  and a.companycode='" + Companycode + "'  and a.EVENTCODE='" + Event + "'   and a.institutecode IN (" + mInstCode + ")  ";
                qry5 = " select  distinct cset from  TP#ELIGIBILITYCRITERIA where companycode='" + Companycode + "' and eventcode='" + Event + "' and cset=decode('" + xSet + "','ALL',cset,'" + xSet + "' )  ";
                rs5 = db.getRowset(qry5);
                //out.print(qry5+"<br>");
                while (rs5.next()) {

                    csst++;
                    
                    qry2 = " select CRITERIAID ,CRITERIAOPERATORBEFORE  ,slno  from  TP#ELIGIBILITYCRITERIA where companycode='" + Companycode + "' and eventcode='" + Event + "' and cset='" + rs5.getString("cset") + "' ";
                    rs2 = db.getRowset(qry2);
                   
                    while (rs2.next()) {
                        mCritvales = "";

                        qry4 = " select CRITERIAID ,CRITERIATABLE ,CRITERIAFIELD  from TP#CRITERIAMASTER where criteriaid='" + rs2.getString("CRITERIAID") + "' ";
                        rs4 = db.getRowset(qry4);
                        if (rs4.next()) {//out.print("QRY4"+qry4+"<br>");

                            //if(csst>2){
                            // qry=qry+"     ";
                            //}else{
                            // qry=qry+" and    ";
                            //}





                            qry3 = " select nvl(CRITERIAVALUE,'') CRITERIAVALUE,nvl(SUBSLNO,'') SUBSLNO  from  TP#ELIGIBILITYCRITERIAVALUE  where companycode='" + Companycode + "' and eventcode='" + Event + "' and cset='" + rs5.getString("cset") + "'  and  criteriaid='" + rs2.getString("CRITERIAID") + "' and    slno='" + rs2.getString("slno") + "'  ";
                            rs3 = db.getRowset(qry3);
                            while (rs3.next()) {//out.print(qry3);
                                if (mCritvales.equals("")) {
                                    mCritvales = mCritvales + "'" + rs3.getString("CRITERIAVALUE") + "'";
                                } else {
                                    mCritvales = mCritvales + ",'" + rs3.getString("CRITERIAVALUE") + "'";
                                }

                            }
//a.institutecode||a.studentid IN

                            qry = qry + " and exists ( select  NVL (institutecode||studentid, '') studentid from " ;
                            if( rs4.getString("CRITERIATABLE").equals("V#STUDENTSGPACGPA")){
                                qry=qry +rs4.getString("CRITERIATABLE") + " g where  a.institutecode||a.studentid = g.institutecode||g.studentid and g.SEMESTER=(select max(semester) from V#STUDENTSGPACGPA t  where  a.institutecode || a.studentid =t.institutecode ||t.studentid) and ";
                            }else{
                                  qry=qry + rs4.getString("CRITERIATABLE") + " g where  a.institutecode||a.studentid = g.institutecode||g.studentid and ";
                                    }
                                    qry3 = " select nvl(CRITERIAVALUE,'') CRITERIAVALUE,nvl(SUBSLNO,'') SUBSLNO  from  TP#ELIGIBILITYCRITERIAVALUE " +
                                    " where companycode='" + Companycode + "' and eventcode='" + Event + "' and cset='" + rs5.getString("cset") + "' " +
                                    " and  criteriaid='" + rs2.getString("CRITERIAID") + "' and    slno='" + rs2.getString("slno") + "'  ";
                            rs3 = db.getRowset(qry3);
                            if (rs3.next()) {
                             
                                if (rs4.getString("CRITERIAFIELD").equals("YEAROFPASSING")) {

                                    qry = qry + "  1=1     ";
                             
                                } else if ((rs4.getString("CRITERIAFIELD").equals("FAIL"))) {

                                    qry = qry + "  1=1   ";
                               
                                } else {
                                   

                                    qry = qry + "   " + rs4.getString("CRITERIAFIELD") + " " + rs2.getString("CRITERIAOPERATORBEFORE") + "  (" + mCritvales + ")       ";

                                }
                                qry = qry + "  )     ";

                               
                                if (rs2.getString("CRITERIAID").equals("PROGRAM")) {
                                    qry = qry + " and a." + rs4.getString("CRITERIAFIELD") + " " + rs2.getString("CRITERIAOPERATORBEFORE") + "  (" + mCritvales + ")";


                                }

                           

                            }
                        }
                    }
                }


                qry = qry + "  ORDER BY Status,InstituteCode,EnrollmentNo ";
                qry = qry + ") ";
                if (!studCat.equals("ALL")) {
                    qry = qry + "Where Nvl(Status,'X') = Decode('" + studCat + "','I','I','N','N','P','P','X','X')";
                }

               
                rs = db.getRowset(qry);
              // out.print(qry+"<br>");

                while (rs.next()) {
                    slno++;
                    int hhh = 0;
                    QERCLOR = " select institutecode||studentid from  TEMP#TPSTUDENTMASTER where institutecode||studentid='" + rs.getString("studentid") + "' and companycode='" + Companycode + "' and eventcode='" + Event + "' and institutecode IN (" + mInstCode + ")    ";
                    rsQERCLOR = db.getRowset(QERCLOR);
                    //out.print(slno+"@@@@@@@@@@@@-"+QERCLOR);
                    if (rsQERCLOR.next()) {
                        mcolor = "#FFD000";
                        hhh = 1;
                    }


                    int yyy = 0;
                    QERCLORR = " select institutecode||studentid from   TP#REGISTRATIONDETAIL where institutecode||studentid='" + rs.getString("studentid") + "' and companycode='" + Companycode + "' and eventcode='" + Event + "' and nvl(status,'A')='I' and institutecode IN (" + mInstCode + ")   ";
                    rsQERCLORR = db.getRowset(QERCLORR);
                    //out.print(slno+"-"+QERCLORR);
                    if (rsQERCLORR.next()) {
                        mcolor = "#95EE95";
                        yyy = 1;
                    }


                    int xxx = 0;
                    QERCLORRN = " select institutecode||studentid from   TP#REGISTRATIONDETAIL where institutecode||studentid='" + rs.getString("studentid") + "' and companycode='" + Companycode + "' and eventcode='" + Event + "' and nvl(status,'A')='N' and institutecode IN (" + mInstCode + ")   ";
                    rsQERCLORRN = db.getRowset(QERCLORRN);
                    //out.print(slno+"-"+QERCLORRN);
                    if (rsQERCLORRN.next()) {//out.print(slno+"-"+QERCLORRN);
                        mcolor = "red";
                        xxx = 1;
                    }


                    if (yyy == 0 && hhh == 0 && xxx == 0) {
                        mcolor = "#F2F2F2";
                        hhh = 0;
                        yyy = 0;
                        xxx = 0;
                    }
                %>

                <tr bgcolor=<%=mcolor%>>

                    <% qrysel = " select 'Y' from TP#EVENTPARTICIPENTS where institutecode||studentid='" + rs.getString("studentid") + "' and companycode='" + Companycode + "' and eventcode='" + Event + "' and  nvl(REGISTERED,'N')='Y'  ";
                    rssel = db.getRowset(qrysel);

                    if (rssel.next()) {//out.print(qrysel);
                        studentid = rs.getString("studentid") == null ? "" : rs.getString("studentid").trim();
                        //studid=studentid.substring(4);
                        //studid=studentid.substring(;

                    %>
                    <td align="left"><INPUT TYPE="checkbox" checked id="Select<%=slno%>"  NAME="Select<%=slno%>" value=<%=rs.getString("studentid")%>></td>

                    <%
                     } else {
                    %>
                    <td align="left"><INPUT TYPE="checkbox" id="Select<%=slno%>" NAME="Select<%=slno%>" value=<%=rs.getString("studentid")%>></td>
                    <%
                    }%>
                    <input type="hidden" name="institu" id="institu" value="<%=rs.getString("Institutecode") == null ? "" : rs.getString("Institutecode").trim()%>">
                    <td align="left"><%=slno%></td>
                    <td align="left"><%=rs.getString("Institutecode") == null ? "N/A" : rs.getString("Institutecode").trim()%></td>
                    <td align="left"><%=rs.getString("Academicyear") == null ? "N/A" : rs.getString("Academicyear").trim()%></td>
                    <td align="left"><%=rs.getString("Enrollmentno") == null ? "N/A" : rs.getString("Enrollmentno").trim()%></td>
                    <td align="left"><%=rs.getString("Studentname") == null ? "N/A" : rs.getString("Studentname").trim()%></td>
                    <td align="left"><%=rs.getString("programcode") == null ? "N/A" : rs.getString("programcode").trim()%></td>
                    <td align="left"><%=rs.getString("branchcode") == null ? "N/A" : rs.getString("branchcode").trim()%></td>
                    <td align="left"><%=rs.getString("dateofbirth") == null ? "N/A" : rs.getString("dateofbirth").trim()%></td>
                    <td align="left"><%=rs.getString("CGPA") == null ? "N/A" : rs.getString("CGPA").trim()%></td>
                    <td align="left"><%=rs.getString("semester") == null ? "N/A" : rs.getString("semester").trim()%></td>
                </tr>



                <%
                    if (request.getParameter("Select" + slno) != null) {
                %>
                <input type=hidden NAME="Select<%=slno%>" ID="Select<%=slno%>"  value="<%=rs.getString("studentid")%>"/>
                <%
                    }


                %>
                <!-- <input type=hidden NAME="Select<%=slno%>" ID="Select<%=slno%>"  value="<%=rs.getString("studentid")%>"/> -->
<%
                    }
                %>
                <input type=hidden name="event" id="event" value="<%=Event%>"/>
                <input type=hidden name="companycode" id="companycode" value="<%=Companycode%>"/>
                <input type=hidden name="slno" id="slno" value="<%=slno%>"/>
                <input type=hidden name="Inst" id="Inst" value="<%=mInstCode%>"/>


                <%




                     } catch (Exception e) {
                         out.print("Error no1:" + e);
                     }

                 } else {

                     out.print("<br><img src='../../Images/Error1.jpg'>");
                     out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> No Data Avialable <a href='../../index.jsp' target=_New></a> </font> <br>");
                 }


                %>
            </table>
            <table cellpadding=3 cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="95%" bgcolor="white">
                <tr bgcolor="silver" align=center><TD>
                        &nbsp; <input type=submit  style="background-color:#88000 ;border-color:black;font-weight:Bold; FONT-FAMILY: Arial; FONT-SIZE: 10pt;color: black; HEIGHT: 30px; VERTICAL-ALIGN: top; WIDTH: 250px"  name="btny"  value ="Save And Load In Excel" onClick="window.open('ChooseHeader.jsp?companycode=<%=Companycode%>&event=<%=Event%>&slno=<%=slno%>&Inst=<%=mInstCode%>','parameterswindow')"> &nbsp;
                </TD></tr>
            </TABLE>
            <br>

            <%
            }
        } catch (Exception e) {
            out.print("error :" + e);
        }
            %>
</form></body></html>