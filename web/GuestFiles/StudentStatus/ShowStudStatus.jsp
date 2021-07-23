<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
long mDur=60;
int mIndx=0;
String mInst="",qry="";
String mSt1="";
String mCYear="";
String mDt1="",mDt2="";
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
<title>Thapar University, Patiala</title>
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
ResultSet rs=null,rsTmp=null;
DBHandler db=new DBHandler();
String mDayTime="";
String mPType="";

if (session.getAttribute("PType")!=null)
	{
	mPType=session.getAttribute("PType").toString().trim();
	}

if (session.getAttribute("LastIndex")==null)
	{
	session.setAttribute("LastIndex","0");
	mIndx=0;
	}
else
	{
	mIndx=Integer.parseInt(session.getAttribute("LastIndex").toString().trim())+1;
	session.setAttribute("LastIndex",String.valueOf(mIndx));
	}
	
if (session.getAttribute("mInstArray")!=null)
	{
	String[] yourInts = (String[]) session.getAttribute("mInstArray");
	mInst=yourInts[mIndx];
	
	if (mInst==null)
	{
		session.setAttribute("LastIndex","0");
		mIndx=0;
		mInst=yourInts[mIndx];
	}
  }

	String mCat="";
	if (session.getAttribute("mCatArray")!=null)
	{
		String[] mCatg = (String[]) session.getAttribute("mCatArray");	
		for(int p=0;p<mCatg.length;p++)
		 {
			if (mCatg[p]!=null)
				{
				if(mCat.equals(""))
				   	mCat="'"+mCatg[p]+"'";
				else
					  mCat=mCat+",'"+mCatg[p]+"'";
				}
		 }	
	}

	
	int sno=0;
	String mPbranch="",mPCat="",mInstname="";
	%>
	<table width='98%' align=center border=1 cellspacing=0 Height='550px' bordercolor=red>	
	<tr><td colspan=5 align=center valign=top>
	<%
	if (!mInst.equals(""))
	{
		qry="Select nvl(InstituteName,InstituteCode) IName from c#InstituteMaster where InstituteCode='"+mInst+"'";
		rs=db.getRowset(qry);		
		if (rs.next())		
		    mInstname=rs.getString(1);
		else
		    mInstname=mInst;
	}
	%>
	<font size=5 color=Green><b><%=mInstname%><br>Admissions</b></font>
	</td></tr>
