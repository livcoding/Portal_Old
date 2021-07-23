<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../CommonFiles/ExceptionHandler.jsp" %> 
<%
String x="",y="";
GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
ResultSet rs=null,rsec=null,rss=null,rsi=null,rsc=null,rs11=null,rs1=null;
String qry="", qry1="";
String mComp="", mInst="",mAcad="",mFacultyID="",mFaculty="",mfaculty="",mSubhead="",mEid="";
String mMemberID="";
String mMemberType="";
String mMemberCode="",LTP="";
String mDMemberCode="",mDMemberID="";
String mMemberName="",mDMemberType="";
String mWebEmail="",MType="";
String mSrsevent="",mcolor="",mTType="",msrs="",mtype="";

String mSRSCont="",mDate1="",mDate2="",mEventCode="",mEmployee="";

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
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
   mHead=session.getAttribute("PageHeading").toString().trim();
else
   mHead="JIIT ";

qry="select to_Char(Sysdate,'dd-mm-yyyy') date1, to_Char((Sysdate-6),'dd-mm-yyyy') date2 from dual";
rs=db.getRowset(qry);
rs.next();
String mCurrDate=rs.getString("date1");
String mPrevDate=rs.getString("date2");
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [View Transaction Log Information ] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />


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
	// mDMemberType=enc.decode(mMemberType);

	String mLogEntryMemberID="",mLogEntryMemberType="";

	if (session.getAttribute("BASELOGINID")==null || session.getAttribute("BASELOGINID").toString().trim().equals(""))
		mLogEntryMemberID="";
	else
		mLogEntryMemberID=session.getAttribute("BASELOGINID").toString().trim();

	if (session.getAttribute("BASELOGINTYPE")==null || session.getAttribute("BASELOGINTYPE").toString().trim().equals(""))
		mLogEntryMemberType="";
	else
		mLogEntryMemberType=session.getAttribute("BASELOGINTYPE").toString().trim();

	if (session.getAttribute("BASEINSTITUTECODE")==null)
		mInst="JIIT";
	else
		mInst=session.getAttribute("BASEINSTITUTECODE").toString().trim();

	qry="Select nvl(COMPANYTAGGING,'UNIV')COMP from InstituteMaster where InstituteCode='"+ mInst +"' And nvl(Deactive,'N')='N'";
	rs=db.getRowset(qry);
	if(rs.next())
	{
		mComp=rs.getString("COMP");
	}

	if (!mLogEntryMemberType.equals(""))
		mLogEntryMemberType=enc.decode(mLogEntryMemberType);

	if (!mLogEntryMemberID.equals(""))
		mLogEntryMemberID=enc.decode(mLogEntryMemberID);

 
//--------------------------------------
	String mIPAddress=session.getAttribute("IPADD").toString().trim();
	String mLoginIDFrSes="";
if(mInst.equals("JIIT"))
	mLoginIDFrSes="asklJIITADMINaskl";
else if(mInst.equals("JPBS"))
	mLoginIDFrSes="asklJPBSADMINaskl";
else if	(mInst.equals("J128"))
	mLoginIDFrSes="asklJ128ADMINaskl";
else
	mLoginIDFrSes="asklADMINaskl";
