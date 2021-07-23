<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="";
int n=0,mNoticeDay=0;
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInst="",mComp="";
String mEID="";
String mRID="",mRemark="";
String mEname="" ,mReportDt="",mRelivingDt="",mType="";

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
if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}

if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
}

if (request.getParameter("InstCode")==null)
{
	mInst="";
}
else
{	
	mInst=request.getParameter("InstCode").toString().trim();
}

if(request.getParameter("EID")==null)
{
	mEID="";
}
else
{
	mEID=request.getParameter("EID").toString().trim();	
}
	
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Cancel Leave Request NOC Detail] </TITLE>
 
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<script language=javascript>
 
	function RefreshContents()
	{ 	
    	    document.frm.x.value='ddd';
    	    document.frm.submit();
	}
//-->
</script>
<script>
function Validate()
{
if(document.frm.Remarks.value=="" || document.frm.Remarks.value==" ")
	{
		alert('Please Enter Some Remarks!');
		document.frm.Remarks.value="";
		frm.Remarks.focus();
		return false;
    }
}
</script>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
try
{
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

		qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from institutemaster WHERE nvl(Deactive,'N')='N' ";
		rs=db.getRowset(qry);
		if(rs.next())
			mInst=rs.getString(1);	
		else
			mInst="JIIT";
		
		String mCurrDate="";
		qry="Select to_Char(SysDate,'dd-mm-yyyy')date1 from dual";
		rs=db.getRowset(qry);
		rs.next();
		mCurrDate=rs.getString("date1");

	  //-----------------------------
	  //-- Enable Security Page Level  
	  //-----------------------------
	  
		qry="Select WEBKIOSK.ShowLink('162','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
		  //----------------------
		  	%>
			<form name="frm"  method="post" action="RequestNOCCancelUpdate.jsp" >
			<input id="x" name="x" type=hidden>
		
			<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
			<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Cancel Leave Request NOC Detail</b></font></td></tr>
			</TABLE>
			<%
			qry="SELECT  B.EmployeeName||' ['||B.EmployeeCode||']' EMPLOYEENAME ,nvl(B.EMPLOYEEID,' ')EMPLOYEEID,nvl(to_char(A.REPORTINGDATE,'dd-mm-yyyy'),' ')REPORTINGDATE ,nvl(to_char(A.DATEOFRELIEVING,'dd-mm-yyyy'),' ')DATEOFRELIEVING, nvl(A.REMARKS,' ')REMARKS,decode(A.NOTICEDAYS,'',' ',A.NOTICEDAYS)NOTICEDAYS,decode(A.TYPE,'R','Resign','T','Transfer')TYPE FROM EMPLOYEELEAVING A,EMPLOYEEMASTER B WHERE A.EMPLOYEEID=B.EMPLOYEEID AND A.EMPLOYEEID='"+mEID+"' ";
			//out.print(qry);
			rs=db.getRowset(qry);
			if(rs.next())
			{
				mEname=rs.getString("EMPLOYEENAME");
				mReportDt=rs.getString("REPORTINGDATE");
				mRelivingDt=rs.getString("DATEOFRELIEVING");
				mNoticeDay=rs.getInt("NOTICEDAYS");
				mType=rs.getString("TYPE");
			}

		if(request.getParameter("x")!=null)
			{
					mRemark=request.getParameter("Remarks").toString().trim();
			}
		else
			{
					mRemark=mRemark;			
			}
				%>
			<br>
			<TABLE  rules=none cellSpacing=0 cellPadding=3 border=2 align=center>
			<tr><td nowrap><FONT Color=Black face=arial size=2><B>&nbsp;Staff Name</B></td><td><b>&nbsp; : </b></td><td> </Font><FONT Color=Black face=arial size=2><%=mEname%>&nbsp;</Font></td></tr>

			<tr><td nowrap><FONT Color=Black face=arial size=2><B>&nbsp;Date of Reporting </B></td><td><b>&nbsp; : </b></td><td> </Font><FONT Color=Black face=arial size=2>(<%=mReportDt%>)&nbsp;<b>&nbsp;Date of Releving :</b>&nbsp;(<%=mRelivingDt%>)</Font></td></tr>
					
			<tr><td nowrap><FONT Color=Black face=arial size=2><B>&nbsp;Notice Days </B></td><td><b>&nbsp; : </B></td><td> </Font><FONT Color=Black face=arial size=2><%=mNoticeDay%>&nbsp;&nbsp;&nbsp;&nbsp;<b>Reason :</b>&nbsp;<%=mType%></Font></td></tr>
			
			<tr><td nowrap><FONT Color=Black face=arial size=2><B>&nbsp;Cancel Date </B></td><td><b>&nbsp; : </B></td><td> </Font><FONT Color=Black face=arial size=2><%=mCurrDate%></Font></td></tr>

			<tr><td nowrap><FONT Color=Black face=arial size=2><B>&nbsp;Please Give Remarks</B></td><td><b>&nbsp; : </B></td><td><TEXTAREA NAME="Remarks" tabindex=1 ROWS="2" COLS="40" maxlength=20 size=10><%=mRemark%></TEXTAREA></Font></td></tr>
			
			<input type=hidden ID=EID NAME=EID value=<%=mEID%>>
			<tr>
			<td align=center colspan=3>
			<input type="submit" name="Submit" tabindex=2 value="ClickToCancel" onClick="return Validate();"></td>
			</tr>
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
		<h3><br><img src='../../../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
		<P>This page is not authorized/available for you.
		<br>For assistance, contact your network support team. 
		</font><br><br><br><br> 
   		<%
  		}
		//-----------------------------
	}
	else
	{
		out.print("<br><img src='../../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}      
}//try end
catch(Exception e)
{
//out.print(" Error is there!!!!");
}
%>

</body>
</html>