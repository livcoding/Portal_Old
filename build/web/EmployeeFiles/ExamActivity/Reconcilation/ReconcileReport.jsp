<%--
    Document   : ReconcileReport
    Created on : 26 Dec, 2015, 12:21:26 PM
    Author     : nipun.gupta
--%>

<!DOCTYPE html>
<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%
String examCode1="";
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="",mst="";
String qry1="";
String x="",t="",mfactype="",mSemType="",msemtype="";
int ctr=0;
int kk1=0;
String Tagg="";
int Data=0;
String v="";
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInstitute="",mInst="";
String mExam="",mE="";
String mexam="";
String mLTP="";
String mltp="";
String mSubj="",mELECTIVECODE="",mDepcode="";
String msubj="";
String mSubjType="";
String msubjType="",mST="",mSubcode="",mDept="";

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

 String mLoginComp="";


if (session.getAttribute("LoginComp")==null)
{
	mLoginComp="";
}
else
{
	mLoginComp=session.getAttribute("LoginComp").toString().trim();
}

if (session.getAttribute("InstituteCode")==null)
{
	mInstitute="";
}
else
{
	mInstitute=session.getAttribute("InstituteCode").toString().trim();
}
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";

String no_Data_Found=request.getParameter("noDataFound");
String found_In_Jsp_Not_In_Excel=request.getParameter("foundInJspNotInExcel");
String found_In_Excel_Not_In_Jsp=request.getParameter("foundInExcelNotInJsp");
String mis_Match_Data=request.getParameter("misMatchData");
String data_Matches=request.getParameter("dataMatches");

%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Approval of Elective Subject Running by DOAA] </TITLE>
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
            function compareData()
            {
               document.marksCompare.action="ReconmarksCompare.jsp";
               document.marksCompare.submit(); 
            }
        </script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
try
{ 


        qry="Select PREREGEXAMID Exam from COMPANYINSTITUTETAGGING Where COMPANYCODE='"+mLoginComp+"' And INSTITUTECODE='"+mInstitute+"'";
        rs=db.getRowset(qry);
        while(rs.next()) 
        {
            examCode1=rs.getString("Exam");
        }




	OLTEncryption enc=new OLTEncryption();

	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{
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

		mInst=mInstitute;

		qry="Select WEBKIOSK.ShowLink('399','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
		  //----------------------


				%>
                                <form id="ReconmarksCompare" name="marksCompare"  method="Post">
				<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
				<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"></font></TD></tr>
				</TABLE>
                                    <table cellpadding=0 cellspacing=0 align=center>
                                        <%if(no_Data_Found.equals("1")){%>
                                       <tr><TD colspan=0 align=middle><font color="#a52a2a" size="6" style="FONT-FAMILY: fantasy"><a href="javascript:void(0)" onclick="compareData();">No Data Found</a></font></TD></tr>
                                       <%} if(found_In_Jsp_Not_In_Excel.equals("1")){%>
                                       <tr><TD colspan=0 align=middle><font color="#a52a2a" size="6" style="FONT-FAMILY: fantasy"><a href="javascript:void(0)" onclick="compareData();">Found in JSP not in Excel</a></font></TD></tr>
                                       <%} if(found_In_Excel_Not_In_Jsp.equals("1")){%>
                                       <tr><TD colspan=0 align=middle><font color="#a52a2a" size="6" style="FONT-FAMILY: fantasy"><a href="javascript:void(0)" onclick="compareData();">Found in Excel not in JSP</a></font></TD></tr>
                                       <%} if(mis_Match_Data.equals("1")){%>
                                       <tr><TD colspan=0 align=middle><font color="#a52a2a" size="6" style="FONT-FAMILY: fantasy"><a href="javascript:void(0)" onclick="compareData();">Mismatch Data</a></font></TD></tr>
                                       <%} if(data_Matches.equals("1")){%>
                                       <tr><TD colspan=0 align=middle><font color="#a52a2a" size="6" style="FONT-FAMILY: fantasy"><a href="javascript:void(0)" onclick="compareData();">Data Matches</a></font></TD></tr>
                                       <%}%>
                                    </table>
				</form>

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
