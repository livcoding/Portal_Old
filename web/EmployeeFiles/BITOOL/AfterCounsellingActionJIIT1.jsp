<%@ page language="java" import="java.sql.*,jpalumni.*,encryption.*" %>
<%@ page errorPage="CommonFiles/ExceptionHandler.jsp" %> 
<%
/*

	' ********************************************************************************
	' *													   *
	' * File Name:	AfterCounsellingActionJIIT.JSP		[For Students]				  
	' * Author:		Ashok Kumar Singh 							      
	' * Date:		19th May 2007								      
	' * Version:	1.1										
	' * Description:	Displays Branch Alloted detail
	' **********************************************************************************
*/

DBHandler db=new DBHandler();
ResultSet srs=null ; 	  
String qry="",qry11="";
String mValue="",mProgName="";
String mWInstName="";
String mInst="", mInstVal="";
long mAIEEENo=0;
long mJIITNo=0;
String mCat="";
String mName="";
String instituecode="";
String mYear="2009";
String mCNO="1";
ResultSet rs=null;
ResultSet CounsellingRecordSet=null,RsInstName=null;
ResultSet StudentRecordSet=null ; 	 
ResultSet BranchRecordSet=null;
ResultSet ChoiceRecordSet=null;
String qry1="";
String mInstituteCode="";
int mShow=0;
String mCtg="";
String mBranchAlot="";
String mBranchAgainstInst="";
String mAlpha="";
String mChoices="";
String mDate=null;
char mAlp;
String  mPType="";
String mrl="",mrnk="";
int mflag1=0,mflag=0;
String mRoll="";
String mCategory ="";
//int mCh=0;
    mValue=request.getParameter("TXT1").toString().trim();



mInstituteCode="JIIT";


%>
<html>
<head>
 
