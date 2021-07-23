<%-- 
    Document   : placementregis_history
    Created on : Nov 6, 2013, 2:45:00 PM
    Author     : campus.trainee
--%>

<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp,java.lang.ArrayIndexOutOfBoundsException" %>
<%
     
        DBHandler db = new DBHandler();
         OLTEncryption enc=new OLTEncryption();
        int rsum=0,ssum=0,tsum=0,usum=0,vsum=0,wsum=0;
        ResultSet rs =  null;
		ResultSet rst = null;
		ResultSet rsf=  null ;
        ResultSet rsd = null;
        ResultSet rs1 = null;
        ResultSet rs2 = null;
        ResultSet rsc = null;
        String qry = "" ,qry2="",table="",qryc="",mSUBB="",mSUBN="",mDMemberCode="", mLTP="",qry1="",inst="",institute="",academic="",academicyear="";
		String qryt = "",Event="",Programcode="",Companycode="",status="",remarks="" ,sysdate="";
        GlobalFunctions gb = new GlobalFunctions();
	    String mRegCode = "",event="", Academicyear="",mMemberID="",selected="",select="";
        String mEXAMCODE = "" ,mSubjID="",DataSublist="" ,mProgCode="",QryProgCode="",companycode="";
        String mAcademicYear = "",program="",programcode="",mMemberType="";
        String mProgramCode = "";
        String mInstCode = "",mName="";
		String  mreg="";
		String mHOSTELTYPE = "" , macade="" ,mbranc="" ,sem="",semester="",branch="",branchcode="" ;
		String mprog="",enddate="",fromdate="";
		String mBranchCode = "",msid="",mCode="",mES="",mSubj1="",qrysubj="",Subject="";
        int n=0;
        String qryx="",mLTP1="",Branch="",mAcadmeicYear="",mProgram="",mMemberCode="";
        ResultSet rsx=null;
        String reqAction="",mSemester="",mMemberName="",mcheck="",mcheck1="",mcheck2="";
		String mInst="",mSubject="",minst="" ,qrys="",Semester="";
		int rsum80t1=0,rsum80t2=0,rsum80t3=0,ssum70t1=0,ssum70t2=0,ssum70t3=0,tsum60t1=0,tsum60t2=0,tsum60t3=0,
					usum50t1=0,usum50t2=0,usum50t3=0,vsum40t1=0,vsum40t2=0,vsum40t3=0,wsum30t1=0,wsum30t2=0,wsum30t3=0;
		int count=0 ,Flag=0;



int ttsum1=0,ttsum2=0,ttsum3=0;

if (session.getAttribute("InstituteCode") == null)
	mInst = "";
else
	mInst = session.getAttribute("InstituteCode").toString().trim();
if (session.getAttribute("CurrentSem") == null)
	mSemester = "";
else
	mSemester = session.getAttribute("CurrentSem").toString().trim();
if (session.getAttribute("BranchCode") == null)
	mBranchCode = "";
else
	mBranchCode = session.getAttribute("BranchCode").toString().trim();
if (session.getAttribute("AcademicYearCode") == null)
	mAcadmeicYear = "";
else
	mAcadmeicYear = session.getAttribute("AcademicYearCode").toString().trim();
if (session.getAttribute("ProgramCode") == null)
	mProgram = "";
else
	mProgram = session.getAttribute("ProgramCode").toString().trim();
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





if (session.getAttribute("MemberName")==null)
{
	mName="";
}
else
{
	mName=session.getAttribute("MemberName").toString().trim();
}


try
{  //1
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
	qry="Select WEBKIOSK.ShowLink('88','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------
	try
	{

		mDMemberCode=enc.decode(mMemberCode);
		mMemberID=enc.decode(mMemberID);
		mMemberType=enc.decode(mMemberType);
	}
	catch(Exception e)
	{
		out.println(e.getMessage());
	}}}}
catch(Exception e)
	{
		out.println(e.getMessage());
	}
%>
<HTML>
    <head>
        <TITLE>#### JIIT [ Attendance PercentageWise BreackUp]</TITLE>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<script type="text/javascript" src="sh/jquery-1.4.2.min.js"></script>

    <script type="text/javascript" src="sh/jquery.searchabledropdown-1.0.8.min.js"></script>
	<script type="text/javascript" >



        function getCurrentDateTime()

            {
				var currentDate;
				var retDateTime;
				currentDate = new Date();
                retDateTime=""+currentDate.getDate()+currentDate.getMonth()+currentDate.getFullYear()+currentDate.getHours()+currentDate.getMinutes()+currentDate.getSeconds();
				return retDateTime;
			}
	$(document).ready(function(){
			$("#value").html($("select#event :selected").text() + " (VALUE: " + $("select#event").val() + ")");
			$("select").change(function(){
				$("#value").html(this.options[this.selectedIndex].text + " (VALUE: " + this.value + ")");

				if(this.id=="event"){
					//alert(this.id+"...."+this.value);
				$.get("company.jsp",{event:$("select#event").val(),dt:getCurrentDateTime()},successfunction);
				}

			});
		});
        function successfunction(response)
    {
		if (response) {

			var x=response+"";
			//alert(x);
			if(x==""){}
			else{
				var arrayOfStrings = x.split("$");
                //alert(arrayOfStrings);
				$("select#companycode").empty();
				$('select#companycode').append("<option value=\"" + "" + "\">" +"Select"+ "</option>");
				for(var i=0;i<arrayOfStrings.length-1;i++){
                    var t=arrayOfStrings[i];
					$('select#companycode').append("<option value=\"" + t + "\">" + t+ "</option>");
				}
			}
		}

   }

