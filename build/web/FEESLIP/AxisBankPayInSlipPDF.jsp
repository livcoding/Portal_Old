<%-- 
    Document   : PDF
    Created on : Jun 20, 2011, 12:50:27 PM
    Author     : ankur.verma
--%>



<%@page import="javax.servlet.*,javax.servlet.http.*,java.io.*,java.util.*,com.lowagie.text.pdf.*,
        com.lowagie.text.*,java.awt.Color.*"%>
<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">



<%

        DBHandler db = new DBHandler();
        ResultSet rs1 = null;

        String mHead = "", qry1 = "";

        if (session.getAttribute("PageHeading") != null && !session.getAttribute("PageHeading").equals("")) {
            mHead = session.getAttribute("PageHeading").toString().trim();
        } else {
            mHead = "JIIT ";
        }
%>
<HTML>
    <head>
    <TITLE>#### <%=mHead%> [ Axis Bank Pay-In-Slip PDF Format ] </TITLE>
 

	
	
	<%    /*
        response.setContentType("application/pdf");
        //response.setHeader("Content-Disposition","attachment; filename=StudentFee.pdf");
        Document document = new Document();
        try{
        ByteArrayOutputStream buffer = new ByteArrayOutputStream();
        PdfWriter.getInstance(document, buffer);
        document.open();


        PdfPTable table = new PdfPTable(2);
        table.addCell("1");
        table.addCell("2");
        table.addCell("3");
        table.addCell("4");
        table.addCell("5");
        table.addCell("6");


        document.add(table);
        document.close();

        DataOutput dataOutput = new DataOutputStream(response.getOutputStream());
        byte[] bytes = buffer.toByteArray();
        response.setContentLength(bytes.length);
        for(int i = 0; i < bytes.length; i++)
        {
        dataOutput.writeByte(bytes[i]);
        }

        }catch(DocumentException e){
        e.printStackTrace();
        }*/


        int slno = 0;
        float DueAmts = 0;
        String mFeeDesc = "";
        String mFeehead = "", mFeeamt = "", qry = "";
        ResultSet rs = null;


        String mName = request.getParameter("StudentName");
        String mStudID = request.getParameter("StudentID");
        String mInst = request.getParameter("InstituteCode");

        String mEnroll = request.getParameter("Enrollment");
        String mAcademicYearCode = request.getParameter("mAcademicYearCode");
        String mProgram = request.getParameter("Program");
        String mBranch = request.getParameter("Branch");
        String mInstAddress = request.getParameter("mInstAddress");
        String mInstName = request.getParameter("mInstName");
        String mSem1 = request.getParameter("mSem1");
        String mSemType = request.getParameter("mSemType");
        String mSum = request.getParameter("sum");
        String mHostel = request.getParameter("Hostel");
        String mCompanyCode = request.getParameter("mCompanyCode");
        String RegCode = request.getParameter("RegCode");
        String mQuota = request.getParameter("mQuota");
        String Currencycode = request.getParameter("Currencycode");
        response.setContentType("application/pdf"); // Code 1
        Document document = new Document();
        try {

            // for(int j=1 ; j<=2 ;j++)
//    {
            PdfWriter.getInstance(document, response.getOutputStream()); // Code 2
            document.open();

            // Code 3
            PdfPTable table = new PdfPTable(4);
            table.setWidthPercentage(110);

            // table.addCell(mInstName);
            //  table.addCell(mInstAddress);

            Font font12c = new Font(Font.NORMAL, 10, Font.NORMAL);

            Chunk chunkyc = new Chunk("\nDeposited at Branch:...... ", font12c);


            Phrase ph = new Phrase(10, "AXIS BANK  ");
            ph.add("\n");
            ph.add(chunkyc);

            PdfPCell cell7Sc = new PdfPCell(new Paragraph(ph));
            cell7Sc.setColspan(2);
            table.addCell(cell7Sc);



            chunkyc = new Chunk("Date: ", font12c);
            Phrase ph2 = new Phrase(10, "PAY-IN-SLIP  ");
            ph2.add("\n\n");
            ph2.add(chunkyc);
            table.addCell(ph2);

            chunkyc = new Chunk("A/C No.:910010050443719", font12c);
            Phrase ph3 = new Phrase(" BANK'S COPY");
            ph3.add("\n\n");
            ph3.add(chunkyc);
            PdfPCell cell2 = new PdfPCell(new Paragraph(ph3));
            cell2.setColspan(2);
            // cell2.setHorizontalAlignment(Element.ALIGN_RIGHT);
            table.addCell(cell2);







            PdfPCell cell1 = new PdfPCell(new Paragraph(mInstName));
            cell1.setColspan(4);
            cell1.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell1);

            Font font1 = new Font(Font.BOLD, 8, Font.BOLD);
            Chunk chunk1 = new Chunk(mInstAddress, font1);
            Phrase phrase1 = new Phrase();
            phrase1.add(chunk1);

            PdfPCell cell8i = new PdfPCell(phrase1);
            cell8i.setColspan(4);
            cell8i.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell8i);

            Font font12 = new Font(Font.NORMAL, 10, Font.NORMAL);


            Chunk chunkcd = new Chunk("Detail of Student", font12);
            Phrase phrasecd = new Phrase();
            phrasecd.add(chunkcd);

            PdfPCell cell5d = new PdfPCell(phrasecd);
            cell5d.setColspan(4);
            cell5d.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell5d);


            //table.addCell("DETAIL OF STUDENT");

            chunkcd = new Chunk(" Enrl.No. : " + mEnroll + "\n Name     : " + mName, font12);
            phrasecd = new Phrase();
            phrasecd.add(chunkcd);

            PdfPCell cell12 = new PdfPCell(phrasecd);
            cell12.setColspan(2);
            cell12.setHorizontalAlignment(Element.ALIGN_LEFT);




            //  PdfPCell cell12 = new PdfPCell(new Paragraph(" Enrl.No. : " + mEnroll + "\n Name      : " + mName));
            // cell12.setColspan(2);
            //cell12.setHorizontalAlignment(Element.ALIGN_LEFT);

            // table.addCell(" RollNo. : " + mEnroll + "\n Name : " + mName);
            table.addCell(cell12);


            chunkcd = new Chunk(" Program : " + mProgram + "\n Branch   : " + mBranch, font12);
            phrasecd = new Phrase();
            phrasecd.add(chunkcd);

            cell12 = new PdfPCell(phrasecd);

            table.addCell(cell12);

            chunkcd = new Chunk("Semester : " + mSem1, font12);
            phrasecd = new Phrase();
            phrasecd.add(chunkcd);

            cell12 = new PdfPCell(phrasecd);
            table.addCell(cell12);

            //  PdfPCell cell3 = new PdfPCell(new Paragraph("FEE FOR THE SEMESTER"));
            // cell3.setColspan(2);
            // cell3.setHorizontalAlignment(Element.ALIGN_CENTER);
            // table.addCell(cell3);

            PdfPTable table1 = new PdfPTable(2);
            table1.setWidthPercentage(100);


            Chunk chunkcd1 = new Chunk("Fee for the Semester " + mSem1, font12);
            Phrase phrasecd1 = new Phrase();
            phrasecd1.add(chunkcd1);
            PdfPCell cell3 = new PdfPCell(phrasecd1);
            cell3.setColspan(2);
            cell3.setHorizontalAlignment(Element.ALIGN_CENTER);
            table1.addCell(cell3);



            //for (int i = 1; i < 9; i++) {
            //System.out.println(" xzfczcxzczcx");

            /*     qry1="SELECT   s.collseqid, g.currencycode, g.feehead,Initcap(s.FEEHEADDESC)FEEHEADDESC," +
            "         g.postingcompany postingcompany, g.glid, g.feeamount," +
            "         'Academic Year Wise' feesource, feetype" +
            "    FROM feestructure g, feeheads s   WHERE g.institutecode = '"+mInst+"'   " +
            "  AND g.companycode = '"+mCompanyCode+"'" +
            "     AND g.QUOTA = '"+mQuota+"'     AND g.academicyear = '"+mAcademicYearCode+"'" +
            "     AND g.programcode = '"+mProgram+"'     AND g.branchcode = '"+mBranch+"'" +
            "     AND g.semester = "+mSem1+"     AND g.semestertype ='"+mSemType+"'" +
            "     AND g.currencycode = '"+Currencycode+"'       AND NVL (g.feeamount, 0) > 0" +
            "     AND s.feehead = g.feehead     AND s.institutecode = g.institutecode" +
            "     AND s.companycode = g.companycode     AND NVL (s.deactive, 'N') = 'N'" +
            "     AND g.feehead NOT IN (            SELECT f.feehead              FROM feeheads f" +
            "             WHERE f.institutecode = '"+mInst+"'               AND f.companycode = '"+mCompanyCode+"'" +
            "               AND f.feetype = '"+mHostel+"'               AND 'N' = 'N')     AND NOT EXISTS (   SELECT NULL" +
            "              FROM feestructureindividual fsi1             WHERE fsi1.institutecode = '"+mInst+"'" +
            "               AND fsi1.companycode = '"+mCompanyCode+"'               AND fsi1.studentid = '"+mStudID+"'" +
            "               AND fsi1.academicyear = '"+mAcademicYearCode+"'" +
            "               AND fsi1.programcode = '"+mProgram+"'" +
            "               AND fsi1.branchcode = '"+mBranch+"'" +
            "               AND fsi1.currencycode = '"+Currencycode+"'               AND NVL (fsi1.deactive, 'N') = 'N'" +
            "               AND fsi1.semester = g.semester               AND fsi1.semestertype = g.semestertype" +
            "               AND fsi1.regcode ='"+RegCode+"'" +
            "               AND fsi1.feehead = g.feehead)     AND NOT EXISTS (" +
            "            SELECT NULL              FROM feestructurecriteria fsc" +
            "             WHERE fsc.institutecode = '"+mInst+"'" +
            "               AND fsc.companycode = '"+mCompanyCode+"'" +
            "               AND fsc.academicyear = '"+mAcademicYearCode+"'" +
            "               AND fsc.programcode = '"+mProgram+"'" +
            "               AND fsc.branchcode = '"+mBranch+"'               AND fsc.currencycode = '"+Currencycode+"'   " +
            "               AND fsc.semester = g.semester               AND fsc.semestertype = g.semestertype" +
            "               AND fsc.feehead = g.feehead               AND fsc.QUOTA = g.QUOTA" +
            "               AND (    fsc.OPERATOR IN ('IN', '=')                    AND fsc.criteriavalue = 'N'" +
            "                   )) UNION ALL SELECT   s.collseqid, g.currencycode, g.feehead ,Initcap(s.FEEHEADDESC)FEEHEADDESC ,  " +
            "       g.postingcompany postingcompany, g.glid, g.feeamount,         'Criteria Wise' feesource, feetype" +
            "    FROM feestructurecriteria g, feeheads s   WHERE g.institutecode = '"+mInst+"'" +
            "     AND g.companycode = '"+mCompanyCode+"'     AND g.QUOTA = 'GENERAL'" +
            "     AND g.academicyear = '"+mAcademicYearCode+"'     AND g.programcode = '"+mProgram+"'" +
            "     AND g.branchcode = '"+mBranch+"'     AND g.semester = "+mSem1+" " +
            "     AND g.semestertype = '"+mSemType+"'     AND g.currencycode = '"+Currencycode+"'   " +
            "     AND (g.OPERATOR IN ('IN', '=') AND g.criteriavalue = 'N'  )" +
            "     AND s.feehead = g.feehead     AND s.institutecode = g.institutecode" +
            "     AND s.companycode = g.companycode     AND NVL (g.feeamount, 0) > 0" +
            "     AND NVL (s.deactive, 'N') = 'N'     AND g.feehead NOT IN (" +
            "            SELECT f.feehead              FROM feeheads f" +
            "             WHERE f.institutecode = '"+mInst+"'" +
            "               AND f.companycode = '"+mCompanyCode+"'" +
            "               AND f.feetype = '"+mHostel+"' " +
            "               AND 'N' = 'N')     AND NOT EXISTS (            SELECT NULL" +
            "              FROM feestructureindividual fsi1             WHERE fsi1.institutecode = '"+mInst+"'" +
            "               AND fsi1.companycode = '"+mCompanyCode+"'" +
            "               AND fsi1.studentid = '"+mStudID+"'" +
            "               AND fsi1.academicyear = '"+mAcademicYearCode+"'" +
            "               AND fsi1.programcode = '"+mProgram+"'" +
            "               AND fsi1.branchcode = '"+mBranch+"'" +
            "               AND fsi1.currencycode = '"+Currencycode+"'   " +
            "               AND NVL (fsi1.deactive, 'N') = 'N'" +
            "               AND fsi1.regcode = '"+RegCode+"'" +
            "               AND fsi1.semester = g.semester" +
            "               AND fsi1.semestertype = g.semestertype" +
            "               AND fsi1.feehead = g.feehead) UNION ALL " +
            "SELECT   s.collseqid, fi.currencycode, fi.feehead, Initcap(s.FEEHEADDESC ) FEEHEADDESC ,      fi.postingcompany postingcompany, fi.glid, feeamount," +
            "         'Individual' feesource, feetype   FROM feestructureindividual fi, feeheads s" +
            "   WHERE fi.institutecode = '"+mInst+"'     AND fi.companycode = '"+mCompanyCode+"'" +
            "     AND fi.studentid = '"+mStudID+"'     AND fi.academicyear = '"+mAcademicYearCode+"'" +
            "     AND fi.programcode = '"+mProgram+"'     AND fi.branchcode = '"+mBranch+"'" +
            "     AND NVL (fi.deactive, 'N') = 'N'     AND fi.regcode = '"+RegCode+"'" +
            "     AND fi.semester = "+mSem1+"     AND fi.semestertype = '"+mSemType+"'" +
            "     AND fi.currencycode = '"+Currencycode+"'       AND s.feehead = fi.feehead" +
            "     AND s.institutecode = fi.institutecode     AND s.companycode = fi.companycode" +
            "     AND NVL (s.deactive, 'N') = 'N'     AND fi.feehead NOT IN (" +
            "            SELECT f.feehead              FROM feeheads f" +
            "             WHERE f.institutecode = '"+mInst+"'" +
            "               AND f.companycode = '"+mCompanyCode+"'" +
            "               AND f.feetype = '"+mHostel+"'             AND  '"+mHostel+"' = 'N')" +
            "               UNION ALL SELECT   collseqid, '"+Currencycode+"'   currencycode, feehead, Initcap(FEEHEADDESC) ," +
            "         postingcompany postingcompany, glid, 0 feeamount,         'FeeHeads' feesource, feetype" +
            "    FROM feeheads   WHERE companycode = '"+mCompanyCode+"'" +
            "     AND institutecode = '"+mInst+"'     AND NVL (deactive, 'N') = 'N'" +
            "     AND feetype IN ('A')ORDER BY 1 ";
             */

            qry1 = "SELECT   s.collseqid, g.currencycode, g.feehead,Initcap(s.FEEHEADDESC)FEEHEADDESC," +
                    "         g.postingcompany postingcompany, g.glid, g.feeamount," +
                    "         'Academic Year Wise' feesource, feetype" +
                    "    FROM feestructure g, feeheads s   WHERE g.institutecode = '" + mInst + "'     AND g.companycode = '" + mCompanyCode + "'" +
                    "     AND g.QUOTA = '" + mQuota + "'     AND g.academicyear = '" + mAcademicYearCode + "'" +
                    "     AND g.programcode = '" + mProgram + "'     AND g.branchcode = '" + mBranch + "'" +
                    "     AND g.semester = " + mSem1 + "     AND g.semestertype ='" + mSemType + "'" +
                    "     AND g.currencycode = '" + Currencycode + "'     AND NVL (g.feeamount, 0) > 0" +
                    "     AND s.feehead = g.feehead     AND s.institutecode = g.institutecode" +
                    "     AND s.companycode = g.companycode     AND NVL (s.deactive, 'N') = 'N'" +
                    "     AND g.feehead NOT IN (            SELECT f.feehead              FROM feeheads f" +
                    "             WHERE f.institutecode = '" + mInst + "'               AND f.companycode = '" + mCompanyCode + "'" +
                    "               AND f.feetype = 'H'               AND '" + mHostel + "' = 'N')     AND NOT EXISTS (   SELECT NULL" +
                    "              FROM feestructureindividual fsi1             WHERE fsi1.institutecode = '" + mInst + "'" +
                    "               AND fsi1.companycode = '" + mCompanyCode + "'               AND fsi1.studentid = '" + mStudID + "'" +
                    "               AND fsi1.academicyear = '" + mAcademicYearCode + "'" +
                    "               AND fsi1.programcode = '" + mProgram + "'" +
                    "               AND fsi1.branchcode = '" + mBranch + "'" +
                    "               AND fsi1.currencycode = '" + Currencycode + "'            AND NVL (fsi1.deactive, 'N') = 'N'" +
                    "               AND fsi1.semester = g.semester               AND fsi1.semestertype = g.semestertype" +
                    "               AND fsi1.regcode ='" + RegCode + "'" +
                    "               AND fsi1.feehead = g.feehead)     AND NOT EXISTS (" +
                    "            SELECT NULL              FROM feestructurecriteria fsc" +
                    "             WHERE fsc.institutecode = '" + mInst + "'" +
                    "               AND fsc.companycode = '" + mCompanyCode + "'" +
                    "               AND fsc.academicyear = '" + mAcademicYearCode + "'" +
                    "               AND fsc.programcode = '" + mProgram + "'" +
                    "               AND fsc.branchcode = '" + mBranch + "'               AND fsc.currencycode = '" + Currencycode + "' " +
                    "               AND fsc.semester = g.semester               AND fsc.semestertype = g.semestertype" +
                    "               AND fsc.feehead = g.feehead               AND fsc.QUOTA = g.QUOTA" +
                    "               AND (    fsc.OPERATOR IN ('IN', '=')                    AND fsc.criteriavalue = 'N'" +
                    "                   )) UNION ALL SELECT   s.collseqid, g.currencycode, g.feehead ,Initcap(s.FEEHEADDESC)FEEHEADDESC ,  " +
                    "       g.postingcompany postingcompany, g.glid, g.feeamount,         'Criteria Wise' feesource, feetype" +
                    "    FROM feestructurecriteria g, feeheads s   WHERE g.institutecode = '" + mInst + "'" +
                    "     AND g.companycode = '" + mCompanyCode + "'     AND g.QUOTA = '" + mQuota + "' " +
                    "     AND g.academicyear = '" + mAcademicYearCode + "'     AND g.programcode = '" + mProgram + "'" +
                    "     AND g.branchcode = '" + mBranch + "'     AND g.semester = " + mSem1 + " " +
                    "     AND g.semestertype = '" + mSemType + "'     AND g.currencycode = '" + Currencycode + "' " +
                    "     AND (g.OPERATOR IN ('IN', '=') AND g.criteriavalue = 'N'  )" +
                    "     AND s.feehead = g.feehead     AND s.institutecode = g.institutecode" +
                    "     AND s.companycode = g.companycode     AND NVL (g.feeamount, 0) > 0" +
                    "     AND NVL (s.deactive, 'N') = 'N'     AND g.feehead NOT IN (" +
                    "            SELECT f.feehead              FROM feeheads f" +
                    "             WHERE f.institutecode = '" + mInst + "'" +
                    "               AND f.companycode = '" + mCompanyCode + "'" +
                    "               AND f.feetype = 'H'" +
                    "               AND '" + mHostel + "' = 'N')     AND NOT EXISTS (            SELECT NULL" +
                    "              FROM feestructureindividual fsi1             WHERE fsi1.institutecode = '" + mInst + "'" +
                    "               AND fsi1.companycode = '" + mCompanyCode + "'" +
                    "               AND fsi1.studentid = '" + mStudID + "'" +
                    "               AND fsi1.academicyear = '" + mAcademicYearCode + "'" +
                    "               AND fsi1.programcode = '" + mProgram + "'" +
                    "               AND fsi1.branchcode = '" + mBranch + "'" +
                    "               AND fsi1.currencycode = '" + Currencycode + "' " +
                    "               AND NVL (fsi1.deactive, 'N') = 'N'" +
                    "               AND fsi1.regcode = '" + RegCode + "'" +
                    "               AND fsi1.semester = g.semester" +
                    "               AND fsi1.semestertype = g.semestertype" +
                    "               AND fsi1.feehead = g.feehead) UNION ALL " +
                    "SELECT   s.collseqid, fi.currencycode, fi.feehead, Initcap(s.FEEHEADDESC)FEEHEADDESC   ,      fi.postingcompany postingcompany, fi.glid, feeamount," +
                    "         'Individual' feesource, feetype   FROM feestructureindividual fi, feeheads s" +
                    "   WHERE fi.institutecode = '" + mInst + "'     AND fi.companycode = '" + mCompanyCode + "'" +
                    "     AND fi.studentid = '" + mStudID + "'     AND fi.academicyear = '" + mAcademicYearCode + "'" +
                    "     AND fi.programcode = '" + mProgram + "'     AND fi.branchcode = '" + mBranch + "'" +
                    "     AND NVL (fi.deactive, 'N') = 'N'     AND fi.regcode = '" + RegCode + "'" +
                    "     AND fi.semester = " + mSem1 + "     AND fi.semestertype = '" + mSemType + "'" +
                    "     AND fi.currencycode = '" + Currencycode + "'     AND s.feehead = fi.feehead" +
                    "     AND s.institutecode = fi.institutecode     AND s.companycode = fi.companycode" +
                    "     AND NVL (s.deactive, 'N') = 'N'     AND fi.feehead NOT IN (" +
                    "            SELECT f.feehead              FROM feeheads f" +
                    "             WHERE f.institutecode = '" + mInst + "'" +
                    "               AND f.companycode = '" + mCompanyCode + "'" +
                    "               AND f.feetype = 'H'               AND  '" + mHostel + "' = 'N')" +
                    "               UNION ALL SELECT   collseqid, '" + Currencycode + "'   currencycode, feehead, Initcap(FEEHEADDESC)FEEHEADDESC ," +
                    "         postingcompany postingcompany, glid, 0 feeamount,         'FeeHeads' feesource, feetype" +
                    "    FROM feeheads   WHERE companycode = '" + mCompanyCode + "'" +
                    "     AND institutecode = '" + mInst + "'     AND NVL (deactive, 'N') = 'N'" +
                    "     AND feetype IN ('A','E') ORDER BY 1 ";
            rs1 = db.getRowset(qry1);

