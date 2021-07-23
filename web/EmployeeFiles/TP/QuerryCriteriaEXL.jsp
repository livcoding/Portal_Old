<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.*,java.util.regex.*;" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp,java.lang.ArrayIndexOutOfBoundsException" %>
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
<%try{
int hh=0;
DBHandler db = new DBHandler();
String qrytt="",qrydd="";
String qryud="", qryudd="",mresister="Y",mSpecial="";
String QERCLORRN="";
int rsum=0,ssum=0,tsum=0,usum=0,vsum=0,wsum=0;
String QrySet="",QrySetC="",QrySetCC="",qry4="" ,qry2="",qry3="",xSet="",mCritvales="",mcolor="#F2F2F2",QERCLOR="",andor="",Qryinsert="",mTPUNIUQUEID="";
		String  QryIns="",CGPA7="";
        ResultSet rs =  null ,rsSet=null,rsIns=null,rs4=null,rsqryud=null,rsQERCLORRN=null;
		ResultSet rst = null;
		ResultSet rsf=  null ;
        ResultSet rsd = null;
        ResultSet rs1 = null,rsQERCLOR=null,rs5=null;
        ResultSet rs2 = null;
        ResultSet rsc = null,rsQERCLORR=null;
        String xevent="",xcompanycode="";int xslno=0;
		String qry = "" ,qryc="",mSUBB="",mSUBN="", mLTP="",qry1="",inst="",institute="",academic="",academicyear="",QERCLORR="";
		String qryt = "",Event="",Programcode="",Companycode="";
        GlobalFunctions gb = new GlobalFunctions();
	    String mRegCode = "",event="", Academicyear="";
        String mEXAMCODE = "" ,mSubjID="",DataSublist="" ,mProgCode="",QryProgCode="",companycode="";
        String mAcademicYear = "",program="",programcode="";
        String mProgramCode = "";
        String mInstCode = "",xStudentid="";
		String  mreg="" ;
		String mHOSTELTYPE = "" , macade="" ,mbranc="" ,sem="",semester="",branch="",branchcode="" ;
		String mprog="",enddate="",fromdate="";
		String mBranchCode = "",msid="",mCode="",mES="",mSubj1="",qrysubj="",Subject="";
        int n=0 ,countI=0,csst=1;
        String qryx="",mLTP1="",Branch="",xInst="";
        ResultSet rsx=null,rs3=null,RsF=null;
        String reqAction="",qryF="";
		String mInst="",mSubject="",minst="" ,qrys="",Semester="",qry5="";
		int rsum80t1=0,rsum80t2=0,rsum80t3=0,ssum70t1=0,ssum70t2=0,ssum70t3=0,tsum60t1=0,tsum60t2=0,tsum60t3=0,
					usum50t1=0,usum50t2=0,usum50t3=0,vsum40t1=0,vsum40t2=0,vsum40t3=0,wsum30t1=0,wsum30t2=0,wsum30t3=0;
		int count=0 ,Flag=0,slno=0;

xevent=request.getParameter("event")==null?"":request.getParameter("event").toString().trim();
xcompanycode=request.getParameter("companycode")==null?"":request.getParameter("companycode").toString().trim();
xInst=request.getParameter("Inst")==null?"":request.getParameter("Inst").toString().trim();

String  sln="",Enrollment="", SubSection="",Student="",Gender="",Institutecod="",ProgramC="",BranchC="",Birth ="",Per10="",year10 ="",board10="",per12 ="",year12 ="",board12="";
String btechcgpa1="",btechcgpa2="",btechcgpa3="",btechcgpa4="",btechcgpa5="",btechcgpa6="",btechcgpa7="",btechcgpa8="";
String  Pergd="",yeargd ="",boardgd ="",degreegd ="",branchgd="",mtechcgpa1="",mtechcgpa2="",mtechcgpa3="";
String studcell="",studemail="",fathername="",mothername="",parentcell="",peraddress="",noofback="",remark="";
// Header valuesboardgd
sln=request.getParameter("sln")==null?"":request.getParameter("sln").toString().trim();
Enrollment= (request.getParameter("Enrollment"))==null?"":request.getParameter("Enrollment").toString().trim();
SubSection= (request.getParameter("SubSection"))==null?"":request.getParameter("SubSection").toString().trim();
Student= (request.getParameter("Student"))==null?"":request.getParameter("Student").toString().trim();
Gender= (request.getParameter("Gender"))==null?"":request.getParameter("Gender").toString().trim();
Institutecod= (request.getParameter("Inst"))==null?"":request.getParameter("Inst").toString().trim();
ProgramC= (request.getParameter("ProgramC"))==null?"":request.getParameter("ProgramC").toString().trim();
BranchC= (request.getParameter("BranchC"))==null?"":request.getParameter("BranchC").toString().trim();
Birth = (request.getParameter("Birth"))==null?"":request.getParameter("Birth").toString().trim();
year10 = (request.getParameter("year10"))==null?"":request.getParameter("year10").toString().trim();
board10= (request.getParameter("board10"))==null?"":request.getParameter("board10").toString().trim();
per12 = (request.getParameter("per12"))==null?"":request.getParameter("per12").toString().trim();
year12 = (request.getParameter("year12"))==null?"":request.getParameter("year12").toString().trim();
board12= (request.getParameter("board12"))==null?"":request.getParameter("board12").toString().trim();
btechcgpa1= (request.getParameter("btechcgpa1"))==null?"":request.getParameter("btechcgpa1").toString().trim();
btechcgpa2= (request.getParameter("btechcgpa2"))==null?"":request.getParameter("btechcgpa2").toString().trim();
btechcgpa3= (request.getParameter("btechcgpa3"))==null?"":request.getParameter("btechcgpa3").toString().trim();
btechcgpa4= (request.getParameter("btechcgpa4"))==null?"":request.getParameter("btechcgpa4").toString().trim();
btechcgpa5= (request.getParameter("btechcgpa5"))==null?"":request.getParameter("btechcgpa5").toString().trim();
btechcgpa6= (request.getParameter("btechcgpa6"))==null?"":request.getParameter("btechcgpa6").toString().trim();
btechcgpa7= (request.getParameter("btechcgpa7"))==null?"":request.getParameter("btechcgpa7").toString().trim();
btechcgpa8= (request.getParameter("btechcgpa8"))==null?"":request.getParameter("btechcgpa8").toString().trim();
Pergd= (request.getParameter("Pergd"))==null?"":request.getParameter("Pergd").toString().trim();
yeargd = (request.getParameter("yeargd"))==null?"":request.getParameter("yeargd").toString().trim();
boardgd = (request.getParameter("boardgd"))==null?"":request.getParameter("boardgd").toString().trim();
degreegd = (request.getParameter("degreegd"))==null?"":request.getParameter("degreegd").toString().trim();
branchgd= (request.getParameter("branchgd"))==null?"":request.getParameter("branchgd").toString().trim();
//mtechcgpa1= (request.getParameter("mtechcgpa1"))==null?"":request.getParameter("mtechcgpa1").toString().trim();
//mtechcgpa2= (request.getParameter("mtechcgpa2"))==null?"":request.getParameter("mtechcgpa2").toString().trim();
//mtechcgpa3= (request.getParameter("mtechcgpa3"))==null?"":request.getParameter("mtechcgpa3").toString().trim();
studcell= (request.getParameter("studcell"))==null?"":request.getParameter("studcell").toString().trim();
studemail= (request.getParameter("studemail"))==null?"":request.getParameter("studemail").toString().trim();
fathername= (request.getParameter("fathername"))==null?"":request.getParameter("fathername").toString().trim();
mothername= (request.getParameter("mothername"))==null?"":request.getParameter("mothername").toString().trim();
parentcell= (request.getParameter("parentcell"))==null?"":request.getParameter("parentcell").toString().trim();
peraddress= (request.getParameter("peraddress"))==null?"":request.getParameter("peraddress").toString().trim();
noofback= (request.getParameter("noofback"))==null?"":request.getParameter("noofback").toString().trim();
remark= (request.getParameter("remark"))==null?"":request.getParameter("remark").toString().trim();



    //xslno= (request.getParameter("slno"));

 //ryF=" execute TP.POPTPQUALIFICATION ";
 //int x=db.update(qryF);

 //out.print(xevent+"@@@@@@@@@"+studcell+"#######"+peraddress+"****"+remark);

/*for(int j=1;j<=xslno;j++)
      {



 if(request.getParameter("Select"+j)!=null)
           {
        //m//chk="N";
           //}

	 if (xStudentid.equals("")) {
                    xStudentid = xStudentid + "'" +request.getParameter("Select"+j)+ "'";
                } else {
                    xStudentid = xStudentid + ",'" +request.getParameter("Select"+j)+ "'";
                }
		   }*/


	//  xStudentid=request.getParameter("xStudentid").toString().trim();
	//  xStudentid=xStudentid+","+request.getParameter("Select"+j);

	 // }
	 // out.print(xStudentid);

int ttsum1=0,ttsum2=0,ttsum3=0;

//if (session.getAttribute("InstituteCode") == null)
//	mInst = "";
//else
	//mInst = session.getAttribute("InstituteCode").toString().trim();


//out.print(mInst+"11"+xevent+"22"+xcompanycode+"333"+xInst+"****************"+xslno+"*********"+xStudentid);
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
    <body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >

<%@page contentType="text/html"%>
	   	<%
		response.setContentType("application/vnd.ms-excel");
		%>
<%response.setHeader("Content-Disposition", "attachment; filename=QueryCriteriaEXL.jsp.xls");%>

 <table cellpadding=3 cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="90%" bgcolor="white">
<tr bgcolor="silver">
        <td colspan=0 align=middle colspan="36">
            <font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><FONT SIZE="4" COLOR=""><B>T & P EVENT PARTICIPENTS</B></FONT></font></td></tr>
        </table>



<table cellpadding=3 cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="90%" bgcolor="white">
<tr bgcolor="silver">
 <td  bgcolor="#F2F2F2" colspan="9"><B>Student(s) In Criteria  </B></td>
<td  bgcolor="red" colspan="9"><B>Not Intrested student(s) </B></td>
<td bgcolor="#90EE90" colspan="9"><B>Intrested  student(s)</B></td>
<td  bgcolor="#FFD000" colspan="9"><B>Special Case student(s) </B></td>
</tr>
</table>




<table cellpadding=3 cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="90%" bgcolor="white">
<tr bgcolor="silver" align="left">



<%
if(!sln.equals("")){
%>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>S/No.</STRONG></font></th>
<%
}
%>

<%
if(!Enrollment.equals("")){
%>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Student TP-ID</STRONG></font></th>
<%
}
%>

<%
if(!SubSection.equals("")){
%>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>SubSection Code</STRONG></font></th>
<%
}
%>
<%
if(!Student.equals("")){
%>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Studentname</STRONG></font></th>
<%
}
%>
<%
if(!Gender.equals("")){
%>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Gender</STRONG></font></th>
<%
}
%>
<%
if(!Enrollment.equals("")){
%>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Enrollment</STRONG></font></th>
<%
}
%>
<%
if(!Institutecod.equals("")){
%>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Institutecode</STRONG></font></th>
<%
}
%>

<%
if(!ProgramC.equals("")){
%>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Program</STRONG></font></th>
<%
}
%>


<%
if(!BranchC.equals("")){
%>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Branch</STRONG></font></th>
<%
}
%>
<%
if(!Birth.equals("")){
%>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Date of Birth</STRONG></font></th>
<%
}
%>


<%
if(!Per10.equals("")){
%>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Per.10</STRONG></font></th>
<%
}
%>

<%
if(!year10.equals("")){
%>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Year of passing10th</STRONG></font></th>
<%
}
%>

<%
if(!board10.equals("")){
%>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Board 10th</STRONG></font></th>
<%
}
%>

<%
if(!per12.equals("")){
%>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Per.12</STRONG></font></th>
<%
}
%>

<%
if(!year12.equals("")){
%>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Year of passing12th</STRONG></font></th>
<%
}
%>

<%
if(!board12.equals("")){
%>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Board 12th</STRONG></font></th>
<%
}
%>

<%
if(!btechcgpa1.equals("")){
%>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>B.Tech CGPA 1</td>
<%
}
%>

<%
if(!btechcgpa2.equals("")){
%>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>B.Tech CGPA 2</td>
<%
}
%>

<%
if(!btechcgpa3.equals("")){
%>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>B.Tech CGPA 3</td>
<%
}
%>

<%
if(!btechcgpa4.equals("")){
%>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>B.Tech CGPA 4</td>
<%
}
%>

<%
if(!btechcgpa5.equals("")){
%>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>B.Tech CGPA 5</td>
<%
}
%>

<%
if(!btechcgpa6.equals("")){
%>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>B.Tech CGPA 6</td>
<%
}
%>

<%
if(!btechcgpa7.equals("")){
%>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>B.Tech CGPA 7</td>
<%
}
%>

<%
if(!btechcgpa8.equals("")){
%>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>B.Tech CGPA 8</td>
<%
}
%>

<%
if(!Pergd.equals("")){
%>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Grad.Per</td>
<%
}
%>

<%
if(!yeargd.equals("")){
%>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Grad.Year</td>
<%
}
%>

<%
if(!boardgd.equals("")){
%>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Grad.University</td>
<%
}
%>


<%
if(!degreegd.equals("")){
%>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Grad.Degree</td>
<%
}
%>


<%
if(!branchgd.equals("")){
%>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Stream</td>
<%
}
%>

<%
if(!studcell.equals("")){
%>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Student Cell</STRONG></font></th>
<%
}
%>

<%
if(!studemail.equals("")){
%>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Student E-MailID</STRONG></font></th>
<%
}
%>


<%
if(!fathername.equals("")){
%>
 <th><font  face=arial size=2 color="#a52a2a"><STRONG>Father Name</STRONG></font></th>
<%
}
%>

<%
if(!mothername.equals("")){
%>
<th><font  face=arial size=2 color="#a52a2a"><STRONG>mother Name</STRONG></font></th>
<%
}
%>

<%
if(!parentcell.equals("")){
%>
<th><font  face=arial size=2 color="#a52a2a"><STRONG>Parent Phone</STRONG></font></th>
<%
}
%>

<%
if(!peraddress.equals("")){
%>
<th colspan="2"><font  face=arial size=2 color="#a52a2a"><STRONG> Address</STRONG></font>
<table><tr>
     <th><font  face=arial size=2 color="#a52a2a"><STRONG>Current Address</STRONG></th><th><font  face=arial size=2 color="#a52a2a"><STRONG>Permanent Address</STRONG></th>
</tr></table></th>
<%
}
%>

<%
if(!noofback.equals("")){
%>
<th><font  face=arial size=2 color="#a52a2a"><STRONG>No. Of Back</STRONG></font></th>
<%
}
%>







<!-- <th><font  face=arial size=2 color="#a52a2a"><STRONG>Remarks</STRONG></font></th>   -->

</tr>

<%
try{

      qry=" SELECT DISTINCT a.studentid, NVL (a.institutecode, '') institutecode, a.sex,                NVL (TO_CHAR (a.dateofbirth, 'dd-mm-yyyy'), 'N/A') dob,                nvl(c.per12,'')per12, nvl(c.per10,'')per10, nvl(c.boardname10,'-')boardname10, nvl(c.boardname12,'-')boardname12,                nvl( c.yearofpassing10,'')yearofpassing10, nvl(c.yearofpassing12,'')yearofpassing12,                NVL (a.academicyear, '') academicyear,                NVL (a.enrollmentno, '') enrollmentno,                NVL (a.studentname, '') studentname,                NVL (a.programcode, '') programcode,                NVL (a.branchcode, '') branchcode,                NVL (a.sectioncode, '') sectioncode,                NVL (a.subsectioncode, '') subsectioncode,                NVL (a.semester, '') semester,  NVL (c.perug, '')perug,  NVL (c.perpg, '')perpg,  NVL (e.stcellno, '')stcellno,                 NVL (e.stemailid, '')stemailid,  NVL (a.fathername, '')fathername,  NVL (a.mothername, '')mothername,";
      qry=qry+"   (e.pastdcode || '-' || e.patelno) plandline,";
      qry=qry+"   (   f.paddress1";
      qry=qry+"   || ' '";
      qry=qry+"   || f.paddress2";
      qry=qry+"   || '  '";
      qry=qry+"   || f.paddress3";
      qry=qry+"   || '  '";
      qry=qry+"   || f.pdistrict";
      qry=qry+"   || ' '";
      qry=qry+"   || f.pcity";
      qry=qry+"   || ' '";
      qry=qry+"   || f.pstate";
      qry=qry+"   || ' '";
      qry=qry+"   || ppin";
      qry=qry+"   ) permanentadd";
      qry=qry+"  , (F.CADDRESS1||' '||F.CADDRESS2||' '||F.CADDRESS3||' '|| f.pdistrict  || ' ' || f.ccity  || ' '   || f.cstate " +
              "  || ' '   || f.cpin) CADDRESSAdd ";
      qry=qry+" FROM v#studentmaster a,";
      qry=qry+" tp#studentdata b,";
      qry=qry+" tp#studentqualification c,";
      qry=qry+" v#studentsgpacgpa d,";
      qry=qry+" v#studentphone e,";
      qry=qry+" v#studentaddress f   where nvl(a.deactive,'N')='N' and a.institutecode IN ("+xInst+")  " ;
      qry=qry+" AND a.studentid IS NOT NULL";
      qry=qry+" AND a.studentid = b.studentid(+)";
	  qry=qry+" AND a.studentid = c.studentid(+)";
	  qry=qry+" AND a.studentid = d.studentid(+)";
      qry=qry+" AND a.studentid = e.studentid(+)";
      qry=qry+" AND a.studentid = f.studentid(+)";
	  qry=qry+" AND b.programcode = a.programcode";
      qry=qry+" AND b.branchcode = a.branchcode";
	  qry=qry+" AND b.semester = a.semester";
	 // qry=qry+" AND b.semester = d.semester";
	  qry=qry+" AND a.academicyear = b.academicyear";
      qry=qry+" AND a.institutecode = b.institutecode(+)";
	  qry=qry+" AND a.institutecode = c.institutecode(+) " +
              "AND a.institutecode = d.institutecode(+)" +
              " AND a.institutecode = e.institutecode(+)";
	  qry=qry+" ";
      qry=qry+" AND a.institutecode = f.institutecode(+)";
      qry=qry+" and a.institutecode||a.studentid IN (select  t.studentid from tempstudentlist t where a.institutecode||a.studentid=t.studentid) ";
      qry=qry+" Order by Studentname ";
	// System.out.println(qry + "<<<<>>>");
	  rs=db.getRowset(qry);


while(rs.next())
{
	mTPUNIUQUEID="TP-"+rs.getString("studentid");

slno++;
int hhh=0;
QERCLOR=" select studentid from  TEMP#TPSTUDENTMASTER where studentid='"+rs.getString("studentid")+"' and companycode='"+xcompanycode+"' and eventcode='"+xevent+"'  ";
rsQERCLOR=db.getRowset(QERCLOR);
//out.print(slno+"-"+QERCLOR);
if(rsQERCLOR.next())
{
	mcolor="#FFD000";
	hhh=1;
}


int yyy=0;
QERCLORR=" select studentid from   TP#REGISTRATIONDETAIL where studentid='"+rs.getString("studentid")+"' and companycode='"+xcompanycode+"' and eventcode='"+xevent+"' and nvl(status,'A')='I' ";
rsQERCLORR=db.getRowset(QERCLORR);
//out.print(slno+"-"+QERCLOR);
 if(rsQERCLORR.next())
{
	mcolor="#90EE90";
	yyy=1;
}


int xxx=0;
QERCLORRN=" select studentid from   TP#REGISTRATIONDETAIL where studentid='"+rs.getString("studentid")+"' and companycode='"+xcompanycode+"' and eventcode='"+xevent+"' and nvl(status,'A')='N' ";
rsQERCLORRN=db.getRowset(QERCLORRN);
//out.print(slno+"-"+QERCLOR);
 if(rsQERCLORRN.next())
{
	mcolor="red";
	xxx=1;
}


if(yyy ==0 && hhh==0 && xxx==0 ){
mcolor="#F2F2F2";
hhh=0;
yyy=0;
xxx=0;
}


	%>
<tr bgcolor=<%=mcolor%>>


 <%
if(!sln.equals("")){
%>
<td align="left"><%=slno%></td>
<%
}
%>

<%
if(!Enrollment.equals("")){
%>
<td align="left"><%=mTPUNIUQUEID%></td>
<%
}
%>

<%
if(!SubSection.equals("")) {
%>
<td align="left"><%=rs.getString("SUBSECTIONCODE")%></td>
<%
}
%>
<%
if(!Student.equals("")){
%>
<td align="left"><%=rs.getString("Studentname")%></td>
<%
}
%>
<%
if(!Gender.equals("")){
%>
<td align="left"><%=rs.getString("sex")%></td>
<%
}
%>
<%
if(!Enrollment.equals("")){
%>
 <td align="left"><%=rs.getString("enrollmentno")%></td>
<%
}
%>
<%
if(!Institutecod.equals("")){
%>
 <td align="left"><%=rs.getString("Institutecode")%></td>
<%
}
%>

<%
if(!ProgramC.equals("")){
%>
<td align="left"><%=rs.getString("programcode")%></td>
<%
}
%>


<%
if(!BranchC.equals("")){
%>
<td align="left"><%=rs.getString("branchcode")%></td>
<%
}
%>
<%
if(!Birth.equals("")){
%>
<td align="left"><%=rs.getString("DOB")%></td>
<%
}
%>


<%

    qry1="SELECT   DISTINCT nvl(d.PercentOfMarks,'0') per10,nvl(d.YearOfpassing,'0') YearOfpassing,nvl(d.NameOfBoard,'-') NameOfBoard   FROM   v#StudentQualification d WHERE " +
       "  d.institutecode||d.Studentid='"+rs.getString("Institutecode")+rs.getString("studentid")+"' and UPPER (d.QualificationCode) = '10TH'";
    //System.out.print(qry1);
    rs1=db.getRowset(qry1);
    if(rs1.next())
    {if(!Per10.equals("")){
     %>
<td align="left"><%=rs1.getDouble("per10")%></td>
<%
}
if(!year10.equals("")){
    %>
<td align="left"><%=rs1.getString("YearOfpassing")%></td>
<%
}else{
	
	%>
<td align="left">-</td>
<%
	
	}
	
	
	if(!board10.equals("")){
  %>
<td align="left"><%=rs1.getString("NameOfBoard")%></td>
<%
}else{
	
	%>
<td align="left">-</td>
<%
	
	}    
}else{


	
	%>
 
<%
	
	
	%>
<td align="left">-</td>
<%
	
	%>
<td align="left">-</td>
<%%>
	
<%

}
%>

<%

    //qry1="SELECT   DISTINCT nvl(d.YearOfpassing,'0') YearOfpassing  FROM   v#StudentQualification d    WHERE " +
    //"  d.institutecode||d.Studentid ='"+rs.getString("Institutecode")+rs.getString("studentid")+"' AND UPPER (d.QualificationCode) = '10TH'";
//rs1=db.getRowset(qry1);
 //   if(rs1.next())
 //   {
//    %>
<%--td align="left"><%=rs1.getString("YearOfpassing")%></td--%>
<%--
//}}
--%>

<%

   // qry1="SELECT   DISTINCT nvl(d.NameOfBoard,'-') NameOfBoard    FROM   v#StudentQualification d   " +
 //   " WHERE   d.institutecode||d.Studentid ='"+rs.getString("Institutecode")+rs.getString("studentid")+"'  AND UPPER (d.QualificationCode) = '10TH'";
//rs1=db.getRowset(qry1);
 /*   if(rs1.next())
    {
   %>
<%--td align="left"><%=rs1.getString("NameOfBoard")%></td--%>
<%
}}*/
%>

<%

 qry1="SELECT   DISTINCT nvl(d.PercentOfMarks,'0')   per12,nvl(d.YearOfpassing,'0') yearofpassing12,nvl(d.NameOfBoard,'')  boardname12 FROM   v#StudentQualification d     " +
         " WHERE   d.institutecode||d.Studentid ='"+rs.getString("Institutecode")+rs.getString("studentid")+"' AND UPPER (d.QualificationCode) = '12TH'";
//out.println(qry1);
 rs1=db.getRowset(qry1);
    if(rs1.next())
    {
 if(!per12.equals("")){%>
<td align="left"><%=rs1.getDouble("per12")%></td>
<%
}if(!year12.equals("")){
    %>
<td align="left"><%=rs1.getString("yearofpassing12")%></td>
<%
}if(!board12.equals("")){%>
<td align="left"><%=rs1.getString("boardname12")%></td>
<%
}
}else{
	
	%>
<td align="left">-</td>
<%
	
	 

	
	%>
<td align="left">-</td>
<%
	
	
	%>
<td align="left">-</td>
<%
	
	%>
<!--td align="left">-</td-->
<%
	

}
%>

<%--
if(!year12.equals("")){
  //  qry1="SELECT DISTINCT nvl(d.YearOfpassing,'0') yearofpassing12  FROM   v#StudentQualification d  " +
  //          " WHERE   d.institutecode||d.Studentid ='"+rs.getString("Institutecode")+rs.getString("studentid")+"' AND UPPER (d.QualificationCode) = '12TH'";
  //  rs1=db.getRowset(qry1);
    if(rs1.next())
    {
    
--%>
<%--td align="left"><%=rs1.getString("yearofpassing12")%></td--%>
<%
//}}
%>

<%

 // qry1=" SELECT   DISTINCT nvl(d.NameOfBoard,'')  boardname12  FROM   v#StudentQualification d  WHERE   d.institutecode||d.Studentid ='"+rs.getString("Institutecode")+rs.getString("studentid")+"'" +
 //          "          AND UPPER (d.QualificationCode) = '12TH'";

 // rs1=db.getRowset(qry1);
  //  if(rs1.next())
  //  {

   %>
<%--td align="left"><%=rs1.getString("boardname12")%></td--%>
<%--
}}
--%>

<%

   String cgpa1="",cgpa2="",cgpa3="",cgpa4="",cgpa5="",cgpa6="",cgpa7="",cgpa8="";

    qry1="select (select DISTINCT e.cgpa cgpa1 from  v#StudentSGpaCgpa e WHERE e.institutecode || e.studentid = '"+rs.getString("Institutecode")+rs.getString("studentid")+"'" +
            "         AND e.Institutecode = '"+rs.getString("Institutecode")+"'  and e.semester=1) cgpa1 ,(select DISTINCT e.cgpa  from  v#StudentSGpaCgpa e WHERE" +
            " e.institutecode || e.studentid = '"+rs.getString("Institutecode")+rs.getString("studentid")+"'         AND e.Institutecode = '"+rs.getString("Institutecode")+"'  and e.semester=2) cgpa2 ," +
            "(select DISTINCT e.cgpa  from  v#StudentSGpaCgpa e WHERE e.institutecode || e.studentid = '"+rs.getString("Institutecode")+rs.getString("studentid")+"'  " +
            "      AND e.Institutecode = '"+rs.getString("Institutecode")+"'  and e.semester=3) cgpa3 ,(select DISTINCT e.cgpa  from  v#StudentSGpaCgpa e " +
            "WHERE e.institutecode || e.studentid = '"+rs.getString("Institutecode")+rs.getString("studentid")+"'        AND e.Institutecode = '"+rs.getString("Institutecode")+"'  and e.semester=4) cgpa4 ," +
            "(select DISTINCT e.cgpa  from  v#StudentSGpaCgpa e WHERE e.institutecode || e.studentid = '"+rs.getString("Institutecode")+rs.getString("studentid")+"'      " +
            "   AND e.Institutecode = '"+rs.getString("Institutecode")+"'  and e.semester=5) cgpa5 ,(select DISTINCT e.cgpa  from  v#StudentSGpaCgpa e " +
            "WHERE e.institutecode || e.studentid = '"+rs.getString("Institutecode")+rs.getString("studentid")+"'         AND e.Institutecode = '"+rs.getString("Institutecode")+"'  and e.semester=6) cgpa6 ," +
            "(select DISTINCT e.cgpa  from  v#StudentSGpaCgpa e WHERE e.institutecode || e.studentid = '"+rs.getString("Institutecode")+rs.getString("studentid")+"'   " +
            "     AND e.Institutecode = '"+rs.getString("Institutecode")+"'  and e.semester=7) cgpa7 ,(select DISTINCT e.cgpa  from  v#StudentSGpaCgpa e " +
            "WHERE e.institutecode || e.studentid = '"+rs.getString("Institutecode")+rs.getString("studentid")+"'       AND e.Institutecode = '"+rs.getString("Institutecode")+"'  and e.semester=8) cgpa8 " +
            " from dual";
   
       //qry1="SELECT DISTINCT NVL (e.CGPA, '0') CGPA,Semester  FROM v#StudentSGpaCgpa e WHERE  " +
       //        "   e.institutecode || e.studentid = '"+rs.getString("Institutecode")+rs.getString("studentid")+"'  AND e.Institutecode = '"+rs.getString("Institutecode")+"'       group by e.Semester,e.CGPA  order by semester ";
    // System.out.println(qry1);
        rs1=db.getRowset(qry1);

   if(rs1.next())
    {
    cgpa1=rs1.getString("cgpa1")==null?"-":rs1.getString("cgpa1").toString();
    cgpa2=rs1.getString("cgpa2")==null?"-":rs1.getString("cgpa2").toString();
    cgpa3=rs1.getString("cgpa3")==null?"-":rs1.getString("cgpa3").toString();
    cgpa4=rs1.getString("cgpa4")==null?"-":rs1.getString("cgpa4").toString();
    cgpa5=rs1.getString("cgpa5")==null?"-":rs1.getString("cgpa5").toString();
    cgpa6=rs1.getString("cgpa6")==null?"-":rs1.getString("cgpa6").toString();
    cgpa7=rs1.getString("cgpa7")==null?"-":rs1.getString("cgpa7").toString();
    cgpa8=rs1.getString("cgpa8")==null?"-":rs1.getString("cgpa8").toString();
    
    
//System.out.print("&&&&&&&&"+map+"*********************");
    }
  if(!btechcgpa1.equals("")){%>
  <td align="left"><%=cgpa1%></td>
<%
}if(!btechcgpa2.equals("")){
%>
 <td align="left"><%=cgpa2%></td>
<%}if(!btechcgpa3.equals("")){
    %>
<td align="left"><%=cgpa3%></td>
<%
}if(!btechcgpa4.equals("")){%>
<td align="left"><%=cgpa4%></td>
<%
}if(!btechcgpa5.equals("")){%>
<td align="left"><%=cgpa5%></td>
<%
}if(!btechcgpa6.equals("")){%>
<td align="left"><%=cgpa6%></td>
<%
}if(!btechcgpa7.equals("")){%>
<td align="left"><%=cgpa7%></td>
<%
}if(!btechcgpa8.equals("")){
    %>
<td align="left"><%=cgpa8%></td>
<%
}
%>
   <%--  qry1="SELECT   DISTINCT nvl(e.CGPA,'0') CGPA2 FROM   v#StudentSGpaCgpa e WHERE e.institutecode||e.studentid ='"+rs.getString("Institutecode")+rs.getString("studentid")+"'" +
          " AND e.Institutecode ='"+rs.getString("Institutecode")+"'      AND e.Semester = 2";
     rs1=db.getRowset(qry1);
    if(rs1.next())
    {

%>
<td align="left"><%=rs1.getString("CGPA2")%></td>
<%
}}
%>

<%
if(!btechcgpa3.equals("")){
     qry1="SELECT   DISTINCT nvl(e.CGPA,'0') CGPA3 FROM   v#StudentSGpaCgpa e WHERE e.institutecode||e.studentid ='"+rs.getString("Institutecode")+rs.getString("studentid")+"'" +
          " AND e.Institutecode ='"+rs.getString("Institutecode")+"' AND e.Semester = 3";
     rs1=db.getRowset(qry1);
    if(rs1.next())
    {
%>
<td align="left"><%=rs1.getString("CGPA3")%></td>
<%
}}
%>

<%
if(!btechcgpa4.equals("")){
     qry1="SELECT   DISTINCT nvl(e.CGPA,'0') CGPA4 FROM   v#StudentSGpaCgpa e WHERE e.institutecode||e.studentid ='"+rs.getString("Institutecode")+rs.getString("studentid")+"'" +
          " AND e.Institutecode ='"+rs.getString("Institutecode")+"'      AND e.Semester = 4";
     rs1=db.getRowset(qry1);
    if(rs1.next())
    {

%>
<td align="left"><%=rs1.getString("CGPA4")%></td>
<%
}}
%>

<%
if(!btechcgpa5.equals("")){
     qry1="SELECT   DISTINCT nvl(e.CGPA,'0') CGPA5 FROM   v#StudentSGpaCgpa e WHERE e.institutecode||e.studentid ='"+rs.getString("Institutecode")+rs.getString("studentid")+"'" +
          " AND e.Institutecode ='"+rs.getString("Institutecode")+"'      AND e.Semester = 5";
     rs1=db.getRowset(qry1);
    if(rs1.next())
    {

%>
<td align="left"><%=rs1.getString("CGPA5")%></td>
<%
}}
%>

<%
if(!btechcgpa6.equals("")){
     qry1="SELECT   DISTINCT nvl(e.CGPA,'0') CGPA6 FROM   v#StudentSGpaCgpa e WHERE e.institutecode||e.studentid ='"+rs.getString("Institutecode")+rs.getString("studentid")+"'" +
          " AND e.Institutecode ='"+rs.getString("Institutecode")+"'      AND e.Semester =6";
     rs1=db.getRowset(qry1);
    if(rs1.next())
    {

%>
<td align="left"><%=rs1.getString("CGPA6")%></td>
<%
}}
%>

<%try{
if(!btechcgpa7.equals("")){
     qry1="SELECT   DISTINCT nvl(e.CGPA,'0') CGPA7 FROM   v#StudentSGpaCgpa e WHERE e.institutecode||e.studentid ='"+rs.getString("Institutecode")+rs.getString("studentid")+"'" +
          " AND e.Institutecode ='"+rs.getString("Institutecode")+"'  AND e.Semester = 7";
     //out.print(qry1);
     rs1=db.getRowset(qry1);
    if(rs1.next())
    {
        
%>
<td align="left"><%=rs1.getString("CGPA7")%></td>
<%
}else{%>
<td align="left">-</td>
<%}}}catch(Exception e)
{
//System.out.println(e);
//out.println(e);
}
%>

<%
if(!btechcgpa8.equals("")){
     qry1="SELECT   DISTINCT nvl(e.CGPA,'0') CGPA8 FROM   v#StudentSGpaCgpa e WHERE e.institutecode||e.studentid ='"+rs.getString("Institutecode")+rs.getString("studentid")+"'" +
          " AND e.Institutecode ='"+rs.getString("Institutecode")+"' AND e.Semester = 8";
     rs1=db.getRowset(qry1);
    if(rs1.next())
    {

%>
<td align="left"><%=rs1.getString("CGPA8")%></td>
<%
}else{%>
<td align="left">-</td>
<%}}
--%>

<%

    qry1="SELECT   DISTINCT nvl(d.PercentOfMarks,'0') GraduationPer,nvl(d.YearOfpassing,'0') GradYOP," +
            "nvl(d.NameOfBoard,'-'),nvl(d.EXAMPASSED,'-') STREAM , nvl(d.NameOfBoard,'-')  GradBoard FROM   v#StudentQualification d    " +
            " WHERE   d.institutecode||d.Studentid ='"+rs.getString("Institutecode")+rs.getString("studentid")+"' AND " +
            "UPPER (LTRIM (RTRIM (QualificationCode))) IN  ('00002', '00003', '00006', 'B.TEC', 'BE')";
//System.out.println(qry1);
    rs1=db.getRowset(qry1);
    if(rs1.next())
    {
    if(!Pergd.equals("")){
%>
<td align="left"><%=rs1.getDouble("GraduationPer")%></td>
<%}if(!yeargd.equals("")){%>
<td align="left"><%=rs1.getString("GradYOP")%></td>
<%}
if(!boardgd.equals("")){ %>
<td align="left"><%=rs1.getString("GradBoard")%></td>
<%
}if(!degreegd.equals("")){%>
<td align="left"><%=rs1.getString("STREAM")%></td>
<%
}if(!branchgd.equals("")){%>
<td align="left"><%=rs1.getString("STREAM")%></td>
<%
}
 }else{ if(!Pergd.equals("")){%>
 <td align="left">-</td><%}%>
 <%}if(!yeargd.equals("")){%><td align="left">-</td>
 <%}
if(!boardgd.equals("")){ %><td align="left">-</td>
<%
}if(!degreegd.equals("")){%>
 <td align="left">-</td>
 <%
}if(!branchgd.equals("")){%><td align="left">-</td>
 <%}
%>

<%--
if(!yeargd.equals("")){
//    qry1="SELECT   DISTINCT nvl(d.YearOfpassing,'0') GradYOP  FROM   v#StudentQualification d   WHERE   " +
//            "d.institutecode||d.Studentid ='"+rs.getString("Institutecode")+rs.getString("studentid")+"' AND UPPER (LTRIM (RTRIM (QualificationCode))) " +
//            "IN  ('00002', '00003', '00006', 'B.TEC', 'BE')";
//rs1=db.getRowset(qry1);
    if(rs1.next())
    {
    %>
<td align="left"><%=rs1.getString("GradYOP")%></td>
<%
    }else{%>
<td align="left">-</td>
<%}
}
--%>

<%--
if(!boardgd.equals("")){
  //  qry1="SELECT DISTINCT nvl(d.NameOfBoard,'-')  GradBoard FROM   v#StudentQualification d  WHERE   d.institutecode||d.Studentid ='"+rs.getString("Institutecode")+rs.getString("studentid")+"' " +
 //           " AND UPPER (LTRIM (RTRIM (QualificationCode))) IN('00002', '00003', '00006', 'B.TEC', 'BE')";
  //  rs1=db.getRowset(qry1);
    if(rs1.next())
    {
    %>
<td align="left"><%=rs1.getString("GradBoard")%></td>
<%
}else{%>
<td align="left">-</td>
<%}}
--%>


<%--
if(!degreegd.equals("")){
 //   qry1="SELECT   DISTINCT nvl(d.EXAMPASSED,'-') STREAM  FROM   v#StudentQualification d  WHERE  " +
//            " d.institutecode||d.Studentid ='"+rs.getString("Institutecode")+rs.getString("studentid")+"' AND UPPER (LTRIM (RTRIM (QualificationCode)))" +
   //         " IN ('00002', '00003', '00006', 'B.TEC', 'BE')";

//rs1=db.getRowset(qry1);
    if(rs1.next())
    {
    %>
<td align="left"><%=rs1.getString("STREAM")%></td>
<%
}else{%>
<td align="left">-</td>
<%}}
%>


<%
if(!branchgd.equals("")){
 //qry1="SELECT   DISTINCT nvl(d.EXAMPASSED,'-') STREAM  FROM   v#StudentQualification d  WHERE  " +
  //          " d.institutecode||d.Studentid ='"+rs.getString("Institutecode")+rs.getString("studentid")+"' AND UPPER (LTRIM (RTRIM (QualificationCode)))" +
  //          " IN ('00002', '00003', '00006', 'B.TEC', 'BE')";

//rs1=db.getRowset(qry1);
    if(rs1.next())
    {
    %>
<td align="left"><%=rs1.getString("STREAM")%></td>
<%
}else{%>
<td align="left">-</td>
<%}}
--%>

<%
if(!studcell.equals("")){
%>
<td align="left"><%=rs.getString("stcellno")==null?"-":rs.getString("stcellno")%></td>
<%
}
%>

<%
if(!studemail.equals("")){
%>
<td align="left"><%=rs.getString("stemailid")==null?"-":rs.getString("stemailid")%></td>
<%
}
%>


<%
if(!fathername.equals("")) {
%>
<td align="left"><%=rs.getString("fathername")==null?"-":rs.getString("fathername")%></td>
<%
}
%>

<%
if(!mothername.equals("")){
%>
<td align="left"><%=rs.getString("mothername")==null?"-":rs.getString("mothername")%></td>
<%
}
%>

<%
if(!parentcell.equals("")){
%>
<td align="left"><%=rs.getString("plandline")==null?"-":rs.getString("plandline")%></td>
<%
}
%>

<%
if(!peraddress.equals("")){
%>
<td align="left"><%=rs.getString("CADDRESSAdd")==null?"-":rs.getString("CADDRESSAdd")%></td>
<td align="left"><%=rs.getString("permanentadd")==null?"-":rs.getString("permanentadd")%></td>
<%
}
%>

<%
if(!noofback.equals("")){
   qry1= "SELECT   DISTINCT COUNT (SUBJECTID)  FAILTOTAL FROM   v#StudentRESULT e  WHERE " +
           "e.institutecode||e.studentid ='"+rs.getString("Institutecode")+rs.getString("studentid")+"' AND e.Institutecode = '"+rs.getString("studentid")+"'    AND e.FAIL = 'Y'  ";
//out.print(qry1);
   rs1=db.getRowset(qry1);
    if(rs1.next())
    {
   %>
<td align="left"><%=rs1.getString("FAILTOTAL")==null?"-":rs1.getString("FAILTOTAL")%></td>
<%
}else{
%>
<td align="left">-</td>
<%
}}
%>



</tr>
<%

qryud=" select 'Y' from  TP#EVENTPARTICIPENTS where EVENTCODE='"+xevent+"' and  COMPANYCODE='"+xcompanycode+"' and  INSTITUTECODE ='"+rs.getString("Institutecode")+"' and  studentid='"+rs.getString("studentid")+"' " ;
rsqryud=db.getRowset(qryud);
//System.out.print("4"+qryud);
if(!rsqryud.next())
{
mTPUNIUQUEID="TP-"+rs.getString("studentid");

Qryinsert=" INSERT INTO  TP#EVENTPARTICIPENTS (   EVENTCODE, COMPANYCODE, INSTITUTECODE,  TPUNIUQUEID,  STUDENTID, REGISTERED, SPECIALCANDIDATE,    REGISTRATIONDATE, DEREGISTRATIONDATE, PARTICIPATIONDATE,  ENTRYDATE ) VALUES ('"+xevent+"' ,'"+xcompanycode+"' ,'"+rs.getString("Institutecode")+"' , '"+mTPUNIUQUEID+"','"+rs.getString("studentid")+"'   ,'"+mresister+"' ,'"+mSpecial+"' ,sysdate    ,sysdate ,sysdate      ,sysdate ) ";
int K=db.insertRow(Qryinsert);
//System.out.print("5"+Qryinsert);

}
else{
	mTPUNIUQUEID="TP-"+rs.getString("studentid");
	//qryudd=" delete from  TP#EVENTPARTICIPENTS where  EVENTCODE='"+xevent+"' and  COMPANYCODE='"+xcompanycode+"' and  INSTITUTECODE='"+rs.getString("Institutecode")+"'  ";
//out.print("6"+qryudd);
//int kr=db.update(qryudd);
Qryinsert=" UPDATE TP#EVENTPARTICIPENTS SET    REGISTRATIONDATE      = sysdate , TPUNIUQUEID ='"+mTPUNIUQUEID+"' ,REGISTERED= '"+mresister+"',     DEREGISTRATIONDATE    = sysdate,       PARTICIPATIONDATE     = sysdate,            ENTRYDATE   = sysdate where  EVENTCODE='"+xevent+"' and  COMPANYCODE='"+xcompanycode+"' and  INSTITUTECODE ='"+rs.getString("Institutecode")+"' and  studentid='"+rs.getString("studentid")+"'     ";
int t=db.update(Qryinsert);
//out.print("****"+Qryinsert);

}


}

qrydd=" delete from TEMP#TPSTUDENTMASTER ";
//out.print("7"+qrydd);
int k=db.update(qrydd);

//String qryddx=" delete from TEMPSTUDENTLIST ";
//out.print("7"+qrydd);
//int j=db.update(qryddx);



 } catch (Exception e) {
            out.print("Error no1:" + e);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ignore) {
                }
            }
        //  if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
        //  if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
        }
}catch(Exception e)
        {
out.print("Error no2:"+e);
}
 %>
</table>
<br>
 </form></body></html>