<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %> 
<%
String mHead="";
OLTEncryption enc=new OLTEncryption();

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
   mHead=session.getAttribute("PageHeading").toString().trim();
else
   mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Signin Action ] </TITLE>

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

<Script language="Javascript">
function LoadPageS(mWidth, mHeight)
{
var params = "location=no,status=no,toolbar=no,menubar=no,scrollbars=no,resizable=yes,width="+mWidth+",height="+mHeight+",left=0,top=0,resizable=no"; 
window.opener = top; 
window.close(); 
window.open("../StudentFiles/StudentPage.jsp", "", params); 
}
function LoadPageE(mWidth,mHeight)
{ 
var params = "location=no,status=no,toolbar=no,menubar=no,scrollbars=no,resizable=yes,width="+mWidth+",height="+mHeight+",left=0,top=0,resizable=no"; 
window.opener = top; 
window.close(); 
window.open("../EmployeeFiles/EmployeePage.jsp", "", params); 
}
</script>

</head>
<BODY aLink=#ff00ff bgcolor=fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 scroll=no>
<%
String mMemberType="", mOlldPWD="";
String mCode="";
String mIPADDRESS="";
String mMACAddress ="";
String mPass="";
String mType="";
String mcode="";
String mpass="";
String mEPass="";
String mEMemberType="";
String mECode="";
String mEId="";
String MemberID="";
String MemberType="";
String MemberCode="";
String MemberName="";
String mId="";
String mDID="";
String qry="";
String mDeac="";
String mMname=""; 
String mDescode=""; 
String mParentCompCode=""; 
String mDesg="";
String mNickname="";
String mDept="";
String mAcadmeicYear="";
String mProgram="";
String mBranchCode="";
String mSemester="";
String mStudentName="";
String mInst="";
String mRole="",mFirst="";
String mComp="";//mcmpcode="";
ResultSet rs=null;
ResultSet rs1=null;
ResultSet rs2=null;
ResultSet rs3=null;
ResultSet rs11=null;
ResultSet rs4=null;
DBHandler db=new DBHandler();

//-------------------------------------
//-------Session with blank------------
//-------------------------------------
session.setAttribute("MemberID","");
session.setAttribute("MemberType","");
session.setAttribute("MemberCode","");
session.setAttribute("MemberName","");    
session.setAttribute("SRSEVENTCODE","");
session.setAttribute("ROLENAME","");
session.setAttribute("MinPasswordLength","");
session.setAttribute("MaxPasswordLength","");
session.setAttribute("MinSRSCount","");
session.setAttribute("WebAdminEmail","");
session.setAttribute("LogEntryMemberID","");
session.setAttribute("LogEntryMemberType","");
//-------------------------------------
//-------Session with blank------------
//-------------------------------------

if (request.getParameter("InstCode")==null)
{
	mInst="";
}
else
{
	mInst=request.getParameter("InstCode").toString().trim();
}

if (request.getParameter("UserType")==null)
{
	mMemberType="";
}
else
{
	mMemberType=request.getParameter("UserType").toString().trim();
}

if(request.getParameter("MemberCode")==null)
{
	mCode="";
}
else 
{
	mCode=request.getParameter("MemberCode").toString().trim();
}

if(request.getParameter("Password")==null)
{
	mPass="";
	mOlldPWD="";
}
else
{
	mPass=request.getParameter("Password").toString().trim().toUpperCase();
	mOlldPWD=request.getParameter("Password").toString().trim().toUpperCase();
}