//System.out.println("dddddddddddddddddddd"+qry1);

            while (rs1.next()) {
                mFeehead = rs1.getString("feehead");
                mFeeamt = rs1.getString("feeamount");
                mFeeDesc = rs1.getString("FEEHEADDESC").toString().trim();

                qry = "select  feedues( '" + mInst + "', '" + mCompanyCode + "','" + mStudID + "'," + mSem1 + ",'" + mSemType + "','" + RegCode + "'," +
                        " '" + mHostel + "' ,'" + mFeehead + "', '" + mFeeamt + "' ,'" + Currencycode + "'  )amount from dual";
                // System.out.print(qry);
                rs = db.getRowset(qry);
                if (rs.next()) {
                    DueAmts = rs.getFloat("amount");

                    if (DueAmts != 0) {
                        slno++;
                        // sum=sum+DueAmts;
                        //  System.out.println("sdf"+DueAmts);


                        chunkcd1 = new Chunk(mFeeDesc, font12);
                        phrasecd1 = new Phrase();
                        phrasecd1.add(chunkcd1);
                        cell3 = new PdfPCell(phrasecd1);

                        cell3.setNoWrap(true);
                        cell3.setPadding(0);

                        table1.addCell(cell3);


                        // table1.addCell(mFeeDesc);
                        // table1.addCell("Rs."+DueAmts);


                        chunkcd1 = new Chunk("Rs." + DueAmts, font12);
                        phrasecd1 = new Phrase();
                        phrasecd1.add(chunkcd1);
                        PdfPCell cell41 = new PdfPCell(phrasecd1);
                        // cell41.setColspan(2);

                        cell41.setHorizontalAlignment(Element.ALIGN_RIGHT);
                        table1.addCell(cell41);

                    }
                }
            }


            for (int i = slno; i < 9; i++) {
                table1.addCell(" ");
                table1.addCell(" ");

            }
