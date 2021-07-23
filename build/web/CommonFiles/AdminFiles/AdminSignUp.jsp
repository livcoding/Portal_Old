<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %> 
<%
OLTEncryption enc=new OLTEncryption();
String mInst="",pMemberRole1="",mCode1="";
String mCaps="",mCode="",mSPass1="",mSPass2="",mHead="",mWebEmail="",mMemberID="",mMemberType="",mMemberCode="",qry="";
String mEmpDefPWD="",mStudDefPWD="",pMemberRole="",mUID="",mPass1="",mPass2="",mUType="",mCD="";
DBHandler db=new DBHandler();
ResultSet rs=null,rs1=null;
String mRole="",qry1="";
int mPwdLength=0;

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
   mHead=session.getAttribute("PageHeading").toString().trim();
else
   mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Change Password ] </TITLE>
 
 


<SCRIPT ID=clientEventHandlersJS LANGUAGE=javascript>


function UType_onchange() 
{
chh=SignupForm.UType.value ;
if (chh=='S') 
	{
	SignupForm.txtCaption.value ='Enrollment No.';	
	SignupForm.TxtUserCode.value="";

	}
else if (chh=='E') 
	{
	SignupForm.txtCaption.value ='Employee Code';
	SignupForm.TxtUserCode.value="";
	}
else if (chh=='V') 
	{
	SignupForm.txtCaption.value ='Visiting Staff ID';
	SignupForm.TxtUserCode.value="";
	}
else
	{
	SignupForm.txtCaption.value ='Guest ID';
	SignupForm.TxtUserCode.value="";
	}

//--

	for(i=document.SignupForm.ROLENAME.options.length-1;i>=0;i--)
	{
		document.SignupForm.ROLENAME.remove(i);
	}


	var optn = document.createElement("OPTION");

	for(i=0;i<SignupForm.AllRoles.options.length;i++)
       {
		var v1;
		var pos;
		var pc;
		var sc;
		var len;
		var otext;
		var v1=SignupForm.AllRoles.options(i).value;
		len= v1.length ;	
		pos=v1.indexOf('***');
		pc=v1.substring(0,pos);
		sc=v1.substring(pos+3,len);
		if (pc==chh)
		 { 	
			var optn = document.createElement("OPTION");
			optn.text=SignupForm.AllRoles.options(i).text;
			optn.value=sc;
			SignupForm.ROLENAME.options.add(optn);
		}
	}
	
   //---
}


function MemberCode_onchange() 
	{
	 var txt1;
		txt1=SignupForm.TxtUserCode.value;
		SignupForm.TxtUserCode.value = txt1.toUpperCase();
	
	}
//-->
</SCRIPT>
<script language=javascript>

	function RefreshContents()
	{ 	
    	    document.SignupForm.x.value='ddd';
    	    document.SignupForm.submit();
	}
//-->
</script>

