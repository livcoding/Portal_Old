<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.regex.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp,java.lang.ArrayIndexOutOfBoundsException" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp,java.lang.ArrayIndexOutOfBoundsException" %>
<%
DBHandler db=new DBHandler();
int xslno=0,k=0,t=0;
String qryddx=" delete from TEMPSTUDENTLIST ";
   //out.print("7"+qrydd);
  t=db.update(qryddx);

String xevent="",xcompanycode="",xInst="",xStudentid ="",qry="";

xevent=request.getParameter("event")==null?"":request.getParameter("event").toString().trim();
xcompanycode=request.getParameter("companycode")==null?"":request.getParameter("companycode").toString().trim();
xInst=request.getParameter("Inst")==null?"":request.getParameter("Inst").toString().trim();
xslno=Integer.parseInt(request.getParameter("slno"));


//out.print(xevent+""+xcompanycode+""+xInst+""+xslno);


 


for(int j=1;j<=xslno;j++)
      {
 if(request.getParameter("Select"+j)!=null)
           {
        //m//chk="N";
           //}
  

qry="insert into tempstudentlist(companyid,studentid,entrydate) values('"+xcompanycode+"','"+request.getParameter("Select"+j)+"',sysdate)";
//out.print(qry);
 k=db.insertRow(qry);



	 if (xStudentid.equals("")) {
                    xStudentid = xStudentid + "'" +request.getParameter("Select"+j)+ "'";
                } else {
                    xStudentid = xStudentid + ",'" +request.getParameter("Select"+j)+ "'";
                }
		   }


	//  xStudentid=request.getParameter("Select"+j).toString().trim();
	//  xStudentid=xStudentid+","+request.getParameter("Select"+j);
	  
	  }
//out.print(xStudentid+"**********"+xevent+"******"+xcompanycode+"***//****"+xInst+"*****"+xslno);

	 %>
	 
	 <HTML>
    <head>
        <TITLE>#### JIIT [Querry Criteria]</TITLE>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<script type="text/javascript" src="sh/jquery-1.4.2.min.js"></script>
 
    <script type="text/javascript" src="sh/jquery.searchabledropdown-1.0.8.min.js"></script>
	
</head>
    <body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 OnLoad="openwindow()" >
        <input type="button" style="background-color:#88000 ;border-color:black;font-weight:Bold; FONT-FAMILY: Arial; FONT-SIZE: 10pt;color: black; HEIGHT: 25px; VERTICAL-ALIGN: top; WIDTH: 95px;margin-left:2.5%" onclick="window.close();return false;" value="Close"/>
	 <form name=frm  method=post action="QuerryCriteriaEXL.jsp"  >
	 <%--input type=hidden   NAME="xStudentid" id="xStudentid" value="<%=//xStudentid%>"/--%>
	 <input type="hidden"   NAME="Inst" id="Inst" value="<%=xInst%>"/>
	 <input type=hidden   NAME="companycode" id="companycode" value="<%=xcompanycode%>"/>
	 <input type=hidden   NAME="event" id="event" value="<%=xevent%>"/>
	 	 <table cellpadding=3 cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="95%" bgcolor="white">
 
<tr bgcolor="silver"><td><H3><CENTER><B>Choose Header (In Excel)</B></CENTER></H3></td></tr></table> 
<table cellpadding=3 cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="95%" bgcolor="white"> 
<tr bgcolor="silver"><td><INPUT TYPE="checkbox" checked NAME="sln" value="1" ></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>S/No.</STRONG></font></td></tr>
<tr bgcolor="white"><td><INPUT TYPE="checkbox" checked NAME="Enrollment" value="2"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Enrollment No</STRONG></font></td></tr>
<tr bgcolor="white"><td><INPUT TYPE="checkbox" checked NAME="Enrollment" value="2"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Institute</STRONG></font></td></tr>
<tr bgcolor="silver"><td><INPUT TYPE="checkbox" checked NAME="SubSection" value="3"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>SubSection Code</STRONG></font></td></tr>
<tr bgcolor="white"><td><INPUT TYPE="checkbox" checked NAME="Student" value="4"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Student Name</STRONG></font></td></tr>
<tr bgcolor="silver"><td><INPUT TYPE="checkbox" checked NAME="Gender" value="5"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Gender</STRONG></font></td></tr>
<!-- <tr bgcolor="white"><td><INPUT TYPE="checkbox" checked NAME="Institutecod" value="6"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Institutecode</STRONG></font></td></tr> -->
<tr bgcolor="silver"><td><INPUT TYPE="checkbox" checked NAME="ProgramC" value="7"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Program</STRONG></font></td></tr>
<tr bgcolor="white"><td><INPUT TYPE="checkbox" checked NAME="BranchC" value="8"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Branch</STRONG></font></td></tr>
<tr bgcolor="silver"><td><INPUT TYPE="checkbox" checked NAME="Birth" value="9"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Date of Birth</STRONG></font></td></tr>
<tr bgcolor="white"><td><INPUT TYPE="checkbox" checked NAME="Per10" value="10"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Per.10</STRONG></font></td></tr>
<tr bgcolor="silver"><td><INPUT TYPE="checkbox" checked NAME="year10" value="11"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Year of passing 10th</STRONG></font></td></tr>
<tr bgcolor="white"><td><INPUT TYPE="checkbox" checked NAME="board10" value="12"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Board 10th</STRONG></font></td></tr>
<tr bgcolor="silver"><td><INPUT TYPE="checkbox" checked NAME="per12" value="13"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Per.12</STRONG></font></td></tr>
<tr bgcolor="white"><td><INPUT TYPE="checkbox" checked NAME="year12" value="14"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Year of passing 12th</STRONG></font></td></tr>
<tr bgcolor="silver"><td><INPUT TYPE="checkbox" checked NAME="board12" value="15"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Board 12th</STRONG></font></td></tr>
<!-- New addition -->
<tr bgcolor="white"><td><INPUT TYPE="checkbox" checked NAME="btechcgpa1" value="16"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>BTech CGPA 1</STRONG></font></td></tr>
<tr bgcolor="silver"><td><INPUT TYPE="checkbox" checked NAME="btechcgpa2" value="17"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>BTech CGPA 2</STRONG></font></td></tr>
<tr bgcolor="white"><td><INPUT TYPE="checkbox" checked NAME="btechcgpa3" value="18"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>BTech CGPA 3</STRONG></font></td></tr>
 


