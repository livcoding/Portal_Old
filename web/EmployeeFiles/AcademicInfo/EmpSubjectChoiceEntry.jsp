<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
ResultSet rso=null;
GlobalFunctions gb =new GlobalFunctions();
String mL="",mT="",mP="";
String qry="";
String qry1="";
String x="",t="",mfactype="",mDept="",moldsubjectid="";
int ctr=0;
int kk1=0;
int msno=0;

//======================================================
// No. of choices/subject preference HOD can provide. //

int mchoice=5;

//===================================================


String Tagg="";
int Data=0;
String v="";
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInstitute="";
String mExam="",mE="",mPrcode="";
String mexam="";
String mLTP="";
String mltp="";
String mName1="",mName2="",mName3="",mName4="",mName5="";
String mSubj="",mELECTIVECODE="";
String msubj="";
String mSubjType="";
String msubjType="",mST="";
String mSc="";	
String mCef="";	
String mEc="";	
String mVal="",mPExam="",mComp="";

if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}


String mLoginComp="";


if (session.getAttribute("LoginComp")==null)
{
	mLoginComp="";
}
else
{
	mLoginComp=session.getAttribute("LoginComp").toString().trim();
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
 
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Subject Choices entry by Employee ] </TITLE>


<script language=javascript>

	function RefreshContents()
	{ 	
    	    document.frm.x.value='ddd';
    	    document.frm.submit();
	}


function validate()
{
	
	var mTot=3;
	var mDup=0;
	var i=0;
	for (i = 1; i <= mTot;i++) 
	{ 	
	
		var  obj=document.getElementById("SUBJECT"+i);
		
		for (var j =1; j <= mTot;j++) 
		{ 	
			var  obj1=document.getElementById("SUBJECT"+j);
			//alert('Obj: i='+i+' Value: '+obj.value+'      Obj1: j='+j+' Value: '+obj1.value);
			if (i!=j && obj1.value==obj.value)
			   { 
				alert('Choice for the same subject already selected');					
				mDup=1;
				break;
			   }	
		}
		if(mDup==1)
		{
			return false;
			obj1.value='NONE';
			obj1.focus;				
			break;
		}
	   }
	  if(mDup==0)
	  {
		return true;
	  }
	

 }	


