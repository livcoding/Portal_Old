<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%
        try {
            String mVacCode = "", mVacDesc = "";
            String mHead = "";     
       
			String mMemberID ="",mMemberType="",mMemberName="",mMemberCode="";
            String mInst="",mComp="",mShow="";
            
String mAppName = "", mDOB = "", mAdd1 = "", mAdd2 = "", mAdd3 = "", mCity = "", mState = "", mDistrict = "", mApplicantID = "",mStatusselect="",mReject="",mSelect="",mSelectedStatus="",mRemarks="",mFinalShortList="",mDept="",mTabColor="";

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
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}

if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}


if (session.getAttribute("DepartmentCode")==null)
{
	mDept="";
}
else
{
	mDept=session.getAttribute("DepartmentCode").toString().trim();
}


if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>

<html>
    <head>
        <TITLE>#### <%=mHead%> [ DepartmentSelection ]</TITLE>
        <link  rel="stylesheet" type="text/css" href="css/style.css">
        <script language="JavaScript" type ="text/javascript">
            <!--
            if (top != self) top.document.title = document.title;
            -->
        </script>

</script>
    </head>
    <body id="top" aLink=#ff00ff rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
   <form name="DepartmentSave">
	<%

    GlobalFunctions gb = new GlobalFunctions();
    DBHandler db = new DBHandler();
    String qry = "";
	String mDMemberID="",mDMemberCode="",mDMemberType="";
    String qry1="",qry2="",qry3="",qry4="";
    ResultSet rs = null,rsupdate=null;
	String ApplicationID="",mDeptRemark="",mStatus="",qryupdate="",qryinsert="",mFreeze="",mDeptCode="";
int ShortlistSeq=0,mflag=0;
	

