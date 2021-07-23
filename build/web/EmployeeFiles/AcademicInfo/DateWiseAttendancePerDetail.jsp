<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%
        DBHandler db = new DBHandler();


        ResultSet rst = null,rsc=null;

        ResultSet rs1 = null,rs2=null;

        String qry = "",mSUBJECT="", mSUBB = "", mTNOOFCLASS="",mSUBN = "", mLTP = "",qrys="";
        String qryt = "",qryc="";
        GlobalFunctions gb = new GlobalFunctions();
 
        String mEXAMCODE = "", mSubjectcode="", mFLAG = "", mSubjID = "", DataSublist = "";
        String mInstCode = "";
		int rsum80t1=0,rsum80t2=0,rsum80t3=0,ssum70t1=0,ssum70t2=0,ssum70t3=0,tsum60t1=0,tsum60t2=0,tsum60t3=0,
					usum50t1=0,usum50t2=0,usum50t3=0,vsum40t1=0,vsum40t2=0,vsum40t3=0,wsum30t1=0,wsum30t2=0,wsum30t3=0;


					
int ttsum1=0,ttsum2=0,ttsum3=0;

        String mInst = "", mSubject = "", minst = "";
        int count = 0, Flag = 0;
        if (session.getAttribute("InstituteCode") == null) {
            mInst = "";
        }else {
            mInst = session.getAttribute("InstituteCode").toString().trim();
        }

%>
<HTML>
    <head>
        <TITLE>#### JIIT [ Attendance PercentageWise BreakUp Detail]</TITLE>


        <script language=javascript>
    
            function RefreshContents()
            {
                document.frm.x.value='ddd';
                document.frm.submit();
            }
            //-->
        </script>
   
        <script>
            if(window.history.forward(1) != null)
                window.history.forward(1);
        </script>
        <script type="text/javascript" src="../js/sortabletable.js"></script>
        <link type="text/css" rel="StyleSheet" href="../css/sortabletable.css" />

    </head>
    <body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >

        <table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
            <tr><td colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><FONT SIZE="4" COLOR=""><B>Student Attendance Date wise Percentage wise Breakup Detail </B></FONT>
                        <!-- <BR><img src="images/ornament.gif" width="474" height="11" alt="" /> -->
            </font></td></tr>
        </table>

        <%

            if (request.getParameter("INSTITUTE") == null) {
                mInstCode = "";
            } else {
                mInstCode = request.getParameter("INSTITUTE").toString().trim();
            }
            if (request.getParameter("LTP") == null) {
                mLTP = "";
            } else {
                mLTP = request.getParameter("LTP").toString().trim();
            }
            if (request.getParameter("FLAG") == null) {
                mFLAG = "";
            } else {
                mFLAG = request.getParameter("FLAG").toString().trim();
            }


         if (request.getParameter("TNOOFCLASS") == null) {
                mTNOOFCLASS = "";
            } else {
                mTNOOFCLASS = request.getParameter("TNOOFCLASS").toString().trim();
            }

            int iFLAG = java.lang.Integer.parseInt(mFLAG);

            if (request.getParameter("SUBJECTCODE") == null) {
                mSubjectcode = "";
            } else {
                mSubjectcode = request.getParameter("SUBJECTCODE").toString().trim();
            }

String mDate1="",mDate2="",mDate3="",SUBJECTID="";

 if (request.getParameter("SUBJECTID") == null) {
                SUBJECTID = "";
            } else {
                SUBJECTID = request.getParameter("SUBJECTID").toString().trim();
            }


 if (request.getParameter("Date1") == null) {
                mDate1 = "";
            } else {
                mDate1 = request.getParameter("Date1").toString().trim();
            }


			 if (request.getParameter("Date2") == null) {
                mDate2 = "";
            } else {
                mDate2 = request.getParameter("Date2").toString().trim();
            }


            if (request.getParameter("Date3") == null) {
                mDate3 = "";
            } else {
                mDate3 = request.getParameter("Date3").toString().trim();
            }





            String mPROG[] = {"ALL"};

            mPROG = request.getParameterValues("PROGRAMCODE");



                      try {
                          if (mPROG.equals("") || mPROG == null) {
                              mPROG[0] = "ALL";
                              mSubject = "ALL";
                          }
                          for (int i = 0; i < mPROG.length; i++) {
                              if (mSubject.equals("")) {
                                  mSubject = "" + mPROG[i] + "";
                                 } else {
                                  mSubject = mSubject + "," + mPROG[i] + "";
                                 }
                          }
                      } catch (Exception e) {
                          mSubject = "ALL";
                      }
                      if (mSubject.indexOf("ALL") > 0) {
                          mSubject = "ALL";
                      }


            if (request.getParameter("SUBJECT") == null) {
                          mSUBJECT = "";
                      } else {
                          mSUBJECT = request.getParameter("SUBJECT").toString().trim();
                      }

				String SUBCODE="";


                      if (request.getParameter("EXAMCODE") == null) {
                          mEXAMCODE = "";
                      } else {
                          mEXAMCODE = request.getParameter("EXAMCODE").toString().trim();
                      }

                      %>
       
				  <br>
				 
