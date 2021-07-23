<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.*" %>


<%



String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="";



%>

<HTML>
<head>
<TITLE>#### <%=mHead%> [ Exam Time Table Setup ] </TITLE>

<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<script type="text/javascript" src="js/TimePicker.js"></script>


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

<%
out.print("LLLLL");
%>
<SCRIPT  language="JavaScript">

function ChangeOptions(Exam,TimeTableCode,DataCombo,TimeTableCodeShow,SetupCode)
{   
    removeAllOptions(TimeTableCodeShow);	
	var QryEvent='';
   var flag=0;
	 
	 for(i=0;i<TimeTableCode.options.length;i++)
       {
		var v1;
		var pos;
		var ec;
		var ev;
		var len;
		var otext;
		var v1=TimeTableCode.options(i).value;
		len= v1.length ;	
		pos=v1.indexOf('***');
		ec=v1.substring(0,pos);
		ev=v1.substring(pos+3,len);
		if (ec==Exam)
		  { 	
			
				

				document.getElementById("EDIT2").disabled=false;

					document.getElementById("EDIT2").checked=true;

					document.frm.TimeTableCodeShow.disabled=false;

						document.frm.SetupCode.disabled=false;


			document.getElementById("EDIT1").checked=false;

				document.getElementById("EDIT1").disabled=true;

				document.frm.NTimeTableCodeShow.disabled=true;

				document.frm.NSetupCode.disabled=true;


			flag=1;
			
			var optn = document.createElement("OPTION");
			optn.text=TimeTableCode.options(i).text;
			optn.value=ev;
			if (QryEvent=='') QryEvent=ev;
			TimeTableCodeShow.options.add(optn);
		  }
		  else
		   {
				document.getElementById("EDIT1").checked=true;

				document.getElementById("EDIT2").disabled=true;

				document.frm.TimeTableCodeShow.disabled=true;

				document.frm.SetupCode.disabled=true;
		   }
	 }

	if(flag==0)
	{
		document.getElementById("EDIT2").disabled=true;
		document.getElementById("EDIT2").checked=false;
		document.frm.TimeTableCodeShow.disabled=true;
		document.frm.SetupCode.disabled=true;

	document.getElementById("EDIT1").checked=true;
	document.getElementById("EDIT1").disabled=false;
	document.frm.NTimeTableCodeShow.disabled=false;
	document.frm.NSetupCode.disabled=false;
	}
	

	/*else if(flag==1)
	{
		document.getElementById("EDIT2").disabled=false;

					document.getElementById("EDIT2").checked=true;

					document.frm.TimeTableCodeShow.disabled=false;

						document.frm.SetupCode.disabled=false;


			document.getElementById("EDIT1").checked=false;

				document.getElementById("EDIT1").disabled=true;

				document.frm.NTimeTableCodeShow.disabled=true;

				document.frm.NSetupCode.disabled=true;

	}*/
	

		removeAllOptions(SetupCode);	

		var optn1 = document.createElement("OPTION");
		//	optn1.text='';
		//	optn1.value='';
		//	SetupCode.options.add(optn1);
	    for(i=0;i<DataCombo.options.length;i++)
	      { 	
			var v1s;
			var pos1;
			var pos2;
			var exams;
			var evs;
			var lens;
			var sc;
			var otexts;
			var v1s=DataCombo.options(i).value;
			lens= v1s.length ;	

			pos1=v1s.indexOf('***');
			pos2=v1s.indexOf('///');

			exams=v1s.substring(0,pos1);
			evs=v1s.substring(pos1+3,pos2);
			sc=v1s.substring(pos2+3,lens);
			
//alert(exams+'=='+Exam +'&&'+ QryEvent+'=='+evs);
		if (exams==Exam && QryEvent==evs)
			{ 		 		
			var optns = document.createElement("OPTION");
			optns.text=DataCombo.options(i).text;
			optns.value=sc;
		//	alert(sc);
			SetupCode.options.add(optns);
			}	
		}
  	}
// ----------click event on EventSubevent------------



function ChangeOptions1(Exam,QryEvent,DataCombo,SetupCode)
{   
   removeAllOptions(SetupCode);	

			var optn = document.createElement("OPTION");
			//optn.text='';
			//optn.value='';
			//SetupCode.options.add(optn);

	for(i=0;i<DataCombo.options.length;i++)
       {   				
			var v1s1;
			var pos11;
			var pos21;
			var exams1;
			var evs1;
			var lens1;
			var sc1;
			var otexts1;
			var v1s1=DataCombo.options(i).value;
			lens1= v1s1.length ;	
			pos11=v1s1.indexOf('***');
			pos21=v1s1.indexOf('///');
			exams1=v1s1.substring(0,pos11);
			evs1=v1s1.substring(pos11+3,pos21);
			sc1=v1s1.substring(pos21+3,lens1);

//alert(exams1+'=='+Exam +'&&'+ QryEvent+'=='+evs1);			
			if (exams1==Exam && QryEvent==evs1)
			 { 	 
				var optns1 = document.createElement("OPTION");
				optns1.text=DataCombo.options(i).text;
				optns1.value=sc1;
				SetupCode.options.add(optns1);
			}
		 }
   }


