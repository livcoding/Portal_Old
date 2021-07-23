<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
ResultSet rs=null,rs1=null,rs2=null,rs3=null,rs5=null,rsc=null,rsl=null,rsm=null;
String mMemberID="",mDMemberID="",qry1="",moldMerge="",moldMerge1="",qrym="";
String mMemberName="";
String mMemberType="",mDMemberType="",mStudcnt="",mDis="",mvalue="";
String mHead="",moldemp="",moldemp1="";
String mDMemberCode="",mMemberCode="",mFac="",mfac="",mElective="";
String mInst="",mSection="",mSubsection="",mBasket="",mOfac="",mNameLMR="";
String qry="",Type="",mltp="",mSem="",mEmpid="",memp="",mName1="",mName2="",mNameLML="";
String mName3="",mName4="",mName5="",mName6="",mName7="",mName8="",mName9="",mName10="";
String [] mMultiFaculty=new String [1000];
int mL1=0;
int mT1=0;
int mP1=0;				
int mlt1=0;
int mFlag2=0,mFlag1=0,mFlag11=0;
int ctr=0;
int msno=0;
String mType="",mLTP="",mSubj="",mDept="",mSname="",mExamcode="",mSeccount="",mPrCode="";
int mL=0,mT=0,mP=0,mlt=0;
double mAssigned=0,mMin=0,mMax=0,mexcludeassign=0;
double mAssignedload=0,mMinload=0,mMaxload=0;
String mEmpidv="";
String mFacv="",mTyp="",mEmpTyp="",mcmp="",mEcmp="",mDuration="",mClass="",mSendhod="",mCompcode="";
String mSubjID="";

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
	mCompcode="";
}
else
{
	mCompcode=session.getAttribute("CompanyCode").toString().trim();
	//out.println(mCompcode);
}

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
if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
}
if (session.getAttribute("MemberName")==null)
{
	mMemberName="";
}
else
{
	mMemberName=session.getAttribute("MemberName").toString().trim();
}

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [HOD Load Distribution] </TITLE>
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
</script>
<script language=javascript>
	<!--
	function RefreshContents()
	{ 	
    	  document.frm.x.value='ddd';
    	  document.frm.submit();
	}


function ChangeOptions1(optn,work,dura,cla)
{

//alert("hello");
var len;
var pos;	
var pos1;
var pos2;
var sec;
var val;
var lr;
var name;
var myname;
var subcount;
var mainvalue;
var maivalue;

var len1;	
var pos1;
var pos11;
var pos21;
var pos3;	
var sec1;
var lr1;
var val1;
var subcount1;
var mtext;
var mynametxt;
var rmynametxt;
var mFlag=0;

var mlen;
var mpos1;
var mpos2;
var mpos3;
var mpos4;
var mpos5;
var mpos6;

var emp;
var assign;
var min;
var max;
var mfactyp;
var myobj;

len= optn.length ;	
pos=optn.indexOf('***');
pos1=optn.indexOf('///');
pos2=optn.indexOf('###');
sec=optn.substring(0,pos);
lr=optn.substring(pos+3,pos1);
val=optn.substring(pos1+3,pos2);
/*
subcount=optn.substring(pos2+3,len);
*/
subcount=0;
name=optn.substring(0,pos1);

len1= work.length ;	
pos1=work.indexOf('***');
pos11=work.indexOf('///');
pos21=work.indexOf('###');
pos3=work.indexOf('merge');	
sec1=work.substring(0,pos1);
lr1=work.substring(pos1+3,pos11);
val1=work.substring(pos11+3,pos21);
// subcount1=work.substring(pos21+3,pos3);

subcount1=0;
mtext=work.substring(pos3,len1);

for (var i = 0; i < document.frm1.elements.length; i++) 
{ 	
var e = document.frm1.elements[i]; 

	if ((e.type == 'select-one' || e.type=='text') && e.name!='Dept' && e.name!='Dura' && e.name!='Class1')
	   {
		for(var j=0; j <=subcount; j++)
		{	
			myname=name+'///'+j+'###'+subcount;
			rname=sec+'***R///'+j+'###'+subcount;
                           
			mynametxt=name+'///'+j+'###'+subcount+mtext;
			rmynametxt=sec+'***R///'+j+'###'+subcount+mtext;

			if(j==0 && e.type == 'select-one' && e.name==myname)
			{
				myobj=e;
				mainvalue=e.value;
				mFlag=1;
				mlen=mainvalue.length;
				mpos1=mainvalue.indexOf('***');
				mpos2=mainvalue.indexOf('///');
				mpos3=mainvalue.indexOf('###');
				mpos4=mainvalue.indexOf('*****');
				mpos5=mainvalue.indexOf('/////');
				mpos6=mainvalue.indexOf('$$$$');

				emp=mainvalue.substring(0,mpos1);
			//	assign=mainvalue.substring(mpos1+3,mpos2);
				assign=mainvalue.substring(mpos6+4,mlen);
				min=mainvalue.substring(mpos2+3,mpos3);
				max=mainvalue.substring(mpos3+3,mpos4);
				
				assign=parseFloat(assign);
				min=parseFloat(min);
				max=parseFloat(max);
		
						
				if(mainvalue!='NONE')
				{
				   e.value=mainvalue;
 				   rmynametxt.value='NONE';
				}
				else
				{
				e.value='NONE';
				}
			}
			 if (j>=0 && e.type == 'select-one' && e.name==rmynametxt) 
			 {
				if(mainvalue!='NONE')
				{
				   e.value='NONE';
 				 }
				else
				{
				e.value='NONE';
				}

			
			}	
			if( e.type == 'select-one' && e.name==rname)
			{
				e.value='NONE';
				
			}
		 }
	  }
   }
var p=Weightage(emp,assign,min,max,dura,cla);

		if(p>0)
		{
			myobj.value='NONE' ;
			ChangeOptions1(optn,work);
			
		}
}	

function ChangeOptions2(optn,work,dura,cla)
{
	/*alert(optn);
	alert(work);
	alert(dura);
	alert(cla);
	alert("hello");*/
var len;
var pos;	
var pos1;
var pos2;
var sec;
var val;
var lr;
var name;
var myname;
var subcount;
var mainvalue;
var maivalue;

var len1;	
var pos1;
var pos11;
var pos21;
var pos3;	
var sec1;
var lr1;
var val1;
var subcount1;
var mtext;
var mynametxt;
var rmynametxt;
var mFlag=0;

var mlen;
var mpos1;
var mpos2;
var mpos3;
var mpos4;
var mpos5;
var mpos6;
var emp;
var assign;
var min;
var max;
var mfactyp;
var myobj;

len= optn.length ;	
pos=optn.indexOf('***');
pos1=optn.indexOf('///');
pos2=optn.indexOf('###');
sec=optn.substring(0,pos);
lr=optn.substring(pos+3,pos1);
val=optn.substring(pos1+3,pos2);
/*
subcount=optn.substring(pos2+3,len);
*/
subcount=0;
name=optn.substring(0,pos1);

len1= work.length ;	
pos1=work.indexOf('***');
pos11=work.indexOf('///');
pos21=work.indexOf('###');
pos3=work.indexOf('merge');	
sec1=work.substring(0,pos1);
lr1=work.substring(pos1+3,pos11);
val1=work.substring(pos11+3,pos21);
// subcount1=work.substring(pos21+3,pos3);
subcount1=0;
mtext=work.substring(pos3,len1);

for (var i = 0; i < document.frm1.elements.length; i++) 
{ 	
var e = document.frm1.elements[i]; 
	if ((e.type == 'select-one' || e.type=='text') && e.name!='Dept' && e.name!='Dura' && e.name!='Class1')
	   {
		for(var j=0; j <=subcount; j++)
		{	
			myname=name+'///'+j+'###'+subcount;
			rname=sec+'***L///'+j+'###'+subcount;

			mynametxt=name+'///'+j+'###'+subcount+mtext;
			rmynametxt=sec+'***L///'+j+'###'+subcount+mtext;

			if(j==0 && e.type == 'select-one' && e.name==myname)
			{
				myobj=e;
				mainvalue=e.value;
				mFlag=1;

				mlen=mainvalue.length;
				mpos1=mainvalue.indexOf('***');
				mpos2=mainvalue.indexOf('///');
				mpos3=mainvalue.indexOf('###');
				mpos4=mainvalue.indexOf('*****');
				mpos5=mainvalue.indexOf('/////');
				mpos6=mainvalue.indexOf('$$$$');

				emp=mainvalue.substring(0,mpos1);
			//	assign=mainvalue.substring(mpos1+3,mpos2);
				assign=mainvalue.substring(mpos6+4,mlen);
				min=mainvalue.substring(mpos2+3,mpos3);
				max=mainvalue.substring(mpos3+3,mpos4);
			
			if(mainvalue!='NONE')
				{
				e.value=mainvalue;
				}
				else
				{
				e.value='NONE';
				}
			} 

			 if (j>=0 && e.type == 'select-one' && e.name==rmynametxt) 
			 {
				if(mainvalue!='NONE')
				{
				   e.value='NONE';
 				 }
				else
				{
				e.value='NONE';
				}
			}	

		if( e.type == 'select-one' && e.name==rname)
			{
				e.value='NONE';
			}
		
		 }
	  }
   }

		var p=Weightage(emp,assign,min,max,dura,cla);
		if(p>0)
		{
			myobj.value='NONE' ;
			ChangeOptions2(optn,work);
		}
	}

