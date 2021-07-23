<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>

<html>
<head>
   

<%
        String StudentName = "", EnrollmentNo = "", qry = "";
        ResultSet rs = null, rs1 = null;
        DBHandler db = new DBHandler();
        String mStudID = "", mInst = "";

        String mBRANCHCODE = "", mcaddress1 = "", mcaddress2 = "", mcaddress3 = "", mcDistrict = "", mcPIN = "", mcCity = "";
        String mcState = "", mpaddress1 = "", mpaddress2 = "", mpaddress3 = "", mpDistrict = "", mpPIN = "", mpCity = "";
        String mpState = "", mENROLLMENTNO = "", mFATHERNAME = "";

        String mStudentTel = "", DOB = "", mGender = "";

        String mSCellNo = "", mPCellNo = "", mSTelNo = "", mPTelNo = "", mSEmail = "", mPEmail = "", qry1 = "";
        ResultSet rs2 = null;

String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="",mtime1="",mtime2="";
String mMemberName="",mComp="";



        if (request.getParameter("EnrollmentNo") == null) {
            EnrollmentNo = "";
        } else {
            EnrollmentNo = request.getParameter("EnrollmentNo");
        }


if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}



if (session.getAttribute("MemberID")==null)
{
	mMemberID="";
}
else
{
	mMemberID=session.getAttribute("MemberID").toString().trim();
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

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead=" ";



try
{
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{	OLTEncryption enc=new OLTEncryption();
		mDMemberID=enc.decode(mMemberID);
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);

		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('260','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
 	RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{


%>
 <TITLE>#### <%=mHead%>  </TITLE>
    <link type="text/css" rel="StyleSheet" href="css/style.css" />
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

     <SCRIPT LANGUAGE="JavaScript">
        function openNewWindow1(studid)
        {
            var newWindow;
            newWindow=window.open('ComplainDetail.jsp?StudentID="+studid+"','_NEW','height=600,width=800,minimize=no,status=yes,toolbar=no,menubar=no,location=no,scrollbars=no');
            newWindow.moveTo(132,50);
        }

       function  radioAlle()
       {
           //alert(document.frm1.Allergies.value+"sdaa");

           if(document.frm1.Allergies.value=="Y")
               {
             //      alert(document.frm1.Alleg.disabled+"LLLL");
                   document.frm1.Alleg.disabled=false;
                document.frm1.AlleDetail.disabled=false;
               }

       }
        </SCRIPT>

</head>
<BODY vLink=#00000b link=#00000b bgcolor="#fce9c5" leftMargin=1 topMargin=0 marginheight="0" marginwidth="0" >
<link  rel="stylesheet" type="text/css" href="css/style.css">
<div id="header">
<table width="100%" align=center border=0 cellpadding=0 cellspacing=0>
<tr><td align=center>
        <h1>Student Medical History</h1>

</td></tr>

<tr><td align=center >
    <font size=2 color="#fce9c5">Please note,  fields marked with an asterisk</B> (<FONT SIZE="2" COLOR="Red" ><b>*</FONT>) are mandatory
</td></tr>

</table>

</div>


<form name="frm" method=post >
<input type="hidden" name="x" id="x">
<br>
<table border=1  rules=none align=center   topmargin=0 cellspacing=0 cellpadding=2 borderColor="#D98242" >
<tr>

    <td class="labelcell">
        Institute
           <select name=InstCode tabindex="1" id="InstCode" style="WIDTH: 80px">
               	<OPTION selected Value ='N'>--Select--</option>
        <%
        try {
            qry = "Select Distinct NVL(INSTITUTECODE,' ')InstCode,instituteid from" +
                    " institutemaster Where  " +
                    " nvl(Deactive,'N')='N' order by instituteid";
            rs = db.getRowset(qry);
            if (request.getParameter("x") == null) {
     
                while (rs.next()) {
                    mInst = rs.getString("InstCode");
            %>
            <OPTION  Value ="<%=mInst%>"><%=mInst%></option>
            <%
                }
            
            } else {
        
                while (rs.next()) {
                    mInst = rs.getString("InstCode");
                    if (mInst.equals(request.getParameter("InstCode").toString().trim())) {
            %>
            <OPTION selected Value ="<%=mInst%>"><%=mInst%></option>
            <%
                } else {
            %>
            <OPTION Value ="<%=mInst%>"><%=mInst%></option>
            <%
                    }
                }
            %>
        </select>
        <%
            }
        } catch (Exception e) {
            //out.println(e.getMessage());
        }%>

    </td>


    <td class="labelcell" >&nbsp;
        Enrollment No.

        <input type="text" id="EnrollmentNo" name="EnrollmentNo"  value="<%=EnrollmentNo%>" maxlength="20"/>
    </td>
    <!--<td class="labelcell" >&nbsp;
Name <font color=red><b><input type="radio" name="Check1"  id="Check1" />
    <input type="text" id="StudentName" name="StudentName" /></td>-->
</tr>
<tr><td align="center" colspan="4">
    <input type=Submit  border= "3px" name="submit" id="submit" value="&nbsp; OK &nbsp;" onClick="return Validate();" ></td>
</td></tr>
</table>
</form>


<br>
<%
//out.print("sd"+request.getParameter("x"));
        if (request.getParameter("x") != null) {
            if (request.getParameter("EnrollmentNo") == null) {
                EnrollmentNo = "";
            } else {
                EnrollmentNo = request.getParameter("EnrollmentNo");
            }

            if (request.getParameter("InstCode") == null) {
                mInst = "";
            } else {
                mInst = request.getParameter("InstCode");
            }


            qry = "select studentid  from studentmaster where Enrollmentno='" + EnrollmentNo + "' and InstituteCode='" + mInst + "'" +
                    " and nvl(deactive,'N')='N' ";
//out.print(qry);
            rs1 = db.getRowset(qry);
            if (rs1.next()) {
                mStudID = rs1.getString("studentid");

                qry = " Select nvl(fathername,' ') fathername,nvl(ENROLLMENTNO, ' ') ENROLLMENTNO, ";
                qry = qry + " nvl(PROGRAMCODE,' ') PROGRAMCODE,nvl(BRANCHCODE,' ') BRANCHCODE, ";
                qry = qry + " nvl(SEMESTER,0) SEMESTER,nvl(caddress1,' ') caddress1,nvl(caddress2,' ') caddress2, ";
                qry = qry + " nvl(caddress3,' ') caddress3,nvl(cdistrict,' ') cdistrict,nvl(ccity,' ') ccity, ";
                qry = qry + " nvl(to_char(cpin),' ') cpin,nvl(cstate,' ') cstate,nvl(paddress1,' ') paddress1, ";
                qry = qry + " nvl(paddress2,' ') paddress2,nvl(paddress3,' ') paddress3,nvl(pdistrict,' ') pdistrict, ";
                qry = qry + " nvl(pcity,' ') pcity,nvl(to_char(ppin),' ') ppin,nvl(pstate,' ') pstate , ";
                qry = qry + " nvl(studentname,' ') studentname,";
                qry = qry + " NVL (CPHONENO, ' ') PHONENUMBER ,to_char(DATEOFBIRTH,'dd-mm-yyyy')DOB," +
                        "decode(sex,'M','Male','F','Female')sex from ";
                qry = qry + " StudentMaster a , studentaddress b where ";
                qry = qry + " a.StudentID='" + mStudID + "'" + " and  ";
                qry = qry + " a.studentid = b.studentid (+) and InstituteCode='" + mInst + "' ";
                //out.print(qry);
                rs = db.getRowset(qry);
                if (rs.next()) {

                    mFATHERNAME = rs.getString("fathername");
                    mStudentTel = rs.getString("PHONENUMBER");
                    DOB = rs.getString("DOB");
                    mGender = rs.getString("sex");


                    mcaddress1 = rs.getString("caddress1");
                    mcaddress2 = rs.getString("caddress2");
                    mcaddress3 = rs.getString("caddress3");
                    mcDistrict = rs.getString("cdistrict");
                    mcPIN = rs.getString("cpin");
                    mcCity = rs.getString("ccity");
                    mcState = rs.getString("cstate");
                    mpaddress1 = rs.getString("paddress1");

                    mpaddress2 = rs.getString("paddress2");
                    mpaddress3 = rs.getString("paddress3");

                    mpDistrict = rs.getString("pdistrict");

                    mpCity = rs.getString("pcity");

                    mpPIN = rs.getString("ppin");

                    mpState = rs.getString("pstate");



                }


                qry1 = "select nvl(StStdCode,' ')||'-'||nvl(StTelNo,' ') sTel,nvl(StCellNo,' ') SCell," +
                        "nvl(StEmailid,' ') sEmail,nvl(PaStdCode,' ')||'-'||nvl(PaTelNo,' ') pTel," +
                        "nvl(PaCellNo,'') pCell,nvl(PaEmailid,'') pEmail from Studentphone where STUDENTID='" + mStudID + "'";
//out.println("Second qry is = " + qry);

                rs2 = db.getRowset(qry1);
                if (rs2.next()) {

                    mSCellNo = rs2.getString("SCell");


                    mPCellNo = rs2.getString("pCell");


                    mSTelNo = rs2.getString("sTel");
//out.println("mSTelNo jjjjjjjjjj= " + mSTelNo);

                    mPTelNo = rs2.getString("pTel");

                    mSEmail = rs2.getString("sEmail");


                    mPEmail = rs2.getString("pEmail");

                }

%>
<form name="frm1" >
<input type="hidden" name="x" id="x">
<input type="hidden" name="StudentID" id="StudentID" value="<%=mStudID%>">


<input type="hidden" name="InstCode" id="InstCode" value="<%=mInst%>">
<input type="hidden" name="EnrollmentNo" id="EnrollmentNo" value="<%=EnrollmentNo%>">
<table  border=1  rules=none align=center   topmargin=0 cellspacing=0 cellpadding=1
        borderColor="#D98242" >
    <tr>
        <td class="labelcell" >
        Father's Name <font color=red><b>*&nbsp;</b></font>
        <td><input  type=text name="FathersName" id="FathersName" size="40" readonly value="<%=mFATHERNAME%>" >

        </td>
        <td class="labelcell" >
        Gender </td><td>
            <input type="text" readonly value="<%=mGender%>" size="10"  name="Gender" >

        </td>
        <td class="labelcell" >Mobile No.
        </td>
        <td>
            <input type="text" id="MobileNo" value="<%=mSCellNo%>"  size="10">
        </td>
    </tr>

    <tr>
        <td class="labelcell" >
            Blood Group <font color=red ><b>*</b></font>
        </td>
        <td>
            <input type="text" id="BloodG" size="2"  >
        </td>
        <td class="labelcell" >
            E-Mail
        </td>
        <td>
            <input type="text" id="Email" name="Email" value="<%=mSEmail%>" readonly size="40">
        </td>
        <td class="labelcell" >
            Date of Birth
        </td>
        <td>
            <input type="text" name="DOB" value="<%=DOB%>"  readonly size="10">
        </td>
    </tr>

    <tr><td class="labelcell" nowrap >
            Local Address
        </td>
        <td>
            <textarea id="" rows="" cols="32" readonly>
    <%=mcaddress1%>&nbsp;<%=mcaddress2%>&nbsp;<%=mcaddress3%>
&nbsp;<%=mcCity%> &nbsp;<%=mcState%> &nbsp;<%=mcDistrict%>
            </textarea>
        </td>
        <td class="labelcell" nowrap >
            Permanent Address
        </td>
        <td colspan="3">
            <textarea id="" rows="" cols="30" readonly>  <%=mpaddress1%>&nbsp;<%=mpaddress2%>&nbsp;<%=mpaddress3%>
            &nbsp;<%=mpCity%> &nbsp;<%=mpState%> &nbsp;<%=mpDistrict%>   </textarea>
        </td>
    </tr>


</table>
<table border=1  rules=none align=center bottommargin=0  topmargin=0
       cellspacing=0 cellpadding=1 borderColor=#D98242>
<BR><BR>
<TR>
    <TD COLSPAN=3 align=left> <h2>Medical
    Detail :-</h2> </TD>
</TR>

<%



String  mPMHistory="",mPHistory="",mFHistory="",mSpecial="",mHistoryAcc="",mMSurgery="",
        mAllergies="",mAlleg="",mAlleDetail="";
String FSelect="",MSelect="",OSelect="",NSelect="";


qry="SELECT STUDENTID, PREVIOUSMEDICALHISTORY, PERSONALHISTORY, " +
        "   FAMILYHISTORY, ACCIDENTSURGERY, ACCIDENTSURGERYDETAIL, " +
        "   ALLERGIES, TYPEOFALLERGIES, ALLERGIESDETAILS, " +
        "   SPECIALNOTE, REMARKS " +
        "   FROM STUDENTMEDICALDETAIL WHERE STUDENTID='"+mStudID+"' ";
rs=db.getRowset(qry);

if(rs.next())
    {
    mPMHistory=rs.getString("PREVIOUSMEDICALHISTORY");
    mPHistory=rs.getString("PERSONALHISTORY");
    mFHistory=rs.getString("FAMILYHISTORY");
    mSpecial=rs.getString("SPECIALNOTE");
    mHistoryAcc=rs.getString("ACCIDENTSURGERY");
    mMSurgery=rs.getString("ACCIDENTSURGERYDETAIL");
    mAllergies=rs.getString("ALLERGIES");
    mAlleg=rs.getString("TYPEOFALLERGIES");
    mAlleDetail=rs.getString("ALLERGIESDETAILS");

    }
else
    {
    mPMHistory="";
    mPHistory="";
    mFHistory="";
    mSpecial="";
    mHistoryAcc="";
    mMSurgery="";
    mAllergies="";
    mAlleg="";
    mAlleDetail="";
    }

String mHistoryChk="",AllergiesChk="";

if(mHistoryAcc==null)
    mHistoryChk="";
else if(mHistoryAcc.equals("Y"))
    mHistoryChk="checked";
else
    mHistoryChk="";


String  mSelDis="",mAllDis="";
//out.print("ddd");
if(mAllergies.equals("Y"))
    {
        AllergiesChk="checked";
        mSelDis="";
        mAllDis="";
    }
else
    {
        AllergiesChk="";
        mSelDis="disabled";
        mAllDis="disabled";
    }

%>

<tr>
    <td class="labelcell">
        Previous Medical History :
    </td>
    <td class="labelcell">
        <textarea id="PMHistory" name="PMHistory" rows="" cols="30"><%=mPMHistory%></textarea>
    </td>
</tr>
<tr>
    <td class="labelcell">
        Personal History:
    </td>
    <td>
        <textarea id="PHistory" name="PHistory" rows="" cols="30"><%=mPHistory%></textarea>
    </td>
</tr>
<tr>
    <td class="labelcell">
        Family History:
    </td>
    <td>
        <textarea id="FHistory" name="FHistory" rows="" cols="30"  ><%=mFHistory%></textarea>
    </td>
</tr>
<tr>
    <td class="labelcell">
        <font color=red ><b>Special Notes </font>
    </td>

    <td><textarea id="Special" name="Special" rows="" cols="30"><%=mSpecial%></textarea>
    </td>
</tr>

<tr>
    <td class="labelcell" valign="top">
        History of any major surgery or Accident
        <input type="checkbox" id="HistoryAcc" <%=mHistoryChk%> onclick=" return radioHistory();" value="Y" name="HistoryAcc" >Yes
<br><font size="1" color="">(in which there was loss of consciouness)</font>
    </td>

    <td><textarea id="MSurgery" name="MSurgery" rows="" cols="30"><%=mMSurgery%></textarea>
        
    </td>
</tr>

<tr>
    <td class="labelcell">
        Allergies
<input type="checkbox" <%=AllergiesChk%> onclick="return radioAlle();" name="Allergies" id="Allergies" value="Y"  onclick=" return radioAlle();">
Yes<select  name="Alleg" id="Alleg" <%=mSelDis%> >
            <%
            
            if(mAlleg.equals("F"))
                FSelect="Selected";
            else if(mAlleg.equals("M"))
                MSelect="Selected";
            else if(mAlleg.equals("O"))
                OSelect="Selected";
            else
                NSelect="Selected";
    

            %>
            <option <%=NSelect%> value='N'><-Select-></option>
            <option <%=FSelect%> value='F'>FOOD</option>
            <option <%=MSelect%> value='M'>MEDICINE</option>
            <option <%=OSelect%> value='O'>OTHER</option>

        </select>
        Allergies Detail <td><textarea id="AlleDetail" <%=mAllDis%>  name="AlleDetail"  rows="" cols="30"><%=mAlleDetail%></textarea>
    </td></td>
</tr>

<tr>
    <td>&nbsp;</td>
</tr>

<tr>

<td align="center"  class="labelcell">
<a href="ComplainDetail.jsp?StudentID=<%=mStudID%>" target=_new>
    <Font face=verdana size=2 color=green><B> Click to Enter Present Complaint   </B></font></a>
           
</td>
<td>
    <input type=Submit  border= "3px" name="Save"
           id="Save" value="&nbsp; Save &nbsp;" onClick="return Validate();" >


</td></tr>

</table>

<%
    if (request.getParameter("Save") != null) {

        String qrys = "", MSurgery = "", Allergies = "", Alleg = "", AlleDetail = "", HistoryAcc = "", PMHistory = "";
        String PHistory = "", FHistory = "", Special = "";

        if(request.getParameter("PMHistory")==null)
            PMHistory = "";
        else
        PMHistory = request.getParameter("PMHistory");

        if(request.getParameter("PHistory")==null)
            PHistory = "";
        else
        PHistory = request.getParameter("PHistory");

        if(request.getParameter("FHistory")==null)
            FHistory = "";
        else
        FHistory = request.getParameter("FHistory");

        if(request.getParameter("Special")==null)
            Special  = "";
        else
        Special  = request.getParameter("Special");

        if(request.getParameter("HistoryAcc")==null)
            HistoryAcc  = "";
        else
        HistoryAcc  = request.getParameter("HistoryAcc");

        if(request.getParameter("MSurgery")==null)
            MSurgery  = "";
        else
        MSurgery  = request.getParameter("MSurgery");


        if(request.getParameter("Allergies")==null)
            Allergies  = "";
        else
        Allergies  = request.getParameter("Allergies");

        if(request.getParameter("Alleg")==null)
            Alleg  = "";
        else
        Alleg  = request.getParameter("Alleg");

        if(request.getParameter("AlleDetail")==null)
            AlleDetail = "";
        else
        AlleDetail = request.getParameter("AlleDetail");
        
        
        qry = "SELECT 'Y' FROM STUDENTMEDICALDETAIL WHERE STUDENTID ='" + mStudID + "' ";
      
        rs = db.getRowset(qry);
        if (!rs.next()) {
            qrys = "INSERT INTO STUDENTMEDICALDETAIL (  STUDENTID, PREVIOUSMEDICALHISTORY, PERSONALHISTORY, " +
                    "   FAMILYHISTORY, ACCIDENTSURGERY, ACCIDENTSURGERYDETAIL, " +
                    "   ALLERGIES, TYPEOFALLERGIES, ALLERGIESDETAILS, " +
                    "   SPECIALNOTE,  ENTRYBY,    ENTRYDATE) " +
                    " VALUES ( '" + mStudID + "' ,'" + PMHistory + "' ,'" + PHistory + "' ,'" + FHistory + "','" + HistoryAcc + "', " +
                    " '" + MSurgery + "', '" + Allergies + "' ,'" + Alleg + "'    ,'" + AlleDetail + "' ,'" + Special + "' , " +
                    "  '"+mChkMemID+"',sysdate )";
              // out.print(qrys);
                int n=db.insertRow(qrys);

                if(n>0)
                   { 
                    out.println("<center><font size=2 face=verdana> " +
                            "Record Saved Successfully </font> </center>");
                   }
            }
        else
            {
           //   out.print(qry);
            qry1="UPDATE STUDENTMEDICALDETAIL " +
                    "SET    STUDENTID              = '" + mStudID + "' ," +
                    "       PREVIOUSMEDICALHISTORY = '" + PMHistory + "'," +
                    "       PERSONALHISTORY        = '" + PHistory + "' ," +
                    "       FAMILYHISTORY          = '" + FHistory + "' ," +
                    "       ACCIDENTSURGERY        = '" + HistoryAcc + "'," +
                    "       ACCIDENTSURGERYDETAIL  = '" + MSurgery + "'," +
                    "       ALLERGIES              = '" + Allergies + "'," +
                    "       TYPEOFALLERGIES        = '" + Alleg + "' ," +
                    "       ALLERGIESDETAILS       = '" + AlleDetail + "'," +
                    "       SPECIALNOTE            = '" + Special + "' ," +
                    "       ENTRYBY                ='"+mChkMemID+"'," +
                    "       ENTRYDATE              = SYSDATE" +
                    " WHERE  STUDENTID              = '" + mStudID + "' ";
            int y=db.update(qry1);
             if(y>0)
                   {
                    out.println("<center><font size=2 face=verdana> " +
                            "Record Updated Successfully </font> </center>");
                   }
            }

    }

%>

<table class="sort-table" id="table-1" border="1"  cellspacing=0 cellpadding=0 borderColor=#D98242  width="100%"  >

   <thead>
    <tr>
        <td COLSPAN=13 align=left> <h2><center>Treatment Record</center></h2> </td>
    </tr>
    <tr bgcolor="#FFCF83">
    <B><td rowspan=2 class="labelcell">Ref.No.</td>
        <B><td rowspan=2 class="labelcell">Complain No.</td>
        <td rowspan=2  class="labelcell">Date Of Complain</B></td>
<td rowspan=2  class="labelcell">Complaint</br></B> </td>
<td rowspan=2  class="labelcell">Treatment Detail</br></B> </td>
<td rowspan=2  class="labelcell">Suggestion if required</B></td>
<td rowspan=2  class="labelcell">Follow Advice</td>
<td rowspan=2  class="labelcell">Any investigation if required</td>
<td rowspan=2  class="labelcell" >Details of Investigation</td>
<td rowspan=2  class="labelcell">Test Result Received</td>
<td rowspan=2  class="labelcell">Result Date </td>
<td rowspan=2  class="labelcell">Result Detail</td>
</tr>
</thead>
**Double click to show or edit the existing details
</tr>
<%

    qry="SELECT  refno,  complaintno,  TO_CHAR (complaintdate, 'DD-MM-YYYY') complaintdate," +
           "       NVL (complaintdesc, ' ') complaintdesc,TREATMENTDESC," +
           " decode(followadvice,'Y','Yes','N','No',' ',followadvice)followadvice ," +
           "       investigationdesc,DECODE (investigationreruired,'Y', 'Yes','N', 'No',' ', investigationreruired)  " +
           " investigationreruired," +
           "       TO_CHAR (receiveddate, 'DD-MM-YYYY') receiveddate, remarks," +
           "       resultdesc, decode(resultreceived,'Y','Yes','N','No','',resultreceived)resultreceived" +
           ", studentid, suggestion, treatmentdesc" +
           "  FROM studenttreatmentdetail" +
           " WHERE studentid = '"+mStudID+"' order by refno ";
   // out.print(qry);
    rs=db.getRowset(qry);
    while(rs.next())
        {
        %>
        <tr>
            <td class="labelcell"><%=rs.getString("refno")%> </td>
            <td class="labelcell"><%=rs.getString("complaintno")%> </td>
            <td nowrap class="labelcell"><%=rs.getString("complaintdate")%> </td>
            <td class="labelcell"> 

<a Title="View in Complain in Detail" 
target=_New 
href="ComplainDetail.jsp?StudentID=<%=mStudID%>&amp;RefeNo=<%=rs.getString("refno")%>&amp;CompaNo=<%=rs.getString("complaintno")%>"><font color="blue">
    <b><%=rs.getString("complaintdesc")%> </b> </font></a>
            
            
              </td>
            <td class="labelcell"><%=rs.getString("TREATMENTDESC")%> </td>
            <td class="labelcell"><%=rs.getString("suggestion")%> </td>
            <td class="labelcell"><%=rs.getString("followadvice")%> </td>
            <td class="labelcell"><%=rs.getString("investigationreruired")%> </td>
            <td class="labelcell"><%=rs.getString("investigationdesc")%> </td>
            <td class="labelcell"><%=rs.getString("resultreceived")%> </td>
            <td nowrap class="labelcell"><%=rs.getString("receiveddate")%> </td>
            <td class="labelcell"><%=rs.getString("resultdesc")%> </td>
            
        </tr>
        <%
        }


    

%>



</form>
<%
}
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
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}
}
catch(Exception e)
{
	 //out.print("error");
}
%>
</body>
</html>

