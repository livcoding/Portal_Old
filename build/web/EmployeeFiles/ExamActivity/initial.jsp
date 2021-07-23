<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*,java.util.* ,java.math.* " %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String xDEV="",xMEN="";
 
String xEMP="",xSUB="";
String mHead="";
String  qrycase="",sFSTIDS="" ,CALVALAP="",CALVALF="" ,nIAP="" ,xTOTS="";
String nIF="",nID="",nIC="",nICP="",nIB="",nIBP="",nIA="";
String xIB8="",xIB7="",xIB6="",xIB5="",xIB4="",xIB3="",xIB2="",xIB1="",xPRE="";
int mAbsentc=0,mMedicalc=0,mUFMc=0,mProdatac=0,mDebarrc=0;
  String xABS="",xMED="",xUFM="",xDEB=""; 



int COUNTFI=0,RounDCount=0,GradeMasterLowerLimitInt=0;

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT";

if(session.getAttribute("DEV")!=null  )
	xDEV=session.getAttribute("DEV").toString().trim();
else
	xDEV="";


	if(session.getAttribute("MEN")!=null  )
	xMEN=session.getAttribute("MEN").toString().trim();
else
	xMEN="";



if(session.getAttribute("IAP")!=null  )
	nIAP=session.getAttribute("IAP").toString().trim();
else
	nIAP="";

	
	if(session.getAttribute("IA")!=null  )
	nIA=session.getAttribute("IA").toString().trim();
else
	nIA="";

	if(session.getAttribute("IBP")!=null  )
	nIBP=session.getAttribute("IBP").toString().trim();
else
	nIBP="";

	if(session.getAttribute("IB")!=null  )
	nIB=session.getAttribute("IB").toString().trim();
else
	nIB="";

	if(session.getAttribute("ICP")!=null  )
	nICP=session.getAttribute("ICP").toString().trim();
else
	nICP="";

	if(session.getAttribute("IC")!=null  )
	nIC=session.getAttribute("IC").toString().trim();
else
	nIC="";

	if(session.getAttribute("ID")!=null  )
	nID=session.getAttribute("ID").toString().trim();
else
	nID="";

	if(session.getAttribute("IF")!=null  )
	nIF=session.getAttribute("IF").toString().trim();
else
	nIF="";


//Ini Boundry


	if(session.getAttribute("IB8")!=null  )
	xIB8=session.getAttribute("IB8").toString().trim();
else
	xIB8="";

if(session.getAttribute("IB7")!=null  )
	xIB7=session.getAttribute("IB7").toString().trim();
else
	xIB7="";
	if(session.getAttribute("IB6")!=null  )
	xIB6=session.getAttribute("IB6").toString().trim();
else
	xIB6="";
	if(session.getAttribute("IB5")!=null  )
	xIB5=session.getAttribute("IB5").toString().trim();
else
	xIB5="";
	if(session.getAttribute("IB4")!=null  )
	xIB4=session.getAttribute("IB4").toString().trim();
else
	xIB4="";
	if(session.getAttribute("IB3")!=null  )
	xIB3=session.getAttribute("IB3").toString().trim();
else
	xIB3="";
	if(session.getAttribute("IB2")!=null  )
	xIB2=session.getAttribute("IB2").toString().trim();
else
	xIB2="";
	if(session.getAttribute("IB1")!=null  )
	xIB1=session.getAttribute("IB1").toString().trim();
else
	xIB1="";


if(session.getAttribute("TOTS")!=null  )
	xTOTS=session.getAttribute("TOTS").toString().trim();
else
	xTOTS="";

if(session.getAttribute("PRE")!=null  )
	xPRE=session.getAttribute("PRE").toString().trim();
else
	xPRE="";



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



if(session.getAttribute("EMP")!=null  )
	xEMP=session.getAttribute("EMP").toString().trim();
else
	xEMP="";

	if(session.getAttribute("SUB")!=null  )
	xSUB=session.getAttribute("SUB").toString().trim();
else
	xSUB="";
   
//out.print("Hello"+nIAP);

%>
<html>
<head>

<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css"/>
<link rel="stylesheet" href="demos.css" type="text/css" media="screen"/>    
<script type="text/javascript" src="libraries/RGraph.common.core.js" ></script>
<script type="text/javascript" src="libraries/RGraph.bar.js" ></script>



