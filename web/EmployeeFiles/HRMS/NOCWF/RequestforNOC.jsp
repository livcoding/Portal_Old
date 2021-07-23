<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%
try
{
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
String qry="";
String qryd="";
String qryi="";
String qrys="";
String qrys1="";
ResultSet rss1=null;
ResultSet rss=null;
ResultSet rsd=null;
ResultSet rs=null;
String mDate="";
String mHead="",mMemberCode="";
String mDMemberID="";
String mDMemberCode="";
String mDMemberType="";
String mInst="";
String mSysdate="";
String mMemberID="",mCompanyCode="",mDepartmentCode="";
String mMemberType="",mMemberName="";
String mRepDate="",mRelvDate="",mType="",mRemark="";
int mNoticeDays=0;
int ctr=0;
String mWFC="OUTNOC";
String mWFT="OUTNOC";
String mNOC=""; 
String mPrint="";
String mPrintS=""; 

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
{
	mHead=session.getAttribute("PageHeading").toString().trim();
}
else
{
	mHead="JIIT ";
}
if (session.getAttribute("MemberID")==null)
{
	mMemberID="";
}
else
{
	mMemberID=session.getAttribute("MemberID").toString().trim();
}
if (session.getAttribute("CompanyCode")==null)
{
	mCompanyCode="";
}
else
{
	mCompanyCode=session.getAttribute("CompanyCode").toString().trim();
}
if (session.getAttribute("DepartmentCode")==null)
{
	mDepartmentCode="";
}
else
{
	mDepartmentCode=session.getAttribute("DepartmentCode").toString().trim();
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
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Request for NOC ] </TITLE>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
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
<SCRIPT LANGUAGE="JavaScript">
 
function isNumber(e)
{
	var unicode=e.charCode? e.charCode : e.keyCode

	if (unicode!=8)
	{ //if the key isn't the backspace key (which we should allow)
		if ((unicode<48||unicode>57) && unicode!=46) //if not a number
		return false //disable key press
	}
}


	function iSValidDate(pDate)
 {
//1 

if(document.frm.RelevingDate.value!="" && document.frm.RelevingDate.value!=" ")
{
	
    var dn, mn, yn, maxday;
    var mDate = pDate;
    dn = 0;
    mn = 0;
    yn = 0;
    maxday = 0;
    var mISValidDate = false;
   // if (isNumeric(mDate.substring(0, 2)) && isNumeric(mDate.substring(3, 5)) &&
   // isNumeric(mDate.substring(6))) { //2]
	 if (mDate.length==10) {
        //3
        if (mDate.substring(2, 3).trim()=="-" && mDate.substring(5, 6).trim()=="-") { //4
           if (parseInt(mDate.substring(0,2).trim()) >= 1 &&
              parseInt(mDate.substring(0,2).trim()) <=31 &&
              parseInt(mDate.substring(3, 5).trim()) <= 12 &&
              parseInt(mDate.substring(3, 5).trim()) >= 1 &&
              parseInt(mDate.substring(6).trim()) >= 1900 &&
              parseInt(mDate.substring(6).trim()) <= 3000) { //5
            dn = parseInt(mDate.substring(0, 2).trim());
            mn = parseInt(mDate.substring(3,5).trim());
            yn = parseInt(mDate.substring(6).trim());
            if (mn == 4 || mn == 6 || mn == 9 || mn == 11)
              maxday = 30;
            else if (mn == 1 || mn == 3 || mn == 5 || mn == 7 || mn == 8 ||
                     mn == 10 || mn == 12)
              maxday = 31;
            else if (mn == 2 && (yn % 4 == 0 || yn % 400 == 0))
              maxday = 29;
            else
              maxday = 28;

            if (mn > 0 && mn <= 12 && dn > 0 && dn <= maxday)
              mISValidDate =true;
          } //5
		  else
		  {
  			alert('Please Enter the valid date format in Releving date field i.e DD-MM-YYYY.'); 
			document.frm.RelevingDate.value="";
			frm.RelevingDate.focus();
		  }
        } //4
		else
		  {
		alert('Please Enter the valid date format in Releving date field i.e DD-MM-YYYY.'); 
			document.frm.RelevingDate.value="";
			frm.RelevingDate.focus();
		  }
      } //3
	  else
		  {
		   alert('Please Enter the valid date format in Releving date field i.e DD-MM-YYYY.'); 
			document.frm.RelevingDate.value="";
			frm.RelevingDate.focus();
		  }
 //   } //2
  return (mISValidDate);
}
}
//-->
</SCRIPT>
<script>
	if(window.history.forward(1)!=null)
	window.history.forward(1);	
</script>
</head>
<body aLink=#ff00ff bgcolor='#fce9c5' rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{
	OLTEncryption enc=new OLTEncryption();
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
		qry="Select WEBKIOSK.ShowLink('162','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{
			qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from InstituteMaster Where nvl(Deactive,'N')='N' ";
			rs=db.getRowset(qry);
			if (rs.next())
				mInst=rs.getString(1);
			else
				mInst="JIIT";	

		qryd="select to_char(sysdate,'dd-mm-yyyy') from dual";
		rsd=db.getRowset(qryd);
		rsd.next();
		mSysdate=rsd.getString(1);
%>
	<table align=center width="100%" bottommargin=0 topmargin=0>
	<tr>
	<TD colspan=0 align=middle width=34%><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4>Request for NOC</FONT></u></b></td>
	</tr>
	</table>
	<form name="frm"  method="post"> 
	<input id="x" name="x" type=hidden>
	<table align=center bottommargin=0 cellspacing=0 cellpadding=2 topmargin=0 border=1 rule=rows width="98%">
	<tr>
	<td><b>Reporting Date<b>
	<input type=text value=<%=mSysdate%> readonly name=ReportingDate size=10 maxlength=10>
	</td>
	<td><b>Releving Date<b>
	<%
if (request.getParameter("x")!=null)
{
	mDate=request.getParameter("RelevingDate").toString().trim();
}
else
{
	mDate="";
}
%>
	<input readonly type=text name=RelevingDate size=10 value='<%=mDate%>' maxlength=10 onchange="return iSValidDate(RelevingDate.value);">&nbsp;<a href="javascript:NewCal('RelevingDate','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>

	</td>
	<td><b>Type<b>
		<select name=NType id=NType>
		<option value="R">Resign</option>
		</select>
	</td>
	</tr>
	<tr>
	<td><b>Notice Days<b>&nbsp; &nbsp; &nbsp;
	<input type=text name=NoticeDays size=10 maxlength=3 onkeypress="return isNumber(event)">
	</td>
	<td colspan=3><b>Remarks<b>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
	<input type=text name=Remark size=40 >
	</td>
	</tr>
	<tr>
	<td colspan=4 align=center>
	<input type=submit value="Save/Refresh">
	</td>
	</tr>
	</table>
	</form>
<%
if(request.getParameter("x")!=null)
{
		if(request.getParameter("ReportingDate")==null)
		mRepDate="";
		else
		mRepDate=request.getParameter("ReportingDate").toString().trim();
		
		if(request.getParameter("ReportingDate")==null)
		mRelvDate="";
		else
		mRelvDate=request.getParameter("ReportingDate").toString().trim();

		if(request.getParameter("NType")==null)
		mType="";
		else
		mType=request.getParameter("NType").toString().trim();

		if(request.getParameter("NoticeDays")==null || request.getParameter("NoticeDays").equals(""))
		mNoticeDays=0;
		else			mNoticeDays=Integer.parseInt(request.getParameter("NoticeDays").toString().trim());

		if(request.getParameter("Remark")==null)
		mRemark="";
		else
		mRemark=request.getParameter("Remark").toString().trim();
	
	qrys="select 'y' from EMPLOYEELEAVING where employeeid='"+mDMemberID+"' and NODUESSTATUS in ('A','C')  ";
//	and REPORTINGDATE=to_date('"+mRepDate+"','dd-mm-yyyy') and DATEOFRELIEVING=to_date('"+mRelvDate+"','dd-mm-yyyy') ";
	//out.print(qrys);
	rss=db.getRowset(qrys);
	if(!rss.next()) //---1
	{
	mNOC=db.GetRequestID(mCompanyCode,mInst,mWFC);
	qryi="INSERT INTO EMPLOYEELEAVING(EMPLOYEEID,TYPE,REPORTINGDATE,DATEOFRELIEVING,	 REMARKS,NOTICEDAYS,NODUESSTATUS,REQUESTID,WORKFLOWCODE,WORKFLOWTYPE)VALUES('"+mDMemberID+"' ,'"+mType+"',to_date('"+mRepDate+"','dd-mm-yyyy'),to_date('"+mRelvDate+"','dd-mm-yyyy'),'"+mRemark+"' ,'"+mNoticeDays+"','D','"+mNOC+"','"+mWFC+"','"+mWFT+"') ";
	int n=db.insertRow(qryi);

	if(n>0)
	{
		out.print("<font color=Green size=3><b>Request saved successfully...</b></font>");
	}   
	else
	{
		out.print("<font color=Red size=3><b>Error while saving request...</b></font>");
	}
	} // closing of ---1
	else
	{
		out.print("<font color=Red size=3><b>&nbsp;Request already under process...</b></font>");
	}
	

} // closing of if(request.getParameter("x")!=null)

%>
	<table align=center bottommargin=0 cellspacing=0 cellpadding=2 topmargin=0 border=1 rule=rows width="98%">
	<tr>
	<td align=center><b>SNo.</b></td>
	<td align=center><b>RequestDate</b></td>
	<td align=center><b>RelevingDate</b></td>
	<td align=center><b>Type</b></td>
	<td align=center><b>NoticeDays</b></td>
	<td align=center><b>Status</b></td>
	</tr>
<%
	qrys1="select nvl(TYPE,' ')TYPE,nvl(to_char(REPORTINGDATE,'dd-mm-yyyy'),' ')REPORTINGDATE,nvl(to_char(DATEOFRELIEVING,'dd-mm-yyyy'),' ')DATEOFRELIEVING,nvl(NOTICEDAYS,0)NOTICEDAYS,nvl(NODUESSTATUS,' ')NODUESSTATUS from Employeeleaving where employeeid='"+mDMemberID+"' ";
	rss1=db.getRowset(qrys1);
	while(rss1.next())
	{
		ctr++;
%>
	<tr>
	<td align=center><%=ctr%></td>
	<td align=center><%=rss1.getString("REPORTINGDATE")%></td>
	<td align=center><%=rss1.getString("DATEOFRELIEVING")%></td>
	<%
	if(rss1.getString("TYPE").equals("R"))
		mPrint="Resign";
	%>
	<td align=center><%=mPrint%></td>
	<td align=center><%=rss1.getInt("NOTICEDAYS")%></td>
	<%
	if(rss1.getString("NODUESSTATUS").equals("D"))
		mPrintS="Pending";
	else if(rss1.getString("NODUESSTATUS").equals("A"))
		mPrintS="Approved";
	else 
		mPrintS="Cancelled";
	%>
	<td align=center><%=mPrintS%></td>
	</tr>
<%
	}
%>
	</table>
<%
//-----------------------------
//---Enable Security Page Level  
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
}
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
}
catch(Exception e)
{
//out.print(e);
}
%>
</body>
</html>