//out.print(mLogEntryMemberID+" - "+mLoginIDFrSes);
	if(mLogEntryMemberID.equals(mLoginIDFrSes) && mLogEntryMemberType.equals("A")) 

	{
	//mDMemberCode=enc.decode(mMemberCode);
	//mDMemberID=enc.decode(mMemberID);

	%>
	<form name="frm"  method="get" >
	<input id="x" name="x" type=hidden>
	<table  ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>View Log Information</B></font></td></tr>
	</TABLE>
	<table align=center bottommargin=0 rules=groups topmargin=0,cellspacing=0 cellpadding=0>
<!--Institute-->
	<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
	<tr><td><FONT face=Arial size=2><STRONG>&nbsp;&nbsp;Transaction Type</STRONG>&nbsp;&nbsp;&nbsp;</FONT>
	<%

	qry="select distinct TRANSTYPE from LOGTRANSINFO Where nvl(InstituteCode,'JIIT')='"+mInst+"' order by transtype asc "; 
	rsec=db.getRowset(qry);
//	out.print(qry);
%>
	<select name="transinfo" tabindex="0" id="transinfo" style="WIDTH: 380px">
<%   	
  	if(request.getParameter("x")==null)
	{
	
	while(rsec.next())
		{
		msrs=rsec.getString("TRANSTYPE");
	%>
		<option  value='<%=msrs%>'><%=msrs%></option>
	<%		
		}
	 }
	else
	{
	  while(rsec.next())
	   {
		msrs=rsec.getString("TRANSTYPE");
	   if(msrs.equals(request.getParameter("transinfo").toString().trim()))
	    {	
	  %>
	    <option selected value='<%=msrs%>'><%=msrs%></option>
	  <%
	     }	
         else
          {		
	   %>
	    <option  value='<%=msrs%>'><%=msrs%></option>
	   <%
	    }	
	   }
       }
    %>
</select>

	<%
	if (request.getParameter("x")!=null)
	{
		mDate1=request.getParameter("TXT1").toString().trim();
		mDate2=request.getParameter("TXT2").toString().trim();
	}
	else
	{
		mDate1=mPrevDate;
		mDate2=mCurrDate;
	}
	%>
	<tr><TD colspan=3><b>&nbsp; Transaction For the Period :<input Name=TXT1 Id=TXT1 Type=text maxlength=10 size=10 value='<%=mDate1%>'> to <input Name=TXT2 Name=TXT2 Type=text Value='<%=mDate2%>' maxlength=10 size=10></b>
	<INPUT Type="submit" Value="Show/Refresh"></td></tr></table></form>
	<table class="sort-table" id="table-1" align=center bottommargin=0 rules=groups topmargin=0 cellspacing=1 cellpadding=0 border=1 >
	<thead>
	 <tr bgcolor="#ff8c00" >
	  <td align=left Title="Click here to sort Table Data on Sr.No."><b><font color=white>SNo</font></b></td>
	  <td align=center nowrap Title="Click here to sort Table Data on Member Name"><b><font color=white>Member Name<br>(Login ID)</font></b></td>
	  <td align=center nowrap Title="Click here to sort Table Data on Department"><b><font color=white>Date & Time</font></b></td>
	  <td align=center nowrap><b><font color=white>IP Address</font></b></td>
	  <td align=center nowrap><b><font color="white">Transaction Detail</font></b></td>
	 </tr>
	</thead>
	<tbody>
	<%
	if(request.getParameter("x")!=null)
	{
		if (request.getParameter("TXT1")==null || request.getParameter("TXT1").equals(""))
		  mDate1="**";
		else
		  mDate1=request.getParameter("TXT1").toString().trim();
	
		if (request.getParameter("TXT2")==null || request.getParameter("TXT2").equals(""))
		  mDate2="**";
		else
		  mDate2=request.getParameter("TXT2").toString().trim();
	
		mTType=request.getParameter("transinfo").toString().trim();
		if ((mDate1.equals("**") || GlobalFunctions.iSValidDate(mDate1)==true )&& (mDate2.equals("**") || GlobalFunctions.iSValidDate(mDate2)))
		{	
			qry="Select Distinct nvl(MEMBERID,' ') MEMBERID, nvl(MemberType,' ')membertype ,to_char(TRANSDATETIME,'dd-mm-yyyy hh:mi PM')TRANSDATETIME,nvl(IPADDRESS,' ')IPADDRESS,nvl(TRANSDETAIL,' ')TRANSDETAIL";
			qry=qry+" from LOGTRANSINFO where nvl(InstituteCode,'JIIT')='"+mInst+"' and transtype='"+mTType+"'";
			qry=qry+" and trunc(TRANSDATETIME) between decode('"+mDate1+"','**',trunc(TRANSDATETIME),to_Date('"+mDate1+"','dd-mm-yyyy')) and decode('"+mDate2+"','**',trunc(TRANSDATETIME),to_Date('"+mDate2+"','dd-mm-yyyy')) order by membertype desc";
			rs1=db.getRowset(qry);	
 			int Ctr=0;
			while(rs1.next())
			{
				Ctr++;
				mtype=rs1.getString("membertype");
				mEid=rs1.getString("MEMBERID");
				%>
				<tr>
				<%
				if(mtype.equals("E"))	
				{
					qry1="select nvl(employeename,' ')employeename, nvl(employeecode,' ')employeecode from V#staff where employeeid='"+mEid+"'";
					//out.print(qry1);
					rs11=db.getRowset(qry1);
					if(rs11.next())
					{
						%>
						 <td><%=Ctr%>.</td>
						 <td nowrap><%=rs11.getString("employeename")%>&nbsp;(<%=rs11.getString("employeecode")%>)</td>
						<%
					}
					else
					{
						%>
						 <td><%=Ctr%>.</td>
						 <td nowrap>&nbsp;</td>
						<%
					}
				}
				else if(mtype.equals("S"))	
				{
					qry1="select nvl(studentname,' ')studentname ,nvl(enrollmentno,' ')enrollmentno from studentmaster where studentid='"+mEid+"' ";
					rs11=db.getRowset(qry1);
					//out.print(qry1);
					if(rs11.next())
					{
						%>
						 <td><%=Ctr%>.</td>
						 <td nowrap><%=rs11.getString("studentname")%>&nbsp;(<%=rs11.getString("enrollmentno")%>)</td>
						<%
					}
					else
					{
						%>
						 <td><%=Ctr%>.</td>
						 <td nowrap>&nbsp;</td>
						<%
					}
				}
				else
				{
					%>
					<tr>
					 <td><%=Ctr%>.</td>
					 <td nowrap>ADMIN</td>
					<%
				}
				%>
				 <td nowrap><%=rs1.getString("TRANSDATETIME")%></td>
				 <td nowrap><%=rs1.getString("IPADDRESS")%></td>	
		     		 <td><%=rs1.getString("TRANSDETAIL")%></td>	
				</tr>		
				<%
			} // closing of while	
			%>
			</tbody>
			</table>
			<script type="text/javascript">
			  var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString","CaseInsensitiveString","Number","Date"]);
			</script>
			<%	
		}	// Validate Date
		else
		{
			out.print("<br><img src='../../Images/Error1.jpg'>");
			out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Valid Date Format is DD-MM-YYYY only</font> <br>");
		}
	}  //*************** closing of (request.getParameter("x")!=null)

} // closing of session
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
}
}
catch(Exception e)
{
}      
%>
</body>
</html>