<script type="text/javascript" src="libraries/excanvas.js" ></script>
<script type="text/javascript" src="libraries/excanvas.compiled.js" ></script>
 <script src="excanvas/excanvas.js"></script>

<script src="excanvas.js"></script> 
<script src="excanvas.compiled.js"></script>

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
<script src="excanvas.js"></script> 
<script src="excanvas.compiled.js"></script>
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
</script>

 <style type="text/css" media="print">
    @media print
    {
 #print {
    display: block;
       width: 100%;
    height: 100%;
    }

    #printable {
    display: block;
      width: 100%;
    height: 100%;
    }

	
    #printable1 {
    display: block;
      width: 100%;
    height: 100%;
    }


    #printable2 {
    display: block;
      width: 100%;
    height: 100%;
    }

    }

    </style>

</head>

<body >
<form name=frm1  >
 <input type="button" value="Print" onclick="printPage();"></input>


<div align="left" id="print" >

<table align=left >
    <div align="left" id="printable" >
<tr valign=top>
<td align=left valign=top >

<table ALIGN=left><TR align=center>
<TD><FONT SIZE="4" COLOR=""><B><H3>Initial Boundary </H3></B></FONT>
</TD></TR><tr>
<td nowrap align=left   valign=top>

  <canvas id="cvs" width="500" height="230" ALIGN=left>[No canvas support]</canvas>

    <script> 
        window.onload = function ()     
        {
            var data = [<%=nIAP%>,<%=nIA%>,<%=nIBP%>,<%=nIB%>,<%=nICP%>,<%=nIC%>,<%=nID%>,<%=nIF%>,<%=xPRE%>];
            var bar = new RGraph.Bar('cvs', data);
            bar.Set('labels', ['A+','A','B+','B','C+','C','D','F','Pre-Graded']);
            bar.Set('labels.above', true);
            bar.Draw();
        }
    </script>
 </td></tr><TR align=left><TD><B>(Student Count/Grade)</B></TR></table>

</td>
</tr><tr><td>
<B>Employee:  <%=xEMP%></B></td></tr>
<tr><td>
<B>Subject:  <%=xSUB%></B></td></tr>
</div>



<div align="left" id="printable1"  >
<tr>
<td width="100%">
    <br>
           
</td>
</tr>

</div>

<div align="left" id="printable2"  >

<tr>
<td  align="left" >

 <table align=CENTER rules=COLUMNS WIDTH=76% CELLSPACING=0 BORDER=1 >
	<TR >		
	<TD colspan=4 ALIGN=CENTER bgcolor="#FF00FF" > <b> Reasons for Pre-grading students  (<%=xPRE%>)</FONT></TD>
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

 <TABLE  ALIGN=CENTER rules=COLUMNS WIDTH=76% CELLSPACING=0 BORDER=1>
	<TR ><TD><b>Grade</TD><TD bgcolor="#FF00FF"> Pre-Graded </TD><TD bgcolor="#01B4FF"> A+</TD><TD bgcolor="#FF0000"> A</TD><TD bgcolor="yellow"> B+</TD><TD bgcolor=blue> B</TD><TD bgcolor="#66FFFF"> C+</TD><TD bgcolor="#B88A00"> C</TD><TD bgcolor="#66FF33"> D</TD><TD bgcolor="orange"> F</TD></TR>
	<TR><TD><b>Initial Boundary</TD><td>&nbsp;</td><TD><%=xIB1%></TD><TD><%=xIB2%></TD><TD><%=xIB3%></TD><TD><%=xIB4%></TD><TD><%=xIB5%></TD><TD><%=xIB6%></TD><TD><%=xIB7%></TD><TD><%=xIB8%></TD></TR>
		<TR><TD><b>Student Count</TD><TD><%=xPRE%> </TD><TD><%=nIAP%></TD><TD><%=nIA%></TD><TD><%=nIBP%></TD><TD><%=nIB%></TD><TD><%=nICP%></TD><TD><%=nIC%></TD><TD><%=nID%></TD><TD><%=nIF%></TD></TR><tr   ><td ><b>Total Student</td><td colspan=9><FONT SIZE="2" COLOR="red"><strong><%=xTOTS%></td></tr>
		
		
			<tr   ><td ><b>Deviation/Mean </td><td colspan=9><FONT SIZE="2" COLOR="red"><strong><%=xDEV%> / <%=xMEN%></td></tr></TABLE>
			

</td>
</tr>

 </div>

</table>
</div>

</form>

</body>
</html>

 