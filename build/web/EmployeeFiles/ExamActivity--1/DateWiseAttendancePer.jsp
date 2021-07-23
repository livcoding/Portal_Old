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
        String qry = "" ,qryc="",mSUBB="",mSUBN="", mLTP="";
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
		String mBranchCode = "";
		String mInst="",mSubject="",minst="" ;
		int rsum80t1=0,rsum80t2=0,rsum80t3=0,ssum70t1=0,ssum70t2=0,ssum70t3=0,tsum60t1=0,tsum60t2=0,tsum60t3=0,
					usum50t1=0,usum50t2=0,usum50t3=0,vsum40t1=0,vsum40t2=0,vsum40t3=0,wsum30t1=0,wsum30t2=0,wsum30t3=0;
		int count=0 ,Flag=0;

		
					
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
<select name="InstCode" tabindex="1" id="InstCode" style="WIDTH: 150px"
onclick="ChangeOptions(InstCode.value,DataRegCode,RegCode);"
onChange="ChangeOptions(InstCode.value,DataRegCode,RegCode);">

<%
while(rs.next())
{
mInst=rs.getString("InstCode");
if(mInst.equals(""))
minst=mInst;
%>
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
&nbsp;<select name="InstCode" tabindex="1" id="InstCode" style="WIDTH: 150px">
<option  selected value="ALL">ALL</option>
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

//      Section Branch    //

%>


</td>
<td>
<%
ResultSet rsfd=null ;
String mReg="",mReg1="";
qry = " Select REGCODE RegCode, ExamCode EXAMCODE, EXAMPERIODFROM,INSTITUTECODE FROM (";
				qry += " Select A.REGCODE REGCODE, A.ExamCode ExamCode, B.EXAMPERIODFROM EXAMPERIODFROM,b.INSTITUTECODE from StudentRegistration A, ExamMaster B";
				qry += " Where A.INSTITUTECODE=B.INSTITUTECODE  AND NVL(LOCKEXAM,'N')='N' and A.EXAMCODE=B.EXAMCODE  AND nvl(B.Deactive,'N')='N'";
				qry += " Group By A.REGCODE, A.ExamCode, B.EXAMPERIODFROM,b.INSTITUTECODE order by EXAMPERIODFROM DESC) where rownum<=10 order by 3 desc";
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
//qry = "SELECT DISTINCT EXAMCODE FROM exammaster WHERE NVL (deactive, 'N') = 'N' ORDER BY EXAMCODE";
qry = " Select REGCODE RegCode, Exam, EXAMPERIODFROM FROM (";
				qry += " Select A.REGCODE REGCODE, A.ExamCode Exam, B.EXAMPERIODFROM EXAMPERIODFROM from StudentRegistration A, ExamMaster B";
				qry += " Where A.INSTITUTECODE=B.INSTITUTECODE  AND NVL(LOCKEXAM,'N')='N' and A.EXAMCODE=B.EXAMCODE  AND nvl(B.Deactive,'N')='N'";
				qry += " Group By A.REGCODE, A.ExamCode, B.EXAMPERIODFROM order by EXAMPERIODFROM DESC) where rownum<=10 order by 3 desc";
			//	out.print(qry);
rs = db.getRowset(qry);
try{
		if (request.getParameter("x") == null) 
					{
                        	%>
	                        <select  name="RegCode" id="RegCode" 
onclick="ChangeOptions1(InstCode.value,RegCode.value);"
onChange="ChangeOptions1(InstCode.value,RegCode.value);"
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
onclick="ChangeOptions1(InstCode.value,RegCode.value);"
onChange="ChangeOptions1(InstCode.value,RegCode.value);"
style="width:150px">
<option  selected value="ALL">ALL</option>
					<%
					while (rs.next())
					{
                                   	mExam = rs.getString("Exam");
	                        	if (mExam.equals(request.getParameter("RegCode").toString().trim())) 
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

 <FONT face=Arial size=2><STRONG>T1 Date:&nbsp</STRONG></FONT>
</font>&nbsp;<input Name="TXT1" Id="TXT1" Type=text maxlength=10 size=12 value='<%=mDate1%>' onclick="Clear(this);">

</td>

<td>


 <FONT face=Arial size=2><STRONG>T2 Date:&nbsp</STRONG></FONT>
&nbsp;<input Name="TXT2" Id="TXT2" Type=text maxlength=10 size=12 value='<%=mDate2%>' onclick="Clear(this);">
</td>

<td>

 <FONT face=Arial size=2><STRONG>T3 Date:&nbsp</STRONG></FONT>
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
<td>
<FONT color=black>&nbsp; <FONT face=Arial size=2><STRONG>&nbsp;&nbsp;LTP :&nbsp</STRONG></FONT></FONT>&nbsp;&nbsp;&nbsp;&nbsp;<select  name="LTP" id="LTP" style="width:150px">

<option  selected value="L">Lecture</option>
<option   value="T">Tutorial</option>
<option   value="P">Practical</option>

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

          
			 if (request.getParameter("InstCode") == null) {
                mInstCode = "";
            } else {
                mInstCode = request.getParameter("InstCode").toString().trim();
            }
			
			
			
			if (request.getParameter("LTP") == null) {
                mLTP = "";
            } else {
                mLTP = request.getParameter("LTP").toString().trim();
            }
                
			
		if (request.getParameter("TXT1")==null || request.getParameter("TXT1").equals(""))
				mDate1="";
			else
				mDate1=request.getParameter("TXT1").toString().trim();

			if (request.getParameter("TXT2")==null || request.getParameter("TXT2").equals(""))
				mDate2="";
			else
				mDate2=request.getParameter("TXT2").toString().trim();

			
		if (request.getParameter("TXT3")==null || request.getParameter("TXT3").equals(""))
				mDate3="";
			else
				mDate3=request.getParameter("TXT3").toString().trim();

		
			
			/*if (request.getParameter("PROG") == null) {
                mPROG = "";
            } else {
                mPROG = request.getParameter("PROG").toString().trim();
            }*/

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
}
}
catch(Exception e)
{
mSubject="ALL";
}
if(mSubject.indexOf("ALL")>0)
mSubject="ALL";

	
			//--------
			if (request.getParameter("RegCode") == null) {
                mEXAMCODE = "";
            } else {
                mEXAMCODE = request.getParameter("RegCode").toString().trim();
            }
           
             // out.print(mSubject + "---");
              // session.setAttribute("listorder",mList);
						
                 //-------------------------------------------------------------------
%>
				  <br>
				 
<table class="sort-table" id="table-1" border=1 cellpadding=0 cellspacing=0 align=center>
		<thead>
				  <tr bgcolor="#ff8c00">
				  <td rowspan=2><b><font color="white">Sr.no.</font></b></td>
                  <td rowspan=2 align=center><b><font color="white" SIZE=1>Subject</font></b></td>
				 
				  <td rowspan=2><b><font color="white" SIZE=1>Co-ordinator</font></b></td>
				
				
				  <td align=LEFT COLSPAN=3  ><b><font color="white" SIZE=1>
				  				 80
				  </td>
                  <td align=LEFT COLSPAN=3 ><b><font color="white" SIZE=1>
				  70</font></b></td>
                  <td align=LEFT COLSPAN=3  ><b><font color="white" SIZE=1>
				  60</font></b></td>
                  <td align=LEFT COLSPAN=3 ><b><font color="white" SIZE=1>
				  50</font></b></td>
                  <td align=LEFT COLSPAN=3  ><b><font color="white" SIZE=1>
				  40</font></b></td>
                  <td align=LEFT COLSPAN=3 ><b><font color="white" SIZE=1>
				  30</font></b></td>
                  <td align=LEFT  COLSPAN=3  ><b><font color="white" SIZE=1 >Total Student</font></b></td>
			
				  <td rowspan=2><b><font color="white" SIZE=1>Classes Held</font></b></td>
				
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

					
												<td><font color="white" SIZE=1> T1 </td>
												<td><font color="white" SIZE=1>T2 </td>
												<td><font color="white" SIZE=1>T3 </td>

					</tr>

				  </thead>
				  <tbody>
				  <!-- <tr>-->
                  <%

String qryx="";
	ResultSet rsx=null;

			qry="select distinct  INSTITUTECODE ,EXAMCODE , SUBJECTID,SUBJECTCODE,Subject,count(distinct CLASSTIMEFROM) totcalsses,count(distinct studentid) totstudents from V#StudentAttendance a Where  a.LTP='"+mLTP+"'  ";
			if (!mInstCode.equals("ALL")) {
					qry = qry + " and  a.institutecode='" + mInstCode + "' ";
			}
			if (!mEXAMCODE.equals("ALL")) {
					qry = qry + "and  a.examcode='" + mEXAMCODE + "' ";
			}
			if(mSubject.equals("ALL"))
            qry=qry+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
            else
            qry=qry+" and a.programcode in ("+mSubject+") and nvl(Studentdeactive,'N')='N'  " ;
			qry=qry+" group by  institutecode , examcode,SUBJECTCODE,Subject,SUBJECTID order by SUBJECTCODE,Subject" ;
			rs1=db.getRowset(qry);
		//out.print(qry);
			//if(rs1.getString("SUBJECTCODE").equals("10B11CI401"))
			while (rs1.next())      
			{ 		


//--------- TOTAL CLASSES-------------------

qryx=" select count(distinct studentid)totcalsses1 from V#StudentAttendance a Where  a.LTP='"+mLTP+"' and subjectid='" +rs1.getString("SUBJECTID")+ "' and a.institutecode='" +rs1.getString("institutecode")+ "'  and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";	
			if(mSubject.equals("ALL"))
            qryx=qryx+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
            else
            qryx=qryx+"  and a.programcode in ("+mSubject+")   " ;
			qryx=qryx+"and nvl(Studentdeactive,'N')='N'  ";
			rsx=db.getRowset(qryx);
		//	out.print(qryt);
			int TotalClassCount=0  ;

			
			while (rsx.next())      
			{ 
		 		
				TotalClassCount=rsx.getInt("totcalsses1");
				TotalClassCount++;
			}

//---------------------------------------------------------------



//------------------------------------------------------


			qryt=" select count(distinct studentid) totstudents1 from V#StudentAttendance a Where  a.LTP='"+mLTP+"' and subjectid='" +rs1.getString("SUBJECTID")+ "'    and a.institutecode='" +rs1.getString("institutecode")+ "'  and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";	
			qryt=qryt+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('','dd-mm-yyyy')))";
					qryt=qryt+" and trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy'))) ";			
			if(mSubject.equals("ALL"))
            qryt=qryt+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
            else
            qryt=qryt+"  and a.programcode in ("+mSubject+")   " ;
			
			qryt=qryt+"and nvl(Studentdeactive,'N')='N' ";
			rst=db.getRowset(qryt);
		//	out.print(qryt);
			int TotalStud1=0  ;
			while (rst.next())      
			{ 
		 		
			
					TotalStud1=rst.getInt("totstudents1");
						TotalStud1++;
				
			}



qryt=" select count(distinct studentid) totstudents2 from V#StudentAttendance a Where  a.LTP='"+mLTP+"' and subjectid='" +rs1.getString("SUBJECTID")+ "'    and a.institutecode='" +rs1.getString("institutecode")+ "'  and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";	
			qryt=qryt+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('','dd-mm-yyyy')))";
					qryt=qryt+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy'))) ";			
			if(mSubject.equals("ALL"))
            qryt=qryt+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
            else
            qryt=qryt+"  and a.programcode in ("+mSubject+")   " ;
			
			qryt=qryt+"and nvl(Studentdeactive,'N')='N' ";
			rst=db.getRowset(qryt);
		//	out.print(qryt);
			int TotalStud2=0  ;
			while (rst.next())      
			{ 
		 		
			
					TotalStud2=rst.getInt("totstudents2");
						TotalStud2++;
				
			}



