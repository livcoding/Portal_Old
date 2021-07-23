<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
  <%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
 <% 
/*	' **********************************************************************************************************
	' *													   *
	' * File Name:	RegDisciplinary.ASP		[For Students]						           *
	' * Author:		Ashok Kumar Singh 							           *
	' * Date:		1st Jul 2006						   *
	' * Version:	2.0									   *
	' * Description:	Students Disciplinary  Info. of
	' **********************************************************************************************************
*/
%>
<html>
<head>
<TITLE>#### <%=mHead%> [ Disciplinary  ] </TITLE>
<style fprolloverstyle>A:hover {color: #FF0000; font-size: 14pt; font-weight: bold}
</style>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<% 
String dd1="";
String qry="";
String mMemberID="";
String mMemberType="", mInst="";
String mMemberCode="",mMemberName="",mDMemberCode="";
ResultSet rs=null ;
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();

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
if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}

if(!mMemberID.equals("") && !mMemberType.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
{  //2

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mMacAddress =" "; //session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
	  //-----------------------------
	  //-- Enable Security Page Level  
	  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('210','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
    RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
		
		  //----------------------
		try
		{	
				mDMemberCode=enc.decode(mMemberCode);
				mMemberID=enc.decode(mMemberID);
				mMemberType=enc.decode(mMemberType);
		}
		catch(Exception e)
		{
			out.println(e.getMessage());
		}


			qry = "SELECT ENROLLMENTNO ENROLLMENTNO,STUDENTNAME STUDENTNAME FROM STUDENTMASTER where StudentId='"+mMemberID+ "'";
			//out.print(qry);
			rs=db.getRowset(qry);
			if(rs.next())
			{
			%>
			<br>
			<br>
			<center>
			<FONT color="#a52a2a"  face=Arial size=3>
			<STRONG>Students Disciplinary Action detail </strong><FONT  face=Arial size=2>(taken by Registrar Office if any)</FONT></font>
			<br>
			<font face=Arial size=2 color=black><b><STRONG>Student Name : <%=rs.getString("STUDENTNAME")%>&nbsp;&nbsp;Enrollment No(<%=rs.getString("ENROLLMENTNO")%>)</STRONG></b></font>
			<br>
			</center>
			<%
			}
			%>
			<br>
			<Table border=1 cellspacing=0 align="center" >
			 <tr bgcolor="#c00000" >
			<th nowrap><font color=white face='arial'>Misconduct Date</font></th>
			<th nowrap><font color=white face='arial'>Misconduct</font></th>
			<th nowrap><font color=white face='arial'>Action Date</font></th>
			<th nowrap><font color=white face='arial'>Action Initiated</font></th>
			<th nowrap><font color=white face='arial'>Action Taken</font></th>
			</tr>
				<%
				qry = "SELECT nvl(to_char(ACTIONDATE,'dd-Mon-yyyy'),' ')ACTIONDATE, nvl(MISCONDUCT,' ')MISCONDUCT,";
				qry=qry +" nvl(ACTIONINITIATED,' ')ACTIONINITIATED, nvl(ACTIONTAKEN,' ')ACTIONTAKEN ,";
				qry=qry +" nvl(to_char(MISCONDUCTDATE,'dd-Mon-yyyy'),' ')MISCONDUCTDATE FROM STUDENTDISCIPLINARYACTION  ";
				qry=qry +" where StudentId ='" + mMemberID + "'  order by  MISCONDUCTDATE desc"  ;
				//out.print(qry);
				rs=db.getRowset(qry);
				while(rs.next())
				{
					%>
					<tr>
					<td nowrap>&nbsp; <%=rs.getString(5)%></td> 
					<td ><%=rs.getString(2)%>&nbsp;</td>
					<td nowrap> <%=rs.getString(1)%>&nbsp;</td> 
					<td> <%=rs.getString(3)%></td>
					<td> <%=rs.getString(4)%>&nbsp;</td>
					</tr>
					<%
				}
					%> 
					</table>
					<%
	
//-----------------------------
//-- Enable Security Page Level  
//-----------------------------
	 }
	else
	{
		%>
		<br>
		<font color=red>
		<h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
		<P>	This page is not authorized/available for you.
		<br>For assistance, contact your network support team. 
		</font>	<br>	<br>	<br>	<br> 
		<%
	}
//-----------------------------
}   //2
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
%>
</body>
</Html>




















