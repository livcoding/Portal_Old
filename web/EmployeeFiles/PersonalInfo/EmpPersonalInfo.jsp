<!--
Changes By      Vivek Kumar Soni
Date            07.06.2017
Modification    Adhar And UAN no Added
-->


<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%@ page import="java.io.*" %>
<%


String qry="",mWebEmail="";
DBHandler db=new DBHandler();

OLTEncryption enc=new OLTEncryption();


//out.print("ADMIN - "+enc.encode("ADMIN"));
//out.print("<BR>"+"ADMINType - "+enc.encode("A"));

//GlobalFunctions gb =new GlobalFunctions();

ResultSet rs=null, EmployeeRecordSet=null,rsImage=null;
String SName="",CAddress1 ="", CAddress2="",CAddress3="", CDistrict="",CPin="",CCity="",CState="";
String PAddress1 ="", PAddress2="",PAddress3="", PDistrict="", PPin="",qry1="", PCity="",PState="",EnrollmentNo="",FatherName="",HusbandName="", MotherName="";
String DOB="",DOJ="",Grade="", Dept="", Desig="", Category="",AccountNo="", BankName="",PFNO="", PANNO="",PassportNo="";
String pPhone ="",cPhone ="",pCell="" ,pEmail="",PassportValidUpto ="", PassportIssueFrom="",pIssueDate="",AAdharno="";
String mMemberID="",mMemberType="",mMemberCode="";
String Uan="";


if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
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

if (session.getAttribute("WebAdminEmail")==null)
{
	 mWebEmail="";
}
else
{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
}


String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Personal Information ] </TITLE>

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>


</head>

