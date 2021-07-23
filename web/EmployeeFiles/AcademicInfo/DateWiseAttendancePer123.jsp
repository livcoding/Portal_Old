<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%
        DBHandler db = new DBHandler();
        int rsum=0,ssum=0,tsum=0,usum=0,vsum=0,wsum=0;
        ResultSet rs =  null;
		ResultSet rst = null;
		ResultSet rsf=  null ;
        ResultSet rsd = null;
        ResultSet rs1 = null;
        ResultSet rs2 = null;
        ResultSet rsc = null;
        String qry = "" ,qryc="",mSUBB="",mSUBN="", mLTP="",qry1="";
		String qryt = "";
        GlobalFunctions gb = new GlobalFunctions();
	    String mRegCode = "";
        String mEXAMCODE = "" ,mSubjID="",DataSublist="" ,mProgCode="",QryProgCode="";
        String mAcademicYear = "";
        String mProgramCode = "";
        String mInstCode = "";
		String  mreg="" ;
		String mHOSTELTYPE = "" , macade="" ,mbranc=""  ;
		String mprog="";
		String mBranchCode = "",msid="",mCode="",mES="",mSubj1="",qrysubj="",Subject="";

String qryx="",mLTP1="";
	ResultSet rsx=null;

		String mInst="",mSubject="",minst="" ,qrys="";
		int rsum80t1=0,rsum80t2=0,rsum80t3=0,ssum70t1=0,ssum70t2=0,ssum70t3=0,tsum60t1=0,tsum60t2=0,tsum60t3=0,
					usum50t1=0,usum50t2=0,usum50t3=0,vsum40t1=0,vsum40t2=0,vsum40t3=0,wsum30t1=0,wsum30t2=0,wsum30t3=0;
		int count=0 ,Flag=0;
		int n=0;



int ttsum1=0,ttsum2=0,ttsum3=0;

if (session.getAttribute("InstituteCode") == null)
	mInst = "";
else
	mInst = session.getAttribute("InstituteCode").toString().trim();

%>
<HTML>
    <head>
        <TITLE>#### JIIT [ Attendance PercentageWise BreackUp]</TITLE>
        <script language="JavaScript" type ="text/javascript">
            <!--
            if (top != self) top.document.title = document.title;
            -->
        </script>
<script language="JavaScript" type ="text/javascript">
function Clear(aa)
{
//alert(aa.value+"LLLLL");
aa.value="";
}



function ChangeOptions(InstCode,DataRegCode,RegCode)
{
removeAllOptions(RegCode);
var optns = document.createElement("OPTION");
optns.text='ALL';
optns.value='ALL';
RegCode.options.add(optns);
rgd='ALL';
var QryReg='';
var QryAcad='';
var QryProg='';
var QryBran='';
for(i=0;i<DataRegCode.options.length;i++)
{
var v1;
var pos;
var ic;
var rc;
var len;
var otext;
var v1=DataRegCode.options(i).value;
len= v1.length ;
pos=v1.indexOf('***');
ic=v1.substring(0,pos);
rc=v1.substring(pos+3,len);
if (ic==InstCode && rgd=='ALL' )
{
var optn = document.createElement("OPTION");
optn.text=DataRegCode.options(i).text;
optn.value=rc;
//          alert(ic+"LLLL"+rc);
if (QryReg=='') QryReg=rc;
RegCode.options.add(optn);
}
}
}


function ChangeOptions1(InstCode,Exam,DataCombo,Subject)
  {
    removeAllOptions(Subject);
	var subj='ALL';
	var mflag=0;
	var ssec='ALL';
		var optn = document.createElement("OPTION");
			optn.text='ALL';
			optn.value='ALL';
		Subject.options.add(optn);

	for(i=0;i<DataCombo.options.length;i++)
       {
		var v1;
			var pos1;
		var pos2;
		var exam;
		var sc;
		var len;
		var otext;
		var v1=DataCombo.options(i).value;
		len= v1.length ;

		pos1=v1.indexOf('***');
		pos2=v1.indexOf('///')

		inst=v1.substring(0,pos1);
		exam=v1.substring(pos1+3,pos2);
		sc=v1.substring(pos2+3,len);



		if (exam==Exam && inst==InstCode )		 {
			var optn = document.createElement("OPTION");
			optn.text=DataCombo.options(i).text;
			optn.value=sc;
			Subject.options.add(optn);
		}

	}
  }




function removeAllOptions(selectbox)
{
var i;
for(i=selectbox.options.length-1;i>=0;i--)
{
selectbox.remove(i);
}
}
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
        <script type="text/javascript" src="../js/sortabletable.js"></script>
        <link type="text/css" rel="StyleSheet" href="../css/sortabletable.css" />

    </head>
    <body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >


        <form name="frm"  method="get" >
        <input id="x" name="x" type=hidden>
        <table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
        <tr><td colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><FONT SIZE="4" COLOR=""><B>Student Attendance Date wise Percentage wise Breakup</B></FONT>
	<!-- 	<BR><img src="images/ornament.gif" width="474" height="11" alt="" /> -->
        </font></td></tr>
        </table>
        <table cellpadding=3 cellspacing=2 align=center rules=groups border=3>
<tr>
<td>
<FONT face=Arial size=2><STRONG>Institute Code:&nbsp;</STRONG></FONT>


<%
try
{
qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from institutemaster Where nvl(Deactive,'N')='N'  ";
rs=db.getRowset(qry);
if (request.getParameter("x")==null)
{
//,DataAcad,Acad,DataProg,Prog,DataBranch,Branch);"
%>
<select name="InstCode" tabindex="1" id="InstCode"
onclick="ChangeOptions(InstCode.value,DataRegCode,RegCode);"
onChange="ChangeOptions(InstCode.value,DataRegCode,RegCode);">
<option  selected value="N"><-Select-></option>
<%
while(rs.next())
{
mInst=rs.getString("InstCode");
if(mInst.equals(""))
minst=mInst;
%>
.....................................
<OPTION  Value ="<%=mInst%>"><%=mInst%></option>
<%
}
%>
</select>
<%
}
else
{
%>
&nbsp;<select name="InstCode" tabindex="1" id="InstCode" >
<option   value="N"><-Select-></option>
<%
while(rs.next())
{
mInst=rs.getString("InstCode");
if(mInst.equals(request.getParameter("InstCode").toString().trim()))
{
%>
<OPTION selected Value ="<%=mInst%>"><%=mInst%></option>
<%
}
else
{
%>
<OPTION Value ="<%=mInst%>"><%=mInst%></option>
<%
}
}
%>
</select>
<%
}
}
catch(Exception e)
{
//out.println(e.getMessage());
}
// Section Branch   //
%>


</td>
<td>
<%
ResultSet rsfd=null ;
String mReg="",mReg1="";
qry = " Select EXAMCODE RegCode, ExamCode EXAMCODE, EXAMPERIODFROM,INSTITUTECODE FROM (";
				qry += " Select A.REGCODE REGCODE, A.ExamCode ExamCode, B.EXAMPERIODFROM EXAMPERIODFROM,b.INSTITUTECODE from StudentRegistration A, ExamMaster B";
				qry += " Where A.INSTITUTECODE=B.INSTITUTECODE   and A.EXAMCODE=B.EXAMCODE  AND nvl(B.Deactive,'N')='N' AND  A.ExamCode  NOT LIKE '%SUP%' AND  A.ExamCode  NOT LIKE '%SUM%' ";
				qry += " Group By A.REGCODE, A.ExamCode, B.EXAMPERIODFROM,b.INSTITUTECODE order by EXAMPERIODFROM DESC) where rownum<=50 order by 3 desc";
				//out.print(qry);
