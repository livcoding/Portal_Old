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
String qrysel=""; 
String  xBcklog="",xNoBcklog="";

String  xgaplog="",xNogaplog="";



        int rsum=0,ssum=0,tsum=0,usum=0,vsum=0,wsum=0;
		 String QrySet="",QrySetC="",QrySetCC="",qry4="" ,qry2="",qry3="",xSet="",mCritvales="",mcolor="#F2F2F2",QERCLOR="",andor="",Qryy="";  
		 String  QryIns="";  
        ResultSet rs =  null ,rsSet=null,rsIns=null,rs4=null,rsQERCLORR=null,rsQERCLORRN=null,rssel=null;
		ResultSet rst = null,rss=null,rss1=null;//int count;
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

event=request.getParameter("event12")==null?"":request.getParameter("event12").trim();
companycode=request.getParameter("company12")==null?"":request.getParameter("company12").trim();



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

            $(document).ready(function(){
     $("#back").html("<input type=button style='background-color:#88000 ;border-color:black;font-weight:Bold; FONT-FAMILY: Arial; FONT-SIZE: 10pt;color: black; HEIGHT: 25px; VERTICAL-ALIGN: top; WIDTH: 95px;margin-left:2.5%' value=Back>");
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
           <div id="back" name="back" style="width:5%;margin-left:86%;"></div>
         <BR><table cellpadding=3 cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="95%" bgcolor="white">
<tr bgcolor="silver">
        <td colspan=0 align=middle>
            <font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><FONT SIZE="4" COLOR=""><B>T&P Registration Summary </B></FONT></font></td></tr>
        </table><!--TABLE>
        <TR>
			<TD><A HREF="T&P-Process.docx">T&P Process Flow</A></TD>
        </TR>
        </TABLE --><BR>
        <%--table cellpadding=3 cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="95%" bgcolor="white">
<tr bgcolor="silver">
<td align="right"  >
<FONT face=Arial size=2><STRONG>Choose Event:</STRONG></FONT><font color=red face=arial size=2><STRONG>*</STRONG></font></td><td>

			<%/*
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
		<%
			}
		catch(Exception e)
                {
        out.print("error is "+e);
		}
		%>
	</td>

   <td>


    &nbsp; <!--input type=submit style="background-color:#88000 ;border-color:black;font-weight:Bold; FONT-FAMILY: Arial; FONT-SIZE: 10pt;color: black; HEIGHT: 25px; VERTICAL-ALIGN: top; WIDTH: 95px"  name="btn" value="Show" onclick="return vari();"> &nbsp;


        
   </td>
</tr>
  </table--%>
  
         <table cellpadding=3 cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="95%" bgcolor="white">
            <tr bgcolor="silver">
            <td align="right"  >
            <FONT face=Arial size=2><STRONG>Event:</STRONG></FONT></td><td><font style="margin-left:5%" size="3" color="white"><strong><%=event%></strong></font></td>
            <td nowrap align=right>
            <FONT face=Arial size=2 ><STRONG>Company:</STRONG></FONT><font color=red face=arial size=2></td><td><font style="margin-left:5%" size="3" color="white"><strong><%=companycode%></strong></font></td>
            </tr>
          </table>
  <%
 try  {//out.print("cccc"+companycode);
        //Companycode=request.getParameter("companycode")==null?"":request.getParameter("companycode").toString().trim();
       // Event=request.getParameter("event")==null?"":request.getParameter("event").toString().trim();

//reqAction=request.getParameter("btn");
//if(reqAction.equalsIgnoreCase("show"))
  Qryy=" select nvl(count(distinct studentid),0)StudCount,nvl(institutecode,'-')institutecode from TP#REGISTRATIONDETAIL where eventcode='"+event+"' and companycode='"+companycode+"' group by institutecode ";
//out.print(Qryy);
rss = db.getRowset(Qryy);
rss1=db.getRowset(Qryy);
if(rss1.next())
{     %>      <BR><BR> <table cellpadding=3 cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="95%" bgcolor="white">
	<thead>
	<tr bgcolor="silver">
		<TD ALIGN=CENTER><font color=black><b>Sno.<B><font></TD>
		<TD ALIGN=CENTER><font color=black><b>Institute Code<B><font></TD>
		<TD ALIGN=CENTER><font color=black><b>Student Count<B><font></TD>
<%

      while (rss.next()){
		  count++;
%>

<tr bgcolor="white">
<TD ALIGN=CENTER><font color=black><b><%=count%><B><font></TD>
<TD ALIGN=CENTER><font color=black><b><%=rss.getString("institutecode")%><B><font></TD>
<TD ALIGN=CENTER><font color=black><b><%=rss.getString("StudCount")%><B><font></TD>
		
<%
	  }


}else{
out.print("<center><font color=red size=4>no student registered ...</center>");
}

  }
   catch(Exception e)
        {
       out.print("error :"+e) ;
		}
 %>
 </form></body></html>