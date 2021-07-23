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
String mint="";
int n=0,bbhour=0,abhour=0,tslot=0,abdays=0,n1=0;
String x="",Date1="",ParmemberID ="",MatchArray="",result="",Message="";
String mINSTITUTECODE =" ",qry2="";
ResultSet rs=null,rsi=null,rss=null,rs1=null,rs2=null;
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
String days="",rcode="",rname="",rcat="",ret="",inst="",insti="",sinst="",dinfo="",rtype="",qry3="",recode="",resID="";
//----------------------
%>				
<html>
 <head>
    <title>Resouce Type</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<SCRIPT TYPE="text/javascript">
function Fdays(){
var t= Math.abs(document.getElementById("abdays").value);
document.getElementById("abdays").value=t;
}



function validData()
 {
var msg="";
var c=0;
	 if(document.getElementById("recode").value=="")
	 {
		msg=msg+"Please Fill Resource Code \n";
        c=1;
	    document.getElementById("recode").focus();
     }
     if(document.getElementById("rname").value=="")
	 {
		msg=msg+"Please Fill	Resource Name\n";
        c=1;
		document.getElementById("rname").focus();
	 }
		
	var snt=document.getElementById("sinst").value;
	if(snt=="")
	 {
	     msg=msg+"Please Fill select a institute\n";
         c=1;
		 document.getElementById("sinst").focus();
     }
     if(c>0)
     {
     alert(msg);
     return false;
     }  

 }

function upper() 
	{
    var field = document.frm[0].rname
    var upperCaseVersion = document.getElementById("rname").value.toUpperCase()
    document.getElementById("rname").value=upperCaseVersion;
	}
function upperMe() 
	{
		var field = document.frm[0].recode
		var upperCaseVersion = document.getElementById("recode").value.toUpperCase()
		document.getElementById("recode").value=upperCaseVersion;
		var vmatch=document.getElementById("mField").value;
		var v=vmatch.split("~");
		var l=v.length;
		for(var i=0;i<l-1;i++)
			{
				var t=v[i];
				if(upperCaseVersion==t)
				{
					alert(t+" Already Exist");
//document.getElementById("recode").value="";
				}
			}
	}



function checkall()
	{
		var p=0;/*
for (var i = 0; i < document.frm.elements.length; i++) 
	{
        var e=document.frm.elements[i]; 
	//	alert(e.type+"  "+e.name);
        if ((e.name == 'inst') && (e.type == 'radio')  && (e.value=='P') && (e.checked==true))
	    { 
			alert(e.name);
		
		
		p++;	
		//e.checked==true;
        }
    
      }*/
	 // alert(p);
		if(document.frm.inst.checked==true)
			{
			document.frm.inst0.checked=true;
			document.frm.inst1.checked=true;
			document.frm.inst2.checked=true;
			document.frm.sinst.value=document.frm.inst0.value+","+document.frm.inst1.value+","+document.frm.inst2.value;
			}
		else
			{
			document.frm.inst0.checked=false;
			document.frm.inst1.checked=false;
			document.frm.inst2.checked=false;
			document.frm.sinst.value=" ";
			}	
	}

