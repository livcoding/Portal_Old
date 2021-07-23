<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%
        DBHandler db = new DBHandler();
        ResultSet rs = null;
        ResultSet rsd = null;
        ResultSet rs1 = null;
        ResultSet rs2 = null;
        String qry = "";
        GlobalFunctions gb = new GlobalFunctions();
//-----------------ADDED CODE----------------------DATE-28-MARCH-2011@mohit sharma
        String mRegCode = "";
        String mFeeHead = "";
        String mAcademicYear = "";
        String mProgramCode = "";
        String mBranchCode = "";
        String mInstCode = "JIIT";
		int count=0;
%>
<HTML>
    <head>
        <TITLE>#### JIIT [ View Academic Fee detail  ] </TITLE>
        <script language="JavaScript" type ="text/javascript">
            <!--
            if (top != self) top.document.title = document.title;
            -->
        </script>
        <script language=javascript>
            <!--
            function RefreshContents()
            {
                document.frm.x.value='ddd';
                document.frm.submit();
            }
            //-->
        </script>
        <script>
            if(window.history.forward(1) != null)
                window.history.forward(1);
        </script>
        <script type="text/javascript" src="../js/sortabletable.js"></script>
        <link type="text/css" rel="StyleSheet" href="../css/sortabletable.css" />

    </head>
    <body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >


        <form name="frm"  method="get" >
            <input id="x" name="x" type=hidden>
            <table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
                <tr><td colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><FONT SIZE="6" COLOR=""><U><B>MIS Report</B></U></FONT>
                </font></td></tr>
            </table>
            <table cellpadding=1 cellspacing=0 align=center rules=groups border=3>
                <tr>
                <td><FONT color=black>&nbsp; <FONT face=Arial size=2><STRONG>Reg.Code :&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</STRONG></FONT></FONT><select  name="RegCode" id="RegCode" style="width:150px">
                        <option  selected value="ALL">ALL</option>
                        <%
        qry = "SELECT DISTINCT regcode FROM registrationmaster WHERE NVL (deactive, 'N') = 'N' ORDER BY regcode";
        rs = db.getRowset(qry);

        while (rs.next()) {
                        %>
                        <option Value ='<%=rs.getString("regcode")%>'><%=rs.getString("regcode")%></option>
                        <%
        }
                        %>
                </select></td>
                <td>
                    <FONT color=black>&nbsp; <FONT face=Arial size=2><STRONG>Fee Head:&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</STRONG></FONT><select  name="FeeHead"  id="FeeHead" style="width:150px">
                            <option  selected value="ALL">ALL</option>
                            <%
        try {
            qry = "SELECT DISTINCT FEEHEAD FROM FEEHEADS WHERE NVL (deactive, 'N') = 'N' ORDER BY FEEHEAD";
            rsd = db.getRowset(qry);
            while (rsd.next()) {
                            %>
                            <option value="<%=rsd.getString("FEEHEAD")%> "><%=rsd.getString("FEEHEAD")%></option>
                            <%
            }
        } catch (Exception e) {
        }
                            %>
                        </select>
                &nbsp;&nbsp;&nbsp; </FONT></td>
                <td><FONT color=black>&nbsp; <FONT face=Arial size=2><STRONG>Academic Year:&nbsp&nbsp&nbsp&nbsp</STRONG></FONT><select  name="AcademicYear"  id="AcademicYear" style="width:150px">
                            <option  selected value="ALL">ALL</option>
                            <%
        try {
            qry = "SELECT DISTINCT academicyear FROM academicyearmaster WHERE NVL (deactive, 'N') = 'N' ORDER BY academicyear";

            rsd = db.getRowset(qry);

            while (rsd.next()) {
                            %>
                            <option value="<%=rsd.getString("academicyear")%> "><%=rsd.getString("academicyear")%></option>
                            <%
            }
        } catch (Exception e) {
        }
                            %>
                        </select>
                &nbsp;&nbsp;&nbsp; </FONT></td>
                <TR>&nbsp&nbsp&nbsp&nbsp&nbsp</TR><TR>
                    <td><FONT color=black>&nbsp; <FONT face=Arial size=2><STRONG>Program Code:&nbsp&nbsp&nbsp&nbsp</STRONG></FONT><select  name="ProgramCode"  id="ProgramCode" style="width:150px">
                                <option  selected value="ALL">ALL</option>
                                <%
        try {
            qry = "SELECT DISTINCT programcode FROM programmaster WHERE NVL (deactive, 'N') = 'N' ORDER BY programcode";

            rsd = db.getRowset(qry);
            while (rsd.next()) {
                                %>
                                <option value="<%=rsd.getString("programcode")%> "><%=rsd.getString("programcode")%></option>
                                <%
            }
        } catch (Exception e) {
        }
                                %>
                            </select>
                    &nbsp;&nbsp;&nbsp; </FONT></td>
                    <td><FONT color=black>&nbsp; <FONT face=Arial size=2><STRONG>Branch Code:&nbsp&nbsp&nbsp&nbsp</STRONG></FONT></FONT><select  NAME="BranchCode"  ID="BranchCode" style="width:150px">
                        <option  selected value="ALL">ALL</option>
                        <%
        try {
            qry = "SELECT DISTINCT branchcode FROM branchmaster WHERE NVL (deactive, 'N') = 'N' ORDER BY branchcode";

            rsd = db.getRowset(qry);
            while (rsd.next()) {
                        %>
                        <option value="<%=rsd.getString("branchcode")%> "><%=rsd.getString("branchcode")%></option>
                        <%
            }
        } catch (Exception e) {
        }
                        %>
                    </select>
                   <td>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<INPUT Type="submit" Value="Show/Refresh"></td>

                </TR><tr><td nowrap colspan=6>
                        &nbsp;
                <marquee  scrolldelay=225 width:700 behavior=alternate><a href="../../Images/PageSetupXL.bmp" Title="Instruction before print a Students List" Target=_New><font size=3 color=Blue><b>Recommended Page Setup: Paper Size - A4 and Top/Bottom Margin - .25</b></font></a></marquee></td></tr>


                <tr>
            </table>
        </form>
        <%  //-----------------------------------------------------------------------
           try
              { 
        if (request.getParameter("x") != null) {

            //------------ADDED CODE--------------DATE-30-MARCH-2011-------------
            if (request.getParameter("AcademicYear") == null) {
                mAcademicYear = "";
            } else {
                mAcademicYear = request.getParameter("AcademicYear").toString().trim();
            }

            if (request.getParameter("RegCode") == null) {
                mRegCode = "";
            } else {
                mRegCode = request.getParameter("RegCode").toString().trim();
            }
            if (request.getParameter("ProgramCode") == null) {
                mProgramCode = "";
            } else {
                mProgramCode = request.getParameter("ProgramCode").toString().trim();
            }
            if (request.getParameter("FeeHead") == null) {
                mFeeHead = "";
            } else {
                mFeeHead = request.getParameter("FeeHead").toString().trim();
            }
            if (request.getParameter("BranchCode") == null) {
                mBranchCode = "";
            } else {
                mBranchCode = request.getParameter("BranchCode").toString().trim();
            }
               //out.print(mAcademicYear + "---" + mBranchCode + "---" + mFeeHead + "---" + mProgramCode + "---" + mRegCode);
             // session.setAttribute("listorder",mList);
            //-------------------------------------------------------------------
%>
        <br>
        <table align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="100%" border=1 >
            <thead>
                <tr bgcolor="#ff8c00">
				<td><b><font color="white">Sr.no.</font></b></td>
                    <td><b><font color="white">Academic Year</font></b></td>
                    <td><b><font color="white">Program Code</font></b></td>
                    <td><b><font color="white">Branch Code</font></b></td>
                    <td><b><font color="white">Total Student</font></b></td>
                    <td><b><font color="white">Total Fee Payable</font></b></td>
                    <td><b><font color="white">Reg.Student</font></b></td>
                    <td><b><font color="white">Fee Recieved</font></b></td>
                    <td><b><font color="white">Not Reg.Student</font></b></td>
                    <td><b><font color="white">Fee Balance</font></b></td>
					</tr>
					</thead>
					<tbody>
					<tr>
                    <%
                  


                //------------Query To Display records---------------Qry Added on 9/30/2011 by mohit

                qry=   "  SELECT   a.academicyear academicyear, a.programcode programcode, a.branchcode			  		  branchcode, " +
                       "  COUNT (DISTINCT a.studentid) totalstudents, " +
                       "  SUM (b.feeamount) totalfee, COUNT (DISTINCT c.studentid) regstudents, " +
                       "  SUM (b.paidamount) paidfee, " +
                       "  (COUNT (DISTINCT a.studentid) - COUNT (DISTINCT c.studentid )                         )     notregstudents, " +
                       "  (SUM (b.feeamount) - SUM (b.paidamount)) balancefee " +
                       "  FROM studentmaster a, studentfeesummary b, studentregistration c " +
                       "  WHERE a.studentid = c.studentid " +
                       "  AND NVL (a.deactive, 'N') = 'N' " +
                       "  AND a.institutecode = b.institutecode " +
                       "  AND a.semester = b.semester " +
                       "  AND a.studentid = b.studentid " +
                       "  AND NVL (c.regallow, 'N') = 'Y' " +
                       "  AND b.semestertype = c.semestertype " +
                       "  AND b.semestertype = 'REG' " +
                       "  AND c.institutecode = a.institutecode ";

           if (!mBranchCode.equals("ALL")) { 
                qry = qry + "and  a.branchcode='" + mBranchCode + "' ";
            }

            if (!mProgramCode.equals("ALL")) {
                qry = qry + "and  a.programcode='" + mProgramCode + "' ";
            }

            if (!mAcademicYear.equals("ALL")) {
                qry = qry + "and a.academicyear='" + mAcademicYear + "' ";
            }
           qry=qry+"GROUP BY a.academicyear, a.programcode, a.branchcode  " +
                   "ORDER BY a.academicyear, a.programcode, a.branchcode  ";
           //out.print(qry);
            rs = db.getRowset(qry);            
            while (rs.next()) {
                    %>
					<td><B><%=++count%></B></td>
					<TD bgcolor=white align=center><a href="Mishistory.jsp?ViewType=CNF&amp;academicyear=<%=rs.getString("academicyear")%>&amp;programcode=<%=rs.getString("programcode")%>&amp;branchcode=<%=rs.getString("branchcode")%>" target=_new><Font face=Arial color=blue size=2><%=rs.getString("academicyear")%></Font></a></TD>
					<TD bgcolor=white align=center><a href="Mishistory.jsp?ViewType=CNF&amp;academicyear=<%=rs.getString("academicyear")%>&amp;programcode=<%=rs.getString("programcode")%>&amp;branchcode=<%=rs.getString("branchcode")%>" target=_new><Font face=Arial color=blue size=2><%=rs.getString("programcode")%></Font></a></TD>
					<TD bgcolor=white align=center><a href="Mishistory.jsp?ViewType=CNF&amp;academicyear=<%=rs.getString("academicyear")%>&amp;programcode=<%=rs.getString("programcode")%>&amp;branchcode=<%=rs.getString("branchcode")%>" target=_new><Font face=Arial color=blue size=2><%=rs.getString("branchcode")%></Font></a></TD>				
                    <td><%=rs.getString("totalstudents")%></td>
                    <td><%=rs.getString("totalfee")%></td>
                    <td><%=rs.getString("regstudents")%></td>
                    <td><%=rs.getString("paidfee")%></td>
                    <td><%=rs.getString("notregstudents")%></td>
                    <td><%=rs.getString("balancefee")%></td>
                </tr>
				<% 
					    session.setAttribute("academicyear",mAcademicYear);
                        session.setAttribute("programcode",mProgramCode);
                        session.setAttribute("branchcode",mBranchCode);
				%>
                <%
            //------------------------------------ADDED CODE------------------------------ ON/27-apl-2011
            }
            qry = "select SUM(totalfee) a,SUM(totalstudents) b,SUM(regstudents) c,SUM(paidfee) d,SUM(balancefee) e,SUM(notregstudents) f from (" + qry + ")";
            //out.print(qry);
            rs = db.getRowset(qry);
            if (rs.next()) {
%>
                <tr bgcolor=white >	<td></td>			
                    <td colspan=3 align=right><b>Total Amount</b>&nbsp; &nbsp;</td>
                    <td align=left><b><%=rs.getString("b")%></b>&nbsp; &nbsp;</td>
                    <td align=left><b><%=rs.getString("a")%></b>&nbsp; &nbsp;</td>
                    <td align=left><b><%=rs.getString("c")%></b>&nbsp; &nbsp;</td>
                    <td align=left><b><%=rs.getString("d")%></b>&nbsp; &nbsp;</td>
                  <td align=left><b><%=rs.getString("f")%></b>&nbsp; &nbsp;</td>
                    <td align=left><b><%out.print(rs.getString("e"));
            }%></b>&nbsp; &nbsp;</td>
                </tr>
                <tr><td colspan=11><marquee scrolldelay=300 behavior=alternate>Click to show detailed of fee structure..</marquee></td></tr>
            </tbody>
        </table>
        <form><input type="button" value=" Print this page "
                     onclick="window.print();return false;" /></form>



<form name="frm2" id="frm2" method="post" action="Mishistory.jsp">                   
                            <input type=hidden name='academicyear' id='academicyear' value="<%=mAcademicYear%>">
                            <input type=hidden name='programcode' id='programcode' value="<%=mProgramCode%>">
                            <input type=hidden name='branchcode' id='branchcode' value="<%=mBranchCode%>">                     
                            </form>

        <script type="text/javascript">
            var st1 = new SortableTable(document.getElementById("table-1"),["CaseInsensitiveString","CaseInsensitiveString","Number","Number","Number","Number","Number"]);
        </script>
        <table ALIGN=Center VALIGN=TOP>
            <tr>
                <td valign=middle><br><br>
                    <IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">	<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>A product of <STRONG>JIL Information Technology Ltd.</STRONG><br><FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:info@jiit.ac.in'>info@jiit.ac.in</A></FONT>
                </td>
            </tr>     
        </table>
        <%
        }
           }catch(Exception e)
            {
               out.print(e);
           }
        %>
    </body>
</html>
