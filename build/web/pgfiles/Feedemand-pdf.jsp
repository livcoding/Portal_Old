<%-- 
    Document   : Feedemand-pdf
    Created on : 22 Nov, 2019, 10:04:59 AM
    Author     : VIVEK.SONI
--%>

<%@page import="javax.servlet.*,javax.servlet.http.*,java.io.*,java.util.*,com.lowagie.text.pdf.*, com.lowagie.text.*,java.awt.Color.*,java.text.*"%>
<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<HTML>
<head>
    <TITLE>#### [ View Academic Fee detail  ] </TITLE>

</head>
<%

       OLTEncryption enc=new OLTEncryption();
String qry="";
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
ResultSet RsFee=null;
ResultSet rs=null;
String qry1="",mWebEmail="";
int mSNO=0;
int mData=0;
String mMemberID="";
String mMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mmMemberName="";
String mCompanyCode="";
String mAcademicYearCode="";
String mProgramCode="";
String mBranchCode="";
String mCurrentSem="";
int mCurSem=0;
String mMS="";
String mInstituteCode="";
String mMaxSemester="";
String minst="";
String ENROLLMENTNO="",STUDENTNAME="",PROGRAMCODE="",BRANCHCODE="",STEMAILID="";
String CADDRESS1="",CADDRESS2="",CDISTRICT="",CADDRESS3="",CPIN="",CSTATE="" ,PPHONENO="",Date="",mFeeAmountWord="",mFeeAmount="25500";

try
{
if (session.getAttribute("WebAdminEmail")==null)
{
	 mWebEmail="";
}
else
{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
}

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
	mmMemberName=GlobalFunctions.toTtitleCase(mMemberName.trim());
}

if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
}

if (session.getAttribute("CompanyCode")==null)
{
	mCompanyCode="";
}
else
{
	mCompanyCode=session.getAttribute("CompanyCode").toString().trim();
}

if (session.getAttribute("AcademicYearCode")==null)
{
	mAcademicYearCode="";
}
else
{
	mAcademicYearCode=session.getAttribute("AcademicYearCode").toString().trim();
}

if (session.getAttribute("ProgramCode")==null)
{
	mProgramCode="";
}
else
{
	mProgramCode=session.getAttribute("ProgramCode").toString().trim();
}

if (session.getAttribute("BranchCode")==null)
{
	mBranchCode="";
}
else
{
	mBranchCode=session.getAttribute("BranchCode").toString().trim();
}

if (session.getAttribute("CurrentSem")==null)
{
	mCurrentSem="";
}
else
{
	mCurrentSem=session.getAttribute("CurrentSem").toString().trim();
}

if (session.getAttribute("InstituteCode")==null)
{
	mInstituteCode="";
}
else
{
	mInstituteCode=session.getAttribute("InstituteCode").toString().trim();
}