<title>Jaypee Institute of Information Technology</title>
<link href="../Resources/CSS/style.css" rel="stylesheet" type="text/css" />
<title>Jaypee Counselling 2009 (based on AIEEE examination)</title></head>
<body topmargin=5 rightmargin=0 leftmargin=10 bottommargin=0 bgcolor=lightgoldenrodyellow>
<br>  
<% 
try
{


    if (!mValue.equals(""))
    {

            qry="Select nvl(A.FIRSTNAME,' ')||' '|| nvl(A.MIDDLENAME,' ')||' '||nvl(A.LASTNAME,' ') Name, B.ROLLNOOFAIEEE, B.APPLIEDINSTITUTECODE INSTCODE, to_number(nvl(B.RANKINAIEEE,'-1')) RANKINAIEEE, to_number(nvl(B.RANKINJIIT,-1)) RANKINJIIT , Nvl(A.CategoryCode,'GEN') CategoryCode, nvl(A.OTHERCATEGORY,'GEN') OTHERCATEGORY ,nvl(HPRANK,'*')HPRANK ";
            qry=qry+" FROM C#APPLICATIONMASTER A, C#APPLICATIONMASTERDETAIL B ";
		qry=qry+" WHERE A.COUNSELLINGID=B.COUNSELLINGID AND A.APPLICATIONID=B.APPLICATIONID";
		qry=qry+" AND A.APPLICATIONNO IS NOT NULL AND B.ROLLNOOFAIEEE IS NOT NULL and B.RANKINAIEEE is not null and b.applicationslno is not null ";
            qry=qry+" AND B.ROLLNOOFAIEEE='"+mValue+"' and B.COUNSELLINGID='"+mYear+"' and  nvl(rejected,'N') ='Y'";           
		srs = db.getRowset(qry);
		while(srs.next())
		{
			mflag1++;
		}

		qry="Select nvl(A.FIRSTNAME,' ')||' '|| nvl(A.MIDDLENAME,' ')||' '||nvl(A.LASTNAME,' ') Name, B.ROLLNOOFAIEEE, B.APPLIEDINSTITUTECODE INSTCODE, to_number(nvl(B.RANKINAIEEE,'-1')) RANKINAIEEE, to_number(nvl(B.RANKINJIIT,-1)) RANKINJIIT , Nvl(A.CategoryCode,'GEN') CategoryCode, nvl(A.OTHERCATEGORY,'GEN') OTHERCATEGORY ,nvl(HPRANK,'*')HPRANK";
		qry=qry+" FROM C#APPLICATIONMASTER A, C#APPLICATIONMASTERDETAIL B ";
		qry=qry+" WHERE A.COUNSELLINGID=B.COUNSELLINGID AND A.APPLICATIONID=B.APPLICATIONID";
		qry=qry+" AND A.APPLICATIONNO IS NOT NULL AND B.ROLLNOOFAIEEE IS NOT NULL and B.RANKINAIEEE is not null and b.applicationslno is not null and nvl(b.REJECTED,'N') ='N' ";				
		qry=qry+" AND B.ROLLNOOFAIEEE='"+mValue+"' and B.COUNSELLINGID='"+mYear+"' ";
		srs = db.getRowset(qry);
		while(srs.next())
		{
			mflag++;
		}
	

         qry="Select nvl(A.FIRSTNAME,' ')||' '|| nvl(A.MIDDLENAME,' ')||' '||nvl(A.LASTNAME,' ') Name, B.ROLLNOOFAIEEE, B.APPLIEDINSTITUTECODE INSTCODE, to_number(nvl(B.RANKINAIEEE,'-1')) RANKINAIEEE, to_number(nvl(B.RANKINJIIT,-1)) RANKINJIIT , Nvl(A.CategoryCode,'GEN') CategoryCode, nvl(A.OTHERCATEGORY,'GEN') OTHERCATEGORY ,nvl(HPRANK,'*')HPRANK";
         qry=qry+" FROM C#APPLICATIONMASTER A, C#APPLICATIONMASTERDETAIL B ";
 		 qry=qry+" WHERE A.COUNSELLINGID=B.COUNSELLINGID AND A.APPLICATIONID=B.APPLICATIONID";
         qry=qry+" AND A.APPLICATIONNO IS NOT NULL AND B.RANKINAIEEE is not null  and b.applicationslno is not null and nvl(b.REJECTED,'N') ='N' AND B.ROLLNOOFAIEEE IS NOT NULL  ";
		 qry=qry+" AND B.ROLLNOOFAIEEE='"+mValue+"' and B.COUNSELLINGID='"+mYear+"' ";
         qry=qry+" and APPLIEDINSTITUTECODE='"+mInstituteCode+"' ";
        
//out.print(qry);
srs = db.getRowset(qry);
CounsellingRecordSet= db.getRowset(qry); 	

if (CounsellingRecordSet.next())	
{
	mrl=CounsellingRecordSet.getString("ROLLNOOFAIEEE"); 
	mrnk=CounsellingRecordSet.getString("RANKINAIEEE"); 
}


	qry="select  CATEGORY,nvl(CHOICENO,0) from C#categoryAppliedFor Where INSTITUTECODE='JIIT' And COUNSELLINGID='2009' ";
	qry+=" And PROGRAMTYPE='UG' And RANK='"+mrnk+"' And nvl (DEACTIVE,'N')='N' And nvl(ELIGIBLE,'N')='Y' Order By nvl(CHOICENO,0)";
//	out.print(qry);
	CounsellingRecordSet= db.getRowset(qry); 	
	if (CounsellingRecordSet.next())	
	    mCategory=CounsellingRecordSet.getString("CATEGORY");
	else
 	   mCategory="";

qry="Select A.PROGRAMTYPE PTYPE, Nvl(A.FROMCATEGORY,'"+mCategory+"') CategoryCode, nvl(S.NAME,' ') Name, nvl(S.ROLLNO,' ') ROLLNO , to_number(nvl(S.RANK,'-1')) RANKNO";
qry= qry +" From C#STUDENTMASTER S, C#ALLOCATIONDETAIL A where A.INSTITUTECODE=S.INSTITUTECODE and A.COUNSELLINGID=S.COUNSELLINGID and A.PROGRAMTYPE=S.PROGRAMTYPE and A.RANK=S.RANK";
qry= qry +" And  S.ROLLNO='" +  mrl + "' And S.RANK='" +  mrnk + "'  and S.RANK is not null and S.INSTITUTECODE='"+mInstituteCode+"' and A.COUNSELLINGID='"+mYear+"' and A.COUNSELLINGNO="+mCNO+"";
//out.print(qry);
CounsellingRecordSet= db.getRowset(qry); 	
if (CounsellingRecordSet.next())	
{
	mPType=CounsellingRecordSet.getString("PTYPE"); 

 	mAIEEENo=CounsellingRecordSet.getLong("RANKNO");   

	mName=CounsellingRecordSet.getString("Name");          

	mRoll=CounsellingRecordSet.getString("ROLLNO"); 
	
	mCtg=CounsellingRecordSet.getString("CategoryCode"); 
	qry = "Select  SUBSTR(TRIM(CHOICES),1,1) CHOICE";
	qry= qry + " From C#ALLOCATIONDETAIL where INSTITUTECODE='"+mInstituteCode+"' and RANK='" +mAIEEENo+"' and COUNSELLINGID='"+mYear+"' and COUNSELLINGNO='"+mCNO+"' and PROGRAMTYPE='"+mPType+"'";
	qry= qry + " and RANK is not null and Nvl(ABSENT,'N')='N' and (Nvl(COUNSELLINGDONE,'N')='Y' OR NVL (DIRECTWAITENTRY,'N')='Y')";
	//out.print(qry);
	StudentRecordSet = db.getRowset(qry);

	if(StudentRecordSet.next())
	 {
		qry="SELECT INSTITUTECODE  FROM C#SEATMASTER Where   PROGRAMTYPE='"+mPType+"' And  ALPHA='"+StudentRecordSet.getString("CHOICE")+"' And nvl(NOOFSEATS,0)>0 And nvl(DEACTIVE,'N')='N' and rownum=1";
		
		StudentRecordSet = db.getRowset(qry);
		if(StudentRecordSet.next())
		{
			if (StudentRecordSet.getString("INSTITUTECODE").equals("JUIT"))	
			 {
			   mShow=1;
			 }
	
			else if (StudentRecordSet.getString("INSTITUTECODE").equals("JIET"))	
			 {
			   mShow=2;
			 }
		}
	}



	%>			
		<font color=darkblue size=5 face=verdana><B><center>Jaypee Institute of Information Technology University, Noida</B></center></font>
		<br>
		<font color=green size=4 face=verdana><B><center>AIEEE based Counselling/Admission <%=mYear%> Status</B></center></font>
		<br>
		<table border="1" width="50%" align="center" bordercolordark="#008000" bordercolor="#008000" bordercolorlight="#008000">
		  <tr>
		    <td width="40%"><font color=green size=3><b>Name</b></font></td>
		    <td width="71%" align="left"><font color=green size=3><b><%=mName%></b></font></td>
		  </tr>
		  <tr>
		    <td width="40%"><font color=green size=3><b>Rank</b></td>
		    <td width="71%" align="left"><font color=green size=3><b><%=mAIEEENo%></b></font></td>
		  </tr>
		  <tr>
		    <td width="40%"><font color=green size=3><b>Roll No.&nbsp;</b></font></td>
		    <td width="71%" align="left"><font color=green size=3><b><%=mRoll%></b></font></td>
		  </tr>
		<%	
		//if(mShow==0)
	//	{
		String mLastBranch="";
		String mCurrentAlpha="", mFormerAlpha="", mAllotedProgram="",mFormerProgram="", mAllotInst="", mFormInst="",mFormerBranch="";

		qry = "Select Nvl(ALLOTEDBRANCH,'*') BRANCHALLOTED, Nvl(ALLOTEDINSTITUTE,'*') BRANCHAGAINSTINST , CHOICES, Nvl(ALLOTEDALPHA,'*') ALPHA, nvl(to_char(COUNSELLINGDATE,'DD-MM-YYYY'),' ') COUNSELLINGDATE,nvl(DEFAULTER,'N') DEFAULTER, nvl(FORMERINSTITUTE,'*')||'-'||nvl(FORMERBRANCH,'*') LastBranch, nvl(FORMERINSTITUTE,'*') FORMERINSTITUTE, nvl(FORMERBRANCH,'*') FORMERBRANCH, nvl(FORMERALPHA,'*') FORMERALPHA";
		qry= qry + " , NVL(ALLOTEDPROGRAM,' ') ALLOTEDPROGRAM, NVL(FORMERPROGRAM,' ') FORMERPROGRAM  From C#ALLOCATIONDETAIL where INSTITUTECODE='"+mInstituteCode+"' and RANK='" +mAIEEENo+"' and COUNSELLINGID='"+mYear+"' and COUNSELLINGNO='"+mCNO+"' and PROGRAMTYPE='"+mPType+"'";
		qry= qry + " and RANK is not null and Nvl(ABSENT,'N')='N' and (Nvl(COUNSELLINGDONE,'N')='Y' OR NVL (DIRECTWAITENTRY,'N')='Y')";

		 //out.print(qry);
		 
             StudentRecordSet = db.getRowset(qry);
		 if (StudentRecordSet.next())								
		 {	
		  if(StudentRecordSet.getString("DEFAULTER").equals("N"))
		     {
		    if(mShow==0)
		     {
			mBranchAlot=StudentRecordSet.getString("BRANCHALLOTED");          
			mBranchAgainstInst=StudentRecordSet.getString("BRANCHAGAINSTINST");
			mAlpha=StudentRecordSet.getString("ALPHA");       
			mChoices=StudentRecordSet.getString("CHOICES");
			mDate=StudentRecordSet.getString("COUNSELLINGDATE");
			mLastBranch=StudentRecordSet.getString("LastBranch");
			mAlp=mAlpha.charAt(0);
			mFormerAlpha=StudentRecordSet.getString("FORMERALPHA");
			mCurrentAlpha=mAlpha;
			mLastBranch=StudentRecordSet.getString("LastBranch");
			mAllotedProgram=StudentRecordSet.getString("ALLOTEDPROGRAM");          
			mFormerProgram=StudentRecordSet.getString("FORMERPROGRAM");          
			mFormerBranch=StudentRecordSet.getString("FORMERBRANCH");          
			
			qry="select SHORTNAME from C#InstituteMaster where InstituteCode='"+mBranchAgainstInst+"'";
			RsInstName = db.getRowset(qry);
		      if (RsInstName.next())								
			{
			mAllotInst=RsInstName.getString(1);
			}

			qry="select SHORTNAME from C#InstituteMaster where InstituteCode='"+StudentRecordSet.getString("FORMERINSTITUTE")+"'";
			RsInstName = db.getRowset(qry);
		      if (RsInstName.next())								
			{
			mFormInst=RsInstName.getString(1);
			}
			
			int i=0;
			if(mAlp=='*')				
				i=mChoices.indexOf("*");
			else
			 	i=mChoices.indexOf(mAlp);
			
			String mCh=mChoices.substring(0,i+1);
			char choice[]=mCh.toCharArray();
			if(mBranchAlot.equals("*"))
			{
				%>			   
				<tr>
				   <td width="40%"><font color=green size=3><b>Counselling Date&nbsp;</b></font></td>
			         <td width="71%" align="left"><font color=green size=3><b><%=mDate%></b></font></td>
				</tr>
				</table>	
				<%
			}
			else
			{
				%>
				<tr>
				   <td width="40%"><font color=green size=3><b>Counselling Date&nbsp;</b></font></td>
				   <td width="71%" align="left"><font color=green size=3><b><%=mDate%></b></font></td>
				</tr>
				<tr>
				  <!-- <td width="40%"><font color=green size=3><b>Upgraded Branch&nbsp;</b></font></td>-->
				   <td width="40%"><font color=green size=3><b>Branch Alloted&nbsp;</b></font></td>
				   <td width="71%" align="left"><font color=green size=3><b><%=mAllotInst%> &nbsp; <%=mAllotedProgram%>-<%=mBranchAlot%> (<%=mCurrentAlpha%>)</b></font></td>
				</tr>
				<%
				if(!mLastBranch.equals("*-*"))
				{
				%>			
				<tr>
				<td width="40%"><font color=green size=3><b>Former Branch&nbsp;</b></font></td>
				<td width="71%" align="left"><font color=green size=3><b><%=mFormInst%> &nbsp; <%=mFormerProgram%>-<%=mFormerBranch%> (<%=mCurrentAlpha%>)</b></font></td>
				</tr>
				<%
				}				
				%>
				</table>
				<%
			}



			if(choice.length>=1 || mBranchAlot.equals("*"))
			{
				int mHead=0;				
				
				qry="select BRANCHCODE BCODE,ALPHA,INSTITUTECODE from c#seatMaster Group By BRANCHCODE,ALPHA,INSTITUTECODE order by ALPHA";
				//**************for choices, branchcode and waiting list no**********
				for(int j=0;j<choice.length;j++)
	    			{
					BranchRecordSet= db.getRowset(qry); 				
					if(choice[j]!=(mAlp))
					{
						while(BranchRecordSet.next())			
						{
							char a = BranchRecordSet.getString("ALPHA").charAt(0);

							mWInstName=BranchRecordSet.getString("INSTITUTECODE");
							if(a==choice[j])
							{
								
							      if (mHead==0)
								{
								      mHead=1;
								      %>
								      <center><br><font color=green><b>Your Wait List status as per Choice form is :</b></font></center>
									<table width="50%" border="1" bordercolorlight="#008000" bordercolordark="#008000" align="center"><tr>
									<th width="20%"><font color=green>&nbsp;&nbsp;&nbsp;Choices&nbsp;&nbsp;&nbsp;</font></th>
									<th width="40%"><font color=green>&nbsp;&nbsp;&nbsp;Branch&nbsp;&nbsp;&nbsp;</font></th>
									<th width="40%"><font color=green>&nbsp;&nbsp;&nbsp;Wait List No&nbsp;&nbsp;&nbsp;</font></th>
									</tr>
								<%
								}

								qry11="select nvl(SHORTNAME,'*') SHORTNAME from C#InstituteMaster where InstituteCode='"+mWInstName+"'";
								//out.print(qry);
								RsInstName = db.getRowset(qry11);
							      if (RsInstName.next())								
								{
								   mWInstName=RsInstName.getString(1);
								}
								RsInstName=null;

								mProgName="";
								qry11="select PROGRAMCODE from C#Seatmaster where ALPHA='"+choice[j]+"'";
								//out.print(qry11);
								RsInstName = db.getRowset(qry11);
							      if (RsInstName.next())								
								{
								   mProgName=RsInstName.getString(1);
								}
								RsInstName=null;
								
								%>
								<tr><td><center><font color=green><%=choice[j]%></font></center></td>
								<td nowrap><font color=green><%=mWInstName%> &nbsp; <%=mProgName%>-<%=BranchRecordSet.getString("BCODE")%> </font></td>
								<%
								int WatingList = 0 ;
qry1="Select nvl(CHOICES,' ')CHOICES From C#ALLOCATIONDETAIL where RANK is not null AND to_number(RANK)<=" +mAIEEENo;
qry1= qry1 + " and INSTITUTECODE='"+mInstituteCode+"' and COUNSELLINGID='"+mYear+"' and COUNSELLINGNO='"+mCNO+"' and PROGRAMTYPE='"+mPType+"' and Nvl(DEFAULTER,'N')='N' ";
qry1= qry1 + " and Nvl(ABSENT,'N')='N' and (Nvl(COUNSELLINGDONE,'N')='Y' OR NVL (DIRECTWAITENTRY,'N')='Y') and nvl(FROMCATEGORY,'"+mCategory+"')='"+mCtg+"' and CHOICES LIKE '%"+choice[j]+"%'";
qry1=qry1+ " AND  nvl(fixit,'N')='N'  and Nvl(ALLOTEDALPHA,'*')<>'"+choice[j]+"'"; 
qry1=qry1+ " And  instr(choices,nvl(ALLOTEDALPHA,'*')) >= instr(choices,'"+choice[j]+"')";
qry1=qry1+ " order by RANK";
//out.print(qry1);
								ChoiceRecordSet= db.getRowset(qry1); 
	 							while(ChoiceRecordSet.next())
								{
									WatingList++;
								}//closing while loop
								if(WatingList==0)
								  WatingList++;
								%>
								<td><center><font color=green><%=WatingList%></center></font></td></tr>
								<%
							}//closing inner if
						}//closing while
					}//closing if
				}//closing for loop
			}//closing if
	//***********closing of getting choices, branchcode and waiting list no************
			%>	
			</font></table>
		</Center>
		<br>

			<br><hr> <br>



<!--<a href="3RD UPDATION - INSTRUCTIONS.pdf"><font color=blue><b>Instructions for Candidates upgraded from Waitlist.</b></font></a>-->
 <br><br> <br><br>

	<%



	} // clsoing of show==0

	else if (mShow==1)
	{
	%>
		<center><hr><font  face=verdana color=blue size=3><b> 
		<!--
		For Seat, Upgradation and Hostel status please contact :<br>
		Registrar, JUIT (Waknaghat) on the Tel. No.: 0172-239203 and Email <b><u>balbir.singh@juit.ac.in</u></b> , 			<b><u>gs.negi@juit.ac.in</u></b>
		-->
<A href="http://www.jiit.ac.in/Admission2008/Admission%20Lists/waitlist/IOM1_.doc">Click here to display your wait list status</A>
		</b> </font></center><br><hr>
	<%
	}

	else if(mShow==2)
	{

	%>
	<center><hr><font face=verdana color=blue size=3><b>
	 For Seat, Upgradation and Hostel status please contact :<br>
		     Registrar, JIET (GUNA) on the Tel. No.: +91-7544-267051, 267310-314 and Email 		              	             <b><u>sks.negi@jiet.ac.in</u></b> , <b><u>cd.babu@jiet.ac.in</u></b> 
		</b></font></center><hr><br>
	<%
	}



 	}

		// If not Data Found then
		else
		{
			%>
			</table>
			<hr>
			<center><font color=Red size=4>Sorry! You have withdrawn from counselling.</font></center>
			<br><br><hr>			
			<%
		}



	
      }
	// If not Data Found then
		else
		{
			%>
			</table>			
			<hr>
			<center><font color=Red size=4>Sorry ! You were not present for counselling / not completed the process</font></center>
			<br><br><hr>
			<!--<ul><li><i>The above results are subject to verificitation of your AIEEE all India Ranking.</i>
			<li><i>Variation in your data may be communicated to the <a Href="mailto:registrar@jiit.ac.in">registrar@jiit.ac.in</a></I>
			</ul>-->
			<%
		}



	
}
else
{
	%>
	<Center>
	<font  face=verdana color=red size=5><u>Sorry !</u></Center><br>
	<hr>
	<Center>
	<font color=Red size=4>No Such AIEEE Roll No / Application Number exists in our data</font></Center>
	<hr><br><br>
	<%
}
}
else
{
	%>
	<Center>
	<font color=red size=6><u>Sorry !</u></Center>
	<br>
	<hr>
	<Center><font color=Red size=4>AIEEE Roll No or Application Number must be entered</font></Center>
	<hr><br><br>
	<%
}
}
catch(Exception e)
{
  //out.print(qry);
}

%>
<TABLE align=center><TR><td VALIGN=BOTTOM>
<%
if(mShow>0)
{
%>
<br><br><br><br>
<%
}
%>
<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../Images/CampusConnectLogo.bmp"> <FONT style="FONT-FAMILY: cursive" size=4><B>Campus Connect</B></FONT>   <FONT style="FONT-FAMILY: cursive" size=2>... an <B>IRP</B> Solution</FONT><BR>A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><BR><FONT size=2>For your comments or suggestions please send an email at <A tabIndex=8 href="mailto:jiiterp@jiit.ac.in">jiiterp@jiit.ac.in</A></FONT> 
</td></tr></table>
</body>
</html>