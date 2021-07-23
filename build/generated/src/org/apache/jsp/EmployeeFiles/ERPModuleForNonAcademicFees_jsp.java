package org.apache.jsp.EmployeeFiles;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import tietwebkiosk.*;
import java.util.*;
import jilit.db.CommonComboData;

public final class ERPModuleForNonAcademicFees_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			"ExceptionHandler.jsp", true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");

String mHead="",mInstCode ="";
String mCandCode="", MName="";
String mCandName="",mINSTITUTECODE="",mStudentName="",mACADEMICYEAR="",mPROGRAMCODE="",mBRANCHCODE="",mSEMESTER="";

String URL="";
int mFeeHeadQty=0;
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";

      out.write("\n");
      out.write("<HTML>\n");
      out.write("<head>\n");
      out.write("        <script type=\"text/javascript\" src=\"js/sortabletable.js\"></script>\n");
      out.write("        <script type=\"text/javascript\" src=\"js/json2.js\"></script>\n");
      out.write("        <link type=\"text/css\" rel=\"StyleSheet\" href=\"css/sortabletable.css\" />\n");
      out.write("\n");
      out.write("        <script src=\"../IQAC/js/jquery/jquery-1.10.2.js\"></script>\n");
      out.write("        <script src=\"../IQAC/js/jquery/jquery-ui.js\"></script>\n");
      out.write("        <script src=\"../IQAC/js/jquery/yattable.js\"></script>\n");
      out.write("        <script src=\"../IQAC/js/jquery/numeric-1.0.js\"></script>\n");
      out.write("        <script src=\"../IQAC/js/IQTest/CommonServiceJs.js\"></script>\n");
      out.write("        <script src=\"../IQAC/js/IQTest/ComboJs.js\"></script>\n");
      out.write("        <script src=\"js/ERPModuleForNonAcademicFees.js\"></script>\n");
      out.write("         <script type=\"text/javascript\">\n");
      out.write("        function mult(id) {\n");
      out.write("            var totalQty=document.getElementById(id).value;\n");
      out.write("            var num=id.substr(3);\n");
      out.write("           // alert(num);\n");
      out.write("           // var n1=num-1;\n");
      out.write("           var n1=num;\n");
      out.write("            //var n2=++num;\n");
      out.write("            var txt1=\"RATE\".concat(n1);\n");
      out.write("            var txt2=id;\n");
      out.write("            var txt3=\"AMT\".concat(n1);\n");
      out.write("            var txt4=\"AMOUNT\".concat(n1);\n");
      out.write("            //alert(\"Amount--\"+document.getElementsByName(txt4).value);\n");
      out.write("        \n");
      out.write("            var txtFirstNo = document.getElementById(txt1).value;\n");
      out.write("            var txtSecondNo = document.getElementById(txt2).value;\n");
      out.write("            var result = parseInt(txtFirstNo) * parseInt(txtSecondNo);\n");
      out.write("            if (!isNaN(result)) {\n");
      out.write("                document.getElementById(txt3).value = Number(result);\n");
      out.write("            }\n");
      out.write("            /*totalQty=Number(totalQty) + Number(document.getElementById('TotalQty').value);\n");
      out.write("            if (!isNaN(totalQty)) {\n");
      out.write("                document.getElementById('TotalQty').value = totalQty;\n");
      out.write("            }*/\n");
      out.write("            var totalAmt=document.getElementById(txt3).value;\n");
      out.write("            var AMOUNT=document.getElementById(txt4).value;\n");
      out.write("            //alert(\"totalAmt--\"+totalAmt);\n");
      out.write("            if(Number(AMOUNT)>0)\n");
      out.write("            {\n");
      out.write("                //alert(\"AMOUNT--\"+AMOUNT);\n");
      out.write("              totalAmt=Number(totalAmt) + Number(document.getElementById('TotalAmt').value)-Number(AMOUNT);\n");
      out.write("              if (!isNaN(totalAmt))\n");
      out.write("              {\n");
      out.write("                document.getElementById('TotalAmt').value = Number(totalAmt);\n");
      out.write("              }\n");
      out.write("            }\n");
      out.write("            else\n");
      out.write("            {\n");
      out.write("            //alert(\"AMOUNT1--\"+AMOUNT);\n");
      out.write("            totalAmt=Number(totalAmt) + Number(document.getElementById('TotalAmt').value)-Number(AMOUNT);\n");
      out.write("            if (!isNaN(totalAmt))\n");
      out.write("             {\n");
      out.write("               document.getElementById('TotalAmt').value = Number(totalAmt);\n");
      out.write("             }\n");
      out.write("            }\n");
      out.write("          }\n");
      out.write(" function AvoidSpace(event)\n");
      out.write(" {\n");
      out.write("    var k = event ? event.which : window.event.keyCode;\n");
      out.write("    if (k == 32) return false;\n");
      out.write(" }\n");
      out.write("            \n");
      out.write("\n");
      out.write("      /*  function add(id) {\n");
      out.write("           // alert(\"123\");\n");
      out.write("            var totalAmount=document.getElementById(id).value;\n");
      out.write("            totalAmount=totalAmount + document.getElementById('txt31').value;\n");
      out.write("            \n");
      out.write("            if (!isNaN(totalAmount)) {\n");
      out.write("                document.getElementById('txt32').value = totalAmount;\n");
      out.write("            }\n");
      out.write("        }*/\n");
      out.write("    </script>\n");
      out.write("\n");
      out.write("<TITLE>#### ");
      out.print(mHead);
      out.write(" [ View Students Profile/Information ] </TITLE>\n");
      out.write("\n");
      out.write("\n");
      out.write("<script>\n");
      out.write("if(window.history.forward(1) != null)\n");
      out.write("window.history.forward(1);\n");
      out.write("</script>\n");
      out.write("\n");
      out.write("<script language=javascript>\n");
      out.write("\n");
      out.write("\tfunction RefreshContents()\n");
      out.write("\t{\n");
      out.write("    \t    document.frm.x.value='ddd';\n");
      out.write("    \t    document.frm.submit();\n");
      out.write("\t}\n");
      out.write("//-->\n");
      out.write("</SCRIPT>\n");
      out.write("<script>\n");
      out.write("if(window.history.forward(1) != null)\n");
      out.write("window.history.forward(1);\n");
      out.write("</script>\n");
      out.write("</head>\n");
      out.write("<body aLink=#ff00ff bgcolor=\"#fce9c5\" rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>\n");

