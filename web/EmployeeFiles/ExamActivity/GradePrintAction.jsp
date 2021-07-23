<%--
    Document   : GradeCalculationsupple
    Created on : 23 Dec, 2017, 2:54:03 PM
    Author     : VIVEK.SONI
    Modification Weightage Hard Coded to 100
--%>
<!--Date 13.01.2018  -->



<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String qry="";
ResultSet rs=null;
String qrys="";
ResultSet rss=null;
ResultSet rss1=null;
int mSno1=0;
String mNames=""; 
double mfinalmarks=0;
DBHandler db=new DBHandler();
String mInst="",mDefault="";
int ctr=0;
String mHead="";
String mysubjcode="",mETOD="",mDet="";
String qrysub="",mNam="",mSc="",mCheckFstid="",mWeightageInit="",qry2="",qryi=""; 
ResultSet rssub=null,rs2=null,rsi=null;



if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";

%>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) 
  top.document.title = document.title;
//-->
</script>
<script language=javascript>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
<script language=javascript>
	<!--
	function RefreshContents()
	{ 	
    	    document.frm.x.value='ddd';
    	    document.frm.submit();
	}
//-->
</script>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
try
{
OLTEncryption enc=new OLTEncryption();
int mFlag=0;
String  mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="",mDept="";
String mECode="",mecode="";
int mSno=0,mDebarCount=0;
String mName="";
String mSCode="",mscode="";
String mEC="",mSC="";
String mName1="";
String status="Y";
String qryhead="";
ResultSet rshead=null;
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
if (session.getAttribute("MemberName")==null)
{
	mMemberName="";
}
else
{
	mMemberName=session.getAttribute("MemberName").toString().trim();
}
if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
}
if (session.getAttribute("Department")==null)
{
	mDept="";
}
else
{
	mDept=session.getAttribute("Department").toString().trim();
}

