<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
ResultSet rs=null,rs1=null,rs2=null,rs3=null,rs5=null,rsc=null,rsl=null,rsm=null,rssession=null,rs12=null,rssession1=null;
String mMemberID="",mDMemberID="",qry1="",moldMerge="",moldMerge1="",qrym="";
String mMemberName="",mSectBranch="";
String mMemberType="",mDMemberType="",mStudcnt="",mDis="",mvalue="";
String mHead="",moldemp="",moldemp1="",mElecode="";
String mDMemberCode="",mMemberCode="",mFac="",mfac="",mElective="",mImMergeSec="";
String mInst="",mSection="",mSubsection="",mBasket="",mOfac="",mNameLMR="";
String qry="",Type="",mltp="",mSem="",mEmpid="",memp="",mName1="",mName2="",mNameLML="";
String mName3="",mName4="",mName5="",mName6="",mName7="",mName8="",mName9="",mName10="",mAcad="",mProg="";
String mEmpIdTemp="";
String as1="",as2="",as3="";
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
String values="",mMult="";
String [] valueslist=new String[1000];
String [] mMultiFaculty=new String [1000];
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
function valid()
{
	//alert(document.frmfirst.classweek12.value);
	var total=document.frmfirst.classweek.value;
	//alert(total);
	if(document.frmfirst.setText1.value=="" || document.frmfirst.setText1.value=="0")
	{
		//alert("Please enter value between 1 to onwards");
		
		if(document.frmfirst.setText2.value!="" || document.frmfirst.setText2.value!="0")
		{
			alert("Please first enter Set-1's No. Of Class(s)");
			return false;
		}
		if(document.frmfirst.setText3.value!="" || document.frmfirst.setText3.value!="0")
		{
			alert("Please first enter Set-1's No. Of Class(s)");
			return false;
		}
	}
	/*if(document.frmfirst.setText3.value!="" || document.frmfirst.setText3.value!="0")
		{
			alert("Please first enter Set-1's No. Of Class(s)");
			return false;
		}*/
	
	if(document.frmfirst.setText2.value=="" || document.frmfirst.setText2.value=="0")
	{
		 //alert("Please enter value between 1 to onwards");
		
		if(document.frmfirst.setText3.value=="" || document.frmfirst.setText3.value=="0")
		{
			/*alert("Please first enter Set-2's No. Of Class(s)");
			return false;*/
		}
		else
		{
			alert("Please first enter Set-2's No. Of Class(s)");
			return false;
		}
	}
	
	
	
	/*if(document.frmfirst.setText3.value!="" || document.frmfirst.setText3.value!="0")
	{
		//alert("Please enter value between 1 to onwards");
		if(document.frmfirst.setText2.value=="" || document.frmfirst.setText2.value=="0")
		{
			alert("Please first enter Set-2's No. Of Class(s)");
						return false;
		}
		
	}*/

	
/*	if(document.frmfirst.setText2.value=="" || document.frmfirst.setText2.value=="0")
	{
		//alert("Please enter value between 1 to onwards");
		if(document.frmfirst.setText3.value!="" || document.frmfirst.setText3.value!="0")
		{
			alert("Please first enter Set-2's No. Of Class(s)");
						return false;
		}
		
	}*/


	if(document.frmfirst.setText1.value=="" || document.frmfirst.setText1.value=="0")
	{
		alert("Please enter value between 1 to onwards");
		return false;
	}

	
		//alert("hello");
		var s1="";
		var s2="";
		var s3="";

		if(document.frmfirst.setText1.value=="")
			s1="0";
		else
			s1=document.frmfirst.setText1.value;
		if(document.frmfirst.setText2.value=="")
			s2="0";
		else
			s2=document.frmfirst.setText2.value;
		if(document.frmfirst.setText3.value=="")
			s3="0";
		else
			s3=document.frmfirst.setText3.value;
		//alert(total);
		
		if(total!=(parseInt(s1))+(parseInt(s2))+(parseInt(s3)))
		{
			alert("Class in a Week is not less or more than "+ total);
			return false;
		}

	
}
function Vlaid2()
{
	/*alert(document.frmsecond.s1.value);
	alert(document.frmsecond.s2.value);
	alert(document.frmsecond.s3.value);
	alert(document.frmsecond.counter.value);*/
	//alert(document.frmsecond.s3.value);
	var set1="";
	var set2="";
	var set3="";
	for(var i=0 ;i<document.frmsecond.counter.value; i++)
	{
		
		var aa="set"+i;
		//alert(document.frmsecond[aa].value);
		var bb=document.frmsecond[aa].value
		var aaa=bb.substr(0,5);
		//alert(aaa);
		if(aaa=="SET-1")
		{
			set1="Y";
		}
		else if(aaa=="SET-2")
		{
			set2="Y";
		}
		else if (aaa=="SET-3")
		{
			set3="Y";
		}
	}
	if(document.frmsecond.s2.value!="" && document.frmsecond.s2.value!="0")
	{
		if(set2!='Y')
		{
			alert("Please select SET-2");
			return false;
		}
	}
	if(document.frmsecond.s3.value!="" && document.frmsecond.s3.value!="0")
	{
		if(set3!='Y')
		{
			alert("Please select SET-3");
			return false;
		}
	}

}
	



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
			%><form name="frmfirst"  method="post" action="PRLoadDistributionHODActionMultiFac.jsp" ><%
						
			if(request.getParameter("ExamCode")==null)
				mExamcode="";
			else
				mExamcode=request.getParameter("ExamCode");

			if(request.getParameter("mProg")==null)
				mProg="";
			else
				mProg=request.getParameter("mProg");


			if(request.getParameter("mAcad")==null)
				mAcad="";
			else
				mAcad=request.getParameter("mAcad");
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

			if(request.getParameter("section")==null)
				mSectBranch="";
			else
			{
				mSectBranch=request.getParameter("section");
				session.setAttribute("secbranch",mSectBranch);
				//out.println(mSectBranch+"<BR>asasa");
			}
			String mSubSecNew="";
			if(request.getParameter("mSubSection")==null)
				mSubSecNew="";
			else
			{
				mSubSecNew=request.getParameter("mSubSection");
				session.setAttribute("subsecsess",mSubSecNew);
				//out.println(mSubSecNew);
			}
