<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.net.*" %>
<%@ page errorPage="CommonFiles/ExceptionHandler.jsp" %>
<%
String mMemberType="", mOlldPWD="";
String mCode="",mDeac="";
String mIPADDRESS="";
String mMACAddress ="";
String mPass="", mPassword="";
String mType="";
String mpass="";
String mEPass="";
String mEMemberType="";
String mECode="";
String MemberID="";
String MemberType="";
String MemberCode="";
String MemberName="";
String qry="";
String mInst="",mComp="";
String ipAddress="",Today="";
int MAXHINT =0;
ResultSet rs=null;
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();
String mBASEADMINPWD="", mBASELOGINID="",	mBASELOGINTYPE="";


String mHead="Admin Page";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="Admin Page";

%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Signin Action ] </TITLE>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>


<link rel="stylesheet" href="css/style.css" type="text/css" media="screen, projection, tv" />

<SCRIPT LANGUAGE="JavaScript">
<!-- Begin

function MemberCode_onchange()
{
	var mUserCode;
	mUserCode=frmadminlogin.MemberCode.value;
	frmadminlogin.MemberCode.value = mUserCode.toUpperCase();
}


function scrollit(seed)
{
	var m1 = "### Welcome to Jaypee Institute of Information Technology University, Noida ###";
	var msg=m1;
	var out = " ";
	var c = 1;
	if (seed > 100)
	{
		seed--;
		cmd="scrollit("+seed+")";
		timerTwo=window.setTimeout(cmd,100);
	}
	else if (seed <= 100 && seed > 0)
	{
		for (c=0 ; c < seed ; c++)
		{
			out+=" ";
		}
		out+=msg;
		seed--;
		window.status=out;
		cmd="scrollit("+seed+")";
		timerTwo=window.setTimeout(cmd,100);
	}
	else if (seed <= 0)
	{
		if (-seed < msg.length)
		{
			out+=msg.substring(-seed,msg.length);
			seed--;
			window.status=out;
			cmd="scrollit("+seed+")";
			timerTwo=window.setTimeout(cmd,100);
		}
		else
		{
			window.status=" ";
			timerTwo=window.setTimeout("scrollit(100)",75);
		}
	}
}
// End -->
</SCRIPT>

</head>
 <BODY aLink=#ff00ff bgcolor=fce9c5 rightmargin=1 leftmargin=1 topmargin=15 bottommargin=2 scroll=no onLoad="scrollit(150)">
<%
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

if(!mBASELOGINID.equals("") && !mBASELOGINTYPE.equals(""))
{
	mMemberType=enc.decode(mBASELOGINTYPE);
	mCode=enc.decode(mBASELOGINID);
	//out.println(mMemberType+"Type"+mCode+"MemberCode");

        mMemberType="A";

		mPass=session.getAttribute("BASELOGINPASSWORD").toString().trim();

    if(mInst.equals("JIIT"))
	{
		mMemberType="A";
		mCode="JIITADMIN";
	}
	else if(mInst.equals("J128"))
	{
		mMemberType="A";
		mCode="J128ADMIN";
	}
	else if(mInst.equals("JPBS"))
	{
		mMemberType="A";
		mCode="JPBSADMIN";
	}
}
else
{
	session.setAttribute("BASELOGINTYPE","");
	session.setAttribute("BASELOGINID","");
	session.setAttribute("BASEINSTITUTECODE","");
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
	}
	else
	{
		mPass=request.getParameter("Password").toString().trim().toUpperCase();
	}
}
// Stop if other than A-Z, a-Z and 0-9 characters found
//out.print(mCode+"sdsd");
	int mValid=0;

	for(int ii=0;ii<mCode.length();ii++)
	{

		if (mCode.charAt(ii)>=65 && mCode.charAt(ii)<=90)
		{
		  mValid=1;
		}
		else if (mCode.charAt(ii)>=97 && mCode.charAt(ii)<=122)
		{
		  mValid=1;
		}

		else if (mCode.charAt(ii)>=48 && mCode.charAt(ii)<=57)
		{
		  mValid=1;
		}
		else
		{
		mValid=0;
		break;
		}
	}

	String mChkSttring=mCode.toUpperCase();
	int start = mChkSttring.indexOf("INSERT");
	if (start<0 )
		start = mChkSttring.indexOf("UPDATE");
	if (start<0 )
		start = mChkSttring.indexOf("DELETE");
	if (start<0 )
		start = mChkSttring.indexOf("TRUNCATE");
	if (start<0 )
		start = mChkSttring.indexOf("DROP");
	if (start<0 )
		start = mChkSttring.indexOf("CREATE");
	if (start<0 )
		start = mChkSttring.indexOf("ALTER");


	// Make Invalid If any DML string found
        if (start>=0)
	   mValid=0;



