<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../../CommonFiles/ExceptionHandler.jsp" %> 
<%@ page import="java.util.ArrayList,java.util.Iterator" %>
<%
DBHandler db=new DBHandler();
ResultSet rs=null,rsi=null;
GlobalFunctions gb =new GlobalFunctions();
OLTEncryption enc=new OLTEncryption();
String qry="";
String mComp="JIIT";
int mSno=0,mIntNo=100,flag=0;
String mEmployeeName="",mEmployeeCode="",mDepartment="";
String mMemberID="", mDMemberID="",mIndentDate="",mDesignation="";
String mMemberType="", mDMemberType="", mMemberCode="", mDMemberCode="";
String mMemberName="", mDept="", mDegs="",mDesignation1="";
String mInstitute="",mInst="",mtext="";
String mDate1="", mDate2="", mCurrDate="",mEmpCategory="";
String mQualification="",mCategory="",mEmployeeType="";
String mIndentReferenceNo="",mRequireDate="",mRequireManPower="";
String mRequireExp="",mDepartment1="",mStatus="";
String mPlacePosting="",mJobDiscription="",mRemarks="";
String mAgeFrom="",mAgeTo="",mDepartmentCode="",mBname="";
String mQuliRemarks="",mGender="",mCategory1="",mEmpType="";
String mIndentStatus="P",mDesignationCode="",mVlaidation="";
ArrayList mQaliArrayList=new ArrayList();
int mSlno=0,mStudent=0,mFaculty=0,mRequiredFaculty=0,count=0;
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
<TITLE>#### <%=mHead%> [ Man Power Indent Action ] </TITLE>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="../css/sortabletable.css" />
<script language=javascript>
	<!--
	function RefreshContents()
	{ 	
		document.frm.x.value='ddd';
   		document.frm.submit();
	}
	//-->
	if(window.history.forward(1) != null)
	window.history.forward(1);
	function QuestionTextChanged() 
	{
		if(document.frm.Remarks.value.length > 300) 
		{
			document.frm.Remarks.value = document.frm.Remarks.value.substr(0,300); 
			alert("You can not enter the remarks more than 300 characters");
			return false;
		}
	} 
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
		qry="Select WEBKIOSK.ShowLink('141','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	    RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
			// For Log Entry Purpose
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
			%>
			<form name="frm"  method="post" >		
			<center>
			<table align=center width="100%" bottommargin=0 topmargin=0>
			<tr>
				<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4>Man Power Indent Action </FONT></u></b></td>
			</tr>
			</table>
			<%
			if(request.getParameter("submit")==null)
				mBname="";
			else
				mBname=request.getParameter("submit");
			if(mBname.equals("Save"))
			{
				String MainQqali="";
				if(session.getAttribute("MainQqali")==null)
					MainQqali="";
				else
					MainQqali=(String)session.getAttribute("MainQqali");
				if(request.getParameter("EmployeeName")==null)
					mEmployeeName="";
				else
					mEmployeeName=request.getParameter("EmployeeName");
				if(request.getParameter("Department")==null)
					mDepartment="";
				else
					mDepartment=request.getParameter("Department");
				if(request.getParameter("Designation")==null)
					mDesignation="";
				else
					mDesignation=request.getParameter("Designation");
				if(request.getParameter("CurrDate")==null)
					mCurrDate="";
				else
					mCurrDate=request.getParameter("CurrDate");
				if(request.getParameter("IndentReferenceNo")==null)
					mIndentReferenceNo="";
				else	
					mIndentReferenceNo=request.getParameter("IndentReferenceNo");
				if(request.getParameter("TXT2")==null)
					mRequireDate="";
				else
					mRequireDate=request.getParameter("TXT2");
				if(request.getParameter("RequireManPower")==null)
					mRequireManPower="";
				else	
					mRequireManPower=request.getParameter("RequireManPower");
				if(request.getParameter("RequireExp")==null)
					mRequireExp="";
				else	
					mRequireExp=request.getParameter("RequireExp");
				if(request.getParameter("AgeFrom")==null)
					mAgeFrom="";
				else	
					mAgeFrom=request.getParameter("AgeFrom");
				if(request.getParameter("AgeTo")==null)
					mAgeTo="";
				else
					mAgeTo=request.getParameter("AgeTo");
				if(request.getParameter("PlacePosting")==null)
					mPlacePosting="";
				else	
					mPlacePosting=request.getParameter("PlacePosting");
				if(request.getParameter("JobDiscription")==null)
					mJobDiscription="";
				else
					mJobDiscription=request.getParameter("JobDiscription");
				if(request.getParameter("Remarks")==null)
					mRemarks="";
				else
					mRemarks=request.getParameter("Remarks");				
				if(session.getAttribute("QualiRemarks")==null)
					mQuliRemarks="";
				else
					mQuliRemarks=(String)session.getAttribute("QualiRemarks");
				if(request.getParameter("Gender")==null)
					mGender="";
				else
					mGender=request.getParameter("Gender");
				if(request.getParameter("Category1")==null)
					mCategory1="";
				else
					mCategory1=request.getParameter("Category1");
				if(request.getParameter("EmpType")==null)
					mEmpType="";
				else
					mEmpType=request.getParameter("EmpType");
				if(request.getParameter("EmpCategory")==null)
					mEmpCategory="";
				else
					mEmpCategory=request.getParameter("EmpCategory");
				if(request.getParameter("Inst")==null)
					mInst="";
				else
					mInst=request.getParameter("Inst");			
				if(!mIndentReferenceNo.equals(""))
				{																		
					if(!mRemarks.equals(""))					
						if(mRemarks.length()>300)
						{
							flag++;
							mVlaidation="1";
						}					
					mQaliArrayList=(ArrayList)session.getAttribute("Qualification");
					if(mQaliArrayList==null)
					{
						//System.out.println("zzzzzzdddd");
						flag++;		
						mVlaidation="2";
					}										
					//System.out.println("mQaliArrayListArray list"+mQaliArrayList);				
					try
					{
						if(!mAgeTo.equals("") && !mAgeTo.equals(""))
						{
							if(Integer.parseInt(mAgeFrom)>Integer.parseInt(mAgeTo))
							{
								//System.out.println("ssssss");
								flag++;
								mVlaidation="4";
							}
						}
					}catch(Exception e)
					{
						//System.out.println("Exception e4"+e);
						flag++;
						mVlaidation="5";
					}					
					if(!mAgeTo.equals(""))
					{
						try
						{
							Integer.parseInt(mAgeTo);							
						}catch(Exception e)
						{
							//out.print("Exception e3:-"+e);
							flag++;
							mVlaidation="6";
						}
					}									
					if(!mAgeFrom.equals(""))
					{
						try
						{
							Integer.parseInt(mAgeFrom);
							if(Integer.parseInt(mAgeFrom)<18)
							{
								flag++;
								mVlaidation="20";
							}
						}catch(Exception e)
						{
							//out.print("Exception e2:-"+e);
							flag++;
							mVlaidation="7";
						}
					}					
					else
					{
						flag++;
						mVlaidation="17";
					}
					if(!mRequireExp.equals(""))
					{
						try
						{
							Float.parseFloat(mRequireExp);
							if(Float.parseFloat(mRequireExp)>99.00)
							{
								flag++;
								mVlaidation="28";
							}
						}catch(Exception e)
						{
							//out.print("Exception e1:-"+e);
							flag++;
							mVlaidation="8";
						}
					}
					else
					{
						flag++;
						mVlaidation="18";
					}
					if(!mRequireManPower.equals(""))
					{
						try
						{
							Integer.parseInt(mRequireManPower);
							if(Integer.parseInt(mRequireManPower)==0)
							{
								flag++;
								mVlaidation="19";
							}

						}catch(Exception e)
						{	
							//out.print("Exception e5:-"+e);
							flag++;
							mVlaidation="9";
						}
					}
					else
					{
						flag++;
						mVlaidation="19";
					}
					qry="select 'y' from dual where to_date('"+mDate1+"','dd-mm-yyyy')> to_date('"+mRequireDate+"','dd-mm-yyyy')";
					//out.println(qry);
					rs=db.getRowset(qry);
					if(rs.next())
					{						
						flag++;
						mVlaidation="10";
					}
					try
					{
						qry="Select INDENTREFNO from HR#MANPOWERINDENT where INDENTREFNO='"+mIndentReferenceNo+"'";
						//out.print(qry);
						rs=db.getRowset(qry);
						if(rs.next())
						{
							flag++;
							mVlaidation="31";							
						}						
					}catch(Exception e)
					{
						//out.println("Exception e:-"+e);						
					}		
				}
				else
				{
					flag++;
					mVlaidation="11";
				}							
				//--------
				//query
				//--------
				if(flag==0)
				{
					try
					{
						qry="Select INDENTNO from HR#MANPOWERINDENT order by INDENTNO desc";
						//out.print(qry);
						rs=db.getRowset(qry);
						if(rs.next())
						{
							mIntNo=Integer.parseInt(rs.getString("INDENTNO"));
							mIntNo++;
						}
					}catch(Exception e)
							{	}
					try
					{
						flag=0;					
						qry="insert into HR#MANPOWERINDENT(COMPANYCODE, INSTITUTECODE, INDENTNO, INDENTREFNO, INDENTDATE, INDENTBY, REMARKS, PLACEOFPOSTING, INDENTDEPARTMENTCODE, INDENTDESIGNATIONCODE, TOTALEXPERIENCEREQ, REQUIREDDATE, REQUIREDMANPOWER, GENDER, FROMAGEGROUP, TOAGEGROUP, EMPLOYEETYPE, EMPCATEGORYCODE, CATEGORYCODE, JOBDESCRIPTION, INDENTSTATUS, DEACTIVE, ENTRYBY, ENTRYDATE)values('"+mComp+"','"+mInst+"','"+mIntNo+"','"+mIndentReferenceNo+"',to_date('"+mCurrDate+"','dd/mm/yyyy'),'"+mChkMemID+"','"+mRemarks+"','"+mPlacePosting+"','"+mDepartment+"','"+mDesignation+"','"+mRequireExp+"',to_date('"+mRequireDate+"','dd/mm/yyyy'),'"+mRequireManPower+"','"+mGender+"','"+mAgeFrom+"','"+mAgeTo+"','"+mEmpType+"','"+mEmpCategory+"','"+mCategory1+"','"+mJobDiscription+"','"+mIndentStatus+"','N','"+mChkMemID+"',sysdate)";
						//System.out.println(qry);
						int n=db.insertRow(qry);
						if(n>0)
						{
							// Log Entry
							//-----------------
							db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType	,"MAN POWER INDENT ENTRY BY HOD LOGIN", "Staff ID : "+mEmployeeName+" DEPT : "+mDepartment1+" DEGS : "+ mDesignation1, "No MAC Address" , mIPAddress);						
							//-----------------
							mQaliArrayList=(ArrayList)session.getAttribute("Qualification");
							Iterator iter=mQaliArrayList.iterator();
							while(iter.hasNext())
							{
								String tt=(String)iter.next();
								String ses1=tt.substring(0,tt.indexOf("***"));	
								String ses2=tt.substring(tt.indexOf("***")+3,tt.indexOf("%%%"));
								qry="insert into HR#MANPOWERQUALIFICATION (COMPANYCODE, INSTITUTECODE, INDENTNO, QUALIFICATIONCODE, REMARKS, ENTRYBY, ENTRYDATE)values('"+mComp+"','"+mInst+"','"+mIntNo+"','"+ses2+"','"+mQuliRemarks+"','"+mChkMemID+"',sysdate)";
								//System.out.print(qry);
								int m=db.insertRow(qry);
								if(m>0)							
									flag++;								
							}
							if(flag>0)
							{								
								session.removeAttribute("Qualification");
								session.removeAttribute("QualiRemarks");							
							}
							else
								out.println("------Error:-------");
							qry="update HR#MANPOWERQUALIFICATION set MAINQUALIFICATION='Y' where INDENTNO='"+mIntNo+"'and QUALIFICATIONCODE='"+MainQqali+"'";
							//System.out.println(qry);
							int n1=db.update(qry);
							if (n1>0)
							{
								session.removeAttribute("MainQqali");
								// Log Entry
								//-----------------						
								db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType	,"QUALIFICATION INDENT ENTRY BY HOD LOGIN", "Staff ID : "+mEmployeeName+" DEPT : "+mDepartment1+" DEGS : "+ mDesignation1, "No MAC Address" , mIPAddress);						
								//-----------------																								
								RequestDispatcher rd=request.getRequestDispatcher("ManPowerIndent.jsp");						
								request.setAttribute("message","10");
								rd.forward(request,response);
							}
							else
							{
								out.println("------Error:-------");																
								RequestDispatcher rd=request.getRequestDispatcher("ManPowerIndent.jsp");						
								request.setAttribute("message","20");
								rd.forward(request,response);
							}
						}
						else
						{
							out.println("------Error:-------");							
							RequestDispatcher rd=request.getRequestDispatcher("ManPowerIndent.jsp");						
							request.setAttribute("message","20");
							rd.forward(request,response);
						}
					}catch(Exception e)
					{/* out.println("Exception e:-"+e);*/}
				}
				RequestDispatcher rd=request.getRequestDispatcher("ManPowerIndentForm.jsp");						
				request.setAttribute("Vlaidation",mVlaidation);
				rd.forward(request,response);	
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
</body>
</html>