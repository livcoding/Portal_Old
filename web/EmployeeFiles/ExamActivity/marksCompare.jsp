<%-- 
    Document   : marksCompare
    Created on : 4 Jan, 2016, 10:34:03 AM
    Author     : nipun.gupta
--%>

<%@page import="jilit.db.ReconcileMarksEntryReportDB"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFCell"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFRow"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFSheet"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
 <!DOCTYPE html>
<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mMemberName1="",mIC1="",mEC1="",mSC1="",NewSubject="",Newsubcode="";

if (session.getAttribute("MemberName")==null) 
{
	mMemberName1="";
}
else
{
	mMemberName1=session.getAttribute("MemberName").toString().trim();
}
if (session.getAttribute("InstCode")==null) 
{
	mIC1="";
}
else
{
	mIC1=session.getAttribute("InstCode").toString().trim();
}
if (session.getAttribute("Exam")==null)
{
	mEC1="";
}
else
{
	mEC1=session.getAttribute("Exam").toString().trim();
}

if (session.getAttribute("Subject")==null)
{
	mSC1="";
}
else
{
	mSC1=session.getAttribute("Subject").toString().trim();
}
String excelMarks="";
    ReconcileMarksEntryReportDB ab=new ReconcileMarksEntryReportDB();
     int counter=0;
            int sNo=1;

             try {

            FileInputStream file = new FileInputStream(new File("D://"+mIC1+"'"+mEC1+"''"+mMemberName1+"''"+mSC1+".xls"));
            HSSFWorkbook workbook2 = new  HSSFWorkbook (file);
            HSSFSheet sheet = workbook2.getSheetAt(0);

            int lastrow=sheet.getLastRowNum();
            //Iterate through each rows one by one
            //  Iterator<Row> rowIterator = sheet.iterator();
            try{
            for (int i=1;i<=lastrow+1;i++) {
                HSSFRow row=sheet.getRow(i);
                if(i!=lastrow+1){
                for (int cn = 0; cn < row.getLastCellNum(); cn++) {

                     HSSFCell cell = row.getCell((short)cn);
                    //System.out.println("CELL: " + cn + " --> " + cell.toString());
                    if(cn==3){
                   
                    double stmarks=cell.getNumericCellValue();
                    String smarks=Double.toString(stmarks);
                    if(smarks!=null){
                    excelMarks=excelMarks+ab.convertItToString(smarks)+",";
                    }
                    }
                }
                }
            }
            }catch(Exception e){
            }
            file.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }
     int count=0;
            
             String excelMarksArray[]=excelMarks.split(",");
             String excelMarksArrayNew[]=new String[excelMarksArray.length];
             for(int x=0;x<excelMarksArray.length;x++)
             {
                 excelMarksArrayNew[count]=excelMarksArray[x];
                 count++;
             }
             
