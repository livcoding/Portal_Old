<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mSCellNo="", mPCellNo="", mSTelNo="", mPTelNo="", mSEmail="",mPEmail="";
String mInst="",mWebEmail="";
String mMem="";
String mMemID="";
String qry="",mDID="",qury="",roomfor="",roomtype="";
String mSemail="",mDMemC="",mInstC="",mMemberID="",mMemberType="";
String academicyear="",active="",starttime="",queall="",endtime="",beytime="",hbook="",ttint="",vbook="";
String mint="",roomusagecode="";
int n=0,bbhour=0,abhour=0,tslot=0,abdays=0,n1=0,roomcapacity=0,roomcapacityY=0,roomcapacityX=0,examseating=0,invigilator=0,exammatrixX=0,exammatrixY=0,minseating=0;
String x="",Date1="",ParmemberID ="",MatchArray="",result="",Message="",roomname="",roomdes="",roomcode="";
String mINSTITUTECODE =" ",qry2="",resname="",rescode="";
ResultSet rs=null,rsi=null,rss=null,rs1=null,rs2=null;
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
String days="",rcode="",shortname="",rname="",rcat="",ret="",inst="",insti="",sinst="",dinfo="",rtype="",qry3="",recode="",resID="",forexam="",resourcetypeId="",resourceId="";

//----------------------
%>				
<html>
 <head>
    <title>Room Master</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">	
	<script> 
	function upper() 
	{
    var field = document.frm[0].roomcode;
    var upperCaseVersion = document.getElementById("roomcode").value.toUpperCase()
    document.getElementById("roomcode").value=upperCaseVersion;
	var field = document.frm[0].roomdes;
    var upperCaseVersion = document.getElementById("roomdes").value.toUpperCase()
    document.getElementById("roomdes").value=upperCaseVersion;
	}
	</script>

		
 </head>
	<body topmargin="10" rightmargin="0" align="center" leftmargin="10" bottommargin="0" bgcolor="#fce9c5">
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
	<form name="frm" id="frm" method="post" action="ResourceMaster.jsp" >
   <input id="x" name="x" type="hidden">
 <table cellspacing=0  cellpadding=1  style="FONT-FAMILY: Arial;FONT-SIZE: x-small" borderColor="black" borderColorDark="white" width="100%">
   <tr><td align="center">
	<font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><U>Room Master</U>
	</td></tr></table><br>
<table cellspacing="0" id="roommaster" cellpadding="1" frame ="box"  border="1" style="FONT-FAMILY: Arial; FONT-SIZE: x-small" borderColor="black" borderColorDark="white" width="97%">
	<tr> 
	
  <td align="left"colspan="4"><FONT color=black face=Arial size=2>&nbsp; Room Code/Description
  <input type="text" value="<%=roomcode%>" name="roomcode" id="roomcode" onKeyUp="return upper();" style="width:75px;" >
  <input type="text" value="<%=roomdes%>" name="roomdes" id="roomdes" onKeyUp="return upper();" style="width:160px;">
		
 <%
			if(request.getParameter("roomcode")!=null)
      roomcode=request.getParameter("roomcode").toString().trim();
         else	
		roomcode="";
			if(request.getParameter("roomdes")!=null)
		 roomdes=request.getParameter("roomdes").toString().trim();
         else	
		roomdes="";%>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="active" name="active" value="<%=active%>">DeActive
		
  
		<%if (request.getParameter("active")!=null)
			active="Y";
		else
			active="N";
		%></td></tr>

		<tr>
		<td  valign="top" ><FONT color=black face=Arial size=2>&nbsp;Short Name</td>
		<td><input type="text" value="<%=shortname%>" name="shortname" id="shortname" style="width:100px;" >
		
<%
		 if(request.getParameter("shortname")!=null)
			shortname=request.getParameter("shortname");
		else
            shortname="";	
	%></td>
	<td  valign="top" ><FONT color=black face=Arial size=2>&nbsp;Room Capacity</td>
	<td><input type="text" value="<%=roomcapacity%>" name="roomcapacity" id="roomcapacity" style="width:50px;">
		
<%
		 if(request.getParameter("roomcapacity")!=null)
			roomcapacity=Integer.parseInt(request.getParameter("roomcapacity"));
		else
            roomcapacity=0;	
	%></td>
</tr>
<tr><td  valign="top" ><FONT color=black face=Arial size=2>&nbsp;Room Capacity X</td>
	<td><input type="text" value="<%=roomcapacityX%>" name="roomcapacityX" id="roomcapacityX" style="width:50px;">
		
<%
		 if(request.getParameter("roomcapacityX")!=null)
			roomcapacityX=Integer.parseInt(request.getParameter("roomcapacityX"));
		else
            roomcapacityX=0;	
	%></td>
	<td  valign="top" ><FONT color=black face=Arial size=2>&nbsp;Room Capacity Y</td>
	<td><input type="text" value="<%=roomcapacityY%>" name="roomcapacityY" id="roomcapacityY" style="width:50px;">
		
<%
		 if(request.getParameter("roomcapacityY")!=null)
			roomcapacityY=Integer.parseInt(request.getParameter("roomcapacityY"));
		else
            roomcapacityY=0;	
	%></td>
</tr><tr>
		<td  valign="top" ><FONT color=black face=Arial size=2>&nbsp;Exam Seating Capacity</td>
		<td><input type="text" value="<%=examseating%>" name="examseating" id="examseating" style="width:50px;" >
		
<%
		 if(request.getParameter("examseating")!=null)
			examseating=Integer.parseInt(request.getParameter("examseating"));
		else
            examseating=0;	
	%></td>
	<td  valign="top" ><FONT color=black face=Arial size=2>&nbsp;Exam Matrix X</td>
	<td><input type="text" value="<%=exammatrixX%>" name="exammatrixX" id="exammatrixX" style="width:50px;">
		