//out.println(session.getAttribute("subsecsess")+"ses");
			String classweek1="";
			
			if(request.getParameter("classweek")==null)
				classweek1="";
			else
				classweek1=request.getParameter("classweek");
	
			%>
			<input type=hidden name="mProg"		value=<%=mProg%>>
			<input type=hidden name="Subjid"		value=<%=mSubjid%>>
			<input type=hidden name="mAcad"		value=<%=mAcad%>>
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
			<input type=hidden name="SECTIONBRANCH"	value=<%=request.getParameter("section")%>>
			<input type=hidden name="SubSection"	value=<%=request.getParameter("mSubSection")%>>
			<input type=hidden name="section"		value=<%=mSectBranch%>>
			<input type=hidden name="x"				value="">
			<input type=hidden name="classweek12"	value="<%=classweek1%>">
			<input type=hidden name="classweek"		value="<%=request.getParameter("classweek")%>">
			<table id=id1 width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
				<tr>
					<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><STRONG>Assigned Load to Multiple/Additional Faculty</STRONG></font></TD>
				</tr>
			</table>
			<table cellspacing=0 align=center border=2 rules=groups style="WIDTH: 400px">
				<tr bgcolor="#ff8c00">
					<td align=middle><b><font color=white face=arial>Multiple Faculty Choice</font><b></td>
				<tr>
				<%
					 qry="select fstid from PR#HODLOADDISTRIBUTION where institutecode='"+mInst+"' and examcode='"+mExamcode+"' and SUBJECTID='"+mSubjid+"' and sectionbranch='"+session.getAttribute("secbranch")+"' and SUBSECTIONCODE='"+session.getAttribute("subsecsess")+"' and LTP='"+mLTP+"' and semestertype='"+mSem+"' and academicyear='"+mAcad+"' and programcode='"+mProg+"' order by fstid ";
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
					
					int i=0;
					qry="select a.EMPLOYEEID,a.FACULTYTYPE,a.NOFHRS from Temp#pr#loaddistribution a where  SUBJECTID='"+mSubjid+"' and LTP='"+mLTP+"' and SECTIONBRANCH='"+session.getAttribute("secbranch")+"' and SUBSECTIONCODE='"+session.getAttribute("subsecsess")+"' and academicyear='"+mAcad+"' and programcode='"+mProg+"'";
					//out.print(qry);
					rs=db.getRowset(qry);
					if(rs.next())
					{ 
						qry="select EMPLOYEEID,nvl(set1,'0')set1,nvl(set2,'0')set2,nvl(set3,'0')set3  from Temp#pr#loaddistribution where SUBJECTID='"+mSubjid+"' and LTP='"+mLTP+"' and SECTIONBRANCH='"+session.getAttribute("secbranch")+"' and SUBSECTIONCODE='"+session.getAttribute("subsecsess")+"' and academicyear='"+mAcad+"' and programcode='"+mProg+"'";
						//out.print(qry);
						rs=db.getRowset(qry);
						while(rs.next())
						{
							list.add(rs.getString("EMPLOYEEID"));	
							as1=rs.getString("set1");
							as2=rs.getString("set2");
							as3=rs.getString("set3");
						}

							
					}
					else
					{		
						qry="select employeeid,nvl(set1,'0')set1,nvl(set2,'0')set2,nvl(set3,'0')set3 from MULTIFACULTYSUBJECTTAGGING  where fstid='"+mImMergeSec+"'";
						//out.println(qry);
						rs=db.getRowset(qry);	
						while(rs.next())
						{
							
							if(!list.contains(rs.getString("employeeid")))
							{
								list.add(rs.getString("employeeid"));						
							}
							as1=rs.getString("set1");
							as2=rs.getString("set2");
							as3=rs.getString("set3");
						}
					}
					/*qry="select employeeid from MULTIFACULTYSUBJECTTAGGING  where fstid='"+mImMergeSec+"'";
					//out.println(qry);
					rs=db.getRowset(qry);	
					while(rs.next())
					{
							list.add(rs.getString("employeeid"));						
					}*/
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
						
					}
					
