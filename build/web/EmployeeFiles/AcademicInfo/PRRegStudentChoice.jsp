<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null,rss1=null;
String studname="",enroll="",qrys="",qrys1="";
ResultSet rss=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="",qry1="";
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInstitute="";
String mSemType="";
String mRunStatus="", mDept="";
String mExam="",mexam="";
String mProg="",mprog="";
String mElec="",melec="";
String mEC="",mPC="",mEL="",mPC1="",mSB="";
int len=0,pos=0,maxCol=0,ctr=0;
String mprog1="",mProg1="";
String melec1="",mElec1="",mpr="",msb="",mpr1="",msb1="";
String mSect="",msect="",mSectd="";

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
 
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Student subject choice ] </TITLE>

<script language=javascript>
	
	function RefreshContents()
	{ 	
    	    document.frm.x.value='ddd';
    	    document.frm.submit();
	}
//-->
</script>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">
function ChangeOptions(Exam,DataComboProgram,DataComboSection,DataComboElective,ProgramCode,SectionBranch,ElectiveCode)
  {
    removeAllOptions(ProgramCode);
	
	var mflag=0;
	for(i=0;i<DataComboProgram.options.length;i++)
       {	
		var v1;
		var pos;
		var exam;
		var pc;
		var len;
		var otext;
		var v1=DataComboProgram.options[i].value;
		len= v1.length ;	
		pos=v1.indexOf('***');
		exam=v1.substring(0,pos);
		pc=v1.substring(pos+3,len);
		if (exam==Exam)
		 { 	
			var optn = document.createElement("OPTION");
			optn.text=DataComboProgram.options[i].text;
			optn.value=pc;			
			ProgramCode.options.add(optn);
		}

	}
	removeAllOptions(SectionBranch);
	 mflag=0;
	var oldscse='?';
	for(i=0;i<DataComboSection.options.length;i++)
       {	
		
		var v1s;
		var pos1;
		var pos2;
		var exams;
		var scs;
		var lens;
		var scse;
		var otexts;
		var v1s=DataComboSection.options[i].value;
		lens= v1s.length ;	
		pos1=v1s.indexOf('***');
		pos2=v1s.indexOf('///')
		exams=v1s.substring(0,pos1);
		scs=v1s.substring(pos1+3,pos2);
		scse=v1s.substring(pos2+3,lens);
		if (exams==Exam && scse!=oldscse)
		 { 	
			var optns = document.createElement("OPTION");
			optns.text=DataComboSection.options[i].text;
			optns.value=scse;
			SectionBranch.options.add(optns);
			oldscse=scse;
		}
	}	
		
	removeAllOptions(ElectiveCode);
	oldscse='?';
	for(i=0;i<DataComboElective.options.length;i++)
       {	
		var v1s1;
		var pos1;
		var pos2;
		var pos3;
		var exams1;
		var scs1;
		var lens1;
		var scse1;
		var otexts1;
		var subsec;
		var v1s1=DataComboElective.options[i].value;
		lens1= v1s1.length ;	
		pos11=v1s1.indexOf('***');
		pos21=v1s1.indexOf('///');
		pos3=v1s1.indexOf('*****');
		exams=v1s1.substring(0,pos11);
		scs1=v1s1.substring(pos11+3,pos21);
		scse1=v1s1.substring(pos21+3,pos3);
		subsec=v1s1.substring(pos3+5,lens1);

		if (exams==Exam && subsec!=oldscse)
		 { 			
			oldscse=subsec;
			var optns1 = document.createElement("OPTION");
			optns1.text=DataComboElective.options[i].text;
			optns1.value=subsec;
			ElectiveCode.options.add(optns1);
		}
	}		
}

