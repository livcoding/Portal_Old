<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp,java.lang.ArrayIndexOutOfBoundsException" %>
<%

        DBHandler db = new DBHandler();
        OLTEncryption enc=new OLTEncryption();
         int rsum=0,ssum=0,tsum=0,usum=0,vsum=0,wsum=0;
        ResultSet rs =  null;
		ResultSet rst = null;
		ResultSet rsf=  null ;
        ResultSet rsd = null;
        ResultSet rs1 = null;
        ResultSet rs2 = null;
        ResultSet rsc = null;
        String qry = "" ,qryc="",mSUBB="",mSUBN="", mLTP="",qry1="",inst="",institute="",academic="",academicyear="";
		String table1="",table2="",table3="",table4="",table5="",table6="",table7="",table8="",table9="",table21="";
		String qryt = "",Event="",Programcode="",Companycode="";
        GlobalFunctions gb = new GlobalFunctions();
	    String mRegCode = "",event="", Academicyear="";
        String mEXAMCODE = "" ,mSubjID="",DataSublist="" ,mProgCode="",QryProgCode="",companycode="";
        String mAcademicYear = "",program="",programcode="";
        String mProgramCode = "";
        String mInstCode = "",mProgram="",mMemberName="";
		String  mreg="",mAcadmeicYear="";
		String mHOSTELTYPE = "" , macade="" ,mbranc="" ,sem="",semester="",branch="",branchcode="" ;
		String mprog="",enddate="",fromdate="",mSemester="",mName="";
		String mBranchCode = "",msid="",mCode="",mES="",mSubj1="",qrysubj="",Subject="";
        int n=0;
        String qryx="",mLTP1="",Branch="",result="",mMemberID="",mMemberType="";
        ResultSet rsx=null;
        String reqAction="",mMemberCode="",mDMemberCode="";
		String mInst="",mSubject="",minst="" ,qrys="",Semester="";
		int rsum80t1=0,rsum80t2=0,rsum80t3=0,ssum70t1=0,ssum70t2=0,ssum70t3=0,tsum60t1=0,tsum60t2=0,tsum60t3=0,
					usum50t1=0,usum50t2=0,usum50t3=0,vsum40t1=0,vsum40t2=0,vsum40t3=0,wsum30t1=0,wsum30t2=0,wsum30t3=0;
		int count=0 ,Flag=0;

        event=request.getParameter("event")==null?"":request.getParameter("event");

int ttsum1=0,ttsum2=0,ttsum3=0;

if (session.getAttribute("InstituteCode") == null)
	mInst = "";
else
	mInst = session.getAttribute("InstituteCode").toString().trim();

if(mInst.equals("JIIT") || mInst.equals("J128")   || mInst.equals("JPBS"))
    {

table1="TP#REGISTRATIONDETAIL";
table2="TP#AFTERINTERVIEW";
table3="tp#eligibilitycriteria";
table4="TP#EVENTMASTER";
table5="tp#eventcompanyparticipents";
table6="TP#ELIGIBILITYCRITERIAvalue";
table7="tp#criteriamaster";
table8="TP#COMPANYMASTER";
table9="tp#participentseventdates";
table21="studentmaster";
    }
