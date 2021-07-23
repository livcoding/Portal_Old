<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %> 
<%
OLTEncryption enc=new OLTEncryption();

String mHead="",mInst="";
ResultSet rsi=null;
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
var chh;
chh=SignupForm.UType.value ;
if (chh=='S') 
	SignupForm.txtCaption.value ='Enrollment No';	
else if (chh=='E') 
	SignupForm.txtCaption.value ='Employee Code';
else if (chh=='V') 
	SignupForm.txtCaption.value ='Visiting Staff ID';
else
	SignupForm.txtCaption.value ='Guest ID';

}

function MemberCode_onchange() 
	{
	 var txt1;
		txt1=SignupForm.MemberCode.value;
		SignupForm.MemberCode.value = txt1.toUpperCase();
	}

//-->
</SCRIPT>
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

/*
	' **********************************************************************************************************
	' *													   *
	' * File Name:	SignupAction.jsp [For New User (all)]						           *
	' * Author:		Ashok Kumar Singh 							           *
	' * Date:		28th Dec 2006								   *
	' * Version:		1.1									   *
       	' * Description:	RegisterUser Details for new users*
 	' **********************************************************************************************************
         */
%>
<BODY aLink=#ff00ff bgcolor="#fce9c5" rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 scroll=auto>
<!*********--Institute--************>
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
  %>
<center><FONT face=Arial>&nbsp;
<br><br>
<%    

long mnFlag=0,mFlag=0;
String mDateTime="" , mPPass1="";
String mUType="", mMUType="", mUserID="",mUserCode="",mPass1="",mPass2="",mEMail="";

if (request.getParameter("TxtUserCode")==null)
  mUserCode="";
else
  mUserCode=request.getParameter("TxtUserCode").trim();

if (request.getParameter("TxtEMail")==null)
{
  mEMail="";
}
else
{
  mEMail=request.getParameter("TxtEMail").trim();
}

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
    mUType="";  
  }
else
  {
    mUType=request.getParameter("UType").trim();
  }
  
  if (mUType=="S")
  {
    mMUType="Student";
  }
  else if (mUType=="E")
  {
    mMUType="Employee";
  }
  else
  {
    mMUType="Guest";
  }
