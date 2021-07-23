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
		String  mreg="" ;
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
        <table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
        <tr>
        <td colspan=0 align=middle>
            <font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><FONT SIZE="4" COLOR=""><B><u>Registered Parameter</u></B></FONT></font></td></tr>
        </table>
        <table  align=center rules=groups border=3 bordercolor="black" width="90%" name="tab" class="tab" id="tab" bgcolor="white" >
<tr bgcolor="silver">
<td align="left" valign="top" width="40%" nowrap>
<FONT face=Arial size=2><STRONG>Choose Event:</STRONG></FONT><font color=red face=arial size=2><STRONG>*</STRONG></font>
			<%

			try
            {
                qry="select distinct NVL(EventCode,'') e from TP#REGISTRATIONPARAMETERS " +
                        "Where nvl(Deactive,'N')='N' and  INSTITUTECODE='"+mInst+"' and ACADEMICYEAR='"+mAcadmeicYear+"' and PROGRAMCODE='"+mProgram+"' and SECTIONBRANCH='"+mBranchCode+"' and SEMESTER=to_number('"+mSemester+"') ";
//out.print(qry2);
				 //out.print(qry);
                rs=db.getRowset(qry);
               %>


					<Select Name="event" tabindex="0" id="event">
                    <OPTION Value ="" ><--select--></OPTION>
                        <%//out.print(qry);
                    if(rs.next())
					{
						event=rs.getString("e");
			if(request.getParameter("x")!=null)
			 			{
							%>
							<OPTION Selected  Value =<%=event%>><%=rs.getString("e")%></option>
							<%
						}
						else
						{
							%>
							<OPTION  Value =<%=event%>><%=rs.getString("e")%></option>
							<%
						}
					event=request.getParameter("event")==null?"":request.getParameter("event").trim();
					}
					%>
					</select>
			<%
			}catch(Exception e)
                {
        out.print("error123 is "+e);
            }

			// out.print("x="+request.getParameter("x"));
			 %>

				</td>
			<td nowrap>
	<FONT color=black face=Arial size=2><b>Choose Company:</b></FONT><font color=red face=arial size=2><STRONG>*</STRONG></font>

<select name="companycode" id="companycode">
<OPTION seleceted Value ="" ><--select--></OPTION>
<%
             try{
  qry1="SELECT distinct NVL(COMPANYCODE,' ') c FROM TP#REGISTRATIONPARAMETERS  Where " +
    "nvl(Deactive,'N')='N' and eventcode='"+event+"' and INSTITUTECODE='"+mInst+"' and " +
    "ACADEMICYEAR='"+mAcadmeicYear+"' and PROGRAMCODE='"+mProgram+"' and SECTIONBRANCH='"+mBranchCode+"'" +
    " and SEMESTER=to_number('"+mSemester+"') ";

        System.out.print("qryyyyyyyyyyyyyy:"+qry1);
rs2=db.getRowset(qry1);
		if(request.getParameter("x")!=null )
		{
        
		while(rs2.next())
					{
           
            	companycode=rs2.getString("c");
            
			if(companycode.equals(request.getParameter("companycode").toString().trim()))
						{
					%>
						<option selected value=<%=companycode%> ><%=companycode%></option>
					<%  }
					else
						{%>
					<option  value=<%=companycode%> ><%=companycode%></option>
				<%	}

					}
		}
		else
			{
				while(rs2.next())
					{
					companycode=rs2.getString("c");
                    if(companycode.equals(request.getParameter("companycode").toString().trim()))
						{
					%>
						<option selected value=<%=companycode%> ><%=companycode%></option>
					<%  }
					else
						{%>
						<option  value=<%=companycode%> ><%=companycode%></option>
				<%	}

					}

			}


//System.out.println("mprogram="+mProgram);
		companycode=request.getParameter("companycode")==null?"":request.getParameter("companycode").trim();
		%>
</select>
		<%}catch(Exception e)
                {
        out.print("error is "+e);}%>
	</td>

   <td>
       <input type="submit" name="btn" id="btn" value="Show"  onclick="return vari();">
   </td>