// out.print(slno);



            PdfPCell cell10 = new PdfPCell();
            cell10.setColspan(2);
//cell10.addElement(arg0);
            cell10.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell10.addElement(table1);
            table.addCell(cell10);
//table.addCell(table1);


            PdfPTable table2 = new PdfPTable(2);
            table2.setWidthPercentage(100);


            chunkcd1 = new Chunk("Cash Deposit", font12);
            phrasecd1 = new Phrase();
            phrasecd1.add(chunkcd1);

            PdfPCell cell4 = new PdfPCell(phrasecd1);
            cell4.setColspan(2);
            cell4.setHorizontalAlignment(Element.ALIGN_CENTER);
            table2.addCell(cell4);


            chunkcd1 = new Chunk("1000*", font12);
            phrasecd1 = new Phrase();
            phrasecd1.add(chunkcd1);
            cell4 = new PdfPCell(phrasecd1);
            cell4.setHorizontalAlignment(Element.ALIGN_LEFT);
            table2.addCell(cell4);
            //table2.addCell("1000 * ");
            table2.addCell("");


            chunkcd1 = new Chunk("500*", font12);
            phrasecd1 = new Phrase();
            phrasecd1.add(chunkcd1);
            cell4 = new PdfPCell(phrasecd1);
            cell4.setHorizontalAlignment(Element.ALIGN_LEFT);
            table2.addCell(cell4);
            table2.addCell("");


            chunkcd1 = new Chunk("100*", font12);
            phrasecd1 = new Phrase();
            phrasecd1.add(chunkcd1);
            cell4 = new PdfPCell(phrasecd1);
            cell4.setHorizontalAlignment(Element.ALIGN_LEFT);
            table2.addCell(cell4);
            table2.addCell("");



            chunkcd1 = new Chunk("50*", font12);
            phrasecd1 = new Phrase();
            phrasecd1.add(chunkcd1);
            cell4 = new PdfPCell(phrasecd1);
            cell4.setHorizontalAlignment(Element.ALIGN_LEFT);
            table2.addCell(cell4);
            table2.addCell("");



            chunkcd1 = new Chunk("20*", font12);
            phrasecd1 = new Phrase();
            phrasecd1.add(chunkcd1);
            cell4 = new PdfPCell(phrasecd1);
            cell4.setHorizontalAlignment(Element.ALIGN_LEFT);
            table2.addCell(cell4);
            table2.addCell("");




            chunkcd1 = new Chunk("10*", font12);
            phrasecd1 = new Phrase();
            phrasecd1.add(chunkcd1);
            cell4 = new PdfPCell(phrasecd1);
            cell4.setHorizontalAlignment(Element.ALIGN_LEFT);
            table2.addCell(cell4);
            table2.addCell("");




            chunkcd1 = new Chunk("5*", font12);
            phrasecd1 = new Phrase();
            phrasecd1.add(chunkcd1);
            cell4 = new PdfPCell(phrasecd1);
            cell4.setHorizontalAlignment(Element.ALIGN_LEFT);
            table2.addCell(cell4);
            table2.addCell("");



            chunkcd1 = new Chunk("2*", font12);
            phrasecd1 = new Phrase();
            phrasecd1.add(chunkcd1);
            cell4 = new PdfPCell(phrasecd1);
            cell4.setHorizontalAlignment(Element.ALIGN_LEFT);
            table2.addCell(cell4);
            table2.addCell("");



            chunkcd1 = new Chunk("1*", font12);
            phrasecd1 = new Phrase();
            phrasecd1.add(chunkcd1);
            cell4 = new PdfPCell(phrasecd1);
            cell4.setHorizontalAlignment(Element.ALIGN_LEFT);
            table2.addCell(cell4);
            table2.addCell("");


            PdfPCell cell11 = new PdfPCell();
            cell11.setColspan(2);
