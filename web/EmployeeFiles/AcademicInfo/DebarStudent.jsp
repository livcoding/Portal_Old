<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%
        DBHandler db = new DBHandler();
        ResultSet rs = null;
        ResultSet rs1 = null;
        ResultSet rs2 = null;
		String Checked="",qrydebar="";
		ResultSet rsdebar=null;
     
        GlobalFunctions gb = new GlobalFunctions();
        String qry = "";
        String qry2 = "";
        String qry1 = "", mLTP = "";
        long mSNo = 0, dt = 0;
        String mMemberID = "";
        String mDMemberID = "";
        String mMemberType = "";
        String mDMemberType = "";
        String mMemberCode = "";
        String mDMemberCode = "", mtime1 = "", mtime2 = "";
        String mMemberName = "";
        String mInstitute = "";
        String mExam = "", mSubject = "", mexam = "", mSubj = "", mGroup = "", TRCOLOR = "#F8F8F8", mcolor = "", mCode = "", mES = "", mSubj1 = "";
        String mSection = "", mSubsection = "", mName1 = "", mName2 = "", mName3 = "", mName4 = "", mName5 = "", mName6 = "", mName7 = "";
        String mSExam = "",mREGCONFIRMATIONDATE="";
        String mSES = "";
        String qryexam = "", qrysubj = "", qrysec = "";
        String mPrn = "N", qsysdate = "";
        String mDate = "", mType = "", mltp1 = "";
        String mRollno = "", mName = "", mradio1 = "";
        String mDTfrom = "";
        String mDTupto = "";
        int Ctr = 0, mDiffInDate = 0;
        int mFLAG=0;
        
        //*******Take QryPercAtt variable to double before it's the long data type 
        double QryPercAtt = 0;

        String mStudentid = "", mRightsID = "";
        String mInst = "", mComp = "", mSrcType = "H";
        if (session.getAttribute("InstituteCode") == null) {
            mInst = "";
        } else {
            mInst = session.getAttribute("InstituteCode").toString().trim();
        }
        mInstitute = mInst;
        if (session.getAttribute("CompanyCode") == null) {
            mComp = "";
        } else {
            mComp = session.getAttribute("CompanyCode").toString().trim();
        }


        if (session.getAttribute("MemberID") == null) {
            mMemberID = "";
        } else {
            mMemberID = session.getAttribute("MemberID").toString().trim();
        }


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
       
       // if (mSrcType.equals("H")) {
            mRightsID = "254";
       // }
        String mHead = "";
        if (session.getAttribute("PageHeading") != null && !session.getAttribute("PageHeading").equals("")) {
            mHead = session.getAttribute("PageHeading").toString().trim();
        } else {
            mHead = "JIIT ";
        }