<body   topmargin=4 rightmargin=0 leftmargin=0 bottommargin=0 bgColor="#fce9c5">
<%
if(!mMemberID.equals("") || !mMemberCode.equals(""))
{
mMemberID=enc.decode(mMemberID);
mMemberCode=enc.decode(mMemberCode);

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;

  //-----------------------------
  //-- Enable Security Page Level
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('1','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------
try
{





qry="Select nvl(BANKACCOUNTNO,' ') accountno, nvl(BankCode,'*') BankCode From employeedetail where employeeid='"+mChkMemID+"'";
rs=db.getRowset(qry);
if(rs.next())
{
   AccountNo = rs.getString("accountno");
   qry="Select nvl(BANKNAME,' ') BANKNAME From EmployeeBankMaster where BankCode='"+rs.getString("BANKCODE")+"'";
   rs=db.getRowset(qry);
   if(rs.next())
   {
       BankName= rs.getString("BANKNAME");
   }
}


qry =   "Select a.employeeid employeeid, a.employeename employeename,nvl(to_char(a.dateofbirth,'dd/mm/yyyy'),' ')" +
        " dateofbirth,nvl(to_char(a.DATEOFJOINING,'dd/mm/yyyy'),' ') dateofjoining,nvl(a.FATHERNAME,' ') fathername," +
        " nvl(a.HUSBANDNAME,' ') HUSBANDNAME, nvl(a.MOTHERNAME,' ') MOTHERNAME,nvl(a.gradecode,' ') gradecode,nvl(designation,' ')" +
        " designation,nvl(e.department,' ') department,nvl(g.CATEGORY,' ') category, nvl(b.PFNUMBER,' ') pfnumber,nvl(b.panno,' ') " +
        " panno,nvl(b.passportno,' ') passportno,nvl(to_char(b.UANNO),'.') UANNO,nvl(d.bankname,' ') bankname,nvl(b.AADHARNO,' ') AADHARNO,nvl(caddress1,' ') caddress1,nvl(caddress2,' ' ) " +
        " caddress2,nvl(caddress3,' ') caddress3,nvl(ccity,' ') ccity,nvl(cdistrict,' ') cdistrict,nvl(cstate,' ') cstate,nvl(to_char(cpin),' ')" +
        " cpin,nvl(paddress1,' ') paddress1,nvl(paddress2,' ') paddress2,nvl(paddress3,' ') paddress3,nvl(pcity,' ') pcity,nvl(pdistrict,' ')" +
        " pdistrict,nvl(pstate,' ' ) pstate, nvl(to_char(ppin),' ') ppin , nvl(PPHONENOS,' ') PPHONENOS, nvl(CPHONENOS,' ')" +
        " CPHONENOS,nvl(EMAILID,' ') emailid, nvl(MOBILE,' ') mobile, nvl(TO_CHAR(PASSPORTVALIDUPTO,'DD-Mon-YYYY'),' ')" +
        "  PASSPORTVALIDUPTO ,nvl(PassportIssueFrom,' ') PassportIssueFrom, nvl(to_char(PASSPORTISSUEDATE,'dd-Mon-YYYY'),' ') " +
        "PASSPORTISSUEDATE  from " ;
qry=qry+ " employeemaster a , employeedetail b,employeeaddress c ,employeebankmaster d ," ;
qry=qry+ " departmentmaster e ,categorymaster g ,designationmaster f where a.employeeid = b.employeeid (+) and a.employeeid = c.employeeid (+)  and a.categorycode = g.categorycode(+)" ;
qry=qry+ " and b.bankcode = d.bankcode(+) and a.departmentcode = e.departmentcode(+) and a.designationcode = f.designationcode(+) " ;
qry=qry+ " and a.employeeid = '" + mMemberID + "'";

//out.print(qry);
EmployeeRecordSet = db.getRowset(qry);



if (EmployeeRecordSet.next())
{
    System.out.print("Inside---------------------");
   SName = EmployeeRecordSet.getString("employeename").toUpperCase();
   DOB = EmployeeRecordSet.getString("dateofbirth");
   DOJ = EmployeeRecordSet.getString("dateofjoining");
   Grade = EmployeeRecordSet.getString("gradecode").toUpperCase();
   Desig = EmployeeRecordSet.getString("designation").toUpperCase();
   Dept= EmployeeRecordSet.getString("department").toUpperCase();
   Category = EmployeeRecordSet.getString("category").toUpperCase();
   //BankName = EmployeeRecordSet.getString("bankname");
   PFNO = EmployeeRecordSet.getString("pfnumber").toUpperCase();
   PANNO = EmployeeRecordSet.getString("panno").toUpperCase();
   PassportNo = EmployeeRecordSet.getString("passportno").toUpperCase();

   CAddress1 = EmployeeRecordSet.getString("caddress1");
   CAddress2 = EmployeeRecordSet.getString("caddress2");
   CAddress3 = EmployeeRecordSet.getString("caddress3");
   CCity = EmployeeRecordSet.getString("ccity");
   CDistrict = EmployeeRecordSet.getString("cdistrict");
   CState = EmployeeRecordSet.getString("cstate");
   CPin = EmployeeRecordSet.getString("cpin");

   PAddress1 = EmployeeRecordSet.getString("paddress1");
   PAddress2 = EmployeeRecordSet.getString("paddress2");
   PAddress3 = EmployeeRecordSet.getString("paddress3");
   PCity = EmployeeRecordSet.getString("pcity");
   PDistrict = EmployeeRecordSet.getString("pdistrict");
   PState = EmployeeRecordSet.getString("pstate");
   PPin = EmployeeRecordSet.getString("ppin");


   cPhone = EmployeeRecordSet.getString("CPHONENOS");
   pPhone = EmployeeRecordSet.getString("PPHONENOS");
   pCell = EmployeeRecordSet.getString("mobile");
   pEmail = EmployeeRecordSet.getString("emailid");
    System.out.print("Inside2222222---------------------");
   Uan = EmployeeRecordSet.getString("UANNO");
   AAdharno = EmployeeRecordSet.getString("AADHARNO");

    System.out.print("Inside33333333---------------------");
   PassportValidUpto=EmployeeRecordSet.getString("PASSPORTVALIDUPTO");
   PassportIssueFrom=EmployeeRecordSet.getString("PassportIssueFrom");
   pIssueDate=EmployeeRecordSet.getString("PASSPORTISSUEDATE");
   FatherName=EmployeeRecordSet.getString("FatherName").toUpperCase();
   HusbandName=EmployeeRecordSet.getString("HusbandName").toUpperCase();
   MotherName=EmployeeRecordSet.getString("MotherName").toUpperCase();

   session.setAttribute("mMemberID",mMemberID);
%>
<CENTER><FONT face="MS Sans Serif"><FONT
face="Arial" color  =black size=2><b>PERSONAL INFORMATION</b></FONT></CENTER>
 <CENTER>

<TABLE cellspacing=0 border=1 frame=box cellpadding=2   align="center"  style="FONT-FAMILY: Arial; FONT-SIZE: x-small; " borderColor=black borderColorDark=white>
   <TR>
 <td colspan=3>&nbsp;
 </td>
   	<td colspan=2  rowspan=6 align="center" style="width:130px; height:180px">

		<img SRC="showImage.jsp" align="center" style="width:130px; height:180px ">
	</td>
   </tr>
   <tr>
    <TD><FONT face=Arial><FONT color=black size=2>&nbsp;Name</FONT><FONT face=Arial> </FONT></FONT> </TD>
        <td colspan=2>&nbsp; <%=SName%></FONT></td>

		</TR>
        <TR><TD nowrap><FONT face=Arial><FONT color=black size=2>&nbsp;Employee Code</FONT> </FONT> </TD>
        <TD colspan=2><FONT face=Arial color=black size=2>&nbsp; <%=mMemberCode%></FONT></TD></TR>

        <TR><TD><FONT color=black face="Arial" size=2>&nbsp;Spouse Name</FONT>   </TD>
        <TD colspan=2><FONT face=Arial color=black size=2>&nbsp; <%=HusbandName%></FONT></TD></TR>

        <TR><TD><FONT color=black face="Arial" size=2>&nbsp;Father Name</FONT>   </TD>
        <TD colspan=2><FONT face=Arial color=black size=2>&nbsp; <%=FatherName%></FONT></TD></TR>


        <TR><TD><FONT color=black face="Arial" size=2>&nbsp;Mother Name</FONT>   </TD>
        <TD colspan=2><FONT face=Arial color=black size=2>&nbsp; <%=MotherName%></FONT></TD></TR>
        <TR>

        <TD><FONT color=black  face="Arial" size=2>&nbsp;Date of Joining </FONT></TD>
                <TD><FONT face=Arial color=black size=2>&nbsp; <%=DOJ %></FONT></TD>
                <TD><FONT color=black face="Arial" size=2>&nbsp;Date of Birth </FONT></TD>
                <TD align="left"><FONT face=Arial color=black size=2>&nbsp; <%=DOB %></FONT></TD>
        </TR>
        <TR>
                <TD><FONT color=black face="Arial">&nbsp;Category </FONT></TD>
                <TD>&nbsp; <%=Category%></TD>
                <TD><font color="black" face="Arial">&nbsp;Grade</font></TD>
                <TD align="left">&nbsp; <%=Grade%></TD>
        </TR>
        <TR>
                <TD><FONT color=black face="Arial">&nbsp;Department </FONT></TD>
                <TD>&nbsp; <%=Dept%></TD>
                <TD><FONT color=black face="Arial">&nbsp;Designation </FONT></TD>
                <TD nowrap align="left">&nbsp; <%=Desig%></TD>
        </TR>

        <TR>
                <TD><FONT color=black face="Arial">&nbsp;PF A/c No </FONT></TD>
                <TD>&nbsp; <%=PFNO %></TD>
                <TD><FONT color=black face="Arial">&nbsp;Pan No </FONT></TD>
                <TD align="left">&nbsp;<%=PANNO%></TD>
        </TR>

        <TR>
            <%
            if(null==Uan){
            Uan="";
            }
            %>
		 <TD><FONT color=black face="Arial">&nbsp;UAN No </FONT></TD>
                <TD >&nbsp; <%=Uan%> <FONT color=black
		      face="Arial" >&nbsp;&nbsp;&nbsp;&nbsp;  </FONT></TD>
                      <TD><FONT color=black face="Arial">&nbsp;AAdhar No </FONT></TD>
                      <TD >&nbsp;  <FONT color=black
		      face="Arial" >&nbsp;&nbsp;&nbsp;&nbsp;<%=AAdharno%>  </FONT></TD>
	</TR>



        <TR>
                <TD><FONT color=black face="Arial">&nbsp;Bank A/c &nbsp;No/Name </FONT></TD>
                <TD colspan=3>&nbsp; <%=AccountNo%> <FONT color=black
		      face="Arial" >&nbsp;&nbsp;&nbsp;&nbsp; <%=BankName%> </FONT></TD>
        </TR>



	<TR>
		<TD><FONT color=black face="Arial">&nbsp;Passport No </FONT></TD>
		<td>&nbsp; <%=PassportNo%></td>
		<TD>&nbsp; Issue From </TD>
		<td>&nbsp; <%=PassportIssueFrom%></td>
	</TR>
	<tr>
		<TD nowrap>&nbsp;Passport issue on</TD>
		<TD>&nbsp; <%=pIssueDate %></TD>
		<TD>&nbsp; Valid Upto</TD>
		<TD>&nbsp; <%=PassportValidUpto%></TD>
	</tr>

	<TR>
		<TD><FONT color=black face="Arial">&nbsp;Cell/Mobile</FONT></TD>
		<TD>&nbsp; <%=pCell %></TD>
		<TD NOWRAP><FONT color=black face="Arial">&nbsp;Correspondence Phone&nbsp;</FONT></TD>
		<TD align="left">&nbsp; <%=cPhone %></TD>
	</TR>
	<TR>
		<TD><FONT color=black face="Arial">&nbsp;E-Mail </FONT></TD>
		<TD>&nbsp; <%=pEmail%></TD>
		<TD NOWRAP><FONT color=black face="Arial">&nbsp;Permanent Phone</FONT></TD>
		<TD align="left">&nbsp; <%=pPhone %></TD>
	</TR>
        <TR  Rowspan="2" colspan="2"><TD colspan="2"><STRONG>
        <FONT face ="Arial" color  =#a00000>&nbsp;Correspondences Address</FONT></STRONG></TD>
        <td colspan="2"><FONT face=Arial><FONT color=maroon><STRONG>&nbsp;Permanent Address</STRONG> </FONT></FONT></td> </TR>
        <TR style="VERTICAL-ALIGN: top"><TD><FONT color=black face="Arial" >&nbsp;Address </FONT> </TD>
                <TD nowrap><FON face="Arial">&nbsp; <%=CAddress1%><br>&nbsp; <%=CAddress2%><br>&nbsp; <%=CAddress3%></FONT></TD>

            <td><FONT color=black face="Arial">&nbsp;Address </FONT> </td>
        <TD nowrap>&nbsp; <%=PAddress1%><br>&nbsp; <%=PAddress2%><br>&nbsp; <%=PAddress3%></TD>	</TR>

        <tr><td><FONT color=black face="Arial">&nbsp;District </FONT></td>
        <TD>&nbsp; <%=CDistrict%></TD>
                <td><FONT color=black face="Arial">&nbsp;District </FONT></td>
        <td>&nbsp; <%=PDistrict%></td></tr>

        <tr><TD><FONT face=Arial><FONT color=black>&nbsp;City/PIN</FONT> </FONT> </TD>
        <TD>&nbsp; <%=CCity%><FONT face="Arial"> / <%=CPin %></FONT></TD>
        <td><FONT face="Arial" >&nbsp;City/PIN</FONT></td>
        <td>&nbsp; <%= PCity%>  <FONT face="Arial">/ <%=PPin %></FONT></td></tr>
        <tr><TD><FONT color=black  face="Arial">&nbsp;State </FONT> </TD>
        <TD>&nbsp; <%=CState%></TD>
        <td><FONT color=black face="Arial">&nbsp;State </FONT></td>
        <td>&nbsp; <%=PState%></td></tr>
	</TABLE></CENTER>
	<%
	}
	else
	{
		%>
		<P><FONT size=2><FONT face=Arial><FONT color=black>Name</FONT><FONT color=black>:&nbsp;&nbsp; Profile not found</FONT></FONT></FONT></P>
		<%
	}
}
catch(Exception e)
{
//out.print(e.getMessage());
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
	<h3>	<br><img src='.../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team.
	</font>	<br>	<br>	<br>	<br>
	<%
}
//-----------------------------
}
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
}
%>
<center>

</body>
</Html>
