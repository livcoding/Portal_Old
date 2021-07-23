<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="CommonFiles/ExceptionHandler.jsp" %> 
<%

DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
String mInst="",mCurExamCode="",mMemberID="";
int  mSemesterNo=0;
double mSGP=0, mCGP=0;      
String mSUBJ="", mGRD="", mGRP="", mCCP="", mECP="", mSGP1="", mCGP1="", mFail="";
String mStudentID="",mEnrollmentNo ="",mName="",mDMemberCode="",mWebEmail="";
ResultSet rs1=null,rsSub=null;

if (session.getAttribute("WebAdminEmail")==null)
{
	mWebEmail="";
}
else
{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
}


	if (session.getAttribute("MemberCode")==null)
	{
		mDMemberCode="";
	}
	else
	{
		mDMemberCode=session.getAttribute("MemberCode").toString().trim();
	}

	
	if (session.getAttribute("MemberID")==null)
	{
		mMemberID="";
	}
	else
	{
		mMemberID=session.getAttribute("MemberID").toString().trim();
	}

	if (request.getParameter("Semester")==null)
		mSemesterNo = 0;
	else
		mSemesterNo = Integer.parseInt(request.getParameter("Semester"));
		
	if (request.getParameter("CGP")==null)
		mCGP=0;
	else
		mCGP = Double.parseDouble(request.getParameter("CGP"));

	if (request.getParameter("CGP")==null)
		mSGP=0;
	else
		mSGP = Double.parseDouble(request.getParameter("SGP"));

	float   mSGPATot=0,  mCGATot = 0, mGP=0, mCCP1= 0,mEC0,mEC=0;

	if (request.getParameter("INSCODE")==null)
	{
		mInst="";
	}
	else
	{
		mInst=request.getParameter("INSCODE").toString().trim();
	}

	if (request.getParameter("SID")==null)
	{
		mStudentID="";
	}
	else
	{
		mStudentID=request.getParameter("SID").toString().trim();
	}



	 

	 


	ResultSet  Rs1=null,Rs2=null,StudentRecordSet=null;
	ResultSet  StudentRecordExam=null;
	String qry="";
	String qry1="";	
    	String mDspGrd  ="";
	String mIndGrd  ="";
	String mRemarks = "";	


/*	' **********************************************************************************************************
	' * File Name:	AcademicInformation.JSP		[For Students]						           *
	' * Author:		Ashok Kumar Singh 								           *
	' * Date:		10th Dec  2005										   *
	' * Version:	1.1							 				   	*
	' * Description: Displays Personal Info. of Students 							   *
	' **********************************************************************************************************
*/

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [Student CGPA Report]</TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="Styl 

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

  </head>
	<body  topmargin=0 rightmargin=0 leftmargin=0 bottommargin=0 background="../Images/Speciman.jpg">
	<br>
