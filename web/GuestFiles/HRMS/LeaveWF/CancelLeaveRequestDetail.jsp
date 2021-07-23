<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="";
int n=0;
double mPAID=0,mLWP=0,mTotalLvDays=0;
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInst="",mComp="";
String mEID="",mLeaveCode="";
String mAprStat="";
String mSHDAY="", mEHDAY="",mSDATE="",mEDATE="",mPOL="";
String mWebEmail="";
String mRID="",mRemark="";

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

if(request.getParameter("RID")==null)
{
	mRID="";
}
else
{
	mRID=request.getParameter("RID").toString().trim();	
}
	
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Cancel Leave Request Detail] </TITLE>

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
	  
		qry="Select WEBKIOSK.ShowLink('165','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
		  //----------------------
		  	%>
			<form name="frm"  method="post" action="CancelLeaveRequestUpdate.jsp" onSubmit="return Validate();">
			<input id="x" name="x" type=hidden>
		
			<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
			<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Cancel Leave Request Detail</b></font></td></tr>
			</TABLE>
			<%
			String mENM="";
			qry="select EmployeeName||' ['||EmployeeCode||']' ENM from employeemaster where employeeid='"+mChkMemID+"' and nvl(Deactive,'N')='N' and employeeid IN (Select nvl(employeeid,' ') from LeaveRequest where REQUESTID='"+mRID+"')  ";
			//out.print(qry);
			rs1=db.getRowset(qry);
			if(rs1.next())
			{
				mENM=rs1.getString("ENM");
			}
			
			qry="select distinct nvl(B.EMPLOYEEID,'')EID,nvl(B.LEAVECODE,'')LCODE,Decode(B.STARTHALFDAY,'B','PreLunch','A','PostLunch',' ')SHDAY, Decode(B.ENDHALFDAY,'B','PreLunch','A','PostLunch',' ')EHDAY,nvl(B.PAID,0)PAID,nvl(B.WITHOUTPAY,0)LWP,nvl(B.PURPOSEOFLEAVE,'')POL,to_char(B.STARTDATE,'DD-MM-YYYY')SDATE,nvl(to_char(B.ENDDATE,'dd-mm-yyyy'),'')EDATE from LEAVEREQUEST B,EMPLOYEEMASTER A  WHERE B.EMPLOYEEID=A.EMPLOYEEID AND B.EMPLOYEEID='"+mChkMemID+"' and B.COMPANYCODE='"+mComp+"'and B.REQUESTID='"+mRID+"'"; 
			//out.print(qry);
			rs=db.getRowset(qry);
			if(rs.next())
			  {
				mPAID=rs.getDouble("PAID");
				mLWP=rs.getDouble("LWP");
				mTotalLvDays=mPAID+mLWP;
				mEID=rs.getString("EID");
				mPOL=rs.getString("POL");
				mSDATE=rs.getString("SDATE");
				mEDATE=rs.getString("EDATE");
				mLeaveCode=rs.getString("LCODE");
			 
				mSHDAY=rs.getString("SHDAY");
				mEHDAY=rs.getString("EHDAY");
								
				if(mSHDAY.trim().equals(""))
					{
						mSHDAY="None";
					}
					else
					{
						mSHDAY=rs.getString("SHDAY");
					}
					if(mEHDAY.trim().equals(""))
					{
						mEHDAY="None";
					}
					else
					{
						mEHDAY=rs.getString("EHDAY");
					}
			   }//end of rs.next()
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
			<tr><td nowrap><FONT Color=Black face=arial size=2><B>&nbsp;Staff Name</B></td><td><b>&nbsp; : </b></td><td> </Font><FONT Color=Black face=arial size=2><%=mENM%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Leave :</b> (<%=mLeaveCode%>)&nbsp;  </Font></td></tr>

			<tr><td nowrap><FONT Color=Black face=arial size=2><B>&nbsp;No. of Days Leave [<%=mLeaveCode%>] Applied </B></td><td><b>&nbsp; : </b></td><td> </Font><FONT Color=Black face=arial size=2><%=mTotalLvDays%>&nbsp;<b>&nbsp;&nbsp;(&nbsp;</b><%=mSDATE%>&nbsp; <b>to &nbsp; </b><%=mEDATE%><b>&nbsp;)</b></Font></td></tr>
			
			<tr><td nowrap><FONT Color=Black face=arial size=2><B>&nbsp;Half Day </B></td>
			<td><b>&nbsp; : </td></font><td><FONT Color=Black face=arial size=2><B>Start Day &nbsp;:&nbsp;</B><%=mSHDAY%></Font>&nbsp;&nbsp;<FONT Color=Black face=arial size=2><b>End Day&nbsp;:&nbsp;</b><%=mEHDAY%></font></td></tr>
		
			<tr><td nowrap><FONT Color=Black face=arial size=2><B>&nbsp;Purpose of Leave </B></td><td><b>&nbsp; : </B></td><td> </Font><FONT Color=Black face=arial size=2><%=mPOL%></Font></td></tr>
			
			<tr><td nowrap><FONT Color=Black face=arial size=2><B>&nbsp;Cancel Date </B></td><td><b>&nbsp; : </B></td><td> </Font><FONT Color=Black face=arial size=2><%=mCurrDate%></Font></td></tr>

			<tr><td nowrap><FONT Color=Black face=arial size=2><B>&nbsp;Please Give Remarks</B></td><td><b>&nbsp; : </B></td><td><TEXTAREA NAME="Remarks" tabindex=1 ROWS="2" COLS="50" maxlength=20 size=10><%=mRemark%></TEXTAREA></Font></td></tr>
			
			<input type=hidden ID=REQUESTID NAME=REQUESTID value=<%=mRID%>>
			<tr>
			<td align=center colspan=3>
			<input type="submit" name="Submit" tabindex=2 value="Click To Cancel"></td>
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
out.print(" Error is there!!!!");
}
%>
<br><br>
<table ALIGN=Center VALIGN=TOP>
<tr>
<td valign=middle>
<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../../Images/CampusConnectLogo.bmp">
<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>  
</td></tr></table>
</body>
</html>