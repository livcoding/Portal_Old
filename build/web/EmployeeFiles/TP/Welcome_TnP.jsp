<%-- 
    Document   : Welcome_TandP
    Created on : Jul 11, 2014, 2:12:12 PM
    Author     : Gyanendra.Bhatt
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.regex.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp,java.lang.ArrayIndexOutOfBoundsException" %>

<html>
    <%
    String qry="",companycode="",qry1="",event="";
    ResultSet RsChk=null,rs2=null,rs=null;
    DBHandler db=new DBHandler();
    String mChkMemID="",mChkMType="",mRole="",mIPAddress="";
    OLTEncryption enc=new OLTEncryption();
    if(session.getAttribute("MemberID")==null)
        {
        mChkMemID="";
        }
    else{
    mChkMemID=enc.decrypt(session.getAttribute("MemberID").toString().trim());
    }

    if(session.getAttribute("MemberType")==null)
        {
        mChkMType="";
        }
    else{
    mChkMType=enc.decrypt(session.getAttribute("MemberType").toString().trim());
    }
    if(session.getAttribute("ROLENAME")==null)
        {
        mRole="";
        }
    else{
    mRole=enc.decrypt(session.getAttribute("ROLENAME").toString().trim());
    }

//out.print(mChkMemID+"   "+mChkMType+"   "+mRole );




    qry="Select WEBKIOSK.ShowLink('276','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	//out.print(qry);
    RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").trim().equals("Y"))
		{
           
            %>
    <head>

        <style>
            .linkstyle{
                margin: 0;
                padding: 0;
            }
            .linkstyle li{
                background:transparent;
                text-align: justify;
                width: inherit;
            }
            .linkstyle li A{
                text-decoration: none;
                background-color: inherit;
                color: #a52a2a;
            }
            .linkstyle li A:hover{                
                color: green;
                font-size: 1em;
            }
        </style>




        <script type="text/javascript" src="sh/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="sh/jquery.searchabledropdown-1.0.8.min.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <script>
          $(document).ready(function(){
    $('#back').click(function(){
        parent.history.back();
        return false;
    });
});




function opennew(company){   
  var i=0;
  $("#back").html("<input type=button style='background-color:#88000 ;border-color:black;font-weight:Bold; FONT-FAMILY: Arial; FONT-SIZE: 10pt;color: black; HEIGHT: 25px; VERTICAL-ALIGN: top; WIDTH: 95px;margin-right:2.5%' value=<<<Back>");
        
  if(company!="")
    {
        document.getElementById("LinkTable").style.visibility="visible";
    }
    else if(company=="")
        {
          document.getElementById("LinkTable").style.visibility="hidden";
        }
        document.getElementById("xx").value=i;
}

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
		$("#value").html($("select#companycode :selected").text() + " (VALUE: " + $("select#companycode").val() + ")");
        $("#link1").click(function(){
				if(this.id=="link1"){
                var event=$("select#event").val();
                var company= $("select#companycode").val() ;
            var a = document.getElementById('link1'); //or grab it by tagname etc
            a.href = "QuerryCriteria.jsp?event12="+event+"&company12="+company+"";
 }});
      $("#link2").click(function(){
				if(this.id=="link2"){
                var event=$("select#event").val();
                var company= $("select#companycode").val() ;
            var a = document.getElementById('link2'); //or grab it by tagname etc
            a.href = "RegistrationSummary.jsp?event12="+event+"&company12="+company+"";
 }});
	     $("#link3").click(function(){
				if(this.id=="link3"){
                var event=$("select#event").val();
                var company= $("select#companycode").val() ;
            var a = document.getElementById('link3'); //or grab it by tagname etc
            a.href = "afterregistered.jsp?event12="+event+"&company12="+company+"";
 }

			});
            $("#link4").click(function(){
				if(this.id=="link4"){
                var event=$("select#event").val();
                var company= $("select#companycode").val() ;
            var a = document.getElementById('link4'); //or grab it by tagname etc
            a.href = "PlacementSummary.jsp?event12="+event+"&company12="+company+"";
            }

			});
		});


       function successfunction(response)
    {/*
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
*/
   }

/*-------------onload company-----------------------------*/

/*-------------onload company-----------------------------*/

 $(document).ready(function(){
     $("#value").html($("select#event :selected").text() + " (VALUE: " + $("select#event").val() + ")");
     if($("select#event").val()!="")
     {
         $.get("addcompanycode.jsp",{event:$("select#event").val(),dt:getCurrentDateTime()},successfunction);
     }
 });


  


            $(document).ready(function(){
			$("#value").html($("select#event :selected").text() + " (VALUE: " + $("select#event").val() + ")");
			$("select").change(function(){
				$("#value").html(this.options[this.selectedIndex].text + " (VALUE: " + this.value + ")");

				if(this.id=="event"){
					//alert(this.id+"...."+this.value);
				$.get("addcompanycode.jsp",{event:$("select#event").val(),dt:getCurrentDateTime()},successfunction);
				}
			})
		})
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

            </script>

        <title>JSP Page</title>
    </head>
    <body aLink=#ff00ff bgcolor='#fce9c5' rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
          <div id="back" name="back" style="width:5%;margin-left:86%;"></div>
