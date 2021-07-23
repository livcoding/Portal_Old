<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mSCellNo="", mPCellNo="", mSTelNo="", mPTelNo="", mSEmail="",mPEmail="";
String mInst="",mWebEmail="";
String mMem="";
String mMemID="";
String qry="",mDID="",qury="",qry2="",qry1="",qry3="";
String mSemail="",mDMemC="",mInstC="",mMemberID="",mMemberType="";
String academicyear="",active="",starttime="",queall="",endtime="",beytime="",hbook="",ttint="",vbook="";
String mint="";
int n=0,bbhour=0,abhour=0,tslot=0,abdays=0,n1=0,y=0;
String x="",Date1="",ParmemberID ="";
String mINSTITUTECODE =" ",institute="",reqAction="";
ResultSet rs=null,rsi=null,rss=null,rs1=null,rs2=null;
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
String dubQry="",listQry="";
	int dubCode=0,slno=0;
	String Message="",allowed="";
    ResultSet ch=null;
   String qryChild="",time1="",time2="",DATE1="",DATE2="",reason="";

//----------------------
%>				
<html>
 <head>
    <title>No Booking Time Slot</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
	<script language="JavaScript" type="text/javascript" src="js/sortabletable.js"></script>
	<script type="text/javascript" src="js/TimePicker.js"></script>

	<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
	<script>	
	function check()
		{
		var msg="";
		var c=0;
		if(document.getElementById("institute").value=="")
		 {
		 msg=msg+"Please select a institute.\n";
         c=1;
		 document.getElementById("institute").focus();
		 } 
		 if(document.getElementById("DATE1").value=="")
		 {
		   msg=msg+"Please Fill	form period.\n";
         c=1;
		 document.getElementById("DATE1").focus();
		}
		if(document.getElementById("DATE2").value=="")
		 {
		 msg=msg+"Please Fill to period.\n";
         c=1;
		 document.getElementById("DATE2").focus();
		 } 
		 if(document.getElementById("time1").value=="")
		 {
		   msg=msg+"Please Fill time slot from.\n";
         c=1;
		 document.getElementById("time1").focus();
	    }
		if(document.getElementById("time2").value=="")
		 {
		   msg=msg+"Please Fill	 time slot to.\n";
         c=1;
		 document.getElementById("time2").focus();
	    }

		if(c>0)
		{
		alert(msg);
		return false;
		}
		}
	function confirmdelete()
	 {
		var confirmLeave = confirm('Are you sure to delete this record?');
		if(confirmLeave==false)
		{
		return false;
        }
     }
</script>
</head>
	
	<body topmargin="10" rightmargin="0" leftmargin="10"  bgcolor="#fce9c5">
    <%
	try
{
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
    mInstC="";
}
else
{
    mInstC=session.getAttribute("InstituteCode").toString().trim();
}
if(session.getAttribute("MemberCode")==null)
{
	mMem="";	
}
else
{
	mMem=session.getAttribute("MemberCode").toString().trim();
}

