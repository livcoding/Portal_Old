<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %> 
<%
String mHead="",mInst="";
ResultSet rsi=null;
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
   mHead=session.getAttribute("PageHeading").toString().trim();
else
   mHead="JIIT ";
%>

<HTML>
<HEAD>
<TITLE>#### <%=mHead%> [ Change Password Action ] </TITLE>
 
<script>
    if(window.history.forward(1) != null)
	window.history.forward(1);
</script>

<Title>Change Password Action</Title></head>
<BODY aLink=#ff00ff bgcolor="#fce9c5" rightmargin=5 leftmargin=5 topmargin=5 bottommargin=0 scroll=auto>
<%
OLTEncryption enc=new OLTEncryption();
String mMemberID="";
String mMemberType="",mMemberCode="";
String mOldPass="";
String mType="";
String mOldPwd="";
String mNewPwd="";
String mRetPwd="";
String mEOldPwd="";
String mENewPwd="";
String qry="",mCode="";
DBHandler db=new DBHandler();
ResultSet rs=null;
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

}
catch(Exception e)
{
mMaxPWD=20;
mMinPWD=4;

}
if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
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

if (request.getParameter("OldPassword")==null)
{
	mOldPwd="";
}
else
{
	mOldPwd=request.getParameter("OldPassword").toString().trim().toUpperCase();
}

if (request.getParameter("NewPassword")==null)
{
	mNewPwd="";
}
else
{
	mNewPwd=request.getParameter("NewPassword").toString().trim().toUpperCase();
}

if (request.getParameter("RetypePassword")==null)
{
	mRetPwd="";
}
else
{
	mRetPwd=request.getParameter("RetypePassword").toString().trim().toUpperCase();
}
String mIPAddress =session.getAttribute("IPADD").toString().trim();




// password 

int mValidPwd1=0,mValidPwd2=0,mValidPwd3=0;
	
//out.print("mValidPwd1::"+mValidPwd1+"::mValidPwd2::"+mValidPwd2+"::mValidPwd3::"+mValidPwd3+"LLLLL"+mPass.length());
if(mNewPwd.length() >= mMinPWD)
{
for(int ii=0;ii<mNewPwd.length();ii++)
	{

		if ( (mNewPwd.charAt(ii)>=65 && mNewPwd.charAt(ii)<=90) || (mNewPwd.charAt(ii)>=97 && mNewPwd.charAt(ii)<=122)) 
		{
		  mValidPwd1=1;	
		}
		
		
		if (mNewPwd.charAt(ii)>=48 && mNewPwd.charAt(ii)<=57) 
		{
		  mValidPwd2=1;	
		}
		
		if ( (mNewPwd.charAt(ii)>32 && mNewPwd.charAt(ii)<127) && !(mNewPwd.charAt(ii)>=65 && mNewPwd.charAt(ii)<=90)  && !(mNewPwd.charAt(ii)>=97 && mNewPwd.charAt(ii)<=122) ) 
		{
			mValidPwd3=1;	
	
		}
		
	}


}
else
{
mValidPwd1=0;mValidPwd2=0;mValidPwd3=0;
}

//out.print("mValidPwd1::"+mValidPwd1+"::mValidPwd2::"+mValidPwd2+"::mValidPwd3::"+mValidPwd3+"LLLLL"+mNewPwd.length());

if(mValidPwd1==1 && mValidPwd2==1  && mValidPwd3==1)
{

%>

<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
<%

if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}
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

