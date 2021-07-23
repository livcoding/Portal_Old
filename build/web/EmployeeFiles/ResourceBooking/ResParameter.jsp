<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mSCellNo="", mPCellNo="", mSTelNo="", mPTelNo="", mSEmail="",mPEmail="";
String mInst="",mWebEmail="";
String mMem="";
String mMemID="";
String qry="",mDID="",qury="",qry2="",qry3="";
String mSemail="",mDMemC="",mInstC="",mMemberID="",mMemberType="";
String academicyear="",active="",starttime="",queall="",endtime="",beytime="",hbook="",ttint="",vbook="";
String mint="",sdays="";
int n=0,bbhour=0,abhour=0,tslot=0 ,l=0;
String x="",Date1="",ParmemberID ="",selectY="",selectN="",y="a";
String mINSTITUTECODE =" ";
ResultSet rs=null,rsi=null,rs1=null,rs2=null,rs3=null;
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
String days="",MatchArray="",result="",v1="",v2="",v3="",v4="",v5="",v6="",v7="",v8="",v9="",v10="",v11="",v12="";
//----------------------

String stime="",etime="",btslot="",hbooking="",timetable="",vbooking="",mail="",queuing="",selecteddays="",deactive="";
int ts=0,before=0,after=0;
%>				
<html>
 <head>
    <title>Resouce Booking</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

	<script type="text/javascript" src="js/TimePicker.js"/>
		<script>
		function calculate (form)
{
	var date1 = new Date(form.starttime.value);
	var date2 = new Date(form.endtime.value);
	var sec = endtime.getTime() - starttime.getTime();
	if (isNaN(sec))
	{
		alert("Input data is incorrect!");
		return;
	}
	if (sec < 0)
	{
		alert("The second date ocurred earlier than the first one!");
		return;
	}
 
	var second = 1000, minute = 60 * second, hour = 60 * minute, day = 24 * hour;
 
	form.result_h.value = trunc(sec / hour);
	form.result_m.value = trunc(sec / minute);
	form.result_s.value = trunc(sec / second);
 
	var days = Math.floor(sec / day);
	sec -= days * day;
	var hours = Math.floor(sec / hour);
	sec -= hours * hour;
	var minutes = Math.floor(sec / minute);
	sec -= minutes * minute;
	var seconds = Math.floor(sec / second);
	form.result.value =minutes + " minute" + (minutes != 1 ? "s" : "") ;
}


</script>


	
<script type="text/javascript">
	
	 function timecheck()
	{
		var t= Math.abs(document.getElementById("bbhour").value);
		document.getElementById("bbhour").value=t;
		var t1=Math.abs(document.getElementById("abhour").value);
		document.getElementById("abhour").value=t1;
	}
	function previousyear()
	{
		var v1=document.frm[0].academicyear;
		var v2=document.getElementById("academicyear").value;
		var vmatch=document.getElementById("mField").value;
		 if(v2==""){
		alert("Enter Financial Year");
		return false;
		}
		else{

		var v=vmatch.split("~");
		var l=v.length;
		var i=0,j=0;
		for(i=l-1;i>=0;i--)
		{
			var t=v[i];
			if (v2==t)
			{
				break;
			}
		}
		if(i>0&&i<l)
		{
			document.frm.academicyear.value=v[i-1];
		}
	} 
	}


	function nextyear()
	{
		var v1=document.frm[0].academicyear;
		var v2=document.getElementById("academicyear").value;
		var vmatch=document.getElementById("mField").value;
          if(v2==""){
		alert("Enter Financial Year");
		return false;
		}
		else{

		var v=vmatch.split("~");
		var l=v.length;
		var i=0, j=0;
		for(i=0;i<=l-1;i++)
		{
			var t=v[i];
			if (v2==t)
			{
				break;
			}
		}
		if(i>=0&&i<(l-1))		
		{
			document.frm.academicyear.value=v[i+1];
		}
	//var vAC=document.getElementById("academicyear").value;
//document.getElementById("Vacadem").value=vAC;
//alert(vAC);

		}
	} 	




	function checkBx()
	{		
		var v1="",v2="",v3="",v4="",v5="",v6="",v7="",result="";
		if(document.frm.day0.checked==true)
		{
			v1=document.frm.day0.value;
		}
		if(document.frm.day1.checked==true)
		{
			v2=document.frm.day1.value;
		}
		if(document.frm.day2.checked==true)
		{
			v3=document.frm.day2.value;
		}
		if(document.frm.day3.checked==true)
		{
			v4=document.frm.day3.value;
		}
		if(document.frm.day4.checked==true)
		{
			v5=document.frm.day4.value;
		}
		if(document.frm.day5.checked==true)
		{
			v6=document.frm.day5.value;
		}
		if(document.frm.day6.checked==true)
		{
			v7=document.frm.day6.value;
		}
		result=" "+v1+" "+v2+" "+v3+" "+v4+" "+v5+" "+v6+" "+v7;
		document.getElementById("sdays").value=result;
		var result1=result.split(" ");
	    //alert(result1);
	}
	 
	  function validData()
   {
    var msg="";
    var c=0;
	 if(document.getElementById("academicyear").value=="")
	 {
		 msg=msg+"Please Fill academic year \n";
         c=1;
	   document.getElementById("academicyear").focus();
     }

	   if(document.getElementById("tslot").value==0)
		 {
		   msg=msg+"Please Fill	Time Slot\n";
         c=1;
		 document.getElementById("tslot").focus();
	    }
		 if(document.getElementById("starttime").value=="")
	 {
		 msg=msg+"Please Fill Start Time \n";
         c=1;
	   document.getElementById("starttime").focus();
     }

	   if(document.getElementById("endtime").value=="")
		 {
		   msg=msg+"Please Fill	End Time\n";
         c=1;
		 document.getElementById("endtime").focus();
	    }

		if(c>0)
{
alert(msg);
return false;
 }

	}</script>
