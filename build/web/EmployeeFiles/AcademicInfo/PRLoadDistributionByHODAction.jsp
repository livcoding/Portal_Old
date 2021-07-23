<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
ResultSet rs=null,rs1=null,rs2=null,rs3=null,rs5=null,rsc=null,rsl=null,rsm=null;

String mMemberID="",mDMemberID="",qry1="",mNameLML="",mvalue="",qrym="",mDept2="";
String mMemberName="",mProgramcode="";
String mMemberType="",mDMemberType="",mStudcnt="",mDis="",moldMerge="",moldMerge1="";
String mHead="",mOldEmp="",moldemp1="",mNameLMR="";
String mDMemberCode="",mMemberCode="",mFac="",mfac="",QryEleCode="";
String mInst="",mSection="",mSubsection="",mBasket="",mOfac="",mprogc="";
String qry="",Type="",mltp="",QrySemType="",mEmpid="",memp="",mName1="",mName2="";
String mName3="",mName4="",mName5="",mName6="",mComp="";
String mType="",mLTP="",mSubj="",mFaculty="",QryFaculty="",QryDept="",QryExam="",mSname="",mSeccount="",mPrCode="";
String mEmpIdv="", mMName5="", mMName6="";
String mFacv="",mTyp="",mEmpTyp="",mcmp="",mEcmp="",mDuration="",mClass="",mSendhod="";
String mMult="", mCapSubmit="Check to Save Load";
String [] mMultiFaculty=new String [1000];

String [] multiFac=(String [])session.getAttribute("MultiCumAddlFaculty");

int mL1=0, mT1=0, mP1=0, mlt1=0, mFlag2=0, mFlag1=0, mFlag11=0, mFlag111=0, CTR=0, ctr=0, x=0, msno=0;
int mL=0,mT=0,mP=0,mlt=0, mTotGlFac=0;
double mAssigned=0,mMin=0,mMax=0,mexcludeassign=0 ;
double mAssignedload=0,mMinload=0,mMaxload=0;




if (session.getAttribute("CompanyCode")==null)
	mComp="";
else
	mComp=session.getAttribute("CompanyCode").toString().trim();

if (session.getAttribute("InstituteCode")==null)
	mInst="";
else
	mInst=session.getAttribute("InstituteCode").toString().trim();

if (session.getAttribute("MemberID")==null)
	mMemberID="";
else
	mMemberID=session.getAttribute("MemberID").toString().trim();

if (session.getAttribute("MemberType")==null)
	mMemberType="";
else
	mMemberType=session.getAttribute("MemberType").toString().trim();

if (session.getAttribute("MemberCode")==null)
	mMemberCode="";
else
	mMemberCode=session.getAttribute("MemberCode").toString().trim();

if (session.getAttribute("MemberName")==null)
	mMemberName="";
else
	mMemberName=session.getAttribute("MemberName").toString().trim();

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";

if (session.getAttribute("TotalInGlobalMultiFac")==null)
	mTotGlFac=0;
else
	mTotGlFac=Integer.parseInt(session.getAttribute("TotalInGlobalMultiFac").toString().trim());

%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [HOD Advance Load Distribution] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<script language="JavaScript" type ="text/javascript">
<!--
  if (top != self) top.document.title = document.title;
-->
</script>
<script language=javascript>
<!--
function Help()
{
	var LoadWindow;
	LoadWindow=window.open('AdvPreRegHlp.htm','','height=200,width=800,minimize=no,status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes');
	LoadWindow.moveTo(80,50)
}
function RefreshContents()
{
	document.frm1.x.value='ddd';
    	document.frm1.submit();
}
function submitForm()
{
	if(document.frm1.save.value=='Draft Save')
	{
		var mChoice=confirm('This will save all the changes made by you. Is it OK to continue...');
		if(mChoice)
		{
			document.frm1.action = "PRLoadDistributionByHODSaveAction.jsp";
			document.frm1.submit();
		}
		else
		{
			document.frm1.action = "";
		}
	}
	else
	{
		document.frm1.action = "";
		//document.frm1.submit();
	}
}
function CheckBoxOption(optn,sec,subsec,SecCount)
{
	//alert(optn+' '+sec+' '+subsec);
	var len;
	var pos1;
	var pos2;
	var mName5="SEC"+""+SecCount;
	var mName6="SEC"+""+SecCount;

//alert(optn+' '+mName5+' '+mName6);

for (var i = 0; i < document.frm1.elements.length; i++)
{
	var e = document.frm1.elements[i];
	if ((e.type=='checkbox') && (e.name==sec) && optn=='OUT')
	{
		if(e.checked==true)
		{
			for(var j=1; j<=100; j++)
			{
				mName6=mName5+""+j;
				if(document.frm1[mName6]!=undefined)
					document.frm1[mName6].checked=true;
				else
					break;
			}
		}
		else
		{
			for(var j=1; j<=100; j++)
			{
				mName6=mName5+""+j;
				if(document.frm1[mName6]!=undefined)
					document.frm1[mName6].checked=false;
				else
					break;
			}
		}
	}
	else if ((e.type=='checkbox') && optn=='IN')
	{
		if(e.checked==false)
		{
			if(document.frm1[mName5]!=undefined)
				document.frm1[mName5].checked=false;
			else
				break;
		}
		else if(e.checked==true)
		{
			//alert('gfdgfdgfd');
			if(document.frm1[mName5]!=undefined)
				document.frm1[mName5].checked=true;
			else
				break;
		}
	}
}
}

