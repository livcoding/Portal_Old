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
<TITLE>#### <%=mHead%> [ View Opted Subjects ] </TITLE>
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
</script>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();
String qry="",mWebEmail="",EmpIDType="";
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
String mInst="";
int msno=0;
String mSem="";
int mSemPlusOne=0;
String mExamCode="",mexamcode="",mexam="",mProg="",mBranch="",mName="", mBasket="";
String mINSTITUTECODE="";
String mEmployeeID="";
//String mSUBJECTCODE="";
String mEName="";
ResultSet rs=null,rs1=null;

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
if (session.getAttribute("InstituteCode")==null)
{
	mINSTITUTECODE="";
}
else
{
	mINSTITUTECODE=session.getAttribute("InstituteCode").toString().trim();
}
if (session.getAttribute("ProgramCode")==null)
{
	mProg="";
}
else
{
	mProg=session.getAttribute("ProgramCode").toString().trim();
}

if (session.getAttribute("BranchCode")==null)
{
	mBranch="";
}
else
{
	mBranch=session.getAttribute("BranchCode").toString().trim();
}

if (session.getAttribute("CurrentSem")==null)
{
	mSem="";
}
else
{
	mSem=session.getAttribute("CurrentSem").toString().trim();
	// mSemPlusOne=(Integer.parseInt(mSem))+0;
}

