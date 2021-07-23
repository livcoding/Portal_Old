<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%
GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
ResultSet rs=null,rsi=null,rsd=null;
String qry="";
String DSC="";
String mWebEmail="";
String mMemberID="";
String mMemberType="";
String mMemberName="";
String mMemberCode="";
String mDMemberType="";
String mDMemberCode="";
String mDMemberID="";
String mInst="";
String mSc="";
String mDSheet="";
String mDatesheet="";
String mSubject="";
String msubject="";
String mSubj="";
String mDCode="";
String mDcode="";
String mDataCode="";
String moldDate="";
int ctr=0;
String mRightsID="0";
String mSrcType="";
String mSrcType1="";
String mSrcType2="";
String Heading="",DSC1="";
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

if (request.getParameter("SrcType")==null)
{
	mSrcType="";
}
else
{
	mSrcType=request.getParameter("SrcType").toString().trim();
}

if (request.getParameter("RightsID")==null)
{
	mRightsID="35";
	Heading="Head Of Department";	
}
else
{
	mRightsID=request.getParameter("RightsID").toString().trim();
	Heading="Individual Member";	
}

	String mHead="";

	if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
		   mHead=session.getAttribute("PageHeading").toString().trim();
	else
		   mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Student Strength in Seating Plan ] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5   rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%	
try{

if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}

