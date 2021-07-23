<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%
        try {
            String mVacCode = "", mVacDesc = "";
			String mMemberID ="",mMemberType="",mMemberName="",mMemberCode="";
            String mInst="",mComp="",mDept="";
            

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


String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<html>
    <head>
        <TITLE>#### <%=mHead%> [ HODWise Selection ]</TITLE>
        <link  rel="stylesheet" type="text/css" href="css/style.css">
   

<script language="JavaScript" type ="text/javascript">
		function openNewWindow(str)
        {
            var newWindow;
          //  alert(str);
		newWindow=window.open(str,'_new','height=600,width=800,minimize=no,status=yes,toolbar=no,menubar=no,location=no,scrollbars=no');
            newWindow.moveTo(132,50)
        }

function EnterRemarks(ss,slno)
	{
	//alert(document.getElementById("Status"+slno).value+"sdds"+ss);

		if(document.getElementById("Status"+slno).value=="R")
		{
			alert("Please Enter Remarks ");
			document.getElementById("DeptRemarks"+slno).value="";
			document.getElementById("DeptRemarks"+slno).focus();
			return false;

		}

		//if(document.getElementByID(ss).value)
	}

	function openWordDocPath(strLocation) {
	//	alert("sdsdsdsd"+strLocation);
		var objWord;
		objWord = new ActiveXObject("Word.Application");
		objWord.Visible = true;
		objWord.Documents.Open(strLocation);
	}
</script>
    </head>
    <body id="top" aLink=#ff00ff rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
    <%

    GlobalFunctions gb = new GlobalFunctions();
    DBHandler db = new DBHandler();
    String qry = "";
    String qry1="",qry2="",qry3="",qry4="";
    ResultSet rsd = null;
    ResultSet rs = null;
    ResultSet rs1 = null;
    ResultSet rs2 = null;
    ResultSet rs3 = null;
    ResultSet rs4 = null;
    String mDDS = "";
    String mS = "";
    String mPS = "";
    session.setAttribute("APPLICANTID", null);
    session.setAttribute("MFLAG", null);
   String mPrev = "", mPostheld = "", mNatureofJob = "", mTypeofExp = "";
            String mTODATE="",mFROMDATE="";

			String mDMemberID ="",mDMemberCode ="",mDMemberType="",mRightID="256";
    %>


   

<%
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
		ResultSet RsChk=null;

	  //-----------------------------
	  //-- Enable Security Page Level  
	  //-----------------------------
		qry="Select WEBKIOSK.ShowLink('"+mRightID+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		//out.print(qry);
		
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
%>
        <table  align=center >
            <tr><td ><h2>HOD Wise Selection</h2></td></tr>
        </table>
        <br>
        <form name=frm1 method=post >
            <input type=hidden name="x" id="x">
            <table borderColor=#D98242 align=center rules=none topmargin=0 cellspacing=0 cellpadding=4  border=1 >
                <tr>
                    <td align="left" class="labelcell">
                       <br> &nbsp;&nbsp;<strong>Vacancy
					</td>
					<td><br>
                            <select name="Vacancy" id="Vacancy" tabindex=1>

                                <%

    qry = "SELECT distinct COMPANYCODE, INSTITUTECODE, VACANCYCODE, VACANCYDESCRIPTION," +
            " FROMPERIOD, TOPERIOD, BROADCAST, CLOSED, CLOSINGDATE FROM HR#VACANCYMASTER" +
            " WHERE NVL(BROADCAST,'N')='Y' AND SYSDATE BETWEEN FROMPERIOD AND TOPERIOD and" +
            " VACANCYCODE in (select VACANCYCODE from HR#APPLICATIONMASTER  where INSTITUTECODE='"+mInst+"')";
    rs = db.getRowset(qry);
   
	if(request.getParameter("x")==null)
	{
		while (rs.next()) 
			{
		    mVacCode = rs.getString("VACANCYCODE").toString().trim();
			mVacDesc = rs.getString("VACANCYDESCRIPTION").toString().toUpperCase().trim();
                                %>
                                <option value="<%=mVacCode%>"><%=mVacDesc%></option>
                                <%
	        }
	}
	else
	{
			while (rs.next()) 
			{
				 mVacCode = rs.getString("VACANCYCODE").toString().trim();
				 mVacDesc = rs.getString("VACANCYDESCRIPTION").toString().toUpperCase().trim();
				 if(mVacCode.equals(request.getParameter("Vacancy").toString().trim()))
				{
					 %>
						 <option selected value="<%=mVacCode%>"><%=mVacDesc%></option>
					 <%
				}
				else
				{
						 %>
						 <option value="<%=mVacCode%>"><%=mVacDesc%></option>
					 <%
			
				}

			}

	}
                                %>
                            </select>
                        </strong>
                    </td>
                </tr>
                <tr>
                    <td align=left class="labelcell">
					<br>&nbsp;&nbsp;<strong>Department &nbsp;
					</td>
					<td  class="labelcell">
  
						<%
					
try {
qry = "select distinct departmentcode,department from DEPARTMENTMASTER where" +
" nvl(DEACTIVE,'N')='N' and  departmentcode ='"+mDept+"' and departmentcode in (select distinct DEPARTMENTCODE from " +
"HR#APPLICATIONMASTER where INSTITUTECODE='"+mInst+"') order by DEPARTMENT";
//out.print(qry);
rsd = db.getRowset(qry);
							%>

                           <br> <select NAME="Departmentcode" ID="Departmentcode" >
<%
while (rsd.next()) {
%>
<option value="<%=rsd.getString("DEPARTMENTCODE")%>"><%=rsd.getString("Department")%>  -  <%=rsd.getString("DEPARTMENTCODE")%></option>
<%
}
} catch (Exception e) {
//out.print(e+"  tyyyyy");
}
%>
                            </select>
                        </strong>
                    </td>
                </tr>

                <tr>
                    <td align=center colspan=2><br><input type=Submit style="background-color:#FFCF83" border= "3px" name=button id=button4 value="&nbsp; Submit &nbsp;" onClick="return Validate();" ></br></td>
                </tr>
            </table>
			</form>
            <%
    if (request.getParameter("x") != null) {
        String mDeptCode = "";
        mDeptCode = request.getParameter("Departmentcode").toString().trim();
		mVacCode= request.getParameter("Vacancy").toString().trim();
        //out.print(mDeptCode + "sads");
%>

<form method=post action="HODWiseSelectionAction.jsp">
 
 <table width="100%" border=1  borderColor=#D98242 rules=group align=center bottommargin=1 topmargin=0 cellspacing=0 cellpadding=2>
     <br>
     <tr bgcolor="#FFCF83">
         <td  class="labelcell"><b><CENTER>Status</CENTER></b></td>
         <td  class="labelcell"><b><CENTER>Name</CENTER></b></td>
                  <td  class="labelcell"><b><CENTER>Address</CENTER></b></td>
         <TD  align=center class="labelcell"><b> Applicant Qualification  </b></TD>
		          <TD  align=center class="labelcell"><b> Applicant Experience</b></TD>
   <TD  align=center class="labelcell"><b>Click to View CV </b></TD>
         <td class="labelcell"><b><CENTER>Department Name</CENTER></b>  </td>
         <!-- <td class="labelcell"><b><CENTER>Remark</CENTER></B> </td> -->
       
         <td class="labelcell"><b><CENTER>HOD<BR>Remark</CENTER></b> </td>

		   <td class="labelcell"><b><CENTER>Department<br>Selection</CENTER></b></td>
		     <td class="labelcell"><b><CENTER>Department<br>Remarks</CENTER></b></td>
     </tr>

     <%
        int slno = 0,mSHORTLISTSEQNO=0,mShortSeq=0;
        String mAppName = "", mDOB = "", mAdd1 = "", mAdd2 = "", mAdd3 = "", mCity = "", mState = "", mDistrict = "", mApplicantID = "",mStatus="",mReject="",mSelect="",mSelectedStatus="",mRemarks="";
        qry = " SELECT   DECODE (c.status,'S', 'Selected','R', 'Rejected','', ' ',  c.status                )deptstatus, c.remarks deptremarks  , c.SHORTLISTSEQNO,a.APPLICANTID,nvl(a.applicantname,' ') applicantname,to_char(a.dateofbirth,'DD-MM-YYYY')dateofbirth " +
                ",nvl(b.CADDRESS1,' ')CADDRESS1, nvl(b.CADDRESS2,' ')CADDRESS2, nvl(b.CADDRESS3,' ')CADDRESS3, " +
                "nvl(b.CCITY,' ')ccity, nvl(b.CDISTRICT,' ')CDISTRICT, nvl(b.CSTATE,' ')CSTATE,     b.CPIN,nvl(c.STATUS,' ') STATUS" +
                " FROM hr#applicationmaster a, hr#applicantaddress b,HR#APPLICANTSHORTLISTMASTER c" +
                " WHERE nvl(c.STATUS,'N')='S' and  a.applicantid = b.applicantid" +
                " AND a.vacancycode = '" + mVacCode + "'" +
                " AND a.departmentcode = '" + mDeptCode + "'    and a.APPLICANTID=c.APPLICANTID   and b.APPLICANTID=c.APPLICANTID   and a.VACANCYCODE=c.VACANCYCODE   and a.INSTITUTECODE=c.INSTITUTECODE AND A.COMPANYCODE=C.COMPANYCODE     AND A.INSTITUTECODE=C.INSTITUTECODE     AND a.institutecode = c.institutecode  and c.SHORTLISTSEQNO in (select LEVELNO FROM HR#SELECTIONLEVELS  where  INSTITUTECODE='"+mInst+"' AND  VACANCYCODE='" + mVacCode + "' AND SELECTIONBY LIKE '%HOD%'   ) ORDER BY a.applicantname";
        rs = db.getRowset(qry);
      //out.print(qry);
        while (rs.next())
        {
            slno++;
			mSHORTLISTSEQNO=rs.getInt("SHORTLISTSEQNO");
            mApplicantID = rs.getString("APPLICANTID").toString();
            mAppName = rs.getString("applicantname").toString().toUpperCase();
            mDOB = rs.getString("dateofbirth").toString();
            mAdd1 = rs.getString("CADDRESS1").toString().trim();
            mAdd2 = rs.getString("CADDRESS2").toString().trim();
            mAdd3 = rs.getString("CADDRESS3").toString().trim();
            mCity = rs.getString("ccity").toString().trim();
            mState = rs.getString("CSTATE").toString().trim();
            mDistrict = rs.getString("CDISTRICT").toString().trim();
			mStatus= rs.getString("STATUS").toString().trim();
							
			mShortSeq=mSHORTLISTSEQNO+1;
				qry1="SELECT  SHORTLISTSEQNO, STATUS,nvl(REMARKS,' ')REMARKS  FROM HR#APPLICANTSHORTLISTMASTER WHERE INSTITUTECODE='"+mInst+"' AND  VACANCYCODE='" + mVacCode + "' AND APPLICANTID ='"+mApplicantID+"' and SHORTLISTSEQNO= "+mShortSeq+" ";
				//out.print(qry1);
				rs1=db.getRowset(qry1);
				if(rs1.next())
				{
					mSelectedStatus=rs1.getString("STATUS").toString().trim();
					mRemarks=rs1.getString("REMARKS").toString().trim();
					if(mSelectedStatus.equals("S"))
							{
								mSelect="Selected";
							}
							else if(mSelectedStatus.equals("R"))
							{
								mReject="Selected";
							}
				}
				else
				{
					mRemarks="";
						if(mStatus.equals("S"))
							{
								mSelect="Selected";
							//	mReject=" ";
							}
							else if(mStatus.equals("R"))
							{
								mReject="Selected";
							}
				}
					

     %>
	 <input type="Hidden" name="ApplicationID<%=slno%>" id="ApplicationID<%=slno%>" value="<%=mApplicantID%>">
     <tr> <td>
             <select name="Status<%=slno%>" id="Status<%=slno%>"  onchange="return EnterRemarks('Status<%=slno%>','<%=slno%>')" >
				 <option value="S" <%=mSelect%> >Selected</option>
                 <option value="R" <%=mReject%> >Rejected</option>
             </select>
         </td>
			<%
			 mReject="";
			 mSelect="";
			%>
         <td  class="labelcell" nowrap>
             <%=mAppName%><br> <%=mDOB%>
         </td>
         <td class="labelcell">
             <%=mAdd1%>&nbsp;<%=mAdd2%>&nbsp;<%=mAdd3%><br>
             <%=mCity%>&nbsp;<%=mState%>&nbsp;<%=mDistrict%>
         </td>

             <td class="labelcell">
                 <table borderColor=#D98242 rules=group bottommargin=1 topmargin=0 cellspacing=0 cellpadding=2>
                     <tr>
                         <td class="labelcell" valign="top"><b>Degree&nbsp;&nbsp;</b></td>
                         <td class="labelcell" valign="top"><b>Institute<br>University
						 </b>&nbsp;&nbsp;&nbsp;</td>
                         <td class="labelcell" valign="top"><b>Year</b></td>
                     </tr>
<%
try{
String mQCode = "", mINSTITUTION= "", mYEAROFPASSING = "", mArea = "";
qry1 = " SELECT INSTITUTION,QUALIFICATIONCODE,QUALIFICATIONCATEGORYCODE, APPLICANTID, YEAROFPASSING, " +
"CGPA, AREAOFQUALIFICATION FROM HR#APPLICANTQUALIFICATION " +
"where APPLICANTID='" + mApplicantID + "'";
//out.print(qry1);
rs1 = db.getRowset(qry1);
while (rs1.next()) {
mQCode = rs1.getString("QUALIFICATIONCODE").toUpperCase();
mINSTITUTION = rs1.getString("INSTITUTION").toString();
mYEAROFPASSING = rs1.getString("YEAROFPASSING").toString();
mArea = rs1.getString("AREAOFQUALIFICATION").toString().toUpperCase();
%>
<tr>
<td nowrap class="labelcell"><%=mQCode%>-<%=rs1.getString("QUALIFICATIONCATEGORYCODE").toString()%></td>
<td class="labelcell"><%=mINSTITUTION%></td>
<td class="labelcell"><%=mYEAROFPASSING%></td>

</tr>
<%
}
}
catch(Exception e)
{
//out.print(e+"   12345");
}
%>
        </table>
    </td>
    <td>
        <table borderColor=#D98242 rules=group bottommargin=1 topmargin=0 cellspacing=4 cellpadding=2>
            <tr>

             
                <td class="labelcell" valign="top"><b>Designation&nbsp;&nbsp;</b></td>
				   <td class="labelcell" valign="top"><b>Institute<br>Company</b>&nbsp;</td>
                <td class="labelcell" valign="top"><b>Period<br>From</b>&nbsp;</td>
                <td class="labelcell" valign="top"><b>Period<br>To</b></td>
            </tr>
                     <%
            try{

            qry2 = "SELECT nvl(a.prevorganisation,' ')prevorganisation, " +
                    " nvl(a.postheld,' ')postheld, nvl(a.natureofjob,' ')natureofjob, " +
                    " to_char(FROMDATE,'DD-MM-YYYY')FROMDATE, to_char(TODATE,'dd-mm-yyyy')TODATE" +
                    " FROM hr#applicantexperience a WHERE applicantid = '" + mApplicantID + "'";
          // out.print(qry);
            rs2 = db.getRowset(qry2);
            while (rs2.next()) {
                mPrev = rs2.getString("prevorganisation").toUpperCase();
                mPostheld = rs2.getString("postheld").toString();
                mFROMDATE = rs2.getString("FROMDATE").toString();
                mTODATE = rs2.getString("TODATE").toString().toUpperCase();

                     %>
                     <tr>
                         <td class="labelcell"><%=mPostheld%></td>
                         <td class="labelcell"><%=mPrev%></td>
                         <td class="labelcell" nowrap><%=mFROMDATE%></td>
                         <td class="labelcell" nowrap><%=mTODATE%></td>
                     </tr>
                     <%
                     }

            }
            catch(Exception e)
                    {
                        out.print(e+"  Error");
                    }
                     %>
                 </table>

             </td>
             <td class="labelcell" nowrap>
                 <%
				 try{
                 String link="";
                 qry4="select nvl(CVFILENAME,'N')CVFILENAME  from HR#APPLICANTRESUME " +
                         "where APPLICANTID='" + mApplicantID + "'";
                         rs4=db.getRowset(qry4);
                         if(rs4.next())
                             {
                            link=rs4.getString("CVFILENAME").toString();
							//link="data/HOLIDAYS 2011.doc";
							//link=link.substring( link.lastIndexOf("/data")+1);
							//out.print(link.substring( link.lastIndexOf("/data/")+1));
							//out.print(link);
                                %>
                 
                 <a href="<%=link%>" title="C.V.<%=link%>" onClick="openWordDocPath('<%=link%>')" target=_new >View C.V.</a>
                 </td>

             <%
                           }
			   }
            catch(Exception e)
                    {
                        out.print(e+"  Error");
                    }
            
             qry3="select department from DEPARTMENTMASTER " +
                     "where departmentcode='"+mDeptCode+"'";
             rs3=db.getRowset(qry3);
             //out.print(qry3);
             if(rs3.next())
             {
                         %>
             <td class="labelcell"><%=rs3.getString("department").toString().toUpperCase()%></td>
             <%
             }
             %>
             
             <td>
                 <input name="DeptRemarks<%=slno%>" id="DeptRemarks<%=slno%>" style="width:150px" value="<%=mRemarks%>"  maxlength=200>
              </td>
			
			<td class="labelcell">
				<font color=red> <b><%=rs.getString("deptstatus")%>
            </td>
			<td class="labelcell">
				<%=rs.getString("deptremarks")%></font>
            </td>
         </tr>
         <%
        }
     %>
	 <tr>
	 <td>
	 <INPUT TYPE="submit" name="Submit" value="Submit">
	 </td>
	 </tr>
     </table>
	  <input type="Hidden" name="ShortlistSeq" id="ShortlistSeq" value="<%=mSHORTLISTSEQNO%>">
 <input type="Hidden" name="TotalCount" id="TotalCount" value="<%=slno%>">
 <input type="Hidden" name="VacancyCode" id="VacancyCode" value="<%=mVacCode%>">
 
 <input type="Hidden" name="Institute" id="Institute" value="<%=mInst%>">
  <input type="Hidden" name="CompanyCode" id="CompanyCode" value="<%=mComp%>">

 </form>
</body>
</html>
<%
        }


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

