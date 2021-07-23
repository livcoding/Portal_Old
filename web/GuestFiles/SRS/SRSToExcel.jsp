<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*" %>
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
<TITLE>#### <%=mHead%> [Student Reaction Survey Report]</TITLE>



<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%

try
{
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();
String qry="",qry1="",qry3="",qryc="";
ResultSet rs=null,rs1=null,rsc=null;
String  mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="";
String mInst="";
String mPCode="",mpcode="";
String mECode="",mecode="";
int aa=0;
int msno=0;
int start=0;
int last=0;
int count=0;

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





if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
  {
	mDMemberCode=enc.decode(mMemberCode);
	mDMemberType=enc.decode(mMemberType);
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;


  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
    qry="Select WEBKIOSK.ShowLink('140','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
    RsChk= db.getRowset(qry);
    if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
	  //----------------------	  
	 
	qry="Select Distinct NVL(INSTITUTECODE,' ')IC from v#SRSEVENTS WHERE nvl(deactive,'N')='N' ";
	rs=db.getRowset(qry);
	while(rs.next())
	{
		mInst=rs.getString("IC");
	}

	String mProgCode="",mExamCode="";
	if(request.getParameter("PC")==null)
	{
		mProgCode="ALL";
	}
	else
	{
		mProgCode=request.getParameter("PC").toString().trim();
	}
	if(request.getParameter("EX")==null)
	{
		mExamCode="";
	}
	else
	{
		mExamCode=request.getParameter("EX").toString().trim();
	}

	%>
	<START OF FILE>
	<%@page contentType="text/html"%>
   	<%
	response.setContentType("application/vnd.ms-excel");
	  %>

	<Center><font color=blue size=3 face='Verdana'>Students SRS Submition/Left Status for ExamCode:<%=mExamCode%> Program Code:<%=mProgCode%></font><Center>
	<Table Align="center" rules="Rows" cellSpacing=1 cellPadding=1  border=1 >
	<Thead>
	<TR bgcolor="#c00000">
	<TD><b><font color="white">SNo.</font></td>
	<TD><b><font color="white">Enrollment No.</font></td>
	<TD><b><font color="white">Student Name</font></td>
	<Td><b><font color="white">Program Code</font></td>
	<TD><b><font color="white">No.of Reg.<br>Subject</font></td>
	<TD><b><font color="white">Total SRS <br>to be Sent</font></td>	
	<TD><b><font color="white">SRS sent </font></td>
	</TR>
	</Thead>

<TBody>
<%
qryc="select  count(distinct studentid ) count from V#STUDENTLTPDETAIL where institutecode='"+mInst+"' ";
qryc=qryc+" and examcode=decode('"+mExamCode+"','ALL',examcode,'"+mExamCode+"') and Programcode=decode('"+mProgCode+"','ALL',programcode,'"+mProgCode+"') and nvl(DEACTIVE,'N')='N' ";
rsc=db.getRowset(qryc);
while(rsc.next())
{
	String c1=rsc.getString(1);
	count=Integer.parseInt(c1);
}

qry="select studentname,studentid,nvl(enrollmentno,'')enrollmentno,count(distinct subjectcode)cntsubj, ";
qry=qry+" count(employeecode)cntemp , Programcode   from V#STUDENTLTPDETAIL where institutecode='"+mInst+"' ";
qry=qry+" and examcode=decode('"+mExamCode+"','ALL',examcode,'"+mExamCode+"') and Programcode=decode('"+mProgCode+"','ALL',programcode,'"+mProgCode+"') and nvl(DEACTIVE,'N')='N' ";
qry=qry+" group by enrollmentno,studentname ,studentid,Programcode ";
rs=db.getRowset(qry);
msno=0;
while(rs.next())
{
	msno++;
	qry1="select count(subjectcode)cnt from V#SRSEVENTSUGGESTION where institutecode='"+mInst+"'  ";
	qry1=qry1+" and examcode=decode('"+mExamCode+"','ALL',examcode,'"+mExamCode+"') and programcode=decode('"+mProgCode+"','ALL',programcode,'"+mProgCode+"') and studentid='"+rs.getString("studentid")+"' ";
	rs1=db.getRowset(qry1);	
	if(rs1.next())	
	  aa=rs1.getInt("cnt");	
	else
	  aa=0;
	
	%>
	<tr>
		<td><%=msno%></td>
		<td><%=rs.getString("enrollmentno")%></td>
			<td><%=rs.getString("studentname")%></td>
			<td><%=rs.getString("Programcode")%></td> 
			<td><%=rs.getString("cntsubj")%></td>
			<td><%=rs.getString("cntemp")%></td>
			<td><%=aa%></td>
	</tr>
	<%
} // closing of while

%>
</tbody>
</table>
<END OF FILE>
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
	<h3><br><img src='../../Images/Error1.jpg'>Access Denied (authentication_failed)</h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font><br><br><br><br>
   <%
   }
  //-----------------------------

} // closing of if(!mMemberID.equals(""))
 //-----------------------------
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}    
} // closing of try
catch(Exception e)
{
	//out.print(e);
}
%>