if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
	{
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());

	mEC=request.getParameter("ExamCode");
			mSC=request.getParameter("Subject");
			mETOD=request.getParameter("ETOD");
		String bno=request.getParameter("bno");
        //status=request.getParameter("status");
		//out.print(status);
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
        //---------(Added By Satendra)----------//

        qryhead="";
        qryhead= "  select 'Y' from EXAMEVENTSUBJECTTAGGING where nvl(locked,'N')='N' and  fstid IN ( select distinct fstid from ( select distinct fstid from ";
					qryhead=qryhead+" facultysubjecttagging aa where institutecode='"+mInst+"' and examcode='"+mEC+"' ";
					qryhead=qryhead+" and employeeid='"+mChkMemID+"' and (LTP='L' or ( LTP='P' and exists (select 1 from programsubjecttagging where examcode='"+mEC+"' and institutecode='"+mInst+"' and subjectid=aa.subjectid and L=0 and p>0 )) OR (LTP='P' and PROJECTSUBJECT='Y' and exists (select 1 from programsubjecttagging where examcode='"+mEC+"' and institutecode='"+mInst+"' and subjectid=aa.subjectid and L=0 and p>0 ))) and subjectID='"+mSC+"' ";//(LTP='L' or LTP='P' OR (LTP='P' and PROJECTSUBJECT='Y'))
					qryhead=qryhead+" union ";
					qryhead=qryhead+" select distinct fstid from V#EX#SUBJECTGRADECOORDINATOR where institutecode='"+mInst+"' and ";
					qryhead=qryhead+" examcode='"+mEC+"' and COORDINATORID='"+mChkMemID+"' and subjectID='"+mSC+"' ";
					qryhead=qryhead+" union ";
					qryhead=qryhead+" select distinct fstid from V#EXAMEVENTSUBJECTTAGGING WHERE institutecode='"+mInst+"' and ";
					qryhead=qryhead+" examcode='"+mDefault+"' and CORDFACULTYID='"+mChkMemID+"' and subjectID='"+mSC+"' AND NVL(DEACTIVE,'N')='N'";
					qryhead=qryhead+" MINUS ";
					qryhead=qryhead+" select distinct fstid from V#EX#SUBJECTGRADECOORDINATOR  ";
					qryhead=qryhead+" where   examcode='"+mEC+"' and employeeid='"+mChkMemID+"' and COORDINATORID<>'"+mChkMemID+"' and subjectID='"+mSC+"' )   )  ";
             rshead=db.getRowset(qryhead);
              //out.print(qryhead);
              if(rshead.next()) {

                  status="N";
               }
       //----------(Added By Satendra)----------//
	qry="Select WEBKIOSK.ShowLink('146','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
    RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{

		
/*qryi=" select 'Y' from exameventsubjecttagging where nvl(LOCKED,'N')='Y' and fstid  in (SELECT distinct B.FSTID   FROM STUDENTWISEGRADE A,V#STUDENTEVENTSUBJECTMARKS  B where A.BREAK#SLNO= '"+bno+"'  ";
qryi=qryi+" and A.INSTITUTECODE='"+mInst+"' and a.institutecode=b.institutecode AND A.FSTID=B.FSTID and A.EXAMCODE='"+mEC+"'  AND A.STUDENTID=B.STUDENTID AND NVL(A.DEACTIVE,'N')='N' )";
rsi=db.getRowset(qryi);
//out.print(qryi); */
//out.print(status);
if(status.equals("N")){

%><table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: large; FONT-FAMILY: fantasy"><b>Draft Saved Grade Sheet</b></TD>
</font></td></tr>
</TABLE><%
}else{
%><table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: large; FONT-FAMILY: fantasy"><b>Freezed Grade Sheet </b></TD>
</font></td></tr>
</TABLE><%
}

		
		
		
		//out.print(mSC);
		qrysub="select subject,SUBJECTCODE from subjectmaster where subjectID='"+mSC+"' and institutecode='"+mInst+"' and nvl(deactive,'N')='N' ";
	rssub=db.getRowset(qrysub);
	if(rssub.next())
		{
	 		mNam=rssub.getString("subject");
			mSc=rssub.getString("SUBJECTCODE");
		}
		else
		{
			mNam="";
			mSc="";
		}

		%>
		<TABLE ALIGN=CENTER rules=COLUMNS rules=groups  cELLSPACING=0 BORDER=0>
<tr><td colspan=3><b>CoOrdinator Name/Member name : </b><font color=dark brownt><b><%=mMemberName%>&nbsp;(<%=mDMemberCode%>)</font></b></td></tr>
	<TR>
		<TD><b>Exam Code :</b><%=mEC%></TD>
		<TD nowrap ><b>&nbsp; Subject Code :</b><%=mNam%>&nbsp(<%=mSc%>)</TD>
	</TR>
	</TABLE>
<table align=center>
<!-- <tr>
<td align=center><b>Final Examination of students Semester-</B>
</td>
</tr> -->
</table>
<BR><CENTER><B><U>Calculation Parameter</U></B></CENTER><BR>
<TABLE bgcolor=#fce9c5 width="75%" class="sort-table" id="table-1" ALIGN=CENTER rules=COLUMNS CELLSPACING=0 BORDER=1> 
<thead>
<tr bgcolor="#ff8c00">
	<td ><b><font color=white>Grade</font></b></td>
	<td><b><font color=white >Normal Range(%) of marks</font></b></td>
	
	<td><b><font color=white >Initial Boundary</font></b></td>
	<td><b><font color=white >Initial Count</font></b></td>
	<td><b><font color=white >Revised Boundary</font></b></td>
	<td><b><font color=white >Revised Count</font></b></td>
	</thead>
	</tr>

<%
String qrybb=""; ResultSet rsbb=null;
qrybb=" SELECT   NVL (GRADE, 'N') GRADE,   NVL (RECOMMENDEDFROM, '0') RECOMMENDEDFROM,     NVL (RECOMMENDEDTO, '0') RECOMMENDEDTO,         NVL (STANDEREDLOWERLIMIT, '0') STANDEREDLOWERLIMIT,         NVL (INITIALCOUNT, '0') INITIALCOUNT,         NVL (FINALCOUNT, '0') FINALCOUNT  FROM   gradecalculationgrades where BREAK#SLNO='"+bno+"' and examcode='"+mEC+"' and INSTITUTECODE='"+mInst+"' ";
rsbb=db.getRowset(qrybb);
//out.print(qrybb);
while(rsbb.next())
{
	  
%>
		<tr bgcolor=white >
<td><%=rsbb.getString("GRADE")%></td>
<td><%=rsbb.getString("STANDEREDLOWERLIMIT")%></td>
<td><%=rsbb.getString("RECOMMENDEDFROM")%></td>
<td><%=rsbb.getString("INITIALCOUNT")%></td>
<td><%=rsbb.getString("RECOMMENDEDTO")%></td>
<td><%=rsbb.getString("FINALCOUNT")%></td>

<%
}
%>
</tr> 
<%
qryi=" SELECT distinct B.FSTID,b.subjectid,B.enrollmentno,B.studentname,A.STUDENTID,A.INITIALMARKS,A.INITIALGRADE,A.MASSCUTS,A.FINALMARKS,";
qryi=qryi+" nvl(A.FINALGRADE,' ')FINALGRADE FROM STUDENTWISEGRADE A,V#STUDENTEVENTSUBJECTMARKS  B where A.BREAK#SLNO= '"+bno+"'  ";
qryi=qryi+" and A.INSTITUTECODE='"+mInst+"' and a.institutecode=b.institutecode AND A.FSTID=B.FSTID and A.EXAMCODE='"+mEC+"'  AND A.STUDENTID=B.STUDENTID AND NVL(A.DEACTIVE,'N')='N'  order by B.studentname";
rsi=db.getRowset(qryi);
//out.print(qryi);
while(rsi.next())
{
	 
	//mDet=rsi.getString("FINALGRADE");
 
qry=" select 'Y' from DEBARSTUDENTDETAIL a  WHERE a.EXAMCODE='"+mEC+"' and a.fstid = '"+rsi.getString("fstid")+"'  and a.INSTITUTECODE='"+mInst+"' and a.STUDENTID='"+rsi.getString("studentid")+"' AND A.SUBJECTID='"+rsi.getString("SUBJECTID")+"' and nvl(a.DEACTIVE,'N')='N' and (NVL(A.DEBAR,'N')='Y' or  NVL(A.ABSENTCASE,'N')='Y' or nvl(UFM,'N')='Y')";
							//out.print(qry);
							rs=db.getRowset(qry);
							if(rs.next())
							{
							 
								mDebarCount++;
							}
							 
 
}

%>
 
<tr bgcolor=white >
<td><B>Pre-Graded</B></td>
<td>-</td>
<td>-</td>
<td><%=mDebarCount%></td>
<td>-</td>
<td><%=mDebarCount%></td>


</tr>
</table>
<BR>
<TABLE bgcolor=#fce9c5 class="sort-table" id="table-1" ALIGN=CENTER rules=COLUMNS CELLSPACING=0 BORDER=1> 
<thead>
<tr bgcolor="#ff8c00">
	<td ><b><font color=white>&nbsp;SNo.</font></b></td>
	<td><b><font color=white >Roll No.</font></b></td>
	
	<td><b><font color=white >Student Name</font></b></td>
	 <td><b><font color=white >Marks</font></b></td> 
	<td><b><font color=white >Grade</font></b></td>
</tr>
</thead>
<tbody>
<%
qryi=" SELECT distinct B.FSTID,b.subjectid,B.enrollmentno,B.studentname,A.STUDENTID,A.INITIALMARKS,A.INITIALGRADE,A.MASSCUTS,A.FINALMARKS,";
qryi=qryi+" nvl(A.FINALGRADE,' ')FINALGRADE FROM STUDENTWISEGRADE A,V#STUDENTEVENTSUBJECTMARKS  B where A.BREAK#SLNO= '"+bno+"'  ";
qryi=qryi+" and A.INSTITUTECODE='"+mInst+"' and a.institutecode=b.institutecode AND A.FSTID=B.FSTID and A.EXAMCODE='"+mEC+"'  AND A.STUDENTID=B.STUDENTID AND NVL(A.DEACTIVE,'N')='N'  order by B.studentname";
rsi=db.getRowset(qryi);
//out.print(qryi);
while(rsi.next())
{
	ctr++;
	//mDet=rsi.getString("FINALGRADE");
%>
		<tr bgcolor=white >
		<td align='right'><B><%=ctr%>.</B></td>
		<td><%=rsi.getString("enrollmentno")%></td>
<%
qry=" select 'Y' from DEBARSTUDENTDETAIL a  WHERE a.EXAMCODE='"+mEC+"' and a.fstid = '"+rsi.getString("fstid")+"'  and a.INSTITUTECODE='"+mInst+"' and a.STUDENTID='"+rsi.getString("studentid")+"' AND A.SUBJECTID='"+rsi.getString("SUBJECTID")+"' and nvl(a.DEACTIVE,'N')='N' and (NVL(A.DEBAR,'N')='Y' or  NVL(A.ABSENTCASE,'N')='Y')";
							//out.print(qry);
							rs=db.getRowset(qry);
							if(rs.next())
							{
								mDet="*";
								mDebarCount++;

								mfinalmarks=0;
							}
							else
						{
										mDet="";
										mfinalmarks=rsi.getDouble("FINALMARKS");
						}
%>
			<td><%=GlobalFunctions.toTtitleCase(rsi.getString("studentname"))%>  <font color=red size=2><b><%=mDet%></b></font> </td>

			

		<td>&nbsp;<%=mfinalmarks%></td>
		<td>&nbsp;<%=rsi.getString("FINALGRADE")%></td>
		</tr>
<%
} // closing of while rsi
qry="select to_char(sysdate,'dd-mm-yyyy hh:mi:ss PM') from dual";
rs=db.getRowset(qry);
rs.next();
String mDat=rs.getString(1);

%>
</tbody>
		</table>	
<script type="text/javascript">
var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString","CaseInsensitiveString","Number","CaseInsensitiveString"]);
</script>
<br>
<%
String qryaa=""; ResultSet rsa=null;
String hod_name="";
qryaa="select employeename from departmentmaster a,hodlist b ,employeemaster c where INSTITUTECODE='"+mInst+"' and nvl(b.deactive,'N')='N' and a.DEPARTMENTCODE=b.DEPARTMENTCODE and b.employeeid=c.employeeid  and a.DEPARTMENT='"+mDept+"'";
rsa=db.getRowset(qryaa);
//out.print(qryaa);
if(rsa.next()){
hod_name=rsa.getString("EMPLOYEENAME");
}else{
hod_name="";
}
%>
<table width=76% align=center>
<tr>
<td align=left>
Signature of Instructor:<br>
<font color=dark brownt><%=mMemberName%>&nbsp;</font><br>
Submitted on..<%=mDat%>
<br>
</td>
<td align=right><font color=red>*</font>Detained/Absent Candidate 
</td>
</tr>
<tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td> 
</tr>
<tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
</tr>
<tr>
<td align=left>
    
Signature of HOD: <br>
<font color=dark brownt><%=hod_name%>&nbsp;</font><br>
Submitted on..<%=mDat%>
</td>

</tr>
</table>

<table width=80% align=center>
<tr>
<td nowrap align=center title="Click to Print" valign=top>
<table width=10% align=center border=2 bordercolor=magroon><tr><td align=center nowrap><font color=blue>
<b>Click  <a style="CURSOR:hand" onClick="window.print();"><img src="../../Images/printer.gif"></a> To Print</b></font></td></tr></table></td>
</tr>
</table>
</form>
 <%





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


} // closing of if(!mMemberID.equals(""))
 //-----------------------------
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}    
}
catch(Exception e)
{
	// out.print(e);
}
%>