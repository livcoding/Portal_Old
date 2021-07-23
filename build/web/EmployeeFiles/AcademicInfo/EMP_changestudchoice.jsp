<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
ResultSet  rs=null,rs1=null,rss1=null,rsc=null,rse=null,rse1=null,rsso=null;
String qry="",qry1="";
String mDID="",mProg="";
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
double mMinCrLmt=0, mMaxCrLmt=0, mMinCrLmtTkn=0, mMaxCrLmtTkn=0, mMaxCrLmtAld=0, mCourseCrPt=0, mTotalCrLmtTkn=0;
String mSect="",	mSubSect="", mTag="",mElective="",mSCode="";
String mExam="", mFailGraders="F", mPrcode="";
String mName1="", mName2="",mName3="", mName4="", mName5="", mName6="", mName7="", mName8="", mName9="", mName10="";
int mochoice=0, mochoice1=0,Count=0,chk=0,m=1;
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Subject Selection for the comming classes(Pre Registration of Students changed by Admin User) ] </TITLE>
<script type="text/javascript" src="../js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="../css/sortabletable.css" />

<Html>
<head>

</head>

<body topmargin=0 rightmargin=0 leftmargin=10 bottommargin=0 bgcolor=#fce9c5>
<cenTer>
<% 
String mSEMESTER="", mSname="";
String mBranch="", mAcad="";
String mInst="", mComp="", mWebEmail="";
int mSem=0, mSno=0, mChoice=1, mTot=0;
String mySect="";
String mFELFinal="N", mCoreFinal="N";
int mSemester=0;
String mSemType="", mSubjType="", mSubjTypeDesc="", mSubjId="", mSubjName="", mBasket="";
String mColor="white";
String mCol1="lightyellow";
String mCol2="#F8F8F8";
OLTEncryption enc=new OLTEncryption();
mSname=session.getAttribute("MemberName").toString().trim();
mSCode=enc.decode(session.getAttribute("MemberCode").toString().trim());
if (session.getAttribute("WebAdminEmail")==null)
{
	mWebEmail="";
}
else
{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
}
try
{

	if (session.getAttribute("MemberID")!=null && session.getAttribute("MemberCode")!=null)
	{
		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		String mStatus="";
		ResultSet RsChk=null;
		//-----------------------------
		//-- Enable Security Page Level  
		//-----------------------------
		/*qry="Select WEBKIOSK.ShowLink('52','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		*/
		if(1==1)
		{

			mComp=session.getAttribute("CompanyCode").toString().trim();
			mInst=session.getAttribute("InstituteCode").toString().trim();
			mDID=enc.decode(session.getAttribute("MemberID").toString().trim());
			//out.println(mComp+"_____________"+mInst+"::::::::::"+mDID);
			 //-----------------------------
			//-- Enable Security Page Level  
		   //-----------------------------
			  
			%>
			<form name="frm"  method="post" action='EMP_PRStudentReEntry.jsp'>
			<input id="x" name="x" type=hidden>
			
			<table id=id1 width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
				<tr>
					<TD colspan=0 align=middle>
						<font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana
						"><B>Change Students Subject Choice by Admin User</b></font>
					</td>
				</tr>
			</TABLE>
			<%//int yy=0;%>
			<!--  <table bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=columns topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center width="60%">
				
				<tr bgcolor="#ff8c00">
					<td align='center'><b>SNo.</b></td>
					<td align='left'><b>&nbsp;&nbsp;&nbsp;Student Name</b></td>
					<td align='center' >&nbsp;&nbsp;&nbsp;<b>EnRoll No.</b></td>
				</tr>
			
			 -->
			
			<%
			//String query="Select distinct b.studentname,b.ENROLLMENTNO,a.STUDENTID from Pr#studentSubjectChoice a,studentmaster b where a.STUDENTID=b.STUDENTID and a.ACADEMICYEAR  =b.ACADEMICYEAR and  b.PROGRAMCODE=a.PROGRAMCODE and b.INSTITUTECODE=a.INSTITUTECODE and nvl(a.DEACTIVE,'Y')<>'N' order by studentname"	;
			//ResultSet rst=db.getRowset(query);
			//while(rst.next())
			//{
				%>
				<!-- <tr>
					<td align='center'><b><%//=++yy%>.</b></td>
					<td align='left'>&nbsp;&nbsp;&nbsp;<%//=rst.getString("studentname")%></td>
					<td align='center'>&nbsp;&nbsp;&nbsp;<a target=_new    href="EMP_BackLogSubjectsList.jsp?studentEnRoll=<%//=rst.getString("ENROLLMENTNO")%>" ><//%=rst.getString("ENROLLMENTNO")%></a></td>
				</tr> -->
				<%
			//}
			%> 
			 </table><br><br>
			<table bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=columns topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center>
			<tr bgcolor="#ff8c00">
			<td align="center"><b>ENROLL of Student	</b>
			</td>
			<td><input type="text" id="studentEnRoll" name="studentEnRoll" />
			</td>
			
			<td align='center'><input type="submit" name="Enter" value="Enter"/>
			</td>
			</tr>
			</table>
			</form>
			
			<%		
		}
		else
		{
			%>
			<br>
			<font color=red>
			<h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
			<P>	This page is not authorized/available for you.
			<br>For assistance, contact your network support team. <br><br><br>
			</font>
		   <%
		}
	  //-----------------------------
}
else
{
%>
<br>
Session timeout! Please <a href="../../index.jsp">Login</a> to continue...
<%
}
}
catch(Exception e)
{
	out.print(e);
}
%>
</body>
</Html>