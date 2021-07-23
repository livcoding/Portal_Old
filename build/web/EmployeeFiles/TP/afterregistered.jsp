<%@ page language="java" import="java.sql.*,java.util.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp,java.lang.ArrayIndexOutOfBoundsException" %>
<%

        DBHandler db = new DBHandler();
        int rsum=0,ssum=0,tsum=0,usum=0,vsum=0,wsum=0;
        ResultSet rs =  null,rs3=null,rs4=null,rs5=null,rs6=null,rs8=null;
		ResultSet rst = null;
		ResultSet rsf=  null ;
        ResultSet rsd = null;
        ResultSet rs1 = null;
        ResultSet rs2 = null;
        ResultSet rsc = null,rs7=null;
        String qry = "" ,qryc="",round12="",mSUBB="",absent="",qry2="",mSUBN="",mchk="", mLTP="",qry1="",inst="",institute="",academic="",academicyear="";
		String qryt = "",Event="",Programcode="",Companycode="",written="",gd="",interview="",studentname="";
        GlobalFunctions gb = new GlobalFunctions();
	    String mRegCode = "",event="", Academicyear="",studentid="",round1="",absentin="";
        String mEXAMCODE = "" ,mSubjID="",DataSublist="" ,mProgCode="",QryProgCode="",companycode="";
        String mAcademicYear = "",program="",programcode="",company="",eventcode="";
        String mProgramCode = "",enroll="";
        String mInstCode = "",round="",stat="",statu="";
		String  mreg="",q="" ;
		String mHOSTELTYPE = "" ,status2="",status1="", macade="" ,mbranc="" ,sem="",semester="",branch="",branchcode="" ;
		String mprog="",enddate="",fromdate="";
		String mBranchCode = "",msid="",mCode="",mES="",mSubj1="",qrysubj="",Subject="";
        int n=0,c=0,l=0,o=0,p=0;
        String qryx="",mLTP1="",Branch="";
        ResultSet rsx=null;
        String reqAction="",roundname="",status="";
		String mInst="",mSubject="",minst="" ,qrys="",Semester="";
		int rsum80t1=0,rsum80t2=0,rsum80t3=0,ssum70t1=0,ssum70t2=0,ssum70t3=0,tsum60t1=0,tsum60t2=0,tsum60t3=0,
					usum50t1=0,usum50t2=0,usum50t3=0,vsum40t1=0,vsum40t2=0,vsum40t3=0,wsum30t1=0,wsum30t2=0,wsum30t3=0;
		int count=0 ,Flag=0,i=0,s=0,m=0,k=0,d=0,cnt=0,j=0,z=0,r=0,x=0;
        event=request.getParameter("event12")==null?"":request.getParameter("event12").trim();
        companycode=request.getParameter("company12")==null?"":request.getParameter("company12").trim();

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
function vari1()
{
    var r1=document.getElementById("round1").checked;
    var r3=document.getElementById("round3").checked;
    var r2=document.getElementById("round2").checked;
  
   var msg="";
    var k=0;
	if(r1==false && r2==false && r3==false)
    {
        msg=msg+"Please choose a round\n";
        k++;
    }
    if(k>0)
        {
            alert(msg);
            return false;
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

function absentinlast()
{
    var cnt=document.getElementById("cnt").value;
    for(var i=1;i<=cnt;i++)
    {
        var check=document.getElementById("check"+i).checked;
        var present=document.getElementById("attendance"+i).checked;
        var attendance=document.getElementById("attendance"+i).value;
        var absent=document.getElementById("absent"+i).value;
    if(document.getElementById("absent"+i).checked)
    {
        document.getElementById("check"+i).checked=false;
        document.getElementById("check"+i).disabled=true;
        
    }else{
          document.getElementById("check"+i).disabled=false;
    }
}
}

function absent()
{
    var cnt=document.getElementById("cnt").value;
    for(var i=1;i<=cnt;i++)
    {
        var check=document.getElementById("check"+i).checked;
        var present=document.getElementById("attendance"+i).checked;
        var attendance=document.getElementById("attendance"+i).value;
        var absent=document.getElementById("absent"+i).value;
        var dbvalue=document.getElementById("dbvalue"+i).value;
     if(present==false)
   {
    document.getElementById("check"+i).disabled=true;
}
  else
      if(dbvalue=='N')
        {
        document.getElementById("check"+i).disabled=false;
        
   }
   if(document.getElementById("check"+i).checked)
            {  if(dbvalue=='N')
        {
           document.getElementById("absent"+i).disabled=true;
        }

        }
   else
            {
            document.getElementById("absent"+i).disabled=false;
            }
    
}}


        </script>
 <style type="text/css" media="print">
    @media print
    {
    #non-printable { display: none; }
    #printable {
    display: block;
    width: 100%;
    height: 100%;
    }
    }
    </style>
</head>
    <body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >


        <form name="frm"  method="post">
        <input id="x" name="x" type=hidden value="accept">
        <div id="non-printable">
       <table cellpadding=3 cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="95%" bgcolor="white">
<tr bgcolor="silver">
        <td colspan=0 align=middle>
            <font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><FONT SIZE="4" COLOR=""><B>Selection Of Students </B></FONT></font></td></tr>
        </table>
         <div id="back" name="back" style="width:5%;margin-left:86%;"></div>
         <table cellpadding=3 cellspacing=2 align=center rules=groups border=3 bordercolor="black" width="95%" bgcolor="white">
            <tr bgcolor="silver">
            <td align="right"  >
            <FONT face=Arial size=2><STRONG>Event:</STRONG></FONT></td><td><font style="margin-left:5%" size="3" color="white"><strong><%=event%></strong></font></td>
            <td nowrap align=right>
            <FONT face=Arial size=2 ><STRONG>Company:</STRONG></FONT><font color=red face=arial size=2></td><td><font style="margin-left:5%" size="3" color="white"><strong><%=companycode%></strong></font></td>
            </tr>
          </table>
        <%--table cellpadding=3  id="tblSearch" c class="mytable filterable" cellspacing=2 align=center rules=groups border=2 bordercolor="black" width="80%" >
<tr>
<td align="left" valign="top" width="50%" nowrap>
<FONT face=Arial size=2><STRONG>Choose Event:</STRONG></FONT><font color=red face=arial size=2><STRONG>*</STRONG></font>

			<%

			try
            {//out.print("HHH"+mInst);
                qry="select distinct NVL(EventCode,'') e from TP#eventmaster Where nvl(Deactive,'N')='N'and nvl(LOCKEVENT,'N')<>'Y' and sysdate between EVENTSTARTDATE and EVENTENDDATE ";
				//out.print(qry);
                rs=db.getRowset(qry);
               %>


					<Select Name="event" tabindex="0" id="event">
                    <OPTION  Value ="" ><--select--></OPTION>
                        <%//out.print(qry);
                   if(rs.next())
					{
						event=rs.getString("e");
			if((request.getParameter("x")!=null) ||(request.getParameter("q")!=null))
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
			}catch(Exception e)
                {
        out.print("error123 is "+e);
            }

			// out.print("x="+request.getParameter("x"));
			 %>

				</td>
			<td nowrap width="50%">
	<FONT face=Arial size=2><STRONG> Choose Company:</STRONG></FONT><font color=red face=arial size=2><STRONG>*</STRONG></font>

<select name="companycode" id="companycode"  >
<OPTION seleceted Value ="" ><--select--></OPTION>
<%
             try{
                 qry1="SELECT distinct NVL(COMPANYCODE,' ') c FROM TP#eventcompanyparticipents where nvl(Deactive,'N')='N' and EVENTCODE='"+event+"'" ;

	//System.out.print(qry1);
			//companycode=rst.getString("c");
rs2=db.getRowset(qry1);
		if((request.getParameter("x")!=null) )
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
    <tr>
	<td colspan="2" align="center">
       <input type="Submit" name="btn" value="Submit" onclick="return vari();">
   </td>
    </tr>
      </table--%>
        </div>
        </form>
<form name="a1" id="a1" method="post">
<% q=request.getParameter("x")==null?"":request.getParameter("x").trim();
%>
  <input type="hidden" name="Y" id="Y" value="<%=p%>">
  <input type="hidden" name="q" id="q" value="<%=q%>">
      <%
     // if(request.getParameter("x")!=null){
           //companycode=request.getParameter("companycode")==null?"":request.getParameter("companycode").trim();
         //  event=request.getParameter("event")==null?"":request.getParameter("event").trim();
          //out.print("companycode : "+companycode+" event:"+event);
           %>
          
     <table width="80%" border="1" bordercolor="black" align="center" bottommargin=0  topmargin=0>
<tr bgcolor="silver">
<td nowrap >
<FONT face=Arial size=2><STRONG> Choose Round:</STRONG></FONT><font color=red face=arial size=2><STRONG>*</STRONG></font>
<%
             try{
             qry1="SELECT written,groupdiss,interview FROM tp#eventcompanyparticipents where" +
                         " eventcode='"+event+"' and companycode='"+companycode+"' and nvl(Deactive,'N')='N'" ;
            //out.print(qry1);
                rs2=db.getRowset(qry1);
              while(rs2.next())
              {
			  written=rs2.getString(1)==null?"":rs2.getString(1).trim();
              gd=rs2.getString(2)==null?"":rs2.getString(2).trim();
              interview=rs2.getString(3)==null?"":rs2.getString(3).trim();
              if(written.equals("Y")&&gd.equals("Y")&&interview.equals("Y"))
                  {
              roundname="WGI";
              }
              else if(!written.equals("Y")&&gd.equals("Y")&&interview.equals("Y"))
              {
              roundname="GI";
              }
               else if(written.equals("Y")&&!gd.equals("Y")&&interview.equals("Y")){
              roundname="WI";
              }
            else{
             roundname="I";
            }
              




              if(written.equals("Y")){%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              Written: <input type="radio" name="round" id="round1" value="W"/>
              <%}
              if(gd.equals("Y")){%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               G.D.: <input type="radio" name="round" id="round2" value="G"/>
              <%}%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                Interview:<input type="radio" name="round" id="round3" value="I"/>
             <%
                   //  {
                }
round=request.getParameter("round")==null?"":request.getParameter("round").trim();

		}catch(Exception e)
                {
        out.print("error "+e);
        }%>
	</td>
    
   <td align="center">
       <input type="Submit" name="btn1" value="Submit" onclick="return vari1();">
   </td>
</tr>
  </table>
    <input type="hidden" name="companycode" id="companycode" value="<%=companycode%>">
    <input type="hidden" name="event" id="event" value="<%=event%>">
    <input type="hidden" name="roundname" id="roundname" value="<%=roundname%>">
    <input type="hidden" name="round1" id="round1" value="<%=request.getParameter("round")==null?"":request.getParameter("round").trim()%>">

</form>

     <%//}%>
    <form name="b" id="b" method="post" >
     <input type="hidden" name="Z" id="Z">
<%try{
     if((request.getParameter("Y")!=null))
         {%>
            <%
         roundname=request.getParameter("roundname")==null?"":request.getParameter("roundname").trim();
          if(roundname.equals("WGI"))
          {
          if(request.getParameter("round").equals("W")){
         //company=request.getParameter("companycode")==null?"":request.getParameter("companycode").trim();
        // eventcode=request.getParameter("event")==null?"":request.getParameter("event").trim();
         round=request.getParameter("round")==null?"":request.getParameter("round").trim();
        // out.print("round: "+round+"eventcode :"+eventcode+"company :"+company);%>
       <table cellpadding=3  id="tblSearch" c class="mytable filterable" cellspacing=2 align=center rules=groups border=2 bordercolor="black" width="80%" >
               <tr>
                   <td valign="center" >
                      <input type="text" readonly  style="width:20px;height:20px;background-color:white;">: Unselected Student &nbsp;&nbsp;
                      <input type="text" readonly  style="width:20px;height:20px;background-color:lightpink;">: Selected in Written&nbsp;&nbsp;
                      <input type="text" readonly  style="width:20px;height:20px;background-color:lightblue;">: Selected in G.D.&nbsp;&nbsp;
                      <input type="text" readonly  style="width:20px;height:20px;background-color:lightgreen;">: Selected in Interview&nbsp;&nbsp;
                   </td>
               </tr>
           </table>
          <br>
  <table width="30%" border="2" cellpadding=3  id="tblSearch" class="mytable filterable" cellspacing=2 align=center bordercolor="black" bottommargin=0  topmargin=0>
  <tr  bgcolor="silver">
    <%
     if(round.equals("W"))
          {
          round12="Written";
          }else if(round.equals("G"))
          {
          round12="G.D";
          }
          else if(round.equals("I"))
          {
          round12="Interview";
          }
     %><td align="center" nowrap colspan="3" ><Font size="3" COLOR="black" align="center">Round :</FONT>
     <Font size="3" COLOR="black" align="center"><u><%=round12%></u></FONT>
     </td></tr>
  
        <tr bgcolor="silver">
       <td align="center"><Font size="3" COLOR="black" align="center">Enrollment No. &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;&nbsp;Student's Name &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp;</FONT></td>
        <td align="center"><Font size="3" COLOR="black" align="center">Present</FONT></td>
         <td align="center"><Font size="3" COLOR="black" align="center">Absent</FONT></td>
        </tr>
        <% 

           qry="SELECT DISTINCT studentname,studentid,ENROLLMENTNO FROM studentmaster WHERE studentid IN (SELECT DISTINCT studentid " +
             "FROM tp#eventparticipents WHERE registered = 'Y' and eventcode='"+event+"' and " +
             "companycode='"+companycode+"') order by studentname";
            //   out.print(qry);
               rs=db.getRowset(qry);
               while(rs.next()){
               i++;
           %>
        <tr>
       <td align="left" nowrap>
        <%   qry1="SELECT  status FROM tp#afterinterview WHERE" +
               " eventcode = '"+event+"' AND companycode = '"+companycode+"' " +
               "And status='W' and studentid='"+rs.getString("studentid")+"' union SELECT  status FROM tp#afterinterview WHERE" +
               " eventcode = '"+event+"' AND companycode = '"+companycode+"' " +
               "And status='G' and studentid='"+rs.getString("studentid")+"' union SELECT  status FROM tp#afterinterview WHERE" +
               " eventcode = '"+event+"' AND companycode = '"+companycode+"' " +
               "And status='I' and studentid='"+rs.getString("studentid")+"'" ;
           //out.print(qry1);
             rs1=db.getRowset(qry1);
             rs2=db.getRowset(qry1);
             rs3=db.getRowset(qry1);
             rs4=db.getRowset(qry1);
             rs5=db.getRowset(qry1);
             rs6=db.getRowset(qry1);
             rs7=db.getRowset(qry1);
        if(rs1.next())
        { if(rs2.next()){
            stat=rs2.getString("status")==null?"":rs2.getString("status").trim();
            if(stat.equals("G")||stat.equals("I")){
            %><input type="checkbox" id="check<%=i%>" checked  disabled  name="check<%=i%>" value="Y" />
                <input type="hidden" value="Y" name="dbvalue<%=i%>" id="dbvalue<%=i%>" >
            <%
            }else{%><input type="checkbox" id="check<%=i%>" checked   name="check<%=i%>" value="Y"  onclick="return absent();" />
                    <input type="hidden" value="N" name="dbvalue<%=i%>" id="dbvalue<%=i%>" >
         <% }}
        }else{%> <input type="hidden" value="N" name="dbvalue<%=i%>" id="dbvalue<%=i%>" >
            <% qry="select absentin from tp#afterinterview where" +
               " eventcode = '"+event+"' AND companycode = '"+companycode+"' " +
               "And absentin='W' and studentid='"+rs.getString("studentid")+"'";

                rs8=db.getRowset(qry);

       if(rs8.next())
       {%>
        <input type="checkbox" id="check<%=i%>"  disabled  name="check<%=i%>" value="Y" onclick="return absent();"/>
       <%}else{%>
       <input type="checkbox" id="check<%=i%>"   name="check<%=i%>" value="Y" onclick="return absent();"/>
      <%}}%>
      
    <% if(rs3.next()){
        statu=rs3.getString("status")==null?"":rs3.getString("status").trim();
      // out.print(statu);
        if(statu.equals("G"))
            {
            %>
            <input type="text" id="enroll<%=i%>" name="enroll<%=i%>"  readonly  value="<%=rs.getString("ENROLLMENTNO")%>" style="width:100px;color: black; font-family: Verdana; font-weight: bold; font-size: 12px; background-color: lightblue;">
            <input type="text" id="sname<%=i%>" name="sname<%=i%>"  readonly  value="<%=rs.getString("studentname")%>" style="width:250px;color: black; font-family: Verdana; font-weight: bold; font-size: 12px; background-color: lightblue;">
            <%}
        else if(statu.equals("I")){%>
            <input type="text" id="enroll<%=i%>" name="enroll<%=i%>" readonly  value="<%=rs.getString("ENROLLMENTNO")%>" style="width:100px;color: black; font-family: Verdana; font-weight: bold; font-size: 12px; background-color: lightgreen;">
            <input type="text" id="sname<%=i%>" name="sname<%=i%>" readonly  value="<%=rs.getString("studentname")%>" style="width:250px;color: black; font-family: Verdana; font-weight: bold; font-size: 12px; background-color: lightgreen;">
             <a href="#" onclick="window.open('joiningstatus.jsp?id=<%=rs.getString("studentid")%>','newwindow', 'width=400, height=200')" >Joining Status</a>
            <%}else if(statu.equals("W")){%>
            <input type="text" id="enroll<%=i%>" name="enroll<%=i%>" readonly  value="<%=rs.getString("ENROLLMENTNO")%>" style="width:100px;color: black; font-family: Verdana; font-weight: bold; font-size: 12px; background-color: lightpink;">
            <input type="text" id="sname<%=i%>" name="sname<%=i%>" readonly value="<%=rs.getString("studentname")%>" style="width:250px; color: black; font-family: Verdana; font-weight: bold; font-size: 12px; background-color: lightpink;">
            <%}} else
                {%>
 <input type="text" id="enroll<%=i%>" name="enroll<%=i%>" readonly value="<%=rs.getString("ENROLLMENTNO")%>" style="width:100px;">
 <input type="text" id="sname<%=i%>" name="sname<%=i%>" readonly value="<%=rs.getString("studentname")%>" style="width:250px;">
                <%}%>
            </td>
            <td align="center">
            <%  if(rs4.next())
        {
                if(rs5.next()){
            status1=rs5.getString("status")==null?"":rs2.getString("status").trim();
            if(status1.equals("G")||status1.equals("I")){
            %><input type="radio" name="attendance<%=i%>" checked  disabled id="present<%=i%>" value="P"  onclick="return absent();"/>
            
            <%
            }else{%><input type="radio" name="attendance<%=i%>"   checked id="present<%=i%>" value="P" onclick="return absent();"/>
         <% }}
        }else{%>
       <input type="radio" name="attendance<%=i%>" checked id="present<%=i%>" value="P" onclick="return absent();"/>
       <%}%>
              
            </td>
            <td align="center">
               <%  if(rs7.next())
        {
                if(rs6.next()){
            status2=rs6.getString("status")==null?"":rs2.getString("status").trim();
            if(status2.equals("G")||status2.equals("I")){
            %><input type="radio" name="attendance<%=i%>"  disabled id="absent<%=i%>" value="A" onclick="return absent();"/>

            <%
            }else{%><input type="radio" name="attendance<%=i%>" disabled  id="absent<%=i%>" value="A" onclick="return absent();"/>
         <% }}
        }else{
                 qry="select absentin from tp#afterinterview where" +
               " eventcode = '"+event+"' AND companycode = '"+companycode+"' " +
               "And absentin='W' and studentid='"+rs.getString("studentid")+"'";
        
                rs8=db.getRowset(qry);
      
       if(rs8.next()){
       %>
       <input type="radio" name="attendance<%=i%>" checked  id="absent<%=i%>" value="A" onclick="return absent();"/>
       <%}else{%>
       <input type="radio" name="attendance<%=i%>"  id="absent<%=i%>" value="A" onclick="return absent();"/>
          <%}
        }%>  </td>
        </tr>
<input type="hidden" name="studentid<%=i%>" id="studentid<%=i%>" value="<%=rs.getString("studentid")%>"/>

<%
   }
  %>
  <tr><td align="center" colspan="7"><input type="Submit" value="Save"></td></tr></table>
<%
      
    }        else if(request.getParameter("round").equals("G")){
        //company=request.getParameter("companycode")==null?"":request.getParameter("companycode").trim();
        // eventcode=request.getParameter("event")==null?"":request.getParameter("event").trim();
         round=request.getParameter("round")==null?"":request.getParameter("round").trim();
         qry="SELECT  status FROM tp#afterinterview WHERE" +
               " eventcode = '"+event+"' AND companycode = '"+companycode+"' " +
               "And status='W' union sELECT  status FROM tp#afterinterview WHERE" +
               " eventcode = '"+event+"' AND companycode = '"+companycode+"' " +
               "And status='G' union sELECT  status FROM tp#afterinterview WHERE" +
               " eventcode = '"+event+"' AND companycode = '"+companycode+"' " +
               "And status='I' " ;
              
          
         //  out.print(qry);
           rs=db.getRowset(qry);
           if(!rs.next())
          {
             out.print("<center><font size=4 color=red>Please Select Student from Previous Round For This Round.</font></center>");
            }else{
        %><table cellpadding=3  id="tblSearch" c class="mytable filterable" cellspacing=2 align=center rules=groups border=2 bordercolor="black" width="80%" >
               <tr>
                   <td valign="center" >
                      <input type="text" readonly  style="width:20px;height:20px;background-color:white;">: Unselected Student &nbsp;&nbsp;
                      <input type="text" readonly  style="width:20px;height:20px;background-color:lightpink;">: Selected in Written&nbsp;&nbsp;
                      <input type="text" readonly  style="width:20px;height:20px;background-color:lightblue;">: Selected in G.D.&nbsp;&nbsp;
                      <input type="text" readonly  style="width:20px;height:20px;background-color:lightgreen;">: Selected in Interview&nbsp;&nbsp;
                   </td>
               </tr>
           </table>
          <br> 
        <table width="30%" border="2" cellpadding=3  id="tblSearch" class="mytable filterable" cellspacing=2 align=center bordercolor="black" bottommargin=0  topmargin=0> <tr  bgcolor="silver">
    <%
     if(round.equals("W"))
          {
          round12="Written";
          }else if(round.equals("G"))
          {
          round12="G.D";
          }
          else if(round.equals("I"))
          {
          round12="Interview";
          }
     %><td align="center" nowrap colspan="3" ><Font size="3" COLOR="black" align="center">Round :</FONT>
     <Font size="3" COLOR="black" align="center"><u><%=round12%></u></FONT>
     </td></tr>
        <tr bgcolor="silver">
      <td align="center"><Font size="3" COLOR="black" align="center">Enrollment No. &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;&nbsp;Student's Name &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp;</FONT></td>
        <td align="center"><Font size="3" COLOR="black" align="center">Present</FONT></td>
         <td align="center"><Font size="3" COLOR="black" align="center">Absent</FONT></td>
        </tr>
        <% 
           qry="SELECT DISTINCT studentname, studentid,ENROLLMENTNO FROM studentmaster WHERE studentid IN (SELECT DISTINCT studentid " +
             "FROM tp#AfterInterview WHERE status = 'W' and eventcode='"+event+"' and " +
             "companycode='"+companycode+"') union SELECT DISTINCT studentname, studentid,ENROLLMENTNO FROM studentmaster WHERE studentid IN (SELECT DISTINCT studentid " +
             "FROM tp#AfterInterview WHERE status = 'G' and eventcode='"+event+"' and " +
             "companycode='"+companycode+"') union SELECT DISTINCT studentname, studentid,ENROLLMENTNO FROM studentmaster WHERE studentid IN (SELECT DISTINCT studentid " +
             "FROM tp#AfterInterview WHERE status = 'I' and eventcode='"+event+"' and " +
             "companycode='"+companycode+"') order by studentname";
         //  out.print(qry);
         rs=db.getRowset(qry);
           while(rs.next()){
               i++;
           %>
        <tr>
       <td align="left" nowrap>
           <%   qry1="SELECT  status FROM tp#afterinterview WHERE" +
               " eventcode = '"+event+"' AND companycode = '"+companycode+"' " +
               "And status='G' and studentid='"+rs.getString("studentid")+"' union SELECT  status FROM tp#afterinterview WHERE" +
               " eventcode = '"+event+"' AND companycode = '"+companycode+"' " +
               "And status='I' and studentid='"+rs.getString("studentid")+"' " ;
//out.print(qry1);
           rs1=db.getRowset(qry1);
           rs2=db.getRowset(qry1);
           rs3=db.getRowset(qry1);
           rs4=db.getRowset(qry1);
           rs5=db.getRowset(qry1);
           rs6=db.getRowset(qry1);
           rs7=db.getRowset(qry1);
           if(rs1.next())
        {if(rs2.next()){
            stat=rs2.getString("status")==null?"":rs2.getString("status").trim();
            if(stat.equals("I")){
            %><input type="checkbox" id="check<%=i%>" checked  disabled  name="check<%=i%>"  value="Y"/>
              <input type="hidden" value="Y" name="dbvalue<%=i%>" id="dbvalue<%=i%>" >
            <%
            }else{%><input type="checkbox" id="check<%=i%>" checked  onclick="return absent();" name="check<%=i%>" value="Y"/>
                    <input type="hidden" value="N" name="dbvalue<%=i%>" id="dbvalue<%=i%>" >
         <% }}
        }else{%> <input type="hidden" value="N" name="dbvalue<%=i%>" id="dbvalue<%=i%>" >
            <% qry="select absentin from tp#afterinterview where" +
               " eventcode = '"+event+"' AND companycode = '"+companycode+"' " +
               "And absentin='G' and studentid='"+rs.getString("studentid")+"'";

                rs8=db.getRowset(qry);

       if(rs8.next())
       {%>
        <input type="checkbox" id="check<%=i%>"  disabled  name="check<%=i%>" value="Y" onclick="return absent();"/>
       <%}else{%>
       <input type="checkbox" id="check<%=i%>"   name="check<%=i%>" value="Y" onclick="return absent();"/>
      <%}}%>
       
       <% if(rs3.next()){
        statu=rs3.getString("status")==null?"":rs3.getString("status").trim();
      // out.print(statu);
        if(statu.equals("I"))
            {
            %>
            <input type="text" id="enroll<%=i%>" name="enroll<%=i%>"  readonly  value="<%=rs.getString("ENROLLMENTNO")%>" style="width:100px;color: black; font-family: Verdana; font-weight: bold; font-size: 12px; background-color: lightgreen;">
            <input type="text" id="sname<%=i%>" name="sname<%=i%>"   value="<%=rs.getString("studentname")%>" style="width:250px;color: black; font-family: Verdana; font-weight: bold; font-size: 12px; background-color: lightgreen;">
             <a href="#" onclick="window.open('joiningstatus.jsp?id=<%=rs.getString("studentid")%>','newwindow', 'width=400, height=200')" >Joining Status</a>
            <%}else{%><input type="text" id="enroll<%=i%>" name="enroll<%=i%>"  readonly  value="<%=rs.getString("ENROLLMENTNO")%>" style="width:100px;color: black; font-family: Verdana; font-weight: bold; font-size: 12px; background-color: lightblue;">
            <input type="text" id="sname<%=i%>" name="sname<%=i%>"  readonly value="<%=rs.getString("studentname")%>" style="width:250px;color: black; font-family: Verdana; font-weight: bold; font-size: 12px; background-color: lightblue;"/><%}
       }
           else{%><input type="text" id="enroll<%=i%>" name="enroll<%=i%>"  readonly  value="<%=rs.getString("ENROLLMENTNO")%>" style="width:100px;">
           <input type="text" id="sname<%=i%>" name="sname<%=i%>"  readonly value="<%=rs.getString("studentname")%>" style="width:250px;"/><%}%>
           </td>
            <td align="center">
            <%  if(rs4.next())
        {
                if(rs5.next()){
            status1=rs5.getString("status")==null?"":rs2.getString("status").trim();
            if(status1.equals("I")){
            %><input type="radio" name="attendance<%=i%>" checked  disabled id="present<%=i%>" value="P" />

            <%
            }else{%><input type="radio" name="attendance<%=i%>"   checked id="present<%=i%>" value="P"  onclick="return absent();"/>
         <% }}
        }else{%>
       <input type="radio" name="attendance<%=i%>" checked id="present<%=i%>" value="P" onclick="return absent();"/>
       <%}%>

            </td>
            <td align="center">
               <%  if(rs7.next())
        {
                if(rs6.next()){
            status2=rs6.getString("status")==null?"":rs2.getString("status").trim();
            if(status2.equals("I")){
            %><input type="radio" name="attendance<%=i%>"  disabled id="absent<%=i%>" value="A" />

            <%
            }else{%><input type="radio" name="attendance<%=i%>" disabled  id="absent<%=i%>" value="A" onclick="return absent();" />
         <% }}
        }else{
                 qry="select absentin from tp#afterinterview where" +
               " eventcode = '"+event+"' AND companycode = '"+companycode+"' " +
               "And absentin='G' and studentid='"+rs.getString("studentid")+"'";

                rs8=db.getRowset(qry);

       if(rs8.next()){
       %>
       <input type="radio" name="attendance<%=i%>" checked  id="absent<%=i%>" value="A" onclick="return absent();"/>
       <%}else{%>
       <input type="radio" name="attendance<%=i%>"  id="absent<%=i%>" value="A" onclick="return absent();"/>
          <%}
        }%>
            </td>
        </tr>
       
       <input type=hidden name="studentid<%=i%>" id="studentid<%=i%>" value="<%=rs.getString("studentid")%>"/>
<%
   }
   %>
        <tr><td align="center" colspan="7"><input type="Submit" value="Save"></td></tr></table>
<%      
            }
  
      
    }   else if(request.getParameter("round").equals("I")){
       // company=request.getParameter("companycode")==null?"":request.getParameter("companycode").trim();
       //  eventcode=request.getParameter("event")==null?"":request.getParameter("event").trim();
         round=request.getParameter("round")==null?"":request.getParameter("round").trim();
          qry="SELECT  status FROM tp#afterinterview WHERE" +
               " eventcode = '"+event+"' AND companycode = '"+companycode+"' " +
               "And status='G' union SELECT  status FROM tp#afterinterview WHERE" +
               " eventcode = '"+event+"' AND companycode = '"+companycode+"' " +
               "And status='I'" ;
               
       //  out.print(qry);
           rs=db.getRowset(qry);
           if(!rs.next())
          {
                 out.print("<center><font size=4 color=red>Please Select Student from Previous Round For This Round.</font></center>");
            }else{%>
            <table cellpadding=3  id="tblSearch" c class="mytable filterable" cellspacing=2 align=center rules=groups border=2 bordercolor="black" width="80%" >
               <tr>
                   <td valign="center" >
                      <input type="text" readonly  style="width:20px;height:20px;background-color:white;">: Unselected Student &nbsp;&nbsp;
                      <input type="text" readonly  style="width:20px;height:20px;background-color:lightpink;">: Selected in Written&nbsp;&nbsp;
                      <input type="text" readonly  style="width:20px;height:20px;background-color:lightblue;">: Selected in G.D.&nbsp;&nbsp;
                      <input type="text" readonly  style="width:20px;height:20px;background-color:lightgreen;">: Selected in Interview&nbsp;&nbsp;
                   </td>
               </tr>
           </table>
          <br> 
         <table width="30%" border="2" cellpadding=3  id="tblSearch" class="mytable filterable" cellspacing=2 align=center bordercolor="black" bottommargin=0  topmargin=0> <tr  bgcolor="silver">
    <%
     if(round.equals("W"))
          {
          round12="Written";
          }else if(round.equals("G"))
          {
          round12="G.D";
          }
          else if(round.equals("I"))
          {
          round12="Interview";
          }
     %><td align="center" nowrap colspan="3" ><Font size="3" COLOR="black" align="center">Round :</FONT>
     <Font size="3" COLOR="black" align="center"><u><%=round12%></u></FONT>
     </td></tr>
        <tr bgcolor="silver">
      <td align="center"><Font size="3" COLOR="black" align="center">Enrollment No. &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;&nbsp;Student's Name &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp;</FONT></td>
        <td align="center"><Font size="3" COLOR="black" align="center">Present</FONT></td>
        <td align="center"><Font size="3" COLOR="black" align="center">Absent</FONT></td>
        </tr>
        <% 
           qry="SELECT DISTINCT studentname,studentid,ENROLLMENTNO FROM studentmaster WHERE studentid IN (SELECT DISTINCT studentid " +
             "FROM tp#AfterInterview WHERE status = 'G' and eventcode='"+event+"' and " +
             "companycode='"+companycode+"') union SELECT DISTINCT studentname,studentid,ENROLLMENTNO FROM studentmaster WHERE studentid IN (SELECT DISTINCT studentid " +
             "FROM tp#AfterInterview WHERE status = 'I' and eventcode='"+event+"' and " +
             "companycode='"+companycode+"') order by studentname";
         //  out.print(qry);
         rs=db.getRowset(qry);
           while(rs.next()){
               i++;
           %>
        <tr>
       <td align="left" nowrap>
        <%   qry1="SELECT  status FROM tp#afterinterview WHERE" +
               " eventcode = '"+event+"' AND companycode = '"+companycode+"' " +
               "And status='I' and studentid='"+rs.getString("studentid")+"' " ;
          // out.print(qry1);
        rs1=db.getRowset(qry1);
            rs3=db.getRowset(qry1);
            rs2=db.getRowset(qry1);
            rs4=db.getRowset(qry1);
            rs5=db.getRowset(qry1);
            rs6=db.getRowset(qry1);
            rs7=db.getRowset(qry1);
            if(rs1.next())
        {%><input type="checkbox" id="check<%=i%>" checked  name="check<%=i%>" value="Y" onclick="return absent();"/>
        <input type="hidden" value="Y" name="dbvalue<%=i%>" id="dbvalue<%=i%>" >
        <%}else{%>
<input type="hidden" value="N" name="dbvalue<%=i%>" id="dbvalue<%=i%>" >
            <% qry="select absentin from tp#afterinterview where" +
               " eventcode = '"+event+"' AND companycode = '"+companycode+"' " +
               "And absentin='I' and studentid='"+rs.getString("studentid")+"'";

                rs8=db.getRowset(qry);

       if(rs8.next())
       {%>
        <input type="checkbox" id="check<%=i%>"  disabled  name="check<%=i%>" value="Y" onclick="return absent();"/>
       <%}else{%>
       <input type="checkbox" id="check<%=i%>"   name="check<%=i%>" value="Y" onclick="return absent();"/>
      <%}}  if(rs3.next()){
        statu=rs3.getString("status")==null?"":rs3.getString("status").trim();
      // out.print(statu);

            if(statu.equals("I"))
            {
            %> <input type="text" id="enroll<%=i%>" name="enroll<%=i%>"  readonly  value="<%=rs.getString("ENROLLMENTNO")%>" style="width:100px;color: black; font-family: Verdana; font-weight: bold; font-size: 12px; background-color: lightgreen;">
            <input type="text" id="sname<%=i%>" name="sname<%=i%>"   value="<%=rs.getString("studentname")%>" style="width:250px;color: black; font-family: Verdana; font-weight: bold; font-size: 12px; background-color:lightgreen;">
            <a href="#" onclick="window.open('joiningstatus.jsp?id=<%=rs.getString("studentid")%>','newwindow', 'width=400, height=200','center=50')" >Joining Status</a>
            <%} else{%> <input type="text" id="enroll<%=i%>" name="enroll<%=i%>"  readonly  value="<%=rs.getString("ENROLLMENTNO")%>" style="width:100px;color: black; font-family: Verdana; font-weight: bold; font-size: 12px; background-color: lightgreen;">
            <input type="text" id="sname<%=i%>" name="sname<%=i%>"  readonly value="<%=rs.getString("studentname")%>" style="width:250px;"/><%}%>
            <%}else{%> <input type="text" id="enroll<%=i%>" name="enroll<%=i%>"  readonly  value="<%=rs.getString("ENROLLMENTNO")%>" style="width:100px;">
            <input type="text" id="sname<%=i%>" name="sname<%=i%>"  readonly value="<%=rs.getString("studentname")%>" style="width:250px;"/><%}%>
       </td><td align="center">
            <%  if(rs4.next())
        { status1=rs4.getString("status")==null?"":rs4.getString("status").trim();
            //
            if(status1.equals("I")){
           %><input type="radio" name="attendance<%=i%>" checked   id="present<%=i%>" value="P"  onclick="return absentinlast();"/>
            <%
            }else{%><input type="radio" name="attendance<%=i%>"   checked id="present<%=i%>" value="P" onclick="return absent();"/>
         <% }
        }else{%>
       <input type="radio" name="attendance<%=i%>" checked id="present<%=i%>" value="P" onclick="return absent();"/>
       <%}%>

            </td>
            <td align="center">
               <%  if(rs7.next())
        { status2=rs7.getString("status")==null?"":rs7.getString("status").trim();
            if(status2.equals("I")){
            %><input type="radio" name="attendance<%=i%>" disabled id="absent<%=i%>" value="A" onclick="return absentinlast();"/>

            <%
            }else{%><input type="radio" name="attendance<%=i%>"  id="absent<%=i%>" value="A" onclick="return absent();"/>
         <% }
        }else{
                 qry="select absentin from tp#afterinterview where" +
               " eventcode = '"+event+"' AND companycode = '"+companycode+"' " +
               "And absentin='I' and studentid='"+rs.getString("studentid")+"'";

                rs8=db.getRowset(qry);

       if(rs8.next()){
       %>
       <input type="radio" name="attendance<%=i%>" checked  id="absent<%=i%>" value="A" onclick="return absent();"/>
       <%}else{%>
       <input type="radio" name="attendance<%=i%>"  id="absent<%=i%>" value="A" onclick="return absent();"/>
          <%}
        }%>
            </td>
        </tr>
       
       <input type=hidden name="studentid<%=i%>" id="studentid<%=i%>" value="<%=rs.getString("studentid")%>"/>
<%
   }
  %>
        <tr><td align="center" colspan="7"><input type="Submit" value="Save"></td></tr></table>
<%

    }}
           }
            else if(request.getParameter("roundname").trim().equals("WI"))
          {
            if(request.getParameter("round").equals("W")){
                %>
                <table cellpadding=3  id="tblSearch" c class="mytable filterable" cellspacing=2 align=center rules=groups border=2 bordercolor="black" width="80%" >
               <tr>
                   <td valign="center" >
                      <input type="text" readonly  style="width:20px;height:20px;background-color:white;">: Unselected Student &nbsp;&nbsp;
                      <input type="text" readonly  style="width:20px;height:20px;background-color:lightpink;">: Selected in Written&nbsp;&nbsp;
                      <input type="text" readonly  style="width:20px;height:20px;background-color:lightblue;">: Selected in G.D.&nbsp;&nbsp;
                      <input type="text" readonly  style="width:20px;height:20px;background-color:lightgreen;">: Selected in Interview&nbsp;&nbsp;
                   </td>
               </tr>
           </table>
          <br>
         <table width="30%" border="2" cellpadding=3  id="tblSearch" class="mytable filterable" cellspacing=2 align=center bordercolor="black" bottommargin=0  topmargin=0>
		  <tr  bgcolor="silver">
    <%
     if(request.getParameter("round").equals("W"))
          {
          round12="Written";
          }
          else if(request.getParameter("round").equals("I"))
          {
          round12="Interview";
          }
     %><td align="center" nowrap colspan="3" ><Font size="3" COLOR="black" align="center">Round :</FONT>
     <Font size="3" COLOR="black" align="center"><u><%=round12%></u></FONT>
     </td></tr>
        <tr bgcolor="silver">
       <td align="center"><Font size="3" COLOR="black" align="center">Enrollment No. &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;&nbsp;Student's Name &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp;</FONT></td>
        <td align="center"><Font size="3" COLOR="black" align="center">Present</FONT></td>
        <td align="center"><Font size="3" COLOR="black" align="center">Absent</FONT></td>

        </tr>
        <%
          // company=request.getParameter("companycode")==null?"":request.getParameter("companycode").trim();
           //eventcode=request.getParameter("event")==null?"":request.getParameter("event").trim();
            round=request.getParameter("round")==null?"":request.getParameter("round").trim();
           qry="SELECT DISTINCT studentname,studentid,ENROLLMENTNO FROM studentmaster WHERE studentid IN (SELECT DISTINCT studentid " +
             "FROM tp#eventparticipents WHERE registered = 'Y' and eventcode='"+event+"' and " +
             "companycode='"+companycode+"') order by studentname";
          // out.print(qry);
         rs=db.getRowset(qry);
           while(rs.next()){
               i++;
           %>
        <tr>
       <td align="left" nowrap>
           <%
            qry1="SELECT  status FROM tp#afterinterview WHERE" +
               " eventcode = '"+event+"' AND companycode = '"+companycode+"' " +
               "And status='W' and studentid='"+rs.getString("studentid")+"' union SELECT  status FROM tp#afterinterview WHERE" +
               " eventcode = '"+event+"' AND companycode = '"+companycode+"' " +
               "And status='I' and studentid='"+rs.getString("studentid")+"'" ;
           //out.print(qry1);
            rs1=db.getRowset(qry1);
            rs2=db.getRowset(qry1);
            rs3=db.getRowset(qry1);
            rs4=db.getRowset(qry1);
            rs5=db.getRowset(qry1);
            rs6=db.getRowset(qry1);
            rs7=db.getRowset(qry1);
            

        if(rs1.next())
        { if(rs2.next()){
            stat=rs2.getString("status")==null?"":rs2.getString("status").trim();
            if(stat.equals("I")){
            %><input type="checkbox" id="check<%=i%>" checked  disabled  name="check<%=i%>" value="Y" onclick="return absent();"/>
              <input type="hidden" value="Y" name="dbvalue<%=i%>" id="dbvalue<%=i%>" >
            <%
            }else{%><input type="checkbox" id="check<%=i%>" checked   name="check<%=i%>" value="Y" onclick="return absent();" />
                    <input type="hidden" value="N" name="dbvalue<%=i%>" id="dbvalue<%=i%>" >
         <% }}
        }else{%> <input type="hidden" value="N" name="dbvalue<%=i%>" id="dbvalue<%=i%>" >
        <% qry="select absentin from tp#afterinterview where" +
               " eventcode = '"+event+"' AND companycode = '"+companycode+"' " +
               "And absentin='W' and studentid='"+rs.getString("studentid")+"'";

                rs8=db.getRowset(qry);

       if(rs8.next())
       {%>
        <input type="checkbox" id="check<%=i%>"  disabled  name="check<%=i%>" value="Y" onclick="return absent();"/>
       <%}else{%>
       <input type="checkbox" id="check<%=i%>"   name="check<%=i%>" value="Y" onclick="return absent();"/>
      <%}}
         if(rs3.next()){
        statu=rs3.getString("status")==null?"":rs3.getString("status").trim();
      // out.print(statu);

            if(statu.equals("I"))
            {
            %> <input type="text" id="enroll<%=i%>" name="enroll<%=i%>"   value="<%=rs.getString("ENROLLMENTNO")%>" style="width:100px;color: black; font-family: Verdana; font-weight: bold; font-size: 12px; background-color: lightgreen;">
            <input type="text" id="sname<%=i%>" name="sname<%=i%>"   value="<%=rs.getString("studentname")%>" style="width:250px;color: black; font-family: Verdana; font-weight: bold; font-size: 12px; background-color: lightgreen;">
             <a href="#" onclick="window.open('joiningstatus.jsp?id=<%=rs.getString("studentid")%>','newwindow', 'width=400, height=200')" >Joining Status</a>
            <%} else{%><input type="text" id="enroll<%=i%>" name="enroll<%=i%>"   value="<%=rs.getString("ENROLLMENTNO")%>" style="width:100px;color: black; font-family: Verdana; font-weight: bold; font-size: 12px; background-color: lightpink;">
            <input type="text" id="sname<%=i%>" name="sname<%=i%>"  readonly value="<%=rs.getString("studentname")%>" style="width:250px;color: black; font-family: Verdana; font-weight: bold; font-size: 12px; background-color: lightpink;"/><%}%>
            <%}else{%><input type="text" id="enroll<%=i%>" name="enroll<%=i%>"   value="<%=rs.getString("ENROLLMENTNO")%>" style="width:100px;">
            <input type="text" id="sname<%=i%>" name="sname<%=i%>"  readonly value="<%=rs.getString("studentname")%>" style="width:250px;"/><%}%>
</td>
<td align="center">
            <%  if(rs4.next())
        { status1=rs4.getString("status")==null?"":rs4.getString("status").trim();
            //
            if(status1.equals("I")){
           %><input type="radio" name="attendance<%=i%>" checked  disabled  id="present<%=i%>" value="P"  onclick="return absentinlast();"/>
            <%
            }else {%><input type="radio" name="attendance<%=i%>"   checked id="present<%=i%>" value="P" onclick="return absent();"/>
         <% }
        }else{%>
       <input type="radio" name="attendance<%=i%>" checked id="present<%=i%>" value="P" onclick="return absent();"/>
       <%}%>

            </td>
            <td align="center">
               <%  if(rs7.next())
        { status2=rs7.getString("status")==null?"":rs7.getString("status").trim();
            if(status2.equals("I")){
            %><input type="radio" name="attendance<%=i%>" disabled id="absent<%=i%>" value="A" onclick="return absentinlast();"/>

            <%
            }else if(status1.equals("W")){%><input type="radio" name="attendance<%=i%>"  disabled id="absent<%=i%>" value="A" onclick="return absent();"/>
         <% }
        }else{
                 qry="select absentin from tp#afterinterview where" +
               " eventcode = '"+event+"' AND companycode = '"+companycode+"' " +
               "And absentin='W' and studentid='"+rs.getString("studentid")+"'";

                rs8=db.getRowset(qry);

       if(rs8.next()){
       %>
       <input type="radio" name="attendance<%=i%>" checked  id="absent<%=i%>" value="A" onclick="return absent();"/>
       <%}else{%>
       <input type="radio" name="attendance<%=i%>"  id="absent<%=i%>" value="A" onclick="return absent();"/>
          <%}
        }%>
            </td>
        </tr>
      
       <input type=hidden name="studentid<%=i%>" id="studentid<%=i%>" value="<%=rs.getString("studentid")%>"/>
<%
   }
  %>
         <tr><td align="center" colspan="7"><input type="Submit" value="Save"></td></tr></table>
<%

    }else if(request.getParameter("round").equals("I"))
    {      // company=request.getParameter("companycode")==null?"":request.getParameter("companycode").trim();
           // eventcode=request.getParameter("event")==null?"":request.getParameter("event").trim();
            round=request.getParameter("round")==null?"":request.getParameter("round").trim();
        qry="SELECT  status FROM tp#afterinterview WHERE" +
               " eventcode = '"+event+"' AND companycode = '"+companycode+"' " +
               "And status='W' union SELECT  status FROM tp#afterinterview WHERE" +
               " eventcode = '"+event+"' AND companycode = '"+companycode+"' " +
               "And status='I' ";
           // out.print(qry);
           rs=db.getRowset(qry);
           if(!rs.next())
          {
                 out.print("<center><font size=4 color=red>Please Select Student from Previous Round For This Round.</font></center>");
            }else{
        %><table cellpadding=3  id="tblSearch" c class="mytable filterable" cellspacing=2 align=center rules=groups border=2 bordercolor="black" width="80%" >
               <tr>
                   <td valign="center" >
                      <input type="text" readonly  style="width:20px;height:20px;background-color:white;">: Unselected Student &nbsp;&nbsp;
                      <input type="text" readonly  style="width:20px;height:20px;background-color:lightpink;">: Selected in Written&nbsp;&nbsp;
                      <input type="text" readonly  style="width:20px;height:20px;background-color:lightblue;">: Selected in G.D.&nbsp;&nbsp;
                      <input type="text" readonly  style="width:20px;height:20px;background-color:lightgreen;">: Selected in Interview&nbsp;&nbsp;
                   </td>
               </tr>
           </table>
          <br> 
         <table width="30%" border="2" cellpadding=3  id="tblSearch" class="mytable filterable" cellspacing=2 align=center bordercolor="black" bottommargin=0  topmargin=0>
		  <tr  bgcolor="silver">
    <%
     if(round.equals("W"))
          {
          round12="Written";
          }
          else if(round.equals("I"))
          {
          round12="Interview";
          }
     %><td align="center" nowrap colspan="3" ><Font size="3" COLOR="black" align="center">Round :</FONT>
     <Font size="3" COLOR="black" align="center"><u><%=round12%></u></FONT>
     </td></tr>
        <tr bgcolor="silver">
       <td align="center"><Font size="3" COLOR="black" align="center">Enrollment No. &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;&nbsp;Student's Name &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp;</FONT></td>
        <td align="center"><Font size="3" COLOR="black" align="center">Present</FONT></td>
        <td align="center"><Font size="3" COLOR="black" align="center">Absent</FONT></td>
        </tr>
        <% //company=request.getParameter("companycode")==null?"":request.getParameter("companycode").trim();
          // eventcode=request.getParameter("event")==null?"":request.getParameter("event").trim();
            round=request.getParameter("round")==null?"":request.getParameter("round").trim();
           qry="SELECT DISTINCT studentname,studentid,ENROLLMENTNO FROM studentmaster WHERE studentid IN (SELECT DISTINCT studentid " +
             "FROM tp#AfterInterview WHERE status = 'W' and eventcode='"+event+"' and " +
             "companycode='"+companycode+"') union SELECT DISTINCT studentname,studentid,ENROLLMENTNO FROM studentmaster WHERE studentid IN (SELECT DISTINCT studentid " +
             "FROM tp#AfterInterview WHERE status = 'I' and eventcode='"+event+"' and " +
             "companycode='"+companycode+"') order by studentname";
           //out.print(qry);
         rs=db.getRowset(qry);
           while(rs.next()){
               i++;
           %>
        <tr>
       <td align="left" nowrap>
       <%   qry1="SELECT  status FROM tp#afterinterview WHERE" +
               " eventcode = '"+event+"' AND companycode = '"+companycode+"' " +
               "And status='I' and studentid='"+rs.getString("studentid")+"' " ;
            rs1=db.getRowset(qry1);
            rs2=db.getRowset(qry1);
            rs3=db.getRowset(qry1);
            rs4=db.getRowset(qry1);
            rs7=db.getRowset(qry1);
            if(rs1.next())
        {%><input type="checkbox" id="check<%=i%>" checked  name="check<%=i%>" value="Y" onclick="return absent();"/>
        <input type="hidden" value="Y" name="dbvalue<%=i%>" id="dbvalue<%=i%>" >
        <%}else{%> <input type="hidden" value="N" name="dbvalue<%=i%>" id="dbvalue<%=i%>" >
        <% qry="select absentin from tp#afterinterview where" +
               " eventcode = '"+event+"' AND companycode = '"+companycode+"' " +
               "And absentin='I' and studentid='"+rs.getString("studentid")+"'";

                rs8=db.getRowset(qry);

       if(rs8.next())
       {%>
        <input type="checkbox" id="check<%=i%>"  disabled  name="check<%=i%>" value="Y" onclick="return absent();"/>
       <%}else{%>
       <input type="checkbox" id="check<%=i%>"   name="check<%=i%>" value="Y"  onclick="return absent();"/>
      <%}}
       
       if(rs3.next()){
        statu=rs3.getString("status")==null?"":rs3.getString("status").trim();
      // out.print(statu);

            if(statu.equals("I"))
            {
            %> <input type="text" id="enroll<%=i%>" name="enroll<%=i%>"   value="<%=rs.getString("ENROLLMENTNO")%>" style="width:100px;color: black; font-family: Verdana; font-weight: bold; font-size: 12px; background-color: lightgreen;">
            <input type="text" id="sname<%=i%>" name="sname<%=i%>"   value="<%=rs.getString("studentname")%>" style="width:250px;color: black; font-family: Verdana; font-weight: bold; font-size: 12px; background-color: lightgreen;">
             <a href="#" onclick="window.open('joiningstatus.jsp?id=<%=rs.getString("studentid")%>','newwindow', 'width=400, height=200')" >Joining Status</a>
            <%} else{%>
<input type="text" id="enroll<%=i%>" name="enroll<%=i%>"   value="<%=rs.getString("ENROLLMENTNO")%>" style="width:100px;">
<input type="text" id="sname<%=i%>" name="sname<%=i%>"  readonly value="<%=rs.getString("studentname")%>" style="width:250px;"/><%}%>
            <%}else{%><input type="text" id="enroll<%=i%>" name="enroll<%=i%>"   value="<%=rs.getString("ENROLLMENTNO")%>" style="width:100px;">
            <input type="text" id="sname<%=i%>" name="sname<%=i%>"  readonly value="<%=rs.getString("studentname")%>" style="width:250px;"/><%}%>
    </td>
    <td align="center">
            <%  if(rs4.next())
        { status1=rs4.getString("status")==null?"":rs4.getString("status").trim();
            //
            if(status1.equals("I")){
           %><input type="radio" name="attendance<%=i%>" checked   id="present<%=i%>" value="P"  onclick="return absent();"/>
            <%
            }else{%><input type="radio" name="attendance<%=i%>"   checked id="present<%=i%>" value="P" onclick="return absent();"/>
         <% }
        }else{%>
       <input type="radio" name="attendance<%=i%>" checked id="present<%=i%>" value="P" onclick="return absent();"/>
       <%}%>

            </td>
            <td align="center">
               <%  if(rs7.next())
        { status2=rs7.getString("status")==null?"":rs7.getString("status").trim();
            if(status2.equals("I")){
            %><input type="radio" name="attendance<%=i%>" disabled id="absent<%=i%>" value="A" onclick="return absent();"/>

            <%
            }else{%><input type="radio" name="attendance<%=i%>"  id="absent<%=i%>" value="A" onclick="return absent();"/>
         <% }
        }else{
                 qry="select absentin from tp#afterinterview where" +
               " eventcode = '"+event+"' AND companycode = '"+companycode+"' " +
               "And absentin='I' and studentid='"+rs.getString("studentid")+"'";

                rs8=db.getRowset(qry);

       if(rs8.next()){
       %>
       <input type="radio" name="attendance<%=i%>" checked  id="absent<%=i%>" value="A" onclick="return absent();"/>
       <%}else{%>
       <input type="radio" name="attendance<%=i%>"  id="absent<%=i%>" value="A" onclick="return absent();" />
          <%}
        }%>
            </td>
    
        </tr>
        
        <input type=hidden name="studentid<%=i%>" id="studentid<%=i%>" value="<%=rs.getString("studentid")%>"/>

<%
   }
  %>
        <tr><td align="center" colspan="3"><input type="Submit" value="Submit "></td></tr></table>
<%

    }
        }   }
          else if(request.getParameter("roundname").trim().equals("GI"))
          {

         if(request.getParameter("round").equals("G")){%>
         <table cellpadding=3  id="tblSearch" c class="mytable filterable" cellspacing=2 align=center rules=groups border=2 bordercolor="black" width="80%" >
               <tr>
                   <td valign="center" >
                      <input type="text" readonly  style="width:20px;height:20px;background-color:white;">: Unselected Student &nbsp;&nbsp;
                      <input type="text" readonly  style="width:20px;height:20px;background-color:lightpink;">: Selected in Written&nbsp;&nbsp;
                      <input type="text" readonly  style="width:20px;height:20px;background-color:lightblue;">: Selected in G.D.&nbsp;&nbsp;
                      <input type="text" readonly  style="width:20px;height:20px;background-color:lightgreen;">: Selected in Interview&nbsp;&nbsp;
                   </td>
               </tr>
           </table>
          <br>
          <table width="30%" border="2" cellpadding=3  id="tblSearch" class="mytable filterable" cellspacing=2 align=center bordercolor="black" bottommargin=0  topmargin=0>
		   <tr  bgcolor="silver">
    <%//out.print(round.equals("G"));
     if(request.getParameter("round").equals("G"))
          {
          round12="G.D";
          }
          else if(round.equals("I"))
          {
          round12="Interview";
          }
     %><td align="center" nowrap colspan="3" ><Font size="3" COLOR="black" align="center">Round :</FONT>
     <Font size="3" COLOR="black" align="center"><u><%=round12%></u></FONT>
     </td></tr>
        <tr bgcolor="silver">
      <td align="center"><Font size="3" COLOR="black" align="center">Enrollment No. &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;&nbsp;Student's Name &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp;</FONT></td>
        <td align="center"><Font size="3" COLOR="black" align="center">Present</FONT></td>
        <td align="center"><Font size="3" COLOR="black" align="center">Absent</FONT></td>
        </tr>
        <% //company=request.getParameter("companycode")==null?"":request.getParameter("companycode").trim();
           //eventcode=request.getParameter("event")==null?"":request.getParameter("event").trim();
            round=request.getParameter("round")==null?"":request.getParameter("round").trim();
        qry="SELECT DISTINCT studentname,studentid,ENROLLMENTNO FROM studentmaster WHERE studentid IN (SELECT DISTINCT studentid " +
             "FROM tp#eventparticipents WHERE registered = 'Y' and eventcode='"+event+"' and " +
             "companycode='"+companycode+"') order by studentname";
      //   out.print(qry);
         rs=db.getRowset(qry);
           while(rs.next()){
               i++;
           %>
        <tr>
       <td align="left" nowrap>

         <%
            qry1="SELECT  status FROM tp#afterinterview WHERE" +
               " eventcode = '"+event+"' AND companycode = '"+companycode+"' " +
               "And status='G' and studentid='"+rs.getString("studentid")+"' union SELECT  status FROM tp#afterinterview WHERE" +
               " eventcode = '"+event+"' AND companycode = '"+companycode+"' " +
               "And status='I' and studentid='"+rs.getString("studentid")+"'" ;
           //out.print(qry1);
        rs1=db.getRowset(qry1);
        rs2=db.getRowset(qry1);
        rs3=db.getRowset(qry1);
        rs4=db.getRowset(qry1);
        rs5=db.getRowset(qry1);
        rs6=db.getRowset(qry1);
        rs7=db.getRowset(qry1);
        if(rs1.next())
        { if(rs2.next()){
            stat=rs2.getString("status")==null?"":rs2.getString("status").trim();
            if(stat.equals("I")){
           %><input type="checkbox" id="check<%=i%>" checked  disabled  name="check<%=i%>" value="Y" onclick="return absent();"/>
              <input type="hidden" value="Y" name="dbvalue<%=i%>" id="dbvalue<%=i%>" >
            <%
            }else{%><input type="checkbox" id="check<%=i%>" checked   name="check<%=i%>" value="Y" onclick="return absent();" />
                    <input type="hidden" value="N" name="dbvalue<%=i%>" id="dbvalue<%=i%>" >
         <% }}
        }else{%> <input type="hidden" value="N" name="dbvalue<%=i%>" id="dbvalue<%=i%>" >
        <% qry="select absentin from tp#afterinterview where" +
               " eventcode = '"+event+"' AND companycode = '"+companycode+"' " +
               "And absentin='G' and studentid='"+rs.getString("studentid")+"'";

                rs8=db.getRowset(qry);

       if(rs8.next())
       {%>
        <input type="checkbox" id="check<%=i%>"  disabled  name="check<%=i%>" value="Y" onclick="return absent();"/>
       <%}else{%>
       <input type="checkbox" id="check<%=i%>"   name="check<%=i%>" value="Y" onclick="return absent();"/>
      <%}}
       
        if(rs3.next()){
        statu=rs3.getString("status")==null?"":rs3.getString("status").trim();
      // out.print(statu);
        
            if(statu.equals("I"))
            {
            %>
            <input type="text" id="enroll<%=i%>" name="enroll<%=i%>"   value="<%=rs.getString("ENROLLMENTNO")%>" style="width:100px;color: black; font-family: Verdana; font-weight: bold; font-size: 12px; background-color: lightgreen;">
            <input type="text" id="sname<%=i%>" name="sname<%=i%>"   value="<%=rs.getString("studentname")%>" style="width:250px;color: black; font-family: Verdana; font-weight: bold; font-size: 12px; background-color: lightgreen;">
           <a href="#" onclick="window.open('joiningstatus.jsp?id=<%=rs.getString("studentid")%>','newwindow', 'width=400, height=200')" >Joining Status</a>
           <%} else{%>
             <input type="text" id="enroll<%=i%>" name="enroll<%=i%>"   value="<%=rs.getString("ENROLLMENTNO")%>" style="width:100px;color: black; font-family: Verdana; font-weight: bold; font-size: 12px; background-color: lightblue;">
            <input type="text" id="sname<%=i%>" name="sname<%=i%>"  readonly value="<%=rs.getString("studentname")%>" style="width:250px;color: black; font-family: Verdana; font-weight: bold; font-size: 12px; background-color: lightblue;"/><%}%>
            <%}else{%>
<input type="text" id="enroll<%=i%>" name="enroll<%=i%>"   value="<%=rs.getString("ENROLLMENTNO")%>" style="width:100px;">
<input type="text" id="sname<%=i%>" name="sname<%=i%>"  readonly value="<%=rs.getString("studentname")%>" style="width:250px;"/><%}%>
       </td>
        <td align="center">
            <%  if(rs4.next())
        { status1=rs4.getString("status")==null?"":rs4.getString("status").trim();
            //
            if(status1.equals("I")){
           %><input type="radio" name="attendance<%=i%>" checked  disabled  id="present<%=i%>" value="P"  onclick="return absentinlast();"/>
            <%
            }else {%><input type="radio" name="attendance<%=i%>"   checked id="present<%=i%>" value="P" onclick="return absent();"/>
         <% }
        }else{%>
       <input type="radio" name="attendance<%=i%>" checked id="present<%=i%>" value="P" onclick="return absent();"/>
       <%}%>

            </td>
            <td align="center">
               <%  if(rs7.next())
        { status2=rs7.getString("status")==null?"":rs7.getString("status").trim();
            if(status2.equals("I")){
            %><input type="radio" name="attendance<%=i%>" disabled id="absent<%=i%>" value="A" onclick="return absentinlast();"/>

            <%
            }else if(status1.equals("G")){%><input type="radio" name="attendance<%=i%>"  disabled id="absent<%=i%>" value="A" onclick="return absent();"/>
         <% }
        }else{
                 qry="select absentin from tp#afterinterview where" +
               " eventcode = '"+event+"' AND companycode = '"+companycode+"' " +
               "And absentin='G' and studentid='"+rs.getString("studentid")+"'";

                rs8=db.getRowset(qry);

       if(rs8.next()){
       %>
       <input type="radio" name="attendance<%=i%>" checked  id="absent<%=i%>" value="A" onclick="return absent();"/>
       <%}else{%>
       <input type="radio" name="attendance<%=i%>"  id="absent<%=i%>" value="A" onclick="return absent();"/>
          <%}
        }%>
            </td>
        </tr>
        
        <input type=hidden name="studentid<%=i%>" id="studentid<%=i%>" value="<%=rs.getString("studentid")%>"/>
<%
   }
  %>
       <tr><td align="center" colspan="7"><input type="Submit" value="Save"></td></tr></table>
<%

    }
           else if(request.getParameter("round").equals("I"))
    {      company=request.getParameter("companycode")==null?"":request.getParameter("companycode").trim();
           eventcode=request.getParameter("event")==null?"":request.getParameter("event").trim();
           round=request.getParameter("round")==null?"":request.getParameter("round").trim();
           qry="SELECT  status FROM tp#afterinterview WHERE" +
               " eventcode = '"+event+"' AND companycode = '"+companycode+"' " +
               "and status='G' union SELECT  status FROM tp#afterinterview WHERE" +
               " eventcode = '"+event+"' AND companycode = '"+companycode+"' " +
               "and status='I'";
           // out.print(qry);
           rs=db.getRowset(qry);
           if(!rs.next())
          {
                 out.print("<center><font size=4 color=red>Please Select Student from Previous Round For This Round.</font></center>");
            }else{%>
            <table cellpadding=3  id="tblSearch" c class="mytable filterable" cellspacing=2 align=center rules=groups border=2 bordercolor="black" width="80%" >
               <tr>
                   <td valign="center" >
                      <input type="text" readonly  style="width:20px;height:20px;background-color:white;">: Unselected Student &nbsp;&nbsp;
                      <input type="text" readonly  style="width:20px;height:20px;background-color:lightpink;">: Selected in Written&nbsp;&nbsp;
                      <input type="text" readonly  style="width:20px;height:20px;background-color:lightblue;">: Selected in G.D.&nbsp;&nbsp;
                      <input type="text" readonly  style="width:20px;height:20px;background-color:lightgreen;">: Selected in Interview&nbsp;&nbsp;
                   </td>
               </tr>
           </table>

          <br>
         <table width="30%" border="2" cellpadding=3  id="tblSearch" class="mytable filterable" cellspacing=2 align=center bordercolor="black" bottommargin=0  topmargin=0>
         <tr  bgcolor="silver">
    <%
     if(round.equals("W"))
          {
          round12="Written";
          }else if(round.equals("G"))
          {
          round12="G.D";
          }
          else if(round.equals("I"))
          {
          round12="Interview";
          }
     %><td align="center" nowrap colspan="3" ><Font size="3" COLOR="black" align="center">Round :</FONT>
     <Font size="3" COLOR="black" align="center"><u><%=round12%></u></FONT>
     </td></tr>
		<tr bgcolor="silver">
      <td align="center"><Font size="3" COLOR="black" align="center">Enrollment No. &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;&nbsp;Student's Name &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp;</FONT></td>
        <td align="center"><Font size="3" COLOR="black" align="center">Present</FONT></td>
        <td align="center"><Font size="3" COLOR="black" align="center">Absent</FONT></td>
        </tr>
        <%// company=request.getParameter("companycode")==null?"":request.getParameter("companycode").trim();
           ///eventcode=request.getParameter("event")==null?"":request.getParameter("event").trim();
            round=request.getParameter("round")==null?"":request.getParameter("round").trim();
           qry="SELECT DISTINCT studentname,studentid,ENROLLMENTNO FROM studentmaster WHERE studentid IN (SELECT DISTINCT studentid " +
             "FROM tp#AfterInterview WHERE status = 'G' and eventcode='"+event+"' and " +
             "companycode='"+companycode+"') union SELECT DISTINCT studentname,studentid,ENROLLMENTNO FROM studentmaster WHERE studentid IN (SELECT DISTINCT studentid " +
             "FROM tp#AfterInterview WHERE status = 'I' and eventcode='"+event+"' and " +
             "companycode='"+companycode+"') order by studentname";
       //    out.print(qry);
         rs=db.getRowset(qry);
           while(rs.next()){
               i++;
           %>
        <tr>
       <td align="left" nowrap>
       <%   qry1="SELECT  status FROM tp#afterinterview WHERE" +
               " eventcode = '"+event+"' AND companycode = '"+companycode+"' " +
               "And status='I' and studentid='"+rs.getString("studentid")+"' " ;
            rs1=db.getRowset(qry1);
            rs2=db.getRowset(qry1);
            rs4=db.getRowset(qry1);
            rs7=db.getRowset(qry1);
            rs3=db.getRowset(qry1);
            if(rs1.next())
         {%><input type="checkbox" id="check<%=i%>" checked  name="check<%=i%>" value="Y" onclick="return absent();"/>
        <input type="hidden" value="Y" name="dbvalue<%=i%>" id="dbvalue<%=i%>" >
        <%}else{%> <input type="hidden" value="N" name="dbvalue<%=i%>" id="dbvalue<%=i%>" >
        <% qry="select absentin from tp#afterinterview where" +
               " eventcode = '"+event+"' AND companycode = '"+companycode+"' " +
               "And absentin='I' and studentid='"+rs.getString("studentid")+"'";

                rs8=db.getRowset(qry);

       if(rs8.next())
       {%>
        <input type="checkbox" id="check<%=i%>"  disabled  name="check<%=i%>" value="Y" onclick="return absent();"/>
       <%}else{%>
       <input type="checkbox" id="check<%=i%>"   name="check<%=i%>" value="Y" onclick="return absent();"/>
      <%}}  if(rs3.next()){
        statu=rs3.getString("status")==null?"":rs3.getString("status").trim();
      // out.print(statu);

            if(statu.equals("I"))
            {
            %><input type="text" id="enroll<%=i%>" name="enroll<%=i%>"   value="<%=rs.getString("ENROLLMENTNO")%>" style="width:100px;color: black; font-family: Verdana; font-weight: bold; font-size: 12px; background-color: lightgreen;">
            <input type="text" id="sname<%=i%>" name="sname<%=i%>"   value="<%=rs.getString("studentname")%>" style="width:250px;color: black; font-family: Verdana; font-weight: bold; font-size: 12px; background-color: lightgreen;">
             <a href="#" onclick="window.open('joiningstatus.jsp?id=<%=rs.getString("studentid")%>','newwindow', 'width=400, height=200')" >Joining Status</a>
            <%} else{%><input type="text" id="enroll<%=i%>" name="enroll<%=i%>"   value="<%=rs.getString("ENROLLMENTNO")%>" style="width:100px;">
            <input type="text" id="sname<%=i%>" name="sname<%=i%>"  readonly value="<%=rs.getString("studentname")%>" style="width:250px;"/><%}%>
            <%}else{%>
<input type="text" id="enroll<%=i%>" name="enroll<%=i%>"   value="<%=rs.getString("ENROLLMENTNO")%>" style="width:100px;">
<input type="text" id="sname<%=i%>" name="sname<%=i%>"  readonly value="<%=rs.getString("studentname")%>" style="width:250px;"/><%}%>
       </td>
        <td align="center">
            <%  if(rs4.next())
        { status1=rs4.getString("status")==null?"":rs4.getString("status").trim();
            //
            if(status1.equals("I")){
           %><input type="radio" name="attendance<%=i%>" checked   id="present<%=i%>" value="P"  onclick="return absent();"/>
            <%
            }else{%><input type="radio" name="attendance<%=i%>"   checked id="present<%=i%>" value="P" onclick="return absent();"/>
         <% }
        }else{%>
       <input type="radio" name="attendance<%=i%>" checked id="present<%=i%>" value="P" onclick="return absent();"/>
       <%}%>

            </td>
            <td align="center">
               <%  if(rs7.next())
        { status2=rs7.getString("status")==null?"":rs7.getString("status").trim();
            if(status2.equals("I")){
            %><input type="radio" name="attendance<%=i%>" disabled id="absent<%=i%>" value="A" onclick="return absent();"/>

            <%
            }else{%><input type="radio" name="attendance<%=i%>"  id="absent<%=i%>" value="A" onclick="return absent();"/>
         <% }
        }else{
                 qry="select absentin from tp#afterinterview where" +
               " eventcode = '"+event+"' AND companycode = '"+companycode+"' " +
               "And absentin='I' and studentid='"+rs.getString("studentid")+"'";

                rs8=db.getRowset(qry);

       if(rs8.next()){
       %>
       <input type="radio" name="attendance<%=i%>" checked  id="absent<%=i%>" value="A" onclick="return absent();"/>
       <%}else{%>
       <input type="radio" name="attendance<%=i%>"  id="absent<%=i%>" value="A" onclick="return absent();" />
          <%}
        }%>
            </td>
       </tr>
        
        <input type=hidden name="studentid<%=i%>" id="studentid<%=i%>" value="<%=rs.getString("studentid")%>"/>

<%
   }
  %>
      <tr><td align="center" colspan="7"><input type="Submit" value="Save"></td></tr></table>
<%

    }}
           }
          else if(request.getParameter("roundname").trim().equals("I"))
          {
 if(request.getParameter("round").equals("I")){%>
 <table cellpadding=3  id="tblSearch" c class="mytable filterable" cellspacing=2 align=center rules=groups border=2 bordercolor="black" width="80%" >
               <tr>
                   <td valign="center" >
                      <input type="text" readonly  style="width:20px;height:20px;background-color:white;">: Unselected Student &nbsp;&nbsp;
                      <input type="text" readonly  style="width:20px;height:20px;background-color:lightpink;">: Selected in Written&nbsp;&nbsp;
                      <input type="text" readonly  style="width:20px;height:20px;background-color:lightblue;">: Selected in G.D.&nbsp;&nbsp;
                      <input type="text" readonly  style="width:20px;height:20px;background-color:lightgreen;">: Selected in Interview&nbsp;&nbsp;
                   </td>
               </tr>
           </table>
          <br> 
         <table width="30%" border="2" cellpadding=3  id="tblSearch" class="mytable filterable" cellspacing=2 align=center bordercolor="black" bottommargin=0  topmargin=0>
		  <tr  bgcolor="silver">
    <%
    
          round12="Interview";
         
     %><td align="center" nowrap colspan="3" ><Font size="3" COLOR="black" align="center">Round :</FONT>
     <Font size="3" COLOR="black" align="center"><u><%=round12%></u></FONT>
     </td></tr>
        <tr bgcolor="silver">
      <td align="center"><Font size="3" COLOR="black" align="center">Enrollment No. &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;&nbsp;Student's Name &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp;</FONT></td>
        <td align="center"><Font size="3" COLOR="black" align="center">Present</FONT></td>
        <td align="center"><Font size="3" COLOR="black" align="center">Absent</FONT></td>


        </tr>
        <%// company=request.getParameter("companycode")==null?"":request.getParameter("companycode").trim();
           //eventcode=request.getParameter("event")==null?"":request.getParameter("event").trim();
            round=request.getParameter("round")==null?"":request.getParameter("round").trim();
           qry="SELECT DISTINCT studentname,studentid,ENROLLMENTNO FROM studentmaster WHERE studentid IN (SELECT DISTINCT studentid " +
             "FROM tp#eventparticipents WHERE registered = 'Y' and eventcode='"+event+"' and " +
             "companycode='"+companycode+"') order by studentname";
       //   out.print(qry);
         rs=db.getRowset(qry);
           while(rs.next()){
               i++;
           %>
        <tr>
       <td align="left" nowrap>

    <%   qry1="SELECT  status FROM tp#afterinterview WHERE" +
               " eventcode = '"+event+"' AND companycode = '"+companycode+"' " +
               "And status='I' and studentid='"+rs.getString("studentid")+"' " ;
            rs1=db.getRowset(qry1);
            rs3=db.getRowset(qry1);
            rs2=db.getRowset(qry1);
            rs4=db.getRowset(qry1);
            rs7=db.getRowset(qry1);
            if(rs1.next())
        {%><input type="checkbox" id="check<%=i%>" checked  name="check<%=i%>" value="Y" onclick="return absent();"/>
        <input type="hidden" value="Y" name="dbvalue<%=i%>" id="dbvalue<%=i%>" >
        <%}else{%> <input type="hidden" value="N" name="dbvalue<%=i%>" id="dbvalue<%=i%>" >
        <% qry="select absentin from tp#afterinterview where" +
               " eventcode = '"+event+"' AND companycode = '"+companycode+"' " +
               "And absentin='I' and studentid='"+rs.getString("studentid")+"'";

                rs8=db.getRowset(qry);

       if(rs8.next())
       {%>
        <input type="checkbox" id="check<%=i%>"  disabled  name="check<%=i%>" value="Y" onclick="return absent();"/>
       <%}else{%>
       <input type="checkbox" id="check<%=i%>"   name="check<%=i%>" value="Y" onclick="return absent();"/>
      <%}}  if(rs3.next()){
        statu=rs3.getString("status")==null?"":rs3.getString("status").trim();
      // out.print(statu);

            if(statu.equals("I"))
            {
            %><input type="text" id="enroll<%=i%>" name="enroll<%=i%>"   value="<%=rs.getString("ENROLLMENTNO")%>" style="width:100px;color: black; font-family: Verdana; font-weight: bold; font-size: 12px; background-color: lightgreen;">
            <input type="text" id="sname<%=i%>" name="sname<%=i%>"   value="<%=rs.getString("studentname")%>" style="width:250px;color: black; font-family: Verdana; font-weight: bold; font-size: 12px; background-color: lightgreen;">
             <a href="#" onclick="window.open('joiningstatus.jsp?id=<%=rs.getString("studentid")%>','newwindow', 'width=400, height=200')" >Joining Status</a>
            <%} else{%>
<input type="text" id="enroll<%=i%>" name="enroll<%=i%>"   value="<%=rs.getString("ENROLLMENTNO")%>" style="width:100px;">
<input type="text" id="sname<%=i%>" name="sname<%=i%>"  readonly value="<%=rs.getString("studentname")%>" style="width:250px;"/><%}%>
            <%}else{%>
            <input type="text" id="enroll<%=i%>" name="enroll<%=i%>"   value="<%=rs.getString("ENROLLMENTNO")%>" style="width:100px;">
            <input type="text" id="sname<%=i%>" name="sname<%=i%>"  readonly value="<%=rs.getString("studentname")%>" style="width:250px;"/><%}%>
       </td>
               <td align="center">
            <%  if(rs4.next())
        { status1=rs4.getString("status")==null?"":rs4.getString("status").trim();
            //
            if(status1.equals("I")){
           %><input type="radio" name="attendance<%=i%>" checked   id="present<%=i%>" value="P"  onclick="return absent();"/>
            <%
            }else{%><input type="radio" name="attendance<%=i%>"   checked id="present<%=i%>" value="P" onclick="return absent();"/>
         <% }
        }else{%>
       <input type="radio" name="attendance<%=i%>" checked id="present<%=i%>" value="P" onclick="return absent();"/>
       <%}%>

            </td>
            <td align="center">
               <%  if(rs7.next())
        { status2=rs7.getString("status")==null?"":rs7.getString("status").trim();
            if(status2.equals("I")){
            %><input type="radio" name="attendance<%=i%>" disabled id="absent<%=i%>" value="A" onclick="return absent();"/>

            <%
            }else{%><input type="radio" name="attendance<%=i%>"  id="absent<%=i%>" value="A" onclick="return absent();"/>
         <% }
        }else{
                 qry="select absentin from tp#afterinterview where" +
               " eventcode = '"+event+"' AND companycode = '"+companycode+"' " +
               "And absentin='I' and studentid='"+rs.getString("studentid")+"'";

                rs8=db.getRowset(qry);

       if(rs8.next()){
       %>
       <input type="radio" name="attendance<%=i%>" checked  id="absent<%=i%>" value="A" onclick="return absent();"/>
       <%}else{%>
       <input type="radio" name="attendance<%=i%>"  id="absent<%=i%>" value="A" onclick="return absent();" />
          <%}
        }%>
            </td>
        </tr>
        <input type=hidden name="studentid<%=i%>" id="studentid<%=i%>" value="<%=rs.getString("studentid")%>"/>

  <% }%>
  <tr><td align="center" colspan="7"><input type="Submit" value="Save"></td></tr></table><%

    }
    
           }%>
     
<%}%>
           <input type="hidden" name="event" id="event" value="<%=event%>">
           <input type="hidden" name="companycode" id="companycode" value="<%=companycode%>">
           <input type="hidden" name="round1" id="round1" value="<%=round%>">
            <input type="hidden" name="cnt" id="cnt" value="<%=i%>">
                 <input type="hidden" name="roundname" id="roundname" value="<%=roundname%>">
    
<% //out.print("round ="+round+" event="+eventcode+" company="+company);
}
catch(Exception e)
       {
    //    out.print("Error in Student List:"+ e);
     }
try{
cnt=Integer.parseInt(request.getParameter("cnt"));
//out.print(cnt);
 //out.print("****"+absent);
if(request.getParameter("Z")!=null)
    {

for(j=0;j<=cnt;j++)
      {
    //
    absent=request.getParameter("attendance"+j)==null?"":request.getParameter("attendance"+j).trim();
       round1=request.getParameter("round1")==null?"":request.getParameter("round1").trim();
       Event=request.getParameter("event")==null?"":request.getParameter("event").trim();
       Companycode=request.getParameter("companycode")==null?"":request.getParameter("companycode").trim();
       studentid=request.getParameter("studentid"+j)==null?"":request.getParameter("studentid"+j).trim();
       studentname=request.getParameter("sname"+j)==null?"":request.getParameter("sname"+j).trim();
       enroll=request.getParameter("enroll"+j)==null?"":request.getParameter("enroll"+j).trim();
//out.print("****"+absent);
         if(absent.equals("A"))
     {
    qry=" SELECT 'Y' FROM TP#AFTERINTERVIEW where eventcode='"+Event+"' and " +
           "companycode='"+Companycode+"' and institutecode='"+mInst+"' and studentid='"+studentid+"'";
   //out.print("****"+qry);
    rs=db.getRowset(qry);
    if(rs.next())
    {
    qry2="UPDATE TP#AFTERINTERVIEW SET  SELECTED='',";

    if(roundname.equals("WGI"))
         {

        if(round1.equals("W"))
 {
    qry2=qry2+"status='', ABSENTIN ='W'";
 }
if(round1.equals("G"))
 {
    qry2=qry2+"status='W', ABSENTIN ='G'";
 }else if(round1.equals("I"))
 {
    qry2=qry2+"status='G', ABSENTIN ='I'";
 }


     }

    else if(roundname.equals("GI"))
     {if(round1.equals("G"))
 {
    qry2=qry2+"status='',ABSENTIN ='G'";
 }else
     if(round1.equals("I"))
 {
    qry2=qry2+"status='G', ABSENTIN ='I'";
 }
     }else if(roundname.equals("WI"))
     {
      if(round1.equals("W"))
 {
    qry2=qry2+"status='', ABSENTIN ='W'";
 }
else if(round1.equals("I"))
 {
    qry2=qry2+"status='W', ABSENTIN ='I'";
 }
     }else
         {
     qry2=qry2+"status='', ABSENTIN ='I'";
     }

qry2=qry2+" WHERE  eventcode='"+Event+"' and companycode='"+Companycode+"' and " +
        "institutecode='"+mInst+"' and studentid='"+studentid+"'  ";
    /*
    if(roundname.equals("WGI"))
         {
        if(round1.equals("W"))
    {
    qry2=qry2+" STATUS ='W' ";
    }

if(round1.equals("G"))
    {
    qry2=qry2+" STATUS ='W' ";
    }
else if(round1.equals("I"))
 {
    qry2=qry2+" STATUS ='G' ";
 }
     }else if(roundname.equals("GI"))
     {
     if(round1.equals("I"))
 {
    qry2=qry2+" STATUS ='G' ";
 }
     }else if(roundname.equals("WI"))
     {
  if(round1.equals("I"))
 {
    qry2=qry2+" STATUS ='W' ";
 }
     }
*/
///out.print(qry2+"<br>");
k=db.insertRow(qry2);

}else
    {//out.print("gyan"+roundname);
    if(roundname.equals("WGI"))
         {
if(round1.equals("W"))
    {
qry2="INSERT INTO TP#AFTERINTERVIEW (EVENTCODE, COMPANYCODE, INSTITUTECODE, STUDENTID,  " +
        "ENTRYDATE, ABSENTIN) VALUES ('"+Event+"','"+Companycode+"','"+mInst+"','"+studentid+"',sysdate,'W')";
//out.print(qry2);
p=db.insertRow(qry2);
}

}else if(roundname.equals("GI"))
{
if (round1.equals("G"))
  {
qry2="INSERT INTO TP#AFTERINTERVIEW (EVENTCODE, COMPANYCODE, INSTITUTECODE, STUDENTID,  " +
        "ENTRYDATE, ABSENTIN) VALUES ('"+Event+"','"+Companycode+"','"+mInst+"','"+studentid+"',sysdate,'G')";
//out.print(qry2);
p=db.insertRow(qry2);
}
}else if(roundname.equals("WI"))
{
if (round1.equals("W"))
  {
qry2="INSERT INTO TP#AFTERINTERVIEW (EVENTCODE, COMPANYCODE, INSTITUTECODE, STUDENTID,  " +
        "ENTRYDATE, ABSENTIN) VALUES ('"+Event+"','"+Companycode+"','"+mInst+"','"+studentid+"',sysdate,'W')";
//out.print(qry2);
p=db.insertRow(qry2);
}
}else if(roundname.equals("I"))
    {
if (round1.equals("I"))
  {
qry2="INSERT INTO TP#AFTERINTERVIEW (EVENTCODE, COMPANYCODE, INSTITUTECODE, STUDENTID,  " +
        "ENTRYDATE, ABSENTIN) VALUES ('"+Event+"','"+Companycode+"','"+mInst+"','"+studentid+"',sysdate,'I')";
//out.print(qry2);
p=db.insertRow(qry2);
}
}

}
 }
 else if(absent.equals("P"))
       {
    qry=" SELECT 'Y' FROM TP#AFTERINTERVIEW where eventcode='"+Event+"' and companycode='"+Companycode+"' and institutecode='"+mInst+"' and studentid='"+studentid+"'";
    rs=db.getRowset(qry);
    if(rs.next())
    {
    qry2="UPDATE TP#AFTERINTERVIEW SET  ABSENTIN='',selected='' where eventcode='"+Event+"' and companycode='"+Companycode+"' and institutecode='"+mInst+"' and studentid='"+studentid+"'";

//out.print(qry2);
k=db.insertRow(qry2);

}
    
 
      if(request.getParameter("check"+j)==null)
           {
        mchk="N";
           }
     else{
        z++;
       mchk="Y";
        }


      if(mchk.equals("N"))
              {
            round1=request.getParameter("round1")==null?"":request.getParameter("round1").trim();
            Event=request.getParameter("event")==null?"":request.getParameter("event").trim();
            Companycode=request.getParameter("companycode")==null?"":request.getParameter("companycode").trim();
            studentid=request.getParameter("studentid"+j)==null?"":request.getParameter("studentid"+j).trim();
            studentname=request.getParameter("sname"+j)==null?"":request.getParameter("sname"+j).trim();
            enroll=request.getParameter("enroll"+j)==null?"":request.getParameter("enroll"+j).trim();
            //out.print("Gyan"+studentid+"round1"+round1+"Event"+Event+"Companycode"+Companycode+"absent"+absent);
    
          if(roundname.equals("WGI")){
                if(round1.equals("W")){  
            qry=" Delete FROM TP#AFTERINTERVIEW where eventcode='"+Event+"' and companycode='"+Companycode+"'" +
                " and institutecode='"+mInst+"' and studentid='"+studentid+"' " +
                " ";
         //  out.print(qry);
             r=db.update(qry);
               }}
            else if(roundname.equals("WI")){
                if(round1.equals("W")){
                 qry=" Delete FROM TP#AFTERINTERVIEW where eventcode='"+Event+"' and companycode='"+Companycode+"'" +
                    " and institutecode='"+mInst+"' and studentid='"+studentid+"' " +
                    " ";
             r=db.update(qry);
                }}
            else if(roundname.equals("GI")){
                if(round1.equals("G")){
                 qry=" Delete FROM TP#AFTERINTERVIEW where eventcode='"+Event+"' and companycode='"+Companycode+"'" +
                    " and institutecode='"+mInst+"' and studentid='"+studentid+"' " +
                    " ";
             r=db.update(qry);
                }}
            else if(roundname.equals("I")){
                if(round1.equals("I")){
                qry=" Delete FROM TP#AFTERINTERVIEW where eventcode='"+Event+"' and companycode='"+Companycode+"'" +
                    " and institutecode='"+mInst+"' and studentid='"+studentid+"' " +
                    " ";
             r=db.update(qry);
                }}
          
   
    qry=" SELECT 'Y' FROM TP#AFTERINTERVIEW where eventcode='"+Event+"' and companycode='"+Companycode+"' and institutecode='"+mInst+"' and studentid='"+studentid+"'";

    rs=db.getRowset(qry);
    if(rs.next())
    {
    qry2="UPDATE TP#AFTERINTERVIEW set ";

    if(roundname.equals("WGI"))
         {
if(round1.equals("G"))
    {
    qry2=qry2+"STATUS ='W'";
    }
else if(round1.equals("I"))
 {
    qry2=qry2+"STATUS ='G'";
 }
     }else if(roundname.equals("GI"))
     {
     if(round1.equals("I"))
 {
    qry2=qry2+"STATUS ='G'";
 }
     }else if(roundname.equals("WI"))
     {
  if(round1.equals("I"))
 {
    qry2=qry2+"STATUS ='W'";
 }
     }

qry2=qry2+" WHERE  eventcode='"+Event+"' and companycode='"+Companycode+"' and " +
        "institutecode='"+mInst+"' and studentid='"+studentid+"' and ";
    if(roundname.equals("WGI"))
         {
if(round1.equals("G"))
    {
    qry2=qry2+" STATUS ='G'";
    }
else if(round1.equals("I"))
 {
    qry2=qry2+" STATUS ='I'";
 }
     }else if(roundname.equals("GI"))
     {
     if(round1.equals("I"))
 {
    qry2=qry2+" STATUS ='I'";
 }
     }else if(roundname.equals("WI"))
     {
  if(round1.equals("I"))
 {
    qry2=qry2+" STATUS ='I'  ";
 }
     }
//out.print("For delete"+qry2);
o=db.insertRow(qry2);

}
}

    if(mchk.equals("Y"))
    {   
             round1=request.getParameter("round1")==null?"":request.getParameter("round1").trim();
            Event=request.getParameter("event")==null?"":request.getParameter("event").trim();
            Companycode=request.getParameter("companycode")==null?"":request.getParameter("companycode").trim();
            studentid=request.getParameter("studentid"+j)==null?"":request.getParameter("studentid"+j).trim();

            //out.print("Gyan"+studentid+"round1"+round1+"Event"+Event+"Companycode"+Companycode);
    qry=" SELECT 'Y' FROM TP#AFTERINTERVIEW where eventcode='"+Event+"' and companycode='"+Companycode+"' and institutecode='"+mInst+"' and studentid='"+studentid+"'";
//out.print(qry);
    rs=db.getRowset(qry);
if(rs.next())
{
    qry2="UPDATE TP#AFTERINTERVIEW SET ";

    if(roundname.equals("WGI"))
         {
if(round1.equals("W"))
    {
    qry2=qry2+"STATUS ='W' ";
    }
else if(round1.equals("G"))
    {
    qry2=qry2+"STATUS ='G' ";
    }
else if(round1.equals("I"))
 {
    qry2=qry2+"STATUS ='I',selected='Y' ";
 }
     }else if(roundname.equals("GI"))
     {
         if(round1.equals("G"))
    {
    qry2=qry2+"STATUS ='G' ";
    }
else if(round1.equals("I"))
 {
    qry2=qry2+"STATUS ='I',selected='Y' ";
 }
     }else if(roundname.equals("WI"))
     {
         if(round1.equals("W"))
    {
    qry2=qry2+"STATUS ='W' ";
    }
else if(round1.equals("I"))
 {
    qry2=qry2+"STATUS ='I',selected='Y' ";
 }
     }else if(roundname.equals("I"))
         {
         if(round1.equals("I"))
 {
    qry2=qry2+"STATUS ='I' ,selected='Y'";
 }
         }

qry2=qry2+" ,absentin='' WHERE  eventcode='"+Event+"' and companycode='"+Companycode+"' and " +
        "institutecode='"+mInst+"' and studentid='"+studentid+"' ";


//out.print(qry2);
x=db.insertRow(qry2);

}
else
    {//out.print("gyan"+roundname);
    if(roundname.equals("WGI"))
         {
if(round1.equals("W"))
    {
qry2="INSERT INTO TP#AFTERINTERVIEW (EVENTCODE, COMPANYCODE, INSTITUTECODE, STUDENTID, " +
        "ENTRYDATE, STATUS) VALUES ('"+Event+"','"+Companycode+"','"+mInst+"','"+studentid+"',sysdate,'W')";
//out.print(qry2);
d=db.insertRow(qry2);
}

}else if(roundname.equals("GI"))
{
if (round1.equals("G"))
  {
qry2="INSERT INTO TP#AFTERINTERVIEW (EVENTCODE, COMPANYCODE, INSTITUTECODE, STUDENTID, " +
        "ENTRYDATE, STATUS) VALUES ('"+Event+"','"+Companycode+"','"+mInst+"','"+studentid+"',sysdate,'G')";
//out.print(qry2);
d=db.insertRow(qry2);
}
}else if(roundname.equals("WI"))
{
if (round1.equals("W"))
  {
qry2="INSERT INTO TP#AFTERINTERVIEW (EVENTCODE, COMPANYCODE, INSTITUTECODE, STUDENTID, " +
        "ENTRYDATE, STATUS) VALUES ('"+Event+"','"+Companycode+"','"+mInst+"','"+studentid+"',sysdate,'W')";
//out.print(qry2);
d=db.insertRow(qry2);
}
}else if(roundname.equals("I"))
    {
if (round1.equals("I"))
  {
qry2="INSERT INTO TP#AFTERINTERVIEW (EVENTCODE, COMPANYCODE, INSTITUTECODE, STUDENTID, SELECTED, " +
        "ENTRYDATE, STATUS) VALUES ('"+Event+"','"+Companycode+"','"+mInst+"','"+studentid+"','Y',sysdate,'I')";
//out.print(qry2);
d=db.insertRow(qry2);
}
} 
    
}}}
}
if( x==0 && d==0 )

  {
out.print("<center><font color=Red size=4>No Student Selected</font></center>");
}
if(d>0||x>0)

    {
out.print("<center><font color=Green size=4>Selected Students</font></center>");

%>
</form>
<form name="c" id="c" method="post" action="selectedStudentXl.jsp">
<div id="printable"> <table width="30%" border="2" cellpadding=3  id="tblSearch" class="mytable filterable" cellspacing=2 align=center bordercolor="black" bottommargin=0  topmargin=0>
 <tr  bgcolor="silver">
     <td align="center" nowrap colspan="3" ><Font size="3" COLOR="black" align="center">Company :&nbsp; </FONT>
    <Font size="3" COLOR="black" align="center"><u><i><%=Companycode%></i></u></FONT></td>
     <%
     if(round1.equals("W"))
          {
          round12="Written";
          }else if(round1.equals("G"))
          {
          round12="G.D";
          }
          else if(round1.equals("I"))
          {
          round12="Interview";
          }
     %><td align="center" nowrap colspan="3" ><Font size="3" COLOR="black" align="center">Round :</FONT>
     <Font size="3" COLOR="black" align="center"><%=round12%></FONT>
     </td></tr>
  <tr bgcolor="silver">
   <td align="center" nowrap><Font size="3" COLOR="black" align="center">Sl.No.</FONT></td>
  
  <td align="center" nowrap><Font size="3" COLOR="black" align="center">Enrollment No.</FONT></td>
  <td align="center" nowrap><Font size="3" COLOR="black" align="center">Student Name</FONT></td>
  <td align="center" nowrap><Font size="3" COLOR="black" align="center">Batch</FONT></td>
  <td align="center" nowrap><Font size="3" COLOR="black" align="center">Branch</FONT></td>
 <td align="center" nowrap><Font size="3" COLOR="black" align="center">Semester</FONT></td>
  </tr>

<%//out.print("Gyan"+z);
for (int w=0;w<=j;w++)
      {//out.print(mchk);
      if(request.getParameter("check"+w)==null)
           {
        mchk="N";
//out.print("mcheck"+mchk);
        }
     else{
//out.print("mcheck"+mchk);
       mchk="Y";
        }

    if(mchk.equals("Y"))
    {
            round1=request.getParameter("round1")==null?"":request.getParameter("round1").trim();
            Event=request.getParameter("event")==null?"":request.getParameter("event").trim();
            Companycode=request.getParameter("companycode")==null?"":request.getParameter("companycode").trim();
            studentid=request.getParameter("studentid"+w)==null?"":request.getParameter("studentid"+w).trim();
            studentname=request.getParameter("sname"+w)==null?"":request.getParameter("sname"+w).trim();
             enroll=request.getParameter("enroll"+w)==null?"":request.getParameter("enroll"+w).trim();
          
                          %>


 


 <tr bgcolor="white" >
    <td align="left" nowrap >
       <%=++l%>
       <input type="hidden" value="<%=studentid%>" id="studentid<%=l%>" name="studentid<%=l%>">
      
     </td>  
      <td align="left" nowrap>
         <%=enroll%>
     </td>
     <td align="left" nowrap>
         <%=studentname%>
     </td>
    
         <%qry="select academicyear,branchcode,semester from studentmaster where studentid='"+studentid+"' ";
           rs=db.getRowset(qry);
           if(rs.next())
               {%>
            <td align="left" nowrap><%=rs.getString(1)==null?"":rs.getString(1).trim()%></td>
             <td align="left" nowrap><%=rs.getString(2)==null?"":rs.getString(2).trim()%></td>
             <td align="left" nowrap><%=rs.getString(3)==null?"":rs.getString(3).trim()%></td>
          <% }%>
       </td>
     </tr>
<%}
}%><input type="hidden" value="<%=round1%>" id="round1" name="round1">
<input type="hidden" value="<%=Event%>" id="Event" name="Event">
<input type="hidden" value="<%=Companycode%>" id="Companycode" name="Companycode">

<input type="hidden" name="l" value="<%=l%>" id="l"></table></div>


    <table bgcolor=#fce9c5  id="non-printable"  bottommargin=0 rules=rows topmargin=0 cellspacing=0 cellpadding=0   align=center>
					<tr><td align=center colspan=7>
					<font color=blue><a class=normaltext onclick="JavaScript:window.print();" >
					<img src="../../../Images/printer.gif"  style="cursor:hand"><b>Click to Print</b></a>
				&nbsp;&nbsp;&nbsp;&nbsp;
					<INPUT  Type="submit" Value="Save In Excel">
							</td>	
                    </tr>
</table>

<%}




}}catch(Exception e)
        {
//out.print("error in to Save records"+e);
}%>

     </form>

</body>
</html>






















