<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../../../CommonFiles/ExceptionHandler.jsp" %>
<%@ page import="java.util.ArrayList,java.util.Iterator" %>
<%
DBHandler db=new DBHandler();
ResultSet rs=null,rsi=null;
GlobalFunctions gb =new GlobalFunctions();
OLTEncryption enc=new OLTEncryption();
String qry="", mAdvApplTo="", QryApplTo="";
String mComp="", mInst="", QryLTCType="", mAdvReqID="", WFCode="LTC";
int mMinNoOfEMI=0, mMaxNoOfEMI=0, QryNoOfEMI=0, mMinEMI=0, mMaxEMI=0, QryMinEMI=0, QryMaxEMI=0;
int errFlag=0, n=0, QRYNOOFEMI=0;
double mIntRate=0, QryIntRate=0, QryNOOFEMI=0, QryIntAmt=0, QryAdvAmt=0, QryEMIVal=0;
double QryTotalVal=0, QryTotalIntAmt=0;
String QryFaculty="", mFaculty="", mFacultyName="", mRightsID="170";
String mMemberID="", mDMemberID="";
String mMemberType="", mDMemberType="", mMemberCode="", mDMemberCode="";
String mDeptCode="", mDedFrom="", mIntType="", QryDedFrom="", QryIntType="";
String mDateOfReq="", mDateOfAdv="", CurrDate="";
String QryAdvType="", mAdvType="", mAdvDesc="", QryPOA="";

if (session.getAttribute("MemberID")==null)
	mMemberID="";
else
	mMemberID=session.getAttribute("MemberID").toString().trim();

if (session.getAttribute("MemberType")==null)
	mMemberType="";
else
	mMemberType=session.getAttribute("MemberType").toString().trim();

if (session.getAttribute("MemberCode")==null)
	mMemberCode="";
else
	mMemberCode=session.getAttribute("MemberCode").toString().trim();

if (session.getAttribute("DepartmentCode")==null)
	mDeptCode="";
else
	mDeptCode=session.getAttribute("DepartmentCode").toString().trim();

if (session.getAttribute("CompanyCode")==null)
	mComp="";
else
	mComp=session.getAttribute("CompanyCode").toString().trim();

if (session.getAttribute("InstituteCode")==null)
	mInst="";
else
	mInst=session.getAttribute("InstituteCode").toString().trim();

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<HEAD>
<TITLE>#### <%=mHead%> [ LTC Request ] </TITLE>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<!--Java Script Code For Clock - START-->
<script type="text/javascript">
<!--
function startclock()
{
var thetime=new Date();
var nhours=thetime.getHours();
var nmins=thetime.getMinutes();
var nsecn=thetime.getSeconds();
var nday=thetime.getDay();
var nmonth=thetime.getMonth();
var ntoday=thetime.getDate();
var nyear=thetime.getYear();
var AorP=" ";
if (nhours>=12)
    AorP="P.M.";
else
    AorP="A.M.";
if (nhours>=13)
    nhours-=12;
if (nsecn<10)
 nsecn="0"+nsecn;
if (nmins<10)
 nmins="0"+nmins;
if (nday==0)
  nday="Sunday";
if (nday==1)
  nday="Monday";
if (nday==2)
  nday="Tuesday";
if (nday==3)
  nday="Wednesday";
if (nday==4)
  nday="Thursday";
if (nday==5)
  nday="Friday";
if (nday==6)
  nday="Saturday";
nmonth+=1;
if (nyear<=99)
  nyear= "19"+nyear;
if ((nyear>99) && (nyear<2000))
 nyear+=1900;
document.forms.frm1.clockspot.value=nhours+": "+nmins+": "+nsecn+"  "+AorP+" "+nday+", "+ntoday+"-"+nmonth+"-"+nyear;
setTimeout('startclock()',1000);
}   
//-->
</script>
<!--Java Script Code For Clock - END-->