//********Click event on Program**********
function ChangeOptions1(Exam,prog,DataComboSection,DataComboElective,SectionBranch,ElectiveCode)
{
  //alert(DataComboSection.value);
	var mflag=0;
	var ssec='ALL';
	removeAllOptions(SectionBranch);
	 mflag=0;
	var oldsec='?';
	
	for(i=0;i<DataComboSection.options.length;i++)
       {	
		var v1s;
		var pos1;
		var pos2;
		var exams;
		var scs;
		var lens;
		var scse;
		var otexts;
		var v1s=DataComboSection.options[i].value;
//alert(v1s);
		lens= v1s.length ;	
		pos1=v1s.indexOf('***');
		pos2=v1s.indexOf('///')
		exams=v1s.substring(0,pos1);
		scs=v1s.substring(pos1+3,pos2);
		scse=v1s.substring(pos2+3,lens);
		
		if (exams==Exam && oldsec!=scse)
		{   
			
		 if(prog==scs)
		 { 	oldsec=scse;			
			var optns = document.createElement("OPTION");
			optns.text=DataComboSection.options[i].text;
			optns.value=scse;
			SectionBranch.options.add(optns);
		}
	}	

	}	
		
	removeAllOptions(ElectiveCode);
			
			 oldsec='?';
	for(i=0;i<DataComboElective.options.length;i++)
       {	
		var v1s1;
		var pos1;
		var pos2;
		var pos3;
		var exams1;
		var scs1;
		var lens1;
		var scse1;
		var otexts1;
		var subsec;
		var v1s1=DataComboElective.options[i].value;

		lens1= v1s1.length ;	
		pos11=v1s1.indexOf('***');
		pos21=v1s1.indexOf('///');
		pos3=v1s1.indexOf('*****');
		exams=v1s1.substring(0,pos11);
		scs1=v1s1.substring(pos11+3,pos21);
		scse1=v1s1.substring(pos21+3,pos3);
		subsec=v1s1.substring(pos3+5,lens1);

		if (exams==Exam && oldsec!=subsec)  
		 { 			
			
			if(prog==scs1)
			{oldsec=subsec;
			var optns1 = document.createElement("OPTION");
			optns1.text=DataComboElective.options[i].text;
			optns1.value=subsec;
			ElectiveCode.options.add(optns1);
			}		
		}
	}		
}

//************click event on sectionbranch***********
function ChangeOptions2(Exam,prog,ssec,DataComboElective,ElectiveCode)
  {
    
	removeAllOptions(ElectiveCode);
			
			var oldsubsec='?';
	for(i=0;i<DataComboElective.options.length;i++)
       {	
		var v1s1;
		var pos1;
		var pos2;
		var pos3;
		var exams1;
		var scs1;
		var lens1;
		var scse1;
		var otexts1;
		var subsec;
		var v1s1=DataComboElective.options[i].value;
		lens1= v1s1.length ;	
		pos11=v1s1.indexOf('***');
		pos21=v1s1.indexOf('///');
		pos3=v1s1.indexOf('*****');
		exams=v1s1.substring(0,pos11);
		scs1=v1s1.substring(pos11+3,pos21);
		scse1=v1s1.substring(pos21+3,pos3);
		subsec=v1s1.substring(pos3+5,lens1);
		if (exams==Exam && oldsubsec!=subsec )
		 { 		
			if(ssec==scse1)		
			{
			oldsubsec=subsec;	
			var optns1 = document.createElement("OPTION");
			optns1.text=DataComboElective.options[i].text;
			optns1.value=subsec;
			ElectiveCode.options.add(optns1);
			}
		}
	}		
}
function removeAllOptions(selectbox)
{
var i;
for(i=selectbox.options.length-1;i>=0;i--)
{
selectbox.remove(i);
}
}

</SCRIPT>	

<script>
	if(window.history.forward(1) != null)
	window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
