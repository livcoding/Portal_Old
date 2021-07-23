<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JUIT ";
%>
<HTML>
<head>

<style type="text/css"> 
body {scrollbar-3dlight-color:#ffd700;
scrollbar-arrow-color:#ff0; 
scrollbar-base-color:=:#000ff0;
scrollbar-darkshadow-color:#000000; 
scrollbar-face-color:#de6400; 
scrollbar-highlight-color:#9900005;
scrollbar-shadow-color:#f0f} 
</style> 

<TITLE>#### <%=mHead%> [Change Contact information] </TITLE>
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
    	    document.frm.submit();
	}
//-->
</script>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
<SCRIPT TYPE="text/javascript">
<!--
// copyright 1999 Idocs, Inc. http://www.idocs.com
// Distribute this script freely but keep this notice in place
function numbersonly(myfield, e, dec)
{
var key;
var keychar;

if (window.event)
   key = window.event.keyCode;
else if (e)
   key = e.which;
else
   return true;
keychar = String.fromCharCode(key);

// control keys
if ((key==null) || (key==0) || (key==8) || 
    (key==9) || (key==13) || (key==27) )
   return true;

// numbers
else if ((("0123456789.").indexOf(keychar) > -1))
   return true;

// decimal point jump
else if (dec && (keychar == "."))
   {
   myfield.form.elements[dec].focus();
   return false;
   }
else
   return false;
}

//-->
</SCRIPT>

</head>
<body topmargin=0 rightmargin=0 leftmargin=10 bottommargin=0 bgcolor=#fce9c5>
<%
String mSCellNo="", mPCellNo="", mSTelNo="", mPTelNo="", mSEmail="",mPEmail="";
String mInstC="",mWebEmail="",mMemberID="",mADDRESS1="",mADDRESS2="",mADDRESS3="";
String mMem="",mCITY="",mPIN="",mPOSTOFFICE="",mRAILSTATION="";
String mMemID="",mPOLSTATION="",mDISTRICT="",mSTATE="";
String mDID="";
String qry="";
String mScellNo="",mMemberType="";
String mStelNo="";
String mSstd="";
String mSemail="";
String mPcellNo="";
String mPstd="";
String mPtelNo="";
String mPemail="",mInst="",mCD="",mPyear="",mTEMPDID="",mUniqueid="";

