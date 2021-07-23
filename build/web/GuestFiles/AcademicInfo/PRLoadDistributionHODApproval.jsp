<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
ResultSet rs=null,rs1=null,rs2=null,rs3=null;
String mMemberID="",mDMemberID="";
String mMemberName="";
String mMemberType="",mDMemberType="",mSst="",mPrcode="",mradio1="",mradio11="";
String mHead="";
String mDMemberCode="",mMemberCode="",mexam="",mExam="",mExamcode="",mExamCode="";
String mInst="" ,mPrCode="",mSendhod="";
String qry="";
int ctr=0;
String mType="",mL="",mT="",mP="",mST="",mSemT="",SEM="",mBasket="",BASKET="";
String SUBJ="",mSubj="",TYPE="",DEPT="",mDept="",LTP="",SUBNAME="",mSname="",EXAM="",mSems="";

if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}


if (session.getAttribute("DepartmentCode")==null)
{
	mDept="";
}
else
{
	mDept=session.getAttribute("DepartmentCode").toString().trim();
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
	{	
		OLTEncryption enc=new OLTEncryption();
		mDMemberID=enc.decode(mMemberID);
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
		  qry="Select WEBKIOSK.ShowLink('56','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
 		    RsChk= db.getRowset(qry);
		    if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	  		{
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

//--------------------------------------



			if (request.getParameter("radio1")==null)
			{
				mSendhod="";
			}
			else
			{
				mSendhod=request.getParameter("radio1").toString().trim();
			}
			if (request.getParameter("PRCODE")==null)
			{
				mPrCode="";
			}
			else
			{
				mPrCode=request.getParameter("PRCODE").toString().trim();
			}
			if (request.getParameter("EXAMCODE")==null)
			{
				mExamCode="";
			}
			else
			{
				mExamCode=request.getParameter("EXAMCODE").toString().trim();
			}


			if(mSendhod.equals("Y"))
			{

			    qry=" Update prevents set LOADDISTRIBUTIONSTATUS='F',LOADDISTAPPROVEDBY='"+mChkMemID+"',LOADDISTAPPROVALDATE=sysdate where institutecode='"+mInst+"' and ";
			    qry=qry+" PREVENTCODE='"+mPrCode+"' and MEMBERTYPE='"+mChkMType+"' and MEMBERID='"+mChkMemID+"' ";	
			    int u=db.update(qry);
				
		
			   qry="update PR#HODLOADDISTRIBUTION set STATUS='F' where	";
			   qry=qry+"  INSTITUTECODE='"+mInst+"' and ";
		         qry=qry+"  EXAMCODE='"+mExamCode+"'  ";
		         qry=qry+" and DEPARTMENTRUNNIG='"+mDept+"'  ";
				int u1=db.update(qry);
		
			 //   if(u>0)
			 //   {
			// Log Entry
			//-----------------
				  db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"Send For Approval -Load Distribution ", "ExamCode:"+mExamCode+" PrEventcode:"+mPrCode+"Depatrment Running:"+ mDept, "NO MAC Address" , mIPAddress);
		     //-----------------
		%>
			<br><br>
			<b><font color=Green>
			<ui>Load Distribution has been Finalized and Send to DOAA for Approval. <br>
			<ui>Now You can not Enter/Modify the LoadDistribution.
			</font><br></b>
	     <%
		//	} // closing of if(u>0)

	} // closing of if(mSendhod.equals("Y"))
	else
	{
	%>
	<br>
	<font color=red>
	<h3><br><img src='../Images/Error1.jpg'>
	 Load Distribution has not been Finalized. <br>
	 It is mandatory to finalized the load distribution in order for approval.
	</h3><br>
	</font>	<br>	<br>	<br>	<br>  
	<%
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
	<h3>	<br><img src='../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font>	<br>	<br>	<br>	<br>  
   <%
  	}
//-----------------------------
	}
	else
	{
		out.print("<br><img src='../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}      
}
catch(Exception e)
{
}
%>
</body>
</html>