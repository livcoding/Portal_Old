<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.regex.*" %>
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
<%
int hh=0;
DBHandler db = new DBHandler();
String qrytt="",qrydd="";
String qryud="", qryudd="",mresister="",mSpecial=""; 
String QERCLORRN="";




        int rsum=0,ssum=0,tsum=0,usum=0,vsum=0,wsum=0;
		 String QrySet="",QrySetC="",QrySetCC="",qry4="" ,qry2="",qry3="",xSet="",mCritvales="",mcolor="#F2F2F2",QERCLOR="",andor="",Qryinsert="";  
		 String  QryIns="";  
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
 

    xslno=Integer.parseInt(request.getParameter("slno"));

 //ryF=" execute TP.POPTPQUALIFICATION ";
 //int x=db.update(qryF);

//out.print(xevent+"@@@@@@@@@"+xcompanycode+"#######"+xslno+"****"+xInst);

for(int j=1;j<=xslno;j++)
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
		   }


	//  xStudentid=request.getParameter("Select"+j).toString().trim();
	//  xStudentid=xStudentid+","+request.getParameter("Select"+j);
	  
	  }
	 // out.print(xStudentid);

int ttsum1=0,ttsum2=0,ttsum3=0;

if (session.getAttribute("InstituteCode") == null)
	mInst = "";
else
	mInst = session.getAttribute("InstituteCode").toString().trim();

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
      
	  
 <table cellpadding=3 cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="90%" bgcolor="white">
<tr bgcolor="silver">
        <td colspan=0 align=middle>
            <font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><FONT SIZE="4" COLOR=""><B>T & P EVENT PARTICIPENTS</B></FONT></font></td></tr>
        </table>
		
		 
		 
<table cellpadding=3 cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="90%" bgcolor="white">
<tr bgcolor="silver">
 <td  bgcolor="#F2F2F2"><B>Student(s) In Criteria  </B></td>
<td  bgcolor="red"><B>Not Intrested student(s) </B></td>
<td bgcolor="#90EE90"><B>Intrested  student(s)</B></td>
<td  bgcolor="#FFD000"><B>Special Case student(s) </B></td>
</tr>
</table>




       <table cellpadding=3 cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="90%" bgcolor="white">
<tr bgcolor="silver" align="left">
 



<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>S/No.</STRONG></font></th>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Enrollmentno</STRONG></font></th>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>SubSection Code</STRONG></font></th>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Studentname</STRONG></font></th>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Gender</STRONG></font></th>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Institutecode</STRONG></font></th>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Program</STRONG></font></th>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Branch</STRONG></font></th>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Date of Birth</STRONG></font></th>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Per.10</STRONG></font></th>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Year of passing10th</STRONG></font></th>

<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Board 10th</STRONG></font></th>

<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Per.12</STRONG></font></th>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Year of passing12th</STRONG></font></th>

<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Board 12th</STRONG></font></th>
<!-- <td align="left">B.Tech CGPA 1</td>
<td align="left">B.Tech CGPA 2</td>
<td align="left">B.Tech CGPA 3</td>
<td align="left">B.Tech CGPA 4</td>
<td align="left">B.Tech CGPA 5</td>
<td align="left">B.Tech CGPA 6</td>
<td align="left">B.Tech CGPA 7</td>
<td align="left">B.Tech CGPA 8</td> -->


<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Student Cell</STRONG></font></th>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Student E-MailID</STRONG></font></th>
 <th><font  face=arial size=2 color="#a52a2a"><STRONG>Father Name</STRONG></font></th>
<th><font  face=arial size=2 color="#a52a2a"><STRONG>monther Name</STRONG></font></th>  
<th><font  face=arial size=2 color="#a52a2a"><STRONG>Parent Phone</STRONG></font></th>  
<th><font  face=arial size=2 color="#a52a2a"><STRONG>Permanent Address</STRONG></font></th>  
</tr>