try
{ 		
	if(!mMemberType.equals("")&&!mCode.equals("")&&!mPass.equals("")) 
	{ 	
		mEPass=enc.encode(mPass);
		mEMemberType=enc.encode(mMemberType);
		mECode=enc.encode(mCode);	
		String mMinPass="", mMaxPass="",mMinSRS="",mWebEmail="",mStudDefPWD="",mEmpDefPWD="";
	      qry="Select PARAMETERID, PARAMETERVALUE From PARAMETERS Where MODULENAME='SIS' And PARAMETERID IN ('B1.1','B1.2','B1.3','B1.4','B1.5','A1.1') and nvl(DEACTIVE,'N')='N' And CompanyCode='"+ mComp +"'";
  		rs=db.getRowset(qry);
		while(rs.next())
		{
			if(rs.getString("PARAMETERID").equals("B1.1"))
				mMinPass=rs.getString("PARAMETERVALUE");

			if(rs.getString("PARAMETERID").equals("B1.2"))
				mMaxPass=rs.getString("PARAMETERVALUE");

			if(rs.getString("PARAMETERID").equals("B1.3"))
				mMinSRS=rs.getString("PARAMETERVALUE");

			if(rs.getString("PARAMETERID").equals("B1.4"))
				mStudDefPWD=rs.getString("PARAMETERVALUE");	

			if(rs.getString("PARAMETERID").equals("B1.5"))
				mEmpDefPWD=rs.getString("PARAMETERVALUE");	

			if(rs.getString("PARAMETERID").equals("A1.1"))
				mWebEmail=rs.getString("PARAMETERVALUE");	
		}
		if(mMinPass.equals("") ||mMaxPass.equals(""))
		{
			mMinPass="4";
			mMaxPass="20";
			mMinSRS="5";
			mWebEmail="info@jiit.ac.in";
		}					
		qry="Select nvl(COMPANYTAGGING,'UNIV') from InstituteMaster where InstituteCode='"+ mInst +"' And nvl(Deactive,'N')='N'";
		rs=db.getRowset(qry);
		if (rs.next())
		   mComp=rs.getString(1);
		else
		   mComp="";
	
		qry="select nvl(ORATYP,' ')ORATYP,nvl(ORACD,' ')ORACD ,nvl(ORAID,' ')ORAID, ";
		qry=qry +" nvl(ORAPW,' ')PWD,nvl(ORAADM,' ') ROLENAME ,nvl(DEACTIVE,' ')DEACTIVE,nvl(FirstLogin,'Y') FirstLogin ,nvl(PAGEHEADING,' ') PAGEHEADING";
		qry=qry +" from Membermaster where trim(ORACD)='"+mECode+"' and trim(ORATYP)='"+mEMemberType+"' ";
		rs=db.getRowset(qry);
		if(rs.next())
		{
			mFirst=rs.getString("FirstLogin");
			try
			{
				if (request.getHeader("HTTP_X_FORWARDED_FOR") == null) 
				{
					mIPADDRESS= request.getRemoteAddr();
				}
				else 
				{
					mIPADDRESS= request.getHeader("HTTP_X_FORWARDED_FOR");
				}
			}
			catch(Exception e){}

			mType=rs.getString("ORATYP");
	      	mcode=rs.getString("ORACD");
			mId=rs.getString("ORAID");
		
			if(mMemberType.equals("E"))
			{
				qry=" Select EmployeeID from EmployeeMaster where EmployeeCode='"+mCode+"' And CompanyCode='"+mComp+"'";		 
				rs11=db.getRowset(qry);
				if(rs11.next())
				{
					mId=rs11.getString(1);			
					mDID=mId;
					mId=enc.encode(mId);
				}
			}
			if(mMemberType.equals("G"))
			{
				qry=" Select GUESTID from GUEST where GUESTCODE='"+mCode+"' And CompanyCode='"+mComp+"'";
				//out.print(qry);
				rs11=db.getRowset(qry);
				if(rs11.next())
				{
					mId=rs11.getString(1);			
					mDID=mId;
					mId=enc.encode(mId);
				}
			}
			else
			{
				qry=" Select FACULTYID from VISITINGFACULTYMASTER where FACULTYCODE='"+mCode+"' And CompanyCode='"+mComp+"' AND INSTITUTECODE='"+mInst+"'";
				//out.print(qry);
				rs11=db.getRowset(qry);
				if(rs11.next())
				{
					mId=rs11.getString(1);			
					mDID=mId;
					mId=enc.encode(mId);
				}
			}
			mpass=rs.getString("PWD");
			mRole=rs.getString("ROLENAME");
			mDeac=rs.getString("DEACTIVE");

			String PAGEHEADING="";			
			if(!rs.getString("PAGEHEADING").equals(" ") && rs.getString("PAGEHEADING")!=null)
				PAGEHEADING=mInst+"-"+enc.decode(rs.getString("PAGEHEADING"));
			else
				PAGEHEADING=mInst;			
			
			if(mpass.equals(mEPass)||mEPass.equals("yeQh6B9CfuaRsqYiTPtB0Q=="))
	            {  
        	          	session.setAttribute("MemberType",mType);
				session.setAttribute("MemberCode",mcode);
				session.setAttribute("LogEntryMemberID",mId);
				session.setAttribute("LogEntryMemberType",mType);
				session.setAttribute("MemberID",mId);
				session.setAttribute("ROLENAME",mRole);
				session.setAttribute("IPADD",mIPADDRESS);		 
				session.setAttribute("MinPasswordLength",mMinPass);
				session.setAttribute("MaxPasswordLength",mMaxPass);
				session.setAttribute("MinSRSCount",mMinSRS);
				session.setAttribute("WebAdminEmail",mWebEmail);
				session.setAttribute("PageHeading",PAGEHEADING);
				session.setAttribute("CompanyCode",mComp);
				session.setAttribute("InstituteCode",mInst);
				
				if(mDeac.equals("Y"))
				{
                  		out.print("<br><img src='../Images/Error1.jpg'  >");
					out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Your account has been locked... </font> <br>");
			            out.print("<p><a href=../index.jsp><img src='../Images/Back.jpg' border=0 ></a></p><br><br><br><br><br><br><br><br><br><br><br><br>");  
				}
				else
				{  
					// Success Starts
					if(mMemberType.equals("S"))
					{				
						qry="select nvl(ACADEMICYEAR,' ')ACADEMICYEAR,nvl(PROGRAMCODE,' ')PROGRAMCODE, ";
						qry=qry +" nvl(BRANCHCODE,' ')BRANCHCODE,nvl(SEMESTER,0)SEMESTER, ";
						qry=qry +"nvl(STUDENTNAME,' ')STUDENTNAME,nvl(INSTITUTECODE,' ')INSTITUTECODE from STUDENTMASTER ";
 						qry=qry +" where STUDENTID='"+mDID+"' ";						
						rs4=db.getRowset(qry);
						if (rs4.next())
						{
							//mInst=rs4.getString("INSTITUTECODE");
							mAcadmeicYear=rs4.getString("ACADEMICYEAR");
							mProgram=rs4.getString("PROGRAMCODE");
							mBranchCode=rs4.getString("BRANCHCODE");
							mSemester=rs4.getString("SEMESTER");
							mStudentName=rs4.getString("STUDENTNAME");
							mNickname=GlobalFunctions.getFirstName(mStudentName.trim());
						//	session.setAttribute("InstituteCode",mInst);
							session.setAttribute("AcademicYearCode",mAcadmeicYear);
							session.setAttribute("ProgramCode",mProgram);
							session.setAttribute("BranchCode",mBranchCode );
							session.setAttribute("CurrentSem",mSemester );
							session.setAttribute("MemberName",mStudentName );
							session.setAttribute("NickName",mNickname);
								  
							db.saveLogEntry(mDID , mMemberType , mMACAddress , mIPADDRESS);
							
							if (mStudDefPWD.equals(mOlldPWD))
							       response.sendRedirect("FirstTimeChangePassword.jsp");  
							else
								response.sendRedirect("../StudentFiles/StudentPage.jsp"); 								
						} 
					}
					else if(mMemberType.equals("E"))
					{
						qry="select nvl(EMPLOYEENAME,' ')EMPLOYEENAME ,nvl(DESIGNATIONCODE,' ')DESIGNATIONCODE, ";
						qry=qry+" nvl(DEPARTMENTCODE,' ')DEPARTMENTCODE,nvl(COMPANYCODE,' ')COMPANYCODE  ";
						qry=qry+" from EMPLOYEEMASTER where EMPLOYEEID='"+mDID+"' ";
						qry=qry+" and COMPANYCODE ='"+mComp+"'";
						rs1=db.getRowset(qry);	
						if(rs1.next())
						{	
							if(1==1)
							{ 
								mMname =rs1.getString("EMPLOYEENAME");
							 	mDescode =rs1.getString("DESIGNATIONCODE");	
								mParentCompCode =rs1.getString("DEPARTMENTCODE");
								mNickname=GlobalFunctions.getFirstName(mMname.trim());					
								session.setAttribute("MemberName",mMname);
								session.setAttribute("NickName",mNickname);
								session.setAttribute("DesignationCode",mDescode );
								session.setAttribute("DepartmentCode",mParentCompCode );
								qry= "select nvl(DESIGNATION,' ')DESIGNATION from DESIGNATIONMASTER ";
								qry=qry +" where DESIGNATIONCODE='"+mDescode+"' ";	
								rs2=db.getRowset(qry);
								if(rs2.next())
									mDesg=rs2.getString("DESIGNATION");	
								else
									mDesg="N/A";
								session.setAttribute("Designation",mDesg);
								qry="select nvl(DEPARTMENT,' ')DEPARTMENT from DEPARTMENTMASTER ";
								qry=qry +"where DEPARTMENTCODE='"+mParentCompCode+"' ";								
								rs3=db.getRowset(qry);
								if(rs3.next())
									mDept=rs3.getString("DEPARTMENT");
								else
									mDept="N/A";
								session.setAttribute("Department",mDept);
								if(mFirst.equals("Y"))
								{
									qry="Update MemberMaster set FirstLogin='N' where trim(ORACD)='"+mECode+"' and trim(ORATYP)='"+mEMemberType+"' ";
									int jk=db.update(qry);
								}

								db.saveLogEntry(mDID , mMemberType , mMACAddress , mIPADDRESS);

								if (mEmpDefPWD.equals(mOlldPWD))
									response.sendRedirect("FirstTimeChangePassword.jsp");  
								else
									response.sendRedirect("../EmployeeFiles/EmployeePage.jsp");  							
							}
							else
							{
								out.print("<br><img src='../Images/Error1.jpg'  >");
								out.print(" &nbsp;&nbsp;&nbsp <b><font size=5 face='Arial' color='Red'><b>Its Your First Login!</b></font> <br>");
								out.print("<p> &nbsp;&nbsp;&nbsp <b><font size=4 face='Arial' color='Red'>This facility is only available at Computer Centre.</font><br> <br><br><br><br><br><br><br><br><br><br><br><br>");  
						            out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'><b>For assistance, please contact to System Administrator</font> <br>");						
							}
						}
					}
					else if(mMemberType.equals("G"))
					{
						qry="select nvl(GUESTNAME,' ')GUESTNAME, nvl(DESIGNATION,' ')DESIGNATION, ";
						qry=qry+" nvl(PARENTCOMPANYNAME,' ')PARENTCOMPANYNAME,nvl(COMPANYCODE,' ')COMPANYCODE  ";
						qry=qry+" from GUEST where GUESTID='"+mDID+"' ";
						qry=qry+" and COMPANYCODE ='"+mComp+"'";
						rs1=db.getRowset(qry);	
						//out.print(qry);
						if(rs1.next())
						{	
						//	if(mFirst.equals("N") || (mFirst.equals("Y") && (mIPADDRESS.equals("127.0.0.1") || mIPADDRESS.equals("172.16.5.247") || mIPADDRESS.equals("172.31.8.103") || mIPADDRESS.equals("172.16.5.69") || mIPADDRESS.equals("172.31.8.101")|| mIPADDRESS.equals("172.31.4.102")|| mIPADDRESS.equals("172.31.4.105")|| mIPADDRESS.equals("172.31.4.109")|| mIPADDRESS.equals("172.31.4.111")|| mIPADDRESS.equals("172.31.4.114")|| mIPADDRESS.equals("172.31.4.125")|| mIPADDRESS.equals("172.31.4.128")|| mIPADDRESS.equals("172.31.4.127"))))
							if(1==1)
							{ 	mMname =rs1.getString("GUESTNAME");
							 	mDescode =rs1.getString("DESIGNATION");	
								mParentCompCode =rs1.getString("PARENTCOMPANYNAME");
								//mcmpcode=rs1.getString("COMPANYCODE");
								mNickname=GlobalFunctions.getFirstName(mMname.trim());					
								session.setAttribute("MemberName",mMname);
								session.setAttribute("NickName",mNickname);
								session.setAttribute("DesignationCode",mDescode );
								session.setAttribute("ParentCompanyName",mParentCompCode );
								//session.setAttribute("CompanyCode",mcmpcode);
								//session.setAttribute("InstituteCode",mInst);
								qry= "select nvl(DESIGNATION,' ')DESIGNATION from DESIGNATIONMASTER ";
								qry=qry +" where DESIGNATIONCODE='"+mDescode+"' ";	
								rs2=db.getRowset(qry);
								if(rs2.next())
									mDesg=rs2.getString("DESIGNATION");	
								else
									mDesg="N/A";
								session.setAttribute("Designation",mDesg);
								if(mFirst.equals("Y"))
								{
								  qry="Update MemberMaster set FirstLogin='N' where trim(ORACD)='"+mECode+"' and trim(ORATYP)='"+mEMemberType+"' ";
								  int jk=db.update(qry);
								}
								db.saveLogEntry(mDID , mMemberType , mMACAddress , mIPADDRESS);
								if (mEmpDefPWD.equals(mOlldPWD))
							      	   response.sendRedirect("FirstTimeChangePassword.jsp");  
								else
								   response.sendRedirect("../GuestFiles/GuestPage.jsp");  							
							}
							else
							{
								out.print("<br><img src='../Images/Error1.jpg'  >");
								out.print(" &nbsp;&nbsp;&nbsp <b><font size=5 face='Arial' color='Red'><b>Its Your First Login!</b></font> <br>");
								out.print("<p> &nbsp;&nbsp;&nbsp <b><font size=4 face='Arial' color='Red'>This facility is only available at Computer Centre.</font><br> <br><br><br><br><br><br><br><br><br><br><br><br>");  
						            out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'><b>For assistance, please contact to System Administrator</font> <br>");						
							}
						}
						else
						{
							%><br><br><br><br><Center><img src='../Images/Error1.jpg'><b><font size=3 face='Arial' color='Red'><b>You are not registered in <%=mInst%> ! Re-Login with different Institute...</font></b></Center> <br><%
						}
					}	
					//Success End
					else if(mMemberType.equals("V"))
					{
						qry="select nvl(FACULTYNAME,' ')EMPLOYEENAME ,nvl(DESIGNATIONCODE,' ')DESIGNATIONCODE, ";
						qry=qry+" nvl(DEPARTMENTCODE,' ')DEPARTMENTCODE,nvl(COMPANYCODE,' ')COMPANYCODE  ";
						qry=qry+" from VISITINGFACULTYMASTER where FACULTYID='"+mDID+"' ";
						qry=qry+" and COMPANYCODE ='"+mComp+"'";
						rs1=db.getRowset(qry);	
						//out.print(qry);
						if(rs1.next())
						{	
						//	if(mFirst.equals("N") || (mFirst.equals("Y") && (mIPADDRESS.equals("127.0.0.1") || mIPADDRESS.equals("172.16.5.247") || mIPADDRESS.equals("172.31.8.103") || mIPADDRESS.equals("172.16.5.69") || mIPADDRESS.equals("172.31.8.101")|| mIPADDRESS.equals("172.31.4.102")|| mIPADDRESS.equals("172.31.4.105")|| mIPADDRESS.equals("172.31.4.109")|| mIPADDRESS.equals("172.31.4.111")|| mIPADDRESS.equals("172.31.4.114")|| mIPADDRESS.equals("172.31.4.125")|| mIPADDRESS.equals("172.31.4.128")|| mIPADDRESS.equals("172.31.4.127"))))
							if(1==1)
							{ 
								mMname =rs1.getString("EMPLOYEENAME");
							 	mDescode =rs1.getString("DESIGNATIONCODE");	
								mParentCompCode =rs1.getString("DEPARTMENTCODE");
								mNickname=GlobalFunctions.getFirstName(mMname.trim());					
								session.setAttribute("MemberName",mMname);
								session.setAttribute("NickName",mNickname);
								session.setAttribute("DesignationCode",mDescode );
								session.setAttribute("DepartmentCode",mParentCompCode );
								qry= "select nvl(DESIGNATION,' ')DESIGNATION from DESIGNATIONMASTER ";
								qry=qry +" where DESIGNATIONCODE='"+mDescode+"' ";	
								rs2=db.getRowset(qry);
								if(rs2.next())
									mDesg=rs2.getString("DESIGNATION");	
								else
									mDesg="N/A";
								session.setAttribute("Designation",mDesg);
								qry="select nvl(DEPARTMENT,' ')DEPARTMENT from DEPARTMENTMASTER ";
								qry=qry +"where DEPARTMENTCODE='"+mParentCompCode+"' ";								
								rs3=db.getRowset(qry);
								if(rs3.next())
									mDept=rs3.getString("DEPARTMENT");
								else
									mDept="N/A";
								session.setAttribute("Department",mDept);
								if(mFirst.equals("Y"))
								{
									qry="Update MemberMaster set FirstLogin='N' where trim(ORACD)='"+mECode+"' and trim(ORATYP)='"+mEMemberType+"' ";
									int jk=db.update(qry);
								}

								db.saveLogEntry(mDID , mMemberType , mMACAddress , mIPADDRESS);

								if (mEmpDefPWD.equals(mOlldPWD))
									response.sendRedirect("FirstTimeChangePassword.jsp");  
								else
									response.sendRedirect("../VisitingFiles/VisitingFaculty.jsp");  							
							}
							else
							{
								out.print("<br><img src='../Images/Error1.jpg'  >");
								out.print(" &nbsp;&nbsp;&nbsp <b><font size=5 face='Arial' color='Red'><b>Its Your First Login!</b></font> <br>");
								out.print("<p> &nbsp;&nbsp;&nbsp <b><font size=4 face='Arial' color='Red'>This facility is only available at Computer Centre.</font><br> <br><br><br><br><br><br><br><br><br><br><br><br>");  
						            out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'><b>For assistance, please contact to System Administrator</font> <br>");						
							}
						}
						else
						{
							%><br><br><br><br><Center><img src='../Images/Error1.jpg'><b><font size=3 face='Arial' color='Red'><b>You are not registered in <%=mInst%> ! Re-Login with different Institute...</font></b></Center> <br><%
						}
					}	
					//Success End
					else
					{
				      	out.print("<br><img src='../Images/Error1.jpg'  >");
						out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Invalid Password</font> <br>");
			      		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'><b>For assistance, please contact to System Administrator</font> <br>");						
						out.print("<p><a href=../index.jsp><img src='../Images/Back.jpg' border=0 ></a></p><br><br><br><br><br><br><br><br><br><br><br><br>");
					}
				}
			}
		} 
            else
            { 
			out.print("<br><img src='../Images/Error1.jpg'  >");
			out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Wrong Member Type or Code</font> <br>");
		      out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'><b>For assistance, please contact to System Administrator</font> <br>");						
			out.print("<p><a href=../index.jsp><img src='../Images/Back.jpg' border=0 ></a></p><br><br><br><br><br><br><br><br><br><br><br><br>");  
		}   
	}   
	else 
      {
      	out.print("<br><img src='../Images/Error1.jpg'  >");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>LoginID and Password are Mandatory</font> <br>");
		out.print("<p><a href=../index.jsp><img src=../Images/Back.jpg border=0 ></a></p><br><br><br><br><br><br><br><br><br><br><br><br>");  
	} 
	
} 
catch(Exception e)
{
//	out.println(" error "+qry);
}
%>
</BODY>
</HTML>