<script>
//function fyearchk()
//{
//var vAC=document.getElementById("academ").value;
//alert(vAC);

//}
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
		qry="Select WEBKIOSK.ShowLink('275','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from	dual";

		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{ %>
		<form name="frm"  method="get" >
		<input id="x" name="x" type=hidden>
		<table cellspacing=0  cellpadding=1 frame =box align="center" border=1 style="FONT-FAMILY: Arial; 
		  FONT-SIZE: x-small" borderColor=black borderColorDark=white width=100%>
		<tr align="middle" bgcolor="#ff8c00">
		<td colspan="4">
		<%	
		qry="select ACADEMICYEAR from RS#RESOURCEPARAMETER order by 1";
		rs=db.getRowset(qry);
		rs1=db.getRowset(qry);
		while (rs1.next())
		{
		MatchArray=rs1.getString(1);
		if (result.equals(""))
		{
			result = MatchArray;
		}
		else
		{
			result+="~"+MatchArray;
		}
		}
%>
		<input type="hidden" id="mField"  name="mField" value="<%=result%>">
		<%if(rs.next())
		{ 
			academicyear=rs.getString("ACADEMICYEAR").toString().trim();
		} 
		
		
		String academyear=request.getParameter("academicyear")==null?"":request.getParameter("academicyear");
		%>
		Academic Year &nbsp;
		<input type="submit"  value="<" style="width:25px;" onClick="return previousyear();<%y="b";%>">
        <input type="text" Name="academicyear" id="academicyear" value="<%=academyear%>" style="width:50px;" title="Enter Financial Year">
		<input type="submit" value=">" style="width:25px;" onClick="return nextyear();<% y="b";%>">
		<!-- <input type="text" id="Vacadem" name="Vacadem"> -->
		
		<!-- <INPUT TYPE="Button" name=submit onClick="<%//y=1;%>" value="view"> -->
		</td>
		
		
		<%	
		if(y.equals("b")){
		
		academyear=request.getParameter("academicyear")==null?"Enter Year":request.getParameter("academicyear");
		
		qry3="SELECT TIMESLOTBREAKUP,to_char(DEFAULTSTARTTIME,'HH12:MI AM') DEFAULTSTARTTIME, to_char(DEFAULTENDTIME,'HH12:MI PM') DEFAULTENDTIME, BEYONDTIMESLOTBOOKING, TIMETABLEINTEGRATION, MAILINTEGRATED, BOOKINGBEFOREHOURS, BOOKINGAFTERHOURS, QUEUINGALLOWED, ' '||VALIDBOOKINGDAYS VALIDBOOKINGDAYS, HOLIDAYBOOKING,VACATIONBOOKING, DEACTIVE FROM RS#RESOURCEPARAMETER where academicyear='"+academyear+"'";
		rs3=db.getRowset(qry3);
		//out.print(qry3);
		if(rs3.next())
		{
		ts=rs3.getInt("TIMESLOTBREAKUP")==0?0:rs3.getInt("TIMESLOTBREAKUP");
		stime=rs3.getString("DEFAULTSTARTTIME")==null?"":rs3.getString("DEFAULTSTARTTIME");
		etime=rs3.getString("DEFAULTENDTIME")==null?"":rs3.getString("DEFAULTENDTIME");
		btslot=rs3.getString("BEYONDTIMESLOTBOOKING");//=="Y"?"Y":"N";
		hbooking=rs3.getString("HOLIDAYBOOKING");
		timetable=rs3.getString("TIMETABLEINTEGRATION");	
		vbooking=rs3.getString("VACATIONBOOKING");
		mail=rs3.getString("MAILINTEGRATED");
		queuing=rs3.getString("QUEUINGALLOWED");
		before=rs3.getInt("BOOKINGBEFOREHOURS")==0?0:rs3.getInt("BOOKINGBEFOREHOURS");
		after=rs3.getInt("BOOKINGAFTERHOURS")==0?0:rs3.getInt("BOOKINGAFTERHOURS");
		selecteddays=rs3.getString("VALIDBOOKINGDAYS")==null?"":rs3.getString("VALIDBOOKINGDAYS");
        deactive=rs3.getString("DEACTIVE");

			
				tslot=ts;
				starttime=stime;
				endtime=etime;
				beytime=btslot;
				hbook=hbooking;
				ttint=timetable;
				vbook=vbooking;
				mint=mail;
				queall=queuing;
				bbhour=before;
				abhour=after;
				//selecteddays =selecteddays.substring(25,24); 
				sdays= selecteddays;
				active=deactive;
			//	out.print(sdays);
			}}
			else
			{
				tslot=0;
				starttime="";
				endtime="";
				beytime="";
				hbook="";
				ttint="";
				vbook="";
				mint="";
				queall="";
				bbhour=0;
				abhour=0;
				sdays="";
				active="";
			
			}
		y.equals("a");
		
	%>
		<td colspan="4">
		
		<%
		if(y.equals("b"))
			{
			if(active.equals("Y")){
			active="Y";%>
<input type="checkbox" id="active" name="active" checked  value="<%=active%>">DeActive
		<%	}
			else{
			active="N";%>
          <input type="checkbox" id="active" name="active"  value="<%=active%>">DeActive  
		<%}
			}else{%>
<input type="checkbox" id="active" name="active"  value="Y">DeActive
			<%}%>
		
		</td>
  </tr>
  <tr>
		<td><FONT color=black face=Arial size=2>&nbsp;Time Slot Break Up(in minutes)</FONT></td>
		<td><input type="button" value="-"style="width:25px;" >
		<input type="text" id="tslot" name="tslot"  value="<%=tslot%>" onkeyup="calculate(this.form)" style="width:75px;"> 

		<input type="button" value="+" style="width:25px;"></td>
		<td  colspan=4><FONT color=black face=Arial size=2>&nbsp;Start Time</FONT>
		<input id='starttime' name='starttime'  type='text' readonly value="<%=starttime%>" size=8 maxlength=8 ONBLUR="validateDatePicker(this)" >&nbsp;<IMG SRC="../../Images/timepicker.gif" BORDER="0" ALT="Pick a Time!" ONCLICK="return selectTime(this,starttime)" STYLE="cursor:hand" >

		<FONT color=black face=Arial size=2>&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;End Time</FONT>
		<input id='endtime' name='endtime' type='text' readonly value='<%=endtime%>' size=8 maxlength=8 ONBLUR="validateDatePicker(this)">&nbsp;
		<IMG SRC="../../Images/timepicker.gif" BORDER="0" ALT="Pick a Time!"  ONCLICK="selectTime(this,endtime)" STYLE="cursor:hand" >

  </tr>
  <tr>
		<td width="30%"><FONT color="black" face="Arial" size="2">&nbsp;Beyond Time Slot Booking</td>
		<td width="20%">

 

		<select class="input-small"   id="beytime" name="beytime">
		<%
		if(y.equals("b"))
			{
			if(btslot.equals("Y")){%>
		<option value="Y" selected>YES</option>
		<option value="N">NO</option>
		<%}else{%>
		<option value="Y" >YES</option>
         <option value="N" selected>NO</option>
		<%}}
			else{%>
               <option value="Y">YES</option>
                <option value="N">NO</option>
		<%}%> 
		</select>
		</td>
		<td colspan="2" width="30%"><FONT color=black face=Arial size=2>&nbsp; Holiday Booking</td>
		<td colspan="2" width="20%">
		<select class="input-small"  id="hbook" name="hbook">
                <%
		if(y.equals("b"))
			{
			if(hbook.equals("Y")){%>
		<option value="Y" selected>YES</option>
		<option value="N">NO</option>
		<%}else{%>
		<option value="Y" >YES</option>
         <option value="N" selected>NO</option>
		<%}}
			else{%>
               <option value="Y">YES</option>
                <option value="N">NO</option>
<%}%>            </select>
	    </td>
  </tr>
  <tr>
	   <td><FONT color=black face=Arial size=2>&nbsp;Time Table Integration</td>
		<td>
		<select class="input-small" id="ttint" name="ttint">
               <%
		if(y.equals("b"))
			{
			if(ttint.equals("Y")){%>
		<option value="Y" selected>YES</option>
		<option value="N">NO</option>
		<%}else{%>
		<option value="Y" >YES</option>
         <option value="N" selected>NO</option>
		<%}}
			else{%>
               <option value="Y">YES</option>
                <option value="N">NO</option>
		<%}%>            
		</select>
		</td>
		<td colspan="2"><FONT color=black face=Arial size=2>&nbsp;Vocation Booking </td>
		<td colspan="2">
		<select class="input-small" name="vbook" id="vbook">
                <%
		if(y.equals("b"))
			{
			if(vbook.equals("Y")){%>
		<option value="Y" selected>YES</option>
		<option value="N">NO</option>
		<%}else{%>
		<option value="Y" >YES</option>
         <option value="N" selected>NO</option>
		<%}}
			else{%>
               <option value="Y">YES</option>
                <option value="N">NO</option>
<%}%>            </select>
		</td>
  </tr>
  <tr>
       <td><FONT color=black face=Arial size=2>&nbsp;Mail Integrated</td>
	   <td>
	   <select class="input-small" name="mint" id="mint" >
               <%
		if(y.equals("b"))
			{
			if(mint.equals("Y")){%>
		<option value="Y" selected>YES</option>
		<option value="N">NO</option>
		<%}else{%>
		<option value="Y" >YES</option>
         <option value="N" selected>NO</option>
		<%}}
			else{%>
               <option value="Y">YES</option>
                <option value="N">NO</option>
		<%}%>          
		</select>
	  </td>
	  <td  colspan="2"><FONT color=black face=Arial size=2>&nbsp;Queuing Allowed</td>
	  <td colspan="2">
	  <select class="input-small" name="queall"id="queall" >
                <%
		if(y.equals("b"))
			{
			if(queall.equals("Y")){%>
		<option value="Y" selected>YES</option>
		<option value="N">NO</option>
		<%}else{%>
		<option value="Y" >YES</option>
         <option value="N" selected>NO</option>
		<%}}
			else{%>
               <option value="Y">YES</option>
                <option value="N">NO</option>
		<%}%>        
		</select>
	 </td>
 </tr>
 <tr>
	  <td><FONT color=black face=Arial size=2>&nbsp;Booking Before Hour</td>
	  <td><input type="text" name="bbhour" id="bbhour" value="<%=bbhour%>" onchange="return timecheck()" style="width:75px;">
	  </td>
      <td colspan="2"><FONT color=black face=Arial size=2>&nbsp;Booking After Hours</td>
	  <td colspan="2"><input type="text" name="abhour" id="abhour" value="<%=abhour%>" onchange="return timecheck()"style="width:75px;">
	  </td>
 </tr>
 <tr>
		<td valign="top" >
		<FONT color=black face=Arial size=2>&nbsp;Valid Booking Days
		</td>
		<td colspan="2">
		<table border="0" borderColor="black">
            <tr>
                <td><%
				//out.print(sdays);
		if(y.equals("b"))
			{String s="MON";
			int t=sdays.indexOf(s);
			//out.print("mon$$="+t);
			boolean sday=(t>0); 
			if(sday==true){%>
			<input type="checkbox" name="day0" id="day0" onclick="return checkBx()" checked value="MON">
		<%	}
			else{%>
			<input type="checkbox" name="day0" id="day0" onclick="return checkBx()" value="MON">
		<%}
			}else{%>
			<input type="checkbox" name="day0" id="day0" onclick="return checkBx()" value="MON">
			<%}%></td>
            <td><FONT color=black face=Arial size=2>&nbsp;MON</td>
            </tr>
            <tr>
             <td><%
		if(y.equals("b"))
			{String s="TUE";
			int t=sdays.indexOf(s);
			boolean sday=(t>0);                        
			if(sday==true){%>
			<input type="checkbox" name="day1" id="day1" onclick="return checkBx()" checked value="TUE">
		<%	}
			else{%>
			<input type="checkbox" name="day1" id="day1" onclick="return checkBx()" value="TUE">
		<%}
			}else{%>
			<input type="checkbox" name="day1" id="day1" onclick="return checkBx()" value="TUE">
			<%}%></td>
            <td><FONT color=black face=Arial size=2>&nbsp;TUE</td>
            </tr>
            <tr>
			 <td><%
		if(y.equals("b"))
			{String s="WED";
			int t=sdays.indexOf(s);
			boolean sday=(t>0);                        
			if(sday==true){%>
			<input type="checkbox" name="day2" id="day2" onclick="return checkBx()" checked value="WED">
		<%	}
			else{%>
			<input type="checkbox" name="day2" id="day2" onclick="return checkBx()" value="WED">
		<%}
			}else{%>
			<input type="checkbox" name="day2" id="day2" onclick="return checkBx()" value="WED">
			<%}%></td>
            <td><FONT color=black face=Arial size=2>&nbsp;WED</td>
            </tr>
            <tr>
            <td><%
		if(y.equals("b"))
			{String s="THU";
			int t=sdays.indexOf(s);
			boolean sday=(t>0);                        
			if(sday==true){%>
			<input type="checkbox" name="day3" id="day3" onclick="return checkBx()" checked value="THU">
		<%	}
			else{%>
			<input type="checkbox" name="day3" id="day3" onclick="return checkBx()" value="THU">
		<%}
			}else{%>
			<input type="checkbox" name="day3" id="day3" onclick="return checkBx()" value="THU">
			<%}%></td>
            <td><FONT color=black face=Arial size=2>&nbsp;THU</td>
            </tr> 
            <tr>
            <td><%
		if(y.equals("b"))
			{String s="FRI";
			int t=sdays.indexOf(s);
			boolean sday=(t>0);                        
			if(sday==true){%>
			<input type="checkbox" name="day4" id="day4" onclick="return checkBx()" checked value="FRI">
		<%	}
			else{%>
			<input type="checkbox" name="day4" id="day4" onclick="return checkBx()" value="FRI">
		<%}
			}else{%>
			<input type="checkbox" name="day4" id="day4" onclick="return checkBx()" value="FRI">
			<%}%></td>
            <td><FONT color=black face=Arial size=2>&nbsp;FRI</td>
            </tr>
			<tr>
              <td><%
		if(y.equals("b"))
			{String s="SAT";
			int t=sdays.indexOf(s);
			boolean sday=(t>0);                        
			if(sday==true){%>
			<input type="checkbox" name="day5" id="day5" onclick="return checkBx()" checked value="SAT">
		<%	}
			else{%>
			<input type="checkbox" name="day5" id="day5" onclick="return checkBx()" value="SAT">
		<%}
			}else{%>
			<input type="checkbox" name="day5" id="day5" onclick="return checkBx()" value="SAT">
			<%}%></td>
            <td><FONT color=black face=Arial size=2>&nbsp;SAT</td>
            </tr>
			<tr>
             <td><%
		if(y.equals("b"))
			{String s="SUN";
			int t=sdays.indexOf(s);
			boolean sday=(t>0);                        
			if(sday==true){%>
			<input type="checkbox" name="day6" id="day6" onclick="return checkBx()" checked value="SUN">
		<%	}
			else{%>
			<input type="checkbox" name="day6" id="day6" onclick="return checkBx()" value="SUN">
		<%}
			}else{%>
			<input type="checkbox" name="day6" id="day6" onclick="return checkBx()" value="SUN">
			<%}%></td>
            <td><FONT color=black face=Arial size=2>&nbsp;SUN</td>
            </tr>
        </table>
		</td><%=sdays%>
		<td colspan="4" valign="top"><FONT color=black face=Arial size=2>&nbsp;Selected Days 
		<input type="text" readonly value="<%=sdays%>" name="sdays" id="sdays" onkeyUp="return days()" style="width:250px">
		</td>
		<tr align="center">
		    <td colspan="6">
		    <input type="submit" value="UPDATE" style="width:70px;" onclick="return validData()">
            <input type="Reset" value="CANCEL" style="width:70px;" ></tr>
		    </td>
	    </tr>
		</table>
	   </form>
	<%
	if(request.getParameter("academicyear")==null)
		academicyear="";
		else
		academicyear=request.getParameter("academicyear").toString().trim();	

	if(request.getParameter("active")!=null)
			active="Y";
		else
			active="N";
	
	if(request.getParameter("starttime")!=null)
		 starttime=request.getParameter("starttime").toString().trim();
         else	
		 starttime="";
		

		if(request.getParameter("endtime")!=null)
		endtime=request.getParameter("endtime").toString().trim();
		else
		endtime="";
		
		if(request.getParameter("beytime")!=null)
		 beytime=request.getParameter("beytime");
		else
		beytime="";
			
		if(request.getParameter("hbook")!=null)
		hbook=request.getParameter("hbook");
		else
		endtime="";
		  
		if(request.getParameter("ttint")!=null)
		ttint=request.getParameter("ttint");
		else
		ttint="";
		
		if(request.getParameter("vbook")!=null)
		vbook=request.getParameter("vbook");
		else
		vbook="";
		
		if(request.getParameter("mint")!=null)
		mint=request.getParameter("mint");
		else
		mint="";
		
		if(request.getParameter("queall")!=null)
		queall=request.getParameter("queall");
		else	
		queall="";
		
        if(request.getParameter("bbhour")!=null)
			bbhour=Integer.parseInt(request.getParameter("bbhour"));
		else
            bbhour=0;	
		 if(request.getParameter("tslot")!=null)
			tslot=Integer.parseInt(request.getParameter("tslot"));
		else
            tslot=0;	
	
		if(request.getParameter("abhour")!=null)
			abhour=Integer.parseInt(request.getParameter("abhour"));	
		else
		   abhour=0;
		
		int i=0;
		for(i=0;i<7;i++)
			{
		 //out.print(" :: "+request.getParameter("day"+i).toString().trim());
		if(request.getParameter("day"+i)!=null)
			days+=request.getParameter("day"+i).toString().trim()+" ";
			}
		if(request.getParameter("x")!=null)
		{
		qury="insert into RS#RESOURCEPARAMETER (ACADEMICYEAR,TIMESLOTBREAKUP,DEFAULTSTARTTIME, DEFAULTENDTIME, BEYONDTIMESLOTBOOKING, TIMETABLEINTEGRATION, MAILINTEGRATED, BOOKINGBEFOREHOURS, BOOKINGAFTERHOURS, VALIDBOOKINGDAYS, HOLIDAYBOOKING, VACATIONBOOKING,QUEUINGALLOWED, DEACTIVE) values('"+academicyear+"','"+tslot+"',to_date('"+starttime+"','HH:MI AM' ),to_date('"+endtime+"','HH:MI PM'),'"+beytime+"','"+ttint+"','"+mint+"','"+bbhour+"','"+abhour+"','"+days+"','"+hbook+"','"+vbook+"','"+queall+"','"+active+"')";
		out.print(qury);
		n=db.insertRow(qury);

		if(n>0){
		//-----------------
		//	    db.saveTransLog(mINSTITUTECODE,mChkMemID,mChkMType ,"EVENTWISEA TTENCANCE  BY RESPECTIVE FACULTY", "Attendance Date From: "+Date1 +"MemberID  : "+ParmemberID , "No MAC Address" , mIPAddress); //---------

		out.print("<font face='vardana' size='2' color='green' >Records Save Successfully >");
			}
			}
	
 //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
		}
		else
		{ %>
		<br>
		<font color=red>
		<h3>	<br><img src='../../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
		<P>	This page is not authorized/available for you.
		<br>For assistance, contact your network support team. <br><br><br>
		</font>
		 <%
			}
			//-----------------------------
		}
		else
		{
		%>
		<br>Session timeout! Please <a href="../index.jsp">Login</a> to continue...
		 <%
		} %><br><br><br><br><br><br>
		<center>
	
		</body>
		<%
		}
		catch(Exception e)
		{
			out.print ("<BR>ERROR.............");
		}
		%>
		</html>