if (mUserCode != "" && mPass1 != ""  && mEMail!="" && mPass2 != "")  //1
{
	if (PublicDataFunction.isValidEmail(mEMail)==true ) //2
        {
           if (PublicDataFunction.isNumeric(mPass1) && PublicDataFunction.isNumeric(mPass2) && mPass1.length()<=10 && mPass2.length()<=10 )  //3
		{
                  if (mPass1.trim().equals(mPass2.trim()) )	 //4
                  {
      			qry="select ORAT4 from OraTemp8i where ORAT4='"+ mEMail + "'";
			Rs = db.getRowset(qry);
                        if (Rs.next()==false) //5
         		{
                        qry="select OraT2 from OraTemp8i where OraT1='"+ PublicDataFunction.InstituteCode + "' and OraT3='" + mUserCode + "' and OraTType='" + mUType + "' and nvl(OraTStatus,'Y')='Y'";
                        Rs = db.getRowset(qry);
   		      	if (Rs.next()==false) //6
            		{
                            qry="select to_char(RequestDate,'dd-Mon-YYYY') RequestDate from  UserRequest where InstituteCode='"+PublicDataFunction.InstituteCode+"' and eMail='" + mEMail + "'";
		             Rs = db.getRowset(qry);
                             if (Rs.next()==false) //7
                             {
                               qry="select to_char(RequestDate,'dd-Mon-YYYY') RequestDate from  UserRequest where InstituteCode='"+ PublicDataFunction.InstituteCode  +"' and UserCode='" + mUserCode + "'";
			        Rs = db.getRowset(qry);                		
                                if (Rs.next()==false) //8
				   {
                                          //----------- enter data in the table      
					mUserID=PublicDataFunction.getUserID(mUserCode,mUType);			
					mPPass1=owe.Encrypt(mPass1);										
					qry="Insert Into UserRequest (InstituteCode,UserID,UserCode,Password,UserType,eMail, REQUESTDATE,ACTIVATIONSTATUS) Values('"+ PublicDataFunction.InstituteCode +"','" + mUserID  + "','" + mUserCode + "','" + mPPass1 + "','" + mUType + "','" + mEMail + "',Sysdate,'N')";
 
					if (mUserID.trim()!="")  //9						   
					   {
                                            mFlag=db.insertRow(qry);														
					     if (mFlag>0) //10
                                             	{

								// ------------------------------------
								// comment it to stop direct insertion

								   qry=" insert into Oratemp8i (ORAT1,ORAT2,ORAT3,ORAT4,ORAT5,ORATSTATUS,ORATTYPE) ";
								   qry=qry+ "values('"+ PublicDataFunction.InstituteCode +"','" + mUserID  + "','" + mUserCode + "','" + mEMail + "','" + mPPass1 + "','Y','" + mUType  + "')";
						  		   mFlag=db.insertRow(qry);


								
								//-------------------------------------
						  out.print("<br><b><FONT COLOR=Black size=6>" + "Congratuation! User " + mUserCode + "</font></b>" );
                                      out.print("<br><Font Color=Black size=4>" + "Requested User Type: " + "<Font Color=Green>" + mUType  + "</font></font>");
						  out.print( "<br><Font Color=Black size=4>" + "Requested User Code: " +"<Font Color=Green>"+ mUserCode  + "</font></font>");
						  out.print( "<br><Font Color=black size=4>" + "Requested User eMail: "+ "<Font Color=Green>" + mEMail  + "</font></font>");
						  out.print( "<br><HR align=center color=black noShade style='BACKGROUND-POSITION-X: 10px; HEIGHT: 2px; VERTICAL-ALIGN: middle; WIDTH: 677px' DESIGNTIMESP=10697 scrollleft=10>");
						  out.print( "<br><Font Color=Black size=4>" + "Your Request has been acceped and your activation will be informed on given email ID" + "</font></font>");
                                             	} //10
					   else
                                           	{  //10-1
					     %>
						<IMG src="../images/Error1.jpg">
  						<FONT Color=red ></FONT><br>
                                                <FONT face=Arial>Error while registring </FONT></FONT>
					     <%                                           	
					     	out.print( "<br><Font Color=Red size=4><br>" + "Please contact to Registrar Office" + "</Font>");
                                           	}  //10-1
					   }//9					   
					else
                                        {   //9-1
					    %>
					    <FONT face=Arial>
					    <IMG src="../images/Error1.jpg"><FONT Color=red >    
                                            </FONT>
                                            <FONT face=Arial>Invalid MemberCode/Type! Error while registring</FONT></FONT>
					    <%
					    out.write("<br><Font Color=Red size=4><br>" + "Please contact to Registrar Office" + "</Font>");
                                        } //9-1
				   }//8
				else
                                { //8-1
				%>
					<FONT face=Arial>
					<IMG src="../images/Error1.jpg"><FONT Color=red ></FONT><br><FONT face=Arial>You request has already posted on " <%=Rs.getString(1)%></FONT></FONT>
				<%
				} //8-1
                             }//7
			else
                        { //7-1
			   %>
			   <FONT face=Arial>
			   <IMG src="../images/Error1.jpg"><FONT Color=red ></FONT><br><FONT face=Arial>Mail ID alreday in used and Request Date  <%=Rs.getString(1) %></FONT></FONT>
			   <%
			} //7-1
            		}//6
		else    
                { //6-1
			out.print("<Font Color=Red size=3><b><u>" + "Signup Status" + "</u></b></font><br>");
			out.print("<hr width=500>");
		    	out.print("<Font Color=Black size=3>" + "Requested User Type: " + "<Font Color=Green>" + mMUType  + "</font></font>");
			out.print("<br><Font Color=Black size=3>" + "Requested User Code: " + "<Font Color=Green>" + mUserCode  + "</font></font>");
			out.print("<br><Font Color=Black size=3>" + "Requested User eMail: " + "<Font Color=Green>" + mEMail  + "</font></font>");   
			out.print("<br><Font Color=Black size=3>" + "You are already a registered/activated User" + "</font>" );
                } //6-1
         		}//5
	else 
        { //5-1
       %>
       <FONT face=Arial>
       <IMG src="../images/Error1.jpg"><FONT Color=red >This mail ID is already in used</FONT></FONT><p>    
       <%
        }	//5-1	    
   }//4
  else    
  { //4-1
  %>
    <FONT face=Arial>
    <IMG src="../images/Error1.jpg"><FONT Color=red >Your both Password doesn't match</FONT></FONT><p>    
  <%
  } //4-1
}//3
 else  
 { //3-1
  %>
  <FONT face=Arial>
  <IMG src="../images/Error1.jpg"><FONT Color=red >Invalid Password: It must be Numeric and password size should be less than 10 only</FONT></FONT><p>  
  <%
 } //3-1
}//2
else    
{ //2-1
  %>
  <FONT face=Arial>
  <IMG src="../images/Error1.jpg"><FONT Color=red >Invalid Email ID!</FONT></FONT><p> 
  <%
} //2-1
}//1
else    
{ //1-1
%>
  <FONT face=Arial>
  <IMG src="../images/Error1.jpg"><FONT Color=red >Please Enter Your Member Code, Password and EMail</FONT></FONT>
<P>  
<%
} //1-1

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

</BODY>
</HTML>
