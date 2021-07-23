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
String mInst="";
String mFacultyName="",mFaculty="", mMsg="";
String QryFaculty="",mEID="",mENM="",mcolor="";

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
<body aLink=#ff00ff bgcolor='#fce9c5' rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<p align=center>
<font color=darkbrown size=3 face='verdana'><b><U>Hostel Detail Provisional</U></b></font>
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

	  //-----------------------------
	  //-- Enable Security Page Level  
	  //-----------------------------
		qry="Select WEBKIOSK.ShowLink('273','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{
			%>
			<form name=frm id=frm>
			<input id="x" name="x" type=hidden>
			<table align=center cellpadding=0 width=70%>
			<%
			qry="Select A.StudentName SName, A.EnrollmentNo EnrollNo, nvl(B.PROVISIONALHOSTELCODE,' ') HOSTEL,nvl(B.PROVISIONALROOMNO,' ') RoomNo,nvl(B.PROVISIONALROOMTYPE,' ') RoomType,	 NVL(B.PRS_HOALLERGICTODRUG,'No')PRS_HOALLERGICTODRUG,";
			qry+=" NVL(B.PRS_HOADDITION,'No')PRS_HOADDITION, NVL(B.PRS_HOPSYCHIATRICILLNESS,'No')PRS_HOPSYCHIATRICILLNESS,";
			qry+=" NVL(B.PRS_PI_ONTREATMENT,'No')PRS_PI_ONTREATMENT, nvl(B.PRS_PI_TYPEOFTREATMENT,'No')PRS_PI_TYPEOFTREATMENT, NVL(B.PST_HOHYPERTENSION,'No')PST_HOHYPERTENSION,";
			qry+=" NVL(B.PST_HODIABETESMELLITUS,'No')PST_HODIABETESMELLITUS, NVL(B.PST_HOBRINICALASTHAMA,'No')PST_HOBRINICALASTHAMA,";
			qry+=" NVL(B.PST_HOALLERGICBRONCHITES,'No')PST_HOALLERGICBRONCHITES, NVL(B.PST_HOCONVULSIORISORFITS,'No')PST_HOCONVULSIORISORFITS,";
			qry+=" NVL(B.PST_HOANYCONGENTIALDIEASES,'No')PST_HOANYCONGENTIALDIEASES, NVL(B.HOANYMAJORSURGERYORACCIDENT,'No')HOANYMAJORSURGERYORACCIDENT,";
			qry+=" NVL(B.HOANYDRUGINTAKE,'No')HOANYDRUGINTAKE, NVL(B.ANYOTHER,'No')ANYOTHER";
			qry+=" from StudentMaster A, StudentMedicalHistory B Where A.STUDENTID=B.STUDENTID AND B.studentid='"+mChkMemID+"'";
		//	out.print(qry);
			rs=db.getRowset(qry);
			if(rs.next())
			{
			%>
			<tr>
			<td align=left><Font color=navy face=arial size=3><b>Name : </b></font></td>
			<td><Font color=navy face=arial size=3><%=rs.getString("SName")%></Font></td>
			</tr>

			<tr>
			<td align=left><Font color=navy face=arial size=3><b>Roll No : </b></font></td>
			<td><Font color=navy face=arial size=3><%=rs.getString("EnrollNo")%></Font></td>
			</tr>


			<tr>
			<td align=left><Font color=navy face=arial size=3><b>Hostel : </b></font></td>
			<td><Font color=navy face=arial size=3><%=rs.getString("HOSTEL")%></Font></td>
			<tr>

			<td align=left><Font color=navy face=arial size=3><b>RoomNo : </b></font></td>
			<td><Font color=navy face=arial size=3><%=rs.getString("RoomNo")%></Font></td>
			<tr>
			<tr>

			<td align=left><Font color=navy face=arial size=3><b>RoomType : </b></font></td>
			<td><Font color=navy face=arial size=3><%=rs.getString("RoomType")%></Font></td>
			<tr>
			<tr>
            </tr>
			<td align=left><Font color=red face=arial size=3><b>*The above hostel detail 
			are provisional subject to the hostel fee deposition through Registrar's
			office</b></font></td>
			<tr>
            </tr>
				<td align=left><Font color=red face=arial size=3><b>*In Case of any query,
			email at juithostel@gmail.com 
			</b></font></td>

			<!--<td align=right><b><a href="StudentMedicalHistoryEntry.jsp" title="click to edit submitted medical history"><font color=blue size=3 face=verdana>Fill/Edit Medical History</font></a></b></td>-->
			</tr> 
			</table>

			<!--<table align=center width=90% cellpadding=1 border=1 cellspacing=0>
			<tr>
			<td colspan=2><Font color=black face=arial size=3><b><U>Present Complaint </U></b></font></td>
			</tr>

			<tr>
			<td><Font color=black face=arial size=2><b>&nbsp; Any History of Allergic to Drug : </b></font></td>
			<td><Font color=navy face=arial size=3><%=rs.getString("PRS_HOALLERGICTODRUG")%></Font></td>
			</tr>

			<tr>
			<td><Font color=black face=arial size=2><b>&nbsp; History of Addition : </b></font></td>
			<td><Font color=navy face=arial size=3><%=rs.getString("PRS_HOADDITION")%></Font></td>
			</tr>

			<tr>
			<td valign=top><Font color=black face=arial size=2><b>&nbsp; Psychiatric illness : </b></font></td>
			<td><Font color=navy face=arial size=3><%=rs.getString("PRS_HOPSYCHIATRICILLNESS")%></Font>
			<BR>
			<%
			if(!rs.getString("PRS_PI_ONTREATMENT").equals("No"))
			{
				%>
				<Font color=black face=arial size=2><b>On Treatment? :</b></font> &nbsp; <Font color=navy face=arial size=3><%=rs.getString("PRS_PI_ONTREATMENT")%></Font> (<Font color=navy face=arial size=3><%=rs.getString("PRS_PI_TYPEOFTREATMENT")%></Font>)
				<%
			}
			else
			{
				%>
				<Font color=black face=arial size=2><b>On Treatment? :</b></font> &nbsp; <Font color=navy face=arial size=3><%=rs.getString("PRS_PI_ONTREATMENT")%></Font>
				<%
			}
			%>
			</td>
			</tr>

			<tr>
			<td colspan=2><Font color=black face=arial size=3><b><U>Past History </U></b></font></td>
			</tr>

			<tr>
			<td><Font color=black face=arial size=2><b>&nbsp; Hypertension : </b></font></td>
			<td><Font color=navy face=arial size=3><%=rs.getString("PST_HOHYPERTENSION")%></Font></td>
			</tr>

			<tr>
			<td><Font color=black face=arial size=2><b>&nbsp; Diabetes Mellitus : </b></font></td>
			<td><Font color=navy face=arial size=3><%=rs.getString("PST_HODIABETESMELLITUS")%></Font></td>
			</tr>

			<tr>
			<td><Font color=black face=arial size=2><b>&nbsp; Bronchial Asthma : </b></font></td>
			<td><Font color=navy face=arial size=3><%=rs.getString("PST_HOBRINICALASTHAMA")%></Font></td>
			</tr>

			<tr>
			<td><Font color=black face=arial size=2><b>&nbsp; Allergic Bronchites : </b></font></td>
			<td><Font color=navy face=arial size=3><%=rs.getString("PST_HOALLERGICBRONCHITES")%></Font></td>
			</tr>

			<tr>
			<td><Font color=black face=arial size=2><b>&nbsp; Convulsioris or Fits : </b></font></td>
			<td><Font color=navy face=arial size=3><%=rs.getString("PST_HOCONVULSIORISORFITS")%></Font></td>
			</tr>

			<tr>
			<td><Font color=black face=arial size=2><b>&nbsp; Any Congential Dieases : </b></font></td>
			<td><Font color=navy face=arial size=3><%=rs.getString("PST_HOANYCONGENTIALDIEASES")%></Font></td>
			</tr>

			<tr>
			<td><BR><Font color=black face=arial size=2><b>History of any major Surgery or Accident<BR>(in which there was loss of consciousness) : </b></font></td>
			<td><Font color=navy face=arial size=3><%=rs.getString("HOANYMAJORSURGERYORACCIDENT")%></Font></td>
			</tr>

			<tr>
			<td><BR><Font color=black face=arial size=2><b>History of any Drug Intake : </b></font></td>
			<td><Font color=navy face=arial size=3><%=rs.getString("HOANYDRUGINTAKE")%></Font></td>
			</tr>

			<tr>
			<td colspan=2><BR><Font color=black face=arial size=2><b>Other History (If Any) : </b></font>
			&nbsp; <Font color=navy face=arial size=3><%=rs.getString("ANYOTHER")%></Font></td>
			</tr>
			</table>-->
			</form>
			<%
			}
			else
			{
				%><!--<CENTER><Font color=red face=verdana size=4><br><img src='../../Images/Error1.jpg'> Your Medical Form yet not filled up! Click to <b><a href="StudentMedicalHistoryEntry.jsp" title="click to edit submitted medical history"><font color=blue>Fill/Edit Medical History</font></a></b></Font></CENTER>--><%
			}
			//-----------------------------
			//---Enable Security Page Level  
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
<IMG  src="../../Images/CampusLynx.png">
</td>
<td >
<FONT size =4 style="FONT-FAMILY: ARIal"><b>Campus Lynx</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>
</body>
</Html>