ResultSet rs=null,rsi=null;
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
try
{
if (session.getAttribute("WebAdminEmail")==null)
{
	 mWebEmail="";
}	 
else
{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
}
if (session.getAttribute("InstituteCode")==null)
{
    mInst="";
}
else
{
    mInst=session.getAttribute("InstituteCode").toString().trim();
}
if (session.getAttribute("MemberType")==null)
{
	mMemberType="";
}
else
{
	mMemberType=session.getAttribute("MemberType").toString().trim();
}

if(session.getAttribute("MemberCode")==null)
{
	mMem="";	
}
else
{
	mMem=session.getAttribute("MemberCode").toString().trim();
}
if(session.getAttribute("MemberID")==null)
{
	mMemID="";	
}
else
{
	mMemID=session.getAttribute("MemberID").toString().trim();
}
if(session.getAttribute("MemberID")==null)
{
	mMemberID="";	
}
else
{
	mMemberID=session.getAttribute("MemberID").toString().trim();
}
if (session.getAttribute("MemberID")!=null && session.getAttribute("MemberCode")!=null)
{
	OLTEncryption enc=new OLTEncryption();
	mDID=enc.decode(session.getAttribute("MemberID").toString().trim());
	mCD=enc.decode(session.getAttribute("MemberCode").toString().trim());
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
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

  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('29','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------

	qry="select To_Char(Sysdate,'YYYY')Pyear from dual ";
	rs=db.getRowset(qry);
	if(rs.next())
		mPyear=rs.getString("Pyear");

	//if (request.getParameter("x")!=null)
	//{
		if(request.getParameter("SCellNo")==null)
			mScellNo="";
		else
			mScellNo=GlobalFunctions.replaceSignleQuot(request.getParameter("SCellNo").toString().trim());	
		
		if(request.getParameter("SSTD")==null)
			mSstd="";
		else
			mSstd=GlobalFunctions.replaceSignleQuot(request.getParameter("SSTD").toString().trim());	

		if(request.getParameter("STelNo")==null)
			mStelNo="";
		else
			mStelNo=GlobalFunctions.replaceSignleQuot(request.getParameter("STelNo").toString().trim());	

		if (request.getParameter("SEMail")==null)
			mSemail="";
		else
			mSemail=GlobalFunctions.replaceSignleQuot(request.getParameter("SEMail").toString().trim());	

		if (request.getParameter("PCellNo")==null)
			mPcellNo="";
		else
			mPcellNo=GlobalFunctions.replaceSignleQuot(request.getParameter("PCellNo").toString().trim());	

		if (request.getParameter("PSTD")==null)
			mPstd="";
		else
			mPstd=GlobalFunctions.replaceSignleQuot(request.getParameter("PSTD").toString().trim());	

		if(request.getParameter("PTelNo")==null)
			mPtelNo="";
		else
			mPtelNo=GlobalFunctions.replaceSignleQuot(request.getParameter("PTelNo").toString().trim());	
		
		if(request.getParameter("PEMail")==null)
			mPemail="";
		else
			mPemail=GlobalFunctions.replaceSignleQuot(request.getParameter("PEMail").toString().trim());
		
        if(request.getParameter("Address1")==null)
			mADDRESS1="";
		else
			mADDRESS1=GlobalFunctions.replaceSignleQuot(request.getParameter("Address1").toString().trim());	
		if(request.getParameter("Address2")==null)
			mADDRESS2="";
		else
			mADDRESS2=GlobalFunctions.replaceSignleQuot(request.getParameter("Address2").toString().trim());
		if(request.getParameter("Address3")==null)
			mADDRESS3="";
		else
			mADDRESS3=GlobalFunctions.replaceSignleQuot(request.getParameter("Address3").toString().trim());
		if(request.getParameter("City")==null)
			mCITY="";
		else
			mCITY=GlobalFunctions.replaceSignleQuot(request.getParameter("City").toString().trim());
		if(request.getParameter("Pin")==null)
			mPIN="";
		else
			mPIN=GlobalFunctions.replaceSignleQuot(request.getParameter("Pin").toString().trim());
		if(request.getParameter("Post0ffice")==null)
			mPOSTOFFICE="";
		else
			mPOSTOFFICE=GlobalFunctions.replaceSignleQuot(request.getParameter("Post0ffice").toString().trim());
		if(request.getParameter("RailStation")==null)
			mRAILSTATION="";
		else
			mRAILSTATION=GlobalFunctions.replaceSignleQuot(request.getParameter("RailStation").toString().trim());
		if(request.getParameter("PolStation")==null)
			mPOLSTATION="";
		else
			mPOLSTATION=GlobalFunctions.replaceSignleQuot(request.getParameter("PolStation").toString().trim());
		if(request.getParameter("District")==null)
			mDISTRICT="";
		else
			mDISTRICT=GlobalFunctions.replaceSignleQuot(request.getParameter("District").toString().trim());
		if(request.getParameter("State")==null)
			mSTATE="";
		else
			mSTATE=GlobalFunctions.replaceSignleQuot(request.getParameter("State").toString().trim());
        out.print("mSTATE :"+mSTATE);
		
		int n=0,m=0,x=0,y=0;

		
		mTEMPDID="TMP"+mDID;

		if(!mSemail.equals(""))
		{
          	qry="SELECT 'y' FROM StudentPhone where studentid='"+mDID+"'";  
		rs=db.getRowset(qry);
		if (rs.next())
			{
	            qry="update STUDENTPHONE set STCELLNO='"+mScellNo+"',STSTDCODE='"+mSstd+"',STTELNO='"+mStelNo+"',";
			qry=qry +" STEMAILID='"+mSemail+"',PACELLNO='"+mPcellNo+"',PASTDCODE='"+mPstd+"',PATELNO='"+mPtelNo+"',";
            	qry=qry +"PAEMAILID='"+mPemail+"' where studentid='"+mDID+"' ";
				//out.print(qry);
			 n =db.update(qry);
			
			}
		else
			{
			qry=" Insert into STUDENTPHONE (StudentID,STCELLNO,STSTDCODE,STTELNO,STEMAILID, PACELLNO,PASTDCODE,PATELNO,PAEMAILID)";
			qry=qry+" Values('"+mDID+"','"+mScellNo+"','"+mSstd+"','"+mStelNo+"','"+mSemail+"','"+mPcellNo+"','"+mPstd+"','"+mPtelNo+"','"+mPemail+"')";
			out.print(qry);
			n =db.insertRow(qry);

			}

///-------------------------temp#studentPhone------------------------------
		
		

				qry="SELECT 'y' FROM TEMP#Studentphone where TEMP#STUDENTID='"+mTEMPDID+"'";  
				rs=db.getRowset(qry);
				if(rs.next())
				{
					 qry="update TEMP#Studentphone set	STCELLNO='"+mScellNo+"',STSTDCODE='"+mSstd+"',STTELNO='"+mStelNo+"',";
					qry=qry +" STEMAILID='"+mSemail+"',PACELLNO='"+mPcellNo+"',PASTDCODE='"+mPstd+"',PATELNO='"+mPtelNo+"',";
	            	qry=qry +"PAEMAILID='"+mPemail+"' where TEMP#STUDENTID='"+mTEMPDID+"' ";
					//out.print(qry);
					 x=db.update(qry);
				}
				else
				{

					qry="SELECT 'y' FROM TEMP#StudentMASTER where TEMP#STUDENTID='"+mTEMPDID+"'";  
					rs=db.getRowset(qry);
					if(rs.next())
					{

					mUniqueid=db.Gettabuniqueid(mPyear);
	
					qry=" Insert into TEMP#Studentphone (   TEMP#STUDENTID, STSTDCODE, STTELNO, STCELLNO, STEMAILID, PASTDCODE,   PATELNO, PACELLNO, PAEMAILID, INSTITUTECODE, UNIQUEID)";
					qry=qry+" Values('"+mTEMPDID+"','"+mSstd+"','"+mStelNo+"','"+mScellNo+"','"+mSemail+"','"+mPstd+"','"+mPtelNo+"','"+mPcellNo+"','"+mPemail+"','"+mInst+"','"+mUniqueid+"')";
					out.print(qry);
					x =db.insertRow(qry);
					}
				}







			qry="SELECT 'y' FROM StudentAddress where studentid='"+mDID+"'";  
		rs=db.getRowset(qry);
		if (rs.next())
			{
	            qry="update STUDENTADDRESS set CADDRESS1='"+mADDRESS1+"', CADDRESS2='"+mADDRESS2+"', CADDRESS3='"+mADDRESS3+"', CCITY='"+mCITY+"', CPIN='"+mPIN+"', CDISTRICT='"+mDISTRICT+"', CPOSTOFFICE='"+mPOSTOFFICE+"', CRAILSTATION='"+mRAILSTATION+"', CPOLICESTATION='"+mPOLSTATION+"',CSTATE='"+mSTATE+"',CSTDCODE='"+mSstd+"', CPHONENO='"+mStelNo+"',PSTDCODE='"+mPstd+"', PPHONENO='"+mPtelNo+"' where studentid='"+mDID+"' ";
			//out.print(qry);
			 m =db.update(qry);
			}
		else
			{
			qry=" Insert into STUDENTADDRESS (STUDENTID,CADDRESS1, CADDRESS2, CADDRESS3, CCITY, CPIN, CDISTRICT, CPOSTOFFICE, CRAILSTATION, CPOLICESTATION, CSTATE,CSTDCODE,CPHONENO,PSTDCODE,PPHONENO)";
			qry=qry+" Values('"+mDID+"','"+mADDRESS1+"','"+mADDRESS2+"','"+mADDRESS3+"','"+mCITY+"','"+mPIN+"','"+mDISTRICT+"','"+mPOSTOFFICE+"','"+mRAILSTATION+"','"+mPOLSTATION+"','"+mSTATE+"','"+mSstd+"', '"+mStelNo+"','"+mPstd+"','"+mPtelNo+"')";
			//out.print(qry);
			m =db.insertRow(qry);

			}


//-----------------------Temp#studentaddress--------------------

			qry="SELECT 'y' FROM TEMP#STUDENTADDRESS where TEMP#STUDENTID='"+mTEMPDID+"'";  
		rs=db.getRowset(qry);
		if (rs.next())
			{
	            qry="update TEMP#STUDENTADDRESS set CADDRESS1='"+mADDRESS1+"', CADDRESS2='"+mADDRESS2+"', CADDRESS3='"+mADDRESS3+"', CCITY='"+mCITY+"', CPIN='"+mPIN+"', CDISTRICT='"+mDISTRICT+"', CPOSTOFFICE='"+mPOSTOFFICE+"', CRAILSTATION='"+mRAILSTATION+"', CPOLICESTATION='"+mPOLSTATION+"',CSTATE='"+mSTATE+"',CSTDCODE='"+mSstd+"', CPHONENO='"+mStelNo+"',PSTDCODE='"+mPstd+"', PPHONENO='"+mPtelNo+"' where TEMP#STUDENTID='"+mTEMPDID+"' ";
			//out.print(qry);
			 m =db.update(qry);
			}
		else
			{
			
				qry="SELECT 'y' FROM TEMP#StudentMASTER where TEMP#STUDENTID='"+mTEMPDID+"'";  
				rs=db.getRowset(qry);
				if(rs.next())
				{
				mUniqueid=db.Gettabuniqueid(mPyear);

				qry=" Insert into TEMP#STUDENTADDRESS (TEMP#STUDENTID,CADDRESS1, CADDRESS2, CADDRESS3, CCITY, CPIN, CDISTRICT, CPOSTOFFICE, CRAILSTATION, CPOLICESTATION, CSTATE,CSTDCODE,CPHONENO,PSTDCODE,PPHONENO,UNIQUEID)";
				qry=qry+" Values('"+mTEMPDID+"','"+mADDRESS1+"','"+mADDRESS2+"','"+mADDRESS3+"','"+mCITY+"','"+mPIN+"','"+mDISTRICT+"','"+mPOSTOFFICE+"','"+mRAILSTATION+"','"+mPOLSTATION+"','"+mSTATE+"','"+mSstd+"', '"+mStelNo+"','"+mPstd+"','"+mPtelNo+"','"+mUniqueid+"')";
				out.print(qry);
				m =db.insertRow(qry);
				}

			}

		if((n>0 && m>0 ) ||  (x>0 && y>0) )
		{
		   
	       //------- Log Entry
	  	//-----------------
		   	 db.saveTransLog(mInstC,mLogEntryMemberID,mLogEntryMemberType ,"EDIT INFORMATION STUDENT", "Member Code : "+mCD, "No MAC Address" , mIPAddress);
	     //-----------------
		
  		response.sendRedirect("StudModifyEmailIDTelephone.jsp");
        //RequestDispatcher rd=request.getRequestDispatcher("StudModifyEmailIDTelephone.jsp");
		//rd.forward(request,response);
		//out.print("ASAFaGg");
		}
		else
		{	
			out.print("<br><img src='../../Images/Error1.jpg'>");
			out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Error while saving</font></b><br>");

		}

		}
		else
		{
			out.print("<br><img src='../../Images/Error1.jpg'>");
			out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Student's E-Mail can't be left blank</font></b><br>");
		}
	//}




  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
  }
  else
   {
   %>
	<br>
	<font color=red>
	<h3>	<br><img src='../../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. <br><br><br>
	</font>
   <%
	
	
   }
  //-----------------------------

}
else
{
%>
<br>Session timeout! Please <a href="../../index.jsp">Login</a> to continue...
 <%
	}

}
catch(Exception e)
{
}
 %><br>
<center>
<table ALIGN=Center VALIGN=TOP>
		<tr>
		<td valign=middle>
		<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">
		<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
		A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
		<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>
		</td></tr></table></body>
</html>
