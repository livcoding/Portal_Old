<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>

<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JUIT ";
%>


<HTML>
<head>
<TITLE>#### <%=mHead%> [ View Student Subject Marks (Eventwise) ] </TITLE>
<script type="text/javascript" src="../js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="../css/sortabletable.css" />


<script>
	if(window.history.forward(1) != null)
	window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
/*
'
*************************************************************************************************
	' *
	' * File Name:	StudentEventMarksViewjsp.JSP		[For Students]
	' * Author:		Ashok   
	' * Date:		24th Nov 2006
	' * Version:		1.0
	' * Description:	Pre Registration of Students
*************************************************************************************************
*/
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();
String qry="",mWebEmail="",EmpIDType="";
String qry1="";
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
String mInst="";
int msno=0;
String mExamCode="",mexamcode="",mexam="",mProg="",mBranch="",mSem="",mName="";
String mINSTITUTECODE="";
String mEmployeeID="";
String mSUBJECTCODE="";
String mEName="",msubj="",mSubj="",mSubjcode="",aa="",mDet="";
ResultSet rs=null,rs1=null;
ArrayList subevents=new ArrayList();
double mWeig=0,mMax=0,mvalue1=0,mTot=0;

GlobalFunctions gb =new GlobalFunctions();

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
if (session.getAttribute("InstituteCode")==null)
{
	mINSTITUTECODE="";
}
else
{
	mINSTITUTECODE=session.getAttribute("InstituteCode").toString().trim();
}
if (session.getAttribute("ProgramCode")==null)
{
	mProg="";
}
else
{
	mProg=session.getAttribute("ProgramCode").toString().trim();
}

if (session.getAttribute("BranchCode")==null)
{
	mBranch="";
}
else
{
	mBranch=session.getAttribute("BranchCode").toString().trim();
}

if (session.getAttribute("CurrentSem")==null)
{
	mSem="";
}
else
{
	mSem=session.getAttribute("CurrentSem").toString().trim();
}

