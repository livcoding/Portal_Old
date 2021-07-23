
<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
ResultSet rs=null,rs1=null,rs2=null,rs3=null,rs5=null,rsc=null,rsl=null,rsm=null;
String mMemberID="",mDMemberID="",qry1="",mNameLML="",mvalue="",qrym="",mDept2=""; 
String mMemberName="",mProgramcode="";
String mMemberType="",mDMemberType="",mStudcnt="",mDis="",moldMerge="",moldMerge1="";
String mHead="",moldemp="",moldemp1="",mNameLMR="";
String mDMemberCode="",mMemberCode="",mFac="",mfac="",mElective="";
String mInst="",mSection="",mSubsection="",mBasket="",mOfac="",mprogc="";
String qry="",Type="",mltp="",mSem="",mEmpid="",memp="",mName1="",mName2="";
String mName3="",mName4="",mName5="",mName6="",mName7="",mName8="",mName9="",mName10="",mCompcode="";
String oldSubject="",DeptCode="";
int mL1=0;
int mT1=0;
int mP1=0;				
int mlt1=0;
int mFlag2=0,mFlag1=0,mFlag11=0,mFlag111=0;
int ctr=0,x=0;
int msno=0,i=0;
int ii=0;
String mType="",mLTP="",mSubj="",mDept="",mSname="",mExamcode="",mSeccount="",mPrCode="";
int mL=0,mT=0,mP=0,mlt=0;
double mAssigned=0,mMin=0,mMax=0,mexcludeassign=0 ;
double mAssignedload=0,mMinload=0,mMaxload=0;
String mEmpidv="";
String mFacv="",mTyp="",mEmpTyp="",mcmp="",mEcmp="",mDuration="",mClass="",mSendhod="";
String mMult="";
String [] mMultiFaculty=new String [1000];
if (session.getAttribute("CompanyCode")==null)
{
	mCompcode="";
}
else
{
	mCompcode=session.getAttribute("CompanyCode").toString().trim();
	//out.println(mCompcode);
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

if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
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
<TITLE>#### <%=mHead%> [Merge Old Subject with New Subject] </TITLE>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor='#fce9c5' rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

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
		String mSubjID="";
		String mEle="";
		String SC="",qrye="",sc="";
		ResultSet rse=null;
		//-----------------------------
		//-- Enable Security Page Level  
		//-----------------------------
		qry="Select WEBKIOSK.ShowLink('56','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
 	    RsChk= db.getRowset(qry);
	    if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		//if(1==1)
	  	{
			%>			
			<form name="frm"  method="Post" >
			<input id="x" name="x" type=hidden>
			<table id=id1 width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
				<tr>
					<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Merge Old Subject with New Subject</b></font>
					</td>
				</tr>
			</TABLE>
			<%
			
			qry="select PREREGEXAMID from COMPANYINSTITUTETAGGING where  INSTITUTECODE='"+mInst+"' and nvl(DEACTIVE,'N')='N' and COMPANYCODE='"+mLoginComp+"'";
			rs= db.getRowset(qry);
			if(rs.next())
			{
				mExamcode=rs.getString("PREREGEXAMID");
			}	
			
			String mergFstid="";
			if(request.getParameter("mergfstid")==null)
				mergFstid="";
			else
				mergFstid=request.getParameter("mergfstid");

			//out.println(mergFstid);

			String subjectid="",mLT="";
			if(request.getParameter("LTP1")==null)
				mLT="";
			else
				mLT=request.getParameter("LTP1");
			 mltp="";
			if(mLT.equals("L"))
				mltp="Lecture";
			else if(mLT.equals("T"))
				mltp="Tutorial";
			else if(mLT.equals("P"))
				mltp="Practical";
			if(request.getParameter("DeptCode1")==null)
				DeptCode="";
			else
				DeptCode=request.getParameter("DeptCode1");

			String counter="",fstidnew="";
			if(request.getParameter("counter1")==null)
				counter="";
			else
				counter=request.getParameter("counter1");
			//out.println(mLT+"<br>"+counter+"<br>"+DeptCode);
			int u=0;
			if(counter.equals(""))
				counter="0";
			for(int iii=1; iii<=Integer.parseInt(counter); iii++)
			{			
				if(request.getParameter("fstid1"+iii)!=null)
				{
					%><INPUT TYPE="hidden" NAME="fstid1<%=iii%>"VALUE=<%=request.getParameter("fstid1"+iii)%>><%
					if(fstidnew.equals(""))
						fstidnew="'"+request.getParameter("fstid1"+iii)+"'";
					else
						fstidnew=fstidnew+",'"+request.getParameter("fstid1"+iii)+"'";
			qry ="update facultysubjecttagging  set MERGEWITHFSTID='"+mergFstid+"' where examcode='"+mExamcode+"' and INSTITUTECODE='"+mInst+"' and  COMPANYCODE='"+mCompcode+"' and ltp='"+mLT+"' and fstid='"+request.getParameter("fstid1"+iii)+"'" ;
					u=db.update(qry);
					//out.println(qry);
				
				}			
			}
			
			if(u>0)
			{

%>
<TABLE align=center rules=group  class="sort-table"  cellSpacing=1 cellPadding=1  border=1>
<tr bgcolor="#ff8c00">

	<TD><B>Emp Name</B></TD>
	<TD><B>ProgCode</B></TD>
	<TD><B>Sect Branch</B></TD>
	<TD><B>SubSection</B></TD>
	
	<TD><B>New Subject Name</B></TD>
	<TD><B>New ProgCode</B></TD>
	<TD><B>New SectBranch</B></TD>
	<TD><B>New SubSection</B></TD>	
</TR><%


				qry=" select a.employeeid, PROGRAMCODE, SECTIONBRANCH, SUBSECTIONCODE, SEMESTERTYPE,employeename||' ('||Employeecode||')'empname,A.LTP,A.MERGEWITHFSTID,a.FSTID from   facultysubjecttagging a , Employeemaster b where fstid in ("+fstidnew+") and examcode='"+mExamcode+"'    and semestertype='RWJ' and a.institutecode='"+mInst+"' and a.companycode='"+mCompcode+"' and    a.employeeid=b.employeeid   and a.companycode=b.companycode   and b.COMPANYCODE='"+mCompcode+"'   and nvl(a.deactive,'N')='N'    and nvl(b.deactive,'N')='N' and nvl(a.LTP,'N')='"+mLT+"'  order by subsectioncode  ";
				//out.print(qry);
				rs= db.getRowset(qry);	
				
				while (rs.next())
				{++i;
				/*Dept=rs.getString("DEPARTMENT");
				DeptCode=rs.getString("DEPARTMENTCODE");*/

				%>
				<TR>
					
					<TD><%=rs.getString("empname")%></TD>
					<TD><%=rs.getString("PROGRAMCODE")%></TD>
					<TD><%=rs.getString("SECTIONBRANCH")%></TD>
					<TD><%=rs.getString("SUBSECTIONCODE")%></TD>
			
				<%					
				 qry1="SELECT   A.FSTID,employeeid, programcode, sectionbranch, subsectioncode, semestertype, SUBJECT || ' (' || SUBJECTCODE || ')' SUBJECT,  a.ltp FROM facultysubjecttagging a, SUBJECTMASTER b WHERE A.subjectid =b.subjectid  AND A.examcode = '"+mExamcode+"'  AND A.FSTID ='"+rs.getString("MERGEWITHFSTID")+"'   AND a.institutecode = '"+mInst+"'   AND a.companycode = '"+mCompcode+"'    AND NVL (a.deactive, 'N') = 'N'    AND NVL (b.deactive, 'N') = 'N'";
				//out.println(qry1);
				rs1=db.getRowset(qry1);
				if(rs1.next())
					{
					%>
					<TD>&nbsp;<%=rs1.getString("SUBJECT")%></TD>
					<TD>&nbsp;<%=rs1.getString("PROGRAMCODE")%></TD>
					<TD>&nbsp;<%=rs1.getString("SECTIONBRANCH")%></TD>
					<TD>&nbsp;<%=rs1.getString("SUBSECTIONCODE")%></TD>
					<%
					}
					else
					{
						%><TD>&nbsp;</TD>
					<TD>&nbsp;</TD>
					<TD>&nbsp;</TD>
					<TD>&nbsp;</TD><%
					}

				%>
					</TR>

<%
				}
						
%>


			
			</TABLE>


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
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}      
}
catch(Exception e)
{
//	out.println(e);
}
%>
</body>
</html>