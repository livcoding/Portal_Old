<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page isELIgnored="false" errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%@ taglib prefix="ntb" uri="http://www.nitobi.com"%>

<html xmlns:ntb>
<%

ServletContext context = pageContext.getServletContext();
String filePath = context.getInitParameter("Exfile-upload");
if(filePath!=null){
request.getSession().setAttribute("svrpath", filePath);
}
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
String testMarks=request.getParameter("testMarks");
String _marksOfTest=request.getParameter("marksOfStudent");
if(_marksOfTest!=null && !_marksOfTest.equals("")){
session.setAttribute("test_marks", _marksOfTest);
}
%>



<head>


<TITLE>#### <%=mHead%> [ Event-Wise Marks Entry ] </TITLE>
        <script type="text/javascript" src="js/sortabletable.js"></script>
        <link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
        <link type="text/css" rel="stylesheet" href="css/style/nitobi.grid.css">
        <link type="text/css" rel="stylesheet" href="css/style/callout/xp/nitobi.callout.css">
        <link type="text/css" rel="stylesheet" href="css/style/nitobi.combo.css">
        <script type="text/javascript" src="js/script/toolkit.js"></script>
        <script type="text/javascript" src="js/script/nitobi.grid.js"></script>
        <script type="text/javascript" src="js/script/nitobi.callout.js"></script>
        <script type="text/javascript" src="js/script/nitobi.combo.js"></script>

<script language="JavaScript" type ="text/javascript">
<!--
  if (top != self) top.document.title = document.title;
-->
</script>

 <script language="javascript">
function load() {
document.getElementById("reconcile").disabled=true;
if(<%=_marksOfTest%>!=null)
    {
  document.getElementById("reconcile").disabled=false;
    }
}
window.onload = load;

function kH(e) {

var pK = document.all? window.event.keyCode:e.which;
return pK != 13;
}

document.onkeypress = kH;
if (document.layers) document.captureEvents(Event.KEYPRESS);
</script>


<script language="text/javascript">
function showAlert()
{
 if(document.frm2("Proceed").checked==true)
 {
	alert('Once You will check and Lock , You cannot enter marks of the rest students further');
 }
 else
 {
	alert('You cannot proceed for Grade Entry until you check it and Lock it.');
 }
}

