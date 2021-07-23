<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.*" %>
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
<TITLE>#### <%=mHead%> [ View Exam Time Table ] </TITLE>



<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

<script language=javascript>

	function RefreshContents()
	{ 	
    	document.frm.x.value='ddd';
    	document.frm.submit();
	}
//-->
</SCRIPT>

<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">

function ChangeOptions(Exam,FacultyID,DataCombo,FacultyIDShow,Subject)
{   
    removeAllOptions(FacultyIDShow);	
	var QryEvent='';
     for(i=0;i<FacultyID.options.length;i++)
       {
		var v1;
		var pos;
		var ec;
		var ev;
		var len;
		var otext;
		var v1=FacultyID.options(i).value;
		len= v1.length ;	
		pos=v1.indexOf('***');
		ec=v1.substring(0,pos);
		ev=v1.substring(pos+3,len);
		if (ec==Exam)
		  { 	
			var optn = document.createElement("OPTION");
			optn.text=FacultyID.options(i).text;
			optn.value=ev;
			if (QryEvent=='') QryEvent=ev;
			FacultyIDShow.options.add(optn);
		  }
	 }

		removeAllOptions(Subject);	

		var optn1 = document.createElement("OPTION");
			optn1.text='ALL';
			optn1.value='ALL';
			Subject.options.add(optn1);
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
			Subject.options.add(optns);
			}	
		}
  	}
// ----------click event on EventSubevent------------

