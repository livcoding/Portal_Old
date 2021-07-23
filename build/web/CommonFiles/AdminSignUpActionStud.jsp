<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../CommonFiles/ExceptionHandler.jsp" %> 
<%    
try 
{  //1
DBHandler db=new DBHandler();
String qryi="";
ResultSet rs=null;
ResultSet rs1=null;
OLTEncryption enc=new OLTEncryption();
String qry="";
String qry1="";
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
int mSNO=0;
String pPassd="";
String minst="", mAcademicyear="";
String mName1=""	,mName2="",mName3="",mName4="",mName5="",mInst="";
String pMemberID="" ,pMemberCode="" , pMemberType=""  ,pMemberRole="" , pPass="", mName="";
int mMaxPWD=20;
int mMinPWD=4;
int mFlag=0;
String qryt="",mTs="";
ResultSet rst=null;
int len=0;
String mP="";
String mN="";
String mE="";
String mI="";
String pdMemberID="",pdMemberCode="";
String qrye="";
ResultSet rse=null;
String mSTemail="";
/*
if (session.getAttribute("MinPasswordLength")==null)
{
	mMinPWD=4;
}
else
{
	mMinPWD=Integer.parseInt(session.getAttribute("MinPasswordLength").toString().trim());
}

if (session.getAttribute("MaxPasswordLength")==null)
{
	mMaxPWD=20;
}
else
{
	mMaxPWD=Integer.parseInt(session.getAttribute("MaxPasswordLength").toString().trim());
}
*/

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
if (session.getAttribute("BASEINSTITUTECODE")==null)
{
	mInst="JIIT";
}
else
{
	mInst=session.getAttribute("BASEINSTITUTECODE").toString().trim();
}
	String mHead="";
	if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
		   mHead=session.getAttribute("PageHeading").toString().trim();
	else
		   mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Student Signup Action ] </TITLE> 
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<table align=center> 
<tr><td><U><FONT face='arial' color=darkbrown size=4>Status of StudentID Creation.</FONT></U>
</td></tr>
</table>
<hr>
<!--Institute-->
<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
<%
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

	{ //2

//if(request.getParameter("StdPwd").toString().trim().length()>=mMinPWD && request.getParameter("StdPwd").toString().trim().length()<=mMaxPWD )
//{	
	try
	{	 
	// mDMemberCode=enc.decode(mMemberCode);
	pMemberType=enc.encode("S");

	pMemberRole =enc.encode(request.getParameter("RoleName").toString().trim());
	// pPass=enc.encode(request.getParameter("StdPwd").toString().trim());
	int c=0;
	

	String mChkAllSudent=request.getParameter("ChkAllSudent");
	String mStr="";

if(request.getParameter("Academicyear")==null)
{	
	 mAcademicyear="";
}	
else
{	
	 mAcademicyear=request.getParameter("Academicyear");
}
	
	if (mChkAllSudent.equals("S"))
	{
		String [] mProg=request.getParameterValues("ProgramCode");
		for (int i=0;i<mProg.length;i++)
		{
			if(mStr.equals(""))
				mStr="'"+mProg[i]+"'";
			else
				mStr=mStr+",'"+mProg[i]+"'";
		}		
	}

	String mAcYr=mAcademicyear.substring(0,2);
	if (mStr.equals(""))
	{
		qry="select STUDENTID, ENROLLMENTNO, STUDENTNAME, PROGRAMCODE from STUDENTMASTER";
		qry=qry+" Where academicyear='"+mAcademicyear+"' and INSTITUTECODE='"+mInst+"' and nvl(deactive,'N')='N'";
		qry=qry+" and enrollmentno  like '"+mAcYr+"%'";
	}
	else
	{
		qry="select STUDENTID, ENROLLMENTNO, STUDENTNAME, PROGRAMCODE from STUDENTMASTER";
		qry=qry+" Where ProgramCode IN ("+mStr+") and academicyear='"+mAcademicyear+"'";
		qry=qry+" and INSTITUTECODE='"+mInst+"' and nvl(deactive,'N')='N' and enrollmentno like '"+mAcYr+"%'";
	}
	//out.print(qry);
	rs=db.getRowset(qry);

//	int mFlag=0;
	%>
	<table align=center width=100%>
	<%
	while(rs.next())
	{		
		pdMemberID =rs.getString("STUDENTID");
		pdMemberCode =rs.getString("ENROLLMENTNO");
		mName=rs.getString("STUDENTNAME");

		pMemberID =enc.encode(pdMemberID);
		pMemberCode=enc.encode(pdMemberCode);

		//len=pMemberID.length();
		mN=mName.substring(0,4);
		mE=pdMemberCode.substring(pdMemberCode.length()-3);
		mI=pdMemberID.substring(pdMemberID.length()-3);
		pPassd=mN;
		pPass=enc.encode(pPassd);

		qry1="select ORAID,ORACD FROM MEMBERMASTER WHERE ORATYP='"+pMemberType+"' AND ORAADM='"+pMemberRole+"' ";
		qry1=qry1+" and ORAID='"+pMemberID+"' ";
    //out.print(qry1);
		rs1=db.getRowset(qry1);
		if(rs1.next()==false)
		{		
			c++;	
	qrye="select nvl(STEMAILID,' ')STEMAILID from STUDENTPHONE WHERE STUDENTID='"+pdMemberID+"' AND STEMAILID IS NOT NULL  ";
	rse=db.getRowset(qrye);
	if(rse.next())
	{
		mSTemail=rse.getString("STEMAILID").trim();
	}
	else
	{
		mSTemail="";
	}

qryi=" INSERT INTO MEMBERMASTER (ORAID,ORATYP,ORAADM,ORAPW,ORACD,PWD,EMAIL)";
qryi=qryi+"VALUES ('"+pMemberID+"','"+pMemberType+"','"+pMemberRole+"','"+pPass+"','"+pMemberCode+"','"+pPassd+"','"+mSTemail+"')";
int n=db.insertRow(qryi);
if(n>0)
{
		//	db.memberSignp(pMemberID ,pMemberCode , pMemberType  ,pMemberRole , pPass);
			mFlag=1;
			%>
			<tr><td><b><%=c%> &nbsp; LoginID for <%=mName%> Enrollment No <%=pdMemberCode%> created, Password: <%=pPassd%></b></td></tr>
			<%
}
else
{
out.print("<font color=red>Error while LoginId creation...</font>");
}
		}		
	}
	%>
	</table>
	<%
	if(mFlag==1)
	{
//---- Log Entry
	  	  //-----------------
db.saveTransLog(mInst,"ADMIN","A","BULK LOGINID CREATION OF STUDENTS", "LoginID Created ", "No MAC Address" , mIPAddress);
		 //-----------------

	}
	if(c==0)
	{
	out.print("Login ID of Select Students Already exist.....");
	}
			
	}
	catch(Exception e)
	{
	//	out.print(qry+"error");	
	}
/*}
else
{
out.print("<br><img src='../../Images/Error1.jpg'>");
out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Password length must be between "+mMinPWD+ " to " +mMaxPWD +" </font> <br>");
out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'><a href='SignUpStudents.jsp'><img src='../../Images/Back.jpg' border=0></a></font> <br>");

}*/

}  //2
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
}	//1	
catch(Exception e)
{
//out.print("dddd");

}





%><br><br><hr>
<table ALIGN=Center VALIGN=TOP>
		<tr>
		<td valign=middle>
		<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">
		<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
		A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
			</td></tr></table>
</body>
</html>