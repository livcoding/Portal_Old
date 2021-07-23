<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Reset password forcibly ] </TITLE>
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
	document.frm.x.value='ddd';
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
	OLTEncryption enc=new OLTEncryption();
try
{
	DBHandler db=new DBHandler();
	ResultSet rs=null;

	String mMType="",mEMType="";
	String qry="",qry2="";;
	String mMemberID="";
	String mMemberType="";

	String mMemberCode="";
	String mEMemberCode="";

	String mNewPass="";
	String mRetPass="";
	String mENewPass="";
	String mERetPass="";
	
	int mMaxPWD=20;
	int mMinPWD=5;

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

	if (session.getAttribute("MaxPasswordLength")==null)
	{
		mMaxPWD=20;
	}
	else
	{
		mMaxPWD=Integer.parseInt(session.getAttribute("MaxPasswordLength").toString().trim());		 
	}

	if (session.getAttribute("MinPasswordLength")==null)
	{
		mMinPWD=4;
	}
	else
	{
		mMinPWD=Integer.parseInt(session.getAttribute("MinPasswordLength").toString().trim());		 
	}
	
	if(!mMemberID.equals("") && !mMemberType.equals("")) 
	{


	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
String mMacAddress =" "; //session.getAttribute("IPADD").toString().trim();

	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('39','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------
	%>
		<form name="frm">
		<input id="x" name="x" type=hidden>
		<table width="100%" ALIGN=CENTER bottommargin=0 topmargin=0>
		<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">Reset Member Webkiosk Password<br>[Admin User Only]</font></td></tr>
		</table>

		<table cellpadding=5 align=center rules=groups border=2 style="WIDTH: 400px; HEIGHT: 100px">
		<tr><td callspan=2><FONT color=black>&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Member Type</STRONG>&nbsp;&nbsp;&nbsp;&nbsp;</FONT></FONT></td>
		<td><select ID=MType Name=MType style="WIDTH: 165px">
		
		<%
		if(request.getParameter("MType")==null)
		{
		%>
			<option value="S" Selected>Student</option>
	     		<option value="E">Employee</option>
			<option value="G">Guest</option>		
      		<option value="V">Visitor</option>		
		<%
		}
		else
		{
			if(request.getParameter("MType").toString().trim().equals("S"))
			{
			%>
				<option value="S" Selected>Student</option>
			<%
			}
			else
			{
			%>
				<option value="S">Student</option>
			<%
			}	
			
			if(request.getParameter("MType").toString().trim().equals("E"))
			{
			%>
				<option value="E" Selected>Employee</option>
			<%
			}
			else
			{
			%>
				<option value="E">Employee</option>
			<%
			}
			
			if(request.getParameter("MType").toString().trim().equals("G"))
			{
			%>
				<option value="G" Selected>Guest</option>
			<%
			}
			else
			{
			%>
				<option value="G">Guest</option>
			<%
			}	

			if(request.getParameter("MType").toString().trim().equals("V"))
			{
			%>
				<option value="V" Selected>Visitor</option>
			<%
			}
			else
			{
			%>
				<option value="V">Visitor</option>
			<%
			}
		}
		%>
	 	</select>
		</td></tr><br>
		<tr>
	 	<td><FONT color=black>&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Member Code</STRONG></FONT>&nbsp;&nbsp;&nbsp; </FONT></td>
		 <td><INPUT ID="MemberCode" Name="MemberCode" style="WIDTH: 165px; HEIGHT: 25px" maxLength=50><FONT size=3 color=RED>*&nbsp;</FONT></td>
		</tr><tr>	
	 	<td><FONT color=black>&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>New Password</STRONG></FONT>&nbsp;&nbsp;&nbsp; </FONT></td>
		 <td><INPUT ID="NewPass" Name="NewPass" TYPE="password" style="WIDTH: 165px; HEIGHT: 25px" maxLength=20><FONT size=3 color=RED>*&nbsp;</FONT><br><FONT size=1 color=green>Hint: Min <%=mMinPWD%> & Max <%=mMaxPWD%> Characters</FONT></td>
		</tr><tr>	
	 	<td><FONT color=black>&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Retype New Password</STRONG></FONT>&nbsp;&nbsp;&nbsp; </FONT></td>
		 <td><INPUT ID="RetPass" Name="RetPass" TYPE="password" style="WIDTH: 165px; HEIGHT: 25px" maxLength=20><FONT size=3 color=RED>*&nbsp;</FONT></td>
		</tr>
		<tr><td colspan=2 align=center><INPUT Type="submit" Value="Save" onclick="RefreshContents();">&nbsp;<INPUT Type="reset" Value="Reset"></td></tr>
	</table>
	</form>
<%
		if(request.getParameter("x")!=null)
		{
		if (request.getParameter("MType")==null)
		{
			mMType="";
		}
		else
		{
			mMType=request.getParameter("MType").toString().trim();
		}

		if(request.getParameter("MemberCode")==null)
		{
			mMemberCode="";
		}
		else
		{
			mMemberCode=request.getParameter("MemberCode").toString().trim();
		}

		if (request.getParameter("NewPass")==null)
		{
			mNewPass="";
		}
		else
		{
			mNewPass=request.getParameter("NewPass").toString().trim().toUpperCase();
		}

		if (request.getParameter("RetPass")==null)
		{
			mRetPass="";
		}
		else
		{
			mRetPass=request.getParameter("RetPass").toString().trim().toUpperCase();
		}
		if(!mMemberCode.equals("") && !mNewPass.equals("") && !mRetPass.equals(""))
		{
			mEMemberCode=enc.encode(mMemberCode);
			mEMType=enc.encode(mMType);
			mENewPass=enc.encode(mNewPass);
			mERetPass=enc.encode(mRetPass);

			if (mENewPass.equals(mERetPass) && (mNewPass.length()>=mMinPWD && mNewPass.length()<=mMaxPWD))
			{
				qry="update MEMBERMASTER set ORAPW='"+mENewPass+"' Where trim(ORATYP)='"+mEMType+"' and trim(ORACD)='"+mEMemberCode+"'";
				int n=db.update(qry);
			qry2="INSERT INTO LOGTRANSINFO (MEMBERID, MEMBERTYPE, TRANSTYPE,TRANSDETAIL, MACADDRESS, IPADDRESS,TRANSDATETIME) ";
			qry2=qry2+ " VALUES ('"+mChkMemID+"','"+mChkMType+"','Password Change','"+mMemberCode+" "+mMType+"','"+mMacAddress+"','"+mIPAddress+"',sysdate ) ";
			int n=db.insertRow(qry2);

				if(n>0)			  
				{
					out.print("<center><b><font size=3 face='Arial' color='Green'>Password changed successfully</font></b></center>");
				}
				else
				{
					out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Please select valid Member Type or enter valid Member Code</font></b></center>");
				}
			}
			else
			{
				out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Error in New Password! </font></b></center>"); 
			}
		}
		else
		{
		out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Field(s) can't be empty</font></b></center>");
		}
	}

 //-----------------------------
  //-- Enable Security Page Level  
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
	}
	else
	{
	out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font></b></center>");
	}

}
catch(Exception e)
{
}
%>
	<br><br><br><br><hr><table ALIGN=Center VALIGN=TOP>
	<tr>
		<td valign=middle>
		<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">	<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT>
		</td>
	</tr>
	</table>
</body>
</html>