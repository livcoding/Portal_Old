<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
String qryi="";
ResultSet rs=null;
ResultSet rs1=null;
OLTEncryption enc=new OLTEncryption();
String qry="";
String qry1="";
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
int mSNO=0;
//String mInst="";
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


String mINSTITUTECODE="";
if (session.getAttribute("InstituteCode")==null)
	{
		mINSTITUTECODE="";
	}
	else
	{
		mINSTITUTECODE=session.getAttribute("InstituteCode").toString().trim();
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
<%
		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mRole1=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk1=null;
		  //-----------------------------
		  //-- Enable Security Page Level  
		  //-----------------------------
		qry="Select WEBKIOSK.ShowLink('0','"+ mChkMemID+"','"+mChkMType+"','"+mRole1+"','"+ mIPAddress +"') SL from dual";
      	RsChk1= db.getRowset(qry);
		if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
		   {


try 
{  //1
if(!mMemberID.equals("") && !mMemberType.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
{  //2
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
	
	if (mStr.equals(""))
		{
		 qry="select STUDENTID, ENROLLMENTNO, STUDENTNAME, PROGRAMCODE from STUDENTMASTER";
		 qry=qry+" Where InstituteCode='"+mINSTITUTECODE+"' And academicyear='"+mAcademicyear+"' and nvl(deactive,'N')='N'";
		}
	else
		{
		qry="select STUDENTID, ENROLLMENTNO, STUDENTNAME, PROGRAMCODE from STUDENTMASTER";
		qry=qry+" Where institutecode='"+mINSTITUTECODE+"' And ProgramCode IN ("+mStr+") and academicyear='"+mAcademicyear+"' and nvl(deactive,'N')='N'";
		}
	rs=db.getRowset(qry);
	//int mFlag=0;
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
mN=mName.substring(1,3);
mE=pdMemberCode.substring(pdMemberCode.length()-3);
mI=pdMemberID.substring(pdMemberID.length()-3);
//pPassd=mI+mE+mN;
pPassd=pdMemberCode;
pPass=enc.encode(pPassd);

		qry1="select ORAID,ORACD FROM MEMBERMASTER WHERE ORATYP='"+pMemberType+"' AND ORAADM='"+pMemberRole+"' ";
		qry1=qry1+" and ORAID='"+pMemberID+"' ";
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
			<tr><td><b><%=c%></b> &nbsp; LoginID for <%=mName%> Enrollment No <%=pdMemberCode%> created...</td></tr>
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
	out.print("<br><img src='../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
}	//1	
catch(Exception e)
{
}


//-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
  }
  else
   {
   %>
	<br>
	<font color=red>
	<h3>	<br><img src='../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font>	<br>	<br>	<br>	<br>
   <%
	
	
   }
  //-----------------------------
%><br><br><hr>
<table ALIGN=Center VALIGN=TOP>
		<tr>
		<td valign=middle>
		<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../Images/CampusConnectLogo.bmp">
		<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
		A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
			</td></tr></table>
</body>
</html>