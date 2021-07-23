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
        String mAcademicYear = "",program="",programcode="",mDate12="";
        String mProgramCode = "";
        String mInstCode = "",msem="",reqAction="";
		String  mreg="",mselect1="" ;
		String mHOSTELTYPE = "" , macade="" ,mbranc="" ,sem="",semester="",branch="",branchcode="" ;
		String mprog="",enddate="",fromdate="",mdate1="",mdate2="";
		String mBranchCode = "",msid="",mCode="",mES="",mSubj1="",qrysubj="",Subject="";
        int n=0;
        String qryx="",mLTP1="",Branch="",mselect="";
        ResultSet rsx=null;
String mins="",mbranch="",mDate="";
		String mInst="",mSubject="",minst="" ,qrys="",Semester="",mDate1="",mDate2="";
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
        <TITLE>#### JIIT [T&P]</TITLE>
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
			else
            {
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
}
</script>
 </head>
    <%
        Companycode=request.getParameter("id");
        Event=request.getParameter("id1");
        institute=request.getParameter("id2");
        Branch=request.getParameter("id5");
        Academicyear=request.getParameter("id3");
        Programcode=request.getParameter("id4");
        Semester=request.getParameter("id6");
        mDate1=request.getParameter("id9");
        mDate2=request.getParameter("id10");
     

             
        %>

    <body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
        <form name="frm"  method="post" >
        <input id="x" name="x" type=hidden>
        <table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
        <tr>
        <td  align=middle>
            <font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><FONT SIZE="4" COLOR=""><B><u>Reg. Parameter</u></B></FONT></font></td></tr>
        </table>
        <table cellpadding=3 cellspacing=2 align=center rules=groups border=3 width="80%">
<tr>
<td align="left" valign="top"  nowrap>
<FONT face=Arial size=2><STRONG>Event&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</STRONG></FONT>
</td>
<td align="left" valign="top"   nowrap>

<%
try
{event=request.getParameter("id1")+"";
    out.print(event);
	}    
    catch(Exception e)
    {
	 out.println("Error Msg"+e);
    }
    %>
</td>

