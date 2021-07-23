<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.*,java.io.*" %>
<%
        String qry = "",qry1 = "", mWebEmail = "";
        DBHandler db = new DBHandler();
        OLTEncryption enc = new OLTEncryption();
        GlobalFunctions gb = new GlobalFunctions();
        ResultSet rs = null,rs1 = null, Rs = null;
        String mMemberID = "", mMemberType = "", mMemberCode = "", mCurDate = "";
        String mEmpName = "", mWorkDt = "", mCompCode = "", mInst = "", mEID = "";
        String LoginIDTime = "", mDeptCode = "", mRightsID = "253", mSRCType = "";
        String mRecipient = "", mFromDatabase = "", mRecipientId = "",mAYear="";
        String mAcademicYear = "", mProgram = "", mBranch = "", mSectd = "",mProgramBranch="";
		String QryProgram="",QryBranch="",CProgram="",CBranch="",stemail ="",mColor="Black";
		String mPrograms1[] = new String [1000];
		String mAcademicList[] = new String [1000];
		String mStudentEmail="";
		 int pos=0,len=0;
        int count = 0;
		int ctr=0,flag=0,Flag1=0,Flag2=0;
        try {
            if (session.getAttribute("MemberCode") == null) {
                mMemberCode = "";
            } else {
                mMemberCode = session.getAttribute("MemberCode").toString().trim();
            }
            if (session.getAttribute("CompanyCode") == null) {
                mCompCode = "";
            } else {
                mCompCode = session.getAttribute("CompanyCode").toString().trim();
            }

            if (session.getAttribute("MemberID") == null) {
                mMemberID = "";
            } else {
                mMemberID = session.getAttribute("MemberID").toString().trim();
            }

            if (session.getAttribute("MemberType") == null) {
                mMemberType = "";
            } else {
                mMemberType = session.getAttribute("MemberType").toString().trim();
            }
            if (session.getAttribute("InstituteCode") == null) {
                mInst = "";
            } else {
                mInst = session.getAttribute("InstituteCode").toString().trim();
            }

            if (session.getAttribute("DepartmentCode") == null) {
                mDeptCode = "";
            } else {
                mDeptCode = session.getAttribute("DepartmentCode").toString().trim();
            }

            if (request.getParameter("SRCType") == null) {
                mSRCType = "";
            } else {
                mSRCType = request.getParameter("SRCType").toString().trim();
            }

            /*if(mSRCType.equals("A"))
            {
            mRightsID="190";
            }
            else if(mSRCType.equals("H"))
            {
            mRightsID="206";
            }*/
            String mHead = "";
            if (session.getAttribute("PageHeading") != null && !session.getAttribute("PageHeading").equals("")) {
                mHead = session.getAttribute("PageHeading").toString().trim();
            } else {
                mHead = "JIIT ";
            }
%>
<HTML>
<head>
    <TITLE>#### <%=mHead%> [ Student Lists] </TITLE>
	<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
    <script type="text/javascript" src="js/sortabletable.js"></script>
	<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

 <script language="JavaScript" >

function Check()
{
//alert('fdfds'+document.frm.SubSection.value);
	if(document.frm.academicyear.value==null || document.frm.academicyear.value=="")
	{
		alert("Please Select AcademicYear !");
		
		return false;
	}
	if(document.frm.program.value==null || document.frm.program.value=="")
	{
		alert("Please Select Program-Branch !");
		
		return false;
	}

	

}
 </script>
	  </head>
<body  topmargin=4 rightmargin=0 leftmargin=0 bottommargin=0 bgColor="#fce9c5" >
<%
    if (!mMemberID.equals("") || !mMemberCode.equals("")) {
        mMemberID = enc.decode(mMemberID);
        mMemberCode = enc.decode(mMemberCode);

        String mChkMemID = enc.decode(session.getAttribute("MemberID").toString().trim());
        String mChkMType = enc.decode(session.getAttribute("MemberType").toString().trim());
        String mIPAddress = session.getAttribute("IPADD").toString().trim();
        String mRole = enc.decode(session.getAttribute("ROLENAME").toString().trim());
        ResultSet RsChk = null;


        //-----------------------------
        //-- Enable Security Page Level
        //-----------------------------
        qry = "Select WEBKIOSK.ShowLink('" + mRightsID + "','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";
        RsChk = db.getRowset(qry);
        if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{

	   try {

		   %>
<form name="frm"  method="post">
<input type="hidden" name="x" id="x" />
		<table id=id1 width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
			<tr><TD align=middle><font color="#a52a2a" size=4 face=verdana><b><u> Student List </u></B></font></TD>
			</font></td></tr>
		</TABLE>
 <table cellspacing=0 cellpadding=0   border=1 rules=groups width=100% >
              
				<tr >
                <td colspan="3" nowrap><font color="#a52a2a" face=Verdana size=2><STRONG>Select Students on AcademicYear/Program/Branch basis)</STRONG></font></td></tr>
				<tr>
					<td> <font face=verdana size=2 ><b>Institute : <%=mInst%></b> &nbsp;&nbsp;&nbsp;<font color=black face=Verdana size=2><STRONG>&nbsp;Academic Year:</STRONG></font></font></td>
				
                    <td nowrap >
                            <%
							 qry = "select distinct nvl(ACADEMICYEAR,' ') ACADEMICYEAR from ACADEMICYEARMASTER where nvl(deactive,'N')='N' order by ACADEMICYEAR";
						    rs = db.getRowset(qry);

							if (request.getParameter("x")==null ) 
							{	
                       	
                            %>
                            <select  multiple name="academicyear" Style="WIDTH:80px ; height:100px">
                                <%
								while (rs.next())
								{
                                %>
                                <option value="<%=rs.getString("ACADEMICYEAR")%>"><%=rs.getString("ACADEMICYEAR")%></option>
                                <%
								}
								%>
                            </select>
							<%
							}
							else
							{
								%>
                            <select name="academicyear" Style="WIDTH:80px ; height:100px" multiple>
						<%

							while(rs.next())
							{
								 mAYear=rs.getString("academicyear");			

									mAcademicList= request.getParameterValues("academicyear");
						

								for(int i=0;i<mAcademicList.length;i++)
								{			
										 if(mAcademicList[i]==null)
										{

										}
										else	if(mAcademicList[i].equals(mAYear))
										{
											//System.out.println("adsfasdf");
											%>
											<OPTION selected Value="<%=mAYear%>"><%=mAYear%></option>
											<%
											Flag2=1;													
										}
								}
										if(Flag2==0)
										{
											%>
													<OPTION  Value="<%=mAYear%>"><%=mAYear%></option>
													<%
										}

								Flag2=0;
							}
							}
									%>
                </font></td></tr>
				 <TR>
               <td nowrap align=right><font color=black face=Verdana size=2><STRONG>Program-Branch:&nbsp; </STRONG></font></td>
                    <td  nowrap><font color=black face=Verdana size=2>
                            <%
            qry = "select distinct nvl(PROGRAMCODE,' ')PROGRAMCODE,nvl(BRANCHCODE,' ')BRANCHCODE, nvl(BRANCHDESC,' ')BRANCHDESC from branchmaster where nvl(deactive,'N')='N' order by PROGRAMCODE,BRANCHCODE";
            rs = db.getRowset(qry);
				if (request.getParameter("x")==null ) 
					{	
                            %>
                            <select name="program" Style="WIDTH:550px ; height:100px" multiple size="3">
                               <!-- <option value="all">All</option>-->
                                <%
					            while (rs.next()) 
								{
                                   mProgramBranch=rs.getString("PROGRAMCODE")+"***"+rs.getString("BRANCHCODE");
                                %>
									<option value="<%=mProgramBranch%>"><%=rs.getString("PROGRAMCODE")%> - <%=rs.getString("BRANCHCODE")%> [<%=rs.getString("BRANCHDESC")%>]</option>
                                <%
								}
					
					}
					else
					{	

						%>
                            <select name="program" Style="WIDTH:550px ; height:100px" multiple size="3">
						<%

							while(rs.next())
							{
								 mProgramBranch=rs.getString("PROGRAMCODE")+"***"+rs.getString("BRANCHCODE");			

									 mPrograms1 = request.getParameterValues("program");
						

							for(int h=0;h<mPrograms1.length;h++)
							{			
								
								 if(mPrograms1[h]==null)
								{

								}
								else if(mPrograms1[h].equals(mProgramBranch))
								{
									//System.out.println("adsfasdf");
									%>
									<OPTION selected Value="<%=mProgramBranch%>"><%=rs.getString("PROGRAMCODE")%> - <%=rs.getString("BRANCHCODE")%> [<%=rs.getString("BRANCHDESC")%>]</option>
									<%
										Flag1=1;
								
								}
								
								
							}
							if(Flag1==0)
							{
								%>
										<OPTION  Value="<%=mProgramBranch%>"><%=rs.getString("PROGRAMCODE")%> - <%=rs.getString("BRANCHCODE")%> [<%=rs.getString("BRANCHDESC")%>]</option>
								<%
							}
							Flag1=0;
							}
					}

					%>
                            </select>
                </font></td>
           </TR>
           
                <tr>
                    <td nowrap align=center colspan=3><font color=black face=Verdana size=2><input type="submit" name="submit"  id="submit" value="Submit" onClick="return Check();" /></font></td>

                </tr>
				</table>
				</form>

				<form name=frm1 > 
				<%
			
if(request.getParameter("x")!=null)
		   {
			

            
			String[] mAcademicYears = request.getParameterValues("academicyear");
            for (int i = 0; i < mAcademicYears.length; i++) {
                if (i == 0) {
                    mAcademicYear = mAcademicYear + "'" + mAcademicYears[i] + "'";
                } else {
                    mAcademicYear = mAcademicYear + ",'" + mAcademicYears[i] + "'";
                }
            }

            String[] mPrograms = request.getParameterValues("program");
            for (int i = 0; i < mPrograms.length; i++) {
                     len= mPrograms[i].length() ;
                     pos=mPrograms[i].indexOf("***");
                     QryProgram=mPrograms[i].substring(0,pos);
                     QryBranch=mPrograms[i].substring(pos+3,len);
                if (i == 0) {

                    mProgram = mProgram + "'" + QryProgram + "'";
                    CProgram=QryProgram;
                   mBranch = mBranch + "'" + QryBranch + "'";
                    CBranch=QryBranch;
                } else {
                         if(!QryProgram.equals(CProgram))
                             {
                    mProgram = mProgram + ",'" + QryProgram + "'";
                    CProgram=QryProgram;
                    }
                         if(!QryBranch.equals(CBranch))
                             {
                    mBranch = mBranch + ",'" + QryBranch + "'";
                    CBranch=QryBranch;
                    }
                }
            }

				%>
				<table bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=columns topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center width="100%">
				<thead>
				<tr bgcolor="#ff8c00">
				<td nowrap align=left ><font color=white size=2><b>Sr. No.</b></font></td>
			    <td nowrap align=left><font color=white size=2><b>Student Name</b></font></td>
				<td nowrap align=center ><font color=white size=2><b>Enrollment <br>Number</b></font></td>
				<td nowrap align=center><font color=white size=2><b>Academic Year</b></font></td>
				<td nowrap align=center><font color=white size=2><b>ProgramCode</b></font></td>
				<td nowrap align=center ><font color=white size=2><b>Branch Code</b></font></td>
				<td nowrap align="left" ><font color=white size=2><b>Student Email</b></font></td>
				</thead>
				<tbody>
				<%

			 qry = "SELECT nvl(a.AcademicYear,' ')AcademicYear,nvl(A.STUDENTID,' ')STUDENTID, NVL(A.STUDENTNAME,' ')STUDENTNAME, NVL(A.ENROLLMENTNO,' ')ENROLLMENTNO,  NVL(A.PROGRAMCODE,' ')PROGRAMCODE, NVL(A.BRANCHCODE,' ')BRANCHCODE,NVL(A.SEMESTER,'')SEMESTER FROM STUDENTMASTER A WHERE  A.INSTITUTECODE='"+mInst+"' and A.ACADEMICYEAR in (" + mAcademicYear + ") and A.PROGRAMCODE in (" +mProgram+ ") and A.BRANCHCODE in (" +mBranch+ ") And ( NVL (programcompleted, 'N') = 'Y' and  NVL (a.DEACTIVE, 'N') = 'Y'  or nvl(deactive,'N' )='N')  order by A.ACADEMICYEAR, a.PROGRAMCODE,A.BRANCHCODE";
			 //out.print(qry);
			  rs = db.getRowset(qry);
			   while (rs.next())
			   {
				  ctr++;
				  flag=1;
					
					qry1="select NVL(B.PAEMAILID,' ')PEMAIL,NVL(B.STEMAILID,' ')STEMAILID from STUDENTPHONE B where B.STUDENTID='"+rs.getString("STUDENTID")+"' ";
					  rs1 = db.getRowset(qry1);
					  if(rs1.next())
						{
						  mStudentEmail=rs1.getString("STEMAILID");
						}
						else
						{
							mStudentEmail=" ";
						}

				   %>
				   <Tr>
		
					<td nowrap align=left> <font size=2><%=ctr%></td>
				   <td nowrap align=left> <font size=2><%=rs.getString("STUDENTNAME")%></td>
					<td nowrap align=center > <font size=2><%=rs.getString("ENROLLMENTNO")%></td>
							<td nowrap align=center > <font size=2><%=rs.getString("ACADEMICYEAR")%></td>
					<td nowrap align=center> <font size=2><%=rs.getString("PROGRAMCODE")%></td>
					<td nowrap align=center > <font size=2><%=rs.getString("BRANCHCODE")%></td>
					<td nowrap align=center > <font size=2><%=mStudentEmail%>&nbsp;</font></td>
					</font>
					</tr>
				   <%
			   }

			
					%>
					</tbody>
				<table>
				<script type="text/javascript">
				var st1 = new SortableTable(document.getElementById("table-1"),["Number", "CaseInsensitiveString", "Number", "Number", "CaseInsensitiveString", "CaseInsensitiveString"]);
				</script>
				<%
				if(flag==0)
			   {
						out.print("<center> <font face=verdana size=3 color=red><b>No Records Found  !</b></font></center>");
			   }
						%>

				</form>

<% }
				//-----------------------------
//-- Enable Security Page Level  
//-----------------------------


        } catch (Exception e) {
          //  out.print(e);
        }

    } 
	else 
	{
%>
<br>
<font color=red>
    <h3>	<br><img src='.../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
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
                out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Verdana' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
    
	}
        }//end of try
        catch (Exception e) {
//	out.println(e.getMessage());
        }

%>
<!-- <center>
    <table ALIGN=Center VALIGN=TOP>
    <tr>
    <td valign=middle>
    <IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">
    <FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
    A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT> 		</td></tr></table> -->
</body>
</Html>