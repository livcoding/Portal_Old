<%@ page language="java" import="java.sql.*,jpalumni.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>

<%
        DBHandler db = new DBHandler();
        ResultSet rs = null;
        ResultSet rsd = null ,rsss =null;
        ResultSet rs1 = null ,rstt=null ;
        ResultSet rs2 = null;
        String qry = "",qryt="",mecodee="";
      
		//-------ADDED CODE-------DATE-05/05/2012@mohit sharma
        String qrys="",mRegCode = "",macad="",mCheck="";
        String mEXAMCODE = "";
        String mAcademicYear = "";
        String mProgramCode = "";
        String mBranchCode = "";
        String mInstcode = "";
        String mFeeHead = "";
        String mDATE1 = "";
        String mDATE2 = "" ,mCompanyCode="";
		int count=0;
		boolean flag ;

		int momr=0;
		int ol=0;
		int om=0;
		int tl=0;
%>
		<HTML>
		<head>
        <TITLE>####[Aplication Submission Status] </TITLE>
        <script language="JavaScript" type ="text/javascript"></script>
		<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>    
		<script language="javascript" type="text/javascript" src="js/jquery.min.js"></script>
		<link type="text/css" rel="StyleSheet" href="css/filtergrid.css"/>
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
            <tr><td colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><FONT SIZE="4" COLOR=""><B>Application Status Summary</B>
            </font></FONT>
			<BR><img src="images/ornament.gif" width="474" height="11" alt="" /></td></tr>
			</table>
			<table cellpadding=1 cellspacing=0 align=center rules=groups border=3>
            <tr>
			
					<td>
					<FONT color=black>&nbsp; <FONT face=Arial size=2><STRONG>From Date:&nbsp<INPUT TYPE="text" NAME="DATE1"><a href="javascript:NewCal('DATE1','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a></STRONG></FONT>&nbsp;&nbsp;</td>
					<td>
					<FONT face=Arial size=2><STRONG>To Date:&nbsp<INPUT TYPE="text" NAME="DATE2"><a href="javascript:NewCal('DATE2','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a></tr><tr></STRONG></FONT>&nbsp;&nbsp;</td></TR>
					<TR>
					<td COLSPAN=6 ALIGN=CENTER><BR><INPUT Type="submit" Value="Show/Refresh"></td>
					</TR>
					</tr>
					</tr>
					</table>
					</form>
					<%  
			
					try
					  { 
					if(request.getParameter("x") != null) {
					  //-----ADDED CODE--------DATE-5/5/2012-------ENTRY-DATE------
					
					if (request.getParameter("DATE1") == null) {
							mDATE1 = "";
					} else {
							mDATE1 = request.getParameter("DATE1").toString().trim();
					}

					if (request.getParameter("DATE2") == null) {
							mDATE2 = "";
					} else {
							mDATE2 = request.getParameter("DATE2").toString().trim();
					}
				
				//-------------------------------------------------------------------
				%>
				<table  align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="65%" border=1 >
				<thead>
            	<tr ><td><b><font color="black">Sl No.</font></b></td>
					<td align=left><b><font color="black">Application Submission Mode </font></b></td>
					<td align=left><b><font color="black">Application Count </font></b></td>
				</tr>
				</thead>
				<tbody>
			
               <%
			qryt="select count(distinct applicationid)OMR from c#applicationmaster where applicationid   LIKE '%JIITOM%'";
			if(!mDATE1.equals(""))
			{
			qryt=qryt+" AND TRUNC (ENTRYDATE) BETWEEN TRUNC (   DECODE (   TO_DATE ('"+mDATE1+"',                       'dd-mm-yyyy'), '', ENTRYDATE,  TO_DATE ('"+mDATE1+"',   'dd-mm-yyyy'))) AND TRUNC (  DECODE (     TO_DATE ('"+mDATE2+"',       "+
			 " 'dd-mm-yyyy'), '', ENTRYDATE, TO_DATE ('"+mDATE2+"', 'dd-mm-yyyy')))   " ;
			}
			rstt = db.getRowset(qryt);  
					//	out.print(qryt);
						while (rstt.next())
			{

			om=rstt.getInt("OMR");
		
			%>
			<tr>
			<td><FONT SIZE="2" COLOR="Black"><B>1.</B></FONT></td>
			<td><FONT SIZE="2" COLOR="Black"><B>OMR Aplication</B></FONT></td>
			<td><FONT SIZE="2" COLOR="red"><A HREF="applicantdetail.jsp?ViewType=CNF&amp;TYPE=JIITOM" target=_new><%=rstt.getInt("OMR")%></A></FONT></td><tr>
			<%
			}
			qrys="select count(distinct applicationid)ONLIN from c#applicationmaster where applicationid LIKE '%JIITOL%' ";
			
			if(!mDATE1.equals(""))
			{
			qrys=qrys+" AND TRUNC (ENTRYDATE) BETWEEN TRUNC (   DECODE (   TO_DATE ('"+mDATE1+"',                       'dd-mm-yyyy'), '', ENTRYDATE,  TO_DATE ('"+mDATE1+"',   'dd-mm-yyyy'))) AND TRUNC (  DECODE (     TO_DATE ('"+mDATE2+"',       "+
			 " 'dd-mm-yyyy'), '', ENTRYDATE, TO_DATE ('"+mDATE2+"', 'dd-mm-yyyy')))   " ;
			}
			rsss = db.getRowset(qrys);  
			//out.print(qrys);
			while (rsss.next())
			{
			ol=rsss.getInt("ONLIN");
			%>
			<tr>
			<td><FONT SIZE="2" COLOR="Black"><B>2.</B></FONT></td>
			<td><FONT SIZE="2" COLOR="Black"><B>Onlilne Aplication</B></FONT></td>
			
			<td><FONT SIZE="2" COLOR="red"><A HREF="applicantdetail.jsp?ViewType=CNF&amp;TYPE=JIITOL" target=_new><%=rsss.getInt("ONLIN")%></A></FONT></FONT></td></tr>
			<%
            }

			tl=(om)+(ol);

			%>
			<tr>
			<td></td>
			<td><FONT SIZE="2" COLOR="red"><B>Total Count:</B></FONT></td>
			<td><FONT SIZE="2" COLOR="green"><B><%=tl%></B></FONT></FONT></td></tr>
			</tbody>
			</table>
			</form>
			<%
			}
			}catch(Exception e)
			{
			out.print(e);
			}
			%>
			
							</body>
							</html>

