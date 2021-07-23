<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../../CommonFiles/ExceptionHandler.jsp" %>
<%@ page import="java.util.ArrayList,java.util.Iterator" %>
<%
DBHandler db=new DBHandler();
ResultSet rs=null,rsi=null;
GlobalFunctions gb =new GlobalFunctions();
OLTEncryption enc=new OLTEncryption();
String qry="", mAdvApplTo="", QryApplTo="";
String mComp="", mInst="", QryAdvanceType="",WFCode="ADVANCE";
int mMinNoOfEMI=0, mMaxNoOfEMI=0, QryNoOfEMI=0, mMinEMI=0, mMaxEMI=0, QryMinEMI=0, QryMaxEMI=0;
int errFlag=0, n=0, mSNo=0, mAdvFlag=0, QRYNOOFEMI=0;
double mIntRate=0, QryIntRate=0, QryNOOFEMI=0, QryIntAmt=0, QryAdvAmt=0, QryEMIVal=0;
double QryTotalVal=0, QryTotalIntAmt=0;
String QryFaculty="", mFaculty="", mFacultyName="", mRightsID="175";
String mMemberID="", mDMemberID="", mMemberName="";
String mMemberType="", mDMemberType="", mMemberCode="", mDMemberCode="";
String mDedFrom="", mIntType="", QryDedFrom="", QryIntType="";
String mDateOfReq="", mDateOfAdv="", CurrDate="",mAdvancetype="",mMemType="",mEname="";
String QryAdvType="", mAdvType="", mAdvDesc="", QryPOA="",mEID="",mRID="",mAdvDate="";

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

if (session.getAttribute("MemberCode")==null)
	mMemberCode="";
else
	mMemberCode=session.getAttribute("MemberCode").toString().trim();

if (session.getAttribute("CompanyCode")==null)
	mComp="";
else
	mComp=session.getAttribute("CompanyCode").toString().trim();

if (session.getAttribute("InstituteCode")==null)
	mInst="";
