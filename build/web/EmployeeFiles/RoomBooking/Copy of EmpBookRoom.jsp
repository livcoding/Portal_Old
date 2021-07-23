<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();
ResultSet rs=null,rsi=null;
ResultSet rs1=null,rss=null,RsChk1=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="";
String qry1="";
int mSNo=0;
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInstitute="",mInst="",mtext="";
String mRoom="",mRoomFor="",mRoomType="",mETime="",mFromTime="",mUptoTime="";
String mSection="",mSubsection="",mDate1="",mDate2="",mName1="",mName2="",mName3="",mName4="";
int kk=0,mINNN=0;
String mCurDate1="",mAmPm="";
String mTmpTime1="";
String mTmpTime2="",mRoomCode="";

qry="select to_Char(Sysdate,'dd-mm-yyyy') date1  from dual";
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



String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Resource Booking] </TITLE>
<script type="text/javascript" src="js/TimePicker.js"></script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<script language="JavaScript">
//Static analog Clock by kurt.grigg@virgin.net
//Script featured on JavaScript Kit
//http://javascriptkit.com

fCol='000000';//face colour.
sCol='ff0000';//seconds colour.
mCol='000000';//minutes colour.
hCol='000000';//hours colour.


H='....';
H=H.split('');
M='.....';
M=M.split('');
S='......';
S=S.split('');
Ypos=0;
Xpos=0;
Ybase=8;
Xbase=8;
dots=12;
ns=(document.layers)?1:0;
if (ns){
dgts='1 2 3 4 5 6 7 8 9 10 11 12';
dgts=dgts.split(' ')
for (i=0; i < dots; i++){
document.write('<layer name=nsDigits'+i+' top=0 left=0 height=30 width=30><center><font face=Arial,Verdana size=1 color='+fCol+'>'+dgts[i]+'</font></center></layer>');
}
for (i=0; i < M.length; i++){
document.write('<layer name=ny'+i+' top=0 left=0 bgcolor='+mCol+' clip="0,0,2,2"></layer>');
}
for (i=0; i < H.length; i++){
document.write('<layer name=nz'+i+' top=0 left=0 bgcolor='+hCol+' clip="0,0,2,2"></layer>');
}
for (i=0; i < S.length; i++){
document.write('<layer name=nx'+i+' top=0 left=0 bgcolor='+sCol+' clip="0,0,2,2"></layer>');
}
}
else{
document.write('<div style="position:absolute;top:0px;left:0px"><div style="position:relative">');
for (i=1; i < dots+1; i++){
document.write('<div id="ieDigits" style="position:absolute;top:0px;left:0px;width:30px;height:30px;font-family:Arial,Verdana;font-size:10px;color:'+fCol+';text-align:center;padding-top:10px">'+i+'</div>');
}
document.write('</div></div>')
document.write('<div style="position:absolute;top:0px;left:0px"><div style="position:relative">');
for (i=0; i < M.length; i++){
document.write('<div id=y style="position:absolute;width:2px;height:2px;font-size:2px;background:'+mCol+'"></div>');
}
document.write('</div></div>')
document.write('</div></div>')
document.write('<div style="position:absolute;top:0px;left:0px"><div style="position:relative">');
for (i=0; i < H.length; i++){
document.write('<div id=z style="position:absolute;width:2px;height:2px;font-size:2px;background:'+hCol+'"></div>');
}
document.write('</div></div>')
document.write('<div style="position:absolute;top:0px;left:0px"><div style="position:relative">');
for (i=0; i < S.length; i++){
document.write('<div id=x style="position:absolute;width:2px;height:2px;font-size:2px;background:'+sCol+'"></div>');
}
document.write('</div></div>')
}
function clock(){
time = new Date ();
secs = time.getSeconds();
sec = -1.57 + Math.PI * secs/30;
mins = time.getMinutes();
min = -1.57 + Math.PI * mins/30;
hr = time.getHours();
hrs = -1.57 + Math.PI * hr/6 + Math.PI*parseInt(time.getMinutes())/360;
if (ns){
Ypos=window.pageYOffset+window.innerHeight-60;
Xpos=window.pageXOffset+window.innerWidth-80;
}
else{
Ypos=document.body.scrollTop+window.document.body.clientHeight-60;
Xpos=document.body.scrollLeft+window.document.body.clientWidth-60;
}
if (ns){
for (i=0; i < dots; ++i){
 document.layers["nsDigits"+i].top=Ypos-5+40*Math.sin(-0.49+dots+i/1.9);
 document.layers["nsDigits"+i].left=Xpos-15+40*Math.cos(-0.49+dots+i/1.9);
 }
for (i=0; i < S.length; i++){
 document.layers["nx"+i].top=Ypos+i*Ybase*Math.sin(sec);
 document.layers["nx"+i].left=Xpos+i*Xbase*Math.cos(sec);
 }
for (i=0; i < M.length; i++){
 document.layers["ny"+i].top=Ypos+i*Ybase*Math.sin(min);
 document.layers["ny"+i].left=Xpos+i*Xbase*Math.cos(min);
 }
for (i=0; i < H.length; i++){
 document.layers["nz"+i].top=Ypos+i*Ybase*Math.sin(hrs);
 document.layers["nz"+i].left=Xpos+i*Xbase*Math.cos(hrs);
 }
}
else{
for (i=0; i < dots; ++i){
 ieDigits[i].style.pixelTop=Ypos-15+40*Math.sin(-0.49+dots+i/1.9);
 ieDigits[i].style.pixelLeft=Xpos-14+40*Math.cos(-0.49+dots+i/1.9);
 }
for (i=0; i < S.length; i++){
 x[i].style.pixelTop =Ypos+i*Ybase*Math.sin(sec);
 x[i].style.pixelLeft=Xpos+i*Xbase*Math.cos(sec);
 }
for (i=0; i < M.length; i++){
 y[i].style.pixelTop =Ypos+i*Ybase*Math.sin(min);
 y[i].style.pixelLeft=Xpos+i*Xbase*Math.cos(min);
 }
for (i=0; i < H.length; i++){
 z[i].style.pixelTop =Ypos+i*Ybase*Math.sin(hrs);
 z[i].style.pixelLeft=Xpos+i*Xbase*Math.cos(hrs);
 }
}
setTimeout('clock()',50);
}
if (document.layers || document.all) window.onload=clock;
//-->
</script>


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
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

	<STYLE>
		input {			
			font-size:13px;
		}
	</STYLE>
