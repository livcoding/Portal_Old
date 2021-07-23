<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%

//-----Variable Declaration-----

DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="";
int ctr=0;
int ctr1=0;
int mFlag=0;
int mRights=0;
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInstitute="",mInst="",mCompany="",mComp="";
String mExam="",mE="";
String mexam="";
String QryDept="", mDeptCode="", mDeptName="", mShowLoadOn="",mcolor="Black";
String Heading="", mType="";

//-----Session Element-----

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
if (request.getParameter("Type")==null)
{
	mType="";
}
else
{
	mType=request.getParameter("Type").toString().trim();
}
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Faculty Assigned Load Distribution] </TITLE>

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
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

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

		qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from PR#HODLOADDISTRIBUTION WHERE nvl(Deactive,'N')='N'";
		rs=db.getRowset(qry);
		if(rs.next())
			mInstitute=rs.getString("InstCode");	
		else
			mInstitute="JIIT";

		qry="Select Distinct NVL(COMPANYCODE,' ')CompCode from PR#HODLOADDISTRIBUTION WHERE nvl(Deactive,'N')='N'";
		rs=db.getRowset(qry);
		if(rs.next())
			mCompany=rs.getString("CompCode");	
		else
			mCompany="JIIT";

	     //-----------------------------
	     //-- Enable Security Page Level  
	     //-----------------------------
		
		mInst=mInstitute;
		mComp=mCompany;

		if(mType.equals("D"))
		{
		   mRights=133;
		   Heading="DOAA";	
		}
		else if(mType.equals("H"))
		{
		   mRights=132;
		   Heading="HOD";	
		}

		qry="Select WEBKIOSK.ShowLink('"+mRights+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
		  //----------------------
	
				%>
				<form name="frm"  method="get">
				<input id="x" name="x" type=hidden>
				<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
				<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Course wise Assigned Load</B></TD>
				</font></td></tr>
				</TABLE>
				<table cellpadding=1 cellspacing=0 align=center rules=groups border=3>

				<!--Institute****-->
				<INPUT name=InstCode TYPE=HIDDEN id="InstCode" VALUE='<%=mInst%>'>

				<!--Company****-->
				<INPUT name=CompCode TYPE=HIDDEN id="CompCode" VALUE='<%=mComp%>'>

				<!--Type****-->
				<input type=hidden Name='Type' ID='Type' value='<%=mType%>'>

				<tr>
				<!--*********Exam**********-->
				<td colspan=2><FONT color=black><FONT face=Arial size=2><STRONG>&nbsp;Exam Code</STRONG></FONT></FONT>
				&nbsp; &nbsp;&nbsp;
				<%
				try
				{
					qry="Select distinct ExamCode Exam from PR#HODLOADDISTRIBUTION where nvl(DEACTIVE,'N')='N'";
					rs=db.getRowset(qry);
					%>
					<select name=Exam tabindex="0" id="Exam" style="WIDTH: 120px">	
					<%   
					if (request.getParameter("x")==null) 
					{
						while(rs.next())
						{
							mExam=rs.getString("Exam");
							if(mexam.equals(""))
 							mexam=mExam;
							%>
							<OPTION Value =<%=mExam%>><%=rs.getString("Exam")%></option>
							<%
						}
						%>
						</select>
						<%
					}
					else
					{
						while(rs.next())
						{
							mExam=rs.getString("Exam");
							if(mExam.equals(request.getParameter("Exam").toString().trim()))
				 			{
								mexam=mExam;
								%>
								<OPTION selected Value =<%=mExam%>><%=rs.getString("Exam")%></option>
								<%			
						     	}
						     	else
							{
								%>
							      <OPTION Value =<%=mExam%>><%=rs.getString("Exam")%></option>
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
				<!--*********Department**********-->
				&nbsp; &nbsp; <FONT color=black><FONT face=Arial size=2><STRONG>Department</STRONG></FONT></FONT>
				&nbsp;&nbsp;
				<%
				if(mType.equals("D"))
				{
				  qry="select distinct DEPARTMENTCODE DeptCode, nvl(DEPARTMENT,' ')DeptName from DEPARTMENTMASTER where nvl(deactive,'N')='N' order by DeptName";
				}
				else if(mType.equals("H"))
				{
					qry="select distinct DEPARTMENTCODE DeptCode, nvl(DEPARTMENT,' ')DeptName from DEPARTMENTMASTER where nvl(deactive,'N')='N' ";
					qry=qry+" and DEPARTMENTCODE IN (Select DEPARTMENTCODE from HODLIST where INSTITUTECODE='"+mInstitute+"' And COMPANYCODE='"+mCompany+"' And EMPLOYEEID='"+mChkMemID+"') order by DeptName";
				}
				//out.print(qry);
				  rs=db.getRowset(qry);
				  %>
				  <select name="Dept" tabindex="1" id="Dept" style="WIDTH: 275px" >
				  <%
				 if(request.getParameter("x")==null)
				 {
					while(rs.next())
					{
		 				mDeptCode=rs.getString("DeptCode");
						if(QryDept.equals(""))
							QryDept=mDeptCode;
					 	mDeptName=rs.getString("DeptName");
						%>
							<option value=<%=mDeptCode%>><%=GlobalFunctions.toTtitleCase(mDeptName)%></option>
						<%
					}
				}
				else
				{
					while(rs.next())
					{
					   	mDeptCode=rs.getString("DeptCode");
					   	mDeptName=rs.getString("DeptName");
					   	if(mDeptCode.equals(request.getParameter("Dept").toString().trim()))
						{
							QryDept=mDeptCode;
							%>
						    		<option selected value=<%=mDeptCode%>><%=GlobalFunctions.toTtitleCase(mDeptName)%></option>
		  					<%
						}
						else
					      {
					   		%>
						    		<option  value=<%=mDeptCode%>><%=GlobalFunctions.toTtitleCase(mDeptName)%></option>
					   		<%
						}	
					}
				}
				%>
				</select>&nbsp;
				</td></tr>

				<!--***********Load status for HOD or DOAA**********-->
				<tr><td colspan=2>
				<FONT color=black>&nbsp;<FONT face=Arial size=2><STRONG>Show Load on</STRONG></FONT></FONT>
				<select ID=ShowLoadOn Name=ShowLoadOn style="WIDTH: 250px">
				<%
				if(request.getParameter("ShowLoadOn")==null)
				{
					mShowLoadOn="A";
					%>
			     		<option value="D">Draft Load Distribution</option>
			     		<option value="F">Finalized Load Distribution by HOD</option>
			     		<option Selected value="A">Approved Load Distribution by DOAA</option>
					<%
				}
				else
				{
					if(request.getParameter("ShowLoadOn").toString().trim().equals("D"))
					{
						%>
				     		<option value="D" Selected>Draft Load Distribution</option>
				     		<option value="F">Finalized Load Distribution by HOD</option>
				     		<option value="A">Approved Load Distribution by DOAA</option>
						<%
					}
					else if(request.getParameter("ShowLoadOn").toString().trim().equals("F"))
					{
						%>
				     		<option value="F" Selected>Finalized Load Distribution by HOD</option>
				     		<option value="D">Draft Load Distribution</option>
				     		<option value="A">Approved Load Distribution by DOAA</option>
						<%
					}
					else if(request.getParameter("ShowLoadOn").toString().trim().equals("A"))
					{
						%>
				     		<option value="A" selected>Approved Load Distribution by DOAA</option>
				     		<option value="D">Draft Load Distribution</option>
				     		<option value="F">Finalized Load Distribution by HOD</option>
						<%
					}
				}
				%>
			 	</select>
				<INPUT Type="submit" Value="&nbsp;Show&nbsp;"></td></tr>
				</table>
				</form>
				<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
				<tr><TD align=middle><b>Title : Course Wise Teaching Load (<%=mexam%>)</B></TD></tr>
				<% 
					qry="select DEPARTMENT DeptName from DEPARTMENTMASTER WHERE DEPARTMENTCODE='"+QryDept+"'";
					rs1=db.getRowset(qry);
					rs1.next();
				  %>
				<tr><td colspan=0 align=middle><b>Department of <%=GlobalFunctions.toTtitleCase(rs1.getString("DeptName"))%></b></td></tr>
				</TABLE>
				<table bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=columns topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center width="100%">
				<thead>
				<tr bgcolor="#ff8c00">
				 <td align=left><font color=white><b>Sr<br>No</b></font></td>
				 <td wrap colspan=2 align=left title="Course Code, Title and Name of Faculty"><font color=white><b>Course No. & Course Title,<br>Name of the Faculty</b></font></td>
				 <td align=center title="Load against Lecture"><font color=white><b>L</b></font></td>
				 <td align=center nowrap title="Load against Tutorial" align=center><font color=white><b>T</b></font></td>
				 <td align=center nowrap title="Load against Practical" align=center><font color=white><b>P</b></font></td>
				</tr>
				</thead>
				<tbody>
				<%
					if (request.getParameter("InstCode")==null)
						mInstitute=mInst;
					else		
						mInstitute=request.getParameter("InstCode").toString().trim();
		
					if (request.getParameter("CompCode")==null)
						mCompany=mComp;
					else		
						mCompany=request.getParameter("CompCode").toString().trim();

					if (request.getParameter("Exam")==null)
						mE=mexam;
					else
						mE=request.getParameter("Exam").toString().trim();
			
					if(request.getParameter("ShowLoadOn")==null)
						mShowLoadOn=mShowLoadOn;
					else
						mShowLoadOn=request.getParameter("ShowLoadOn").toString().trim();

					if(request.getParameter("Dept")!=null)	
						QryDept=request.getParameter("Dept").toString().trim();
					else
						QryDept=QryDept;
					mType=request.getParameter("Type").toString().trim();
					if(mType.equals("D"))
					{
					   mRights=133;
					   Heading="DOAA";	
					}
					else if(mType.equals("H"))
					{
					   mRights=132;
					   Heading="HOD";	
					}
//--------------------------------------------HOD------------------------------------- 
					if(mType.equals("H"))
					{
						qry="select DISTINCT A.SUBJECTID subid, B.SUBJECTCODE subcode, B.SUBJECT subname, A.FACULTYID fid, A.FACULTYTYPE ftyp, C.EMPLOYEENAME empname,";
						qry=qry+" WEBKIOSK.getFacultyLoadDetails('"+mCompany+"','"+mInstitute+"',A.FACULTYID,A.FACULTYTYPE,'"+mE+"',A.SUBJECTID) subjectload,";
						qry=qry+" C.DEPARTMENTCODE dcode From PR#HODLOADDISTRIBUTION A, SUBJECTMASTER B, V#STAFF C";
						qry=qry+" Where A.SUBJECTID=B.SUBJECTID AND A.INSTITUTECODE=B.INSTITUTECODE AND A.COMPANYCODE=C.COMPANYCODE AND A.FACULTYID=C.EMPLOYEEID AND ";
						qry=qry+" A.EXAMCODE='"+mE+"' AND C.DEPARTMENTCODE='"+QryDept+"' and A.STATUS='"+mShowLoadOn+"' and nvl(c.deactive,'N')='N'";
						qry=qry+" And A.FACULTYID IN (Select EMPLOYEEID from V#STAFF where DEPARTMENTCODE IN (Select DEPARTMENTCODE from HODLIST ";
						qry=qry+" where INSTITUTECODE='"+mInstitute+"' And COMPANYCODE='"+mCompany+"' And EMPLOYEEID='"+mChkMemID+"')) Order By subname";
					}
//--------------------------------------------DOAA-------------------------------------
					if(mType.equals("D"))
					{
						qry="select DISTINCT A.SUBJECTID subid, B.SUBJECTCODE subcode, B.SUBJECT subname, A.FACULTYID fid, A.FACULTYTYPE ftyp, C.EMPLOYEENAME empname,";
						qry=qry+" WEBKIOSK.getFacultyLoadDetails('"+mCompany+"','"+mInstitute+"',A.FACULTYID,A.FACULTYTYPE,'"+mE+"',A.SUBJECTID) subjectload,";
						qry=qry+" C.DEPARTMENTCODE dcode From PR#HODLOADDISTRIBUTION A, SUBJECTMASTER B, V#STAFF C";
						qry=qry+" Where A.SUBJECTID=B.SUBJECTID AND A.INSTITUTECODE=B.INSTITUTECODE AND A.COMPANYCODE=C.COMPANYCODE AND A.FACULTYID=C.EMPLOYEEID AND ";
						qry=qry+" A.EXAMCODE='"+mE+"' AND C.DEPARTMENTCODE='"+QryDept+"' and A.STATUS='"+mShowLoadOn+"' and nvl(c.deactive,'N')='N' Order By subname";
					}
					//out.print(qry);
					rs=db.getRowset(qry);
					
					String scode="";
					int len=0,i=0,len1=0;
					int lect=0,lval=0,theory=0,pract=0;
					String subjectload="",subjectload1="",subjectload2="";
					String l="",l1="",l2="";
					String t="",p="";
//-----Start of While loop-----
					while(rs.next())
					{ 
						mFlag=1;
						if(!rs.getString("subcode").equals(scode))
						{	
							ctr++;
							ctr1=0;

							if(!scode.equals(""))
							{
								
							}
							scode=rs.getString("subcode");
						%>
						
						<tr>
						<td nowrap><font color=<%=mcolor%>><b><%=ctr%>.</b></font></td>
						<td nowrap colspan=2><font color=<%=mcolor%>><b><%=rs.getString("subcode")%> : <%=rs.getString("subname")%></b></font></td>
						<td nowrap><font color=<%=mcolor%>>&nbsp;</font></td>
						<td nowrap><font color=<%=mcolor%>>&nbsp;</font></td>
						<td nowrap><font color=<%=mcolor%>>&nbsp;</font></td>

						</tr>
						
						<%
						}
						if(rs.getString("subcode").equals(scode))
						{
						ctr1++;
						subjectload=rs.getString("subjectload");
						
						len=subjectload.length();
						lect=subjectload.indexOf("**");
						subjectload1=subjectload.substring(lect+2,len);
						theory=subjectload1.indexOf("##");
						len1=subjectload1.length();
						subjectload2=subjectload1.substring(theory+2,len1);
						pract=subjectload2.indexOf("$$");
						if(lect<=1)
						{
							lval=0;
						}
						else
						{
							l=subjectload.substring(1,lect);
							i=l.indexOf('@');
							l1=l.substring(0,i);
							l2=l.substring(i+1,lect-1);
							lval=Integer.parseInt(l1)*Integer.parseInt(l2);
						}
						if(theory<=1)
						{
							t="0";
							
						}
						else
						{
							t=subjectload1.substring(1,theory);
							
						}	
						if(pract<=1)
						{
							p="0";
							
						}
						else
						{
							p=subjectload2.substring(1,pract);
													
						}	
					
						%>
						
						<tr>
						<td nowrap><font color=<%=mcolor%>>&nbsp;&nbsp;</font></td>
						<td nowrap><font color=<%=mcolor%>><%=ctr1%></font></td>
						<td nowrap><font color=<%=mcolor%>><%=rs.getString("empname")%></font></td>
						<td nowrap align=center><font color=<%=mcolor%>><%=lval%></font></td>
						<td nowrap align=center><font color=<%=mcolor%>><%=t%></font></td>
						<td nowrap align=center><font color=<%=mcolor%>><%=p%></font></td>
						</tr>	
						<%
						}//closing of if 
  					}//-----End of While loop-----

					%>
	
				</tbody>
				</TABLE>
				<%
				if(mFlag==1)
				{
				%>
				<table width=100% align=center>
				<tr>
				<td colspan=3 align=center title="Click to Print"><font color=blue><a onClick="window.print();"><img src="../../Images/printer.gif"></a></font></td>
				</tr>
				</TABLE>
				<%
				}
				%>
				<script type="text/javascript">
				var st1 = new SortableTable(document.getElementById("table-1"),[,,,,]);
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
				<h3><br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
				<P>This page is not authorized/available for you.
				<br>For assistance, contact your network support team. 
				</font><br><br><br><br>
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