function  Weightage(emp,assign,min,max,dura,cla)
{
var len;
var pos1;
var pos2;
var pos3;	
var mainvalue;
var assignc=parseFloat(assign);
var minc=parseFloat(min);
var maxc=parseFloat(max);
var Dur=dura;
var mClass=cla;
var mTotal=dura*cla;
var ctr=0;
var empid;
var mFlag=0;

for (var i = 0; i < document.frm1.elements.length; i++) 
{ 	
var e = document.frm1.elements[i]; 
var e1 = document.frm1.elements[i+1]; 
var x=e.value;
pos1=x.indexOf('///0');
	
	if (e.type == 'select-one'  &&  e.name!='Dept' && pos1==-1)
	   {
				mainvalue=x;

				mlen=mainvalue.length;
				mpos1=mainvalue.indexOf('***');
				mpos2=mainvalue.indexOf('///');
				mpos3=mainvalue.indexOf('###');
				empid=mainvalue.substring(0,mpos1);
		if(e1!=null && e1.type== 'select-one')
		{
				
			if(emp==empid && e1.value=='NONE' && e1.type == 'select-one')			
			{
				ctr=ctr+1;
			}
		}
				
		var mT=parseFloat(ctr)*parseFloat(mTotal);
	      if((parseFloat(mT)+assignc)>maxc)
		{
			alert('Load assigned must be less than '+ max);
			mFlag=1;
			break;
		}
	}
}	
 return (mFlag);
}

function ChangeOptions3(optn,work)
{
var len;
var pos;	
var pos1;
var pos2;
var sec;
var val;
var lr;
var name;
var myname;
var subcount;
var mainvalue;
var maivalue;

var len1;	
var pos1;
var pos11;
var pos21;
var pos3;	
var sec1;
var lr1;
var val1;
var subcount1;
var mtext;
var mynametxt;
var rmynametxt;
var mFlag=0;

var mlen;
var mpos1;
var mpos2;
var mpos3;
var mpos4;
var mpos5;
var emp;
var assign;
var min;
var max;
var mfactyp;
var myobj;

len= optn.length ;	
pos=optn.indexOf('***');
pos1=optn.indexOf('///');
pos2=optn.indexOf('###');
sec=optn.substring(0,pos);
lr=optn.substring(pos+3,pos1);
val=optn.substring(pos1+3,pos2);
// subcount=optn.substring(pos2+3,len);
subcount=0;
name=optn.substring(0,pos1);

len1= work.length ;	
pos1=work.indexOf('***');
pos11=work.indexOf('///');
pos21=work.indexOf('###');
pos3=work.indexOf('merge');	
sec1=work.substring(0,pos1);
lr1=work.substring(pos1+3,pos11);
val1=work.substring(pos11+3,pos21);
// subcount1=work.substring(pos21+3,pos3);
subcount1=0;
mtext=work.substring(pos3,len1);
var msec ;
var x;
for (var i = 0; i < document.frm1.elements.length; i++) 
{ 	
	var e = document.frm1.elements[i]; 
	if ( e.type == 'select-one' && e.name!='Dept' && e.name!='Dura' && e.name!='Class1')
	   {
		for(var j=0; j <=subcount; j++)
		{	
			myname=name+'///'+j+'###'+subcount;
			rname=sec+'***R///'+j+'###'+subcount;

			 mynametxt=name+'///'+j+'###'+subcount+mtext;
			rmynametxt=sec+'***R///'+j+'###'+subcount+mtext;

	             if(j==0 && e.type == 'select-one' && e.name==mynametxt )
			{
				x = document.frm1.elements[i-1]; 

				mainvalue=e.value;
				mlen=mainvalue.length;
				mpos1=mainvalue.indexOf('***');
				
				assign=mainvalue.substring(mpos1+3,mlen);
				name=assign;
				
				break;
			}
		 }
	  }
   }

for (var i = 0; i < document.frm1.elements.length; i++) 
{ 
   var e = document.frm1.elements[i]; 
	if ( e.type == 'select-one' && e.name!='Dept' && e.name!='Dura' && e.name!='Class1')
	   {
			myname=name+'***L///0###0';
			if(e.type == 'select-one' && e.name==myname )
			{
				mainvalue=e.name;
				mlen=mainvalue.length;
				mpos1=mainvalue.indexOf('***');
			  var	msection=mainvalue.substring(0,mpos1);
				if(msection==assign)
				{
				x.value=e.value;
				}
			}
		  }	
}
}	

function ChangeOptions4(optn,work)
{
var len;
var pos;	
var pos1;
var pos2;
var sec;
var val;
var lr;
var name;
var myname;
var subcount;
var mainvalue;
var maivalue;

var len1;	
var pos1;
var pos11;
var pos21;
var pos3;	
var sec1;
var lr1;
var val1;
var subcount1;
var mtext;
var mynametxt;
var rmynametxt;
var mFlag=0;

var mlen;
var mpos1;
var mpos2;
var mpos3;
var mpos4;
var mpos5;
var emp;
var assign;
var min;
var max;
var mfactyp;
var myobj;

len= optn.length ;	
pos=optn.indexOf('***');
pos1=optn.indexOf('///');
pos2=optn.indexOf('###');
sec=optn.substring(0,pos);
lr=optn.substring(pos+3,pos1);
val=optn.substring(pos1+3,pos2);
// subcount=optn.substring(pos2+3,len);
subcount=0;
name=optn.substring(0,pos1);

len1= work.length ;	
pos1=work.indexOf('***');
pos11=work.indexOf('///');
pos21=work.indexOf('###');
pos3=work.indexOf('merge');	
sec1=work.substring(0,pos1);
lr1=work.substring(pos1+3,pos11);
val1=work.substring(pos11+3,pos21);
// subcount1=work.substring(pos21+3,pos3);
subcount1=0;
mtext=work.substring(pos3,len1);
var msec ;
var x;
for (var i = 0; i < document.frm1.elements.length; i++) 
{ 	
	var e = document.frm1.elements[i]; 
	if ( e.type == 'select-one' && e.name!='Dept' && e.name!='Dura' && e.name!='Class1')
	   {
		for(var j=0; j<=subcount; j++)
		{	
			myname=name+'///'+j+'###'+subcount;
			rname=sec+'***L///'+j+'###'+subcount;
			
	            mynametxt=name+'///'+j+'###'+subcount+mtext;
			rmynametxt=sec+'***R///'+j+'###'+subcount+mtext;
	            if(j==0 && e.type == 'select-one' && e.name==mynametxt )
			{
				x = document.frm1.elements[i-1]; 
				
				mainvalue=e.value;
				
				mlen=mainvalue.length;
				mpos1=mainvalue.indexOf('***');
				assign=mainvalue.substring(mpos1+3,mlen);
				name=assign;
				break;
			}
		 }
	  }
   }

for (var i = 0; i < document.frm1.elements.length; i++) 
{ 
   var e = document.frm1.elements[i]; 
	if ( e.type == 'select-one' && e.name!='Dept' && e.name!='Dura' && e.name!='Class1')
	   {
			myname=name+'***R///0###0';
			if(e.type == 'select-one' && e.name==myname )
			{
				mainvalue=e.name;
				
				mlen=mainvalue.length;
				mpos1=mainvalue.indexOf('***');
			  var	msection=mainvalue.substring(0,mpos1);
				if(msection==assign)
				{
				x.value=e.value;
				}
			}
		  }	
}
}	




