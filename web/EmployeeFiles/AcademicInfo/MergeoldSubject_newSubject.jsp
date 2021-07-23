
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

function validate()
{
	
	if(document.frm1.oldSubject.value=="")
	{
		alert("Please select an old subject");
		return	false;
	}

}
function valid()
{
	/*alert(document.frm2.mergfstid.checked);
	if(document.frm2.mergfstid.checked)
	{
		
	}
	else
	{
		alert("Please select any option");
		
		return false;
	}*/
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
			
			
			%>
			
			<form name="frm1"  method="Post" >
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
			
			
			
			String subjectid="",mLT="";
			if(request.getParameter("LTP")==null)
				mLT="";
			else
				mLT=request.getParameter("LTP");
			 mltp="";
			if(mLT.equals("L"))
				mltp="Lecture";
			else if(mLT.equals("T"))
				mltp="Tutorial";
			else if(mLT.equals("P"))
				mltp="Practical";


			
			
			if(request.getParameter("subjectid")==null)
				subjectid="";
			else
				subjectid=request.getParameter("subjectid");
			
			if(request.getParameter("DeptCode")==null)
				DeptCode="";
			else
				DeptCode=request.getParameter("DeptCode");

			String counter="0";
			if(request.getParameter("counter")==null)
				counter="0";
			else
				counter=request.getParameter("counter");
			
				qry="select subject||'('||subjectcode||')' sub from subjectmaster where subjectid='"+subjectid+"' and nvl(DEACTIVE,'N')='N' ";
			//out.println(qry);
			rs=db.getRowset(qry);
			if(rs.next())
			{
				oldSubject=rs.getString("sub");
			}
		
			qry="select DEPARTMENTCODE,DEPARTMENT from departmentmaster where DEPARTMENTCODE='"+DeptCode+"' and nvl(DEACTIVE,'N')='N' ";
			//out.println(qry);
			rs=db.getRowset(qry);
			if(rs.next())
			{
				mDept=rs.getString("DEPARTMENT");
			}
			
			
			//out.println(counter);
			%>
<TABLE align=center rules=group  class="sort-table"  cellSpacing=1 cellPadding=1  border=1>
<tr>
<td valign="top">			
			
			
			
			<TABLE align=center rules=group  class="sort-table"  cellSpacing=1 cellPadding=1  border=1>
			<tr>
			<td colspan="2" valign="top" ><FONT color=black face=Arial size=2><b>Old Subject</b>:<br><%=oldSubject%></FONT></td>
			<td valign="top"><FONT color=black face=Arial size=2><b>Department</b>:<br><%=mDept%></FONT></td>
			<td  valign="top"><FONT color=black face=Arial size=2><b>LTP</b>:<br><%=mltp%></FONT></td>
			</tr>	
			<tr>
				<td colspan="4"><hr>
				</td>
			</tr>
			
			<tr bgcolor="#ff8c00">
				<TD><B>Emp Name</B></TD>
				<TD><B>Prog Code</B></TD>
				<TD><B>Sect Branch</B></TD>
				<TD><B>Sub Section</B></TD>	
			</TR>
			<%
			for( ii=1; ii<=Integer.parseInt(counter); ii++)
			{
				//out.println(request.getParameter("fstid"+ii));
				if(request.getParameter("fstid"+ii)!=null)
				{
					%><INPUT TYPE="hidden" NAME="fstid<%=ii%>"VALUE=<%=request.getParameter("fstid"+ii)%>><%
					qry=" select FACULTYID, PROGRAMCODE, SECTIONBRANCH, SUBSECTIONCODE, SEMESTERTYPE,employeename||' ('||Employeecode||')'empname,c.DEPARTMENT,c.DEPARTMENTCODE,A.LTP,A.MERGEWITHFSTID,a.FSTID from   PR#hodloadDistribution a , Employeemaster b,departmentmaster c where subjectid='"+subjectid+"' and examcode='"+mExamcode+"'   and a.DEPARTMENTRUNNIG=c.DEPARTMENTCODE and semestertype='RWJ' and a.institutecode='"+mInst+"' and a.companycode='"+mCompcode+"' and    a.FACULTYID=b.employeeid   and a.companycode=b.companycode   and b.COMPANYCODE='"+mCompcode+"'   and nvl(a.deactive,'N')='N'    and nvl(b.deactive,'N')='N' and nvl(c.deactive,'N')='N' and A.FSTID='"+request.getParameter("fstid"+ii)+"'  order by subsectioncode  ";
					//out.print(qry);
					rs= db.getRowset(qry);								
					while (rs.next())
					{				
						%>
						<TR>
						<TD><%=rs.getString("empname")%></TD>
						<TD><%=rs.getString("PROGRAMCODE")%></TD>
						<TD><%=rs.getString("SECTIONBRANCH")%></TD>
						<TD><%=rs.getString("SUBSECTIONCODE")%></TD><%
					}
				}
		
			}
			%>
			</tr>
			</table>

</td><td valign="top">			
			
			
			
			
			
			<INPUT TYPE="hidden" NAME="subjectid" value="<%=subjectid%>">
			<INPUT TYPE="hidden" NAME="DeptCode" value="<%=DeptCode%>">
			<INPUT TYPE="hidden" NAME="counter" value="<%=counter%>">
			<INPUT TYPE="hidden" NAME="LTP" value=<%=mLT%>><%
				

			%>
			
		<!-- 	<table id=id1 width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
				<tr>
					<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>New Subject Tagging </b></font>
					</td>
				</tr>
			</TABLE> -->
			<TABLE align=center rules=group  class="sort-table"  cellSpacing=1 cellPadding=1  border=1>
				<tr bgcolor="#ff8c00" >
					 <td nowrap width='20%' align='center' valign='top'>
						<FONT color=black face=Arial size=2><b>New Subject To Be Merged</b></FONT>
					</td>
			
			</tR><tr>
			<td align='left'>
			
			
			<%

			qry="select distinct subjectid, subject|| ' ('|| subjectcode ||') ' sub from subjectmaster where subjectid in (select distinct subjectid from pr#hodloaddistribution where examcode='"+mExamcode+"' and semestertype='REG' and nvl(deactive,'N')='N' and institutecode='"+mInst+"' and COMPANYCODE='"+mCompcode+"' and DEPARTMENTRUNNIG='"+DeptCode+"' and ltp='"+mLT+"' ) AND NVL (DEACTIVE, 'N') = 'N' order by sub";	
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
						//System.out.println(selected);
						
						%>
						
						<option <%=selected%> value='<%=rs.getString("subjectid")%>'> <%=rs.getString("sub")%></option>
							
						<%
						}
						%>
						</select>

					<br><center><INPUT TYPE="submit" name='submit' value='Submit' onclick="return validate();">
					</center></td>
				</tr>
			</table>
			
			
			</form>
			<%			
	if(request.getParameter("x")!=null)
			{
				/*if(request.getParameter("LTP")==null)
					oldSubject="";
				else
					oldSubject=request.getParameter("LTP");*/
				if(request.getParameter("oldSubject")==null)
					oldSubject="";
				else
					oldSubject=request.getParameter("oldSubject");
					//out.println(oldSubject);
%>
<form name="frm2"  method="Post" action='MergeoldSubject_newSubjectAction.jsp'>
<INPUT TYPE="hidden" NAME="subjectid1" value="<%=subjectid%>">
			<INPUT TYPE="hidden" NAME="DeptCode1" value="<%=DeptCode%>">
			<INPUT TYPE="hidden" NAME="counter1" value="<%=counter%>">
			<INPUT TYPE="hidden" NAME="LTP1" value=<%=mLT%>>

<%
	
if(counter.equals(""))
	counter="0";
for(int iii=1; iii<=Integer.parseInt(counter); iii++)
			{
				
				
				//out.println(request.getParameter("fstid"+ii));
				if(request.getParameter("fstid"+iii)!=null)
				{
					%><INPUT TYPE="hidden" NAME="fstid1<%=iii%>"VALUE=<%=request.getParameter("fstid"+iii)%>><%
			
				}
			
			}
			%>









<TABLE align=center rules=group  class="sort-table"  cellSpacing=1 cellPadding=1  border=1>
<tr bgcolor="#ff8c00">
<TD><B>Click</B></TD>
	<TD><B>Employee Name</B></TD>
	<TD><B>Programcode</B></TD>
	<TD><B>Section Branch</B></TD>
	<TD><B>Sub Section</B></TD>

</TR><%


				qry="   select NVL(MERGEWITHFSTID,'N') MERG,FACULTYID, PROGRAMCODE, SECTIONBRANCH, SUBSECTIONCODE, SEMESTERTYPE,employeename||' ('||Employeecode||')'empname,c.DEPARTMENT,c.DEPARTMENTCODE,A.LTP,a.fstid,a.subjectid from   PR#hodloadDistribution a , Employeemaster b,departmentmaster c where subjectid='"+oldSubject+"' and examcode='"+mExamcode+"'   and a.DEPARTMENTRUNNIG=c.DEPARTMENTCODE  and a.institutecode='"+mInst+"' and a.companycode='"+mCompcode+"' and    a.FACULTYID=b.employeeid   and a.companycode=b.companycode   and b.COMPANYCODE='"+mCompcode+"'   and nvl(a.deactive,'N')='N'  and a.LTP='"+mLT+"'  and nvl(b.deactive,'N')='N' AND NVL(c.deactive, 'N') = 'N' order by subsectioncode  ";
				//out.print(qry);
				rs= db.getRowset(qry);	
				
				while (rs.next())
				{++i;
				
				%>
				<TR>
					<td>
					<%if(!rs.getString("MERG").equals("N")){%>
					&nbsp;</td>
					<%}else{%>
					<INPUT TYPE="radio" NAME="mergfstid"  value="<%=rs.getString("fstid")%>"></td><%}%>
					<TD><%=rs.getString("empname")%></TD>
					<TD><%=rs.getString("PROGRAMCODE")%></TD>
					<TD><%=rs.getString("SECTIONBRANCH")%></TD>
					<TD><%=rs.getString("SUBSECTIONCODE")%></TD>
					</TR>

<%
				}
						
%>
			</TABLE>
			
			
			
			
			<center><br><input type="submit" value="Save" name="Save" onclick='return valid();'/></center>			
</td>
</tr>
</table>
			
			
			
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