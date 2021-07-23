<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %> 
<%
try
{
String mHead="JAYPEE INSTITUTE OF INFORMATION TECHNOLOGY UNIVERSITY, NOIDA ### COUNSELLING 2009 ###";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%></TITLE>

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

<Script language="Javascript">

function LoadPageS(mWidth, mHeight)
{
	var params = "location=no,status=no,toolbar=no,menubar=no,scrollbars=no,resizable=yes,width="+mWidth+",height="+mHeight+",left=0,top=0,resizable=no"; 
	window.opener = top; 
	window.close(); 
	window.open("ShowSeatStatus.jsp", "", params); 
}

</script>
<script>

function FunDateChk()
{
	if(document.frm1.CounsDate[0].checked==true)
	{
		//alert('Accumulative Counselling');
		document.frm1.dtFrom.disabled=true;
		document.frm1.dtTo.disabled=true;
	}
	else if(document.frm1.CounsDate[1].checked==true) 
	{
		//alert('Datewise Counselling');
		document.frm1.dtFrom.disabled=false;
		document.frm1.dtTo.disabled=false;
	}

}
function check()
{
	
	if(document.frm1.count.value>0)	
	{
		var ncheck=document.frm1.count.value;
		var i,flag;
		//alert(document.frm1[ncheck].checked);
		for(i=1;i<=ncheck;i++)
		{
			if(document.getElementById(i).checked==true)
			{
				flag=1;
			}
			
		}
	}
	if(flag==1){
		return true;
	}
	else{
		alert("Please Select Atleast One Category")
		return false;
	}
}
-->
</script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 onLoad="FunDateChk()">
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
String mCounsDate="", mFrDate="", mToDate="";

   try
   {
	if(1==1)
	{
		if (1==1)
		{
		%>
		<br>
		<form name=frm1 method=post Action="ShowFrames.jsp">
		<table border=4 bordercolor=green align=center width='75%'>
		<tr><td align=center><font color=brown face='Arial' size=4>Setup for Seat Allocation Screen</font>
		<table border=1 bordercolor=blue cellpadding=0 rules=groups cellspacing=0 width='100%'>
			<tr><td><font color=Red><b>Display Institutes</b></font></td></tr>
		<%
			qry="Select A.INSTITUTECODE INSTITUTECODE, nvl(B.INSTITUTEName,A.INSTITUTECODE) IName from C#SEATDISPLAY A, C#INSTITUTEMASTER B Where A.INSTITUTECODE is not null and A.InstituteCode=b.InstituteCode and nvl(A.NOOFSEATS,0)>0 group by A.INSTITUTECODE,B.INSTITUTENAME";
	 
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
		
			<table width='100%' border=1 bordercolor=black cellpadding=0 cellspacing=0 rules=groups>			
			<tr><td><font color=darkblue><b>Display Category</b></font></tr></tr>
			<%			
			qry="SELECT A.CATEGORYCODE CATEGORYCODE,nvl(B.CATEGORYDESC,A.CATEGORYCODE)||' ('||A.CATEGORYCODE||' )' cat from C#SEATDISPLAY A, C#CATEGORYMASTER B Where A.CATEGORYCODE=B.CATEGORYCODE And A.INSTITUTECODE is not null and nvl(A.NOOFSEATS,0)>0 Group By A.CATEGORYCODE,nvl(B.CATEGORYDESC,A.CATEGORYCODE)||' ('||A.CATEGORYCODE||' )' order by A.CATEGORYCODE"; 
			//out.print(qry);
			int i=0;
			rs=db.getRowset(qry);			
			while (rs.next())
			{			
			mName="C"+rs.getString("CATEGORYCODE");
			%>
			<tr><td>
			<input type='checkbox' Vale="Y" name=<%=mName%> id=<%=++i%>><%=rs.getString("cat")%>
			</td></tr>
			<%
			}
			%>		
			</table>
			<input type="hidden" value=<%=i%> name="count" />
			</td></tr>
			<tr><td>
			<font color=Red><b>Refresh Rate in Second(s)</b></font> <input type=text id=second name=second value="60" size=5 maxlength=5>
			</td></tr>
			<%
				qry="Select to_char(sysdate,'dd-mm-yyyy')CurrDate from dual";
				rs=db.getRowset(qry);
				if(rs.next())
				{
					mFrDate=rs.getString(1);
					mToDate=rs.getString(1);
				}
				if(request.getParameter("CounsDate")==null)
					mCounsDate="A";
				else
					mCounsDate=request.getParameter("CounsDate").toString().trim();
				if(mCounsDate.equals("D"))
				{
					if(request.getParameter("dtFrom")==null)
						mFrDate=mFrDate;
					else
						mFrDate=request.getParameter("dtFrom").toString().trim();
					if(request.getParameter("dtTo")==null)
						mToDate=mToDate;
					else
						mToDate=request.getParameter("dtTo").toString().trim();
				}
			%>
			<tr><td nowrap><font color=red><b><input type=radio name=CounsDate value="A" checked OnClick="FunDateChk()">Accumulative Counselling <input type=radio name=CounsDate value="D" OnClick="FunDateChk()">Counselling for the Period From: (DD-MM-YYYY)</b></font>
			<input type="Text" ID="dtFrom" Name="dtFrom" value="<%=mFrDate%>" style="WIDTH: 70px; HEIGHT: 22px" size=10> <font color=red><b>To</b></font> <input type="Text" ID="dtTo" Name="dtTo" style="WIDTH: 70px; HEIGHT: 22px" value="<%=mToDate%>" size=10>			
			</td></tr>
			<tr><td>
			<input type="Checkbox" id=HOSTEL name=HOSTEL checked value="Y"><font color=Red><b>Show Hostel Status</b></font>			
			</td></tr>
			<tr><td>
			<input type="Checkbox" id="IstAttendance" name="IstAttendance" checked value="Y"><font color=Red><b>Show Last Rank of First Attendance</b></font>			
			&nbsp; &nbsp; <input type="Checkbox" id="IIndAttendance" name="IIndAttendance" checked value="Y"><font color=Red><b>Show Last Rank of 2nd Attendance</b></font>
			<br><input type="Checkbox" id="DcoumentV" name="DcoumentV" checked value="Y"><font color=Red><b>Show Last Rank of Document Verified</b></font>			
			<input type="Checkbox" id="CounsDone" name="CounsDone" checked value="Y"><font color=Red><b>Show Last Rank of Counselling done</b></font>			
			<br><input type="Checkbox" id="FeesPaid" name="FeesPaid" checked value="Y"><font color=Red><b>Show Last Rank of Fees paid</b></font>			
			</td></tr>
			<tr><td align=center><STRONG><input type="submit" name=btn1 id=btn1 value="Show Seat Status" onclick="return check();"></td></tr>
			</table>
			</form>
			<%
    		
		   }
		  else
	        { 
                		
			 %>
	<br>
	<font color=red>
	<h3>	<br><img src='../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font><br><br><br><br>
   	<%

        	   }   
	     }   
           else 
           {
                   out.print("<br><img src='../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
            } 
   } 
   catch(Exception e)
  {
   }
}
catch(Exception e)
  {
   }

 %>
		</BODY>
		</HTML>