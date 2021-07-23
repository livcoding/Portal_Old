<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%

DBHandler db=new DBHandler();
ResultSet rsDate=null,rs=null;
ResultSet rs1=null;
ResultSet rsTmp=null;
ResultSet rs2=null;
String QryExam="";
GlobalFunctions gb =new GlobalFunctions();
String qry="";
String qry2="";
String qry1="",mLTP="";
long mSNo=0;
long mTransDay =0;
String QrySem1="";
String mMemberID="";
String mDMemberID="";
String mMemberType="",mSs="";
String mFactID="",mDateFrom="",mDateTo="",mREmarks="";	
String mDMemberType="",mDsub="",mSF="";
String mFID="",mECode="",mExamFac="",mFName="";
String mMemberCode="",QryLTP1="",mSem1="",mFES="";
String mDMemberCode="";
String mMemberName="",mSem="",msem="",mFaculty1="",mfaculty="",mFac="";
String mInstitute="",mFacultyID,FSTID="";
String mExam="",mSubject="",mexam="",mSubj="",mcolor="",mCode="",mES="",mSubj1="";
String mSection="",mSubsection="",mName1="",mName2="",mName3="",mName4="",mName5="",QryFac="";
String mSExam="",mFaculty="",QryFac1="",Qryexam1="";
String mSES="",mEcode="";
String qryexam="",qrysubj="",qrysec="",qrysem="",QrySem="",QrySubj1="",Qrysubj="";
String mPrn="N",mSubid="";