OLTEncryption enc=new OLTEncryption();
if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
{
	mDMemberType=enc.decode(mMemberType);
	mDMemberCode=enc.decode(mMemberCode);
	mDMemberID=enc.decode(mMemberID);

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
	
	//-----------------------------
	//-- Enable Security Page Level  
	//-----------------------------

//out.print(mRightsID);	
qry="Select WEBKIOSK.ShowLink('"+mRightsID+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
RsChk= db.getRowset(qry);
if (RsChk.next() && RsChk.getString("SL").equals("Y"))
   {
	%>
	<Form Name="frm"  method="get" >
	<input id="x" name="x" type=hidden>
	<table width='100%' ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">Center cum Subjectwise Students Strength</font></td></tr>
	</TABLE>
	<table width=100% bottommargin=0 rules=groups topmargin=0,cellspacing=0 cellpadding=0>
	<!--************Institute*************-->
	<INPUT Type="hidden" Name=SrcType id=SrcType Value=<%=mSrcType%>>
	<INPUT Type="hidden" Name=RightsID id=RightsID Value=<%=mRightsID%>>
	<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
	<%
		 
	qry="select WEBKIOSK.GetSeatingPlanCodes('"+mInst+"') DS from dual ";
	rsd=db.getRowset(qry);
	if (rsd.next() && !rsd.getString("DS").equals("N"))
	   {
		int len=0;
		int pos1=0;
		DSC=rsd.getString("DS")	;	
		len=DSC.length();
		pos1=DSC.indexOf(")");
		DSC1=DSC.substring(0,pos1+1)+"'";	
	%>
	<!--********* Datesheet Code *************-->
<tr>
	<td colspan=5>
	<font face=arial size=2><b>DateSheet Code :</b></font>
	<%
	try
	{	
      qry="select distinct EXAMCODE||'('||EXAMEVENTCODE||')-'||SPCODE dscode from V#CENTREWISEROOMALLOCATION where ";
      qry=qry+" InstituteCode='"+mInst+"' And EXAMCODE||'('||EXAMEVENTCODE||')-'||SPCODE in (select EXAMCODE||'('||EXAMEVENTCODE||')-'||SPCODE from SEATINGPLAN where ";
      qry=qry+" InstituteCode='"+mInst+"' And EXAMCODE||'('||EXAMEVENTCODE||')-'||SPCODE in ("+DSC+") and nvl(Status,'N')='F') ";	            
      rs=db.getRowset(qry);	
      
   %>
	 <select name=DScode tabindex="0" id="DScode" style="WIDTH: 350px">	   
   <%

    if (request.getParameter("x")==null)				
   {
	while(rs.next())
	{
           mDataCode=rs.getString("dscode"); 

	   if(mDcode.equals(""))	
	     mDcode=mDataCode;
       %>
 	  <option value=<%=mDataCode%>><%=mDataCode%></option>  	
	<%	 	
  	}
   } //closing of if
   else
   {
     while(rs.next())
     {
         mDataCode=rs.getString("dscode"); 
	  if(mDataCode.equals(request.getParameter("DScode").toString().trim()))
 			{
  		mDcode=mDataCode;
				%>
				<OPTION selected Value =<%=mDataCode%>><%=mDataCode%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mDataCode%>><%=mDataCode%></option>
		      	<%			
		   	}	
       }	//closing of while
   }	 //closing of else		
   
   }
   catch(Exception e)
   {
   }
 %>
  </select>
<Input type='submit' value=Show/Refresh>
</Td></tr>
</Table>
</Form>
<Table bgcolor=#fce9c5 class="sort-table" id="table-1" width='100%' bottommargin=0 rules=all topmargin=0 cellspacing=0 cellpadding=0 border=2 align=center>	
<tr bgcolor="#ff8c00">
<td><b><font color="white">SNo.</font></b></td>
<td><b><font color="white">Date/Day</font></b></td>
<td><b><font color="white">Time</font></b></td>
<td align=center><b><font color="white">Course code</font></b></td>
<td><b><font color="white">Course Name</font></b></td>
</tr> 
<%


	if(request.getParameter("x")!=null)
	   mDCode=request.getParameter("DScode");     	
	else
	   	mDCode=mDcode;

	String mExam="";
	int mPos= mDCode.indexOf("(");

	if (mPos>0)
	  {
	   mExam=mDCode.substring(0,mPos);	
	  }
	else
	  mExam="";

	qry=" Select count(distinct studentid)cnt, subject||' ('||SUBJECTCODE||')' SUBJECT, examcentercode, To_char(DATETIME,'dd-mm-yyyy')||' At '||to_char(DATETIME,'hh:mi PM')DateTime,";
	qry=qry+" examcentername,roomdesc from V#CENTREWISEROOMALLOCATION where institutecode='"+mInst+"' and (subjectID,StudentID) in ";
	qry=qry+" (select A.subjectID,B.StudentID  from ( select distinct subjectID,fstid from ";
	qry=qry+" Facultysubjecttagging where institutecode='"+mInst+"' and examcode='"+mExam+"' ";
	qry=qry+" and employeeid='"+mChkMemID+"' and LTP='L' Group By subjectID,fstid ";
	qry=qry+" Union ";
	qry=qry+" select subjectID,fstid from V#EX#SUBJECTGRADECOORDINATOR where institutecode='"+mInst+"' and ";
	qry=qry+" examcode='"+mExam+"' and COORDINATORID='"+mChkMemID+"' Group By subjectID,fstid ";
	qry=qry+" MINUS ";
	qry=qry+" select subjectID,fstid from V#EX#SUBJECTGRADECOORDINATOR";
	qry=qry+" where  employeeid='"+mChkMemID+"' and COORDINATORID<>'"+mChkMemID+"' Group By subjectID,fstid) A,V#StudentLTPdetail B ";
	qry=qry+" Where A.FSTID=B.FSTID	And B.ExamCode='"+mExam+"'	And B.SubjectID=A.SubjectID	And b.LTP='L')";
	qry=qry+" and EXAMCODE||'('||EXAMEVENTCODE||')-'||SPCODE in('"+mDCode+"') ";
	qry=qry+" group by institutecode,examcode,exameventcode,spcode,subjectID,subject||' ('||SUBJECTCODE||')',examcentercode,examcentername,roomcode,roomdesc,datetime ";
	qry=qry+" order by SUBJECT, DATETIME";

	//out.print(qry);
	String sbj="";
        int mtot=0;
	rs=db.getRowset(qry);	
	ctr=0;
	%>
	<tr>
	<td><STRONG>Paper ID</STRONG></font></td>
	<td><STRONG>Exam Date</STRONG></font></td>	
	<td><b>Exam Center Name</b></td>
	<td><b>Room Name</b></td> 	
	<td><b>Total Strength</b></td>	
	</tr>
	<%
	while(rs.next())
	{
		if(sbj.equals(""))
		{
		   sbj=rs.getString("subject");
		}
		else if(!sbj.equals(rs.getString("subject")))
		{
		%>
		<tr>
		     <td colspan=4 align=right><b><%=sbj%></b></td><td><b>Total Count: <%=mtot%></b></td>
		</tr>
		
		<%
		sbj=rs.getString("subject");
		mtot=0;
		}
		mtot=mtot+rs.getInt("cnt");
		%>
		<tr>
		<td><%=rs.getString("subject")%></td>
		<td><%=rs.getString("DateTime")%></td>
		<td><%=rs.getString("examcentername")%></td>
		<td><%=rs.getString("roomdesc")%></td>
		<td><%=rs.getString("cnt")%></td>
		</tr>
	 <%	
			
       } // closing of while

       if(mtot>0)
	{
	%>
	<tr>
	     <td colspan=4 align=right><b><%=sbj%></b></td><td><b>Total Count: <%=mtot%></b></td>
	</tr>	
	</table>
<%
	}	
   }  // closing of ds code
//----------------------
//-security link
//----------------------
  } // closing of Webkiosk Showlink if
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
   } //closing of Session if 
 }
 else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}
} // closing of outer try
catch(Exception e)
{
//out.print("error"+qry);
}      
%>
</body>
</html>
