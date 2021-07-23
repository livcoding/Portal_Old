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
<TITLE>#### <%=mHead%> [ Old Student  v/s New Subject [Load Distribution] ] </TITLE>
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
function check(){
/*alert(document.frm1.subjects2.value);
alert(document.frm1.subjects.value);*/

if(document.frm1.subjects2.value == document.frm1.subjects.value)
{
	alert("Please select different subjects in Subject-I and Subject -II");
	return false;
}

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
String qry="",qry1="",mWebEmail="",EmpIDType="",fstid="",mLoginComp="";
String elecCode="";
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
String mComp="", mInst="";
String mSem="";
String mExamCode="",mProg="",mBranch="",mName="";
String mEmployeeID="",mLTP="",mSubjectid="",mSubjectid2="";
String enroll="",acad="",progcode="",tagfor="",secbranc="",sem="",semtype="",subseccode="",basket="",mergfstid="",compcode="",facultyid="",facultytype="";
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
			qry="Select  nvl(PREREGEXAMID,' ') Exam from CompanyInstituteTagging where CompanyCode='"+mLoginComp+"' and InstituteCode='"+mInst+"' and PREREGEXAMID is not null";
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
						<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana"><U>Old Student  v/s New Subject [Load Distribution]</U></TD></font>
					</tr>
				</TABLE><br>
				<table cellpadding=1 cellspacing=0 width="95%" align=center rules=groups border=3>
					<tr>			
						<td><FONT color=black><FONT face=Arial size=2><STRONG>&nbsp;&nbsp;Exam Code&nbsp;&nbsp;</STRONG></FONT></FONT></td>
						<td>
							<select name=Exam tabindex="0" id="Exam" style="WIDTH: 120px">	
								<OPTION Value =<%=mExamCode%>><%=mExamCode%></option>						
						</td>
						<td><FONT color=black><FONT face=Arial size=2><STRONG>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Old Sub &nbsp;&nbsp;</STRONG></FONT></FONT>
						</td>
						<td>
						<%
							if(request.getParameter("x")==null)
								mSubjectid="";
							else
								mSubjectid=request.getParameter("subjects");
							//qry="SELECT DISTINCT a.subjectid subjectid,b.subject || ' (' || b.subjectcode || ')' subject FROM pr#studentsubjectchoice a, subjectmaster b WHERE a.examcode = '"+mExamCode+"' AND NVL (a.deactive, 'N') = 'N' AND NVL (b.deactive, 'N') = 'N' AND a.subjectid = b.subjectid and a.InstituteCode='"+mInst+"' and a.InstituteCode=b.InstituteCode order by subject";

							qry="SELECT DISTINCT a.subjectid subjectid,b.subject || ' (' || b.subjectcode || ')' subject FROM pr#studentsubjectchoice a, subjectmaster b WHERE a.examcode = '"+mExamCode+"' and SEMESTERTYPE in ('SAP','RWJ') AND NVL (a.deactive, 'N') = 'N' AND NVL (b.deactive, 'N') = 'N' AND a.subjectid = b.subjectid and a.InstituteCode='"+mInst+"' and a.InstituteCode=b.InstituteCode order by subject";
							rs=db.getRowset(qry);
						//out.println(qry);
						%>
							<select name="subjects" tabindex="0" id="subjects" style="WIDTH: 480px">
							<%

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
						<td><FONT color=black><FONT face=Arial size=2><STRONG>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;New Sub&nbsp;&nbsp;</STRONG></FONT></FONT>
						</td>
						<td>
						<%
							if(request.getParameter("x")==null)
								mSubjectid2="";
							else
								mSubjectid2=request.getParameter("subjects2");
						%>
							<select name="subjects2" tabindex="0" id="subjects2" style="WIDTH: 480px">
							<%
							//qry="SELECT DISTINCT a.subjectid subjectid,b.subject || ' (' || b.subjectcode || ')' subject FROM pr#studentsubjectchoice a, subjectmaster b WHERE a.examcode = '"+mExamCode+"' AND NVL (a.deactive, 'N') = 'N' AND NVL (b.deactive, 'N') = 'N' AND a.subjectid = b.subjectid and a.InstituteCode='"+mInst+"' and a.InstituteCode=b.InstituteCode order by subject";

							qry="SELECT DISTINCT a.subjectid subjectid,b.subject || ' (' || b.subjectcode || ')' subject FROM pr#studentsubjectchoice a, subjectmaster b WHERE a.examcode = '"+mExamCode+"' AND NVL (a.deactive, 'N') = 'N' AND NVL (b.deactive, 'N') = 'N' AND a.subjectid = b.subjectid and a.InstituteCode='"+mInst+"' and SEMESTERTYPE='REG' AND a.InstituteCode=b.InstituteCode UNION 	SELECT a.subjectid subjectid,b.subject || ' (' || b.subjectcode || ')' subject FROM PROGRAMSUBJECTTAGGING a, subjectmaster b WHERE a.examcode = '"+mExamCode+"' AND NVL (a.deactive, 'N') = 'N' AND NVL (b.deactive, 'N') = 'N' AND a.subjectid = b.subjectid and a.InstituteCode='"+mInst+"'  AND a.InstituteCode=b.InstituteCode ORDER BY SUBJECT ";
							rs=db.getRowset(qry);
							//System.out.println(qry);
							while(rs.next()){
								if(!mSubjectid2.equals("") && mSubjectid2.equals(rs.getString("subjectid"))){
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
						<td align='center' colspan=4> <center><input type="submit" name="Ok" value="Ok" style="WIDTH:50px" onClick="return check();"/></center>
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
								String aa=request.getParameter("regbatch").trim();
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
						count=Integer.parseInt(request.getParameter("i").trim());
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
									enroll=request.getParameter("enroll"+i).trim();
								if(request.getParameter("acad"+i)==null)
									acad="";
								else
									acad=request.getParameter("acad"+i).trim();
								if(request.getParameter("progcode"+i)==null)
									progcode="";
								else
									progcode=request.getParameter("progcode"+i);
								if(request.getParameter("tagfor"+i)==null)
									tagfor="";
								else
									tagfor=request.getParameter("tagfor"+i).trim();
								if(request.getParameter("secbranc"+i)==null)
									secbranc="";
								else
									secbranc=request.getParameter("secbranc"+i).trim();
								if(request.getParameter("sem"+i)==null)
									sem="";
								else
									sem=request.getParameter("sem"+i).trim();
								if(request.getParameter("semtype"+i)==null)
									semtype="";
								else
									semtype=request.getParameter("semtype"+i)==null?"":request.getParameter("semtype"+i).trim();
								if(request.getParameter("subseccode"+i)==null)
									subseccode="";
								else
									subseccode=request.getParameter("subseccode"+i)==null?"":request.getParameter("subseccode"+i).trim();
								if(request.getParameter("subtype"+i)==null)
									subtype="";
								else
									subtype=request.getParameter("subtype"+i)==null?"":request.getParameter("subtype"+i).trim();								
								try{
								String qrybas="select decode(subjecttype,'C','A',Decode(nvl(ElectiveCode,'*'),'PD','B','E')) Basket,subjecttype,ElectiveCode from pr#studentsubjectchoice where INSTITUTECODE ='"+mInst+"' and examcode='"+mExamCode+"' and subjectid='"+mSubjectid+"' and studentid='"+enroll+"'";
								rsbas=db.getRowset(qrybas);
								//out.print(qrybas);
								if(rsbas.next())
								{
									basket=rsbas.getString("Basket")==null?"":rsbas.getString("Basket").trim();
									/*subtype=rs.getString("subjecttype");
									elecCode=rs.getString("ElectiveCode");*/
								}
								}catch(Exception e)
								{
									out.println(e);
								}
								
							
									
									
									if(1==1){
									
									String qryprhod="SELECT * FROM PR#HODLOADDISTRIBUTION where INSTITUTECODE ='"+mInst+"' and COMPANYCODE ='"+compcode+"' and FACULTYTYPE='"+facultytype+"' and FACULTYID='"+facultyid+"' and EXAMCODE ='"+mExamCode+"' and ACADEMICYEAR='"+acad+"'  and PROGRAMCODE ='"+progcode+"' and TAGGINGFOR ='"+tagfor+"' and SECTIONBRANCH='"+secbranc+"' and SUBSECTIONCODE ='"+subseccode+"'  and SEMESTER ='"+sem+"' and SEMESTERTYPE='"+semtype+"'  and BASKET='"+basket+"' and SUBJECTID='"+mSubjectid+"' and LTP='"+mLTP+"'";
									//out.println(qryprhod);
									ResultSet rsprhod=db.getRowset(qryprhod);
									if(!rsprhod.next()){
										fstid=db.GenerateFSTID(mInst);
										String qryinst="INSERT INTO PR#HODLOADDISTRIBUTION (   INSTITUTECODE, COMPANYCODE, FACULTYTYPE, FACULTYID, EXAMCODE, ACADEMICYEAR,    PROGRAMCODE, TAGGINGFOR, SECTIONBRANCH,  SUBSECTIONCODE, SEMESTER, SEMESTERTYPE,    BASKET, SUBJECTID, LTP,    REQROOMTYPE, DEPARTMENTRUNNIG, DURATIONOFCLASS,    NOOFCLASSINAWEEK, STATUS, ENTRYBY,    ENTRYDATE, APPROVEDBY, APPROVEDDATE,    APPROVEREMARKS, FSTID, DEACTIVE,    MERGEWITHSECTIONBRANCH, MERGEWITHFSTID, SUBJECTTYPE,    ELECTIVECODE, MULTIFACULTY) VALUES (  '"+mInst+"', '"+compcode+"','"+facultytype+"' ,'"+facultyid+"', '"+mExamCode+"','"+acad+"' , '"+progcode+"','"+tagfor+"' , '"+secbranc+"', '"+subseccode+"', '"+sem+"','"+semtype+"' ,'"+basket+"', '"+mSubjectid+"' , '"+mLTP+"', '', '"+dept+"','"+mhr+"' , '"+mclass+"','D' , '"+mChkMemID+"', sysdate,'' ,'' ,'' , '"+fstid+"', '','','"+mergfstid+"' , '"+subtype+"','"+elecCode+"' ,'')";
										//out.println(qryinst+"<br>");
										stmt.addBatch(qryinst);
									
									}
									String qrypstchk="select * from programsubjecttagging where INSTITUTECODE ='"+mInst+"' and  EXAMCODE='"+mExamCode+"' and ACADEMICYEAR='"+acad+"' and PROGRAMCODE= '"+progcode+"' and TAGGINGFOR='"+tagfor+"' and SECTIONBRANCH='"+secbranc+"' and SEMESTER='"+sem+"' and BASKET='"+basket+"' and SUBJECTID='"+mSubjectid+"' and nvl(deactive,'N')='N'";
									//out.println(qrypstchk);
									ResultSet rspstchk=db.getRowset(qrypstchk);	
									if(!rspstchk.next()){
										String qryhpst="select nvl(L,'0') L,nvl(T,'0') T ,nvl(P,'0') P,nvl(COURSECREDITPOINT,0) COURSECREDITPOINT, nvl(NOOFSESSION,0) NOOFSESSION, nvl(COURSETYPE,'0') COURSETYPE  from programsubjecttagging where INSTITUTECODE='"+mInst+"' and  EXAMCODE='"+mExamCode+"' and ACADEMICYEAR='"+hacad+"' and PROGRAMCODE= '"+hprogram+"' and TAGGINGFOR='"+htagfor+"' and SECTIONBRANCH='"+hsecbranch+"' and SEMESTER='"+hsem+"' and BASKET='"+hbasket+"' and SUBJECTID='"+mSubjectid+"'";
										//out.println(qryhpst);
										ResultSet rsqryhpst=db.getRowset(qryhpst);	
										if(rsqryhpst.next())
										{
											String qryintpst="INSERT INTO programsubjecttagging (   INSTITUTECODE, EXAMCODE, ACADEMICYEAR,    PROGRAMCODE, TAGGINGFOR, SECTIONBRANCH,    SEMESTER, BASKET, SUBJECTID,    L, T, P,    COURSECREDITPOINT, DEACTIVE, NOOFSESSION,    COURSETYPE) VALUES ('"+mInst+"' , '"+mExamCode+"','"+acad+"' ,'"+progcode+"', '"+tagfor+"','"+secbranc+"' , '"+sem+"'   , '"+basket+"','"+mSubjectid+"' , '"+rsqryhpst.getString("L")+"'   ,'"+rsqryhpst.getString("T")+"' ,'"+rsqryhpst.getString("P")+"' ,'"+rsqryhpst.getString("COURSECREDITPOINT")+"'    ,'' ,'"+rsqryhpst.getString("NOOFSESSION")+"' , '"+rsqryhpst.getString("COURSETYPE")+"')";
											//out.println(qryintpst+"<br>");
											stmt.addBatch(qryintpst);
										}
									}									
									String qrypsubsecchk="select 'Y' from  programsubsectiontagging where  INSTITUTECODE='"+mInst+"'		and  EXAMCODE='"+mExamCode+"' and ACADEMICYEAR= '"+acad+"' and PROGRAMCODE='"+progcode+"' and TAGGINGFOR='"+tagfor+"' and SECTIONBRANCH='"+secbranc+"' and SEMESTER ='"+sem+"' and SEMESTERTYPE='"+semtype+"' and  SUBSECTIONCODE='"+subseccode+"' and  SUBSECTIONTYPE='"+subtype+"'";
									ResultSet rssubsecchk=db.getRowset(qrypsubsecchk);	
									//out.println(qrypsubsecchk);
									if(!rssubsecchk.next())
									{
										String qryintsubsec="INSERT INTO PROGRAMSUBSECTIONTAGGING (INSTITUTECODE, EXAMCODE,ACADEMICYEAR, PROGRAMCODE, TAGGINGFOR, SECTIONBRANCH,SEMESTER, SEMESTERTYPE, SUBSECTIONCODE,SUBSECTIONTYPE, SECTIONCODE, DEACTIVE,ENTRYBY, ENTRYDATE, SEQID,SECTIONALLOCATED, SUBSECTIONALLOCATED, MAXSTUDENT) VALUES ( '"+mInst+"', '"+mExamCode+"' ,'"+acad+"' , '"+progcode+"', '"+tagfor+"', '"+secbranc+"', '"+sem+"', '"+semtype+"','"+subseccode+"' , '"+subtype+"','' ,'' , '"+mChkMemID+"' ,sysdate ,'' ,'' , '','' )";
										//out.println(qryintsubsec+"<br>");
										stmt.addBatch(qryintsubsec);
									}
									if(mLTP.equals("L")){
										String qryupdateL="UPDATE PR#STUDENTSUBJECTCHOICE SET  LFSTID='"+mergfstid+"' where INSTITUTECODE='"+mInst+"' and  EXAMCODE='"+mExamCode+"' and  ACADEMICYEAR='"+acad+"' and PROGRAMCODE='"+progcode+"' and TAGGINGFOR='"+tagfor+"' and  SECTIONBRANCH='"+secbranc+"' and  SEMESTER='"+sem+"' and  SEMESTERTYPE='"+semtype+"' and STUDENTID='"+enroll+"' and SUBJECTID='"+mSubjectid+"' and  SUBJECTTYPE='"+subtype+"'  ";
										//out.println(qryupdateL+"<br>");
										//int n =db.update(qryupdateL);
										stmt.addBatch(qryupdateL);
									}else if(mLTP.equals("T")){
										String qryupdateT="UPDATE PR#STUDENTSUBJECTCHOICE SET TFSTID='"+mergfstid+"' where INSTITUTECODE='"+mInst+"' and  EXAMCODE='"+mExamCode+"' and  ACADEMICYEAR='"+acad+"' and PROGRAMCODE='"+progcode+"' and TAGGINGFOR='"+tagfor+"' and  SECTIONBRANCH='"+secbranc+"' and  SEMESTER="+sem+" and  SEMESTERTYPE='"+semtype+"' and STUDENTID='"+enroll+"' and SUBJECTID='"+mSubjectid+"' and  SUBJECTTYPE='"+subtype+"'  ";
										//out.println(qryupdateT);
										//int m =db.pdate(qryupdateT);
										stmt.addBatch(qryupdateT);
									}else if(mLTP.equals("P")){
										String qryupdateP="UPDATE PR#STUDENTSUBJECTCHOICE SET  PFSTID= '"+mergfstid+"' where INSTITUTECODE='"+mInst+"' and  EXAMCODE='"+mExamCode+"' and  ACADEMICYEAR='"+acad+"' and PROGRAMCODE='"+progcode+"' and TAGGINGFOR='"+tagfor+"' and  SECTIONBRANCH='"+secbranc+"' and  SEMESTER='"+sem+"' and  SEMESTERTYPE='"+semtype+"' and STUDENTID='"+enroll+"' and SUBJECTID='"+mSubjectid+"' and  SUBJECTTYPE='"+subtype+"' ";
										//int g =db.Update(qryupdateP);
										stmt.addBatch(qryupdateP);
										
										//out.println(qryupdateP);
									}
								}
							}
							int updateCounts[] = stmt.executeBatch();							
							jj++;
							conn.commit();
						}					

						if(jj >0)
						{
						//	out.print("<br><img src='../../Images/Error1.jpg'>");
							out.print(" <br><center> <b><font size=3 face='Arial' color='Red'> Record Saved Successfully......</font></center>");

						}
					}
					catch(Exception e){
						out.println(e);
						out.print(" <br><center> <b><font size=3 face='Arial' color='Red'> Please select all options ....</font></center><br>	<br>	<br>	<br>");
						conn.rollback();
						conn.commit();
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
				if(request.getParameter("x")!=null)
				{
					%><br>
					<TABLE border='1' align="center" class="sort-table" id="table-1" width="70%">
					<tr bgcolor="#ff8c00">
						<TD align="center"><B>Students in Subject I</B></TD>
						<TD align="center"><B>Regular Batches for Subject II</B> </TD>
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
								<TD><B>Edit</B></TD> 
							</TR>
								<%
								
								String disabled="";
								
					
								qry="SELECT distinct a.studentid studentid,ENROLLMENTNO, STUDENTNAME, a.PROGRAMCODE PROGRAMCODE,B.BRANCHCODE BRANCHCODE,a.SEMESTER SEMESTER, b.SUBSECTIONCODE SUBSECTIONCODE,SEMESTERTYPE,nvl(B.SECTIONCODE,'&nbsp;') SECTIONCODE,a.ACADEMICYEAR ACADEMICYEAR,a.TAGGINGFOR TAGGINGFOR,SECTIONBRANCH,a.subsectioncode subsectioncode,a.SUBJECTTYPE SUBJECTTYPE FROM PR#STUDENTSUBJECTCHOICE A, STUDENTMASTER B WHERE A.SUBJECTID ='"+mSubjectid+"' AND A.STUDENTID = B.STUDENTID AND A.EXAMCODE = '"+mExamCode+"'  AND A.SUBJECTRUNNING = 'Y' AND NVL (A.DEACTIVE, 'N') = 'N' AND NVL (B.DEACTIVE, 'N') = 'N' and a.InstituteCode='"+mInst+"' and a.InstituteCode=b.InstituteCode order by PROGRAMCODE,BRANCHCODE,semester,a.SUBSECTIONCODE";
								rs=db.getRowset(qry);
								//out.println(qry);
								while(rs.next())	
								{
									String checkqry="";
									if(mLTP.equals("L"))
									{
										checkqry="Select 'Y' from PR#STUDENTSUBJECTCHOICE A WHERE A.SUBJECTID ='"+mSubjectid+"'  AND A.EXAMCODE = '"+mExamCode+"' AND A.SUBJECTRUNNING = 'Y' AND NVL (A.DEACTIVE, 'N') = 'N' and a.InstituteCode='"+mInst+"' AND NVL (lfstid, 'N') = 'N' and  studentid in (select studentid from studentmaster where ENROLLMENTNO='"+rs.getString("ENROLLMENTNO")+"' and nvl(deactive,'N')='N' and InstituteCode='"+mInst+"') ";
									}else if(mLTP.equals("T"))
									{
										checkqry="Select 'Y' from PR#STUDENTSUBJECTCHOICE A WHERE A.SUBJECTID ='"+mSubjectid+"'  AND A.EXAMCODE = '"+mExamCode+"' AND A.SUBJECTRUNNING = 'Y' AND NVL (A.DEACTIVE, 'N') = 'N' and a.InstituteCode='"+mInst+"' and NVL (tfstid, 'N') = 'N' and  studentid in (select studentid from studentmaster where ENROLLMENTNO='"+rs.getString("ENROLLMENTNO")+"' and nvl(deactive,'N')='N' and InstituteCode='"+mInst+"') ";
									}else if(mLTP.equals("P"))
									{
										checkqry="Select 'Y' from PR#STUDENTSUBJECTCHOICE A WHERE A.SUBJECTID ='"+mSubjectid+"'  AND A.EXAMCODE = '"+mExamCode+"' AND  A.SUBJECTRUNNING = 'Y' AND NVL (A.DEACTIVE, 'N') = 'N' and a.InstituteCode='"+mInst+"' and NVL (pfstid, 'N') = 'N' and  studentid in  (select studentid from studentmaster where ENROLLMENTNO='"+rs.getString("ENROLLMENTNO")+"' and nvl(deactive,'N')='N' and  InstituteCode='"+mInst+"') ";

									}
									//out.println("11"+checkqry);	
									
									ResultSet rscheckqry=db.getRowset(checkqry);
									if(rscheckqry.next())
									{
										disabled="";
										
									}
									else
									{
										disabled="disabled";
										
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
										<TD>
										
										
										<INPUT TYPE="checkbox" NAME="chk<%=i%>" onclick="singlecheck();" value="Y" <%=disabled%> >
										
										
										
										</TD>
										<TD><CENTER><%=rs.getString("ENROLLMENTNO")%></CENTER></TD>
										<TD><CENTER><%=rs.getString("STUDENTNAME")%></CENTER></TD>
										<TD><CENTER><%=rs.getString("PROGRAMCODE")%></CENTER></TD>
										<TD><CENTER><%=rs.getString("BRANCHCODE")%></CENTER></TD>
										<TD><CENTER><%=rs.getString("SEMESTER")%></CENTER></TD>
										<TD><CENTER><%=rs.getString("SUBSECTIONCODE")%></CENTER></TD>
										<TD><CENTER><%=rs.getString("SEMESTERTYPE")%></CENTER></TD>
										<!--  <TD><%//=rs.getString("SECTIONCODE")%></TD -->
										
										<%if(disabled.equals("")){%>
										<TD><B>--</B></TD>
										<%}else{%>
										 <TD><B><a href='editBackLogStudLoadDistributionII.jsp?mLTP=<%=mLTP%>&examcode=<%=mExamCode%>&subjectid=<%=mSubjectid%>&studentid=<%=rs.getString("studentid")%>&subjectid2=<%=mSubjectid2%>' target="_new">Edit</a></B></TD> 
										<%}%>
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
								qry="SELECT programcode, sectionbranch, subsectioncode, semester,ACADEMICYEAR,semestertype,fstid, companycode,facultyid,facultytype,ltp,basket,TAGGINGFOR,DEPARTMENTRUNNIG,SUBJECTTYPE,nvl(ELECTIVECODE,' ')ELECTIVECODE,NOOFCLASSINAWEEK,DURATIONOFCLASS FROM pr#hodloaddistribution WHERE subjectid = '"+mSubjectid2+"'   AND examcode = '"+mExamCode+"'   AND ltp = '"+mLTP+"' and InstituteCode='"+mInst+"' and nvl(MERGEWITHFSTID,'N')='N' and semestertype='REG' and companycode='"+mComp+"' order by programcode,sectionbranch,subsectioncode,semester";	
								//out.println(qry);
								rs=db.getRowset(qry);
								while(rs.next())	
								{
									String aa=rs.getString("fstid")+"!!!"+rs.getString("companycode")+"@@@"+rs.getString("facultyid")+"###"+rs.getString("facultytype")+"$$$"+rs.getString("ltp")+"^^^"+rs.getString("ACADEMICYEAR")+"&&&"+rs.getString("programcode")+"```"+rs.getString("sectionbranch")+"~~~"+rs.getString("semester")+">>>"+rs.getString("basket")+"???"+rs.getString("TAGGINGFOR")+"+++"+rs.getString("DEPARTMENTRUNNIG")+"___"+rs.getString("SUBJECTTYPE")+"---"+rs.getString("ELECTIVECODE")+"///"+rs.getString("NOOFCLASSINAWEEK")+"<<<"+rs.getString("DURATIONOFCLASS");
									%>	<TR>
										<TD><INPUT TYPE="radio" NAME="regbatch" value="<%=aa%>"></TD>
										<TD><CENTER><%=rs.getString("programcode")%></CENTER></TD>
										<TD><CENTER><%=rs.getString("sectionbranch")%></CENTER></TD>
										<TD><CENTER><%=rs.getString("subsectioncode")%></CENTER></TD>
										<TD><CENTER><%=rs.getString("semester")%></CENTER></TD>
										<%
										String qryinn="select count(distinct studentid)aa From PR#STUDENTSUBJECTCHOICE where institutecode='"+mInst+"' and subjectid='"+mSubjectid2+"' and semestertype='REG' and nvl(deactive,'N')='N' and EXAMCODE =  '"+mExamCode+"' and sectionbranch='"+rs.getString("sectionbranch")+"' and programcode='"+rs.getString("programcode")+"' and subsectioncode='"+rs.getString("subsectioncode")+"' and semester= '"+rs.getString("semester")+"' and ACADEMICYEAR='"+rs.getString("ACADEMICYEAR")+"' and semestertype='"+rs.getString("semestertype")+"' AND NVL (subjectrunning, 'N') = 'Y' AND subsectioncode IS NOT NULL";
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