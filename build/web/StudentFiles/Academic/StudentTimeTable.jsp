<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.*" %>
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
 <TITLE>#### <%=mHead%> [ Student Time Table ] </TITLE>
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
	-->
</script>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
/*
*************************************************************************************************
	' *												
	' * File Name	:	StudentTimeTable.JSP		[For Students]					
	' * Author		:	Ashok
	' * Date		:	10th July 2007								
	' * Version		:	1.0								
	' * Description	:	Student Time Table
*************************************************************************************************
*/
OLTEncryption enc=new OLTEncryption();
String qry="";
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
ResultSet rs=null;
ResultSet rs1=null;
ResultSet temprs=null;
ResultSet rsLunch=null;
ResultSet rsTableData=null;
String mWebEmail="";
String mMemberID="";
String mMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mmMemberName="";
String mAcademicYearCode="";
String mProgramCode="";
String mBranchCode="";
String mSubjID="";
String mSubjectName="";
String QrySubj="";
String mInstituteCode="";
String mExam="",mexam="";

try
{
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
		mmMemberName=GlobalFunctions.toTtitleCase(mMemberName.trim());
	}

	if (session.getAttribute("MemberCode")==null)
	{
		mMemberCode="";
	}
	else
	{
		mMemberCode=session.getAttribute("MemberCode").toString().trim();
	}
  
	if (session.getAttribute("AcademicYearCode")==null)
	{
		mAcademicYearCode="";
	}
	else
	{
		mAcademicYearCode=session.getAttribute("AcademicYearCode").toString().trim();
	}

	if (session.getAttribute("ProgramCode")==null)
	{
		mProgramCode="";
	}
	else
	{
		mProgramCode=session.getAttribute("ProgramCode").toString().trim();
	}

	if (session.getAttribute("BranchCode")==null)
	{
		mBranchCode="";
	}
	else
	{
		mBranchCode=session.getAttribute("BranchCode").toString().trim();
	}

	if (session.getAttribute("InstituteCode")==null)
	{
		mInstituteCode="";
	}
	else
	{
		mInstituteCode=session.getAttribute("InstituteCode").toString().trim();
	}
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
	{
		try
		{			
			mDMemberCode=enc.decode(mMemberCode);
			mMemberID=enc.decode(mMemberID);
		}
		catch(Exception e)
		{
			out.println(e.getMessage());
		}

		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk=null;
	  //-----------------------------
	  //-- Enable Security Page Level  
	  //-----------------------------
		qry="Select WEBKIOSK.ShowLink('134','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{
		  //----------------------
%>
		<form name="frm"  method="get" >
		<input id="x" name="x" type=hidden>
		<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
		<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">Time Table</font></td></tr>
		</TABLE>
		<table cellpadding=1 cellspacing=0 align=center rules=groups border=2>
		<tr>
		<!--*********Exam**********-->
		<td><FONT color=black face=Arial size=2><STRONG>&nbsp;Exam Code</STRONG></FONT>
		&nbsp; &nbsp;
		<%
		try
		{

			qry="Select distinct ExamCode Exam from TT#TIMETABLEDATA ";
			qry=qry + " where INSTITUTECODE='"+mInstituteCode+"' and (fstid) in";
			qry=qry +"(Select fstid from V#STUDENTLTPDETAIL where STUDENTID='"+mMemberID+"')";
			rs=db.getRowset(qry);

			if (request.getParameter("x")==null) 
			{	
		%>
				<select name=Exam tabindex="0" id="Exam" style="WIDTH: 120px">
		<%   
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
		%>	
				<select name=Exam tabindex="0" id="Exam" style="WIDTH: 120px">	
		<%
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
		</td>
		<!--*********Exam**********-->
	
		<!--*********Subject**********-->
	 	<td><FONT color=black face=Arial size=2><STRONG>Subject Name :</STRONG></FONT>&nbsp;&nbsp;&nbsp;
 		<%

		try
		{
			qry="select B.SUBJECTID, B.SUBJECT||' ('||B.SUBJECTCODE||')' SUBJECT from TT#TIMETABLEDATA A, ";
			qry=qry+" SUBJECTMASTER B  where (A.fstid) in (select fstid from V#STUDENTLTPDETAIL ";
			qry=qry+" where studentid='"+mMemberID+"' and a.subjectID=b.subjectID and ";
			qry=qry+" examcode='"+mExam+"') Group By B.SUBJECTID, B.SUBJECT||' ('||B.SUBJECTCODE||')' order by subject";
			rs=db.getRowset(qry);
		 %>

			<select name="Subject" tabindex="1" id="Subject" style="WIDTH: 230px"> 
	  <%
			if (request.getParameter("x")==null) 
			 {
				QrySubj="ALL";
	  %>
				<OPTION selected value=ALL>ALL</option>
	  <%
				while(rs.next())
				{
					mSubjID=rs.getString("SUBJECTID");
			 		mSubjectName=rs.getString("SUBJECT");
		%>
					<option value=<%=mSubjID%>><%=GlobalFunctions.toTtitleCase(mSubjectName)%></option>
		<%
				}	
			}
			else
			{
				if (request.getParameter("Subject").toString().trim().equals("ALL"))
	 			{
					QrySubj="ALL";
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
					mSubjID=rs.getString("SUBJECTID");
		 			mSubjectName=rs.getString("SUBJECT");
				   	if(mSubjID.equals(request.getParameter("Subject").toString().trim()))
					{
						QrySubj=mSubjID;
					%>
						<option selected value=<%=mSubjID%>><%=GlobalFunctions.toTtitleCase(mSubjectName)%></option>
					<%
					}
					else
				  	{
 	%>
						<option  value=<%=mSubjID%>><%=GlobalFunctions.toTtitleCase(mSubjectName)%></option>
 	<%	
					}	
				}
			}
		}
		catch(Exception e)
		{
			
		}
		%>
		&nbsp;
		</select>
		</td></tr>
		<!--*********Subject**********-->
		<tr>
		<td colspan=2 align=right>
		<INPUT Type="submit" Value="Display/Refresh"></td></tr>
		</table></form>
		<!--*********Time Table**********-->
		<%	
		//*********Session Time**********
		qry="select distinct to_char(FROMSESSIONTIME,'hh24:mi PM') FROMSESSIONTIME,";
		qry=qry+" to_char(TOSESSIONTIME,'hh24:mi AM') TOSESSIONTIME from TT#TIMETABLEDATA ";
		qry=qry+" where (FSTID) in (select distinct FSTID from V#STUDENTLTPDETAIL where ";
		qry=qry+" STUDENTID='"+mMemberID+"' and SUBJECTID=Decode('"+QrySubj+"','ALL',SUBJECTID,'"+QrySubj+"'))";
		qry=qry+" UNION select distinct to_char(FROMTIME,'hh24:mi PM') FROMTIME,";
		qry=qry+" to_char(TOTIME,'hh24:mi AM')TOTIME from TT#LUNCHTIME ";
		qry=qry+" WHERE EXAMCODE = '"+mExam+"'ORDER BY 1, 2";
		temprs=db.getRowset(qry);
		ArrayList ar = new ArrayList();
		int ctr=0;
	
%>	
		<!--*********Session Time**********-->
		
<%		
		//************Working Days*************
		qry="select Distinct decode ( AllocationDay ,'Sunday','1','Monday','2', 'Tuesday',";
		qry=qry+" '3', 'Wednesday','4', 'Thusday','5', 'Friday','6', 'Saturday','7'),";
		qry=qry+" Allocationday   from  TT#TIMETABLEDATA  where (FSTID) in (select distinct"; 
		qry=qry+" FSTID from V#STUDENTLTPDETAIL where STUDENTID='"+mMemberID+"' and EXAMCODE = '"+mExam+"' and "; 
		qry=qry+" SUBJECTID=Decode('"+QrySubj+"','ALL',SUBJECTID,'"+QrySubj+"')) ORDER BY 1,2";
		rs=db.getRowset(qry);
%>
<table bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=columns topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center>	
<%
		try
		{
			while(rs.next())
			{
			//************Loop for Session Time*******************
				if(ctr==0)
				{
%>				
					<thead>
					<tr bgcolor="#ff8c00">
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
<%
					while(temprs.next())
					{
						String Tabletime = temprs.getString("FROMSESSIONTIME");
						int len=Tabletime.length();
						int j=Tabletime.indexOf(":");
						String s=Tabletime.substring(0,j);
						int hr=Integer.parseInt(s);
						s=Tabletime.substring(j,len);
						if(hr>12)
						{
%>						
							<td align=center><b><font color="white"><%=(hr-12)%><%=s%></font>&nbsp;&nbsp;</td>
<%					
						}
						else
						{
%>
							<td align=center><b><font color="white"><%=Tabletime%></font>&nbsp;&nbsp;</td>
<%
						}
						ar.add(Tabletime);
						ctr=1;
					}
				}
			//************Closing Loop for Session Time*******************
%>
				</tr></thead>
<%
			//*********Printing workding days*****************
				String AllocateDay = rs.getString("ALLOCATIONDAY") ;
				String Allocate=AllocateDay.substring(0,3);
%>
				<tbody><tr><td bgcolor="#ff8c00"><b><font color="white"><center>&nbsp;&nbsp;<%=Allocate%>&nbsp;&nbsp;</center></font>&nbsp;&nbsp;</td>
<%	
				Iterator i = ar.iterator();
				//********Loop for printing Time Table Data***********
				while(i.hasNext())
				{
					String FromTime = (String)i.next();
					qry= "select B.SUBJECTCODE, A.LTP, A.ROOMSHORTNAME, A.FACULTYSHORTNAME ";
					qry=qry+" from TT#TIMETABLEDATA A, Subjectmaster B  where A.EXAMCODE = '"+mExam+"' AND ";
					qry=qry+" A.SUBJECTID=Decode('"+QrySubj+"','ALL',A.SUBJECTID,'"+QrySubj+"') ";
					qry=qry+" AND A.SUBJECTID=B.SUBJECTID AND A.INSTITUTECODE=B.INSTITUTECODE AND to_char(A.FROMSESSIONTIME,'hh24:mi PM')= '"+FromTime+"' AND ";
					qry=qry+"	A.ALLOCATIONDAY ='"+AllocateDay+"' and A.fstid in(select C.FSTID ";
					qry=qry+" from V#STUDENTLTPDETAIL C where C.STUDENTID='"+mMemberID+"')";
					rsTableData = db.getRowset(qry); 
					// out.print(qry);
					if(rsTableData.next())
					{
%>
					<!--*********Time Table Data**********-->
						<td><b><font size=2><%=rsTableData.getString("SUBJECTCODE")%></font><br>
						<font color="#c00000" size=2><%=rsTableData.getString("LTP")%>&nbsp;&nbsp;&nbsp;&nbsp;<%=rsTableData.getString("ROOMSHORTNAME")%></font><br>
						<font size=2><%=rsTableData.getString("FACULTYSHORTNAME")%></font>
						</b></td>
					<!--*********Time Table Data**********-->
<%
					}
					else 
					{
						qry = "select FROMTIME from TT#LUNCHTIME where ";
						qry=qry+" EXAMCODE = '"+mExam+"' AND to_char(FROMTIME,'hh24:mi PM')= '"+FromTime+"'  GROUP BY FROMTIME";
						rsLunch = db.getRowset(qry); 
						if(rsLunch.next())
						{
						//*********Lunch Time**********
							out.println("<td align='center'><font color='#ff8c00'><B>Lunch</B></font></td>");
						}
						else
						{
							 out.println("<td align='center'><b><font color='#ff8c00'>---</font></b></td>");
						}
					}
				}
			//********Closing Loop for printing Time Table Data***********
	%>
			</TR></tbody>
	<%
			}
		}
		catch(Exception e)
		{
		}
%>
</TABLE>

<%
   //-----------------------------
  //-- Enable Security Page Level  
 //------------------------------
	}
	else
	{
   %>
		<br>
		<font color=red>
		<h3>	<br><img src='../../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
		<P>	This page is not authorized/available for you.
		<br>For assistance, contact your network support team. 
		</font>	<br>	<br>	<br>	<br>
   <%
	}
}
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}
}
catch(Exception e)
{
//	out.print(qry);
}
%>
<table ALIGN=Center VALIGN=TOP>
<tr>
	<td valign=middle><br><br>
	<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">	<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br><FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>
	</td>
</tr>
</table>
</body>
</html>