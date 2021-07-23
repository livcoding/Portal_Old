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
ResultSet Rst=null, srs=null ; 	  
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
 
mValue=request.getParameter("TXT1").toString().trim();

long mJIITRankFrom =30024, mJIITRankTo=40364 ;	

mInstituteCode="JIIT";

//long mJIITLastSCRank=80648;
//long mJIITLastSTRank=81173;
//long mJIITLastGENRank=29995;

long mJIITLastSCRank1=80648;
long mJIITLastSTRank1=81173;
long mJIITLastGENRank1=29995;

long mJIITLastSCRank2=80648;
long mJIITLastSTRank2=81173;
long mJIITLastGENRank2=40364;

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

	qry="Select A.PROGRAMTYPE PTYPE, Nvl(A.FROMCATEGORY,'"+mCategory+"') CategoryCode, nvl(S.NAME,' ') Name, nvl(S.ROLLNO,' ') ROLLNO , to_number(nvl(S.RANK,'-1')) RANKNO, nvl(Absent,'N') Absent";
	qry= qry +" From C#STUDENTMASTER S, C#ALLOCATIONDETAIL A where A.INSTITUTECODE=S.INSTITUTECODE and A.COUNSELLINGID=S.COUNSELLINGID and A.PROGRAMTYPE=S.PROGRAMTYPE and A.RANK=S.RANK";
	qry= qry +" And  S.ROLLNO='" +  mrl + "' And S.RANK='" +  mrnk + "'  and S.RANK is not null and S.INSTITUTECODE='"+mInstituteCode+"' and A.COUNSELLINGID='"+mYear+"' and A.COUNSELLINGNO="+mCNO+"  and nvl(S.Deactive,'N')='N'";
	//out.print(qry);
	CounsellingRecordSet= db.getRowset(qry); 	
	if (CounsellingRecordSet.next())	
	{
	 if(CounsellingRecordSet.getString("ABSENT").equals("N"))
		{
			mPType=CounsellingRecordSet.getString("PTYPE"); 
		 	mAIEEENo=CounsellingRecordSet.getLong("RANKNO");   
			mName=CounsellingRecordSet.getString("Name");          
			mRoll=CounsellingRecordSet.getString("ROLLNO"); 
			mCtg=CounsellingRecordSet.getString("CategoryCode"); 
			 
			%>			
			<font color=darkblue size=5 face=verdana><B><center>Jaypee Institute of Information Technology University, Noida</B></center></font>
			<br>
			<font color=green size=4 face=verdana><B><center>AIEEE based Counselling/Admission <%=mYear%>	Status</B></center></font>
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
		String mLastBranch="";
		String mCurrentAlpha="", mFormerAlpha="", mAllotedProgram="",mFormerProgram="", mAllotInst="", mFormInst="",mFormerBranch="";
		qry = "Select Nvl(ALLOTEDBRANCH,'*') BRANCHALLOTED, Nvl(ALLOTEDINSTITUTE,'*') BRANCHAGAINSTINST , Nvl(ALLOTEDALPHA,'*') ALPHA, nvl(to_char(COUNSELLINGDATE,'DD-MM-YYYY'),' ') COUNSELLINGDATE,nvl(DEFAULTER,'N') DEFAULTER, nvl(FORMERINSTITUTE,'*')||'-'||nvl(FORMERBRANCH,'*') LastBranch, nvl(FORMERINSTITUTE,'*') FORMERINSTITUTE, nvl(FORMERBRANCH,'*') FORMERBRANCH, nvl(FORMERALPHA,'*') FORMERALPHA, choices ";
		qry= qry + " , NVL(ALLOTEDPROGRAM,' ') ALLOTEDPROGRAM, NVL(FORMERPROGRAM,' ') FORMERPROGRAM  From C#ALLOCATIONDETAIL where INSTITUTECODE='"+mInstituteCode+"' and RANK='" +mAIEEENo+"' and COUNSELLINGID='"+mYear+"' and COUNSELLINGNO='"+mCNO+"' and PROGRAMTYPE='"+mPType+"'";
		qry= qry + " and RANK is not null and Nvl(ABSENT,'N')='N' and (Nvl(COUNSELLINGDONE,'N')='Y' OR NVL (DIRECTWAITENTRY,'N')='Y')";

//		 out.print(qry);
		 
             StudentRecordSet = db.getRowset(qry);
		 if (StudentRecordSet.next())								
		 {	
		    if(StudentRecordSet.getString("DEFAULTER").equals("N"))
		      {		   
			 mBranchAlot=StudentRecordSet.getString("BRANCHALLOTED");          
			 mBranchAgainstInst=StudentRecordSet.getString("BRANCHAGAINSTINST");
			 mAlpha=StudentRecordSet.getString("ALPHA");       

			/* qry="select  CHOICENO, ALPHA from C#choicemaster Where INSTITUTECODE='"+mInstituteCode+"' And COUNSELLINGID='"+mYear+"' And RANK='"+mAIEEENo+"' and COUNSELLINGNO='"+mCNO+"' and PROGRAMTYPE='"+mPType+"' and nvl(DEACTIVE,'N')='N' order by  CHOICENO ";
			 //out.print(qry);

			 Rst=db.getRowset(qry);
			 while(Rst.next())
			    {
				  if(mChoices.equals("*"))
					mChoices= Rst.getString("ALPHA");
					else
					mChoices=mChoices+Rst.getString("ALPHA");
			    }
				 if(!mChoices.equals("*"))
					 mChoices=mChoices+"*";
			*/
			mChoices=StudentRecordSet.getString("CHOICES");
			//out.print(mChoices);
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

/*qry1="Select RANK  From C#ALLOCATIONDETAIL A where RANK is not null AND to_number(RANK)<=" +mAIEEENo;
qry1= qry1 + " and INSTITUTECODE='"+mInstituteCode+"' and COUNSELLINGID='"+mYear+"' and COUNSELLINGNO='"+mCNO+"' and PROGRAMTYPE='"+mPType+"' and Nvl(DEFAULTER,'N')='N' ";
qry1= qry1 + " and Nvl(ABSENT,'N')='N' and (Nvl(COUNSELLINGDONE,'N')='Y' OR NVL (DIRECTWAITENTRY,'N')='Y') and nvl(FROMCATEGORY,'"+mCategory+"')='"+mCtg+"' and exists (Select 1 from C#choicemaster B Where b.INSTITUTECODE='"+mInstituteCode+"' And b.COUNSELLINGID='"+mYear+"' And b.COUNSELLINGNO='"+mCNO+"' And b.PROGRAMTYPE='"+mPType+"' And B.RANK=A.RANK and b.ALPHA='"+choice[j]+"' And nvl(b.Deactive,'N')='N')";
qry1=qry1+ " AND  Nvl(Fixit,'N')='N'  and Nvl(ALLOTEDALPHA,'*')<>'"+choice[j]+"'"; 
qry1=qry1+ " AND ( A.AllotedALPHA is Null or Exists (Select 1 From C#ChoiceMaster C Where c.INSTITUTECODE='"+mInstituteCode+"' And c.COUNSELLINGID='"+mYear+"' And c.COUNSELLINGNO='"+mCNO+"' And c.PROGRAMTYPE='"+mPType+"' And c.RANK=A.RANK And Nvl(C.ALPHA,'*')='"+choice[j]+"' And C.ChoiceNo<(Select max(D.ChoiceNo) From C#ChoiceMaster D Where D.INSTITUTECODE='"+mInstituteCode+"' And D.COUNSELLINGID='"+mYear+"' And D.COUNSELLINGNO='"+mCNO+"' And D.PROGRAMTYPE='"+mPType+"' And D.RANK=A.RANK  And D.ALPHA=Nvl(A.ALLOTEDALPHA,'*')))) And   Nvl(A.ALLOTEDALPHA,'*')<>'"+choice[j]+"'"; 
qry1=qry1+ " order by RANK";*/
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

 <br><br> <br><br>

	<%
	} 
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


		}//CounsellingRecordSet.getString("ABSENT").equals("N"))
		else
		{
		%>
		</table>			
			<hr>
			<center><font color=Red size=4>Sorry ! You have missed the first round of counselling and hence you are not qualified for Wait Listing or subsequent Counselling.</font></center>
			<br><br><hr>
		<%
		}	
}
else
{


	qry="Select     nvl(S.NAME,' ') Name, nvl(S.ROLLNO,' ') ROLLNO , to_number(nvl(S.RANK,'-1')) RANKNO ";
	qry= qry +" From C#STUDENTMASTER S   where  S.ROLLNO='" +  mrl + "' And S.RANK='" +  mrnk + "'   and COUNSELLINGID='"+mYear+"'  and nvl(S.Deactive,'N')='N'";
	//out.print(qry);
	CounsellingRecordSet= db.getRowset(qry); 	
	if (CounsellingRecordSet.next())	
		{
			 
		 	mAIEEENo=CounsellingRecordSet.getLong("RANKNO");   
			mName=CounsellingRecordSet.getString("Name");          
			mRoll=CounsellingRecordSet.getString("ROLLNO"); 
			 
		}

   qry="Select  FINALATTENDANCE from C#STUDENTATTENDANCE where InstituteCode='"+mInstituteCode+"' and COUNSELLINGID='"+mYear+"' ";
   qry+=" and PROGRAMTYPE='UG' and RANK='"+mrnk+"' and  nvl(FINALATTENDANCE,'*')='A' and COUNSELLINGNO="+mCNO ;
   
   //out.print(qry);

   CounsellingRecordSet= db.getRowset(qry); 
   int mFlg=0;
   int mFlags=0;
   int mPrint =0;
	if(CounsellingRecordSet.next())
	{
		mFlg++;
		mPrint=1;
		%>
		<font color=darkblue size=5 face=verdana><B><center>Jaypee Institute of Information Technology University, Noida</B></center></font>
			<br>
			<font color=green size=4 face=verdana><B><center>AIEEE based Counselling/Admission <%=mYear%>	Status</B></center></font>
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
		   </table>			
			<hr>
			<center><font  face=verdana color=Red size=6><u>Sorry!</u></Center><br>
			<!--<br>-->
			<hr>
			<%

			if ((mCategory.equals("SC") && Long.parseLong(mrnk) <=mJIITLastSCRank1) ||
			(mCategory.equals("ST") && Long.parseLong(mrnk) <=mJIITLastSTRank1) ||
			(mCategory.equals("GEN") && Long.parseLong(mrnk) <=mJIITLastGENRank1) )
			{
			%>
			<center><font color=Red size=4>You have missed the first round of counselling and hence you are not qualified for Wait Listing/subsequent Counselling.</font></center>
			<br><br><hr>
			<%
			}
			else if ((mCategory.equals("SC") && Long.parseLong(mrnk) <=mJIITLastSCRank2) ||
			(mCategory.equals("ST") && Long.parseLong(mrnk) <=mJIITLastSTRank2) ||
			(mCategory.equals("GEN") && Long.parseLong(mrnk) <=mJIITLastGENRank2) )
			{
			%>
			<center><font color=Red size=4>You have missed the second round of counselling and hence you are not qualified for Wait Listing/subsequent Counselling.</font></center>
			<br><br><hr>
			<%
			}
	}
	else
	{		
		qry="select  '1' a from C#APPLICATIONMASTERDETAIL where COUNSELLINGID='"+mYear+"' AND APPLIEDINSTITUTECODE='JIIT' ";
		qry+=" and ROLLNOOFAIEEE='"+mValue+"'";
		//out.print(qry);
		CounsellingRecordSet= db.getRowset(qry); 
		if(CounsellingRecordSet.next()  && !mrnk.equals(""))
			{ 
				mFlags=1;
				////if( ((mCategory.equals("SC") && Long.parseLong(mrnk) >mJIITLastSCRank) ||
				////	(mCategory.equals("ST") && Long.parseLong(mrnk) >mJIITLastSTRank) ||
				////	(mCategory.equals("GEN") && Long.parseLong(mrnk) >mJIITLastGENRank))
				////	&& (Long.parseLong(mrnk)>=mJIITRankFrom && Long.parseLong(mrnk)<=mJIITRankTo))
				///{
				////	mFlg++;
				////	mPrint=1;
				%>
				<!--					
				<font color=darkblue size=5 face=verdana><B><center>Jaypee Institute of Information Technology University, Noida</B></center></font>
			<br>
			<font color=green size=4 face=verdana><B><center>AIEEE based Counselling/Admission <%=mYear%>	Status</B></center></font>
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
				</table>			
				<hr>
				<center><font  face=verdana color=Green size=6><u>Congratulation!</u></Center>
					<hr>
				<center><font color=Green size=5>You are elligible for Second round of counselling at JIIT Noida.</font></center>
				<br>
				<br>
				<a href="http://www.jiit.ac.in/Admission2009/btech/2ND ROUND COUSELLING INSTRUCTIONS - JIIT.pdf"><font size=3 color="darkbrown">For More information click here</font></a>
				<br>

				<font size=3><b>Schedule is as follows:</b><br>
				<b><u>For JIIT, NOIDA</u></b><br>
				Date	-	10 July 2009<br>
				Time	-	09.00 A.M.<br>
				Venue	-	Jaypee Institute of Information Technology University<br>
				A-10, Sector-62<br>
				Noida-201307 (U.P.)</font>
				<hr>
				-->
				<%

			////	}
			}

		if (mFlags==1 && ((mCategory.equals("SC") && Long.parseLong(mrnk) <=mJIITLastSCRank1) ||
			(mCategory.equals("ST") && Long.parseLong(mrnk) <=mJIITLastSTRank1) ||
			(mCategory.equals("GEN") && Long.parseLong(mrnk) <=mJIITLastGENRank1) ))
			{
			mPrint=1;
			%>
			<font color=darkblue size=5 face=verdana><B><center>Jaypee Institute of Information Technology University, Noida</B></center></font>
			<br>
			<font color=green size=4 face=verdana><B><center>AIEEE based Counselling/Admission <%=mYear%>	Status</B></center></font>
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
			</table>			
				<hr>
				<center><font  face=verdana color=Red size=6><u>Sorry!</u></Center><br>
				<!--<br>-->
				<hr>
				<center><font color=Red size=4>You have missed the first round of counselling and hence you are not	qualified for Wait Listing/subsequent Counselling.</font></center>
				<br><br><hr>
			<%
		}		
		
			if (mPrint==0 && mFlags==1 && ((mCategory.equals("SC") && Long.parseLong(mrnk) <=mJIITLastSCRank2) ||
					(mCategory.equals("ST") && Long.parseLong(mrnk) <=mJIITLastSTRank2) ||
					(mCategory.equals("GEN") && Long.parseLong(mrnk) <=mJIITLastGENRank2) ))
			{
			mPrint=1;
			%>
			<font color=darkblue size=5 face=verdana><B><center>Jaypee Institute of Information Technology University, Noida</B></center></font>
			<br>
			<font color=green size=4 face=verdana><B><center>AIEEE based Counselling/Admission <%=mYear%>	Status</B></center></font>
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
			</table>			
				<hr>
				<center><font  face=verdana color=Red size=6><u>Sorry!</u></Center><br>
				<!--<br>-->
				<hr>
				<center><font color=Red size=4>You have missed the second round of counselling and hence you are not	qualified for Wait Listing/subsequent Counselling.</font></center>
				<br><br><hr>
			<%
		}		
		else if (mPrint==0 && mFlags==1)
		{
			mFlg++;
			mPrint=1;
			%>
			<font color=darkblue size=5 face=verdana><B><center>Jaypee Institute of Information Technology University, Noida</B></center></font>
			<br>
			<font color=green size=4 face=verdana><B><center>AIEEE based Counselling/Admission <%=mYear%>	Status</B></center></font>
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
			</table>			
			<hr>
			<center><font  face=verdana color=red size=6><u>Sorry !</u></Center><br>
			<br>
			<Center>
			<!--<center><font color=Red size=4>You are not qualified for Second round of counselling.</font></center>-->
			<center><font color=Red size=4>You are not qualified for counselling.</font></center>
			<br><br><hr>
		<%
		}

	}

	if (mFlags==0 && mPrint==0)
		{
		%>
		<Center>
		<font  face=verdana color=red size=6><u>Sorry !</u></Center><br>
		<br>
		<hr>
		<Center>
		<font color=Red size=4>No Such AIEEE Roll No / Application Number exists in our data</font></Center>
		<hr><br><br>
		<%
		}
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
//  out.print(qry);
}

%>
<TABLE align=center><TR><td VALIGN=BOTTOM>

<br><br><br><br>

<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../Images/CampusConnectLogo.bmp"> <FONT style="FONT-FAMILY: cursive" size=4><B>Campus Connect</B></FONT>   <FONT style="FONT-FAMILY: cursive" size=2>... an <B>IRP</B> Solution</FONT><BR>A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><BR><FONT size=2>For your comments or suggestions please send an email at <A tabIndex=8 href="mailto:jiiterp@jiit.ac.in">jiiterp@jiit.ac.in</A></FONT> 
</td></tr></table>
</body>
</html>