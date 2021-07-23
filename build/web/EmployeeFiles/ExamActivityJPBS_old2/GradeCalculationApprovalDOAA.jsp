<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null,rss=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="";
String mStatus="";
int ctr=0;
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInstitute="",mInst="";
String mExam="",QryExam="", QryStatus="";
String mName1="",mName2="";
int mFlag=0;
String sname="",qry2="",qry3="",qry4="";
ResultSet rs2=null,rs3=null,rs4=null;
String 	Studid="",mDetained="";
int Rejected=0,mCount1=0;



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
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Grade Approval By DOAA ]</TITLE>

<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<SCRIPT LANGUAGE="JavaScript"> 
function un_check()
{
 for (var i = 0; i < document.frm1.elements.length; i++) 
 {
  var e = document.frm1.elements[i]; 
  if ((e.name != 'allbox') && (e.type == 'checkbox')) 
  { 
   e.checked = document.frm1.allbox.checked;
  }
 }
}
</SCRIPT>

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
</script>
<script>
	if(window.history.forward(1) != null)
	window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
try
{
	OLTEncryption enc=new OLTEncryption();

	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{
		mDMemberID=enc.decode(mMemberID);
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

		qry="Select WEBKIOSK.ShowLink('147','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
		  //----------------------

		mInstitute=  mInst;
				%>
				<form name="frm" method="post" >
				<input id="x" name="x" type=hidden>
				<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
				<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><STRONG>Grade Approval</STRONG></TD>
				</font></td></tr>
				</TABLE>
				<table cellpadding=1 cellspacing=0 align=center rules=groups border=3>

				<!--Institute****-->
				<INPUT name=InstCode TYPE=HIDDEN id="InstCode" VALUE='<%=mInstitute%>'>

				<!--*********Exam**********-->
<tr>
				<td colspan=4><font color=black face=Verdana size=2><STRONG>&nbsp;Institute : <%=mInstitute%></STRONG>
				</td>
				</tr>
				<tr>
				<td><font color=black face=arial size=2><STRONG>&nbsp;Exam</STRONG>
				<%
				qry=" SELECT distinct A.EXAMCODE Examcode, to_char(B.EXAMPERIODFROM,'DD-MM-YYYY')EXAMPERIODFROM from GRADECALCULATION A, EXAMMASTER B ";

				//***************25/01/2010***********
				//************nvl(b.lockexam,'N')='N'
				qry=qry+" WHERE  A.INSTITUTECODE='"+mInstitute+"' and A.INSTITUTECODE=B.INSTITUTECODE and A.EXAMCODE=B.EXAMCODE and nvl(b.lockexam,'N')='N' order by 1 desc";
				//out.print(qry);
				rs=db.getRowset(qry);
				%>
				<select name="Exam" tabindex="0" id="Exam" style="WIDTH: 120px" >
				<%
				if(request.getParameter("x")==null)
				{
					while(rs.next())
					{
					 	mExam=rs.getString("Examcode");
					 	//out.println("The Exam Code is = " + mExam);
						if(QryExam.equals(""))
							QryExam=mExam;
							

						%>
						<option value=<%=mExam%>><%=mExam%></option>
						<%
					}
				}
				else
				{
					while(rs.next())
					{
					   	mExam=rs.getString("Examcode");
					   	if(mExam.equals(request.getParameter("Exam").toString().trim()))
						{
							QryExam=mExam;
							%>
					   		<option selected value=<%=mExam%>><%=mExam%></option>
				  			<%
						}
						else
						{	
		   					%>
					    		<option  value=<%=mExam%>><%=mExam%></option>
		   					<%
						}
					}
				}
				%>
				</select></td>
			<!--*********Pending/Approved**********-->
				<td><font color=black face=arial size=2><STRONG>Status</STRONG>
				<select name="Status" tabindex="0" id="Status" style="WIDTH: 165px" >
				<%
				if(request.getParameter("x")==null)
				{
					QryStatus="ALL";
					%>
 					<OPTION selected value=ALL>ALL</option>
 					<OPTION value=A>Approved</option>
 					<OPTION value=D>Pending</option>
					<%
				}
				else
				{
					if (request.getParameter("Status").toString().trim().equals("ALL"))
			 		{
						QryStatus="ALL";
						%>
	 					<OPTION selected value=ALL>ALL</option>
	 					<OPTION value=A>Approved</option>
	 					<OPTION value=D>Pending</option>
						<%
					}
					else if (request.getParameter("Status").toString().trim().equals("A"))
					{
						%>
	 					<OPTION value=ALL>ALL</option>
	 					<OPTION selected value=A>Approved</option>
	 					<OPTION value=D>Pending</option>
						<%
					}
					else if (request.getParameter("Status").toString().trim().equals("D"))
					{
						%>
	 					<OPTION value=ALL>ALL</option>
	 					<OPTION value=A>Approved</option>
	 					<OPTION selected value=D>Pending</option>
						<%
					}
				}
				%>
				</select>
				<!--
				 <input type=RADIO name=ETOD id=ETOD VALUE="N" checked=true ><b>Normal</b>
				 <input type=RADIO name=ETOD id=ETOD VALUE="E" ><b>EtoD</b> -->

				<INPUT Type="submit" Value="Show/Refresh"></td></tr>
				</table>
				</form>
				<%	
				/*
				String mETOD="";
				if(request.getParameter("ETOD")==null)
			    {
					mETOD="N";
				} 
				else
			    { 
					mETOD=request.getParameter("ETOD").toString().trim();
				}   
				*/
				if(request.getParameter("Exam")==null)
				{
					QryExam=QryExam;
				}
				else
				{
					QryExam=request.getParameter("Exam").toString().trim();	
					
					//out.println("The Exam Code is = " + QryExam);
				}
				if(request.getParameter("Status")==null)
				{
					QryStatus=QryStatus;
				}
				else
				{
					QryStatus=request.getParameter("Status").toString().trim();	
				}
				qry="select Distinct A.TOTALSTUDENT,A.EXAMCODE EXAMCODE,A.SUBJECTID SUBJECTID, B.SUBJECTCODE SUBJCODE, B.SUBJECT SUBJNAME,				 Decode(nvl(Finalized,'N'),'Y','YES','NO')Finalized,				Decode(STATUS,'D','Pending','A','Approved','F','Finalized',' ')STATUS, ";
				qry=qry+" nvl(to_char(ENTRYDATE,'DD-MM-YYYY'),' ')ENTRYDATE From GRADECALCULATION A, SUBJECTMASTER B";
				qry=qry+" Where A.INSTITUTECODE=B.INSTITUTECODE AND  A.SUBJECTID=B.SUBJECTID AND A.EXAMCODE='"+QryExam+"' AND  A.INSTITUTECODE ='"+mInstitute+"' AND A.STATUS=DECODE('"+QryStatus+"','ALL',A.STATUS,'"+QryStatus+"')";
				qry=qry+" Order by SubjName";
				//out.println(qry);
				rs=db.getRowset(qry);
				rss=db.getRowset(qry);
				if(rs.next())
				{
				%>
				<form Name=frm1 ID=frm1 Action="GradeCalculationApprovalAction.jsp" Method=Post>
				<table valign=top class="sort-table" id="table-1" border=1 width="100%" cellpadding=0 cellspacing=0 align=center rules=none>
				<THEAD>
				<tr bgcolor='#e68a06'>
				<td><font color="white"><b>SrNo</b></font></td>
				<td align=left Title="Subject Name [Subject Code]"><font color="white"><b>Subject</b></font></td>
				
				<td align=left Title="Student Count" ><font color="white"><b>Total Students<br>/Rejected</b></font></td>
				
				<td align=left Title="Grade Entry Date"><font color="white"><b>Entry Date</b></font></td>
				<td align=left Title="E2D or Normal?"><font color="white"><b>Freezed?</b></font></td> 
				<td align=left ><b><font color="white">&nbsp;<input onClick="un_check()" type="checkbox" id='allbox' name='allbox' value='Y'></font><font color="white">Approve?</font></b></td>
				</tr>
				</thead>
				<tbody>
				<input type=hidden Name='InstCode' ID='InstCode' value='<%=mInstitute%>'>
				<input type=hidden Name='ExamCode' ID='ExamCode' value='<%=QryExam%>'>
				<%
				}
				else
				{
					%><Center><%
					out.print("<br><img src='../../Images/Error1.jpg'>");
					out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>No Such Record Found...</font> <br>");
					%></Center><%
				}
				String mColor="";
				int mChoice=0;
				String mLastStatus="";
				String mCol1="LightGrey";
				String OldmELECTIVECODE="";
				String mCol2="#ffffff";
				String mSubjCode="", mSubjName="", mE2DType="", mEDate="", TRCOLOR="#F8F8F8";
				while(rss.next())
				{
					mSubjCode=rss.getString("SUBJECTID");
					// mSubjid=rss.getString("SUBJECTID");
					mStatus=rss.getString("Status");
					mSubjName=rss.getString("SubjName");
					mE2DType=rss.getString("Finalized");
					mEDate=rss.getString("EntryDate");
					ctr++;
					if(ctr%2==0)
						TRCOLOR="White";
					else
						TRCOLOR="#F8F8F8";

					mName1="Checked_"+String.valueOf(ctr).trim();
					mName2="SubjCode_"+String.valueOf(ctr).trim();
					%>
					<tr BGCOLOR='<%=TRCOLOR%>'>
					<input type=hidden Name=<%=mName2%> ID=<%=mName2%> value='<%=mSubjCode%>'>
					<td align=right><%=ctr%>.&nbsp;&nbsp;</td>
					<td nowrap><A target=_new HREF="SubjectGradeDetail.jsp?Subject=<%=rss.getString("SUBJECTID")%>&ExamCode=<%=rss.getString("EXAMCODE")%>"><%=GlobalFunctions.toTtitleCase(mSubjName)%> [<%=rss.getString("SUBJCODE")%>] </a></td>
				
		<td nowrap><%=rss.getString("TOTALSTUDENT")%></td>
			
				<td nowrap><%=mEDate%></td>
				<td nowrap><%=mE2DType%></td>
	<%
					if(mStatus.equals("Approved"))
						{
						%>
						<td align=left nowrap><input type='checkbox' name='<%=mName1%>' id='<%=mName1%>' disabled value='A'"><FONT COLOR=GREEN>Approved</FONT></td>
						<%
						}
						else if(mStatus.equals("Pending"))
						{
						mFlag=2;
						%>
						<td align=left nowrap>
						<% if(mE2DType.equals("YES"))
							{%>
						<input type='checkbox' name='<%=mName1%>' id='<%=mName1%>' value='D'"><FONT COLOR=RED>Pending</FONT></td>
						<%
							}
						else
							{
							%>
						<input type='hidden' name='<%=mName1%>' id='<%=mName1%>' value='X'"><FONT COLOR=Blue>Not Freezed</FONT></td>
						<%

							}
						}
						else
						{
						%>
						<td nowrap>&nbsp;<FONT COLOR=GREEN>Canceled</FONT></td>
						<%
						}
					
					%>
					</tr>
					<%
				}
				%>
				</tbody>
				</TABLE>
				<script type="text/javascript">
				var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString","Number","CaseInsensitiveString","CaseInsensitiveString"]);
				</script>
				<%
				if(mFlag>1)
				{
				%>
				<table valign=top border=1 width="100%" cellpadding=0 cellspacing=0 align=center rules=none bgcolor=white>
				<tr bgcolor=white><td colspan=5 nowrap><font color=black face=arial size=2><STRONG>Remarks ( If Any? ) : </STRONG><input type="text" name="Remarks" id="Remarks" size=80 maxlength="160px"></td></tr>
				<TR BGCOLOR='#e68a06'><TD colspan=5 ALIGN=CENTER><INPUT Type="submit" Value="Click to Approve"></TD></TR>
				</table>
				<input type=hidden Name='TotalCount' ID='TotalCount' value='<%=ctr%>'>
				</form>
				<%
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
			<h3><br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
			<P>This page is not authorized/available for you.
			<br>For assistance, contact your network support team. 
			</font><br>	<br>	<br>	<br> 
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
	//out.println(qry);
}
%>
</body>
</html>