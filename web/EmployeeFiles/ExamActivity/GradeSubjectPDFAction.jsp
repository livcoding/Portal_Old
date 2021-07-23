


<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>

<%@page import="javax.servlet.*,javax.servlet.http.*,java.io.*,java.util.*,com.lowagie.text.pdf.*,com.lowagie.text.pdf.fonts.*,
        com.lowagie.text.*,java.awt.Color.*"%>
<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>

<TITLE>#### <%=mHead%> [ Grade Subject PDF Generation ]</TITLE>


<script type="text/javascript" src="../js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="../css/sortabletable.css" />

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

<script language=javascript>
	
	function RefreshContents()
	{ 	
    	    document.frm.x.value='ddd';
    	    document.frm.submit();
	}
//-->
</script>

</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
	<form name="frm" method="post"  action="GradeSubjectPDFFile.jsp" >

<%

DBHandler db=new DBHandler();
ResultSet rs=null,rs1=null;
ResultSet rss=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="";
String x="";
int mTotal=0;
int n=0;
int mFlag=0;
int mRecFlag=0;
int ChkFlag=0,ctr=0;
String mName1="",mName2="";
String mSCode="", mAprRemarks="";

String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInst="";
String mECode="",mChk="";
String mWebEmail="",SubjectCode="",SubjectName="",QryExam="";

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
}

if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
}

if (request.getParameter("TotalCount")==null)
{
	mTotal=0;
}
else
{
	mTotal=Integer.parseInt(request.getParameter("TotalCount").toString().trim());
}

if (request.getParameter("InstCode")==null)
{
	mInst="";
}
else
{
	mInst=request.getParameter("InstCode").toString().trim();
}
if (request.getParameter("Exam")==null)
{
	QryExam="";
}
else
{
	QryExam=request.getParameter("Exam").toString().trim();
}

if (request.getParameter("Remarks")==null)
{
	mAprRemarks="";
}
else
{
	mAprRemarks=request.getParameter("Remarks").toString().trim();
}
%>

