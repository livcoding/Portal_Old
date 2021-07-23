<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%
        try {
            String mVacCode = "", mVacDesc = "";
            String mHead = "";     
       
			String mMemberID ="",mMemberType="",mMemberName="",mMemberCode="";
            String mInst="",mComp="";
            

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


if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>

<html>
    <head>
        <TITLE>#### <%=mHead%> [ DepartmentSelection ]</TITLE>
        <link  rel="stylesheet" type="text/css" href="css/style.css">
       
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
    ResultSet rs = null,rsupdate=null,rs1=null;
	String ApplicationID="",mDeptRemark="",mStatus="",qryupdate="",qryinsert="";
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
		String mRightID="256";
		ResultSet RsChk=null;

	  //-----------------------------
	  //-- Enable Security Page Level  
	  //-----------------------------
		qry="Select WEBKIOSK.ShowLink('"+mRightID+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		
		
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{


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

	if(request.getParameter("ShortlistSeq")==null)
		ShortlistSeq=0;
	else
		ShortlistSeq=Integer.parseInt(request.getParameter("ShortlistSeq"));

	ShortlistSeq=ShortlistSeq+1;

	int mTotalCount=0;

	mTotalCount=Integer.parseInt(request.getParameter("TotalCount"));

String  mFinal="";

	qry1="select nvl(FINAL,'N')FINAL FROM HR#SELECTIONLEVELS  where  INSTITUTECODE='"+mInst+"' AND  VACANCYCODE='" + mVacCode + "' AND SELECTIONBY LIKE '%HOD%' and nvl(FINAL,'N')='Y'  ";
	rs1=db.getRowset(qry1);
	if(rs1.next())
		{
			mFinal=rs1.getString("FINAL").toString().trim();
		}


	if(mTotalCount!=0)
	{
		for(int i=0;i<=mTotalCount;i++)
		{
			if(request.getParameter("DeptRemarks"+i)==null)
				mDeptRemark="";
			else
				mDeptRemark=request.getParameter("DeptRemarks"+i).toString().trim();
	
			if(request.getParameter("Status"+i)==null)
				mStatus="";
			else
				mStatus=request.getParameter("Status"+i).toString().trim();
	
			if(request.getParameter("ApplicationID"+i)==null)
				ApplicationID="";
			else
				ApplicationID=request.getParameter("ApplicationID"+i).toString().trim();
	
			qry="SELECT 'Y' FROM HR#APPLICANTSHORTLISTMASTER WHERE COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND VACANCYCODE='"+mVacCode+"' AND   APPLICANTID='"+ApplicationID+"' AND SHORTLISTSEQNO="+ShortlistSeq+" ";
			rs=db.getRowset(qry);
			if(rs.next())
			{
				 qryupdate="UPDATE HR#APPLICANTSHORTLISTMASTER			SET    STATUS         = '"+mStatus+"',	  SHORTLISTBY    = '"+ mChkMemID+"' ,       SHORTLISTDATE  = sysdate,       REMARKS        = '"+mDeptRemark+"',       ENTRYBY        = '"+ mChkMemID+"',       ENTRYDATE      = sysdate WHERE  COMPANYCODE    = '"+mComp+"' AND    INSTITUTECODE  = '"+mInst+"' AND    VACANCYCODE    = '"+mVacCode+"' AND    APPLICANTID    = '"+ApplicationID+"' AND    SHORTLISTSEQNO = "+ShortlistSeq+" ";
				int update=db.update(qryupdate);
				if(update>0)
					mflag=1;
				else
					mflag=0;

				
				
			}
			else
			{
				qryinsert="INSERT INTO HR#APPLICANTSHORTLISTMASTER (   COMPANYCODE, INSTITUTECODE, VACANCYCODE,    APPLICANTID, SHORTLISTSEQNO, STATUS,    SHORTLISTBY, SHORTLISTDATE, REMARKS,    DEACTIVE, ENTRYBY, ENTRYDATE)  VALUES ( '"+mComp+"','"+mInst+"' ,'"+mVacCode+"' ,'"+ApplicationID+"'    ,'"+ShortlistSeq+"' ,'"+mStatus+"' ,'"+ mChkMemID+"' ,sysdate ,'"+mDeptRemark+"' , 'N' , '"+ mChkMemID+"', sysdate )";
				int insert=db.insertRow(qryinsert)	;
				if(insert>0)
					mflag=1;
				else
					mflag=0;
				
				
			}
			//out.print(mStatus+"mStatus");
			if(mFinal.equals("Y"))
				{
					qry="UPDATE HR#APPLICATIONMASTER SET SHORTLISTED='"+mStatus+"' ,SHORTLISTEDBY  = '"+ mChkMemID+"', SHORTLISTEDDATE = sysdate     WHERE 		APPLICANTID = '"+ApplicationID+"' and VACANCYCODE    = '"+mVacCode+"' ";
					//out.print(qry);
					int finalupdate=db.update(qry);
					if(finalupdate>0)
						mflag=1;
					else
						mflag=0;
				}
			


		}

		if (mflag==1)
		{
				out.print("<BR><BR><CENTER><FONT sIZE=4 COLOR=GREEN > <B> Record Save Successfully </B></FONT>");

				//response.sendRedirect("HODWiseSelection.jsp");
		}
		else
		{
					out.print("<BR><BR><CENTER><FONT sIZE=4 COLOR=red > <B> Error ... </B></FONT>");
		}

		}
		%>
		<center>
<a href="javascript:window.close()"><FONT SIZE=2 COLOR=BLUE FACE=VERDANA>
Click to Close</FONT></a>
</center>
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