qryt=" select count(distinct studentid) totstudents3 from V#StudentAttendance a Where  a.LTP='"+mLTP+"' and subjectid='" +rs1.getString("SUBJECTID")+ "'    and a.institutecode='" +rs1.getString("institutecode")+ "'  and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";	
			qryt=qryt+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('','dd-mm-yyyy')))";
					qryt=qryt+" and trunc(decode(to_date('"+mDate3+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate3+"','dd-mm-yyyy'))) ";			
			if(mSubject.equals("ALL"))
            qryt=qryt+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
            else
            qryt=qryt+"  and a.programcode in ("+mSubject+")   " ;
			
			qryt=qryt+" and nvl(Studentdeactive,'N')='N' ";
			rst=db.getRowset(qryt);
		//	out.print(qryt);
			int TotalStud3=0  ;
			while (rst.next())      
			{ 
		 		
			
					TotalStud3=rst.getInt("totstudents3");
						TotalStud3++;
				
			}


//---------------------------------------------------------------------------------------------------------------------------

			qryt=" select studentid,count(*)noofclass from V#StudentAttendance a Where  a.LTP='"+mLTP+"' and subjectid='" +rs1.getString("SUBJECTID")+ "'    and a.institutecode='" +rs1.getString("institutecode")+ "'  and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";	
			qryt=qryt+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('','dd-mm-yyyy')))";
					qryt=qryt+" and trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy'))) ";			
			if(mSubject.equals("ALL"))
            qryt=qryt+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
            else
            qryt=qryt+"  and a.programcode in ("+mSubject+")   " ;
			
			qryt=qryt+"and nvl(present,'N')='Y' and nvl(Studentdeactive,'N')='N'  group by studentid ";
			rst=db.getRowset(qryt);
	//	out.print(qryt);
			int CNTL80T1=0  ;
			while (rst.next())      
			{ 
		 		
				//if  (rst.getInt("noofclass")>(rs1.getInt("totcalsses")*rs1.getInt("totstudents")*80/100)){
				if  (((rst.getInt("noofclass")*100)/rs1.getInt("totcalsses"))<80)
					{
						CNTL80T1++;
					}
//out.print("jhj"+rst.getInt("noofclass")+"ljklj"+rs1.getInt("totcalsses"));
			}

		qryt=" select studentid,count(*)noofclass from V#StudentAttendance a Where  a.LTP='"+mLTP+"' and subjectid='" +rs1.getString("SUBJECTID")+ "'    and a.institutecode='" +rs1.getString("institutecode")+ "'  and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";	
			qryt=qryt+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('','dd-mm-yyyy')))";
					qryt=qryt+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy')))  ";
			
			if(mSubject.equals("ALL"))
            qryt=qryt+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
            else
            qryt=qryt+"  and a.programcode in ("+mSubject+")   " ;
			
			qryt=qryt+"and nvl(present,'N')='Y' and nvl(Studentdeactive,'N')='N'  group by studentid ";
			rst=db.getRowset(qryt);
			//out.print(qryt);
			int CNTL80T2=0  ;
			while (rst.next())      
			{ 
		 		
				//if  (rst.getInt("noofclass")>(rs1.getInt("totcalsses")*rs1.getInt("totstudents")*80/100)){
				if  (((rst.getInt("noofclass")*100)/rs1.getInt("totcalsses"))<80)
					{
						CNTL80T2++;
					//	out.print("jhj"+rst.getInt("noofclass")+"ljklj"+rs1.getInt("totcalsses"));
					}
//out.print("jhj"+rst.getInt("noofclass")+"ljklj"+rs1.getInt("totcalsses"));
			}

				qryt=" select studentid,count(*)noofclass from V#StudentAttendance a Where  a.LTP='"+mLTP+"' and subjectid='" +rs1.getString("SUBJECTID")+ "'    and a.institutecode='" +rs1.getString("institutecode")+ "'  and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";	
			qryt=qryt+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('','dd-mm-yyyy')))";
			qryt=qryt+" and trunc(decode(to_date('"+mDate3+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate3+"','dd-mm-yyyy')))";
			
			if(mSubject.equals("ALL"))
            qryt=qryt+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
            else
            qryt=qryt+"  and a.programcode in ("+mSubject+")   " ;
		
			qryt=qryt+"and nvl(present,'N')='Y' and nvl(Studentdeactive,'N')='N' group by studentid ";
			rst=db.getRowset(qryt);
		//	out.print(qryt);
			int CNTL80T3=0  ;
			while (rst.next())      
			{ 
		 		
				//if  (rst.getInt("noofclass")>(rs1.getInt("totcalsses")*rs1.getInt("totstudents")*80/100)){
				if  (((rst.getInt("noofclass")*100)/rs1.getInt("totcalsses"))<80)
					{
						CNTL80T3++;
					}
//out.print("jhj"+rst.getInt("noofclass")+"ljklj"+rs1.getInt("totcalsses"));
			}