if(session.getAttribute("MemberID")==null)
{
	mMemID="";	
}
else
{
	mMemID=session.getAttribute("MemberID").toString().trim();
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



if (session.getAttribute("MemberID")!=null && session.getAttribute("MemberCode")!=null)
{
	OLTEncryption enc=new OLTEncryption();
	mDID=enc.decode(session.getAttribute("MemberID").toString().trim());
	mDMemC=enc.decode(session.getAttribute("MemberCode").toString().trim());

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress=session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
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


  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('275','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";

      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{ %>
	<form name="frm1"  method="get" >
   <input id="x" name="x" type=hidden> <input id="z" name="z" type=hidden>
   <table cellspacing=0  cellpadding=1  style="FONT-FAMILY: Arial; 
    FONT-SIZE: x-small" borderColor="black" borderColorDark="white" width="100%">
   <tr><td align="center">
	<font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><U><b>No Booking TIme Slot</b></U>
	</td></tr></table>
	<table cellspacing=0  cellpadding=1 frame =box align="center" border=1 style="FONT-FAMILY: Arial; FONT-SIZE: x-small" borderColor=black borderColorDark=white width=100%>
   <br>
   <tr  bgcolor="#ff8c00">
	<td valign="top" colspan="4" align="LEFT" width="80%"><FONT color="black" face="Arial" size="2">Institue Code & Name<FONT color="red" face="Arial" size="4" align="left">*
     <% 
	qry="select INSTITUTECODE,INSTITUTENAME  from INSTITUTEMASTER ";
	rs=db.getRowset(qry);
	rs1=db.getRowset(qry);
	while (rs1.next())
	%>

<select name="institute" id="institute"  style="width:470px;align:center;" align="center">
<option value=""><--Select institute code & Name--></option>
<%{
	if(request.getParameter("x")==null)
	{
	while(rs.next())
	{ %>
<option value="<%=rs.getString("INSTITUTECODE")%>"><%=rs.getString("INSTITUTECODE")%>/<%=rs.getString("INSTITUTENAME")%></option>
<%}}
	else{while(rs.next())
	{
					institute=rs.getString("INSTITUTECODE");

	if(institute.equals(request.getParameter("institute")))
			{%>
	<option  selected  value="<%=rs.getString("INSTITUTECODE")%>"><%=rs.getString("INSTITUTECODE")%>/<%=rs.getString("INSTITUTENAME")%></option>
<%
			}
			else
			{
%>
<option value="<%=rs.getString("INSTITUTECODE")%>"><%=rs.getString("INSTITUTECODE")%>/<%=rs.getString("INSTITUTENAME")%></option>
<%
			}
			}
	}//institute=rs.getParameter("INSTITUTECODE");	
	}%></select>
	<%institute=request.getParameter("institute")==null?"":request.getParameter("institute");%>
	
		
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="checkbox" id="active" name="active" value="<%=active%>"><FONT color="black" face="Arial" size="2">DeActive
		</td>
  
		<%if (request.getParameter("active")!=null)
			active="Y";
		else
			active="N";
		%></tr>
		
		<tr>
	<td align="right" width="20%" ><FONT color=black face=Arial size=2>Not Allowed</td>
	<td align="left" width="30%"><input type="radio" name="allowed" value="N" checked></td>
	 
	<td align="right" width="20%"><FONT color=black face=Arial size=2>Allowed</td>
	<td align="left" width="30%"><input type="radio" name="allowed" value="Y"></td>
	</tr>
	<%allowed=request.getParameter("allowed")==null?"":request.getParameter("allowed");%>
	<tr>
	<td align="RIGHT" colspan="">From Period<font color="green" face="Calibri" size="2">(DD-MM-YYYY)</font><FONT color="red" face="Arial" size="4" align="right">*</td>
	<td align="left">&nbsp;<INPUT TYPE="text" NAME="DATE1" ID="DATE1" size="9" VALUE='<%=DATE1%>' >
	<a href="javascript:NewCal('DATE1','ddmmyyyy')">
	<img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a></td>
<td align="right"><FONT color="black" face="Arial" size="2">To Period<FONT color="red" face="Arial" size="4" align="left">*</td>
	<td align="left">&nbsp;<INPUT TYPE="text" NAME="DATE2" ID="DATE2" size="9" 
	VALUE='<%=DATE2%>' >&nbsp;<a href="javascript:NewCal('DATE2','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>&nbsp;</td></tr>
<%
	DATE1=request.getParameter("DATE1")==null?"":request.getParameter("DATE1");
	DATE2=request.getParameter("DATE2")==null?"":request.getParameter("DATE2");
	%><tr>
	<td align="right"  colspan="">
	<FONT color="black" face="Arial" size="2">
	Time Slot From<FONT color="red" face="Arial" size="4" align="left">*</td>
	<td align="left">&nbsp;<input id='time1' name='time1'	style="width:75px;" type='text' readonly value="<%=time1%>" size=8 maxlength=8	ONBLUR="validateDatePicker(this)" >&nbsp;<IMG SRC="../../Images/timepicker.gif" BORDER="0" ALT="Pick a Time!" ONCLICK="return selectTime(this,time1)" STYLE="cursor:hand" ></td>
<td align="right"><FONT color="black" face="Arial"size="2">Time Slot To<FONT color="red" face="Arial" size="4" align="left">*</td>
<td align="left">&nbsp;<input id='time2' name='time2' style="width:75px;" type='text' readonly value="<%=time2%>" size=8 maxlength=8	ONBLUR="validateDatePicker(this)" >&nbsp;<IMG SRC="../../Images/timepicker.gif" BORDER="0"ALT="Pick a Time!" ONCLICK="return selectTime(this,time2)" STYLE="cursor:hand"></td>
	<%
	time1=request.getParameter("time1")==null?"":request.getParameter("time1");
	time2=request.getParameter("time2")==null?"":request.getParameter("time2");
	%>

</tr>
<tr >
<td valign="top" colspan="4" align="center"><FONT color=black face=Arial size=2>&nbsp;Reason
<textarea align="center" rows="3" cols="60" id="reason" name="reason" value="<%=reason%>"></textarea>
<input type="submit" value="Save" name="btn" onclick="return check()"/>
<input type="reset" value="Cancel"/>
<%reason=request.getParameter("reason")==null?"":request.getParameter("reason")+"";%></td>
</tr></TABLE>

		<%
		
		 reqAction=request.getParameter("btn")+"";
		
		//out.print("req="+reqAction);
		if(reqAction.equalsIgnoreCase("save"))
			{
			dubQry="Select Count(*) from RS#NOBOOKING where INSTITUTECODE='"+institute+"' and NOBOOKINGFROMDATE=to_date('"+DATE1+"','dd-mm-yyyy') and NOBOOKINGTODATE=to_date('"+DATE2+"','dd-mm-yyyy')";
			rs=db.getRowset(dubQry);
			if(rs.next())
			  { 
			 dubCode=rs.getInt(1);
			
			 }

	if(dubCode>0)
		{
		Message="Already Entered";
		}
		else
		{
		
 qry="SELECT 'Y' FROM rs#nobooking where institutecode='"+institute+"'and nobookingfromdate=to_date('"+DATE1+"','dd-mm-yyyy')and NOBOOKINGTODATE=to_date('"+DATE2+"','dd-mm-yyyy')";
 rs2=db.getRowset(qry);
 if(!rs2.next())
		{
qry="select nvl(max(Slno),0)+1 slno from RS#NOBOOKING ";
rs2=db.getRowset(qry);
//out.print(qry);
while(rs2.next()){
slno=rs2.getInt("slno");		
//out.print("slno"+slno);
}
qry="INSERT INTO RS#NOBOOKING (INSTITUTECODE,NOBOOKINGFROMDATE,NOBOOKINGTODATE,SLNO, TIMESLOTFROM,TIMESLOTTO,REASON, FLAG,DEACTIVE) VALUES('"+institute+"',to_date('"+DATE1+"','dd-mm-yyyy'),to_date('"+DATE2+"','dd-mm-yyyy'),'"+slno+"',to_date('"+time1+"','HH:MI AM'),to_date('"+time2+"','HH:MI PM'),'"+reason+"','"+allowed+"','"+active+"')";
//out.print(qry);
n=db.insertRow(qry);		
if(n>0)
	{
out.print("Record Saved Successfully....<br>");
	}
else
	{
out.print("error.");
	}
		}

}}	else if(reqAction.equalsIgnoreCase("Update"))
		{
	institute=request.getParameter("id");
	DATE1=request.getParameter("id1");
	DATE2=request.getParameter("id2");
	
	qry="UPDATE RS#NOBOOKING SET INSTITUTECODE='"+institute+"',NOBOOKINGFROMDATE=to_date('"+DATE1+"','dd-mm-yyyy'),NOBOOKINGTODATE=to_date('"+DATE2+"','dd-mm-yyyy'),TIMESLOTFROM=to_date('"+time1+"','HH:MI AM'),TIMESLOTTO =to_date('"+time2+"','HH:MI AM'),REASON ='"+reason+"', FLAG ='"+allowed+"',DEACTIVE ='"+active+"' where INSTITUTECODE='"+institute+"' and NOBOOKINGFROMDATE=to_date('"+DATE1+"','dd-mm-yyyy') and NOBOOKINGTODATE=to_date('"+DATE2+"','dd-mm-yyyy')" ;
	//out.print(qry);
	n=db.update(qry);
	Message="Record Updated Successfully";
	 }
	 else  if(reqAction.equalsIgnoreCase("delete"))
		{
		 institute=request.getParameter("id");
	     DATE1=request.getParameter("id1");
	     DATE2=request.getParameter("id2");
		qry="delete from rs#nobooking  where INSTITUTECODE='"+institute+"' and NOBOOKINGFROMDATE=to_date('"+DATE1+"','dd-mm-yyyy') and NOBOOKINGTODATE=to_date('"+DATE2+"','dd-mm-yyyy')";
		int result=db.update(qry);
		Message="Record Deleted Successfully";	
		}%>
	  <br><table cellspacing="0"  cellpadding="0"  cellspacing="0" align="center"	style="FONT-SIZE:x-small" border="1"  borderColor=black borderColorDark="white" bgcolor="white" width="850" name="table1" id="table1">
		
		 <tr align="middle" bgcolor="#ff8c00" >
		 <td align="left" valign="top" id="instcode" width="10%">
		 <FONT color=white face=Arial size=2><U>Institute Code</U>
		 </td>
		 <td align="left" valign="top" id="fromPeriod" >
		 <FONT color=white face=Arial size=2><U>From Period</U>
		 </td>
		 <td align="left" valign="top" id="toPeriod" >
		 <FONT color=white face=Arial size=2><U>To Period</U>
		 </td>
		 <td align="left" valign="top" id="slotfrom" >
		 <FONT color=white face=Arial size=2><U>Slot From</U>
		 </td>
		 <td align="left" valign="top" id="slotto" >
		 <FONT color=white face=Arial size=2><U>Slot To</U>
		 </td>
		 <td align="left" valign="top" id="status" width="30%">
		 <FONT color=white face=Arial size=2><U>Reason</U>
		 </td>
		 <td align="left" valign="top" id="reasons" >
		 <FONT color=white face=Arial size=2><U>Allowed</U>
		 </td>
		 <td align="left" valign="top" id="reasons" >
		 <FONT color=white face=Arial size=2><U>Deactive</U>
		 </td>
		 <td align="left" valign="top" id="deactive" >
		 <FONT color=white face=Arial size=2><U>Edit</U>
		 </td>
		 <td align="left" valign="top" id="deactive" >
		 <FONT color=white face=Arial size=2><U>Delete</U>
		 </td>
</tr>
		<%
			 qry="SELECT Distinct  SLNO,INSTITUTECODE,to_char(NOBOOKINGFROMDATE,'dd-mm-yyyy') NOBOOKINGFROMDATE,to_char(NOBOOKINGTODATE,'dd-mm-yyyy') NOBOOKINGTODATE,to_char(TIMESLOTFROM,'HH:MI AM') TIMESLOTFROM,to_char(TIMESLOTTO,'HH:MI PM') TIMESLOTTO, nvl(REASON,' ') REASON,FLAG,DEACTIVE  FROM RS#NOBOOKING ";
		 rs=db.getRowset(qry);
		//out.print(qry);
		 while(rs.next())
		{%>
		 <tr>
		 <td align="left" valign="top" width="10%" ><%=rs.getString("INSTITUTECODE").toString().trim()%></td>
		 <td align="left" valign="top"  ><%=rs.getString("NOBOOKINGFROMDATE").toString().trim()%></td>
		 <td align="left" valign="top" ><%=rs.getString("NOBOOKINGTODATE").toString().trim()%></td>
		 <td align="left" valign="top" ><%=rs.getString("TIMESLOTFROM").toString().trim()%></td>
		 <td align="left" valign="top"><%=rs.getString("TIMESLOTTO").toString().trim()%></td>
		 <td align="left" valign="top" width="30%"><%=rs.getString("REASON").toString().trim()==" "?" ":rs.getString("REASON").toString().trim()%></td>
		 <td align="left" valign="top" ><%=rs.getString("FLAG").toString().trim()%></td>
		 <td align="left" valign="top" ><%=rs.getString("DEACTIVE")%></td>
		 <td align="left" valign="top" height="10" width="30">
		 <a href="NoBookingTimeSlotEdit.jsp?id=<%=rs.getString("INSTITUTECODE").toString().trim()%>&id1=<%=rs.getString("NOBOOKINGFROMDATE").toString().trim()%>&id2=<%=rs.getString("NOBOOKINGTODATE").toString().trim()%>">Edit</a>
		 </td>
		 <td valign="center" align="left" height="10" width="30" >

		 <a href="NoBookingTimeSlot.jsp?id=<%=rs.getString("INSTITUTECODE").toString().trim()%>&id1=<%=rs.getString("NOBOOKINGFROMDATE").toString().trim()%>&id2=<%=rs.getString("NOBOOKINGTODATE").toString().trim()%>&btn=delete" onclick="return confirmdelete();">Delete</a>
		</td>
		</tr><%}%></table>

	<%}}}
catch(Exception e)
{
	out.print(e);
}
%></body></form>
</html>