//					out.println(mEmpIdTemp);
					%><input type="hidden" name="empId" value="<%=mEmpIdTemp%>"><%
					//out.println(mInst+"<br>"+mCompcode+"<br>"+mMemberID+"<br>"+mMemberType+"<br>"+mMemberCode+"<br>"+mMemberName);
					//out.println(mExamcode+"<br>"+mSubj+"<br>"+mBasket+"<br>"+mLTP+"<br>"+mDept);
					qry="select A.Employeeid facultyid,A.Employeename employeename,A.COMPANYCODE companycode,";
					qry+=" A.EMPLOYEETYPE facultytype,to_char(WebKiosk.getAssignedTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+mExamcode+"'))assignedload, ";
					qry+=" to_char(WebKiosk.getAssignedTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid,A.EMPLOYEETYPE,'"+mExamcode+"','"+mSubj+"','"+mBasket+"','"+mLTP+"'))assignedload11, ";
					qry+=" to_char(WebKiosk.getMinTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+mExamcode+"')) minload,to_char(WebKiosk.getMaxTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE ,'"+mExamcode+"'))maxload  from V#STAFF A  where A.departmentcode='"+mDept+"' AND A.COMPANYCODE='"+mCompcode+"'  and nvl(a.deactive,'N')='N'";
					qry+=" order by employeename ";
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
							
							//System.out.println("sunny");
							mFac=rs.getString("facultyid");
							if(!mEmpIdTemp.equals(mFac))
							{
								//System.out.println("sunny "+mFac );
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
								qry="select A.Employeeid facultyid,A.Employeename employeename,A.COMPANYCODE companycode,";
								qry+=" A.EMPLOYEETYPE facultytype,to_char(WebKiosk.getAssignedTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+mExamcode+"'))assignedload, ";
								qry+=" to_char(WebKiosk.getAssignedTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid,A.EMPLOYEETYPE,'"+mExamcode+"','"+mSubj+"','"+mBasket+"','"+mLTP+"'))assignedload11, ";
								qry+=" to_char(WebKiosk.getMinTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+mExamcode+"')) minload,to_char(WebKiosk.getMaxTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE ,'"+mExamcode+"'))maxload  from V#STAFF A  where A.departmentcode='"+mDept+"' AND A.COMPANYCODE='"+mCompcode+"'  and nvl(a.deactive,'N')='N'";
								qry+=" and A.employeeid in (select EMPLOYEEID from multifacultysubjecttagging where INSTITUTECODE='"+mInst+"' and COMPANYCODE='"+mCompcode+"' and FSTID in (select fstid from PR#HODLOADDISTRIBUTION where INSTITUTECODE='"+mInst+"' and COMPANYCODE='"+mCompcode+"' and EXAMCODE='"+mExamcode+"' and SECTIONBRANCH='"+mSectBranch+"' and  programcode='"+mProg+"' and  academicyear='"+mAcad+"'  and SUBSECTIONCODE='"+session.getAttribute("subsecsess")+"' and SEMESTERTYPE='"+mSem+"' and SUBJECTID='"+mSubjid+"' and LTP='"+mLTP+"'))";
								qry+=" and A.Employeeid='"+mFac+"' order by employeename ";
								//System.out.println(qry);
								ResultSet rsPreReg=db.getRowset(qry);
								if(rsPreReg.next())
								{
									%><OPTION SELECTED Value =<%=mFacv%>><%=rs.getString("employeename")%></option><%
								}
								else
								{
									%><OPTION Value =<%=mFacv%>><%=rs.getString("employeename")%></option><%
								}
							}
								flag=0;
							}
						}
					%>
					</select>
				</td>	
				</tr>
				<tr><td align="center"><td></tr>

				<tr><td align="center">
				<font size=3 color=green>* Select Multiple Faculty use Ctrl+MouseClick</font><td></tr>
				<tr><td align="center"><hr><td></tr>
				<tr><td align="center">
				<font size=3 color=green>* Enter No. of Class per Week :- <%=request.getParameter("classweek")%></font><td></tr>
				<tr><td align="center"><hr><td></tr>				
				<TR>

				<td align='center'>&nbsp;&nbsp;<B>Set 1</B>&nbsp;&nbsp;
				<%
				if(request.getParameter("setText1")!=null && !request.getParameter("setText1").equals(""))
				{
					%><INPUT TYPE="text" id="setText1" NAME="setText1" size=2 maxlength='2' value=<%=request.getParameter("setText1")%>>&nbsp;&nbsp;<%
				}
				else
				{
					%><INPUT TYPE="text" id="setText1" NAME="setText1" size=2 maxlength='2' value=<%=as1%>>&nbsp;&nbsp;<%
				}
					
				%><B>Set 2</B>&nbsp;&nbsp;<%
				if(request.getParameter("setText2")!=null && !request.getParameter("setText2").equals(""))
				{
					%><INPUT TYPE="text" NAME="setText2" size=2 maxlength='2' value=<%=request.getParameter("setText2")%>>&nbsp;&nbsp;<%
				}
				else
				{
					%><INPUT TYPE="text" NAME="setText2" size=2 maxlength='2' value=<%=as2%>>&nbsp;&nbsp;<%
				}

				%><B>Set 3</B>&nbsp;&nbsp;<%
				if(request.getParameter("setText3")!=null && !request.getParameter("setText3").equals(""))
				{
					%><INPUT TYPE="text" NAME="setText3" size=2 maxlength='2' value=<%=request.getParameter("setText3")%>>&nbsp;</td><%
				}
				else
				{
					%><INPUT TYPE="text" NAME="setText3" size=2 maxlength='2' value=<%=as3%>>&nbsp;</td><%
				}
				%>
				</TR>
				<tr><td align="center"><input type="submit" name="submit" value="Select" onClick="return valid();"><td></tr>
			</table>
			</form>
			<%
			}//if 
			if(request.getParameter("x")!=null && request.getParameter("y")==null)
			{
				%>
				<form name="frmsecond"  method="post" action="PRLoadDistributionHODActionMultiFac.jsp" >
				<input type=hidden name="mProg"		value=<%=request.getParameter("mProg")%>>
				<input type=hidden name="mAcad"		value=<%=request.getParameter("mAcad")%>>
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
				<input type=hidden name="SubSection"	value=<%=request.getParameter("SubSection")%>>
				<input type=hidden name="y"			value="">
				<input type=hidden name="classweek"			value="<%=request.getParameter("classweek")%>">
				<%
				/*out.println(request.getParameter("setText1"));
				out.println(request.getParameter("setText2"));
				out.println(request.getParameter("setText3"));*/
				mImMergeSec=request.getParameter("fstid")	;
				/*out.println(!request.getParameter("setText3").equals(""));*/
				%>
				<INPUT TYPE="hidden" NAME="s1" value="<%=request.getParameter("setText1")%>">
				<INPUT TYPE="hidden" NAME="s2" value="<%=request.getParameter("setText2")%>">
				<INPUT TYPE="hidden" NAME="s3" value="<%=request.getParameter("setText3")%>">
				
				<%
				ArrayList sessionlist= new ArrayList();
				int h=0;
				if(request.getParameterValues("MultiFaculti")==null)
					values="";
				else
					valueslist=request.getParameterValues("MultiFaculti");	

				if(valueslist[0]!=null)
				{
				%>
				<table cellspacing=0 align=center border=2 rules='groups'>
				<tr bgcolor="#ff8c00">
					<td align="center"><b><font color=white>Faculty Name</b></font></td>
					<td align="center"><b><font color=white>FacultySet</b></font></td>
					<!-- <td align="center"><b><font color=white>Class in a week</b></font></td>	 -->
 				<tr>				
				<%
				for(h=0;h<valueslist.length;h++)
				{													
					String aa=valueslist[h];
					String bb = aa.substring(aa.indexOf("@@@")+3,aa.length());
					String cc=aa.substring(0,aa.indexOf("***"));
					bb=bb.replaceAll(":"," ");
					//out.println(aa);
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
														
							
								%><td align="center">
								<input type="hidden" name="hr<%=h%>" size=2 value=<%=rs12.getString("NOFHRS")%>  maxlength='1'>
								<SELECT NAME="set<%=h%>">
								<%
									if(request.getParameter("setText1")!=null && !request.getParameter("setText1").equals("") && !request.getParameter("setText1").equals("0"))
									{
										%>
										
										<OPTION VALUE="SET-1~~~<%=request.getParameter("setText1")%>" >SET 1<%
									}
									if(request.getParameter("setText2")!=null && !request.getParameter("setText2").equals("") && !request.getParameter("setText2").equals("0"))
									{
										%><OPTION VALUE="SET-2~~~<%=request.getParameter("setText2")%>">SET 2<%
									}
										if(request.getParameter("setText3")!=null && !request.getParameter("setText3").equals("") && !request.getParameter("setText3").equals("0"))
									{
										%><OPTION VALUE="SET-3~~~<%=request.getParameter("setText3")%>">SET 3<%
									}
								%>	
									
									
									
									
													
								
								</SELECT>
								</td>
								<%--<td><input type="text" name="classWeek<%=h%>" size=2 value=<%=rs12.getString("NOFHRS")%>  maxlength='1'></td>--%>
								</tR><%
							
							
						}
						else
							{
									%><td align="center">
									<input type="hidden" name="hr<%=h%>" size=2 value=1  maxlength='1'>
									<SELECT NAME="set<%=h%>">
									<%
									if(request.getParameter("setText1")!=null && !request.getParameter("setText1").equals("") && !request.getParameter("setText1").equals("0"))
									{
										%>
										
										<OPTION VALUE="SET-1~~~<%=request.getParameter("setText1")%>" >SET 1<%
									}
									if(request.getParameter("setText2")!=null && !request.getParameter("setText2").equals("") && !request.getParameter("setText2").equals("0"))
									{
										%><OPTION VALUE="SET-2~~~<%=request.getParameter("setText2")%>">SET 2<%
									}
										if(request.getParameter("setText3")!=null && !request.getParameter("setText3").equals("") && !request.getParameter("setText3").equals("0"))
									{
										%><OPTION VALUE="SET-3~~~<%=request.getParameter("setText3")%>">SET 3<%
									}
								%>	
									
								</SELECT>
									
									</td>
									<%--<td><input type="text" name="classWeek<%=h%>" size=2 value=1  maxlength='1'></td>--%></tR><%
							}


						%>
						<INPUT TYPE="hidden" NAME="setText1" value=<%=request.getParameter("setText1")%>>
						<INPUT TYPE="hidden" NAME="setText2" value=<%=request.getParameter("setText2")%>>
						<INPUT TYPE="hidden" NAME="setText3" value=<%=request.getParameter("setText3")%>>
						<%
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
					<td align="center" colspan="3"><hr></td>
				</tr>
				<tr>
					<td align="center" colspan="3"><input type="submit" name="submit" value="Save" onClick="return Vlaid2()"> &nbsp;&nbsp;
					<%//if(h==1){%>
					<!--  <input type="submit" name="delete" value="Delete"> -->
					<%//}%>
					
					</td>
				</tr>
				</table>
				</form>
				<%
				}
			}//lll
			else if(request.getParameter("y")==null)
			{
				//out.println(list.size());
				if(list.size()>0)
				{
					%>
					<form name="frmthird"  method="post" action="PRLoadDistributionHODActionMultiFac.jsp" >
					<input type=text name="mProg"		value=<%=request.getParameter("mProg")%>>
					<input type=text name="mAcad"		value=<%=request.getParameter("mAcad")%>>
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
					<input type=hidden name="classweek"			value="<%=request.getParameter("classweek")%>">
					<input type=hidden name="SECTIONBRANCH"			value=<%=mSectBranch%>>
					<input type=hidden name="SubSection"			value=<%=request.getParameter("SubSection")%>>
					<input type=hidden name="y"			value="">
					
					<%
					mEmpIdTemp=request.getParameter("empId");
					ArrayList viewList=new ArrayList();	
					qry="select A.Employeeid facultyid,A.Employeename employeename,A.COMPANYCODE companycode,";
					qry+=" A.EMPLOYEETYPE facultytype,to_char(WebKiosk.getAssignedTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+mExamcode+"'))assignedload, ";
					qry+=" to_char(WebKiosk.getAssignedTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid,A.EMPLOYEETYPE,'"+mExamcode+"','"+mSubj+"','"+mBasket+"','"+mLTP+"'))assignedload11, ";
					qry+=" to_char(WebKiosk.getMinTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+mExamcode+"')) minload,to_char(WebKiosk.getMaxTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE ,'"+mExamcode+"'))maxload  from V#STAFF A  where A.departmentcode='"+mDept+"' AND A.COMPANYCODE='"+mCompcode+"' and nvl(a.deactive,'N')='N' order by employeename ";
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
									String qry123="select NOFHRS,set1,set2,set3 from MULTIFACULTYSUBJECTTAGGING  where fstid='"+mImMergeSec+"' and FACULTYTYPE='"+mTyp+"' and EMPLOYEEID='"+mFac+"'";// and COMPANYCODE='"+mcmp+"' ";
									//out.println(qry123);
									rssession=db.getRowset(qry123);	
									if(rssession.next())
									{
										mFacv=mFacv+"!!!"+rssession.getString("NOFHRS");
										//out.println(mFacv);
										viewList.add(mFacv);
									}
									else
									{
									String qry1234="";
									qry1234="select NOFHRS,set1,set2,set3 from Temp#pr#loaddistribution  where  FACULTYTYPE='"+mTyp+"' and EMPLOYEEID='"+mFac+"' and COMPANYCODE='"+mcmp+"' and LTP ='"+mLTP+"' and SECTIONBRANCH='"+session.getAttribute("secbranch")+"' and SUBSECTIONCODE='"+session.getAttribute("subsecsess")+"'";
									//out.println(qry1234);
									rssession1=db.getRowset(qry1234);	
									if(rssession1.next())
									{
										mFacv=mFacv+"!!!"+rssession.getString("NOFHRS");
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
					<td align="center"><b><font color=white>Faculty Name</b></font></td>
					<td align="center"><b><font color=white>FacultySet</b></font></td>
					<!-- <td align="center"><b><font color=white>Class in a week</b></font></td>	 -->
 				<tr>				
				<%
				//out.println(viewList.size());
				for(h=0;h<viewList.size();h++)
				{													
					String aa=(String)viewList.get(h);
					//out.println(aa);
					String bb = aa.substring(aa.indexOf("@@@")+3,aa.indexOf("!!!"));
					
					bb=bb.replaceAll(":"," ");
					String cc=aa.substring(aa.indexOf("!!!")+3,aa.length());
					String dd=aa.substring(0,aa.indexOf("***"));
					sessionlist.add(aa);
					%>
						<tr>
						<td align="center"><input type="text" name="factName<%=h%>" value="<%=bb%>" readonly size="35"></td>
						<%
						%>
						<td align="center"><input type="hidden" name="hr<%=h%>" size=2 value=<%=cc%>  maxlength='1'><SELECT NAME="set<%=h%>">
						<%
							String qry123="select  NOFHRS,nvl(set1,'0')set1,nvl(set2,'0')set2,nvl(set3,'0')set3,FACULTYSET,CLASSINAWEEK from MULTIFACULTYSUBJECTTAGGING  where fstid='"+mImMergeSec+"' and EMPLOYEEID='"+dd+"'";// and COMPANYCODE='"+mcmp+"' ";
									//out.println(qry123);
									rssession=db.getRowset(qry123);	
									if(rssession.next())
									{

										String ia1="";
										String ia2="";
										String ia3="";
										if(rssession.getString("FACULTYSET").equals("SET-1"))
										{
											ia1="Selected";
										}
										else if(rssession.getString("FACULTYSET").equals("SET-2"))
										{
											ia2="Selected";
										}
										else if(rssession.getString("FACULTYSET").equals("SET-3"))
										{
											ia3="Selected";
										}

										if(!rssession.getString("set1").equals("0"))
										{
										%><OPTION VALUE="SET-1~~~<%=rssession.getString("CLASSINAWEEK")%>" <%=ia1%>>SET 1<%
										}
										if(!rssession.getString("set2").equals("0"))
										{

											%><OPTION VALUE="SET-2~~~<%=rssession.getString("CLASSINAWEEK")%>"  <%=ia2%>>SET 2<%
										}if(!rssession.getString("set3").equals("0"))
										{
											%><OPTION VALUE="SET-3~~~<%=rssession.getString("CLASSINAWEEK")%>"  <%=ia3%>>SET 3<%
										}
											%><INPUT TYPE="hidden" NAME="setText1" value=<%=rssession.getString("set1")%>>
						<INPUT TYPE="hidden" NAME="setText2" value=<%=rssession.getString("set2")%>>
						<INPUT TYPE="hidden" NAME="setText3" value=<%=rssession.getString("set3")%>><%

									}
									else
									{
									String qry1234="";
									qry1234="select NOFHRS,nvl(set1,'0')set1,nvl(set2,'0')set2,nvl(set3,'0')set3,FACULTYSET,CLASSINAWEEK from Temp#pr#loaddistribution  where  EMPLOYEEID='"+dd+"' and LTP ='"+mLTP+"' and SECTIONBRANCH='"+session.getAttribute("secbranch")+"' and SUBSECTIONCODE='"+session.getAttribute("subsecsess")+"'";
									//out.println(qry1234);
									rssession1=db.getRowset(qry1234);	
									if(rssession1.next())
									{
										
										String ia1="";
										String ia2="";
										String ia3="";
										if(rssession.getString("FACULTYSET").equals("SET-1"))
										{
											ia1="Selected";
										}
										else if(rssession.getString("FACULTYSET").equals("SET-2"))
										{
											ia2="Selected";
										}
										else if(rssession.getString("FACULTYSET").equals("SET-3"))
										{
											ia3="Selected";
										}

										if(!rssession.getString("set1").equals("0"))
										{
										%><OPTION VALUE="SET-1~~~<%=rssession.getString("CLASSINAWEEK")%>" <%=ia1%>>SET 1<%
										}
										if(!rssession.getString("set2").equals("0"))
										{

											%><OPTION VALUE="SET-2~~~<%=rssession.getString("CLASSINAWEEK")%>"  <%=ia2%>>SET 2<%
										}if(!rssession.getString("set3").equals("0"))
										{
											%><OPTION VALUE="SET-3~~~<%=rssession.getString("CLASSINAWEEK")%>"  <%=ia3%>>SET 3<%
										}
										%><INPUT TYPE="hidden" NAME="setText1" value=<%=rssession.getString("set1")%>>
						<INPUT TYPE="hidden" NAME="setText2" value=<%=rssession.getString("set2")%>>
						<INPUT TYPE="hidden" NAME="setText3" value=<%=rssession.getString("set3")%>><%
										
										
									}
									}
					
					
					%>
						
						</select>
						
						
						
						</td>
 						<!-- <td>&nbsp;</td> -->
						<tr>
						
					<%
				}
					%> <INPUT TYPE="hidden" NAME="setText1" value=<%=request.getParameter("setText1")%>>
						<INPUT TYPE="hidden" NAME="setText2" value=<%=request.getParameter("setText2")%>>
						<INPUT TYPE="hidden" NAME="setText3" value=<%=request.getParameter("setText3")%>>
						<INPUT TYPE="hidden" NAME="sses" value=<%=request.getParameter("mSubSection")%>><%
				session.setAttribute("MultiFaculti",null);
				session.setAttribute("MultiFaculti",sessionlist);
				%>
				<input type="hidden" name="counter" value="<%=h%>"/>
				<tr>
					<td align="center" colspan="3"><hr></td>
				</tr>
				<tr>
					<td align="center" colspan="3"><input type="submit" name="submit" value="Save">&nbsp;&nbsp;
					<%if(h==1){%>
					
					<input type="submit" name="delete" value="Delete"> 
					
					<%}%></td>
				</tr>
				</table>
				</form>
				<%
				}
			}
			if(request.getParameter("y")!=null)
			{
				
				if(request.getParameter("submit")!=null)
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
						String setvalue="";
						String classValue="";
						
						if(request.getParameter("hr"+i)==null)
							ii="0";
						else
							ii=request.getParameter("hr"+i);
						if(request.getParameter("set"+i)==null)
							setvalue="";
						else
							setvalue=request.getParameter("set"+i);
/*						if(request.getParameter("classWeek"+i)==null)
							classValue="0";
						else
							classValue =request.getParameter("classWeek"+i);	*/				
						mMultiFaculty[i]=(futlist.get(i).toString())+"###"+ii+"```"+setvalue;
						//out.println("asdf"+(futlist.get(i).toString())+"###"+ii);
					}
					session.setAttribute("MultiFaculti",null);
					session.setAttribute("MultiFaculti",mMultiFaculty);
					String ltp=request.getParameter("LTP");
					String subid1=request.getParameter("SUBJID");
					String secbran=request.getParameter("SECTIONBRANCH");
					String subsecbran="";
					int ito=0;
					if(request.getParameter("sses")==null)
					{						subsecbran="";}
					else
					{subsecbran=request.getParameter("sses");
						ito=1;
					}
					//out.println(subsecbran);
					if(ito==0)
					{
						subsecbran=request.getParameter("SubSection");
					}
					//	out.println("<BR>12+"+subsecbran);
					
/*					out.println(subsecbran+"]]"+request.getParameter("sses")+"<br>");
					if(subsecbran==null)
					{
							out.println(subsecbran+"]]"+request.getParameter("sses")+"<br>");
						subsecbran=request.getParameter("sses");
					}*/
					
					
					String [] multiFaculty=(String [])session.getAttribute("MultiFaculti");
					//out.println("addddd"+i);
					qry="delete from TEMP#PR#LOADDISTRIBUTION where LTP='"+ltp+"'  and SECTIONBRANCH ='"+session.getAttribute("secbranch")+"' and SUBJECTID='"+subid1+"' and USERID='"+mChkMemID+"' and SUBSECTIONCODE='"+session.getAttribute("subsecsess")+"' and programcode='"+request.getParameter("mProg")+"' and academicyear='"+request.getParameter("mAcad")+"'";
					int n123=db.insertRow(qry);
					//out.println(n123);
					for(int j=0;j<i;j++)
					{
						//out.println(i);
						String aa=multiFaculty[j];
						//out.println(aa);
						String fid=aa.substring(0,aa.indexOf("***"));
						String ftype=aa.substring(aa.indexOf("***")+3,aa.indexOf("///"));
						String cmp=aa.substring(aa.indexOf("///")+3,aa.indexOf("@@@"));
						String hr=aa.substring(aa.indexOf("###")+3,aa.indexOf("```"));
						String setsess=aa.substring(aa.indexOf("```")+3,aa.indexOf("~~~"));
						String classsess=aa.substring(aa.indexOf("~~~")+3,aa.length());
						String id=ltp+session.getAttribute("secbranch")+session.getAttribute("subsecsess");
						
						qry="INSERT INTO TEMP#PR#LOADDISTRIBUTION ( SESSIONID, USERID, SUBJECTID, SECTIONBRANCH, SUBSECTIONCODE, LTP,COMPANYCODE, FACULTYTYPE, EMPLOYEEID, NOFHRS, DATETIME,FACULTYSET, CLASSINAWEEK,SET1, SET2,SET3,academicyear,programcode) VALUES ( '"+id+"','"+mChkMemID+"' ,'"+subid1+"', '"+session.getAttribute("secbranch")+"','"+session.getAttribute("subsecsess")+"','"+ltp+"','"+cmp+"' , '"+ftype+"', '"+fid+"',"+hr+" ,sysdate ,'"+setsess+"','"+classsess+"','"+request.getParameter("setText1")+"','"+request.getParameter("setText2")+"','"+request.getParameter("setText3")+"','"+request.getParameter("mAcad")+"','"+request.getParameter("mProg")+"')";
						//out.println(qry);
						n=db.insertRow(qry);	
						
					}
					if(n>0)
					{
						out.println("<center><font size=3 color=green>Multi/Additional faculty added successfully...</font></center>");
						out.println("<center><input type='submit' name='submit' value='close' onclick='window.close();'</center>");
					}
				}
				//session.setAttribute("MultiFaculti",null);
				}
				catch(Exception e)
				{
					//System.out.println(e);
					out.println("<center><font size=3 color=green>Multi/Additional faculty added successfully...</font></center>");
							out.println("<center><input type='submit' name='submit' value='close' onclick='window.close();'</center>");
				}
			}
			else
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
					String subsecbran="";
					int ito=0;
					if(request.getParameter("sses")==null)
					{						subsecbran="";}
					else
					{subsecbran=request.getParameter("sses");
						ito=1;
					}
					//out.println(subsecbran);
					if(ito==0)
					{
						subsecbran=request.getParameter("SubSection");
					}String upfstid="";
					String [] multiFaculty=(String [])session.getAttribute("MultiFaculti");
					//out.println("addddd"+i);
					qry="delete from TEMP#PR#LOADDISTRIBUTION where LTP='"+ltp+"'  and SECTIONBRANCH ='"+session.getAttribute("secbranch")+"' and SUBJECTID='"+subid1+"' and USERID='"+mChkMemID+"' and SUBSECTIONCODE='"+session.getAttribute("subsecsess")+"'  and academicyear='"+request.getParameter("mAcad")+"' and programcode='"+request.getParameter("mProg")+"'";
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
						String id=ltp+session.getAttribute("secbranch")+session.getAttribute("subsecsess");
						
						/*qry="INSERT INTO TEMP#PR#LOADDISTRIBUTION ( SESSIONID, USERID, SUBJECTID, SECTIONBRANCH, SUBSECTIONCODE, LTP,COMPANYCODE, FACULTYTYPE, EMPLOYEEID, NOFHRS, DATETIME) VALUES ( '"+id+"','"+mChkMemID+"' ,'"+subid1+"', '"+secbran+"','"+subsecbran+"','"+ltp+"','"+cmp+"' , '"+ftype+"', '"+fid+"',"+hr+" ,sysdate )";*/
						//out.println(qry);
						qry="select fstid from PR#HODLOADDISTRIBUTION where institutecode='"+mInst+"' and examcode='"+request.getParameter("EXAM")+"' and SUBJECTID='"+subid1+"' and sectionbranch='"+session.getAttribute("secbranch")+"' and SUBSECTIONCODE='"+session.getAttribute("subsecsess")+"' and LTP='"+ltp+"' and semestertype='"+mSem+"' and academicyear='"+request.getParameter("mAcad")+"' and programcode= '"+request.getParameter("mProg")+"' order by fstid ";
						//out.print(qry);
						ResultSet rsf=db.getRowset(qry);
						if(rsf.next())
						{
							upfstid=rsf.getString("fstid");
						}
						


						qry=" delete from multifacultysubjecttagging where INSTITUTECODE='"+mInst+"' and COMPANYCODE='"+cmp+"' and   FACULTYTYPE='"+ftype+"' and  EMPLOYEEID='"+fid+"' and fstid='"+upfstid+"'";

						//out.println("<br>"+qry);
						n=db.insertRow(qry);	
						
					}
					if(n>0 && request.getParameter("classweek")!=null)
					{
						
						qry="update  PR#HODLOADDISTRIBUTION set NOOFCLASSINAWEEK ='"+request.getParameter("classweek")+"' where institutecode='"+mInst+"' and examcode='"+request.getParameter("EXAM")+"' and SUBJECTID='"+subid1+"' and sectionbranch='"+session.getAttribute("secbranch")+"' and SUBSECTIONCODE='"+session.getAttribute("subsecsess")+"' and LTP='"+ltp+"' and semestertype='"+mSem+"' and fstid='"+upfstid+"' and academicyear='"+request.getParameter("mAcad")+"'";
						n=db.insertRow(qry);
						
						//out.println("<br>"+qry);
						out.println("<center><font size=3 color=green>Multi/Additional faculty discarded successfully...</font></center>");
						out.println("<center><input type='submit' name='submit' value='close' onclick='window.close();'</center>");
					}
					else
					{
						out.println("<center><font size=3 color=red>No record found....</font></center>");
						out.println("<center><input type='submit' name='submit' value='close' onclick='window.close();'</center>");
					}



				}
			}
			catch(Exception e)
				{
					//out.println(e);
					out.println("<center><font size=3 color=red>Error while deleting ....</font></center>");
							out.println("<center><input type='submit' name='submit' value='close' onclick='window.close();'</center>");
				}
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