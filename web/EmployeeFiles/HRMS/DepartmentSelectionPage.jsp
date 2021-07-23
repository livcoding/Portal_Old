<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%
        try {
            String mVacCode = "", mVacDesc = "";
			String mMemberID ="",mMemberType="",mMemberName="",mMemberCode="";
            String mInst="",mComp="",mDept="",mDESIGCODE="";
            

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
	<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
        <TITLE>#### <%=mHead%> [ DepartmentSelection ]</TITLE>
        <link  rel="stylesheet" type="text/css" href="css/style.css">

<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="js/jquery.searchabledropdown-1.0.8.min.js"></script>

 <script type="text/javascript">
 function getCurrentDateTime()
    {
        var currentDate;
        var retDateTime;
        currentDate = new Date();
        retDateTime=""+currentDate.getDate()+currentDate.getMonth()+currentDate.getFullYear()+currentDate.getHours()+currentDate.getMinutes();
        return retDateTime;
    }
    </script>
    
  <script type="text/javascript">
        //$(document).ready(function() {
        //$("select").searchable();
        //	});
        $(document).ready(function() {
            $("select").change(function(){
                $("#value").html(this.options[this.selectedIndex].text + " (VALUE: " + this.value + ")");

				       if(this.id=="Departmentcode"){
						  // alert($("#VaccCode").val());
                 $.get("getDesignation.jsp",{vacancy:$("select#VacancyCode").val(),departmentcode:$("select#Departmentcode").val(),dated:getCurrentDateTime()}, successfunction1);
              }
            });
        });

		function successfunction1(response)
        {
            if (response) {
                var x=response+"";

                if(x==""){}
                else{
                    var arrayOfStrings = x.split("~");

                    $("select#DESIGNATIONCODE").empty();
                    $('select#DESIGNATIONCODE').append("<option value=\"" + "" + "\">" +"<--Select-->"+ "</option>");
                    for(var i=0;i<arrayOfStrings.length-1;i++){
                        var t=arrayOfStrings[i].split("@");
                        $('select#DESIGNATIONCODE').append("<option value=\"" + t[0] + "\">" + t[1]+ "</option>");
                    }
                }
            }
        }

</script>


<script language="JavaScript" type ="text/javascript">

/*
 function un_checkAllSelect()
{
var mFlag=0;
 for (var i = 0; i < document.frm1.elements.length; i++) 
{
 var e = document.frm1.elements[i]; 
if ((e.name != 'AllSelect') && (e.type == 'radio') &&(e.value=='S')) 
{ 
e.checked = document.frm1.AllSelect.checked;
if (mFlag==0 && document.frm1.AllSelect.checked==true)
	{ 
	document.frm1.AllReject.checked=false;
	mFlag=1;
	}
 } } }


 function un_checkAllNotSelect()
{
var mFlag=0;
 for (var i = 0; i < document.frm1.elements.length; i++) 
{
 var e = document.frm1.elements[i]; 
if ((e.name != 'AllNotSelect') && (e.type == 'radio') &&(e.value=='N')) 
{ 
e.checked = document.frm1.AllNotSelect.checked;
if (mFlag==0 && document.frm1.AllNotSelect.checked==true)
	{ 
	document.frm1.AllReject.checked=false;
	mFlag=1;
	}
 } } }

 function un_checkAllReject()
{
var mFlag=0;
 for (var i = 0; i < document.frm1.elements.length; i++) 
{
 var e = document.frm1.elements[i]; 
if ((e.name != 'AllReject') && (e.type == 'radio') &&(e.value=='R')) 
{ 
e.checked = document.frm1.AllReject.checked;
if (mFlag==0 && document.frm1.AllReject.checked==true)
	{ 
	document.frm1.AllSelect.checked=false;
	mFlag=1;
	}
 } } }*/
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

			String mDMemberID ="",mDMemberCode ="",mDMemberType="",mRightID="255";
    
        int slno = 0,mSHORTLISTSEQNO=0,mShortSeq=0;
        String mAppName = "", mDOB = "", mAdd1 = "", mAdd2 = "", mAdd3 = "", mCity = "", mState = "", mDistrict = "", mApplicantID = "",mStatus="",mReject="",mSelect="",mSelectedStatus="",mRemarks="",mFinalShortList="";
		String mDisable="",mTabColor="",mDEPARTMENTCODE="";
	
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
            <tr><td align=center><h2>&nbsp;&nbsp; Initial ShortListing by Nominated Members &nbsp;&nbsp;</h2></td></tr>
			<tr><td align=center class="labelcell"><b>Name : <%=mMemberName%></td></tr>
        </table>
        <br>
        <form name="frm" method=post >
            <input type=hidden name="x" id="x">

		
		
		
		

       <table borderColor="#D98242" align=center rules=none topmargin=0 cellspacing=0 cellpadding=4  border=1 >
               
				
				<tr> 
                    <td align="left" class="labelcell"><br>
                       <strong>Vacancy&nbsp;&nbsp;
					</td>
					<td><br>
					<%
	    qry = "SELECT distinct COMPANYCODE, INSTITUTECODE, VACANCYCODE, VACANCYDESCRIPTION," +
            " FROMPERIOD, TOPERIOD, BROADCAST, CLOSED, CLOSINGDATE FROM HR#VACANCYMASTER" +
            " WHERE NVL(BROADCAST,'N')='Y' AND " +
            " VACANCYCODE in (       SELECT DISTINCT VACANCYCODE       " +
            "                          FROM hr#vacancydepartmentselection                   " +
            "             WHERE  GUESTID='"+mChkMemID+"')";
//	out.print("ssdsd"+qry);
	rs = db.getRowset(qry);

//out.print(qry);
	%>
                            <select name="VacancyCode" id="VacancyCode" tabindex=1>

                                <%



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
				 if(mVacCode.equals(request.getParameter("VacancyCode").toString().trim()))
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

	} %>
                            </select>
                       </strong>

					
                      &nbsp;&nbsp;  </td>
             
                    <td align=left class="labelcell"><br>
					<strong>Department &nbsp;&nbsp;
					</td>
					<td  class="labelcell"><br>
  
						<%
					