if(mInstituteCode.equalsIgnoreCase("JIIT")){
minst="Jaypee Institute of Information Technology";
}else if(mInstituteCode.equalsIgnoreCase("J128")){
minst="Jaypee Institute of Information Technology,Noida-128";
}else if(mInstituteCode.equalsIgnoreCase("JPBS")){
minst="Jaypee Business School";
}
if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
{
	try
	{
		mDMemberCode=enc.decode(mMemberCode);
		mMemberID=enc.decode(mMemberID);
	}
	catch(Exception e)
	{
		out.println(e.getMessage());
	}

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress=session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level
  //-----------------------------
String acdYear="",quota="",semester="",semestertype="";
String seqqry="Select WEBKIOSK.ShowLink('275','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
  RsChk= db.getRowset(seqqry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
            


%>


<%

           qry="select ACADEMICYEAR,QUOTA,ENROLLMENTNO,STUDENTNAME,PROGRAMCODE,BRANCHCODE from studentmaster where studentid='"+mChkMemID+"'";

            rs = db.getRowset(qry);

            if(rs.next()){
            ENROLLMENTNO=rs.getString("ENROLLMENTNO");
            STUDENTNAME=rs.getString("STUDENTNAME");
            PROGRAMCODE=rs.getString("PROGRAMCODE");
            BRANCHCODE=rs.getString("BRANCHCODE");
            acdYear=rs.getString("ACADEMICYEAR");
            quota=rs.getString("QUOTA");
            }

            qry1="select nvl(CADDRESS1,' ')CADDRESS1, nvl(CADDRESS3,' ')CADDRESS3,nvl(CADDRESS2,' ')CADDRESS2,nvl(CDISTRICT,' ')CDISTRICT,nvl(CSTATE,' ')CSTATE ,nvl(PPHONENO,'0')PPHONENO,nvl(CPIN,'0')CPIN from STUDENTADDRESS where STUDENTID='"+mChkMemID+"'";
            RsFee=db.getRowset(qry1);
            if(RsFee.next()){
            CADDRESS1=RsFee.getString("CADDRESS1");
            CADDRESS2=RsFee.getString("CADDRESS2");
            CADDRESS3=RsFee.getString("CADDRESS3");
            CDISTRICT=RsFee.getString("CDISTRICT");
            CPIN=RsFee.getString("CPIN");
            CSTATE=RsFee.getString("CSTATE");
            PPHONENO=RsFee.getString("PPHONENO");
            }
            

           
            
            String address=CADDRESS1+","+CDISTRICT+","+CSTATE+" "+CPIN;  //CADDRESS1="",CADDRESS2="",CDISTRICT="",CADDRESS3="",CPIN="",CSTATE=""

            qry="select to_char(sysdate,'DD-MM-YYYY')ss from dual";
	    rs=db.getRowset(qry);
	    if(rs.next())
	    {
            Date=rs.getString("ss");
            }

            qry=" select nvl(STEMAILID,'N/A')STEMAILID,nvl(STCELLNO,'N/A')STCELLNO from studentphone where STUDENTID='"+mChkMemID+"'";
	    rs=db.getRowset(qry);
	    if(rs.next())
	    {
            STEMAILID=rs.getString("STEMAILID");
            PPHONENO=rs.getString("STCELLNO");
            }


             
            if(CPIN!=null && CPIN.equalsIgnoreCase("0")){
                CPIN=" ";
            }
            

            String mcurrentreg="";
            String HOSTELALLOW="",HOSTELTYPE="";

            qry = "select semester,regcode,semestertype,nvl(HOSTELALLOW,'N') HOSTELALLOW,nvl(HOSTELTYPE,' ') HOSTELTYPE   from  STUDENTREGISTRATION where semester=  (select MAX (semester) from STUDENTREGISTRATION where studentid='"+mChkMemID+"') and studentid='"+mChkMemID+"'";
            ResultSet rss2 = db.getRowset(qry);
            if (rss2.next()) {
            mcurrentreg = rss2.getString("regcode");
            semester = rss2.getString("semester");
            semestertype = rss2.getString("semestertype");
            HOSTELALLOW = rss2.getString("HOSTELALLOW");
            HOSTELTYPE = rss2.getString("HOSTELTYPE");
            rss2.close();
            }

            qry = "select regcode  from studentregistration where studentid='"+mChkMemID+"'";
            ResultSet rss3 = db.getRowset(qry);
            double mPreviousdues=0.0;
            double mduesamt=0.0;
            double curremtdues=0.0;
            double totdues=0.0;
            while (rss3.next()) {

            String regcode = rss3.getString("regcode");
            if(!regcode.equalsIgnoreCase(mcurrentreg)){
            qry = " select feeDueSem( '"+mCompanyCode+"' ,'"+mChkMemID+"' ,'"+regcode+"')dues from dual ";
            ResultSet rss4 = db.getRowset(qry);
            String duesamt="";
            if(rss4.next()){
            duesamt= rss4.getString("dues");
            }
            if(!duesamt.equalsIgnoreCase("")){
            mduesamt=Double.parseDouble(duesamt);
            mPreviousdues=mduesamt+mPreviousdues;
            }

            }
            }
            
            String consem="";
            qry = "SELECT initcap(common.toword(" + semester + ")) TOWORDS FROM   dual";
            ResultSet rsse = db.getRowset(qry);
            if (rsse.next()) {
            consem = rsse.getString("TOWORDS");
            }
            consem=consem.replace("Only", "");


	          response.setContentType("application/pdf");
                 // response.setContentType("APPLICATION/OCTET-STREAM");
		  response.setHeader("Content-Disposition", "attachment; filename=\""+ "FeeDemand.pdf" + "\"");
                  Document document = new Document();
                  try {
                   PdfWriter.getInstance(document, response.getOutputStream());
                   document.open();

                   PdfPTable table = new PdfPTable(1);
                   table.setWidthPercentage(113);

                    Font bold = new Font(Font.NORMAL, 12, Font.BOLD);
                    Font bold2 = new Font(Font.NORMAL, 11, Font.BOLD);
                    Font normal = new Font(Font.NORMAL, 11, Font.getFamilyIndex("Calibri (Body)"));
                    
                    String basePath="D:/jiitlogo.jpg";

                  //  Image img = Image.getInstance(basePath);

                    Image img = Image.getInstance("/u01/jboss/EAP/standalone" + "/logo_1.JPG");
                    img.scalePercent(65);
                    PdfPCell cell = new PdfPCell();
                    cell.setBorder(0);
                    cell.addElement(new Chunk(img, 10, -35));
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                    cell.setTop(Element.ALIGN_TOP);
                    table.addCell(cell);



                    Chunk chunk6d = new Chunk(minst,bold);
                    Phrase ph6D = new Phrase(chunk6d);
                    PdfPCell celld = new PdfPCell(new Paragraph(ph6D));
                    celld.setHorizontalAlignment(Element.ALIGN_CENTER);
                    celld.setTop(Element.ALIGN_TOP);
                    celld.setBorder(0);

                    table.addCell(celld);

                    Chunk chunk61 = new Chunk("(Declared Deemed to be University u/s 3 of UGC Act 1956)",normal);
                    Phrase ph61 = new Phrase(chunk61);
                    PdfPCell celld1 = new PdfPCell(new Paragraph(ph61));
                    celld1.setHorizontalAlignment(Element.ALIGN_CENTER);
                    celld1.setTop(Element.ALIGN_TOP);
                    celld1.setBorder(0);

                    table.addCell(celld1);

                    Chunk chunk601 = new Chunk("-------------------------------------------------------------------------",normal);
                    Phrase ph601 = new Phrase(chunk601);
                    PdfPCell celld01 = new PdfPCell(new Paragraph(ph601));
                    celld01.setHorizontalAlignment(Element.ALIGN_CENTER);
                    celld01.setTop(Element.ALIGN_TOP);
                    celld01.setBorder(0);
                    celld01.setColspan(4);
                    table.addCell(celld01);


                    PdfPTable personaltable = new PdfPTable(4);
                    personaltable.setWidthPercentage(95);

                    Chunk chunk62 = new Chunk("     Name ",normal);
                    Phrase ph62 = new Phrase(chunk62);
                    PdfPCell celld2 = new PdfPCell(new Paragraph(ph62));
                    celld2.setHorizontalAlignment(Element.ALIGN_LEFT);
                    celld2.setTop(Element.ALIGN_TOP);
                    celld2.setBorder(0);
                    personaltable.addCell(celld2);



                    Chunk chunk63 = new Chunk(STUDENTNAME,bold);
                    Phrase ph63 = new Phrase(chunk63);
                    PdfPCell celld3 = new PdfPCell(new Paragraph(ph63));
                    celld3.setHorizontalAlignment(Element.ALIGN_LEFT);
                    celld3.setTop(Element.ALIGN_TOP);
                    celld3.setBorder(0);
                    personaltable.addCell(celld3);


                    Chunk chunk64 = new Chunk("     Enrol No. ",normal);
                    Phrase ph64 = new Phrase(chunk64);
                    PdfPCell celld4 = new PdfPCell(new Paragraph(ph64));
                    celld4.setHorizontalAlignment(Element.ALIGN_LEFT);
                    celld4.setTop(Element.ALIGN_TOP);
                    celld4.setBorder(0);
                    personaltable.addCell(celld4);

                    


                    Chunk chunk65 = new Chunk(ENROLLMENTNO,bold);
                    Phrase ph65 = new Phrase(chunk65);
                    PdfPCell celld5 = new PdfPCell(new Paragraph(ph65));
                    celld5.setHorizontalAlignment(Element.ALIGN_LEFT);
                    celld5.setTop(Element.ALIGN_TOP);
                    celld5.setBorder(0);
                    personaltable.addCell(celld5);

                    Chunk chunk608 = new Chunk("     Address ",normal);
                    Phrase ph608 = new Phrase(chunk608);
                    PdfPCell celld08 = new PdfPCell(new Paragraph(ph608));
                    celld08.setHorizontalAlignment(Element.ALIGN_LEFT);
                    celld08.setTop(Element.ALIGN_TOP);
                    celld08.setBorder(0);
                    personaltable.addCell(celld08);

                    Chunk chunk609 = new Chunk(address,bold);
                    Phrase ph609 = new Phrase(chunk609);
                    PdfPCell celld09 = new PdfPCell(new Paragraph(ph609));
                    celld09.setHorizontalAlignment(Element.ALIGN_LEFT);
                    celld09.setTop(Element.ALIGN_TOP);
                    celld09.setBorder(0);
                    celld09.setColspan(3);
                    personaltable.addCell(celld09);


                     Chunk chunk66 = new Chunk("     Program ",normal);
                    Phrase ph66 = new Phrase(chunk66);
                    PdfPCell celld6 = new PdfPCell(new Paragraph(ph66));
                    celld6.setHorizontalAlignment(Element.ALIGN_LEFT);
                    celld6.setTop(Element.ALIGN_TOP);
                    celld6.setBorder(0);
                    personaltable.addCell(celld6);



                    Chunk chunk67 = new Chunk(PROGRAMCODE,bold);
                    Phrase ph67 = new Phrase(chunk67);
                    PdfPCell celld7 = new PdfPCell(new Paragraph(ph67));
                    celld7.setHorizontalAlignment(Element.ALIGN_LEFT);
                    celld7.setTop(Element.ALIGN_TOP);
                    celld7.setBorder(0);
                    personaltable.addCell(celld7);


                    Chunk chunk68 = new Chunk("     Branch ",normal);
                    Phrase ph68 = new Phrase(chunk68);
                    PdfPCell celld8 = new PdfPCell(new Paragraph(ph68));
                    celld8.setHorizontalAlignment(Element.ALIGN_LEFT);
                    celld8.setTop(Element.ALIGN_TOP);
                    celld8.setBorder(0);
                    personaltable.addCell(celld8);

                    Chunk chunk69 = new Chunk(BRANCHCODE,bold);
                    Phrase ph69 = new Phrase(chunk69);
                    PdfPCell celld9 = new PdfPCell(new Paragraph(ph69));
                    celld9.setHorizontalAlignment(Element.ALIGN_LEFT);
                    celld9.setTop(Element.ALIGN_TOP);
                    celld9.setBorder(0);
                    personaltable.addCell(celld9);

                    Chunk chunk618 = new Chunk("     Contact No. ",normal);
                    Phrase ph618 = new Phrase(chunk618);
                    PdfPCell celld18 = new PdfPCell(new Paragraph(ph618));
                    celld18.setHorizontalAlignment(Element.ALIGN_LEFT);
                    celld18.setTop(Element.ALIGN_TOP);
                    celld18.setBorder(0);
                    personaltable.addCell(celld18);

                    Chunk chunk619 = new Chunk(PPHONENO,bold);
                    Phrase ph619 = new Phrase(chunk619);
                    PdfPCell celld19 = new PdfPCell(new Paragraph(ph619));
                    celld19.setHorizontalAlignment(Element.ALIGN_LEFT);
                    celld19.setTop(Element.ALIGN_TOP);
                    celld19.setBorder(0);
                    personaltable.addCell(celld19);

                    Chunk chunk628 = new Chunk("     Email ID ",normal);
                    Phrase ph628 = new Phrase(chunk628);
                    PdfPCell celld28 = new PdfPCell(new Paragraph(ph628));
                    celld28.setHorizontalAlignment(Element.ALIGN_LEFT);
                    celld28.setTop(Element.ALIGN_TOP);
                    celld28.setBorder(0);
                    personaltable.addCell(celld28);

                    Chunk chunk639 = new Chunk(STEMAILID,bold);
                    Phrase ph639 = new Phrase(chunk639);
                    PdfPCell celld29 = new PdfPCell(new Paragraph(ph639));
                    celld29.setHorizontalAlignment(Element.ALIGN_LEFT);
                    celld29.setTop(Element.ALIGN_TOP);
                    celld29.setBorder(0);
                    personaltable.addCell(celld29);

                    Chunk chunk6128 = new Chunk("     Date ",normal);
                    Phrase ph6128 = new Phrase(chunk6128);
                    PdfPCell celld128 = new PdfPCell(new Paragraph(ph6128));
                    celld128.setHorizontalAlignment(Element.ALIGN_LEFT);
                    celld128.setTop(Element.ALIGN_TOP);
                    celld128.setBorder(0);
                    personaltable.addCell(celld128);

                    Chunk chunk6139 = new Chunk(Date,bold);
                    Phrase ph6139 = new Phrase(chunk6139);
                    PdfPCell celld129 = new PdfPCell(new Paragraph(ph6139));
                    celld129.setHorizontalAlignment(Element.ALIGN_LEFT);
                    celld129.setTop(Element.ALIGN_TOP);
                    celld129.setBorder(0);
                    celld129.setColspan(3);
                    personaltable.addCell(celld129);

                    Chunk chunk61139 = new Chunk("                                                 ",normal);
                    Phrase ph61139 = new Phrase(chunk61139);
                    PdfPCell celld1129 = new PdfPCell(new Paragraph(ph61139));
                    celld1129.setHorizontalAlignment(Element.ALIGN_LEFT);
                    celld1129.setTop(Element.ALIGN_TOP);
                    celld1129.setBorder(0);
                    celld1129.setColspan(4);
                    personaltable.addCell(celld1129);

                    Chunk chunk6239 = new Chunk("     Dear Student "+ "\n"+"     Please find below the details of Amount/fees due for semester"+consem+"",normal);
                    Phrase ph6239 = new Phrase(chunk6239);
                    PdfPCell celld2129 = new PdfPCell(new Paragraph(ph6239));
                    celld2129.setHorizontalAlignment(Element.ALIGN_LEFT);
                    celld2129.setTop(Element.ALIGN_TOP);
                    celld2129.setBorder(0);
                    celld2129.setColspan(4);
                    personaltable.addCell(celld2129);

                    PdfPTable datatable = new PdfPTable(1);
                    datatable.setWidthPercentage(84);

                    String  query = " Select s.CollSeqID,g.CurrencyCode,g.FeeHead, g.PostingCompany PostingCompany,g.GlID,g.FeeAmount, 'Academic Year Wise' FeeSource,Null Feetype  From FeeStructure g ,FeeHeads s "
    +"  Where g.InstituteCode= '"+mInstituteCode+"' And g.CompanyCode    =     '"+mCompanyCode+"'     And    g.Quota    =   '"+quota+"'   And g.AcademicYear=  '"+acdYear+"'       And    g.ProgramCode= '"+PROGRAMCODE+"'   And    "
   +" g.BranchCode=   '"+BRANCHCODE+"'   And g.Semester=  '"+semester+"'  And    g.SemesterType=  '"+semestertype+"'   And Nvl(g.FeeAmount,0)> 0   And s.FeeHead=    g.FeeHead and s.InstituteCode=g.InstituteCode "
   +"  and s.CompanyCode=g.CompanyCode And g.Feehead Not in( Select f.Feehead From Feeheads f Where f.InstituteCode = '"+mInstituteCode+"' And f.CompanyCode =     '"+mCompanyCode+"'     And FeeType = 'H' And '"+HOSTELALLOW+"' = 'N')   "
   +" And    Not Exists ( Select  Null  From  FeeStructureIndividual FSI1 Where  fsi1.InstituteCode    = '"+mInstituteCode+"' And fsi1.CompanyCode    =     '"+mCompanyCode+"'       And fsi1.StudentID    =  '"+mChkMemID+"' And fsi1.AcademicYear =   '"+acdYear+"'    "
   +"   And     fsi1.ProgramCode= '"+PROGRAMCODE+"'      And    fsi1.BranchCode    =   '"+BRANCHCODE+"'     And Nvl(fsi1.Deactive,'N')= 'N' And fsi1.RegCode     = '"+mcurrentreg+"'     And     fsi1.Semester = g.Semester    And  "
   +"    fsi1.SemesterType= g.SemesterType And fsi1.FeeHead= g.FeeHead)   And    Not Exists ( Select  Null  From  FeeStructureCriteria FSC1 Where  FSC1.InstituteCode    = '"+mInstituteCode+"'  "
   +"  And FSC1.CompanyCode    =     '"+mCompanyCode+"'       And FSC1.AcademicYear =   '"+acdYear+"'        And     FSC1.ProgramCode= '"+PROGRAMCODE+"'      And    FSC1.BranchCode    =   '"+BRANCHCODE+"'     "
   +"  And FSC1.Semester = g.Semester    And    FSC1.SemesterType= g.SemesterType And FSC1.FeeHead= g.FeeHead  And FSC1.Quota= g.Quota    And    "
   +"     (FSC1.Operator IN ('IN','=') And FSC1.CriteriaValue = '"+HOSTELTYPE+"'))    Union All    Select        s.CollSeqID,fc.CurrencyCode,fc.FeeHead,fc.PostingCompany PostingCompany ,fc.GlID,  "
   +"   fc.FeeAmount, 'Academic Year Wise' FeeSource,Null Feetype    From FeeStructureCriteria fc ,FeeHeads s Where fc.InstituteCode    = '"+mInstituteCode+"' and fc.CompanyCode    =     '"+mCompanyCode+"'     "
   +"  and fc.Quota=   '"+quota+"'   And    fc.AcademicYear    =   '"+acdYear+"'        And    fc.ProgramCode    = '"+PROGRAMCODE+"'   And    fc.BranchCode=   '"+BRANCHCODE+"'   And    fc.Semester=  '"+semester+"'  And    "
   +" fc.SemesterType=   '"+semestertype+"'  AND    NVL(fc.FeeAmount,0) >0    And    (fc.Operator In ('IN','=') And fc.CriteriaValue = '"+HOSTELTYPE+"') And s.FeeHead=fc.FeeHead    And   "
   +"  s.InstituteCode    = fc.InstituteCode   And    fc.Feehead Not in( Select f.Feehead From Feeheads f Where f.InstituteCode = '"+mInstituteCode+"'    And f.CompanyCode =     '"+mCompanyCode+"'     "
   +" And FeeType = 'H' And '"+HOSTELALLOW+"' = 'N')    And    Not Exists ( Select  Null  From FeeStructureIndividual FSI1    Where  fsi1.InstituteCode='"+mInstituteCode+"' And fsi1.CompanyCode=     '"+mCompanyCode+"'      "
   +"  And    fsi1.StudentID=  '"+mChkMemID+"'    And    fsi1.AcademicYear=   '"+acdYear+"'     And fsi1.ProgramCode= '"+PROGRAMCODE+"'      And    fsi1.BranchCode    =   '"+BRANCHCODE+"'   And    Nvl(fsi1.Deactive,'N')= 'N'   "
   +"   And    fsi1.RegCode = '"+mcurrentreg+"'     And    fsi1.Semester= fc.Semester    And         fsi1.SemesterType= fc.SemesterType    And fsi1.FeeHead= fc.FeeHead)   Union All    "
   +"    Select  s.CollSeqID,I.CurrencyCode,I.FeeHead, I.PostingCompany PostingCompany ,I.GlID,FeeAmount, 'Individual' FeeSource,Null Feetype     "
   +"    From FeeStructureIndividual I,FeeHeads s Where    I.InstituteCode='"+mInstituteCode+"' And I.CompanyCode=     '"+mCompanyCode+"'     And    I.StudentID    =  '"+mChkMemID+"' And I.AcademicYear    =  '"+acdYear+"'        "
   +"     and    I.ProgramCode= '"+PROGRAMCODE+"'   And    I.BranchCode =  '"+BRANCHCODE+"'   And Nvl(I.Deactive,'N')= 'N' And    I.RegCode ='"+mcurrentreg+"' And    I.Semester    =  '"+semester+"'  And I.SemesterType=  '"+semestertype+"'     "
   +"       And s.FeeHEad  = I.FeeHEad And  s.InstituteCode     = I.InstituteCode      And    I.Feehead Not in( Select f.Feehead From Feeheads f Where f.InstituteCode = '"+mInstituteCode+"'  "
   +"     and f.CompanyCode =     '"+mCompanyCode+"'     And f.FeeType = 'H'       And '"+HOSTELALLOW+"' = 'N')    Order By     1 ";


    PdfPTable desctable = new PdfPTable(2);
    desctable.setWidthPercentage(84);
    desctable.getDefaultCell().setBorder(PdfPCell.NO_BORDER);
    desctable.setTotalWidth(new float[]{ 316, 72 });
  //  desctable.set
    desctable.setLockedWidth(true);
     desctable.setSpacingAfter(2f);
  //  System.out.println(query);
    ResultSet rss6 = db.getRowset(query);
    String totfees="",tutionFeeamount="",feehead="",amt="",FEEHEADDESC="";
    Double feeheaddues=0.0,headamt=0.0;
    DecimalFormat df=new DecimalFormat("00.00");
    while(rss6.next()){
        int i=0;
        feehead=rss6.getString("FeeHead");
        amt=rss6.getString("FeeAmount");

         if(!feehead.equalsIgnoreCase("")){
         qry="select FEEHEADDESC from FEEHEADS where INSTITUTECODE='"+mInstituteCode+"'  and FEEHEAD='"+feehead+"' ";
         ResultSet rss7 = db.getRowset(qry);
         if(rss7.next()){
         FEEHEADDESC=rss7.getString("FEEHEADDESC");
         }
          qry="select feedues('"+mInstituteCode+"',     '"+mCompanyCode+"'     , '"+mChkMemID+"' ,  '"+semester+"'  ,  '"+semestertype+"'  , '"+mcurrentreg+"' , 'Y' , '"+feehead+"','"+amt+"','INR' )  dues from dual  ";
         ResultSet rss8 = db.getRowset(qry);
         if(rss8.next()){
         tutionFeeamount=rss8.getString("dues");
         }
         if(!tutionFeeamount.equalsIgnoreCase("")&&tutionFeeamount.equalsIgnoreCase("0.00")){
         tutionFeeamount="00";
         }
        

         headamt=Double.parseDouble(tutionFeeamount);
         tutionFeeamount=df.format(headamt);
         feeheaddues=headamt+feeheaddues;

         }
         Chunk chunk62391 = new Chunk(FEEHEADDESC,normal);
         desctable.addCell(new Phrase(chunk62391));
         
        PdfPCell pcell = new PdfPCell(new Paragraph(tutionFeeamount, normal));
        pcell.setHorizontalAlignment(Element.ALIGN_RIGHT);
        pcell.setBorder(0);
        desctable.addCell(pcell);
    
                   
        }// END OF WHILE

         String mpvrdu="",totdues2="";



         mpvrdu=df.format(mPreviousdues);

         if(!mpvrdu.equalsIgnoreCase("")&&mpvrdu.equalsIgnoreCase("0.00")){
         mpvrdu="00";
         }

         Chunk chunk623 = new Chunk("Fines / Other Dues",normal);
         desctable.addCell(new Phrase(chunk623));
         PdfPCell pcell2 = new PdfPCell(new Paragraph(mpvrdu, normal));
         pcell2.setHorizontalAlignment(Element.ALIGN_RIGHT);
         pcell2.setBorder(0);
         desctable.addCell((pcell2));

            double totaldues=0.0;
            totaldues=mPreviousdues+feeheaddues;
            qry = "SELECT initcap(common.toword(" + totaldues + ")) TOWORDS FROM   dual";
            ResultSet rss = db.getRowset(qry);
            if (rss.next()) {
            mFeeAmountWord = rss.getString("TOWORDS");
            }
       // DecimalFormat df2 = new DecimalFormat("#.##");
        
        // totaldues=df.format(totaldues);
         //totdues2=Double.toString(totaldues);
            Chunk chunk643911 = new Chunk("----------------------------------------------",normal);
            Phrase ph643911 = new Phrase(chunk643911);
            PdfPCell celld412933 = new PdfPCell(new Paragraph(ph643911));
            celld412933.setHorizontalAlignment(Element.ALIGN_LEFT);
            celld412933.setTop(Element.ALIGN_TOP);
            celld412933.setBorder(0);
            desctable.addCell(celld412933);

            Chunk chunk6439113 = new Chunk("---------",normal);
            Phrase ph6439113 = new Phrase(chunk6439113);
            PdfPCell celld4129333 = new PdfPCell(new Paragraph(ph6439113));
            celld4129333.setHorizontalAlignment(Element.ALIGN_LEFT);
            celld4129333.setTop(Element.ALIGN_TOP);
            celld4129333.setBorder(0);
            desctable.addCell(celld4129333);


         if(!totdues2.equalsIgnoreCase("")&&totdues2.equalsIgnoreCase("0.00")){
         totdues2="00";
         }
            
         totdues2 = df.format(totaldues);
         Chunk chunk62312 = new Chunk("Total Dues",bold);
         desctable.addCell(new Phrase(chunk62312));
        
         PdfPCell pcell3 = new PdfPCell(new Paragraph(totdues2, bold));
         pcell3.setHorizontalAlignment(Element.ALIGN_RIGHT);
         pcell3.setBorder(0);
         desctable.addCell(pcell3);


         PdfPTable datatable2 = new PdfPTable(1);
         datatable2.setWidthPercentage(84);
         datatable2.setSpacingBefore(5f);

         //Chunk chunk6439 = new Chunk("Please pay the total dues, a sum of Rs. "+totdues2+"("+mFeeAmountWord+  "), latest by the date of registration as per academic calendar, through online / credit-debit card / Demand Draft." +"\n"+"Cash payment is not accepted. Any discrepancy in the above may please be brought to the notice of JIIT Finance Department. ",normal);
         //Phrase ph6439 = new Phrase(chunk6439);

            Chunk chunkdata112 = new Chunk("Please pay the total dues,a sum of Rs.",normal);
            Chunk chunkdata1321 = new Chunk(totdues2,bold);
             Chunk chunkdata132101 = new Chunk("(",normal);
            Chunk chunkdata132133 = new Chunk(mFeeAmountWord,bold);
            Chunk chunkdata13210 = new Chunk("),latest by the date of registration as per academic calendar, through online / credit-debit card / Demand Draft." +"\n"+"Cash payment is not accepted. Any discrepancy in the above may please be brought to the notice of JIIT Finance Department. ",normal);
           

            Paragraph p4 = new Paragraph();
            p4.add(chunkdata112);
            p4.add(chunkdata1321);
            p4.add(chunkdata132101);
            p4.add(chunkdata132133);
            p4.add(chunkdata13210);
            PdfPCell celld4129 = new PdfPCell(new Paragraph(p4));
            celld4129.setHorizontalAlignment(Element.ALIGN_LEFT);
            celld4129.setTop(Element.ALIGN_TOP);
            celld4129.setBorder(0);
            //celld129.setColspan(3);
            datatable2.addCell(celld4129);


            PdfPTable datatable31 = new PdfPTable(1);
            datatable31.setWidthPercentage(84);

            Chunk chunk62439 = new Chunk("Registrar ",bold);
            Phrase ph62439 = new Phrase(chunk62439);
            PdfPCell celld42129 = new PdfPCell(new Paragraph(ph62439));
            celld42129.setHorizontalAlignment(Element.ALIGN_LEFT);
            celld42129.setTop(Element.ALIGN_TOP);
            celld42129.setBorder(0);
            //celld129.setColspan(3);
            datatable31.addCell(celld42129);

            Chunk chunk6243 = new Chunk("This is a computer generated printout and no signature is required. ",normal);
            Phrase ph6243 = new Phrase(chunk6243);
            PdfPCell celld4212 = new PdfPCell(new Paragraph(ph6243));
            celld4212.setHorizontalAlignment(Element.ALIGN_LEFT);
            celld4212.setTop(Element.ALIGN_TOP);
            celld4212.setBorder(0);
            //celld129.setColspan(3);
            datatable31.addCell(celld4212);
            datatable31.setSpacingAfter(1f);

          /*  Chunk chunk6339 = new Chunk(" ",normal);
            Phrase ph6339 = new Phrase(chunk6339);
            PdfPCell celld2329 = new PdfPCell(new Paragraph(ph6339));
            celld2329.setHorizontalAlignment(Element.ALIGN_LEFT);
            celld2329.setTop(Element.ALIGN_TOP);
            celld2329.setBorder(0);
            celld2329.setColspan(4);
            personaltable.addCell(celld2329);*/




            PdfPTable datatable3 = new PdfPTable(2);
            datatable3.setWidthPercentage(84);
            datatable3.setWidths(new float[] { 1, 3 });
            datatable3.setSpacingBefore(5f);

            Chunk chunkdata = new Chunk("Fee Payment Options ",bold);
            Phrase pharsedata = new Phrase(chunkdata);
            PdfPCell celldata = new PdfPCell(new Paragraph(pharsedata));
            celldata.setHorizontalAlignment(Element.ALIGN_LEFT);
            celldata.setTop(Element.ALIGN_TOP);
            celldata.setBorder(0);
           // celldata.set
            datatable3.addCell(celldata);

            Chunk chunkdata1 = new Chunk("1. Online - through payment gateway available on webkiosk the student portal of JIIT.",normal);
            Phrase pharsedata1 = new Phrase(chunkdata1);
            PdfPCell celldata1 = new PdfPCell(new Paragraph(pharsedata1));
            celldata1.setHorizontalAlignment(Element.ALIGN_LEFT);
            celldata1.setTop(Element.ALIGN_TOP);
            celldata1.setBorder(0);
           // celldata.set
            datatable3.addCell(celldata1);

            Chunk chunkdata12 = new Chunk("",normal);
            Phrase pharsedata12 = new Phrase(chunkdata12);
            PdfPCell celldata12 = new PdfPCell(new Paragraph(pharsedata12));
            celldata12.setHorizontalAlignment(Element.ALIGN_LEFT);
            celldata12.setTop(Element.ALIGN_TOP);
            celldata12.setBorder(0);
           // celldata.set
            datatable3.addCell(celldata12);




            Chunk chunkdata2 = new Chunk("2. Demand Draft drawn in favour of",normal);
            Chunk chunkdata321 = new Chunk(""+" 'Jaypee Institute of Information Technology '",bold);
            Chunk chunkdata32133 = new Chunk(""+"payable at ",normal);
            Chunk chunkdata3210 = new Chunk(" Noida/Delhi.",bold);
            Chunk chunkdata32101 = new Chunk("Please mention your enrolment No. and name on the back side of DD.",normal);
            Paragraph p = new Paragraph();
            p.add(chunkdata2);
            p.add(chunkdata321);
            p.add(chunkdata32133);
            p.add(chunkdata3210);
            p.add(chunkdata32101);
            PdfPCell celldata2 = new PdfPCell(new Paragraph(p));
            celldata2.setHorizontalAlignment(Element.ALIGN_LEFT);
            celldata2.setTop(Element.ALIGN_TOP);
            celldata2.setBorder(0);
           // celldata.set
            datatable3.addCell(celldata2);

            Chunk chunkdata121 = new Chunk("",normal);
            Phrase pharsedata121 = new Phrase(chunkdata121);
            PdfPCell celldata121 = new PdfPCell(new Paragraph(pharsedata121));
            celldata121.setHorizontalAlignment(Element.ALIGN_LEFT);
            celldata121.setTop(Element.ALIGN_TOP);
            celldata121.setBorder(0);
           // celldata.set
            datatable3.addCell(celldata121);

            Chunk chunkdata22 = new Chunk("3. Demand Draft shall be received at Accounts & Finance Department of JIIT,Noida only.",normal);
            Phrase pharsedata22 = new Phrase(chunkdata22);
            PdfPCell celldata22 = new PdfPCell(new Paragraph(pharsedata22));
            celldata22.setHorizontalAlignment(Element.ALIGN_LEFT);
            celldata22.setTop(Element.ALIGN_TOP);
            celldata22.setBorder(0);
           // celldata.set
            datatable3.addCell(celldata22);








          document.add(table);
          document.add(new Phrase("\n"));
          document.add(personaltable);
        //  document.add(new Phrase("\n"));
          document.add(datatable);

          document.add(desctable);
         // document.add(new Phrase(" "));
           document.add(datatable31);
        //  document.add(new Phrase(" "));
          document.add(datatable2);

          document.add(datatable3);
           document.add(new Phrase("\n"));
            document.add(new Phrase("\n"));
                    document.add(new Phrase("\n"));
                    document.add(new Phrase("\n"));
                     Paragraph p2 = new Paragraph();
                    p2.add("                                                                      --------------               ");
                     document.add(p2);
                  
                   document.close();
                 }
                 catch(Exception e){
                 e.printStackTrace();
                 }




 }
  else
   {
   %>
	<br>
	<font color=red>
	<h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team.
	<br>	<br>	<br>	<br>
   <%
	}
}
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}
}
catch(Exception e)
{
System.out.println(e);
}
%>

</body>
</html>
