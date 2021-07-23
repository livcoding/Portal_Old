<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
	int C=0;
	ResultSet rs=null;
	DBHandler db=new DBHandler();
	String mName="";
	String mInstArray[]=new String[10];
	String mCatArray[]=new String[10];
	String mCat="";
	String qry="Select INSTITUTECODE from C#INSTITUTEMASTER Where nvl(Deactive,'N')='N' and INSTITUTECODE is not null";
	try
{
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
	C=0;
	qry="SELECT CATEGORYCODE, nvl(CATEGORYDESC,CATEGORYCODE) cat FROM C#CATEGORYMASTER Where nvl(Deactive,'N')='N'";
	rs=db.getRowset(qry);			

	mCat="aada";
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
			mYear="2007";
			}
		}
	else
		{
			mYear="2007";
		}


	session.setAttribute("CYear",mYear);


	String mfdate="", mtdate="";
	if (request.getParameter("dtFrom")!=null)
		{	
			mfdate=request.getParameter("dtFrom").toString().trim();
		}

	if (request.getParameter("dtTo")!=null)
		{	
			mtdate=request.getParameter("dtTo").toString().trim();
		}

	session.setAttribute("FromDate",mfdate);
	session.setAttribute("ToDate",mtdate);
}
catch(Exception e)
{
}
%>
 

<frameset border=0 rows= "0%,99.9%" FrameBorder=0>
      <frame  noresize  scrolling=no border=0 src = "TopStudTitle.jsp"/>
      <frame  noresize  scrolling=no border=0 src = "ShowStudStatus.jsp"/>
   </frameset>
</HTML>