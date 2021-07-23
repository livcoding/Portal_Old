<%-- 
    Document   : ERPModuleForNonAcademicFees
    Created on : 27 Jan, 2020, 1:55:28 PM
    Author     : Anoop.Tiwari
--%>

<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %>
<%@page import="jilit.db.CommonComboData"%>

<%
String mHead="",mInstCode ="";
String mCandCode="", MName="";

String mCandName="",mINSTITUTECODE="",mStudentName="",mACADEMICYEAR="",mPROGRAMCODE="",mBRANCHCODE="",mSEMESTER="";

String URL="";
int mFeeHeadQty=0;
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
        <script type="text/javascript" src="js/sortabletable.js"></script>
        <script type="text/javascript" src="js/json2.js"></script>
        <link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

        <script src="../IQAC/js/jquery/jquery-1.10.2.js"></script>
        <script src="../IQAC/js/jquery/jquery-ui.js"></script>
        <script src="../IQAC/js/jquery/yattable.js"></script>
        <script src="../IQAC/js/jquery/numeric-1.0.js"></script>
        <script src="../IQAC/js/IQTest/CommonServiceJs.js"></script>
        <script src="../IQAC/js/IQTest/ComboJs.js"></script>
        <script src="js/ERPModuleForNonAcademicFees.js"></script>
         <script type="text/javascript">
        function mult(id) {
            var totalQty=document.getElementById(id).value;
            var num=id.substr(3);
           // alert(num);
           // var n1=num-1;
           var n1=num;
            //var n2=++num;
            var txt1="RATE".concat(n1);
            var txt2=id;
            var txt3="AMT".concat(n1);
            var txt4="AMOUNT".concat(n1);
            //alert("Amount--"+document.getElementsByName(txt4).value);
        
            var txtFirstNo = document.getElementById(txt1).value;
            var txtSecondNo = document.getElementById(txt2).value;
            var result = parseInt(txtFirstNo) * parseInt(txtSecondNo);
            if (!isNaN(result)) {
                document.getElementById(txt3).value = Number(result);
            }
            /*totalQty=Number(totalQty) + Number(document.getElementById('TotalQty').value);
            if (!isNaN(totalQty)) {
                document.getElementById('TotalQty').value = totalQty;
            }*/
            var totalAmt=document.getElementById(txt3).value;
            //alert("totalAmt--"+totalAmt);
            if(Number(AMOUNT)>0)
            {
                //alert("AMOUNT--"+AMOUNT);
              totalAmt=Number(totalAmt) + Number(document.getElementById('TotalAmt').value)-Number(AMOUNT);
              if (!isNaN(totalAmt))
              {
                document.getElementById('TotalAmt').value = Number(totalAmt);


              }
            }
            else
            {
            //alert("AMOUNT1--"+AMOUNT);
            totalAmt=Number(totalAmt) + Number(document.getElementById('TotalAmt').value)-Number(AMOUNT);
            if (!isNaN(totalAmt))
             {
               document.getElementById('TotalAmt').value = Number(totalAmt);
             }
            }
          }
 function AvoidSpace(event)
 {
    var k = event ? event.which : window.event.keyCode;
    if (k == 32) return false;
 }
            

      /*  function add(id) {
           // alert("123");
            var totalAmount=document.getElementById(id).value;
            totalAmount=totalAmount + document.getElementById('txt31').value;
            
            if (!isNaN(totalAmount)) {
                document.getElementById('txt32').value = totalAmount;
            }
        }*/
    </script>

