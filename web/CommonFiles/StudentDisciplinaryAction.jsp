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
	' * File Name:	DisciplinaryAction.jsp		[For Students]						           *
	' * Author:		Ankur Verma 							           *
	' * Date:		19th SEP 2008						   *
	' * Version:	1.0									   *
	' * Description:	Students Disciplinary Info. 
	' **********************************************************************************************************
*/
%>
<html>
<head>
<TITLE>#### <%=mHead%> [ View Student Disciplinary Action ] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<style fprolloverstyle>A:hover {color: #FF0000; font-size: 14pt; font-weight: bold}
</style>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<% 
String dd1="";
String qry="";
String mMemberID="";
String mMemberType="", mInst="";
String mMemberCode="", mMemberName="", mDMemberCode="", mSID="", mName="";
ResultSet rs=null ;
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();

if (request.getParameter("SID")==null)
{
	mSID="";
}
else
{
	mSID=request.getParameter("SID").toString().trim();
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
if (request.getParameter("INSCODE")==null)
{
	mInst ="";
}
else
{
	mInst =request.getParameter("INSCODE").toString().trim();
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


			qry = "SELECT ENROLLMENTNO ENROLLMENTNO,STUDENTNAME STUDENTNAME FROM STUDENTMASTER where StudentId='"+mSID+"'";
			//out.print(qry);
			rs=db.getRowset(qry);
			if(rs.next())
			{
			%>
			<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
			  <tr>
			   <td align=left><font color="#a52a2a" style="FONT-SIZE: medium"><b>Student Disciplinary Action</b></font>
			   </td>
			   <td align=right><font color=brown><b>Login User :&nbsp; &nbsp;<%=mMemberName%> [Emp. Code: <%=mDMemberCode%>]</b></font>
			   </td>
			  </tr>
			</table>
			<center>
			<FONT color="#a52a2a"  face=Arial size=3>
			<STRONG>View Student Disciplinary Action Detail</strong><br><FONT  face=Arial size=2>(taken by Registrar Office if any)</FONT></font>
			<br>
			<font face=Arial size=2 color=navy><b><STRONG>Student Name : <%=rs.getString("STUDENTNAME")%>&nbsp;&nbsp;Enrollment No : <%=rs.getString("ENROLLMENTNO")%></STRONG></b></font>
			<br>
			</center>
			<%
			}
			%>
			<br>
			<TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="98%" border=1 >
			<thead>
			<tr bgcolor="#c00000">
			 <td><b><font color="White">Misconduct Date</font></b></td>
			 <td><b><font color="White">Misconduct</font></b></td>
			 <td align=center><b><font color="White">Action Date</font></b></td> 
			 <td align=center><b><font color="White">Action Initiated In</font></b></td> 
			 <td align=center><b><font color="White">Action Taken</font></b></td> 
			</tr>
			</thead>
			<tbody>
				<%
				qry = "SELECT nvl(to_char(ACTIONDATE,'dd-Mon-yyyy'),' ')ACTIONDATE, nvl(MISCONDUCT,' ')MISCONDUCT,";
				qry=qry +" nvl(ACTIONINITIATED,' ')ACTIONINITIATED, nvl(ACTIONTAKEN,' ')ACTIONTAKEN ,";
				qry=qry +" nvl(to_char(MISCONDUCTDATE,'dd-Mon-yyyy'),' ')MISCONDUCTDATE FROM STUDENTDISCIPLINARYACTION  ";
				qry=qry +" where StudentId ='" +mSID+ "'  order by  MISCONDUCTDATE desc"  ;
				//out.print(qry);
				rs=db.getRowset(qry);
				while(rs.next())
				{
					%>
					<tr>
					<td align=center><Font face=arial><%=rs.getString(5)%></font></td>
					<td align=left><Font face=arial><%=GlobalFunctions.toTtitleCase(rs.getString(2))%></font></td>
					<td align=center nowrap><Font face=arial><%=rs.getString(1)%></font></td> 
					<td align=center><Font face=arial><%=rs.getString(3)%></font></td>
					<td align=left><Font face=arial><%=GlobalFunctions.toTtitleCase(rs.getString(4))%></font></td>
					</tr>
					<%
				}
				%> 
			</tbody>
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