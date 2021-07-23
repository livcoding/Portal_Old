<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>

<HTML>
<head>
<TITLE>#### <%=mHead%> [ Backlog Student Merge with REgular Batch ] </TITLE>
<script type="text/javascript" src="../js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="../css/sortabletable.css" />


<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
<script>
function checkall(){
	var i=0,tot=parseInt(document.frm1.i.value);
	if(document.frm1.chk1.checked==true){
		for(i=2;i<=tot;i++){
			document.frm1["chk"+i].checked=true;
		}
	}else if(document.frm1.chk1.checked==false){
		for(i=2;i<=tot;i++){
			document.frm1["chk"+i].checked=false;
		}
	}
}
function singlecheck(){
	var i=0,flag=1,tot=parseInt(document.frm1.i.value);
	 	for(i=2;i<=tot;i++){
			if(document.frm1["chk"+i].checked==false)
				flag=0;
		}
	if(flag!=0)
		document.frm1.chk1.checked=true;
	else
		document.frm1.chk1.checked=false;
}
</script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<%
DBHandler db=new DBHandler();
Connection conn = null;
OLTEncryption enc=new OLTEncryption();
String dept="",subtype="";
String qry="",qry1="",qry2="",mWebEmail="",EmpIDType="",fstid="";
String elecCode="";
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
String mComp="", mInst="";
String mSem="";
String mExamCode="",mProg="",mBranch="",mName="",mLoginComp="";
String mEmployeeID="",mLTP="",mSubjectid="",mEmpname="";
String Studid="",acad="",progcode="",tagfor="",secbranc="",sem="",semtype="",subseccode="",basket="",mergfstid="",compcode="",facultyid="",facultytype="",subjectid="",subsection="";
String hacad="",hprogram="",hsecbranch="",hsem="",hbasket="",htagfor="",Studfstid="",mMergeEmployee="";
int mLclass=0,mTclass=0,mPclass=0,mLhr=0,mThr=0,mPhr=0,jj=0,mflag=0;
String mclass="",mhr="",semestertype="";

String QrySemType="",mSemType="";

ResultSet rs=null,rs1=null,rs2=null,rsbas=null;
int i=1;
if (session.getAttribute("WebAdminEmail")==null){
	mWebEmail="";
}else{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
}
if (session.getAttribute("MemberID")==null){
	mMemberID="";
}else{
	mMemberID=session.getAttribute("MemberID").toString().trim();
}
if (session.getAttribute("MemberType")==null){
	mMemberType="";
}else{
	mMemberType=session.getAttribute("MemberType").toString().trim();
}
if (session.getAttribute("MemberName")==null){
	mMemberName="";
}else{
	mMemberName=session.getAttribute("MemberName").toString().trim();
}
if (session.getAttribute("MemberCode")==null){
	mMemberCode="";
}else{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
}
if (session.getAttribute("InstituteCode")==null){
	mInst="";
}else{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}
if (session.getAttribute("CompanyCode")==null){
	mComp="";
}else{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}
if (session.getAttribute("ProgramCode")==null){
	mProg="";
}else{
	mProg=session.getAttribute("ProgramCode").toString().trim();
}
if (session.getAttribute("BranchCode")==null){
	mBranch="";
}else{
	mBranch=session.getAttribute("BranchCode").toString().trim();
}
if (session.getAttribute("MemberName")==null){
	mName="";
}else{
	mName=session.getAttribute("MemberName").toString().trim();
}




if (session.getAttribute("LoginComp")==null)
{
	mLoginComp="";
}
else
{
	mLoginComp=session.getAttribute("LoginComp").toString().trim();
}

