<html>
  <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>JSP Page</title>

  </head>
  <body>

    <h4>Mee..</h4> 
  </body>
</html>


<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%
      try {
     
            String mVacCode = "";
			String mMemberID ="",mMemberType="",mMemberName="",mMemberCode="";
            String mInst="",mComp="",mDept="",mAppRefNo="",mPVacccCode="";
            
 int start=0,last=0,custom=0,ccustom=0,count=0;
	 String mPage="",qqry="",mAbsent="";






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

		</head>
    <body id="top" aLink=#ff00ff rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >

	 	 
    <%

    GlobalFunctions gb = new GlobalFunctions();
    DBHandler db = new DBHandler();
    String qry = "";
	String mDMemberID="",mDMemberCode="",mDMemberType="";
    String qry1="",qry2="",qry3="",qry4="",mShow="";
    ResultSet rs = null,rsupdate=null;
	String ApplicationID="",mDeptRemark="",mStatus="",qryupdate="",qryinsert="",mFreeze="",mDeptCode="",mChkMemID="";
int ShortlistSeq=0,mflag=0;




System.out.print("------------------------------FFF");


	if(request.getParameter("VacancyCode")==null)
		mVacCode="";
	else
		mVacCode=request.getParameter("VacancyCode").toString().trim();



System.out.print(mVacCode+"------------------------------mVacCode");



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

if(request.getParameter("mChkMemID")==null)
		mChkMemID="";
	else
		mChkMemID=request.getParameter("mChkMemID");



	
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

/*



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
*/
	
		//out.print(mFreeze+"FFF"+ShortlistSeq);
	
	int i=0;

	i=Integer.parseInt(request.getParameter("slno"));

//if(mTotalCount<)


System.out.print(i+"FFF");


//	if(i!=0 )
//	{
	//	for(int i=1;i<=mTotalCount;i++)
	//	{
		/*	if(request.getParameter("DeptRemarks"+i)==null)
				mDeptRemark="";
			else
				mDeptRemark=request.getParameter("DeptRemarks"+i).toString().trim();
	
			if(request.getParameter("Status"+i)==null)
				mStatus="N";
			else
				mStatus=request.getParameter("Status"+i).toString().trim();
	
			if(request.getParameter("ApplicationID"+i)==null)
				ApplicationID="";
			else
				ApplicationID=request.getParameter("ApplicationID"+i).toString().trim();
		
		
System.out.print(slno+" :Institute: "+mInst+" :CompanyCode: "+mComp+" :ccustom: "+ccustom+" :DeptCode: "+mDeptCode+" :VacancyCode: "+mVacCode+"  :ShortlistSeq: "+ShortlistSeq+" :TotalCount: "+TotalCount+" :DeptRemarks: "+mDeptRemark+" :Status: "+mStatus+" :ApplicationID: "+ApplicationID+" : mChkMemID  : "+mChkMemID);*/

	






	//}

		 } catch (Exception e) {
            System.out.print(e+" zzzzz");
        }
%>

		
		</form>
		</body>
		</html>
