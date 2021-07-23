<%-- 
    Document   : FeesHeadWise
    Created on : 11 Feb, 2020, 4:39:39 PM
    Author     : VIVEK.SONI
--%>
<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.*" %>
<!-- Modified Date 16-06-2020 -->



<%
String mHead="",mInstCode ="";
String mCandCode="", MName="";
String mCandName="";
String URL="";

if(session.getAttribute("PageHeadinjg")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
              
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>

<TITLE>#### <%=mHead%> [ Student Fee Head Wise] </TITLE>


<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

<script language=javascript>

	function RefreshContents()
	{
    	    document.frm.x.value='ddd';
    	    document.frm.submit();
	}
//-->
</SCRIPT>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<script type="text/javascript">
    $(function () {
        $("input[name='cradio']").click(function () {
            if ($("#grp1").is(":checked")) {
                $("#acdyear").removeAttr("disabled");
                $("#programe").removeAttr("disabled");
                $("#SECTIONBRANCH").removeAttr("disabled");
               
                $("#enno").attr("disabled", "disabled");
                 document.getElementById('enno').value = ''
               
            }else {
                $("#acdyear").attr("disabled", "disabled");
                $("#programe").attr("disabled", "disabled");
                $("#SECTIONBRANCH").attr("disabled", "disabled");
                document.getElementById("acdyear").selectedIndex=-1;
                document.getElementById("programe").selectedIndex=-1;
                document.getElementById("SECTIONBRANCH").selectedIndex=-1;
                 //$("option:programe").prop("selected", false)
                // $("#programe").val('');
                // $("#SECTIONBRANCH").val('');
                $("#enno").removeAttr("disabled");
                $("#enno").focus();
               // document.getElementById('gno').value = ''

            }
        });
     
    });
   
  
</script>

<script>
function myFunction() {
  var x = document.getElementById("feehead").value;
  const words = x.split('==');
   //const str = 'Thequick***brown';
 document.getElementById("demo").innerHTML =  words[1];
 document.getElementById("feerate").innerHTML =  words[1];
 document.getElementById("feerate").value =  words[1];
 document.getElementById("x").value =  words[1];

<%--console.log(words[1]);
  alert(x) ;--%>
}
</script>

<script>
function validateform(){

//alert();
//var head=document.frm.feehead.value;
var headdate=document.frm.date.value;
var tamt=document.frm.txtamount.value;

if (document.frm.feehead.selectedIndex==""){
  alert("Please select the Fee Head Type");
  return false;
}else if(headdate==null||headdate.length<10){
  alert("Please Enter the date in DD-MM-YYYY Format");
  return false;
  }else if(tamt==null||tamt.length<1){
  alert("Please Enter Amount");
  return false;
  }
}
</script>

<body aLink=#ff00ff bgcolor="#fce9c5" rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
//GlobalFunctions gb =new GlobalFunctions();

DBHandler db=new DBHandler();
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="",mDept="",mDesg="",mInst="",minst="",mDMemberID="";
String qry="",qry1="",qrys="", mEnOrNm="", x="",cInst="",mCheck="",qryi="";
String mStudentId="",mAcademicYear="",mProgramcode="",mEnrollmentno="",mBranchcode="",mEnrollMentNo="";
int msno=0;
ResultSet rs=null,rs1=null,rss=null;
String FeeDesc="",Feehead="",amount="";

//ArrayList<String> list=new ArrayList<String>();
int ctr=0,count=0;
String mName1="",mName2="",mName3="",mName4="",mName5="",mName6="";
if (session.getAttribute("Designation")==null)
{
	mDesg="";
}
else
{
	mDesg=session.getAttribute("Designation").toString().trim();
}

if (session.getAttribute("Department")==null)
{
	mDept="";
}
else
{
	mDept=session.getAttribute("Department").toString().trim();
}
if (session.getAttribute("MemberID")==null)
{
	mMemberID="";
}
else
{
	mMemberID=session.getAttribute("MemberID").toString().trim();
}

if (session.getAttribute("MemberType")==null)
{
	mMemberType="";
}
else
{
	mMemberType=session.getAttribute("MemberType").toString().trim();
}

if (session.getAttribute("MemberName")==null)
{
	mMemberName="";
}
else
{
	mMemberName=session.getAttribute("MemberName").toString().trim();
}

if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
}

