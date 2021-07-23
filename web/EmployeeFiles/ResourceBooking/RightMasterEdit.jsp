<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mSCellNo="", mPCellNo="", mSTelNo="", mPTelNo="", mSEmail="",mPEmail="";
String mInst="",mWebEmail="";
String mMem="";
String mMemID="";
String qry="",mDID="",qury="",qry2="",qry1="",qry3="";
String mSemail="",mDMemC="",mInstC="",mMemberID="",mMemberType="";
String academicyear="",starttime="",queall="",endtime="",beytime="",hbook="",ttint="",vbook="";
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
   String active="";

//----------------------
%>				
<html>
 <head>
    <title>Right Master</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
	{ 
RightId=request.getParameter("id")+""; 
reqAction=request.getParameter("btn")+"";
 if(!reqAction.equalsIgnoreCase("update"))
{
listQry="select RIGHTSID,SEQID,RIGHTSNAME,NVL(DEACTIVE,'N') DEACTIVE, decode(DEACTIVE,'Y','Yes','No')ACT_DCT from RS#RIGHTSMASTER  where RIGHTSID='"+RightId+"' order by 1 ";
rs=db.getRowset(listQry);
while(rs.next())
	{
RightName=rs.getString("RIGHTSNAME")==null?"":rs.getString("RIGHTSNAME")+"";

active=rs.getString("DEACTIVE");//=="N"?"N":"Y";
}

%>
		<form name="frm1"  method="post" action="RightMaster.jsp" >
		<input id="x" name="x" type=hidden> <input id="z" name="z" type=hidden>
		 <br><table cellspacing=0  cellpadding=1  style="FONT-FAMILY: Arial; 
		 FONT-SIZE: x-small" borderColor=black borderColorDark=white width=100%>
		 <tr><td align="center">
		<font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><U>Right Master</U>
		</td></tr></table>
		<table cellspacing="0"  cellpadding="1" frame ="box" align="center" border="1" style="FONT-FAMILY: Arial; 
		FONT-SIZE: x-small" borderColor="black" borderColorDark="white" width="500"%>
		<br>	
		<tr align="middle" bgcolor="#ff8c00">
		<td align="center" width="80%" colspan="4"><FONT color=black face=Arial size=2>&nbsp;Right's Name<font	color=red size=5px>*</font>
		<input type="text" value="<%=RightName%>" name="rightname" id="rightname"  style="width:300px;">
    	</td>
		<td  align="center" colspan="2">
		<%if(active.equals("N")){%>
		<input type="checkbox" id="active" name="active"  value="<%=active%>">
		<%}else{%>
		<input type="checkbox" id="active" name="active" checked value="Y">
			<%}%>
		<FONT color=black face=Arial size=2>&nbsp;DeActive 
		</td>
		</tr>
		<tr align="middle"><td align="middle" colspan="6">
		<input type="hidden" id="id" name="id" value=<%=RightId%>>
		<input type="submit" name="btn" onClick="<%reqAction="update";%>"  value="Update" accesskey="u" title="Alt+u">
		<input type="Reset" name="reset" value="Reset"   accesskey="r" title="Alt+r"></td>	
		</td></tr>
		</table>
		</form>
   
<%}
	}}
} catch(Exception e)
	{
System.out.println(e);
}%>
</body>
</html>