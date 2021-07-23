<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%

DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
ResultSet rs2=null;
ResultSet rs3=null;
String qry="",mWebEmail="";
String qry1="",myLTP="",mChkvalue="";
int mSNO=0;
String mMemberID="";
String mMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mrfay="";
String mRFAY="";
String mName1=""	,mName2="",mName3="",mName4="",mName5="",mName6="",mName7="";
String mName8="", mName9="", mName10="";


String mInst="";
String minst="";

String mCCode="";
String mccode="";

String mSRSEventCode="";
String msrseventcode="";
String mName="";
String mPCode="",mpcode="";
String mBCode="";
String mbcode="";

String mSem="";

String mSubj="";
String msubj="";

String mLTP="";

String mFaculty="";
String mfaculty="";

String mEmp1="";
String mEName="";
String ass="";

String mSRSCont="";

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


 
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="TIET ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ SRS Finalization (After Printing Approval) ] </TITLE>
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

	qry="Select WEBKIOSK.ShowLink('47','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------
	

%>

<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">SRS Finalization [After Printing Approval]</TD>
</font></td></tr>
</TABLE>
<table cellpadding=2 cellspacing=0 align=center rules=groups border=3>

<!--Institute-->
<INPUT Type="Hidden" Name=ICCode id=mInst Value=<%=mInst%>>
<%
	qry="Select Distinct NVL(INSTITUTECODE,' ') IC from V#SRSEVENTS where  nvl(Approved,'N')='N' and nvl(Deactive,'N')='N'";
	rs=db.getRowset(qry);
	while(rs.next())
	{
		mInst=rs.getString("IC");
	}