rsfd=db.getRowset(qry);
if (request.getParameter("x")==null)
{
%>
<select name="DataRegCode" tabindex="0" id="DataRegCode" style="WIDTH:0px">
<%
while(rsfd.next())
{
mReg=rsfd.getString("INSTITUTECODE")+"***"+rsfd.getString("EXAMCODE");
if(mReg1.equals(""))
mReg1=mReg;
%>
<OPTION selected Value="<%=mReg%>"><%=rsfd.getString("EXAMCODE")%></option>
<%
}
%>
</select>
<%
}
else
{
%>
<select name=DataRegCode tabindex="0" id="DataRegCode" style="WIDTH: 0px">
<%
while(rsfd.next())
{
mReg=rsfd.getString("INSTITUTECODE")+"***"+rsfd.getString("EXAMCODE");
if(mReg.equals(request.getParameter("DataRegCode").toString().trim()))
{
mReg1=mReg;
%>
<OPTION selected Value="<%=mReg%>"><%=rsfd.getString("EXAMCODE")%></option>
<%
}
else
{
%>
<OPTION Value="<%=mReg%>"><%=rsfd.getString("EXAMCODE")%></option>
<%
}
}
%>
</select>
<%
}
%>

<FONT color=black>&nbsp; <FONT face=Arial size=2><STRONG>Exam Code :&nbsp</STRONG></FONT></FONT><!-- <select  name="RegCode" id="RegCode"
onclick="ChangeOptions1(InstCode.value,RegCode.value);"
onChange="ChangeOptions1(InstCode.value,RegCode.value);"
style="width:150px">
<option  selected value="ALL">ALL</option> -->
<%
String mExam="",qryexam="";

//out.print(request.getParameter("RegCode")+" ------------");

//qry = "SELECT DISTINCT EXAMCODE FROM exammaster WHERE NVL (deactive, 'N') = 'N' ORDER BY EXAMCODE";
qry = " Select  RegCode, Exam, EXAMPERIODFROM FROM (";
				qry += " Select A.REGCODE REGCODE, A.ExamCode Exam, B.EXAMPERIODFROM EXAMPERIODFROM from StudentRegistration A, ExamMaster B";
				qry += " Where nvl(b.LOCKEXAM,'N')='N' and A.INSTITUTECODE=B.INSTITUTECODE   and A.EXAMCODE=B.EXAMCODE  AND nvl(B.Deactive,'N')='N' AND  A.ExamCode  NOT LIKE '%SUP%' AND  A.ExamCode  NOT LIKE '%SUM%'";
				qry += " Group By A.REGCODE, A.ExamCode, B.EXAMPERIODFROM order by EXAMPERIODFROM DESC) where rownum<=50 order by 3 desc";
				//out.print(qry);
rs = db.getRowset(qry);
try{
		if (request.getParameter("x") == null)
					{
                        	%>
	                        <select  name="RegCode" id="RegCode"
onclick="ChangeOptions1(InstCode.value,RegCode.value,DataCombo,Subject);"
onChange="ChangeOptions1(InstCode.value,RegCode.value,DataCombo,Subject);"
style="width:150px">
<option  selected value="ALL">ALL</option>
      				<%
                              while (rs.next())
					{
                                    mExam = rs.getString("Exam");
                                    if (qryexam.equals(""))
						{
							qryexam = mExam;
							%>
							<OPTION Selected Value =<%=mExam%>><%=rs.getString("Exam")%></option>
							<%
						}
						else
						{
							%>
							<OPTION Value =<%=mExam%>><%=rs.getString("Exam")%></option>
							<%
						}
                              }
					%>
	                        </select>
      	                  <%
            		}
				else
				{
		            	%>
            		     <select  name="RegCode" id="RegCode"
onclick="ChangeOptions1(InstCode.value,RegCode.value,DataCombo,Subject);"
onChange="ChangeOptions1(InstCode.value,RegCode.value,DataCombo,Subject);"
style="width:150px">

<%
if (request.getParameter("RegCode").equals("ALL"))
 		{

			%>
	 		<OPTION selected value=ALL>ALL</option>
			<%
		}
		else
		{
			%>
			<OPTION value=ALL>ALL</option>
			<%
		}




					while (rs.next())
					{
                                   	mExam = rs.getString("Exam");
	                        	if (mExam.equals(request.getParameter("RegCode")))
						{
	                              	qryexam = mExam;
      			                  %>
                        			<OPTION selected Value =<%=mExam%>><%=rs.getString("Exam")%></option>
			                        <%
                  			}
						else
						{
			            		%>
                  			      <OPTION Value =<%=mExam%>><%=rs.getString("Exam")%></option>
			                        <%
						}
                        	}
					%>
		                  </select>
            		      <%
                        }
			}
			catch (Exception e)
			{
                       	// out.println("Error Msg");
			}
			%>
</select></td>


<td>
<%
String mCurrDate="DD-MM-YYYY";
String mDate1="",mDate2="",mDate3="";
if (request.getParameter("x")!=null)
		{
			mDate1=request.getParameter("TXT1").toString().trim();
			mDate2=request.getParameter("TXT2").toString().trim();
				mDate3=request.getParameter("TXT3").toString().trim();
		}
		else
		{
			mDate1=mCurrDate;
			mDate3=mCurrDate;
			mDate2=mCurrDate;
		}
%>
<FONT face=Arial size=2><STRONG>T1 Date:<Br>
<FONT face=Arial COLOR=GREEN size=1><STRONG>
(DD-MM-YYY)</STRONG>
 </FONT></STRONG>
 </FONT>
</font>&nbsp;<input Name="TXT1" Id="TXT1" Type=text maxlength=10 size=12 value='<%=mDate1%>' onclick="Clear(this);">
</td>

<td>
 <FONT face=Arial size=2><STRONG>T2 Date:<br>
<FONT face=Arial COLOR=GREEN size=1><STRONG>
(DD-MM-YYY)</STRONG>
 </FONT></STRONG></FONT>
&nbsp;<input Name="TXT2" Id="TXT2" Type=text maxlength=10 size=12 value='<%=mDate2%>' onclick="Clear(this);">
</td>

<td>
 <FONT face=Arial size=2><STRONG>T3 Date:<br>
<FONT face=Arial COLOR=GREEN size=1><STRONG>
(DD-MM-YYY)</STRONG>
 </FONT></STRONG></FONT>
&nbsp;<input Name="TXT3" Id="TXT3" Type=text maxlength=10 size=12 value='<%=mDate3%>' onclick="Clear(this);">
</td>



</TR>



