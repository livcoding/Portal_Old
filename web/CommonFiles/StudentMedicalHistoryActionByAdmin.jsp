<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
 <% 
/*	' **********************************************************************************************************
	' *													   *
	' * File Name:	StudentMedicalHistoryByAdmin.jsp		[For Students]						           *
	' * Author:		Vijay Kumar							           *
	' * Date:		14th JUL 2009						   *
	' * Version:	1.0							   *
	' * Description:	Student Medical History
	' **********************************************************************************************************
*/
%>
<html>
<head>
<TITLE>#### <%=mHead%> [ View/Edit Student Medical History] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<style fprolloverstyle>A:hover {color: #FF0000; font-size: 14pt; font-weight: bold}
</style>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<% 
String dd1="";
String qry="";
String mMemberID="";
String mMemberType="", mInst="";
String mMemberCode="", mMemberName="", mDMemberCode="", mSID="";
ResultSet rs=null,rs1=null;
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();

if (request.getParameter("SID")==null)
{
	mSID="";
}
else
{
	mSID=request.getParameter("SID").toString().trim();
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

if (session.getAttribute("MemberName")==null)
{
	mMemberName="";
}
else
{
	mMemberName=session.getAttribute("MemberName").toString().trim();
}

if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
}
if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}

if(!mMemberID.equals("") && !mMemberType.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
{  //2

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mMacAddress =" "; //session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
	  //-----------------------------
	  //-- Enable Security Page Level  
	  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('248','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
		String mName="", mRoll="", mPrstC1="", mPrstC2="", mPrstC3="", mPrstC3a="", mPrstC3a1="";
		String mPastC1="", mPastC2="", mPastC3="", mPastC4="", mPastC5="", mPastC6="";
		String mMajorComp="", mDrugIntake="";

		String mRoomNo="", mAllergicToDrug="", mHOAddition="", mPsychiatricIllness="", mTypeOfPITreatment="", mHypertension="";
		String mDiabetesMellitus="", mBronchialAsthma="", mAllergicBronchites="", mConvulsioris="", mCongentialDiease="";
		String mAnyMajorOrAccidental="", mAnyDrugIntake="", mAnyOther="";

				if(request.getParameter("RoomNo")!=null)
					mRoomNo=request.getParameter("RoomNo").toString().trim();
				else
					mRoomNo="";
				if(request.getParameter("txtPrstC1")!=null)
					mAllergicToDrug=request.getParameter("txtPrstC1").toString().trim();
				else
					mAllergicToDrug="";
				if(request.getParameter("txtPrstC2")!=null)
					mHOAddition=request.getParameter("txtPrstC2").toString().trim();
				else
					mHOAddition="";
				if(request.getParameter("txtPrstC3")!=null)
					mPsychiatricIllness=request.getParameter("txtPrstC3").toString().trim();
				else
					mPsychiatricIllness="";
				if(request.getParameter("txtPrstC3a")!=null)
					mTypeOfPITreatment=request.getParameter("txtPrstC3a").toString().trim();
				else
					mTypeOfPITreatment="";
				if(request.getParameter("PrstC3a1")!=null)
					mPrstC3a1=request.getParameter("PrstC3a1").toString().trim();
				else
					mPrstC3a1="";
				if(request.getParameter("txtPastC1")!=null)
					mHypertension=request.getParameter("txtPastC1").toString().trim();
				else
					mHypertension="";
				if(request.getParameter("txtPastC2")!=null)
					mDiabetesMellitus=request.getParameter("txtPastC2").toString().trim();
				else
					mDiabetesMellitus="";
				if(request.getParameter("txtPastC3")!=null)
					mBronchialAsthma=request.getParameter("txtPastC3").toString().trim();
				else
					mBronchialAsthma="";
				if(request.getParameter("txtPastC4")!=null)
					mAllergicBronchites=request.getParameter("txtPastC4").toString().trim();
				else
					mAllergicBronchites="";
				if(request.getParameter("txtPastC5")!=null)
					mConvulsioris=request.getParameter("txtPastC5").toString().trim();
				else
					mConvulsioris="";
				if(request.getParameter("txtPastC6")!=null)
					mCongentialDiease=request.getParameter("txtPastC6").toString().trim();
				else
					mCongentialDiease="";
				if(request.getParameter("MajorComp")!=null)
					mMajorComp=request.getParameter("MajorComp").toString().trim();
				else
					mMajorComp="";
				if(request.getParameter("txtMajorComp")!=null)
					mAnyMajorOrAccidental=request.getParameter("txtMajorComp").toString().trim();
				else
					mAnyMajorOrAccidental="";
				if(request.getParameter("txtDrugIntake")!=null)
					mAnyDrugIntake=request.getParameter("txtDrugIntake").toString().trim();
				else
					mAnyDrugIntake="";
				if(request.getParameter("AnyOther")!=null)
					mAnyOther=request.getParameter("AnyOther").toString().trim();
				else
					mAnyOther="";
				try
				{
					int n=0;
					qry="SELECT 'Y' FROM STUDENTMEDICALHISTORY WHERE STUDENTID='"+mSID+"'";
					//out.print(qry);
					rs=db.getRowset(qry);
					if(!rs.next())
					{
						qry="INSERT INTO STUDENTMEDICALHISTORY (STUDENTID, HOSTELROOMNO, PRS_HOALLERGICTODRUG, PRS_HOADDITION, PRS_HOPSYCHIATRICILLNESS, PRS_PI_ONTREATMENT, PRS_PI_TYPEOFTREATMENT, PST_HOHYPERTENSION, PST_HODIABETESMELLITUS, PST_HOBRINICALASTHAMA, PST_HOALLERGICBRONCHITES, PST_HOCONVULSIORISORFITS, PST_HOANYCONGENTIALDIEASES, HOANYMAJORSURGERYORACCIDENT, HOANYDRUGINTAKE, ANYOTHER, ENTRYBY, ENTRYDATE)";
						qry+="VALUES('"+mSID+"','"+mRoomNo+"','"+mAllergicToDrug+"','"+mHOAddition+"','"+mPsychiatricIllness+"','"+mTypeOfPITreatment+"','"+mPrstC3a1+"','"+mHypertension+"','"+mDiabetesMellitus+"','"+mBronchialAsthma+"','"+mAllergicBronchites+"','"+mConvulsioris+"','"+mCongentialDiease+"','"+mAnyMajorOrAccidental+"','"+mAnyDrugIntake+"','"+mAnyOther+"','"+mSID+"',SYSDATE)";
						n=db.insertRow(qry);
						if(n>0)
						{
							RequestDispatcher rd=request.getRequestDispatcher("StudentMedicalHistoryByAdmin.jsp");
							request.setAttribute("message","Msg1");
							rd.forward(request,response);

							//out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='green'>Your Medical Form is submitted successfully...</font> <br>");
						}
					}
					else
					{
						qry="UPDATE STUDENTMEDICALHISTORY ";
						qry+="SET HOSTELROOMNO='"+mRoomNo+"',";
						qry+="PRS_HOALLERGICTODRUG='"+mAllergicToDrug+"',";
						qry+="PRS_HOADDITION='"+mHOAddition+"',";
						qry+="PRS_HOPSYCHIATRICILLNESS='"+mPsychiatricIllness+"',";
						qry+="PRS_PI_ONTREATMENT='"+mTypeOfPITreatment+"',";
						qry+="PRS_PI_TYPEOFTREATMENT='"+mPrstC3a1+"',";
						qry+="PST_HOHYPERTENSION='"+mHypertension+"',";
						qry+="PST_HODIABETESMELLITUS='"+mDiabetesMellitus+"',";
						qry+="PST_HOBRINICALASTHAMA='"+mBronchialAsthma+"',";
						qry+="PST_HOALLERGICBRONCHITES='"+mAllergicBronchites+"',";
						qry+="PST_HOCONVULSIORISORFITS='"+mConvulsioris+"',";
						qry+="PST_HOANYCONGENTIALDIEASES='"+mCongentialDiease+"',";
						qry+="HOANYMAJORSURGERYORACCIDENT='"+mAnyMajorOrAccidental+"',";
						qry+="HOANYDRUGINTAKE='"+mAnyDrugIntake+"',";
						qry+="ANYOTHER='"+mAnyOther+"',";
						qry+="ENTRYBY='"+mSID+"',";
						qry+="ENTRYDATE=SYSDATE WHERE STUDENTID='"+mSID+"'";
						//out.print(qry);
						n=db.update(qry);
						if(n>0)
						{
							RequestDispatcher rd=request.getRequestDispatcher("StudentMedicalHistoryByAdmin.jsp");
							request.setAttribute("message","Msg2");
							rd.forward(request,response);

							//out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='green'>Your Medical Form is updated successfully...</font> <br>");
						}
					}
				}
				catch(Exception e)
				{
					//out.print(e);
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
}   //2
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
%>
</body>
</Html>