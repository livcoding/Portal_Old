<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
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
<TITLE>#### <%=mHead%> [ Booked Room Cancellation ] </TITLE>
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
	document.frm.x.value='ddd';
	}
	//-->
    </script>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

</head>

<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
	OLTEncryption enc=new OLTEncryption();
try
{
	DBHandler db=new DBHandler();
	ResultSet rs=null, rs1=null,rsi=null;
	String qry="", qry1="";
int pos = 0;
	int SNo=0;	
	int kk=0;
	String mName1="", mName2="", mName3="", mName4="", mName5="", mName6="";
	String mMemberID="";
	String mMemberType="";
	String mCanStat="";
	String mMemberCode="";
	String mEMemberCode="",mBP="",mmBP="",mInst="";

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

	if(!mMemberID.equals("") && !mMemberType.equals("")) 
	{
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	String mMacAddress =" "; //session.getAttribute("IPADD").toString().trim();

	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('27','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
  //----------------------
	%>
<form name="frm" Action="EmpCancelRoomBookingAction.jsp" method="Post">
<input id="x" name="x" type=hidden>
<table width="100%" ALIGN=CENTER bottommargin=0 topmargin=0>
 <tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u>Room Cancellation</u></b></font></td></tr>
</table>
<!*********--Institute--************>
<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
<%
	qry="select distinct nvl(institutecode,' ')IC from INSTITUTEMASTER where nvl(DEACTIVE,'N')='N' ";
	rsi=db.getRowset(qry);
	while(rsi.next())
	{
		mInst=rsi.getString("IC");
	}
%>
<TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="100%" border=1>
<thead>
<tr bgcolor="#ff8c00">
<td align=left Title="Click on SlNo. to sort"><b><font color=white>SlNo.</font></b></td>
<td align=left Title="Click on Room No. to sort" nowrap><b><font color=white>Room No.</font></b></td>
<td align=CENTER Title="Click on Purpose to sort"><b><font color=white>Purpose</font></b></td>
<td align=CENTER Title="Click on Request Date to sort" nowrap><b><font color=white>Rqst. Date</font></b></td>
<td align=CENTER Title="Click on Booking Period to sort" nowrap><b><font color=white>Booking Period</font></b></td>
<td align=CENTER Title="Click on Cancel to sort"><b><font color=white>Cancel?</font></b></td>
</tr>
</thead>
<tbody>
<%
		qry="select distinct nvl(A.ROOMCODE,' ')RC, nvl(A.BOOKINGPURPOSE,' ' )BP, to_char(A.BOOKINGDATETIME,'DD-MM-YYYY')RD,to_char(A.BOOKINGDATETIME,'DD-MM-YYYY HH:MI PM')BOOKINGDATE,";
		qry=qry+" to_char(A.BOOKINGFROMDATE,'DD-MM-YYYY')BDF, to_char(A.BOOKINGUPTODATE,'DD-MM-YYYY')BDT, ";
		qry=qry+" to_char(A.BOOKINGFROMTIME,'HH:MI PM')BTF, to_char(A.BOOKINGUPTOTIME,'HH:MI PM')BTT, nvl(A.CANCELLATIONSTATUS,'N')CanStat, nvl(B.ROOMDESC,' ')ROOMDESC";
		qry=qry+" From ROOMBOOKINGINFO A, ROOMMASTER B Where trunc(A.BOOKINGUPTODATE)>=trunc(sysdate) and nvl(A.BOOKEDBY,' ')='"+mChkMemID+"'";
		//qry=qry+" and nvl(A.CANCELLATIONSTATUS,'N')='N' "; 	
		qry=qry+" AND NVL(A.DEACTIVE,'N')='N' AND A.ROOMCODE=B.ROOMCODE AND NVL(B.DEACTIVE,'N')='N' ORDER BY BDF, BTF, BDT, BTT";
		rs=db.getRowset(qry);
		//out.print(qry);
		SNo=0;
		while(rs.next())
		{	
			SNo++;
			mName1="checked_"+String.valueOf(SNo).trim();
			mName2="RoomNo_"+String.valueOf(SNo).trim();
			mName3="BookingPurpose_"+String.valueOf(SNo).trim();
			mName4="BookingDate_"+String.valueOf(SNo).trim();
			mName5="BookingFrom_"+String.valueOf(SNo).trim();
			mName6="BookingTo_"+String.valueOf(SNo).trim();
			mCanStat=rs.getString("CanStat");
			/*
			mBP=rs.getString("BP");
			//pos=mBP.indexOf("");
			mmBP=mBP.substring(0,5);
			out.print("abc"+mmBP);	
			*/
			if(mCanStat.equals("N"))
			{
		%>
			<tr>
			<input type=hidden Name=<%=mName2%> ID=<%=mName2%> value='<%=rs.getString("RC")%>'>
			<input type=hidden Name=<%=mName3%> ID=<%=mName3%> value='<%=rs.getString("BP")%>'>
			<input type=hidden Name=<%=mName4%> ID=<%=mName4%> value='<%=rs.getString("BOOKINGDATE")%>'>
			<input type=hidden Name=<%=mName5%> ID=<%=mName5%> value='<%=rs.getString("BDF")%>'>
			<input type=hidden Name=<%=mName6%> ID=<%=mName6%> value='<%=rs.getString("BDT")%>'>
			<td><b><%=SNo%>.</b></td>
			<td><FONT COLOR=GREEN><%=rs.getString("ROOMDESC")%></FONT></td>
			<td><FONT COLOR=GREEN><%=rs.getString("BP")%></FONT></td>
			<td><FONT COLOR=GREEN><%=rs.getString("RD")%></FONT></td>
			<td nowrap><FONT COLOR=GREEN><%=rs.getString("BDF")%> To <%=rs.getString("BDT")%>(<%=rs.getString("BTF")%> - <%=rs.getString("BTT")%>)</FONT></td>
			<td align=center><input type='checkbox' name='<%=mName1%>' id='<%=mName1%>' value='Y'"></FONT></td>
			</tr>
		<%
			}
			else
			{
		%>
			<tr>
			<td><b><%=SNo%>.</b></td>
			<td><FONT COLOR=RED><%=rs.getString("ROOMDESC")%></FONT></td>
			<td><FONT COLOR=RED><%=rs.getString("BP")%></FONT></td>
			<td><FONT COLOR=RED><%=rs.getString("RD")%></FONT></td>
			<td nowrap><FONT COLOR=RED><%=rs.getString("BDF")%> To <%=rs.getString("BDT")%>(<%=rs.getString("BTF")%> - <%=rs.getString("BTT")%>)</FONT></td>
			<td><FONT COLOR=RED><b>Cancelled</b></FONT></td>
			</tr>
		<%
			}
		}
%>
<input type=hidden name=SNo id=SNo value=<%=SNo%>>
<input type=hidden name=INSTITUTE id=INSTITUTE value=<%=mInst%>>
</tbody>
</table>
<script type="text/javascript">
var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString"]);
</script>
<table width=100%>
<tr><td align=right>
<INPUT id=btn1 style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 102px; HEIGHT: 23px; FONT-VARIANT: normal" type=submit size=5 value="Cancel Room" name=btn1>
	</td></tr></table>
<%
 //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
  	}
 	 else
   	{
   %>
	<font color=red>
	<h3>	<br><img src='../../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font><br><br>
   <%
   }
  //-----------------------------
	}
	else
	{
	out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font></b></center>");
	}
}
catch(Exception e)
{
}
%>
</form>
</body>
</html>