<TR>
<td>
<font color=black face=arial size=2><STRONG> Program Code</STRONG></font>
	<%
	  qry="select distinct programcode from programmaster where  nvl(deactive,'N')='N' ORDER BY programcode ";
	  rs=db.getRowset(qry);
	  //out.print(qry);
	%>
	&nbsp;&nbsp;<select name="PROG" id="PROG" tabindex="0" id="PROG" style="WIDTH: 120px;height: 120px"  multiple="multiple">
	<option  selected value="ALL" >ALL</option>
	<%
	try
	{
 	if(request.getParameter("x")==null)
	{
		while(rs.next())
		{
		 	mProgCode=rs.getString("ProgramCode");
			if(QryProgCode.equals(""))
 			{
				QryProgCode=mProgCode;
				%>
				<OPTION  Value =<%=mProgCode%>><%=mProgCode%></option>
				<%
			}
			else
			{
				%>
				<option value=<%=mProgCode%>><%=mProgCode%></option>
				<%
			}
		}
	}
	else
	{
		while(rs.next())
		{
		   mProgCode=rs.getString("ProgramCode");
		   if(mProgCode.equals(request.getParameter("PROG").toString().trim()))
		   {
			QryProgCode=mProgCode;
			%>
			<option selected value=<%=mProgCode%>><%=mProgCode%></option>
	 		<%
		   }
		   else
		   {
			%>
			<option  value=<%=mProgCode%>><%=mProgCode%></option>
			<%
		   }
		}
	}
	}
	catch(Exception e)
	{
	}
	%>
	</select>

</td>

<td colspan=2>

<!--******************DataCombo**************-->
<%
try
{
	qry=" Select Distinct A.Institutecode Institutecode, nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
	qry=qry+" from  facultysubjecttagging A,SUBJECTMASTER B where  ";
	//qry=qry+" A.facultytype=decode('"+mDMemberType+"','E','I','E') and ";
	qry=qry+"  A.examcode  in (select examcode from exammaster where nvl(LOCKEXAM,'N')='N' ";
	qry=qry+" and nvl(FINALIZED,'N')='N' and NVL(DEACTIVE,'N')='N' ) AND A.Institutecode=B.Institutecode AND A.SUBJECTID=B.SUBJECTID";
	qry=qry+" order by subject";
	rs=db.getRowset(qry);
	//out.print(qry);
	if (request.getParameter("x")==null)
	{
	 %>
		<Select Name=DataCombo tabindex="0" id="DataCombo" style="WIDTH: 0px">
		<%
		while(rs.next())
		{

			msid=rs.getString("subjectid");
			mCode=rs.getString("examcode");
			mES= rs.getString("Institutecode")+"***"+mCode+"///"+msid;
			%>
			<OPTION Value=<%=mES%>><%=rs.getString("subject")%></option>
			<%
		}
		%>
		</select>
		<%
	}
	else
	{
		%>
		<Select Name=DataCombo tabindex="0" id="DataCombo" style="WIDTH: 0px">
		<%
		while(rs.next())
		{
			msid=rs.getString("subjectid");
			mCode=rs.getString("examcode");

				mES= rs.getString("Institutecode")+"///"+mCode+"***"+msid;

			if(msid.equals(request.getParameter("Subject").toString().trim()))
 			{
				%>
				<OPTION selected Value=<%=mES%>><%=rs.getString("subject")%></option>
				<%
		     	}
		     	else
		      {
				%>
		      	<OPTION Value=<%=mES%>><%=rs.getString("subject")%></option>
		      	<%
		   	}
		}
		%>
		</select>
	  	<%
	 }
 }
catch(Exception e)
{
	// out.println("Error Msg");
}

//----***************Subject**********************
%>
<FONT color=black face=Arial size=2><b>Subject</b> </FONT>
<%
	qry=" Select Distinct nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,B.subject sbj, nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
	qry=qry+" from  facultysubjecttagging A,SUBJECTMASTER B where  ";
	//qry=qry+"  A.facultytype=decode('"+mDMemberType+"','E','I','E') and ";
	qry=qry+" A.institutecode='"+mInst+"' and A.examcode  in (select examcode from exammaster where nvl(LOCKEXAM,'N')='N' ";
	qry=qry+" and nvl(FINALIZED,'N')='N' and NVL(DEACTIVE,'N')='N' ) AND A.institutecode=B.institutecode AND A.SUBJECTID=B.SUBJECTID";
	qry=qry+" and A.EXAMCODE='"+qryexam+"' order by 2";
	rs=db.getRowset(qry);

%>
	<select name=Subject tabindex="0" id="Subject" style="WIDTH: 330px" onclick="ChangeSubject(Exam.value,Subject.value,DataComboSec,Section,DataComboSub,SubSection);" onChange="ChangeSubject(Exam.value,Subject.value,DataComboSec,Section,DataComboSub,SubSection);">
<%
if (request.getParameter("x")==null)
{
%>
	<OPTION selected Value=ALL>ALL</option>
<%
	qrysubj="ALL";
	while(rs.next())
	{
		if(mSubj1.equals(""))
		{
		  mSubj1=rs.getString("subjectid");

 		%>
			<OPTION Value ='<%=mSubj1%>'><%=rs.getString("subject")%></option>
		<%
		}
		else
		{
 		%>
			<OPTION Value ='<%=rs.getString("subjectid")%>'><%=rs.getString("subject")%></option>
		<%
		}
	}
}
else
{
	if (request.getParameter("Subject").toString().trim().equals("ALL"))
 		{
		qrysubj="ALL";

			%>
	 		<OPTION selected value=ALL>ALL</option>
			<%
		}
		else
		{
			%>
			<OPTION value=ALL>ALL</option>
			<%
		}


		while(rs.next())
		{
			mSubj1=rs.getString("subjectid");
			if (mSubj1.equals(request.getParameter("Subject").toString().trim()))
			{
			qrysubj=mSubj1;
		%>
			<OPTION selected Value ='<%=mSubj1%>'><%=rs.getString("subject")%></option>
		<%
		}
		else
		{
		%>
      		<OPTION Value ='<%=mSubj1%>'><%=rs.getString("subject")%></option>
     		<%
	   	}
	}
  }
%>
</select>
&nbsp;



</td>


<td>
<FONT color=black>&nbsp; <FONT face=Arial size=2><STRONG>&nbsp;&nbsp;LTP :&nbsp</STRONG></FONT></FONT>&nbsp;&nbsp;&nbsp;&nbsp;
<select  name="LTP" id="LTP" style="width:150px">
<%
if(request.getParameter("x")==null)
{

%>
<option  selected value="L">Lecture</option>
<option   value="T">Tutorial</option>
<option   value="P">Practical</option>
<option    value="LT">Lecture+Tutorial</option>
<%
}
else
{
if(request.getParameter("LTP").equals("L"))
{

%>
<option  selected value="L">Lecture</option>
<option   value="T">Tutorial</option>
<option   value="P">Practical</option>
<option    value="LT">Lecture+Tutorial</option>
<%
}
else if(request.getParameter("LTP").equals("T"))
{

%>
<option   value="L">Lecture</option>
<option  selected value="T">Tutorial</option>
<option   value="P">Practical</option>
<option    value="LT">Lecture+Tutorial</option>
<%
}
else if(request.getParameter("LTP").equals("P"))
{

%>
<option   value="L">Lecture</option>
<option   value="T">Tutorial</option>
<option   selected value="P">Practical</option>
<option    value="LT">Lecture+Tutorial</option>

<%
}
else  if(request.getParameter("LTP").equals("LT"))

{

%>
<option   value="L">Lecture</option>
<option   value="T">Tutorial</option>
<option    value="P">Practical</option>
<option  selected  value="LT">Lecture+Tutorial</option>
<%
}
else

{

%>
<option   value="L">Lecture</option>
<option   value="T">Tutorial</option>
<option    value="P">Practical</option>
<option    value="LT">Lecture+Tutorial</option>
<%
}
}
%>
</select></td>