try
{
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{
		OLTEncryption enc=new OLTEncryption();
		mDMemberID=enc.decode(mMemberID);
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);

		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		String mRightID="255";
		ResultSet RsChk=null;

	  //-----------------------------
	  //-- Enable Security Page Level  
	  //-----------------------------
		qry="Select WEBKIOSK.ShowLink('"+mRightID+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		
		
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{

	%>

		<table  border=1  borderColor=#D98242 rules=group align=left  topmargin=0 cellspacing=0 cellpadding=0>
				 <tr bgcolor="#FFCF83">
					<td colspan=2 class="labelcell" align=left>
					<A href="DepartmentSelectionPage.jsp"><font face=verdana size=4 ><b><<-Go Back </b></b></A></td>
				</tr>
				</table>
	<table  align=center >

            <tr><td align=center><h2>&nbsp;&nbsp; Initial ShortListing by Nominated Members &nbsp;&nbsp;</h2></td></tr>
			<tr><td align=center class="labelcell">Name : <%=mMemberName%></td></tr>
        </table>
	<%
	if(request.getParameter("VacancyCode")==null)
		mVacCode="";
	else
		mVacCode=request.getParameter("VacancyCode").toString().trim();

	if(request.getParameter("Institute")==null)
		mInst="";
	else
		mInst=request.getParameter("Institute").toString().trim();

	if(request.getParameter("CompanyCode")==null)
		mComp="";
	else
		mComp=request.getParameter("CompanyCode").toString().trim();

		if(request.getParameter("ShowStatus")==null)
		mShow="";
	else
		mShow=request.getParameter("ShowStatus");

	
if(request.getParameter("DeptCode")==null)
		mDeptCode="";
	else
		mDeptCode=request.getParameter("DeptCode").toString().trim();


	if(request.getParameter("ShortlistSeq")==null)
		ShortlistSeq=0;
	else
		ShortlistSeq=Integer.parseInt(request.getParameter("ShortlistSeq"));

	//if(ShortlistSeq==1)	
	ShortlistSeq=2;

int start=0,last=0,		ccustom=0;
String mPage="";


if(request.getParameter("ccustom")==null)
		ccustom=0;
	else
		ccustom=Integer.parseInt(request.getParameter("ccustom"));



	 if(request.getParameter("sstart")==null)
    {
        start=1;
    }
    else
    {
        start=Integer.parseInt(request.getParameter("sstart"));
    }
    
    
    if(request.getParameter("llast")==null)
    {
		last=5;
	}
	else
	{
		last=Integer.parseInt(request.getParameter("llast"));
	}
if (request.getParameter("Paging")==null)
					mPage="";
				else
					mPage=request.getParameter("Paging").trim();

	if(request.getParameter("Freeze")==null)
			{
				mFreeze="N";
			}
			else
			{
				mFreeze="Y";
			}
		//out.print(mFreeze+"FFF"+ShortlistSeq);
	int mTotalCount=0;

	mTotalCount=Integer.parseInt(request.getParameter("TotalCount"));



//out.print(mTotalCount);
//if(mTotalCount<)

	if(mTotalCount!=0 )
	{
		for(int i=1;i<=mTotalCount;i++)
		{
			if(request.getParameter("DeptRemarks"+i)==null)
				mDeptRemark="";
			else
				mDeptRemark=request.getParameter("DeptRemarks"+i).toString().trim();
	
			if(request.getParameter("Status"+i)==null)
			{	mStatus="N";}
			else
			{mStatus=request.getParameter("Status"+i).toString().trim();}

			//out.print(request.getParameter("Status"+i));
	
			if(request.getParameter("ApplicationID"+i)==null)
				ApplicationID="";
			else
				ApplicationID=request.getParameter("ApplicationID"+i).toString().trim();

				//out.print(ApplicationID+"@@@@@"+mStatus+"<br>");

		if(!mStatus.equals("N"))
		{
			qry="SELECT 'Y' FROM HR#APPLICANTSHORTLISTMASTER WHERE COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND VACANCYCODE='"+mVacCode+"' AND   APPLICANTID='"+ApplicationID+"' AND SHORTLISTSEQNO="+ShortlistSeq+" ";
			//out.print(qry);
			rs=db.getRowset(qry);
			if(rs.next())
			{
				 qryupdate="UPDATE HR#APPLICANTSHORTLISTMASTER	" +
                         "		SET    STATUS         = '"+mStatus+"',			" +
                         "	  SHORTLISTBY    = '"+ mChkMemID+"' ,    " +
                         "   SHORTLISTDATE  = sysdate,       REMARKS    " +
                         "    = '"+mDeptRemark+"',       ENTRYBY        = '"+ mChkMemID+"',   " +
                         "    ENTRYDATE      = sysdate		" +
                         "		 ,FINAL='"+mFreeze+"', FINALIZEDBY='"+ mChkMemID+"', FINALIZEDDATE=sysdate		" +
                         "			 WHERE  COMPANYCODE    = '"+mComp+"' AND   " +
                         " INSTITUTECODE  = '"+mInst+"' AND    VACANCYCODE    = '"+mVacCode+"' AND " +
                         "   APPLICANTID    = '"+ApplicationID+"' AND  " +
                         "  SHORTLISTSEQNO = "+ShortlistSeq+" ";
				// out.print(qryupdate);
				
				int update=db.update(qryupdate);
				if(update>0)
					mflag=1;
				else
					mflag=0;
			}
			else
			{
				qryinsert="INSERT INTO HR#APPLICANTSHORTLISTMASTER (   COMPANYCODE, INSTITUTECODE, VACANCYCODE,    APPLICANTID, SHORTLISTSEQNO, STATUS,    SHORTLISTBY, SHORTLISTDATE, REMARKS,    DEACTIVE, ENTRYBY, ENTRYDATE,   FINAL ,FINALIZEDBY,FINALIZEDDATE)  VALUES ( '"+mComp+"','"+mInst+"' ,'"+mVacCode+"' ,'"+ApplicationID+"'    ,'"+ShortlistSeq+"' ,'"+mStatus+"' ,'"+ mChkMemID+"' ,sysdate ,'"+mDeptRemark+"' , 'N' , '"+ mChkMemID+"', sysdate ,'"+mFreeze+"','"+ mChkMemID+"',sysdate)";
	//out.print(qryinsert);
				
int insert=db.insertRow(qryinsert)	;
				if(insert>0)
					mflag=1;
				else
					mflag=0;
			}
		}
		else
			{
mflag=1;
			}
			/*if(mStatus.equals("R"))
			{
				 qry="UPDATE HR#APPLICATIONMASTER SET SHORTLISTED='"+mStatus+"' ,SHORTLISTEDBY  = '"+ mChkMemID+"', SHORTLISTEDDATE = sysdate     WHERE 		APPLICANTID = '"+ApplicationID+"' and VACANCYCODE    = '"+mVacCode+"' ";
					//out.print(qry);
					int finalupdate=db.update(qry);
					if(finalupdate>0)
						mflag=1;
					else
						mflag=0;
			}*/

			}

		if (mflag==1)
		{
			
				out.print("<BR><CENTER><FONT sIZE=4 COLOR=GREEN > <B> Record Saved Successfully... </B></FONT>");
				
							//	out.print(request.getParameter("Submit1")+"SUBMIT");		

			//out.print("ShowStatus"+mShow+"Vacancy"+mVacCode+"Paging"+mPage+"llast"+last+"sstart"+start);
if(request.getParameter("Submit1")==null &&  request.getParameter("Freeze")==null )
		{
		response.sendRedirect("DepartmentLinksPage.jsp?ShowStatus="+mShow+"&VacancyCode="+mVacCode+"&DeptCode="+mDeptCode+"&llast="+last+"&sstart="+start+"&ccustom="+ccustom+"&x=1");
		}
		else if(request.getParameter("Submit1")!=null) 
		{	
		response.sendRedirect("DepartmentLinksPage.jsp?ShowStatus="+mShow+"&VacancyCode="+mVacCode+"&DeptCode="+mDeptCode+"&llast="+last+"&sstart="+start+"&ccustom="+ccustom+"&x=1");
		}		
		
		
				///DepartmentLinks.jsp?ShowStatus=S&Vacancy=VAC1011&DeptCode=0004
		}
		else
		{
					out.print("<BR><BR><CENTER><FONT sIZE=2 COLOR=red > <B> Error ... </B></FONT>");
						%>		<center>
<a href="javascript:window.close()"><FONT SIZE=2 COLOR=BLUE FACE=VERDANA>
Click to Close</FONT></a>
</center>
<%
		}

		}


%>
<table width="100%" border=1  borderColor=#D98242 rules=group align=center bottommargin=1 topmargin=0 cellspacing=0 cellpadding=2>
     <br>
     <tr bgcolor="#FFCF83">
	  <td  class="labelcell"><b><CENTER>Sr.No.</CENTER></b></td>
       <td  class="labelcell"><b><CENTER>Candidate<br>Selection</CENTER></b></td>
         <td  class="labelcell"><b><CENTER>Name<br><br>DOB</CENTER></b></td>
                  <td  class="labelcell"><b><CENTER>Address</CENTER></b></td>
				   <td class="labelcell"><b><CENTER> Remark</CENTER></b> </td>
				   </tr>

<% int ctr=0;
qry="SELECT round(months_between(sysdate,dateofbirth)/12)AGE , nvl(a.SHORTLISTED,' ')SHORTLISTED, decode(a.SHORTLISTED,'S','Selected','R','Rejected','',' ',a.SHORTLISTED)FINALSHORTLISTED,c.SHORTLISTSEQNO,a.APPLICANTID,nvl(a.firstname,' ') firstname,nvl(a.middlename,' ') middlename,nvl(a.lastname,' ') lastname,to_char(a.dateofbirth,'DD-MM-YYYY')dateofbirth ,nvl(b.CADDRESS1,' ')CADDRESS1, nvl(b.CADDRESS2,' ')CADDRESS2, nvl(b.CADDRESS3,' ')CADDRESS3, nvl(b.CCITY,' ')ccity, nvl(b.CDISTRICT,' ')CDISTRICT, nvl(b.CSTATE,' ')CSTATE, b.CPIN,decode(c.STATUS,'S','Selected','R','Rejected','N','NotProcess',c.STATUS) STATUS ,nvl(c.REMARKS,' ')REMARKS ,nvl(C.final,'N') final FROM hr#applicationmaster a, hr#applicantaddress b,HR#APPLICANTSHORTLISTMASTER c WHERE a.applicantid = b.applicantid AND a.vacancycode = '"+mVacCode+"' AND a.departmentcode = '"+mDeptCode+"' and a.APPLICANTID=c.APPLICANTID and b.APPLICANTID=c.APPLICANTID and a.VACANCYCODE=c.VACANCYCODE and a.INSTITUTECODE=c.INSTITUTECODE AND A.COMPANYCODE=C.COMPANYCODE AND A.INSTITUTECODE=C.INSTITUTECODE AND a.institutecode = c.institutecode AND c.shortlistseqno = 2 ORDER BY c.status desc ";
 rs = db.getRowset(qry);
//  out.print(qry);
        while (rs.next())
		{
			ctr++;
			 mAppName = rs.getString("firstname").toString().toUpperCase()+" "+rs.getString("middlename").toString().toUpperCase()+" "+rs.getString("lastname").toString().toUpperCase();
            mDOB = rs.getString("dateofbirth").toString();
            mAdd1 = rs.getString("CADDRESS1").toString().trim();
            mAdd2 = rs.getString("CADDRESS2").toString().trim();
            mAdd3 = rs.getString("CADDRESS3").toString().trim();
            mCity = rs.getString("ccity").toString().trim();
            mState = rs.getString("CSTATE").toString().trim();
            mDistrict = rs.getString("CDISTRICT").toString().trim();
			mStatusselect= rs.getString("STATUS").toString().trim();
			mRemarks=rs.getString("REMARKS").toString().trim();
			
			
if(mStatusselect.equals("Selected"))
	mTabColor="lightgreen";
else if(mStatusselect.equals("Rejected"))
	mTabColor="pink";
else if(mStatusselect.equals("NotProcess"))
	mTabColor="lightblue";
			
			%>
			  <tr bgColor="<%=mTabColor%>" > 
	 <td  class="labelcell"  valign=top> <%=ctr%>.</td>
	  <td nowrap valign=top class="labelcell">
             <%=mStatusselect%>
         </td>
		  	
         <td  class="labelcell" nowrap valign=top>
             <%=mAppName%><br><br> DOB :<%=mDOB%> <BR>Age :<%=rs.getString("Age")%>
         </td>
         <td class="labelcell" valign=top>
             <%=mAdd1%>&nbsp;<%=mAdd2%>&nbsp;<%=mAdd3%><br>
             <%=mCity%>&nbsp;<%=mState%>&nbsp;<%=mDistrict%>
         </td>
		 
		  <td valign=top class="labelcell">
                <%=mRemarks%>
              </td>
		 </tr>

			<%
		}

%>
	<style type="text/css">
				@media print 
				{
				input#btnPrint 
				{
					display: none;
				}
				}
				</style>
		
		<tr>
		<!-- <td align="left" >
		<a href="javascript:window.close()"><FONT SIZE=2 COLOR=BLUE FACE=VERDANA>
		Click to Close</FONT></a>
		</td> -->

		<td align="center" COLSPAN=5 ><br>
			 <input type="button" name='submit'  id="btnPrint"  onClick='window.print()' value='Click To Print'>
			<!-- <INPUT TYPE="submit" name="Freeze" value="Click to Freeze" > -->
		</td>
		
		
		</tr>
		
		<table>
<%

	}
else
{
   %>
	<br>
	<font color=red>
	<h3><br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
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
catch(Exception e)
{
	//out.print("Exception "+e);
}
        } catch (Exception e) {
            out.print(e+" zzzzz");
        }
%>

		
		</form>
		</body>
		</html>


