<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null,rs1=null,rss=null,rse=null,rsv=null;
GlobalFunctions gb =new GlobalFunctions();
int mSno=0 ;
String qry="",qry1="",qrys="",qrye="",qryv="";
String mComp="",TRCOLOR="White";
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInst="",mRightID="169";
String mRightsID="",QryRights="",mEventFrom="",mEventTo="",mCurDate="",mMessFrom="";
String mMessTo="",mMarquee="",mStaff="",mNextDate="",mRightsInfo="",mRelated="";
String mEmployee="",mStudent="";

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
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}

if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Rights ID] </TITLE>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<SCRIPT LANGUAGE="JavaScript"> 
function ChangeOnLeaveStatus()
{
	document.frm1.action="PageWiseMessageEntry.jsp";
	document.frm1.submit();
	return true;
}
function Validate()
{
	if(document.frm1.Marquee.value.length==0)
		{
			alert("Please Enter The Marquee Message !");
			document.frm1.Marquee.value="";
			frm1.Marquee.focus();
			return false;
		}
	if((document.frm1.Student.checked==false) && (document.frm1.Employee.checked==false) &&
		(document.frm1.Staff.checked==false))
		{
			alert("Please Select Any of The Check Boxes !");
			frm1.Student.focus();
			return false;
		}
}
</SCRIPT>

