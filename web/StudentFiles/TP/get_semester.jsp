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
        String mAcademicYear = "",program="",programcode="";
        String mProgramCode = "";
        String mInstCode = "";
		String  mreg="" ;
		String mHOSTELTYPE = "" , macade="" ,mbranc="" ,sem="",semester="",branch="",branchcode="" ;
		String mprog="",enddate="",fromdate="";
		String mBranchCode = "",msid="",mCode="",mES="",mSubj1="",qrysubj="",Subject="";
        int n=0;
        String qryx="",mLTP1="",Branch="",result="";
        ResultSet rsx=null;
        String reqAction="";
		String mInst="",mSubject="",minst="" ,qrys="",Semester="";
		int rsum80t1=0,rsum80t2=0,rsum80t3=0,ssum70t1=0,ssum70t2=0,ssum70t3=0,tsum60t1=0,tsum60t2=0,tsum60t3=0,
					usum50t1=0,usum50t2=0,usum50t3=0,vsum40t1=0,vsum40t2=0,vsum40t3=0,wsum30t1=0,wsum30t2=0,wsum30t3=0;
		int count=0 ,Flag=0;

        academicyear=request.getParameter("academic")==null?"":request.getParameter("academic").trim();
        programcode=request.getParameter("program")==null?"":request.getParameter("program").trim();
        branch=request.getParameter("branch")==null?"":request.getParameter("branch").trim();
        // System.out.print("AAAAAAAAAAA"+academicyear);
int ttsum1=0,ttsum2=0,ttsum3=0;

if (session.getAttribute("InstituteCode") == null)
	mInst = "";
else
	mInst = session.getAttribute("InstituteCode").toString().trim();

try{
qry= "select distinct NVL(SEMESTER,0) s FROM v#studentmaster where nvl(Deactive,'N')='N' and PROGRAMCODE='"+programcode+"' and ACADEMICYEAR='"+academicyear+"' and BRANCHCODE='"+branch+"'";

	System.out.println("#####################################33"+qry);
	rs2=db.getRowset(qry);
	while(rs2.next()) {
		result=result+rs2.getString("s")+"$";
	}
	//result=result+"~"+result2;//+">"+TimeId;
      out.println(result);
	}
	catch(Exception e)
	{
		out.println(e);
	}
%>
