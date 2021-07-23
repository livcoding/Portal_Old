<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mSCellNo="", mPCellNo="", mSTelNo="", mPTelNo="", mSEmail="",mPEmail="";
String mInst="",mWebEmail="";
String mMem="";
String mMemID="";
String qry="",mDID="",qury="";
String mSemail="",mDMemC="",mInstC="",mMemberID="",mMemberType="";
String academicyear="",active="",starttime="",queall="",endtime="",beytime="",hbook="",ttint="",vbook="";
String mint="",roomusagecode="";
int n=0,bbhour=0,abhour=0,tslot=0,abdays=0,n1=0,roomcapacity=0,roomcapacityY=0,roomcapacityX=0,examseating=0,invigilator=0,exammatrixX=0,exammatrixY=0,minseating=0,i=0,j=0,p=0,s=0,n2=0,n3=0;
String x="",Date1="",ParmemberID ="",MatchArray="",result="",Message="",roomname="",roomdes="",roomcode="";
String mINSTITUTECODE =" ",qry2="",resname="",rescode="",institute="",qry1="",qry4="";
ResultSet rs=null,rsi=null,rss=null,rs1=null,rs2=null;
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
String days="",rcode="",shortname="",rname="",rcat="",ret="",inst="",insti="",sinst="",dinfo="",rtype="",qry3="",recode="",resID="",forexam="",resourcetypeId="",resourceId="",tagedinstitute="",bookedistitute="",time1="",time2="";

//----------------------
%>				
<html>
 <head>
    <title>Resouce Master</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<!-- <link rel="stylesheet" href="Accordion/js/jquery-ui.css" /> 
	<script src="Accordion/js/jquery-1.9.1.js"></script> 
	<script src="Accordion/js/jquery-ui.js"></script>
	<link rel="stylesheet" href="/resources/demos/style.css" /> -->
	
	<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
	<script language="JavaScript" type="text/javascript" src="js/sortabletable.js"></script>
	<script type="text/javascript" src="js/TimePicker.js"></script>
	
	<script type="text/javascript">
	 function booking()
	{	
	var cnt=0;
	var v=document.getElementById("count").value;	
	//alert(v);
	var tag= new Array(v);
	for(k=1;k<=v;k++)
		{ 
	tag[k]=document.getElementById("chk"+k).value;
	if(document.getElementById("chk"+k).checked==true)
			{cnt++;
		
		
	for(var j=1;j<=k;j++)
				{
		document.getElementById("tagedinstitute"+k).value=tag[j];
		document.getElementById("forbook"+k).value=tag[j];		
				}	
			}
			else
				{
			for(j=1;j<=k;j++)
				{
		document.getElementById("tagedinstitute"+k).value="";
		document.getElementById("forbook"+k).value="";
				}	

			}
			
	}
	document.getElementById("c").value=cnt;
	
		
}

function priorty()
{
	var cnt=0;
	var v=document.getElementById("count").value;	
	//alert(v);
	var tag= new Array(v);
	for(var k=1;k<=v;k++)
		{ 
	tag[k]=document.getElementById("check"+k).value;
		if(document.getElementById("check"+k).checked==true)
			{document.getElementById("check"+k).value=document.getElementById("forbook"+k).value;
		
		}
		else
		{
		document.getElementById("check"+k).value="";
		}
		//alert(document.getElementById("check"+k).value);
		//alert(tag[k]);
		}
}

function move()
	{	
		var cnt=0,c=0;	
		var v=document.getElementById("count").value;	
		var taged= new Array(v);
		var c=document.getElementById("c").value;
		for(var p=1;p<=v;p++)
			{
				if(document.getElementById("forbook"+p).value=="")
			{
		document.getElementById("check"+p).checked=false;
			}
			else
			{
			taged[p]=document.getElementById("check"+p).value;
			if(document.getElementById("check"+p).checked==true)
			{	cnt++;
			
				if(document.getElementById("priorty"+cnt).value=="")
					{
			document.getElementById("priorty"+cnt).value=taged[p];
			document.getElementById("check"+p).checked=false;
					}
					else
				{
				document.getElementById("priorty"+c).value=taged[p];
				document.getElementById("check"+p).checked=false;
				}//alert(taged[p]);
				
				}
			}//alert(document.getElementById("check"+p).value);
			document.getElementById("v").value=cnt;
			document.getElementById("z").value=c;
			//alert(document.getElementById("v").value);
		if(document.getElementById("checki"+p).checked==true)
				{
			document.getElementById("priorty"+cnt).value="";
		}
		for(var s=1;s<=c;s++)
		{
			
			document.getElementById("timepriorty"+s).value=document.getElementById("priorty"+s).value;
			
			}	
			}
			

		
				//alert(document.getElementById("priorty"+p).value);
		}


