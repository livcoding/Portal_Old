<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null,rsi=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="", qry1="";
String mMemberID="";
String mMemberType="";
String mMemberName="";
String mMemberCode="",mInstitute="",mDMemberCode="",mWebEmail="";
int mSems=0;
int mFlag=0;	
String mAcad="";
if (session.getAttribute("WebAdminEmail")==null)
{
	mWebEmail="";
}
else
{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
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
<TITLE>#### <%=mHead%> [Student CGPA Report]</TITLE>
<script type="text/javascript" src="../js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="../css/sortabletable.css" />


<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 background="../../Images/Speciman.jpg">
<%
try
{
	OLTEncryption enc=new OLTEncryption();
	if(!mMemberID.equals("") && !mMemberCode.equals("")) 
	{
	mDMemberCode=enc.decode(mMemberCode);
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------

	qry="Select AcademicYear from StudentMaster where Studentid='"+mChkMemID+"'";	
      RsChk= db.getRowset(qry);
	if (RsChk.next())
	{mAcad=RsChk.getString(1);   
	}
	
	qry="Select WEBKIOSK.ShowLink('138','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
  //----------------------
%>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD colspan=0 align=middle ><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Student SGPA/CGPA Report</b></font></td>
</tr>
</TABLE>
<%
String mSnm="", mENo="";
int mSem=0;
qry="select StudentName, Enrollmentno ,semester from StudentMaster where StudentID='"+mChkMemID+"'";
rs1=db.getRowset(qry);
if(rs1.next())
{
mSnm=rs1.getString(1);
mENo=rs1.getString(2);
mSem=rs1.getInt(3);	
}

qry1="Select Distinct NVL(INSTITUTECODE,' ')InstCode from institutemaster WHERE nvl(Deactive,'N')='N' ";
		rsi=db.getRowset(qry1);
		if(rsi.next())
			mInstitute=rsi.getString(1);	
		else
			mInstitute="JIIT";

%>
<table rules=NONE cellspacing=1 cellpadding=1 align=center border=1>
<tr>
<td align=center><font color="#00008b"><B>Student Name : </B><%=GlobalFunctions.toTtitleCase(mSnm)%> [<%=mENo%>]</font></TD>
<TD align=center><font color="#00008b"><b>&nbsp; &nbsp; Current Semester : </b>&nbsp;<%=mSem%></font></td>
</tr>
</table>
<BR>
<TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="70%" border=1 >
<thead>
 <tr bgcolor="#ff8c00"> 
 <td Title="Click on Semester to Sort" align=center><b><font color="White">Semester</font></b></td>
 <td Title="Click on Grade Points to Sort"><b><font color="White">Grade Points</font></b></td> 
 <td Title="Click on CourseCredits to Sort"><b><font color="White">Course Credit</font></b></td> 
 <td Title="Click on Earned Credit to Sort"><b><font color="White">Earned Credit</font></b></td> 
 <td Title="Click on Point Secured CGPA to Sort"><b><font color="White">Points Secured<br>SGPA</font></b></td> 
 <td Title="Click on Point Secured CGPA to Sort"><b><font color="White">Points Secured<br>CGPA</font></b></td> 
 <td Title="Click on CGPA to Sort" align=center><b><font color="White">SGPA</font></b></td> 
 <td Title="Click on CGPA to Sort" align=center><b><font color="White">CGPA</font></b></td> 
</tr>
</thead>
<tbody>
<%
	qry="select SEMESTER,TOTALGRADEPOINTS,TOTALCOURSECREDIT, ";
	qry=qry+" TOTALEARNEDCREDIT,TOTALPOINTSECUREDSGPA,TOTALPOINTSECUREDCGPA,SGPA SGPA,CGPA CGPA FROM ";
	qry=qry+" STUDENTSGPACGPA#Pub WHERE institutecode='"+mInstitute+"' and  STUDENTID='"+mChkMemID+"' ";
	//out.print(qry);
	rs1=db.getRowset(qry);

	while(rs1.next())
	{
	mSems=rs1.getInt("SEMESTER");	
	  %>
	<tr>
	<td align=center><A Href='AcademicDetSem.jsp?Semester=<%=rs1.getInt("SEMESTER")%>&SGP=<%=rs1.getDouble("SGPA")%>&CGP=<%=rs1.getDouble("CGPA")%>'><%=rs1.getInt("SEMESTER")%></a></td>
	<td><%=rs1.getDouble("TOTALGRADEPOINTS")%></td>
	<td><%=rs1.getDouble("TOTALCOURSECREDIT")%></td>
	<td><%=rs1.getDouble("TOTALEARNEDCREDIT")%></td>
	<td><%=rs1.getDouble("TOTALPOINTSECUREDSGPA")%></td>
	<%
	if (mAcad.equals("0809"))
	{
	%>
	<td>&nbsp;</td>
	<%
	}
	else
	{
	%>
	<td><%=rs1.getDouble("TOTALPOINTSECUREDCGPA")%></td>
	<%
	}
	%>
	<td align=center><%=rs1.getDouble("SGPA")%></td>
	<%
	if (mAcad.equals("0809"))
	{
	%>
	<td>&nbsp;</td>
	<%
	}
	else
	{
	%>
	<td align=center><%=rs1.getDouble("CGPA")%></td>
	<%
	}
	%>
	</tr>			
   <%
	} // CLOSING OF WHILE
%>
</tbody>
</TABLE>
<script type="text/javascript">
var st1 = new SortableTable(document.getElementById("table-1"),["CaseInsensitiveString","Number","Number","Number","Number","Number","Number","Number","Number"]);
</script>

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
}
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
}		
catch(Exception e)
{
}
%>
<br>
<table ALIGN=Center VALIGN=TOP>
		<tr>
		<td valign=middle>
		<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">
		<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
		A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
		<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>  
		</td></tr></table>

</body>
</html>



