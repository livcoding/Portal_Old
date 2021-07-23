<%@ page import="ChartDirector.*" %>
<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*" %>
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
<TITLE>#### <%=mHead%> [ Student Reaction Survey Graph Rating Report </TITLE>
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
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">
function ChangeOptions(Program,DataCombo,DataComboFac,Subject,Faculty)
{
	removeAllOptions(Subject);
	var optn = document.createElement("OPTION");
			optn.text='ALL';
			optn.value='ALL';
			Subject.options.add(optn);
    for(i=0;i<DataCombo.options.length;i++)
       {
		var v1;
		var pos;
		var pc;
		var sc;
		var len;
		var otext;
		var v1=DataCombo.options(i).value;
		len= v1.length ;	
		pos=v1.indexOf('***');
		pc=v1.substring(0,pos);
		sc=v1.substring(pos+3,len);
		if (pc==Program)
		 { 	
			var optn = document.createElement("OPTION");
			optn.text=DataCombo.options(i).text;
			optn.value=sc;
			Subject.options.add(optn);
		}
		else if (Program=='ALL')
		{
			var optn = document.createElement("OPTION");
			optn.text=DataCombo.options(i).text;
			optn.value=sc;
			if(optn.text!=otext)
			{
			Subject.options.add(optn);
			otext=optn.text;
			}
		}

	}
			
 removeAllOptions(Faculty);

			var optn1 = document.createElement("OPTION");
			optn1.text='ALL';
			optn1.value='ALL';
			Faculty.options.add(optn1);

    for(i=0;i<DataComboFac.options.length;i++)
       {  
		var v11;
		var pos1;
		var id;
		var sc1;
		var len1;
		var otext1;
		var v11=DataComboFac.options(i).value;

		len1= v11.length ;	
		pos1=v11.indexOf('///');
		id=v11.substring(0,pos1);
		sc1=v11.substring(pos1+3,len1);
		var optn1 = document.createElement("OPTION");
			optn1.text=DataComboFac.options(i).text;
			optn1.value=id;
			if(optn1.text!=otext1)
			{
			Faculty.options.add(optn1);
			otext1=optn1.text;
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
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">
function ChangeCombo(Subject,DataComboFac,Faculty)
  {
    removeAllOptions(Faculty);

			var optn1 = document.createElement("OPTION");
			optn1.text='ALL';
			optn1.value='ALL';
			Faculty.options.add(optn1);

    for(i=0;i<DataComboFac.options.length;i++)
       {  
		var v11;
		var pos1;
		var id;
		var sc1;
		var len1;
		var otext1;
		var v11=DataComboFac.options(i).value;

		len1= v11.length ;	
		pos1=v11.indexOf('///');
		id=v11.substring(0,pos1);
		sc1=v11.substring(pos1+3,len1);

		if (sc1==Subject)
		 { 	
			var optn1 = document.createElement("OPTION");
			optn1.text=DataComboFac.options(i).text;
			optn1.value=id;
			
			Faculty.options.add(optn1);
		}
		else if (Subject=='ALL')
		{
			var optn1 = document.createElement("OPTION");
			optn1.text=DataComboFac.options(i).text;
			optn1.value=id;
			if(optn1.text!=otext1)
			{
			Faculty.options.add(optn1);
			otext1=optn1.text;
			}
		}
	}
  	}
</script>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%

DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null,rs2=null,rssrtype=null,rsc=null,rsc1=null;
GlobalFunctions gb =new GlobalFunctions();

long mTotStrength=0,mTotSentStrength=0;
String qry="";
String qry1="",qry2="";
String x="",y="",yy="",z="",mRsExam="",t="",mSP="",mPc="";
int mSNO=0;
String mMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
double mTotPrecent=0;
double mTotDivide=0;

String mOA="",mPC="",msc="";
double mMarks=0,mEval=0,mPerc=0,mMarks1=0,cnt1=0,a=0,rating=0,rating1=0,ev=0,ev1=0,avg=0;
double mExTot=0;
double exev1=0;
double exavg=0;
String mInst="";
String minst="";
String lpc="",lpc1=""; 
String mDsub="",mSF="";
String mExam="";
String mexam="";
long mLtot=0,mTtot=0,mPtot=0;
long Ltot=0,Ttot=0,Ptot=0;

String mEvent="";
String mevent="";

String mLTP="";
String mltp="";
String MLTP=""; 

String mPCode="";
String mpcode="";

String mSubj="";
String msubj="";

String mFaculty="";
String mFacultyID="";
String mfaculty="";
String mcolor="",mColor="",mlistorder="";
int i=0;
int j=0;

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
	OLTEncryption enc=new OLTEncryption();
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
	{
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
	qry="Select WEBKIOSK.ShowLink('104','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------



%>
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>SRS Teacher Rating Report [Graph View]</b></TD>
</font></td></tr>
</TABLE>
<table cellpadding=1 cellspacing=0 width="100%" align=center rules=groups border=3>
<tr>
<td nowrap colspan=4>
<FONT color=black><FONT face=Arial size=2>&nbsp;&nbsp;<STRONG>Choice:</STRONG></FONT></FONT>
&nbsp;
<select name="Choice" id="Choice" style="WIDTH: 280px">
<% 
	if(request.getParameter("Choice")==null)
   	{
 %>
	<option selected value="OFAS">One faculty All subject for one event</option>
	<option  value="AFOS">All faculty one subject for one event</option>
	<option  value="OFOS">One faculty one subject for all event</option>
<%	
	}
	else
	{
	  	String mChoice=request.getParameter("Choice");
		if(mChoice.equals("OFAS"))
		{
	%>
		<option selected value="OFAS">One faculty All subject for one event</option>
		<option  value="AFOS">All faculty one subject for one event</option>
		<option  value="OFOS">One faculty one subject for all event</option>
	<%	
		}
		else if(mChoice.equals("AFOS"))
		{
	 %>	
		<option  value="OFAS">One faculty All subject for one event</option>
		<option selected value="AFOS">All faculty one subject for one event</option>
		<option  value="OFOS">One faculty one subject for all event</option>
	<%	
		}
		else if(mChoice.equals("OFOS"))
		{
	%>
		<option  value="OFAS">One faculty All subject for one event</option>
		<option  value="AFOS">All faculty one subject for one event</option>
		<option  selected value="OFOS">One faculty one subject for all event</option>
	<%	
		}
		}
	%>  
	</select>&nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp;
<FONT color=black><FONT face=Arial size=2>&nbsp;&nbsp;<STRONG>Graph Type:</STRONG></FONT></FONT>
&nbsp; 
<select name="GraphType" id="GraphType" style="WIDTH: 140px">
 <% 
	if(request.getParameter("GraphType")==null)
   	{
 %>
	   <option  value="CB" selected>Soft BarGraph</option>
         <option  value="SB">Simple BarGraph</option>
	   <option  value="LG">Line Graph</option>
	   <!--<option value="PG">Pie BarGraph</option>-->
<%
	}
	  else
   	{
		mlistorder=request.getParameter("GraphType");
		if(mlistorder.equals("CB"))
		{
	%>
		<option value="CB" selected>Soft BarGraph</option>
		<option value="SB" >Simple BarGraph</option>
		<option value="LG">Line Graph</option>
		<!--<option  value="PG">Pie BarGraph</option>-->
	<%
	      }
		else if(mlistorder.equals("SB"))
		{
	%>
		<option  value="CB" >Soft BarGraph</option>
		<option  value="SB" selected>Simple BarGraph</option>
		<option  value="LG" >Line Graph</option>
		<!--<option  value="PG">Pie BarGraph</option>-->
	<%
		}
		else if(mlistorder.equals("LG"))
		{
	%>
		<option  value="CB" >Soft BarGraph</option>
		<option  value="SB" >Simple BarGraph</option>
		<option  value="LG" selected>Line Graph</option>
		<!--<option value="PG">Pie BarGraph</option>-->
	<%  
 		}
      	}
	%>
	</select> 
	</td>	
	</tr>
	<!--Institute-->
	<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
<%
	qry="Select Distinct NVL(INSTITUTECODE,' ')IC from v#SRSEVENTS WHERE nvl(FINALIZED,'N')='Y' and nvl(deactive,'N')='N' ";
	rs=db.getRowset(qry);
	while(rs.next())
	{
		mInst=rs.getString("IC");
	}
%>
<!--Program**********-->
<tr><td nowrap><FONT color=black><FONT face=Arial size=2>&nbsp;&nbsp;<STRONG>Program</STRONG></FONT></FONT>
<%
try
{
	qry="Select Distinct nvl(B.PROGRAMCODE,' ')PROGRAMCODE, A.PROGRAMNAME||' ('||B.PROGRAMCODE||') ' Program from PROGRAMMASTER A, V#SRSEVENTS B where A.ProgramCode=B.ProgramCode and nvl(FINALIZED,'N')='Y' and nvl(B.deactive,'N')='N'";
	rs=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		%>
		<select name=Program tabindex="0" id="Program" style="WIDTH: 300px" onclick="ChangeOptions(Program.value,DataCombo,DataComboFac,Subject,Faculty);" onChange="ChangeOptions(Program.value,DataCombo,DataComboFac,Subject,Faculty);">	
		<OPTION selected value=ALL>ALL</option>
		<%   
		while(rs.next())
		{
			mPCode=rs.getString("PROGRAMCODE");
			if(mpcode.equals(""))
 			mpcode=mPCode;
			%>
			<OPTION Value =<%=mPCode%>><%=rs.getString("Program")%></option>
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name=Program tabindex="0" id="Program" style="WIDTH: 300px" onclick="ChangeOptions(Program.value,DataCombo,DataComboFac,Subject,Faculty);" onChange="ChangeOptions(Program.value,DataCombo,DataComboFac,Subject,Faculty);">	
		<%
		if (request.getParameter("Program").toString().trim().equals("ALL"))
 		{
			lpc="ALL";
			%>
	 		<OPTION selected value=ALL>ALL</option>
			<%
		}
		else
		{
			%>
			<OPTION value=ALL>ALL</option>
			<%
		}

		while(rs.next())
		{
			mPCode=rs.getString("PROGRAMCODE");
			if(mPCode.equals(request.getParameter("Program").toString().trim()))
 			{
				mpcode=mPCode;
				lpc=mPCode;
				%>
				<OPTION selected Value =<%=mPCode%>><%=rs.getString("Program")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mPCode%>><%=rs.getString("Program")%></option>
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
//	out.println("MSG5");
}
%>
</td>
<!--SRSEVENTCODE****-->
<td nowrap callspan=0><FONT color=black><FONT face=Arial size=2><STRONG>SRS Event</STRONG></FONT></FONT>
<select name=Exam tabindex="0" id="Exam" style="WIDTH: 140px">	

<%
try
{ 
	qry="Select Distinct nvl(SRSEVENTCODE,' ')Exam from v#SRSEVENTS WHERE  NVL(FINALIZED,'N')='Y' and nvl(deactive,'N')='N'";
	rs=db.getRowset(qry);
//	out.print(qry);
	if (request.getParameter("x")==null)
	{
		%>
		<OPTION selected Value=ALL>ALL</option>
		<%   
		while(rs.next())
		{
			mExam=rs.getString("Exam");
			if(mexam.equals(""))
 			mexam=mExam;
			%>
			<OPTION Value =<%=mExam%>><%=mExam%></option>
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{	if (request.getParameter("Exam").toString().trim().equals("ALL"))
 		{
			%>
	 		<OPTION selected value=ALL>ALL</option>
			<%
		}
		else
		{
			%>
			<OPTION value=ALL>ALL</option>
			<%
		}

		while(rs.next())
		{
			mExam=rs.getString("Exam");
			if(mExam.equals(request.getParameter("Exam").toString().trim()))
 			{
				mexam=mExam;
				%>
				<OPTION selected Value =<%=mExam%>><%=mExam%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mExam%>><%=mExam%></option>
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
//	out.println("MSG2");
}
%>
</td></tr>
<!--SUBJECT**************-->
<tr><td nowrap><FONT color=black><FONT face=Arial size=2>&nbsp;&nbsp;<STRONG>Subject</STRONG>&nbsp;&nbsp;</FONT></FONT>

<select name="Subject" ID="Subject" tabindex="0" style="WIDTH: 350px" onclick="ChangeCombo(Subject.value,DataComboFac,Faculty);" onChange="ChangeCombo(Subject.value,DataComboFac,Faculty);">

<%
if(request.getParameter("x")==null)
{
	qry1="Select Distinct B.SubjectCode, B.SubjectID, B.Subject, B.Subject||' ('||B.SubjectCode||') ' Subj from v#SRSEVENTS B  where nvl(B.FINALIZED,'N')='Y' and nvl(B.deactive,'N')='N' ORDER BY SUBJ";
	rs1=db.getRowset(qry1);
%>
	<OPTION selected Value=ALL>ALL</option>
<%
	while(rs1.next())
	{
		mSubj=rs1.getString("SubjectID");
		if(mSubj.equals(""))
 		%>
		<OPTION Value ="<%=mSubj%>"><%=rs1.getString("Subj")%></option>
		<%			
	}

}
else
{
qry1="Select Distinct B.SubjectID, B.SubjectCode, B.Subject, B.Subject||' ('||B.SubjectCode||') ' Subj from v#SRSEVENTS B  where nvl(B.FINALIZED,'N')='Y' and nvl(B.deactive,'N')='N' ";
qry1=qry1+" and B.programcode=decode('"+lpc+"','ALL',B.programcode,'"+lpc+"') ORDER BY SUBJ";
	rs1=db.getRowset(qry1);
	//mSubj ="";
	if (request.getParameter("Subject").toString().trim().equals("ALL"))
 		{
			lpc1="ALL";
			%>
	 		<OPTION selected value=ALL>ALL</option>
			<%
		}
		else
		{
			%>
			<OPTION value=ALL>ALL</option>
			<%
		}
	while(rs1.next())
	{
		
	
		 mSubj=rs1.getString("SubjectID");
if (mSubj.equals(request.getParameter("Subject").toString().trim()))
{		lpc1=mSubj;


 		%>
		<OPTION selected Value ="<%=mSubj%>"><%=rs1.getString("Subj")%></option>
		<%
		}	
		else
		{
		mSubj=rs1.getString("SubjectID");
	%>
      	<OPTION Value ="<%=mSubj%>"><%=rs1.getString("Subj")%></option>
     	<%			
	   	}
		
	}

}
%>
</select>

<!-- *****New Data combo****** -->

<%
try
{ 
	qry1="Select Distinct B.SubjectID,B.SubjectCode,B.Programcode, B.Subject, B.Subject||' ('||B.SubjectCode||') ' Subj from v#SRSEVENTS B  where nvl(B.FINALIZED,'N')='Y' and nvl(B.deactive,'N')='N' ORDER BY SUBJ";
	rs1=db.getRowset(qry1);
	//out.print(qry1);	
	if (request.getParameter("x")==null) 
	{
		%>
		<select name=DataCombo tabindex="0" id="DataCombo" style="WIDTH: 0px">	
	<!-- <OPTION selected Value=ALL>ALL</option> -->
		<%   
		while(rs1.next())
		{
			mSubj=rs1.getString("SubjectID");
			mPc=rs1.getString("Programcode");
			mSP=mPc+"***"+mSubj;
			//mSP=mPc;
			if(mSP.equals(""))
 			msubj=mSubj;
			%>
			<OPTION Value ="<%=mSP%>"><%=rs1.getString("Subj")%></option>
			<%			
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
		
		while(rs1.next())
		{
			mSubj=rs1.getString("SubjectID");
			mPc=rs1.getString("Programcode");
			mSP=mPc+"***"+mSubj;
			if(mSP.equals(request.getParameter("DataCombo").toString().trim()))
 			{
				msubj=mSubj;
				%>
				<OPTION selected Value ="<%=mSP%>"><%=rs1.getString("Subj")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value ="<%=mSP%>"><%=rs1.getString("Subj")%></option>
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
}
%>

</td>


<!--LTP***********-->
<td nowrap><FONT color=black><FONT face=Arial size=2><STRONG>LTP</STRONG>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT></FONT>
<%
try
{ 
	qry1="select 'ALL' LTP,'ALL' LTPDesc,'0' ono from dual UNION select distinct LTP, decode(LTP,'L','Lecture','T','Tutorial','Practical') LTPDesc,decode(ltp,'L','1','T','2','3') ono from v#SRSevents where nvl(FINALIZED,'N')='Y' and nvl(deactive,'N')='N' order by ono" ;
	rs1=db.getRowset(qry1);
	if (request.getParameter("x")==null) 
	{
		%>
		<select ID="LTP" Name=LTP tabindex="0" style="WIDTH: 120px">
		<%   
		while(rs1.next())
		{
			mLTP=rs1.getString("LTP");
			if(mltp.equals(""))
 			{mltp=mLTP;
			%>
			<OPTION selected Value =<%=mLTP%>><%=rs1.getString("LTPDesc")%></option>
			<%			
			}
			else
			{
			%>
			<OPTION Value =<%=mLTP%>><%=rs1.getString("LTPDesc")%></option>
			<%			

			}
		}
		%>
		</select><font color='green'>#</font>
		<%
	}
	else
	{
		%>	
		<select ID="LTP" Name=LTP tabindex="0" style="WIDTH: 120px">
		<%		 
		while(rs1.next())
		{
			mLTP=rs1.getString("LTP");
			if(mLTP.equals(request.getParameter("LTP").toString().trim()))
 			{
				mltp=mLTP;
				%>
				<OPTION selected Value =<%=mLTP%>><%=rs1.getString("LTPDesc")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mLTP%>><%=rs1.getString("LTPDesc")%></option>
		      	<%			
		   	}
		}
		%>
		</select><font color='green'>#</font>
	  	<%
	 }
 }    
catch(Exception e)
{
	out.println("");
}
%>

<!--********DataComboFac***********-->
<%
try
{ 
	qry="select Distinct nvl(A.EMPLOYEEID,' ') EMPLOYEEID,nvl(A.subjectcode,' ') subjectcode,nvl(A.subjectid,' ') subjectid,nvl(A.EMPLOYEENAME,' ') EMPLOYEENAME from V#SRSEVENTS A Where nvl(A.APPROVED,'N')='Y' and nvl(A.FINALIZED,'N')='Y' and nvl(Deactive,'N')='N' ORDER BY  EMPLOYEENAME,subjectcode";
	rs=db.getRowset(qry);
	if (request.getParameter("DataComboFac")==null)
	{
		%>
		<select name='DataComboFac' id="DataComboFac" style="WIDTH:0px">	
		<%   
		while(rs.next())
		{
			mFacultyID=rs.getString("EMPLOYEEID");
			mDsub=rs.getString("subjectid");
			mSF=mFacultyID+"///"+mDsub;
              	mFaculty=rs.getString("EMPLOYEENAME");
			if(mSF.equals(""))
 			%>
			<OPTION Value =<%=mSF%>><%=mFaculty%></option>
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name='DataComboFac' tabindex="0" id="DataComboFac" style="WIDTH:0px">	
		<%
		  while(rs.next())
		{
			mFaculty=rs.getString("EMPLOYEENAME");
			mFacultyID=rs.getString("EMPLOYEEID");
			mSF=mFacultyID+"///"+mDsub;
			if(mSF.equals(request.getParameter("DataComboFac").toString().trim()))
 			{
				mfaculty=mFacultyID;
				%>
				<OPTION selected Value =<%=mSF%>><%=mFaculty%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mSF%>><%=mFaculty%></option>
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
	out.println("");
}
%>
</td></tr>
<!--Faculty***********-->
<tr><td colspan=2><FONT color=black><FONT face=Arial size=2>&nbsp;&nbsp;<STRONG>Faculty</STRONG>&nbsp;&nbsp;</FONT></FONT>
<select name="Faculty" ID="Faculty" tabindex="0" style="WIDTH: 300px">
<%
if(request.getParameter("Faculty")==null)
{
qry="select Distinct nvl(A.EMPLOYEEID,' ') EMPLOYEEID, ";
qry=qry+" nvl(A.EMPLOYEENAME,' ') EMPLOYEENAME from V#SRSEVENTS A Where nvl(A.APPROVED,'N')='Y' ";
qry=qry+" and nvl(A.FINALIZED,'N')='Y' and nvl(Deactive,'N')='N' ORDER BY  EMPLOYEENAME";
rs=db.getRowset(qry);
%>
	<OPTION selected Value=ALL>ALL</option>
<%
		while(rs.next())
		{
			mFacultyID=rs.getString("EMPLOYEEID");
			mFaculty=rs.getString("EMPLOYEENAME");
			if(mFacultyID.equals(""))
 			%>
			<OPTION Value =<%=mFacultyID%>><%=mFaculty%></option>
			<%			
		}
}
else
{
qry="select Distinct nvl(A.EMPLOYEEID,' ') EMPLOYEEID, ";
qry=qry+" nvl(A.EMPLOYEENAME,' ') EMPLOYEENAME from V#SRSEVENTS A Where nvl(A.APPROVED,'N')='Y' ";
qry=qry+" and nvl(A.FINALIZED,'N')='Y' and nvl(Deactive,'N')='N' and A.subjectid=decode('"+lpc1+"','ALL',A.subjectid,'"+lpc1+"') order by employeename";
rs=db.getRowset(qry);
if (request.getParameter("Faculty").toString().trim().equals("ALL"))
 		{
	
			%>
	 		<OPTION selected value=ALL>ALL</option>
			<%
		}
		else
		{
			%>
			<OPTION value=ALL>ALL</option>
			<%
		}
		while(rs.next())
		{
		mFacultyID=rs.getString("EMPLOYEEID");
		mFaculty=rs.getString("EMPLOYEENAME");
if (mFacultyID.equals(request.getParameter("Faculty").toString().trim()))
{

 		%>
		<OPTION selected Value ="<%=mFacultyID%>"><%=mFaculty%></option>
		<%
		}	
		else
		{
	%>
      	<OPTION Value ="<%=mFacultyID%>"><%=mFaculty%></option>
     	<%			
	   	}
		
	}

}
%>
</select>
<INPUT Type="submit" Value="Show"></td>
</tr>
</table>
</form>
<%
String mE="";
String mP="";
String mS="";
String mL="";
String mF="";
String mC="";
%>
<TABLE rules=Rows cellSpacing=0 cellPadding=0 width="100%" border=1 >
<table bgcolor=#fce9c5 class="sort-table" id="table-1" width='100%' bottommargin=0 rules=groups topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center>	

 <form name="frm1" method=post>
 <%
      if(request.getParameter("x")!=null)
	{
	 mE=request.getParameter("Exam").toString().trim();
	 mP=request.getParameter("Program").toString().trim();
	 mS=request.getParameter("Subject").toString().trim();
	 mL=request.getParameter("LTP").toString().trim();
	 mF=request.getParameter("Faculty").toString().trim();
	 mC=request.getParameter("Choice").toString().trim();

	double[] DA= new double[1000] ;
	String[] LA=new String[1000];
	String aa="";
		aa=request.getParameter("Choice");
	
	if(aa.equals("AFOS") && (mS.equals("ALL") || mE.equals("ALL")))
	{
	%>	
		<font color=red>
		<h3>	<br><img src='../../Images/Error1.jpg'>	
		As per Selected Choice... 
		<li>You can not choose all subject for given choice.
		<li>You can not choose one faculty for given choice.
		<li>You can not choose all srsevent for given choice.

			
		</h3><br>
		
		</font>	
	<%
	}
	else
	{
    	if(aa.equals("OFAS") && (mF.equals("ALL")|| mE.equals("ALL")))
	{
	%>	
		<font color=red>
		<h3>	<br><img src='../../Images/Error1.jpg'>	
		As per Selected Choice... 
		<li>You can not choose one subject for given choice.
		<li>You can not choose all faculty for given choice.
		<li>You can not choose all srsevent for given choice.

			
		</h3><br>

		</font>	
	<%
	}
	else
	{
	if(aa.equals("OFOS") && (mF.equals("ALL") || mS.equals("ALL")))	
	{
	%>	
		<font color=red>
		<h3>	<br><img src='../../Images/Error1.jpg'>	
		As per Selected Choice... 
		<li>You can not choose all subject for given choice.
		<li>You can not choose all faculty for given choice.
		<li>You can not choose one srsevent for given choice.
		</h3><br>
		</font>	
	<%
	}
	else
	{
qry1 =" select distinct A.INSTITUTECODE, A.COMPANYCODE,A.SRSEVENTCODE,A.FACULTYTYPE,A.EMPLOYEEID, ";
qry1 = qry1 + "a.EXAMCODE,A.SUBJECTCODE,a.subjectid, A.LTP, ";
qry1 = qry1 + "a.EMPLOYEENAME,a.SUBJECT ";
qry1 = qry1 + "from v#SRSEVENTDETAIL A Where A.INSTITUTECODE='"+mInst+"' AND A.SRSEVENTCODE=decode('"+mE+"','ALL',A.SRSEVENTCODE,'"+mE+"') ";
qry1 = qry1 + "And A.PROGRAMCODE=decode('"+mP+"','ALL',A.PROGRAMCODE, '"+mP+"') ";
qry1 = qry1 + "And A.subjectid=decode('"+mS+"','ALL',A.subjectid, '"+mS+"') ";
qry1 = qry1 + "and A.LTP=decode('"+mL+"','ALL',LTP, '"+mL+"') ";
qry1 = qry1 + "and A.EMPLOYEEID=decode('"+mF+"','ALL',A.EMPLOYEEID, '"+mF+"') ";
qry1 = qry1 + "and nvl(A.DEACTIVE,'N')='N'";
qry1 = qry1 + "And (A.FSTID) in (select FSTID from v#SRSEvents where nvl(FINALIZED,'N')='Y' and nvl(Deactive,'N')='N')";
qry1 = qry1 + "order by A.Employeename,A.EMPLOYEEID,A.SUBJECTCODE,A.LTP";

      mMarks=0;
	mEval=0;
	mPerc=0;
	String p="";
	rs1=db.getRowset(qry1);
	while(rs1.next())
	{ 	 
	try{
		if(x.equals("") || y.equals("") || z.equals(""))
		{ 
		      mRsExam=rs1.getString("EXAMCODE").trim();
			x=rs1.getString("EMPLOYEEID");
			yy=rs1.getString("SUBJECTCODE");
			y=rs1.getString("SUBJECTID");
			z="'"+rs1.getString("LTP")+"'";
			t=rs1.getString("LTP");
			p=rs1.getString("EMPLOYEENAME");

		}
     		else if (!(rs1.getString("EMPLOYEEID").equals(x) && rs1.getString("SUBJECTID").equals(y)) )
		{
		LA[j++]=yy;
	mTotPrecent=0;
	mTotDivide=0;
	qry="select SRSCODE, nvl(Weightage,0) Weightage from SRSTYPEMASTER WHERE SRSEVENTCODE=decode('"+mE+"','ALL',SRSEVENTCODE,'"+mE+"') Order by SEQID ";
	rssrtype=db.getRowset(qry);
	while(rssrtype.next())
	{	
	qry2="select NVL(D.EVALUATIONUPTO,0)EVALUATIONUPTO,COUNT(*) cnt, nvl(A.NASELECTED,'N')NASELECTED, A.SRSCODE,A.SRSSUBCODE,A.SRSQUESTIONCODE,"; 
	qry2=qry2+ " A.RATINGCODE,B.SRSDESCRIPTION,B.SEQID,C.SRSSUBDESCRIPTION,C.SEQID,nvl(C.EXCLUDINGREQUIRED,'N') EXCLUDINGREQUIRED,sum(A.RatingValue) RatingValue from V#SRSEVENTDETAIL A,SRSTYPEMASTER B,SRSSUBTYPEMASTER C,SRSRATINGMASTER D";
	qry2=qry2+ " where A.SRSEVENTCODE=decode('"+mE+"','ALL',A.SRSEVENTCODE,'"+mE+"') AND A.SRSEVENTCODE=B.SRSEVENTCODE AND A.SRSEVENTCODE=C.SRSEVENTCODE  and A.SRSCODE=B.SRSCODE AND A.SRSSUBCODE=C.SRSSUBCODE AND A.SRSCODE=C.SRSCODE AND A.institutecode='"+mInst+"'";
	qry2=qry2 + " AND A.EXAMCODE='"+mRsExam+"' ";
	qry2=qry2+"  AND  A.RATINGCODE=D.RATINGCODE  ";
	qry2=qry2+ " and A.Employeeid='"+x+"' and  ";
	qry2=qry2 + " A.PROGRAMCODE=decode('"+mP+"','ALL',A.PROGRAMCODE, '"+mP+"')  AND ";
	qry2=qry2 + " A.LTP IN ("+z+") AND A.SRSCODE='"+rssrtype.getString("SRSCODE")+"' ";
	qry2=qry2+ " and A.subjectID='"+y+"' and nvl(A.naselected,'N')='N' ";
	qry2=qry2+" and nvl(APPROVED,'N')='Y' and nvl(FINALIZED,'N')='Y' ";
	qry2=qry2 + " AND  nvl(A.DEACTIVE,'N')='N'  ";
	qry2=qry2+" Group by D.EVALUATIONUPTO,A.NASELECTED,A.SRSCODE,A.SRSSUBCODE,A.SRSQUESTIONCODE,"; 
	qry2=qry2+ " A.RATINGCODE,B.SRSDESCRIPTION,B.SEQID,C.SRSSUBDESCRIPTION,C.SEQID,C.EXCLUDINGREQUIRED ORDER BY B.SEQID,C.SEQID ";
	rs2=db.getRowset(qry2);
	

		mMarks=0;
		mEval=0;
		mPerc=0;
		a=0;
		cnt1=0;
		rating=0;
		rating1=0;
		ev=0;
		ev1=0;
		avg=0;
		mExTot=0;
		exev1=0;
		exavg=0;
			  while(rs2.next())
	   		   {
				ev=rs2.getDouble("EVALUATIONUPTO");
			 	if(rs2.getString("NASELECTED").equals("N"))
	 			{
					a=rs2.getDouble("RatingValue");
					cnt1=rs2.getDouble("cnt");
					rating=a/cnt1;	
					rating=gb.getRound(rating,2);
					rating1=rating1+rating ;
					ev1=ev1+ev;
					if (rs2.getString("EXCLUDINGREQUIRED").equals("Y"))
				     {
						mExTot=mExTot+rating;
						mExTot=gb.getRound(mExTot,2);
						exev1=exev1+ev;
		                 }
					
		 		 } //closing of if
	   		  }  //closing of rs2..while
				if(rating1==0)
				{
			%>	
				<!-- <TD nowrap>&nbsp;</td> -->
			<%
				}
				else
				{
					if(mExTot>0)
					{
					   exavg=((rating1-mExTot)/(ev1-exev1))*100;
					mTotPrecent=mTotPrecent+(exavg*rssrtype.getDouble("Weightage")/100);
				   mTotDivide=mTotDivide+(rssrtype.getDouble("Weightage")/100);

					if(exavg<50)
						mcolor="red";
						else
						mcolor="black";
					}
					else
					{
						avg=(rating1/ev1)*100;
					mTotPrecent=mTotPrecent+(avg*rssrtype.getDouble("Weightage")/100);
					mTotDivide=mTotDivide+(rssrtype.getDouble("Weightage")/100);
						if(avg<50)
						mcolor="red";
						else
						mcolor="black";
					}	
			         } 
		      	}
			if(mTotDivide>0)
			{
			if((mTotPrecent/mTotDivide)<50)
			mColor="red";
			else
			mColor="black";
		//	if(i>999)
		//	break;
			DA[i++]=gb.getRound((mTotPrecent/mTotDivide),2);
			}
			else
			{
			%>
			<td>&nbsp;</td>
			<%
			}
			mTotPrecent=0;
			mTotDivide=0;
	//---------------
	//---------------
	%>
	     </tr> 
	 <%	mRsExam=rs1.getString("EXAMCODE").trim();
		x=rs1.getString("EMPLOYEEID");
		yy=rs1.getString("SUBJECTCODE");
		y=rs1.getString("SUBJECTID");
		z="'"+rs1.getString("LTP")+"'";	
		p=rs1.getString("EMPLOYEENAME");
		t=rs1.getString("LTP");	
		}
	  else
	  {
		z=z+",'"+rs1.getString("LTP")+"'";	
		t=t+rs1.getString("LTP");	
	  }		
	}
	catch(Exception e)
	{
	}
   }  //closing of while rs1
//--------counting of students....
   if(!x.equals("") && !y.equals("") && !z.equals(""))
 	{
		LA[j++]=yy;
	//--------------------------------------------------
  try{
		qry="select SRSCODE, nvl(Weightage,0) Weightage from SRSTYPEMASTER WHERE SRSEVENTCODE=decode('"+mE+"','ALL',SRSEVENTCODE,'"+mE+"') Order by SEQID ";
		rssrtype=db.getRowset(qry);
		while(rssrtype.next())
		{
	qry2="select NVL(D.EVALUATIONUPTO,0)EVALUATIONUPTO,COUNT(*) cnt, nvl(A.NASELECTED,'N')NASELECTED, A.SRSCODE,A.SRSSUBCODE,A.SRSQUESTIONCODE,"; 
	qry2=qry2+ " A.RATINGCODE,B.SRSDESCRIPTION,B.SEQID,C.SRSSUBDESCRIPTION,C.SEQID,nvl(C.EXCLUDINGREQUIRED,'N') EXCLUDINGREQUIRED,sum(A.RatingValue) RatingValue from V#SRSEVENTDETAIL A,SRSTYPEMASTER B,SRSSUBTYPEMASTER C,SRSRATINGMASTER D";
	qry2=qry2+ " where A.SRSEVENTCODE=decode('"+mE+"','ALL',A.SRSEVENTCODE,'"+mE+"') AND A.SRSEVENTCODE=B.SRSEVENTCODE AND A.SRSEVENTCODE=C.SRSEVENTCODE  and A.SRSCODE=B.SRSCODE AND A.SRSSUBCODE=C.SRSSUBCODE AND A.SRSCODE=C.SRSCODE AND A.institutecode='"+mInst+"'";
	qry2=qry2 + " AND A.EXAMCODE='"+mRsExam+"' ";
	qry2=qry2+"  AND  A.RATINGCODE=D.RATINGCODE  ";
	qry2=qry2+ " and A.Employeeid='"+x+"' and  ";
	qry2=qry2 + " A.PROGRAMCODE=decode('"+mP+"','ALL',A.PROGRAMCODE, '"+mP+"')  AND ";
	qry2=qry2 + " A.LTP IN ("+z+") AND A.SRSCODE='"+rssrtype.getString("SRSCODE")+"' ";
	qry2=qry2+ " and A.subjectid='"+y+"' and nvl(A.naselected,'N')='N' ";
	qry2=qry2+" and nvl(APPROVED,'N')='Y' and nvl(FINALIZED,'N')='Y' ";
	qry2=qry2 + " AND  nvl(A.DEACTIVE,'N')='N'  ";
	qry2=qry2+" Group by D.EVALUATIONUPTO,A.NASELECTED,A.SRSCODE,A.SRSSUBCODE,A.SRSQUESTIONCODE,"; 
	qry2=qry2+ " A.RATINGCODE,B.SRSDESCRIPTION,B.SEQID,C.SRSSUBDESCRIPTION,C.SEQID,C.EXCLUDINGREQUIRED ORDER BY B.SEQID,C.SEQID ";
	rs2=db.getRowset(qry2);

		mMarks=0;
		mEval=0;
		mPerc=0;
		a=0;
		cnt1=0;
		rating=0;
		rating1=0;
		ev=0;
		ev1=0;
		avg=0;
		mExTot=0;
		exev1=0;
		exavg=0;
			  while(rs2.next())
	   		  {
				ev=rs2.getDouble("EVALUATIONUPTO");
				if(rs2.getString("NASELECTED").equals("N"))
	 			{
					a=rs2.getDouble("RatingValue");
					cnt1=rs2.getDouble("cnt");
					rating=a/cnt1;	
					rating=gb.getRound(rating,2);
					rating1=rating1+rating ;
					ev1=ev1+ev;
				if (rs2.getString("EXCLUDINGREQUIRED").equals("Y"))
				  {
					mExTot=mExTot+rating;
					mExTot=gb.getRound(mExTot,2);
					exev1=exev1+ev;
				  }
					
		 		}
	   		  }
				if(rating1==0)
				{
			%>	<!--	<TD>&nbsp;</td> -->
			<%
				}
				else
				{
				if(mExTot>0)
				{
				exavg=((rating1-mExTot)/(ev1-exev1))*100;			
				mTotPrecent=mTotPrecent+(exavg*rssrtype.getDouble("Weightage")/100);
				mTotDivide=mTotDivide+(rssrtype.getDouble("Weightage")/100);
				
					if(exavg<50)
						mcolor="red";
						else
						mcolor="black";
				}
				else
				{
					avg=(rating1/ev1)*100;
				   mTotPrecent=mTotPrecent+(avg*rssrtype.getDouble("Weightage")/100);
				   mTotDivide=mTotDivide+(rssrtype.getDouble("Weightage")/100);
				
						if(avg<50)
						mcolor="red";
						else
						mcolor="black";
				}	
			} 
			}
			if(mTotDivide>0)
			{
			if((mTotPrecent/mTotDivide)<50)
						mColor="red";
						else
						mColor="black";
			//	out.print("compre"+gb.getRound((mTotPrecent/mTotDivide),2)+"<br>");
		 		DA[i++]=gb.getRound((mTotPrecent/mTotDivide),2);
			}
			else
			{
			%>
			<td>&nbsp;</td>
			<%
			}
			mTotPrecent=0;
			mTotDivide=0;
		}
		catch(Exception e)
		{
		}
	}
%>
 </tr> 
</form>
</TABLE>
<%
int k=0;
double [] data =new double[i];
String[] labels =new String[j];

for(k=0;k<i;k++)
data[k]=DA[k];

for(k=0;k<j;k++)
labels[k]=LA[k];
String mGraphType="";

if (request.getParameter("GraphType")!=null)
    mGraphType=request.getParameter("GraphType").toString().trim();



String mTitle ="Faculty cum Subject wise SRS Rating Graph ";

if (mGraphType.equals("PG"))
{
// Create a PieChart object of size 360 x 300 pixels
PieChart c = new PieChart(360, 300);

// Set the center of the pie at (180, 140) and the radius to 100 pixels
c.setPieSize(180, 140, 100);

// Set the pie data and the pie labels
c.setData(data, labels);

// output the chart
String chart1URL = c.makeSession(request, "chart1");

// Include tool tip for the chart
String imageMap1 = c.getHTMLImageMap("", "",
    "title='{label}: US${value}K ({percent}%)'");
%>
 <hr color="#000080"> 
<img  src='<%=response.encodeURL("getchart.jsp?"+chart1URL)%>'
    usemap="#map1" border="0">
<map name="map1"><%=imageMap1%></map>
<%
}
else if (mGraphType.equals("CB"))
{
// Create a XYChart object of size 600 x 360 pixels
XYChart c = new XYChart(650, 360);

// Add a title to the chart using 18pts Times Bold Italic font
c.addTitle(mTitle, "Times New Roman Bold Italic", 18);

// Set the plotarea at (60, 40) and of size 500 x 280 pixels. Use a vertical gradient
// color from light blue (eeeeff) to deep blue (0000cc) as background. Set border and
// grid lines to white (ffffff).
c.setPlotArea(60, 40, 550, 280, c.linearGradientColor(60, 40, 60, 280, 0xeeeeff, 0x0000cc), -1, 0xffffff, 0xffffff);

// Add a multi-color bar chart layer using the supplied data. Use soft lighting
// effect with light direction from left.
c.addBarLayer3(data).setBorderColor(Chart.Transparent, Chart.softLighting(Chart.Left)
    );

// Set x axis labels using the given labels
c.xAxis().setLabels(labels);

// Draw the ticks between label positions (instead of at label positions)
c.xAxis().setTickOffset(0.5);

// Add a title to the y axis with 10pts Arial Bold font
c.yAxis().setTitle("Comprehensive SRS Rating", "Arial Bold", 10);

// Set axis label style to 8pts Arial Bold
c.xAxis().setLabelStyle("Arial Bold", 8);
c.yAxis().setLabelStyle("Arial Bold", 8);

// Set axis line width to 2 pixels
c.xAxis().setWidth(2);
c.yAxis().setWidth(2);

// output the chart
String chart1URL = c.makeSession(request, "chart1");

// Include tool tip for the chart
String imageMap1 = c.getHTMLImageMap("", "", "title='Year {xLabel}: US$ {value}M'");
%>
<hr color="#000080">
<br>
<img src='<%=response.encodeURL("getchart.jsp?"+chart1URL)%>'
    usemap="#map1" border="0">
<map name="map1"><%=imageMap1%></map>
<%
}
else if (mGraphType.equals("SB"))
{

// Create a XYChart object of size 250 x 250 pixels
XYChart c = new XYChart(650, 250);

// Set the plotarea at (30, 20) and of size 200 x 200 pixels
c.setPlotArea(30, 20, 600, 200);

// Add a bar chart layer using the given data
c.addBarLayer(data);

// Set the labels on the x axis.
c.xAxis().setLabels(labels);

// output the chart
String chart1URL = c.makeSession(request, "chart1");

// Include tool tip for the chart
String imageMap1 = c.getHTMLImageMap("", "", "title='{xLabel}: US${value}K'");
%>
<hr color="#000080">
<br>
<img src='<%=response.encodeURL("getchart.jsp?"+chart1URL)%>'
    usemap="#map1" border="0">
<map name="map1"><%=imageMap1%></map>
<%
}
else if (mGraphType.equals("LG"))

{
// Create a XYChart object of size 250 x 250 pixels
XYChart c = new XYChart(650, 250);

// Set the plotarea at (30, 20) and of size 200 x 200 pixels
c.setPlotArea(30, 20, 600, 200);

// Add a line chart layer using the given data
c.addLineLayer(data);

// Set the labels on the x axis.
c.xAxis().setLabels(labels);

// Display 1 out of 3 labels on the x-axis.
//c.xAxis().setLabelStep(3);

// output the chart
String chart1URL = c.makeSession(request, "chart1");

// Include tool tip for the chart
String imageMap1 = c.getHTMLImageMap("", "",
    "title='Hour {xLabel}: Traffic {value} GBytes'");
%>
<hr color="#000080">
<br>
<img src='<%=response.encodeURL("getchart.jsp?"+chart1URL)%>'
    usemap="#map1" border="0">
<map name="map1"><%=imageMap1%></map>
<%
}
//Closing of Graph Type


} //closing of else OFOS
} //closing of else OFAS
} //closing of else AFOS
} //closing of (if x!=null)
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
	}
	catch(Exception e)
	{
//	out.print(qry);
	}

%>
</body>
</html>