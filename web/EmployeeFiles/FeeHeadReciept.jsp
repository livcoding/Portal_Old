<%--
    Document   : NaFeeHeadReciept
    Created on : 31 Jul, 2020, 4:47:28 PM
    Author     : power.jiit
--%>
<%@page import="javax.servlet.*,javax.servlet.http.*,java.io.*,java.util.*,com.lowagie.text.pdf.*, com.lowagie.text.*,java.awt.Color.*"%>
<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%





            String mHead = "", mCompCode = "";
            String mCandCode = "", MName = "";
            String mCandName = "", mInst = "", mInstName = "", mInstAddress = "", mFeeheadDate = "", mVoucherEntryDate = "", mVoucherNo = "";
            String mFeeHeads = "";
            String mHeadDesc = "", mStudentName = "", mACADEMICYEAR = "", mPROGRAMCODE = "", mBRANCHCODE = "", mSEMESTER = "", mEnrollMentNo = "", mFeeAmount = "", mFeeRate = "";

//231
            String mInstituteCode = "", mPRNO = "", mChkMemID = "", Shortdesc1 = "", PRDATE = "", mFeeAmountWord = "", qry2 = "";
            if (session.getAttribute("PageHeading") != null && !session.getAttribute("PageHeading").equals("")) {
                mHead = session.getAttribute("PageHeading").toString().trim();
            } else {
                mHead = "JIIT ";
            }




%>
<html>
    <head>
        <title>#### <%=mHead%> [ View Academic Fee detail  ] </title>

    </head>

    <%

            response.setContentType("application/pdf");
            DBHandler db = new DBHandler();
            String mMemberID = "", mMemberType = "", mMemberName = "", mMemberCode = "";
            String qry = "", qry1 = "", x = "", mFeeHeadQty = "";
            int msno = 0;
            ResultSet rs = null, rs1 = null, rs2 = null;

            if (session.getAttribute("MemberID") == null) {
                mMemberID = "";
            } else {
                mMemberID = session.getAttribute("MemberID").toString().trim();
            }

            if (session.getAttribute("MemberType") == null) {
                mMemberType = "";
            } else {
                mMemberType = session.getAttribute("MemberType").toString().trim();
            }

            if (session.getAttribute("MemberName") == null) {
                mMemberName = "";
            } else {
                mMemberName = session.getAttribute("MemberName").toString().trim();
            }

            if (session.getAttribute("MemberCode") == null) {
                mMemberCode = "";
            } else {
                mMemberCode = session.getAttribute("MemberCode").toString().trim();
            }

            if (session.getAttribute("CompanyCode") == null) {
                mCompCode = "JIIT";
            } else {
                mCompCode = session.getAttribute("CompanyCode").toString().trim();
            }

            if (session.getAttribute("mStudentName") == null) {
                mStudentName = "";
            } else {
                mStudentName = session.getAttribute("mStudentName").toString().trim();
            }
            if (session.getAttribute("mACADEMICYEAR") == null) {
                mACADEMICYEAR = "";
            } else {
                mACADEMICYEAR = session.getAttribute("mACADEMICYEAR").toString().trim();
            }
            if (session.getAttribute("mPROGRAMCODE") == null) {
                mPROGRAMCODE = "";
            } else {
                mPROGRAMCODE = session.getAttribute("mPROGRAMCODE").toString().trim();
            }
            if (session.getAttribute("mBRANCHCODE") == null) {
                mBRANCHCODE = "";
            } else {
                mBRANCHCODE = session.getAttribute("mBRANCHCODE").toString().trim();
            }
            if (session.getAttribute("mSEMESTER") == null) {
                mSEMESTER = "";
            } else {
                mSEMESTER = session.getAttribute("mSEMESTER").toString().trim();
            }

            if (session.getAttribute("mEnrollMentNo") == null) {
                mEnrollMentNo = "";
            } else {
                mEnrollMentNo = session.getAttribute("mEnrollMentNo").toString().trim();
            }
            if (session.getAttribute("InstituteCode") == null) {
                mInst = "";
            } else {
                mInst = session.getAttribute("InstituteCode").toString().trim();
            }