//cell10.addElement(arg0);
            cell11.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell11.addElement(table2);
            table.addCell(cell11);
            //}

//bold font 
            Font font = new Font(Font.NORMAL, 10, Font.NORMAL);
            Chunk chunk = new Chunk("Total ", font);
            Phrase phrase = new Phrase();
            phrase.add(chunk);

            PdfPCell cell8 = new PdfPCell(phrase);
            cell8.setHorizontalAlignment(Element.ALIGN_RIGHT);
            table.addCell(cell8);


            chunk = new Chunk("Rs." + mSum, font);
            phrase = new Phrase();
            phrase.add(chunk);

            PdfPCell cell112 = new PdfPCell(phrase);
            cell112.setHorizontalAlignment(Element.ALIGN_RIGHT);
            table.addCell(cell112);
            // table.addCell("Rs. "+mSum);


            table.addCell(cell8);

            chunk = new Chunk("Rs.", font);
            phrase = new Phrase();
            phrase.add(chunk);

            cell112 = new PdfPCell(phrase);
            cell112.setHorizontalAlignment(Element.ALIGN_LEFT);
            table.addCell(cell112);








            Chunk chunkc = new Chunk("DD Details", font12);
            Phrase phrasec = new Phrase();
            phrasec.add(chunkc);

            PdfPCell cell5 = new PdfPCell(phrasec);
            cell5.setColspan(4);
            cell5.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell5);



            chunkc = new Chunk("Bank ", font12);
            phrasec = new Phrase();
            phrasec.add(chunkc);

            cell5 = new PdfPCell(phrasec);
            //   cell5.setColspan(4);
            cell5.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell5);

            chunkc = new Chunk("Branch ", font12);
            phrasec = new Phrase();
            phrasec.add(chunkc);

            cell5 = new PdfPCell(phrasec);
            // cell5.setColspan(4);
            cell5.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell5);


            chunkc = new Chunk("DD No. ", font12);
            phrasec = new Phrase();
            phrasec.add(chunkc);

            cell5 = new PdfPCell(phrasec);
            // cell5.setColspan(4);
            cell5.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell5);

            chunkc = new Chunk("Amount ", font12);
            phrasec = new Phrase();
            phrasec.add(chunkc);

            cell5 = new PdfPCell(phrasec);
            // cell5.setColspan(4);
            cell5.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell5);

            //   table.addCell("Bank");
            // table.addCell("Branch");
            // table.addCell("Cheque No.");
            //  table.addCell("Amount ");

            table.addCell("");
            table.addCell("");
            table.addCell("");

            chunkc = new Chunk("Rs.", font12);
            phrasec = new Phrase();
            phrasec.add(chunkc);

            cell5 = new PdfPCell(phrasec);
            // cell5.setColspan(4);
            cell5.setHorizontalAlignment(Element.ALIGN_LEFT);
            table.addCell(cell5);



            //  PdfPCell cell8i = new PdfPCell(phrase1);
            //  cell8i.setColspan(4);
            //  cell8i.setHorizontalAlignment(Element.ALIGN_CENTER);
            //   table.addCell(cell8i);
            Chunk chunk12 = new Chunk("Amount (in words)", font12);
            Phrase phrase12 = new Phrase();
            phrase12.add(chunk12);

            PdfPCell cell5w = new PdfPCell(phrase12);
            cell5w.setColspan(4);
            cell5w.setHorizontalAlignment(Element.ALIGN_LEFT);
            table.addCell(cell5w);
            // table.addCell("");
            // table.addCell("In Word");


            chunk12 = new Chunk("Signature of Depositor & Contact No", font12);
            phrase12 = new Phrase();
            phrase12.add(chunk12);
            PdfPCell cell6 = new PdfPCell(new Paragraph(phrase12));
            cell6.setColspan(2);
            cell6.setHorizontalAlignment(Element.ALIGN_LEFT);

            table.addCell(cell6);


            chunk12 = new Chunk("For office use only", font12);
            Phrase ph6 = new Phrase(chunk12);
            ph6.add("\n");
            //  ph6.add("\n");
            Chunk chunk123 = new Chunk("Tranid No.        Entered          Verified", font12);
            ph6.add(chunk123);
            PdfPCell cell7 = new PdfPCell(new Paragraph(ph6));
            cell7.setColspan(2);
            table.addCell(cell7);


            //  document.add(table);


            //table.addCell("---------------------------------------------------------------");
            // document.add(table3);
            // document.add(table);


            //---------------------------------------student copy












            PdfWriter.getInstance(document, response.getOutputStream()); // Code 2
            document.open();

            // Code 3
            PdfPTable tableS = new PdfPTable(4);
            tableS.setWidthPercentage(110);


            //   PdfPCell cell7 = new PdfPCell(new Paragraph(ph6));
            //  cell7.setColspan(2);
            // table.addCell(cell7);


            // tableS.addCell(mInstName);
            //  tableS.addCell(mInstAddress);

            Font font12c1 = new Font(Font.NORMAL, 10, Font.NORMAL);

            Chunk chunky = new Chunk("\nDeposited at Branch:....... ", font12c1);

            Phrase phS = new Phrase(10, "AXIS BANK  ");
            phS.add("\n");
            phS.add(chunky);

            PdfPCell cell7S = new PdfPCell(new Paragraph(phS));
            cell7S.setColspan(2);
            tableS.addCell(cell7S);

            chunky = new Chunk("Date: ", font12c1);
            Phrase ph2S = new Phrase(10, "PAY-IN-SLIP  ");
            ph2S.add("\n\n");
            ph2S.add(chunky);
            tableS.addCell(ph2S);


            Chunk chunky1 = new Chunk("A/C No.:910010050443719", font12c1);
            Phrase ph3S = new Phrase("STUDENT'S COPY");
            ph3S.add("\n \n");
            ph3S.add(chunky1);
            PdfPCell cell2S = new PdfPCell(new Paragraph(ph3S));
            //  cell2S.setColspan(2);
            cell2.setHorizontalAlignment(Element.ALIGN_LEFT);
            tableS.addCell(cell2S);


            PdfPCell cell1S = new PdfPCell(new Paragraph(mInstName));
            cell1S.setColspan(4);
            cell1S.setHorizontalAlignment(Element.ALIGN_CENTER);
            tableS.addCell(cell1);

            Font font1s = new Font(Font.BOLD, 8, Font.BOLD);
            Chunk chunk1s = new Chunk(mInstAddress, font1s);
            Phrase phrase1s = new Phrase();
            phrase1s.add(chunk1);

            PdfPCell cell8is = new PdfPCell(phrase1s);
            cell8is.setColspan(4);
            cell8is.setHorizontalAlignment(Element.ALIGN_CENTER);
            tableS.addCell(cell8is);





            Chunk chunkcds = new Chunk("Detail of Student", font12);
            Phrase phrasecds = new Phrase();
            phrasecds.add(chunkcds);

            PdfPCell cell5ds = new PdfPCell(phrasecds);
            cell5ds.setColspan(4);
            cell5ds.setHorizontalAlignment(Element.ALIGN_CENTER);
            tableS.addCell(cell5ds);


            //table.addCell("DETAIL OF STUDENT");

            chunkcds = new Chunk(" Enrl.No. : " + mEnroll + "\n Name     : " + mName, font12);
            phrasecds = new Phrase();
            phrasecds.add(chunkcds);

            PdfPCell cell12s = new PdfPCell(phrasecds);
            cell12s.setColspan(2);
            cell12s.setHorizontalAlignment(Element.ALIGN_LEFT);




            //  PdfPCell cell12 = new PdfPCell(new Paragraph(" Enrl.No. : " + mEnroll + "\n Name      : " + mName));
            // cell12.setColspan(2);
            //cell12.setHorizontalAlignment(Element.ALIGN_LEFT);

            // table.addCell(" RollNo. : " + mEnroll + "\n Name : " + mName);
            tableS.addCell(cell12s);



            chunkcds = new Chunk(" Program : " + mProgram + "\n Branch : " + mBranch, font12);
            phrasecds = new Phrase();
            phrasecds.add(chunkcds);

            cell12s = new PdfPCell(phrasecds);

            tableS.addCell(cell12s);
            chunkcds = new Chunk("Semester : " + mSem1, font12);
            phrasecds = new Phrase();
            phrasecds.add(chunkcds);

            cell12s = new PdfPCell(phrasecds);
            tableS.addCell(cell12s);

            //  PdfPCell cell3 = new PdfPCell(new Paragraph("FEE FOR THE SEMESTER"));
            // cell3.setColspan(2);
            // cell3.setHorizontalAlignment(Element.ALIGN_CENTER);
            // table.addCell(cell3);

            PdfPTable table1ss = new PdfPTable(2);
            table1ss.setWidthPercentage(100);


            Chunk chunkcd1s = new Chunk("Fee for the Semester " + mSem1, font12);
            Phrase phrasecd1s = new Phrase();
            phrasecd1s.add(chunkcd1s);
            PdfPCell cell3s = new PdfPCell(phrasecd1s);
            cell3s.setColspan(2);
            cell3s.setHorizontalAlignment(Element.ALIGN_CENTER);
            table1ss.addCell(cell3s);



            //for (int i = 1; i < 9; i++) {
            //System.out.println(" xzfczcxzczcx");

            qry1 = "SELECT   s.collseqid, g.currencycode, g.feehead,Initcap(s.FEEHEADDESC)FEEHEADDESC," +
                    "         g.postingcompany postingcompany, g.glid, g.feeamount," +
                    "         'Academic Year Wise' feesource, feetype" +
                    "    FROM feestructure g, feeheads s   WHERE g.institutecode = '" + mInst + "'     AND g.companycode = '" + mCompanyCode + "'" +
                    "     AND g.QUOTA = '" + mQuota + "'     AND g.academicyear = '" + mAcademicYearCode + "'" +
                    "     AND g.programcode = '" + mProgram + "'     AND g.branchcode = '" + mBranch + "'" +
                    "     AND g.semester = " + mSem1 + "     AND g.semestertype ='" + mSemType + "'" +
                    "     AND g.currencycode = '" + Currencycode + "'     AND NVL (g.feeamount, 0) > 0" +
                    "     AND s.feehead = g.feehead     AND s.institutecode = g.institutecode" +
                    "     AND s.companycode = g.companycode     AND NVL (s.deactive, 'N') = 'N'" +
                    "     AND g.feehead NOT IN (            SELECT f.feehead              FROM feeheads f" +
                    "             WHERE f.institutecode = '" + mInst + "'               AND f.companycode = '" + mCompanyCode + "'" +
                    "               AND f.feetype = 'H'               AND '" + mHostel + "' = 'N')     AND NOT EXISTS (   SELECT NULL" +
                    "              FROM feestructureindividual fsi1             WHERE fsi1.institutecode = '" + mInst + "'" +
                    "               AND fsi1.companycode = '" + mCompanyCode + "'               AND fsi1.studentid = '" + mStudID + "'" +
                    "               AND fsi1.academicyear = '" + mAcademicYearCode + "'" +
                    "               AND fsi1.programcode = '" + mProgram + "'" +
                    "               AND fsi1.branchcode = '" + mBranch + "'" +
                    "               AND fsi1.currencycode = '" + Currencycode + "'            AND NVL (fsi1.deactive, 'N') = 'N'" +
                    "               AND fsi1.semester = g.semester               AND fsi1.semestertype = g.semestertype" +
                    "               AND fsi1.regcode ='" + RegCode + "'" +
                    "               AND fsi1.feehead = g.feehead)     AND NOT EXISTS (" +
                    "            SELECT NULL              FROM feestructurecriteria fsc" +
                    "             WHERE fsc.institutecode = '" + mInst + "'" +
                    "               AND fsc.companycode = '" + mCompanyCode + "'" +
                    "               AND fsc.academicyear = '" + mAcademicYearCode + "'" +
                    "               AND fsc.programcode = '" + mProgram + "'" +
                    "               AND fsc.branchcode = '" + mBranch + "'               AND fsc.currencycode = '" + Currencycode + "' " +
                    "               AND fsc.semester = g.semester               AND fsc.semestertype = g.semestertype" +
                    "               AND fsc.feehead = g.feehead               AND fsc.QUOTA = g.QUOTA" +
                    "               AND (    fsc.OPERATOR IN ('IN', '=')                    AND fsc.criteriavalue = 'N'" +
                    "                   )) UNION ALL SELECT   s.collseqid, g.currencycode, g.feehead ,Initcap(s.FEEHEADDESC)FEEHEADDESC ,  " +
                    "       g.postingcompany postingcompany, g.glid, g.feeamount,         'Criteria Wise' feesource, feetype" +
                    "    FROM feestructurecriteria g, feeheads s   WHERE g.institutecode = '" + mInst + "'" +
                    "     AND g.companycode = '" + mCompanyCode + "'     AND g.QUOTA = '" + mQuota + "' " +
                    "     AND g.academicyear = '" + mAcademicYearCode + "'     AND g.programcode = '" + mProgram + "'" +
                    "     AND g.branchcode = '" + mBranch + "'     AND g.semester = " + mSem1 + " " +
                    "     AND g.semestertype = '" + mSemType + "'     AND g.currencycode = '" + Currencycode + "' " +
                    "     AND (g.OPERATOR IN ('IN', '=') AND g.criteriavalue = 'N'  )" +
                    "     AND s.feehead = g.feehead     AND s.institutecode = g.institutecode" +
                    "     AND s.companycode = g.companycode     AND NVL (g.feeamount, 0) > 0" +
                    "     AND NVL (s.deactive, 'N') = 'N'     AND g.feehead NOT IN (" +
                    "            SELECT f.feehead              FROM feeheads f" +
                    "             WHERE f.institutecode = '" + mInst + "'" +
                    "               AND f.companycode = '" + mCompanyCode + "'" +
                    "               AND f.feetype = 'H'" +
                    "               AND '" + mHostel + "' = 'N')     AND NOT EXISTS (            SELECT NULL" +
                    "              FROM feestructureindividual fsi1             WHERE fsi1.institutecode = '" + mInst + "'" +
                    "               AND fsi1.companycode = '" + mCompanyCode + "'" +
                    "               AND fsi1.studentid = '" + mStudID + "'" +
                    "               AND fsi1.academicyear = '" + mAcademicYearCode + "'" +
                    "               AND fsi1.programcode = '" + mProgram + "'" +
                    "               AND fsi1.branchcode = '" + mBranch + "'" +
                    "               AND fsi1.currencycode = '" + Currencycode + "' " +
                    "               AND NVL (fsi1.deactive, 'N') = 'N'" +
                    "               AND fsi1.regcode = '" + RegCode + "'" +
                    "               AND fsi1.semester = g.semester" +
                    "               AND fsi1.semestertype = g.semestertype" +
                    "               AND fsi1.feehead = g.feehead) UNION ALL " +
                    "SELECT   s.collseqid, fi.currencycode, fi.feehead, Initcap(s.FEEHEADDESC)FEEHEADDESC   ,      fi.postingcompany postingcompany, fi.glid, feeamount," +
                    "         'Individual' feesource, feetype   FROM feestructureindividual fi, feeheads s" +
                    "   WHERE fi.institutecode = '" + mInst + "'     AND fi.companycode = '" + mCompanyCode + "'" +
                    "     AND fi.studentid = '" + mStudID + "'     AND fi.academicyear = '" + mAcademicYearCode + "'" +
                    "     AND fi.programcode = '" + mProgram + "'     AND fi.branchcode = '" + mBranch + "'" +
                    "     AND NVL (fi.deactive, 'N') = 'N'     AND fi.regcode = '" + RegCode + "'" +
                    "     AND fi.semester = " + mSem1 + "     AND fi.semestertype = '" + mSemType + "'" +
                    "     AND fi.currencycode = '" + Currencycode + "'     AND s.feehead = fi.feehead" +
                    "     AND s.institutecode = fi.institutecode     AND s.companycode = fi.companycode" +
                    "     AND NVL (s.deactive, 'N') = 'N'     AND fi.feehead NOT IN (" +
                    "            SELECT f.feehead              FROM feeheads f" +
                    "             WHERE f.institutecode = '" + mInst + "'" +
                    "               AND f.companycode = '" + mCompanyCode + "'" +
                    "               AND f.feetype = 'H'               AND  '" + mHostel + "' = 'N')" +
                    "               UNION ALL SELECT   collseqid, '" + Currencycode + "'   currencycode, feehead, Initcap(FEEHEADDESC)FEEHEADDESC ," +
                    "         postingcompany postingcompany, glid, 0 feeamount,         'FeeHeads' feesource, feetype" +
                    "    FROM feeheads   WHERE companycode = '" + mCompanyCode + "'" +
                    "     AND institutecode = '" + mInst + "'     AND NVL (deactive, 'N') = 'N'" +
                    "     AND feetype IN ('A','E') ORDER BY 1 ";

            rs1 = db.getRowset(qry1);

           // System.out.print(qry1);

            while (rs1.next()) {
                mFeehead = rs1.getString("feehead");
                mFeeamt = rs1.getString("feeamount");
                mFeeDesc = rs1.getString("FEEHEADDESC").toString().trim();

                qry = "select  feedues( '" + mInst + "', '" + mCompanyCode + "','" + mStudID + "'," + mSem1 + ",'" + mSemType + "','" + RegCode + "'," +
                        " '" + mHostel + "' ,'" + mFeehead + "', '" + mFeeamt + "' ,'" + Currencycode + "'  )amount from dual";
                //  System.out.print(qry);
                rs = db.getRowset(qry);
                if (rs.next()) {
                    DueAmts = rs.getFloat("amount");

                    if (DueAmts != 0) {
                        slno++;
                        // sum=sum+DueAmts;
                        //  System.out.println("sdf"+DueAmts);


                        chunkcd1s = new Chunk(mFeeDesc, font12);
                        phrasecd1s = new Phrase();
                        phrasecd1s.add(chunkcd1s);
                        cell3s = new PdfPCell(phrasecd1s);
                        cell3s.setNoWrap(true);
                        cell3s.setPadding(0);

                        table1ss.addCell(cell3s);


                        // table1.addCell(mFeeDesc);
                        // table1.addCell("Rs."+DueAmts);


                        chunkcd1s = new Chunk("Rs." + DueAmts, font12);
                        phrasecd1s = new Phrase();
                        phrasecd1s.add(chunkcd1s);
                        PdfPCell cell41s = new PdfPCell(phrasecd1s);
                        // cell41.setColspan(2);
                        cell41s.setHorizontalAlignment(Element.ALIGN_RIGHT);

                        table1ss.addCell(cell41s);

                    }
                }
            }


            for (int i = slno; i < 6; i++) {
                chunkcd1s = new Chunk(" ",font12);
                        phrasecd1s = new Phrase();
                        phrasecd1s.add(chunkcd1s);
                        PdfPCell cell41s = new PdfPCell(phrasecd1s);
                        cell41s.setPadding(0);
                        cell41s.setNoWrap(true);
                        cell41s.setMinimumHeight(1);

                       //     cell41s
                table1ss.addCell(cell41s);
                table1ss.addCell(cell41s);

            }
