
<%@ page import="org.json.JSONObject,java.sql.*,pgwebkiosk.*,java.util.ArrayList, java.util.HashMap, java.util.List, java.util.Map" errorPage="ExceptionHandler.jsp"%>
<%
try{
String WithRegCode="Y";

String pStudentID=request.getParameter("memberid")==null?"":request.getParameter("memberid");
String programCode=request.getParameter("programcode")==null?"":request.getParameter("programcode");
String pQuota=request.getParameter("quota")==null?"":request.getParameter("quota");
String academicYear=request.getParameter("academicyear")==null?"":request.getParameter("academicyear");
String branchCode=request.getParameter("branchcode")==null?"":request.getParameter("branchcode");
String pInstitutecode=request.getParameter("institutecode")==null?"":request.getParameter("institutecode");
String pGlobalCompanyCode=request.getParameter("companycode")==null?"":request.getParameter("companycode");
String CategoryCode=request.getParameter("categorycode")==null?"":request.getParameter("categorycode");

String pSemester="";
String pSemesterType="";
String pHostel="";
String pHostelType="";
String pRegcode="";
String Temp="";
String errorStr="";
String varAdvance="A";
String varExcess="E";
DBHandler db=new DBHandler();
ResultSet rs1=null;
ResultSet rs2=null;
ResultSet rs3=null;
ResultSet rs4=null;
ResultSet rs5=null;
ResultSet rs6=null;
ResultSet RsChk=null;
boolean result=false;
int Temp1=0;

OLTEncryption enc=new OLTEncryption();
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress=session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());

