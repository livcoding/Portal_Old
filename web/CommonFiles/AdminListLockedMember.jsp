<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../CommonFiles/ExceptionHandler.jsp" %> 
<%

try
{
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Locked Member List ] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
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
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
String qry="",qry1="";

String myLTP="",mChkvalue="";
int mSNO=0;
String mMemberID="";
String mMemberType="",mName1="",mName2="",mName3="";
String mMemberCode="";
String mDMemberCode="",x="";
String mMemberName="",mMType="",Mid="",MType="",mtype="",men="",mec="",Mtype="",DMid="",mInst="";
int kk=0;
String mCurDate1="";
qry="select to_Char(Sysdate,'dd-mm-yyyy') date1 from dual";
rs=db.getRowset(qry);
rs.next();
mCurDate1=rs.getString(1);


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

OLTEncryption enc=new OLTEncryption();

// For Log Entry Purpose
//--------------------------------------
String mLogEntryMemberID="",mLogEntryMemberType="";

if (session.getAttribute("BASELOGINID")==null || session.getAttribute("BASELOGINID").toString().trim().equals(""))
	mLogEntryMemberID="";
else
	mLogEntryMemberID=session.getAttribute("BASELOGINID").toString().trim();

if (session.getAttribute("BASELOGINTYPE")==null || session.getAttribute("BASELOGINTYPE").toString().trim().equals(""))
	mLogEntryMemberType="";
else
	mLogEntryMemberType=session.getAttribute("BASELOGINTYPE").toString().trim();

if (session.getAttribute("BASEINSTITUTECODE")==null)
	mInst="JIIT";
else
	mInst=session.getAttribute("BASEINSTITUTECODE").toString().trim();

if (!mLogEntryMemberType.equals(""))
	mLogEntryMemberType=enc.decode(mLogEntryMemberType);

if (!mLogEntryMemberID.equals(""))
	mLogEntryMemberID=enc.decode(mLogEntryMemberID);

 
//--------------------------------------
String mIPAddress=session.getAttribute("IPADD").toString().trim();
String mLoginIDFrSes="";
if(mInst.equals("JIIT"))
	mLoginIDFrSes="asklJIITADMINaskl";
else if(mInst.equals("JPBS"))
	mLoginIDFrSes="asklJPBSADMINaskl";
else	
	mLoginIDFrSes="asklADMINaskl";
