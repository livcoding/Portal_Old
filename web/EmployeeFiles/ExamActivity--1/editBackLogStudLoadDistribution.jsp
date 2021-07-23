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
<TITLE>#### <%=mHead%> [Edit Back Log Subjects Merge With Regular Batches (Load Distribution) ] </TITLE>
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
String qry="",qry1="",mWebEmail="",EmpIDType="",fstid="";
String elecCode="";
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
String mComp="", mInst="";
String mSem="";
String mExamCode="",mProg="",mBranch="",mName="";
String mEmployeeID="",mLTP="",mSubjectid="";
String enroll="",acad="",progcode="",tagfor="",secbranc="",sem="",semtype="",subseccode="",basket="",mergfstid="",compcode="",facultyid="",facultytype="";
String LTPFstid="";
String hacad="",hprogram="",hsecbranch="",hsem="",hbasket="",htagfor="";
int mLclass=0,mTclass=0,mPclass=0,mLhr=0,mThr=0,mPhr=0,jj=0;
String mclass="",mhr="";
ResultSet rs=null,rs1=null,rsbas=null;
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

String mLoginComp="";


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
						<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">Edit Back Log Subjects Merge With Regular Batches (Load Distribution)</TD></font>
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
							if(request.getParameter("subjectid")==null)
								mSubjectid="";
							else
								mSubjectid=request.getParameter("subjectid");
							qry="SELECT DISTINCT b.subjectid subjectid,b.subject || ' (' || b.subjectcode || ')' subject FROM   subjectmaster b WHERE  NVL (b.deactive, 'N') = 'N' AND b.subjectid = '"+mSubjectid+"' and b.InstituteCode='"+mInst+"'";
							rs=db.getRowset(qry);
							//out.println(qry);
						%>
							<select name="subjects" tabindex="0" id="subjects" style="WIDTH: 480px">
							<%
							
							
							while(rs.next()){
								
									%>
									<OPTION selected Value =<%=rs.getString("subjectid")%>><%=rs.getString("subject")%></option>
									<%
								
							}
							%>
							</select>
						</td>
					</tr>
					<tr>
						<%
							if(request.getParameter("mLTP")==null)
								mLTP="";
							else
								mLTP=request.getParameter("mLTP");
						%>
						<td><FONT color=black><FONT face=Arial size=2><STRONG>&nbsp;&nbsp;LTP&nbsp;&nbsp;</STRONG></FONT></FONT></td>
						<td>
							<select name="LTP" style="WIDTH: 120">									
								<%if(mLTP.equals("L")){%>
								<option selected value="L">Lecture </option>
								<!-- <option value="T">Tutorial</option>
								<option value="P">Practical</option> -->						
								<%}else if(mLTP.equals("T")){%>
								<!-- <option value="L">Lecture </option> -->
								<option selected value="T">Tutorial</option>
								<!-- <option value="P">Practical</option>		 -->				
								<%}else if(mLTP.equals("P")){%>
								<!-- <option value="L">Lecture </option>
								<option value="T">Tutorial</option> -->
								<option selected value="P">Practical</option>
								<%}else {%>
								<!-- <option value="L">Lecture </option>
								<option value="T">Tutorial</option>
								<option value="P">Practical</option> -->								
								<%}%>
							</select>
						</td>	
						<td align='center' colspan=2> <center><!-- <input type="submit" name="Ok" value="Ok" style="WIDTH:50px"/> --></center>
						</td>
					</tr>
				</table>				
				<%
				if(request.getParameter("Y")!=null && (request.getParameter("save")!=null))//|| request.getParameter("save").equals("SAVE")
				{
					int count=0;
					//out.println(request.getParameter("regbatch"));
					if(request.getParameter("i")!=null && !request.getParameter("i").equals("") && request.getParameter("regbatch")!=null){
						if(request.getParameter("regbatch")!=null){
							if(!request.getParameter("regbatch").equals("")){
								String aa=request.getParameter("regbatch");
								mergfstid=aa.substring(0,aa.indexOf("!!!"));
								compcode=aa.substring(aa.indexOf("!!!")+3,aa.indexOf("@@@"));
								facultyid=aa.substring(aa.indexOf("@@@")+3,aa.indexOf("###"));
								facultytype=aa.substring(aa.indexOf("###")+3,aa.indexOf("$$$"));
								hacad=aa.substring(aa.indexOf("^^^")+3,aa.indexOf("&&&"));
								hprogram=aa.substring(aa.indexOf("&&&")+3,aa.indexOf("```"));
								hsecbranch=aa.substring(aa.indexOf("```")+3,aa.indexOf("~~~"));
								hsem=aa.substring(aa.indexOf("~~~")+3,aa.indexOf(">>>"));
								hbasket=aa.substring(aa.indexOf(">>>")+3,aa.indexOf("???"));
								htagfor=aa.substring(aa.indexOf("???")+3,aa.indexOf("+++"));							dept=aa.substring(aa.indexOf("+++")+3,aa.indexOf("___"));
								subtype=aa.substring(aa.indexOf("___")+3,aa.indexOf("---"));
								elecCode=aa.substring(aa.indexOf("---")+3,aa.indexOf("///"));
								mclass=aa.substring(aa.indexOf("///")+3,aa.indexOf("<<<"));
								mhr=aa.substring(aa.indexOf("<<<")+3,aa.length());
							}
						}
						count=Integer.parseInt(request.getParameter("i"));
						try{
							DBConn co = new DBConn();									
							conn = co.DBConOpen();
							PreparedStatement pst = null;	
							Statement stmt = null;
							stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
							conn.setAutoCommit(false);
							for(i=2;i<=count;i++){
								if(request.getParameter("chk"+i)!=null && !request.getParameter("chk"+i).equals("") && request.getParameter("chk"+i).equals("Y")){
								if(request.getParameter("enroll"+i)==null)
									enroll="";
								else
									enroll=request.getParameter("enroll"+i);
								if(request.getParameter("acad"+i)==null)
									acad="";
								else
									acad=request.getParameter("acad"+i);
								if(request.getParameter("progcode"+i)==null)
									progcode="";
								else
									progcode=request.getParameter("progcode"+i);
								if(request.getParameter("tagfor"+i)==null)
									tagfor="";
								else
									tagfor=request.getParameter("tagfor"+i);
								if(request.getParameter("secbranc"+i)==null)
									secbranc="";
								else
									secbranc=request.getParameter("secbranc"+i);
								if(request.getParameter("sem"+i)==null)
									sem="";
								else
									sem=request.getParameter("sem"+i);
								if(request.getParameter("semtype"+i)==null)
									semtype="";
								else
									semtype=request.getParameter("semtype"+i);
								if(request.getParameter("subseccode"+i)==null)
									subseccode="";
								else
									subseccode=request.getParameter("subseccode"+i);
								if(request.getParameter("subtype"+i)==null)
									subtype="";
								else
									subtype=request.getParameter("subtype"+i);								
								try{
								String qrybas="select decode(subjecttype,'C','A',Decode(nvl(ElectiveCode,'*'),'PD','B','E')) Basket,subjecttype,ElectiveCode from pr#studentsubjectchoice where INSTITUTECODE ='"+mInst+"' and examcode='"+mExamCode+"' and subjectid='"+mSubjectid+"' and studentid='"+enroll+"'";
								rsbas=db.getRowset(qrybas);
								if(rsbas.next()){
									basket=rsbas.getString("Basket");
								}
								}catch(Exception e){
									//out.println(e);
								}
								String qryprhod="SELECT * FROM PR#HODLOADDISTRIBUTION where INSTITUTECODE ='"+mInst+"' and COMPANYCODE ='"+compcode+"' and FACULTYTYPE='"+facultytype+"' and FACULTYID='"+facultyid+"' and EXAMCODE ='"+mExamCode+"' and ACADEMICYEAR='"+acad+"'  and PROGRAMCODE ='"+progcode+"' and TAGGINGFOR ='"+tagfor+"' and SECTIONBRANCH='"+secbranc+"' and SUBSECTIONCODE ='"+subseccode+"'  and SEMESTER ='"+sem+"' and SEMESTERTYPE='"+semtype+"'  and BASKET='"+basket+"' and SUBJECTID='"+mSubjectid+"' and LTP='"+mLTP+"'";
								//out.println(qryprhod);
								ResultSet rsprhod=db.getRowset(qryprhod);
								if(!rsprhod.next()){
									fstid=db.GenerateFSTID(mInst);
									String qryinst="update PR#HODLOADDISTRIBUTION set FACULTYTYPE='"+facultytype+"' , FACULTYID='"+facultyid+"',MERGEWITHFSTID='"+mergfstid+"',entryby='"+mChkMemID+"' ,entrydate=sysdate where INSTITUTECODE ='"+mInst+"' and COMPANYCODE ='"+compcode+"'  and EXAMCODE ='"+mExamCode+"' and ACADEMICYEAR='"+acad+"'  and PROGRAMCODE ='"+progcode+"' and TAGGINGFOR ='"+tagfor+"' and SECTIONBRANCH='"+secbranc+"' and SUBSECTIONCODE ='"+subseccode+"'  and SEMESTER ='"+sem+"' and SEMESTERTYPE='"+semtype+"'  and BASKET='"+basket+"' and SUBJECTID='"+mSubjectid+"' and LTP='"+mLTP+"'";										
									//out.println(qryinst+"<br>");
									stmt.addBatch(qryinst);									
								}
								String qryhpst="select nvl(L,'0') L,nvl(T,'0') T ,nvl(P,'0') P,nvl(COURSECREDITPOINT,0) COURSECREDITPOINT, nvl(NOOFSESSION,0) NOOFSESSION, nvl(COURSETYPE,'0') COURSETYPE  from programsubjecttagging where INSTITUTECODE='"+mInst+"' and  EXAMCODE='"+mExamCode+"' and ACADEMICYEAR='"+hacad+"' and PROGRAMCODE= '"+hprogram+"' and TAGGINGFOR='"+htagfor+"' and SECTIONBRANCH='"+hsecbranch+"' and SEMESTER='"+hsem+"' and BASKET='"+hbasket+"' and SUBJECTID='"+mSubjectid+"'";
									//out.println(qryhpst);
									ResultSet rsqryhpst=db.getRowset(qryhpst);	
									if(rsqryhpst.next())
									{
										String qryintpst="update programsubjecttagging set  L='"+rsqryhpst.getString("L")+"', T='"+rsqryhpst.getString("T")+"' , P='"+rsqryhpst.getString("P")+"',    COURSECREDITPOINT='"+rsqryhpst.getString("COURSECREDITPOINT")+"', NOOFSESSION='"+rsqryhpst.getString("NOOFSESSION")+"',    COURSETYPE='"+rsqryhpst.getString("COURSETYPE")+"' where INSTITUTECODE ='"+mInst+"' and  EXAMCODE='"+mExamCode+"' and ACADEMICYEAR='"+acad+"' and PROGRAMCODE= '"+progcode+"' and TAGGINGFOR='"+tagfor+"' and SECTIONBRANCH='"+secbranc+"' and SEMESTER='"+sem+"' and BASKET='"+basket+"' and SUBJECTID='"+mSubjectid+"' and nvl(deactive,'N')='N'";
										//out.println(qryintpst+"<br>");
											//stmt.addBatch(qryintpst);
									}
									/*String qrypsubsecchk="select * from  programsubsectiontagging where  INSTITUTECODE='"+mInst+"'		and  EXAMCODE='"+mExamCode+"' and ACADEMICYEAR= '"+acad+"' and PROGRAMCODE='"+progcode+"' and TAGGINGFOR='"+tagfor+"' and SECTIONBRANCH='"+secbranc+"' and SEMESTER ='"+sem+"' and SEMESTERTYPE='"+semtype+"' and  SUBSECTIONCODE='"+subseccode+"' and  SUBSECTIONTYPE='"+subtype+"'";
									ResultSet rssubsecchk=db.getRowset(qrypsubsecchk);	
									//out.println(qrypsubsecchk);
									if(!rssubsecchk.next())
									{
										String qryintsubsec="INSERT INTO PROGRAMSUBSECTIONTAGGING (INSTITUTECODE, EXAMCODE,ACADEMICYEAR, PROGRAMCODE, TAGGINGFOR, SECTIONBRANCH,SEMESTER, SEMESTERTYPE, SUBSECTIONCODE,SUBSECTIONTYPE, SECTIONCODE, DEACTIVE,ENTRYBY, ENTRYDATE, SEQID,SECTIONALLOCATED, SUBSECTIONALLOCATED, MAXSTUDENT) VALUES ( '"+mInst+"', '"+mExamCode+"' ,'"+acad+"' , '"+progcode+"', '"+tagfor+"', '"+secbranc+"', '"+sem+"', '"+semtype+"','"+subseccode+"' , '"+subtype+"','' ,'' , '"+mChkMemID+"' ,sysdate ,'' ,'' , '','' )";
										//out.println(qryintsubsec+"<br>");
										stmt.addBatch(qryintsubsec);
									}*/
									if(mLTP.equals("L")){
										String qryupdateL="UPDATE PR#STUDENTSUBJECTCHOICE SET  LFSTID='"+mergfstid+"' where INSTITUTECODE='"+mInst+"' and  EXAMCODE='"+mExamCode+"' and  ACADEMICYEAR='"+acad+"' and PROGRAMCODE='"+progcode+"' and TAGGINGFOR='"+tagfor+"' and  SECTIONBRANCH='"+secbranc+"' and  SEMESTER='"+sem+"' and  SEMESTERTYPE='"+semtype+"' and STUDENTID='"+enroll+"' and SUBJECTID='"+mSubjectid+"' and  SUBJECTTYPE='"+subtype+"'  ";
										//out.println(qryupdateL+"<br>");
										stmt.addBatch(qryupdateL);
									}else if(mLTP.equals("T")){
										String qryupdateT="UPDATE PR#STUDENTSUBJECTCHOICE SET TFSTID='"+mergfstid+"' where INSTITUTECODE='"+mInst+"' and  EXAMCODE='"+mExamCode+"' and  ACADEMICYEAR='"+acad+"' and PROGRAMCODE='"+progcode+"' and TAGGINGFOR='"+tagfor+"' and  SECTIONBRANCH='"+secbranc+"' and  SEMESTER='"+sem+"' and  SEMESTERTYPE='"+semtype+"' and STUDENTID='"+enroll+"' and SUBJECTID='"+mSubjectid+"' and  SUBJECTTYPE='"+subtype+"'  ";
										//out.println(qryupdateT);
										stmt.addBatch(qryupdateT);
									}else if(mLTP.equals("P")){
										String qryupdateP="UPDATE PR#STUDENTSUBJECTCHOICE SET  PFSTID= '"+mergfstid+"' where INSTITUTECODE='"+mInst+"' and  EXAMCODE='"+mExamCode+"' and  ACADEMICYEAR='"+acad+"' and PROGRAMCODE='"+progcode+"' and TAGGINGFOR='"+tagfor+"' and  SECTIONBRANCH='"+secbranc+"' and  SEMESTER='"+sem+"' and  SEMESTERTYPE='"+semtype+"' and STUDENTID='"+enroll+"' and SUBJECTID='"+mSubjectid+"' and  SUBJECTTYPE='"+subtype+"' ";
										stmt.addBatch(qryupdateP);
										//out.println(qryupdateP);
									}								
							}
							int updateCounts[] = stmt.executeBatch();							
							jj++;
							conn.commit();
						}					

						if(jj >0)
						{
						//	out.print("<br><img src='../../Images/Error1.jpg'>");
							out.print(" <br><center> <b><font size=3 face='Arial' color='Red'> Record Edit Successfully......</font></center>");

						}
					}
					catch(Exception e){
						//out.println(e);
						out.print(" <br><center> <b><font size=3 face='Arial' color='Red'> Please select all options ....</font></center><br>	<br>	<br>	<br>");
						conn.rollback();
						conn.close();
					}
					finally{
						conn.close();
					}
					
				}
				else{
					out.print("<br><center> <b><font size=3 face='Arial' color='Red'> Please Select Atleast One Student and Regular Batch ....</font></center>");
				}
			}
				if(request.getParameter("subjectid")!=null && request.getParameter("studentid")!=null && request.getParameter("mLTP")!=null  )
				{
					%><br>
					<TABLE border='1' align="center" class="sort-table" id="table-1" width="70%">
					<tr bgcolor="#ff8c00">
						<TD align="center"><B>Students (SAP and RWJ)</B></TD>
						<TD align="center"><B>Regular Batches</B> </TD>
					</tr>
					<tr>	
						<TD width="50%" valign="top">
							<TABLE border='1' width="100%" class="sort-table" id="table-1" cellpadding=1 cellspacing=0>
							<tr bgcolor="#ff8c00">
								<!-- <TD><CENTER><B>--</B></CENTER><INPUT TYPE="checkbox" NAME="chk1" onclick="checkall();"></TD> -->
								<TD><B>EnRoll</B></TD>
								<TD><B>Stud. Name</B></TD>
								<TD><B>Pro<br>Code</B></TD>
								<TD><B>Branch <br>Code</B></TD>
								<TD><B>Sem</B></TD>
								<TD><B>Sub<br>Sec</B></TD>
								<TD><B>Sem<br> Type</B></TD>							
							</TR>
								<%
								
								String disabled="";
								
					
								qry="SELECT a.studentid,ENROLLMENTNO, STUDENTNAME, a.PROGRAMCODE PROGRAMCODE,B.BRANCHCODE BRANCHCODE,a.SEMESTER SEMESTER, b.SUBSECTIONCODE SUBSECTIONCODE,SEMESTERTYPE,nvl(B.SECTIONCODE,'&nbsp;') SECTIONCODE,a.ACADEMICYEAR ACADEMICYEAR,a.TAGGINGFOR TAGGINGFOR,SECTIONBRANCH,a.subsectioncode subsectioncode,a.SUBJECTTYPE SUBJECTTYPE FROM PR#STUDENTSUBJECTCHOICE A, STUDENTMASTER B WHERE A.SUBJECTID ='"+request.getParameter("subjectid")+"' AND A.STUDENTID = B.STUDENTID AND A.EXAMCODE = '"+mExamCode+"' AND A.SEMESTERTYPE IN ('RWJ', 'SAP') AND A.SUBJECTRUNNING = 'Y' AND NVL (A.DEACTIVE, 'N') = 'N' AND NVL (B.DEACTIVE, 'N') = 'N' and a.InstituteCode='"+mInst+"' and a.InstituteCode=b.InstituteCode and a.studentid='"+request.getParameter("studentid")+"' order by PROGRAMCODE,BRANCHCODE,semester,a.SUBSECTIONCODE ";
								rs=db.getRowset(qry);
								//out.println(qry);
								while(rs.next())	
								{
									String checkqry="";
									if(mLTP.equals("L"))
									{
										checkqry="Select LFSTID LTPFSTID from PR#STUDENTSUBJECTCHOICE A WHERE A.SUBJECTID ='"+request.getParameter("subjectid")+"'  AND A.EXAMCODE = '"+mExamCode+"' AND A.SEMESTERTYPE IN ('RWJ', 'SAP') AND A.SUBJECTRUNNING = 'Y' AND NVL (A.DEACTIVE, 'N') = 'N' and a.InstituteCode='"+mInst+"'  and  studentid= (select studentid from studentmaster where ENROLLMENTNO='"+rs.getString("ENROLLMENTNO")+"' AND InstituteCode='"+mInst+"' and nvl(deactive,'N')='N') ";
									}else if(mLTP.equals("T"))
									{
										checkqry="Select TFSTID LTPFSTID from PR#STUDENTSUBJECTCHOICE A WHERE A.SUBJECTID ='"+request.getParameter("subjectid")+"'  AND A.EXAMCODE = '"+mExamCode+"' AND A.SEMESTERTYPE IN ('RWJ', 'SAP') AND A.SUBJECTRUNNING = 'Y' AND NVL (A.DEACTIVE, 'N') = 'N' and a.InstituteCode='"+mInst+"'  and  studentid= (select studentid from studentmaster where ENROLLMENTNO='"+rs.getString("ENROLLMENTNO")+"' AND InstituteCode='"+mInst+"' and nvl(deactive,'N')='N') ";
									}else if(mLTP.equals("P"))
									{
										checkqry="Select PFSTID LTPFSTID from PR#STUDENTSUBJECTCHOICE A WHERE A.SUBJECTID ='"+request.getParameter("subjectid")+"'  AND A.EXAMCODE = '"+mExamCode+"' AND A.SEMESTERTYPE IN ('RWJ', 'SAP') AND A.SUBJECTRUNNING = 'Y' AND NVL (A.DEACTIVE, 'N') = 'N' and a.InstituteCode='"+mInst+"'  and  studentid= (select studentid from studentmaster where ENROLLMENTNO='"+rs.getString("ENROLLMENTNO")+"' AND InstituteCode='"+mInst+"' and nvl(deactive,'N')='N') ";
									}
									//out.println("11"+checkqry);									
									ResultSet rscheckqry=db.getRowset(checkqry);
									if(rscheckqry.next())
									{
										disabled="";
										LTPFstid=rscheckqry.getString("LTPFSTID");
									}
									else
									{
										disabled="disabled";
										LTPFstid=rscheckqry.getString("LTPFSTID");
										
									}
									//out.println(disabled);
									
									%>	<%++i;%>
										<INPUT TYPE="hidden" NAME="enroll<%=i%>" value=<%=rs.getString("studentid")%>>
										<INPUT TYPE="hidden" NAME="acad<%=i%>" value=<%=rs.getString("ACADEMICYEAR")%>>
										<INPUT TYPE="hidden" NAME="progcode<%=i%>" value=<%=rs.getString("PROGRAMCODE")%>>
										<INPUT TYPE="hidden" NAME="tagfor<%=i%>" value=<%=rs.getString("TAGGINGFOR")%>>
										<INPUT TYPE="hidden" NAME="secbranc<%=i%>" value=<%=rs.getString("SECTIONBRANCH")%>>
										<INPUT TYPE="hidden" NAME="sem<%=i%>" value=<%=rs.getString("SEMESTER")%>>
										<INPUT TYPE="hidden" NAME="semtype<%=i%>" value=<%=rs.getString("SEMESTERTYPE")%>>
										<INPUT TYPE="hidden" NAME="subseccode<%=i%>" value=<%=rs.getString("subsectioncode")%>>
										<INPUT TYPE="hidden" NAME="subtype<%=i%>" value=<%=rs.getString("SUBJECTTYPE")%>>
											
										<TR>
										<!-- <TD> -->
										
										
										<INPUT TYPE="hidden" NAME="chk<%=i%>" value="Y" <%=disabled%> >
										
										
										
										<!-- </TD> -->
										<TD><%=rs.getString("ENROLLMENTNO")%></TD>
										<TD><%=rs.getString("STUDENTNAME")%></TD>
										<TD><%=rs.getString("PROGRAMCODE")%></TD>
										<TD><%=rs.getString("BRANCHCODE")%></TD>
										<TD><%=rs.getString("SEMESTER")%></TD>
										<TD><%=rs.getString("SUBSECTIONCODE")%></TD>
										<TD><%=rs.getString("SEMESTERTYPE")%></TD>
										<!-- <TD><%//=rs.getString("SECTIONCODE")%></TD> -->
										</TR>
									<%
								}
								%>
							</TABLE>
						</TD>
						<TD width="50%" valign="TOP"><TABLE border='1' width="100%" class="sort-table" id="table-1">
							<tr bgcolor="#ff8c00">
								<TD>&nbsp;</TD>
								<TD><B>Pro<br>Code</B></TD>
								<TD><B>Sec<br> Branch</B></TD>
								<TD><B>Sub<br>Sect</B></TD>
								<TD><B>Sem</B></TD>
								<TD><B>Count<br>(Stud)</B></TD>
							</TR>
							
								<%
								qry="SELECT programcode, sectionbranch, subsectioncode, semester,ACADEMICYEAR,semestertype,fstid, companycode,facultyid,facultytype,ltp,basket,TAGGINGFOR,DEPARTMENTRUNNIG,SUBJECTTYPE,nvl(ELECTIVECODE,' ')ELECTIVECODE,NOOFCLASSINAWEEK,DURATIONOFCLASS FROM pr#hodloaddistribution WHERE subjectid = '"+request.getParameter("subjectid")+"'   AND examcode = '"+mExamCode+"'   AND ltp = '"+request.getParameter("mLTP")+"' and InstituteCode='"+mInst+"' and nvl(MERGEWITHFSTID,'N')='N' and semestertype='REG' and companycode='"+mComp+"' order by programcode,sectionbranch,subsectioncode,semester";	
								//out.println(qry);
								rs=db.getRowset(qry);
								while(rs.next())	
								{
									String aa=rs.getString("fstid")+"!!!"+rs.getString("companycode")+"@@@"+rs.getString("facultyid")+"###"+rs.getString("facultytype")+"$$$"+rs.getString("ltp")+"^^^"+rs.getString("ACADEMICYEAR")+"&&&"+rs.getString("programcode")+"```"+rs.getString("sectionbranch")+"~~~"+rs.getString("semester")+">>>"+rs.getString("basket")+"???"+rs.getString("TAGGINGFOR")+"+++"+rs.getString("DEPARTMENTRUNNIG")+"___"+rs.getString("SUBJECTTYPE")+"---"+rs.getString("ELECTIVECODE")+"///"+rs.getString("NOOFCLASSINAWEEK")+"<<<"+rs.getString("DURATIONOFCLASS");
									%>	<TR>
										<%
										String qrycheck="SELECT programcode, sectionbranch, subsectioncode, semester,ACADEMICYEAR,semestertype,fstid, companycode,facultyid,facultytype,ltp,basket,TAGGINGFOR,DEPARTMENTRUNNIG,SUBJECTTYPE,nvl(ELECTIVECODE,' ')ELECTIVECODE,NOOFCLASSINAWEEK,DURATIONOFCLASS FROM pr#hodloaddistribution WHERE subjectid = '"+request.getParameter("subjectid")+"'   AND examcode = '"+mExamCode+"'   AND ltp = '"+request.getParameter("mLTP")+"' and InstituteCode='"+mInst+"' and nvl(MERGEWITHFSTID,'N')='N' and semestertype='REG' and companycode='"+mComp+"' and fstid='"+LTPFstid+"' and programcode='"+rs.getString("programcode")+"' and sectionbranch ='"+rs.getString("sectionbranch")+"'  and subsectioncode='"+rs.getString("subsectioncode")+"' and  semester='"+rs.getString("semester")+"'";	
										//out.println(qrycheck);
										ResultSet rschk=db.getRowset(qrycheck);
										//out.println(qrycheck);
										if(rschk.next()){
										%>	
										<TD><INPUT TYPE="radio" NAME="regbatch" value="<%=aa%>" checked></TD>
										<%}else{%>
										<TD><INPUT TYPE="radio" NAME="regbatch" value="<%=aa%>" ></TD>
										<%}%>
										<TD><%=rs.getString("programcode")%></TD>
										<TD><%=rs.getString("sectionbranch")%></TD>
										<TD><%=rs.getString("subsectioncode")%></TD>
										<TD><%=rs.getString("semester")%></TD>
										<%
										String qryinn="select count(distinct studentid)aa From PR#STUDENTSUBJECTCHOICE where institutecode='"+mInst+"' and subjectid='"+mSubjectid+"' and semestertype='REG' and nvl(deactive,'N')='N' and EXAMCODE =  '"+mExamCode+"' and sectionbranch='"+rs.getString("sectionbranch")+"' and programcode='"+rs.getString("programcode")+"' and subsectioncode='"+rs.getString("subsectioncode")+"' and semester= '"+rs.getString("semester")+"' and ACADEMICYEAR='"+rs.getString("ACADEMICYEAR")+"' and semestertype='"+rs.getString("semestertype")+"' AND NVL (subjectrunning, 'N') = 'Y' AND subsectioncode IS NOT NULL";
										//out.println(qryinn);
										ResultSet rsinn=db.getRowset(qryinn);										
										if(rsinn.next()){%>
										<TD>&nbsp;<%=rsinn.getString("aa")%></TD>
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
					<center><INPUT TYPE="submit" name="save" value="Save">&nbsp;&nbsp;<INPUT TYPE="button" name="closed" value="Closed Page" onclick="window.close();"></center>
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