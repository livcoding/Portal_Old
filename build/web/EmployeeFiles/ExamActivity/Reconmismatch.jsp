<%-- 
    Document   : Reconmismatch
    Created on : 17 Mar, 2017, 11:32:11 AM
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


</script>



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
String mEventsubevent1="",mSubj1="",msubj="",fromemp="";
session.setMaxInactiveInterval(10800);
session.setAttribute("Click",mSelf);



 if(session.getAttribute("isemp")==null)
			fromemp="";
		else
                    fromemp=session.getAttribute("isemp").toString();
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
                <br>
        	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <FONT color=RED><FONT face=Arial size=4><b><STRONG>Reconciliation Mismatch Details</STRONG></b></FONT></FONT>
                <%
                
                    //out.print("mSelf"+mSelf);
                   

                        String selectedExam=request.getParameter("Exam");
                        String selectedEvent=request.getParameter("EventSubevent");
                        String selectedsub=request.getParameter("Subject").toString();
                         String selectedem=request.getParameter("empid").toString();

                       // String selectedInst=request.getParameter("InstCode").toString();
                        //String selectedsubject=request.getParameter("Exam");

        qry="select a.EventSubevent ,a.EMPLOYEEID,b.EmployeeCode,b.EmployeeName,a.FileName ,a.Reconciled from MR#ReconciledDetail a , v#staff b where a.Employeeid=b.Employeeid and INSTITUTECODE = '"+mInst+"' " +
                "and a.ExamCode= '"+selectedExam+"'  and a.ForEventSubEvent='"+selectedEvent+"' and   a.EMPLOYEEID in ("+selectedem+")" +
                " and a.subjectid='"+selectedsub+"' and nvl(a.Reconciled,'')in('M','F','V')";
        rs2=db.getRowset(qry);
        session.setAttribute("isemp", "y");
        %>
        <form>
        <table  bordercolor="#a52a2a" border="1" align="center" cellspacing="0"  cellpadding="0" width="72%">
            <thead>
                <tr bgcolor="yellow">
                    <th>Event</th>
                    <th>Faculty Code</th>
                    <th>Faculty Name</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                int sno=0;
                while(rs2.next()){
                 String DBEvent=rs2.getString("EVENTSUBEVENT");
                 String DBemp=rs2.getString("EMPLOYEEID");
                 String DBempcode=rs2.getString("EMPLOYEECODE");
                 String DBempname=rs2.getString("EMPLOYEENAME");
                 String stat=rs2.getString("RECONCILED");
                 sno++;
                 String tval="remarks"+String.valueOf(sno);
                 %>
                <tr>
                    <td align="center"><%=DBEvent%></td>
                    <td  align="center"><%=DBempcode%></td>
                    <td  align="center"><%=DBempname%></td>
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
                 <!--   <td align="center" a><mverified%></td>-->

                    <%
                   if(stat.equalsIgnoreCase("v"))
                    {
                        msms="";
                    }else  if(stat.equalsIgnoreCase("M")){
                     msms="Show Mismatch Data";
                    }else  if(stat.equalsIgnoreCase("F")){
                     msms="File not Found";
                    }
                    %>
                 

                    <%if(!stat.equalsIgnoreCase("F")){%>
                    <td align="center" ><A href="Reconverification.jsp?Inst=<%=mInst%>&DBEventCode=<%=DBEvent%>&Emp=<%=DBemp%>&Status=<%=stat%>&textval=<%=tval%>&Exam=<%=selectedExam%>&Subject=<%=selectedsub%>&selectedEventCode=<%=selectedEvent%>&empname=<%=DBempname%>&code=<%=DBempcode%>"target=_new"  alt="Click here to view on line for details"><font size=3><b><%=msms%></b></font></A></td>
                    <%}else{%>
                    <%   if(fromemp.equalsIgnoreCase("dean")){%>
                        <td align="center" ><input type="submit" id="submit" value="File Not Found" ></td>
                        
                    <%}else{%>
                     <td align="center" a><%=mverified%></td>
                    <%}%>
                </tr>

                         <% } }%>
                 </tbody>
            </table>
        </form>
            <%  
         
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