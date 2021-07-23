<%-- 
    Document   : ERPModuleForNonAcademicFees
    Created on : 27 Jan, 2020, 1:55:28 PM
    Author     : Anoop.Tiwari
--%>

<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %>
<%@page import="jilit.db.CommonComboData"%>
<%
String mHead="",mInstCode ="";
String mCandCode="", MName="";
String mCandName="";
String URL="";

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<script src=".../IQAC/js/jquery/jquery-1.10.2.js"></script>
        <script src=".../IQAC/js/jquery/jquery-ui.js"></script>
        <script src=".../IQAC/js/jquery/yattable.js"></script>
        <script src=".../IQAC/js/jquery/numeric-1.0.js"></script>
        <script src=".../IQAC/js/IQTest/CommonServiceJs.js"></script>
        <script src=".../IQAC/js/IQTest/ComboJs.js"></script>
        <script src="js/ERPModuleForNonAcademicFees.js"></script>

<TITLE>#### <%=mHead%> [ View Students Profile/Information ] </TITLE>


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
</SCRIPT>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor="#fce9c5" rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
//GlobalFunctions gb =new GlobalFunctions();
CommonComboData ccd=new CommonComboData();
DBHandler db=new DBHandler();
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="",mDept="",mDesg="",mInst="",minst="",mDMemberID="";
String qry="", mEnOrNm="", x="",cInst="",mCheck="",mAcademicYear="",mProgramcode="",mEnrollmentno="",mBranchcode="",mEnrollMentNo="";
int msno=0;
ResultSet rs=null;
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
		qry="Select WEBKIOSK.ShowLink('389','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      	RsChk1= db.getRowset(qry);
		if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
		   {
                    %>
                    <form name="frm" method="get">
                        <table width="60%"  border=1  rules=none align=center   topmargin=0 cellspacing=0 cellpadding=1 borderColor="#D98242" >
                            <tr>
                                <td  align=center colspan=1>&nbsp;Enrollment Number</td>
                                <td><input  type=text name="EnrollMentNo"  onchange="return ChangeCase()" id="EnrollMentNo" width=150px maxlength=50></td>
                            </tr>
                            <tr>
                                <td  align=center colspan=2>OR</td>
                            </tr>


                 <tr>
                    <td style="text-align: right">Institute Code<span class="req"><font color='red'> *</font></span> :</td><td style="text-align: left"><select  name='instituteCode' id='instituteCode'  class='combo'  title='Institute Code' onchange="getAcademicYear()"><%=ccd.commonJspCombo("{\"comboId\":\"instituteCodeCombo\"}")%></select></td>
                    <td style="text-align: right">Academic Year<font color='red'> *</font> :</td><td style="text-align: left"><select  name='academicYear' id='academicYear'  class='combo' style=''  title='Academic Year' onchange="getProgramCode()"><option value='0'>Select Academic Year</option></select></td>

                </tr>
                <tr>
                    <td style="text-align: right">Program Code:</td><td style="text-align: left"><select  name='programCode' id='programCode'  class='combo' style=''  title='Program Code' onchange="getBranchCode()"><option value='0'>Select Program Code</option></select></td>
                    <td style="text-align: right">Branch Code:</td><td style="text-align: left"><select  name='branchCode' id='branchCode'  class='combo' style=''  title='Branch Year' onchange="getExamCode()"><option value='0'>Select Branch Code</option></select></td>
                </tr>

                            
                            
                            <tr>
                            <br>
                            <td align=center colspan=4><input type="submit"  border= "3px" name="submit" id="submit" value="&nbsp; Submit &nbsp;" onClick="return Validate();" >
                                </br>
                            </td>
                        </tr>
                            
                        </table>
    <%
	if(request.getParameter("EnrollMentNo")!=null)
        {
            mEnrollMentNo=request.getParameter("EnrollMentNo").trim();
            System.out.println("mEnrollMentNo--"+mEnrollMentNo);

            qry="select * from NA#FeeHeads x, (select b.INSTITUTECODE ,b.studentid,b.enrollmentno,b.studentname ,b.programcode , b.branchcode  , b.DEACTIVE, PROGRAMCOMPLETIONDATE ,c.FEEHEADS ,c.FEEHEADQTY ,c.FEEHEADRATE from studentmaster b ,NA#STUDENTFeedetail c where nvl(B.INSTITUTECODE,'x')=nvl(c.INSTITUTeCODE,'x') and B.STUDENTID='00011900314'  and B.STUDENTID=c.STUDENTID and c.vouchercode is not null ) y where   x.INSTITUTeCODE=y.INSTITUTECODE(+) and x.FEEHEADS= y.FEEHEADS(+)and x.feetype='S'";
            rs=db.getRowset(qry);
            while(rs.next())
                {

            }
        }
        else
        {
        System.out.println("Please Enter EnrollMentNo");
        }
			
  }
  else
   {
   %>
	<br>
	<font color=red>
	<h3>	<br><img src='../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team.
	</font>	<br>	<br>	<br>	<br>
   <%


   }
  //-----------------------------




}
else
{
	out.print("<br><img src='Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='index.jsp'>Login</a> to continue</font> <br>");
}

%>
</form>
</body>
</html>