<table class="sort-table" id="table-1" border=1 cellpadding=0 cellspacing=0 align=center>
		<thead>
				  <tr bgcolor="#ff8c00">
				  <td rowspan=2><b><font color="white">Sr.no.</font></b></td>
                  <td rowspan=2 align=center><b><font color="white" SIZE=1>Subject</font></b></td>
				       <td rowspan=2 align=center><b><font color="white" SIZE=1>Program</font></b></td>
				   <td rowspan=2><b><font color="white" SIZE=1>Sub-<BR>section</font></b></td>
				  <td rowspan=2><b><font color="white" SIZE=1>Employee Name</font></b></td>				
				  <td align=LEFT COLSPAN=3  ><b><font color="white" SIZE=1>
					 80				  </td>
                  <td align=LEFT COLSPAN=3 ><b><font color="white" SIZE=1>
				  70</font></b></td>
                  <td align=LEFT COLSPAN=3  ><b><font color="white" SIZE=1>
				  60</font></b></td>
                  <td align=LEFT COLSPAN=3 ><b><font color="white" SIZE=1>
				  50</font></b></td>
                  <td align=LEFT COLSPAN=3  ><b><font color="white" SIZE=1>
				  40</font></b></td>
                  <td align=LEFT COLSPAN=3 ><b><font color="white" SIZE=1>
				  30</font></b></td>
                  <td align=LEFT  rowspan=2  ><b><font color="white" SIZE=1 >Total <br>Student</font></b></td>
			
				  <td rowspan=2><b><font color="white" SIZE=1>Classes <br>Held <b>(<%=mLTP%>)</b></font></b></td>
				
                  </tr>

					 <tr bgcolor="#ff8c00">
					
											
												
												<td><font color="white" SIZE=1> T1 </td>
												<td><font color="white" SIZE=1>T2 </td>
												<td><font color="white" SIZE=1>T3 </td>

												<td><font color="white" SIZE=1> T1 </td>
												<td><font color="white" SIZE=1>T2 </td>
												<td><font color="white" SIZE=1>T3 </td>
													
												<td><font color="white" SIZE=1> T1 </td>
												<td><font color="white" SIZE=1>T2 </td>
												<td><font color="white" SIZE=1>T3 </td>

												<td><font color="white" SIZE=1> T1 </td>
												<td><font color="white" SIZE=1>T2 </td>
												<td><font color="white" SIZE=1>T3 </td>

												<td><font color="white" SIZE=1> T1 </td>
												<td><font color="white" SIZE=1>T2 </td>
												<td><font color="white" SIZE=1>T3 </td>

												<td><font color="white" SIZE=1> T1 </td>
												<td><font color="white" SIZE=1>T2 </td>
												<td><font color="white" SIZE=1>T3 </td>

					
										
					</tr>

				  </thead>
				  <tbody>
				  <!-- <tr>-->
                  <%

String qryx="",mEmpID="",mEmpNAME="",mprog1="",mSemType="";
	ResultSet rsx=null;


