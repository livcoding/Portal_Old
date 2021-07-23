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
    <title>No Booking Resources</title>
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
	{
		 institute=request.getParameter("id");
	     DATE1=request.getParameter("id1");
	     DATE2=request.getParameter("id2");
		reqAction=request.getParameter("btn")+"";
		
 if(!reqAction.equalsIgnoreCase("update"))
		{		
qry="SELECT Distinct  SLNO,INSTITUTECODE,to_char(NOBOOKINGFROMDATE,'dd-mm-yyyy') NOBOOKINGFROMDATE,to_char(NOBOOKINGTODATE,'dd-mm-yyyy') NOBOOKINGTODATE,to_char(TIMESLOTFROM,'HH:MI AM') TIMESLOTFROM,to_char(TIMESLOTTO,'HH:MI PM') TIMESLOTTO, nvl(REASON,' ') REASON,RESOURCECODE,FLAG,DEACTIVE  FROM RS#NORESOURCEBOOKING  where INSTITUTECODE='"+institute+"' and NOBOOKINGFROMDATE=to_date('"+DATE1+"','dd-mm-yyyy') and NOBOOKINGTODATE=to_date('"+DATE2+"','dd-mm-yyyy') and RESOURCEID='"+resource+"' and RESOURCETYPEID='"+ResourcetypeId+"'" ;
		 rs=db.getRowset(qry);
		
		 while(rs.next())
		{
			 institute=rs.getString("INSTITUTECODE");
			 DATE1=rs.getString("NOBOOKINGFROMDATE");
			 DATE2=rs.getString("NOBOOKINGTODATE");
			 time1=rs.getString("TIMESLOTFROM");
			 time2=rs.getString("TIMESLOTTO");
			 reason=rs.getString("REASON");
			 allowed=rs.getString("FLAG");
			 active=rs.getString("DEACTIVE");
			 %>
	<form name="frm1"  method="post" action="NoBookingTimeSlot.jsp">
	<input id="x" name="x" type=hidden> <input id="z" name="z" type=hidden>
	<table cellspacing=0  cellpadding=1  style="FONT-FAMILY: Arial; 
    FONT-SIZE: x-small" borderColor="black" borderColorDark="white" width="100%">
   <tr><td align="center">
	<font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><U><b>No Booking TIme Slot</b></U>
	</td></tr></table>
	<table cellspacing=0  cellpadding=1 frame =box align="center" border=1 style="FONT-FAMILY: Arial; FONT-SIZE: x-small" borderColor=black borderColorDark=white width=100%>
   <br>
   <tr  bgcolor="#ff8c00">
	<tr  bgcolor="#ff8c00">
	<td valign="top" colspan="3" align="right" width="80%"><FONT color="black" face="Arial" size="2"> Institue Code & Name
    
<%
qry="select INSTITUTECODE inst,INSTITUTENAME instname  from INSTITUTEMASTER ";
	rs=db.getRowset(qry);	

%>

<select name="institute" id="institute"  style="width:470px;align:center;" align="center">
<option value=""><--Select institute code & Name--></option>
	<%
while(rs.next())
			{
if(rs.getString(1).equals(institute))
	{%>
<option value="<%=rs.getString(1)%>" selected><%=rs.getString(1)%>/<%=rs.getString(2)%></option>
	<%} else{%>
<option value="<%=rs.getString(1)%>"><%=rs.getString(1)%>/<%=rs.getString(2)%></option>
<%			}
			}
%>
</select>
</td>
		<td  align="center" width="20%">
		<%if(active.equals("N")){%>
		<input type="checkbox" id="active" name="active"  value="<%=active%>">
		<%}else{%>
		<input type="checkbox" id="active" name="active" checked value="Y">
			<%}%>
		<FONT color=black face=Arial size=2>&nbsp;DeActive </td>
		</tr>
		
		<tr>
	
	<%if(allowed.equals("N")){%>
	<td align="right" width="20%" ><FONT color=black face=Arial size=2>Not Allowed</td>
	<td align="left" width="30%"><input type="radio" name="allowed" value="N" checked></td>
	<td align="right" width="20%"><FONT color=black face=Arial size=2>Allowed</td>
	<td align="left" width="30%"><input type="radio" name="allowed" value="Y"></td>
	
	<%}
	else 
		{
		%><td align="right" width="20%" ><FONT color=black face=Arial size=2>Not Allowed</td>
	<td align="left" width="30%"><input type="radio" name="allowed" value="N" ></td>
	 
	<td align="right" width="20%"><FONT color=black face=Arial size=2>Allowed</td>
	<td align="left" width="30%"><input type="radio" name="allowed" value="Y" checked></td>
	<%}%>
	
	</tr>
	<tr>
	<td align="left" colspan="">From Period <font color=green face=arialblack font size=2>(DD-MM-YYYY)</font></td>
	<td align="left">&nbsp;<INPUT TYPE="text" NAME="DATE1" ID="DATE1" size="9" VALUE='<%=DATE1%>' >
	<a href="javascript:NewCal('DATE1','ddmmyyyy')">
	<img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a></td>
	<td align="right"><FONT color="black" face="Arial" size="2">To Period</td>
	<td align="left">&nbsp;<INPUT TYPE="text" NAME="DATE2" ID="DATE2" size="9" 
	VALUE='<%=DATE2%>' >&nbsp;<a href="javascript:NewCal('DATE2','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>&nbsp;</td>
	</tr>
	<tr>
	<td align="right"  colspan="">
	<FONT color="black" face="Arial" size="2">
	Time Slot From</td>
	<td align="left">&nbsp;<input id='time1' name='time1'	style="width:75px;" type='text' readonly value="<%=time1%>" size=8 maxlength=8	ONBLUR="validateDatePicker(this)" >&nbsp;<IMG SRC="../../Images/timepicker.gif" BORDER="0" ALT="Pick a Time!" ONCLICK="return selectTime(this,time1)" STYLE="cursor:hand" ></td>
<td align="right"><FONT color="black" face="Arial"size="2">Time Slot To</td>
<td align="left">&nbsp;<input id='time2' name='time2' style="width:75px;" type='text' readonly value="<%=time2%>" size=8 maxlength=8	ONBLUR="validateDatePicker(this)" >&nbsp;<IMG SRC="../../Images/timepicker.gif" BORDER="0"ALT="Pick a Time!" ONCLICK="return selectTime(this,time2)" STYLE="cursor:hand"></td>
<tr >
<td valign="top" colspan="4" align="center"><FONT color=black face=Arial size=2>&nbsp;Reason
<textarea align="center" rows="3" cols="60" id="reason" name="reason" value=""><%=reason%></textarea>
<td valign="top" colspan="2" align="left">
<FONT color=black face=Arial size=2>&nbsp;Reason

&nbsp;<textarea valign="center" rows="3" cols="50" id="reason" name="reason" value="<%=reason%>"></textarea>
<%reason=request.getParameter("reason")==null?"":request.getParameter("reason")+"";%></td>

<td align="right"  valign="top">
<FONT color="black" face="Arial" size="2" >Resources</td>
<td align="left"  valign="top">
     <% 
	qry="select RESOURCEID,RESOURCETYPEID ,Initcap(RESOURCEDESC )||'['||RESOURCECODE||']' RESOURCEDESC from RS#RESOURCEMASTER ";
	rs1=db.getRowset(qry);
	while (rs1.next())
		{%>
		<table>
		<tr>
		<td><input type="checkbox" name="resourcecode"></td>
		<td><FONT color="black" face="Arial" size="2" ><%=rs1.getString("RESOURCEDESC")%></td>
		</table>
		<%ResourcetypeId=rs1.getString("RESOURCETYPEID")==null?"":rs1.getString("RESOURCETYPEID");
		
		resource=rs1.getString("RESOURCEID")==null?"":rs1.getString("RESOURCEID");
		}%>
</td>
<input type="hidden" id="id" name="id" value=<%=institute%>>
<input type="hidden" id="id1" name="id1" value=<%=DATE1%>>
<input type="hidden" id="id2" name="id2" value=<%=DATE2%>>
<input type="hidden" id="id3" name="id3" value=<%=resource%>>
<input type="hidden" id="id4" name="id4" value=<%=ResourcetypeId%>>
<input type="submit" value="Update" onClick="<%reqAction="Update";%>" name="btn"/>
<input type="reset" value="Cancel"/>
</td>
</tr>
</table>
</form>
			 
	<%}	}
	}
	
}
	}
catch(Exception e)
{
}
%>