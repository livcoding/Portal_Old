<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
ResultSet rs2=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="";
String qry2="";
String qry1="",mLTP="",mBasket="",mTagg="";
long mSNo=0;
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInstitute="";
String mExam="",mSubject="",mexam="",mSubj="",mGroup="",mcolor="",mCode="",mES="",mSubj1="";
String mStudent="",mSubStudent="",mName1="",mName2="",mName3="",mName4="",mName5="";
String mSExam="",mInst="";
String mSES="";
String qryexam="",qrysubj="",qrysec="";
String mPrn="N";
if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
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

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Subjectwise Students List ] </TITLE>

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
function ChangeOptions(Exam,DataCombo,Subject,DataComboSec,Student)
  {
    removeAllOptions(Subject);
	var subj='ALL';
	var mflag=0;
	var ssec='ALL';
		var optn = document.createElement("OPTION");
			optn.text='ALL';
			optn.value='ALL';
		Subject.options.add(optn);

	for(i=0;i<DataCombo.options.length;i++)
       {	
		var v1;
		var pos;
		var exam;
		var sc;
		var len;
		var otext;
		var v1=DataCombo.options(i).value;
		len= v1.length ;	
		pos=v1.indexOf('***');
		exam=v1.substring(0,pos);
		sc=v1.substring(pos+3,len);
		if (exam==Exam)		 { 	
			var optn = document.createElement("OPTION");
			optn.text=DataCombo.options(i).text;
			optn.value=sc;			
			Subject.options.add(optn);
		}
	}
	removeAllOptions(Student);
	 mflag=0;
	var optns = document.createElement("OPTION");
	optns.text='ALL';
	optns.value='ALL';
	Student.options.add(optns);
	ssec='ALL';
	var oldscse='?';
	for(i=0;i<DataComboSec.options.length;i++)
       {	
		
		var v1s;
		var pos1;
		var pos2;
		var exams;
		var scs;
		var lens;
		var scse;
		var otexts;
		var v1s=DataComboSec.options(i).value;
		lens= v1s.length ;	
		pos1=v1s.indexOf('***');
		pos2=v1s.indexOf('///')
		exams=v1s.substring(0,pos1);
		scs=v1s.substring(pos1+3,pos2);
		scse=v1s.substring(pos2+3,lens);
		if (exams==Exam && scse!=oldscse)
		 { 	
			var optns = document.createElement("OPTION");
			optns.text=DataComboSec.options(i).text;
			optns.value=scse;
			Student.options.add(optns);
			oldscse=scse;
		}
	}	
		
	
}

