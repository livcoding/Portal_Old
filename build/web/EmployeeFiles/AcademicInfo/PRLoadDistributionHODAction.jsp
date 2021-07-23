
<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
ResultSet rs=null,rs1=null,rs2=null,rs3=null,rs5=null,rsc=null,rsl=null,rsm=null;
String mMemberID="",mDMemberID="",qry1="",mNameLML="",mvalue="",qrym="",mDept2=""; 
String mMemberName="",mProgramcode="";
String mMemberType="",mDMemberType="",mStudcnt="",mDis="",moldMerge="",moldMerge1="";
String mHead="",moldemp="",moldemp1="",mNameLMR="";
String mDMemberCode="",mMemberCode="",mFac="",mfac="",mElective="";
String mInst="",mSection="",mSubsection="",mBasket="",mOfac="",mprogc="";
String qry="",Type="",mltp="",mSem="",mEmpid="",memp="",mName1="",mName2="";
String mName3="",mName4="",mName5="",mName6="",mName7="",mName8="",mName9="",mName10="",mCompcode="",procode="";
int mL1=0;
int mT1=0;
int mP1=0;				
int mlt1=0;
int mFlag2=0,mFlag1=0,mFlag11=0,mFlag111=0;
int ctr=0,x=0;
int msno=0;
String mType="",mLTP="",mSubj="",mDept="",mSname="",mExamcode="",mSeccount="",mPrCode="";
int mL=0,mT=0,mP=0,mlt=0;
double mAssigned=0,mMin=0,mMax=0,mexcludeassign=0 ;
double mAssignedload=0,mMinload=0,mMaxload=0;
String mEmpidv="";
String mFacv="",mTyp="",mEmpTyp="",mcmp="",mEcmp="",mDuration="",mClass="",mSendhod="";
String mMult="";
String [] mMultiFaculty=new String [1000];
if (session.getAttribute("CompanyCode")==null)
{
	mCompcode="";
}
else
{
	mCompcode=session.getAttribute("CompanyCode").toString().trim();
	//out.println(mCompcode);
}


