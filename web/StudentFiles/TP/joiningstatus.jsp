<%-- 
    Document   : joiningstatus
    Created on : Oct 28, 2013, 3:42:49 PM
    Author     : campus.trainee
--%>

<%@ page language="java" import="java.sql.*,java.util.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp,java.lang.ArrayIndexOutOfBoundsException" %>
<%

        DBHandler db = new DBHandler();
        int rsum=0,ssum=0,tsum=0,usum=0,vsum=0,wsum=0;
        ResultSet rs =  null,rs3=null,rs4=null,rs5=null,rs6=null,rs8=null;
		ResultSet rst = null;
		ResultSet rsf=  null ;
        ResultSet rsd = null;
        ResultSet rs1 = null;
        ResultSet rs2 = null;
        ResultSet rsc = null,rs7=null;
        String qry = "" ,qryc="",round12="",mSUBB="",absent="",qry2="",mSUBN="",mchk="", mLTP="",qry1="",inst="",institute="",academic="",academicyear="";
		String qryt = "",Event="",Programcode="",Companycode="",written="",gd="",interview="",studentname="";
        GlobalFunctions gb = new GlobalFunctions();
	    String mRegCode = "",event="", Academicyear="",studentid="",round1="",absentin="";
        String mEXAMCODE = "" ,mSubjID="",DataSublist="" ,mProgCode="",QryProgCode="",companycode="";
        String mAcademicYear = "",program="",programcode="",company="",eventcode="";
        String mProgramCode = "",enroll="";
        String mInstCode = "",round="",stat="",statu="";
		String  mreg="",p="",q="" ;
		String mHOSTELTYPE = "" ,status2="",status1="", macade="" ,mbranc="" ,sem="",semester="",branch="",branchcode="" ;
		String mprog="",enddate="",fromdate="";
		String mBranchCode = "",msid="",mCode="",mES="",mSubj1="",qrysubj="",Subject="";
        int n=0,c=0,l=0;
        String qryx="",mLTP1="",Branch="";
        ResultSet rsx=null;
        String reqAction="",roundname="",status="";
		String mInst="",mSubject="",minst="" ,qrys="",Semester="",joined="";
		int rsum80t1=0,rsum80t2=0,rsum80t3=0,ssum70t1=0,ssum70t2=0,ssum70t3=0,tsum60t1=0,tsum60t2=0,tsum60t3=0,
					usum50t1=0,usum50t2=0,usum50t3=0,vsum40t1=0,vsum40t2=0,vsum40t3=0,wsum30t1=0,wsum30t2=0,wsum30t3=0;
		int count=0 ,Flag=0,i=0,s=0,m=0,k=0,d=0,cnt=0,j=0,z=0,r=0,x=0 ,pack=0;



int ttsum1=0,ttsum2=0,ttsum3=0;

if (session.getAttribute("InstituteCode") == null)
	mInst = "";
else
	mInst = session.getAttribute("InstituteCode").toString().trim();

studentid=request.getParameter("id")==null?"":request.getParameter("id").trim();
%>
<HTML>
    <head>
        
    </head>
     <TITLE>#### JIIT [ Attendance PercentageWise BreackUp]</TITLE>
 <body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
 <table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
        <tr>
        <td colspan=0 align=middle>
            <font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><FONT SIZE="4" COLOR=""><B><u><I>Joining Status</I></u></B></FONT></font></td></tr>
        </table>
        
     
   <%try{
   qry="SELECT distinct nvl(COMPANYCODE,'') COMPANYCODE,nvl(a.studentname,'')studentname , nvl(JOINED,'N') JOINED, nvl(PACKAGEOFFEREDINLACKS,0) PACKAGEOFFEREDINLACKS" +
           " FROM studentmaster a,TP#AFTERINTERVIEW b where a.studentid='"+studentid+"' and status='I'" +
           " and selected='Y'";
   rs=db.getRowset(qry);
   while(rs.next())
       {company=rs.getString(1)==null?"":rs.getString(1).trim();
       studentname=rs.getString(2)==null?"":rs.getString(2).trim();
       joined=rs.getString(3).trim().equals("Y")?"Yes":"No";
       //out.print("####"+joined+"***"+studentname+"#######"+company);
       pack=rs.getInt(4)==0?0:rs.getInt(4);
      
        
   }%>
       <table cellpadding=3  id="tblSearch"  class="mytable filterable" cellspacing=2 align=center rules=groups border=2 bordercolor="black" width="80%" >
           <tr><td nowrap><b><I>Student Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</I>:</b></td><td nowrap><%=studentname%></td></tr>
           <tr><td nowrap><b><I>Company Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</I>:</b></td><td nowrap><%=company%></td></tr>
           <tr><td nowrap><b><I>Package(Rupees/Year)&nbsp;</I>:</b></td><td nowrap><%=pack%>/=</td></tr>
           <tr><td nowrap><b><I>Joined</I>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b></td><td nowrap><%=joined%></td></tr>
               
           

          </table>
     
     <%}catch(Exception e)
             {
     out.print("error is"+e);
     }%>
     
 </body>