if (session.getAttribute("MemberName")==null)
{
	mName="";
}
else
{
	mName=session.getAttribute("MemberName").toString().trim();
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
	qry="Select WEBKIOSK.ShowLink('160','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------
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
	
%>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Scholorship Record</b></font>
</td>
</tr>
</table>
<form name="frm" method=get>
<input id="x" name="x" type=hidden>
<table width=95%  rules=groups cellspacing=1 cellpadding=1 align=center border=1>
<tr><td>&nbsp;&nbsp;<font color=black face=arial size=2><STRONG> Name:&nbsp;</STRONG></font><%=GlobalFunctions.toTtitleCase(mName)%>[<%=mDMemberCode%>]
	&nbsp; &nbsp; &nbsp; &nbsp; <font color=black face=arial size=2><STRONG>Course/Branch:&nbsp;</STRONG></font><%=mProg%>(<%=mBranch%>)
	&nbsp; &nbsp; &nbsp; &nbsp; <font color=black face=arial size=2><STRONG>Current Sem:&nbsp;</STRONG></font><%=mSem%>
</td></tr>


</table></form>
  <table width=100% cellspacing=0 cellpading=0 align=middle border=1>
  <tr bgcolor="#c00000" >
  <td><b><font color=white>SNo.</font></b></td>
  <td><b><font color=white>ScholorShip Type</font></b></td>	
  <td><b><font color=white>Sem/Acad.Year</font></b></td>
  <td><b><font color=white>PaymentDate</font></b></td>
  <td><b><font color=white>Scholorship Amount</font></b></td>
  <td><b><font color=white>Paid Amount</font></b></td>
  <td><b><font color=white>Remarks</font></b></td>
 </tr>
<%
	String mPtype="";
	String qryv="";
	String qryf="";
	ResultSet rsv=null;
	ResultSet rsf=null;
	double mPA=0;

qry="select distinct A.SCHOLARSHIPDESC SCHOLARSHIPDESC,NVL(TO_char(B.PAYMENTDATE,'DD-MM-YYYY'),' ')PAYMENTDATE, ";
qry=qry+" B.SCHOLARSHIPID,B.ACADEMICYEAR,B.SEMORACADYEAR,B.SCHOLARSHIPFOR,";
qry=qry+" NVL(B.SCH#AMOUNT,0)SCH#AMOUNT,NVL(B.REMARKS,' ')REMARKS ,nvl(B.PAYMENTTYPESTATUS,'**')PAYMENTTYPESTATUS FROM SCHOLARSHIPTYPEMASTER A, ";
qry=qry+" SCHOLARSHIPPAYMENTDETAIL B WHERE B.INSTITUTECODE='"+mINSTITUTECODE+"' AND ";
qry=qry+"  B.STUDENTID='"+mMemberID+"' AND NVL(A.DEACTIVE,'N')='N' AND A.INSTITUTECODE=B.INSTITUTECODE ";
qry=qry+" AND A.SCHOLARSHIPID=B.SCHOLARSHIPID AND NVL(B.DEACTIVE,'N')='N' AND  NVL(A.DEACTIVE,'N')=NVL(B.DEACTIVE,'N') order by PAYMENTDATE desc ";
rs1=db.getRowset(qry);
//out.print(qry);
msno=0;
while(rs1.next())
{
	msno++ ;
// 0412040083

%>
    <tr>
	<td><%=msno%></td>	
	<td><%=rs1.getString("SCHOLARSHIPDESC")%></td>
	<td align=center><%=rs1.getString("SEMORACADYEAR")%></td>
	<td><%=rs1.getString("PAYMENTDATE")%></TD>
	<td align=right><%=rs1.getString("SCH#AMOUNT")%>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</TD>
<%
	mPtype=rs1.getString("PAYMENTTYPESTATUS");

	if(mPtype.equals("V"))
	{	
		qryv="SELECT nvl(PAYMENTAMOUNT,0)PAYMENTAMOUNT FROM SCHOLARSHIPVOUCHERTAGGING ";
		qryv=qryv+" where INSTITUTECODE='"+mINSTITUTECODE+"' and SCHOLARSHIPID='"+rs1.getString("SCHOLARSHIPID")+"' and ACADEMICYEAR='"+rs1.getString("ACADEMICYEAR")+"' ";
		qryv=qryv+" and STUDENTID='"+mMemberID+"' and SCHOLARSHIPFOR='"+rs1.getString("SCHOLARSHIPFOR")+"' and SEMORACADYEAR='"+rs1.getString("SEMORACADYEAR")+"' and ";
		qryv=qryv+" nvl(DEACTIVE,'N')='N' ";
		//out.print(qryv);
		rsv=db.getRowset(qryv);
		rsv.next();
		%>
			<td align=right><%=rsv.getString("PAYMENTAMOUNT")%>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</TD>
		<%
	}
	else if(mPtype.equals("F"))
	{
		qryf="SELECT nvl(PAYADJUSTAMOUNT,0)PAYADJUSTAMOUNT FROM SCHOLARSHIPPAYMENTFEEADJDETAIL ";
		qryf=qryf+" where INSTITUTECODE='"+mINSTITUTECODE+"' and SCHOLARSHIPID='"+rs1.getString("SCHOLARSHIPID")+"' and ACADEMICYEAR='"+rs1.getString("ACADEMICYEAR")+"' ";
		qryf=qryf+" and STUDENTID='"+mMemberID+"' and SCHOLARSHIPFOR='"+rs1.getString("SCHOLARSHIPFOR")+"' and SEMORACADYEAR='"+rs1.getString("SEMORACADYEAR")+"' and ";
		qryf=qryf+" nvl(DEACTIVE,'N')='N' ";
		rsf=db.getRowset(qryf);
		rsf.next();
		%>
			<td align=right><%=rsf.getString("PAYADJUSTAMOUNT")%>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</TD>
		<%
	}
	else if(mPtype.equals("B"))
	{
	mPA=rsv.getDouble("PAYMENTAMOUNT")+rsf.getDouble("PAYADJUSTAMOUNT");
	%>
			<td align=right><%=mPA%>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</TD>
	<%
	}
	else
	{
	%>
		<td align=right>&nbsp;</TD>
	<%
	}
	%>
		<td nowrap>&nbsp;<%=rs1.getString("REMARKS")%></TD>
         </tr>	
    <%
	}
%>
 </table>		
<%	 		        
//}					

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
  }   //2
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
}	//1	
catch(Exception e)
{
	
}
%>
<br>
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

