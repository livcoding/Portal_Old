<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
GlobalFunctions gb =new GlobalFunctions();
int mSno=0, TotInboxItem=0;
String qry="",qry1="";
String mColor="",mComp="",TRCOLOR="White",mWebEmail="";
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInst="";
String mFacultyName="",mFaculty="", mMsg="";
String QryFaculty="",mEID="",mENM="",mcolor="";


String mProg="",mBranch="",mAcademicYearCode="";

if (session.getAttribute("WebAdminEmail")==null)
{
	 mWebEmail="";
}	 
else
{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
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



if (session.getAttribute("ProgramCode")==null)
{
	mProg="";
}
else
{
	mProg=session.getAttribute("ProgramCode").toString().trim();
}

if (session.getAttribute("BranchCode")==null)
{
	mBranch="";
}
else
{
	mBranch=session.getAttribute("BranchCode").toString().trim();
}

	if (session.getAttribute("AcademicYearCode")==null)
	{
		mAcademicYearCode="";
	}
	else
	{
		mAcademicYearCode=session.getAttribute("AcademicYearCode").toString().trim();
	}


String mTime="";
qry="Select to_char(Sysdate,'DD-Mon-yyyy HH:MI:SS PM') mTime from Dual";
rs=db.getRowset(qry);
if (rs.next())
	mTime=rs.getString("mTime");
else
	mTime="";

String mHead="";

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
  mHead=session.getAttribute("PageHeading").toString().trim();
else
  mHead="JIIT ";

%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Alert/Message Window ] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<SCRIPT LANGUAGE="JavaScript"> 
	function un_check()
	{
	 for (var i = 0; i < document.frm1.elements.length; i++) 
	 {
	  var e = document.frm1.elements[i]; 
	  if ((e.name != 'allbox') && (e.type == 'checkbox')) 
	  { 
	   e.checked = document.frm1.allbox.checked;
	  }
	 }
	}
	</SCRIPT>
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
<!-- <p align=right>
<font color=darkbrown size=2 face='verdana'><b>Mesage/Alert Last Refresh Date Time: <%=mTime%></b></font>
</p> -->
<center>
<!--<marquee direction="right" height="150" scrollamount="5" behavior="scroll" style="font-family:Verdana;font-size:13px;text-decoration:none;color:#FFFFFF;background-color:transparent;" id="Marquee1"><img src="../../PhotoImages/1.jpg">&nbsp;&nbsp;<img src="../../PhotoImages/2.jpg">&nbsp;&nbsp;<img src="../../PhotoImages/3.jpg">&nbsp;&nbsp;<img src="../../PhotoImages/5.jpg">&nbsp;&nbsp;<img src="../../PhotoImages/6.jpg">&nbsp;&nbsp;<img src="../../PhotoImages/7.jpg">&nbsp;&nbsp;<img src="../../PhotoImages/8.jpg">&nbsp;&nbsp;<img src="../../PhotoImages/9.jpg"></marquee>
<marquee direction="righttoleft" height="25" width="102%" scrolldelay="50" scrollamount="5" behavior="scroll" loop="0" style="font-family:Verdana;font-size:25px;text-decoration:none;color:#FFFFFF;background-color:navy;" id="Marquee2"><STRONG>Site is Under Construction. Modules will open one by one after sometime.</STRONG></marquee>-->
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
		qry="Select WEBKIOSK.ShowLink('164','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{
			%>

<p align=right>
<font color=darkbrown size=2 face='verdana'><b>Welcome , <%=mMemberName%> </b></font>
</p>
<%



		//	qry="SELECT  distinct COUNT(*)  FROM studentmaster a, PG#TAGGINGFORONLINEFEE b WHERE a.studentid = b.TOUSERID    and a.STUDENTID= and a.INSTITUTECODE='"+mInst+"' and a.INSTITUTECODE=b.INSTITUTECODE ";
				
			qry=" select  to_char(b.TODATE,'dd Mon yyyy')todate from STUDENTREGISTRATION a,PG#TAGGINGFORONLINEFEE b where        a.PROGRAMCODE='"+mProg+"' AND A.BRANCHCODE='"+mBranch+"'      AND A.ACADEMICYEAR='"+mAcademicYearCode+"'        AND A.INSTITUTECODE='"+mInst+"'    AND a.EXAMCODE=b.EXAMCODE                  AND A.STUDENTID='"+mDMemberID+"'             and    a.INSTITUTECODE=b.INSTITUTECODE and               a.ACADEMICYEAR=b.ACADEMICYEAR                and a.PROGRAMCODE=b.PROGRAMCODE                and A.BRANCHCODE=B.BRANCHCODE    AND A.SEMESTER=B.SEMESTER  and        trunc(sysdate) >= trunc(b.FROMDATE) and trunc(sysdate) <=trunc(b.TODATE)    AND A.STUDENTID IN (SELECT STUDENTID FROM STUDENTMASTER C WHERE C.INSTITUTECODE=A.INSTITUTECODE AND A.STUDENTID=C.STUDENTID    AND NVL(C.DEACTIVE,'N')='N' AND C.QUOTA=B.QUOTA  ) ";	
				rs=db.getRowset(qry);

				if(rs.next())
			{
			%>
				<BR>
			<font size=3 color=Green face=arial>
			<b>
			 Note:- Dear Students you can pay fees online through payment gateway under Fee Detail<br>
			 Last date of Online Fee submission is -: <%=rs.getString("todate")%>
			 </b>
			</font>
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
  }

%>
<br><br><br>	<br><br><br> <br><br><br><br><br><br>
<table align=center><tr><td align=left>
<IMG  src="../../Images/CampusLynx.png">
</td>
<td >
<FONT size =4 style="FONT-FAMILY: ARIal"><b>Campus Lynx</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT> 			
</body>
</Html>
