<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %> 
<%
OLTEncryption enc=new OLTEncryption();
String mInst="",pMemberRole1="",mCode1="";
String mCaps="",mCode="",mSPass1="",mSPass2="",mHead="",mWebEmail="",mMemberID="",mMemberType="",mMemberCode="",qry="";
String mEmpDefPWD="",mStudDefPWD="",pMemberRole="",mUID="",mPass1="",mPass2="",mUType="";
DBHandler db=new DBHandler();
ResultSet rs=null,rsi=null;

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
   mHead=session.getAttribute("PageHeading").toString().trim();
else
   mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Change Password ] </TITLE>
 
<SCRIPT ID=clientEventHandlersJS LANGUAGE=javascript>
 

function UType_onchange(mEmpPWD,mStudPWD) 
{
chh=SignupForm.UType.value ;
if (chh=='S') 
	{
	SignupForm.txtCaption.value ='Enrollment No.';	
	SignupForm.TxtUserCode.value="";
	SignupForm.TxtPass.value=mStudPWD;
	SignupForm.TxtRePass.value=mStudPWD;
	}
else if (chh=='E') 
	{
	SignupForm.txtCaption.value ='Employee Code';
	SignupForm.TxtUserCode.value="";
	SignupForm.TxtPass.value=mEmpPWD;
	SignupForm.TxtRePass.value=mEmpPWD;
	}
else if (chh=='V') 
	{
	SignupForm.txtCaption.value ='Visiting Staff ID';
	SignupForm.TxtUserCode.value="";
	SignupForm.TxtPass.value=mEmpPWD;
	SignupForm.TxtRePass.value=mEmpPWD;
	}
else
	{
	SignupForm.txtCaption.value ='Guest ID';
	SignupForm.TxtUserCode.value="";
	SignupForm.TxtPass.value=mEmpPWD;
	SignupForm.TxtRePass.value=mEmpPWD;
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
	<!--
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
int mMinPWD=5;
try{


if (session.getAttribute("MinPasswordLength")==null)
{
	mMinPWD=5;
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
mMinPWD=4;

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
if(!mMemberID.equals("") || !mMemberType.equals("") || !mMemberCode.equals(""))
{
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('70','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {

  //----------------------
//----------------------
// For Log Entry Purpose
//--------------------------------------
%>
  <INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
<%
	qry="select distinct nvl(institutecode,' ')IC from INSTITUTEMASTER where nvl(DEACTIVE,'N')='N' ";
	rsi=db.getRowset(qry);
	while(rsi.next())
	{
		mInst=rsi.getString("IC");
	}


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
<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>New Member Signup/Registration Form</b></font>
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
	  <SELECT id=UType language=javascript name='UType' onClick="return UType_onchange('<%=mEmpDefPWD%>','<%=mStudDefPWD%>');"  onChange="return UType_onchange('<%=mEmpDefPWD%> ','<%=mStudDefPWD%>');" style="FONT-SIZE: x-small; WIDTH: 121px; FONT-STYLE: normal; FONT-FAMILY: Arial;   HEIGHT: 25px; TEXT-ALIGN: center; FONT-VARIANT: normal"> 
	  <%
		if(request.getParameter("x")==null)
	       {
		 mCaps="Enrollment No.";
		 mSPass1=mStudDefPWD;
		 mSPass2=mStudDefPWD;
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
		   mSPass1=request.getParameter("TxtPass").toString();
		   mSPass2=request.getParameter("TxtRePass").toString();
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
		</td></tr>
		<tr><td align=right><FONT size=2><FONT face=Arial><FONT color=midnightblue><FONT color=#ff0000 style="COLOR: black;TEXT-ALIGN: right">
		<FONT color=red>*</FONT> <FONT color=black>Password </FONT> 
      </FONT></FONT></FONT></FONT>
</td>
<td><FONT face=Arial size=2><INPUT type=password id=TxtPass name=TxtPass value='<%=mSPass1%>'  size=100 style="FONT-WEIGHT: bold; FONT-SIZE: x-small; WIDTH: 123px; FONT-FAMILY: Arial; HEIGHT: 22px" 
      tabIndex=2> </FONT>
</td>
</tr>
<tr><td align=right><FONT size=2><FONT face=Arial>
      <FONT color=midnightblue 
       
      ><FONT color=#ff0000>* 
      </FONT><FONT color=navy><FONT color=black>Re-type 
      </FONT> 
      </FONT></FONT><FONT color=black>Password</FONT></FONT></FONT></td>
    <td><INPUT id=TxtRePass type=password name=TxtRePass style="FONT-WEIGHT: bold; FONT-SIZE: x-small; WIDTH:123px; FONT-FAMILY: Arial;HEIGHT: 22px" size=10 tabIndex=3 value='<%=mSPass2%>'>	
    	<A href='PasswordHint.htm' target=_New title 'How can i secure my password'><FONT color=teal  size=2 face=Arial>Password Length <%=mMinPWD%> to <%=mMaxPWD%></FONT></a></td>

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
		if ( request.getParameter("TxtPass")==null)
		 {
		   mPass1="";
		 }
		else
		  {
		    mPass1=request.getParameter("TxtPass").trim();
		  }
		if (request.getParameter("TxtRePass")==null)
		  {
		    mPass2="";
		  }
		else
		  {
		    mPass2=request.getParameter("TxtRePass").trim();
		  }

		if (request.getParameter("UType")==null)
		  {
		    mMemberType="";  
		  }
		else
		  {
		    mMemberType=request.getParameter("UType").trim();
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
		  }
		  else if (mMemberType.equals("E"))
		  {
		   	 qry="select EmployeeID USID from EmployeeMaster where nvl(EmployeeCode,' ')='"+mCode+"' and nvl(deactive,'N')='N'";
		  }

		  else if (mMemberType.equals("V"))
		  {
		   	 qry="select FACULTYID USID from VisitingFacultyMaster where nvl(FacultyCode,' ')='"+mCode+"' and nvl(deactive,'N')='N'";
		  }
		  else
		  {
		   	 qry="select GUESTID USID from GUEST where nvl(GUESTCODE,' ')='"+mCode+"' and nvl(deactive,'N')='N'";
		   }
a=1;		
		if (mCode != "" && mPass1 != ""  && mPass2 != "")  //1
		 {
		   if (mPass1.trim().equals(mPass2.trim()))  //4
		      { 
a=2;
			  // Find Whether Empcode/Enroll No is valid or not.............
			  rs = db.getRowset(qry);
		        if (rs.next()) //5
		          {
a=3;
                 	    	 mMemberType=enc.encode(mMemberType);
                 	    	 mUID=enc.encode(rs.getString("USID"));
				 mCode=enc.encode(mCode);
				mCode1=enc.decode(mCode);
				 mPass2=enc.encode(mPass2);
				 pMemberRole=enc.encode(pMemberRole);
				 pMemberRole1=enc.decode(pMemberRole);	
				 qry="select 'Y' from MEMBERMASTER where ORATYP='"+mMemberType+"' and ORACD='"+mCode+"'";
                   	 rs = db.getRowset(qry);
   		   		 if (rs.next()==false) //6
            	         {
 				 	db.memberSignp(mUID,mCode, mMemberType,pMemberRole,mPass2);
// Log Entry
	  		   //-----------------
			    db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"NEW SIGNUP MEMBER", "Member Code : "+mCode1+" Member Type :"+pMemberRole1, "No MAC Address" , mIPAddress);
			   //-----------------
					out.print("<center><img src='../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Green'>LoginID created successfully.......</font> <br>");
	
			         }
				else
				  {
					// If LoginID Already Exist
					out.print("<center><img src='../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>LoginID Already Exist</font> <br>");

				   }

		          }
			else
			   {
				// If LoginID Already Exist
				out.print("<center><img src='../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Invalid "+mCaps+"! Please enter valid LoginID/"+mCaps+" </font> <br>");

			   }
		   } 
	       else
	         {
		// If both Password doesn't Matched
			out.print("<center><img src='../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Both Password doesn't Matched</font> <br>");
		   }
	 }
	else
	 {
	//Mandatory Items must be entered
	out.print("<center><img src='../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> All Mandatory Items must be entered</font> <br>");
	 }

}				
      
}
catch(Exception e){out.print("eoor "+a+qry);}

 //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
  }
  else
   {
   %>
<br>	<font color=red>
	<h3>	<br><img src='../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font>	<br>	<br>	<br>	<br>
   <%
	
	
   }
  //-----------------------------

}
else
{
out.print("<center><img src='../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp'>Login</a> to continue</font> <br>");
}

%>
<hr>
<table ALIGN=Center VALIGN=TOP>
		<tr><td valign=middle><IMG style="WIDTH: 28px; HEIGHT: 28px" src="../Images/CampusConnectLogo.bmp">
		<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
		A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
		<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>  
		</td></tr></table>

</BODY></HTML>