//---------------------------------------------------------------------------------------------------------------------------



            qryt=" select studentid,count(*)noofclass from V#StudentAttendance a Where  a.LTP='"+mLTP+"' and subjectid='" +rs1.getString("SUBJECTID")+ "'    and a.institutecode='" +rs1.getString("institutecode")+ "'  and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";
			qryt=qryt+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('','dd-mm-yyyy')))";
					qryt=qryt+" and trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy'))) ";	

			if(mSubject.equals("ALL"))
            qry=qry+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
            else
            qryt=qryt+"  and a.programcode in ("+mSubject+") " ;
			qryt=qryt+"and nvl(present,'N')='Y' and nvl(Studentdeactive,'N')='N' and nvl(Studentdeactive,'N')='N' group by studentid ";
			rst=db.getRowset(qryt);
            //out.print("ddd"+qryt);
			int CCNTL70T1=0  ;
			while (rst.next())
			{

				//if  (rst.getInt("noofclass")>(rs1.getInt("totcalsses")*rs1.getInt("totstudents")*80/100)){
				if   (((rst.getInt("noofclass")*100)/rs1.getInt("totcalsses"))<70)
				{
					CCNTL70T1++;
				}
				}


  qryt=" select studentid,count(*)noofclass from V#StudentAttendance a Where  a.LTP='"+mLTP+"' and subjectid='" +rs1.getString("SUBJECTID")+ "'    and a.institutecode='" +rs1.getString("institutecode")+ "'  and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";
			qryt=qryt+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('','dd-mm-yyyy')))";
					qryt=qryt+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy'))) ";	

			if(mSubject.equals("ALL"))
            qry=qry+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
            else
            qryt=qryt+"  and a.programcode in ("+mSubject+") " ;
			qryt=qryt+"and nvl(present,'N')='Y' and nvl(Studentdeactive,'N')='N' and nvl(Studentdeactive,'N')='N' group by studentid ";
			rst=db.getRowset(qryt);
            //out.print("ddd"+qryt);
			int CCNTL70T2=0  ;
			while (rst.next())
			{

				//if  (rst.getInt("noofclass")>(rs1.getInt("totcalsses")*rs1.getInt("totstudents")*80/100)){
				if   (((rst.getInt("noofclass")*100)/rs1.getInt("totcalsses"))<70)
				{
					CCNTL70T2++;
				}
				}



  qryt=" select studentid,count(*)noofclass from V#StudentAttendance a Where  a.LTP='"+mLTP+"' and subjectid='" +rs1.getString("SUBJECTID")+ "'    and a.institutecode='" +rs1.getString("institutecode")+ "'  and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";
			qryt=qryt+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('','dd-mm-yyyy')))";
					qryt=qryt+" and trunc(decode(to_date('"+mDate3+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate3+"','dd-mm-yyyy'))) ";	

			if(mSubject.equals("ALL"))
            qry=qry+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
            else
            qryt=qryt+"  and a.programcode in ("+mSubject+") " ;
			qryt=qryt+"and nvl(present,'N')='Y' and nvl(Studentdeactive,'N')='N' and nvl(Studentdeactive,'N')='N' group by studentid ";
			rst=db.getRowset(qryt);
            //out.print("ddd"+qryt);
			int CCNTL70T3=0  ;
			while (rst.next())
			{

				//if  (rst.getInt("noofclass")>(rs1.getInt("totcalsses")*rs1.getInt("totstudents")*80/100)){
				if   (((rst.getInt("noofclass")*100)/rs1.getInt("totcalsses"))<70)
				{
					CCNTL70T3++;
				}
				}

