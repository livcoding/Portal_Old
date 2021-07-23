<%--
    Document   : ReconDeanApprovalaction
    Created on : 9 Mar, 2017, 10:51:50 AM
    Author     : VIVEK.SONI
--%>

<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page isELIgnored="false" errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%@ taglib prefix="ntb" uri="http://www.nitobi.com"%>

<html>
<%


String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead=" ";
session.setAttribute("CurrEvent","");
session.setAttribute("PrevEvent","");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", -1);
response.setHeader("Cache-Control", "no-store");

%>



<head>


<TITLE>#### <%=mHead%> [ Event-Wise Marks Entry ] </TITLE>


<script language="JavaScript" type ="text/javascript">
<!--
  if (top != self) top.document.title = document.title;
-->

if(window.history.forward(1) != null)
window.history.forward(1);

</script>

 <script language="javascript">
function load() {
document.getElementById("reconcile").disabled=true;

}
window.onload = load;

function kH(e) {

var pK = document.all? window.event.keyCode:e.which;
return pK != 13;
}

document.onkeypress = kH;
if (document.layers) document.captureEvents(Event.KEYPRESS);
</script>








<style type="text/css">
<!--

input-wrapper input[type=text] {
    width:100%;
    padding: 10px;
    margin: 0px;
}

table .last, td:last-child {
    padding: 2px 24px 2px 0px;
}

-->
</style>
<style type="text/css">
<!--
BODY{
scrollbar-face-color:#fce9c5;
scrollbar-arrow-color:darkpink;
scrollbar-track-color:darkpink;
scrollbar-shadow-color:'white';
scrollbar-highlight-color:'lightgray';
scrollbar-3dlight-color:'blue';
scrollbar-darkshadow-Color:'gray';
}
-->
</style>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">
function ChangeOptions(Exam,DataEvent,Event)
{
     removeAllOptions(Event);
	var QryEvent='';
     for(i=0;i<DataEvent.options.length;i++)
       {
		var v1;
		var pos;
		var ec;
		var ev;
		var len;
		var otext;
		var v1=DataEvent.options(i).value;
		len= v1.length ;
		pos=v1.indexOf('***');
		ec=v1.substring(0,pos);
		ev=v1.substring(pos+3,len);

		if (ec==Exam)
		 {
			var optn = document.createElement("OPTION");
			optn.text=DataEvent.options[i].text;
			optn.value=ev;
			if (QryEvent=='') QryEvent=ev;
			Event.options.add(optn);

		}

	 }



  	}
</script>
    <script>
// ----------click event on EventSubevent------------

