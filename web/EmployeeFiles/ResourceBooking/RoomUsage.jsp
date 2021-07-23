<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mSCellNo="", mPCellNo="", mSTelNo="", mPTelNo="", mSEmail="",mPEmail="";
String mInst="",mWebEmail="";
String mMem="";
String mMemID="";
String qry="",mDID="",qury="",qry2="",qry1="",qry3="";
String mSemail="",mDMemC="",mInstC="",mMemberID="",mMemberType="";
String academicyear="",active="",starttime="",queall="",endtime="",beytime="",hbook="",ttint="",vbook="";
String mint="";
int n=0,bbhour=0,abhour=0,tslot=0,abdays=0,n1=0,y=0;
String x="",Date1="",ParmemberID ="";
String mINSTITUTECODE =" ",rdes="",RoomID="",seqid="";
ResultSet rs=null,rsi=null,rss=null,rs1=null,rs2=null;
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
String days="",usage="",rcode="",rname="",rcat="",ret="",inst="",insti="",sinst="",dinfo="",rtype="",recode="",rocode="";int j=1;
//----------------------
%>				
<html>
 <head>
    <title>Room Usage</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<SCRIPT TYPE="text/javascript">

	function roomcode()
		{
		var v1=document.frm1.rocode.value;
		var v2 =v1.length;
	if(v2==0)
			{
			//document.getElementById("rocode").disabled = true;
			document.getElementById("rcode").disabled = false;
			}
		else
			{
      // alert(document.frm1.elements['HVROOMEDESC'].value);
	   //alert(VRC);
//HVROOMCODE,HVROOMEDESC,HVROOMFLAG

			document.getElementById("rcode").disabled = true;
			}
			}



		function showTable()
			{
		document.getElementById('table').style.visibility = "visible";
			}
		
		
		
		//function hideTable()
		//	{
		//document.getElementById('table').style.visibility = "hidden";
		//	}
		
		
		
		
		function upper()
			{
			var v2=document.frm1.rcode.value;
			if(v2!="")
				{
				document.getElementById("rocode").disabled = true;
				}
			else
				{
				document.getElementById("rocode").disabled = false;
				}
			var field=document.frm1[0].rcode
			var upperCaseVersion=document.getElementById("rcode").value.toUpperCase();
			document.getElementById("rcode").value=upperCaseVersion;
			var field=document.frm1[0].rdes
			var upperCaseVersion=document.getElementById("rdes").value.toUpperCase();
			document.getElementById("rdes").value=upperCaseVersion;
			}
		function validData()
		{
		var msg="";
		var c=0;
		if(document.getElementById("rcode").value=="")
		{
		 msg=msg+"Please Fill Room Code.\n";
         c=1;
	   document.getElementById("rcode").focus();
		 }

	   if(document.getElementById("rdes").value=="")
		 {
		   msg=msg+"Please Fill	Room Description.\n";
         c=1;
		 document.getElementById("rdes").focus();
	    }
		if(document.getElementById("Usage").value=="")
		 {
		 msg=msg+"Please select the Usage. \n";
         c=1;
	   document.getElementById("Usage").focus();
		 }
		if(c>0)
		{
		alert(msg);
		return false;
		}
		}
	 

 </script>
 </head>
	<!-- <body topmargin="10" rightmargin="0" leftmargin="10" bottommargin="0" bgcolor="#fce9c5" onload="javascript:hideTable()"> -->
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
	<form name="frm1"  method="get" >
   <input id="x" name="x" type=hidden> <input id="z" name="z" type=hidden>
   <br><table cellspacing=0  cellpadding=1  style="FONT-FAMILY: Arial; 
    FONT-SIZE: x-small" borderColor=black borderColorDark=white width=100%>
   <tr><td align="center">
	<font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><U>Room Usage</U>
	</td></tr></table>
	<table cellspacing=0  cellpadding=1 frame =box align="center" border=1 style="FONT-FAMILY: Arial; 
    FONT-SIZE: x-small" borderColor=black borderColorDark=white width=100%>
   <br>	
   <tr align="middle" bgcolor="#ff8c00">
 
		
		<td valign="center" colspan="5" align="center"><FONT color=black face=Arial size=2>&nbsp;Room Usage Code
     <% 
{
qry="select ROOMUSAGECODE from RS#RoomUsage";
rs=db.getRowset(qry);
%>
<select name="rocode" tabindex="" id="rocode" style="width:160px;" onChange="return roomcode();" >
<option value=""><-Select RoomCode-></option>
<%
	if(request.getParameter("x")==null)
	{
	while(rs.next())
	{ %>
<option value="<%=rs.getString("ROOMUSAGECODE")%>"> <%=rs.getString("ROOMUSAGECODE")%></option>
<%}}
	else{while(rs.next())
	{
					rocode=rs.getString("ROOMUSAGECODE");

	if(rocode.equals(request.getParameter("rocode")))
			{%>
	<option  selected  value="<%=rs.getString("ROOMUSAGECODE")%>"><%=rs.getString("ROOMUSAGECODE")%></option>
<%
			}
			else
			{
%>
<option value="<%=rs.getString("ROOMUSAGECODE")%>"><%=rs.getString("ROOMUSAGECODE")%></option>
<%
			}
			}
	}		
	}
	%>
	</select>
	<input type="submit" value="view" onclick="<%y=2;%>" style="width:45px;">
		</td>
	<%

		if(y==2){
	String VRoomCode=request.getParameter("rocode");
	String VRoomDesc="",VRoomCd="",VRoomFlag="";
	qry2=" SELECT ROOMUSAGECODE,ROOMUSAGEDESC,ROOMUSAGEFLAG,DEACTIVE FROM RS#ROOMUSAGE Where ROOMUSAGECODE='"+VRoomCode+"'  ";
	rs2=db.getRowset(qry2);
	if(rs2.next())
		{
	VRoomDesc=rs2.getString("ROOMUSAGEDESC")==null?"":rs2.getString("ROOMUSAGEDESC");
	VRoomCd=rs2.getString("ROOMUSAGECODE")==null?"":rs2.getString("ROOMUSAGECODE");
	VRoomFlag=rs2.getString("ROOMUSAGEFLAG")==null?"":rs2.getString("ROOMUSAGEFLAG");
		{
	rcode=VRoomCd;
	rdes=VRoomDesc;
   usage=VRoomFlag;
	} }
	
	}
	else{
	rcode="";
	rdes="";
	usage="";
	}
	y=0;
	%>
	
		<td  align="center" colspan="2">
		<input type="checkbox" id="active" name="active" value="<%=active%>">
		<FONT color=black face=Arial size=2>&nbsp;DeActive 
		
		</td>
  
		<%if (request.getParameter("active")!=null)
			active="Y";
		else
			active="N";
		%></tr>
	 	<tr>  <td align="left" width="60%" colspan="4"><FONT color=black face=Arial size=2>&nbsp; Room Usage Code/Description
  <input type="text" value="<%=rcode%>" name="rcode" id="rcode" onKeyUp="return upper();" style="width:75px;" >
  <input type="text" value="<%=rdes%>" name="rdes" id="rdes" onKeyUp="return upper();" style="width:160px;">
		
 <%
			if(request.getParameter("rcode")!=null)
		 rcode=request.getParameter("rcode").toString().trim();
         else	
		rcode="";
			if(request.getParameter("rdes")!=null)
		 rdes=request.getParameter("rdes").toString().trim();
         else	
		rdes="";%></td>
		<td  valign="top"  align="center" colspan="4" ><FONT color=black face=Arial size=2>&nbsp;Usage For
		<select name="Usage"  id="Usage" style="width:160px;" >
		<%//if(request.getParameter("Usage")!=null)
		//{usage=request.getParameter("Usage");
		//}
		//else
		//{usage="";}{
		%><option  ><--select Usage--></option>
        <%if(usage.equals("L")){%>
		<option selected value="L">Lecture</option>
		<%}else{%>
		<option  value="L">Lecture</option>
		<%}if((usage.equals("T"))){%>
		<option selected value="T">Tutorial</option>
		<%}else{%>
		<option  value="T">Tutorial</option>
		<%}if((usage.equals("P"))){%>
        <option selected value="P">Practical-Normal Room</option>
         <%}else{%>
		 <option value="P">Practical-Normal Room</option>
	     <%}if((usage.equals("PD"))){%>
		<option selected value="PD">Practical-Digtal Room</option>
		  <%}else{%>
		<option value="PD">Practical-Digtal Room</option>
        <%}if((usage.equals("M"))){%>
		<option selected value="M">Meeting Room</option>
		<%}else{%>
		<option value="M">Meeting Room</option>
        <%}if((usage.equals("C"))){%>
		<option selected value="C">Confereance </option>
        <%}else{%>
		<option value="C">Confereance </option>
		 <%}if((usage.equals("V"))){%>
		<option selected value="V">Movie Theature</option>
         <%}else{%>
		 <option value="V">Movie Theature</option>
		 <%}if((usage.equals("E"))){%>
		<option selected value="E">Exam Use</option>
		 <%}else{%>
		 <option value="E">Exam Use</option>
		<%}if((usage.equals("O"))){%>
		<option selected value="O">Other</option>
		<%}else{%>
		<option value="O">Other</option>
		</select>
		


		<%} //}
		%><input type="button" value="RESEQ" onClick="return showTable();" style="width:60px;" ></td>
		

	<tr><td align="center" colspan="8"><input type="submit" value="UPDATE" style="width:60px;" onclick="return validData(); <%y=1;%>">
            <input type="Reset" value="CANCEL" style="width:60px;">
		 </td>
		</tr> 
		</table></form>
		