if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
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
				
			}
			else if (j>0 && e.type == 'select-one' && e.name==myname) 
			{ 					
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

function ChangeOptions3(optn,work,dura,cla)
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

			rname=sec+'***R///'+val+'###'+subcount;

			mynametxt1=name+'///'+0+'###'+subcount+mtext;
			mynametxt=name+'///'+val+'###'+subcount+mtext;
			rmynametxt=sec+'***R///'+val+'###'+subcount+mtext;

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
function ChangeOptions4(optn,work,dura,cla)
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


function  Weightage(emp,assign,min,max,dura,cla)
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
		//	alert(c+'  '+mT);
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
	
		String mSubjID="";
		String mEle="";
		String SC="",qrye="",sc="";
		ResultSet rse=null;
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

qry="select subject from subjectmaster where SUBJECTID='"+mSubjID+"' ";
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
  qry="select nvl(L,0)L,nvl(T,0)T,nvl(P,0)P from programsubjecttagging where institutecode='"+mInst+"'  and SUBJECTID='"+mSubjID+"' and examcode='"+mExamcode+"' ";
  qry=qry+" and nvl(deactive,'N')='N' ";
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
  /*
	qry1=" select count(distinct studentid)cnt from STUDENTISTRATION where ";
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
/*try{
ArrayList  futlist=new ArrayList();*/
/*out.println("session :"+(String [])session.getAttribute("MultiFaculti"));
mMultiFaculty=(String [])session.getAttribute("MultiFaculti");
out.println(mMultiFaculty[0]);
if(session.getAttribute("MultiFaculti").toString().equals(""))
	{
	session.setAttribute("MultiFaculti",null);
	}*/
	
/*if(session.getAttribute("MultiFaculti")==null) 
{
	mMult="";
	//out.print("adf");
	session.setAttribute("MultiFaculti",null);
}
else
{
	//out.println(session.getAttribute("MultiFaculti"));
	futlist=(ArrayList)session.getAttribute("MultiFaculti");
//	if(request.getParameter("counter")==null)
	int i=0;
	for( i=0;i<futlist.size();i++)
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
	String subsecbran=request.getParameter("SubSection");
	String [] multiFaculty=(String [])session.getAttribute("MultiFaculti");
	for(int j=0;j<i;j++)
	{
		String aa=multiFaculty[j];
		String fid=aa.substring(0,aa.indexOf("***"));
		String ftype=aa.substring(aa.indexOf("***")+3,aa.indexOf("///"));
		String cmp=aa.substring(aa.indexOf("///")+3,aa.indexOf("@@@"));

		
		String sessionid=ltp+secbran+subsecbran;
		String hr=aa.substring(aa.indexOf("###")+3,aa.length());
		qry="INSERT INTO TEMP#PR#LOADDISTRIBUTION ( SESSIONID, USERID, SUBJECTID, SECTIONBRANCH, SUBSECTIONCODE, LTP,COMPANYCODE, FACULTYTYPE, EMPLOYEEID, NOFHRS, DATETIME)VALUES ( '"+sessionid+"','"+mChkMemID+"' ,'"+subid1+"', '"+secbran+"','"+subsecbran+"','"+ltp+"','"+cmp+"' , '"+ftype+"', '"+fid+"','"+hr+"' ,sysdate )";
		//out.println(qry);
		rs=db.getRowset(qry);
	}
}
//out.println("daf");
session.setAttribute("MultiFaculti",null);
}
catch(Exception e)
{
	out.println(e);
}


*/

%>
<form name="frm1"  method="post" action="PRLoadDistributionHODSaveAction.jsp" >
<table id=id1 width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">Assigned Load to Faculty</TD>
</font></td></tr>
</TABLE>
<table id=idd2 cellpadding=1 cellspacing=0 width="100%" align=center rules=rows  border=3>
<tr><td align=center colspan=3>
<b>HOD Load Distribution of Subject : </b><%=mSname%>&nbsp;(<%=mSubj%>)- <%=Type%> &nbsp; &nbsp;<b>LTP:</b>&nbsp;<%=mltp%>&nbsp; &nbsp;
</td></tr>
<tr>
<td colspan="3">
  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <b>Running Dept : </b><select name=Dept id=Dept>
  <%
	String qryu="select Department from departmentmaster where departmentcode='"+mDept+"' and nvl(deactive,'N')='N'";
	ResultSet rssss= db.getRowset(qryu);
	if(rssss.next())
			{
mDept2=rssss.getString("Department");
			}
	
	%>
  
  
  <option selected value='<%=mDept%>'><%=mDept2%></option>
</select
</td>	
</tr>
<tr>
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
	<table cellspacing=0 align=center border=2 rules=groups width=90%>
	<tr bgcolor="#ff8c00">
	<td align=middle><b><font color=white>Section</font><b></td>
	<td align=middle><b><font color=white>SubSection</font><b></td>
	<td align=middle><b><font color=white>&nbsp;</font><b></td>
	<td align=middle><b><font color=white>&nbsp;</font><b></td>
	<td align=middle><b><font color=white>Faculty Choice</font><b></td>
	<td align=middle><b><font color=white>Merge</font><b></td>
	<td align=middle><b><font color=white>Multiple Faculty</font><b></td>
<!-- <td align=middle><b><font color=white>&nbsp;</font><b></td> -->
	<td align=middle4><b><font color=white>Total-Student</font><b></td>
	</tr>
<%
//    if(request.getParameter("x")!=null)
//	{

	int mFlag=0;
	if(mType.equals("C"))
	{
		qry="SELECT DISTINCT b.subsectioncode subsectioncode, a.academicyear, a.programcode, a.taggingfor,a.sectionbranch sectionbranch, a.semester, a.semestertype,(SELECT COUNT (*) FROM programsubsectiontagging c WHERE c.institutecode = '"+mInst+"' AND c.examcode = '"+mExamcode+"' AND c.semestertype =DECODE ('"+mSem+"','ALL', c.semestertype,'"+mSem+"') AND NVL (c.deactive, 'N') = 'N'  AND c.academicyear = a.academicyear AND c.programcode = a.programcode  AND c.sectionbranch = a.sectionbranch AND c.semester = a.semester  and c.subsectioncode is not null AND c.subsectiontype = 'C') cnt FROM programsubsectiontagging a, pr#studentsubjectchoice b, programsubjecttagging c  WHERE b.subsectioncode is not null and a.institutecode = '"+mInst+"' AND a.institutecode = c.institutecode  AND a.examcode = c.examcode AND a.examcode = b.examcode AND b.subjecttype = 'C' AND a.examcode = '"+mExamcode+"' AND a.semestertype = DECODE ('"+mSem+"', 'ALL', a.semestertype, '"+mSem+"') AND NVL (a.deactive, 'N') = 'N' AND a.academicyear = b.academicyear AND a.programcode = b.programcode AND a.sectionbranch = b.sectionbranch  AND a.academicyear = c.academicyear AND a.programcode = c.programcode  AND b.sectionbranch = c.sectionbranch AND b.taggingfor = c.taggingfor AND a.semester = b.semester AND a.semester = c.semester AND b.subjectid = '"+mSubjID+"' AND a.subsectiontype = 'C' AND a.semestertype = b.semestertype AND NVL (b.subjectrunning, 'N') = 'Y'  AND b.subjectid IN (SELECT d.subjectid FROM pr#departmentsubjecttagging d WHERE d.departmentcode = '"+mDept+"' AND d.sectionbranch = a.sectionbranch AND d.sectionbranch = b.sectionbranch) UNION SELECT DISTINCT a.subsectioncode subsectioncode, a.academicyear, a.programcode, a.taggingfor,a.sectionbranch sectionbranch, a.semester, a.semestertype,(SELECT COUNT (*) FROM programsubsectiontagging c WHERE c.institutecode = '"+mInst+"' AND c.examcode = '"+mExamcode+"' AND c.semestertype =DECODE ('"+mSem+"','ALL', c.semestertype,'"+mSem+"') AND NVL (c.deactive, 'N') = 'N'  AND c.academicyear = a.academicyear AND c.programcode = a.programcode  AND c.sectionbranch = a.sectionbranch AND c.semester = a.semester And c.InstituteCode=b.InstituteCode And c.academicyear=b.academicyear and c.subsectioncode is not null AND c.subsectiontype = 'C') cnt  FROM programsubsectiontagging a,AcademicYearmaster b,programsubjecttagging c WHERE a.institutecode = '"+mInst+"'  AND a.institutecode = c.institutecode  AND a.examcode = c.examcode  AND c.Basket = 'A' AND a.examcode = '"+mExamcode+"'  AND a.semestertype = DECODE ('"+mSem+"', 'ALL', a.semestertype, '"+mSem+"') AND NVL (a.deactive, 'N') = 'N' AND a.academicyear = b.academicyear AND a.academicyear = c.academicyear AND a.programcode = c.programcode AND a.semester = c.semester AND a.subsectiontype = 'C'  AND NVL(b.CURRENTYEAR, 'N') = 'Y' and a.subsectioncode is not null  AND c.subjectid = '"+mSubjID+"'  AND c.subjectid IN ( SELECT d.subjectid  FROM pr#departmentsubjecttagging d WHERE d.departmentcode = '"+mDept+"' AND d.sectionbranch = a.sectionbranch AND d.sectionbranch = a.sectionbranch) order by sectionbranch,academicyear";
	//
	//out.print(qry);

	}
	else if(mType.equals("E"))
	{
	
	qry="SELECT DISTINCT subsectioncode subsectioncode,  a.academicyear, a.programcode, a.taggingfor, a.sectionbranch sectionbranch, a.semester, a.semestertype, (SELECT COUNT (*)   FROM programsubsectiontagging c   WHERE c.institutecode = '"+mInst+"' AND c.examcode = '"+mExamcode+"' AND c.semestertype = a.semestertype AND c.semestertype = DECODE ('"+mSem+"', 'ALL', c.semestertype, '"+mSem+"') AND NVL (c.deactive, 'N') = 'N' AND c.academicyear = a.academicyear  AND c.programcode = a.programcode AND c.sectionbranch = a.sectionbranch AND c.semester = a.semester AND c.subsectiontype = 'C') cnt FROM programsubsectiontagging a, pr#electivesubjects b WHERE b.subjectrunning = 'Y' AND EXISTS (SELECT 1 FROM pr#studentsubjectchoice c WHERE c.institutecode = '"+mInst+"' AND c.examcode = '"+mExamcode+"' AND c.semestertype = DECODE ('"+mSem+"', 'ALL', c.semestertype, '"+mSem+"' ) AND NVL (c.deactive, 'N') = 'N' AND c.academicyear = a.academicyear AND c.programcode = a.programcode AND c.sectionbranch = a.sectionbranch AND c.semester = a.semester  AND a.sectionbranch = b.sectionbranch AND NVL (c.subjectrunning, 'N') = 'Y' AND c.subjectid = b.subjectid AND c.subjecttype = 'E') AND a.institutecode = '"+mInst+"' AND b.electivecode = '"+mElective+"' AND a.examcode = '"+mExamcode+"' AND a.semestertype = DECODE ('"+mSem+"', 'ALL', a.semestertype, '"+mSem+"') AND NVL (a.deactive, 'N') = 'N' AND a.academicyear = b.academicyear AND a.programcode = b.programcode  AND a.examcode = b.examcode  AND a.sectionbranch = b.sectionbranch AND a.semester = b.semester AND b.subjectid = '"+mSubjID+"' AND a.subsectiontype = 'C' AND b.subjectid IN (SELECT d.subjectid FROM pr#departmentsubjecttagging d WHERE d.departmentcode = '"+mDept+"' AND d.sectionbranch = a.sectionbranch AND d.sectionbranch = b.sectionbranch) ORDER BY a.sectionbranch,subsectioncode,a.academicyear,a.programcode,a.taggingfor, a.semester,a.semestertype";
	//out.print(qry);
	}
	
	rs1=db.getRowset(qry);
	ctr=0;
	String mChkFac[]=new String[100];	
	String mChkFacS1[]=new String[100];	
	String mChkFacS11[]=new String[100];
	while(rs1.next())
	{
		mChkFacS1[x]=rs1.getString("SECTIONBRANCH");	
		mChkFac[x]=rs1.getString("subsectioncode");	
		mChkFacS11[x]=rs1.getString("PROGRAMCODE");	
		x++;
		
		mFlag=1;
		mSeccount=rs1.getString("cnt");
		mSubsection=rs1.getString("subsectioncode");
		msno++;
		mName4="OLDNEW"+String.valueOf(msno).trim();
		if(!mSection.equals(rs1.getString("SECTIONBRANCH")) || !procode.equals(rs1.getString("academicyear")))
		{
		ctr=0;
		mSection=rs1.getString("SECTIONBRANCH");	
		procode=rs1.getString("academicyear");
//out.println(procode);

if(mType.equals("C"))
{

	//and PROGRAMCODE='"+rs1.getString("PROGRAMCODE")+"'
	
	if(rs1.getString("semestertype").equals("REG"))
	{
	String qrycuracd="select 1 from ACADEMICYEARmaster a where A.institutecode = '"+mInst+"' and a.ACADEMICYEAR='"+rs1.getString("academicyear")+"'  and nvl(deactive,'N')='N' and nvl(closed,'N')='N' And nvl(CURRENTYEAR,'N')='Y'" ;
	ResultSet rscuracd=db.getRowset(qrycuracd);
	//out.println(qrycuracd);
	if(rscuracd.next())
	{
	
	qry1="select nvl(sum (maxstudent),0) cnt from ( SELECT DISTINCT a.subsectioncode subsectioncode,a.academicyear, a.programcode ,maxstudent FROM programsubsectiontagging a, academicyearmaster b,programsubjecttagging c WHERE a.institutecode = '"+mInst+"' AND a.institutecode = c.institutecode AND a.examcode = c.examcode AND c.basket = 'A' AND a.examcode = '"+mExamcode+"' AND a.semestertype = DECODE ('"+mSem+"', 'ALL', a.semestertype, '"+mSem+"') AND NVL (a.deactive, 'N') = 'N' AND a.academicyear = b.academicyear AND a.academicyear = c.academicyear AND a.programcode = c.programcode AND a.semester = c.semester AND a.subsectiontype = 'C' and a.subsectioncode is not null AND NVL (b.currentyear, 'N') = 'Y' AND a.academicyear = '"+rs1.getString("academicyear")+"' and a.sectionbranch = '"+rs1.getString("SECTIONBRANCH")+"' AND a.taggingfor = '"+rs1.getString("TAGGINGFOR")+"' AND subjectid='"+mSubjID+"' and  a.semester = '"+rs1.getString("SEMESTER")+"' AND c.subjectid IN (SELECT d.subjectid FROM pr#departmentsubjecttagging d WHERE d.departmentcode = '"+mDept+"' AND d.sectionbranch = a.sectionbranch AND d.sectionbranch = a.sectionbranch))";
	//out.println(qry1);
	}
	else
	{
	     qry1="SELECT nvl(COUNT (DISTINCT studentid),0) cnt FROM PR#StudentSubjectChoice A  WHERE A.institutecode = '"+mInst+"'   AND a.sectionbranch = '"+rs1.getString("SECTIONBRANCH")+"'   And a.EXAMCODE='"+mExamcode+"'   And a.ACADEMICYEAR='"+rs1.getString("academicyear")+"'     And a.TAGGINGFOR='"+rs1.getString("TAGGINGFOR")+"'   And a.SECTIONBRANCH='"+rs1.getString("SECTIONBRANCH")+"'   And a.SEMESTER='"+rs1.getString("SEMESTER")+"'   AND a.subjectid = '"+mSubjID+"'  And a.SubjectType='C' AND a.semestertype = DECODE ('"+mSem+"', 'ALL', semestertype, '"+mSem+"') And a.subsectioncode is not null";
	}
	rsc=db.getRowset(qry1);
	while(rsc.next())
	{
				mStudcnt=rsc.getString("cnt");	
	}
	}
}
else if(mType.equals("E"))
{
  
qrye="select distinct subjectid from PR#ELECTIVESUBJECTS where institutecode='"+mInst+"'  and ";
qrye=qrye+" examcode='"+mExamcode+"' and PROGRAMCODE='"+rs1.getString("PROGRAMCODE")+"' and SECTIONBRANCH='"+mSection+"' and electivecode='"+mEle+"' and  (nvl(L,0)>0 or nvl(T,0)>0 or nvl(P,0)>0 ) AND ";
qrye=qrye+" nvl(subjectrunning,'N')='Y' and nvl(DEACTIVE,'N')='N' ";
rse=db.getRowset(qrye);
	//out.print(qrye);
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


qry1="SELECT nvl(COUNT (DISTINCT studentid),0) cnt FROM PR#StudentSubjectChoice A  WHERE A.institutecode = '"+mInst+"'   AND a.sectionbranch = '"+rs1.getString("SECTIONBRANCH")+"'   And a.EXAMCODE='"+mExamcode+"'   And a.ACADEMICYEAR='"+rs1.getString("academicyear")+"'     And a.TAGGINGFOR='"+rs1.getString("TAGGINGFOR")+"'   And a.SECTIONBRANCH='"+rs1.getString("SECTIONBRANCH")+"'   And a.SEMESTER='"+rs1.getString("SEMESTER")+"'   AND a.subjectid = '"+mSubjID+"'  And a.SubjectType='E' AND a.semestertype = DECODE ('"+mSem+"', 'ALL', semestertype, '"+mSem+"') And a.subsectioncode is not null AND NVL (a.subjectrunning, 'N') = 'Y'";
rsc=db.getRowset(qry1);
//out.println(qry1);
if(rsc.next())
{
		  mStudcnt=rsc.getString("cnt");	
		 //12/13/2008 out.println(mStudcnt);
}
else
	{
	mStudcnt="0";
	}


}	
	
	%>
		<tr bgcolor=lightgrey>
		<td align="center"><%=mSection%></td>
		<td>&nbsp;</td>
		<td>
	<%
		qry="select A.FACULTYID FACULTYID,nvl(MERGEWITHFSTID,' ')MERGEWITHFSTID from PR#HODLOADDISTRIBUTION A  where A.institutecode='"+mInst+"' ";
		qry=qry+" and A.examcode='"+mExamcode+"' and A.SUBJECTID='"+mSubjID+"' and A.LTP='"+mLTP+"' ";
		qry=qry+" and A.SECTIONBRANCH='"+mSection+"' and programcode='"+rs1.getString("PROGRAMCODE")+"' and A.subsectioncode='"+mSubsection+"' and nvl(A.deactive,'N')='N' ";		
		qry=qry+" and A.semestertype='"+rs1.getString("SEMESTERTYPE")+"' and a.ACADEMICYEAR='"+rs1.getString("academicyear")+"' ";
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
			qrym="select A.subsectioncode from PR#HODLOADDISTRIBUTION A where A.institutecode='"+mInst+"' ";
			qrym=qrym+" and fstid='"+moldMerge1+"' and A.examcode='"+mExamcode+"' and A.SUBJECTID='"+mSubjID+"' and A.LTP='"+mLTP+"' ";
			qrym=qrym+" and nvl(A.deactive,'N')='N' ";
			rsm=db.getRowset(qrym);
	
			if(rsm.next())
			{
				moldMerge=rsm.getString("subsectioncode");
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
		qry=qry+" A.FACULTYTYPE facultytype,WebKiosk.getAssignedTeachLoad(B.COMPANYCODE,'"+mInst+"',A.facultyid,A.FACULTYTYPE,'"+mExamcode+"')assignedload, ";
		qry=qry+" WebKiosk.getAssignedTeachLoad(B.COMPANYCODE,'"+mInst+"',A.facultyid,A.FACULTYTYPE,'"+mExamcode+"','"+mSubjID+"','"+mBasket+"','"+mLTP+"')assignedload11 , ";
		qry=qry+" WebKiosk.getMinTeachLoad(B.COMPANYCODE,'"+mInst+"',A.facultyid,A.FACULTYTYPE,'"+mExamcode+"')minload,WebKiosk.getMaxTeachLoad(B.COMPANYCODE,'"+mInst+"',A.facultyid,A.FACULTYTYPE,'"+mExamcode+"')maxload  from PR#FACULTYSUBJECTCHOICES A,V#STAFF B where A.institutecode='"+mInst+"' ";
		qry=qry+" and A.examcode='"+mExamcode+"' and A.SUBJECTID='"+mSubjID+"' and A.LTP='"+mLTP+"' ";
		qry=qry+" and subjecttype='"+mType+"' and A.facultyid=B.employeeid and nvl(A.deactive,'N')='N' and nvl(b.deactive,'N')='N' ";		
		//out.println(qry);
		rs=db.getRowset(qry);

		mName1=mSection+"***L///"+String.valueOf(ctr).trim()+"###"+mSeccount;  
		mName2=mSection+"***L///"+String.valueOf(ctr).trim()+"###"+mSeccount+"txt"; 
		mNameLML=mSection+"***L///"+String.valueOf(ctr).trim()+"###"+mSeccount+"merge";  
 
		%>
		<select name="<%=mName1%>" id=<%=mName1%> tabindex="0" style="WIDTH: 0px"  onChange="ChangeOptions1('<%=mName1%>','<%=mName2%>',<%=mlt1%>,<%=mlt%>);">
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

			mFacv=mFac+"***"+mAssigned+"///"+mMin+"###"+mMax+"*****"+mTyp+"/////"+mcmp+"$$$$"+mexcludeassign;

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

		} //CLOSING OF WHILE
	}

	%>
	</select>
	</td>
	<td>
	&nbsp;
	</td>
	<td align="center">
	<%

	qry="select A.Employeeid facultyid,A.Employeename employeename,A.COMPANYCODE companycode,";
	qry=qry+" A.EMPLOYEETYPE facultytype,WebKiosk.getAssignedTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+mExamcode+"')assignedload, ";
	qry=qry+" WebKiosk.getAssignedTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+mExamcode+"','"+mSubjID+"','"+mBasket+"','"+mLTP+"')assignedload11 , ";
	qry=qry+" WebKiosk.getMinTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+mExamcode+"') minload,WebKiosk.getMaxTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE ,'"+mExamcode+"')maxload  from V#STAFF A where A.departmentcode='"+mDept+"' and a.COMPANYCODE='"+mCompcode+"' and nvl(A.deactive,'N')='N'";
//	out.println(qry);
	rs=db.getRowset(qry);
	mName1=mSection+"***R///"+String.valueOf(ctr).trim()+"###"+mSeccount;  
	mName2=mSection+"***R///"+String.valueOf(ctr).trim()+"###"+mSeccount+"txt";  
	mNameLMR=mSection+"***R///"+String.valueOf(ctr).trim()+"###"+mSeccount+"merge";    
	%>
	<select  name="<%=mName1%>" id=<%=mName1%> tabindex="0" style="WIDTH: 200px"  onChange="ChangeOptions2('<%=mName1%>','<%=mName2%>',<%=mlt1%>,<%=mlt%>);">
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

		while(rs.next())
		{
			mEmpid=rs.getString("facultyid");
			mEmpTyp=rs.getString("facultytype");
			mEcmp=rs.getString("companycode");
			mAssignedload=rs.getDouble("assignedload");
			mMaxload=rs.getDouble("maxload");
			mMinload=rs.getDouble("minload");
			mexcludeassign=rs.getDouble("assignedload11");

			mEmpidv=mEmpid+"***"+mAssignedload+"///"+mMinload+"###"+mMaxload+"*****"+mEmpTyp+"/////"+mEcmp+"$$$$"+mexcludeassign;			
			
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
	<td>
	&nbsp;
	</td>
	<td>
	&nbsp;
	</td>
	<td align=middle><%=mStudcnt%></td>
	</tr>
	<%
	}
//	else   // 111
//	{	
		ctr++;
	// mSection=rs1.getString("SECTIONBRANCH");	
	mProgramcode=rs1.getString("PROGRAMCODE");
	//if(!mLTP.equals("L"))
	{
	%>
	<tr>
	<td>&nbsp;</td>
	<td align="center"><%=mSubsection%>&nbsp;(<%=mProgramcode%>)(<%=rs1.getString("academicyear")%>)</td> 
	<td>
	<%
	}	
		
		qry="select A.FACULTYID FACULTYID,nvl(MERGEWITHFSTID,' ')MERGEWITHFSTID from PR#HODLOADDISTRIBUTION A  where A.institutecode='"+mInst+"' ";
		qry=qry+" and A.examcode='"+mExamcode+"' and A.SUBJECTID='"+mSubjID+"' and A.LTP='"+mLTP+"' ";
		qry=qry+" and A.SECTIONBRANCH='"+mSection+"' and programcode='"+mProgramcode+"' and A.subsectioncode='"+mSubsection+"' and nvl(A.deactive,'N')='N' ";		
		qry=qry+" and A.semestertype='"+rs1.getString("SEMESTERTYPE")+"' and a.ACADEMICYEAR='"+rs1.getString("academicyear")+"' ";
		//out.println(qry);
		rs5=db.getRowset(qry);

		if(rs5.next())
		{
			moldemp=rs5.getString("FACULTYID");
			moldMerge1=rs5.getString("MERGEWITHFSTID");
		}
		else
		{
			moldemp="";
			moldMerge1="";
		}

		if(!moldMerge1.equals(" "))
		{
				
			qrym="select A.subsectioncode,A.programcode from PR#HODLOADDISTRIBUTION A where A.institutecode='"+mInst+"' ";
			qrym=qrym+" and fstid='"+moldMerge1+"' and A.examcode='"+mExamcode+"' and A.SUBJECTID='"+mSubjID+"' and A.LTP='"+mLTP+"' ";
			qrym=qrym+" and nvl(A.deactive,'N')='N' ";
			rsm=db.getRowset(qrym);
	
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
			mprogc="";
		}
	
		qry="select A.facultyid facultyid,B.Employeename employeename,B.COMPANYCODE companycode,";
		qry=qry+" A.FACULTYTYPE facultytype,WebKiosk.getAssignedTeachLoad(B.COMPANYCODE,'"+mInst+"',A.facultyid,A.FACULTYTYPE,'"+mExamcode+"')assignedload, ";
		qry=qry+" WebKiosk.getAssignedTeachLoad(B.COMPANYCODE,'"+mInst+"',A.facultyid ,A.FACULTYTYPE,'"+mExamcode+"','"+mSubjID+"','"+mBasket+"','"+mLTP+"')assignedload11 , ";
		qry=qry+" WebKiosk.getMinTeachLoad(B.COMPANYCODE,'"+mInst+"',A.facultyid ,A.FACULTYTYPE,'"+mExamcode+"')minload,WebKiosk.getMaxTeachLoad(B.COMPANYCODE,'"+mInst+"',A.facultyid,A.FACULTYTYPE,'"+mExamcode+"')maxload  from PR#FACULTYSUBJECTCHOICES A,V#STAFF B where A.institutecode='"+mInst+"' ";
		qry=qry+" and A.examcode='"+mExamcode+"' and A.SUBJECTID='"+mSubjID+"' and A.LTP='"+mLTP+"' ";
		qry=qry+" and subjecttype='"+mType+"' and A.facultyid=B.employeeid and nvl(A.deactive,'N')='N' and nvl(b.deactive,'N')='N'";		
		rs=db.getRowset(qry);
//		out.println(qry);
//out.println(ctr);
//ctr=6;
//mSeccount="6";
		mName1=mSection+"***L///"+String.valueOf(ctr).trim()+"###"+mSeccount ; 
		mName2=mSection+"***L///"+String.valueOf(ctr).trim()+"###"+mSeccount+"txt" ;  
		mNameLML=mSection+"***L///"+String.valueOf(ctr).trim()+"###"+mSeccount+"merge"; 
 //out.println( mName1+" <br> "+mName2+"<br>"+mNameLMR);
  %>
	     <select <%=mDis%> name="<%=mName1%>" id=<%=mName1%> tabindex="0" style="WIDTH: 0px" onChange="ChangeOptions3('<%=mName1%>','<%=mName2%>',<%=mlt1%>,<%=mlt%>);">
	<%
		if (request.getParameter("x")==null) 
		{	
			if(moldemp.equals(""))
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
			if(moldemp.equals(mFac))
			{
			mFlag111=1;
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
		} // closing of while
	} // closing of if
%>
	</select>
	</td>
	<td>
	<select name='<%=mNameLML%>' id='<%=mNameLML%>' tabindex="0" style="WIDTH: 0px" onChange="ChangeOptions5('<%=mName1%>','<%=mNameLML%>');"> 
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
			<option value='NONE'>Merge</option>
	<%
		}	
	for(int jp=0;jp<x;jp++)
	{

	
	mvalue=rs1.getString("SECTIONBRANCH")+"***"+rs1.getString("subsectioncode")+"///"+mChkFac[jp]+"###"+mChkFacS11[jp]+"$$$"+mChkFacS1[jp] ;
	if(moldMerge.equals(mChkFac[jp]) && mprogc.equals(mChkFacS11[jp]))
	{
	      if(mFlag111==1)
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
	} // closing of for
	%>
		</select>
	</td>
<%
	//if(!mLTP.equals("L"))
	{
	%>
	<td align="center">
	<%
	}


	qry="select A.Employeeid facultyid,A.Employeename employeename,A.COMPANYCODE companycode,";
	qry=qry+" A.EMPLOYEETYPE facultytype,WebKiosk.getAssignedTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+mExamcode+"')assignedload, ";
	qry=qry+" WebKiosk.getAssignedTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+mExamcode+"','"+mSubjID+"','"+mBasket+"','"+mLTP+"')assignedload11 , ";
	qry=qry+" WebKiosk.getMinTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE,'"+mExamcode+"') minload,WebKiosk.getMaxTeachLoad(A.COMPANYCODE,'"+mInst+"',A.Employeeid ,A.EMPLOYEETYPE ,'"+mExamcode+"')maxload  from V#STAFF A where A.departmentcode='"+mDept+"' and nvl(A.deactive,'N')='N' and A.COMPANYCODE='"+mCompcode+"'";
	rs=db.getRowset(qry);
	//out.println( qry);
	mName1=mSection+"***R///"+String.valueOf(ctr).trim()+"###"+mSeccount ;  
	mName2=mSection+"***R///"+String.valueOf(ctr).trim()+"###"+mSeccount+"txt" ;  
	mNameLMR=mSection+"***R///"+String.valueOf(ctr).trim()+"###"+mSeccount+"merge"; 
	//out.println( mName1+" <br> "+mName2+"<br>"+mNameLMR);
	%>
	<select <%=mDis%> name="<%=mName1%>" id=<%=mName1%> tabindex="0" style="WIDTH: 200px" onChange="ChangeOptions4('<%=mName1%>','<%=mName2%>',<%=mlt1%>,<%=mlt%>);">
	<%
	if (request.getParameter("x")==null) 
	{
		if(moldemp.equals(""))
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

			mEmpidv=mEmpid+"***"+mAssignedload+"///"+mMinload+"###"+mMaxload+"*****"+mEmpTyp+"/////"+mEcmp+"$$$$"+mexcludeassign ;	
			if(moldemp.equals(mEmpid))
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
		  } //closing of while	
		
  	} //closing of if
	%>
	</select>
	</td>
	<td align="center">
	<select name='<%=mNameLMR%>' id='<%=mNameLMR%>' tabindex="0" style="WIDTH: 110px" onChange="ChangeOptions6('<%=mName1%>','<%=mNameLMR%>');">
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
	//if(!mLTP.equals("L"))
	{
%>
	
	
	<td align="center"><a href="PRLoadDistributionHODActionMultiFac.jsp?ExamCode=<%=mExamcode%>&Sub=<%=mSubj%>&Basket=<%=mBasket%>&LTP=<%=mLTP%>&Dept=<%=mDept%>&Subjid=<%=mSubjID%>&Elecode=<%=mElective%>&PRCODE=<%=request.getParameter("PRCODE")%>&radio1=<%=request.getParameter("radio1")%>&ELE=<%=mEle%>&SUBNAME=<%=request.getParameter("SUBNAME")%>&TYPE=<%=mType%>&SEM=<%=mSem%>&section=<%=rs1.getString("SECTIONBRANCH")%>&mSubSection=<%=mSubsection%>&classweek=<%=mlt%>&mAcad=<%=rs1.getString("academicyear")%>&mProg=<%=rs1.getString("PROGRAMCODE")%>" target="_child">Multiple Faculty</a></td>
	
	<%
	String subseccount="";
	if(mType.equals("C"))
		{
	String query123="";
	if(rs1.getString("semestertype").equals("REG"))
	{
		
		String qrycuracd1="select 1 from ACADEMICYEARmaster a where A.institutecode = '"+mInst+"' and a.ACADEMICYEAR='"+rs1.getString("academicyear")+"'  and nvl(deactive,'N')='N' and nvl(closed,'N')='N' And nvl(CURRENTYEAR,'N')='Y'" ;
	ResultSet rscuracd1=db.getRowset(qrycuracd1);
	//out.println(qrycuracd1+"<BR><BR>");
	if(rscuracd1.next())
	{
		query123="select nvl(sum(MAXSTUDENT),0) cnt from programsubsectiontagging a  WHERE A.institutecode = '"+mInst+"'   AND a.sectionbranch = '"+rs1.getString("SECTIONBRANCH")+"'   And a.EXAMCODE='"+mExamcode+"'   And a.ACADEMICYEAR='"+rs1.getString("academicyear")+"'   And a.PROGRAMCODE='"+rs1.getString("PROGRAMCODE")+"'   And a.TAGGINGFOR='"+rs1.getString("TAGGINGFOR")+"'  And a.SEMESTER='"+rs1.getString("SEMESTER")+"'  AND a.semestertype = DECODE ('"+mSem+"', 'ALL', semestertype, '"+mSem+"')  And nvl(a.SUBSECTIONCODE,'*')='"+mSubsection+"'";

	}
	else
		{
		query123="SELECT nvl(COUNT (DISTINCT studentid),0) cnt FROM PR#StudentSubjectChoice A  WHERE A.institutecode = '"+mInst+"'   AND a.sectionbranch = '"+rs1.getString("SECTIONBRANCH")+"'   And a.EXAMCODE='"+mExamcode+"'   And a.ACADEMICYEAR='"+rs1.getString("academicyear")+"'   And a.PROGRAMCODE='"+rs1.getString("PROGRAMCODE")+"'   And a.TAGGINGFOR='"+rs1.getString("TAGGINGFOR")+"'   And a.SECTIONBRANCH='"+rs1.getString("SECTIONBRANCH")+"'   And a.SEMESTER='"+rs1.getString("SEMESTER")+"'  And nvl(a.SUBSECTIONCODE,'*')='"+mSubsection+"'  AND a.subjectid = '"+mSubjID+"'  And a.SubjectType='C' AND a.semestertype = DECODE ('"+mSem+"', 'ALL', semestertype, '"+mSem+"') And a.subsectioncode is not null";
		//out.println(query123);
	}
	}
	//out.println(query123);
	ResultSet rssec=db.getRowset(query123);
	while(rssec.next())
	{
		subseccount=rssec.getString("cnt");
	}
	//subseccount=mSeccount;
		}
		else if(mType.equals("E"))
		{
String query123="SELECT nvl(COUNT (DISTINCT studentid),0) cnt FROM PR#StudentSubjectChoice A  WHERE A.institutecode = '"+mInst+"'   AND a.sectionbranch = '"+rs1.getString("SECTIONBRANCH")+"'   And a.EXAMCODE='"+mExamcode+"'   And a.ACADEMICYEAR='"+rs1.getString("academicyear")+"'   And a.PROGRAMCODE='"+rs1.getString("PROGRAMCODE")+"'   And a.TAGGINGFOR='"+rs1.getString("TAGGINGFOR")+"'   And a.SECTIONBRANCH='"+rs1.getString("SECTIONBRANCH")+"'   And a.SEMESTER='"+rs1.getString("SEMESTER")+"'  And nvl(a.SUBSECTIONCODE,'*')='"+mSubsection+"'  AND a.subjectid = '"+mSubjID+"'  And a.SubjectType='E' AND a.semestertype = DECODE ('"+mSem+"', 'ALL', semestertype, '"+mSem+"') and nvl(a.SUBJECTRUNNING,'N')='Y' And a.subsectioncode is not null";

	//out.println(query123);
	ResultSet rssec=db.getRowset(query123);
	while(rssec.next())
	{
		subseccount=rssec.getString("cnt");
//		out.println("aaa"+subseccount);
	}



//subseccount="";
		}
		else
		{

		}
	
	%>

	<td align="center"><%=subseccount%></td>

<%



	}


////	}
	if(mFlag11==1 || mFlag111==1)
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
	mFlag111=0;
// } closing of else  111


	} // closing of outer while

	if(mFlag==1)
	{
	mFlag=0;
	%>
</tr>
	<TR>
	<TD ALIGN=CENTER colspan=9><table width=100%><tr><hr><td align=center><input type=submit name=btn id=btn value='Draft Save'></td></tr></table></TD>
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
<input type=hidden name=ELECTIVECODE ID=ELECTIVECODE value=<%=mElective%>>	
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
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}      
}
catch(Exception e)
{
	out.println(e);
}
%>
</body>
</html>