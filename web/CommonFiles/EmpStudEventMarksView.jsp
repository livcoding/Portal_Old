<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.*" %>
<%@ page errorPage="CommonFiles/ExceptionHandler.jsp" %> 

<%
String mHead="",mSID="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ View Student Subject Marks (Eventwise) ] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
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
' 
*************************************************************************************************
	' *												
	' * File Name:	EmpStudEventMarksView.JSP		[For Adminuser User-Marks of Students]					
	' * Author:		Ashok
	' * Date:		08th Nov 2006								
	' * Version:	1.0								
	' * Description:	Students Marks
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
String mEName="",msubj="",mSubj="",mSubjcode="",aa="";
ResultSet rs=null,rs1=null;
ArrayList subevents=new ArrayList();

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
/*if (session.getAttribute("InstituteCode")==null)
{
	mINSTITUTECODE="";
}
else
{
	mINSTITUTECODE=session.getAttribute("InstituteCode").toString().trim();
}*/
if (request.getParameter("INSCODE")==null)
{
	mINSTITUTECODE ="";
}
else
{
	mINSTITUTECODE =request.getParameter("INSCODE").toString().trim();
}

mInst=mINSTITUTECODE;

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

if (request.getParameter("SID")==null)
{
	mSID="";
}
else
{
	mSID=request.getParameter("SID").toString().trim();
}