</td></tr><tr>
<td COLSPAN=6 ALIGN=CENTER><BR><INPUT Type="submit" Value="Show/Refresh"></td>
</TR>
<!--end 10/29/2011-->
<!-- <tr><td nowrap colspan=6>
&nbsp;
<marquee  scrolldelay=225 width:700 behavior=alternate><a href="../../Images/PageSetupXL.bmp" Title="Instruction before print a Students List" Target=_New><font size=3 color=Blue><b>Recommended Page Setup: Paper Size - A4 and Top/Bottom Margin - .25</b></font></a></marquee>

</td></tr>
<tr> -->
</table>

        </form>

        <%

		//-----------mohit sharma updated on 20/09/2011-----------------------------


		try
          {
        if(request.getParameter("x") != null) {

        //-----Get request from user ---------------ADDED CODE--------------DATE-30-MARCH-2011-------------InstCode



	if (request.getParameter("TXT1")==null || request.getParameter("TXT1").equals(""))
				mDate1="01-11-2009";
			else
				mDate1=request.getParameter("TXT1").toString().trim();

			if (request.getParameter("TXT2")==null || request.getParameter("TXT2").equals("") || request.getParameter("TXT2").equals("DD-MM-YYYY"))
				mDate2="01-11-2009";
			else
				mDate2=request.getParameter("TXT2").toString().trim();


		if (request.getParameter("TXT3")==null || request.getParameter("TXT3").equals("") ||  request.getParameter("TXT3").equals("DD-MM-YYYY"))
				mDate3="01-11-2009";
			else
				mDate3=request.getParameter("TXT3").toString().trim();


			 if (request.getParameter("InstCode") == null) {
                mInstCode = "";
            } else {
                mInstCode = request.getParameter("InstCode").toString().trim();
            }

	if (request.getParameter("RegCode") == null) {
                mEXAMCODE = "";
            } else {
                mEXAMCODE = request.getParameter("RegCode").toString().trim();
            }


			if (request.getParameter("LTP") == null) {
                mLTP1 = "";
            } else {
                mLTP1 = request.getParameter("LTP").toString().trim();
            }





			if (request.getParameter("Subject") == null) {
                Subject = "";
            } else {
                Subject = request.getParameter("Subject").toString().trim();
            }

String mPROG[]={"ALL"};

mPROG=request.getParameterValues("PROG");

%>
<input type=hidden name="PROG" id="PROG" value="<%=mPROG%>" >
<%

try
{
if(mPROG.equals("") || mPROG==null)
{
mPROG[0]="ALL";
mSubject="ALL";
}
for (int i=0;i<mPROG.length;i++)
{
if(mSubject.equals(""))
mSubject="'"+mPROG[i]+"'";
else
mSubject=mSubject+",'"+mPROG[i]+"'";

/*qry="select 'Y' from TEMP#AttendanceParaProgram where PROGRAMCODE = '"+mSubject+"'";
rs=db.getRowset(qry);
if(rs.next())
{*/
qry1="INSERT INTO TEMP#ATTENDANCEPARAPROGRAM (INSTITUTECODE, EXAMCODE, PROGRAMCODE)VALUES ('"+mInstCode+"','"+mEXAMCODE+"','"+mPROG[i]+"')";
out.print(qry1);
 n=db.insertRow(qry1);



if(n>0)
{
out.print("record saved");



out.print(mInstCode+"--"+mEXAMCODE+"--"+Subject+"--"+mPROG[i]+"----"+mLTP1+"--"+mDate1+"--"+mDate2+"--"+mDate3);

//db.PopulateAttendanceData(mInstCode,mEXAMCODE,Subject,mPROG[i], mLTP1, mDate1,mDate2, mDate3);

//execute webkiosk.PopulateAttendanceData('"+mInstCode+"','"+mEXAMCODE+"','"+Subject+"', '"+mLTP1+"', '"+mDate1+"','"+mDate2+"', '"+mDate3+"');



//db.PopulateAttendanceData(Inst, ExamCode, SubjectID, Program, LTP, T1date, T2date, T3date)
//db.PopulateAttendanceData(Inst, ExamCode, SubjectID, mPROG[i], LTP, T1date, T2date, T3date);
}
else
{
    out.print("error");
}

}


}
//}
catch(Exception e)
{
mSubject="ALL";

out.print("error"+e);
}
if(mSubject.indexOf("ALL")>0)
mSubject="ALL";


			//--------
		
             // out.print(mSubject + "---");
              // session.setAttribute("listorder",mList);


	//if(mDate1.equals)

if(mLTP1.equals("LT"))
			{
mLTP="'L','T'";
			}
else
			{
mLTP="'"+mLTP1+"'";
			}


                 //-------------------------------------------------------------------
%>
				  <br>
	<form >

<input type=hidden name="LTP" id="LTP" value="<%=mLTP1%>">


<input type=hidden name="RegCode" id="RegCode" value="<%=mEXAMCODE%>">



<input type=hidden name="Subject" id="Subject" value="<%=Subject%>">


<table class="sort-table" id="table-1" border=1 cellpadding=0 cellspacing=0 align=center>
		<thead>
				  <tr bgcolor="#ff8c00">
				  <td rowspan=2><b><font color="white">Sr.no.</font></b></td>
                  <td rowspan=2 align=center><b><font color="white" SIZE=1>Subject</font></b></td>

				  <td rowspan=2><b><font color="white" SIZE=1>Co-ordinator</font></b></td>


				  <td align=LEFT COLSPAN=3><b><font color="white" SIZE=1>
				  				 80
				  </td>
                  <td align=LEFT COLSPAN=3><b><font color="white" SIZE=1>
				  70</font></b></td>
                  <td align=LEFT COLSPAN=3><b><font color="white" SIZE=1>
				  60</font></b></td>
                  <td align=LEFT COLSPAN=3><b><font color="white" SIZE=1>
				  50</font></b></td>
                  <td align=LEFT COLSPAN=3 ><b><font color="white" SIZE=1>
				  40</font></b></td>
                  <td align=LEFT COLSPAN=3><b><font color="white" SIZE=1>
				  30</font></b></td>
                  <td align=LEFT  rowspan=2><b><font color="white" SIZE=1 >Total <br> Student</font></b></td>

				  <td rowspan=2><b><font color="white" SIZE=1>Classes<br> Held  <b> (<%=mLTP%>) </b></font></b></td>

                  </tr>

					 <tr bgcolor="#ff8c00">
                                               <td><font color="white" SIZE=1> T1 </td>
												<td><font color="white" SIZE=1>T2 </td>
												<td><font color="white" SIZE=1>T3 </td>

												<td><font color="white" SIZE=1> T1 </td>
												<td><font color="white" SIZE=1>T2 </td>
												<td><font color="white" SIZE=1>T3 </td>

												<td><font color="white" SIZE=1> T1 </td>
												<td><font color="white" SIZE=1>T2 </td>
												<td><font color="white" SIZE=1>T3 </td>

												<td><font color="white" SIZE=1> T1 </td>
												<td><font color="white" SIZE=1>T2 </td>
												<td><font color="white" SIZE=1>T3 </td>

												<td><font color="white" SIZE=1> T1 </td>
												<td><font color="white" SIZE=1>T2 </td>
												<td><font color="white" SIZE=1>T3 </td>

												<td><font color="white" SIZE=1> T1 </td>
												<td><font color="white" SIZE=1>T2 </td>
												<td><font color="white" SIZE=1>T3 </td>




					</tr>

				  </thead>
				  <tbody>
				  <!-- <tr>-->
                  <%



int cc=0;
String mprog1="",mpp="";






qry1="select distinct  programcode from V#StudentAttendance a Where  a.LTP in ("+mLTP+") AND   nvl(Studentdeactive,'N')='N' ";
			if (!mInstCode.equals("ALL")) {
					qry1 = qry1 + " and  a.institutecode='" + mInstCode + "' ";
			}
			if (!mEXAMCODE.equals("ALL")) {
					qry1 = qry1 + "and  a.examcode='" + mEXAMCODE + "' ";
			}
			if(mSubject.equals("ALL"))
            qry1=qry1+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
            else
            qry1=qry1+" and a.programcode in ("+mSubject+")  " ;
		qry1=qry1+" and SUBJECTID=decode('"+Subject+"','ALL',A.SUBJECTID,'"+Subject+"') group by  programcode order by programcode" ;
	//out.print(qry1);
	//a.subjectcode='10B11CI111'  and
	rs=db.getRowset(qry1);
	while(rs.next())
			{
		//mpp=rs.getString("programcode");



if(mpp.equals(""))
mpp=rs.getString("programcode");
else
mpp=mpp+","+rs.getString("programcode")+" ";


			}

//out.print(mpp+"PLPLP");



			qry="select distinct  INSTITUTECODE ,EXAMCODE , SUBJECTID,SUBJECTCODE,Subject from V#StudentAttendance a Where  a.LTP in ("+mLTP+")   and  nvl(Studentdeactive,'N')='N' ";
			if (!mInstCode.equals("ALL")) {
					qry = qry + " and  a.institutecode='" + mInstCode + "' ";
			}
			if (!mEXAMCODE.equals("ALL")) {
					qry = qry + "and  a.examcode='" + mEXAMCODE + "' ";
			}
			if(mSubject.equals("ALL"))
            qry=qry+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
            else
            qry=qry+" and a.programcode in ("+mSubject+")  " ;
		qry=qry+"  and SUBJECTID=decode('"+Subject+"','ALL',A.SUBJECTID,'"+Subject+"')  group by  institutecode , examcode,SUBJECTCODE,Subject,SUBJECTID order by Subject" ;
			rs1=db.getRowset(qry);
		//out.print(qry);
		//and a.SUBJECTCODE in ('10B11EC412','10B11EC312')   AND a.subjectcode = '10B11EC412'
			//if(rs1.getString("SUBJECTCODE").equals("10B11CI401"))  and a.subjectcode='12M1NEC231'    ,count(distinct CLASSTIMEFROM) totcalsses,count(distinct studentid) totstudents and a.subjectcode='10B11CI111'
			while (rs1.next())
			{





	/* rsum80t1=0;
	 rsum80t2=0;
	 rsum80t3=0;
	 ssum70t1=0;
	 ssum70t2=0;
	 ssum70t3=0;
	 tsum60t1=0;
	 tsum60t2=0;
	 tsum60t3=0;

					usum50t1=0;
					usum50t2=0;
					usum50t3=0;
					vsum40t1=0;
					vsum40t2=0;
					vsum40t3=0;
					wsum30t1=0;
					wsum30t2=0;
					wsum30t3=0;*/

//--------- TOTAL CLASSES-------------------

qryx=" select count(distinct CLASSTIMEFROM)totcalsses1,institutecode , examcode,SUBJECTCODE,SUBSECTIONCODE,Subject,SUBJECTID from V#StudentAttendance a Where  a.LTP in ("+mLTP+")  and subjectid='" +rs1.getString("SUBJECTID")+ "' " +
        "and a.institutecode='" +rs1.getString("institutecode")+ "'  and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";
			if(mSubject.equals("ALL"))
            qryx=qryx+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
            else
            qryx=qryx+"  and a.programcode in ("+mSubject+")   " ;
			qryx=qryx+"and nvl(Studentdeactive,'N')='N'  and nvl(deactive,'N')='N'  and attendancetype in ('E','R') group by institutecode , examcode,SUBJECTCODE,SUBSECTIONCODE,Subject,SUBJECTID  ,    employeeid ";
			rsx=db.getRowset(qryx);
	//	out.print(qryx);
			int TotalClassCount=0 ,TotalClassCount1=0 ,uu=0;


			while (rsx.next())
			{ uu++;

				TotalClassCount1=TotalClassCount1+rsx.getInt("totcalsses1");

				TotalClassCount=TotalClassCount1/uu;
				//out.print(TotalClassCount);
				//TotalClassCount++;
			}

//---------------------------------------------------------------



//------------------------------------------------------


			qryt=" select count(distinct studentid) totstudents1 from V#StudentAttendance a Where  a.LTP in ("+mLTP+") and subjectid='" +rs1.getString("SUBJECTID")+ "'    and a.institutecode='" +rs1.getString("institutecode")+ "'  and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";
		//	qryt=qryt+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('','dd-mm-yyyy')))";
			//		qryt=qryt+" and trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy'))) ";
			if(mSubject.equals("ALL"))
            qryt=qryt+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
            else
            qryt=qryt+"  and a.programcode in ("+mSubject+")   " ;

			qryt=qryt+"and nvl(Studentdeactive,'N')='N'  and nvl(deactive,'N')='N' and attendancetype in ('E','R')         group by a.SUBSECTIONCODE   ,    employeeid        ";
			rst=db.getRowset(qryt);
		//	out.print(qryt);
			int TotalStud1=0  ;
			while (rst.next())
			{


					TotalStud1=TotalStud1+rst.getInt("totstudents1");
//out.print(TotalStud1);
				//	if(TotalStud1!=0)
				//		TotalStud1++;

			}

/*

qryt=" select count(distinct studentid) totstudents2 from V#StudentAttendance a Where  a.LTP in ("+mLTP+") and subjectid='" +rs1.getString("SUBJECTID")+ "'    and a.institutecode='" +rs1.getString("institutecode")+ "'  and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";
			qryt=qryt+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('','dd-mm-yyyy')))";
					qryt=qryt+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy'))) ";
			if(mSubject.equals("ALL"))
            qryt=qryt+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
            else
            qryt=qryt+"  and a.programcode in ("+mSubject+")   " ;

			qryt=qryt+"and nvl(Studentdeactive,'N')='N' and attendancetype in ('E','R') ";
			rst=db.getRowset(qryt);
			//out.print(qryt);
			int TotalStud2=0  ;
			while (rst.next())
			{


					TotalStud2=rst.getInt("totstudents2");

				//	if(TotalStud2!=0)
				//		TotalStud2++;

			}



qryt=" select count(distinct studentid) totstudents3 from V#StudentAttendance a Where  a.LTP in ("+mLTP+") and subjectid='" +rs1.getString("SUBJECTID")+ "'    and a.institutecode='" +rs1.getString("institutecode")+ "'  and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";
			qryt=qryt+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('','dd-mm-yyyy')))";
					qryt=qryt+" and trunc(decode(to_date('"+mDate3+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate3+"','dd-mm-yyyy'))) ";
			if(mSubject.equals("ALL"))
            qryt=qryt+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
            else
            qryt=qryt+"  and a.programcode in ("+mSubject+")   " ;

			qryt=qryt+" and nvl(Studentdeactive,'N')='N' and attendancetype in ('E','R') ";
			rst=db.getRowset(qryt);
		//	out.print(qryt);
			int TotalStud3=0  ;
			while (rst.next())
			{


					TotalStud3=rst.getInt("totstudents3");

				//	if(TotalStud3!=0)
				//		TotalStud3++;

			}

*/
//---------------------------------------------------------------------------------------------------------------------------


			int CNTL80T1s=0  ;
			int CNTL80T1=0 ,CCNTL70T1=0 ,CCNTL70T2=0,CCNTL70T3=0,CNTL60T3=0,CNTL50T3=0,CNTL40T3=0,CNTL30T3=0;

			int CNTL80T2s=0  ;
			int CNTL80T2=0  ;

				int CNTL60T2s=0,CNTL60T1=0, CNTL50T1=0,CNTL40T1=0,CNTL30T1=0;
				int CNTL60T2=0, CNTL70T2=0, CNTL50T2=0,CNTL40T2=0, CNTL30T2=0 ;

			String mStud80="";


			qrys="select distinct institutecode , examcode,SUBJECTCODE,Subject,SUBJECTID,SUBSECTIONCODE,employeeid,semestertype, count(distinct CLASSTIMEFROM) totcalsses from V#StudentAttendance a Where  a.LTP in ("+mLTP+") and subjectid='" +rs1.getString("SUBJECTID")+ "'    and a.institutecode='" +rs1.getString("institutecode")+ "'  and a.examcode='" +rs1.getString("EXAMCODE")+ "' and a.attendancetype in ('E','R')  and nvl(Studentdeactive,'N')='N'  ";

			if(mSubject.equals("ALL"))
            qrys=qrys+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
            else
            qrys=qrys+" and a.programcode in ("+mSubject+") and nvl(Studentdeactive,'N')='N'  " ;

				qrys=qrys+" AND TRUNC (a.attendancedate) BETWEEN TRUNC(DECODE (TO_DATE ('',  'dd-mm-yyyy'),'', a.attendancedate,TO_DATE ('','dd-mm-yyyy'                                        ))                                               )                                      AND TRUNC                                              (DECODE (TO_DATE ('"+mDate1+"',                                                                'dd-mm-yyyy'                                                               ),                                                       '', a.attendancedate,                                                       TO_DATE ('"+mDate1+"',             'dd-mm-yyyy'                                                               )                                                      )                                              ) ";
			qrys=qrys+" and  nvl(deactive,'N')='N'  group by  institutecode , examcode,SUBJECTCODE,Subject,SUBJECTID,SUBSECTIONCODE,employeeid ,semestertype order by SUBSECTIONCODE" ;
	//out.print(qrys);
				rs2=db.getRowset(qrys);


			while (rs2.next())
				{

						CNTL80T1s=rs2.getInt("totcalsses");



							qryt=" select   studentid,count(*)noofclass from V#StudentAttendance a Where   a.LTP in ("+mLTP+") and subjectid='" +rs1.getString("SUBJECTID")+ "' and a.semestertype='"+rs2.getString("semestertype")+"' and a.employeeid='"+rs2.getString("employeeid")+"' and a.SUBSECTIONCODE='"+rs2.getString("SUBSECTIONCODE")+"'  and a.institutecode='" +rs1.getString("institutecode")+ "'  and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";
			qryt=qryt+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('','dd-mm-yyyy')))";
			qryt=qryt+" and trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy'))) ";
					if(mSubject.equals("ALL"))
            qryt=qryt+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
            else
            qryt=qryt+"  and a.programcode in ("+mSubject+")   " ;

			qryt=qryt+"   and attendancetype in ('E','R') and nvl(present,'N')='Y' and nvl(Studentdeactive,'N')='N' and  nvl(deactive,'N')='N' group by  studentid ";
			rst=db.getRowset(qryt);
	//out.print(qryt);

			while (rst.next())
			{
		 		if  (((rst.getInt("noofclass")*100)/CNTL80T1s)<80)
					{
						CNTL80T1++;

//out.print("<br>"+rst.getInt("noofclass")+"___"+CNTL80T1s+"_____"+CNTL80T1);
					//	out.print("<br>"+CNTL80T1);
					}
				if(((rst.getInt("noofclass")*100)/CNTL80T1s)<70)
				{
					CCNTL70T1++;
				}

					if (((rst.getInt("noofclass")*100)/CNTL80T1s)<60)
				{
					CNTL60T1++;
				}

					if (((rst.getInt("noofclass")*100)/CNTL80T1s)<60)
				{
					CNTL50T1++;
				}

					if (((rst.getInt("noofclass")*100)/CNTL80T1s)<60)
				{
					CNTL40T1++;
				}

					if (((rst.getInt("noofclass")*100)/CNTL80T1s)<60)
				{
					CNTL30T1++;
				}
			}

		}



		//		}


//CNTL80T1=0;



	qrys="select distinct  SUBSECTIONCODE,employeeid,institutecode ,semestertype, examcode,SUBJECTCODE,Subject,SUBJECTID, count(distinct CLASSTIMEFROM) totcalsses from V#StudentAttendance a Where   a.LTP in ("+mLTP+") and subjectid='" +rs1.getString("SUBJECTID")+ "'    and a.institutecode='" +rs1.getString("institutecode")+ "'  and a.examcode='" +rs1.getString("EXAMCODE")+ "' and  nvl(a.deactive,'N')='N' and nvl(Studentdeactive,'N')='N' and attendancetype in ('E','R')   ";

			if(mSubject.equals("ALL"))
            qrys=qrys+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
            else
            qrys=qrys+" and a.programcode in ("+mSubject+")  " ;

				qrys=qrys+" AND TRUNC (a.attendancedate) BETWEEN TRUNC(DECODE (TO_DATE ('',  'dd-mm-yyyy'),'', a.attendancedate,TO_DATE ('','dd-mm-yyyy'                                        ))                                               )                                      AND TRUNC                                              (DECODE (TO_DATE ('"+mDate2+"',                                                                'dd-mm-yyyy'                                                               ),                                                       '', a.attendancedate,                                                       TO_DATE ('"+mDate2+"',             'dd-mm-yyyy'                                                               )                                                      )                                              ) ";
			qrys=qrys+"  group by  institutecode , examcode,SUBJECTCODE,Subject,SUBJECTID,SUBSECTIONCODE,employeeid,semestertype order by SUBSECTIONCODE" ;
			//out.print(qrys);
				rs2=db.getRowset(qrys);

			while (rs2.next())
				{
						CNTL80T2s=rs2.getInt("totcalsses");




	qryt=" select studentid,count(*)noofclass from V#StudentAttendance a Where  a.LTP in ("+mLTP+") and subjectid='" +rs1.getString("SUBJECTID")+ "' and a.semestertype='"+rs2.getString("semestertype")+"' and  a.institutecode='" +rs1.getString("institutecode")+ "' and a.employeeid='"+rs2.getString("employeeid")+"' and a.SUBSECTIONCODE='"+rs2.getString("SUBSECTIONCODE")+"'  and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";
			qryt=qryt+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('','dd-mm-yyyy')))";
					qryt=qryt+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))  ";

			if(mSubject.equals("ALL"))
            qryt=qryt+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
            else
            qryt=qryt+"  and a.programcode in ("+mSubject+")   " ;

			qryt=qryt+"and nvl(present,'N')='Y' and nvl(Studentdeactive,'N')='N' and  nvl(a.deactive,'N')='N' and attendancetype in ('E','R')  group by studentid ";
			rst=db.getRowset(qryt);
		//	out.print(qryt);

			while (rst.next())
			{

				//if  (rst.getInt("noofclass")>(rs1.getInt("totcalsses")*rs1.getInt("totstudents")*80/100)){
				if  (((rst.getInt("noofclass")*100)/CNTL80T2s)<80)
					{
						CNTL80T2++;
					//	out.print("jhj"+rst.getInt("noofclass")+"ljklj"+rs1.getInt("totcalsses"));
					}
						if   (((rst.getInt("noofclass")*100)/CNTL80T2s)<70)
					{
						CCNTL70T2++;
					}
						if   (((rst.getInt("noofclass")*100)/CNTL80T2s)<70)
					{
						CNTL60T2++;
					}

						if   (((rst.getInt("noofclass")*100)/CNTL80T2s)<70)
					{
						CNTL50T2++;
					}

							if   (((rst.getInt("noofclass")*100)/CNTL80T2s)<70)
					{
						CNTL40T2++;
					}

							if   (((rst.getInt("noofclass")*100)/CNTL80T2s)<70)
					{
						CNTL30T2++;
					}
//out.print("jhj"+rst.getInt("noofclass")+"ljklj"+rs1.getInt("totcalsses"));
			}


				}




	qrys="select distinct  SUBSECTIONCODE,employeeid,institutecode , examcode,SUBJECTCODE,Subject,SUBJECTID, semestertype,count(distinct CLASSTIMEFROM) totcalsses,SUBSECTIONCODE from V#StudentAttendance a Where   a.LTP in ("+mLTP+") and subjectid='" +rs1.getString("SUBJECTID")+ "'    and a.institutecode='" +rs1.getString("institutecode")+ "'  and a.examcode='" +rs1.getString("EXAMCODE")+ "'  and  nvl(a.deactive,'N')='N' and nvl(Studentdeactive,'N')='N' and attendancetype in ('E','R')  ";
			if(mSubject.equals("ALL"))
            qrys=qrys+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
            else
            qrys=qrys+" and a.programcode in ("+mSubject+")   " ;
				qrys=qrys+" AND TRUNC (a.attendancedate) BETWEEN TRUNC(DECODE (TO_DATE ('',  'dd-mm-yyyy'),'', a.attendancedate,TO_DATE ('','dd-mm-yyyy'                                        ))                                               )                                      AND TRUNC                                              (DECODE (TO_DATE ('"+mDate3+"',                                                                'dd-mm-yyyy'                                                               ),                                                       '', a.attendancedate,                                                       TO_DATE ('"+mDate3+"',             'dd-mm-yyyy'                                                               )                                                      )                                              ) ";
			qrys=qrys+"  group by  institutecode , examcode,SUBJECTCODE,Subject,SUBJECTID, SUBSECTIONCODE,semestertype,employeeid order by SUBJECTCODE,Subject" ;

			//out.print(qrys);
				rs2=db.getRowset(qrys);
			int CNTL80T3s=0  ;
				int CNTL80T3=0  ;
			while (rs2.next())
			{
						CNTL80T3s=rs2.getInt("totcalsses");


						qryt=" select studentid,count(*)noofclass,SUBSECTIONCODE from V#StudentAttendance a Where  a.LTP in ("+mLTP+") and subjectid='" +rs1.getString("SUBJECTID")+ "' and a.semestertype='"+rs2.getString("semestertype")+"' and a.employeeid='"+rs2.getString("employeeid")+"' and a.SUBSECTIONCODE='"+rs2.getString("SUBSECTIONCODE")+"'  and a.SUBSECTIONCODE='" +rs2.getString("SUBSECTIONCODE")+ "'    and a.institutecode='" +rs1.getString("institutecode")+ "'  and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";
			qryt=qryt+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('','dd-mm-yyyy')))";
			qryt=qryt+" and trunc(decode(to_date('"+mDate3+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate3+"','dd-mm-yyyy')))";

			if(mSubject.equals("ALL"))
            qryt=qryt+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
            else
            qryt=qryt+"  and a.programcode in ("+mSubject+")   " ;

			qryt=qryt+"and nvl(present,'N')='Y' and nvl(Studentdeactive,'N')='N' and  nvl(a.deactive,'N')='N' and attendancetype in ('E','R') group by studentid,SUBSECTIONCODE ";
			rst=db.getRowset(qryt);
		//	out.print(qryt);

			while (rst.next())
			{

				//if  (rst.getInt("noofclass")>(rs1.getInt("totcalsses")*rs1.getInt("totstudents")*80/100)){
				if  (((rst.getInt("noofclass")*100)/CNTL80T3s)<80)
					{
						CNTL80T3++;
					}
						if   (((rst.getInt("noofclass")*100)/CNTL80T3s)<70)
				{
					CCNTL70T3++;
				}

					if   (((rst.getInt("noofclass")*100)/CNTL80T3s)<70)
				{
					CNTL60T3++;
				}
					if   (((rst.getInt("noofclass")*100)/CNTL80T3s)<70)
				{
					CNTL50T3++;
				}
					if   (((rst.getInt("noofclass")*100)/CNTL80T3s)<70)
				{
					CNTL40T3++;
				}
					if   (((rst.getInt("noofclass")*100)/CNTL80T3s)<70)
				{
					CNTL30T3++;
				}
//out.print("jhj"+rst.getInt("noofclass")+"ljklj"+rs1.getInt("totcalsses"));
			}
		}
	        %>
				    <tr><td><B><%=++count%></B></td>


					<td align=left ><FONT SIZE="2" >

					> <a href="DateWiseAttendancePerDetail.jsp?ViewType=CNF&amp;INSTITUTE=<%=mInstCode%>&amp;EXAMCODE=<%=mEXAMCODE%>&amp;PROGRAMCODE=<%=mSubject%>&amp;LTP=<%=mLTP%>&amp;SUBJECTCODE=<%=rs1.getString("SUBJECTCODE")%>&amp;SUBJECT=<%=rs1.getString("Subject")%>&amp;SUBJECTID=<%=rs1.getString("SUBJECTID")%>&amp;FLAG=80&amp;Date1=<%=mDate1%>&amp;Date2=<%=mDate2%>&amp;Date3=<%=mDate3%>" target=_new>

					<%=rs1.getString("Subject")%>(<%=rs1.getString("SUBJECTCODE")%>) - ( <%=mpp%> )
					</a>
					</td>


					<%
	qryc="SELECT COORDINATORCODE,COORDINATORNAME  from V#EX#SUBJECTGRADECOORDINATOR where LTP in ("+mLTP+" ) and subjectcode='"+rs1.getString("SUBJECTCODE")+"' ";

			if (!mInstCode.equals("ALL")) {
			    qryc = qryc + " and  institutecode='" + mInstCode + "' ";
			}
			if (!mEXAMCODE.equals("ALL")) {
				qryc = qryc + "and  examcode='" + mEXAMCODE + "' ";
					}

			if(mSubject.equals("ALL"))
