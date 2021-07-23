<%@ page language="java" import="java.sql.*,tietwebkiosk.*;" %>
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
        String qryx="",mLTP1="",Branch="";
        ResultSet rsx=null;
        String reqAction="";
		String mInst="",mSubject="",minst="" ,qrys="",Semester="";
		int rsum80t1=0,rsum80t2=0,rsum80t3=0,ssum70t1=0,ssum70t2=0,ssum70t3=0,tsum60t1=0,tsum60t2=0,tsum60t3=0,
					usum50t1=0,usum50t2=0,usum50t3=0,vsum40t1=0,vsum40t2=0,vsum40t3=0,wsum30t1=0,wsum30t2=0,wsum30t3=0;
		int count=0 ,Flag=0;



        Event=request.getParameter("event12")==null?"":request.getParameter("event12").trim();
        Companycode=request.getParameter("company12")==null?"":request.getParameter("company12").trim();




int ttsum1=0,ttsum2=0,ttsum3=0;

if (session.getAttribute("InstituteCode") == null)
	mInst = "";
else
	mInst = session.getAttribute("InstituteCode").toString().trim();

%>
<HTML>
    <head>
        <TITLE>#### JIIT [ T&P]</TITLE>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<script type="text/javascript" src="sh/jquery-1.4.2.min.js"></script>

    <script type="text/javascript" src="sh/jquery.searchabledropdown-1.0.8.min.js"></script>
	<script type="text/javascript">
        $(document).ready(function(){
    $('#back').click(function(){
        parent.history.back();
        return false;
    });
});





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
</head>
    <body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >


        
        <input id="x" name="x" type=hidden>
        <table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
        <tr>
        <td colspan=0 align=middle>
            <font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><FONT SIZE="4" COLOR=""><B><u>Registered Parameter</u></B></FONT></font></td></tr>
        </table>
<table cellpadding=3 cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="95%" bgcolor="white">
<tr bgcolor="silver">
        <td colspan=0 align=middle>
            <font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><FONT SIZE="4" COLOR=""><B>Registered Parameter</B></FONT></font></td></tr>
        </table>


        <div id="back" name="back">
            <input type=button style='background-color:#88000 ;border-color:black;font-weight:Bold; FONT-FAMILY: Arial; FONT-SIZE: 10pt;color: black; HEIGHT: 25px; VERTICAL-ALIGN: top; WIDTH: 95px;margin-left:2.5%' value=Back>
        </div>




          <table cellpadding=3 cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="95%" bgcolor="white">

<tr bgcolor="silver">
<td align="right"  >
<FONT face=Arial size=2><STRONG>Event:</STRONG></FONT></td><td><font style="margin-left:5%" size="3" color="white"><strong><%=Event%></strong></font></td>

<!--
			<%
	/*
			try
            {
                qry="select distinct NVL(EventCode,'') e from TP#eventmaster Where nvl(Deactive,'N')='N'and nvl(LOCKEVENT,'N')<>'Y' and sysdate between EVENTSTARTDATE and EVENTENDDATE ";
				//out.print(qry);
                rs=db.getRowset(qry);
               %>


					<select Name="event" tabindex="0" id="event">
                    <OPTION seleceted Value ="" ><--select-->
                        <%//out.print(qry);
                    if(rs.next())
					{ 
						event=rs.getString("e");
			if(request.getParameter("x")!=null)
			 			{
							%>
	<!--						<option Selected  Value =<%=event%>><%=rs.getString("e")%></option>
							<%
						}
						else
						{
							%>
		<!--					<option  Value =<%=event%>><%=rs.getString("e")%></option>
							<%
						}
					event=request.getParameter("event")==null?"":request.getParameter("event").trim();
					}
					%>
					
			<%
			}catch(Exception e)
                {
        out.print("error123 is "+e);
            }
		
			// out.print("x="+request.getParameter("x"));
	*/		 %>
		-->
				
			<td nowrap align="right">
	<FONT face=Arial size=2><STRONG>Company:</STRONG></FONT><font color=red face=arial size=2><STRONG>*</STRONG></font>
            </td>
            <td>
                <font style="margin-left:5%" size="3" color="white"><strong><%=Companycode%></strong></font>
                </td>
<!--<select name="companycode" id="companycode"  >
<OPTION seleceted Value ="" ><--select-->
<% 	
          /*   try{
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
			<!--			<option selected value=<%=companycode%> ><%=companycode%></option>
					<%  }
					else
						{%>
					<option  value=<%=companycode%>><%=companycode%></option>
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
	


		companycode=request.getParameter("companycode")==null?"":request.getParameter("companycode").trim();	
		%>
</select>-->
		<%}catch(Exception e)
                {
        out.print("error is "+e);}
        */
        %>
	

   <%--<td>
       <input type="Submit" name="btn" value="Show" onclick="return vari();">
   </td>--%>
