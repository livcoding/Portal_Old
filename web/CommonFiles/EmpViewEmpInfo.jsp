<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %> 
<%
String mHead="",mCompCode ="";
String mCandCode="", MName="";
String mCandName="";
String mDt="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<TITLE>#### <%=mHead%> [ View Employee Profile/information ] </TITLE>


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
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="",mCheck="",cInst="";
String qry="",x="";
int msno=0;
ResultSet rs=null;


String mDept="",mDesignation="",qry1="",qry2="";
ResultSet rs1=null,rs2=null;



				session.setAttribute("INSCODE","");

				session.setAttribute("COMPCODE","");

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

if (session.getAttribute("CompanyCode")==null)
{
	mCompCode="JIIT";
}
else
{
	mCompCode=session.getAttribute("CompanyCode").toString().trim();
}

OLTEncryption enc=new OLTEncryption();
   if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
	{
		mMemberCode=enc.decode(mMemberCode);
		mMemberType=enc.decode(mMemberType);
		mMemberID=enc.decode(mMemberID);
		
		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk1=null;
		  //-----------------------------
		  //-- Enable Security Page Level  
		  //-----------------------------
		qry="Select WEBKIOSK.ShowLink('72','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
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
			<table cellpadding=0 cellspacing=0 align=center rules=groups width=40% border=1>
			<tr><td align=center colspan=2 bgcolor='#c00000'><font color=white><b>Employee Listing Criteria</b></font></td></tr>

 
 
 <tr><td colspan="2">&nbsp;&nbsp;<STRONG><FONT color=black face=Arial size=2>Institute :</STRONG></FONT>
            <%
            qry="select distinct institutecode from companyinstitutetagging where nvl(deactive,'N')='N' and institutecode not in ('J128','JISF') order by institutecode ";
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
                
        

            %>
            </td>
            </tr>




			<tr><td valign="top"><STRONG><FONT color=black face=Arial size=2>&nbsp;&nbsp;Employee Name like:</FONT></STRONG></FONT></td>
			<td><INPUT ID="CandName" Name="CandName" value="<%=MName%>"><FONT size=2 color=green> &nbsp; <INPUT Type="submit" Value="Search"><br>Hint: Any word/character of Name</FONT></td></tr>
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

			  qry="select distinct COMPANYCODE from companyinstitutetagging where nvl(deactive,'N')='N' and institutecode='"+cInst+"' order by institutecode ";
            rs=db.getRowset(qry);
            if(rs.next())
				mCompCode=rs.getString("COMPANYCODE");




				session.setAttribute("INSCODE",cInst);

				session.setAttribute("COMPCODE",mCompCode);

			//	session.setAttribute("INSCODE",cInst);


				if (request.getParameter("CandName")==null)
					x="%%";
				else
					x="%"+request.getParameter("CandName").toString().trim().toUpperCase()+"%";
			


				qry="Select EMPLOYEEID, nvl(EmployeeCode,' ') EmployeeCode,nvl( EMPLOYEENAME,' ')  EMPLOYEENAME, nvl(DESIGNATIONCODE,' ') DESIGNATIONCODE, nvl(DEPARTMENTCODE,' ') DEPARTMENTCODE,To_char(DATEOFJOINING,'dd-mm-yyyy') DATEOFJOINING, nvl(GRADECODE,' ') GRADECODE, nvl(EMPLOYEETYPE,' ') EMPLOYEETYPE  from EmployeeMaster  where CompanyCode=decode('"+mCompCode+"','ALL','ALL','"+mCompCode+"')   and upper(EmployeeName) like '"+x+"' and  nvl(deactive,'N')='N'  order by EmployeeName,EmployeeCode";
				
				%>
				<font size=4 face="arial" color="#a52a2a"><u><marquee behavior=alternate scrolldelay=300>Click the desired Employee Name to continue...</marquee></u></font>
				<table class="sort-table" id="TblEmpView" rules=rows cellSpacing=1 cellPadding=0 width="95%" align=center border=1>
				<thead>
				<tr bgcolor="#c00000">
				<td title="Click here to sort list on Serial No."><font color="white">Sno</font></td>
				<td title="Click here to sort list on Employee Name"><font color="white">Employee Name (Code)</font></td>
				<td title="Click here to sort list on Designation"><font color="white">Designation</font></td>
				<td title="Click here to sort list on Department"><font color="white">Department</font></td>
				<td title="Click here to sort list on Joining Date"><font color="white">Joining Date</font></td>
				<td title="Click here to sort list on Employee Grade/Type"> <font color="white">Grade (Type)</font></td>
				</tr>
				</thead>
				<%
				rs=db.getRowset(qry);
				while(rs.next())
				{	msno++;
					if (rs.getString("DATEOFJOINING")==null)
						mDt="";
					else
						mDt=rs.getString("DATEOFJOINING");
				

				qry1=" select designation from DESIGNATIONMASTER where DESIGNATIONCODE='"+rs.getString("DESIGNATIONCODE")+"' ";
				rs1=db.getRowset(qry1);
					if(rs1.next())
					{
						mDesignation=rs1.getString("designation");
					}


				qry2=" select DEPARTMENT from DEPARTMENTMASTER where DEPARTMENTCODE='"+rs.getString("DEPARTMENTCODE")+"' ";
				rs2=db.getRowset(qry2);
					if(rs2.next())
					{
						mDept=rs2.getString("DEPARTMENT");
					}



					%>
					<tr>
						<td Align=right><%=msno%></td>
						<td nowrap>&nbsp;<font size=2><A title='Click here to explore detailed of <%=rs.getString("EmployeeName")%>' href="EmpAdminOption.jsp?SID=<%=rs.getString("EmployeeID")%>&amp;INSCODE=<%=cInst%>&amp;COMPCODE=<%=mCompCode%>"><%=rs.getString("EmployeeName")%>&nbsp;&nbsp;(<%=rs.getString("EmployeeCode")%>)</a></font></td>
						<td><font size=2x	><%=mDesignation%></font></td>
						<td><font size=2x	><%=mDept%></font></td>
						<td><font size=2><%=mDt%></font></td>
						<td><font size=2><%=rs.getString("GRADECODE")%> (<%=rs.getString("EMPLOYEETYPE")%>)</font></td>
						</tr>
					<%
				}
			
				%>
				</table>
				<script type="text/javascript">
				var st1 = new SortableTable(document.getElementById("TblEmpView"),["Number","CaseInsensitiveString","CaseInsensitiveString", "CaseInsensitiveString","Date","CaseInsensitiveString"]);
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
</body>
</html>