try{

			qry="select distinct  SEMESTERTYPE,INSTITUTECODE ,EXAMCODE , SUBJECTID,SUBJECTCODE,SUBSECTIONCODE,Subject,EMPLOYEEID,EMPLOYEENAME,programcode from V#StudentAttendance a Where a.subjectid='"+SUBJECTID+"' and a.LTP in ("+mLTP+")  and nvl(Studentdeactive,'N')='N'  ";
			if (!mInstCode.equals("ALL")) {
					qry = qry + " and  a.institutecode='" + mInstCode + "' ";
			}
			if (!mEXAMCODE.equals("ALL")) {
					qry = qry + "and  a.examcode='" + mEXAMCODE + "' ";
			}
			if(mSubject.equals("ALL"))
            qry=qry+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
            else
            qry=qry+" and a.programcode in ("+mSubject+")  " ;
			
			qry=qry+" group by SEMESTERTYPE, institutecode , examcode,SUBJECTCODE,SUBSECTIONCODE,Subject,SUBJECTID,EMPLOYEEID,EMPLOYEENAME,programcode order by SUBSECTIONCODE" ;
			rs1=db.getRowset(qry);
	//out.print(qry);
			//if(rs1.getString("SUBJECTCODE").equals("10B11CI401"))
			while (rs1.next())      
			{ 		

	mSemType=rs1.getString("SEMESTERTYPE");

mEmpID=rs1.getString("EMPLOYEEID");

mEmpNAME=rs1.getString("EMPLOYEENAME");

mprog1=rs1.getString("PROGRAMCODE");

//--------- TOTAL CLASSES-------------------

qryx=" select count(distinct CLASSTIMEFROM)totcalsses1 from V#StudentAttendance a Where    a.LTP in ("+mLTP+") AND A.SEMESTERTYPE='"+mSemType+"' and subjectid='" +rs1.getString("SUBJECTID")+ "' and  SUBSECTIONCODE='" +rs1.getString("SUBSECTIONCODE")+ "' and a.institutecode='" +rs1.getString("institutecode")+ "' and EMPLOYEEID='"+mEmpID+"' and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";	
			if(mSubject.equals("ALL"))
            qryx=qryx+"  and a.programcode = '"+mprog1+"'  " ;
            else
            qryx=qryx+"  and a.programcode in ("+mSubject+")   " ;
			qryx=qryx+"and nvl(Studentdeactive,'N')='N' and  nvl(a.deactive,'N')='N' and attendancetype in ('E','R') AND A.SEMESTERTYPE='REG' ";
			rsx=db.getRowset(qryx);
	//	out.print(qryx);
			int TotalClassCount=0  ;

			
			while (rsx.next())      
			{ 
		 		
				TotalClassCount=rsx.getInt("totcalsses1");
				//TotalClassCount;
			}

//---------------------------------------------------------------



//------------------------------------------------------


			qryt=" select distinct count(distinct studentid) totstudents1 from V#StudentAttendance a Where    a.LTP in ("+mLTP+") AND A.SEMESTERTYPE='"+mSemType+"' and subjectid='" +rs1.getString("SUBJECTID")+ "' and  SUBSECTIONCODE='" +rs1.getString("SUBSECTIONCODE")+ "'   and a.institutecode='" +rs1.getString("institutecode")+ "' and EMPLOYEEID='"+mEmpID+"' and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";	
		//	qryt=qryt+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('','dd-mm-yyyy')))";
		//			qryt=qryt+" and trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy'))) ";			
			if(mSubject.equals("ALL"))
            qryt=qryt+"  and a.programcode = '"+mprog1+"'  " ;
            else
            qryt=qryt+"  and a.programcode in ("+mSubject+")   " ;
			
			qryt=qryt+"and nvl(a.Studentdeactive,'N')='N' and  nvl(a.deactive,'N')='N' and a.attendancetype in ('E','R') ";
			rst=db.getRowset(qryt);
			
		//out.print(qryt);
			int TotalStud1=0  ;
			while (rst.next())      
			{ 
		 		
			
					TotalStud1=rst.getInt("totstudents1");
						
//out.print(TotalStud1+"TotalStud1");

		//				if(TotalStud1!=0)
				//		TotalStud1++;
				
			}
/*

qryt=" select count(distinct studentid) totstudents2 from V#StudentAttendance a Where    a.LTP in ("+mLTP+") AND A.SEMESTERTYPE='"+mSemType+"' and subjectid='" +rs1.getString("SUBJECTID")+ "'  and  SUBSECTIONCODE='" +rs1.getString("SUBSECTIONCODE")+ "'  and a.institutecode='" +rs1.getString("institutecode")+ "'  and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";	
			qryt=qryt+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('','dd-mm-yyyy')))";
					qryt=qryt+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy'))) ";			
			if(mSubject.equals("ALL"))
            qryt=qryt+"  and a.programcode = '"+mprog1+"'  " ;
            else
            qryt=qryt+"  and a.programcode in ("+mSubject+")   " ;
			
			qryt=qryt+"and nvl(Studentdeactive,'N')='N' and attendancetype in ('E','R') ";
			rst=db.getRowset(qryt);
		//	out.print(qryt);
			int TotalStud2=0  ;
			while (rst.next())      
			{ 
		 		
			
					TotalStud2=rst.getInt("totstudents2");

					//	if(TotalStud2!=0)
					//	TotalStud2++;
			}



qryt=" select count(distinct studentid) totstudents3 from V#StudentAttendance a Where    a.LTP in ("+mLTP+") AND A.SEMESTERTYPE='"+mSemType+"' and subjectid='" +rs1.getString("SUBJECTID")+ "'   and  SUBSECTIONCODE='" +rs1.getString("SUBSECTIONCODE")+ "' and a.institutecode='" +rs1.getString("institutecode")+ "'  and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";	
			qryt=qryt+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('','dd-mm-yyyy')))";
					qryt=qryt+" and trunc(decode(to_date('"+mDate3+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate3+"','dd-mm-yyyy'))) ";			
			if(mSubject.equals("ALL"))
            qryt=qryt+"  and a.programcode = '"+mprog1+"'  " ;
            else
            qryt=qryt+"  and a.programcode in ("+mSubject+")   " ;
			
			qryt=qryt+" and nvl(Studentdeactive,'N')='N' and attendancetype in ('E','R') ";
			rst=db.getRowset(qryt);
		//	out.print(qryt);
			int TotalStud3=0  ;
			while (rst.next())      
			{ 
		 		
			
					TotalStud3=rst.getInt("totstudents3");
					

				//	if(TotalStud3!=0)
					//	TotalStud3++;
				
			}
*/

//---------------------------------------------------------------------------------------------------------------------------

//---------------------------------------------------------------------------------------------------------------------------

			
			qrys="select distinct institutecode , examcode,SUBJECTCODE,Subject,SUBJECTID, count(distinct CLASSTIMEFROM) totcalsses from V#StudentAttendance a Where     a.LTP in ("+mLTP+") AND A.SEMESTERTYPE='"+mSemType+"' and  SUBSECTIONCODE='" +rs1.getString("SUBSECTIONCODE")+ "' and subjectid='" +rs1.getString("SUBJECTID")+ "'    and a.institutecode='" +rs1.getString("institutecode")+ "'  and a.examcode='" +rs1.getString("EXAMCODE")+ "' and EMPLOYEEID='"+mEmpID+"' and nvl(Studentdeactive,'N')='N' and  nvl(a.deactive,'N')='N'  and attendancetype in ('E','R')  ";	
			if(mSubject.equals("ALL"))
            qrys=qrys+"  and a.programcode = '"+mprog1+"'  " ;
            else
            qrys=qrys+" and a.programcode in ("+mSubject+")   " ;
				qrys=qrys+" AND TRUNC (a.attendancedate) BETWEEN TRUNC(DECODE (TO_DATE ('',  'dd-mm-yyyy'),'', a.attendancedate,TO_DATE ('','dd-mm-yyyy'                                        ))                                               )                                      AND TRUNC                                              (DECODE (TO_DATE ('"+mDate1+"',                                                                'dd-mm-yyyy'                                                               ),                                                       '', a.attendancedate,                                                       TO_DATE ('"+mDate1+"',             'dd-mm-yyyy'                                                               )                                                      )                                              ) ";
			qrys=qrys+"  group by  institutecode , examcode,SUBJECTCODE,Subject,SUBJECTID order by SUBJECTCODE" ;
		//out.print(qrys);
				rs2=db.getRowset(qrys);
			int CNTL80T1s=0  ;
			if (rs2.next())  
				{
						CNTL80T1s=rs2.getInt("totcalsses");
				}			
			
			qryt=" select studentid,count(*)noofclass from V#StudentAttendance a Where    a.LTP in ("+mLTP+") AND A.SEMESTERTYPE='"+mSemType+"' and  SUBSECTIONCODE='" +rs1.getString("SUBSECTIONCODE")+ "' and  a.subjectid='" +rs1.getString("SUBJECTID")+ "'    and a.institutecode='" +rs1.getString("institutecode")+ "' and EMPLOYEEID='"+mEmpID+"' and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";	
			qryt=qryt+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('','dd-mm-yyyy')))";
			qryt=qryt+" and trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy'))) ";			
		
			if(mSubject.equals("ALL"))
            qryt=qryt+"  and a.programcode = '"+mprog1+"'  " ;
            else
            qryt=qryt+"  and a.programcode in ("+mSubject+")   " ;			
	   
			qryt=qryt+"and nvl(present,'N')='Y' and nvl(Studentdeactive,'N')='N' and  nvl(a.deactive,'N')='N' and attendancetype in ('E','R')  group by studentid ";
			rst=db.getRowset(qryt);
	//out.print(qryt);
			int CNTL80T1=0  ;
			int CCNTL70T1=0  ;int CNTL60T1=0,CNTL50T1=0 ,CNTL40T1=0,CNTL30T1=0;

			while (rst.next())      
			{ 
		 		
				//if  (rst.getInt("noofclass")>(rs1.getInt("totcalsses")*rs1.getInt("totstudents")*80/100)){
				if  (((rst.getInt("noofclass")*100)/CNTL80T1s)<80)
				{
						CNTL80T1++;						
				}

				if   (((rst.getInt("noofclass")*100)/CNTL80T1s)<70)
				{
					CCNTL70T1++;
				}

				if (((rst.getInt("noofclass")*100)/CNTL80T1s)<60)
				{
					CNTL60T1++;
				}
if   (((rst.getInt("noofclass")*100)/CNTL80T1s)<50)
				{
					CNTL50T1++;
				}

				if   (((rst.getInt("noofclass")*100)/CNTL80T1s)<40)
				{
					CNTL40T1++;
				}

				if   (((rst.getInt("noofclass")*100)/CNTL80T1s)<30)
			{
			CNTL30T1++;
			}
//out.print("jhj"+rst.getInt("noofclass")+"ljklj"+rs1.getInt("totcalsses"));

			}






	qrys="select distinct institutecode , examcode,SUBJECTCODE,Subject,SUBJECTID, count(distinct CLASSTIMEFROM) totcalsses from V#StudentAttendance a Where     a.LTP in ("+mLTP+") AND A.SEMESTERTYPE='"+mSemType+"' and  SUBSECTIONCODE='" +rs1.getString("SUBSECTIONCODE")+ "'  and subjectid='" +rs1.getString("SUBJECTID")+ "'  and EMPLOYEEID='"+mEmpID+"'  and a.institutecode='" +rs1.getString("institutecode")+ "'  and a.examcode='" +rs1.getString("EXAMCODE")+ "'  and nvl(Studentdeactive,'N')='N' and  nvl(a.deactive,'N')='N' and attendancetype in ('E','R') ";	
			if(mSubject.equals("ALL"))
            qrys=qrys+"  and a.programcode = '"+mprog1+"'  " ;
            else
            qrys=qrys+" and a.programcode in ("+mSubject+")    " ;
				qrys=qrys+" AND TRUNC (a.attendancedate) BETWEEN TRUNC(DECODE (TO_DATE ('',  'dd-mm-yyyy'),'', a.attendancedate,TO_DATE ('','dd-mm-yyyy'                                        ))                                               )                                      AND TRUNC                                              (DECODE (TO_DATE ('"+mDate2+"',                                                                'dd-mm-yyyy'                                                               ),                                                       '', a.attendancedate,                                                       TO_DATE ('"+mDate2+"',             'dd-mm-yyyy'                                                               )                                                      )                                              ) ";
			qrys=qrys+" group by  institutecode , examcode,SUBJECTCODE,Subject,SUBJECTID order by SUBJECTCODE,Subject" ;
			//out.print(qrys);
				rs2=db.getRowset(qrys);
			int CNTL80T2s=0  ;
			if (rs2.next())  
				{
						CNTL80T2s=rs2.getInt("totcalsses");
				}
				

		qryt=" select studentid,count(*)noofclass from V#StudentAttendance a Where    a.LTP in ("+mLTP+") AND A.SEMESTERTYPE='"+mSemType+"' and  SUBSECTIONCODE='" +rs1.getString("SUBSECTIONCODE")+ "'  and subjectid='" +rs1.getString("SUBJECTID")+ "'    and a.institutecode='" +rs1.getString("institutecode")+ "' and EMPLOYEEID='"+mEmpID+"' and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";	
			qryt=qryt+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('','dd-mm-yyyy')))";
					qryt=qryt+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))  ";
			
			if(mSubject.equals("ALL"))
            qryt=qryt+"  and a.programcode = '"+mprog1+"'  " ;
            else
            qryt=qryt+"  and a.programcode in ("+mSubject+")   " ;
			
			qryt=qryt+"and nvl(present,'N')='Y' and nvl(Studentdeactive,'N')='N' and  nvl(a.deactive,'N')='N' and attendancetype in ('E','R')  group by studentid ";
			rst=db.getRowset(qryt);
			//out.print(qryt);
			int CNTL80T2=0  ;