</tr>
  </table>
 <br>
    </form>
  <form>
      <%
    try{if(request.getParameter("x")!=null){
        Companycode=request.getParameter("companycode")==null?"":request.getParameter("companycode").toString().trim();
        Event=request.getParameter("event")==null?"":request.getParameter("event").toString().trim();
%><table  align=center rules=groups border=3 bordercolor="black" width="90%" name="tab" class="tab" id="tab" bgcolor="white" display="hidden" >
 
<%qry="SELECT COMPANYNAME name, EMAILID email,ADDRESS1, ADDRESS2, ADDRESS3 FROM TP#COMPANYMASTER " +
        "where companycode='"+Companycode+"'";

rs=db.getRowset(qry);
//out.print(qry);
if(rs.next()){
%>

 <tr bgcolor="silver">
        <td nowrap align="" width="50%"><b>Company Name:</b><%=rs.getString("name")%></td>
        <td nowrap align="center" width="50%"><b>Email-id:</b><%=rs.getString("email")%></td>
   </tr>
    <%
}%>
<tr>
<td>
<b>Registretion Status:</b>
<%qry="SELECT status FROM TP#REGISTRATIONDETAIL where " +
        "Eventcode='"+event+"' and companycode='"+companycode+"' and INSTITUTECODE='"+mInst+"' " +
        "and STUDENTID='"+mMemberID+"'";
 //out.print(qry);
rs=db.getRowset(qry);
if(!rs.next())
{
%>
<input type="radio" name="status" value="I" />Intrested</br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="status" value="N" />Not Intrested</br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="status" value="P" checked />Pending
<%}else{
    if(rs.getString("status").equals("I"))
    {
   mcheck="checked";
}else if(rs.getString("status").equals("N"))
{
 mcheck1="checked";
}
    else
    {
mcheck2="checked";
} %>
<input type="radio" name="status" value="I" <%=mcheck%>/>Intrested</br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="status" value="N" <%=mcheck1%>/>Not Intrested</br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="status" value="P" <%=mcheck2%> />Pending
<%}%>

</td>
 <td align="left" nowrap>
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 &nbsp;&nbsp;&nbsp;&nbsp;
 <b>Remarks:
 <%qry="SELECT REMARKS FROM TP#REGISTRATIONDETAIL where " +
        "Eventcode='"+event+"' and companycode='"+companycode+"' and INSTITUTECODE='"+mInst+"' " +
        "and STUDENTID='"+mMemberID+"'";
 //out.print(qry);
rs=db.getRowset(qry);
if(!rs.next())
{
 %>

 <input type="text" style="width:260px;" length="160" name="remarks" id="remarks" value=""></b>
 </td>
  </tr>
   <tr>
        <td align="right" colspan="2">
        <input type="submit" value="Register"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         </td>
    </tr>
 <%}else{%>
 <input type="text" style="width:260px;" length="160" name="remarks" id="remarks" value="<%=rs.getString("REMARKS")==null?"":rs.getString("REMARKS").trim()%>"></b>
 </td>
  </tr>
   <tr>
        <td align="right" colspan="2">
        <input type="submit" value="Update"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         </td>
    </tr>
 <%}%>


<input type="hidden" name="remarks" id="remarks" value="<%=remarks%>">
<input type="hidden" name="status" id="status" value="<%=status%>">
<input type="hidden" name="companycode" id="companycode" value="<%=companycode%>">
<input type="hidden" name="event" id="event" value="<%=event%>">
<input type="hidden" name="y" id="y">
<%}
    if(request.getParameter("y")!=null){
    //qry="select sysdate from dual";
    //rs=db.getRowset(qry);
    //while(rs.next()){
 //sysdate=rs.getString("sysdate");
   // }
try{
try{
    remarks=request.getParameter("remarks")==null?"":request.getParameter("remarks").toString().trim();
status=request.getParameter("status")==null?"":request.getParameter("status").toString().trim();
Companycode=request.getParameter("companycode")==null?"":request.getParameter("companycode").toString().trim();
Event=request.getParameter("event")==null?"":request.getParameter("event").toString().trim();
if(mInst.equals("JIIT"))
    {
table="TP#REGISTRATIONDETAIL";
    }
else
    {
table="TP#REGISTRATIONDETAIL@linktest";
}

}catch(Exception e){
out.print("Error in getting data"+e);
}

qry2="SELECT 'Y' FROM "+table+" " +
        "where EVENTCODE='"+Event+"' and COMPANYCODE='"+Companycode+"' and INSTITUTECODE='"+mInst+"' and ACADEMICYEAR='"+mAcadmeicYear+"' and " +
        "PROGRAMCODE='"+mProgram+"' and SECTIONBRANCH='"+mBranchCode+"' and SEMESTER=to_number('"+mSemester+"') and STUDENTID='"+mMemberID+"'";
//out.print(qry2);
rs1=db.getRowset(qry2);
if(rs1.next()){
qry="UPDATE "+table+" SET STATUS='"+status+"',REMARKS ='"+remarks+"',DATEOFREGISTRATION = sysdate " +
        "WHERE  EVENTCODE ='"+Event+"' AND    COMPANYCODE = '"+Companycode+"'  " +
        " AND INSTITUTECODE ='"+mInst+"'  AND    ACADEMICYEAR = '"+mAcadmeicYear+"'   " +
        " AND PROGRAMCODE = '"+mProgram+"' AND    SECTIONBRANCH  = '"+mBranchCode+"'" +
        " AND    SEMESTER = '"+mSemester+"' AND STUDENTID ='"+mMemberID+"' ";
//out.print(qry);
int t=db.update(qry);
if(t>0)
    {
out.print("<center><font color=green size=4 >Now You successfuly update your status and remarks.</font></center>");
}
}
else
{
qry1="INSERT INTO "+table+" (EVENTCODE, COMPANYCODE, INSTITUTECODE, ACADEMICYEAR, PROGRAMCODE, " +
        "SECTIONBRANCH,SEMESTER,STUDENTID, STATUS,REMARKS, DATEOFREGISTRATION, REGISTEREDBY) VALUES " +
        "( '"+Event+"','"+Companycode+"','"+mInst+"','"+mAcadmeicYear+"','"+mProgram+"','"+mBranchCode+"'," +
        "to_number('"+mSemester+"'),'"+mMemberID+"','"+status+"','"+remarks+"',sysdate,'"+mDMemberCode+"')";
 //out.print(qry1);
int l=db.insertRow(qry1);
if(l>0)
    {

out.print("<center><font color=green size=4 >Now You are registered for this company</font></center>");
    }
}
}






catch(Exception e){
out.print("Error in insert"+e);
}
}

}
catch(Exception e){
out.print("Error in showing company details"+e);
}
try{if(mInst.equals("JIIT"))
    {
table="TP#REGISTRATIONDETAIL";
    }
else
    {
table="TP#REGISTRATIONDETAIL@linktest";
}
qry1="SELECT distinct NVL(COMPANYCODE,' ') c,status s,remarks r FROM "+table+"  Where " +
    "eventcode='"+event+"' and INSTITUTECODE='"+mInst+"' and " +
    "ACADEMICYEAR='"+mAcadmeicYear+"' and PROGRAMCODE='"+mProgram+"' and SECTIONBRANCH='"+mBranchCode+"'" +
    " and SEMESTER=to_number('"+mSemester+"') and studentid='"+mMemberID+"'";

//out.print(qry1);
rs=db.getRowset(qry1);
rs1=db.getRowset(qry1);
if(!rs.next()){}
    else{%>
     <table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
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
 <td width="30%" align="center"><input type="text" value="<%=rs1.getString("r")==null?"":rs1.getString("r").trim()%>" style="width:325px;" name="r" id="r" readonly/></td>
</tr>
     <%}%> </table>
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

 <table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
        <tr>
        <td colspan=0 align=middle>
            <font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><FONT SIZE="4" COLOR=""><B><u>Placement History</u></B></FONT></font></td></tr>
        </table>
<table  align=center rules=groups border=3 bordercolor="black" width="90%" name="tab" class="tab" id="tab" bgcolor="white" >
  <tr bgcolor="Silver">
      <td width="30%" align="center">Company Name</td>
      <td width="30%" align="center">Seleced</td>
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


<%}
}
    %>
</form>
</body>
        </html>