<%
		 if(request.getParameter("exammatrixX")!=null)
			exammatrixX=Integer.parseInt(request.getParameter("exammatrixX"));
		else
            exammatrixX=0;	
	%></td>
</tr>
<tr><td  valign="top" ><FONT color=black face=Arial size=2>&nbsp;exam matrix Y</td>
	<td><input type="text" value="<%=exammatrixY%>" name="exammatrixY" id="exammatrixY" style="width:50px;">
		
<%
		 if(request.getParameter("exammatrixY")!=null)
			exammatrixY=Integer.parseInt(request.getParameter("exammatrixY"));
		else
            exammatrixY=0;	
	%></td>
	<td  valign="top" ><FONT color=black face=Arial size=2>&nbsp;Invigilator</td>
	<td><input type="text" value="<%=invigilator%>" name="invigilator" id="invigilator" style="width:50px;">
		
<%
		 if(request.getParameter("invigilator")!=null)
			invigilator=Integer.parseInt(request.getParameter("invigilator"));
		else
            invigilator=0;	
	%></td>
</tr><td  valign="top" colspan="" ><FONT color=black face=Arial size=2>&nbsp;Used For Exam</td>
		
		
<%// qry="select distinct RESOURCECATEGORY rescat,decode(RESOURCECATEGORY,'O','Other','R','Room') RESOURCECATEGORY from RS#RESOURCETYPE";
 
   //rs=db.getRowset(qry);
%><td>
<select name="forexam"  id="forexam" style="width:85px;" >
<option value=""><-Select-></option>
<option value="Y">YES</option>
<option value="N">NO</option>
</select>
<%if(request.getParameter("forexam")!=null)
		{forexam=request.getParameter("forexam");
		}
		else
		{forexam="";}%>
</td>
	<td  valign="top" ><FONT color="black" face="Arial" size=2>&nbsp;Min. Seating Capacity</td>
	<td><input type="text" value="<%=minseating%>" name="minseating" id="minseating" style="width:50px;">
		
<%
		 if(request.getParameter("minseating")!=null)
			minseating=Integer.parseInt(request.getParameter("minseating"));
		else
            minseating=0;	
	%></td>
	<tr>
<td valign="top"><FONT color=black face=Arial size=2>&nbsp;Room Usage Code</td>
     <% 
{
qry="select ROOMUSAGECODE from RS#RoomUsage";
rs=db.getRowset(qry);
%>
<td><select name="roomusagecode" id="roomusagecode" style="width:160px;" >
<option value=""><-Select RoomCode-></option>
<%
	if(request.getParameter("x")==null)
	{
	while(rs.next())
	{ %>
<option value="<%=rs.getString("ROOMUSAGECODE")%>"> <%=rs.getString("ROOMUSAGECODE")%></option>
<%}}
	else{while(rs.next())
	{
					roomusagecode=rs.getString("ROOMUSAGECODE");

	if(roomusagecode.equals(request.getParameter("roomusagecode")))
			{%>
	<option  selected  value="<%=rs.getString("ROOMUSAGECODE")%>"><%=rs.getString("ROOMUSAGECODE")%></option>
<%
			}
			else
			{
%>
<option value="<%=rs.getString("ROOMUSAGECODE")%>"><%=rs.getString("ROOMUSAGECODE")%></option>
<%
			}
			}
	}		
	}
	%>
	</select>
		</td ><td valign="top"><FONT color=black face=Arial size=2>&nbsp;Room For</td>
			<td><input type="text" value="<%=roomfor%>" name="roomfor" id="roomfor" style="width:100px;" >
		
<%
		 if(request.getParameter("roomfor")!=null)
			roomfor=request.getParameter("roomfor");
		else
            roomfor="";	
	%></td></tr>
		<tr>
		<td valign="top"><FONT color=black face=Arial size=2>&nbsp;Room Type</td>
			<td><input type="text" value="<%=roomtype%>" name="roomtype" id="roomtype" style="width:100px;" >
		
<%
		 if(request.getParameter("roomtype")!=null)
			roomtype=request.getParameter("roomtype");
		else
            roomtype="";	
	%></td><td align="center"colspan="2"><input type="submit" value="Submit" 
style="width:50px;">&nbsp;&nbsp;<input type="reset" style="width:50px;" value="Cancel"></td></tr>
		</table>
	<%
	qry="select RESOURCETYPEID, RESOURCEID from rs#resourcemaster";
	rs=db.getRowset(qry);
	while(rs.next())
		{
		resourcetypeId=rs.getString("RESOURCETYPEID");
		resourceId=rs.getString("RESOURCEID");

	qry="INSERT INTO RS#ROOMMASTER (RESOURCETYPEID,RESOURCEID,ROOMCODE,ROOMDESC,SHORTNAME,ROOMCAPACITY,ROOMCAPACITYX, ROOMCAPACITYY,USEDFOREXAM,EXAMSEATINGCAPACITY,EXAMMATRIXX,EXAMMATRIXY,INVIGILATORREQUIRED,MINSEATINGCAPACITY,DEACTIVE)VALUES('"+resourcetypeId+"','"+resourceId+"','"+roomcode+"','"+roomdes+"','"+shortname+"','"+roomcapacity+"','"+roomcapacityX+"','"+roomcapacityY+"','"+forexam+"','"+examseating+"','"+exammatrixX+"','"+exammatrixY+"','"+invigilator+"','"+minseating+"','"+active+"')";
	 n=db.insertRow(qry);
	if(n>0)
		{
		out.print("Room Master Data is Saved now Continue");
		}



		}





			}}}
catch(Exception e)
{
}
%>
</html>