int CCNTL70T2=0 ,CNTL60T2=0 ,CNTL50T2=0,CNTL40T2=0,CNTL30T2=0;
			while (rst.next())      
			{ 
		 		
				//if  (rst.getInt("noofclass")>(rs1.getInt("totcalsses")*rs1.getInt("totstudents")*80/100)){
				if  (((rst.getInt("noofclass")*100)/CNTL80T2s)<80)
					{
						CNTL80T2++;
					//	out.print("jhj"+rst.getInt("noofclass")+"ljklj"+rs1.getInt("totcalsses"));
					}

				if   (((rst.getInt("noofclass")*100)/CNTL80T2s)<70)
					{
						CCNTL70T2++;
					}

						if (((rst.getInt("noofclass")*100)/CNTL80T2s)<60)
					{
						CNTL60T2++;
					}
if   (((rst.getInt("noofclass")*100)/CNTL80T2s)<50)
				{
					CNTL50T2++;
				}
				if   (((rst.getInt("noofclass")*100)/CNTL80T2s)<40)
				{
					CNTL40T2++;
				}

				if   (((rst.getInt("noofclass")*100)/CNTL80T2s)<30)
			{
			CNTL30T2++;
			}
//out.print("jhj"+rst.getInt("noofclass")+"ljklj"+rs1.getInt("totcalsses"));
			}





	qrys="select distinct institutecode , examcode,SUBJECTCODE,Subject,SUBJECTID, count(distinct CLASSTIMEFROM) totcalsses from V#StudentAttendance a Where     a.LTP in ("+mLTP+") AND A.SEMESTERTYPE='"+mSemType+"' and  SUBSECTIONCODE='" +rs1.getString("SUBSECTIONCODE")+ "'  and subjectid='" +rs1.getString("SUBJECTID")+ "'  and EMPLOYEEID='"+mEmpID+"'  and a.institutecode='" +rs1.getString("institutecode")+ "'  and a.examcode='" +rs1.getString("EXAMCODE")+ "'  and nvl(Studentdeactive,'N')='N' and  nvl(a.deactive,'N')='N' and attendancetype in ('E','R')   ";	
			if(mSubject.equals("ALL"))
            qrys=qrys+"  and a.programcode = '"+mprog1+"'  " ;
            else
            qrys=qrys+" and a.programcode in ("+mSubject+")  " ;
				qrys=qrys+" AND TRUNC (a.attendancedate) BETWEEN TRUNC(DECODE (TO_DATE ('',  'dd-mm-yyyy'),'', a.attendancedate,TO_DATE ('','dd-mm-yyyy'                                        ))                                               )                                      AND TRUNC                                              (DECODE (TO_DATE ('"+mDate3+"',                                                                'dd-mm-yyyy'                                                               ),                                                       '', a.attendancedate,                                                       TO_DATE ('"+mDate3+"',             'dd-mm-yyyy'                                                               )                                                      )                                              ) ";
			qrys=qrys+" group by  institutecode , examcode,SUBJECTCODE,Subject,SUBJECTID order by SUBJECTCODE,Subject" ;
