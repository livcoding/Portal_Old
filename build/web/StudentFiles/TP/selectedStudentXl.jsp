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
        int n=0,c=0,l=0,t=0;
        String qryx="",mLTP1="",Branch="";
        ResultSet rsx=null;
        String reqAction="",roundname="",status="";
		String mInst="",mSubject="",minst="" ,qrys="",Semester="";
		int rsum80t1=0,rsum80t2=0,rsum80t3=0,ssum70t1=0,ssum70t2=0,ssum70t3=0,tsum60t1=0,tsum60t2=0,tsum60t3=0,
					usum50t1=0,usum50t2=0,usum50t3=0,vsum40t1=0,vsum40t2=0,vsum40t3=0,wsum30t1=0,wsum30t2=0,wsum30t3=0;
		int count=0 ,Flag=0,i=0,s=0,m=0,k=0,d=0,cnt=0,j=0,z=0,r=0,x=0;
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT";


int ttsum1=0,ttsum2=0,ttsum3=0;

if (session.getAttribute("InstituteCode") == null)
	mInst = "";
else
	mInst = session.getAttribute("InstituteCode").toString().trim();

%><HTML>
<head>
<TITLE>#### <%=mHead%> [ Pre Registration Report] </TITLE>
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

<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

</head>
<body aLink=#ff00ff  rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>

 <%@page contentType="text/html"%>
	   	<%
            response.setContentType("application/vnd.ms-excel");
            round1=request.getParameter("round1")==null?"":request.getParameter("round1").trim();
            Event=request.getParameter("Event")==null?"":request.getParameter("Event").trim();
            Companycode=request.getParameter("Companycode")==null?"":request.getParameter("Companycode").trim();
        if(round1.equals("W"))
          {
          round12="Written";
          }else if(round1.equals("G"))
          {
          round12="G.D";
          }
          else if(round1.equals("I"))
          {
          round12="Interview";
          }%><form name="c" id="c" method="post" action="selectedStudentXl.jsp">
<div id="printable">
   <% out.print("<center><font color=Green size=4><u>Selected Students</u></font></center>");%>
<table width="30%" border="2" cellpadding=3  id="tblSearch" class="mytable filterable" cellspacing=2 align=center bordercolor="black" bottommargin=0  topmargin=0>
 <tr  bgcolor="silver">
     <td align="center" nowrap colspan="3" ><Font size="3" COLOR="black" align="center">Company :&nbsp; </FONT>
    <Font size="3" COLOR="black" align="center"><u><i><%=Companycode%></i></u></FONT></td>
     <td align="center" nowrap colspan="3" ><Font size="3" COLOR="black" align="center">Round :</FONT>
     <Font size="3" COLOR="black" align="center"><%=round12%></FONT>
     </td></tr>
   <tr bgcolor="silver">
   <td align="center" nowrap><Font size="3" COLOR="black" align="center">Sl.No.</FONT></td>
   <td align="center" nowrap><Font size="3" COLOR="black" align="center">Enrollment No.</FONT></td>
   <td align="center" nowrap><Font size="3" COLOR="black" align="center">Student Name</FONT></td>
   <td align="center" nowrap><Font size="3" COLOR="black" align="center">Batch</FONT></td>
   <td align="center" nowrap><Font size="3" COLOR="black" align="center">Branch</FONT></td>
   <td align="center" nowrap><Font size="3" COLOR="black" align="center">Semester</FONT></td>
   </tr>
<%
try
 {
    l=Integer.parseInt(request.getParameter("l"))==0?0:Integer.parseInt(request.getParameter("l"));
   //System.out.print("gYAN"+l);

    for (int R=1;R<=l;R++)
{
   
           
            studentid=request.getParameter("studentid"+R)==null?"":request.getParameter("studentid"+R).trim();

          //  System.out.println(R+"*****"+studentid+"#########"+l);

            qry="select distinct studentname,enrollmentno,academicyear,branchcode,to_chAR(semester) semester from studentmaster where studentid='"+studentid+"' ";

         rs=db.getRowset(qry);

           while(rs.next())
               {
         %>
 <tr bgcolor="white" >
    <td align="left" nowrap >
       <%=R%>
      
     </td>
    
            <td align="left" nowrap><%=rs.getString(1)==null?"":rs.getString(1).trim()%></td>
            <td align="left" nowrap><%=rs.getString(2)==null?"":rs.getString(2).trim()%></td>
            <td align="left" nowrap><%=rs.getString(3)==null?"":rs.getString(3).trim()%></td>
             <td align="left" nowrap><%=rs.getString(4)==null?"":rs.getString(4).trim()%></td>
             <td align="left" nowrap><%=rs.getString(5)==null?"":rs.getString(5).trim()%></td>
          <% }%>
      
     </tr>
<%
}%></table>
<%}
catch(Exception e)
        {
System.out.print("error in to XL records"+e);
}%>

     </form>

</body>
</html>














                