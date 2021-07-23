<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../../CommonFiles/ExceptionHandler.jsp" %>
<%@ page import="java.util.ArrayList,java.util.Iterator" %>
<%
DBHandler db=new DBHandler();
ResultSet rs=null,rsi=null;
GlobalFunctions gb =new GlobalFunctions();
OLTEncryption enc=new OLTEncryption();
String qry="";
String mComp="JIIT",mAprStatus=""; 
String mEmployeeName="",mEmployeeCode="",mDepartment="";
String mMemberID="", mDMemberID="",mIndentDate="",mDesignation="";
String mMemberType="", mDMemberType="", mMemberCode="", mDMemberCode="";
String mMemberName="", mDept="", mDegs="",mDesignation1="",mStatus="";
String mInstitute="",mInst="",mtext="",mDate1="",mCurrDate="",mIndentNo="";
String mBname="";
int mNoStudent=0,mSlno=0,count=0,flag=0;
double mRequiredFaculty=0;
qry="select to_Char(Sysdate,'dd-mm-yyyy') date1  from dual";
rs=db.getRowset(qry);
rs.next();
mCurrDate=rs.getString("date1");
if (session.getAttribute("MemberID")==null)
	mMemberID="";
else
	mMemberID=session.getAttribute("MemberID").toString().trim();
if (session.getAttribute("MemberType")==null)
	mMemberType="";
else
	mMemberType=session.getAttribute("MemberType").toString().trim();
if (session.getAttribute("MemberName")==null)
	mMemberName="";
else
	mMemberName=session.getAttribute("MemberName").toString().trim();
if (session.getAttribute("MemberCode")==null)
	mMemberCode="";
else
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ ManPower Indent Action ] </TITLE>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
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
<STYLE>input {font-size:13px;}</STYLE>
</HEAD>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
try
{
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{	
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
		qry="Select WEBKIOSK.ShowLink('143','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	    RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
			// For Log Entry Purpose
			//--------------------------------------
			String mLogEntryMemberID="",mLogEntryMemberType="";
			if (session.getAttribute("LogEntryMemberID")==null ||	session.getAttribute("LogEntryMemberID").toString().trim().equals(""))
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
			%>			
			<center>
			<table align=center width="100%" bottommargin=0 topmargin=0>
			<tr>
				<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4>ManPower Indent Action</FONT></u></b></td>
			</tr>
			</table>
			</center>
			<%
			qry="select distinct nvl(institutecode,' ')IC from INSTITUTEMASTER where nvl(DEACTIVE,'N')='N' ";
			rsi=db.getRowset(qry);
			while(rsi.next())
			{
				mInst=rsi.getString("IC");
			}							
			if(request.getParameter("mApprove").equals("Approve"))
			{				
				//out.print(request.getParameter("counter"));
				for(int i=0;i<Integer.parseInt(request.getParameter("counter"))+1;i++)
				{
					//out.print(request.getParameter("check"+i));
					if(request.getParameter("check"+i)!=null)
					{
						flag++;
						mIndentNo=request.getParameter("IntNo"+i);
						try
						{
							qry="UPDATE HR#MANPOWERINDENT set INDENTSTATUS='A' where INDENTNO='"+mIndentNo+"'";
							int n=db.insertRow(qry);
							if(n>0)
							{
								++count;								
							}
							else
								count=0;
						}catch(Exception e)
						{
							//out.print("Exception e"+e);					
						}
					}
				}
				if(flag==0)
				{				
					//out.println("SSSSSS");
					RequestDispatcher rd=request.getRequestDispatcher("ManPowerIndent.jsp");				
					request.setAttribute("message","3");
					rd.forward(request,response);
				}
				else if(count>0)
				{
					//out.println("SSSSSS");
					RequestDispatcher rd=request.getRequestDispatcher("ManPowerIndent.jsp");
					request.setAttribute("message","1");								rd.forward(request,response);
				}
				else if(count==0)
				{
					//out.println("SSSSSS");
					RequestDispatcher rd=request.getRequestDispatcher("ManPowerIndent.jsp");
					request.setAttribute("message","2");								rd.forward(request,response);
				}
				//System.out.println("RRRRRR");
			}			
			else if(request.getParameter("mApprove").equals("Cancel"))
			{
				//System.out.print("dfsajhsdfajd"+request.getParameter("counter"));
				for(int i=0;i<Integer.parseInt(request.getParameter("counter"))+1;i++)
				{
					//out.print(request.getParameter("check"+i));
					if(request.getParameter("check"+i)!=null)
					{
						flag++;
						mIndentNo=request.getParameter("IntNo"+i);
						try
						{
							qry="delete from HR#MANPOWERINDENT  where INDENTNO='"+mIndentNo+"'";
							//System.out.print(qry);
							int n=db.insertRow(qry);
							if(n>0)
								++count;
							else
								count=0;
							qry="delete from HR#MANPOWERQUALIFICATION  where INDENTNO='"+mIndentNo+"'";
							//System.out.print(qry);
							n=db.insertRow(qry);
							if(n>0)
								++count;
							else
								count=0;
						}catch(Exception e)
						{
							//System.out.print("Exception e"+e);					
						}
					}
				}
				if(flag==0)
				{				
					//out.println("SSSSSS");
					RequestDispatcher rd=request.getRequestDispatcher("ManPowerIndent.jsp");				
					request.setAttribute("message","13");
					rd.forward(request,response);
				}
				else if(count>0)
				{
					//out.println("SSSSSS");
					RequestDispatcher rd=request.getRequestDispatcher("ManPowerIndent.jsp");
					request.setAttribute("message","11");								
					rd.forward(request,response);
				}
				else if(count==0)
				{
					//out.println("SSSSSS");
					RequestDispatcher rd=request.getRequestDispatcher("ManPowerIndent.jsp");
					request.setAttribute("message","12");								
					rd.forward(request,response);
				}
			}
			else
			{
				RequestDispatcher rd=request.getRequestDispatcher("ManPowerIndent.jsp");			
				rd.forward(request,response);
			}
		}
		else
		{
			%>
			<br>
			<font color=red>
			<h3>	<br><img src='../../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
			<P>	This page is not authorized/available for you.
			<br>For assistance, contact your network support team. 
			</font>	<br>	<br>	<br>	<br> 
			<%
		}
		//-----------------------------
	}
	else
	{
		out.print("<br><img src='../../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}
}
catch(Exception e)
{
	//out.print("Catch Block");	
}
%>
</form>
</html>