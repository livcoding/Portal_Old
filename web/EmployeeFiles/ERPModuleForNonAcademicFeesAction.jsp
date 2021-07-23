<%--
    Document   : ERPModuleForNonAcademicFeesAction
    Created on : 31 Jan, 2020, 11:52:46 AM
    Author     : anoop.tiwari
--%>

<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %>
<%
OLTEncryption enc=new OLTEncryption();
GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
   mHead=session.getAttribute("PageHeading").toString().trim();
else
   mHead="JIIT ";


%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [Student VC Remarks] </TITLE>

<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>


</HEAD>
<%
String mMemberID="";
String mMemberType="";
String mMemberCode="",qry="",qryi="",qryu="",mMemberName="",qrytHead="",qry1="",qrylink="",qrycount="",qry111="";
ResultSet rs=null,rsHead=null,rs1=null;
ResultSet rss=null,rslink=null,rscount=null,rsVoucher=null;
String mWebEmail="";
String mInst="";
String mCount="",mCtr="",mINSTITUTECODE="",mStudentId="",mStudentName="",mACADEMICYEAR="",mPROGRAMCODE="",mBRANCHCODE="",mSEMESTER="",mEnrollMentNo="";
int update=0,insert=0;
int totalAmount=0;
int mFeeHeadQty=0;
int ctr1=0;
int count1=0;
String qryVoucher="",mVoucherNo="",mDeptCode="";

String mName1="";
String mName2="";
String mName3="";
String mName4="";
String mName5="";
String mName6="";
String mName7="";
String mName8="";
String temp=null;


if (session.getAttribute("WebAdminEmail")==null)
{
	 mWebEmail="";
}
else
{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
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

if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
}
if (session.getAttribute("DepartmentCode")==null)
{
	mDeptCode="";
}
else
{
	mDeptCode=session.getAttribute("DepartmentCode").toString().trim();
}
if (session.getAttribute("MemberName")==null)
{
	mMemberName="";
}
else
{
	mMemberName=session.getAttribute("MemberName").toString().trim();
}

if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}
if (session.getAttribute("mINSTITUTECODE")==null)
{
	mINSTITUTECODE="";
}
else
{
	mINSTITUTECODE=session.getAttribute("mINSTITUTECODE").toString().trim();
}
if (session.getAttribute("mStudentId")==null)
{
	mStudentId="";
}
else
{
	mStudentId=session.getAttribute("mStudentId").toString().trim();
}
if (session.getAttribute("mEnrollMentNo")==null)
{
	mEnrollMentNo="";
}
else
{
	mEnrollMentNo=session.getAttribute("mEnrollMentNo").toString().trim();
}
if (session.getAttribute("mStudentName")==null)
{
	mStudentName="";
}
else
{
	mStudentName=session.getAttribute("mStudentName").toString().trim();
}
if (session.getAttribute("mACADEMICYEAR")==null)
{
	mACADEMICYEAR="";
}
else
{
	mACADEMICYEAR=session.getAttribute("mACADEMICYEAR").toString().trim();
}
if (session.getAttribute("mPROGRAMCODE")==null)
{
	mPROGRAMCODE="";
}
else
{
	mPROGRAMCODE=session.getAttribute("mPROGRAMCODE").toString().trim();
}
if (session.getAttribute("mBRANCHCODE")==null)
{
	mBRANCHCODE="";
}
else
{
	mBRANCHCODE=session.getAttribute("mBRANCHCODE").toString().trim();
}
if (session.getAttribute("mSEMESTER")==null)
{
	mSEMESTER="";
}
else
{
	mSEMESTER=session.getAttribute("mSEMESTER").toString().trim();
}




%>