//------------------mEOldPwd--------------------
if(!mOldPwd.equals("") && !mNewPwd.equals("") && !mRetPwd.equals("") && (mNewPwd.length()>=mMinPWD && mNewPwd.length()<=mMaxPWD) )
{
	try
	{	
		
		mEOldPwd=enc.encode(mOldPwd) ;		
		mENewPwd=enc.encode(mNewPwd);
		mCode=enc.decode(mMemberCode);
	      mType=enc.decode(mMemberType);
	}
	catch(Exception e)
	{
		// out.println(e.getMessage());
	}
	if (!mNewPwd.equals(mOldPwd))
	{	
	if (mNewPwd.equals(mRetPwd))
	{
		try
		{
			qry="Select nvl(ORAPW,' ')PWD From MEMBERMASTER Where trim(ORATYP)='"+mMemberType+"' and ORACD='"+mMemberCode+"'";
			//out.print(qry);
			rs=db.getRowset(qry);
			if(rs.next())
			{
			 	mOldPass=rs.getString("PWD").trim();
				mOldPass=enc.decode(mOldPass).toUpperCase();
				mOldPwd=mOldPwd.toUpperCase();
				//out.print(mOldPass+" "+mOldPwd);
				//if(!mOldPass.equals(mOldPwd))
			//	{
					qry="update MEMBERMASTER set ORAPW='"+mENewPwd+"',PWD=NULL,EMAIL=NULL,MEMCODE=NULL,MEMNAME=NULL  ,FIRSTLOGIN='Y' , FLAC=0  Where trim(ORACD)='"+mMemberCode+"' and trim(ORATYP)='"+mMemberType+"'";
					//out.print(qry);
					int n=db.update(qry);
					if(n>0)						  
					{
			       	  // Log Entry
	  		       	  //-----------------
			        	  db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"UPDATE PASSWORD", "Member Code : "+mCode+"Member Type :"+mType , "No MAC Address" , mIPAddress);
			      	  //-----------------
					  //out.print("<center> <b><font size=4 face='Arial' color='Green'><br>Password changed successfully. Click Back to Login Again.</center>");
						
						


						if(mType.equals("S"))
						{
							response.sendRedirect("../StudentFiles/StudentPage.jsp");
						}
						else if(mType.equals("E"))
						{
							response.sendRedirect("../EmployeeFiles/EmployeePage.jsp");  	
						}
						else 
						{
							 response.sendRedirect("../GuestFiles/GuestPage.jsp");  	
						}

							%>
					<table align=center>
					<tr><td>
					<a href ="../index.jsp"><img border=0 src='../Images/Back.jpg'></a>
					</td></tr>
					</table>
					<%

					}
					else
					{
						out.print("<center><img src='../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp<b><font size=3 face='Arial' color='Red'>Error while changing password</b></center>");
					%>
					<table align=center>
					<tr><td>
					<a href ="FirstTimeChangePassword.jsp"><img border=0 src='../Images/Back.jpg'></a>
					</td></tr>
					 </table>
					<%
					}
				
			}
			else
			{
				out.print("<center><img src='../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Invalid LoginID</font> <br>");
				%>
				<table align=center>
					<tr><td>
					<a href ="FirstTimeChangePassword.jsp"><img border=0 src='../Images/Back.jpg'></a>
					 </td></tr>
				 </table>
				<%			
			}
		}
		catch(Exception e)
		{
			out.println(e.getMessage());
		}	
	}
	else     
	{
		out.print("<center><img src='../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Error in Retype Password ! </font> <br>"); 
		%>
		<table align=center>
		<tr><td>
		<a href ="FirstTimeChangePassword.jsp"><img border=0 src='../Images/Back.jpg'></a>
		</td></tr>
		</table>
		<%
	}  
}
	else     
	{
		out.print("<center><img src='../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Error in Old Password ! </font> <br>"); 
		%>
		<table align=center>
		<tr><td>
		<a href ="FirstTimeChangePassword.jsp"><img border=0 src='../Images/Back.jpg'></a>
		</td></tr>
		</table>
		<%
	}  
}
else
{
	out.print("<center><img src='../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Field(s) should not be empty</font> <br>");
	out.print(" &nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Password Lengh must be between "+mMinPWD+" and "+ mMaxPWD+" only</font> <br>");
%>
	<table align=center>
		<tr><td>
		<a href ="FirstTimeChangePassword.jsp"><img border=0 src='../Images/Back.jpg'></a>
		</td></tr>
	</table>
<%
}

}	

else
{


%>
	<table align=center rules=groups border=1  style="WIDTH: 550px;">
<tr><td colspan=3><FONT size=2 color=red face = arial><br>
	
	<b>
	<P style="BACKGROUND: #fce9c5; LINE-HEIGHT: 140%; MARGIN-RIGHT: 11.25pt"><B><SPAN 
style="FONT-SIZE: 5pt; COLOR: red; FONT-FAMILY: 'Trebuchet MS'"><FONT 
size=4>&nbsp;New Password Should:</FONT></SPAN></B></P>
<UL style="MARGIN-TOP: 0in" type=circle>
  <LI class=MsoNormal 
  style="BACKGROUND: #fce9c5; MARGIN: 0in 11.5pt 0pt 0in; COLOR: #222222; LINE-HEIGHT: 140%; mso-margin-bottom-alt: auto; mso-list: l0 level1 lfo3; tab-stops: list .5in"><B><SPAN 
  style="FONT-FAMILY: Verdana; mso-bidi-font-size: 11.0pt"><FONT color=#954b5c>Minimum length should be of <%=mMinPWD%> characters and maximum of <%=mMaxPWD%>
 <o:p></O:P></FONT></SPAN></B>
  <LI class=MsoNormal 
  style="BACKGROUND: #fce9c5; MARGIN: 0in 11.5pt 0pt 0in; COLOR: #222222; LINE-HEIGHT: 140%; mso-margin-bottom-alt: auto; mso-list: l0 level1 lfo3; tab-stops: list .5in"><B><SPAN 
  style="FONT-FAMILY: Verdana; mso-bidi-font-size: 11.0pt"><FONT color=#954b5c>Password is case sensitive

  <o:p></O:P></FONT></SPAN></B>
  <LI class=MsoNormal 
  style="BACKGROUND: #fce9c5; MARGIN: 0in 11.5pt 0pt 0in; COLOR: #222222; LINE-HEIGHT: 140%; mso-margin-bottom-alt: auto; mso-list: l0 level1 lfo3; tab-stops: list .5in"><B><SPAN 
  style="FONT-FAMILY: Verdana; mso-bidi-font-size: 11.0pt"><FONT color=#954b5c>Must contain at least one numeric, one alphabet and one special character 

  <o:p></O:P></FONT></SPAN></B>

 <LI class=MsoNormal 
  style="BACKGROUND: #fce9c5; MARGIN: 0in 11.5pt 0pt 0in; COLOR: #222222; LINE-HEIGHT: 140%; mso-margin-bottom-alt: auto; mso-list: l0 level1 lfo3; tab-stops: list .5in"><B><SPAN 
  style="FONT-FAMILY: Verdana; mso-bidi-font-size: 11.0pt"><FONT color=#954b5c>Allowed Special characters like @,#,_,-,<,>,?,/,|,},{,*,&,^,%,$,,! etc.

  <o:p></O:P></FONT></SPAN></B>



	<br>

	
	</FONT>
	<br>
	</td></tr>
</table>
	<table align=CENTER>
		<tr><td>
		<a href ="FirstTimeChangePassword.jsp"><img border=0 src='../Images/Back.jpg'></a>
		</td></tr>
	</table>
<%
}




%>
</body>
</html>