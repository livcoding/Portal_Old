<%-- 
    Document   : Reconverification
    Created on : 11 Mar, 2017, 10:07:58 AM
    Author     : VIVEK.SONI
--%>

<%--
    Document   : ReconDeanApprovalaction
    Created on : 9 Mar, 2017, 10:51:50 AM
    Author     : VIVEK.SONI
--%>

<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page isELIgnored="false" errorPage="../../CommonFiles/ExceptionHandler.jsp" %>


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


function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}


</script>
<style type="text/css">
<!--

input-wrapper input[type=text] {
    width:50%;
    padding: 10px;
    margin: 0px;
}

table .last, td:last-child {
    padding: 2px 24px 2px 0px;
}

-->
</style>





</head>

<body  aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0  onkeydown="if(event.keyCode==13){event.keyCode=9;return event.keyCode}">

<%
GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="",markslocked="",selectedExam="",selectedEvent="",selectedEmp="",selectedInst="",selectedSub="",selectedDBEvent="",selectedname="",selectedcode="";
String mDMemberCode="",mDMemberType="",mDept="",mDesg="", mComp="", minst="", mInst="",mDMemberID="";
String mExam="",mexam="",mExamid="",mEventsubevent="",mSubj="",counter="";
String qry="",qry1="",x="",msubsection="",mPrint="",facqry="";
int msno=0,sno=0;
int len =0;
int pos=0;
String mSE="", mMaxMarks="";
double mWeight=0;
double mvalue=0,mMaxmarks=0,MyMax=0;
int ctr=0,flag=0,rowcnt=0,incno=1;
String mStatus="";
String mIC="",mEC="",mSC="",mList="",mOrder="",mEvent="",mPrevEvent=""; //,mExamsubevent="",mExamevent="";
ResultSet rs=null,rss=null,rs1=null,rs2=null,rs3=null,rse=null,rsm=null,rsmm=null,facrse=null;
String mMOP="",mName5="",mlistorder="",mctr="",qrys="",mSelf="";
String msubeven="",mMarks="",mPerc="",mName1="",mMark="",mName2="",mName3="",msms="",mverified="", DEvent="";
String mEventsubevent1="",mSubj1="",msubj="";
 int loopval=0;