//-----------------------------------------------------------------------------------------------------------------------------

	qryt=" select studentid,count(*)noofclass from V#StudentAttendance a Where  a.LTP='"+mLTP+"' and subjectid='" +rs1.getString("SUBJECTID")+ "'    and a.institutecode='" +rs1.getString("institutecode")+ "'  and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";
		qryt=qryt+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('','dd-mm-yyyy')))";
					qryt=qryt+" and trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy'))) ";	
			if(mSubject.equals("ALL"))
qryt=qryt+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
else
qryt=qryt+"  and a.programcode in ("+mSubject+")   " ;
			qryt=qryt+"and nvl(present,'N')='Y' and nvl(Studentdeactive,'N')='N' and nvl(Studentdeactive,'N')='N' group by studentid ";
			rst=db.getRowset(qryt);
			//out.print(qryt);
			int CNTL60T1=0  ;
			while (rst.next())
			{
			//if  (rst.getInt("noofclass")>(rs1.getInt("totcalsses")*rs1.getInt("totstudents")*80/100)){
			if (((rst.getInt("noofclass")*100)/rs1.getInt("totcalsses"))<60)
			{
				CNTL60T1++;
			}

            }


	qryt=" select studentid,count(*)noofclass from V#StudentAttendance a Where  a.LTP='"+mLTP+"' and subjectid='" +rs1.getString("SUBJECTID")+ "'    and a.institutecode='" +rs1.getString("institutecode")+ "'  and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";
		qryt=qryt+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('','dd-mm-yyyy')))";
					qryt=qryt+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy'))) ";	
			if(mSubject.equals("ALL"))