function removeAllOptions(selectbox)
{
var i;
	for(i=selectbox.options.length-1;i>=0;i--)
	{
		selectbox.remove(i);
	}
}

</SCRIPT>	


<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>


<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >

<%


				


GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="",mDept="",mDesg="",mInst="",minst="",mDMemberID="";
String mExam="",mexam="",mExamid="",mTTCode="",mSetup="";
String qry="",qry1="",qry2="",qry3="",x="",qrymEventsubevent="";
int msno=0;
double mvalue=0,mMaxmarks=0,MyMax=0,mchkmarks=0;
String mmvalue="";
int ctr=0;
String mIC="",mEC="",mSC="",mList="",mOrder="",mFaculty=""; //,mExamsubevent="",mExamevent="";
ResultSet rsSub =null,rs=null,rss=null,rs1=null,rs2=null,rs3=null,rsfac=null,rse=null,rsm=null,rsi=null,rstable=null,rsTableData=null,rsTime=null;
String mMOP="",mName5="",mlistorder="";		
int kk=0;	
String msubeven="",mMarks="",mPerc="",mName1="",mMark="",mName2="",mName3="",mName4="",mName8="";
String mName6="",mName7="";		
String mTTCode1="",mSetup1="",qrymExamid="",examidm="";
String mType="",mEdit="";
int mRights=0;

String mDays="",mStartDate="",mStartTime="",mEndDate="",mEndTime="";
					int mSessDuration=0,mSessions=0;
	String NSetupCode="",NTTCodeShow="",Exam="";
int i=0,j=0,flag=0;
String SubQry="",mySub="";
				
if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}
				
