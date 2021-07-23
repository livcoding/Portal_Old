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
String mINSTITUTECODE =" ",RightName="",RightId="",seqid="",reqAction="";
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
    <title>Right Master</title>
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
		if(document.getElementById("rightname").value=="")
		 {
		 msg=msg+"Please Fill Right's Name.\n";
         c=1;
		 document.getElementById("rightname").focus();
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
			var upperCaseVersion=document.getElementById("rightname").value.toUpperCase();
			document.getElementById("rightname").value=upperCaseVersion;
			}	
			</script>


	 </head>
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
	<font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><U><b>Right Master</b></U>
	</td></tr></table>
	<table cellspacing=0  cellpadding=1 frame =box align="center" border=1 style="FONT-FAMILY: Arial; 
    FONT-SIZE: x-small" borderColor=black borderColorDark=white width=100%>
   <br>	
   <tr align="middle" bgcolor="#ff8c00">
   <td align="center" width="80%" colspan="4"><FONT color=black face=Arial size=2>&nbsp; <b>Right's Name</b><font color=red size=5px>*</font>
   <input type="text" value="<%=RightName%>" name="rightname" id="rightname" onKeyUp="return upper();" style="width:160px;">
			<%
			if(request.getParameter("rightname")!=null)
			RightName=request.getParameter("rightname").toString().trim();
			else	
			RightName="";
			%>

		
	</td>
	<td  align="center" colspan="2">
		<input type="checkbox" id="active" name="active" value="<%=active%>">
		<FONT color=black face=Arial size=2>&nbsp;<b>DeActive</b> 
	</td>
  
		<%if (request.getParameter("active")!=null)
			active="Y";
		else
			active="N";
		%></tr>
		<tr>
		<td align="center" valign="center" colspan="8">
		<input type="Submit" name="btn"  value="Save" onClick="return check();">&nbsp;&nbsp;<input type="reset" value="cancel"/></td></tr></table></form>
		<%
		int srno=1;
		reqAction=request.getParameter("btn")+"";
//String deactive=request.getParameter("deactive")==null?
		active=request.getParameter("active")=="N"?"N":"Y";
		RightName=request.getParameter("RIGHTSNAME")==null?"":request.getParameter("RIGHTSNAME")+"";

			if(reqAction.equalsIgnoreCase("save"))
			{
			RightName=RightName.toUpperCase();
			dubQry="Select Count(*) from RS#RIGHTSMASTER where  upper(RIGHTSNAME)=upper('"+RightName+"')";
			//out.print(qry);
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
		RightName=request.getParameter("rightname")==null?"":request.getParameter("rightname")+"";
		active=request.getParameter("active")==null?"":request.getParameter("active")+"";
		qry="select(nvl(max(to_number(RIGHTSID)),0)+1) RIGHTSID,(nvl(max(SEQID),0)+1) SEQID from RS#RIGHTSMASTER";
		rs=db.getRowset(qry);
		 if(rs.next())
	  {
		 RightId=rs.getString(1)+"";
		 seqid=rs.getString(2)+"";
	 }
		qry="INSERT INTO RS#RIGHTSMASTER (RIGHTSID,RIGHTSNAME,SEQID,DEACTIVE) VALUES('"+RightId+"','"+RightName+"','"+seqid+"','"+active+"')"; 
		
		n=db.insertRow(qry);
		Message="Record Saved Successfully";
		}}
		else if(reqAction.equalsIgnoreCase("update"))
		{
		active=request.getParameter("active")=="N"?"N":"Y";
// deactive=request.getParameter("deactive")==null?"":request.getParameter("deactive")+"";

		RightId=request.getParameter("id")+"";
		RightName=request.getParameter("rightname")==null?"":request.getParameter("rightname")+"";
		active=request.getParameter("active")==null?"N":"Y"+"";
		qry="update RS#RIGHTSMASTER set RIGHTSNAME='"+RightName+"',DEACTIVE='"+active+"'" +
                   " Where RIGHTSID='"+RightId+"'" ;
	n=db.update(qry);
	Message="Record Updated Successfully";
	 }
	 else  if(reqAction.equalsIgnoreCase("delete"))
		{
		RightId=request.getParameter("id")+""; 
		qry="delete from RS#RIGHTSMASTER where RIGHTSID ='"+RightId+"'";
		int result=db.update(qry);
		Message="Record Deleted Successfully";	
		
		}
	%>
	
		<table cellspacing=0  cellpadding=0  cellspacing=0 align="center"  	style="FONT-SIZE:x-small" border="1"  borderColor=black borderColorDark=white bgcolor="white" width="500" name="table1" id="table1">
		 <thead>
		 <tr align="middle" bgcolor="#ff8c00" >
		 <td align="left" valign="top" id="rightname">
		 <FONT color=white face="arial" size="2">Seq.ID
		 </td>
		 <td align="left" valign="top" id="seqid">
		 <FONT color=white face="arial" size=2>Right Name
		 </td>
		 <td align="left" valign="top" id="active">
		 <FONT color=white face="arial" size=2>Deactive
		 </td>
		 <td align="left" valign="top" id="deactive">
		 <FONT color=white face="arial" size=2>Edit
		 </td>
		 <td align="left" valign="top" id="deactive">
		 <FONT color=white face="verdana" size=2>Delete
		 </td>
		 </tr>
		 </thead>
		 <tbody>
		<% qry="select SEQID,UPPER(RIGHTSNAME) RIGHTSNAME,NVL(DEACTIVE,'N') DEACTIVE, decode(DEACTIVE,'Y','Yes','No')ACT_DCT from RS#RIGHTSMASTER order by 1";
		 rs=db.getRowset(qry);
	     while(rs.next())
			 {
			 %>
		 <tr>
		 <td align="left" valign="center" height="10"><%=rs.getString("SEQID")%>
		 <FONT color=black face= size=2>
		 </td>
		 <td align="left" valign="center" height="10"><%=rs.getString("RIGHTSNAME")%>
		 <FONT color=black face=Arial size=2>
		 </td>
		 <td align="left" valign="center" height="10"><%=rs.getString("ACT_DCT")%>
		 <FONT color=black face=Arial size=2>
		 </td>
		 <td align="left" valign="center" height="10">
		 <a href="RightMasterEdit.jsp?id=<%=rs.getString(1).toString()%>">Edit</a>
		 </td>
		 <td>
		 <a href="RightMaster.jsp?id=<%=rs.getString(1).toString()%>&btn=<%="delete"%>" onclick="return confirmdelete();">Delete</a>
	   	 </td>
		 </tr>
		 <% 
			 }
		 %> </tbody>
		 </table>
		
		 
		 
		
<%
	}}}
catch(Exception e)
{
}
%>
</html>