%>
<!--Program**********-->
<tr><td nowrap><FONT color=black><FONT face=Arial size=2><STRONG>Program</STRONG></FONT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT>
<%
try
{ 
	qry="Select Distinct nvl(PROGRAMCODE,' ')PROGRAMCODE from v#SRSEVENTS where  nvl(Approved,'N')='N' and nvl(Finalized,'N')='N' and nvl(Deactive,'N')='N' order by PROGRAMCODE";
	rs=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		%>
		<select name=Program tabindex="0" id="Program" style="WIDTH: 120px">	
		<OPTION selected value=ALL>ALL</option>
		<%   
		while(rs.next())
		{
			mPCode=rs.getString("PROGRAMCODE");
			if(mPCode.equals(""))
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
	else
	{
		%>	
		<select name=Program tabindex="0" id="Program" style="WIDTH: 120px">	
		<%
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
<td nowrap><FONT color=black><FONT face=Arial size=2><STRONG>Subject</STRONG></FONT>&nbsp;</FONT>
<%
try
{ 
	qry1="Select Distinct 'ALL' SubjectID,'ALL' Subj from DUAL UNION Select Distinct B.SubjectID SubjectID, Subject||'( '||B.SubjectCode||' )' Subj from  V#SRSEVENTS B where nvl(B.Approved,'N')='N' and nvl(B.Deactive,'N')='N' and b.subjectid in (select distinct subjectid from v#srseventsuggestion where srseventcode=B.srseventcode and nvl(deactive,'N')='N') order by Subj";
	rs1=db.getRowset(qry1);

	if (request.getParameter("x")==null) 
	{
		%>
		<select name=Subject tabindex="0" id="Subject" style="WIDTH: 350px">	
		<%   
		while(rs1.next())
		{
			mSubj=rs1.getString("SubjectID");
			if(msubj.equals(""))
 			{msubj=mSubj;
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
		%>	
		<select name=Subject tabindex="0" id="Subject" style="WIDTH: 350px">	
		<%
	
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
<tr><td nowrap><FONT color=black><FONT face=Arial size=2><STRONG>SRS Event Code</STRONG></FONT></FONT>
<%
try
{ 
	qry="Select Distinct nvl(SRSEventCode,' ') SRSEVENTCODE from v#SRSEVENTS Where nvl(Approved,'N')='Y' and nvl(Deactive,'N')='N'";
	rs=db.getRowset(qry);
	if (request.getParameter("x")==null)
	{
		%>
		<select name=SRSEventCode tabindex="0" id="SRSEventCode" style="WIDTH: 120px">	
		<%   
		while(rs.next())
		{
			mSRSEventCode=rs.getString("SRSEVENTCODE");
			if(msrseventcode.equals(""))
 			msrseventcode=mSRSEventCode;
			%>
			<OPTION selected Value =<%=mSRSEventCode%>><%=mSRSEventCode%></option>
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name=SRSEventCode tabindex="0" id="SRSEventCode" style="WIDTH: 120px">	
		<%
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
		out.println(e.getMessage());
}
%>

</td>
<!--Faculty***********-->
 <td nowrap><FONT color=black><FONT face=Arial size=2><STRONG>Faculty</STRONG></FONT>&nbsp; </FONT>
<%
try
{ 
	qry="select Distinct nvl(A.EMPLOYEEID,' ') EMPLOYEEID,nvl(EMPLOYEENAME,' ') EMPLOYEENAME from v#SRSEvents A";
	qry=qry +" Where nvl(A.Approved,'N')='N' and nvl(A.Deactive,'N')='N' and A.employeeid in (select distinct employeeid from v#srseventsuggestion where srseventcode=A.srseventcode  and nvl(deactive,'N')='N') order by EMPLOYEENAME ";
	
	rs=db.getRowset(qry);
	if (request.getParameter("x")==null)
	{
		%>
		<select name=Faculty tabindex="0" id="Faculty" style="WIDTH: 245px">	
		<OPTION selected Value=ALL>ALL</option>
		
		<%   
		while(rs.next())
		{
			mFaculty=rs.getString("EMPLOYEEID");
			if(mFaculty.equals(""))			
 			mfaculty=mFaculty;
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
		%>	
		<select name=Faculty tabindex="0" id="Faculty" style="WIDTH: 245px">	
		<%
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
	out.println(e.getMessage());
} 
String mT="";
if(request.getParameter("mCount")==null)
	mT=mSRSCont;
else
	mT=request.getParameter("mCount").toString().trim();

%> 
<tr><td nowrap></td><td nowrap><FONT color=black face=Arial size=2><strong>SRS Count >=&nbsp;&nbsp;</strong></FONT><INPUT style="Text-Align=right" Type="Text" size=3 maxlength=3 Name=mCount id=mCount Value=<%=mT%>>
&nbsp;<INPUT Type="submit" Value="Show/Refresh"></td></tr>
</table></form>
<TABLE  rules=Rows cellSpacing=0 cellPadding=0 width="100%" border=1 >
<form name=frm1 action="EmpFinalizedSRSAction.jsp" method=post>
<tr bgcolor="#ff8c00">
 <td><b><font color="white">Program</font></td>
 <td><b><font color="white">Section-<br>Subsection</font></td>
 <td><b><font color="white">Subject</font></td>
 <td><b><font color="white">Faculty Name </font></td>
 <td><b><font color="white">LTP</font></td>
 <td><b><font color="white" size=2>Total <br>Stdents</font></td>
 <td><b><font color="white" size=2>SRS <br>Submitted</font></td>
<td><b><font color="white" size=2>Finalize?<br><input onClick="un_check()" type="checkbox" id='allbox' name='allbox' value='Y'>All</font></td>
</tr>
 <%
//------------------  

msubj=request.getParameter("Subject").toString().trim();
mfaculty=request.getParameter("Faculty").toString().trim();
mpcode=request.getParameter("Program").toString().trim();
msrseventcode=request.getParameter("SRSEventCode").toString().trim();
minst=request.getParameter("ICCode").toString().trim();
int mCounter=0;

if (request.getParameter("mCount")==null)
	mCounter=1;
else
	mCounter=Integer.parseInt(request.getParameter("mCount").toString().trim());

  qry="select Distinct FACULTYTYPE, A.EMPLOYEEID, EXAMCODE,ACADEMICYEAR, PROGRAMCODE, TAGGINGFOR  ";
  qry=qry+" ,SECTIONBRANCH, SUBSECTIONCODE, SEMESTER, SEMESTERTYPE, BASKET, SUBJECTCODE, SUBJECTID, SRSEVENTCODE,";   
  qry=qry+" INSTITUTECODE, Count(distinct studentid) TotalSubmitted FROM V#SRSEVENTSUGGESTION A";
  qry=qry+" where A.INSTITUTECODE='"+ mInst + "' and SRSEVENTCODE='"+msrseventcode+"'";
  qry=qry+" and A.EmployeeID=decode('"+mfaculty+"','ALL',A.EmployeeID,'"+mfaculty+"') ";
  qry=qry+" And A.PROGRAMCODE=decode('"+mpcode+"','ALL',A.PROGRAMCODE,'"+mpcode+"')";
  qry=qry+" And nvl(A.deactive,'N')='N' And A.SUBJECTID=decode('"+msubj+"','ALL',A.SUBJECTID,'"+msubj +"')  ";
  qry=qry+" and ( FACULTYTYPE, A.EMPLOYEEID, EXAMCODE,ACADEMICYEAR, PROGRAMCODE, TAGGINGFOR  ";
  qry=qry+" ,SECTIONBRANCH, SUBSECTIONCODE, SEMESTER, SEMESTERTYPE, BASKET, SUBJECTID, SRSEVENTCODE,";   
  qry=qry+" INSTITUTECODE) in (select  FACULTYTYPE, EMPLOYEEID, EXAMCODE,ACADEMICYEAR, PROGRAMCODE, TAGGINGFOR  ";
  qry=qry+" ,SECTIONBRANCH, SUBSECTIONCODE, SEMESTER, SEMESTERTYPE, BASKET, SUBJECTID, SRSEVENTCODE,";   
  qry=qry+" INSTITUTECODE from v#srsevents where nvl(Approved,'N')='Y'  and nvl(Finalized,'N')='N' and nvl(Deactive,'N')='N' )";
  qry=qry+" Group by FACULTYTYPE, A.EMPLOYEEID, EXAMCODE,ACADEMICYEAR, PROGRAMCODE, TAGGINGFOR  ";
  qry=qry+" ,SECTIONBRANCH, SUBSECTIONCODE, SEMESTER, SEMESTERTYPE, BASKET, SUBJECTCODE, SUBJECTID, SRSEVENTCODE,InstituteCode";   
  qry=qry+" Having count(distinct studentid)>="+mCounter;
  //out.print(qry);
  rs=db.getRowset(qry);
  int kk=0;
  long mTotStrength=0, mTotSentStrength=0;
  while(rs.next())
  {

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
		qry=qry +" In (select INSTITUTECODE, FACULTYTYPE, EMPLOYEEID, EXAMCODE, ACADEMICYEAR, PROGRAMCODE, TAGGINGFOR, SECTIONBRANCH, BASKET, SEMESTER, SUBJECTID,LTP  ";
		qry=qry+" from v#SRSEVENTS SS where  SRSEVENTCODE='"+ msrseventcode+"' And SUBJECTID='"+rs.getString("SUBJECTID")+"' and nvl(APPROVED,'N')='Y'  and nvl(Finalized,'N')='N' and nvl(DEACTIVE,'N')='N')";
//		out.print(qry);
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
	out.println("err");
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
		try{
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
		mName3="SUBJECTCODE_"+String.valueOf(kk).trim(); 		 		
		mName4="LTP_"+String.valueOf(kk).trim(); 		 		
		mName5="Approved_"+String.valueOf(kk).trim(); 		 		
		mName6="ExamCode_"+String.valueOf(kk).trim(); 		 		
		mName7="EmployeeNM_"+String.valueOf(kk).trim(); 		 		
		mName8="Section_"+String.valueOf(kk).trim();
		mName9="SubSection_"+String.valueOf(kk).trim();
		mName10="SUBJECTID_"+String.valueOf(kk).trim(); 		 		

		%>
		<TR>
		<input type=hidden Name='<%=mName1%>' ID='<%=mName1%>' value='<%=rs.getString("EmployeeID")%>'>
		<input type=hidden Name='<%=mName2%>' ID='<%=mName2%>' value='<%=rs.getString("PROGRAMCODE")%>'>
		<input type=hidden Name='<%=mName3%>' ID='<%=mName3%>' value='<%=rs.getString("SUBJECTCODE")%>'>
		<input type=hidden NAME='<%=mName6%>' ID='<%=mName6%>' value='<%=rs.getString("EXAMCODE")%>'>
		<input type=hidden Name='<%=mName4%>' ID='<%=mName4%>' value='<%=myLTP%>'>
		<input type=hidden Name='<%=mName7%>' ID='<%=mName7%>' value='<%=mEName%>'>
		<input type=hidden Name='<%=mName8%>' ID='<%=mName8%>' value='<%=rs.getString("SECTIONBRANCH")%>'>
		<input type=hidden Name='<%=mName9%>' ID='<%=mName9%>' value='<%=rs.getString("SUBSECTIONCODE")%>'>
		<input type=hidden Name='<%=mName10%>' ID='<%=mName10%>' value='<%=rs.getString("SUBJECTID")%>'>

		<td><%=rs.getString("PROGRAMCODE")%></td>
 		<td><%=rs.getString("SECTIONBRANCH")%>-<%=rs.getString("SUBSECTIONCODE")%></td> 	
		<td><%=rs.getString("SUBJECTCODE")%></td>
		<td><font size=2><%=mEName%></td>
		<td><%=GlobalFunctions.getSortedLTPSQ(mLTP)%></td>
		<td><%=mTotStrength%></td>
		<td><%=mTotSentStrength%></td>
		<td><input type='checkbox' value='Y' ID='<%=mName5%>' Name='<%=mName5%>'></td>
		</tr>
		<%
		}
	}

%>
<tr><td align=right colspan=8><input type=hidden name=TotalRec id=TotalRec value=<%=kk%>>
<input type=hidden ID=INSTITUTECODE NAME=INSTITUTECODE value=<%=mInst%>>
<input type=hidden ID=SRSEVENTCODE NAME=SRSEVENTCODE value=<%=msrseventcode%>>
<input type="submit" name=btn1 value="Finalize Selected Subject/LTP"></td></tr>
</form>
</TABLE>

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