if (session.getAttribute("mStudentName")==null)
{
	mStudentName="";
}
else
{
	mStudentName=session.getAttribute("mStudentName").toString().trim();
}



            qry1 = "select a.INSTITUTECODE,a.INSTITUTENAME, a.CITY  aaa " +
                    " from institutemaster a where a.institutecode='" + mInst + "' ";


            rs1 = db.getRowset(qry1);
            if (rs1.next()) {
                mInstName = rs1.getString("INSTITUTENAME");
                mInstAddress = rs1.getString("aaa");
            }

            //---------------   PDF -------------
            //    Document document = new Document();
            try {
                Document document = new Document();
                response.setContentType("application/pdf");
                PdfWriter.getInstance(document, response.getOutputStream());
                document.open();

                PdfPTable table = new PdfPTable(4);
                table.setWidthPercentage(113);
                // document.add(new Paragraph("Report in Itext"));

                PdfPCell cell = new PdfPCell();
                cell.setBorder(0);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                cell.setTop(Element.ALIGN_TOP);
                table.addCell(cell);
                Font font12c = new Font(Font.NORMAL, 12, Font.BOLD);
                Chunk chunk6d = new Chunk(mInstName + "\n                   " + mInstAddress, font12c);
                Phrase ph6D = new Phrase(chunk6d);
                PdfPCell celld = new PdfPCell(new Paragraph(ph6D));

                celld.setColspan(3);
                celld.setBorder(0);
                //celld.setFixedHeight(50);
                celld.setHorizontalAlignment(Element.ALIGN_LEFT);
                celld.setTop(Element.ALIGN_TOP);
                //pdfHCell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(celld);


                Font font12 = new Font(Font.BOLD, 11, Font.BOLD);
                Chunk chunkcd = new Chunk("                                                     Fee Receipt ", font12);
                Phrase phrasecd = new Phrase();
                phrasecd.add(chunkcd);

                PdfPCell cell5d = new PdfPCell(phrasecd);
                cell5d.setBorder(0);
                cell5d.setColspan(3);
                cell5d.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell5d);

                Font font1 = new Font(Font.NORMAL, 10, Font.BOLD);
               

                Chunk chunkx = new Chunk("      ", font12);
                Phrase phrasex = new Phrase();
                phrasex.add(chunkx);
                PdfPCell cellx = new PdfPCell(phrasex);
                cellx.setColspan(4);
                cellx.setBorder(0);
                table.addCell(cellx);

                Chunk chunka = new Chunk(" Name : " + mStudentName + "\n Enrollment No  : " + mEnrollMentNo + "\n Program : " + mPROGRAMCODE + "\n Semester :" + mSEMESTER, font1);
                Phrase phrasea = new Phrase();
                phrasea.add(chunka);

                PdfPCell cell12 = new PdfPCell(phrasea);
                cell12.setColspan(2);
                cell12.setPadding(4);
                cell12.setHorizontalAlignment(Element.ALIGN_LEFT);
                table.addCell(cell12);

                qry1 = "select Feeheads,to_char(FeeheadDate,'dd-mm-yyyy') FeeheadDate,FEEHEADRATE,feeheadQty,Amount,to_char(VOUCHERENTRYDATE,'dd-mm-yyyy') VOUCHERENTRYDATE,VOUCHERNO from NA#STUDENTFeedetail where  institutecode='" + mInst + "' and  vouchercode is NOT null and feeheads='" + session.getAttribute("FEEHEADS") + "' and studentid='" + session.getAttribute("mStudentId").toString().trim() + "' order by FeeheadDate desc";
               
                rs = db.getRowset(qry1);
                while (rs.next()) {
                    msno++;
                    mFeeHeadQty = rs.getString("feeheadQty");
                    mFeeheadDate = rs.getString("FeeheadDate");
                    mFeeAmount = rs.getString("Amount");
                    mFeeRate = rs.getString("FEEHEADRATE");
                    mVoucherEntryDate = rs.getString("VOUCHERENTRYDATE");
                    mVoucherNo = rs.getString("VOUCHERNO");

                }

                Chunk chunkf = new Chunk(" Academic Year : " + mACADEMICYEAR + "\n Branch  : " + mBRANCHCODE + "\n   ", font1);
                Phrase phrasef = new Phrase();
                phrasef.add(chunkf);

                PdfPCell cellf = new PdfPCell(phrasef);
                cellf.setColspan(2);
                cellf.setPadding(4);
                cellf.setHorizontalAlignment(Element.ALIGN_LEFT);
                table.addCell(cellf);


                //student
                Chunk chunkcS = new Chunk("Student Copy", font1);
                Phrase phrasecS = new Phrase();
                phrasecS.add(chunkcS);
                PdfPCell cell1S = new PdfPCell(phrasecS);
                cell1S.setColspan(1);
                cell1S.setBorder(0);
                cell1S.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell1S);
                // table pdf

                PdfPTable tablee = new PdfPTable(6);
                PdfPCell Date = new PdfPCell(new Phrase("Date"));
                tablee.addCell(Date);

                PdfPCell Qty = new PdfPCell(new Phrase("Qty"));
                tablee.addCell(Qty);

                PdfPCell Rate = new PdfPCell(new Phrase("Rate"));
                tablee.addCell(Rate);

                PdfPCell Amount = new PdfPCell(new Phrase("Amount"));
                tablee.addCell(Amount);

                PdfPCell Voucherentry = new PdfPCell(new Phrase("Voucher Entry Date"));
                tablee.addCell(Voucherentry);

                PdfPCell Vouchernumber = new PdfPCell(new Phrase("Voucher Number"));
                tablee.addCell(Vouchernumber);

                rs = db.getRowset(qry1);
                while (rs.next()) {
                    msno++;
                    mFeeHeadQty = rs.getString("feeheadQty");
                    mFeeheadDate = rs.getString("FeeheadDate");
                    mFeeAmount = rs.getString("Amount");
                    mFeeRate = rs.getString("FEEHEADRATE");
                    mVoucherEntryDate = rs.getString("VOUCHERENTRYDATE");
                    mVoucherNo = rs.getString("VOUCHERNO");
                    //table DATA
                    Chunk chunkk = new Chunk(mFeeheadDate + "\n", font1);
                    Phrase p3 = new Phrase(chunkk);
                    PdfPCell f1 = new PdfPCell(p3);


                    //  f1.setBackgroundColor(BaseColor.PINK);
                    tablee.addCell(f1);
                    Chunk chh = new Chunk(mFeeHeadQty + "\n", font1);
                    Phrase p4 = new Phrase(chh);
                    PdfPCell f2 = new PdfPCell(p4);
                    // f2.setBackgroundColor(BaseColor.MAGENTA);
                    tablee.addCell(f2);
                    Chunk ch11 = new Chunk(mFeeRate + "\n", font1);
                    Phrase p5 = new Phrase(ch11);
                    PdfPCell f3 = new PdfPCell(p5);
                    //   f3.setBackgroundColor(BaseColor.ORANGE);


                    tablee.addCell(f3);
                    Chunk ch01 = new Chunk(mFeeAmount + "\n", font1);
                    Phrase p9 = new Phrase(ch01);
                    PdfPCell f05 = new PdfPCell(p9);

                    tablee.addCell(f05);
                    Chunk ch12 = new Chunk(mVoucherEntryDate + "\n", font1);
                    Phrase p6 = new Phrase(ch12);
                    PdfPCell f4 = new PdfPCell(p6);
                    //   f4.setBackgroundColor(BaseColor.DARK_GRAY);
                    tablee.addCell(f4);
                    Chunk ch13 = new Chunk(mVoucherNo + "\n", font1);
                    Phrase p8 = new Phrase(ch13);
                    PdfPCell f5 = new PdfPCell(p8);
                    // f5.setBackgroundColor(BaseColor.LIGHT_GRAY);
                    tablee.addCell(f5);
                    tablee.setWidthPercentage(113);
                }


                document.add(table);
                document.add(tablee);
                document.close();
            } catch (DocumentException e) {
                e.printStackTrace();
            }
    %>

</body>
</html>
