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
String mINSTITUTECODE =" ",RoleCode="",RoleDes="",RoleId="",seqid="",reqAction="";
ResultSet rs=null,rsi=null,rss=null,rs1=null,rs2=null;
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
String dubQry="",listQry="";
	int dubCode=0;
	String Message="";
    ResultSet ch=null;
   String qryChild="";

//----------------------
%>				
<html>
 <head>
    <title>Role Master</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<script> 

	 function confirmdelete()
	 {
 
		var confirmLeave = confirm('Are you sure to delete this record?');
		if(confirmLeave==false)
		{
		return false;
        }
     }



		function check()
		{
		var msg="";
		var c=0;
		if(document.getElementById("rolecode").value=="")
		 {
		 msg=msg+"Please Fill Role Code.\n";
         c=1;
		 document.getElementById("rolecode").focus();
		 } 
		 if(document.getElementById("roledes").value=="")
		 {
		   msg=msg+"Please Fill	Role Description.\n";
         c=1;
		 document.getElementById("roledes").focus();
	    }
		if(c>0)
		{
		alert(msg);
		return false;
		}
		}
		
		function upper()
			{
			var field=document.frm1[0].RoleCode;
			var upperCaseVersion=document.getElementById("rolecode").value.toUpperCase();
			document.getElementById("rolecode").value=upperCaseVersion;
			var field=document.frm1[0].RoleDes
			var upperCaseVersion=document.getElementById("roledes").value.toUpperCase();
			document.getElementById("roledes").value=upperCaseVersion;
			}
	</script>


	 </head>
	<!-- <body topmargin="10" rightmargin="0" leftmargin="10" bottommargin="0" bgcolor="#fce9c5" onload="javascript:hideTable()"> -->
	<body topmargin="10" rightmargin="0" leftmargin="10" bottommargin="0" bgcolor="#fce9c5">
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
	<font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><U><b>Role Master</b></U>
	</td></tr></table>
	<table cellspacing=0  cellpadding=1 frame =box align="center" border=1 style="FONT-FAMILY: Arial; 
    FONT-SIZE: x-small" borderColor=black borderColorDark=white width=100%>
   <br>	
   <tr align="middle" bgcolor="#ff8c00">
   <td align="center" width="80%" colspan="4"><FONT color=black face=Arial size=2>&nbsp; <b>Role Code/Description</b><font color=red size=5px>*</font>
   <input type="text" value="<%=RoleCode%>" name="rolecode" id="rolecode" onKeyUp="return upper();"  style="width:75px;" >
   <input type="text" value="<%=RoleDes%>" name="roledes" id="roledes"  onKeyUp="return upper();" style="width:160px;">
    <%
			if(request.getParameter("rolecode")!=null)
		 RoleCode=request.getParameter("rolecode").toString().trim();
         else	
		RoleCode="";
			if(request.getParameter("roledes")!=null)
		 RoleDes=request.getParameter("roledes").toString().trim();
         else	
		RoleDes="";%>

		
	</td>
	<td  align="center" colspan="2">
		<input type="checkbox" id="active" name="active" value="Y">
		<FONT color=black face=Arial size=2>&nbsp;<b>DeActive</b> 
	</td>
  
		<%if (request.getParameter("active")!=null)
			active="Y";
		else
			active="N";
		%></tr>
		<tr><td align="center" valign="center" colspan="8">
		<input type="Submit" name="btn"  value="Save" onClick="return check();">&nbsp;&nbsp;<input type="reset" value="cancel"/></td></tr></table>
		</form>
		<%
int srno=1;
	reqAction=request.getParameter("btn")+"";
//String deactive=request.getParameter("deactive")==null?
	active=request.getParameter("active")=="N"?"N":"Y";
	 RoleCode=request.getParameter("rolecode")==null?"":request.getParameter("rolecode")+"";
	 RoleDes=request.getParameter("roledec")==null?"":request.getParameter("roledes")+"";