//out.print(mLogEntryMemberID+" - "+mLoginIDFrSes);
	if(mLogEntryMemberID.equals(mLoginIDFrSes) && mLogEntryMemberType.equals("A")) 

	{
%>
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<table width="100%" ALIGN=CENTER bottommargin=0 topmargin=0>
		<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">Locked Member List (Current Status)</font></td></tr>
		</table>
<table cellpadding=5 align=center rules=groups border=2 style="WIDTH: 380px; HEIGHT: 50px">
<tr>
<!--Institute-->
<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
<!--******MemberType**********-->
 <td colspan=0 align=middle><FONT color=black><FONT face=Arial size=2><STRONG>Member Type</STRONG></FONT></FONT>
	
		<select name=MemberType tabindex="0" id="MemberType" style="WIDTH: 120px">	
		<%
			if(request.getParameter("MemberType")==null)
		{
		%>
			<option value="S" Selected>Student</option>
	     		<option value="E">Employee</option>
			<option value="G">Guest</option>		
      		<option value="V">Visitor</option>		
		<%
		}
		else
		{
			if(request.getParameter("MemberType").toString().trim().equals("S"))
			{
			%>
				<option value="S" Selected>Student</option>
			<%
			}
			else
			{
			%>
				<option value="S">Student</option>
			<%
			}	
			
			if(request.getParameter("MemberType").toString().trim().equals("E"))
			{
			%>
				<option value="E" Selected>Employee</option>
			<%
			}
			else
			{
			%>
				<option value="E">Employee</option>
			<%
			}
			
			if(request.getParameter("MemberType").toString().trim().equals("G"))
			{
			%>
				<option value="G" Selected>Guest</option>
			<%
			}
			else
			{
			%>
				<option value="G">Guest</option>
			<%
			}	
			if(request.getParameter("MemberType").toString().trim().equals("V"))
			{
			%>
				<option value="V" Selected>Visitor</option>
			<%
			}
			else
			{
			%>
				<option value="V">Visitor</option>
			<%
			}
		}
		%>
	 	</select>
</td>
&nbsp;&nbsp;
<td>
<INPUT TYPE="submit" NAME=btn1 ID=btn1 VALUE=Show/Refresh> 
</TD>
</tr>
</form>
</TABLE>
<center>
	
	<table bgcolor=#fce9c5 class="sort-table" id="table-1" width='98%' bottommargin=0 rules=groups topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center>	
	<form name="frm1"  method="post" action="AdminListLockedMemberAction.jsp"> 
	<thead>
	<tr bgcolor="#ff8c00">
		<td Title="Sort on SlNo"><font color=white><b>S.No</b></td>
		<td Title="Sort on LoginID"><font color=white><b>Login Id</b></td>
		<td Title="Sort on Member Name"><font color=white><b>Member Name</b></td>
           	<td Title="Sort on Member Type"><font color=white><b>Member Type</b></td>
		<td ><font color=white><b>Unlock</b></td>
		</tr></thead><tbody>
   <%
	if(request.getParameter("x")!=null)
	{
		mMType=request.getParameter("MemberType").toString().trim();
           	Mtype=enc.encode(mMType);
		qry="select nvl(ORAID,' ')ORAID from membermaster where nvl(DEACTIVE,'N')='Y' and ORATYP='"+Mtype+"'";
		rs=db.getRowset(qry);
		while(rs.next())
		{
			kk++;
			Mid=rs.getString("ORAID");
			DMid=enc.decode(Mid);
			mName1="MID"+String.valueOf(kk).trim();
			mName2="ACTIVE"+String.valueOf(kk).trim();

			if(mMType.equals("S"))
      		{				
				x="Students";
        		  qry1="Select nvl(enrollmentno,' ')enrollmentno,nvl(STUDENTNAME,' ')STUDENTNAME from STUDENTMASTER";
			  qry1=qry1+" where studentid='"+DMid+"' order by STUDENTNAME desc ";
			  rs1=db.getRowset(qry1);
				while(rs1.next())
				{
				 men=rs1.getString("STUDENTNAME");
			       mec=rs1.getString("enrollmentno");
				}
				
			}
    		  	else if(mMType.equals("E"))
       		 {	
				x="Employee";
                  	 qry1="Select nvl(employeecode,' ')employeecode,nvl(EMPLOYEENAME,' ')EMPLOYEENAME from V#STAFF";
	        		 qry1=qry1+" where employeeid='"+DMid+"' order by EMPLOYEENAME";
			
      	            rs1=db.getRowset(qry1);  
  				while(rs1.next())
				{
				 men=rs1.getString("EMPLOYEENAME");
			       mec=rs1.getString("employeecode");
	           	      }
			}
    		  	else if(mMType.equals("G"))
       		{	
				x="Guest";
                  	 qry1="Select nvl(guestcode,' ')employeecode,nvl(GUESTNAME,' ')EMPLOYEENAME from GUEST";
	        		 qry1=qry1+" where GUESTID='"+DMid+"' order by EMPLOYEENAME";
			
      	            rs1=db.getRowset(qry1);  
  				while(rs1.next())
				{
				 men=rs1.getString("EMPLOYEENAME");
			       mec=rs1.getString("employeecode");
	           	      }
			}
			mName3="EC"+String.valueOf(kk).trim();
		%>         
		<input type=hidden name=<%=mName1%> ID=<%=mName1%> value='<%=Mid%>' >
		<input type=hidden name=<%=mName3%> ID=<%=mName3%> value='<%=mec%>' >
            	<tr>
			<td><%=kk%></td>
			<td><%=mec%></td>
			<td><%=GlobalFunctions.toTtitleCase(men)%></td>
           		<td><%=x%></td>
			<td><input type=checkbox name='<%=mName2%>' id='<%=mName2%>' value='Y'></td>
			</tr>
	<%
} //closing of while     
%>
<input type=hidden name=INSTITUTE ID=INSTITUTE value=<%=mInst%>>
<input type=hidden name=TYPE ID=TYPE value=<%=mMType%>>
<input type=hidden name=TotalRec ID=TotalRec value=<%=kk%> >
<!--<tr><td colspan=5 align=center><input type=submit value=Unlock></td></tr>-->

</table>
	<script type="text/javascript">
	var st1 = new SortableTable(document.getElementById("table-1"),["Number","Number","CaseInsensitiveString", "CaseInsensitiveString" ]);
	</script>
<table bgcolor=white  width='98%' bottommargin=0 rules=groups topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center>	
<tr><td colspan=5 align=center><input type=submit value=Unlock></td></tr>
<table>		

	</form>
<%
} // closing of outer if

   //-----------------------------
}
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
}		
catch(Exception e)
{
}
%>

<table ALIGN=Center VALIGN=TOP>
		<tr>
		<td valign=middle><br>

<br>
		<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">
		<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
		A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
		</td></tr></table>
</body>
</html>
