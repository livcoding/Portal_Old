<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
try
{
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Performance Report Of Student ] </TITLE>


<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

<script language=javascript>

<!--
	function RefreshContents()
	{ 	
    	    document.frm.x.value='ddd';
    	    document.frm.submit();
	}
//-->
</SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">
function ChangeOptions(Exam,DataComboFac,DataComboSubj,Faculty,Subject)
{    
     removeAllOptions(Faculty);	
	var QryEvent='';
     for(i=0;i<DataComboFac.options.length;i++)
       {
		var v1;
		var pos;
		var ec;
		var fc;
		var len;
		var otext;
		var v1=DataComboFac.options[i].value;
		len= v1.length ;	
		pos=v1.indexOf('***');
		ec=v1.substring(0,pos);
		fc=v1.substring(pos+3,len);
		if (ec==Exam)
		 { 	
			var optn = document.createElement("OPTION");
			optn.text=DataComboFac.options[i].text;
			optn.value=fc;
			if (QryEvent=='') QryEvent=fc;
			Faculty.options.add(optn);
		}
		
	 }
 	    removeAllOptions(Subject);	 
	    for(i=0;i<DataComboSubj.options.length;i++)
	      {  
			var v1s;
			var pos1;
			var pos2;
			var exams;
			var fac;
			var lens;
			var sc;
			var otexts;
			var v1s=DataComboSubj.options[i].value;
			lens= v1s.length ;	
			pos1=v1s.indexOf('***');
			pos2=v1s.indexOf('///')
			exams=v1s.substring(0,pos1);
			fac=v1s.substring(pos1+3,pos2);
			sc=v1s.substring(pos2+3,lens);
		if (exams==Exam && QryEvent==fac)
		 { 				
			var optns = document.createElement("OPTION");
			optns.text=DataComboSubj.options[i].text;
			optns.value=sc;
			Subject.options.add(optns);
		}
		
	 }
  	}
// ----------click event on Faculty------------