session.setMaxInactiveInterval(10800);
session.setAttribute("Click",mSelf);
 String fromemp="";
  String Dsubject="";

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
            String eqry="Select WEBKIOSK.ShowLink('401','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
            ResultSet ERsChk1= db.getRowset(eqry);
            if (RsChk1.next() && RsChk1.getString("SL").equals("Y") ||ERsChk1.next() && ERsChk1.getString("SL").equals("Y"))
            {

	  //----------------------
                %>
        	<form name="frm" method="get" >
                <input id="y" name="y" type=hidden>


                <%
                
                        




        if(request.getParameter("y")==null){
            selectedExam=request.getParameter("Exam");
            selectedEvent=request.getParameter("selectedEventCode");
            selectedEmp=request.getParameter("Emp");
            selectedInst=request.getParameter("Inst");
            selectedSub=request.getParameter("Subject");
            selectedDBEvent=request.getParameter("DBEventCode");
           

            String selqry="select subjectcode,subject from subjectmaster where institutecode='"+selectedInst+"' and  subjectid='"+selectedSub+"' ";
            ResultSet  selrs2=db.getRowset(selqry);
            if(selrs2.next()){
            Dsubject=selrs2.getString("subject")+"("+selrs2.getString("subjectcode")+")";
            }






            if(session.getAttribute("isemp")==null)
              	fromemp="";
		else
                    fromemp=session.getAttribute("isemp").toString();
            if(request.getParameter("empname")==null)        //="",selectedcode
			selectedname="";
		else
                    selectedname=request.getParameter("empname");
              if(request.getParameter("code")==null)
			selectedcode="";
		else
                    selectedcode=request.getParameter("code");

            }else
                {
             if(request.getParameter("selectedExam")==null)
			selectedExam="";
		else
                    selectedExam=request.getParameter("selectedExam");

                if(request.getParameter("selectedEvent")==null)
			selectedEvent="";
		else
                    selectedEvent=request.getParameter("selectedEvent");
                  if(request.getParameter("selectedEmp")==null)
			selectedEmp="";
		else
                    selectedEmp=request.getParameter("selectedEmp");
                 if(request.getParameter("selectedSub")==null)
			selectedSub="";
		else
                    selectedSub=request.getParameter("selectedSub");

                  if(request.getParameter("selectedInst")==null)
			selectedInst="";
		else
                    selectedInst=request.getParameter("selectedInst");

             

             

            }
        qry="select EMPLOYEEID,EVENTSUBEVENT ,a.studentid,studentname,enrollmentno ,excelmarks ,databasemarks,VERIFIEDMARKS ,remarks " +
             "from MR#MismatchedMarks a,studentmaster b where a.INSTITUTECODE=b.INSTITUTECODE and a.STUDENTID=b.studentid and" +
             " a.INSTITUTECODE ='"+selectedInst+"' and examcode='"+selectedExam+"'  and EVENTSUBEVENT ='"+selectedDBEvent+"'  and subjectid ='"+selectedSub+"' and  " +
             " EMPLOYEEID ='"+selectedEmp+"'  and ForEventSubEvent='"+selectedEvent+"' ";
        
        rs2=db.getRowset(qry);

        %>
       
             
        <table class="sort-table" id="table-1"  width='100%' border=1 cellpadding=0 cellspacing=0 align=center>
            <thead>
                 <% if(!fromemp.equalsIgnoreCase("y")){

                %>
                 <TR><td colspan=8 align=center bgcolor="orange"><font size="4"  ><b>DEAN APPROVAL FORM </font><br><font size="3" color="gray"><%=selectedname%><%=" "%><%=selectedcode%> <%="  "%> <br> <%=Dsubject%></b></font> </td><br>
                </b></font> </TR>
               
                 <tr></TR>
               <%}else{%>
                <TR><td colspan=8 align=center bgcolor="orange"><font size="4"  ><b>RECONCILIATION MISMATCH DETAILS FOR EMPLOYEE </font><br><font size="3" color="gray"><%=selectedname%><%=" "%><%=selectedcode%> <%="  "%> <br> <%=Dsubject%></b></font> </td><br>
                </b></font> </TR>
                 
                 <tr></TR>
                  <%}%>
                <tr bgcolor="yellow">
                    <th>Sr No.</th>
                    <th>For Event</th>
                    <th>Enrollment No</th>
                    <th>Student Name</th>
                    <th>Excel Marks</th>
                    <th>Database Marks</th>
                   <% if(!fromemp.equalsIgnoreCase("y")){%>
                    <th>Verified</th>
                    <th>Remark</th>
                    <%}%>
                </tr>
            </thead>
            <tbody>
                <%
              
                while(rs2.next()){
                 String DBemp=rs2.getString("EMPLOYEEID");
                 String DBEvent=rs2.getString("EVENTSUBEVENT");
                 String StudentId=rs2.getString("STUDENTID");
                 String Exmark=rs2.getString("EXCELMARKS");
                 String DBmarks=rs2.getString("DATABASEMARKS");
                 String Verifiedmarks=rs2.getString("VERIFIEDMARKS");
                 String remark=rs2.getString("REMARKS");
                 String stuname=rs2.getString("studentname");
                 String stuenno=rs2.getString("enrollmentno");
                 if(DBmarks!=null && DBmarks.equalsIgnoreCase("-1")){
                 DBmarks="A";
                 }
                 if(Exmark!=null && Exmark.equalsIgnoreCase("-1")){
                 Exmark="A";
                 }if(remark==null){
                 remark="";
                 }if(Verifiedmarks==null){
                 Verifiedmarks="";
                 }
                 rowcnt++;
                 String tval="txt"+String.valueOf(sno);
                 String rval="rmk"+String.valueOf(sno);
                 ++loopval;
                 %>
                <tr>
                    <td align="center"><%=incno%></td>
                     <%++incno;%>
                    <td  align="center"><%=DBEvent%></td>
                    <input type=hidden name='<%="DBEvent"+String.valueOf(sno)%>' ID='<%="DBEvent"+String.valueOf(sno)%>' value='<%=DBEvent%>'>
                    <input type=hidden name='<%="DBemp"+String.valueOf(sno)%>' ID='<%="DBemp"+String.valueOf(sno)%>'value='<%=DBemp%>'>
                    <input type=hidden name='<%="StudentId"+String.valueOf(sno)%>' ID='<%="StudentId"+String.valueOf(sno)%>'value='<%=StudentId%>'>


                    <td align="center" a><%=stuenno%></td>
                     <input type=hidden name='<%="stuenno"+String.valueOf(sno)%>' ID='<%="stuenno"+String.valueOf(sno)%>'value='<%=stuenno%>'>

                      <input type=hidden name='<%="loopval"%>' ID='<%="loopval"%>'value='<%=loopval%>'>
                      
                    <td align="center" a><%=stuname%></td>
                     <input type=hidden name='<%="stuname"+String.valueOf(sno)%>' ID='<%="stuname"+String.valueOf(sno)%>'value='<%=stuname%>'>
                      <td align="center" a><%=Exmark%></td>
                        <input type=hidden name='<%="Exmark"+String.valueOf(sno)%>' ID='<%="Exmark"+String.valueOf(sno)%>' value='<%=Exmark%>'>
                        <input type=hidden name="sno" ID="sno" value='<%=sno%>'>
                    <td  align="center"><%=DBmarks%></td>
                     <input type=hidden name='<%=DBmarks+String.valueOf(sno)%>' ID='<%=DBmarks+String.valueOf(sno)%>'value='<%=DBmarks%>'>

                     <%if(!fromemp.equalsIgnoreCase("y")){%>


                     <td align="center"><input type="text" style="WIDTH: 200px; HEIGHT: 22px" maxLength=5 NAME="<%=tval%>" id="<%=Verifiedmarks%>"value="<%=Verifiedmarks%>" onkeypress="return isNumber(event)"></td>
                      <td align="center"><input type="text" style="WIDTH: 200px; HEIGHT: 22px" maxLength=50 NAME="<%=rval%>" id="<%=remark%>"value="<%=remark%>"></td>
                    <input type=hidden name="selectedExam" ID="selectedExam" value='<%=selectedExam%>'>
                    <input type=hidden name="selectedEvent" ID="selectedEvent" value='<%=selectedEvent%>'>
                       <input type=hidden name="selectedEmp" ID="selectedEmp" value='<%=selectedEmp%>'>
                    <input type=hidden name="selectedInst" ID="selectedInst" value='<%=selectedInst%>'>
                    <input type=hidden name="selectedSub" ID="selectedSub" value='<%=selectedSub%>'>
                   <input type=hidden name="selectedDBEvent" ID="selectedDBEvent" value='<%=selectedDBEvent%>'>
                       


                      <% }%>
          
                    

                </tr>

                         <% sno++;}
               if(fromemp.equalsIgnoreCase("dean")){%>
               
                   <TR><td colspan=8 align=center>
                           <INPUT Type="submit" name="action" Value="Verified"> &nbsp;&nbsp;&nbsp;
                           <INPUT Type="submit" name="action" Value="Lock">
                       </td></TR>
                <%}else if(fromemp.equalsIgnoreCase("y")){%>
                   
                   <%}%>
                 </tbody>
                 
            </table>
                 &nbsp;&nbsp;
                     
        </form>
                 <table border="0" align="center">

                     <tbody>
                         <tr>
                             <td> <INPUT Type="submit" Value="PRINT" onclick="window.print()">
                                
                             </td>
                         </tr>
                     </tbody>
                 </table>

                  
        <%if(request.getParameter("y")!=null && request.getParameter("action")!=null )
           
        {
            // select hidden variabble for both button

             if(request.getParameter("selectedExam")==null)
			selectedExam="";
		else
                    selectedExam=request.getParameter("selectedExam");

                  if(request.getParameter("selectedDBEvent")==null)
			selectedDBEvent="";
		else
                    selectedDBEvent=request.getParameter("selectedDBEvent");

                if(request.getParameter("selectedEvent")==null)
			selectedEvent="";
		else
                    selectedEvent=request.getParameter("selectedEvent");
                  if(request.getParameter("selectedEmp")==null)
			selectedEmp="";
		else
                    selectedEmp=request.getParameter("selectedEmp");
                 if(request.getParameter("selectedSub")==null)
			selectedSub="";
		else
                    selectedSub=request.getParameter("selectedSub");

                  if(request.getParameter("selectedInst")==null)
			selectedInst="";
		else
                    selectedInst=request.getParameter("selectedInst");
              if(request.getParameter("loopval")==null)
			counter="";
		else
                counter=request.getParameter("loopval");

             // Get Maximum Marks Limit for marks ..............................................
             
              String mqry=" Select   MAXMARKS   from EXAMEVENTSUBJECTTAGGING A," +
                "FacultySubjectTagging B   WHERE   A.FSTID= B.FSTID   AND    B.EMPLOYEEID='"+selectedEmp+"'   AND   B.INSTITUTECODE='"+selectedInst+"'" +
                "  And B.ExamCode='"+selectedExam+"' and B.SubjectID='"+selectedSub+"' and rownum=1";
                double max=0.0;
                ResultSet mrs=db.getRowset(mqry);

                if(mrs.next()){
                max=mrs.getDouble("MAXMARKS");
                }

      // If click button is Varified than function *********************************************************************

            if(request.getParameter("action").equalsIgnoreCase("Verified")){
            String notupdated="";
            String tbemp="",tbevent="",tbsid="",tbmid="",tbrmk="";
         
         
            String snoo=request.getParameter("loopval");
            int size=5000;
            if(!counter.equalsIgnoreCase("")){
            size=Integer.parseInt(counter);
            }
            int loop=Integer.parseInt(snoo);
            for(int i=0;i<=5000;i++)
            {
                String conint="",getemp="";
                 conint=""+String.valueOf(i).trim();
                 getemp="DBemp"+conint;//+conint;
                String getevent="DBEvent"+conint;//+conint;
                 String getSID="StudentId"+conint;//+conint;
                 String getMID="txt"+conint;//+conint;
                 String getRID="rmk"+conint;//+conint;

                 if(request.getParameter(getemp)==null)
			tbemp="";
		else
                    tbemp=request.getParameter(getemp);

                 if(request.getParameter(getevent)==null)
			tbevent="";
		else
                    tbevent=request.getParameter(getevent);

                  if(request.getParameter(getSID)==null)
			tbsid="";
		else
                    tbsid=request.getParameter(getSID);

                  if(request.getParameter(getMID)==null)
			tbmid="";
		else
                    tbmid=request.getParameter(getMID);

                 if(request.getParameter(getRID)==null)
			tbrmk="";
		else
                    tbrmk=request.getParameter(getRID);
                

         if(!tbemp.equalsIgnoreCase("")){

            boolean isalphabetonly=tbmid.matches("[a-zA-Z]+");
            boolean isnumber= tbmid.matches("^[-+]?\\d+(\\.\\d+)?$");
            boolean validmarks=false;
            

            if(isalphabetonly || isnumber){  // check whether number is alphabet or Numeric only
           
               

                if(isnumber){  // if number than numbet should be between range
                double isvalidmarks=Double.parseDouble(tbmid);
                double min=0.0;
               

                if(isvalidmarks>=min && isvalidmarks<=max){
                validmarks=true;
                }
                }else if(isalphabetonly){
                if(tbmid.trim().length()==1){
                validmarks=false;
                }

                }

            }
            if(validmarks){
     qry="update MR#MismatchedMarks set  VERIFIEDMARKS='"+tbmid+"' ,VERIFIEDBYBY='"+mDMemberCode+"' ,VERIFIEDDATE =sysdate ,REMARKS ='"+tbrmk+"' " +
     "where INSTITUTECODE ='"+selectedInst+"' and examcode='"+selectedExam+"' and EVENTSUBEVENT ='"+tbevent+"' and subjectid ='"+selectedSub+"' and  " +
     " EMPLOYEEID ='"+tbemp+"' and ForEventSubEvent='"+selectedEvent+"' and studentid='"+tbsid+"'";
                db.update(qry);
             //   out.println("oooooooooo"+qry);
                int Upd=db.update(qry);
                if(Upd<0){
              //   notupdated=tbemp+"--"+tbmid;
                }
            }else{
                 notupdated=tbemp+"--"+tbmid;
                }
   }
                 
                 
   else{ // If no Row found than Exit from loop
   break;
   }
                 
            } // end of for loop
            String sms="Record Verified Successfully..............";
         response.sendRedirect("Reconverificationaction.jsp?action="+sms);
            // List of Not Updated Record..............
       if(!notupdated.equalsIgnoreCase("")){
         sms="Record Not Submitted ..............";
         response.sendRedirect("Reconverificationaction.jsp?action="+sms);
   %>
      
     <%  }
  }//End of Verified Button

      //******************* IF Click on Locked Button **********************************************

  else if(request.getParameter("action").equalsIgnoreCase("Lock")){

  String First="select studentid from MR#mismatchedmarks where Institutecode='"+selectedInst+"' and  examcode='"+selectedExam+"' and subjectid='"+selectedSub+"'" +
  " and employeeid='"+selectedEmp+"' and VERIFIEDMARKS not between 0  and "+max+" " ;

  ResultSet frs=db.getRowset(First);

  if(frs.next()){%>

 <font color="red" size="3"><b>Please Update the All records than Proceed Lock ...></b>              </font>
 
 <% }else
{
  /* String second="update studenteventsubjectmarks c set marksawarded1=(select d.verifiedmarks from MR#mismatchedmarks d where d.Institutecode='"+selectedInst+"' and " +
  "  d.eventsubevent= x.eventsubevent and d.studentid=x.studentid and d.fstid=x.fstid  and d.examcode='"+selectedExam+"' and d.subjectid='"+selectedSub+"'  " +
  " and d.employeeid='"+selectedEmp+"') ,marksawarded2=(select d.verifiedmarks from MR#mismatchedmarks d where d.Institutecode='"+selectedInst+"' and d.eventsubevent= x.eventsubevent" +
  " and d.studentid=x.studentid and d.fstid=x.fstid  and d.examcode='"+selectedExam+"' and d.subjectid='"+selectedSub+"'  and d.employeeid='"+selectedEmp+"') " +
  ",LastUpdateddate =sysdate ,LastUpdatedby ='"+mMemberCode+"' where " +
  " fstid in (select fstid from facultysubjecttagging a,MR#mismatchedmarks b  where a.Institutecode=b.Institutecode and a.EXAMCODE=b.EXAMCODE and " +
  " a.subjectid = b.subjectid and a.employeeid= b.employeeid and  c.eventsubevent= b.eventsubevent and c.studentid=b.studentid " +
  " and a.Institutecode='"+selectedInst+"' and a.examcode='"+selectedExam+"' and a.subjectid='"+selectedSub+"'" +
  " and a.employeeid='"+selectedEmp+"' ) ";*/
  String second= " update studenteventsubjectmarks x set  ( x.marksawarded1,x.marksawarded2)=(select d.verifiedmarks ,d.verifiedmarks from MR#mismatchedmarks d" +
  " where d.Institutecode='"+selectedInst+"' and d.eventsubevent= x.eventsubevent and d.studentid=x.studentid   and d.examcode='"+selectedExam+"' and " +
  " d.subjectid='"+selectedSub+"'  and d.employeeid='"+selectedEmp+"' and d.foreventsubevent = '"+selectedEvent+"' ) , lastupdateddate= sysdate ,lastupdatedby ='"+mMemberCode+"' where x.fstid in (select fstid from facultysubjecttagging a,MR#mismatchedmarks b" +
  " where a.Institutecode= b.Institutecode and a.examcode='"+selectedExam+"' and a.subjectid='"+selectedSub+"'  and a.employeeid='"+selectedEmp+"' and foreventsubevent='"+selectedEvent+"' and a.EXAMCODE=b.EXAMCODE and " +
  " a.subjectid = b.subjectid and a.employeeid= b.employeeid and  x.eventsubevent= b.eventsubevent and x.studentid=b.studentid ) and eventsubevent= '"+selectedDBEvent+"' ";
 
   int isupdate=db.update(second);
   if(isupdate>0){
    String Thired="update MR#RECONCILEDDETAIL SET reconciled ='V',reconcileddate=sysdate,reconciledby='"+mDMemberCode+"' where  Institutecode='"+selectedInst+"' and examcode='"+selectedExam+"' and subjectid='"+selectedSub+"'" +
  " and employeeid='"+selectedEmp+"' and eventsubevent='"+selectedDBEvent+"' and foreventsubevent='"+selectedEvent+"' ";

     int isupda=db.update(Thired);
     

     if(isupda>0){
     String sms="Record Lock Successfully..............";
         response.sendRedirect("Reconverificationaction.jsp?action="+sms);
     }else{
     String sms="Record Not Locked ..........";
    response.sendRedirect("Reconverificationaction.jsp?action="+sms);
     }
   }
}
  }
}//End of Hidden Variable Y If
%>
           
           <%  }
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