function ChangeOptions1(Exam,QryEvent,DataCombo,Subject)
{   
   removeAllOptions(Subject);	

			var optn = document.createElement("OPTION");
			optn.text='ALL';
			optn.value='ALL';
			Subject.options.add(optn);

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
				Subject.options.add(optns1);
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
String mDMemberCode="",mDMemberType="",mDept="",mDesg="",mInst="",mDMemberID="";
String mExam="",mexam="",mExamid="",mFacltyID="",mSubj="",msubj="";
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
String mFacltyID1="",mSubj1="",qrymExamid="",examidm="",msubj1="";
String mType="";
int mRights=0;
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

	if (request.getParameter("Type")==null)
{
	mType = "";
}
else
{
	mType = request.getParameter("Type").toString().trim();
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

	if(mType.equals("D"))
	{
	   mRights=135;
	}
	else if(mType.equals("H"))
	{
	   mRights=136; 	
	}
	else if(mType.equals("I"))
	{
	   mRights=137;
	}
	qry="Select WEBKIOSK.ShowLink('"+mRights+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
    RsChk1= db.getRowset(qry);
//	out.println(qry);
	if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
	{
  //----------------------
%>	

	<table  ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>View Exam Time Table</b></font></td></tr>
	</table>

<form name="frm" method=get>
<table cellpadding=1 cellspacing=0  align=center rules=groups border=3>
	<input id="x" name="x" type=hidden>
<tr><td nowrap>
	<%
	if(!mDesg.equals("DEAN"))
	{
	%>
	<font color=Green face=arial size=2><STRONG>&nbsp;<%=mMemberName%> [<%=mDMemberCode%>]
	&nbsp;: &nbsp; &nbsp;<%=GlobalFunctions.toTtitleCase(mDesg)%>&nbsp; (<%=mDept%>)
	<%
	}
	else
	{
	%>
	<font color=Green face=arial size=2><STRONG>&nbsp;<%=mMemberName%> [<%=mDMemberCode%>]
	&nbsp;: &nbsp; &nbsp;<%=mDesg%>&nbsp; (<%=mDept%>)
	<%
	}
	%>
	<!-- Institute *******************-->
	<INPUT Type="hidden" Name=Type id=Type Value=<%=mType%>>
	<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
	</td>
</tr>

<tr>
	<td nowrap>

<!--************************************* Exam ********************************-->

	<FONT color=black><FONT face=Arial size=2><STRONG>&nbsp;Exam Code : </STRONG></FONT></FONT>
<%  
	try
	{

if(mType.equals("D"))
	{
	  qry="select distinct EXAMCODE GRADEENTRYEXAMID from TT#TIMETABLEDATA order by examcode desc";
	  /*
		qry=qry+" where (fstid) in (select fstid from  facultysubjecttagging where "; 
		qry=qry+" facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"'";
		qry=qry+" and nvl(deactive,'N')='N' AND LTP='L') order by examcode desc";  
	  */
	}
	else if(mType.equals("H"))
	{
	qry="select distinct EXAMCODE GRADEENTRYEXAMID from TT#TIMETABLEDATA where ";
	qry=qry+" (fstid) in (select fstid from  facultysubjecttagging where "; 
	qry=qry+"  facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid in (select employeeid from V#STAFF where departmentcode='"+mDept+"')";
	qry=qry+" and nvl(deactive,'N')='N') order by examcode desc";  

	}
	else 
	{
	qry="select distinct EXAMCODE GRADEENTRYEXAMID  from TT#TIMETABLEDATA where ";
	qry=qry+" (fstid) in (select fstid from  facultysubjecttagging where "; 
	qry=qry+"  facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"'";
	qry=qry+" and nvl(deactive,'N')='N') order by examcode desc ";  
	}
	
		rs=db.getRowset(qry);
//		out.println("######### "+mType);
//		out.print(qry);
		if (request.getParameter("x")==null)
		{
		%>
			<select name=Exam tabindex="0" id="Exam" style="WIDTH: 150px" onclick="ChangeOptions(Exam.value,FacultyID,DataCombo,FacultyIDShow,Subject);" onChange="ChangeOptions(Exam.value,FacultyID,DataCombo,FacultyIDShow,Subject);">	
			
		<%   
			while(rs.next())
			{
				mExamid=rs.getString("GRADEENTRYEXAMID");
				if(examidm.equals(""))
				{
				examidm=mExamid;
				qrymExamid=mExamid;
			%>

				<option  Value =<%=mExamid%>><%=mExamid%></option>
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
		<select name=Exam tabindex="0" id="Exam" style="WIDTH: 150px" onclick="ChangeOptions(Exam.value,FacultyID,DataCombo,FacultyIDShow,Subject);" onChange="ChangeOptions(Exam.value,FacultyID,DataCombo,FacultyIDShow,Subject);">
	<%
		while(rs.next())
			{
				mExamid=rs.getString("GRADEENTRYEXAMID");
				
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
	    //out.println("Before Facultyid 1"+e.getMessage());
	}

//********************FacltyID Combo(FacultyID)*************/
try
{
	if(mType.equals("D"))
	{
		qry="select distinct A.FACULTYID,B.employeename employeename ,A.examcode ";
		qry=qry+" from TT#TIMETABLEDATA A, V#Staff B  where A.FACULTYID=B.EMPLOYEEID order by examcode, A.FACULTYID";
	}
	else if(mType.equals("H"))
	{
		qry="select distinct A.FACULTYID,B.employeename employeename ,examcode from TT#TIMETABLEDATA A, V#Staff B where ";
		qry=qry+" (A.fstid) in (select fstid from  facultysubjecttagging where ";
		qry=qry+" facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid in (select employeeid from V#STAFF where departmentcode='"+mDept+"') ";
		qry=qry+"and nvl(deactive,'N')='N') and A.FACULTYID=B.EMPLOYEEID  order by examcode";  
	
	}
	else if(mType.equals("I"))
	{
		qry="select distinct A.FACULTYID,B.employeename employeename ,examcode from TT#TIMETABLEDATA A, V#Staff B where ";
		qry=qry+" (A.fstid) in (select fstid from  facultysubjecttagging where ";
		qry=qry+" facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"' ";
		qry=qry+"and nvl(deactive,'N')='N') and A.FACULTYID=B.EMPLOYEEID order by examcode";  
	}

	rse=db.getRowset(qry);
 //	out.print(qry);
	if (request.getParameter("x")==null) 
	{
%>
	<select name=FacultyID tabindex="0" id="FacultyID" style="WIDTH: 0px">
<%   
		while(rse.next())
			{
			mFacltyID1 = rse.getString("examcode")+"***"+rse.getString("FACULTYID");
			
		%>
			<option Value=<%=mFacltyID1%>> <%=rse.getString("employeename")%> </option> 
		<%			
			}
%>
  </select>
<%		
	}
	else
	{
%>
	<select name=FacultyID tabindex="0" id="FacultyID" style="WIDTH: 0px">
<%
		
		while(rse.next())
		{
		 mFacltyID1=rse.getString("examcode")+"***"+rse.getString("FACULTYID");
			if(mFacltyID1.equals(request.getParameter("FacultyID").toString().trim()))
 			{
			%>
				<option selected Value = <%=mFacltyID1%> > <%=rse.getString("employeename")%> </option>
			<%			
		     }
		      else
		      {
				%>
		      	<option Value = <%=mFacltyID1%>> <%=rse.getString("employeename")%> </option>  
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
&nbsp;&nbsp;
<FONT color=black><FONT face=Arial size=2><STRONG>Faculty : </STRONG></FONT></FONT>
<%    try{
	
	if(mType.equals("D"))
	{
	qry="select distinct A.FACULTYID,B.employeename employeename from TT#TIMETABLEDATA A, ";
      qry=qry+" V#Staff B  where A.FACULTYID=B.EMPLOYEEID and EXAMCODE = '"+qrymExamid+"' order by EMPLOYEENAME ";
	}
	else if(mType.equals("H"))
	{
	qry="select distinct A.FACULTYID,B.employeename employeename from TT#TIMETABLEDATA A, V#Staff B where ";
	qry=qry+" (A.fstid) in (select fstid from  facultysubjecttagging where ";
	qry=qry+" facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid in (select employeeid from V#STAFF where departmentcode='"+mDept+"') ";
	qry=qry+" and nvl(deactive,'N')='N') and EXAMCODE = '"+qrymExamid+"' and A.FACULTYID=B.EMPLOYEEID order by EMPLOYEENAME";  
	}
	else 
	{
	qry="select distinct A.FACULTYID,B.EMPLOYEENAME EMPLOYEENAME from TT#TIMETABLEDATA A,V#STAFF B where ";
	qry=qry+" (A.fstid) in (select "; 
	qry=qry+" fstid from  facultysubjecttagging  ";
	qry=qry+" where facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"' and nvl(deactive,'N')='N') ";  
	qry=qry+"AND A.FACULTYID=B.EMPLOYEEID and EXAMCODE = '"+qrymExamid+"' order by EMPLOYEENAME";
	}
	rse=db.getRowset(qry);

 //	out.print(qry);

	if (request.getParameter("x")==null) 
	{
	%>
		<select name=FacultyIDShow tabindex="0" id="FacultyIDShow" style="WIDTH: 250px" onclick="ChangeOptions1(Exam.value,FacultyIDShow.value,DataCombo,Subject);" onChange="ChangeOptions1(Exam.value,FacultyIDShow.value,DataCombo,Subject);">
	<%   

		while(rse.next())
		{
			mFacltyID=rse.getString("FACULTYID");
			if(qrymEventsubevent.equals(""))	
			{		
				qrymEventsubevent=mFacltyID;
			%>
			<OPTION selected Value = <%=mFacltyID%>><%=rse.getString("EMPLOYEENAME")%></option>
			<%	
			}
			
			else
			{
			%>
			<OPTION  Value = <%=mFacltyID%>><%=rse.getString("EMPLOYEENAME")%></option>
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

<select name=FacultyIDShow tabindex="0" id="FacultyIDShow" style="WIDTH: 250px" onclick="ChangeOptions1(Exam.value,FacultyIDShow.value,DataCombo,Subject);" onChange="ChangeOptions1(Exam.value,FacultyIDShow.value,DataCombo,Subject);">

	<%
		
		while(rse.next())
		{
			mFacltyID=rse.getString("FACULTYID");
			if(mFacltyID.equals(request.getParameter("FacultyIDShow").toString().trim()))
 			{
				qrymEventsubevent=mFacltyID;
			%>
			 <OPTION selected value= <%=mFacltyID%>> <%=rse.getString("EMPLOYEENAME")%> </option>
				<%			
		    }
		    else
		      {
				%>
				
		      	<OPTION Value= <%=mFacltyID%> > <%=rse.getString("EMPLOYEENAME")%> </option>
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
</tr>
<tr>
	<td nowrap>
<%
//******************DataCombo Subject********************/
try
	{
	if(mType.equals("D"))
	{
		qry="select distinct B.SUBJECT, A.SUBJECTID subjectid, B.SUBJECTCODE subjectcode,A.examcode,FACULTYID ";
		qry=qry+ " from TT#TIMETABLEDATA A, SUBJECTMASTER B where ";
		qry=qry+ " A.SUBJECTID = B.SUBJECTID order by A.examcode,FACULTYID, subjectcode";
	}
	else if(mType.equals("H"))
	{
		qry="select distinct B.SUBJECT, A.SUBJECTID subjectid, B.SUBJECTCODE subjectcode,examcode,FACULTYID";
		qry=qry+ " from TT#TIMETABLEDATA A, SUBJECTMASTER B where ";
		qry=qry+" (A.fstid) in (select fstid from  facultysubjecttagging"; 
		qry=qry+" where facultytype = decode('"+mDMemberType+"','E','I','E') and "; 
		qry=qry+"employeeid in (select employeeid from V#STAFF where departmentcode='"+mDept+"') and nvl(deactive,'N')='N') ";  
		qry=qry+"and A.SUBJECTID = B.SUBJECTID order by examcode,FACULTYID, subjectcode ";
	}
	else 
	{
		qry="select distinct B.SUBJECT, A.SUBJECTID subjectid, B.SUBJECTCODE subjectcode,examcode,FACULTYID";
		qry=qry+ " from TT#TIMETABLEDATA A, SUBJECTMASTER B where ";
		qry=qry+" (A.fstid) in (select fstid from  facultysubjecttagging"; 
		qry=qry+" where facultytype = decode('"+mDMemberType+"','E','I','E') and "; 
		qry=qry+"employeeid='"+mDMemberID+"' and nvl(deactive,'N')='N') ";  
		qry=qry+"and A.SUBJECTID = B.SUBJECTID order by examcode,FACULTYID ";
	}
	rss=db.getRowset(qry);
 //	out.println(qry);
	if (request.getParameter("x")==null) 
	{
		%>
 
		<select name=DataCombo tabindex="0" id="DataCombo" style="WIDTH: 0px">	

		<%   
		while(rss.next())
		{
			mSubj1=rss.getString("examcode")+"***"+rss.getString("FACULTYID")+"///"+rss.getString("Subjectid");
			if(msubj.equals(""))
			{
 			msubj=mSubj1;
			%>
			<OPTION Value =<%=mSubj1%>><%=rss.getString("SUBJECT")%></option> 
			<%	
			}
			 else
			 {
			%>
			<OPTION Value =<%=mSubj1%>><%=rss.getString("SUBJECT")%></option> 
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
		mSubj1=rss.getString("examcode")+"***"+rss.getString("FACULTYID")+"///"+rss.getString("Subjectid");

			if(mSubj1.equals(request.getParameter("DataCombo").toString().trim()))
 			{
				msubj=mSubj1;
				%>
				 <OPTION selected Value =<%=mSubj1%>><%=rss.getString("SUBJECT")%></option> 
				<%			
		     }
		     else
				 {
				%>
			     	<OPTION Value = <%=mSubj1%>><%=rss.getString("SUBJECT")%></option> 
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
<!--******************************SUBJECT *************************************-->
<FONT color=black><FONT face=Arial size=2><STRONG>Subject : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</STRONG></FONT></FONT>
<%
	try
	{
	if(mType.equals("D"))
	{
	   qry="select distinct B.SUBJECT, A.SUBJECTID subjectid, B.SUBJECTCODE SUBJECTCODE from TT#TIMETABLEDATA A, ";
	   qry=qry+" SUBJECTMASTER B where  A.FACULTYID='"+qrymEventsubevent+"' ";
	   qry=qry+" and examcode='"+qrymExamid+"' AND A.SUBJECTID = B.SUBJECTID order by subject ";
	}
	else if(mType.equals("H"))
	{
	qry="select distinct B.SUBJECT, A.SUBJECTID subjectid, B.SUBJECTCODE subjectcode";
	qry=qry+ " from TT#TIMETABLEDATA A, SUBJECTMASTER B where ";
	qry=qry+" (A.fstid) in (select fstid from  facultysubjecttagging"; 
	qry=qry+" where facultytype = decode('"+mDMemberType+"','E','I','E') and "; 
	qry=qry+"employeeid in (select employeeid from V#STAFF where departmentcode='"+mDept+"') and nvl(deactive,'N')='N') ";  
	qry=qry+"and A.SUBJECTID = B.SUBJECTID and FACULTYID ='"+qrymEventsubevent+"' ";
	qry=qry+" and examcode='"+qrymExamid+"' order by subject";	
	}
	else 
	{
	qry="select distinct B.SUBJECT, A.SUBJECTID subjectid, B.SUBJECTCODE SUBJECTCODE from ";
    qry=qry+"TT#TIMETABLEDATA A, SUBJECTMASTER B  where ";
	qry=qry+" (A.fstid) in (select fstid from  facultysubjecttagging"; 
	qry=qry+" where facultytype=decode('"+mDMemberType+"','E','I','E') and " ;
	qry=qry+" employeeid='"+mDMemberID+"' and nvl(deactive,'N')='N') ";  
	qry=qry+" AND A.SUBJECTID = B.SUBJECTID ";
	qry=qry+" and examcode='"+qrymExamid+"' order by subject";

	}
	
//	out.print(qry);
	rss=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		%>
		<select name=Subject tabindex="0" id="Subject" style="WIDTH: 300px">
		<option SELECTED value=ALL > ALL </option>
		<%   
		while(rss.next())
		{
			mSubj=rss.getString("SUBJECTID");
			if(msubj1.equals(""))
			{
 			msubj1=mSubj;
			%>
			<OPTION Value=<%=mSubj%>><%=rss.getString("SUBJECT")%></option>
			<%
			}
			 else
				{
			%>
			<OPTION  Value=<%=mSubj%>><%=rss.getString("SUBJECT")%></option>
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
		<select name=Subject tabindex="0" id="Subject" style="WIDTH: 300px">	
<%
		if((request.getParameter("Subject").toString().trim()).equals("ALL"))
		 {
%>	
		<option value='ALL' selected >ALL</option>
<%	
		 }
	 else
		 {
	%>
			<option value='ALL'>ALL</option>
	<%
		 }
		while(rss.next())
		{
			mSubj=rss.getString("SubjectID");
			if(mSubj.equals(request.getParameter("Subject").toString().trim()))
 			{
				msubj1=mSubj;
				%>
				<OPTION  selected Value =<%=mSubj%>><%=rss.getString("SUBJECT")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mSubj%>><%=rss.getString("SUBJECT")%></option>
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
	<INPUT Type="submit" Value="Show/Refresh">
	</td>
</tr>

	</table>
	    </form>
	<%	
	//	if(request.getParameter("x")!=null)
	//	{
		
		
	//	 if( request.getParameter("Subject")!=null && request.getParameter("FacultyIDShow")!=null && request.getParameter("Exam")!=null)
	//	{
		
		if(request.getParameter("Exam")!=null)
			mEC=request.getParameter("Exam").toString().trim();
		else
			mEC=examidm;
		
		if(request.getParameter("Subject")!=null)
			mSC=request.getParameter("Subject").toString().trim();
		else
			mSC="ALL";
			//mSC=msubj1;

		if(request.getParameter("FacultyIDShow")!=null)
			mFaculty=request.getParameter("FacultyIDShow").toString().trim();
		else
			mFaculty=qrymEventsubevent;

//*************** TO SHOW WHAT WE SELECT *****************

//	out.println("Exam Code : "+mEC+"<br>");
//	out.println("Subject : "+mSC+"<br>");
//	out.println("FacultyID : "+mFaculty+"<br>");

	try
		{
		 qry = "Select distinct to_char(A.FROMSESSIONTIME,'hh:mi AM') FROMSESSIONTIME,to_char(A.FROMSESSIONTIME,'hh24:mi')    From  "; 
		 qry=qry+" TT#TIMETABLEDATA A  WHERE A.EXAMCODE = '"+mEC+"' AND FACULTYID "; 
		 qry=qry+" =DECODE('"+mFaculty+"','ALL', FACULTYID,'"+mFaculty+"') AND ";
		 qry=qry+" SUBJECTID = DECODE('"+mSC+"','ALL', SUBJECTID,'"+mSC+"')";
		 qry=qry+" AND (A.fstid) in (select fstid from facultysubjecttagging ";
		 qry=qry+" where facultytype=decode('"+mDMemberType+"','E','I','E') and ";
		 qry=qry+" employeeid='"+mFaculty+"' and  nvl(deactive,'N')='N') ";
	       qry=qry+" and A.FROMSESSIONTIME is not null ORDER BY  2";

		 
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
		Tabletime = rstable.getString("FROMSESSIONTIME");
		%>  
	<!-- ************************ Display time of Time table ******************* -->
	<td align='center'><font color="#FFFFFF" size="2"><b><%=Tabletime %></b></font></td>
		<%	
			
		}
	%>
	 </tr>
	<%
		
		qry = "select Distinct  decode ( AllocationDay ,'MON','1', ";
		qry=qry+" 'TUE','2', 'WED','3', 'THU','4', 'FRI','5', ";
		qry=qry+" 'SAT','6','SUN','7'), AllocationDay From  TT#TIMETABLEDATA ";
		qry=qry+" where EXAMCODE = '"+mEC+"' AND FACULTYID = ";
		qry=qry+" DECODE('"+mFaculty+"','ALL', FACULTYID,'"+mFaculty+"') AND ";
		qry=qry+" SUBJECTID = DECODE('"+mSC+"','ALL', SUBJECTID,'"+mSC+"')  order by 1";

		rstable = db.getRowset(qry);  	
		while(rstable.next())
		{
		 String DayDisplay=rstable.getString("ALLOCATIONDAY") ;
		 qry = "Select distinct to_char(A.FROMSESSIONTIME,'hh:mi AM') FROMSESSIONTIME,to_char(A.FROMSESSIONTIME,'hh24:mi')    From  "; 
		 qry=qry+" TT#TIMETABLEDATA A  WHERE A.EXAMCODE = '"+mEC+"' AND FACULTYID "; 
		 qry=qry+" =DECODE('"+mFaculty+"','ALL', FACULTYID,'"+mFaculty+"') AND ";
		 qry=qry+" SUBJECTID = DECODE('"+mSC+"','ALL', SUBJECTID,'"+mSC+"')";
		 qry=qry+" AND (A.fstid) in (select fstid from facultysubjecttagging ";
		 qry=qry+" where facultytype=decode('"+mDMemberType+"','E','I','E') and ";
		 qry=qry+" employeeid='"+mFaculty+"' and  nvl(deactive,'N')='N') ";
	       qry=qry+" and A.FROMSESSIONTIME is not null ORDER BY  2";
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
			Tabletime = rsTime.getString("FROMSESSIONTIME");
			qry2 = "select distinct SUBJECTID, nvl(LTP,'N/A') LTP, nvl(ROOMSHORTNAME,'*') ROOMSHORTNAME, nvl(FACULTYSHORTNAME,' ')FACULTYSHORTNAME ";
			qry2=qry2+" from TT#TIMETABLEDATA  where EXAMCODE = '"+mEC+"' AND FACULTYID = ";
			qry2=qry2+" DECODE('"+mFaculty+"','ALL', FACULTYID,'"+mFaculty+"') AND ";
			qry2=qry2+" SUBJECTID = DECODE('"+mSC+"','ALL', SUBJECTID,'"+mSC+"') AND ";
			qry2=qry2+" to_char(FROMSESSIONTIME,'hh24:mi AM')= '"+Tabletime +"' AND ALLOCATIONDAY ='"+DayDisplay+"' ";			
			qry2=qry2+" and SUBJECTID is not null "; 			 
			
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
				 
				<font color="#C00000"> <%=rsTableData.getString("LTP")%>&nbsp;&nbsp;&nbsp;&nbsp;<%=rsTableData.getString("ROOMSHORTNAME")%></font><br>
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