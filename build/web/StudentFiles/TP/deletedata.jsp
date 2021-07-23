<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp,java.lang.ArrayIndexOutOfBoundsException" %>
<%

        DBHandler db = new DBHandler();
        int rsum=0,ssum=0,tsum=0,usum=0,vsum=0,wsum=0;
        ResultSet rs =  null;
		ResultSet rst = null;
		ResultSet rsf=  null ;
        ResultSet rsd = null;
        ResultSet rs1 = null;
        ResultSet rs2 = null;
        ResultSet rsc = null;
        String qry = "" ,qryc="",mSUBB="",mSUBN="", mLTP="",qry1="",inst="",institute="",academic="",academicyear="";
		String qryt = "",Event="",Programcode="",Companycode="";
        GlobalFunctions gb = new GlobalFunctions();
	    String mRegCode = "",event="", Academicyear="";
        String mEXAMCODE = "" ,mSubjID="",DataSublist="" ,mProgCode="",QryProgCode="",companycode="";
        String mAcademicYear = "",program="",programcode="",mDate12="";
        String mProgramCode = "";
        String mInstCode = "",msem="",reqAction="";
		String  mreg="",mselect1="" ;
		String mHOSTELTYPE = "" , macade="" ,mbranc="" ,sem="",semester="",branch="",branchcode="" ;
		String mprog="",enddate="",fromdate="",mdate1="",mdate2="";
		String mBranchCode = "",msid="",mCode="",mES="",mSubj1="",qrysubj="",Subject="";
        int n=0;
        String qryx="",mLTP1="",Branch="",mselect="";
        ResultSet rsx=null;
String mins="",mbranch="",mDate="";
		String mInst="",mSubject="",minst="" ,qrys="",Semester="",mDate1="",mDate2="";
		int rsum80t1=0,rsum80t2=0,rsum80t3=0,ssum70t1=0,ssum70t2=0,ssum70t3=0,tsum60t1=0,tsum60t2=0,tsum60t3=0,
					usum50t1=0,usum50t2=0,usum50t3=0,vsum40t1=0,vsum40t2=0,vsum40t3=0,wsum30t1=0,wsum30t2=0,wsum30t3=0;
		int count=0 ,Flag=0;



int ttsum1=0,ttsum2=0,ttsum3=0;

if (session.getAttribute("InstituteCode") == null)
	mInst = "";
else
	mInst = session.getAttribute("InstituteCode").toString().trim();
%>
<HTML>
    <head>
        <TITLE>#### JIIT [ Attendance PercentageWise BreackUp]</TITLE>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
    </head>
    <%
        Companycode=request.getParameter("id");
        Event=request.getParameter("id1");
        institute=request.getParameter("id2");
        Branch=request.getParameter("id5");
        Academicyear=request.getParameter("id3");
        Programcode=request.getParameter("id4");
        Semester=request.getParameter("id6");
        mDate1=request.getParameter("id9");
        mDate2=request.getParameter("id10");
 %>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >

<%qry="delete from TP#REGISTRATIONPARAMETERS where COMPANYCODE='"+Companycode+"'and EVENTCODE='"+Event+"'" +
              " and INSTITUTECODE='"+institute+"' and SECTIONBRANCH='"+Branch+"'and ACADEMICYEAR='"+Academicyear+"' and" +
              " PROGRAMCODE='"+Programcode+"' and SEMESTER='"+Semester+"'";
//out.print(qry);
int k=db.update(qry);
if(k>0)
    {
    response.sendRedirect("showregisteredpage.jsp?event="+Event+"&companycode="+Companycode+"&x= ");
    
}else{
     
out.print("<center><font size=4 valign=center style=family:verdana; color=red>Sorry!! There is a student is registered for this criteria.</font></center>");
out.print("<center><font size=4 valign=center style=family:verdana; color=red><a href=showregisteredpage.jsp>Click here</a> for go back.</font></center>");

}
        %>
</body>
</HTML>