//out.print(qrys);
				rs2=db.getRowset(qrys);
			int CNTL80T3s=0  ;
			if (rs2.next())  
				{
						CNTL80T3s=rs2.getInt("totcalsses");
				}

				qryt=" select studentid,count(*)noofclass from V#StudentAttendance a Where    a.LTP in ("+mLTP+") AND A.SEMESTERTYPE='"+mSemType+"' and  SUBSECTIONCODE='" +rs1.getString("SUBSECTIONCODE")+ "'  and subjectid='" +rs1.getString("SUBJECTID")+ "'    and a.institutecode='" +rs1.getString("institutecode")+ "'  and EMPLOYEEID='"+mEmpID+"' and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";	
			qryt=qryt+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('','dd-mm-yyyy')))";
			qryt=qryt+" and trunc(decode(to_date('"+mDate3+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate3+"','dd-mm-yyyy')))";
			
			if(mSubject.equals("ALL"))
            qryt=qryt+"  and a.programcode = '"+mprog1+"'  " ;
            else
            qryt=qryt+"  and a.programcode in ("+mSubject+")   " ;
		
			qryt=qryt+"and nvl(present,'N')='Y' and nvl(Studentdeactive,'N')='N' and  nvl(a.deactive,'N')='N' and attendancetype in ('E','R') group by studentid ";
			rst=db.getRowset(qryt);
	//		out.print(qryt);
			int CNTL80T3=0  ;int CCNTL70T3=0 ,CNTL60T3=0,CNTL50T3=0,CNTL40T3=0,CNTL30T3=0 ;
			while (rst.next())      
			{ 
		 		
				//if  (rst.getInt("noofclass")>(rs1.getInt("totcalsses")*rs1.getInt("totstudents")*80/100)){
				if  (((rst.getInt("noofclass")*100)/CNTL80T3s)<80)
					{
						CNTL80T3++;
					}

	
			if   (((rst.getInt("noofclass")*100)/CNTL80T3s)<70)
				{
					CCNTL70T3++;
				}

				if (((rst.getInt("noofclass")*100)/CNTL80T3s)<60)
			{
				CNTL60T3++;
			}

			if   (((rst.getInt("noofclass")*100)/CNTL80T3s)<50)
				{
					CNTL50T3++;
				}
				if   (((rst.getInt("noofclass")*100)/CNTL80T3s)<40)
				{
					CNTL40T3++;
				}
				if   (((rst.getInt("noofclass")*100)/CNTL80T3s)<30)
			{
			CNTL30T3++;
			}
//out.print("jhj"+rst.getInt("noofclass")+"ljklj"+rs1.getInt("totcalsses"));
			}



//-------------------------------------------------------------------------------------------------------------------------------


			        %>
				    <tr><td><B><%=++count%></B></td>
				
                    <!-- ---------- -->
                    <%
				    if(!mSUBN.equals(rs1.getString("Subject")) )
					{
					%>
					<td align=left ><FONT SIZE="2" ><%=rs1.getString("Subject")%>(<%=rs1.getString("SUBJECTCODE")%>)</td>
					<%
					mSUBN=rs1.getString("Subject");
					}
				    else
					{
					%>
					<td  align=left ><Font size=1 color=green align=center>''</Font></td>
					<%
					}
					%>

					
<td align=left >
					<FONT SIZE="1" >
							<%=rs1.getString("PROGRAMCODE")%>
							</font>
					</a>
					</td>

					<td align=left ><FONT SIZE="1" ><%=rs1.getString("SUBSECTIONCODE")%> - - <%=mSemType%></td>
						


				<td><FONT SIZE="2" ><%=mEmpNAME%></td>



    <td ALIGN=LEFT><a href="Facultywiseattnpercentdetail.jsp?ViewType=CNF&amp;INSTITUTE=<%=mInstCode%>&amp;EXAMCODE=<%=mEXAMCODE%>&amp;PROGRAMCODE=<%=mSubject%>&amp;LTP=<%=mLTP%>&amp;SUBJECTCODE=<%=rs1.getString("SUBJECTCODE")%>&amp;SUBJECT=<%=rs1.getString("Subject")%>&amp;SUBCODE=<%=rs1.getString("SUBSECTIONCODE")%>&amp;FLAG=80&amp;TNOOFCLASS=<%=CNTL80T1s%>&amp;Date1=<%=mDate1%>&amp;EMPID=<%=mEmpID%>&amp;SEMTYPE=<%=mSemType%>" target=NEW><%=CNTL80T1%></a></td>


 <td ALIGN=LEFT><a href="Facultywiseattnpercentdetail.jsp?ViewType=CNF&amp;INSTITUTE=<%=mInstCode%>&amp;EXAMCODE=<%=mEXAMCODE%>&amp;PROGRAMCODE=<%=mSubject%>&amp;LTP=<%=mLTP%>&amp;SUBJECTCODE=<%=rs1.getString("SUBJECTCODE")%>&amp;SUBJECT=<%=rs1.getString("Subject")%>&amp;SUBCODE=<%=rs1.getString("SUBSECTIONCODE")%>&amp;FLAG=80&amp;TNOOFCLASS=<%=CNTL80T2s%>&amp;Date1=<%=mDate2%>&amp;EMPID=<%=mEmpID%>&amp;SEMTYPE=<%=mSemType%>" target=NEW><%=CNTL80T2%></a></td>

 
 <td ALIGN=LEFT><a href="Facultywiseattnpercentdetail.jsp?ViewType=CNF&amp;INSTITUTE=<%=mInstCode%>&amp;EXAMCODE=<%=mEXAMCODE%>&amp;PROGRAMCODE=<%=mSubject%>&amp;LTP=<%=mLTP%>&amp;SUBJECTCODE=<%=rs1.getString("SUBJECTCODE")%>&amp;SUBJECT=<%=rs1.getString("Subject")%>&amp;SUBCODE=<%=rs1.getString("SUBSECTIONCODE")%>&amp;FLAG=80&amp;TNOOFCLASS=<%=CNTL80T3s%>&amp;Date1=<%=mDate3%>&amp;EMPID=<%=mEmpID%>&amp;SEMTYPE=<%=mSemType%>" target=NEW><%=CNTL80T3%></a></td>


    <td ALIGN=LEFT><a href="Facultywiseattnpercentdetail.jsp?ViewType=CNF&amp;INSTITUTE=<%=mInstCode%>&amp;EXAMCODE=<%=mEXAMCODE%>&amp;PROGRAMCODE=<%=mSubject%>&amp;LTP=<%=mLTP%>&amp;SUBJECTCODE=<%=rs1.getString("SUBJECTCODE")%>&amp;SUBJECT=<%=rs1.getString("Subject")%>&amp;SUBCODE=<%=rs1.getString("SUBSECTIONCODE")%>&amp;FLAG=70&amp;TNOOFCLASS=<%=CNTL80T1s%>&amp;Date1=<%=mDate1%>&amp;EMPID=<%=mEmpID%>&amp;SEMTYPE=<%=mSemType%>" target=NEW><%=CCNTL70T1%></a></td>