//-->
</script>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
<script language=javascript>

function validate()
{
	/*alert(document.getElementById("FacultyChoice").value);
	alert(document.frm1.FacultyChoice.value);
	alert(document.frm1.Mergesection.value);
	alert(document.frm1.FacultyNChoice.value);
	alert(document.frm1.MergeSection1.value);*/

	if(document.getElementById("FacultyChoice").value=='NONE')
	{
		if(document.getElementById("FacultyNChoice").value=='NONE')
		{
			alert("Please Select either Faculty Having Choice or Faculty-No Choice");	
			return false;
		}
	}
	/*if(document.getElementById("Mergesection").value=='NONE')
	{
		if(document.getElementById("MergeSection1").value=='NONE')
		{
			alert("Please Select Merge With Section");	
			return false;
		}
	}*/
	//return false;
}

</script>
</head>
<body aLink=#ff00ff bgcolor='#fce9c5' rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
try
{
if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{	OLTEncryption enc=new OLTEncryption();
		mDMemberID=enc.decode(mMemberID);
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);

		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk=null;
		String mEle="";
		String SC="",qrye="",sc="";
		ResultSet rse=null;

	//	int a=0;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
  qry="Select WEBKIOSK.ShowLink('56','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
 	    RsChk= db.getRowset(qry);
	    if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	  	{
		  //----------------------
if (request.getParameter("SUBJID")==null)
{
	mSubjID="";
}
else
{
	mSubjID=request.getParameter("SUBJID").toString().trim();
}

if (request.getParameter("SUBJ")==null)
{
	mSubj="";
}
else
{
	mSubj=request.getParameter("SUBJ").toString().trim();
}
if (request.getParameter("TYPE")==null)
{
	mType="";
}
else
{
	mType=request.getParameter("TYPE").toString().trim();
}
if (request.getParameter("DEPT")==null)
{
	mDept="";
}
else
{
	mDept=request.getParameter("DEPT").toString().trim();
}
if (request.getParameter("ELECTIVECODE")==null || request.getParameter("ELECTIVECODE").equals("null"))
{
	mElective="";
}
else
{
	mElective=request.getParameter("ELECTIVECODE").toString().trim();
}

if (request.getParameter("LTP")==null)
{
	mLTP="";
}
else
{
	mLTP=request.getParameter("LTP").toString().trim();
}
if (request.getParameter("ELE")==null)
{
	mEle="";
}
else
{
	mEle=request.getParameter("ELE").toString().trim();
}
if (request.getParameter("BASKET")==null)
{
	mBasket="";
}
else
{
	mBasket=request.getParameter("BASKET").toString().trim();
}
if (request.getParameter("EXAM")==null)
{
	mExamcode="";
}
else
{
	mExamcode=request.getParameter("EXAM").toString().trim();
}
if (request.getParameter("SEM")==null)
{
	mSem="";
}
else
{
	mSem=request.getParameter("SEM").toString().trim();
}

qry="select subject from subjectmaster where subjectid='"+mSubjID+"' ";
rs=db.getRowset(qry);
if(rs.next())
mSname=rs.getString(1);		

if(mType.equals("C"))
  Type="Core";
else if(mType.equals("E"))
 Type="Elective";
else
 Type="Free Elective";

try
{

	/*
	qry1=" select nvl(LHOURS,0)L,nvl(THOURS,0)T,nvl(PHOURS,0)P, ";
	qry1=qry1+" nvl(LCLASSES,0)L1,nvl(TCLASSES,0)T1,nvl(PCLASSES,0)P1 from SUBJECTWISELTPHOURS where ";
	qry1=qry1+" institutecode='"+mInst+"' and EXAMCODE='"+mExamcode+"' and ";
	qry1=qry1+" SUBJECTID='"+mSubjID+"' and BASKET='"+mBasket+"' and (INSTITUTECODE, ";
	qry1=qry1+" EXAMCODE,ACADEMICYEAR, PROGRAMCODE, TAGGINGFOR, SECTIONBRANCH, ";
	qry1=qry1+" SEMESTER ) in (select INSTITUTECODE, EXAMCODE, ";
	qry1=qry1+" ACADEMICYEAR, PROGRAMCODE, TAGGINGFOR, SECTIONBRANCH, SEMESTER from ";
	qry1=qry1+" PROGRAMSUBJECTTAGGING WHERE EXAMCODE='"+mExamcode+"' AND SUBJECTID='"+mSubjID+"' )";
	qry1=qry1+" and NVL(DEACTIVE,'N')='N' ";
	*/

	qry1=" select nvl(LHOURS,0)L,nvl(THOURS,0)T,nvl(PHOURS,0)P, ";
	qry1=qry1+" nvl(LCLASSES,0)L1,nvl(TCLASSES,0)T1,nvl(PCLASSES,0)P1 from SUBJECTWISELTPHOURS where ";
	qry1=qry1+" institutecode='"+mInst+"' and EXAMCODE='"+mExamcode+"' and ";
	qry1=qry1+" SUBJECTID='"+mSubjID+"' and BASKET='"+mBasket+"'  ";
	qry1=qry1+" and NVL(DEACTIVE,'N')='N' ";

	rsl=db.getRowset(qry1);
	if(rsl.next())
	{
		  mL1=rsl.getInt("L");
		  mT1=rsl.getInt("T");
		  mP1=rsl.getInt("P");
	
		  mL=rsl.getInt("L1");
		  mT=rsl.getInt("T1");
		  mP=rsl.getInt("P1");

		if(mLTP.equals("L"))
		{
		  mltp="Lecture";
		  mlt=mL;
		  mlt1=mL1;
		}
		else if(mLTP.equals("T"))
		{
		 mltp="Tutorial";
		 mlt=mT;
		 mlt1=mT1;	
		}
		else
		{
		 mltp="Practical";
		 mlt=mP;
		 mlt1=mP1;		
		}

	}
else
{

if(mType.equals("C"))
{
  qry="select nvl(L,0)L,nvl(T,0)T,nvl(P,0)P from Programscheme where institutecode='"+mInst+"'  and SUBJECTID='"+mSubjID+"'  ";
  qry=qry+" and nvl(deactive,'N')='N' ";
  rs=db.getRowset(qry);
  if(rs.next())
  {	
  mL=rs.getInt("L");
  mT=rs.getInt("T");
  mP=(int)(rs.getInt("P")/2);				

  mL1=rs.getInt("L");
  mT1=rs.getInt("T");
  mP1=rs.getInt("P");				
  }
/*	
	qry1=" select count(distinct studentid)cnt from STUDENTREGISTRATION where ";
	qry1=qry1+" institutecode='"+mInst+"'  and  (examcode,regcode) in (Select examcode,regcode ";
	qry1=qry1+" from PREVENTS where MEMBERTYPE='S') and  (INSTITUTECODE, ";
	qry1=qry1+" EXAMCODE,  ACADEMICYEAR, PROGRAMCODE, TAGGINGFOR, SECTIONBRANCH, ";
	qry1=qry1+" SEMESTER ) in (select INSTITUTECODE, EXAMCODE, ";
	qry1=qry1+" ACADEMICYEAR, PROGRAMCODE, TAGGINGFOR, SECTIONBRANCH, SEMESTER from ";
	qry1=qry1+" PROGRAMSUBJECTTAGGING WHERE EXAMCODE='"+mExamcode+"' AND SUBJECTID='"+mSubjID+"' )";
	qry1=qry1+" and SEMESTERTYPE=decode('"+mSem+"','ALL',semestertype,'"+mSem+"')  ";
	rsc=db.getRowset(qry1);
	while(rsc.next())
	{
		  mStudcnt=rsc.getString("cnt");	
	}
  */	

}		
else if(mType.equals("E"))
{
  qry="select nvl(L,0)L,nvl(T,0)T,nvl(P,0)P from PR#ELECTIVESUBJECTS where institutecode='"+mInst+"' and examcode='"+mExamcode+"' and SUBJECTID='"+mSubjID+"' ";
  qry=qry+" and nvl(deactive,'N')='N' ";
  rs=db.getRowset(qry);
  if(rs.next())
  {	
  mL=rs.getInt("L");
  mT=rs.getInt("T");
  mP=(int)(rs.getInt("P")/2);			
	
  mL1=rs.getInt("L");
  mT1=rs.getInt("T");
  mP1=rs.getInt("P");				

  }	

/*
qry1=" select count (distinct studentid)cnt from PR#STUDENTSUBJECTCHOICE WHERE ";
qry1=qry1+" institutecode='"+mInst+"' and EXAMCODE='"+mExamcode+"'  and ";
qry1=qry1+"  SEMESTERTYPE=decode('"+mSem+"','ALL',semestertype,'"+mSem+"') and SUBJECTID='"+mSubjID+"' and ";
qry1=qry1+" SUBJECTTYPE='E' and SUBJECTRUNNING='Y' and ";
qry1=qry1+" (ACADEMICYEAR,PROGRAMCODE,TAGGINGFOR,SECTIONBRANCH,SEMESTER,SUBJECTID) in ";
qry1=qry1+" (Select ACADEMICYEAR, PROGRAMCODE, TAGGINGFOR, SECTIONBRANCH, SEMESTER,SUBJECTID ";
qry1=qry1+" from PROGRAMSUBJECTTAGGING WHERE EXAMCODE='"+mExamcode+"' AND  SUBJECTID='"+mSubjID+"' )";

rsc=db.getRowset(qry1);

while(rsc.next())
{
  mStudcnt=rsc.getString("cnt");	
}
*/

}	
else 
{
  qry="select nvl(L,0)L,nvl(T,0)T,nvl(P,0)P from FREEELECTIVE where institutecode='"+mInst+"' and examcode='"+mExamcode+"' and SUBJECTID='"+mSubjID+"' ";
  qry=qry+" and nvl(deactive,'N')='N' ";
  rs=db.getRowset(qry);
  if(rs.next())
  {	
  mL=rs.getInt("L");
  mT=rs.getInt("T");
  mP=(int)(rs.getInt("P")/2);				

  mL1=rs.getInt("L");
  mT1=rs.getInt("T");
  mP1=rs.getInt("P");				
 }
/*	
qry1=" select count (distinct studentid)cnt from PR#STUDENTSUBJECTCHOICE WHERE ";
qry1=qry1+" institutecode='"+mInst+"' and EXAMCODE='"+mExamcode+"'  and ";
qry1=qry1+"  SEMESTERTYPE=decode('"+mSem+"','ALL',semestertype,'"+mSem+"') and SUBJECTID='"+mSubjID+"' and ";
qry1=qry1+" SUBJECTTYPE='F' and SUBJECTRUNNING='Y' ";
rsc=db.getRowset(qry1);
while(rsc.next())
{
  mStudcnt=rsc.getString("cnt");	
}
*/
}	
if(mLTP.equals("L"))
{

  mltp="Lecture";
  mlt=mL;
  mlt1=1;
}
else if(mLTP.equals("T"))
{
 mltp="Tutorial";
 mlt=mT;
 mlt1=1;	
}
else
{
 mltp="Practical";
 mlt=mP;
 mlt1=2;		
}
} // closing of else
}
catch(Exception e)
{
}	
String mMult="";
/*if(request.getParameterValues("MultiFaculti")==null)
{	
	mMult="";
	session.setAttribute("MultiFaculti",null);
}
else
{
	mMultiFaculty=request.getParameterValues("MultiFaculti");
	session.setAttribute("MultiFaculti",null);
	session.setAttribute("MultiFaculti",mMultiFaculty);
}*/
/*try{
ArrayList  futlist=new ArrayList();
if(session.getAttribute("MultiFaculti")==null)
{
	mMult="";
	session.setAttribute("MultiFaculti",null);
}
else
{
	//out.println(session.getAttribute("MultiFaculti"));
	futlist=(ArrayList)session.getAttribute("MultiFaculti");
//	if(request.getParameter("counter")==null)
	int i=0;
	for(i=0;i<futlist.size();i++)
	{
		//out.println((futlist.get(i).toString())+request.getParameter("hr"+i));
		String ii="0";
		if(request.getParameter("hr"+i)==null)
			ii="0";
		else
			ii=request.getParameter("hr"+i);
		mMultiFaculty[i]=(futlist.get(i).toString())+"###"+ii;
		//out.println("asdf"+(futlist.get(i).toString())+"###"+ii);
	}
	session.setAttribute("MultiFaculti",null);
	session.setAttribute("MultiFaculti",mMultiFaculty);
	String ltp=request.getParameter("LTP");
	String subid1=request.getParameter("SUBJID");
	String secbran=request.getParameter("SECTIONBRANCH");
	String [] multiFaculty=(String [])session.getAttribute("MultiFaculti");
	for(int j=0;j<i;j++)
	{
		String aa=multiFaculty[j];
		String fid=aa.substring(0,aa.indexOf("***"));
		String ftype=aa.substring(aa.indexOf("***")+3,aa.indexOf("///"));
		String cmp=aa.substring(aa.indexOf("///")+3,aa.indexOf("@@@"));
		String hr=aa.substring(aa.indexOf("###")+3,aa.length());
		//qry="INSERT INTO TEMP#PR#LOADDISTRIBUTION ( SESSIONID, USERID, SUBJECTID, SECTIONBRANCH, SUBSECTIONCODE, LTP,	      COMPANYCODE, FACULTYTYPE, EMPLOYEEID, NOFHRS, DATETIME)VALUES ( 'dd','"+mChkMemID+"' ,'"+subid1+"', '"+secbran+"','','"+ltp+"','"+cmp+"' , '"+ftype+"', '"+fid+"','"+hr+"' ,sysdate )";
		//out.println(qry);
		//rs=db.getRowset(qry);
	}
}
session.setAttribute("MultiFaculti",null);
}
catch(Exception e)
{
	//out.println(e);
}*/
%>
<form name="frm1"  method="post" action="PRLoadDistributionHODSaveActionLec.jsp" >
<table id=id1 width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">Assigned Load to Faculty</TD>
</font></td></tr>
</TABLE>
<table id=idd2 cellpadding=1 cellspacing=0 width="100%" align=center rules=rows  border=3>
<tr><td align=center colspan=3>
<b>HOD Load Distribution of Subject : </b><%=mSname%>&nbsp;(<%=mSubj%>)- <%=Type%> &nbsp; &nbsp;<b>LTP:</b>&nbsp;<%=mltp%>&nbsp; &nbsp;
</td></tr>
<tr>
<td>
  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <b>Running Dept : </b><select name=Dept id=Dept>
	<option selected value='<%=mDept%>'><%=mDept%></option>
	</select
</td>	
<td>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <b>Class Duration : </b>
<input readonly type=text name=Dura id=Dura value='<%=mlt1%>' maxlength=3 size=4>hrs
</td>
<td>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
 <b>No. of Class in a Week : </b><input readonly type=text name=Class1 id=Class1 value='<%=mlt%>' maxlength=3 size=4>
</td>
</tr>			
</table>
	<table cellspacing=0 align=center border=2 rules=groups width=100%>
	<tr bgcolor="#ff8c00">
	<td align=middle><b><font color=white>Section</font><b></td>
	<td align=middle><b><font color=white>&nbsp;</font><b></td>
	<td align=middle><b><font color=white>&nbsp;</font><b></td> 
	<td align=middle><b><font color=white>Faculty Choice</font><b></td>
	<td align=middle><b><font color=white>Merge with</font><b></td>
	
	<td align=middle><b><font color=white>Total-Stud.</font><b></td>
	<td align=middle><b><font color=white>New Link</font><b></td>
	</tr>
<%
//    if(request.getParameter("x")!=null)
//	{
	int mFlag=0;

	if(mType.equals("C"))
	{
	qry="select distinct SUBSECTIONCODE subsectioncode,to_char(NVL(seqid,1)seqid) seqid,";
	qry=qry+"A.ACADEMICYEAR,A.PROGRAMCODE,A.TAGGINGFOR,A.SECTIONBRANCH SECTIONBRANCH,A.SEMESTER,";
	qry=qry+" A.SEMESTERTYPE,";
	qry=qry+" (Select count(*) from PROGRAMSUBSECTIONTAGGING C where C.institutecode='"+mInst+"' and C.examcode='"+mExamcode+"' and ";
	qry=qry+" C.semestertype=decode('"+mSem+"','ALL',C.semestertype,'"+mSem+"') and nvl(C.deactive,'N')='N' and ";
	qry=qry+" C.ACADEMICYEAR=A.ACADEMICYEAR and C.PROGRAMCODE=A.PROGRAMCODE and C.SECTIONBRANCH=A.SECTIONBRANCH and";
	qry=qry+" C.SEMESTER=A.SEMESTER and C.SUBSECTIONTYPE='C' )cnt from PROGRAMSUBSECTIONTAGGING A, ";
	qry=qry+" PROGRAMSCHEME B where A.institutecode='"+mInst+"' and A.examcode='"+mExamcode+"' and ";
	qry=qry+" A.semestertype=decode('"+mSem+"','ALL',A.semestertype,'"+mSem+"') and nvl(A.deactive,'N')='N' and ";
	qry=qry+" A.ACADEMICYEAR=B.ACADEMICYEAR and A.PROGRAMCODE=B.PROGRAMCODE and A.SECTIONBRANCH=B.SECTIONBRANCH and";
	qry=qry+" A.SEMESTER=B.SEMESTER  and B.SUBJECTID='"+mSubjID+"' and A.SUBSECTIONTYPE='C' ";
	qry=qry+" and B.subjectid in (select D.subjectid from PR#DEPARTMENTSUBJECTTAGGING D ";
	qry=qry+" where  D.departmentcode ='"+mDept+"'  and D.SECTIONBRANCH=A.SECTIONBRANCH and D.SECTIONBRANCH=B.SECTIONBRANCH) ";
	qry=qry+" order by A.SECTIONBRANCH,seqid,subsectioncode, ";
	qry=qry+"A.ACADEMICYEAR,A.PROGRAMCODE,A.TAGGINGFOR,A.SEMESTER,";
	qry=qry+" A.SEMESTERTYPE";
	}
	else if(mType.equals("E"))
	{
	qry="select distinct SUBSECTIONCODE subsectioncode,to_char(NVL(seqid,1)seqid) seqid, ";
	qry=qry+"A.ACADEMICYEAR,A.PROGRAMCODE,A.TAGGINGFOR,A.SECTIONBRANCH SECTIONBRANCH,A.SEMESTER,";
	qry=qry+" A.SEMESTERTYPE ";	
	qry=qry+" ,(Select count(*) from PROGRAMSUBSECTIONTAGGING C where C.institutecode='"+mInst+"' and C.examcode='"+mExamcode+"' and ";
	qry=qry+" C.semestertype=decode('"+mSem+"','ALL',C.semestertype,'"+mSem+"') and nvl(C.deactive,'N')='N' and ";
	qry=qry+" C.ACADEMICYEAR=A.ACADEMICYEAR and C.PROGRAMCODE=A.PROGRAMCODE and C.SECTIONBRANCH=A.SECTIONBRANCH and";
	qry=qry+" C.SEMESTER=A.SEMESTER and C.SUBSECTIONTYPE='E' )cnt "; 
	qry=qry+" from PROGRAMSUBSECTIONTAGGING A, ";
	qry=qry+" PR#ELECTIVESUBJECTS B where B.SUBJECTRUNNING='Y' AND A.institutecode='"+mInst+"' and B.ELECTIVECODE='"+mElective+"' AND A.examcode='"+mExamcode+"' and ";
	qry=qry+" A.semestertype=decode('"+mSem+"','ALL',A.semestertype,'"+mSem+"') and nvl(A.deactive,'N')='N' and ";
	qry=qry+" A.ACADEMICYEAR=B.ACADEMICYEAR and A.PROGRAMCODE=B.PROGRAMCODE and A.EXAMCODE=B.EXAMCODE and A.SECTIONBRANCH=B.SECTIONBRANCH ";
	qry=qry+" AND A.SEMESTER=B.SEMESTER and B.SUBJECTID='"+mSubjID+"' and A.SUBSECTIONTYPE='E' ";
	qry=qry+" and B.subjectid in (select D.subjectid from PR#DEPARTMENTSUBJECTTAGGING D ";
	qry=qry+" where  D.departmentcode ='"+mDept+"'  and D.SECTIONBRANCH=A.SECTIONBRANCH and D.SECTIONBRANCH=B.SECTIONBRANCH) ";
	qry=qry+" order by A.SECTIONBRANCH,seqid,subsectioncode, ";
	qry=qry+"A.ACADEMICYEAR,A.PROGRAMCODE,A.TAGGINGFOR,A.SEMESTER,";
	qry=qry+" A.SEMESTERTYPE";
	}
	else
	{
	qry="select distinct SUBSECTIONCODE subsectioncode,to_char(NVL(seqid,1)seqid)seqid, ";
	qry=qry+"A.ACADEMICYEAR,A.PROGRAMCODE,A.TAGGINGFOR,A.SECTIONBRANCH SECTIONBRANCH,A.SEMESTER,";
	qry=qry+" A.SEMESTERTYPE ";	
	qry=qry+" ,(Select count(*) from PROGRAMSUBSECTIONTAGGING C where C.institutecode='"+mInst+"' and C.examcode='"+mExamcode+"' and ";
	qry=qry+" C.semestertype=decode('"+mSem+"','ALL',C.semestertype,'"+mSem+"') and nvl(C.deactive,'N')='N' and ";
	qry=qry+" C.ACADEMICYEAR=A.ACADEMICYEAR and C.PROGRAMCODE=A.PROGRAMCODE and C.SECTIONBRANCH=A.SECTIONBRANCH and";
	qry=qry+" C.SEMESTER=A.SEMESTER and C.SUBSECTIONTYPE='F' )cnt ";	
	qry=qry+" from PROGRAMSUBSECTIONTAGGING A, ";
	qry=qry+" FREEELECTIVE B where B.SUBJECTRUNNING='Y' AND A.institutecode='"+mInst+"'  AND A.examcode='"+mExamcode+"' and ";
	qry=qry+" A.semestertype=decode('"+mSem+"','ALL',A.semestertype,'"+mSem+"') and nvl(A.deactive,'N')='N' and ";
	qry=qry+" A.ACADEMICYEAR=B.ACADEMICYEAR and A.PROGRAMCODE=B.PROGRAMCODE and A.EXAMCODE=B.EXAMCODE and A.SECTIONBRANCH=B.SECTIONBRANCH ";
	qry=qry+" AND A.SEMESTER=B.SEMESTER and B.SUBJECTID='"+mSubjID+"' and A.SUBSECTIONTYPE='F' ";
	qry=qry+" and B.subjectid in (select D.subjectid from PR#DEPARTMENTSUBJECTTAGGING D ";
	qry=qry+" where  D.departmentcode ='"+mDept+"'  and D.SECTIONBRANCH=A.SECTIONBRANCH and D.SECTIONBRANCH=B.SECTIONBRANCH) ";
	qry=qry+" order by A.SECTIONBRANCH,seqid,subsectioncode, ";
	qry=qry+"A.ACADEMICYEAR,A.PROGRAMCODE,A.TAGGINGFOR,A.SEMESTER,";
	qry=qry+" A.SEMESTERTYPE";
	}
	rs1=db.getRowset(qry);
	//out.print(qry);
	ctr=0;
	int x=0;
	String mChkFac[]=new String[100];
	while(rs1.next())
	{
		mFlag=1;
		// mSeccount=rs1.getString("cnt");
		mSeccount="0";
		mSubsection=rs1.getString("subsectioncode");
		msno++;
		mName4="OLDNEW"+String.valueOf(msno).trim();
		
		if(!mSection.equals(rs1.getString("SECTIONBRANCH")))
		{
		ctr=0;
		mSection=rs1.getString("SECTIONBRANCH");	
// System.out.print(mType+"ffff");		
if(mType.equals("E"))
{
		qrye="select distinct subjectid from PR#ELECTIVESUBJECTS where institutecode='"+mInst+"'  and ";
		qrye=qrye+" examcode='"+mExamcode+"' and PROGRAMCODE='"+rs1.getString("PROGRAMCODE")+"' and SECTIONBRANCH='"+mSection+"' and electivecode='"+mEle+"' and  (nvl(L,0)>0 or nvl(T,0)>0 or nvl(P,0)>0 ) AND ";
		qrye=qrye+" nvl(subjectrunning,'N')='Y' and nvl(DEACTIVE,'N')='N' ";
		rse=db.getRowset(qrye);
	
		while(rse.next())
		{
		if(SC.equals(""))
			{
				SC="'"+rse.getString("subjectid")+"'";
			}
			else
			{
				SC=SC+",'"+rse.getString("subjectid")+"'";
			}
			
		} // closing of while
qry1="Select Subjectid, Count(Subjectid) cnt From (Select StudentID, Subjectid ";
qry1=qry1+" From Pr#StudentSubjectChoice a Where Studentid in(select Studentid from STUDENTREGISTRATION where EXAMCODE='"+mExamcode+"' and nvl(REGALLOW,'N')='Y')and SUBJECTTYPE='"+mType+"' AND  ELECTIVECODE='"+mEle+"'  and EXAMCODE='"+mExamcode+"' ";
qry1=qry1+" and SECTIONBRANCH='"+mSection+"' and PROGRAMCODE='"+rs1.getString("PROGRAMCODE")+"' and Choice = (Select Min(Choice) From PR#StudentSubjectChoice ";
qry1=qry1+"	Where Subjectid IN("+SC+")	And StudentID = a.StudentID    ) ) ";
qry1=qry1+" Group By Subjectid Having Subjectid in('"+mSubj+"') Order By Subjectid ";
rsc=db.getRowset(qry1);
//out.println(qry1);
while(rsc.next())
{
		  mStudcnt=rsc.getString("cnt");	
}

}
else if(mType.equals("F")) 
{
	

qrye="select distinct subjectid from FREEELECTIVE where institutecode='"+mInst+"'  and ";
qrye=qrye+" examcode='"+mExamcode+"' and PROGRAMCODE='"+rs1.getString("PROGRAMCODE")+"' and SECTIONBRANCH='"+mSection+"'  and  (nvl(L,0)>0 or nvl(T,0)>0 or nvl(P,0)>0 ) AND ";
qrye=qrye+" nvl(subjectrunning,'N')='Y' and nvl(DEACTIVE,'N')='N' ";
rse=db.getRowset(qrye);

while(rse.next())
{
	
		if(SC.equals(""))
		{
			SC="'"+rse.getString("subjectid")+"'";
		}
			else
			{
				SC=SC+",'"+rse.getString("subjectid")+"'";
			}
			
		} // closing of while
		
qry1="Select Subjectid, Count(Subjectid) cnt From (Select StudentID, Subjectid ";
qry1=qry1+" From Pr#StudentSubjectChoice a Where Studentid in(select Studentid from STUDENTREGISTRATION where EXAMCODE='"+mExamcode+"' and nvl(REGALLOW,'N')='Y')and SUBJECTTYPE='"+mType+"' AND   EXAMCODE='"+mExamcode+"' ";
qry1=qry1+" and SECTIONBRANCH='"+mSection+"' and PROGRAMCODE='"+rs1.getString("PROGRAMCODE")+"' and Choice = (Select Min(Choice) From PR#StudentSubjectChoice ";
qry1=qry1+"	Where Subjectid IN("+SC+")	And StudentID = a.StudentID    ) ) ";
qry1=qry1+" Group By Subjectid Having Subjectid in('"+mSubj+"') Order By Subjectid ";
rsc=db.getRowset(qry1);
//out.println(qry1);
while(rsc.next())
{
		  mStudcnt=rsc.getString("cnt");	
}

}
else
{
//and PROGRAMCODE='"+rs1.getString("PROGRAMCODE")+"'
qry1=" select count(distinct studentid)cnt from STUDENTREGISTRATION where ";
	qry1=qry1+" institutecode='"+mInst+"' and sectionbranch='"+mSection+"'  and nvl(REGALLOW,'N')='Y'  and  (examcode,regcode) in (Select examcode,regcode ";
	qry1=qry1+" from PREVENTS where MEMBERTYPE='S') and  (INSTITUTECODE, ";
	qry1=qry1+" EXAMCODE,  ACADEMICYEAR, PROGRAMCODE, TAGGINGFOR, SECTIONBRANCH, ";
	qry1=qry1+" SEMESTER ) in (select INSTITUTECODE, EXAMCODE, ";
	qry1=qry1+" ACADEMICYEAR, PROGRAMCODE, TAGGINGFOR, SECTIONBRANCH, SEMESTER from ";
	qry1=qry1+" PROGRAMSUBJECTTAGGING WHERE EXAMCODE='"+mExamcode+"' AND SUBJECTID='"+mSubjID+"' and SECTIONBRANCH='"+mSection+"' ) ";
	qry1=qry1+" and SEMESTERTYPE=decode('"+mSem+"','ALL',semestertype,'"+mSem+"')  ";
	rsc=db.getRowset(qry1);
	
	while(rsc.next())
	{
		  mStudcnt=rsc.getString("cnt");	
	}
}
/*
	qry1=" select count(distinct studentid)cnt from STUDENTREGISTRATION where ";
	qry1=qry1+" institutecode='"+mInst+"'  and  (examcode,regcode) in (Select examcode,regcode ";
	qry1=qry1+" from PREVENTS where MEMBERTYPE='S') and  (INSTITUTECODE, ";
	qry1=qry1+" EXAMCODE,  ACADEMICYEAR, PROGRAMCODE, TAGGINGFOR, SECTIONBRANCH, ";
	qry1=qry1+" SEMESTER ) in (select INSTITUTECODE, EXAMCODE, ";
	qry1=qry1+" ACADEMICYEAR, PROGRAMCODE, TAGGINGFOR, SECTIONBRANCH, SEMESTER from ";
	qry1=qry1+" PROGRAMSUBJECTTAGGING WHERE EXAMCODE='"+mExamcode+"' AND SUBJECTID='"+mSubjID+"' and SECTIONBRANCH='"+mSection+"' ) ";
	qry1=qry1+" and SEMESTERTYPE=decode('"+mSem+"','ALL',semestertype,'"+mSem+"')  ";
	rsc=db.getRowset(qry1);
	while(rsc.next())
	{
		  mStudcnt=rsc.getString("cnt");	
	}
*/
		mChkFac[x]=rs1.getString("SECTIONBRANCH");	
		x++;
	%>
		<tr bgcolor=lightgrey>
		<td align='center'><%=mSection%></td>
		<td>
	<%
	
		qry="select A.FACULTYID FACULTYID,nvl(MERGEWITHFSTID,' ')MERGEWITHFSTID from PR#HODLOADDISTRIBUTION A  where A.institutecode='"+mInst+"' ";
		qry=qry+" and A.examcode='"+mExamcode+"' and A.SUBJECTID='"+mSubjID+"'  and A.LTP='"+mLTP+"' ";
		qry=qry+" and A.SECTIONBRANCH='"+mSection+"' and A.subsectioncode='"+mSubsection+"' and nvl(A.deactive,'N')='N' ";		
		qry=qry+" and A.semestertype='"+rs1.getString("SEMESTERTYPE")+"' ";
		//out.print(qry);
		rs5=db.getRowset(qry);
		
		if(rs5.next())
		{
			moldemp1=rs5.getString("FACULTYID");
			moldMerge1=rs5.getString("MERGEWITHFSTID");
		}
		else
		{
			moldemp1="";
			moldMerge1="";
		}

		if(!moldMerge1.equals(" "))
		{
				
			qrym="select A.sectionbranch from PR#HODLOADDISTRIBUTION A where A.institutecode='"+mInst+"' ";
			qrym=qrym+" and fstid='"+moldMerge1+"' and A.examcode='"+mExamcode+"' and A.SUBJECTID='"+mSubjID+"'  and A.LTP='"+mLTP+"' ";
			qrym=qrym+" and nvl(A.deactive,'N')='N' ";
			rsm=db.getRowset(qrym);
	
			if(rsm.next())
			{
				moldMerge=rsm.getString("sectionbranch");
			}
			else
			{
				moldMerge="";
			}
		}
		else
		{
			moldMerge="";
		}

		
		qry="select A.facultyid facultyid,B.Employeename employeename,B.COMPANYCODE companycode,";
		qry=qry+" A.FACULTYTYPE facultytype,to_char(WebKiosk.getAssignedTeachLoad(B.COMPANYCODE,'"+mInst+"',A.facultyid,A.FACULTYTYPE,'"+mExamcode+"'))assignedload, ";
		qry=qry+" to_char(WebKiosk.getAssignedTeachLoad(B.COMPANYCODE,'"+mInst+"',A.facultyid,A.FACULTYTYPE,'"+mExamcode+"','"+mSubj+"','"+mBasket+"','"+mLTP+"'))assignedload11, ";
		qry=qry+" to_char(WebKiosk.getMinTeachLoad(B.COMPANYCODE,'"+mInst+"',A.facultyid,A.FACULTYTYPE,'"+mExamcode+"'))minload,to_char(WebKiosk.getMaxTeachLoad(B.COMPANYCODE,'"+mInst+"',A.facultyid,A.FACULTYTYPE,'"+mExamcode+"'))maxload  from PR#FACULTYSUBJECTCHOICES A,V#STAFF B where A.institutecode='"+mInst+"' ";
		qry=qry+" and A.examcode='"+mExamcode+"' and A.SUBJECTID='"+mSubjID+"'  and A.LTP='"+mLTP+"' ";
		qry=qry+" and subjecttype='"+mType+"' and A.facultyid=B.employeeid and nvl(A.deactive,'N')='N' ";		
		//out.println(qry);
		rs=db.getRowset(qry);
		
			mName1=mSection+"***L///"+String.valueOf(ctr).trim()+"###"+mSeccount;  
			mNameLML=mSection+"***L///"+String.valueOf(ctr).trim()+"###"+mSeccount+"merge";  
			
			

	 	%>
		   <select name="<%=mName1%>" id="FacultyChoice" tabindex="0" style="WIDTH: 0px"  onChange="ChangeOptions1('<%=mName1%>','<%=mNameLML%>',<%=mlt1%>,<%=mlt%>);">
		<%	
		if (request.getParameter("x")==null) 
		{
		if(moldemp1.equals(""))
		{	
		%>
		<OPTION selected Value='NONE'>Select a Faculty</option>
		<%	
		}
		else
		{
		%>
			<OPTION  Value='NONE'>Select a Faculty</option>
		<%	
		}
		while(rs.next())
		{
			mFac=rs.getString("facultyid");
			mTyp=rs.getString("facultytype");
			mcmp=rs.getString("companycode");
			mAssigned=rs.getDouble("assignedload");
			mMax=rs.getDouble("maxload");
			mMin=rs.getDouble("minload");
			mexcludeassign=rs.getDouble("assignedload11");

			mFacv=mFac+"***"+mAssigned+"///"+mMin+"###"+mMax+"*****"+mTyp+"/////"+mcmp+"$$$$"+mexcludeassign ;
			if(moldemp1.equals(mFac))
			{
			mFlag11=1;
			%>
			 <OPTION selected Value =<%=mFacv%>><%=rs.getString("employeename")%></option> 
			<%
			}
			else
			{
			%>
			 <OPTION  Value =<%=mFacv%>><%=rs.getString("employeename")%></option> 
			<%
			}

		}//CLOSING OF WHILE
	}
	%>
	</select>
	</td>
	<td>

	<%
//	mNameLML=mSection+"***L///"+String.valueOf(ctr).trim()+"###"+mSeccount+"merge";  
	%>
	<select name='<%=mNameLML%>' id='Mergesection' tabindex="0" style="WIDTH: 0px" onChange="ChangeOptions3('<%=mName1%>','<%=mNameLML%>');">
	<%
		if(moldMerge.equals(""))
		{
	%>
		<option selected value='NONE'>Merge with section</option>
	<%	
		}
		else
		{
	%>
		<option value='NONE'>Merge with section</option>
	<%
		}	
	for(int jp=0;jp<x;jp++)
	{
	mvalue=rs1.getString("SECTIONBRANCH")+"***"+mChkFac[jp];
// mvalue=rs1.getString("SECTIONBRANCH")+"***"+rs1.getString("subsectioncode")+"///"+mChkFac[jp]+"###"+rs1.getString("PROGRAMCODE");

	if(moldMerge.equals(mChkFac[jp]) )
	{
	      if(mFlag11==1)
		{	
	%>	
		<option selected value='<%=mvalue%>'><%=mChkFac[jp]%></option>
	<%
	      }
	
	}
	else
	{
	%>
		<option value='<%=mvalue%>'><%=mChkFac[jp]%></option>
	<%
	}
	}
	%>
	</select>
	</td>
	<td align='center'>
	<%
	/*
	qry="select A.Employeeid facultyid,A.Employeename employeename,A.COMPANYCODE companycode,";
	qry=qry+" A.EMPLOYEETYPE facultytype,WebKiosk.getAssignedTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+mExamcode+"')assignedload, ";
	qry=qry+" WebKiosk.getMinTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+mExamcode+"') minload,WebKiosk.getMaxTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE ,'"+mExamcode+"')maxload  from V#STAFF A where A.departmentcode='"+mDept+"'  ";
	qry=qry+" minus ";
	qry=qry+" select A.facultyid facultyid,B.Employeename employeename,B.COMPANYCODE companycode,";
	qry=qry+" A.FACULTYTYPE facultytype,WebKiosk.getAssignedTeachLoad(B.COMPANYCODE,'"+mInst+"',A.facultyid,A.FACULTYTYPE,'"+mExamcode+"')assignedload, ";
	qry=qry+" WebKiosk.getMinTeachLoad(B.COMPANYCODE,'"+mInst+"',A.facultyid,A.FACULTYTYPE,'"+mExamcode+"')minload,WebKiosk.getMaxTeachLoad(B.COMPANYCODE,'"+mInst+"',A.facultyid,A.FACULTYTYPE,'"+mExamcode+"')maxload from PR#FACULTYSUBJECTCHOICES A,V#STAFF B where A.institutecode='"+mInst+"' ";
	qry=qry+" and A.examcode='"+mExamcode+"' and A.SUBJECTID='"+mSubjID+"'  and A.LTP='"+mLTP+"' ";
	qry=qry+" and subjecttype='"+mType+"' and A.facultyid=B.employeeid and nvl(A.deactive,'N')='N' order by employeename";	
	*/
	/*
	// last updated
	qry="select A.Employeeid facultyid,A.Employeename employeename,A.COMPANYCODE companycode,";
	qry=qry+" A.EMPLOYEETYPE facultytype,WebKiosk.getAssignedTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+mExamcode+"')assignedload, ";
	qry=qry+" WebKiosk.getAssignedTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid,A.EMPLOYEETYPE,'"+mExamcode+"','"+mSubj+"','"+mBasket+"','"+mLTP+"')assignedload11, ";
	qry=qry+" WebKiosk.getMinTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+mExamcode+"') minload,WebKiosk.getMaxTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE ,'"+mExamcode+"')maxload  from V#STAFF A   ";
	qry=qry+" minus ";
	qry=qry+" select A.facultyid facultyid,B.Employeename employeename,B.COMPANYCODE companycode,";
	qry=qry+" A.FACULTYTYPE facultytype,WebKiosk.getAssignedTeachLoad(B.COMPANYCODE,'"+mInst+"',A.facultyid,A.FACULTYTYPE,'"+mExamcode+"')assignedload, ";
	qry=qry+" WebKiosk.getAssignedTeachLoad(B.COMPANYCODE,'"+mInst+"',A.facultyid,A.FACULTYTYPE,'"+mExamcode+"','"+mSubj+"','"+mBasket+"','"+mLTP+"')assignedload11, ";
	qry=qry+" WebKiosk.getMinTeachLoad(B.COMPANYCODE,'"+mInst+"',A.facultyid,A.FACULTYTYPE,'"+mExamcode+"')minload,WebKiosk.getMaxTeachLoad(B.COMPANYCODE,'"+mInst+"',A.facultyid,A.FACULTYTYPE,'"+mExamcode+"')maxload from PR#FACULTYSUBJECTCHOICES A,V#STAFF B where A.institutecode='"+mInst+"' ";
	qry=qry+" and A.examcode='"+mExamcode+"' and A.SUBJECTID='"+mSubjID+"'  and A.LTP='"+mLTP+"' ";
	qry=qry+" and subjecttype='"+mType+"' and A.facultyid=B.employeeid and nvl(A.deactive,'N')='N' order by employeename";	
	*/
	qry="select A.Employeeid facultyid,A.Employeename employeename,A.COMPANYCODE companycode,";
	qry=qry+" A.EMPLOYEETYPE facultytype,to_char(WebKiosk.getAssignedTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+mExamcode+"'))assignedload, ";
	qry=qry+" to_char(WebKiosk.getAssignedTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid,A.EMPLOYEETYPE,'"+mExamcode+"','"+mSubj+"','"+mBasket+"','"+mLTP+"'))assignedload11, ";
	qry=qry+" to_char(WebKiosk.getMinTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+mExamcode+"')) minload,to_char(WebKiosk.getMaxTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE ,'"+mExamcode+"'))maxload  from V#STAFF A  where A.departmentcode='"+mDept+"' AND A.COMPANYCODE='"+mCompcode+"' ";
	qry=qry+" minus ";
	qry=qry+" select A.facultyid facultyid,B.Employeename employeename,B.COMPANYCODE companycode,";
	qry=qry+" A.FACULTYTYPE facultytype,to_char(WebKiosk.getAssignedTeachLoad(B.COMPANYCODE,'"+mInst+"',A.facultyid,A.FACULTYTYPE,'"+mExamcode+"'))assignedload, ";
	qry=qry+" to_char(WebKiosk.getAssignedTeachLoad(B.COMPANYCODE,'"+mInst+"',A.facultyid,A.FACULTYTYPE,'"+mExamcode+"','"+mSubj+"','"+mBasket+"','"+mLTP+"'))assignedload11, ";
	qry=qry+" to_char(WebKiosk.getMinTeachLoad(B.COMPANYCODE,'"+mInst+"',A.facultyid,A.FACULTYTYPE,'"+mExamcode+"'))minload,to_char(WebKiosk.getMaxTeachLoad(B.COMPANYCODE,'"+mInst+"',A.facultyid,A.FACULTYTYPE,'"+mExamcode+"'))maxload from PR#FACULTYSUBJECTCHOICES A,V#STAFF B where A.institutecode='"+mInst+"' ";
	qry=qry+" and A.examcode='"+mExamcode+"' and A.SUBJECTID='"+mSubjID+"'  and A.LTP='"+mLTP+"' ";
	qry=qry+" and subjecttype='"+mType+"' and A.facultyid=B.employeeid and nvl(A.deactive,'N')='N' order by employeename";	
	rs=db.getRowset(qry);
	//out.print(qry);	
	mName1=mSection+"***R///"+String.valueOf(ctr).trim()+"###"+mSeccount;  
	mNameLMR=mSection+"***R///"+String.valueOf(ctr).trim()+"###"+mSeccount+"merge";    

	%>
	<select name="<%=mName1%>" id="FacultyNChoice" tabindex="0" style="WIDTH: 200px"  onChange="ChangeOptions2('<%=mName1%>','<%=mNameLMR%>',<%=mlt1%>,<%=mlt%>);">
	<%
	if (request.getParameter("x")==null) 
	{
		if(moldemp1.equals(""))
		{	
		%>
			<OPTION selected Value ='NONE'>Select a Faculty</option>
		<%
		}
		else
		{
		%>
			<OPTION  Value ='NONE'>Select a Faculty</option>
		<%
		}
		//System.out.print(rs.next());	
		while(rs.next())
		{
			
			mEmpid=rs.getString("facultyid");
			mEmpTyp=rs.getString("facultytype");
			mEcmp=rs.getString("companycode");
			mAssignedload=rs.getDouble("assignedload");
			mMaxload=rs.getDouble("maxload");
			mMinload=rs.getDouble("minload");
			mexcludeassign=rs.getDouble("assignedload11");

			mEmpidv=mEmpid+"***"+mAssignedload+"///"+mMinload+"###"+mMaxload+"*****"+mEmpTyp+"/////"+mEcmp+"$$$$"+mexcludeassign ;			
			
			if(moldemp1.equals(mEmpid))
			{
			mFlag11=1;
			%>
				 <OPTION selected Value =<%=mEmpidv%>><%=rs.getString("employeename")%></option>
			<%
			}
			else
			{
			%>
				 <OPTION  Value =<%=mEmpidv%>><%=rs.getString("employeename")%></option>
			<%
			}
		} // closing of while
	}
%>
	</select>
	</td>
	<td align='center'>
	<%
	//   mNameLMR=mSection+"***R///"+String.valueOf(ctr).trim()+"###"+mSeccount+"merge";    
	%>
	<select name='<%=mNameLMR%>' id='Mergesection1' tabindex="0" style="WIDTH: 135px" onChange="ChangeOptions4('<%=mName1%>','<%=mNameLMR%>');">
	<%
		if(moldMerge.equals(""))
		{
	%>
		<option selected value='NONE'>Merge with section</option>
	<%	
		}
		else
		{
	%>
		<option value='NONE'>Merge with section</option>
	<%
		}	
	for(int jp=0;jp<x;jp++)
	{
	mvalue=rs1.getString("SECTIONBRANCH")+"***"+mChkFac[jp];
	if(moldMerge.equals(mChkFac[jp]))
	{
	%>	
		<option selected value='<%=mvalue%>'><%=mChkFac[jp]%></option>
	<%
	}
	else
	{
	%>
		<option value='<%=mvalue%>'><%=mChkFac[jp]%></option>
	<%
	}
	}
	%>
	</select>
	</td>
	<td align=middle><%=mStudcnt%></td>
	<td align=middle>
	<a href="PRLoadDistributionHODMultiFut.jsp?ExamCode=<%=mExamcode%>&Sub=<%=mSubj%>&Basket=<%=mBasket%>&LTP=<%=mLTP%>&Dept=<%=mDept%>&Subjid=<%=mSubjID%>&Elecode=<%=mElective%>&PRCODE=<%=request.getParameter("PRCODE")%>&radio1=<%=request.getParameter("radio1")%>&ELE=<%=mEle%>&SUBNAME=<%=request.getParameter("SUBNAME")%>&TYPE=<%=mType%>&SEM=<%=mSem%>&Subsection=<%=rs1.getString("SECTIONBRANCH")%>" target="_child">Multiple Faculty </a></font></td>
	</tr>
<%
	}
//	else   // 111
//	{	
		ctr++;
	
	if(!mLTP.equals("L"))
	{
%>
	</tr>
<%
	}
	if(mFlag11==1)
	{
	%>
	<input type=hidden name=<%=mName4%> id=<%=mName4%>  value=O>
	<%
	}
	else
	{
	%>
	<input type=hidden name=<%=mName4%> id=<%=mName4%>  value=N>
	<%
	}
	mFlag11=0;
// } closing of else  111

	} // closing of outer while

	if(mFlag==1)
	{
	mFlag=0;
	%>
	<TR>
	<TD ALIGN=CENTER COLSPAN=7><table width=100%><tr><hr><td align=center><input type=submit name=btn id=btn value='Draft Save' onClick="return validate();"></td></tr>
	
		
	</table></TD>
	</TR>
	<%
	}
%>
<input type=hidden name=INSTITUTE ID=INSTITUTE value=<%=mInst%>>
<input type=hidden name=EXAM ID=EXAM value=<%=mExamcode%>>
<input type=hidden name=LTP ID=LTP value=<%=mLTP%>>
<input type=hidden name=DEPARTMENT ID=DEPARTMENT value=<%=mDept%>>
<input type=hidden name=SUBJECT ID=SUBJECT value=<%=mSubj%>>
<input type=hidden name=SUBJECTID ID=SUBJECTID value=<%=mSubjID%>>
<input type=hidden name=TotalRec ID=TotalRec value=<%=msno%>>	
<input type=hidden name=TYPE ID=TYPE value=<%=mType%>>
<input type=hidden name=SEMTYPE ID=SEMTYPE value=<%=mSem%>>
<input type=hidden name=BASKET ID=BASKET value=<%=mBasket%>>
<input type=hidden name=DURATION ID=DURATION value=<%=mlt1%>>
<input type=hidden name=NOOFCLASS ID=NOOFCLASS value=<%=mlt%>>
<input type=hidden name=ELECTIVECODE ID=ELECTIVECODE value='<%=mElective%>'>	
</form>
<%

//	} //closing of if(request.getParameter("x")!=null)


//-----------------------------
//---Enable Security Page Level  
//-----------------------------
	}
	else
	{
   %>
	<br>
	<font color=red>
	<h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
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
	//out.println("e"+e);
}
%>
</body>
</html>