<%
try{
	OLTEncryption enc=new OLTEncryption();	

	if(!mMemberID.equals("")) 
	{
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
	mDMemberCode=enc.decode(mDMemberCode);
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
   
	qry="Select WEBKIOSK.ShowLink('139','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{

		    	
	String mSnm="",mENo="";
	qry="Select StudentName, Enrollmentno from StudentMaster where StudentID='"+mStudentID+"'";
	
	rs1=db.getRowset(qry);
	if(rs1.next())
	{
		mSnm=rs1.getString(1);
		mENo=rs1.getString(2);
	} 

  	//----------------------

%>

<CENTER><FONT face=Arial><FONT size=2><P align=center><FONT color=black>Student Name : <%=mSnm%>-<%=mENo%> &nbsp; &nbsp; &nbsp; </FONT>
<hr><b><FONT color=black><b>Student Examination Result Details of Semester <%=mSemesterNo%></b></FONT>&nbsp; 
	 </b></FONT>&nbsp;</FONT></FONT>
	 <br>
			<table frame=box align="center" borderColor=maroon cellSpacing=0 cellPadding=2 style="FONT-FAMILY: Arial; FONT-SIZE: x-small; FONT-STYLE: normal" borderColorDark=white>
			<tr style="BACKGROUND-COLOR: #ffa900">
			<th><FONT color=white face=Arial size=2>Subject (Subjcet Code)</FONT></th>
			<th><FONT color=white face=Arial size=2>Grade </FONT> </th>
			<th><FONT color=white face=Arial size=2>Grade Points </FONT>  </th>
			<th><FONT color=white face=Arial size=2>Course Credit Points</FONT>   </th>
			<th><FONT color=white face=Arial size=2>Earned Credit </FONT>  </th>
			<th><FONT color=white face=Arial size=2>SGPA POINTS </FONT></th>
			<th><FONT color=white face=Arial size=2>CGPA POINTS </FONT></th>
			<th><FONT color=white face=Arial size=2>FAIL </FONT> </th>
			</tr>
<%

        qry = "Select  decode(nvl(INDUSTRIALPROJECTGRADE,'F'),'F','Not Completed','Completed') INDUSTRIALPROJECTGRADE from studentindustrialgrade Where InstituteCode='" + mInst + "' and studentid='" + mStudentID.toString().trim() + "'"; // and  SEMESTER=" + mSemesterNo;
     //out.print(qry);
	  Rs1 = db.getRowset(qry);
      if( Rs1.next())	 
         mIndGrd = Rs1.getString(1);      	
      else
	 mIndGrd ="Not Completed";      
	
	
       qry = "Select  DISCIPLINARYGRADE from  STUDENTDISCIPLINARYGRADE Where InstituteCode='" +  mInst + "' and studentid='" + mStudentID.toString().trim()  + "' and  SEMESTER=" + mSemesterNo;
       Rs2 = db.getRowset(qry);

       if( Rs2.next())
     	  mDspGrd = Rs2.getString(1);
       else
          mDspGrd = "A+";

        qry ="Select  A.SubjectID SubjectID, GRADE, nvl(GRADEPOINT,0) GradePoint, NVL(A.COURSECREDITPOINT,0) COURSECREDITPOINT, nvl(EARNEDCREDIT,0) EARNEDCREDIT, nvl(CGPAPOINTS,0) CGPAPOINTS, nvl(FAIL,'N') FAIL, Nvl(SGPAPOINTS,0) SGPAPOINTS,nvl(SUBJECT,' ') SUBJECT, NVL(b.subjectcode ,'') subjectcode From studentresult#pub  A, SubjectMaster B  Where A.subjectid=b.subjectid  And A.InstituteCode=b.InstituteCode And A.InstituteCode='" + mInst + "' and studentid='" + mStudentID.toString().trim()  + "' and  SEMESTER=" + mSemesterNo + " Order By Semester";

     //   qry ="Select  NVL(SUBJECTID,'') subjectID, GRADE, nvl(GRADEPOINT,0) GradePoint, NVL(COURSECREDITPOINT,0) COURSECREDITPOINT, nvl(EARNEDCREDIT,0) EARNEDCREDIT, nvl(SGPAPOINTS,0) SGPAPOINTS, nvl(CGPAPOINTS,0) CGPAPOINTS, Decode(FAIL,'N','No','Y','Yes','No') FAIL From studentresult#pub  Where InstituteCode='" + mInst + "' and studentid='" + mStudentID.toString().trim()  + "' and  SEMESTER=" + mSemesterNo + " Order By  Grade Desc";
	  StudentRecordSet = db.getRowset(qry);
        if (StudentRecordSet.next())
	   	   {	//1
		do 
		{
		  //2
		 mSUBJ =StudentRecordSet.getString("Subject") + " ( " + StudentRecordSet.getString("SubjectCode") + " )";
	         mGRD = StudentRecordSet.getString(2);
	         mGRP = StudentRecordSet.getString(3);
	      	 mCCP = StudentRecordSet.getString(4);;
	         mECP = StudentRecordSet.getString(5);
	         mCGP1= StudentRecordSet.getString(6);
		 mSGP1= StudentRecordSet.getString(8);
     	   	 mFail = StudentRecordSet.getString(7);

      	        if(StudentRecordSet.getString("Fail").trim().equals("Y"))
			{
		 	%>
			<tr align="middle" >
		      <% 
			if (mRemarks.equals("P")) 
			{
			%>
			<td><FONT color=red><%=mSUBJ%></FONT></td>
		       <%
			 }
			else 
			{
			%>
			<td><FONT color=red><%=mSUBJ%></FONT></td>
		       <%
			 }
			%>

			<td><FONT color=red><%=mGRD%></FONT></td>
			<td><FONT color=red><%=mGRP%></FONT></td>
			<td><FONT color=red><%=mCCP%></FONT></td>
			<td><FONT color=red><%=mECP%></FONT></td>
			<td><FONT color=red><%=mSGP1%></FONT></td>
			<td><FONT color=red><%=mCGP1%></FONT></td>
		      <td><FONT color=red><%=mFail%></FONT></td>
           		</tr>
		
        		<%
			}
			 else 
			{
			%>		   	     	   	    	
			<tr align="middle">          	   	   	   	     	   	    
		      <% if (mRemarks.equals("P")) 
			{
			%>
			<td><FONT color=black><%=mSUBJ%></FONT></td>
		       <% }
			else 
			{	
			%>
			<td><FONT color=black><%=mSUBJ%></FONT></td>
		       <% }
			%>

			<td><FONT color=black><%=mGRD%></FONT></td>
			<td><FONT color=black><%=mGRP%></FONT></td>
			<td><FONT color=black><%=mCCP%></FONT></td>
			<td><FONT color=black><%=mECP%></FONT></td>		
			<td><FONT color=black><%=mCGP1%></FONT></td>
			<td><FONT color=black><%=mSGP1%></FONT></td>
                  <td><FONT color=black><%=mFail%></FONT></td>
           </tr>
          <%
	   }
          		mCGATot = mCGATot + StudentRecordSet.getFloat("CGPAPOINTS");
			mSGPATot = mSGPATot + StudentRecordSet.getFloat("SGPAPOINTS");
	            mGP = mGP + StudentRecordSet.getFloat("GradePoint");
                  mCCP1 = mCCP1 + StudentRecordSet.getFloat("COURSECREDITPOINT");
                  mEC = mEC + StudentRecordSet.getFloat("EARNEDCREDIT");
	}while(StudentRecordSet.next());  //2
} //1
	
       
  %>       
   <tr align="middle"  style="BACKGROUND-COLOR: #ffa900"><td colspan=2 align="right"><FONT color=black face=Arial size=2>Total &nbsp;</FONT></td>
    <td><%=mGP%></td>
    <td><%=mCCP1%></td>
		<td><%=mEC%></td>
		<td><%=mSGPATot%></td>
		<td><%=mCGATot%></td>
		<td>&nbsp;</td>
    </tr>
    </table> 
    <DIV align=center>
    <table frame=no  rules=groups borderColor=white borderColorDark=gray cellPadding=2 cellSpacing=0>
    <tr>
	<td><FONT color=blue face=Arial size=2>SGPA : <%=mSGP%></FONT>&nbsp; &nbsp; &nbsp;</td>
	<td><FONT color=blue face=Arial size=2>CGPA : <%=mCGP%></FONT>&nbsp; &nbsp; &nbsp;</td>
     <%if (mSemesterNo%2==0)
	{
	%>
		<td><FONT color=blue face=Arial size=2>Disciplinary Grade : <%=mDspGrd%></FONT></td>
	<% 
	}

	else 
	{
	%>
		<td>&nbsp;</td>
	<% 
	} 
	if ((mIndGrd.trim().length()==0) || mIndGrd==null)
	{
	%>
		<td>&nbsp;</td>
    <%
	 }
	else
	{
	 %>		
		<td><FONT color=blue face=Arial size=2>Industrial Grade : <%=mIndGrd%></FONT></td>
    <%
	 }
	
	 %>
    </tr>
    </table></DIV>
</center>
<!--<p align = justify>* Results of some subjects have not yet been declared, therefore final CGPA may undergo a change once balance results (if applicable) are uploaded.</p>-->
&nbsp;&nbsp;&nbsp;<HR align=center color=black noshade scrollleft="10" style="BACKGROUND-POSITION-X: 10px; HEIGHT: 2px; VERTICAL-ALIGN: middle; WIDTH: 677px">
<br></p>



 
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
	<h3>	<br><img src='../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font>	<br>	<br>	<br>	<br>
   <%
   }
  //-----------------------------

}
else
{
%><br>
Session timeout! Please <a href="../index.jsp">Login</a> to continue...
<%
}

}
catch(Exception e)
{
}
%>
<p align = center > 
<center>
<table width=60%> 
<tr><td valign=bottom><IMG style="WIDTH: 60px; HEIGHT: 60px" src="../Images/CampusConnectLogo.bmp" width=116 ></td>
<td align=right>  <FONT size =5 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT>
A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT></td></tr>
<tr><td colspan=2 align=right><FONT size =2>For your comments or suggestions please email at<A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>  
</td></tr></table>
	  
  </body>
</html>