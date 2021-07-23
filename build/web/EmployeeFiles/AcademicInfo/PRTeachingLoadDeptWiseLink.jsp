

<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
ResultSet rs=null,rs1=null,rs2=null,rs3=null,rs5=null,rsc=null,rsl=null,rsm=null;

String mMemberID="",mDMemberID="",qry1="",mNameLML="",mvalue="",qrym="",mDept2="";
String mMemberName="",mProgramcode="";
String mMemberType="",mDMemberType="",mStudcnt="",mDis="",moldMerge="",moldMerge1="";
String mHead="",mOldEmp="",moldemp1="",mNameLMR="";
String mDMemberCode="",mMemberCode="",mFac="",mfac="",QryEleCode="";
String mInst="",mSection="",mSubsection="",mBasket="",mOfac="",mprogc="";
String qry="",Type="",mltp="",QrySemType="",mEmpid="",memp="",mName1="",mName2="";
String mName3="",mName4="",mName5="",mName6="",mComp="";
String mType="",mLTP="",mSubj="",mFaculty="",QryFaculty="",QryDept="",QryExam="",mSname="",mSeccount="",mPrCode="";
String mEmpIdv="", mMName5="", mMName6="";
String mFacv="",mTyp="",mEmpTyp="",mcmp="",mEcmp="",mDuration="",mClass="",mSendhod="";
String mMult="", mCapSubmit="Check to Save Load";
String [] mMultiFaculty=new String [1000];

String [] multiFac=(String [])session.getAttribute("MultiCumAddlFaculty");
int TotalFaculty=0;
int mL1=0, mT1=0, mP1=0, mlt1=0, mFlag=0, mFlag1=0, mFlag11=0, mFlag111=0, CTR=0, ctr=0, x=0, msno=0;
int mL=0,mT=0,mP=0,mlt=0, mTotGlFac=0;
double mAssigned=0,mMin=0,mMax=0,mexcludeassign=0 ;
double mAssignedload=0,mMinload=0,mMaxload=0;
String LOADID="";

if (session.getAttribute("CompanyCode")==null)
	mComp="";
else
	mComp=session.getAttribute("CompanyCode").toString().trim();

if (session.getAttribute("InstituteCode")==null)
	mInst="";
else
	mInst=session.getAttribute("InstituteCode").toString().trim();




if (session.getAttribute("MemberID")==null)
	mMemberID="";
else
	mMemberID=session.getAttribute("MemberID").toString().trim();

if (session.getAttribute("MemberType")==null)
	mMemberType="";
else
	mMemberType=session.getAttribute("MemberType").toString().trim();

if (session.getAttribute("MemberCode")==null)
	mMemberCode="";
else
	mMemberCode=session.getAttribute("MemberCode").toString().trim();

if (session.getAttribute("MemberName")==null)
	mMemberName="";
else
	mMemberName=session.getAttribute("MemberName").toString().trim();

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";

if (session.getAttribute("TotalInGlobalMultiFac")==null)
	mTotGlFac=0;
else
	mTotGlFac=Integer.parseInt(session.getAttribute("TotalInGlobalMultiFac").toString().trim());


//out.print(mMemberID+"FFFFFf");
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [Teaching Load Department Wise] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<script language="JavaScript" type ="text/javascript">
<!--
  if (top != self) top.document.title = document.title;
-->
</script>
<script language=javascript>


function RefreshContents()
{
	document.frm1.x.value='ddd';
    	document.frm1.submit();
}
function submitForm()
{
	if(document.frm1.save.value=='Draft Save')
	{
		var mChoice=confirm('This will save all the changes made by you. Is it OK to continue...');
		if(mChoice)
		{
			document.frm1.action = "PRLoadDistributionByHODSaveAction.jsp";
			document.frm1.submit();
		}
		else
		{
			document.frm1.action = "";
		}
	}
	else
	{
		document.frm1.action = "";
		//document.frm1.submit();
	}
}

