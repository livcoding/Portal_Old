<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../CommonFiles/ExceptionHandler.jsp" %> 
<%  
/*
	' **********************************************************************************************************
	' *															*
	' * File Name:	AdminMigrateStudPass.JSP		[For Employee]				*
	' * Author:		Vijay Kumar 						         			*
	' * Date:		3rd Aug 2009	 							   		*
	' * Version:	1.0									   			*	
	' **********************************************************************************************************
*/

String qry="";
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();
ResultSet rs1=null, rs2=null, rs3=null;

String mMemberID="",mMemberType="",mMemberCode="",mAcad="",mPass="",macad="",mRole="", mInst="";
String mAcadYear="'0910'";
int mMaxPWD=20;
int mMinPWD=5;
try
{
	if (session.getAttribute("BASEINSTITUTECODE")==null)
		mInst="JIIT";
	else
		mInst=session.getAttribute("BASEINSTITUTECODE").toString().trim();

	if (session.getAttribute("MinPasswordLength")==null)
		mMinPWD=5;
	else
		mMinPWD=Integer.parseInt(session.getAttribute("MinPasswordLength").toString().trim());

	if (session.getAttribute("MaxPasswordLength")==null)
		mMaxPWD=20;
	else
		mMaxPWD=Integer.parseInt(session.getAttribute("MaxPasswordLength").toString().trim());
}
catch(Exception e)
{
	mMaxPWD=20;
	mMinPWD=4;
}

if (session.getAttribute("MemberCode")==null)
	mMemberCode="";
else
	mMemberCode=session.getAttribute("MemberCode").toString().trim();

if (session.getAttribute("MemberID")==null)
	mMemberID="";
else
	mMemberID=session.getAttribute("MemberID").toString().trim();

if (session.getAttribute("MemberType")==null)
	mMemberType="";
else
	mMemberType=session.getAttribute("MemberType").toString().trim();

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<TITLE>#### <%=mHead%> [ Migrate Student password in bulk from Internet Access to Webkiosk Access] </TITLE>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</HEAD>
<BODY bgcolor="#fce9c5" rightmargin=5 leftmargin=1 topmargin=1 bottommargin=0 scroll=auto>
<% 
try
{
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
	int ctr1=0, ctr2=0;
	String mMemCode="", mOraCode="", mMemName="", mOraName="", mMemPass="", mOraPass="", mMemID="", mOraID="", mOraTyp="", mOraAdm="";
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
	{
		%>
		<center><U><FONT face='arial' color=darkbrown size=4>Migrate Student Passowrd</FONT></U>
		<%
//==============================================
		//qry="select ENROLLMENTNO, '1234' PASSWORD from STUDENTMASTER where ENROLLMENTNO LIKE '09%' AND ACADEMICYEAR IN ("+mAcadYear+") AND nvl(DEACTIVE,'N')='N'";
		//qry+=" AND ENROLLMENTNO NOT IN (select ENROLLMENTNO from TMP#LOGINPWD where nvl(DEACTIVE,'N')='N')";
		//qry+=" UNION ALL";
		qry=" select ENROLLMENTNO, PASSWORD from TMP#LOGINPWD where nvl(UPDATIONSTSTUS,'N')='N' AND nvl(DEACTIVE,'N')='N'";
		rs1=db.getRowset(qry);
		//out.print(qry);
		while(rs1.next())
		{
			mMemCode=rs1.getString("ENROLLMENTNO");
			mOraCode=enc.encode(mMemCode.trim());
			mMemPass=rs1.getString("PASSWORD");
			mOraPass=enc.encode(mMemPass.trim());
			qry="Select 'Y' from MEMBERMASTER where ORACD='"+mOraCode+"'";
			//out.print(qry);
			rs2=db.getRowset(qry);
			if(rs2.next())
			{
				qry="UPDATE MEMBERMASTER SET ORAPW='"+mOraPass+"' WHERE ORACD='"+mOraCode+"'";
				int a=db.update(qry);
				//out.print(qry);
				ctr1++;
			}
			else
			{
				qry="SELECT STUDENTID, STUDENTNAME FROM STUDENTMASTER WHERE ENROLLMENTNO='"+mMemCode+"' AND NVL(DEACTIVE,'N')='N'";
				rs3=db.getRowset(qry);
				//out.print(qry);
				if(rs3.next())
				{
					mMemID=rs3.getString("STUDENTID");
					mOraID=enc.encode(mMemID.trim());
					mMemName=rs3.getString("STUDENTNAME");
					mOraName=enc.encode(mMemName.trim());
					mOraTyp=enc.encode("S");
					mOraAdm=enc.encode("STUD");

					qry="INSERT INTO MEMBERMASTER (ORAID, ORATYP, ORAADM, ORAPW, ORACD, FIRSTLOGIN, PWD, MEMCODE, MEMNAME, NETFIRSTLOGIN)";
					qry+="VALUES ('"+mOraID+"','"+mOraTyp+"','"+mOraAdm+"','"+mOraPass+"','"+mOraCode+"','Y','"+mMemPass+"','"+mMemCode+"','"+mMemName+"','Y')";
					int aa=db.insertRow(qry);
					//out.print(qry);
					ctr2++;
				}
			}
		}
		%>
		<LEFT>
		<%
		if(ctr1>0 && ctr2>0)
		{
			%><BR><BR><font color=green face=verdana size=4>Total <%=ctr1%> old records updated while <%=ctr2%> new records inserted</font><%
		}
		else if(ctr1==0 && ctr2>0)
		{
			%><BR><BR><font color=green face=verdana size=4>Total <%=ctr2%> new records inserted</font><%
		}
		else if(ctr1>0 && ctr2==0)
		{
			%><BR><BR><font color=green face=verdana size=4>Total <%=ctr1%> old records updated</font><%
		}
		%>
		</LEFT>
		<%

//==============================================
	}
	else
	{
		out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}
}
catch(Exception e)
{
//out.print("abcd"+qry);
}
%>
<hr><table ALIGN=Center VALIGN=TOP>
<tr>
<td valign=middle>
<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">	<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT>
</td>
</tr>
</table>
</body>
</html>