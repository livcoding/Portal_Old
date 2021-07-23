<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
ResultSet rs=null,rs1=null,rs2=null,rs3=null;
String mMemberID="",mDMemberID="";
String mMemberName="",departmentname="";
String mMemberType="",mDMemberType="",mSst="",mPrcode="",mradio1="",mradio11="";
String mHead="";
String mDMemberCode="",mMemberCode="",mexam="",mExam="",mExamcode="";
String mInst="" ;
String qry="",ELE1="",mSubjID="";
int ctr=0;
String mType="",mL="",mT="",mP="",mST="",mSemT="",SEM="",mBasket="",BASKET="";
String SUBJ="",mSubj="",TYPE="",DEPT="",mDept="",LTP="",SUBNAME="",mSname="",EXAM="",mSems="",mCompcode="";

if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}

if (session.getAttribute("CompanyCode")==null)
{
	mCompcode="";
}
else
{
	mCompcode=session.getAttribute("CompanyCode").toString().trim();
}
/*if (session.getAttribute("DepartmentCode")==null)
{
	mDept="";
}
else
{
	mDept=session.getAttribute("DepartmentCode").toString().trim();
}*/

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
if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
}
if (session.getAttribute("MemberName")==null)
{
	mMemberName="";
}
else
{
	mMemberName=session.getAttribute("MemberName").toString().trim();
}
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [HOD Load Distribution] </TITLE>
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
  qry="Select WEBKIOSK.ShowLink('56','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
 	    RsChk= db.getRowset(qry);
	    if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	  	{

		
		/*qry=" Select PREVENTCODE PREVENTCODE  from PREVENTS A WHERE INSTITUTECODE='"+ mInst+"' AND (PREVENTCODE) IN (SELECT  PREVENTCODE from PREVENTMASTER WHERE INSTITUTECODE='" + mInst+"' ";
		qry=qry+" and NVL(FREEELECTIVERUNFINALIZED,'N')='Y'  and nvl(PRCOMPLETED,'N')='N' and nvl(PRBROADCAST,'N')='Y' and PRREQUIREDFOR='E'";
		qry=qry+" AND NVL(DEACTIVE,'N')='N') and  nvl(LOADDISTRIBUTIONSTATUS,'N') not in ('F','A') and nvl(ELRNNINGFINALIZEDBYHOD,'N')='Y' and MEMBERTYPE='E' ";
		and MEMBERID IN (sELECT EMPLOYEEID)'"+mChkMemID+"' ";
		qry=qry+"  and nvl(DEACTIVE,'N')='N'";*/
		
		
		
		
		//out.print(qry);	
		
		
		
		//rs=db.getRowset(qry);
		if(1==1)
		//if(rs.next())
		{		
			//mPrcode=rs.getString("PREVENTCODE");
  //----------------------
%>
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<table id=id1 width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">HOD Load Distribution of Department</TD>
</font></td></tr>
</TABLE>
<table id=idd2 cellpadding=1 cellspacing=0 width="100%" align=center rules=rows  border=3>
<tr><td align=center colspan=4>
<b>Load Distribution or Faculty Subject Choice Approval</b>
</td></tr>
<tr>
<!--*********Exam**********-->
				<td><FONT color=black><FONT face=Arial size=2><STRONG>Exam Code</STRONG></FONT></FONT>
				&nbsp;&nbsp;
				<%
				try
				{
					/*
					qry=" SELECT distinct EXAMCODE Exam from PREVENTMASTER WHERE INSTITUTECODE='"+ mInst+"' and ELSUBJECTRUNNINGFINALIZED='Y' and  NVL(LOADDISTRIBUTIONAPPROVAL,'N')='N' and nvl(PRCOMPLETED,'N')='N' and nvl(PRBROADCAST,'N')='Y'";
					qry=qry+" AND NVL(DEACTIVE,'N')='N' And (INSTITUTECODE, PREVENTCODE) In ";
					qry=qry+" (select INSTITUTECODE, PREVENTCODE from PREVENTS where nvl(DEACTIVE,'N')='N' ";
					qry=qry+" And nvl(SENDTOHOD,'N')='Y' and MEMBERTYPE<>'S' )";									
					*/
					qry=" SELECT distinct EXAMCODE Exam from PREVENTMASTER WHERE INSTITUTECODE='"+ mInst+"' and FREEELECTIVERUNFINALIZED='Y'  and nvl(PRCOMPLETED,'N')='N' and nvl(PRBROADCAST,'N')='Y'";
					qry=qry+" AND NVL(DEACTIVE,'N')='N'";									
					//out.print(qry);
					rs=db.getRowset(qry);	
							
					if (request.getParameter("x")==null) 
				 	  {
						%>
						<select name=Exam tabindex="0" id="Exam" style="WIDTH: 120px">	
						<%   
						while(rs.next())
						{
							mExam=rs.getString("Exam");
							if(mexam.equals(""))
 							mexam=mExam;
							%>
							<OPTION Value =<%=mExam%>><%=rs.getString("Exam")%></option>
							<%
						}
							%>
						</select>
						<%
					 }
					else
					{
					%>	
						<select name=Exam tabindex="0" id="Exam" style="WIDTH: 120px">	
						<%
						while(rs.next())
						{
							mExam=rs.getString("Exam");
							if(mExam.equals(request.getParameter("Exam").toString().trim()))
				 			{
								mexam=mExam;
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
				</td>

<td>
&nbsp;  &nbsp; <b>Semester Type : </b><select name=SemType id=SemType>
	<%
	if(request.getParameter("SemType")==null)
	{
	%>
	   <!--<option selected value='ALL'>ALL</option>-->
	   <option value='REG'>REG</option>
	  <!--  <option value='RWJ'>RWJ</option>  -->
	<%
	}
	else
	{
		mSemT=request.getParameter("SemType").toString().trim();
		if(mSemT.equals("ALL"))
		{
		%>
			<!-- <option selected value='ALL'>ALL</option> -->
	      <!--      <option value='REG'>REG</option>
		      <option value='RWJ'>RWJ</option> -->
 		<%
		}
		else if(mSemT.equals("REG"))
		{
		%>
			<!--<option value='ALL'>ALL</option> -->
			<option selected value='REG'>REG</option>
	   		<!-- <option value='RWJ'>RWJ</option>  -->
 		<%
		}	
		else 
		{
		%>
			<option value='ALL'>ALL</option>
		<!--	<option value='REG'>REG</option>
	  	      <option selected value='RWJ'>RWJ</option> -->
		<%
		}
	}
%>
</select>
</td>
<tr>
<td colspan='2'>&nbsp;  &nbsp; <b> Department</b>
<%
qry="select a.DEPARTMENTCODE,a.department from departmentmaster a ,USERWISELOADPERMITION b where a.departmentcode=b.DEPARTMENTCODE and nvl(A.deactive,'N')='N' and nvl(b.deactive,'N')='N' and b.EMPLOYEEID='"+mChkMemID+"'  and examcode='"+mExam+"' and COMPANYCODE='"+mCompcode+"' and nvl(freezed,'N')='N'";
//out.println(qry);
rs=db.getRowset(qry);	
if (request.getParameter("x")==null) 
				 	  {
						%>
						<select name="department" tabindex="0" id="department" style="WIDTH: 300px">	
						<%   
						while(rs.next())
						{
							mDept=rs.getString("DEPARTMENTCODE");
							departmentname=rs.getString("department");
							
							%>
							<OPTION Value =<%=rs.getString("DEPARTMENTCODE")%>><%=rs.getString("department")%></option>
							<%
						}
							%>
						</select>
						<%
					 }
					else
					{
					%>	
						<select name="department" tabindex="0" id="department" style="WIDTH: 300px">	
						<%
						while(rs.next())
						{
							mDept=rs.getString("DEPARTMENTCODE");
							departmentname=rs.getString("department");
							%>
							<OPTION Value =<%=rs.getString("DEPARTMENTCODE")%>><%=rs.getString("department")%></option>
							<%
						}
							%>
						
						</select>
					  	<%
					 }



%>






</td>
</tr>
<tr>
<td colspan='2' align=center>
<input type=submit id=btn name=btn value='Show/Refresh'>
</td>
</tr>	
</table>

<table cellspacing=0 align=center border=2 rules=groups width=100%>
<tr bgcolor="#ff8c00">
<td align=middle><b><font color=white>Sno.</font><b></td>
<td align=middle><b><font color=white>Subject <br>Type </font><b></td>
<td align=middle><b><font color=white>Subject</font><b></td>

<td align=middle>
<table align=center cellspacing=0 cellpadding=0 border=2>
<tr bgcolor="#ff8c00">
<td colspan=3 align=center nowrap><b><font color=white>Assigned Faculty Count</font</b></td></tr>
<tr>
<td align=middle><b><font color=white>L</font></b></td>
<td align=middle><b><font color=white>T</font></b></td>
<td align=middle><b><font color=white>P</font></b></td>
</tr>
</table>
</td>
</tr>	
<br>
<%         

	//	mType=request.getParameter("Type").toString().trim();

		if(request.getParameter("x")==null)
		{
		mExamcode=mexam;
		}
		else
		{	
		mExamcode=request.getParameter("Exam").toString().trim();
		}

		if(request.getParameter("x")==null)
		{
		mSems="REG";
		}
		else
		{	
		mSems=request.getParameter("SemType").toString().trim();
		}
	if (mExamcode!=null && !mExamcode.equals(""))
	{
		
	try
	{
		
		
		qry="Select PREVENTCODE   from PREVENTmaster A WHERE INSTITUTECODE='"+ mInst+"' and examcode ='"+mExamcode+"' and nvl(deactive,'N')='N' and nvl(PRCOMPLETED,'N')='N' and nvl(PRREQUIREDFOR,'E')='E'";
		//out.println(qry);
		ResultSet rdddd= db.getRowset(qry);
		if(rdddd.next())
		{
mPrcode=rdddd.getString("PREVENTCODE");
//out.println(mPrcode);
		}
		if(request.getParameter("department")!=null)		
			mDept=request.getParameter("department");
		
		
		
		
		
		
		
		
		
		/*qry="select distinct 'C' CEF, nvl(L,0)L,nvl(T,0)T,nvl(P,0)P ,A.subjectcode subjectcode,NULL ELECTIVECODE,A.Basket Basket,B.Subject||' ('||A.SubjectCode||') ' subj from programscheme A ,Subjectmaster B ";
		qry=qry+" where A.institutecode='"+mInst+"' ";
		qry=qry+" and A.subjectcode in (select C.subjectcode from PR#DEPARTMENTSUBJECTTAGGING C ";
		qry=qry+" where  departmentcode in (select departmentcode ";
		qry=qry+" from employeemaster where employeeid in (select employeeid from hodlist ";
		qry=qry+" where employeeid='"+mDMemberID+"')))  AND A.SUBJECTCODE=B.SUBJECTCODE  ";
		qry=qry+" and (nvl(L,0)>0 or nvl(T,0)>0 or nvl(P,0)>0 )  ";
		qry=qry+" union ";
		qry=qry+" select distinct 'E' CEF,nvl(L,0)L,nvl(T,0)T,nvl(P,0)P , A.subjectcode subjectcode,A.ELECTIVECODE ELECTIVECODE,A.Basket Basket,B.Subject||' ('||A.SubjectCode||') ' subj from PR#ELECTIVESUBJECTS A ,Subjectmaster B  ";
		qry=qry+" where A.institutecode='"+mInst+"' and A.examcode='"+mExamcode+"' ";
		qry=qry+" and A.subjectcode in (select C.subjectcode from PR#DEPARTMENTSUBJECTTAGGING C ";
		qry=qry+" where  departmentcode in (select departmentcode ";
		qry=qry+" from employeemaster where employeeid in (select employeeid from hodlist ";
		qry=qry+" where employeeid='"+mDMemberID+"'))) and A.SUBJECTRUNNING='Y' AND A.SUBJECTCODE=B.SUBJECTCODE  ";
		qry=qry+" and (nvl(L,0)>0 or nvl(T,0)>0 or nvl(P,0)>0 )  ";
		qry=qry+" union ";
		qry=qry+" select distinct 'F' CEF, nvl(L,0)L,nvl(T,0)T,nvl(P,0)P ,A.subjectcode subjectcode,NULL ELECTIVECODE,A.Basket Basket,B.Subject||' ('||A.SubjectCode||') ' subj from FREEELECTIVE A ,Subjectmaster B  ";
		qry=qry+" where A.institutecode='"+mInst+"' and A.examcode='"+mExamcode+"' ";
		qry=qry+" and A.subjectcode in (select C.subjectcode from PR#DEPARTMENTSUBJECTTAGGING C ";
		qry=qry+" where  departmentcode in (select departmentcode ";
		qry=qry+" from employeemaster where employeeid in (select employeeid from hodlist ";
		qry=qry+" where employeeid='"+mDMemberID+"'))) and A.SUBJECTRUNNING='Y' AND A.SUBJECTCODE=B.SUBJECTCODE  ";
		qry=qry+" and (nvl(L,0)>0 or nvl(T,0)>0 or nvl(P,0)>0 )  order by CEF, subj ";
		*/


		//nvl(L,0)L,nvl(T,0)T,nvl(P,0)P
		qry="select distinct 'C' CEF,A.L L,A.T T,A.P P,A.subjectid subjectid,B.subjectcode subjectcode,null ELECTIVECODE,A.Basket Basket,B.Subject||' ('||B.SubjectCode||') ' subj from programscheme A ,Subjectmaster B ";
		qry=qry+" where A.institutecode='"+mInst+"' ";
		qry=qry+" and A.subjectid in (select C.subjectid from PR#DEPARTMENTSUBJECTTAGGING C ";
		qry=qry+" where  C.examcode='"+mExamcode+"' ";
		qry=qry+" AND A.INSTITUTECODE = C.INSTITUTECODE ";
		qry=qry+" AND A.ACADEMICYEAR =C.ACADEMICYEAR ";
		qry=qry+" AND A.PROGRAMCODE  = C.PROGRAMCODE ";
		qry=qry+" AND A.TAGGINGFOR   = C.TAGGINGFOR ";
		qry=qry+" AND A.SECTIONBRANCH = C.SECTIONBRANCH AND C.departmentcode ='"+mDept+"' )  AND A.SUBJECTID=B.SUBJECTID ";
		qry=qry+"and (A.L>0 or A.T>0 or A.P>0 )";
		qry=qry+" union ";
		qry=qry+"select distinct 'C' CEF, A.L L,A.T T,A.P P,A.subjectid subjectid,B.subjectcode subjectcode,null ELECTIVECODE,A.Basket Basket,B.Subject||' ('||B.SubjectCode||') ' subj from OFFERSUBJECTTAGGING A ,Subjectmaster B where A.institutecode='"+mInst+"' and   a.examcode='"+mExamcode+"'  AND a.departmentcode ='"+mDept+"'  AND A.SUBJECTID=B.SUBJECTID and (A.L>0 or A.T>0 or A.P>0 ) aND A.Basket='A'";
		qry=qry+" union ";
		qry=qry+" select distinct 'E' CEF,A.L L,A.T T,A.P P, A.subjectid subjectid, B.subjectcode subjectcode,A.ELECTIVECODE ELECTIVECODE,A.Basket Basket,B.Subject||' ('||B.SubjectCode||') ' subj from PR#ELECTIVESUBJECTS A ,Subjectmaster B  ";
		qry=qry+" where A.institutecode='"+mInst+"' and A.examcode='"+mExamcode+"' ";
		qry=qry+" and A.subjectid in (select C.subjectid from PR#DEPARTMENTSUBJECTTAGGING C ";
		qry=qry+" where  C.examcode='"+mExamcode+"' ";
		qry=qry+" AND A.INSTITUTECODE = C.INSTITUTECODE ";
		qry=qry+" AND A.ACADEMICYEAR =C.ACADEMICYEAR ";
		qry=qry+" AND A.PROGRAMCODE  = C.PROGRAMCODE ";
		qry=qry+" AND A.TAGGINGFOR   = C.TAGGINGFOR ";
		qry=qry+" AND A.SECTIONBRANCH = C.SECTIONBRANCH AND  C.departmentcode ='"+mDept+"' ) and A.SUBJECTRUNNING='Y' AND A.SUBJECTID=B.SUBJECTID   ";
		qry=qry+" and (A.L>0 or A.T>0 or A.P>0 ) ";
		qry=qry+" union ";
		qry=qry+"select distinct 'E' CEF,A.L L,A.T T,A.P P,A.subjectid subjectid,B.subjectcode subjectcode,null ELECTIVECODE,A.Basket Basket,B.Subject||' ('||B.SubjectCode||') ' subj from OFFERSUBJECTTAGGING A ,Subjectmaster B where A.institutecode='"+mInst+"' and  a.examcode='"+mExamcode+"'  AND a.departmentcode ='"+mDept+"'  AND A.SUBJECTID=B.SUBJECTID and (A.L>0 or A.T>0 or A.P>0 ) and  A.Basket='B'";
		qry=qry+" union ";
		qry=qry+" select distinct 'F' CEF,A.L L,A.T T,A.P P,A.subjectid subjectid,B.subjectcode subjectcode,NULL ELECTIVECODE,A.Basket Basket,B.Subject||' ('||A.SubjectCode||') ' subj from FREEELECTIVE A ,Subjectmaster B  ";
		qry=qry+" where A.institutecode='"+mInst+"' and A.examcode='"+mExamcode+"' ";
		qry=qry+" and A.subjectid in (select C.subjectid from PR#DEPARTMENTSUBJECTTAGGING C ";
		qry=qry+" where  C.examcode='"+mExamcode+"' ";
		qry=qry+" AND A.INSTITUTECODE = C.INSTITUTECODE ";
		qry=qry+" AND A.ACADEMICYEAR =C.ACADEMICYEAR ";
		qry=qry+" AND A.PROGRAMCODE  = C.PROGRAMCODE ";
		qry=qry+" AND A.TAGGINGFOR   = C.TAGGINGFOR ";
		qry=qry+" AND A.SECTIONBRANCH = C.SECTIONBRANCH AND   C.departmentcode ='"+mDept+"') and A.SUBJECTRUNNING='Y' AND A.SUBJECTID=B.SUBJECTID ";
		qry=qry+" and (A.L>0 or A.T>0 or A.P>0 )  ";
		qry=qry+"order by CEF, subj ";
	//out.print(qry);
	rs=db.getRowset(qry);
//out.print(rs.next());
	while(rs.next())
	{


	ctr++;
	mSubjID=rs.getString("subjectid");
		
	
	mSubj=rs.getString("subjectcode");


	mSname=rs.getString("subj");

	mBasket=rs.getString("Basket");

	mType=rs.getString("CEF").trim();


	
	qry="select count(distinct facultyid)cnt from PR#FACULTYSUBJECTCHOICES ";
	qry=qry+" where institutecode='"+mInst+"' and examcode='"+mExamcode+"' and subjectid='"+mSubjID+"' ";
	qry=qry+" and subjecttype='"+mType+"' and LTP='L' ";
	rs1=db.getRowset(qry);
	if(rs1.next())
	mL=rs1.getString("cnt");
	
	qry="select count(distinct facultyid)cnt from PR#FACULTYSUBJECTCHOICES ";
	qry=qry+" where institutecode='"+mInst+"' and examcode='"+mExamcode+"' and subjectid='"+mSubjID+"' ";
	qry=qry+" and subjecttype='"+mType+"' and LTP='T' ";
	rs2=db.getRowset(qry);
	if(rs2.next())
	mT=rs2.getString("cnt");

	qry="select count(distinct facultyid)cnt from PR#FACULTYSUBJECTCHOICES ";
	qry=qry+" where institutecode='"+mInst+"' and examcode='"+mExamcode+"' and subjectid='"+mSubjID+"' ";
	qry=qry+" and subjecttype='"+mType+"' and LTP='P' ";
	rs3=db.getRowset(qry);
	if(rs3.next())
	mP=rs3.getString("cnt");

	if(mType.equals("C"))
	{
	  mSst="Core";
	
	ELE1="CORE";
	
	}
	else if(mType.equals("E"))
	{
	  mSst="Elective("+rs.getString("ELECTIVECODE")+")";
	
	ELE1=rs.getString("ELECTIVECODE");
	
	}
	else
	{	
	  mSst="Free Elective";
	ELE1="FREEELECTIVE";
	
	 }

	%>
	<tr>  
	<td ><%=ctr%></td>
	<td nowrap><%=mSst%></td>
	<td nowrap>&nbsp;<%=rs.getString("subj")%></td>

	<td align=center>
	<table width='100%'><tr>
	<td width='10%' align=center>
	<%
	if(rs.getInt("L")>0)
	{
	%>
<!--	<a target=_New href="PRLoadDistributionHODActionLec.jsp?SUBJID=<%=mSubjID%>&amp;SUBJ=<%=mSubj%>&amp;ELECTIVECODE=<%=rs.getString("ELECTIVECODE")%>&amp;BASKET=<%=mBasket%>&amp;PRCODE=<%=mPrcode%>&amp;radio1=<%=mradio1%>&amp;SEM=<%=mSems%>&amp;ELE=<%=ELE1%>&amp;SUBNAME=<%=mSname%>&amp;EXAM=<%=mExamcode%>&amp;TYPE=<%=mType%>&amp;DEPT=<%=mDept%>&amp;LTP=L">Assign </a>-->

	<a target=_New href="PRLoadDistributionHODAction.jsp?SUBJID=<%=mSubjID%>&amp;SUBJ=<%=mSubj%>&amp;ELECTIVECODE=<%=rs.getString("ELECTIVECODE")%>&amp;BASKET=<%=mBasket%>&amp;PRCODE=<%=mPrcode%>&amp;radio1=<%=mradio1%>&amp;SEM=<%=mSems%>&amp;ELE=<%=ELE1%>&amp;SUBNAME=<%=mSname%>&amp;EXAM=<%=mExamcode%>&amp;TYPE=<%=mType%>&amp;DEPT=<%=mDept%>&amp;LTP=L">Assign </a>

	<%
	}
	else
	{
	%>
	-
	<%
	}
	%>
	</td>
	<td width='10%' align=center>
	<%
	if(rs.getInt("T")>0)
	{
	%>
	<a target=_New href="PRLoadDistributionHODAction.jsp?SUBJID=<%=mSubjID%>&amp;SUBJ=<%=mSubj%>&amp;ELECTIVECODE=<%=rs.getString("ELECTIVECODE")%>&amp;BASKET=<%=mBasket%>&amp;PRCODE=<%=mPrcode%>&amp;radio1=<%=mradio1%>&amp;SEM=<%=mSems%>&amp;ELE=<%=ELE1%>&amp;SUBNAME=<%=mSname%>&amp;EXAM=<%=mExamcode%>&amp;TYPE=<%=mType%>&amp;DEPT=<%=mDept%>&amp;LTP=T">Assign </a>
	<%
	}
	else
	{
	%>
	-
	<%
	}
	%>
	</td>
	<td width='10%' align=center>
	<%
	if(rs.getInt("P")>0)
	{
	%>
	<a target=_New href="PRLoadDistributionHODAction.jsp?SUBJID=<%=mSubjID%>&amp;SUBJ=<%=mSubj%>&amp;ELECTIVECODE=<%=rs.getString("ELECTIVECODE")%>&amp;BASKET=<%=mBasket%>&amp;PRCODE=<%=mPrcode%>&amp;radio1=<%=mradio1%>&amp;SEM=<%=mSems%>&amp;ELE=<%=ELE1%>&amp;SUBNAME=<%=mSname%>&amp;EXAM=<%=mExamcode%>&amp;TYPE=<%=mType%>&amp;DEPT=<%=mDept%>&amp;LTP=P">Assign </a>
	<%
	}
	else
	{
	%>
	-
	<%
	}
	%>
	</td>
	</tr></table>
	</td>
	</tr>
	<%
	} //closing of while

	}
	catch(Exception e)
	{
		//out.print("Errors"+e);
	}

	%>
	</table>
	</form>
<form name="frm1"  method="post" action="PRLoadDistributionHODApproval.jsp">
<input id="x1" name="x1" type=hidden>
<table cellspacing=0 align=center border=2 rules=groups width=100%>
<tr bgcolor="#ff8c00">
<TR><TD  ALIGN=CENTER><b><font color=green><sup>#</sup></font>Finalized and Freezed:-</b>
<input checked type=radio id=radio1 name=radio1 value='N'><b>No</b>
<input type=radio id=radio1 name=radio1 value='Y'><b>Yes</b>
<INPUT Type="submit" Value="Freezed"></TD></TR>
</table>
<input type=hidden name=PRCODE ID=PRCODE value='<%=mPrcode%>'>
<input type=hidden name=EXAMCODE ID=EXAMCODE value='<%=mExamcode%>'>
</form>
<font color=green ># Once you will finalize and freezed,Load distribution can not be modifed.</font> 
	<%

	} //closing of if(mExamcode)

	}
	else
	{
   %>
	<br>
	<font color=red>
	<h3><br><img src='../../Images/Error1.jpg'> Load Distribution has been Already Finalized and Sent to DOAA for Approval  </h3><br>
	</font>	<br>	<br>	<br>	<br>  

   <%
	}
//-----------------------------
//---Enable Security Page Level  
//-----------------------------
	}
	else
	{
   %>
	<br>
	<font color=red>
	<h3>	<br><img src='../../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
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
}
%>
</body>
</html>
