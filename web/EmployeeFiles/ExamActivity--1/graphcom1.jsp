
<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*,java.util.* ,java.math.* " %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 

<%  

/*
'**********************************************************************************************************
'* File Name:	MainFrame.JSP	[ For Employee ]
'* Author:		Mohit .sharma	*
'* Date:		2/15/2013       *
'* Version:		1.0				*	
'**********************************************************************************************************
 */
  String xABS="",xMED="",xUFM="",xDEB=""; 

 String xDEV="",xMEN="";
 String mTitle = "JIIT" ,mIAP="" ,mTOTS=""; 
 String mIF="",mID="",mIC="",mICP="",mIB="",mIBP="",mIA="";
 String mRF="",mRD="",mRC="",mRCP="",mRB="",mRBP="",mRA="",mRAP="",nIAP="",nIA="",nIBP="",nIB="",	nICP="",	nIC="",nID="",	nIF="";
 String sIB8="",sIB7="",sIB6="",sIB5="",sIB4="",sIB3="",sIB2="",sIB1="" ,xRB="" ,xPRE="";

String xIB8="",xIB7="",xIB6="",xIB5="",xIB4="",xIB3="",xIB2="",xIB1="",	xTOTS="";
String nRF="",nRD="",nRC="",nRCP="",nRB="",nRBP="",nRA="",nRAP="" ;