</script>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor='#fce9c5' rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
try
{

//	out.print(mMemberID+"SDFSFSDF"+mMemberCode+mMemberName);
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

		String QrySubjID="", mProjSubj="";
		String mEle="";
		String qrye="",sc="";
		ResultSet rse=null;
  //-----------------------------
  //-- Enable Security Page Level
  //-----------------------------
		qry="Select WEBKIOSK.ShowLink('56','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if(RsChk.next() && RsChk.getString("SL").equals("Y"))
		{
  //----------------------

//out.print(((String [])session.getAttribute("MultiCumAddlFaculty"))[0]);%><br><%
//out.print(((String [])session.getAttribute("MultiCumAddlFaculty"))[1]);


if (request.getParameter("PROJSUBJ")==null)
{
	mProjSubj="N";
}
else
{
	mProjSubj=request.getParameter("PROJSUBJ").toString().trim();
}

if (request.getParameter("SUBJID")==null)
{
	QrySubjID="";
}
else
{
	QrySubjID=request.getParameter("SUBJID").toString().trim();
}
//out.print(QrySubjID+"QRY sds PRO "+mProjSubj);
if (request.getParameter("SUBJ")==null)
{
	mSubj="";
}
else
{
	mSubj=request.getParameter("SUBJ").toString().trim();
	//out.println(mSubj);
}
if (request.getParameter("TYPE")==null)
{
	mType="";
}
else
{
	mType=request.getParameter("TYPE").toString().trim();
}
if (request.getParameter("DEPT")==null)
{
	QryDept="";
}
else
{
	QryDept=request.getParameter("DEPT").toString().trim();
}

if (request.getParameter("ELECTIVECODE")==null || request.getParameter("ELECTIVECODE").equals("null"))
{
	QryEleCode="";
}
else
{
	QryEleCode=request.getParameter("ELECTIVECODE").toString().trim();
}

if (request.getParameter("LTP")==null)
{
	mLTP="";
}
else
{
	mLTP=request.getParameter("LTP").toString().trim();
}
if (request.getParameter("ELE")==null)
{
	mEle="";
}
else
{
	mEle=request.getParameter("ELE").toString().trim();
}
if (request.getParameter("BASKET")==null)
{
	mBasket="";
}
else
{
	mBasket=request.getParameter("BASKET").toString().trim();
}

if (request.getParameter("EXAM")==null)
{
	QryExam="";
}
else
{
	QryExam=request.getParameter("EXAM").toString().trim();
}
if (request.getParameter("SEM")==null)
{
	QrySemType="";
}
else
{
	QrySemType=request.getParameter("SEM").toString().trim();
}

if (request.getParameter("Total")==null)
{
	TotalFaculty=0;
}
else
{
    TotalFaculty=Integer.parseInt(request.getParameter("Total").toString().trim());
}

if (request.getParameter("LOADID")==null)
{
	LOADID="";
}
else
{
	LOADID=request.getParameter("LOADID").toString().trim();
}
//out.print("SDFSDF"+TotalFaculty+"LOADID"+LOADID+"QryDept"+QryDept);

qry="select subject from subjectmaster where INSTITUTECODE='"+mInst+"' AND SUBJECTID='"+QrySubjID+"' ";
rs=db.getRowset(qry);
if(rs.next())
mSname=rs.getString(1);
mSname=gb.toTtitleCase(mSname);
if(mType.equals("C"))
  Type="Core";
else if(mType.equals("E"))
 Type="Elective";
else
 Type="Free Elective";

try
{
	qry1=" select nvl(LHOURS,0)L,nvl(THOURS,0)T,nvl(PHOURS,0)P, ";
	qry1+=" nvl(LCLASSES,0)L1,nvl(TCLASSES,0)T1,nvl(PCLASSES,0)P1 from SUBJECTWISELTPHOURS where ";
	qry1+=" institutecode='"+mInst+"' and EXAMCODE='"+QryExam+"' and ";
	qry1+=" SUBJECTID='"+QrySubjID+"' and BASKET='"+mBasket+"'  ";
	qry1+=" and NVL(DEACTIVE,'N')='N' ";

//	out.println(qry1);
	rsl=db.getRowset(qry1);


	if(rsl.next())
	{
		  mL1=rsl.getInt("L");
		  mT1=rsl.getInt("T");
		  mP1=rsl.getInt("P");

		  mL=rsl.getInt("L1");
		  mT=rsl.getInt("T1");
		  mP=rsl.getInt("P1");

		if(mLTP.equals("L"))
		{
		  mltp="Lecture";
		  mlt=mL;
		  mlt1=mL1;
		}
		else if(mLTP.equals("T"))
		{
		 mltp="Tutorial";
		 mlt=mT;
		 mlt1=mT1;
		}
		else
		{
		 mltp="Practical";
		 mlt=mP;
		 mlt1=mP1;
		}

	}
else
{

if(mType.equals("C"))
{
  qry="select nvl(L,0)L,nvl(T,0)T,nvl(P,0)P from programsubjecttagging where institutecode='"+mInst+"'  and SUBJECTID='"+QrySubjID+"' and examcode='"+QryExam+"' ";
  qry+=" and nvl(deactive,'N')='N' ";
  //out.println(qry);
  rs=db.getRowset(qry);
  if(rs.next())
  {
  mL=rs.getInt("L");
  mT=rs.getInt("T");
  mP=(int)(rs.getInt("P")/2);

  mL1=rs.getInt("L");
  mT1=rs.getInt("T");
  mP1=rs.getInt("P");

  }
}
else if(mType.equals("E"))
{
  qry="select nvl(L,0)L,nvl(T,0)T,nvl(P,0)P from PR#ELECTIVESUBJECTS where institutecode='"+mInst+"' and examcode='"+QryExam+"' and SUBJECTID='"+QrySubjID+"' ";
  qry+=" and nvl(deactive,'N')='N' ";
  rs=db.getRowset(qry);
  if(rs.next())
  {
  mL=rs.getInt("L");
  mT=rs.getInt("T");
  mP=(int)(rs.getInt("P")/2);

  mL1=rs.getInt("L");
  mT1=rs.getInt("T");
  mP1=rs.getInt("P");
  }
}
else
{
  qry="select nvl(L,0)L,nvl(T,0)T,nvl(P,0)P from FREEELECTIVE where institutecode='"+mInst+"' and examcode='"+QryExam+"' and SUBJECTID='"+QrySubjID+"' ";
  qry+=" and nvl(deactive,'N')='N' ";
  rs=db.getRowset(qry);
  if(rs.next())
  {
  mL=rs.getInt("L");
  mT=rs.getInt("T");
  mP=(int)(rs.getInt("P")/2);

  mL1=rs.getInt("L");
  mT1=rs.getInt("T");
  mP1=rs.getInt("P");
 }
}

if(mLTP.equals("L"))
{
  mltp="Lecture";
  mlt=mL;
  mlt1=1;
}
else if(mLTP.equals("T"))
{
 mltp="Tutorial";
 mlt=mT;
 mlt1=1;
}
else
{
 mltp="Practical";
 mlt=mP;
 mlt1=2;
}

} // closing of else
}
catch(Exception e)
{
}

%>
<!--<form name="frm1" method="post" action="PRLoadDistributionHODSaveAction.jsp" >-->
<form name="frm1" method="post">
<input type=hidden name="xx">

<table id=id1 width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD  align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana"><B>Teaching Load to Faculty<B></TD>
</font></td></tr>
</TABLE>
<table cellpadding=1 cellspacing=1  align=center rules=rows   border=1>
<tr><td align=left >
<%
String mProject="";
if(mProjSubj.equals("Y"))
	mProject=" <FONT COLOR=NAVY><B>[Project Subject]</B></FONT>";
%>
<font face=verdana color=black size=3><b>Teaching Load Subject : &nbsp;<%=mSname%>&nbsp;(<%=mSubj%>) - <%=Type%> </b>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<font face=verdana color=black size=3><b>LTP : </b>&nbsp;<b><%=mltp%></b></Font> <%=mProject%> &nbsp; &nbsp;
</td></tr>

<tr><td align=left >
<font face=verdana color=black size=2><b>Staff From :

<%
String qryu="select Department from departmentmaster where departmentcode='"+QryDept+"' and nvl(deactive,'N')='N'";
ResultSet rssss= db.getRowset(qryu);
if(rssss.next())
	mDept2=rssss.getString("Department");

String mCheck1="",mCheck="";
//out.print(request.getParameter("SELFDEPT") +"sdsd"+request.getParameter("DEPTNAME"));
if(request.getParameter("SELFDEPT")!=null)
	mCheck="checked";
else if(request.getParameter("DEPTNAME")!=null)
	mCheck1="checked";


%>

&nbsp;<input type="checkbox" <%=mCheck%> name="SELFDEPT" id="SELFDEPT" value="<%=QryDept%>" >
<%=mDept2%>

<br>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;&nbsp; &nbsp;
    <input type="checkbox" <%=mCheck1%> name="DEPTNAME" id="DEPTNAME" value="ALL">  ALL DEPARTMENTS
 </b>

    </font>


</td>
</tr>
<tr>
<td>
<font face=verdana color=black size=2><b>Exam Code :
<%=QryExam%></b></Font>
&nbsp;&nbsp;
<font face=verdana color=black size=2><b>Semester Type :
<%=QrySemType%></b></Font>
</td>

</tr>

<tr><td align=left nowrap>
<font face=verdana color=black size=2><b>Class Duration : </b></Font>
<input readonly type=text name=Dura id=Dura value='<%=mlt1%>' style="background-color:#C6D6FD; color:black; font-weight:normal; text-align:right" maxlength=3 size=1>hrs
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
 <font face=verdana color=black size=2><b>No. of Class in a Week : </b><input readonly type=text name=Class1 id=Class1 value='<%=mlt%>' style="background-color:#C6D6FD; color:black; font-weight:normal; text-align:right" maxlength=3 size=1>days
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
</td>

</tr>

<tr>
    <td colspan="2" align="center">
        <input type="submit" name="submit" value="Submit" id="submit">
    </td>
</tr>

</table>
</form>

<%
//out.print("sssss"+LOADID);
if(request.getParameter("xx")!=null)
    {

String     mDEPT="",mEmpID="";



//out.print("SDFJASLDFKL"+LOADID);

%>
<form name="frm2" method="post">
    <input id="y" name="y" type=hidden>
		<input id="xx" name="xx" type=hidden>
<%
if(request.getParameter("DEPTNAME")!=null)
	{
		mDEPT=request.getParameter("DEPTNAME");
			%>
			<input type=hidden	 name=DEPTNAME ID=DEPTNAME value="<%=mDEPT%>">
			<%
	}
else if(request.getParameter("SELFDEPT")!=null)
	{
	mDEPT=request.getParameter("SELFDEPT");
	%>
	<input type=hidden name=SELFDEPT ID=SELFDEPT value="<%=mDEPT%>">
	<%
	}
	%>



<!-- <input type=hidden name=TotalFaculty ID=TotalFaculty value="<%=TotalFaculty%>"> -->
<TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=2 cellPadding=2  border=1 rules=groups>
<thead>
<tr bgcolor="#ff8c00">
<td nowrap  ><b><font face=verdana size=2 color=white>Sr.No.</font><b></td>
<td nowrap  ><b><font face=verdana size=2 color=white>Load ID</font><b></td>

<td nowrap ><b><font face=verdana size=2 color=white>Faculty Name</font><b></td>
<td nowrap><b><font face=verdana size=2 color=white>SessionAssigned</font><b></td>

</tr>
</THEAD>
<TBODY>
    <% String mSESSASS="";
    for(int i=1 ;i<=TotalFaculty;i++)
        {
      mName4="EMPSELECT"+String.valueOf(i);



           if(request.getParameter("SessionAssign"+i)==null)
            {
                mSESSASS=" ";
            }
            else
            {
                mSESSASS=request.getParameter("SessionAssign"+i);

            }

        %>
        <tr bgcolor="white">
		<td align=right><%=i%>. &nbsp; </td>
		<td align=center><%=LOADID%> </td>
        <td nowrap>

           <%
         qry="SELECT EMPLOYEEID, EMPLOYEECODE, EMPLOYEENAME FROM V#STAFF A WHERE A.COMPANYCODE='"+mComp+"' " +
        " and A.DEPARTMENTCODE =decode ('"+mDEPT+"','ALL',A.DEPARTMENTCODE,'"+mDEPT+"')  " +
         " AND NVL(DEACTIVE,'N')='N' order by a.EMPLOYEENAME";
     //    out.print(qry);
          rs=db.getRowset(qry);

         %>
         <select name="<%=mName4%>" id="<%=mName4%>"  >
         <%

		 if (request.getParameter("y")==null)
		 {

         while(rs.next())
         {
             mEmpID=rs.getString("EMPLOYEEID");

			 //System.out.println(mEmpID+"hghasg"+request.getParameter("EMPSELECT"+i));
          %>
          <option value="<%=rs.getString("EMPLOYEEID")%>" >
          <%=rs.getString("EMPLOYEENAME")%>--<%=rs.getString("EMPLOYEECODE")%>
          </option>

           <%
           }
         }
          else
         {

              while(rs.next())
                {
                    mEmpID=rs.getString("EMPLOYEEID");


                  if(mEmpID.equals(request.getParameter("EMPSELECT"+i).toString().trim()))
                      {
                  %>
                  <option selected value="<%=rs.getString("EMPLOYEEID")%>" >
                  <%=rs.getString("EMPLOYEENAME")%>--<%=rs.getString("EMPLOYEECODE")%>
                  </option>

                   <%
                   }
                  else
					{
					%>
					 <OPTION Value ="<%=rs.getString("EMPLOYEEID")%>">
                         <%=rs.getString("EMPLOYEENAME")%>--<%=rs.getString("EMPLOYEECODE")%></option>
					<%
					}
               }
         }
            %>

             </td>


            <td nowrap><input type="text" name="SessionAssign<%=i%>" id="SessionAssign<%=i%>"
            value="<%=mSESSASS%>"></td>
            <%
        }

        %>
</TBODY>
<BR>





<input type=hidden name=INSTITUTE ID=INSTITUTE value=<%=mInst%>>

<input type=hidden name=SUBJID ID=SUBJID value=<%=QrySubjID%>>
<input type=hidden name=SUBJECT ID=SUBJECT value=<%=mSubj%>>

</table>


<table align="center" >
    <tr>
        <td>
            <input type="submit" value="Save" name="submit">
        </td>
    </tr>
</table>
</form>

<form name="frmm" >
<%



if(request.getParameter("y")!=null)
    {
    String  mFacultyID="",mFACULTYNAME="" ,mSESSIONASS="";
    int mTotalFaculty=0;
// out.print("lllllsdfsdf"+TotalFaculty);

if (request.getParameter("LOADID")==null)
{
	LOADID="";
}
else
{
	LOADID=request.getParameter("LOADID").toString().trim();
}

    for(int yy=1 ;yy<=TotalFaculty;yy++)
        {
                    if(request.getParameter("EMPSELECT"+yy)==null)
                {
                    mFacultyID="N";
                }
                else
                {
                    mFacultyID=request.getParameter("EMPSELECT"+yy);
                }


                  if(request.getParameter("SessionAssign"+yy)==null)
            {
                mSESSIONASS="N";
            }
            else
            {
                mSESSIONASS=request.getParameter("SessionAssign"+yy);

            }

            %><input type=hidden name=LOADID ID=LOADID value=<%=LOADID%>>
            <input type="hidden" name="<%="SessionAssign"+yy%>" id="<%="SessionAssign"+yy%>" value="<%=mSESSIONASS%>">

        <input type="hidden" name="<%="EMPSELECT"+yy%>" id="<%="EMPSELECT"+yy%>" value="<%=mFacultyID%>">
            <%
//out.print(mFacultyID+"mFACULTYCODE--mSESSIONASS"+mSESSIONASS);
             if(!mFacultyID.equals("")  && !mSESSIONASS.equals(""))
             {

                qry="select 'Y' from FACULTYload  where  INSTITUTECODE='"+mInst+"' and " +
                        " LOADID='"+LOADID+"' and  EMPLOYEEID='"+mFacultyID+"' ";
                     rs=db.getRowset(qry);
                     if(!rs.next())
                         {
                              qry1="  INSERT INTO FACULTYload (   INSTITUTECODE, LOADID, SLNO," +
                                    " FACULTYTYPE, EMPLOYEEID, SESSIONASSIGNED,    ENTRYBY, ENTRYDATE)" +
                                    " VALUES ( '"+mInst+"','"+LOADID+"' ,'"+yy+"' ,'I','"+mFacultyID+"' ," +
                                    "'"+mSESSIONASS+"' ,'"+mChkMemID+"' ,SYSDATE ) ";
                           // out.print(qry1);
                            int j=db.insertRow(qry1);
                            if(j>0)
							 {
								mFlag=1;
								//    out.print("<center> <font face=verdana size=2 color=green ><b> Record Saved Successfully</b></font></center> ");
							 }
                               else
							 {
								   mFlag=0;
								   // out.print("<center> <font face=verdana size=2 color=red ><b> Error in Saving</b></font></center> ");
							 }


                           }
                     else
                         {
                        // out.print("<center> <font face=verdana size=2 color=green ><b> Record Already Saved</b></font></center> ");
                         }

                     qry1="select 'Y' FROM SUBJECTload WHERE INSTITUTECODE='"+mInst+"' and " +
                        " LOADID='"+LOADID+"' AND EXAMCODE='"+QryExam+"'  AND SUBJECTID='"+QrySubjID+"' ";
                    // out.print(qry1);
                     rs1=db.getRowset(qry1);
                     if(rs1.next())
                         {
                            String qryupdate="UPDATE SUBJECTload SET  " +
                                    "       TOTALSET             =  1," +
                                    "       NOOFFACULTYINEACHSET = "+TotalFaculty+"," +
                                    "       TOTALFACULTYUSED     = "+TotalFaculty+" , ENTRYDATE=SYSDATE " +
                                   "        WHERE INSTITUTECODE = '"+mInst+"' AND " +
                                    "       LOADID               = '"+LOADID+"' AND " +
                                    "       EXAMCODE             = '"+QryExam+"' AND " +
                                    "       SUBJECTID            = '"+QrySubjID+"'  ";
					//	out.print(qryupdate);
                            int q=db.update(qryupdate);

                         }



              }

        }
			if(mFlag==1)
				 {
					 out.print("<center> <font face=verdana size=2 color=green ><b> Record Saved Successfully</b></font></center> ");
				 }
				 else if(mFlag==0)
				 {
					//out.print("<center> <font face=verdana size=2 color=red ><b> Error in Saving</b></font></center> ");
				 }

    %>
    <TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=2 cellPadding=2  border=1 rules=groups>
<thead>
<tr bgcolor="#ff8c00">
<td nowrap  ><b><font face=verdana size=2 color=white>Sr.No.</font><b></td>
<td nowrap  ><b><font face=verdana size=2 color=white>Load ID</font><b></td>

<td nowrap ><b><font face=verdana size=2 color=white>Faculty Name</font><b></td>
<td nowrap><b><font face=verdana size=2 color=white>SessionAssigned</font><b></td>

</tr>
</THEAD>
<TBODY>
    <%
      qry="select nvl(A.SLNO,0)SLNO,nvl(A.LOADID,' ')LOADID, nvl(B.EMPLOYEECODE,' ')EMPLOYEECODE " +
       " ,nvl(B.EMPLOYEENAME,' ')EMPLOYEENAME  , nvl(A.SESSIONASSIGNED,0)SESSIONASSIGNED" +
        " from FACULTYload A ,EMPLOYEEMASTER B where  A.INSTITUTECODE='"+mInst+"'" +
        " and A.LOADID='"+LOADID+"' AND A.EMPLOYEEID=B.EMPLOYEEID AND NVL(B.DEACTIVE,'N')='N'" +
        " AND B.COMPANYCODE='"+mComp+"' order by SLNO ";
       // out.print(qry);
                            rs=db.getRowset(qry);
                     while(rs.next())
                         {
                        //out.print(rs.getInt("SLNO")+"KKK");
                         %>
                         <tr>
                         <td><font face="verdana" size="2"><%=rs.getInt("SLNO")%></font> </td>
                         <td><font face="verdana" size="2"><%=rs.getString("LOADID")%></font> </td>
                         <td><font face="verdana" size="2"><%=rs.getString("EMPLOYEENAME")%>(<%=rs.getString("EMPLOYEECODE")%>)</font> </td>
                         <td><font face="verdana" size="2"><%=rs.getInt("SESSIONASSIGNED")%></font> </td>
                         </tr>
                         <%
                         }
    %>
</TBODY>
    </TABLE>

    <%
/*
INSERT INTO FACULTYLOAD (
   INSTITUTECODE, LOADID, SLNO,
   FACULTYTYPE, EMPLOYEEID, SESSIONASSIGNED,
   DEACTIVE, ENTRYBY, ENTRYDATE)
VALUES ( , , ,
    , , ,
    , , )*/

}//c
}//xx
//-----------------------------
//---Enable Security Page Level
//-----------------------------
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
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='verdana' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}

}
catch(Exception e)
{
//	out.println(e);
}
%>
</form>
</body>
</html>