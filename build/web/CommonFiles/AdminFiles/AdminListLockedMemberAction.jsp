<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ List of Locked Member Action ] </TITLE>

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

</head>

<%

DBHandler db=new DBHandler();
//GlobalFunctions gb =new GlobalFunctions();
		OLTEncryption enc=new OLTEncryption();
String qry="";
String qry1="",mLTP="",myLTP="", qry2="";
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
int mSNO=0;
ResultSet rs=null,rs1=null;
ResultSet RsFSTID=null;
ResultSet RsChk2=null;
int More=1;
int mLevel=0;
String mInst="";
String minst="",mDEmpID="";
String mEmpID="";
String mType="",mType1="",mType2="",mEmpCD="";
String mName1=""	,mName2="",mSID="",mEC="",mName3="";


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
%>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<center><font size=4>Member Status </font></center>
<hr>
<table border=1 cellpadding=3 cellspacing=1 rules="All" align=center>
<tr bgcolor=ff8c00>

<td><b>Member Name</b></td>
<td><b>Member Type</b></td>
<td><b>Status</b></td>
</tr>
<%
try 
{  //1

// For Log Entry Purpose
//--------------------------------------
String mLogEntryMemberID="",mLogEntryMemberType="";

if (session.getAttribute("BASELOGINID")==null || session.getAttribute("BASELOGINID").toString().trim().equals(""))
	mLogEntryMemberID="";
else
	mLogEntryMemberID=session.getAttribute("BASELOGINID").toString().trim();

if (session.getAttribute("BASELOGINTYPE")==null || session.getAttribute("BASELOGINTYPE").toString().trim().equals(""))
	mLogEntryMemberType="";
else
	mLogEntryMemberType=session.getAttribute("BASELOGINTYPE").toString().trim();

if (!mLogEntryMemberType.equals(""))
	mLogEntryMemberType=enc.decode(mLogEntryMemberType);

if (!mLogEntryMemberID.equals(""))
	mLogEntryMemberID=enc.decode(mLogEntryMemberID);

//--------------------------------------
String mIPAddress=session.getAttribute("IPADD").toString().trim();

	if(mLogEntryMemberID.equals("asklADMINaskl") && mLogEntryMemberType.equals("A")) 
	{
  //----------------------
		/*
		mDMemberCode=enc.decode(mMemberCode);
		mMemberID=enc.decode(mMemberID);
		mMemberType=enc.decode(mMemberType);
		*/
	int  mTotalRec = 0;
	String mApproved="";
	
	String mEName=" ";
	int kk=0;
		
	if (request.getParameter("TotalRec")!=null && Integer.parseInt(request.getParameter("TotalRec").toString().trim())>0)
	{  //3
	mTotalRec =Integer.parseInt(request.getParameter("TotalRec").toString().trim());
	for (kk=1;kk<=mTotalRec ;kk++)
	{

		
		mName1="MID"+String.valueOf(kk).trim();
		mName2="ACTIVE"+String.valueOf(kk).trim();
		mName3="EC"+String.valueOf(kk).trim();
	
		if (request.getParameter(mName1)==null)
			mEmpID= "";
		else
			mEmpID= request.getParameter(mName1);

		if (request.getParameter(mName3)==null)
			mEmpCD= "";
		else
			mEmpCD=request.getParameter(mName3);

			mInst=request.getParameter("INSTITUTE");

		if (request.getParameter(mName2)==null || request.getParameter(mName2).equals(""))
			mApproved= "N";
		else
			mApproved="Y";
		mType=request.getParameter("TYPE");
		
		if(mType.equals("S"))
		 mType1="Student";
		else if(mType.equals("E"))
		mType1="Employee";
		else if(mType.equals("G"))
		mType1="Guest";
		else
		mType1="Visiting";
		
		mDEmpID=enc.decode(mEmpID);
		mType2=enc.encode(mType);

		if(mApproved.equals("Y"))
		{
		qry="update membermaster set deactive='N' where ";
		qry=qry+" oraid='"+mEmpID+"' and oratyp='"+mType2+"' "; 
		int n=db.update(qry);	
//---- Log Entry
	  	  //-----------------
db.saveTransLog(mInst,"ADMIN","A","UNLOCK WEBKIOSK MEMBER", "Unlock Member ,Member Code : "+mEmpCD+" Member Type :"+mType, "No MAC Address" , mIPAddress);
		 //-----------------
	qry="Select WEBKIOSK.getMemberName('"+mDEmpID+"','"+mType+"') SL from dual" ;
	 RsChk2= db.getRowset(qry);
	//out.print(qry);
	 if(RsChk2.next())
	{
		 mSID=RsChk2.getString(1);	


	}

		%>
			<tr>
			<td><%=GlobalFunctions.toTtitleCase(mSID)%></td>
			<td><%=mType1%></td>
			<td><font color=green>UnLock</font></td>
			</tr>
			
		<%	
	     }
		else
		{
qry="Select WEBKIOSK.getMemberName('"+mDEmpID+"','"+mType+"') SL from dual" ;
	 RsChk2= db.getRowset(qry);
	 if(RsChk2.next())
	{
		 mSID=RsChk2.getString(1);	
	}

		%>
		<tr>
	
		<td><%=GlobalFunctions.toTtitleCase(mSID)%></td>
		<td><%=mType1%></td>
		<td><font color=red>Locked</font></td>
		</tr>
<%
	}
	} //closing of for
 %>
	</table>
<%
	
 	} //3
	else
	{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Please select approved check box to unlock the respective member!</font> <br>");
	}
 //-----------------------------

}  //2
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
}	//1	
catch(Exception e)
{
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>No Item Selected...</font> <br>");
}
%>
<table ALIGN=Center VALIGN=TOP>
		<tr>
		<td valign=middle>
		<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">
		<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
		A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
		</td></tr></table>
</body>
</html>