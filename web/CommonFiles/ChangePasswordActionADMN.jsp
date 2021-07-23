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
<TITLE>#### <%=mHead%> [ Change Password Action ] </TITLE>
 

 
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

<Title>Change Password Action</Title></head>
<BODY aLink=#ff00ff bgcolor="#fce9c5" rightmargin=5 leftmargin=5 topmargin=5 bottommargin=0 scroll=auto>
<%

String mMemberID="";
String mMemberType="";
String mOldPass="";

String mOldPwd="";
String mNewPwd="";
String mRetPwd="";

String mEOldPwd="";
String mENewPwd="";

String qry="";
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

if (session.getAttribute("BASELOGINID")==null)
{
	mMemberID="";
}
else
{
	mMemberID=session.getAttribute("BASELOGINID").toString().trim();
}

if (session.getAttribute("BASELOGINTYPE")==null)
{
	mMemberType="";
}
else
{
	mMemberType=session.getAttribute("BASELOGINTYPE").toString().trim();
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
if(!mMemberID.equals("") && !mMemberType.equals(""))
{
	mMemberID=enc.decode(mMemberID);
	mMemberType=enc.decode(mMemberType);

	
	
	if(mMemberType.trim().equals("A") &&  mMemberID.trim().equals("asklADMINaskl"))
	{
		mMemberID=enc.encode("ADMIN");
		mMemberType=enc.encode("A");
	}
	else if(mMemberType.trim().equals("A") &&  mMemberID.trim().equals("asklJIITADMINaskl"))
	{
		mMemberID=enc.encode("JIITADMIN");
		mMemberType=enc.encode("A");
	}
	else if(mMemberType.trim().equals("A") &&  mMemberID.trim().equals("asklJPBSADMINaskl"))
	{
		mMemberID=enc.encode("JPBSADMIN");
		mMemberType=enc.encode("A");
	}

	else
	{
		mMemberID="";
		mMemberType="";
	}
	
}
if(!mMemberID.equals("") && !mMemberType.equals(""))
{
	if(!mOldPwd.equals("") && !mNewPwd.equals("") && !mRetPwd.equals("") && (mNewPwd.length()>=mMinPWD && mNewPwd.length()<=mMaxPWD) )
	{
	try
	{	
		mEOldPwd=enc.encode(mOldPwd) ;				
		mENewPwd=enc.encode(mNewPwd);
	}
	catch(Exception e)
	{
		//out.println(e.getMessage());
	}
	if (mNewPwd.equals(mRetPwd))
	{
		try
		{
			qry="Select nvl(ORAPW,' ')PWD From MEMBERMASTER Where trim(ORAID)='"+mMemberID+"' and trim(ORATYP)='"+mMemberType+"'";
			rs=db.getRowset(qry);
			//out.print(qry);
			if(rs.next())
			{
			 	mOldPass=rs.getString("PWD").trim();
				//out.print(enc.decode(mOldPass) + " "+(enc.decode(mEOldPwd)));
				if(mOldPass.equals(mEOldPwd))
				{
					qry="update MEMBERMASTER set ORAPW='"+mENewPwd+"' Where trim(ORAID)='"+mMemberID+"' and trim(ORATYP)='"+mMemberType+"'";
					int n=db.update(qry);
					if(n>0)						  
					{
					 out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Green'><br>Password changed successfully");
					}
					else
					{
						out.print("<center><img src='../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp<b><font size=3 face='Arial' color='Red'>Error while changing password</b></center>");
					%>
					<table align=center>
					<tr><td>
					<a href ="AdminChangePassword.jsp"><img border=0 src='../Images/Back.jpg'></a>
					</td></tr>
					 </table>
					<%
					}
				}
				else
				{
					out.print("<center><img src='../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Old password is incorrect</font> <br>");
					%>
					<table align=center>
					<tr><td>
					<a href ="AdminChangePassword.jsp"><img border=0 src='../Images/Back.jpg'></a>
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
					<a href ="AdminChangePassword.jsp"><img border=0 src='../Images/Back.jpg'></a>
					 </td></tr>
				 </table>
				<%			
			}	
		}
		catch(Exception e)
		{
			//out.println(e.getMessage());
		}	
	}
	else     
	{
		out.print("<center><img src='../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Error in New Password! </font> <br>"); 
		%>
		<table align=center>
		<tr><td>
		<a href ="AdminChangePassword.jsp"><img border=0 src='../Images/Back.jpg'></a>
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
		<a href ="AdminChangePassword.jsp"><img border=0 src='../Images/Back.jpg'></a>
		</td></tr>
	</table>
<%
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
%>
<br><a href="" onClick="window.self.close();"><font color=blue face='arial' size=3>Close Window</font></a><br>

</body>
</html>