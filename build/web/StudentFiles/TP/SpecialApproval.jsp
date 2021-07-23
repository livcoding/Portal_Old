<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp,java.lang.ArrayIndexOutOfBoundsException" %>
<%

        DBHandler db = new DBHandler();
        int rsum=0,ssum=0,tsum=0,usum=0,vsum=0,wsum=0,i=0,l=0,s=0,d=0;
        ResultSet rs =  null;
		ResultSet rst = null;
		ResultSet rsf=  null ;
        ResultSet rsd = null;
        ResultSet rs1 = null;
        ResultSet rs2 = null;
        ResultSet rsc = null ,rssd=null;
        String qry = "" ,qryc="",mSUBB="",mSUBN="", mLTP="",qry1="",inst="",institute="",academic="",academicyear="",Institute = "",mchk="";
		String  qerysd="";  
		String qryt = "",Event="",Programcode="",Companycode="",enrollmentno="",studentid="",studentname="";
        GlobalFunctions gb = new GlobalFunctions();
	    String mRegCode = "",event="", Academicyear="",subsectioncode="";
        String mEXAMCODE = "" ,mSubjID="",DataSublist="" ,mProgCode="",QryProgCode="",companycode="";
        String mAcademicYear = "",program="",programcode="";
        String mProgramCode = "";
        String mInstCode = "";
		String  mreg="" ;
		String mHOSTELTYPE = "" , macade="" ,mbranc="" ,sem="",semester="",branch="",branchcode="" ;
		String mprog="",enddate="",fromdate="";
		String mBranchCode = "",msid="",mCode="",mES="",mSubj1="",qrysubj="",Subject="";
        int n=0;
        String qryx="",mLTP1="",Branch="",table="";
        ResultSet rsx=null;

		String mInst="",mSubject="",minst="" ,qrys="",Semester="";
		int rsum80t1=0,rsum80t2=0,rsum80t3=0,ssum70t1=0,ssum70t2=0,ssum70t3=0,tsum60t1=0,tsum60t2=0,tsum60t3=0,
					usum50t1=0,usum50t2=0,usum50t3=0,vsum40t1=0,vsum40t2=0,vsum40t3=0,wsum30t1=0,wsum30t2=0,wsum30t3=0;
		int count=0 ,Flag=0;

qry="delete from TEMP#TPSTUDENTMASTER ";
//out.print(qry);
int k=db.update(qry);

int ttsum1=0,ttsum2=0,ttsum3=0;

if (session.getAttribute("InstituteCode") == null)
	mInst = "";
else
	mInst = session.getAttribute("InstituteCode").toString().trim();

