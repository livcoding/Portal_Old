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
        OLTEncryption enc=new OLTEncryption();
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
try{
       String DATE1=request.getParameter("Date")==null?"":request.getParameter("Date");
       String member1=request.getParameter("member")==null?"":request.getParameter("member");

        String usertype=request.getParameter("memtype")==null?"":request.getParameter("memtype");
        String empcode=request.getParameter("empcode")==null?"":request.getParameter("empcode");
        String instid=request.getParameter("instid")==null?"":request.getParameter("instid");
      //  System.out.print("AAAAAAAAAAA"+usertype+"BBB**"+empcode);
int ttsum1=0,ttsum2=0,ttsum3=0;

if(usertype.trim().equals("E"))
{
    usertype=enc.encode(usertype);
    empcode=enc.encode(empcode);

qry="Select  round(NVL ( (PASSWORDDATETIME + PASSWORDEXPIREDDAYS )-SYSDATE , 0))  datediff From MEMBERMASTER " +
        "Where TRIM (ORACD) = '"+empcode+"'   AND TRIM (ORATYP) = '"+usertype+"' ";
System.out.print(qry);
rs2=db.getRowset(qry);
	if(rs2.next()) {
        //System.out.print(rs2.getDouble("datediff")>0);
        if(rs2.getDouble("datediff")>0&&rs2.getDouble("datediff")<10){
		     result="Your Password will be expired with in next "+rs2.getInt("datediff")+" days";
        }else
        {
             result="N";
        }
    }
    else{
   result="N";
    }
	 //System.out.println("***********"+result+"****************");
      out.println(result);
	}
else{
qry= "select 'Y' from studentmaster where enrollmentno='"+member1+"' and " +
        "TO_CHAR (dateofbirth, 'DDMMYYYY') =TO_CHAR (TO_DATE ('"+DATE1+"', 'DD-MM-YYYY'), 'ddmmyyyy')";
    //qry ="Y";
 //  System.out.println("#####################################33"+qry);
	rs2=db.getRowset(qry);
	if(!rs2.next()) {
		     result="Invalid Combination of Date of Birth & Enrollment No. ";
        }
    else{
   result="Y";
    }
	 //System.out.println("***********"+result+"****************");
      out.println(result);
	}
}
	catch(Exception e)
	{
		out.println(e);
	}
%>