if(!pStudentID.equals("")  && !programCode.equals("") &&  !pQuota.equals("") &&  !academicYear.equals("") && 
   !branchCode.equals("")  && !pInstitutecode.equals("") &&  !pGlobalCompanyCode.equals("") &&  !CategoryCode.equals(""))
{

 //-----------------------------
  //-- Enable Security Page Level
  //-----------------------------
String seqqry="Select WEBKIOSK.ShowLink('275','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
  RsChk= db.getRowset(seqqry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------










String qry1="  Select FeeHead From FeeStructure  Where InstituteCode = '"+pInstitutecode+"'  And CompanyCode = '"+pGlobalCompanyCode+"'"+
            "  And AcademicYear= '"+academicYear+"'  And ProgramCode = '"+programCode+"'  And BranchCode= '"+branchCode+"'"+
            "  And Quota = '"+pQuota+"'  And Nvl('"+WithRegCode+"','N') = 'Y' And SemesterType = '"+pSemesterType+"'"+
            "  And Nvl(Deactive,'N') = 'N'"+
            "  Union All "+
            "  Select FeeHead From FeeStructureIndividual  Where InstituteCode = '"+pInstitutecode+"' And CompanyCode= '"+pGlobalCompanyCode+"'"+
            "  And AcademicYear='"+academicYear+"' And ProgramCode = '"+programCode+"'"+
            "  And BranchCode='"+branchCode+"' And StudentId    = '"+pStudentID+"'  And Nvl('"+WithRegCode+"','N') = 'Y'"+
            "  And SemesterType ='"+pSemesterType+"'  And Nvl(Deactive,'N') = 'N'  And Rownum = 1 ";
          


String qry2= " Select Distinct fs.FeeHead From C#WaitFeeStructure fs    Where Fs.InstituteCode = '"+pInstitutecode+"'"+
             " And Fs.CompanyCode= '"+pGlobalCompanyCode+"'  And Fs.AcademicYear = '"+academicYear+"'"+
             " And Fs.CategoryCode='"+CategoryCode+"'  And Fs.Quota= '"+pQuota+"'"+
             " And Fs.Semester = '"+pSemester+"' And Fs.SemesterType= '"+pSemesterType+"'  And Nvl(Fs.Deactive,'N')= 'N'";         

if(!"".equals(programCode)){
rs1=db.getRowset(qry1);

while(rs1.next()){
Temp=rs1.getString("FeeHead");
if(Temp!=null){
break;
} 
}
}else{
rs1=db.getRowset(qry2);

while(rs1.next()){
Temp=rs1.getString("FeeHead");
if(Temp!=null){
break;
} 
}
}// end of else block;


if(Temp!=null){
result=true;
}
else{
result=false;
}

if(result==false){
errorStr="Fee structure not found.";
}
else{
//-------fOR POPULATE ACCOUNTING CURRENCY
String currencyCodeofAccounting="";

String qry3="Select Distinct CurrencyCode 	From CurrencyMaster	Where NVl(Deactive,'N')= 'N'	And AccountingCurrency = 'Y'";

rs2=db.getRowset(qry3);

if(rs2.next()){
currencyCodeofAccounting=rs2.getString(1);
}

if(currencyCodeofAccounting==null || !"".equals(currencyCodeofAccounting))
{
errorStr="Accounting Currency not Found in Currency Master. Contact Administrator..";
}
//=================================================================================//=========================================================
//PROCEDURE popfeeSemester IS
//Cursor 		BWF is 
//	-------------------
 String qry4=" Select  b.ProgramCode programcode,b.BranchCode branchcode,Nvl(b.HostelAllow,'N') HostelAllow,Nvl(b.HostelType,'*') HostelType,	rm.RegCode regcode, b.Semester semester, b.SemesterType  semestertype"+
             " From V#SFmStudentRegistration b,RegistrationMaster rm Where rm.RegCode = b.RegCode And rm.InstituteCode	= b.InstituteCode "+
	         " And rm.CompanyCode= b.CompanyCode ANd Nvl(rm.FeeCollection,'N') = 'Y'"+		 			 
             " And b.Institutecode  ='"+ pInstitutecode+"' And b.CompanyCode = '"+pGlobalCompanyCode+"' And b.StudentID = '"+pStudentID+"' "+
	         " And Nvl(b.RegAllow,'N') = 'Y' And b.AcademicYear='"+academicYear+"' And nvl(b.ProgramCode,'*') = Nvl('"+ programCode+"','*') "+
             " And  nvl(b.BranchCode,'*')= nvl('"+branchCode+"','*')order by b.Semester, b.SemesterType,rm.RegDateFrom	";			
	
	Temp ="N";	
	
	String hostelallow="";
	Map feeDetailMap=new HashMap();
	rs3=db.getRowset(qry4);
	/
//For BWFRec in BWF Loop
List feeDetailList =new ArrayList();


	while(rs3.next()){
	feeDetailMap=new HashMap();

		pSemester=rs3.getString("semester")==null?"":rs3.getString("semester");
	    pSemesterType= rs3.getString("semestertype")==null?"":rs3.getString("semestertype");
		feeDetailMap.put("Semester",pSemester);
		feeDetailMap.put("SemesterType",pSemesterType);
		feeDetailMap.put("Head","Sem-"+pSemester+"("+pSemesterType+")");
		feeDetailMap.put("Hostel",hostelallow);
		feeDetailMap.put("HostelType",rs3.getString("HostelType")==null?"":rs3.getString("HostelType"));
		feeDetailMap.put("Regcode",rs3.getString("regcode")==null?"":rs3.getString("regcode"));
	
		pHostel=hostelallow;
		pHostelType=rs3.getString("HostelType")==null?"":rs3.getString("HostelType");
		pRegcode=rs3.getString("regcode")==null?"":rs3.getString("regcode");

		Temp = "Y";
		if("N".equals(hostelallow)){
		feeDetailMap.put("Hostel","N");
		pHostel="N";
		feeDetailMap.put("HostelType","*");
		pHostelType="*";
		}
		} // end of while loop
if("N".equals(Temp)){
errorStr="Program Code / Branch Code  is not same in StudentRegistration..";

}

//PROCEDURE popsemester IS
//Cursor c1 is
String qry5=" Select x.Quota, x.Semester, x.Semestertype,x.ForRegCode "+
            " From (	Select F.Quota Quota, D.FeePaidSemester Semester, D.SemesterType Semestertype,F.ForRegCode ForRegCode "+
            " From FeeTransaction F,FeeTransactionDetail D Where f.InstituteCode = '"+pInstitutecode+"'"+
            " And F.CompanyCode = '"+pGlobalCompanyCode+"' ANd f.AcademicYear = '"+academicYear+"'"+
            " ANd F.StudentId = '"+pStudentID+"' And F.DocMode 	<> 'C' And D.InstituteCode 	= F.InstituteCode  "+
            " And D.CompanyCode = F.CompanyCode And D.FinancialYear 	= f.FinancialYear And D.TransactionType = f.TransactionType  "+
            " And D.Prno = F.Prno And f.Quota is not null And d.FeepaidSemester is not null And d.SemesterType is not null "+
            " And f.ForRegCode is not null	"+	
	        " Union "+
            " Select F.Quota Quota, D.Semester Semester, D.SemesterType Semestertype,F.ForRegCode ForRegCode  "+
	 	    " From FeeTransfer F,FeeTransferHead D Where f.InstituteCode = '"+pInstitutecode+"'"+
		    " And F.CompanyCode = '"+pGlobalCompanyCode+"'	ANd f.AcademicYear = '"+academicYear+"'"+
		    " ANd F.StudentId = '"+pStudentID+"' And F.DocMode	<> 'C' "+
		    " And D.InstituteCode = F.InstituteCode And D.CompanyCode = F.CompanyCode "+
		    " And D.FinancialYear = f.FinancialYear And D.Tdate = f.Tdate And D.Tno= F.Tno  "+
			 " And f.Quota is not null	And d.Semester is not null And d.SemesterType is not null "+
			 " And f.ForRegCode is not null ) x Group by x.Quota,x.ForRegCode,x.Semester,x.SemesterType "; 
			
			
			
			Map semesterMap;
	       rs4=db.getRowset(qry5);
	

List semesterDetailList =new ArrayList();
	while(rs4.next()){
	semesterMap=new HashMap();
	semesterMap.put("quota",rs3.getString("Quota")==null?"":rs3.getString("Quota"));
	semesterMap.put("forregcode",rs3.getString("ForRegCode")==null?"":rs3.getString("ForRegCode"));
	semesterMap.put("semester",rs3.getString("Semester")==null?"":rs3.getString("Semester"));
	semesterMap.put("semestertype",rs3.getString("SemesterType")==null?"":rs3.getString("SemesterType"));
    semesterDetailList.add(semesterDetailList);
	}
//PROCEDURE popFeeDetailALL(
double  TempConversionRate=0.0d;
double  TempCurrencyAmount=0.0d;

String qry6=" Select  nvl(X.DisAmount,0) DisAmount,nvl(sUM(nvl(x.FeeAmount,0) + nvl(x.FcFeeAmount,0)),0) FeeAmount From (	 "+
		    " Select  nvl(d.DisAmount,0) DisAmount,	Sum(g.FeeAmount) FeeAmount, Nvl(E.fcFeeAmount,0) fcFeeAmount "+
		    " From	FeeStructure g,FeeHeads s,( Select 	Semester DisSemester,SemesterType DisSemesterType,Sum(nvl(DiscountAmount,0)) DisAmount "+
			" From StudentFeeDiscount "+
			" Where InstituteCode= '"+pInstitutecode+"' And CompanyCode ='"+pGlobalCompanyCode+"'"+
			" And AcademicYear= '"+academicYear+"' And Nvl(ProgramCode,'*')= Nvl('"+programCode+"','*') "+
			" And Nvl(BranchCode,'*')	= Nvl('"+branchCode+"','*') And StudentID= '"+pStudentID+"'"+
			" And RegCode='"+pRegcode+"' And Feehead Not in (Select F.FeeHead From FeeHeads f "+
			" Where f.InstituteCode = '"+pInstitutecode+"'  And  F.CompanyCode    = '"+pGlobalCompanyCode+"'"+
			" And f.Feetype  = 'H'  And '"+pHostel+"' = 'N' "+
			" )Group By Semester, SemesterType) d, "+
			
			" (Select Sum(Fc.FeeAmount) fcfeeAmount From FeeStructureCriteria fc "+
       		" Where fc.InstituteCode	= '"+pInstitutecode+"' And fc.CompanyCode ='"+pGlobalCompanyCode+"'"+
  			" And fc.AcademicYear= '"+academicYear+"' And Nvl(fc.ProgramCode,'*')= Nvl('"+programCode+"','*') "+
			" And Nvl(fc.BranchCode,'*')= Nvl('"+branchCode+"','*') And fc.Quota= '"+pQuota+"' And fc.Semester='"+pSemester+"' "+
          	" And fc.SemesterType= '"+pSemesterType+"' And Nvl(fc.FeeAmount,0) > 0 And fc.Feehead not IN (Select F.FeeHead From FeeHeads f "+
			" Where f.InstituteCode = '"+pInstitutecode+"' And  F.CompanyCode = '"+pGlobalCompanyCode+"'"+
			" And f.Feetype  = 'H' And '"+pHostel+"' = 'N' "+
		    " )"+
			" And  (fc.operator IN ('IN','=') And Fc.CriteriaValue	= '"+pHostelType+"')"+																						
			" ) E "+
			" Where g.InstituteCode= '"+pInstitutecode+"' And g.CompanyCode = '"+pGlobalCompanyCode+"' And g.Quota= '"+pQuota+"'"+
       		" And g.AcademicYear= '"+academicYear+"' And Nvl(g.ProgramCode,'*')= Nvl('"+programCode+"','*') "+
		 	" And Nvl(g.BranchCode,'*') =  Nvl('"+branchCode+"','*') And	g.Semester='"+pSemester +"'"+
            " And g.SemesterType= '"+pSemesterType+"' aNd Nvl(g.FeeAmount,0) > 0 And d.DisSemester(+)= g.Semester "+
 		   " And d.DisSemesterType(+) = g.SemesterType And s.FeeHead = g.FeeHead And s.InstituteCode= g.InstituteCode	"+
           " And S.CompanyCode = g.CompanyCode And S.FeeType	<>'R'  "+
		   " And Nvl(s.Deactive,'N')   = 'N'	And Not Exists ( Select  1 From FeeStructureIndividual FSI1 "+
           " Where  fsi1.InstituteCode = '"+pInstitutecode+"' And fsi1.CompanyCode = '"+pGlobalCompanyCode+"'"+
           " And fsi1.StudentID= '"+pStudentID+"' And	fsi1.AcademicYear='"+academicYear +"'"+
		   " And Nvl(fsi1.ProgramCode,'*')= Nvl('"+programCode+"','*') And Nvl(fsi1.BranchCode,'*')= Nvl('"+branchCode+"','*') "+
		   " And Nvl(fsi1.Deactive,'N')= 'N'	And fsi1.Semester = g.Semester And fsi1.SemesterType= g.SemesterType "+ 
		   " And fsi1.FeeHead= g.FeeHead And	RegCode	= '"+pRegcode+"')"+
		   " And Not Exists ( Select  1 From FeeStructureCriteria fsc Where  fsc.InstituteCode= '"+pInstitutecode+"'"+
		   " And fsc.CompanyCode = '"+pGlobalCompanyCode+"' And fsc.AcademicYear = '"+academicYear+"'"+
		   " And Nvl(fsc.ProgramCode,'*') = Nvl('"+programCode+"','*')  "+
		  "  And Nvl(fsc.BranchCode,'*')= Nvl('"+branchCode+"','*') "+
		  "	And fsc.Semester = g.Semester And fsc.SemesterType= g.SemesterType "+
		  "	And fsc.FeeHead	= g.FeeHead And	fsc.Quota= g.Quota And    Nvl(fsc.FeeAmount,0)>0 "+
		  "	And (fsc.operator IN ('IN','=') And Fsc.CriteriaValue	= '"+pHostelType+"')"+
		  "			) And	G.Feehead not in (Select F.FeeHead From FeeHeads f "+
		  " 	Where f.InstituteCode = '"+pInstitutecode+"'  And  F.CompanyCode  = '"+pGlobalCompanyCode+"'"+
		  "	And f.Feetype = 'H' And '"+pHostel+"' = 'N'  ) Group By d.DisAmount, e.fcFeeamount "+
     	  "	Union All "+
		
		  "		Select nvl(k.DisAmount,0) DisAmount,Sum(i.FeeAmount) FeeAmount, Nvl(E.fcFeeAmount,0) fcFeeAmount "+
		  "		From FeeStructureIndividual i, Feeheads s, ( Select Semester DisSemester, SemesterType DisSemesterType,  "+
		  "		Sum(nvl(DiscountAmount,0)) DisAmount From StudentFeeDiscount Where InstituteCode= '"+pInstitutecode+"' "+
		  "		And CompanyCode ='"+pGlobalCompanyCode+"' and	AcademicYear = '"+academicYear+"' "+
		  "		And Nvl(ProgramCode,'*') = Nvl('"+programCode+"','*') And Nvl(BranchCode,'*')= Nvl('"+branchCode+"','*') "+
		  "		And StudentID= '"+pStudentID+"' And RegCode ='"+pRegcode+"' And	Feehead not in(Select F.FeeHead From FeeHeads f  "+
		  "		Where f.InstituteCode = '"+pInstitutecode+"' And  F.CompanyCode = '"+pGlobalCompanyCode+"'	And f.Feetype  = 'H'  "+
		  "		And '"+pHostel+"' = 'N' ) Group By Semester, SemesterType) k, (Select Sum(Fc.FeeAmount) fcfeeAmount  "+
		  "		From FeeStructureCriteria fc Where fc.InstituteCode = '"+pInstitutecode+"' And fc.CompanyCode ='"+pGlobalCompanyCode+"' "+
		  "		And fc.AcademicYear= '"+academicYear+"' And Nvl(fc.ProgramCode,'*')= Nvl('"+programCode+"','*') "+
		  "		And Nvl(fc.BranchCode,'*')= Nvl('"+branchCode+"','*') And fc.Quota= '"+pQuota+"' And  fc.Semester=	'"+pSemester+"'"+
		  "		And fc.SemesterType = '"+pSemesterType+"' And  Nvl(fc.FeeAmount,0) > 0 And fc.Feehead not IN (Select F.FeeHead From FeeHeads f "+
		  "		Where f.InstituteCode = '"+pInstitutecode+"' And  F.CompanyCode = '"+pGlobalCompanyCode+"' And f.Feetype  = 'H' And '"+pHostel+"' = 'N'  ) "+
		  "		And (fc.operator IN ('IN','=') And Fc.CriteriaValue	= '"+pHostelType+"')	) E	"+			 
	      "		Where i.InstituteCode= '"+pInstitutecode+"' And i.CompanyCode = '"+pGlobalCompanyCode+"' And i.StudentID='"+ pStudentID +"'"+
		  "  		And i.AcademicYear ='"+academicYear+"' And Nvl(i.ProgramCode,'*') = Nvl('"+programCode+"','*') "+
		  "		And Nvl(i.BranchCode,'*') = Nvl('"+branchCode+"','*') And Nvl(i.Deactive,'N') = 'N' "+
		  "		And i.RegCode =	'"+pRegcode+"' And i.Semester	= '"+pSemester+"' And	i.SemesterType = '"+pSemesterType+"'"+
		  "		And k.DisSemester(+)= i.Semester And k.DisSemesterType(+) = i.SemesterType "+
		  "		And s.FeeHead=	i.FeeHead And s.InstituteCode 	= i.InstituteCode And S.CompanyCode= i.CompanyCode "+
		  "		And S.FeeType<>'R' "+
		  "		And Nvl(s.Deactive,'N')   = 'N'	 And i.Feehead not in (Select F.FeeHead From FeeHeads f "+
		  "		Where f.InstituteCode = '"+pInstitutecode+"'  And  F.CompanyCode  = '"+pGlobalCompanyCode+"' "+
		  "		And f.Feetype  = 'H' And '"+pHostel+"' = 'N' ) Group By  k.DisAmount,E.fcFeeAmount "+
		  "     Union All "+
		  "   Select 0 DisAmount,Sum(Nvl(FF.FineAmount,0)- Nvl(FF.WaiverAmount,0)) FeeAmount, 0 fcFeeAmount "+
		  "   From FeeFineTransaction FF, FeeTransaction FT,FeeTransactionDetail Ftd,FeeHeads s"+
		  "   Where Ft.InstituteCode = '"+pInstitutecode+"' And   ft.CompanyCode='"+pGlobalCompanyCode+"'"+
		  "   And Ft.AcademicYear = '"+academicYear+"' And Nvl(ft.ProgramCode,'*')= Nvl('"+programCode+"','*')"+
		  " And Nvl(ft.BranchCode,'*') = Nvl('"+branchCode+"','*') And   Ft.Quota = '"+pQuota+"'"+
		  " And ft.ForRegCode = '"+pRegcode+"' And Ft.StudentId  = '"+pStudentID+"' And   Ft.Docmode <> 'C' "+
		  " ANd Ftd.FeePaidSemester	= '"+pSemester+"' ANd Ftd.SemesterType = '"+pSemesterType+"' And Ftd.CompanyCode=Ft.CompanyCode "+
		  " And Ftd.FinancialYear=Ft.FinancialYear And Ftd.Prno=Ft.Prno And Ftd.TransactionType = Ft.TransactionType "+
		  " And FF.CompanyCode = Ftd.CompanyCode And   FF.FinancialYear    = Ftd.FinancialYear "+
          " And FF.Prno = Ftd.Prno	And   FF.TransactionType  = Ftd.TransactionType	And FF.CompanyCode = Ftd.CompanyCode  "+
       	  "	And FF.FinancialYear = Ftd.FinancialYear And FF.Prno = Ftd.Prno And FF.FineFeeHead=Ftd.FeeHead  "+
          " And FF.StudentID  ='"+pStudentID+"' ANd Nvl(FF.TransactionType,'*') = 'R' "+
		  " And s.FeeHead =	Ftd.FeeHead And s.InstituteCode = Ftd.InstituteCode And S.CompanyCode= Ftd.CompanyCode "+
		  " And Nvl(s.Deactive,'N') = 'N' And 'Y' = '"+WithRegCode+"'"+
		  " Union All "+
 		  " Select  0 DisAmount,Sum(Fs.FeeAmount) FeeAmount, null fcFeeAmountfs From C#WaitFeeStructure fs,FeeHeads Fh"+
		  " Where Fs.InstituteCode 	= '"+pInstitutecode+"'  And Fs.CompanyCode = '"+pGlobalCompanyCode+"'"+
		  " And Fs.AcademicYear = '"+academicYear+"' And Fs.CategoryCode='"+CategoryCode +"' And Fs.Quota= '"+pQuota+"'"+
		  " And Fs.Semester = '"+pSemester+"' And Fs.SemesterType = '"+pSemesterType+"' And Nvl(Fs.Deactive,'N')= 'N'"+
		  " And Fh.FeeHead=fs.Feehead And Fh.InstituteCode = fs.InstituteCode And Fh.CompanyCode = fs.CompanyCode "+
		  " And Fh.FeeHead = fs.FeeHead And	Fh.FeeType<>'R'   "+
		  " And Nvl(Fh.deactive,'N') = 'N' "+
		  " And Fs.Feehead not in (Select F.FeeHead From FeeHeads f  Where f.InstituteCode = '"+pInstitutecode+"'"+ 
		  " And  F.CompanyCode    = '"+pGlobalCompanyCode+"' And f.Feetype = 'H' And '"+pHostel+"' = 'N' ) "+
		  " And '"+programCode+"' Is Null )X gROUP BY X.DisAmount	  Order By 	2 ";



String qry7= "Select Sum(nvl(ApprovalAmount,0)) ApprovalAmount From StudentSpecialApproval Where InstituteCode= '"+pInstitutecode+"'"+
		     " And CompanyCode = '"+pGlobalCompanyCode+"' And ForSemester= '"+pSemester+"'	And SemesterType= '"+pSemesterType+"'"+
		     " And StudentID= '"+pStudentID+"' And	RegCode	= '"+pRegcode+"' And	Trunc(DateOfApproval) <= Trunc(Sysdate) "+
			 " And nvl(Trunc(ApprovalUpTo),Trunc(Sysdate)) >= Trunc(Sysdate) And Nvl(Status,'P')='P' "+
		     " And Feehead Not in (Select F.FeeHead From FeeHeads f Where f.InstituteCode = '"+pInstitutecode +"'"+
		     " And  F.CompanyCode    = '"+pGlobalCompanyCode+"' And f.Feetype  = 'H' And '"+pHostel+"' = 'N' ) "; 
	
//SSARec SSA%RowType;
//-------------If FeeCurrencyIs Accounting Currency And Transaction Type Is Receipt
//Cursor CPaid(pStudentId Varchar2,pSemester Number,pSemesterType Varchar2) Is
String qry8=" Select nvl(x.PaidAmount,0) PaidAmount From (Select Sum(Nvl(d.FeeCurrencyAmount,0)) PaidAmount From FeeTransactionDetail d, FeeTransaction m,Feeheads h "+
	        " Where m.InstituteCode= '"+pInstitutecode+"' And m.CompanyCode = '"+pGlobalCompanyCode+"' And m.StudentID='"+pStudentID+"' "+
	        " And m.AcademicYear = '"+academicYear+"'	And  m.Quota='"+pQuota+"' And	m.ForRegCode='"+pRegcode+"' "+
	        " ANd m.CompanyCode = d.CompanyCode And m.InstituteCode   = d.InstituteCode And m.FinancialYear=d.FinancialYear "+
	        " And m.TransactionType = d.TranSactionType And m.TransactionType	='R' And m.PRNO	=d.PRNO	And D.Feehead=h.FeeHead "+
	        " And d.CompanyCode = h.Companycode And h.FeeType	Not In ('"+varAdvance +"','"+varExcess+"')	And Nvl(d.FeePaidSemester,0)= Nvl('"+pSemester+"',0) "+
	        " And Nvl(d.SemesterType,'*')=Nvl('"+pSemesterType+"','*') And m.DocMode != 'C' AND NOT EXISTS (SELECT 'Y' FROM FEETRANSACTIONDETAILFC fc WHERE "+
            " fc.Prno = d.prno And fc.Slno = d.slno  AND fc.feehead = d.Feehead And fc.CompanyCode = d.CompanyCode And fc.InstituteCode = d.InstituteCode "+
	        " And fc.FinancialYear = d.FinancialYear And TransactionType = d.Transactiontype AND ConversionRateFlag = 'N'  "+
	        " And Fc.RecvCurrencyCode != D.FeeCurrencyCode) "+
            "  Union All "+
	        " Select nvl(Sum(Nvl(d.FeeCurrencyAmount,0)),0) PaidAmount From FeeTransferHead d, FeeTransfer m,Feeheads h "+
	        " Where m.InstituteCode= '"+pInstitutecode+"' And m.CompanyCode ='"+pGlobalCompanyCode+"' And m.StudentID= '"+pStudentID +"'"+
	        " And m.AcademicYear= '"+academicYear+"' And   m.Quota='"+pQuota+"' And	m.ForRegCode= '"+pRegcode+"'"+
	        "  ANd m.CompanyCode = d.CompanyCode And m.InstituteCode  = d.InstituteCode And   m.FinancialYear=d.FinancialYear "+
	         "  And m.TNO=d.TNO And D.TOFeeheadOrGlID	= h.FeeHead And	d.CompanyCode = h.Companycode And h.FeeType Not In ('"+varAdvance +"','"+varExcess+"') "+
	         " And Nvl(d.Semester,0)= Nvl('"+pSemester+"',0)	And Nvl(d.SemesterType,'*')=Nvl('"+pSemesterType+"','*') And m.Docmode	!= 'C' "+
	         " AND NOT EXISTS (SELECT 'Y' FROM FeeTransferDetailFC fc WHERE fc.Tno = d.Tno And fc.Slno = d.slno  AND fc.Tofeehead = d.ToFeeheadOrGlID "+
	         " And fc.CompanyCode = d.CompanyCode And fc.InstituteCode = d.InstituteCode And fc.FinancialYear = d.FinancialYear "+
	         " AND ConversionRateFlag = 'N' And Fc.RecvCurrencyCode != D.ToCurrencyCode) )x "; 

	//InsPaid Cpaid%RowType;	
//	-----------------If FeeCurrencyIs Accounting Currency And Transaction Type Is Refund
//	Cursor CRefund(pStudentId Varchar2,pSemester Number,pSemesterType Varchar2/*,pCurrencyCode Varchar2*/) Is
String qry9=" Select nvl(nvl(x.PaidAmount,0),0) PaidAmount From (Select Sum(Nvl(d.FeeCurrencyAmount,0)) PaidAmount From FeeTransactionDetail d, FeeTransaction m,FeeHeads h "+
	        "  Where m.InstituteCode = '"+pInstitutecode+"' And m.CompanyCode = '"+pGlobalCompanyCode+"' And m.StudentID='"+pStudentID+"'"+
"	And m.AcademicYear= '"+academicYear+"' And  m.Quota='"+pQuota+"' And m.ForRegCode='"+pRegcode+"' ANd	m.CompanyCode = d.CompanyCode "+
"	And m.TransactionType='P' And	m.PRNO	= d.PRNO And m.Transactiontype	=d.TransactionType And   m.FinancialYear  = d.FinancialYear "+
"	And m.instituteCode=d.InstituteCode And D.Feehead=h.FeeHead And	d.CompanyCode = h.Companycode And h.FeeType Not in ('"+varAdvance +"','"+varExcess+"') "+
"	And Nvl(d.RefundType,'*') <> 'R' And Nvl(d.FeePaidSemester,0)= Nvl('"+pSemester+"',0) And Nvl(d.SemesterType,'*')=Nvl('"+pSemesterType+"','*')"+
"	And m.DocMode != 'C' AND NOT EXISTS (SELECT 'Y' FROM FEETRANSACTIONDETAILFC fc WHERE fc.Prno = d.prno "+
"	And fc.Slno = d.Slno And fc.CompanyCode = d.CompanyCode	And fc.FinancialYear = d.Financialyear	And fc.TransactionType = d.TransactionType "+
"	And InstituteCode = d.InstituteCode AND fc.feehead = d.Feehead And Fc.RecvCurrencyCode != D.FeeCurrencyCode "+
"	AND ConversionRateFlag = 'N') 	 "+
"      Union All "+
"	Select nvl(Sum(Nvl(d.FeeCurrencyAmount,0)),0) PaidAmount From FeeTransferHead d, FeeTransfer m,Feeheads h Where m.InstituteCode= '"+pInstitutecode+"'"+
"	And m.CompanyCode= '"+pGlobalCompanyCode+"' And m.FromStudentID='"+pStudentID+"' And m.FromAcademicYear= '"+academicYear+"'"+
"	And m.FromQuota	= '"+pQuota+"' And m.FromRegCode='"+pRegcode+"' ANd	m.CompanyCode = d.CompanyCode And m.InstituteCode= d.InstituteCode  "+
"	And m.FinancialYear=d.FinancialYear And	m.TNO=d.TNO And	D.FromFeehead=h.FeeHead And d.CompanyCode= h.Companycode  "+
"	And h.FeeType Not In ('"+varAdvance +"','"+varExcess+"') And Nvl(d.FromSemester,0)	= Nvl('"+pSemester+"',0) And	Nvl(d.FromSemesterType,'*')=Nvl('"+pSemesterType+"','*') "+
"	And m.DocMode != 'C' And d.FromCurrencyCode = d.ToCurrencyCode AND NOT EXISTS (SELECT null FROM FeeTransferDetailFC fc WHERE "+
"	fc.Tno = d.Tno And fc.Slno = d.slno AND fc.FromFeehead = d.FromFeehead And fc.CompanyCode = d.CompanyCode And fc.InstituteCode = d.InstituteCode "+
"	And fc.FinancialYear = d.FinancialYear AND ConversionRateFlag = 'N' And Fc.RecvCurrencyCode != D.FromCurrencyCode) "+
"     Union All "+
"	Select nvl(Sum(Nvl(Fc.RecvCurrencyAmount,0)),0) PaidAmount From FeeTransferHead d, FeeTransfer m,Feeheads h,FeetransferDetailFc Fc "+
"	Where m.InstituteCode= '"+pInstitutecode+"' And m.CompanyCode	= '"+pGlobalCompanyCode+"' And m.FromStudentID='"+pStudentID+"'"+
"	And m.FromAcademicYear	= '"+academicYear+"' And  m.FromQuota='"+pQuota+"' And m.FromRegCode	='"+pRegcode+"'"+
"	ANd m.CompanyCode = d.CompanyCode And m.InstituteCode = d.InstituteCode And m.FinancialYear=d.FinancialYear "+
"	And m.TNO=d.TNO And D.FromFeehead = h.FeeHead And d.CompanyCode = h.Companycode And h.FeeType Not In ('"+varAdvance +"','"+varExcess+"') "+
"	And Nvl(d.FromSemester,0) = Nvl('"+pSemester+"',0) And Nvl(d.FromSemesterType,'*')=Nvl('"+pSemesterType+"','*')And m.DocMode != 'C'  "+
"	And d.FromCurrencyCode <> d.ToCurrencyCode AND fc.Tno = d.Tno And fc.Slno = d.slno And fc.CompanyCode = d.CompanyCode "+
"	And fc.InstituteCode = d.InstituteCode And fc.FinancialYear = d.FinancialYear )x ";

//	InsRefund CRefund%RowType;
	
	
	//--------For Advance Amount Collection
	
//	Cursor CAdvance(pStudentId Varchar2,pSemester Number,pSemesterType Varchar2) Is
String qry10="Select nvl(x.AdvanceAmount,0) AdvanceAmount From (Select Sum(Nvl(d.FeeAmount,0)) AdvanceAmount From FeeTransactionDetail d, FeeTransaction m,FeeHeads h "+
"	Where m.InstituteCode = '"+pInstitutecode+"' And m.CompanyCode = '"+pGlobalCompanyCode+"'	And m.StudentID	= '"+pStudentID+"'"+
"	And m.AcademicYear= '"+academicYear+"' And  m.Quota='"+pQuota+"' And	m.ForRegCode='"+pRegcode+"' ANd m.CompanyCode= d.CompanyCode "+
"	And m.TransactionType= 'R' And m.PRNO =d.PRNO And m.TransactionType = d.TransactionType "+
"	And m.InstituteCode = d.InstituteCode And m.FinancialYear = d.FinancialYear And d.FeeHead=h.FeeHead "+
"	And d.CompanyCode = h.Companycode And h.Feetype	in ('"+varAdvance +"','"+varExcess+"') And Nvl(d.FeePaidSemester,0)= Nvl('"+pSemester+"',0) "+
"	And Nvl(d.SemesterType,'*')=Nvl('"+pSemesterType+"','*') And m.DocMode != 'C' AND NOT EXISTS (SELECT 'Y' FROM FEETRANSACTIONDETAILFC fc WHERE "+
"	fc.Prno = d.prno And fc.Slno = d.Slno AND fc.feehead = d.Feehead And fc.FinancialYear = d.FinancialYear And fc.InstituteCode = d.InstituteCode "+
"	And fc.CompanyCode = d.CompanyCode And fc.Transactiontype = d.TransactionType And Fc.RecvCurrencyCode != D.FeeCurrencyCode "+
"	AND ConversionRateFlag = 'N')	 "+
"	Union All "+
"	Select nvl(Sum(Nvl(d.FeeAmount,0)),0) AdvanceAmount From FeeTransferHead d, FeeTransfer m,Feeheads h Where m.InstituteCode 	= '"+pInstitutecode+"'"+
"	And m.CompanyCode = '"+pGlobalCompanyCode+"' And m.StudentID	='"+pStudentID+"' And m.AcademicYear= '"+academicYear+"' "+
"	And m.Quota='"+pQuota+"' And m.ForRegCode='"+pRegcode+"' ANd m.CompanyCode= d.CompanyCode And m.InstituteCode= d.InstituteCode "+
"	And m.FinancialYear=d.FinancialYear And	m.TNO=d.TNO And D.ToFeeheadOrGlID=h.FeeHead And d.CompanyCode     = h.Companycode "+
"	And h.FeeType In ('"+varAdvance +"','"+varExcess+"') And Nvl(d.Semester,0)	= Nvl('"+pSemester+"',0) And Nvl(d.SemesterType,'*')	=Nvl('"+pSemesterType+"','*') "+
"	And m.DocMode != 'C' AND NOT EXISTS (SELECT 'Y' FROM FeeTransferDetailFC fc WHERE fc.Tno = d.Tno And fc.Slno = d.slno  "+
"	AND fc.Tofeehead = d.ToFeeheadOrGlID And fc.CompanyCode = d.CompanyCode And fc.InstituteCode = d.InstituteCode "+
"	And fc.FinancialYear = d.FinancialYear AND ConversionRateFlag = 'N' And Fc.RecvCurrencyCode != D.ToCurrencyCode) )x ";
	
//	InsAdvance CAdvance%RowType;

//	Cursor CAdvanceRefund(pStudentId Varchar2,pSemester Number,pSemesterType Varchar2) Is 
	
String qry11="	Select nvl(x.AdvanceAmountRefund,0) PaidAmount from (Select Sum(Nvl(d.FeeAmount,0)) AdvanceAmountRefund	From FeeTransactionDetail d, FeeTransaction m,FeeHeads h "+
" Where m.InstituteCode = '"+pInstitutecode+"' And m.CompanyCode = '"+pGlobalCompanyCode+"' And m.StudentID='"+pStudentID+"' And m.AcademicYear= '"+academicYear+"'"+
"	And m.Quota='"+pQuota+"' And	m.ForRegCode='"+pRegcode+"' ANd m.CompanyCode = d.CompanyCode And m.TransactionType='P' "+
"	And m.PRNO=d.PRNO And m.InstituteCode   = d.InstituteCode And m.Transactiontype = d.TransactionType And	m.FinancialYear = d.FinancialYear "+
"	And d.FeeHead	=h.FeeHead And d.CompanyCode = h.Companycode And h.Feetype in ('"+varAdvance +"','"+varExcess+"') And Nvl(d.FeePaidSemester,0)= Nvl('"+pSemester+"',0) "+
"	And Nvl(d.SemesterType,'*')=Nvl('"+pSemesterType+"','*') And m.DocMode != 'C' AND NOT EXISTS (SELECT 'Y' FROM FEETRANSACTIONDETAILFC fc WHERE "+
"	fc.Prno = d.prno And fc.Slno = d.slno AND fc.feehead = d.Feehead And fc.CompanyCode = d.CompanyCode And fc.InstituteCode = d.InstituteCode "+
"	And fc.FinancialYear = d.FinancialYear And TransactionType = d.Transactiontype And Fc.RecvCurrencyCode != D.FeeCurrencyCode "+
"	AND ConversionRateFlag = 'N')	 "+
"	Union All "+
"	Select nvl(Sum(Nvl(d.FeeAmount,0)),0) PaidAmount From FeeTransferHead d, FeeTransfer m,Feeheads h Where m.InstituteCode= '"+pInstitutecode+"'"+
"	And m.CompanyCode= '"+pGlobalCompanyCode+"'	And m.FromStudentID='"+pStudentID+"' And m.FromAcademicYear = '"+academicYear+"'"+
"	And m.FROMQuota='"+pQuota+"' And m.FromRegCode='"+pRegcode+"' ANd	m.CompanyCode = d.CompanyCode And m.InstituteCode = d.InstituteCode "+
"	And m.FinancialYear=d.FinancialYear And	m.TNO=d.TNO And	D.FromFeehead=h.FeeHead And d.CompanyCode= h.Companycode "+
"	And h.FeeType In ('"+varAdvance +"','"+varExcess+"') And Nvl(d.FromSemester,0)= Nvl('"+pSemester+"',0) And Nvl(d.FromSemesterType,'*')=Nvl('"+pSemesterType+"','*') "+
"	And m.DocMode != 'C' And d.FromCurrencyCode = d.ToCurrencyCode	AND NOT EXISTS (SELECT 'Y' FROM FeeTransferDetailFC fc WHERE "+
"	fc.Tno = d.Tno And fc.Slno = d.slno AND fc.FromFeehead = d.FromFeehead And fc.CompanyCode = d.CompanyCode And fc.InstituteCode = d.InstituteCode "+
"	And fc.FinancialYear = d.FinancialYear AND ConversionRateFlag = 'N' And Fc.RecvCurrencyCode != D.FromCurrencyCode)  "+
" Union All "+
"	Select nvl(Sum(Nvl(Fc.RecvCurrencyAmount,0)),0) PaidAmount From FeeTransferHead d, FeeTransfer m,Feeheads h,FeetransferDetailFc Fc "+
"	Where m.InstituteCode = '"+pInstitutecode+"' And m.CompanyCode = '"+pGlobalCompanyCode+"' And m.FromStudentID='"+pStudentID+"' "+
"	And m.FromAcademicYear= '"+academicYear+"' And  m.FromQuota='"+pQuota+"' And m.FromRegCode='"+pRegcode+"' ANd m.CompanyCode= d.CompanyCode "+
"	And m.InstituteCode = d.InstituteCode And m.FinancialYear=d.FinancialYear And m.TNO=d.TNO And D.FromFeehead=h.FeeHead "+
"	And d.CompanyCode = h.Companycode And 	h.FeeType In ('"+varAdvance +"','"+varExcess+"') And Nvl(d.FromSemester,0)	= Nvl('"+pSemester+"',0) "+
"	And Nvl(d.FromSemesterType,'*')	= Nvl('"+pSemesterType+"','*') And m.DocMode != 'C' And d.FromCurrencyCode <> d.ToCurrencyCode	"+
"	AND fc.Tno = d.Tno And fc.Slno = d.slno And fc.CompanyCode = d.CompanyCode And fc.InstituteCode = d.InstituteCode "+
"	And fc.FinancialYear = d.FinancialYear "+
"	 )x ";

//	InsAdvanceRefund CAdvanceRefund   % RowType;		
	
	
//BEGIN

//For BWFRec in BWF Loop

rs1=db.getRowset(qry6);

while(rs1.next()){
feeDetailMap.put("CourseFee","0");
feeDetailMap.put("Discount","0");
feeDetailMap.put("Approval","0");
feeDetailMap.put("Paid1","0");
feeDetailMap.put("Refund","0");
feeDetailMap.put("AdvanceCollection","0");
feeDetailMap.put("AdvanceRefund","0");
feeDetailMap.put("Advance","0");
feeDetailMap.put("Dues","0");

feeDetailMap.put("Quota",pQuota);
feeDetailMap.put("CopyQuota",pQuota);
feeDetailMap.put("CourseFee",rs1.getString("FeeAmount")==null?"0":rs1.getString("FeeAmount"));
feeDetailMap.put("Discount",rs1.getString("DisAmount")==null?"0":rs1.getString("DisAmount"));
 double amt=0.0d;
 rs2=db.getRowset(qry7);
 amt=Double.parseDouble(feeDetailMap.get("Approval")==null?"0":feeDetailMap.get("Approval").toString());
 while (rs2.next()){
 amt=amt+Double.parseDouble(rs2.getString("ApprovalAmount")==null?"0":rs2.getString("ApprovalAmount").toString());	
 }
 feeDetailMap.put("Approval",amt);

	rs2=db.getRowset(qry8);
	 amt=Double.parseDouble(feeDetailMap.get("Paid1")==null?"0":feeDetailMap.get("Paid1").toString());
		while(rs2.next()){
	        amt=amt+Double.parseDouble(rs2.getString("PaidAmount")==null?"0":rs2.getString("PaidAmount").toString());		
        	}
		    feeDetailMap.put("Paid1",amt);
	
rs2=db.getRowset(qry9);
	 amt=Double.parseDouble(feeDetailMap.get("Refund")==null?"0":feeDetailMap.get("Refund").toString());
		while(rs2.next()){
	         amt=amt+Double.parseDouble(rs2.getString("PaidAmount")==null?"0":rs2.getString("PaidAmount").toString());		
 		}
		feeDetailMap.put("Refund",amt);
	
		
rs2=db.getRowset(qry10);
	 amt=Double.parseDouble(feeDetailMap.get("AdvanceCollection")==null?"0":feeDetailMap.get("AdvanceCollection").toString());
		while(rs2.next()){
	         amt=amt+Double.parseDouble(rs2.getString("AdvanceAmount")==null?"0":rs2.getString("AdvanceAmount").toString());		
		}
		feeDetailMap.put("AdvanceCollection",amt);

rs2=db.getRowset(qry11);
	 amt=Double.parseDouble(feeDetailMap.get("AdvanceRefund")==null?"0":feeDetailMap.get("AdvanceRefund").toString());
		while(rs2.next()){
	         amt=amt+Double.parseDouble(rs2.getString("PaidAmount")==null?"0":rs2.getString("PaidAmount").toString());		
         	}
		feeDetailMap.put("AdvanceRefund",amt);


double advCallectionAmt=Double.parseDouble(feeDetailMap.get("AdvanceCollection")==null?"0":feeDetailMap.get("AdvanceCollection").toString());
double advRefund=Double.parseDouble(feeDetailMap.get("AdvanceRefund")==null?"0":feeDetailMap.get("AdvanceRefund").toString());
double advanceAmt=advCallectionAmt-advRefund;
feeDetailMap.put("Advance",advanceAmt);

double feeAmt=	Double.parseDouble(rs1.getString("FeeAmount")==null?"0":rs1.getString("FeeAmount").toString());
double disAmt=	Double.parseDouble(rs1.getString("DisAmount")==null?"0":rs1.getString("DisAmount").toString());
double paid1Amt=Double.parseDouble(feeDetailMap.get("Paid1")==null?"0":feeDetailMap.get("Paid1").toString());
double refundAmt=Double.parseDouble(feeDetailMap.get("Refund")==null?"0":feeDetailMap.get("Refund").toString());
double approvalAmt=Double.parseDouble(feeDetailMap.get("Approval")==null?"0":feeDetailMap.get("Approval").toString());
double paidAmt=Double.parseDouble(feeDetailMap.get("Paid")==null?"0":feeDetailMap.get("Paid").toString());
double duesAmt=feeAmt-(disAmt+(paid1Amt-refundAmt)+approvalAmt);
	
	feeDetailMap.put("Dues",duesAmt);
	
} // end of rs1.next() end of main loop
//END;



//--------------------- END -------------------------//
}// end of else block   errorStr="Fee structure not found."


 //-----------------------------
  //-- Enable Security Page Level
  //-----------------------------
  }
  else
   {
   %>
	<br>
	<font color=red>
	<h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team.
	<br>	<br>	<br>	<br></P>
   <%
	}
}
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}




}
catch(Exception e){
System.out.println(e);
}
%>
