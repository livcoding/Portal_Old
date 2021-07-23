<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
try
{
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
String mHead="";
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberID="",mDMemberCode="",mDMemberType="";
String mInst="";
String qry="";
String qry1="";
String qrys="";
ResultSet rss=null;
ResultSet rs=null;
ResultSet rsd1=null;
String qryd1="";
String mCentreCode="",mStoreCode="",mSiteCode="",mLocationCode="";
String mMajorHead="",mItemHead="",mItemSubHead="",mItemCode="",mPartRef="";
String mItemType="";
String mDataItemHead="",mDataItemSubHead="",mDataItemCode="";
String mMajoor="";
String mIteem="";
String mIteemSub="";
String mItemPartRef="";
String Mprno="";
String mNewPR="",mPRNO="";
String mPartMake1="";
int mfla=0;
String mCostCentre="",mStore="",mPrrefno="",mPrrefdate="";
String mSite="",mLocation="",mRemarks="",mItemCategory="" ;
String mMajorHead1="",mItemHead1="",mItemSubHead1="",mItemCode1="";
String mPartRefMake="",mPartMake="",mItemType1="",mQtyReq="";
String mAU="",mReqDate="",mRemarks1="",mDetailDesc="";
String mDepartmentCode="",mCompanyCode="";
String mCC="",mSC="",mPR="",mPD="",mSCode="",mLC="",mRR="",qryo="";
String mPC1="";
String ComboPr="",mP="",mCC1="",mSC1="",mPR1="",mPD1="",mSCode1="",mLC1="",mRR1="",mPC11="";

ResultSet rso=null;
Connection con = null;
Statement st = null;
DBConn co = null;


if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
{
	mHead=session.getAttribute("PageHeading").toString().trim();
}
else
{
	mHead="JIIT ";
}
if (session.getAttribute("MemberID")==null)
{
	mMemberID="";
}
else
{
	mMemberID=session.getAttribute("MemberID").toString().trim();
}
if (session.getAttribute("CompanyCode")==null)
{
	mCompanyCode="";
}
else
{
	mCompanyCode=session.getAttribute("CompanyCode").toString().trim();
}
if (session.getAttribute("DepartmentCode")==null)
{
	mDepartmentCode="";
}
else
{
	mDepartmentCode=session.getAttribute("DepartmentCode").toString().trim();
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
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Pruchase Requisition ] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<!--  <script type="text/javascript" src="js/dateformat.js"></script>-->
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<script language=javascript>

function RefreshContents()
{ 	
	document.frm.x.value='ddd';
    	document.frm.submit();
}
//-->
</script>
<SCRIPT LANGUAGE="JavaScript">
function iSValidDate(pDate)
 {
//1 

if(document.frm.ReqDate.value!="" && document.frm.ReqDate.value!=" ")
{
	
    var dn, mn, yn, maxday;
    var mDate = pDate;
    dn = 0;
    mn = 0;
    yn = 0;
    maxday = 0;
    var mISValidDate = false;
   // if (isNumeric(mDate.substring(0, 2)) && isNumeric(mDate.substring(3, 5)) &&
   // isNumeric(mDate.substring(6))) { //2]
	 if (mDate.length==10) {
        //3
        if (mDate.substring(2, 3).trim()=="-" && mDate.substring(5, 6).trim()=="-") { //4
           if (parseInt(mDate.substring(0,2).trim()) >= 1 &&
              parseInt(mDate.substring(0,2).trim()) <=31 &&
              parseInt(mDate.substring(3, 5).trim()) <= 12 &&
              parseInt(mDate.substring(3, 5).trim()) >= 1 &&
              parseInt(mDate.substring(6).trim()) >= 1900 &&
              parseInt(mDate.substring(6).trim()) <= 3000) { //5
            dn = parseInt(mDate.substring(0, 2).trim());
            mn = parseInt(mDate.substring(3,5).trim());
            yn = parseInt(mDate.substring(6).trim());
            if (mn == 4 || mn == 6 || mn == 9 || mn == 11)
              maxday = 30;
            else if (mn == 1 || mn == 3 || mn == 5 || mn == 7 || mn == 8 ||
                     mn == 10 || mn == 12)
              maxday = 31;
            else if (mn == 2 && (yn % 4 == 0 || yn % 400 == 0))
              maxday = 29;
            else
              maxday = 28;

            if (mn > 0 && mn <= 12 && dn > 0 && dn <= maxday)
              mISValidDate =true;
          } //5
		  else
		  {
  			alert('Please Enter the valid date format in Required date field i.e DD-MM-YYYY.'); 
			document.frm.ReqDate.value="";
			frm.ReqDate.focus();
		  }
        } //4
		else
		  {
		alert('Please Enter the valid date format in Required date field i.e DD-MM-YYYY.'); 
			document.frm.ReqDate.value="";
			frm.ReqDate.focus();
		  }
      } //3
	  else
		  {
		   alert('Please Enter the valid date format in Required date field i.e DD-MM-YYYY.'); 
			document.frm.ReqDate.value="";
			frm.ReqDate.focus();
		  }
 //   } //2
  return (mISValidDate);
}
}


function iSValidDate1(pDate)
 {
//1 
if(document.frm.Prrefdate.value!="" && document.frm.Prrefdate.value!=" ")
{
    var dn, mn, yn, maxday;
    var mDate = pDate;
    dn = 0;
    mn = 0;
    yn = 0;
    maxday = 0;
    var mISValidDate1 = false;
   // if (isNumeric(mDate.substring(0, 2)) && isNumeric(mDate.substring(3, 5)) &&
   // isNumeric(mDate.substring(6))) { //2]

	 if (mDate.length==10) {
        //3
        if (mDate.substring(2, 3).trim()=="-" && mDate.substring(5, 6).trim()=="-") { //4
           if (parseInt(mDate.substring(0,2).trim()) >= 1 &&
              parseInt(mDate.substring(0,2).trim()) <=31 &&
              parseInt(mDate.substring(3, 5).trim()) <= 12 &&
              parseInt(mDate.substring(3, 5).trim()) >= 1 &&
              parseInt(mDate.substring(6).trim()) >= 1900 &&
              parseInt(mDate.substring(6).trim()) <= 3000) { //5
            dn = parseInt(mDate.substring(0, 2).trim());
            mn = parseInt(mDate.substring(3,5).trim());
            yn = parseInt(mDate.substring(6).trim());
            if (mn == 4 || mn == 6 || mn == 9 || mn == 11)
              maxday = 30;
            else if (mn == 1 || mn == 3 || mn == 5 || mn == 7 || mn == 8 ||
                     mn == 10 || mn == 12)
              maxday = 31;
            else if (mn == 2 && (yn % 4 == 0 || yn % 400 == 0))
              maxday = 29;
            else
              maxday = 28;

            if (mn > 0 && mn <= 12 && dn > 0 && dn <= maxday)
              mISValidDate1 =true;
          } //5
		  else
		  {
  		alert('Please Enter the valid date format in PR Ref. date field i.e DD-MM-YYYY.'); 
			document.frm.Prrefdate.value="";
			frm.Prrefdate.focus();
		  }
        } //4
		else
		  {
		alert('Please Enter the valid date format in PR Ref. date field i.e DD-MM-YYYY.'); 
			document.frm.Prrefdate.value="";
			frm.Prrefdate.focus();
		  }
      } //3
	  else
		  {
		  alert('Please Enter the valid date format in PR Ref. date field i.e DD-MM-YYYY.'); 
			document.frm.Prrefdate.value="";
			frm.Prrefdate.focus();
		  }
 //   } //2
  return (mISValidDate1);

}

}



function IsNumeric()
{

   var ValidChars = "0123456789-";
   var Char;
   var Char1;
   
if(document.frm.Prrefdate.value!="" && document.frm.Prrefdate.value!=" ")
{
for (i=0; i<document.frm.Prrefdate.value.length; i++) 
{ 
	  Char = document.frm.Prrefdate.value.charAt(i); 
      if (ValidChars.indexOf(Char) == -1) 
      {
			alert('Please Enter the valid date format in PR Ref. date field i.e DD-MM-YYYY.'); 
			document.frm.Prrefdate.value="";
			frm.Prrefdate.focus();
			return false;
        }
 } // closing of for
}	 




if(document.frm.ReqDate.value!="" && document.frm.ReqDate.value!=" ")
{
	
for (i=0; i<document.frm.ReqDate.value.length; i++) 
{ 
	  Char1 = document.frm.ReqDate.value.charAt(i); 
      if (ValidChars.indexOf(Char1) == -1) 
      {
			alert('Please Enter the valid date format in Required date field i.e DD-MM-YYYY.'); 
			document.frm.ReqDate.value="";
			frm.ReqDate.focus();
			return false;
        }
 } // closing of for
}

var ValidChars1 = "0123456789.";
var Char2;
for (i=0; i<document.frm.QtyReq.value.length; i++) 
{ 
	  Char2 = document.frm.QtyReq.value.charAt(i); 
      if (ValidChars1.indexOf(Char2) == -1) 
      {
			alert('Please Enter the numeric value only in Qty Required field.'); 
			document.frm.QtyReq.value="";
			frm.QtyReq.focus();
			return false;
        }
 } // closing of for

if(document.frm.QtyReq.value=="")
{
	alert('Please insert the quantity required value.');
	frm.QtyReq.focus();
	return false;	
}

if(document.frm.AU.value=="")
{
	alert('You can not left UOM field blank.');
	frm.AU.focus();
	return false;	
}
if(document.frm.ReqDate.value!="" && document.frm.ReqDate.value!=" ")
{
var dt=document.frm.ReqDate.value;
var dt2=document.frm.SDate.value;

	len=dt.length;
	i=dt.indexOf("-");
	dtDD=dt.substring(0,i);
	dt=dt.substring(i+1,len);
	len=dt.length;
	i=dt.indexOf("-");
	dtMM=dt.substring(0,i);
	dtYY=dt.substring(i+1,len);

	len=dt2.length;
	i=dt2.indexOf("-");
	dt2DD=dt2.substring(0,i);
	dt2=dt2.substring(i+1,len);
	len=dt2.length;
	i=dt2.indexOf("-");
	dt2MM=dt2.substring(0,i);
	dt2YY=dt2.substring(i+1,len);
	
	var date1=new Date(dtYY,dtMM-1,dtDD);
	var date2=new Date(dt2YY,dt2MM-1,dt2DD);
	
	if(dt=="" || dt2=="")
	{
		alert("Please Enter valid Date");
		return false;

	}
	else if(date2>date1)
	{

		alert(" Required Date should be greater than today date");
		return false;
	}
	else
	{
		return true;
	}
}
}

</script>
<script language="JavaScript" TYPE="text/javascript">
function Disab()
{
	
	if(document.frm.NewPR.checked==true)
	{
		document.frm.PRNO.disabled=true;
		document.frm.CostCentre.disabled=false;
		document.frm.Store.disabled=false;
		document.frm.Prrefno.disabled=false;
		document.frm.Prrefno.value="";
		document.frm.Prrefdate.disabled=false;
		document.frm.Prrefdate.value="";
		document.frm.Site.disabled=false;
		document.frm.Location.disabled=false;
		document.frm.ItemType.disabled=false;
		document.frm.Remarks.disabled=false;
		document.frm.Remarks.value="";
	}
	else
	{
		document.frm.PRNO.disabled=false;
		document.frm.CostCentre.disabled=true;
		document.frm.Store.disabled=true;
		document.frm.Prrefno.disabled=true;
		document.frm.Prrefdate.disabled=true;
		document.frm.Site.disabled=true;
		document.frm.Location.disabled=true;
		document.frm.ItemType.disabled=true;
		document.frm.Remarks.disabled=true;
	}	

}
</script>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">
function ChangeOptions(MajorHead,DataItemHead,ItemHead,DataItemSubHead,ItemSubHead,DataItemCode,ItemCode)
{
      removeAllOptions(ItemHead);
	var mitemhead='?';
	var mflag=0;
	var ssec='?';

	var optn0 = document.createElement("OPTION");
	optn0.text='<--Select your Major Head-->';
	optn0.value='NONE';
	ItemHead.options.add(optn0);

	for(i=0;i<DataItemHead.options.length;i++)
       {	
		var v1;
		var pos;
		var majorh;
		var itemhead;
		var len;
		var otext;
		var v1=DataItemHead.options(i).value;
		len= v1.length ;	
		pos=v1.indexOf('***');
		majorh=v1.substring(0,pos);
		itemhead=v1.substring(pos+3,len);
		if (MajorHead==majorh)
		 { 	if(mflag==0) 
			{
			mitemhead=itemhead;
			mflag=1;
			}
			var optn = document.createElement("OPTION");
			optn.text=DataItemHead.options(i).text;
			optn.value=itemhead;
			ItemHead.options.add(optn);
		}
	}
	removeAllOptions(ItemSubHead);
      mflag=0;

	var optns = document.createElement("OPTION");
	optns.text='<--Select your Sub Head-->';
	optns.value='NONE';
	ItemSubHead.options.add(optns);

	for(i=0;i<DataItemSubHead.options.length;i++)
      {	
		var v1s;
		var pos1;
		var pos2;
		var majorhs;
		var itemheads;
		var lens;
		var itemsubheads;
		var otexts;
		var v1s=DataItemSubHead.options(i).value;
		lens= v1s.length ;	
		pos1=v1s.indexOf('***');
		pos2=v1s.indexOf('///')
		majorhs=v1s.substring(0,pos1);
		itemheads=v1s.substring(pos1+3,pos2);
		itemsubheads=v1s.substring(pos2+3,lens);
		if (MajorHead==majorhs && mitemhead==itemheads)
		 { 				
			var optns = document.createElement("OPTION");
			optns.text=DataItemSubHead.options(i).text;
			optns.value=itemsubheads;
			ItemSubHead.options.add(optns);
		}
	}	
	removeAllOptions(ItemCode);
	var optns1 = document.createElement("OPTION");
	optns1.text='<--Select your Item Code-->';
	optns1.value='NONE';
	ItemCode.options.add(optns1);

	for(i=0;i<DataItemCode.options.length;i++)
       {	
		var v1s1;
		var pos1;
		var pos2;
		var pos3;
		var majorhs1;
		var itemheads1;
		var lens1;
		var itemsubheads1;
		var otexts1;
		var itemcode;
		var v1s1=DataItemCode.options(i).value;
		lens1= v1s1.length ;	
		pos11=v1s1.indexOf('***');
		pos21=v1s1.indexOf('///');
		pos3=v1s1.indexOf('%%%');
		majorhs1=v1s1.substring(0,pos11);
		itemheads1=v1s1.substring(pos11+3,pos21);
		itemsubheads1=v1s1.substring(pos21+3,pos3);
		itemcode=v1s1.substring(pos3+3,lens1);

		if (MajorHead==majorhs && mitemhead==itemheads)
		 { 			
			var optns1 = document.createElement("OPTION");
			optns1.text=DataItemCode.options(i).text;
			optns1.value=itemcode;
			ItemCode.options.add(optns1);
		}
	}		
}

//********Click event on ItemHead**********

function ChangeOptions1(MajorHead,ItemHead,DataItemSubHead,ItemSubHead,DataItemCode,ItemCode)
  {
  	var mflag=0;
	var ssec='?';
	
	removeAllOptions(ItemSubHead);
	 mflag=0;
	var optns1 = document.createElement("OPTION");
	optns1.text='<--Select your Sub Head-->';
	optns1.value='NONE';
	ItemSubHead.options.add(optns1);

	for(i=0;i<DataItemSubHead.options.length;i++)
       {	
		var v1s;
		var pos1;
		var pos2;
		var majorhead;
		var itemhead;
		var lens;
		var itemsubhead;
		var otexts;
		var v1s=DataItemSubHead.options(i).value;
		lens= v1s.length ;	
		pos1=v1s.indexOf('***');
		pos2=v1s.indexOf('///')
		majorhead=v1s.substring(0,pos1);
		itemhead=v1s.substring(pos1+3,pos2);
		itemsubhead=v1s.substring(pos2+3,lens);
		if (majorhead==MajorHead && itemhead==ItemHead)
		 { 				
			var optns = document.createElement("OPTION");
			optns.text=DataItemSubHead.options(i).text;
			optns.value=itemsubhead;
			ItemSubHead.options.add(optns);
		}
	}	
		
	removeAllOptions(ItemCode);
	var optns1 = document.createElement("OPTION");
	optns1.text='<--Select your Item Code-->';
	optns1.value='NONE';
	ItemCode.options.add(optns1);

	for(i=0;i<DataItemCode.options.length;i++)
       {	
		var v1s1;
		var pos1;
		var pos2;
		var pos3;
		var major;
		var itemhead;
		var lens1;
		var itemsub;
		var otexts1;
		var itemcode;
		var v1s1=DataItemCode.options(i).value;

		lens1= v1s1.length ;	
		pos11=v1s1.indexOf('***');
		pos21=v1s1.indexOf('///');
		pos3=v1s1.indexOf('%%%');
		major=v1s1.substring(0,pos11);
		itemhead=v1s1.substring(pos11+3,pos21);
		itemsub=v1s1.substring(pos21+3,pos3);
		itemcode=v1s1.substring(pos3+3,lens1);
		if (majorhead==MajorHead && itemhead==ItemHead)// && ssec=='ALL')
		 { 			
			var optns1 = document.createElement("OPTION");
			optns1.text=DataItemCode.options(i).text;
			optns1.value=itemcode;
			ItemCode.options.add(optns1);
		}
	}		
}

//************click event on subhead***********
function ChangeOptions2(MajorHead,ItemHead,ItemSubHead,DataItemCode,ItemCode)
  {
   		
	removeAllOptions(ItemCode);

	var optns1 = document.createElement("OPTION");
	optns1.text='<--Select your Item Code-->';
	optns1.value='NONE';
	ItemCode.options.add(optns1);

	for(i=0;i<DataItemCode.options.length;i++)
       {	
		var v1s1;
		var pos1;
		var pos2;
		var pos3;
		var majoor;
		var iteemhead;
		var lens1;
		var itemsubhead;
		var otexts1;
		var itemcode;
		var v1s1=DataItemCode.options(i).value;

		lens1= v1s1.length ;	
		pos11=v1s1.indexOf('***');
		pos21=v1s1.indexOf('///');
		pos3=v1s1.indexOf('%%%');
		majoor=v1s1.substring(0,pos11);
		iteemhead=v1s1.substring(pos11+3,pos21);
		itemsubhead=v1s1.substring(pos21+3,pos3);
		itemcode=v1s1.substring(pos3+3,lens1);
		if(majoor==MajorHead && ItemHead==iteemhead && ItemSubHead==itemsubhead)
		{
			var optns1 = document.createElement("OPTION");
			optns1.text=DataItemCode.options(i).text;
			optns1.value=itemcode;
			ItemCode.options.add(optns1);
		}
	}		
}

function ChangeOptions3(MajorHead,ItemHead,ItemSubHead,ItemCode,DataItemPart,PartRefMake,AU)
{ 
	for(i=0;i<DataItemPart.options.length;i++)
       {   
		var v1s;
		var pos1;
		var pos2;
		var clas;
		var lens;
		var pos3;
		var pos4;
		var pos5;
		var major;
		var item;
		var itemsub;
		var itemcode;
		var partref;
		var unit;

		var v1s=DataItemPart.options(i).value;
		lens= v1s.length ;	
		pos1=v1s.indexOf('***');
		pos2=v1s.indexOf('///');
		pos3=v1s.indexOf('%%%');
		pos4=v1s.indexOf('###');
		pos5=v1s.indexOf('@@@');
//alert(v1s);
		major=v1s.substring(0,pos1);
		item=v1s.substring(pos1+3,pos2);
		itemsub=v1s.substring(pos2+3,pos3);
		itemcode=v1s.substring(pos3+3,pos4);
		partref=v1s.substring(pos4+3,pos5);
		unit=v1s.substring(pos5+3,lens);
	   if(major==MajorHead && item==ItemHead && itemsub==ItemSubHead && itemcode==ItemCode)
 	   {
	//alert(partref);
		if(partref==-1)
			PartRefMake.value="";
		else
			PartRefMake.value=partref;
		if(unit==-1)
			AU.value="";
		else
			AU.value=unit;
		   }
		}
}

function ComboPR(PR)
{ 
	
	for(i=0;i<document.frm.DataPRNO.options.length;i++)
       {  
		
		var v1s;
		var clas;
		var len;
		var pos1;
		var pos2;
		var pos3;
		var pos4;
		var pos5,pos7,pos8;
		

		var v1s=document.frm.DataPRNO.options(i).value;
		
		len= v1s.length ;	
		pos1=v1s.indexOf('///');
		pos2=v1s.indexOf('***');
		pos3=v1s.indexOf('@@@');
		pos4=v1s.indexOf('###');
		pos5=v1s.indexOf('%%%');
		pos6=v1s.indexOf('!!!');
		pos7=v1s.indexOf('$$$');	
		pos8=v1s.indexOf('~~~');

		var cc=v1s.substring(0,pos1);
		var sc=v1s.substring(pos1+3,pos2);
		var pr=v1s.substring(pos2+3,pos3);
		var pd=v1s.substring(pos3+3,pos4);
		var stc=v1s.substring(pos4+3,pos5);
		var lc=v1s.substring(pos5+3,pos6);
		var pc=v1s.substring(pos6+3,pos7);
		var rm=v1s.substring(pos7+3,pos8);
		var prn=v1s.substring(pos8+3,len);	

//alert(prn+'=='+PR);
	   if(prn==PR)
 	   {
		document.frm.CostCentre.value=cc;
		document.frm.Store.value=sc;
		if(pr=="**")
			document.frm.Prrefno.value="";
		else
		document.frm.Prrefno.value=pr;
		if(pd=="**")
		document.frm.Prrefdate.value="";
		else
		document.frm.Prrefdate.value=pd;
		document.frm.Site.value=stc;
		document.frm.Location.value=lc;
		document.frm.ItemType.value=pc;
		if(rm=="**")
		document.frm.Remarks.value="";
		else
		document.frm.Remarks.value=rm;
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

</script>


<script>
	if(window.history.forward(1)!=null)
	window.history.forward(1);	
</script>
</head>
<body aLink=#ff00ff bgcolor='#fce9c5' rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 onSubmit="return ValidateForm();" onload="Disab();">
<%
if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{
	OLTEncryption enc=new OLTEncryption();
	 mDMemberID=enc.decode(mMemberID);
	 mDMemberCode=enc.decode(mMemberCode);
	 mDMemberType=enc.decode(mMemberType);

		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk=null;

	  //-----------------------------
	  //-- Enable Security Page Level  
	  //-----------------------------
		qry="Select WEBKIOSK.ShowLink('156','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{
			qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from InstituteMaster Where nvl(Deactive,'N')='N' ";
			rs=db.getRowset(qry);
			if (rs.next())
				mInst=rs.getString(1);
			else
				mInst="JIIT";	

			String qryd="",mDate="";
			ResultSet rsd=null;

			qryd="select to_char(sysdate,'dd-mm-yyyy') from dual ";
			rsd=db.getRowset(qryd);
			rsd.next();
			mDate=rsd.getString(1);


		String mFl="";

	if(request.getParameter("PRNO")==null)
			mPRNO="";
	else
			mPRNO=request.getParameter("PRNO").toString().trim();

if(request.getParameter("FLAG")==null)
			mFl="";
	else
			mFl=request.getParameter("FLAG").toString().trim();

if(mFl.equals("N"))
{
	qryo="select B.POCKETCODE,A.COSTCENTRECODE,A.STORECODE,nvl(A.PRREFERENCENO,' ')PRREFERENCENO,nvl(to_char(A.PRREFERENCEDATE,'dd-mm-yyyy'),' ')PRREFERENCEDATE,A.SITECODE,A.LOCATIONCODE,nvl(A.REMARKS,' ')REMARKS ";
	qryo=qryo+" from PRMASTER A ,PRDETAIL B where A.companycode='"+mCompanyCode+"' and A.PRNO='"+mPRNO+"' and nvl(A.DEACTIVE,'N')='N' ";
	qryo=qryo+" AND A.companycode=B.companycode AND A.PRNO=B.PRNO ";
	rso=db.getRowset(qryo);
	if(rso.next())
	{

	mCC=rso.getString("COSTCENTRECODE");
		mSC=rso.getString("STORECODE");
			mPR=rso.getString("PRREFERENCENO");
				mPD=rso.getString("PRREFERENCEDATE");
					mSCode=rso.getString("SITECODE");
						mLC=rso.getString("LOCATIONCODE");
							mRR=rso.getString("REMARKS");
							 mPC1=rso.getString("POCKETCODE");
	}
} // closing of if mFL.equals="N"
  //----------------------
%>

	<!--
   	<table id=id1 width="100%" ALIGN=CENTER bottommargin=0 topmargin=0>
	<tr><TD align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Purchase Requisition General Category</B></TD>
	</font></td></tr>
	</TABLE>
	-->
	<form name="frm1"  method="get" action="EditPurchaseRequisition.jsp">
	<input id="y" name="y" type=hidden>

<table align=center width="100%" bottommargin=0 topmargin=0>
			<tr>
				<td align="left" width=33%>&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<TD colspan=0 align=middle width=34%><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4>Purchase Requisition<br>(General Category)</FONT></u></b></td>
				<td align="right" width=33%><input type="submit"  value="Edit Purchase Requisition" style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 200px; HEIGHT: 23px; FONT-VARIANT: normal; cursor:hand; border-width:1 ; filter:progid:DXImageTransform.Microsoft.Gradient(startColorStr='#ff8c00', endColorStr='White', gradientType='0'"></td>
			</tr>
			</table>
</form>
	   <form name="frm"  method="post" action="PurchaseRequisitionAction.jsp"> 
	  
	<input id="x" name="x" type=hidden>
	<table align=center bottommargin=0 cellspacing=0 cellpadding=2 topmargin=0 border=1 rule=rows width="98%">
	<tr bgcolor=burlywood>

	<td> 
	<input  type=checkbox name="NewPR" id="NewPR" value="NPR" onclick="Disab();">
	<b>New PR</B>
	&nbsp; <b>Old PR.</B> &nbsp;
	<select name="DataPRNO" id="DataPRNO" style="WIDTH: 0px" > 
	<%
	qry="select A.PRNO,B.POCKETCODE,A.COSTCENTRECODE,A.STORECODE,nvl(A.PRREFERENCENO,'**')PRREFERENCENO,nvl(to_char(A.PRREFERENCEDATE,'dd-mm-yyyy'),'**')PRREFERENCEDATE,A.SITECODE,A.LOCATIONCODE,nvl(A.REMARKS,'**')REMARKS ";
	qry=qry+" from PRMASTER A ,PRDETAIL B where A.companycode='"+mCompanyCode+"'  and nvl(A.DEACTIVE,'N')='N' and nvl(A.DOCMODE,'N')='D' ";
	qry=qry+" AND A.PRNO=B.PRNO ";
	rs=db.getRowset(qry);
	if (request.getParameter("x")==null) 
		{
			while(rs.next())
			{

	mP=rs.getString("PRNO");			
	mCC1=rs.getString("COSTCENTRECODE");
		mSC1=rs.getString("STORECODE");
			mPR1=rs.getString("PRREFERENCENO");
				mPD1=rs.getString("PRREFERENCEDATE");
					mSCode1=rs.getString("SITECODE");
						mLC1=rs.getString("LOCATIONCODE");
							mRR1=rs.getString("REMARKS");
							 mPC11=rs.getString("POCKETCODE");

 ComboPr=mCC1+"///"+mSC1+"***"+mPR1+"@@@"+mPD1+"###"+mSCode1+"%%%"+mLC1+"!!!"+mPC11+"$$$"+mRR1+"~~~"+mP;
%>
		
			<option  value=<%=ComboPr%>><%=mP%></option>
		<%

			} // closing of while 
		}
			else
			{
				while(rs.next())
				{	
 ComboPr=mCC1+"///"+mSC1+"***"+mPR1+"@@@"+mPD1+"###"+mSCode1+"%%%"+mLC1+"!!!"+mPC11+"$$$"+mRR1+"~~~"+mP;
				//	if(ComboPr.equals(Mprno))
				 if(ComboPr.equals(request.getParameter("DataPRNO")))
					{
					%>
					<option selected  value=<%=ComboPr%>><%=mP%></option>					<%
					}
					else
					{

					%>
<option  value=<%=ComboPr%>><%=mP%></option>					<%
					}
				}
			} // closing of else
		%>
		</select>
	<select name="PRNO" id="PRNO" style="WIDTH: 110px" onclick="ComboPR(PRNO.value);" onChange="ComboPR(PRNO.value);"> 

<%
		qry="select distinct prno from prmaster where nvl(DEACTIVE,'N')='N' and nvl(DOCMODE,'N')='D' order by 1 ";
		rs=db.getRowset(qry);
		if (request.getParameter("x")==null) 
		{
			while(rs.next())
			{
				Mprno=rs.getString("prno");

			if(mPRNO.equals(Mprno))
			{
		%>
			<option selected value=<%=Mprno%>><%=rs.getString("prno")%></option>
		<%	
			} // closing of if
			else
			{	
		%>
			<option value=<%=Mprno%>><%=rs.getString("prno")%></option>
		<%
			}	

			} // closing of while 
		}
			else
			{
				while(rs.next())
				{	
					Mprno=rs.getString("prno");
					if(mPRNO.equals(Mprno))
				// if(Mprno.equals(request.getParameter("PRNO")))
					{
					%>
						<option selected value=<%=Mprno%>><%=rs.getString("prno")%></option>
					<%
					}
					else
					{

					%>
						<option value=<%=Mprno%>><%=rs.getString("prno")%></option>
					<%
					}
				}
			} // closing of else
		%>
		</select>&nbsp;&nbsp;&nbsp;&nbsp;<b>Cost Center</B> &nbsp;
		<select name="CostCentre" id="CostCentre" style="WIDTH: 120px">
		  <%
			qry="select distinct costcentrecode,costcentrename from costcentremaster where nvl(DEACTIVE,'N')='N' order by costcentrename ";
			rs=db.getRowset(qry);
			if (request.getParameter("x")==null) 
			{
				while(rs.next())
				{
					mCentreCode=rs.getString("costcentrecode");
					if(mCC.equals(mCentreCode))
					{
					%>
					<option selected value=<%=mCentreCode%>><%=rs.getString("costcentrename")%></option>
					<%	
                    }//  closing of if
					else
					{
					%>
					<option value=<%=mCentreCode%>><%=rs.getString("costcentrename")%></option>
					<%	
                    }//  closing of else
				} // closing of while
			}
			else
			{
				while(rs.next())
				{	
					mCentreCode=rs.getString("costcentrecode");
					if(mCC.equals(mCentreCode))
				//	if(mCentreCode.equals(request.getParameter("CostCentre")))
					{
					%>
						<option selected value=<%=mCentreCode%>><%=rs.getString("costcentrename")%></option>
					<%
					}
					else
					{
					%>
						<option value=<%=mCentreCode%>><%=rs.getString("costcentrename")%></option>
					<%
					}
				}
			} // closing of else
		%>
		</select>&nbsp;&nbsp;&nbsp;
		  <b>Store</B> 
		<select name="Store" id="Store" style="WIDTH: 194px">
		  <%
			qry="select distinct storecode,storedescription from storemaster where nvl(DEACTIVE,'N')='N' order by 2  ";
			rs=db.getRowset(qry);
			if (request.getParameter("x")==null) 
			{
				while(rs.next())
				{
					mStoreCode=rs.getString("storecode");
					if(mSC.equals(mStoreCode))
					{
					%>
					<option selected value=<%=mStoreCode%>><%=rs.getString("storedescription")%></option>
					<%	
					}
					else
					{
					%>
					<option value=<%=mStoreCode%>><%=rs.getString("storedescription")%></option>
					<%
					} // closing of else	
				}
			}
			else
			{
				while(rs.next())
				{	
					mStoreCode=rs.getString("storecode");
					if(mSC.equals(mStoreCode))
					// if(mStoreCode.equals(request.getParameter("Store")))
					{
					%>
						<option selected value=<%=mStoreCode%>><%=rs.getString("storedescription")%></option>
					<%
					}
					else
					{
					%>
						<option value=<%=mStoreCode%>><%=rs.getString("storedescription")%></option>
					<%
					}
				}
			} // closing of else
		%>
		</select>
		</td>
	</tr>
<tr bgcolor=burlywood>
<td>
<b>PR Ref No</B>&nbsp;&nbsp;&nbsp;&nbsp;<input type=text value="<%=mPR%>" name="Prrefno" id="Prrefno" size=10>
&nbsp;<b>PR Ref Date</B> 
	<input type=text name="Prrefdate" value="<%=mPD%>" id="Prrefdate" size=7 maxlength=10 onchange="return iSValidDate1(Prrefdate.value);"><font size=1 color=teal>#</font>
		  <b>Site</B> 
		<select name="Site" id="Site" style="WIDTH: 85px">
		  <%
			qry="select distinct sitecode,sitename from sitemaster where nvl(DEACTIVE,'N')='N' order by 2";
			rs=db.getRowset(qry);
			if (request.getParameter("x")==null) 
			{
				while(rs.next())
				{
					mSiteCode=rs.getString("sitecode");
					if(mSCode.equals(mSiteCode))
					{
					%>
					<option selected value=<%=mSiteCode%>><%=rs.getString("sitename")%></option>
					<%	
					}
					else
					{
					%>
					<option value=<%=mSiteCode%>><%=rs.getString("sitename")%></option>
					<%	
					}
				}
			}
			else
			{
				while(rs.next())
				{	
					mSiteCode=rs.getString("sitecode");
					if(mSCode.equals(mSiteCode))
				 // if(mSiteCode.equals(request.getParameter("Site")))
					{
					%>
						<option selected value=<%=mSiteCode%>><%=rs.getString("sitename")%></option>
					<%
					}
					else
					{
					%>
						<option value=<%=mSiteCode%>><%=rs.getString("sitename")%></option>
					<%
					}
				}
			} // closing of else
		%>
		</select>
		&nbsp;<b>Location</B> 
		<select name="Location" id="Location" style="WIDTH: 194px">
		  <%
			qry="select distinct locationcode,locationname from locationmaster where nvl(DEACTIVE,'N')='N' order by 2";
			rs=db.getRowset(qry);
			if (request.getParameter("x")==null) 
			{
				while(rs.next())
				{
					mLocationCode=rs.getString("locationcode");
					if(mLC.equals(mLocationCode))
					{
					%>
					<option selected  value=<%=mLocationCode%>><%=rs.getString("locationname")%></option>
					<%	
					}
					else
					%>
					<option value=<%=mLocationCode%>><%=rs.getString("locationname")%></option>
					<%	
				}
			}
			else
			{
				while(rs.next())
				{	
					mLocationCode=rs.getString("locationcode");
					if(mLC.equals(mLocationCode))
				//	if(mLocationCode.equals(request.getParameter("Location")))
					{
					%>
						<option selected value=<%=mLocationCode%>><%=rs.getString("locationname")%></option>
					<%
					}
					else
					{
					%>
						<option value=<%=mLocationCode%>><%=rs.getString("locationname")%></option>
					<%
					}
				}
			} // closing of else
		%>
		</select>
</td>
</tr>
<tr bgcolor=burlywood>
<td colspan=3>
<b> Item Type</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<select name="ItemType" id="ItemType" style="WIDTH: 270px">
		  <%
			qry="select distinct pocketcode,pocketdescription  from pocketmaster where nvl(DEACTIVE,'N')='N' order by 2";
			rs=db.getRowset(qry);
			if (request.getParameter("x")==null) 
			{
				while(rs.next())
				{
					mItemType=rs.getString("pocketcode");
					if(mPC1.equals(mItemType))
					{
					%>
					<option selected value=<%=mItemType%>><%=rs.getString("pocketdescription")%></option>
					<%	
					}
					else
					{
					%>
					<option value=<%=mItemType%>><%=rs.getString("pocketdescription")%></option>
					<%
					}
				}
			}
			else
			{
				while(rs.next())
				{	
					mItemType=rs.getString("pocketcode");
					if(mPC1.equals(mItemType))
				//	if(mItemType.equals(request.getParameter("ItemType").toString().trim()))
					{
					%>
						<option selected value=<%=mItemType%>><%=rs.getString("pocketdescription")%></option>
					<%
					}
					else
					{
					%>
						<option value=<%=mItemType%>><%=rs.getString("pocketdescription")%></option>
					<%
					}
				}
			} // closing of else
		%>
	</select><font color=red>*</font>
	&nbsp;
<B>Remarks</b>&nbsp;&nbsp;
  <input type=text value="<%=mRR%>" name="Remarks" id="Remarks" size=42%>
</td>
 <input type=hidden name="ItemCategory" id="ItemCategory" value="G">
</tr>
<tr>
	<td colspan=3>
	<b>Major Head</B>&nbsp;&nbsp;&nbsp;&nbsp;
		<select name="MajorHead" id="MajorHead" style="WIDTH: 270px" onclick="ChangeOptions(MajorHead.value,DataItemHead,ItemHead,DataItemSubHead,ItemSubHead,DataItemCode,ItemCode);" onChange="ChangeOptions(MajorHead.value,DataItemHead,ItemHead,DataItemSubHead,ItemSubHead,DataItemCode,ItemCode);">
	<option selected value="NONE" ><--Select Major Head--></option>
		  <%
			qry="select distinct itemmajorhead,majorheaddescription  from itemmajorhead where nvl(DEACTIVE,'N')='N' order by 2";
			rs=db.getRowset(qry);
			if (request.getParameter("x")==null) 
			{
				while(rs.next())
				{
					mMajorHead=rs.getString("itemmajorhead");
					mMajoor=mMajorHead;
					%>
					<option value=<%=mMajorHead%>><%=rs.getString("majorheaddescription")%></option>
					<%	
				}
			}
			else
			{
				while(rs.next())
				{	
					mMajorHead=rs.getString("itemmajorhead");
					if(mMajorHead.equals(request.getParameter("MajorHead").toString().trim()))
					{
					mMajoor=mMajorHead;
					%>
						<option  value=<%=mMajorHead%>><%=rs.getString("majorheaddescription")%></option>
					<%
					}
					else
					{
					%>
						<option value=<%=mMajorHead%>><%=rs.getString("majorheaddescription")%></option>
					<%
					}
				}
			} // closing of else
		%>
		</select><font color=red>*</font>&nbsp;
<%
	qry="select distinct ITEMMAJORHEAD,ITEMHEAD,HEADDESCRIPTION from ItemHEAD";
	qry=qry+" where nvl(DEACTIVE,'N')='N' order by ITEMMAJORHEAD,ITEMHEAD,HEADDESCRIPTION ";        
	rs=db.getRowset(qry);
%>
	<select name="DataItemHead" id="DataItemHead" style="WIDTH: 0px">
<%
if (request.getParameter("x")==null) 
{
				while(rs.next())
				{
					mDataItemHead=rs.getString("ITEMMAJORHEAD")+"***"+rs.getString("ITEMHEAD");
					%>
					<option value=<%=mDataItemHead%>><%=rs.getString("HEADDESCRIPTION")%></option> 
					<%	
				}
			}
			else
			{
				while(rs.next())
				{	
					mDataItemHead=rs.getString("ITEMMAJORHEAD")+"***"+rs.getString("ITEMHEAD");
					if(mDataItemHead.equals(request.getParameter("DataItemHead").toString().trim()))
					{
					%>
						<option selected value=<%=mDataItemHead%>><%=rs.getString("HEADDESCRIPTION")%></option>
					<%
					}
					else
					{
					%>
						<option value=<%=mDataItemHead%>><%=rs.getString("HEADDESCRIPTION")%></option>
					<%
					}
				}
			} // closing of else
%>
</select>
	<b>Item  Head</B> 
	<select name="ItemHead" id="ItemHead" style="WIDTH: 275px" onclick="ChangeOptions1(MajorHead.value,ItemHead.value,DataItemSubHead,ItemSubHead,DataItemCode,ItemCode);" onChange="ChangeOptions1(MajorHead.value,ItemHead.value,DataItemSubHead,ItemSubHead,DataItemCode,ItemCode);">
	<option selected value="NONE" ><--Select Item Head--></option>
	  <%
		//	qry="select distinct itemhead,headdescription  from itemhead where itemmajorhead='"+mMajoor+"' and  nvl(DEACTIVE,'N')='N' order by 2";
		qry="select distinct itemhead,headdescription  from itemhead where  nvl(DEACTIVE,'N')='N' order by 2";
			rs=db.getRowset(qry);
			if (request.getParameter("x")==null) 
			{
				while(rs.next())
				{

					mItemHead=rs.getString("itemhead");
					mIteem=mItemHead;
					%>
					<option value=<%=mItemHead%>><%=rs.getString("headdescription")%></option>
					<%	
				}
			}
			else
			{
				while(rs.next())
				{	
					mItemHead=rs.getString("itemhead");
					if(mItemHead.equals(request.getParameter("ItemHead").toString().trim()))
					{
						mIteem=mItemHead;
					%>
						<option  value=<%=mItemHead%>><%=rs.getString("headdescription")%></option>
					<%
					}
					else
					{
					%>
						<option value=<%=mItemHead%>><%=rs.getString("headdescription")%></option>
					<%
					}
				}
			} // closing of else
		%>
		</select><font color=red>*</font>
		<%
	qry="select distinct ITEMMAJORHEAD,ITEMHEAD,ITEMSUBHEAD,SUBHEADDESCRIPTION from ITEMSUBHEAD";
	qry=qry+" where nvl(DEACTIVE,'N')='N' order by ITEMMAJORHEAD,ITEMHEAD,ITEMSUBHEAD, SUBHEADDESCRIPTION ";        
	rs=db.getRowset(qry);
%>
	<select name="DataItemSubHead" id="DataItemSubHead" style="WIDTH: 0px">
<%
if (request.getParameter("x")==null) 
{
				while(rs.next())
				{
					mDataItemSubHead=rs.getString("ITEMMAJORHEAD")+"***"+rs.getString("ITEMHEAD")+"///"+rs.getString("ITEMSUBHEAD");
					%>
					<option value=<%=mDataItemSubHead%>><%=rs.getString("SUBHEADDESCRIPTION")%></option> 
					<%	
				}
			}
			else
			{
				while(rs.next())
				{	
					mDataItemSubHead=rs.getString("ITEMMAJORHEAD")+"***"+rs.getString("ITEMHEAD")+"///"+rs.getString("ITEMSUBHEAD");
					if(mDataItemSubHead.equals(request.getParameter("DataItemSubHead").toString().trim()))
					{
					%>
						<option selected value=<%=mDataItemSubHead%>><%=rs.getString("SUBHEADDESCRIPTION")%></option>
					<%
					}
					else
					{
					%>
						<option value=<%=mDataItemSubHead%>><%=rs.getString("SUBHEADDESCRIPTION")%></option>
					<%
					}
				}
			} // closing of else
%>
</select>

	</td>	
	</tr>
<tr>
<td colspan=3>


	<b>Item Sub Head</B> 
		<select name="ItemSubHead" id="ItemSubHead" style="WIDTH: 270px"  onclick="ChangeOptions2(MajorHead.value,ItemHead.value,ItemSubHead.value,DataItemCode,ItemCode);" onChange="ChangeOptions2(MajorHead.value,ItemHead.value,ItemSubHead.value,DataItemCode,ItemCode);">
	<option selected value="NONE" ><--Select Item Sub Head--></option>
		  <%
		//	qry="select distinct itemsubhead,subheaddescription  from itemsubhead where itemmajorhead='"+mMajoor+"' and itemhead='"+mIteem+"' and nvl(DEACTIVE,'N')='N' order by 2";
qry="select distinct itemsubhead,subheaddescription  from itemsubhead where nvl(DEACTIVE,'N')='N' order by 2";

			rs=db.getRowset(qry);
			if (request.getParameter("x")==null) 
			{
				while(rs.next())
				{
					mItemSubHead=rs.getString("itemsubhead");
					mIteemSub=mItemSubHead;
					%>
					<option value=<%=mItemSubHead%>><%=rs.getString("subheaddescription")%></option>
					<%	
				}
			}
			else
			{
				while(rs.next())
				{	
					mItemSubHead=rs.getString("itemsubhead");
					if(mItemSubHead.equals(request.getParameter("ItemSubHead").toString().trim()))
					{
						mIteemSub=mItemSubHead;
					%>
						<option  value=<%=mItemSubHead%>><%=rs.getString("subheaddescription")%></option>
					<%
					}
					else
					{
					%>
						<option value=<%=mItemSubHead%>><%=rs.getString("subheaddescription")%></option>
					<%
					}
				}
			} // closing of else
		%>
		</select><font color=red>*</font>
		

<%
	qry="select distinct ITEMMAJORHEAD,ITEMHEAD,ITEMSUBHEAD,ITEMCODE,ITEMDESCRIPTION from ITEMCATALOGUE";
	qry=qry+" where nvl(DEACTIVE,'N')='N' order by ITEMMAJORHEAD,ITEMHEAD,ITEMSUBHEAD,ITEMCODE,ITEMDESCRIPTION ";        
	rs=db.getRowset(qry);
%>
	<select name="DataItemCode" id="DataItemCode" style="WIDTH: 0px">
<%
if (request.getParameter("x")==null) 
{
				while(rs.next())
				{
	mDataItemCode=rs.getString("ITEMMAJORHEAD")+"***"+rs.getString("ITEMHEAD")+"///"+rs.getString("ITEMSUBHEAD")+"%%%"+rs.getString("ITEMCODE");
					%>
					<option value=<%=mDataItemCode%>>(<%=rs.getString("ITEMCODE")%>)&nbsp;<%=rs.getString("ITEMDESCRIPTION")%></option> 
					<%	
				}
			}
			else
			{
				while(rs.next())
				{	
mDataItemCode=rs.getString("ITEMMAJORHEAD")+"***"+rs.getString("ITEMHEAD")+"///"+rs.getString("ITEMSUBHEAD")+"%%%"+rs.getString("ITEMCODE");
					if(mDataItemCode.equals(request.getParameter("DataItemCode").toString().trim()))
					{
					%>
						<option selected value=<%=mDataItemCode%>>(<%=rs.getString("ITEMCODE")%>)&nbsp;<%=rs.getString("ITEMDESCRIPTION")%></option>
					<%
					}
					else
					{
					%>
						<option value=<%=mDataItemCode%>>(<%=rs.getString("ITEMCODE")%>)&nbsp;<%=rs.getString("ITEMDESCRIPTION")%></option>
					<%
					}
				}
			} // closing of else
%>
</select>
		<b>Item Code </B> 
		<select name="ItemCode" id="ItemCode" style="WIDTH: 278px" onclick="ChangeOptions3(MajorHead.value,ItemHead.value,ItemSubHead.value,ItemCode.value,DataItemPart,PartRefMake,AU);" onChange="ChangeOptions3(MajorHead.value,ItemHead.value,ItemSubHead.value,ItemCode.value,DataItemPart,PartRefMake,AU);"> 

	<option selected value="NONE" ><--Select Item Code--></option>
	
		  <%
qry="select distinct itemcode,itemdescription  from itemcatalogue where nvl(DEACTIVE,'N')='N' order by 2";
			rs=db.getRowset(qry);
			if (request.getParameter("x")==null) 
			{
				while(rs.next())
				{

					mItemCode=rs.getString("itemcode");
					//System.out.println(mItemCode);
					%>
					<option value="<%=mItemCode%>">(<%=mItemCode%>)&nbsp;<%=rs.getString("itemdescription")%></option>
					<%	
				}
			}
			else
			{
				while(rs.next())
				{	
					mItemCode=rs.getString("itemcode");
					if(mItemCode.equals(request.getParameter("ItemCode").toString().trim()))
					{
					%>
						<option  value="<%=mItemCode%>">(<%=mItemCode%>)&nbsp;<%=rs.getString("itemdescription")%></option>
					<%
					}
					else
					{
					%>
						<option value="<%=mItemCode%>">(<%=mItemCode%>)&nbsp;<%=rs.getString("itemdescription")%></option>
					<%
					}
				}
			} // closing of else
		%>
		</select><font color=red>*</font>
		<%
	qry="select distinct ITEMMAJORHEAD,ITEMHEAD,ITEMSUBHEAD,ITEMCODE,ITEMDESCRIPTION ,nvl(PARTREFNO,'-1')PARTREFNO,nvl(PURCHASEUOM,'-1')PURCHASEUOM from ITEMCATALOGUE";
	qry=qry+" where nvl(DEACTIVE,'N')='N' order by ITEMMAJORHEAD,ITEMHEAD,ITEMSUBHEAD,ITEMCODE,ITEMDESCRIPTION ";        
	rs=db.getRowset(qry);
%>
	<select name="DataItemPart" id="DataItemPart" style="WIDTH: 0px">
<%
if (request.getParameter("x")==null) 
{
				while(rs.next())
				{
//System.out.println("rr"+rs.getString("ITEMCODE"));
	mItemPartRef=rs.getString("ITEMMAJORHEAD")+"***"+rs.getString("ITEMHEAD")+"///"+rs.getString("ITEMSUBHEAD")+"%%%"+rs.getString("ITEMCODE")+"###"+rs.getString("PARTREFNO")+"@@@"+rs.getString("PURCHASEUOM");
					%>
					<option value="<%=mItemPartRef%>"><%=mItemPartRef%></option> 
					<%	
				}
			}
			else
			{
				while(rs.next())
				{	
	mItemPartRef=rs.getString("ITEMMAJORHEAD")+"***"+rs.getString("ITEMHEAD")+"///"+rs.getString("ITEMSUBHEAD")+"%%%"+rs.getString("ITEMCODE")+"###"+rs.getString("PARTREFNO")+"@@@"+rs.getString("PURCHASEUOM");
					if(mItemPartRef.equals(request.getParameter("DataItemPart").toString().trim()))
					{
					%>
						<option selected value=<%=mItemPartRef%>><%=mItemPartRef%></option>
					<%
					}
					else
					{
					%>
						<option value=<%=mItemPartRef%>><%=mItemPartRef%></option>
					<%
					}
				}
			} // closing of else
%>
</select>
	</td>



</tr>
<tr>
<td colspan=3>
<b>PartRef/Make</B> 
<input type=text name="PartRefMake" id="PartRefMake" size=18>
<input type=text name="PartMake" id="PartMake" size=18>
&nbsp;&nbsp; 
<b>Qty Required</b>&nbsp;&nbsp;
	<input type=text name="QtyReq" id="QtyReq" size=12><font color=red>*</font>&nbsp;&nbsp;&nbsp;&nbsp;
	<b>A/U</b>
	<select name="AU" id="AU" style="WIDTH: 60px">
	<%
		qry="select UOM from INVENTORYUOM where nvl(DEACTIVE,'N')='N' ";
		rs=db.getRowset(qry);
		while(rs.next())
		{
		%>
		<option value=<%=rs.getString("UOM")%>><%=rs.getString("UOM")%></option>
		<%	
		}	
	%>
	</select>
	<!-- <input type=text name="AU" id="AU" size=5>-->
	<font color=red>*</font> 
</td>
</tr>	
<tr>
<td colspan=3>
<%
	String qryd11="";
	ResultSet rsd11=null;

	qryd11=" select to_char(sysdate,'dd-mm-yyyy') from dual";
	rsd11=db.getRowset(qryd11);
	rsd11.next();
%>
	<input type=hidden name="SDate"  value="<%=rsd11.getString(1)%>" id="SDate">
	<b>Req. Date</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type=text name="ReqDate" id="ReqDate" size=8 maxlength=10 onchange="return iSValidDate(ReqDate.value);" >
	<font size=1 color=teal>#</font> &nbsp;<b>Remarks</b>
	<input type=text name="Remarks1" id="Remarks1" size=15>&nbsp;&nbsp;
&nbsp;
	<b>Detail Desc.</b>&nbsp; &nbsp;
		<input type=text name="DetailDesc" id="DetailDesc" size=30>
	</td>
</tr>
<tr>
<td colspan=3>
	
</td>
</tr>
<tr>
	<td align=center colspan=3>
<input type=submit name="SAVE" value="Save/Refresh"  onClick="return IsNumeric();">
	</td>
</tr>
	</table>  
	<font size=2 color=teal># (DD-MM-YYYY)</font> 

</form>
<%
if(!mPRNO.equals(""))
{
if(mFl.equals("N"))
{
%>
<TABLE bgcolor=#fce9c5 class="sort-table"  width=98% ALIGN=CENTER rules=COLUMNS CELLSPACING=0 BORDER=1> 
	<thead>
	<tr bgcolor="#ff8c00">
		<TD ALIGN=CENTER><font color=white><b>Sno.<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>PRNO.<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>ItemCode<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>ItemDescription<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Make<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Req.Qty(UOM)<B><font></TD>
	</tr>
	</thead>
<%
qry=" select distinct A.PRNO,A.ItemCode,B.itemdescription,nvl(A.make,' ')make,A.UOM,A.REQUESTEDQTY from PRDETAIL A,itemcatalogue B ";
qry=qry+" where A.PRNO in (select Prno from PRMASTER where prno='"+mPRNO+"' and  departmentcode='"+mDepartmentCode+"') and A.itemcode=B.itemCode ";
qry=qry+" and nvl(A.DEACTIVE,'N')='N' AND NVL(B.DEACTIVE,'N')='N' order by A.PRNO,A.ITemcode";
rs=db.getRowset(qry);
int ctr=0;
	while(rs.next())
	{	
		ctr++;
	%>
		<tr>		
			<td><%=ctr%></td>
			<td>&nbsp;<%=rs.getString("PRNO")%></td>
			<td>&nbsp;<%=rs.getString("ItemCode")%></td>
			<td NOWRAP>&nbsp;<%=rs.getString("itemdescription")%></td>
			<td NOWRAP>&nbsp;<%=rs.getString("make")%></td>
			<td>&nbsp;<%=rs.getString("REQUESTEDQTY")%>&nbsp;<%=rs.getString("UOM")%></td>
				
		</tr>
	<%
	}// closing of while
}// closing of mFl=N
else
{

%>
<TABLE bgcolor=#fce9c5 class="sort-table"  width=98% ALIGN=CENTER rules=COLUMNS CELLSPACING=0 BORDER=1> 
	<thead>
	<tr bgcolor="#ff8c00">
		<TD ALIGN=CENTER><font color=white><b>Sno.<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>PRNO.<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>ItemCode<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>ItemDescription<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Make<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Req.Qty(UOM)<B><font></TD>
	</tr>
	</thead>
<%
qry=" select distinct A.PRNO,A.ItemCode,B.itemdescription,nvl(A.make,' ')make,A.UOM,A.REQUESTEDQTY from PRDETAIL A,itemcatalogue B ";
qry=qry+" where A.PRNO in (select Prno from PRMASTER where prno='"+mPRNO+"' and departmentcode='"+mDepartmentCode+"') and A.itemcode=B.itemCode ";
qry=qry+"  AND nvl(A.DEACTIVE,'N')='N' AND NVL(B.DEACTIVE,'N')='N' order by A.PRNO,A.ITemcode";
rs=db.getRowset(qry);
int ctr=0;
	while(rs.next())
	{	
		ctr++;
	%>
		<tr>		
			<td><%=ctr%></td>
			<td>&nbsp;<%=rs.getString("PRNO")%></td>
			<td>&nbsp;<%=rs.getString("ItemCode")%></td>
			<td NOWRAP>&nbsp;<%=rs.getString("itemdescription")%></td>
			<td NOWRAP>&nbsp;<%=rs.getString("make")%></td>
			<td>&nbsp;<%=rs.getString("REQUESTEDQTY")%>&nbsp;<%=rs.getString("UOM")%></td>
				
		</tr>
	<%
	}// closing of while
%>
	</table>
<%
} // closing of else


} // closing of if(!mPRNO.equals(""))
		
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

}
%>
</body>
</html>