// out.print(slno);



            PdfPCell cell10s = new PdfPCell();
            cell10s.setColspan(2);
//cell10.addElement(arg0);
            cell10s.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell10s.addElement(table1ss);
            tableS.addCell(cell10);
//table.addCell(table1);


            PdfPTable table2s = new PdfPTable(2);
            table2s.setWidthPercentage(100);


            chunkcd1s = new Chunk("Cash Deposit", font12);
            phrasecd1s = new Phrase();
            phrasecd1s.add(chunkcd1s);

            PdfPCell cell4s = new PdfPCell(phrasecd1s);
            cell4s.setColspan(2);
            cell4s.setHorizontalAlignment(Element.ALIGN_CENTER);
            table2s.addCell(cell4s);


            chunkcd1s = new Chunk("1000*", font12);
            phrasecd1s = new Phrase();
            phrasecd1s.add(chunkcd1s);
            cell4s = new PdfPCell(phrasecd1s);
            cell4s.setHorizontalAlignment(Element.ALIGN_LEFT);
            table2s.addCell(cell4s);
            //table2.addCell("1000 * ");
            table2s.addCell("");


            chunkcd1s = new Chunk("500*", font12);
            phrasecd1s = new Phrase();
            phrasecd1s.add(chunkcd1s);
            cell4s = new PdfPCell(phrasecd1s);
            cell4s.setHorizontalAlignment(Element.ALIGN_LEFT);
            table2s.addCell(cell4s);
            table2s.addCell("");


            chunkcd1s = new Chunk("100*", font12);
            phrasecd1s = new Phrase();
            phrasecd1s.add(chunkcd1s);
            cell4s = new PdfPCell(phrasecd1s);
            cell4s.setHorizontalAlignment(Element.ALIGN_LEFT);
            table2s.addCell(cell4s);
            table2s.addCell("");



            chunkcd1s = new Chunk("50*", font12);
            phrasecd1s = new Phrase();
            phrasecd1s.add(chunkcd1s);
            cell4s = new PdfPCell(phrasecd1s);
            cell4s.setHorizontalAlignment(Element.ALIGN_LEFT);
            table2s.addCell(cell4s);
            table2s.addCell("");



            chunkcd1s = new Chunk("20*", font12);
            phrasecd1s = new Phrase();
            phrasecd1s.add(chunkcd1s);
            cell4s = new PdfPCell(phrasecd1s);
            cell4s.setHorizontalAlignment(Element.ALIGN_LEFT);
            table2s.addCell(cell4s);
            table2s.addCell("");




            chunkcd1s = new Chunk("10*", font12);
            phrasecd1s = new Phrase();
            phrasecd1s.add(chunkcd1s);
            cell4s = new PdfPCell(phrasecd1s);
            cell4s.setHorizontalAlignment(Element.ALIGN_LEFT);
            table2s.addCell(cell4s);
            table2s.addCell("");




            chunkcd1s = new Chunk("5*", font12);
            phrasecd1s = new Phrase();
            phrasecd1s.add(chunkcd1s);
            cell4s = new PdfPCell(phrasecd1s);
            cell4s.setHorizontalAlignment(Element.ALIGN_LEFT);
            table2s.addCell(cell4s);
            table2s.addCell("");



            chunkcd1s = new Chunk("2*", font12);
            phrasecd1s = new Phrase();
            phrasecd1s.add(chunkcd1s);
            cell4s = new PdfPCell(phrasecd1s);
            cell4s.setHorizontalAlignment(Element.ALIGN_LEFT);
            table2s.addCell(cell4s);
            table2s.addCell("");



            chunkcd1s = new Chunk("1*", font12);
            phrasecd1s = new Phrase();
            phrasecd1s.add(chunkcd1s);
            cell4s = new PdfPCell(phrasecd1s);
            cell4s.setHorizontalAlignment(Element.ALIGN_LEFT);
            table2s.addCell(cell4s);
            table2s.addCell("");


            PdfPCell cell11s = new PdfPCell();
            cell11s.setColspan(2);