<td ALIGN=LEFT><a href="Facultywiseattnpercentdetail.jsp?ViewType=CNF&amp;INSTITUTE=<%=mInstCode%>&amp;EXAMCODE=<%=mEXAMCODE%>&amp;PROGRAMCODE=<%=mSubject%>&amp;LTP=<%=mLTP%>&amp;SUBJECTCODE=<%=rs1.getString("SUBJECTCODE")%>&amp;SUBJECT=<%=rs1.getString("Subject")%>&amp;SUBCODE=<%=rs1.getString("SUBSECTIONCODE")%>&amp;FLAG=70&amp;TNOOFCLASS=<%=CNTL80T2s%>&amp;Date1=<%=mDate2%>&amp;EMPID=<%=mEmpID%>&amp;SEMTYPE=<%=mSemType%>" target=NEW><%=CCNTL70T2%></a></td>


<td ALIGN=LEFT><a href="Facultywiseattnpercentdetail.jsp?ViewType=CNF&amp;INSTITUTE=<%=mInstCode%>&amp;EXAMCODE=<%=mEXAMCODE%>&amp;PROGRAMCODE=<%=mSubject%>&amp;LTP=<%=mLTP%>&amp;SUBJECTCODE=<%=rs1.getString("SUBJECTCODE")%>&amp;SUBJECT=<%=rs1.getString("Subject")%>&amp;SUBCODE=<%=rs1.getString("SUBSECTIONCODE")%>&amp;FLAG=70&amp;TNOOFCLASS=<%=CNTL80T3s%>&amp;Date1=<%=mDate3%>&amp;EMPID=<%=mEmpID%>&amp;SEMTYPE=<%=mSemType%>" target=NEW><%=CCNTL70T3%></a></td>





    <td ALIGN=LEFT><a href="Facultywiseattnpercentdetail.jsp?ViewType=CNF&amp;INSTITUTE=<%=mInstCode%>&amp;EXAMCODE=<%=mEXAMCODE%>&amp;PROGRAMCODE=<%=mSubject%>&amp;LTP=<%=mLTP%>&amp;SUBJECTCODE=<%=rs1.getString("SUBJECTCODE")%>&amp;SUBJECT=<%=rs1.getString("Subject")%>&amp;SUBCODE=<%=rs1.getString("SUBSECTIONCODE")%>&amp;FLAG=60&amp;TNOOFCLASS=<%=CNTL80T1s%>&amp;Date1=<%=mDate1%>&amp;EMPID=<%=mEmpID%>&amp;SEMTYPE=<%=mSemType%>" target=NEW><%=CNTL60T1%> </a></td>


<td ALIGN=LEFT><a href="Facultywiseattnpercentdetail.jsp?ViewType=CNF&amp;INSTITUTE=<%=mInstCode%>&amp;EXAMCODE=<%=mEXAMCODE%>&amp;PROGRAMCODE=<%=mSubject%>&amp;LTP=<%=mLTP%>&amp;SUBJECTCODE=<%=rs1.getString("SUBJECTCODE")%>&amp;SUBJECT=<%=rs1.getString("Subject")%>&amp;SUBCODE=<%=rs1.getString("SUBSECTIONCODE")%>&amp;FLAG=60&amp;TNOOFCLASS=<%=CNTL80T2s%>&amp;Date1=<%=mDate2%>&amp;EMPID=<%=mEmpID%>&amp;SEMTYPE=<%=mSemType%>" target=NEW><%=CNTL60T2%> </a></td>

<td ALIGN=LEFT><a href="Facultywiseattnpercentdetail.jsp?ViewType=CNF&amp;INSTITUTE=<%=mInstCode%>&amp;EXAMCODE=<%=mEXAMCODE%>&amp;PROGRAMCODE=<%=mSubject%>&amp;LTP=<%=mLTP%>&amp;SUBJECTCODE=<%=rs1.getString("SUBJECTCODE")%>&amp;SUBJECT=<%=rs1.getString("Subject")%>&amp;SUBCODE=<%=rs1.getString("SUBSECTIONCODE")%>&amp;FLAG=60&amp;TNOOFCLASS=<%=CNTL80T3s%>&amp;Date1=<%=mDate3%>&amp;EMPID=<%=mEmpID%>&amp;SEMTYPE=<%=mSemType%>" target=NEW><%=CNTL60T3%> </a></td>



    <td ALIGN=LEFT><a href="Facultywiseattnpercentdetail.jsp?ViewType=CNF&amp;INSTITUTE=<%=mInstCode%>&amp;EXAMCODE=<%=mEXAMCODE%>&amp;PROGRAMCODE=<%=mSubject%>&amp;LTP=<%=mLTP%>&amp;SUBJECTCODE=<%=rs1.getString("SUBJECTCODE")%>&amp;SUBJECT=<%=rs1.getString("Subject")%>&amp;SUBCODE=<%=rs1.getString("SUBSECTIONCODE")%>&amp;FLAG=50&amp;TNOOFCLASS=<%=CNTL80T1s%>&amp;Date1=<%=mDate1%>&amp;EMPID=<%=mEmpID%>&amp;SEMTYPE=<%=mSemType%>" target=NEW> <%=CNTL50T1%> </a></td>