function ChangeOptions2(optn,work,dura,cla)
{
//	alert(optn);
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
subcount=optn.substring(pos2+3,len);
name=optn.substring(0,pos1);

len1= work.length ;
pos1=work.indexOf('***');
pos11=work.indexOf('///');
pos21=work.indexOf('###');
pos3=work.indexOf('txt');
sec1=work.substring(0,pos1);
lr1=work.substring(pos1+3,pos11);
val1=work.substring(pos11+3,pos21);
subcount1=work.substring(pos21+3,pos3);
mtext=work.substring(pos3,len1);
//alert(work);

for (var i = 0; i < document.frm1.elements.length; i++)
{
	var e = document.frm1.elements[i];
	if ((e.type == 'select-one' || e.type=='text') && e.name!='Dept' && e.name!='Dura' && e.name!='Class1')
	{
		//alert(subcount);
		for(var j=0; j <=subcount; j++)
		{
			myname=name+'///'+j+'###'+subcount;
			rname=sec+'***L///'+j+'###'+subcount;

			mynametxt=name+'///'+j+'###'+subcount+mtext;
			rmynametxt=sec+'***L///'+j+'###'+subcount+mtext;
		//alert("e.name==myname" +e.name);
		//alert("ee"+myname);
			if(j==0 && e.type == 'select-one' && e.name==myname)
			{
				myobj=e;
				mainvalue=e.value;
				mFlag=1;
			//alert(mainvalue);
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

				//alert(mainvalue+' == '+min + '  '+max);
			}
			else if (j>0 && e.type == 'select-one' && e.name==myname)
			{
				//alert(myname);
				if(mainvalue!='NONE')
				{
					e.value=mainvalue;
				}
				else
				{
					e.value='NONE';
				}
			}
			if( e.type == 'select-one' && e.name==rname)
			{
				//alert(rname);
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
function change_assigned(optn, ctr)
{
var mCtr;
var TotCtr;

TotCtr=document.frm1.TotalRec.value;
for(i=1;i<=TotCtr;i++)
{
   if(i==ctr)
   {
	//alert(TotCtr +' '+ document.frm1.elements['mNm_'+ctr].value);
	if(document.forms["frm1"].elements["mNm_"+ctr].value!='')
	{
		var mChoice=confirm('Faculty already assigned! Do you want to change the current Faculty Choice?');
		//alert(mChoice);
/*
		if(mChoice)
		{
			//alert('Faculty already assigned for this batch hence review required');
		}
		else
		{
		}
*/
	}

   }
}
}
function ChangeOptions4(optn,work,dura,cla,ctr)
{
//change_assigned(optn, ctr);

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
var myname1;

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
var mynametxt1;
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

len= optn.length ;
pos=optn.indexOf('***');
pos1=optn.indexOf('///');
pos2=optn.indexOf('###');
sec=optn.substring(0,pos);
lr=optn.substring(pos+3,pos1);
val=optn.substring(pos1+3,pos2);
subcount=optn.substring(pos2+3,len);
name=optn.substring(0,pos1);

len1= work.length ;
pos1=work.indexOf('***');
pos11=work.indexOf('///');
pos21=work.indexOf('###');
pos3=work.indexOf('txt');
sec1=work.substring(0,pos1);
lr1=work.substring(pos1+3,pos11);
val1=work.substring(pos11+3,pos21);
subcount1=work.substring(pos21+3,pos3);
mtext=work.substring(pos3,len1);
for (var i = 0; i < document.frm1.elements.length; i++)
{
var e = document.frm1.elements[i];

	if ((e.type == 'select-one' || e.type=='text') && e.name!='Dept' && e.name!='Dura' && e.name!='Class1')
	   {

			myname=name+'///'+val+'###'+subcount;
			myname1=name+'///'+0+'###'+subcount;

			rname=sec+'***L///'+val+'###'+subcount;
			mynametxt1=name+'///'+0+'###'+subcount+mtext;
			mynametxt=name+'///'+val+'###'+subcount+mtext;
			rmynametxt=sec+'***L///'+val+'###'+subcount+mtext;

		if( e.type == 'select-one' && e.name==myname)
			{
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
				assign=mainvalue.substring(mpos6+4,mlen);
			//	assign=mainvalue.substring(mpos1+3,mpos2);
				min=mainvalue.substring(mpos2+3,mpos3);
				max=mainvalue.substring(mpos3+3,mpos4);

				var p=Weightage(emp,assign,min,max,dura,cla);
				if(p>0)
				{
					e.value='NONE' ;
					break;
				}

			}
			if( e.type == 'select-one' && e.name==rname)
			{
				e.value='NONE';
			}
		else if( e.type == 'select-one' && e.name==myname1)
			{
				e.value='NONE';
			}
	  }
  }
}
function Weightage(emp,assign,min,max,dura,cla)
{
var len;
var pos1;
var pos2;
var pos3;
var mainvalue;
var assignc=parseFloat(assign);
//alert(max);
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
pos1=(e.name).indexOf('///0');

	if (e.type == 'select-one'  && e.name!='Dept' && pos1==-1)
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
		var c=parseFloat(mT)+assignc;
		 	//alert(c+'  '+mT+ '   '+maxc+'    '+assignc);
	      if((parseFloat(mT)+assignc)>maxc)
		{
			//alert('Load assigned must be less than '+ max);
			//mFlag=1;
			//break;
		}
	}
}

 return (mFlag);

}

function ChangeOptions5(optn,work)
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
subcount=optn.substring(pos2+3,len);
name=optn.substring(0,pos1);

len1= work.length ;
pos1=work.indexOf('***');
pos11=work.indexOf('///');
pos21=work.indexOf('###');
pos3=work.indexOf('merge');
sec1=work.substring(0,pos1);
lr1=work.substring(pos1+3,pos11);
val1=work.substring(pos11+3,pos21);
subcount1=work.substring(pos21+3,pos3);
mtext=work.substring(pos3,len1);
var msec ;
var namesect;
var sectio;
var mpos3=0;
var x;
var x1;
var y;
var y1=0;
var y2;
var ctr=0;
var times=0;
var oldmsec1='?';
var mmerge='?';
var memp1='NONE';
for (var i = 0; i < document.frm1.elements.length; i++)
{
	var e = document.frm1.elements[i];

	if (e.type == 'select-one' && e.name!='Dept' && e.name!='Dura' && e.name!='Class1')
	   {
		for(var j=1; j <=subcount; j++)
		{
			myname=name+'///'+j+'###'+subcount;
			rname=sec+'***R///'+j+'###'+subcount;

		 	mynametxt=name+'///'+j+'###'+subcount+mtext;
			rmynametxt=sec+'***L///'+j+'###'+subcount+mtext;

			if(j>0 && e.type == 'select-one' && e.name==work)
			{
				x = document.frm1.elements[i-1];
				mainvalue=e.value;
				y2=e.selectedIndex;
				mlen=mainvalue.length;
				mpos1=mainvalue.indexOf('///');
				mpos2=mainvalue.indexOf('###');
				mpos3=mainvalue.indexOf('$$$');
				assign=mainvalue.substring(mpos1+3,mpos2);
				sectio=mainvalue.substring(mpos3+3,mlen);
				namesect=assign;
				name=sectio;
				break;
			}
		 } // closing of for

  }
   } // closing of outer for

//****************************************
for (var i = 0; i < document.frm1.elements.length; i++)
{
	var e = document.frm1.elements[i];

	if (e.type == 'select-one' && e.name!='Dept' && e.name!='Dura' && e.name!='Class1')
	   {

		var txt=e.name;
		len= txt.length ;
		pos=txt.indexOf('***');
		pos1=txt.indexOf('///');
		pos2=txt.indexOf('merge');
		lr=txt.substring(pos+3,pos1);
		msec1=txt.substring(0,pos);
		if(pos2>0)
		mmerge=txt.substring(pos2,pos2+5);
		else
		mmerge='!!!';


if(lr=='L' && mmerge=='merge')
{
y1++;
if(y1==y2)
{
	x1= document.frm1.elements[i-1];
	memp1=x1.value
	break;
}
}
  }
   } // closing of outer for

x.value=memp1;

}
function ChangeOptions6(optn,work)
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
subcount=optn.substring(pos2+3,len);
name=optn.substring(0,pos1);

len1= work.length ;
pos1=work.indexOf('***');
pos11=work.indexOf('///');
pos21=work.indexOf('###');
pos3=work.indexOf('merge');
sec1=work.substring(0,pos1);
lr1=work.substring(pos1+3,pos11);
val1=work.substring(pos11+3,pos21);
subcount1=work.substring(pos21+3,pos3);
mtext=work.substring(pos3,len1);
var msec ;
var namesect;
var sectio;
var mpos3=0;
var x;
var x1;
var y;
var y1=0;
var y2;
var ctr=0;
var times=0;
var oldmsec1='?';
var mmerge='?';
var memp1='NONE';
for (var i = 0; i < document.frm1.elements.length; i++)
{
	var e = document.frm1.elements[i];

	if (e.type == 'select-one' && e.name!='Dept' && e.name!='Dura' && e.name!='Class1')
	   {


		for(var j=1; j <=subcount; j++)
		{
			myname=name+'///'+j+'###'+subcount;
			rname=sec+'***L///'+j+'###'+subcount;

		 	mynametxt=name+'///'+j+'###'+subcount+mtext;
			rmynametxt=sec+'***R///'+j+'###'+subcount+mtext;

			if(j>0 && e.type == 'select-one' && e.name==work)
			{
				x = document.frm1.elements[i-1];
				mainvalue=e.value;
				y2=e.selectedIndex;
				mlen=mainvalue.length;
				mpos1=mainvalue.indexOf('///');
				mpos2=mainvalue.indexOf('###');
				mpos3=mainvalue.indexOf('$$$');
				assign=mainvalue.substring(mpos1+3,mpos2);
				sectio=mainvalue.substring(mpos3+3,mlen);
				namesect=assign;
				name=sectio;
				break;
			}
		 } // closing of for

  }
   } // closing of outer for
//****************************************
for (var i = 0; i < document.frm1.elements.length; i++)
{
	var e = document.frm1.elements[i];

	if (e.type == 'select-one' && e.name!='Dept' && e.name!='Dura' && e.name!='Class1')
	   {

		var txt=e.name;
		len= txt.length ;
		pos=txt.indexOf('***');
		pos1=txt.indexOf('///');
		pos2=txt.indexOf('merge');
		lr=txt.substring(pos+3,pos1);
		msec1=txt.substring(0,pos);
		if(pos2>0)
		mmerge=txt.substring(pos2,pos2+5);
		else
		mmerge='!!!';


if(lr=='R' && mmerge=='merge')
{
y1++;
if(y1==y2)
{
	x1= document.frm1.elements[i-1];
	memp1=x1.value
	break;
}
}
  }
   } // closing of outer for

x.value=memp1;

}
//-->
</script>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
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

		String QrySubjID="", mProjSubj="";
		String mEle="";
		String qrye="",sc="";
		ResultSet rse=null;
  //-----------------------------
  //-- Enable Security Page Level
  //-----------------------------
		qry="Select WEBKIOSK.ShowLink('56','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if(RsChk.next() && RsChk.getString("SL").equals("Y"))
		{
  //----------------------

//out.print(((String [])session.getAttribute("MultiCumAddlFaculty"))[0]);%><br><%
//out.print(((String [])session.getAttribute("MultiCumAddlFaculty"))[1]);

if (request.getParameter("PROJSUBJ")==null)
{
	mProjSubj="N";
}
else
{
	mProjSubj=request.getParameter("PROJSUBJ").toString().trim();
}

if (request.getParameter("SUBJID")==null)
{
	QrySubjID="";
}
else
{
	QrySubjID=request.getParameter("SUBJID").toString().trim();
}

if (request.getParameter("SUBJ")==null)
{
	mSubj="";
}
else
{
	mSubj=request.getParameter("SUBJ").toString().trim();
	//out.println(mSubj);
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
	QryDept="";
}
else
{
	QryDept=request.getParameter("DEPT").toString().trim();
}

if (request.getParameter("ELECTIVECODE")==null || request.getParameter("ELECTIVECODE").equals("null"))
{
	QryEleCode="";
}
else
{
	QryEleCode=request.getParameter("ELECTIVECODE").toString().trim();
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
//out.print(mBasket);
if (request.getParameter("EXAM")==null)
{
	QryExam="";
}
else
{
	QryExam=request.getParameter("EXAM").toString().trim();
}
if (request.getParameter("SEM")==null)
{
	QrySemType="";
}
else
{
	QrySemType=request.getParameter("SEM").toString().trim();
}
qry="select subject from subjectmaster where INSTITUTECODE='"+mInst+"' AND SUBJECTID='"+QrySubjID+"' ";
rs=db.getRowset(qry);
if(rs.next())
mSname=rs.getString(1);
mSname=gb.toTtitleCase(mSname);
if(mType.equals("C"))
  Type="Core";
else if(mType.equals("E"))
 Type="Elective";
else
 Type="Free Elective";

try
{
	qry1=" select nvl(LHOURS,0)L,nvl(THOURS,0)T,nvl(PHOURS,0)P, ";
	qry1+=" nvl(LCLASSES,0)L1,nvl(TCLASSES,0)T1,nvl(PCLASSES,0)P1 from SUBJECTWISELTPHOURS where ";
	qry1+=" institutecode='"+mInst+"' and EXAMCODE='"+QryExam+"' and ";
	qry1+=" SUBJECTID='"+QrySubjID+"' and BASKET='"+mBasket+"'  ";
	qry1+=" and NVL(DEACTIVE,'N')='N' ";

//	out.println(qry1);
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
  qry="select nvl(L,0)L,nvl(T,0)T,nvl(P,0)P from programsubjecttagging where institutecode='"+mInst+"'  and SUBJECTID='"+QrySubjID+"' and examcode='"+QryExam+"' ";
  qry+=" and nvl(deactive,'N')='N' ";
  //out.println(qry);
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
}
else if(mType.equals("E"))
{
  qry="select nvl(L,0)L,nvl(T,0)T,nvl(P,0)P from PR#ELECTIVESUBJECTS where institutecode='"+mInst+"' and examcode='"+QryExam+"' and SUBJECTID='"+QrySubjID+"' ";
  qry+=" and nvl(deactive,'N')='N' ";
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
}
else
{
  qry="select nvl(L,0)L,nvl(T,0)T,nvl(P,0)P from FREEELECTIVE where institutecode='"+mInst+"' and examcode='"+QryExam+"' and SUBJECTID='"+QrySubjID+"' ";
  qry+=" and nvl(deactive,'N')='N' ";
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

%>
<!--<form name="frm1" method="post" action="PRLoadDistributionHODSaveAction.jsp" >-->
<form name="frm1" method="post">
<input type=hidden name="xx" value="">
<table id=id1 width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Assign/Distribute Load to Faculty<B></TD>
</font></td></tr>
</TABLE>
<table id=idd2 cellpadding=1 cellspacing=0 width="100%" align=center rules=rows  border=3>
<tr><td align=center colspan=3>
<%
String mProject="";
if(mProjSubj.equals("Y"))
	mProject=" <FONT COLOR=NAVY><B>[Project Subject]</B></FONT>";
%>
<font face=arial color=navy size=2><b>HOD Load Distribution of Subject : </b>&nbsp;<font face=arial color=navy size=2><%=mSname%></font>&nbsp;(<%=mSubj%>) - <%=Type%> &nbsp; &nbsp; &nbsp; &nbsp;<font face=arial color=black size=2><b>LTP : </b></Font>&nbsp;<%=mltp%></Font> <%=mProject%> &nbsp; &nbsp;
</td></tr>

<tr><td align=left nowrap colspan=2>&nbsp; &nbsp;
<font face=arial color=black size=2><b>Running Department : </b></font><select name=DEPT id=DEPT style="background-color:#C6D6FD; color:black; font-weight:normal">
<%
String qryu="select Department from departmentmaster where departmentcode='"+QryDept+"' and nvl(deactive,'N')='N'";
ResultSet rssss= db.getRowset(qryu);
if(rssss.next())
	mDept2=rssss.getString("Department");
%>
<option selected name="RunningDept" value='<%=QryDept%>'><%=mDept2%> (<%=QryDept%>)</option>
</select>

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<font face=arial color=black size=2><b>Exam Code : </b></Font><select name=EXAM id=EXAM style="background-color:#C6D6FD; color:black; font-weight:normal">
<option selected value='<%=QryExam%>'><%=QryExam%></option>
</select>

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<font face=arial color=black size=2><b>Semester Type : </b></Font><select name=SEMTYPE id=SEM style="background-color:#C6D6FD; color:black; font-weight:normal">
<option selected value='<%=QrySemType%>'><%=QrySemType%></option>
</select>
</td></tr>

<tr><td align=left nowrap>&nbsp; &nbsp;
<font face=arial color=black size=2><b>Class Duration : </b></Font>
<input readonly type=text name=Dura id=Dura value='<%=mlt1%>' style="background-color:#C6D6FD; color:black; font-weight:normal; text-align:right" maxlength=3 size=1>hrs
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
 <font face=arial color=black size=2><b>No. of Class in a Week : </b><input readonly type=text name=Class1 id=Class1 value='<%=mlt%>' style="background-color:#C6D6FD; color:black; font-weight:normal; text-align:right" maxlength=3 size=1>days
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
</td>
<td nowrap align=center><a style="cursor:hand" onClick="Help()" title="Need Help? Click Here"><B><Font color=mahroon>HELP?</Font></B></a></td>
<tr>
</table>
<BR>
<table id=idd3 cellpadding=1 cellspacing=0 width="100%" align=center rules=rows border=0>
<tr><td align=left nowrap>&nbsp; &nbsp;
<font face=arial color=black size=2><b>Tick (&radic;) checkbox to assign faculty globally : </b></Font>
<%

qry="delete Temp#pr#loaddistribution where SUBJECTID='"+QrySubjID+"' and LTP='"+mLTP+"'";
//out.println(qry);
//int n1=db.update(qry);

try
{
	qry="select A.Employeeid facultyid,A.Employeename employeename,A.COMPANYCODE companycode,";
	qry+=" A.EMPLOYEETYPE facultytype,to_char(WebKiosk.getAssignedTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+QryExam+"'))assignedload, ";
	qry+=" to_char(WebKiosk.getAssignedTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+QryExam+"','"+QrySubjID+"','"+mBasket+"','"+mLTP+"'))assignedload11 , ";
	qry+="to_char( WebKiosk.getMinTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+QryExam+"') )minload,to_char(WebKiosk.getMaxTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE ,'"+QryExam+"'))maxload  from V#STAFF A where A.departmentcode='"+QryDept+"' and a.COMPANYCODE='"+mComp+"' and nvl(A.deactive,'N')='N'";
/*
	qry+=" minus ";
	qry+=" select A.facultyid facultyid,B.Employeename employeename,B.COMPANYCODE companycode,";
	qry+=" A.FACULTYTYPE facultytype,WebKiosk.getAssignedTeachLoad(B.COMPANYCODE,'"+mInst+"',A.facultyid,A.FACULTYTYPE,'"+QryExam+"')assignedload , ";
	qry+=" WebKiosk.getAssignedTeachLoad(B.COMPANYCODE,'"+mInst+"',A.facultyid,A.FACULTYTYPE,'"+QryExam+"','"+QrySubjID+"','"+mBasket+"','"+mLTP+"')assignedload11 , ";
	qry+=" WebKiosk.getMinTeachLoad(B.COMPANYCODE,'"+mInst+"',A.facultyid,A.FACULTYTYPE,'"+QryExam+"')minload,WebKiosk.getMaxTeachLoad(B.COMPANYCODE,'"+mInst+"',A.facultyid,A.FACULTYTYPE,'"+QryExam+"')maxload from PR#FACULTYSUBJECTCHOICES A,V#STAFF B where A.institutecode='"+mInst+"' ";
	qry+=" and A.examcode='"+QryExam+"' and A.SUBJECTID='"+QrySubjID+"' and A.LTP='"+mLTP+"' ";
	qry+=" and subjecttype='"+mType+"' and A.facultyid=B.employeeid and nvl(A.deactive,'N')='N' and nvl(b.deactive,'N')='N'";
*/
	qry+=" order by employeename";
//out.print(qry);

	//qry="SELECT DISTINCT EMPLOYEEID Faculty, NVL(EMPLOYEENAME,' ')||' ('||NVL(EMPLOYEECODE,' ')||')' FacName from EMPLOYEEMASTER WHERE COMPANYCODE='"+mComp+"' AND DEPARTMENTCODE='"+QryDept+"' AND NVL(DEACTIVE,'N')='N' ORDER BY FacName";
//out.print(qry);
	rs=db.getRowset(qry);
	if (request.getParameter("xx")==null)
	{
		%>
		<select name=Faculty tabindex="0" id="Faculty" style="background-color:#C6D6FD; color:black; font-weight:normal">
		<OPTION selected Value ='NONE'>Select a Faculty for All</option>
		<%
		while(rs.next())
		{
			mEmpid=rs.getString("facultyid");
			mEmpTyp=rs.getString("facultytype");
			mEcmp=rs.getString("companycode");
			mAssignedload=rs.getDouble("assignedload");
			mMaxload=rs.getDouble("maxload");
			mMinload=rs.getDouble("minload");
			mexcludeassign=rs.getDouble("assignedload11");
			mEmpIdv=mEmpid+"***"+mAssignedload+"///"+mMinload+"###"+mMaxload+"*****"+mEmpTyp+"/////"+mEcmp+"$$$$"+mexcludeassign;
			if(QryFaculty.equals(""))
 				QryFaculty=mEmpIdv;
			%>
			<OPTION Value =<%=mEmpIdv%>><%=rs.getString("employeename")%></option>
			<%
		}
		%>
		</select>
		<%
	}
	else
	{
		%>
		<select name=Faculty tabindex="0" id="Faculty" style="background-color:#C6D6FD; color:black; font-weight:normal">
		<%
		if(request.getParameter("Faculty").equals("NONE"))
		{
			%>
			<OPTION Selected Value ='NONE'>Select a Faculty for All</option>
			<%
		}
		else
		{
			%>
			<OPTION Value ='NONE'>Select a Faculty for All</option>
			<%
		}
		while(rs.next())
		{
			mEmpid=rs.getString("facultyid");
			mEmpTyp=rs.getString("facultytype");
			mEcmp=rs.getString("companycode");
			mAssignedload=rs.getDouble("assignedload");
			mMaxload=rs.getDouble("maxload");
			mMinload=rs.getDouble("minload");
			mexcludeassign=rs.getDouble("assignedload11");
			mEmpIdv=mEmpid+"***"+mAssignedload+"///"+mMinload+"###"+mMaxload+"*****"+mEmpTyp+"/////"+mEcmp+"$$$$"+mexcludeassign;

			if(mEmpIdv.equals(request.getParameter("Faculty").toString().trim()))
			{
				QryFaculty=mEmpIdv;
				%>
				<OPTION selected Value =<%=mEmpIdv%>><%=rs.getString("employeename")%></option>
				<%
			}
			else
			{
				%>
				<OPTION Value =<%=mEmpIdv%>><%=rs.getString("employeename")%></option>
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
}
%>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<a href="PRLoadDistributionByHODActionMultiFac.jsp?ExamCode=<%=QryExam%>&Dura=<%=mlt1%>&PROJSUBJ=<%=mProjSubj%>&Sub=<%=mSubj%>&Basket=<%=mBasket%>&LTP=<%=mLTP%>&Dept=<%=QryDept%>&Subjid=<%=QrySubjID%>&Elecode=<%=QryEleCode%>&PRCODE=<%=request.getParameter("PRCODE")%>&radio1=<%=request.getParameter("radio1")%>&ELE=<%=mEle%>&SUBNAME='<%=request.getParameter("SUBNAME")%>'&TYPE=<%=mType%>&SEM=<%=QrySemType%>&classweek=<%=mlt%>" target="_blank"><font face=arial color=blue size=2><b>Click to club Multiple/Additional Faculty globally</b></Font></a>
</td></tr>
</table>
<TABLE width="100%" align=center rules=Rows class="sort-table" id="table-1" cellSpacing=0 cellPadding=0 border=1 rules=groups>
<thead>
<tr bgcolor="#C6D6FD">
<td align=middle><b><font color=black face=arial size=2>Section</font><b></td>
<td align=middle><b><font color=black face=arial size=2>SubSection</font><b></td>
<td align=middle><b><font color=black face=arial size=2>Faculty Choice</font><b></td>
<td align=middle><b><font color=black face=arial size=2>Merge</font><b></td>
<td align=middle><b><font color=black face=arial size=2>Multiple Faculty</font><b></td>
<!--<td align=middle><b><font color=black face=arial size=2>&nbsp;</font><b></td> -->
<td align=middle><b><font color=black face=arial size=2>Total Student</font><b></td>
</tr>
</thead>
<tbody>
<%
//    if(request.getParameter("x")!=null)
//	{
	int mFlag=0;
//=============================================
//=============================================
	if(mType.equals("C"))
	{
		qry="SELECT DISTINCT b.subsectioncode subsectioncode, a.academicyear academicyear, a.programcode, a.taggingfor,a.sectionbranch sectionbranch,";
		qry+=" a.semester semester, a.semestertype,to_char( (SELECT COUNT (*) FROM programsubsectiontagging cc  ";
		qry+=" WHERE cc.institutecode = '"+mInst+"' AND cc.examcode = '"+QryExam+"' AND B.SUBSECTIONCODE IS NOT NULL";
		qry+=" AND cc.semestertype =DECODE ('"+QrySemType+"','ALL', cc.semestertype,'"+QrySemType+"') AND NVL (cc.deactive, 'N') = 'N' ";
		qry+=" AND cc.academicyear = a.academicyear AND cc.programcode = a.programcode AND cc.sectionbranch = a.sectionbranch AND cc.semester = a.semester AND cc.subsectiontype = 'C'";
		qry+=" AND cc.academicyear = b.academicyear AND cc.programcode = b.programcode AND cc.semester = b.semester AND cc.sectionbranch = b.sectionbranch";
		qry+=" AND cc.academicyear = c.academicyear AND cc.programcode = c.programcode AND cc.semester = c.semester AND cc.sectionbranch = c.sectionbranch ) )cnt";
		qry+=" FROM programsubsectiontagging a, pr#STUDENTSUBJECTCHOICE b  ,ProgramSubjecttagging c WHERE a.institutecode = '"+mInst+"' AND a.institutecode = b.institutecode AND b.institutecode = c.institutecode AND c.institutecode = a.institutecode";
		qry+=" AND a.examcode = c.examcode AND a.examcode = b.examcode AND b.subjecttype = 'C' AND a.examcode = '"+QryExam+"' ";
		qry+=" AND a.semestertype = DECODE ('"+QrySemType+"', 'ALL', a.semestertype, '"+QrySemType+"') AND NVL (a.deactive, 'N') = 'N' ";
		qry+=" AND a.academicyear = b.academicyear AND a.programcode = b.programcode AND a.sectionbranch = b.sectionbranch  ";
		qry+=" and a.academicyear=c.ACADEMICYEAR and a.programcode=c.programcode and b.SECTIONBRANCH=c.SECTIONBRANCH AND b.TAGGINGFOR=c.TAGGINGFOR ";
		qry+=" AND a.semester = b.semester and a.semester = c.semester and a.taggingfor=c.taggingfor and a.SECTIONBRANCH=c.SECTIONBRANCH And B.SubjectID = C.SubjectID ";
		qry+=" AND b.subjectid = '"+QrySubjID+"' AND C.BASKET='"+mBasket+"' AND a.subsectiontype = 'C'  AND B.SUBSECTIONCODE IS NOT NULL";
		qry+=" AND a.semestertype =  b.semestertype AND nvl(b.subjectrunning,'N')='Y'  ";
		qry+=" AND b.subjectid IN (SELECT d.subjectid FROM pr#departmentsubjecttagging d WHERE d.departmentcode = '"+QryDept+"' ";
		qry+=" AND d.sectionbranch = a.sectionbranch AND d.sectionbranch = b.sectionbranch)";
		qry+=" UNION ";
		qry+=" SELECT DISTINCT A.subsectioncode subsectioncode, a.academicyear academicyear, a.programcode, a.taggingfor,a.sectionbranch sectionbranch,";
		qry+=" a.semester, a.semestertype,to_char((SELECT COUNT (*) FROM programsubsectiontagging c  ";
		qry+=" WHERE c.institutecode = '"+mInst+"' AND c.examcode = '"+QryExam+"' AND A.SUBSECTIONCODE IS NOT NULL";
		qry+=" AND c.semestertype =DECODE ('"+QrySemType+"','ALL', c.semestertype,'"+QrySemType+"') AND NVL (c.deactive, 'N') = 'N' ";
		qry+=" AND c.academicyear = a.academicyear AND c.programcode = a.programcode AND c.sectionbranch = a.sectionbranch ";
		qry+=" AND c.semester = a.semester AND c.institutecode = b.institutecode AND c.academicyear = b.academicyear AND c.subsectiontype = 'C')) cnt ";
		qry+=" FROM programsubsectiontagging a, academicyearmaster b, ProgramSubjecttagging c WHERE a.institutecode = '"+mInst+"' AND a.institutecode = b.institutecode AND b.institutecode = c.institutecode AND c.institutecode = a.institutecode";
		qry+=" AND a.examcode = c.examcode AND c.basket = 'A' AND a.examcode = '"+QryExam+"' AND a.semestertype = DECODE ('"+QrySemType+"', 'ALL', a.semestertype, '"+QrySemType+"') AND NVL (a.deactive, 'N') = 'N' ";
		qry+=" AND a.academicyear = b.academicyear AND a.academicyear = c.academicyear AND a.programcode = c.programcode AND a.Semester = c.Semester and a.taggingfor=c.taggingfor and a.SECTIONBRANCH=c.SECTIONBRANCH and a.subsectiontype='C' AND NVL (b.currentyear, 'N') = 'Y'";
		qry+=" AND c.subjectid IN (SELECT d.subjectid FROM pr#departmentsubjecttagging d WHERE d.departmentcode='"+QryDept+"' AND d.sectionbranch = a.sectionbranch AND d.sectionbranch = a.sectionbranch)";
		qry+=" AND c.subjectid='"+QrySubjID+"' AND C.BASKET='"+mBasket+"' ";
		qry+=" AND A.INSTITUTECODE='"+mInst+"' and A.INSTITUTECODE=b.Institutecode and c.INSTITUTECODE=b.Institutecode";
		qry+=" ORDER BY SECTIONBRANCH,ACADEMICYEAR,subsectioncode,PROGRAMCODE,TAGGINGFOR,SEMESTER,SEMESTERTYPE";


	}
	else if(mType.equals("E"))
	{
		qry="	select distinct A.SUBSECTIONCODE subsectioncode, a.academicyear academicyear, A.PROGRAMCODE,A.TAGGINGFOR,A.SECTIONBRANCH SECTIONBRANCH,";
		qry+=" a.semester, a.semestertype,to_char((SELECT COUNT (*) FROM programsubsectiontagging cc  ";
		qry+=" WHERE cc.institutecode = '"+mInst+"' AND cc.examcode = '"+QryExam+"' ";//AND B.SUBSECTIONCODE IS NOT NULL";
		qry+=" AND cc.semestertype =DECODE ('"+QrySemType+"','ALL', cc.semestertype,'"+QrySemType+"') AND NVL (cc.deactive, 'N') = 'N' ";
		qry+=" AND cc.academicyear = a.academicyear AND cc.programcode = a.programcode AND cc.sectionbranch = a.sectionbranch AND cc.semester = a.semester AND cc.subsectiontype = 'C'";
		qry+=" AND cc.academicyear = b.academicyear AND cc.programcode = b.programcode AND cc.semester = b.semester AND cc.sectionbranch = b.sectionbranch ))cnt";
		qry+=" from PROGRAMSUBSECTIONTAGGING A, PR#ELECTIVESUBJECTS B where B.SUBJECTRUNNING='Y' and exists (SELECT 1 FROM pr#studentsubjectchoice C WHERE C.institutecode='"+mInst+"' AND C.EXAMCODE= '"+QryExam+"' AND c.semestertype = decode('"+QrySemType+"','ALL',C.semestertype,'"+QrySemType+"') AND NVL (c.deactive, 'N') = 'N' AND c.academicyear = a.academicyear AND c.programcode = a.programcode AND c.sectionbranch = a.sectionbranch AND c.semester = a.semester AND a.sectionbranch = b.sectionbranch AND c.subjectid = b.subjectid AND c.subjecttype = 'E') AND A.institutecode='"+mInst+"' and B.ELECTIVECODE='"+QryEleCode+"' AND A.examcode='"+QryExam+"' and ";
		qry+=" A.semestertype=decode('"+QrySemType+"','ALL',A.semestertype,'"+QrySemType+"') and nvl(A.deactive,'N')='N' and ";
		qry+=" A.ACADEMICYEAR=B.ACADEMICYEAR and A.PROGRAMCODE=B.PROGRAMCODE and A.EXAMCODE=B.EXAMCODE and A.SECTIONBRANCH=B.SECTIONBRANCH ";
		qry+=" AND A.SEMESTER=B.SEMESTER and B.SUBJECTID='"+QrySubjID+"' AND B.BASKET='"+mBasket+"' and A.SUBSECTIONTYPE='C' AND A.SUBSECTIONCODE IS NOT NULL";
		qry+=" and B.subjectid in (select D.subjectid from PR#DEPARTMENTSUBJECTTAGGING D ";
		qry+=" where  D.departmentcode ='"+QryDept+"'  and D.SECTIONBRANCH=A.SECTIONBRANCH and D.SECTIONBRANCH=B.SECTIONBRANCH) ";
		//qry+=" order by A.SECTIONBRANCH, A.ACADEMICYEAR, subsectioncode, A.PROGRAMCODE, A.TAGGINGFOR, A.SEMESTER, A.SEMESTERTYPE";
		qry+=" UNION ";
		qry+=" SELECT DISTINCT A.subsectioncode subsectioncode, a.academicyear academicyear, a.programcode, a.taggingfor,a.sectionbranch sectionbranch,";
		qry+=" a.semester, a.semestertype,to_char((SELECT COUNT (*) FROM programsubsectiontagging c  ";
		qry+=" WHERE c.institutecode = '"+mInst+"' AND c.examcode = '"+QryExam+"' AND A.SUBSECTIONCODE IS NOT NULL";
		qry+=" AND c.semestertype =DECODE ('"+QrySemType+"','ALL', c.semestertype,'"+QrySemType+"') AND NVL (c.deactive, 'N') = 'N' ";
		qry+=" AND c.academicyear = a.academicyear AND c.programcode = a.programcode AND c.sectionbranch = a.sectionbranch ";
		qry+=" AND c.semester = a.semester AND c.institutecode = b.institutecode AND c.academicyear = b.academicyear AND c.subsectiontype = 'C')) cnt ";
		qry+=" FROM programsubsectiontagging a, academicyearmaster b, pr#electivesubjects c WHERE a.institutecode = '"+mInst+"' AND a.institutecode = b.institutecode AND b.institutecode = c.institutecode AND c.institutecode = a.institutecode";
		qry+=" AND a.examcode = c.examcode  AND a.examcode = '"+QryExam+"' AND a.semestertype = DECODE ('"+QrySemType+"', 'ALL', a.semestertype, '"+QrySemType+"') AND NVL (a.deactive, 'N') = 'N' ";
		qry+=" AND a.academicyear = b.academicyear AND a.academicyear = c.academicyear AND a.programcode = c.programcode AND a.Semester = c.Semester and a.taggingfor=c.taggingfor and a.SECTIONBRANCH=c.SECTIONBRANCH and a.subsectiontype='C' AND NVL (b.currentyear, 'N') = 'Y'";
		qry+=" AND c.subjectid IN (SELECT d.subjectid FROM pr#departmentsubjecttagging d WHERE d.departmentcode='"+QryDept+"' AND d.sectionbranch = a.sectionbranch AND d.sectionbranch = a.sectionbranch)";
		qry+=" AND c.subjectid='"+QrySubjID+"' AND C.BASKET='"+mBasket+"'";
		qry+=" AND A.INSTITUTECODE='"+mInst+"' and A.INSTITUTECODE=b.Institutecode and c.INSTITUTECODE=b.Institutecode";
		qry+=" ORDER BY SECTIONBRANCH,ACADEMICYEAR,subsectioncode,PROGRAMCODE,TAGGINGFOR,SEMESTER,SEMESTERTYPE";
	}
//====================================================
//====================================================


	rs1=db.getRowset(qry);
	ctr=0;
	String mChkFac[]=new String[100];
	String mChkFacS1[]=new String[100];
	String mChkFacS11[]=new String[100];
	String QryAcadYr="", TotAcadYr="", QryProgCode="", TotSemester="";
	while(rs1.next())
	{
		mChkFacS1[x]=rs1.getString("SECTIONBRANCH");
		mChkFac[x]=rs1.getString("subsectioncode");
		mChkFacS11[x]=rs1.getString("PROGRAMCODE");
		x++;

		mFlag=1;
		mSeccount=rs1.getString("cnt");
		mSubsection=rs1.getString("subsectioncode");
		QryAcadYr=rs1.getString("academicyear");
		QryProgCode=rs1.getString("programcode");
		msno++;
	//	out.print("TOTAL - "+mSeccount);
		mName4="OLDNEW"+String.valueOf(msno).trim();
		if(!mSection.equals(rs1.getString("SECTIONBRANCH")))
		{
			ctr=0;
			CTR++;
			//out.print(CTR);
			mSection=rs1.getString("SECTIONBRANCH");
			mStudcnt="";
			int mStudCount=0;
			if(mType.equals("C"))
			{
				qry=" SELECT DISTINCT a.academicyear academicyear, a.semester semester";
				qry+=" FROM programsubsectiontagging a, academicyearmaster b, ProgramSubjecttagging c WHERE a.institutecode = '"+mInst+"' and a.INSTITUTECODE=c.INSTITUTECODE ";
				qry+=" AND a.examcode = c.examcode AND c.basket = 'A' AND a.examcode = '"+QryExam+"' AND a.semestertype = DECODE ('"+QrySemType+"', 'ALL', a.semestertype, '"+QrySemType+"') AND NVL (a.deactive, 'N') = 'N' ";
				qry+=" AND a.academicyear = b.academicyear AND a.academicyear = c.academicyear AND a.programcode = c.programcode AND a.Semester = c.Semester and a.subsectiontype='C' AND NVL (b.currentyear, 'N') = 'Y'";
				//qry+=" AND c.subjectid IN (SELECT d.subjectid FROM pr#departmentsubjecttagging d WHERE d.departmentcode='"+QryDept+"' AND d.sectionbranch = a.sectionbranch AND d.sectionbranch = a.sectionbranch)";
				qry+=" AND c.subjectid='"+QrySubjID+"'";
				qry+=" GROUP BY a.academicyear, a.semester ORDER BY ACADEMICYEAR";
		//		out.print(qry);
				ResultSet RrSs=db.getRowset(qry);
				TotAcadYr="";
				TotSemester="";
				while (RrSs.next())
				{
					if(TotAcadYr.equals(""))
						TotAcadYr="'"+RrSs.getString(1)+"'";
					else
						TotAcadYr=TotAcadYr+",'"+RrSs.getString(1)+"'";

					if(TotSemester.equals(""))
						TotSemester="'"+RrSs.getString(2)+"'";
					else
						TotSemester=TotSemester+",'"+RrSs.getString(2)+"'";
				}
				//out.print("Total Acad Yr - "+TotAcadYr+" Total Semester - "+TotSemester);
				if(rs1.getString("semestertype").equals("REG"))
				{
					qry1="SELECT nvl(COUNT (DISTINCT studentid),0) cnt FROM PR#StudentSubjectChoice A  WHERE A.institutecode = '"+mInst+"'   AND a.sectionbranch = '"+rs1.getString("SECTIONBRANCH")+"'   And a.EXAMCODE='"+QryExam+"'   And a.ACADEMICYEAR='"+rs1.getString("academicyear")+"'     And a.TAGGINGFOR='"+rs1.getString("TAGGINGFOR")+"'   And a.SECTIONBRANCH='"+rs1.getString("SECTIONBRANCH")+"'   And a.SEMESTER='"+rs1.getString("SEMESTER")+"'   AND a.subjectid = '"+QrySubjID+"'  And a.SubjectType='C' AND a.semestertype = DECODE ('"+QrySemType+"', 'ALL', semestertype, '"+QrySemType+"') And a.subsectioncode is not null";
					rsc=db.getRowset(qry1);
					//out.println(qry1);
					if(rsc.next())
					{
						mStudCount=rsc.getInt("cnt");
						//out.println(rs1.getString("SECTIONBRANCH")+" "+mStudCount);
					}

					String qrycuracd="select 1 from ACADEMICYEARMASTER a where A.institutecode = '"+mInst+"' and nvl(deactive,'N')='N' and nvl(closed,'N')='N' And nvl(CURRENTYEAR,'N')='Y' and ACADEMICYEAR IN (SELECT ACADEMICYEAR FROM PROGRAMSUBSECTIONTAGGING WHERE INSTITUTECODE='"+mInst+"' and EXAMCODE='"+QryExam+"' and nvl(semester,0)=1)";
					if(!TotAcadYr.equals(""))
						qrycuracd+=" and a.ACADEMICYEAR IN ("+TotAcadYr+")";
					else
						qrycuracd+=" and a.ACADEMICYEAR=''";

					ResultSet rscuracd=db.getRowset(qrycuracd);
					//out.println(qrycuracd);
					if(rscuracd.next())
					{
						qry1="select nvl(sum (maxstudent),0) cnt from ( SELECT DISTINCT a.subsectioncode subsectioncode,a.academicyear, a.programcode ,maxstudent FROM programsubsectiontagging a, academicyearmaster b,programsubjecttagging c";
						qry1+=" WHERE a.institutecode='"+mInst+"' AND a.institutecode = c.institutecode AND a.examcode = c.examcode AND c.basket = 'A' AND a.examcode = '"+QryExam+"' AND a.semestertype = DECODE ('"+QrySemType+"', 'ALL', a.semestertype, '"+QrySemType+"')";
						qry1+=" AND NVL (a.deactive, 'N') = 'N' AND a.academicyear = b.academicyear AND a.academicyear = c.academicyear AND a.programcode = c.programcode AND a.semester = c.semester AND a.subsectiontype = 'C' and a.subsectioncode is not null";
						qry1+=" AND NVL (b.currentyear, 'N') = 'Y' AND a.academicyear IN ("+TotAcadYr+") and a.sectionbranch = '"+rs1.getString("SECTIONBRANCH")+"' AND a.taggingfor = '"+rs1.getString("TAGGINGFOR")+"'";
						qry1+=" AND a.semester IN ("+TotSemester+") AND subjectid='"+QrySubjID+"' AND c.subjectid IN (SELECT d.subjectid FROM pr#departmentsubjecttagging d WHERE d.departmentcode = '"+QryDept+"' AND d.sectionbranch = a.sectionbranch AND d.sectionbranch = a.sectionbranch))";
						rsc=db.getRowset(qry1);
						//out.println(qry1);
						//out.print(mStudCount);
						if(rsc.next())
						{
							//--------By Vijay AsOn02/12/2009--------

							mStudCount=rsc.getInt("cnt");
							mStudCount=mStudCount+rsc.getInt("cnt");

							//---------------------------------------
							//out.println(rs1.getString("SECTIONBRANCH")+" "+mStudCount);
						}
					}
					mStudcnt=mStudCount+"";

					//out.println(rs1.getString("SECTIONBRANCH")+" "+mStudcnt);
				}
				else
				{
					qry1="SELECT   nvl(COUNT (studentid),0) cnt FROM pr#studentsubjectchoice cc WHERE cc.institutecode = '"+mInst+"' AND cc.examcode = '"+QryExam+"' AND NVL (cc.deactive, 'N') = 'N' and cc.semestertype='RWJ' AND cc.subjectid = '"+QrySubjID+"' and ACADEMICYEAR ='"+rs1.getString("ACADEMICYEAR")+"' and PROGRAMCODE='"+rs1.getString("PROGRAMCODE")+"' and SECTIONBRANCH ='"+mSection+"'";
					rsc=db.getRowset(qry1);
					//out.println(qry1);
					if(rsc.next())
					{
						mStudcnt=rsc.getString("cnt");
						// out.println(mStudcnt);
					}



				}
			}
			else if(mType.equals("E"))
			{
				qry=" SELECT DISTINCT a.academicyear academicyear, a.semester semester";
				qry+=" FROM programsubsectiontagging a, academicyearmaster b, pr#electivesubjects c WHERE a.institutecode = '"+mInst+"' and a.INSTITUTECODE=c.INSTITUTECODE ";
				qry+=" AND a.examcode = c.examcode AND a.examcode = '"+QryExam+"' AND a.semestertype = DECODE ('"+QrySemType+"', 'ALL', a.semestertype, '"+QrySemType+"') AND NVL (a.deactive, 'N') = 'N' ";
				qry+=" AND a.academicyear = b.academicyear AND a.academicyear = c.academicyear AND a.programcode = c.programcode AND a.Semester = c.Semester and a.subsectiontype='C' AND NVL (b.currentyear, 'N') = 'Y'";
				//qry+=" AND c.subjectid IN (SELECT d.subjectid FROM pr#departmentsubjecttagging d WHERE d.departmentcode='"+QryDept+"' AND d.sectionbranch = a.sectionbranch AND d.sectionbranch = a.sectionbranch)";
				qry+=" AND c.subjectid='"+QrySubjID+"'";
				qry+=" GROUP BY a.academicyear, a.semester ORDER BY ACADEMICYEAR";
				//out.print(qry);
				ResultSet RrSs=db.getRowset(qry);
				TotAcadYr="";
				TotSemester="";
				while (RrSs.next())
				{
					if(TotAcadYr.equals(""))
						TotAcadYr="'"+RrSs.getString(1)+"'";
					else
						TotAcadYr=TotAcadYr+",'"+RrSs.getString(1)+"'";

					if(TotSemester.equals(""))
						TotSemester="'"+RrSs.getString(2)+"'";
					else
						TotSemester=TotSemester+",'"+RrSs.getString(2)+"'";
				}
				String qrycuracd="";
				qrycuracd="select 1 from ACADEMICYEARMASTER a where A.institutecode = '"+mInst+"' and nvl(deactive,'N')='N' and nvl(closed,'N')='N' And nvl(CURRENTYEAR,'N')='Y' and ACADEMICYEAR IN (SELECT ACADEMICYEAR FROM PROGRAMSUBSECTIONTAGGING WHERE INSTITUTECODE='"+mInst+"' and EXAMCODE='"+QryExam+"' and nvl(semester,0)=1)";
				//out.print(qrycuracd);
					if(!TotAcadYr.equals(""))
						qrycuracd+=" and a.ACADEMICYEAR IN ("+TotAcadYr+")";
					else
						qrycuracd+=" and a.ACADEMICYEAR=''";

					ResultSet rscuracd=db.getRowset(qrycuracd);
					//out.println(qrycuracd);
					if(rscuracd.next())
					{

						qry1="select nvl(sum (maxstudent),0) cnt from ( SELECT DISTINCT a.subsectioncode subsectioncode,a.academicyear, a.programcode ,maxstudent FROM programsubsectiontagging a, academicyearmaster b,PR#ELECTIVESUBJECTS c";
						qry1+=" WHERE a.institutecode='"+mInst+"' AND a.institutecode = c.institutecode AND a.examcode = c.examcode  AND a.examcode = '"+QryExam+"' AND a.semestertype = DECODE ('"+QrySemType+"', 'ALL', a.semestertype, '"+QrySemType+"')";
						qry1+=" AND NVL (a.deactive, 'N') = 'N' AND a.academicyear = b.academicyear AND a.academicyear = c.academicyear AND a.programcode = c.programcode AND a.semester = c.semester AND a.subsectiontype = 'C' and a.subsectioncode is not null";
						qry1+=" AND NVL (b.currentyear, 'N') = 'Y' AND a.academicyear IN ("+TotAcadYr+") and a.sectionbranch = '"+rs1.getString("SECTIONBRANCH")+"' AND a.taggingfor = '"+rs1.getString("TAGGINGFOR")+"'";
						qry1+=" AND a.semester IN ("+TotSemester+") AND subjectid='"+QrySubjID+"' AND c.subjectid IN (SELECT d.subjectid FROM pr#departmentsubjecttagging d WHERE d.departmentcode = '"+QryDept+"' AND d.sectionbranch = a.sectionbranch AND d.sectionbranch = a.sectionbranch))";
						rsc=db.getRowset(qry1);
						//out.println(qry1);
						if(rsc.next())
						{
							mStudCount=mStudCount+rsc.getInt("cnt");
							//out.println(rs1.getString("SECTIONBRANCH")+" "+mStudCount);
						}
					}
					else
				{
						qry1="SELECT nvl(COUNT (DISTINCT studentid),0) cnt FROM PR#StudentSubjectChoice A  WHERE A.institutecode = '"+mInst+"'   AND a.sectionbranch = '"+rs1.getString("SECTIONBRANCH")+"'   And a.EXAMCODE='"+QryExam+"'   And a.ACADEMICYEAR='"+rs1.getString("academicyear")+"'     And a.TAGGINGFOR='"+rs1.getString("TAGGINGFOR")+"'   And a.SECTIONBRANCH='"+rs1.getString("SECTIONBRANCH")+"'   And a.SEMESTER='"+rs1.getString("SEMESTER")+"'   AND a.subjectid = '"+QrySubjID+"'  And a.SubjectType='E' AND a.semestertype = DECODE ('"+QrySemType+"', 'ALL', semestertype, '"+QrySemType+"') And a.subsectioncode is not null AND NVL (a.subjectrunning, 'N') = 'Y'";
				rsc=db.getRowset(qry1);
				//out.println(qry1);
				if(rsc.next())
				{
					mStudCount=rsc.getInt("cnt");
				}
				else
				{
					//mStudcnt="0";
				}
				}


					mStudcnt=mStudCount+"";

			}
			mName5="SEC"+String.valueOf(CTR).trim();
			%>
			<thead>
			<tr bgcolor=lightgrey>
			<%
			if(request.getParameter(mName5)==null)
			{
				%>
				<td align="left"><input type=checkbox name="<%=mName5%>" value='Y' onClick="CheckBoxOption('OUT','<%=mName5%>','<%=mName6%>','<%=CTR%>');"><B><%=mSection%></B></td>
				<%
			}
			else if(request.getParameter(mName5).equals("Y"))
			{
				%>
				<td align="left"><input type=checkbox name="<%=mName5%>" value='Y' onClick="CheckBoxOption('OUT','<%=mName5%>','<%=mName6%>','<%=CTR%>');" ><B><%=mSection%></B></td>
				<%
			}
			else
			{
				%>
				<td align="left"><input type=checkbox name="<%=mName5%>" value='Y' onClick="CheckBoxOption('OUT','<%=mName5%>','<%=mName6%>','<%=CTR%>');"><B><%=mSection%></B></td>
				<%
			}
			%>
			<td>
			&nbsp;
			</td>
			<td align="center">
			<%
			qry="select A.Employeeid facultyid,A.Employeename employeename,A.COMPANYCODE companycode,";
			qry+=" A.EMPLOYEETYPE facultytype,to_char(WebKiosk.getAssignedTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+QryExam+"'))assignedload, ";
			qry+=" to_char(WebKiosk.getAssignedTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+QryExam+"','"+QrySubjID+"','"+mBasket+"','"+mLTP+"'))assignedload11 , ";
			qry+=" to_char(WebKiosk.getMinTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+QryExam+"')) minload,to_char(WebKiosk.getMaxTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE ,'"+QryExam+"'))maxload  from V#STAFF A where A.departmentcode='"+QryDept+"' and a.COMPANYCODE='"+mComp+"' and nvl(A.deactive,'N')='N' " +
                                " UNION ALL SELECT a.guestid facultyid, a.guestname employeename, a.companycode companycode, 'G' facultytype, '1' assignedload,  '1' assignedload11, '1' minload, '500' maxload  FROM guest a  WHERE a.departmentcode = '"+QryDept+"' AND NVL (a.deactive, 'N') = 'N'";
/*
			qry+=" minus ";
			qry+=" select A.facultyid facultyid,B.Employeename employeename,B.COMPANYCODE companycode,";
			qry+=" A.FACULTYTYPE facultytype,WebKiosk.getAssignedTeachLoad(B.COMPANYCODE,'"+mInst+"',A.facultyid,A.FACULTYTYPE,'"+QryExam+"')assignedload , ";
			qry+=" WebKiosk.getAssignedTeachLoad(B.COMPANYCODE,'"+mInst+"',A.facultyid,A.FACULTYTYPE,'"+QryExam+"','"+QrySubjID+"','"+mBasket+"','"+mLTP+"')assignedload11 , ";
			qry+=" WebKiosk.getMinTeachLoad(B.COMPANYCODE,'"+mInst+"',A.facultyid,A.FACULTYTYPE,'"+QryExam+"')minload,WebKiosk.getMaxTeachLoad(B.COMPANYCODE,'"+mInst+"',A.facultyid,A.FACULTYTYPE,'"+QryExam+"')maxload from PR#FACULTYSUBJECTCHOICES A,V#STAFF B where A.institutecode='"+mInst+"' ";
			qry+=" and A.examcode='"+QryExam+"' and A.SUBJECTID='"+QrySubjID+"' and A.LTP='"+mLTP+"' ";
			qry+=" and subjecttype='"+mType+"' and A.facultyid=B.employeeid and nvl(A.deactive,'N')='N' and nvl(b.deactive,'N')='N'";
*/
			qry+=" order by employeename";
			//out.println(qry);
			rs=db.getRowset(qry);
			//out.println(ctr);
			//out.println(mSeccount);
			//mSeccount="6";
			mName1=mSection+"***R///"+String.valueOf(ctr).trim()+"###"+mSeccount;
		//out.print(mName1);
			mName2=mSection+"***R///"+String.valueOf(ctr).trim()+"###"+mSeccount+"txt";
			mNameLMR=mSection+"***R///"+String.valueOf(ctr).trim()+"###"+mSeccount+"merge";
//out.print(mSection+" "+ctr+" "+mSeccount);
//out.println( mName1+" <br> "+mName2+" <br> "+mNameLMR);
//out.println(mNameLMR);
			//out.print(QryFaculty+" "+mEmpid+" "+moldemp1);
			%>
			<select name="<%=mName1%>" id=<%=mName1%> tabindex="0" style="WIDTH:250px;" onChange="ChangeOptions2('<%=mName1%>','<%=mName2%>',<%=mlt1%>,<%=mlt%>);">
			<%
			if (request.getParameter("xx")==null)
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
				while(rs.next())
				{
					mEmpid=rs.getString("facultyid");
					mEmpTyp=rs.getString("facultytype");
					mEcmp=rs.getString("companycode");
					mAssignedload=rs.getDouble("assignedload");
					mMaxload=rs.getDouble("maxload");
					mMinload=rs.getDouble("minload");
					mexcludeassign=rs.getDouble("assignedload11");

					mEmpIdv=mEmpid+"***"+mAssignedload+"///"+mMinload+"###"+mMaxload+"*****"+mEmpTyp+"/////"+mEcmp+"$$$$"+mexcludeassign;

					if(moldemp1.equals(mEmpid))
					{
						//System.out.println(moldemp1+"==="+mEmpid);
						mFlag11=1;
						%>
						<OPTION selected Value =<%=mEmpIdv%>><%=rs.getString("employeename")%></option>
						<%
					}
					else
					{
						%>
						<OPTION  Value =<%=mEmpIdv%>><%=rs.getString("employeename")%></option>
						<%
					}
				} // closing of while
			}
			else
			{
				if(QryFaculty.equals("NONE"))
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
				while(rs.next())
				{
					mEmpid=rs.getString("facultyid");
					mEmpTyp=rs.getString("facultytype");
					mEcmp=rs.getString("companycode");
					mAssignedload=rs.getDouble("assignedload");
					mMaxload=rs.getDouble("maxload");
					mMinload=rs.getDouble("minload");
					mexcludeassign=rs.getDouble("assignedload11");

					if(request.getParameter(mName5)==null)
						mMName5="";
					else
						mMName5="Y";

					mEmpIdv=mEmpid+"***"+mAssignedload+"///"+mMinload+"###"+mMaxload+"*****"+mEmpTyp+"/////"+mEcmp+"$$$$"+mexcludeassign;

					if(!QryFaculty.equals("NONE") && QryFaculty.equals(mEmpIdv) && mMName5.equals("Y"))
					{
						mFlag11=1;
						int LEN=mEmpIdv.length();
						int POS=mEmpIdv.indexOf("***");
						String mFacID=mEmpIdv.substring(0,POS);
						qry="SELECT NVL(EMPLOYEENAME,' ')EMPLOYEENAME FROM V#STAFF WHERE COMPANYCODE='"+mComp+"' AND EMPLOYEEID='"+mFacID+"'";
						ResultSet RRSS=db.getRowset(qry);
						if(RRSS.next())
						{
							%>
							<OPTION selected Value =<%=mEmpIdv%>><%=RRSS.getString("EMPLOYEENAME")%></option>
							<%
						}
					}
					else
					{
						%>
						<OPTION  Value =<%=mEmpIdv%>><%=rs.getString("employeename")%></option>
						<%
					}
				} // closing of while
			}
			%>
			</select>
			</td>
			<td>
			&nbsp;
			</td>
			<td>
			&nbsp;
			</td>
			<td align=middle><B><%=mStudcnt%></B></td>
			</tr>
			</thead>
			<%
			//out.print(mEmpIdv);
		}
		ctr++;
		mProgramcode=rs1.getString("PROGRAMCODE");
		mName6="SEC"+String.valueOf(CTR).trim()+String.valueOf(ctr).trim();
		//out.print(mName6);
		%>
		<tr>
		<td>&nbsp;</td>
		<%
		if(request.getParameter(mName6)==null)
		{
			%>
			<td align="Left"><input type=checkbox name="<%=mName6%>" value='YY' onClick="CheckBoxOption('IN','<%=mName5%>','<%=mName6%>','<%=CTR%>');"> <%=QryAcadYr%> - <%=mSubsection%>&nbsp;(<%=mProgramcode%>)</td>
			<%
		}
		else if(request.getParameter(mName6).equals("YY"))
		{
			%>
			<td align="Left"><input type=checkbox name="<%=mName6%>" value='YY' onClick="CheckBoxOption('IN','<%=mName5%>','<%=mName6%>','<%=CTR%>');" > <%=QryAcadYr%> - <%=mSubsection%>&nbsp;(<%=mProgramcode%>)</td>
			<%
		}
		else
		{
			%>
			<td align="Left"><input type=checkbox name="<%=mName6%>" value='YY' onClick="CheckBoxOption('IN','<%=mName5%>','<%=mName6%>','<%=CTR%>');"> <%=QryAcadYr%> - <%=mSubsection%>&nbsp;(<%=mProgramcode%>)</td>
			<%
		}
		%>
		<td align="center">
		<%
		qry="select A.Employeeid facultyid,A.Employeename employeename,A.COMPANYCODE companycode,";
		qry+=" A.EMPLOYEETYPE facultytype,to_char(WebKiosk.getAssignedTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+QryExam+"'))assignedload, ";
		qry+="to_char( WebKiosk.getAssignedTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+QryExam+"','"+QrySubjID+"','"+mBasket+"','"+mLTP+"'))assignedload11 , ";
		qry+="to_char( WebKiosk.getMinTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+QryExam+"')) minload,to_char(WebKiosk.getMaxTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE ,'"+QryExam+"'))maxload  from V#STAFF A where A.departmentcode='"+QryDept+"' and nvl(A.deactive,'N')='N' and A.COMPANYCODE='"+mComp+"'";
                qry+= " UNION ALL SELECT a.guestid facultyid, a.guestname employeename, a.companycode companycode, 'G' facultytype, '1' assignedload,  '1' assignedload11, '1' minload, '500' maxload  FROM guest a  WHERE a.departmentcode = '"+QryDept+"' AND NVL (a.deactive, 'N') = 'N'";

                /*
		qry+=" minus ";
		qry+=" select A.facultyid facultyid,B.Employeename employeename,B.COMPANYCODE companycode,";
		qry+=" A.FACULTYTYPE facultytype,WebKiosk.getAssignedTeachLoad(B.COMPANYCODE,'"+mInst+"',A.facultyid,A.FACULTYTYPE,'"+QryExam+"')assignedload, ";
		qry+=" WebKiosk.getAssignedTeachLoad(B.COMPANYCODE,'"+mInst+"',A.facultyid,A.FACULTYTYPE,'"+QryExam+"','"+QrySubjID+"','"+mBasket+"','"+mLTP+"')assignedload11 , ";
		qry+=" WebKiosk.getMinTeachLoad(B.COMPANYCODE,'"+mInst+"',A.facultyid,A.FACULTYTYPE,'"+QryExam+"')minload,WebKiosk.getMaxTeachLoad(B.COMPANYCODE,'"+mInst+"',A.facultyid,A.FACULTYTYPE,'"+QryExam+"')maxload from PR#FACULTYSUBJECTCHOICES A,V#STAFF B where A.institutecode='"+mInst+"' ";
		qry+=" and A.examcode='"+QryExam+"' and A.SUBJECTID='"+QrySubjID+"' and A.LTP='"+mLTP+"' ";
		qry+=" and subjecttype='"+mType+"' and A.facultyid=B.employeeid and nvl(A.deactive,'N')='N' and nvl(b.deactive,'N')='N'";
*/
		qry+=" order by employeename";
		rs=db.getRowset(qry);

		mName1=mSection+"***R///"+String.valueOf(ctr).trim()+"###"+mSeccount ;
		mName2=mSection+"***R///"+String.valueOf(ctr).trim()+"###"+mSeccount+"txt" ;
		mNameLMR=mSection+"***R///"+String.valueOf(ctr).trim()+"###"+mSeccount+"merge";
//out.println( mName1+" <br> "+mName2+"<br>"+mNameLMR);
//out.println(mNameLMR);
//out.print("OLD - "+mOldEmp);
		%>
		<select <%=mDis%> name="<%=mName1%>" id=<%=mName1%> tabindex="0" style="WIDTH: 250px;" onChange="ChangeOptions4('<%=mName1%>','<%=mName2%>',<%=mlt1%>,<%=mlt%>,<%=msno%>);" onFocus="change_assigned('<%=mName1%>',<%=msno%>);")">
		<%
		if (request.getParameter("xx")==null)
		{
			if(mOldEmp.equals(""))
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
			while(rs.next())
			{
				mOldEmp="";
				qry1="select A.Employeeid facultyid,A.Employeename employeename,A.COMPANYCODE companycode, A.EMPLOYEETYPE facultytype,";
				qry1+=" to_char(WebKiosk.getAssignedTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+QryExam+"'))assignedload, ";
				qry1+=" to_char(WebKiosk.getAssignedTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+QryExam+"','"+QrySubjID+"','"+mBasket+"','"+mLTP+"'))assignedload11 , ";
				qry1+=" to_char( WebKiosk.getMinTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+QryExam+"') )minload,to_char(WebKiosk.getMaxTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE ,'"+QryExam+"'))maxload  from V#STAFF A where A.departmentcode='"+QryDept+"' and nvl(A.deactive,'N')='N' and A.COMPANYCODE='"+mComp+"'";
				qry1+=" And A.Employeeid IN (Select FACULTYID from PR#HODLOADDISTRIBUTION where INSTITUTECODE='"+mInst+"' AND COMPANYCODE='"+mComp+"' AND EXAMCODE='"+QryExam+"' AND ACADEMICYEAR='"+QryAcadYr+"' AND PROGRAMCODE='"+QryProgCode+"' AND SECTIONBRANCH='"+rs1.getString("SECTIONBRANCH")+"' AND SUBSECTIONCODE='"+rs1.getString("subsectioncode")+"' AND SEMESTERTYPE='"+QrySemType+"' AND BASKET='"+mBasket+"' AND SUBJECTID='"+QrySubjID+"' AND LTP='"+mLTP+"' AND DEPARTMENTRUNNIG='"+QryDept+"')";
				//out.print(qry1);
				//System.out.println(qry1);
				ResultSet rsPreReg=db.getRowset(qry1);
				if(rsPreReg.next())
				{
					String mEmpidOld="", mEmpTypOld="", mEcmpOld="";
					double mAssignedloadOld=0, mMaxloadOld=0, mMinloadOld=0, mexcludeassignOld=0;
					mEmpidOld=rsPreReg.getString("facultyid");
					mEmpTypOld=rsPreReg.getString("facultytype");
					mEcmpOld=rsPreReg.getString("companycode");
					mAssignedloadOld=rsPreReg.getDouble("assignedload");
					mMaxloadOld=rsPreReg.getDouble("maxload");
					mMinloadOld=rsPreReg.getDouble("minload");
					mexcludeassignOld=rsPreReg.getDouble("assignedload11");
					mOldEmp=mEmpidOld+"***"+mAssignedloadOld+"///"+mMinloadOld+"###"+mMaxloadOld+"*****"+mEmpTypOld+"/////"+mEcmpOld+"$$$$"+mexcludeassignOld;
				}

				mEmpid=rs.getString("facultyid");
				mEmpTyp=rs.getString("facultytype");
				mEcmp=rs.getString("companycode");
				mAssignedload=rs.getDouble("assignedload");
				mMaxload=rs.getDouble("maxload");
				mMinload=rs.getDouble("minload");
				mexcludeassign=rs.getDouble("assignedload11");

				mEmpIdv=mEmpid+"***"+mAssignedload+"///"+mMinload+"###"+mMaxload+"*****"+mEmpTyp+"/////"+mEcmp+"$$$$"+mexcludeassign ;

				if(mOldEmp.equals(mEmpIdv))
				{
//System.out.println("...............................");
//System.out.println(mOldEmp);
//System.out.println(mEmpIdv);
					%>
					<OPTION SELECTED Value =<%=mEmpIdv%>><%=rs.getString("employeename")%></option>
					<%
				}
				else
				{
					%>
					<OPTION Value =<%=mEmpIdv%>><%=rs.getString("employeename")%></option>
					<%
				}

			} //closing of while
	  	} //closing of if
		else
		{
			if(mOldEmp.equals(""))
			{
				%>
				<OPTION selected Value ='NONE'>Select a Faculty</option>
				<%
			}
			else
			{
				%>
				<OPTION Value ='NONE'>Select a Faculty</option>
				<%
			}
			while(rs.next())
			{
				mOldEmp="";
				qry1="select A.Employeeid facultyid,A.Employeename employeename,A.COMPANYCODE companycode, A.EMPLOYEETYPE facultytype,";
				qry1+=" to_char(WebKiosk.getAssignedTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+QryExam+"'))assignedload, ";
				qry1+="to_char( WebKiosk.getAssignedTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+QryExam+"','"+QrySubjID+"','"+mBasket+"','"+mLTP+"'))assignedload11 , ";
				qry1+="to_char( WebKiosk.getMinTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+QryExam+"') )minload,to_char(WebKiosk.getMaxTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE ,'"+QryExam+"'))maxload  from V#STAFF A where A.departmentcode='"+QryDept+"' and nvl(A.deactive,'N')='N' and A.COMPANYCODE='"+mComp+"'";
				qry1+=" And A.Employeeid IN (Select FACULTYID from PR#HODLOADDISTRIBUTION where INSTITUTECODE='"+mInst+"' AND COMPANYCODE='"+mComp+"' AND EXAMCODE='"+QryExam+"' AND ACADEMICYEAR='"+QryAcadYr+"' AND PROGRAMCODE='"+QryProgCode+"' AND SECTIONBRANCH='"+rs1.getString("SECTIONBRANCH")+"' AND SUBSECTIONCODE='"+rs1.getString("subsectioncode")+"' AND SEMESTERTYPE='"+QrySemType+"' AND BASKET='"+mBasket+"' AND SUBJECTID='"+QrySubjID+"' AND LTP='"+mLTP+"' AND DEPARTMENTRUNNIG='"+QryDept+"')";
				//out.print(qry1);
				ResultSet rsPreReg=db.getRowset(qry1);
				if(rsPreReg.next())
				{
					String mEmpidOld="", mEmpTypOld="", mEcmpOld="";
					double mAssignedloadOld=0, mMaxloadOld=0, mMinloadOld=0, mexcludeassignOld=0;
					mEmpidOld=rsPreReg.getString("facultyid");
					mEmpTypOld=rsPreReg.getString("facultytype");
					mEcmpOld=rsPreReg.getString("companycode");
					mAssignedloadOld=rsPreReg.getDouble("assignedload");
					mMaxloadOld=rsPreReg.getDouble("maxload");
					mMinloadOld=rsPreReg.getDouble("minload");
					mexcludeassignOld=rsPreReg.getDouble("assignedload11");
					mOldEmp=mEmpidOld+"***"+mAssignedloadOld+"///"+mMinloadOld+"###"+mMaxloadOld+"*****"+mEmpTypOld+"/////"+mEcmpOld+"$$$$"+mexcludeassignOld;
				}

				mEmpid=rs.getString("facultyid");
				mEmpTyp=rs.getString("facultytype");
				mEcmp=rs.getString("companycode");
				mAssignedload=rs.getDouble("assignedload");
				mMaxload=rs.getDouble("maxload");
				mMinload=rs.getDouble("minload");
				mexcludeassign=rs.getDouble("assignedload11");

				mEmpIdv=mEmpid+"***"+mAssignedload+"///"+mMinload+"###"+mMaxload+"*****"+mEmpTyp+"/////"+mEcmp+"$$$$"+mexcludeassign ;

				if(request.getParameter(mName6)==null)
					mMName6="";
				else
					mMName6="YY";

				//System.out.println("QryFaculty - "+QryFaculty+" mEmpIdv - "+mEmpIdv+" mMName6 - "+mMName6);
				if(!QryFaculty.equals("NONE") && QryFaculty.equals(mEmpIdv) && mMName6.equals("YY"))
				//if(!QryFaculty.equals("NONE") && mMName6.equals("YY"))
				{
					qry="DELETE TEMP#PR#LOADDISTRIBUTION WHERE PROGRAMCODE='"+rs1.getString("programcode")+"' AND ACADEMICYEAR='"+rs1.getString("academicyear")+"' AND SECTIONBRANCH='"+rs1.getString("sectionbranch")+"' AND SUBSECTIONCODE='"+rs1.getString("subsectioncode")+"' AND SUBJECTID='"+QrySubjID+"' AND LTP='"+mLTP+"' AND NVL(INSERTFROMGLOBAL,'N')='Y'";
					int delTmp=db.update(qry);

					//System.out.println("QryFaculty - "+QryFaculty+" mEmpIdv - "+mEmpIdv+" mMName6 - "+mMName6);
					mFlag11=1;
					int LEN=mEmpIdv.length();
					int POS=mEmpIdv.indexOf("***");
					String mFacID=mEmpIdv.substring(0,POS);
					qry="SELECT NVL(EMPLOYEENAME,' ')EMPLOYEENAME FROM V#STAFF WHERE COMPANYCODE='"+mComp+"' AND EMPLOYEEID='"+mFacID+"'";
					//System.out.println("<BR>"+qry+"<BR>");
					ResultSet RST=db.getRowset(qry);
					if(RST.next())
					{
						%>
						<OPTION selected Value =<%=mEmpIdv%>><%=RST.getString("EMPLOYEENAME")%></option>
						<%
					}
//------------------
					String id=mLTP+rs1.getString("sectionbranch")+rs1.getString("subsectioncode")+rs1.getString("academicyear")+rs1.getString("programcode");
					try
					{
						for(int j=0;j<mTotGlFac;j++)
						{
							// System.out.println(mTotGlFac);
							String aa=multiFac[j];
							String fid=aa.substring(0,aa.indexOf("***"));
							String ftype=aa.substring(aa.indexOf("***")+3,aa.indexOf("///"));
							String cmp=aa.substring(aa.indexOf("///")+3,aa.indexOf("@@@"));
							String hr=aa.substring(aa.indexOf("###")+3,aa.indexOf("```"));
							String setsess=aa.substring(aa.indexOf("```")+3,aa.indexOf("~~~"));
							String classsess=aa.substring(aa.indexOf("~~~")+3,aa.indexOf("((("));
							String set1val=aa.substring(aa.indexOf("(((")+3,aa.indexOf(")))"));
							String set2val=aa.substring(aa.indexOf(")))")+3,aa.indexOf("???"));
							String set3val=aa.substring(aa.indexOf("???")+3,aa.indexOf("<<<"));
							String SubjInSet=aa.substring(aa.indexOf("<<<")+3,aa.indexOf(">>>"));
							String LtpInSet=aa.substring(aa.indexOf(">>>")+3,aa.length());
							if(QrySubjID.equals(SubjInSet) && mLTP.equals(LtpInSet))
							{
								//if(!mEmpid.equals(fid)) //Main Faculty in MultiFacultySubjectTagging
								//{
									//System.out.println(mEmpid+" : "+fid);
									qry="INSERT INTO TEMP#PR#LOADDISTRIBUTION (SESSIONID, USERID,  SUBJECTID, SECTIONBRANCH, SUBSECTIONCODE, LTP,COMPANYCODE, FACULTYTYPE,  EMPLOYEEID, NOFHRS, DATETIME,FACULTYSET, CLASSINAWEEK,SET1, SET2,SET3, INSERTFROMGLOBAL, ACADEMICYEAR, PROGRAMCODE)";
									qry+=" VALUES('"+id+"','"+mChkMemID+"' ,'"+QrySubjID+"',  '"+rs1.getString("sectionbranch")+"', '"+rs1.getString("subsectioncode")+"', '"+mLTP+"', '"+cmp+"', '"+ftype+"', '"+fid+"',"+hr+" ,sysdate, '"+setsess+"','"+mlt+"','"+set1val+"',' "+set2val+"','"+set3val+"','Y','"+rs1.getString("academicyear")+"','"+rs1.getString("programcode")+"')";
									int nnnn1=db.insertRow(qry);
									//System.out.print(qry);
								//}
							}
						}
					}
					catch(Exception e)
					{
								 out.print(e+" 111111");
					}
//------------------
				}
				else
				{
					if(mOldEmp.equals(mEmpIdv))
					{
						try
						{
							qry="Select A.COMPANYCODE CC, A.FACULTYTYPE FT, A.EMPLOYEEID EID, nvl(A.NOFHRS,'') HR, B.ENTRYDATE DT, A.FACULTYSET FS, nvl(A.CLASSINAWEEK,'') CPW,nvl(A.SET1,'') S1, nvl(A.SET2,'') S2, nvl(A.SET3,'') S3, B.ACADEMICYEAR AYR, B.PROGRAMCODE PC";
							qry+=" FROM MULTIFACULTYSUBJECTTAGGING A, PR#HODLOADDISTRIBUTION B WHERE A.FSTID=B.FSTID";
							qry+=" AND B.SUBJECTID='"+QrySubjID+"' and B.LTP='"+mLTP+"' and B.SECTIONBRANCH='"+rs1.getString("sectionbranch")+"' and B.SUBSECTIONCODE='"+rs1.getString("subsectioncode")+"' and B.AcademicYear='"+rs1.getString("academicyear")+"' and B.ProgramCode='"+rs1.getString("programcode")+"'";

							ResultSet rstrst1=db.getRowset(qry);
							//System.out.print(qry);
							while(rstrst1.next())
							{
								String id1=mLTP+rs1.getString("sectionbranch")+rs1.getString("subsectioncode")+rs1.getString("academicyear")+rs1.getString("programcode");

								qry="INSERT INTO TEMP#PR#LOADDISTRIBUTION (SESSIONID, USERID,  SUBJECTID, SECTIONBRANCH, SUBSECTIONCODE, LTP,COMPANYCODE, FACULTYTYPE,  EMPLOYEEID, NOFHRS, DATETIME,FACULTYSET, CLASSINAWEEK,SET1, SET2,SET3,ACADEMICYEAR, PROGRAMCODE)";
								qry+=" VALUES('"+id1+"','"+mChkMemID+"' ,'"+QrySubjID+"',  '"+rs1.getString("sectionbranch")+"', '"+rs1.getString("subsectioncode")+"', '"+mLTP+"',";
								qry+=" '"+rstrst1.getString("CC")+"', '"+rstrst1.getString("FT")+"', '"+rstrst1.getString("EID")+"',"+rstrst1.getString("HR")+" ,sysdate, '"+rstrst1.getString("FS")+"','"+rstrst1.getString("CPW")+"','"+rstrst1.getString("S1")+"',' "+rstrst1.getString("S2")+"',";
								qry+=" '"+rstrst1.getString("S3")+"','"+rs1.getString("academicyear")+"','"+rs1.getString("programcode")+"')";
								//int nnn1=db.insertRow(qry);
								//System.out.print(qry);
							}
						}
						catch(Exception e)
						{
									 out.print(" 2222");
						}
						if(mMName6.equals("YY"))
						{
							%>
							<OPTION Value =<%=mEmpIdv%>><%=rs.getString("employeename")%></option>
							<%
						}
						else
						{
							%>
							<OPTION selected Value =<%=mEmpIdv%>><%=rs.getString("employeename")%></option>
							<%
						}
					}
					else
					{
						%>
						<OPTION Value =<%=mEmpIdv%>><%=rs.getString("employeename")%></option>
						<%
					}
				}

			} //closing of while
		}
		%>
		</select>
		</td>
		<%
			qry="select A.FACULTYID FACULTYID,nvl(MERGEWITHFSTID,' ')MERGEWITHFSTID from PR#HODLOADDISTRIBUTION A  where A.institutecode='"+mInst+"' ";
			qry=qry+" and A.examcode='"+QryExam+"' and A.SUBJECTID='"+QrySubjID+"' and A.LTP='"+mLTP+"' ";
			qry=qry+" and A.SECTIONBRANCH='"+mSection+"' and programcode='"+rs1.getString("PROGRAMCODE")+"' and A.subsectioncode='"+mSubsection+"' and nvl(A.deactive,'N')='N' ";
			qry=qry+" and A.semestertype='"+rs1.getString("SEMESTERTYPE")+"' and a.ACADEMICYEAR='"+rs1.getString("academicyear")+"' ";
			//out.print(qry);
			rs5=db.getRowset(qry);
			if(rs5.next())
			{
				moldemp1=rs5.getString("FACULTYID");
				moldMerge1=rs5.getString("MERGEWITHFSTID");
				mFlag11=1;
			}
			else
			{
				moldemp1="";
				moldMerge1="";
				mFlag11=0;
			}
//out.print("fsdfsd"+moldMerge1);
			if(!moldMerge1.equals(" ") && !moldMerge1.equals(""))
			{
				qrym="select A.subsectioncode, A.programcode from PR#HODLOADDISTRIBUTION A where A.institutecode='"+mInst+"' ";
				qrym=qrym+" and fstid='"+moldMerge1+"' and A.examcode='"+QryExam+"' and A.SUBJECTID='"+QrySubjID+"' and A.LTP='"+mLTP+"' ";
				qrym=qrym+" and nvl(A.deactive,'N')='N' ";
				rsm=db.getRowset(qrym);
				//out.print(qrym);
				if(rsm.next())
				{
					moldMerge=rsm.getString("subsectioncode");
					mprogc=rsm.getString("programcode");
				}
				else
				{
					moldMerge="";
					mprogc="";
				}
			}
			else
			{
				moldMerge="";
			}


//out.print("Old - "+moldMerge+" "+mprogc);
%>
		<td align="center">
		<select name='<%=mNameLMR%>' id='<%=mNameLMR%>' tabindex="0" style="WIDTH: 140px" onChange="ChangeOptions6('<%=mName1%>','<%=mNameLMR%>');">
		<%
		if(moldMerge.equals(""))
		{
			%>
			<option selected value='NONE'>Merge</option>
			<%
		}
		else
		{
			%>
			<option value='NONE'>Merge </option>
			<%
		}

		for(int jp=0;jp<x;jp++)
		{
			mvalue=rs1.getString("SECTIONBRANCH")+"***"+rs1.getString("subsectioncode")+"///"+mChkFac[jp]+"###"+mChkFacS11[jp]+"$$$"+mChkFacS1[jp] ;
			if(moldMerge.equals(mChkFac[jp]) )//&& mprogc.equals(mChkFacS11[jp]))
			{
				//System.out.println("Merge - "+mChkFac[jp]+" *** "+mChkFacS11[jp]);
			}
			if(moldMerge.equals(mChkFac[jp]) && mprogc.equals(mChkFacS11[jp]))
			{
			      if(mFlag11==1)
				{
					%>
					<option selected value='<%=mvalue%>'>(<%=mChkFacS11[jp]%>)<%=mChkFacS1[jp]%>/<%=mChkFac[jp]%></option>
					<%
			      }
				else
				{
					%>
				 	<option value='<%=mvalue%>'>(<%=mChkFacS11[jp]%>)<%=mChkFacS1[jp]%>/<%=mChkFac[jp]%></option>
					<%
				}
			}
			else
			{
				%>
				<option value='<%=mvalue%>'>(<%=mChkFacS11[jp]%>)<%=mChkFacS1[jp]%>/<%=mChkFac[jp]%></option>
				<%
			}
		}
		%>
		</select>
		</td>
		<%
		String mNm="", mNn="";
		mNm="mNm_"+String.valueOf(msno).trim();
		mNn="mNn_"+String.valueOf(msno).trim();
		%>
		<input type="hidden" name="<%=mNm%>" value="<%=mOldEmp%>">
		<input type="hidden" name="<%=mNn%>" value="<%=msno%>">
		<%
		//if(!mLTP.equals("L"))
		{
			%>
			<td align="center"><a href="PRLoadDistributionByHODActionInnerMultiFac.jsp?mAcad=<%=QryAcadYr%>&amp;mProg=<%=QryProgCode%>&amp;ExamCode=<%=QryExam%>&Sub=<%=mSubj%>&Basket=<%=mBasket%>&LTP=<%=mLTP%>&Dept=<%=QryDept%>&Subjid=<%=QrySubjID%>&Elecode=<%=QryEleCode%>&PRCODE=<%=request.getParameter("PRCODE")%>&radio1=<%=request.getParameter("radio1")%>&ELE=<%=mEle%>&SUBNAME=<%=request.getParameter("SUBNAME")%>&TYPE=<%=mType%>&SEM=<%=QrySemType%>&section=<%=rs1.getString("SECTIONBRANCH")%>&mSubSection=<%=mSubsection%>&classweek=<%=mlt%>" target="_blank"><Font color=blue face=arial><B>Club Multi / Addl. Faculty</B></FONT></a></td>
			<%
			String subseccount="";
			if(mType.equals("C"))
			{
				String query123="";
				if(rs1.getString("semestertype").equals("REG"))
				{
					String qrycuracd1="select 1 from ACADEMICYEARmaster a where A.institutecode = '"+mInst+"' and a.ACADEMICYEAR='"+rs1.getString("academicyear")+"'  and nvl(deactive,'N')='N' and nvl(closed,'N')='N' And nvl(CURRENTYEAR,'N')='Y' and ACADEMICYEAR IN (SELECT ACADEMICYEAR FROM PROGRAMSUBSECTIONTAGGING WHERE INSTITUTECODE='"+mInst+"' and EXAMCODE='"+QryExam+"' and nvl(semester,0)=1)";
					ResultSet rscuracd1=db.getRowset(qrycuracd1);
					//out.println(qrycuracd1+"<BR><BR>");
					if(rscuracd1.next())
					{
						query123="select nvl(sum(MAXSTUDENT),0) cnt from programsubsectiontagging a  WHERE A.institutecode = '"+mInst+"'   AND a.sectionbranch = '"+rs1.getString("SECTIONBRANCH")+"'   And a.EXAMCODE='"+QryExam+"'   And a.ACADEMICYEAR='"+rs1.getString("academicyear")+"'   And a.PROGRAMCODE='"+rs1.getString("PROGRAMCODE")+"'   And a.TAGGINGFOR='"+rs1.getString("TAGGINGFOR")+"'  And a.SEMESTER='"+rs1.getString("SEMESTER")+"'  AND a.semestertype = DECODE ('"+QrySemType+"', 'ALL', semestertype, '"+QrySemType+"')  And nvl(a.SUBSECTIONCODE,'*')='"+mSubsection+"'";
					}
					else
					{
						query123="SELECT nvl(COUNT (DISTINCT studentid),0) cnt FROM PR#StudentSubjectChoice A  WHERE A.institutecode = '"+mInst+"'   AND a.sectionbranch = '"+rs1.getString("SECTIONBRANCH")+"'   And a.EXAMCODE='"+QryExam+"'   And a.ACADEMICYEAR='"+rs1.getString("academicyear")+"'   And a.PROGRAMCODE='"+rs1.getString("PROGRAMCODE")+"'   And a.TAGGINGFOR='"+rs1.getString("TAGGINGFOR")+"'   And a.SECTIONBRANCH='"+rs1.getString("SECTIONBRANCH")+"'   And a.SEMESTER='"+rs1.getString("SEMESTER")+"'  And nvl(a.SUBSECTIONCODE,'*')='"+mSubsection+"'  AND a.subjectid = '"+QrySubjID+"'  And a.SubjectType='C' AND a.semestertype = DECODE ('"+QrySemType+"', 'ALL', semestertype, '"+QrySemType+"') And a.subsectioncode is not null";
					}
					//out.println(query123);
				}
				ResultSet rssec=db.getRowset(query123);
				while(rssec.next())
				{
					subseccount=rssec.getString("cnt");
				}
			}
			else if(mType.equals("E"))
			{

				String query123="";
				String qrycuracd1="select 1 from ACADEMICYEARmaster a where A.institutecode = '"+mInst+"' and a.ACADEMICYEAR='"+rs1.getString("academicyear")+"'  and nvl(deactive,'N')='N' and nvl(closed,'N')='N' And nvl(CURRENTYEAR,'N')='Y' and ACADEMICYEAR IN (SELECT ACADEMICYEAR FROM PROGRAMSUBSECTIONTAGGING WHERE INSTITUTECODE='"+mInst+"' and EXAMCODE='"+QryExam+"' and nvl(semester,0)=1)";
					ResultSet rscuracd1=db.getRowset(qrycuracd1);
					//out.println(qrycuracd1+"<BR><BR>");
					if(rscuracd1.next())
					{

						query123="select nvl(sum (maxstudent),0) cnt from ( SELECT DISTINCT a.subsectioncode subsectioncode,a.academicyear, a.programcode ,maxstudent FROM programsubsectiontagging a, academicyearmaster b,PR#ELECTIVESUBJECTS c";
						query123+=" WHERE a.institutecode='"+mInst+"' AND a.institutecode = c.institutecode AND a.examcode = c.examcode  AND a.examcode = '"+QryExam+"' AND a.semestertype = DECODE ('"+QrySemType+"', 'ALL', a.semestertype, '"+QrySemType+"')";
						query123+=" AND NVL (a.deactive, 'N') = 'N' AND a.academicyear = b.academicyear AND a.academicyear = c.academicyear AND a.programcode = c.programcode AND a.semester = c.semester AND a.subsectiontype = 'C' and a.subsectioncode is not null";
						query123+=" AND NVL (b.currentyear, 'N') = 'Y' AND a.academicyear IN ("+TotAcadYr+") and a.sectionbranch = '"+rs1.getString("SECTIONBRANCH")+"' AND a.taggingfor = '"+rs1.getString("TAGGINGFOR")+"'";
						query123+=" AND a.semester IN ("+TotSemester+") AND subjectid='"+QrySubjID+"' And nvl(a.SUBSECTIONCODE,'*')='"+mSubsection+"' AND c.subjectid IN (SELECT d.subjectid FROM pr#departmentsubjecttagging d WHERE d.departmentcode = '"+QryDept+"' AND d.sectionbranch = a.sectionbranch AND d.sectionbranch = a.sectionbranch))";
						//out.println(qry1);


						/*query123="SELECT nvl(COUNT (DISTINCT studentid),0) cnt FROM programsubsectiontagging A  WHERE A.institutecode = '"+mInst+"'   AND a.sectionbranch = '"+rs1.getString("SECTIONBRANCH")+"'   And a.EXAMCODE='"+QryExam+"'   And a.ACADEMICYEAR='"+rs1.getString("academicyear")+"'   And a.PROGRAMCODE='"+rs1.getString("PROGRAMCODE")+"'   And a.TAGGINGFOR='"+rs1.getString("TAGGINGFOR")+"'   And a.SECTIONBRANCH='"+rs1.getString("SECTIONBRANCH")+"'   And a.SEMESTER='"+rs1.getString("SEMESTER")+"'  And nvl(a.SUBSECTIONCODE,'*')='"+mSubsection+"'  AND a.subjectid = '"+QrySubjID+"'  And a.SubjectType='E' AND a.semestertype = DECODE ('"+QrySemType+"', 'ALL', semestertype, '"+QrySemType+"') and nvl(a.SUBJECTRUNNING,'N')='Y' And a.subsectioncode is not null";*/
//						out.println(query123);

					}
					else
					{

						query123="SELECT nvl(COUNT (DISTINCT studentid),0) cnt FROM PR#StudentSubjectChoice A  WHERE A.institutecode = '"+mInst+"'   AND a.sectionbranch = '"+rs1.getString("SECTIONBRANCH")+"'   And a.EXAMCODE='"+QryExam+"'   And a.ACADEMICYEAR='"+rs1.getString("academicyear")+"'   And a.PROGRAMCODE='"+rs1.getString("PROGRAMCODE")+"'   And a.TAGGINGFOR='"+rs1.getString("TAGGINGFOR")+"'   And a.SECTIONBRANCH='"+rs1.getString("SECTIONBRANCH")+"'   And a.SEMESTER='"+rs1.getString("SEMESTER")+"'  And nvl(a.SUBSECTIONCODE,'*')='"+mSubsection+"'  AND a.subjectid = '"+QrySubjID+"'  And a.SubjectType='E' AND a.semestertype = DECODE ('"+QrySemType+"', 'ALL', semestertype, '"+QrySemType+"') and nvl(a.SUBJECTRUNNING,'N')='Y' And a.subsectioncode is not null";


						 /*qry1="select nvl(sum (maxstudent),0) cnt from ( SELECT DISTINCT a.subsectioncode subsectioncode,a.academicyear, a.programcode ,maxstudent FROM programsubsectiontagging a, academicyearmaster b,PR#ELECTIVESUBJECTS c";
						qry1+=" WHERE a.institutecode='"+mInst+"' AND a.institutecode = c.institutecode AND a.examcode = c.examcode  AND a.examcode = '"+QryExam+"' AND a.semestertype = DECODE ('"+QrySemType+"', 'ALL', a.semestertype, '"+QrySemType+"')";
						qry1+=" AND NVL (a.deactive, 'N') = 'N' AND a.academicyear = b.academicyear AND a.academicyear = c.academicyear AND a.programcode = c.programcode AND a.semester = c.semester AND a.subsectiontype = 'C' and a.subsectioncode is not null";
						qry1+=" AND NVL (b.currentyear, 'N') = 'Y' AND a.academicyear IN ("+TotAcadYr+") and a.sectionbranch = '"+rs1.getString("SECTIONBRANCH")+"' AND a.taggingfor = '"+rs1.getString("TAGGINGFOR")+"'";
						qry1+=" AND a.semester IN ("+TotSemester+") AND subjectid='"+QrySubjID+"' AND c.subjectid IN (SELECT d.subjectid FROM pr#departmentsubjecttagging d WHERE d.departmentcode = '"+QryDept+"' AND d.sectionbranch = a.sectionbranch AND d.sectionbranch = a.sectionbranch))";*/
						//out.println(query123);

					}

				ResultSet rssec=db.getRowset(query123);
				while(rssec.next())
				{
					subseccount=rssec.getString("cnt");
					//out.println("aaa"+subseccount);
				}
			}
			else
			{
			}
		%>
		<td align="center"><%=subseccount%></td>
		<%
	}
	qry="select fstid from PR#HODLOADDISTRIBUTION where institutecode='"+mInst+"' and examcode='"+QryExam+"' and ";
	qry+=" SUBJECTID='"+QrySubjID+"' and programcode='"+rs1.getString("PROGRAMCODE")+"' and sectionbranch='"+mSection+"'";
	qry+=" and ACADEMICYEAR ='"+rs1.getString("ACADEMICYEAR")+"' and subsectioncode='"+mSubsection+"' and LTP='"+mLTP+"' and Semestertype='"+QrySemType+"'";
	//out.print(qry);
	ResultSet rsChkFst=db.getRowset(qry);
	if(rsChkFst.next())
	//if(mFlag11==1 || mFlag111==1)
	{
		%>
		<input type=hidden name=<%=mName4%> id=<%=mName4%> value=O>
		<%
	}
	else
	{
		%>
		<input type=hidden name=<%=mName4%> id=<%=mName4%> value=N>
		<%
	}
	mFlag11=0;
	mFlag111=0;
} // closing of outer while
if(mFlag==1)
{
	mFlag=0;
	%>
	<tr>
	<td colspan=2 align=center nowrap><input type=submit name=assign id=assign style="background-color:lightgrey; color:black; font-weight:bold; width:70px;" value='Assign~'"><BR>~ Use this button for Global Load Assignment</td>
	<td colspan=4>&nbsp;</td>
	</tr>

	<tr><TD ALIGN=LEFT colspan=7><Font face=verdana color=navy>*In case of global Load assignment, you can use "Merge" option only after clicking over the "Assign" button.</font>
	<br>
	<Font face=verdana color=navy>*Click "Draft Save" button after every click of the "Assign" button to Save the changes made by you.</font>
	</td></tr>

	<TR>
	<TD ALIGN=CENTER colspan=7><table width=100% align=center><tr><td align=center>
	<input type=submit name=save id=save style="background-color:#C6D6FD; color:black; font-weight:bold; width:120px;" value='Draft Save' onMouseDown="submitForm()">
	</td></tr></table></TD>
	</TR>
	<%
}
%>
<input type=hidden name=xx ID=xx value="">
<input type=hidden name=CTR ID=CTR value="<%=CTR%>">
<input type=hidden name=RunningDept ID=RunningDept value=<%=QryDept%>>
<input type=hidden name=EXAM ID=EXAM value=<%=QryExam%>>
<input type=hidden name=SEMTYPE ID=SEMTYPE value=<%=QrySemType%>>
<input type=hidden name=Dura ID=Dura value=<%=mlt1%>>
<input type=hidden name=Class1 ID=Class1 value=<%=mlt%>>
<input type=hidden name=Faculty ID=Faculty value=<%=QryFaculty%>>

<input type=hidden name=INSTITUTE ID=INSTITUTE value=<%=mInst%>>
<input type=hidden name=LTP ID=LTP value=<%=mLTP%>>
<input type=hidden name=SUBJECT ID=SUBJECT value=<%=mSubj%>>
<input type=hidden name=SUBJECTID ID=SUBJECTID value=<%=QrySubjID%>>
<input type=hidden name=PROJSUBJ ID=PROJSUBJ value=<%=mProjSubj%>>
<input type=hidden name=TotalRec ID=TotalRec value=<%=msno%>>
<input type=hidden name=TYPE ID=TYPE value=<%=mType%>>
<input type=hidden name=BASKET ID=BASKET value=<%=mBasket%>>
<input type=hidden name=DURATION ID=DURATION value=<%=mlt1%>>
<input type=hidden name=NOOFCLASS ID=NOOFCLASS value=<%=mlt%>>
<input type=hidden name=ELECTIVECODE ID=ELECTIVECODE value=<%=QryEleCode%>>
</tbody>
</table>
</form>
<%

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
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}
session.setAttribute("MultiCumAddlFaculty",null);
}
catch(Exception e)
{
//	out.println(e);

									 out.print(" 44444");
}
%>
</body>
</html>