<strong>
    <font color="#a52a2a"><center><u>WELCOME TO T & P MODULE</u></center></font>
</strong>



    <!--   <img src="../Images/bullet4.gif">&nbsp;<A href="PlacementSummary.jsp" title="Student Placement Summary" target="DetailSection"><FONT face="Arial" size =2 color=white>Placement Summary</FONT></A><br>

<img src="../Images/bullet4.gif">&nbsp;<A href="PlacementSummary.jsp" title="Student Placement Summary" target="DetailSection"><FONT face="Arial" size =2 color=white>Placement Summary</FONT></A><br>
	  <img src="../Images/bullet4.gif">&nbsp;<A href="showregisteredpage.jsp" title="Student wise Class percentage(%) Attendance" target="DetailSection"><FONT face="Arial" size =2 color=white>T&P Registration</FONT></A><br>
	<img src="../Images/bullet4.gif">&nbsp;<A href="QuerryCriteria.jsp" title="Student wise Class percentage(%) Attendance" target="DetailSection"><FONT face="Arial" size =2 color=white>T&P Querry Criteria</FONT></A><br>
	 <img src="../Images/bullet4.gif">&nbsp;<A href="fterregistered.jsp" title="Student wise Class percentage(%) Attendance" target="DetailSection"><FONT face="Arial" size =2 color=white>T&P Selection</FONT></A><br>-->




         <form name="frm"  method="post">
        <input id="x" name="x" type=hidden>
<br>
 <table cellpadding=3 cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="60%" style="border-collapse:collapse;">
<tr>
<td align="left" valign="top" width="40%" nowrap>
<FONT face=Arial size=2><STRONG>Choose Event:</STRONG></FONT><font color=red face=arial size=2><STRONG>*</STRONG></font>

			<%

			try
            {
                qry="select distinct NVL(EventCode,'') e from TP#eventmaster Where nvl(Deactive,'N')='N'and nvl(LOCKEVENT,'N')<>'Y' and sysdate between EVENTSTARTDATE and EVENTENDDATE ";
				//out.print(qry);
                rs=db.getRowset(qry);
               %>


					<select Name="event" tabindex="0" id="event">
                    <OPTION seleceted Value ="" ><--select--></OPTION>
                        <%//out.print(qry);
                    if(rs.next())
					{
						event=rs.getString("e");
			if(request.getParameter("x")!=null)
			 			{
							%>
							<option selected  Value =<%=event%>><%=rs.getString("e")%></option>
							<%
						}
						else
						{
							%>
							<option   Value =<%=event%>><%=rs.getString("e")%></option>
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
	<FONT face=Arial size=2><STRONG> Choose Company:</STRONG></FONT><font color=red face=arial size=2><STRONG>*</STRONG></font>

<select name="companycode" id="companycode" onchange="return opennew(companycode.value);">
<option seleceted Value =""><--select--></option>
<%
             try{
qry1="SELECT distinct NVL(COMPANYCODE,' ') c FROM TP#eventcompanyparticipents where nvl(Deactive,'N')='N' and EVENTCODE='"+event+"'" ;
//out.print(qry1);
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
</select>
		<%}catch(Exception e)
                {
        out.print("error is "+e);}%>
	</td>
 
</tr>
  </table>
  <br>
      
 <table cellpadding=3 cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="60%" id="LinkTable" style="visibility:hidden; border-collapse: collapse;">
      <tr><td></td>
          <td colspan>
          <ul class="linkstyle">
                <li>
                <A href="" title="Student wise Class percentage(%) Attendance" target="DetailSection" ID="link1" NAME="link1">T&P Querry Criteria</button></A>
                
                  </li>
                <li>
                 <A href="" title="Student wise Class percentage(%) Attendance" target="DetailSection" ID="link2" NAME="link2">Registration Summary</A>
                </li>
              </ul>
             
                  </td>
                  <td colspan>
          <ul class="linkstyle">
              <li>
                 <A href="" title="Student wise Class percentage(%) Attendance" target="DetailSection" ID="link3" NAME="link3">T&P Selection</A>
              </li>
              <li>
                <A href="" title="Student Placement Summary" id="link4" target="DetailSection">Placement Summary</A>
              </li>
          </ul>
          </td>
      </tr>      
  </table>
</form>



    </body>
    <%
    }
        else{
        %>
			<br>
			<font color=red>
			<h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
			<P>	This page is not authorized/available for you.
			<br>For assistance, contact your network support team.
			</font>	<br>	<br>	<br>	<br>
			<%
        }
    %>
</html>