qryt=qryt+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
else
qryt=qryt+"  and a.programcode in ("+mSubject+")   " ;
			qryt=qryt+"and nvl(present,'N')='Y' and nvl(Studentdeactive,'N')='N' and nvl(Studentdeactive,'N')='N' group by studentid ";
			rst=db.getRowset(qryt);
			//out.print(qryt);
			int CNTL60T2=0  ;
			while (rst.next())
			{
			//if  (rst.getInt("noofclass")>(rs1.getInt("totcalsses")*rs1.getInt("totstudents")*80/100)){
			if (((rst.getInt("noofclass")*100)/rs1.getInt("totcalsses"))<60)
			{
				CNTL60T2++;
			}

            }

	qryt=" select studentid,count(*)noofclass from V#StudentAttendance a Where  a.LTP='"+mLTP+"' and subjectid='" +rs1.getString("SUBJECTID")+ "'    and a.institutecode='" +rs1.getString("institutecode")+ "'  and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";
		qryt=qryt+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('','dd-mm-yyyy')))";
					qryt=qryt+" and trunc(decode(to_date('"+mDate3+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate3+"','dd-mm-yyyy'))) ";	
			if(mSubject.equals("ALL"))
qryt=qryt+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
else
qryt=qryt+"  and a.programcode in ("+mSubject+")   " ;
			qryt=qryt+"and nvl(present,'N')='Y' and nvl(Studentdeactive,'N')='N' and nvl(Studentdeactive,'N')='N' group by studentid ";
			rst=db.getRowset(qryt);
			//out.print(qryt);
			int CNTL60T3=0  ;
			while (rst.next())
			{
			//if  (rst.getInt("noofclass")>(rs1.getInt("totcalsses")*rs1.getInt("totstudents")*80/100)){
			if (((rst.getInt("noofclass")*100)/rs1.getInt("totcalsses"))<60)
			{
				CNTL60T3++;
			}

            }

//------------------------------------------------------------------------------------------------------------------------------------


qryt=" select studentid,count(*)noofclass from V#StudentAttendance a Where  a.LTP='"+mLTP+"' and subjectid='" +rs1.getString("SUBJECTID")+ "'   and a.institutecode='" +rs1.getString("institutecode")+ "'    and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";
qryt=qryt+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('','dd-mm-yyyy')))";
					qryt=qryt+" and trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy'))) ";	

