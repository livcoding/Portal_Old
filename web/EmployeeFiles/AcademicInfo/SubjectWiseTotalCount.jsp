<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
ResultSet rs2=null,rsg=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="";
String qry2="";
String qry1="",mLTP="",mBasket="",mTagg="";
long mSNo=0;
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInstitute="",mInst="";
String mExam="",mSubject="",mexam="",mSubj="",mGroup="",mcolor="",mCode="",mES="",mSubj1="";
String mSection="",mSubsection="",mName1="",mName2="",mName3="",mName4="",mName5="";
String mSExam="";
String mSES="";
String qryexam="",qrysubj="",qrysec="";
String mPrn="N",mComp="";
int Total=0,mCount=0;
int Total1=0,mCount1=0;

if (session.getAttribute("MemberID")==null)
{
	mMemberID="";
}
else
{
	mMemberID=session.getAttribute("MemberID").toString().trim();
}



if (session.getAttribute("InstituteCode")==null)
{
	mInstitute="";
	mInst="";
}
else
{
	mInstitute=session.getAttribute("InstituteCode").toString().trim();
	mInst=mInstitute;
}


if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
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
<TITLE>#### <%=mHead%> [ Students Wise List ] </TITLE>

<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<script language=javascript>
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

function AlertMe()
{
	document.dd.twait.value=" ";
}
</script>
</head>
<body  onload="AlertMe()" aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
try
{
if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{	OLTEncryption enc=new OLTEncryption();
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
		qry="Select WEBKIOSK.ShowLink('86','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
 		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	  	{
				
  //----------------------
%>
<form name="frm"  method="get"  >
<input id="x" name="x" type=hidden>
<table id=id1 width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana"><b>Faculty cum Subject Wise Students Total</b></TD>
</font></td></tr>
</TABLE>
<table  cellpadding=3 cellspacing=1 align=center rules=groups border=1>
<!--Institute****-->
<Input Type=hidden name=InstCode Value=<%=mInstitute%>>
<!--*********Exam**********-->
<br>
<tr><td nowrap><FONT color=black face=Arial size=2><b>Exam Code</b></FONT>
<%
try
{
	 qry="Select  nvl(EXAMCODE,' ') Exam , EXAMPERIODFROM from EXAMMASTER Where ";
	qry=qry+"  InstituteCode='"+mInst+"' And  nvl(Deactive,'N')='N' and Nvl(LOCKEXAM,'N')='N' and Nvl(FINALIZED,'N')='N' AND NVL(EXCLUDEINATTENDANCE,'N')='N' order by EXAMPERIODFROM DESC";
/*	qry=qry+" and examcode not in ( select examcode from V#StudentAttendance where  institutecode='"+mInst+"' group by examcode)	order by EXAMPERIODFROM DESC";
	qry=qry+" and examcode not in (SELECT EXAMCODE FROM GRADECALCULATION WHERE InstituteCode='"+mInst+"' ) 	order by EXAMPERIODFROM DESC";*/
	rs=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		%>
		<Select Name=Exam tabindex="0" id="Exam" style="WIDTH: 150px"  >	
		<%   
		while(rs.next())
		{
			mExam=rs.getString("Exam");
			if(mexam.equals(""))
 			{
			mexam=mExam;
			qryexam=mExam;
			%>
			<OPTION Selected Value =<%=mExam%>><%=rs.getString("Exam")%></option>
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
	//out.print(qry);
	}
	else
	{
		%>	
		<select name=Exam tabindex="0" id="Exam" style="WIDTH: 150px" >	
		<%
		while(rs.next())
		{
			mExam=rs.getString("Exam");
			if(mExam.equals(request.getParameter("Exam").toString().trim()))
 			{
				mexam=mExam;
				qryexam=mExam;
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
	// out.println("Error Msg");
}
%>
</TD>
<TD>
<FONT color=black><FONT face=Arial size=2><STRONG>LTP </STRONG></FONT></FONT>
<select name=LTP tabindex="0" id="LTP" style="WIDTH: 90px">
<% 	if(request.getParameter("LTP")==null)
   	{
 %>			
	<OPTION Value =L selected>Lecture</option>
	<OPTION Value =T>Tutorial</option>
	<OPTION Value =P>Practical</option>
<%
  	}
  else
   {
	mLTP=request.getParameter("LTP");
	if(mLTP.equals("L"))
	{
%>
	<OPTION Value =L selected>Lecture</option>
	<OPTION Value =T>Tutorial</option>
	<OPTION Value =P>Practical</option>
<%
      }
	else if(mLTP.equals("T"))
	{
	%>
	<OPTION Value =L selected>Lecture</option>
	<OPTION Selected Value =T>Tutorial</option>
	<OPTION Value =P>Practical</option>
	<%		
	}
	else if(mLTP.equals("P"))
	{
	%>
	<OPTION Value =L selected>Lecture</option>
	<OPTION Value =T>Tutorial</option>
	<OPTION Value =P Selected>Practical</option>
	<%		
	}
    }		
%>
</select>
</td>
<TD>
	<INPUT Type="submit" Value="Show/Refresh">
	&nbsp;
	</td>
	</tr>
	</table>
	</form>
<center>	
<form name="dd" id="dd">
<center>
<input style="width:220px;font-size:18px;position:absolute;text-align:middle;
	color:red;font-weight:bold;BORDER-LEFT: c00000 0px solid;BORDER-TOP: c00000 0px solid;
	BORDER-RIGHT: c00000 0px solid;BORDER-BOTTOM: c00000 0px solid ;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden;"  name="twait" id="twait" readonly type="text" value="Please Wait...">
</center>
</form>	
</center>	

<%	
	if(request.getParameter("x")!=null)
	{
	mExam=request.getParameter("Exam").toString().trim();
	mLTP=request.getParameter("LTP").toString().trim();
%>
<form name="frm1"  method="post" Action="SubjectWiseTotalCountXLS.jsp"> 
		
	<table bgcolor=#fce9c5 class="sort-table" id="table-1" width='98%' bottommargin=0  topmargin=0 cellspacing=2 cellpadding=2 border=1 align=center>	
	<thead>
	<tr bgcolor="#ff8c00">
	<td Title="Sort on CTR"><b><font color=white size=2>Sr.No.</font></b></td>

	 <td Title="Sort on Program Code"><b><font color=white>Subject Code</font></b></td> 
	
	<td Title="Sort on Subject Code"><b><font color=white size=2>Subject Name</font></b></td>
<td Title="Sort on Faculty Name"><b><font color=white size=2>Faculty</font></b></td>
<td Title="Sort on Subject Code"><b><font color=white size=2>SubSection - Total REGULAR Student </font></b></td>
	<td Title="Sort on Total Student"><b><font color=white size=2>Total REGULAR Students </font></b></td>
	<td Title="Sort on Subject Code"><b><font color=white size=2>SubSection - Total RWJ Student  </font></b></td>
	<td Title="Sort on Total Student"><b><font color=white size=2>Total RWJ Students </font></b></td>
	</tr>
	</thead>
	<tbody>
	
<%
	
qry="SELECT distinct nvl(B.SUBJECTID,' ') SUBJECTID, NVL (b.subjectcode, ' ') subjectcode,   nvl(a.EMPLOYEEID,' ') EMPLOYEEID,nvl(c.EMPLOYEENAME,' ') EMPLOYEENAME,  nvl(b.SUBJECT,' ')  SUBJECT FROM facultysubjecttagging a, subjectmaster b,employeemaster c   WHERE  a.EXAMCODE='"+mExam+"'    AND A.INSTITUTECODE='"+mInst+"'      AND LTP='"+mLTP+"'   AND NVL(A.DEACTIVE,'N')='N' AND NVL(B.DEACTIVE,'N')='N' AND NVL(C.DEACTIVE,'N')='N'  and a.SUBJECTID=b.SUBJECTID   and a.INSTITUTECODE=b.INSTITUTECODE   and a.EMPLOYEEID=c.EMPLOYEEID   and a.COMPANYCODE=c.COMPANYCODE   and a.COMPANYCODE='"+mComp+"'      AND A.FSTID IN (   SELECT FSTID FROM v#studentltpdetail WHERE   EXAMCODE='"+mExam+"'    AND INSTITUTECODE='"+mInst+"'   AND NVL(DEACTIVE,'N')='N' AND NVL(STUDENTDEACTIVE,'N')='N'   )  	 order by SUBJECT,EMPLOYEENAME ";

/*qry="SELECT    NVL (a.academicyear, ' ') academicyear,         NVL (a.programcode, ' ') programcode,         NVL (a.sectionbranch, ' ') sectionbranch,         NVL (b.subjectcode, ' ') subjectcode, a.employeeid,         c.employeename employeename, a.subsectioncode subsectioncode,         b.subject subject,COUNT(STUDENTID) CCC    FROM V#STUDENTLTPDETAIL a, subjectmaster b, employeemaster c   WHERE a.examcode = '"+mExam+"'      AND a.institutecode ='"+mInst+"'       AND ltp = '"+mLTP+"'     AND NVL (a.deactive, 'N') = 'N'     AND a.subjectid = b.subjectid     AND a.institutecode = b.institutecode     AND a.employeeid = c.employeeid     AND a.companycode = c.companycode     AND a.companycode = '"+mComp+"'      AND a.fstid IN (            SELECT fstid              FROM FACULTYSUBJECTTAGGING             WHERE examcode = '"+mExam+"'               AND institutecode = '"+mInst+"'               AND NVL (deactive, 'N') = 'N'               )               gROUP BY  NVL (a.academicyear, ' ') ,         NVL (a.programcode, ' ') ,         NVL (a.sectionbranch, ' '),         NVL (b.subjectcode, ' ') , a.employeeid,         c.employeename , a.subsectioncode ,         b.subject ORDER BY academicyear, programcode, sectionbranch, subjectcode ";*/

	rs1=db.getRowset(qry);
	//out.print(qry);
 	   int Ctr=0;
	   while(rs1.next())
	   {
		Ctr++;
		
	
		%>
		<tr bgcolor="">
		<td><font size=2><%=Ctr%>.</font></td>
		
		
			<td nowrap>&nbsp;<font size=2><%=rs1.getString("SUBJECTCODE")%></td>
			<td nowrap>&nbsp;<font size=2><%=rs1.getString("SUBJECT")%></font></td>
			<td>&nbsp;<font size=2><%=rs1.getString("EMPLOYEENAME")%></font></td>
			<td>
			<%

				qry1="SELECT  distinct  NVL (b.subjectcode, ' ') subjectcode, nvl(a.employeeid,' ')employeeid,nvl(c.employeename,' ') employeename,nvl(b.subject,' ') subject,nvl(a.SUBSECTIONCODE,' ') SUBSECTIONCODE, count(a.studentid)ccc    FROM V#STUDENTLTPDETAIL a, subjectmaster b, employeemaster c   WHERE a.examcode = '"+mExam+"' and NVL(a.semestertype,'N')='REG'    AND a.institutecode = '"+mInst+"'      AND ltp ='"+mLTP+"'          AND NVL (a.deactive, 'N') = 'N'     AND a.subjectid = b.subjectid AND NVL(A.STUDENTDEACTIVE,'N')='N'     AND a.institutecode = b.institutecode     AND a.employeeid = c.employeeid     AND a.companycode = c.companycode     and a.SUBJECTID='"+rs1.getString("SUBJECTID")+"'	  and a.EMPLOYEEID='"+rs1.getString("EMPLOYEEID")+"'     AND a.companycode = '"+mComp+"'      AND a.fstid IN (            SELECT fstid              FROM FACULTYSUBJECTTAGGING             WHERE examcode = '"+mExam+"'               AND institutecode = '"+mInst+"'  and ltp ='"+mLTP+"'                    AND NVL (deactive, 'N') = 'N'               )               gROUP BY           NVL   (b.subjectcode, ' ') , a.employeeid,         c.employeename ,  b.subject ,a.SUBSECTIONCODE     ORDER BY SUBSECTIONCODE ";
				//out.print(qry1);
				rs=db.getRowset(qry1);
				while (rs.next())
				{
					mCount=rs.getInt("ccc");
					Total=Total+mCount;
					%>
					&nbsp;<b><font size=2><%=rs.getString("SUBSECTIONCODE")%>-<%=mCount%></B><BR></font>
					
					<%
				}
					

				%>&nbsp;
				</td>
				<td>	
					<%
					if(Total==0)
					{
					%>
						<font size=2><B>-</B></font>
					<%
					}
					else
					{
						%>
						<font size=2><B><%=Total%></B></font>
						<%
					}
					%>
					</td>
				<td>
			<%

				qry="SELECT  distinct  NVL (b.subjectcode, ' ') subjectcode, nvl(a.employeeid,' ')employeeid,nvl(c.employeename,' ') employeename,nvl(b.subject,' ') subject,nvl(a.SUBSECTIONCODE,' ') SUBSECTIONCODE, count(a.studentid)ccc    FROM V#STUDENTLTPDETAIL a, subjectmaster b, employeemaster c   WHERE a.examcode = '"+mExam+"' and a.SEMESTERTYPE in ('RWJ','SAP' )   AND a.institutecode = '"+mInst+"'      AND ltp ='"+mLTP+"'          AND NVL (a.deactive, 'N') = 'N'     AND a.subjectid = b.subjectid AND NVL(A.STUDENTDEACTIVE,'N')='N'     AND a.institutecode = b.institutecode     AND a.employeeid = c.employeeid     AND a.companycode = c.companycode     and a.SUBJECTID='"+rs1.getString("SUBJECTID")+"'	  and a.EMPLOYEEID='"+rs1.getString("EMPLOYEEID")+"'     AND a.companycode = '"+mComp+"'      AND a.fstid IN (            SELECT fstid              FROM FACULTYSUBJECTTAGGING             WHERE examcode = '"+mExam+"'               AND institutecode = '"+mInst+"'  and ltp ='"+mLTP+"'                    AND NVL (deactive, 'N') = 'N'               )               gROUP BY           NVL   (b.subjectcode, ' ') , a.employeeid,         c.employeename ,  b.subject ,a.SUBSECTIONCODE     ORDER BY SUBSECTIONCODE ";
				//out.print(qry1);
				rsg=db.getRowset(qry);
				while (rsg.next())
				{
					mCount1=rsg.getInt("ccc");
					Total1=Total1+mCount1;
					%>
					&nbsp;<b><font size=2><%=rsg.getString("SUBSECTIONCODE")%>-<%=mCount1%></B><BR></font>
						<%
				}
				%>&nbsp;
				</td>
				<td>	
					<%
					if(Total1==0)
					{
					%>
						<font size=2><B>-</B></font>
					<%
					}
					else
					{
						%>
						<font size=2><B><%=Total1%></B></font>
						<%
					}
					%>
					</td>
		
		</tr>

	<%         Total=0;	
				Total1=0;						
		 }	

	%>
		
		</tbody>
		</table>
	
			<script type="text/javascript">
   			var st1 = new SortableTable(document.getElementById("table-1"),["Number", "String", "CaseInsensitiveString","CaseInsensitiveString", "CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","Number"]);
		</script>
		<INPUT TYPE="hidden" NAME="ExamCode" value='<%=mExam%>'  > 
		<INPUT TYPE="hidden" NAME="LTP" value='<%=mLTP%>'  > 
		<table bgcolor=#fce9c5 class="sort-table" id="table-1"  bottommargin=0 rules=rows topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center>
					<tr><td align=center colspan=7>
					<font color=blue><a onClick="window.print();">
					<img src="../../../Images/printer.gif"  style="cursor:hand"><b>Click to Print</b></a>
				
					&nbsp;&nbsp;&nbsp;&nbsp;
					<INPUT Type="submit" Value="Save In Excel">
							</td>	
					</tr>
					</table>
	<%
	     }
      
//-----------------------------
//---Enable Security Page Level  
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
//	out.print("error"+qry);	
}
%>
	</form>
</body>
</html>