try
{
	OLTEncryption enc=new OLTEncryption();

	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{
		mDMemberID=enc.decode(mMemberID);
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);
		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk=null;

		
if (session.getAttribute("InstituteCode")==null)
{
	mInstitute="";
	
}
else
{
	mInstitute=session.getAttribute("InstituteCode").toString().trim();
	
}

	     //-----------------------------
	     //-- Enable Security Page Level  
	     //-----------------------------

		qry="Select WEBKIOSK.ShowLink('123','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
		  //----------------------
%>
			<form name="frm"  method="get" >
				<input id="x" name="x" type=hidden>
				<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
				<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">Students choices of electives.</TD>
				</font></td></tr>
				</TABLE>
				<table cellpadding=1 cellspacing=0 width="99%" align=center rules=groups border=3>
				<!--Institute****-->
				<INPUT name=InstCode TYPE=HIDDEN id="InstCode" VALUE='<%=mInstitute%>'>
				<tr>
				

				<!--*********Exam**********-->
				<td><FONT color=black><FONT face=Arial size=2><STRONG>Exam Code</STRONG></FONT></FONT>
				&nbsp; &nbsp; &nbsp;

				<%
				try
				{
					qry=" SELECT distinct a.EXAMCODE exam ,to_date(a.FROMDATE,'dd-mm-yyyy')dd from PREVENTMASTER a WHERE a.INSTITUTECODE='"+ mInstitute +"' and nvl(a.PRCOMPLETED,'N')='N' and nvl(a.PRBROADCAST,'N')='Y'";
					qry=qry+" AND NVL(PRREQUIREDFOR,'S')<>'S' AND NVL(a.DEACTIVE,'N')='N' order by dd desc ";
				//out.print(qry);
					rs=db.getRowset(qry);
					if (request.getParameter("x")==null) 
				 	  {
						%>
						<select name=Exam tabindex="0" id="Exam" style="WIDTH: 120px" onclick="ChangeOptions(Exam.value,DataComboProgram,DataComboSection,DataComboElective,ProgramCode,SectionBranch,ElectiveCode);" onChange="ChangeOptions(Exam.value,DataComboProgram,DataComboSection,DataComboElective,ProgramCode,SectionBranch,ElectiveCode);">	
						<%   
						while(rs.next())
						{
							mExam=rs.getString("Exam");
							if(mexam.equals(""))
 							mexam=mExam;
							%>
							<OPTION  Value =<%=mExam%>><%=rs.getString("Exam")%></option>
							<%
						}
							%>
						</select>
						<%
					 }
					else
					{
				%>	
					<select name=Exam tabindex="0" id="Exam" style="WIDTH: 120px" onclick="ChangeOptions(Exam.value,DataComboProgram,DataComboSection,DataComboElective,ProgramCode,SectionBranch,ElectiveCode);" onChange="ChangeOptions(Exam.value,DataComboProgram,DataComboSection,DataComboElective,ProgramCode,SectionBranch,ElectiveCode);">	
				<%
					while(rs.next())
					{
					mExam=rs.getString("Exam");
					if(mExam.equals(request.getParameter("Exam").toString().trim()))
					{
								mexam=mExam;
								%>
								<OPTION selected Value =<%=mExam%>><%=rs.getString("Exam")%></option>
								<%			
						     	}
						     	else
						         {
							//	mexam=mExam;
							%>
							     	<OPTION Value =<%=mExam%>><%=rs.getString("Exam")%></option>
					      	<%			
						   	}
						}
						%>
						</select>
					  	<%
					 }
				 }    
				catch(Exception e)
				{
				// out.println("Error Msg");
				}
				%>
</td>

<%
 // ************Data Combo Program Code and section branch 
try
				{
			qry="select distinct examcode, programcode from PR#ELECTIVESUBJECTS where ";
			qry=qry+" INSTITUTECODE='"+ mInstitute +"' and nvl(DEACTIVE,'N')='N' AND ";
			qry=qry+" examcode in (SELECT distinct a.EXAMCODE exam from PREVENTMASTER a WHERE a.INSTITUTECODE='"+ mInstitute +"' and nvl(a.PRCOMPLETED,'N')='N' and nvl(a.PRBROADCAST,'N')='Y'";
			qry=qry+" AND NVL(PRREQUIREDFOR,'S')<>'S' AND NVL(a.DEACTIVE,'N')='N') order by examcode,programcode ";
			rs=db.getRowset(qry);

        if (request.getParameter("x")==null) 
	  {
		%>
			<select name=DataComboProgram tabindex="0" id="DataComboProgram"  style="WIDTH:0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">		
		<%   
				while(rs.next())
				{
					mProg1=rs.getString("examcode")+"***"+rs.getString("programcode");
					%>
						<OPTION  selected Value=<%=mProg1%>><%=rs.getString("programcode")%></option>
					<%
				} // closing of while
					%>
						</select>
					<%
	  } // closing of if
	  else
	  {
		%>	
			<select name=DataComboProgram tabindex="0" id="DataComboProgram"  style="WIDTH:0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">		
		<%
			while(rs.next())
			{
			 mProg1=rs.getString("examcode")+"***"+rs.getString("programcode");
			if(mProg1.equals(request.getParameter("DataComboProgram").toString().trim()))
			{
				%>
					<OPTION selected Value =<%=mProg1%>><%=rs.getString("programcode")%></option>
				<%			
		     	}
		     	else
		         {
				%>
				<OPTION Value =<%=mProg1%>><%=rs.getString("programcode")%></option>
			     	<%			
			  }
			}
						%>
						</select>
					  	<%
					 }
				 }    
				catch(Exception e)
				{
				// out.println("Error Msg");
				}

%>

<!--*********Program Code**********-->
<td><FONT color=black><FONT face=Arial size=2><STRONG>Program Code</STRONG></FONT></FONT>
&nbsp;&nbsp;
	<%
	try
	{
			qry="select distinct programcode from PR#ELECTIVESUBJECTS where ";
			qry=qry+" INSTITUTECODE='"+ mInstitute +"' and nvl(DEACTIVE,'N')='N' AND ";
			qry=qry+" examcode='"+mexam+"' ";
			qry=qry+"  order by programcode";
			rs=db.getRowset(qry);
%>	
															
		<select name=ProgramCode tabindex="0" id="ProgramCode" style="WIDTH: 80px" onclick="ChangeOptions1(Exam.value,ProgramCode.value,DataComboSection,DataComboElective,SectionBranch,ElectiveCode);" onChange="ChangeOptions1(Exam.value,ProgramCode.value,DataComboSection,DataComboElective,SectionBranch,ElectiveCode);">	 
<%   
	if (request.getParameter("x")==null) 
	 {
		while(rs.next())
		{
			mProg=rs.getString("programcode");
			if(mprog.equals(""))
			{
				mprog=mProg;
			%>
				<OPTION  selected Value=<%=mProg%>><%=rs.getString("programcode")%></option>
			<%
			}
			else
			{
			%>
				<OPTION Value=<%=mProg%>><%=rs.getString("programcode")%></option>
			<%
			}
		} // closing of while
	 } // closing of if 
	 else
	{
		while(rs.next())
		{
			mProg=rs.getString("programcode");
			if(mProg.equals(request.getParameter("ProgramCode").toString().trim()))
 			{
			   mprog=mProg;
			%>
				<OPTION selected Value=<%=mProg%>><%=rs.getString("programcode")%></option>
			<%			
			}
			else
 	            {
				%>
					<OPTION Value =<%=mProg%>><%=rs.getString("programcode")%></option>
			    	<%			
			}
		 } // closing of while
 } // closing of else
					%>
						</select>
					  	<%
				 }    
				catch(Exception e)
				{
				// out.println("Error Msg");
				}

//******************Hidden DataComboSection
try
	{
			qry="select distinct examcode,programcode,sectionbranch from PR#ELECTIVESUBJECTS where ";
			qry=qry+" INSTITUTECODE='"+ mInstitute +"' and nvl(DEACTIVE,'N')='N'  ";
			// qry=qry+" AND examcode='"+mexam+"' and programcode='"+mprog+"' ";
			qry=qry+"  order by examcode,programcode,sectionbranch ";
			rs=db.getRowset(qry);
%>
		<select name=DataComboSection tabindex="0" id="DataComboSection"  style="WIDTH:0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">		
<%   
	if (request.getParameter("x")==null) 
	{
		while(rs.next())
		{
		 mSectd=rs.getString("examcode")+"***"+rs.getString("programcode")+"///"+rs.getString("sectionbranch");
	%>
				<OPTION  selected Value=<%=mSectd%>><%=rs.getString("sectionbranch")%></option>
			<%
		}
	 }
	else
	{
		while(rs.next())
		{
			 mSectd=rs.getString("examcode")+"***"+rs.getString("programcode")+"///"+rs.getString("sectionbranch");
			if(mSectd.equals(request.getParameter("DataComboSection").toString().trim()))
			{
		%>
				<OPTION selected Value=<%=mSectd%>><%=rs.getString("sectionbranch")%></option>
		<%			
		     	}
		     	else
 	            {
			%>
			<OPTION Value =<%=mSectd%>><%=rs.getString("sectionbranch")%></option>
		     	<%			
			}
		 } // closing of while
						
	 } // closing of else
					%>
						</select>
					  	<%
				 }    
				catch(Exception e)
				{
				// out.println("Error Msg");
				}
//************************

				%>
				</td>
			<!-- ************section branch-->
<td><FONT color=black><FONT face=Arial size=2><STRONG>Section Branch</STRONG></FONT></FONT>
<%
	try
	{

		//out.print(mexam+";pkoklklkl");
			qry="select distinct sectionbranch from PR#ELECTIVESUBJECTS where ";
			qry=qry+" INSTITUTECODE='"+ mInstitute +"' and nvl(DEACTIVE,'N')='N' AND ";
			qry=qry+" examcode='"+mexam+"' and programcode='"+mprog+"' ";
			qry=qry+"  order by sectionbranch ";
		//	out.print(qry);
			rs=db.getRowset(qry);
%>
		<select name=SectionBranch tabindex="0" id="SectionBranch" style="WIDTH: 80px" onclick="ChangeOptions2(Exam.value,ProgramCode.value,SectionBranch.value,DataComboElective,ElectiveCode);" onChange="ChangeOptions2(Exam.value,ProgramCode.value,SectionBranch.value,DataComboElective,ElectiveCode);">	 
<%   
	if (request.getParameter("x")==null) 
	{
		while(rs.next())
		{
		 mSect=rs.getString("sectionbranch");
      		if(msect.equals(""))
			{
				msect=mSect;
			%>
				<OPTION  selected Value=<%=mSect%>><%=rs.getString("sectionbranch")%></option>
			<%
			}
		}
	 }
	else
	{
		while(rs.next())
		{
			mSect=rs.getString("sectionbranch");
			if(mSect.equals(request.getParameter("SectionBranch").toString().trim()))
			{
			   msect=mSect;
		%>
				<OPTION selected Value=<%=mSect%>><%=rs.getString("sectionbranch")%></option>
		<%			
		     	}
		     	else
 	            {
			%>
			<OPTION Value =<%=mSect%>><%=rs.getString("sectionbranch")%></option>
	     	<%			
			}
		 } // closing of while
						
	 } // closing of else
					%>
						</select>
					  	<%
				 }    
				catch(Exception e)
				{
				// out.println("Error Msg");
				}
			%>
				</td>
				</tr>
				<tr>
				<td>
				<FONT color=black><FONT face=Arial size=2><STRONG>Elective code</STRONG></FONT></FONT>
				&nbsp;&nbsp;
				<%
		//*********Datacombo Elective Code**********************
		try
		{
				qry="select distinct examcode,programcode,sectionbranch,nvl(electivecode,' ')electivecode from PR#ELECTIVESUBJECTS where institutecode='"+mInstitute+"'  ";
				qry=qry+" and nvl(DEACTIVE,'N')='N' order by examcode,programcode,sectionbranch,electivecode ";
				//out.print(qry);
				rs=db.getRowset(qry);
					if (request.getParameter("x")==null) 
				 	  {
						%>
						<select name=DataComboElective tabindex="0" id="DataComboElective"  style="WIDTH:0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">		
						<%   
						while(rs.next())
					{
				mElec1=rs.getString("examcode")+"***"+rs.getString("programcode")+"///"+rs.getString("sectionbranch")+"*****"+rs.getString("electivecode");
			%>
							<OPTION selected Value ="<%=mElec1%>"><%=rs.getString("electivecode")%></option>
				<%
						}
							%>
						</select>
						<%
					 }
					else
					{
					%>	
						<select name=DataComboElective tabindex="0" id="DataComboElective"  style="WIDTH:0px;background-color:transparent;border-bottom-style:hidden; border-left-style:hidden; border-right-style:hidden;border-top-style:hidden; ">		
						<%
						while(rs.next())
						{
						mElec1=rs.getString("examcode")+"***"+rs.getString("programcode")+"///"+rs.getString("sectionbranch")+"*****"+rs.getString("electivecode");
						if(mElec1.equals(request.getParameter("DataComboElective").toString().trim()))
				 			{
									melec1=mElec1;
								%>
							<OPTION selected Value ="<%=mElec1%>"><%=rs.getString("electivecode")%></option>
							<%			
						     	}
						     	else
						         {
							%>
							<OPTION Value ="<%=mElec1%>"><%=rs.getString("electivecode")%></option>
						     	<%			
						   	}
						}
						%>
						</select>
					  	<%
					 }
				 }    
				catch(Exception e)
				{
				// out.println("Error Msg");
				}


//***********Elective code*******
				try
				{
				qry="select distinct nvl(electivecode,' ')electivecode from PR#ELECTIVESUBJECTS where institutecode='"+mInstitute+"'  ";
				qry=qry+" and examcode='"+mexam+"' and programcode='"+mprog+"' and sectionbranch='"+msect+"' and nvl(DEACTIVE,'N')='N' order by electivecode ";
			//	out.print(qry);
				rs=db.getRowset(qry);
					if (request.getParameter("x")==null) 
				 	  {
						%>
						<select name="ElectiveCode" tabindex="0" id="ElectiveCode" style="WIDTH: 120px">	
						<%   
						while(rs.next())
						{
							mElec=rs.getString("electivecode");
							%>
							<OPTION selected Value ="<%=mElec%>"><%=mElec%></option>
							<%
						}
							%>
						</select>
						<%
					 }
					else
					{
					%>	
						<select name="ElectiveCode" tabindex="0" id="ElectiveCode" style="WIDTH: 120px">	
						<%
						while(rs.next())
						{
							mElec=rs.getString("electivecode").toString().trim(); System.out.print("<BR>"+mElec+"xx"+request.getParameter("ElectiveCode"));
							
							if(mElec.equals(request.getParameter("ElectiveCode").toString().trim()))
				 			{
									melec=mElec;
								%>
							<OPTION selected Value ="<%=mElec%>"><%=mElec%></option>
							<%			
						     	}
						     	else
						         {
							%>
							<OPTION Value ="<%=mElec%>"><%=mElec%></option>
						     	<%			
						   	}
						}
						%>
						</select>
					  	<%
					 }
				 }    
				catch(Exception e)
				{
				// out.println("Error Msg");
				}
				%>
			</td>
			<td>
		<INPUT Type="submit" Value="Show/Refresh"></td></tr>
		</td</tr>
		</table>
		</form>
	<%
	if(request.getParameter("x")!=null)
	{
		if(request.getParameter("Exam")==null)
			mEC="";
		else
			mEC=request.getParameter("Exam").toString().trim();
		if(request.getParameter("ProgramCode")==null)	
			mPC="";
		else
			mPC=request.getParameter("ProgramCode").toString().trim();
		if(request.getParameter("SectionBranch")==null)	
			mSB="";
		else
			mSB=request.getParameter("SectionBranch").toString().trim();
		if(request.getParameter("ElectiveCode")==null)
			mEL="";
		else
			mEL=request.getParameter("ElectiveCode").toString().trim();


		/*
		if(!mPC1.equals(""))
		{
				len=mPC1.length();
				pos=mPC1.indexOf("***");
				mPC=mPC1.substring(0,pos);
				mSB=mPC1.substring(pos+3,len);	
		}
		*/				
	%>
		<table cellspacing=0 cellpadding=0 border=1 align=center>
		<form name="frm2"  method="post" action="">
		<tr bgcolor="#c00000">

		<INPUT TYPE="hidden" NAME="ElectiveCode" ID="ElectiveCode" VALUE="<%=mEL%>">
		
		<td><b><font color=white>SNo.</font></b></td>
		<td nowrap><b><font color=white>Enroll. No</font></b></td>
		<td nowrap><b><font color=white>Student Name</font></b></td>
		<td nowrap><b><font color=white>Sem.</font></b></td>
	<%
	qry="select max(CHOICE) CHOICE from  PR#STUDENTSUBJECTCHOICE  where ";
	qry=qry+" INSTITUTECODE='"+mInstitute+"' And EXAMCODE='"+mEC+"'  ";
	qry=qry+" and programcode='"+mPC+"' and ";
	qry=qry+" sectionbranch='"+mSB+"' and electivecode LIKE '%"+mEL+"%' and nvl(DEACTIVE,'N')='N' ";
	
	//out.print(qry);
	rs=db.getRowset(qry);
	if (rs.next()) 
		maxCol=rs.getInt(1); 
	else 
		maxCol=0;
	for(int i=1;i<=maxCol;i++)
	{
%>
	<td nowrap><b><font color=white>Choice-<%=i%></font></b></td>
<%
	}
%>
	</tr>
<%
qry="select distinct studentid,semester from PR#STUDENTSUBJECTCHOICE where institutecode='"+mInstitute+"' ";
qry=qry+" and examcode='"+mEC+"' and programcode='"+mPC+"' and electivecode LIKE '%"+mEL+"%'  ";
qry=qry+" and sectionbranch='"+mSB+"' and nvl(deactive,'N')='N' ";
rs=db.getRowset(qry);
//out.print(qry);
while(rs.next())
{
ctr++;

qrys="select enrollmentno,studentname from studentmaster where studentid='"+rs.getString("studentid")+"' and nvl(DEACTIVE,'N')='N' ";
rss=db.getRowset(qrys);
if(rss.next())
{
	studname=rss.getString("studentname");
	enroll=rss.getString("enrollmentno");
}
else
{
	studname="";
	enroll="";
}
%>
<TR>
<td align=center><%=ctr%></td>
<td align=center><%=enroll%></td>
<td nowrap><%=GlobalFunctions.toTtitleCase(studname)%></td>
<td align=center><%=rs.getString("semester")%></td>
<%
for (int mCh=1;mCh<=maxCol;mCh++)
{
qry1="select subjectid from PR#STUDENTSUBJECTCHOICE where institutecode='"+mInstitute+"' and electivecode LIKE '%"+mEL+"%' ";
qry1=qry1+" and choice='"+mCh+"' and examcode='"+mEC+"' and programcode='"+mPC+"' AND STUDENTID='"+rs.getString("studentid")+"' ";
qry1=qry1+" and semester='"+rs.getInt("semester")+"' and sectionbranch='"+mSB+"' and nvl(deactive,'N')='N' ";
rs1=db.getRowset(qry1);
//out.print(qry1);
if(rs1.next())
{
 qrys1="select subjectcode from subjectmaster where subjectid='"+rs1.getString("subjectid")+"' and nvl(DEACTIVE,'N')='N' ";
 rss1=db.getRowset(qrys1);
 rss1.next();
%>
<td align=center><%=rss1.getString("subjectcode")%></td>
<%
}
else
{
%>
<td align=right>&nbsp;</td>
<%
}

} // closing of for
%>
</TR>
<%
	
}
		}
	
	 //-----------------------------
	 //-- Enable Security Page Level  
	  //-----------------------------


	    }
 	else
   	{
   %>
	<br>
	<font color=red>
	<h3><br><img src='../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font>	<br>	<br>	<br>	<br> 
   <%
  	}
  //-----------------------------
	}
	else
	{
		out.print("<br><img src='../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}      
}
catch(Exception e)
{
// out.print(e);
}
%>
</body>
</html>