qryc=qryc+"  and programcode = decode(programcode ,'ALL','ALL', programcode )  " ;
else
qryc=qryc+"  and programcode in ("+mSubject+")   " ;

				rsc=db.getRowset(qryc);
				//out.print(qryc);
				//	if(rs1.getString("SUBJECTCODE").equals("10B11CI401"))

			if (rsc.next())
				{
                %>
				<td><FONT SIZE="1" ><%=rsc.getString("COORDINATORNAME")%></td>
<%
}else{
%>
<td><font SIZE=2 color="red">Not Define</font></td>

<%
}

%>

    <td ALIGN=LEFT><%=CNTL80T1%> </a></td>


 <td ALIGN=LEFT><%=CNTL80T2%></a></td>


 <td ALIGN=LEFT><%=CNTL80T3%></a></td>


    <td ALIGN=LEFT><%=CCNTL70T1%></a></td>

<td ALIGN=LEFT><%=CCNTL70T2%></a></td>


<td ALIGN=LEFT><%=CCNTL70T3%></a></td>





<td ALIGN=LEFT><%=CNTL60T1%> </a></td>
<td ALIGN=LEFT><%=CNTL60T2%> </a></td>
<td ALIGN=LEFT><%=CNTL60T3%> </a></td>



<td ALIGN=LEFT> <%=CNTL50T1%> </a></td>
<td ALIGN=LEFT> <%=CNTL50T2%> </a></td>
<td ALIGN=LEFT> <%=CNTL50T3%> </a></td>


    <td ALIGN=LEFT> <%=CNTL40T1%> </a></td>
	<td ALIGN=LEFT> <%=CNTL40T2%> </a></td>
    <td ALIGN=LEFT> <%=CNTL40T3%> </a></td>




    <td ALIGN=LEFT><%=CNTL30T1%> </a></td>
    <td ALIGN=LEFT><%=CNTL30T2%> </a></td>


    <td ALIGN=LEFT><%=CNTL30T3%> </a></td>



                    <%



				rsum80t1=((CNTL80T1)+(rsum80t1));
				rsum80t2=((CNTL80T2)+(rsum80t2));
				rsum80t3=((CNTL80T3)+(rsum80t3));

				ssum70t1=((CCNTL70T1)+(ssum70t1));
				ssum70t2=((CCNTL70T2)+(ssum70t2));
				ssum70t3=((CCNTL70T3)+(ssum70t3));

				tsum60t1=((CNTL60T1)+(tsum60t1));
				tsum60t2=((CNTL60T2)+(tsum60t2));
				tsum60t3=((CNTL60T3)+(tsum60t3));

				usum50t1=((CNTL50T1)+(usum50t1));
				usum50t2=((CNTL50T2)+(usum50t2));
				usum50t3=((CNTL50T3)+(usum50t3));

				 vsum40t1=((CNTL40T1)+(vsum40t1));
				 vsum40t2=((CNTL40T2)+(vsum40t2));
				 vsum40t3=((CNTL40T3)+(vsum40t3));

				 wsum30t1=((CNTL30T1)+(wsum30t1));
				 wsum30t2=((CNTL30T2)+(wsum30t2));
				 wsum30t3=((CNTL30T3)+(wsum30t3));

				 	ttsum1=TotalStud1+ttsum1;
		//	ttsum2=TotalStud2+ttsum2;
		//	ttsum3=TotalStud3+ttsum3;


               //
                //    tsum=((CNTL60)+(tsum));
                 //   usum=((CNTL50)+(usum));
                  //  vsum=((CNTL40)+(vsum));
              //      wsum=((CNTL30)+(wsum));

