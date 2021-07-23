
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
String oldSubject="",DeptCode="",mLT="";
int i=0;
int mL1=0;
int mT1=0;
int mP1=0;				
int mlt1=0;
int mFlag2=0,mFlag1=0,mFlag11=0,mFlag111=0;
int ctr=0,x=0;
int msno=0;
String mType="",mLTP="",mSubj="",mDept="",mSname="",mExamcode="",mSeccount="",mPrCode="";
int mL=0,mT=0,mP=0,mlt=0;
double mAssigned=0,mMin=0,mMax=0,mexcludeassign=0 ;
double mAssignedload=0,mMinload=0,mMaxload=0;
String mEmpidv="";
String mFacv="",mTyp="",mEmpTyp="",mcmp="",mEcmp="",mDuration="",mClass="",mSendhod="";
String mMult="",Dept="";
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
<TITLE>#### <%=mHead%> [Old Subject Tagging] </TITLE>

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
function validate()
{
	
	if(document.frm1.oldSubject.value=="")
	{
		alert("Please select an old subject");
		return	false;
	}

}





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
			//----------------------
			qry="select PREREGEXAMID from COMPANYINSTITUTETAGGING where  INSTITUTECODE='"+mInst+"' and nvl(DEACTIVE,'N')='N' and COMPANYCODE='"+mLoginComp+"'";
			rs= db.getRowset(qry);
			if(rs.next())
			{
				mExamcode=rs.getString("PREREGEXAMID");
			}
			%>		

			<form name="frm1"  method="Post" >
			<input id="x" name="x" type=hidden>
			<TABLE align=center rules=group    cellSpacing=1 cellPadding=1  border=0>
				<tr>
					<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Old Subject Tagging </b></font>
					</td>
				</tr>
			</TABLE>
			<table id=idd2 cellpadding=1 cellspacing=0 width="90%" align=center rules=groups border=3>
				<tr>
					<td nowrap >
						<FONT color=black face=Arial size=2><b>Old Subject</b></FONT>
					</td>
					<td align='left' >
						<%
						
						qry="select subjectid, subject|| ' ('|| subjectcode ||') ' sub from subjectmaster where subjectid in (select subjectid from offersubjecttagging where examcode='"+mExamcode+"' and subjectid in (select distinct subjectid from pr#hodloaddistribution where examcode='"+mExamcode+"' and semestertype='RWJ' and nvl(deactive,'N')='N' and institutecode='"+mInst+"' and COMPANYCODE='"+mCompcode+"' )and institutecode='"+mInst+"'  and nvl(deactive,'N')='N')     AND NVL (DEACTIVE, 'N') = 'N'";	
						//out.println(qry);
						rs= db.getRowset(qry);
						String selected="";
						%><select name='oldSubject' >		
						<option value='' selected> Select 
						<%

						while(rs.next()) 
						{
						if(request.getParameter("oldSubject")==null)
							selected="";
						else 
							if(request.getParameter("oldSubject").equals(rs.getString("subjectid")))
								selected="selected";
							else
								selected="";

						if(request.getParameter("oldSubject")==null)
						{
						if(request.getParameter("oldSubject1")==null  )
							selected="";
						else
							if(request.getParameter("oldSubject1").equals(rs.getString("subjectid")))
								selected="selected";
							else
								selected="";
						}

						//System.out.println(selected);
						
						%>
						
						<option <%=selected%> value='<%=rs.getString("subjectid")%>'> <%=rs.getString("sub")%></option>
							
						<%
						}
						%>
						</select>

					</td>
					<td>
					<FONT color=black face=Arial size=2><b>LTP</b></FONT>
						<select name=LTP tabindex="0" id="LTP">
	<%
 	if(request.getParameter("LTP")==null)
   	{
		%>			
		<OPTION Value =L selected>Lecture</option>
		<OPTION Value =T>Tutorial</option>
		<OPTION Value =P>Practical</option>
		<%
  	}
	else
	{
		mLTP=request.getParameter("LTP");
		if(mLTP.equals("L"))
		{
			%>
			<OPTION Value =L selected>Lecture</option>
			<OPTION Value =T>Tutorial</option>
			<OPTION Value =P>Practical</option>
			<%
	      }
		else if(mLTP.equals("T"))
		{
			%>
			<OPTION Value =L selected>Lecture</option>
			<OPTION Selected Value =T>Tutorial</option>
			<OPTION Value =P>Practical</option>
			<%		
		}
		else if(mLTP.equals("P"))
		{
			%>
			<OPTION Value =L selected>Lecture</option>
			<OPTION Value =T>Tutorial</option>
			<OPTION Value =P Selected>Practical</option>
			<%
		}
	}