if (session.getAttribute("InstituteCode")==null)
{
	mInstCode ="JIIT";
}
else
{
	mInstCode =session.getAttribute("InstituteCode").toString().trim();
}

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
		qry="Select WEBKIOSK.ShowLink('415','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      	RsChk1= db.getRowset(qry);
		if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
		   {
                    %>
                    <form name="frm" method="get" onsubmit="return validateform()">
                        <br><br>
                        <div align="center">
                            <b>  <font color="red">Fees  Collection Fee Head-Wise </font></b> 
                        </div>
                        <br>
                         <input id="x" name="x" type=hidden>
                          <input id="feerate" name="feerate" value=""  type=hidden>
                         <table width="60%"  border=1  rules=none align="center"  topmargin=0 cellspacing=5 cellpadding=5  borderColor="#D98242" >  <%--rules=none align=center   topmargin=0 cellspacing=5 cellpadding=5 --%>

                            <tr>
                                <td width="25%">
                                    <b>  Fees Head</b>
                                </td>
                                <td width="25%">
                                  <%  qry="select FEEHEADS,HEADDESC,RATE from NA#FeeHeads  Where InstituteCode='"+mInstCode+"' and nvl(Deactive,'N')='N' ";
                    rs=db.getRowset(qry);
                    if (request.getParameter("x")==null)
                    {
                        %>
                        <select name=feehead tabindex="1" id="feehead" style="WIDTH: 200px" onchange="myFunction()"> >
                               <OPTION selected value=""></option>
                        <%
                        int cnter=0;
                        while(rs.next())
                        {
                            FeeDesc=rs.getString("HEADDESC");
                            if(cnter==0){

                            }

                            String FeeDesc1=rs.getString("FEEHEADS")+"=="+rs.getString("RATE");
                           
                            %>
                            <OPTION value="<%=FeeDesc1%>"><%=FeeDesc%></option>
                            <%
                        }
                     }else{
                            %>
                              <select name=feehead tabindex="1" id="feehead" style="WIDTH: 200px"  >
                           
                            <%
                            while(rs.next())
                            {
                                FeeDesc=rs.getString("HEADDESC");
                                 String FeeDesc2=rs.getString("FEEHEADS");
                                String FeeDesc1=rs.getString("FEEHEADS")+"=="+rs.getString("RATE");
                                String temp=request.getParameter("feehead").toString().trim();
                                String [] arrSplit=temp.split("==");
                                String val=arrSplit[0];
                                if(FeeDesc1.equals(request.getParameter("feehead").toString().trim()))
                                {
                                    %>
                                    
                                     <OPTION selected Value ="<%=FeeDesc1%>"><%=FeeDesc%></option>
                                    <%
                                }
                                else
                                {
                                    %>
                                   <OPTION value="<%=FeeDesc1%>"><%=FeeDesc%></option>
                                    <%
                                }
                            }
                     }
                            %>
                        %>
                        </select>
                                </td>
                                <td width="25%" align="center">
                               <b> Amount</b>
                                </td>
                                <td width="25%">
                                <%
                                String rrate="";
                                if (request.getParameter("x")==null)
                                {%>
                                <input type="text" name="txtamount" id="txtamount">
                              <% }else {
                                if (request.getParameter("txtamount")==null){%>
                                 <input type="text" id="txtamount" name="txtamount">
                                <%}else{

                               if(request.getParameter("txtamount")!=null){

                               rrate=request.getParameter("txtamount").toString();
                               }

                                %>
                                <input type="text" name="txtamount" id="txtamount" value="<%=rrate%>">
                               <%}}%>
                                </td>
                            </tr>
                            <tr>
                                <td>
                              <b> Date</b>
                                </td>

                                <td>
                                    <%
                                     if (request.getParameter("x")==null)
                                  {
                                    %>
                                <input type="text" id="date" name="date">
                                <%}else{
                                if (request.getParameter("date")==null){%>
                                 <input type="text" id="date" name="date">
                                <%}else{
                                    String date=request.getParameter("date").toString();
                                %>
                                <input type="text" id="date" name="date" value="<%=date%>">
                                <%}
                                }%>

                                </td>
                                <td> </td><td> </td>

                            </tr>

                        </table>
                        <table width="60%"  border=1  rules=none align=center   topmargin=0 cellspacing=5 cellpadding=5 borderColor="#D98242" >
                            <tr>
                                <td>
                                    <input type="radio" name="cradio" value="grp1" id="grp1" >
                                </td>
                                <td>
                                    <b>Academic</b>
                                </td>
                                <td>
                                <%  qry="select distinct ACADEMICYEAR  from STUDENTREGISTRATION   where INSTITUTECODE='"+mInstCode+"' order by ACADEMICYEAR  ";
                    rs=db.getRowset(qry);
                    if (request.getParameter("x")==null)
                    {
                        %>
                        <select name=acdyear tabindex="1" id="acdyear" style="WIDTH: 60px" disabled>
                        <OPTION selected=""> </option>
                        <%
                        while(rs.next())
                        {
                           String acdyear=rs.getString("ACADEMICYEAR");

                            %>
                            
                            <OPTION <%=acdyear%>><%=acdyear%></option>
                            <%
                        }
                     }else{
                            %>
                              <select name=acdyear tabindex="1" id="acdyear" style="WIDTH: 200px" disabled  >
                            <%
                             if(request.getParameter("acdyear")==null){%>
                                  <OPTION selected Value =""></option>
                          <%       }
                            while(rs.next())
                            {
                                String acdyear=rs.getString("ACADEMICYEAR");

                                if(request.getParameter("acdyear")!=null){


                                if(acdyear.equals(request.getParameter("acdyear").toString().trim()))
                                {
                                    %>

                                     <OPTION selected Value ="<%=acdyear%>"><%=acdyear%></option>
                                    <%
                                }
                                else
                                {
                                    %>
                                   <OPTION value="<%=acdyear%>"><%=acdyear%></option>
                                    <%
                                }
                                }else{%>
                                     <OPTION selected Value =""></option>
                                 <OPTION value="<%=acdyear%>"><%=acdyear%></option>
                          <%      }
                            }
                     }
                            %>
                        %>
                        </select>
                                </td>
                                <td>
                                    <b>Program</b>
                                </td>
                                <td>
                                <%  qry="select distinct PROGRAMCODE from STUDENTREGISTRATION     where INSTITUTECODE='"+mInstCode+"' order by PROGRAMCODE ";
                    rs=db.getRowset(qry);
                    if (request.getParameter("x")==null)
                    {
                        %>
                        <select name=programe tabindex="2" id="programe" style="WIDTH: 100px" disabled>
                            <OPTION selected=""> </option>
                        <%
                        while(rs.next())
                        {
                           String PROGRAMCODE=rs.getString("PROGRAMCODE");

                            %>
                            <OPTION <%=PROGRAMCODE%>><%=PROGRAMCODE%></option>
                            <%
                        }
                     }else{
                            %>
                              <select name=programe tabindex="2" id="programe" style="WIDTH: 100px" disabled >
                            <%
                             if(request.getParameter("programe")==null){%>
                                  <OPTION selected Value =""></option>
                          <%       }
                            while(rs.next())
                            {
                                String PROGRAMCODE=rs.getString("PROGRAMCODE");

                                if(request.getParameter("programe")!=null){
                                if(PROGRAMCODE.equals(request.getParameter("programe").toString().trim()))
                                {
                                    %>

                                     <OPTION selected Value ="<%=PROGRAMCODE%>"><%=PROGRAMCODE%></option>
                                    <%
                                }
                                else
                                {
                                    %>
                                   <OPTION value="<%=PROGRAMCODE%>"><%=PROGRAMCODE%></option>
                                    <%
                                }
                            }else{%>
                                     <OPTION selected Value =""></option>
                                 <OPTION value="<%=PROGRAMCODE%>"><%=PROGRAMCODE%></option>
                          <%      }
                            }
                     }
                            %>
                        %>
                        </select>
                                </td>
                                <td>
                                    <b>Branch</b>
                                </td>
                                <td>
                                <%  qry="select distinct  SECTIONBRANCH from STUDENTREGISTRATION   where INSTITUTECODE='"+mInstCode+"' order by SECTIONBRANCH ";
                    rs=db.getRowset(qry);
                    if (request.getParameter("x")==null)
                    {
                        %>
                        <select name=SECTIONBRANCH tabindex="3" id="SECTIONBRANCH" style="WIDTH: 100px" disabled>
                            <OPTION selected value=""> </option>
                        <%
                        while(rs.next())
                        {
                           String SECTIONBRANCH=rs.getString("SECTIONBRANCH");

                            %>
                            <OPTION <%=SECTIONBRANCH%>><%=SECTIONBRANCH%></option>
                            <%
                        }
                     }else{
                            %>
                              <select name=SECTIONBRANCH tabindex="1" id="SECTIONBRANCH" style="WIDTH: 100px" disabled >

                            <%
                             if(request.getParameter("SECTIONBRANCH")==null){%>
                                  <OPTION selected Value =""></option>
                          <%       }
                            while(rs.next())
                            {
                                String SECTIONBRANCH=rs.getString("SECTIONBRANCH");

                                 if(request.getParameter("SECTIONBRANCH")!=null){

                                if(SECTIONBRANCH.equals(request.getParameter("SECTIONBRANCH").toString().trim()))
                                {
                                    %>

                                     <OPTION selected Value ="<%=SECTIONBRANCH%>"><%=SECTIONBRANCH%></option>
                                    <%
                                }
                                else
                                {
                                    %>
                                   <OPTION value="<%=SECTIONBRANCH%>"><%=SECTIONBRANCH%></option>
                                    <%
                                }
                            }
                                else{%>
                                    
                                 <OPTION value="<%=SECTIONBRANCH%>"><%=SECTIONBRANCH%></option>
                          <%      }
                            }
                     }
                            %>
                        %>
                        </select>
                    
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="radio"  name="cradio" value="grp2" id="grp2">
                                </td>
                                <td >
                                <b>Enrollment No</b>
                                </td>
                                <td colspan="5">
                                    <input type="text" align="left" name="enno" id="enno" disabled>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="7" align="center">
                                   <%  if(request.getParameter("x")==null){%>
                                    <input type="submit" value="Submit">
                                  <%  }%>
                                </td>
                            </tr>

                        </table>

                      </form>
                                <form action="FeeHeadwiseAction.jsp">


                        <%
                         if (request.getParameter("x")!=null){%>
                         <table width="60%" align="center" border="1" cellpadding="2" cellspacing="2">
                             <tr bgcolor="yellow">
                                 <td align="center"><B>Sr. No.</B> </td>
                             <td align="center"><B>Enrollment No </B></td>
                             <td align="center"> <B>Name</B> </td>
                             <td align="center"><B>Academic-Year</B> </td>
                             <td align="center"><B>Program </B></td>
                             <td align="center"><B>Branch</B> </td>
                            
                             </tr>

                             <%
                             String selection="",feehead="",date="";
                             if(request.getParameter("cradio")!=null){
                              selection=request.getParameter("cradio").toString();
                             }else{
                             
                             }
                              if(request.getParameter("feehead")!=null){

                                String temp=request.getParameter("feehead").toString().trim();
                                String [] arrSplit=temp.split("==");
                                feehead=arrSplit[0];
                             }
                             if(request.getParameter("date")!=null){

                                date=request.getParameter("date").toString().trim();

                             }

                             if(selection.equalsIgnoreCase("")){
                                 String qrra="select  A.STUDENTNAME,A.ENROLLMENTNO,A.ACADEMICYEAR,A.PROGRAMCODE,A.BRANCHCODE   from studentmaster A ,NA#STUDENTFeedetail B where B.FEEHEADS='"+feehead+"' and" +
                                         " A.STUDENTID=B.STUDENTID and B.INSTITUTECODE='"+mInstCode+"' and  to_char(B.FEEHEADDATE,'dd-mm-yyyy')='"+date+"' order by  A.STUDENTNAME";
                                  rs=db.getRowset(qrra);
                                  int ctra=0;
                                  while(rs.next()){
                                        ctra++;
                                      String enroll=rs.getString("ENROLLMENTNO");
                                      String name=rs.getString("STUDENTNAME");
                                      String acadmic=rs.getString("ACADEMICYEAR");
                                      String prog=rs.getString("PROGRAMCODE");
                                      String brnch=rs.getString("BRANCHCODE");
                                      String chkval=ctra+"-"+enroll+"-"+name+"-"+acadmic +"-"+prog+"-"+brnch;
                                %>

                                  <tr>
                                      <td> <%=ctra%> </td>
                                      <td> <%=enroll%> </td>
                                      <td> <%=name%> </td>
                                      <td> <%=acadmic%> </td>
                                      <td> <%=prog%> </td>
                                      <td> <%=brnch%> </td>
                                     

                                  </tr>


                              <%    }
                                  if(ctra==0){%>
                                  <tr>
                                      <td colspan="6"><font color="red"> No Data Found.... </font> </td>
                                  </tr>
                                <%  }

                             }
                             //--- if user select Enrollment no wise or other craeteria than 
                             else  if(selection!=null && selection.equalsIgnoreCase("grp2")){
                                String mstdid="",macdyear="",mprogcode="",mbranch="",mname="",mamt="",mfeehead="",menno="";

                                  if(request.getParameter("enno")!=null){

                                  if(request.getParameter("txtamount")!=null){
                                  mamt=request.getParameter("txtamount").toString();
                                  session.setAttribute("txtamount", mamt);
                                  }
                                  String adate="";
                                  if(request.getParameter("date")!=null){
                                  adate=request.getParameter("date").toString().trim();
                                 // session.setAttribute("feedate", adate);
                                  }
                                  String enno=request.getParameter("enno").toString().trim();
                                  String qrr="select STUDENTID, STUDENTNAME,ENROLLMENTNO,ACADEMICYEAR,PROGRAMCODE,BRANCHCODE   from studentmaster where INSTITUTECODE='"+mInstCode+"' and  ENROLLMENTNO='"+enno+"'";
                                  rs=db.getRowset(qrr);
                                  
                                  String temp=request.getParameter("feehead").toString().trim();
                                  String [] arrSplit=temp.split("==");
                                  mfeehead=arrSplit[0];
                                 // session.setAttribute("feehead", mfeehead);
                                  if(rs.next()){
                                      
                                    mstdid=  rs.getString("STUDENTID");
                                    macdyear=  rs.getString("ACADEMICYEAR");
                                    mprogcode=  rs.getString("PROGRAMCODE");
                                    mbranch=  rs.getString("BRANCHCODE");
                                    mname=  rs.getString("STUDENTNAME");
                                    menno=  rs.getString("ENROLLMENTNO");

                                   String ckkqry="select * from NA#STUDENTFeedetail where STUDENTID='"+mstdid+"' and FEEHEADS='"+mfeehead+"' and trunc( FEEHEADDATE)=( TO_DATE('"+adate+"','DD-MM-YYYY')) ";
                                   rs=db.getRowset(ckkqry);
                                   if(!rs.next()){
                                   qry="INSERT INTO NA#STUDENTFeedetail(INSTITUTECODE, FEEHEADS, FEEHEADDATE,REGCODE,STUDENTID,FEEHEADRATE,FEEHEADQTY,AMOUNT,ENTRYBY,ENTRYDATE,DEACTIVE,LASTUPDATE) " +
                                           "VALUES('"+mInstCode+"','"+mfeehead+"', to_date('"+adate+"','dd-mm-yyyy'),'REGCODE','"+mstdid+"','"+mamt+"','1','"+mamt+"','"+mMemberName+"',sysdate,'N',sysdate)";
                                        System.out.println(qry);
                                   int n=db.insertRow(qry);
                                   if(n>0){
                                       
                                       String qrre="select  A.STUDENTNAME,A.ENROLLMENTNO,A.ACADEMICYEAR,A.PROGRAMCODE,A.BRANCHCODE   from studentmaster A ,NA#STUDENTFeedetail B where B.FEEHEADS='"+feehead+"' and" +
                                         " A.STUDENTID=B.STUDENTID and B.INSTITUTECODE='"+mInstCode+"' and  to_char(B.FEEHEADDATE,'dd-mm-yyyy')='"+adate+"' order by  A.STUDENTNAME";
                                  rs=db.getRowset(qrre);
                                  int ctra=0;
                                  while(rs.next()){
                                        ctra++;
                                      String enroll=rs.getString("ENROLLMENTNO");
                                      String name=rs.getString("STUDENTNAME");
                                      String acadmic=rs.getString("ACADEMICYEAR");
                                      String prog=rs.getString("PROGRAMCODE");
                                      String brnch=rs.getString("BRANCHCODE");
                                      String chkval=ctra+"-"+enroll;
                                %>

                                  <tr>
                                      <td> <%=ctra%> </td>
                                      <td> <%=enroll%> </td>
                                      <td> <%=name%> </td>
                                      <td> <%=acadmic%> </td>
                                      <td> <%=prog%> </td>
                                      <td> <%=brnch%> </td>
                                      <td> <input type="checkbox" id="<%=ctra%>" name="<%=ctra%>" value="<%=chkval%>" checked> </td>

                                  </tr>
                                 
                                <%      }
                                     }

                                    }else{%>
                                    <tr>  <td colspan="7" align="center"><font color="red"><b> Entry already exist with selected parameter</b></font></td> </tr>
                                  <%}

                                  }else{  // check  if enrollment no exist in studentmaster %>
                                       <tr>  <td colspan="7" align="center"><font color="red"><b> Please Enter Valid Enrollment No.</b></font></td> </tr>
                                
                                <%  }

                                  }else{%>
                                        <tr>  <td colspan="7" align="center"><font color="red"><b>  Enrollment No. can't ba blank</b></font></td> </tr>
                                 <% }%>
                                

                           <%  }else  if(selection!=null && selection.equalsIgnoreCase("grp1")){
                               
                               String mstdid="",macdyear="",mprogcode="",mbranch="",mname="",mamt="200",mfeehead="",menno="",mracdyear="",mrpgcode="",mrbranch="";

                               if(request.getParameter("acdyear")!=null){
                                      mracdyear=request.getParameter("acdyear").toString();
                                }
                               if(request.getParameter("programe")!=null){
                                      mrpgcode=request.getParameter("programe").toString();
                                }
                               if(request.getParameter("SECTIONBRANCH")!=null){
                                      mrbranch=request.getParameter("SECTIONBRANCH").toString();
                                }
                               String adate="";
                                if(request.getParameter("date")!=null){
                                  adate=request.getParameter("date").toString().trim();
                                  session.setAttribute("feedate", adate);
                                  }


                             if(session.getAttribute("feerate")!=null){
                                  mamt=session.getAttribute("feerate").toString().trim();
                              }
                             if(session.getAttribute("feehead")!=null){
                                  mfeehead=session.getAttribute("feehead").toString().trim();
                              }

                                  String temp=request.getParameter("feehead").toString().trim();
                                  String [] arrSplit=temp.split("==");
                                  mfeehead=arrSplit[0];
                                  String qrr="select STUDENTID, STUDENTNAME,ENROLLMENTNO,ACADEMICYEAR,PROGRAMCODE,BRANCHCODE   from studentmaster A where INSTITUTECODE='"+mInstCode+"' and  ACADEMICYEAR='"+mracdyear+"' and PROGRAMCODE='"+mrpgcode+"'   and BRANCHCODE='"+mrbranch+"' and nvl(deactive,'N')='N' and not exists (select 'y' From NA#STUDENTFeedetail B where A.studentid=B.studentid and B.FEEHEADS='"+mfeehead+"' and  to_char(B.FEEHEADDATE,'dd-mm-yyyy') ='"+adate+"') order by STUDENTNAME ";
                                  rs=db.getRowset(qrr);
                                  System.out.println(qrr);

                                
                                  int ctra=0;
                                  session.setAttribute("feehead", mfeehead);
                                  if(request.getParameter("feerate")!=null){
                                  mamt=request.getParameter("feerate").toString();
                                  session.setAttribute("feerate", mamt);
                                  }

                                  while(rs.next()){
                                        ctra++;

                                    mstdid=  rs.getString("STUDENTID");
                                    macdyear=  rs.getString("ACADEMICYEAR");
                                    mprogcode=  rs.getString("PROGRAMCODE");
                                    mbranch=  rs.getString("BRANCHCODE");
                                    mname=  rs.getString("STUDENTNAME");
                                    menno=  rs.getString("ENROLLMENTNO");

                                    String chkval=ctra+"-"+menno;
                                    %>
                                   <tr>
                                      <td> <%=ctra%> </td>
                                      <td> <%=menno%> </td>
                                      <td> <%=mname%> </td>
                                      <td> <%=macdyear%> </td>
                                      <td> <%=mprogcode%> </td>
                                      <td> <%=mbranch%> </td>
                                      <td> <input type="checkbox" id="<%=ctra%>" name="<%=ctra%>" value="<%=chkval%>" checked> </td>

                                  </tr>
                              <%                                      }
                              %>
                              
                              <tr>
                                  <td colspan="7" align="center">
                                     <input type="submit" value="save">
                                 </td>
                             </tr>

                            <% }
                             %>

                         </table>
                             <p align="center">  <a href="https://webkiosk.jiit.ac.in/EmployeeFiles/ERPNonAcdmicFee/FeesHeadWise.jsp">Reset</a></p>

                             
</form>
                             


                         <%}
                        %>
   
<%
  } 
  else
   {
   %>
	<br>
	<font color=red>
	<h3>	<br><img src='../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team.
	</font>	<br>	<br>	<br>	<br>
   <%


   }
  //-----------------------------




}
else
{
	out.print("<br><img src='Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp'>Login</a> to continue</font> <br>");
}

%>
</form>
</body>
</html>
