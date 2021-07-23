<%-- 
    Document   : FeeHeadwiseAction
    Created on : 18 Feb, 2020, 10:14:20 AM
    Author     : VIVEK.SONI
--%>

<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.*" %>
<!-- Modified Date 16-06-2020 -->



<%
String mHead="",mInstCode ="";
String mCandCode="", MName="";
String mCandName="";
String URL="";

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
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
}%>
<br>
<p align="center"><font color="blue" size="5"><b>Student List </b></font></p>

<br>

    <%
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

                     Enumeration<String> param = request.getParameterNames();
                             String adate="";
                              String mstdid="",macdyear="",mprogcode="",mbranch="",mname="",mamt="",mfeehead="",menno="";
                             if(session.getAttribute("feedate")!=null){
                                  adate=session.getAttribute("feedate").toString().trim();
                              }
                             if(session.getAttribute("txtamount")!=null){
                                  mamt=session.getAttribute("txtamount").toString().trim();
                              }
                             if(session.getAttribute("feehead")!=null){
                                  mfeehead=session.getAttribute("feehead").toString().trim();
                              }

                            while (param.hasMoreElements())
                            {
                                String key = param.nextElement();
                                String value = request.getParameter(key);//hangs here
                                String [] arrSplit=value.split("-");
                                String enrollno=arrSplit[1];

                                 String qrr="select STUDENTID, STUDENTNAME,ENROLLMENTNO,ACADEMICYEAR,PROGRAMCODE,BRANCHCODE   from studentmaster where INSTITUTECODE='"+mInstCode+"' and  ENROLLMENTNO='"+enrollno+"'";
                                 rs=db.getRowset(qrr);

                                 if(rs.next()){

                                    mstdid=  rs.getString("STUDENTID");
                                    macdyear=  rs.getString("ACADEMICYEAR");
                                    mprogcode=  rs.getString("PROGRAMCODE");
                                    mbranch=  rs.getString("BRANCHCODE");
                                    mname=  rs.getString("STUDENTNAME");
                                    menno=  rs.getString("ENROLLMENTNO");

                                   qry="INSERT INTO NA#STUDENTFeedetail(INSTITUTECODE, FEEHEADS, FEEHEADDATE,REGCODE,STUDENTID,FEEHEADRATE,FEEHEADQTY,AMOUNT,ENTRYBY,ENTRYDATE,DEACTIVE,LASTUPDATE) " +
                                    "VALUES('"+mInstCode+"','"+mfeehead+"',to_date('"+adate+"','dd-mm-yyyy'),' ','"+mstdid+"','"+mamt+"','1','"+mamt+"','"+mMemberName+"',sysdate,'N',sysdate)";
                                   System.out.println(qry);
                                   if(session.getAttribute("feedate")!=null){
                                   int n=db.insertRow(qry);
                                   }
                                 }



                            }

                               String ckkqry="select  A.STUDENTNAME,A.ENROLLMENTNO,A.ACADEMICYEAR,A.PROGRAMCODE,A.BRANCHCODE   from studentmaster A, NA#STUDENTFeedetail  " +
                                       " B where B.INSTITUTECODE='"+mInstCode+"' and B.FEEHEADS='"+mfeehead+"' and trunc( B.FEEHEADDATE)=( TO_DATE('"+adate+"','DD-MM-YYYY'))   and A.STUDENTID=B.STUDENTID order by A.STUDENTNAME ";
                                   rs=db.getRowset(ckkqry);
                                  int ctra=0;
                                  %>
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
                                  while(rs.next()){
                                        ctra++;
                                      String enroll=rs.getString("ENROLLMENTNO");
                                      String name=rs.getString("STUDENTNAME");
                                      String acadmic=rs.getString("ACADEMICYEAR");
                                      String prog=rs.getString("PROGRAMCODE");
                                      String brnch=rs.getString("BRANCHCODE");
                                      %>
                                       <tr>
                                      <td> <%=ctra%> </td>
                                      <td> <%=enroll%> </td>
                                      <td> <%=name%> </td>
                                      <td> <%=acadmic%> </td>
                                      <td> <%=prog%> </td>
                                      <td> <%=brnch%> </td>
                                     

                                  </tr>
                                  

                                     <% }%>
                                     </table>


  <p align="center">  <a href="https://webkiosk.jiit.ac.in/EmployeeFiles/ERPNonAcdmicFee/FeesHeadWise.jsp">BACK</a></p>


                              <%

                                  
                              session.removeAttribute("feehead");
                              session.removeAttribute("feerate");
                              session.removeAttribute("feedate");

                              %>
                           

                   




                <%
                  }else
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

                 }
                else
                {
                        out.print("<br><img src='Images/Error1.jpg'>");
                        out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='index.jsp'>Login</a> to continue</font> <br>");
                }

                %>
                </form>
                </body>
                </html>