if(mSubject.equals("ALL"))
qry=qry+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
else
qryt=qryt+"  and a.programcode in ("+mSubject+")   " ;
qryt=qryt+"and nvl(present,'N')='Y' and nvl(Studentdeactive,'N')='N' and nvl(Studentdeactive,'N')='N' group by studentid ";


			    rst=db.getRowset(qryt);
                //out.print(qryt);
			    //out.print(qryt);
			    int CNTL50T1=0  ;
                while (rst.next())
                {
				//if  (rst.getInt("noofclass")>(rs1.getInt("totcalsses")*rs1.getInt("totstudents")*80/100)){
				if   (((rst.getInt("noofclass")*100)/rs1.getInt("totcalsses"))<50)
				{
					CNTL50T1++;
				}
                }


qryt=" select studentid,count(*)noofclass from V#StudentAttendance a Where  a.LTP='"+mLTP+"' and subjectid='" +rs1.getString("SUBJECTID")+ "'   and a.institutecode='" +rs1.getString("institutecode")+ "'    and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";
qryt=qryt+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('','dd-mm-yyyy')))";
					qryt=qryt+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy'))) ";	
if(mSubject.equals("ALL"))
qry=qry+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
else
qryt=qryt+"  and a.programcode in ("+mSubject+")   " ;
qryt=qryt+"and nvl(present,'N')='Y' and nvl(Studentdeactive,'N')='N' group by studentid ";


			    rst=db.getRowset(qryt);
                //out.print(qryt);
			    //out.print(qryt);
			    int CNTL50T2=0  ;
                while (rst.next())
                {
				//if  (rst.getInt("noofclass")>(rs1.getInt("totcalsses")*rs1.getInt("totstudents")*80/100)){
				if   (((rst.getInt("noofclass")*100)/rs1.getInt("totcalsses"))<50)
				{
					CNTL50T2++;
				}
                }

				
qryt=" select studentid,count(*)noofclass from V#StudentAttendance a Where  a.LTP='"+mLTP+"' and subjectid='" +rs1.getString("SUBJECTID")+ "'   and a.institutecode='" +rs1.getString("institutecode")+ "'    and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";
qryt=qryt+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('','dd-mm-yyyy')))";
					qryt=qryt+" and trunc(decode(to_date('"+mDate3+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate3+"','dd-mm-yyyy'))) ";	
if(mSubject.equals("ALL"))
qry=qry+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
else
qryt=qryt+"  and a.programcode in ("+mSubject+")   " ;
qryt=qryt+"and nvl(present,'N')='Y' and nvl(Studentdeactive,'N')='N' group by studentid ";


			    rst=db.getRowset(qryt);
                //out.print(qryt);
			    //out.print(qryt);
			    int CNTL50T3=0  ;
                while (rst.next())
                {
				//if  (rst.getInt("noofclass")>(rs1.getInt("totcalsses")*rs1.getInt("totstudents")*80/100)){
				if   (((rst.getInt("noofclass")*100)/rs1.getInt("totcalsses"))<50)
				{
					CNTL50T3++;
				}
                }

//---------------------------------------------------------------------------------------------------------------------------------------


            qryt=" select studentid,count(*)noofclass from V#StudentAttendance a Where  a.LTP='"+mLTP+"' and subjectid='" +rs1.getString("SUBJECTID")+ "'   and a.institutecode='" +rs1.getString("institutecode")+ "'  and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";
			qryt=qryt+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('','dd-mm-yyyy')))";
					qryt=qryt+" and trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy'))) ";	
			if(mSubject.equals("ALL"))
            qry=qry+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
            else
            qryt=qryt+"  and a.programcode in ("+mSubject+")   " ;
			qryt=qryt+"and nvl(present,'N')='Y' and nvl(Studentdeactive,'N')='N' group by studentid ";
			rst=db.getRowset(qryt);

			//out.print(qryt);

			int CNTL40T1=0  ;


			while (rst.next())
			{

				//if  (rst.getInt("noofclass")>(rs1.getInt("totcalsses")*rs1.getInt("totstudents")*80/100)){
				if   (((rst.getInt("noofclass")*100)/rs1.getInt("totcalsses"))<40)
				{
					CNTL40T1++;
				}

            }



            qryt=" select studentid,count(*)noofclass from V#StudentAttendance a Where  a.LTP='"+mLTP+"' and subjectid='" +rs1.getString("SUBJECTID")+ "'   and a.institutecode='" +rs1.getString("institutecode")+ "'  and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";
			qryt=qryt+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('','dd-mm-yyyy')))";
					qryt=qryt+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy'))) ";	
			if(mSubject.equals("ALL"))
            qry=qry+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
            else
            qryt=qryt+"  and a.programcode in ("+mSubject+")   " ;
			qryt=qryt+"and nvl(present,'N')='Y' and nvl(Studentdeactive,'N')='N' group by studentid ";
			rst=db.getRowset(qryt);

			//out.print(qryt);

			int CNTL40T2=0  ;


			while (rst.next())
			{

				//if  (rst.getInt("noofclass")>(rs1.getInt("totcalsses")*rs1.getInt("totstudents")*80/100)){
				if   (((rst.getInt("noofclass")*100)/rs1.getInt("totcalsses"))<40)
				{
					CNTL40T2++;
				}

            }

      qryt=" select studentid,count(*)noofclass from V#StudentAttendance a Where  a.LTP='"+mLTP+"' and subjectid='" +rs1.getString("SUBJECTID")+ "'   and a.institutecode='" +rs1.getString("institutecode")+ "'  and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";
			qryt=qryt+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('','dd-mm-yyyy')))";
					qryt=qryt+" and trunc(decode(to_date('"+mDate3+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate3+"','dd-mm-yyyy'))) ";	
			if(mSubject.equals("ALL"))
            qry=qry+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
            else
            qryt=qryt+"  and a.programcode in ("+mSubject+")   " ;
			qryt=qryt+"and nvl(present,'N')='Y' and nvl(Studentdeactive,'N')='N' group by studentid ";
			rst=db.getRowset(qryt);

			//out.print(qryt);

			int CNTL40T3=0  ;


			while (rst.next())
			{

				//if  (rst.getInt("noofclass")>(rs1.getInt("totcalsses")*rs1.getInt("totstudents")*80/100)){
				if   (((rst.getInt("noofclass")*100)/rs1.getInt("totcalsses"))<40)
				{
					CNTL40T3++;
				}

            }