</head>
<body aLink=#ff00ff bgcolor='#fce9c5' rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
try
{
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
		qry="Select WEBKIOSK.ShowLink('"+mRightID+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
	  //----------------------
		qry="select to_Char(Sysdate,'dd-mm-yyyy')date1 ,to_Char(Sysdate+1,'dd-mm-yyyy')date2  from dual";
		rs=db.getRowset(qry);
		rs.next();
		mCurDate=rs.getString("date1");
		mNextDate=rs.getString("date2");

	%>
	<form name=frm method=POST>
	<input id="x" name="x" type=hidden>
	<table id=id1 width=851 ALIGN=CENTER  topmargin=0 cellspacing=0 cellpadding=0>

<!-------------Page Heading and Marquee Message----------------------->
<%
try
{
	String mPageHeader="Page Wise Message", mMarqMsg="", CurrDate="";
	qry="Select to_char(sysdate,'dd-mm-yyyy')CurrDate from dual";
	rs=db.getRowset(qry);
	if(rs.next())
	{
		CurrDate=rs.getString("CurrDate");
	}
	qry="Select nvl(A.MARQUEEMESSAGE,' ')MarqMsg FROM PAGEBASEDMEESSAGES A WHERE A.RIGHTSID='"+mRightID+"' and A.RELATEDTO LIKE '%E%' and to_date('"+CurrDate+"','dd-mm-yyyy') between MESSAGEFLASHFROMDATETIME and MESSAGEFLASHUPTODATETIME and nvl(DEACTIVE,'N')='N'";
	rs=db.getRowset(qry);
	//out.print(qry);
	if(rs.next())
	{
		mMarqMsg=rs.getString("MarqMsg");
		%>
		<tr><td width=100% bgcolor="#A53403" style="FONT-WEIGHT:bold; FONT-SIZE:smaller; WIDTH:100%; HEIGHT:15px; FONT-VARIANT:small-cap; filter:progid:DXImageTransform.Microsoft.Gradient(startColorStr='Orange', endColorStr='#A53403', gradientType='0'"><marquee behavior="" scrolldelay=100 width=100%><font color="white" face=arial size=2><STRONG><%=mMarqMsg%></STRONG></font></marquee></b></td><tr>
		<%
	}
	qry="Select nvl(B.PAGEHEADER,'"+mPageHeader+"')PageHeader FROM WEBKIOSKRIGHTSMASTER B WHERE B.RIGHTSID='"+mRightID+"' and B.RELATEDTO LIKE '%E%'";
	rs=db.getRowset(qry);
	//out.print(qry);
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

	</table>
	<table cellpadding=3 cellspacing=0  align=center rules=groups  border=1>
	<!--**Rights Description**-->
	<tr><td align=center nowrap><font color=black face=arial size=2><STRONG>Rights :</STRONG>
	<%
	qry="select  nvl(RIGHTSID,0)RIGHTS,nvl(RIGHTSINFO,' ')RIGHTSINFO from WEBKIOSKRIGHTSMASTER where NVL(DEACTIVE,'N')='N' order by RIGHTSID";	
	rs=db.getRowset(qry);
	%>
	<select id="Rights" name="Rights"  tabindex=0>
	<%
	if(request.getParameter("x")==null)
		{
		while(rs.next())
			{
			mRightsID=rs.getString("RIGHTS");
				mRightsInfo=rs.getString("RIGHTSINFO");
			if(QryRights.equals(""))
				{
				QryRights=mRightsID;
				}
				%>
				<option value=<%=mRightsID%>><%=mRightsInfo%>&nbsp;&nbsp;(<%=mRightsID%>)</option>
				<%
			}
		}
	else
		{
		 while(rs.next())
			{
			 mRightsID=rs.getString("RIGHTS");
				mRightsInfo=rs.getString("RIGHTSINFO");
				
				if(mRightsID.equals(request.getParameter("Rights").toString().trim()))
					{
						%>
						<option selected value=<%=mRightsID%>><%=mRightsInfo%>&nbsp;&nbsp;(<%=mRightsID%>)</option>
						<%
					}
				else
					{
						%>
						<option  value=<%=mRightsID%>><%=mRightsInfo%>&nbsp;&nbsp;(<%=mRightsID%>)</option>
						<%
					}
			}
		}
	%>
	</select>
		<INPUT id=submit  style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 55px; HEIGHT: 23px; FONT-VARIANT: normal" type=submit size=5 value="OK" name=submit tabindex=1 title="Click OK to See Detail">
	</td>
	</table>
	</form>
<%	
if (request.getParameter("x")!=null)
{
	if(request.getParameter("Rights")==null)
			QryRights="";
			else
			QryRights=request.getParameter("Rights").toString().trim();
			
	if(request.getParameter("Marquee")==null)
			mMarquee="";
			else
			mMarquee=request.getParameter("Marquee").toString().trim();
	
	if(request.getParameter("EventFrom")==null)
			mEventFrom=mCurDate;	
			else
			mEventFrom=request.getParameter("EventFrom").toString().trim();
	
	if(request.getParameter("EventTo")==null)
			mEventTo=mNextDate;
			else
			mEventTo=request.getParameter("EventTo").toString().trim();

	if(request.getParameter("MessFrom")==null)
			mMessFrom=mCurDate;
			else
			mMessFrom=request.getParameter("MessFrom").toString().trim();

	if(request.getParameter("MessTo")==null)
			mMessTo=mNextDate;
			else
			mMessTo=request.getParameter("MessTo").toString().trim();

	if(request.getParameter("Staff")==null)
			mStaff="";
			else
			mStaff=request.getParameter("Staff").toString().trim();				

	if(request.getParameter("Employee")==null)
			mEmployee="";
			else
			mEmployee=request.getParameter("Employee").toString().trim();				
	if(request.getParameter("Student")==null)
			mStudent="";	
			else
			mStudent=request.getParameter("Student").toString().trim();						

	qry="select NVL(RIGHTSID,0)RIGHTS,NVL(MARQUEEMESSAGE,' ')MARQUEE,nvl(to_char(EVENTFROMDATETIME,'dd-mm-yyyy'),' ')EVENTFROM, nvl(to_char(EVENTTODATETIME,'dd-mm-yyyy'),' ')EVENTTO, nvl(to_char(MESSAGEFLASHFROMDATETIME,'dd-mm-yyyy'),' ')MESSFROM,nvl(to_char(MESSAGEFLASHUPTODATETIME,'dd-mm-yyyy'),' ')MESSTO FROM PAGEBASEDMEESSAGES WHERE RIGHTSID='"+QryRights+"' ";
	//out.print(qry);
	rs=db.getRowset(qry);
	if(rs.next())
	{
		mMarquee=rs.getString("MARQUEE");
		mEventFrom=rs.getString("EVENTFROM");
		mEventTo=rs.getString("EVENTTO");
		mMessFrom=rs.getString("MESSFROM");
		mMessTo=rs.getString("MESSTO");
	}
	%>
	<form name="frm1" method="post" action="PageWiseMessageAction.jsp">
	<input id="Rights" name="Rights" type=hidden value=<%=QryRights%>>
	<table cellspacing=0 cellpadding=3 align=center rules=groups border=1>
	<tr><td nowrap>
		<font size=2 face='Arial' color=black><b>Marquee Message </b>
	</td>
		 <td>
			<textarea rows="2" cols="60" style="width:500px" name="Marquee" id="Marquee"  tabindex=2 ><%=gb.replaceSignleQuot(mMarquee)%></textarea>
		 </td>
	</tr>

	<tr><td>
		<font size=2 face='Arial' color=black><b>Event From</b>
	</td>
		<td>
		<input type=text name="EventFrom" id="EventFrom" size=9 tabindex=3 value='<%=mEventFrom%>' 
		onTextChange="ChangeOnLeaveStatus()" READONLY><a href="javascript:NewCal('EventFrom','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>
		<b>&nbsp;&nbsp;to&nbsp;&nbsp;</b>
		<INPUT TYPE="text" NAME="EventTo" ID="EventTo" size=9 tabindex=4
		VALUE='<%=mEventTo%>'onTextChange="ChangeOnLeaveStatus()" READONLY><a href="javascript:NewCal('EventTo','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>&nbsp;
		</td>
	</tr>

	<tr><td>
		<font size=2 face='Arial' color=black ><b>Marquee Message View By</b>
	</td><td>
	<%
	qry="select 'Y' from PAGEBASEDMEESSAGES where RIGHTSID='"+QryRights+"' ";
	rs=db.getRowset(qry);	
	if(rs.next())
	{
		qrys=" SELECT 'Y' FROM PAGEBASEDMEESSAGES B where B.RELATEDTO LIKE '%S%' AND B.RIGHTSID='"+QryRights+"' ";
		rss=db.getRowset(qrys);
		if(rss.next())
		{	
			%>		
			<input type="checkbox"  checked name="Student" id="Student" value="S" size=3 tabindex=5>
			<font size=2 face='Arial' color=black ><b>Student&nbsp;&nbsp;</b></font>
			<%
		}
		else
		{
			%>		
			<input type="checkbox"  name="Student" id="Student" value="S" size=3 tabindex=5>
			<font size=2 face='Arial' color=black ><b>Student&nbsp;&nbsp;</b></font>
			<%
		}
		qrye=" SELECT 'Y' FROM PAGEBASEDMEESSAGES B where B.RELATEDTO LIKE '%E%' AND B.RIGHTSID='"+QryRights+"' ";
		rse=db.getRowset(qrye);
		if(rse.next())
		{	
			%>	
			<input type="checkbox" checked  name="Employee" id="Employee" value="E" size=3 tabindex=6>	<font size=2 face='Arial' color=black ><b>Employee&nbsp;&nbsp;</b></font>	
			<%
		}
		else
		{
			%>	
			<input type="checkbox"   name="Employee" id="Employee" value="E" size=3 tabindex=6>	<font size=2 face='Arial' color=black ><b>Employee&nbsp;&nbsp;</b></font>	
			<%
		}
		qryv=" SELECT 'Y' FROM PAGEBASEDMEESSAGES B where B.RELATEDTO LIKE '%V%' AND B.RIGHTSID='"+QryRights+"' ";
		rsv=db.getRowset(qryv);
		if(rsv.next())
		{	
			%>
			<input type="checkbox"  name="Staff" checked id="Staff" value="V" size=3 tabindex=7>
			<font size=2 face='Arial' color=black><b>Visiting Staff&nbsp;&nbsp;</b>
			</font>
			<%
		}
		else
		{
			%>
			<input type="checkbox"  name="Staff" id="Staff" value="V" size=3 tabindex=7>
			<font size=2 face='Arial' color=black><b>Visiting Staff&nbsp;&nbsp;</b>
			</font>
			<%
		}
	}//END OF RS
else 
	{
		qrys=" SELECT 'Y' FROM WEBKIOSKRIGHTSMASTER B where B.RELATEDTO LIKE '%S%' AND B.RIGHTSID='"+QryRights+"' ";
		//out.print(qrys);
		rss=db.getRowset(qrys);
		if(rss.next())
		{	
			%>		
			<input type="checkbox"  checked name="Student" id="Student" value="S" size=3 tabindex=5>
			<font size=2 face='Arial' color=black ><b>Student&nbsp;&nbsp;</b></font>
			<%
		}
		else
		{
			%>		
			<input type="checkbox"  name="Student" id="Student" value="S" size=3 tabindex=5>
			<font size=2 face='Arial' color=black ><b>Student&nbsp;&nbsp;</b></font>
			<%
		}
		qrye=" SELECT 'Y' FROM WEBKIOSKRIGHTSMASTER B where B.RELATEDTO LIKE '%E%' AND B.RIGHTSID='"+QryRights+"' ";
		//out.print(qrye);
		rse=db.getRowset(qrye);
		if(rse.next())
		{	
			%>	
			<input type="checkbox" checked  name="Employee" id="Employee" value="E" size=3 tabindex=6>	<font size=2 face='Arial' color=black ><b>Employee&nbsp;&nbsp;</b></font>	
			<%
		}
		else
		{
			%>	
			<input type="checkbox"   name="Employee" id="Employee" value="E" size=3 tabindex=6>
			<font size=2 face='Arial' color=black ><b>Employee&nbsp;&nbsp;</b></font>	
			<%
		}
		qryv=" SELECT 'Y' FROM WEBKIOSKRIGHTSMASTER B where B.RELATEDTO LIKE '%V%' AND B.RIGHTSID='"+QryRights+"' ";
		rsv=db.getRowset(qryv);
		if(rsv.next())
		{	
			%>
			<input type="checkbox"  name="Staff" checked id="Staff" value="V" size=3 tabindex=7>
			<font size=2 face='Arial' color=black><b>Visiting Staff&nbsp;&nbsp;</b>
			</font>
			<%
		}
		else
		{
			%>
			<input type="checkbox"  name="Staff" id="Staff" value="V" size=3 tabindex=7>
			<font size=2 face='Arial' color=black><b>Visiting Staff&nbsp;&nbsp;</b>
			</font>
			<%
		}
	}
	%>
		</td>	
		</tr>
<tr><td nowrap>
	   <font size=2 face='Arial' color=black><b>Message Flash From</b>
    </td>
	<td>
		<input type=text name="MessFrom" id="MessFrom" size=9 tabindex=8 value='<%=mMessFrom%>' 
		onTextChange="ChangeOnLeaveStatus()" READONLY><a href="javascript:NewCal('MessFrom','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>
		<b>&nbsp;&nbsp;to&nbsp;&nbsp;</b>
		<INPUT TYPE="text" NAME="MessTo" ID="MessTo" size=9 tabindex=9
		VALUE='<%=mMessTo%>'onTextChange="ChangeOnLeaveStatus()" READONLY><a href="javascript:NewCal('MessTo','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>&nbsp;
	</td>
</tr>
<tr>
	<td nowrap colspan=2 align=center>
		<INPUT id=submit tabindex=10 style=" BACKground-COLOR:Transparent; FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 55px; HEIGHT: 23px; FONT-VARIANT: normal" type=submit size=5 value="Save" name=submit title="Click to Save Rights Description " onClick="return Validate();">
	</td></tr>
</table>

	<table  width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B><u>Available Message List</u> </B></TD>
	</font></td>	
	</table>
	<table class="sort-table" id="table-1" border=1 leftmargin=0 cellpadding=0	cellspacing=0 align=center width="100%">
				<thead>
				<tr bgcolor="#ff8c00">
				<td align=left rowspan=2 nowrap><font color=white><B>RightsID</B></font></td>
				<td align=center rowspan=2 nowrap><font color=white><B>RightsInfo</B></font></td>
				<td align=center rowspan=2 nowrap><font color=white><B>Marquee  Message</B></font></td>
				<td align=center rowspan=2 nowrap><font color=white><B>Related To</B></font></td>
				<td align=center nowrap colspan=2><font color=white><B>Event Period </B></font></td>
				<td align=center colspan=2 nowrap><font color=white><B>Message Flash <br>Duration</B></font></td>
				</tr>
				<tr bgcolor="#ff8c00">
				<td align=center nowrap><font color=white><B>Event From</B></font></td>
				<td align=center nowrap><font color=white><B>Event To</B></font></td>
				<td align=center nowrap><font color=white><B>Msg from</B></font></td>
				<td align=center nowrap><font color=white><B>Msg To</B></font></td>
				</tr>
				</thead>
				<tbody>
			<%
			qry="SELECT nvl(A.RIGHTSID,0)RIGHTS,nvl(B.RIGHTSINFO,' ')RIGHTSINFO,NVL(A.MARQUEEMESSAGE,' ')MARQUEE, NVL(A.RELATEDTO,' ')RELATEDTO, nvl(to_char(A.EVENTFROMDATETIME,'dd-mm-yyyy'),' ')EVENTFROM, nvl(to_char(A.EVENTTODATETIME,'dd-mm-yyyy'),' ')EVENTTO, nvl(to_char(A.MESSAGEFLASHFROMDATETIME,'dd-mm-yyyy'),' ')MESSFROM,nvl(to_char(A.MESSAGEFLASHUPTODATETIME,'dd-mm-yyyy'),' ')MESSTO FROM PAGEBASEDMEESSAGES A,WEBKIOSKRIGHTSMASTER B where A.RIGHTSID=B.RIGHTSID order by A.RIGHTSID";
			//out.print(qry);
			rs=db.getRowset(qry);
			String mMarqueeMsg="";
			int SrNo=0;
			String mColor="";
			while(rs.next())
			{
				SrNo++;
				if(SrNo%2==0)
					mColor="white";
				else if(SrNo%2==1)
					mColor="#F1F1F1";
				else
					mColor="";
				mMarqueeMsg=rs.getString("MARQUEE");
				if(mMarqueeMsg.length()>15)
					mMarqueeMsg=mMarqueeMsg.substring(0,15)+"....";
		
			    %>
				<tr bgcolor="<%=mColor%>">
				<td nowrap align=right><%=rs.getString("RIGHTS")%> &nbsp; &nbsp; &nbsp; &nbsp;</td>
				<td nowrap align=left>&nbsp;<%=rs.getString("RIGHTSINFO")%></td>	
				<td nowrap align=left>&nbsp;<a Title="Click To View Message Details '<%=rs.getString("MARQUEE")%>' " target=New_ href='PageWiseMessageDetail.jsp?RIGHTSID=<%=rs.getString("RIGHTS")%>'><font color=blue><%=mMarqueeMsg%></font></a></td>
				<td nowrap align=center>&nbsp;<%=rs.getString("RELATEDTO")%></td>	
				<td nowrap align=center>&nbsp;<%=rs.getString("EVENTFROM")%></td>
				<td nowrap align=center>&nbsp;<%=rs.getString("EVENTTO")%></td>
				<td nowrap align=center>&nbsp;<%=rs.getString("MESSFROM")%></td>
				<td nowrap align=center>&nbsp;<%=rs.getString("MESSTO")%></td>
				</tr>
			<%
			}
			%>
			</tbody>
			</table>
			<script type="text/javascript">
			var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString"]);
			</script>
			</form>
	<%	
	}//end of If X
//-----------------------------
//---Enable Security Page Level  
//-----------------------------
}
else
{
   %>
	<br>
	<font color=red>
	<h3><br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
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
	//out.print("Exception "+e);
}
%>

</body>
</html>