%>
<HTML>
    <head>
        <TITLE>#### JIIT [ Attendance PercentageWise BreackUp]</TITLE>
		<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<script language="javascript" type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/sortabletable.js"></script>


 
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css"/>
<link type="text/css" rel="StyleSheet" href="css/filtergrid.css"/>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
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
			$("#value").html($("select#academic :selected").text() + "(VALUE: " + $("select#academic").val() + ")");
			$("select").change(function(){
				$("#value").html(this.options[this.selectedIndex].text + " (VALUE: " + this.value + ")");

				if(this.id=="academic"){
					//alert(this.id+"...."+this.value);
				$.get("get_Programcode.jsp",{academic:$("select#academic").val(),dt:getCurrentDateTime()},successfunction);
				}
				if(this.id=="program"){
                $.get("get_branch.jsp",{academic:$("select#academic").val(),program:$("select#program").val(),dated:getCurrentDateTime()},successfunction1);
				}
                if(this.id=="branch"){
                $.get("get_semester.jsp",{academic:$("select#academic").val(),program:$("select#program").val(),branch:$("select#branch").val(),dated:getCurrentDateTime()},successfunction2);
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
				$("select#program").empty();
				$('select#program').append("<option value=\"" + "" + "\">" +"Select"+ "</option>");
				for(var i=0;i<arrayOfStrings.length-1;i++){
                    var t=arrayOfStrings[i];
					$('select#program').append("<option value=\"" + t + "\">" + t+ "</option>");
				}
			}
		}

   }
         function successfunction1(response)
    {
		if (response) {

			var x=response+"";
			//alert(x);
			if(x==""){}
			else{
				var arrayOfStrings = x.split("$");
                //alert(arrayOfStrings);
				$("select#branch").empty();
				$('select#branch').append("<option value=\"" + "" + "\">" +"Select"+ "</option>");
				for(var i=0;i<arrayOfStrings.length-1;i++){
                    var t=arrayOfStrings[i];
					$('select#branch').append("<option value=\"" + t + "\">" + t+ "</option>");
				}
			}
		}

   }
    function successfunction2(response)
    {
		if (response) {

			var x=response+"";
			//alert(x);
			if(x==""){}
			else{
				var arrayOfStrings = x.split("$");
                //alert(arrayOfStrings);
				$("select#SEMESTER").empty();
				$('select#SEMESTER').append("<option value=\"" + "" + "\">" +"Select"+ "</option>");
				for(var i=0;i<arrayOfStrings.length-1;i++){
                    var t=arrayOfStrings[i];
					$('select#SEMESTER').append("<option value=\"" + t + "\">" + t+ "</option>");
				}
			}
		}

   }
 
</script>
<script type="text/javascript">
  function vari()
   {
       var i=document.getElementById("inst").value;
       // alert(i);
     var j=document.getElementById("academic").value;
       var k=document.getElementById("program").value;
       var l=document.getElementById("branch").value;
       var m=document.getElementById("SEMESTER").value;
       var n=document.getElementById("DATE1").value;
       var o=document.getElementById("DATE2").value;
       var p="";
       var q=0;
     if(i==(""))
    {
        p="Institute can not be left blank\n";
        q++ ;
    }
    if(j==(""))
    {
        p=p+"Academic Year can not be left blank\n";
    q++;
    }
    if(k==(""))
    {
        p=p+"Program can not be left blank\n";
        q++;
    }
    if(l==(""))
        {
          p=p+"Branch can not be left blank\n";
        q++;
        }
        if(m==(""))
        {
          p=p+"Semester can not be left blank\n";
        q++;
        }
         if(n==("")||o==(""))
        {
          p=p+"Date fields can not be left blank\n";
        q++;
        }

 if(q>0)
       {
        alert(p);
        return false;
        }
        else
            { 
                //document.getElementById("msg").innerHTML=alert("Records Saved successfuly!!!");
              //  window.close();
              //  return true;
       }
 //alert( "hello");
}
</script>
</head>
    <body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >


        <form name="frm"  method="get" >
        <input id="x" name="x" type=hidden>
        <table cellpadding=3 cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="80%" bgcolor="white">
<tr bgcolor="silver" align=center >
        <td colspan=0 align=middle>
            <font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><FONT SIZE="4" COLOR=""><B>Special Approval ( Add Student )</B></FONT></font></td></tr>
        </table>
       </table><BR><table cellpadding=3 cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="80%" bgcolor="white">
<tr bgcolor="silver" align=center >
<td valign="top" align="right" >
    <!-- <td align="left" valign="right"   nowrap>
<FONT face=Arial size=2><STRONG>Event&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;:</STRONG></FONT>
</td>
 <td align="left" valign="top" nowrap>

<%
Event=request.getParameter("id8")==null?"":request.getParameter("id8").trim();
Companycode=request.getParameter("id7")==null?"":request.getParameter("id7").trim();
//out.print("Event : "+Event);
//out.print("Companycode : "+Companycode);
    %>
</td>
 -->