function ChangeOptions1(Exam,QryEvent,DataCombo)
{        alert("hellofdgfdgggg");
     	removeAllOptions(Subject);

	for(i=0;i<DataCombo.options.length;i++)
       {
			var v1s1;
			var pos11;
			var pos21;
			var exams1;
			var evs1;
			var lens1;
			var sc1;
			var otexts1;
			var v1s1=DataCombo.options[i].value;

			lens1= v1s1.length ;
			pos11=v1s1.indexOf('***');
			pos21=v1s1.indexOf('///');
			exams1=v1s1.substring(0,pos11);
			evs1=v1s1.substring(pos11+3,pos21);
			//sc1=v1s1.substring(pos21+3,lens1);
			if (exams1==Exam && QryEvent==evs1)
	    	 {
				var optns1 = document.createElement("OPTION");
				optns1.text=DataCombo.options[i].text;
				optns1.value=sc1;

				//Subject.options.add(optns1);
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

</SCRIPT>



</head>

<body  aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0  onkeydown="if(event.keyCode==13){event.keyCode=9;return event.keyCode}">

<%
GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="",markslocked="";
String mDMemberCode="",mDMemberType="",mDept="",mDesg="", mComp="", minst="", mInst="",mDMemberID="";
String mExam="",mexam="",mExamid="",mEventsubevent="",mSubj="";
String qry="",qry1="",x="",msubsection="",mPrint="",facqry="";
int msno=0;
int len =0;
int pos=0;
String mSE="", mMaxMarks="";
double mWeight=0;
double mvalue=0,mMaxmarks=0,MyMax=0;
int ctr=0,flag=0;
String mStatus="";
String mIC="",mEC="",mSC="",mList="",mOrder="",mEvent="",mPrevEvent=""; //,mExamsubevent="",mExamevent="";
ResultSet rs=null,rss=null,rs1=null,rs2=null,rs3=null,rse=null,rsm=null,rsmm=null,facrse=null;
String mMOP="",mName5="",mlistorder="",mctr="",qrys="",mSelf="";
String msubeven="",mMarks="",mPerc="",mName1="",mMark="",mName2="",mName3="",msms="",mverified="", DEvent="";
String mEventsubevent1="",mSubj1="",msubj="";
session.setMaxInactiveInterval(10800);
session.setAttribute("Click",mSelf);

if (session.getAttribute("Designation")==null)
	mDesg="";
else
	mDesg=session.getAttribute("Designation").toString().trim();
if (session.getAttribute("Department")==null)
	mDept="";
else
	mDept=session.getAttribute("Department").toString().trim();
if (session.getAttribute("MemberID")==null)
	mMemberID="";
else
	mMemberID=session.getAttribute("MemberID").toString().trim();
if (session.getAttribute("MemberType")==null)
	mMemberType="";
else
	mMemberType=session.getAttribute("MemberType").toString().trim();
if (session.getAttribute("MemberName")==null)
	mMemberName="";
else
	mMemberName=session.getAttribute("MemberName").toString().trim();
if (session.getAttribute("MemberCode")==null)
	mMemberCode="";
else
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
if (session.getAttribute("InstituteCode")==null)
	mInst="";
else
	mInst=session.getAttribute("InstituteCode").toString().trim();
if (session.getAttribute("CompanyCode")==null)
	mComp="";
else
	mComp=session.getAttribute("CompanyCode").toString().trim();
try
{
        OLTEncryption enc=new OLTEncryption();
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{
            mDMemberCode=enc.decode(mMemberCode);
            mDMemberType=enc.decode(mMemberType);
            mDMemberID=enc.decode(mMemberID);
            String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
            String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
            String mIPAddress =session.getAttribute("IPADD").toString().trim();
            String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
            ResultSet RsChk1=null;

            session.setAttribute("isemp","dean");
	  //-----------------------------
	  //-- Enable Security Page Level
	  //-----------------------------

            qry="Select WEBKIOSK.ShowLink('400','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
            RsChk1= db.getRowset(qry);
            if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
            {

	  //----------------------
                %>
        	<form name="frm" method="get">
                <input id="y" name="y" type=hidden>



                <table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
                <tr><TD colspan="0" align="middle"><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><B><u>Dean Approval Form</u></B></TD>
                </font></td></tr>
                </TABLE>

                <table cellpadding=1 cellspacing=0 align=center rules=groups border=3>
                <tr><td><font color=Green face=arial size=2><STRONG><%=mMemberName%>[<%=mDMemberCode%>]
                &nbsp;&nbsp; : &nbsp;<%=GlobalFunctions.toTtitleCase(mDesg)%>&nbsp; (<%=GlobalFunctions.toTtitleCase(mDept)%>)
                </td></tr>
                <!--Institute****-->
                <tr><td><FONT color=black><FONT face=Arial size=2><STRONG>Institute</STRONG></FONT></FONT>
                <%
                try
                {

                    qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from institutemaster Where InstituteCode='"+mInst+"' and nvl(Deactive,'N')='N' ";
                    rs=db.getRowset(qry);

                        %>
                        <select name=InstCode tabindex="1" id="InstCode" style="WIDTH: 80px">
                        <%
                        while(rs.next())
                        {
                            mInst=rs.getString("InstCode");
                            if(mInst.equals(""))
                                minst=mInst;
                            %>
                            <OPTION selected Value =<%=mInst%>><%=mInst%></option>
                            <%
                        }
                        %>
                        </select>
                        <%


                }
                catch(Exception e)
                {
                    //out.println(e.getMessage());
                }
                %>
                <!--*********Exam**********-->
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <FONT color=black><FONT face=Arial size=2><STRONG>Exam Code</STRONG></FONT></FONT>
                <%
                    try
                    { %>
                            <select name=Exam1 tabindex="2" id="Exam1" style="WIDTH: 229px" disabled  >

                            <%
                          if(request.getParameter("y")!=null){
                            mexam=session.getAttribute("Dexam").toString();
                %>
                         <OPTION Value =<%=mexam%>><%=mexam%></option>
                        <input type=hidden name='Exam1' id='Exam1' value="<%=mexam%>">

               <%}else{
                                 mexam=request.getParameter("Exam");
                                 if(session.getAttribute("Dexam")==null){
                                 session.setAttribute("Dexam", mexam);
                                 }
                                 
                                %>
                                <OPTION Value =<%=mexam%>><%=mexam%></option>
                                 <input type=hidden name='Exam1' id='Exam1' value="<%=mexam%>">
                                <%
                            }
                            %>
                            </select>
                            <%


                    }
                    catch(Exception e)
                    {
                        //out.println(e.getMessage());
                    }
	%>

                    &nbsp;&nbsp;<FONT color=black><FONT face=Arial size=2><STRONG>Event-Subevent</STRONG></FONT></FONT>
                    <%
                    try
                    {
                         %>
                         <select name="Event" tabindex="3" id="Event" style="WIDTH: 215px"  disabled>

                            <%
                             if(request.getParameter("y")!=null){
                             mEvent=session.getAttribute("deanevent").toString();
                             %>

                               <OPTION Value ="<%=mEvent%>"><%=mEvent%></option>
                               <input type=hidden name='EventSubevent' id='EventSubevent' value="<%=mEvent%>">

                           <% }else{

                               mEvent=request.getParameter("Event");
                               if(session.getAttribute("deanevent")==null){
                                 session.setAttribute("deanevent", mEvent);
                                 }
                              // session.setAttribute("deanevent", mEvent);
                                %>
                                <OPTION Value ="<%=mEvent%>"><%=mEvent%></option>
                                  <input type=hidden name='EventSubevent' id='EventSubevent' value="<%=mEvent%>">
                                <%
                            }
                            %>
                            </select>
                            <%


                        //out.println("Subevent"+mEventsubevent);
                    }
                    catch(Exception e)
                    {
                        //out.print("error");
                    }
                    %>

                    </td></tr>
                    <tr><td>

	 <FONT color="black"><FONT face="Arial" size="2"><STRONG> Subject</STRONG></FONT></FONT>
                      <%
                   try
                    {
				  String Subqry=" select subject||'('||subjectcode||')' subject ,subjectid from subjectmaster where institutecode='"+mInst+"' and subjectid in(select distinct Subjectid from MR#ReconciledDetail  where INSTITUTECODE = '"+mInst+"' and   ExamCode='"+mexam+"'  and ForEventSubEvent='"+mEvent+"' and   nvl(Reconciled,'')in('M','F'))";
                      // out.print(qry);
                       ResultSet subrss=db.getRowset(Subqry);

                        if (request.getParameter("y")==null)
                        {
                            %>
                            <select name=Subject tabindex="2" id="Subject" style="WIDTH: 380px"   onchange="ChangeOptions(Subject.value,DataEvent,Faculty);">
                            <OPTION selected Value="NONE"><b><-- Select an Subject --></b></option>
                            <%
                            while(subrss.next())
                            {
                                mSubj=subrss.getString("subjectid");
                                %>
                                <OPTION Value =<%=mSubj%>><%=subrss.getString("Subject")%></option>
                                <%
                            }
                            %>
                            </select>
                            <%
                        }
                        else
                        {
                            %>
                            <select name=Subject tabindex="2" id="Subject" style="WIDTH: 380px" onclick="ChangeOptions(Subject.value,DataEvent,Faculty);" onChange="ChangeOptions(Exam.value,DataEvent,Event);">
                            <OPTION Value="NONE"><b><-- Select an Subject Code --></b></option>
                            <%
                            while(subrss.next())
                            {
                                mSubj=subrss.getString("subjectid");
                                if(mSubj.equals(request.getParameter("Subject").toString().trim()))
                                {
                                    %>
                                    <OPTION selected Value =<%=mSubj%>><%=subrss.getString("Subject")%></option>
                                    <%
                                }
                                else
                                {
                                    %>
                                    <OPTION Value =<%=mSubj%>><%=subrss.getString("Subject")%></option>
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


//********************DataEvent Combo*************/

	try
	{


  mPrint="select distinct a.Subjectid ,a.employeeid ,b.employeecode Employee  from MR#ReconciledDetail a ,V#STAFF b  where A.EMPLOYEEID=b.EMPLOYEEID and a.INSTITUTECODE = '"+mInst+"' and  ExamCode= '"+mexam+"' and a.ForEventSubEvent='"+mEvent+"' and   nvl(a.Reconciled,'')in('M','F','V')";
  rsmm=db.getRowset(mPrint);
	//out.print(qry);
	//if (request.getParameter("y")==null)
	///{
	//	%>
		<select name=DataEvent tabindex="0" id="DataEvent" style="WIDTH: 0px;display:none;">
		<%
                String mys="";
                
		while(rsmm.next())
		{
                        if(!rsmm.getString("Subjectid").equalsIgnoreCase(" ")){
			mEventsubevent1=rsmm.getString("Subjectid")+"***"+rsmm.getString("EMPLOYEEID").toString().trim();
			 %>
                         
			<OPTION Value ="<%=mEventsubevent1%>"><%=rsmm.getString("Employee")%></option>
			<%
                        }else{
                        mEventsubevent1=rsmm.getString("Subjectid")+"***"+rsmm.getString("EMPLOYEEID").toString().trim();%>
                        <OPTION Value ="<%=mEventsubevent1%>"><%=rse.getString("Employee")%></option>
                        <%}%>

		<%}
		%>
		</select>
		<%
	//}


	}
	catch(Exception e)
	{
		out.print("error");
	}
	//********************Event Combo************/

	%>



                    &nbsp;&nbsp;<FONT color=black><FONT face=Arial size=2><STRONG>Faculty-Code</STRONG></FONT></FONT>
                    <%
                    try
                    {
                        facqry="select distinct a.Subjectid ,a.employeeid ,b.employeecode Employee  from MR#ReconciledDetail a ,V#STAFF b  where " +
                                "A.EMPLOYEEID=b.EMPLOYEEID and a.INSTITUTECODE = '"+mInst+"' and  ExamCode= '"+mexam+"' " +
                                "and a.ForEventSubEvent='"+mEvent+"' and   nvl(a.Reconciled,'')in('M','F','V')";
			 facrse=db.getRowset(facqry);

                        if (request.getParameter("y")==null)
                        {
                            %>
                            <select name="Faculty" tabindex="3" id="Faculty" style="WIDTH: 150px" onclick="ChangeOptions1(Subject.value,Event.value,DataCombo);" onChange="ChangeOptions1(Subject.value,Event.value,DataCombo);">
                            <OPTION selected Value="ALL"><b> ALL </b></option>
                            <%
                            while(facrse.next())
                            {
                                mEventsubevent=facrse.getString("EMPLOYEEID");
                                %>
                                <OPTION Value ="<%=mEventsubevent%>"><%=facrse.getString("Employee")%></option>
                                <%
                            }
                            %>
                            </select>
                            <%
                        }
                        else
                        {
                            %>
                            <select name="Faculty" tabindex="3" id="Faculty" style="WIDTH: 150px" onclick="ChangeOptions1(Subject.value,Event.value,DataCombo);" onChange="ChangeOptions1(Subject.value,Event.value,DataCombo);">
                            <OPTION Value="ALL"><b>ALL</b></option>
                            <%
                            while(facrse.next())
                            {
                                mEventsubevent=facrse.getString("EMPLOYEEID");
                                if(mEventsubevent.equals(request.getParameter("Faculty")))
                                {
                                    %>
                                    <OPTION selected Value ="<%=mEventsubevent%>"><%=facrse.getString("Employee")%></option>
                                    <%
                                }
                                else
                                {
                                    %>
                                    <OPTION Value ="<%=mEventsubevent%>"><%=facrse.getString("Employee")%></option>
                                    <%
                                }
                            }
                            %>
                            </select>
                            <%
                        }
                        //out.println("Subevent"+mEventsubevent);
                    }
                    catch(Exception e)
                    {
                        //out.print("error");
                    }
                    %>
                    
                     &nbsp; &nbsp;  <INPUT Type="submit" name="show" Value="Show/Refresh" >

                    </td></tr>
                    <tr>


                        <td>
                    <%
                    String sel="";


                %>

                </td></tr>
                </table>
                </form>
 <%
                if(request.getParameter("y")!=null && request.getParameter("show").equalsIgnoreCase("Show/Refresh"))
                {%>
               <form name="infrm" method="get" action="">
               
                    
             <%       if( request.getParameter("Subject")!=null && request.getParameter("EventSubevent")!=null && request.getParameter("Exam1")!=null)
                    {
                        String selectedExam=request.getParameter("Exam1");
                        String selectedEvent=request.getParameter("EventSubevent");
                        String selectedEmp=request.getParameter("Faculty");
                        String selectedsub=request.getParameter("Subject").toString();
                        String selectedInst=request.getParameter("InstCode").toString();
                        //String selectedsubject=request.getParameter("Exam");

        qry="select A.EventSubevent ,A.EMPLOYEEID,B.EmployeeCode,B.EmployeeName, A.FileName ,A.Reconciled from MR#ReconciledDetail A,V#Staff B  where A.EMPLOYEEID =B.EMPLOYEEID And A.INSTITUTECODE = '"+mInst+"' " +
                "and A.ExamCode= '"+selectedExam+"'  and A.ForEventSubEvent='"+selectedEvent+"' and   A.EMPLOYEEID ='"+selectedEmp+"' and subjectID='"+selectedsub+"'" +
                " and nvl(A.Reconciled,'')in('M','F','V')";
        rs2=db.getRowset(qry);
       // out.println(qry);
        %>
        
        <table  bordercolor="#a52a2a" border="1" align="center" cellspacing="0"  cellpadding="0" width="72%">
            <thead>
                <tr>
                    <th>Event</th>
                    <th>Faculty Name</th>
                    <th>Faculty Code</th>
                    <th>Status</th>
                    <th>Remarks</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                int sno=0;
                while(rs2.next()){
                 String DBEvent=rs2.getString("EVENTSUBEVENT");
                 String DBemp=rs2.getString("EMPLOYEEID");
                 String stat=rs2.getString("RECONCILED");
                 String facname=rs2.getString("EmployeeName");
                 String faccode=rs2.getString("EmployeeCode");
                 sno++;
                 String tval="remarks"+String.valueOf(sno);
                 %>
                <tr>
                    <td align="center"><%=DBEvent%></td>
                    <td  align="center"><%=faccode%></td>
                    <td  align="center"><%=facname%></td>
                    <%

                    if(stat.equalsIgnoreCase("v"))
                    {
                        mverified="Verified";
                    }else  if(stat.equalsIgnoreCase("M")){
                     mverified="Mismatch";
                    }else  if(stat.equalsIgnoreCase("F")){
                     mverified="File not Found";
                    }

%>
                    <td align="center" a><%=mverified%></td>

                    <%
                   if(stat.equalsIgnoreCase("v"))
                    {
                        msms="";
                    }else  if(stat.equalsIgnoreCase("M")){
                     msms="Show Mismatch Data";
                    }else  if(stat.equalsIgnoreCase("F")){
                     msms="<< Click to Verify >>";
                    }
                    %>
                  <td align="center"><input type="text" style="WIDTH: 300px; HEIGHT: 22px" maxLength=50 NAME="<%=tval%>" id="<%=tval%>"value=""></td>

                    <%if(!stat.equalsIgnoreCase("F")){%>
                      <input type=hidden name='<%=tval%>' ID='<%=tval%>' value="">
                    <td align="center" ><A href="Reconverification.jsp?Inst=<%=selectedInst%>&DBEventCode=<%=DBEvent%>&Emp=<%=DBemp%>&Status=<%=stat%>&textval=<%=tval%>&Exam=<%=selectedExam%>&Subject=<%=selectedsub%>&selectedEventCode=<%=selectedEvent%>&empname=<%=facname%>&code=<%=faccode%>  "target=_new"  alt="Click here to view on line for details"><font size=3><b><%=msms%></b></font></A></td>
           
                    <%}else{%>
                        <td align="center" ><A href='Reconfilenotfound.jsp?Inst=<%=selectedInst%>&DBEventCode=<%=DBEvent%>&Emp=<%=DBemp%>&Status=<%=stat%>&textval=<%=tval%>&Exam=<%=selectedExam%>&Subject=<%=selectedsub%>&selectedEventCode=<%=selectedEvent%>&empname=<%=facname%>&code=<%=faccode%>&text=' ><font size=3><b><%=msms%></b></font></A></td>
                    <%}%>

                </tr>

                         <% }%>
                 </tbody>
            </table>
        </form>
            <%  }
                }
            }
            else
            {
                %>
                <br>
                <font color=red>
                <h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
                <P>	This page is not authorized/available for you.
                <br>For assistance, contact your network support team.
                </font>	<br>	<br>	<br>	<br>
                <%
            }
  //-----------------------------
        }
        else
        {
        	out.print("<br><img src='../../Images/Error1.jpg'>");
                out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
        }
}
//catch(org.json.JSONException e)
catch(Exception e)
{
    //System.out.println(e);
}
%>
</body>
</html>