//			  out.print(TotalStud2+" : :");
                    %>
					  <td align="LEFT"><font color="green"><%=TotalStud1%></font> </td>


					                    <td align="LEFT"><font color="green"><%=TotalClassCount%></font> </td>


					</tr>
                    <%
                    //----------------ADDED CODE----------------- ON/27-apl-2011
                    }
                //    rsum=((rsum)-(count));
                 //   ssum=((ssum)-(count));
                  //  tsum=((tsum)-(count));
                 //   usum=((usum)-(count));
                  //  vsum=((vsum)-(count));
                   // wsum=((wsum)-(count));

				   //	int rsum80t1=0,rsum80t2=0,rsum80t3=0,ssum70t1=0,ssum70t2=0,ssum70t3=0,tsum60t1=0,tsum60t2=0,tsum60t3=0,
//					usum50t1=0,usum50t2=0,usum50t3=0,vsum40t1=0,vsum40t2=0,vsum40t3=0,wsum30t1=0,wsum30t2=0,wsum30t3=0;
					%>
                    <tr><td></td><td></td><td align="left"><STRONG>Total Count(% Wise):</STRONG></td><td><font color="red"><%=rsum80t1%></font></td>
                    <td><font color="red"><%=rsum80t2%></font> </td>
					 <td><font color="red"><%=rsum80t3%></font> </td>

					<td><font color="red"><%=ssum70t1%></font> </td>
					<td><font color="red"><%=ssum70t2%></font> </td>
					<td><font color="red"><%=ssum70t3%></font> </td>

                    <td><font color="red"><%=tsum60t1%></font> </td>
                    <td><font color="red"><%=tsum60t2%></font> </td>
                    <td><font color="red"><%=tsum60t3%></font> </td>

					    <td><font color="red"><%=usum50t1%></font> </td>
						  <td><font color="red"><%=usum50t2%></font> </td>
						    <td><font color="red"><%=usum50t3%></font> </td>

				    <td><font color="red"><%=vsum40t1%></font> </td>
					    <td><font color="red"><%=vsum40t2%></font> </td>
						    <td><font color="red"><%=vsum40t3%></font> </td>

							  <td><font color="red"><%=wsum30t1%></font> </td>
							    <td><font color="red"><%=wsum30t2%></font> </td>
								  <td><font color="red"><%=wsum30t3%></font> </td>



  <td><font color="red"><%=ttsum1%></font> </td>


					</tr>
					</tbody>
					</table>
					<form><CENTER>
					<input type="button" value=" Print this page "
                    onclick="window.print();return false;" /></CENTER>
					</form>
					<script type="text/javascript">
					var st1 = new SortableTable(document.getElementById("table-1"),["CaseInsensitiveString","CaseInsensitiveString","Number","Number","Number","Number","Number"]);
					</script>
					<%
					}
					%>
					<%
					}catch(Exception e)
					{
					//out.print(e);
					}
					%>
					</body>
					</html>