<%
		if(y==1){
	
usage=request.getParameter("Usage");
int vCount=0;
			String RoomChk="";
			if(request.getParameter("x")!=null)
			{
		qry1=" select nvl(Count(*),0) From RS#ROOMUSAGE  where ROOMUSAGECODE='"+rcode+"' ";
		rs1=db.getRowset(qry1);
		if(rs1.next())
				{
			vCount=rs1.getInt(1);
				if(vCount>0){
					qry3=" select ROOMUSAGEID From RS#ROOMUSAGE  where ROOMUSAGECODE='"+rcode+"' ";
					rs2=db.getRowset(qry3);
					if(rs2.next()){
					RoomChk=rs2.getString(1);
					}

		qry2=" UPDATE RS#ROOMUSAGE SET  ROOMUSAGECODE = '"+rcode+"',ROOMUSAGEDESC = '"+rdes+"',DEACTIVE = '"+active+"' WHERE  ROOMUSAGEID   = '"+RoomChk+"'";
		
		n=db.update(qry2);
		out.print(qry2);	
		}

				else
					{
		qury="select 'USG'||lpad(nvl(max(Substr(RoomUsageid,-3)),0)+1,3,0) RoomID,nvl(max(SEQID),0)+1 seqid From RS#ROOMUSAGE ";
		//out.print(qury);
		rs1=db.getRowset(qury);
		if(rs1.next()){
			seqid=rs1.getString(2);
			RoomID=rs1.getString(1);
		}
	
		qry="INSERT INTO RS#ROOMUSAGE (RoomUsageid,ROOMUSAGECODE,SEQID, ROOMUSAGEDESC, ROOMUSAGEFLAG,DEACTIVE) VALUES ( '"+RoomID+"','"+rcode+"','"+seqid+"','"+rdes+"','"+usage+"' ,'"+active+"')" ;
	//out.print(qry);
		n=db.insertRow(qry);
				}
		if(n>0){
		out.print("<font face='vardana' size='2' color='green' >Records Save Successfully >");
		
		}else{
		//out.println("<font face='vardana' size='2' color='red' >error");
		}
		}}}
		}
}
		%>

		<input type=hidden id=show value='a'>
		<%if(request.getParameter("show")==null){%>
		<table cellspacing=0  cellpadding=0 frame ="box"  align="center"  style="FONT-FAMILY: Arial;visibility: hidden;
		FONT-SIZE: x-small" border="1" bordercolor="#fce9c5" bgcolor="#fce9c5" width="100" name="table" id="table"%>
  	
		 <tr align="middle" bgcolor="#ff8c00" >
		 <td align="center"  colspan="3" id="changeseq">
		 <font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><U>Change Seq.No.</U>
		 </td>
</tr>
<tr>
		<td width="40%" valign="top">
<table border="1"  width="100%" bordercolor="black" id="table1"> 
			<tr>
			<td align="center" colspan="2" id="existingseq">Existing Sequence
			</td>
			</tr>
			<%
			 
		 
		 
		 qry3="select SEQID,ROOMUSAGEDESC FROM RS#ROOMUSAGE";
			rs2=db.getRowset(qry3);
			while(rs2.next()){
				j++;
%>
			<tr>
			<td width="20%" id="seq"><input type="text" readonly value="<%=rs2.getString("SEQID")%>"				style="width:20Px;">
			</td>
			<td width="80%"><input type="text" readonly value="<%=rs2.getString("ROOMUSAGEDESC")%>">
			</td>
			</tr>
	 
			<%}%>

			<INPUT TYPE="text" NAME="count" value="<%=j%>">
</table>
   </td>
	 <td width="20%" align="center">
     <table bordercolor="black" border="0">
	 <tr>
		<td><input type="button" value=">" id=">"style="width:25px;">
		</td>
	</tr>
	<tr>
		<td><input type="button" value="<" id="<"style="width:25px;"></td>
    </tr>
	<tr>
		<td><input type="button" value=">>" id=">>"style="width:25px;"></td>
	</tr>
	<tr>
		<td><input type="button"value="<<"id="<<"style="width:25px;"></td>
	</tr>
</table></td>
   <td width="40%" valign="top">
<table border="1" bordercolor="black" width="100%" id="table2"> 
		<tr>
			<td align="center" colspan="2"id="newsequence">New Sequence
			</td>
		</tr><%for(int i=1;i<j;i++){%>
		<tr>
			<td width="20%"><input type="text" readonly value="<%=i%>" style="width:20Px;">
			</td>
			<td width="80%"><input type="text" readonly value=""></td>
	</tr><%}%>
</table>
</td></tr></table><%}%> </form>
 
<%}
catch(Exception e)
{
}
%>
</html>