</tr>
  </table>
  <%
 try  {//out.print("cccc"+companycode);
      //  Companycode=request.getParameter("companycode")==null?"":request.getParameter("companycode").toString().trim();
        //Event=request.getParameter("event")==null?"":request.getParameter("event").toString().trim();
//reqAction=request.getParameter("btn");
//if(reqAction.equalsIgnoreCase("show"))

//if(request.getParameter("x")!=null)
       %>
       <br>
       <table cellpadding=3 cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="95%" bgcolor="white">
<tr bgcolor="silver">
<th><font  face=arial size=2 color="#a52a2a"><STRONG>Company</STRONG></font></th>
<th><font  face=arial size=2 color="#a52a2a"><STRONG>Institute</STRONG></font></th>
<th><font  face=arial size=2 color="#a52a2a"><STRONG>Academic Year</STRONG></font></th>
<th><font  face=arial size=2 color="#a52a2a"><STRONG>Semester</STRONG></font></th>
<th><font  face=arial size=2 color="#a52a2a"><STRONG>Program</STRONG></font></th>
<th><font  face=arial size=2 color="#a52a2a"><STRONG>Branch</STRONG></font></th>
<th><font  face=arial size=2 color="#a52a2a"><STRONG>Start Date</STRONG></font></th>
<th><font  face=arial size=2 color="#a52a2a"><STRONG>End Date</STRONG></font></th>
<th><font  face=arial size=2 color="#a52a2a"><STRONG>Modify</STRONG></font></th>
<th><font  face=arial size=2 color="#a52a2a"><STRONG>Delete</STRONG></font></th>
</tr>

<%try{
qry="SELECT  EVENTCODE e,  COMPANYCODE c,  INSTITUTECODE i, ACADEMICYEAR a, PROGRAMCODE" +
        " p, SECTIONBRANCH b, " +
    "  SEMESTER s, to_char(FROMPERIOD,'dd-mm-yyyy') d1, to_char(TODATE,'dd-mm-yyyy') " +
    "d2 FROM TP#REGISTRATIONPARAMETERS where COMPANYCODE='"+Companycode+"' and " +
    "Eventcode='"+Event+"'" +
    " order by INSTITUTECODE,ACADEMICYEAR,PROGRAMCODE,SECTIONBRANCH,SEMESTER ";
out.print(qry);
rs=db.getRowset(qry);
rs1=db.getRowset(qry);
while(rs.next())
    {%>
<tr>
<td align="center"><%=rs.getString("c")%></td>
<td align="center"><%=rs.getString("i")%></td>
<td align="center"><%=rs.getString("a")%></td>
<td align="center"><%=rs.getString("s")%></td>
<td align="center"><%=rs.getString("p")%></td>
<td align="center"><%=rs.getString("b")%></td>
<td align="center"><%=rs.getString("d1")%></td>
<td align="center"><%=rs.getString("d2")%></td>
<td align="center"><a href="editdata.jsp?id=<%=rs.getString("c")%>&id1=<%=rs.getString("e")%>
&id2=<%=rs.getString("i")%>&id3=<%=rs.getString("a")%>&id4=<%=rs.getString("p")%>&id5=<%=rs.getString("b")%>
&id6=<%=rs.getString("s")%>&id9=<%=rs.getString("d1")%>&id10=<%=rs.getString("d2")%>">Edit</a></td>
<td valign="center">
   <a href="deletedata.jsp?id=<%=rs.getString("c")%>&id1=<%=rs.getString("e")%>
&id2=<%=rs.getString("i")%>&id3=<%=rs.getString("a")%>&id4=<%=rs.getString("p")%>&id5=<%=rs.getString("b")%>
&id6=<%=rs.getString("s")%>&id9=<%=rs.getString("d1")%>&id10=<%=rs.getString("d2")%>" >Delete</a>
</td>
</tr>
<%
}
}catch(Exception e)
        {
out.print("Error no1:"+e);
}
 %>
</table>
<br>
<%if(rs1.next())%>
<table width="100%">
 <tr>
 <td align="center">
 <input type="button" value="Click here for Add New Data."
 onClick="window.open('regparameter.jsp?id7=<%=rs1.getString("c")%>&id8=<%=rs1.getString("e")%>','parameterswindow', 'height=300,width=600')" />
 </td><td align="center">
 </td>
 </tr>
 </table><%// }

        }
   catch(Exception e)
        {
       out.print("error :"+e) ;
   }
 
 %>
 