%>
<%
listQry="SELECT ROLEID,ROLECODE, ROLEDESC, SEQID, nvl(DEACTIVE,'N') DEACTIVE ,decode(DEACTIVE,'Y','Yes','No') ACTIVE2 FROM RS#ROLEMASTER Order by 4";
    if(reqAction.equalsIgnoreCase("save"))
	{
		RoleCode=RoleCode.toUpperCase();
		dubQry="Select Count(*) from RS#ROLEMASTER where  upper(RoleCode)=upper('"+RoleCode+"' ) ";
rs=db.getRowset(dubQry);
if(rs.next())
    {
  dubCode=rs.getInt(1);
	}

%>
<%
if(dubCode>0)
		{
Message="Already Entered";

}else
	{
	 RoleCode=request.getParameter("rolecode")==null?"":request.getParameter("rolecode")+"";
	 RoleDes=request.getParameter("roledes")==null?"":request.getParameter("roledes")+"";
	 active=request.getParameter("active")==null?"":request.getParameter("active")+"";
// to get next ID
 qry="select 'R'|| nvl(max(substr(RoleId,2)+1),1) RoleId,(nvl(max(SEQID),0)+1) SEQID  from RS#ROLEMASTER";
rs=db.getRowset(qry);
 if(rs.next())
    {
   RoleId=rs.getString(1)+"";
   seqid=rs.getString(2)+"";
   }


qry="insert into RS#ROLEMASTER(RoleId,RoleCode,RoleDesc,DEACTIVE,SEQID)"+
	" values ('"+RoleId+"','"+RoleCode+"'," +
     "'"+RoleDes+"','"+active+"','"+seqid+"')";

 n=db.insertRow(qry);
  Message="Record Saved Successfully";
}
}
 else if(reqAction.equalsIgnoreCase("update"))
     {
	active=request.getParameter("active")=="N"?"N":"Y";
// deactive=request.getParameter("deactive")==null?"":request.getParameter("deactive")+"";

	RoleId=request.getParameter("id")+"";
	RoleCode=request.getParameter("rolecode")==null?"":request.getParameter("rolecode")+"";
	RoleDes=request.getParameter("roledes")==null?"":request.getParameter("roledes")+"";
	active=request.getParameter("active")==null?"N":"Y"+"";
//RoleId=request.getParameter("RoleId")+"";
	qry="update RS#ROLEMASTER set RoleCode='"+RoleCode+"',RoleDesc='"+RoleDes+"',DEACTIVE='"+active+"'" +
                   " Where RoleId='"+RoleId+"'"  ;
n=db.update(qry);
Message="Record Updated Successfully";
	 }
	 else  if(reqAction.equalsIgnoreCase("delete"))
	{
   RoleId=request.getParameter("id")+""; 
    qry="delete from RS#ROLEMASTER where RoleId='"+RoleId+"'";

	Message="Record Deleted Successfully";	
	 int resut=db.update(qry);
		}

	
%>
	
		<table cellspacing=0  cellpadding=0  cellspacing=0 align="center"  	style="FONT-SIZE:x-small" border="1"  borderColor=black borderColorDark=white bgcolor="white" width="450" name="table1" id="table1">
		
		 <tr align="middle" bgcolor="#ff8c00" >
		 <td align="left" valign="top" id="rolecode">
		 <FONT color=white face=Arial size=2><U>Role Code</U>
		 </td>
		 <td align="left" valign="top" id="rolename">
		 <FONT color=white face=Arial size=2><U>Role Name</U>
		 </td>
		 <td align="left" valign="top" id="seqid" width="30">
		 <FONT color=white face=Arial size=2><U>Seq.ID</U>
		 </td>
		 <td align="left" valign="top" id="deactive" width="10">
		 <FONT color=white face=Arial size=2><U>Deactive</U>
		 </td>
		 <td align="left" valign="top" id="deactive" width="30">
		 <FONT color=white face=Arial size=2><U>Edit</U>
		 </td>
		 <td align="left" valign="top" id="deactive" width="30">
		 <FONT color=white face=Arial size=2><U>Delete</U>
		 </td>
		 
		 <% //qry="SELECT ROLEID,ROLECODE, ROLEDESC, SEQID, nvl(DEACTIVE,'No') DEACTIVE FROM RS#ROLEMASTER";
		rs=db.getRowset(listQry);
		while(rs.next()){%><tr>
		 <td align="left" valign="center" height="10" ><%=rs.getString("ROLECODE")%>
		<FONT color= face=arial size=2>
		 </td>
		 <td align="left" valign="center" height="10" ><%=rs.getString("ROLEDESC")%>
		<FONT color= face=arial size=2>
		 </td>
		 <td align="left" valign="center" height="10" ><%=rs.getString("SEQID")%>
		<FONT color= face=arial size=2>
		 </td>
		 <td align="left" valign="center" height="10" width="20"><%=rs.getString("ACTIVE2")%>
		<FONT color= face=arial size=2>
		 </td>
		  <td align="left" valign="center" height="10" width="30">
		 <a href="RoleMasterEdit.jsp?id=<%=rs.getString(1).toString()%>">Edit</a>
		 </td>
		 
		 <form method="get" action="RoleMaster.jsp?id=<%=rs.getString(1).toString()%>">
		 <td valign="center" align="left" height="10" width="30" >
		<a href="RoleMaster.jsp?id=<%=rs.getString(1)%>&btn=<%="delete"%>" onclick="return confirmdelete();">Delete</a>
		</td></form>
		</tr>
		 <%}%>
		</body>
<%
}}}
catch(Exception e)
{
}
%>
</html>