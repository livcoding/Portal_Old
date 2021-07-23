<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
try

{
GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<html>
<head>
<TITLE>#### <%=mHead%> [ MassCuts Marks Entry ] </TITLE>
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
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%	
String mMemberID="",mMemberType="",mMemberCode="",mDMemberCode="",mDMemberType="",mDMemberID="";
String mMemberName="",qryx="";
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
	OLTEncryption enc=new OLTEncryption();
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
	{
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);
		mDMemberID=enc.decode(mMemberID);

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk1=null,RsChk=null;

  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------

	qryx="Select WEBKIOSK.ShowLink('146','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
    RsChk1= db.getRowset(qryx);
	if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
	{
  //----------------------

String mName1="",mName2="",mName3="",mName5="";
String mSemester="",mStudentid="";
String mINSTITUTECODE="",mExam="",mSubject="",mSID="";
String mFstid="";
int mTotalCount=0;
double mMarks=0;
String qry="",qrys="",qry3="",qryd="";
int aa=0;
ResultSet rs3=null;

%>
	<center><font size=4 color=green>MassCuts marks entry status</font></center>
	<hr>
	<table border=1 cellpadding=0 cellspacing=0 rules="rows" align=center width=90%>
	<tr bgcolor=ff8c00>
	<td><b>SNo.</b></td>
	<td><b>Student name</b></td>
	<td><b>Semester</b></td>
	<td><b>Marks</b></td>
	</tr>
<%
mINSTITUTECODE=request.getParameter("institute");
mExam=request.getParameter("Exam");	
mSubject=request.getParameter("subjectcode");

if(request.getParameter("TotalCount")!=null && Integer.parseInt(request.getParameter("TotalCount").toString().trim())>0)
	{ 
		mTotalCount =Integer.parseInt(request.getParameter("TotalCount").toString().trim());
		for (int ctr=1;ctr<=mTotalCount;ctr++)
		{			
			mName1="Semester"+String.valueOf(ctr).trim();  
			mName2="Studentid"+String.valueOf(ctr).trim();
			mName3="Marks"+String.valueOf(ctr).trim();
		//	mName4="Detained"+String.valueOf(ctr).trim();
			mName5="Fstid"+String.valueOf(ctr).trim();
		
			mSemester=request.getParameter(mName1);
			mStudentid=request.getParameter(mName2);
	 try{
			if(request.getParameter(mName3)==null || request.getParameter(mName3).equals(""))
			{	
			mMarks=0;
			}
			else
			{
			mMarks=Double.parseDouble(request.getParameter(mName3));
				}
			}
		catch(Exception e)
		{
				mMarks=0;
		}
		mFstid=request.getParameter(mName5);

	if(mMarks>0)
	{
		
qry3="select nvl(MASSCUTS,0)MASSCUTS from EX#STUDENTMASSCUTS where fstid='"+mFstid+"' and studentid='"+mStudentid+"' and nvl(DEACTIVE,'N')='N' ";
rs3=db.getRowset(qry3);
if(!rs3.next())
{
	qry="insert into EX#STUDENTMASSCUTS(FSTID,STUDENTID,MASSCUTS,ENTRYDATE,ENTRYBY) ";
	qry=qry+" values ('"+mFstid+"','"+mStudentid+"','"+mMarks+"',sysdate,'"+mDMemberID+"')"; 	
	int n=db.insertRow(qry);
} //closing of rs3.next	
else
{
	qry="Update EX#STUDENTMASSCUTS set MASSCUTS='"+mMarks+"' where FSTID='"+mFstid+"' and STUDENTID='"+mStudentid+"' ";
	qry=qry+" and nvl(DEACTIVE,'N')='N' ";
	int n1=db.update(qry);

}

qrys="Select WEBKIOSK.getMemberName('"+mStudentid+"','S') SL from dual" ;
   RsChk= db.getRowset(qrys);
   if(RsChk.next())
    mSID=RsChk.getString(1);	
	aa++;
 %>
			<tr>
			<td><%=aa%></td>
			<td><%=GlobalFunctions.toTtitleCase(mSID)%></td>
			<td><%=mSemester%></td>
			<td>&nbsp;<%=mMarks%></td>
			</tr>
  <%	

	} // closing of if mMArks>0
	if(mMarks==0 || mMarks==0.0)
	{		
		qryd="delete from EX#STUDENTMASSCUTS where  FSTID='"+mFstid+"' and STUDENTID='"+mStudentid+"' ";
		int a2=db.update(qryd);
	}

	} // closing of for 
	} // closing of total count
%>
</table>
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