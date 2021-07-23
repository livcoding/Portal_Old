	<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.regex.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp,java.lang.ArrayIndexOutOfBoundsException" %>
<%!    Pattern p = Pattern.compile("^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\\.[a-zA-Z]{2,4}$");
    Matcher m;

    public boolean validateEmail(String email) {
        boolean b = false;
        try {
            m = p.matcher(email);
            b = m.matches();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return b;
    }
%>
<%
int hh=0;
DBHandler db = new DBHandler();
String qrytt="",Selected="";
String QERCLORR=""; 
String QERCLORRN="";
String  xBcklog="",xNoBcklog="";

String  xgaplog="",xNogaplog="";




        int rsum=0,ssum=0,tsum=0,usum=0,vsum=0,wsum=0;
		 String QrySet="",QrySetC="",QrySetCC="",qry4="" ,qry2="",qry3="",xSet="",mCritvales="",mcolor="#F2F2F2",QERCLOR="",andor="";  
		 String  QryIns="";  
        ResultSet rs =  null ,rsSet=null,rsIns=null,rs4=null,rsQERCLORR=null,rsQERCLORRN=null;
		ResultSet rst = null;
		ResultSet rsf=  null ;
        ResultSet rsd = null;
        ResultSet rs1 = null,rsQERCLOR=null,rs5=null;
        ResultSet rs2 = null;
        ResultSet rsc = null;
        String qry = "" ,qryc="",mSUBB="",mSUBN="", mLTP="",qry1="",inst="",institute="",academic="",academicyear="";
		String qryt = "",Event="",Programcode="",Companycode="";
        GlobalFunctions gb = new GlobalFunctions();
	    String mRegCode = "",event="", Academicyear="";
        String mEXAMCODE = "" ,mSubjID="",DataSublist="" ,mProgCode="",QryProgCode="",companycode="";
        String mAcademicYear = "",program="",programcode="";
        String mProgramCode = "";
        String mInstCode = "";
		String  mreg="" ;
		String mHOSTELTYPE = "" , macade="" ,mbranc="" ,sem="",semester="",branch="",branchcode="" ;
		String mprog="",enddate="",fromdate="";
		String mBranchCode = "",msid="",mCode="",mES="",mSubj1="",qrysubj="",Subject="";
        int n=0 ,countI=0,csst=1;
        String qryx="",mLTP1="",Branch="";
        ResultSet rsx=null,rs3=null,RsF=null;
        String reqAction="",qryF="";
		String mInst="",mSubject="",minst="" ,qrys="",Semester="",qry5="";
		int rsum80t1=0,rsum80t2=0,rsum80t3=0,ssum70t1=0,ssum70t2=0,ssum70t3=0,tsum60t1=0,tsum60t2=0,tsum60t3=0,
					usum50t1=0,usum50t2=0,usum50t3=0,vsum40t1=0,vsum40t2=0,vsum40t3=0,wsum30t1=0,wsum30t2=0,wsum30t3=0;
		int count=0 ,Flag=0,slno=0;




 //qryF=" execute TP.POPTPQUALIFICATION ";
 //int xn=db.update(qryF);

//out.print(qry);



int ttsum1=0,ttsum2=0,ttsum3=0;

if (session.getAttribute("InstituteCode") == null)
	mInst = "";
else
	mInst = session.getAttribute("InstituteCode").toString().trim();

%>
<HTML>
    <head>
        <TITLE>#### JIIT [Querry Criteria]</TITLE>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<script type="text/javascript">

               function enable_text()
               {   
                    if(document.getElementById("checkbox1").checked === true)
                     {
                        document.getElementById("textbox1").disabled = false;
                     }
                     else{
                         document.getElementById("textbox1").disabled = true;
                      }
                }
        </script>





<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<script type="text/javascript" src="sh/jquery-1.4.2.min.js"></script>

    <script type="text/javascript" src="sh/jquery.searchabledropdown-1.0.8.min.js"></script>
	<script type="text/javascript">
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
				$.get("addcompanycode.jsp",{event:$("select#event").val(),dt:getCurrentDateTime()},successfunction);
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
		<script type="text/javascript">

               function enable_text()
               {   
                    if(document.getElementById("checkbox1").checked === true)
                     {
                        document.getElementById("textbox1").disabled = false;
                     }
                     else{
                         document.getElementById("textbox1").disabled = true;
                      }
                }
        </script>

	 


</head>
    <body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
 
        <form name="frm"  method="post" >
		<script type="text/javascript">

               function enable_text()
               {   
                    if(document.getElementById("checkbox1").checked === true)
                     {
                        document.getElementById("textbox1").disabled = false;
                     }
                     else{
                         document.getElementById("textbox1").disabled = true;
                      }
                }


   function enable_text2()
               {   
                    if(document.getElementById("checkbox2").checked === true)
                     {
                        document.getElementById("textbox2").disabled = false;
                     }
                     else{
                         document.getElementById("textbox2").disabled = true;
                      }
                }

        </script>
        <input id="x" name="x" type=hidden>
         <table cellpadding=3 cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="95%" bgcolor="white">
<tr bgcolor="silver">
        <td colspan=0 align=middle>
            <font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><FONT SIZE="4" COLOR=""><B>T&P Querry Criteria </B></FONT></font></td></tr>
        </table><BR>
        <table cellpadding=3 cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="95%" bgcolor="white">
<tr bgcolor="silver">
<td align="right"  >
<FONT face=Arial size=2><STRONG>Choose Event:</STRONG></FONT><font color=red face=arial size=2><STRONG>*</STRONG></font></td><td>

			<%
			
 

	

			try
            {
                qry="select distinct NVL(EventCode,'') e from TP#eventmaster Where nvl(Deactive,'N')='N'and nvl(LOCKEVENT,'N')<>'Y' and sysdate between EVENTSTARTDATE and EVENTENDDATE ";
				//out.print(qry);
                rs=db.getRowset(qry);
               %>


					<Select Name="event" tabindex="0" id="event" style="background-color:#88000 ;border-color:black;font-weight:Bold; FONT-FAMILY: Arial; FONT-SIZE: 10pt;color: black; HEIGHT: 25px; VERTICAL-ALIGN: top; WIDTH: 95px" >
                    <OPTION seleceted Value ="" ><--select--></OPTION>
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
					}
					catch(Exception e)
					{
				out.print("error  is "+e);
					}
		
			// out.print("x="+request.getParameter("x"));
			 %>
			
				</td>
			<td nowrap align=right>	
	<FONT face=Arial size=2 ><STRONG>Choose Company:</STRONG></FONT><font color=red face=arial size=2><STRONG>*</STRONG></font></td><td>

<select name="companycode" id="companycode" style="background-color:#88000 ;border-color:black;font-weight:Bold; FONT-FAMILY: Arial; FONT-SIZE: 10pt;color: black; HEIGHT: 25px; VERTICAL-ALIGN: top;  " >
<OPTION seleceted Value ="" ><--select--></OPTION>
<% 	
             try{
                 qry1="SELECT distinct NVL(COMPANYCODE,' ') c FROM TP#eventcompanyparticipents where nvl(Deactive,'N')='N' and EVENTCODE='"+event+"'" ;

	//System.out.print(qry1);
			//companycode=rst.getString("c");
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
						<% 
						}
					else
						{
						%>
					<option  value=<%=companycode%>><%=companycode%></option>
						<%
						}
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
						<%
						}
					else
						{
						%>
						<option  value=<%=companycode%> ><%=companycode%></option>
						<%	
						}
						}
						}
	


		companycode=request.getParameter("companycode")==null?"":request.getParameter("companycode").trim();	
		%>
