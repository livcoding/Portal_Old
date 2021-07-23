<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%  
   int ctr=0;
   int ctr1=0;
   int ctr2=0;
   int mSNo=0;
   int mTotalCount=0,mTotalEvent =0,mTotalMarks =0;
   String mName1="",mName2="",mName3="",mName4="",mStudentname="",macad="",msem="";
   String mEnroll="",mRegDate="",mName5="";
   String qry="",mMarks="";
   String mL="",mT="",mP="",mCredit="";
   String mSC="",mInst="",mEC="",mWeightage="",mEvent="",mname="";
   int j=0;	
   ResultSet RsChk=null,rsc=null,rsl=null,rsa=null,rsltp=null,rsm=null,rs1=null,rs3=null;
   ResultSet rsg=null;	
   GlobalFunctions gb =new GlobalFunctions();
   DBHandler db=new DBHandler();
   String mMemberID="",mMemberType="",mMemberName="",mMemberCode="";	
   String mDMemberCode="",mDMemberType="",mDMemberID="",mEs="",mSems="",mDet="",mFEmp="";
   double mWeighatage=0,mvalue=0;
   double mWeig=0,mMax=0,mvalue1=0,mTot=0;
   try
   {
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

	/*
	' **********************************************************************************************************
	' *													   *
	' * File Name:	SignUpMemberBulk.JSP		[For Employee]			   *
	' * Author:		Rituraj Tyagi						         *
	' * Date:		21rd May 2007	 							   *
	' * Version:		1.0									   *	
	' **********************************************************************************************************
*/
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .75in 1.0in .75in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
-->
</style>
<title>Hide Stuff and Print</title>
</head>

<body leftmargin=5 topmargin=5>
<p align=right><b>Doc.No.:JIIT/DEPT/FT/03(00)</b></p>
<p align=center><b>TITLE: Ongoing performance record of students</b></p>

<%
		if (request.getParameter("SUBJECTCODE")==null )
			mSC="";
		 else
			mSC=request.getParameter("SUBJECTCODE").toString().trim();
		 if (request.getParameter("INSTITUTECODE")==null )
			mInst="";
		 else
			mInst=request.getParameter("INSTITUTECODE").toString().trim();

		 if (request.getParameter("EXAMCODE")==null )
			mEC="";
		  else
			mEC=request.getParameter("EXAMCODE").toString().trim();

		 if (request.getParameter("SEMESTERTYPE")==null )
			mSems="";
		  else
			mSems=request.getParameter("SEMESTERTYPE").toString().trim();
		if (request.getParameter("FACULTY")==null )
			mFEmp="";
		  else
			mFEmp=request.getParameter("FACULTY").toString().trim();



		qry="select distinct NVL(A.semester,0)semester ";
		qry=qry+" from V#EXAMEVENTSUBJECTTAGGING A where A.institutecode='"+mInst+"' ";
		qry=qry+" and A.examcode='"+mEC+"' and A.SEMESTERTYPE=decode('"+mSems+"','ALL',A.SEMESTERTYPE,'"+mSems+"') and A.employeeid='"+mFEmp+"' ";
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
	
		qry="Select NVL(A.ACADEMICYEAR,' ')ACADEMICYEAR  From V#EXAMEVENTSUBJECTTAGGING A where A.institutecode='"+mInst+"' ";
		qry=qry+" and A.examcode='"+mEC+"' and A.SEMESTERTYPE=decode('"+mSems+"','ALL',A.SEMESTERTYPE,'"+mSems+"') and A.employeeid='"+mFEmp+"' ";
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
		qry=qry+" employeeid='"+mFEmp+"' and facultytype=decode('"+mDMemberType+"','E','I','E') ";
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
	%>
<br>
<b>Course Name</b>&nbsp;&nbsp;<%=mname%>
&nbsp; &nbsp;  <b>Course No.</b>&nbsp;<%=rsc.getString("SUBJECTCODE") %>&nbsp; &nbsp;
<b>L :</b><%=mL%>&nbsp;<b>T :</b><%=mT%>&nbsp;<b>P :</b><%=mP%>&nbsp;<b>Cr:</b><%=mCredit%>
&nbsp; &nbsp;
<br>
&nbsp; &nbsp; &nbsp;<b>Semester :(Even/Odd)</b>&nbsp;&nbsp;<%=msem%>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
<!-- <b>Year :</b>&nbsp;&nbsp;<%=macad%> -->
 <b>Year :</b>&nbsp;&nbsp;<%=mEC%>

	<table border=1 Align=Left cellSpacing=0 cellPadding=0 width=100%>
	<START OF FILE>
	<%@page contentType="text/html"%>
   	<%
	response.setContentType("application/vnd.ms-excel");
	  %>
	<tr style="height:37pt;" vAlign=center align=right>

		<td align=left><b>Rollno.</font></b></td>
		<td align=left><b>Name</font></b></td>
		<%	
		qry="select distinct EVENTSUBEVENT ,WEIGHTAGE from ( ";
		qry=qry=qry+" select distinct EVENTSUBEVENT ,WEIGHTAGE,FROMDATE from V#EXAMEVENTSUBJECTTAGGING ";
		qry=qry+" where institutecode='"+mInst+"' and SEMESTERTYPE=decode('"+mSems+"','ALL',SEMESTERTYPE,'"+mSems+"') and examcode='"+mEC+"' and employeeid='"+mFEmp+"' ";
		qry=qry+" and facultytype=decode('"+mDMemberType+"','E','I','E') and subjectID='"+mSC+"'  ";
		qry=qry+" and eventsubevent  in (select eventsubevent from V#STUDENTEVENTSUBJECTMARKS ";
		qry=qry+" where institutecode='"+mInst+"' and SEMESTERTYPE=decode('"+mSems+"','ALL',SEMESTERTYPE,'"+mSems+"') and examcode='"+mEC+"' and employeeid='"+mFEmp+"'  ";
		qry=qry+" and facultytype=decode('"+mDMemberType+"','E','I','E') and subjectID='"+mSC+"')";
		qry=qry+" ORDER BY FROMDATE)";
		rsm=db.getRowset(qry);
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
		<td align=left><b><%=mEs%>(<%=mWeighatage%>)</b></td>
	<%	
		mIndx++;
		}		
	%>	
		<td align=left ><b>Total&nbsp;(<%=mwTot%>)</b></td>
		<td align=left><b>Grade</b></td>
		</tr>
		</thead>
		<tbody>

	<%
		