if (session.getAttribute("MemberCode")!=null && session.getAttribute("MemberType")!=null)
{





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




if(request.getParameter("IAP")==null)
		mIAP="";
	else
		mIAP=request.getParameter("IAP").toString().trim();

if(request.getParameter("IA")==null)
		mIA="";
	else
		mIA=request.getParameter("IA").toString().trim();

if(request.getParameter("IBP")==null)
		mIBP="";
	else
		mIBP=request.getParameter("IBP").toString().trim();

if(request.getParameter("IB")==null)
		mIB="";
	else
		mIB=request.getParameter("IB").toString().trim();

if(request.getParameter("ICP")==null)
		mICP="";
	else
		mICP=request.getParameter("ICP").toString().trim();

if(request.getParameter("IC")==null)
		mIC="";
	else
		mIC=request.getParameter("IC").toString().trim();

if(request.getParameter("ID")==null)
		mID="";
	else
		mID=request.getParameter("ID").toString().trim();

if(request.getParameter("IF")==null)
		mIF="";
	else
		mIF=request.getParameter("IF").toString().trim();

//initial boundary


if(request.getParameter("IB1")==null)
		sIB1="";
	else
		sIB1=request.getParameter("IB1").toString().trim();

if(request.getParameter("IB2")==null)
		sIB2="";
	else
		sIB2=request.getParameter("IB2").toString().trim();

if(request.getParameter("IB3")==null)
		sIB3="";
	else
		sIB3=request.getParameter("IB3").toString().trim();

if(request.getParameter("IB4")==null)
		sIB4="";
	else
		sIB4=request.getParameter("IB4").toString().trim();

if(request.getParameter("IB5")==null)
		sIB5="";
	else
		sIB5=request.getParameter("IB5").toString().trim();

if(request.getParameter("IB6")==null)
		sIB6="";
	else
		sIB6=request.getParameter("IB6").toString().trim();

if(request.getParameter("IB7")==null)
		sIB7="";
	else
		sIB7=request.getParameter("IB7").toString().trim();

if(request.getParameter("IB8")==null)
		sIB8="";
	else
		sIB8=request.getParameter("IB8").toString().trim();


if(request.getParameter("RRB")==null)
		xRB="";
	else
		xRB=request.getParameter("RRB").toString().trim();


if(request.getParameter("DEV")==null)
		xDEV="";
	else
		xDEV=request.getParameter("DEV").toString().trim();

if(request.getParameter("MEN")==null)
		xMEN="";
	else
		xMEN=request.getParameter("MEN").toString().trim();

 
  
//System.out.println("##########"+xDEV+"@@@@@@@@@"+xMEN);

session.setAttribute("DEV",xDEV);
session.setAttribute("MEN",xMEN);
session.setAttribute("IAP",mIAP);
session.setAttribute("IA",mIA);
session.setAttribute("IBP",mIBP);
session.setAttribute("IB",mIB);
session.setAttribute("ICP",mICP);
session.setAttribute("IC",mIC);
session.setAttribute("ID",mID);
session.setAttribute("IF",mIF);
session.setAttribute("IB8",sIB8);
session.setAttribute("IB7",sIB7);
session.setAttribute("IB6",sIB6);
session.setAttribute("IB5",sIB5);
session.setAttribute("IB4",sIB4);
session.setAttribute("IB3",sIB3);
session.setAttribute("IB2",sIB2);
session.setAttribute("IB1",sIB1);
session.setAttribute("RRB",xRB);

//System.out.println(xRB);
//-----Revised Bpundary

if(request.getParameter("RAP")==null)
		mRAP="";
	else
		mRAP=request.getParameter("RAP").toString().trim();


if(request.getParameter("RA")==null)
		mRA="";
	else
		mRA=request.getParameter("RA").toString().trim();

if(request.getParameter("RBP")==null)
		mRBP="";
	else
		mRBP=request.getParameter("RBP").toString().trim();

if(request.getParameter("RB")==null)
		mRB="";
	else
		mRB=request.getParameter("RB").toString().trim();

if(request.getParameter("RCP")==null)
		mRCP="";
	else
		mRCP=request.getParameter("RCP").toString().trim();

if(request.getParameter("RC")==null)
		mRC="";
	else
		mRC=request.getParameter("RC").toString().trim();

if(request.getParameter("RD")==null)
		mRD="";
	else
		mRD=request.getParameter("RD").toString().trim();

if(request.getParameter("RF")==null)
		mRF="";
	else
		mRF=request.getParameter("RF").toString().trim();


if(request.getParameter("TOTS")==null)
		mTOTS="";
	else
		mTOTS=request.getParameter("TOTS").toString().trim();

if(request.getParameter("PRE")==null)
		xPRE="";
	else
		xPRE=request.getParameter("PRE").toString().trim();



if(session.getAttribute("TOTS")!=null  )
	xTOTS=session.getAttribute("TOTS").toString().trim();
else
	xTOTS="";

 
if(request.getParameter("ABS")==null)
		xABS="";
	else
		xABS=request.getParameter("ABS").toString().trim();
	if(request.getParameter("MED")==null)
		xMED="";
	else
		xMED=request.getParameter("MED").toString().trim();
	if(request.getParameter("UFM")==null)
		xUFM="";
	else
		xUFM=request.getParameter("UFM").toString().trim();
	if(request.getParameter("DEB")==null)
		xDEB="";
	else
		xDEB=request.getParameter("DEB").toString().trim();


	
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

      
session.setAttribute("ABS",xABS);
session.setAttribute("MED",xMED);
session.setAttribute("UFM",xUFM);
session.setAttribute("DEB",xDEB);



session.setAttribute("PRE",xPRE);
session.setAttribute("TOTS",mTOTS);
session.setAttribute("RAP",mRAP);
session.setAttribute("RA",mRA);
session.setAttribute("RBP",mRBP);
session.setAttribute("RB",mRB);
session.setAttribute("RCP",mRCP);
session.setAttribute("RC",mRC);
session.setAttribute("RD",mRD);
session.setAttribute("RF",mRF);
// System.out.println("TESTINGNNGNGNGNGN"+xABS+""+xDEB);
%>

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

   function printPage() {
         window.print();
    }
/*
var i = 0;
alert("dddddddd"+document.getElementById("cvs"+i).value);
while (document.getElementById("cvs" + i)) {
	alert("dddddddd");
   draw(document.getElementById("cvs" + i).getContext("2d"));
   i ++;       
}

function draw(ctx)
{alert("dddd");
    var grd=ctx.createLinearGradient(0,0,175,50);
    grd.addColorStop(0,"#E05D1B");
    grd.addColorStop(1,"#00FF00");
    ctx.fillStyle=grd;
    ctx.fillRect(0,0,275,50);
}*/
 alert("vv1");
            var data = [<%=nIAP%>,<%=nIA%>,<%=nIBP%>,<%=nIB%>,<%=nICP%>,<%=nIC%>,<%=nID%>,<%=nIF%>,<%=xPRE%>];
            var bar = new RGraph.Bar('cvs', data);
            bar.Set('labels', ['A+','A','B+','B','C+','C','D','F','Pre-Graded']);
            bar.Set('labels.above', true);
            //bar.draw(document.getElementById("cvs0").getContext("2d"));
            bar.Draw();
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

	   #printable3 {
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
<TD><FONT SIZE="4" COLOR=""><B><H3>Initial Boundary</H3></B></FONT>
</TD></TR><tr>



<br>

<td nowrap align=left   valign=top>


<div style="position: relative;">

  <canvas id="cvs"   width="500" height="230"  ALIGN=left style="position: absolute;
    top: 50px; left: 50px;" >[No canvas support]</canvas>

</div>


 </td>
 
 </tr>

 <TR align=left><TD><B>(Student Count/Grade)</B></TR></table>

</td>
</tr>
</div>



<div align="left" id="printable1"  >
<tr>
<td width="100%">
    <br>
    <br>
        <br>
            <br>
                <br>
                    <br>
                        <br>
                            <br>
                                <br>
                                    <br>
                                  <br>
                            <br>
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




<tr>
<td>

<div align="left" id="printable3"  >

    <table ALIGN=left>
        <TR align=center><TD><FONT SIZE="4" COLOR=""><B><H3>Revised Boundary</H3></B></FONT></TD></TR>

        <tr>
    <td nowrap align=left   valign=top>
<div style="position: relative;">

 

    <canvas id="cvs1" width="500" height="230" ALIGN=CENTER style="position: absolute;
    top: 50px; left: 50px;" >[No canvas support]</canvas>

</div>
    <script>
        window.onload = function  ()
        {
          //  alert("vv2");
            var data1 = [<%=nRAP%>,<%=nRA%>,<%=nRBP%>,<%=nRB%>,<%=nRCP%>,<%=nRC%>,<%=nRD%>,<%=nRF%>,<%=xPRE%>];
            var bar1 = new RGraph.Bar('cvs1', data1);
            bar1.Set('labels', ['A+','A','B+','B','C+','C','D','F','Pre-Graded']);
            bar1.Set('labels.above', true);
           // bar1.draw(document.getElementById("cvs1").getContext("2d
            bar1.Draw();
       //     bar.Draw();
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
                            <br>
                                <br>
                                    <br>
                                  <br>
                            <br>
                                <br>
                                        <br>
                                <br>

</p>

<B>(Student Count/Grade)</B>
<p >
    <br>&nbsp;
    <br>
        <br>
            <br>
                <br>
               
                          

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
	<tr   ><td ><b>Deviation/Mean </td><td colspan=9><FONT SIZE="2" COLOR="red"><strong><%=xDEV%> / <%=xMEN%></td></tr>
	
	</TABLE>



</div>
</td>
</tr>


</table>
</div>

</form>

</body>
</html>
<%
}
else
{
%>
<br>
Session timeout! Please <a href="../index.jsp">Login</a> to continue...
<%
}
%>


 