//-->
</script>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
function runCallout()
{
// Create a new callout with the 'xp' style
myCallout = new nitobi.callout.Callout("xp");
//alert(myCallout+"myCallout");
// use attachToElement to bind it to the form field (using ID, not NAME)
myCallout.attachToElement('columnheader_3_ntb__1');

// set the title of the element
myCallout.setTitle('New Version of Marks Entry!');

// set the body
myCallout.setBody('Enter marks directly or Copy-Paste from Excel enabled page. You are requested to keep SAVING. ');

// show it
myCallout.show();
}
</script>
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
String qry="",qry1="",x="",msubsection="",mPrint="";
int msno=0;
int len =0;
int pos=0;
String mSE="", mMaxMarks="";
double mWeight=0;
double mvalue=0,mMaxmarks=0,MyMax=0;
int ctr=0,flag=0;
String mStatus="";
String mIC="",mEC="",mSC="",mList="",mOrder="",mEvent="",mPrevEvent=""; //,mExamsubevent="",mExamevent="";
ResultSet rs=null,rss=null,rs1=null,rs2=null,rs3=null,rse=null,rsm=null,rsmm=null,rschk1=null;
String mMOP="",mName5="",mlistorder="",mctr="",qrys="",mSelf="";
String msubeven="",mMarks="",mPerc="",mName1="",mMark="",mName2="",mName3="",mName4="",mName7="";
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

	  //-----------------------------
	  //-- Enable Security Page Level
	  //-----------------------------

            qry="Select WEBKIOSK.ShowLink('400','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
            RsChk1= db.getRowset(qry);
            if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
            {

	  //----------------------
                %>
        	<form name="frm" method="get" action="ReconDeanApprovalaction.jsp">
                <input id="x" name="x" type=hidden>
              


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
                    if (request.getParameter("x")==null)
                    {
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
                     else
                     {
                        %>
                        <select name=InstCode tabindex="1" id="InstCode" style="WIDTH: 80px">
                        <%
                        while(rs.next())
                        {
                            mInst=rs.getString("InstCode");
                            if(mInst.equals(request.getParameter("InstCode").toString().trim()))
                            {
                                %>
                                <OPTION selected Value =<%=mInst%>><%=mInst%></option>
                                <%
                            }
                            else
                            {
                                %>
                                <OPTION Value =<%=mInst%>><%=mInst%></option>
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
                %>
                <!--*********Exam**********-->
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <FONT color=black><FONT face=Arial size=2><STRONG>Exam Code</STRONG></FONT></FONT>
                <%
                    try
                    {
				qry="select examcode from Exammaster where INSTITUTECODE = '"+mInst+"' and sysdate between EXAMPERIODFROM and EXAMPERIODTo";
//out.print(qry);

                        rs=db.getRowset(qry);
                        if (request.getParameter("x")==null)
                        {
                            %>
                            <select name=Exam tabindex="2" id="Exam" style="WIDTH: 229px"   onchange="ChangeOptions(Exam.value,DataEvent,Event);">
                            <OPTION selected Value="NONE"><b><-- Select an Exam --></b></option>
                            <%
                            while(rs.next())
                            {
                                mExamid=rs.getString("examcode");
                                %>
                                <OPTION Value =<%=mExamid%>><%=mExamid%></option>
                                <%
                            }
                            %>
                            </select>
                            <%
                        }
                        else
                        {
                            %>
                            <select name=Exam tabindex="2" id="Exam" style="WIDTH: 229px" onclick="ChangeOptions(Exam.value,DataEvent,Event);" onChange="ChangeOptions(Exam.value,DataEvent,DataCombo,Event);">
                            <OPTION Value="NONE"><b><-- Select an Exam Code --></b></option>
                            <%
                            while(rs.next())
                            {
                                mExamid=rs.getString("examcode");
                                if(mExamid.equals(request.getParameter("Exam").toString().trim()))
                                {
                                    %>
                                    <OPTION selected Value =<%=mExamid%>><%=mExamid%></option>
                                    <%
                                }
                                else
                                {
                                    %>
                                    <OPTION Value =<%=mExamid%>><%=mExamid%></option>
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


 qry="select distinct a.examcode,a.EXAMEVENTCODE,nvl(b.SUBEVENTCODE,' ') SUBEVENTCODE from exameventmaster a ,examsubeventmaster b where a.EXAMCODE=b.examcode(+) and a.EXAMEVENTCODE=b.EXAMEVENTCODE(+)and sysdate between EVENTfrom and EVENTUPTO";




	rse=db.getRowset(qry);
	//out.print(qry);
	if (request.getParameter("x")==null)
	{
		%>
		<select name=DataEvent tabindex="0" id="DataEvent" style="WIDTH: 0px;display:none;">
		<%
		while(rse.next())
		{
                        if(!rse.getString("SUBEVENTCODE").equalsIgnoreCase(" ")){
			mEventsubevent1=rse.getString("examcode")+"***"+rse.getString("EXAMEVENTCODE").toString().trim()+"#"+rse.getString("SUBEVENTCODE");
			 %>
			<OPTION Value ="<%=mEventsubevent1%>"><%=rse.getString("EXAMEVENTCODE")+"#"+rse.getString("SUBEVENTCODE")%></option>
			<%
                        }else{
                        mEventsubevent1=rse.getString("examcode")+"***"+rse.getString("EXAMEVENTCODE").toString().trim();%>
                        <OPTION Value ="<%=mEventsubevent1%>"><%=rse.getString("EXAMEVENTCODE")%></option>
                        <%}%>

		<%}
		%>
		</select>
		<%
	}
	

	}
	catch(Exception e)
	{
		out.print("error");
	}
	//********************Event Combo************/

	%>



                    &nbsp;&nbsp;<FONT color=black><FONT face=Arial size=2><STRONG>Event-Subevent</STRONG></FONT></FONT>
                    <%
                    try
                    {
                         qry="select distinct a.examcode,a.EXAMEVENTCODE,nvl(b.SUBEVENTCODE,' ') SUBEVENTCODE from exameventmaster a ,examsubeventmaster b where a.EXAMCODE=b.examcode(+) and a.EXAMEVENTCODE=b.EXAMEVENTCODE(+)and sysdate between EVENTfrom and EVENTUPTO"; // out.print(qry);
						//trunc(SYSDATE) >= trunc(fromperiod)   and  trunc(SYSDATE) <= trunc(toperiod)
                        rse=db.getRowset(qry);

                        if (request.getParameter("x")==null)
                        {
                            %>
                            <select name="Event" tabindex="3" id="Event" style="WIDTH: 215px" onclick="ChangeOptions1(Exam.value,Event.value,DataCombo);" onChange="ChangeOptions1(Exam.value,Event.value,DataCombo);">
                            <OPTION selected Value="NONE"><b><-- Select an Event-Subevent --></b></option>
                            <%
                            while(rse.next())
                            {
                                mEventsubevent=rse.getString("EXAMEVENTCODE");
                                %>
                                <OPTION Value ="<%=mEventsubevent%>"><%=mEventsubevent%></option>
                                <%
                            }
                            %>
                            </select>
                            <%
                        }
                        else
                        {
                            %>
                            <select name="Event" tabindex="3" id="Event" style="WIDTH: 215px" onclick="ChangeOptions1(Exam.value,Event.value,DataCombo);" onChange="ChangeOptions1(Exam.value,Event.value,DataCombo);">
                            <OPTION Value="NONE"><b><-- Select an Event-Subevent --></b></option>
                            <%
                            while(rse.next())
                            {
                                mEventsubevent=rse.getString("EXAMEVENTCODE");
                                if(mEventsubevent.equals(request.getParameter("Event")))
                                {
                                    %>
                                    <OPTION selected Value ="<%=mEventsubevent%>"><%=mEventsubevent%></option>
                                    <%
                                }
                                else
                                {
                                    %>
                                    <OPTION Value ="<%=mEventsubevent%>"><%=mEventsubevent%></option>
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
                    </td></tr>
                    <tr><td>

					<%



//******************DataCombo Subject********************/

%>

                   
                     &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                      &nbsp; &nbsp;
                      <INPUT Type="submit" Value="Show/Refresh" >

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
                if(request.getParameter("x")!=null)
                {
                    //out.print("mSelf"+mSelf);
                    if(request.getParameter("Click")!=null && request.getParameter("Subject")!=null && request.getParameter("Event")!=null && request.getParameter("Exam")!=null)
                    {
                		mSelf=request.getParameter("Click");
                		mIC=request.getParameter("InstCode").toString().trim();
                        mEC=request.getParameter("Exam").toString().trim();
                        mSC=request.getParameter("Subject").toString().trim();
                        mList=request.getParameter("listorder").toString().trim();
                        mOrder=request.getParameter("order").toString().trim();
                        mEvent=request.getParameter("Event").toString().trim();

                        session.setAttribute("Click",mSelf);
                        session.setAttribute("InstCode",mIC);
                        session.setAttribute("Exam",mEC);
                        session.setAttribute("Subject",mSC);
                        session.setAttribute("listorder",mList);
                        session.setAttribute("order",mOrder);
                        session.setAttribute("Event",mEvent);
                        len=mEvent.length();
                        pos=mEvent.indexOf("#");


                    }
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