<hr>
<center><font size=4 face=Verdana color=green>Grade Subject PDF Generation </font>
<hr>
<%
try
{
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{
		OLTEncryption enc=new OLTEncryption();
		mDMemberID=enc.decode(mMemberID);
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);
		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
		qry="Select WEBKIOSK.ShowLink('147','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{
		if (request.getParameter("TotalCount")!=null && Integer.parseInt(request.getParameter("TotalCount").toString().trim())>0)
		{
			// For Log Entry Purpose
			//--------------------------------------
			String mLogEntryMemberID="",mLogEntryMemberType="";
			if (session.getAttribute("LogEntryMemberID")==null || session.getAttribute("LogEntryMemberID").toString().trim().equals(""))
				mLogEntryMemberID="";
			else
				mLogEntryMemberID=session.getAttribute("LogEntryMemberID").toString().trim();

			if (session.getAttribute("LogEntryMemberType")==null || session.getAttribute("LogEntryMemberType").toString().trim().equals(""))
				mLogEntryMemberType="";
			else
				mLogEntryMemberType=session.getAttribute("LogEntryMemberType").toString().trim();

			if (mLogEntryMemberType.equals(""))
				mLogEntryMemberType=mMemberType;

			if (mLogEntryMemberID.equals(""))
				mLogEntryMemberID=mMemberID;

			if (!mLogEntryMemberType.equals(""))
				mLogEntryMemberType=enc.decode(mLogEntryMemberType);

			if (!mLogEntryMemberID.equals(""))
				mLogEntryMemberID=enc.decode(mLogEntryMemberID);

			//--------------------------------------


       
        try {




  response.setContentType("application/pdf"); // Code 1
 Document document = new Document();
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

            Chunk chunkyc = new Chunk("\nExam Code " + QryExam + " ", font12c);


            Phrase ph = new Phrase(10, " Grade Sheet in PDF ");
            ph.add("\n");
            ph.add(chunkyc);

            PdfPCell cell7Sc = new PdfPCell(new Paragraph(ph));
            cell7Sc.setColspan(2);
            table.addCell(cell7Sc);



	  PdfPTable table1 = new PdfPTable(5);
            table1.setWidthPercentage(100);


				   Font font12 = new Font(Font.NORMAL, 10, Font.NORMAL);

                 

			for (int i=1;i<=mTotal;i++)
			{  
				mRecFlag=0;
				mName1="Checked_"+String.valueOf(i).trim();
				mName2="SubjCode_"+String.valueOf(i).trim();
				
				if(request.getParameter(mName1)!=null)
					mChk=request.getParameter(mName1);
				else
					mChk="";
				if (request.getParameter(mName2)!=null)
					mSCode=request.getParameter(mName2);
				else
					mSCode="";

			//-------------
			//--Update here
			//-------------
			//out.print(mChk+"--"+mSCode);
				if(!mChk.equals(""))
				{
					
					
					qry="select subjectid, subjectcode,subject from subjectmaster where subjectid='"+mSCode+"' and INSTITUTECODE ='"+mInst+"' ";
				//	out.print(qry);
                     System.out.println(qry);
					rs=db.getRowset(qry);
					while(rs.next())
					{
						SubjectCode=rs.getString("subjectcode");
						SubjectName=rs.getString("subject");
					
					

				qry="select A.STUDENTID,B.STUDENTNAME,b.enrollmentno enrollmentno,A.FINALGRADE,A.FINALMARKS " +
                        " from studentwisegrade A,STUDENTMASTER B where A.examcode='"+QryExam+"' " +
                        "and a.INSTITUTECODE ='"+mInst+"'  AND A.STUDENTID=B.STUDENTID AND" +
                        " A.INSTITUTECODE=B.INSTITUTECODE AND A.BREAK#SLNO IN(SELECT BREAK#SLNO " +
                        "FROM GRADECALCULATION WHERE examcode='"+QryExam+"'  AND SUBJECTID='"+mSCode+"' " +
                        "and INSTITUTECODE ='"+mInst+"'  )";
				qry=qry+" Order by ENROLLMENTNO";
				//
              System.out.println(qry);
				rs1=db.getRowset(qry);
				rss=db.getRowset(qry);
				if(rs1.next())
				{
				

                 Font font = new Font( Font.COURIER , 10, Font.BOLD );

            Chunk chunkcd1 = new Chunk(SubjectCode+" " + SubjectName , font);
            Phrase phrasecd1 = new Phrase();
            phrasecd1.add(chunkcd1);
            PdfPCell cell3 = new PdfPCell(phrasecd1);
            cell3.setColspan(5);
            cell3.setHorizontalAlignment(Element.ALIGN_CENTER);
            table1.addCell(cell3);

                        chunkcd1 = new Chunk("Sr No.", font);
                        phrasecd1 = new Phrase();
                        phrasecd1.add(chunkcd1);
                        cell3 = new PdfPCell(phrasecd1);

                        cell3.setNoWrap(true);
                        cell3.setPadding(0);
                        cell3.setHorizontalAlignment(Element.ALIGN_CENTER);
                        table1.addCell(cell3);


                        // table1.addCell(mFeeDesc);
                        // table1.addCell("Rs."+DueAmts);


                        chunkcd1 = new Chunk("Student Name" , font);
                        phrasecd1 = new Phrase();
                        phrasecd1.add(chunkcd1);
                        PdfPCell cell41 = new PdfPCell(phrasecd1);
                                              // cell41.setColspan(2);
                        cell41.setHorizontalAlignment(Element.ALIGN_CENTER);
                        table1.addCell(cell41);

                        chunkcd1 = new Chunk("Enrollment No" , font);
                        phrasecd1 = new Phrase();
                        phrasecd1.add(chunkcd1);
                        PdfPCell cell42 = new PdfPCell(phrasecd1);
                                              // cell41.setColspan(2);
                        cell42.setHorizontalAlignment(Element.ALIGN_CENTER);
                        table1.addCell(cell42);

                          chunkcd1 = new Chunk("Final Marks" , font);
                        phrasecd1 = new Phrase();
                        phrasecd1.add(chunkcd1);
                        PdfPCell cell43 = new PdfPCell(phrasecd1);
                                              // cell41.setColspan(2);
                        cell43.setHorizontalAlignment(Element.ALIGN_CENTER);
                        table1.addCell(cell43);



                          chunkcd1 = new Chunk("Final Grades" , font);
                        phrasecd1 = new Phrase();
                        phrasecd1.add(chunkcd1);
                        PdfPCell cell44 = new PdfPCell(phrasecd1);
                                              // cell41.setColspan(2);
                        cell43.setHorizontalAlignment(Element.ALIGN_RIGHT);
                        table1.addCell(cell44);

               
				}
				else
				{
					%><Center><%
					out.print("<br><img src='../../Images/Error1.jpg'>");
					out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>No Such Record Found...</font> <br>");
					%></Center><%
				}
				String mColor="";
				int mChoice=0;
				String mLastStatus="";
				String mCol1="LightGrey";
				String OldmELECTIVECODE="";
				String mCol2="#ffffff";
				String mSubjCode="", mSubjName="", mE2DType="", mEDate="", TRCOLOR="#F8F8F8";
				while(rss.next())
				{					ctr++;

           
        //    PdfPCell cell4 = new PdfPCell();
         		  // Font font121 = new Font(Font.NORMAL, 10, Font.NORMAL);

     Chunk   chunkcd12 = new Chunk(""+ctr, font12);
           Phrase phrasecd12 = new Phrase();
            phrasecd12.add(chunkcd12);
            PdfPCell cell3 = new PdfPCell(phrasecd12);
            cell3.setFixedHeight(4);

            cell3.setHorizontalAlignment(Element.ALIGN_LEFT);
            table1.addCell(cell3);



            chunkcd12 = new Chunk(""+rss.getString("STUDENTNAME"), font12);
            phrasecd12 = new Phrase();
            phrasecd12.add(chunkcd12);
            PdfPCell cell4 = new PdfPCell(phrasecd12);
            
            cell4.setHorizontalAlignment(Element.ALIGN_LEFT);
            table1.addCell(cell4);

            chunkcd12 = new Chunk(""+rss.getString("ENROLLMENTNO"), font12);
            phrasecd12 = new Phrase();
            phrasecd12.add(chunkcd12);
            PdfPCell cell5 = new PdfPCell(phrasecd12);
            cell5.setNoWrap(true);
            cell5.setHorizontalAlignment(Element.ALIGN_LEFT);
            table1.addCell(cell5);

            chunkcd12 = new Chunk(""+rss.getString("FINALMARKS"), font12);
            phrasecd12 = new Phrase();
            phrasecd12.add(chunkcd12);
            PdfPCell cell6 = new PdfPCell(phrasecd12);
            cell6.setHorizontalAlignment(Element.ALIGN_RIGHT);
            table1.addCell(cell6);


            chunkcd12 = new Chunk(""+rss.getString("FINALGRADE"), font12);
            phrasecd12 = new Phrase();
            phrasecd12.add(chunkcd12);
            PdfPCell cell7 = new PdfPCell(phrasecd12);
            cell7.setHorizontalAlignment(Element.ALIGN_RIGHT);
            table1.addCell(cell7);


					
				}


					}
					ctr=0;
				}
				
			}

                   document.add(table);
document.add(table1);

  document.close();

}
       catch (DocumentException e) {
            e.printStackTrace();
        }

			
			}
			else
			{
			%>
				<center><br><br><font size=4 color=RED>No Record Found !</font></center>
			<%
			}
//-----------------------------
//-- Enable Security Page Level
//-----------------------------
		}
		else
   		{
		%>
			<br>
			<font color=red>
			<h3><br><img src='../../Images/Error1.jpg'>Access Denied (authentication_failed)</h3><br>
			<P>This page is not authorized/available for you.
			<br>For assistance, contact your network support team. 
			</font><br><br><br><br>
		<%
	}
  //-----------------------------
	}
	else
	{
		out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}      
}
catch(Exception e)
{
 
}
%><br>
<table ALIGN=Center VALIGN=TOP>
		<tr>
		<td valign=middle>
		<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">
		<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
		A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
		<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>  
		</td></tr></table>
</body>
</html>