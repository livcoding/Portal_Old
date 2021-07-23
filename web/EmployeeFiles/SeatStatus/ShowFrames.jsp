<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %> 
<%
	try
	{
	int C=0;
	ResultSet rs=null;
	DBHandler db=new DBHandler();
	String mName="";
	String mInstArray[]=new String[10];
	String mCatArray[]=new String[10];
	String mSysDate="", mCounsDate="", mFrDate="", mToDate="";

	String mIstAttendance="N";
	String mIIndAttendance="N";
	String mDcoument="N";
	String mCounsDone="N";
	String mFeesPaid="N";

	if (request.getParameter("IstAttendance")!=null)
	{
		mIstAttendance=request.getParameter("IstAttendance");
	}
	if (request.getParameter("IIndAttendance")!=null)
	{
		mIIndAttendance=request.getParameter("IIndAttendance");
	}
	if (request.getParameter("DcoumentV")!=null)
	{
		mDcoument=request.getParameter("CounsDone");
	}
	if (request.getParameter("CounsDone")!=null)
	{
		mCounsDone=request.getParameter("CounsDone");
	}
	if (request.getParameter("FeesPaid")!=null)
	{
		mFeesPaid=request.getParameter("FeesPaid");
	}
	
	session.setAttribute("IstAttendance",mIstAttendance);
	session.setAttribute("IIndAttendance",mIIndAttendance);
	session.setAttribute("Dcoument",mDcoument);
	session.setAttribute("CounsDone",mCounsDone);
	session.setAttribute("FeesPaid",mFeesPaid);




	String qry="Select INSTITUTECODE,SEQID from C#INSTITUTEMASTER Where nvl(Deactive,'N')='N' and INSTITUTECODE is not null ORDER BY SEQID";
	rs=db.getRowset(qry);			


	while (rs.next())
	{			
		mName="I"+rs.getString("INSTITUTECODE");
		if (request.getParameter(mName)!=null)
			{	
			mInstArray[C]=rs.getString("INSTITUTECODE");
			C++;
			}
	}


	session.setAttribute("mInstArray",mInstArray);

	qry="Select to_char(sysdate,'dd-mm-yyyy')CurrDate from dual";
	rs=db.getRowset(qry);
	if(rs.next())
	{
		mSysDate=rs.getString(1);
		mFrDate=mSysDate;
		mToDate=mSysDate;
	}
	if(request.getParameter("CounsDate")==null)
		mCounsDate="A";
	else
		mCounsDate=request.getParameter("CounsDate").toString().trim();

	session.setAttribute("Accumulated",mCounsDate);

	if(mCounsDate.equals("D"))
	{
		if(request.getParameter("dtFrom")==null)
			mFrDate=mFrDate;
		else
			mFrDate=request.getParameter("dtFrom").toString().trim();
		if(request.getParameter("dtTo")==null)
			mToDate=mToDate;
		else
			mToDate=request.getParameter("dtTo").toString().trim();

		session.setAttribute("DT1",mFrDate);
		session.setAttribute("DT2",mToDate);
	}

	if(request.getParameter("HOSTEL")!=null )
	{
		session.setAttribute("SHOWHOSTEL","Y");
	}
	else
	{
		session.setAttribute("SHOWHOSTEL","N");
	}

	C=0;
	qry="SELECT CATEGORYCODE, nvl(CATEGORYDESC,CATEGORYCODE) cat FROM C#CATEGORYMASTER Where nvl(Deactive,'N')='N' order by SORTON";
	rs=db.getRowset(qry);			
	while (rs.next())
	{			
		mName="C"+rs.getString("CATEGORYCODE");
		if (request.getParameter(mName)!=null)
		{	
			mCatArray[C]=rs.getString("CATEGORYCODE");
			C++;
		}
	}
	session.setAttribute("mCatArray",mCatArray);
	long n=0;
	if (request.getParameter("second")!=null)
			{	
			try{
			n=Long.parseLong(request.getParameter("second").toString().trim());
			   }
			catch(Exception e)
			{
			n=60;
			}
		}
	else
		{
			n=60;
		}

	session.setAttribute("mDuration",String.valueOf(n));

	String mPType="";
	if (request.getParameter("PType")!=null)
			{	
			try{
			mPType=request.getParameter("PType").toString().trim();
			   }
			catch(Exception e)
			{
			mPType="";
			}
		}
	else
		{
			mPType="UG";
		}


	session.setAttribute("PType",mPType);


	String mYear="";
	if (request.getParameter("TxtYear")!=null)
			{	
			try{
			mYear=request.getParameter("TxtYear").toString().trim();
			   }
			catch(Exception e)
			{
			mYear="2009";
			}
		}
	else
		{
			mYear="2009";
		}


	session.setAttribute("CYear",mYear);


 

}
catch(Exception e)
{
}
%>
<html>
<frameset border=0 cols= "1%,99%" FrameBorder=0>
      <frame  noresize  scrolling=no border=0 src = "TopTitle.jsp"/>
      <frame  noresize  scrolling=no border=0 src = "ShowSeatStatus.jsp"/>
   </frameset>
</HTML>