<td ALIGN=LEFT><a href="Facultywiseattnpercentdetail.jsp?ViewType=CNF&amp;INSTITUTE=<%=mInstCode%>&amp;EXAMCODE=<%=mEXAMCODE%>&amp;PROGRAMCODE=<%=mSubject%>&amp;LTP=<%=mLTP%>&amp;SUBJECTCODE=<%=rs1.getString("SUBJECTCODE")%>&amp;SUBJECT=<%=rs1.getString("Subject")%>&amp;SUBCODE=<%=rs1.getString("SUBSECTIONCODE")%>&amp;FLAG=50&amp;TNOOFCLASS=<%=CNTL80T2s%>&amp;Date1=<%=mDate2%>&amp;EMPID=<%=mEmpID%>&amp;SEMTYPE=<%=mSemType%>" target=NEW> <%=CNTL50T2%> </a></td>

<td ALIGN=LEFT><a href="Facultywiseattnpercentdetail.jsp?ViewType=CNF&amp;INSTITUTE=<%=mInstCode%>&amp;EXAMCODE=<%=mEXAMCODE%>&amp;PROGRAMCODE=<%=mSubject%>&amp;LTP=<%=mLTP%>&amp;SUBJECTCODE=<%=rs1.getString("SUBJECTCODE")%>&amp;SUBJECT=<%=rs1.getString("Subject")%>&amp;SUBCODE=<%=rs1.getString("SUBSECTIONCODE")%>&amp;FLAG=50&amp;TNOOFCLASS=<%=CNTL80T3s%>&amp;Date1=<%=mDate3%>&amp;EMPID=<%=mEmpID%>&amp;SEMTYPE=<%=mSemType%>" target=NEW> <%=CNTL50T3%> </a></td>


    <td ALIGN=LEFT><a href="Facultywiseattnpercentdetail.jsp?ViewType=CNF&amp;INSTITUTE=<%=mInstCode%>&amp;EXAMCODE=<%=mEXAMCODE%>&amp;PROGRAMCODE=<%=mSubject%>&amp;LTP=<%=mLTP%>&amp;SUBJECTCODE=<%=rs1.getString("SUBJECTCODE")%>&amp;SUBJECT=<%=rs1.getString("Subject")%>&amp;SUBCODE=<%=rs1.getString("SUBSECTIONCODE")%>&amp;FLAG=40&amp;TNOOFCLASS=<%=CNTL80T1s%>&amp;Date1=<%=mDate1%>&amp;EMPID=<%=mEmpID%>&amp;SEMTYPE=<%=mSemType%>" target=NEW> <%=CNTL40T1%> </a></td>

	<td ALIGN=LEFT><a href="Facultywiseattnpercentdetail.jsp?ViewType=CNF&amp;INSTITUTE=<%=mInstCode%>&amp;EXAMCODE=<%=mEXAMCODE%>&amp;PROGRAMCODE=<%=mSubject%>&amp;LTP=<%=mLTP%>&amp;SUBJECTCODE=<%=rs1.getString("SUBJECTCODE")%>&amp;SUBJECT=<%=rs1.getString("Subject")%>&amp;SUBCODE=<%=rs1.getString("SUBSECTIONCODE")%>&amp;FLAG=40&amp;TNOOFCLASS=<%=CNTL80T2s%>&amp;Date1=<%=mDate2%>&amp;EMPID=<%=mEmpID%>&amp;SEMTYPE=<%=mSemType%>" target=NEW> <%=CNTL40T2%> </a></td>

