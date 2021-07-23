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
int len=0,kk=0;
String mP="";
String mN="";
String mE="";
String mI="";
String pdMemberID="",pdMemberCode="";
String qrye="";
ResultSet rse=null;
String mSTemail="", mQUOTA="";
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
<form name="save" method="post" action="AdminSignUpActionStudXLS.jsp">
<table align=center>
<tr><td><U><FONT face='arial' color=darkbrown size=4>Student Password Creation.</FONT></U>
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
else
	mLoginIDFrSes="asklJ128ADMINaskl";

//out.print(mLogEntryMemberID+" - "+mLoginIDFrSes+" 2 2 "+mLogEntryMemberType);
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

	if(request.getParameter("QUOTA")==null)
	{
		 mQUOTA="";
	}
	else
	{
		 mQUOTA=request.getParameter("QUOTA");
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

	%>
	<INPUT Type="Hidden" Name="pMemberType" id="pMemberType" Value="<%=pMemberType%>">
		<INPUT Type="Hidden" Name="QUOTA" id="QUOTA" Value="<%=mQUOTA%>">
	<INPUT Type="Hidden" Name="RoleName" id="RoleName" Value="<%=pMemberRole%>">
	<INPUT Type="Hidden" Name="ProgramCode" id="ProgramCode" Value="<%=mStr%>">
	<INPUT Type="Hidden" Name="Academicyear" id="Academicyear" Value="<%=mAcademicyear%>">
	<%

	if (mStr.equals(""))
	{
		 qry="select STUDENTID, ENROLLMENTNO, STUDENTNAME, PROGRAMCODE from STUDENTMASTER Where academicyear='"+mAcademicyear+"' and QUOTA= decode('"+mQUOTA+"','ALL',quota,'"+mQUOTA+"')   ";
		 qry=qry+" and INSTITUTECODE='"+mInst+"' and ENROLLMENTNO is not null and nvl(deactive,'N')='N'";
	}
	else
	{
		qry="select STUDENTID, ENROLLMENTNO, STUDENTNAME, PROGRAMCODE from STUDENTMASTER Where ProgramCode IN ("+mStr+") and ";
		qry=qry+" academicyear='"+mAcademicyear+"' and QUOTA= decode('"+mQUOTA+"','ALL',quota,'"+mQUOTA+"')  and ENROLLMENTNO is not null and INSTITUTECODE='"+mInst+"' and nvl(deactive,'N')='N'  ";
	}
	rs=db.getRowset(qry);
	//out.print(qry);
//	int mFlag=0;
	//out.print("9910103401::"+enc.encode("9910103401"));
	%>

	<TABLE cellSpacing=1 cellPadding=1 width="100%" border=1 rules="groups" align=center bordercolor=black>
				<thead>
				<TR >
				<td><FONT face=arial color=black><B>S.No</b></font></td>
				<TD><FONT face=arial color=black><B>Enrollment No./LoginID</FONT></TD>
				<TD><FONT face=arial color=black><B>Password</B></FONT></TD>
				<TD><FONT face=arial color=black><B>Student Name</FONT></TD>
				<TD><FONT face=arial color=black><B>Program Code</FONT></TD>
	<TD><FONT face=arial color=black><B>Academic Year</FONT></TD>
	<TD><FONT face=arial color=black><B>Branchcode</FONT></TD>

				<TR>
				</thead>
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
		//out.print(mI+":"+mE+":"+mN);
		pPassd=mI+mE+mN;
		if(pPassd.equals(""))
			pPassd=" ";
		else
			pPassd=pPassd;

		pPass=enc.encode(pPassd);

		qry1="select ORAID,ORACD FROM MEMBERMASTER WHERE ORATYP='"+pMemberType+"' AND ORAADM='"+pMemberRole+"' ";
		qry1=qry1+" and ORAID='"+pMemberID+"' ";
		//out.print(qry1+";"+pdMemberCode+"<br>");
		rs1=db.getRowset(qry1);
		if(!rs1.next())
		{
			c++;
			qrye="select nvl(STEMAILID,' ')STEMAILID from STUDENTPHONE WHERE STUDENTID='"+pdMemberID+"' AND STEMAILID IS NOT NULL";
			rse=db.getRowset(qrye);
			if(rse.next())
			{
				mSTemail=rse.getString("STEMAILID").trim();
			}
			else
			{
				mSTemail="";
			}
			qryi=" INSERT INTO MEMBERMASTER (ORAID,ORATYP,ORAADM,ORAPW,ORACD,PWD,EMAIL,MEMCODE,MEMNAME)";
			qryi=qryi+"VALUES ('"+pMemberID+"','"+pMemberType+"','"+pMemberRole+"','"+pPass+"','"+pMemberCode+"','"+pPassd+"','"+mSTemail+"','"+pdMemberCode+"','"+mName+"')";
			//out.print(qryi);
			int n=0;
			n=db.insertRow(qryi);
			if(n>0)
			{
			//	db.memberSignp(pMemberID ,pMemberCode , pMemberType  ,pMemberRole , pPass);
				mFlag=1;
				%>
				<!-- <tr><td><b><%=c%></b> &nbsp; LoginID for <%=mName%> Enrollment No <%=pdMemberCode%> created, Password: <%=pPassd%></td></tr> -->


				<!-- <tbody>
				<tr>
					<td align=right><%=c%>.</td>
					<td align=right><%=pdMemberCode%></td>
					<td align=right><%=pPassd%></td>
					<td align=right><%=mName%></td>
				</tr>
				</tbody>
				</table> -->

				<%
			}
			else
			{
				out.print("<font color=red>Error while LoginId creation...</font>");
			}


		}
	}

	if(mFlag==1)
	{
//---- Log Entry
	  	  //-----------------
		db.saveTransLog(mInst,"ADMIN","A","BULK LOGINID CREATION OF STUDENTS", "LoginID Created ", "No MAC Address" , mIPAddress);
		 //-----------------

	}
	//if(c==0)
	//{

		out.print("<center><font face=arial size=2 color=black><b>Login ID of Selected Students are</b></font></center>");
		if (mStr.equals(""))
		{
		 qry="select A.STUDENTID, A.ENROLLMENTNO, A.STUDENTNAME,a.BRANCHCODE, A.PROGRAMCODE, A.academicyear," +
                 "B.PWD from STUDENTMASTER A, MEMBERMASTER b Where A.academicyear='"+mAcademicyear+"' " +
                 "AND B.ORATYP='"+pMemberType+"' AND B.ORAADM='"+pMemberRole+"' ";
		 qry=qry+"and A.INSTITUTECODE='"+mInst+"' and QUOTA=decode('"+mQUOTA+"','ALL',quota,'"+mQUOTA+"')  AND a.ENROLLMENTNO=b.MEMCODE " +
                 "and A.ENROLLMENTNO is not null and nvl(A.deactive,'N')='N' order by ENROLLMENTNO";
		}
		else
		{
		qry="select A.STUDENTID, A.ENROLLMENTNO, A.STUDENTNAME, A.PROGRAMCODE,a.BRANCHCODE," +
                " A.academicyear,B.PWD from STUDENTMASTER A, MEMBERMASTER b Where" +
                " A.ProgramCode IN ("+mStr+") and  a.ENROLLMENTNO=b.MEMCODE AND B.ORATYP='"+pMemberType+"' " +
                "AND B.ORAADM='"+pMemberRole+"' AND  ";
		qry=qry+" A.academicyear='"+mAcademicyear+"'" +
                " and QUOTA=decode('"+mQUOTA+"','ALL',quota,'"+mQUOTA+"')  " +
                "and A.ENROLLMENTNO is not null and A.INSTITUTECODE='"+mInst+"'" +
                " and nvl(A.deactive,'N')='N' order by ENROLLMENTNO";
		}
		rs=db.getRowset(qry);
 //out.print(qry);
		while (rs.next())
		{
			kk++;
			%>

				<tr>
					<td ><%=kk%>.</td>
					<td ><%=rs.getString("ENROLLMENTNO")%></td>
					<td ><%=rs.getString("PWD")%></td>
					<td ><%=rs.getString("STUDENTNAME")%></td>
					<td ><%=rs.getString("PROGRAMCODE")%></td>
								<td ><%=rs.getString("academicyear")%></td>
									<td ><%=rs.getString("BRANCHCODE")%></td>
				</tr>

			<%
		}

	//}


	}
	catch(Exception e)
	{
	//	out.print(qry+"error");
	}
	%>
	<table align=center>
<tr>
<td>
<INPUT TYPE="button" name="Print" Value="Click to Print"  onClick="window.print();">
</td>

<td>
<INPUT TYPE="submit" name="Save" Value="Save in EXCEL"  >
</td>

</tr>
</table>
</form>
	<%
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