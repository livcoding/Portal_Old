<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%  
   int ctr=0;
   int mSNo=0;
   int mTotalCount=0;
   String mName1="",mName2="",mName3="",mName4="",mStudentname="",mSID="",mSubj="",mSec="",mLTP="",mName6="";
   String ctr1="",mEnroll="",mRegDate="",mName5="",mEmailId="";
   String qry="";
   String Subj="",LTP="",mGroup="",mColor="",mradio="",mInst="";
   int j=0,mCt1=0,mCt2=0,i=0;	
   ResultSet rs=null, RsChk=null;
   GlobalFunctions gb =new GlobalFunctions();
   DBHandler db=new DBHandler();
				

	/*
	' **********************************************************************************************************
	' *													   *
	' * File Name:	SignUpMemberBulk.JSP		[For Employee]			   *
	' * Author:		Ashok Kumar Singh 						         *
	' * Date:		3rd Nov 2006	 							   *
	' * Version:		1.0									   *	
	' **********************************************************************************************************
*/
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .75in 1.0in .75in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
-->
</style>
<title>Hide Stuff and Print</title>
</head>

<body leftmargin=5 topmargin=5>
<%
if(request.getParameter("TotalCount")!=null && Integer.parseInt(request.getParameter("TotalCount").toString().trim())>0)
	{ 
		mTotalCount =Integer.parseInt(request.getParameter("TotalCount").toString().trim());
		ctr=0;
		 if (request.getParameter("Subj")==null )
			Subj="";
		 else
			Subj=request.getParameter("Subj").toString().trim();
		 if (request.getParameter("LTP")==null )
			LTP="";
		 else
			LTP=request.getParameter("LTP").toString().trim();

		 if (request.getParameter("mGroup")==null )
			mGroup="";
		  else
			mGroup=request.getParameter("mGroup").toString().trim();

		  if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}

		mradio=request.getParameter("ATYPE");

		qry="Select subjectcode Subject from subjectmaster where subjectid='"+Subj+"'  and  InstituteCode='"+mInst+"' ";
		rs=db.getRowset(qry);
		rs.next();

	if(mradio.equals("A"))
	{	
	%>
<table border=1 Align=Left cellSpacing=0 cellPadding=0 >
<START OF FILE>
<%@page contentType="text/html"%>
<%
  response.setContentType("application/vnd.ms-excel");
%>
		<tr style="height:37pt;" vAlign=center align=right>
		<td>&nbsp;</td>
		<td align=left nowrap><font size=2><b>Subj.:<%=rs.getString("Subject")%>&nbsp;LTP:<%=LTP%>&nbsp;Group: <%=mGroup%><br>
		Enrol No. &nbsp; Name of Student &nbsp; Reg. Date</b></font>
		</td>
                <td align=left nowrap><font size=2><b>EmailId</b></font>
	<%
	for (int a=1;a<=31;a++)
	{
	%>
	<td><%=a%></td>
<%
	}
	%>
		
                </tr>
	<%
	
	  for (j=1;j<=mTotalCount;j++)		
		{mCt1++;
		   mName1="Studentid"+String.valueOf(mCt1).trim();
		   mName2="mSNo"+String.valueOf(mCt1).trim();
		   mName3="Enroll"+String.valueOf(mCt1).trim();
		   mName4="RegDate"+String.valueOf(mCt1).trim();
                   mName6="Email"+String.valueOf(mCt1).trim();
		   mName5="Color"+String.valueOf(mCt1).trim();

		 if(request.getParameter(mName1)!=null)
		 {
		   mStudentname=request.getParameter(mName1);
		   ctr1=request.getParameter(mName2);
		   mEnroll=request.getParameter(mName3);
		   mRegDate=request.getParameter(mName4);
                   mEmailId=request.getParameter(mName6);
	         mColor=request.getParameter(mName5);

		%>
			<tr vAlign=center style='height:23.10pt'>
			<td width=31 nowrap align=right><font color=<%=mColor%>><%=ctr1%>&nbsp;&nbsp;&nbsp;</font></td>
			<td><font size=2 color=<%=mColor%>><%=mEnroll%>&nbsp;[<%=GlobalFunctions.toTtitleCase(mStudentname)%>]&nbsp;&nbsp;&nbsp;</font><font size=1><%=mRegDate%></font></td>
                        <td width=231 nowrap align=left><font color=<%=mColor%>><%=mEmailId%>&nbsp;&nbsp;&nbsp;</font></td>
		<%
			for(int b=0;b<=31;b++)
			{
		%>
			<td>&nbsp; &nbsp; &nbsp; </td>
	
		<%
		}
		%>
              
               
               <%
		} // CLOSING OF IF
	
      	}  // closing of for (j)
 	}
	else
	{
%>
<table border=1 Align=Left cellSpacing=0 cellPadding=0 >
<START OF FILE>
<%@page contentType="text/html"%>
<%
  response.setContentType("application/vnd.ms-excel");

	  for (j=1;j<=mTotalCount;j+=68)		
		{
		%>
		<tr style="height:37pt;" vAlign=center align=right>
		<td>&nbsp;</td>
		<td align=left><font size=2><b>LTP:<%=LTP%> &nbsp;Subj.:<%=Subj%>&nbsp;Group: <%=mGroup%><br>
		Enrol No. &nbsp; Name of Student &nbsp; Reg. Date</b></font>
		</td>
		<td width=31>&nbsp;</td>
		<td width=31>&nbsp;</td>
		<td align=left><font size=2><b>LTP:<%=LTP%> &nbsp;Subj.:<%=Subj%>&nbsp;Group: <%=mGroup%><br>
		Enrol No. &nbsp; Name of Student &nbsp; Reg. Date</b></font>
		</td>
		</tr>
		<%

		mCt1=mCt2;
		for (mSNo=1;mSNo<=34;mSNo++)
		{	
		   if(mCt1==mTotalCount) break;
 		   mCt1++;
		   mCt2=mCt1+34;
		   mName1="Studentid"+String.valueOf(mCt1).trim();
		   mName2="mSNo"+String.valueOf(mCt1).trim();
		   mName3="Enroll"+String.valueOf(mCt1).trim();
		   mName4="RegDate"+String.valueOf(mCt1).trim();
                   mName6="Email"+String.valueOf(mCt1).trim();
		   mName5="Color"+String.valueOf(mCt1).trim();

		 if(request.getParameter(mName1)!=null)
		 {
		   mStudentname=request.getParameter(mName1);
		   ctr1=request.getParameter(mName2);
		   mEnroll=request.getParameter(mName3);
		   mRegDate=request.getParameter(mName4);
                   mEmailId=request.getParameter(mName6);
	         mColor=request.getParameter(mName5);

		%>
			<tr vAlign=center style='height:23.10pt'>
			<td width=31 nowrap align=right><font color=<%=mColor%>><%=ctr1%>&nbsp;&nbsp;&nbsp;</font></td>
			<td><font size=2 color=<%=mColor%>><%=mEnroll%>&nbsp;[<%=GlobalFunctions.toTtitleCase(mStudentname)%>]&nbsp;&nbsp;&nbsp;</font><font size=1><%=mRegDate%></font></td>
                        
		<%
		}
		  mName1="Studentid"+String.valueOf(mCt2).trim();
		  mName2="mSNo"+String.valueOf(mCt2).trim();
		  mName3="Enroll"+String.valueOf(mCt2).trim();	
		  mName4="RegDate"+String.valueOf(mCt2).trim();
                  mName6="Email"+String.valueOf(mCt1).trim();
		mName5="Color"+String.valueOf(mCt2).trim();

		 if(request.getParameter(mName1)!=null)
		 {
		  mStudentname=request.getParameter(mName1);
		  ctr1=request.getParameter(mName2);
		  mEnroll=request.getParameter(mName3);
		  mRegDate=request.getParameter(mName4);
                  mEmailId=request.getParameter(mName6);
		 mColor=request.getParameter(mName5);
		%>		
			<td width=31>&nbsp;</td>
			<td width=31 nowrap align=right><font color=<%=mColor%>><%=ctr1%>&nbsp;&nbsp;&nbsp;</font></td>
			<td><font size=2 color=<%=mColor%>><%=mEnroll%>&nbsp;<%=GlobalFunctions.toTtitleCase(mStudentname)%>&nbsp;</font><font size=1><%=mRegDate%></font></td>
                        
			</tr>
		<%
		}
	   }
	
      	}  


	}	
		}  //closing of total count if
	%>
</table>
<END OF FILE>
</body>
</html> 
     
