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
<TITLE>#### <%=mHead%> [ WEBKIOSK Member Login Action ] </TITLE>
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
</script>

<script>
	if(window.history.forward(1) != null)
	window.history.forward(1);
</script>

</head>

<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%

DBHandler db=new DBHandler();
ResultSet rs=null;
OLTEncryption enc=new OLTEncryption();
String qry="";
String qry1="";
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
int mSNO=0;
String mInst="";
String minst="";
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

try 
{  //1
if(!mMemberID.equals("") && !mMemberType.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
{  //2

if(request.getParameter("EmpPwd").toString().trim().length()>=mMinPWD && request.getParameter("EmpPwd").toString().trim().length()<=mMaxPWD )
{	
try
	{	 
	mDMemberCode=enc.decode(mMemberCode);
	pMemberType=enc.encode("E");
	pMemberRole =enc.encode(request.getParameter("RoleName").toString().trim());
	pPass=enc.encode(request.getParameter("EmpPwd").toString().trim());
	int c=0;

	String mChkAllEmployee =request.getParameter("ChkAllEmployee");
	String mStr="";
	if (mChkAllEmployee.equals("S"))
		{
		String [] mDept=request.getParameterValues("DepartmentCode");
		for (int i=0;i<mDept.length;i++)
			{
			if(mStr.equals(""))
				mStr="'"+mDept[i]+"'";
			else
				mStr=mStr+",'"+mDept[i]+"'";
			}		
		}
	if (mStr.equals(""))
		{
		 qry="select EmployeeID, EmployeeCode, EmployeeNAME from EmployeeMASTER";
		 qry=qry+" Where nvl(deactive,'N')='N'";
		}
	else
		{
		qry="select EmployeeID, EmployeeCode, EmployeeNAME from EmployeeMASTER";
		qry=qry+" Where DepartmentCode IN ("+mStr+") and nvl(deactive,'N')='N'";
		}
	rs=db.getRowset(qry);
	
	while (rs.next())
	{
	c++;
	pMemberID =rs.getString("EmployeeID");
	pMemberCode =rs.getString("EmployeeCode");
	mName=rs.getString("EmployeeNAME");
	%>
	<br><b><%=c%></b> &nbsp; LoginID for <%=mName%> Employee Code <%=pMemberCode %> created..
	<%
	pMemberID =enc.encode(pMemberID);
	pMemberCode=enc.encode(pMemberCode);
 	db.memberSignp(pMemberID ,pMemberCode , pMemberType  ,pMemberRole , pPass);
	}
	}
	catch(Exception e)
	{
		out.println(e.getMessage());
	}
}
else
{
out.print("<br><img src='../../Images/Error1.jpg'>");
out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Password length must be between "+mMinPWD+ " and " +mMaxPWD +" </font> <br>");
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