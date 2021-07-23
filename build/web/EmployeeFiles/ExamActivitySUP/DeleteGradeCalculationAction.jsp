<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String qry="";
ResultSet rs=null;
int mSno1=0;
DBHandler db=new DBHandler();
String mInst="";
int ctr=0,mCheck=0;
String mHead="";
String mExamCode="",mSubjectid="",mBR="",mName1="";
String qry1="",FS="",FS1="";
String qry2="",qry3="",qry4="";
ResultSet rs1=null;
String mysubjcode="";
String qryss="";
ResultSet rss=null;



if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";

	qry="Select Distinct NVL(INSTITUTECODE,' ')IC from v#SRSEVENTS WHERE nvl(deactive,'N')='N' ";
	rs=db.getRowset(qry);
	while(rs.next())
	{
		mInst=rs.getString("IC");
	}

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
String mDMemberCode="",mDMemberType="";
String mSCode="",mscode="";



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
	qry="Select WEBKIOSK.ShowLink('146','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
    RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
	qry="Select Distinct NVL(INSTITUTECODE,' ')IC from INSTITUTEMASTER WHERE nvl(deactive,'N')='N' ";
	rs=db.getRowset(qry);
	while(rs.next())
	{
		mInst=rs.getString("IC");
		
	}
//-------------------------------------
//----- For Log Entry Purpose
//--------------------------------------
String mLogEntryMemberID="",mLogEntryMemberType="";

if (session.getAttribute("LogEntryMemberID")==null || session.getAttribute("LogEntryMemberID").toString().trim().equals(""))
	mLogEntryMemberID="";
else
	mLogEntryMemberID=session.getAttribute("LogEntryMemberID").toString().trim();

if (session.getAttribute("LogEntryMemberType")==null || session.getAttribute("LogEntryMemberType").toString().trim().equals(""))
	mLogEntryMemberType="";
else
	mLogEntryMemberType=session.getAttribute("LogEntryMemberType").toString().trim();

if (mLogEntryMemberType.equals(""))
	mLogEntryMemberType=mMemberType;

if (mLogEntryMemberID.equals(""))
	mLogEntryMemberID=mMemberID;

if (!mLogEntryMemberType.equals(""))
	mLogEntryMemberType=enc.decode(mLogEntryMemberType);

if (!mLogEntryMemberID.equals(""))
	mLogEntryMemberID=enc.decode(mLogEntryMemberID);



%>
<input id="x" name="x" type=hidden>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Delete calculated Grade </b></TD>
</font></td></tr>
</TABLE>
<%
		
	if(request.getParameter("ExamCode")==null)
		mExamCode="";
	else
		mExamCode=request.getParameter("ExamCode").toString().trim();

	if(request.getParameter("Subject")==null)
		mSubjectid="";
	else
		mSubjectid=request.getParameter("Subject").toString().trim();
	
if(request.getParameter("CTR")==null)
	mCheck=0;
else
mCheck=Integer.parseInt(request.getParameter("CTR").toString().trim());
 
for(int i=1;i<=mCheck;i++)
 {
	mName1="FSTID"+i;
	FS1=request.getParameter(mName1);
	if(FS1==null || FS1.equals(""))
	{
		
	}
	else
	{
		
		if(FS.equals(""))
		{
			FS="'"+FS1+"'";
		}
		else
		{
			FS=FS+",'"+FS1+"'";
		}
	}
//out.print(FS+"fffff");
 }
		
		  	  qry1=" Delete from STUDENTWISEGRADE ";
                    qry1=qry1+" where INSTITUTECODE='"+mInst+"' and ExamCode='"+mExamCode+"' ";
			  qry1=qry1+" and fstid in("+FS+") and docmode='D' ";			 
		 	  int a1=db.update(qry1);
			if(a1>0)
			{
 			  qry2="Delete from  GRADECALCULATIONGRADES   ";
                    qry2=qry2+" where INSTITUTECODE='"+mInst+"' and ExamCode='"+mExamCode+"' ";
			  qry2=qry2+" and Subjectid='"+mSubjectid+"' and BREAK#SLNO in (select BREAK#SLNO  from ";
                    qry2=qry2+" EX#GRADESUBJECTBREAKUP where fstid in("+FS+") ) "; 
			  int a2=a1+db.update(qry2);
//out.print(qry2);
			 if(a2>1)
			{	
			  qry3="Delete from GRADECALCULATION ";
                    qry3=qry3+" where INSTITUTECODE='"+mInst+"' and ExamCode='"+mExamCode+"' ";
			  qry3=qry3+" and Subjectid='"+mSubjectid+"' and BREAK#SLNO in (select BREAK#SLNO  from ";
                    qry3=qry3+" EX#GRADESUBJECTBREAKUP where fstid in("+FS+") ) "; 

			  int a3=a2+db.update(qry3);
//out.print(qry3);
			qry4=" delete EX#GRADESUBJECTBREAKUP where fstid in("+FS+") and  BREAK#SLNO in (select BREAK#SLNO  from ";
                  qry4=qry4+" EX#GRADESUBJECTBREAKUP where fstid in("+FS+") ) "; 

				int a4=a3+db.update(qry4);
			//out.print(qry4);
			  if (a4>1)
			  {
	// Log Entry
	//-----------------
    db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"Delete Grade Entry ", "ExamCode: "+mExamCode+ " subjectid :  "+mSubjectid+" MemberID :"+mChkMemID,"NO MAC Address",mIPAddress);
	//-----------------

		response.sendRedirect("GradeCalculation.jsp");
		  %>
				<br><hr><p><font color=Green size=4><ul><li>Grade Deleted Successfully!! .
				Student subject Grades should be re-executed or calculated ...	
				</ul></font><hr>
		  <%
			  }
			} // closing of a2>0
				
			} // closing of if a1>0

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
	 out.print(e);
}
%>