try 
{  //1
if(!mMemberID.equals("") && !mMemberType.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
{  //2

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mMacAddress =" "; //session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('61','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
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
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD ALIGN=right><font color="#a52a2a" face=verdana>Student Subject Marks (Eventwise)</font></td>
<td align=right><font color=brown><b>Login User :&nbsp; &nbsp;<%=mName%>[Emp. Code: <%=mDMemberCode%>]</b></font>
</td>
</tr>
</table>

<form name="frm" method=get>
<input id="x" name="x" type=hidden>
<input id="INSCODE" name="INSCODE" value="<%=mINSTITUTECODE%>" type="hidden">
<input type=hidden value=<%=mSID%> id=SID Name=SID>
<table width=70%  rules=groups cellspacing=1 cellpadding=1 align=center border=1>
<tr><td>&nbsp;&nbsp;<font color=black face=arial size=2><STRONG><b>Student Name:&nbsp;</STRONG></font><%=GlobalFunctions.getUserName(mSID,"S")%></b>
<tr><td>&nbsp;&nbsp;<font color=black face=arial size=2><STRONG>Exam Code</STRONG></font>
<%
/*  qry="select nvl(examcode,' ')examcode from V#STUDENTEVENTSUBJECTMARKS where institutecode='"+mINSTITUTECODE+"' and nvl(deactive,'N')='N'";		
  qry=qry+" and StudentID='"+mSID+"' and nvl(deactive,'N')='N'	Group By examcode  order by examcode ";		
*/
  qry="select distinct nvl(examcode,' ')examcode, EXAMPERIODFROM from exammaster where institutecode='"+mINSTITUTECODE+"'";
			qry=qry+" and nvl(deactive,'N')='N' and  nvl(LOCKEXAM,'N')='N' and EXAMCODE IN (SELECT EXAMCODE FROM V#studenteventsubjectmarks where studentid='"+mSID+"' AND NVL(LOCKED,'N')='Y' AND  institutecode='"+mINSTITUTECODE+"') order by EXAMPERIODFROM Desc";
			
  rs=db.getRowset(qry);
//out.print(qry);
%>
	<select name=exam tabindex="0" id="exam" style="WIDTH: 120px">		
<%   	
  	if(request.getParameter("x")==null)
	{
	%>	
	<OPTION selected value=ALL><--Select--></option>
<%
		while(rs.next())
		{
		 mexamcode=rs.getString("examcode");
	%>
		<option  value=<%=mexamcode%>><%=mexamcode%></option>
	<%		
		}
	  mexamcode="ALL";
	 }
	else
	{
		if (request.getParameter("exam").toString().trim().equals("ALL"))
 		{
			mexamcode="ALL";
			%>
	 		<OPTION selected value=ALL><--Select--></option>
			<%
		}
		else
		{
			%>
			<OPTION  value=ALL><--Select--></option>
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
&nbsp;<input type="submit" value="Show/Refresh"></td></tr>
</table></form>
<%
   if(request.getParameter("x")!=null)
	{
	   mexamcode=request.getParameter("exam").toString().trim();	
	
%>
	<table bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=group/s topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center width="70%">	
	<thead>
	<tr bgcolor="#ff8c00">
  <td><b><font color=white>SNo.</font></b></td>
  <td><b><font color=white>Exam Code</td>
  <td><b><font color=white>Subject(Code)</font></b></td>	
  
<%
	//	qry="select distinct nvl(EVENTSUBEVENT,' ')EVENTSUBEVENT,MAXMARKS,nvl(EXAMCODE,' ')EXAMCODE from V#STUDENTEVENTSUBJECTMARKS where studentid='"+mMemberID+"' and examcode=decode('"+mexam+"','ALL',examcode,'"+mexam+"') and nvl(Locked,'N')='Y' and nvl(PUBLISHED,'N')='Y' and EVENTSUBEVENT not like '%TA%' ";
	//	out.print(qry);

	qry="select distinct a.eventsubevent||b.weightage eventsubevent,a.eventsubevent event ,b.weightage";
					qry=qry+" from V#STUDENTEVENTSUBJECTMARKS a, ";
					qry=qry+" V#EXAMEVENTSUBJECTTAGGING b where  ";
					qry=qry+" b.EVENTSUBEVENT not like '%TA%'  AND B.EVENTSUBEVENT NOT LIKE  ('%D2D%') and      b.eventsubevent NOT LIKE ('%DTOD%')  AND ";
					qry=qry+"  a.examcode='"+mexamcode+"' and a.examcode=b.examcode and a.eventsubevent=b.eventsubevent and ";
					qry=qry+" a.studentid='"+mSID+"' and  a.studentid=b.studentid and a.institutecode='"+mInst+"' and a.institutecode=b.institutecode AND";
					qry=qry+"  nvl(a.DEACTIVE,'N')='N' and ";
					qry=qry+" nvl(a.LOCKED,'N')='Y' and a.subjectID=b.subjectID and nvl(a.DEACTIVE,'N')='N' ";
					qry=qry+" and a.fstid=b.fstid  order by eventsubevent";
				 //	out.print(qry);
		rs=db.getRowset(qry);
		while(rs.next())
			{

			subevents.add(rs.getString("eventsubevent")+"$$$"+rs.getString("weightage")+"###"+rs.getString("event"));

			%>

			<%
			}
						
						String qryadd="";
						String sumadd="";
						int i=0;
						for( i=0; i<subevents.size();i++)
						{
								
							String aaa=(String)subevents.get(i);
							String cccc=aaa.substring(0,aaa.indexOf("$$$"));
							String dddd=aaa.substring(aaa.indexOf("$$$")+3,aaa.indexOf("###"));
                                                        String eeee=aaa.substring(aaa.indexOf("###")+3,aaa.length());
							
							%><td nowrap ><Font color=white><b><%=eeee%><br>   (<%=dddd%>)</b></font></td>
							<%
							
							
							if(aa.equals(""))
								aa="'"+cccc+"'";
							else
								aa=aa+",'"+cccc+"'";

							if(qryadd.equals(""))
							{
								qryadd=qryadd+" nvl( trunc(DECODE(Sum(Decode(xyz.EventSubEvent, '"+cccc+"', total,0)),null,null,'0',0,0,'Absent',Sum(Decode(xyz.EventSubEvent, '"+cccc+"', total,0))),3),'0')  AB"+i+" ";	
								sumadd="NVL(Sum(Decode(xyz.EventSubEvent, '"+cccc+"', total,0)),'0')";
								
							}
							else
							{
								qryadd=qryadd+",  nvl(trunc(DECODE(Sum(Decode(xyz.EventSubEvent, '"+cccc+"', total,0)),'','Absent',Sum(Decode(xyz.EventSubEvent, '"+cccc+"', total,0))),3) ,'0') AB"+i+" ";	
								sumadd=sumadd+"+"+"NVL(Sum(Decode(xyz.EventSubEvent, '"+cccc+"', total,0)) ,'0')";
								
							}								
						}	
%>
 <!--  <td><b><font color=white>Full Marks</td>
  <td><b><font color=white>Obtained Marks</td>
  <td><b><font color=white>Status</td> -->
 </tr>
</thead>
	<tbody>
<%


String qry2="Select subjectcode,EXAMCODE,enrollmentno, studentname, studentid,subject,fstid, "+qryadd+","+sumadd+" e from ( select ";
					qry2+=" a.EXAMCODE, a.EventSubEvent||b.weightage EventSubEvent,nvl(a.MARKSAWARDED2,'0') MARKSAWARDED2, nvl( round(((a.marksawarded2/a.maxmarks)*b.weightage),2),'0') total,";
					qry2+=" a.fstid fstid, a.studentid studentid,a.enrollmentno enrollmentno, a.studentname studentname,a.subject,a.subjectcode ";
					qry2+=" from V#STUDENTEVENTSUBJECTMARKS a, V#EXAMEVENTSUBJECTTAGGING b  where ";
					qry2+="   a.EVENTSUBEVENT not like '%TA%'  AND B.EVENTSUBEVENT NOT LIKE  ('%D2D%')   and   b.eventsubevent NOT LIKE ('%DTOD%') and a.examcode='"+mexamcode+"' AND A.STUDENTID='"+mSID+"' and a.INSTITUTECODE='"+mInst+"'  AND A.INSTITUTECODE=B.INSTITUTECODE and a.examcode=b.examcode  and ";
					qry2+=" a.eventsubevent=b.eventsubevent and a.studentid=b.studentid  ";
					qry2+=" and nvl(a.DEACTIVE,'N')='N' and nvl(a.LOCKED,'N')='Y' and a.subjectID=b.subjectID ";
					qry2+=" and nvl(a.DEACTIVE,'N')='N' and a.fstid=b.fstid and a.EVENTSUBEVENT|| b.weightage in ("+aa+") ";
					qry2+=" order by enrollmentno,studentname)xyz group by enrollmentno,studentname,studentid,fstid,subject,EXAMCODE  ,subjectcode order by enrollmentno, studentname   ";
			rs1=db.getRowset(qry2);
//out.print(qry2);

			msno=0;
			while(rs1.next())
			{
				msno++ ;
				%>
				<tr>
				<td>&nbsp;<%=msno%>.</td>
				<td><%=rs1.getString("EXAMCODE")%></td>
				<td ><%=rs1.getString("SUBJECT")%>- <%=rs1.getString("subjectcode")%></td>
				<%
						for(int j=0;j<i;j++)
							{
								if((rs1.getString("AB"+String.valueOf(j))=="") || (rs1.getString("AB"+String.valueOf(j))==null))
								{
									%>
							<td align='right'>--</td>	
							<%
								}
								else
								{
							%>
							<td align='right'><%=rs1.getString("AB"+String.valueOf(j))%></td>	
							<%	
								}

							}
							%>	
				
				</tr>
				<%
			}
			%>
</tbody>
 </table>	
<script type="text/javascript">
			var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString","String","Number","Number","String","String"]);
		</script>
	
	
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
	<h3>	<br><img src='../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font>	<br>	<br>	<br>	<br> 
   <%
	}
    		 //-----------------------------
  }   //2
else
{
	out.print("<br><img src='../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
}	//1	
catch(Exception e)
{
//	out.print(qry+qry1);
}
%><br><br><br><br><br><br>
</body>
</html>