else if (mInst.equals("JUIT")){
table1="TP#REGISTRATIONDETAIL@tpjiit";
table2="TP#AFTERINTERVIEW@tpjiit";
table3="tp#eligibilitycriteria@tpjiit";
table4="TP#EVENTMASTER@tpjiit";
table5="tp#eventcompanyparticipents@tpjiit";
table6="TP#ELIGIBILITYCRITERIAvalue@tpjiit";
table7="tp#criteriamaster@tpjiit";
table8="TP#COMPANYMASTER@tpjiit";
table9="tp#participentseventdates@tpjiit";
table21="v#studentmaster";

}else if (mInst.equals("JUET")){
table1="TP#REGISTRATIONDETAIL@tpjiit";
table2="TP#AFTERINTERVIEW@tpjiit";
table3="tp#eligibilitycriteria@tpjiit";
table4="TP#EVENTMASTER@tpjiit";
table5="tp#eventcompanyparticipents@tpjiit";
table6="TP#ELIGIBILITYCRITERIAvalue@tpjiit";
table7="tp#criteriamaster@tpjiit";
table8="TP#COMPANYMASTER@tpjiit";
table9="tp#participentseventdates@tpjiit";
table21="v#studentmaster";
}
else {
table1="TP#REGISTRATIONDETAIL";
table2="TP#AFTERINTERVIEW";
table3="tp#eligibilitycriteria";
table4="TP#EVENTMASTER";
table5="tp#eventcompanyparticipents";
table6="TP#ELIGIBILITYCRITERIAvalue";
table7="tp#criteriamaster";
table8="TP#COMPANYMASTER";
table9="tp#participentseventdates";
table21="studentmaster";
}
if (session.getAttribute("CurrentSem") == null)
	mSemester = "";
else
	mSemester = session.getAttribute("CurrentSem").toString().trim();
if (session.getAttribute("BranchCode") == null)
	mBranchCode = "";
else
	mBranchCode = session.getAttribute("BranchCode").toString().trim();
if (session.getAttribute("AcademicYearCode") == null)
	mAcadmeicYear = "";
else
	mAcadmeicYear = session.getAttribute("AcademicYearCode").toString().trim();
if (session.getAttribute("ProgramCode") == null)
	mProgram = "";
else
	mProgram = session.getAttribute("ProgramCode").toString().trim();
if (session.getAttribute("MemberID")==null)
{
	mMemberID="";
}
else
{
	mMemberID=session.getAttribute("MemberID").toString().trim();
}

if (session.getAttribute("MemberType")==null)
{
	mMemberType="";
}
else
{
	mMemberType=session.getAttribute("MemberType").toString().trim();
}

if (session.getAttribute("MemberName")==null)
{
	mMemberName="";
}
else
{
	mMemberName=session.getAttribute("MemberName").toString().trim();
}

if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
}





if (session.getAttribute("MemberName")==null)
{
	mName="";
}
else
{
	mName=session.getAttribute("MemberName").toString().trim();
}


try
{  //1
if(!mMemberID.equals("") && !mMemberType.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
{  //2

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mMacAddress =" "; //session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('88','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------
	try
	{

		mDMemberCode=enc.decode(mMemberCode);
		mMemberID=enc.decode(mMemberID);
		mMemberType=enc.decode(mMemberType);
	}
	catch(Exception e)
	{
		out.println(e.getMessage());
	}}}}
catch(Exception e)
	{
		out.println(e.getMessage());
	}
try{
qry="SELECT DISTINCT NVL (a.companycode, ' ') c FROM "+table3+" a, "+table4+" b " +
        "WHERE NVL (a.deactive, 'N') = 'N' AND a.eventcode = '"+event+"' AND " +
        "TO_DATE (TO_CHAR (SYSDATE, 'dd-mm-yyyy'), 'dd-mm-yyyy') BETWEEN " +
        "to_date(TO_CHAR (b.eventstartdate, 'dd-mm-yyyy'),'dd-mm-yyyy') " +
        "AND to_date(TO_CHAR (b.eventenddate, 'dd-mm-yyyy'),'dd-mm-yyyy') " +
        "AND NVL (b.lockevent, 'N') = 'N' AND a.eventcode = b.eventcode And not exists(Select   'Y' From    "+table5+" x where   x.EventCode   = a.EventCode  And x.CompanyCode = a.CompanyCode And ( Nvl(x.Deactive,'N') = 'Y' Or   Nvl(x.LockCompany,'N') = 'Y'))";
	//System.out.println("#####################################33"+qry);
	rs2=db.getRowset(qry);
	while(rs2.next()) {
                        result=result+rs2.getString("c")+"$";
                      }
	//result=result+"~"+result2;//+">"+TimeId;
      out.println(result);
	}
	catch(Exception e)
	{
		out.println(e);
	}
%>