function vari()
{
    var i=document.getElementById("event").value;
    var j=document.getElementById("companycode").value;
    var msg="";
    var k=0
if(i==(""))
    {
        msg="Event can not be left blank\n";
        k++;
    }
if(j==(""))
    {
        msg=msg+"Company can not be left blank\n";
        k++;
    }
    if(k>0)
        {
            alert(msg);
            return false;
        }
}




        </script>
</head>
    <body aLink=#ff00ff bgcolor=#fce9c5  rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >


        <form name="frm"  method="post" >
        <input id="x" name="x" type=hidden>
    <table  align=center rules=groups border=3 bordercolor="black" width="90%" name="tab" class="tab" id="tab" >
    <tr>
        <td>


    <%       try{if(mInst.equals("JIIT"))
    {
table="TP#REGISTRATIONDETAIL";
    }
else
    {
table="TP#REGISTRATIONDETAIL@linktest";
}
qry1="SELECT distinct NVL(COMPANYCODE,' ') c,status s,remarks r FROM "+table+"  Where " +
    " INSTITUTECODE='"+mInst+"' and " +
    "ACADEMICYEAR='"+mAcadmeicYear+"' and PROGRAMCODE='"+mProgram+"' and SECTIONBRANCH='"+mBranchCode+"'" +
    " and SEMESTER=to_number('"+mSemester+"') and studentid='"+mMemberID+"'";

//out.print(qry1);
rs=db.getRowset(qry1);
rs1=db.getRowset(qry1);
if(!rs.next()){}
    else{%>
     <!--table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
        <tr>
        <td colspan=0 align=middle>
            <font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><FONT SIZE="4" COLOR=""><B><u>Registration History</u></B></FONT></font></td></tr>
        </table>

<table  align=center rules=groups border=3 bordercolor="black" width="90%" name="tab" class="tab" id="tab" bgcolor="white" >
  <tr bgcolor="Silver">
      <td width="30%" align="center">Company Name</td>
      <td width="30%" align="center">Status</td>
      <td width="30%" align="center">Remarks</td>
  </tr>
 <%while(rs1.next()){
     String stat=rs1.getString("s")==null?"":rs1.getString("s").trim();
     if(stat.equals("I"))
         {
     status="Intrested";
     }
     else if(stat.equals("N"))
         {
     status="Not Intrested";
     }
     else{
     status="Pending";
     }
     %>
  <tr>
 <td width="30%" align="center"><%=rs1.getString("c")==null?"":rs1.getString("c").trim()%></td>
  <td width="30%" align="center"><%=status%></td>
 <td width="30%" align="center"><%=rs1.getString("r")==null?"":rs1.getString("r").trim()%></td>
</tr>
     <%}%> </table-->
 <%}
}catch(Exception e){
out.print("Error in showing Registration History"+e);
}
    qry="SELECT COMPANYCODE,SELECTED, PACKAGEOFFEREDINLACKS FROM TP#AFTERINTERVIEW " +
        "where " +
        " INSTITUTECODE='"+mInst+"' and studentid='"+mMemberID+"'";
//out.print(qry);
    rs=db.getRowset(qry);
rs1=db.getRowset(qry);
    if(!rs.next())
{}
else{%>
<center><p><font color="lightred" size="4">You can't apply for more companies because you are already seleced in <u> '<%=rs.getString(1)%>' </u> </font> </p></center>
 <table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
        <tr>
        <td colspan=0 align=middle>
            <font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><FONT SIZE="4" COLOR=""><B><u>Placement History</u></B></FONT></font></td></tr>
        </table>
<table  align=center rules=groups border=3 bordercolor="black" width="90%" name="tab" class="tab" id="tab" bgcolor="white" >
  <tr bgcolor="Silver">
      <td width="30%" align="center">Company Name</td>
      <td width="30%" align="center">Status</td>
  </tr>
<%while(rs1.next()){
selected=rs1.getString("SELECTED")==null?"":rs1.getString("SELECTED").trim();
if(selected.equals("N"))
    {
select="Not Selected.";
}
else{
select="Selected";
}

    %>
<tr>
      <td width="30%" align="center"><%=rs1.getString("COMPANYCODE")%></td>
      <td width="30%" align="center"><%=select%></td>
      </tr>
</table>

    <br>

</table>

<%}
}
    %>