<%--
    Document   : studentMaster
    Created on : 23 Sep, 2015, 11:40:40 AM
    Author     : nipun.gupta
--%>
<!DOCTYPE html>
<%@ page language="java" import="java.sql.*,java.util.HashMap,java.util.Map,tietwebkiosk.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %>
<%@page import="jilit.db.CommonComboData"%>
<%
    String mHead = "", mInstCode = "";
    String mCandCode = "", MName = "";
    String mCandName = "";
    String URL = "";
    String regConfirmation="";
   // int l=0,m=0,n=0;

    if (session.getAttribute("PageHeading") != null && !session.getAttribute("PageHeading").equals("")) {
        mHead = session.getAttribute("PageHeading").toString().trim();
    } else {
        mHead = "JIIT ";
    }
%>
<HTML>
    <head>
        <style type="text/css" media="print">

    @media print
    {
    @page { size: landscape; }
    #non-printable { display: none; }
    #printable {
    display: block;
    width: 100%;
    height: 100%;
    }
    }
    </style>
        <script type="text/javascript" src="js/sortabletable.js"></script>
        <script type="text/javascript" src="js/json2.js"></script>
        <link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

        <TITLE>JIIT </TITLE>
        <script src="../IQAC/js/jquery/jquery-1.10.2.js"></script>
        <script src="../IQAC/js/jquery/jquery-ui.js"></script>
        <script src="../IQAC/js/jquery/yattable.js"></script>
        <script src="../IQAC/js/jquery/numeric-1.0.js"></script>
        <script src="../IQAC/js/IQTest/CommonServiceJs.js"></script>
        <script src="../IQAC/js/IQTest/ComboJs.js"></script>
        <script src="js/studentMasterJS.js"></script>
        <script>
            $(document).ready(function() {

                getCommonMasterTable();
 });
 function validateform()
 {
     /*alert("12112121");
     alert("instituteCode--"+document.studentMasterReport.instituteCode.value);
     alert("academicYear--"+document.studentMasterReport.academicYear.value);
     alert("programCode--"+document.studentMasterReport.programCode.value);
     alert("branchCode--"+document.studentMasterReport.branchCode.value);
     alert("examCode--"+document.studentMasterReport.examCode.value);
     alert("quota--"+document.studentMasterReport.quota.value);*/
    if(document.studentMasterReport.regConfirmation.value!='0' && document.studentMasterReport.regConfirmation.value!="" 
        && document.studentMasterReport.deactive.value!='0'  && document.studentMasterReport.deactive.value!=""
        && document.studentMasterReport.gender.value!='0' && document.studentMasterReport.gender.value!=""
        && document.studentMasterReport.instituteCode.value!='0' && document.studentMasterReport.instituteCode.value!=""
        && document.studentMasterReport.academicYear.value!='0' && document.studentMasterReport.academicYear.value!=""
        && document.studentMasterReport.programCode.value!='0' && document.studentMasterReport.programCode.value!=""
        && document.studentMasterReport.branchCode.value!='0' && document.studentMasterReport.branchCode.value!=""
        && document.studentMasterReport.examCode.value!='0' && document.studentMasterReport.examCode.value!=""
        && document.studentMasterReport.quota.value!='0' && document.studentMasterReport.quota.value!="")
             {
                 //alert("1");
                return true;
             }
             else
             {
               alert("Please Select All Field ");
               return false;
             }
           
 }
        </script>

    </head>
    <body aLink=#ff00ff bgcolor="#fce9c5" rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
        <%
            CommonComboData ccd=new CommonComboData();
            //GlobalFunctions gb =new GlobalFunctions();
            DBHandler db = new DBHandler();
            String mMemberID = "", mMemberType = "", mMemberName = "", mMemberCode = "";
            String mDMemberCode = "", mDMemberType = "", mDept = "", mDesg = "", mInst = "", minst = "", mDMemberID = "";
            String qry = "", mEnOrNm = "", x = "", cInst = "", mCheck = "",institute="",mInstituteCode="";
            String mStrInst="",qry1="",qry2="",qry3="",qry4="",qry5="",qry6="",mAcademicyear="",mStrAcademicYear="",mProgramCode="",mStrProgramCode11="";
            int msno = 0;
            String mQuota="",mBranchCode="",mStrExamCode11="",mExamCode="",mStrBranchCode11="",mStrQuota11="",mQuota11="";
            ResultSet rs = null,rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null;
            String inst="hii";
            if (session.getAttribute("Designation") == null) {
                mDesg = "";
            } else {
                mDesg = session.getAttribute("Designation").toString().trim();
            }

            if (session.getAttribute("Department") == null) {
                mDept = "";
            } else {
                mDept = session.getAttribute("Department").toString().trim();
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

            if (session.getAttribute("InstituteCode") == null) {
                mInstCode = "JIIT";
            } else {
                mInstCode = session.getAttribute("InstituteCode").toString().trim();
            }
            session.setAttribute("INSCODE", " ");
            OLTEncryption enc = new OLTEncryption();
            if (!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) {
                mDMemberCode = enc.decode(mMemberCode);
                mDMemberType = enc.decode(mMemberType);
                mDMemberID = enc.decode(mMemberID);

                String mChkMemID = enc.decode(session.getAttribute("MemberID").toString().trim());
                String mChkMType = enc.decode(session.getAttribute("MemberType").toString().trim());
                String mIPAddress = session.getAttribute("IPADD").toString().trim();
                String mRole = enc.decode(session.getAttribute("ROLENAME").toString().trim());
                ResultSet RsChk1 = null;
                //-----------------------------
                //-- Enable Security Page Level
                //-----------------------------
                qry = "Select WEBKIOSK.ShowLink('387','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";
                RsChk1 = db.getRowset(qry);
                if (RsChk1.next() && RsChk1.getString("SL").equals("Y")) {

        %>

        <form name="studentMasterReport" >
            <input type="hidden" name="x" id="x" >
          <!-- <div id="non-printable">-->
               <table cellpadding=2 cellspacing=2 align=center rules=groups border=1>
                <tr><td align="center" colspan='6' bgcolor='#c00000'><font color=white><b>Student Master Bulk</b></font></td></tr>
                <tr>
                    <td style="text-align: right">Institute Code<font color='red'> *</font> :</td>
                    <%
                    qry="select nvl(im.INSTITUTECODE,'')INSTITUTECODE ,nvl(im.INSTITUTECODE,'')INSTITUTECODE1 from INSTITUTEMASTER im where nvl(deactive,'N')='N'";
                    rs=db.getRowset(qry);
                    %>
                    <td>
                          <SELECT id=instituteCode style="WIDTH: 250px; HEIGHT: 70px" multiple size=2 name=instituteCode>
	
	
	<%
	try
        {
            //System.out.println("11111---");
           // if(session.getAttribute("inst").toString()!="jiitfirst")
            //{
                //System.out.println("2222---1122");
          while(rs.next())
			{
                              //  inst="jiitfirst";
				mInstituteCode=rs.getString("INSTITUTECODE");
				%>
				<OPTION Value =<%=mInstituteCode%>><%=mInstituteCode%></option>
				<%
                                // session.setAttribute("inst",inst);

			}
                        
            //}
          /*  else if(session.getAttribute("inst").toString()=="jiitfirst")
            {
                System.out.println("2222---333333");
                 String [] mInst1=request.getParameterValues("instituteCode");
		      for (int i=0;i<mInst1.length;i++)
		      {
            %>
               
            <%
                 }
            }*/

        }
        catch(Exception e)
	{
		//out.println(e.getMessage());
	}
	%>
	</SELECT>
                    </td>
                    <td>
                        <input type="Submit"  id="btn1" class="btn1" name="btn1" value=">>"   >
                    </td>
                    <%
                    if (request.getParameter("btn1") != null){
                      //temp1="right";
                      String [] mInst1=request.getParameterValues("instituteCode");
		      for (int i=0;i<mInst1.length;i++)
		      {
			if(mStrInst.equals(""))
				mStrInst="'"+mInst1[i]+"'";
			else
				mStrInst=mStrInst+",'"+mInst1[i]+"'";
		      }
                                        
                      session.setAttribute("mStrInst", mStrInst);
                      }

                    %>

                  
         <td style="text-align: right">Academic Year<font color='red'> *</font> :</td>
                    <td>
                        <SELECT id=academicYear style="WIDTH: 250px; HEIGHT: 70px" multiple size=2 name=academicYear>
                       
	<%
	try
        {
             //System.out.println("2222---");
            if (request.getParameter("btn1") != null)
            {
            qry1="select distinct nvl(A.academicyear,'')academicyear ,nvl(A.academicyear,'') academicyear1 from academicyearmaster A  where nvl(deactive,'N')='N' and nvl(closed,'N')='N' and institutecode in ("+mStrInst+") order by academicyear desc";
            rs1=db.getRowset(qry1);
            }
            //else if(request.getParameter("temp1").toString() != "")
             else if(session.getAttribute("mStrInst").toString()!=""&&session.getAttribute("mStrInst").toString()!=null)
            {
            qry1="select distinct nvl(A.academicyear,'')academicyear ,nvl(A.academicyear,'') academicyear1 from academicyearmaster A  where nvl(deactive,'N')='N' and nvl(closed,'N')='N' and institutecode in ("+session.getAttribute("mStrInst").toString()+") order by academicyear desc";
            //System.out.println("2222---"+qry1);
            rs1=db.getRowset(qry1);
            }
        if(rs1!=null)
        {
	while(rs1.next())
	{
            mAcademicyear=rs1.getString("academicyear");
	%>
	<OPTION Value =<%=mAcademicyear%>><%=mAcademicyear%></option>
	<%
       	}
        }
        }
        catch(Exception e)
        {

        }
	%>
	</SELECT>
                    </td>
                    <td>
                         <input type="Submit"  id="btn2" class="btn2" name="btn2" value=">>"   >
                    </td>
               </tr>
                    <%
                    if (request.getParameter("btn2") != null){
                      
                      String [] mAcademicYear1=request.getParameterValues("academicYear");
		      for (int i=0;i<mAcademicYear1.length;i++)
		      {
			if(mStrAcademicYear.equals(""))
				mStrAcademicYear="'"+mAcademicYear1[i]+"'";
			else
				mStrAcademicYear=mStrAcademicYear+",'"+mAcademicYear1[i]+"'";
		      }
                       
                      session.setAttribute("mStrAcademicYear",mStrAcademicYear);
                      
                      }

                    %>
                    

                
                <tr>
                  
         <td style="text-align: right">Program Code:<font color='red'> *</font> :</td>
                    <td>
                        <SELECT id=programCode style="WIDTH: 250px; HEIGHT: 70px" multiple size=2 name=programCode>

	<%
	try
        {
             //System.out.println("333333---223333");
             //System.out.println("------"+session.getAttribute("mStrAcademicYear").toString()+"**************"+session.getAttribute("mStrInst").toString());
            if (request.getParameter("btn2") != null)
            {
                //System.out.println("666666---");
            qry2="select distinct nvl(sm.programcode,'')programcode  from studentmaster sm  where  institutecode in ("+session.getAttribute("mStrInst").toString()+")  and academicyear IN ("+mStrAcademicYear+")";
            rs2=db.getRowset(qry2);
            }
           // else if(request.getParameter("temp2").toString() != "")
             else if(session.getAttribute("mStrAcademicYear").toString()!=""&&session.getAttribute("mStrAcademicYear").toString()!=null)
            {
                //System.out.println("7777777---********");
               // System.out.println(request.getParameter("Academicyr").toString());
              qry2="select distinct nvl(sm.programcode,'')programcode  from studentmaster sm  where  institutecode in ("+session.getAttribute("mStrInst").toString()+")  and academicyear IN ("+session.getAttribute("mStrAcademicYear").toString()+")";
             // System.out.println("7777777---!!!!!!!!"+qry2);
              rs2=db.getRowset(qry2);
            }
               
         if(rs2!=null)
        {
            // System.out.println("44444444---in 2");
	while(rs2.next())
	{
            
            mProgramCode=rs2.getString("programcode");
	%>
	<OPTION Value =<%=mProgramCode%>><%=mProgramCode%></option>
	<%
       	}
        }
             //System.out.println("5555555---");
        }
        catch(Exception e)
        {
          // e.printStackTrace();
           
        }
	%>
	</SELECT>
                    </td>
                    <td>
                         <input type="Submit"  id="btn3" class="btn3" name="btn3" value=">>"   >
                    </td>
                    <%
                    if (request.getParameter("btn3") != null){
                       // System.out.println("333333---6666666btn3"+request.getParameterValues("programCode"));
                      //temp3="right";
                      String [] mProgramCode111=request.getParameterValues("programCode");
		      for (int i=0;i<mProgramCode111.length;i++)
		      {
			if(mStrProgramCode11.equals(""))
				mStrProgramCode11="'"+mProgramCode111[i]+"'";
			else
				mStrProgramCode11=mStrProgramCode11+",'"+mProgramCode111[i]+"'";
		      }
                      
                      session.setAttribute("mStrProgramCode11",mStrProgramCode11);
                      }

                    %>
                    <td style="text-align: right">Branch Code:<font color='red'> *</font> :</td>
                    <td>
                        <SELECT id=branchCode style="WIDTH: 250px; HEIGHT: 70px" multiple size=2 name=branchCode>

	<%
	try
        {
            // System.out.println("333333---444444444444444444444");
            if (request.getParameter("btn3") != null)
            {
               // System.out.println("666666---btn3");
            qry3="select distinct nvl(branchcode,'')branchcode  from studentmaster where institutecode in ("+session.getAttribute("mStrInst").toString()+")  and academicyear IN ("+session.getAttribute("mStrAcademicYear").toString()+") AND PROGRAMCODE IN ("+mStrProgramCode11+")";
            rs3=db.getRowset(qry3);
            }
           // else if(request.getParameter("temp3").toString() != "")
             else if(session.getAttribute("mStrProgramCode11").toString()!=""&&session.getAttribute("mStrProgramCode11").toString()!=null)
            {
                //System.out.println("7777777---btn3");
                //System.out.println(request.getParameter("Academicyr").toString());
              qry3="select distinct nvl(branchcode,'')branchcode  from studentmaster where institutecode in ("+session.getAttribute("mStrInst").toString()+")  and academicyear IN ("+session.getAttribute("mStrAcademicYear").toString()+") AND PROGRAMCODE IN ("+session.getAttribute("mStrProgramCode11").toString()+")";
              rs3=db.getRowset(qry3);
            }

         if(rs3!=null)
        {
             //System.out.println("44444444---btn3");
	while(rs3.next())
	{
           // System.out.println("5555555---");
            mBranchCode=rs3.getString("branchcode");
	%>
	<OPTION Value =<%=mBranchCode%>><%=mBranchCode%></option>
	<%
       	}
        }
        }
        catch(Exception e)
        {
          // e.printStackTrace();

        }
	%>
	</SELECT>
                    </td>
                    <td>
                         <input type="Submit"  id="btn4" class="btn4" name="btn4" value=">>"   >
                    </td>
                </tr>
                <%
                    if (request.getParameter("btn4") != null){
                       // System.out.println("333333---6666666btn4");
                     
                      String [] mBranchCode111=request.getParameterValues("branchCode");
		      for (int i=0;i<mBranchCode111.length;i++)
		      {
			if(mStrBranchCode11.equals(""))
				mStrBranchCode11="'"+mBranchCode111[i]+"'";
			else
				mStrBranchCode11=mStrBranchCode11+",'"+mBranchCode111[i]+"'";
		      }
                      session.setAttribute("mStrBranchCode11",mStrBranchCode11);
                      }

                    %>
<tr>
                  
         <td style="text-align: right">Exam Code:<font color='red'> *</font> :</td>
                    <td>
                        <SELECT id=examCode style="WIDTH: 250px; HEIGHT: 70px" multiple size=2 name=examCode>

	<%
	try
        {
             //System.out.println("333333---223333");
             //System.out.println("------"+session.getAttribute("mStrAcademicYear").toString()+"**************"+session.getAttribute("mStrInst").toString());
            if (request.getParameter("btn4") != null)
            {
                System.out.println("666666---btn4");
            qry4="select distinct nvl(a.EXAMCODE,'')EXAMCODE,b.EXAMPERIODFROM from STUDENTREGISTRATION a,exammaster b where a.INSTITUTECODE in ("+session.getAttribute("mStrInst").toString()+") AND a.AcademicYear IN ("+session.getAttribute("mStrAcademicYear").toString()+")  AND a.PROGRAMCODE in ("+session.getAttribute("mStrProgramCode11").toString()+") and a.INSTITUTECODE=b.INSTITUTECODE and a.EXAMCODE=b.EXAMCODE order by b.EXAMPERIODFROM desc ";
            rs4=db.getRowset(qry4);
            }
           // else if(request.getParameter("temp2").toString() != "")
             else if(session.getAttribute("mStrBranchCode11").toString()!=""&&session.getAttribute("mStrBranchCode11").toString()!=null)
            {
               // System.out.println("7777777---********btn4else");
               // System.out.println(request.getParameter("Academicyr").toString());
              qry4="select distinct nvl(EXAMCODE,'')EXAMCODE from STUDENTREGISTRATION where INSTITUTECODE in ("+session.getAttribute("mStrInst").toString()+") AND AcademicYear IN ("+session.getAttribute("mStrAcademicYear").toString()+") AND PROGRAMCODE in ("+session.getAttribute("mStrProgramCode11").toString()+") ";
             // System.out.println("7777777---!!!!!!!!"+qry2);
              rs4=db.getRowset(qry4);
            }

         if(rs4!=null)
        {
            // System.out.println("44444444---in 2");
	while(rs4.next())
	{

            mExamCode=rs4.getString("EXAMCODE");
	%>
	<OPTION Value =<%=mExamCode%>><%=mExamCode%></option>
	<%
       	}
        }
             //System.out.println("5555555---");
        }
        catch(Exception e)
        {
          // e.printStackTrace();

        }
	%>
	</SELECT>
                    </td>
                    <td>
                         <input type="Submit"  id="btn5" class="btn5" name="btn5" value=">>"   >
                    </td>
                    <%
                    if (request.getParameter("btn5") != null){
                       //System.out.println("333333---6666666btn5");
                      //temp3="right";
                      String [] mExamCode111=request.getParameterValues("examCode");
		      for (int i=0;i<mExamCode111.length;i++)
		      {
			if(mStrExamCode11.equals(""))
				mStrExamCode11="'"+mExamCode111[i]+"'";
			else
				mStrExamCode11=mStrExamCode11+",'"+mExamCode111[i]+"'";
		      }
                       session.setAttribute("mStrExamCode11",mStrExamCode11);
                      }

                    %>
               
                    <td style="text-align: right">Quota:<font color='red'> *</font> :</td>
                    <td>
                        <SELECT id=quota style="WIDTH: 250px; HEIGHT: 70px" multiple size=2 name=quota>

	<%
	try
        {
             //System.out.println("333333---444444444444444444444");
            if (request.getParameter("btn5") != null)
            {
                //System.out.println("666666---btn5");
            qry5="select  distinct nvl(QUOTA,'')QUOTA  from studentmaster where QUOTA IS NOT NULL and INSTITUTECODE in ("+session.getAttribute("mStrInst").toString()+") AND ACADEMICYEAR IN ("+session.getAttribute("mStrAcademicYear").toString()+")  ORDER BY QUOTA";
            //System.out.println("666666---btn5"+qry5);
            rs5=db.getRowset(qry5);
            }
           // else if(request.getParameter("temp3").toString() != "")
             else if(session.getAttribute("mStrExamCode11").toString()!=""&&session.getAttribute("mStrExamCode11").toString()!=null)
            {
                //System.out.println("7777777---btn5");
                //System.out.println(request.getParameter("Academicyr").toString());
              qry5="select  distinct nvl(QUOTA,'')QUOTA  from studentmaster where QUOTA IS NOT NULL and INSTITUTECODE in ("+session.getAttribute("mStrInst").toString()+") AND ACADEMICYEAR IN ("+session.getAttribute("mStrAcademicYear").toString()+")  ORDER BY QUOTA";
              rs5=db.getRowset(qry5);
            }

         if(rs5!=null)
        {
             //System.out.println("44444444---");
	while(rs5.next())
	{
           // System.out.println("5555555---");
            mQuota=rs5.getString("QUOTA");
	%>
	<OPTION Value =<%=mQuota%>><%=mQuota%></option>
	<%
       	}
        }
        }
        catch(Exception e)
        {
          // e.printStackTrace();

        }
	%>
	</SELECT>
                    </td>
                    <td>
                       <!--  <input type="Submit"  id="btn6" class="btn6" name="btn4" value=">>"   >-->
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right">Registration Confirmation</td><td style="text-align: left">
                        <select  name='regConfirmation' id='regConfirmation'  class='combo' style=''  title='Registration Confirmation'>
                            <option value='0'>Select Registration Confirmation</option>
                            <option value='ALL'>All</option>
                            <option value='Y'>Yes</option>
                            <option value='N'>No</option>
                        </select>
                    </td>
                    <td style="text-align: right">Deactive:</td><td style="text-align: left">
                        <select  name='deactive' id='deactive'  class='combo' style=''  title='Deactive'>
                            <option value='0'>Select Deactive</option>
                            <option value='ALL'>All</option>
                            <option value='Y'>Yes</option>
                            <option value='N'>No</option>
                        </select>
                    </td>
                    <td style="text-align: right">Gender</td><td style="text-align: left">
                        <select  name='gender' id='gender'  class='combo' style=''  title='Gender'>
                            <option value='0'>Select Gender</option>
                            <option value='ALL'>All</option>
                            <option value='M'>Male</option>
                            <option value='F'>Female</option>
                        </select>
                    </td>
                </tr>
                <tr>   </tr>
                <tr>   </tr>
                <tr>   </tr>
                <tr>   </tr>
                <tr>   </tr>
                <tr>   </tr>
                <tr>   </tr>
                <tr>   </tr>
                <tr>   </tr>
                <tr>   </tr>
                <tr>   </tr>
                <tr>   </tr>
                <tr>   </tr>
                <tr>   </tr>
                <tr>   </tr>
                <tr>   </tr>
                <tr>   </tr>
                <tr>   </tr>
                <tr>   </tr>
                <tr>   </tr>
                <tr>   </tr>
                <tr>   </tr>
               
                <tr>
                    
                    <td colspan="6" align="right"><input type="Submit"  id="btn7" class="btn7" name="btn7" value="Submit" style="margin-right: 50%" onclick="return validateform()"   ></td>
                    <%
                  if (request.getParameter("btn7") != null){
                      //INSTITUTECODE
                       String [] mInst1=request.getParameterValues("instituteCode");
                       
		      for (int i=0;i<mInst1.length;i++)
		      {
			if(mStrInst.equals(""))
				mStrInst="'"+mInst1[i]+"'";
			else
				mStrInst=mStrInst+",'"+mInst1[i]+"'";
		      }

                      session.setAttribute("mStrInst", mStrInst);

                      //academicYear
                      
                      String [] mAcademicYear1=request.getParameterValues("academicYear");
		      for (int i=0;i<mAcademicYear1.length;i++)
		      {
			if(mStrAcademicYear.equals(""))
				mStrAcademicYear="'"+mAcademicYear1[i]+"'";
			else
				mStrAcademicYear=mStrAcademicYear+",'"+mAcademicYear1[i]+"'";
		      }

                      //programCode
                      
                      String [] mProgramCode111=request.getParameterValues("programCode");
		      for (int i=0;i<mProgramCode111.length;i++)
		      {
			if(mStrProgramCode11.equals(""))
				mStrProgramCode11="'"+mProgramCode111[i]+"'";
			else
				mStrProgramCode11=mStrProgramCode11+",'"+mProgramCode111[i]+"'";
		      }
                      session.setAttribute("mStrProgramCode11",mStrProgramCode11);

                      //branchCode

                      String [] mBranchCode111=request.getParameterValues("branchCode");
		      for (int i=0;i<mBranchCode111.length;i++)
		      {
			if(mStrBranchCode11.equals(""))
				mStrBranchCode11="'"+mBranchCode111[i]+"'";
			else
				mStrBranchCode11=mStrBranchCode11+",'"+mBranchCode111[i]+"'";
		      }
                      session.setAttribute("mStrBranchCode11",mStrBranchCode11);

                      //examCode

                      String [] mExamCode111=request.getParameterValues("examCode");
		      for (int i=0;i<mExamCode111.length;i++)
		      {
			if(mStrExamCode11.equals(""))
				mStrExamCode11="'"+mExamCode111[i]+"'";
			else
				mStrExamCode11=mStrExamCode11+",'"+mExamCode111[i]+"'";
		      }
                       session.setAttribute("mStrExamCode11",mStrExamCode11);

                       //quota
                      
                      String [] mQuota111=request.getParameterValues("quota");
                      session.setAttribute("mStrAcademicYear",mStrAcademicYear);
                        for (int i=0;i<mQuota111.length;i++)
		          {
			if(mStrQuota11.equals(""))
				mStrQuota11="'"+mQuota111[i]+"'";
			else
				mStrQuota11=mStrQuota11+",'"+mQuota111[i]+"'";
		            }

                       session.setAttribute("mStrQuota11",mStrQuota11);

                      int j=1;
                      int k=1;
                      Map data = new HashMap();
                      Map tm = new HashMap();
                      StringBuilder sb = new StringBuilder();
                       //System.out.println("333333---submitReport");
                       qry6="select distinct NVL(A.INSTITUTECODE,'')  INSTITUTECODE,NVL(A.ACADEMICYEAR,'') ACADEMICYEAR,NVL(A.ENROLLMENTNO,'N/A') ENROLLMENTNO,NVL(A.STUDENTNAME,'') STUDENTNAME";
                       qry6=qry6+",NVL(A.PROGRAMCODE,'') PROGRAMCODE,NVL(A.BRANCHCODE,'') BRANCHCODE,NVL(A.SUBSECTIONCODE,'N/A') SUBSECTIONCODE,NVL(A.SEMESTER,'') SEMESTER,NVL( A.DEACTIVE,'N' )  DEACTIVESTATUS,";
                       qry6=qry6+"to_char(A.DATEOFBIRTH,'dd-mm-yyyy') DATEOFBIRTH,NVL(A.FATHERNAME,'') FATHERNAME,NVL(A.QUOTA,'') QUOTA,NVL(B.REGCONFIRMATION,'N/A') REGISTRATIONCONFIRMATION ,NVL(C.STCELLNO,'')";
                       qry6=qry6+" STUDENTPHONENUMBER,NVL(C.STEMAILID,'') STUDENTEMAILID ,D.CADDRESS1||','||D.CADDRESS2||','||D.CADDRESS3||','||D.CDISTRICT||','";
                       qry6=qry6+"||D.CSTATE AS CURRENTADDRESS,D.PADDRESS1||','||D.PADDRESS2||','||D.PADDRESS3||','||D.PDISTRICT||','||D.PSTATE AS PURMANENTADDRESS,";
                       qry6=qry6+" NVL(B.EXAMCODE,'') EXAMCODE, NVL(A.SEX,'') SEX  from studentmaster A,STUDENTREGISTRATION B , STUDENTPHONE C ,STUDENTADDRESS D where A.INSTITUTECODE IN ("+session.getAttribute("mStrInst").toString()+") AND";
                       qry6=qry6+" A.ACADEMICYEAR IN ("+session.getAttribute("mStrAcademicYear").toString()+") AND  A.PROGRAMCODE IN ("+session.getAttribute("mStrProgramCode11").toString()+") AND  A.BRANCHCODE IN ("+session.getAttribute("mStrBranchCode11").toString()+")  AND";
                       qry6=qry6+"     b.EXAMCODE IN ("+session.getAttribute("mStrExamCode11").toString()+") AND   A.QUOTA IN ("+session.getAttribute("mStrQuota11").toString()+")  ";
                         if(!request.getParameter("gender").toString().trim().equals("ALL"))
                             {
                                    qry6=qry6+" AND A.SEX='"+request.getParameter("gender").toString().trim()+"'";
                                    session.setAttribute("gender",request.getParameter("gender").toString().trim());
                                   // System.out.println("gender--"+session.getAttribute("gender").toString().trim());

                             }
                        if(!request.getParameter("deactive").toString().trim().equals("ALL"))
                             {
                                   qry6=qry6+" AND  NVL(A.DEACTIVE,'N')='"+request.getParameter("deactive").toString().trim()+"'";
                                   session.setAttribute("deactive",request.getParameter("deactive").toString().trim());
                                  // System.out.println("deactive---"+session.getAttribute("deactive").toString().trim());
                             }
                        if(!request.getParameter("regConfirmation").toString().trim().equals("ALL"))
                              {
                                   qry6=qry6+" AND b.regconfirmation='"+request.getParameter("regConfirmation").toString().trim()+"'";
                                   session.setAttribute("regConfirmation",request.getParameter("regConfirmation").toString().trim());
                                  // System.out.println("regConfirmation---"+session.getAttribute("regConfirmation").toString().trim());
                              }
                       qry6=qry6+" AND  A.STUDENTID =B.STUDENTID";
                       qry6=qry6+" AND A.STUDENTID =C.STUDENTID(+) AND A.STUDENTID =D.STUDENTID(+) AND A.ACADEMICYEAR=B.ACADEMICYEAR";
                       rs6=db.getRowset(qry6);
                       %>
       <br><br><br> <table  bgcolor=#fce9c5 class="sort-table" id="table-1"   ALIGN=center rules=COLUMNS CELLSPACING=0   BORDER=1><tr bgcolor='#c00000'>
        <td ><b><font color='white' size='1' style='font-family:arial;width:2%'>Sno</font></td>
        <td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Institute Code</font></td>
        <td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Academic Year</font></td>
        <td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Enrollment No</font></td>
        <td ><b><font color='white' size='1' style='font-family:arial;width:8%'>Student Name</font></td>
        <td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Program Code</font></td>
        <td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Branch Code</font></td>
        <td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Subsection Code</font></td>
        <td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Semester</font></td>
        <td ><b><font color='white' size='1' style='font-family:arial;width:2%'>Deactive</font></td>
        <td nowrap><b><font color='white' size='1' style='font-family:arial;width:5%'>Date of Birth</font></td>
        <td ><b><font color='white' size='1' style='font-family:arial;width:8%'>Father Name</font></td>
        <td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Quota</font></td>
        <td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Reg Confirmation</font></td>
        <td ><b><font color='white' size='1' style='font-family:arial;width:5%'>Phone Number</font></td>
        <td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Mail ID</font></td>
        <td ><b><font color='white' size='1' style='font-family:arial;width:8%'>Current Address</font></td>
        <td ><b><font color='white' size='1' style='font-family:arial;width:8%'>Permanent Address</font></td>
        <td ><b><font color='white' size='1' style='font-family:arial;width:8%'>Exam Code</font></td>
        <td ><b><font color='white' size='1' style='font-family:arial;width:8%'>Gender</font></td> </tr>

                    <%
                      
                    while(rs6.next())
                        {
                         
                         %>
                          <tr>
                       <td ><b><font color='white' size='1' style='font-family:arial;width:2%'></font><%=j%></td>
        <td ><b><font color='white' size='1' style='font-family:arial;width:5%'></font><%=rs6.getString(1)%></td>
        <td ><b><font color='white' size='1' style='font-family:arial;width:5%'></font><%=rs6.getString(2)%></td>
        <td ><b><font color='white' size='1' style='font-family:arial;width:5%'></font><%=rs6.getString(3)%></td>
        <td ><b><font color='white' size='1' style='font-family:arial;width:8%'></font><%=rs6.getString(4)%></td>
        <td ><b><font color='white' size='1' style='font-family:arial;width:5%'></font><%=rs6.getString(5)%></td>
        <td ><b><font color='white' size='1' style='font-family:arial;width:5%'></font><%=rs6.getString(6)%></td>
        <td ><b><font color='white' size='1' style='font-family:arial;width:5%'></font><%=rs6.getString(7)%></td>
        <td ><b><font color='white' size='1' style='font-family:arial;width:2%'></font><%=rs6.getString(8)%></td>
        <td ><b><font color='white' size='1' style='font-family:arial;width:5%'></font><%=rs6.getString(9)%></td>
        <td nowrap><b><font color='white' size='1' style='font-family:arial;width:8%'></font><%=rs6.getString(10)%></td>
        <td ><b><font color='white' size='1' style='font-family:arial;width:5%'></font><%=rs6.getString(11)%></td>
        <td ><b><font color='white' size='1' style='font-family:arial;width:5%'></font><%=rs6.getString(12)%></td>
        <td ><b><font color='white' size='1' style='font-family:arial;width:5%'></font><%=rs6.getString(13)%></td>
        <td ><b><font color='white' size='1' style='font-family:arial;width:4%'></font><%=rs6.getString(14)%></td>
        <td ><b><font color='white' size='1' style='font-family:arial;width:8%'></font><%=rs6.getString(15)%></td>
        <td ><b><font color='white' size='1' style='font-family:arial;width:8%'></font><%=rs6.getString(16)%></td>
        <td ><b><font color='white' size='1' style='font-family:arial;width:8%'></font><%=rs6.getString(17)%></td>
        <td ><b><font color='white' size='1' style='font-family:arial;width:8%'></font><%=rs6.getString(18)%></td>
        <td ><b><font color='white' size='1' style='font-family:arial;width:5%'></font><%=rs6.getString(19)%></td>
                </tr>
                     
                       
                       <%
            j++;
            k++;
                    }
                       if(k>1){
                       %>
                       
       <br><tr><img src="../Images/bullet4.gif">&nbsp;<a   title="Continue to Student Master (Bulk)" href="../CommonFiles/StudentMasterBulkXLS.jsp" ><FONT face="Arial" color =black size=2 ><STRONG>Click here to Export in Exel</STRONG></font></a></tr><br>
       <tr>Total no. of Record  <%=j-1%></tr>
       </table>
                       <%
                  }
		     }
                    else
                        {
                    
                    }

                 %>
                </tr>
                 
            </table>
                <!--</div>-->
                <div id="printable">
                    <div id="total">
                    </div>
                    <table class="sort-table" id="TblStdView" rules='ALL' style="width:auto;" cellSpacing=0 cellPadding=0  align=center border=1>

                        <thead id="gridhead">


                        </thead>
                        <tbody id="gridbody" style="width:auto;">

                        </tbody>
                    </table></div>

              </form>



        <%                //-----------------------------
            //-- Enable Security Page Level
            //-----------------------------
        } else {
        %>
        <br>
        <font color=red>
        <h3>	<br><img src='../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
        <P>	This page is not authorized/available for you.
            <br>For assistance, contact your network support team.
            </font>	<br>	<br>	<br>	<br>
            <%           }
                    //-----------------------------







                } else {
                    out.print("<br><img src='Images/Error1.jpg'>");
                    out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='index.jsp'>Login</a> to continue</font> <br>");
                }

            %>
    </body>
</html>