</select>
		<%}catch(Exception e)
                {
        out.print("error is "+e);}%>
	</td>

   <td>


    &nbsp; <input type=submit style="background-color:#88000 ;border-color:black;font-weight:Bold; FONT-FAMILY: Arial; FONT-SIZE: 10pt;color: black; HEIGHT: 25px; VERTICAL-ALIGN: top; WIDTH: 95px"  name="btn" value="Show" onclick="return vari();"> &nbsp;


        
   </td>
</tr>
  </table>
  <%
 try  {//out.print("cccc"+companycode);
        Companycode=request.getParameter("companycode")==null?"":request.getParameter("companycode").toString().trim();
        Event=request.getParameter("event")==null?"":request.getParameter("event").toString().trim();
//reqAction=request.getParameter("btn");
//if(reqAction.equalsIgnoreCase("show"))
  

       %>
       <br>
	    <input type=hidden name="event" id="event" value="<%=Event%>"/>
		   <input type=hidden name="companycode" id="companycode" value="<%=Companycode%>"/>
	   </form>
	   <form name=frm3 method=post   >
	   <%
	   if(request.getParameter("x")!=null) {
		Companycode=request.getParameter("companycode")==null?"":request.getParameter("companycode").toString().trim();
        Event=request.getParameter("event")==null?"":request.getParameter("event").toString().trim();
	   %>

 <input type="hidden" name="x">
	   <input type="hidden" name="xx">
	   <table cellpadding=3 cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="95%" bgcolor="white">

<tr bgcolor="silver">
<td class=tablecell align ="right"><B>Backlog Allowed:&nbsp;&nbsp;<input type="checkbox" name="checkbox1" id="checkbox1" value="Y" onclick="enable_text()">
    </B></td><td><INPUT TYPE="text"   name="textbox1" id="textbox1" disabled   style="background-color:#88000 ;border-color:black;font-weight:Bold; FONT-FAMILY: Arial; FONT-SIZE: 10pt;color: black; HEIGHT: 25px; VERTICAL-ALIGN: top; WIDTH: 50px" ></td>
	<td class=tablecell align ="right"><B>Gap Allowed:&nbsp;&nbsp;<input type="checkbox" name="checkbox2" id="checkbox2" value="Y" onclick="enable_text2()">
    </B></td><td><INPUT TYPE="text"   name="textbox2" id="textbox2" disabled   style="background-color:#88000 ;border-color:black;font-weight:Bold; FONT-FAMILY: Arial; FONT-SIZE: 10pt;color: black; HEIGHT: 25px; VERTICAL-ALIGN: top; WIDTH: 50px" ></td>

<td class=tablecell align ="right" ><B>Set Criteria: </B></td><td align="Left">
<SELECT NAME="Set" id="Set" style="background-color:#88000 ;border-color:black;font-weight:Bold; FONT-FAMILY: Arial; FONT-SIZE: 10pt;color: black; HEIGHT: 25px; VERTICAL-ALIGN: top; WIDTH: 95px"   >
<OPTION VALUE="" SELECTED><-Select-></OPTION>
<%	
		  // out.print("***********"+QrySet);
  QrySet=" select distinct  cset from TP#ELIGIBILITYCRITERIA where eventcode='"+Event+"' and companycode='"+Companycode+"' order by cset  ";
  rsSet=db.getRowset(QrySet);
  //out.print(QrySet);
	   while(rsSet.next())
    {
%><OPTION VALUE=<%=rsSet.getString("cset")%>><%=rsSet.getString("cset")%></OPTION>

<%
	}
	   
	   %>	
	   <OPTION VALUE="ALL"  >ALL</OPTION>
</SELECT></td>
        <td class=tablecell align ="right">
                <B>&nbsp;Institute :&nbsp;</B>
					</td>
						 <td> <%
            qry = " select distinct Institutecode from  TP#INSTITUTE where companycode='"+Companycode+"' and eventcode='"+Event+"' ";
            rs = db.getRowset(qry);
%>

            <%
            while (rs.next()) {

if(rs.getString("Institutecode").equals("JIIT") || rs.getString("Institutecode").equals("JUIT") || rs.getString("Institutecode").equals("JUET") || rs.getString("Institutecode").equals("JASR") || rs.getString("Institutecode").equals("J128")  ) {

Selected="checked" ;




                count++;
                if (count == 1) {
            %> <font color="black" face=Verdana size=2><input type="checkbox" name="checkinst" id="checkinst"   <%=Selected%>  value="<%=rs.getString(1).toString().trim()%> "   ><STRONG><%=rs.getString(1).toString().trim()%></STRONG></font>&nbsp;<%
                } else {
            %> <font color="black" face=Verdana size=2><input type="checkbox" name="checkinst" id="checkinst"     <%=Selected%>  value="<%=rs.getString(1).toString().trim()%>"><STRONG><%=rs.getString(1).toString().trim()%></STRONG></font>&nbsp;<%
                }

}else{
	Selected="";


  count++;
                if (count == 1) {
            %> <font color="black" face=Verdana size=2><input type="checkbox" name="checkinst" id="checkinst"   <%=Selected%>  value="<%=rs.getString(1).toString().trim()%>"   ><STRONG><%=rs.getString(1).toString().trim()%></STRONG></font>&nbsp;<%
                } else {
            %> <font color="black" face=Verdana size=2><input type="checkbox" name="checkinst" id="checkinst"     <%=Selected%>  value="<%=rs.getString(1).toString().trim()%>"><STRONG><%=rs.getString(1).toString().trim()%></STRONG></font>&nbsp;<%
                }
				}
	            }
            %>
			</td><td class=tablecell>
                &nbsp; <input type=submit style="background-color:#88000 ;border-color:black;font-weight:Bold; FONT-FAMILY: Arial; FONT-SIZE: 10pt;color: black; HEIGHT: 25px; VERTICAL-ALIGN: top; WIDTH: 95px"  value="Submit" tabindex=88> &nbsp;

            </td>
 
</tr></table>
<input type=hidden name="event" id="event" value="<%=Event%>"/>
<input type=hidden name="companycode" id="companycode" value="<%=Companycode%>"/>
</form>
<form name=frm2  method=post action="ChooseHeader.jsp" target="_New" onsubmit="window.open('', this.target,    'width=500,height=700,resizable,scrollbars=yes'); return true;" >
  <input type="hidden" name="xxx">
 <%
}
//out.print("***************/*/*/*/*/*/*/*/");
 if (request.getParameter("xx") != null) {
	 
qrytt=" delete from  TP#STUDENTQUALIFICATION ";
int uy=db.update(qrytt);
        
		
Connection connection = db.getDataConn();

CallableStatement cs = connection.prepareCall("{call TP.POPTPQUALIFICATION()}");//conn.prepareCall("{call myproc(?)}");
 cs.execute();
connection.close();
 connection = null;
hh=1;
 
qryF=" select 'Y' from  TP#STUDENTQUALIFICATION   ";
		RsF = db.getRowset(qryF);
		if (RsF.next())
		//if (1==1)
		{

  Companycode=request.getParameter("companycode")==null?"":request.getParameter("companycode").toString().trim();
        Event=request.getParameter("event")==null?"":request.getParameter("event").toString().trim();

	// out.print("***************/*/*/*/*/*/*/*/"); ALL
	 
 	//String mInstCode = "";
            String[] mInstCodes = request.getParameterValues("checkinst");

            for (int j = 0; j<mInstCodes.length; j++) {
                if (j == 0) {
                    mInstCode = mInstCode + "'" + mInstCodes[j] + "'";
                } else {
                    mInstCode = mInstCode + ",'" + mInstCodes[j] + "'";
                }

                }

xSet=request.getParameter("Set")==null?"":request.getParameter("Set").toString().trim();


xBcklog=request.getParameter("checkbox1")==null?"":request.getParameter("checkbox1").toString().trim();

xNoBcklog=request.getParameter("textbox1")==null?"":request.getParameter("textbox1").toString().trim();


if(xBcklog.equals("Y")){ xNoBcklog=xNoBcklog;   }else{xNoBcklog="0";}

xgaplog=request.getParameter("checkbox2")==null?"":request.getParameter("checkbox2").toString().trim();

xNogaplog=request.getParameter("textbox2")==null?"":request.getParameter("textbox2").toString().trim();


if(xgaplog.equals("Y")){ xNogaplog=xNogaplog;   }else{xNogaplog="0";}
				//out.print(xNoBcklog+"*********"+xBcklog);  


mInstCode=mInstCode.toString().trim();

 %>
 
<table cellpadding=3 cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="95%" bgcolor="white">
<tr bgcolor="silver">
 <td  bgcolor="#F2F2F2"><B>Student(s) In Criteria </B></td>
<td  bgcolor="red"><B>Not Intrested student(s) </B></td>
<td bgcolor="#95EE95"><B>Intrested  student(s)</B></td>
<td  bgcolor="#FFD000"><B>Special Case student(s) </B></td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="Special Approval (Add Student)"
 onClick="window.open('SpecialApproval.jsp?id7=<%=request.getParameter("companycode")%>&id8=<%=request.getParameter("event")%>','parameterswindow')"/> </td></tr></table>

       <table cellpadding=3 cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="95%" bgcolor="white">
<tr bgcolor="silver" align="left">
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Select</STRONG></font></th>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>S/No.</STRONG></font></th>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Institute</STRONG></font></th>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Academic Year</STRONG></font></th>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Enrollment</STRONG></font></th>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Student</STRONG></font></th>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Program</STRONG></font></th>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Branch</STRONG></font></th>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Section</STRONG></font></th>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>SubSection</STRONG></font></th>
<th><font  face=arial size=2 color="#a52a2a" align="left"><STRONG>Semester</STRONG></font></th>
<!-- <th><font  face=arial size=2 color="#a52a2a"><STRONG>Modify</STRONG></font></th>
<th><font  face=arial size=2 color="#a52a2a"><STRONG>Delete</STRONG></font></th> -->  
</tr>

<%
try{


qry=" select studentid,Institutecode,Academicyear,Enrollmentno, Studentname,programcode,branchcode,sectioncode,SUBSECTIONCODE,semester,FAILTOTAL from ( ";


qry=qry+" select studentid studentid ,nvl(Institutecode,'')Institutecode,nvl(Academicyear,'') Academicyear,nvl(Enrollmentno,'')Enrollmentno,nvl(Studentname,'')Studentname,nvl(programcode,'')programcode,nvl(branchcode,'')branchcode,nvl(sectioncode,'')sectioncode,nvl(SUBSECTIONCODE,'')SUBSECTIONCODE,nvl(semester,'')semester , ";
   qry=qry+"        (SELECT   DISTINCT COUNT (SUBJECTID) ";
   qry=qry+"           FROM   StudentRESULT e ";
   qry=qry+"          WHERE       e.studentid = k.studentid ";
     qry=qry+"                AND e.Institutecode = k.institutecode ";
    qry=qry+"                 AND e.FAIL = 'Y') ";
    qry=qry+"          FAILTOTAL from v#studentmaster k where nvl(deactive,'N')='N' and institutecode IN ("+mInstCode+")    " ;
qry=qry+"  and studentid IS NOT NULL ";
qry5=" select  distinct cset from  TP#ELIGIBILITYCRITERIA where companycode='"+Companycode+"' and eventcode='"+Event+"' and cset=decode('"+xSet+"','ALL',cset,'"+xSet+"' )  ";
rs5=db.getRowset(qry5);
//out.print(qry5);
while(rs5.next())
	{

	csst++;
//out.print("*********************"+csst);
	if(csst>2){
	 qry=qry+" OR (  institutecode IN ("+mInstCode+")  ";
	}
qry2=" select CRITERIAID ,CRITERIAOPERATORBEFORE  ,slno  from  TP#ELIGIBILITYCRITERIA where companycode='"+Companycode+"' and eventcode='"+Event+"' and cset='"+rs5.getString("cset")+"' ";
rs2=db.getRowset(qry2);
//out.print(qry2);
while(rs2.next())
{
mCritvales="";
	//out.print(qry);
qry4=" select CRITERIAID ,CRITERIATABLE ,CRITERIAFIELD  from TP#CRITERIAMASTER where criteriaid='"+rs2.getString("CRITERIAID")+"' ";

rs4=db.getRowset(qry4);
if(rs4.next())
{

	//if(csst>2){
	// qry=qry+"     ";
	//}else{
	// qry=qry+" and    ";
	//}
 qry=qry+" and  studentid IN ( select studentid from "+rs4.getString("CRITERIATABLE")+" where   ";

 qry3=" select CRITERIAVALUE,SUBSLNO  from  TP#ELIGIBILITYCRITERIAVALUE  where companycode='"+Companycode+"' and eventcode='"+Event+"' and cset='"+rs5.getString("cset")+"'  and  criteriaid='"+rs2.getString("CRITERIAID")+"' and    slno='"+rs2.getString("slno")+"'  ";
rs3=db.getRowset(qry3);
while(rs3.next())
{
if (mCritvales.equals("")) {
    mCritvales = mCritvales + "'" +rs3.getString("CRITERIAVALUE")+ "'";
} 
else {
    mCritvales = mCritvales + ",'" +rs3.getString("CRITERIAVALUE")+ "'";
}
	 
}

qry3=" select CRITERIAVALUE,SUBSLNO  from  TP#ELIGIBILITYCRITERIAVALUE  where companycode='"+Companycode+"' and eventcode='"+Event+"' and cset='"+rs5.getString("cset")+"'  and  criteriaid='"+rs2.getString("CRITERIAID")+"' and    slno='"+rs2.getString("slno")+"'  ";
rs3=db.getRowset(qry3);
if(rs3.next())
{
	
qry=qry+"   "+rs4.getString("CRITERIAFIELD")+"   "+rs2.getString("CRITERIAOPERATORBEFORE")+"   ("+mCritvales+")    )   ";
}
}
}
}
if(csst>2){
	 qry=qry+" )  ";
	}
 qry=qry+" union        SELECT b.studentid studentid ,   NVL (b.institutecode, '') institutecode,  NVL (b.academicyear, '') academicyear,   NVL (b.enrollmentno, '') enrollmentno,  NVL (b.studentname, '') studentname, NVL (b.programcode, '') programcode,   NVL (b.branchcode, '') branchcode, NVL (b.sectioncode, '') sectioncode,   NVL (b.subsectioncode, '') subsectioncode, NVL (b.semester, '') semester ,";
    qry=qry+"       (SELECT   DISTINCT COUNT (SUBJECTID)";
      qry=qry+"        FROM   StudentRESULT e";
      qry=qry+"       WHERE       e.studentid = b.studentid";
      qry=qry+"               AND e.Institutecode = b.institutecode";
       qry=qry+"              AND e.FAIL = 'Y')";
       qry=qry+"       FAILTOTAL  FROM TEMP#TPSTUDENTMASTER a,v#studentmaster b    where a.STUDENTID=b.studentid and a.institutecode IN ("+mInstCode+") ";
  
 qry=qry+" union     SELECT b.studentid studentid ,   NVL (b.institutecode, '') institutecode,  NVL (b.academicyear, '') academicyear,   NVL (b.enrollmentno, '') enrollmentno,  NVL (b.studentname,'' ) studentname, NVL (b.programcode, '') programcode,   NVL (b.branchcode, '') branchcode, NVL (b.sectioncode, '') sectioncode,   NVL (b.subsectioncode, '') subsectioncode, NVL (b.semester, '') semester,";
         qry=qry+"   (SELECT   DISTINCT COUNT (SUBJECTID)";
         qry=qry+"      FROM   StudentRESULT e";
         qry=qry+"     WHERE       e.studentid = b.studentid";
         qry=qry+"             AND e.Institutecode = b.institutecode";
         qry=qry+"             AND e.FAIL = 'Y')";
         qry=qry+"      FAILTOTAL    FROM TP#REGISTRATIONDETAIL a, v#studentmaster b    where a.studentid = b.studentid  and a.INSTITUTECODE=b.INSTITUTECODE  and a.ACADEMICYEAR=b.ACADEMICYEAR  and a.PROGRAMCODE=b.PROGRAMCODE  and a.companycode='"+Companycode+"'  and a.EVENTCODE='"+Event+"'  and nvl(a.STATUS,'X')='I' and a.institutecode IN ("+mInstCode+")  ";

 qry=qry+"  order by Studentname ";

 qry=qry+" ) xx where xx.failtotal <='"+xNoBcklog+"' ";

   out.print(qry);
rs=db.getRowset(qry);
 
 
while(rs.next())
{
slno++;
int hhh=0;
QERCLOR=" select studentid from  TEMP#TPSTUDENTMASTER where studentid='"+rs.getString("studentid")+"' and companycode='"+Companycode+"' and eventcode='"+Event+"'  ";
rsQERCLOR=db.getRowset(QERCLOR);
//out.print(slno+"-"+QERCLOR);
if(rsQERCLOR.next())
{
	mcolor="#FFD000";
	hhh=1;
}


int yyy=0;
QERCLORR=" select studentid from   TP#REGISTRATIONDETAIL where studentid='"+rs.getString("studentid")+"' and companycode='"+Companycode+"' and eventcode='"+Event+"' and nvl(status,'A')='I' ";
rsQERCLORR=db.getRowset(QERCLORR);
//out.print(slno+"-"+QERCLOR);
 if(rsQERCLORR.next())
{
	mcolor="#95EE95";
	yyy=1;
}


int xxx=0;
QERCLORRN=" select studentid from   TP#REGISTRATIONDETAIL where studentid='"+rs.getString("studentid")+"' and companycode='"+Companycode+"' and eventcode='"+Event+"' and nvl(status,'A')='N' ";
rsQERCLORRN=db.getRowset(QERCLORRN);
//out.print(slno+"-"+QERCLOR);
 if(rsQERCLORRN.next())
{
	mcolor="red";
	xxx=1;
}


if(yyy ==0 && hhh==0 && xxx==0 ) {
mcolor="#F2F2F2";
hhh=0;
yyy=0;
xxx=0;
}


 

	
	%>
<tr bgcolor=<%=mcolor%>>
<td align="left"><INPUT TYPE="checkbox" NAME="Select<%=slno%>" value=<%=rs.getString("studentid")%>></td>
<td align="left"><%=slno%></td>
<td align="left"><%=rs.getString("Institutecode")%></td>
<td align="left"><%=rs.getString("Academicyear")%></td>
<td align="left"><%=rs.getString("Enrollmentno")%></td>
<td align="left"><%=rs.getString("Studentname")%></td>
<td align="left"><%=rs.getString("programcode")%></td>
<td align="left"><%=rs.getString("branchcode")%></td>
<td align="left"><%=rs.getString("sectioncode")%></td>
<td align="left"><%=rs.getString("SUBSECTIONCODE")%></td>
<td align="left"><%=rs.getString("semester")%></td>
</tr>



<%
	
if(request.getParameter("Select"+slno)!=null)
           {
     %>
	 <input type=hidden NAME="Select<%=slno%>" ID="Select<%=slno%>"  value="<%=rs.getString("studentid")%>"/>
	 <%
           }
      

%>
<!-- <input type=hidden NAME="Select<%=slno%>" ID="Select<%=slno%>"  value="<%=rs.getString("studentid")%>"/> -->
<%
}
%>
           <input type=hidden name="event" id="event" value="<%=Event%>"/>
		   <input type=hidden name="companycode" id="companycode" value="<%=Companycode%>"/>
		   <input type=hidden name="slno" id="slno" value="<%=slno%>"/>
		   <input type=hidden name="Inst" id="Inst" value="<%=mInstCode%>"/>
		         

<%
}catch(Exception e)
        {
out.print("Error no1:"+e);
}

}else{
   
   out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> No Data Avialable <a href='../../index.jsp' target=_New></a> </font> <br>");
   }
 

 %>
</table>
<table cellpadding=3 cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="95%" bgcolor="white">
<tr bgcolor="silver" align=center><TD>
&nbsp; <input type=submit style="background-color:#88000 ;border-color:black;font-weight:Bold; FONT-FAMILY: Arial; FONT-SIZE: 10pt;color: black; HEIGHT: 30px; VERTICAL-ALIGN: top; WIDTH: 250px"  name="btny"  value ="Save And Load In Excel" onClick="window.open('ChooseHeader.jsp?companycode=<%=Companycode%>&event=<%=Event%>&slno=<%=slno%>&Inst=<%=mInstCode%>','parameterswindow')"> &nbsp;
</TD></tr> 
</TABLE>
<br>

<% 
 }
  }
   
 
 
 
 
   catch(Exception e)
        {
       out.print("error :"+e) ;
  
		}
 %>
 </form></body></html>