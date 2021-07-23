<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Debarr Students  ] </TITLE>
  <script type="text/javascript" src="js/sortabletable.js"></script>
        <link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<%
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
OLTEncryption enc=new OLTEncryption();
String qry="",mWebEmail="";
String qry1="";
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
int n=0;
ResultSet rs=null,rs1=null,RsChk1=null;
String mSID="", Remarks=" ";
String mName1="",mName2="",mName3="",mName4="",mName5="",mName6="", mName7="";
String mSelf="", mINSTITUTECODE="",mInst="";
String mFstid="", mDate="", mType="", mStudentID="";
String mPresent="", mAbsent="";
int yy=0, mTotalRec=0, Ctr=0;
String Date="", Type="";	
String mEmployeeid="";
String mTfrom="", mTupto="";
String mRollno="", mSno="";

				ResultSet rsdebar=null;
				String qrydebar="";
		
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

   if (session.getAttribute("InstituteCode") == null) {
            mInst = "";
        } else {
            mInst = session.getAttribute("InstituteCode").toString().trim();
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

      qry="Select WEBKIOSK.ShowLink('254','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      
      RsChk= db.getRowset(qry);
      if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
	   //----------------------
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
	try
	{	
		mDMemberCode=enc.decode(mMemberCode);
		mMemberID=enc.decode(mMemberID);
		mMemberType=enc.decode(mMemberType);
	}
	catch(Exception e)
	{
		out.println(e.getMessage());
	}
	
String Exam="", SubjectID="",mStudentid="",FSTID="";

if(request.getParameter("SubjectID")==null)
	SubjectID="";
else
	SubjectID=request.getParameter("SubjectID");


if(request.getParameter("Exam")==null)
	Exam="";
else
	Exam=request.getParameter("Exam");

	if (request.getParameter("Ctr")!=null && Integer.parseInt(request.getParameter("Ctr").toString().trim())>0)
	{ 	//3
		mTotalRec=Integer.parseInt(request.getParameter("Ctr").toString().trim());
		
		
		
		for (yy=1;yy<=mTotalRec;yy++)
		{  			
			
			if(request.getParameter("Checked"+yy)==null)
			{
				mStudentid="N";
			}
			else
			{
				mStudentid=request.getParameter("mStudentid"+yy);
				FSTID=request.getParameter("FSTID"+yy);
			}
			
			if(!mStudentid.equals("N"))
			{
				qrydebar="SELECT 'Y' FROM DEBARSTUDENTDETAIL WHERE INSTITUTECODE ='"+ mInst +"'   and STUDENTID='"+mStudentid+"'  AND EXAMCODE='"+Exam+"'   AND  SUBJECTID='"+SubjectID+"'     AND NVL(REGISTEREDSTATUS,'N')='N'";
				//out.print(qrydebar);
				rsdebar=db.getRowset(qrydebar);
				if(!rsdebar.next())
				{
				qry="INSERT INTO DEBARSTUDENTDETAIL ( INSTITUTECODE, EXAMCODE, FSTID,  STUDENTID, SUBJECTID, DEBAR,     ENTRYDATE, ENTRYBY) VALUES ( '"+mInst+"','"+Exam+"' ,'"+FSTID+"' ,'"+mStudentid+"','"+SubjectID+"' , 'Y',sysdate   ,'"+mMemberID+"' )";
				//out.print(qry);
				int a=db.insertRow(qry);
				}
							
					
			}
				
		}
	String mName ="",Subject="",SubjectCode="";

qry="select subject,subjectcode from subjectmaster where subjectid='"+SubjectID+"' and institutecode='"+mInst+"' ";
rs=db.getRowset(qry);
if(rs.next())
		{
	Subject=rs.getString("subject");
	SubjectCode=rs.getString("subjectcode");
		}
%>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<center><Br><font size=4 color=arial face=arial >Debarr 
Students List for Subject <br>
<%=Subject%> - <%=SubjectCode%>
</font></center>
<hr>
 <table bgcolor=#fce9c5 class="sort-table" id="table-1" width='90%' bottommargin=0 rules=rows topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center>
                <thead>
                    <tr bgcolor="#ff8c00">
                        <td rowspan=2 Title="Sort on SlNo"><font color="White" size=2><b>Sr.<br>No.</b></font></td>
                        <td rowspan=2 Title="Sort on Enrollment No" nowrap><font color="White" size=2><b>Roll No.</b></font></td>
                        <td rowspan=2 Title="Class Student Name"><font color="White" size=2><b>Name</b></font></td>
                        <td rowspan=2 Title="Sort on Section/Subsection"><font color="White" size=2><b>Section<br>(SubSec.)</b></font></td>
                       
                        <td Title="Debarr Student" align="center" nowrap><font color="White" size=2><b>Debarr Student</b></font></td>
                    </tr>
                 
                </thead>
                <tbody>
				<%
				 qry="SELECT DISTINCT NVL (a.enrollmentno, ' ') enrollmentno,                NVL (a.studentname, ' ') studentname,                NVL (a.studentid, ' ') studentid,                   NVL (a.sectionbranch, ' ')  || '('  || a.subsectioncode                || ')' sectionbranch,                NVL (b.semester, 1) semester,                TO_CHAR (regconfirmationdate, 'DD-MM-YY') regconfirmationdate,                a.sectionbranch secbr, a.subsectioncode, a.semestertype ,a.FSTID  FSTID         FROM v#studentltpdetail a,                studentregistration b,                 studentmaster d          WHERE       a.LTP in ('L','P') and       a.studentid = d.studentid            AND NVL (d.deactive, 'N') = 'N'            AND b.institutecode = a.institutecode            AND b.examcode = a.examcode            AND b.examcode = '"+Exam+"'            AND a.examcode = '"+Exam+"'            AND b.academicyear = a.academicyear            AND b.studentid = a.studentid            AND a.institutecode = '"+mInst+"'            AND a.subjectid = '" + SubjectID + "'            AND a.examcode = '"+Exam+"'               AND NVL(a.STUDENTDEACTIVE , 'N') = 'N' AND NVL (a.DEACTIVE , 'N') = 'N'  and a.Studentid in(select studentid from DEBARSTUDENTDETAIL where institutecode = '"+mInst+"' and  examcode = '"+Exam+"' and subjectid = '" + SubjectID + "'     )              ORDER BY enrollmentno";
						//	 out.print(qry);
                            rs1 = db.getRowset(qry);
							//int SrNo=0;
                            while (rs1.next()) {

                                Ctr++;

                                mRollno = rs1.getString("enrollmentno").toString().trim();
                                mName = rs1.getString("studentname").toString().trim();
								 %>
						 <tr bgcolor="White">
						 <td><%=Ctr%>.</td>
                        <td><%=mRollno%></td>
                        <td nowrap><%=GlobalFunctions.toTtitleCase(mName)%></td>
                        <td><%=rs1.getString("sectionbranch")%></td>
						<td ALIGN=CENTER>&nbsp;<font color=red>  Debarr Student </font> </TD></td>
          					
					            </tr>

                    <%
							}
								%>
	</table>
	<center><input type="button" id="btnPrint" onclick="window.print();" value="Click To Print"/></center>
<%
	
	} //3
	else
	{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" <b><font size=3 face='Arial' color='Red'>Please Click to Debarr Student!</font>&nbsp; &nbsp; <br> ");
	//out.print("<p><a href=DailyStudentAttendanceEntry.jsp><img src='../../Images/Back.jpg' border=0 ></a></p>");  

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
	<h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font>	<br>	<br>	<br>	<br>
   <%
	
	
   }
  //-----------------------------

}  //2
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
}	//1	
catch(Exception e)
{
	//out.print("No Item Selected..."+qry);
//	out.println(e.getMessage());
}
%>

</body>
</html>