//********Click event on subject**********
function ChangeSubject(Exam,subj,DataComboSec,Student)
  {
    
	var mflag=0;
	var ssec='ALL';
	
	removeAllOptions(Student);
	 mflag=0;
			var optns = document.createElement("OPTION");
			optns.text='ALL';
			optns.value='ALL';
			Student.options.add(optns);
			ssec='ALL';
			var oldsec='?';
	for(i=0;i<DataComboSec.options.length;i++)
       {	
		var v1s;
		var pos1;
		var pos2;
		var exams;
		var scs;
		var lens;
		var scse;
		var otexts;
		var v1s=DataComboSec.options(i).value;
		lens= v1s.length ;	
		pos1=v1s.indexOf('***');
		pos2=v1s.indexOf('///')
		exams=v1s.substring(0,pos1);
		scs=v1s.substring(pos1+3,pos2);
		scse=v1s.substring(pos2+3,lens);
		if (exams==Exam && oldsec!=scse)
		{   
			
		if(subj=='ALL')
		 { 		oldsec=scse;		
			var optns = document.createElement("OPTION");
			optns.text=DataComboSec.options(i).text;
			optns.value=scse;
			Student.options.add(optns);
		}
		else if(subj==scs)
		 { 	oldsec=scse;			
			var optns = document.createElement("OPTION");
			optns.text=DataComboSec.options(i).text;
			optns.value=scse;
			Student.options.add(optns);
		}
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
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
try
{
if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{	OLTEncryption enc=new OLTEncryption();
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
		qry="Select WEBKIOSK.ShowLink('85','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
 	    RsChk= db.getRowset(qry);
		  if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	  	{
		

  //----------------------
%>
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<table id=id1 width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Faculty cum Subject wise Students List (Class Strength)</b></TD>
</font></td></tr>
</TABLE>
<table id=idd2 cellpadding=1 cellspacing=0 width="100%" align=center rules=groups border=3>
<!--Institute****-->
<Input Type=hidden name=InstCode Value=<%=mInst%>>
<!--*********Exam**********-->
<tr><td nowrap><FONT color=black face=Arial size=2><b>Exam Code</b></FONT>

		<Select Name=Exam tabindex="0" id="Exam" style="WIDTH: 150px" onclick="ChangeOptions(Exam.value,DataCombo,Subject,DataComboSec,Student);" onChange="ChangeOptions(Exam.value,DataCombo,Subject,DataComboSec,Student);">	
		<%   

try
{
	 qry="Select Distinct nvl(EXAMCODE,' ') Exam , EXAMPERIODFROM from EXAMMASTER Where institutecode='"+mInst+"' and ";
	 qry=qry+" nvl(Deactive,'N')='N' and Nvl(LOCKEXAM,'N')='N' and Nvl(FINALIZED,'N')='N' order by EXAMPERIODFROM DESC";
     //out.print(qry);
	rs=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		
		while(rs.next())
		{
			mExam=rs.getString("Exam");
			if(mexam.equals(""))
 			{
			mexam=mExam;
			qryexam=mExam;
			%>
			<OPTION Selected Value =<%=mExam%>><%=rs.getString("Exam")%></option>
			<%
			}
			else
			{
			%>
			<OPTION Value =<%=mExam%>><%=rs.getString("Exam")%></option>
			<%

			}
		}
		%>
		</select>
		<%
	}
	else
	{
		
		while(rs.next())
		{
			mExam=rs.getString("Exam");
			if(mExam.equals(request.getParameter("Exam").toString().trim()))
 			{
				mexam=mExam;
				qryexam=mExam;
				%>
				<OPTION selected Value =<%=mExam%>><%=rs.getString("Exam")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mExam%>><%=rs.getString("Exam")%></option>
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
%>
<!--******************DataCombo**************-->
<%
try														
{ 
	qry=" Select Distinct nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
	qry=qry+" from  facultysubjecttagging A,SUBJECTMASTER B where  ";
	//qry=qry+" A.facultytype=decode('"+mDMemberType+"','E','I','E') and ";
	qry=qry+" A.institutecode='"+mInst+"' and A.examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
	qry=qry+" and nvl(FINALIZED,'N')='Y' and NVL(DEACTIVE,'N')='Y' )  AND NVL (A.deactive, 'N') = 'N'  AND NVL (B.deactive, 'N') = 'N' AND A.Institutecode=B.Institutecode AND A.SUBJECTID=B.SUBJECTID";
	qry=qry+" order by subject";
	rs=db.getRowset(qry);
	//out.print(qry);
	if (request.getParameter("x")==null) 
	{
	 %>
		<Select Name=DataCombo tabindex="0" id="DataCombo" style="WIDTH: 0px">	
		<%   
		while(rs.next())
		{
			mExam=rs.getString("subjectid");
			mCode=rs.getString("examcode");
			mES=mCode+"***"+mExam;
			%>
			<OPTION Value=<%=mES%>><%=rs.getString("subject")%></option>
			<%
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<Select Name=DataCombo tabindex="0" id="DataCombo" style="WIDTH: 0px">	
		<%
		while(rs.next())
		{
			mExam=rs.getString("subjectid");
			mCode=rs.getString("examcode");
			mES=mCode+"***"+mExam;

			if(mExam.equals(request.getParameter("DataCombo").toString().trim()))
 			{
				%>
				<OPTION selected Value=<%=mES%>><%=rs.getString("subject")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value=<%=mES%>><%=rs.getString("subject")%></option>
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

//----***************Subject**********************
%>
<FONT color=black face=Arial size=2><b>Subject</b> </FONT>
<%	
	qry=" Select Distinct nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,B.subject sbj, nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
	qry=qry+" from  facultysubjecttagging A,SUBJECTMASTER B where  ";
	//qry=qry+"  A.facultytype=decode('"+mDMemberType+"','E','I','E') and ";
	qry=qry+" A.institutecode='"+mInst+"' and A.examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
	qry=qry+" and nvl(FINALIZED,'N')='Y' and NVL(DEACTIVE,'N')='Y' ) AND A.institutecode=B.institutecode AND A.SUBJECTID=B.SUBJECTID";
	qry=qry+" and A.EXAMCODE='"+qryexam+"'  AND NVL (A.deactive, 'N') = 'N'            AND NVL (B.deactive, 'N') = 'N' order by subject";
	//out.print(qry);
	rs=db.getRowset(qry);

%>
	<select name=Subject tabindex="0" id="Subject" style="WIDTH: 330px"
	onclick="ChangeSubject(Exam.value,Subject.value,DataComboSec,Student);" 
	onChange="ChangeSubject(Exam.value,Subject.value,DataComboSec,Student);">	
<% 
if (request.getParameter("x")==null) 
{
%>
	<OPTION selected Value=ALL>ALL</option>
<%
	qrysubj="ALL";
	while(rs.next())
	{
		if(mSubj1.equals(""))
		{
		  mSubj1=rs.getString("subjectid");
			
 		%>
			<OPTION Value ="<%=mSubj1%>"><%=rs.getString("subject")%></option>
		<%
		}
		else
		{
 		%>
			<OPTION Value ="<%=rs.getString("subjectid")%>"><%=rs.getString("subject")%></option>
		<%
		}
	}
}
else
{		
	if (request.getParameter("Subject").toString().trim().equals("ALL"))
 		{
		qrysubj="ALL";
	
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
			mSubj1=rs.getString("subjectid");
			if (mSubj1.equals(request.getParameter("Subject").toString().trim()))
			{
			qrysubj=mSubj1;
		%>
			<OPTION selected Value ="<%=mSubj1%>"><%=rs.getString("subject")%></option>
		<%
		}
		else
		{
		%>
      		<OPTION Value ="<%=mSubj1%>"><%=rs.getString("subject")%></option>
     		<%			
	   	}
	}
  }
%>
</select>
</td>

<td>

<%
%>
 <!******************Sub Group/Sub Student**************-->
<FONT color=black><FONT face=Arial size=2><STRONG>Student Name </STRONG></FONT></FONT>

<select name="Student" tabindex="0" id="Student" style="WIDTH: 90px" >	
<%
try
{ 
	
	qry1=qry1+" select Distinct STUDENTID, ENROLLMENTNO, STUDENTNAME from  v#studentltpdetail where  ";
	qry1=qry1+" institutecode='"+mInst+"' and fstid in (select fstid from facultysubjecttagging where institutecode='"+mInst+"' and   NVL(DEACTIVE,'N')='N' )  and  NVL(DEACTIVE,'N')='N'  and NVL(STUDENTDEACTIVE,'N')='N'	";
	qry1=qry1+" and examcode='"+qryexam+"' and subjectid=decode('"+qrysubj+"','ALL',subjectid,'"+qrysubj+"') order by ENROLLMENTNO";
	//out.print(qry1);
	rs1=db.getRowset(qry1);
	if (request.getParameter("x")==null) 
	{
		%>
		
		<option selected value='ALL'>ALL</option>
		<%   
			qrysec="ALL";
		while(rs1.next())
		{
			mSubj=rs1.getString("STUDENTID");
		
			%>
			<OPTION Value =<%=mSubj%>><%=rs1.getString("ENROLLMENTNO")%>-<%=rs1.getString("STUDENTNAME")%></option>
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		
		if(request.getParameter("Student").toString().trim().equals("ALL"))
		{
		%>
		<option selected value='ALL'>ALL</option>
	
		<%   
			qrysec="ALL";
		}
		else
		{
		%>
			<option value='ALL'>ALL</option>

		<%
		}

		while(rs1.next())
		{
			mSubj=rs1.getString("STUDENTID");
			if(mSubj.equals(request.getParameter("Student").toString().trim()))
 			{
				qrysec=mSubj;
				%>
				<OPTION selected Value ="<%=mSubj%>"><%=rs1.getString("ENROLLMENTNO")%>-<%=rs1.getString("STUDENTNAME")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value ="<%=mSubj%>"><%=rs1.getString("ENROLLMENTNO")%>-<%=rs1.getString("STUDENTNAME")%></option>
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




//**********************DataComboSec***************

try
{ 
	qry1=" select Distinct STUDENTID, ENROLLMENTNO, STUDENTNAME,subjectid,examcode from  v#studentltpdetail where  ";
	//qry1=qry1+"  facultytype=decode('"+mDMemberType+"','E','I','E') and ";
	qry1=qry1+" institutecode='"+mInst+"' and fstid in (select fstid from facultysubjecttagging where institutecode='"+mInst+"' and   NVL(DEACTIVE,'N')='N' )  and  NVL(DEACTIVE,'N')='N'  and NVL(STUDENTDEACTIVE,'N')='N'   ";
	qry1=qry1+" order by ENROLLMENTNO";
		out.print(qry1);
	
	rs1=db.getRowset(qry1);

	if (request.getParameter("x")==null) 
	{
		%>
		<select name=DataComboSec tabindex="0" id="DataComboSec" style="WIDTH: 0px">	
		<%   
		while(rs1.next())
		{
			mSubj=rs1.getString("subjectid");
			mSExam=rs1.getString("examcode");
			mSES=mSExam+"***"+mSubj+"///"+rs1.getString("STUDENTID");

			%>
			<OPTION Value ="<%=mSES%>"><%=rs1.getString("ENROLLMENTNO")%>-<%=rs1.getString("STUDENTNAME")%></option>
			
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name=DataComboSec tabindex="0" id="DataComboSec" style="WIDTH:0px">	
		<%
		while(rs1.next())
		{
			mSubj=rs1.getString("subjectid");
			mSExam=rs1.getString("examcode");
			mSES=mSExam+"***"+mSubj+"///"+rs1.getString("STUDENTID");

			if(mSES.equals(request.getParameter("DataComboSec").toString().trim()))
 			{
				%>
				<OPTION selected Value ="<%=mSES%>"><%=rs1.getString("ENROLLMENTNO")%>-<%=rs1.getString("STUDENTNAME")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value ="<%=mSES%>"><%=rs1.getString("ENROLLMENTNO")%>-<%=rs1.getString("STUDENTNAME")%></option>
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
</tr>
</table>
	<%
	if(request.getParameter("x")!=null)
	{




	}


      // }
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
//	out.print("error"+qry);	
}
%>
</body>
</html>
