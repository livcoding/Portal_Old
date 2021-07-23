<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
   mHead=session.getAttribute("PageHeading").toString().trim();
else
   mHead="JIIT ";


%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Admin Signin Action ] </TITLE> 
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
 <BODY aLink=#ff00ff bgcolor=fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 scroll=no>
<%
String mMemberType="", mOlldPWD="";
String mCode="";
String mIPADDRESS="";
String mMACAddress ="";
String mType="";
String mcode="";
String mEMemberType="";
String mECode="";
String mEId="";
String MemberID="";
String MemberType="";
String MemberCode="";
String MemberName="";
String mDID="", mId="";
String qry="";
String mDeac="";
String mMname=""; 
String mDescode=""; 
String mDeptcode=""; 
String mDesg="";
String mNickname="";
String mDept="";
String mAcadmeicYear="";
String mProgram="";
String mBranchCode="";
String mSemester="";
String mStudentName="";
String mInst="", mComp="";
String mRole="",mFirst="";
String mcmpcode="";
String mBASELOGINID="",mBASELOGINTYPE="";
ResultSet rs=null;
ResultSet rs1=null;
ResultSet rs2=null;
ResultSet rs3=null;
ResultSet rs4=null;
DBHandler db=new DBHandler();
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

if (request.getParameter("MType")==null)
{
	mMemberType="";
}
else
{
	mMemberType=request.getParameter("MType").toString().trim();
}

if(request.getParameter("MemberCode")==null)
{
	mCode="";
}
else 
{
	mCode=request.getParameter("MemberCode").toString().trim();
}

if(session.getAttribute("BASELOGINID")==null)
{
	mBASELOGINID="";
}
else 
{
	mBASELOGINID=session.getAttribute("BASELOGINID").toString().trim();
}

if(session.getAttribute("BASELOGINTYPE")==null)
{
	mBASELOGINTYPE="";
}
else 
{
	mBASELOGINTYPE=session.getAttribute("BASELOGINTYPE").toString().trim();
}
//out.print(mBASELOGINID+" - "+mBASELOGINTYPE);
if(session.getAttribute("BASEINSTITUTECODE")==null)
{
	mInst="";
}
else 
{
	mInst=session.getAttribute("BASEINSTITUTECODE").toString().trim();
}
qry="Select nvl(COMPANYTAGGING,'UNIV') from InstituteMaster where InstituteCode='"+ mInst +"' And nvl(Deactive,'N')='N'";
//out.print(qry);
rs=db.getRowset(qry);
if (rs.next())
	mComp=rs.getString(1);
else
	mComp="";

