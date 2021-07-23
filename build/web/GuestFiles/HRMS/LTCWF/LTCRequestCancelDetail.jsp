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
String mEname="" ;
String  mAdvDate="",mAdvDesc="",mRequestRemarks="";
int mNoInstal=0;
double  mAdvAmount=0;

if (session.getAttribute("MemberID")==null)
	mMemberID="";
else
	mMemberID=session.getAttribute("MemberID").toString().trim();

if (session.getAttribute("MemberType")==null)
	mMemberType="";
else
	mMemberType=session.getAttribute("MemberType").toString().trim();

if (session.getAttribute("MemberName")==null)
	mMemberName="";
else
	mMemberName=session.getAttribute("MemberName").toString().trim();

if (session.getAttribute("CompanyCode")==null)
	mComp="";
else
	mComp=session.getAttribute("CompanyCode").toString().trim();
if (session.getAttribute("MemberCode")==null)
	mMemberCode="";
else
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
if (request.getParameter("InstCode")==null)
	mInst="";
else
	mInst=request.getParameter("InstCode").toString().trim();

if(request.getParameter("EID")==null)
	mEID="";
else
	mEID=request.getParameter("EID").toString().trim();	

if(request.getParameter("RID")==null)
	mRID="";
else
	mRID=request.getParameter("RID").toString().trim();

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Cancel LTC Leave Request ]   </TITLE>

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
if(document.frm.Remarks.value.length==0)
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
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
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
	  
		qry="Select WEBKIOSK.ShowLink('176','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
			 //----------------------
			 // For Log Entry 
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

		  	%>
			<form name="frm"  method="post" >
			<input id="x" name="x" type=hidden>
			<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
			<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><u><b>Cancel LTC Leave Detail </b></u></font></td></tr>
			</TABLE>
			<%
			qry="SELECT  B.EmployeeName||' ['||B.EmployeeCode||']' EMPLOYEENAME ,nvl(B.EMPLOYEEID,' ')EMPLOYEEID,nvl(to_char(A.LTCDATE,'dd-mm-yyyy'),' ')LTCDATE, nvl(C.LTCDESC,' ')LTCDESC,decode(A.LTCAMOUNT,'',' ',LTCAMOUNT)LTCAMOUNT,decode(A.NOOFINSTALLMENT,'',' ',NOOFINSTALLMENT)NOOFINSTALLMENT, nvl(A.REQUESTREMARKS,' ')REQUESTREMARKS FROM PAY#EMPOTHERLTCREQUEST A,V#STAFF B,PAY#LTCTYPEMASTER C WHERE A.MEMBERID=B.EMPLOYEEID AND A.MEMBERID='"+mEID+"' and A.REQUESTID='"+mRID+"' and  A.COMPANYCODE='"+mComp+"' and A.INSTITUTECODE='"+mInst+"' AND A.LTCTYPE=C.LTCTYPE AND A.MEMBERID=B.EMPLOYEEID	";

			//out.print(qry);
			rs=db.getRowset(qry);
			if(rs.next())
			{
				mEname=rs.getString("EMPLOYEENAME");
				mAdvDate=rs.getString("LTCDATE");
				mAdvDesc=rs.getString("LTCDESC");
			
				mNoInstal=rs.getInt("NOOFINSTALLMENT");
				mRequestRemarks=rs.getString("REQUESTREMARKS");
			}
			%>
			<br>
			<TABLE  rules=none cellSpacing=0 cellPadding=3 border=2 align=center>
			<tr><td nowrap><FONT Color=Black face=arial size=2><B>&nbsp;Staff Name</B></td><td><b>&nbsp; : </b></td><td> </Font><FONT Color=black face=arial size=2><b><%=mEname%>&nbsp;</b></Font></td></tr>

					
			<tr><td nowrap><FONT Color=Black face=arial size=2><B>&nbsp;LTC Leave Description </B></td><td><b>&nbsp; : </B></td><td> </Font><FONT Color=Black face=arial size=2><%=mAdvDesc%>&nbsp;&nbsp;&nbsp;&nbsp;<b>No. of Installment :</b>&nbsp;<%=mNoInstal%></Font></td></tr>

			<tr><td nowrap><FONT Color=Black face=arial size=2><B>&nbsp;LTC Date</B></td><td><b>&nbsp; : </b></td><td> </Font><FONT Color=Black face=arial size=2><%=mAdvDate%>&nbsp;</Font></td></tr>

			<tr><td nowrap><FONT Color=Black face=arial size=2><B>&nbsp;Purpose</B></td><td><b>&nbsp; : </b></td><td> </Font><FONT Color=Black face=arial size=2><%=mRequestRemarks%>&nbsp;</Font></td></tr>

			<tr><td nowrap><FONT Color=Black face=arial size=2><B>&nbsp;Cancel Date </B></td><td><b>&nbsp; : </B></td><td> </Font><FONT Color=Black face=arial size=2><%=mCurrDate%></Font></td></tr>

			<tr><td nowrap><FONT Color=Black face=arial size=2><B>&nbsp;Please Give Remarks</B></td><td><b>&nbsp; : </B></td><td><TEXTAREA NAME="Remarks" id="Remarks" tabindex=1 ROWS="2" COLS="40" maxlength=20 size=10><%=mRemark%></TEXTAREA></Font></td></tr>
			
			<input type=hidden ID=EID NAME=EID value=<%=mEID%>>
			<input type=hidden ID=RID NAME=RID value=<%=mRID%>>
			
			<tr>
			<td align=center colspan=3>
			<input type="submit" name="SubmitCancel" tabindex=2 value="ClickToCancel" onClick="return Validate();"></td>
			</tr>
			</table>
			</form>
			<%
			if(request.getParameter("x")!=null)
			{
				if(request.getParameter("Remarks")!=null)
					mRemark=request.getParameter("Remarks").toString().trim();
						else
					mRemark="";
				if(!mRemark.equals(""))
				{
					String mEmpName="";
					qry="select EmployeeName from V#STAFF where EmployeeID='"+mEID+"' ";
					rs=db.getRowset(qry);
					if(rs.next())
					{
						mEmpName=rs.getString(1);
					}
					qry="UPDATE PAY#EMPOTHERLTCREQUEST SET STATUS='C' ,APPROVEDBY='"+mChkMemID+"', APPROVEDDATE=SYSDATE ,APPROVALCANCELREMARKS='"+mRemark+"' where MEMBERID='"+mEID+"' AND REQUESTID='"+mRID+"' ";
					n=db.update(qry);
					if(n>0)
					{
					// Log Entry
					//-----------------
 					db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType,"LTC LEAVE CANCEL", "Staff :"+mEmpName+" RequestID :"+mRID, "NO MAC ADDRESS",  mIPAddress);
					//-----------------
					response.sendRedirect("LTCRequestCancel.jsp");
					}
					else
					{
						%><CENTER><%
						out.print("<img src='../../../Images/Error1.jpg'>");
						out.print("<font size=4 color=red face='arial'><b>Error while saving record...</b></font>");
						%></CENTER><%
					}
				}
			else
				{
				%><table align=center><tr><td>
					<b><font size=2 face='Arial' color='RED'>Remarks cant be Left Blank !</font></b>
					</td></tr></table><%
				}
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