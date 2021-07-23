<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
session.setMaxInactiveInterval(10800);
DBHandler db=new DBHandler();
ResultSet rs=null, rs1=null, rs2=null, rs3=null;
String qry="",mWebEmail="", qry1="",myLTP="",mChkvalue="";
int kk=0, sno=0, count=0, NoStud=0, start=0, last=0;
String mMemberID="", mMemberType="", mMemberCode="", mDMemberCode="", mMemberName="";
String mName1="", mName2="", mName3="", mName4="", mName5="", mName6="", mName7="", mName8="", mName9="", mName10="";
String mRFAY="", mColor="", mInst="", mCCode="";
String mSRSEventCode="", msrseventcode="";
String mName="", mPCode="",mpcode="", mBCode="", mbcode="", mSem="", msem="";
String mSubj="", msubj="", mLTP="";
String mFaculty="", mfaculty="", mEmp1="", mEName="";
String ass="", mSRSCont="", mT="5";
int mNoStudent=20, mCounter=5;

if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}

if (session.getAttribute("MinSRSCount")==null)
{
	mSRSCont="";
}
else
{
	mSRSCont=session.getAttribute("MinSRSCount").toString().trim();
}

if (session.getAttribute("WebAdminEmail")==null)
{
	mWebEmail="";
}
else
{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
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

if(request.getParameter("mCount")!=null)
	mT=request.getParameter("mCount").toString().trim();
else
	mT="5";

if(request.getParameter("NoStudent")!=null)
	mNoStudent=Integer.parseInt(request.getParameter("NoStudent").toString().trim());
else
	mNoStudent=20;

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="TIET ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ SRS Approval For Printing ] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
</script>

<SCRIPT LANGUAGE="JavaScript"> 
 function un_check()
{
 for (var i = 0; i < document.frm1.elements.length; i++) 
{
 var e = document.frm1.elements[i]; 
if ((e.name != 'allbox') && (e.type == 'checkbox')) 
{ 
e.checked = document.frm1.allbox.checked;
 } } }
 </SCRIPT>

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
</script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
OLTEncryption enc=new OLTEncryption();

try
{
if(!mMemberID.equals("") &&  !mMemberCode.equals("") && !mMemberName.equals("")) 
{
	try
	{	
		mDMemberCode=enc.decode(mMemberCode);
	}
	catch(Exception e)
	{
		out.println(e.getMessage());
	}


	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;

  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------

	qry="Select WEBKIOSK.ShowLink('12','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------
	

%>

<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>SRS Approval [For Printing]</B></TD>
</font></td></tr>
</TABLE>
<table cellpadding=2 cellspacing=0 align=center rules=groups border=3 WIDTH=100%>

<!--Institute-->
<INPUT Type="Hidden" Name=ICCode id=mInst Value=<%=mInst%>>
<!--Program**********-->
<tr><td Nowrap><FONT color=black><FONT face=Arial size=2><STRONG>Program</STRONG></FONT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT>
<%
try
{ 
	qry="Select Distinct nvl(PROGRAMCODE,' ')PROGRAMCODE from v#SRSEVENTS where  nvl(Approved,'N')='N' and nvl(Finalized,'N')='N' and nvl(Deactive,'N')='N' order by PROGRAMCODE";
	rs=db.getRowset(qry);
	%>
	<select name=Program tabindex="0" id="Program" style="WIDTH: 150px">	
	<%
	if (request.getParameter("x")==null) 
	{
		%>
		<OPTION selected value=ALL>ALL</option>
		<%   
		if(mpcode.equals(""))
			mpcode="ALL";
		while(rs.next())
		{
			mPCode=rs.getString("PROGRAMCODE");
			%>
			<OPTION Value =<%=mPCode%>><%=mPCode%></option>
			<%					
		}
		%>
		</select>
		<%
	}
	else
	{
		if (request.getParameter("Program").toString().trim().equals("ALL"))
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
			mPCode=rs.getString("PROGRAMCODE");
			if(mPCode.equals(request.getParameter("Program").toString().trim()))
 			{
				mpcode=mPCode;
				%>
				<OPTION selected Value =<%=mPCode%>><%=mPCode%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mPCode%>><%=mPCode%></option>
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
	out.println(e.getMessage());
}
%>
</td>
<!--SUBJECT**************-->
<td Nowrap><FONT color=black><FONT face=Arial size=2><STRONG>Subject</STRONG></FONT>&nbsp;</FONT>
<%
try
{ 
	//qry1="Select Distinct 'ALL' SubjectID,'ALL' Subj, 1 SeqNo from DUAL UNION Select Distinct B.SubjectID SubjectID, Subject||'( '||B.SubjectCode||' )' Subj, 2 SeqNo  from  V#SRSEVENTS B where nvl(B.Approved,'N')='N' and nvl(B.Deactive,'N')='N' and B.SUBJECTID in (select distinct SUBJECTID from v#srseventsuggestion where srseventcode=B.srseventcode and nvl(deactive,'N')='N') order by SeqNo, Subj";
	qry1="Select Distinct 'ALL' SubjectID,'ALL' Subj, 1 SeqNo from DUAL UNION Select Distinct B.SubjectID SubjectID, Subject||'( '||B.SubjectCode||' )' Subj, 2 SeqNo  from  V#SRSEVENTS B where nvl(B.Approved,'N')='N' and nvl(B.Deactive,'N')='N' and B.FSTID in (select distinct FSTID from v#srseventsuggestion where srseventcode=B.srseventcode and nvl(deactive,'N')='N') order by SeqNo, Subj";
	rs1=db.getRowset(qry1);
	//out.print(qry1);
	%>
	<select name=Subject tabindex="0" id="Subject">
	<%
	if (request.getParameter("x")==null) 
	{
		while(rs1.next())
		{
			mSubj=rs1.getString("SubjectID");
			if(msubj.equals(""))
 			{
				msubj=mSubj;
				%>
				<OPTION selected Value =<%=mSubj%>><%=rs1.getString("Subj")%></option>
				<%			
			}
			else
			{
				%>
				<OPTION Value =<%=mSubj%>><%=rs1.getString("Subj")%></option>
				<%			
			}
		}
		%>
		</select>
		<%
	}
	else
	{
		while(rs1.next())
		{
			mSubj=rs1.getString("SubjectID");
			if(mSubj.equals(request.getParameter("Subject").toString().trim()))
 			{
				msubj=mSubj;
				%>
				<OPTION selected Value =<%=mSubj%>><%=rs1.getString("Subj")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mSubj%>><%=rs1.getString("Subj")%></option>
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
	out.println(e.getMessage());
}
%>
</td></tr>
<!--SRSEventCode****-->
<tr><td Nowrap><FONT color=black><FONT face=Arial size=2><STRONG>SRS Event Code</STRONG></FONT></FONT>
<%
try
{ 
	qry="Select Distinct nvl(A.SRSEventCode,' ') SRSEVENTCODE, TO_DATE(B.EXAMPERIODFROM,'DD-MM-YYYY')EXAMFROM from v#SRSEVENTS A, EXAMMASTER B ";
	qry+=" Where A.INSTITUTECODE=B.INSTITUTECODE AND A.EXAMCODE=B.EXAMCODE AND nvl(A.Approved,'N')='N' and nvl(A.Deactive,'N')='N' ORDER BY EXAMFROM DESC";
	//out.print(qry);
	rs=db.getRowset(qry);
	%>
	<select name=SRSEventCode tabindex="0" id="SRSEventCode" style="WIDTH: 150px">
	<%   
	if (request.getParameter("x")==null)
	{
		while(rs.next())
		{
			mSRSEventCode=rs.getString("SRSEVENTCODE");
			if(msrseventcode.equals(""))
			{
 				msrseventcode=mSRSEventCode;
				%>
				<OPTION selected Value =<%=mSRSEventCode%>><%=mSRSEventCode%></option>
				<%
			}
			else
			{
				%>
				<OPTION  Value =<%=mSRSEventCode%>><%=mSRSEventCode%></option>
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
			mSRSEventCode=rs.getString("SRSEventCode");
			if(mSRSEventCode.equals(request.getParameter("SRSEventCode").toString().trim()))
 			{
				msrseventcode=mSRSEventCode;
				%>
				<OPTION selected Value =<%=mSRSEventCode%>><%=mSRSEventCode%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mSRSEventCode%>><%=mSRSEventCode%></option>
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

</td>
<!--Faculty***********-->
 <td Nowrap><FONT color=black><FONT face=Arial size=2><STRONG>Faculty</STRONG></FONT>&nbsp; </FONT>
<%
try
{ 
	qry="select Distinct nvl(A.EMPLOYEEID,' ') EMPLOYEEID,nvl(EMPLOYEENAME,' ') EMPLOYEENAME from v#SRSEvents A";
	qry=qry +" Where nvl(A.Approved,'N')='N' and nvl(A.Deactive,'N')='N' and A.fstid in (select distinct fstid from v#srseventsuggestion where srseventcode=A.srseventcode  and nvl(deactive,'N')='N') order by EMPLOYEENAME ";
	//out.print(qry);
	rs=db.getRowset(qry);
	%>
	<select name=Faculty tabindex="0" id="Faculty">
	<%   
	if (request.getParameter("x")==null)
	{
		%>
		<OPTION selected Value=ALL>ALL</option>
		<%
		if(mfaculty.equals(""))			
			mfaculty="ALL";

		while(rs.next())
		{
			mFaculty=rs.getString("EMPLOYEEID");
			%>
			<OPTION Value =<%=mFaculty%>><%=rs.getString("EMPLOYEENAME")%></option>
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		if(request.getParameter("Faculty").toString().trim().equals("ALL"))
		{
		%>
			<OPTION Value=ALL Selected>ALL</option>
		<%
		}
		else
		{
		%>
			<OPTION Value=ALL>ALL</option>
		<%
		}
		while(rs.next())
		{
			mFaculty=rs.getString("EMPLOYEEID");
			if(mFaculty.equals(request.getParameter("Faculty").toString().trim()))
 			{
				mfaculty=mFaculty;
				%>
				<OPTION selected Value =<%=mFaculty%>><%=rs.getString("EMPLOYEENAME")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mFaculty%>><%=rs.getString("EMPLOYEENAME")%></option>
		      	<%			
		   	}
		}
		%>
		</select>
		</td>
		</tr>
	  	<%
	 }
 }    
catch(Exception e)
{
	//out.println(e.getMessage());
} 
if(request.getParameter("mCount")!=null)
	mT=request.getParameter("mCount").toString().trim();
else
	mT="5";
if(request.getParameter("NoStudent")!=null)
	mNoStudent=Integer.parseInt(request.getParameter("NoStudent").toString().trim());
else
	mNoStudent=20;
%>
<tr>
<td Nowrap><FONT color=black face=Arial size=2><strong>SRS Count >= &nbsp; &nbsp; </strong></FONT><INPUT Type="Text" style="text-align=right"size=3 maxlength=3 Name=mCount id=mCount  Value=<%=mT%>></td>
<td>
<Font face=arial size=2 color=black><b>No. of Records to Display </b></font>
<input type="text" name="NoStudent" size="3" maxlength="3" value=<%=mNoStudent%>>
&nbsp;<INPUT Type="submit" Value="Show/Refresh"></td>
</tr>
</table></form>
<LEFT><font face=arial size=2 color=navy>'SRS Count' & 'No. of Records to Display' are set '5' & '20' as default respectively. You can change this as per your needs.</font></LEFT>
<TABLE class="sort-table" rules=Rows cellSpacing=0 cellPadding=0 width="100%" border=1 >
<form name=frm1 action="SRSApprovalActionEmp.jsp" method=post>
<THEAD>
<TR bgcolor="#ff8c00">
 <td><b><font face=arial color="white" size=2>Program</font></td>
 <td><b><font face=arial color="white" size=2>Section-<br>Subsection</font></td>
 <td><b><font face=arial color="white" size=2>Subject</font></td>
 <td><b><font face=arial color="white" size=2>Faculty Name </font></td>
 <td><b><font face=arial color="white" size=2>LTP</font></td>
 <td><b><font face=arial color="white" size=2>Total <br>Stdents</font></td>
 <td><b><font face=arial color="white" size=2>SRS <br>Submitted</font></td>
 <td><b><font face=arial color="white" size=2>Approve?<br><input onClick="un_check()" type="checkbox" id='allbox' name='allbox' value='Y'>All</font></td>
</tr>
</THEAD>
 <%
//------------------  

if(request.getParameter("x")!=null)
{
	msubj=request.getParameter("Subject").toString().trim();
	mfaculty=request.getParameter("Faculty").toString().trim();
	mpcode=request.getParameter("Program").toString().trim();
	msrseventcode=request.getParameter("SRSEventCode").toString().trim();
	mT=request.getParameter("mCount").toString().trim();
	mCounter=Integer.parseInt(request.getParameter("mCount").toString().trim());
	mNoStudent=Integer.parseInt(request.getParameter("NoStudent").toString().trim());
}
else
{
	mNoStudent=mNoStudent;
	msubj=msubj;
	mfaculty=mfaculty;
	mpcode=mpcode;
	msrseventcode=msrseventcode;
	mT=mT;
	mCounter=5;
}
//out.print(mNoStudent+""+msubj+""+mfaculty+""+mpcode+""+msrseventcode+""+mT+""+mCounter);
try
{
	if(mNoStudent==0)
		NoStud=20;
	else
		NoStud=mNoStudent;
}
catch(Exception e)
{
	out.print(mNoStudent);
	//NoStud=Integer.parseInt(mNoStudent);
}
if (request.getParameter("StartIndex")==null)
	start=1;
else
	start=Integer.parseInt(request.getParameter("StartIndex").trim());

if (request.getParameter("LastIndex")==null)
	last=20;
else
	last=Integer.parseInt(request.getParameter("LastIndex").trim());

if (request.getParameter("LastIndex")==null)
{	
	if(request.getParameter("NoStudent")==null || request.getParameter("NoStudent").equals(""))
	{
		last=20;
	}
	else
	{
		try
		{
			last=Integer.parseInt(request.getParameter("NoStudent"));
		}
		catch(Exception e)
		{
			//System.out.println("Exception e"+e);
		}
	}
}
else
{
	last=Integer.parseInt(request.getParameter("LastIndex").trim());
}
String mPage="";
if (request.getParameter("Paging")==null)
	mPage="";
else
	mPage=request.getParameter("Paging").trim();
if(mPage.equals("add"))
{
	start=start+NoStud;
	last=last+NoStud;
}
else if(mPage.equals("substract"))
{
	start=start-NoStud;
	last=last-NoStud;
}

  qry="select Distinct FACULTYTYPE, A.EMPLOYEEID, EXAMCODE,ACADEMICYEAR, PROGRAMCODE, TAGGINGFOR  ";
  qry=qry+" ,SECTIONBRANCH, SUBSECTIONCODE, SEMESTER, SEMESTERTYPE, BASKET, SUBJECTID, SUBJECTCODE, SRSEVENTCODE,";   
  qry=qry+" INSTITUTECODE, Count(distinct studentid) TotalSubmitted FROM V#SRSEVENTSUGGESTION A";
  qry=qry+" where A.INSTITUTECODE='"+ mInst+ "' and SRSEVENTCODE='"+msrseventcode+"'";
  qry=qry+" and A.EmployeeID=decode('"+mfaculty+"','ALL',A.EmployeeID,'"+mfaculty+"') ";
  qry=qry+" And A.PROGRAMCODE=decode('"+mpcode+"','ALL',A.PROGRAMCODE,'"+mpcode+"')";
  qry=qry+" And nvl(A.deactive,'N')='N' And A.SUBJECTID=decode('"+msubj+"','ALL',A.SUBJECTID,'"+msubj +"')  ";
  qry=qry+" and ( FACULTYTYPE, A.EMPLOYEEID, EXAMCODE,ACADEMICYEAR, PROGRAMCODE, TAGGINGFOR  ";
  qry=qry+" ,SECTIONBRANCH, SUBSECTIONCODE, SEMESTER, SEMESTERTYPE, BASKET, SUBJECTID, SRSEVENTCODE,";   
  qry=qry+" INSTITUTECODE) in (select  FACULTYTYPE, EMPLOYEEID, EXAMCODE,ACADEMICYEAR, PROGRAMCODE, TAGGINGFOR  ";
  qry=qry+" ,SECTIONBRANCH, SUBSECTIONCODE, SEMESTER, SEMESTERTYPE, BASKET, SUBJECTID, SRSEVENTCODE,";   
  qry=qry+" INSTITUTECODE from v#srsevents where nvl(Approved,'N')='N' and nvl(Deactive,'N')='N' )";
  qry=qry+" Group by FACULTYTYPE, A.EMPLOYEEID, EXAMCODE,ACADEMICYEAR, PROGRAMCODE, TAGGINGFOR  ";
  qry=qry+" ,SECTIONBRANCH, SUBSECTIONCODE, SEMESTER, SEMESTERTYPE, BASKET, SUBJECTID, SUBJECTCODE, SRSEVENTCODE,InstituteCode";   
  qry=qry+" Having count(distinct studentid)>="+mCounter;
 //out.print(qry);
  String qryrow="";
  qryrow="select * from (select a.*, rownum rn from("+qry+") a where rownum<='"+last+"') where rn>='"+start+"'";
 //out.print(qryrow);
  rs=db.getRowset(qryrow);
  long mTotStrength=0, mTotSentStrength=0;
  while(rs.next())
  {
	if(rs.getInt("rn")==0)
		sno+=sno+1;
	else
		sno=rs.getInt("rn");
	if(sno%2==0)
		mColor="white";
	else if(sno%2==1)
		mColor="lightgrey";
	else
		mColor="";					
   /*
	LTP genertaion
   */
	try
	{
		qry="select Distinct nvl(S.EMPLOYEEID,' ') EMPLOYEEID,'TRUE' mchk,nvl(Initials,' ')||nvl(E.EMPLOYEENAME,' ')||' ('||nvl(SHORTNAME,' ')||')' EMPLOYEENAME, nvl(LTP,' ')LTP from v#SRSEVENTSUGGESTION S, EmployeeMaster E ";
		qry=qry +" Where E.EmployeeID=S.EmployeeID and nvl(E.DEACTIVE,'N')='N' and nvl(s.deactive,'N')='N'";
		qry=qry+" and S.INSTITUTECODE='"+rs.getString("InstituteCode")+"' and S.FACULTYTYPE='"+rs.getString("FacultyType")+"' and S.EMPLOYEEID='"+rs.getString("EmployeeID")+"' and S.EXAMCODE='"+rs.getString("ExamCode")+"'";
		qry=qry+" and  S.ACADEMICYEAR='"+rs.getString("ACADEMICYEAR")+"' and S.PROGRAMCODE='"+rs.getString("PROGRAMCODE")+"' and  S.TAGGINGFOR='"+rs.getString("TAGGINGFOR")+"' and  S.SECTIONBRANCH='"+rs.getString("SECTIONBRANCH")+"'";
		qry=qry+" and  s.BASKET='"+rs.getString("BASKET")+"' and S.SEMESTER='"+rs.getString("SEMESTER")+"' and  S.SUBJECTID='"+rs.getString("SUBJECTID")+"'";
		qry=qry +" And (S.INSTITUTECODE, S.FACULTYTYPE, S.EMPLOYEEID, S.EXAMCODE,  S.ACADEMICYEAR,  S.PROGRAMCODE,  S.TAGGINGFOR,  S.SECTIONBRANCH,  s.BASKET, S.SEMESTER,  S.SUBJECTID,S.LTP) ";
		qry=qry +" In (select INSTITUTECODE, FACULTYTYPE, EMPLOYEEID, EXAMCODE, ACADEMICYEAR, PROGRAMCODE, TAGGINGFOR, SECTIONBRANCH, BASKET, SEMESTER, SUBJECTID,LTP ";
		qry=qry+" from v#SRSEVENTS SS where  SRSEVENTCODE='"+ msrseventcode+"' And SubjectID='"+rs.getString("SubjectID")+"' and nvl(APPROVED,'N')='N' and nvl(DEACTIVE,'N')='N')";
		//out.print(qry);
		rs2=db.getRowset(qry);
      	rs3=db.getRowset(qry);

		
		while (rs2.next())
	 	{  
   			if ((rs2.getString("mchk")).equals("TRUE"))	
	           	{
				mEmp1=rs2.getString("EMPLOYEEID");
				mEName=rs2.getString("EMPLOYEENAME"); 
			}
		}
     
 		mLTP="";
		myLTP="";

		
	  	while (rs3.next())
 		{
       	    ass=rs3.getString("EMPLOYEEID").toString().trim();
      	    if (ass.equals(mEmp1))
  			{	
	  	 	if (mLTP.equals(""))	
		   		{
				mLTP="'"+rs3.getString("LTP")+"'" ;
				myLTP=rs3.getString("LTP");
				}
					
  	 		else 
	   			{
			 	 mLTP=mLTP+",'"+rs3.getString("LTP")+"'" ; 		
				 myLTP=myLTP+rs3.getString("LTP");
				}
	     	}    }
	}
	catch(Exception e)
	{
	// out.println("err");
	}
	if (!mLTP.equals(""))
	{
		kk++;
		qry="SELECT count(distinct studentid) from v#STUDENTLTPDETAIL where INSTITUTECODE='"+rs.getString("INSTITUTECODE")+"' and EXAMCODE='"+rs.getString("EXAMCODE")+"'";
		qry=qry+" And ACADEMICYEAR='"+rs.getString("ACADEMICYEAR")+"' and  PROGRAMCODE='"+rs.getString("PROGRAMCODE")+"' and TAGGINGFOR='"+rs.getString("TAGGINGFOR")+"'";
		qry=qry+" And SEMESTER='"+rs.getString("SEMESTER")+"' and SEMESTERTYPE='"+rs.getString("SEMESTERTYPE")+"'";
		qry=qry+" and SECTIONBRANCH='"+rs.getString("SECTIONBRANCH")+"' and SUBSECTIONCODE='"+rs.getString("SUBSECTIONCODE")+"' and BASKET='"+rs.getString("BASKET")+"'";
		qry=qry+" and SUBJECTID='"+rs.getString("SUBJECTID")+"' and EmployeeID='"+rs.getString("EmployeeID")+"' and LTP in("+mLTP+") and nvl(deactive,'N')='N'";
		rs1=db.getRowset(qry);
// out.print(qry);
		if (rs1.next())
		{
			mTotStrength=rs1.getLong(1);
		}
		else
		{
			mTotStrength=0;
		}
		try
		{
			qry="SELECT count(distinct studentid) mtot from v#SRSEVENTSUGGESTION where INSTITUTECODE='"+rs.getString("INSTITUTECODE")+"' and EXAMCODE='"+rs.getString("EXAMCODE")+"'";
			qry=qry+" And SEMESTER='"+rs.getString("SEMESTER")+"' and SEMESTERTYPE='"+rs.getString("SEMESTERTYPE")+"' and SRSEVENTCODE='"+rs.getString("SRSEVENTCODE")+"'";
			qry=qry+" And ACADEMICYEAR='"+rs.getString("ACADEMICYEAR")+"' and  PROGRAMCODE='"+rs.getString("PROGRAMCODE")+"' and TAGGINGFOR='"+rs.getString("TAGGINGFOR")+"'";
			qry=qry+" and SECTIONBRANCH='"+rs.getString("SECTIONBRANCH")+"' and SUBSECTIONCODE='"+rs.getString("SUBSECTIONCODE")+"' and BASKET='"+rs.getString("BASKET")+"'";
			qry=qry+" and SUBJECTID='"+rs.getString("SUBJECTID")+"' And LTP in ("+mLTP+") and nvl(deactive,'N')='N'";
			rs1=db.getRowset(qry);
			if (rs1.next())
			{
				mTotSentStrength=rs1.getLong("mtot");
			}
			else
			{
				mTotSentStrength=0;
			}
		}
		catch(Exception e){}

		mName1="EmployeeID_"+String.valueOf(kk).trim(); 		 		
		mName2="PROGRAMCODE_"+String.valueOf(kk).trim(); 		 		
		mName3="SUBJECTID_"+String.valueOf(kk).trim(); 		 		
		mName4="LTP_"+String.valueOf(kk).trim(); 		 		
		mName5="Approved_"+String.valueOf(kk).trim(); 		 		
		mName6="ExamCode_"+String.valueOf(kk).trim(); 		 		
		mName7="EmployeeNM_"+String.valueOf(kk).trim(); 		 		
		mName8="Section_"+String.valueOf(kk).trim();
		mName9="SubSection_"+String.valueOf(kk).trim();
		mName10="SUBJECTCODE_"+String.valueOf(kk).trim(); 		 		

		%>
		<TBODY>
		<TR bgcolor=<%=mColor%>>
		<input type=hidden Name='<%=mName1%>' ID='<%=mName1%>' value='<%=rs.getString("EmployeeID")%>'>
		<input type=hidden Name='<%=mName2%>' ID='<%=mName2%>' value='<%=rs.getString("PROGRAMCODE")%>'>
		<input type=hidden Name='<%=mName3%>' ID='<%=mName3%>' value='<%=rs.getString("SUBJECTID")%>'>
		<input type=hidden Name='<%=mName4%>' ID='<%=mName4%>' value='<%=myLTP%>'>
		<input type=hidden NAME='<%=mName6%>' ID='<%=mName6%>' value='<%=rs.getString("EXAMCODE")%>'>
		<input type=hidden Name='<%=mName7%>' ID='<%=mName7%>' value='<%=mEName%>'>
		<input type=hidden Name='<%=mName8%>' ID='<%=mName8%>' value='<%=rs.getString("SECTIONBRANCH")%>'>
		<input type=hidden Name='<%=mName9%>' ID='<%=mName9%>' value='<%=rs.getString("SUBSECTIONCODE")%>'>
		<input type=hidden Name='<%=mName10%>' ID='<%=mName10%>' value='<%=rs.getString("SUBJECTCODE")%>'>

		<td><%=rs.getString("PROGRAMCODE")%></td>
 		<td><%=rs.getString("SECTIONBRANCH")%>-<%=rs.getString("SUBSECTIONCODE")%></td> 	
		<td><%=rs.getString("SUBJECTCODE")%></td>
		<td><font size=2><%=mEName%></td>
		<td><%=GlobalFunctions.getSortedLTPSQ(mLTP)%></td>
		<td><%=mTotStrength%></td>
		<td><%=mTotSentStrength%></td>
		<td><input type='checkbox' value='Y' ID='<%=mName5%>' Name='<%=mName5%>'></td>
		</tr>
		</TBODY>
		<%
		}
	}
%>
<tr><td align=right colspan=8><input type=hidden name=TotalRec id=TotalRec value=<%=kk%>>
<INPUT TYPE="hidden" NAME="mCount" ID="mCount" VALUE=<%=mT%>>
<INPUT TYPE="hidden" NAME="NoStudent" ID="NoStudent" VALUE=<%=mNoStudent%>>
<input type=hidden ID=INSTITUTECODE NAME=INSTITUTECODE value=<%=mInst%>>
<input type=hidden ID=SRSEVENTCODE NAME=SRSEVENTCODE value=<%=msrseventcode%>>
<input type="submit" name=btn1 value="Allow Selected Subject/LTP for Printing"></td></tr>
</form>
</TABLE>
<table align=center cellspacing =1 cellpadding=8>
<tr>
<%
if(start!=1)
{
	%>
	<form method="Post" Action="SrsApprovalEmployee.jsp">
	<input id="x" name="x" type=hidden>
	<INPUT TYPE="hidden" NAME="Paging" VALUE="substract">
	<INPUT TYPE="hidden" NAME="mCount" ID="mCount" VALUE=<%=mT%>>
	<INPUT TYPE="hidden" NAME="NoStudent" ID="NoStudent" VALUE=<%=mNoStudent%>>
	<input type=hidden ID=INSTITUTECODE NAME=INSTITUTECODE value=<%=mInst%>>
	<input type=hidden ID=SRSEVENTCODE NAME=SRSEVENTCODE value=<%=msrseventcode%>>
	<input id="count" name="count" type=hidden value=<%=count%>>
	<INPUT TYPE="hidden" NAME="StartIndex" VALUE=<%=start%>>
	<INPUT TYPE="hidden" NAME="LastIndex" VALUE=<%=last%>>
	<td align="left"><INPUT TYPE="submit" style="background-color:#ff8c00; color=white; border-color=black; font-weight:bold" value="Previous" name="Previous"></td>
	</form>
	<%
}
//out.print("First - "+start+" Last - "+last+" Total - "+count);
if(last<count)
{
	%>
	<form method="Post" Action="SrsApprovalEmployee.jsp">
	<input id="x" name="x" type=hidden>
	<INPUT TYPE="hidden" NAME="Paging" VALUE="substract">
	<INPUT TYPE="hidden" NAME="mCount" ID="mCount" VALUE=<%=mT%>>
	<INPUT TYPE="hidden" NAME="NoStudent" ID="NoStudent" VALUE=<%=mNoStudent%>>
	<input type=hidden ID=INSTITUTECODE NAME=INSTITUTECODE value=<%=mInst%>>
	<input type=hidden ID=SRSEVENTCODE NAME=SRSEVENTCODE value=<%=msrseventcode%>>
	<input id="count" name="count" type=hidden value=<%=count%>>
	<INPUT TYPE="hidden" NAME="StartIndex" VALUE=<%=start%>>
	<INPUT TYPE="hidden" NAME="LastIndex" VALUE=<%=last%>>
	<td align="right"><INPUT TYPE="submit" style="background-color:#ff8c00; color=white; border-color=black; font-weight:bold" value="Next" name="Next"></td>
	</form>
	<%
}
%>
</tr>
</table>
<%
  //----------
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
}
%>

<table ALIGN=Center VALIGN=TOP>
<tr>
<td valign=middle><br>
<br>
<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">
<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>  
</td></tr></table>
</body>
</html>