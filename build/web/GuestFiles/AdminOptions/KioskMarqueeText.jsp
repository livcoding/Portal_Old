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
<TITLE>#### <%=mHead%> [ Change Marquee Message Text] </TITLE>

<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
</script>
<script language=javascript>
	<!--
	function RefreshContents()
	{ 	
    	    document.frm.x.value='ddd';
    	    document.frm.submit();
	}
//-->
</script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
ResultSet rs=null;
ResultSet rs1=null;
String qry="",qry1="",mWebEmail="";
String myLTP="",mChkvalue="", mInst="";
long mTPNO=0;
String mMemberID="";
String mMemberType="";
String mMemberCode="";
String mDMemberCode="",x="";
String mMemberName="",mMType="",MType="",mtype="",men="",mec="",Mtype="";
String mDate1="", mPrevDate="";
String mDate2="", mCurrDate="";
String mCurDate1="", mMTextLevel="", mMText="";
String mActive="", mAct="";
qry="select to_Char((Sysdate+7),'DD-MM-YYYY') date1, to_Char((Sysdate-6),'DD-MM-YYYY') date2 from dual";
rs=db.getRowset(qry);
rs.next();
mCurrDate=rs.getString("date1");
mPrevDate=rs.getString("date2");

if (session.getAttribute("WebAdminEmail")==null)
{
	mWebEmail="";
}
else
{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
}

if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
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

OLTEncryption enc=new OLTEncryption();

