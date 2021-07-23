<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="JIIT UNIVERSITY, NOIDA ### COUNSELLING 2008 ###";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%></TITLE>

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

</head>
<BODY aLink=#ff00ff bgcolor=fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
String qry="";
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInst="";
String mWebEmail="";
String mName="";

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


 
   try
   {
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{
		OLTEncryption enc=new OLTEncryption();
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
		qry="Select WEBKIOSK.ShowLink('127','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{
		%>	
	
		<form name=frm1 method=post Action="ShowFrameStud.jsp">
		<table border=4 bordercolor=green align=center>
		<tr><td align=center><font color=brown face='Arial' size=4>Setup for Students Admission Status</font>
		<table border=1 bordercolor=blue rules=groups  cellpadding=0 cellspacing=0 width='100%'>
			<tr><td><font color=Red><b>Display Institute</b></font></td></tr>
		<%
		String mCDay="",mLDay="";
			qry="Select to_char(sysdate,'DD-MM-YYYY') CDay,to_char(sysdate-1,'DD-MM-YYYY') PDay from C#SEATDISPLAY A, C#INSTITUTEMASTER B Where A.INSTITUTECODE is not null and A.InstituteCode=b.InstituteCode and nvl(A.NOOFSEATS,0)>0 and rownum<=1 group by A.INSTITUTECODE,B.INSTITUTENAME";	 
			rs=db.getRowset(qry);			
			if (rs.next())
			{
			  mCDay=rs.getString(1);
			  mLDay=rs.getString(2);
			}
			qry="Select A.INSTITUTECODE INSTITUTECODE, nvl(B.INSTITUTEName,A.INSTITUTECODE) IName from C#SEATDISPLAY A, C#INSTITUTEMASTER B Where A.INSTITUTECODE is not null and A.InstituteCode=b.InstituteCode and nvl(A.NOOFSEATS,0)>0 and rownum<=1 group by A.INSTITUTECODE,B.INSTITUTENAME";	 
			rs=db.getRowset(qry);			
			while (rs.next())
			{			
			mName="I"+rs.getString("INSTITUTECODE");
			%>
			<tr><td>
			<input checked type='checkbox' Vale="Y" name=<%=mName%>><%=rs.getString("IName")%>
			</td></tr>
			<%
			}
		
		%>
			</table>
		
		<br>

			<%
			qry="Select A.PROGRAMTYPECODE PROGRAMTYPECODE, nvl(B.PROGRAMTYPENAME,A.PROGRAMTYPECODE) PName  from C#SEATDISPLAY A, C#PROGRAMTYPEMASTER B Where A.INSTITUTECODE is not null And A.PROGRAMTYPECODE=B.PROGRAMTYPECODE and nvl(A.NOOFSEATS,0)>0 group by A.PROGRAMTYPECODE,B.PROGRAMTYPENAME order by PROGRAMTYPENAME ";	
			%>
		<table border=1 bordercolor=blue cellpadding=0 cellspacing=0 width='100%'>
			<tr><td><font color=Red><b>Program Type</b></font>
			<select Name=PType Id=PType>
		<%
 
			rs=db.getRowset(qry);			
			int mFlag=0;
			while (rs.next())
			{			
			if (mFlag==0)
			{
			%>			
			<option selected value='<%=rs.getString("PROGRAMTYPECODE")%>'><%=rs.getString("PName")%> (<%=rs.getString("PROGRAMTYPECODE")%>)</option>			
			<%
			}
			else
			{
			%>			
			<option value='<%=rs.getString("PROGRAMTYPECODE")%>'><%=rs.getString("PROGRAMTYPECODE")%></option>			
			<%
			}		
			}
			%>
			</td></tr></table>
		<br>
		<table width='100%' rules=groups  border=1 bordercolor=black cellpadding=0 cellspacing=0>
			<tr><td><font color=red><b>Display Categories</b></font></tr></tr>
		<%
			qry="SELECT A.CATEGORYCODE CATEGORYCODE,nvl(B.CATEGORYDESC,A.CATEGORYCODE)||' ('||A.CATEGORYCODE||' )' cat from C#SEATDISPLAY A, C#CATEGORYMASTER B Where A.CATEGORYCODE=B.CATEGORYCODE And A.INSTITUTECODE is not null and nvl(A.NOOFSEATS,0)>0 Group By A.CATEGORYCODE,nvl(B.CATEGORYDESC,A.CATEGORYCODE)||' ('||A.CATEGORYCODE||' )' order by A.CATEGORYCODE";

 
			rs=db.getRowset(qry);			
			while (rs.next())
			{			
			mName="C"+rs.getString("CATEGORYCODE").trim();
			%>
			<tr><td>
			<input type='checkbox' name="<%=mName%>" id="<%=mName%>"><%=rs.getString("cat")%>
			</td></tr>
			<%
			}
			%>		
			</table>

			</td></tr>
			<tr><td>
			<font color=red><b>Refresh Rate in Second(s):</font> <input type=text id=second name=second value="60" size=5 maxlength=5>
			<font color=red><b>Counseling for the Year:</b></font> <INPUT id=TxtYear style="WIDTH: 36px; HEIGHT: 22px" size=4 value="2007" name=TxtYear>
			</b></td></tr>
			<tr><td><font color=red><b>Counselling for the Period (Formt: DD-MM-YYYY)</b></font>
			<input type="Text" ID="dtFrom" Name="dtFrom" value="<%=mLDay%>" style="WIDTH: 80px; HEIGHT: 22px" size=10> And <input type="Text" ID="dtTo" Name="dtTo" style="WIDTH: 80px; HEIGHT: 22px" value="<%=mCDay%>" size=10>			
			</td></tr>
			<tr><td align=center><STRONG><input type="submit" name=btn1 id=btn1 value="Show Seat Status"></td></tr>
			</table>
			</form>
			<%
    		
		   }
		  else
		{
	         %>
	<br>
	<font color=red>
	<h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font><br><br><br><br>
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
out.print("aaa");
   }


 %>
		</BODY>
		</HTML>