</script> 
<script>
function open_win()
{
window.open('roomtable.jsp','','width=500,height=400');
}
</script>

	
 </head>
	<body topmargin="10" rightmargin="0" leftmargin="10" bottommargin="0" bgcolor="#fce9c5">
    <%
	try
{
if (session.getAttribute("WebAdminEmail")==null)
{
	 mWebEmail="";
}	 
else
{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
}


if (session.getAttribute("InstituteCode")==null)
{
    mInstC="";
}
else
{
    mInstC=session.getAttribute("InstituteCode").toString().trim();
}
if(session.getAttribute("MemberCode")==null)
{
	mMem="";	
}
else
{
	mMem=session.getAttribute("MemberCode").toString().trim();
}

if(session.getAttribute("MemberID")==null)
{
	mMemID="";	
}
else
{
	mMemID=session.getAttribute("MemberID").toString().trim();
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



if (session.getAttribute("MemberID")!=null && session.getAttribute("MemberCode")!=null)
{
	OLTEncryption enc=new OLTEncryption();
	mDID=enc.decode(session.getAttribute("MemberID").toString().trim());
	mDMemC=enc.decode(session.getAttribute("MemberCode").toString().trim());

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress=session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
// For Log Entry Purpose
//--------------------------------------
String mLogEntryMemberID="",mLogEntryMemberType="";

if (session.getAttribute("LogEntryMemberID")==null || session.getAttribute("LogEntryMemberID").toString().trim().equals(""))
	mLogEntryMemberID="";
else
	mLogEntryMemberID=session.getAttribute("LogEntryMemberID").toString().trim();


if (session.getAttribute("LogEntryMemberType")==null || session.getAttribute("LogEntryMemberType").toString().trim().equals(""))
	mLogEntryMemberType="";
else
	mLogEntryMemberType=session.getAttribute("LogEntryMemberType").toString().trim();

if (mLogEntryMemberType.equals(""))
	mLogEntryMemberType=mMemberType;

if (mLogEntryMemberID.equals(""))
	mLogEntryMemberID=mMemberID;


if (!mLogEntryMemberType.equals(""))
	mLogEntryMemberType=enc.decode(mLogEntryMemberType);

if (!mLogEntryMemberID.equals(""))
	mLogEntryMemberID=enc.decode(mLogEntryMemberID);

//--------------------------------------


  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('275','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";

      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{ %>
	<form name="frm"  method="get" >
   <input id="x" name="x" type="hidden">
   <br><table cellspacing="0"  cellpadding="1"  style="FONT-FAMILY: Arial; 
    FONT-SIZE: x-small" borderColor="black" borderColorDark="white" width="100%">
   <tr><td align="center">
	<font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><U>Resource Master</U>
	</td></tr></table>
		 <table cellspacing="0"  cellpadding="1" frame ="box" align="center" border="1" style="FONT-FAMILY: Arial; 
    FONT-SIZE: x-small" borderColor="black" borderColorDark="white" width="100%">
   <br>
   <tr bgcolor="#ff8c00">

  
		
	<td valign="top" colspan="3" align="center"><FONT color=black face=Arial size=2>&nbsp;Resource Type Code/Name
     <% 
{
qry="select upper(RESOURCETYPECODE)  RESOURCETYPECODE ,RESOURCETYPEID from RS#RESOURCETYPE";
rs=db.getRowset(qry);
rs1=db.getRowset(qry);
while (rs1.next())
	{
MatchArray=rs1.getString(1);
result=result+MatchArray+"~";
}
%>
<input type="hidden" id=mField  name=mField value="<%=result%>">
<select name="rescode"  id="rescode"  style="width:160px;" >
<option value="N"><font=Calibri  size=2><-Select Res.Code-></option>
<%
	if(request.getParameter("x")==null)
	{
	while(rs.next())
	{ %>
<option value="<%=rs.getString("RESOURCETYPEID")%>"> <%=rs.getString("RESOURCETYPECODE")%></option>
<%}}
	else{while(rs.next())
	{
					rescode=rs.getString("RESOURCETYPE");

	if(rescode.equals(request.getParameter("rescode")))
			{%>
	<option  selected  value="<%=rs.getString("RESOURCETYID")%>"><%=rs.getString("RESOURCETYPECODE")%></option>
<%
			}
			else
			{
%>
<option value="<%=rs.getString("RESOURCETYID")%>"><%=rs.getString("RESOURCETYPECODE")%></option>
<%
			}
			}
	}		
	}
	%>
	</select>
	&nbsp;
     <% 
{
qry="select upper(RESOURCETYPENAME)  RESOURCETYPENAME,RESOURCEDETAILS from RS#RESOURCETYPE";
rs=db.getRowset(qry);
rs1=db.getRowset(qry);
while (rs1.next())
	{
MatchArray=rs1.getString(1);
result=result+MatchArray+"~";
}
%>
<input type="hidden" id=mField  name=mField value="<%=result%>">

<select name="resname"  id="resname"  style="width:160px;" >
<option value=""><-Select Res.Name-></option>
<%
	if(request.getParameter("x")==null)
	{
	while(rs.next())
	{ %>
<option value="<%=rs.getString("RESOURCEDETAILS")%>"> <%=rs.getString("RESOURCETYPENAME")%></option>
<%}}
	else{while(rs.next())
	{
					resname=rs.getString("RESOURCETYPENAME");

	if(resname.equals(request.getParameter("resname")))
			{%>
	<option  selected  value="<%=rs.getString("RESOURCEDETAILS")%>"><%=rs.getString("RESOURCETYPENAME")%></option>
<%
			}
			else
			{
%>
<option value="<%=rs.getString("RESOURCEDETAILS")%>"><%=rs.getString("RESOURCETYPENAME")%></option>
<%
			}
			}
	}		
	}
	%>
	</select><input type="button" value="view" style="width:50px;">
	
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		
		<input type="checkbox" id="active" name="active" value="<%=active%>">DeActive
		</td>
  
		<%if (request.getParameter("active")!=null)
			active="Y";
		else
			active="N";
		%></tr>
		<tr>
		<td align="left"  ><FONT color=black face=Arial size=2>&nbsp; Resource Type Code/Name
  <input type="text" value="<%=rcode%>" name="rcode" id="rcode" onKeyUp="return upper();" style="width:75px;" >
  <input type="text" value="<%=rname%>" name="rname" id="rname" onKeyUp="return upper();" style="width:160px;">
		
 <%
			if(request.getParameter("rcode")!=null)
		 rcode=request.getParameter("rcode").toString().trim();
         else	
		rcode="";
			if(request.getParameter("rname")!=null)
		 rname=request.getParameter("rname").toString().trim();
         else	
		rname="";%></td>
		<td  valign="top" ><FONT color=black face=Arial size=2>&nbsp;Advance Booking Days
	<input type="text" value="<%=abdays%>" name="abdays" id="abdays" style="width:50px;">
		
<%
		 if(request.getParameter("abdays")!=null)
			abdays=Integer.parseInt(request.getParameter("abdays"));
		else
            abdays=0;	
	%></td><td  valign="top" colspan="" ><FONT color=black face=Arial size=2>&nbsp;Resource Category
		
		
<%// qry="select distinct RESOURCECATEGORY rescat,decode(RESOURCECATEGORY,'O','Other','R','Room') RESOURCECATEGORY from RS#RESOURCETYPE";
 
   //rs=db.getRowset(qry);
%>
<select name="rcat"  id="rcat" style="width:100px;" onchange="open_win()">
<option value=""><-Select-></option>
<option value="R" >Room</a></option>
<option value="O"><a href="roomtable.jsp">Other</a></option>
</select>
<%if(request.getParameter("rcat")!=null)
		{rcat=request.getParameter("rcat");
		}
		else
		{rcat="";}%>


</td>
	
	</table></br>
	
<table style="FONT-FAMILY: Arial;FONT-SIZE: x-small" borderColor="black" borderColorDark="white" width="100%">
<tr>
<td width="30%">
		<table cellspacing=1  cellpadding=1 border="1" style="FONT-FAMILY: Arial;FONT-SIZE: x-small" borderColor="black" borderColorDark="white" >
	
		<tr>
		<h5>Resource Institute Tagging</h5> 
		<td width="50%">
			<table cellspacing=1  cellpadding=1  style="FONT-FAMILY: Arial;FONT-SIZE: x-small" borderColor="black" borderColorDark="white" width="50%">
			Institutes:
			<%qry="SELECT INSTITUTECODE FROM INSTITUTEMASTER";
			rs=db.getRowset(qry);
			while(rs.next()){i++;
			institute=rs.getString("INSTITUTECODE");%>
			<tr>
			<td>
			<input type="checkbox" id="chk<%=i%>" name="chk<%=i%>" onclick="booking()" 
			value="<%=rs.getString("INSTITUTECODE")%>">
			</td>
	
			<td>
			<%=rs.getString("INSTITUTECODE")%>
			</td>
			</tr>
			<%
			}
			
			%>
			<input type="hidden" value="<%=i%>" id="count" name="count">
			</table>
			</td>

			<td width="50%">
			<table cellspacing=1  cellpadding=1  style="FONT-FAMILY: Arial;FONT-SIZE: x-small" borderColor="black" borderColorDark="white" width="50%">
			<br>Taged Institutes:
			<%for(j=1;j<=i;j++){%>
			<tr>
			<td><%=j%>-</td>
			<td>
			<input type="text" value="" id="tagedinstitute<%=j%>" name="tagedinstitute<%=j%>"  style="width:100px;">
			</td>
			</tr><%
		tagedinstitute=request.getParameter("tagedinstitute"+j)==null?"":request.getParameter("tagedinstitute"+j);
			}%>
			</table>
			</td>
			</tr>
		</table>
</td>

<td>
		<input type="hidden" name="c" id="c" value="" >
		<table cellspacing="1"  cellpadding="1" border="1" style="FONT-FAMILY: Arial;FONT-SIZE: x-small" borderColor="black" borderColorDark="white" width="50%">
		
		<h5>Booking Priorty</h5>
		<tr>
		<td width="40%">
		<table cellspacing=1  cellpadding=1  style="FONT-FAMILY: Arial;FONT-SIZE: x-small" borderColor="black" borderColorDark="white" >
		<br>For Priorty:
		<%for(p=1;p<=i;p++){%>
		<tr>
		<td>
		<input type="checkbox" id="check<%=p%>" name="check<%=p%>" onclick="priorty()" 
		value="">
		</td>
		<td><%=p%>-</td>
		
		<td>
		<input type="text" value="" id="forbook<%=p%>" name="forbook<%=p%>"  style="width:70px;">
		</td>
		</tr><%}%>
		</table>
		</td>
		<td width="20%">
		<table cellspacing="1"  cellpadding="1"  style="FONT-FAMILY: Arial;FONT-SIZE: x-small" borderColor="black" borderColorDark="white" >
		<tr>
		<td valign="center" align="center">
		<input type="button" name="btn" id="btn" value=">" style="width:25px" onclick="move()"/><br>	
		<input type="button" name="btn1" id="btn1" value="<" style="width:25px"/>
		</td>
		</tr>
		</table>
		</td>
		<td width="40%">
		<table cellspacing=1  cellpadding=1  style="FONT-FAMILY: Arial;FONT-SIZE: x-small" borderColor="black" borderColorDark="white" >
		<br> Priorty-wise:
		<%for(s=1;s<=i;s++){%>
		<tr>
		<td>
		<input type="checkbox" id="checki<%=s%>" name="checki<%=s%>"  value="">
		</td>
		<td><%=s%>-</td>
		<td>
		<input type="text" value="" id="priorty<%=s%>" name="priorty<%=s%>"  style="width:70px;">
		</td>
		</tr><%
			bookedistitute=request.getParameter("priorty"+s)==null?"":request.getParameter("priorty"+s);
		}%>
		</table>
		</td>
		</tr>
		</table>
		
		
		<input type="hidden" name="v" id="v" value="" >
		<input type="hidden" name="z" id="z" value="" >
 </td>
<td width="40%">
		<input type="hidden" name="c" id="c" value="" >
		<table cellspacing="1"  cellpadding="1" border="1" style="FONT-FAMILY: Arial;FONT-SIZE: x-small" borderColor="black" borderColorDark="white" width="50%">
		
		<h5>Time wise priorty</h5>
		<tr>
		<td width="40%">
		<table cellspacing=1  cellpadding=1  style="FONT-FAMILY: Arial;FONT-SIZE: x-small" borderColor="black" borderColorDark="white" >
		<br> Enter Time:
		<%for(s=1;s<=i;s++){%>
		<tr>
		<td><%=s%>-</td>
		<td>
		<input type="text" value="" id="timepriorty<%=s%>" name="timepriorty<%=s%>" style="width:70px;">
		</td>
		<td>
		&nbsp;From&nbsp;<input id='time<%=s%>' name='time<%=s%>'	style="width:50px;" type='text' readonly value="" size=8 maxlength=8	ONBLUR="validateDatePicker(this)" >&nbsp;<IMG SRC="../../Images/timepicker.gif" BORDER="0" ALT="Pick a Time!" ONCLICK="return selectTime(this,time<%=s%>)" STYLE="cursor:hand" >
		</td>
		<td>
		&nbsp;To&nbsp;<input id='tim<%=s%>' name='tim<%=s%>'	style="width:50px;" type='text' readonly value="" size=8 maxlength=8	ONBLUR="validateDatePicker(this)" >&nbsp;<IMG SRC="../../Images/timepicker.gif" BORDER="0" ALT="Pick a Time!" ONCLICK="return selectTime(this,tim<%=s%>)" STYLE="cursor:hand" >
		</td>
		</tr><%
		time1=request.getParameter("time"+s)==null?"":request.getParameter("time"+s);
		time2=request.getParameter("tim"+s)==null?"":request.getParameter("tim"+s);
		
		
		}%>
		</table>
		</td>
		</table><input type="hidden" name="v" id="v" value="" >
		<input type="hidden" name="z" id="z" value="" >
	 </td>
	 </tr>
	 
 </td>
 </tr>
 </table>
 </td>
 </tr>
 </table>
</td>
</tr>
</table>
<br><br>
<table>
<tr>
<td align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="submit" value="Submit" id="submit" name="submit" style="width:50px;">
<input type="reset" value="Reset" id="reset" name="reset" style="width:50px;">
</td>
</tr>
</table>
	
<%qry="select'LT'||(nvl(max(Substr(resourceid,3)),0)+1) resourceid,'R'||lpad(nvl(max(Substr(RESOURCETYPEID,-11)),0)+1,11,0) resourcetypeID from rs#resourcemaster";
rs=db.getRowset(qry);
while(rs.next()){
		resourcetypeId=rs.getString("RESOURCETYPEID");
		resourceId=rs.getString("RESOURCEID");

qry1="INSERT INTO RS#RESOURCEFORINSTITUTE (RESOURCETYPEID,RESOURCEID,INSTITUTECODE,DEACTIVE)VALUES ('"+resourcetypeId+"','"+resourceId+"','"+tagedinstitute+"','"+active+"')";
	n=db.insertRow(qry1);

qry2="INSERT INTO RS#BOOKINGPRIORITY (RESOURCETYPEID,RESOURCEID,INSTITUTECODE,PRIORITYORDER)VALUES ('"+resourcetypeId+"','"+resourceId+"','"+bookedistitute+"','"+s+"')";
	n1=db.insertRow(qry2);

qry3="INSERT INTO RS#BOOKINGTIMEPRIORITY(RESOURCETYPEID,RESOURCEID,INSTITUTECODE,PRIORITYORDER,TIMESLOTFROM,TIMESLOTTO)VALUES ('"+resourcetypeId+"','"+resourceId+"','"+bookedistitute+"','"+s+"','"+time1+"','"+time2+"')";
	n2=db.insertRow(qry3);
	
qry4="INSERT INTO RS#RESOURCEMASTER (RESOURCETYPEID,RESOURCEID,RESOURCECATEGORY,RESOURCECODE,RESOURCEDESC,RESOURCEDETAILS,ADVANCEBOOKINGDAYS,DEACTIVE)"
+"VALUES('"+resourcetypeId+"','"+resourceId+"','"+rcat+"','"+rescode+"','"+rname+"','"+rname+"','"+abdays+"','"+active+"')";	
	n3=db.insertRow(qry4);
	if(n>0&&n1>0&&n2>0&&n3>0)
	{
	out.print("Record Save Successfully........");
	}

	}}}}
catch(Exception e)
{
}
%>
</html>
		
	
	
	