try
{
if(!mMemberID.equals("") && !mMemberType.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
{
	mDMemberCode=enc.decode(mMemberCode);
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('101','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
  //----------------------
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
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<table width="100%" ALIGN=CENTER bottommargin=0 topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Change Webkiosk Marquee Message</b></font></td></tr>
</table>
<table cellpadding=5 align=center rules=groups border=2 style="WIDTH:100%; HEIGHT: 50px">
<tr>
<!--******MemberType**********-->
<td nowrap colspan=0 align=left><FONT color=black><FONT face=Arial size=2><STRONG>Applicable For</STRONG></FONT></FONT>
	<select name=MemberType tabindex="0" id="MemberType" style="WIDTH: 120px">	
	<%
	if(request.getParameter("MemberType")==null)
	{
		mMType="A";
	%>
		<option value="A" Selected>ALL</option>		
		<option value="E">Employee</option>
		<option value="G">Guest</option>		
		<option value="S">Student</option>
		<option value="V">Visitor</option>		
	<%
	}
	else
	{
		if(request.getParameter("MemberType").toString().trim().equals("A"))
		{
			mMType="A";
		%>
			<option value="A" Selected>ALL</option>
		<%
		}
		else
		{
		%>
			<option value="A">ALL</option>
		<%
		}	
		if(request.getParameter("MemberType").toString().trim().equals("S"))
		{
		%>
			<option value="S">Student</option>
		<%
		}
		else
		{
		%>
			<option value="S">Student</option>
		<%
		}	
		if(request.getParameter("MemberType").toString().trim().equals("E"))
		{
		%>
			<option value="E" Selected>Employee</option>
		<%
		}
		else
		{
		%>
			<option value="E">Employee</option>
		<%
		}
		if(request.getParameter("MemberType").toString().trim().equals("G"))
		{
		%>
			<option value="G" Selected>Guest</option>
		<%
		}
		else
		{
		%>
			<option value="G">Guest</option>
		<%
		}	
		if(request.getParameter("MemberType").toString().trim().equals("V"))
		{
		%>
			<option value="V" Selected>Visitor</option>
		<%
		}
		else
		{
		%>
			<option value="V">Visitor</option>
		<%
		}
	}
	%>
 	</select>
	<%
	if (request.getParameter("x")!=null)
	{	
		mDate1=request.getParameter("TXT1").toString().trim();
		mDate2=request.getParameter("TXT2").toString().trim();
		mMText=request.getParameter("MarqueeText").toString().trim();	
		mMText=gb.replaceSignleQuot(mMText);
		mMTextLevel=request.getParameter("MarqueeTextPriority").toString().trim();	
	}
	else
	{
		mDate1=mPrevDate;
		mDate2=mCurrDate;
		mMText="";
		mMTextLevel="";
	}
%>
<font color=black face=arial size=2>&nbsp;&nbsp;&nbsp;<STRONG>Display From</font><font face=arialblack size=2 color=Green>&nbsp;&nbsp;(DD-MM-YYYY)&nbsp;&nbsp;&nbsp;</font></STRONG></font>&nbsp;<input Name=TXT1 Id=TXT1 Type=text maxlength=10 size=10 value='<%=mDate1%>'> <font color=black face=arial size=2>&nbsp;&nbsp;<STRONG>To</STRONG>&nbsp;&nbsp;</font> <input Name=TXT2 Name=TXT2 Type=text Value='<%=mDate2%>' maxlength=10 size=10></td></tr>

<tr><td nowrap><FONT color=black face=Arial size=2><STRONG>Message Text</STRONG></FONT>&nbsp;<INPUT ID="MarqueeText" Name="MarqueeText" style="WIDTH: 57%;" maxLength=100 value=<%=mMText%>>
<FONT color=black face=Arial size=2><STRONG>Priority</STRONG></FONT>&nbsp;<INPUT ID="MarqueeTextPriority" Name="MarqueeTextPriority" style="WIDTH: 20px;" maxLength=2 value=<%=mMTextLevel%>>
<INPUT id=submit1 style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 102px; HEIGHT: 23px; FONT-VARIANT: normal" type=submit size=5 value="Save/Refresh" name=submit1></td></tr></form>
</TABLE>
<!*********--Institute--************>
<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
<%
	if(request.getParameter("x")!=null)
	{
		if(request.getParameter("MemberType")==null)
		{
			mMType="";
		}
		else
		{
			mMType=request.getParameter("MemberType").toString().trim();	
		}

		if (request.getParameter("TXT1")==null || request.getParameter("TXT1").equals(""))
			mDate1="";
		else
			mDate1=request.getParameter("TXT1").toString().trim();

		if (request.getParameter("TXT2")==null || request.getParameter("TXT2").equals(""))
			mDate2="";
		else
			mDate2=request.getParameter("TXT2").toString().trim();

		if(request.getParameter("MarqueeText")==null)
		{
			mMText="";
		}
		else
		{
			mMText=request.getParameter("MarqueeText").toString().trim();	
			mMText=gb.replaceSignleQuot(mMText);
		}

		if(request.getParameter("MarqueeTextPriority")==null)
		{
			mMTextLevel="";
		}
		else
		{
			mMTextLevel=request.getParameter("MarqueeTextPriority").toString().trim();	
		}
	} // closing of outer if

		if (!mMTextLevel.equals("") && !mMText.equals(""))
		{
		   if (gb.isNumeric(mMTextLevel)==true)
		   {
			mTPNO=Long.parseLong(request.getParameter("MarqueeTextPriority").toString().trim());
			mMText=gb.replaceSignleQuot(mMText);
			if(mTPNO > 0)
			{
			qry="select 'Y' from KIOSKMARQUEETEXT where APPLICABLEFOR=decode('"+mMType+"','A',APPLICABLEFOR,'"+mMType+"') ";
			qry=qry+" and (DISPLAYFROM between (to_date('"+mDate1+"','dd-mm-yyyy'))";
			qry=qry+" and (to_date('"+mDate2+"','dd-mm-yyyy'))";
			qry=qry+" or DISPLAYTILL between (to_date('"+mDate1+"','dd-mm-yyyy'))";
			qry=qry+" and (to_date('"+mDate2+"','dd-mm-yyyy')))";
			rs1=db.getRowset(qry);
			//out.print(qry);
			if(!rs1.next())
			{
				qry1="INSERT INTO KIOSKMARQUEETEXT(INSTITUTECODE, TEXTDATA, APPLICABLEFOR, MSGPRIORITY, DISPLAYFROM, DISPLAYTILL, ACTIVE)";
				qry1=qry1+ " VALUES ('"+mInst+"', '"+mMText+"', '"+mMType+"', '"+mTPNO+"',to_date('"+mDate1+"','DD-MM-YYYY'), to_date('"+mDate2+"', 'DD-MM-YYYY'),'Y')";
				int n=db.insertRow(qry1);
			   // Log Entry
	  		   //-----------------
			    db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"NEW KIOSK MARQUEE TEST", "Marquee Type  : "+mMType+" Display From :"+ mDate1+"Upto"+mDate2, "No MAC Address" , mIPAddress);
			   //-----------------
				//out.print(qry1);
			}
			else
			{
					out.print("<br><img src='../../Images/Error1.jpg'>");
					out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>&nbsp;&nbsp;&nbsp;Duplicate Message can't allowed during this period! Choose different time interval...</font> <br>");
			}
			}
			else
			{
				out.print("<br><img src='../../Images/Error1.jpg'>");
				out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>&nbsp;&nbsp;&nbsp;Message Priority must be greater than <font color=black>'</font> 0 <font color=black>'</font> !</font> <br>");
			}
		   }
		   else
		   {		 
			   out.print("<br><img src='../../Images/Error1.jpg'>");
			   out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>&nbsp;&nbsp;&nbsp;Please enter numeric Priority only!</font> <br>");
		   }

		}
		else 
		{
//			out.print("<br><img src='../../Images/Error1.jpg'>");
//			out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>&nbsp;&nbsp;&nbsp;Please enter Message with unique Priority to insert any record!</font> <br>");
		}
	%>
			<center>
			<table bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=columns topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center width="100%">
			<thead>
			<tr bgcolor="#ff8c00">
				<td><font color=white><b>SNo.</b></td>
				<td align=center><font color=white><b>Marquee Message</b></td>
				<td align=center><font color=white><b>Display Period</b></td>
				<td align=center><font color=white><b>Priority</b></td>
				<td align=center><font color=white><b>Status</b></td>
				<td align=center><font color=white><b>Edit?</b></td>
				<td align=center><font color=white><b>Delete?</b></td>
			</tr>
		</thead>
	<tbody>
	<%
	qry="Select nvl(TEXTDATA,' ') MText, nvl(APPLICABLEFOR,' ') MType, nvl(MSGPRIORITY,0) MLevel, nvl(to_char(DISPLAYFROM,'DD-MM-YYYY'),' ')DateF,";
	qry=qry+" nvl(to_char(DISPLAYTILL,'DD-MM-YYYY'),' ')DateT, nvl(ACTIVE,'N') Active from KIOSKMARQUEETEXT where APPLICABLEFOR=decode('"+mMType+"','A',APPLICABLEFOR,'"+mMType+"') ";
	qry=qry+" and (trunc(DISPLAYFROM) between trunc(decode(to_date('"+mDate1+"','DD-MM-YYYY'),'',DISPLAYFROM,to_date('"+mDate1+"','DD-MM-YYYY')))";
	qry=qry+" and trunc(decode(to_date('"+mDate2+"','DD-MM-YYYY'),'',DISPLAYFROM,to_date('"+mDate2+"','DD-MM-YYYY')))";
	qry=qry+" or trunc(DISPLAYTILL) between trunc(decode(to_date('"+mDate1+"','DD-MM-YYYY'),'',DISPLAYTILL,to_date('"+mDate1+"','DD-MM-YYYY')))";
	qry=qry+" and trunc(decode(to_date('"+mDate2+"','DD-MM-YYYY'),'',DISPLAYTILL,to_date('"+mDate2+"','DD-MM-YYYY')))) Order By DateF, DateT, MType";
//out.print(qry);
			rs1=db.getRowset(qry);
 			int Ctr=0;
			while(rs1.next())
			{
				mActive=rs1.getString("Active");
				Ctr++;
				%>
            		<tr>
					<td><%=Ctr%>.</td>
					<td>&nbsp;<%=rs1.getString("MText")%></td>
					<td nowrap>&nbsp;<%=rs1.getString("DateF")%><b> - </b><%=rs1.getString("DateT")%></td>
					<td align=center>&nbsp;<%=rs1.getLong("MLevel")%></td>
					<%
					if(mActive.equals("Y"))
					mAct="Active";
					else
					mAct="Deactive";
					%>
					<td align=center>&nbsp;<%=mAct%></td>
					<td align=center><a href ='EditKioskMarqueeText.jsp?INST=<%=mInst%>&amp;MTEXT=<%=rs1.getString("MText")%>&amp;MTYPE=<%=rs1.getString("MType")%>&amp;MLEVEL=<%=rs1.getLong("MLevel")%>&amp;MDATE1=<%=rs1.getString("DateF")%>&amp;MDATE2=<%=rs1.getString("DateT")%>&amp;ACTV=<%=mActive%>'><img src='../../Images/EditButt.jpg' border=0 title="Edit the current Kiosk Marquee Text"></a></td>
					<td align=center><a href ='DeleteKioskMarqueeText.jsp?INST=<%=mInst%>&amp;MTEXT=<%=rs1.getString("MText")%>&amp;MTYPE=<%=rs1.getString("MType")%>&amp;MLEVEL=<%=rs1.getLong("MLevel")%>&amp;MDATE1=<%=rs1.getString("DateF")%>&amp;MDATE2=<%=rs1.getString("DateT")%>'><img src='../../Images/Delete.jpg' border=0 title="Delete the current Kiosk Marquee Text"></a></td></tr>
				<%
			} //closing of while
		%>
		</tbody>
		</table>
		<script type="text/javascript">
		var st1 = new SortableTable(document.getElementById("table-1"),["Number", "CaseInsensitiveString", "CaseInsensitiveString", "CaseInsensitiveString", "Number"]);
		</script>
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
	<h3>	<br><img src='../../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
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
}
%>

</body>
</html>