try {
qry = "select distinct departmentcode,department from DEPARTMENTMASTER where" +
" nvl(DEACTIVE,'N')='N' and   departmentcode in (select distinct DEPARTMENTCODE from " +
" HR#VACANCYDEPARTMENTSELECTION   where  GUESTID='"+mChkMemID+"' and VACANCYCODE IN " +
        "(SELECT DISTINCT VACANCYCODE FROM   HR#VACANCYMASTER WHERE  NVL(BROADCAST,'N')='Y')) " +
        "order by DEPARTMENT";
//out.print(qry);
rs = db.getRowset(qry);
							%>

      <select NAME="Departmentcode" ID="Departmentcode" >
          <option selected value="SELECT"><--Select Department--></option>
<%
	if(request.getParameter("x")==null)
{
while (rs.next())
{
mDEPARTMENTCODE = rs.getString("DEPARTMENTCODE").toString().trim();

%>
<option value="<%=mDEPARTMENTCODE%>"><%=rs.getString("Department")%>   </option>
<%
}
}
else
{
while (rs.next())
{
mDEPARTMENTCODE = rs.getString("DEPARTMENTCODE").toString().trim();

if(mDEPARTMENTCODE.equals(request.getParameter("Departmentcode").toString().trim()))
{
%>
<option selected value="<%=mDEPARTMENTCODE%>"><%=rs.getString("Department")%>  </option><%
}
else
{
%>
<option value="<%=mDEPARTMENTCODE%>"><%=rs.getString("Department")%>  </option><%

}

}

}
}
catch(Exception e)
	{

	}
	%>
              
</select>
                        </strong>
               </td>

       <td class="labelcell" align=left><b>
