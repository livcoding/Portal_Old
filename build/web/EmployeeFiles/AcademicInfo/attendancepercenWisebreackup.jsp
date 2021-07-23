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
//--------ADDED CODE------DATE-3/28/2012 @mohit sharma
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
		int count=0 ,Flag=0;
		
if (session.getAttribute("InstituteCode") == null) 
	mInst = "";
else
	mInst = session.getAttribute("InstituteCode").toString().trim();

%>
<HTML>
    <head>
        <TITLE>#### JIIT [ Attendance PercentageWise BreackUp]</TITLE>
   
<script language="JavaScript" type ="text/javascript">
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
var v1=DataRegCode.options[i].value;
len= v1.length ;
pos=v1.indexOf('***');
ic=v1.substring(0,pos);
rc=v1.substring(pos+3,len);
if (ic==InstCode && rgd=='ALL' )
{
var optn = document.createElement("OPTION");
optn.text=DataRegCode.options[i].text;
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
selectbox.remove[i];
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
        <tr><td colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><FONT SIZE="4" COLOR=""><B>Student Attendance Percentage Wise Breakup</B></FONT>
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
				qry += " Group By A.REGCODE, A.ExamCode, B.EXAMPERIODFROM order by EXAMPERIODFROM DESC) where rownum<=20 order by 3 desc";
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
				  <table align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="40%" border=1 >
				  <thead>
				  <tr bgcolor="#ff8c00">
				  <td ><b><font color="white">Sr.no.</font></b></td>
                 <!--  <td align=center><b><font color="white" SIZE=1>Subject Code</font></b></td> -->
                  <td align=center><b><font color="white" SIZE=1>Subject</font></b></td>
				   <td><b><font color="white" SIZE=1>Sub-<BR>section</font></b></td>
				  <td><b><font color="white" SIZE=1>Co-ordinator</font></b></td>
				   
				  <td align=LEFT ><b><font color="white" SIZE=1><80</td>
                  <td align=LEFT ><b><font color="white" SIZE=1><70</font></b></td>
                  <td align=LEFT ><b><font color="white" SIZE=1><60</font></b></td>
                  <td align=LEFT ><b><font color="white" SIZE=1><50</font></b></td>
                  <td align=LEFT ><b><font color="white" SIZE=1><40</font></b></td>
                  <td align=LEFT ><b><font color="white" SIZE=1><30</font></b></td>
                  <td align=LEFT  ><b><font color="white" SIZE=1 >Total Student</font></b></td>
                  </tr>
				  </thead>
				  <tbody>
				  <!-- <tr>-->
                  <%
			qry="select  INSTITUTECODE ,EXAMCODE , SUBJECTID,SUBJECTCODE,fstid,subsectioncode,Subject,count(distinct CLASSTIMEFROM) totcalsses,count(distinct studentid) totstudents from V#StudentAttendance a Where  a.LTP='"+mLTP+"'  ";
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
			qry=qry+" group by  institutecode , examcode,SUBJECTCODE,Subject,SUBJECTID,fstid,subsectioncode order by SUBJECTCODE,Subject,subsectioncode" ;
			rs1=db.getRowset(qry);
		//out.print(qry);
			//if(rs1.getString("SUBJECTCODE").equals("10B11CI401"))
			while (rs1.next())      
			{ 		
			qryt=" select studentid,count(*)noofclass from V#StudentAttendance a Where  a.LTP='"+mLTP+"' and subjectid='" +rs1.getString("SUBJECTID")+ "' and a.fstid='"+rs1.getString("fstid")+"'   and a.institutecode='" +rs1.getString("institutecode")+ "'  and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";	
			if(mSubject.equals("ALL"))
            qryt=qryt+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
            else
            qryt=qryt+"  and a.programcode in ("+mSubject+")   " ;
			qryt=qryt+"and nvl(present,'N')='Y' group by studentid ";
			rst=db.getRowset(qryt);
		//	out.print(qryt);
			int CNTL80=0  ;

			
			while (rst.next())      
			{ 
		 		
				//if  (rst.getInt("noofclass")>(rs1.getInt("totcalsses")*rs1.getInt("totstudents")*80/100)){
				if  (((rst.getInt("noofclass")*100)/rs1.getInt("totcalsses"))<80)
					{
						CNTL80++;
					}
//out.print("jhj"+rst.getInt("noofclass")+"ljklj"+rs1.getInt("totcalsses"));
			}
            qryt=" select studentid,count(*)noofclass from V#StudentAttendance a Where  a.LTP='"+mLTP+"' and subjectid='" +rs1.getString("SUBJECTID")+ "' and a.fstid='"+rs1.getString("fstid")+"'   and a.institutecode='" +rs1.getString("institutecode")+ "'  and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";
			if(mSubject.equals("ALL"))
            qry=qry+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
            else
            qryt=qryt+"  and a.programcode in ("+mSubject+") " ;
			qryt=qryt+"and nvl(present,'N')='Y' and nvl(Studentdeactive,'N')='N' group by studentid ";
			rst=db.getRowset(qryt);
            //out.print("ddd"+qryt);
			int CCNTL70=0  ;
			while (rst.next())
			{

				//if  (rst.getInt("noofclass")>(rs1.getInt("totcalsses")*rs1.getInt("totstudents")*80/100)){
				if   (((rst.getInt("noofclass")*100)/rs1.getInt("totcalsses"))<70)
				{
					CCNTL70++;
				}
				}



                	qryt=" select studentid,count(*)noofclass from V#StudentAttendance a Where  a.LTP='"+mLTP+"' and subjectid='" +rs1.getString("SUBJECTID")+ "' and a.fstid='"+rs1.getString("fstid")+"'   and a.institutecode='" +rs1.getString("institutecode")+ "'  and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";
			if(mSubject.equals("ALL"))
qryt=qryt+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
else
qryt=qryt+"  and a.programcode in ("+mSubject+")   " ;
			qryt=qryt+"and nvl(present,'N')='Y' and nvl(Studentdeactive,'N')='N' group by studentid ";
			rst=db.getRowset(qryt);
			//out.print(qryt);
			int CNTL60=0  ;
			while (rst.next())
			{
			//if  (rst.getInt("noofclass")>(rs1.getInt("totcalsses")*rs1.getInt("totstudents")*80/100)){
			if (((rst.getInt("noofclass")*100)/rs1.getInt("totcalsses"))<60)
			{
				CNTL60++;
			}

            }

qryt=" select studentid,count(*)noofclass from V#StudentAttendance a Where  a.LTP='"+mLTP+"' and subjectid='" +rs1.getString("SUBJECTID")+ "'   and a.institutecode='" +rs1.getString("institutecode")+ "' and a.fstid='"+rs1.getString("fstid")+"'   and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";
if(mSubject.equals("ALL"))
qry=qry+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
else
qryt=qryt+"  and a.programcode in ("+mSubject+")   " ;
qryt=qryt+"and nvl(present,'N')='Y' and nvl(Studentdeactive,'N')='N' group by studentid ";


			    rst=db.getRowset(qryt);
                //out.print(qryt);
			    //out.print(qryt);
			    int CNTL50=0  ;
                while (rst.next())
                {
				//if  (rst.getInt("noofclass")>(rs1.getInt("totcalsses")*rs1.getInt("totstudents")*80/100)){
				if   (((rst.getInt("noofclass")*100)/rs1.getInt("totcalsses"))<50)
				{
					CNTL50++;
				}
                }
            qryt=" select studentid,count(*)noofclass from V#StudentAttendance a Where  a.LTP='"+mLTP+"' and subjectid='" +rs1.getString("SUBJECTID")+ "' and a.fstid='"+rs1.getString("fstid")+"'  and a.institutecode='" +rs1.getString("institutecode")+ "'  and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";
			if(mSubject.equals("ALL"))
            qry=qry+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
            else
            qryt=qryt+"  and a.programcode in ("+mSubject+")   " ;
			qryt=qryt+"and nvl(present,'N')='Y' and nvl(Studentdeactive,'N')='N' group by studentid ";
			rst=db.getRowset(qryt);

			//out.print(qryt);

			int CNTL40=0  ;


			while (rst.next())
			{

				//if  (rst.getInt("noofclass")>(rs1.getInt("totcalsses")*rs1.getInt("totstudents")*80/100)){
				if   (((rst.getInt("noofclass")*100)/rs1.getInt("totcalsses"))<40)
				{
					CNTL40++;
				}

            }


            qryt=" select studentid,count(*)noofclass from V#StudentAttendance a Where  a.LTP='"+mLTP+"' and subjectid='" +rs1.getString("SUBJECTID")+ "' and a.fstid='"+rs1.getString("fstid")+"'   and a.institutecode='" +rs1.getString("institutecode")+ "'  and a.examcode='" +rs1.getString("EXAMCODE")+ "'   ";
			if(mSubject.equals("ALL"))
            qryt=qryt+"  and a.programcode = decode(a.programcode ,'ALL','ALL', a.programcode )  " ;
            else
            qryt=qryt+"  and a.programcode in ("+mSubject+")   " ;
			qryt=qryt+"and nvl(present,'N')='Y'  and nvl(Studentdeactive,'N')='N' group by studentid ";
			rst=db.getRowset(qryt);
			//out.print(qryt);
			int CNTL30=0  ;
			while (rst.next())
			{
			//if  (rst.getInt("noofclass")>(rs1.getInt("totcalsses")*rs1.getInt("totstudents")*80/100)){
			if   (((rst.getInt("noofclass")*100)/rs1.getInt("totcalsses"))<30)
			{
			CNTL30++;
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
					<td align=left ><FONT SIZE="1" ><%=rs1.getString("Subject")%>(<%=rs1.getString("SUBJECTCODE")%>)</td>
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

					<td  align=left ><Font size=1 color=green align=center><%=rs1.getString("subsectioncode")%></Font></td>
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
}%>
    <td ALIGN=LEFT><a href="Facultywiseattnpercentdetail.jsp?ViewType=CNF&amp;INSTITUTE=<%=mInstCode%>&amp;EXAMCODE=<%=mEXAMCODE%>&amp;PROGRAMCODE=<%=mSubject%>&amp;LTP=<%=mLTP%>&amp;SUBJECTCODE=<%=rs1.getString("SUBJECTCODE")%>&amp;SUBCODE=<%=rs1.getString("SUBSECTIONCODE")%>&amp;SUBJECT=<%=rs1.getString("Subject")%>&amp;FLAG=80&amp;TNOOFCLASS=<%=rs1.getInt("totcalsses")%>" target=_new><%=CNTL80++%></a></td>
    <td ALIGN=LEFT><a href="Facultywiseattnpercentdetail.jsp?ViewType=CNF&amp;INSTITUTE=<%=mInstCode%>&amp;EXAMCODE=<%=mEXAMCODE%>&amp;PROGRAMCODE=<%=mSubject%>&amp;LTP=<%=mLTP%>&amp;SUBJECTCODE=<%=rs1.getString("SUBJECTCODE")%>&amp;SUBCODE=<%=rs1.getString("SUBSECTIONCODE")%>&amp;SUBJECT=<%=rs1.getString("Subject")%>&amp;FLAG=70&amp;TNOOFCLASS=<%=rs1.getInt("totcalsses")%>" target=_new><%=CCNTL70++%></a></td>
    <td ALIGN=LEFT><a href="Facultywiseattnpercentdetail.jsp?ViewType=CNF&amp;INSTITUTE=<%=mInstCode%>&amp;EXAMCODE=<%=mEXAMCODE%>&amp;PROGRAMCODE=<%=mSubject%>&amp;LTP=<%=mLTP%>&amp;SUBJECTCODE=<%=rs1.getString("SUBJECTCODE")%>&amp;SUBCODE=<%=rs1.getString("SUBSECTIONCODE")%>&amp;SUBJECT=<%=rs1.getString("Subject")%>&amp;FLAG=60&amp;TNOOFCLASS=<%=rs1.getInt("totcalsses")%>" target=_new><%=CNTL60++%> </a></td>
    <td ALIGN=LEFT><a href="Facultywiseattnpercentdetail.jsp?ViewType=CNF&amp;INSTITUTE=<%=mInstCode%>&amp;EXAMCODE=<%=mEXAMCODE%>&amp;PROGRAMCODE=<%=mSubject%>&amp;LTP=<%=mLTP%>&amp;SUBJECTCODE=<%=rs1.getString("SUBJECTCODE")%>&amp;SUBCODE=<%=rs1.getString("SUBSECTIONCODE")%>&amp;SUBJECT=<%=rs1.getString("Subject")%>&amp;FLAG=50&amp;TNOOFCLASS=<%=rs1.getInt("totcalsses")%>" target=_new> <%=CNTL50++%> </a></td>
    <td ALIGN=LEFT><a href="Facultywiseattnpercentdetail.jsp?ViewType=CNF&amp;INSTITUTE=<%=mInstCode%>&amp;EXAMCODE=<%=mEXAMCODE%>&amp;PROGRAMCODE=<%=mSubject%>&amp;LTP=<%=mLTP%>&amp;SUBJECTCODE=<%=rs1.getString("SUBJECTCODE")%>&amp;SUBCODE=<%=rs1.getString("SUBSECTIONCODE")%>&amp;SUBJECT=<%=rs1.getString("Subject")%>&amp;FLAG=40&amp;TNOOFCLASS=<%=rs1.getInt("totcalsses")%>" target=_new> <%=CNTL40++%> </a></td>
    <td ALIGN=LEFT><a href="Facultywiseattnpercentdetail.jsp?ViewType=CNF&amp;INSTITUTE=<%=mInstCode%>&amp;EXAMCODE=<%=mEXAMCODE%>&amp;PROGRAMCODE=<%=mSubject%>&amp;LTP=<%=mLTP%>&amp;SUBJECTCODE=<%=rs1.getString("SUBJECTCODE")%>&amp;SUBCODE=<%=rs1.getString("SUBSECTIONCODE")%>&amp;SUBJECT=<%=rs1.getString("Subject")%>&amp;FLAG=30&amp;TNOOFCLASS=<%=rs1.getInt("totcalsses")%>" target=_new><%=CNTL30++%> </a></td>

                    <%
                    rsum=((CNTL80)+(rsum));
                    ssum=((CCNTL70)+(ssum));
                    tsum=((CNTL60)+(tsum));
                    usum=((CNTL50)+(usum));
                    vsum=((CNTL40)+(vsum));
                    wsum=((CNTL30)+(wsum));
                    %>
                    <td align="LEFT"><font color="green"><%=rs1.getString("totstudents")%></font> </td>
					</tr>
                    <%
                    //----------------ADDED CODE----------------- ON/27-apl-2011
                    }
                    rsum=((rsum)-(count));
                    ssum=((ssum)-(count));
                    tsum=((tsum)-(count));
                    usum=((usum)-(count));
                    vsum=((vsum)-(count));
                    wsum=((wsum)-(count));
					%>
                    <tr><td></td><td></td><td></td><td ></td><td align="left"><STRONG>Total Count(% Wise):</STRONG></td><td><font color="red"><%=rsum%></font></td>
                    <td><font color="red"><%=ssum%></font> </td>
                   <CENTER> <td><font color="red"><%=tsum%></font> </td></CENTER>
                    <td><font color="red"><%=usum%></font> </td>
                    <td><font color="red"><%=vsum%></font> </td>
                    <td><font color="red"><%=wsum%></font> </td></tr>
					</tbody>
					</table>
					<form><CENTER>
					<input type="button" value=" Print this page "
                    onclick="window.print();return false;" /></CENTER>
					</form>
					<script type="text/javascript">
					var st1 = new SortableTable(document.getElementById("table-1"),["CaseInsensitiveString","CaseInsensitiveString","Number","Number","Number","Number","Number"]);
					</script>
					<table ALIGN=Center VALIGN=TOP>
					<tr>
					<td valign=middle><br><br>
                    <IMG style="WIDTH: 56px; HEIGHT: 56px" src="../../Images/CampusLynx.png"><FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Lynx</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>A product of <STRONG>JIL Information Technology Ltd.</STRONG><br><FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:info@jiit.ac.in'>info@jiit.ac.in</A></FONT>
					</td> 
					</table>
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

