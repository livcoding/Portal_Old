<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%


//System.out.print("-- ankurrrr----");

      try {
     


//System.out.print("-- dddddddddddddddddd----");


            String mVacCode = "";
			String mMemberID ="",mMemberType="",mMemberName="",mMemberCode="";
            String mInst="",mComp="",mDept="",mAppRefNo="",mPVacccCode="";
            
 int start=0,last=0,custom=0,ccustom=0,count=0;
	 String mPage="",qqry="",mAbsent="";








String	mHead="JIIT ";
%>
<html>
    <head>
	

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <TITLE>#### <%=mHead%> [HOD Final Selection ]</TITLE>
        <link  rel="stylesheet" type="text/css" href="css/style.css">

		</head>
    <body id="top" aLink=#ff00ff rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >

	 	 
    <%
try{
    GlobalFunctions gb = new GlobalFunctions();
    DBHandler db = new DBHandler();
    String qry = "";
	String mDMemberID="",mDMemberCode="",mDMemberType="";
    String qry1="",qry2="",qry3="",qry4="",mShow="";
    ResultSet rs = null,rsupdate=null;
	String ApplicationID="",mDeptRemark="",mStatus="",qryupdate="",qryinsert="",mFreeze="",mDeptCode="",mChkMemID="";
int ShortlistSeq=0,mflag=0;


	if(request.getParameter("VacancyCode")==null)
		mVacCode="";
	else
		mVacCode=request.getParameter("VacancyCode").toString().trim();


	
//System.out.print(mVacCode+"-- dddddddddddddddddd----");

	
	
	
	if(request.getParameter("Institute")==null)
		mInst="";
	else
		mInst=request.getParameter("Institute").toString().trim();

	if(request.getParameter("CompanyCode")==null)
		mComp="";
	else
		mComp=request.getParameter("CompanyCode").toString().trim();





	
if(request.getParameter("mChkMemID")==null)
		mChkMemID="";
	else
		mChkMemID=request.getParameter("mChkMemID");
	
if(request.getParameter("DeptCode")==null)
		mDeptCode="";
	else
		mDeptCode=request.getParameter("DeptCode").toString().trim();


//	System.out.print(mChkMemID+"-- dddddddddddddddddd----"+ mDeptCode);

/*
	if(request.getParameter("ShortlistSeq")==null)
		ShortlistSeq=0;
	else
		ShortlistSeq=Integer.parseInt(request.getParameter("ShortlistSeq"));
*/
	//if(ShortlistSeq==2)	


	ShortlistSeq=3;



	
	int i=0;

//System.out.print("-- dddddddddddddddddd----"+ mStatus);


			if(request.getParameter("DeptRemarks")==null)
				mDeptRemark="";
			else
				mDeptRemark=request.getParameter("DeptRemarks").toString().trim();
	
			if(request.getParameter("Status")==null)
				mStatus="N";
			else
				mStatus=request.getParameter("Status").toString().trim();
	
			if(request.getParameter("ApplicationID")==null)
				ApplicationID="";
			else
				ApplicationID=request.getParameter("ApplicationID").toString().trim();
		
		

		/*
System.out.print(i+" :Institute: "+mInst+" :CompanyCode: "+mComp+" :: "+mDeptCode+" :VacancyCode: "+mVacCode+" " +
        " :ShortlistSeq: "+ShortlistSeq+" :TotalCount: "+i+" :DeptRemarks: "+mDeptRemark +" :Status: "+mStatus+" :ApplicationID: "+ApplicationID+" :" +
        " mChkMemID  : "+mChkMemID);
		
		*/
		
//			System.out.print(ApplicationID+"-- dddddddddddddddddd----"+ mStatus);
		if(!mStatus.equals("N"))
		{
			qry="SELECT 'Y' FROM HR#APPLICANTSHORTLISTMASTER WHERE COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND VACANCYCODE='"+mVacCode+"' AND   APPLICANTID='"+ApplicationID+"' AND SHORTLISTSEQNO="+ShortlistSeq+" ";
		//System.out.print("-- Selcete----"+ qry);
			rs=db.getRowset(qry);
			if(rs.next())
			{
				 qryupdate="UPDATE HR#APPLICANTSHORTLISTMASTER			SET    STATUS         = '"+mStatus+"',				  SHORTLISTBY    = '"+ mChkMemID+"' ,       SHORTLISTDATE  = sysdate,       REMARKS        = '"+mDeptRemark+"',       ENTRYBY        = '"+ mChkMemID+"',       ENTRYDATE      = sysdate				 ,FINAL='"+mFreeze+"', FINALIZEDBY='"+ mChkMemID+"', FINALIZEDDATE=sysdate					 WHERE  COMPANYCODE    = '"+mComp+"' AND    INSTITUTECODE  = '"+mInst+"' AND    VACANCYCODE    = '"+mVacCode+"' AND    APPLICANTID    = '"+ApplicationID+"' AND    SHORTLISTSEQNO = "+ShortlistSeq+" ";
//		System.out.print("------------------update------------------"+qryupdate);
				int update=db.update(qryupdate);
				if(update>0)
					mflag=1;
				else
					mflag=0;
			}
			else
			{
				qryinsert="INSERT INTO HR#APPLICANTSHORTLISTMASTER (   COMPANYCODE, INSTITUTECODE, VACANCYCODE,    APPLICANTID, SHORTLISTSEQNO, STATUS,    SHORTLISTBY, SHORTLISTDATE, REMARKS,    DEACTIVE, ENTRYBY, ENTRYDATE,   FINAL ,FINALIZEDBY,FINALIZEDDATE)  VALUES ( '"+mComp+"','"+mInst+"' ,'"+mVacCode+"' ,'"+ApplicationID+"'    ,'"+ShortlistSeq+"' ,'"+mStatus+"' ,'"+ mChkMemID+"' ,sysdate ,'"+mDeptRemark+"' , 'N' , '"+ mChkMemID+"', sysdate ,'"+mFreeze+"','"+ mChkMemID+"',sysdate)";
//			System.out.print("------------------insert------------------"+qryinsert);
				int insert=db.insertRow(qryinsert)	;
				if(insert>0)
					mflag=1;
				else
					mflag=0;
			}


		}
		else
			{
      mflag=0;
			}
			

			//}

		if (mflag==1)
		{
				//out.print("<BR><CENTER><FONT sIZE=4 COLOR=GREEN > <B> Record Saved Successfully... </B></FONT>");
%>
<!-- <div id="myDiv">
    <h4><CENTER><FONT sIZE=4 COLOR=GREEN > <B> Record Saved Successfully... </B></FONT></h4>
  </div> -->


<%
		}
	//}


	
		 } catch (Exception e) {
out.print(e+" zzzzz");
        }

		 } catch (Exception e) {
out.print(e+" zzzzz");
        }
%>

		
		</form>
		</body>
		</html>