Designation<font color=red ><b>*</font>

&nbsp; &nbsp;

<%
//	qry = "select distinct departmentcode,department from DEPARTMENTMASTER where nvl(DEACTIVE,'N')='N' and  DEPARTMENTCODE in (select  DEPARTMENTCODE from HR#VacancyDepartmentTagging where VACANCYCODE='"+mVaccCode+"' )order by DEPARTMENT ";

qry="SELECT DISTINCT DESIGNATIONCODE DESIGCODE, DESIGNATIOn           FROM DESIGNATIONMASTER          WHERE NVL (deactive, 'N') = 'N'     " +
        "       AND DESIGNATIONCODE IN (SELECT DESIGNATIONCODE                                     FROM HR#VACANCYDEPDESIGTAGGING      " +
        "                               WHERE vacancycode in ( " +
        "(SELECT DISTINCT VACANCYCODE FROM   HR#VACANCYMASTER WHERE  NVL(BROADCAST,'N')='Y')) AND departmentcode IN (                   SELECT DISTINCT departmentcode                              FROM hr#vacancydepartmentselection                             WHERE guestid = '"+mChkMemID+"' )  ";

if(request.getParameter("Departmentcode")!=null)
		{
	qry=qry+"  and departmentcode='"+request.getParameter("Departmentcode")+"'  ";
		}

qry=qry+" )   ORDER BY DESIGNATION";
//out.print(qry);
	%>

<select  NAME="DESIGNATIONCODE"  ID="DESIGNATIONCODE" style="width:292px;">
<option selected value="SELECT"><--Select Designation--></option>



<%
try
        {

rs = db.getRowset(qry);

	if(request.getParameter("x")==null)
{
while (rs.next())
{
mDESIGCODE = rs.getString("DESIGCODE").toString().trim();

%>
<option value="<%=mDESIGCODE%>"><%=rs.getString("DESIGNATIOn")%>   </option>
<%
}
}
else
{
while (rs.next())
{
mDESIGCODE = rs.getString("DESIGCODE").toString().trim();

if(mDESIGCODE.equals(request.getParameter("DESIGNATIONCODE").toString().trim()))
{
%>
<option selected value="<%=mDESIGCODE%>"><%=rs.getString("DESIGNATIOn")%>  </option><%
}
else
{
%>
<option value="<%=mDESIGCODE%>"><%=rs.getString("DESIGNATIOn")%>  </option><%

}

}

}
}
catch(Exception e)
	{

	}




%>
</select>
</td>