try{

	qry="select distinct fstid,nvl(studentid,' ')studentid,nvl(studentname,' ')studentname, ";
	qry=qry+" nvl(enrollmentno,' ')enrollmentno,nvl(semester,0)semester ";
	qry=qry+" from V#STUDENTEVENTSUBJECTMARKS ";
	qry=qry+" where institutecode='"+mInst+"' and SEMESTERTYPE=decode('"+mSems+"','ALL',SEMESTERTYPE,'"+mSems+"') And ";
	qry=qry+" examcode='"+mEC+"' and employeeid='"+mFEmp+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and subjectID='"+mSC+"'  order by enrollmentno" ;
	rs1=db.getRowset(qry);
	
	while(rs1.next())
	{	

 %>	
	<tr>
	<td><%=rs1.getString("enrollmentno")%></td>
	<td><%=GlobalFunctions.toTtitleCase(rs1.getString("studentname"))%></td>
	
<%
		for(int jp=0;jp<mIndx;jp++)
		{
		
			qry="Select nvl(A.MARKSAWARDED1,-1)MARKSAWARDED1,NVL(A.DETAINED,'N')DETAINED,nvl(A.MAXMARKS,0)MAXMARKS ";
			qry=qry+" from V#STUDENTEVENTSUBJECTMARKS A ";
			qry=qry+" where A.INSTITUTECODE='"+mInst+"' and A.SEMESTERTYPE=decode('"+mSems+"','ALL',A.SEMESTERTYPE,'"+mSems+"') and A.EXAMCODE='"+mEC+"' and ";
			qry=qry+" A.fstid='"+rs1.getString("fstid")+"' and A.STUDENTID='"+rs1.getString("studentid")+"' and A.subjectID='"+mSC+"' ";
			qry=qry+" And A.EVENTSUBEVENT='"+myEvent[jp]+"'";
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
				else if(mDet.equals("D") || mDet.equals("A") || mDet.equals("M"))
				{
				%>
				<td>&nbsp;</td>
				<%
				}	
				else
				{
				mTot=mTot+mvalue1;
					%>
				<td><%=mvalue1%></td>
				<%
				}
		}	// CLOSING OF if rs3
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
<br><br>
<b>(Signature of Instructor)</b>
<br><br>
Mark the Makeup Test Marks with red ink.
<hr>
<p align=left>Prepared by
&nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
Approved by</p>
<END OF FILE>

</body>

</html> 


<%
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