<BODY aLink=#ff00ff bgcolor="#fce9c5" rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 scroll=auto>
<%
if(!mMemberID.equals("") || !mMemberType.equals("") || !mMemberCode.equals(""))
{

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('415','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {

            if (session.getAttribute("countofhiddennfield")==null)
            {
	     mCount="";
            }
         else
          {
	   mCount=session.getAttribute("countofhiddennfield").toString().trim();
          }
     if (session.getAttribute("countofcurrentfield")==null)
          {
	   mCtr="";
          }
        else
         {
	mCtr=session.getAttribute("countofcurrentfield").toString().trim();
        }
            int count=Integer.parseInt(mCount);
            int ctr=Integer.parseInt(mCtr);

            //System.out.println("count--"+count);
           // System.out.println("ctr--"+ctr);

            for(int i=1;i<=count;i++)
                  {
                int temp1=0;
                String mHeads="";
                  mName1="FEEHEADS"+i;
                  mName2="HEADDESC"+i;
                  mName3="RATE"+i;
                  mName4="QTY"+i;
                  mName5="AMT"+i;
                  mName6="REM"+i;
                  //System.out.println("mName1--"+mName1);
                  //System.out.println("mName2--"+mName2);
                  //System.out.println("mName3--"+mName3);
                  //System.out.println("mName4--"+mName4);
                  //System.out.println("mName5--"+mName5);
                  //System.out.println("mName6--"+mName6);

                  //for update purpose
                  mName7="FEEHEADQTY"+i;
                  mName8="Remarks"+i;
                 // mName8="FEEHEADS"+i;

                  if(request.getParameter(mName1)==null || request.getParameter(mName1).equals(""))
                    {
	             mName1="";
                    }
                 else
                   {
	            mName1=request.getParameter(mName1).toString().trim();
                   }
                  if(request.getParameter(mName2)==null || request.getParameter(mName2).equals(""))
                    {
	             mName2="";
                    }
                 else
                   {
	            mName2=request.getParameter(mName2).toString().trim();
                   }
                  if(request.getParameter(mName3)==null || request.getParameter(mName3).equals(""))
                    {
	             mName3="";
                    }
                 else
                   {
	            mName3=request.getParameter(mName3).toString().trim();
                   }
                   if(request.getParameter(mName4)==null || request.getParameter(mName4).equals(""))
                    {
	             mName4="";
                    }
                 else
                   {
	            mName4=request.getParameter(mName4).toString().trim();
                   }
                   if(request.getParameter(mName5)==null || request.getParameter(mName5).equals(""))
                    {
	             mName5="";
                    }
                 else
                   {
	            mName5=request.getParameter(mName5).toString().trim();
                   }
                  if(request.getParameter(mName6)==null || request.getParameter(mName6).equals(""))
                    {
	             mName6="";
                    }
                 else
                   {
	            mName6=request.getParameter(mName6).toString().trim();
                   }
                  if(request.getParameter(mName7)=="null" || request.getParameter(mName7).equals(""))
                    {
	             mName7="";
                    }
                 else
                   {
	            mName7=request.getParameter(mName7).toString().trim();
                   }

                 if(request.getParameter(mName8)=="null" || request.getParameter(mName8).equals(""))
                    {
	             mName8="";
                    }
                 else
                   {
	            mName8=request.getParameter(mName8).toString().trim();
                   }
                   /*if(request.getParameter(mName8)==null || request.getParameter(mName8).equals(""))
                    {
	             mName8="";
                    }
                 else
                   {
	            mName8=request.getParameter(mName8).toString().trim();
                   }*/

                          totalAmount=totalAmount+Integer.parseInt(mName5==""?"0":mName5);


                  //System.out.println("mName1--"+mName1);
                 // System.out.println("mName2--"+mName2);
                  //System.out.println("mName3--"+mName3);
                  //System.out.println("mName4--"+mName4);
                  //System.out.println("mName5--"+mName5);
                  //System.out.println("mName6--"+mName6);
                  //System.out.println("mName7--"+mName7);
                     //21-05-2020
                          qryVoucher="Select nvl(VOUCHERNO,'') VOUCHERNO from NA#STUDENTFeedetail where studentid='"+session.getAttribute("mStudentId").toString().trim()+"' and feeheads='"+mName1+"' and VOUCHERNO is not null";
                  //System.out.println("--"+qryVoucher);
                          rsVoucher=db.getRowset(qryVoucher);
                  try{
                  if(rsVoucher.next())
                      {
                      mVoucherNo=rsVoucher.getString("VOUCHERNO");
                      }
                  else
                  {
                      mVoucherNo="";
                  }
                  }
                  catch(Exception e)
                          {
                      //e.printStackTrace();
                          }
                     //21-05-2020

                  qrytHead="Select nvl(FEEHEADS,'') FEEHEADS from NA#STUDENTFeedetail where studentid='"+session.getAttribute("mStudentId").toString().trim()+"' and feeheads='"+mName1+"'";
                  rsHead=db.getRowset(qrytHead);
                  if(rsHead.next())
                      {
                      mHeads=rsHead.getString("FEEHEADS");
                      }
               // if(mName7.equals("null") || mName7.isEmpty())
              if((mName7.isEmpty()&&!mName4.isEmpty()&&!mName4.equals("0")&&!mName1.equals(mHeads))
                          ||(mName7.isEmpty()&&!mName4.isEmpty()&&!mName4.equals("0")&&!mVoucherNo.isEmpty()))
                {
                    temp1++;
                  qryi="insert into NA#STUDENTFeedetail( INSTITUTECODE, FEEHEADS,  FeeheadDate, REGCODE, STUDENTID, FEEHEADRATE, FEEHEADQTY, AMOUNT,remarks";
                  qryi=qryi+ " ,ENTRYBY, ENTRYDATE, DEACTIVE, LASTUPDATE ) values ('"+mInst+"','"+mName1+"',sysdate,'REGCODE','"+session.getAttribute("mStudentId").toString().trim()+"','"+mName3+"'";
                  qryi=qryi+ " ,'"+mName4+"','"+mName5+"','"+mName6+"','"+mMemberName+"',sysdate,'N',sysdate) ";
                 //out.println(qryi);
                 int ni=db.insertRow(qryi);
                 if (ni > 0)
                  {
                     insert++;
                   //out.println("Inserted Successfully");
                  // System.out.println("qryi--"+qryi);
                  }
             else
                 {
                 out.println("Not Inserted Successfully");
                 //System.out.println("qryi--"+qryi);
                 }
                  //System.out.println(mName1);
                   //System.out.println(request.getParameter(mName1).trim());
              }
          else if((!mName7.equals(mName4)&&!mName4.isEmpty()&&mName1.equals(mHeads))||(!mName4.isEmpty()&&mName1.equals(mHeads)&&!mName6.isEmpty()&&!mName6.equals(mName8)))
                {
                      temp1++;
                      qryu="update NA#STUDENTFeedetail set FEEHEADQTY = '"+mName4+"',REMARKS='"+mName6+"', AMOUNT = '"+mName5+"',lastupdate=sysdate where institutecode='"+mInst+"' and  vouchercode is  null and feeheads='"+mName1+"' and studentid='"+session.getAttribute("mStudentId").toString().trim()+"' ";
                      int nu=db.update(qryu);
                      if(nu>0)
                      {
                          update++;
                          //out.println("Updated Successfully");
                         // System.out.println("qryu--"+qryu);
                      }
                      else
                      {
                      //out.println("Not Updated Successfully");
                          //System.out.println("qryu--"+qryu);
                      }

               }
         else
              {
                         if(temp1>0)
                             {
                            // out.print("Problem in Logic--");
                             System.out.println("Please check your insert or update Logic--");
                             }
                         else
                             {
                             //out.print("Not a case of insert or update--");
                            // System.out.println("Not a case of insert or update--");
                             }
                          //System.out.println("mName7--"+mName7+"mName4--"+mName4);
              }


           }
            if(insert>0){
         //  out.println("Total number of Record Inserted="+insert);

    }
           %>
           <br>
           <%
           if(update>0){
          // out.println(" Total number of Record Updated="+update);


            //out.println("Total Amount="+totalAmount);
           }
           %>
           <br>
           <%
           // out.println("Total Amount="+totalAmount);
			//view after insert Anoop start
           %>
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



           qry111="SELECT  nvl(x.FEEHEADS,'') FEEHEADS,nvl(x.HEADDESC,'') HEADDESC ,nvl(x.RATE,'') RATE,nvl(y.FEEHEADQTY,'') FEEHEADQTY ,nvl(y.AMOUNT,'') AMOUNT ,nvl(y.Remarks,'') Remarks FROM NA#FeeHeads x, (SELECT b.INSTITUTECODE,  b.studentid, b.enrollmentno, b.studentname, b.programcode, b.branchcode, b.DEACTIVE, PROGRAMCOMPLETIONDATE,  c.FEEHEADS,  c.FEEHEADQTY,  c.FEEHEADRATE,  c.FEEHEADDATE,c.AMOUNT,  Remarks FROM studentmaster b, NA#STUDENTFeedetail c WHERE NVL (B.INSTITUTECODE, 'x') = NVL (c.INSTITUTeCODE, 'x') AND B.STUDENTID = '"+mStudentId+"' AND B.STUDENTID = c.STUDENTID AND c.vouchercode IS  NULL) y WHERE  x.INSTITUTeCODE = y.INSTITUTECODE(+) AND x.FEEHEADS = y.FEEHEADS(+)   AND x.feetype = 'S' and x.departmentcode='"+mDeptCode+"' AND x.INSTITUTeCODE='"+mINSTITUTECODE+"' order by x.FEEHEADS";
            rs1=db.getRowset(qry111);

            int TotalAmount=0;
            while(rs1.next())
                {
                ctr1++;
                count1++;
                TotalAmount=TotalAmount+Integer.parseInt(rs1.getString("AMOUNT")==null?"0":rs1.getString("AMOUNT"));
                qrylink="select sum(feeheadqty) from NA#STUDENTFeedetail where  institutecode='"+mINSTITUTECODE+"' and  vouchercode is not null and feeheads='"+rs1.getString("FEEHEADS")+"' and studentid='"+mStudentId+"'";
                qrycount="select count(*) from NA#STUDENTFeedetail where  institutecode='"+mINSTITUTECODE+"' and  vouchercode is not null and feeheads='"+rs1.getString("FEEHEADS")+"' and studentid='"+mStudentId+"'";
                rslink=db.getRowset(qrylink);
                rscount=db.getRowset(qrycount);


               // list.add(rs1.getString("FEEHEADS"));
                %>

                  <input TYPE=hidden NAME="FEEHEADS<%=count1%>" ID="FEEHEADS<%=count1%>" VALUE="<%=rs1.getString("FEEHEADS")%>">
	          <input type="hidden" name="HEADDESC<%=count1%>" id="HEADDESC<%=count1%>" value="<%=rs1.getString("HEADDESC")%>">
                  <input TYPE=hidden NAME="RATE1<%=count1%>" ID="RATE1<%=count1%>" VALUE="<%=rs1.getString("RATE")%>">
                  <input TYPE=hidden NAME="FEEHEADQTY<%=count1%>" ID="FEEHEADQTY<%=count1%>" VALUE="<%=rs1.getString("FEEHEADQTY")==null?"":rs1.getString("FEEHEADQTY")%>">
	          <input type="hidden" name="AMOUNT<%=count1%>" id="AMOUNT<%=count1%>" value="<%=rs1.getString("AMOUNT")==null?"":rs1.getString("AMOUNT")%>">
                  <input TYPE=hidden NAME="Remarks<%=count1%>" ID="Remarks<%=count1%>" VALUE="<%=rs1.getString("Remarks")==null?"":rs1.getString("Remarks")%>">
                  <input TYPE=hidden NAME="TotalAmount<%=count1%>" ID="TotalAmount<%=count1%>" VALUE="<%=Integer.parseInt(rs1.getString("AMOUNT")==null?"0":rs1.getString("AMOUNT"))%>">
                <tr>
                    <td><%=rs1.getString("HEADDESC")%></td>
                    <td><input type="text" NAME="RATE<%=ctr1%>" id="RATE<%=ctr1%>" value="<%=rs1.getString("RATE")%>" readonly="readonly" size="5"/></td>
                    <td><input type="text" NAME="QTY<%=ctr1%>" id="QTY<%=ctr1%>" value="<%=rs1.getString("FEEHEADQTY")==null?"":rs1.getString("FEEHEADQTY")%>" readonly="readonly" size="5" /></td>
                    <td><input type="text" NAME="AMT<%=ctr1%>" id="AMT<%=ctr1%>" value="<%=rs1.getString("AMOUNT")==null?"":rs1.getString("AMOUNT")%>"  size="5" readonly="readonly"/></td>
                    <td><input type="text" NAME="REM<%=ctr1%>" id="REM<%=ctr1%>" value="<%=rs1.getString("Remarks")==null?"":rs1.getString("Remarks")%>"  readonly="readonly" size="50"/></td>

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
                    <td></td><td></td><td><input type="text" id="TotalAmt" value="<%=totalAmount%>" readonly="readonly" size="5"/></td><td></td><td></td></tr>

                <tr></tr>
                </tbody>
                </table>
                    <table>
                        <tr>
                            <td align=right>
                                                <a href="ERPModuleForNonAcademicFees.jsp"><font><b>BACK</b></font><a>
                            </td>
                        </tr>
                    </table>

                    <%


         //view after insert end


  }
  else
   {
   %>
<br>	<font color=red>
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
out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp'>Login</a> to continue</font> <br>");
}
%>

</BODY>
</HTML>