function ChangeOptions1(Exam,QryEvent,DataComboSubj,Subject)
{    
     	removeAllOptions(Subject);	
	for(i=0;i<DataComboSubj.options.length;i++)
       {       	
			var v1s1;
			var pos11;
			var pos21;
			var exams1;
			var facs;
			var lens1;
			var sc1;
			var otexts1;
			var v1s1=DataComboSubj.options[i].value;
			lens1= v1s1.length ;	
			pos11=v1s1.indexOf('***');
			pos21=v1s1.indexOf('///');
			exams1=v1s1.substring(0,pos11);
			facs=v1s1.substring(pos11+3,pos21);
			sc1=v1s1.substring(pos21+3,lens1);
			if (exams1==Exam && QryEvent==facs)
			 { 				
				var optns1 = document.createElement("OPTION");
				optns1.text=DataComboSubj.options[i].text;
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
int ctr=0;
int ctr1=0;
int ctr2=0;
GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="",mType="";
String mDMemberCode="",mDMemberType="",mDept="",mDesg="",mInst="",minst="",mDMemberID="";
String mExam="",mexam="",mExamid="",mEventsubevent="",mSubj="",msubj="",macad="";
String qry="",qry1="",mname="",mCredit="";
double mWeighatage=0,mvalue=0;
String mmvalue="",mL="",mT="",mP="";
String mIC="",mEC="",mSC="",mEvent="",mFacd1="",mFacd="",msubjd1="",mSubjd="",mFEmp=""; 
ResultSet rsc=null,rsltp=null,rsf=null,rsfd=null,rssd=null,rsg=null;
ResultSet rs=null,rss=null,rs1=null,rs2=null,rs3=null,rsl=null,rsm=null,rsi=null,rsa=null;
String mEs="",mName5="",msem="",mFac="",mFac1="",mDet="";		
String msubeven="",mMarks="",mName1="",mMark="",mName2="",mName3="",mName4="",mColor="";
String mEventsubevent1="",mSubj1="",qrymExamid="",examidm="",msubj1="",mSemT="",mSems="";	
double mWeig=0,mMax=0,mvalue1=0,mTot=0;;
int mRights=0;
if (session.getAttribute("Designation")==null)
{
	mDesg="";
}
else
{
	mDesg=session.getAttribute("Designation").toString().trim();
}
							
if (session.getAttribute("DepartmentCode")==null)
{
	mDept="";
}
else
{
	mDept=session.getAttribute("DepartmentCode").toString().trim();
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
if (request.getParameter("Type")==null)
{
	mType="";
}
else
{
	mType=request.getParameter("Type").toString().trim();
}



	if (session.getAttribute("InstituteCode")==null)
	{
		mInst="";
	}
	else
	{
		mInst=session.getAttribute("InstituteCode").toString().trim();
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
if(mType.equals("H"))
	{
	   mRights=57;
	  
	}
	else 
	{
	   mRights=111;	  	
	}

	qry="Select WEBKIOSK.ShowLink('"+mRights+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
//  out.print(qry);
	  RsChk1= db.getRowset(qry);
	
	if (RsChk1.next())
	{
   //----------------------
%>
	<form name="frm" method=get >
	<input id="x" name="x" type=hidden>
	<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana">Student Progressive Marks</b><font size=3></font</font></td></tr>
	</table>
	<table cellpadding=1 cellspacing=0 align=center rules=groups border=3 width="100%">
	<tr><td>&nbsp; <font color=Green face=arial size=2><STRONG><%=mMemberName%>[<%=mDMemberCode%>]
	&nbsp;: &nbsp; &nbsp;<%=GlobalFunctions.toTtitleCase(mDesg)%>&nbsp; (
	<%=mDept%>)

	<!--Institute****-->
	
	</td></tr>
	<tr><td>
	<!--*********Exam**********-->
	<FONT color=black><FONT face=Arial size=2><STRONG>&nbsp; Exam Code</STRONG></FONT></FONT>
<%  
	try
	{
	if(mType.equals("H"))
	{
/*	qry="select distinct examcode GRADEENTRYEXAMID ,to_char(FROMDATE ,'dd-mm-yyyy')FROMDATE  from V#EXAMEVENTSUBJECTTAGGING where ";
	qry=qry+" (fstid) in (select "; 
	qry=qry+" DISTINCT fstid from  facultysubjecttagging  ";
	qry=qry+" where facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid in (select employeeid from employeemaster where departmentcode='"+mDept+"' and nvl(deactive,'N')='N') and nvl(deactive,'N')='N' AND (LTP='L' or ltp = 'P' or PROJECTSUBJECT='Y')) ";  
      qry=qry+"  order by FROMDATE  ";
*/
	qry="  SELECT DISTINCT examcode gradeentryexamid,                EXAMPERIODFROM           FROM exammaster          WHERE nvl(Deactive,'N')='N' AND NVL(LOCKEXAM,'N')='N' and  examcode           IN (                   SELECT DISTINCT examcode                              FROM facultysubjecttagging                             WHERE facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid IN (                                      SELECT employeeid                                        FROM employeemaster                                       WHERE departmentcode ='"+mDept+"'                                         AND NVL (deactive, 'N') = 'N')                               AND NVL (deactive, 'N') = 'N'                               AND (   ltp = 'L'                                    OR ltp = 'P'                                    OR projectsubject = 'Y'                                   )) ORDER BY EXAMPERIODFROM desc ";
	}
	else
	{
	/*qry="select distinct examcode GRADEENTRYEXAMID ,to_char(FROMDATE ,'dd-mm-yyyy')FROMDATE from V#EXAMEVENTSUBJECTTAGGING where ";
	qry=qry+" (fstid) in (select "; 
	qry=qry+" fstid from  facultysubjecttagging  ";
	qry=qry+" where facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"' and nvl(deactive,'N')='N' AND (LTP='L' or ltp = 'P' OR PROJECTSUBJECT='Y')) ";  
      qry=qry+"  order by FROMDATE  ";
*/

	  qry=" Select DISTINCT nvl(EXAMCODE,' ')  GRADEENTRYEXAMID, EXAMPERIODFROM from EXAMMASTER Where INSTITUTECODE='"+mInst+"' AND";
	qry+=" nvl(Deactive,'N')='N' AND NVL(LOCKEXAM,'N')='N' and examcode in (Select examcode from facultysubjecttagging)";
      //qry+=" and examcode in (select nvl(GRADEENTRYEXAMID,' ')GRADEENTRYEXAMID from COMPANYINSTITUTETAGGING Where InstituteCode='" + mInst + "' And CompanyCode='" + mComp + "') ";
	qry+=" order by EXAMPERIODFROM DESC";
	}
//out.print(qry);
      rs=db.getRowset(qry);
		if (request.getParameter("x")==null)
		{
		%>
			<select name=Exam tabindex="0" id="Exam" style="WIDTH: 150px" onclick="ChangeOptions(Exam.value,DataComboFac,DataComboSubj,Faculty,Subject);" onChange="ChangeOptions(Exam.value,DataComboFac,DataComboSubj,Faculty,Subject);" >	
		<%   
			while(rs.next())
			{
				mExamid=rs.getString("GRADEENTRYEXAMID");
				if(examidm.equals(""))
				{
				examidm=mExamid;
			%>
				<OPTION selected Value =<%=mExamid%>><%=mExamid%></option>
			<%	
				}
				else
				{
			%>
				<OPTION  Value =<%=mExamid%>><%=mExamid%></option>
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
		<select name=Exam tabindex="0" id="Exam" style="WIDTH: 150px" onclick="ChangeOptions(Exam.value,DataComboFac,DataComboSubj,Faculty,Subject);" onChange="ChangeOptions(Exam.value,DataComboFac,DataComboSubj,Faculty,Subject);">	
	<%
		while(rs.next())
			{
				mExamid=rs.getString("GRADEENTRYEXAMID");
				if(mExamid.equals(request.getParameter("Exam").toString().trim()))
 				{	
					examidm=mExamid;
				%>
					<OPTION selected Value =<%=mExamid%>><%=mExamid%></option>
				<%			
			     	}
			     	else
		      	{
				%>
		      		<OPTION Value =<%=mExamid%>><%=mExamid%></option>
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
	//*********************DataComboFac*******************	
	try
	{

//out.print(mType+"mType");

	if(mType.equals("H"))
	{
	qry="select distinct examcode,employeeid,employeename ||' ( '||employeecode||' )' employeename from V#EXAMEVENTSUBJECTTAGGING where ";
	qry=qry+" (fstid) in (select "; 
	qry=qry+" fstid from facultysubjecttagging  ";
	qry=qry+" where facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid in (select employeeid from employeemaster where departmentcode='"+mDept+"' and nvl(deactive,'N')='N') and nvl(deactive,'N')='N' ) ";  
	qry=qry+"  order by examcode,employeeid";
	}
	else
	{
	qry="select distinct examcode,employeeid,employeename ||' ( '||employeecode||' )' employeename from V#EXAMEVENTSUBJECTTAGGING where ";
	qry=qry+" (fstid) in (select "; 
	qry=qry+" fstid from facultysubjecttagging  ";
	qry=qry+" where facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"'  and nvl(deactive,'N')='N' ) ";  
	qry=qry+"  order by examcode,employeeid";

	}
	rsfd=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
	  %>
		<select name=DataComboFac tabindex="0" id="DataComboFac" style="WIDTH: 0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">	
	  <%   
	   while(rsfd.next())
	   {
			mFacd=rsfd.getString("examcode")+"***"+rsfd.getString("employeeid");
			if(mFacd1.equals(""))
 			mFacd1=mFacd;
			%>
			<OPTION selected Value=<%=mFacd%>><%=rsfd.getString("employeename")%></option>
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name=DataComboFac tabindex="0" id="DataComboFac" style="WIDTH: 0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">	
		<%
		while(rsfd.next())
		{
			mFacd=rsfd.getString("examcode")+"***"+rsfd.getString("employeeid");
			if(mFacd.equals(request.getParameter("DataComboFac").toString().trim()))
 			{
				mFacd1=mFacd;
				%>
					<OPTION selected Value=<%=mFacd%>><%=rsfd.getString("employeename")%></option>
				<%			
		     	}
		     	else
		      {
				%>
				   <OPTION Value=<%=mFacd%>><%=rsfd.getString("employeename")%></option>
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
	<!--********Employee**************-->
	<FONT color=black><FONT face=Arial size=2><STRONG>&nbsp;Faculty</STRONG></FONT></FONT>
<%
	try
	{
	if(mType.equals("H"))
	{
	qry="select distinct employeename ||' ( '||employeecode||' )' employeename,employeeid from V#EXAMEVENTSUBJECTTAGGING where ";
	qry=qry+" (fstid) in (select "; 
	qry=qry+" fstid from facultysubjecttagging  ";
	qry=qry+" where facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid in (select employeeid from employeemaster where departmentcode='"+mDept+"' and nvl(deactive,'N')='N') and nvl(deactive,'N')='N' ) ";  
	qry=qry+"  and examcode='"+examidm+"' order by employeename";
	}
	else
	{
	qry="select distinct employeename ||' ( '||employeecode||' )' employeename,employeeid from V#EXAMEVENTSUBJECTTAGGING where ";
	qry=qry+" (fstid) in (select "; 
	qry=qry+" fstid from facultysubjecttagging  ";
	qry=qry+" where facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"' and nvl(deactive,'N')='N' ) ";  
	qry=qry+"  and examcode='"+examidm+"' order by employeename";
	}
	//out.print(qry);


	rsf=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
	  %>
		<select name=Faculty tabindex="0" id="Faculty" style="WIDTH: 290px" onclick="ChangeOptions1(Exam.value,Faculty.value,DataComboSubj,Subject);" onChange="ChangeOptions1(Exam.value,Faculty.value,DataComboSubj,Subject);">	
	  <%   
	   while(rsf.next())
	   {
			mFac=rsf.getString("employeeid");
			if(mFac1.equals(""))
			{
			mFac1=mFac;
			%>
			<OPTION selected Value=<%=mFac%>><%=rsf.getString("employeename")%></option>
			<%			
			}
			else
			{
			%>
			<OPTION  Value=<%=mFac%>><%=rsf.getString("employeename")%></option>
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
		<select name=Faculty tabindex="0" id="Faculty" style="WIDTH: 290px" onclick="ChangeOptions1(Exam.value,Faculty.value,DataComboSubj,Subject);" onChange="ChangeOptions1(Exam.value,Faculty.value,DataComboSubj,Subject);">	
		<%
		while(rsf.next())
		{
			mFac=rsf.getString("employeeid");
			if(mFac.equals(request.getParameter("Faculty").toString().trim()))
 			{
				mFac1=mFac;
				%>
					<OPTION selected Value=<%=mFac%>><%=rsf.getString("employeename")%></option>
				<%			
		     	}
		     	else
		      {
				%>
				   <OPTION Value=<%=mFac%>><%=rsf.getString("employeename")%></option>
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
</td></tr>
<tr><td>	
<%
//*******************DataComboSubj*******************	
try
{
	//out.print(mType+"::::::"); 

if(mType.equals("H"))
	{
	qry="select distinct examcode,employeeid,subjectID,subject ||' ( '||subjectcode||' )' subject from V#EXAMEVENTSUBJECTTAGGING where ";
	qry=qry+" (fstid) in (select "; 
	qry=qry+" fstid from  facultysubjecttagging  ";
	qry=qry+" where facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid in (select employeeid from employeemaster where departmentcode='"+mDept+"' and nvl(deactive,'N')='N') and nvl(deactive,'N')='N' ) ";  
	qry=qry+"  order by examcode,employeeid,subjectID";
	}
	else
	{
	qry="select distinct examcode,employeeid,subjectID,subject ||' ( '||subjectcode||' )' subject from V#EXAMEVENTSUBJECTTAGGING where ";
	qry=qry+" (fstid) in (select "; 
	qry=qry+" fstid from  facultysubjecttagging  ";
	qry=qry+" where facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"' and nvl(deactive,'N')='N' ) ";  
	qry=qry+"  order by examcode,employeeid,subjectID";
	}
	//out.print(qry);
	rssd=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		%>
		<select name=DataComboSubj tabindex="0" id="DataComboSubj" style="WIDTH: 0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">	
		<%   
		while(rssd.next())
		{
			mSubjd=rssd.getString("examcode")+"***"+rssd.getString("employeeid")+"///"+rssd.getString("SubjectID");
			if(msubjd1.equals(""))
 			msubjd1=mSubjd;
			%>
			<OPTION selected Value=<%=mSubjd%>><%=rssd.getString("Subject")%></option>
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name=DataComboSubj tabindex="0" id="DataComboSubj" style="WIDTH: 0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">	
		<%
		while(rssd.next())
		{
			mSubjd=rssd.getString("examcode")+"***"+rssd.getString("employeeid")+"///"+rssd.getString("subjectID");
			if(mSubjd.equals(request.getParameter("DataComboSubj").toString().trim()))
 			{
				msubjd1=mSubjd;
				%>
				<OPTION selected Value =<%=mSubjd%>><%=rssd.getString("Subject")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mSubjd%>><%=rssd.getString("Subject")%></option>
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
	<!--SUBJECT**************-->
	<FONT color=black><FONT face=Arial size=2><STRONG>&nbsp; Subject</STRONG></FONT></FONT>
<%
	try
	{
if(mType.equals("H"))
	{
	qry="select distinct subject ||' ( '||subjectcode||' )' subject,subjectID from V#EXAMEVENTSUBJECTTAGGING where ";
	qry=qry+" (fstid) in (select "; 
	qry=qry+" fstid from  facultysubjecttagging  ";
	qry=qry+" where facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid in (select employeeid from employeemaster where departmentcode='"+mDept+"' and nvl(deactive,'N')='N') and nvl(deactive,'N')='N' ) ";  
	qry=qry+"  and examcode='"+examidm+"' and employeeid='"+mFac1+"' order by subject";
	}
	else
	{
	qry="select distinct subject ||' ( '||subjectcode||' )' subject,subjectID from V#EXAMEVENTSUBJECTTAGGING where ";
	qry=qry+" (fstid) in (select "; 
	qry=qry+" fstid from  facultysubjecttagging  ";
	qry=qry+" where facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"'  and nvl(deactive,'N')='N' ) ";  
	qry=qry+"  and examcode='"+examidm+"' and employeeid='"+mFac1+"' order by subject";

	}
	//out.print(qry);
	rss=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		%>
		<select name=Subject tabindex="0" id="Subject" >	
		<%   
		while(rss.next())
		{
			mSubj=rss.getString("SubjectID");
			if(msubj1.equals(""))
 			{
			msubj1=mSubj;
			%>
			<OPTION selected Value=<%=mSubj%>><%=rss.getString("Subject")%></option>
			<%	
			}
			else
			{
			%>
			<OPTION Value=<%=mSubj%>><%=rss.getString("Subject")%></option>
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
		<select name=Subject tabindex="0" id="Subject">	
		<%
		while(rss.next())
		{
			mSubj=rss.getString("SubjectID");
			if(mSubj.equals(request.getParameter("Subject").toString().trim()))
 			{
				msubj1=mSubj;
				%>
				<OPTION selected Value =<%=mSubj%>><%=rss.getString("Subject")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mSubj%>><%=rss.getString("Subject")%></option>
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

&nbsp;  <b>Semester Type : </b><select name=SemType id=SemType>
	<%
	if(request.getParameter("SemType")==null)
	{
	%>
	   <option  selected value='ALL'>ALL</option>
	   <option  value='REG'>REG</option>
	   <option value='RWJ'>RWJ</option> 
	<%
	}
	else
	{
		mSemT=request.getParameter("SemType").toString().trim();
		if(mSemT.equals("ALL"))
		{
		%>
			<option selected value='ALL'>ALL</option>
	            <option value='REG'>REG</option>
		      <option value='RWJ'>RWJ</option> 
 		<%
		}
		else if(mSemT.equals("REG"))
		{
		%>
			<option value='ALL'>ALL</option>
			<option selected value='REG'>REG</option>
	   		<option value='RWJ'>RWJ</option>  
 		<%
		}	
		else 
		{
		%>
			<option value='ALL'>ALL</option>
			<option value='REG'>REG</option>
	  	      <option selected value='RWJ'>RWJ</option> 
		<%
		}
	}
%>
</select>
	 &nbsp; &nbsp;<INPUT Type="submit" Value="Show">&nbsp;&nbsp;
	</td></tr>
	</table>
<input id="Type" name="Type" type=hidden value="<%=mType%>">
</form>
	<%	
	
		
		if(request.getParameter("Exam")!=null)
			mEC=request.getParameter("Exam").toString().trim();
		else
			mEC=examidm;
		
		if(request.getParameter("Subject")!=null)
			mSC=request.getParameter("Subject").toString().trim();
		else
			mSC=msubj1;
		if(request.getParameter("Faculty")!=null)
			mFEmp=request.getParameter("Faculty").toString().trim();
		else
			mFEmp=mFac1;

	if(request.getParameter("mType")!=null)
			mType=request.getParameter("Type").toString().trim();
		else
			mType="H";


		if(request.getParameter("x")==null)
		{
		mSems="REG";
		}
		else
		{	
		mSems=request.getParameter("SemType").toString().trim();
		}

		qry="select distinct NVL(A.semester,0)semester ";
		qry=qry+" from V#EXAMEVENTSUBJECTTAGGING A where A.institutecode='"+mInst+"' ";
		qry=qry+" and A.examcode='"+mEC+"' and A.SEMESTERTYPE=decode('"+mSems+"','ALL',A.SEMESTERTYPE,'"+mSems+"')  ";
		qry=qry+" and A.facultytype=decode('"+mDMemberType+"','E','I','E') and A.subjectID='"+mSC+"' ";
		rsl=db.getRowset(qry);
		while(rsl.next())
		{
		
		if(msem.equals(""))
		{
		msem=rsl.getString("semester");		
		}
		else
		{
		msem=msem+","+rsl.getString("semester") ;
		}
	
		}
	
		qry="select distinct NVL(A.ACADEMICYEAR,' ')ACADEMICYEAR ";
		qry=qry+" from V#EXAMEVENTSUBJECTTAGGING A where A.institutecode='"+mInst+"' ";
		qry=qry+" and A.examcode='"+mEC+"' and A.SEMESTERTYPE=decode('"+mSems+"','ALL',A.SEMESTERTYPE,'"+mSems+"')  ";
		qry=qry+" and A.facultytype=decode('"+mDMemberType+"','E','I','E') and A.subjectID='"+mSC+"' ";
		rsa=db.getRowset(qry);

		while(rsa.next())
		{
		if(macad.equals(""))
		{
		macad=rsa.getString("ACADEMICYEAR");		
		}
		else
		{
		macad=macad+","+rsa.getString("ACADEMICYEAR") ;
		}
	
		}
		
		qry="select distinct nvl(B.L,0)L,nvl(B.T,0)T,nvl(B.P,0)P,nvl(B.COURSECREDITPOINT,0)creditpoint ";
		qry=qry+" from PROGRAMSUBJECTTAGGING B where B.institutecode='"+mInst+"' and B.examcode='"+mEC+"' ";
		qry=qry+" AND B.subjectID='"+mSC+"' and (ACADEMICYEAR, PROGRAMCODE, TAGGINGFOR,";
		qry=qry+" SECTIONBRANCH, SEMESTER, BASKET) in (select ACADEMICYEAR, PROGRAMCODE, ";
		qry=qry+" TAGGINGFOR, SECTIONBRANCH, SEMESTER, BASKET from V#EXAMEVENTSUBJECTTAGGING  ";
		qry=qry+" where institutecode='"+mInst+"' and SEMESTERTYPE=decode('"+mSems+"','ALL',SEMESTERTYPE,'"+mSems+"') and examcode='"+mEC+"' and ";
		qry=qry+"  facultytype=decode('"+mDMemberType+"','E','I','E') ";
		qry=qry+" and subjectID='"+mSC+"') and nvl(DEACTIVE,'N')='N' ";
		rsltp=db.getRowset(qry);

		if(rsltp.next())
		{
		mL=rsltp.getString("L");
		mT=rsltp.getString("T");
		mP=rsltp.getString("P");
		mCredit=rsltp.getString("creditpoint");

		}	


	qry="select subject,SUBJECTCODE from subjectmaster where subjectID='"+mSC+"' ";
	rsc=db.getRowset(qry);	
	if(rsc.next())
	{
	mname=rsc.getString("subject");
	}

String mfname="";
qry="select EMPLOYEENAME,EMPLOYEECODE from employeemaster where Employeeid='"+mFEmp+"' and nvl(DEACTIVE,'N')='N' ";
//EMPLOYEEID, EMPLOYEENAME, DEACTIVE, EMPLOYEECODE
	rsc=db.getRowset(qry);	
	if(rsc.next())
	{
	mfname=rsc.getString("EMPLOYEENAME")+"--"+rsc.getString("EMPLOYEECODE");
	}
	
	%>
<br>
<b>Faculty Name </b>&nbsp;&nbsp;<%=mfname%>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
 <b>Exam Code :</b>&nbsp;&nbsp;<%=mEC%>
<br> 
<b>Course Name</b>&nbsp;&nbsp;<%=mname%>
&nbsp; &nbsp;<b>L :</b><%=mL%>&nbsp;&nbsp;<b>T :</b><%=mT%>&nbsp;&nbsp;<b>P :</b><%=mP%>&nbsp;&nbsp;<b>Cr :</b><%=mCredit%>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<b>Semester :(Even/Odd)</b>&nbsp;&nbsp;<%=msem%>

                            
	<form name="frm1" method=post action="PrintPerformanceReport.jsp">
	<input id="x" name="x" type=hidden>
<input id="Type" name="Type" type=hidden value="<%=mType%>">
	 <CENTER>
					
						<font size=2 color="RED" face=verdana><B>'A' - for Absent &nbsp; &nbsp; 'M' - for Medical &nbsp; &nbsp; 'U' - for UFM &nbsp; &nbsp; 'D' - for Debar   &nbsp; &nbsp; </B>
						<br>
						<!-- <marquee  scrolldelay=300  behavior=alternate><b><font size=2 color="green" face=verdana><U>You may click on any header to sort the list by marks in  ascending  or descending order.</U>
						</b>
						</marquee> -->
						</font><br>

					</CENTER>
		<TABLE align=center rules=group  class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="100%" border=1>
		<thead>
		<tr bgcolor="#ff8c00"> 

		<td align=left><font color=white> <b>Sr. No.</font></b></td>
		<td align=left><font color=white><b>Rollno.</font></b></td>
		<td align=left><font color=white><b>Name</font></b></td>
		<%	
		qry="select EVENTSUBEVENT ,WEIGHTAGE,fromd from ( ";
		qry=qry+" select distinct EVENTSUBEVENT ,WEIGHTAGE,FROMDATE,to_char(fromdate,'yyyymmdd')fromd from V#EXAMEVENTSUBJECTTAGGING ";
		qry=qry+" where institutecode='"+mInst+"' AND NVL(DEACTIVE,'N')='N' and SEMESTERTYPE=decode('"+mSems+"','ALL',SEMESTERTYPE,'"+mSems+"') and examcode='"+mEC+"'  ";
		qry=qry+" and facultytype=decode('"+mDMemberType+"','E','I','E') and subjectID='"+mSC+"'  ";
		qry=qry+" and eventsubevent  in (select eventsubevent from V#STUDENTEVENTSUBJECTMARKS ";
		qry=qry+" where institutecode='"+mInst+"' and SEMESTERTYPE=decode('"+mSems+"','ALL',SEMESTERTYPE,'"+mSems+"') and examcode='"+mEC+"'   ";
		qry=qry+" AND NVL(DEACTIVE,'N')='N'  and facultytype=decode('"+mDMemberType+"','E','I','E') and subjectID='"+mSC+"')";
		qry=qry+") GROUP BY EVENTSUBEVENT ,WEIGHTAGE,fromd order by eventsubevent";
		rsm=db.getRowset(qry);
//out.print(qry);
		String myEvent[]=new String[100];
		double myWeightage[]=new double[100];
		int mIndx=0;
		double mwTot=0;
		while(rsm.next())
		{
			myEvent[mIndx]=rsm.getString("EVENTSUBEVENT");
			myWeightage[mIndx]=rsm.getDouble("WEIGHTAGE");

			mEs=rsm.getString("EVENTSUBEVENT");
			mWeighatage=rsm.getDouble("WEIGHTAGE");
			mwTot+=mWeighatage;
	%>
		<td align=left><font color=white><b><%=mEs%>(<%=mWeighatage%>)</b></td>
	<%	
		mIndx++;
		}		
	%>	
		<td align=left ><font color=white><b>Total&nbsp;(<%=mwTot%>)</b></td>
		<td align=left><font color=white><b>Grade</b></td>
		</tr>
		</thead>
		<tbody>

	<%
		
try{
int c=1;
	qry="select distinct fstid,nvl(studentid,' ')studentid,nvl(studentname,' ')studentname, ";
	qry=qry+" nvl(enrollmentno,' ')enrollmentno,nvl(semester,0)semester ";
	qry=qry+"  from V#STUDENTEVENTSUBJECTMARKS ";
	qry=qry+" where institutecode='"+mInst+"' and SEMESTERTYPE=decode('"+mSems+"','ALL',SEMESTERTYPE,'"+mSems+"') And ";
	qry=qry+" examcode='"+mEC+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and subjectID='"+mSC+"' AND NVL(DEACTIVE,'N')='N'   order by enrollmentno" ;
	//AND ENROLLMENTNO='121319'
	rs1=db.getRowset(qry);
	//out.print(qry);
	while(rs1.next())
	{	

 %>	
	<tr>
	<td><%=c++%>.</td>
	<td><%=rs1.getString("enrollmentno")%></td>
	<td><%=GlobalFunctions.toTtitleCase(rs1.getString("studentname"))%></td>
	
<%
		for(int jp=0;jp<mIndx;jp++)
		{
		
			qry="Select nvl(A.MARKSAWARDED1,-1)MARKSAWARDED1,NVL(A.DETAINED,'N')DETAINED,nvl(A.MAXMARKS,0)MAXMARKS ";
			qry=qry+" from V#STUDENTEVENTSUBJECTMARKS A ";
			qry=qry+" where A.INSTITUTECODE='"+mInst+"' and A.SEMESTERTYPE=decode('"+mSems+"','ALL',A.SEMESTERTYPE,'"+mSems+"') and A.EXAMCODE='"+mEC+"' and ";
			qry=qry+" A.fstid='"+rs1.getString("fstid")+"' AND NVL(DEACTIVE,'N')='N' and A.STUDENTID='"+rs1.getString("studentid")+"' and A.subjectID='"+mSC+"' ";
			qry=qry+" And A.EVENTSUBEVENT='"+myEvent[jp]+"'";
		//	out.print(qry);
			rs3=db.getRowset(qry);
			if(rs3.next())
			{	
				mDet=rs3.getString("DETAINED");
				mWeig=myWeightage[jp];	
				mMax=rs3.getDouble("MAXMARKS");	
				mvalue=rs3.getDouble("MARKSAWARDED1");	
				mvalue1=(mvalue/mMax)*mWeig ;
				mvalue1=gb.getRound(mvalue1,2);
		
				if(mDet.equals("M") && mvalue1>=0)
				{	
					mTot=mTot+mvalue1;
				%>
				<td><b><u><font color=red><%=mvalue1%></font></u></b></td>
				<%
				}
				else if(mDet.equals("D") || mDet.equals("A") || mDet.equals("M") || mDet.equals("U")  )
				{
				%>
				<td>&nbsp;<FONT SIZE="2" COLOR="#FF0066"> <b><%=mDet%></b> </FONT></td>
				<%
				}	
				else
				{
				mTot=mTot+mvalue1;
					%>
				<td><%=mvalue1%></td>
				<%
				}
		}
		else
			{
	%>
				<td>  </td>
				<%
			
			}
			// CLOSING OF if rs3
}// CLOSING OF For loop
mTot=gb.getRound(mTot,2);
	%>
		<td><%=mTot%></td>
	<%
	mTot=0;

	qry="select Finalgrade from studentwisegrade where STUDENTID='"+rs1.getString("studentid")+"' and fstid in ( ";
	qry=qry+" select fstid from v#studentLtpDetail where INSTITUTECODE='"+mInst+"' ";
	qry=qry+"and EXAMCODE='"+mEC+"' and SUBJECTID='"+mSC+"' and SEMESTERTYPE=decode('"+mSems+"','ALL',SEMESTERTYPE,'"+mSems+"') and ";
	qry=qry+" SEMESTER='"+rs1.getString("semester")+"' and STUDENTID='"+rs1.getString("studentid")+"') ORDER BY Finalgrade";
	rsg=db.getRowset(qry);
	
	if(rsg.next())
	{
	%>

		<td><%=rsg.getString("Finalgrade")%></td>
		</tr>
	<%
	}
	else
	{
	%>

		<td>&nbsp;</td>
		</tr>
	<%

	}
	
	   }  // CLOSING OF WHILE rs1
	}
	catch(Exception e)
	{
		
	}
	%>
	</table>	
	</tbody>
		
	<input type=hidden name='INSTITUTECODE' id='INSTITUTECODE' value=<%=mInst%>>
	<input type=hidden name='SUBJECTCODE' id='SUBJECTCODE' value='<%=mSC%>'>
	<input type=hidden name='EXAMCODE' id='EXAMCODE' value='<%=mEC%>'>
	<input type=hidden name='SEMESTER' id='SEMESTER' value='<%=msem%>'>
	<input type=hidden name='SEMESTERTYPE' id='SEMESTERTYPE' value='<%=mSems%>'>
	<input type=hidden name='FACULTY' id='FACULTY' value='<%=mFEmp%>'>

	
<p align=right><INPUT Type="submit" Value="Make Printable Format"></p>
	
<script type="text/javascript">
	var st1 = new SortableTable(document.getElementById("table-1"),[ "Number", "CaseInsensitiveString" ]);
		</script>
</form>

<br>
<b>(Signature of Faculty)</b>
<br>

<%

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
out.print(e);
}
%>

