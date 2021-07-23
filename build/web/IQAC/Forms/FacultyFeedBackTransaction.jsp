	<%-- 
		Document   : Faculty FeedBackTransaction
		Created on : 1/20/2015, 4:39:07 PM
		Author     : Mohit Sharma
	--%>
	<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*" %>
	<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
	<%@page contentType="text/html" pageEncoding="UTF-8"%>

	<!DOCTYPE html>
	<html>
		<head>
			<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
			<link rel="stylesheet" href="../css/Style.css">
			<link rel="stylesheet" href="../css/jquery-ui.css"/>
			<style type="text/css">
				html, body{ margin: 0; border: 0 none; padding: 0;    }
				html, body, #wrapper, #left, #right {  margin-top: auto }
				#wrapper { margin: 0 auto;  width: 960px;  }
				#mastergrid  tr:nth-child(even) {background: #F8F8F8;cursor:pointer;padding:8px; border:#999 1px solid; }
				#mastergrid tr:nth-child(odd) {background: 	#EBF5FF;cursor:pointer;padding:8px; border:#999 1px solid; }
				#mastergrid td { padding:5px; border:#999 1px solid; }
				#mastergrid1 th { padding:5px; border:#999 1px solid; }
				#mastergrid :hover, .applicantclass:focus, .applicantclass:active   {
					background: skyblue !important;}

			</style>
			<script src="../js/jquery/jquery-1.10.2.js"></script>
			<script src="../js/jquery/jquery-ui.js"></script>
			<script src="../js/jquery/yattable.js"></script>
			<script src="../js/IQTest/FeedBackTransactionJS.js"></script>
			<script>
				$(document).ready(function() {
					$(".date").datepicker({
					dateFormat: 'dd-mm-yy',
					changeMonth: true,
					changeYear: true,
					yearRange: '-100:+0'
				});
					$(document).tooltip({
						track: true
					});
				});
			</script>
		</head>
	 <%
	 DBHandler db=new DBHandler();
	 
	 %>

	 <%
	try
	{
	OLTEncryption enc=new OLTEncryption();
	int mFlag=0,slnoo=0,seq=0;
		String QryRating="",nSubject="",nLTP="",mID="",subject=""; ResultSet rsRating=null;

 	 String  subchk=""; ResultSet rschksub=null;
String QryTransid="",vTrans=""; ResultSet rsTrans=null;
		
		
			String xAns="",xAnsRemarks="",qryAns=""; ResultSet rsAns=null;
		String xUserRemark="",xRating="",xtransactionDate="",mInstCode="",mFeeDCode="",xLtp="",TRANSID="",qryin1="",qryin2="";
	String  mMemberID="",mexamcode="",QrySubject="",xquestion="",mMemberType="",mMemberName="",mMemberCode="",QrySub1="";
	String mDMemberCode="",mDMemberType="",ltp="",xFstid="",mrating="",QryDel="",QryDel1="",qryUpdate="";
	String mECode="",mecode="", mDesg="", mDept="";
	int mSno=0,slno=0,Qslno=0,pp=0,nn=0,nd=0,nnd=0,nnu=0;
	String mLTP="",QrySub="";ResultSet rsSub=null;
	String mName="";
	String mSCode="",mscode="",QryHead="";
	String mEC="",mSC="",mComp="",mInst="",mLoginComp="",xHead="",qry="",QryQues="",mComponent="";
	String mName1="",mSubjectRadio="",xexamcode="",mFeedbakid="",xInstCode="",Qrydetail ="",xSTATUS="",vDocMode="";
	String QryRatingv=""; ResultSet rsRatingv=null;
	ResultSet rsDetail=null,rsHead=null,rsQues=null;

	String  QryHeadcHILD="",date=""; ResultSet rsRatingChild=null;
	if (session.getAttribute("Designation")==null)
	{
		mDesg="";
	}
	else
	{
		mDesg=session.getAttribute("Designation").toString().trim();
	}
								
	if (session.getAttribute("Department")==null)
	{
		mDept="";
	}
	else
	{
		mDept=session.getAttribute("Department").toString().trim();
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
	if (session.getAttribute("CompanyCode")==null)
	{
		mComp="";
	}
	else
	{
		mComp=session.getAttribute("CompanyCode").toString().trim();
	}
	if (session.getAttribute("InstituteCode")==null)
	{
		mInst="";
	}
	else
	{
		mInst=session.getAttribute("InstituteCode").toString().trim();
	}
	if (session.getAttribute("LoginComp")==null)
	{
		mLoginComp=""; 
	}
	else
	{
		mLoginComp=session.getAttribute("LoginComp").toString().trim();
	}

//New Added (Suggested by deepak sir)

    if(mInst.equals("JIIT")){
      mComp="UNIV";
     }

//new added
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
	{
	   mDMemberCode=enc.decode(mMemberCode);
	   mDMemberType=enc.decode(mMemberType);
	   String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	   String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	   String mIPAddress =session.getAttribute("IPADD").toString().trim();
	   String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	   ResultSet RsChk=null,rs=null,rss=null,rsHeadcHILD=null,rsQuesc=null,rsRatingc=null,rsRatingvc=null;
	   int Qslnoc=0,seqc=0,id=0;
	   String mExamid="",QryQuesc="",QryRatingvc="",QryRatingc="";
	   //-----------------------------
	   //-- Enable Security Page Level  
	   //-----------------------------
	   qry="Select WEBKIOSK.ShowLink('146','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	   RsChk= db.getRowset(qry);
	   if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
		   //out.print(mInst+"**");

		%>
		<body >
			
			   
				
				<!-- Above Is  to handle  the session values   -->
				<div id="windowheader" class="ui-widget-header ui-corner-all div" style="height:35px" ><B><FONT SIZE="4" COLOR="black">Faculty Feedback Transaction (QA-AC-3)</FONT></B></div> 
				
				
				<div style="width: 99%; padding: 10px ;border: .3em solid;border-radius: 25px;" > 

				<form name="frm0" method="post" >
		<input id="xx" name="xx" type=hidden>
		<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
		
		</TABLE>
		<table cellpadding=1 cellspacing=0 width="75%" align=center rules=groups border=1>
		<tr><td   colspan=8 align=center>&nbsp;<font color=navy face=arial size=2><STRONG>Faculty : &nbsp;</STRONG></font><font color=black face=arial size=2><%=mMemberName%>[<%=mDMemberCode%>]
		&nbsp; &nbsp; &nbsp;<font color=navy face=arial size=2><STRONG>Department : &nbsp;</STRONG></font><%=GlobalFunctions.toTtitleCase(mDept)%>
		&nbsp; &nbsp; &nbsp;<font color=navy face=arial size=2><STRONG>Designation : &nbsp;</STRONG></font><%=GlobalFunctions.toTtitleCase(mDesg)%>
		<hr></td></tr>

		<!--Institute****-->
		<tr><td colspan=5 align=center><FONT color=black><FONT face=Arial size=2><STRONG>Institute :</STRONG></FONT></FONT>
		&nbsp; &nbsp;<select name=InstCode tabindex="0" id="InstCode">
		<OPTION selected Value =<%=mInst%>><%=mInst%></option>
		</select>
		&nbsp; &nbsp; &nbsp;
			<FONT color=black face=Arial size=2><STRONG>FeedBack Code :</STRONG></FONT>
			<%
			
		//**************CHANGE THE QUERY 27/01/2010**************************

			qry="  SELECT distinct to_char(sysdate,'DD-MM-YYYY') cdate, a.FEEDBACKID FEEDBACKID , a.FEEDBACKCODE || ' - ' ||A.FEEDBACKDESC feedback   FROM   AP#FACULTYFEEDBACKMASTER a  WHERE       NVL (deactive, 'N') = 'N'  AND NVL (A.EVENTBROADCAST, 'Y') = 'Y'    AND NVL (A.EVENTCOMPLETED, 'N') = 'N' and  trunc(sysdate) >= trunc(EVENTFROMDATE) and trunc(sysdate) <=trunc(EVENTTODATE)    and institutecode='"+mInst+"'  AND feedbackid IN (SELECT DISTINCT apfeedbackid      FROM ap#feedbacktypemaster      WHERE apfeedbacktype = 'ACFACULTY') ";
			
			//out.print(qry);
			rs=db.getRowset(qry);


			
			%>
			<select name="FeeDCode" tabindex="0" id="FeeDCode">	
			<%
			try
			{ 
				if (request.getParameter("xx")==null)
				{
					%>
					<OPTION selected Value="NONE"><b><-- Select FeedBack Code --></b></option>
				<%
				while(rs.next())
				{
						date=rs.getString("cdate");
					mExamid=rs.getString("FEEDBACKID");
					%>
					<OPTION Value =<%=mExamid%>><%=rs.getString("feedback")%></option>
					<%
				}
			}
			else
			{
				%>
				<OPTION Value="NONE"><b><-- Select FeedBack Code --></b></option>
				<%
				while(rs.next())
				{
					date=rs.getString("cdate");
					mExamid=rs.getString("FEEDBACKID");
					if(mExamid.equals(request.getParameter("FeeDCode").toString().trim()))
					{
						%>
						<OPTION selected Value =<%=mExamid%>><%=rs.getString("feedback")%></option>
						<%			
					}
						else
					  {
						%>
							<OPTION Value =<%=mExamid%>><%=rs.getString("feedback")%></option>
							<%			
					}
				}
			}
		}
		catch(Exception e)
		{
			//out.println(e.getMessage());
		}
		%>
		</select></td><td>
							
							<FONT color=black face=Arial size=2><STRONG>Exam Code :</STRONG></FONT>
			<%
			
		//**************CHANGE THE QUERY 27/01/2010**************************

			qry="  SELECT DISTINCT  a.examcode   FROM   AP#FACULTYFEEDBACKMASTER a  WHERE       NVL (deactive, 'N') = 'N'  AND NVL (A.EVENTBROADCAST, 'Y') = 'Y'     AND NVL (A.EVENTCOMPLETED, 'N') = 'N' and  trunc(sysdate) >= trunc(EVENTFROMDATE) and trunc(sysdate) <=trunc(EVENTTODATE) and institutecode='"+mInst+"' ";
			
			// out.print(qry);
			rs=db.getRowset(qry);
			%>
			<select name="examcode" tabindex="0" id="examcode">	
			<%
			try
			{ 
				if (request.getParameter("xx")==null)
				{
					%>
					<OPTION  Value="NONE"><b><-- Select Exam Code --></b></option>
				<%
				while(rs.next())
				{
					mexamcode=rs.getString("examcode");
					%>
					<OPTION Value =<%=mexamcode%>><%=rs.getString("examcode")%></option>
					<%
				}
			}
			else
			{
				%>
				<OPTION Value="NONE"><b><-- Select Exam Code --></b></option>
				<%
				while(rs.next())
				{
					mexamcode=rs.getString("examcode");
					if(mexamcode.equals(request.getParameter("examcode").toString().trim()))
					{
						%>
						<OPTION selected Value =<%=mexamcode%>><%=rs.getString("examcode")%></option>
						<%			
					}
						else
					  {
						%>
							<OPTION Value =<%=mexamcode%>><%=rs.getString("examcode")%></option>
							<%			
					}
				}
			}
		}
		catch(Exception e)
		{
			//out.println(e.getMessage());
		}
		%>
		</select>
							
							</td><td colspan="2">
		&nbsp; &nbsp; &nbsp;
		<INPUT Type="submit" class="button"   Value="&nbsp; Continue &nbsp;">
		</td></tr>
		</table>
		</form>


		<%
		if(request.getParameter("xx")!=null  )
		{
			mExamid="";		
			if( request.getParameter("FeeDCode")!=null && !request.getParameter("FeeDCode").equals("") && !request.getParameter("FeeDCode").equals("NONE") && request.getParameter("examcode")!=null && !request.getParameter("examcode").equals("") && !request.getParameter("examcode").equals("NONE") )
			{
		   if(request.getParameter("FeeDCode")!=null && !request.getParameter("FeeDCode").equals("NONE"))
		   {
			mExamid=request.getParameter("FeeDCode").toString().trim();
		   }

if(request.getParameter("InstCode")!=null && !request.getParameter("InstCode").equals("NONE"))
		   {
			mInstCode=request.getParameter("InstCode").toString().trim();
		   }

if(request.getParameter("examcode")!=null && !request.getParameter("examcode").equals("NONE"))
		    {
			xexamcode=request.getParameter("examcode").toString().trim();
		    }



		  // out.print(mExamid+"/*/*/*/*/*/*/*/");
			%>	<form name="frm"  method="post" >


			<input id="examcode" name="examcode" value=<%=xexamcode%> type=hidden>
			<input id="xx" name="xx" type=hidden>
			<input id="x" name="x" type=hidden>


	<input type=hidden value=<%=mInst%> id="InstCode" name="InstCode">
			<input type=hidden value=<%=mExamid%> id="FeeDCode" name="FeeDCode">
		 
			

				</div>
				
				
				<div style="width: 99%; padding: 10px ;border: .3em solid;border-radius: 25px;" > 
					<CENTER><table  id="commonmasterid" style="text-align: center;font-size: 18px; border:1px">
						<CENTER><tr>
							<td style="text-align: center" colspan=5>Transaction Date<span class="req"> *</span> :</td><td><input type='text' name='transactionDate' id='transactionDate'  value='<%=date%>' maxlength='100' class='date' style='' title='Transaction Date' readonly/></td> 
						</tr>

	   <table id="mastergrid" style="width: 100%;font-size: 18px;text-align: center" ><thead id="gridhead" border=1><th style="width: 5%">Sl No.</th><th style="width: 25%">Subject</th><th style="width: 25%">SubjectType</th><th style="width: 25%">Program</th><th style="width: 25%">Program</th><th style="width: 25%">Sub Sections</th><th style="width: 20%">FeedBack Count</th><th style="width: 20%">Status</th></thead> 
					  
							<tbody id="gridbody">
							
	<%


	QrySubject=" select subjectid,SUBJECTCODE,  SUBJECT, COUNT (STUDENTID) FeedBackCount,LTP from v#studentltpdetail  a  where  a.institutecode = '"+mInst+"'  AND ( (employeeid = '"+mChkMemID+"') or  EXISTS ( SELECT c.employeeid   FROM MULTIFACULTYSUBJECTTAGGING c             WHERE a.fstid = c.fstid               AND a.institutecode = c.institutecode     and c.employeeid = '"+mChkMemID+"'         ))  AND exists ( SELECT   B.FSTID  FROM   AP#FEEDBACKSUBJECTTAGGING b WHERE    A.FSTID=B.FSTID and A.INSTITUTECODE=B.INSTITUTECODE  and A.EXAMCODE=B.EXAMCODE and   b.feedbackid = '"+mExamid+"'  AND b.institutecode = '"+mInst+"'  AND TRUNC (SYSDATE) >= TRUNC (b.EVENTFROMDATE) AND TRUNC (SYSDATE) <= TRUNC (b.EVENTTODATE) AND NVL (b.approved, 'Y') = 'Y' and nvl(b.deactive,'N')='N' )  and ltp in ('L','P') and subjectid not in ( select distinct subjectid from AP#excludesubjects where nvl(deactive,'N')='N'  and instituteid = '"+mInst+"'  and feedbackid='"+mExamid+"'  and examcode='"+xexamcode+"') group by  LTP, subjectid, SUBJECTCODE, SUBJECT  order by SUBJECT ";
	rs=db.getRowset(QrySubject);
	//out.print(QrySubject);
	while(rs.next()){

		slno++;
	 %>
	<tr>
	<td><%=slno%><INPUT TYPE="radio" NAME="SubjectRadio"  value=<%=rs.getString("subjectid")+"-"+rs.getString("LTP")%>></td>
	<td ><%=rs.getString("SUBJECT")%> - <%=rs.getString("SUBJECTCODE")%>  </td><td ><%=rs.getString("LTP")%></td>
	<td >
	<%
	QrySub=" select distinct programcode  from v#studentltpdetail  a  where  a.institutecode = '"+mInst+"'   and ltp='"+rs.getString("LTP")+"'  and subjectid='"+rs.getString("subjectid")+"'  AND ( (employeeid = '"+mChkMemID+"') or  EXISTS ( SELECT c.employeeid   FROM MULTIFACULTYSUBJECTTAGGING c             WHERE a.fstid = c.fstid               AND a.institutecode = c.institutecode   and c.employeeid = '"+mChkMemID+"'               )) AND exists ( SELECT   B.FSTID  FROM   AP#FEEDBACKSUBJECTTAGGING b WHERE    A.FSTID=B.FSTID and A.INSTITUTECODE=B.INSTITUTECODE  and A.EXAMCODE=B.EXAMCODE and   b.feedbackid = '"+mExamid+"'   AND b.institutecode = '"+mInst+"'  AND TRUNC (SYSDATE) >= TRUNC (b.EVENTFROMDATE) AND TRUNC (SYSDATE) <= TRUNC (b.EVENTTODATE) AND NVL (b.approved, 'Y') = 'Y' and nvl(b.deactive,'N')='N' ) order by programcode   ";
	rss=db.getRowset(QrySub);
	//out.print(QrySub);
	while(rss.next()) {
	%>
	<%=rss.getString("programcode")%> 
	<%
	}	
	%>
	</td>
	<td>
	<%
	QrySub=" select distinct sectionbranch  from v#studentltpdetail  a  where  a.institutecode = '"+mInst+"'  and ltp='"+rs.getString("LTP")+"'  and subjectid='"+rs.getString("subjectid")+"'   AND ( (employeeid = '"+mChkMemID+"') or  EXISTS ( SELECT c.employeeid   FROM MULTIFACULTYSUBJECTTAGGING c             WHERE a.fstid = c.fstid               AND a.institutecode = c.institutecode  and c.employeeid = '"+mChkMemID+"'               )) AND exists ( SELECT   B.FSTID  FROM   AP#FEEDBACKSUBJECTTAGGING b WHERE    A.FSTID=B.FSTID and A.INSTITUTECODE=B.INSTITUTECODE  and A.EXAMCODE=B.EXAMCODE and   b.feedbackid = '"+mExamid+"'   AND b.institutecode = '"+mInst+"'  AND TRUNC (SYSDATE) >= TRUNC (b.EVENTFROMDATE) AND TRUNC (SYSDATE) <= TRUNC (b.EVENTTODATE) AND NVL (b.approved, 'Y') = 'Y' and nvl(b.deactive,'N')='N' )  order by sectionbranch    ";
	rss=db.getRowset(QrySub);
	//out.print(QrySub);
	while(rss.next()){
	%>
	<%=rss.getString("sectionbranch")%> 
	<%
	}	
	%>
	</td>
	<td >
	<%
	QrySub=" select distinct SUBSECTIONCODE from v#studentltpdetail  a  where  a.institutecode = '"+mInst+"'  and ltp='"+rs.getString("LTP")+"'  and subjectid='"+rs.getString("subjectid")+"'  AND ( (employeeid = '"+mChkMemID+"') or  EXISTS ( SELECT c.employeeid   FROM MULTIFACULTYSUBJECTTAGGING c             WHERE a.fstid = c.fstid               AND a.institutecode = c.institutecode      and c.employeeid = '"+mChkMemID+"'           )) AND exists ( SELECT   B.FSTID  FROM   AP#FEEDBACKSUBJECTTAGGING b WHERE    A.FSTID=B.FSTID and A.INSTITUTECODE=B.INSTITUTECODE  and A.EXAMCODE=B.EXAMCODE and   b.feedbackid = '"+mExamid+"'   AND b.institutecode = '"+mInst+"'  AND TRUNC (SYSDATE) >= TRUNC (b.EVENTFROMDATE) AND TRUNC (SYSDATE) <= TRUNC (b.EVENTTODATE) AND NVL (b.approved, 'Y') = 'Y' and nvl(b.deactive,'N')='N' )  order by SUBSECTIONCODE   ";
	rss=db.getRowset(QrySub);
	//out.print(QrySub);
	while(rss.next()){

	%>
	<%=rss.getString("SUBSECTIONCODE")%>
	<%
	}	
	%>
	</td>
	<td ><%=rs.getInt("FeedBackCount")%></td>



<% QryTransid= " select distinct TRANSID from AP#FACULTYFEEDBACK   where entryby = '"+mChkMemID+"' and     fstid in (   SELECT   DISTINCT fstid  FROM   v#studentltpdetail a  WHERE       a.institutecode =  '"+mInst+"'   AND examcode = '"+xexamcode+"'   AND ltp = '"+rs.getString("LTP")+"'    AND subjectid = '"+rs.getString("subjectid")+"'    AND ( (employeeid = '"+mChkMemID+"') or  EXISTS ( SELECT c.employeeid   FROM MULTIFACULTYSUBJECTTAGGING c             WHERE a.fstid = c.fstid               AND a.institutecode = c.institutecode     and c.employeeid = '"+mChkMemID+"'         ))     AND EXISTS                (SELECT   B.FSTID        FROM   AP#FEEDBACKSUBJECTTAGGING b            WHERE       A.FSTID = B.FSTID   AND FEEDBACKID = '"+mExamid+"'              AND A.INSTITUTECODE = B.INSTITUTECODE    AND A.EXAMCODE = B.EXAMCODE  AND b.feedbackid = '"+mExamid+"'                        AND TRUNC (SYSDATE) >= TRUNC (b.EVENTFROMDATE)    AND TRUNC (SYSDATE) <= TRUNC (b.EVENTTODATE)   AND NVL (b.approved, 'Y') = 'Y'                          AND NVL (b.deactive, 'N') = 'N' )  ) ";

       	rsTrans=db.getRowset(QryTransid);
	// out.print(QryTransid);
	if(rsTrans.next()){
//vTrans=rsTrans.getString("TRANSID");
	
	
	%>
			
		<input type=hidden value='S' id="STATUS" name="STATUS">
	<td > FeedBack Stored &nbsp;</td>
<%
	}else{	
	%>
	<td >Pending</td>
	<input type=hidden value='P' id="STATUS" name="STATUS">
<%
	}	
	%>
	</tr>
	<%
	}	
	%>

	</CENTER>
	<tr align=right  bgcolor=red ><td colspan=8  bgcolor=skyblue align=right><INPUT Type="submit" class="button"   Value="&nbsp; View&nbsp;/&nbsp;Refresh &nbsp;">
		<!--nput type="button"  title='Reset Fields'  class="button" id="Reset" style="cursor:pointer;" onclick=" resetValues()" value="Reset"-->
		</td></tr></tbody>
		</table> 
		</div>

 
		 <INPUT TYPE="hidden" NAME="transactionDate"  value="<%=xtransactionDate%>" >

		</form>
	<%

			mComponent="";


	if(request.getParameter("x")!=null && request.getParameter("xx")!=null  && request.getParameter("transactionDate")!=null && !request.getParameter("transactionDate").equals("NONE"))
		{

		if(request.getParameter("SubjectRadio")!=null && !request.getParameter("SubjectRadio").equals("NONE"))
		   {
			mSubjectRadio=request.getParameter("SubjectRadio").toString().trim();
            }

 
int p = mSubjectRadio.indexOf('-');
if (p >= 0) {
      nSubject = mSubjectRadio.substring(0, p);
      nLTP = mSubjectRadio.substring(p + 1);
} else {
  // s does not contain '-'
}

//out.print(nSubject+"<><><>"+nLTP);

if(request.getParameter("transactionDate")!=null && !request.getParameter("transactionDate").equals("NONE"))
		   {
			xtransactionDate=request.getParameter("transactionDate").toString().trim();
		   }


		  if(request.getParameter("examcode")!=null && !request.getParameter("examcode").equals("NONE"))
		    {
			xexamcode=request.getParameter("examcode").toString().trim();
		    }

			if(request.getParameter("FeeDCode")!=null && !request.getParameter("FeeDCode").equals("NONE"))
		   {
			mFeedbakid=request.getParameter("FeeDCode").toString().trim();
		   }

			if(request.getParameter("InstCode")!=null && !request.getParameter("InstCode").equals("NONE"))
		   {
			xInstCode=request.getParameter("InstCode").toString().trim();
		   }

    /* if(request.getParameter("STATUS")!=null && !request.getParameter("STATUS").equals("NONE"))
            {
            xSTATUS=request.getParameter("STATUS").toString().trim();
            } */

/*--------------------------Updated by Gyan (27-feb-2015) Start-------------- */

QryTransid= " select DISTINCT nvl(TRANSID,' ') TRANSID,nvl(docmode,' ') docmode from AP#FACULTYFEEDBACK   where entryby='"+mChkMemID+"'    and  fstid in (   SELECT   DISTINCT fstid  FROM   v#studentltpdetail a  WHERE       a.institutecode =  '"+mInst+"'   AND examcode = '"+xexamcode+"'   AND ltp = '"+nLTP+"'    AND subjectid = '"+nSubject+"'         AND ( (employeeid = '"+mChkMemID+"') or  EXISTS ( SELECT c.employeeid   FROM MULTIFACULTYSUBJECTTAGGING c             WHERE a.fstid = c.fstid               AND a.institutecode = c.institutecode     and c.employeeid = '"+mChkMemID+"'         ))       AND EXISTS                (SELECT   B.FSTID        FROM   AP#FEEDBACKSUBJECTTAGGING b            WHERE       A.FSTID = B.FSTID   AND FEEDBACKID = '"+mFeedbakid+"'              AND A.INSTITUTECODE = B.INSTITUTECODE    AND A.EXAMCODE = B.EXAMCODE  AND b.feedbackid = '"+mFeedbakid+"'                        AND TRUNC (SYSDATE) >= TRUNC (b.EVENTFROMDATE)    AND TRUNC (SYSDATE) <= TRUNC (b.EVENTTODATE)   AND NVL (b.approved, 'Y') = 'Y'                          AND NVL (b.deactive, 'N') = 'N' )  ) ";

       	rsTrans=db.getRowset(QryTransid);
	// out.print(QryTransid);
	if(rsTrans.next()){
vTrans=rsTrans.getString("TRANSID");
vDocMode=rsTrans.getString("docmode").trim();
xSTATUS="S" ;
	}else{
    vDocMode="";
	vTrans="";
xSTATUS="" ;
	}

/*--------------------------Updated by Gyan (27-feb-2015) End-------------- */
//out.print("************************"+xSTATUS);


qry=" select distinct subject || '-' || SUBJECTcode subject from subjectmaster where subjectid='"+nSubject+"'  and institutecode='"+mInst+"' " ;
	rs=db.getRowset(qry);
if(rs.next()){
subject=rs.getString("subject");

}
	%>

<CENTER><TABLE>
<TR>
	<TD><FONT SIZE="3" COLOR="darkblue">Selected Subject: <%=subject%>&nbsp;&nbsp;&nbsp;Component Type :&nbsp;<%=nLTP%></FONT></TD>
</TR>
</TABLE></CENTER>

	<form name="frm1"  method="post" >
	<input type=hidden value=<%=mFeedbakid%> id="FeeDCode" name="FeeDCode">
	 <INPUT TYPE="hidden" NAME="STATUS"  value="<%=xSTATUS%>" >
	  <INPUT TYPE="hidden" NAME="InstCode"  value="<%=xInstCode%>" >
	<INPUT TYPE="hidden" NAME="transactionDate"  value="<%=xtransactionDate%>" >
	<INPUT TYPE="hidden" NAME="SubjectRadio"  value="<%=nSubject%>" >
	<INPUT TYPE="hidden" NAME="LTP"  value="<%=nLTP%>" >
	<INPUT TYPE="hidden" NAME="examcode"  value="<%=xexamcode%>" >
	<INPUT TYPE="hidden" NAME="FeeDCode"  value="<%=mFeedbakid%>" >
	<input id="xy" name="xy" type=hidden>
		<table id="mastergrid1" style="width: 100%;font-size:18px;text-align: center;table-layout:fixed;" >
		<thead id="gridhead">
		<th style="width:3%">S/No.</th>
		<th style="width:42%" >Item Code/ Description</th>
		<!-- <th style="width:30%">Rating Instructions </th> -->
		<th style="width:25%">Rating</th>
		<th style="width:30%">User Remarks </th>
		</thead>
		</table>
		<table id="mastergrid" style="width: 100%;font-size: 18px;text-align: center;table-layout:fixed;word-wrap: break-word" >
		<tbody id="gridbody">
		</tbody>
	<%
String  qryPC="",Show=""; ResultSet rsPC=null;

	QryHead= " select headid, headcode || '-' || headdesc head from AP#FACULTYQUESTIONHEAD where institutecode='"+xInstCode+"' and COMPONENTTYPE='"+nLTP+"' and examcode='"+xexamcode+"' and  feedbackid='"+mFeedbakid+"'  and   PARENTHEADID is null order by SEQID  " ;
	rsHead=db.getRowset(QryHead);
	// out.print(QryHead);
	while(rsHead.next()){


Show="";

qryPC= "  select 'Y' from AP#FACULTYQUESTIONHEAD  where institutecode='"+mInstCode+"'   and  feedbackid='"+mExamid+"' and   PARENTHEADID ='"+rsHead.getString("headid")+"' order by SEQID   " ;
rsPC=db.getRowset(qryPC);
	 //out.print(qryPC);
	if(rsPC.next()){

Show="hidden";

	}else{
Show="text";
	
	}


	QryQues="  SELECT DISTINCT a.seqid, a.ratingid , nvl(a.QUESTIONBODY,'N') QUESTIONBODY ,a.QUESTIONID,nvl(a.EVALUATIONGUIDELINE,'N/A') EVALUATIONGUIDELINE, a.COMPONENTTYPE from   AP#FACULTYQUESTIONMASTER a  where a.institutecode='"+xInstCode+"'  and COMPONENTTYPE='"+nLTP+"' and  a.examcode='"+xexamcode+"' and a.feedbackid='"+mFeedbakid+"' and a.HEADID='"+rsHead.getString("headid")+"' order by SEQID   " ;
	rsQues=db.getRowset(QryQues);
	//out.print(QryQues);
	while(rsQues.next()){


		id++;
		Qslno++;
		seq=0;

	%><tr>
	<td style="width:5%" ><%=Qslno%></td>
	<td style="width:52%" align=left >

	<INPUT TYPE="hidden" NAME="Head<%=id%>"  value="<%=rsHead.getString("headid")%>" >
	<INPUT TYPE="hidden" NAME="question<%=id%>"  value="<%=rsQues.getString("QUESTIONID")%>" ><%=rsQues.getString("QUESTIONBODY")%></td>
	<!-- <td  align=left  style="width:30%"> --><!-- <%=rsQues.getString("EVALUATIONGUIDELINE")%>  -->
     <%
		//out.print(xSTATUS);
		if(!xSTATUS.equals("S"))    {

		QryRating= " SELECT  distinct  b.SUBJECTIVE SUBJECTIVE,a.rating ,A.RATINGDESC RATINGDESC ,A.RATINGID,a.defaultvalue,nvl(A.EVALUATIONVALUE,a.defaultvalue) value,B.EVALUATIONGUIDELINE,B.RATINGCODE,B.SEQID  FROM   AP#RATINGDETAIL a, AP#RATINGmaster b WHERE       A.RATINGID = B.RATINGID          AND A.FEEDBACKID = B.FEEDBACKID    AND A.INSTITUTECODE = B.INSTITUTECODE  and  a.ratingid='"+rsQues.getString("ratingid")+"' and a.feedbackid='"+mFeedbakid+"'  AND a.institutecode = '"+xInstCode+"'  order by  B.SEQID ";
	rsRating=db.getRowset(QryRating);
	 ///out.print(QryRating);

	while(rsRating.next()){

	

	if(rsRating.getString("SUBJECTIVE").equals("Y")){
	seq++;
	if(seq==1){
	%>

	<!--  <%=rsRating.getString("EVALUATIONGUIDELINE")%>  -->
	<td    style="width: 24%"  >
	
	

<%

/* 
		{
QryTransid= " select distinct TRANSID from AP#FACULTYFEEDBACK where  fstid in (   SELECT   DISTINCT fstid  FROM   v#studentltpdetail a  WHERE       a.institutecode =  '"+xInstCode+"'   AND examcode = '"+xexamcode+"'   AND ltp = '"+nLTP+"'    AND subjectid = '"+nSubject+"'     AND employeeid = '"+mChkMemID+"'     AND EXISTS                (SELECT   B.FSTID        FROM   AP#FEEDBACKSUBJECTTAGGING b            WHERE       A.FSTID = B.FSTID   AND FEEDBACKID = '"+mFeedbakid+"'              AND A.INSTITUTECODE = B.INSTITUTECODE    AND A.EXAMCODE = B.EXAMCODE  AND b.feedbackid = '"+mFeedbakid+"'   AND examcode = '"+xexamcode+"' AND b.institutecode = '"+xInstCode+"'                          AND TRUNC (SYSDATE) >= TRUNC (b.EVENTFROMDATE)    AND TRUNC (SYSDATE) <= TRUNC (b.EVENTTODATE)   AND NVL (b.approved, 'Y') = 'Y'                          AND NVL (b.deactive, 'N') = 'N' )  ) ";
rsTrans=db.getRowset(QryTransid);
//out.print(QryRating);
if(rsTrans.next()){
vTrans=rsTrans.getString("TRANSID");
}

*/

%>



	<INPUT TYPE="<%=Show%>"  placeholder="Type your FeedBack" NAME="Rating<%=id%>"  ></td>


	<%
	}
	} else {

	seq++;
			//out.print(QryRating);
			 if(seq==1){
			%>
			 <!-- <%=rsRating.getString("EVALUATIONGUIDELINE")%></td> -->
	<td   style="width: 24%" ><select NAME="Rating<%=id%>" id="rating<%=id%>" tabindex="0"   >


			<%
			 }
			 if(seq==1){
			%>
					<OPTION selected Value="NONE"><b><--  Choose Ratiing  --></b></option>
				<%
				}

	QryRatingv= " SELECT  distinct a.rating ,A.RATINGDESC RATINGDESC ,A.RATINGID,a.defaultvalue,nvl(A.EVALUATIONVALUE,a.defaultvalue) value,B.EVALUATIONGUIDELINE,B.RATINGCODE,B.SEQID FROM AP#RATINGDETAIL a, AP#RATINGmaster b WHERE A.RATINGID = B.RATINGID AND A.FEEDBACKID = B.FEEDBACKID AND A.INSTITUTECODE = B.INSTITUTECODE and  a.ratingid='"+rsRating.getString("ratingid")+"' and a.feedbackid='"+mFeedbakid+"'  AND a.institutecode = '"+xInstCode+"'  order by  B.SEQID ";
	rsRatingv=db.getRowset(QryRatingv);
	//out.print(QryRating);
	while(rsRatingv.next()){
				 if(seq==1){
			
						%>
					 <OPTION Value =<%=rsRatingv.getString("value")%>><%=rsRatingv.getString("RATINGDESC")%></OPTION>
					<%
				 }
				
	}
	%>
	</select></td>
	<%
	}
	}
	%><td   style="width:23%"><INPUT TYPE="<%=Show%>" placeholder="Type your Remarks" NAME="UserRemark<%=id%>"></td>
	</tr>
	<%/*-----------------------Updated By Gyan on Friday-27-feb-2015(Start)------------- */
}else if(xSTATUS.equals("S")&&vDocMode.equals("D")) {
qryAns=" SELECT   a.SUBJECTIVEANSWER || ' '||b.RATINGDESC Ans, nvl(a.FEEDBACKREMARKS,'N/A')FEEDBACKREMARKS,a.EVALUATIONVALUE  FROM  " +
        " AP#FACULTYFEEDBACKDETAIL a,         AP#RATINGDETAIL b,         AP#FACULTYQUESTIONMASTER c  WHERE     " +
        "  A.QUESTIONID = C.QUESTIONID and A.HEADID=C.HEADID         AND A.FEEDBACKID = c.FEEDBACKID     " +
        "    AND A.INSTITUTECODE = C.INSTITUTECODE and A.EVALUATIONVALUE=B.EVALUATIONVALUE       " +
        "  and B.RATINGID=C.RATINGID and B.FEEDBACKID=C.FEEDBACKID and B.EXAMCODE=C.EXAMCODE      " +
        "    AND a.transid = '"+vTrans+"'      AND a.questionid = '"+rsQues.getString("QUESTIONID")+"' ";
	rsAns=db.getRowset(qryAns);
	
if(rsAns.next()){
//out.print(qryAns+"<br>");
xAns=rsAns.getString("Ans").trim();
xAnsRemarks=rsAns.getString("FEEDBACKREMARKS").trim();
}else
{
xAns="";
xAnsRemarks="";
}

QryRating= " SELECT  distinct  b.SUBJECTIVE SUBJECTIVE,a.rating ,A.RATINGDESC RATINGDESC ,A.RATINGID,a.defaultvalue,nvl(A.EVALUATIONVALUE,a.defaultvalue) value,B.EVALUATIONGUIDELINE,B.RATINGCODE,B.SEQID  FROM   AP#RATINGDETAIL a, AP#RATINGmaster b WHERE       A.RATINGID = B.RATINGID          AND A.FEEDBACKID = B.FEEDBACKID    AND A.INSTITUTECODE = B.INSTITUTECODE  and  a.ratingid='"+rsQues.getString("ratingid")+"' and a.feedbackid='"+mFeedbakid+"'  AND a.institutecode = '"+xInstCode+"'  order by  B.SEQID ";
	rsRating=db.getRowset(QryRating);
	 ///out.print(QryRating);

	while(rsRating.next()){



	if(rsRating.getString("SUBJECTIVE").equals("Y")){
	seq++;
	if(seq==1){
	%>

	<!--  <%=rsRating.getString("EVALUATIONGUIDELINE")%>  -->
	<td    style="width: 24%"  >



<%


/*QryTransid= " select distinct TRANSID from AP#FACULTYFEEDBACK where  fstid in (   SELECT   DISTINCT fstid  FROM   v#studentltpdetail a  WHERE       a.institutecode =  '"+xInstCode+"'   AND examcode = '"+xexamcode+"'   AND ltp = '"+nLTP+"'    AND subjectid = '"+nSubject+"'     AND employeeid = '"+mChkMemID+"'     AND EXISTS                (SELECT   B.FSTID        FROM   AP#FEEDBACKSUBJECTTAGGING b            WHERE       A.FSTID = B.FSTID   AND FEEDBACKID = '"+mFeedbakid+"'              AND A.INSTITUTECODE = B.INSTITUTECODE    AND A.EXAMCODE = B.EXAMCODE  AND b.feedbackid = '"+mFeedbakid+"'   AND examcode = '"+xexamcode+"' AND b.institutecode = '"+xInstCode+"'                          AND TRUNC (SYSDATE) >= TRUNC (b.EVENTFROMDATE)    AND TRUNC (SYSDATE) <= TRUNC (b.EVENTTODATE)   AND NVL (b.approved, 'Y') = 'Y'                          AND NVL (b.deactive, 'N') = 'N' )  ) ";

       	rsTrans=db.getRowset(QryTransid);
	//out.print(QryRating);
	if(rsTrans.next()){
vTrans=rsTrans.getString("TRANSID");

	}*/
%>

	<INPUT TYPE="<%=Show%>"  placeholder="Type your FeedBack" NAME="Rating<%=id%>"  ></td>


	<%
	}
	} else {

	seq++;
			//out.print(QryRating);
			 if(seq==1){
			%>
			 <!-- <%=rsRating.getString("EVALUATIONGUIDELINE")%></td> -->
	<td   style="width: 24%" >
        <select NAME="Rating<%=id%>" id="rating<%=id%>" tabindex="0"  >
            <%
			 }
			 if(seq==1){
			%>
					<OPTION  Value="NONE"><b><--  Choose Ratiing  --></b></option>
				<%
				}

	QryRatingv= " SELECT  distinct a.rating ,A.RATINGDESC RATINGDESC ,A.RATINGID,a.defaultvalue,nvl(A.EVALUATIONVALUE,a.defaultvalue) value,B.EVALUATIONGUIDELINE,B.RATINGCODE,B.SEQID FROM AP#RATINGDETAIL a, AP#RATINGmaster b WHERE A.RATINGID = B.RATINGID AND A.FEEDBACKID = B.FEEDBACKID AND A.INSTITUTECODE = B.INSTITUTECODE and  a.ratingid='"+rsRating.getString("ratingid")+"' and a.feedbackid='"+mFeedbakid+"'  AND a.institutecode = '"+xInstCode+"'  order by  B.SEQID ";
	rsRatingv=db.getRowset(QryRatingv);
	//System.out.print(QryRatingv);
	while(rsRatingv.next()){
				 if(seq==1){

            //     System.out.print(rsRatingv.getString("RATINGDESC").equals(xAns));
                 if(rsRatingv.getString("RATINGDESC").equals(xAns))
                 {%>
                  <OPTION selected Value =<%=rsRatingv.getString("value")%>><%=rsRatingv.getString("RATINGDESC")%></OPTION>
                 <%}else{
						%>
					 <OPTION Value =<%=rsRatingv.getString("value")%>><%=rsRatingv.getString("RATINGDESC")%></OPTION>
					<%
				 }
        }}
	%>
	</select></td>
	<%
	}
	}
	%><td   style="width:23%"><INPUT TYPE="<%=Show%>" placeholder="Type your Remarks" NAME="UserRemark<%=id%>" value="<%=xAnsRemarks%>"></td>




<%

/*-----------------------Updated By Gyan on Friday-27-feb-2015(End)------------- */

} else {


		qryAns=" SELECT   nvl(b.RATINGDESC,'N/A') Ans, nvl(a.FEEDBACKREMARKS,'N/A')FEEDBACKREMARKS,a.EVALUATIONVALUE  FROM   AP#FACULTYFEEDBACKDETAIL a,         AP#RATINGDETAIL b,         AP#FACULTYQUESTIONMASTER c  WHERE       A.QUESTIONID = C.QUESTIONID and A.HEADID=C.HEADID         AND A.FEEDBACKID = c.FEEDBACKID         AND A.INSTITUTECODE = C.INSTITUTECODE and A.EVALUATIONVALUE=B.EVALUATIONVALUE         and B.RATINGID=C.RATINGID and B.FEEDBACKID=C.FEEDBACKID and B.EXAMCODE=C.EXAMCODE          AND a.transid = '"+vTrans+"'      AND a.questionid = '"+rsQues.getString("QUESTIONID")+"' ";
	rsAns=db.getRowset(qryAns);
	//out.print(qryAns);
if(rsAns.next()){

xAns=rsAns.getString("Ans");
xAnsRemarks=rsAns.getString("FEEDBACKREMARKS");
}else{
xAns="";
xAnsRemarks="";
}

/*-----------------------Updated By Gyan on Friday-27-feb-2015(Start)------------- */


%><td  colspan=3 style="width:25%"><%=xAns%></td>




<%
	/*-----------------------Updated By Mohit on 01-05-2015------------- */

%>








<td colspan=4 style="width:19%"><%=xAnsRemarks%></td><%
	}
	}
	//CHILD 
	QryHeadcHILD= " select headid, headcode || '-' || headdesc head from AP#FACULTYQUESTIONHEAD where institutecode='"+xInstCode+"' and COMPONENTTYPE='"+nLTP+"' and examcode='"+xexamcode+"' and  feedbackid='"+mFeedbakid+"' and   PARENTHEADID ='"+rsHead.getString("headid")+"' order by SEQID  " ;
	rsHeadcHILD=db.getRowset(QryHeadcHILD);
	 //out.print(QryHeadcHILD);
	while(rsHeadcHILD.next())  {
	 

	//out.print("*********************");

	QryQuesc="  SELECT DISTINCT a.seqid, a.ratingid , nvl(a.QUESTIONBODY,'N') QUESTIONBODY ,a.QUESTIONID,nvl(a.EVALUATIONGUIDELINE,'N/A') EVALUATIONGUIDELINE, a.COMPONENTTYPE from   AP#FACULTYQUESTIONMASTER a  where a.institutecode='"+xInstCode+"'  and COMPONENTTYPE='"+nLTP+"' and  a.examcode='"+xexamcode+"' and a.feedbackid='"+mFeedbakid+"' and a.HEADID='"+rsHeadcHILD.getString("headid")+"' order by SEQID   " ;
	rsQuesc=db.getRowset(QryQuesc);
	//out.print(QryQuesc);
	while(rsQuesc.next())  {
		Qslnoc++;
		id++;
		seqc=0;
		%>
	<tr>
	<td    style="width:3%"><%=Qslno%>-<%=Qslnoc%></td>
	<INPUT TYPE="hidden" NAME="Head<%=id%>"  value="<%=rsHeadcHILD.getString("headid")%>" >
	<INPUT TYPE="hidden" NAME="question<%=id%>"  value="<%=rsQuesc.getString("QUESTIONID")%>"> 
	<td align=left  style="width:52%"><%=rsQuesc.getString("QUESTIONBODY")%></td>
	<%




	
	%>
	<!-- <td align=left   style="width:30%"><%=rsQuesc.getString("EVALUATIONGUIDELINE")%>  -->
	<%
if(!xSTATUS.equals("S")) {
	QryRatingc= " SELECT  distinct  b.SUBJECTIVE SUBJECTIVE,a.rating ,A.RATINGDESC RATINGDESC ,A.RATINGID,a.defaultvalue,nvl(A.EVALUATIONVALUE,a.defaultvalue) value,B.EVALUATIONGUIDELINE,B.RATINGCODE,B.SEQID  FROM  AP#RATINGDETAIL a, AP#RATINGmaster b WHERE  A.RATINGID = B.RATINGID AND A.FEEDBACKID = B.FEEDBACKID AND A.INSTITUTECODE = B.INSTITUTECODE  and  a.ratingid='"+rsQuesc.getString("ratingid")+"' and a.feedbackid='"+mFeedbakid+"'  and a.examcode='"+xexamcode+"' AND a.institutecode =  '"+xInstCode+"'  order by  B.SEQID ";
	rsRatingc=db.getRowset(QryRatingc);
	//out.print(QryRating);

	while(rsRatingc.next()){

		

	if(rsRatingc.getString("SUBJECTIVE").equals("Y")){
	seqc++;
	if(seqc==1){
	%>
	<!--  <%=rsRatingc.getString("EVALUATIONGUIDELINE")%>  -->
	<td style="width: 20%" name="rating" id="rating"><INPUT TYPE="text" placeholder="Type your FeedBack" NAME="Rating<%=id%>" ></td>
	<%
	}
	} else {

	seqc++;
	//out.print(QryRating);
	 if(seqc==1) {
			%>
			 <!-- <%=rsRatingc.getString("EVALUATIONGUIDELINE")%></td> -->
	<td style="width: 20%" ><select NAME="Rating<%=id%>" id="rating<%=id%>" tabindex="0"  >
		<%
			 }
			 if(seqc==1){
			%>
					<OPTION selected Value="NONE"><b><--  Choose Ratiing  --></b></option>
				<%
				}


	QryRatingvc= " SELECT  distinct a.rating ,A.RATINGDESC RATINGDESC ,A.RATINGID,a.defaultvalue,nvl(A.EVALUATIONVALUE,a.defaultvalue) value,B.EVALUATIONGUIDELINE,B.RATINGCODE,B.SEQID  FROM   AP#RATINGDETAIL a, AP#RATINGmaster b WHERE       A.RATINGID = B.RATINGID          AND A.FEEDBACKID = B.FEEDBACKID    AND A.INSTITUTECODE = B.INSTITUTECODE  and  a.ratingid='"+rsRatingc.getString("ratingid")+"' and a.feedbackid='"+mFeedbakid+"'  AND a.institutecode = '"+xInstCode+"'  order by  B.SEQID ";
	rsRatingvc=db.getRowset(QryRatingvc);
	//out.print(QryRatingvc);
	while(rsRatingvc.next()){

				 if(seqc==1){
					
						%>
					 <OPTION Value =<%=rsRatingvc.getString("value")%>><%=rsRatingvc.getString("RATINGDESC")%></option>
					<%
				 }
				
	}
	%>
	</select></td>
	<%
	}
	}

	%><td style="width:15%"><INPUT TYPE="text"  placeholder="Type your Remarks" NAME="UserRemark<%=id%>"></td>
	</tr>
	<%
/*---------------------------Updated By Gyan(27-02-2015) Start-------------------*/


}else if(xSTATUS.equals("S")&&vDocMode.equals("D")){
    qryAns=" SELECT   a.SUBJECTIVEANSWER || ' '||b.RATINGDESC Ans, nvl(a.FEEDBACKREMARKS,'N/A') FEEDBACKREMARKS ,a.EVALUATIONVALUE  FROM   AP#FACULTYFEEDBACKDETAIL a,         AP#RATINGDETAIL b,         AP#FACULTYQUESTIONMASTER c  WHERE       A.QUESTIONID = C.QUESTIONID and A.HEADID=C.HEADID         AND A.FEEDBACKID = c.FEEDBACKID         AND A.INSTITUTECODE = C.INSTITUTECODE and A.EVALUATIONVALUE=B.EVALUATIONVALUE         and B.RATINGID=C.RATINGID and B.FEEDBACKID=C.FEEDBACKID and B.EXAMCODE=C.EXAMCODE          AND a.transid = '"+vTrans+"'      AND a.questionid = '"+rsQuesc.getString("QUESTIONID")+"' ";
	rsAns=db.getRowset(qryAns);
	//out.print(qryAns);
if(rsAns.next()){
xAns=rsAns.getString("Ans").trim();
xAnsRemarks=rsAns.getString("FEEDBACKREMARKS").trim();
}else
{
xAns="";
xAnsRemarks="";
}
    
 	QryRatingc= " SELECT  distinct  b.SUBJECTIVE SUBJECTIVE,a.rating ,A.RATINGDESC RATINGDESC ,A.RATINGID,a.defaultvalue,nvl(A.EVALUATIONVALUE,a.defaultvalue) value,B.EVALUATIONGUIDELINE,B.RATINGCODE,B.SEQID  FROM  AP#RATINGDETAIL a, AP#RATINGmaster b WHERE  A.RATINGID = B.RATINGID AND A.FEEDBACKID = B.FEEDBACKID AND A.INSTITUTECODE = B.INSTITUTECODE  and  a.ratingid='"+rsQuesc.getString("ratingid")+"' and a.feedbackid='"+mFeedbakid+"'  and a.examcode='"+xexamcode+"' AND a.institutecode =  '"+xInstCode+"'  order by  B.SEQID ";
	rsRatingc=db.getRowset(QryRatingc);
	//out.print(QryRating);

	while(rsRatingc.next()){

		

	if(rsRatingc.getString("SUBJECTIVE").equals("Y")){
	seqc++;
	if(seqc==1){
	%>
	<!--  <%=rsRatingc.getString("EVALUATIONGUIDELINE")%>  -->
	<td style="width: 20%" name="rating" id="rating"><INPUT TYPE="text" placeholder="Type your FeedBack" NAME="Rating<%=id%>" ></td>
	<%
	}
	} else {

	seqc++;
	//out.print(QryRating);
	 if(seqc==1) {
			%>
			 <!-- <%=rsRatingc.getString("EVALUATIONGUIDELINE")%></td> -->
	<td style="width: 20%" ><select NAME="Rating<%=id%>" id="rating" tabindex="0"  >
		<%
			 }
			 if(seqc==1){
			%>
					<OPTION  Value="NONE"><b><--  Choose Ratiing  --></b></option>
				<%
				}


	QryRatingvc= " SELECT  distinct a.rating ,A.RATINGDESC RATINGDESC ,A.RATINGID,a.defaultvalue,nvl(A.EVALUATIONVALUE,a.defaultvalue) value,B.EVALUATIONGUIDELINE,B.RATINGCODE,B.SEQID  FROM   AP#RATINGDETAIL a, AP#RATINGmaster b WHERE       A.RATINGID = B.RATINGID          AND A.FEEDBACKID = B.FEEDBACKID    AND A.INSTITUTECODE = B.INSTITUTECODE  and  a.ratingid='"+rsRatingc.getString("ratingid")+"' and a.feedbackid='"+mFeedbakid+"'  AND a.institutecode = '"+xInstCode+"'  order by  B.SEQID ";
	rsRatingvc=db.getRowset(QryRatingvc);
	//out.print(QryRatingvc);
	while(rsRatingvc.next()){

				 if(seqc==1){
					if(rsRatingvc.getString("RATINGDESC").equals(xAns))
						{
                    %>
                  	<OPTION  SELECTED Value =<%=rsRatingvc.getString("value")%>><%=rsRatingvc.getString("RATINGDESC")%></option>

                  <%
                    }else{%>
					 <OPTION Value =<%=rsRatingvc.getString("value")%>><%=rsRatingvc.getString("RATINGDESC")%></option>
					<%
				 }
				
	}}
	%>
	</select></td>
	<%
	}
	}
    %><td style="width:15%"><INPUT TYPE="text"  placeholder="Type your Remarks" NAME="UserRemark<%=id%>" value="<%=xAnsRemarks%>"></td>
    <%       
     }
        else if(vDocMode.equals("F"))
	{
	
		qryAns=" SELECT nvl(b.RATINGDESC,'N/A') Ans, nvl(a.FEEDBACKREMARKS,'N/A') FEEDBACKREMARKS ,a.EVALUATIONVALUE  FROM   AP#FACULTYFEEDBACKDETAIL a,         AP#RATINGDETAIL b,         AP#FACULTYQUESTIONMASTER c  WHERE       A.QUESTIONID = C.QUESTIONID and A.HEADID=C.HEADID         AND A.FEEDBACKID = c.FEEDBACKID         AND A.INSTITUTECODE = C.INSTITUTECODE and A.EVALUATIONVALUE=B.EVALUATIONVALUE         and B.RATINGID=C.RATINGID and B.FEEDBACKID=C.FEEDBACKID and B.EXAMCODE=C.EXAMCODE          AND a.transid = '"+vTrans+"'      AND a.questionid = '"+rsQuesc.getString("QUESTIONID")+"' ";
	rsAns=db.getRowset(qryAns);
	//out.print(qryAns);
if(rsAns.next()){
xAns=rsAns.getString("Ans");
xAnsRemarks=rsAns.getString("FEEDBACKREMARKS");
} else {
xAns="";
xAnsRemarks="";
}

/*    */

%><td   colspan=3  style="width:20%"  ><%=xAns%></td><td colspan=4 style="width:15%"><%=xAnsRemarks%></td><%/**/
	}

/*---------------------------12345Updated By Gyan(27-02-2015) End-------------------*/
	}
	}
	}
	%>
	<INPUT TYPE="hidden" NAME="ID" value="<%=id%>"><tr><td colspan=10 align=right bgcolor=skyblue  > 
<INPUT TYPE="hidden" NAME="STATUS" value="<%=xSTATUS%>">
<INPUT TYPE="hidden" NAME="TRANS" value="<%=vTrans%>">
<%
	
if(!xSTATUS.equals("S")) {
%>


<INPUT TYPE="hidden" NAME="DEL" value="S">

	<INPUT Type="submit" class="button"   Value="&nbsp;Draft Save&nbsp;">
	    <INPUT Type="submit" class="button" onclick="{document.frm1.DEL.value='FS';document.frm1.submit();}"   Value="Final Save">

	<%
}else
{	
	%>





 
<INPUT TYPE="hidden" NAME="DEL" value="D">

 

<%
qry="select nvl(docmode,'D') docmode from AP#FACULTYFEEDBACK   where TRANSID='"+vTrans+"' and INSTITUTECODE='"+xInstCode+"' and EXAMCODE='"+xexamcode+"' and FEEDBACKID='"+mFeedbakid+"'";
//out.print(qry);
rs=db.getRowset(qry);
if(rs.next())
{
vDocMode=rs.getString("docmode")==null?"":rs.getString("docmode").trim();
}
if(!vDocMode.equals("F")){
%>
    <INPUT Type="submit" class="button" onclick="{document.frm1.DEL.value=DEL.value;document.frm1.submit();}"   Value="Reset">
	<INPUT Type="submit" class="button" onclick="{document.frm1.DEL.value='DS';document.frm1.submit();}"   Value="Draft Save">

    <INPUT Type="submit" class="button" onclick="{document.frm1.DEL.value='F';document.frm1.submit();}"   Value="Final Save">
<%}%>
	
	<INPUT Type="button" class="button"   Value="Print" onClick="window.print()">

<%
	}%>
		<!-- <input type="button"  class="button"    id="finalSaveForm" style="cursor:pointer;"  value="&nbsp;Final Save&nbsp;"> -->
		</td></tr>
		</table>
	</form>
	<%
			} 	
		}else{
			
			%>
		<CENTER><BR>
		<font color=red>
		<h3>	<br><img src='../../Images/Error1.jpg'>Select All Mandantry Fields!! 
		</font></CENTER>
		<%
			}	

	   }

	   if(request.getParameter("xy")!=null)
		{
	%>
	<form name="frm2"  method="post">


	<%

	int xID=0;
		
	  if(request.getParameter("ID")!=null && !request.getParameter("ID").equals("NONE"))
		   {
			mID=request.getParameter("ID")==null?"":request.getParameter("ID").trim();
		   }
			 
		 
		xID = Integer.parseInt(mID);
		if(request.getParameter("STATUS")!=null && !request.getParameter("STATUS").equals("NONE"))
		   {
			xSTATUS=request.getParameter("STATUS")==null?"":request.getParameter("STATUS").trim();
		   }


if(request.getParameter("transactionDate")!=null && !request.getParameter("transactionDate").equals("NONE"))
		   {
			xtransactionDate=request.getParameter("transactionDate")==null?"":request.getParameter("transactionDate").trim();
		   }




if(request.getParameter("TRANS")!=null && !request.getParameter("TRANS").equals("NONE"))
		   {
			vTrans=request.getParameter("TRANS")==null?"":request.getParameter("TRANS").trim();
		   }

	 
String Delete =request.getParameter("DEL")==null?"S":request.getParameter("DEL").toString().trim();

 
//out.print("***>"+Delete+"<****");
 




	 if(request.getParameter("SubjectRadio")!=null && !request.getParameter("SubjectRadio").equals("NONE"))
		   {
			mSubjectRadio=request.getParameter("SubjectRadio")==null?"":request.getParameter("SubjectRadio").trim();
		   }




if(request.getParameter("LTP")!=null && !request.getParameter("LTP").equals("NONE"))
		   {
			mLTP=request.getParameter("LTP")==null?"":request.getParameter("LTP").trim();
		   }

	  
	 if(request.getParameter("examcode")!=null && !request.getParameter("examcode").equals("NONE"))
		   {
			xexamcode=request.getParameter("examcode")==null?"":request.getParameter("examcode").trim();
		   }

	 if(request.getParameter("FeeDCode")!=null && !request.getParameter("FeeDCode").equals("NONE"))
		   {
			mFeedbakid=request.getParameter("FeeDCode")==null?"":request.getParameter("FeeDCode").trim();
		   }

	 

if(request.getParameter("InstCode")!=null && !request.getParameter("InstCode").equals("NONE"))
		   {
			xInstCode=request.getParameter("InstCode")==null?"":request.getParameter("InstCode").trim();
		   }

//out.print(">"+Delete+"<");

//out.print(">GYAN");

 if(!Delete.equals("D")&&!Delete.equals("F")&&!Delete.equals("DS")&&!Delete.equals("FS")) {


	 
qry=" select 'FECFEE'|| lpad(nvl(max(substr(TRANSID,7)),0)+1,14,0) TRANSID  from  AP#FACULTYFEEDBACK  ";
		rs=db.getRowset(qry);
		//System.out.print(qry);

		if(rs.next())
			{
			TRANSID=rs.getString("TRANSID").trim();
			}
	Qrydetail =" select distinct fstid ,ltp from v#studentltpdetail  a  where  a.institutecode = '"+xInstCode+"' and examcode='"+xexamcode+"'  and ltp='"+mLTP+"' and subjectid='"+mSubjectRadio+"'   AND ( (employeeid = '"+mChkMemID+"') or  EXISTS ( SELECT c.employeeid   FROM MULTIFACULTYSUBJECTTAGGING c             WHERE a.fstid = c.fstid               AND a.institutecode = c.institutecode     and c.employeeid = '"+mChkMemID+"'         ))  AND exists ( SELECT   B.FSTID  FROM   AP#FEEDBACKSUBJECTTAGGING b WHERE    A.FSTID=B.FSTID  and FEEDBACKID='"+mFeedbakid+"'  and A.INSTITUTECODE=B.INSTITUTECODE  and A.EXAMCODE=B.EXAMCODE and   b.feedbackid = '"+mFeedbakid+"' and examcode='"+xexamcode+"'   AND b.institutecode = '"+xInstCode+"'  AND TRUNC (SYSDATE) >= TRUNC (b.EVENTFROMDATE) AND TRUNC (SYSDATE) <= TRUNC (b.EVENTTODATE) AND NVL (b.approved, 'Y') = 'Y' and nvl(b.deactive,'N')='N' ) ";
	rsDetail=db.getRowset(Qrydetail);
	  // System.out.print("****"+Qrydetail);
	while(rsDetail.next()){
/*---------------------Updated By Gyan on 27-feb-2015 Start-----------*/
/*qry="select nvl(Docmode,'D') Docmode from AP#FACULTYFEEDBACK where TRANSID='"+TRANSID+"' and COMPANYCODE='"+mComp+"' and INSTITUTECODE='"+xInstCode+"' and EXAMCODE='"+xexamcode+"' and FEEDBACKID='"+mFeedbakid+"' and FSTID='"+rsDetail.getString("fstid")+"'";
rs=db.getRowset(qry);
if(rs.next())
{
vDocMode=rs.getString("Docmode").trim();
qryUpdate="update AP#FACULTYFEEDBACK set Docmode='F' where TRANSID='"+TRANSID+"' and COMPANYCODE='"+mComp+"' and INSTITUTECODE='"+xInstCode+"' and EXAMCODE='"+xexamcode+"' and FEEDBACKID='"+mFeedbakid+"' and FSTID='"+rsDetail.getString("fstid")+"'";
pp=db.update(qryUpdate);
}
else
{*/
qryin1="  INSERT INTO AP#FACULTYFEEDBACK ( TRANSID, COMPANYCODE, INSTITUTECODE, EXAMCODE, FEEDBACKID, FSTID, DOCMODE, DEACTIVE, ENTRYBY, ENTRYDATE,TRANSACTIONDATE) VALUES ( '"+TRANSID+"','"+mComp+"' ,'"+xInstCode+"' , '"+xexamcode+"','"+mFeedbakid+"' ,'"+rsDetail.getString("fstid")+"' ,'D' ,'N' ,'"+mChkMemID+"' ,sysdate, to_date('"+xtransactionDate+"','DD-MM-YYYY') )" ;
//out.print(qryin1);
System.out.print(qryin1+"11");
pp=db.insertRow(qryin1);
/*---------------------Updated By Gyan on 27-feb-2015 End-----------*/
	}

//	out.print(xFstid+ " -------- " +xID);


try{

	for(int zx = 1; zx <= xID; zx++) {

	 if(request.getParameter("question"+zx+"")!=null && !request.getParameter("question"+zx+"").equals("NONE"))
		   {
			xquestion=request.getParameter("question"+zx+"").toString().trim();
		   }


		   if(request.getParameter("Head"+zx+"")!=null && !request.getParameter("Head"+zx+"").equals("NONE"))
		   {
			xHead=request.getParameter("Head"+zx+"").toString().trim();
		   }
	  
        /*Change By Gyan at 27-feb-2015 start*/
	    xRating=request.getParameter("Rating"+zx+"").equals("NONE")?"":request.getParameter("Rating"+zx+"").toString().trim();
		xUserRemark=request.getParameter("UserRemark"+zx+"")==null?"":request.getParameter("UserRemark"+zx+"").toString().trim();
        /*Change By Gyan at 27-feb-2015 end*/

	 
	 /* if(request.getParameter("UserRemark"+zx+"")!=null && !request.getParameter("UserRemark"+zx+"").equals("NONE"))
		   {
			
		   }*/

      //  out.print(zx+">>>>>>>>>>>>>"+xRating+"##############"+request.getParameter("Rating"+zx+"").toString().trim()+"<br>");


subchk= " select 'Y' from AP#RATINGMASTER  where  nvl(SUBJECTIVE,'N')='Y' and RATINGID in ( SELECT   ratingid   FROM   AP#FACULTYQUESTIONMASTER WHERE       QUESTIONID =     '"+xquestion+"'  AND HEADID = '"+xHead+"'  AND COMPONENTTYPE = '"+mLTP+"'   AND FEEDBACKID = '"+mFeedbakid+"'   AND EXAMCODE = '"+xexamcode+"'   AND INSTITUTECODE = '"+xInstCode+"' AND COMPANYCODE = '"+mComp+"' ) " ;


	rschksub=db.getRowset(subchk);
	   // out.print(subchk);
	if(rschksub.next()) {
 


qryin2=" INSERT INTO AP#FACULTYFEEDBACKDETAIL ( TRANSID, COMPANYCODE, INSTITUTECODE,  EXAMCODE, FEEDBACKID, COMPONENTTYPE, HEADID, QUESTIONID,EVALUATIONVALUE, SUBJECTIVEANSWER,       FEEDBACKREMARKS,   STAFFTYPE, STAFFID, DEACTIVE,   ENTRYBY, ENTRYDATE) VALUES ( '"+TRANSID+"', '"+mComp+"','"+xInstCode+"' ,'"+xexamcode+"' ,'"+mFeedbakid+"' ,'"+mLTP+"' ,'"+xHead+"' ,'"+xquestion+"' ,'0','"+xRating+"'  ,'"+xUserRemark+"' ,'"+mChkMType+"' ,'"+mChkMemID+"' ,'N' ,'"+mChkMemID+"' ,sysdate ) ";
//

//System.out.print(qryin2+"1");
	 nn=db.insertRow(qryin2);
	 %>
<!--script language=javascript>
alert("You have Sucessfully submitted your request");	
</script-->
<%
		
	}else{
	
	qryin2=" INSERT INTO AP#FACULTYFEEDBACKDETAIL ( TRANSID, COMPANYCODE, INSTITUTECODE,  EXAMCODE, FEEDBACKID, COMPONENTTYPE, HEADID, QUESTIONID, SUBJECTIVEANSWER,     MALICIOUSCONTENT, EVALUATIONVALUE, FEEDBACKREMARKS,   STAFFTYPE, STAFFID, DEACTIVE,   ENTRYBY, ENTRYDATE) VALUES ( '"+TRANSID+"', '"+mComp+"','"+xInstCode+"' ,'"+xexamcode+"' ,'"+mFeedbakid+"' ,'"+mLTP+"' ,'"+xHead+"' ,'"+xquestion+"' ,'' ,'' ,'"+xRating+"' ,'"+xUserRemark+"' ,'"+mChkMType+"' ,'"+mChkMemID+"' ,'N' ,'"+mChkMemID+"' ,sysdate ) ";
	// System.out.print(qryin2+"2");
	 nn=db.insertRow(qryin2);

%>
<!--script language=javascript>
alert("You have Sucessfully submitted your request");	
</script-->
<%
	}
	}}catch(Exception e)
    {
    out.print(e);
    }
	%>

	</form>
			<%

		}else if(Delete.equals("FS")){
            qry=" select 'FECFEE'|| lpad(nvl(max(substr(TRANSID,7)),0)+1,14,0) TRANSID  from  AP#FACULTYFEEDBACK  ";
		rs=db.getRowset(qry);
		//System.out.print(qry);
		if(rs.next())
			{
			TRANSID=rs.getString("TRANSID").trim();
			}
	Qrydetail =" select distinct fstid ,ltp from v#studentltpdetail  a  where  a.institutecode = '"+xInstCode+"' and examcode='"+xexamcode+"'  and ltp='"+mLTP+"' and subjectid='"+mSubjectRadio+"' AND ( (employeeid = '"+mChkMemID+"') or  EXISTS ( SELECT c.employeeid   FROM MULTIFACULTYSUBJECTTAGGING c             WHERE a.fstid = c.fstid               AND a.institutecode = c.institutecode     and c.employeeid = '"+mChkMemID+"'         )) AND exists ( SELECT   B.FSTID  FROM   AP#FEEDBACKSUBJECTTAGGING b WHERE    A.FSTID=B.FSTID  and FEEDBACKID='"+mFeedbakid+"'  and A.INSTITUTECODE=B.INSTITUTECODE  and A.EXAMCODE=B.EXAMCODE and   b.feedbackid = '"+mFeedbakid+"' and examcode='"+xexamcode+"'   AND b.institutecode = '"+xInstCode+"'  AND TRUNC (SYSDATE) >= TRUNC (b.EVENTFROMDATE) AND TRUNC (SYSDATE) <= TRUNC (b.EVENTTODATE) AND NVL (b.approved, 'Y') = 'Y' and nvl(b.deactive,'N')='N' ) ";
	rsDetail=db.getRowset(Qrydetail);
	   //System.out.print("****"+Qrydetail);
	while(rsDetail.next()){
/*---------------------Updated By Gyan on 27-feb-2015 Start-----------*/
/*qry="select nvl(Docmode,'D') Docmode from AP#FACULTYFEEDBACK where TRANSID='"+TRANSID+"' and COMPANYCODE='"+mComp+"' and INSTITUTECODE='"+xInstCode+"' and EXAMCODE='"+xexamcode+"' and FEEDBACKID='"+mFeedbakid+"' and FSTID='"+rsDetail.getString("fstid")+"'";
rs=db.getRowset(qry);
if(rs.next())
{
vDocMode=rs.getString("Docmode").trim();
qryUpdate="update AP#FACULTYFEEDBACK set Docmode='F' where TRANSID='"+TRANSID+"' and COMPANYCODE='"+mComp+"' and INSTITUTECODE='"+xInstCode+"' and EXAMCODE='"+xexamcode+"' and FEEDBACKID='"+mFeedbakid+"' and FSTID='"+rsDetail.getString("fstid")+"'";
pp=db.update(qryUpdate);
}
else
{*/
qryin1="  INSERT INTO AP#FACULTYFEEDBACK ( TRANSID, COMPANYCODE, INSTITUTECODE, EXAMCODE, FEEDBACKID, FSTID, DOCMODE, DEACTIVE, ENTRYBY, ENTRYDATE,TRANSACTIONDATE) VALUES ( '"+TRANSID+"','"+mComp+"' ,'"+xInstCode+"' , '"+xexamcode+"','"+mFeedbakid+"' ,'"+rsDetail.getString("fstid")+"' ,'F' ,'N' ,'"+mChkMemID+"' ,sysdate, to_date('"+xtransactionDate+"','DD-MM-YYYY') )" ;
//out.print(qryin1);
System.out.print(qryin1+"11");
pp=db.insertRow(qryin1);
/*---------------------Updated By Gyan on 27-feb-2015 End-----------*/
	}

//	out.print(xFstid+ " -------- " +xID);


try{

	for(int zx = 1; zx <= xID; zx++) {

	 if(request.getParameter("question"+zx+"")!=null && !request.getParameter("question"+zx+"").equals("NONE"))
		   {
			xquestion=request.getParameter("question"+zx+"").toString().trim();
		   }


		   if(request.getParameter("Head"+zx+"")!=null && !request.getParameter("Head"+zx+"").equals("NONE"))
		   {
			xHead=request.getParameter("Head"+zx+"").toString().trim();
		   }
	  
        /*Change By Gyan at 27-feb-2015 start*/
	    xRating=request.getParameter("Rating"+zx+"").equals("NONE")?"":request.getParameter("Rating"+zx+"").toString().trim();
		xUserRemark=request.getParameter("UserRemark"+zx+"")==null?"":request.getParameter("UserRemark"+zx+"").toString().trim();
        /*Change By Gyan at 27-feb-2015 end*/

	 
	 /* if(request.getParameter("UserRemark"+zx+"")!=null && !request.getParameter("UserRemark"+zx+"").equals("NONE"))
		   {
			
		   }*/

      //  out.print(zx+">>>>>>>>>>>>>"+xRating+"##############"+request.getParameter("Rating"+zx+"").toString().trim()+"<br>");


subchk= " select 'Y' from AP#RATINGMASTER  where  nvl(SUBJECTIVE,'N')='Y' and RATINGID in ( SELECT   ratingid   FROM   AP#FACULTYQUESTIONMASTER WHERE       QUESTIONID =     '"+xquestion+"'  AND HEADID = '"+xHead+"'  AND COMPONENTTYPE = '"+mLTP+"'   AND FEEDBACKID = '"+mFeedbakid+"'   AND EXAMCODE = '"+xexamcode+"'   AND INSTITUTECODE = '"+xInstCode+"' AND COMPANYCODE = '"+mComp+"' ) " ;


	rschksub=db.getRowset(subchk);
	   // out.print(subchk);
	if(rschksub.next()) {
 


qryin2=" INSERT INTO AP#FACULTYFEEDBACKDETAIL ( TRANSID, COMPANYCODE, INSTITUTECODE,  EXAMCODE, FEEDBACKID, COMPONENTTYPE, HEADID, QUESTIONID,EVALUATIONVALUE, SUBJECTIVEANSWER,       FEEDBACKREMARKS,   STAFFTYPE, STAFFID, DEACTIVE,   ENTRYBY, ENTRYDATE) VALUES ( '"+TRANSID+"', '"+mComp+"','"+xInstCode+"' ,'"+xexamcode+"' ,'"+mFeedbakid+"' ,'"+mLTP+"' ,'"+xHead+"' ,'"+xquestion+"' ,'0','"+xRating+"'  ,'"+xUserRemark+"' ,'"+mChkMType+"' ,'"+mChkMemID+"' ,'N' ,'"+mChkMemID+"' ,sysdate ) ";
//System.out.print(qryin2+"");
	 nn=db.insertRow(qryin2);
	 %>
<script language=javascript>
alert("You have Sucessfully submitted your request");	
</script>
<%
		
	}else{
	
	qryin2=" INSERT INTO AP#FACULTYFEEDBACKDETAIL ( TRANSID, COMPANYCODE, INSTITUTECODE,  EXAMCODE, FEEDBACKID, COMPONENTTYPE, HEADID, QUESTIONID, SUBJECTIVEANSWER,     MALICIOUSCONTENT, EVALUATIONVALUE, FEEDBACKREMARKS,   STAFFTYPE, STAFFID, DEACTIVE,   ENTRYBY, ENTRYDATE) VALUES ( '"+TRANSID+"', '"+mComp+"','"+xInstCode+"' ,'"+xexamcode+"' ,'"+mFeedbakid+"' ,'"+mLTP+"' ,'"+xHead+"' ,'"+xquestion+"' ,'' ,'' ,'"+xRating+"' ,'"+xUserRemark+"' ,'"+mChkMType+"' ,'"+mChkMemID+"' ,'N' ,'"+mChkMemID+"' ,sysdate ) ";
	//System.out.print(qryin2);
	 nn=db.insertRow(qryin2);

%>
<!--script language=javascript>
alert("You have Sucessfully submitted your request");	
</script-->
<%
	}
	}}catch(Exception e)
    {
    out.print(e);
    }
	%>

	</form>
    <%










        }
else if(Delete.equals("D")){


QryDel=" delete from AP#FACULTYFEEDBACK where TRANSID='"+vTrans+"' and INSTITUTECODE='"+xInstCode+"' and EXAMCODE='"+xexamcode+"' and FEEDBACKID='"+mFeedbakid+"'   ";
//out.print(QryDel);
nnd=db.update(QryDel);

QryDel1=" delete from AP#FACULTYFEEDBACKDETAIL where TRANSID='"+vTrans+"' and INSTITUTECODE='"+xInstCode+"' and EXAMCODE='"+xexamcode+"' and FEEDBACKID='"+mFeedbakid+"'   ";
//out.print(QryDel1);
nd=db.update(QryDel1);

%>
<!--script language=javascript>
alert("You have Sucessfully submitted your request");	
</script-->
<%


		
		}
/*---------------------Updated By Gyan at 270-feb-2015 start------------------*/
else if(Delete.equals("F"))
        {//out.print("Gyan");
        qryUpdate="update AP#FACULTYFEEDBACK set Docmode='F' where TRANSID='"+vTrans+"' and INSTITUTECODE='"+xInstCode+"' and EXAMCODE='"+xexamcode+"' and FEEDBACKID='"+mFeedbakid+"'";
       // out.print(qryUpdate);
        nnu=db.update(qryUpdate);


	for(int zx = 1; zx <= xID; zx++) {

	 if(request.getParameter("question"+zx+"")!=null && !request.getParameter("question"+zx+"").equals("NONE"))
		   {
			xquestion=request.getParameter("question"+zx+"").toString().trim();
		   }


		   if(request.getParameter("Head"+zx+"")!=null && !request.getParameter("Head"+zx+"").equals("NONE"))
		   {
			xHead=request.getParameter("Head"+zx+"").toString().trim();
		   }


	   /*Change By Gyan at 27-feb-2015 start*/
	    xRating=request.getParameter("Rating"+zx+"").equals("NONE")?"":request.getParameter("Rating"+zx+"").toString().trim();
		xUserRemark=request.getParameter("UserRemark"+zx+"")==null?"":request.getParameter("UserRemark"+zx+"").toString().trim();
        /*Change By Gyan at 27-feb-2015 end*/




subchk= " select 'Y' from AP#RATINGMASTER  where  nvl(SUBJECTIVE,'N')='Y' and RATINGID in ( SELECT   ratingid   FROM   AP#FACULTYQUESTIONMASTER WHERE       QUESTIONID =     '"+xquestion+"'  AND HEADID = '"+xHead+"'  AND COMPONENTTYPE = '"+mLTP+"'   AND FEEDBACKID = '"+mFeedbakid+"'   AND EXAMCODE = '"+xexamcode+"'   AND INSTITUTECODE = '"+xInstCode+"' AND COMPANYCODE = '"+mComp+"' ) " ;


	rschksub=db.getRowset(subchk);
	   // out.print(subchk);
	if(rschksub.next()){
qryin2="update AP#FACULTYFEEDBACKDETAIL set SUBJECTIVEANSWER='"+xRating+"' , FEEDBACKREMARKS='"+xUserRemark+"' where TRANSID='"+vTrans+"' and COMPANYCODE='"+mComp+"' and INSTITUTECODE='"+xInstCode+"' and EXAMCODE='"+xexamcode+"' and FEEDBACKID='"+mFeedbakid+"' and COMPONENTTYPE='"+mLTP+"' and HEADID='"+xHead+"' and QUESTIONID='"+xquestion+"'";
//out.print(qryin2);
nnu=db.update(qryin2);

/*qryin2=" INSERT INTO AP#FACULTYFEEDBACKDETAIL ( TRANSID, COMPANYCODE, INSTITUTECODE,  EXAMCODE, FEEDBACKID, COMPONENTTYPE, HEADID, QUESTIONID,EVALUATIONVALUE, SUBJECTIVEANSWER,       FEEDBACKREMARKS,   STAFFTYPE, STAFFID, DEACTIVE,   ENTRYBY, ENTRYDATE) VALUES ( '"+TRANSID+"', '"+mComp+"','"+xInstCode+"' ,'"+xexamcode+"' ,'"+mFeedbakid+"' ,'"+mLTP+"' ,'"+xHead+"' ,'"+xquestion+"' ,'0','"+xRating+"'  ,'"+xUserRemark+"' ,'"+mChkMType+"' ,'"+mChkMemID+"' ,'N' ,'"+mChkMemID+"' ,sysdate ) ";
//out.print(qryin2);
	 nn=db.insertRow(qryin2);
	 */%>
<!--script language=javascript>
alert("You have Sucessfully submitted your request");
</script-->
<%

	}else{
qryin2="update AP#FACULTYFEEDBACKDETAIL set EVALUATIONVALUE='"+xRating+"', FEEDBACKREMARKS='"+xUserRemark+"' where TRANSID='"+vTrans+"' and COMPANYCODE='"+mComp+"' and INSTITUTECODE='"+xInstCode+"' and EXAMCODE='"+xexamcode+"' and FEEDBACKID='"+mFeedbakid+"' and COMPONENTTYPE='"+mLTP+"' and HEADID='"+xHead+"' and QUESTIONID='"+xquestion+"'";
//out.print(qryin2);
nnu=db.update(qryin2);

        /*
	qryin2=" INSERT INTO AP#FACULTYFEEDBACKDETAIL ( TRANSID, COMPANYCODE, INSTITUTECODE,  EXAMCODE, FEEDBACKID, COMPONENTTYPE, HEADID, QUESTIONID, SUBJECTIVEANSWER,     MALICIOUSCONTENT, EVALUATIONVALUE, FEEDBACKREMARKS,   STAFFTYPE, STAFFID, DEACTIVE,   ENTRYBY, ENTRYDATE) VALUES ( '"+TRANSID+"', '"+mComp+"','"+xInstCode+"' ,'"+xexamcode+"' ,'"+mFeedbakid+"' ,'"+mLTP+"' ,'"+xHead+"' ,'"+xquestion+"' ,'' ,'' ,'"+xRating+"' ,'"+xUserRemark+"' ,'"+mChkMType+"' ,'"+mChkMemID+"' ,'N' ,'"+mChkMemID+"' ,sysdate ) ";
	// out.print(qryin2);
	 nn=db.insertRow(qryin2);
*/
%>
<!--script language=javascript>
alert("You have Sucessfully submitted your request");
</script-->
<%
	}
	}
/*---------------------Updated By Gyan at 270-feb-2015 end------------------*/

        }
else if(Delete.equals("DS"))
        {//out.print("Gyan");
        qryUpdate="update AP#FACULTYFEEDBACK set Docmode='D' where TRANSID='"+vTrans+"' and INSTITUTECODE='"+xInstCode+"' and EXAMCODE='"+xexamcode+"' and FEEDBACKID='"+mFeedbakid+"'";
       // out.print(qryUpdate);
        nnu=db.update(qryUpdate);


	for(int zx = 1; zx <= xID; zx++) {

	 if(request.getParameter("question"+zx+"")!=null && !request.getParameter("question"+zx+"").equals("NONE"))
		   {
			xquestion=request.getParameter("question"+zx+"").toString().trim();
		   }


		   if(request.getParameter("Head"+zx+"")!=null && !request.getParameter("Head"+zx+"").equals("NONE"))
		   {
			xHead=request.getParameter("Head"+zx+"").toString().trim();
		   }


	   /*Change By Gyan at 27-feb-2015 start*/
	    xRating=request.getParameter("Rating"+zx+"").equals("NONE")?"":request.getParameter("Rating"+zx+"").toString().trim();
		xUserRemark=request.getParameter("UserRemark"+zx+"")==null?"":request.getParameter("UserRemark"+zx+"").toString().trim();
        /*Change By Gyan at 27-feb-2015 end*/




subchk= " select 'Y' from AP#RATINGMASTER  where  nvl(SUBJECTIVE,'N')='Y' and RATINGID in ( SELECT   ratingid   FROM   AP#FACULTYQUESTIONMASTER WHERE       QUESTIONID =     '"+xquestion+"'  AND HEADID = '"+xHead+"'  AND COMPONENTTYPE = '"+mLTP+"'   AND FEEDBACKID = '"+mFeedbakid+"'   AND EXAMCODE = '"+xexamcode+"'   AND INSTITUTECODE = '"+xInstCode+"' AND COMPANYCODE = '"+mComp+"' ) " ;


	rschksub=db.getRowset(subchk);
	   // out.print(subchk);
	if(rschksub.next()){
qryin2="update AP#FACULTYFEEDBACKDETAIL set SUBJECTIVEANSWER='"+xRating+"' , FEEDBACKREMARKS='"+xUserRemark+"' where TRANSID='"+vTrans+"' and COMPANYCODE='"+mComp+"' and INSTITUTECODE='"+xInstCode+"' and EXAMCODE='"+xexamcode+"' and FEEDBACKID='"+mFeedbakid+"' and COMPONENTTYPE='"+mLTP+"' and HEADID='"+xHead+"' and QUESTIONID='"+xquestion+"'";
//out.print(qryin2);
nnu=db.update(qryin2);

/*qryin2=" INSERT INTO AP#FACULTYFEEDBACKDETAIL ( TRANSID, COMPANYCODE, INSTITUTECODE,  EXAMCODE, FEEDBACKID, COMPONENTTYPE, HEADID, QUESTIONID,EVALUATIONVALUE, SUBJECTIVEANSWER,       FEEDBACKREMARKS,   STAFFTYPE, STAFFID, DEACTIVE,   ENTRYBY, ENTRYDATE) VALUES ( '"+TRANSID+"', '"+mComp+"','"+xInstCode+"' ,'"+xexamcode+"' ,'"+mFeedbakid+"' ,'"+mLTP+"' ,'"+xHead+"' ,'"+xquestion+"' ,'0','"+xRating+"'  ,'"+xUserRemark+"' ,'"+mChkMType+"' ,'"+mChkMemID+"' ,'N' ,'"+mChkMemID+"' ,sysdate ) ";
//out.print(qryin2);
	 nn=db.insertRow(qryin2);
	 */%>
<!--script language=javascript>
alert("You have Sucessfully submitted your request");
</script-->
<%

	}else{
qryin2="update AP#FACULTYFEEDBACKDETAIL set EVALUATIONVALUE='"+xRating+"', FEEDBACKREMARKS='"+xUserRemark+"' where TRANSID='"+vTrans+"' and COMPANYCODE='"+mComp+"' and INSTITUTECODE='"+xInstCode+"' and EXAMCODE='"+xexamcode+"' and FEEDBACKID='"+mFeedbakid+"' and COMPONENTTYPE='"+mLTP+"' and HEADID='"+xHead+"' and QUESTIONID='"+xquestion+"'";
//out.print(qryin2);
nnu=db.update(qryin2);

        /*
	qryin2=" INSERT INTO AP#FACULTYFEEDBACKDETAIL ( TRANSID, COMPANYCODE, INSTITUTECODE,  EXAMCODE, FEEDBACKID, COMPONENTTYPE, HEADID, QUESTIONID, SUBJECTIVEANSWER,     MALICIOUSCONTENT, EVALUATIONVALUE, FEEDBACKREMARKS,   STAFFTYPE, STAFFID, DEACTIVE,   ENTRYBY, ENTRYDATE) VALUES ( '"+TRANSID+"', '"+mComp+"','"+xInstCode+"' ,'"+xexamcode+"' ,'"+mFeedbakid+"' ,'"+mLTP+"' ,'"+xHead+"' ,'"+xquestion+"' ,'' ,'' ,'"+xRating+"' ,'"+xUserRemark+"' ,'"+mChkMType+"' ,'"+mChkMemID+"' ,'N' ,'"+mChkMemID+"' ,sysdate ) ";
	// out.print(qryin2);
	 nn=db.insertRow(qryin2);
*/
%>
<!--script language=javascript>
alert("You have Sucessfully submitted your request");
</script-->
<%
	}
	}
/*---------------------Updated By Gyan at 270-feb-2015 end------------------*/

        }
//end oh status cond.
		}
         if(nnu>0||nd>0||nnd>0||nn>0||pp>0)

         {%>
<script language=javascript>
alert("You have Sucessfully submitted your request");
</script>
<%   }

	   }
	   else
	   {
		%>
		<br><BR>
		<font color=red>
		<h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
		<P>	This page is not authorized/available for you.
		<br>For assistance, contact your network support team. 
		</font>	<br>	<br>	<br>	<br>  
		<%
	   }
	}
	else
	{
		out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}    
	}
	catch(Exception e)
	{
	//out.print(e+qry);
	}
	%>
		</body>
	</html>