</HEAD>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
try
{
if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{	
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
		qry="Select WEBKIOSK.ShowLink('26','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	      RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
			

 //----------------------
%>
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<table width="100%" ALIGN=CENTER bottommargin=0 topmargin=0>
 <tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana"><b><u><FONT SIZE=4>Resource Booking</FONT></u></b></font></td></tr>
</table>
<table cellpadding=2 cellspacing=0 width="100%" align=center rules=groups border=3>
<!*********--Institute--************>
<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
<%


if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}
%>
<!--*********Room Type**********-->
<tr><td><FONT color=black face=Arial size=2><b>Room Desc</b></FONT>
<%
try
{
	qry="select 'ALL' ROOMCODE ,'ALL' ROOMDESC from dual union all Select Distinct nvl(ROOMCODE,' ') ROOMCODE, NVL(ROOMDESC,' ')ROOMDESC from Roommaster Where nvl(Deactive,'N')='N' and InstituteCode='"+mInst+"'	 order by ROOMDESC";
	//out.print(qry);
	rs=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		%>
		<Select Name="RoomCode" tabindex="0" id="RoomCode" >	
		<%   
		while(rs.next())
		{
			mRoom=rs.getString("ROOMCODE");
			%>
				<OPTION Value ="<%=mRoom%>"><%=rs.getString("ROOMDESC")%></option>
			<%
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name="RoomCode" tabindex="0" id="RoomCode" >	
		<%
		while(rs.next())
		{
			mRoom=rs.getString("ROOMCODE");
			if(mRoom.equals(request.getParameter("RoomCode").toString().trim()))
 			{
			%>
				<OPTION selected Value ="<%=mRoom%>"><%=rs.getString("ROOMDESC")%></option>
			<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value ="<%=mRoom%>"><%=rs.getString("ROOMDESC")%></option>
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
//----***************Room For**********************



if (request.getParameter("x")!=null)
	
	{
		mDate1=mDate1=request.getParameter("TXT1").toString().trim();
		//mDate2=request.getParameter("TXT2").toString().trim();

	}
else
{
mDate1=mCurDate1;
//mDate2=mCurDate1;
}


%>
</td></tr>
<!******************Date**************-->
<tr><TD colspan=2><FONT color=black face=Arial size=2>Booking Date From &nbsp; 
<input Name=TXT1 Id=TXT1 Type=text maxlength=10 size=10 value='<%=mDate1%>'> </b>
<font size=1 color=teal>(DD-MM-YYYY)</font> </td></tr>

<tr><td colspan=2><FONT color=black face=Arial size=2>
<INPUT TYPE="radio" NAME="NotShowClass" value="DSC">Do not Show Scheduled Class Slots 
&nbsp;
<INPUT TYPE="radio" NAME="NotShowClass" value="SFS">Show Only Free Slots
&nbsp;
<INPUT TYPE="radio" NAME="NotShowClass" value="SMB">Show My Booking Only
</FONT>
&nbsp;&nbsp;&nbsp;

<INPUT id=submit1 style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 102px; HEIGHT: 23px; FONT-VARIANT: normal" type=submit size=5 value=" Show " name=submit1></td></tr>
</table>
</form>

<form name="frm1" method="post" >
<input id="x" name="x" type=hidden>
 <%	String NotShowClass="";

	if(request.getParameter("x")!=null)
	{
		if (request.getParameter("TXT1")!=null)
			mDate1=request.getParameter("TXT1").toString().trim();
		else
			mDate1="";

		if (request.getParameter("RoomCode")!=null)
			mRoom=request.getParameter("RoomCode").toString().trim();
		else
			mRoom="";

		if (request.getParameter("NotShowClass")!=null)
			NotShowClass=request.getParameter("NotShowClass").toString().trim();
		else
			NotShowClass="";
%>

<table class="sort-table" id="table-1" align=center bottommargin=0  topmargin=0 cellspacing=0 cellpadding=0 border=1 >
			<thead>
			<tr bgcolor="#ff8c00">
			<td><b><font color=white>Room Code</font></b></td>
			<td><b><font color=white>Purpose of Booking</font></b></td>
			<td><b><font color=white>Booked Time From</font></b></td>
						<td><b><font color=white>Booked Time To</font></b></td>
			<td><b><font color=white>Booked By</font></b></td>
			</tr>
			</thead>
			<tbody>

<%
			}  //----------- closing of (request.getParameter("x")!=null)
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
					 
				}
			%>
				</body>
				</html>

