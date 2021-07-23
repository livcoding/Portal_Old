<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="TIET ";

%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [Student Reaction Survey Report]</TITLE>

<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
</script>

<script language=javascript>
	<!--
	function RefreshContents()
	{ 	
    	    document.frm.x.value='ddd';
    	    document.frm.submit();
	}
//-->
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

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


		String mPage="";

		if (request.getParameter("StartIndex")==null)
{
		start=1;
}
else
{
			start=Integer.parseInt(request.getParameter("StartIndex").trim());
}

if (request.getParameter("LastIndex")==null)
{
		last=30;
}
else
{
		last=Integer.parseInt(request.getParameter("LastIndex").trim());
}

		if (request.getParameter("Paging")==null)
		{
			mPage="";
		}
		else
		{
			mPage=request.getParameter("Paging").trim();
		}
		if(mPage.equals("add"))
		{
			start=start+30;
			last=last+30;
		}
		else if(mPage.equals("substract"))
		{
			start=start-30;
			last=last-30;
		}

  %>
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>SRS Detailed Report</b></TD>
</font></td></tr>
</TABLE>
<table cellpadding=1 cellspacing=0 width="100%" align=center rules=groups border=3>

<!--Institute-->
<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
<%
	qry="Select Distinct NVL(INSTITUTECODE,' ')IC from v#SRSEVENTS WHERE nvl(deactive,'N')='N' ";
	rs=db.getRowset(qry);
	while(rs.next())
	{
		mInst=rs.getString("IC");
	}
%>
<tr><td nowrap><FONT color=black><FONT face=Arial size=2><STRONG>Program</STRONG></FONT></FONT>
<%
try
{
	qry="Select Distinct nvl(B.PROGRAMCODE,' ')PROGRAMCODE, A.PROGRAMNAME||' ('||B.PROGRAMCODE||') ' Program from PROGRAMMASTER A, V#SRSEVENTS B where A.ProgramCode=B.ProgramCode and nvl(B.deactive,'N')='N'";
	rs=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		%>
		<select name=Program tabindex="0" id="Program" style="WIDTH: 300px" >	
		<OPTION selected value=ALL>ALL</option>
		<%   
		while(rs.next())
		{  
			mPCode=rs.getString("PROGRAMCODE");
			if(mpcode.equals(""))
 		//	mpcode=mPCode;
			%>
			<OPTION Value =<%=mPCode%>><%=rs.getString("Program")%></option>
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name=Program tabindex="0" id="Program" style="WIDTH: 300px" >	
		<%
		if (request.getParameter("Program").toString().trim().equals("ALL"))
 		{
			%>
	 		<OPTION selected value=ALL>ALL</option>
			<%
		}
		else
		{
			%>
			<OPTION value=ALL>ALL</option>
			<%
		}

		while(rs.next())
		{
			mPCode=rs.getString("PROGRAMCODE");
			if(mPCode.equals(request.getParameter("Program").toString().trim()))
 			{
		%>
				<OPTION selected Value =<%=mPCode%>><%=rs.getString("Program")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mPCode%>><%=rs.getString("Program")%></option>
		      	<%			
		   	}
		}
		%>
		</select>
	  	<%
	 }
 }    
catch(Exception e)
{
//	out.println("MSG5");
}
%>
</td>
<td nowrap>
<FONT color=black><FONT face=Arial size=2>&nbsp;&nbsp;<STRONG>ExamCode</STRONG></FONT></FONT>

<%
try
{
	qry="select Distinct Examcode,eventfrom from V#SRSEvents where nvl(DEACTIVE,'N')='N' order by eventfrom desc";
	//qry="Select Distinct nvl(B.PROGRAMCODE,' ')PROGRAMCODE, A.PROGRAMNAME||' ('||B.PROGRAMCODE||') ' Program from PROGRAMMASTER A, V#SRSEVENTS B where A.ProgramCode=B.ProgramCode and nvl(B.deactive,'N')='N'";
	rs=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		%>
		<select name=ExamCode tabindex="0" id="ExamCode" style="WIDTH: 140px" >	
		<%   
		while(rs.next())
		{  
			mECode=rs.getString("Examcode");
			if(mecode.equals(""))
			{
				mecode=mECode;
			%>
			<OPTION selected Value =<%=mECode%>><%=rs.getString("Examcode")%></option>
			<%			
			}
			else
			{
			%>
			<OPTION Value =<%=mECode%>><%=rs.getString("Examcode")%></option>
			<%			
			}
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name=ExamCode tabindex="0" id="ExamCode" style="WIDTH: 140px" >	
		<%		
		while(rs.next())
		{
			mECode=rs.getString("Examcode");
			if(mECode.equals(request.getParameter("ExamCode").toString().trim()))
 			{
			%>
				<OPTION selected Value =<%=mECode%>><%=rs.getString("Examcode")%></option>
			<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mECode%>><%=rs.getString("Examcode")%></option>
		      	<%			
		   	}
		}
		%>
		</select>
	  	<%
	 }
 }    
