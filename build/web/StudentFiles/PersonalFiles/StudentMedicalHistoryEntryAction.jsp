<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
GlobalFunctions gb =new GlobalFunctions();
int mSno=0, TotInboxItem=0;
String qry="",qry1="";
String mColor="",mComp="",TRCOLOR="White",mWebEmail="";
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInst="",EmailID="";
String mFacultyName="",mFaculty="", mMsg="";
String QryFaculty="",mEID="",mENM="",mcolor="";
int m=0;

if (session.getAttribute("WebAdminEmail")==null)
{
	 mWebEmail="";
}	 
else
{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
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

if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}

String mTime="";
qry="Select to_char(Sysdate,'DD-Mon-yyyy HH:MI:SS PM') mTime from Dual";
rs=db.getRowset(qry);
if (rs.next())
	mTime=rs.getString("mTime");
else
	mTime="";

String mHead="";

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
  mHead=session.getAttribute("PageHeading").toString().trim();
else
  mHead="JIIT ";

%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Student Medical History ] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
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
</head>
<body aLink=#ff00ff bgcolor='#fce9c5' rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 onLoad="funOnLoad()">
<p align=center>
<font color=darkbrown size=3 face='verdana'><b><U>Medical Form</U></b></font>
</p>
<center>
<!--<marquee direction="right" height="150" scrollamount="5" behavior="scroll" style="font-family:Verdana;font-size:13px;text-decoration:none;color:#FFFFFF;background-color:transparent;" id="Marquee1"><img src="../../PhotoImages/1.jpg">&nbsp;&nbsp;<img src="../../PhotoImages/2.jpg">&nbsp;&nbsp;<img src="../../PhotoImages/3.jpg">&nbsp;&nbsp;<img src="../../PhotoImages/5.jpg">&nbsp;&nbsp;<img src="../../PhotoImages/6.jpg">&nbsp;&nbsp;<img src="../../PhotoImages/7.jpg">&nbsp;&nbsp;<img src="../../PhotoImages/8.jpg">&nbsp;&nbsp;<img src="../../PhotoImages/9.jpg"></marquee>
<marquee direction="righttoleft" height="25" width="102%" scrolldelay="50" scrollamount="5" behavior="scroll" loop="0" style="font-family:Verdana;font-size:25px;text-decoration:none;color:#FFFFFF;background-color:navy;" id="Marquee2"><STRONG>Site is Under Construction. Modules will open one by one after sometime.</STRONG></marquee>-->
<%
try
{
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{
		OLTEncryption enc=new OLTEncryption();
		mDMemberID=enc.decode(mMemberID);
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);

		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk=null;

		String mName="", mRoll="", mRoomNo="", mPrstC1="", mPrstC2="", mPrstC3="", mPrstC3a="", mPrstC3a1="";
		String mPastC1="", mPastC2="", mPastC3="", mPastC4="", mPastC5="", mPastC6="";
		String mMajorComp="", mDrugIntake="", mAnyOther="";

		String mAllergicToDrug="", mHOAddition="", mPsychiatricIllness="", mTypeOfPITreatment="", mHypertension="";
		String mDiabetesMellitus="", mBronchialAsthma="", mAllergicBronchites="", mConvulsioris="", mCongentialDiease="";
		String mAnyMajorOrAccidental="", mAnyDrugIntake="";

	  //-----------------------------
	  //-- Enable Security Page Level  
	  //-----------------------------
		qry="Select WEBKIOSK.ShowLink('247','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{
				if(request.getParameter("RoomNo")!=null)
					mRoomNo=request.getParameter("RoomNo").toString().trim();
				else
					mRoomNo="";
				
				if(request.getParameter("EmailID")!=null)
					EmailID=request.getParameter("EmailID").toString().trim();
				else
					EmailID="";

				if(request.getParameter("PrstC1")!=null)
					mPrstC1=request.getParameter("PrstC1").toString().trim();
				else
					mPrstC1="";
				if(request.getParameter("txtPrstC1")!=null)
					mAllergicToDrug=request.getParameter("txtPrstC1").toString().trim();
				else
					mAllergicToDrug="";
				if(request.getParameter("PrstC2")!=null)
					mPrstC2=request.getParameter("PrstC2").toString().trim();
				else
					mPrstC2="";
				if(request.getParameter("txtPrstC2")!=null)
					mHOAddition=request.getParameter("txtPrstC2").toString().trim();
				else
					mHOAddition="";
				if(request.getParameter("PrstC3")!=null)
					mPrstC3=request.getParameter("PrstC3").toString().trim();
				else
					mPrstC3="";
				if(request.getParameter("txtPrstC3")!=null)
					mPsychiatricIllness=request.getParameter("txtPrstC3").toString().trim();
				else
					mPsychiatricIllness="";
				if(request.getParameter("PrstC3a")!=null)
					mPrstC3a=request.getParameter("PrstC3a").toString().trim();
				else
					mPrstC3a="";
				if(request.getParameter("txtPrstC3a")!=null)
					mTypeOfPITreatment=request.getParameter("txtPrstC3a").toString().trim();
				else
					mTypeOfPITreatment="";
				if(request.getParameter("PrstC3a1")!=null)
					mPrstC3a1=request.getParameter("PrstC3a1").toString().trim();
				else
					mPrstC3a1="";
				if(request.getParameter("PastC1")!=null)
					mPastC1=request.getParameter("PastC1").toString().trim();
				else
					mPastC1="";
				if(request.getParameter("txtPastC1")!=null)
					mHypertension=request.getParameter("txtPastC1").toString().trim();
				else
					mHypertension="";
				if(request.getParameter("PastC2")!=null)
					mPastC2=request.getParameter("PastC2").toString().trim();
				else
					mPastC2="";
				if(request.getParameter("txtPastC2")!=null)
					mDiabetesMellitus=request.getParameter("txtPastC2").toString().trim();
				else
					mDiabetesMellitus="";
				if(request.getParameter("PastC3")!=null)
					mPastC3=request.getParameter("PastC3").toString().trim();
				else
					mPastC3="";
				if(request.getParameter("txtPastC3")!=null)
					mBronchialAsthma=request.getParameter("txtPastC3").toString().trim();
				else
					mBronchialAsthma="";
				if(request.getParameter("PastC4")!=null)
					mPastC4=request.getParameter("PastC4").toString().trim();
				else
					mPastC4="";
				if(request.getParameter("txtPastC4")!=null)
					mAllergicBronchites=request.getParameter("txtPastC4").toString().trim();
				else
					mAllergicBronchites="";
				if(request.getParameter("PastC5")!=null)
					mPastC5=request.getParameter("PastC5").toString().trim();
				else
					mPastC5="";
				if(request.getParameter("txtPastC5")!=null)
					mConvulsioris=request.getParameter("txtPastC5").toString().trim();
				else
					mConvulsioris="";
				if(request.getParameter("PastC6")!=null)
					mPastC6=request.getParameter("PastC6").toString().trim();
				else
					mPastC6="";
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
				//out.print(mRoomNo+" - "+mPrstC1+" - "+mPrstC2+" - "+mPrstC3+" - "+mPrstC3a+" - "+mPrstC3a1+" - "+mPastC1+" - "+mPastC2+" - "+mPastC3+" - "+mPastC4+" - "+mPastC5+" - "+mPastC6+" - "+mMajorComp+" - "+mDrugIntake+" - "+mAnyOther);		
				try
				{

	qry="SELECT 'y' FROM StudentPhone where studentid='"+mChkMemID+"'";  
		rs=db.getRowset(qry);
		if (!rs.next())
			{
				qry=" Insert into STUDENTPHONE (StudentID,STEMAILID)";
				qry=qry+" Values('"+mChkMemID+"','"+EmailID+"')";
				//out.print(qry);
				 m =db.insertRow(qry);
			
			}
		else
			{
				

				 qry="update STUDENTPHONE set STEMAILID='"+EmailID+"' where studentid='"+mChkMemID+"' ";
				//out.print(qry);
			m =db.update(qry);

			}


					int n=0;
					qry="SELECT 'Y' FROM STUDENTMEDICALHISTORY WHERE STUDENTID='"+mChkMemID+"'";
					//out.print(qry);
					rs=db.getRowset(qry);
					if(!rs.next())
					{
						qry="INSERT INTO STUDENTMEDICALHISTORY (STUDENTID, HOSTELROOMNO, PRS_HOALLERGICTODRUG, PRS_HOADDITION, PRS_HOPSYCHIATRICILLNESS, PRS_PI_ONTREATMENT, PRS_PI_TYPEOFTREATMENT, PST_HOHYPERTENSION, PST_HODIABETESMELLITUS, PST_HOBRINICALASTHAMA, PST_HOALLERGICBRONCHITES, PST_HOCONVULSIORISORFITS, PST_HOANYCONGENTIALDIEASES, HOANYMAJORSURGERYORACCIDENT, HOANYDRUGINTAKE, ANYOTHER, ENTRYBY, ENTRYDATE)";
						qry+="VALUES('"+mChkMemID+"','"+mRoomNo+"','"+mAllergicToDrug+"','"+mHOAddition+"','"+mPsychiatricIllness+"','"+mTypeOfPITreatment+"','"+mPrstC3a1+"','"+mHypertension+"','"+mDiabetesMellitus+"','"+mBronchialAsthma+"','"+mAllergicBronchites+"','"+mConvulsioris+"','"+mCongentialDiease+"','"+mAnyMajorOrAccidental+"','"+mAnyDrugIntake+"','"+mAnyOther+"','"+mChkMemID+"',SYSDATE)";
						n=db.insertRow(qry);
						if(n>0)
						{
							RequestDispatcher rd=request.getRequestDispatcher("StudentMedicalHistoryEntry.jsp");
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
						qry+="ENTRYBY='"+mChkMemID+"',";
						qry+="ENTRYDATE=SYSDATE WHERE STUDENTID='"+mChkMemID+"'";
						n=db.update(qry);
						if(n>0)
						{
							RequestDispatcher rd=request.getRequestDispatcher("StudentMedicalHistoryEntry.jsp");
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
			//---Enable Security Page Level  
			//-----------------------------
		}
		else
		{
		   %>
			</form>
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
		out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}  
  }
  catch(Exception e)
  {
  }

%>
<br>
<table align=center><tr><td align=left>
<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp"><br>
<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT> 		
</body>
</Html>