try
{
//out.print("Vijay"+mMemberType);
	if(!mMemberType.equals("")&&!mCode.equals("")&&!mBASELOGINTYPE.equals("") && !mBASELOGINID.equals("")) 
      {  	
		OLTEncryption enc=new OLTEncryption();
		mEMemberType=enc.encode(mMemberType);
		mECode=enc.encode(mCode);	
		String mMinPass="", mMaxPass="",mMinSRS="",mWebEmail="",mStudDefPWD="",mEmpDefPWD="";

	      qry="Select PARAMETERID, PARAMETERVALUE From PARAMETERS Where MODULENAME='SIS' And PARAMETERID IN ('B1.1','B1.2','B1.3','B1.4','B1.5','A1.1') and nvl(DEACTIVE,'N')='N'";
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
			if(mInst.equals("JIIT") || mInst.equals("JPBS"))
				mWebEmail="info@jiit.ac.in";
			else if(mInst.equals("JUIT"))
				mWebEmail="info@juit.ac.in";
			if(mInst.equals("JIET"))
				mWebEmail="info@jiet.ac.in";
		}
		qry="	select nvl(ORATYP,' ')ORATYP,nvl(ORACD,' ')ORACD ,nvl(ORAID,' ')ORAID, ";
		qry=qry +" nvl(ORAPW,' ')PWD,nvl(ORAADM,' ') ROLENAME ,nvl(DEACTIVE,' ')DEACTIVE,nvl(FirstLogin,'Y') FirstLogin ,nvl(PAGEHEADING,' ') PAGEHEADING";
		qry=qry +" from Membermaster where trim(ORACD)='"+mECode+"' and trim(ORATYP)='"+mEMemberType+"' ";
		//out.print(qry);
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
			catch(Exception e)
			{
			}
			mType=rs.getString("ORATYP");
	    		mcode=rs.getString("ORACD");
			mRole=rs.getString("ROLENAME");
		      mDeac=rs.getString("DEACTIVE");
			String PAGEHEADING="";			
			if(!rs.getString("PAGEHEADING").equals(" ") && rs.getString("PAGEHEADING")!=null)
				PAGEHEADING=mInst+"-"+enc.decode(rs.getString("PAGEHEADING"));
			else
				PAGEHEADING=mInst;
		//out.print(mBASELOGINTYPE+" * "+mcode+" * "+enc.encode(mCode));
		if(mcode.equals(enc.encode(mCode)))
      	{
           		session.setAttribute("BASELOGINTYPE","A");
			session.setAttribute("BASELOGINID","ADMIN");
			session.setAttribute("LogEntryMemberID",enc.encode("ADMIN"));
			session.setAttribute("LogEntryMemberType",enc.encode("A"));
      	    	session.setAttribute("MemberType",mType);
			session.setAttribute("MemberCode",mcode);
			session.setAttribute("ROLENAME",mRole);
			session.setAttribute("IPADD",mIPADDRESS);		 
			session.setAttribute("MinPasswordLength",mMinPass);
			session.setAttribute("MaxPasswordLength",mMaxPass);
			session.setAttribute("MinSRSCount",mMinSRS);
			session.setAttribute("WebAdminEmail",mWebEmail);
			session.setAttribute("PageHeading",PAGEHEADING);
			if(mDeac.equals("Y"))
			{
      	      	 out.print("<br><img src='../Images/Error1.jpg'  >");
	      	  	 out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Your account has been locked... </font> <br>");
				 out.print("<p><a href=AdminLoginAction.jsp><img src='../Images/Back.jpg' border=0 ></a></p><br><br><br><br><br><br><br><br><br><br><br><br>");  
	 	      }
      	      else 
            	{
				// Success Starts
				if(mMemberType.equals("S"))
				{
					qry="select STUDENTID, nvl(ACADEMICYEAR,' ')ACADEMICYEAR,nvl(PROGRAMCODE,' ')PROGRAMCODE, ";
					qry=qry +" nvl(BRANCHCODE,' ')BRANCHCODE,nvl(SEMESTER,0)SEMESTER, ";
					qry=qry +" nvl(STUDENTNAME,' ')STUDENTNAME,nvl(INSTITUTECODE,' ')INSTITUTECODE from STUDENTMASTER ";
	 				qry=qry +" where INSTITUTECODE='"+mInst+"' and ENROLLMENTNO='"+mCode+"' And nvl(Deactive,'N')='N'";
					rs4=db.getRowset(qry);
					if (rs4.next())
					{
			 			mDID=rs4.getString("STUDENTID");
			 			mInst=rs4.getString("INSTITUTECODE");
			  			mAcadmeicYear=rs4.getString("ACADEMICYEAR");
				  		mProgram=rs4.getString("PROGRAMCODE");
				  		mBranchCode=rs4.getString("BRANCHCODE");
				  		mSemester=rs4.getString("SEMESTER");
				  		mStudentName=rs4.getString("STUDENTNAME");
			  			mNickname=GlobalFunctions.getFirstName(mStudentName.trim());
						mId=enc.encode(mDID);
						session.setAttribute("MemberID",mId);
			  			session.setAttribute("InstituteCode",mInst);
				 		session.setAttribute("AcademicYearCode",mAcadmeicYear);
						session.setAttribute("ProgramCode",mProgram);
						session.setAttribute("BranchCode",mBranchCode );
				  		session.setAttribute("CurrentSem",mSemester );
			  			session.setAttribute("MemberName",mStudentName );
						session.setAttribute("NickName",mNickname);	  
						db.saveLogEntry(mDID , mMemberType , mMACAddress , mIPADDRESS);
						response.sendRedirect("../StudentFiles/StudentPage.jsp"); 								
					}
					else
					{
				 		%>
						<CENTER><br><img src='../Images/Error1.jpg'><b><font size=3 face='Arial' color='Red'> This student does not exists in <%=mInst%> Institute</font></b></CENTER>
						<%
					}
				}
				else if(mMemberType.equals("E"))
				{
					qry="select EMPLOYEEID, nvl(EMPLOYEENAME,' ')EMPLOYEENAME ,nvl(DESIGNATIONCODE,' ')DESIGNATIONCODE, ";
					qry=qry +"nvl(DEPARTMENTCODE,' ')DEPARTMENTCODE,nvl(COMPANYCODE,' ')COMPANYCODE  ";
					qry=qry +" from EMPLOYEEMASTER where CompanyCode='"+mComp+"' and EmployeeCode='"+mCode+"' and nvl(Deactive,'N')='N'";		
					rs1=db.getRowset(qry);
					//out.print(qry);	
					if(rs1.next())
					{	
						//if(mFirst.equals("N") || (mFirst.equals("Y") && (mIPADDRESS.equals("127.0.0.1") || mIPADDRESS.equals("172.16.5.247") || mIPADDRESS.equals("172.31.8.103") || mIPADDRESS.equals("172.16.5.69") || mIPADDRESS.equals("172.31.8.101")|| mIPADDRESS.equals("172.31.4.102")|| mIPADDRESS.equals("172.31.4.105")|| mIPADDRESS.equals("172.31.4.109")|| mIPADDRESS.equals("172.31.4.111")|| mIPADDRESS.equals("172.31.4.114")|| mIPADDRESS.equals("172.31.4.125")|| mIPADDRESS.equals("172.31.4.128")|| mIPADDRESS.equals("172.31.4.127"))))
						if(1==1)
						{ 
							mDID=rs1.getString("EMPLOYEEID");
							mMname =rs1.getString("EMPLOYEENAME");
			 				mDescode =rs1.getString("DESIGNATIONCODE");	
							mDeptcode =rs1.getString("DEPARTMENTCODE");
							mcmpcode=rs1.getString("COMPANYCODE");
							mNickname=GlobalFunctions.getFirstName(mMname.trim());					
							mId=enc.encode(mDID);
							session.setAttribute("MemberID",mId);
							session.setAttribute("MemberName",mMname);
							session.setAttribute("NickName",mNickname);
							session.setAttribute("DesignationCode",mDescode );
							session.setAttribute("DepartmentCode",mDeptcode );
							session.setAttribute("CompanyCode",mcmpcode);
							session.setAttribute("InstituteCode",mInst);

							qry= "select nvl(DESIGNATION,' ')DESIGNATION from DESIGNATIONMASTER ";
							qry=qry +" where DESIGNATIONCODE='"+mDescode+"' ";	
							rs2=db.getRowset(qry);
							if(rs2.next())
								mDesg=rs2.getString("DESIGNATION");	
							else
								mDesg="N/A";
	
							session.setAttribute("Designation",mDesg);

							qry="select nvl(DEPARTMENT,' ')DEPARTMENT from DEPARTMENTMASTER ";
							qry=qry +"where DEPARTMENTCODE='"+mDeptcode+"' ";								
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
			      			response.sendRedirect("../EmployeeFiles/EmployeePage.jsp");  							
			  			}
				  		else
						{  		
							out.print("<br><img src='../Images/Error1.jpg'  >");
							out.print(" &nbsp;&nbsp;&nbsp <b><font size=5 face='Arial' color='Red'><b>Its Your First Login!</b></font> <br>");
							out.print("<p> &nbsp;&nbsp;&nbsp <b><font size=4 face='Arial' color='Red'>This facility is only available at Computer Centre.</font><br> <br><br><br><br><br><br><br><br><br><br><br><br>");  
						}
					}
					else
					{
				 		%>
						<CENTER><br><img src='../Images/Error1.jpg'><b><font size=3 face='Arial' color='Red'> This employee does not exists in <%=mInst%> Institute</font></b></CENTER>
						<%
					}
      			}
		            else
            		{
					out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>welcome in Guest file...Page under construction. </font> <br>");
				}	
			      //Success End
			}
		} 
		else
	    	{
			%>
			<br>
			<font color=red>
			<h3>	<br><img src='../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
			<P>	This page is not authorized/available for you.
			<br>For assistance, contact your network support team. 
			</font>	<br>	<br>	<br>	<br>
			<%
		}
	} 
	else
     	{                 		
		out.print("<br><img src='../Images/Error1.jpg'  >");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Wrong Member Type or Code</font> <br>");
		out.print("<p><a href=AdminLoginAction.jsp><img src='../Images/Back.jpg' border=0 ></a></p><br><br><br><br><br><br><br><br><br><br><br><br>");  
	}   
}   
else 
{
	out.print("<br><img src='../Images/Error1.jpg'  >");
 	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>LoginID and Password are Mandatory</font> <br>");
	out.print("<p><a href=AdminLoginAction.jsp><img src=../Images/Back.jpg border=0 ></a></p><br><br><br><br><br><br><br><br><br><br><br><br>");  
}
} 
catch(Exception e)
{
}
%>
</BODY>
</HTML>