try {
            GlobalFunctions gb = new GlobalFunctions();
            OLTEncryption enc = new OLTEncryption();
            DBHandler db = new DBHandler();
            ResultSet rs = null, rssub = null, rsm = null, rs1 = null;
            String mMemberID = "", mMemberType = "", mDMemberType = "", mMemberName = "", mMemberCode = "", mInst = "", mDMemberCode = "", mCheckFstid = "", mSMarks = "";
            String mComp = "", mSelf = "", mIC = "", mEC = "", mSC = "", mList = "", mOrder = "", mEvent = "", mSE = "", qry = "", qry1 = "", qry2 = "", mMOP = "",jspMarks="";
            int len = 0, pos = 0, ctr = 0;
            double mWeight = 0, mMaxmarks = 0;
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

            if (session.getAttribute("InstituteCode") == null) {
                mInst = "";
            } else {
                mInst = session.getAttribute("InstituteCode").toString().trim();
            }

            if (session.getAttribute("CompanyCode") == null) {
                mComp = "";
            } else {
                mComp = session.getAttribute("CompanyCode").toString().trim();
            }

            if (session.getAttribute("Click") != null) {
                mSelf = session.getAttribute("Click").toString().trim();
            } else {
                mSelf = "";
            }
            //"D://"+mIC+"\'"+mEC+"'\'"+mMemberName+"'\'"+mSC+".xlsx"
            if (session.getAttribute("InstCode") != null) {
                mIC = session.getAttribute("InstCode").toString().trim();
            } else {
                mIC = "";
            }
            if (session.getAttribute("Exam") != null) {
                mEC = session.getAttribute("Exam").toString().trim();
            } else {
                mEC = "";
            }
            if (session.getAttribute("Subject") != null) {
                mSC = session.getAttribute("Subject").toString().trim();
            } else {
                mSC = "";
            }
            if (session.getAttribute("listorder") != null) {
                mList = session.getAttribute("listorder").toString().trim();
            } else {
                mList = "EnrollNo";
            }
            if (session.getAttribute("order") != null) {
                mOrder = session.getAttribute("order").toString().trim();
            } else {
                mOrder = "";
            }
            if (session.getAttribute("Event") != null) {
                mEvent = session.getAttribute("Event").toString().trim();
            } else {
                mEvent = "";
            }
            len = mEvent.length();
            pos = mEvent.indexOf("#");
            if (pos > 0) {
                mSE = mEvent.substring(0, pos);
            } else {
                mSE = mEvent.toString().trim();
            }
%>
<HTML>
<head>
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../../IQAC/css/Style.css">
        <link rel="stylesheet" href="../../IQAC/css/jquery.multiselect.css"/>
        <link rel="stylesheet" href="../../IQAC/css/jquery-ui.css"/>
        <script src="../../IQAC/js/jquery/jquery-1.10.2.js"></script>
        <script src="../../IQAC/js/jquery/jquery-ui.js"></script>
        <script>
            $(document).ready(function() {
                
                getCommonMasterTable();
                
            });
           
        </script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>

    <%

                   String mSubcode1 = "", qrysub1 = "", mNam1 = "";
                    qrysub1 = "select subject,subjectcode from subjectmaster where InstituteCode='" + mIC + "' and subjectID='" + mSC + "' and nvl(deactive,'N')='N' ";
                    //System.out.println(qrysub);
                    rssub = db.getRowset(qrysub1);
                    if (rssub.next()) {
                        mNam1 = rssub.getString("subject");
                        mSubcode1 = rssub.getString("subjectcode");
                    }

%>

    &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;
    &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;
   
    &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;
    <b><font color='black' back size='3' style='font-family:arial;width:30%'>Exam Code       :- <%=mEC1%></font></b> &nbsp; &nbsp;&nbsp;&nbsp;<br>
     &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;
     &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;
    &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;
    <b><font color='black' size='3' style='font-family:arial;width:20%'>Subject Code:-  <%=mSubcode1%></font><b>&nbsp; &nbsp;&nbsp;&nbsp;
     <b><font color='black' size='3' style='font-family:arial;width:20%'>&nbsp;&nbsp; Subject:-  <%=mNam1%></font><b></b>

            <br>
             &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;
             &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;
    &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;
            <b><font color='black' size='3' style='font-family:arial;width:20%'>Event Code      :-  <%=mEvent%></font></b>
            <br>
           
    <table class="sort-table" id="TblStdView" rules='ALL' style="width:auto;" cellSpacing=0 cellPadding=0  align=center border=2 bordercolor="#8B4513">
         <br>
        <thead id="gridhead">
             <tr bgcolor='#c00000'><td ><b><font color='white' size='2' style='font-family:arial;width:20%'>Sno</font></td><td ><b><font color='white' size='2' style='font-family:arial;width:20%'>Enrollment No.</font></td><td ><b><font color='white' size='2' style='font-family:arial;width:20%'>Name</font></td><td ><b><font color='white' size='2' style='font-family:arial;width:20%'>Saved Marks</font></td><td ><b><font color='white' size='2' style='font-family:arial;width:20%'>Excel Marks</font></td></tr>
         </thead>
         <tbody id="gridbody" style="width:auto;">
            
<%
try
{

	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{
		mDMemberCode = enc.decode(mMemberCode);
                mDMemberType = enc.decode(mMemberType);
                String mCode = enc.decode(mMemberCode);
                String mChkMemID = enc.decode(session.getAttribute("MemberID").toString().trim());
                String mChkMType = enc.decode(session.getAttribute("MemberType").toString().trim());
                String mIPAddress = session.getAttribute("IPADD").toString().trim();
                String mRole = enc.decode(session.getAttribute("ROLENAME").toString().trim());
                ResultSet RsChk = null;

	
	     //-----------------------------
	     //-- Enable Security Page Level  
	     //-----------------------------
		
		

		qry="Select WEBKIOSK.ShowLink('60','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
		 String mSubcode = "", qrysub = "", mNam = "";
                    qrysub = "select subject,subjectcode from subjectmaster where InstituteCode='" + mIC + "' and subjectID='" + mSC + "' and nvl(deactive,'N')='N' ";
                    //System.out.println(qrysub);
                    rssub = db.getRowset(qrysub);
                    if (rssub.next()) {
                        mNam = rssub.getString("subject");
                        mSubcode = rssub.getString("subjectcode");
                    } else {
                        mNam = "";
                        mSubcode = "";
                    }
                    session.setAttribute("Newsubject", mNam);
                    session.setAttribute("Newsubjectcode", mSubcode);

                    String name = "", time = "";
                    String query123 = "select employeename,to_char(sysdate,'DD/MM/YYYY HH:MI:SS AM')dd from employeemaster where employeeid='" + mChkMemID + "'";
                    //out.println(query123);
                    rssub = db.getRowset(query123);
                    if (rssub.next()) {
                        name = rssub.getString("employeename");
                        time = rssub.getString("dd");
                    }
                    if (mSelf.equals("Self")) {
                        //---------------------Commemted as per deepak sir---------------------------------------//

                       /* qry = "select fstid,nvl(studentid,' ')studentid,nvl(studentname,' ')StudentName, nvl(enrollmentno,' ')EnrollNo, nvl(semester,0)Semester,";
                        qry = qry + " nvl(programcode,' ')||' ('||nvl(SECTIONBRANCH,' ')||' - '||subsectioncode||')' Course from V#EXAMEVENTSUBJECTTAGGING ";
                        qry = qry + " where institutecode='" + mIC + "' and nvl(DEACTIVE,'N')='N' and nvl(PROCEEDSECOND,'N')='N' and nvl(locked,'N')='N' and nvl(PUBLISHED,'N')='N' and ";
                        qry = qry + " examcode='" + mEC + "' and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P' ) and subjectID='" + mSC + "' ";
                        //qry=qry+" AND employeeid='"+mChkMemID+"' and facultytype=decode('"+mDMemberType+"','E','I','E')";
                        qry = qry + " AND ((EMPLOYEEID=(Select '" + mChkMemID + "' EmployeeID from dual)) OR (fstid in (select fstid from FACULTYSUBJECTTAGGING where companycode='" + mComp + "' and institutecode='" + mIC + "' and facultytype=decode('" + mDMemberType + "','E','I','E') and employeeid='" + mChkMemID + "')) and facultytype=decode('" + mDMemberType + "','E','I','E'))";
                        //qry=qry+" AND employeeid in (Select '"+mChkMemID+"' EmployeeID from dual UNION Select EmployeeID from FacultySubjectTagging where FSTID in (SELECT FSTID FROM MULTIFACULTYSUBJECTTAGGING WHERE COMPANYCODE='"+mComp+"' and INSTITUTECODE='"+mIC+"' and FACULTYTYPE=decode('"+mDMemberType+"','E','I','E') and EMPLOYEEID='"+mChkMemID+"')) and facultytype=decode('"+mDMemberType+"','E','I','E')";
                        qry = qry + " AND EVENTSUBEVENT='" + mEvent + "' ";
                        qry = qry + "  AND ( (studentid, fstid) IN (SELECT studentid, fstid FROM StudentEventSubjectMarks WHERE EVENTSUBEVENT = '"+mEvent+"'";
                        qry = qry + " AND NVL (DEACTIVE, 'N') = 'N' AND NVL (locked, 'N') = 'N') OR (studentid, fstid) NOT IN (SELECT studentid, fstid ";
                        qry = qry + " FROM StudentEventSubjectMarks WHERE EVENTSUBEVENT = '"+mEvent+"' AND NVL (DEACTIVE, 'N') = 'N' ";
                        qry = qry + " AND NVL (locked, 'N') = 'Y')) AND STUDENTID NOT IN (SELECT DISTINCT studentid FROM debarstudentdetail WHERE NVL (REEXAMINATION, 'N') = 'Y') ";
                        qry = qry + " GROUP BY fstid,studentid,StudentName,enrollmentno,Semester, programcode,SECTIONBRANCH, subsectioncode";
                        qry = qry + " order by " + mList + " " + mOrder + " ";  */

                       /* qry="SELECT fstid,NVL (studentid, ' ') studentid,NVL (studentname, ' ') StudentName,NVL (enrollmentno, ' ') EnrollNo,NVL (semester, 0) Semester,NVL (programcode, ' ')|| ' ('  || NVL (SECTIONBRANCH, ' ')|| ' - ' || subsectioncode || ')'";
                        qry=qry+" Course";
                        qry=qry+" FROM  V#EXAMEVENTSUBJECTTAGGING WHERE     institutecode = 'JIIT' AND NVL (DEACTIVE, 'N') = 'N' AND NVL (PROCEEDSECOND, 'N') = 'N' AND NVL (locked, 'N') = 'N' AND NVL (PUBLISHED, 'N') = 'N' AND examcode = '2015ODDSEM' AND (ltp = 'L' OR (LTP = 'E' AND PROJECTSUBJECT = 'Y') OR LTP = 'P')  AND subjectID = '150044'";
                        qry=qry+"AND ( (EMPLOYEEID = (SELECT 'UNIV-S00037' EmployeeID FROM DUAL)) OR (fstid IN (SELECT fstid FROM FACULTYSUBJECTTAGGING WHERE     companycode = 'UNIV'   AND institutecode = 'JIIT'   AND facultytype = DECODE ('E', 'E', 'I', 'E')    AND employeeid = 'UNIV-S00037'))   AND facultytype = DECODE ('E', 'E', 'I', 'E'))";
                        qry=qry+" AND ( (studentid, fstid) IN (SELECT studentid, fstid  FROM StudentEventSubjectMarks  WHERE   EVENTSUBEVENT = 'TEST-1' AND NVL (DEACTIVE, 'N') = 'N' ) OR (studentid, fstid) NOT IN  (SELECT studentid, fstid  FROM StudentEventSubjectMarks";
                        qry=qry+" WHERE     EVENTSUBEVENT = 'TEST-1'   AND NVL (DEACTIVE, 'N') = 'N'   ))  AND STUDENTID NOT IN (SELECT DISTINCT studentid FROM debarstudentdetail  WHERE NVL (REEXAMINATION, 'N') = 'Y')";
                        qry=qry+"GROUP BY fstid,studentid,  StudentName,  enrollmentno,  Semester,  programcode,  SECTIONBRANCH,  subsectioncode ORDER BY EnrollNo ASC"; */
                        //---------------------------------------Added by Satendra-----------------------//
                        qry="SELECT fstid,NVL (studentid, ' ') studentid,NVL (studentname, ' ') StudentName,NVL (enrollmentno, ' ') EnrollNo,NVL (semester, 0) Semester,NVL (programcode, ' ')|| ' ('  || NVL (SECTIONBRANCH, ' ')|| ' - ' || subsectioncode || ')'";
                        qry=qry+" Course";
                        qry=qry+" FROM  V#EXAMEVENTSUBJECTTAGGING WHERE     institutecode = '" + mIC + "' AND NVL (DEACTIVE, 'N') = 'N' AND NVL (PROCEEDSECOND, 'N') = 'N' AND NVL (locked, 'N') = 'N' AND NVL (PUBLISHED, 'N') = 'N' AND examcode ='" + mEC + "' AND (ltp = 'L' OR (LTP = 'E' AND PROJECTSUBJECT = 'Y') OR LTP = 'P')  AND subjectID = '" + mSC + "'";
                        qry=qry+"AND ( (EMPLOYEEID = (SELECT  '" + mChkMemID + "' EmployeeID FROM DUAL)) OR (fstid IN (SELECT fstid FROM FACULTYSUBJECTTAGGING WHERE     companycode ='" + mComp + "'  AND institutecode = '" + mIC + "' AND facultytype = DECODE ('" + mDMemberType + "', 'E', 'I', 'E')    AND employeeid = '" + mChkMemID + "'))   AND facultytype = DECODE ('" + mDMemberType + "', 'E', 'I', 'E'))";
                        qry=qry+" AND ( (studentid, fstid) IN (SELECT studentid, fstid  FROM StudentEventSubjectMarks  WHERE   EVENTSUBEVENT = '"+mEvent+"' AND NVL (DEACTIVE, 'N') = 'N' ) OR (studentid, fstid) NOT IN  (SELECT studentid, fstid  FROM StudentEventSubjectMarks";
                        qry=qry+" WHERE     EVENTSUBEVENT ='"+mEvent+"'  AND NVL (DEACTIVE, 'N') = 'N'   ))  AND STUDENTID NOT IN (SELECT DISTINCT studentid FROM debarstudentdetail  WHERE NVL (REEXAMINATION, 'N') = 'Y')";
                        qry=qry+"GROUP BY fstid,studentid,  StudentName,  enrollmentno,  Semester,  programcode,  SECTIONBRANCH,  subsectioncode ORDER BY " + mList + " " + mOrder + " ";

                        qry1 = "select WEIGHTAGE, MARKSORPERCENTAGE, MAXMARKS from V#EXAMEVENTSUBJECTTAGGING  ";
                        qry1 += " where institutecode='" + mIC + "' and  examcode='" + mEC + "' ";
                        qry1 += " AND ((EMPLOYEEID=(Select '" + mChkMemID + "' EmployeeID from dual)) OR (fstid in (select fstid from FACULTYSUBJECTTAGGING where companycode='" + mComp + "' and institutecode='" + mInst + "' and facultytype=decode('" + mDMemberType + "','E','I','E') and employeeid='" + mChkMemID + "')) and facultytype=decode('" + mDMemberType + "','E','I','E'))";
                        qry1 += " And EVENTSUBEVENT='" + mEvent + "' and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P') and subjectID='" + mSC + "' AND  NVL (deactive, 'N') = 'N' ";

                    } else if (!mSelf.equals("Self")) {
                        qry = "select fstid,nvl(studentid,' ')studentid,nvl(studentname,' ')StudentName, nvl(enrollmentno,' ')EnrollNo, nvl(semester,0)Semester,";
                        qry = qry + " nvl(programcode,' ')||' ('||nvl(SECTIONBRANCH,' ')||' - '||subsectioncode||')' Course from V#EXAMEVENTSUBJECTTAGGING ";
                        qry = qry + " where institutecode='" + mIC + "' and nvl(DEACTIVE,'N')='N' and nvl(PROCEEDSECOND,'N')='N' and nvl(locked,'N')='N' and nvl(PUBLISHED,'N')='N' and ";
                        qry = qry + " examcode='" + mEC + "'  and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P' ) and subjectID='" + mSC + "' ";
                        qry = qry + " And EVENTSUBEVENT='" + mEvent + "' ";
                        qry = qry + " AND FSTID IN (SELECT FSTID FROM EX#SUBJECTGRADECOORDINATOR WHERE COMPANYCODE='" + mComp + "' and INSTITUTECODE='" + mIC + "' and FACULTYTYPE=decode('" + mDMemberType + "','E','I','E') and FACULTYID='" + mChkMemID + "')";
                        qry = qry + " GROUP BY fstid,studentid,StudentName,enrollmentno,Semester, programcode,SECTIONBRANCH, subsectioncode";
                        qry = qry + " order by " + mList + " " + mOrder + " ";

                        qry1 = "select  WEIGHTAGE, MARKSORPERCENTAGE, MAXMARKS from V#EXAMEVENTSUBJECTTAGGING  ";
                        qry1 += " where institutecode='" + mIC + "' and  examcode='" + mEC + "' ";
                        qry1 += " And EVENTSUBEVENT='" + mEvent + "'  ";
                        qry1 += " and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P') and subjectID='" + mSC + "' AND  NVL (deactive, 'N') = 'N'";
                    }
                    //System.out.println(qry);
                    rsm = db.getRowset(qry1);
                    if (rsm.next()) {
                        mMOP = rsm.getString("MARKSORPERCENTAGE");
                        mMaxmarks = rsm.getDouble("MAXMARKS");
                        mWeight = rsm.getDouble("WEIGHTAGE");
                    }

                    rs = db.getRowset(qry);

                    while (rs.next()) {

                     
                        qry2 = "Select fstid,studentid,nvl(MARKSAWARDED1,-1)MARKSAWARDED1, ";
                        qry2 = qry2 + " nvl(DETAINED,'N') DETAINED from V#STUDENTEVENTSUBJECTMARKS ";
                        qry2 = qry2 + " where INSTITUTECODE='" + mIC + "' and EXAMCODE='" + mEC + "' and ";
                        qry2 = qry2 + " EVENTSUBEVENT='" + mEvent + "' and   ";
                        qry2 = qry2 + " fstid='" + rs.getString("fstid") + "' and STUDENTID='" + rs.getString("studentid") + "' ";
                        //  	System.out.print("JILIT - "+qry);
                        rs1 = db.getRowset(qry2);
                        if (rs1.next()) {
                            mSMarks = rs1.getString("MARKSAWARDED1");
                            if(mSMarks.equals("-1"))
                            {
                             mSMarks="A"; 
                            }
                            if (excelMarksArrayNew[counter].equals("-1.0"))
                            {
                                excelMarksArrayNew[counter] ="A";
                            }
                        }

                        %>
                          <%
                          if(!mSMarks.equals(excelMarksArrayNew[counter])){
                          %>
                         <tr bgcolor="white"> 
                        <td  style='width: 20%'><font size='2' style='font-family:arial'color="red"><%=sNo%></font></td>
                        <td  style='width: 20%'><font size='2' style='font-family:arial' color="red"><%=rs.getString("EnrollNo")%></font></td>
                        <td  style='width: 20%'><font size='2' style='font-family:arial' color="red"><%=rs.getString("StudentName")%></font></td>
                        <td  style='width: 20%'><font size='2' style='font-family:arial'color="red"><%=mSMarks%>&nbsp;*</font></td>
                        <td  style='width: 20%'><font size='2' style='font-family:arial' color="red"><%=excelMarksArrayNew[counter]%>&nbsp;*</font></td>
                       </tr>
                       <% }else{
                            %> 

                       <tr bgcolor="#F5DEB3">
                        <td  style='width: 20%'><font size='2' style='font-family:arial' color="black"><%=sNo%></font></td>
                        <td  style='width: 20%'><font size='2' style='font-family:arial' color="black"><%=rs.getString("EnrollNo")%></font></td>
                        <td  style='width: 20%'><font size='2' style='font-family:arial' color="black"><%=rs.getString("StudentName")%></font></td>
                        <td  style='width: 20%'><font size='2' style='font-family:arial'color="black"><%=mSMarks%></font></td>
                        <td  style='width: 20%'><font size='2' style='font-family:arial' color="black"><%=excelMarksArrayNew[counter]%></font></td>
                       </tr>
                       <%}
                        %>
                    <%
                    sNo++;
                        counter++;
                    }
	
                        
				%>
    
         
                 
<tr>
     
</tr>
              
         </tbody>
         </table>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                                <INPUT TYPE="button" name="Print" Value="Click to Print"  onClick="window.print();">
     <%
		

		 //-----------------------------
		  //-- Enable Security Page Level  
		  //-----------------------------


	    }
 	else
   	{
   %>
	<br>
	<font color=red>
	<h3><br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font>	<br>	<br>	<br>	<br> 
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
e.printStackTrace();
}
%>
</body>
</html>
<%} catch (Exception e) {
            e.printStackTrace();
        }
%>