%>
</select>
					</td>	

					<td><INPUT TYPE="submit" name='submit' value='Submit' onClick="return validate();"></td>
				</tr>
			</table>
			</form>
			<%
			if(request.getParameter("x")!=null)
			{
				if(request.getParameter("oldSubject")==null)
				{
					oldSubject="";
					if(request.getParameter("oldSubject1")==null)
						oldSubject="";
					else
						oldSubject=request.getParameter("oldSubject1");
				}
				else
					oldSubject=request.getParameter("oldSubject");

				if(request.getParameter("LTP")==null)
					mLT="";
				else
					mLT=request.getParameter("LTP");
					//out.println(oldSubject);
%>
<form name="frm2"  method="Post" action='MergeoldSubject_newSubject.jsp'>
<br><br>
<TABLE align=center rules=group  class="sort-table"  cellSpacing=1 cellPadding=1  border=1>
<tr bgcolor="#ff8c00">
<TD><B>Check</B></TD>
	<TD ><B>Emp Name</B></TD>
	<TD><B>ProgCode</B></TD>
	<TD><B>Sect <br>Branch</B></TD>
	<TD><B>SubSection</B></TD>	
	<TD><B>New Subject Name</B></TD>
	<TD align='center'><B>New <br>ProgCode</B></TD>
	<TD align='center'><B>New <br>SectBranch</B></TD>
	<TD align='center'><B>New <br>SubSection</B></TD>	
	<TD><B>Remove <br>Merge</B></TD>	

</TR><%


				qry=" select FACULTYID, PROGRAMCODE, SECTIONBRANCH, SUBSECTIONCODE, SEMESTERTYPE,employeename||' ('||Employeecode||')'empname,c.DEPARTMENT,c.DEPARTMENTCODE,A.LTP,NVL(A.MERGEWITHFSTID,'N')MERGEWITHFSTID,a.FSTID from   PR#hodloadDistribution a , Employeemaster b,departmentmaster c where subjectid='"+oldSubject+"' and examcode='"+mExamcode+"'   and a.DEPARTMENTRUNNIG=c.DEPARTMENTCODE and semestertype='RWJ' and a.institutecode='"+mInst+"' and a.companycode='"+mCompcode+"' and    a.FACULTYID=b.employeeid   and a.companycode=b.companycode   and b.COMPANYCODE='"+mCompcode+"'   and nvl(a.deactive,'N')='N'     and nvl(b.deactive,'N')='N' and nvl(c.deactive,'N')='N' and nvl(a.LTP,'N')='"+mLT+"'  order by subsectioncode  ";
				//out.print(qry);
				rs= db.getRowset(qry);	
				
				while (rs.next())
				{++i;
				Dept=rs.getString("DEPARTMENT");
				DeptCode=rs.getString("DEPARTMENTCODE");

				%>
				<TR>
					<% if (rs.getString("MERGEWITHFSTID").equals("N")){%>
					<td><INPUT TYPE="checkbox" NAME="fstid<%=i%>" checked value="<%=rs.getString("FSTID")%>"></td>
					<%}else{%>
					<td>Selected</td>
					<%}%>
					<TD><%=rs.getString("empname")%></TD>
					<TD><%=rs.getString("PROGRAMCODE")%></TD>
					<TD><%=rs.getString("SECTIONBRANCH")%></TD>
					<TD><%=rs.getString("SUBSECTIONCODE")%></TD>
			
				<%					
				 qry1="SELECT   A.FSTID,facultyid, programcode, sectionbranch, subsectioncode, semestertype, SUBJECT || ' (' || SUBJECTCODE || ')' SUBJECT, c.department,         c.departmentcode, a.ltp FROM pr#hodloaddistribution a, SUBJECTMASTER b, departmentmaster c  WHERE A.subjectid = b.subjectid   AND A.examcode = '"+mExamcode+"'  AND A.FSTID ='"+rs.getString("MERGEWITHFSTID")+"'   AND a.departmentrunnig = c.departmentcode  AND a.institutecode = '"+mInst+"'   AND a.companycode = '"+mCompcode+"'    AND NVL (a.deactive, 'N') = 'N'   and nvl(c.deactive,'N')='N'   AND NVL (b.deactive, 'N') = 'N'";
				//out.println(qry1);
				rs1=db.getRowset(qry1);
				if(rs1.next())
					{
					%>
					<TD>&nbsp;<%=rs1.getString("SUBJECT")%></TD>
					<TD>&nbsp;<%=rs1.getString("PROGRAMCODE")%></TD>
					<TD>&nbsp;<%=rs1.getString("SECTIONBRANCH")%></TD>
					<TD>&nbsp;<%=rs1.getString("SUBSECTIONCODE")%></TD>
					<TD><A HREF="removemergsubjects.jsp?fstid=<%=rs.getString("FSTID")%>&examcode=<%=mExamcode%>&oldSubject=<%=oldSubject%>&mLTP=<%=mLT%>"> Remove Subject</A></TD>
					<%
					}
					else
					{
						%><TD>&nbsp;</TD>
					<TD>&nbsp;</TD>
					<TD>&nbsp;</TD>
					<TD>&nbsp;</TD><TD>&nbsp;</TD><%
					}

				%>
					
					
					</TR>

<%
				}
						
%><INPUT TYPE="hidden" NAME="counter" value=<%=i%>>
<INPUT TYPE="hidden" NAME="subjectid" value=<%=oldSubject%>>
<INPUT TYPE="hidden" NAME="DeptCode" value=<%=DeptCode%>>
<INPUT TYPE="hidden" NAME="LTP" value=<%=mLT%>>




			
			</TABLE>
			<center><font size= 2 face=Arial ><b>Deaprtment : <%=Dept%> </b><center>
			<center><br><input type="submit" value="Submit" name="Submit"/></center>			
			<%
						//out.println("sunny");
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