<font color=black face=arial size=2><STRONG>Institute:</STRONG></font><font color=red face=arial size=2><STRONG>*</STRONG></font>
</td>
<td valign="top" align="left"  ><%
	  qry1="select distinct NVL(INSTITUTECODE,' ') i FROM TP#INSTITUTE";
	  rst=db.getRowset(qry1);
	 // out.print(qry1);
	%>
	<select name="inst" id="inst" tabindex="0" style="WIDTH: 120px;height: 80px"  >
	
	<%
	try
	{
 	if(request.getParameter("x")==null)
	{
		while(rst.next())
		{
		 	inst=rst.getString("i");
			if(institute.equals(""))
 			{
				institute=inst;
				%>
				<OPTION  Value =<%=inst%>><%=inst%></option>
				<%
			}
			else
			{
				%>
				<option value=<%=inst%>><%=inst%></option>
				<%
			}
		}
	}
	else
	{
		while(rst.next())
		{
            inst=rst.getString("i");
		   if(inst.equals(request.getParameter("inst").toString().trim()))
		   {
			institute=inst;
			%>
			<option selected value=<%=inst%>><%=inst%></option>
	 		<%
		   }
		   else
		   {
			%>
			<option  value=<%=inst%>><%=inst%></option>
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

    <!-- <td valign="top" align="left" >
<font color=black face=arial size=2><STRONG>Company&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;:</STRONG></font>
</td>
<td valign="top" align="left">
<%
Companycode=request.getParameter("id7")==null?"":request.getParameter("id7").trim();
//out.print(Companycode);
  %>
</td> -->

<td valign="top" align="right" nowrap >
<font color=black face=arial size=2><STRONG>Academic Year:</STRONG></font><font color=red face=arial size=2><STRONG>*</STRONG></font>
</td>
<td valign="top" align="left" >
<%
try
{
	qry1="select distinct ACADEMICYEAR a FROM v#studentmaster where nvl(Deactive,'N')='N' order by ACADEMICYEAR desc ";
	  rs=db.getRowset(qry1);
	if (request.getParameter("x")==null)
	{
		%>
		<select name="academic" id="academic" style="WIDTH: 120px;height: 80px" >
		<OPTION Value =""><--select--></option>
		<%
		while(rs.next())
		{
			academic=rs.getString("a");
			%>
				<OPTION Value ="<%=academic%>"><%=rs.getString("a")%></option>
			<%
		}
		%>
		</select>
		<%
	}
	else
	{
		%>
		<select name="academic" id="academic" style="WIDTH: 120px;height: 80px">
		<OPTION Value =""><--select--></option>
		<%
		while(rs.next())
		{
			academic=rs.getString("a");
			if(academic.equals(request.getParameter("academic").toString().trim()))
 			{
			%>
				<OPTION selected Value ="<%=academic%>"><%=rs.getString("a")%></option>
			<%
		     	}
		     	else
		      {
				%>
		      	<OPTION Value ="<%=academic%>"><%=rs.getString("a")%></option>
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
	 out.println("Error Msg1"+e);
    }
    %>

</td>
<td valign="top" align="right" >
<font color=black face=arial size=2><STRONG>Program Code:</STRONG></font><font color=red face=arial size=2><STRONG>*</STRONG></font>
</td>
<td valign="top" align="left" >
<%
try
{
	 qry1="select distinct NVL(PROGRAMCODE,' ') p FROM v#studentmaster where nvl(Deactive,'N')='N' and ACADEMICYEAR='"+academic+"'";
	  rst=db.getRowset(qry1);
	if (request.getParameter("x")!=null)
	{
		%>
		<select name="program" id="program"  style="WIDTH: 120px;height: 80px" >
        <OPTION Value =""><--select--></option>
		<%
		while(rst.next())
		{
			program=rst.getString("p");
			%>
				<OPTION Value ="<%=program%>"><%=rst.getString("p")%></option>
			<%
		}
		%>
		</select>
		<%
	}
	else
	{
		%>
		<select name="program" id="program"  style="WIDTH: 120px;height: 80px" >
		  <OPTION Value =""><--select--></option>
        <%
		while(rst.next())
		{
			program=rst.getString("p");
			if(program.equals(request.getParameter("program").toString().trim()))
 			{
			%>
				<OPTION selected Value ="<%=program%>"><%=rst.getString("p")%></option>
			<%
		     	}
		     	else
		      {
				%>
		      	<OPTION Value ="<%=program%>"><%=rst.getString("p")%></option>
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
	 out.println("Error Msg2"+e);
    }
    %>
	
</td>
</tr>
<tr bgcolor="silver" align=center >
<td valign="top" align="right" >
<font color=black face=arial size=2><STRONG>Branch:</STRONG></font><font color=red face=arial size=2><STRONG>*</STRONG></font>
</td>
<td valign="top" align="left" >
    <%
try
{
	 qry1="select distinct NVL(BRANCHCODE,' ') b FROM v#studentmaster where nvl(Deactive,'N')='N' and PROGRAMCODE='"+program+"' and ACADEMICYEAR='"+academic+"'";
	  rst=db.getRowset(qry1);
	if (request.getParameter("x")!=null)
	{
		%>
		<select name="branch" id="branch" style="WIDTH: 120px;height: 80px">
		  <OPTION Value =""><--select--></option>
        <%
		while(rst.next())
		{
			branch=rst.getString("b");
			%>
				<OPTION Value ="<%=branch%>"><%=rst.getString("b")%></option>
			<%
		}
		%>
		</select>
		<%
	}
	else
	{
		%>
		<select name="branch" id="branch"  style="WIDTH: 120px;height: 80px">
		  <OPTION Value =""><--select--></option>
        <%
		while(rst.next())
		{
			branch=rst.getString("b");
			if(branch.equals(request.getParameter("branch").toString().trim()))
 			{
			%>
				<OPTION selected Value ="<%=branch%>"><%=rst.getString("b")%></option>
			<%
		     	}
		     	else
		      {
				%>
		      	<OPTION Value ="<%=branch%>"><%=rst.getString("b")%></option>
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
	 out.println("Error Msg3"+e);
    }
    %>
</td>
<td valign="top" align="right" >
<font color=black face=arial size=2><STRONG>Semester:</STRONG></font><font color=red face=arial size=2><STRONG>*</STRONG></font>
</td>
<td valign="top" align="left" >
    <%
    try
{
	 qry1="select distinct NVL(SEMESTER,0) s FROM v#studentmaster where nvl(Deactive,'N')='N' and PROGRAMCODE='"+program+"' and ACADEMICYEAR='"+academic+"' and BRANCHCODE='"+branch+"'";
	  rst=db.getRowset(qry1);
	if (request.getParameter("x")!=null)
	{
		%>
		<select name="SEMESTER" id="SEMESTER" style="WIDTH: 120px;height: 80px" >
		  <OPTION Value =""><--select--></option>
        <%
		while(rst.next())
		{
			sem=rst.getString("s");
			%>
				<OPTION Value ="<%=sem%>"><%=rst.getString("s")%></option>
			<%
		}
		%>
		</select>
		<%
	}
	else
	{
		%>
		<select name="SEMESTER" id="SEMESTER"  style="WIDTH: 120px;height: 80px" >
		  <OPTION Value =""><--select--></option>
        <%
		while(rst.next())
		{
			sem=rst.getString("s");
			if(sem.equals(request.getParameter("SEMESTER").toString().trim()))
 			{
			%>
				<OPTION selected Value ="<%=sem%>"><%=rst.getString("s")%></option>
			<%
		     	}
		     	else
		      {
				%>
		      	<OPTION Value ="<%=sem%>"><%=rst.getString("s")%></option>
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
	 out.println("Error Msg4"+e);
    }
    %>
    
</td>
 
 

     
    <td   align="right">
        <input type="Submit" value="Submit" style="WIDTH: 100px " onclick="return vari();">
            </td><td></td>

    </tr>
    </table>
           <input type=hidden name="Event" id="Event" value="<%=Event%>"/>
          <input type=hidden name="Institute" id="Institute" value="<%=Institute%>"/>
          <input type=hidden name="academic" id="academic" value="<%=Academicyear%>"/>
          <input type=hidden name="Prog" id="Prog" value="<%=Programcode%>"/>
          <input type=hidden name="branch" id="branch" value="<%=Branch%>"/>
          <input type=hidden name="SEMESTER" id="SEMESTER" value="<%=Semester%>"/>
          <input type=hidden name="companycode" id="companycode" value="<%=Companycode%>"/>
    </form>
    <form name="a" id="a" method="post">
    <input type="hidden" name="Y" id="Y" />
    <%
try
	{

   //System.out.println("***************");
 	if(request.getParameter("x")!=null)
	{
          Programcode=request.getParameter("program")==null?"":request.getParameter("program").trim();
          Academicyear=request.getParameter("academic")==null?"":request.getParameter("academic").trim();
          Institute =request.getParameter("inst").trim()==null?"":request.getParameter("inst").trim();
          Branch=request.getParameter("branch")==null?"":request.getParameter("branch").trim();
          Semester=request.getParameter("SEMESTER")==null?"":request.getParameter("SEMESTER").trim(); 
          Event=request.getParameter("Event")==null?"":request.getParameter("Event").trim();
          Companycode=request.getParameter("companycode")==null?"":request.getParameter("companycode").trim();
          %>
<%
           //System.out.println("########################");




//out.print("sgfsxsxhsm"+Institute.length);
String mcheck="";
%>

<BR>
     <p style="text-align:right;width:500px;">

           <span style="font-weight:bold;">Search:</span> <input type="text" id="txtSearch" name="txtSearch" maxlength="50" />&nbsp; 
           <img id="imgSearch" src="images/cancel.gif" alt="Cancel Search" title="Cancel Search" style="width:150px;width:14px;height:14px;" />
           </p>
     
    <table cellpadding=3  id="tblSearch" c class="mytable filterable" cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="80%" bgcolor="white">
<tr bgcolor="silver"><td>Select</td><td>Institute</td><td>Academicyear</td><td>Enrollmentno</td><td>Studentname</td><td>Program-Branch-Sec.</td></tr>
<%
 
qry1=" SELECT studentid,institutecode,academicyear,enrollmentno,studentname,programcode,branchcode,semester,SECTIONCODE,SUBSECTIONCODE  FROM v#studentmaster  WHERE institutecode ='"+Institute+"'   AND programcode = '"+Programcode+"'   AND NVL (deactive, 'N') = 'N'   AND branchcode = '"+Branch+"'   AND academicyear = '"+Academicyear+"'   AND semester = '"+Semester+"' ";
//out.print(qry1);

  rs1=db.getRowset(qry1);
  while(rs1.next())
  {i++;
	  studentname=rs1.getString("studentname");
      subsectioncode=rs1.getString("SUBSECTIONCODE");
      studentid=rs1.getString("studentid");
      enrollmentno=rs1.getString("enrollmentno");
     %>
	<tr>
    <td><INPUT TYPE="checkbox" NAME="chk<%=i%>" id="chk<%=i%>" value="Y"> </td>
	<td><%=rs1.getString("institutecode")%></td>
	<td><%=rs1.getString("academicyear")%></td>
	<td><%=rs1.getString("enrollmentno")%></td>
	<td><%=rs1.getString("studentname")%></td>
	<td><%=rs1.getString("programcode")%>-<%=rs1.getString("branchcode")%>-<%=rs1.getString("semester")%>-<%=rs1.getString("SUBSECTIONCODE")%></td>
	<input type=hidden name="studentid<%=i%>" id="studentid<%=i%>" value="<%=studentid%>"/>
 
	</tr>

    <%}%>
  

 
     
     </table>
	 <script language="javascript" type="text/javascript">

			  jQuery.expr[":"].containsNoCase = function(el, i, m) {

              var search = m[3];

              if (!search) return false;

              return eval("/" + search + "/i").test($(el).text());
			  };


			jQuery(document).ready(function() {

               // used for the first example in the blog post

               jQuery('li:contains(\'DotNetNuke\')').css('color', '#0000ff').css('font-weight', 'bold');

  

              // hide the cancel search image

               jQuery('#imgSearch').hide();

  

              // reset the search when the cancel image is clicked

               jQuery('#imgSearch').click(function() {

                  resetSearch();

               });

   
             // cancel the search if the user presses the ESC key

               jQuery('#txtSearch').keyup(function(event) {

                 if (event.keyCode == 27) {

                     resetSearch();

                   }

              });

  

              // execute the search

               jQuery('#txtSearch').keyup(function() {

                  // only search when there are 3 or more characters in the textbox

                 if (jQuery('#txtSearch').val().length > 2) {

                 // hide all rows

                 jQuery('#tblSearch tr').hide();

                 // show the header row

                 jQuery('#tblSearch tr:first').show();

                 // show the matching rows (using the containsNoCase from Rick Strahl)

                       jQuery('#tblSearch tr td:containsNoCase(\'' + jQuery('#txtSearch').val() + '\')').parent().show();

                      // show the cancel search image

                    jQuery('#imgSearch').show();

                  }

                else if (jQuery('#txtSearch').val().length == 0) {

                      // if the user removed all of the text, reset the search

                    resetSearch();

                  }

   

                   // if there were no matching rows, tell the user

                if (jQuery('#tblSearch tr:visible').length == 1) {

                     // remove the norecords row if it already exists

                      jQuery('.norecords').remove();

                      // add the norecords row

                     jQuery('#tblSearch').append('<tr class="norecords"><td colspan="5" class="Normal">No records were found</td></tr>');

                  }

             });

          });

 
          function resetSearch() {

             // clear the textbox

             jQuery('#txtSearch').val('');

            // show all table rows

            jQuery('#tblSearch tr').show();

             // remove any no records rows

             jQuery('.norecords').remove();

             // remove the cancel search image

             jQuery('#imgSearch').hide();

             // make sure we re-focus on the textbox for usability

             jQuery('#txtSearch').focus();

         }

     

</script>
<table cellpadding=3 cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="80%" bgcolor="white"><tr><td align="center" colspan="8"><input type="Submit" value="Add Student"></td></tr></table>
	 
          <input type="hidden" id="i" name="i" value="<%=i%>">
          <input type=hidden name="Event" id="Event" value="<%=Event%>"/>
          <input type=hidden name="Institute" id="Institute" value="<%=Institute%>"/>
          <input type=hidden name="academic" id="academic" value="<%=Academicyear%>"/>
          <input type=hidden name="Prog" id="Prog" value="<%=Programcode%>"/>
          <input type=hidden name="branch" id="branch" value="<%=Branch%>"/>
          <input type=hidden name="SEMESTER" id="SEMESTER" value="<%=Semester%>"/>
          <input type=hidden name="companycode" id="companycode" value="<%=Companycode%>"/>
          
        

    <%
        }
    if(request.getParameter("Y")!=null)
//
    { 
		//System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
		Event=request.getParameter("Event")==null?"":request.getParameter("Event").trim();
        Companycode=request.getParameter("companycode")==null?"":request.getParameter("companycode").trim();
        studentid=request.getParameter("studentid")==null?"":request.getParameter("studentid").trim();
        studentname=request.getParameter("studentname")==null?"":request.getParameter("studentname").trim();
       subsectioncode=request.getParameter("subsectioncode")==null?"":request.getParameter("subsectioncode").trim();
	   Institute =request.getParameter("Institute")==null?"":request.getParameter("Institute").trim();
       enrollmentno=request.getParameter("enrollmentno")==null?"":request.getParameter("enrollmentno").trim();
        s=Integer.parseInt(request.getParameter("i"));
  // out.print("123"+Event+"");
      for(int j=1;j<=s;j++)
      {%>
       
        <%//out.print("student idno."+studentid);
       //  out.print("GYANNNN"+request.getParameter("chk"+j));
      if(request.getParameter("chk"+j)==null)
           {
        mchk="N";
           }
     else{
     mchk="Y";
        }
     
//System.out.println("///////////////////////////");




     //   out.print("hello"+mchk);
    if(mchk.equals("Y"))
        {  
		///System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@");
         // out.print("hello");
//out.print("EVENT : "+Event+"Companycode"+Companycode+"institute :"+Institute+" Academicyear :"+Academicyear+" Programcode :"+Programcode+" Semester :"+Semester+" Branch :"+Branch);
            Event=request.getParameter("Event")==null?"":request.getParameter("Event").trim();
            Companycode=request.getParameter("companycode")==null?"":request.getParameter("companycode").trim();
        //  Programcode=request.getParameter("Prog")==null?"":request.getParameter("Prog").trim();
          //Academicyear=request.getParameter("academic")==null?"":request.getParameter("academic").trim();
           // out.print("#####////////////#####AAAAAAAAAAAAAA");
          //Institute =request.getParameter("Institute")==null?"":request.getParameter("Institute").trim();
           //Branch=request.getParameter("branch")==null?"":request.getParameter("branch").trim();
         // Semester=request.getParameter("SEMESTER")==null?"":request.getParameter("SEMESTER").trim();
          studentid=request.getParameter("studentid"+j)==null?"":request.getParameter("studentid"+j).trim();
      

qerysd=" select INSTITUTECODE, ACADEMICYEAR,ENROLLMENTNO,PROGRAMCODE,BRANCHCODE ,SEMESTER,SUBSECTIONCODE from v#studentmaster where studentid='"+studentid+"' and nvl(deactive,'N')='N' and academicyear='"+Academicyear+"' ";
rssd=db.getRowset(qerysd);
while(rssd.next())
{

            
          qry="INSERT INTO TEMP#TPSTUDENTMASTER (INSTITUTECODE,EVENTCODE ,COMPANYCODE , STUDENTID, ACADEMICYEAR, ENROLLMENTNO, PROGRAMCODE, BRANCHCODE," +
     " SEMESTER,SUBSECTIONCODE, FLAG ,entrydate) VALUES ('"+rssd.getString("INSTITUTECODE")+"','"+Event+"', '"+Companycode+"','"+studentid+"','"+rssd.getString("ACADEMICYEAR")+"' " +
     ",'"+rssd.getString("ENROLLMENTNO")+"','"+rssd.getString("PROGRAMCODE")+"','"+rssd.getString("BRANCHCODE")+"' ,'"+rssd.getString("SEMESTER")+"', " +
     "'"+rssd.getString("SUBSECTIONCODE")+"','S' ,sysdate)";
   //  out.print(qry);
    l=db.insertRow(qry);
}
}}}
    if(l>0)
    {
out.print("<center><font size=4 color=green>Record Saved ......</font></center>");

    
 %>
<!--table cellpadding=3 cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="80%" bgcolor="white">
<tr bgcolor="silver"><td>Institute</td><td>Academicyear</td><td>Enrollmentno</td><td>Studentname</td><td>Program-Branch-Sec.</td></tr>
<%
//for(int y=0;y<=d;y++)


{
%>
	<tr>
	<td><%=Institute%></td>
	<td><%=Academicyear%></td>
	<td><%=enrollmentno%></td>
	<td><%=studentname%></td>
	<td><%=program%>-<%=Branch%>-<%=Semester%>-<%=subsectioncode%></td>
	
	</tr>
	 
    <%}%>
     </table-->
  <%//  out.print(mchk);
   //out.print("value of Y"+request.getParameter("y"));
   //out.print("value of X"+request.getParameter("x"));
     
 }
 
    }catch(Exception e)
            {
        out.print("Error is"+e);
    }%>

	
</form>
</body>
</html>