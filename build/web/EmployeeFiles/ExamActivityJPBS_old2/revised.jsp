<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*,java.util.* ,java.math.* " %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
String xSUB="",xEMP="";
String  qrycase="",sFSTIDS="" ,CALVALAP="",CALVALF="";
int mAbsentc=0,mMedicalc=0,mUFMc=0,mProdatac=0,mDebarrc=0;

String nRF="",nRD="",nRC="",nRCP="",nRB="",nRBP="",nRA="",nRAP="" ,xRB="" ,xTOTS="",xPRE="";
String xDEV="",xMEN="";
int COUNTFI=0,RounDCount=0,GradeMasterLowerLimitInt=0;
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT";

  String xABS="",xMED="",xUFM="",xDEB=""; 


if(session.getAttribute("ABS")!=null  )
	xABS=session.getAttribute("ABS").toString().trim();
else
	xABS="";

	if(session.getAttribute("MED")!=null  )
	xMED=session.getAttribute("MED").toString().trim();
else
	xMED="";

	if(session.getAttribute("UFM")!=null  )
	xUFM=session.getAttribute("UFM").toString().trim();
else
	xUFM="";

	if(session.getAttribute("DEB")!=null  )
	xDEB=session.getAttribute("DEB").toString().trim();
else
	xDEB="";

if(session.getAttribute("RAP")!=null  )
	nRAP=session.getAttribute("RAP").toString().trim();
else
	nRAP="";

	
	if(session.getAttribute("RA")!=null  )
	nRA=session.getAttribute("RA").toString().trim();
else
	nRA="";

	if(session.getAttribute("RBP")!=null  )
	nRBP=session.getAttribute("RBP").toString().trim();
else
	nRBP="";

	if(session.getAttribute("RB")!=null  )
	nRB=session.getAttribute("RB").toString().trim();
else
	nRB="";

	if(session.getAttribute("RCP")!=null  )
	nRCP=session.getAttribute("RCP").toString().trim();
else
	nRCP="";

	if(session.getAttribute("RC")!=null  )
	nRC=session.getAttribute("RC").toString().trim();
else
	nRC="";

	if(session.getAttribute("RD")!=null  )
	nRD=session.getAttribute("RD").toString().trim();
else
	nRD="";

	if(session.getAttribute("RF")!=null  )
	nRF=session.getAttribute("RF").toString().trim();
else
	nRF="";

	if(session.getAttribute("RRB")!=null  )
	xRB=session.getAttribute("RRB").toString().trim();
else
	xRB="";

xRB=xRB+"&nbsp;|&nbsp;0";


if(session.getAttribute("TOTS")!=null  )
	xTOTS=session.getAttribute("TOTS").toString().trim();
else
	xTOTS="";


if(session.getAttribute("PRE")!=null  )
	xPRE=session.getAttribute("PRE").toString().trim();
else
	xPRE="";



if(session.getAttribute("DEV")!=null  )
	xDEV=session.getAttribute("DEV").toString().trim();
else
	xDEV="";


	if(session.getAttribute("MEN")!=null  )
	xMEN=session.getAttribute("MEN").toString().trim();
else
	xMEN="";




if(session.getAttribute("SUB")!=null  )
	xSUB=session.getAttribute("SUB").toString().trim();
else
	xSUB="";


	if(session.getAttribute("EMP")!=null  )
	xEMP=session.getAttribute("EMP").toString().trim();
else
	xEMP="";


%><html>
    <head>

<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<link rel="stylesheet" href="demos.css" type="text/css" media="screen" />    
    <script type="text/javascript" src="libraries/RGraph.common.core.js" ></script>
    <script type="text/javascript" src="libraries/RGraph.bar.js" ></script>
   <script src="excanvas/excanvas.js"></script>
<script type="text/javascript">
function apply()
{
  document.frm.sub.disabled=true;
  if(document.frm.chk.checked==true)
  {
    document.frm.sub.disabled=false;
  }
  if(document.frm.chk.checked==false)
  {
    document.frm.sub.enabled=false;
  }
}


   function printPage() {
         window.print();
    }

</script> 
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
    </script>
    </head>
    <body>