<%
try{

qry=" select distinct a.studentid, NVL (a.institutecode, '') institutecode, a.sex,";
      qry=qry+"   to_Char(a.dateofbirth,'dd-mm-yyyy')DOB, c.per12, c.per10, c.boardname10, c.boardname12,";
      qry=qry+"   c.yearofpassing10, c.yearofpassing12,";
      qry=qry+"   NVL (a.academicyear, '') academicyear,";
      qry=qry+"   NVL (a.enrollmentno, '') enrollmentno,";
      qry=qry+"   NVL (a.studentname, '') studentname,";
      qry=qry+"   NVL (a.programcode, '') programcode,";
      qry=qry+"   NVL (a.branchcode, '') branchcode,";
      qry=qry+"   NVL (a.sectioncode, '') sectioncode,";
      qry=qry+"   NVL (a.subsectioncode, '') subsectioncode,";
      qry=qry+"   NVL (a.semester, '') semester,";
      qry=qry+"   (d.cgpa || '- CGPA FOR SEMESTER  ' || d.semester) cgpa, c.perug,";
      qry=qry+"   c.perpg, e.stcellno, e.stemailid, a.fathername, a.mothername,";
      qry=qry+"   (e.pastdcode || '-' || e.patelno) plandline,";
      qry=qry+"   (   f.paddress1";
      qry=qry+"    || ' '";
      qry=qry+"    || f.paddress2";
      qry=qry+"    || '  '";
       qry=qry+"   || f.paddress3";
       qry=qry+"   || '  '";
       qry=qry+"   || f.pdistrict";
       qry=qry+"   || ' '";
       qry=qry+"   || f.pcity";
      qry=qry+"    || ' '";
     qry=qry+"     || f.pstate";
     qry=qry+"     || ' '";
     qry=qry+"     || ppin";
    qry=qry+"     ) permanentadd";
  qry=qry+"  FROM v#studentmaster a,";
        qry=qry+" tp#studentdata b,";
       qry=qry+"  tp#studentqualification c,";
         qry=qry+"v#studentsgpacgpa d,";
         qry=qry+"studentphone e,";
    qry=qry+"     studentaddress f   where nvl(a.deactive,'N')='N' and a.institutecode IN ("+xInst+")    " ;
 qry=qry+" AND a.studentid IS NOT NULL";
  qry=qry+"   AND a.studentid = b.studentid(+)";
qry=qry+"     AND a.studentid = f.studentid(+)";
  qry=qry+"   AND a.studentid = e.studentid(+)";
  qry=qry+"   AND a.studentid = c.studentid(+)";
 qry=qry+"    AND a.studentid = d.studentid";
 qry=qry+"    AND b.programcode = a.programcode";
 qry=qry+"    AND b.branchcode = a.branchcode";
  qry=qry+"   AND b.semester = a.semester";
  qry=qry+"   AND b.semester = d.semester";
  qry=qry+"   AND a.academicyear = b.academicyear";
  qry=qry+"   AND a.academicyear = b.academicyear";
  qry=qry+"   AND a.institutecode = b.institutecode(+)";
   qry=qry+"  AND a.institutecode = e.institutecode(+)";
    qry=qry+" AND a.institutecode = c.institutecode(+)";
    qry=qry+" AND a.institutecode = d.institutecode(+) and a.studentid IN ("+xStudentid+") ";

 qry=qry+"  order by Studentname ";
 //out.print("1"+qry);
rs=db.getRowset(qry);
 
 
while(rs.next())
{
 
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


if (yyy ==0 && hhh==0 && xxx==0 ){
mcolor="#F2F2F2";
hhh=0;
yyy=0;
xxx=0;

}

	
	%>
<tr bgcolor=<%=mcolor%>>
 
<td align="left"><%=slno%></td>
<td align="left"><%=rs.getString("Enrollmentno")%></td>
<td align="left"><%=rs.getString("SUBSECTIONCODE")%></td>
<td align="left"><%=rs.getString("Studentname")%></td>
<td align="left"><%=rs.getString("sex")%></td>
<td align="left"><%=rs.getString("Institutecode")%></td>
<td align="left"><%=rs.getString("programcode")%></td>
<td align="left"><%=rs.getString("branchcode")%></td>
<td align="left"><%=rs.getString("DOB")%></td>
<td align="left"><%=rs.getString("per10")%></td>
<td align="left"><%=rs.getString("yearofpassing10")%></td>
<td align="left"><%=rs.getString("boardname10")%></td>
<td align="left"><%=rs.getString("per12")%></td>
<td align="left"><%=rs.getString("yearofpassing12")%></td>
<td align="left"><%=rs.getString("boardname12")%></td>
<!-- <td align="left">CGPA 1%></td>
<td align="left">CGPA 2%></td>
<td align="left">CGPA 3%></td>
<td align="left">CGPA 4%></td>
<td align="left">CGPA 5%></td>
<td align="left">CGPA 6%></td>
<td align="left">CGPA 7%></td>
<td align="left">CGPA 8%></td> -->
<td align="left"><%=rs.getString("stcellno")%></td>
<td align="left"><%=rs.getString("stemailid")%></td>
<td align="left"><%=rs.getString("fathername")%></td>
<td align="left"><%=rs.getString("mothername")%></td>
<td align="left"><%=rs.getString("plandline")%></td>
<td align="left"><%=rs.getString("permanentadd")%></td>
</tr>
<%

	
qryud=" select 'Y' from  TP#EVENTPARTICIPENTS where EVENTCODE='"+xevent+"' and  COMPANYCODE='"+xcompanycode+"' and  INSTITUTECODE ='"+rs.getString("Institutecode")+"' and  studentid='"+rs.getString("studentid")+"' " ;
rsqryud=db.getRowset(qryud);
//out.print("4"+qryud);
if(!rsqryud.next())
{


Qryinsert=" INSERT INTO  TP#EVENTPARTICIPENTS (   EVENTCODE, COMPANYCODE, INSTITUTECODE,    STUDENTID, REGISTERED, SPECIALCANDIDATE,    REGISTRATIONDATE, DEREGISTRATIONDATE, PARTICIPATIONDATE,      ENTRYDATE ) VALUES ('"+xevent+"' ,'"+xcompanycode+"' ,'"+rs.getString("Institutecode")+"' , '"+rs.getString("studentid")+"'   ,'"+mresister+"' ,'"+mSpecial+"' ,sysdate    ,sysdate ,sysdate      ,sysdate ) ";
int K=db.insertRow(Qryinsert);
//out.print("5"+Qryinsert);

}
else{
	//qryudd=" delete from  TP#EVENTPARTICIPENTS where  EVENTCODE='"+xevent+"' and  COMPANYCODE='"+xcompanycode+"' and  INSTITUTECODE='"+rs.getString("Institutecode")+"'  ";
//out.print("6"+qryudd);
//int kr=db.update(qryudd);
Qryinsert=" UPDATE TP#EVENTPARTICIPENTS SET    REGISTRATIONDATE      = sysdate ,       DEREGISTRATIONDATE    = sysdate,       PARTICIPATIONDATE     = sysdate,            ENTRYDATE             = sysdate where  EVENTCODE='"+xevent+"' and  COMPANYCODE='"+xcompanycode+"' and  INSTITUTECODE ='"+rs.getString("Institutecode")+"' and  studentid='"+rs.getString("studentid")+"'    ";
int t=db.update(Qryinsert);
//out.print("****"+Qryinsert);

}


}

qrydd="delete from TEMP#TPSTUDENTMASTER ";
//out.print("7"+qrydd);
int k=db.update(qrydd);



}catch(Exception e)
        {
out.print("Error no1:"+e);
}

 
 

 %>
</table> 
<br>
<% 
	 
 
   
 
 
 
 
    
 %>
 </form></body></html>