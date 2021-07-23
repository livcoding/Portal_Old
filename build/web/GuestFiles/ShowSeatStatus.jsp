<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %> 
<%
//------------------------
// For JIIT Noida
//------------------------
ResultSet rsPrgPrint=null, rsPrgTotPrint=null,rsProg=null, rs=null, StudentRecordSet =null,BranchRecordSet=null;
DBHandler db=new DBHandler();
long mDur=60;
String mInst="",qry="",mInstShort="";
String mSt1="";
String mCYear="";
String mShowHostel="N";
String mCNO="1";
String mSysDate="", mAcumulated="", mDt1="", mDt2="",mCompany="";
String mIstAttendance="N";
String mIIndAttendance="N";
String mDcoument="N";
String mCounsDone="N";
String mFeesPaid="N";
String mDispInst="";
String mBreak="";
String mBreak1="";
int mTable=0;
int mCatCount=0;
int mGen=0;
String mExclude="";
String ExcludeInst="N";
String mSCST="N";

try
{
if(session.getAttribute("IstAttendance")!=null)
{
	mIstAttendance=session.getAttribute("IstAttendance").toString().trim();
}
else
{
	mIstAttendance="N";
}

if(session.getAttribute("IIndAttendance")!=null)
{
	mIIndAttendance=session.getAttribute("IIndAttendance").toString().trim();
}
else
{
	mIIndAttendance="N";
}


if(session.getAttribute("Dcoument")!=null)
{
	mDcoument=session.getAttribute("Dcoument").toString().trim();
}
else
{
	mDcoument="N";
}

if(session.getAttribute("CounsDone")!=null)
{
	mCounsDone=session.getAttribute("CounsDone").toString().trim();
}
else
{
	mCounsDone="N";
}

if(session.getAttribute("FeesPaid")!=null)
{
	mFeesPaid=session.getAttribute("FeesPaid").toString().trim();
}
else
{
	mFeesPaid="N";
}



if(session.getAttribute("CompanyCode")!=null)
{
	mCompany=session.getAttribute("CompanyCode").toString().trim();
}
else
{
	mCompany="UNIV";
}



if(session.getAttribute("CYear")!=null)
{
	mCYear=session.getAttribute("CYear").toString();
}

if(session.getAttribute("SHOWHOSTEL")!=null)
{
	mShowHostel=session.getAttribute("SHOWHOSTEL").toString().trim();
}

if(session.getAttribute("Accumulated")!=null)
	mAcumulated=session.getAttribute("Accumulated").toString().trim();
else
	mAcumulated="Y";
if(mAcumulated.equals("D"))
	mAcumulated="N";
if(mAcumulated.equals("N"))
{
	qry="Select to_char(sysdate,'dd-mm-yyyy')CurrDate from dual";
	rs=db.getRowset(qry);
	if(rs.next())
	{
		mSysDate=rs.getString(1);
	}

	if(session.getAttribute("DT1")!=null)
		mDt1=session.getAttribute("DT1").toString().trim();
	else
		mDt1=mSysDate;

	if(session.getAttribute("DT2")!=null)
		mDt2=session.getAttribute("DT2").toString().trim();
	else
		mDt2=mSysDate;
}
//out.print(mSysDate+"#######"+mDt1+"*******"+mDt2+"*******"+mAcumulated);
%>
<html>
<head>
<meta http-equiv="refresh" content="<%=mDur%>">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"> 
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1"><script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>

<BODY aLink='#ff00ff' bgcolor=WHITE rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 scroll=yes>
<%

//String mSnapshot="",mSnapshotOld="";
//if (session.getAttribute("Snapshot")!=null)
//	mSnapshotOld=session.getAttribute("Snapshot").toString().trim();

//qry="select SNAPSHOTS from C#Current";
//rs=db.getRowset(qry);		
//if (rs.next())
//{
//	mSnapshot=rs.getString(1);
//      session.setAttribute("Snapshot",mSnapshot);
//}
if (1==1)// (!mSnapshot.equals(mSnapshotOld))
{
String mDayTime="";
String mStop="N";
String mLocation="JIIT";
String mProgType="UG";
String mShowSeatWait="N";
String mShowHostelWait="N";

qry="select PARAMETERVALUE from Parameters where  COMPANYCODE='" + mCompany + "' And MODULENAME='COUNS' And PARAMETERID='H2.3' and nvl(DEACTIVE,'N')='N'";
rs=db.getRowset(qry);		
if(rs.next())
  {
	if(rs.getString(1).equals("Y"))
		{
		mShowSeatWait="Y";			
		}
	else
		{
		 mBreak="<BR>";
		}
  }

qry="select PARAMETERVALUE from Parameters where  COMPANYCODE='" + mCompany + "' And MODULENAME='COUNS' And PARAMETERID='H2.4' and nvl(DEACTIVE,'N')='N'";
//out.print(qry);
rs=db.getRowset(qry);		
if(rs.next())
  {
	if(rs.getString(1).equals("Y"))
		{
		mShowHostelWait="Y";	
		}
	else
		{
		 mBreak+="<BR><BR>";
		mBreak1+="<BR>";

		}

  }

//System.out.println("mShowSeatWait="+mShowSeatWait);
//System.out.println("mShowHostelWait="+mShowHostelWait);

	
qry="select NVL(STOPDISPLAYSEAT,'N') STP ,NVL(lOCATIONcODE,'JIIT') LOC from c#cURRENT";
rs=db.getRowset(qry);		
if (rs.next())		
  {
	mLocation=rs.getString("LOC");			
	mStop=rs.getString("STP");			
  }


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



if (session.getAttribute("mInstArray")!=null)
	{
	String[] yourInts = (String[]) session.getAttribute("mInstArray");

		for(int pp=0;pp<yourInts.length;pp++)
		 {
			if( yourInts[pp]!=null)
				{
				if(yourInts[pp].equals("JIET")||yourInts[pp].equals("JUIT")) ExcludeInst="JUIT";

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
String mcattt="";

	int mTotCat=0;
	if (session.getAttribute("mCatArray")!=null)
	{
		String[] mCatg = (String[]) session.getAttribute("mCatArray");	
		for(int p=0;p<mCatg.length;p++)
		 {
			if (mCatg[p]!=null)
				{
				  mTotCat++;		 
				 if (mcattt.equals(""))
					mcattt="'" + mCatg[p] + "'";
				   else
					mcattt=mcattt+",'"+mCatg[p] + "'";
					
				}
		 }	
	}



if (session.getAttribute("mCatArray")!=null)
	{

	String[] yourCat = (String[]) session.getAttribute("mCatArray");		
	if(mTotCat==1)
	{
	out.print("<br>");
	}
	%>
	<table width='100%' border=0 cellspacing=0 cellpadding=0>
	<tr><td align=center bgcolor='#ff3300'>
	<table align=center width='100%' height='100%' cellspacing=0 cellpadding=0 border=0>
	<%

	String[] myInst1 = (String[]) session.getAttribute("mInstArray");

	String mTime="";

	qry="select to_char(sysdate,'dd-Mon-yyyy hh:mi PM') mtime from dual";

	rs=db.getRowset(qry);		

	if (rs.next())		
	    mTime=rs.getString(1);			

	String[] mInst1 = (String[]) session.getAttribute("mInstArray");

	long mLastRankATTTot1=0, mLastRankATTTot=0, mLastRankDOCTot=0,mLastRankCOUTot=0,mLastRankFEETot=0;

	String mLastRankATT1="",mLastRankATT="", mLastRankDOC="",mLastRankCOU="",mLastRankFEE="";

	String Nqry =""; 

	Nqry ="Select  nvl(To_Char(Max(To_number(A.RANK))),'In Process'),count(*) Tot1 FROM C#STUDENTATTENDANCE A Where A.INSTITUTECODE in ("+mInst+") And A.COUNSELLINGID='"+mCYear+"' ";
	Nqry = Nqry + " And A.PROGRAMTYPE='"+mProgType+"'";
	Nqry = Nqry + " And A.LOCATIONCODE='"+mLocation+"' And Nvl(A.FIRSTATTENDANCE,'N')='Y' And exists (select 1 from C#CATEGORYAPPLIEDFOR B ";
	Nqry=Nqry + " where B.INSTITUTECODE in ("+mInst+") And B.COUNSELLINGID='"+mCYear +"' And B.PROGRAMTYPE='"+ mProgType +"' And B.RANK=A.RANK And B.CHOICENO=1 ";
	Nqry=Nqry + " And B.CATEGORY in ("+mcattt+") And nvl(B.DEACTIVE,'N')='N') ";
	//out.print(Nqry);	
	if(mAcumulated.equals("N"))
	{
		Nqry=Nqry + " and trunc(A.FIRSTATTENDANCEDATE) Between To_Date('"+mDt1+"','DD-MM-YYYY') And To_Date('"+mDt2+"','DD-MM-YYYY')";
	}

	rs=db.getRowset(Nqry);		
	if (rs.next())	
	  {	
	   mLastRankATT1=rs.getString(1);			
	   mLastRankATTTot1=rs.getLong(2);			
	  }
	
	Nqry ="Select  nvl(To_Char(Max(To_number(A.RANK))),'In Process'),count(*) Tot1 FROM C#STUDENTATTENDANCE A Where A.INSTITUTECODE in ("+mInst+") And A.COUNSELLINGID='"+mCYear+"' ";
	Nqry = Nqry + " And A.PROGRAMTYPE='"+mProgType+"'";
	Nqry = Nqry + " And A.LOCATIONCODE='"+mLocation+"' And Nvl(A.FINALATTENDANCE,'N')='Y' And exists (select 1 from C#CATEGORYAPPLIEDFOR B ";
	Nqry=Nqry + " where B.INSTITUTECODE in ("+mInst+") And B.COUNSELLINGID='"+mCYear +"' And B.PROGRAMTYPE='"+ mProgType +"' And B.RANK=A.RANK And B.CHOICENO=1 ";
	Nqry=Nqry + " And B.CATEGORY in ("+mcattt+") And nvl(B.DEACTIVE,'N')='N') ";

//	out.print(Nqry);
	
	if(mAcumulated.equals("N"))
	{
		Nqry=Nqry + " and trunc(A.FINALATTENDANCEDATE) Between To_Date('"+mDt1+"','DD-MM-YYYY') And To_Date('"+mDt2+"','DD-MM-YYYY')";
	}

	//out.print(Nqry);
	rs=db.getRowset(Nqry);		
	if (rs.next())	
	  {	
	   mLastRankATT=rs.getString(1);			
	   mLastRankATTTot=rs.getLong(2);			
	  }

	Nqry =" SELECT  nvl(To_Char(Max(to_number(A.RANK))),'In Process'),count(*) Tot1 FROM C#STUDENTDOCUMENTMASTER A Where A.INSTITUTECODE in ("+mInst+") And A.COUNSELLINGID='"+mCYear+"' ";
	//Nqry=Nqry + " And A.PROGRAMTYPE= '"+mProgType+"'";
	Nqry=Nqry + " And Nvl(A.PROCEEDFORCOUNSELLING,'N')='Y' And exists (select 1 from C#CATEGORYAPPLIEDFOR B where B.INSTITUTECODE in ("+mInst+") And B.COUNSELLINGID='"+mCYear+"' And B.PROGRAMTYPE='"+mProgType+"'";
	Nqry=Nqry + " And B.RANK=A.RANK  And B.CHOICENO=1  And B.CATEGORY in ("+mcattt+")   And nvl(B.DEACTIVE,'N')='N')     ";
	Nqry=Nqry + " And exists (select 1 from C#STUDENTATTENDANCE C where C.INSTITUTECODE in ("+mInst+") And C.COUNSELLINGID='"+mCYear+"' And C.PROGRAMTYPE = '"+mProgType+"'";
	Nqry=Nqry + " And C.RANK=A.RANK And C.LOCATIONCODE='"+mLocation+"' And Nvl(C.FINALATTENDANCE,'N')='Y' )";
	//out.print(Nqry);

	if(mAcumulated.equals("N"))
	{
	
		Nqry=Nqry + " and trunc(A.DOCVERIFICATIONDATE) Between To_Date('"+mDt1+"','DD-MM-YYYY') And To_Date('"+mDt2+"','DD-MM-YYYY')";
	}
	
	//out.print(Nqry);
	rs=db.getRowset(Nqry);		
	if (rs.next())		
	   {
	     mLastRankDOC=rs.getString(1);		
	     mLastRankDOCTot=rs.getLong(2);		
	   }

	Nqry = "SELECT nvl(To_Char(Max(to_number(A.RANK))),'In Process'),count(*) Tot1 From C#ALLOCATIONDETAIL A Where A.INSTITUTECODE in (" + mInst + ") And A.COUNSELLINGID='"+mCYear+"'";
	Nqry = Nqry + " And A.PROGRAMTYPE = '"+mProgType+"' And  A.FROMCATEGORY in ("+mcattt+") And   nvl(A.COUNSELLINGDONE,'N')='Y' And nvl(A.DEFAULTER,'N')='N'";
 	Nqry = Nqry + " And exists (select 1 from C#STUDENTATTENDANCE C where C.INSTITUTECODE in ("+mInst+") And C.COUNSELLINGID='"+mCYear+"' And C.PROGRAMTYPE ='"+mProgType+"'";
	Nqry = Nqry + " And C.RANK=A.RANK And C.LOCATIONCODE='"+mLocation+"' And Nvl(C.FINALATTENDANCE,'N')='Y' )";
	//out.print(Nqry);
	
	if(mAcumulated.equals("N"))
	{
	 Nqry=Nqry + " and trunc(A.COUNSELLINGDATE) Between To_Date('"+mDt1+"','DD-MM-YYYY') And To_Date('"+mDt2+"','DD-MM-YYYY')";
	}
	//out.print(Nqry);

	rs=db.getRowset(Nqry);		
	if (rs.next())		
	  {
	   mLastRankCOU=rs.getString(1);	
	   mLastRankCOUTot=rs.getLong(2);	
	  }
 
	Nqry = "SELECT nvl(To_Char(Max(To_number(A.RANK))),'In Process'),count(*) Tot1 From C#ALLOCATIONDETAIL A Where A.INSTITUTECODE in (" + mInst + ") And A.COUNSELLINGID='"+mCYear+"'";
	Nqry = Nqry + " And A.PROGRAMTYPE = '"+mProgType+"' And  A.FROMCATEGORY in ("+mcattt+") And   nvl(A.COUNSELLINGDONE,'N')='Y' And nvl(A.DEFAULTER,'N')='N'";
 	Nqry = Nqry + " And exists (select 1 from C#STUDENTATTENDANCE C where C.INSTITUTECODE in ("+mInst+") And C.COUNSELLINGID='"+mCYear+"' And C.PROGRAMTYPE ='"+mProgType+"'";
	Nqry = Nqry + " And C.RANK=A.RANK And C.LOCATIONCODE='"+mLocation+"' And Nvl(C.FINALATTENDANCE,'N')='Y' ) ";
	Nqry = Nqry + " And Exists ( Select 1 from C#StudentMaster SM Where   SM.INSTITUTECODE=A.INSTITUTECODE And Sm.COUNSELLINGID=A.COUNSELLINGID "; // And Sm.COUNSELLINGNO=A.COUNSELLINGNO 
	Nqry = Nqry + " And Sm.PROGRAMTYPE=A.PROGRAMTYPE And Sm.RANK=A.RANK And Sm.STUDENTID is not null )";
	//out.print(Nqry);

	if(mAcumulated.equals("N"))
	{
		Nqry=Nqry +" and trunc(A.COUNSELLINGDATE) Between To_Date('"+mDt1+"','DD-MM-YYYY') And To_Date('"+mDt2+"','DD-MM-YYYY')";
	}
	//out.print(Nqry);
	rs=db.getRowset(Nqry);		
	if (rs.next())		
	  {
	   mLastRankFEE=rs.getString(1);	
	   mLastRankFEETot=rs.getLong(2);	
	  }
	 
if(mStop.equals("N"))
  {
	 
	//-------------------------------------------------------------------------------
	// Stop Displaying Seats when C#Current Table shwoing/Required STOPDISPLAYSEAT='Y'
	//mStop
	//-------------------------------------------------------------------------------

	String mInstAdd="";
	if(ExcludeInst.equals("JUIT"))
		mInstAdd="JAYPEE UNIVERSITY OF INFORMATION TECHNOLOGY , WAKNAGHAT";
	else
		mInstAdd="JAYPEE INSTITUTE OF INFORMATION TECHNOLOGY UNIVERSITY, NOIDA";

	%>
	<tr>
	<td align=center bgcolor='white'><font FACE=VERDANA color=#ff3300 size=5><b>  Counselling <%=mCYear%><br><%=mInstAdd%><BR>Seat Status (<%=mTime%>)</b></font>
	<%
	 if(mTotCat==1)
	{
	out.print("<br><br><br>");}%></td></tr>
	<tr><td width='100%' align=center bgcolor=DarkBlue>
	
	<%if(mIstAttendance.equals("Y") || mIIndAttendance.equals("Y") || mDcoument.equals("Y") || mCounsDone.equals("Y") || mFeesPaid.equals("Y")){%>	
	<Table bordercolor="gray" border=1 width='100%' cellpadding=0 cellspacing=0>
	<tr>
	<td align=center><font  FACE=VERDANA color='White' size=3><b>&nbsp;</b></font></td>
	<%
	if(mIstAttendance.equals("Y"))
	{
	%>	
	<td align=center><font  FACE=VERDANA color='White' size=4><b>Attendance at Gate</b></font></td> 
	<%
	}
	if(mIIndAttendance.equals("Y"))
	{
	%>	
	<td align=center><font  FACE=VERDANA color='White' size=4><b>Called Rank</b></font></td> 
	<%
	}
	if(mDcoument.equals("Y"))
	{
	%>	
	<td align=center><font color='White' FACE=VERDANA  size=4><b>Document Verified</b></font></td>
	<%
	}
	if(mCounsDone.equals("Y"))
	{
	%>	
	<td align=center><font color='White'  FACE=VERDANA size=4><b>Seat Allocation Done</b></font></td>
	<%
	}
	if(mFeesPaid.equals("Y"))
	{
	%>	
	<td align=center><font color='White'  FACE=VERDANA size=4><b>Fee Paid</b></font></td>
	<%
	}
	%>
	</tr>
	
	<tr bgcolor="white">
	<td  align=center bgcolor='darkblue'><font  FACE=VERDANA color='white' size=4><b>Last Rank</b></font></td>
	<%
	if(mIstAttendance.equals("Y"))
	{
	%>	
	<td align=center><font  FACE=VERDANA color='blue' size=4><b><%=mLastRankATT1%></b></font></td> 
	<%
	}
	if(mIIndAttendance.equals("Y"))
	{
	%>	
	<td align=center><font  FACE=VERDANA color='blue' size=4><b><%=mLastRankATT%></b></font></td> 
	<%
	}
	if(mDcoument.equals("Y"))
	{
	%>	
	<td align=center><font  FACE=VERDANA color='blue' size=4><b><%=mLastRankDOC%></b></font></td>
	<%
	}
	if(mCounsDone.equals("Y"))
	{
	%>	
	<td align=center><font  FACE=VERDANA color='blue' size=4><b><%=mLastRankCOU%></b></font></td>
	<%
	}
	if(mFeesPaid.equals("Y"))
	{
	%>	
	<td align=center><font  FACE=VERDANA color='blue' size=4><b><%=mLastRankFEE%></b></font></td>
	<%
	}
	%>
	</tr>

	<tr bgcolor=white>
	<td bgcolor=darkblue><font FACE=VERDANA color='white' size=4><b>Total Count</b></font></td>
	<%
	if(mIstAttendance.equals("Y"))
	{
	%>
	<td align=center><font  FACE=VERDANA color='blue' size=4><b><%=mLastRankATTTot1%></b></font></td> 
	<%
	}
	if(mIIndAttendance.equals("Y"))
	{
	%>	
	<td align=center><font  FACE=VERDANA color='blue' size=4><b><%=mLastRankATTTot%></b></font></td> 
	<%
	}
	if(mDcoument.equals("Y"))
	{
	%>	
	<td align=center><font  FACE=VERDANA color='blue' size=4><b><%=mLastRankDOCTot%></b></font></td>
	<%
	}
	if(mCounsDone.equals("Y"))
	{
	%>	
	<td align=center><font  FACE=VERDANA color='blue' size=4><b><%=mLastRankCOUTot%></b></font></td>
	<%
	}
	if(mFeesPaid.equals("Y"))
	{
	%>	
	<td align=center><font  FACE=VERDANA color='blue' size=4><b><%=mLastRankFEETot%></b></font></td>
	<%
	}
	%>
	</tr>
	</Table>
	<%}%>
	</td>		
	</tr>
	 <%if(mTotCat==1)
	{
	out.print("<tr><td bgcolor=white><br><br></td></tr>");
	}
	%>	
	</table>
	</td>
	</tr>	
	<%

     if(mTotCat==1)
	{
		if(mTable==0)
		{
		 mBreak+="<BR><BR>";
		 mBreak1+="<BR>";
		}	
	}



	if(mTotCat>=3)
	 {
	 %>
	 <marquee height='510px' direction=up behavior=scroll scrolldelay=300 ALIGN=MIDDLE>
	 <%
	 }
		int mHos=0;	

	int y=0;
	qry="Select distinct INSTITUTECODE||A.ProgramCode||A.BRANCHCODE BCD,INSTITUTECODE,A.SEQID,B.BRANCHDESC,A.ProgramCode BDesc from C#SEATDISPLAY A, C#BRANCHMASTER B where A.BRANCHCODE is not null And A.INSTITUTECODE in ("+mInst+") and nvl(A.NOOFSEATS,0)>0 ";
	qry=qry +" and A.BRANCHCODE=B.BRANCHCODE order by INSTITUTECODE,SEQID";
//	out.print(qry);

	rs=db.getRowset(qry);

	while (rs.next())  y++;
 
	String bDescArray[][]=new String[y][2];			

	y=0;

	rs=db.getRowset(qry);		

	while (rs.next()) 
	{
		bDescArray[y][0]=rs.getString("BCD");
		bDescArray[y++][1]=rs.getString("BDesc");		
	}

	for(int jk=0;jk<yourCat.length;jk++)
	 {
		
		int k=0;
		qry="Select nvl(A.NOOFSEATS,0) NOOFSEATS from C#SEATDISPLAY A where A.BRANCHCODE is not null And A.INSTITUTECODE In ("+mInst+") And A.CATEGORYCODE='"+yourCat[jk]+"'  and nvl(A.NOOFSEATS,0)>0 ";

		rs=db.getRowset(qry);		
		if (rs.next() && yourCat[jk]!=null)
		 {			
		%>
		<Table border=1 bordercolor=Black cellpadding=0 cellspacing=0>		
		<tr><td  bgcolor="DarkBlue"><font  FACE=VERDANA size=4 color=white>
		<%
			if (yourCat[jk]!=null && yourCat[jk].equals("GEN"))
			{
			mGen=1;
			%>
			<b>Category: * <%=yourCat[jk]%></b>
			<%
			}
			
			else
			{
			%>
			<b>Category: <%=yourCat[jk]%></b>
			<%
			}
			%> 
		<br><table><tr><td><br><font  FACE=VERDANA size=4 color=white><b>Seats ...</b></font><br><br></td></tr>
		<tr><td height='40Px'><font  FACE=VERDANA size=4 color=white><b>Total</b></font></td></tr>
		<tr><td height='30Px' vALIGN="TOP"><font  FACE=VERDANA size=4 color=white><b>Alloted</b></font></td></tr>
		<tr><td vALIGN="TOP"><font  FACE=VERDANA size=4 color=white><b>Available</b></td></tr></table>
		<%
		if( mShowSeatWait.equals("Y") )
		{
		%>
			<br><b>Wait Listed</b>
		<%
            }
		%>		
		</font>
		</td>
		<%
		//qry="select distinct INSTITUTECODE,BRANCHCODE,SEQID from C#SEATDISPLAY where BRANCHCODE is not null And INSTITUTECODE IN ("+mInst+") And CATEGORYCODE='"+yourCat[jk]+"'  and nvl(NOOFSEATS,0)>0 order by INSTITUTECODE,seqid ";
		qry="select distinct INSTITUTECODE,ProgramCode||BRANCHCODE BRANCHCODE,SEQID from C#SEATDISPLAY where BRANCHCODE is not null And INSTITUTECODE IN ("+mInst+") And CATEGORYCODE='"+yourCat[jk]+"'  and nvl(NOOFSEATS,0)>=0 order by INSTITUTECODE,seqid ";
		rs=db.getRowset(qry);			
		while (rs.next())	k++;
		if (k>0) k--;
		
		String bArray[]=new String[k+1];	
		String seatArray[][]=new String[4][k+1];
		
		k=0;
		int mLastK=0;
		for(int opl=0;opl<mInst1.length;opl++)
		  {
		    if(mInst1[opl]!=null)
			{

			 qry="select nvl(shortname,INSTITUTECODE) shortname, seqid from C#institutemaster where institutecode='"+mInst1[opl]+"' order by seqid";
			 rs=db.getRowset(qry);		

			 if (rs.next())
			   mDispInst=rs.getString(1);
			 else
			   mDispInst=mInst1[opl];

			//qry="Select count(distinct ProgramCode||BRANCHCODE) ct from C#SEATDISPLAY A where A.BRANCHCODE is not null And A.INSTITUTECODE ='"+mInst1[opl]+"' And A.CATEGORYCODE='"+yourCat[jk]+"'  and nvl(A.NOOFSEATS,0)>0 ";
			qry="Select count(distinct ProgramCode||BRANCHCODE) ct from C#SEATDISPLAY A where A.BRANCHCODE is not null And A.INSTITUTECODE ='"+mInst1[opl]+"' And A.CATEGORYCODE='"+yourCat[jk]+"'  and nvl(A.NOOFSEATS,0)>=0 ";
			rs=db.getRowset(qry);		
			if (rs.next() && rs.getInt(1)>0)
			 {			
			 int myNum=rs.getInt(1);
			%>
			<td><table border=1 bordercolor="gray" cellpadding=0 cellspacing=0><tr><td bgcolor=darkblue colspan=<%=myNum%> align=center><font  FACE=VERDANA size=4 color=white><b><%=mDispInst%></b></font></td>

			<tr>
			<%

			//-----------------
			qry="select Distinct T, PROGRAMCODE from ( ";
			qry+="select count(distinct BRANCHCODE) T, PROGRAMCODE,ALPHA   from (";
			qry+="select distinct BranchCode,INSTITUTECODE,PROGRAMCODE, Alpha from C#SEATDISPLAY where INSTITUTECODE ='"+mInst1[opl]+"' And CATEGORYCODE='"+yourCat[jk]+"' and nvl(NOOFSEATS,0)>=0 order by ALPHA) Group by ALPHA,ProgramCode)";
			//out.print(qry);
			rsPrgPrint=db.getRowset(qry);	
			while(rsPrgPrint.next())
			   {		
			 
				qry="select count(distinct BRANCHCODE) T  from C#SEATDISPLAY where INSTITUTECODE ='"+mInst1[opl]+"' And CATEGORYCODE='"+yourCat[jk]+"' and nvl(NOOFSEATS,0)>=0 and ProgramCode='"+rsPrgPrint.getString(2)+"'";
				//out.print(qry);
				rsPrgTotPrint=db.getRowset(qry);	
				rsPrgTotPrint.next();
				%>
					<td BGCOLOR=RED align=center colspan=<%=rsPrgTotPrint.getInt(1)%>><FONT COLOR=WHITE FACE=VERDANA SIZE=5><b><%=rsPrgPrint.getString(2)%></b></FONT></td>
					<%
			
			    }
			%>
			</tr>
			<tr  bgcolor=white height="25px">
			<%
			mLastK=k;
			qry="select Distinct T, PROGRAMCODE from ( ";
			qry+="select count(distinct BRANCHCODE) T, PROGRAMCODE,ALPHA   from (";
			qry+="select distinct BranchCode,INSTITUTECODE,PROGRAMCODE, Alpha from C#SEATDISPLAY where INSTITUTECODE ='"+mInst1[opl]+"' And CATEGORYCODE='"+yourCat[jk]+"' and nvl(NOOFSEATS,0)>=0 order by ALPHA) Group by ALPHA,ProgramCode)";
			rsPrgPrint=db.getRowset(qry);	
			while(rsPrgPrint.next())
				{
				qry="select distinct INSTITUTECODE||PROGRAMCODE||BRANCHCODE , BRANCHCODE,Programcode, INSTITUTECODE,Alpha  from (";
				qry+="select distinct BranchCode,INSTITUTECODE,PROGRAMCODE, Alpha from C#SEATDISPLAY where INSTITUTECODE ='"+mInst1[opl]+"' And CATEGORYCODE='"+yourCat[jk]+"' and nvl(NOOFSEATS,0)>=0 And PROGRAMCODE='"+ rsPrgPrint.getString("PROGRAMCODE")+"' order by INSTITUTECODE,SEQID) order by INSTITUTECODE,Alpha";
				//out.print(qry);
				rs=db.getRowset(qry);			
				//mLastK=k;
				while (rs.next())
				  { 
				   bArray[k++]=rs.getString(1);
					//bgcolor='#ffdead'
				  %>
				  <td bgcolor="#ffdead" valign=middle align=center ><font color=blue  FACE=VERDANA color='#8b0000' size="4"><b>&nbsp;<%=rs.getString("PROGRAMCODE")%><br><%=rs.getString(2)%><br>(<%=rs.getString("ALPHA")%>)</b>&nbsp;</font></td>
				<%
		  	  	}
			     }
			   k--;
			%>
			</tr>
			<tr bgcolor=white>			
			<%			
			for(int o=mLastK;o<=k;o++)
			{			  
			   qry="select to_char(nvl(NOOFSEATS,0)) NOS, to_char(nvl(BALANCESEAT,0)) AVS , to_char(nvl(ALLOTEDSEATS,0)) ALS , TO_CHAR(NVL(WAITNO,0)) WAITNO,alpha from C#SEATDISPLAY where INSTITUTECODE||PROGRAMCODE||BRANCHCODE='"+bArray[o]+"' And CATEGORYCODE='"+yourCat[jk]+"'  and nvl(NOOFSEATS,0)>=0 ORDER BY alpha";			 
			   rs=db.getRowset(qry);			
			   if(rs.next())
			     {	
				seatArray[0][o]=rs.getString(2);
				seatArray[1][o]=rs.getString(3);			
				seatArray[3][o]=rs.getString(4);			

				String mName=bArray[o]+yourCat[jk]+bArray[o];

				if(session.getAttribute(mName)!=null)
					{	
					if(session.getAttribute(mName).toString().trim().equals(seatArray[0][o]+seatArray[3][o]))
							seatArray[2][o]="White";					
					else
						seatArray[2][o]="#ff3300";											 				 		
					}
				else
					seatArray[2][o]="white";					


				session.setAttribute(mName,String.valueOf(seatArray[0][o]+seatArray[3][o]));

			%>
				<td align=right><font  SIZE=5 FACE=VERDANA color='Blue'><b><%=rs.getString(1)%></b></font>&nbsp;&nbsp;&nbsp;</td>		
			<%
			} // closing of IF

		}//closing of for loop local

	%>
		</tr>
		<tr bgcolor=white>
		<%
		for(int o=mLastK;o<=k;o++)
		{
			String fclor="Green";
			if(seatArray[2][o].equals("#ff3300"))
				 fclor="White";
			 %>
				<td align=right bgcolor="<%=seatArray[2][o]%>"><font FACE=VERDANA SIZE=5 color=blue><b><%=seatArray[1][o]%></b></font>&nbsp;&nbsp;&nbsp;</td>		
			 <%
		}
		%>
		</tr>
		<tr bgcolor=white>	
		<%
		for(int o=mLastK;o<=k;o++)
		{
			String fclor="Red";
			//out.print(seatArray[2][o]);
			if(seatArray[2][o].equals("#ff3300"))			 
				fclor="White";
			  %>
				<td align=right bgcolor="<%=seatArray[2][o]%>"><font SIZE=5 FACE=VERDANA color='blue'><b><%=seatArray[0][o]%></b></font>&nbsp;&nbsp;&nbsp;</td>		
			 <%
		}
		%>
	 </td>
	</tr>			

		<tr>	
		<%
		if( mShowSeatWait.equals("Y") )
		{
			for(int o=mLastK;o<=k;o++)
			{
			   String fclor="Red";			
			   if(seatArray[2][o].equals("#ff3300"))			 
				fclor="White";
			 %>
				<td align=right bgcolor="<%=seatArray[2][o]%>"><font SIZE=5  FACE=VERDANA color='<%=fclor%>'><b><%=seatArray[3][o]%></b></font>&nbsp;&nbsp;&nbsp;</td>		
			 <%
			}
		}
		%>
	 </td>
	</tr>			

	</table>
    <%
   }// close if data
   }// close if 
   }// closing of institute loop
%>
   </tr>			
  </table><br>
<%	
}  //if
}  // closing of for loop


if(mGen==1)
 {
		if(ExcludeInst.equals("Y"))
		{
		   mExclude="Bio Informatics/";
		}
%>
<table width='100%'><tr><td><font color=black face=verdana size=3><b>* Excludes Seats</b>: &nbsp; &nbsp;[A] NRI seats &nbsp;&nbsp;[B] 50% seats of Bio Tech/<%=mExclude%>B-Pharma</b></font></td></tr></table>
<%
if(mTotCat==1)
{
%>
<br>
<%
}
}


 	long mBoys=0;
	long mGirls=0;
	long mBoysWait=0;
	long mGirlsWait=0;
	String mrsp="",mSh="";

	if(mShowHostel.equals("Y"))
	{
		 if(mShowHostelWait.equals("Y"))
		  {
			mSh=" colspan=2 ";
			mrsp=" rowspan=2 ";
		  }
		%>		
		<table border=1 width='100%' CELLspacing=0 bordercolor="#696969">
		<tr bgcolor="darkblue"><td align=center <%=mSh%>><font  FACE=VERDANA size=4 color=white><b>Hostel Seats Availability </b></font> </td>
		<td align=center ><font  FACE=VERDANA color=white size=4><b>For Boys</b></font></td>
		<td align=center ><font  FACE=VERDANA color=white size=4><b>For Girls</b></font></td>
		</tr>
		<%
		String[] yourInts = (String[]) session.getAttribute("mInstArray");
		int mHostFound=0;
		long mGTotH=0, mGAllotH=0,mBTotH=0, mBAllotH=0;
		for (int mis=0;mis<yourInts.length;mis++)
		 {
			mBoysWait=0;
			mGirlsWait=0;
			if( yourInts[mis]!=null)
			 {
			mHostFound=0;
			qry="select Nvl(TOTALSEATS,0) from C#HOSTELMASTER  where INSTITUTECODE ='"+yourInts[mis]+"' and nvl(DEACTIVE,'N')='N'";
      		rs=db.getRowset(qry);				
			if (rs.next())
			{
			 mHostFound=1;
			} 
		     if(mHostFound==1)
			{
			 mGTotH=0;
			 mGAllotH=0;
			 mBTotH=0;
			 mBAllotH=0;
			qry="select Nvl(TOTALSEATS,0)-nvl(ALLOTEDSEATS,0) AvlHos,Nvl(TOTALSEATS,0) TOTALSEATS,Nvl(ALLOTEDSEATS,0) ALLOTEDSEATS  from C#HOSTELMASTER  ";
			qry=qry+" where INSTITUTECODE ='"+yourInts[mis]+"' and nvl(HOSTELFOR,'M')='M' and nvl(DEACTIVE,'N')='N'";
      			rs=db.getRowset(qry);			
			//out.print(qry);
			if(rs.next())
				{
				 mBoys=rs.getLong(1);	
				 mBTotH=rs.getLong(2);
				 mBAllotH=rs.getLong(3);
				}
				else
				{ 
				mBoys=0;
				}
						
 
				qry="select Nvl(TOTALSEATS,0)-nvl(ALLOTEDSEATS,0) AvlHos,Nvl(TOTALSEATS,0) TOTALSEATS,Nvl(ALLOTEDSEATS,0) ALLOTEDSEATS from C#HOSTELMASTER  ";
				qry=qry+" where INSTITUTECODE ='"+yourInts[mis]+"' and nvl(HOSTELFOR,'M')='F' and nvl(DEACTIVE,'N')='N'";
			      rs=db.getRowset(qry);			
				if(rs.next()) 
					{
						mGirls=rs.getLong(1);
						mGTotH=rs.getLong(2);
						mGAllotH=rs.getLong(3);
					}
					else
					{
					 mGirls=0;	
					}

				qry = "Select Nvl(ALLOTEDBRANCH,'*') BRANCHALLOTED, NVL(HostelCodeAlloted,'N') HostelCodeAlloted ,";
				qry= qry + " Nvl(ALLOTEDINSTITUTE,'*') BRANCHAGAINSTINST , CHOICES, Nvl(ALLOTEDALPHA,'*') ALPHA , nvl(FORMERINSTITUTE,'*')||'-'||nvl(FORMERBRANCH,'*') LastBranch";
				qry= qry + " From C#ALLOCATIONDETAIL where COUNSELLINGID='"+mCYear+"' and COUNSELLINGNO='"+mCNO+"' and PROGRAMTYPE='"+mProgType+"'";
				qry= qry + " And RANK is not null and Nvl(ABSENT,'N')='N' and NVL(COUNSELLINGDONE,'N')='Y' And nvl(DEFAULTER,'N')='N' ";
				//qry= qry + " And NVL(HOSTELREQUIRED,'N') ='Y'";
				qry= qry + " And nvl(ALLOTEDBRANCH,'*')<>'*' And (HostelCodeAlloted is not null or Nvl(HostelWaiting,'N')='Y') And Rank in (select Rank from C#StudentMaster where sex='M') ORDER BY RANK";
				StudentRecordSet = db.getRowset(qry);
				//out.print(qry);
				while (StudentRecordSet.next())								
				 {	
					String mBranchAlot=StudentRecordSet.getString("BRANCHALLOTED");          
					String mBranchAgainstInst=StudentRecordSet.getString("BRANCHAGAINSTINST");
					String mAlpha=StudentRecordSet.getString("ALPHA");       
					String mChoices=StudentRecordSet.getString("CHOICES");
					String mLastBranch=StudentRecordSet.getString("LastBranch");
					String mHostelCodeAlloted=StudentRecordSet.getString("HostelCodeAlloted");
					char mAlp=mAlpha.charAt(0);	
					int i=0;
				 	i=mChoices.indexOf(mAlp);
					String mCh=mChoices.substring(0,i+1);
				char choice[]=mCh.toCharArray();	

				qry="Select InstituteCode   From C#HostelMaster Where HostelCode='"+mHostelCodeAlloted+"'";
				//out.print(qry);
				BranchRecordSet= db.getRowset(qry); 				
				if (BranchRecordSet.next())
				{
					mHostelCodeAlloted=BranchRecordSet.getString(1);
				}


				if(choice.length>=1)
				   {
					for(int j=0;j<choice.length;j++)
		    		  	   {				
						 //if(choice[j]!=(mAlp))	
						 //  {
							qry="Select BRANCHCODE BCODE,ALPHA From C#SeatMaster Where INSTITUTECODE ='"+yourInts[mis]+"' And ALPHA='"+choice[j]+"'";
							BranchRecordSet= db.getRowset(qry); 				
					  		if (BranchRecordSet.next())
							 {
								if(!yourInts[mis].equals(mHostelCodeAlloted))							
								{
									mBoysWait++;
									j=choice.length+2;
								}
			
							 }
						 // }
						}						
					}	

			 }

		// For Girls Hostel Wait List

			qry = "Select Nvl(ALLOTEDBRANCH,'*') BRANCHALLOTED, NVL(HostelCodeAlloted,'N') HostelCodeAlloted, Nvl(HostelWaiting,'N') HostelWaiting, ";
			qry= qry + " Nvl(ALLOTEDINSTITUTE,'*') BRANCHAGAINSTINST , CHOICES, Nvl(ALLOTEDALPHA,'*') ALPHA , nvl(FORMERINSTITUTE,'*')||'-'||nvl(FORMERBRANCH,'*') LastBranch";
			qry= qry + " From C#ALLOCATIONDETAIL where COUNSELLINGID='"+mCYear+"' and COUNSELLINGNO='"+mCNO+"' and PROGRAMTYPE='"+mProgType+"'";
			qry= qry + " And RANK is not null and Nvl(ABSENT,'N')='N' and NVL(COUNSELLINGDONE,'N')='Y' And nvl(DEFAULTER,'N')='N' ";
			//qry= qry + " And NVL(HOSTELREQUIRED,'N') ='Y'";
			qry= qry + " And nvl(ALLOTEDBRANCH,'*')<>'*'  And (HostelCodeAlloted is not null or Nvl(HostelWaiting,'N')='Y') And Rank in (select Rank from C#StudentMaster where sex='F') ORDER BY RANK";

			StudentRecordSet = db.getRowset(qry);
			//out.print(qry);
			while (StudentRecordSet.next())								
			 {	
				String mBranchAlot=StudentRecordSet.getString("BRANCHALLOTED");          
				String mBranchAgainstInst=StudentRecordSet.getString("BRANCHAGAINSTINST");
				String mAlpha=StudentRecordSet.getString("ALPHA");       
				String mChoices=StudentRecordSet.getString("CHOICES");
				String mLastBranch=StudentRecordSet.getString("LastBranch");
				String mHostelCodeAlloted=StudentRecordSet.getString("HostelCodeAlloted");
				char mAlp=mAlpha.charAt(0);	
				int i=0;
			 	i=mChoices.indexOf(mAlp);
				String mCh=mChoices.substring(0,i+1);
				char choice[]=mCh.toCharArray();	

				qry="Select InstituteCode   From C#HostelMaster Where HostelCode='"+mHostelCodeAlloted+"'";
				//out.print(qry);
				BranchRecordSet= db.getRowset(qry); 				
				if (BranchRecordSet.next())
				{
					mHostelCodeAlloted=BranchRecordSet.getString(1);
				}

				if(choice.length>=1)
				   {
					for(int j=0;j<choice.length;j++)
			    	  	   {				
						 //if(choice[j]!=(mAlp))	
						 //  {
							qry="Select BRANCHCODE BCODE,ALPHA From C#SeatMaster Where INSTITUTECODE ='"+yourInts[mis]+"' And ALPHA='"+choice[j]+"'";
							//out.print(qry);
							BranchRecordSet= db.getRowset(qry); 				
					  		if (BranchRecordSet.next())
							 {
								//out.print(qry);
								if(!yourInts[mis].equals(mHostelCodeAlloted))
								{
									mGirlsWait++;
									//System.out.print(" mGirlsWait "+mGirlsWait);
									j=choice.length+2;
								}
	
							 }
						 // }
						}						
					}





			 }



				 qry="select nvl(shortname,INSTITUTECODE) shortname from C#institutemaster where institutecode='"+yourInts[mis]+"'";
				 rs=db.getRowset(qry);		

				 if (rs.next())
				   mDispInst=rs.getString(1);
				 else
				   mDispInst=yourInts[mis];

					 %>
				 <tr>
					<td <%=mrsp%> align=center><font  FACE=VERDANA size=4><b><%=mDispInst%></b>&nbsp; &nbsp; </font></td>
					<% if(mShowHostelWait.equals("Y"))
					{
						%>
						<td align=center><font  FACE=VERDANA  size=5><b>Available</b></font></td>
						<%
					}
					if(mBoys<0) mBoys=0;
					if(mGirls<0) mGirls=0;
					%>
						<td align=center><font  FACE=VERDANA  size=5><b><%=mBTotH%>-<%=mBAllotH%> = <%=mBoys%></b></font></td>
						<td align=center><font  FACE=VERDANA  size=5><b><%=mGTotH%>-<%=mGAllotH%> = <%=mGirls%></b></font></td>
				</tr>
				<%
				 if(mShowHostelWait.equals("Y"))
				{
				%>
				<tr><td align=center><font  FACE=VERDANA  color=red size=3><b>Wait Listed</b></font></td>
				    <td align=center><font  FACE=VERDANA color=red size=3><b><%=mBoysWait%></b></font></td>
				    <td align=center><font  FACE=VERDANA color=red size=3><b><%=mGirlsWait%></font></b></td>
				</tr>
				 <%
				}
			}//mHostFound=1
			}//if( yourInts[mis]!=null)
		}//for (int mis=0;mis<yourInts.length;mis++)
	   %>
		</table>
 	   <%
	}//if(mShowHostel.equals("Y"))


%>
<TR>
<TD>
	<%
	if(mTotCat==1)
	{
	 out.print("<br><br><br>");
	}
	else
	{
	out.print("<br>");
	}
	%>
<table width='100%'>
<tr><td valign=bottom bgcolor='red'><font  FACE=VERDANA color="White" size=4>
<%
qry="select CounsellingMsg from C#Current Where CounsellingMsg is not null ";
rs=db.getRowset(qry);
while (rs.next())
{
%>
<marquee width='100%' scrolldelay=150><b><%=rs.getString(1)%></marquee>
<%
}
%>
</font></td></tr></table>
</TD>
</TR>
</table>
</marquee>
</td></tr>
</table>
<%
}
else
{
%>
Wait processing...
<%
}

} // closing of if

	

%>
</table>

<%
}

}
catch(Exception e)
{
out.print("Error, While Fetching Datan");
}
%>

</center>
</BODY>
</HTML>