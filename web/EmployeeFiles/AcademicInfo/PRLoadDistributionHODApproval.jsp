<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
ResultSet rs=null,rs1=null,rs2=null,rs3=null,rs4=null,rs5=null;
String mMemberID="",mDMemberID="";
String mMemberName="";
String mMemberType="",mDMemberType="",mSst="",mPrcode="",mradio1="",mradio11="";
String mHead="";
String mDMemberCode="",mMemberCode="",mexam="",mExam="",mExamcode="",QryExam="";
String mInst="" ,mPrCode="",mSendhod="";
String qry="",mCompcode="";
int ctr=0, LAssigned=0, TAssigned=0, PAssigned=0;
String mType="",mL="",mT="",mP="",mST="",mSemT="",SEM="",mBasket="",BASKET="";
String SUBJ="",mSubj="",TYPE="",DEPT="",mDept="",LTP="",SUBNAME="",mSname="",EXAM="",mSems="";
String QrySemType, QryDept="", curacadyr="", TRCOLOR="", mSubjID="", mProjSubj="", ELE1="" ;
String LAss="Y", TAss="Y", PAss="Y";

if (session.getAttribute("CompanyCode")==null)
{
	mCompcode="";
}
else
{
	mCompcode=session.getAttribute("CompanyCode").toString().trim();
}
if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
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
	{	
		OLTEncryption enc=new OLTEncryption();
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
//-------------------------------------
//----- For Log Entry Purpose
//--------------------------------------

			String mLogEntryMemberID="",mLogEntryMemberType="";

			if (session.getAttribute("LogEntryMemberID")==null || session.getAttribute("LogEntryMemberID").toString().trim().equals(""))
				mLogEntryMemberID="";
			else
				mLogEntryMemberID=session.getAttribute("LogEntryMemberID").toString().trim();

			if (session.getAttribute("LogEntryMemberType")==null || session.getAttribute("LogEntryMemberType").toString().trim().equals(""))
				mLogEntryMemberType="";
			else
				mLogEntryMemberType=session.getAttribute("LogEntryMemberType").toString().trim();

			if (mLogEntryMemberType.equals(""))
				mLogEntryMemberType=mMemberType;

			if (mLogEntryMemberID.equals(""))
				mLogEntryMemberID=mMemberID;

			if (!mLogEntryMemberType.equals(""))
				mLogEntryMemberType=enc.decode(mLogEntryMemberType);

			if (!mLogEntryMemberID.equals(""))
				mLogEntryMemberID=enc.decode(mLogEntryMemberID);

//--------------------------------------

			if(request.getParameter("SemType")==null)
				QrySemType="REG";
			else
				QrySemType=request.getParameter("SemType").toString().trim();

			if(request.getParameter("department")==null)
				QryDept=mDept;
			else
				QryDept=request.getParameter("department").toString().trim();

			if (request.getParameter("radio1")==null)
				mSendhod="";
			else
				mSendhod=request.getParameter("radio1").toString().trim();

			if (request.getParameter("PRCODE")==null)
				mPrCode="";
			else
				mPrCode=request.getParameter("PRCODE").toString().trim();

			if (request.getParameter("EXAMCODE")==null)
				QryExam="";
			else
				QryExam=request.getParameter("EXAMCODE").toString().trim();

			if(mSendhod.equals("Y"))
			{
//==============================================
				qry="select distinct 'C' CEF,A.L L,A.T T,A.P P,A.subjectid subjectid,B.subjectcode subjectcode,null ELECTIVECODE,A.Basket Basket,B.Subject||' ('||B.SubjectCode||') ' subj, NVL(B.PROJECTSUBJECT,'N')PROJECTSUBJECT from programscheme A ,Subjectmaster B ";
				qry=qry+" where A.institutecode='"+mInst+"' ";
				qry=qry+" and A.subjectid in (select C.subjectid from PR#DEPARTMENTSUBJECTTAGGING C ";
				qry=qry+" where  C.examcode='"+QryExam+"' ";
				qry=qry+" AND A.INSTITUTECODE = C.INSTITUTECODE ";
				qry=qry+" AND A.ACADEMICYEAR =C.ACADEMICYEAR ";
				qry=qry+" AND A.PROGRAMCODE  = C.PROGRAMCODE ";
				qry=qry+" AND A.TAGGINGFOR   = C.TAGGINGFOR ";
				qry=qry+" AND A.SECTIONBRANCH = C.SECTIONBRANCH AND C.departmentcode ='"+mDept+"' )  AND A.SUBJECTID=B.SUBJECTID ";
				qry=qry+"and (A.L>0 or A.T>0 or A.P>0 )";
				qry=qry+" and ( a.academicyear='"+curacadyr+"' or (Exists (select 1 from pr#studentsubjectchoice a1 where a1.subjectid =a.subjectid and  institutecode = '"+mInst+"' and examcode = '"+QryExam+"' and SEMESTERTYPE='REG')))";
				qry=qry+" union ";
				qry=qry+"select distinct 'C' CEF, A.L L,A.T T,A.P P,A.subjectid subjectid,B.subjectcode subjectcode,null ELECTIVECODE,A.Basket Basket,B.Subject||' ('||B.SubjectCode||') ' subj, NVL(B.PROJECTSUBJECT,'N')PROJECTSUBJECT from OFFERSUBJECTTAGGING A ,Subjectmaster B where A.institutecode='"+mInst+"' and   a.examcode='"+QryExam+"'  AND a.departmentcode ='"+mDept+"'  AND A.SUBJECTID=B.SUBJECTID and (A.L>0 or A.T>0 or A.P>0 ) aND A.Basket='A'";
				qry=qry+" and Exists (select 1 from pr#studentsubjectchoice a1 where a1.subjectid =a.subjectid and  institutecode = '"+mInst+"' and examcode = '"+QryExam+"' and SEMESTERTYPE='REG')";
				qry=qry+" union ";
				qry=qry+" select distinct 'E' CEF,A.L L,A.T T,A.P P, A.subjectid subjectid, B.subjectcode subjectcode,A.ELECTIVECODE ELECTIVECODE,A.Basket Basket,B.Subject||' ('||B.SubjectCode||') ' subj, NVL(B.PROJECTSUBJECT,'N')PROJECTSUBJECT from PR#ELECTIVESUBJECTS A ,Subjectmaster B  ";
				qry=qry+" where A.institutecode='"+mInst+"' and A.examcode='"+QryExam+"' ";
				qry=qry+" and A.subjectid in (select C.subjectid from PR#DEPARTMENTSUBJECTTAGGING C ";
				qry=qry+" where  C.examcode='"+QryExam+"' ";
				qry=qry+" AND A.INSTITUTECODE = C.INSTITUTECODE ";
				qry=qry+" AND A.ACADEMICYEAR =C.ACADEMICYEAR ";
				qry=qry+" AND A.PROGRAMCODE  = C.PROGRAMCODE ";
				qry=qry+" AND A.TAGGINGFOR   = C.TAGGINGFOR ";
				qry=qry+" AND A.SECTIONBRANCH = C.SECTIONBRANCH AND  C.departmentcode ='"+mDept+"' ) and A.SUBJECTRUNNING='Y' AND A.SUBJECTID=B.SUBJECTID   ";
				qry=qry+" and (A.L>0 or A.T>0 or A.P>0 ) ";
				qry=qry+" and ( a.academicyear='"+curacadyr+"' or (Exists (select 1 from pr#studentsubjectchoice a1 where a1.subjectid =a.subjectid and  institutecode = '"+mInst+"' and examcode = '"+QryExam+"' and SEMESTERTYPE='REG')))";
				qry=qry+" union ";
				qry=qry+"select distinct 'E' CEF,A.L L,A.T T,A.P P,A.subjectid subjectid,B.subjectcode subjectcode,null ELECTIVECODE,A.Basket Basket,B.Subject||' ('||B.SubjectCode||') ' subj, NVL(B.PROJECTSUBJECT,'N')PROJECTSUBJECT from OFFERSUBJECTTAGGING A ,Subjectmaster B where A.institutecode='"+mInst+"' and  a.examcode='"+QryExam+"'  AND a.departmentcode ='"+mDept+"'  AND A.SUBJECTID=B.SUBJECTID and (A.L>0 or A.T>0 or A.P>0 ) and  A.Basket='B'";
				qry=qry+" and Exists (select 1 from pr#studentsubjectchoice a1 where a1.subjectid =a.subjectid and  institutecode = '"+mInst+"' and examcode = '"+QryExam+"' and SEMESTERTYPE='REG')";
				qry=qry+"order by CEF, subj ";
				rs=db.getRowset(qry);
				//out.print(qry);
				while(rs.next())
				{
					ctr++;
					mSubjID=rs.getString("subjectid");
					mSubj=rs.getString("subjectcode");
					mSname=rs.getString("subj");
					mBasket=rs.getString("Basket");
					mProjSubj=rs.getString("PROJECTSUBJECT");
					mType=rs.getString("CEF").trim();

					qry="select count(distinct facultyid)cnt from PR#FACULTYSUBJECTCHOICES ";
					qry=qry+" where institutecode='"+mInst+"' and examcode='"+QryExam+"' and subjectid='"+mSubjID+"' ";
					qry=qry+" and subjecttype='"+mType+"' and LTP='L' ";
					rs1=db.getRowset(qry);
					if(rs1.next())
						mL=rs1.getString("cnt");
	
					qry="select count(distinct facultyid)cnt from PR#FACULTYSUBJECTCHOICES ";
					qry=qry+" where institutecode='"+mInst+"' and examcode='"+QryExam+"' and subjectid='"+mSubjID+"' ";
					qry=qry+" and subjecttype='"+mType+"' and LTP='T' ";
					rs2=db.getRowset(qry);
					if(rs2.next())
						mT=rs2.getString("cnt");

					qry="select count(distinct facultyid)cnt from PR#FACULTYSUBJECTCHOICES ";
					qry=qry+" where institutecode='"+mInst+"' and examcode='"+QryExam+"' and subjectid='"+mSubjID+"' ";
					qry=qry+" and subjecttype='"+mType+"' and LTP='P' ";
					rs3=db.getRowset(qry);
					if(rs3.next())
						mP=rs3.getString("cnt");

					if(rs.getInt("L")>0)
					{
						qry="SELECT 'Y' FROM PR#HODLOADDISTRIBUTION WHERE INSTITUTECODE='"+mInst+"' AND COMPANYCODE='"+mCompcode+"' AND EXAMCODE='"+QryExam+"' AND SEMESTERTYPE='"+QrySemType+"' AND BASKET='"+mBasket+"' AND SUBJECTID='"+mSubjID+"' AND NVL(DEPARTMENTRUNNIG,' ')='"+QryDept+"' AND LTP='L'";
						//out.print(qry);
						rs4=db.getRowset(qry);
						if(!rs4.next())
						{
							LAssigned++;
							LAss="N";
						}
					}
					if(rs.getInt("T")>0)
					{
						qry="SELECT 'Y' FROM PR#HODLOADDISTRIBUTION WHERE INSTITUTECODE='"+mInst+"' AND COMPANYCODE='"+mCompcode+"' AND EXAMCODE='"+QryExam+"' AND SEMESTERTYPE='"+QrySemType+"' AND BASKET='"+mBasket+"' AND SUBJECTID='"+mSubjID+"' AND NVL(DEPARTMENTRUNNIG,' ')='"+QryDept+"' AND LTP='T'";
						//out.print(qry);
						rs4=db.getRowset(qry);
						if(!rs4.next())
						{
							TAssigned++;
							TAss="N";
						}
					}
					if(rs.getInt("P")>0)
					{
						qry="SELECT 'Y' FROM PR#HODLOADDISTRIBUTION WHERE INSTITUTECODE='"+mInst+"' AND COMPANYCODE='"+mCompcode+"' AND EXAMCODE='"+QryExam+"' AND SEMESTERTYPE='"+QrySemType+"' AND BASKET='"+mBasket+"' AND SUBJECTID='"+mSubjID+"' AND NVL(DEPARTMENTRUNNIG,' ')='"+QryDept+"' AND LTP='P'";
						//out.print(qry);
						rs4=db.getRowset(qry);
						if(!rs4.next())
						{
							PAssigned++;
							PAss="N";
						}
					}
				} //closing of while

				//out.print(LAssigned+" "+TAssigned+" "+PAssigned+"<BR>");
				//out.print(LAss+" "+TAss+" "+PAss+"<BR>");
//==============================================
				//if(LAssigned==0 || TAssigned==0 || PAssigned==0))
				if(LAss.equals("Y") && TAss.equals("Y") && PAss.equals("Y"))
				{
					qry=" Update prevents set LOADDISTRIBUTIONSTATUS='F',LOADDISTAPPROVEDBY='"+mChkMemID+"',LOADDISTAPPROVALDATE=sysdate where institutecode='"+mInst+"' and ";
					qry=qry+" PREVENTCODE='"+mPrCode+"' and MEMBERTYPE='"+mChkMType+"' and MEMBERID='"+mChkMemID+"' ";
					int u=db.update(qry);
				
					qry=" Update USERWISELOADPERMITION set FREEZED='Y' where EXAMCODE='"+QryExam+"'  and COMPANYCODE='"+mCompcode+"' and EMPLOYEEID='"+mChkMemID+"' and DEPARTMENTCODE='"+mDept+"'";
					//out.println(qry);
					int u2=db.update(qry);

					qry=" Update PR#HODLOADDISTRIBUTION set STATUS='F' where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+QryExam+"' and DEPARTMENTRUNNIG='"+mDept+"' ";
					int u1=db.update(qry);
		
					if(u>0)
			 		{
						// Log Entry
						//-----------------
						  db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"Freeze Load Distribution ", "ExamCode:"+QryExam+" PrEventcode:"+mPrCode+"Depatrment Running:"+ QryDept, "NO MAC Address" , mIPAddress);
					     //-----------------
						%>
						<br><br>
						<b><font color=Green>
						<ui>Load Distribution has been Finalized and Send to DOAA for Approval. <br>
						<ui>Now You can not Enter/Modify the Load Distribution.
						</font><br></b>
					     <%
					} // closing of if(u>0)
				}
				else
				{
					out.print("<br><img src='../../Images/Error1.jpg'>");
					out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Not Freezed! Please Assign Load for All the Subjects</font> <br>");
				}

			} // closing of if(mSendhod.equals("Y"))
			else
			{
				%>
				<br>
				<font color=red>
				<h3><br><img src='../../Images/Error1.jpg'>
				 ~ Load Distribution has not been finalized.<br>
				 &nbsp; &nbsp; ~ Finalization is mandatory to approve the load distribution.
				</h3><br>
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
			<h3>	<br><img src='../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
			<P>	This page is not authorized/available for you.
			<br>For assistance, contact your network support team. 
			</font>	<br>	<br>	<br>	<br>  
			<%
	  	}
//-----------------------------
	}
	else
	{
		out.print("<br><img src='../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}      
}
catch(Exception e)
{
}
%>
</body>
</html>