catch(Exception e)
{
}
%>
<input type=submit value=Show>
</td>
</tr>
</table>
<%
String mProgCode="",mExamCode="";

	if(request.getParameter("Program")==null)
	{
		mProgCode="ALL";
	}
	else
	{
			mProgCode=request.getParameter("Program").toString().trim();
	}
	if(request.getParameter("ExamCode")==null)
	{
		mExamCode=mECode;
	}
	else
	{
		mExamCode=request.getParameter("ExamCode").toString().trim();
	}

%>
<Center><A Target=_New HREF='SRSToExcel.jsp?EX=<%=mExamCode%>&amp;PC=<%=mProgCode%>'><font size=2 color=green face='Verdana'><b><u>Click here to Print all Record(s) in Ms Excel</b></u></font></A></center><br>
<Table  align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1  border=1 >
<Thead>
<TR bgcolor="#ff8c00">
<TD Title="Click on SNo. to Sort "><b><font color="white">SNo.</font></td>
<TD Title="Click on Enrollment to Sort "><b><font color="white">Enrollment No.</font></td>
<TD Title="Click on Student Name to Sort"><b><font color="white">Student Name</font></td>
<TD Title="Click on No.of Reg.Subject to Sort"><b><font color="white">No.of Reg.Subject</font></td>
<TD Title="Click on No.of faculty to Sort"><b><font color="white">Total SRS to be Sent</font></td>
<TD Title="Click on SRS sent to Sort"><b><font color="white">SRS sent </font></td>
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

	// A.PROGRAMCODE=decode('"+mpcode+"','ALL',A.PROGRAMCODE,'"+mpcode+"')";
qry="select studentname,studentid,nvl(enrollmentno,'')enrollmentno,count(distinct subjectid)cntsubj, ";
qry=qry+" count(employeecode)cntemp from V#STUDENTLTPDETAIL where institutecode='"+mInst+"' ";
qry=qry+" and examcode=decode('"+mExamCode+"','ALL',examcode,'"+mExamCode+"') and Programcode=decode('"+mProgCode+"','ALL',programcode,'"+mProgCode+"') and nvl(DEACTIVE,'N')='N' ";
qry=qry+" group by enrollmentno,studentname ,studentid";

qry3="select * from (select a.*, rownum rn from("+qry+") a where rownum<='"+last+"') where rn>='"+start+"'" ;

rs=db.getRowset(qry3);
while(rs.next())
{
msno++;
	qry1="select count(subjectid)cnt from V#SRSEVENTSUGGESTION where institutecode='"+mInst+"'  ";
	qry1=qry1+" and examcode=decode('"+mExamCode+"','ALL',examcode,'"+mExamCode+"') and programcode=decode('"+mProgCode+"','ALL',programcode,'"+mProgCode+"') and studentid='"+rs.getString("studentid")+"' ";
	rs1=db.getRowset(qry1);
	//out.print(qry1);
	if(rs1.next())
	{
		aa=rs1.getInt("cnt");	
	}
	else
	{
		aa=0;
	}
	%>
	<tr>
		<td><%=rs.getString("rn")%></td>
		<td><%=rs.getString("enrollmentno")%></td>
			<td><%=rs.getString("studentname")%></td>
				<td><%=rs.getString("cntsubj")%></td>
				<td><%=rs.getString("cntemp")%></td>
					<td><%=aa%></td>
						
						</tr>
	<%
} // closing of while

%>
</tbody>
</table>
</form>
<table width=100%>

<tr>
<%	
			if(start!=1)
			{
%>
<FORM METHOD=POST ACTION="">
<INPUT TYPE="hidden" NAME="Paging" VALUE="substract">
<INPUT TYPE="hidden" NAME="StartIndex" VALUE=<%=start%>>
<INPUT TYPE="hidden" NAME="LastIndex" VALUE=<%=last%>>
<td align="left"><INPUT TYPE="submit" value="Previous" class="submitbutton"></td>
</form>
<%
			}

			if(last<count)
			{
%>	
<FORM METHOD=POST ACTION="">
<INPUT TYPE="hidden" NAME="Paging" VALUE="add">
<INPUT TYPE="hidden" NAME="StartIndex" VALUE=<%=start%>>
<INPUT TYPE="hidden" NAME="LastIndex" VALUE=<%=last%>>
<td align="right"><INPUT TYPE="submit" value="Next" class="submitbutton"></td>
</form>
<%
			}
%>
</tr>
</table>
<script type="text/javascript">
var st1 = new SortableTable(document.getElementById("table-1"),["Number","Number","CaseInsensitiveString","Number","Number","Number"]);
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