<TITLE>#### <%=mHead%> [ View Students Profile/Information ] </TITLE>


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
CommonComboData ccd=new CommonComboData();
DBHandler db=new DBHandler();
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="",mDept="",mDesg="",mInst="",minst="",mDMemberID="";
String qry="",qry1="",qrys="", mEnOrNm="", x="",cInst="",mCheck="",qryi="",qrylink="",qrycount="";
String mStudentId="",mAcademicYear="",mProgramcode="",mEnrollmentno="",mBranchcode="",mEnrollMentNo="",mTempEnrollmentno="",mDeptCode="";
int msno=0;
ResultSet rs=null,rs1=null,rss=null,rslink=null,rscount=null;
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
if (session.getAttribute("DepartmentCode")==null)
{
	mDeptCode="";
}
else
{
	mDeptCode=session.getAttribute("DepartmentCode").toString().trim();
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
session.setAttribute("INSCODE"," ");
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
		  //-- Enable Security Page Level  uvesh

               //String mStudID=enc.decode(session.getAttribute(mStudID)).toString().trim());
	  //-----------------------------
		qry="Select WEBKIOSK.ShowLink('415','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      	RsChk1= db.getRowset(qry);
		if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
		   {
                    %>
                    <form name="frm" method="get">
                        <table width="60%"  border=1  rules=none align=center   topmargin=0 cellspacing=0 cellpadding=1 borderColor="#D98242" >
                          
                            <tr>
                                <td  align=center colspan=1>&nbsp;Enrollment Number</td>
                                <td><input  type=text  name="EnrollMentNo"  onchange="return ChangeCase()" id="EnrollMentNo" width=150px maxlength=50 onkeypress="return AvoidSpace(event)"></td>
                            </tr>
                        
                            <tr>
                                <td  align=center colspan=2>OR</td>
                            </tr>
<
                            
                 <tr>
                    <td style="text-align: right">Institute Code<span class="req"><font color='red'> *</font></span> :</td><td style="text-align: left"><select  name='instituteCode' id='instituteCode'  class='combo'  title='Institute Code' onchange="getAcademicYear()"><%=ccd.commonJspCombo("{\"comboId\":\"instituteCodeCombo1\"}")%></select></td>
                    <td style="text-align: right">Academic Year<font color='red'> *</font> :</td><td style="text-align: left"><select  name='academicYear' id='academicYear'  class='combo' style=''  title='Academic Year' onchange="getProgramCode()"><option value='0'>Select Academic Year</option></select></td>

                </tr>
                <tr>
                    <td style="text-align: right">Program Code:</td><td style="text-align: left"><select  name='programCode' id='programCode'  class='combo' style=''  title='Program Code' onchange="getBranchCode()"><option value='0'>Select Program Code</option></select></td>
                    <td style="text-align: right">Branch Code:</td><td style="text-align: left"><select  name='branchCode' id='branchCode'  class='combo' style=''  title='Branch Year' onchange="getEnrollMentNo()"><option value='0'>Select Branch Code</option></select></td>
                </tr>


                <tr>
                    <td style="text-align: right">EnrollMent Number:</td><td style="text-align: left" ><select  name='enrollmentno' id='enrollmentno'  class='combo' style=''  title='EnrollMent Number'><option value=''>Select EnrollMent Number</option></td>
                </tr>

                            <tr>
                            <br>
                            <td align=center colspan=4><input type="submit"  border= "3px" name="submit" id="submit" value="&nbsp; Submit &nbsp;" onClick="return Valid()" >
                                </br>
                            </td>
                        </tr>
                            
                        </table>
              <script>
                  function Valid(){
if(jQuery.trim($('#EnrollMentNo').val()) == 0 && jQuery.trim($('#instituteCode').val()) == 0 && jQuery.trim($('#academicYear').val()) == 0 && jQuery.trim($('#programCode').val()) == 0 && jQuery.trim($('#branchCode').val()) == 0 && jQuery.trim($('#enrollmentno').val()) == 0)
 {
alert("Please Enter the Enrollment Number OR Select Other Options");
return false;
 }
 if (jQuery.trim($('#EnrollMentNo').val()) == 0 && jQuery.trim($('#instituteCode').val()) != 0 && jQuery.trim($('#academicYear').val()) != 0 && jQuery.trim($('#programCode').val()) != 0 && jQuery.trim($('#branchCode').val()) != 0 && jQuery.trim($('#enrollmentno').val()) != 0 ) {

  return true;
  }
if (jQuery.trim($('#EnrollMentNo').val()) == 0 && jQuery.trim($('#instituteCode').val()) == 0 && jQuery.trim($('#academicYear').val()) != 0 && jQuery.trim($('#programCode').val()) != 0 && jQuery.trim($('#branchCode').val()) != 0 && jQuery.trim($('#enrollmentno').val()) != 0 ) {
      alert("Please Select Institute Code");
    return false;
     }
     if (jQuery.trim($('#EnrollMentNo').val()) == 0 && jQuery.trim($('#instituteCode').val()) == 0 && jQuery.trim($('#academicYear').val()) == 0 && jQuery.trim($('#programCode').val()) != 0 && jQuery.trim($('#branchCode').val()) != 0 && jQuery.trim($('#enrollmentno').val()) != 0 ) {
      alert("Please Select Academic Year");
    return false;
        }
      if (jQuery.trim($('#EnrollMentNo').val()) == 0 && jQuery.trim($('#instituteCode').val()) == 0 && jQuery.trim($('#academicYear').val()) == 0 && jQuery.trim($('#programCode').val()) == 0 && jQuery.trim($('#branchCode').val()) != 0 && jQuery.trim($('#enrollmentno').val()) != 0 ) {
      alert("Please Select Program Code");
    return false;
        }
         if (jQuery.trim($('#EnrollMentNo').val()) == 0 && jQuery.trim($('#instituteCode').val()) == 0 && jQuery.trim($('#academicYear').val()) == 0 && jQuery.trim($('#programCode').val()) == 0 && jQuery.trim($('#branchCode').val()) == 0 && jQuery.trim($('#enrollmentno').val()) != 0 ) {
      alert("Please Select Branch Code");
    return false;
        }
           if (jQuery.trim($('#EnrollMentNo').val()) !=0 && jQuery.trim($('#instituteCode').val()) == 0 && jQuery.trim($('#academicYear').val()) == 0 && jQuery.trim($('#programCode').val()) == 0 && jQuery.trim($('#branchCode').val()) == 0 && jQuery.trim($('#enrollmentno').val()) == 0 ) {
    
    return true;
        }
        if (jQuery.trim($('#EnrollMentNo').val()) == 0 && jQuery.trim($('#instituteCode').val()) != 0 && jQuery.trim($('#academicYear').val()) == 0 && jQuery.trim($('#programCode').val()) == 0 && jQuery.trim($('#branchCode').val()) == 0 && jQuery.trim($('#enrollmentno').val()) == 0 ) {
      alert("Please Select Value");
    return false;
        }
           if (jQuery.trim($('#EnrollMentNo').val()) == 0 && jQuery.trim($('#instituteCode').val()) != 0 && jQuery.trim($('#academicYear').val()) != 0 && jQuery.trim($('#programCode').val()) == 0 && jQuery.trim($('#branchCode').val()) == 0 && jQuery.trim($('#enrollmentno').val()) == 0 ) {
      alert("Please Select  Value");
    return false;
        }
           if (jQuery.trim($('#EnrollMentNo').val()) == 0 && jQuery.trim($('#instituteCode').val()) != 0 && jQuery.trim($('#academicYear').val()) != 0 && jQuery.trim($('#programCode').val()) != 0 && jQuery.trim($('#branchCode').val()) == 0 && jQuery.trim($('#enrollmentno').val()) == 0 ) {
      alert("Please Select  Value");
    return false;
        }
           if (jQuery.trim($('#EnrollMentNo').val()) != 0 && jQuery.trim($('#instituteCode').val()) != 0 && jQuery.trim($('#academicYear').val()) != 0 && jQuery.trim($('#programCode').val()) != 0 && jQuery.trim($('#branchCode').val()) != 0 && jQuery.trim($('#enrollmentno').val()) == 0 ) {
      alert("Please Select  Value");
    return false;
        }
          if (jQuery.trim($('#EnrollMentNo').val()) == 0 && jQuery.trim($('#instituteCode').val()) != 0 && jQuery.trim($('#academicYear').val()) != 0 && jQuery.trim($('#programCode').val()) != 0 && jQuery.trim($('#branchCode').val()) != 0 && jQuery.trim($('#enrollmentno').val()) == 0 ) {
      alert("Please Select  Value");
    return false;
        }
                  }
              
              </script>
                   
    <%
    //System.out.println("EnrollMentNo--"+request.getParameter("EnrollMentNo").trim());
   // System.out.println("enrollmentno--"+request.getParameter("enrollmentno").trim());
	if(request.getParameter("EnrollMentNo")!=null || request.getParameter("enrollmentno")!=null )
        {
            //out.print("enrollmentno--"+request.getParameter("enrollmentno").trim());
            mEnrollMentNo=request.getParameter("EnrollMentNo").trim();
           //out.print("mEnrollMentNo--"+mEnrollMentNo);


            if(request.getParameter("EnrollMentNo").trim()!=null && !request.getParameter("EnrollMentNo").trim().equals(""))
                {
                qrys="Select studentid,ENROLLMENTNO,INSTITUTECODE,STUDENTNAME,ACADEMICYEAR,PROGRAMCODE,BRANCHCODE,SEMESTER from studentmaster where enrollmentno='"+request.getParameter("EnrollMentNo").trim()+"'";
				//out.print("enrollmentno1--"+request.getParameter("enrollmentno").trim());
                }
            else
                {
                mTempEnrollmentno=request.getParameter("enrollmentno").trim();
                String str=mTempEnrollmentno.toString();
                //System.out.println("Str--"+str);
                int pos11=str.indexOf("[");
               // System.out.println("pos11--"+pos11);
               // int pos12=str.in
                int len=str.length();
                mEnrollMentNo=str.substring(0,pos11);
               // System.out.println("mEnrollMentNo--"+mEnrollMentNo);
                //mEnrollMentNo=str.substring(pos11,len);
                qrys="Select studentid,ENROLLMENTNO,INSTITUTECODE,STUDENTNAME,ACADEMICYEAR,PROGRAMCODE,BRANCHCODE,SEMESTER from studentmaster where enrollmentno='"+mEnrollMentNo+"'";
				//out.print("enrollmentno2--"+request.getParameter("enrollmentno").trim());
                }
				//out.print(qrys);



            rss=db.getRowset(qrys);
            if(rss.next())
                {
                mStudentId=rss.getString("studentid");
                mINSTITUTECODE=rss.getString("INSTITUTECODE");
                mStudentName=rss.getString("STUDENTNAME");
                
                mACADEMICYEAR=rss.getString("ACADEMICYEAR");
                mPROGRAMCODE=rss.getString("PROGRAMCODE");
                mBRANCHCODE=rss.getString("BRANCHCODE");
                mSEMESTER=rss.getString("SEMESTER");
                mEnrollMentNo=rss.getString("ENROLLMENTNO");

                session.setAttribute("mStudentId",mStudentId);
                session.setAttribute("mINSTITUTECODE",mINSTITUTECODE);
                session.setAttribute("mStudentName",mStudentName);

                session.setAttribute("mACADEMICYEAR",mACADEMICYEAR);
                session.setAttribute("mPROGRAMCODE",mPROGRAMCODE);
                session.setAttribute("mBRANCHCODE",mBRANCHCODE);
                session.setAttribute("mSEMESTER",mSEMESTER);
                session.setAttribute("mEnrollMentNo",mEnrollMentNo);

                }
                %>
                 </form>
                 <form NAME="ErpForm" action="ERPModuleForNonAcademicFeesAction.jsp" method=post>
                            <table bgcolor=#fce9c5 class="sort-table" id="table-1" ALIGN=CENTER rules=COLUMNS CELLSPACING=0 width=76% BORDER=1>
                                <thead>
                                    <tr bgcolor="#ff8c00">
                                        <td align="left"><b><font color=white>EnrollmentNo.-Student Name</font></b></td>
                                        <td colspan="5" align="left"><b><font color=white><%=mEnrollMentNo%>-<%=mStudentName%></font></b></td>
                                    </tr>
                                    <tr bgcolor="#ff8c00">
                                        <td align="left"><b><font color=white>Academic Year</font></b></td>
                                        <td colspan="5" align="left"><b><font color=white><%=mACADEMICYEAR%></font></b></td>
                                    </tr>
                                    <tr bgcolor="#ff8c00">
                                        <td align="left"><b><font color=white>Program</font></b></td>
                                        <td colspan="5" align="left"><b><font color=white><%=mPROGRAMCODE%></font></b></td>
                                    </tr>
                                    <tr bgcolor="#ff8c00">
                                        <td align="left"><b><font color=white>Branch</font></b></td>
                                        <td colspan="5" align="left"><b><font color=white><%=mBRANCHCODE%></font></b></td>
                                    </tr>
                                    <tr bgcolor="#ff8c00">
                                        <td align="left"><b><font color=white>Semester</font></b></td>
                                        <td colspan="5" align="left"><b><font color=white><%=mSEMESTER%></font></b></td>
                                    </tr>
                                    <tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr>
                                        
                                    <tr bgcolor="#ff8c00">
                                        <td><b><font color=white>FeeHead</font></b></td>
                                        <td><b><font color=white>Rate</font></b></td>
                                        <td><b><font color=white>Qty</font></b></td>
                                        <td><b><font color=white>Amount</font></b></td>
                                        <td><b><font color=white>Remarks</font></b></td>
                                        <td><b><font color=white>History</font></b></td>
                                    </tr>
                                </thead><tbody>

                 <%
           // qry1="select x.FEEHEADS as FEEHEADS,x.HEADDESC as HEADDESC ,x.RATE as RATE from NA#FeeHeads x, (select b.INSTITUTECODE ,b.studentid,b.enrollmentno,b.studentname ,b.programcode , b.branchcode  , b.DEACTIVE, PROGRAMCOMPLETIONDATE ,c.FEEHEADS ,c.FEEHEADQTY ,c.FEEHEADRATE from studentmaster b ,NA#STUDENTFeedetail c where nvl(B.INSTITUTECODE,'x')=nvl(c.INSTITUTeCODE,'x') and B.STUDENTID='"+mStudentId+"'  and B.STUDENTID=c.STUDENTID and c.vouchercode is not null ) y where   x.INSTITUTeCODE=y.INSTITUTECODE(+) and x.FEEHEADS= y.FEEHEADS(+)and x.feetype='S'";

            qry1="SELECT  nvl(x.FEEHEADS,'') FEEHEADS,nvl(x.HEADDESC,'') HEADDESC ,nvl(x.RATE,'') RATE,nvl(y.FEEHEADQTY,'') FEEHEADQTY ,nvl(y.AMOUNT,'') AMOUNT ,nvl(y.Remarks,'') Remarks FROM NA#FeeHeads x, (SELECT b.INSTITUTECODE,  b.studentid, b.enrollmentno, b.studentname, b.programcode, b.branchcode, b.DEACTIVE, PROGRAMCOMPLETIONDATE,  c.FEEHEADS,  c.FEEHEADQTY,  c.FEEHEADRATE,  c.FEEHEADDATE,c.AMOUNT,  Remarks FROM studentmaster b, NA#STUDENTFeedetail c WHERE NVL (B.INSTITUTECODE, 'x') = NVL (c.INSTITUTeCODE, 'x') AND B.STUDENTID = '"+mStudentId+"' AND B.STUDENTID = c.STUDENTID AND c.vouchercode IS  NULL) y WHERE  x.INSTITUTeCODE = y.INSTITUTECODE(+) AND x.FEEHEADS = y.FEEHEADS(+)   AND x.feetype = 'S' and x.departmentcode='"+mDeptCode+"' AND x.INSTITUTeCODE='"+mINSTITUTECODE+"' order by x.FEEHEADS";
            rs1=db.getRowset(qry1);
            
            int TotalAmount=0;
            while(rs1.next())
                {
                ctr++;
                count++;
                TotalAmount=TotalAmount+Integer.parseInt(rs1.getString("AMOUNT")==null?"0":rs1.getString("AMOUNT"));
                qrylink="select sum(feeheadqty) from NA#STUDENTFeedetail where  institutecode='"+mINSTITUTECODE+"' and  vouchercode is not null and feeheads='"+rs1.getString("FEEHEADS")+"' and studentid='"+mStudentId+"'";
                qrycount="select count(*) from NA#STUDENTFeedetail where  institutecode='"+mINSTITUTECODE+"' and  vouchercode is not null and feeheads='"+rs1.getString("FEEHEADS")+"' and studentid='"+mStudentId+"'";
                rslink=db.getRowset(qrylink);
                rscount=db.getRowset(qrycount);


               // list.add(rs1.getString("FEEHEADS"));
                %>

                  <input TYPE=hidden NAME="FEEHEADS<%=count%>" ID="FEEHEADS<%=count%>" VALUE="<%=rs1.getString("FEEHEADS")%>">
	          <input type="hidden" name="HEADDESC<%=count%>" id="HEADDESC<%=count%>" value="<%=rs1.getString("HEADDESC")%>">
                  <input TYPE=hidden NAME="RATE1<%=count%>" ID="RATE1<%=count%>" VALUE="<%=rs1.getString("RATE")%>">
                  <input TYPE=hidden NAME="FEEHEADQTY<%=count%>" ID="FEEHEADQTY<%=count%>" VALUE="<%=rs1.getString("FEEHEADQTY")==null?"":rs1.getString("FEEHEADQTY")%>">
	          <input type="hidden" name="AMOUNT<%=count%>" id="AMOUNT<%=count%>" value="<%=rs1.getString("AMOUNT")==null?"":rs1.getString("AMOUNT")%>">
                  <input TYPE=hidden NAME="Remarks<%=count%>" ID="Remarks<%=count%>" VALUE="<%=rs1.getString("Remarks")==null?"":rs1.getString("Remarks")%>">
                  <input TYPE=hidden NAME="TotalAmount<%=count%>" ID="TotalAmount<%=count%>" VALUE="<%=Integer.parseInt(rs1.getString("AMOUNT")==null?"0":rs1.getString("AMOUNT"))%>">
                <tr>
                    <td><%=rs1.getString("HEADDESC")%></td>                    
                    <td><input type="text" NAME="RATE<%=ctr%>" id="RATE<%=ctr%>" value="<%=rs1.getString("RATE")%>" readonly="readonly" size="5"/></td>
                    <td><input type="text" NAME="QTY<%=ctr%>" id="QTY<%=ctr%>" value="<%=rs1.getString("FEEHEADQTY")==null?"":rs1.getString("FEEHEADQTY")%>" onchange="mult(this.id)" size="5" /></td>
                    <td><input type="text" NAME="AMT<%=ctr%>" id="AMT<%=ctr%>" value="<%=rs1.getString("AMOUNT")==null?"":rs1.getString("AMOUNT")%>"  size="5" readonly="readonly"/></td>
                    <td><input type="text" NAME="REM<%=ctr%>" id="REM<%=ctr%>" value="<%=rs1.getString("Remarks")==null?"":rs1.getString("Remarks")%>"  size="50"/></td>

                    <%
                    if(rscount.next())
                        {
                       mFeeHeadQty= rscount.getInt(1);
                    }
                    if(rslink.next())
                    {
                        if(mFeeHeadQty>0)
                        {
                     %>
                    <td ALIGN=center><a href="FeeHead.jsp?FEEHEADS=<%=rs1.getString("FEEHEADS")%>"target=_New ><%=mFeeHeadQty%></a></td>
                   <%
                    }
                        else
                            {
                            %>
                            <td ALIGN=center>...</td>
                            
                            <%
                        }

                        }

                    %>
	          
	          
               <%

            }
            session.setAttribute("countofhiddennfield",count);
            session.setAttribute("countofcurrentfield",ctr);
            %>
                <tr bgcolor="#ff8c00">
                    <td><b><font color=white>Total</font></b></td>
                    <td></td><td></td><td><input type="text" id="TotalAmt" value="<%=TotalAmount%>" readonly="readonly" size="5"/></td><td></td><td></td></tr>
                <td align=center colspan=6><input type="submit"  border= "3px" name="Save" id="Save" value="&nbsp; Save &nbsp;" onClick="return Validate();" >
                <tr></tr>
                </tbody>
                </table>
               
                    <%
        }
        else
        {
           // response.sendRedirect("Error.jsp?sms=Please Enter EnrollmentNo.");
        //System.out.println("Please Enter EnrollMentNo");
       // out.println("Please Enter EnrollMentNo");
        }
         /* if (request.getParameter("Save") != null)
          {
              System.out.println("count"+count);

              for(int i=1;i<count;i++)
                  {
                  /*mName1="FEEHEADS"+i;
                  mName2="HEADDESC"+i;
                  mName3="RATE1"+i;
                  mName4="FEEHEADQTY"+i;
                  mName5="AMOUNT"+i;
                 /* mName6="Remarks"+i;
                  mName1="FEEHEADS"+i;
                  mName2="HEADDESC"+i;
                  mName3="RATE"+i;
                  mName4="QTY"+i;
                  mName5="AMT"+i;
                  mName6="REM"+i;
                  System.out.println("mName1--"+mName1);
                  System.out.println("mName2--"+mName2);
                  System.out.println("mName3--"+mName3);
                  System.out.println("mName4--"+mName4);
                  System.out.println("mName5--"+mName5);
                  System.out.println("mName6--"+mName6);

                  System.out.println("mName1--"+request.getParameter(mName1).trim());
                  System.out.println("mName2--"+request.getParameter(mName2).trim());
                  System.out.println("mName3--"+request.getParameter(mName3).trim());
                  System.out.println("mName4--"+request.getParameter(mName4).trim());
                  System.out.println("mName5--"+request.getParameter(mName5).trim());
                  System.out.println("mName6--"+request.getParameter(mName6).trim());
                  
                  qryi="insert into NA#STUDENTFeedetail( INSTITUTECODE, FEEHEADS,  FeeheadDate, REGCODE, STUDENTID, FEEHEADRATE, FEEHEADQTY, AMOUNT,remarks";
               qryi=qryi+ " ,ENTRYBY, ENTRYDATE, DEACTIVE, LASTUPDATE ) values('"+mInstCode+"','"+request.getParameter(mName1).trim()+"',sysdate,'REGCODE','"+session.getAttribute("studentid").toString().trim()+"','"+request.getParameter(mName3).trim()+"'";
               qryi=qryi+ " ,'"+request.getParameter(mName4).trim()+"','"+request.getParameter(mName5).trim()+"','"+request.getParameter(mName6).trim()+"')where vouchercode is not null";
              int ni=db.insertRow(qryi);
             /* if (ni > 0)
              {
                 System.out.println("Inserted Successfully");
              }
              else
              {
                  System.out.println("Not Inserted Successfully");
              }*/
                  //System.out.println(mName1);
                   //System.out.println(request.getParameter(mName1).trim());

                 // }
              /*Iterator itr=list.iterator();
              while(itr.hasNext())
              {
                   System.out.println(itr.next());
              
              qryi="insert into NA#STUDENTFeedetail( INSTITUTECODE, FEEHEADS,  FeeheadDate, REGCODE, STUDENTID, FEEHEADRATE, FEEHEADQTY, AMOUNT,remarks";
               qryi=qryi+ " ,ENTRYBY, ENTRYDATE, DEACTIVE, LASTUPDATE ) values('"+mInst+"' ,) where vouchercode is not null";
              int ni=db.insertRow(qryi);

              }*/
              

         // }*/
			
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
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='index.jsp'>Login</a> to continue</font> <br>");
}

%>
</form>
</body>
</html>