</head>
<%
int mMaxPWD=20;
int mMinPWD=8;
try{


if (session.getAttribute("BASEINSTITUTECODE")==null)
{
	mInst="JIIT";
}
else
{
	mInst=session.getAttribute("BASEINSTITUTECODE").toString().trim();
}

if (session.getAttribute("MinPasswordLength")==null)
{
	mMinPWD=8;
}
else
{
	mMinPWD=Integer.parseInt(session.getAttribute("MinPasswordLength").toString().trim());
}

if (session.getAttribute("MaxPasswordLength")==null)
{
	mMaxPWD=20;
}
else
{
	mMaxPWD=Integer.parseInt(session.getAttribute("MaxPasswordLength").toString().trim());
}

if (session.getAttribute("WebAdminEmail")==null)
{
	 mWebEmail="";
}	 
else
{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
}

}
catch(Exception e)
{
mMaxPWD=20;
mMinPWD=8;

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

%>
<BODY aLink=#ff00ff bgcolor="#fce9c5" rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 scroll=auto>
<%
//OLTEncryption enc=new OLTEncryption();

// For Log Entry Purpose
//--------------------------------------
String mLogEntryMemberID="",mLogEntryMemberType="";

if (session.getAttribute("BASELOGINID")==null || session.getAttribute("BASELOGINID").toString().trim().equals(""))
	mLogEntryMemberID="";
else
	mLogEntryMemberID=session.getAttribute("BASELOGINID").toString().trim();

if (session.getAttribute("BASELOGINTYPE")==null || session.getAttribute("BASELOGINTYPE").toString().trim().equals(""))
	mLogEntryMemberType="";
else
	mLogEntryMemberType=session.getAttribute("BASELOGINTYPE").toString().trim();

if (!mLogEntryMemberType.equals(""))
	mLogEntryMemberType=enc.decode(mLogEntryMemberType);

if (!mLogEntryMemberID.equals(""))
	mLogEntryMemberID=enc.decode(mLogEntryMemberID);

 
//--------------------------------------
String mIPAddress=session.getAttribute("IPADD").toString().trim();
String mLoginIDFrSes="";
if(mInst.equals("JIIT"))
	mLoginIDFrSes="asklJIITADMINaskl";
else if(mInst.equals("JPBS"))
	mLoginIDFrSes="asklJPBSADMINaskl";
else if	(mInst.equals("J128"))
	mLoginIDFrSes="asklJ128ADMINaskl";
else
	mLoginIDFrSes="asklADMINaskl";
//out.print(mLogEntryMemberID+" - "+mLoginIDFrSes);
	if(mLogEntryMemberID.equals(mLoginIDFrSes) && mLogEntryMemberType.equals("A")) 
	{
  //----------------------
//----------------------
// For Log Entry Purpose
//--------------------------------------
%>
  <INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
<%


//--------------------------------------

	      qry="Select PARAMETERID, PARAMETERVALUE From PARAMETERS Where MODULENAME='SIS' And PARAMETERID IN ('B1.4','B1.5') and nvl(DEACTIVE,'N')='N'";
  		rs=db.getRowset(qry);
		
		while(rs.next())
		{
			
			if(rs.getString("PARAMETERID").equals("B1.4"))
			  mStudDefPWD=rs.getString("PARAMETERVALUE");	

			if(rs.getString("PARAMETERID").equals("B1.5"))
			  mEmpDefPWD=rs.getString("PARAMETERVALUE");	
		 }
%>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: VERDANA"><b>New Member Signup/Registration Form .</b></font>
</td>
</tr>
</TABLE>

	<center>
	<table align=center  border=1 rules=groups>
	<TBODY>
	<TR><TD COLSPAN=2>&nbsp;</TD></TR>
	<form Name="SignupForm"  method="get">
	<input type=hidden id='x' name='x'>
	<tr><td align=right><FONT size=2><FONT face=Arial>
		<FONT color=midnightblue>
        <FONT color=red>* </FONT></FONT><FONT color=black>Member Type </FONT></FONT></FONT>  
		</td>
		<td>
	  <SELECT id=UType language=javascript name='UType' onClick="return UType_onchange();"  onChange="return UType_onchange();" style="FONT-SIZE: x-small; WIDTH: 121px; FONT-STYLE: normal; FONT-FAMILY: Arial;   HEIGHT: 25px; TEXT-ALIGN: center; FONT-VARIANT: normal"> 
	  <%
		if(request.getParameter("x")==null)
	       {
		 mCaps="Enrollment No.";
		 mCode="";
		%>
		 <OPTION selected value=S>Student</OPTION>
	       <OPTION value=E>Employee</OPTION>
      	 <OPTION value="V">Visiting Staff</OPTION>
	       <OPTION value="G">Guest</OPTION>
		<%
		}
		else
		{
		   mCode=request.getParameter("TxtUserCode").toString();
		   if(request.getParameter("UType").toString().equals("S"))
		 	 {
			 mCaps="Enrollment No.";
			 %>
			 <OPTION selected value=S>Student</OPTION>		
		       <OPTION value=E>Employee</OPTION>
      		 <OPTION value="V">Visiting Staff</OPTION>
	      	 <OPTION value="G">Guest</OPTION>
			<%
			 }
		  else if(request.getParameter("UType").toString().equals("E"))
		 	 {
			 mCaps="Employee Code";
			 %>
			 <OPTION value=S>Student</OPTION>		
		       <OPTION selected value=E>Employee</OPTION>
      		 <OPTION value="V">Visiting Staff</OPTION>
	      	 <OPTION value="G">Guest</OPTION>
			<%
			 }

		  else if(request.getParameter("UType").toString().equals("V"))
		 	 {
			 mCaps="Visiting Staff ID";
			 %>
			 <OPTION value=S>Student</OPTION>		
		       <OPTION value=E>Employee</OPTION>
      		 <OPTION selected value="V">Visiting Staff</OPTION>
	      	 <OPTION value="G">Guest</OPTION>
			<%
			 }

		  else if(request.getParameter("UType").toString().equals("G"))
		 	 {
			 mCaps="Guest ID";
			 %>
			 <OPTION value=S>Student</OPTION>		
		       <OPTION value=E>Employee</OPTION>
      		 <OPTION value="V">Visiting Staff</OPTION>
	      	 <OPTION selected value="G">Guest</OPTION>
			<%
			 }
		}
		%>
		</SELECT>
		</td>
	</tr>
	<tr>
		<td align=right><FONT size=2><FONT face=Arial>
		<FONT color=midnightblue><FONT color=red>* </FONT>
        <INPUT id=txtCaption style="BORDER-TOP: medium none; VERTICAL-ALIGN: bottom; WIDTH: 93px; BORDER-BOTTOM: thin; FONT-FAMILY: ARIAL; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; HEIGHT: 22px; BACKGROUND-COLOR: #fce9c5; TEXT-ALIGN: right; FONT-VARIANT:normal" size =10 name  =txtCaption readOnly align =right value="<%=mCaps%>" tabIndex=1></FONT> 
		</FONT></FONT>
		</td>
		<td><FONT face=Arial size=2>
		<INPUT id=TxtUserCode style="FONT-WEIGHT: bold; FONT-SIZE: x-small; WIDTH: 123px;FONT-FAMILY: Arial; HEIGHT: 22px" size=11 name=TxtUserCode tabIndex=1 value="<%=mCode%>" LANGUAGE="javascript" onchange="MemberCode_onchange();" > </FONT>

		
    	<A href='PasswordHint.htm' target=_New title 'How can i secure my password'><FONT color=teal  size=2 face=Arial>Password Length <%=mMinPWD%> to <%=mMaxPWD%></FONT></a></td>
				</td></tr>
 </tr>
<tr>
<td align=middle colspan="2">
 </td></tr>
<tr>
<select name="AllRoles" id="AllRoles" style="WIDTH: 0px">
<%
qry="select nvl(ROLEFORMEMBERTYPE,'E')||'***'||ROLENAME ROLENAME, nvl(ROLEDESCRIPTION,ROLENAME) RoleDesc from WEBKIOSKROLEMASTER WHERE  nvl(deactive,'N')='N' order by RoleDesc Desc"; 
rs=db.getRowset(qry);
while(rs.next())
{
mRole=rs.getString("ROLENAME");
%>
	<OPTION selected value=<%=rs.getString("ROLENAME")%>><%=rs.getString("RoleDesc")%></OPTION>
<%
 }
%>
</select>
<td align=right><font size=1 color=red><sup>*</sup></font>&nbsp; Role to assigned </td>
<td>
<select name="ROLENAME" id="ROLENAME" tabindex="4" style="WIDTH: 350px">
<%
if(request.getParameter("x")==null)
{
	qry="select ROLENAME, nvl(ROLEDESCRIPTION,ROLENAME) RoleDesc from WEBKIOSKROLEMASTER WHERE  nvl(deactive,'N')='N' "; 
	qry=qry+" AND nvl(ROLEFORMEMBERTYPE,'E')='S'  order by RoleDesc ";
	rs=db.getRowset(qry);
	
	while(rs.next())
	{
	mRole=rs.getString("ROLENAME");
%>
	<OPTION selected value=<%=rs.getString("ROLENAME")%>><%=rs.getString("RoleDesc")%></OPTION>
<%
	}

   }

 else
	{  
	mUType=request.getParameter("UType").toString().trim();
	qry="select ROLENAME, nvl(ROLEDESCRIPTION,ROLENAME) RoleDesc from WEBKIOSKROLEMASTER WHERE  nvl(deactive,'N')='N' "; 
	qry=qry+" AND nvl(ROLEFORMEMBERTYPE,'E')='"+mUType+"' order by RoleDesc ";
	
	rs=db.getRowset(qry);
   	while(rs.next())
	{
	mRole=rs.getString("RoleName");
	if(mRole.equals(request.getParameter("ROLENAME").toString().trim()))
	{
   %>	
	<OPTION selected value=<%=rs.getString("ROLENAME")%>><%=rs.getString("RoleDesc")%></OPTION>
   <%			
	}
	else
	{
   %>
        <OPTION  value=<%=rs.getString("ROLENAME")%>><%=rs.getString("RoleDesc")%></OPTION>

   <%	
	 }
	}

   }
%>
</select>


</td>
</tr>
<tr><td colspan=2><FONT size=2><FONT face=Arial><FONT color=black>Note: <EM>Please fill following mandatory 
      <STRONG>( </STRONG><STRONG><FONT color=red>* </FONT>) </STRONG>fields</EM></FONT></FONT></FONT>
</font></td></tr>

 <tr><td colspan=2 align=center>
<font color="#ff4500" face="Times New Roman Greek">
 <INPUT type="submit" onClick="return RefreshContents();" id=BTNSubmit style="FONT-SIZE: x-small; WIDTH: 74px; FONT-FAMILY: Arial; HEIGHT: 27px" size=23 value="Submit" name=BTNSubmit tabIndex=5>
</font>
<font color="#ff4500" face="Times New Roman Greek">
<INPUT id=BTNReset type=reset value=Reset name=BTNReset style="FONT-SIZE: x-small; WIDTH: 74px; FONT-FAMILY: Arial; HEIGHT: 27px" size    =18 tabIndex=6> 
  </td></tr>
</TBODY></table></FORM></center></FONT>
<%
int a=0;
  try{
	if(request.getParameter("x")!=null)
	      {
 		if (request.getParameter("TxtUserCode")==null)
		  mCode="";
		else
		  mCode=request.getParameter("TxtUserCode").trim();
		
		if (request.getParameter("UType")==null)
		  {
		    mMemberType="";  
		  }
		else
		  {
		    mMemberType=request.getParameter("UType").trim();

				
				if(mMemberType.equals("E") || mMemberType.equals("V") || mMemberType.equals("G") || mMemberType.equals("I") )
				{

					qry1="select MINRANGE from PARAMETERS where MODULENAME='SIS' and PARAMETERID='B1.5'";
				}
				else
				{

					qry1="select MINRANGE from PARAMETERS where MODULENAME='SIS' and PARAMETERID='B1.4'";
				}
				rs1=db.getRowset(qry1);
				//out.print(qry1);
				rs1.next();
				mPwdLength=rs1.getInt("MINRANGE");


				qry="select webkiosk.GeneratePWD("+mPwdLength+") PWD from dual";
				rs=db.getRowset(qry);
				if(rs.next())
			  {
					mPass2=rs.getString("PWD").toUpperCase();
					mPass1=rs.getString("PWD").toUpperCase();
			  }



		  }

		 if (request.getParameter("ROLENAME")==null)
		  {
		    pMemberRole="";  
		  }
		 else
		  {
		    pMemberRole=request.getParameter("ROLENAME").trim();
		  }

 
		  if (mMemberType.equals("S"))
		  {
    		   	 qry="select StudentID USID from StudentMaster where nvl(Enrollmentno,' ')='"+mCode+"' and nvl(deactive,'N')='N'";
			 mCD="Enrollment Number";
		  }
		  else if (mMemberType.equals("E"))
		  {
		   	 qry="select EmployeeID USID from EmployeeMaster where nvl(EmployeeCode,' ')='"+mCode+"' and nvl(deactive,'N')='N'";
			 mCD="Employee Code";
		  }

		  else if (mMemberType.equals("V"))
		  {
		   	 qry="select EmployeeID USID from EmployeeMaster where nvl(EmployeeCode,' ')='"+mCode+"' and nvl(deactive,'N')='N'";
			 mCD="Visiting StaffID";
		  }
		  else
		  {
		   	 qry="select GUESTID USID from GUEST where nvl(GUESTCODE,' ')='"+mCode+"' and nvl(deactive,'N')='N'";
			 mCD="Guest ID";		  
		   }
a=1;		
		if (mCode != "" && mPass2 != ""  )  //1
		 {
		
a=2;
			  // Find Whether Empcode/Enroll No is valid or not.............
			  rs = db.getRowset(qry);
		        if (rs.next()) //5
		          {
a=3;
//out.print(pMemberRole+" -- ");

                 	    	 mMemberType=enc.encode(mMemberType);
                 	    	 mUID=enc.encode(rs.getString("USID"));
				 mCode=enc.encode(mCode);
				mCode1=enc.decode(mCode);
				 mPass2=enc.encode(mPass2);
				 pMemberRole=enc.encode(pMemberRole);
				 pMemberRole1=enc.decode(pMemberRole);	
				 qry="select 'Y' from MEMBERMASTER where ORATYP='"+mMemberType+"' and ORACD='"+mCode+"'";
				//out.print(qry+"mUID"+mUID );


                   	 rs = db.getRowset(qry);
   		   		 if (!rs.next()) //6
            	         {
 				 	db.memberSignp(mUID,mCode, mMemberType,pMemberRole,mPass2);
// Log Entry
	  		   //-----------------
			    db.saveTransLog(mInst,"ADMIN","A" ,"NEW SIGNUP MEMBER", "Member Code : "+mCode1+" Member Type :"+pMemberRole1, "No MAC Address" , mIPAddress);
			   //-----------------
					out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Green'>LoginID created successfully and Password is -  "+mPass1+"</font> <br>");
	
			         }
				else
				  {

					qry="update MEMBERMASTER a set a.ORAADM ='"+pMemberRole+"' where ORATYP='"+mMemberType+"' and ORACD='"+mCode+"' ";
					//out.print(qry);
				int d=db.update(qry);

					// If LoginID Already Exist
					out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>LoginID Already Exist and Member Role is Changed </font> <br>");

				   }

		          }
			else
			   {
				// If LoginID Already Exist
				out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Invalid "+mCD +"! Please enter valid LoginID/"+mCD+" </font> <br>");

			   }
		 
	 }
	else
	 {
	//Mandatory Items must be entered
	out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> All Mandatory Items must be entered</font> <br>");
	 }

}				
      
}
catch(Exception e){
//out.print("eoor "+a+qry);
}

 
  //-----------------------------

}
else
{
out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp'>Login</a> to continue</font> <br>");
}

%>
<hr>

</BODY></HTML>
