<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%

DBHandler db=new DBHandler();
ResultSet rs=null;
OLTEncryption enc=new OLTEncryption();
String qry="";
String qry1="";
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
int mSNO=0;
String mInst="";
String minst="", mAcademicyear="";
String mName1=""	,mName2="",mName3="",mName4="",mName5="";
String pMemberID="" ,pMemberCode="" , pMemberType=""  ,pMemberRole="" , pPass="", mName="";
int mMaxPWD=20;
int mMinPWD=5;




if (session.getAttribute("MinPasswordLength")==null)
{
	mMinPWD=5;
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
<html>
<head>
<title>SRS for Approval</title>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
try 
{  //1
if(!mMemberID.equals("") && !mMemberType.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
{  //2

if(request.getParameter("StdPwd").toString().trim().length()>=mMinPWD && request.getParameter("StdPwd").toString().trim().length()<=mMaxPWD )
{	
	try
	{	 
	mDMemberCode=enc.decode(mMemberCode);
	pMemberType=enc.encode("S");
	pMemberRole =enc.encode(request.getParameter("RoleName").toString().trim());
	pPass=enc.encode(request.getParameter("StdPwd").toString().trim());
	int c=0;

	String mChkAllSudent=request.getParameter("ChkAllSudent");
	String mStr="";

	
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
	
	if (mStr.equals(""))
		{
		 qry="select STUDENTID, ENROLLMENTNO, STUDENTNAME, PROGRAMCODE from STUDENTMASTER";
		 qry=qry+" Where nvl(deactive,'N')='N'";
		}
	else
		{
		qry="select STUDENTID, ENROLLMENTNO, STUDENTNAME, PROGRAMCODE from STUDENTMASTER";
		qry=qry+" Where ProgramCode IN ("+mStr+") and nvl(deactive,'N')='N'";
		}
	rs=db.getRowset(qry);
	
	while (rs.next())
	{
	c++;
	pMemberID =rs.getString("STUDENTID");
	pMemberCode =rs.getString("ENROLLMENTNO");
	mName=rs.getString("STUDENTNAME");
	%>
	<br><b><%=c%></b> &nbsp; LoginID for <%=mName%> Enrollment No <%=pMemberCode %> created..
	<%
	pMemberID =enc.encode(pMemberID);
	pMemberCode=enc.encode(pMemberCode);
 	db.memberSignp(pMemberID ,pMemberCode , pMemberType  ,pMemberRole , pPass);
	}
	
	}
	catch(Exception e)
	{
		
	}
}
else
{
out.print("<br><img src='../../Images/Error1.jpg'>");
out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Password length must be between "+mMinPWD+ " to " +mMaxPWD +" </font> <br>");
out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'><a href='SignUpMemberBulk.jsp'><img src='../../Images/Back.jpg' border=0></a></font> <br>");

}

}  //2
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
}	//1	
catch(Exception e)
{
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