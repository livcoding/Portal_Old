<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp,java.lang.ArrayIndexOutOfBoundsException" %>
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
        int n=0;
        String qryx="",mLTP1="",Branch="",table="";
        ResultSet rsx=null;

		String mInst="",mSubject="",minst="" ,qrys="",Semester="";
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
			$("#value").html($("select#academic :selected").text() + " (VALUE: " + $("select#academic").val() + ")");
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


        <form name="frm"  method="post" >
        <input id="x" name="x" type=hidden>
        <table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
        <tr>
        <td colspan=0 align=middle>
            <font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><FONT SIZE="4" COLOR=""><B><u>Reg. Parameter</u></B></FONT></font></td></tr>
        </table>
        <table cellpadding=3 cellspacing=2 align=center rules=groups border=3 width="80%">
<tr>
<td align="left" valign="right"   nowrap>
<FONT face=Arial size=2><STRONG>Event&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;:</STRONG></FONT>
</td>
 <td align="left" valign="top" nowrap>

<%
Event=request.getParameter("id8")==null?"":request.getParameter("id8").trim();
   out.print(Event);
	
    %>
</td>

<td valign="top" align="right" >
<font color=black face=arial size=2><STRONG>Institute:</STRONG></font><font color=red face=arial size=2><STRONG>*</STRONG></font>
</td>
<td valign="top" align="left"  rowspan="2"><%
	  qry1="select distinct NVL(INSTITUTECODE,' ') i FROM TP#INSTITUTE";
	  rst=db.getRowset(qry1);
	 // out.print(qry1);
	%>
	<select name="inst" id="inst" tabindex="0" style="WIDTH: 120px;height: 80px"  multiple="multiple">
	
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
</tr>
<tr>
    <td valign="top" align="left" >
<font color=black face=arial size=2><STRONG>Company&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;:</STRONG></font>
</td>
<td valign="top" align="left">
<%
Companycode=request.getParameter("id7")==null?"":request.getParameter("id7").trim();
out.print(Companycode);
  %>
</td>
<tr>
<td valign="top" align="left" nowrap >
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
		<select name="academic" id="academic" style="WIDTH: 90px;" >
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
		<select name="academic" id="academic" style="WIDTH: 90px;" >
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
		<select name="program" id="program"  style="WIDTH: 120px;" >
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
		<select name="program" id="program"  style="WIDTH: 120px;" >
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
<tr>
<td valign="top" align="left" nowrap>
<font color=black face=arial size=2><STRONG>Branch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</STRONG></font><font color=red face=arial size=2><STRONG>*</STRONG></font>
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
		<select name="branch" id="branch"  style="WIDTH: 90px;">
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
		<select name="branch" id="branch"  style="WIDTH: 90px;">
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
		<select name="SEMESTER" id="SEMESTER"  style="WIDTH: 120px;" >
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
		<select name="SEMESTER" id="SEMESTER"  style="WIDTH: 120px;" >
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
</tr>
<tr>
<td valign="top" align="left"  nowrap>
<font color=black face=arial size=2><STRONG>From Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
:</STRONG></font><font color=red face=arial size=2><STRONG>*</STRONG></font>

</td>
<td nowrap><INPUT TYPE="text" readonly NAME=DATE1 ID=DATE1 size=9 tabindex=1 VALUE=''
	maxlength=10><a href="javascript:NewCal('DATE1','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>
	</td>
	
	<td nowrap align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>To</b>
    <font color=green face=arialblack font size=2><b>(DD-MM-YYYY)&nbsp;</b></font><strong>:</strong></td>
   <td nowrap align="LEFT">
    <INPUT TYPE="text" NAME=DATE2 ID=DATE2 size=9 tabindex=2 readonly
	VALUE='' maxlength=10 ><a href="javascript:NewCal('DATE2','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>&nbsp;
    </td>
</tr>

    <tr>
    <td colspan="4" align="center">
        <input type="Submit" value="Save Parameters" onclick="return vari();">
            </td>
    </tr>
    </table>
    
    <%
try
	{
 	if(request.getParameter("x")!=null)
	{
        fromdate=request.getParameter("DATE1")==null?" ":request.getParameter("DATE1").toString().trim();
        enddate=request.getParameter("DATE2")==null?" ":request.getParameter("DATE2").toString().trim();
         
         
          String[] Institute = {"ALL"};
        
          Programcode=request.getParameter("program")==null?"":request.getParameter("program").trim();
          Academicyear=request.getParameter("academic")==null?"":request.getParameter("academic").trim();
          Institute =request.getParameterValues("inst");
          Branch=request.getParameter("branch")==null?"":request.getParameter("branch").trim();
          Semester=request.getParameter("SEMESTER")==null?"":request.getParameter("SEMESTER").trim();
    



%>
           <input type=hidden name="Event" id="Event" value="<%=Event%>"/>
          <input type=hidden name="Institute" id="Institute" value="<%=Institute%>"/>
          <input type=hidden name="academic" id="academic" value="<%=Academicyear%>"/>
          <input type=hidden name="Prog" id="Prog" value="<%=Programcode%>"/>
          <input type=hidden name="branch" id="branch" value="<%=Branch%>"/>
          <input type=hidden name="SEMESTER" id="SEMESTER" value="<%=Semester%>"/>
          <input type=hidden name="companycode" id="companycode" value="<%=Companycode%>"/>
<%


if(Institute.equals("") || Institute==null)
{

Institute[0]="ALL";

}
//out.print("sgfsxsxhsm"+Institute.length);


                             for(int i=0;i<Institute.length;i++)
        {
       
   Institute[i]=Institute[i]==null?"":Institute[i];
     
//out.print(Institute[i]);
        qry="select 'Y' from TP#REGISTRATIONPARAMETERS where" +
           " EVENTCODE='"+Event+"' and INSTITUTECODE='"+Institute[i]+"' and ACADEMICYEAR='"+Academicyear+"'" +
           " and PROGRAMCODE='"+Programcode+"' and SECTIONBRANCH='"+Branch+"' and SEMESTER='"+Semester+"'" +
           " and COMPANYCODE='"+Companycode+"' ";
       
       rst=db.getRowset(qry);
      //out.print(qry);
         if(rst.next())
           {
           out.print("<center><font size=4 family=verdana color=red>Record already exist in table.</font></center>");

       }
        else
       { 
           qry1="insert into TP#REGISTRATIONPARAMETERS (COMPANYCODE,EVENTCODE,INSTITUTECODE,ACADEMICYEAR,PROGRAMCODE," +
                   "SECTIONBRANCH,SEMESTER,FROMPERIOD,TODATE) values('"+Companycode+"','"+Event+"','"+Institute[i]+"'," +
                   "'"+Academicyear+"','"+Programcode+"','"+Branch+"'," +
                   "'"+Semester+"',to_date('"+fromdate+"','dd-mm-yyyy'),to_date('"+enddate+"','dd-mm-yyyy'))";
        //   out.print(qry1);
           n=db.insertRow(qry1);

            }

        }
        if(n>0)
            {
        out.print("<center><font size=4 family=verdana color=Green>Record Saved Successfully.</font></center>");
        }
    }
    }catch(Exception e)
            {
        out.print("Error is"+e);
    }%>

<!--table height="40%" width="100%">
    <tr>
        <td valign="bottom" align="right">
        
      <font  color="black" size="4" family="verdana">For Show The Registered Parameter <a href="showregisteredpage.jsp" >click here</a></font>
        </td>
    </tr></table-->
</form>
</body>
</html>