<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
ResultSet rs12=null,rs=null,rs1=null,rs2=null,rs3=null,rs5=null,rsc=null,rsl=null,rsm=null,rssession=null,rssession1=null;
String mMemberID="",mDMemberID="",qry1="",moldMerge="",moldMerge1="",qrym="";
String mMemberName="",mSectBranch="";
String mMemberType="",mDMemberType="",mStudcnt="",mDis="",mvalue="",mMult="";
String mHead="",moldemp="",moldemp1="",mElecode="";
String mDMemberCode="",mMemberCode="",mFac="",mfac="",mElective="",mImMergeSec="";
String mInst="",mSection="",mSubsection="",mBasket="",mOfac="",mNameLMR="";
String qry="",Type="",mltp="",mSem="",mEmpid="",memp="",mName1="",mName2="",mNameLML="";
String mName3="",mName4="",mName5="",mName6="",mName7="",mName8="",mName9="",mName10="";
String mEmpIdTemp="";
String [] mMultiFaculty=new String [1000];
int mL1=0;
int mT1=0;
int mP1=0;				
int mlt1=0;
int mFlag2=0,mFlag1=0,mFlag11=0;
int ctr=0;
int msno=0;
String mType="",mLTP="",mSubj="",mDept="",mSname="",mExamcode="",mSeccount="",mPrCode="";
int mL=0,mT=0,mP=0,mlt=0;
double mAssigned=0,mMin=0,mMax=0,mexcludeassign=0;
double mAssignedload=0,mMinload=0,mMaxload=0;
String mEmpidv="",mSubjid="";
String mFacv="",mTyp="",mEmpTyp="",mcmp="",mEcmp="",mDuration="",mClass="",mSendhod="",mCompcode="";
String mSubjID="";
String values="";
String [] valueslist=new String[1000];
ArrayList list= new ArrayList();
if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}
if (session.getAttribute("CompanyCode")==null)
{
	mCompcode="";
}
else
{
	mCompcode=session.getAttribute("CompanyCode").toString().trim();
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
	{	OLTEncryption enc=new OLTEncryption();
		mDMemberID=enc.decode(mMemberID);
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);
		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk=null;
		String mEle="";
		String SC="",qrye="",sc="";
		ResultSet rse=null;
		//	int a=0;
		//-----------------------------
		//-- Enable Security Page Level  
		//-----------------------------
		qry="Select WEBKIOSK.ShowLink('56','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
	    if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	  	{		
			if(request.getParameter("y")==null)		
			{
			
			%><form name="frm1"  method="post" action="PRLoadDistributionHODMultiFut.jsp" ><%
			
			
			if(request.getParameter("ExamCode")==null)
				mExamcode="";
			else
				mExamcode=request.getParameter("ExamCode");
			if(request.getParameter("Sub")==null)
				mSubj="";
			else
				mSubj=request.getParameter("Sub");
			if(request.getParameter("Basket")==null)
				mBasket="";
			else
				mBasket=request.getParameter("Basket");
			if(request.getParameter("LTP")==null)
				mLTP="";
			else
				mLTP=request.getParameter("LTP");			
			
			if(request.getParameter("Dept")==null)
				mDept="";
			else
				mDept=request.getParameter("Dept");
			
			if(request.getParameter("Subjid")==null)
				mSubjid="";
			else
				mSubjid=request.getParameter("Subjid");
			
			if(request.getParameter("Elecode")==null)
				mElecode="";
			else
				mElecode=request.getParameter("Elecode");

			if(request.getParameter("ELE")==null)
				mEle="";
			else
				mEle=request.getParameter("ELE");

			if(request.getParameter("TYPE")==null)
				mType="";
			else
				mType=request.getParameter("TYPE");

			if(request.getParameter("SEM")==null)
				mSem="";
			else
				mSem=request.getParameter("SEM");

			if(request.getParameter("Subsection")==null)
				mSectBranch="";
			else
				mSectBranch=request.getParameter("Subsection");
	
			%>
			
			<input type=hidden name="Subjid"		value=<%=mSubjid%>>
			<input type=hidden name="Sub"			value=<%=mSubj%>>
			<input type=hidden name="Elecode"		value=<%=mElecode%>>
			<input type=hidden name="Basket"		value=<%=mBasket%>>
			<input type=hidden name="PRCODE"		value=<%=request.getParameter("PRCODE")%>>
			<input type=hidden name="radio1"		value=<%=request.getParameter("radio1")%>>
			<input type=hidden name="ELE"			value=<%=mEle%>>
			<input type=hidden name="SUBNAME"		value=<%=request.getParameter("SUBNAME")%>>
			<input type=hidden name="ExamCode"		value=<%=mExamcode%>>
			<input type=hidden name="TYPE"			value=<%=mType%>>
			<input type=hidden name="Dept"			value=<%=mDept%>>
			<input type=hidden name="LTP"			value=<%=mLTP%>>
			<input type=hidden name="SEM"			value=<%=mSem%>>
			<input type=hidden name="SECTIONBRANCH"	value=<%=mSectBranch%>>
			<input type=hidden name="Subsection"	value=<%=mSectBranch%>>
			<input type=hidden name="x"			value="">
			<table id=id1 width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
				<tr>
					<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">Assigned Load to Multiple Faculty</font></TD>
				</tr>
			</table>
			<table cellspacing=0 align=center border=2 rules=groups style="WIDTH: 400px">
				<tr bgcolor="#ff8c00">
					<td align=middle><b><font color=white>Multiple Faculty Choice</font><b></td>
				<tr>
				<%
					 qry="select fstid from PR#HODLOADDISTRIBUTION where institutecode='"+mInst+"' and examcode='"+mExamcode+"' and SUBJECTID='"+mSubjid+"' and sectionbranch='"+mSectBranch+"' and  LTP='"+mLTP+"' and semestertype='REG'  order by fstid ";
					//out.println(qry);	
					rsl=db.getRowset(qry);	
					if(rsl.next())
					{
						mImMergeSec=rsl.getString("fstid");
					}
					else
					{
						mImMergeSec="";
					}
					%><input Type="hidden" value="<%=mImMergeSec%>" name="fstid"><%
					//int i=0;
					qry="select a.EMPLOYEEID,a.FACULTYTYPE,a.NOFHRS from Temp#pr#loaddistribution a where COMPANYCODE='"+mCompcode+"' and SUBJECTID='"+mSubjid+"' and LTP='"+mLTP+"' and SECTIONBRANCH='"+mSectBranch+"' ";
					//out.print(qry);
					rs=db.getRowset(qry);
					if(rs.next())
					{ 
						qry="select EMPLOYEEID from Temp#pr#loaddistribution where COMPANYCODE='"+mCompcode+"' and SUBJECTID='"+mSubjid+"' and LTP='"+mLTP+"' and SECTIONBRANCH='"+mSectBranch+"' ";
						//out.print(qry);
						rs=db.getRowset(qry);
						while(rs.next())
						{
							list.add(rs.getString("EMPLOYEEID"));						
						}
							
					}
					else
					{		
						qry="select employeeid from MULTIFACULTYSUBJECTTAGGING  where fstid='"+mImMergeSec+"'";
						//out.println(qry);
						rs=db.getRowset(qry);	
						while(rs.next())
						{
							
							if(!list.contains(rs.getString("employeeid")))
							{
								list.add(rs.getString("employeeid"));						
							}
						}
					}
					if(request.getParameter("x")!=null)
					{
						if(request.getParameterValues("MultiFaculti")==null)
							values="";
						else
							valueslist=request.getParameterValues("MultiFaculti");
						
					}
					qry="select FACULTYID from PR#HODLOADDISTRIBUTION  where fstid='"+mImMergeSec+"'";
					//out.println(qry);
					rs=db.getRowset(qry);	
					while(rs.next())
					{
						mEmpIdTemp=rs.getString("FACULTYID");
						
					}//out.println(mInst+"<br>"+mCompcode+"<br>"+mMemberID+"<br>"+mMemberType+"<br>"+mMemberCode+"<br>"+mMemberName);
					//out.println(mExamcode+"<br>"+mSubj+"<br>"+mBasket+"<br>"+mLTP+"<br>"+mDept);
					qry="select A.Employeeid facultyid,A.Employeename employeename,A.COMPANYCODE companycode,";
					qry=qry+" A.EMPLOYEETYPE facultytype,to_char(WebKiosk.getAssignedTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+mExamcode+"'))assignedload, ";
					qry=qry+" to_char(WebKiosk.getAssignedTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid,A.EMPLOYEETYPE,'"+mExamcode+"','"+mSubj+"','"+mBasket+"','"+mLTP+"'))assignedload11, ";
					qry=qry+" to_char(WebKiosk.getMinTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+mExamcode+"')) minload,to_char(WebKiosk.getMaxTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE ,'"+mExamcode+"'))maxload  from V#STAFF A  where A.departmentcode='"+mDept+"' AND A.COMPANYCODE='"+mCompcode+"' ";
					//out.println(qry);
					rs=db.getRowset(qry);
					int flag=0;
				%>		
				<tr>
				<td>
					<select tabindex="0" style="WIDTH: 400px; HEIGHT: 200px" multiple name="MultiFaculti" >
						<!--<OPTION  Value ='NONE'>Select a Faculty</option>-->
					<%
						while(rs.next())
						{
							mFac=rs.getString("facultyid");
							
							if(!mEmpIdTemp.equals(mFac))
							{
							mTyp=rs.getString("facultytype");
							mcmp=rs.getString("companycode");
							String empname=rs.getString("employeename");
							empname=empname.replaceAll(" ",":");
							mFacv=mFac+"***"+mTyp+"///"+mcmp+"@@@"+empname;//
							if(request.getParameter("x")==null)
							{
								for(int j=0;j<list.size();j++)
								{
									if(list.get(j).equals(mFac))						
									{
										
										%><OPTION selected Value =<%=mFacv%>><%=rs.getString("employeename")%></option><%
											flag=1;
									}
								}
							}
							else
							{
									
									//System.out.println("hello: "+valueslist.length);
									for(int h=0;h<valueslist.length;h++)
									{			
										//System.out.println("asdfa"+valueslist[h]+"////////"+mFacv);
										if(valueslist[h]==null)
										{
											//System.out.println("hello13");
										}
										else if(valueslist[h].equals(mFacv))
										{
											//System.out.println("adsfasdf");
											%><OPTION selected Value =<%=mFacv%>><%=rs.getString("employeename")%></option><%
											flag=1;													
										}
									}
							}
							if(flag==0)
							{
								//System.out.println("hello2");
								%><OPTION Value =<%=mFacv%>><%=rs.getString("employeename")%></option><%
							}
						flag=0;
							}
							
						}
					%>
					</select>
				</td>	
				</tr>
				<tr><td align="center"><hr><td></tr>
				<tr><td align="center"><font size=3 color=green>* Select Multiple Faculty use Ctrl+MouseClick</font><td></tr>
				<tr><td align="center"><hr><td></tr>
				<tr><td align="center"><input type="submit" name="submit" value="OK"><td></tr>
				
				
			</table>
			</form>
			<%
			}
			if(request.getParameter("x")!=null && request.getParameter("y")==null)
			{
				
				%>
				<form name="frm1"  method="post" action="PRLoadDistributionHODMultiFut.jsp" >
				<input type=hidden name="SUBJID"		value=<%=request.getParameter("Subjid")%>>
				<input type=hidden name="SUBJ"			value=<%=request.getParameter("Sub")%>>
				<input type=hidden name="ELECTIVECODE"	value=<%=request.getParameter("Elecode")%>>
				<input type=hidden name="BASKET"		value=<%=request.getParameter("Basket")%>>
				<input type=hidden name="PRCODE"		value=<%=request.getParameter("PRCODE")%>>
				<input type=hidden name="radio1"		value=<%=request.getParameter("radio1")%>>
				<input type=hidden name="ELE"			value=<%=request.getParameter("ELE")%>>	
				<input type=hidden name="SUBNAME"		value=<%=request.getParameter("SUBNAME")%>>
				<input type=hidden name="EXAM"			value=<%=request.getParameter("ExamCode")%>>
				<input type=hidden name="TYPE"			value=<%=request.getParameter("TYPE")%>>
				<input type=hidden name="DEPT"			value=<%=request.getParameter("Dept")%>>
				<input type=hidden name="LTP"			value=<%=request.getParameter("LTP")%>>
				<input type=hidden name="SEM"			value=<%=request.getParameter("SEM")%>>
				<input type=hidden name="SECTIONBRANCH"	value=<%=request.getParameter("SECTIONBRANCH")%>>
								<input type=hidden name="y"			value="">
				
				<%
					mImMergeSec=request.getParameter("fstid")	;
				ArrayList sessionlist= new ArrayList();
				int h=0;
				if(request.getParameterValues("MultiFaculti")==null)
					values="";
				else
					valueslist=request.getParameterValues("MultiFaculti");				
				if(valueslist[0]!=null)
				{
				
				%>
				<table cellspacing=0 align=center border=2 rules=groups>
				<tr bgcolor="#ff8c00">
					<td align="center" width="70%"><b><font color=white>Faculty Name</b></font></td>
					<td align="center" width="30%"><b><font color=white>Duration (Hr)</b></font></td>
 				<tr>				
				<%
				for(h=0;h<valueslist.length;h++)
				{													
					String aa=valueslist[h];
					String bb = aa.substring(aa.indexOf("@@@")+3,aa.length());
					bb=bb.replaceAll(":"," ");
					String cc=aa.substring(0,aa.indexOf("***"));
					sessionlist.add(aa);
					%>
						<tr>
						<td align="center"><input type="text" name="factName<%=h%>" value="<%=bb%>" readonly size="35"></td>
					<%
						try{
						
						String qry12345="select EMPLOYEEID, NOFHRS from MULTIFACULTYSUBJECTTAGGING  where fstid='"+mImMergeSec+"' and EMPLOYEEID='"+cc+"'";
						//out.println(qry12345);
						rs12=db.getRowset(qry12345);	
						if(rs12.next())
						{
														
							
								%><td align="center"><input type="text" name="hr<%=h%>" size=2 value=<%=rs12.getString("NOFHRS")%>  maxlength='1'></td></tR><%
							
							
						}
						else
							{
									%><td align="center"><input type="text" name="hr<%=h%>" size=2 value=1  maxlength='1'></td></tR><%
							}
					}catch(Exception e)
					{
						//out.print(e);
					}
						%>
						
						
						
						
					<%
				}					
				session.setAttribute("MultiFaculti",null);
				session.setAttribute("MultiFaculti",sessionlist);
				%>
				<input type="hidden" name="counter" value="<%=h%>"/>
				<tr>
					<td align="center" colspan="2"><hr></td>
				</tr>
				<tr>
					<td align="center" colspan="2"><input type="submit" name="submit" value="Save"></td>
				</tr>
				</table>
				</form>
				<%
				}
			}
			else if(request.getParameter("y")==null)
			{
				if(list.size()>0)
				{
				//out.println(list.size());
				%>
				<form name="frm1"  method="post"		action="PRLoadDistributionHODMultiFut.jsp" >
				<input type=hidden name="SUBJID"		value=<%=request.getParameter("Subjid")%>>
				<input type=hidden name="SUBJ"			value=<%=request.getParameter("Sub")%>>
				<input type=hidden name="ELECTIVECODE"	value=<%=request.getParameter("Elecode")%>>
				<input type=hidden name="BASKET"		value=<%=request.getParameter("Basket")%>>
				<input type=hidden name="PRCODE"		value=<%=request.getParameter("PRCODE")%>>
				<input type=hidden name="radio1"		value=<%=request.getParameter("radio1")%>>
				<input type=hidden name="ELE"			value=<%=request.getParameter("ELE")%>>	
				<input type=hidden name="SUBNAME"		value=<%=request.getParameter("SUBNAME")%>>
				<input type=hidden name="EXAM"			value=<%=request.getParameter("ExamCode")%>>
				<input type=hidden name="TYPE"			value=<%=request.getParameter("TYPE")%>>
				<input type=hidden name="DEPT"			value=<%=request.getParameter("Dept")%>>
				<input type=hidden name="LTP"			value=<%=request.getParameter("LTP")%>>
				<input type=hidden name="SEM"			value=<%=request.getParameter("SEM")%>>
				<input type=hidden name="SECTIONBRANCH"			value=<%=mSectBranch%>>
				<input type=hidden name="y"			value="">
				<%
				ArrayList viewList=new ArrayList();	
				qry="select A.Employeeid facultyid,A.Employeename employeename,A.COMPANYCODE companycode,";
					qry=qry+" A.EMPLOYEETYPE facultytype,to_char(WebKiosk.getAssignedTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+mExamcode+"'))assignedload, ";
					qry=qry+" to_char(WebKiosk.getAssignedTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid,A.EMPLOYEETYPE,'"+mExamcode+"','"+mSubj+"','"+mBasket+"','"+mLTP+"'))assignedload11, ";
					qry=qry+" to_char(WebKiosk.getMinTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+mExamcode+"')) minload,to_char(WebKiosk.getMaxTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE ,'"+mExamcode+"'))maxload  from V#STAFF A  where A.departmentcode='"+mDept+"' AND A.COMPANYCODE='"+mCompcode+"' ";
					//out.println(qry);
					rs=db.getRowset(qry);
					//int flag=0;
					int h=0;
					while(rs.next())
					{
						mFac=rs.getString("facultyid");
						mTyp=rs.getString("facultytype");
						mcmp=rs.getString("companycode");
						String empname=rs.getString("employeename");
						empname=empname.replaceAll(" ",":");
						mFacv=mFac+"***"+mTyp+"///"+mcmp+"@@@"+empname;//
						if(request.getParameter("x")==null)
						{
							for(int j=0;j<list.size();j++)
							{
								if(list.get(j).equals(mFac))						
								{
									//viewList.add(mFacv);
									String qry123="select NOFHRS from MULTIFACULTYSUBJECTTAGGING  where fstid='"+mImMergeSec+"' and FACULTYTYPE='"+mTyp+"' and EMPLOYEEID='"+mFac+"' ";//and COMPANYCODE='"+mcmp+"' ";
									//out.println(qry);
									rssession=db.getRowset(qry123);	
									if(rssession.next())
									{
										mFacv=mFacv+"!!!"+rssession.getString("NOFHRS");
										//out.println(mFacv);
										viewList.add(mFacv);
									}	
									/*****/
									else
									{
									String qry1234="";
									qry1234="select NOFHRS from Temp#pr#loaddistribution  where  FACULTYTYPE='"+mTyp+"' and EMPLOYEEID='"+mFac+"' and COMPANYCODE='"+mcmp+"' and LTP ='"+mLTP+"' and SECTIONBRANCH='"+mSectBranch+"' ";
									out.println(qry1234);
									rssession1=db.getRowset(qry1234);	
									if(rssession1.next())
									{
										mFacv=mFacv+"!!!"+rssession1.getString("NOFHRS");
										//out.println(mFacv);
										viewList.add(mFacv);
									}
									}								
								}
							}
						}
			
					}
				ArrayList sessionlist= new ArrayList();				
				%>
				<table cellspacing=0 align=center border=2 rules=groups>
				<tr bgcolor="#ff8c00">
					<td align="center" width="70%"><b><font color=white>Faculty Name</b></font></td>
					<td align="center" width="30%"><b><font color=white>Duration (Hr)</b></font></td>
 				<tr>				
				<%
				
				for(h=0;h<viewList.size();h++)
				{													
					String aa=(String)viewList.get(h);
					//out.println(aa);
					String bb = aa.substring(aa.indexOf("@@@")+3,aa.indexOf("!!!"));
					
					bb=bb.replaceAll(":"," ");
					String cc=aa.substring(aa.indexOf("!!!")+3,aa.length());
					String dd=aa.substring(0,aa.indexOf("!!!"));
					sessionlist.add(aa);
					%>
						<tr>
						<td align="center"><input type="text" name="factName<%=h%>" value="<%=bb%>" readonly size="35"></td>
						<td align="center"><input type="text" name="hr<%=h%>" size=2 value=<%=cc%>  maxlength='1'></td>
						<tr>
					<%
				}					
				session.setAttribute("MultiFaculti",null);
				session.setAttribute("MultiFaculti",sessionlist);
				%>
				<input type="hidden" name="counter" value="<%=h%>"/>
				<tr>
					<td align="center" colspan="2"><hr></td>
				</tr>
				<tr>
					<td align="center" colspan="2"><input type="submit" name="submit" value="Save"></td>
				</tr>
				</table>
				</form>
				<%
				}
			}
			if(request.getParameter("y")!=null)
			{
				try{
				ArrayList  futlist=new ArrayList();
				if(session.getAttribute("MultiFaculti")==null)
				{
					mMult="";
					session.setAttribute("MultiFaculti",null);
				}
				else
				{
					//out.println(session.getAttribute("MultiFaculti"));
					
					futlist=(ArrayList)session.getAttribute("MultiFaculti");
				//	if(request.getParameter("counter")==null)
					int i=0;
					int n=0;
					for(i=0;i<futlist.size();i++)
					{
						//out.println("sss"+(futlist.get(i).toString())+request.getParameter("hr"+i));
						String ii="0";
						if(request.getParameter("hr"+i)==null)
							ii="0";
						else
							ii=request.getParameter("hr"+i);
						mMultiFaculty[i]=(futlist.get(i).toString())+"###"+ii;
						//out.println("asdf"+(futlist.get(i).toString())+"###"+ii);
					}
					session.setAttribute("MultiFaculti",null);
					session.setAttribute("MultiFaculti",mMultiFaculty);
					String ltp=request.getParameter("LTP");
					String subid1=request.getParameter("SUBJID");
					String secbran=request.getParameter("SECTIONBRANCH");
					String [] multiFaculty=(String [])session.getAttribute("MultiFaculti");
					//out.println("addddd"+i);
					qry="delete from TEMP#PR#LOADDISTRIBUTION where LTP='"+ltp+"' and  COMPANYCODE='"+mCompcode+"' and SECTIONBRANCH ='"+secbran+"' and SUBJECTID='"+subid1+"' and USERID='"+mChkMemID+"'";
					int n123=db.insertRow(qry);
					//out.println(n123);
					for(int j=0;j<i;j++)
					{
						//out.println(i);
						String aa=multiFaculty[j];
						String fid=aa.substring(0,aa.indexOf("***"));
						String ftype=aa.substring(aa.indexOf("***")+3,aa.indexOf("///"));
						String cmp=aa.substring(aa.indexOf("///")+3,aa.indexOf("@@@"));
						String hr=aa.substring(aa.indexOf("###")+3,aa.length());
						String id=ltp+secbran;
						//int hrr=Integer.parseInt(hr);
						//qry="INSERT INTO TEMP#PR#LOADDISTRIBUTION ( SESSIONID, USERID, SUBJECTID, SECTIONBRANCH,  LTP) VALUES ( 'dd','"+mChkMemID+"' ,'"+subid1+"', '"+secbran+"','"+ltp+"')";
						//qry="delete from TEMP#PR#LOADDISTRIBUTION where SESSIONID='"+id+"'";
						//int n123=db.insertRow(qry);	
						qry="INSERT INTO TEMP#PR#LOADDISTRIBUTION ( SESSIONID, USERID, SUBJECTID, SECTIONBRANCH,  LTP,COMPANYCODE, FACULTYTYPE, EMPLOYEEID, NOFHRS, DATETIME) VALUES ( '"+id+"','"+mChkMemID+"' ,'"+subid1+"', '"+secbran+"','"+ltp+"','"+cmp+"' , '"+ftype+"', '"+fid+"',"+hr+" ,sysdate )";
						//out.println(qry);
						n=db.insertRow(qry);	
						
					}
					if(n>0)
					{
						out.println("<center><font size=3 color=red>data is Saved successfully....</font></center>");
						out.println("<center><input type='submit' name='submit' value='close' onclick='window.close();'</center>");
					}
				}
				//session.setAttribute("MultiFaculti",null);
				}
				catch(Exception e)
				{
					//System.out.println(e);
					out.println("<center><font size=3 color=red>data is Saved successfully....</font></center>");
							out.println("<center><input type='submit' name='submit' value='close' onclick='window.close();'</center>");
				}
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
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}      
}
catch(Exception e)
{
	//out.println(e);
}
%>
</body>
</html>