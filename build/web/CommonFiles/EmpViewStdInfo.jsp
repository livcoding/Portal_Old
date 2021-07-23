<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %> 
<%
String mHead="",mInstCode ="";
String mCandCode="", MName="";
String mCandName="";
String URL="";

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<TITLE>#### <%=mHead%> [ View Students Profile/Information ] </TITLE>


<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

<script language=javascript>

	function RefreshContents()
	{ 	
    	    document.frm.x.value='ddd';
    	    document.frm.submit();
	}
//-->
</SCRIPT>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor="#fce9c5" rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
//GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="",mDept="",mDesg="",mInst="",minst="",mDMemberID="";
String qry="", mEnOrNm="", x="",cInst="",mCheck="";
int msno=0;
ResultSet rs=null;
if (session.getAttribute("Designation")==null)
{
	mDesg="";
}
else
{
	mDesg=session.getAttribute("Designation").toString().trim();
}
							
if (session.getAttribute("Department")==null)
{
	mDept="";
}
else
{
	mDept=session.getAttribute("Department").toString().trim();
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

if (session.getAttribute("InstituteCode")==null)
{
	mInstCode ="JIIT";
}
else
{
	mInstCode =session.getAttribute("InstituteCode").toString().trim();
}
session.setAttribute("INSCODE"," ");
OLTEncryption enc=new OLTEncryption();
   if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
	{
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);
		mDMemberID=enc.decode(mMemberID);
		
		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk1=null;
		  //-----------------------------
		  //-- Enable Security Page Level  
		  //-----------------------------
		qry="Select WEBKIOSK.ShowLink('71','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      	RsChk1= db.getRowset(qry);
		if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
		   {
		  //----------------------
			if (request.getParameter("CandName")==null)
				MName="";
				else
				MName=request.getParameter("CandName").toString().trim().toUpperCase();

			%>
			<form name="frm"  method="get" >
			<input id="x" name="x" type=hidden>
			<table cellpadding=0 cellspacing=0 align=center rules=groups border=1>
			<tr><td align=center colspan=2 bgcolor='#c00000'><font color=white><b>Students Listing Criteria</b></font></td></tr>
            <tr><td colspan="2">&nbsp;&nbsp;<STRONG><FONT color=black face=Arial size=2>Institute :</STRONG></FONT>
            <%
            qry="select distinct institutecode from companyinstitutetagging where nvl(deactive,'N')='N' order by institutecode ";
            rs=db.getRowset(qry);
            while(rs.next())
                {
               if(request.getParameter("x")!=null)
			{
                   
                   if(request.getParameter("radio1").equals(rs.getString(1).toString().trim()))
                    {
                      
                %><input type="radio" name="radio1" id="<%=rs.getString(1)%>" value="<%=rs.getString(1)%>" checked ><%=rs.getString(1)%> &nbsp;<%
                
               }
               else
                   {
                    %><input type="radio" name="radio1" id="<%=rs.getString(1)%>" value="<%=rs.getString(1)%>" ><%=rs.getString(1)%> &nbsp;<%
                   }
            }
               else
                   {
                   
					if(rs.getString(1).equals("JIIT"))
						mCheck="checked";
					else
						mCheck="";
				   %>
				   
				   
				   <input type="radio" name="radio1" id="<%=rs.getString(1)%>" value="<%=rs.getString(1)%>" <%=mCheck%> ><%=rs.getString(1)%> &nbsp;
				   
				   <%
                   }
               }
                
           if(request.getParameter("x")!=null)
			{
                   if(request.getParameter("radio1").equals("All"))
                    {
           %>
            <input type="radio" name="radio1" id="radio3" value="All" checked>All
            <%
            }
                   else
                       {
                       %>
            <input type="radio" name="radio1" id="radio3" value="All" >All
            <%
                       }
                   }
            else
                {
                       %>
            <input type="radio" name="radio1" id="radio3" value="All" >All
            <%
                       }
            %>
            </td>
            </tr>
			<tr><td><STRONG><FONT color=black face=Arial size=2>&nbsp;&nbsp;Name/Enrollment No Like : &nbsp; &nbsp;</FONT></STRONG></FONT></td>
			<td><INPUT ID="CandName" Name="CandName" value="<%=MName%>">
			<%
			if (request.getParameter("EORN")==null)
				mEnOrNm="";
			else
				mEnOrNm=request.getParameter("EORN").toString().trim();

			if(mEnOrNm.equals("E"))
			{
			%>
			<input type="radio" value="N" name="EORN">Name &nbsp; <input type="radio" value="E" name="EORN" checked>Enrollment No
			<%
			}
			else
			{
			%>
			<input type="radio" value="N" name="EORN" checked>Name &nbsp; <input type="radio" value="E" name="EORN">Enrollment No
			<%
			}
			%>
			<FONT size=2 color=green> &nbsp;<INPUT Type="submit" Value="Search"><br>Hint: Any word/character of Name/Enrollment No</FONT></td></tr>
			</tr>
			</table></form> 
			<%
			if(request.getParameter("x")!=null)
			{		
				try
				{
                    if (request.getParameter("radio1")==null)
					cInst="";
				else
					cInst=request.getParameter("radio1").toString().trim();
                    
				if (request.getParameter("EORN")==null)
					mEnOrNm="";
				else
					mEnOrNm=request.getParameter("EORN").toString().trim();

				if (request.getParameter("CandName")==null)
					x="%%";
				else
					x="%"+request.getParameter("CandName").toString().trim().toUpperCase()+"%";

				//out.print(cInst+"sdfsdf");

				session.setAttribute("INSCODE",cInst);

				if(mEnOrNm.equals("N"))
				{
				qry="Select nvl(ACADEMICYEAR,' ') ACADEMICYEARCODE, nvl(ENROLLMENTNO,' ') ENROLLMENTNO, nvl(STUDENTNAME,' ') STUDENTNAME, nvl(PROGRAMCODE,' ') COURSECODE, nvl(BRANCHCODE,' ') BRANCHCODE,nvl(Semester,0) Semester , StudentID SID from StudentMaster  where InstituteCode = decode( '"+cInst +"','All',InstituteCode,'"+cInst +"') and upper(StudentName) like '"+x+"' and enrollmentno is not null order by StudentName,AcademicYearCode";
				}
				else
				{
				qry="Select nvl(ACADEMICYEAR,' ') ACADEMICYEARCODE, nvl(ENROLLMENTNO,' ') ENROLLMENTNO, nvl(STUDENTNAME,' ') STUDENTNAME, nvl(PROGRAMCODE,' ') COURSECODE, nvl(BRANCHCODE,' ') BRANCHCODE,nvl(Semester,0) Semester , StudentID SID from StudentMaster  where InstituteCode= decode( '"+cInst +"','All',InstituteCode,'"+cInst +"') and EnrollmentNo like '"+x+"' and enrollmentno is not null order by StudentName,AcademicYearCode";
				}
                //out.print(qry);
				%>
				<form name="frm1" method=GET>
				<font size=4 face="arial" color="#a52a2a"><u><marquee scrolldelay=300  behavior=alternate>Click the desired Student Name to continue...</marquee></u></font>
				<TABLE class="sort-table" id="TblStdView" rules=rows cellSpacing=0 cellPadding=0 width="95%" align=center border=1>
				<thead>
				<tr bgcolor="#c00000">
				<td title="Click here to sort list on Serial Number"><b><font color="White">Sno</font></td>
				<td title="Click here to sort list on Student Name"><b><font color="White">Student Name (Enrollment No.)</font></td>
				<td title="Click here to sort list on Academic Year"><b><font color="White">Academic Year</font></td>
				<td title="Click here to sort list on Program/Branch"><b><font color="White">Program-Branch</font></td>
				<td title="Click here to sort list on Semester"><b><font color="White">Sem.</font></td>
				</tr>
				</thead>
				
				<%
				rs=db.getRowset(qry);
				while(rs.next())
				{
				qry="Select '1' data From STUDENTRESULT A where A.institutecode='"+cInst+"' And A.studentid= '"+rs.getString("SID")+"' and nvl(Fail,'N')='Y'";
				qry=qry+" UNION Select '1' Data From NRSTUDENTFAILSUBJECTS A where Institutecode='"+cInst+"' And A.studentid= '"+rs.getString("SID")+"'";
				//out.print(qry);
				ResultSet  rsChk=null;
				rsChk=db.getRowset(qry);
				if (rsChk.next())
				{
					URL="NRBackLogSubjectListFistScreenADMN.jsp";
				}
				else
				{
					URL="";
				}


					msno++;

					

					%>
					<tr>
						<td Align=right><%=msno%></td>
						
						<%
						if(URL.equals(""))
						{
						%>
						<td>  &nbsp; &nbsp; <A title='Click here to explore detailed of <%=rs.getString("StudentName")%>' href="StudAdminOption.jsp?SID=<%=rs.getString("SID")%>&amp;INSCODE=<%=cInst%>"><%=GlobalFunctions.toTtitleCase(rs.getString("StudentName"))%>&nbsp;&nbsp;(<%=rs.getString("EnrollmentNo")%>)</a></td>
						<%
						}
						else
						{
						%>
						<td>  &nbsp; &nbsp; <A title='Click here to explore detailed of <%=rs.getString("StudentName")%>' href="NRBackLogSubjectListFistScreenADMN.jsp?INSCODE=<%=cInst%>&amp;SID=<%=rs.getString("SID")%>"><%=GlobalFunctions.toTtitleCase(rs.getString("StudentName"))%>&nbsp;&nbsp;(<%=rs.getString("EnrollmentNo")%>)</a></td>
						<%
						}
						%>
						<td><%=rs.getString("AcademicYearCode")%></td>
						<td><%=rs.getString("CourseCode")%>-<%=rs.getString("BranchCode")%></td>
						<td><%=rs.getString("Semester")%></td>
						</tr>
					<%
				}
			
				%>
				</TABLE>
				<script type="text/javascript">
				var st1 = new SortableTable(document.getElementById("TblStdView"),["Number","CaseInsensitiveString","String", "CaseInsensitiveString","Number"]);
				</script>

				<%
	
		}
		catch(Exception e)
		{
			//out.print(qry);
		}
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
	<h3>	<br><img src='../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font>	<br>	<br>	<br>	<br>
   <%
	
	
   }
  //-----------------------------




}
else
{
	out.print("<br><img src='Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='index.jsp'>Login</a> to continue</font> <br>");
}

%>
</form>
</body>
</html>