<%@ page errorPage="../CommonFiles/ExceptionHandler.jsp" %>  
<%  

/*
'**********************************************************************************************************
'* File Name:	MainFrame.JSP	[ For Employee ]
'* Author:		Mohit .sharma	*
'* Date:		2/15/2013       *
'* Version:		1.0				*	
'**********************************************************************************************************
 */
  String xABS="",xMED="",xUFM="",xDEB=""; 

 String xDEV="",xMEN="";
 String xSUB="",xEMP="";
 String mSUB="",mEMP="";
 String mTitle = "JIIT" ,mIAP="" ,mTOTS=""; 
 String mIF="",mID="",mIC="",mICP="",mIB="",mIBP="",mIA="";
 String mRF="",mRD="",mRC="",mRCP="",mRB="",mRBP="",mRA="",mRAP="";
 String sIB8="",sIB7="",sIB6="",sIB5="",sIB4="",sIB3="",sIB2="",sIB1="" ,xRB="" ,xPRE="";

if (session.getAttribute("MemberCode")!=null && session.getAttribute("MemberType")!=null)
{
if(request.getParameter("IAP")==null)
		mIAP="";
	else
		mIAP=request.getParameter("IAP").toString().trim();

if(request.getParameter("IA")==null)
		mIA="";
	else
		mIA=request.getParameter("IA").toString().trim();

if(request.getParameter("IBP")==null)
		mIBP="";
	else
		mIBP=request.getParameter("IBP").toString().trim();

if(request.getParameter("IB")==null)
		mIB="";
	else
		mIB=request.getParameter("IB").toString().trim();

if(request.getParameter("ICP")==null)
		mICP="";
	else
		mICP=request.getParameter("ICP").toString().trim();

if(request.getParameter("IC")==null)
		mIC="";
	else
		mIC=request.getParameter("IC").toString().trim();

if(request.getParameter("ID")==null)
		mID="";
	else
		mID=request.getParameter("ID").toString().trim();

if(request.getParameter("IF")==null)
		mIF="";
	else
		mIF=request.getParameter("IF").toString().trim();

//initial boundary


if(request.getParameter("IB1")==null)
		sIB1="";
	else
		sIB1=request.getParameter("IB1").toString().trim();

if(request.getParameter("IB2")==null)
		sIB2="";
	else
		sIB2=request.getParameter("IB2").toString().trim();

if(request.getParameter("IB3")==null)
		sIB3="";
	else
		sIB3=request.getParameter("IB3").toString().trim();

if(request.getParameter("IB4")==null)
		sIB4="";
	else
		sIB4=request.getParameter("IB4").toString().trim();

if(request.getParameter("IB5")==null)
		sIB5="";
	else
		sIB5=request.getParameter("IB5").toString().trim();

if(request.getParameter("IB6")==null)
		sIB6="";
	else
		sIB6=request.getParameter("IB6").toString().trim();

if(request.getParameter("IB7")==null)
		sIB7="";
	else
		sIB7=request.getParameter("IB7").toString().trim();

if(request.getParameter("IB8")==null)
		sIB8="";
	else
		sIB8=request.getParameter("IB8").toString().trim();


if(request.getParameter("RRB")==null)
		xRB="";
	else
		xRB=request.getParameter("RRB").toString().trim();


if(request.getParameter("DEV")==null)
		xDEV="";
	else
		xDEV=request.getParameter("DEV").toString().trim();

if(request.getParameter("MEN")==null)
		xMEN="";
	else
		xMEN=request.getParameter("MEN").toString().trim();

 
  
//System.out.println("##########"+xDEV+"@@@@@@@@@"+xMEN);

session.setAttribute("DEV",xDEV);
session.setAttribute("MEN",xMEN);
session.setAttribute("IAP",mIAP);
session.setAttribute("IA",mIA);
session.setAttribute("IBP",mIBP);
session.setAttribute("IB",mIB);
session.setAttribute("ICP",mICP);
session.setAttribute("IC",mIC);
session.setAttribute("ID",mID);
session.setAttribute("IF",mIF);
session.setAttribute("IB8",sIB8);
session.setAttribute("IB7",sIB7);
session.setAttribute("IB6",sIB6);
session.setAttribute("IB5",sIB5);
session.setAttribute("IB4",sIB4);
session.setAttribute("IB3",sIB3);
session.setAttribute("IB2",sIB2);
session.setAttribute("IB1",sIB1);
session.setAttribute("RRB",xRB);

//System.out.println(xRB);
//-----Revised Bpundary

if(request.getParameter("RAP")==null)
		mRAP="";
	else
		mRAP=request.getParameter("RAP").toString().trim();


if(request.getParameter("RA")==null)
		mRA="";
	else
		mRA=request.getParameter("RA").toString().trim();

if(request.getParameter("RBP")==null)
		mRBP="";
	else
		mRBP=request.getParameter("RBP").toString().trim();

if(request.getParameter("RB")==null)
		mRB="";
	else
		mRB=request.getParameter("RB").toString().trim();

if(request.getParameter("RCP")==null)
		mRCP="";
	else
		mRCP=request.getParameter("RCP").toString().trim();

if(request.getParameter("RC")==null)
		mRC="";
	else
		mRC=request.getParameter("RC").toString().trim();

if(request.getParameter("RD")==null)
		mRD="";
	else
		mRD=request.getParameter("RD").toString().trim();

if(request.getParameter("RF")==null)
		mRF="";
	else
		mRF=request.getParameter("RF").toString().trim();


if(request.getParameter("TOTS")==null)
		mTOTS="";
	else
		mTOTS=request.getParameter("TOTS").toString().trim();

if(request.getParameter("PRE")==null)
		xPRE="";
	else
		xPRE=request.getParameter("PRE").toString().trim();


 
if(request.getParameter("ABS")==null)
		xABS="";
	else
		xABS=request.getParameter("ABS").toString().trim();
	if(request.getParameter("MED")==null)
		xMED="";
	else
		xMED=request.getParameter("MED").toString().trim();
	if(request.getParameter("UFM")==null)
		xUFM="";
	else
		xUFM=request.getParameter("UFM").toString().trim();
	if(request.getParameter("DEB")==null)
		xDEB="";
	else
		xDEB=request.getParameter("DEB").toString().trim();


if(request.getParameter("SUB")==null)
		xSUB="";
	else
		xSUB=request.getParameter("SUB").toString().trim();
	if(request.getParameter("EMP")==null)
		xEMP="";
	else
		xEMP=request.getParameter("EMP").toString().trim();


session.setAttribute("SUB",xSUB);
session.setAttribute("EMP",xEMP);  
	  
session.setAttribute("ABS",xABS);
session.setAttribute("MED",xMED);
session.setAttribute("UFM",xUFM);
session.setAttribute("DEB",xDEB);



session.setAttribute("PRE",xPRE);
session.setAttribute("TOTS",mTOTS);
session.setAttribute("RAP",mRAP);
session.setAttribute("RA",mRA);
session.setAttribute("RBP",mRBP);
session.setAttribute("RB",mRB);
session.setAttribute("RCP",mRCP);
session.setAttribute("RC",mRC);
session.setAttribute("RD",mRD);
session.setAttribute("RF",mRF);
// System.out.println("TESTINGNNGNGNGNGN"+xABS+""+xDEB);
%>
<html>
<HEAD>
</HEAD>
<frameset border=0 Rows = "8%,92%" FrameBorder=0>
<frame  noresize  scrolling=no border=0 src = "print.jsp"/>

<frameset border=0 cols = "25%,25%" >
<frame     border=0 src ="initial.jsp"/ >
<frame     border=0   src ="revised.jsp"  />
</frameset>
</frameset>
</html>
<%

}
else
{
%>
<br>
Session timeout! Please <a href="../index.jsp">Login</a> to continue...
<%
}
%>


 