<script language=javascript>
<!--
function RefreshContents()
{ 	
	document.frm1.x.value='ddd';
	document.frm1.submit1();
}
//-->
</script>
<script language=javascript>
if(window.history.forward(1) != null)
window.history.forward(1);
function SubmitActive() 
{
	//alert('vijay')
	if(document.frm2.POA.value.length <= 0 ) 
	{
		document.frm2.submit2.disabled = true;
	}
	else
	{
		document.frm2.submit2.disabled = false;
	}
}
function ActiveSubmit() 
{
	if(document.frm2.POA.value.length > 300) 
	{
		//document.frm2.POA.value = document.frm2.Remarks.value.substr(0,300); 
		alert("'Purpose Of LTC' can't be more than 300 characters");
		return false;
	}
	else if(document.frm2.POA.value.length == 0) 
	{
		alert("'Purpose Of LTC' can't be lest blank!");
		return false;
	}
}
</script>
<STYLE>input {font-size:13px;}</STYLE>
</HEAD>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
try
{
	if(!mMemberID.equals("") && !mMemberCode.equals(""))
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
		qry="Select WEBKIOSK.ShowLink('"+mRightsID+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
			// For Log Entry Purpose
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
			//--------------------------------------
			%>
			<form name="frm1" method="post">
			<input id="x" name="x" type=hidden>
			<table align=center width="103%" bottommargin=0 topmargin=0 leftmargin=0 rightmargin=0>
<!-------------Page Heading and Marquee Message----------------------->
			<%
			try
			{
				String mPageHeader="LTC Request", mMarqMsg="";//, CurrDate="";
				qry="Select to_char(sysdate,'dd-mm-yyyy')CurrDate from dual";
				rs=db.getRowset(qry);
				if(rs.next())
				{
					CurrDate=rs.getString("CurrDate");
				}
				qry="Select nvl(A.MARQUEEMESSAGE,' ')MarqMsg FROM PAGEBASEDMEESSAGES A WHERE A.RIGHTSID='"+mRightsID+"' and A.RELATEDTO LIKE '%E%' and to_date('"+CurrDate+"','dd-mm-yyyy') between MESSAGEFLASHFROMDATETIME and MESSAGEFLASHUPTODATETIME and nvl(DEACTIVE,'N')='N'";
				rs=db.getRowset(qry);
				if(rs.next())
				{
					mMarqMsg=rs.getString("MarqMsg");
					%>
					<tr><td width=100% bgcolor="#A53403" style="FONT-WEIGHT:bold; FONT-SIZE:smaller; WIDTH:100%; HEIGHT:15px; FONT-VARIANT:small-cap; filter:progid:DXImageTransform.Microsoft.Gradient(startColorStr='Orange', endColorStr='#A53403', gradientType='0'"><marquee behavior="" scrolldelay=100 width=100%><font color="white" face=arial size=2><STRONG><%=mMarqMsg%></STRONG></font></marquee></b></td><tr>
					<%
				}
				qry="Select nvl(B.PAGEHEADER,'LTC Request')PageHeader FROM WEBKIOSKRIGHTSMASTER B WHERE B.RIGHTSID='"+mRightsID+"' and B.RELATEDTO LIKE '%E%'";
				rs=db.getRowset(qry);
				if(rs.next())
				{
					mPageHeader=rs.getString("PageHeader");
					%>
					<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4> <%=mPageHeader%> </FONT></u></b></font></td></tr>
					<%
				}
				else
				{
					%>
					<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4> <%=mPageHeader%> </FONT></u></b></font></td></tr>
					<%
				}
			}
			catch(Exception e)
			{}
			%>
<!-------------Page Heading and Marquee Message----------------------->
			</table></center><br>

			<table valign=middle border=2 cellpadding=5 cellspacing=0 align=center rules=groups border=0>
		<!--Show Clock Here-->
			<tr><td colspan=4>
			<div>
			<p align="center" style="margin-top: 0; margin-bottom: 0">
			<!--<font face="Arial" size="2"><B>Current Time: </font></B>--><input style="color:#de6400; background-color:#fce9c5;font-weight:bold;font-face:'arial black';position:relative;font-size:10px" type="text" id="clockspot" name="clockspot" size="33" READONLY>
			</div>
			</td></tr>
		<!------------------->
			<tr><td nowrap><font color=black face=arial size=2><STRONG>&nbsp;Employee : &nbsp;</STRONG></font></td>
			<td Nowrap>
			<%
			qry="select distinct nvl(EMPLOYEEID,' ')Faculty, nvl(EMPLOYEENAME,' ')FacultyName from V#STAFF where employeeid='"+mChkMemID+"' and nvl(deactive,'N')='N'";
			rs=db.getRowset(qry);
			%>
			<select name="Faculty" tabindex="0" id="Faculty" style="WIDTH: 230px" >
			<%
			if(request.getParameter("x")==null)
			{	
				while(rs.next())
				{
				 	mFaculty=rs.getString("Faculty");
					if(QryFaculty.equals(""))
					{
						QryFaculty=mFaculty;
					}
				 	mFacultyName=rs.getString("FacultyName");
					%>
					<option value=<%=mFaculty%>><%=mFacultyName%></option>
					<%
				}
			}
			else
			{
				while(rs.next())
				{
			   		mFaculty=rs.getString("Faculty");
					QryFaculty="mFaculty";
				   	mFacultyName=rs.getString("FacultyName");
				   	if(mFaculty.equals(request.getParameter("Faculty").toString().trim()))
					{
						QryFaculty=mFaculty;
						%>
		    				<option selected value=<%=mFaculty%>><%=mFacultyName%></option>
						<%
				  	}
					else
		      		{
						%>
			    			<option  value=<%=mFaculty%>><%=mFacultyName%></option>
						<%
					}	
				}
			}
			%>
			</select>
			</td>
			<td nowrap><font color=black face=arial size=2><STRONG>&nbsp;Date Of LTC : &nbsp;</STRONG></font></td>
			<%
			if (request.getParameter("x")!=null)
			{
				mDateOfAdv=request.getParameter("DateOfAdv").toString().trim();
			}
			else
			{
				mDateOfAdv=CurrDate;
			}
			%>
			<td nowrap><input Name=DateOfAdv Id=DateOfAdv style="height:22px" Type=text maxlength=10 size=8 value='<%=mDateOfAdv%>' READONLY><a href="javascript:NewCal('DateOfAdv','ddmmyyyy')"><img src="../../../../Images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>
			</td></tr>

			<tr><td nowrap><font color=black face=arial size=2><STRONG>&nbsp;LTC Type : &nbsp;</STRONG></font></td>
			<td nowrap>
			<%
			qry="select distinct LTCTYPE ADVTYPE, APPLICABLETO APPLTO, nvl(LTCDESC,' ')ADVDESC, nvl(DEDUCTIONFROM,'O')DEDFROM, nvl(MINNOOFEMI,0)MINNOEMI, nvl(MAXNOOFEMI,0)MAXNOEMI, nvl(INTERESTRATE,0)INTRATE, nvl(TYPEOFINTEREST,'S')INTTYPE";
			qry=qry+" from PAY#LTCTYPEMASTER where COMPANYCODE='"+mComp+"' AND APPLICABLETO='"+mDMemberType+"' and nvl(DEACTIVE,'N')='N' ORDER BY ADVDESC";
			//out.print(qry);
			rs=db.getRowset(qry);
			%>
			<select name="ADVTYPE" tabindex="0" id="ADVTYPE" style="WIDTH: 230px">
			<%
			if(request.getParameter("x")==null)
			{	
				while(rs.next())
				{
				 	mAdvType=rs.getString("ADVTYPE");
				 	mAdvApplTo=rs.getString("APPLTO");
				 	mDedFrom=rs.getString("DEDFROM");
					mMinEMI=rs.getInt("MINNOEMI");
					mMaxEMI=rs.getInt("MAXNOEMI");
					mIntRate=rs.getDouble("INTRATE");
				 	mIntType=rs.getString("INTTYPE");
					mAdvType=mAdvType+"@@@"+mDedFrom+"###"+mMinEMI+"$$$"+mMaxEMI+"&&&"+mIntRate+"***"+mIntType+"???"+mAdvApplTo;
					if(QryAdvType.equals(""))
					{
						QryAdvType=mAdvType;
					}
				 	mAdvDesc=rs.getString("ADVDESC");
					%>
					<option value=<%=mAdvType%>><%=mAdvDesc%></option>
					<%
				}
			}
			else
			{
				while(rs.next())
				{
				 	mAdvType=rs.getString("ADVTYPE");
				 	mAdvApplTo=rs.getString("APPLTO");
				 	mDedFrom=rs.getString("DEDFROM");
					mMinEMI=rs.getInt("MINNOEMI");
					mMaxEMI=rs.getInt("MAXNOEMI");
					mIntRate=rs.getDouble("INTRATE");
				 	mIntType=rs.getString("INTTYPE");
					mAdvType=mAdvType+"@@@"+mDedFrom+"###"+mMinEMI+"$$$"+mMaxEMI+"&&&"+mIntRate+"***"+mIntType+"???"+mAdvApplTo;
				   	mAdvDesc=rs.getString("ADVDESC");
				   	if(mAdvType.equals(request.getParameter("ADVTYPE").toString().trim()))
					{
						QryAdvType=mAdvType;
						%>
		    				<option selected value=<%=mAdvType%>><%=mAdvDesc%></option>
						<%
				  	}
					else
		      		{
						%>
			    			<option  value=<%=mAdvType%>><%=mAdvDesc%></option>
						<%
					}	
				}
			}
			%>
			</select>
			</td>
			<td nowrap align=left><b><font face=arial size=2>&nbsp;LTC Amount : &nbsp;</font></b></td>
			<%
			try
			{
				if(request.getParameter("AdvAmt")==null)
					QryAdvAmt=0;
				else
					QryAdvAmt=Double.parseDouble(request.getParameter("AdvAmt").toString().trim());
			}
			catch(Exception e)
			{
				errFlag++;
			}
			%>
			<td nowrap><Input style="text-align=right" type="text" style="position:relative;width:91px;font-size:10px" id="AdvAmt" name="AdvAmt" maxlength=12 value=<%=QryAdvAmt%>><FONT color=red>*</FONT></td>
			</tr>
			<tr><td nowrap><b><font face=arial size=2>&nbsp;No. Of EMIs : &nbsp;</font></b></td>
			<td nowrap colspan=3>
			<%
			qry="Select MIN(MINNOOFEMI)MINNOOFEMI, MAX(MAXNOOFEMI)MAXNOOFEMI from PAY#LTCTYPEMASTER WHERE COMPANYCODE='"+mComp+"' AND APPLICABLETO='"+mDMemberType+"' AND nvl(DEACTIVE,'N')='N' GROUP BY COMPANYCODE, APPLICABLETO";
			rs=db.getRowset(qry);
			//out.print(qry);
			if(rs.next())
			{
				mMinNoOfEMI=rs.getInt("MINNOOFEMI");
				mMaxNoOfEMI=rs.getInt("MAXNOOFEMI");
			}
			%>
			<select name="NOOFEMI" tabindex="0" id="NOOFEMI" style="WIDTH: 50px" >
			<%
			if(request.getParameter("x")==null)
			{
				for(int NoOfEMI=mMinNoOfEMI;NoOfEMI<=mMaxNoOfEMI;NoOfEMI++)
				{
					if(QryNoOfEMI==0)
					{
						QryNoOfEMI=NoOfEMI;
					}
					%>
					<option value=<%=NoOfEMI%>><%=NoOfEMI%></option>
					<%
				}
			}
			else
			{
				for(int NoOfEMI=mMinNoOfEMI;NoOfEMI<=mMaxNoOfEMI;NoOfEMI++)
				{
				   	if(NoOfEMI==Integer.parseInt(request.getParameter("NOOFEMI").toString().trim()))
					{
						QryNoOfEMI=NoOfEMI;
						%>
		    				<option selected value=<%=NoOfEMI%>><%=NoOfEMI%></option>
						<%
				  	}
					else
		      		{
						%>
			    			<option  value=<%=NoOfEMI%>><%=NoOfEMI%></option>
						<%
					}
				}
			}
			%>
			</select>&nbsp;
			<INPUT id=submit1 style="BACKGROUND-COLOR:TRANSPARENT; FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 50px; HEIGHT: 23px; FONT-VARIANT: normal" type=submit value="OK" name=submit1 title="Click To Check EMI Calculation">
			<a target=_new href="../WorkFlowApprovalLevel.jsp?WFC=<%=WFCode%>&amp;DEPTCODE=<%=mDeptCode%>" title="Click to View Default (Departmentwise) Approval Level"><marquee behavior=alternate scrolldelay=100 width=76% style="cursor:hand"><font color="blue" face=arial size=2><STRONG>Click To View Default Work Flow</STRONG></font></marquee></a>
			</td></tr>
			</table>
			</form>
		<!--Start Clock Here-->
			<font face="Lucida Sans Unicode" size="2">
			<script type="text/javascript">
			<!-- 
			startclock();
			//-->
			</script>
			</font>
		<!-------------------->
			<%
			if(request.getParameter("x")!=null)
			{
				if (request.getParameter("Faculty")!=null)
					QryFaculty=request.getParameter("Faculty").toString().trim();
				else
					QryFaculty="";
				if (request.getParameter("DateOfAdv")!=null)
					mDateOfAdv=request.getParameter("DateOfAdv").toString().trim();
				else
					mDateOfAdv=CurrDate;
				if (request.getParameter("ADVTYPE")!=null)
				{
					QryLTCType=QryAdvType;
					QryAdvType=request.getParameter("ADVTYPE").toString().trim();
				}
				else
					QryAdvType="";
				if(!QryAdvType.equals(""))
				{
					int len=0, pos1=0, pos2=0, pos3=0, pos4=0, pos5=0, pos6=0;
					String mAType="";
					len=QryAdvType.length();
					pos1=QryAdvType.indexOf("@@@");
					pos2=QryAdvType.indexOf("###");
					pos3=QryAdvType.indexOf("$$$");
					pos4=QryAdvType.indexOf("&&&");
					pos5=QryAdvType.indexOf("***");
					pos6=QryAdvType.indexOf("???");
					mAType=QryAdvType.substring(0,pos1);
				 	QryDedFrom=QryAdvType.substring(pos1+3,pos2);
					QryMinEMI=Integer.parseInt(QryAdvType.substring(pos2+3,pos3));
					QryMaxEMI=Integer.parseInt(QryAdvType.substring(pos3+3,pos4));
					QryIntRate=Double.parseDouble(QryAdvType.substring(pos4+3,pos5));
				 	QryIntType=QryAdvType.substring(pos5+3,pos6);
				 	QryApplTo=QryAdvType.substring(pos6+3,len);
				 	QryAdvType=mAType;
				}
				try
				{
					if(request.getParameter("AdvAmt")==null)
						QryAdvAmt=0;
					else
						QryAdvAmt=Double.parseDouble(request.getParameter("AdvAmt").toString().trim());
				}
				catch(Exception e)
				{
					errFlag++;
				}

				if(request.getParameter("NOOFEMI")==null)
					QryNOOFEMI=0;
				else
					QryNOOFEMI=Double.parseDouble(request.getParameter("NOOFEMI").toString().trim());
				//QryNOOFEMI=Double.parseDouble(QryNoOfEMI);

				QryNOOFEMI=QryNOOFEMI/12;
				if(QryIntType.equals("C"))
				{
					QryIntAmt=(Math.pow((1.0+(QryIntRate/100.0)),(QryNOOFEMI)));
					QryNOOFEMI=QryNOOFEMI*12;
					QryTotalVal=QryAdvAmt*QryIntAmt;
					QryEMIVal=(QryAdvAmt*(QryIntAmt/QryNOOFEMI));
				}
				else if(QryIntType.equals("S"))
				{
					QryIntAmt=(QryAdvAmt*QryIntRate*QryNOOFEMI)/100;
					QryNOOFEMI=QryNOOFEMI*12;
					QryTotalVal=QryAdvAmt+QryIntAmt;
					QryEMIVal=((QryAdvAmt+QryIntAmt)/QryNOOFEMI);
				}
				QryTotalIntAmt=gb.getRound((QryTotalVal-QryAdvAmt),2);
				QryEMIVal=gb.getRound(QryEMIVal,2);
				//QryEMIVal=Math.round(QryEMIVal);
				QryTotalVal=gb.getRound(QryTotalVal,2);
				QryIntRate=gb.getRound(QryIntRate,2);
			}
			if(request.getParameter("x")!=null)
			{
				QRYNOOFEMI=(int)QryNOOFEMI;
				qry="Select 'Y' from PAY#LTCTYPEMASTER Where COMPANYCODE='"+mComp+"' AND LTCTYPE='"+QryAdvType+"' AND APPLICABLETO='"+QryApplTo+"'";
				qry=qry+" AND trunc(to_date('"+mDateOfAdv+"','DD-MM-YYYY'))>=trunc(sysdate)";
				rs=db.getRowset(qry);
				if(rs.next())
				{
					if(QryAdvAmt>0)
					{
						qry="Select 'Y' from PAY#LTCTYPEMASTER Where COMPANYCODE='"+mComp+"' AND LTCTYPE='"+QryAdvType+"' AND APPLICABLETO='"+QryApplTo+"'";
						qry=qry+" AND "+QRYNOOFEMI+" BETWEEN "+QryMinEMI+" and "+QryMaxEMI+"";
						rs=db.getRowset(qry);
						if(rs.next())
						{
							%>
							<form name="frm2" method="post">
							<input id="x" name="x" type=hidden>
							<input id="y" name="y" type=hidden>
							<input id="Faculty" name="Faculty" type=hidden value=<%=QryFaculty%>>
							<input id="DateOfAdv" name="DateOfAdv" type=hidden value=<%=mDateOfAdv%>>
							<input id="NOOFEMI" name="NOOFEMI" type=hidden value=<%=QRYNOOFEMI%>>
							<input id="AdvAmt" name="AdvAmt" type=hidden value=<%=QryAdvAmt%>>
							<input id="ADVTYPE" name="ADVTYPE" type=hidden value=<%=QryLTCType%>>
							<%
							//out.print(QryDedFrom+" "+QryMinEMI+" "+QryMaxEMI+" "+QryIntRate+" "+QryIntType+" "+QryAdvType);
							%>
							<table valign=middle border=2 cellpadding=5 cellspacing=0 align=center rules=groups border=0>
							<tr>
							<td nowrap colspan=2>
							<b><font face=arial size=2>Total Amount <font size=1>(LTC+Interest) </font>:&nbsp;</font></b><%=QryTotalVal%>
							<b><font face=arial size=2>&nbsp;Rate Of Interest :&nbsp;</font></b><%=QryIntRate%>% [<%=QryIntType%>] p.a.
							<b><font face=arial size=2>&nbsp;EMI Amount :&nbsp;</font></b><%=QryEMIVal%>
							</td>
							</tr>

							<tr><td nowrap><b><font face=arial size=2>Purpose Of LTC :&nbsp;</font></b></td>
							<td nowrap><TextArea type="text" id="POA" name="POA" maxlength=300 cols=53 rows=2 OnChange="SubmitActive()"></TextArea><FONT color=red>*</FONT></td></tr>

							<tr><td colspan=2 align=center><INPUT id=submit2 style="BACKGROUND-COLOR:TRANSPARENT; FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 70px; HEIGHT: 23px; FONT-VARIANT: normal" type=submit value="Request" name=submit2 title="Request for LTC" onclick="return ActiveSubmit();"></td></tr>
							</table>
							</form>
							<%
						}
						else
						{
							%><table align=center><tr><td>
							<b><font size=2 face='Arial' color='RED'>For selected LTC Type, the permissible 'No of EMIs' should be between <%=QryMinEMI%> and <%=QryMaxEMI%>...</font></b>
							</td></tr></table><%
						}
					}
					else if(errFlag==0)
					{
						%><table align=center><tr><td>
						<b><font size=2 face='Arial' color='RED'>LTC Amount must be greater than zero ('0')!</font></b>
						</td></tr></table><%
					}
				}
				else
				{
					%><table align=center><tr><td>
					<b><font size=2 face='Arial' color='RED'>'Date OF LTC' must be of current date or later!</font></b>
					</td></tr></table><%
				}
			}
			if(errFlag>0)
			{
				%><table align=center><tr><td>
				<b><font size=2 face='Arial' color='RED'>'LTC Amount' must be Numeric and Greater than zero ('0')!</font></b>
				</td></tr></table><%
			}
			if(request.getParameter("y")!=null)
			{
				if (request.getParameter("POA")!=null)
					QryPOA=request.getParameter("POA").toString().trim();
				else
					QryPOA="";
				if(!QryPOA.equals(""))
				{
					qry="SELECT 'Y' FROM PAY#EMPOTHERLTCREQUEST WHERE COMPANYCODE='"+mComp+"' AND LTCTYPE='"+QryAdvType+"' AND MEMBERTYPE='"+mDMemberType+"' AND MEMBERID='"+mDMemberID+"' AND LTCDATE=to_date('"+mDateOfAdv+"','DD-MM-YYYY')";
					rs=db.getRowset(qry);
					//out.print(qry);
					if(!rs.next())
					{
						mAdvReqID=db.GetRequestID(mComp,mInst,WFCode);

						qry="INSERT INTO PAY#EMPOTHERLTCREQUEST(COMPANYCODE, INSTITUTECODE, LTCTYPE, MEMBERTYPE, MEMBERID, LTCDATE, REQUESTID, LTCAMOUNT, INSTALLMENT, NOOFINSTALLMENT, INTERESTAMOUNT, DEDUCTEDAMOUNT, REQUESTREMARKS, REQUESTBY, REQUESTDATE, WORKFLOWCODE, WORKFLOWTYPE, STATUS)";
						qry=qry+" VALUES('"+mComp+"', '"+mInst+"', '"+QryAdvType+"', '"+mDMemberType+"', '"+mDMemberID+"', to_date('"+mDateOfAdv+"','DD-MM-YYYY'), '"+mAdvReqID+"', '"+QryAdvAmt+"', 'Y', '"+QryNOOFEMI+"', '"+QryTotalIntAmt+"', '"+QryEMIVal+"', '"+QryPOA+"', '"+mDMemberID+"', sysdate ,'LTC', '"+QryAdvType+"','D')";
						n=db.insertRow(qry);
						//out.print(qry);
						if(n>0)
						{
							qry="Select nvl(LTCDESC,' ')LTCDESC from PAY#LTCTYPEMASTER where COMPANYCODE='"+mComp+"' AND LTCTYPE='"+QryAdvType+"' AND APPLICABLETO='"+mDMemberType+"'";
							rs=db.getRowset(qry);
							//out.print(qry);
							if(rs.next())
							{
								%><table align=center><tr><td>
								<b><font size=2 face='Arial' color='Green'>Your LTC Request for <%=rs.getString("LTCDESC")%> has been sent Successfully...</font></b>
								</td></tr></table><%
							}
						}
						else
						{
							%><table align=center><tr><td>
							<b><font size=2 face='Arial' color='RED'>Error while advance request!</font></b>
							</td></tr></table><%
						}
					}
					else
					{
						%><table align=center><tr><td>
						<b><font size=2 face='Arial' color='RED'>Request already exists! Kindly choose another request or different date...</font></b>
						</td></tr></table><%
					}
				}
				else
				{
					%><table align=center><tr><td>
					<b><font size=2 face='Arial' color='RED'>Purpose of LTC Request can't be left blank!</font></b>
					</td></tr></table><%
				}
			}
		//-----------------------------
		//---Enable Security Page Level  
		//-----------------------------
		}
		else
		{
			%>
			<br>
			<font color=red>
			<h3>	<br><img src='../../../../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
			<P>	This page is not authorized/available for you.
			<br>For assistance, contact your network support team. 
			</font>	<br>	<br>	<br>	<br> 
			<%
		}
		//-----------------------------
	}
	else
	{
		out.print("<br><img src='../../../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}
}
catch(Exception e)
{
}
%>
</body>
</html>