<tr height'10%'>
<td width='8%'><b>S. No.</b></td>
<td width='21%'><b>Branch - Category</b></td>
<td width='14%'><b>Roll No.</b></td>
<td width='42%'><b>Name</b></td>
<td width='15%'><b>Rank</b></td>
</tr>
<tr height='90%'><td colspan=5 align=center>
<MARQUEE id=MARQUEE1  behavior=scroll height='500px' scrolldelay=250 LANGUAGE=javascript onfinish="return MARQUEE1_onfinish()" direction=up loop=1> 
	<table width='100%' align=center border=1 cellspacing=0>	
	<%
	qry="Select RANKNO, ROLLNO, NAME, FromCategory CategoryCode, PROGRAMCODE, BRANCHALLOTED, COUNSELLINGDONE";
	qry=qry+" from C#StudentMaster where INSTITUTECODE='"+mInst+"' and COUNSELLINGID ='"+mCYear+"' And FromCategory in ("+mCat+") ";
	qry=qry+" And nvl(DEACTIVE,'N')='N' And PROGRAMTYPECODE='"+mPType+"' And trunc(COUNSELLINGDATE) Between To_Date('"+mDt1+"','DD-MM-YYYY') And To_Date('"+mDt2+"','DD-MM-YYYY')";
	qry=qry+" And nvl(COUNSELLINGDONE,'N')='Y' and nvl(defaulter,'N')='N' ";

	//qry=qry+" Group by BRANCHALLOTED,CATEGORYCODE Having count(*)>=1";
	qry=qry+" Order by PROGRAMCODE,BRANCHALLOTED,FromCategory,to_number(RANKNO),COUNSELLINGDATE";
	//out.print(qry);
	rs=db.getRowset(qry);			
	String myCat="";
 
	while (rs.next())
	{
		//out.print(mPbranch+"  <>");
		if(mPbranch.equals(""))
		{
			qry="SELECT nvl(B.CATEGORYDESC,b.CATEGORYCODE)||' ('||b.CATEGORYCODE||' )' cat from C#CATEGORYMASTER B Where B.CATEGORYCODE='"+rs.getString("CATEGORYCODE")+"'";
			rsTmp=db.getRowset(qry);	
			if (rsTmp.next()) 
				myCat=rsTmp.getString(1) ;
				 
	
			%> 
				<tr>
				<td colspan=5 align=left bgcolor='#9b2d0b'>
					<font color='white'><b>Program[Branch]: <%=rs.getString("PROGRAMCODE")%> &nbsp;[<%=rs.getString("BRANCHALLOTED")%>]
					<br>Category: <%=myCat%></b></font>
				</td>
				</tr>
			<%
			sno=0;
			mPbranch=rs.getString("PROGRAMCODE")+rs.getString("BRANCHALLOTED");
			mPCat=rs.getString("CATEGORYCODE");

		}

		else if(!mPbranch.equals(rs.getString("PROGRAMCODE")+rs.getString("BRANCHALLOTED"))||!mPCat.equals(rs.getString("CATEGORYCODE")))
		{
			qry="Select nvl(NOOFSEATS,0) NOOFSEATS from C#SEATDISPLAY Where CATEGORYCODE='"+mPCat+"' And INSTITUTECODE='"+mInst+"'";
			qry=qry+" And PROGRAMTYPECODE='"+mPType+"' And  PROGRAMCODE||BRANCHCODE='"+mPbranch+"'";
    			rsTmp=db.getRowset(qry);		
			if (rsTmp.next()) 
				mTot=rsTmp.getLong(1) ;


			qry="Select nvl(count(*),0) tot from C#STUDENTMASTER Where FROMCATEGORY='"+mPCat+"' And INSTITUTECODE='"+mInst+"'";
			qry=qry+" And nvl(Present,'N')='Y' and COUNSELLINGID ='"+mCYear+"' And nvl(DEACTIVE,'N')='N' And To_Char(COUNSELLINGDATE,'yyyymmdd')< to_char(To_Date('"+mDt1+"','DD-MM-YYYY'),'yyyymmdd') ";
			qry=qry+" And nvl(COUNSELLINGDONE,'N')='Y' and nvl(defaulter,'N')='N' And PROGRAMTYPECODE='"+mPType+"' And  PROGRAMCODE||BRANCHALLOTED='"+mPbranch+"'";
			//out.println(qry);

    			rsTmp=db.getRowset(qry);		
			if (rsTmp.next()) 
				mTot=mTot-rsTmp.getLong(1) ;


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
					Program[Branch]: <%=rs.getString("PROGRAMCODE")%> &nbsp; [<%=rs.getString("BRANCHALLOTED")%>]<br>
					Category: <%=myCat%>
					</b></font>
				</td>
				</tr>
			<%
			sno=0;
			mPbranch=rs.getString("PROGRAMCODE")+rs.getString("BRANCHALLOTED");
			mPCat=rs.getString("CATEGORYCODE");
		}
		sno++;
			%> 
				<tr>
					<td width='8%'><b><%=sno%></b></td>
					<td width='21%'><b><%=rs.getString("PROGRAMCODE")%>/<%=rs.getString("BRANCHALLOTED")%> - <%=rs.getString("CATEGORYCODE")%></b></td>
					<td width='14%'><b><%=rs.getString("ROLLNO")%></b></td>
					<td width='42%'><b><%=rs.getString("NAME")%></b></td>
					<td width='15%' align=right><b><%=rs.getString("RANKNO")%></b>&nbsp; &nbsp;</td>
				</tr>
			<%
	
	} //Closing of While

	 if(sno>0)
		{
			mTot=0;
			qry="Select nvl(NOOFSEATS,0) from C#SEATDISPLAY Where CATEGORYCODE='"+mPCat+"' And INSTITUTECODE='"+mInst+"'";
			qry=qry+" And PROGRAMTYPECODE='"+mPType+"' And  PROGRAMCODE||BRANCHCODE='"+mPbranch+"'";
    			rsTmp=db.getRowset(qry);		
			if (rsTmp.next()) 
				mTot=rsTmp.getLong(1) ;

			qry="Select nvl(count(*),0) tot from C#STUDENTMASTER Where FROMCATEGORY='"+mPCat+"' And INSTITUTECODE='"+mInst+"'";
			qry=qry+"  And nvl(Present,'N')='Y' and COUNSELLINGID ='"+mCYear+"' And nvl(DEACTIVE,'N')='N' And To_Char(COUNSELLINGDATE,'yyyymmdd')< to_char(To_Date('"+mDt1+"','DD-MM-YYYY'),'yyyymmdd') ";
			qry=qry+" And nvl(COUNSELLINGDONE,'N')='Y' and nvl(defaulter,'N')='N' And PROGRAMTYPECODE='"+mPType+"' And  PROGRAMCODE||BRANCHALLOTED='"+mPbranch+"'";

    			rsTmp=db.getRowset(qry);		
			if (rsTmp.next()) 
				mTot=mTot-rsTmp.getLong(1) ;



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
out.print("Error, While Fetching Data"+qry);
}
%>
</table>
</marquee>
</td></tr></table>

</center>
</BODY>
</HTML>