</tr>


                <tr>


                <tr>
                    <td align=center colspan=6><br><input type=Submit style="background-color:#FFCF83" border= "3px" name=button id=button4 value="&nbsp; Click To View Detail &nbsp;"  ></br></td>
                </tr>
            </table>
			</form>
            <%
    if (request.getParameter("x") != null) {
        String mDeptCode = "",mShow="",mNotSelect="",mFinal="",mDesignation="";
		int mMaxSeq=0;
        mDeptCode = request.getParameter("Departmentcode").toString().trim();
		mVacCode= request.getParameter("VacancyCode").toString().trim();
		mDesignation= request.getParameter("DESIGNATIONCODE").toString().trim();


    qry = "SELECT distinct COMPANYCODE, INSTITUTECODE, VACANCYCODE, VACANCYDESCRIPTION," +
            " FROMPERIOD, TOPERIOD, BROADCAST, CLOSED, CLOSINGDATE FROM HR#VACANCYMASTER" +
            " WHERE NVL(BROADCAST,'N')='Y' and VACANCYCODE='"+mVacCode+"' AND " +
            "  VACANCYCODE in (       SELECT DISTINCT VACANCYCODE                       " +
            "          FROM hr#vacancydepartmentselection                    " +
            "            WHERE  GUESTID='"+mChkMemID+"' and DEPARTMENTCODE='"+mDeptCode+"' " +
            "and VACANCYCODE='"+mVacCode+"' )";
rs=db.getRowset(qry);
if(rs.next())
					{
mInst=rs.getString("INSTITUTECODE");
mComp=rs.getString("COMPANYCODE");
					}


int mTSelected=0 ;
		qry1="select count(c.applicantid)selected from   hr#applicantshortlistmaster c," +
                "  hr#applicationmaster a,hr#applicantaddress D where a.vacancycode in " +
                "(select vacancycode from HR#VACANCYMASTER WHERE a.vacancycode='"+mVacCode+"' " +
                "and institutecode='"+mInst+"' and NVL(BROADCAST,'N')='Y'  ) and a.DESIGNATIONCODE='"+mDesignation+"' and a.departmentcode ='"+mDeptCode+"'  " +
                "       and c.STATUS='S'   and  c.SHORTLISTSEQNO =2  and a.vacancycode ='"+mVacCode+"'   " +
                " AND a.applicantid = c.applicantid			and a.institutecode='"+mInst+"'" +
                " AND a.vacancycode = c.vacancycode AND a.institutecode = c.institutecode  AND " +
                "a.applicantid = D.applicantid AND C.applicantid = D.applicantid ";
		//out.print(qry1);
		rs1=db.getRowset(qry1);
		if(rs1.next())
			mTSelected=rs1.getInt("selected");
		else
			mTSelected=0;

//192.168.4.221   juet4guna

		int mTReject=0 ;
			qry2="select count(c.applicantid)reject from   hr#applicantshortlistmaster c," +
                    "  hr#applicationmaster a ,hr#applicantaddress D where a.vacancycode in (select " +
                    "vacancycode from HR#VACANCYMASTER WHERE a.vacancycode='"+mVacCode+"' and institutecode='"+mInst+"'" +
                    " and NVL(BROADCAST,'N')='Y'  ) and a.DESIGNATIONCODE='"+mDesignation+"' and a.departmentcode ='"+mDeptCode+"'         and nvl(c.STATUS,'N')='R'" +
                    "   and  c.SHORTLISTSEQNO =2  and a.vacancycode ='"+mVacCode+"'              AND a.applicantid = c.applicantid" +
                    "			and a.institutecode='"+mInst+"' AND a.vacancycode = c.vacancycode AND a.institutecode = c.institutecode " +
                    " AND a.applicantid = D.applicantid AND C.applicantid = D.applicantid ";
		rs1=db.getRowset(qry2);
		if(rs1.next())
			mTReject=rs1.getInt("reject");
		else
			mTReject=0;

	




		int mALLSum=0;
		qry2="select count(c.applicantid)AllResume from   hr#applicantshortlistmaster c, " +
                " hr#applicationmaster a ,hr#applicantaddress D where a.vacancycode in (select vacancycode" +
                " from HR#VACANCYMASTER WHERE institutecode='"+mInst+"' and NVL(BROADCAST,'N')='Y' )" +
                " and a.DESIGNATIONCODE='"+mDesignation+"' and a.departmentcode ='"+mDeptCode+"'         and  c.SHORTLISTSEQNO =1  and a.vacancycode ='"+mVacCode+"' " +
                "  AND a.applicantid = D.applicantid AND C.applicantid = D.applicantid AND a.applicantid = c.applicantid	" +
                "		and a.institutecode='"+mInst+"' AND a.vacancycode = c.vacancycode AND a.institutecode = c.institutecode";
		//out.print(qry2);
		rs1=db.getRowset(qry2);
		if(rs1.next())
			mALLSum=rs1.getInt("AllResume");
		else
			mALLSum=0;



			int mTNotProcess=0;
			qry2="select count(c.applicantid)mTNotProcess from   hr#applicantshortlistmaster c, " +
                    " hr#applicationmaster a,hr#applicantaddress D where a.vacancycode" +
                    " in (select vacancycode from HR#VACANCYMASTER WHERE a.vacancycode='"+mVacCode+"' " +
                    "and institutecode='"+mInst+"' and NVL(BROADCAST,'N')='Y'  ) and a.DESIGNATIONCODE='"+mDesignation+"' and a.departmentcode ='"+mDeptCode+"'    " +
                    "     and nvl(c.STATUS,'N')='N'   and  c.SHORTLISTSEQNO =2  and a.vacancycode ='"+mVacCode+"'          " +
                    "    AND a.applicantid = c.applicantid			and a.institutecode='"+mInst+"' AND a.vacancycode = c.vacancycode " +
                    "AND a.institutecode = c.institutecode  AND a.applicantid = D.applicantid AND C.applicantid = D.applicantid";
			//out.print(qry2);
		rs1=db.getRowset(qry2);
		if(rs1.next())
			mTNotProcess=rs1.getInt("mTNotProcess");
		else
			mTNotProcess=0;

		mTNotProcess=mALLSum-(mTReject+mTSelected);


		//int mTNotProcess=( Integer.parseInt(mALLSum) ) - (Integer.parseInt(mTSelected)+Integer.parseInt(mTReject));

		//out.print(Integer.parseInt((mTSelected+mTReject))+"mTNotProcess");
		%>
		<form>
		<table  border=1 width="50%" borderColor=#D98242 rules=group align=center  topmargin=0 cellspacing=0 cellpadding=8><br>
		
		  <tr bgcolor="#FFCF83">
		<td colspan=3 class="labelcell" align=center>
			<font  size=2>Institute  :  <%=mInst%>
		</td>
		</tr>

			 
			 <tr bgcolor="#FFCF83">
		<td colspan=3 class="labelcell" align=center>
			<font  size=2>Click respective link buttons to view Details.
		</td>
		</tr>

		<tr>
		<td class="labelcell" >
		<a href="DepartmentLinksPage.jsp?ShowStatus=ALL&amp;VacancyCode=<%=mVacCode%>&amp;DeptCode=<%=mDeptCode%>&amp;INSTITUTECODE=<%=mInst%>&amp;COMPANYCODE=<%=mComp%>&amp;DESCODE=<%=mDesignation%>"> <font  size=2><b>* Resumes to be reviewed </td><td> <%=mALLSum%> </td>
		</tr>
		
		<tr bgColor="lightgreen">
		<td class="labelcell">
		<a href="DepartmentLinksPage.jsp?ShowStatus=S&amp;VacancyCode=<%=mVacCode%>&amp;DeptCode=<%=mDeptCode%>&amp;INSTITUTECODE=<%=mInst%>&amp;COMPANYCODE=<%=mComp%>&amp;DESCODE=<%=mDesignation%>"> 	<font color=green size=2><b>* Resumes Shortlisted  </a></td><td> <%=mTSelected%> </td>
		</tr>

		<tr bgColor="pink">
		<td class="labelcell">
		<a href="DepartmentLinksPage.jsp?ShowStatus=R&amp;VacancyCode=<%=mVacCode%>&amp;DeptCode=<%=mDeptCode%>&amp;INSTITUTECODE=<%=mInst%>&amp;COMPANYCODE=<%=mComp%>&amp;DESCODE=<%=mDesignation%>"><font color=red size=2><b>* Resumes Not Shortlisted </a> </td><td> <%=mTReject%> 		</td>
		</tr>
	
		
		<tr bgColor="white">
		<td class="labelcell">
		<a href="DepartmentLinksPage.jsp?ShowStatus=N&amp;VacancyCode=<%=mVacCode%>&amp;DeptCode=<%=mDeptCode%>&amp;INSTITUTECODE=<%=mInst%>&amp;COMPANYCODE=<%=mComp%>&amp;DESCODE=<%=mDesignation%>">	<font color=blue size=2><b>* Resume Yet to be Processed  </a></td><td> <%=mTNotProcess%> 		</td>
		</tr>
		</table>
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