<td ALIGN=LEFT><a href="Facultywiseattnpercentdetail.jsp?ViewType=CNF&amp;INSTITUTE=<%=mInstCode%>&amp;EXAMCODE=<%=mEXAMCODE%>&amp;PROGRAMCODE=<%=mSubject%>&amp;LTP=<%=mLTP%>&amp;SUBJECTCODE=<%=rs1.getString("SUBJECTCODE")%>&amp;SUBJECT=<%=rs1.getString("Subject")%>&amp;SUBCODE=<%=rs1.getString("SUBSECTIONCODE")%>&amp;FLAG=40&amp;TNOOFCLASS=<%=CNTL80T3s%>&amp;Date1=<%=mDate3%>&amp;EMPID=<%=mEmpID%>&amp;SEMTYPE=<%=mSemType%>" target=NEW> <%=CNTL40T3%> </a></td>




    <td ALIGN=LEFT><a href="Facultywiseattnpercentdetail.jsp?ViewType=CNF&amp;INSTITUTE=<%=mInstCode%>&amp;EXAMCODE=<%=mEXAMCODE%>&amp;PROGRAMCODE=<%=mSubject%>&amp;LTP=<%=mLTP%>&amp;SUBJECTCODE=<%=rs1.getString("SUBJECTCODE")%>&amp;SUBJECT=<%=rs1.getString("Subject")%>&amp;SUBCODE=<%=rs1.getString("SUBSECTIONCODE")%>&amp;FLAG=30&amp;TNOOFCLASS=<%=CNTL80T1s%>&amp;Date1=<%=mDate1%>&amp;EMPID=<%=mEmpID%>&amp;SEMTYPE=<%=mSemType%>" target=NEW><%=CNTL30T1%> </a></td>

	
    <td ALIGN=LEFT><a href="Facultywiseattnpercentdetail.jsp?ViewType=CNF&amp;INSTITUTE=<%=mInstCode%>&amp;EXAMCODE=<%=mEXAMCODE%>&amp;PROGRAMCODE=<%=mSubject%>&amp;LTP=<%=mLTP%>&amp;SUBJECTCODE=<%=rs1.getString("SUBJECTCODE")%>&amp;SUBJECT=<%=rs1.getString("Subject")%>&amp;SUBCODE=<%=rs1.getString("SUBSECTIONCODE")%>&amp;FLAG=30&amp;TNOOFCLASS=<%=CNTL80T2s%>&amp;Date1=<%=mDate2%>&amp;EMPID=<%=mEmpID%>&amp;SEMTYPE=<%=mSemType%>" target=NEW><%=CNTL30T2%> </a></td>

	
    <td ALIGN=LEFT><a href="Facultywiseattnpercentdetail.jsp?ViewType=CNF&amp;INSTITUTE=<%=mInstCode%>&amp;EXAMCODE=<%=mEXAMCODE%>&amp;PROGRAMCODE=<%=mSubject%>&amp;LTP=<%=mLTP%>&amp;SUBJECTCODE=<%=rs1.getString("SUBJECTCODE")%>&amp;SUBJECT=<%=rs1.getString("Subject")%>&amp;SUBCODE=<%=rs1.getString("SUBSECTIONCODE")%>&amp;FLAG=30&amp;TNOOFCLASS=<%=CNTL80T3s%>&amp;Date1=<%=mDate3%>&amp;EMPID=<%=mEmpID%>&amp;SEMTYPE=<%=mSemType%>" target=NEW><%=CNTL30T3%> </a></td>

	

                    <%

				
				//out.print(CNTL80T1 + " : CNTL80T1 : "+ rsum80t1);

				rsum80t1=((CNTL80T1)+(rsum80t1));
				rsum80t2=((CNTL80T2)+(rsum80t2));
				rsum80t3=((CNTL80T3)+(rsum80t3));

				ssum70t1=((CCNTL70T1)+(ssum70t1));
				ssum70t2=((CCNTL70T2)+(ssum70t2));
				ssum70t3=((CCNTL70T3)+(ssum70t3));

				tsum60t1=((CNTL60T1)+(tsum60t1));
				tsum60t2=((CNTL60T2)+(tsum60t2));
				tsum60t3=((CNTL60T3)+(tsum60t3));

				usum50t1=((CNTL50T1)+(usum50t1));
				usum50t2=((CNTL50T2)+(usum50t2));
				usum50t3=((CNTL50T3)+(usum50t3));

				 vsum40t1=((CNTL40T1)+(vsum40t1));
				 vsum40t2=((CNTL40T2)+(vsum40t2));
				 vsum40t3=((CNTL40T3)+(vsum40t3));

				 wsum30t1=((CNTL30T1)+(wsum30t1));
				 wsum30t2=((CNTL30T2)+(wsum30t2));
				 wsum30t3=((CNTL30T3)+(wsum30t3));
		
		//	ttsum2=TotalStud2+ttsum2;
		//	ttsum3=TotalStud3+ttsum3;

               //     
                //    tsum=((CNTL60)+(tsum));
                 //   usum=((CNTL50)+(usum));
                  //  vsum=((CNTL40)+(vsum));
              //      wsum=((CNTL30)+(wsum));
                    %>
					  <td align="LEFT"><font color="green"><%=TotalStud1%>  </font> </td>
				

					                    <td align="LEFT"><font color="green"><%=TotalClassCount%> </font> </td>

					
					</tr>
                    <%
						if(TotalStud1!=0)
				{
						ttsum1=ttsum1+TotalStud1;
				}

                    //----------------ADDED CODE----------------- ON/27-apl-2011
                    }
                //    rsum=((rsum)-(count));
                 //   ssum=((ssum)-(count));
                  //  tsum=((tsum)-(count));
                 //   usum=((usum)-(count));
                  //  vsum=((vsum)-(count));
                   // wsum=((wsum)-(count));

				   //	int rsum80t1=0,rsum80t2=0,rsum80t3=0,ssum70t1=0,ssum70t2=0,ssum70t3=0,tsum60t1=0,tsum60t2=0,tsum60t3=0,
//					usum50t1=0,usum50t2=0,usum50t3=0,vsum40t1=0,vsum40t2=0,vsum40t3=0,wsum30t1=0,wsum30t2=0,wsum30t3=0;
					%>
                    <tr><td>&nbsp;</td><td>&nbsp;</td> <td>&nbsp;</td><td>&nbsp;</td><td align="left"><STRONG>Total Count(% Wise):</STRONG></td><td><font color="red"><%=rsum80t1%></font></td>
                    <td><font color="red"><%=rsum80t2%></font> </td>
					 <td><font color="red"><%=rsum80t3%></font> </td>

					<td><font color="red"><%=ssum70t1%></font> </td>
					<td><font color="red"><%=ssum70t2%></font> </td>
					<td><font color="red"><%=ssum70t3%></font> </td>

                    <td><font color="red"><%=tsum60t1%></font> </td>
                    <td><font color="red"><%=tsum60t2%></font> </td>
                    <td><font color="red"><%=tsum60t3%></font> </td>
					
					    <td><font color="red"><%=usum50t1%></font> </td>
						  <td><font color="red"><%=usum50t2%></font> </td>
						    <td><font color="red"><%=usum50t3%></font> </td>
					
				    <td><font color="red"><%=vsum40t1%></font> </td>
					    <td><font color="red"><%=vsum40t2%></font> </td>
						    <td><font color="red"><%=vsum40t3%></font> </td>

							  <td><font color="red"><%=wsum30t1%></font> </td>
							    <td><font color="red"><%=wsum30t2%></font> </td>
								  <td><font color="red"><%=wsum30t3%></font> </td>


  <td><font color="red"><%=ttsum1%> </font> </td>
					
					</tr>
					</tbody>
					</table>
					<form><CENTER>
					<input type="button" value=" Print this page "
                    onclick="window.print();return false;" /></CENTER>
					</form>
					<script type="text/javascript">
					var st1 = new SortableTable(document.getElementById("table-1"),["CaseInsensitiveString","CaseInsensitiveString","Number","Number","Number","Number","Number"]);
					</script>
	
<%
}
catch(Exception e)
{
	out.print(e);
}
%>

    </body>
</html>