//-------------------------------------------------------------------------------------------------------------------------------

            qryt=" select studentid,count(*)noofclass from V#StudentAttendance a Where  a.LTP='"+mLTP+"' and subjectid='" +rs1.getString("SUBJECTID")+ "'    and a.institutecode='" +rs1.getString("institutecode")+ "'  and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";
			qryt=qryt+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('','dd-mm-yyyy')))";
					qryt=qryt+" and trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy'))) ";	
			if(mSubject.equals("ALL"))
            qryt=qryt+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
            else
            qryt=qryt+"  and a.programcode in ("+mSubject+")   " ;
			qryt=qryt+"and nvl(present,'N')='Y'  and nvl(Studentdeactive,'N')='N' group by studentid ";
			rst=db.getRowset(qryt);
			//out.print(qryt);
			int CNTL30T1=0  ;
			while (rst.next())
			{
			//if  (rst.getInt("noofclass")>(rs1.getInt("totcalsses")*rs1.getInt("totstudents")*80/100)){
			if   (((rst.getInt("noofclass")*100)/rs1.getInt("totcalsses"))<30)
			{
			CNTL30T1++;
			}

	               //
		            }

     qryt=" select studentid,count(*)noofclass from V#StudentAttendance a Where  a.LTP='"+mLTP+"' and subjectid='" +rs1.getString("SUBJECTID")+ "'    and a.institutecode='" +rs1.getString("institutecode")+ "'  and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";
			qryt=qryt+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('','dd-mm-yyyy')))";
					qryt=qryt+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy'))) ";	
			if(mSubject.equals("ALL"))
            qryt=qryt+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
            else
            qryt=qryt+"  and a.programcode in ("+mSubject+")   " ;
			qryt=qryt+"and nvl(present,'N')='Y'  and nvl(Studentdeactive,'N')='N' group by studentid ";
			rst=db.getRowset(qryt);
			//out.print(qryt);
			int CNTL30T2=0  ;
			while (rst.next())
			{
			//if  (rst.getInt("noofclass")>(rs1.getInt("totcalsses")*rs1.getInt("totstudents")*80/100)){
			if   (((rst.getInt("noofclass")*100)/rs1.getInt("totcalsses"))<30)
			{
			CNTL30T2++;
			}

	               //
		            }

					
     qryt=" select studentid,count(*)noofclass from V#StudentAttendance a Where  a.LTP='"+mLTP+"' and subjectid='" +rs1.getString("SUBJECTID")+ "'    and a.institutecode='" +rs1.getString("institutecode")+ "'  and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";
			qryt=qryt+" and trunc(a.ATTENDANCEDATE) between trunc(decode(to_date('','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('','dd-mm-yyyy')))";
					qryt=qryt+" and trunc(decode(to_date('"+mDate3+"','dd-mm-yyyy'),'',a.ATTENDANCEDATE,to_date('"+mDate3+"','dd-mm-yyyy'))) ";	
			if(mSubject.equals("ALL"))
            qryt=qryt+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
            else
            qryt=qryt+"  and a.programcode in ("+mSubject+")   " ;
			qryt=qryt+"and nvl(present,'N')='Y'  and nvl(Studentdeactive,'N')='N' group by studentid ";
			rst=db.getRowset(qryt);
			//out.print(qryt);
			int CNTL30T3=0  ;
			while (rst.next())
			{
			//if  (rst.getInt("noofclass")>(rs1.getInt("totcalsses")*rs1.getInt("totstudents")*80/100)){
			if   (((rst.getInt("noofclass")*100)/rs1.getInt("totcalsses"))<30)
			{
			CNTL30T3++;
			}

	               //
		            }


			        %>
				    <tr><td><B><%=++count%></B></td>
				
                    <!-- ---------- -->
                    <%
				    if(!mSUBN.equals(rs1.getString("Subject")) )
					{
					%>
					<td align=left ><FONT SIZE="1" >
					
					><a href="DateWiseAttendancePerDetail.jsp?ViewType=CNF&amp;INSTITUTE=<%=mInstCode%>&amp;EXAMCODE=<%=mEXAMCODE%>&amp;PROGRAMCODE=<%=mSubject%>&amp;LTP=<%=mLTP%>&amp;SUBJECTCODE=<%=rs1.getString("SUBJECTCODE")%>&amp;SUBJECT=<%=rs1.getString("Subject")%>&amp;SUBJECTID=<%=rs1.getString("SUBJECTID")%>&amp;FLAG=80&amp;TNOOFCLASS=<%=rs1.getInt("totcalsses")%>&amp;Date1=<%=mDate1%>&amp;Date2=<%=mDate2%>&amp;Date3=<%=mDate3%>" target=_new>
					
					<%=rs1.getString("Subject")%>(<%=rs1.getString("SUBJECTCODE")%>)
					</a>
					</td>
					<%
					mSUBN=rs1.getString("Subject");
					}
				    else
					{
					%>
					<td  align=left ><Font size=1 color=green align=center>''</Font></td>
					<%
					}
					%>

				
					<%
				


	qryc="SELECT COORDINATORCODE,COORDINATORNAME  from V#EX#SUBJECTGRADECOORDINATOR where LTP='"+mLTP+"'  and subjectcode='"+rs1.getString("SUBJECTCODE")+"' ";

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

    <td ALIGN=LEFT><%=CNTL80T1++%></a></td>


 <td ALIGN=LEFT><%=CNTL80T2++%></a></td>

 
 <td ALIGN=LEFT><%=CNTL80T3++%></a></td>


    <td ALIGN=LEFT><%=CCNTL70T1++%></a></td>