else
	mInst=session.getAttribute("InstituteCode").toString().trim();

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
<HEAD>
<TITLE>#### <%=mHead%> [ Edit Advance Leave Request ] </TITLE>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
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
		alert("'Purpose Of Advance' can't be more than 300 characters");
		return false;
	}
	else if(document.frm2.POA.value.length == 0) 
	{
		alert("'Purpose Of Advance' can't be lest blank!");
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

				qry="Select to_char(sysdate,'dd-mm-yyyy')CurrDate from dual";
				rs=db.getRowset(qry);
				if(rs.next())
				{
					CurrDate=rs.getString("CurrDate");
				}

			//--------------------------------------
			%>
			<form name="frm1" method="post">
			<input id="x" name="x" type=hidden>
			<table align=center width="100%" bottommargin=0 topmargin=0>
			<tr>
			<TD colspan=0 align=middle width=34%><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4>Edit Advance Request Detail</FONT></u></b></td>
			</tr>
			</table>
			<br>
	<%
			qry="SELECT nvl(A.MEMBERID,' ')MEMBERID,nvl(A.MEMBERTYPE,' ')MEMBERTYPE,nvl(to_char(A.ADVANCEDATE,'dd-mm-yyyy'),' ')ADVANCEDATE,nvl(C.EMPLOYEENAME,' ')EMPLOYEENAME, nvl(B.ADVANCETYPE,' ')ADVANCETYPE,NVL(A.REQUESTID,' ')REQUESTID,decode(A.ADVANCEAMOUNT,'',' ',ADVANCEAMOUNT)ADVANCEAMOUNT,decode(A.NOOFINSTALLMENT,'',' ',NOOFINSTALLMENT)NOOFINSTALLMENT, nvl(A.REQUESTREMARKS,' ')REQUESTREMARKS FROM PAY#EMPOTHERADVANCEREQUEST A,PAY#ADVANCETYPEMASTER B,V#STAFF C where A.MEMBERID='"+mEID+"' and  A.REQUESTID='"+mRID+"' AND A.COMPANYCODE='"+mComp+"' and A.INSTITUTECODE='"+mInst+"' AND A.ADVANCETYPE=B.ADVANCETYPE AND A.MEMBERID=C.EMPLOYEEID ";
			//out.print(qry);
			rs=db.getRowset(qry);
			if(rs.next())
			{
			mAdvDate=rs.getString("ADVANCEDATE");
			mAdvancetype=rs.getString("ADVANCETYPE");
			mMemType=rs.getString("MEMBERTYPE");
			}

		%>
			<table valign=middle border=2 cellpadding=5 cellspacing=0 align=center rules=groups border=0>
			<tr><td nowrap><font color=black face=arial size=2><STRONG>&nbsp;Employee : &nbsp;</STRONG></font></td>
			<td Nowrap>
			<%
			qry="select distinct nvl(EMPLOYEEID,' ')Faculty, nvl(EMPLOYEENAME,' ')FacultyName from V#STAFF where employeeid='"+mEID+"' and nvl(deactive,'N')='N'";
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
			<td nowrap><font color=black face=arial size=2><STRONG>&nbsp;Date Of Advance : &nbsp;</STRONG></font></td>
		
			<td nowrap><input Name=DateOfAdv Id=DateOfAdv style="height:22px" Type=text maxlength=10 size=8 value='<%=mAdvDate%>' READONLY>
			</td></tr>

			<tr><td nowrap><font color=black face=arial size=2><STRONG>&nbsp;Advance Type : &nbsp;</STRONG></font></td>
			<td nowrap>
			<%
			qry="select distinct ADVANCETYPE ADVTYPE, APPLICABLETO APPLTO, nvl(ADVANCEDESC,' ')ADVDESC, nvl(DEDUCTIONFROM,'O')DEDFROM, nvl(MINNOOFEMI,0)MINNOEMI, nvl(MAXNOOFEMI,0)MAXNOEMI, nvl(INTERESTRATE,0)INTRATE, nvl(TYPEOFINTEREST,'S')INTTYPE";
			qry=qry+" from PAY#ADVANCETYPEMASTER where COMPANYCODE='"+mComp+"' AND APPLICABLETO='"+mMemType+"' AND ADVANCETYPE='"+mAdvancetype+"'  and nvl(DEACTIVE,'N')='N' ORDER BY ADVDESC";
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
			<td nowrap align=left><b><font face=arial size=2>&nbsp;Advance Amount : &nbsp;</font></b></td>
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
			qry="Select MIN(MINNOOFEMI)MINNOOFEMI, MAX(MAXNOOFEMI)MAXNOOFEMI from PAY#ADVANCETYPEMASTER WHERE COMPANYCODE='"+mComp+"' AND APPLICABLETO='"+mMemType+"' AND nvl(DEACTIVE,'N')='N' GROUP BY COMPANYCODE, APPLICABLETO";
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
			<INPUT id=submit1 style="BACKGROUND-COLOR:TRANSPARENT; FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 50px; HEIGHT: 23px; FONT-VARIANT: normal" type=submit value="OK" name=submit1 title="Click To Check EMI Calculation"></td></tr>
			</table>
			</form>
			<%
			if(request.getParameter("x")!=null)
			{
				if (request.getParameter("Faculty")!=null)
					QryFaculty=request.getParameter("Faculty").toString().trim();
				else
					QryFaculty="";
				if (request.getParameter("DateOfAdv")!=null)
					mAdvDate=request.getParameter("DateOfAdv").toString().trim();
				else
					mAdvDate=CurrDate;
				if (request.getParameter("ADVTYPE")!=null)
				{
					QryAdvanceType=QryAdvType;
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
			
					if(QryAdvAmt>0)
					{
						qry="Select 'Y' from PAY#ADVANCETYPEMASTER Where COMPANYCODE='"+mComp+"' AND ADVANCETYPE='"+QryAdvType+"' AND APPLICABLETO='"+QryApplTo+"'";
						qry=qry+" AND "+QRYNOOFEMI+" BETWEEN "+QryMinEMI+" and "+QryMaxEMI+"";
						rs=db.getRowset(qry);
						if(rs.next())
						{
							%>
							<form name="frm2" method="post">
							<input id="x" name="x" type=hidden>
							<input id="y" name="y" type=hidden>
							<input id="Faculty" name="Faculty" type=hidden value=<%=QryFaculty%>>
							<input id="DateOfAdv" name="DateOfAdv" type=hidden value=<%=mAdvDate%>>
							<input id="NOOFEMI" name="NOOFEMI" type=hidden value=<%=QRYNOOFEMI%>>
							<input id="AdvAmt" name="AdvAmt" type=hidden value=<%=QryAdvAmt%>>
							<input id="ADVTYPE" name="ADVTYPE" type=hidden value=<%=QryAdvanceType%>>
							<%
							//out.print(QryDedFrom+" "+QryMinEMI+" "+QryMaxEMI+" "+QryIntRate+" "+QryIntType+" "+QryAdvType);
							%>
							<table valign=middle border=2 cellpadding=5 cellspacing=0 align=center rules=groups border=0>
							<tr>
							<td nowrap colspan=2>
							<b><font face=arial size=2>Total Amount <font size=1>(Advance+Interest) </font>:&nbsp;</font></b><%=QryTotalVal%>
							<b><font face=arial size=2>&nbsp;Rate Of Interest :&nbsp;</font></b><%=QryIntRate%>% [<%=QryIntType%>] p.a.
							<b><font face=arial size=2>&nbsp;EMI Amount :&nbsp;</font></b><%=QryEMIVal%>
							</td>
							</tr>

							<tr><td nowrap><b><font face=arial size=2>Purpose Of Advance :&nbsp;</font></b></td>
							<td nowrap><TextArea type="text" id="POA" name="POA" maxlength=300 cols=53 rows=2 OnChange="SubmitActive()"></TextArea><FONT color=red>*</FONT></td></tr>

							<tr><td colspan=2 align=center><INPUT id=submit2 style="BACKGROUND-COLOR:TRANSPARENT; FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 70px; HEIGHT: 23px; FONT-VARIANT: normal" type=submit value="Edit" name=submit2 title="Edit Request for Advance" onclick="return ActiveSubmit();"></td></tr>
							</table>
							</form>
							<%
						}
						else
						{
							%><table align=center><tr><td>
							<b><font size=2 face='Arial' color='RED'>For selected Advance Type, the permissible 'No of EMIs' should be between <%=QryMinEMI%> and <%=QryMaxEMI%>...</font></b>
							</td></tr></table><%
						}
					}
					else if(errFlag==0)
					{
						%><table align=center><tr><td>
						<b><font size=2 face='Arial' color='RED'>Advance Amount must be greater than zero ('0')!</font></b>
						</td></tr></table><%
					}
			
			}
			if(errFlag>0)
			{
				%><table align=center><tr><td>
				<b><font size=2 face='Arial' color='RED'>'Advance Amount' must be Numeric and Greater than zero ('0')!</font></b>
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
					qry="select EmployeeName from EmployeeMaster where EmployeeID='"+mEID+"'";
					rs=db.getRowset(qry);
					if(rs.next())
					{
						mEname=rs.getString(1);
					}
						qry="UPDATE PAY#EMPOTHERADVANCEREQUEST SET  INSTITUTECODE='"+mInst+"',  ADVANCEAMOUNT='"+QryAdvAmt+"', INSTALLMENT='Y', NOOFINSTALLMENT='"+QryNOOFEMI+"', INTERESTAMOUNT='"+QryTotalIntAmt+"', DEDUCTEDAMOUNT='"+QryEMIVal+"', REQUESTREMARKS='"+QryPOA+"', REQUESTBY='"+mEID+"', REQUESTDATE=sysdate, WORKFLOWCODE='ADVANCE', WORKFLOWTYPE= '"+QryAdvType+"', STATUS='D' WHERE REQUESTID='"+mRID+"' and  MEMBERID='"+mEID+"' and COMPANYCODE='"+mComp+"' and ADVANCETYPE='"+QryAdvType+"' and MEMBERTYPE='"+mMemType+"' ";
						//out.print(qry);
						n=db.update(qry);
						if(n>0)
						{
							
							// Log Entry
							//-----------------
							db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType," EDIT ADVANCE LEAVE REQUEST ", "Staff:"+mEname+" EmployeeID:"+mEID,"NO MAC ADDRESS ", mIPAddress);
							//-----------------
								%>
								<table align=center><tr><td align=center>
								<b><font size=2 face='Arial' color='Green'>Your Advance Leave "<%=mAdvDesc%>" is Edited  Successfully...</font></b>
								</td></tr>
								<tr><td align=center>
								<a Title='Do You Want to Edit More Leaves' href='AdvanceRequestEdit.jsp'>
								<font size=2 face='Arial' color='Green'><b>Click To Edit More Leaves </b></font></a>
								</td></tr>
								</table>
								<%
							
						}
						else
						{
							%><table align=center><tr><td>
							<b><font size=2 face='Arial' color='RED'>Error while advance request Edit!</font></b>
							</td></tr></table><%
						}
										
				}
				else
				{
					%><table align=center><tr><td>
					<b><font size=2 face='Arial' color='RED'>Purpose of Advance Request can't be left blank!</font></b>
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
			<h3>	<br><img src='../../../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
			<P>	This page is not authorized/available for you.
			<br>For assistance, contact your network support team. 
			</font>	<br>	<br>	<br>	<br> 
			<%
		}
		//-----------------------------
	}
	else
	{
		out.print("<br><img src='../../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}
}
catch(Exception e)
{
}
%>
</body>
</html>