<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*,java.util.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
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
<script language=javascript>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: large; FONT-FAMILY: fantasy"><b>Freezd Grade Sheet</b></TD>
</font></td></tr>
</TABLE>
<br>
<%
try
{
GlobalFunctions gb =new GlobalFunctions();
OLTEncryption enc=new OLTEncryption();
DBHandler db=new DBHandler();
String mCheckRadio="";
String  mMemberID="",mMemberType="",mMemberName="",mMemberCode="",mInst="";
String mDMemberCode="",mDMemberType="";
Set mGradeChecked=new HashSet();
Set mGradeUnChecked=new HashSet();
int mCount=0;
int pos2Init=0,pos2=0,pos3Init=0,pos20=0;
String mWeightageInit="",mWeightage="";
String mInitMarks="",mWe="";
int pos4Init=0,pos201=0;
String mMassCut="",mMass="",qryv="";
int pos2011=0,pos5Init=0;
String mFST="",mfst="";
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

  if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
	{
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
qryv="Select WEBKIOSK.ShowLink('146','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
RsChk= db.getRowset(qryv);
if (RsChk.next() && RsChk.getString("SL").equals("Y"))
 {
      if(request.getParameter("CHECKRADIO")==null)
		mCheckRadio="N";
	else
		mCheckRadio=request.getParameter("CHECKRADIO").toString().trim();

	if(request.getParameter("COUNT")==null)
		mCount=0;
	else
		mCount=Integer.parseInt(request.getParameter("COUNT").toString().trim());

	int len=0;
	int pos=0,pos1=0;
	int lenInit=0;
	int posInit=0,pos1Init=0;
	String mStudid="",mMarks="",mGrad="",mExamCode="";
	String mStudidInit="",mMarksInit="",mGradInit="",mSubjectCode="";
	String mName="",mRoll="",mNam="";
	int ctr=0;
	String qry="",qrysub="";
	String mSc="";
	String mSem1="";
String mCheckFstid="",Stdidclub="",mBreakSlno="",MassCutCheck="";
	ResultSet rs=null,rssub=null;

	if(request.getParameter("ExamCode")==null)
		mExamCode="";
	else
		mExamCode=request.getParameter("ExamCode").toString().trim();

	if(request.getParameter("Subject")==null)
		mSubjectCode="";
	else
		mSubjectCode=request.getParameter("Subject").toString().trim();
	
	if(request.getParameter("BREAKSLNO")==null)
		mBreakSlno="";
	else
		mBreakSlno=request.getParameter("BREAKSLNO").toString().trim();
	
	
	if(request.getParameter("SEMESTER")==null)
		mSem1="";
	else
		mSem1=request.getParameter("SEMESTER").toString().trim();

	if(request.getParameter("mCheckFstid")==null)
		mCheckFstid="";
	else
		mCheckFstid=request.getParameter("mCheckFstid").toString().trim();
	
	
if(request.getParameter("MassCutCheck")==null)
				{
					MassCutCheck="N";
				}
				{
					MassCutCheck=request.getParameter("MassCutCheck");
				}

	if(request.getParameter("Stdidclub")==null)
		Stdidclub="";
	else
		Stdidclub=request.getParameter("Stdidclub").toString().trim();
	String count1="";
	String temp1="";
	if(request.getParameter("count")==null)
		count1="";
	else
		count1=request.getParameter("count").toString().trim();
	
	if(request.getParameter("temp")==null)
		temp1="";
	else
		temp1=request.getParameter("temp").toString().trim();
	
	%>
	<form name="frm" method="post" action="StudentGradesXLSJPBS.jsp">
	<input type="hidden" name="ExamCode" value=<%=mExamCode%>>
	<input type="hidden" name="Stdidclub" value=<%=Stdidclub%>>	
	<input type="hidden"  name="mCheckFstid" value="<%=mCheckFstid%>">	
	<input type="hidden" name="SEMESTER" value=<%=mSem1%>>
	<input type="hidden" name="BREAKSLNO" value=<%=mBreakSlno%>>
	<input type="hidden" name="Subject" value=<%=mSubjectCode%>>	
	<%	
	qrysub="select subject,SUBJECTCODE from subjectmaster where subjectID='"+mSubjectCode+"' and  INSTITUTECODE='"+mInst+"' and nvl(deactive,'N')='N' ";
	//out.print(qrysub);
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

int n=0;

if( !temp1.equals("") && !count1.equals("")) 
{
int j=0;
if(1==1)
{
	String qryupdate="update  GRADECALCULATION set FINALIZED='Y' , FINALIZEDBY	='"+mChkMemID+"' , FINALIZEDDATE=sysdate where INSTITUTECODE='"+mInst+"'	and EXAMCODE='"+mExamCode+"' and SUBJECTID	='"+mSubjectCode+"'  and BREAK#SLNO='"+mBreakSlno+"' " ;
	//out.print(qryupdate);
	 j=db.update(qryupdate);
}
//out.println("J-"+j);

if(j>0)
{

%>
<TABLE ALIGN=CENTER rules=COLUMNS rules=groups  cELLSPACING=0 BORDER=0>
<tr><td colspan=3><b>CoOrdinator Name/Member name : </b><font color=dark brownt><b><%=mMemberName%>&nbsp;(<%=mDMemberCode%>)</font></b></td></tr>
	<TR>
		<TD><b>Exam Code :</b><%=mExamCode%></TD>
		<TD nowrap ><b>&nbsp; Subject Code :</b><%=mNam%>&nbsp(<%=mSc%>)</TD>
	</TR>
	</TABLE>

	<br>

 <TABLE bgcolor=#fce9c5 class="sort-table" id="table-1" ALIGN=CENTER rules=COLUMNS CELLSPACING=0 width=76% BORDER=1> 
<!-- <table bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=columns topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center width="100%"> -->
<thead>
<tr bgcolor="#ff8c00">
	<td><b><font color=white>SNo.</font></b></td>
	<td><b><font color=white >Roll No.</font></b></td>
	<td><b><font color=white >Student Name</font></b></td>
	<%
			if(MassCutCheck.equals("Y"))
			{
			%>
		<td><b><font color=white >Marks Cuts</font></b></td>
			<%
			}
	%>
	<td><b><font color=white >Final<br>Marks</font></b></td>
	<td><b><font color=white >Final<br>Grade</font></b></td>
</tr>
</thead>
<tbody>
</tbody>
<%
		int count=0;
String query="select b.ENROLLMENTNO,b.STUDENTNAME,a.FINALMARKS,nvl(a.FINALGRADE,' ')FINALGRADE,nvl(a.MASSCUTS,0)MASSCUTS from STUDENTWISEGRADE a , Studentmaster b WHERE a.EXAMCODE='"+mExamCode+"' and a.fstid in ("+mCheckFstid+")  and a.INSTITUTECODE='"+mInst+"' and a.BREAK#SLNO='"+mBreakSlno+"' and a.STUDENTID=b.STUDENTID and nvl(a.DEACTIVE,'N')<>'Y' and nvl(b.DEACTIVE,'N')<>'Y' order by studentname";	
ResultSet rslist=db.getRowset(query);
//out.println(query);
while(rslist.next())
{

	%>
	<tr >
	<td><b><%=++count%> .</b></td>
	<td>&nbsp;<%=rslist.getString("ENROLLMENTNO")%></b></td>
	<td>&nbsp;<%=rslist.getString("STUDENTNAME")%></b></td>
	<%
		if(MassCutCheck.equals("Y"))
			{
			%>
				<td>&nbsp;<%=rslist.getString("MASSCUTS")%></b></td>
			<%
			}
			%>

	<td>&nbsp;<%=rslist.getString("FINALMARKS")%></b></td>
	<td>&nbsp;<%=rslist.getString("FINALGRADE")%></b></td>
	
</tr>
	
	<%



}

%>




</table>	
<script type="text/javascript">
var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString"]);
</script>
<br>
<table width=76% align=center>
<tr>
<td align=left>
Name:-<br>
Signature of Instructor:<br>
Submitted on..<%%>
</td>
<td align=right>*Detained Candidate 
</td>
</tr>

</tr>
</table>
<center><input type="button" name='submit' onClick='window.print()' value='Click To Print'/></center>
</form>
	<%
	//-----------------------------
//---Enable Security Page Level  
//-----------------------------
}
else
	 {
%>
	<center><br>
	<font color=red>
	<h3>	<br><img src='../../Images/Error1.jpg'>	Error on Saving ..............</h3><br>
</font> </center>  <%
	 }
}
else{	
%>
<center><br>
	<font color=red>
	<h3>	<br><img src='../../Images/Error1.jpg'>	Some of the Grade Are not enter yet...........</h3><br>
</font> </center>  
<%

}
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