<tr bgcolor="silver"><td><INPUT TYPE="checkbox" checked NAME="btechcgpa4" value="19"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>BTech CGPA 4</STRONG></font></td></tr>
 


<tr bgcolor="white"><td><INPUT TYPE="checkbox" checked NAME="btechcgpa5" value="20"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>BTech CGPA 5</STRONG></font></td></tr>
 


<tr bgcolor="silver"><td><INPUT TYPE="checkbox" checked NAME="btechcgpa6" value="21"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>BTech CGPA 6</STRONG></font></td></tr>
 


<tr bgcolor="white"><td><INPUT TYPE="checkbox" checked NAME="btechcgpa7" value="22"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>BTech CGPA 7</STRONG></font></td></tr>
 

<tr bgcolor="silver"><td><INPUT TYPE="checkbox" checked NAME="btechcgpa8" value="23"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>BTech CGPA 8</STRONG></font></td></tr>



<tr bgcolor="white"><td><INPUT TYPE="checkbox" checked NAME="Pergd" value="24"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Percentage Graduation</STRONG></font></td></tr>
<tr bgcolor="silver"><td><INPUT TYPE="checkbox" checked NAME="yeargd" value="25"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Year of passing Graduation</STRONG></font></td></tr>
<tr bgcolor="white"><td><INPUT TYPE="checkbox" checked NAME="boardgd" value="26"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Collage /Univ. Of Graduation</STRONG></font></td></tr>

<tr bgcolor="silver"><td><INPUT TYPE="checkbox" checked NAME="degreegd" value="27"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Graduation Degree</STRONG></font></td></tr>
<tr bgcolor="white"><td><INPUT TYPE="checkbox" checked NAME="branchgd" value="28"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG> Graduation Branch</STRONG></font></td></tr>

<!-- <tr bgcolor="silver"><td><INPUT TYPE="checkbox" checked NAME="mtechcgpa1" value="29"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>M.Tech CGPA 1</STRONG></font></td></tr>

<tr bgcolor="white"><td><INPUT TYPE="checkbox" checked NAME="mtechcgpa2" value="30"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>M.Tech CGPA 2</STRONG></font></td></tr>


<tr bgcolor="silver"><td><INPUT TYPE="checkbox" checked NAME="mtechcgpa3" value="31"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>M.Tech CGPA 3</STRONG></font></td></tr> -->


<tr bgcolor="white"><td><INPUT TYPE="checkbox" checked NAME="studcell" value="32"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Student Cell No.</STRONG></font></td></tr>
 

<tr bgcolor="silver"><td><INPUT TYPE="checkbox" checked NAME="studemail" value="33"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Student Email ID</STRONG></font></td></tr>


<tr bgcolor="white"><td><INPUT TYPE="checkbox" checked NAME="fathername" value="34"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Father's Name </STRONG></font></td></tr>
 
<tr bgcolor="silver"><td><INPUT TYPE="checkbox" checked NAME="mothername" value="35"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Mother's Name </STRONG></font></td></tr>

<tr bgcolor="white"><td><INPUT TYPE="checkbox" checked NAME="parentcell" value="36"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Parent Cell No./ Landline</STRONG></font></td></tr>
 
<tr bgcolor="silver"><td><INPUT TYPE="checkbox" checked NAME="peraddress" value="37"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Address</STRONG></font></td></tr>


<tr bgcolor="white"><td><INPUT TYPE="checkbox" checked NAME="noofback" value="38"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>No. of Backlogs</STRONG></font></td></tr>
 

<tr bgcolor="silver"><td><INPUT TYPE="checkbox" checked NAME="remark" value="39"></td><td><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Remarks </STRONG></font></td></tr>

<tr align =center><td colspan=2><INPUT TYPE="submit" value="Load Excel"></td></tr>
 
</table>

</form>

</body>

</html>