if (session.getAttribute("MemberName")==null)
{
	mName="";
}
else
{
	mName=session.getAttribute("MemberName").toString().trim();
}
try
{
//1
	if(!mMemberID.equals("") && !mMemberType.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{
	//2
		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mMacAddress =" "; //session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk=null;
	  //-----------------------------
	  //-- Enable Security Page Level
	  //-----------------------------
		qry="Select WEBKIOSK.ShowLink('62','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	      RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{
	  //----------------------
			try
			{
				mDMemberCode=enc.decode(mMemberCode);
				mMemberID=enc.decode(mMemberID);
				mMemberType=enc.decode(mMemberType);
			}
			catch(Exception e)
			{
				//out.println(e.getMessage());
			}
			%>
			<form name="frm" method=get>
			<input id="x" name="x" type=hidden>
			<table  ALIGN=CENTER bottommargin=0  topmargin=0>
			<tr>
			<TD align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana"><strong>Student Subject Marks (Eventwise)</strong></font>
			</td>
			</tr>
			</table>
			<table rules=groups cellspacing=1 cellpadding=1 align=center border=1>
			<tr><td>&nbsp;<font color=#00008b face=arial size=2><STRONG> Name:&nbsp;</STRONG></font><%=GlobalFunctions.toTtitleCase(mName)%>[<%=mDMemberCode%>]
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color=#00008b face=arial size=2><STRONG>Course/Branch:&nbsp;</STRONG></font><%=mProg%>(<%=mBranch%>)
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color=#00008b face=arial size=2><STRONG>Current Semester:&nbsp;</STRONG></font><%=mSem%></td></tr>
			<tr><td ALIGN=CENTER><HR>&nbsp;&nbsp;<font color=#00008b face=arial size=2><STRONG>Exam Code</STRONG></font>
			<%
			// qry="select distinct nvl(examcode,' ')examcode, EXAMPERIODFROM from exammaster where institutecode='"+mINSTITUTECODE+"' and nvl(deactive,'N')='N' and nvl(FINALIZED,'N')='N' and nvl(PUBLISHED,'N')='Y'  order by EXAMPERIODFROM Desc";
			//qry="select distinct nvl(examcode,' ')examcode, EXAMPERIODFROM from exammaster where institutecode='"+mINSTITUTECODE+"' and nvl(deactive,'N')='N' and nvl(FINALIZED,'N')='N' and nvl(LOCKEXAM,'N')='N'  order by EXAMPERIODFROM Desc";

			mInst=mINSTITUTECODE;

			qry="select distinct nvl(examcode,' ')examcode, EXAMPERIODFROM from exammaster where institutecode='"+mINSTITUTECODE+"'";
			qry=qry+" and nvl(deactive,'N')='N' and nvl(LOCKEXAM,'N')='N' and       EXAMPERIODFROM  >= to_date('1-jul-2012') and  EXAMCODE IN (SELECT EXAMCODE FROM V#studenteventsubjectmarks where studentid='"+mChkMemID+"'	AND    institutecode='"+mINSTITUTECODE+"') order by EXAMPERIODFROM Desc";

			rs=db.getRowset(qry);
			//out.print(qry);
			%>
			<select name=exam tabindex="0" id="exam" style="WIDTH: 120px">
			<%
		  	if(request.getParameter("x")==null)
			{
				%>
				<OPTION  value='N'><--Select--></option>
				<%
				while(rs.next())
				{
					mexamcode=rs.getString("examcode");
					if(mexam.equals(""))
						mexam=mexamcode;
					%>
					<option  value=<%=mexamcode%>><%=mexamcode%></option>
					<%
				}
			 }
			else
			{
				if (request.getParameter("exam").toString().trim().equals("ALL"))
		 		{
					%>
			 				<OPTION selected value='N'><--Select--></option>
					<%
				}
				else
				{
					%>
					<OPTION  value='N'><--Select--></option>
					<%
				}
				while(rs.next())
				{
					mexamcode=rs.getString("examcode");
					if(mexamcode.equals(request.getParameter("exam").toString().trim()))
				{
					%>
					<option selected value=<%=mexamcode%>><%=mexamcode%></option>
					<%
				}
				else
				{
					%>
					<option  value=<%=mexamcode%>><%=mexamcode%></option>
					<%
				}
			}
		}
		%>
		</select>
		&nbsp;<input type="submit" value="Show"></td></tr>
		</table>
		<%
		if(request.getParameter("x")!=null)
		{
			mexam=request.getParameter("exam").toString().trim();

		%>
		<table bgcolor=#fce9c5 class="sort-table" id="table-1"  rules=rows topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center width="100%">
		<thead>
		<tr bgcolor="#ff8c00">
		<td><b><font color=white>Sr.No.</font></b></td>
	<!-- 	<td ><b><font color=white>Exam Code</td> -->
		<td><b><font color=white>Subject(Code)</font></b></td>

		<%
	//	qry="select distinct nvl(EVENTSUBEVENT,' ')EVENTSUBEVENT,MAXMARKS,nvl(EXAMCODE,' ')EXAMCODE from V#STUDENTEVENTSUBJECTMARKS where studentid='"+mMemberID+"' and examcode=decode('"+mexam+"','ALL',examcode,'"+mexam+"') and nvl(Locked,'N')='Y' and nvl(PUBLISHED,'N')='Y' and EVENTSUBEVENT not like '%TA%' ";
	//	out.print(qry);



		String myEvent[]=new String[100];
		double myWeightage[]=new double[100];
		int mIndx=0;
		double mwTot=0,mWeighatage=0,mvalue=0;
String  mEs="";
ResultSet rs3=null;

	qry="select distinct a.eventsubevent,b.weightage";
					qry=qry+" from V#STUDENTEVENTSUBJECTMARKS a, ";
					qry=qry+" V#EXAMEVENTSUBJECTTAGGING b where  ";
					qry=qry+" b.EVENTSUBEVENT not like '%TA%' AND (b.eventsubevent NOT LIKE ('%D2D%')               AND b.eventsubevent NOT LIKE ('%DTOD%'))  ";
					qry=qry+"  and a.examcode='"+mexam+"' and a.examcode=b.examcode and a.eventsubevent=b.eventsubevent and ";
					qry=qry+" a.studentid='"+mMemberID+"' and  a.studentid=b.studentid and a.institutecode='"+mInst+"' and a.institutecode=b.institutecode AND";
					qry=qry+"  nvl(a.DEACTIVE,'N')='N' and ";
					qry=qry+" nvl(a.LOCKED,'N')='Y' and a.subjectID=b.subjectID and nvl(a.DEACTIVE,'N')='N' ";
					qry=qry+" and a.fstid=b.fstid  order by a.eventsubevent";
			//		out.print(qry);
		rs=db.getRowset(qry);
		while(rs.next())
			{

				myEvent[mIndx]=rs.getString("EVENTSUBEVENT");
			myWeightage[mIndx]=rs.getDouble("WEIGHTAGE");

			mEs=rs.getString("EVENTSUBEVENT");
			mWeighatage=rs.getDouble("WEIGHTAGE");
			mwTot+=mWeighatage;
	%>
		<td align=left><font color=white><b><%=mEs%><br>(<%=mWeighatage%>)</b></td>
	<%
		mIndx++;
		}



			%>

		<!-- <td><b><font color=white>Full Marks</td>
		<td><b><font color=white>Obtained Marks</td>
		<td><b><font color=white>Status</td> -->
		</tr>
		</thead>
		<tbody>
		<%
		/*	qry="select distinct "+qryadd+","+sumadd+"  Weightage,nvl(SUBJECT,' ')||'('||NVL(SUBJECTCODE,' ')||')' SUBJECT, ";
			qry=qry+ " nvl(EVENTSUBEVENT,' ')EVENTSUBEVENT,MAXMARKS,decode(MARKSAWARDED2,NULL,' ',to_char(MARKSAWARDED2))MARKSAWARDED2, decode(nvl(detained2,' '),'D','Detained','M','Make Up','A','Absent',' ') detained2,nvl(EXAMCODE,' ')EXAMCODE from V#STUDENTEVENTSUBJECTMARKS ";
			qry=qry+ " where studentid='"+mMemberID+"' and examcode=decode('"+mexam+"','ALL',examcode,'"+mexam+"') ";
			qry=qry+ " and nvl(Locked,'N')='Y' ";
			qry=qry+ " and nvl(PUBLISHED,'N')='Y'  and EVENTSUBEVENT not like '%TA%' order by SUBJECT,EVENTSUBEVENT ";*/


/*
String qry2="Select subjectcode,EXAMCODE,enrollmentno, studentname, studentid,subject,fstid,"+qryadd+","+sumadd+"  Weightage from ( select ";
					qry2+=" a.EXAMCODE, a.EventSubEvent,a.MARKSAWARDED2 MARKSAWARDED2, round(((a.marksawarded2/a.maxmarks)*b.weightage),2) total,";
					qry2+=" a.fstid fstid, a.studentid studentid,a.enrollmentno enrollmentno, a.studentname studentname,a.subject,a.subjectcode ";
					qry2+=" from V#STUDENTEVENTSUBJECTMARKS a, V#EXAMEVENTSUBJECTTAGGING b  where ";
					qry2+="   a.EVENTSUBEVENT not like '%TA%'  AND (b.eventsubevent NOT LIKE ('%D2D%') AND b.eventsubevent NOT LIKE ('%DTD%')               AND b.eventsubevent NOT LIKE ('%DTOD%'))  and a.examcode='"+mexam+"' AND A.STUDENTID='"+mMemberID+"' and a.INSTITUTECODE='"+mInst+"'  AND A.INSTITUTECODE=B.INSTITUTECODE and a.examcode=b.examcode  and ";
					qry2+=" a.eventsubevent=b.eventsubevent and a.studentid=b.studentid  ";
					qry2+=" and nvl(a.DEACTIVE,'N')='N' and nvl(a.LOCKED,'N')='Y' and a.subjectID=b.subjectID ";
					qry2+=" and nvl(a.DEACTIVE,'N')='N' and a.fstid=b.fstid and a.EVENTSUBEVENT in ("+aa+") ";
					qry2+=" order by enrollmentno,studentname)xyz group by enrollmentno,studentname,studentid,fstid,subject,EXAMCODE  ,subjectcode order by enrollmentno, studentname   ";
*/

	qry="select distinct subjectcode,EXAMCODE,enrollmentno, studentname, fstid,studentid,subject ,subjectid";
	qry=qry+"  from V#STUDENTEVENTSUBJECTMARKS ";
	qry=qry+" where institutecode='"+mInst+"' And EVENTSUBEVENT not like '%TA%'  AND (eventsubevent NOT LIKE ('%D2D%')               AND eventsubevent NOT LIKE ('%DTOD%'))   AND";
	qry=qry+" examcode='"+mexam+"'  and STUDENTID='"+mMemberID+"' AND nvl(LOCKED,'N')='Y' AND NVL(DEACTIVE,'N')='N'   order by subject" ;
			rs1=db.getRowset(qry);
//out.print(qry2);
			msno=0;
			while(rs1.next())
			{
				msno++ ;
				%>
				<tr>
				<td>&nbsp;<%=msno%>.</td>
			<!-- 	<td><%=rs1.getString("EXAMCODE")%></td> -->
				<td  ><%=rs1.getString("SUBJECT")%>- <%=rs1.getString("subjectcode")%></td>
				<%

		for(int jp=0;jp<mIndx;jp++)
		{

			qry="Select nvl(A.MARKSAWARDED1,-1)MARKSAWARDED1,NVL(A.DETAINED,'N')DETAINED,decode(A.DETAINED,'A','Absent','D','Detained','M','Medical','U','UFM',' ')DETAINED1,nvl(A.MAXMARKS,0)MAXMARKS ";
			qry=qry+" from V#STUDENTEVENTSUBJECTMARKS A ";
			qry=qry+" where nvl(A.locked,'N')='Y' and A.INSTITUTECODE='"+mInst+"'  and A.EXAMCODE='"+mexam+"' and ";
			qry=qry+" A.fstid='"+rs1.getString("fstid")+"' AND NVL(DEACTIVE,'N')='N' and A.STUDENTID='"+mMemberID+"' and A.subjectID='"+rs1.getString("subjectid")+"' ";
			qry=qry+" And A.EVENTSUBEVENT='"+myEvent[jp]+"'";
			//out.print(qry);
			rs3=db.getRowset(qry);
			if(rs3.next())
			{
				mDet=rs3.getString("DETAINED");
				mWeig=myWeightage[jp];
				mMax=rs3.getDouble("MAXMARKS");
				mvalue=rs3.getDouble("MARKSAWARDED1");
				mvalue1=(mvalue/mMax)*mWeig ;
				mvalue1=gb.getRound(mvalue1,2);

			 if(mDet.equals("D") || mDet.equals("A") || mDet.equals("M") || mDet.equals("U") || mDet.equals("P") )
				{
				%>
				<td align=right>&nbsp;<FONT SIZE="2" COLOR="red"><%=rs3.getString("DETAINED1")%></b> </FONT></td>
				<%
				}
				else
				{
				mTot=mTot+mvalue1;
					%>
				<td align=right><%=mvalue1%></td>
				<%
				}
		}
		else
			{
	%>
				<td>  </td>
				<%

			}
			// CLOSING OF if rs3
}
							%>

				</tr>
				<%
			}

			%>
			</tbody>
			</table>
				<center><input type="button" id="btnPrint" onclick="window.print();" value="Click To Print"/></center>
			<script type="text/javascript">
			var st1 = new SortableTable(document.getElementById("table-1"),["Number", "CaseInsensitiveString", "Number", "Number","Number", "Number","Number","Number","Number","Number"]);
			</script>
			<%}
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
	}   //2
	else
	{
		out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}
}	//1
catch(Exception e)
{
//	out.print(qry+qry1);
}
%>
<br><br>

</form>
</body>
</html>