if (session.getAttribute("Designation")==null)
{
	mDesg="";
}
else
{
	mDesg=session.getAttribute("Designation").toString().trim();
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

if (session.getAttribute("DepartmentCode")==null)
{
	mDept="";
}
else
{
	mDept=session.getAttribute("DepartmentCode").toString().trim();
}

	

OLTEncryption enc=new OLTEncryption();
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
	{
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);
		mDMemberID=enc.decode(mMemberID);
		
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk1=null;

  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------

	   mRights=136; 	
	

	qry="Select WEBKIOSK.ShowLink('"+mRights+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
    RsChk1= db.getRowset(qry);
//	out.println(qry);
	if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
	{
  //----------------------

/*
String mNewTTCode="",mNewSSCode="";

qry="select distinct MAX(timetablecode)TT,MAX(SETUPCODE)SS from TTS#TimeTable A where a.institutecode='"+mInst+"' order by examcode   ";
rs=db.getRowset(qry);
if(rs.next())
		{
	mNewTTCode=rs.getString("TT");
	mNewSSCode=rs.getString("SS");
		}*/
//out.print(mNewTTCode+1);




%>	

	<table  ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: VERDANA"><b>Exam Time Table Setup </b></font></td></tr>
	</table>

<form name="frm" method=post>
<table cellpadding=1 cellspacing=0  align=center rules=groups border=3>
	<input id="x" name="x" type=hidden>
<tr><td nowrap colspan=2>


	<font color=Green face=arial size=2><STRONG>&nbsp;<%=mMemberName%> [<%=mDMemberCode%>]
	&nbsp;: &nbsp; &nbsp;<%=mDesg%>&nbsp; (<%=mDept%>)
	

	<!-- Institute *******************-->
	
<hr>
	</td>
</tr>

<tr>
	<td nowrap colspan=2>

<!--************************************* Exam ********************************-->

	<FONT color=black><FONT face=Arial size=2><STRONG>&nbsp;Exam Code : </STRONG></FONT></FONT>
<%  
	try
	{


	qry="select distinct EXAMCODE  from PR#HODLoadDistribution where ";
	qry=qry+"  nvl(deactive,'N')='N' and institutecode='"+mInst+"' order by examcode desc";  

	
	
		rs=db.getRowset(qry);
//		out.println("######### "+mType);
	//	out.print(qry);
		if (request.getParameter("x")==null)
		{
		%>
			<select name=Exam tabindex="0" id="Exam" style="WIDTH: 150px" onclick="ChangeOptions(Exam.value,TimeTableCode,DataCombo,TimeTableCodeShow,SetupCode);" onChange="ChangeOptions(Exam.value,TimeTableCode,DataCombo,TimeTableCodeShow,SetupCode);">	
				<option SELECTED value="N" > Select ExamCode </option>
		<%   
			while(rs.next())
			{
				mExamid=rs.getString("EXAMCODE");
				if(examidm.equals(""))
				{
				examidm=mExamid;
				qrymExamid=mExamid;
			%>

				<option   Value =<%=mExamid%>><%=mExamid%></option>
			<%	
				}
				else
				{
			%>
				<option  Value =<%=mExamid%>><%=mExamid%></option>
			<%	
				}		
			}
		%>
			</select>
		<%
		}
	else
	{
	%>	
		<select name=Exam tabindex="0" id="Exam" style="WIDTH: 150px" onclick="ChangeOptions(Exam.value,TimeTableCode,DataCombo,TimeTableCodeShow,SetupCode);" onChange="ChangeOptions(Exam.value,TimeTableCode,DataCombo,TimeTableCodeShow,SetupCode);">
<%
		if((request.getParameter("Exam").toString().trim()).equals("N"))
		 {
%>	
		<option value='N' selected >Select Exam Code</option>
<%	
		 }
	 else
		 {
	%>
			<option value='N'>Select Exam Code</option>
	<%
		 }
		while(rs.next())
			{
				mExamid=rs.getString("EXAMCODE");
				
				if(mExamid.equals(request.getParameter("Exam").toString().trim()))
 				{qrymExamid=mExamid;
				%>
					<option selected Value =<%=mExamid%>><%=mExamid%></option>

				<%			
			     }
			     else
		      	{
				%>
		      		<option Value =<%=mExamid%>><%=mExamid%></option>
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
	    //out.println("Before TimeTableCode 1"+e.getMessage());
	}


%>
</td>
</tr>

<%

	String mCheck="",mCheck1="",mDisable="",mDisable1="";

//out.print("KKKK"+request.getParameter("EDIT"));


if(request.getParameter("EDIT")==null)
		{
	mCheck="Checked";
	mDisable1="disabled";
		}
else if(request.getParameter("EDIT").equals("E"))
		{
	mCheck="Checked";
		mDisable1="disabled";
		}
else{
		mCheck1="Checked";
			mDisable="disabled";
		}

	%>
<tr>
<td nowrap><INPUT TYPE="radio" NAME="EDIT" id="EDIT2" <%=mCheck%>   VALUE="E" >
 <FONT face=Arial size=2><STRONG>Edit &nbsp;


	<select name="TimeTableCode" tabindex="0" id="TimeTableCode" <%=mDisable%> style="WIDTH: 0px">


<%

//********************FacltyID Combo(TimeTableCode)*************/
try
{
	


		qry="select distinct examcode,TIMETABLECODE, SETUPCODE from TTS#TimeTable A where 	 a.institutecode='"+mInst+"'	order by examcode";  
	
	

	rse=db.getRowset(qry);
 //	out.print(qry);
	if (request.getParameter("x")==null) 
	{
  
		while(rse.next())
			{
			mTTCode1 = rse.getString("examcode")+"***"+rse.getString("TIMETABLECODE");
			
		%>
			<option Value="<%=mTTCode1%>"> <%=rse.getString("TIMETABLECODE")%> </option> 
		<%			
			}
%>
  </select>
<%		
	}
	else
	{
		
		while(rse.next())
		{
		 mTTCode1=rse.getString("examcode")+"***"+rse.getString("TIMETABLECODE");
			if(mTTCode1.equals(request.getParameter("TimeTableCode").toString().trim()))
 			{
			%>
				<option selected Value = "<%=mTTCode1%>" > <%=rse.getString("TIMETABLECODE")%> </option>
			<%			
		     }
		      else
		      {
				%>
		      	<option Value ="<%=mTTCode1%>"> <%=rse.getString("TIMETABLECODE")%> </option>  
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
		//out.print("error after Faculty id 1 & Before 2" + e);
	}
	
	//********************FACULTY ID  Show ************/
%>
<!-- Space between exam code & Faculty id -->


<FONT color=black><FONT face=Arial size=2><STRONG>Time Table Code : </STRONG></FONT></FONT>


		<select name=TimeTableCodeShow tabindex="0" id="TimeTableCodeShow"  onclick="ChangeOptions1(Exam.value,TimeTableCodeShow.value,DataCombo,SetupCode);" onChange="ChangeOptions1(Exam.value,TimeTableCodeShow.value,DataCombo,SetupCode);" <%=mDisable%>>

<%    try{
	

	qry="select distinct examcode,TIMETABLECODE from TTS#TimeTable A where 	 a.institutecode='"+mInst+"'	order by examcode";  
	 
	
	rse=db.getRowset(qry);

 //	out.print(qry);

	if (request.getParameter("x")==null) 
	{
	  

		while(rse.next())
		{
			mTTCode=rse.getString("TIMETABLECODE");
			if(qrymEventsubevent.equals(""))	
			{		
				qrymEventsubevent=mTTCode;
			%>
			<OPTION selected Value = <%=mTTCode%>><%=rse.getString("TIMETABLECODE")%></option>
			<%	
			}
			
			else
			{
			%>
			<OPTION  Value = <%=mTTCode%>><%=rse.getString("TIMETABLECODE")%></option>
			<%	
			}	
		}
	%>
		</select>
 <%		
	}
	else
	{
	
		
		while(rse.next())
		{
			mTTCode=rse.getString("TIMETABLECODE");
			if(mTTCode.equals(request.getParameter("TimeTableCodeShow").toString().trim()))
 			{
				qrymEventsubevent=mTTCode;
			%>
			 <OPTION selected value= "<%=mTTCode%>"> <%=rse.getString("TIMETABLECODE")%> </option>
				<%			
		    }
		    else
		      {
				%>
				
		      	<OPTION Value= "<%=mTTCode%>" > <%=rse.getString("TIMETABLECODE")%> </option>
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
		//out.print("error After faculty id " + e);
	}	
%>
	</td>

	<td nowrap align=left>
<%
//******************DataCombo SetupCode********************/
try
	{

	
	qry="select distinct examcode,TIMETABLECODE, SETUPCODE from TTS#TimeTable A where 	 a.institutecode='"+mInst+"'	order by examcode";  
	
	
	rss=db.getRowset(qry);
 //	out.println(qry);
	if (request.getParameter("x")==null) 
	{
		%>
 
		<select name=DataCombo tabindex="0" id="DataCombo" style="WIDTH: 0px">	

		<%   
		while(rss.next())
		{
		mSetup1=rss.getString("examcode")+"***"+rss.getString("TIMETABLECODE")+"///"+rss.getString("SETUPCODE");
			if(mSetup.equals(""))
			{
 			mSetup=mSetup1;
			%>
			<OPTION Value =<%=mSetup1%>><%=rss.getString("SETUPCODE")%></option> 
			<%	
			}
			 else
			 {
			%>
			<OPTION Value =<%=mSetup1%>><%=rss.getString("SETUPCODE")%></option> 
			<%
			 }
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name=DataCombo tabindex="0" id="DataCombo" style="WIDTH: 0px">	
		<%
		while(rss.next())
		{
		mSetup1=rss.getString("examcode")+"***"+rss.getString("TIMETABLECODE")+"///"+rss.getString("SETUPCODE");

			if(mSetup1.equals(request.getParameter("DataCombo").toString().trim()))
 			{
				mSetup=mSetup1;
				%>
				 <OPTION selected Value ="<%=mSetup1%>"><%=rss.getString("SETUPCODE")%></option> 
				<%			
		     }
		     else
				 {
				%>
			     	<OPTION Value ="<%=mSetup1%>"><%=rss.getString("SETUPCODE")%></option> 
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
	//out.println(e.getMessage());
}
%>
<!--******************************SetupCode *************************************-->
<FONT color=black><FONT face=Arial size=2><STRONG>Setup Code : </STRONG></FONT></FONT>
<%
	try
	{
qry="select distinct  SETUPCODE from TTS#TimeTable A where 	 a.institutecode='"+mInst+"'	order by SETUPCODE";  
	
	%>
		<select name=SetupCode tabindex="0" id="SetupCode" <%=mDisable%> >
		
		<%   
	
//	out.print(qry);
	rss=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		
		while(rss.next())
		{
			mSetup=rss.getString("SETUPCODE");
			if(mSetup1.equals(""))
			{
 			mSetup1=mSetup;
			%>
			<OPTION Value="<%=mSetup%>"><%=rss.getString("SETUPCODE")%></option>
			<%
			}
			 else
				{
			%>
			<OPTION  Value="<%=mSetup%>"><%=rss.getString("SETUPCODE")%></option>
			<%
				}
		}
		%>
		</select>
		<%
	}
	else
	{
		
		while(rss.next())
		{
			mSetup=rss.getString("SETUPCODE");
			if(mSetup.equals(request.getParameter("SetupCode").toString().trim()))
 			{
				mSetup1=mSetup;
				%>
				<OPTION  selected Value ="<%=mSetup%>"><%=rss.getString("SETUPCODE")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value ="<%=mSetup%>"><%=rss.getString("SETUPCODE")%></option>
		      	<%			
		   	}
		}
		%>
		</select> <%
	 }
 }    
catch(Exception e)
{
	//out.println(e );
}
%>
	&nbsp;

	
	
	
	
	</td>
</tr>

<tr>
<td>
<INPUT TYPE="radio" NAME="EDIT" id="EDIT1" VALUE="N"  <%=mCheck1%>>
  <FONT face=Arial size=2><STRONG>New &nbsp;
 
<FONT face=Arial size=2><STRONG>Time Table Code :
<INPUT TYPE="text" NAME="NTimeTableCodeShow" size=12 maxlength=10 value="TT-"  <%=mDisable1%>>
</td>

<td>&nbsp;<FONT face=Arial size=2><STRONG>Setup Code : 
<INPUT TYPE="text" NAME="NSetupCode" size=14 value="SETUP-" maxlength=11 <%=mDisable1%>>
</td>

</tr>

<tr>
<td>
<INPUT Type="submit" Value="Show/Refresh">
</td>
</tr>
	</table>
	

	    </form>
	<%	
if(request.getParameter("x")!=null )
		{
mEdit=request.getParameter("EDIT").toString().trim();

out.print(mEdit+"LLL");
if(mEdit.equals("E"))
	{

if(request.getParameter("TimeTableCodeShow")==null)
		NTTCodeShow="";
	else
		NTTCodeShow=request.getParameter("TimeTableCodeShow");


	if(request.getParameter("SetupCode")==null)
		NSetupCode="";
	else
		NSetupCode=request.getParameter("SetupCode");

	}
	else
	{

	if(request.getParameter("NTimeTableCodeShow")==null)
		NTTCodeShow="";
	else
		NTTCodeShow=request.getParameter("NTimeTableCodeShow");


	if(request.getParameter("NSetupCode")==null)
		NSetupCode="";
	else
		NSetupCode=request.getParameter("NSetupCode");

	}

	if(request.getParameter("Exam")==null)
		Exam="";
	else
		Exam=request.getParameter("Exam");



	if( NTTCodeShow!=null && NSetupCode!=null && (!Exam.equals("N")) )
{






	%>
		<form name=frm1>
		<INPUT TYPE="hidden" NAME="y">
	<INPUT TYPE="hidden" NAME="x">

		<INPUT TYPE="hidden" NAME="Exam" value="<%=Exam%>">
		<INPUT TYPE="hidden" NAME="EDIT" value="<%=Exam%>">
		<INPUT TYPE="hidden" NAME="NSetupCode" value="<%=NSetupCode%>">
		<INPUT TYPE="hidden" NAME="NTimeTableCodeShow" value="<%=NTTCodeShow%>">

	<INPUT TYPE="hidden" NAME="SetupCode" value="<%=NSetupCode%>">
		<INPUT TYPE="hidden" NAME="TimeTableCodeShow" value="<%=NTTCodeShow%>">


	
		<p align=center>
		<font face=arial size=2><b>Time Table Code<b></font>: <%=NTTCodeShow%>
		&nbsp;
		<font face=arial size=2><b>Setup Code<b></font>: <%=NSetupCode%>
		</p>
		<table bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=columns topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center width="70%">
				<thead>
				<tr bgcolor="#ff8c00">
				<td><font color=white face=arial size=2><b>Check Box<b></font></td>
				<td colspan=2 align=center><font color=white face=arial size=2><b>Days<b></font></td>
				<td><font color=white face=arial size=2><b>Start Time<b></font></td>
				<td><font color=white face=arial size=2><b>End Time<b></font></td>
				<td><font color=white face=arial size=2><b>Sessions<b></font></td>
				<td><font color=white face=arial size=2><b>Session Duration<b></font></td>
				</tr>
				</thead>
				<tbody>
				<%

				qry="SELECT INSTITUTECODE, EXAMCODE, TIMETABLECODE,    SETUPCODE, DAYS, SORTON,    TOTSESSION, to_char(starttime,'dd-mm-yyyy')startdate,to_char(starttime,'hh:mi am')starttime,        to_char(endtime,'dd-mm-yyyy')enddate,to_char(endtime,'hh:mi am')endtime ,   SESSIONDURATION, ENTRYBY, ENTRYDATE FROM TTS#APPLICABLEDAYS WHERE INSTITUTECODE='"+mInst+"' AND  EXAMCODE='"+Exam+"'  AND  TIMETABLECODE='"+NTTCodeShow+"'  AND     SETUPCODE='"+NSetupCode+"' order by startdate ";
				//out.print(qry);
				rs1=db.getRowset(qry);
				rs=db.getRowset(qry);
				if(rs1.next())
				{
					
				while(rs.next())
					{
					i++;
					%>
						<tr >
				<td> <input type="checkbox" name="Check<%=i%>" id="Check<%=i%>" value="Y">     </td>
				<td colspan=2 align=center> 
				
			
				<input type="textbox" size=3 name="Days<%=i%>" id="Days<%=i%>"  value=<%=rs.getString("DAYS")%>>  
			
				<td nowrap> <input type="textbox" size=7 name="StartDate<%=i%>" READONLY id="StartDate<%=i%>" VALUE="<%=rs.getString("startdate")%>" > 
				
				 <input type="textbox" name="StartTime<%=i%>"  id="StartTime<%=i%>"  size=8 maxlength=8 ONBLUR="validateDatePicker(this)" VALUE="<%=rs.getString("starttime")%>">&nbsp;<IMG SRC="images/timepicker.gif" BORDER="0" ALT="Pick a Time!" ONCLICK="selectTime(this,StartTime<%=i%>)" STYLE="cursor:hand" >

				

				</td>

				<td nowrap><input type="textbox" size=7 name="EndDate<%=i%>" id="EndDate<%=i%>" READONLY VALUE="<%=rs.getString("enddate")%>" >

				<input type="textbox" size=7 name="EndTime<%=i%>" id="EndTime<%=i%>" size=8 maxlength=8 ONBLUR="validateDatePicker(this)" VALUE="<%=rs.getString("endtime")%>">&nbsp;<IMG SRC="images/timepicker.gif" BORDER="0" ALT="Pick a Time!" ONCLICK="selectTime(this,EndTime<%=i%>)" STYLE="cursor:hand" >
				</td>
							
				
				</td>
				<td> <input type="textbox" size=4 name="Sessions<%=i%>" maxlength= id="Sessions<%=i%>" VALUE="<%=rs.getString("TOTSESSION")%>" >   </td>
				

				<td><input type="textbox" size=4 name="SessDuration<%=i%>" id="SessDuration<%=i%>" VALUE="<%=rs.getString("SESSIONDURATION")%>">     </td>
				</tr>
						<%
					}		

				}
				else
				{

					for(i=0;i<7;i++)
						{
						//	ss
						%>
						<tr >
				<td> <input type="checkbox" name="Check<%=i%>" id="Check<%=i%>" value="Y">     </td>
				<td colspan=2 align=center> 
				
				<%
					qry="select to_Char(Sysdate+'"+i+"' ,'DY')DAY,to_Char(Sysdate+'"+i+"' ,'DD-MM-YYYY')DATE1 from dual";
					rs=db.getRowset(qry);
					if(rs.next())
							{
					%>
				<input type="textbox" size=3 name="Days<%=i%>" id="Days<%=i%>"  value=<%=rs.getString("DAY")%>>  
			
				<td nowrap> <input type="textbox" size=7 name="StartDate<%=i%>" READONLY id="StartDate<%=i%>" VALUE="<%=rs.getString("DATE1")%>" > 
				
				 <input type="textbox" name="StartTime<%=i%>"  id="StartTime<%=i%>"  size=8 maxlength=8 ONBLUR="validateDatePicker(this)">&nbsp;<IMG SRC="images/timepicker.gif" BORDER="0" ALT="Pick a Time!" ONCLICK="selectTime(this,StartTime<%=i%>)" STYLE="cursor:hand">

				

				</td>

				<td nowrap><input type="textbox" size=7 name="EndDate<%=i%>" id="EndDate<%=i%>" READONLY VALUE="<%=rs.getString("DATE1")%>" >

				<input type="textbox" size=7 name="EndTime<%=i%>" id="EndTime<%=i%>" size=8 maxlength=8 ONBLUR="validateDatePicker(this)">&nbsp;<IMG SRC="images/timepicker.gif" BORDER="0" ALT="Pick a Time!" ONCLICK="selectTime(this,EndTime<%=i%>)" STYLE="cursor:hand">
				</td>
								<%
							}
						%>
				
				</td>
				<td> <input type="textbox" size=4 name="Sessions<%=i%>" maxlength= id="Sessions<%=i%>" >   </td>
				

												<td><input type="textbox" size=4 name="SessDuration<%=i%>" id="SessDuration<%=i%>" >     </td>
				</tr>
						<%
						}
				}
				%>

				<tr>
				<td colspan=7 align=center>
					<INPUT TYPE="submit" name="Save" VAlue="Save">

				</td>
				</tr>
				</tbody>
				</table>

	

<%
			if(request.getParameter("y")!=null)
			{
				
		int cc=0;

				if(request.getParameter("NSetupCode")!=null && request.getParameter("NTimeTableCodeShow")!=null  )
				{
				NTTCodeShow=request.getParameter("NTimeTableCodeShow");
				NSetupCode=request.getParameter("NSetupCode");
				Exam=request.getParameter("Exam");
				
				
				qry="SELECT INSTITUTECODE, EXAMCODE   FROM TTS#TIMETABLE WHERE INSTITUTECODE='"+mInst+"' AND  EXAMCODE='"+Exam+"'";
				rs=db.getRowset(qry);
				if(!rs.next())
					{
				


qry1="INSERT INTO TTS#PARAMETERMASTER (   INSTITUTECODE, EXAMCODE, TIMETABLECODE, SETUPCODE, SETUPDESC,     ENTRYDATE, ENTRYBY   ) VALUES ( '"+mInst+"','"+Exam+"'  ,'"+NTTCodeShow+"' , '"+NSetupCode+"' ,'ALLSETUP'   ,      SYSDATE ,'"+mDMemberID+"' )";
out.println(qry1);
int h=db.insertRow(qry1);

				qry1="INSERT INTO TTS#TIMETABLE (   INSTITUTECODE, EXAMCODE, TIMETABLECODE, SETUPCODE, ENTRYBY, ENTRYDATE) VALUES ( '"+mInst+"' , '"+Exam+"','"+NTTCodeShow+"' , '"+NSetupCode+"','"+mDMemberID+"',sysdate )";
					cc=db.insertRow(qry1);
					}
					else
					{
				qry1="UPDATE TTS#TIMETABLE SET  TIMETABLECODE='"+NTTCodeShow+"' , SETUPCODE='"+NSetupCode+"'  WHERE  INSTITUTECODE   = '"+mInst+"'  AND    EXAMCODE        = '"+Exam+"' ";
				cc=db.update(qry1);

					}
				//out.print(qry1);	
					if(cc>0)
					{

						for(j=0;j<7;j++)
						{							
					


						if(request.getParameter("Days"+j)==null)
							mDays="";
						else
							mDays=request.getParameter("Days"+j);
									
						if(request.getParameter("StartDate"+j)==null)
							mStartDate="";
						else
							mStartDate=request.getParameter("StartDate"+j);

						
						if(request.getParameter("StartTime"+j)==null)
							mStartTime="";
						else
							mStartTime=request.getParameter("StartTime"+j);
									
											
							mStartDate=mStartDate+" "+mStartTime;

						if(request.getParameter("EndDate"+j)==null)
							mEndDate="";
						else
							mEndDate=request.getParameter("EndDate"+j);

						
						if(request.getParameter("EndTime"+j)==null)
							mEndTime="";
						else
							mEndTime=request.getParameter("EndTime"+j);

						mEndDate=mEndDate+" "+mEndTime;		
														

						if(request.getParameter("SessDuration"+j)==null)
							mSessDuration=0;
						else
							mSessDuration=Integer.parseInt(request.getParameter("SessDuration"+j));
							
						if(request.getParameter("Sessions"+j)==null)
							mSessions=0;
						else
							mSessions=Integer.parseInt(request.getParameter("Sessions"+j));

							int a=0;								


     


							qry="SELECT 'Y'  FROM TTS#APPLICABLEDAYS WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+Exam+"' AND TIMETABLECODE='"+NTTCodeShow+"' AND SETUPCODE='"+NSetupCode+"' and DAYS ='"+mDays+"' ";
								//out.print(qry);	

							rs=db.getRowset(qry);
							if(!rs.next())	
							{
								
								
								
								
								
								qry2="INSERT INTO TTS#APPLICABLEDAYS (   INSTITUTECODE, EXAMCODE, TIMETABLECODE,    SETUPCODE, DAYS, SORTON, 								TOTSESSION, STARTTIME, ENDTIME,    SESSIONDURATION, ENTRYBY, ENTRYDATE) 								VALUES ( '"+mInst+"','"+Exam+"'  ,'"+NTTCodeShow+"' , '"+NSetupCode+"'    ,'"+mDays+"' ,"+i+" , '"+mSessions+"'   ,to_date('"+mStartDate+"','dd-MM-yyyy HH:MI PM') ,to_date('"+mEndDate+"','dd-MM-yyyy HH:MI PM'),'"+mSessDuration+"' , '"+mDMemberID+"',sysdate)";
								a=db.insertRow(qry2);
							}
							else
							{
								qry2="UPDATE TTS#APPLICABLEDAYS SET  SORTON ="+i+",       TOTSESSION      = '"+mSessions+"' ,       STARTTIME       = to_date('"+mStartDate+"','dd-MM-yyyy HH:MI PM'),       ENDTIME         = to_date('"+mEndDate+"','dd-MM-yyyy HH:MI PM'),       SESSIONDURATION = '"+mSessDuration+"' ,       ENTRYBY         = '"+mDMemberID+"',       ENTRYDATE       = sysdate								WHERE  INSTITUTECODE   = '"+mInst+"' AND    EXAMCODE        = '"+Exam+"'  AND    TIMETABLECODE   = '"+NTTCodeShow+"'  AND    SETUPCODE       = '"+NSetupCode+"' AND    DAYS            = '"+mDays+"' ";
								a=db.update(qry2);
							}



							//			out.print(qry2);	

							if(a>0)
								flag=0;
							else
								flag=1;
								
										

						}

					}
					else
					{
						flag=1;
					}


			if(flag==1)
				out.print("<center><font Color=red face=arial size=2>Error in Saving </font></center>");
			else
				out.print("<center><font Color=green face=arial size=2>Record Saved Successfully</font><center>");				%>

				<form name=frm2>

				<%
try
		{
						


		 qry = "Select  to_char(A.starttime,'hh:mi AM') starttime,to_char(A.starttime,'hh24:mi')    From  "; 
		 qry=qry+"tts#applicabledays A  WHERE A.EXAMCODE = '"+Exam+"' and a.INSTITUTECODE='"+mInst+"'  AND a.TIMETABLECODE='"+NTTCodeShow+"' AND a.SETUPCODE='"+NSetupCode+"' ";
	       qry=qry+" and A.starttime is not null ORDER BY  2";

		 out.print(qry); 
		 //to_char(starttime+60/(24*60) , 'hh:mi AM')starttime
		 rstable = db.getRowset(qry);  
		   
%>	

<!-- *************************** Time Table start's ************************* -->
<br>
<table border="2" bordercolor="#C0C0C0" cellpadding="3" cellspacing="0" align="center" >
	<tr bgcolor="#FF8C00">
	<td><font color=white><B>DAY</B></font></td>
<%
String Tabletime ="";
	while(rstable.next())
	 { 
				Tabletime = rstable.getString("starttime");
		
		qry1="SELECT  TO_CHAR ('"+Tabletime+"', 'hh:mi AM')||'-'||TO_CHAR ('"+Tabletime+"'+60/(24*60), 'hh:mi AM') time ,TO_CHAR ('"+Tabletime+"'+60/(24*60), 'hh:mi AM')time1 from dual ";
		out.print(qry1);
		rs=db.getRowset(qry1);
		while(rs.next())
		 {

		 

		

		%>  
	<!-- ************************ Display time of Time table ******************* -->
	<td align='center'><font color="#FFFFFF" size="2"><b><%=rs.getString("time")%></b></font></td>
		<%	
		 }
		}
	%>
	 </tr>
	<%
		
		qry = "select Distinct  decode ( DAys ,'MON','1', ";
		qry=qry+" 'TUE','2', 'WED','3', 'THU','4', 'FRI','5', ";
		qry=qry+" 'SAT','6','SUN','7'), DAys From  tts#applicabledays ";
		qry=qry+" where EXAMCODE = '"+Exam+"' and  INSTITUTECODE='"+mInst+"'  AND TIMETABLECODE='"+NTTCodeShow+"' AND SETUPCODE='"+NSetupCode+"' order by 1";

		rstable = db.getRowset(qry);  	
		while(rstable.next())
		{
		 String DayDisplay=rstable.getString("days") ;
		 qry = "Select distinct to_char(A.starttime,'hh:mi AM') starttime,to_char(A.starttime,'hh24:mi')    From  "; 
		 qry=qry+" tts#applicabledays A  WHERE A.EXAMCODE = '"+Exam+"' and a.INSTITUTECODE='"+mInst+"'  AND a.TIMETABLECODE='"+NTTCodeShow+"' AND a.SETUPCODE='"+NSetupCode+"'  ";
	       qry=qry+" and A.starttime is not null ORDER BY  2";
		 rsTime = db.getRowset(qry);  
		%>
		<!-- *********** Display DAY's of Time Table  ************** -->
		<tr>	
			<td bgcolor="#FF8C00"><b><font color="#FFFFFF" face="Georgia"> <%=DayDisplay%> </font></b> </td>
			<%			 
			while(rsTime.next())
			{
			try
			{			
			Tabletime = rsTime.getString("starttime");
			qry2 = "select distinct SUBJECTID, nvl(LTP,'N/A') LTP, nvl(SHORTNAME,'*') SHORTNAME, nvl(FACULTYSHORTNAME,' ')FACULTYSHORTNAME ";
			qry2=qry2+" from TTS#TIMETABLEDATA2112  where EXAMCODE = '"+mEC+"'  ";
			//qry2=qry2+" AND EMPLOYEEID = DECODE('"+mFaculty+"','ALL', EMPLOYEEID,'"+mFaculty+"') AND ";
			//qry2=qry2+" SUBJECTID = DECODE('"+mSC+"','ALL', SUBJECTID,'"+mSC+"') AND ";
			qry2=qry2+" and to_char(FROMSESSIONTIME,'hh24:mi AM')= '"+Tabletime +"' AND ALLOCATIONDAY ='"+DayDisplay+"' ";			
			qry2=qry2+" and SUBJECTID is not null "; 			 
			//out.print(qry2);
			rsTableData = db.getRowset(qry2); 	
			if(rsTableData.next())
			{			 
				SubQry="Select SubjectCode from Subjectmaster where SubjectID='"+rsTableData.getString("SUBJECTID")+"'";
				rsSub = db.getRowset(SubQry); 
				if(rsSub.next())
					mySub=rsSub.getString("SubjectCode");
				else
					mySub="";
				%>
				<!-- **************** Display Data of Each block of Time Table  **************** -->
				<td>
				<font size="2"><b><%=mySub%><br>				 
				 
				<font color="#C00000"> <%=rsTableData.getString("LTP")%>&nbsp;&nbsp;&nbsp;&nbsp;<%=rsTableData.getString("SHORTNAME")%></font><br>
				<%=rsTableData.getString("FACULTYSHORTNAME")%>
				</b></font>
				</td>
				<%
			}

			else
			{
				 
				out.println("<td align='center'><b><font color='#990033'>---</font></b></td>");
			}
			}
			catch(Exception e)
			{
				//out.print("aaaaaaaaaaaa"+qry2);
			}

		 }
			
		%>
		</tr>
		<%
		}
	%>
	</table><br>
	<table align=center><tr><td title="Click to Print">&nbsp;&nbsp;&nbsp;<font color=blue><a onClick="window.print();"><img src="../../Images/printer.gif"></a></font>
</td></tr></table>
	<%	
	}
    catch(Exception e)
	{
		 out.println("Error : "+e.getMessage()+qry2);
	}
					%>
					
				</form>
				<%


				}
				
			}

		}
	}
	
  //-----------------------------
  //-- Enable Security Page Level  
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
%>
</body>
</html>