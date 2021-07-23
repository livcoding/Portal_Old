<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%
GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
ResultSet rs=null,rsi=null,rsd=null,rs1=null, rsDuty=null;
String qry="";
String DSC="";
String mWebEmail="";
String mMemberID="";
String mMemberType="";
String mMemberName="";
String mMemberCode="";
String mDMemberType="";
String mDMemberCode="";
String mDMemberID="", mInvgID="", mInvgRole="";
String mInst="";
String mSc="",mFS="",mID="";
String mDSheet="";
String mDatesheet="";
String mStaff="";
String mstaff="";
String mStaffID="";
String mDCode="";
String mDcode="";
String mDataCode="";
String moldDate="";
String mDegsCode="";
int ctr=0,msno=0;
int mRights=0;
String mSrcType="";
String mSrcType1="";
String mSrcType2="";
String Heading="",DSC1="",mType="";
String mColor="";
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
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}

if (session.getAttribute("DesignationCode")==null)
{
	mDegsCode="";
}
else
{
	mDegsCode=session.getAttribute("DesignationCode").toString().trim();
}

if (request.getParameter("SrcType")==null)
{
	mSrcType="";
}
else
{
	mSrcType=request.getParameter("SrcType").toString().trim();
}


	String mHead="";
	if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
		   mHead=session.getAttribute("PageHeading").toString().trim();
	else
		   mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [Invigilation Duty Status ] </TITLE>
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
		
	if(mSrcType.equals("A"))
	{
	   mRights=115;
	  Heading="Admin.";	
	}
	else if(mSrcType.equals("H"))
	{
	   mRights=116;
	  Heading="DepartmentWise";	
	}
	else
	{
	   mRights=117;
	  Heading="Individual Member";	
	}
		
	qry="Select WEBKIOSK.ShowLink('"+mRights+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
	%>
	<form name="frm"  method="get" >
	<input id="x" name="x" type=hidden>
	<table ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD align=middle>
	<font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana"><b>View Invigilation Duty Plan By <%=Heading%></B></font>
	</td></tr>
	</TABLE>
	<table align=center bottommargin=0 rules=groups topmargin=0,cellspacing=0 cellpadding=0>
	<!--************Institute*************-->
	<INPUT Type="hidden" Name=SrcType id=SrcType Value=<%=mSrcType%>>
	<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
	<%

	qry="select WEBKIOSK.GetSeatingPlanCodes('"+mInst+"') DS from dual ";
	rsd=db.getRowset(qry);
	if (rsd.next()  ) //&& !rsd.getString("DS").equals("N"))
	{
	//out.print(qry);
	int len=0;
	int pos1=0;
//DSC="'2012TR1(END TERM)-SP ENDTR3'";
	DSC=rsd.getString("DS")	;	
	len=DSC.length();
	pos1=DSC.indexOf(")");
	DSC1=DSC.substring(0,pos1+1)+"'";	
   
	
	
	
qry="SELECT 'Y' FROM INVIGILATIONDUTY   WHERE  examcode || '(' || exameventcode || ')-' || spcode IN                                                  ("+DSC+")     AND STATUS='F' and INSTITUTECODE='"+mInst+"' ";
rs=db.getRowset(qry);
if(rs.next())
		{
%>
 <!--*********Datesheet Code*************-->
 <tr>
<td nowrap>
  <font face=arial size=2><b>DateSheet Code :</b></font>
  <%
try
{
    qry="select distinct VWC.EXAMCODE||'('||VWC.EXAMEVENTCODE||')-'||VWC.SPCODE dscode from V#CENTREWISEROOMALLOCATION VWC where ";
    qry=qry+" VWC.EXAMCODE||'('||VWC.EXAMEVENTCODE||')-'||VWC.SPCODE in (select SP.EXAMCODE||'('||SP.EXAMEVENTCODE||')-'||SP.SPCODE from SEATINGPLAN SP where";
    qry=qry+" SP.EXAMCODE||'('||SP.EXAMEVENTCODE||')-'||SP.SPCODE in ("+DSC+") and nvl(SP.Status,'N')='F')";
    rs=db.getRowset(qry);
//out.print(qry);
	%>
	<select name="DScode" tabindex="0" id="DScode" style="WIDTH: 250px">	   
	<%
	if (request.getParameter("x")==null)
	{
		while(rs.next())
		{
			mDataCode=rs.getString("DScode").toString().trim(); 
			if(mDcode.equals(""))	
				mDcode=mDataCode;
		      %>
		 	<option value="<%=mDataCode%>"><%=mDataCode%></option>  	
			<%
		}
	} //closing of if
	else
	{
		while(rs.next())
		{
			mDataCode=rs.getString("DScode").toString().trim(); 
			if(mDataCode.equals(request.getParameter("DScode").toString().trim()))
 			{
		  		mDcode=mDataCode;
				%>
				<OPTION selected Value ="<%=mDataCode%>"><%=mDataCode%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value ="<%=mDataCode%>"><%=mDataCode%></option>
		      	<%			
		   	}	
		}	//closing of while
	}	 //closing of else		
	%>
	</select>
	<%
}
catch(Exception e)
{
//out.print("error"+qry);
}
%>
<!-- 
<input type=radio name=radio id=radio value="E" checked>
<b>Exc. Student</b>
<input type=radio name=radio id=radio value="I">
<b>Inc. Student</b>
-->
</td>
<!--****************Invogilators*****************-->
<td>
  <font face=arial size=2><b>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Invigilator : </b></font>
  <%
 try{
	if(mSrcType.equals("A"))
	{
	qry="select distinct A.INVIGILATORID invigilatorid,B.employeename employeename from INVIGILATIONDUTYALLOCATION A,V#STAFF B where ";
	qry=qry+" institutecode='"+mInst+"' and  EXAMCODE||'('||EXAMEVENTCODE||')-'||SPCODE in ("+DSC+") ";
	qry=qry+" and A.INVIGILATORID in ( select B.employeeid from V#staff) ";
	qry=qry+" and (A.INSTITUTECODE, A.EXAMCODE, A.EXAMEVENTCODE, A.SPCODE, A.IDCODE) IN (Select ID.INSTITUTECODE, ID.EXAMCODE, ID.EXAMEVENTCODE, ID.SPCODE, ID.IDCODE FROM INVIGILATIONDUTY ID WHERE ID.STATUS='F')";
	}
	else if(mSrcType.equals("H"))
	{
	qry="select distinct A.INVIGILATORID invigilatorid,B.employeename employeename from INVIGILATIONDUTYALLOCATION A,V#STAFF B where ";
	qry=qry+" A.institutecode='"+mInst+"' and  A.EXAMCODE||'('||A.EXAMEVENTCODE||')-'||A.SPCODE in ("+DSC+") ";
	qry=qry+" and A.INVIGILATORID in ( select B.employeeid from V#staff where B.departmentcode in ";
	qry=qry+" (select C.DEPARTMENTCODE from HODLIST C where employeeid='"+mDMemberID+"' and nvl(deactive,'N')='N')) AND A.INVIGILATORID=B.EMPLOYEEID ";
	qry=qry+" and (A.INSTITUTECODE, A.EXAMCODE, A.EXAMEVENTCODE, A.SPCODE, A.IDCODE) IN (Select ID.INSTITUTECODE, ID.EXAMCODE, ID.EXAMEVENTCODE, ID.SPCODE, ID.IDCODE FROM INVIGILATIONDUTY ID WHERE ID.STATUS='F')";
	}
	else
	{
	qry="select distinct A.INVIGILATORID invigilatorid,B.employeename employeename from INVIGILATIONDUTYALLOCATION A,V#STAFF B where ";
	qry=qry+" institutecode='"+mInst+"' and  EXAMCODE||'('||EXAMEVENTCODE||')-'||SPCODE in ("+DSC+") ";
	qry=qry+" and A.INVIGILATORID='"+mDMemberID+"'  ";
	qry=qry+" and A.INVIGILATORID=B.EMPLOYEEID ";
	qry=qry+" and (A.INSTITUTECODE, A.EXAMCODE, A.EXAMEVENTCODE, A.SPCODE, A.IDCODE) IN (Select ID.INSTITUTECODE, ID.EXAMCODE, ID.EXAMEVENTCODE, ID.SPCODE, ID.IDCODE FROM INVIGILATIONDUTY ID WHERE ID.STATUS='F')";
	}

	qry=qry+" union ";
	qry=qry+" select distinct A.INVIGILATORID invigilatorid,C.studentname employeename from INVIGILATIONDUTYALLOCATION A,Studentmaster C where ";
	qry=qry+" A.institutecode='"+mInst+"' and  EXAMCODE||'('||EXAMEVENTCODE||')-'||SPCODE in ("+DSC+") ";
	qry=qry+" and A.INVIGILATORID in ( select C.studentid from studentmaster ) order by employeename";
	//out.print(qry);
    	rs=db.getRowset(qry);	
	if (request.getParameter("x")==null)				
	{
		%>
      	<select name=Staff tabindex="0" id="Staff" style="WIDTH: 300px">
		<option value='ALL' selected >ALL</option>
		<%
		while(rs.next())
		{
			mStaff=rs.getString("invigilatorid"); 
			if(mStaff.equals(mDMemberID))
			{
				mstaff=mDMemberID;
				%>
				<option selected value=<%=mStaff%>><%=rs.getString("employeename")%></option>  	
				<%
			}
			else
			{
				if(mstaff.equals(""))	
				   mstaff="ALL";
				%>
				<option value=<%=mStaff%>><%=rs.getString("employeename")%></option>  	
				<%
			}
		}
		%>
		</select>
		<%
	} //closing of if
	else
	{
		%>
		<select name=Staff tabindex="0" id="Staff" style="WIDTH: 300px">	
		<%
		if((request.getParameter("Staff").toString().trim()).equals("ALL"))
		{
			%>
			<option value='ALL' selected >ALL</option>
			<%
		}
		else
		{
			%>
			<option value='ALL'>ALL</option>
			<%
		}
		while(rs.next())
		{
			mStaff=rs.getString("invigilatorid"); 
			if(mStaff.equals(request.getParameter("Staff").toString().trim()))
			{
  				mStaff=mStaff;
				%>
				<OPTION selected Value =<%=mStaff%>><%=rs.getString("employeename")%></option>
				<%
		     	}
	     		else
		      {
				%>
	      		<OPTION Value =<%=mStaff%>><%=rs.getString("employeename")%></option>
	      		<%			
		   	}
		}	//closing of while
	}	 //closing of else		
%>
</select>
<%
}
catch(Exception e)
{
//out.print("error"+qry);
}
%>
</td>
</tr>
<td align=center colspan=2>
<input type='submit' value=Show/Refresh>
</td></tr>
</table>
</form>
<table bgcolor=#fce9c5 class="sort-table" id="table-1" width='100%' bottommargin=0 rules=ROWS topmargin=0 cellspacing=0 cellpadding=0 border=2 align=center>	
<%
	if(request.getParameter("x")!=null)
		mStaffID=request.getParameter("Staff");
	else
		mStaffID=mstaff;

	if(request.getParameter("x")!=null)
	   mDCode=request.getParameter("DScode").toString().trim();     	
	else
	   	mDCode=mDcode;
%>
<tr bgcolor="#ff8c00">
<td><b><font color="white">SNo.</font></b></td>
<td><b><font color="white">Date/time</font></b></td>
<td><b><font color="white">Faculty</font></b></td>
<td><b><font color="white">Exam center</font></b></td>
<td><b><font color="white">Room code</font></b></td>
<%
if(!mStaffID.equals("ALL"))
{
%>
<td align=center><b><font color="white">Invigilator's Additional Role</font></b></td>
<%
}
%>
</tr> 
<%
	if(mSrcType.equals("A"))
	{
		qry="select  to_char(A.DATETIME,'dd-mm-yyyy')||' At '||to_char(A.DATETIME,'hh:mi PM')DateTime, to_char(A.DATETIME,'dd-mm-yyyy hh:mi PM')InvgDateTime, ";
		qry=qry+"  B.EXAMCENTERNAME examcentername,A.INVIGILATORID,A.INVIGILATORTYPE,A.EXAMCENTERCODE,A.ROOMCODE ROOMCODE,C.ROOMDESC roomdesc from INVIGILATIONDUTYALLOCATION A,examcentermaster B,roommaster C";
		qry=qry+" where A.institutecode='"+mInst+"' and  ";
		qry=qry+" A.EXAMCODE||'('||A.EXAMEVENTCODE||')-'||A.SPCODE in('"+mDCode+"') ";
		qry=qry+" and A.INVIGILATORID=decode('"+mStaffID+"','ALL',A.INVIGILATORID,'"+mStaffID+"')"; 
		qry=qry+" and A.EXAMCENTERCODE=B.EXAMCENTERCODE AND A.ROOMCODE=C.ROOMCODE ";
		qry=qry+" and (A.INSTITUTECODE, A.EXAMCODE, A.EXAMEVENTCODE, A.SPCODE, A.IDCODE) IN (Select ID.INSTITUTECODE, ID.EXAMCODE, ID.EXAMEVENTCODE, ID.SPCODE, ID.IDCODE FROM INVIGILATIONDUTY ID WHERE ID.STATUS='F')";
		qry=qry+" group by A.institutecode,A.examcode,A.exameventcode,A.INVIGILATORID, ";
		qry=qry+" A.EXAMCENTERCODE,A.INVIGILATORTYPE,A.spcode,A.roomcode,A.datetime, ";
		qry=qry+" B.examcentername,C.roomdesc ";
		qry=qry+" order by A.DATETIME ";
	}
	else if(mSrcType.equals("H"))
	{
		qry="select  to_char(A.DATETIME,'dd-mm-yyyy')||' At '||to_char(A.DATETIME,'hh:mi PM')DateTime, to_char(A.DATETIME,'dd-mm-yyyy hh:mi PM')InvgDateTime, ";
		qry=qry+"  B.EXAMCENTERNAME examcentername,A.INVIGILATORID,A.INVIGILATORTYPE,A.EXAMCENTERCODE,A.ROOMCODE ROOMCODE,C.ROOMDESC roomdesc from INVIGILATIONDUTYALLOCATION A,examcentermaster B,roommaster C";
		qry=qry+" where A.institutecode='"+mInst+"' and  ";
		qry=qry+" A.EXAMCODE||'('||A.EXAMEVENTCODE||')-'||A.SPCODE in('"+mDCode+"') ";
		qry=qry+" and A.INVIGILATORID=decode('"+mStaffID+"','ALL',A.INVIGILATORID,'"+mStaffID+"')"; 
		qry=qry+" and (A.INVIGILATORTYPE='S' or ( A.INVIGILATORTYPE<>'S' and A.INVIGILATORID in ( select B.employeeid from V#staff B where B.departmentcode in ";
		qry=qry+" (select C.DEPARTMENTCODE from HODLIST C where employeeid='"+mDMemberID+"' and nvl(deactive,'N')='N')))) ";
		qry=qry+" and A.EXAMCENTERCODE=B.EXAMCENTERCODE AND A.ROOMCODE=C.ROOMCODE ";
		qry=qry+" and (A.INSTITUTECODE, A.EXAMCODE, A.EXAMEVENTCODE, A.SPCODE, A.IDCODE) IN (Select ID.INSTITUTECODE, ID.EXAMCODE, ID.EXAMEVENTCODE, ID.SPCODE, ID.IDCODE FROM INVIGILATIONDUTY ID WHERE ID.STATUS='F')";
		qry=qry+" group by A.institutecode,A.examcode,A.exameventcode,A.INVIGILATORID, ";
		qry=qry+" A.EXAMCENTERCODE,A.INVIGILATORTYPE,A.spcode,A.roomcode,A.datetime, ";
		qry=qry+" B.examcentername,C.roomdesc ";
		qry=qry+" order by A.DATETIME ";
	
	}
	else
	{
		qry="select  to_char(A.DATETIME,'dd-mm-yyyy')||' At '||to_char(A.DATETIME,'hh:mi PM')DateTime, to_char(A.DATETIME,'dd-mm-yyyy hh:mi PM')InvgDateTime, ";
		qry=qry+"  B.EXAMCENTERNAME examcentername,A.INVIGILATORID,A.INVIGILATORTYPE,A.EXAMCENTERCODE,A.ROOMCODE ROOMCODE,C.ROOMDESC roomdesc from INVIGILATIONDUTYALLOCATION A,examcentermaster B,roommaster C";
		qry=qry+" where A.institutecode='"+mInst+"' and  ";
		qry=qry+" A.EXAMCODE||'('||A.EXAMEVENTCODE||')-'||A.SPCODE in('"+mDCode+"') ";
		qry=qry+" and (A.INVIGILATORTYPE='S' or (A.INVIGILATORTYPE<>'S' AND  A.INVIGILATORID='"+mDMemberID+"' ))"; 
		qry=qry+" and A.INVIGILATORID=decode('"+mStaffID+"','ALL',A.INVIGILATORID,'"+mStaffID+"')"; 
		qry=qry+" and A.EXAMCENTERCODE=B.EXAMCENTERCODE AND A.ROOMCODE=C.ROOMCODE ";
		qry=qry+" and (A.INSTITUTECODE, A.EXAMCODE, A.EXAMEVENTCODE, A.SPCODE, A.IDCODE) IN (Select ID.INSTITUTECODE, ID.EXAMCODE, ID.EXAMEVENTCODE, ID.SPCODE, ID.IDCODE FROM INVIGILATIONDUTY ID WHERE ID.STATUS='F')";
		qry=qry+" group by A.institutecode,A.examcode,A.exameventcode,A.INVIGILATORID, ";
		qry=qry+" A.EXAMCENTERCODE,A.INVIGILATORTYPE,A.spcode,A.roomcode,A.datetime, ";
		qry=qry+" B.examcentername,C.roomdesc ";
		qry=qry+" order by A.DATETIME ";
		//out.print(qry);

		/*qry="select to_char(A.DATETIME,'dd-mm-yyyy')||' At '||to_char(A.DATETIME,'hh:mi PM')DateTime, to_char(A.DATETIME,'dd-mm-yyyy hh:mi PM')InvgDateTime, B.EXAMCENTERNAME examcentername,A.INVIGILATORID,A.INVIGILATORTYPE,A.EXAMCENTERCODE,A.ROOMCODE ROOMCODE,C.ROOMDESC roomdesc from INVIGILATIONDUTYALLOCATION A,examcentermaster B,roommaster C WHERE A.DATETIME IN ( SELECT DATETIME FROM INVIGILATIONDUTYALLOCATION WHERE INVIGILATORID='"+mDMemberID+"'    AND institutecode='"+mInst+"' and EXAMCODE||'('||EXAMEVENTCODE||')-'||SPCODE in('"+mDCode+"') )   AND A.ROOMCODE  IN (SELECT ROOMCODE FROM INVIGILATIONDUTYALLOCATION   WHERE INVIGILATORID='"+mDMemberID+"' AND  institutecode='"+mInst+"' and EXAMCODE||'('||EXAMEVENTCODE||')-'||SPCODE    in('"+mDCode+"') ) AND  A.institutecode='"+mInst+"' and A.EXAMCODE||'('||A.EXAMEVENTCODE||')-'||A.SPCODE in('"+mDCode+"') and A.INVIGILATORID=A.INVIGILATORID and A.EXAMCENTERCODE=B.EXAMCENTERCODE AND A.ROOMCODE=C.ROOMCODE AND A.INSTITUTECODE=C.INSTITUTECODE and (A.INSTITUTECODE, A.EXAMCODE, A.EXAMEVENTCODE, A.SPCODE, A.IDCODE) IN (Select ID.INSTITUTECODE,  ID.EXAMCODE, ID.EXAMEVENTCODE, ID.SPCODE, ID.IDCODE FROM INVIGILATIONDUTY ID WHERE ID.STATUS='F') group by A.institutecode,A.examcode,A.exameventcode,A.INVIGILATORID, A.EXAMCENTERCODE,A.INVIGILATORTYPE,A.spcode,A.roomcode,A.datetime, B.examcentername,C.roomdesc order by A.DATETIME ";*/
		
		/*qry="select to_char(A.DATETIME,'dd-mm-yyyy')||' At '||to_char(A.DATETIME,'hh:mi PM')DateTime, to_char(A.DATETIME,'dd-mm-yyyy hh:mi PM')InvgDateTime, D.EXAMCENTERNAME examcentername,A.INVIGILATORID,A.INVIGILATORTYPE,A.EXAMCENTERCODE,A.ROOMCODE ROOMCODE,C.ROOMDESC roomdesc from INVIGILATIONDUTYALLOCATION A,INVIGILATIONDUTYALLOCATION B, examcentermaster D,roommaster C where A.institutecode= '"+mInst+"' and A.EXAMCODE||'('||A.EXAMEVENTCODE||')-'||A.SPCODE in('"+mDCode+"') and (A.INVIGILATORTYPE<>'S' OR (A.INVIGILATORID='"+mDMemberID+"'  and  A.INVIGILATORTYPE<>'S'  )) and A.INVIGILATORID=decode('ALL','ALL',A.INVIGILATORID,'ALL') and A.EXAMCENTERCODE=D.EXAMCENTERCODE  AND a.INSTITUTECODE = b.INSTITUTECODE and a.EXAMCODE =b.EXAMCODE and a.EXAMEVENTCODE = b.EXAMEVENTCODE and a.SPCODE = b.SPCODE and a.IDCODE = b.IDCODE and a.DATETIME = b.DATETIME and a.EXAMCENTERCODE = b.EXAMCENTERCODE and a.ROOMCODE = b.ROOMCODE and a.INVIGILATORID <> b.INVIGILATORID and a.INVIGILATORID = '"+mDMemberID+"'and A.EXAMCODE||'('||A.EXAMEVENTCODE||')-'||A.SPCODE in('"+mDCode+"') and A.EXAMCENTERCODE=d.EXAMCENTERCODE AND A.ROOMCODE=C.ROOMCODE AND A.INSTITUTECODE=C.INSTITUTECODE AND A.ROOMCODE=C.ROOMCODE and (A.INSTITUTECODE, A.EXAMCODE, A.EXAMEVENTCODE, A.SPCODE, A.IDCODE) IN (Select ID.INSTITUTECODE, ID.EXAMCODE, ID.EXAMEVENTCODE, ID.SPCODE, ID.IDCODE FROM INVIGILATIONDUTY ID WHERE ID.STATUS='F') group by A.institutecode,A.examcode,A.exameventcode,A.INVIGILATORID, A.EXAMCENTERCODE,A.INVIGILATORTYPE,A.spcode,A.roomcode,A.datetime, D.examcentername,C.roomdesc order by A.DATETIME ";*/
 
	}
//	out.print(qry);
	
	rs=db.getRowset(qry);
	ctr=0;
	String QDateTime="", QRmCode="",mMessage="";
String mInvgRole1="",mInvgRole2="",mInvgRole3="";
int mflag=0;
//out.print(mStaffID+"<br>");
	while(rs.next())
	{
		//msno++;
		QDateTime=rs.getString("InvgDateTime");
		QRmCode=rs.getString("ROOMCODE");
		//out.print(QDate+" "+QTime+" "+QRmCode);
			//out.print(rs.getString("roomdesc"));

		qry="select A.Invigilatorid Invigilatorid, B.DESIGNATIONCODE, C.GRADE from INVIGILATIONDUTYALLOCATION A, EMPLOYEEMASTER B, DESIGNATIONMASTER C WHERE A.institutecode='"+mInst+"' AND ";
		qry=qry+" A.Invigilatorid=B.EMPLOYEEID AND B.DESIGNATIONCODE=C.DESIGNATIONCODE AND A.EXAMCODE||'('||A.EXAMEVENTCODE||')-'||A.SPCODE in('"+mDCode+"')";
		qry=qry+" and to_char(A.DATETIME,'dd-mm-yyyy hh:mi PM')='"+QDateTime+"' and ROOMCODE='"+QRmCode+"' ORDER BY Grade asc";
		//out.print(qry);
		rsDuty=db.getRowset(qry);

		while(rsDuty.next())
		{
			mInvgID=rsDuty.getString("Invigilatorid");
			ctr++;
					
			

				mInvgRole1=" To Collect Question Paper";
			    mInvgRole2=" To Collect Answer Scripts";	
			    mInvgRole3=" Assign for pre examination announcement";
				
			//out.print(ctr+"::"+mInvgID);
				if(ctr!=3 && (mInvgID.equals(mStaffID)))
				{
					mInvgRole2=" To Collect Answer Scripts ,Assign for pre examination announcement ";	
				}
				
				
				if(ctr==1 && (mInvgID.equals(mStaffID)))
					{
							mMessage=" , you are also a hall Incharge";

						mInvgRole=mInvgRole1+mMessage;
						mColor="Green";
						
						mflag=1;

					}
				if(ctr==2 && (mInvgID.equals(mStaffID)))
					{
						mInvgRole=mInvgRole2;
							mColor="Brown";
							mflag=1;

					}
				
				if(ctr==3 && (mInvgID.equals(mStaffID)))
					{
						mInvgRole=mInvgRole3;
						mColor="RED";
						mflag=1;
					}
			
		
			if(mflag==0)
			{
				mInvgRole=mInvgRole3;
								mColor="RED";
			}
		
			
		}
ctr=0;
mMessage="";
mInvgID="";
mflag=0;


		mID=rs.getString("INVIGILATORID");
		mType=rs.getString("INVIGILATORTYPE");

		if(mType.equals("S"))	
		{
	
			qry="select studentname from studentmaster where studentid='"+mID+"' ";
			rs1=db.getRowset(qry);
			if(rs1.next())
			mFS=rs1.getString(1);

		}	
		else
		{
		  
			qry="select employeename from V#STAFF where employeeid='"+mID+"' ";
			//out.print(qry);
			rs1=db.getRowset(qry);
			if(rs1.next())
			mFS=rs1.getString(1);

		}	

//out.print(moldDate+"moldDate"+rs.getString("DateTime") );

	  	 if(!moldDate.equals(rs.getString("DateTime")))
	 	{
			msno++;
			moldDate=rs.getString("DateTime");	
		%>
		<tr>
		<td><%=msno%></td>
		<td NOWRAP><%=moldDate%></td>	
		<td NOWRAP><%=mFS%></td>	
		<td ><%=rs.getString("examcentername")%></td>
		<td NOWRAP><%=rs.getString("roomdesc")%></td>
		<%
		if(!mStaffID.equals("ALL"))
		{
		%>
		<td align=center NOWRAP><font  color="<%=mColor%>" ><b><%=mInvgRole%></b></font></font></td>
		<%
		}
		%>
		</tr>
	 	<%	
		}
	
       } // closing of while
	%>
	</table>
	<%
	}	
	else
		   {
			out.println("<center><Br><Br><font color=red face=arial size=4> Invigilation Duty is not yet Finalized !..  </center>");
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