</script>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
try
{
	OLTEncryption enc=new OLTEncryption();

	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{
		mDMemberID=enc.decode(mMemberID);
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);
		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk=null;

		qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from institutemaster WHERE nvl(Deactive,'N')='N' ";
		rs=db.getRowset(qry);
		if(rs.next())
			mInstitute=rs.getString(1);	
		else
			mInstitute="JIIT";

	  //-----------------------------
	  //-- Enable Security Page Level  
	  //-----------------------------
		qry="Select WEBKIOSK.ShowLink('126','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		
	   	{
		  //----------------------
			qry="Select  nvl(PREREGEXAMID,' ') Exam from CompanyInstituteTagging where CompanyCode='"+mLoginComp+"' and InstituteCode='"+mInstitute+"'";
			//out.print(qry);
			rs=db.getRowset(qry);
			if(rs.next())
			{
			mPExam=rs.getString("Exam");		
			}
			qry=" Select 'y',nvl(SENDTOHOD,'N') SENDTOHOD,PREVENTCODE PREVENTCODE  from PREVENTS A WHERE INSTITUTECODE='"+ mInstitute +"' and nvl(APPROVED,'N')='Y' AND (PREVENTCODE) IN (SELECT  PREVENTCODE from PREVENTMASTER WHERE INSTITUTECODE='" + mInstitute +"' and Examcode='"+mPExam+"' ";
			qry=qry+" and NVL(FREEELECTIVERUNFINALIZED,'N')='Y'  and nvl(PRCOMPLETED,'N')='N' and nvl(PRBROADCAST,'N')='Y' and PRREQUIREDFOR='E'";
			qry=qry+" AND NVL(DEACTIVE,'N')='N') and nvl(LOADDISTRIBUTIONSTATUS,'N')='N' and nvl(ELRNNINGFINALIZEDBYHOD,'N')='Y' and MEMBERTYPE='E' and MEMBERID in ( select ";
			qry=qry+" EMPLOYEEID from HODLIST where DEPARTMENTCODE='"+mDept+"' and nvl(deactive,'N')='N') ";
			qry=qry+" and trunc(sysdate) between trunc(EVENTFROM) and trunc(EVENTTO) and nvl(DEACTIVE,'N')='N'";
			//out.print(qry);
			rs=db.getRowset(qry);
			
		if(rs.next())
		{		
		   if(rs.getString("SENDTOHOD").equals("N"))
			{
			 mPrcode=rs.getString("PREVENTCODE");
				%>
				<form name="frm"  method="get" >
				<input id="x" name="x" type=hidden>
				<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
				<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">Faculty Subject Choice Entry [Pre Registration]</TD>
				</font></td></tr>
				</TABLE>
				<table cellpadding=1 cellspacing=0 width="85%" align=center rules=groups border=3>
				<!--Institute****-->
				<INPUT name=InstCode TYPE=HIDDEN id="InstCode" VALUE='<%=mInstitute%>'>
				<tr>
				<!--*********Exam**********-->
				<td><FONT color=black><FONT face=Arial size=2><STRONG>Exam Code</STRONG></FONT></FONT>
				&nbsp;&nbsp;
				<%
				try
				{
					qry="Select  nvl(PREREGEXAMID,' ') Exam from CompanyInstituteTagging where CompanyCode='"+mLoginComp+"' and InstituteCode='"+mInstitute+"'";
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

				}
				%>
				</td>
				<td>				
				<INPUT Type="submit" Value="&nbsp;Show&nbsp;"></td></tr>
				</table>
				</form>
				<TABLE rules=all cellSpacing=0 width=90% cellPadding=0 border=1 align=center>
				<form name="frm1" ID="frm1" Action="EmpSubjectChoiceAction.jsp" method="post" onsubmit="return validate();">
				<tr bgcolor='#e68a06'>
				 <th>Sno.</th>
				 <th>Choice</th>
				 <th>Subject Description</th>
				 </tr>
				 <%
					if (request.getParameter("Exam")==null)
						mE=mexam;
					else
						mE=request.getParameter("Exam").toString().trim();
		
					if(mDMemberType.equals("E"))
						 mfactype="I";	
					else if(mDMemberType.equals("V"))
						 mfactype="E";
					
					for(int i=1;i<=mchoice;i++)
					{
					ctr++;
					mName3="SUBJECT"+String.valueOf(ctr).trim();
					%>
					<tr>
					<td><%=ctr%></td>
					<td>Choice<%=i%></td>
					<%
				mDMemberID="UNIV-D00008";
					qry="select distinct SUBJECTID SUBJECTID,FACULTYID FACULTYID from PR#FACULTYSUBJECTCHOICES where ";
					qry=qry+" INSTITUTECODE='"+mInstitute+"' and EXAMCODE='"+mE+"' and ";
					qry=qry+" FACULTYTYPE='"+mfactype+"' and choice='"+i+"' and FACULTYID='"+mDMemberID+"'";
					//out.print(qry);
					rso=db.getRowset(qry);
					if(rso.next())
					{
					moldsubjectid=rso.getString("SUBJECTID");	
					}
					else
					{
					  moldsubjectid=""; 			
					}
			
qry="select Distinct 'C' C,'Core' code, A.Subject SUBJECT, B.SubjectID SC,A.Subjectcode SC1, B.L L, B.T T, B.p P from PROGRAMSUBJECTTAGGING B, SUBJECTMASTER A";
qry=qry+ " Where A.SUBJECTID=B.SUBJECTID and B.INSTITUTECODE='"+mInstitute+"' and B.ExamCode='"+mE+"' And B.Basket='A' And ";
qry=qry+ " A.INSTITUTECODE=B.INSTITUTECODE and nvl(A.DEACTIVE,'N')='N' and nvl(B.deactive,'N')='N' ";
qry=qry+ " And (B.ACADEMICYEAR,B.PROGRAMCODE,B.TAGGINGFOR, B.SECTIONBRANCH,B.SUBJECTID)in (Select PR.ACADEMICYEAR,PR.PROGRAMCODE,PR.TAGGINGFOR, PR.SECTIONBRANCH, PR.SUBJECTID from PR#DEPARTMENTSUBJECTTAGGING PR where Pr.INSTITUTECODE='"+mInstitute+"' And Pr.EXAMCODE='"+mE+"' And Pr.DEPARTMENTCODE =(select departmentcode from v#Staff where EmployeeID='"+mDMemberID+"'))";

//qry=qry+ " and (B.AcademicYear,Semester) in (";
//qry=qry+ " Select SM.AcademicYear,SM.Semester+1 from StudentMaster SM Where ";
//qry=qry+ " SM.AcademicYear is not null and SM.Semester is not null and nvl(Deactive,'N')='N' Group By SM.AcademicYear,SM.Semester+1) ";

qry=qry+" and (To_number(B.L)>0 or To_number(B.T)>0 or To_number(B.p)>0 )  ";
qry=qry+" union ";
qry=qry+" select Distinct 'E' C,nvl(B.electivecode,' ')code, A.Subject SUBJECT , B.SubjectID SC,A.Subjectcode SC1, To_char(B.L) L, To_char(B.T) T, To_char(B.p)  P from SUBJECTMASTER A, ";
qry=qry+" PR#ELECTIVESUBJECTS B where A.INSTITUTECODE=B.INSTITUTECODE ";
qry=qry+" And B.INSTITUTECODE='"+mInstitute+"' AND B.SUBJECTRUNNING='Y' AND A.SUBJECTID=B.SUBJECTID and EXAMCODE='"+mE+"'";
qry=qry+ " And (B.ACADEMICYEAR,B.PROGRAMCODE,B.TAGGINGFOR, B.SECTIONBRANCH,B.SUBJECTID)in (Select PR.ACADEMICYEAR,PR.PROGRAMCODE,PR.TAGGINGFOR, PR.SECTIONBRANCH, PR.SUBJECTID from PR#DEPARTMENTSUBJECTTAGGING PR where Pr.INSTITUTECODE='"+mInstitute+"' And Pr.EXAMCODE='"+mE+"' And Pr.DEPARTMENTCODE =(select departmentcode from v#Staff where EmployeeID='"+mDMemberID+"'))";
qry=qry+" and nvl(A.DEACTIVE,'N')='N' and nvl(B.DEACTIVE,'N')='N'  ";  
qry=qry+" and (B.L >0 or B.T >0 or B.p >0 )  ";
qry=qry+" union ";	
qry=qry+" select Distinct B.SubjectType C, decode(B.SubjectType,'C','Core','Elective') code, A.Subject SUBJECT , B.SubjectID SC,A.Subjectcode SC1, B.L  L, B.T T, B.p P from SUBJECTMASTER A, ";
qry=qry+" OFFERSUBJECTTAGGING B where A.INSTITUTECODE=B.INSTITUTECODE ";
qry=qry+" And B.INSTITUTECODE='"+mInstitute+"' AND nvl(B.Deactive,'N')='N' AND A.SUBJECTID=B.SUBJECTID and B.EXAMCODE='"+mE+"'";
qry=qry+ " And (B.SUBJECTID)in (Select PR.SUBJECTID from PR#DEPARTMENTSUBJECTTAGGING PR  where Pr.INSTITUTECODE='"+mInstitute+"' And Pr.EXAMCODE='"+mE+"' And Pr.DEPARTMENTCODE =(select departmentcode from v#Staff where EmployeeID='"+mDMemberID+"'))";
qry=qry+" and nvl(A.DEACTIVE,'N')='N' and nvl(B.DEACTIVE,'N')='N' ";  
qry=qry+" and (to_number(B.L)>0 or to_number(B.T)>0 or to_number(B.p)>0 ) Order by Subject  ";
//out.print(qry);
		try{
					
						rs=db.getRowset(qry);	
				
				
				%>
					<td>
					<select name='<%=mName3%>' id='<%=mName3%>' style="Width:470">
				<%
					if(moldsubjectid.equals(""))
					{	
				%>
					<OPTION selected Value='NONE'>Select a Subject</option>
				<%	
					}
					else
					{
				%>
					<OPTION  Value='NONE'>Select a Subject</option>
				<%	
					}
					while(rs.next())
					{
					mSc=rs.getString("SC");	
					mCef=rs.getString("C");	
					mEc=rs.getString("Code");	
					mL=rs.getString("L");
					mT=rs.getString("T");
					mP=rs.getString("P");
					mVal=mSc+"***"+mCef+"///"+mEc+"###"+mL+"---"+mT+"==="+mP;
					
					if(moldsubjectid.equals(mSc))
					{
					%>
						<option selected value='<%=mVal%>'><%=rs.getString("SUBJECT")%>(<%=rs.getString("SC1")%>)-(<%=mEc%>)-(L:<%=mL%>&nbsp;T:<%=mT%>&nbsp;P:<%=mP%>)</option>
						 
					<%
					}
					else
					{
					%>
						<option value='<%=mVal%>'><%=rs.getString("SUBJECT")%>(<%=rs.getString("SC1")%>)-(<%=mEc%>)-(L:<%=mL%>&nbsp;T:<%=mT%>&nbsp;P:<%=mP%>)</option>

					<%
					}

					} // closing of while
			}
		catch(Exception e)
		{
			 
		}
					%>
					</select>
					</td>	</tr>
					<%
				
					} //closing of for 										
				%>			 
				<TR><TD colspan=6 ALIGN=CENTER><b>Send to HOD:-</b>
				<input checked type=radio id=radio1 name=radio1 value='N'><b>No</b>
				<input type=radio id=radio1 name=radio1 value='Y'><b>Yes</b>
				<INPUT Type="submit" Value="Save Subject Choices"></TD></TR>
				<input type=hidden Name='InstCode' ID='InstCode' value='<%=mInstitute%>'>
				<input type=hidden Name='ExamCode' ID='ExamCode' value='<%=mE%>'>
				<input type=hidden Name='TotalCount' ID='TotalCount' value='<%=ctr%>'>
				<input type=hidden Name='PREVENTCODE' ID='PREVENTCODE' value='<%=mPrcode%>'>
			</form>
			</TABLE>
			<font color=green>&nbsp; &nbsp; &nbsp; &nbsp;# Once choices are sent to HOD,you can not enter or modify your choice.</font>
		 <%
			
	        }
		  else
		  {
			%>
			<font color=red>
			<h3><br><img src='../../Images/Error1.jpg'>
			Pre- Registration / Subjects Choices have been already sent to HOD! <br><b>Click to view <a href='EmpSubjectChoiceView.jsp'><font  color=blue>Subject/Time and Room Preferences Sent to HOD</font></a></b>
			 <%
		  }
  		}
		else
		{
		%>
		<font color=red>
		<h3>	<br><img src='../../Images/Error1.jpg'>
		Pre- Registration Event has not been declared or Registration completed</FONT></P>
		 <%
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
}
catch(Exception e)
{
}
%>
</body>
</html>