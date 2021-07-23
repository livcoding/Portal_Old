<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%

DBHandler db=new DBHandler();
ResultSet rs=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="",mst="";
String mfactype="",mSemType="", msemtype="", QrySemType="", mHOD="", mHOD1="", mHOD2="", mHODCode="", mStatus="";
int ctr=0;
String mMemberID="";
String mDMemberID="", mHODID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mDept="",mdept="";
String mInstitute="";
String mExam="",QryExam="", mPrExCode="";
String mName1="",mName2="",mName3="",mName4="";
int mFlag=0;



if (session.getAttribute("InstituteCode")==null)
{
	mInstitute="";
}
else
{
	mInstitute=session.getAttribute("InstituteCode").toString().trim();
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
<TITLE>#### <%=mHead%>[HOD wise Load Distribution Cancellation by DOAA (Pre Registration)]</TITLE>

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
		
		 

		qry="Select WEBKIOSK.ShowLink('113','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
		  //----------------------
	
			qry=" SELECT distinct a.PREVENTCODE PRECODE, a.EXAMCODE from PREVENTMASTER a WHERE a.INSTITUTECODE='"+ mInstitute +"' and NVL(a.FREEELECTIVERUNFINALIZED,'N')='Y' and nvl(a.PRCOMPLETED,'N')='N' and nvl(a.PRBROADCAST,'N')='Y'";
			qry=qry+" AND NVL(PRREQUIREDFOR,'S')<>'S' AND NVL(a.DEACTIVE,'N')='N' And (a.INSTITUTECODE, a.PREVENTCODE) In ";
			qry=qry+" (select b.INSTITUTECODE, b.PREVENTCODE from PREVENTS b where nvl(B.DEACTIVE,'N')='N'";
			qry=qry+" And NVL(B.MEMBERTYPE,'N')<>'S' GROUP BY b.INSTITUTECODE, b.PREVENTCODE)";
			
			rs= db.getRowset(qry);
			//out.print(qry);
			if(rs.next())
			{		
				mPrExCode=rs.getString("PRECODE");
				%>
				<form name="frm" method="post" >
				<input id="x" name="x" type=hidden>
				<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
				<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><STRONG>HOD wise Load Distribution Cancellation [Pre Registration]</STRONG></TD>
				</font></td></tr>
				</TABLE>
				<table cellpadding=1 cellspacing=0 align=center rules=groups border=3>

				<!--Institute****-->
				<INPUT name=InstCode TYPE=HIDDEN id="InstCode" VALUE='<%=mInstitute%>'>

				<!--*********Exam**********-->

				<tr>
				<td><font color=black face=arial size=2><STRONG>&nbsp;Exam Code&nbsp;</STRONG>
				<%
					qry=" SELECT distinct a.EXAMCODE Examcode from PREVENTMASTER a WHERE a.INSTITUTECODE='"+ mInstitute +"' and NVL(a.FREEELECTIVERUNFINALIZED,'N')='Y' and nvl(a.PRCOMPLETED,'N')='N' and nvl(a.PRBROADCAST,'N')='Y'";
					qry=qry+" AND NVL(PRREQUIREDFOR,'S')<>'S' AND NVL(a.DEACTIVE,'N')='N' And (a.INSTITUTECODE, a.PREVENTCODE) In ";
					qry=qry+" (select b.INSTITUTECODE, b.PREVENTCODE from PREVENTS b where nvl(B.DEACTIVE,'N')='N'";
					qry=qry+" And NVL(B.MEMBERTYPE,'N')<>'S' GROUP BY b.INSTITUTECODE, b.PREVENTCODE)";
					rs=db.getRowset(qry);
				%>
				<select name="Exam" tabindex="0" id="Exam" style="WIDTH: 120px" >
				<%
				if(request.getParameter("x")==null)
				{
					while(rs.next())
					{
					 	mExam=rs.getString("Examcode");
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
			<!--*********Semester Type**********-->

				<td><font color=black face=arial size=2><STRONG>&nbsp; &nbsp; &nbsp;Semester Type&nbsp;</STRONG>
				<%
					qry="Select Distinct nvl(SEMESTERTYPE,' ')SemType from PR#HODLOADDISTRIBUTION where nvl(DEACTIVE,'N')='N'";
					rs=db.getRowset(qry);
				%>
				<select name="SemType" tabindex="0" id="SemType" style="WIDTH: 120px" >
				<%
				if(request.getParameter("x")==null)
				{
					QrySemType="ALL";
					%>
					<OPTION selected value=ALL>ALL</option>
					<%
					while(rs.next())
					{
				 		mSemType=rs.getString("SemType");
						if(mSemType.equals("REG"))
							msemtype="Regular";
						else if(mSemType.equals("RWJ"))
							msemtype="Regular with Jr.";
						%>
							<option value=<%=mSemType%>><%=msemtype%></option>
						<%
					}
				}
				else
				{
					if (request.getParameter("SemType").toString().trim().equals("ALL"))
			 		{
						QrySemType="ALL";
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
			   			mSemType=rs.getString("SemType");
						if(mSemType.equals("REG"))
							msemtype="Regular";
						else if(mSemType.equals("RWJ"))
							msemtype="Regular with Jr.";
					   	if(mSemType.equals(request.getParameter("SemType").toString().trim()))
						{
							QrySemType=mSemType;
							%>
			   				<option selected value=<%=mSemType%>><%=msemtype%></option>
						  	<%
						}	
						else
						{
			   				%>
			    				<option  value=<%=mSemType%>><%=msemtype%></option>
		   					<%
						}
					}
				}
				%>
				</select>
				<INPUT Type="submit" Value="Show / Refresh"></td></tr>
				</table>
				</form>
				<TABLE rules=all cellSpacing=0 cellPadding=0 border=1 align=center>
				<form Name=frm1 ID=frm1 Action="PRRegLoadDistributionCancelAction.jsp" Method=Post>
				<tr bgcolor='#e68a06'>
				<th>&nbsp;<b><font color="white" size=3>Sr.</font>&nbsp;<br>&nbsp;<font color="white" size=3>No.</font></b>&nbsp;</th>
				<th><font color="white" size=3><b>&nbsp;Department&nbsp;</b></font></th>
				<th><b><font color="white" size=3>Head of </font><br><font color="white" size=3>Department</font></b></th>
				<th><b><font color="white" size=3>Cancel?&nbsp;</font><br><font color="white" size=3><input onClick="un_check()" type="checkbox" id='allbox' name='allbox' value='Y'></font></b></th>
				<th><b><font color="white" size=3>Current</font><br><font color="white" size=3>Status</font></b></th>
				</tr>
				<%				 
				int mData=0;
				int maxCol=0;
				int mSbjChoice=0;

				if(request.getParameter("Exam")==null)
				{
					QryExam=QryExam;
				}
				else
				{
					QryExam=request.getParameter("Exam").toString().trim();	
				}
				if(request.getParameter("SemType")==null)
				{
					QrySemType=QrySemType;
				}
				else
				{
					QrySemType=request.getParameter("SemType").toString().trim();	
				}
				qry="select Distinct nvl(A.DEPARTMENTRUNNIG,' ') Dept, nvl(A.STATUS,'D')Status, nvl(B.EMPLOYEEID,' ') HODID, nvl(C.EMPLOYEENAME,' ') HODName, nvl(C.EMPLOYEECODE,' ') HODCode from PR#HODLOADDISTRIBUTION A, ";
				qry=qry+" HODLIST B, EMPLOYEEMASTER C where A.INSTITUTECODE=B.INSTITUTECODE and A.ENTRYBY=C.EMPLOYEEID";
				qry=qry+" And B.INSTITUTECODE='"+mInstitute+"' AND A.DEPARTMENTRUNNIG=B.DEPARTMENTCODE AND NVL(A.DEACTIVE,'N')='N'";
				qry=qry+" And A.EXAMCODE='"+QryExam+"' and A.SEMESTERTYPE=decode('"+QrySemType+"','ALL',A.SEMESTERTYPE,'"+QrySemType+"')";

				//out.print(qry);
				rs=db.getRowset(qry);
				%>
				<input type=hidden Name='InstCode' ID='InstCode' value='<%=mInstitute%>'>
				<input type=hidden Name='ExamCode' ID='ExamCode' value='<%=QryExam%>'>
				<input type=hidden Name='SemType' ID='SemType' value='<%=QrySemType%>'>
				<INPUT name=PREVENT TYPE=HIDDEN id="PREVENT" VALUE='<%=mPrExCode	%>'>
				<%
				String mColor="";
				int mChoice=0;
				String mLastStatus="";
				String mCol1="LightGrey";
				String OldmELECTIVECODE="";
				String mCol2="#ffffff";
				while(rs.next())
				{
					mDept=rs.getString("Dept");
					mStatus=rs.getString("Status");
					mHOD=rs.getString("HODName");
				/*	int len=0;
					int pos1=0;
					len=mHOD.length();
					pos1=mHOD.indexOf("(");
					if(pos1==0)
					{
						mHOD1=mHOD;
					}
					else
					{
						mHOD1=mHOD.substring(0,pos1);
						mHOD2=mHOD.substring(pos1,len);
					}*/
					mHODCode=rs.getString("HODCode");
					mHODID=rs.getString("HODID");
					mData=1;
					ctr++;
					mName1="checked_"+String.valueOf(ctr).trim();
					mName2="Department_"+String.valueOf(ctr).trim();
					mName3="HODID_"+String.valueOf(ctr).trim();
					%>
					<tr bgcolor="<%=mColor%>">
					<input type=hidden Name=<%=mName2%> ID=<%=mName2%> value='<%=mDept%>'>
					<input type=hidden Name=<%=mName3%> ID=<%=mName3%> value='<%=mHODID%>'>
					<td>&nbsp;<%=ctr%>.</td>
					<td align=center><a Title="View Department's Load Distribution Detail" target=_New href='ViewDeptLoaddistribution.jsp?EXAM=<%=QryExam%>&amp;SEMTYPE=<%=QrySemType%>&amp;DEPT=<%=mDept%>'><%=mDept%></a></td>
					<!--<td>&nbsp;<%=GlobalFunctions.toTtitleCase(mHOD1)%> <%=mHOD2%></td>-->
					<td>&nbsp;<%=mHOD%></td>
					<%
					if(mStatus.equals("C"))
					{
						%>
						<td align=center><input type='checkbox' name='<%=mName1%>' id='<%=mName1%>' disabled checked value='C'"></td>
						<td><FONT COLOR=GREEN>Cancelled</FONT></td>
						<%
					}
					else if(mStatus.equals("F"))//-----Actually 'F' will be here----
					{
						mFlag=1;
						%>
						<td align=center><input type='checkbox' name='<%=mName1%>' id='<%=mName1%>' value='Y'"></td>
						<td><FONT COLOR=Black>Finalized by HOD</FONT></td>
						<%
					}
					else if(mStatus.equals("D")) //-----Actually 'D' will be here----
					{
						%>
						<td align=center><input type='checkbox' name='<%=mName1%>' id='<%=mName1%>' disabled value='D'"></td>
						<td><FONT COLOR=Black>Not Finalized</FONT></td>
						<%
					}
					else if(mStatus.equals("A"))
					{
						%>
						<td>&nbsp;</td>
						<td><FONT COLOR=GREEN>Approved</FONT></td>
						<%
					}
					else
					{
						%>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<%
					}
					%>
					</tr>
					<%
				}
				if(mFlag>0)
				{
				%>
				<TR><TD colspan=5 ALIGN=CENTER><INPUT Type="submit" Value="Save"></TD></TR>
				<%
				}
				%>
				<input type=hidden Name='TotalCount' ID='TotalCount' value='<%=ctr%>'>
				</form>
				</TABLE>
				<%
			}
			else
			{
				%>
				<font color=red>
				<h3>	<br><img src='../../Images/Error1.jpg'>
				Pre- Registration Event has not been declared or Registration completed</FONT></P>
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
}
%>
</body>
</html>