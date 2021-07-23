<%-- 
    Document   : FeeHead
    Created on : 29 Jan, 2020, 5:04:48 PM
    Author     : anoop.tiwari
--%>

<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.text.SimpleDateFormat,java.util.Date" %>
<%@ page errorPage="ExceptionHandler.jsp" %>

<%
String mHead="",mCompCode ="";
String mCandCode="", MName="";
String mCandName="",mInst="",mFeeheadDate="",mVoucherEntryDate="",mVoucherNo="";
String mFeeHeads="";
String mHeadDesc="",mStudentName="",mACADEMICYEAR="",mPROGRAMCODE="",mBRANCHCODE="",mSEMESTER="",mEnrollMentNo="",mFeeAmount="",mFeeRate="";

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<TITLE>#### <%=mHead%> [ View Department wise Employee Profile/information ] </TITLE>


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
String qry="",x="",mFeeHeadQty="";
int msno=0;
ResultSet rs=null;
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

if (session.getAttribute("CompanyCode")==null)
{
	mCompCode="JIIT";
}
else
{
	mCompCode=session.getAttribute("CompanyCode").toString().trim();
}
if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
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

if (session.getAttribute("mEnrollMentNo")==null)
{
	mEnrollMentNo="";
}
else
{
	mEnrollMentNo=session.getAttribute("mEnrollMentNo").toString().trim();
}

OLTEncryption enc=new OLTEncryption();
   if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{
		mMemberCode=enc.decode(mMemberCode);
		mMemberType=enc.decode(mMemberType);
		mMemberID=enc.decode(mMemberID);

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
		  //----------------------

				try
				{
                                    qry="SELECT  nvl(FEEHEADS,'') FEEHEADS,nvl(HEADDESC,'') HEADDESC  FROM NA#FeeHeads where  institutecode='"+mInst+"' and feeheads='"+request.getParameter("FEEHEADS")+"'";
				rs=db.getRowset(qry);
				//out.print(qry);


				if(rs.next())
				{	msno++;

                                        mFeeHeads=rs.getString("FEEHEADS");
                                        mHeadDesc=rs.getString("HEADDESC");
                                        session.setAttribute("FEEHEADS",mFeeHeads);
                                        session.setAttribute("HEADDESC",mHeadDesc);
					

				}

				%>
				<!--<font align=right size=5 face="arial" color="#a52a2a" ><u>Fee Head</u></font>-->
                                <div></div>
                                <br>
                                <br>
                                <br>
                                <br>
                                <form name="NaForm" method="post" action="FeeHeadReciept.jsp">
                                <div>
				<table bgcolor=#fce9c5 class="sort-table" id="FeeHeadView" style="" rules=COLUMNS cellSpacing=1 cellPadding=0 width="30%" align=center border=1 >
				<thead>                                    
                                    <tr bgcolor="#c00000">
                                      <td align=left colspan=6 title="Fee Head"><font color="white"><b>Student Name (<%=mStudentName%>),Enrollment No(<%=mEnrollMentNo%>) </b></font></td>
                                    </tr>
                                    <tr bgcolor="#c00000">
                                      <td align=left colspan=6 title="Fee Head"><font color="white"><b>Academic Year (<%=mACADEMICYEAR%>)</b></font></td>
                                    </tr>
                                    <tr bgcolor="#c00000">
                                      <td align=left colspan=6 title="Fee Head"><font color="white"><b>Program (<%=mPROGRAMCODE%>) ,Branch (<%=mBRANCHCODE%>) ,Semester (<%=mSEMESTER%>)</b></font></td>
                                    </tr>
                                    <tr></tr><tr></tr>
                                    <tr bgcolor="#c00000"  >
                                      <td align=center colspan=6 title="Fee Head"><font color="white"><b>Fee Head (<%=mHeadDesc%>)</b></font></td>
                                    </tr>
				<tr bgcolor="#c00000">
                                <td title="Date"><font color="white"><b>Date</b></font></td>
				<td title="Qty"><font color="white"><b>Qty</b></font></td>
				<td title="Rate"><font color="white"><b>Rate</b></font></td>
                                <td Align=right title="Amount"><font color="white"><b>Amount</b></font></td>
                                <td Align=right title="Voucher Entry Date"><font color="white"><b>Voucher Entry Date</b></font></td>
                                <td Align=right title="Voucher Entry Date"><font color="white"><b>Voucher No</b></font></td>
				</tr>
				</thead>
				<%
				qry="select Feeheads,to_char(FeeheadDate,'dd-mm-yyyy') FeeheadDate,FEEHEADRATE,feeheadQty,Amount,to_char(VOUCHERENTRYDATE,'dd-mm-yyyy') VOUCHERENTRYDATE,VOUCHERNO from NA#STUDENTFeedetail where  institutecode='"+mInst+"' and  vouchercode is NOT null and feeheads='"+request.getParameter("FEEHEADS")+"' and studentid='"+session.getAttribute("mStudentId").toString().trim()+"' order by FeeheadDate desc";
				rs=db.getRowset(qry);
				//out.print(qry);


				while(rs.next())
				{	msno++;

                                        mFeeHeadQty=rs.getString("feeheadQty");
					mFeeheadDate=rs.getString("FeeheadDate");
                                        mFeeAmount=rs.getString("Amount");
                                        mFeeRate=rs.getString("FEEHEADRATE");
                                        mVoucherEntryDate=rs.getString("VOUCHERENTRYDATE");
                                        mVoucherNo=rs.getString("VOUCHERNO");

                                        //String pattern = "dd-MM-yyyy";
                                        //SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd/MM/yyyy");
                                        // Date date= simpleDateFormat.parse(mFeeheadDate);
                                        //SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
                  //  out.print(rs.getString("DepartmentCode")+"ssss");
					%>
					<tr bgcolor=#fce9c5>
                                                <td><font size=2><%=mFeeheadDate%></font></td>
						<td Align=centre><%=mFeeHeadQty%></td>
						<td><font size=2><%=mFeeRate%></font></td>
                                                <td Align=right><font size=2><%=mFeeAmount%></font></td>
                                                <td Align=right><font size=2><%=mVoucherEntryDate%></font></td>
                                                <td Align=right><font size=2><%=mVoucherNo%></font></td>
					</tr>
					<%
				}

				%>
                                <tr bgcolor=#fce9c5>
						<td Align=center colspan=6><INPUT TYPE="submit"  VALUE="Click to Print in PDF"></td>
                                                <%--<td Align=center colspan=6><input type='submit'  id='btnPrint'  onClick='window.print()' value='Click To Print'></td>--%>
					</tr>
				
                                </table>

                                </div>
                                </form>
				<%

		}
		catch(Exception e)
		{
			out.print(e);
		}

	//-----------------------------
  //-- Enable Security Page Level
  //-----------------------------
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
</body>
</html>