<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>

<%
String qrty="",checkstatus="";ResultSet rsty=null;
/*

	' ********************************************************************************
	' *													   *
	' * File Name:	AppicationFromActionJPBS.JSP		[For Students]				  
	' * Author:		Ankur Verma				      
	' * Date:		24th Jan 2009				      
	' * Version:		1.2										
	' * Description:	Displays Application form status
	' **********************************************************************************
*/

try
{



%>
<html>
   <head>
	<title>Student Examination Result</title>		

<script language="JavaScript" type ="text/javascript">

if(window.history.forward(1) != null)
window.history.forward(1);
</script>

  </head>
<body topmargin=5 rightmargin=0 leftmargin=0 bottommargin=0 bgcolor=lightgoldenrodyellow  scroll=no>
<center>
 
<% 
ResultSet RSS=null, StudentRecordSet=null,rs1=null,rs2=null,rs=null; 	  
DBHandler db=new DBHandler();
String qry="", qry1="";
String mName ="";
String mStudentName="",mInstituteCode="",mDOB="",mDDNo="";
String mApplicationSlno="",mOp="",mDDType="";
String mAppl="",mTESTCODE="",mPERCENTAGE="";
String  qry2="",mQUALCODE="",mPERQUAL="",mAPPEARING="", mCall2="",mEmail="",rRank="";
 

if (request.getParameter("StudentName")!=null)
	mStudentName=request.getParameter("StudentName").toString().trim().toUpperCase();
else
	mStudentName="";

if (request.getParameter("InstCode")!=null)
	mInstituteCode=request.getParameter("InstCode").toString().trim();
else
	mInstituteCode="";

if (request.getParameter("DOB")!=null)
	mDOB=request.getParameter("DOB").toString().trim();
else
	mDOB="";



String mYear="";

qry="select to_char(sysdate,'yyyy')dd from dual";
rs=db.getRowset(qry);
if(rs.next())
mYear=rs.getString("dd");

mYear="2016";

if (!mStudentName.equals("") && !mDOB.equals(""))
{
/*	SELECT NVL (a.studentname, ' ') firstname, a.applicationslno, a.applicationno,       
       TO_CHAR (NVL (a.dateofbirth, SYSDATE), 'dd-MM-yyyy') dateofbirth, b.TESTCODE, b.PERCENTAGE
  FROM c#mbaapplicationmaster a,C#MBATESTSCORE b
 WHERE a.studentname = 'SAVITA SINGH'
 and a.dateofbirth='15-feb-1986'
 and a.APPLICATIONSLNO=b.APPLICATIONSLNO*/


	qry = "Select nvl(A.STUDENTNAME,' ')FirstName,nvl(A.APPLICATIONSLNO,' ') APPLICATIONSLNO,A.APPLICATIONNO,to_char(nvl(A.DATEOFBIRTH,SYSDATE),'dd-MM-yyyy'),NVL(b.EMAILID,' ')EMAILID   From c#MBAAPPLICATIONMASTER  A ,c#MBAAPPLICANTADD B where A.STUDENTNAME='"+mStudentName+"' AND A.APPLICATIONSLNO=B.APPLICATIONSLNO ";
	qry=qry+" and A.DATEOFBIRTH =to_date('"+mDOB+"','dd-mm-yyyy' ) and  Substr(A.APPLICATIONSLNO,1,4)='"+mYear+"' and  nvl(a.deactive,'N')='N'  ";
	//out.print(qry);
	
	StudentRecordSet = db.getRowset(qry); 	
   
	if (StudentRecordSet.next())
	 { 
	    mName = StudentRecordSet.getString("FirstName");      
		mAppl=StudentRecordSet.getString("APPLICATIONNO");                  
		mApplicationSlno=StudentRecordSet.getString("APPLICATIONSLNO").toString().trim();   
        mEmail= StudentRecordSet.getString("EMAILID");                  
		//out.print(qry);


		if (!mStudentName.equals(" "))
		{
		


	 		qry ="Select nvl(sum(nvl(AMOUNT,0)),0)amt,nvl(CHEQUEDDNO,' ')CHEQUEDDNO,CHQDDTYPE From c#MBAFEE Where APPLICATIONSLNO='"+mApplicationSlno+"' group by CHEQUEDDNO,CHQDDTYPE"	;		  
			//out.print(qry);
		 	RSS = db.getRowset(qry); 	  								
		 	if (RSS.next() && RSS.getDouble(1)>=1100 && RSS.getString("CHQDDTYPE").equals("D"))	
			{
			  
				mDDNo=RSS.getString("CHEQUEDDNO");
				mDDType=RSS.getString("CHQDDTYPE");
			//	out.print(mDDType+"asdax"+mDDNo);
			}
		  	else
			{
			mDDNo="";
			}
		 
	
	%>
	<br><br><br><hr>
	<% 
	if(!mApplicationSlno.equals(" "))
	  {	 

		%>
		<font color=green size=4  face='Verdana'><b>Your Application Form has been received.</b></font>
		<br>
		<%

	//out.print(mDDType+"asdax");
	if(mDDType.equals("D"))
		{
	
		%>
		<font color=Green size=4  face='Verdana'><b>  your DD has been received.</b></font>
		<%
		}
		else if(mDDNo.equals("")  && mDDType.equals("D") )
		{
		%>
		<!--<font color=Red size=6><b>Your DD of amount Rs. 800/- has not been received....</b></font>-->
		<font color=Red size=4><b>Your Application Form has been received but DD has not been received....  </b></font>
		<%
		}
		%>
		<hr>
		<table align=center  cellspacing=0 cellpadding=0 >
		<tr><td>
		<font color=Black size=3 face='Verdana'>
		<b>Applicant Name :&nbsp;</td><td><font color=Black size=3 face='Verdana'><b> <%=mName%> </b>
		</td></tr>
		<tr><td>
		<font color=Black size=3 face='Verdana'><b>Application Number :&nbsp;</td><td><font color=Black size=3 face='Verdana'><b><%=mAppl%></b></font>
		</td></tr>
		<tr><td>
		<font color=Black size=3 face='Verdana'><b>Email ID :&nbsp;</td><td><font color=Black size=3 face='Verdana'><b>
		<%
		if(mEmail.equals(" "))
		  {
			%>
			<font color=red> Not provided confirm earliest to <a href="mailto:jbs.helpcenter@jiit.ac.in">jbs.helpcenter@jiit.ac.in</a></font>
			<%
		  }
		  else
		  {
				%>
				<%=mEmail%>
				<%
		  }
			%>
		
		
		</b></font>
		</td></tr>
		<tr><td>
		<font color=Black size=3 face='Verdana'><b> CAT/MAT/CMAT/Other(GMAT/XAT) Result:&nbsp;
		</td><td><font color=Black size=3 face='Verdana'>
		<%
			try{
			qry1="select DECODE(testcode,'CMAT','CMAT','MAT','MAT','CAT','CAT','XAT','XAT','GMAT','GMAT','AWT','AWT')testcode, nvl(PERCENTAGE,0)PERCENTAGE,NVL(CALL2,'N')CALL2,nvl(Rank,'')Rank,nvl(b.CHECKSCORECARD,'N') CHECKSCORECARD From c#mbatestscore a,C#MBAAPPLICATIONMASTER b  where 		 a.APPLICATIONSLNO='"+mApplicationSlno+"' and a.APPLICATIONSLNO=b.APPLICATIONSLNO";
		//out.print(qry1);
			rs1 = db.getRowset(qry1); 	
			while(rs1.next())
			{
				 mTESTCODE=  rs1.getString("TESTCODE")==null?"": rs1.getString("TESTCODE").trim();
		
				 mPERCENTAGE= rs1.getString("PERCENTAGE")==null?"": rs1.getString("PERCENTAGE").trim();
				
				 mCall2= rs1.getString("CALL2")==null?"": rs1.getString("CALL2").trim();
				 //rRank= rs1.getString("RANK")
				 checkstatus=rs1.getString("CHECKSCORECARD")==null?"": rs1.getString("CHECKSCORECARD").trim();
//out.print(mTESTCODE+"@@@@"+mPERCENTAGE+"#####"+mCall2+"$$$$$<br>");
				 if(mPERCENTAGE.equals("0") && checkstatus.equals("N"))
				{
				 %>
					<font color=red face=verdana SIZE=2 ><b>  Not Submitted(Not eligible for shortlisting for GD/PI till such time the score card is provided) </b></font>&nbsp;
				 <%
				}
				 else
				{
					%>
					<b> <%=mTESTCODE%> Percentile - <%=mPERCENTAGE%></b>&nbsp;
				 <%
					if(mTESTCODE.equals("CMAT"))
					{
					 %>
						<b> Rank - <%=rs1.getString("Rank")==null?"":rs1.getString("Rank").trim()%></b>
					 <%
					}

				}
			}}catch(Exception e)
				{
			out.print(e);
			}
			%>
			</font>
			</td></tr>
			<tr>
			<td>
			<font color=Black size=3 face='Verdana'><b> 12<sup>th</sup> Score :<BR> Graduation Score : &nbsp;
			</td>
			<td>
			<%
			qry2="SELECT  decode(a.QUALIFICATIONCODE,'10TH','10th','12TH','12th','GRAD','Graduation',a.QUALIFICATIONCODE)QUALIFICATIONCODE, a.QUALIFICATIONDESC,nvl(a.PERCENTAGE,0)PERCENTAGE,nvl(decode(b.APPEARINGININST,'Y','Yes','N','No','No','',b.APPEARINGININST),' ') APPEARINGININST  FROM c#QUALIFICATION a , c#mbaapplicationmaster b where  a.APPLICATIONSLNO='"+mApplicationSlno+"' and a.APPLICATIONSLNO=b.APPLICATIONSLNO(+) and  a.QUALIFICATIONCODE <>'10TH'";
	
//out.print(qry2);
			rs2 = db.getRowset(qry2); 	
			while(rs2.next())
			{


				 mQUALCODE=  rs2.getString("QUALIFICATIONCODE").toString().trim();   
	
				 mPERQUAL= rs2.getString("PERCENTAGE").toString().trim(); 
				
				 mAPPEARING=rs2.getString("APPEARINGININST").toString().trim(); 



//out.print(mAPPEARING+"--"+mPERQUAL+"---"+mQUALCODE);

				 //Not provided, as yet
				if(mAPPEARING.equals("Yes") && mQUALCODE.equals("Graduation"))
				{
				 %>
				<font color=Black size=3 face='Verdana'><b>Appeared </b>
				 <%
				}
				else if (mAPPEARING.equals("No") )
				{
					 %>
					<font color=Black size=3 face='Verdana'><b>   <%=mQUALCODE%>  - 
					
					<%
						if(mPERQUAL.equals("0"))
					{
						%>
						<font color=red face=verdana SIZE=2 ><b>
							% Not provided, as yet
						</b>
						</font>
						<%
					}
					else
					{
					%>

				 	   <%=mPERQUAL%>%   
					
					<%
					}
					%>
					
					</b>
					 <%
				}
					else
				{
						%>
						<font color=Black size=3 face='Verdana'><B><%=mQUALCODE%>  - <%=mPERQUAL%>% </B></FONT>
						<%
				}%>
				
				 &nbsp;&nbsp;&nbsp;<BR>
				<%
			}
			%>
			</font>
			</td>
			</tr>
			<%
				
			qrty="select 'Y' from c#mbatestscore where nvl(CHECKSCORE,'N')='N' and  APPLICATIONSLNO='"+mApplicationSlno+"' ";	
			rsty = db.getRowset(qrty); 
			//out.print(qrty);
			if(rsty.next())
			{
			%>
			<tr><td>
		<font size="3" COLOR=Red face="Verdana"><b><sup>*</sup>&nbsp;HARDCOPY AWAITED</b></font>				
			</td></tr>


<%
			}	
%>
 <tr><td colspan=2><br><font color=green size=2 face='Verdana'><b>In case of variation please mail to <a href="mailto:jbs.helpcenter@jiit.ac.in">jbs.helpcenter@jiit.ac.in</a></b> </font><br>
	</td></tr> 
 <TR><TD colspan = 2 align = left> <br>
<font size="2" COLOR=red face="Verdana">


<!-- 04/02/2010 changes this matter -->


<p>

<b>Note:-</b>&nbsp;</font><br><font size="2" COLOR=GREEN face="Verdana"><b>&nbsp;(I)Next round of GD/PI -Date 27th<sup>th</sup> Feb 2016.
<br>
   (II) Shortlisted candidates shall be informed through-<bR>  
  (a) Email   
   (b) Courrier 
</b></font>
</p>

 </TD></TR>
	</table>
	<%
	}
	//else
	//{
	%>
		<!-- <font color=Red size=6><b>Your Application has been Rejected.</b></font>
		<hr>
		<table align=center width='50%'>
		<tr><td><br><br><br><br>
		<font color=Black size=3 face='Verdana'>
		<b>Applicant Name : <%=mName%> </b><br>
		<b><br>Application Number: <%=mAppl%></b><br>
		</td></tr>
		 <tr><td colspan=2><br><font color=green size=3 face='Verdana'><b>In case of variation please contact at <a href="mailto:jbs.helpcenter@jiit.ac.in">jbs.helpcenter@jiit.ac.in</a></b> </font><br>
	</td></tr>  -->
	<%
	//}
%>
	</table>
<hr>
</h1>
<%}
	}

else
	{
	%>
	<br><br><br><hr>
	<center>
	<h1><font color=red size=4  face='Verdana'>
			Your application has not yet been received <br> or <br> fill in correct Date of Birth and Name as given in Appliaction 
	</font></h1>
	<br>
	
	<br>
	<%
	}
}
else
{
	%>
	<br><br><br><hr>
	<center>
	<h1><font color=red size=6><br>Please enter Correct Applicant Name and Date of Birth </font></h1>
	<hr>
	<br>
	<%

}
}
catch(Exception e)
{

}
%>
</table>
<br><br><br><br><br>
<TABLE  WIDTH=100%><TR><td VALIGN=BOTTOM>
<IMG style="WIDTH: 40px; HEIGHT: 40px" src="../Images/CampusLynx.png"> <FONT style="FONT-FAMILY: cursive" 
size=4><B>Campus Lynx</B></FONT>   <FONT style="FONT-FAMILY: cursive" 
size=2>... an <B>IRP</B> Solution</FONT><BR>A product of <STRONG>JIL Information 
Technology Ltd.</STRONG></FONT><BR><FONT size=2>For your comments or suggestions 
please send an email at <A tabIndex=8 href="mailto:jiiterp@jiit.ac.in">jiiterp@jiit.ac.in</A></FONT> 
</td></tr></table></td></tr>


  </body>
</html>