function check()
	{	if((document.frm.inst0.checked==true)&&(document.frm.inst1.checked==true)&&(document.frm.inst2.checked==true))
	      {
          document.frm.inst.checked=true;
		  }
		  else
			  {
		  document.frm.inst.checked=false;
		      }
		  
if((document.frm.inst0.checked==true)&&(document.frm.inst1.checked==true)&&(document.frm.inst2.checked==true))
	{
document.frm.sinst.value=document.frm.inst0.value+","+document.frm.inst1.value+","+document.frm.inst2.value;
	}
else
if((document.frm.inst0.checked==true)&&(document.frm.inst1.checked==true))
	{
document.frm.sinst.value=document.frm.inst0.value+","+document.frm.inst1.value;
    }
else  if((document.frm.inst1.checked==true)&&(document.frm.inst2.checked==true))
	{
document.frm.sinst.value=document.frm.inst1.value+","+document.frm.inst2.value;
    }
else  if((document.frm.inst0.checked==true)&&(document.frm.inst2.checked==true))
	{
document.frm.sinst.value=document.frm.inst0.value+","+document.frm.inst2.value;
    }
else if(document.frm.inst0.checked==true)
	{
document.frm.sinst.value=document.frm.inst0.value;
    }
	else  if(document.frm.inst1.checked==true)
	{
document.frm.sinst.value=document.frm.inst1.value;
	}
else  if(document.frm.inst2.checked==true)
	{
document.frm.sinst.value=document.frm.inst2.value;
	}
else   if((document.frm.inst0.checked==false)&&(document.frm.inst1.checked==false)&&((document.frm.inst2.checked==false)))
	{
	document.frm.sinst.value="";
	
	}
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
   <input id="x" name="x" type=hidden>
   <br><table cellspacing=0  cellpadding=1  style="FONT-FAMILY: Arial; 
    FONT-SIZE: x-small" borderColor=black borderColorDark=white width=100%>
   <tr><td align="center">
	<font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><U>Resource Type</U>
	</td></tr></table>

	 <table cellspacing=0  cellpadding=1 frame =box align="center" border=1 style="FONT-FAMILY: Arial; 
    FONT-SIZE: x-small" borderColor=black borderColorDark=white width=100%>
   <br>
   <tr align="middle" bgcolor="#ff8c00">

  
		
		<td valign="top" width="60%" colspan="2" align="left"><FONT color=black face=Arial size=2>&nbsp;Resource Type Code
     <% 
{
qry="select upper(RESOURCETYPECODE)  RESOURCETYPECODE from RS#RESOURCETYPE";
rs=db.getRowset(qry);
rs1=db.getRowset(qry);
while (rs1.next())
	{
MatchArray=rs1.getString(1);
result=result+MatchArray+"~";
}
%>
<input type="hidden" id=mField  name=mField value="<%=result%>">
<select name="rcode" tabindex="" id="rcode"  style="width:160px;" >
<option value="N"><-Select RoomCode-></option>
<%
	if(request.getParameter("x")==null)
	{
	while(rs.next())
	{ %>
<option value="<%=rs.getString("RESOURCETYPECODE")%>"> <%=rs.getString("RESOURCETYPECODE")%></option>
<%}}
	else{while(rs.next())
	{
					rcode=rs.getString("RESOURCETYPECODE");

	if(rcode.equals(request.getParameter("rcode")))
			{%>
	<option  selected  value="<%=rs.getString("RESOURCETYPECODE")%>"><%=rs.getString("RESOURCETYPECODE")%></option>
<%
			}
			else
			{
%>
<option value="<%=rs.getString("RESOURCETYPECODE")%>"><%=rs.getString("RESOURCETYPECODE")%></option>
<%
			}
			}
	}		
	}
	%>
	</select><input type="button" value="view" style="width:50px;">
		</td>
		
		<td  align="center" width="30%" colspan="2">
		<input type="checkbox" id="active" name="active" value="<%=active%>">DeActive
		</td>
  
		<%if (request.getParameter("active")!=null)
			active="Y";
		else
			active="N";
		%></tr>
		<tr> <td align="left" width="30%"><FONT color=black face=Arial size=2>&nbsp; Resource Type Code
  <input type="text" value="<%=recode%>" name="recode" onKeyup="return upperMe()"  id="recode" style="width:75px;">
		
<%
			if(request.getParameter("recode")!=null)
		 recode=request.getParameter("recode").toString().trim();
         else	
		recode="";%></td>
		<td  valign="top" width="30%"><FONT color=black face=Arial size=2>&nbsp;Resource Type Name
		<input type="text" value="<%=rname%>" name="rname" onKeyup="return upper()" id="rname" style="width:100px">
		
<%
			if(request.getParameter("rname")!=null)
		 rname=request.getParameter("rname").toString().trim();
         else	
		 rname="";%></td>
<td  valign="top" width=""colspan="2" ><FONT color=black face=Arial size=2>&nbsp;Type Of Resource
     <% 
//{
//qry="select decode(RESOURCETYPE,'M','Movable','N','Nonmovable') RESOURCETYPE  from RS#RESOURCETYPE";
//rs=db.getRowset(qry);
%>
<select name="rtype" tabindex="" id="rtype" style="width:150px;" >
<option value=" "><-Select Res.Type-></option>
<option value="M">Movable</option>
<option value="N">Non-Movable</option>
</select>
<%if(request.getParameter("rtype")!=null)
		{rtype=request.getParameter("rtype");
		}
		else
		{rtype="";}%>


</tr><tr><td colspan="" valign="top" width="25%" ><FONT color=black face=Arial size=2>&nbsp;Returnable
	<select name="ret" tabindex="1" id="ret" style="width:160px;" >
<option ><-Select Returnable -></option>
<option value="Y">YES</option>
<option value="N">NO</option>
</select>
		<%if(request.getParameter("ret")!=null)
		{ret=request.getParameter("ret");
		}
		else
		{ret="";}%>
</td>
<td  valign="top" colspan="2" width="30%"><FONT color=black face=Arial size=2>&nbsp;Resource Category
		
		
<%// qry="select distinct RESOURCECATEGORY rescat,decode(RESOURCECATEGORY,'O','Other','R','Room') RESOURCECATEGORY from RS#RESOURCETYPE";
 
   //rs=db.getRowset(qry);
%>
<select name="rcat" tabindex="" id="rcat" style="width:150px;" >
<option value=" "><-Select Res.Type-></option>
<option value="R">Room</option>
<option value="O">Other</option>
</select>
<%if(request.getParameter("rcat")!=null)
		{rcat=request.getParameter("rcat");
		}
		else
		{rtype="";}%>


</td>
	<td colspan="1" valign="top" ><FONT color=black face=Arial size=2>&nbsp;Advance Booking Days
	<input type="text" value="<%=abdays%>" name="abdays" id="abdays" style="width:50px;" onchange="return Fdays()">
		
<%
		 if(request.getParameter("abdays")!=null)
			abdays=Integer.parseInt(request.getParameter("abdays"));
		else
            abdays=0;	
	%></td>
	<tr><td colspan="" ><FONT color=black face=Arial size=2>&nbsp;For Institute
	<input type="checkbox"  name="inst" id="inst" value="p" onclick="return checkall();" ><FONT color=black  size=1>Select Multiple Institutes
	
	<table border="0" borderColor="black">
            <tr align="left">
                <td><input type="checkbox" name="inst0" onclick="return check();" id="inst0" value="JIIT" >
                <FONT color=black face=Arial size=2>&nbsp;JIIT
                <input type="checkbox" name="inst1" onclick="return check();"id="inst1" value="JPBS" >
                <FONT color=black face=Arial size=2>&nbsp;JPBS
                <input type="checkbox" name="inst2"onclick="return check();" id="inst2" value="J128" >
                <FONT color=black face=Arial size=2>&nbsp;J128</td>
				</tr>
<td valign="top">
<FONT color=black face=Arial size=2>&nbsp;>>Selected Institutes
		<input type="text" value="" name="sinst" id="sinst" style="width:250px">
		</td></tr></table></td>
<td valign="top" colspan="4" align="left"><FONT color=black face=Arial size=2>&nbsp;Detailed Information
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<textarea align="center" rows="3" cols="60" id="dinfo" name="dinfo" value="<%=dinfo%>"></textarea></td>
	<%
			if(request.getParameter("dinfo")!=null)
		 dinfo=request.getParameter("dinfo").toString().trim();
         else	
		 dinfo="";%></td></tr>

	<tr align="center">
		    <td colspan="6">
		    <input type="submit" value="SAVE" style="width:70px;" onclick="return validData()" /> 
            <input type="Reset" value="CANCEL" style="width:70px;" ></tr>
		    </td>
	    </tr>
		</table>
	</form>
<%
if(request.getParameter("x")!=null) 	
		{

rcat=request.getParameter("rcat")==null?" ":request.getParameter("rcat");
rname=request.getParameter("rname")==null?" ":request.getParameter("rname");
//abdays=request.getParameter("abdays")==null?" ":request.getParameter("abdays");
ret=request.getParameter("ret")==null?" ":request.getParameter("ret");
active=request.getParameter("active")==null?"N":"Y";
rtype=request.getParameter("rtype")==null?" ":request.getParameter("rtype");
dinfo=request.getParameter("dinfo")==null?" ":request.getParameter("dinfo");



int dub=0;
qry3=" Select count(*) From RS#RESOURCETYPE R Where Upper(RESOURCETYPECODE)=upper('"+recode+"') ";
rss=db.getRowset(qry3);
while(rss.next())
dub=rss.getInt(1);
 
  if(dub>0)
	  {
	  Message="Already Exists";
	  }
	  else{
qry2="select 'R'||lpad(nvl(max(Substr(RESOURCETYPEID,-11)),0)+1,11,0) resourceID from RS#RESOURCETYPE ";
rs2=db.getRowset(qry2);
while(rs2.next())
resID=rs2.getString(1);

	qry="insert into RS#RESOURCETYPE (RESOURCETYPEID, RESOURCETYPECODE,RESOURCETYPENAME,RESOURCEDETAILS,ADVANCEBOOKINGDAYS, RESOURCETYPE,RESOURCECATEGORY,RETURNABLE,DEACTIVE)values(  '"+resID+"','"+recode+"','"+rname+"','"+dinfo+"','"+abdays+"','"+rtype+"','"+rcat+"','"+ret+"','"+active+"')";
n=db.insertRow(qry);
out.print(qry);

	int i=0;
    for(i=0;i<3;i++){
	if(request.getParameter("inst"+i)!=null)
		{
			inst=request.getParameter("inst"+i).toString().trim();
	qury="INSERT INTO RS#RESOURCETYPEFORINSTITUTE (RESOURCETYPEID, INSTITUTECODE)VALUES('"+resID+"','"+inst+"' )";
	out.print("\n"+qury);
n1+=db.insertRow(qury);
		}
}}}%>
<%
if(n>0 && n1>0){
//-----------------
	//	    db.saveTransLog(mINSTITUTECODE,mChkMemID,mChkMType ,"EVENTWISEA TTENCANCE  BY RESPECTIVE FACULTY", "Attendance Date From: "+Date1 +"MemberID  : "+ParmemberID , "No MAC Address" , mIPAddress); //---------

Message=" Records Save Successfully ";


}
%>
<font color="red"><%=Message%>			
<%
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
}%><br><br><br><br><br><br>
<center>

</body>
<%

}
catch(Exception e)
{
}
%>
</html>