try 
{  //1
	if(!mMemberID.equals("") && !mMemberType.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")){  //2
		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mMacAddress =" "; 
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk=null;
		//-----------------------------
		//-- Enable Security Page Level  
		//-----------------------------
		qry="Select WEBKIOSK.ShowLink('56','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      	RsChk= db.getRowset(qry);
		//if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		if(1==1){
			//----------------------
			try{	
				mDMemberCode=enc.decode(mMemberCode);
				mMemberID=enc.decode(mMemberID);
				mMemberType=enc.decode(mMemberType);
			}catch(Exception e){
				//out.println(e.getMessage());
			}
			qry="Select  nvl(PREREGEXAMID,' ') Exam from CompanyInstituteTagging where CompanyCode='"+mLoginComp+"' and InstituteCode='"+mInst+"'";
			//out.print(qry);
			rs=db.getRowset(qry);
			if(rs.next()){
				mExamCode=rs.getString("Exam");		
			}
			%>
			<FORM METHOD=POST ACTION="" name="frm1">
				<INPUT TYPE="hidden" NAME="x">
					<table cellpadding=1 cellspacing=0 width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
					<tr>
						<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: VERDANA">Back Log Student Merge with Regular Batch After Load Distribution</TD></font>
					</tr>
				</TABLE><br>
				<table cellpadding=1 cellspacing=0 width="95%" align=center rules=groups border=3>
					<tr>			
						<td><FONT color=black><FONT face=Arial size=2><STRONG>&nbsp;&nbsp;Exam Code&nbsp;&nbsp;</STRONG></FONT></FONT></td>
						<td>
							<select name=Exam tabindex="0" id="Exam" style="WIDTH: 120px">	
								<OPTION Value =<%=mExamCode%>><%=mExamCode%></option>						
						</td>
						<td><FONT color=black><FONT face=Arial size=2><STRONG>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Subject&nbsp;&nbsp;</STRONG></FONT></FONT>
						</td>
						<td>
						<%
							if(request.getParameter("x")==null)
								mSubjectid="";
							else
								mSubjectid=request.getParameter("subjects");
						%>
							<select name="subjects" tabindex="0" id="subjects" style="WIDTH: 480px">
							<%
							qry="SELECT DISTINCT a.subjectid subjectid,b.subject || ' (' || b.subjectcode || ')' subject FROM facultysubjecttagging a, subjectmaster b WHERE a.examcode = '"+mExamCode+"' AND a.semestertype IN ('RWJ', 'SAP') AND NVL (a.deactive, 'N') = 'N' AND NVL (b.deactive, 'N') = 'N' AND a.subjectid = b.subjectid and a.InstituteCode='"+mInst+"' and a.InstituteCode=b.InstituteCode order by subject";
							rs=db.getRowset(qry);
							//System.out.println(qry);
							while(rs.next()){
								if(!mSubjectid.equals("") && mSubjectid.equals(rs.getString("subjectid"))){
									%>
									<OPTION selected Value =<%=rs.getString("subjectid")%>><%=rs.getString("subject")%></option>
									<%
								}else{
									%>
									<OPTION Value =<%=rs.getString("subjectid")%>><%=rs.getString("subject")%></option>
									<%
								}
							}
							%>
							</select>
						</td>
					</tr>
					<tr>
						<%
							if(request.getParameter("x")==null)
								mLTP="";
							else
								mLTP=request.getParameter("LTP");
						%>
						<td><FONT color=black><FONT face=Arial size=2><STRONG>&nbsp;&nbsp;LTP&nbsp;&nbsp;</STRONG></FONT></FONT></td>
						<td>
							<select name="LTP" style="WIDTH: 120">									
								<%if(mLTP.equals("L")){%>
								<option selected value="L">Lecture </option>
								<option value="T">Tutorial</option>
								<option value="P">Practical</option>						
								<%}else if(mLTP.equals("T")){%>
								<option value="L">Lecture </option>
								<option selected value="T">Tutorial</option>
								<option value="P">Practical</option>						
								<%}else if(mLTP.equals("P")){%>
								<option value="L">Lecture </option>
								<option value="T">Tutorial</option>
								<option selected value="P">Practical</option>
								<%}else {%>
								<option value="L">Lecture </option>
								<option value="T">Tutorial</option>
								<option value="P">Practical</option>								
								<%}%>
							</select>
						</td>
						
						<TD nowrap>
						<FONT face=Arial size=2 color=black><b>Sem. Type</b></font>
</td>
<td>

<select name=SemType id=SemType>
<%

if(request.getParameter("SemType")==null)
{
	if(QrySemType.equals(""))
		QrySemType=mSemType;
	%>
	
	<option value='REG'>REG</option>
	<option value='SAP'>SAP</option>
	<option selected value='RWJ'>RWJ</option>
	<%
}
else
{
	mSemType=request.getParameter("SemType").toString().trim();
	QrySemType=mSemType;
	if(mSemType.equals("SAP"))
	{
		%>
		<!--<option selected value='ALL'>ALL</option>-->
		<option value='REG'>REG</option>
		<option selected value='SAP'>SAP</option>
		<option value='RWJ'>RWJ</option>
 		<%
	}
	else if(mSemType.equals("REG"))
	{
		%>
		<!--<option value='ALL'>ALL</option>-->
		<option selected value='REG'>REG</option>
		<option value='SAP'>SAP</option>
	   	<option value='RWJ'>RWJ</option>

 		<%
	}	
	else 
	{
		%>
		<!--<option value='ALL'>ALL</option>-->
		<option value='REG'>REG</option>
		<option value='SAP'>SAP</option>
	  	<option selected value='RWJ'>RWJ</option>
		<%
	}
}
%>
</select>
						</TD>
						</tr>
						<tr>

						<td align='center' colspan=4> <center><input type="submit" name="Ok" value="Ok" style="WIDTH:50px"/></center>
						</td>
					</tr>
				</table>				
				<%

			String ELECTIVECODE="",DURATIONOFCLASS="",NOOFCLASSINAWEEK="",BASKET="",empid="",hsubsection="";

				if(request.getParameter("Y")!=null && (request.getParameter("save")!=null))//|| request.getParameter("save").equals("SAVE")
				{
					int count=0;
					//out.println(request.getParameter("regbatch"));
					if(request.getParameter("i")!=null && !request.getParameter("i").equals("") && request.getParameter("regbatch")!=null){
						if(request.getParameter("regbatch")!=null){
							if(!request.getParameter("regbatch").equals("")){
								String aa=request.getParameter("regbatch");
								//fstid=aa.substring(0,aa.indexOf("@@@"));
								
									mergfstid=aa.substring(0,aa.indexOf("!!!"));
								compcode=aa.substring(aa.indexOf("!!!")+3,aa.indexOf("@@@"));
								facultyid=aa.substring(aa.indexOf("@@@")+3,aa.indexOf("###"));
								facultytype=aa.substring(aa.indexOf("###")+3,aa.indexOf("$$$"));
								hacad=aa.substring(aa.indexOf("^^^")+3,aa.indexOf("&&&"));
								hprogram=aa.substring(aa.indexOf("&&&")+3,aa.indexOf("```"));
								hsecbranch=aa.substring(aa.indexOf("```")+3,aa.indexOf("~~~"));
								hsem=aa.substring(aa.indexOf("~~~")+3,aa.indexOf(">>>"));
								hbasket=aa.substring(aa.indexOf(">>>")+3,aa.indexOf("???"));
								htagfor=aa.substring(aa.indexOf("???")+3,aa.indexOf("+++"));					hsubsection=aa.substring(aa.indexOf("+++")+3,aa.indexOf("___"));
								subtype=aa.substring(aa.indexOf("___")+3,aa.indexOf("---"));
								elecCode=aa.substring(aa.indexOf("---")+3,aa.indexOf("///"));
								mclass=aa.substring(aa.indexOf("///")+3,aa.indexOf("<<<"));
								mhr=aa.substring(aa.indexOf("<<<")+3,aa.length());
								
							//out.print(facultyid+"facultyid"+fstid);
							
							}
						}

					//	out.print(facultyid+"facultyid"+mergfstid);

						count=Integer.parseInt(request.getParameter("i"));
						
						
							for(i=2;i<=count;i++){
								if(request.getParameter("chk"+i)!=null && !request.getParameter("chk"+i).equals("") && request.getParameter("chk"+i).equals("Y")){

								if(request.getParameter("enroll"+i)==null)
									Studid="";
								else
									Studid=request.getParameter("enroll"+i);

								if(request.getParameter("fstid1"+i)==null)
									Studfstid="";
								else
									Studfstid=request.getParameter("fstid1"+i);
								
								
								if(request.getParameter("semestertype"+i)==null)
									semestertype="";
								else
									semestertype=request.getParameter("semestertype"+i);
								
							
							
							if(request.getParameter("acad"+i)==null)
									acad="";
								else
									acad=request.getParameter("acad"+i);
								if(request.getParameter("progcode"+i)==null)
									progcode="";
								else
									progcode=request.getParameter("progcode"+i);
								
								if(request.getParameter("empid"+i)==null)
									empid="";
								else
									empid=request.getParameter("empid"+i);

								if(request.getParameter("tagfor"+i)==null)
									tagfor="";
								else
									tagfor=request.getParameter("tagfor"+i);
													

								
								if(request.getParameter("subsection"+i)==null)
									subsection="";
								else
									subsection=request.getParameter("subsection"+i);

					
								if(request.getParameter("secbranc"+i)==null)
									secbranc="";
								else
									secbranc=request.getParameter("secbranc"+i);

								if(request.getParameter("sem"+i)==null)
									sem="";
								else
									sem=request.getParameter("sem"+i);
								
								
								if(request.getParameter("subtype"+i)==null)
									subtype="";
								else
									subtype=request.getParameter("subtype"+i);	

								
								if(request.getParameter("NOOFCLASSINAWEEK"+i)==null)
									NOOFCLASSINAWEEK="";
								else
									NOOFCLASSINAWEEK=request.getParameter("NOOFCLASSINAWEEK"+i);	

								if(request.getParameter("DURATIONOFCLASS"+i)==null)
									DURATIONOFCLASS="";
								else
									DURATIONOFCLASS=request.getParameter("DURATIONOFCLASS"+i);	
								
							if(request.getParameter("ELECTIVECODE"+i)==null)
									ELECTIVECODE="";
								else
									ELECTIVECODE=request.getParameter("ELECTIVECODE"+i);	

								if(request.getParameter("BASKET"+i)==null)
									BASKET="";
								else
									BASKET=request.getParameter("BASKET"+i);	




						//	out.println(subsection+"StudFSTID"+Studid+"semestertype"+hsubsection	);
															
								int x=0,g=0;

						qry="select 'Y' from v#studentltpdetail where  fstid='"+Studfstid+"'  and studentid <>'"+Studid+"'";
						//out.print(qry);
						rs=db.getRowset(qry);
						if(!rs.next())
						{
							qry2="select distinct  fstid rwjfstid from FACULTYSUBJECTTAGGING where  SUBJECTID='"+mSubjectid+"' and LTP='"+mLTP+"' and SECTIONBRANCH='"+secbranc+"' and SUBSECTIONCODE='"+hsubsection+"' and AcademicYear='"+acad+"' and ProgramCode='"+progcode+"' AND EXAMCODE = '"+mExamCode+"' and institutecode='"+mInst+"' and EMPLOYEEID='"+facultyid+"' "; 
							//out.print(qry2);
							rs2=db.getRowset(qry2);
							if(rs2.next())
							{
								qry1="select 'Y' from v#studentltpdetail where  fstid='"+rs2.getString("rwjfstid")+"'  and studentid <>'"+Studid+"'";
								//out.print(qry1+"LL");
								rs1=db.getRowset(qry1);
								if(rs1.next())
									{
									


											qry="UPDATE STUDENTLTPDETAIL SET FSTID= '"+rs2.getString("rwjfstid")+"',ENTRYBY='"+mChkMemID+"',ENTRYDATE=sysdate			WHERE  FSTID     = '"+Studfstid+"'	AND    STUDENTID = '"+Studid+"' ";
										//	out.print(qry+" :11");
										 g=db.update(qry);
											if(g>0)
												mflag=1;
											else
												mflag=0;
								
										}
										else
										{
															if(facultyid.equals(empid) )										
												{			
												qry1="UPDATE FACULTYSUBJECTTAGGING set MERGEWITHFSTID='"+mergfstid+"',ENTRYBY='"+mChkMemID+"',ENTRYDATE=sysdate WHERE FSTID='"+Studfstid+"' ";
											
												}
												else
												{
												
												qry1="UPDATE FACULTYSUBJECTTAGGING set employeeid='"+facultyid+"', MERGEWITHFSTID='"+mergfstid+"',ENTRYBY='"+mChkMemID+"',ENTRYDATE=sysdate WHERE FSTID='"+Studfstid+"' ";
												}
											
												//out.print(qry1+" ::2");
												int s=0;
												s=db.update(qry1);
												if(s>0)
													mflag=1;	
												else
													mflag=0;
										}

							}
							else
							{
								if(facultyid.equals(empid) )										
								{			
								qry1="UPDATE FACULTYSUBJECTTAGGING set MERGEWITHFSTID='"+mergfstid+"',ENTRYBY='"+mChkMemID+"',ENTRYDATE=sysdate WHERE FSTID='"+Studfstid+"' ";
							
								}
								else
								{
								
								qry1="UPDATE FACULTYSUBJECTTAGGING set employeeid='"+facultyid+"', MERGEWITHFSTID='"+mergfstid+"',ENTRYBY='"+mChkMemID+"',ENTRYDATE=sysdate WHERE FSTID='"+Studfstid+"' ";
								}
							
							//out.print(qry1+" ::3");
								int s=0;
								s=db.update(qry1);
								if(s>0)
									mflag=1;	
								else
									mflag=0;
							}



						}
								else
						{
										
									
										
							
					
						if(mSemType.equals("RWJ") || mSemType.equals("SAP"))
								{
						qry="select distinct  fstid rwjfstid from FACULTYSUBJECTTAGGING where  SUBJECTID='"+mSubjectid+"' and LTP='"+mLTP+"' and SECTIONBRANCH='"+secbranc+"' and SUBSECTIONCODE='"+hsubsection+"' and AcademicYear='"+acad+"' and ProgramCode='"+progcode+"' AND EXAMCODE = '"+mExamCode+"' and institutecode='"+mInst+"' and EMPLOYEEID='"+facultyid+"' "; 
						//out.println("FSTID "+qry);
						rs=db.getRowset(qry);
						if(!rs.next())
							{

								fstid=db.GenerateFSTID(mInst);
										 qry1="INSERT INTO FACULTYSUBJECTTAGGING (    FSTID, INSTITUTECODE, COMPANYCODE,    FACULTYTYPE, EMPLOYEEID, EXAMCODE,    ACADEMICYEAR, PROGRAMCODE, TAGGINGFOR,    SECTIONBRANCH, SUBSECTIONCODE, SEMESTER,    SEMESTERTYPE, BASKET, SUBJECTID,    LTP,  ENTRYBY,    ENTRYDATE, DEACTIVE, DURATIONOFCLASS,    MERGEWITHFSTID, NOOFCLASSINAWEEK, SUBJECTTYPE,    ELECTIVECODE) VALUES (  '"+fstid+"', '"+mInst+"','"+compcode+"','"+facultytype+"' ,'"+facultyid+"', '"+mExamCode+"','"+acad+"' , '"+progcode+"','"+tagfor+"' , '"+secbranc+"', '"+hsubsection+"', '"+sem+"','"+semestertype+"' ,'"+BASKET+"', '"+mSubjectid+"' , '"+mLTP+"','"+mChkMemID+"', sysdate,'' ,'"+DURATIONOFCLASS+"','"+mergfstid+"', '"+NOOFCLASSINAWEEK+"','"+subtype+"', '"+ELECTIVECODE+"' )";
								//	out.print(qry1+" ::4");
												 x=db.insertRow(qry1);
											if(x>0)
												mflag=1;
											else
												mflag=0;


											qry="UPDATE STUDENTLTPDETAIL SET FSTID= '"+fstid+"',ENTRYBY='"+mChkMemID+"',ENTRYDATE=sysdate			WHERE  FSTID     = '"+Studfstid+"'	AND    STUDENTID = '"+Studid+"' ";
									//out.print(qry+" ::5");
											 g=db.update(qry);
											if(g>0)
												mflag=1;
											else
												mflag=0;
									
									
							}
							else
							{
								out.print(rs.getString("rwjfstid")+"***"+Studid);
							qry="select 'Y' from v#studentltpdetail where  fstid='"+rs.getString("rwjfstid")+"'  and studentid <>'"+Studid+"'";
							//out.print(qry);
							rs1=db.getRowset(qry);
							if(rs1.next())
									{
									


											qry="UPDATE STUDENTLTPDETAIL SET FSTID= '"+rs.getString("rwjfstid")+"',ENTRYBY='"+mChkMemID+"',ENTRYDATE=sysdate			WHERE  FSTID     = '"+Studfstid+"'	AND    STUDENTID = '"+Studid+"' ";
										//out.print(qry+" ::6");
										 g=db.update(qry);
											if(g>0)
												mflag=1;
											else
												mflag=0;



											
if(subsection.equals(hsubsection)){

										if(facultyid.equals(empid) )										
										{			
									qry1="UPDATE FACULTYSUBJECTTAGGING set MERGEWITHFSTID='"+mergfstid+"',ENTRYBY='"+mChkMemID+"',ENTRYDATE=sysdate WHERE FSTID='"+Studfstid+"' ";
									
										}
										else
										{
										
									qry1="UPDATE FACULTYSUBJECTTAGGING set employeeid='"+facultyid+"', MERGEWITHFSTID='"+mergfstid+"',ENTRYBY='"+mChkMemID+"',ENTRYDATE=sysdate WHERE FSTID='"+Studfstid+"' ";
										}
									
									//out.print(qry1 + " : : - 9" );
									int s=0;
									s=db.update(qry1);
										if(s>0)
											mflag=1;	
										else
											mflag=0;


}

								
								}
								else
								{
									
									 if(subsection.equals(hsubsection)){
										if(facultyid.equals(empid) )										
										{			
									qry1="UPDATE FACULTYSUBJECTTAGGING set MERGEWITHFSTID='"+mergfstid+"',ENTRYBY='"+mChkMemID+"',ENTRYDATE=sysdate WHERE FSTID='"+Studfstid+"' ";
									
										}
										else
										{
										
									qry1="UPDATE FACULTYSUBJECTTAGGING set employeeid='"+facultyid+"', MERGEWITHFSTID='"+mergfstid+"',ENTRYBY='"+mChkMemID+"',ENTRYDATE=sysdate WHERE FSTID='"+Studfstid+"' ";
										}
									
									//out.print(qry1 + " : : - 9" );
									int s=0;
									s=db.update(qry1);
										if(s>0)
											mflag=1;	
										else
											mflag=0; 

									 }


											qry="UPDATE STUDENTLTPDETAIL SET FSTID= '"+rs.getString("rwjfstid")+"',ENTRYBY='"+mChkMemID+"',ENTRYDATE=sysdate			WHERE  FSTID     = '"+Studfstid+"'	AND    STUDENTID = '"+Studid+"' ";
										//out.print(qry+" ::66");
											 g=db.update(qry);
											if(g>0)
												mflag=1;
											else
												mflag=0;



								}



							}
						}
						else  // REGULAR STUDENTS
							{

qry="select distinct  fstid rwjfstid from FACULTYSUBJECTTAGGING where  SUBJECTID='"+mSubjectid+"' and LTP='"+mLTP+"' and SECTIONBRANCH='"+secbranc+"' and SUBSECTIONCODE='"+hsubsection+"' and AcademicYear='"+acad+"' and ProgramCode='"+progcode+"' AND EXAMCODE = '"+mExamCode+"' and institutecode='"+mInst+"' and EMPLOYEEID='"+facultyid+"' "; 
						//out.print(qry);
						rs=db.getRowset(qry);
						if(rs.next())
							{

	qry="select 'Y' from v#studentltpdetail where  fstid='"+rs.getString("rwjfstid")+"'  and studentid <>'"+Studid+"'";
							//out.print(qry);
							rs1=db.getRowset(qry);
							if(rs1.next())
									{
									


											qry="UPDATE STUDENTLTPDETAIL SET FSTID= '"+rs.getString("rwjfstid")+"',ENTRYBY='"+mChkMemID+"',ENTRYDATE=sysdate			WHERE  FSTID     = '"+Studfstid+"'	AND    STUDENTID = '"+Studid+"' ";
										//out.print(qry+" ::6");
										//	g=db.update(qry);
											if(g>0)
												mflag=1;
											else
												mflag=0;
								
								}


							}





							}
						

											
									}


									//	fstid=db.GenerateFSTID(mInst);
									
								}
							}
						
									//		out.print(mflag+"mflag");
						if(mflag==1)
						{
						//	out.print("<br><img src='../../Images/Error1.jpg'>");
							out.print(" <br><center> <b><font size=3 face='Arial' color='green'> Record Saved Successfully......</font></center>");

						}
						else
						{
							out.print(" <br><center> <b><font size=3 face='Arial' color='red'> Error in Saving...</font></center>");
						}
								
					
				}
				else{
					out.print("<br><center> <b><font size=3 face='Arial' color='Red'> Please Select Atleast One Student and Regular Batch ....</font></center>");
				}
			}
				if(request.getParameter("x")!=null)
				{
					%><br>
					<TABLE border='1' align="center" class="sort-table" id="table-1" width="90%">
					<tr bgcolor="#ff8c00">
						<TD align="center"><B>Students (SAP and RWJ)</B></TD>
						<TD align="center"><B>Regular Batches</B> </TD>
					</tr>
					<tr>	
						<TD width="50%" valign="top">
							<TABLE border='1' width="100%" class="sort-table" id="table-1" cellpadding=1 cellspacing=0>
							<tr bgcolor="#ff8c00">
								<TD><CENTER><B>--</B></CENTER><!-- <INPUT TYPE="checkbox" NAME="chk1" onclick="checkall();"> --></TD>
								<TD><B>EnRoll</B></TD>
								<TD><B>Stud. Name</B></TD>
								<TD><B>Pro<br>Code</B></TD>
								<TD><B>Branch <br>Code</B></TD>
								<TD><B>Sem</B></TD>
								<TD><B>Sub<br>Sec</B></TD>
								<TD><B>Sem<br> Type</B></TD>
							
								<TD><B>Faculty</B></TD>
								<TD><B>Merge<br>With</B></TD>
							</TR>
								<%
								
								String disabled="",mMergeBatch="",mcolor="";
								
					//a.TAGGINGFOR,a.SUBJECTTYPE,a.NOOFCLASSINAWEEK,a.DURATIONOFCLASS,a.subjectid,a.ELECTIVECODE 
								
								qry="SELECT DISTINCT  a.employeename employeename,a.employeecode, a.employeeID EMPLOYEEID,b.MERGEWITHFSTID MERGEWITHFSTID ,a.FSTID, a.studentid studentid,a.ENROLLMENTNO, a.STUDENTNAME, a.PROGRAMCODE PROGRAMCODE,a.SEMESTER SEMESTER, a.SUBSECTIONCODE ,a.SEMESTERTYPE,a.ACADEMICYEAR ACADEMICYEAR,a.TAGGINGFOR TAGGINGFOR,a.SECTIONBRANCH,a.SUBJECTTYPE SUBJECTTYPE,nvl(b.NOOFCLASSINAWEEK,0)NOOFCLASSINAWEEK,nvl(b.DURATIONOFCLASS,0)DURATIONOFCLASS,nvl(b.ELECTIVECODE,' ')ELECTIVECODE,B.BASKET,to_char(b.ENTRYDATE,'yyyymmdd')ENTRYDATE,to_char(sysdate,'yyyymmdd')SyDate FROM v#studentltpdetail A ,facultysubjecttagging B WHERE a.FSTID=b.FSTID AND  A.SUBJECTID ='"+mSubjectid+"'  AND A.EXAMCODE = '"+mExamCode+"'  ";
								
								if(mSemType.equals("RWJ"))
									qry=qry+" AND A.SEMESTERTYPE IN ('RWJ', 'SAP') ";
								else
									qry=qry+" AND A.SEMESTERTYPE IN ('REG') ";

								qry=qry+" AND NVL (A.DEACTIVE, 'N') = 'N' AND NVL (a.studentDEACTIVE, 'N') = 'N' and a.InstituteCode='"+mInst+"'  AND A.LTP='"+mLTP+"'  order by PROGRAMCODE,SECTIONBRANCH,semester,SUBSECTIONCODE  ";
								rs=db.getRowset(qry);
								//out.println(qry);
								while(rs.next())	
								{
									
									qry1="select A.mergewithFSTID,A.SUBSECTIONCODE from facultysubjecttagging A where   A.fstid='"+rs.getString("MERGEWITHFSTID")+"' ";
									rs1=db.getRowset(qry1);
									if(rs1.next())
									{
										mMergeBatch=rs1.getString("SUBSECTIONCODE");
										
									}
									else
									{	mMergeBatch="";

									}
									//out.println(disabled);
									
									mMergeEmployee=rs.getString("employeename");

									if(rs.getString("ENTRYDATE").toString().trim().equals(rs.getString("SyDate").toString().trim()))
										mcolor="pink";
									else
										mcolor="";

									%>	<%++i;%>
										<INPUT TYPE="hidden" NAME="enroll<%=i%>" value="<%=rs.getString("studentid")%>">

										<INPUT TYPE="hidden" NAME="fstid1<%=i%>" value="<%=rs.getString("FSTID")%>">
										
											<INPUT TYPE="hidden" NAME="semestertype<%=i%>" value="<%=rs.getString("SEMESTERTYPE")%>">

											<INPUT TYPE="hidden" NAME="acad<%=i%>" value="<%=rs.getString("ACADEMICYEAR")%>">

											<INPUT TYPE="hidden" NAME="tagfor<%=i%>" value="<%=rs.getString("TAGGINGFOR")%>">
										
										<INPUT TYPE="hidden" NAME="progcode<%=i%>" 
										value="<%=rs.getString("PROGRAMCODE")%>">
										
										<INPUT TYPE="hidden" NAME="empid<%=i%>" value="<%=rs.getString("EMPLOYEEID")%>">
										
										<INPUT TYPE="hidden" NAME="secbranc<%=i%>" value="<%=rs.getString("SECTIONBRANCH")%>">

										<INPUT TYPE="hidden" NAME="subsection<%=i%>" value="<%=rs.getString("SUBSECTIONCODE")%>">

										<INPUT TYPE="hidden" NAME="sem<%=i%>" value="<%=rs.getString("SEMESTER")%>">

										<INPUT TYPE="hidden" NAME="subtype<%=i%>" value="<%=rs.getString("SUBJECTTYPE")%>">

										<INPUT TYPE="hidden" NAME="NOOFCLASSINAWEEK<%=i%>" value="<%=rs.getString("NOOFCLASSINAWEEK")%>">

										<INPUT TYPE="hidden" NAME="DURATIONOFCLASS<%=i%>" value="<%=rs.getString("DURATIONOFCLASS")%>">

										<INPUT TYPE="hidden" NAME="ELECTIVECODE<%=i%>" value="<%=rs.getString("ELECTIVECODE")%>">

										<INPUT TYPE="hidden" NAME="BASKET<%=i%>" value="<%=rs.getString("BASKET")%>">
									

										<TR bgcolor="<%=mcolor%>">
										<TD>
										
										
										<INPUT TYPE="checkbox" NAME="chk<%=i%>" onclick="singlecheck();" value="Y" <%=disabled%> >
										
										
										
										</TD>
										<TD><CENTER><%=rs.getString("ENROLLMENTNO")%></CENTER></TD>
										<TD><%=rs.getString("STUDENTNAME")%></TD>
										<TD><CENTER><%=rs.getString("PROGRAMCODE")%></CENTER></TD>
										<TD><CENTER><%=rs.getString("SECTIONBRANCH")%></CENTER></TD>
										<TD><CENTER><%=rs.getString("SEMESTER")%></CENTER></TD>
										<TD><CENTER><%=rs.getString("SUBSECTIONCODE")%></CENTER></TD>
										<TD><CENTER><%=rs.getString("SEMESTERTYPE")%></CENTER></TD>
									
										
										
										<TD><%=mMergeEmployee%>  <%=rs.getString("employeecode")%></TD>
										

										<TD><%=mMergeBatch%></TD>
										</TR>
									<%
								}
								%>
							</TABLE>
						</TD>
						<TD width="50%" valign="TOP"><TABLE border='1' width="100%" class="sort-table" id="table-1">
							<tr bgcolor="#ff8c00">
								<TD>&nbsp;</TD>
								<TD><B>Faculty</B></TD>
								<TD><B>Pro<br>Code</B></TD>
								<TD><B>Sec<br> Branch</B></TD>
								<TD><B>Sub<br>Sect</B></TD>
								<TD><B>Sem</B></TD>
								<TD><B>Count<br>(Stud)</B></TD>
							</TR>
							
								<%
								qry="SELECT  a.programcode, a.sectionbranch, a.subsectioncode, a.semester,a.ACADEMICYEAR,a.semestertype,a.fstid, a.companycode,a.employeeid facultyid,a.facultytype,a.ltp,a.basket,a.TAGGINGFOR,nvl(a.SUBJECTTYPE,' ')SUBJECTTYPE,nvl(a.NOOFCLASSINAWEEK,0)NOOFCLASSINAWEEK,nvl(a.DURATIONOFCLASS,0)DURATIONOFCLASS,a.subjectid,nvl(a.ELECTIVECODE,' ')ELECTIVECODE  FROM FACULTYSUBJECTTAGGING a WHERE   a.subjectid = '"+mSubjectid+"'   AND a.examcode = '"+mExamCode+"'   AND a.ltp = '"+mLTP+"' and a.InstituteCode='"+mInst+"' and a.semestertype='REG' and a.companycode='"+mComp+"' order by programcode,sectionbranch,subsectioncode,semester";	
								//out.println(qry);
								// and nvl(a.MERGEWITHFSTID,'N')='N'
								rs=db.getRowset(qry);
								while(rs.next())	
								{
									String aa=rs.getString("fstid")+"!!!"+rs.getString("companycode")+"@@@"+rs.getString("facultyid")+"###"+rs.getString("facultytype")+"$$$"+rs.getString("ltp")+"^^^"+rs.getString("ACADEMICYEAR")+"&&&"+rs.getString("programcode")+"```"+rs.getString("sectionbranch")+"~~~"+rs.getString("semester")+">>>"+rs.getString("basket")+"???"+rs.getString("TAGGINGFOR")+"+++"+rs.getString("subsectioncode")+"___"+rs.getString("SUBJECTTYPE")+"---"+rs.getString("ELECTIVECODE")+"///"+rs.getString("NOOFCLASSINAWEEK")+"<<<"+rs.getString("DURATIONOFCLASS");
									
									qry1="select A.employeeid,A.employeename,A.employeecode from employeemaster A where   A.employeeid='"+rs.getString("facultyid")+"' ";
									rs1=db.getRowset(qry1);
									if(rs1.next())
									{
										mEmpname=rs1.getString("employeename")+"-"+rs1.getString("employeecode");
										
									}
									else
									{
										mEmpname="--";
									}
									
									%>	<TR>
										<TD><INPUT TYPE="radio" NAME="regbatch" value="<%=aa%>"></TD>
										<TD><%=mEmpname%> </TD>
										<TD><CENTER><%=rs.getString("programcode")%></CENTER></TD>
										<TD><CENTER><%=rs.getString("sectionbranch")%></CENTER></TD>
										<TD><CENTER><%=rs.getString("subsectioncode")%></CENTER></TD>
										<TD><CENTER><%=rs.getString("semester")%></CENTER></TD>
										<%
										String qryinn="select count(distinct studentid)aa From V#Studentltpdetail where institutecode='"+mInst+"' and subjectid='"+mSubjectid+"' and semestertype='REG' and nvl(deactive,'N')='N' and nvl(studentdeactive,'N')='N' and EXAMCODE =  '"+mExamCode+"' and sectionbranch='"+rs.getString("sectionbranch")+"' and programcode='"+rs.getString("programcode")+"' and subsectioncode='"+rs.getString("subsectioncode")+"' and semester= '"+rs.getString("semester")+"' and ACADEMICYEAR='"+rs.getString("ACADEMICYEAR")+"' and semestertype='"+rs.getString("semestertype")+"' AND subsectioncode IS NOT NULL";
										//out.println(qryinn);
										ResultSet rsinn=db.getRowset(qryinn);										
										if(rsinn.next()){
										%>
										<TD><CENTER><%=rsinn.getString("aa")%></CENTER></TD>
										<%}else{%>
										<TD>-</TD>
										<%}%>
										</TR>
									<%
								}
								%>
							
							</TABLE>
						</TD>
					</TR>
					</TABLE>
					<INPUT TYPE="hidden" NAME="i" value=<%=i%>>
					<INPUT TYPE="hidden" NAME="Y">
					<center><INPUT TYPE="submit" name="save" value="SAVE"></center>
					<%					
				}
				
		
		%>
		</FORM>
		<%
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
}   //2
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
}	//1	
catch(Exception e)
{
	//out.println(e);
}
%>

</body>
</html>