try
{
//   out.print(mValid+"asa"+mMemberType+"ss"+mCode+"hh"+mPass);
	if(mValid>0 && !mMemberType.equals("")&&!mCode.equals(""))
      {
        mMemberType="A";
		mCode="JIITADMIN";

        mEPass=enc.encode(mPass);
		mEMemberType=enc.encode(mMemberType);
		mECode=enc.encode(mCode);
		String mMinPass="", mMaxPass="";
	      qry="Select PARAMETERID, PARAMETERVALUE From PARAMETERS Where MODULENAME='SIS' " +
                  "And PARAMETERID IN ('B1.1','B1.2','B1.3','B1.4','B1.5','A1.1') and nvl(DEACTIVE,'N')='N'";
  		rs=db.getRowset(qry);

		while(rs.next())
		{
			if(rs.getString("PARAMETERID").equals("B1.1"))
			  mMinPass=rs.getString("PARAMETERVALUE");

			if(rs.getString("PARAMETERID").equals("B1.2"))
			  mMaxPass=rs.getString("PARAMETERVALUE");
		}

		if(mMinPass.equals("") ||mMaxPass.equals(""))
		{
			mMinPass="4";
			mMaxPass="20";
		}




	//mBASEADMINPWD=enc.encode("@#KLASKLAS@#ADMIN");


				//mBASEADMINPWD="3rgFgHNj7oFJq6GCUeVWyg==";
//  out.print("**::PD"+enc.decode("eFTOhCo61KgY+5x2BRl34w=="));
//out.print(mBASEADMINPWD+"*****"+mBASELOGINID+"&&&&mCode"+mCode+":::mECode:::"+mECode);
 //out.print(mCode+"%%%"+mECode+"******"+mBASEADMINPWD+"&&&"+mMemberType+"&&&"+mEMemberType+"&&&"+mBASELOGINID);

//mEpass   qaz@jiit1234

	  qry="Select nvl(ORATYP,' ')ORATYP,nvl(ORACD,' ')ORACD ,nvl(ORAID,' ')ORAID, ";
			qry=qry +" nvl(ORAPW,' ')PWD,nvl(ORAADM,' ') ROLENAME ,nvl(DEACTIVE,' ')DEACTIVE,nvl(FirstLogin,'Y') FirstLogin ,nvl(PAGEHEADING,' ') PAGEHEADING";
			qry=qry +" from Membermaster where  " +
             " trim(ORACD)='"+mECode+"' and trim(ORATYP)='"+mEMemberType+"' AND ORAPW='"+mEPass+"' ";
     //     out.print(qry);
       rs=db.getRowset(qry);
       if(rs.next())
        {
         //  out.print("sds");




        %>
     <form name="frm" >
     <input type="hidden" name="x" id="x">
          <input type="hidden" name="UserType" id="UserType" value="<%=mMemberType%>">
          <input type="hidden" name="MemberCode" id="MemberCode" value="<%=mCode%>">
         


       <div id=header>
<table cellspacing=0 cellpadding=0 border=0 width="100%" >
<tr>
<td align=left>
<INPUT TYPE="image" SRC="images/logo.JPG" >
</td>
<td>

  <h1>	JAYPEE INSTITUTE OF INFORMATION TECHNOLOGY</h1>

</td></tr>
<tr>
<td>
&nbsp;
</td>
<td  align=center>
&nbsp;
</td></tr>
</table>
</div>




		<table border="1" cellpadding="2" rules="groups" cellspacing="1" width="100%" align=CENTER>
						<tr>
                <td align="right"> &nbsp;<font face='Verdana' size=2><b><U>Institute</U> :</b></font>
                &nbsp;

       <%
                        try {
                            qry = "Select Distinct NVL(INSTITUTECODE,' ')InstCode from institutemaster Where  " +
                                    " nvl(Deactive,'N')='N' and INSTITUTECODE in ('JIIT','JPBS','J128') ";
                            rs = db.getRowset(qry);
                            if (request.getParameter("x") == null) {
                    %>
                     <select size="1" name="Inst" tabindex="1" style="VERTICAL-ALIGN: middle; WIDTH: 90px">
                        <%
                            while (rs.next()) {
                                mInst = rs.getString("InstCode");

                        %>
                        <OPTION selected Value =<%=mInst%>><%=mInst%></option>
                        <%
                            }
                        %>
                    </select>
                    <%
                        } else {
                    %>
                     <select size="1" name="Inst" tabindex="1" style="VERTICAL-ALIGN: middle; WIDTH: 90px">
                        <%
                            while (rs.next()) {
                                mInst = rs.getString("InstCode");
                                if (mInst.equals(request.getParameter("Inst").toString().trim())) {
                        %>
                        <OPTION selected Value =<%=mInst%>><%=mInst%></option>
                        <%
                            } else {
                        %>
                        <OPTION Value =<%=mInst%>><%=mInst%></option>
                        <%
                                }
                            }
                        %>
                    </select>
                    <%
                            }
                        } catch (Exception e) {
                            //out.println(e.getMessage());
                        }

%></td>


                <td align="right"><font color=darkbrown face='Verdana' size=4>
            Welcome ADMIN</font>&nbsp; &nbsp; &nbsp;<br>
                <a href='SignOut.jsp'><font  face='Verdana' color="blue" size="2" ><b>Signout</B>
       </font></a>&nbsp; &nbsp; &nbsp;</td>
                        </tr>

                        <tr>
                            <td align="right" colspan="1">
                                <input type="submit" name="Submit" id="Submit" value="Submit">
                            </td>
                        </tr>
        </table>
     </form>
        <%
        if(request.getParameter("x")!=null)
            {

         if(request.getParameter("Inst")!=null)
             mInst=request.getParameter("Inst");
         else
             mInst="";




if(mInst.equals("JIIT"))
	{mBASELOGINID="asklJIITADMINaskl";
         mCode="JIITADMIN";
         }
else if(mInst.equals("JPBS"))
{	mBASELOGINID="asklJPBSADMINaskl";
        mCode="JPBSADMIN";
         }
else if	(mInst.equals("J128"))
	{mBASELOGINID="asklJ128ADMINaskl";
       	mCode="J128ADMIN";
         }
else
	{mBASELOGINID="asklADMINaskl";
         mCode="ADMIN";
         }

        qry="Select nvl(COMPANYTAGGING,'UNIV') from InstituteMaster where InstituteCode='"+ mInst +"'" +
                " And nvl(Deactive,'N')='N'";
		rs=db.getRowset(qry);
		if (rs.next())
		   mComp=rs.getString(1);
		else
		   mComp="";
		//System.out.print(mComp);
		qry="SELECT NVL(IPVELOCITYCOUNT,-1)COUNT FROM COMPANYINSTITUTETAGGING " +
                "WHERE COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"'";
		rs=db.getRowset(qry);
		if(rs.next())
			MAXHINT=rs.getInt(1);
		else
			MAXHINT=-1;
		if(MAXHINT!=-1)
		{
			try
			{
				if (request.getHeader("HTTP_X_FORWARDED_FOR") == null)
				{
					ipAddress= request.getRemoteAddr();
				}
				else
				{
					ipAddress= request.getHeader("HTTP_X_FORWARDED_FOR");
				}
			}
			catch(Exception e){}
			int count=1;
			qry="SELECT NVL(NOOFHITS,0)NOOFHITS FROM IPVELOCITYCHECK WHERE IPADDRESS='"+ipAddress+"' AND WEBMODULE='WEBKIOSK' AND ACTIONDATE=TO_DATE(TO_CHAR(sysdate,'DD-MM-YYYY'),'DD-MM-YYYY')";
			rs=db.getRowset(qry);
			if(rs.next())
			{
		      	int mNOOFHITS=rs.getInt(1);
				if(mNOOFHITS < MAXHINT)
				{
					mNOOFHITS++;
					qry="UPDATE IPVELOCITYCHECK SET  NOOFHITS='"+mNOOFHITS+"'WHERE IPADDRESS='"+ipAddress+"' AND WEBMODULE='WEBKIOSK' AND ACTIONDATE=TO_DATE(TO_CHAR(sysdate,'DD-MM-YYYY'),'DD-MM-YYYY')";
					db.update(qry);
				}
				else
				{
			         response.sendRedirect("LimitErrorPage.jsp");
				}
			}
			else
			{
				qry="INSERT INTO IPVELOCITYCHECK(IPADDRESS, WEBMODULE, ACTIONDATE, NOOFHITS) VALUES('"+ipAddress+"','WEBKIOSK',TO_DATE(TO_CHAR(sysdate,'DD-MM-YYYY'),'DD-MM-YYYY'),'"+count+"')";
				db.insertRow(qry);
			}
		}

		if(mCode.indexOf(mInst)>=0 || !mInst.equals("JIIT") || !mInst.equals("JPBS"))
		{


	            qry="Select nvl(ORATYP,' ')ORATYP,nvl(ORACD,' ')ORACD ,nvl(ORAID,' ')ORAID, ";
			qry=qry +" nvl(ORAPW,' ')PWD,nvl(ORAADM,' ') ROLENAME ,nvl(DEACTIVE,' ')DEACTIVE,nvl(FirstLogin,'Y') FirstLogin ,nvl(PAGEHEADING,' ') PAGEHEADING";
			qry=qry +" from Membermaster where  " +
                     " trim(ORACD)='"+mECode+"' and trim(ORATYP)='"+mEMemberType+"' AND ORAPW='"+mEPass+"' ";
	 		rs=db.getRowset(qry);
			//out.print(qry);
			if(rs.next() )
			{

				mDeac=rs.getString("Deactive");

				mpass=rs.getString("PWD");


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

				String PAGEHEADING="";
				PAGEHEADING=mInst+"-"+"<<Admin>>";

				if(mpass.equals(mEPass))
				{
					if(mDeac.equals("Y"))
				 	{
      	                  	out.print("<br><img src='../Images/Error1.jpg'  >");
			        	      out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Your account has been locked... </font> <br>");
					      out.print("<p><a href=../AdminLogin.jsp><img src='../Images/Back.jpg' border=0 ></a></p><br><br><br><br><br><br><br><br><br><br><br><br>");
			 		}
	                  	else
					{
						// Success Starts
						db.saveLogEntry("ADMIN", "A" , mMACAddress , mIPADDRESS);
						mBASELOGINTYPE=enc.encode("A");
                        mBASELOGINID=   enc.encode(mBASELOGINID);

						session.setAttribute("BASELOGINPASSWORD",mPass);
						session.setAttribute("BASELOGINTYPE",mBASELOGINTYPE);
						session.setAttribute("BASELOGINID",mBASELOGINID);
						session.setAttribute("BASEINSTITUTECODE",mInst);
						session.setAttribute("PageHeading",PAGEHEADING);
						session.setAttribute("IPADD",mIPADDRESS);

						session.setAttribute("CompanyCode",mComp);
						session.setAttribute("InstituteCode",mInst);

						session.setAttribute("LoginComp",mComp);
						%>


                        <HR HEIGHT=2 color=red>
						<table width='100%' align=CENTER>
						<tr>
						<td><table border=1><tr><td>
						<ul><font color=darkbrown size=4 face='Verdana'>Available ADMIN Options</font>
						<br>			<br>
						<b>
						<li><A href="AdminFiles/ResetPassADMIN.jsp" Target=_new Title='Reset Password Forcibly'><font color='#6b6d6a' size=3 face=arial>Reset password</font></A>
						<li><A href="AdminFiles/AdminDeactiveWebkioskMember.jsp" Target=_new Title='Lock/UnLock a Member'><font color='#6b6d6a' size=3 face=arial>Lock/UnLock Member</font></A>
						<li><A href="AdminFiles/AdminListLockedMember.jsp" Target=_new Title='List of Locked Members which can be unlocked too'><font color='#6b6d6a' size=3 face=arial>List of Locked Member (presently)</font></A>
						<li><A href="AdminFiles/AdminListOfMemberPassword.jsp" Target=_new Title='View Webkiosk Member Password'><font color='#6b6d6a' size=3 face=arial>List of Webkiosk Member Password</font></A>
						<li><A href="AdminFiles/AdminSignUp.jsp" Target=_new Title='Create a Login / Signup New Member (individually)'><font color='#6b6d6a' size=3 face=arial>Signup Member (Individual) </font></A>
						<li><A href="AdminFiles/AdminSignUpStudents.jsp" Target=_new Title='Create  LoginIDs for New Batch Students (in Bulk)'><font color='#6b6d6a' size=3 face=arial>Signup New Students (in Bulk)</font></A>
						<li><A href="AdminFiles/AdminSignUpParents.jsp" Target=_new Title='Create  LoginIDs for New Batch Students Fathers (in Bulk)'><font color='#6b6d6a' size=3 face=arial>Signup Parents (in Bulk)</font></A>
                                                <li><A href="AdminFiles/AdminMigrateStudPass.jsp" Target=_new Title='Migrate Student Internet Access Password to Webkiosk Password for New Batch Students (in Bulk)'><font color='#6b6d6a' size=3 face=arial>Migrate Student Password (in Bulk)</font></A>
						<li><A href="AdminFiles/AdminFramePage.jsp" Target=_new Title='Employee Role and Webpage Title(Dept. wise)'><font color='#6b6d6a' size=3 face=arial>Employee Role and Webpage Title (Department wise)</font></A>
						<!--<li><A href="AdminFiles/DeptwiseEmpRoleTitleInfo.jsp" Target=_new Title='Employee Role and Webpage Title(Dept. wise)'><font color='#6b6d6a' size=3 face=arial>Employee Role and Webpage Title (Department wise)</font></A>-->
						<li><A href="AdminFiles/ListofRoles.jsp" Target=_new Title='List of Members (Active/UnLocked only) and their Assigned Role'><font color='#6b6d6a' size=3 face=arial>List of Members (Active only) and their Assigned Role</font></A>
						<li><A href="AdminFiles/AdminLoginlogInfo.jsp" Target=_new Title='View User Login Log Information'><font color='#6b6d6a' size=3 face=arial>View Login Logs Information</font></A>
						<li><A href="AdminFiles/AdminLogtransInfo.jsp" Target=_new Title='View Transactional Log Information'><font color='#6b6d6a' size=3 face=arial>View Transaction Logs Information</font></A>
						<li><A target=_New href="AdminChangePassword.jsp" title="Change Admin Login Password"><font color='#6b6d6a' size=3 face=arial>Change Admin Password</font></A>
                                                <li><A href="AdminFiles/AdminLinkNewAdmission.jsp" Target=_new Title='Link for New Admission'><font color='#6b6d6a' size=3 face=arial>Link for New Admission</font></A>
						</b>
						</ul>
						</td></tr></table></td>

						<td ALIGN=CENTER><font color="darkbrown" style="FONT-SIZE: medium; FONT-FAMILY: verdana">
                          Member Login Screen</font><br>
                            <font color="darkbrown" style="FONT-SIZE: small; FONT-FAMILY: verdana"> [For Admin User Only]</font></b>
						<form Name=frmadminlogin Method=post Action="AdminUserAction.jsp">
						<table cellpadding=5 align=center rules=groups border=2 style="WIDTH: 250px; HEIGHT: 100px">
						<tr><td callspan=2><FONT color=black>&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Login Type</STRONG>&nbsp;&nbsp;&nbsp;&nbsp;</FONT></FONT></td>
						<td><select ID=MType Name=MType style="WIDTH: 105px">
						 <option value="S" Selected>Student</option>
					     	 <option value="E">Employee</option>
						 <!--<option value="G">Guest</option>
			      		 <option value="V">Visiting Staff</option>
						 -->
						</select></td>
						</tr>
						<tr>
					 	<td><FONT color=black>&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Login ID</STRONG></FONT>&nbsp;&nbsp;&nbsp; </FONT>
						</td>
						 <td><INPUT ID="MemberCode" Name="MemberCode" style="WIDTH: 105px; HEIGHT: 25px" onchange="MemberCode_onchange();" maxLength=50><FONT size=3 color=RED>*&nbsp;</FONT>
						</td>
						</tr>
						<tr>
						<td colspan=2 align=center><INPUT Type="submit" Value="Submit" onclick="RefreshContents();">&nbsp;<INPUT Type="reset" Value="Cancel"></td>
						</tr>
						 </table>
						</td>
						</tr>
						</table>
						<br>
						<CENTER>
						<p><font face=arial>Keep <a target=_new href="AdminChangePassword.jsp" title="Change Admin Login Password"><FONT color="blue"><u><b>changing your password</b></u></font></a> for better security</font>
						</form>
						<HR HEIGHT=2 color=red>
						<br><marquee behavior=alternate scrolldelay=250><font size=2 color=Green face='Verdana'><b>Don't forget to signout and close this screen when your job is over or leaving your PC/Laptop</b></font></marquee>
						</CENTER>
						<%
                  		}
				}
			 	else
            	      {
		      		out.print("<br><img src='../Images/Error1.jpg'  >");
					out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Invalid Password</font><br>");
				      out.print("<p><a href=../AdminLogin.jsp><img src='../Images/Back.jpg' border=0 ></a></p><br><br><br><br><br><br><br><br><br><br><br><br>");
				}
			}
	           	else
      		{
				out.print("<br><img src='../Images/Error1.jpg'  >");
				out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Wrong Member Type or Code</font> <br>");
				out.print("<p><a href=../AdminLogin.jsp><img src='../Images/Back.jpg' border=0 ></a></p><br><br><br><br><br><br><br><br><br><br><br><br>");
      	      }
		}
           	else
      	{
			out.print("<br><img src='../Images/Error1.jpg'  >");
			out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Wrong Member Type or Code ! &nbsp; Kindly Choose Valid Institute, Login ID and Password...</font> <br>");
			out.print("<p><a href=../AdminLogin.jsp><img src='../Images/Back.jpg' border=0 ></a></p><br><br><br><br><br><br><br><br><br><br><br><br>");
            }



    }//xx


       }
    else
        {
out.print("<br><img src='../Images/Error1.jpg'  >");
					out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Invalid Password</font><br>");
				      out.print("<p><a href=../AdminLogin.jsp><img src='../Images/Back.jpg' border=0 ></a></p><br><br><br><br><br><br><br><br><br><br><br><br>");
        }
    }
	else
      {
      	out.print("<br><img src='../Images/Error1.jpg'  >");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Login Type and LoginID are Mandatory!</font> <br>");
		out.print("<p><a href=../AdminLogin.jsp><img src=../Images/Back.jpg border=0 ></a></p><br><br><br><br><br><br><br><br><br><br><br><br>");
	}
}
catch(Exception e)
{
}
%>
</BODY>
</HTML>