<td ALIGN=LEFT><%=CCNTL70T2++%></a></td>


<td ALIGN=LEFT><%=CCNTL70T3++%></a></td>





    <td ALIGN=LEFT><%=CNTL60T1++%> </a></td>


<td ALIGN=LEFT><%=CNTL60T2++%> </a></td>

<td ALIGN=LEFT><%=CNTL60T3++%> </a></td>



    <td ALIGN=LEFT> <%=CNTL50T1++%> </a></td>

<td ALIGN=LEFT> <%=CNTL50T2++%> </a></td>

<td ALIGN=LEFT> <%=CNTL50T3++%> </a></td>


    <td ALIGN=LEFT> <%=CNTL40T1++%> </a></td>

	<td ALIGN=LEFT> <%=CNTL40T2++%> </a></td>

<td ALIGN=LEFT> <%=CNTL40T3++%> </a></td>




    <td ALIGN=LEFT><%=CNTL30T1++%> </a></td>

	
    <td ALIGN=LEFT><%=CNTL30T2++%> </a></td>

	
    <td ALIGN=LEFT><%=CNTL30T3++%> </a></td>

	

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
			ttsum2=TotalStud2+ttsum2;
			ttsum3=TotalStud3+ttsum3;

		
               //     
                //    tsum=((CNTL60)+(tsum));
                 //   usum=((CNTL50)+(usum));
                  //  vsum=((CNTL40)+(vsum));
              //      wsum=((CNTL30)+(wsum));
                    %>
					  <td align="LEFT"><font color="green"><%=TotalStud1%></font> </td>
					  <td align="LEFT"><font color="green"><%=TotalStud2%></font> </td>
                    <td align="LEFT"><font color="green"><%=TotalStud3%></font> </td>

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
						  <td><font color="red"><%=usum50t3%></font> </td>
						    <td><font color="red"><%=usum50t3%></font> </td>
					
				    <td><font color="red"><%=vsum40t1%></font> </td>
					    <td><font color="red"><%=vsum40t2%></font> </td>
						    <td><font color="red"><%=vsum40t3%></font> </td>

							  <td><font color="red"><%=wsum30t1%></font> </td>
							    <td><font color="red"><%=wsum30t2%></font> </td>
								  <td><font color="red"><%=wsum30t3%></font> </td>



  <td><font color="red"><%=ttsum1%></font> </td>
							    <td><font color="red"><%=ttsum2%></font> </td>
								  <td><font color="red"><%=ttsum3%></font> </td>
					
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
					out.print(e);
					}	
					%>
					</body>
					</html>