<td valign="top" align="right" nowrap>
<font color=black face=arial size=2><STRONG>Institute:</STRONG></font>
</td>
<td valign="top" align="left"  rowspan="2" nowrap><%
	  qry1="select distinct NVL(INSTITUTECODE,' ') i FROM TP#INSTITUTE";
	  rst=db.getRowset(qry1);
	  //out.print(qry);
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
			if(institute.equals(inst))
                {
            minst="selected";
            }
            else
            {
            minst="";
            }
            if(institute.equals(""))
 			{
                institute=inst;

                %>
				<OPTION <%=minst%> Value =<%=inst%>><%=inst%></option>
				<%
			}
			else
			{
				%>
				<option <%=minst%> value=<%=inst%>><%=inst%></option>
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
    <td valign="top" align="left" nowrap>
<font color=black face=arial size=2><STRONG>Company&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</STRONG></font>
</td>
<td valign="top" align="left" >
<%
try
{companycode=request.getParameter("id")+"";
    out.print(companycode);
	
 }
    catch(Exception e)
    {
	 out.println("Error Msg0"+e);
    }
    %>
</td>
<tr>
<td valign="top" align="left" nowrap>
<font color=black face=arial size=2><STRONG>Academic Year&nbsp;:</STRONG></font>
</td>
<td valign="top" align="left" >
<%
try
{
	qry1="select distinct ACADEMICYEAR a FROM v#studentmaster where nvl(Deactive,'N')='N' order by ACADEMICYEAR desc";
	  rst=db.getRowset(qry1);
	if (request.getParameter("x")==null)
	{
		%>
		<select name="academic" id="academic" style="WIDTH: 90px;" >
		<%
		while(rst.next())
		{
			academic=rst.getString("a");
			if(academic.equals(Academicyear))
                   {
                mselect1="Selected";
                }
            else
                {
                mselect1="";
                }
            %>
				<OPTION <%=mselect1%> Value ="<%=academic%>"><%=rst.getString("a")%></option>
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
		while(rst.next())
		{
			academic=rst.getString("a");

            if(academic.equals(request.getParameter("academic").toString().trim()))
 			{
			%>
				<OPTION selected Value ="<%=academic%>"><%=rst.getString("a")%></option>
			<%
		     	}
		     	else
		      {
				%>
		      	<OPTION Value ="<%=academic%>"><%=rst.getString("a")%></option>
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
<td valign="top" align="right" nowrap>
<font color=black face=arial size=2><STRONG>Program Code:</STRONG></font>
</td>
<td valign="top" align="left">
<%
try
{
	 qry1="select distinct NVL(PROGRAMCODE,' ') p FROM v#studentmaster where nvl(Deactive,'N')='N' and ACADEMICYEAR='"+Academicyear+"'";

     rst=db.getRowset(qry1);
	if (request.getParameter("x")!=null)
	{
		%>
		<select name="program" id="program"  style="WIDTH: 120px;" >
		<%
		while(rst.next())
		{
			program=rst.getString("p");
//System.out.print(program);
            if(program.equals(Programcode))
                {
                mselect="Selected";
                }
            else
                {
                mselect="";
                }
			%>
				<OPTION <%=mselect%> Value ="<%=program%>"><%=rst.getString("p")%></option>
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
		<%
		while(rst.next())
		{
			{
			program=rst.getString("p");
//System.out.print(program);
            if(program.equals(Programcode))
                {
                mselect="Selected";
                }
            else
                {
                mselect="";
                }
			%>
				<OPTION <%=mselect%> Value ="<%=program%>"><%=rst.getString("p")%></option>
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
<td valign="top" align="left"  nowrap>
<font color=black face=arial size=2><STRONG>Branch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</STRONG></font>
</td>
<td valign="top" align="left"  nowrap><%
try
{
	 qry1="select distinct NVL(BRANCHCODE,' ') b FROM v#studentmaster where nvl(Deactive,'N')='N' and PROGRAMCODE='"+Programcode+"' and ACADEMICYEAR='"+Academicyear+"'";
	  rst=db.getRowset(qry1);
	if (request.getParameter("x")!=null)
	{
		%>
		<select name="branch" id="branch"  style="WIDTH: 90px;">
		<%
		while(rst.next())
		{
			branch=rst.getString("b");
			if(branch.equals(Branch))
                {
            mbranch="selected";
            }else
            {mbranch="";
            }
            %>
				<OPTION <%=mbranch%> Value ="<%=branch%>"><%=rst.getString("b")%></option>
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
		<%
		while(rst.next())
		{
			branch=rst.getString("b");
			if(branch.equals(Branch))
                {
            mbranch="selected";
            }else
            {mbranch="";
            }
            %>
				<OPTION <%=mbranch%> Value ="<%=branch%>"><%=rst.getString("b")%></option>
			<%
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
<td valign="top" align="right"  nowrap>
<font color=black face=arial size=2><STRONG>Semester:</STRONG></font>
</td>
<td valign="top" align="left"  nowrap>
    <%
    try
{
	 qry1="select distinct NVL(SEMESTER,0) s FROM v#studentmaster where nvl(Deactive,'N')='N' and PROGRAMCODE='"+Programcode+"' and ACADEMICYEAR='"+Academicyear+"' and BRANCHCODE='"+branch+"'";
	  rst=db.getRowset(qry1);
	if (request.getParameter("x")!=null)
	{
		%>
		<select name="SEMESTER" id="SEMESTER"  style="WIDTH: 120px;" >
		<%
		while(rst.next())
		{
			sem=rst.getString("s");
			if(sem.equals(Semester))
                {
            msem="selected";
            }else
            {
                msem="";
            }
            %>
				<OPTION <%=msem%> Value ="<%=sem%>"><%=rst.getString("s")%></option>
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
		<%
		while(rst.next())
		{
			sem=rst.getString("s");
			if(sem.equals(Semester))
                {
            msem="selected";
            }else
            {
                msem="";
            }
            %>
				<OPTION <%=msem%> Value ="<%=sem%>"><%=rst.getString("s")%></option>
			<%
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
<td valign="top" align="left" nowrap>
<font color=black face=arial size=2><STRONG>From Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</STRONG></font>
</td>
<td nowrap><% if(request.getParameter("DATE1")==null){
        mDate12=mDate1;
        }
      else
      {
       mDate12=request.getParameter("DATE1");
      }%>
    <INPUT TYPE="text"  NAME=DATE1 ID=DATE1 size=9 tabindex=1 VALUE='<%=mDate12%>'
	maxlength=10><a href="javascript:NewCal('DATE1','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>

    </td>
	<td nowrap><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To&nbsp;</b>
    <font color=green face=arialblack font size=2><b> (DD-MM-YYYY)&nbsp;</b></font>
    <b>:</b></td>
	<td nowrap align="left">
	<% if(request.getParameter("DATE2")==null){
        mDate=mDate2;
        }
      else
      {
       mDate=request.getParameter("DATE2");
      }%>
    <INPUT TYPE="text" NAME=DATE2 ID=DATE2 size=9 tabindex=2 
	VALUE='<%=mDate%>' maxlength=10 ><a href="javascript:NewCal('DATE2','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>&nbsp;</td>
       
      
</tr>

    <tr>
    <td nowrap colspan="4" align="center">
        <input type="Submit" name="button" value="Update" onclick="return vari()">
            </td>
    </tr>
    </table>
    <%
 //   }
try
	{
 	if(request.getParameter("x")!=null)
	{
        fromdate=request.getParameter("DATE1")==null?" ":request.getParameter("DATE1").toString().trim();
        enddate=request.getParameter("DATE2")==null?" ":request.getParameter("DATE2").toString().trim();
         
         
        String[] instit = {"ALL"};
        String[] Institute = {"ALL"};
        programcode=request.getParameter("program").trim();
        academicyear=request.getParameter("academic").trim();
        instit =request.getParameterValues("inst");
        branch=request.getParameter("branch").trim();
        semester=request.getParameter("SEMESTER").trim();
        



           %>
           <input type=hidden name="Event" id="Event" value="<%=Event%>"/>
          <input type=hidden name="Institute" id="Institute" value="<%=instit%>"/>
          <input type=hidden name="academic" id="academic" value="<%=Academicyear%>"/>
          <input type=hidden name="Prog" id="Prog" value="<%=Programcode%>"/>
          <input type=hidden name="branch" id="branch" value="<%=Branch%>"/>
          <input type=hidden name="SEMESTER" id="SEMESTER" value="<%=Semester%>"/>
          <input type=hidden name="companycode" id="companycode" value="<%=Companycode%>"/>
<%

if(instit.equals("") || instit==null)
{

instit[0]="ALL";

} 
     for(int i=0;i<instit.length;i++)
        {
        
        Companycode=request.getParameter("id").trim();
        Event=request.getParameter("id1").trim();
        Institute[i]=request.getParameter("id2").trim();
        Branch=request.getParameter("id5").trim();
        Academicyear=request.getParameter("id3").trim();
        Programcode=request.getParameter("id4").trim();
        Semester=request.getParameter("id6").trim();

        

        qry="select 'Y' from TP#REGISTRATIONPARAMETERS where" +
           " EVENTCODE='"+Event+"' and INSTITUTECODE='"+instit[i]+"' and ACADEMICYEAR='"+academicyear+"'" +
           " and PROGRAMCODE='"+programcode+"' and SECTIONBRANCH='"+branch+"' and SEMESTER='"+semester+"'" +
           " and COMPANYCODE='"+Companycode+"' ";
       
        rst=db.getRowset(qry);
    // out.print(qry);
         if(rst.next())
           {
           out.print("<center><font size=4 family=verdana color=red>Record already exist in table.</font></center>");

       }
        else
       {
         qry="update TP#REGISTRATIONPARAMETERS set COMPANYCODE='"+companycode+"',EVENTCODE='"+event+"'," +
             "INSTITUTECODE='"+instit[i]+"',SECTIONBRANCH='"+branch+"',ACADEMICYEAR='"+academicyear+"'," +
             "PROGRAMCODE='"+programcode+"',SEMESTER='"+semester+"' ,FROMPERIOD=to_date('"+fromdate+"','dd-mm-yyyy')," +
             " TODATE=to_date('"+enddate+"','dd-mm-yyyy') where COMPANYCODE='"+Companycode+"'and EVENTCODE='"+Event+"'" +
              " and INSTITUTECODE='"+Institute[i]+"' and SECTIONBRANCH='"+Branch+"'and ACADEMICYEAR='"+Academicyear+"' and" +
              " PROGRAMCODE='"+Programcode+"' and SEMESTER='"+Semester+"'";
                // out.print(qry);
                int k=db.update(qry);

        if(k>0)
            {
         out.print("<center><font size=4 family=verdana color=Green>Record Update Successfully.</font></center>");
        }
                else
                {
                out.print("<center><font size=4 valign=center style=family:verdana; color=red>Sorry!! Child record exist</font></center>");
                }

        }
    }}

    }
    catch(Exception e)
            {
        out.print("Error is"+e);
    }%>

<table height="40%" width="100%">
    <tr>
        <td valign="bottom" align="right">
        
      <font  color="black" size="4" family="verdana">For Show The Registered Parameter <a href="showregisteredpage.jsp" >click here</a></font>
        </td>
    </tr></table>
</form>
      