//GlobalFunctions gb =new GlobalFunctions();
CommonComboData ccd=new CommonComboData();
DBHandler db=new DBHandler();
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="",mDept="",mDesg="",mInst="",minst="",mDMemberID="";
String qry="",qry1="",qrys="", mEnOrNm="", x="",cInst="",mCheck="",qryi="",qrylink="",qrycount="";
String mStudentId="",mAcademicYear="",mProgramcode="",mEnrollmentno="",mBranchcode="",mEnrollMentNo="",mTempEnrollmentno="",mDeptCode="";
int msno=0;
ResultSet rs=null,rs1=null,rss=null,rslink=null,rscount=null;
//ArrayList<String> list=new ArrayList<String>();
int ctr=0,count=0;
String mName1="",mName2="",mName3="",mName4="",mName5="",mName6="";
if (session.getAttribute("Designation")==null)
{
	mDesg="";
}
else
{
	mDesg=session.getAttribute("Designation").toString().trim();
}

if (session.getAttribute("Department")==null)
{
	mDept="";
}
else
{
	mDept=session.getAttribute("Department").toString().trim();
}
if (session.getAttribute("DepartmentCode")==null)
{
	mDeptCode="";
}
else
{
	mDeptCode=session.getAttribute("DepartmentCode").toString().trim();
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

if (session.getAttribute("InstituteCode")==null)
{
	mInstCode ="JIIT";
}
else
{
	mInstCode =session.getAttribute("InstituteCode").toString().trim();
}
session.setAttribute("INSCODE"," ");
OLTEncryption enc=new OLTEncryption();
   if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);
		mDMemberID=enc.decode(mMemberID);

		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk1=null;
		  //-----------------------------
		  //-- Enable Security Page Level
		  //-----------------------------
		qry="Select WEBKIOSK.ShowLink('415','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      	RsChk1= db.getRowset(qry);
		if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
		   {
                    
      out.write("\n");
      out.write("                    <form name=\"frm\" method=\"get\">\n");
      out.write("                        <table width=\"60%\"  border=1  rules=none align=center   topmargin=0 cellspacing=0 cellpadding=1 borderColor=\"#D98242\" >\n");
      out.write("                          \n");
      out.write("                            <tr>\n");
      out.write("                                <td  align=center colspan=1>&nbsp;Enrollment Number</td>\n");
      out.write("                                <td><input  type=text  name=\"EnrollMentNo\"  onchange=\"return ChangeCase()\" id=\"EnrollMentNo\" width=150px maxlength=50 onkeypress=\"return AvoidSpace(event)\"></td>\n");
      out.write("                            </tr>\n");
      out.write("                        \n");
      out.write("                            <tr>\n");
      out.write("                                <td  align=center colspan=2>OR</td>\n");
      out.write("                            </tr>\n");
      out.write("\n");
      out.write("                            \n");
      out.write("                 <tr>\n");
      out.write("                    <td style=\"text-align: right\">Institute Code<span class=\"req\"><font color='red'> *</font></span> :</td><td style=\"text-align: left\"><select  name='instituteCode' id='instituteCode'  class='combo'  title='Institute Code' onchange=\"getAcademicYear()\">");
      out.print(ccd.commonJspCombo("{\"comboId\":\"instituteCodeCombo1\"}"));
      out.write("</select></td>\n");
      out.write("                    <td style=\"text-align: right\">Academic Year<font color='red'> *</font> :</td><td style=\"text-align: left\"><select  name='academicYear' id='academicYear'  class='combo' style=''  title='Academic Year' onchange=\"getProgramCode()\"><option value='0'>Select Academic Year</option></select></td>\n");
      out.write("\n");
      out.write("                </tr>\n");
      out.write("                <tr>\n");
      out.write("                    <td style=\"text-align: right\">Program Code:</td><td style=\"text-align: left\"><select  name='programCode' id='programCode'  class='combo' style=''  title='Program Code' onchange=\"getBranchCode()\"><option value='0'>Select Program Code</option></select></td>\n");
      out.write("                    <td style=\"text-align: right\">Branch Code:</td><td style=\"text-align: left\"><select  name='branchCode' id='branchCode'  class='combo' style=''  title='Branch Year' onchange=\"getEnrollMentNo()\"><option value='0'>Select Branch Code</option></select></td>\n");
      out.write("                </tr>\n");
      out.write("                <tr>\n");
      out.write("                    <td style=\"text-align: right\">EnrollMent Number:</td><td style=\"text-align: left\" ><select  name='enrollmentno' id='enrollmentno'  class='combo' style=''  title='EnrollMent Number'><option value=''>Select EnrollMent Number</option></td>\n");
      out.write("                </tr>\n");
      out.write("\n");
      out.write("                            \n");
      out.write("                          \n");
      out.write("                            <tr>\n");
      out.write("                            <br>\n");
      out.write("                            <td align=center colspan=4><input type=\"submit\"  border= \"3px\" name=\"submit\" id=\"submit\" value=\"&nbsp; Submit &nbsp;\" onClick=\"return Valid()\" >\n");
      out.write("                                </br>\n");
      out.write("                            </td>\n");
      out.write("                        </tr>\n");
      out.write("                            \n");
      out.write("                        </table>\n");
      out.write("              <script>\n");
      out.write("                  function Valid(){\n");
      out.write("if(jQuery.trim($('#EnrollMentNo').val()) == 0 && jQuery.trim($('#instituteCode').val()) == 0 && jQuery.trim($('#academicYear').val()) == 0 && jQuery.trim($('#programCode').val()) == 0 && jQuery.trim($('#branchCode').val()) == 0 && jQuery.trim($('#enrollmentno').val()) == 0)\n");
      out.write(" {\n");
      out.write("alert(\"Please Select the Enrollment Number OR Other Options\");\n");
      out.write("return false;\n");
      out.write(" }\n");
      out.write(" if (jQuery.trim($('#EnrollMentNo').val()) == 0 && jQuery.trim($('#instituteCode').val()) != 0 && jQuery.trim($('#academicYear').val()) != 0 && jQuery.trim($('#programCode').val()) != 0 && jQuery.trim($('#branchCode').val()) != 0 && jQuery.trim($('#enrollmentno').val()) != 0 ) {\n");
      out.write("\n");
      out.write("  return true;\n");
      out.write("  }\n");
      out.write("if (jQuery.trim($('#EnrollMentNo').val()) == 0 && jQuery.trim($('#instituteCode').val()) == 0 && jQuery.trim($('#academicYear').val()) != 0 && jQuery.trim($('#programCode').val()) != 0 && jQuery.trim($('#branchCode').val()) != 0 && jQuery.trim($('#enrollmentno').val()) != 0 ) {\n");
      out.write("      alert(\"Please Select Select Value\");\n");
      out.write("    return false;\n");
      out.write("     }\n");
      out.write("     if (jQuery.trim($('#EnrollMentNo').val()) == 0 && jQuery.trim($('#instituteCode').val()) == 0 && jQuery.trim($('#academicYear').val()) == 0 && jQuery.trim($('#programCode').val()) != 0 && jQuery.trim($('#branchCode').val()) != 0 && jQuery.trim($('#enrollmentno').val()) != 0 ) {\n");
      out.write("      alert(\"Please Select Select Value\");\n");
      out.write("    return false;\n");
      out.write("        }\n");
      out.write("      if (jQuery.trim($('#EnrollMentNo').val()) == 0 && jQuery.trim($('#instituteCode').val()) == 0 && jQuery.trim($('#academicYear').val()) == 0 && jQuery.trim($('#programCode').val()) == 0 && jQuery.trim($('#branchCode').val()) != 0 && jQuery.trim($('#enrollmentno').val()) != 0 ) {\n");
      out.write("      alert(\"Please Select Select Value\");\n");
      out.write("    return false;\n");
      out.write("        }\n");
      out.write("         if (jQuery.trim($('#EnrollMentNo').val()) == 0 && jQuery.trim($('#instituteCode').val()) == 0 && jQuery.trim($('#academicYear').val()) == 0 && jQuery.trim($('#programCode').val()) == 0 && jQuery.trim($('#branchCode').val()) == 0 && jQuery.trim($('#enrollmentno').val()) != 0 ) {\n");
      out.write("      alert(\"Please Select Select Value\");\n");
      out.write("    return false;\n");
      out.write("        }\n");
      out.write("           if (jQuery.trim($('#EnrollMentNo').val()) !=0 && jQuery.trim($('#instituteCode').val()) == 0 && jQuery.trim($('#academicYear').val()) == 0 && jQuery.trim($('#programCode').val()) == 0 && jQuery.trim($('#branchCode').val()) == 0 && jQuery.trim($('#enrollmentno').val()) == 0 ) {\n");
      out.write("    \n");
      out.write("    return true;\n");
      out.write("        }\n");
      out.write("        if (jQuery.trim($('#EnrollMentNo').val()) == 0 && jQuery.trim($('#instituteCode').val()) != 0 && jQuery.trim($('#academicYear').val()) == 0 && jQuery.trim($('#programCode').val()) == 0 && jQuery.trim($('#branchCode').val()) == 0 && jQuery.trim($('#enrollmentno').val()) == 0 ) {\n");
      out.write("      alert(\"Please Select Select Value\");\n");
      out.write("    return false;\n");
      out.write("        }\n");
      out.write("           if (jQuery.trim($('#EnrollMentNo').val()) == 0 && jQuery.trim($('#instituteCode').val()) != 0 && jQuery.trim($('#academicYear').val()) != 0 && jQuery.trim($('#programCode').val()) == 0 && jQuery.trim($('#branchCode').val()) == 0 && jQuery.trim($('#enrollmentno').val()) == 0 ) {\n");
      out.write("      alert(\"Please Select Select Value\");\n");
      out.write("    return false;\n");
      out.write("        }\n");
      out.write("           if (jQuery.trim($('#EnrollMentNo').val()) == 0 && jQuery.trim($('#instituteCode').val()) != 0 && jQuery.trim($('#academicYear').val()) != 0 && jQuery.trim($('#programCode').val()) != 0 && jQuery.trim($('#branchCode').val()) == 0 && jQuery.trim($('#enrollmentno').val()) == 0 ) {\n");
      out.write("      alert(\"Please Select Select Value\");\n");
      out.write("    return false;\n");
      out.write("        }\n");
      out.write("           if (jQuery.trim($('#EnrollMentNo').val()) != 0 && jQuery.trim($('#instituteCode').val()) != 0 && jQuery.trim($('#academicYear').val()) != 0 && jQuery.trim($('#programCode').val()) != 0 && jQuery.trim($('#branchCode').val()) != 0 && jQuery.trim($('#enrollmentno').val()) == 0 ) {\n");
      out.write("      alert(\"Please Select Select Value\");\n");
      out.write("    return false;\n");
      out.write("        }\n");
      out.write("          if (jQuery.trim($('#EnrollMentNo').val()) == 0 && jQuery.trim($('#instituteCode').val()) != 0 && jQuery.trim($('#academicYear').val()) != 0 && jQuery.trim($('#programCode').val()) != 0 && jQuery.trim($('#branchCode').val()) != 0 && jQuery.trim($('#enrollmentno').val()) == 0 ) {\n");
      out.write("      alert(\"Please Select Select Value\");\n");
      out.write("    return false;\n");
      out.write("        }\n");
      out.write("                  }\n");
      out.write("               \n");
      out.write("              </script>\n");
      out.write("                   \n");
      out.write("    ");

    //System.out.println("EnrollMentNo--"+request.getParameter("EnrollMentNo").trim());
   // System.out.println("enrollmentno--"+request.getParameter("enrollmentno").trim());
	if(request.getParameter("EnrollMentNo")!=null || request.getParameter("enrollmentno")!=null )
        {
            //out.print("enrollmentno--"+request.getParameter("enrollmentno").trim());
            mEnrollMentNo=request.getParameter("EnrollMentNo").trim();
           //out.print("mEnrollMentNo--"+mEnrollMentNo);


            if(request.getParameter("EnrollMentNo").trim()!=null && !request.getParameter("EnrollMentNo").trim().equals(""))
                {
                qrys="Select studentid,ENROLLMENTNO,INSTITUTECODE,STUDENTNAME,ACADEMICYEAR,PROGRAMCODE,BRANCHCODE,SEMESTER from studentmaster where enrollmentno='"+request.getParameter("EnrollMentNo").trim()+"'";
				//out.print("enrollmentno1--"+request.getParameter("enrollmentno").trim());
                }
            else
                {
                mTempEnrollmentno=request.getParameter("enrollmentno").trim();
                String str=mTempEnrollmentno.toString();
                //System.out.println("Str--"+str);
                int pos11=str.indexOf("[");
               // System.out.println("pos11--"+pos11);
               // int pos12=str.in
                int len=str.length();
                mEnrollMentNo=str.substring(0,pos11);
               // System.out.println("mEnrollMentNo--"+mEnrollMentNo);
                //mEnrollMentNo=str.substring(pos11,len);
                qrys="Select studentid,ENROLLMENTNO,INSTITUTECODE,STUDENTNAME,ACADEMICYEAR,PROGRAMCODE,BRANCHCODE,SEMESTER from studentmaster where enrollmentno='"+mEnrollMentNo+"'";
				//out.print("enrollmentno2--"+request.getParameter("enrollmentno").trim());
                }
				//out.print(qrys);
            rss=db.getRowset(qrys);
            if(rss.next())
                {
                mStudentId=rss.getString("studentid");
                mINSTITUTECODE=rss.getString("INSTITUTECODE");
                mStudentName=rss.getString("STUDENTNAME");
                
                mACADEMICYEAR=rss.getString("ACADEMICYEAR");
                mPROGRAMCODE=rss.getString("PROGRAMCODE");
                mBRANCHCODE=rss.getString("BRANCHCODE");
                mSEMESTER=rss.getString("SEMESTER");
                mEnrollMentNo=rss.getString("ENROLLMENTNO");

                session.setAttribute("mStudentId",mStudentId);
                session.setAttribute("mINSTITUTECODE",mINSTITUTECODE);
                session.setAttribute("mStudentName",mStudentName);

                session.setAttribute("mACADEMICYEAR",mACADEMICYEAR);
                session.setAttribute("mPROGRAMCODE",mPROGRAMCODE);
                session.setAttribute("mBRANCHCODE",mBRANCHCODE);
                session.setAttribute("mSEMESTER",mSEMESTER);
                session.setAttribute("mEnrollMentNo",mEnrollMentNo);

                }
                
      out.write("\n");
      out.write("                 </form>\n");
      out.write("                 <form NAME=\"ErpForm\" action=\"ERPModuleForNonAcademicFeesAction.jsp\" method=post>\n");
      out.write("                            <table bgcolor=#fce9c5 class=\"sort-table\" id=\"table-1\" ALIGN=CENTER rules=COLUMNS CELLSPACING=0 width=76% BORDER=1>\n");
      out.write("                                <thead>\n");
      out.write("                                    <tr bgcolor=\"#ff8c00\">\n");
      out.write("                                        <td align=\"left\"><b><font color=white>EnrollmentNo.-Student Name</font></b></td>\n");
      out.write("                                        <td colspan=\"5\" align=\"left\"><b><font color=white>");
      out.print(mEnrollMentNo);
      out.write('-');
      out.print(mStudentName);
      out.write("</font></b></td>\n");
      out.write("                                    </tr>\n");
      out.write("                                    <tr bgcolor=\"#ff8c00\">\n");
      out.write("                                        <td align=\"left\"><b><font color=white>Academic Year</font></b></td>\n");
      out.write("                                        <td colspan=\"5\" align=\"left\"><b><font color=white>");
      out.print(mACADEMICYEAR);
      out.write("</font></b></td>\n");
      out.write("                                    </tr>\n");
      out.write("                                    <tr bgcolor=\"#ff8c00\">\n");
      out.write("                                        <td align=\"left\"><b><font color=white>Program</font></b></td>\n");
      out.write("                                        <td colspan=\"5\" align=\"left\"><b><font color=white>");
      out.print(mPROGRAMCODE);
      out.write("</font></b></td>\n");
      out.write("                                    </tr>\n");
      out.write("                                    <tr bgcolor=\"#ff8c00\">\n");
      out.write("                                        <td align=\"left\"><b><font color=white>Branch</font></b></td>\n");
      out.write("                                        <td colspan=\"5\" align=\"left\"><b><font color=white>");
      out.print(mBRANCHCODE);
      out.write("</font></b></td>\n");
      out.write("                                    </tr>\n");
      out.write("                                    <tr bgcolor=\"#ff8c00\">\n");
      out.write("                                        <td align=\"left\"><b><font color=white>Semester</font></b></td>\n");
      out.write("                                        <td colspan=\"5\" align=\"left\"><b><font color=white>");
      out.print(mSEMESTER);
      out.write("</font></b></td>\n");
      out.write("                                    </tr>\n");
      out.write("                                    <tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr>\n");
      out.write("                                        \n");
      out.write("                                    <tr bgcolor=\"#ff8c00\">\n");
      out.write("                                        <td><b><font color=white>FeeHead</font></b></td>\n");
      out.write("                                        <td><b><font color=white>Rate</font></b></td>\n");
      out.write("                                        <td><b><font color=white>Qty</font></b></td>\n");
      out.write("                                        <td><b><font color=white>Amount</font></b></td>\n");
      out.write("                                        <td><b><font color=white>Remarks</font></b></td>\n");
      out.write("                                        <td><b><font color=white>History</font></b></td>\n");
      out.write("                                    </tr>\n");
      out.write("                                </thead><tbody>\n");
      out.write("\n");
      out.write("                 ");

           // qry1="select x.FEEHEADS as FEEHEADS,x.HEADDESC as HEADDESC ,x.RATE as RATE from NA#FeeHeads x, (select b.INSTITUTECODE ,b.studentid,b.enrollmentno,b.studentname ,b.programcode , b.branchcode  , b.DEACTIVE, PROGRAMCOMPLETIONDATE ,c.FEEHEADS ,c.FEEHEADQTY ,c.FEEHEADRATE from studentmaster b ,NA#STUDENTFeedetail c where nvl(B.INSTITUTECODE,'x')=nvl(c.INSTITUTeCODE,'x') and B.STUDENTID='"+mStudentId+"'  and B.STUDENTID=c.STUDENTID and c.vouchercode is not null ) y where   x.INSTITUTeCODE=y.INSTITUTECODE(+) and x.FEEHEADS= y.FEEHEADS(+)and x.feetype='S'";

            qry1="SELECT  nvl(x.FEEHEADS,'') FEEHEADS,nvl(x.HEADDESC,'') HEADDESC ,nvl(x.RATE,'') RATE,nvl(y.FEEHEADQTY,'') FEEHEADQTY ,nvl(y.AMOUNT,'') AMOUNT ,nvl(y.Remarks,'') Remarks FROM NA#FeeHeads x, (SELECT b.INSTITUTECODE,  b.studentid, b.enrollmentno, b.studentname, b.programcode, b.branchcode, b.DEACTIVE, PROGRAMCOMPLETIONDATE,  c.FEEHEADS,  c.FEEHEADQTY,  c.FEEHEADRATE,  c.FEEHEADDATE,c.AMOUNT,  Remarks FROM studentmaster b, NA#STUDENTFeedetail c WHERE NVL (B.INSTITUTECODE, 'x') = NVL (c.INSTITUTeCODE, 'x') AND B.STUDENTID = '"+mStudentId+"' AND B.STUDENTID = c.STUDENTID AND c.vouchercode IS  NULL) y WHERE  x.INSTITUTeCODE = y.INSTITUTECODE(+) AND x.FEEHEADS = y.FEEHEADS(+)   AND x.feetype = 'S' and x.departmentcode='"+mDeptCode+"' AND x.INSTITUTeCODE='"+mINSTITUTECODE+"' order by x.FEEHEADS";
            rs1=db.getRowset(qry1);
            
            int TotalAmount=0;
            while(rs1.next())
                {
                ctr++;
                count++;
                TotalAmount=TotalAmount+Integer.parseInt(rs1.getString("AMOUNT")==null?"0":rs1.getString("AMOUNT"));
                qrylink="select sum(feeheadqty) from NA#STUDENTFeedetail where  institutecode='"+mINSTITUTECODE+"' and  vouchercode is not null and feeheads='"+rs1.getString("FEEHEADS")+"' and studentid='"+mStudentId+"'";
                qrycount="select count(*) from NA#STUDENTFeedetail where  institutecode='"+mINSTITUTECODE+"' and  vouchercode is not null and feeheads='"+rs1.getString("FEEHEADS")+"' and studentid='"+mStudentId+"'";
                rslink=db.getRowset(qrylink);
                rscount=db.getRowset(qrycount);


               // list.add(rs1.getString("FEEHEADS"));
                
      out.write("\n");
      out.write("\n");
      out.write("                  <input TYPE=hidden NAME=\"FEEHEADS");
      out.print(count);
      out.write("\" ID=\"FEEHEADS");
      out.print(count);
      out.write("\" VALUE=\"");
      out.print(rs1.getString("FEEHEADS"));
      out.write("\">\n");
      out.write("\t          <input type=\"hidden\" name=\"HEADDESC");
      out.print(count);
      out.write("\" id=\"HEADDESC");
      out.print(count);
      out.write("\" value=\"");
      out.print(rs1.getString("HEADDESC"));
      out.write("\">\n");
      out.write("                  <input TYPE=hidden NAME=\"RATE1");
      out.print(count);
      out.write("\" ID=\"RATE1");
      out.print(count);
      out.write("\" VALUE=\"");
      out.print(rs1.getString("RATE"));
      out.write("\">\n");
      out.write("                  <input TYPE=hidden NAME=\"FEEHEADQTY");
      out.print(count);
      out.write("\" ID=\"FEEHEADQTY");
      out.print(count);
      out.write("\" VALUE=\"");
      out.print(rs1.getString("FEEHEADQTY")==null?"":rs1.getString("FEEHEADQTY"));
      out.write("\">\n");
      out.write("\t          <input type=\"hidden\" name=\"AMOUNT");
      out.print(count);
      out.write("\" id=\"AMOUNT");
      out.print(count);
      out.write("\" value=\"");
      out.print(rs1.getString("AMOUNT")==null?"":rs1.getString("AMOUNT"));
      out.write("\">\n");
      out.write("                  <input TYPE=hidden NAME=\"Remarks");
      out.print(count);
      out.write("\" ID=\"Remarks");
      out.print(count);
      out.write("\" VALUE=\"");
      out.print(rs1.getString("Remarks")==null?"":rs1.getString("Remarks"));
      out.write("\">\n");
      out.write("                  <input TYPE=hidden NAME=\"TotalAmount");
      out.print(count);
      out.write("\" ID=\"TotalAmount");
      out.print(count);
      out.write("\" VALUE=\"");
      out.print(Integer.parseInt(rs1.getString("AMOUNT")==null?"0":rs1.getString("AMOUNT")));
      out.write("\">\n");
      out.write("                <tr>\n");
      out.write("                    <td>");
      out.print(rs1.getString("HEADDESC"));
      out.write("</td>                    \n");
      out.write("                    <td><input type=\"text\" NAME=\"RATE");
      out.print(ctr);
      out.write("\" id=\"RATE");
      out.print(ctr);
      out.write("\" value=\"");
      out.print(rs1.getString("RATE"));
      out.write("\" readonly=\"readonly\" size=\"5\"/></td>\n");
      out.write("                    <td><input type=\"text\" NAME=\"QTY");
      out.print(ctr);
      out.write("\" id=\"QTY");
      out.print(ctr);
      out.write("\" value=\"");
      out.print(rs1.getString("FEEHEADQTY")==null?"":rs1.getString("FEEHEADQTY"));
      out.write("\" onchange=\"mult(this.id)\" size=\"5\" /></td>\n");
      out.write("                    <td><input type=\"text\" NAME=\"AMT");
      out.print(ctr);
      out.write("\" id=\"AMT");
      out.print(ctr);
      out.write("\" value=\"");
      out.print(rs1.getString("AMOUNT")==null?"":rs1.getString("AMOUNT"));
      out.write("\"  size=\"5\" readonly=\"readonly\"/></td>\n");
      out.write("                    <td><input type=\"text\" NAME=\"REM");
      out.print(ctr);
      out.write("\" id=\"REM");
      out.print(ctr);
      out.write("\" value=\"");
      out.print(rs1.getString("Remarks")==null?"":rs1.getString("Remarks"));
      out.write("\"  size=\"50\"/></td>\n");
      out.write("\n");
      out.write("                    ");

                    if(rscount.next())
                        {
                       mFeeHeadQty= rscount.getInt(1);
                    }
                    if(rslink.next())
                    {
                        if(mFeeHeadQty>0)
                        {
                     
      out.write("\n");
      out.write("                    <td ALIGN=center><a href=\"FeeHead.jsp?FEEHEADS=");
      out.print(rs1.getString("FEEHEADS"));
      out.write("\"target=_New >");
      out.print(mFeeHeadQty);
      out.write("</a></td>\n");
      out.write("                   ");

                    }
                        else
                            {
                            
      out.write("\n");
      out.write("                            <td ALIGN=center>...</td>\n");
      out.write("                            \n");
      out.write("                            ");

                        }

                        }

                    
      out.write("\n");
      out.write("\t          \n");
      out.write("\t          \n");
      out.write("               ");


            }
            session.setAttribute("countofhiddennfield",count);
            session.setAttribute("countofcurrentfield",ctr);
            
      out.write("\n");
      out.write("                <tr bgcolor=\"#ff8c00\">\n");
      out.write("                    <td><b><font color=white>Total</font></b></td>\n");
      out.write("                    <td></td><td></td><td><input type=\"text\" id=\"TotalAmt\" value=\"");
      out.print(TotalAmount);
      out.write("\" readonly=\"readonly\" size=\"5\"/></td><td></td><td></td></tr>\n");
      out.write("                <td align=center colspan=6><input type=\"submit\"  border= \"3px\" name=\"Save\" id=\"Save\" value=\"&nbsp; Save &nbsp;\" onClick=\"return Validate();\" >\n");
      out.write("                <tr></tr>\n");
      out.write("                </tbody>\n");
      out.write("                </table>\n");
      out.write("               \n");
      out.write("                    ");

        }
        else
        {
           // response.sendRedirect("Error.jsp?sms=Please Enter EnrollmentNo.");
        //System.out.println("Please Enter EnrollMentNo");
       // out.println("Please Enter EnrollMentNo");
        }
         /* if (request.getParameter("Save") != null)
          {
              System.out.println("count"+count);

              for(int i=1;i<count;i++)
                  {
                  /*mName1="FEEHEADS"+i;
                  mName2="HEADDESC"+i;
                  mName3="RATE1"+i;
                  mName4="FEEHEADQTY"+i;
                  mName5="AMOUNT"+i;
                 /* mName6="Remarks"+i;
                  mName1="FEEHEADS"+i;
                  mName2="HEADDESC"+i;
                  mName3="RATE"+i;
                  mName4="QTY"+i;
                  mName5="AMT"+i;
                  mName6="REM"+i;
                  System.out.println("mName1--"+mName1);
                  System.out.println("mName2--"+mName2);
                  System.out.println("mName3--"+mName3);
                  System.out.println("mName4--"+mName4);
                  System.out.println("mName5--"+mName5);
                  System.out.println("mName6--"+mName6);

                  System.out.println("mName1--"+request.getParameter(mName1).trim());
                  System.out.println("mName2--"+request.getParameter(mName2).trim());
                  System.out.println("mName3--"+request.getParameter(mName3).trim());
                  System.out.println("mName4--"+request.getParameter(mName4).trim());
                  System.out.println("mName5--"+request.getParameter(mName5).trim());
                  System.out.println("mName6--"+request.getParameter(mName6).trim());
                  
                  qryi="insert into NA#STUDENTFeedetail( INSTITUTECODE, FEEHEADS,  FeeheadDate, REGCODE, STUDENTID, FEEHEADRATE, FEEHEADQTY, AMOUNT,remarks";
               qryi=qryi+ " ,ENTRYBY, ENTRYDATE, DEACTIVE, LASTUPDATE ) values('"+mInstCode+"','"+request.getParameter(mName1).trim()+"',sysdate,'REGCODE','"+session.getAttribute("studentid").toString().trim()+"','"+request.getParameter(mName3).trim()+"'";
               qryi=qryi+ " ,'"+request.getParameter(mName4).trim()+"','"+request.getParameter(mName5).trim()+"','"+request.getParameter(mName6).trim()+"')where vouchercode is not null";
              int ni=db.insertRow(qryi);
             /* if (ni > 0)
              {
                 System.out.println("Inserted Successfully");
              }
              else
              {
                  System.out.println("Not Inserted Successfully");
              }*/
                  //System.out.println(mName1);
                   //System.out.println(request.getParameter(mName1).trim());

                 // }
              /*Iterator itr=list.iterator();
              while(itr.hasNext())
              {
                   System.out.println(itr.next());
              
              qryi="insert into NA#STUDENTFeedetail( INSTITUTECODE, FEEHEADS,  FeeheadDate, REGCODE, STUDENTID, FEEHEADRATE, FEEHEADQTY, AMOUNT,remarks";
               qryi=qryi+ " ,ENTRYBY, ENTRYDATE, DEACTIVE, LASTUPDATE ) values('"+mInst+"' ,) where vouchercode is not null";
              int ni=db.insertRow(qryi);

              }*/
              

         // }*/
			
  }
  else
   {
   
      out.write("\n");
      out.write("\t<br>\n");
      out.write("\t<font color=red>\n");
      out.write("\t<h3>\t<br><img src='../Images/Error1.jpg'>\tAccess Denied (authentication_failed) </h3><br>\n");
      out.write("\t<P>\tThis page is not authorized/available for you.\n");
      out.write("\t<br>For assistance, contact your network support team.\n");
      out.write("\t</font>\t<br>\t<br>\t<br>\t<br>\n");
      out.write("   ");



   }
  //-----------------------------




}
else
{
	out.print("<br><img src='Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='index.jsp'>Login</a> to continue</font> <br>");
}


      out.write("\n");
      out.write("</form>\n");
      out.write("</body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