if (session.getAttribute("InstituteCode")==null)
{
	mInstitute="";
}
else
{
	mInstitute=session.getAttribute("InstituteCode").toString().trim();
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
<TITLE>#### <%=mHead%> [ View/Modify Teaching Load ] </TITLE>

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
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
	
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">

function ChangeOptions1(Exam,Datacombo,Subject,DataComboFac,Faculty)
{	
var fac;
	removeAllOptions1(Subject);
	mflag=0;
	for(i=0;i<Datacombo.options.length;i++)
	{

		var v1;
		var pos;
		var exams;
		var len;
		var facul;
		var v1=Datacombo.options(i).value;
		len= v1.length;
		pos=v1.indexOf('***')
		facul=v1.substring(0,pos);
		exams=v1.substring(pos+3,len);
		if (facul==Exam)
		 { 	if(mflag==0) 
			{
			subj=exams;
			mflag=1;
			}
	
			var optn1 = document.createElement("OPTION");
			optn1.text=Datacombo.options(i).text;
			optn1.value=exams;
			Subject.options.add(optn1);
		}
	}	

	
	 mflag=0;
	 removeAllOptions1(Faculty);
			var optn1 = document.createElement("OPTION");
			optn1.text='ALL';
			optn1.value='ALL';
			Faculty.options.add(optn1);

   	for(i=0;i<DataComboFac.options.length;i++)
       {	
		var v1s;
		var pos1;
		var pos2;
		var exams;
		var scs;
		var lens;
		var scse;
		var otexts;
		var v1s=DataComboFac.options(i).value;

		lens= v1s.length ;	
		pos1=v1s.indexOf('***');
		pos2=v1s.indexOf('///');
		exam=v1s.substring(0,pos1);
		scs=v1s.substring(pos1+3,pos2);
		scse=v1s.substring(pos2+3,lens);

		if (exam==Exam && subj==scs)
		 { 				
			
	
			var optns = document.createElement("OPTION");
			optns.text=DataComboFac.options(i).text;
			optns.value=scse;
			Faculty.options.add(optns);
		}
	}	
}

	
function ChangeCombo(Subject,DataComboFac,Faculty)
  {
   			 removeAllOptions1(Faculty);
			var optn1 = document.createElement("OPTION");
			optn1.text='ALL';
			optn1.value='ALL';
			Faculty.options.add(optn1);
   	for(i=0;i<DataComboFac.options.length;i++)
       {	
		var v1s;
		var pos1;
		var pos2;
		var exams;
		var scs;
		var lens;
		var scse;
		var otexts;
		var v1s=DataComboFac.options(i).value;
		lens= v1s.length ;	
		pos1=v1s.indexOf('***');
		pos2=v1s.indexOf('///')
		exams=v1s.substring(0,pos1);
		scs=v1s.substring(pos1+3,pos2);
		scse=v1s.substring(pos2+3,lens);
		if (Subject==scs)
		 { 				
			var optns = document.createElement("OPTION");
			optns.text=DataComboFac.options(i).text;
			optns.value=scse;
			Faculty.options.add(optns);
		}
	}	
}		
function removeAllOptions1(selectbox)
{
	var i;
	for(i=selectbox.options.length-1;i>=0;i--)
	{
	selectbox.remove(i);
	}
}


</script>

		


<body aLink=#ff00ff bgcolor='#fce9c5' rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
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
	    qry="Select WEBKIOSK.ShowLink('106','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
 	    RsChk= db.getRowset(qry);
	    if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	  	{


  //----------------------
%>
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<table id=id1 width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>View/Modify Teaching Load</b></TD>
</font></td></tr>
</TABLE>
<table id=idd2 cellpadding=1 cellspacing=0 width="100%" align=center rules=groups border=3>
<!--Institute****-->
<Input Type=hidden name=InstCode Value=<%=mInstitute%>>

<!--*********Exam**********-->
<tr><td colspan=4><FONT color=black face=Arial size=2><b>Exam Code</b></FONT>
<%
try
{
      qry="Select Distinct nvl(EXAMCODE,' ') Exam from facultysubjecttagging Where ";
	qry=qry+" nvl(Deactive,'N')='N'";
	
	rs=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		%>
			<Select Name=Exam tabindex="0" id="Exam" style="WIDTH: 120px"  onclick="ChangeOptions1(Exam.value,Datacombo,Subject,DataComboFac,Faculty);" onChange="ChangeCombo(Exam.value,Datacombo,Subject,DataComboFac,Faculty);">
		<%   
		while(rs.next())
		{
			mExam=rs.getString("Exam");
			if(mexam.equals(""))
 			{
			mexam=mExam;
			qryexam=mExam;
			QryExam=mExam;
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
		%>	
		<select name=Exam tabindex="0" id="Exam" style="WIDTH: 120px" onclick="ChangeOptions1(Exam.value,Datacombo,Subject,DataComboFac,Faculty);" onChange="ChangeCombo(Exam.value,Datacombo,Subject,DataComboFac,Faculty);">
		<%
		while(rs.next())
		{
			mExam=rs.getString("Exam");
			if(mExam.equals(request.getParameter("Exam").toString().trim()))
 			{
				mexam=mExam;
				qryexam=mExam;
				QryExam=mExam;
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
<!--***************Subject*********************-->
<FONT color=black face=Arial size=2><b>Subject</b>&nbsp;</FONT>
<%	
	qry=" Select Distinct nvl(A.subjectid,' ') subjectid, A.examcode examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject,B.subject subject1 ";
	qry=qry+" from  facultysubjecttagging A,Subjectmaster B where A.subjectid=B.subjectid and A.examcode='"+qryexam+"'order by subject1";
	rs=db.getRowset(qry);
	//out.print(qry);
	%>
	<select name=Subject tabindex="5" id="Subject" style="WIDTH: 360px" onclick="ChangeCombo(Subject.value,DataComboFac,Faculty);" onChange="ChangeCombo(Subject.value,DataComboFac,Faculty);">
	<% 
	if (request.getParameter("x")==null) 
	{
		while(rs.next())
		{
		mSubj1=rs.getString("subjectid");
		if(qrysubj.equals(""))
		{
		  qrysubj=mSubj1;
              Qrysubj=mSubj1;
 		%>
			<OPTION selected Value ='<%=mSubj1%>'><%=rs.getString("subject")%></option>
		<%
		}
		else
		{
 		%>
			<OPTION Value ='<%=rs.getString("subjectid")%>'><%=rs.getString("subject")%></option>
		<%
		}
         }
     }
     else
     {
		while(rs.next())
		{
			mSubj1=rs.getString("subjectid");
			if (mSubj1.equals(request.getParameter("Subject").toString().trim()))
			{
			qrysubj=mSubj1;
     	            Qrysubj=mSubj1;
		%>
			<OPTION selected Value ='<%=mSubj1%>'><%=rs.getString("subject")%></option>
		<%
		}
		else
		{
		%>
      		<OPTION Value ='<%=mSubj1%>'><%=rs.getString("subject")%></option>
     		<%			
	   	}
	}
  }
%>
</select>
<!--**********************************Datacombo**********************-->
<%	
	qry=" Select Distinct nvl(A.subjectid,' ') subjectid,nvl(B.subjectcode,' ') subjectcode,A.examcode examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
	qry=qry+" from  facultysubjecttagging A,Subjectmaster B where A.Subjectid=B.Subjectid order by examcode,subjectcode";
	rs=db.getRowset(qry);
%>
	<select name=Datacombo tabindex="5" id="Datacombo" style="WIDTH:0px">	
<% 	
	if (request.getParameter("x")==null) 
	{
		while(rs.next())
		{
		  mExam=rs.getString("subjectid");
		  mCode=rs.getString("examcode");
		  mES=mCode+"***"+mExam;
 		%>
			 <OPTION selected Value ='<%=mES%>'><%=rs.getString("subject")%></option> 
		<%
		}
	 }
	else
	{
		while(rs.next())
		{
			mExam=rs.getString("subjectid");
			mCode=rs.getString("examcode");
			mES=mCode+"***"+mExam;
			if (mExam.equals(request.getParameter("Datacombo").toString().trim()))
			{
		%>
			<OPTION selected Value ='<%=mES%>'><%=rs.getString("subject")%></option> 
		<%
		}
		else
		{
		%>
      		 <OPTION  Value ='<%=mES%>'><%=rs.getString("subject")%></option>
     		<%			
	   	}
	}
  }
%>
</select>

</td></tr>
<tr>
<td colspan=4>
<!--********DataComboFac***********-->
<%
try
{ 
	qry=" Select Distinct A.EmployeeID EmployeeID,A.examcode examcode,A.subjectid subjectid, B.EmployeeName EmployeeName";
	qry=qry+" from facultysubjecttagging A,EmployeeMaster B where A.employeeid=B.employeeid order by examcode,Subjectid,EmployeeID";
	rs=db.getRowset(qry);
	if (request.getParameter("DataComboFac")==null)
	{
		%>
		<select name='DataComboFac' id="DataComboFac" style="WIDTH: 0px">	
		<%   
		while(rs.next())
		{
                  mEcode=rs.getString("examcode");
			mFacultyID=rs.getString("EmployeeID");
			mDsub=rs.getString("subjectid");
			mSF=mEcode+"***"+mDsub+"///"+mFacultyID;
              	mFaculty=rs.getString("EmployeeName");
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
			mEcode=rs.getString("examcode");

			mFacultyID=rs.getString("EmployeeID");
			mDsub=rs.getString("subjectid");
			mSF=mEcode+"***"+mDsub+"///"+mFacultyID;
              	mFaculty=rs.getString("EmployeeName");


			if(mSF.equals(request.getParameter("DataComboFac").toString().trim()))
 			{
				mfaculty=mFacultyID;
				%>
				
                        <OPTION  selected Value =<%=mSF%>><%=mFaculty%></option>

				<%			
		     	}
		     	else
		      {
				%>
	
                        <OPTION  Value =<%=mSF%>><%=mFaculty%></option>


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
<!-----***************Faculty**********************-->
<FONT color=black face=Arial size=2><b>Faculty</b>&nbsp;</FONT>
<select name=Faculty tabindex="1" id="Faculty" style="WIDTH: 250px">
<%
	qry=" Select Distinct A.EmployeeID EmployeeID,B.EmployeeName EmployeeName,A.subjectid subjectid ";
	qry=qry+" from facultysubjecttagging A,EmployeeMaster B where A.employeeid=B.employeeid and A.examcode='"+qryexam+"'and A.subjectid='"+Qrysubj+"' order by 2";
	rs=db.getRowset(qry);
	
      if (request.getParameter("x")==null) 
	{
%>
	      <OPTION selected Value=ALL>ALL</option>		
<%
      	 while(rs.next())
		{
       	mFaculty=rs.getString("EmployeeID");
            QryFac=mFaculty;
%>
		<OPTION  Value ='<%=mFaculty%>'><%=rs.getString("EmployeeName")%></option>
<%
		}
	}
	else
	{	
	if (request.getParameter("Faculty").toString().trim().equals("ALL")) 
	{
%>
	<OPTION selected Value=ALL>ALL</option>
<%
	}
	else
	{
%>
	<OPTION selected Value=ALL>ALL</option>
<%
	}
		while(rs.next())
	{
             mFaculty=rs.getString("EmployeeID");
	       QryFac=mFaculty;
		if(mFaculty.equals(request.getParameter("Faculty").toString().trim()))
		{
		%>
		
			<OPTION selected Value ='<%=mFaculty%>'><%=rs.getString("EmployeeName")%></option>
		<%
		}
		else
		{
 		%>
			<OPTION Value ='<%=rs.getString("EmployeeID")%>'><%=rs.getString("EmployeeName")%></option>
		<%
		}
	}
}
%>
</select>
<!--***************LTP*********************-->
&nbsp; <FONT color=black face=Arial size=2>
	<STRONG>LTP</STRONG>&nbsp;</FONT>
&nbsp;
<select name="LTP" tabindex="7" id="LTP" style="WIDTH: 120px">
<% 	if(request.getParameter("x")==null)
   	{
 %>	
			
	<OPTION Value =L selected>Lecture</option>
	<OPTION Value =T>Tutorial</option>
	<OPTION Value =P>Practical</option>
<%
  	}
  else
   {
	mLTP=request.getParameter("LTP");
	if(mLTP.equals("L"))
	{
%>
	<OPTION Value =L selected>Lecture</option>
	<OPTION Value =T>Tutorial</option>
	<OPTION Value =P>Practical</option>
<%
      }
	else if(mLTP.equals("T"))
	{
	%>
	<OPTION Value =L selected>Lecture</option>
	<OPTION Selected Value =T>Tutorial</option>
	<OPTION Value =P>Practical</option>
	<%		
	}
	else if(mLTP.equals("P"))
	{
	%>
	<OPTION Value =L selected>Lecture</option>
	<OPTION Value =T>Tutorial</option>
	<OPTION Value =P Selected>Practical</option>
	<%		
	}
    }		
	%>
</select>
&nbsp; 
<INPUT Type="submit" Value="Show/Refresh">
	</td></tr>
	</table>
	</form>


	<table bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=group/s topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center>	
	<thead>
	<tr bgcolor="#ff8c00">
	<td Title="Click to Sort on SlNo"><font color="White"><b>SNo.</b></font></td>
	<td Title="Click to Sort on Faculty Name"><font color="White"><b>Faculty</b></font></td>
	<td Title="Click to Sort on Subject"><font color="White"><b>Subject</b></font></td>	
	<td Title="Click to Sort on LTP"><font color="White"><b>LTP</b></font></td>
	<td Title="Click to Sort on Semester"><font color="White"><b>Semester</b></font></td>	
	<td Title="Click to Sort on Section/Group"><font color="White"><b>Section Group</b></font></td>
        <td><font color="White"><b>Edit/Modify</b></font></td>
	</tr>
	</thead>
	<tbody>
	<%
	if(request.getParameter("x")!=null)
	{
	if(request.getParameter("Exam")==null)
	{
	Qryexam1=QryExam;
	}
	else
	{
	Qryexam1=request.getParameter("Exam");
	}

	if(request.getParameter("Subject")==null)
	{
	QrySubj1=Qrysubj;
	}
	else
	{
	QrySubj1=request.getParameter("Subject");
	}

	if(request.getParameter("Faculty")==null)
	{
	QryFac1="All";
	}
	else
	{
	QryFac1=request.getParameter("Faculty");
	}

	QryLTP1=request.getParameter("LTP");
	QrySem1=request.getParameter("SEMESTER");
 	
      qry="select distinct A.employeeid employeeid,A.subjectid subjectid, C.SubjectCode  SubjectCode,A.LTP LTP,A.Semester Semester,A.FSTID FSTID,A.SECTIONBRANCH||'-'||A.SUBSECTIONCODE SECTIONBRANCH,B.EMPLOYEENAME EMPLOYEENAME";
      qry=qry+" from facultysubjecttagging A,EmployeeMaster B, SubjectMaster C where A.EmployeeID=B.EmployeeID and A.SubjectID=C.SubjectID and A.examcode='"+Qryexam1+"' and A.employeeid=decode('"+QryFac1+"','ALL',A.employeeid,'"+QryFac1+"')";
      qry=qry+" and A.SubjectID ='"+QrySubj1+"'and A.Ltp='"+QryLTP1+"'";	
      rs1=db.getRowset(qry);	
 	int Ctr=0;
	while(rs1.next())
	 {
			Ctr++;
			mcolor="Black";
			%>
			<tr>
			<td><font color=<%=mcolor%>><%=Ctr%></font></td>
			<td><font color=<%=mcolor%>><%=rs1.getString("EMPLOYEENAME")%></font>
			<td><font color=<%=mcolor%>><%=rs1.getString("SubjectCode")%></font></td>
			<td><font color=<%=mcolor%>><%=rs1.getString("LTP")%></font></td>		
			<td><font color=<%=mcolor%>><%=rs1.getString("Semester")%></font>		
			<td><font color=<%=mcolor%>><%=rs1.getString("SECTIONBRANCH")%></font>
	     		<td align=center><a href =FacultyLoadModify.jsp?INST=<%=mInstitute%>&amp;FSTID=<%=rs1.getString("FSTID")%>>EDIT</a></td>
 			</tr>		
			<%
		 } //closing of while
	} //closing of outer x	
		%>
		</tbody>
		</table>
		<script type="text/javascript">
			var st1 = new SortableTable(document.getElementById("table-1"),["Number", "CaseInsensitiveString", "CaseInsensitiveString", "CaseInsensitiveString", "CaseInsensitiveString", "CaseInsensitiveString"]);
		</script>
		<%
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
 // out.print(qry);
}
%>
</body>
</html>