<form name=frm1  >

 <input type="button" value="Print" onclick="printPage();"></input>
    <%
  //  if(!nRAP.equals("0") && !nRA.equals("0") && !nRB.equals("0") && nRBP.equals("0")  &&  nRCP.equals("0") &&  nRC.equals("0") && nRD.equals("0") ){
	///out.print("MMMMMMM"+nRBP);
    %>


    <table ALIGN=left>
        <TR align=center><TD><FONT SIZE="4" COLOR=""><B><H3>Revised Boundary </H3></B></FONT></TD></TR>

        <tr>
    <td nowrap align=left   valign=top>
    <canvas id="cvs" width="500" height="230" ALIGN=CENTER>[No canvas support]</canvas>
    <script>
        window.onload = function ()
        {
            var data = [<%=nRAP%>,<%=nRA%>,<%=nRBP%>,<%=nRB%>,<%=nRCP%>,<%=nRC%>,<%=nRD%>,<%=nRF%>,<%=xPRE%>];
            var bar = new RGraph.Bar('cvs', data);
            bar.Set('labels', ['A+','A','B+','B','C+','C','D','F','Pre-Graded']);
            bar.Set('labels.above', true);
            bar.Draw();
        }
    </script>
    <br>
	    </td></tr>



      
        </table>


<p > 
    <br>&nbsp;
    <br>
        <br>
            <br>
                <br>
                    <br>
                        <br>
                            <br><BR>
                                <br>
                                    <br>
                                  <br>
                            <br>
                                <br>

</p>
<BR>
<B>(Student Count/Grade)</B><BR>


<B>Employee:  <%=xEMP%></B><BR>

<B>Subject:  <%=xSUB%></B>
<p >
    
             
                          

</p>

	<TABLE ALIGN=CENTER rules=COLUMNS WIDTH=76% CELLSPACING=0 BORDER=1 >
	<TR>		
	<TD colspan=4 ALIGN=CENTER bgcolor="#FF00FF"  > <b> Reasons for Pre-grading students (<%=xPRE%>)</FONT></TD>
	</tr>
	<TR>
		
		<TD ALIGN=CENTER ><b>Absent in T3 End Term exam(F)&nbsp;&nbsp;-&nbsp;($)<B></TD>
		<TD ALIGN=CENTER ><b>Approved Medical cases(I)&nbsp;&nbsp;-&nbsp;(#)<B></TD>
		<TD ALIGN=CENTER ><b>UFM(F)&nbsp;&nbsp;-&nbsp;(@)<B></TD>	 
		<TD ALIGN=CENTER ><b>DEBAR(F)&nbsp;&nbsp;-&nbsp;(*)<B></TD>
		 
	</TR>	
	<TR> 
		<TD ALIGN=CENTER ><%=xABS%>  </TD>
	<TD ALIGN=CENTER ><%=xMED%> </TD>
		<TD ALIGN=CENTER > <%=xUFM%> </TD>	
		<TD ALIGN=CENTER > <%=xDEB%> </TD>		
	</TR>
</table><BR>
	    <TABLE ALIGN=CENTER rules=COLUMNS WIDTH=76% CELLSPACING=0 BORDER=1>
		<TR><TD><b>Grade</TD><TD bgcolor="#FF00FF">Pre-Graded</TD><TD bgcolor="#01B4FF">A+</TD><TD  bgcolor="#FF0000">A</TD><TD bgcolor="yellow">B+</TD><TD bgcolor=blue >B</TD><TD bgcolor="#66FFFF" >C+</TD><TD bgcolor="#B88A00">C</TD><TD bgcolor="#66FF33">D</TD><TD bgcolor="orange">F</TD></TR>
		<TR  ><TD><b>Revised Boundary</TD><td>&nbsp;</td><td colspan=8><%=xRB%></TD></TR>
		<TR><TD><b>Student Count</TD><TD><%=xPRE%> </td><td><%=nRAP%></TD><TD><%=nRA%></TD><TD><%=nRBP%></TD><TD><%=nRB%></TD><TD><%=nRCP%></TD><TD><%=nRC%></TD><TD><%=nRD%></TD><TD><%=nRF%></TD></TR>
		<tr   ><td><b>Total Student</td><td colspan=9><FONT SIZE="2" COLOR="red"><strong><%=xTOTS%></FONT></td></tr>
	<tr   ><td ><b>Deviation/Mean </td><td colspan=9><FONT SIZE="2" COLOR="red"><strong><%=xDEV%> / <%=xMEN%></td></tr></TABLE>



		<%
	//}else{	
	%>
	<!-- <TABLE align=center>
	<TR>
		<TD><FONT SIZE="" COLOR=""><B><CENTER><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR>No Revised Boundary Avialable</CENTER></B></FONT></TD>
	</TR>
	</TABLE> -->
	<%
//	}	
	%>
    </form>

</body>
    </html>