//cell10.addElement(arg0);
            cell11s.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell11s.addElement(table2s);
            tableS.addCell(cell11s);
            //}

//bold font
            Font font122 = new Font(Font.NORMAL, 10, Font.NORMAL);
            Chunk chunkss = new Chunk("Total ", font122);
            Phrase phrasess = new Phrase();
            phrasess.add(chunkss);

            PdfPCell cell8ss = new PdfPCell(phrasess);
            cell8ss.setHorizontalAlignment(Element.ALIGN_RIGHT);
            tableS.addCell(cell8ss);


            chunkss = new Chunk("Rs." + mSum, font122);
            phrasess = new Phrase();
            phrasess.add(chunkss);

            PdfPCell cell112s = new PdfPCell(phrasess);
            cell112s.setHorizontalAlignment(Element.ALIGN_RIGHT);
            tableS.addCell(cell112s);
            // table.addCell("Rs. "+mSum);


            tableS.addCell(cell8ss);

            chunkss = new Chunk("Rs.", font);
            phrasess = new Phrase();
            phrasess.add(chunkss);

            cell112s = new PdfPCell(phrasess);
            cell112s.setHorizontalAlignment(Element.ALIGN_LEFT);
            tableS.addCell(cell112s);








            Chunk chunkc1 = new Chunk("DD Details", font12);
            Phrase phrasec1 = new Phrase();
            phrasec1.add(chunkc1);

            PdfPCell cell51 = new PdfPCell(phrasec1);
            cell51.setColspan(4);
            cell51.setHorizontalAlignment(Element.ALIGN_CENTER);
            tableS.addCell(cell51);




            chunkc1 = new Chunk("Bank ", font12);
            phrasec1 = new Phrase();
            phrasec1.add(chunkc1);

            cell51 = new PdfPCell(phrasec1);
            //   cell5.setColspan(4);
            cell51.setHorizontalAlignment(Element.ALIGN_CENTER);
            tableS.addCell(cell51);

            chunkc1 = new Chunk("Branch ", font12);
            phrasec1 = new Phrase();
            phrasec1.add(chunkc1);

            cell51 = new PdfPCell(phrasec1);
            // cell5.setColspan(4);
            cell51.setHorizontalAlignment(Element.ALIGN_CENTER);
            tableS.addCell(cell51);


            chunkc1 = new Chunk("DD No. ", font12);
            phrasec1 = new Phrase();
            phrasec1.add(chunkc1);

            cell51 = new PdfPCell(phrasec1);
            // cell5.setColspan(4);
            cell51.setHorizontalAlignment(Element.ALIGN_CENTER);
            tableS.addCell(cell51);

            chunkc1 = new Chunk("Amount ", font12);
            phrasec1 = new Phrase();
            phrasec1.add(chunkc1);

            cell51 = new PdfPCell(phrasec1);
            // cell5.setColspan(4);
            cell51.setHorizontalAlignment(Element.ALIGN_CENTER);
            tableS.addCell(cell51);

            //   table.addCell("Bank");
            // table.addCell("Branch");
            // table.addCell("Cheque No.");
            //  table.addCell("Amount ");

            tableS.addCell("");
            tableS.addCell("");
            tableS.addCell("");

            chunkc1 = new Chunk("Rs.", font12);
            phrasec1 = new Phrase();
            phrasec1.add(chunkc1);

            cell51 = new PdfPCell(phrasec1);
            // cell5.setColspan(4);
            cell51.setHorizontalAlignment(Element.ALIGN_LEFT);
            tableS.addCell(cell51);



            //  PdfPCell cell8i = new PdfPCell(phrase1);
            //  cell8i.setColspan(4);
            //  cell8i.setHorizontalAlignment(Element.ALIGN_CENTER);
            //   table.addCell(cell8i);
            Chunk chunk121 = new Chunk("Amount (in words)", font12);
            Phrase phrase121 = new Phrase();
            phrase121.add(chunk121);

            PdfPCell cell5w1 = new PdfPCell(phrase121);
            cell5w1.setColspan(4);
            cell5w1.setHorizontalAlignment(Element.ALIGN_LEFT);
            tableS.addCell(cell5w1);
            // table.addCell("");
            // table.addCell("In Word");


            chunk121 = new Chunk("Signature of Depositor & Contact No", font12);
            phrase121 = new Phrase();
            phrase121.add(chunk121);
            PdfPCell cell61 = new PdfPCell(new Paragraph(phrase121));
            cell61.setColspan(2);
            cell61.setHorizontalAlignment(Element.ALIGN_LEFT);

            tableS.addCell(cell61);


            chunk121 = new Chunk("For office use only", font12);
            Phrase ph61 = new Phrase(chunk121);
            ph61.add("\n");
            //  ph6.add("\n");
            Chunk chunk1231 = new Chunk("Tranid No.        Entered          Verified", font12);
            ph61.add(chunk1231);
            PdfPCell cell71 = new PdfPCell(new Paragraph(ph61));
            cell71.setColspan(2);
            tableS.addCell(cell71);




            PdfPTable table2D = new PdfPTable(2);
            table2D.setWidthPercentage(200);

//Wingdings
//Font font12d=new Font(Font.WINGDINGS , 8, Font.BOLD);
//font12d.setStyle(Font.Wingdings);

//Image jpeg = Image.getInstance("logo.png");

            Chunk chunk6d = new Chunk("\n - - - - - - - - - - - - - - - - - - - please tear from here - - - - - - - - - - - - - - - - - -\n", font12);
            Phrase ph6D = new Phrase(chunk6d);
            ph6D.add("\n");
            PdfPCell celld = new PdfPCell(new Paragraph(ph6D));
            celld.setColspan(2);
            celld.setBorder(0);
            celld.setHorizontalAlignment(Element.ALIGN_CENTER);
//pdfHCell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table2D.addCell(celld);

            document.add(table);

            document.add(table2D);

            document.add(tableS);



            document.close();


//}

        } catch (DocumentException e) {
            e.printStackTrace();
        }

    %>

    </body>
</html>
