<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %> 
<%
long mDur=60;
String mInst="",qry="";
String mSt1="";
String mCYear="";
String mDt1="",mDt2="";
String mDispInst="";

long mTot=0;
try
{

if(session.getAttribute("FromDate")!=null)
  {
	mDt1=session.getAttribute("FromDate").toString().trim();
  }


if(session.getAttribute("ToDate")!=null)
  {
	mDt2=session.getAttribute("ToDate").toString().trim();
  }



if(session.getAttribute("mDuration")!=null)
  {
	mDur=Long.parseLong(session.getAttribute("mDuration").toString().trim());
  }

if(session.getAttribute("CYear")!=null)
  {
	mCYear=session.getAttribute("CYear").toString();
  }

%>
<html>
<head>

<SCRIPT ID=clientEventHandlersJS LANGUAGE=javascript>
	<!--

	function MARQUEE1_onfinish() {
	window.location = 'ShowStudStatus.jsp';

	}

if(window.history.forward(1) != null)
window.history.forward(1);
	//-->

</script>
</head>

<BODY aLink='#d3d3d3' bgcolor=Yellow rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
ResultSet rs=null,rsTmp=null,rsdf=null;
DBHandler db=new DBHandler();
String mDayTime="",mInstShort="";

if (session.getAttribute("mInstArray")!=null)
	{
	String[] yourInts = (String[]) session.getAttribute("mInstArray");

		for(int pp=0;pp<yourInts.length;pp++)
		 {
			if( yourInts[pp]!=null)
				{
				 qry="select nvl(shortname,INSTITUTECODE) shortname from C#institutemaster where institutecode='"+yourInts[pp]+"'";
				 rs=db.getRowset(qry);		
				 if (rs.next())
				   mDispInst=rs.getString(1);
				 else
				   mDispInst=yourInts[pp];

				if(mInst.equals(""))
				   	{
					  mInst="'"+yourInts[pp]+"'";
					  mInstShort=mDispInst;
					}
				else
					{
					  mInst=mInst+",'"+yourInts[pp]+"'";
					  mInstShort=mInstShort+", "+mDispInst;
					}

				}
		 }	
	}

	//out.print(mInst);

	String mCat="";
	if (session.getAttribute("mCatArray")!=null)
	{
		String[] mCatg = (String[]) session.getAttribute("mCatArray");	
		for(int p=0;p<mCatg.length;p++)
		 {
			if( mCatg[p]!=null)
				{
				if(mCat.equals(""))
				   	mCat="'"+mCatg[p]+"'";
				else
					  mCat=mCat+",'"+mCatg[p]+"'";
				}
		 }	
	}

	
	int sno=0;
	String mPbranch="",mPCat="";
	%>
	<table width='98%' align=center border=1 cellspacing=0 Height='550px' bordercolor=red>	
	<tr><td colspan=5 align=center valign=top>
	<font size=5 color=Green><b>Counselling <%=mCYear%> for [<%=mInstShort%>]<br>Admissions</b></font>
	</td></tr>
<tr height'10%'>
<td width='8%'><b>S. No.</b></td>
<td width='21%'><b>Institute/Branch - Category</b></td>
<td width='14%'><b>Roll No.</b></td>
<td width='42%'><b>Name</b></td>
<td width='15%'><b>Rank</b></td>
</tr>
<tr height='90%'><td colspan=5 align=center>
<MARQUEE id=MARQUEE1  behavior=scroll height='500px' scrolldelay=250 LANGUAGE=javascript onfinish="return MARQUEE1_onfinish()" direction=up loop=1> 
	<table width='100%' align=center border=1 cellspacing=0>	
	<%

qry="Select A.ALLOTEDINSTITUTE BRANCHALLOTEDAGAINSTINSTITUTE,B.RANK RANKNO,B.ROLLNO,B.NAME,A.FROMCATEGORY CATEGORYCODE, ";
qry=qry+"A.ALLOTEDBRANCH BRANCHALLOTED,A.COUNSELLINGDONE from C#ALLOCATIONDETAIL A,C#StudentMaster B ";
qry=qry+"where A.ALLOTEDINSTITUTE in("+mInst+") and A.COUNSELLINGID='"+mCYear+"' ";
qry=qry+" AND A.INSTITUTECODE=B.INSTITUTECODE AND A.COUNSELLINGID=B.COUNSELLINGID AND A.PROGRAMTYPE=B.PROGRAMTYPE ";
qry=qry+" AND A.RANK=B.RANK	And A.FROMCATEGORY in ("+mCat+") And nvl(B.DEACTIVE,'N')='N' And ";
qry=qry+" trunc(A.COUNSELLINGDATE) Between To_Date('"+mDt1+"','DD-MM-YYYY') And To_Date('"+mDt2+"','DD-MM-YYYY')";
qry=qry+" And nvl(A.COUNSELLINGDONE,'N')='Y' Order by A.ALLOTEDINSTITUTE ,A.ALLOTEDBRANCH,A.FROMCATEGORY,";
qry=qry+" to_number(B.RANK),A.COUNSELLINGDATE ";


	/*
	qry="Select BRANCHALLOTEDAGAINSTINSTITUTE,RANKNO, ROLLNO, NAME, CATEGORYCODE, BRANCHALLOTED, COUNSELLINGDONE from C#StudentMaster ";
	qry=qry+" where BRANCHALLOTEDAGAINSTINSTITUTE in("+mInst+") and COUNSELLINGID ='"+mCYear+"' And CategoryCode in ("+mCat+") ";
	qry=qry+" And nvl(DEACTIVE,'N')='N' And trunc(COUNSELLINGDATE) Between To_Date('"+mDt1+"','DD-MM-YYYY') And To_Date('"+mDt2+"','DD-MM-YYYY')";
	qry=qry+" And nvl(COUNSELLINGDONE,'N')='Y'";
	qry=qry+" Order by BRANCHALLOTEDAGAINSTINSTITUTE,BRANCHALLOTED,CATEGORYCODE,to_number(RANKNO),COUNSELLINGDATE";	
	*/

	rs=db.getRowset(qry);
	String myCat="";
	while(rs.next())
	{
		if(mPbranch.equals(""))
		{
			qry="SELECT nvl(B.CATEGORYDESC,b.CATEGORYCODE)||' ('||b.CATEGORYCODE||' )' cat From C#CATEGORYMASTER B Where B.CATEGORYCODE='"+rs.getString("CATEGORYCODE")+"'";
			rsTmp=db.getRowset(qry);	
			if (rsTmp.next()) 
				myCat=rsTmp.getString(1) ;


			mDispInst="";
			qry="select nvl(shortname,INSTITUTECODE) shortname from C#institutemaster where institutecode='"+rs.getString("BRANCHALLOTEDAGAINSTINSTITUTE")+"'";
			rsdf=db.getRowset(qry);		

			 if (rsdf.next())
			   mDispInst=rsdf.getString(1);
			 else
			   mDispInst=rs.getString("BRANCHALLOTEDAGAINSTINSTITUTE");

				 
	
			%> 
				<tr>
				<td colspan=5 align=left bgcolor='#9b2d0b'>
					<font color='white'><b>Institute: <%=mDispInst%> &nbsp; &nbsp;Branch: <%=rs.getString("BRANCHALLOTED")%>
					<br>Category: <%=myCat%></b></font>
				</td>
				</tr>
			<%
			sno=0;
						
			mPbranch=rs.getString("BRANCHALLOTEDAGAINSTINSTITUTE")+rs.getString("BRANCHALLOTED");
			mPCat=rs.getString("CATEGORYCODE");

		}

		else if(!mPbranch.equals(rs.getString("BRANCHALLOTEDAGAINSTINSTITUTE")+rs.getString("BRANCHALLOTED"))||!mPCat.equals(rs.getString("CATEGORYCODE")))
		{
			qry="Select nvl(NOOFSEATS,0) NOOFSEATS from C#SEATDISPLAY Where CATEGORYCODE='"+mPCat+"' And INSTITUTECODE in ("+mInst+" )";
			qry=qry+" And INSTITUTECODE||BRANCHCODE='"+mPbranch+"'";
    			rsTmp=db.getRowset(qry);		
			if (rsTmp.next()) 
				mTot=rsTmp.getLong(1) ;


			qry="SELECT nvl(B.CATEGORYDESC,b.CATEGORYCODE)||' ('||b.CATEGORYCODE||' )' cat from C#CATEGORYMASTER B Where B.CATEGORYCODE='"+rs.getString("CATEGORYCODE")+"'";
			rsTmp=db.getRowset(qry);	
			if (rsTmp.next()) 
				myCat=rsTmp.getString(1) ;

			%> 
			<tr>
				<td colspan=5 align=Right><b>Seats filled / Total Seats <%=sno%>/<%=mTot%></b>&nbsp;&nbsp;&nbsp;&nbsp;				
				</td>
			</tr>
				<tr>
					<td colspan=5 align=left bgcolor='#9b2d0b'>
					<font color='white'><b>
					Institute: <%=mDispInst%> &nbsp; &nbsp; Branch : <%=rs.getString("BRANCHALLOTED")%><br>
					Category: <%=myCat%>
					</b></font>
				</td>
				</tr>
			<%
			sno=0;
			mPbranch=rs.getString("BRANCHALLOTEDAGAINSTINSTITUTE")+rs.getString("BRANCHALLOTED");
			mPCat=rs.getString("CATEGORYCODE");
		}
		sno++;
			%> 
				<tr>
					<td width='8%'><b><%=sno%></b></td>
					<td width='21%'><b><%=mDispInst%>/<%=rs.getString("BRANCHALLOTED")%> - <%=rs.getString("CATEGORYCODE")%></b></td>
					<td width='14%'><b><%=rs.getString("ROLLNO")%></b></td>
					<td width='42%'><b><%=rs.getString("NAME")%></b></td>
					<td width='15%' align=right><b><%=rs.getString("RANKNO")%></b>&nbsp; &nbsp;</td>
				</tr>
			<%
	
	} //Closing of While

	 if(sno>0)
		{
			mTot=0;
			qry="Select nvl(NOOFSEATS,0) from C#SEATDISPLAY Where CATEGORYCODE='"+mPCat+"' And INSTITUTECODE in ("+mInst+")";
			qry=qry+" And INSTITUTECODE||BRANCHCODE='"+mPbranch+"'";
    			rsTmp=db.getRowset(qry);		
			if (rsTmp.next()) 
				mTot=rsTmp.getLong(1) ;

			%> 
			<tr>
				<td colspan=5 align=Right><b>Seats filled / Total Seats <%=sno%>/<%=mTot%></b>&nbsp;&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		<%	
		}

	%>
	</table>

<%


}
catch(Exception e)
{
	out.print("Error, While Fetching Data");
}
%>
</table>
</marquee>
</td></tr></table>

</center>
</BODY>
</HTML>