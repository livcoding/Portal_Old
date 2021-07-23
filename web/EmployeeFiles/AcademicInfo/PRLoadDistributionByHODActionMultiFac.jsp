<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
ResultSet rs=null,rs1=null,rs2=null,rs3=null,rs5=null,rsc=null,rsl=null,rsm=null,rssession=null,rs12=null,rssession1=null,rse=null;
String mMemberID="",mDMemberID="",qry1="",moldMerge="",moldMerge1="",qrym="";
String mMemberName="",mSectBranch="";
String mMemberType="",mDMemberType="",mStudcnt="",mDis="",mvalue="";
String mHead="",moldemp="",moldemp1="",QryEleCode="";
String mDMemberCode="",mMemberCode="",mFac="",mfac="",mElective="",mImMergeSec="";
String mInst="",mSection="",mSubsection="",mBasket="",mOfac="",mNameLMR="";
String qry="",Type="",mltp="",QrySemType="",mEmpid="",memp="",mName1="",mName2="",mNameLML="";
String mName3="",mName4="",mName5="",mName6="",mName7="",mName8="",mName9="",mName10="";
String mEle="", SC="",qrye="",sc="", id="";
String mEmpIdTemp="";
String as1="",as2="",as3="";
int mL=0,mT=0,mP=0,mlt=0;
int mL1=0, mT1=0, mP1=0, mlt1=0;
int mFlag2=0,mFlag1=0,mFlag11=0;
int ctr=0, msno=0;
String mType="",mLTP="",mSubj="",QryDept="",mDept2="",mSname="",QryExam="",mSeccount="",mPrCode="";
double mAssigned=0,mMin=0,mMax=0,mexcludeassign=0;
double mAssignedload=0,mMinload=0,mMaxload=0;
String mEmpidv="",mFacv="",mTyp="",mEmpTyp="",mcmp="",mEcmp="",mDuration="",mClass="",mSendhod="",mComp="";
String QrySubjID="", mProjSubj="";
String values="",mMult="";
String [] valueslist=new String[1000];
String [] mMultiFaculty=new String [1000];
String mClDura="", mTotClass="";
ArrayList list= new ArrayList();

//session.setAttribute("MultiCumAddlFaculty",null);

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
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
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

if(request.getParameter("Subjid")==null)
	QrySubjID="";
else
	QrySubjID=request.getParameter("Subjid");
if(request.getParameter("LTP")==null)
	mLTP="";
else
	mLTP=request.getParameter("LTP");			

//out.print("SUBJECT ID - "+QrySubjID+" LTP - "+mLTP);

%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [HOD Advance Load Distribution] </TITLE>
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
			alert("Total Class per Week should not be less or more than "+ total);
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
	{
		OLTEncryption enc=new OLTEncryption();
		mDMemberID=enc.decode(mMemberID);
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);
		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress=session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk=null;
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
			%>
			<form name="frmfirst" method="post" action="PRLoadDistributionByHODActionMultiFac.jsp">
			<INPUT TYPE=HIDDEN NAME="x" ID="x" VALUES="">
			<%

			if(request.getParameter("ExamCode")==null)
				QryExam="";
			else
				QryExam=request.getParameter("ExamCode");
			if(request.getParameter("Sub")==null)
				mSubj="";
			else
				mSubj=request.getParameter("Sub").toString().trim();
			if (request.getParameter("PROJSUBJ")==null)
				mProjSubj="N";
			else
				mProjSubj=request.getParameter("PROJSUBJ").toString().trim();
			if(request.getParameter("Basket")==null)
				mBasket="";
			else
				mBasket=request.getParameter("Basket");
			if(request.getParameter("LTP")==null)
				mLTP="";
			else
				mLTP=request.getParameter("LTP");			
			if(request.getParameter("Dept")==null)
				QryDept="";
			else
				QryDept=request.getParameter("Dept");
			if(request.getParameter("Subjid")==null)
				QrySubjID="";
			else
				QrySubjID=request.getParameter("Subjid");
			if(request.getParameter("Elecode")==null)
				QryEleCode="";
			else
				QryEleCode=request.getParameter("Elecode");
			if(request.getParameter("ELE")==null)
				mEle="";
			else
				mEle=request.getParameter("ELE");
			if(request.getParameter("TYPE")==null)
				mType="";
			else
				mType=request.getParameter("TYPE");
			if(request.getParameter("SEM")==null)
				QrySemType="";
			else
				QrySemType=request.getParameter("SEM");
			if(request.getParameter("Dura")==null)
				mlt1=0;
			else
				mlt1=Integer.parseInt(request.getParameter("Dura"));
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

			//out.print("SUBJECT ID - "+QrySubjID);
			if(request.getParameter("x")==null)
			{
				session.setAttribute("MultiFaculti",null);
				session.setAttribute("MultiCumAddlFaculty",null);
			}