%>
<HTML>
    <head>
        <TITLE>#### <%=mHead%> [ Debarr Students List] </TITLE>

        <script type="text/javascript" src="js/sortabletable.js"></script>
        <link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

        <script language="JavaScript" type ="text/javascript">
       	function AlertMe()
		{
			
			dd.twait.value='';
		}	

        </script>
        <script language=javascript>
			
	

            <!--
            function RefreshContents()
            {
                document.frm.x.value='ddd';
                document.frm.submit();
            }
            //-->
        </script>
      

       
        <script type="text/javascript" src="js/TimePicker.js"></script>
       

       
        <SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">
            function ChangeOptions(Exam,DataCombo,Subject)
            {
                // alert("in Function");
                removeAllOptions(Subject);
                var subj='?';
                var mflag=0;
                var ssec='?';
                for(i=0;i<DataCombo.options.length;i++)
                {
                    var v1;
                    var pos;
                    var exam;
                    var sc;
                    var len;
                    var otext;
                    var v1=DataCombo.options(i).value;
                    len= v1.length ;
                    pos=v1.indexOf('***');
                    exam=v1.substring(0,pos);
                    sc=v1.substring(pos+3,len);
                    if (exam==Exam)
                    { 	if(mflag==0)
                        {
                            subj=sc;
                            mflag=1;
                        }
                        var optn = document.createElement("OPTION");
                        optn.text=DataCombo.options(i).text;
                        optn.value=sc;

                        Subject.options.add(optn);
                    }
                }
                //alert("in Section");
                
			}
         



            function removeAllOptions(selectbox)
            {
                var i;
                for(i=selectbox.options.length-1;i>=0;i--)
                {
                    selectbox.remove(i);
                }
            }

        </SCRIPT>
        <script>
            if(window.history.forward(1) != null)
                window.history.forward(1);
        </script>
    </head>
    <body onload="AlertMe()" aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
        <%
        try {
            if (!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) {
                OLTEncryption enc = new OLTEncryption();
                mDMemberID = enc.decode(mMemberID);
                mDMemberCode = enc.decode(mMemberCode);
                mDMemberType = enc.decode(mMemberType);

                // out.print(mDMemberType);

                String mChkMemID = enc.decode(session.getAttribute("MemberID").toString().trim());
                String mChkMType = enc.decode(session.getAttribute("MemberType").toString().trim());
                String mIPAddress = session.getAttribute("IPADD").toString().trim();
                String mRole = enc.decode(session.getAttribute("ROLENAME").toString().trim());
                ResultSet RsChk = null;
                //-----------------------------
                //-- Enable Security Page Level
                //-----------------------------
                qry = "Select WEBKIOSK.ShowLink('" + mRightsID + "','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";
                //out.print(qry);
                RsChk = db.getRowset(qry);
                if (RsChk.next() && RsChk.getString("SL").equals("Y")) {

                    qry = "select to_Char(Sysdate,'dd-mm-yyyy') date1 from dual";

                    rs = db.getRowset(qry);

                    if (rs.next()) {
                        qsysdate = rs.getString(1);
                    } else {
                        qsysdate = "";
                    }

//out.print(mSrcType+"asas");
                    //----------------------
%>
        <form name="frm"  method="post">
            <input id="x" name="x" type=hidden><bR>
            <table align=center><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: Arial"><U><B>Debarr Student</b></U></font></TABLE>
            <table id=id2 cellpadding=1 cellspacing=1  align=center rules=groups border=2>
                <!--Institute****-->
                <Input Type=hidden name=InstCode Value=<%=mInstitute%>>
                <tr><td nowrap>
                        <FONT color=black face=Arial size=2><b>Exam Code</b></FONT>
                        <%
                    try {
                        qry = " Select Exam from (";
                        qry += " Select nvl(EXAMCODE,' ') Exam , EXAMPERIODFROM from EXAMMASTER Where INSTITUTECODE='" + mInst + "' AND";
                        qry += " nvl(Deactive,'N')='N' and Nvl(LOCKEXAM,'N')='N' and nvl(EXCLUDEINATTENDANCE,'N')='N' ";
                        qry += " and examcode in (Select examcode from facultysubjecttagging where fstid in (select fstid from studentattendance))";
                        //qry+=" and examcode in (select EXAMCODEFORATTENDNACEENTRY from COMPANYINSTITUTETAGGING Where InstituteCode='" + mInst + "' And CompanyCode='" + mComp + "') ";
                        qry += " order by EXAMPERIODFROM DESC";
                        qry += ") where rownum<8";
                        //out.print(qry);
                        rs = db.getRowset(qry);
                        if (request.getParameter("x") == null) {
                        %>
                        <Select Name=Exam tabindex="0" id="Exam" style="WIDTH: 120px" onclick="ChangeOptions(Exam.value,DataCombo,Subject);" onChange="ChangeOptions(Exam.value,DataCombo,Subject);">
                            <%
                                while (rs.next()) {
                                    mExam = rs.getString("Exam");
                                    if (mexam.equals("")) {
                                        mexam = mExam;
                                        qryexam = mExam;
                            %>
                            <OPTION Selected Value =<%=mExam%>><%=rs.getString("Exam")%></option>
                            <%
                                } else {
                            %>
                            <OPTION Value =<%=mExam%>><%=rs.getString("Exam")%></option>
                            <%

                                    }
                                }
                            %>
                        </select>
                        <%
                            } else {
                        %>
                        <select name=Exam tabindex="0" id="Exam" style="WIDTH: 120px" onclick="ChangeOptions(Exam.value,DataCombo,Subject);" onChange="ChangeOptions(Exam.value,DataCombo,Subject);">
                            <%
                                while (rs.next()) {
                                    mExam = rs.getString("Exam");
                                    if (mExam.equals(request.getParameter("Exam").toString().trim())) {
                                        mexam = mExam;
                                        qryexam = mExam;
                            %>
                            <OPTION selected Value =<%=mExam%>><%=rs.getString("Exam")%></option>
                            <%
                                } else {
                            %>
                            <OPTION Value =<%=mExam%>><%=rs.getString("Exam")%></option>
                            <%
                                    }
                                }
                            %>
                        </select>
                        <%
                        }
                    } catch (Exception e) {
                        // out.println("Error Msg");
                    }
                        %>
                        &nbsp;

                        <!--******************DataCombo for Subject   **************-->
<%
                    try {
                        
                        if (mSrcType.equals("A") || mSrcType.equals("H")) {
                            qry = "Select distinct nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
                            qry = qry + " from facultysubjecttagging A, SUBJECTMASTER B where A.SUBJECTID=B.SUBJECTID And a.INSTITUTECODE=b.INSTITUTECODE And a.INSTITUTECODE='" + mInst + "'  AND nvl(a.PROJECTSUBJECT,'N')='N' and A.FSTID in (select fstid from V#STUDENTATTENDANCE where nvl(deactive,'N')='N' and institutecode = '" + mInst + "' and EMPLOYEEID in (select Employeeid from EMPLOYEEMASTER where DEPARTMENTCODE in (select DEPARTMENTCODE from  hodlist where employeeid='"+mDMemberID+"' and institutecode = '" + mInst + "' and  nvl(deactive,'N')='N')) ) order by subject asc";
                        }
                       // out.print(qry);
                        rs = db.getRowset(qry);


                        if (request.getParameter("x") == null) {
                        %>
                        <Select Name=DataCombo id="DataCombo" style="WIDTH:0px">
                            <%
                        while (rs.next()) {
                            mExam = rs.getString("subjectid");
                            mCode = rs.getString("examcode");
                            mES = mCode + "***" + mExam;
                            %>
                            <OPTION Value=<%=mES%>><%=rs.getString("subject")%></option>
                            <%
                        }
                            %>
                        </select>
                        <%
                    } else {
                        %>
                        <Select Name=DataCombo id="DataCombo" style="WIDTH:0px">
                            <%
                        while (rs.next()) {
                            mExam = rs.getString("subjectid");
                            mCode = rs.getString("examcode");
                            mES = mCode + "***" + mExam;

                            if (mExam.equals(request.getParameter("DataCombo").toString().trim())) {
                            %>
                            <OPTION selected Value=<%=mES%>><%=rs.getString("subject")%></option>
                            <%
                                } else {
                            %>
                            <OPTION Value=<%=mES%>><%=rs.getString("subject")%></option>
                            <%
                            }
                        }
                            %>
                        </select>
                        <%
                        }
                    } catch (Exception e) {
                        // out.println("Error Msg");
                    }
                    //----***************Subject**********************
%>

                        <FONT color=black face=Arial size=2><b>Subject</b>&nbsp;  </FONT>
                        <%
                    if (mSrcType.equals("A") || mSrcType.equals("H")) {

                        qry = "Select distinct nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
                        qry = qry + " from facultysubjecttagging A, SUBJECTMASTER B where A.SUBJECTID=B.SUBJECTID And a.INSTITUTECODE=b.INSTITUTECODE And a.INSTITUTECODE='" + mInst + "' and A.EXAMCODE='" + qryexam + "' AND nvl(a.PROJECTSUBJECT,'N')='N' and A.FSTID in (select fstid from V#STUDENTATTENDANCE where examcode='" + qryexam + "' and institutecode = '" + mInst + "' and nvl(deactive,'N')='N' and EMPLOYEEID in (select Employeeid from EMPLOYEEMASTER where DEPARTMENTCODE in (select DEPARTMENTCODE from  hodlist where employeeid='"+mDMemberID+"' and institutecode = '" + mInst + "' and nvl(deactive,'N')='N')) ) order by subject asc";
                    }
                    // out.print(qry);
                    rs = db.getRowset(qry);


                        %>
                        <select name=Subject tabindex="0" id="Subject" >
                            <%
                    if (request.getParameter("x") == null) {
                        while (rs.next()) {
                            if (mSubj1.equals("")) {
                                mSubj1 = rs.getString("subjectid");
                                qrysubj = mSubj1;
                            %>
                            <OPTION selected Value ='<%=mSubj1%>'><%=rs.getString("subject")%></option>
                            <%
                                    } else {
                            %>
                            <OPTION Value ='<%=rs.getString("subjectid")%>'><%=rs.getString("subject")%></option>
                            <%
                                    }
                                }
                            } else {
                                while (rs.next()) {
                                    mSubj1 = rs.getString("subjectid");
                                    if (mSubj1.equals(request.getParameter("Subject").toString().trim())) {
                                        qrysubj = mSubj1;
                            %>
                            <OPTION selected Value ='<%=mSubj1%>'><%=rs.getString("subject")%></option>
                            <%
                            } else {
                            %>
                            <OPTION Value ='<%=mSubj1%>'><%=rs.getString("subject")%></option>
                            <%
                            }
                        }
                    }
                            %>
                </select>
                &nbsp;
              <br><Br>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<INPUT Type="submit" Value="Show/Refresh"></td></tr>

            </table>
        </form>
		
<form name="dd" id="dd">
<center>
<input style="width:200px;font-size:20px; 
	color:red;font-weight:bold;BORDER-LEFT: c00000 0px solid;BORDER-TOP: c00000 0px solid;
	BORDER-RIGHT: c00000 0px solid;BORDER-BOTTOM: c00000 0px solid ; background-color:transparent"  name="twait" readonly id="twait" type="text" value="Please Wait.......">
</center>
</form>
        <%

                    if (request.getParameter("x") != null) {
                        mExam = request.getParameter("Exam").toString().trim();

                        mSubject = request.getParameter("Subject").toString().trim();

String FSTID="";
                        //out.print(mExam+" "+mSubject+" "+mLTP+" "+mSection+" "+mSubsection);
%>
		

        <form name="frm1"  method="post" action="DebarStudentAction.jsp">
		<input type="hidden" name="Exam" id="Exam" value="<%=mExam%>">
		<input type="hidden" name="SubjectID" id="SubjectID" value="<%=mSubject%>">
            <table bgcolor=#fce9c5 class="sort-table" id="table-1" width='90%' bottommargin=0 rules=rows topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center>
                <thead>
                    <tr bgcolor="#ff8c00">
                        <td rowspan=2 Title="Sort on SlNo"><font color="White" size=2><b>Sr.<br>No.</b></font></td>
                        <td rowspan=2 Title="Sort on Enrollment No" nowrap><font color="White" size=2><b>Roll No.</b></font></td>
                        <td rowspan=2 Title="Class Student Name"><font color="White" size=2><b>Name</b></font></td>
                        <td rowspan=2 Title="Sort on Section/Subsection"><font color="White" size=2><b>Section<br>(SubSec.)</b></font></td>
                       
                        <td Title="Click To Debarr Student" align="center" nowrap><font color="White" size=2><b>Click To Debarr Student</b></font></td>
                    </tr>
                 
                </thead>
                <tbody>
                    <%
                                                     
						
							 qry="SELECT DISTINCT NVL (a.enrollmentno, ' ') enrollmentno,                NVL (a.studentname, ' ') studentname,                NVL (a.studentid, ' ') studentid,                   NVL (a.sectionbranch, ' ')  || '('  || a.subsectioncode                || ')' sectionbranch,                NVL (b.semester, 1) semester,                TO_CHAR (regconfirmationdate, 'DD-MM-YY') regconfirmationdate,                a.sectionbranch secbr, a.subsectioncode, a.semestertype ,a.FSTID  FSTID         FROM v#studentltpdetail a,                studentregistration b,                 studentmaster d          WHERE  a.LTP in ('L','P') and          a.studentid = d.studentid            AND NVL (d.deactive, 'N') = 'N'            AND b.institutecode = a.institutecode            AND b.examcode = a.examcode            AND b.examcode = '"+mExam+"'            AND a.examcode = '"+mExam+"'            AND b.academicyear = a.academicyear            AND b.studentid = a.studentid            AND a.institutecode = '"+mInst+"'            AND a.subjectid = '" + mSubject + "'            AND a.examcode = '"+mExam+"'               AND NVL(a.STUDENTDEACTIVE , 'N') = 'N' AND NVL (a.DEACTIVE , 'N') = 'N'                ORDER BY enrollmentno";
						//	 out.print(qry);
                            rs1 = db.getRowset(qry);
							//int SrNo=0;
                            while (rs1.next()) {
                                Ctr++;
                               
                                    TRCOLOR = "White";
                                
								mStudentid= rs1.getString("studentid").toString().trim();
                                mRollno = rs1.getString("enrollmentno").toString().trim();
                                mName = rs1.getString("studentname").toString().trim();
								FSTID= rs1.getString("fstid").toString().trim();
                                
								qrydebar="SELECT 'Y' FROM DEBARSTUDENTDETAIL WHERE INSTITUTECODE ='"+ mInst +"'   and STUDENTID='"+mStudentid+"'  AND EXAMCODE='"+mExam+"'   AND  SUBJECTID='"+mSubject+"'     AND NVL(REGISTEREDSTATUS,'N')='N'";
								//out.print(qrydebar);
								rsdebar=db.getRowset(qrydebar);
								if(rsdebar.next())
								{
									mFLAG=1;
								}
														
								if(mFLAG==1)
								{ 
									Checked="checked ";
								}
								else
								{
									Checked=" ";
								}
								

													
                    %>
                    <tr bgcolor=<%=TRCOLOR%>>
                        <td><%=Ctr%>.</td>
                        <td><%=mRollno%></td>
                        <td nowrap><%=GlobalFunctions.toTtitleCase(mName)%></td>
                        <td><%=rs1.getString("sectionbranch")%></td>
						<td ALIGN=CENTER>&nbsp;  <INPUT TYPE="checkbox" NAME="Checked<%=Ctr%>" <%=Checked%> id="Checked" Title="Click To Debarr Student"></TD></td>
          
					
					<input type="hidden" name="mStudentid<%=Ctr%>" id="mStudentid<%=Ctr%>" value="<%=mStudentid%>">
					<input type="hidden" name="FSTID<%=Ctr%>" id="FSTID<%=Ctr%>" value="<%=FSTID%>">
                    </tr>

                    <%mFLAG=0;
                            }
                    %>
                    
                   
                </tbody>
            </table>
			<input type="hidden" name="Ctr" id="Ctr" value="<%=Ctr%>">

            <script type="text/javascript">
                var st1 = new SortableTable(document.getElementById("table-1"),["Number", "Number", "CaseInsensitiveString"]);
            </script>
            <table align=center bgcolor=white width=90% cellmargin=0 bottommargin=0 border=1>
                <tr>
                    <td align=right>
					<INPUT TYPE="submit" value="Save Debarr Student"> 
					</td>
                </tr>
            </table>
        </form>
        <%
                    }
                //-----------------------------
                //---Enable Security Page Level
                //-----------------------------
                } else {
        %>
        <br>
        <font color=red>
            <h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
            <P>	This page is not authorized/available for you.
            <br>For assistance, contact your network support team.
        </font>	<br>	<br>	<br>	<br>
        <%                }
            //-----------------------------
            } else {
                out.print("<br><img src='../../Images/Error1.jpg'>");
                out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
            }
        } catch (Exception e) {
       
        }
        %>
    </body>
</html>