/*
			session.setAttribute("MultiFaculti",null);
			session.setAttribute("MultiCumAddlFaculty",null);

			out.print(session.getAttribute("MultiFaculti"));
			%><br><%
			out.print(session.getAttribute("MultiCumAddlFaculty"));
*/
/*
			int abc=0;
			qry="delete from TEMP#PR#LOADDISTRIBUTION where COMPANYCODE='"+mComp+"' AND SUBJECTID='"+QrySubjID+"' AND LTP='"+mLTP+"'";
			abc=db.update(qry);
			//out.print(qry);

			qry="delete from PR#HODLOADDISTRIBUTION where INSTITUTECODE='"+mInst+"' AND COMPANYCODE='"+mComp+"' AND EXAMCODE='"+QryExam+"' AND SEMESTERTYPE='"+QrySemType+"' AND SUBJECTID='"+QrySubjID+"' AND LTP='"+mLTP+"'";
			abc=db.update(qry);
			//out.print(qry);

			qry="delete from MULTIFACULTYSUBJECTTAGGING where INSTITUTECODE='"+mInst+"' AND COMPANYCODE='"+mComp+"' AND FSTID IN (SELECT FSTID FROM FACULTYSUBJECTTAGGING WHERE EXAMCODE='"+QryExam+"' AND SEMESTERTYPE='"+QrySemType+"' AND SUBJECTID='"+QrySubjID+"' AND LTP='"+mLTP+"')";
			abc=db.update(qry);
			//out.print(qry);
*/

			qry="select subject from subjectmaster where INSTITUTECODE='"+mInst+"' AND SUBJECTID='"+QrySubjID+"' ";
			rs=db.getRowset(qry);
			if(rs.next())
				mSname=rs.getString(1);		
			mSname=gb.toTtitleCase(mSname);

			if(mType.equals("C"))
				Type="Core";
			else if(mType.equals("E"))
				Type="Elective";
			else
				Type="Free Elective";

			if(mLTP.equals("L"))
				mltp="Lecture";
			else if(mLTP.equals("T"))
				mltp="Tutorial";
			else if(mLTP.equals("P"))
				mltp="Practical";
			else
				mltp="Project";

			%>
			<input type=hidden name="Subjid"		value=<%=QrySubjID%>>
			<input type=hidden name="Sub"			value=<%=mSubj%>>
			<input type=hidden name="PROJSUBJ" 		value=<%=mProjSubj%>>
			<input type=hidden name="Elecode"		value=<%=QryEleCode%>>
			<input type=hidden name="Basket"		value=<%=mBasket%>>
			<input type=hidden name="PRCODE"		value=<%=request.getParameter("PRCODE")%>>
			<input type=hidden name="radio1"		value=<%=request.getParameter("radio1")%>>
			<input type=hidden name="ELE"			value=<%=mEle%>>
			<input type=hidden name="SUBNAME"		value=<%=request.getParameter("SUBNAME")%>>
			<input type=hidden name="ExamCode"		value=<%=QryExam%>>
			<input type=hidden name="TYPE"		value=<%=mType%>>
			<input type=hidden name="Dept"		value=<%=QryDept%>>
			<input type=hidden name="LTP"			value=<%=mLTP%>>
			<input type=hidden name="SEM"			value=<%=QrySemType%>>
			<input type=hidden name="SECTIONBRANCH"	value=<%=request.getParameter("section")%>>
			<input type=hidden name="SubSection"	value=<%=request.getParameter("mSubSection")%>>
			<input type=hidden name="section"		value=<%=mSectBranch%>>
			<input type=hidden name="x"			value="">
			<input type=hidden name="classweek12"	value="<%=classweek1%>">
			<input type=hidden name="classweek"		value="<%=request.getParameter("classweek")%>">

			<table id=id1 width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
			<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Assign/Distribute Load to Multiple/Additional Faculty</B></font></TD></tr>
			</font></td></tr>
			</TABLE>
			<table id=idd2 cellpadding=1 cellspacing=0 width="100%" align=center rules=rows  border=3>
			<tr><td align=center colspan=3>
			<%
			String mProject="";
			if(mProjSubj.equals("Y"))
				mProject=" <FONT COLOR=NAVY><B>[Project Subject]</B></FONT>";
			%>
			<font face=arial color=navy size=2><b>HOD Load Distribution of Subject : </b>&nbsp;<font face=arial color=navy size=2><%=mSname%></font>&nbsp;(<%=mSubj%>) - <%=Type%> &nbsp; &nbsp; &nbsp; &nbsp;<font face=arial color=black size=2><b>LTP : </b></Font>&nbsp;<%=mltp%></Font> <%=mProject%> &nbsp; &nbsp;
			</td></tr>

			<tr><td align=left nowrap>&nbsp; &nbsp; 
			<font face=arial color=black size=2><b>Running Department : </b></font><select name=DEPT id=DEPT style="background-color:#C6D6FD; color:black; font-weight:normal">
			<%
			String qryu="select Department from departmentmaster where departmentcode='"+QryDept+"' and nvl(deactive,'N')='N'";
			ResultSet rssss= db.getRowset(qryu);
			if(rssss.next())
				mDept2=rssss.getString("Department");
			%>
			<option selected name="RunningDept" value='<%=QryDept%>'><%=mDept2%> (<%=QryDept%>)</option>
			</select>

			&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
			<font face=arial color=black size=2><b>Exam Code : </b></Font><select name=EXAM id=EXAM style="background-color:#C6D6FD; color:black; font-weight:normal">
			<option selected value='<%=QryExam%>'><%=QryExam%></option>
			</select>

			&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
			<font face=arial color=black size=2><b>Semester Type : </b></Font><select name=SEM id=SEM style="background-color:#C6D6FD; color:black; font-weight:normal">
			<option selected value='<%=QrySemType%>'><%=QrySemType%></option>
			</select>
			</td></tr>

			<tr><td align=left nowrap>&nbsp; &nbsp; 
			<font face=arial color=black size=2><b>Class Duration : </b></Font>
			<input readonly type=text name=Dura id=Dura value='<%=mlt1%>' style="background-color:#C6D6FD; color:black; font-weight:normal; text-align:right" maxlength=3 size=1>hrs
			 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
			 <font face=arial color=black size=2><b>No. of Class in a Week : </b><input readonly type=text name=Class1 id=Class1 value='<%=classweek1%>' style="background-color:#C6D6FD; color:black; font-weight:normal; text-align:right" maxlength=3 size=1>
			 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
			</td><tr>
			<table cellspacing=0 align=center border=2 rules=groups style="WIDTH: 400px">
			<tr bgcolor="#C6D6FD">
			<td align=middle><font face=arial size=4 color=black>Multiple Faculty Choice</font></td>
			<tr>
			<%
			qry="select fstid from PR#HODLOADDISTRIBUTION where institutecode='"+mInst+"' and examcode='"+QryExam+"' and SUBJECTID='"+QrySubjID+"' and sectionbranch='"+session.getAttribute("secbranch")+"' and SUBSECTIONCODE='"+session.getAttribute("subsecsess")+"' and LTP='"+mLTP+"' and semestertype='"+QrySemType+"' order by fstid ";
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
			%>
			<input Type="hidden" value="<%=mImMergeSec%>" name="fstid">
			<%
			int i=0;
			qry="select a.EMPLOYEEID,a.FACULTYTYPE,a.NOFHRS from Temp#pr#loaddistribution a where  SUBJECTID='"+QrySubjID+"' and LTP='"+mLTP+"' and SECTIONBRANCH='"+session.getAttribute("secbranch")+"' and SUBSECTIONCODE='"+session.getAttribute("subsecsess")+"'";
			//out.print(qry);
			rs=db.getRowset(qry);
			if(rs.next())
			{ 
				qry="select EMPLOYEEID,nvl(set1,'0')set1,nvl(set2,'0')set2,nvl(set3,'0')set3  from Temp#pr#loaddistribution where SUBJECTID='"+QrySubjID+"' and LTP='"+mLTP+"' and SECTIONBRANCH='"+session.getAttribute("secbranch")+"' and SUBSECTIONCODE='"+session.getAttribute("subsecsess")+"'";
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
					//out.println(as2);
				}
			}
			if(request.getParameter("x")!=null)
			{
				if(request.getParameterValues("MultiCumAddlFaculty")==null)
					values="";
				else
					valueslist=request.getParameterValues("MultiCumAddlFaculty");
			}
			qry="select FACULTYID from PR#HODLOADDISTRIBUTION where fstid='"+mImMergeSec+"'";
			//out.println(qry);
			rs=db.getRowset(qry);	
			while(rs.next())
			{
				mEmpIdTemp=rs.getString("FACULTYID");
			}
			//out.println(mEmpIdTemp);
			%>
			<input type="hidden" name="empId" value="<%=mEmpIdTemp%>">
			<%
			//out.println(mInst+"<br>"+mComp+"<br>"+mMemberID+"<br>"+mMemberType+"<br>"+mMemberCode+"<br>"+mMemberName);
			//out.println(QryExam+"<br>"+mSubj+"<br>"+mBasket+"<br>"+mLTP+"<br>"+QryDept);
			qry="select DISTINCT A.Employeeid facultyid,A.Employeename employeename,A.COMPANYCODE companycode,";
			qry=qry+" A.EMPLOYEETYPE facultytype,to_char(WebKiosk.getAssignedTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+QryExam+"'))assignedload, ";
			qry=qry+" to_char(WebKiosk.getAssignedTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid,A.EMPLOYEETYPE,'"+QryExam+"','"+mSubj+"','"+mBasket+"','"+mLTP+"'))assignedload11, ";
			qry=qry+" to_char(WebKiosk.getMinTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+QryExam+"')) minload,to_char(WebKiosk.getMaxTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE ,'"+QryExam+"'))maxload  from V#STAFF A  where A.departmentcode='"+QryDept+"' AND A.COMPANYCODE='"+mComp+"'  and nvl(a.deactive,'N')='N'order by employeename ";
			//out.println(qry);
			rs=db.getRowset(qry);
			int flag=0;
			%>		
			<tr>
			<td>
			<select tabindex="0" style="WIDTH: 400px; HEIGHT: 200px" multiple name="MultiCumAddlFaculty" >
			<!--<OPTION  Value='NONE'>Select a Faculty</option>-->
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
								%>
								<OPTION Value=<%=mFacv%>><%=rs.getString("employeename")%></option>
								<%
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
								%>
								<OPTION selected Value=<%=mFacv%>><%=rs.getString("employeename")%></option>
								<%
								flag=1;													
							}
						}
					}
					if(flag==0)
					{
						%><OPTION Value=<%=mFacv%>><%=rs.getString("employeename")%></option><%
					}
					flag=0;
				}
			}
			%>
			</select>
			</td>	
			</tr>
			<tr><td align="center"><td></tr>
			<tr><td align="center"><font size=3 face=arial color=navy>* Select multiple Faculty using Ctrl+MouseClick</font><td></tr>
			<tr><td align="center"><hr><td></tr>
			<tr><td align="center">
			<font size=3 face=arial color=navy>* Enter No. of Class per Week :- <%=request.getParameter("classweek")%></font><td></tr>
			<tr><td align="center"><td></tr>				
			<TR>
			<td align='center'>&nbsp;&nbsp;<B><Font face=arial>Set 1</font></B>&nbsp;&nbsp;
			<%
			if(request.getParameter("setText1")!=null && !request.getParameter("setText1").equals(""))
			{
				%>
				<INPUT TYPE="text" id="setText1" NAME="setText1" size=2 maxlength='2' value=<%=request.getParameter("setText1")%>>&nbsp;&nbsp;
				<%
			}
			else
			{
				%><INPUT TYPE="text" id="setText1" NAME="setText1" size=2 maxlength='2' value=<%=as1%>>&nbsp;&nbsp;<%
			}
			%><B><Font face=arial>Set 2</font></B>&nbsp;&nbsp;<%
			if(request.getParameter("setText2")!=null && !request.getParameter("setText2").equals(""))
			{
				%>
				<INPUT TYPE="text" NAME="setText2" size=2 maxlength='2' value=<%=request.getParameter("setText2")%>>&nbsp;&nbsp;
				<%
			}
			else
			{
					%><INPUT TYPE="text" NAME="setText2" size=2 maxlength='2' value=<%=as2%>>&nbsp;&nbsp;<%
			}
			%><B><Font face=arial>Set 3</font></B>&nbsp;&nbsp;<%
			if(request.getParameter("setText3")!=null && !request.getParameter("setText3").equals(""))
			{
				%>
				<INPUT TYPE="text" NAME="setText3" size=2 maxlength='2' value=<%=request.getParameter("setText3")%>>&nbsp;</td>
				<%
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
			int abc=0;
			qry="delete from TEMP#PR#LOADDISTRIBUTION where COMPANYCODE='"+mComp+"' AND SUBJECTID='"+QrySubjID+"' AND LTP='"+mLTP+"'";
			//abc=db.update(qry);
			//out.print(qry);

			qry="delete from PR#HODLOADDISTRIBUTION where INSTITUTECODE='"+mInst+"' AND COMPANYCODE='"+mComp+"' AND EXAMCODE='"+QryExam+"' AND SEMESTERTYPE='"+QrySemType+"' AND SUBJECTID='"+QrySubjID+"' AND LTP='"+mLTP+"'";
			//abc=db.update(qry);
			//out.print(qry);

			qry="delete from MULTIFACULTYSUBJECTTAGGING where INSTITUTECODE='"+mInst+"' AND COMPANYCODE='"+mComp+"' AND FSTID IN (SELECT FSTID FROM FACULTYSUBJECTTAGGING WHERE EXAMCODE='"+QryExam+"' AND SEMESTERTYPE='"+QrySemType+"' AND SUBJECTID='"+QrySubjID+"' AND LTP='"+mLTP+"')";
			//abc=db.update(qry);
			//out.print(qry);
				%>
				<form name="frmsecond"  method="post" action="PRLoadDistributionByHODActionMultiFac.jsp" >
				<INPUT TYPE=HIDDEN NAME="x" ID="x" 		VALUES="">
				<INPUT TYPE=HIDDEN NAME="y" ID="y" 		VALUES="">
				<input type=hidden name="PROJSUBJ" 		value=<%=mProjSubj%>>
				<input type=hidden name="Subjid"		value=<%=request.getParameter("Subjid")%>>
				<input type=hidden name="SUBJ"		value=<%=request.getParameter("Sub")%>>
				<input type=hidden name="ELECTIVECODE"	value=<%=request.getParameter("Elecode")%>>
				<input type=hidden name="BASKET"		value=<%=request.getParameter("Basket")%>>
				<input type=hidden name="PRCODE"		value=<%=request.getParameter("PRCODE")%>>
				<input type=hidden name="radio1"		value=<%=request.getParameter("radio1")%>>
				<input type=hidden name="ELE"			value=<%=request.getParameter("ELE")%>>	
				<input type=hidden name="SUBNAME"		value=<%=request.getParameter("SUBNAME")%>>
				<input type=hidden name="EXAM"		value=<%=request.getParameter("ExamCode")%>>
				<input type=hidden name="TYPE"		value=<%=request.getParameter("TYPE")%>>
				<input type=hidden name="DEPT"		value=<%=request.getParameter("Dept")%>>
				<input type=hidden name="LTP"			value=<%=request.getParameter("LTP")%>>
				<input type=hidden name="SEM"			value=<%=request.getParameter("SEM")%>>
				<input type=hidden name="SECTIONBRANCH"	value=<%=request.getParameter("SECTIONBRANCH")%>>
				<input type=hidden name="SubSection"	value=<%=request.getParameter("SubSection")%>>
				<input type=hidden name="classweek"		value="<%=request.getParameter("classweek")%>">
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
				if(request.getParameterValues("MultiCumAddlFaculty")==null)
					values="";
				else
					valueslist=request.getParameterValues("MultiCumAddlFaculty");	

				if(valueslist[0]!=null)
				{
				%>
				<table cellspacing=0 cellpadding=0 align=center border=2 rules='groups'>
				<tr bgcolor="#C6D6FD">
				<td align="center"><font face=arial size=3 color=black><B>Faculty Name<B></font></td>
				<td align="center"><font face=arial size=3 color=black><B>Faculty Set<B></font></td>
				<!--<td align="center"><font face=arial size=3 color=black><B>Class per week<B></font></td>-->
 				<tr>				
				<%
				for(h=0;h<valueslist.length;h++)
				{													
					String aa= valueslist[h];
					String bb= aa.substring(aa.indexOf("@@@")+3,aa.length());
					String cc=aa.substring(0,aa.indexOf("***"));
					bb=bb.replaceAll(":"," ");
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
				session.setAttribute("MultiCumAddlFaculty",null);
				session.setAttribute("MultiCumAddlFaculty",sessionlist);
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
			else if(request.getParameter("y")!=null)
			{
				//out.println(list.size());
				if(list.size()>0)
				{
					%>
					<form name="frmthird" method="post" action="PRLoadDistributionByHODActionMultiFac.jsp" >
					<INPUT TYPE=HIDDEN NAME="x" ID="x" 		VALUES="">
					<INPUT TYPE=HIDDEN NAME="y" ID="y" 		VALUES="">
					<INPUT TYPE=HIDDEN NAME="z" ID="z" 		VALUES="">
					<input type=hidden name="PROJSUBJ" 		value=<%=mProjSubj%>>
					<input type=hidden name="Subjid"		value=<%=request.getParameter("Subjid")%>>
					<input type=hidden name="SUBJ"		value=<%=request.getParameter("Sub")%>>
					<input type=hidden name="ELECTIVECODE"	value=<%=request.getParameter("Elecode")%>>
					<input type=hidden name="BASKET"		value=<%=request.getParameter("Basket")%>>
					<input type=hidden name="PRCODE"		value=<%=request.getParameter("PRCODE")%>>
					<input type=hidden name="radio1"		value=<%=request.getParameter("radio1")%>>
					<input type=hidden name="ELE"			value=<%=request.getParameter("ELE")%>>	
					<input type=hidden name="SUBNAME"		value=<%=request.getParameter("SUBNAME")%>>
					<input type=hidden name="EXAM"		value=<%=request.getParameter("ExamCode")%>>
					<input type=hidden name="TYPE"		value=<%=request.getParameter("TYPE")%>>
					<input type=hidden name="DEPT"		value=<%=request.getParameter("Dept")%>>
					<input type=hidden name="LTP"			value=<%=request.getParameter("LTP")%>>
					<input type=hidden name="SEM"			value=<%=request.getParameter("SEM")%>>
					<input type=hidden name="classweek"		value="<%=request.getParameter("classweek")%>">
					<input type=hidden name="Dura"		value="mlt1%>">
					<input type=hidden name="SECTIONBRANCH"	value=<%=mSectBranch%>>
					<input type=hidden name="SubSection"	value=<%=request.getParameter("SubSection")%>>
					
					<%
					mEmpIdTemp=request.getParameter("empId");
					ArrayList viewList=new ArrayList();	
					qry="select A.Employeeid facultyid,A.Employeename employeename,A.COMPANYCODE companycode,";
					qry=qry+" A.EMPLOYEETYPE facultytype,to_char(WebKiosk.getAssignedTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+QryExam+"'))assignedload, ";
					qry=qry+" to_char(WebKiosk.getAssignedTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid,A.EMPLOYEETYPE,'"+QryExam+"','"+mSubj+"','"+mBasket+"','"+mLTP+"'))assignedload11, ";
					qry=qry+" to_char(WebKiosk.getMinTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+QryExam+"')) minload,to_char(WebKiosk.getMaxTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE ,'"+QryExam+"'))maxload  from V#STAFF A  where A.departmentcode='"+QryDept+"' AND A.COMPANYCODE='"+mComp+"' and nvl(a.deactive,'N')='N' order by employeename ";
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
									qry1234="select NOFHRS,set1,set2,set3 from Temp#pr#loaddistribution  where  FACULTYTYPE='"+mTyp+"' and EMPLOYEEID='"+mFac+"' and COMPANYCODE='"+mcmp+"' and LTP='"+mLTP+"' and SECTIONBRANCH='"+session.getAttribute("secbranch")+"' and SUBSECTIONCODE='"+session.getAttribute("subsecsess")+"'";
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
					<tr bgcolor="#C6D6FD">
					<td align="center"><b><font color=black>Faculty Name</b></font></td>
					<td align="center"><b><font color=black>FacultySet</b></font></td>
					<!-- <td align="center"><b><font color=black>Class in a week</b></font></td>	 -->
 					<tr>				
					<%
					//out.println(viewList.size());
					for(h=0;h<viewList.size();h++)
					{													
						String aa=(String)viewList.get(h);
						//out.println(aa);
						String bb= aa.substring(aa.indexOf("@@@")+3,aa.indexOf("!!!"));
					
						bb=bb.replaceAll(":"," ");
						String cc=aa.substring(aa.indexOf("!!!")+3,aa.length());
						String dd=aa.substring(0,aa.indexOf("***"));
						sessionlist.add(aa);
						%>
						<tr>
						<td align="center"><input type="text" name="factName<%=h%>" value="<%=bb%>" readonly size="35"></td>
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
								%>
								<OPTION VALUE="SET-1~~~<%=rssession.getString("CLASSINAWEEK")%>" <%=ia1%>>SET 1
								<%
							}
							if(!rssession.getString("set2").equals("0"))
							{
								%>
								<OPTION VALUE="SET-2~~~<%=rssession.getString("CLASSINAWEEK")%>"  <%=ia2%>>SET 2
								<%
							}
							if(!rssession.getString("set3").equals("0"))
							{
								%>
								<OPTION VALUE="SET-3~~~<%=rssession.getString("CLASSINAWEEK")%>"  <%=ia3%>>SET 3
								<%
							}
							%>
							<INPUT TYPE="hidden" NAME="setText1" value=<%=rssession.getString("set1")%>>
							<INPUT TYPE="hidden" NAME="setText2" value=<%=rssession.getString("set2")%>>
							<INPUT TYPE="hidden" NAME="setText3" value=<%=rssession.getString("set3")%>>
							<%
						}
						else
						{
							String qry1234="";
							qry1234="select NOFHRS,nvl(set1,'0')set1,nvl(set2,'0')set2,nvl(set3,'0')set3,FACULTYSET,CLASSINAWEEK from Temp#pr#loaddistribution  where  EMPLOYEEID='"+dd+"' and LTP='"+mLTP+"' and SECTIONBRANCH='"+session.getAttribute("secbranch")+"' and SUBSECTIONCODE='"+session.getAttribute("subsecsess")+"'";
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
								}
								if(!rssession.getString("set3").equals("0"))
								{
									%><OPTION VALUE="SET-3~~~<%=rssession.getString("CLASSINAWEEK")%>"  <%=ia3%>>SET 3<%
								}
								%>
								<INPUT TYPE="hidden" NAME="setText1" value=<%=rssession.getString("set1")%>>
								<INPUT TYPE="hidden" NAME="setText2" value=<%=rssession.getString("set2")%>>
								<INPUT TYPE="hidden" NAME="setText3" value=<%=rssession.getString("set3")%>>
								<%
							}
						}
						%>
						</select>
						</td>
 						<!-- <td>&nbsp;</td> -->
						<tr>
						<%
					}
					%>
					<INPUT TYPE="hidden" NAME="setText1" value=<%=request.getParameter("setText1")%>>
					<INPUT TYPE="hidden" NAME="setText2" value=<%=request.getParameter("setText2")%>>
					<INPUT TYPE="hidden" NAME="setText3" value=<%=request.getParameter("setText3")%>>
					<INPUT TYPE="hidden" NAME="sses" value=<%=request.getParameter("mSubSection")%>>
					<%
					session.setAttribute("MultiCumAddlFaculty",null);
					session.setAttribute("MultiCumAddlFaculty",sessionlist);
					%>
					<input type="hidden" name="counter" value="<%=h%>"/>
					<tr>
					<td align="center" colspan="3"><hr></td>
					</tr>
					<tr>
					<td align="center" colspan="3"><input type="submit" name="submit" value="Save">&nbsp;&nbsp;
					<%
					if(h==1)
					{
						%>
						<input type="submit" name="delete" value="Delete"> 
						<%
					}
					%>
					</td>
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
					try
					{
						ArrayList futlist=new ArrayList();
						ArrayList futlistDummy=new ArrayList();
						if(session.getAttribute("MultiCumAddlFaculty")==null)
						{
							mMult="";
							session.setAttribute("MultiCumAddlFaculty",null);
						}
						else
						{
							futlist=(ArrayList)session.getAttribute("MultiCumAddlFaculty");
							//if(request.getParameter("counter")==null)
							//out.print(session.getAttribute("MultiCumAddlFaculty"));
							//out.print(futlist);%><br><%
							int i=0;
							int n=0, n1=0;
							String set1value="", set2value="", set3value="";
							for(i=0;i<futlist.size();i++)
							{
								//out.println("sss"+(futlist.get(i).toString())+request.getParameter("hr"+i));
								String ii="0";
								String setvalue="";
								String classValue="";

								if(request.getParameter("TYPE")==null)
									mType="";
								else
									mType=request.getParameter("TYPE");
						
								if(request.getParameter("EXAM")==null)
									QryExam="";
								else
									QryExam=request.getParameter("EXAM");
								if(request.getParameter("SEM")==null)
									QrySemType="";
								else
									QrySemType=request.getParameter("SEM");
								if(request.getParameter("DEPT")==null)
									QryDept="";
								else
									QryDept=request.getParameter("DEPT");

								if(request.getParameter("hr"+i)==null)
									ii="0";
								else
									ii=request.getParameter("hr"+i);
				
								if(request.getParameter("set"+i)==null)
									setvalue="";
								else
									setvalue=request.getParameter("set"+i);

								if(request.getParameter("setText1")==null)
									set1value="0";
								else
									set1value=request.getParameter("setText1");

								if(request.getParameter("setText2")==null)
									set2value="0";
								else
									set2value=request.getParameter("setText2");

								if(request.getParameter("setText3")==null)
									set3value="0";
								else
									set3value=request.getParameter("setText3");

								if(set1value.equals(""))
									set1value="0";
								if(set2value.equals(""))
									set2value="0";
								if(set3value.equals(""))
									set3value="0";

								mMultiFaculty[i]=(futlist.get(i).toString())+"###"+ii+"```"+setvalue+"((("+set1value+")))"+set2value+"???"+set3value+"<<<"+QrySubjID+">>>"+mLTP;
								//out.println("asdf"+(futlist.get(i).toString())+"###"+ii+"```"+setvalue+"<<<"+QrySubjID+">>>"+mLTP);
							}
							//out.print(mMultiFaculty.length);
							session.setAttribute("MultiCumAddlFaculty",null);
							session.setAttribute("MultiCumAddlFaculty",mMultiFaculty);
							//out.print(((String [])session.getAttribute("MultiCumAddlFaculty"))[0]);%><br><%
							//out.print(set1value+" "+set2value+" "+set3value);
							String [] multiFaculty=(String [])session.getAttribute("MultiCumAddlFaculty");
							%><Table align=center bgcolor=white border=2><%
							int inc=0;
							for(int j=0;j<i;j++)
							{
								inc++;
								if(inc==1)
								{
									%>
									<tr bgcolor="#C6D6FD">
									<td><font face=arial size=2><B>Subject<B></font></td>
									<td><font face=arial size=2><B>LTP<B></font></td>
									<td><font face=arial size=2><B>Faculty<B></font></td>
									<td><font face=arial size=2><B>Class Duration<B></font></td>
									<td><font face=arial size=2><B>SET Assigned</B></font></td>
									<td><font face=arial size=2><B>Total Class Assigned<BR>per Week</B></font></td>
									</tr>
									<%
								}
								//out.println(i);
								String aa=multiFaculty[j];
								String fid=aa.substring(0,aa.indexOf("***"));
								String ftype=aa.substring(aa.indexOf("***")+3,aa.indexOf("///"));
								String cmp=aa.substring(aa.indexOf("///")+3,aa.indexOf("@@@"));
								String hr=aa.substring(aa.indexOf("###")+3,aa.indexOf("```"));
								String setsess=aa.substring(aa.indexOf("```")+3,aa.indexOf("~~~"));
								String classsess=aa.substring(aa.indexOf("~~~")+3,aa.indexOf("((("));
								String set1val=aa.substring(aa.indexOf("(((")+3,aa.indexOf(")))"));
								String set2val=aa.substring(aa.indexOf(")))")+3,aa.indexOf("???"));
								String set3val=aa.substring(aa.indexOf("???")+3,aa.indexOf("<<<"));
								String SubjInSet=aa.substring(aa.indexOf("<<<")+3,aa.indexOf(">>>"));
								String LtpInSet=aa.substring(aa.indexOf(">>>")+3,aa.length());
								qry="select employeename ename from v#staff where CompanyCode='"+cmp+"' and employeeid='"+fid+"'";
								//out.print(qry);
								rs=db.getRowset(qry);
								rs.next();

								qry="select SubjectCode SCode from subjectmaster where Institutecode='"+mInst+"' and subjectid='"+SubjInSet+"'";
								rs1=db.getRowset(qry);
								rs1.next();

								%>
								<tr>
								<td align=center><font face=arial size=2 color=navy><%=rs1.getString("SCode")%></font></td>
								<td align=center><font face=arial size=2 color=navy><%=LtpInSet%></font></td>
								<td><font face=arial size=2 color=navy><%=rs.getString("ename")%></font></td>
								<td align=center><font face=arial size=2 color=navy><%=hr%> hour(s)</font></td>
								<td align=center><font face=arial size=2 color=navy><%=setsess%></font></td>
								<td align=center><font face=arial size=2 color=navy><%=classsess%> day(s)</font></td>
								</tr>
								<%
							}
							%></Table><%
							rs1=null;
							String mInc=inc+"";
							session.setAttribute("TotalInGlobalMultiFac",mInc);
							if(inc>0)
							{
								out.println("<center><font size=3 color=Green>Multiple/Additional faculty are selected successfully....</font></center>");
								out.println("<center><input type='submit' name='submit' value='close' onclick='window.close();'</center>");
							}
						}
						//session.setAttribute("MultiCumAddlFaculty",null);
					}
					catch(Exception e)
					{
						//System.out.println(e);
						//out.println("<center><font size=3 color=green>Multiple/Additional Faculty are selected successfully....</font></center>");
						//out.println("<center><input type='submit' name='submit' value='close' onclick='window.close();'</center>");
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