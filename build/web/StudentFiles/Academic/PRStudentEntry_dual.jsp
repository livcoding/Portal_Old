<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%


ResultSet  rsdks=null,rs=null,rs1=null,rss1=null,rsc=null,rse=null,rse1=null,rsso=null,rse12=null,rsexam=null,rse1212=null;
String aa="";
String qry="",qry1="";
String mDID="",mProg="";
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
double mMinCrLmt=0, mMaxCrLmt=0, mMinCrLmtTkn=0, mMaxCrLmtTkn=0, mMaxCrLmtAld=0, mCourseCrPt=0, mTotalCrLmtTkn=0;
String mSect="",	mSubSect="", mTag="",mElective="",mSCode="";
String mExam="", mFailGraders="F", mPrcode="";
String mName1="", mName2="", mNameSmall="",mName3="", mName4="", mName5="", mName6="", mName7="", mName8="", mName9="", mName10="";
String mFlagstr1="",value="Y";
String readonly="",pdvalue="";
int mochoice=0, mochoice1=0,Count=0,chk=0,m=1,eee=0;
int CourseCrPtBasketD=1,i=1;
String choise="",qry2="";
double mMinBasketD=0,mMaxBasketD=0,mMaxCrLmtTknbc=0;
double mMinBasketE=0,mMaxBasketE=0;
	int mysno=0;
long  FeeAmt=0;
int pp=0,mFlag=0;
/*
*************************************************************************************************
	' *
	' * File Name:	PRStudentEntry.jsp		[For Students]
	' * Author:		Ankur Verma
	' * Date:		21th april 2010
	' * Version:	1.0
	' * Description:	Pre Registration of Students [Choices for Back & Curr Core+Elective+FreeElective]
*************************************************************************************************
*/

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Subject Selection for the comming classes(Pre Registration of Students) ] </TITLE>
<script type="text/javascript" src="../js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="../css/sortabletable.css" />

<Html>
<head>
<style type="text/css">
body {scrollbar-3dlight-color:#ffd700;
scrollbar-arrow-color:#ff0;
scrollbar-base-color:#000ff0;
scrollbar-darkshadow-color:#000000;
scrollbar-face-color:#de6400;
scrollbar-highlight-color:#9900005;
scrollbar-shadow-color:#f0f}
</style>
<script language=javascript>

function FunMustChoice(j,k,n){
	var x=parseInt(j);
	var y=parseInt(k);
	var TotCtr=document.frm1.TotalRec.value;
	var total=parseInt(document.frm1.TotalCCP.value);
	var backcr=parseInt(document.frm1.backcr.value);
	if(backcr>=total){
		if(document.frm1["CHK"+y].checked){
			var z=parseInt(document.frm1.TotalCCPAld.value)+parseInt(j);
			if(document.frm1.TotalCCP.value>=z){
			document.frm1.TotalCCPAld.setAttribute("value",z);
			}else{
				alert('You have exceeded the maximum credit limit of '+document.frm1.TotalCCP.value);
				document.frm1["CHK"+y].checked=false;
			}
		}
		else{
			var z=parseInt(document.frm1.TotalCCPAld.value)-parseInt(j);
			document.frm1.TotalCCPAld.setAttribute("value",z);
		}
	}else{
		mName1="CHK"+y;
		if(document.frm1[mName1].checked==false){
			alert('Sorry this is yours compulsary Backlog Course(s)');
			document.frm1[mName1].checked=true;
		}else{
			FunRefresh(j,k,b,n);
		}
	}
}

function FunRefresh(j,k,b,n){

var totalcheckcount=document.getElementById("Count2").value;

//ankur
//alert(n+"LLL"+b+": : "+k+" : : "+j+" totalcheckcount"+totalcheckcount+" ::---"+document.frm1.TotalCCP.value);
var nn1,flag1,sum1=0;
//alert(document.frm1["Improvement"+k].value+"LLL");

for(i=1;i<=totalcheckcount ;i++){
			nn1="CHK"+i;
			//alert(document.frm1[nn1].checked);
			if(document.frm1[nn1].checked==false){
				flag1=1;
			}else{

				sum1++;
				//alert(sum1);
			}
}

if(sum1<totalcheckcount)
	{

if(document.frm1["Improvement"+k].value=="Y"  )
					{
	alert('Sorry first you have to select all core subjects because you have credit points');
	document.frm1[n].checked=false;
					}
	}

//alert(sum1+"  :: sum1");

//if(document.frm1["Improvement"+k]==null)
//	{
//	}


	var total=parseInt(document.frm1.TotalCCP.value);
	var backcr=parseInt(document.frm1.backcr.value);

//alert(backcr+"-    - -"+total);
	if(backcr>=total){
		if(document.frm1[n].checked){
			var z=parseInt(document.frm1.TotalCCPAld.value)+parseInt(j);
			if(document.frm1.TotalCCP.value>=z){
			document.frm1.TotalCCPAld.setAttribute("value",z);
			}else{
				alert('You have exceeded the maximum credit limit of '+document.frm1.TotalCCP.value);
				document.frm1[n].checked=false;
			}
		}
		else{
			var z=parseInt(document.frm1.TotalCCPAld.value)-parseInt(j);
			document.frm1.TotalCCPAld.setAttribute("value",z);
		}
	}else{
		var t=0;
		if(document.frm1.pd==null)
			t=0;
		else
			 t =document.frm1.pd.value;

		var ec=document.frm1.electivecount.value;
		var tot=document.frm1.last.value;
		var flag=0,i=0,n,sum=0;
		var totalchkcr=parseInt(document.frm1.no.value);
		var total=parseInt(document.frm1.TotalCCP.value);
		var checkbox=parseInt(tot)-(parseInt(t)+parseInt(ec));
		//alert(checkbox);
		for(i=1;i<=checkbox ;i++){
			nn="CHK"+i;
			if(document.frm1[nn].checked==false){
				flag=1;
			}else{
				sum=parseInt(document.frm1["cr"+i].value)+sum;
			}

//alert("cccc"+nn);

//if(document.frm1["Improvement"+i].value=="Y")


		}

		if(parseInt(t)!=0 && parseInt(total)!=0){
			if(total>=totalchkcr){
				alert('Sorry first you have to select all core because you have credit points');
				document.frm1[n].checked=true;
				return false;
			}else
			if(document.frm1[n].checked){
				var z=parseInt(document.frm1.TotalCCPAld.value)+parseInt(j);
				if(document.frm1.TotalCCP.value>=z){
				document.frm1.TotalCCPAld.setAttribute("value",z);
				}else{
					alert('You have exceeded the maximum credit limit of '+document.frm1.TotalCCP.value);
					document.frm1[n].checked=false;
				}
			}
			else{
				var z=parseInt(document.frm1.TotalCCPAld.value)-parseInt(j);
				document.frm1.TotalCCPAld.setAttribute("value",z);
			}
		}
		else{
			if(document.frm1[n].checked){
				var z=parseInt(document.frm1.TotalCCPAld.value)+parseInt(j);

			//alert(z + " :: "+document.frm1.TotalCCP.value);

				if(document.frm1.TotalCCP.value>=z){
				document.frm1.TotalCCPAld.setAttribute("value",z);



//if(  document.frm1.TotalCCP.value>=z)

				}else{
					alert('You have exceeded the maximum credit limit of '+ document.frm1.TotalCCP.value);
					document.frm1[n].checked=false;
				}
			}
			else{
				var z=parseInt(document.frm1.TotalCCPAld.value)-parseInt(j);
				document.frm1.TotalCCPAld.setAttribute("value",z);
			}

		}
	}


if(document.frm1["Improvement"+k].value=="Y" && document.frm1[n].checked==true )
			{
//	alert(document.frm1[n].checked);
	alert("click to print receipt for payment after Draft Save");
			return false;
			}
}

function FunRefreshselect(j,k){
	var t=k.substr(6,k.length);
	//alert(parseInt(document.getElementById(k).value)<=parseInt(document.frm1.studelecchoise.value));
	if(document.getElementById(k).value!="" && parseInt(document.getElementById(k).value)<=parseInt(document.frm1.studelecchoise.value)){
		if(document.getElementById("temp"+t).value=='Y'){
			var z=parseInt(document.frm1.TotalCCPAld.value)+parseInt(j);
			if(document.frm1.TotalCCP.value>=z){
				document.frm1.TotalCCPAld.setAttribute("value",z);
				document.getElementById("temp"+t).value='N';
			}else{
				alert('You have exceeded the maximum credit limit of '+document.frm1.TotalCCP.value);
				document.getElementById(k).value="";
			}
		}else{
			//alert("hello");
		}
	}else{

		if(document.getElementById("temp"+t).value=='N'){
			var z=parseInt(document.frm1.TotalCCPAld.value)-parseInt(j);
			document.frm1.TotalCCPAld.setAttribute("value",z);
			document.getElementById("temp"+t).value='Y';
		}
	}
}

function Clickedsel(k,j,c,b,t, check){
	var ttt=0;

//alert(k+"sdfsdf");

//alert(document.frm1.studelecchoise.value+"LLL"+document.frm1.maxValueLmitD.value);


//alert(document.frm1.TCount.value+"sdfsdf");



        if(document.getElementById(c).value==""){
            document.getElementById(check).value="N";
        }else{
            document.getElementById(check).value="Y";
        }

	if(document.frm1.pd==null)
		ttt=0;
	else
		 ttt =document.frm1.pd.value;
	var tt=1,xx=0,uu=0;
	for(i=1;i<=ttt;i++){
		if(document.getElementById("Selectf"+i).value==""){
			tt=0;
			}

	}

	var mTCount=document.frm1.TCount.value;
	for(i=1;i<=mTCount;i++){

		if(document.getElementById("Selectf"+i).value!=""){
			//tt=0;
			xx++;
			//alert(document.getElementById("Select"+i).value+"aaaa");
			}
			else
		{
				uu++;
			//	continue;
		}

	}
//11/4/2011alert(xx+"aaaa");
if(xx>8)
{
alert('Not allowed ,you have already selected 8 electives');
document.getElementById(c).value="";
return false;
}

 /*if(xx<8 )
{
alert('Choice of elective should be minimum 8');
document.getElementById(c).value="";
return false;
}*/


	if(tt==0){
		alert("You have to fill all choices for PD Electives.");
		document.getElementById(c).value="";
		document.getElementById("Selectf").focus();
		return false;
	}else{
		if(document.frm1.studelecchoise.value!=''){
			var c1=document.frm1.studelecchoise.value;
			var c2=document.frm1.minValueD.value;
			var c3=document.frm1.maxValueLmitD.value;
			if(parseInt(c1)<=parseInt(c3)) {
				var i=0;
				var flag=0;
				for( i=1;i<=t;i++){
					if(c!=("Selectf"+i))
						if(document.getElementById(c).value==document.getElementById("Selectf"+i).value){
							flag=1;
						}
					}
					if(flag==1 && document.getElementById(c).value!=""){
						alert('You have already exercise this choice.');
						document.getElementById(c).value="";
						return false;
					}
					else{

							FunRefreshselect(j,c);
					}
			}
			else{
				alert("No. Of Subject should be greater then "+document.frm1.maxValueLmitE.value);
				document.frm1.studelecchoise.value=c3.substr(0,1);

				document.getElementById(c).value="";


				return false;
			}
		}
		else{
			alert("Please Enter elective choise ");
			frm1.studelecchoise.focus();
			document.getElementById(c).value="";
			return false;
		}
	}
}

function Clickedsel1(k,j,c,b,t){
	var ttt=0;

//alert(k+"sdfsdf");

//alert(document.frm1.studelecchoise.value+"LLL"+document.frm1.maxValueLmitD.value);


//alert(document.frm1.TCount.value+"sdfsdf");



	if(document.frm1.pd==null)
		ttt=0;
	else
		 ttt =document.frm1.pd.value;
	var tt=1,xx=0,uu=0;
	for(i=1;i<=ttt;i++){
		if(document.getElementById("Selecth"+i).value==""){
			tt=0;
			}

	}

	var mTCount=document.frm1.TCount.value;
	for(i=1;i<=mTCount;i++){

		if(document.getElementById("Selecth"+i).value!=""){
			//tt=0;
			xx++;
			//alert(document.getElementById("Select"+i).value+"aaaa");
			}
			else
		{
				uu++;
			//	continue;
		}

	}
//11/4/2011alert(xx+"aaaa");
if(xx>8)
{
alert('Not allowed ,you have already selected 8 electives');
document.getElementById(c).value="";
return false;
}

 /*if(xx<8 )
{
alert('Choice of elective should be minimum 8');
document.getElementById(c).value="";
return false;
}*/


	if(tt==0){
		alert("You have to fill all choices for PD Electives.");
		document.getElementById(c).value="";
		document.getElementById("Selecth").focus();
		return false;
	}else{
		if(document.frm1.studelecchoise.value!=''){
			var c1=document.frm1.studelecchoise.value;
			var c2=document.frm1.minValueD.value;
			var c3=document.frm1.maxValueLmitD.value;
			if(parseInt(c1)<=parseInt(c3)) {
				var i=0;
				var flag=0;
				for( i=1;i<=t;i++){
					if(c!=("Selecth"+i))
						if(document.getElementById(c).value==document.getElementById("Selecth"+i).value){
							flag=1;
						}
					}
					if(flag==1 && document.getElementById(c).value!=""){
						alert('You have already exercise this choice.');
						document.getElementById(c).value="";
						return false;
					}
					else{

							FunRefreshselect(j,c);
					}
			}
			else{
				alert("No. Of Subject should be greater then "+document.frm1.maxValueLmitE.value);
				document.frm1.studelecchoise.value=c3.substr(0,1);

				document.getElementById(c).value="";


				return false;
			}
		}
		else{
			alert("Please Enter elective choise ");
			frm1.studelecchoise.focus();
			document.getElementById(c).value="";
			return false;
		}
	}
}


function limit(e){
	var c4=document.frm1.c1.value;
	var c1=document.frm1.studelecchoise.value;
	var c2=document.frm1.minValueD.value;
	var c3=document.frm1.maxValueLmitD.value;
	var ec=document.frm1.electivecount.value;
	var ccp=parseInt(document.frm1.TotalCCP.value);
	var ald=parseInt(document.frm1.TotalCCPAld.value);
	var corecr=parseInt(document.frm1.corecrpoint.value);
	var choisept=parseInt(c1)*3;
	var newald= ald+choisept;
	var i=0;
	var ttt =document.frm1.pd.value;
	var tt=1;
	var unicode=e.charCode? e.charCode : e.keyCode
	if(unicode!=8){
		if (unicode<49||unicode>57){ //if not a number
			document.frm1.studelecchoise.value="0";
			return false
		}else{
			if(ccp<newald){
				alert("Sorry you have't enough credit points");
				document.frm1.studelecchoise.value=c4;
			}else{
				for(i=1;i<=ttt;i++){
					if(document.getElementById("Selectf"+i).value==""){
						tt=0;
					}
				}
				if(tt==0){
					alert("You have to fill all choices for PD Electives.");
					document.frm1.studelecchoise.value=c4;
					document.getElementById("Selectf1").focus();
					return false;
				}else{
					if(!(parseInt(document.frm1.TotalCCP.value)>=(corecr+3))){
						alert("Sorry you have't enough credit points");
						document.frm1.studelecchoise.value=c4;
					}else{
						if(parseInt(c1)>=parseInt(c2) && parseInt(c1)<=parseInt(c3)){
							for(i=1;i<=ec;i++){
								document.getElementById("Select"+i).value="";
								document.getElementById("temp"+i).value="Y";
							}
							return false;
						}else{
							alert("No. Of Subject should be greater then "+document.frm1.maxValueLmitE.value);
							document.frm1.studelecchoise.value=c1;
							frm1.studelecchoise.focus();
							for(i=1;i<=ec;i++){
								document.getElementById("Select"+i).value="";
								document.getElementById("temp"+i).value="Y";
							}
							return false;
						}
						return false;
					}
				}
			}
		}
	}
}
function Clickedsel11(k,j,c,b,t,check){
    //alert("K="+k+"j="+j+"c="+c+"B="+b+"t="+t);
	var i=0;
	var flag=0;
		var z=0;
	for( i=1;i<=t;i++){
        //alert("c="+c+"i="+i);
        //alert(document.getElementById(c).value+"---"+document.getElementById("Selectf"+i).value);
        if(document.getElementById(c).value==""){
            document.getElementById(check).value="N";
        }else{
            document.getElementById(check).value="Y";
        }
		if(c!=(b+i))
        //    alert(document.getElementById(c).value+"---"+document.getElementById("Selectf"+i).value);
            if(document.getElementById(c).value==document.getElementById(b+i).value){
				flag=1;
                alert("flag="+flag);
			}
	}
	if(flag==1 && document.getElementById(c).value!=""){
		alert('You have already exercise this choice.');
		document.getElementById(c).value="";
		return false;
	}
	else{
        var tt=c.substr(b.length, c.length);
		if(document.getElementById("temp1"+tt).value=='Y')	{
			 z=parseInt(document.frm1.TotalCCPAld.value)+parseInt(j);

		//alert(document.frm1.TotalCCP.value +" -- "+z+" ==== "+document.frm1.TotalCCPAld.value+" \\\\ "+j);


			if(document.frm1.TotalCCP.value>=z){
				document.frm1.TotalCCPAld.setAttribute("value",z);
				for( i=1;i<=t;i++){
					document.getElementById("temp1"+i).value='N';
					document.frm1.pdvalue.value="Y";
				}
			}else{
				alert('You have exceeded the maximum credit limit of  '+document.frm1.TotalCCP.value);
				document.getElementById(c).value="";
			}
		}else if(document.getElementById(c).value=="" && document.getElementById(b).value=="") {
			var z=parseInt(document.frm1.TotalCCPAld.value)-parseInt(j);
			document.frm1.TotalCCPAld.setAttribute("value",z);
			for( i=1;i<=t;i++){
				document.getElementById("temp1"+i).value='Y';
			}
		}
	}
}
function finalsave(){


	var cr=document.frm1.TotalCCPAld.value;
	var total=document.frm1.TotalCCP.value;
	var t=0;
	if(document.frm1.pd==null)
		t=0;
	else
		t =document.frm1.pd.value;
	var ec=document.frm1.electivecount.value;
	var tt=1;
	var ttt=1;
	var tttt=1;
	var last=document.frm1.last.value;
	var chkb=parseInt(last)-parseInt(t)-parseInt(ec);
	var corecr=parseInt(document.frm1.corecrpoint.value);
	//alert(corecr);
	var backcr=parseInt(document.frm1.backcr.value);
	//alert(backcr);
	var c =document.frm1.studelecchoise.value;



	//-------------------ankur 09/11/2011
	var mTCount=document.frm1.TCount.value;
		//alert(mTCount+"sds");
if(mTCount>8)
	{

		var yy=0;
	for(i=1;i<=mTCount;i++){
//alert(document.getElementById("Select"+i).value+"aaaa");
		if(document.getElementById("Select"+i).value!="" || document.getElementById("Select"+i).value!=''){
			//tt=0;
			yy++;
			}
	}
//alert(yy+"aaaa");
 if(yy<8 )
{
alert('Choice of elective should be minimum 8');
//document.getElementById(c).value="";
return false;
}
if(yy>8)
{
alert('Not allowed ,you have already selected 8 electives');
//document.getElementById(c).value="";
return false;
}
	}
	//-------------------ankur 09/11/2011


	if(parseInt(corecr)>=parseInt(total)){
	}else
	if(t==0 && ec==0){

		if(parseInt(total)<parseInt(corecr)){
			alert('You have exceeded the maximum credit limit of '+document.frm1.TotalCCP.value);
			return false;
		}


	}
	else{
		for(i=1;i<=chkb;i++){
			if(document.frm1["CHK"+i].checked==false){
				tttt=0;
			}
		}
		if(tttt==0 && parseInt(corecr)+1<parseInt(total)){
			alert("Please select Core subject first" );
			return false;
		}else
		if(parseInt(cr)+3<=total){
			for(i=1;i<=t;i++){
				if(document.getElementById("Selectf"+i).value==""){
					tt=0;
				}
			}
			if(tt==0){
				alert("You have to fill all choices for PD Electives.");
				return false;
			}
			for(i=1;i<=ec;i++){
				if(document.getElementById("Select"+i).value==""){
					ttt=0;
				}
			}


	//-------------------ankur 09/11/2011
	if(mTCount<8)
	{
		if(c!=0 && ttt==0){
				alert("Please allocate preference to all Listed Elective(s)");
				return false;
			}
	}

		}
		for(i=1;i<=t;i++){
			if(document.getElementById("Selectf"+i).value!=""){
				++tt;
			}
		}
		if((tt-1)!=(t) ){
			
			alert("Please allocate preference to all Listed Elective(PD)"+tt +"and "+t);
			return false;
		}
		for(i=1;i<=ec;i++){
			if(document.getElementById("Select"+i).value==""){
				ttt=0;
			}
		}
		/*if(c!=0 && ttt==0 ){
			alert("Please allocate preference to all Listed Elective(s)");
			return false;
		}*/
	}
	var op=0;
	var kk=document.frm1.minlimt.value;

	if(t==0)
		op=(parseInt(c)*3)+corecr;
	else
		op=(parseInt(c)*3)+corecr+3;

	//alert(parseInt(op)+"sdsds"+corecr+"sss"+c+"document.frm1.minlimt.value"+document.frm1.minlimt.value);

	if(parseInt(op)<parseInt(document.frm1.minlimt.value) ) {
		alert('As per Curriculum Structure you Minimum Corurse Credit Point must be '+kk+' whereas your Total calculated Course Credit Point is '+op+' only.');
		return false;
	}
    //if(parseInt(document.frm1.minlimt.value)>parseInt(cr)){
	//		alert('You have to select the credit limit of '+document.frm1.minlimt.value);
	//		return false;
	//	}
    }

function onLoadfun() {
	if(document.frm1!=null) {
		var cr=document.frm1.TotalCCPAld.value;
		var total=document.frm1.TotalCCP.value;
		var t=0;

		if(document.frm1.pd==null)
			t=0;
		else
			t =document.frm1.pd.value;
		var ec=document.frm1.electivecount.value;
		var last=document.frm1.last.value;
		var c =document.frm1.studelecchoise.value;
		var chkb=parseInt(last)-parseInt(t)-parseInt(ec);
		var corecr=document.frm1.corecrpoint.value;

		if(parseInt(total)<(parseInt(corecr)+3)){
			for(i=1;i<=t;i++){

				if(document.getElementById("Selectf"+i).value=="")
					document.getElementById("Selectf"+i).disabled=true;
			}
		}
		if(parseInt(total)<(parseInt(corecr)+6) && c=='0'){
			document.frm1.studelecchoise.disabled=true;
			for(i=1;i<=ec;i++){
				//alert(total+"sdfsdf"+(parseInt(corecr)+6));
				document.getElementById("Select"+i).disabled=true;
			}
		}
		test();
	}
}
function test(){
	var t=0;
	if(document.frm1.pd==null)
		t=0;
	else
		t =document.frm1.pd.value;
	var ec=document.frm1.electivecount.value;

	if(document.frm1.mSem.value=='8'){
		var cr=parseInt(document.frm1.TotalCCPAld.value);
		var corecr=parseInt(document.frm1.corecrpoint.value);
		var total=parseInt(document.frm1.TotalCCP.value);
		var points=document.frm1.studelecchoise.value;
		var c2=document.frm1.minValueD.value;
		var c3=document.frm1.maxValueLmitD.value;
	//	alert(c2+"total"+c3);
		var u=0;
		if(corecr==total && points=='0'){
			document.frm1.studelecchoise.value="0";
		}
		if((corecr+3)>=total && points=='0'){
			document.frm1.studelecchoise.value="0";
		}else if( points=='0') {
			if(t==0)
				u=(total-(corecr))/3;
			else
				u=(total-(corecr+3))/3;
			if(u<=c3)
				document.frm1.studelecchoise.value=parseInt(u);
			else
				document.frm1.studelecchoise.value=parseInt(c3);
		}
	}
//-------------------ankur 09/11/2011
if(document.frm1.mProg.value=='M.T')
	{
	var cr=parseInt(document.frm1.TotalCCPAld.value);
		var corecr=parseInt(document.frm1.corecrpoint.value);
		var total=parseInt(document.frm1.TotalCCP.value);
		var points=document.frm1.studelecchoise.value;
		var c2=document.frm1.minValueD.value;
		var c3=document.frm1.maxValueLmitD.value;
	//	alert(c2+"total"+c3);
		var u=0;
		if(corecr==total && points=='0'){
			document.frm1.studelecchoise.value="0";
		}
		if((corecr+3)>=total && points=='0'){
			document.frm1.studelecchoise.value="0";
		}else if( points=='0') {
			if(t==0)
				u=(total-(corecr))/3;
			else
				u=(total-(corecr+3))/3;
			if(u<=c3)
				document.frm1.studelecchoise.value=parseInt(u);
			else
				document.frm1.studelecchoise.value=parseInt(c3);
		}
	}


if(document.frm1.mProg.value=='DUAL' && document.frm1.mSem.value=='11')
	{
	var cr=parseInt(document.frm1.TotalCCPAld.value);
		var corecr=parseInt(document.frm1.corecrpoint.value);
		var total=parseInt(document.frm1.TotalCCP.value);
		var points=document.frm1.studelecchoise.value;
		var c2=document.frm1.minValueD.value;
		var c3=document.frm1.maxValueLmitD.value;
	//	alert(c2+"total"+c3);
		var u=0;
		if(corecr==total && points=='0'){
			document.frm1.studelecchoise.value="0";
		}
		if((corecr+3)>=total && points=='0'){
			document.frm1.studelecchoise.value="0";
		}else if( points=='0') {
			if(t==0)
				u=(total-(corecr))/3;
			else
				u=(total-(corecr+3))/3;
			if(u<=c3)
				document.frm1.studelecchoise.value=parseInt(u);
			else
				document.frm1.studelecchoise.value=parseInt(c3);
		}
	}
	//-------------------ankur 09/11/2011

//	alert(document.frm1.mProg.value+"sdfsdf"+document.frm1.mSem.value);

//alert(document.frm1.studelecchoise.value+"sdfsdf"+ec);

	if(document.frm1.studelecchoise.value=='0'){
	//	alert(document.frm1.studelecchoise.value+"sdfsdf"+ec);
		document.frm1.studelecchoise.disabled=true;
		for(i=1;i<=ec;i++){
			document.getElementById("Select"+i).disabled=true;
		}
	}
	var op=document.frm1.studelecchoise.value;
	//alert(op+"OP");
	var test=0;
	if(t==0)
		test=(parseInt(op)*3)+corecr;
	else
		test=(parseInt(op)*3)+corecr+3;
	if(test<parseInt(document.frm1.minlimt.value)){
		alert('As per Curriculum Structure you Minimum Corurse Credit Point must be '+document.frm1.minlimt.value+' whereas your Total calculated Course Credit Point is '+test+' only.');
	}
}



 </SCRIPT>

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>



</head>

<body topmargin=0 rightmargin=0 leftmargin=10 bottommargin=0 bgcolor=#fce9c5  onLoad="onLoadfun();">
<cenTer>
<%
String mSEMESTER="", mSname="";
String mBranch="", mAcad="";
String mInst="", mComp="", mWebEmail="";
int mSem=0, mSno=0, mChoice=1, mTot=0;
String mySect="";
String mFELFinal="N", mCoreFinal="N";
int mSemester=0;
String mSemType="", mSubjType="", mSubjTypeDesc="", mSubjId="", mSubjName="", mBasket="";
String mColor="white";
String mCol1="lightyellow";
String mElecCode="", OldmELECTIVECODE="",mELECTIVECODE="";
String mCol2="#F8F8F8";

if (session.getAttribute("WebAdminEmail")==null)
{
	mWebEmail="";
}
else
{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
}

try
{
OLTEncryption enc=new OLTEncryption();
if (session.getAttribute("MemberID")!=null && session.getAttribute("MemberCode")!=null)
{//out.print(enc.decode(session.getAttribute("MemberID").toString()));
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  	//-----------------------------
	//-- Enable Security Page Level
	//-----------------------------
	qry="Select WEBKIOSK.ShowLink('52','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	//if (1==1)
	if(RsChk.next() && RsChk.getString("SL").equals("Y"))
	{

	mComp=session.getAttribute("CompanyCode").toString().trim();
	mInst=session.getAttribute("InstituteCode").toString().trim();
	mDID=enc.decode(session.getAttribute("MemberID").toString().trim());


qry=" SELECT distinct examcode, regcode                     FROM preventmaster                    WHERE institutecode = '"+mInst+"'                      AND NVL (prcompleted, 'N') = 'N'                      AND NVL (prbroadcast, 'N') = 'Y'                      AND prrequiredfor = 'S'                      AND NVL (deactive, 'N') = 'N'                      AND TRUNC (SYSDATE) >= TRUNC (fromdate)                      AND TRUNC (SYSDATE) <= TRUNC (endate)";
	rs=db.getRowset(qry);
	//out.print(qry);
	if (rs.next())
		mExam=rs.getString(1);


	qry=" Select distinct nvl(STUDENTID, ' ') STUDENTID, nvl(PROGRAMCODE,' ') PROGRAMCODE,nvl(BRANCHCODE,' ') BRANCHCODE, ";
	qry=qry+" SEMESTER SEMESTER, TaggingFor, ACADEMICYEAR, SECTIONBRANCH from ";
	qry=qry+" STUDENTREGISTRATION where  StudentID='" +mDID+ "' and examcode='"+mExam+"' and  InstituteCode='" + mInst + "'  and semestertype <>'GIP'  and ";
	qry=qry+" (EXAMCODE,REGCODE) in (SELECT  ExamCode,REGCODE from PREVENTMASTER WHERE INSTITUTECODE='" + mInst +"' ";
	qry=qry+" and nvl(PRCOMPLETED,'N')='N' and nvl(PRBROADCAST,'N')='Y' and PRREQUIREDFOR='S'";
	qry=qry+" AND NVL(DEACTIVE,'N')='N' AND  trunc(sysdate) >= trunc(FROMDATE)            and trunc(sysdate) <= trunc(ENDATE) ) and ";
	qry=qry+"  STUDENTID IN (SELECT MemberID FROM PREVENTS WHERE INSTITUTECODE='"+ mInst +"' and nvl(SSTPOPULATED,'N')='N'";
	qry=qry+" AND (PREVENTCODE) IN (SELECT  PREVENTCODE from PREVENTMASTER WHERE INSTITUTECODE='" + mInst +"'";
	qry=qry+" and ExamCode='"+mExam+"'  and nvl(PRCOMPLETED,'N')='N' and nvl(PRBROADCAST,'N')='Y' and PRREQUIREDFOR='S'";
	qry=qry+" AND NVL(DEACTIVE,'N')='N') and MEMBERTYPE='S' and MEMBERID='"+mDID+"'";
	qry=qry+" AND  trunc(sysdate) >= trunc(eventfrom) and trunc(sysdate) <= trunc(eventto) and nvl(DEACTIVE,'N')='N')";
	rs=db.getRowset(qry);
//	out.print(qry);
///out.print("sdfsfsafasdf");
	if (rs.next())
	{
		mSEMESTER=rs.getString("SEMESTER");
		//mSem=rs.getInt("SEMESTER")+1;

//--------------------Changed by Vijay---------------
		mSem=rs.getInt("SEMESTER");
//--------------------Changed by Vijay---------------

		mSname=session.getAttribute("MemberName").toString().trim();

		mSCode=enc.decode(session.getAttribute("MemberCode").toString().trim());
		mProg=rs.getString("PROGRAMCODE");
		mBranch=rs.getString("BRANCHCODE");
		mSect=rs.getString("SECTIONBRANCH");
		mTag=rs.getString("TaggingFor");
		mAcad=rs.getString("ACADEMICYEAR");
		mySect=mSect;

			qry="Select distinct Semester, SEMESTERTYPE, SUBJECTTYPE, SUBJECTID,  Subj, COURSECREDITPOINT COURSECREDITPOINT, nvl(BASKET,' ')BASKET";
			qry=qry+" from (";
                                qry=qry+" (Select distinct A.Semester, 'RWJ' SEMESTERTYPE, 'C' SUBJECTTYPE, A.SubjectID, C.Subject||' ('||C.SubjectCode||')' Subj,B.COURSECREDITPOINT , nvl(B.BASKET,' ')BASKET  From STUDENTRESULT A, ProgramSubjectTagging B, SubjectMaster C ";
                                qry=qry+" where A.institutecode='"+mInst +"' And A.studentid= '"+mChkMemID+"' And   A.InstituteCode=B.InstituteCode And  B.ExamCode='"+mExam+"' ";
                                qry=qry+" and A.grade='"+mFailGraders+"' And A.semester< "+(mSem-1)+" AND B.BASKET='A' AND A.institutecode=C.institutecode and A.subjectID=B.subjectID And A.subjectID=C.subjectID)";
		       qry=qry+" union ";
			 qry=qry+" (Select distinct A.Semester, 'RWJ' SEMESTERTYPE, 'C' SUBJECTTYPE, A.SubjectID, C.Subject||' ('||C.SubjectCode||')' Subj,B.COURSECREDITPOINT , nvl(B.BASKET,' ')BASKET  From STUDENTRESULT A, OfferSubjectTagging B, SubjectMaster C ";
                   qry=qry+" where A.institutecode='"+mInst +"' And A.studentid= '"+mChkMemID+"' And   A.InstituteCode=B.InstituteCode And B.ExamCode='"+mExam+"' ";
                   qry=qry+" and A.grade='"+mFailGraders+"' And A.semester< "+(mSem-1)+" AND B.BASKET='A' AND A.institutecode=C.institutecode and A.subjectID=B.subjectID And A.subjectID=C.subjectID)";

                   qry=qry+" union ";
                                qry=qry+" (select distinct C.semester Semester, 'SAP' SemesterType,nvl(C.SUBJECTTYPE,'C') SUBJECTTYPE, C.SUBJECTID SUBJECTID, B.Subject||' ('||B.SubjectCode||')' SUBJECT, A.COURSECREDITPOINT COURSECREDITPOINT, nvl(C.BASKET,'A')BASKET from NRSTUDENTFAILSUBJECTS C,SUBJECTMASTER B,ProgramSubjectTagging A";
					  qry=qry+"  where C.institutecode='"+mInst+"'  and nvl(c.CURRENTEXAM,'N')<>'"+mExam+"' And B.institutecode=C.institutecode And C.studentid= '"+mChkMemID+"' And B.SubjectID=C.SubjectID   And nvl(C.REGISTEREXAMCODE,'"+mExam+"')='"+mExam+"' ";
                                qry=qry+"  and C.semester<="+(mSem-1)+" AND C.BASKET IN ('A') ";
					  qry=qry+"  And a.INSTITUTECODE=B.INSTITUTECODE and C.INSTITUTECODE=a.INSTITUTECODE And a.EXAMCODE='"+mExam+"' and a.SUBJECTID=C.SUBJECTID ) ";
                   qry=qry+" union ";
			 qry=qry+" (select distinct C.semester Semester, 'SAP' SemesterType,nvl(C.SUBJECTTYPE,'C') SUBJECTTYPE, C.SUBJECTID SUBJECTID, B.Subject||' ('||B.SubjectCode||')' SUBJECT, A.COURSECREDITPOINT COURSECREDITPOINT, nvl(C.BASKET,'A')BASKET from NRSTUDENTFAILSUBJECTS C,SUBJECTMASTER B,OfferSubjectTagging A";
					  qry=qry+"  where C.institutecode='"+mInst+"'  and nvl(c.CURRENTEXAM,'N')<>'"+mExam+"' And B.institutecode=C.institutecode And C.studentid= '"+mChkMemID+"' And B.SubjectID=C.SubjectID   And nvl(C.REGISTEREXAMCODE,'"+mExam+"')='"+mExam+"' ";
                                qry=qry+"  and C.semester<="+(mSem-1)+" AND C.BASKET IN ('A') ";
					  qry=qry+"  And a.INSTITUTECODE=B.INSTITUTECODE and C.INSTITUTECODE=a.INSTITUTECODE And a.EXAMCODE='"+mExam+"' and a.SUBJECTID=C.SUBJECTID ) ";

                 qry=qry+" union ";
                                qry=qry+" (select distinct C.semester Semester, 'RWJ' SemesterType,'E' SUBJECTTYPE, C.SUBJECTID SUBJECTID, B.Subject||' ('||B.SubjectCode||')'||'***'||nvl(A.ELECTIVECODE,' ') SUBJECT, A.COURSECREDITPOINT COURSECREDITPOINT, nvl(A.BASKET,'D')BASKET from PR#ELECTIVESUBJECTS A,SUBJECTMASTER B, STUDENTRESULT C";
								qry=qry+"  where A.institutecode='"+mInst+"'  And A.institutecode=C.institutecode And C.studentid= '"+mChkMemID+"' And C.grade='"+mFailGraders+"' And A.ExamCode='"+mExam+"' And A.SubjectID=C.SubjectID  ";
                                qry=qry+"  and C.semester<"+(mSem-1)+" AND A.BASKET IN ('B','D') AND A.institutecode=B.institutecode and A.subjectID=B.subjectID ) ";
                                qry=qry+"  union ";
                                qry=qry+" (select distinct C.semester Semester, 'RWJ'  SEMESTERTYPE, decode(nvl(A.BASKET,'A'),'A','C','E') SUBJECTTYPE, C.SUBJECTID SUBJECTID, B.Subject||' ('||B.SubjectCode||')' SUBJECT, A.COURSECREDITPOINT COURSECREDITPOINT, nvl(A.BASKET,'A')BASKET from OFFERSUBJECTTAGGING A,SUBJECTMASTER B, STUDENTRESULT C";
                                qry=qry+"  where A.institutecode='"+mInst+"'  And A.institutecode=B.institutecode And C.studentid= '"+mChkMemID+"' And C.grade='"+mFailGraders+"' And A.ExamCode='"+mExam+"' And A.SubjectID=C.SubjectID  ";
								qry=qry+"  and C.semester<"+(mSem-1)+"  AND A.institutecode=c.institutecode and A.subjectID=B.subjectID ) ";        qry=qry+"UNION (select distinct A.semester Semester, 'REG' SEMESTERTYPE, 'E' SUBJECTTYPE, A.SUBJECTID SUBJECTID, B.Subject||' ('||B.SubjectCode||')'||'***'||nvl (A.ELECTIVECODE,' ') SUBJECT, A.COURSECREDITPOINT COURSECREDITPOINT, nvl(A.BASKET,'D')BASKET from PR#ELECTIVESUBJECTS A,SUBJECTMASTER B";
                                qry=qry+" where A.institutecode='"+mInst+"' and A.Academicyear='"+mAcad+"' and A.programcode='"+mProg+"' and A.TAGGINGFOR='"+mTag+"' AND A.SECTIONBRANCH='"+mySect+"' ";
                                qry=qry+" and A.semester="+mSem+" AND A.BASKET in ('B','D','E') AND A.institutecode=B.institutecode and A.subjectID=B.subjectID))";
                                qry=qry+" order by SUBJECTTYPE, Subj";
					  //query changed add AND A.BASKET in ('B','D','E') in place of AND A.BASKET in ('B','D')
//out.print(qry);
		rse1=db.getRowset(qry);
		if(rse1.next())
		{

			qry="SELECT MINCREDITPOINT MINCRPT, MAXCREDITPOINT MAXCRPT FROM PR#PROGRAMMINMAXCP WHERE INSTITUTECODE='"+mInst+"' AND (EXAMCODE,REGCODE) in ";
			qry=qry+" (SELECT  ExamCode,REGCODE from PREVENTMASTER WHERE INSTITUTECODE='"+mInst+"' and nvl(PRCOMPLETED,'N')='N' and nvl(PRBROADCAST,'N')='Y' and PRREQUIREDFOR='S' AND NVL(DEACTIVE,'N')='N' and  examcode='"+mExam+"')";
			qry=qry+" AND ACADEMICYEAR='"+mAcad+"' AND PROGRAMCODE='"+mProg+"' AND TAGGINGFOR='"+mTag+"' AND SECTIONBRANCH='"+mySect+"' AND SEMESTER='"+mSem+"' AND NVL(DEACTIVE,'N')='N'";

//out.print(qry+"ddd");
		   rsso=db.getRowset(qry);
		   if(rsso.next())
		   {
			mMinCrLmt=rsso.getDouble(1);
			mMaxCrLmt=rsso.getDouble(2);
//			out.println(mMaxCrLmt);
		   }
	/*********************************************/
	qry="SELECT MINSUBJECT MINSUBJECT, MAXSUBJECT MAXSUBJECT FROM basketmaster WHERE INSTITUTECODE='"+mInst+"'  ";
	qry=qry+" AND ACADEMICYEAR='"+mAcad+"' AND PROGRAMCODE='"+mProg+"' AND TAGGINGFOR='"+mTag+"' AND SECTIONBRANCH='"+mySect+"' AND SEMESTER="+mSem+" and basket='D' ";
	//out.println(qry);
	rs=db.getRowset(qry);
	if(rs.next())
	{
		mMinBasketD=rs.getDouble(1);
		mMaxBasketD=rs.getDouble(2);
		//out.println(mMaxBasketD);
	}
	else
	{
		mMinBasketD=0;
		mMaxBasketD=0;
	}
/*add for basket 'E'*/
	qry="SELECT MINSUBJECT MINSUBJECT, MAXSUBJECT MAXSUBJECT FROM basketmaster WHERE INSTITUTECODE='"+mInst+"'  ";
	qry=qry+" AND ACADEMICYEAR='"+mAcad+"' AND PROGRAMCODE='"+mProg+"' AND TAGGINGFOR='"+mTag+"' AND SECTIONBRANCH='"+mySect+"' AND SEMESTER="+mSem+" and basket='E' ";
	//out.println(qry);
	rs=db.getRowset(qry);
	if(rs.next())
	{
		mMinBasketE=rs.getDouble(1);
		mMaxBasketE=rs.getDouble(2);
		//ln(mMaxBasketD);
	}
	else
	{
		mMinBasketE=0;
		mMaxBasketE=0;
	}
/********************************/

		   qry= " select nvl(ELRNNINGFINALIZEDBYHOD,'N') EL from PREVENTS where INSTITUTECODE='"+mInst+"' ";
		   qry= qry + " And nvl(SSTPOPULATED,'N')='N' AND (PREVENTCODE) IN (SELECT  PREVENTCODE from PREVENTMASTER WHERE INSTITUTECODE='" + mInst +"'";
		   qry= qry + " and ExamCode='"+mExam+"'  and nvl(PRCOMPLETED,'N')='N' and nvl(PRBROADCAST,'N')='Y' and PRREQUIREDFOR='E'";
		   qry= qry + " AND NVL(DEACTIVE,'N')='N') and MEMBERTYPE='E' " ;
		   qry= qry + "  and MEMBERID in (select EMPLOYEEID from HODLIST where DEPARTMENTCODE in (select DEPARTMENTCODE from BRANCHDEPTTAGGING where ";
		   qry= qry + " ACADEMICYEAR='"+mAcad+"' and PROGRAMCODE='"+mProg+"' and TAGGINGFOR='"+mTag+"' ";
		   qry= qry + " and SECTIONBRANCH='"+mySect+"' and nvl(DEACTIVE,'N')='N' ) ) ";
	   	   rsso=db.getRowset(qry);
		//	out.print(qry);

 if(rsso.next())
  {
   if(!rsso.getString("EL").equals("Y") && !mCoreFinal.equals("Y") && !mFELFinal.equals("Y"))
   {
	qry=" Select nvl(SENDTOHOD,'N') SENDTOHOD,PREVENTCODE PREVENTCODE,nvl(NOOFELESUBJECTSCHOICES,'0')NOOFELESUBJECTSCHOICES FROM PREVENTS";
	qry=qry+" WHERE INSTITUTECODE='"+ mInst +"' and nvl(SSTPOPULATED,'N')='N' and nvl(ELRNNINGFINALIZEDBYHOD,'N')='N' and nvl(APPROVED,'N')='N' and nvl(LOADDISTRIBUTIONSTATUS,'N') not in ('F','A') AND (PREVENTCODE) IN (SELECT  PREVENTCODE from PREVENTMASTER WHERE INSTITUTECODE='" + mInst +"'";
qry=qry+" And ExamCode='"+mExam+"' And nvl(FREEELECTIVERUNFINALIZED,'N')='N' and nvl(PRCOMPLETED,'N')='N' and nvl(PRBROADCAST,'N')='Y' and PRREQUIREDFOR='S'";
qry=qry+" AND NVL(DEACTIVE,'N')='N') and MEMBERTYPE='S' and MEMBERID='"+mDID+"'";
qry=qry+" and trunc(sysdate) between trunc(EVENTFROM) and trunc(EVENTTO) and nvl(DEACTIVE,'N')='N'";
rss1=db.getRowset(qry);
//out.print(qry);
 	if(!rss1.next())
	    		{

				%>
				<P><br><br><br><font size=4 color=red>Event period is already completed or Pre Reg. event has not been declared for you!</font>
				<P><font size=4>Check/View <a href="PRStudentView.jsp">Pre-registration detail</a>, your opted Subjects </font><br><br><br><br><br><br><hr><br>
				<%
			}
		      else if(rss1.getString("SENDTOHOD").equals("Y"))
			{
				%>
				<P><br><br><br><font size=4 color=red>You have already submitted your choice earlier for the required semester</font>
				<P> <font size=4>Check/View <a href="PRStudentView.jsp">Pre-registration detail</a>, your opted Subjects </font><br><br><br><br><br><br><hr><br>
				<%
			}
			else
	      	{
				mPrcode=rss1.getString("PREVENTCODE");
				eee=rss1.getInt("NOOFELESUBJECTSCHOICES");

				//action="PRStudentAction.jsp"
				%>
				<form name="frm1" method=post action="PRStudentAction_dual.jsp">
				<table border=1 bgcolor=#fce9c5 class="sort-table" id="table-1"  cellspacing=0 width='100%' >
				<thead>

				<input Type=hidden id=minValue name=minValueD value=<%=mMinBasketD%>>
				<input Type=hidden id="maxValueLmit" name="maxValueLmitD" value=<%=mMaxBasketD%>>
				<input Type=hidden id=minValue name=minValueE value=<%=mMinBasketE%>>
				<input Type=hidden id="maxValueLmit" name="maxValueLmitE" value=<%=mMaxBasketE%>>
				<tr bgcolor="#ff8c00">
				<td colspan=3 align=center>
				<input Type=hidden id=mExam name=mExam value=<%=mExam%>>
				<input Type=hidden id=mSem name=mSem value=<%=mSem%>>
				<input Type=hidden id=mProg name=mProg value=<%=mProg%>>
				<input Type=hidden id=mSname name=mSname value=<%=mSname%>>
				<input Type=hidden id=mBranch name=mBranch value=<%=mBranch%>>
				<input Type=hidden id=mSect name=mSect value=<%=mySect%>>
				<input Type=hidden id=mTag name=mTag value=<%=mTag%>>
				<input Type=hidden id=mAcad name=mAcad value=<%=mAcad%>>

				<font color=white size=3>STUDENT PRE REGISTRATION/SUBJECT-CHOICE ENTRY SCREEN</font>



				</td>
				</tr>
				</thead>
				<tr>
			     	<td colspan=2><FONT face=Arial size=2 color=black><STRONG>Student Name - </STRONG></FONT><FONT face=verdana size=2 color=black><%=GlobalFunctions.toTtitleCase(mSname)%> (<%=mSCode%>)</td>
				<!-- <td><FONT face=Arial size=2 color=black><STRONG>Institute Code &nbsp; </STRONG></FONT><select name=InstCode id=InstCode><option value='<%=mInst%>'><%=mInst%></option></select></td> -->
				</tr>
				<tr>
				 <td>
				  &nbsp; &nbsp; &nbsp;
				 <FONT face=Arial size=2 color=black><STRONG>Exam Code -	</STRONG></FONT><select name=ExamCode id=ExamCode><option value=<%=mExam%>><%=mExam%></option></select>
				 &nbsp;&nbsp;  &nbsp;  &nbsp;

				 <FONT face=Arial size=2 color=black><STRONG>Pre Registration for Semester </STRONG></FONT><select name=sem id=sem><option value=<%=String.valueOf(mSem)%>><%=mSem%></option></select></td>
				<!-- <td><FONT face=Arial size=2 color=black><STRONG>Academic Year </STRONG></FONT><select name=AcadYear id=AcadYear><option value='<%=mAcad%>'><%=mAcad%></option></select></td>
				<td><FONT face=Arial size=2 color=black><STRONG>Program Code &nbsp;</STRONG></FONT><select id=ProgCode Name=ProgCode><option value='<%=mProg%>'><%=mProg%></option></select></td>  -->
			    	</tr>
				<tr>
				<!-- <td><FONT face=Arial size=2 color=black><STRONG>Section Code &nbsp;&nbsp; </STRONG></FONT><select name=Sect id=Sect><option Value='<%=mySect%>'><%=mySect%></option></select> -->
				<!--
				<FONT face=Arial size=2 color=black><STRONG>SubSection Code &nbsp;&nbsp; </STRONG></FONT><Select Name=SubSect id=SubSect><option value='<%=mSubSect%>'><%=mSubSect%></option></select>
				-->
				<!-- <td><FONT face=Arial size=2 color=black><STRONG>Tagging For  &nbsp;&nbsp;  &nbsp; </STRONG></FONT><select Name=TaggingFor id=TaggingFor><option Value='<%=mTag%>'><%=mTag%></option></td> -->
				</tr>
				<!--<tr>
				<td colspan=3 align="center">
				<a href="BackLogSubjectsList.jsp" ><b>My All backlog papers/subjects (if any)</b></a>

				</td></tr>-->
				<tr>
				<td colspan=3 align="left">
				<%




				%>




				<% //This is for semester for which preregistrtion is not done
				//if(mSem==8){
				%>
				<!-- <FONT face=Arial size=2 color=black><STRONG>How many elective(s) you want to opt:</STRONG></FONT>&nbsp;&nbsp;
				<input type="test" name="studelecchoise" value="<%=rss1.getString("NOOFELESUBJECTSCHOICES")%>" maxlength='2' size='2'  onKeyup="return limit(event);" onkeydown="if(event.keyCode==13){event.keyCode=9;return event.keyCode}" > -->
				<%
				//}else{%>
				<!-- <FONT face=Arial size=2 color=black><STRONG>No. of elective(s) allowed as per curriculum structure/Maximum credit Limit:
</STRONG></FONT>&nbsp;&nbsp; -->
				<input  type="hidden" name="studelecchoise" value="<%=rss1.getString("NOOFELESUBJECTSCHOICES")%>" maxlength='2' size='2'  readonly>

				<%
		//	}%><INPUT TYPE="hidden" NAME="c1" value="<%=rss1.getString("NOOFELESUBJECTSCHOICES")%>">
				</td>



				</tr>
				<tr>
				<td colspan=3>
				<table bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=columns topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center width="100%">
				<thead>
				<tr bgcolor="#ff8c00">
				<td><font color=white face=arial size=2><b>SrNo<b></font></td>
				<td colspan=2 align=center><font color=white face=arial size=2><b>Subject Type<b></font></td>
				<td><font color=white face=arial size=2><b>Subject (Subject Code)<b></font></td>
				<td title="Cource Credit Point"><font color=white face=arial size=2><b>Credit<b></font></td>
				<td><font color=white face=arial size=2><b>Choice<b></font></td>
				</tr>
				</thead>
				<tbody>
				<%

//-----------------------------------------------------
//------START OF BACK CORE, ELECTIVE & FREEELECTIVE----
//-----------------------------------------------------


				qry="Select distinct Semester, SEMESTERTYPE, SUBJECTTYPE, SUBJECTID,  Subj, COURSECREDITPOINT COURSECREDITPOINT, nvl(BASKET,' ')BASKET";
				qry=qry+" from (";
				qry=qry+" (Select distinct A.Semester, 'RWJ' SEMESTERTYPE, 'C' SUBJECTTYPE, A.SubjectID, C.Subject||' ('||C.SubjectCode||')' Subj,B.COURSECREDITPOINT , nvl(B.BASKET,' ')BASKET  From STUDENTRESULT A, ProgramSubjectTagging B, SubjectMaster C ";
				qry=qry+" where A.institutecode='"+mInst +"' And A.studentid= '"+mChkMemID+"' And  A.InstituteCode=B.InstituteCode And B.ExamCode='"+mExam+"' ";
				qry=qry+" and A.grade='"+mFailGraders+"' And A.semester< "+(mSem-1)+" AND B.BASKET='A' AND A.institutecode=C.institutecode and A.subjectID=B.subjectID And A.subjectID=C.subjectID )"; //and  PROGRAMCODE='"+mProg+"' AND SECTIONBRANCH = '"+mySect+"')";
				qry=qry+" union ";
			 	qry=qry+" (Select distinct A.Semester, 'RWJ' SEMESTERTYPE, 'C' SUBJECTTYPE, A.SubjectID, C.Subject||' ('||C.SubjectCode||')' Subj,B.COURSECREDITPOINT , nvl(B.BASKET,' ')BASKET  From STUDENTRESULT A, OfferSubjectTagging B, SubjectMaster C ";
                   	qry=qry+" where A.institutecode='"+mInst +"' And A.studentid= '"+mChkMemID+"' And   A.InstituteCode=B.InstituteCode And B.ExamCode='"+mExam+"' ";
                   	qry=qry+" and A.grade='"+mFailGraders+"' And A.semester< "+(mSem-1)+" AND B.BASKET='A' AND A.institutecode=C.institutecode and A.subjectID=B.subjectID And A.subjectID=C.subjectID)";
		        	qry=qry+" union ";
                		qry=qry+" (select distinct C.semester Semester, 'SAP' SemesterType,nvl(C.SUBJECTTYPE,'C') SUBJECTTYPE, C.SUBJECTID SUBJECTID, B.Subject||' ('||B.SubjectCode||')' SUBJECT, A.COURSECREDITPOINT COURSECREDITPOINT, nvl(C.BASKET,'A')BASKET from NRSTUDENTFAILSUBJECTS C,SUBJECTMASTER B,ProgramSubjectTagging A";
				qry=qry+"  where C.institutecode='"+mInst+"' and nvl(c.CURRENTEXAM,'N')<>'"+mExam+"'  And B.institutecode=C.institutecode And C.studentid= '"+mChkMemID+"' And B.SubjectID=C.SubjectID   And nvl(C.REGISTEREXAMCODE,'"+mExam+"')='"+mExam+"' ";
                		qry=qry+"  and C.semester<"+(mSem-1)+" AND C.BASKET IN ('A') ";
				qry=qry+"  And a.INSTITUTECODE=B.INSTITUTECODE and C.INSTITUTECODE=a.INSTITUTECODE And a.EXAMCODE='"+mExam+"' and a.SUBJECTID=C.SUBJECTID ) ";
		//change in <= to < in above qry
 qry=qry+" union ";
			 qry=qry+" (select distinct C.semester Semester, 'SAP' SemesterType,nvl(C.SUBJECTTYPE,'C') SUBJECTTYPE, C.SUBJECTID SUBJECTID, B.Subject||' ('||B.SubjectCode||')' SUBJECT, A.COURSECREDITPOINT COURSECREDITPOINT, nvl(C.BASKET,'A')BASKET from NRSTUDENTFAILSUBJECTS C,SUBJECTMASTER B,OfferSubjectTagging A";
					  qry=qry+"  where C.institutecode='"+mInst+"'  and nvl(c.CURRENTEXAM,'N')<>'"+mExam+"' And B.institutecode=C.institutecode And C.studentid= '"+mChkMemID+"' And B.SubjectID=C.SubjectID   And nvl(C.REGISTEREXAMCODE,'"+mExam+"')='"+mExam+"' ";
                                qry=qry+"  and C.semester<="+(mSem-1)+" AND C.BASKET IN ('A') ";
					  qry=qry+"  And a.INSTITUTECODE=B.INSTITUTECODE and C.INSTITUTECODE=a.INSTITUTECODE And a.EXAMCODE='"+mExam+"' and a.SUBJECTID=C.SUBJECTID ) ";

qry=qry+" union ";
				qry=qry+" (select distinct C.semester Semester, 'RWJ' SemesterType,'E' SUBJECTTYPE, C.SUBJECTID SUBJECTID, B.Subject||' ('||B.SubjectCode||')'||'***'||nvl(A.ELECTIVECODE,' ') SUBJECT, A.COURSECREDITPOINT COURSECREDITPOINT, nvl(A.BASKET,'D')BASKET from PR#ELECTIVESUBJECTS A,SUBJECTMASTER B, STUDENTRESULT C";
				qry=qry+"  where A.institutecode='"+mInst+"'  And A.institutecode=C.institutecode And C.studentid= '"+mChkMemID+"' And C.grade='"+mFailGraders+"' And A.ExamCode='"+mExam+"' And A.SubjectID=C.SubjectID  ";
				qry=qry+"  and C.semester<"+(mSem-1)+" AND A.BASKET IN ('B','D','E') AND A.institutecode=B.institutecode and A.subjectID=B.subjectID ) ";
				qry=qry+"  union ";
				qry=qry+" (select distinct C.semester Semester, 'RWJ'  SEMESTERTYPE, decode(nvl(A.BASKET,'A'),'A','C','E') SUBJECTTYPE, C.SUBJECTID SUBJECTID, B.Subject||' ('||B.SubjectCode||')' SUBJECT, A.COURSECREDITPOINT COURSECREDITPOINT, nvl(A.BASKET,'A')BASKET from OFFERSUBJECTTAGGING A,SUBJECTMASTER B, STUDENTRESULT C";
				qry=qry+"  where A.institutecode='"+mInst+"' and nvl(c.deactive,'N')='N' And A.institutecode=B.institutecode And C.studentid= '"+mChkMemID+"' And C.grade='"+mFailGraders+"' And A.ExamCode='"+mExam+"' And A.SubjectID=C.SubjectID  ";
				qry=qry+"  and C.semester<"+(mSem-1)+"  AND A.institutecode=B.institutecode and A.subjectID=B.subjectID ) )";
				qry=qry+" order by SUBJECTTYPE , Subj";


String jk="checked";
//change in query replace AND A.BASKET IN ('B','D') with AND A.BASKET IN ('B','D','E')
				//out.print(qry);
				rs=db.getRowset(qry);
				String mOldSubj="xyz";
				while(rs.next())
				{
				 if(!mOldSubj.equals(rs.getString("SUBJECTID")))
				   {
					mOldSubj=rs.getString("SUBJECTID");
					mSno++;
					mColor="#FFB9B9";
					mSemester=rs.getInt("Semester");
					mSemType=rs.getString("SEMESTERTYPE");
					mSubjType=rs.getString("SUBJECTTYPE");
					mSubjId=rs.getString("SUBJECTID");
					mSubjName=rs.getString("Subj");
					mCourseCrPt=rs.getDouble("COURSECREDITPOINT");
					mBasket=rs.getString("BASKET");
					mTotalCrLmtTkn=mTotalCrLmtTkn+mCourseCrPt;
					if(mSubjType.equals("E"))
					{
						int len=0;
						int pos1=0;
						len=mSubjName.length();
						pos1=mSubjName.indexOf("***");
						mElecCode=mSubjName.substring(pos1+3,len);
						mSubjName=mSubjName.substring(0,pos1);
					}
					mName1="CHK"+String.valueOf(mSno).trim();
					mName2="SEM"+String.valueOf(mSno).trim();
					mName3="SEMTYP"+String.valueOf(mSno).trim();
					mName4="SUBJTYP"+String.valueOf(mSno).trim();
					mName5="SUBJID"+String.valueOf(mSno).trim();
					mName6="SUBJ"+String.valueOf(mSno).trim();
					mName7="CCP"+String.valueOf(mSno).trim();
					mName8="ELCODE"+String.valueOf(mSno).trim();
					mName9="BASKET"+String.valueOf(mSno).trim();
					mName10="CHOICE"+String.valueOf(mSno).trim();
					int flag=0;

					qry="Select 'Y' from PR#STUDENTSUBJECTCHOICE where INSTITUTECODE='"+mInst+"' ";
						qry=qry+" and EXAMCODE='"+mExam+"' and ACADEMICYEAR='"+mAcad+"' and PROGRAMCODE='"+mProg+"' ";
						qry=qry+" and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mySect+"'  ";
						qry=qry+" and STUDENTID='"+mChkMemID+"'  ";
						//out.println(qry);
						rse1212=db.getRowset(qry);
					if(rse1212.next())
						flag=1;
					else
						flag=0;
					if(flag==1){

					qry="Select choice chc from PR#STUDENTSUBJECTCHOICE where INSTITUTECODE='"+mInst+"' ";
					qry=qry+" and EXAMCODE='"+mExam+"' and ACADEMICYEAR='"+mAcad+"' and PROGRAMCODE='"+mProg+"' ";
					qry=qry+" and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mySect+"' and subjectid='"+mSubjId+"' ";
					qry=qry+" and semestertype in ('RWJ','SAP') and STUDENTID='"+mChkMemID+"'  ";
					rse1212=db.getRowset(qry);

						//out.println(qry);
						if(rse1212.next())
						{
							jk="checked";
						}
						else
						{
							jk="";
						}

					}
					else
						jk="checked";
					%>


					<tr bgcolor="<%=mColor%>">
					<td align=center><Font face=arial size=2><%=mSno%>.</font></td>
					<td align=center><Font face=arial size=2>BACKLOG</font></td>
					<%
					if(mSubjType.equals("C"))
						mSubjTypeDesc="CORE";
					else if(mSubjType.equals("E"))
						mSubjTypeDesc="ELECTIVE";
					else if(mSubjType.equals("F"))
						mSubjTypeDesc="FREE ELECTIVE";
					else
						mSubjTypeDesc=" ";

					if(mSubjType.equals("E"))
					{
						%>
						<td align=center><Font face=arial size=2><%=mSubjTypeDesc%> (<%=mElecCode%>)</font></td>
						<%
					}
					else
					{
						%>
						<td align=center><Font face=arial size=2><%=mSubjTypeDesc%></font></td>
						<%
					}
					%>
					<td><Font face=arial size=2><%=mSubjName%></font></td>
					<td align=center><Font face=arial size=2><%=mCourseCrPt%>
					<INPUT TYPE="hidden" NAME="cr<%=mSno%>" value="<%=mCourseCrPt%>">
					</font></td>
					<%

					//out.println(mSubjType);
					if(mSubjType.equals("C"))
					{
						mMaxCrLmtTknbc=mMaxCrLmtTknbc+mCourseCrPt;
						//if(!jk.equals(""))
							mMaxCrLmtTkn=mMaxCrLmtTkn+mCourseCrPt;
						//out.println(mMaxCrLmtTkn+"mMaxCrLmtTkn"+mMaxCrLmt);

						if(mMaxCrLmtTkn<=mMaxCrLmt)
						{
							mMaxCrLmtAld=mMaxCrLmtTkn;
							%>
							<td align=center><input Type=checkbox id='<%=mName1%>' name='<%=mName1%>' value='Y' <%=jk%> onclick="FunMustChoice('<%=mCourseCrPt%>', '<%=mSno%>','<%=mName1%>')"></td>
							<%
								Count++;

						}
						else
						{
						%>
							<td align=center><input Type=checkbox id='<%=mName1%>' name='<%=mName1%>' value='Y' onclick="FunRefresh('<%=mCourseCrPt%>', '<%=mSno%>','<%=mBasket%>','<%=mName1%>')"></td>
							<%Count++;

						}
					}
					else
					{
						%>
						<td align=center><input Type=checkbox id='<%=mName1%>' name='<%=mName1%>' value='Y' onclick="FunRefresh('<%=mCourseCrPt%>', '<%=mSno%>','<%=mBasket%>','<%=mName1%>')"></td>
						<%Count++;

					}
					%>
						<input Type=HIDDEN id='Improvement<%=mSno%>' name='Improvement<%=mSno%>' value='N'>

					<input Type=hidden id='<%=mName2%>' name='<%=mName2%>' value='<%=mSemester%>'>
					<input Type=hidden id='<%=mName3%>' name='<%=mName3%>' value='<%=mSemType%>'>
					<input Type=hidden id='<%=mName4%>' name='<%=mName4%>' value='<%=mSubjType%>'>
					<input Type=hidden id='<%=mName5%>' name='<%=mName5%>' value='<%=mSubjId%>'>
					<input Type=hidden id='<%=mName6%>' name='<%=mName6%>' value='<%=mSubjName%>'>
					<input Type=hidden id='<%=mName7%>' name='<%=mName7%>' value='<%=mCourseCrPt%>'>
					<input Type=hidden id='<%=mName8%>' name='<%=mName8%>' value='<%=mElecCode%>'>
					<input Type=hidden id='<%=mName9%>' name='<%=mName9%>' value='<%=mBasket%>'>
					<input Type=hidden id='<%=mName10%>' name='<%=mName10%>' value='<%=mChoice%>'>


					</tr>
					<%
				  }
				}

//-----------------------------------------------------
//--------END OF BACK CORE, ELECTIVE & FREEELECTIVE----
//-----------------------------------------------------

//--------Back paper

//mFlagstr1="1";
%><INPUT TYPE="hidden" NAME="backcr" value=<%=mMaxCrLmtTknbc%>><%




int mMaxsem=0;
double mMinsem=5.2;

qry1=" SELECT max(semester)sem FROM STUDENTSGPACGPA  WHERE studentid = '"+mChkMemID+"' and institutecode = '"+mInst+"' ";
rs1=db.getRowset(qry1);
if(rs1.next())
	mMaxsem=rs1.getInt("sem");

//-----------------------------------------------------
//-------START OF CURR CORE
//-----------------------------------------------------
int electivecount=0;
qry="";
				qry=qry+" select count(*)aa from PR#ELECTIVESUBJECTS A,SUBJECTMASTER B";
				qry=qry+" where A.institutecode='"+mInst+"' and A.Academicyear='"+mAcad+"' and A.programcode='"+mProg+"' and A.TAGGINGFOR='"+mTag+"' AND A.SECTIONBRANCH='"+mySect+"' ";
				qry=qry+" and A.semester="+mSem+" AND A.BASKET in ('D','E') AND A.institutecode=B.institutecode and A.subjectID=B.subjectID ";

//out.println(qry);
				ResultSet rsco=db.getRowset(qry);
				if(rsco.next())
				{
					electivecount=rsco.getInt("aa");
					%><INPUT TYPE="hidden" NAME="electivecount" value='<%=electivecount%>'><%
				}

				qry="Select distinct Semester, SEMESTERTYPE, SUBJECTTYPE, SUBJECTID, SUBJECT Subj, COURSECREDITPOINT COURSECREDITPOINT, nvl(BASKET,' ')BASKET";
				qry=qry+" from ";
				qry=qry+" (select distinct A.semester Semester, 'REG' SEMESTERTYPE, 'C' SUBJECTTYPE, A.SUBJECTID SUBJECTID, B.Subject||' ('||B.SubjectCode||')' SUBJECT, A.COURSECREDITPOINT COURSECREDITPOINT, nvl(A.BASKET,'A')BASKET from PROGRAMSCHEME A,SUBJECTMASTER B";
				qry=qry+" where A.institutecode='"+mInst +"' and A.Academicyear='"+mAcad+"' and A.programcode='"+mProg+"' and A.TAGGINGFOR='"+mTag+"' AND A.SECTIONBRANCH='"+mySect+"' ";
//improvement subject exclude
qry=qry+" and (a.subjectid) not IN (                                    SELECT DISTINCT subjectid                                               FROM studentresult                                              WHERE institutecode ='"+mInst +"'                                                AND studentid ='"+mChkMemID+"' )";

				qry=qry+" and A.semester="+mSem+" AND A.BASKET='A' AND A.institutecode=B.institutecode and A.subjectID=B.subjectID )";
				/*qry=qry+" union ";
				qry=qry+" (select distinct A.semester Semester, 'REG' SEMESTERTYPE, 'E' SUBJECTTYPE, A.SUBJECTID SUBJECTID, B.Subject||' ('||B.SubjectCode||')'||'***'||nvl(A.ELECTIVECODE,' ') SUBJECT, A.COURSECREDITPOINT COURSECREDITPOINT, nvl(A.BASKET,'D')BASKET from PR#ELECTIVESUBJECTS A,SUBJECTMASTER B";
				qry=qry+" where A.institutecode='"+mInst+"' and A.Academicyear='"+mAcad+"' and A.programcode='"+mProg+"' and A.TAGGINGFOR='"+mTag+"' AND A.SECTIONBRANCH='"+mySect+"' ";
				qry=qry+" and A.semester="+mSem+" AND A.BASKET in ('D','E') AND A.institutecode=B.institutecode and A.subjectID=B.subjectID))";	*/
				qry=qry+"  order by SUBJECTTYPE, Subject";

// query change replace A.BASKET in ('D')  by A.BASKET in ('D','E')


				rs=db.getRowset(qry);
				//out.print(qry);
				while(rs.next())
				{

					mSno++;
					mColor="White";
					mSemester=rs.getInt("Semester");
					mSemType=rs.getString("SEMESTERTYPE");
					mSubjType=rs.getString("SUBJECTTYPE");
					mSubjId=rs.getString("SUBJECTID");
					mSubjName=rs.getString("Subj");
					mCourseCrPt=rs.getDouble("COURSECREDITPOINT");
					mBasket=rs.getString("BASKET");
					mTotalCrLmtTkn=mTotalCrLmtTkn+mCourseCrPt;
					if(mSubjType.equals("E"))
					{
						int len=0;
						int pos1=0;
						len=mSubjName.length();
						pos1=mSubjName.indexOf("***");
						mElecCode=mSubjName.substring(pos1+3,len);
						mSubjName=mSubjName.substring(0,pos1);
						//out.print(mElecCode+" "+mSubjName);
					}

					mName1="CHK"+String.valueOf(mSno).trim();
					mName2="SEM"+String.valueOf(mSno).trim();
					mName3="SEMTYP"+String.valueOf(mSno).trim();
					mName4="SUBJTYP"+String.valueOf(mSno).trim();
					mName5="SUBJID"+String.valueOf(mSno).trim();
					mName6="SUBJ"+String.valueOf(mSno).trim();
					mName7="CCP"+String.valueOf(mSno).trim();
					mName8="ELCODE"+String.valueOf(mSno).trim();
					mName9="BASKET"+String.valueOf(mSno).trim();
					mName10="CHOICE"+String.valueOf(mSno).trim();
/*getting draft values*/
						qry="Select choice chc from PR#STUDENTSUBJECTCHOICE where INSTITUTECODE='"+mInst+"' ";
						qry=qry+" and EXAMCODE='"+mExam+"' and ACADEMICYEAR='"+mAcad+"' and PROGRAMCODE='"+mProg+"' ";
						qry=qry+" and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mySect+"' and SEMESTER='"+mSem+"' ";
						qry=qry+" and SEMESTERTYPE='REG' and STUDENTID='"+mChkMemID+"'  ";
						rse1212=db.getRowset(qry);

						//out.println(qry);
						while(rse1212.next())
						{
							mFlagstr1="1";
						}
						//out.println("flag : "+mFlagstr1);

						qry="Select choice chc from PR#STUDENTSUBJECTCHOICE where INSTITUTECODE='"+mInst+"' ";
						qry=qry+" and EXAMCODE='"+mExam+"' and ACADEMICYEAR='"+mAcad+"' and PROGRAMCODE='"+mProg+"' ";
						qry=qry+" and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mySect+"' and SEMESTER='"+mSem+"' ";
						qry=qry+" and SEMESTERTYPE='REG' and STUDENTID='"+mChkMemID+"' and SUBJECTID='"+mSubjId+"' ";
						qry=qry+" and SUBJECTTYPE='"+mSubjType+"'";
						rse12=db.getRowset(qry);
						String str1="";
						//out.println(qry);
						if(rse12.next())
						{
							if(mSubjType.equals("C"))
							{

							str1="Checked";
							//mFlagstr1="1";
							mMaxCrLmtAld=mMaxCrLmtAld+mCourseCrPt;
							}else if(mSubjType.equals("E") || mSubjType.equals("F")){
								if(rse12.getInt("chc")<=eee)
								{
								//	out.println("hello");
									mMaxCrLmtAld=mMaxCrLmtAld+mCourseCrPt;
									str1="selected";
									choise=rse12.getString("chc");
									value="N";
								}
								else
								{
									str1="selected";
									choise=rse12.getString("chc");
									value="Y";
								}
								//out.println(rse12.getInt("chc")>=eee);
							}
							//out.println(eee);
						}
						else
						{
							str1="";
							//mFlagstr1="";
						}


					if(mSubjType.equals("C"))
					{
						mSubjTypeDesc="CORE";
						%><tr bgcolor="LightGrey"><%
					}
					else if(mSubjType.equals("E"))
					{
						mSubjTypeDesc="ELECTIVE";
						%><tr bgcolor=""><%
					}
					else if(mSubjType.equals("F"))
					{
						mSubjTypeDesc="FREE ELECTIVE";
						%><tr bgcolor=""><%
					}
					else
					{
						mSubjTypeDesc=" ";
						%><tr bgcolor=""><%
					}

					%>


					<td align=center><Font face=arial size=2><%=mSno%>.</font></td>
					<td align=center><Font face=arial size=2>CURRENT</font></td>
					<%

					if(mSubjType.equals("E"))
					{
						%>
						<td align=center><Font face=arial size=2><%=mSubjTypeDesc%> (<%=mElecCode%>)</font></td>
						<%
					}
					else
					{
						%>
						<td align=center><Font face=arial size=2><%=mSubjTypeDesc%></font></td>
						<%
					}
					%>
					<td><Font face=arial size=2><%=mSubjName%></font></td>
					<td align=center><Font face=arial size=2><%=mCourseCrPt%></font><INPUT TYPE="hidden" NAME="cr<%=mSno%>" value="<%=mCourseCrPt%>"></td>
					<%
					if(mSubjType.equals("C"))
					{

						//out.println(mFlagstr1);
						if(!mFlagstr1.equals("1"))
						{

							//out.println("sunny");
							mMaxCrLmtTkn=mMaxCrLmtTkn+mCourseCrPt;

							if(mMaxCrLmtTkn<=mMaxCrLmt )
							{
								mMaxCrLmtAld=mMaxCrLmtTkn;
								//current core
								%>
								<td align=center><input Type=checkbox id='<%=mName1%>' name='<%=mName1%>' value='Y' checked onclick="FunRefresh('<%=mCourseCrPt%>', '<%=mSno%>','<%=mBasket%>','<%=mName1%>')">
								</td>
								<%
									Count++;
							}
							else
							{
								%>
								<td align=center><input Type=checkbox <%=str1%> id='<%=mName1%>' name='<%=mName1%>' value='Y' onclick="FunRefresh('<%=mCourseCrPt%>', '<%=mSno%>','<%=mBasket%>','<%=mName1%>')"></td>
								<%

							}
						}
						else
						{

							if( !str1.equals(""))
							{
								mMaxCrLmtTkn=mMaxCrLmtTkn+mCourseCrPt;
								//out.print(mMaxCrLmtTkn);
							}
							if(mMaxCrLmtTkn<=mMaxCrLmt)
							{

									mMaxCrLmtAld=mMaxCrLmtTkn;
								//out.println()
								//current core
								%>
								<td align=center><input Type=checkbox <%=str1%> id='<%=mName1%>' name='<%=mName1%>' value='Y'  onclick="FunRefresh('<%=mCourseCrPt%>', '<%=mSno%>','<%=mBasket%>','<%=mName1%>')">
								</td>
								<%
									Count++;
							}
							else
							{
								%>
								<td align=center><input Type=checkbox <%=str1%> id='<%=mName1%>' name='<%=mName1%>' value='Y' onclick="FunRefresh('<%=mCourseCrPt%>', '<%=mSno%>','<%=mBasket%>','<%=mName1%>')"></td>
								<%


							}

						}

					}
					else
					{
						//Current Elective
						%>

						<td align=center>
						<input Type=hidden  id='check<%=str1%>' name='<%=mName1%>' value='Y'>
						<input type=hidden name='temp11<%=i%>' value="<%=value%>" size=1 id="temp11<%=i%>">
						<select name='<%=mName10%>' id='Selecth<%=i%>'onChange="Clickedsel1('<%=mSno%>','<%=mCourseCrPt%>','Selecth<%=i%>','<%=mBasket%>','<%=electivecount%>')"	style="Width:40">
								<%

									String st1="";
									%><option selected Value=''> </option><%
									for ( m=1;m<=electivecount;m++)
									{
										if(choise.equals(String.valueOf(m)))
										{
											st1="Selected";
											//mMaxCrLmtAld=mMaxCrLmtAld+mCourseCrPt;
										}
											else
												st1="";

											%>

											<option <%=st1%>  Value=<%=m%>><%=m%></option>
											<%
									}
								%>
								</select>
						<!--<input Type=checkbox <%//=str1%> id='<%//=mName1%>' name='<%//=mName1%>' value='Y' onclick="FunRefresh('<%//=mCourseCrPt%>', '<%//=mSno%>','<%//=mBasket%>')">-->


						</td>
						<%
							i++;
					}
					%>
						<input Type=HIDDEN id='Improvement<%=mSno%>' name='Improvement<%=mSno%>' value='N'>

					<input Type=hidden id='<%=mName2%>' name='<%=mName2%>' value='<%=mSemester%>'>
					<input Type=hidden id='<%=mName3%>' name='<%=mName3%>' value='<%=mSemType%>'>
					<input Type=hidden id='<%=mName4%>' name='<%=mName4%>' value='<%=mSubjType%>'>
					<input Type=hidden id='<%=mName5%>' name='<%=mName5%>' value='<%=mSubjId%>'>
					<input Type=hidden id='<%=mName6%>' name='<%=mName6%>' value='<%=mSubjName%>'>
					<input Type=hidden id='<%=mName7%>' name='<%=mName7%>' value='<%=mCourseCrPt%>'>
					<input Type=hidden id='<%=mName8%>' name='<%=mName8%>' value='<%=mElecCode%>'>
					<input Type=hidden id='<%=mName9%>' name='<%=mName9%>' value='<%=mBasket%>'>
					<input Type=hidden id='<%=mName10%>' name='<%=mName10%>' value='<%=mChoice%>'>



					</tr>
					<%
				}

						%><input type=hidden name="Count2" id="Count2" value="<%=Count%>"><%
				%><input type=hidden name="no" id="no" value="<%=mMaxCrLmtTkn%>"><%
//-----------------------------------------------------
//---------END OF CORE, ELECTIVE & FREEELECTIVE--------
//-----------------------------------------------------
%><input type="hidden" name="corecrpoint" value="<%=mMaxCrLmtTkn%>">




<%




//-----------------------------------------------------
//---------START OF ELECTIVE [WHERE BASKET='B']--------
//-----------------------------------------------------
int j=0;


				qry="Select count(A.ELECTIVECODE)cnt,A.ELECTIVECODE ELECTIVECODE, nvl(A.BASKET,'B')BASKET From PR#ELECTIVESUBJECTS A";
				qry=qry+" where A.INSTITUTECODE='"+mInst+"' and A.EXAMCODE='"+mExam+"' and A.ACADEMICYEAR='"+mAcad+"'";
				qry=qry+" and A.PROGRAMCODE='"+mProg+"' and A.TAGGINGFOR='"+mTag+"' and A.SECTIONBRANCH='"+mySect+"'";
				qry=qry+" and A.SEMESTER="+mSem+"  and nvl(A.DEACTIVE,'N')='N'";
				//improvement subject not in
				qry=qry+" and (a.subjectid) not IN (                                    SELECT DISTINCT subjectid                                               FROM studentresult                                              WHERE institutecode ='"+mInst +"'                                                AND studentid ='"+mChkMemID+"' )";
                qry=qry+" and substr(A.electivecode,1,3)<>'SCE'";
//                qry=qry+" and A.basket <> 'B'";
                qry=qry+" group by A.ELECTIVECODE, A.BASKET" +
                        " order by electivecode";
				rsc=db.getRowset(qry);
				//out.print(qry);
				while(rsc.next())
				{
                    i=0;
                    mTot=rsc.getInt("cnt");
					%><INPUT TYPE="HIDDEN" NAME="pd" value=<%=mTot%>><%
					mElecCode=rsc.getString("ELECTIVECODE");
					mBasket=rsc.getString("BASKET");

                    qry="select distinct electivecode, subjectid ,subj, COURSECREDITPOINT  from ( ";
					qry=qry+"Select a.electivecode, A.SUBJECTID SUBJECTID, B.Subject||'('||B.SubjectCode||')' Subj, A.COURSECREDITPOINT COURSECREDITPOINT From PR#ELECTIVESUBJECTS A,  SubjectMaster B ";
					qry=qry+" where A.INSTITUTECODE='"+mInst+"' and A.EXAMCODE='"+mExam+"' and A.ACADEMICYEAR='"+mAcad+"'";
					qry=qry+" and A.ELECTIVECODE='"+mElecCode+"' and A.PROGRAMCODE='"+mProg+"' and A.TAGGINGFOR='"+mTag+"' and A.SECTIONBRANCH='"+mySect+"'";
					qry=qry+" and A.BASKET= '"+mBasket+"'";
                    qry=qry+" and A.SEMESTER="+mSem+" and nvl(A.DEACTIVE,'N')='N'  and nvl(b.deactive,'N')='N' and B.subjectID=A.subjectID  and a.INSTITUTECODE=b.INSTITUTECODE";
					qry=qry+" Group By A.SUBJECTID , B.Subject||'('||B.SubjectCode||')', A.COURSECREDITPOINT, electivecode ";
                    qry=qry+"union all Select a.electivecode,A.SUBJECTID SUBJECTID, B.Subject||'('||B.SubjectCode||')' Subj, A.COURSECREDITPOINT COURSECREDITPOINT From PR#ELECTIVESUBJECTS A,  SubjectMaster B ";
					qry=qry+" where A.INSTITUTECODE='"+mInst+"' and A.EXAMCODE='"+mExam+"' and A.ACADEMICYEAR='"+mAcad+"'";
					qry=qry+" and A.ELECTIVECODE='"+mElecCode+"' and A.PROGRAMCODE='"+mProg+"' and A.TAGGINGFOR='"+mTag+"' and A.SECTIONBRANCH='"+mySect+"'";
					qry=qry+" and A.BASKET= '"+mBasket+"'";
                    qry=qry+" and A.SEMESTER="+mSem+" and nvl(A.DEACTIVE,'N')='N'  and nvl(b.deactive,'N')='N' and B.subjectID=A.subjectID  and a.INSTITUTECODE=b.INSTITUTECODE";
					qry=qry+" Group By A.SUBJECTID , B.Subject||'('||B.SubjectCode||')', A.COURSECREDITPOINT, electivecode )";


                 //   out.print(qry);
					rs1=db.getRowset(qry);

					while(rs1.next())
					{

						mSno++;
						mColor="White";
						mSemester=mSem;
						mSemType="REG";
						mSubjType="E";
						mSubjId=rs1.getString("SUBJECTID");
						mSubjName=rs1.getString("Subj");
						mCourseCrPt=rs1.getDouble("COURSECREDITPOINT");
                        mElecCode=rs1.getString("ELECTIVECODE");

						mTotalCrLmtTkn=mTotalCrLmtTkn+mCourseCrPt;

						mELECTIVECODE=mElecCode;

						qry="Select choice chc from PR#STUDENTSUBJECTCHOICE where INSTITUTECODE='"+mInst+"' ";
						qry=qry+" and EXAMCODE='"+mExam+"' and ACADEMICYEAR='"+mAcad+"' and PROGRAMCODE='"+mProg+"' ";
						qry=qry+" and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mySect+"' and SEMESTER='"+mSem+"' ";
						qry=qry+" and SEMESTERTYPE='REG' and STUDENTID='"+mChkMemID+"' and SUBJECTID='"+mSubjId+"' ";
						qry=qry+" and SUBJECTTYPE='E'";
						rse=db.getRowset(qry);
						//out.print(qry);
						if(rse.next())
						{
							mochoice=rse.getInt("chc");
							value="N";
							pdvalue="Y";
						}
						else
						{
							mochoice=0;
							pdvalue="N";
						}

						if (!mELECTIVECODE.equals(OldmELECTIVECODE))
						{
							if (mChoice==0)
								mChoice=1 ;
							else
								mChoice=0 ;
							OldmELECTIVECODE=mELECTIVECODE;
						}
						if (mChoice==0)
							mColor=mCol1;
						else
							mColor=mCol2;

						mName1="CHK"+String.valueOf(mSno).trim();
						mNameSmall="chk"+String.valueOf(mSno).trim();
						mName2="SEM"+String.valueOf(mSno).trim();
						mName3="SEMTYP"+String.valueOf(mSno).trim();
						mName4="SUBJTYP"+String.valueOf(mSno).trim();
						mName5="SUBJID"+String.valueOf(mSno).trim();
						mName6="SUBJ"+String.valueOf(mSno).trim();
						mName7="CCP"+String.valueOf(mSno).trim();
						mName8="ELCODE"+String.valueOf(mSno).trim();
						mName9="BASKET"+String.valueOf(mSno).trim();
						mName10="CHOICE"+String.valueOf(mSno).trim();

	      			      if(!mElective.equals(mElecCode))
						   {
							mElective=mElecCode;
							%>
							<tr bgcolor="<%=mColor%>">
							<td align=center><Font face=arial size=2><%=mSno%>.</font></td>
							<td align=center><Font face=arial size=2>CURRENT</font></td>
							<td align=center><Font face=arial size=2>ELECTIVE (<%=mElecCode%>)</font></td>
							<td align=left><Font face=arial size=2><%=mSubjName%></font></td>
							<td align=center><Font face=arial size=2><%=mCourseCrPt%></font></td>
							<td nowrap align="center">

							<input Type=hidden  id='check<%=++j%>' name='<%=mName1%>' value='Y'>
                            <%if(mochoice>0){%>
                                <input Type=hidden  id='<%=mNameSmall%>' name='<%=mNameSmall%>' value='Y'/>
                            <%}else{%>
                                <input Type=hidden  id='<%=mNameSmall%>' name='<%=mNameSmall%>' value='N'/>
							<%}%>
							<!--onclick="Clicked('<%=mSno%>','<%=mochoice%>')"
							onchange="FunRefresh('<%=mCourseCrPt%>', '<%=mSno%>','<%=mBasket%>')"
							-->
							<input type=hidden name='temp1<%=++i%>' value="<%=value%>" size=1 id="temp1<%=i%>">
                            <select name='<%=mName10%>' id='<%=mElecCode.toString().replaceAll("-","")%><%=i%>' onchange="Clickedsel11('<%=mSno%>','<%=mCourseCrPt%>','<%=mElecCode.toString().replaceAll("-","")%><%=i%>','<%=mElecCode.toString().replaceAll("-","")%>','<%=mTot%>', '<%=mNameSmall%>')"	style="Width:40">
							<%
							//i++;
							String st1="";
							%><option selected Value=''> </option><%
							for ( m=1;m<=mTot;m++)
							{
								if(mochoice==m)
								{
									st1="Selected";
									mMaxCrLmtAld=mMaxCrLmtAld+mCourseCrPt;


								}
									else{
										st1="";

									}


									%>

									<option <%=st1%>  Value=<%=m%>><%=m%></option>
									<%



							}

							%>

							</select>
							<INPUT TYPE="hidden" NAME="pdvalue" value="<%=pdvalue%>">
							</td>
								<input Type=HIDDEN id='Improvement<%=mSno%>' name='Improvement<%=mSno%>' value='N'>

							<input Type=hidden id='<%=mName2%>' name='<%=mName2%>' value='<%=mSemester%>'>
							<input Type=hidden id='<%=mName3%>' name='<%=mName3%>' value='<%=mSemType%>'>
							<input Type=hidden id='<%=mName4%>' name='<%=mName4%>' value='<%=mSubjType%>'>
							<input Type=hidden id='<%=mName5%>' name='<%=mName5%>' value='<%=mSubjId%>'>
							<input Type=hidden id='<%=mName6%>' name='<%=mName6%>' value='<%=mSubjName%>'>
							<input Type=hidden id='<%=mName7%>' name='<%=mName7%>' value='<%=mCourseCrPt%>'>
							<input Type=hidden id='<%=mName8%>' name='<%=mName8%>' value='<%=mElecCode%>'>
							<input Type=hidden id='<%=mName9%>' name='<%=mName9%>' value='<%=mBasket%>'>

							</tr>
							<%
						}
						else
						{
							%>
						 	<tr bgcolor="<%=mColor%>">
							<td align=center><Font face=arial size=2><%=mSno%>.</font></td>
							<td align=center><Font face=arial size=2>CURRENT</font></td>
							<td align=center><Font face=arial size=2>ELECTIVE (<%=mElecCode%>)</font></td>
                            <td align=left><Font face=arial size=2><%=mSubjName%></font></td>
							<td align=center><Font face=arial size=2><%=mCourseCrPt%></font></td>
							<td nowrap align="center">


							<input Type=hidden id='check<%=++j%>' name='<%=mName1%>' value='Y'  >
							<%if(mochoice>0){%>
                                <input Type=hidden  id='<%=mNameSmall%>' name='<%=mNameSmall%>' value='Y'/>
                            <%}else{%>
                                <input Type=hidden  id='<%=mNameSmall%>' name='<%=mNameSmall%>' value='N'/>
							<%}%>

							<!--onclick="Clicked('<%=mSno%>','<%=mochoice%>')"-->
							<input type="hidden" name='temp1<%=++i%>' value="<%=value%>" size=1 id="temp1<%=i%>">
							<select name='<%=mName10%>' id='<%=mElecCode.toString().replaceAll("-","")%><%=i%>' onchange="Clickedsel11('<%=mSno%>','<%=mCourseCrPt%>','<%=mElecCode.toString().replaceAll("-","")%><%=i%>','<%=mElecCode.toString().replaceAll("-","")%>','<%=mTot%>','<%=mNameSmall%>')"	style="Width:40">

									<!--<option selected Value=''> </option>-->
									<%

								String st1="";
							%><option selected Value=''> </option><%
							for ( m=1;m<=mTot;m++)
							{
								if(mochoice==m)
								{
									st1="Selected";
									//mMaxCrLmtAld=mMaxCrLmtAld+1;
								}
									else
										st1="";

									%>

									<option <%=st1%>  Value=<%=m%>><%=m%></option>
									<%



							}

							%>

							</select>
	<input Type=HIDDEN id='Improvement<%=mSno%>' name='Improvement<%=mSno%>' value='N'>

							<input Type=hidden id='<%=mName2%>' name='<%=mName2%>' value='<%=mSemester%>'>
							<input Type=hidden id='<%=mName3%>' name='<%=mName3%>' value='<%=mSemType%>'>
							<input Type=hidden id='<%=mName4%>' name='<%=mName4%>' value='<%=mSubjType%>'>
							<input Type=hidden id='<%=mName5%>' name='<%=mName5%>' value='<%=mSubjId%>'>
							<input Type=hidden id='<%=mName6%>' name='<%=mName6%>' value='<%=mSubjName%>'>
							<input Type=hidden id='<%=mName7%>' name='<%=mName7%>' value='<%=mCourseCrPt%>'>
							<input Type=hidden id='<%=mName8%>' name='<%=mName8%>' value='<%=mElecCode%>'>
							<input Type=hidden id='<%=mName9%>' name='<%=mName9%>' value='<%=mBasket%>'>

							</td>
							</tr>
							<%
						} //closing of else
					} // closing of while rs1
				} // closing of while rsc



//-----------------------------------------------------
//----------END OF ELECTIVE [WHERE BASKET='B']---------
//-----------------------------------------------------
i=1;
//---------new added ----------------------

int mTCount=0;
                qry="";
				qry=qry+" select count(*)aa from PR#ELECTIVESUBJECTS A,SUBJECTMASTER B";
				qry=qry+" where A.institutecode='"+mInst+"' and A.Academicyear='"+mAcad+"' and A.programcode='"+mProg+"' and A.TAGGINGFOR='"+mTag+"' AND A.SECTIONBRANCH='"+mySect+"' ";
				qry=qry+" and A.semester="+mSem+" AND A.BASKET in ('D','E') AND A.institutecode=B.institutecode and A.subjectID=B.subjectID ";
                qry=qry+" AND (SUBSTR(A.ELECTIVECODE,1,2)='SC')";

//out.println(qry);
			    rsdks=db.getRowset(qry);
				if(rsdks.next())
				{
					electivecount=rsdks.getInt("aa");
					%><INPUT TYPE="hidden" NAME="electivecount" value='<%=electivecount%>'><%
				}

//electivecount = 6;
				qry="Select distinct electivecode, Semester, SEMESTERTYPE, SUBJECTTYPE, SUBJECTID, SUBJECT Subj, COURSECREDITPOINT COURSECREDITPOINT, nvl(BASKET,' ')BASKET";
				qry=qry+" from (";
				/*qry=qry+" (select distinct A.semester Semester, 'REG' SEMESTERTYPE, 'C' SUBJECTTYPE, A.SUBJECTID SUBJECTID, B.Subject||' ('||B.SubjectCode||')' SUBJECT, A.COURSECREDITPOINT COURSECREDITPOINT, nvl(A.BASKET,'A')BASKET from PROGRAMSCHEME A,SUBJECTMASTER B";
				qry=qry+" where A.institutecode='"+mInst +"' and A.Academicyear='"+mAcad+"' and A.programcode='"+mProg+"' and A.TAGGINGFOR='"+mTag+"' AND A.SECTIONBRANCH='"+mySect+"' ";
				qry=qry+" and A.semester="+mSem+" AND A.BASKET='A' AND A.institutecode=B.institutecode and A.subjectID=B.subjectID )";
				qry=qry+" union ";*/
				qry=qry+" (select distinct A.semester Semester, 'REG' SEMESTERTYPE, 'E' SUBJECTTYPE, A.SUBJECTID SUBJECTID, B.Subject||' ('||B.SubjectCode||')'||'***'||nvl(A.ELECTIVECODE,' ') SUBJECT, A.COURSECREDITPOINT COURSECREDITPOINT, nvl(A.BASKET,'D')BASKET, electivecode from PR#ELECTIVESUBJECTS A,SUBJECTMASTER B";
				qry=qry+" where A.institutecode='"+mInst+"' and A.Academicyear='"+mAcad+"' and A.programcode='"+mProg+"' and A.TAGGINGFOR='"+mTag+"' AND A.SECTIONBRANCH='"+mySect+"' AND (SUBSTR(A.ELECTIVECODE,1,2)='SC')";
				//improvement subject not in
				qry=qry+" and (a.subjectid) not IN (                                    SELECT DISTINCT subjectid                                               FROM studentresult                                              WHERE institutecode ='"+mInst +"'                                                AND studentid ='"+mChkMemID+"' )";
				qry=qry+" and A.semester="+mSem+" AND A.BASKET in ('D','E') AND A.institutecode=B.institutecode and A.subjectID=B.subjectID)";
				qry=qry+" ) order by electivecode,SUBJECTTYPE, Subject";

// query change replace A.BASKET in ('D')  by A.BASKET in ('D','E')


				rs=db.getRowset(qry);
				//out.print(qry);
				while(rs.next())
				{

                    mTCount++;

					mSno++;
					mColor="White";
					mSemester=rs.getInt("Semester");
					mSemType=rs.getString("SEMESTERTYPE");
					mSubjType=rs.getString("SUBJECTTYPE");
					mSubjId=rs.getString("SUBJECTID");
					mSubjName=rs.getString("Subj");
					mCourseCrPt=rs.getDouble("COURSECREDITPOINT");
					mBasket=rs.getString("BASKET");
					mTotalCrLmtTkn=mTotalCrLmtTkn+mCourseCrPt;
					if(mSubjType.equals("E"))
					{
						int len=0;
						int pos1=0;
						len=mSubjName.length();
						pos1=mSubjName.indexOf("***");
						mElecCode=mSubjName.substring(pos1+3,len);
						mSubjName=mSubjName.substring(0,pos1);
						//out.print(mElecCode+" "+mSubjName);
					}

					mName1="CHK"+String.valueOf(mSno).trim();
					mName2="SEM"+String.valueOf(mSno).trim();
					mName3="SEMTYP"+String.valueOf(mSno).trim();
					mName4="SUBJTYP"+String.valueOf(mSno).trim();
					mName5="SUBJID"+String.valueOf(mSno).trim();
					mName6="SUBJ"+String.valueOf(mSno).trim();
					mName7="CCP"+String.valueOf(mSno).trim();
					mName8="ELCODE"+String.valueOf(mSno).trim();
					mName9="BASKET"+String.valueOf(mSno).trim();
					mName10="CHOICE"+String.valueOf(mSno).trim();
                    mNameSmall="chk"+String.valueOf(mSno).trim();
/*getting draft values*/
						qry="Select distinct choice chc from PR#STUDENTSUBJECTCHOICE where INSTITUTECODE='"+mInst+"' ";
						qry=qry+" and EXAMCODE='"+mExam+"' and ACADEMICYEAR='"+mAcad+"' and PROGRAMCODE='"+mProg+"' ";
						qry=qry+" and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mySect+"' and SEMESTER='"+mSem+"' ";
						qry=qry+" and SEMESTERTYPE='REG' and STUDENTID='"+mChkMemID+"'  ";
						rse1212=db.getRowset(qry);

						//out.println(qry);
						while(rse1212.next())
						{
							mFlagstr1="1";
						}
						//out.println("flag : "+mFlagstr1);
						mochoice=0;
						qry="Select distinct choice chc from PR#STUDENTSUBJECTCHOICE where INSTITUTECODE='"+mInst+"' ";
						qry=qry+" and EXAMCODE='"+mExam+"' and ACADEMICYEAR='"+mAcad+"' and PROGRAMCODE='"+mProg+"' ";
						qry=qry+" and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mySect+"' and SEMESTER='"+mSem+"' ";
						qry=qry+" and SEMESTERTYPE='REG' and STUDENTID='"+mChkMemID+"' and SUBJECTID='"+mSubjId+"' ";
						qry=qry+" and SUBJECTTYPE='"+mSubjType+"'";
						rse12=db.getRowset(qry);
						String str1="";
						//out.println(qry);
						if(rse12.next())
						{
						//	out.println("INNNN   "+mSubjId);
							if(mSubjType.equals("C"))
							{

							str1="Checked";
							//mFlagstr1="1";
							mMaxCrLmtAld=mMaxCrLmtAld+mCourseCrPt;
							}else if(mSubjType.equals("E") || mSubjType.equals("F")){
								if(rse12.getInt("chc")<=eee)
								{
									//out.println("hello");
									mMaxCrLmtAld=mMaxCrLmtAld+mCourseCrPt;
									str1="selected";
									choise=rse12.getString("chc");
                                    mochoice=Integer.parseInt(choise);
									value="N";
								}
								else
								{
									str1="selected";
									choise=rse12.getString("chc");
                                    mochoice=Integer.parseInt(choise);
									value="Y";
								}
								//out.println(rse12.getInt("chc")>=eee);
							}
							//out.println(eee+"sss"+choise);
						}
						else
						{
							str1="";
							//mFlagstr1="";
							choise="";
//							out.print(electivecount+"electivecount"+choise);
						}


					if(mSubjType.equals("C"))
					{
						mSubjTypeDesc="CORE";
						%><tr bgcolor="LightGrey"><%
					}
					else if(mSubjType.equals("E"))
					{
						mSubjTypeDesc="ELECTIVE";
						%><tr bgcolor=""><%
					}
					else if(mSubjType.equals("F"))
					{
						mSubjTypeDesc="FREE ELECTIVE";
						%><tr bgcolor=""><%
					}
					else
					{
						mSubjTypeDesc=" ";
						%><tr bgcolor=""><%
					}

					%>


					<td align=center><Font face=arial size=2><%=mSno%>.</font></td>
					<td align=center><Font face=arial size=2>CURRENT</font></td>
					<%

					if(mSubjType.equals("E"))
					{
						%>
						<td align=center><Font face=arial size=2><%=mSubjTypeDesc%> (<%=mElecCode%>)</font></td>
						<%
					}
					else
					{
						%>
						<td align=center><Font face=arial size=2><%=mSubjTypeDesc%></font></td>
						<%
					}
					%>
					<td><Font face=arial size=2><%=mSubjName%></font></td>
					<td align=center><Font face=arial size=2><%=mCourseCrPt%></font></td>
					<%
					if(mSubjType.equals("C"))
					{

						//out.println(mFlagstr1);
						if(!mFlagstr1.equals("1"))
						{

							//out.println("sunny");
							mMaxCrLmtTkn=mMaxCrLmtTkn+mCourseCrPt;

							if(mMaxCrLmtTkn<=mMaxCrLmt )
							{
								mMaxCrLmtAld=mMaxCrLmtTkn;
								//current core
								%>
								<td align=center><input Type=checkbox id='<%=mName1%>' name='<%=mName1%>' value='Y' checked onclick="FunRefresh('<%=mCourseCrPt%>', '<%=mSno%>','<%=mBasket%>','<%=mName1%>')">
								</td>
								<%
									Count++;
							}
							else
							{
								%>
								<td align=center><input Type=checkbox <%=str1%> id='<%=mName1%>' name='<%=mName1%>' value='Y' onclick="FunRefresh('<%=mCourseCrPt%>', '<%=mSno%>','<%=mBasket%>','<%=mName1%>')"></td>
								<%

							}
						}
						else
						{

							if( !str1.equals(""))
							{
								mMaxCrLmtTkn=mMaxCrLmtTkn+mCourseCrPt;
								//out.print(mMaxCrLmtTkn);
							}
							if(mMaxCrLmtTkn<=mMaxCrLmt)
							{

									mMaxCrLmtAld=mMaxCrLmtTkn;
								//out.println()
								//current core
								%>
								<td align=center><input Type=checkbox <%=str1%> id='<%=mName1%>' name='<%=mName1%>' value='Y'  onclick="FunRefresh('<%=mCourseCrPt%>', '<%=mSno%>','<%=mBasket%>','<%=mName1%>')">
								</td>
								<%
									Count++;
							}
							else
							{
								%>
								<td align=center><input Type=checkbox <%=str1%> id='<%=mName1%>' name='<%=mName1%>' value='Y' onclick="FunRefresh('<%=mCourseCrPt%>', '<%=mSno%>','<%=mBasket%>','<%=mName1%>')"></td>
								<%


							}

						}

					}
					else
					{
						//out.print(mCourseCrPt+"mCourseCrPt"+electivecount);
						//Current Elective
					//	out.print(electivecount+"electivecount"+choise);
					//	electivecount=9;
						%>

						<td align=center>
						<input Type=hidden  id='check<%=str1%>' name='<%=mName1%>' value='Y'>
						<%if(mochoice>0){%>
                                <input Type=hidden  id='<%=mNameSmall%>' name='<%=mNameSmall%>' value='Y'/>
                            <%}else{%>
                                <input Type=hidden  id='<%=mNameSmall%>' name='<%=mNameSmall%>' value='N'/>
							<%}%>
						<input type=hidden name='temp<%=i%>' value="<%=value%>" size=1 id="temp<%=i%>">

                        <select name='<%=mName10%>' id='Selectf<%=i%>' onchange="Clickedsel('<%=mSno%>','<%=mCourseCrPt%>','Selectf<%=i%>','<%=mBasket%>','<%=mTCount%>','<%=mNameSmall%>')"	style="Width:40">

									<!--<option selected Value=''> </option>-->
									<%

								String st1="";
							%><option selected Value=''> </option><%
							for ( m=1;m<=electivecount;m++)
							{
								if(mochoice==m)
								{
									st1="Selected";
									//mMaxCrLmtAld=mMaxCrLmtAld+1;
								}
									else
										st1="";

									%>

									<option <%=st1%>  Value=<%=m%>><%=m%></option>
									<%
							}

							%>

							</select>


						</td>
						<%
							i++;
					}
					%>

						<input Type=HIDDEN id='Improvement<%=mSno%>' name='Improvement<%=mSno%>' value='N'>

					<input Type=hidden id='<%=mName2%>' name='<%=mName2%>' value='<%=mSemester%>'>
					<input Type=hidden id='<%=mName3%>' name='<%=mName3%>' value='<%=mSemType%>'>
					<input Type=hidden id='<%=mName4%>' name='<%=mName4%>' value='<%=mSubjType%>'>
					<input Type=hidden id='<%=mName5%>' name='<%=mName5%>' value='<%=mSubjId%>'>
					<input Type=hidden id='<%=mName6%>' name='<%=mName6%>' value='<%=mSubjName%>'>
					<input Type=hidden id='<%=mName7%>' name='<%=mName7%>' value='<%=mCourseCrPt%>'>
					<input Type=hidden id='<%=mName8%>' name='<%=mName8%>' value='<%=mElecCode%>'>
					<input Type=hidden id='<%=mName9%>' name='<%=mName9%>' value='<%=mBasket%>'>
					<input Type=hidden id='<%=mName10%>' name='<%=mName10%>' value='<%=mChoice%>'>



					</tr>
					<%
				}
//aNKURIMPRO
	//out.print(mMaxCrLmtAld+" ::: mMaxCrLmtAld");

//mMaxCrLmtAld=mMaxCrLmtAld;
//---------------------------------------












//------------------------------- improvement  basket - A CORE ------------------------------
int a=Integer.parseInt(mAcad);

if(a>1213){
    mMinsem=6;
    }


qry1="Select distinct Semester, SEMESTERTYPE, SUBJECTTYPE, SUBJECTID, SUBJECT Subj, COURSECREDITPOINT COURSECREDITPOINT, nvl(BASKET,' ')BASKET";
				qry1=qry1+" from ";
				qry1=qry1+" ( SELECT DISTINCT A.semester semester, 'REG' semestertype,  'C' subjecttype, a.subjectid subjectid,                                 B.Subject||' ('||B.SubjectCode||')' SUBJECT ,                                 a.coursecreditpoint coursecreditpoint,                                 NVL (a.basket, 'A') basket     FROM programscheme a, subjectmaster b,studentresult c,studentmaster d                           WHERE (B.subject NOT LIKE '%PROJECT%'            OR B.subject LIKE '%PROJECT MANAGEMENT%') AND  a.institutecode = '"+mInst+"'   and a.BASKET='A'  and a.SUBJECTID=c.SUBJECTID and d.studentid=c.studentid  AND d.institutecode = c.institutecode                              AND a.institutecode = c.institutecode and b.SUBJECTID=c.SUBJECTID             and                  A.institutecode='"+mInst+"' and A.Academicyear='"+mAcad+"' and A.programcode='"+mProg+"' and A.TAGGINGFOR='"+mTag+"' AND A.SECTIONBRANCH='"+mySect+"'                             AND a.institutecode = b.institutecode                             AND a.subjectid = b.subjectid  and (a.SUBJECTID,d.studentid) in (select distinct e.subjectid,e.studentid from studentresult e where e.INSTITUTECODE = '"+mInst+"'  and                               e.STUDENTID= '"+mChkMemID+"'  and e.grade NOT IN ('A', 'A+', 'B+','F','X')      AND exists (select 'y'                                                             FROM studentsgpacgpa x                                                             WHERE x.institutecode = '"+mInst+"'                                                              AND  x.cgpa <  "+mMinsem+"                                                             and  x.studentid= e.studentid                                                              and x.semester = "+mMaxsem+"                                                            and ( (x.semester = a.semester)                                                                     or                                                                     (e.subjectid in(select o.subjectid                                                                                      from offersubjecttagging o                                                                                      where o.institutecode ='"+mInst+"'                                                                                     and   o.examcode = '"+mExam+"'                                                                                      and   o.subjectid = e.subjectid                                                   )                                                                     )                                                                    )                                                                            ))) ";


				rs=db.getRowset(qry1);
		//out.print(qry1);
				while(rs.next())
				{

qry2="select FEEAMOUNT from PR#LTPWiseFee a where a.INSTITUTECODE='"+ mInst +"'   AND A.EXAMCODE='"+mExam+"' AND A.MAXCOURSECREDITPOINT="+rs.getString("coursecreditpoint")+"";
//out.print(qry2);
rs1=db.getRowset(qry2);
if(rs1.next())
		{
FeeAmt=rs1.getLong("FEEAMOUNT");

		}

					mSno++;
					mColor="LIGHTGREEN";
					mSemester=rs.getInt("Semester");
					mSemType=rs.getString("SEMESTERTYPE");
					mSubjType=rs.getString("SUBJECTTYPE");
					mSubjId=rs.getString("SUBJECTID");
					mSubjName=rs.getString("Subj");
					mCourseCrPt=rs.getDouble("COURSECREDITPOINT");
					mBasket=rs.getString("BASKET");
					mTotalCrLmtTkn=mTotalCrLmtTkn+mCourseCrPt;
					mChoice=1;
					mElecCode="";
				/*	if(mSubjType.equals("E"))
					{
						int len=0;
						int pos1=0;
						len=mSubjName.length();
						pos1=mSubjName.indexOf("***");
						mElecCode=mSubjName.substring(pos1+3,len);
						mSubjName=mSubjName.substring(0,pos1);
						//out.print(mElecCode+" "+mSubjName);
					}*/

					mName1="CHK"+String.valueOf(mSno).trim();
					mName2="SEM"+String.valueOf(mSno).trim();
					mName3="SEMTYP"+String.valueOf(mSno).trim();
					mName4="SUBJTYP"+String.valueOf(mSno).trim();
					mName5="SUBJID"+String.valueOf(mSno).trim();
					mName6="SUBJ"+String.valueOf(mSno).trim();
					mName7="CCP"+String.valueOf(mSno).trim();
					mName8="ELCODE"+String.valueOf(mSno).trim();
					mName9="BASKET"+String.valueOf(mSno).trim();
					mName10="CHOICE"+String.valueOf(mSno).trim();
/*getting draft values*/
						qry="Select choice chc from PR#STUDENTSUBJECTCHOICE where INSTITUTECODE='"+mInst+"' ";
						qry=qry+" and EXAMCODE='"+mExam+"' and ACADEMICYEAR='"+mAcad+"' and PROGRAMCODE='"+mProg+"' ";
						qry=qry+" and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mySect+"'  ";
						qry=qry+" and SEMESTERTYPE='GIP' and STUDENTID='"+mChkMemID+"'  ";
						rse1212=db.getRowset(qry);

						//out.println(qry);
						while(rse1212.next())
						{
							mFlagstr1="1";
						}
						//out.println("flag : "+mFlagstr1);

						qry="Select choice chc from PR#STUDENTSUBJECTCHOICE where INSTITUTECODE='"+mInst+"' ";
						qry=qry+" and EXAMCODE='"+mExam+"' and ACADEMICYEAR='"+mAcad+"' and PROGRAMCODE='"+mProg+"' ";
						qry=qry+" and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mySect+"'  ";
						qry=qry+" and SEMESTERTYPE='GIP' and STUDENTID='"+mChkMemID+"' and SUBJECTID='"+mSubjId+"' ";
						qry=qry+" and SUBJECTTYPE='"+mSubjType+"'";
						rse12=db.getRowset(qry);
						String str1="";
					//	out.println(qry);
						if(rse12.next())
						{
							if(mSubjType.equals("C"))
							{

							str1="Checked";
							//mFlagstr1="1";
	//						mMaxCrLmtAld=mMaxCrLmtAld+mCourseCrPt;
							}

							/*else if(mSubjType.equals("E") || mSubjType.equals("F")){
								if(rse12.getInt("chc")<=eee)
								{
								//	out.println("hello");
									mMaxCrLmtAld=mMaxCrLmtAld+mCourseCrPt;
									str1="selected";
									choise=rse12.getString("chc");
									value="N";
								}
								else
								{
									str1="selected";
									choise=rse12.getString("chc");
									value="Y";
								}
								//out.println(rse12.getInt("chc")>=eee);
							}*/
							//out.println(eee);
						}
						else
						{
							str1="";
							//mFlagstr1="";
						}


					if(mSubjType.equals("C"))
					{
						mSubjTypeDesc="CORE";
						%><tr bgcolor="<%=mColor%>"><%
					}

					else
					{
						mSubjTypeDesc=" ";
						%><tr bgcolor=""><%
					}

					%>


					<td align=center><Font face=arial size=2><%=mSno%>.</font></td>
					<td align=center><Font face=arial size=2 COLOR=RED>IMPROVEMENT</font></td>
					<%

					if(mSubjType.equals("E"))
					{
						%>
						<td align=center><Font face=arial size=2><%=mSubjTypeDesc%> (<%=mElecCode%>)</font></td>
						<%
					}
					else
					{
						%>
						<td align=center><Font face=arial size=2><%=mSubjTypeDesc%></font></td>
						<%
					}
					%>
					<td><Font face=arial size=2><%=mSubjName%>  <Font color=red size=2> Fee Amount - Rs.<%=FeeAmt%></font></td>
					<td align=center><Font face=arial size=2><%=mCourseCrPt%></font><INPUT TYPE="hidden" NAME="cr<%=mSno%>" value="<%=mCourseCrPt%>">


					</td>

					<%
					if(mSubjType.equals("C"))
					{

						//out.println(mFlagstr1);
						if(!mFlagstr1.equals("1"))
						{

							//out.println("sunny");
							mMaxCrLmtTkn=mMaxCrLmtTkn+mCourseCrPt;

							if(mMaxCrLmtTkn<=mMaxCrLmt )
							{

								//out.println("sunny"+mMaxCrLmtTkn);


								//mMaxCrLmtAld=mMaxCrLmtTkn;
								//current core
								%>
								<td align=center> <input Type=checkbox id='<%=mName1%>' name='<%=mName1%>' value='Y'  onclick="FunRefresh('<%=mCourseCrPt%>', '<%=mSno%>','<%=mBasket%>','<%=mName1%>')">
								</td>
								<%
									Count++;
							}
							else
							{
								//out.println("ankur  "+mMaxCrLmtTkn);
								%>
								<td align=center> <input Type=checkbox <%=str1%> id='<%=mName1%>' name='<%=mName1%>' value='Y' onclick="FunRefresh('<%=mCourseCrPt%>', '<%=mSno%>','<%=mBasket%>','<%=mName1%>')" ></td>
								<%

							}
						}
						else
						{


							//out.print(mCourseCrPt+" ddddddddddd :: "+mMaxCrLmtTkn+"  mMaxCrLmtAld"+mMaxCrLmtAld);

							if( !str1.equals(""))
							{
								mMaxCrLmtTkn=mCourseCrPt+mMaxCrLmtAld;
								mMaxCrLmtAld=mMaxCrLmtTkn;
								//out.print(" str1 :: "+mMaxCrLmtTkn);
							}
							if(mMaxCrLmtTkn<=mMaxCrLmt)
							{

								//	mMaxCrLmtAld=mMaxCrLmtTkn;
						//		out.println(mMaxCrLmtAld + " --- ");
								//current core  FunRefresh
//click to print receipt for payment after Draft Save


								%>
								<td align=center><input Type=checkbox <%=str1%> id='<%=mName1%>' name='<%=mName1%>' value='Y' onclick="FunRefresh('<%=mCourseCrPt%>', '<%=mSno%>','<%=mBasket%>','<%=mName1%>')" >
								</td>
								<%
									Count++;
							}
							else
							{

								//out.println(mMaxCrLmtAld + " -fdf-- ");
								%>
								<td align=center><input Type=checkbox <%=str1%> id='<%=mName1%>' name='<%=mName1%>' value='Y' onclick="FunRefresh('<%=mCourseCrPt%>', '<%=mSno%>','<%=mBasket%>','<%=mName1%>')" ></td>
								<%


							}

						}

					}

					%>

					<input Type=HIDDEN id='Improvement<%=mSno%>' name='Improvement<%=mSno%>' value='Y'>

						<input Type=hidden id='FeeAmt<%=mSno%>' name='FeeAmt<%=mSno%>' value='<%=FeeAmt%>'>
					<input Type=hidden id='<%=mName2%>' name='<%=mName2%>' value='<%=mSemester%>'>
					<input Type=hidden id='<%=mName3%>' name='<%=mName3%>' value='GIP'>
					<input Type=hidden id='<%=mName4%>' name='<%=mName4%>' value='<%=mSubjType%>'>
					<input Type=hidden id='<%=mName5%>' name='<%=mName5%>' value='<%=mSubjId%>'>
					<input Type=hidden id='<%=mName6%>' name='<%=mName6%>' value='<%=mSubjName%>'>
					<input Type=hidden id='<%=mName7%>' name='<%=mName7%>' value='<%=mCourseCrPt%>'>
					<input Type=HIDDEN id='<%=mName8%>' name='<%=mName8%>' value='<%=mElecCode%>'>
					<input Type=HIDDEN id='<%=mName9%>' name='<%=mName9%>' value='<%=mBasket%>'>
					<input Type=HIDDEN id='<%=mName10%>' name='<%=mName10%>' value='<%=mChoice%>'>






					</tr>
					<%
				}

//------------------------------------------------------------------------------------------------------------------------------------



//--------------------------------------improvement  basket=B  --------------------------------------------------




	qry1="SELECT DISTINCT A.ELECTIVECODE ELECTIVECODE,a.subjectid subjectid,                                     b.subject|| ' ('|| b.subjectcode || ')'                                  Subj,                                  a.coursecreditpoint coursecreditpoint                                 FROM pr#electivesubjects a,                                  subjectmaster b,                                  studentresult c,                                  studentmaster d                            WHERE (B.subject NOT LIKE '%PROJECT%'            OR B.subject LIKE '%PROJECT MANAGEMENT%') AND  a.institutecode = '"+mInst+"'                              AND a.subjectid = c.subjectid                              AND d.studentid = c.studentid                              AND d.institutecode = c.institutecode                              AND a.institutecode = c.institutecode                              AND b.subjectid = c.subjectid                              AND A.EXAMCODE='"+mExam+"' and A.ACADEMICYEAR='"+mAcad+"'                              and A.PROGRAMCODE='"+mProg+"' and A.TAGGINGFOR='"+mTag+"'                              AND A.SECTIONBRANCH='"+mySect+"'                              and nvl(A.DEACTIVE,'N')='N'                              AND a.institutecode = b.institutecode                              AND a.subjectid = b.subjectid                       and nvl(A.BASKET,'B')='B'      and (a.SUBJECTID,d.studentid) in (select distinct e.subjectid,e.studentid from studentresult e where e.INSTITUTECODE = '"+mInst+"'  and                               e.STUDENTID= '"+mChkMemID+"'  and e.grade NOT IN ('A', 'A+', 'B+','F','X')      AND exists (select 'y'                                                             FROM studentsgpacgpa x                                                             WHERE x.institutecode = '"+mInst+"'                                                              AND  x.cgpa <  "+mMinsem+"                                                             and  x.studentid= e.studentid                                                              and x.semester = "+mMaxsem+"                                                            and ( (x.semester = a.semester)                                                                     or                                                                     (e.subjectid in(select o.subjectid                                                                                      from offersubjecttagging o                                                                                      where o.institutecode ='"+mInst+"'                                                                                     and   o.examcode = '"+mExam+"'                                                                                      and   o.subjectid = e.subjectid                                                   )                                                                     )                                                                    )                                                                            )) ";

				//out.print(qry1);
					rs1=db.getRowset(qry1);

					while(rs1.next())
					{



qry2="select FEEAMOUNT from PR#LTPWiseFee a where a.INSTITUTECODE='"+ mInst +"'   AND A.EXAMCODE='"+mExam+"' AND A.MAXCOURSECREDITPOINT="+rs1.getString("coursecreditpoint")+"";
rs=db.getRowset(qry2);
if(rs.next())
		{
FeeAmt=rs.getLong("FEEAMOUNT");

		}


						mSno++;
						mColor="lightgreen";
						mSemester=mSem;
						mSemType="REG";
						mSubjType="E";
						mSubjId=rs1.getString("SUBJECTID");
						mSubjName=rs1.getString("Subj");
						mCourseCrPt=rs1.getDouble("COURSECREDITPOINT");
						mTotalCrLmtTkn=mTotalCrLmtTkn+mCourseCrPt;

						mELECTIVECODE=rs1.getString("ELECTIVECODE");

						qry="Select choice chc from PR#STUDENTSUBJECTCHOICE where INSTITUTECODE='"+mInst+"' ";
						qry=qry+" and EXAMCODE='"+mExam+"' and ACADEMICYEAR='"+mAcad+"' and PROGRAMCODE='"+mProg+"' ";
						qry=qry+" and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mySect+"'  ";
						qry=qry+" and SEMESTERTYPE='GIP' and STUDENTID='"+mChkMemID+"' and SUBJECTID='"+mSubjId+"' ";
						qry=qry+" and SUBJECTTYPE='E'";
						rse=db.getRowset(qry);
						//out.print(qry);
						if(rse.next())
						{
							mochoice=rse.getInt("chc");
							value="N";
							pdvalue="Y";
						}
						else
						{
							mochoice=0;
							pdvalue="N";
						}

						if (!mELECTIVECODE.equals(OldmELECTIVECODE))
						{
							if (mChoice==0)
								mChoice=1 ;
							else
								mChoice=0 ;
							OldmELECTIVECODE=mELECTIVECODE;
						}
						if (mChoice==0)
							mColor=mCol1;
						else
							mColor=mCol2;

						mName1="CHK"+String.valueOf(mSno).trim();
						mName2="SEM"+String.valueOf(mSno).trim();
						mName3="SEMTYP"+String.valueOf(mSno).trim();
						mName4="SUBJTYP"+String.valueOf(mSno).trim();
						mName5="SUBJID"+String.valueOf(mSno).trim();
						mName6="SUBJ"+String.valueOf(mSno).trim();
						mName7="CCP"+String.valueOf(mSno).trim();
						mName8="ELCODE"+String.valueOf(mSno).trim();
						mName9="BASKET"+String.valueOf(mSno).trim();
						mName10="CHOICE"+String.valueOf(mSno).trim();


						//	mElective=mElecCode;
							%>
							<tr bgcolor="<%=mColor%>">
							<td align=center><Font face=arial size=2><%=mSno%>.</font></td>
							<td align=center><Font face=arial size=2><Font color=red size=2>IMPROVEMENT </font></td>
							<td align=center><Font face=arial size=2>ELECTIVE (<%=mElecCode%>)  </font></td>
							<td align=left><Font face=arial size=2><%=mSubjName%>   ---  <Font color=red size=2> Fee Amount - Rs.<%=FeeAmt%> </font></td>
							<td align=center><Font face=arial size=2><%=mCourseCrPt%></font></td>
							<td nowrap align="center">

							<input Type=hidden  id='check<%=++j%>' name='<%=mName1%>' value='Y'>

							<!--onclick="Clicked('<%=mSno%>','<%=mochoice%>')"
							onchange="FunRefresh('<%=mCourseCrPt%>', '<%=mSno%>','<%=mBasket%>')"
							-->
							<input type=hidden name='temp1<%=++i%>' value="<%=value%>" size=1 id="temp1<%=i%>">
							<select name='<%=mName10%>' id='Selectf<%=i%>' onchange="Clickedsel11('<%=mSno%>','<%=mCourseCrPt%>','Selectf<%=i%>','<%=mBasket%>','<%=mTot%>')"	style="Width:40">
							<%
							//i++;
							String st1="";
							%><option selected Value=''> </option><%
							for ( m=1;m<=mTot;m++)
							{
								if(mochoice==m)
								{
									st1="Selected";
									mMaxCrLmtAld=mMaxCrLmtAld+mCourseCrPt;


								}
									else{
										st1="";

									}


									%>

									<option <%=st1%>  Value=<%=m%>><%=m%></option>
									<%



							}

							%>

							</select>
							<INPUT TYPE="hidden" NAME="pdvalue" value="<%=pdvalue%>">
							</td>


								<input Type=hidden id='FeeAmt<%=mSno%>' name='FeeAmt<%=mSno%>' value='<%=FeeAmt%>'>

					<input Type=HIDDEN id='Improvement<%=mSno%>' name='Improvement<%=mSno%>' value='Y'>

							<input Type=hidden id='<%=mName2%>' name='<%=mName2%>' value='<%=mSemester%>'>
							<input Type=hidden id='<%=mName3%>' name='<%=mName3%>' value='GIP'>
							<input Type=hidden id='<%=mName4%>' name='<%=mName4%>' value='<%=mSubjType%>'>
							<input Type=hidden id='<%=mName5%>' name='<%=mName5%>' value='<%=mSubjId%>'>
							<input Type=hidden id='<%=mName6%>' name='<%=mName6%>' value='<%=mSubjName%>'>
							<input Type=hidden id='<%=mName7%>' name='<%=mName7%>' value='<%=mCourseCrPt%>'>
							<input Type=hidden id='<%=mName8%>' name='<%=mName8%>' value='<%=mELECTIVECODE%>'>
							<input Type=hidden id='<%=mName9%>' name='<%=mName9%>' value='<%=mBasket%>'>



							</tr>
							<%
						}







//--------------------------------------improvement  basket='D' or 'E'  --------------------------------------------------



	qry1="SELECT DISTINCT A.ELECTIVECODE ELECTIVECODE,a.subjectid subjectid,                                     b.subject|| ' ('|| b.subjectcode || ')'                                  Subj,                                  a.coursecreditpoint coursecreditpoint                                 FROM pr#electivesubjects a,                                  subjectmaster b,                                  studentresult c,                                  studentmaster d                            WHERE (B.subject NOT LIKE '%PROJECT%'            OR B.subject LIKE '%PROJECT MANAGEMENT%') AND a.institutecode = '"+mInst+"'                              AND a.subjectid = c.subjectid                              AND d.studentid = c.studentid                              AND d.institutecode = c.institutecode                              AND a.institutecode = c.institutecode                              AND b.subjectid = c.subjectid                              AND A.EXAMCODE='"+mExam+"' and A.ACADEMICYEAR='"+mAcad+"'                              and A.PROGRAMCODE='"+mProg+"' and A.TAGGINGFOR='"+mTag+"'                              AND A.SECTIONBRANCH='"+mySect+"'                               and nvl(A.DEACTIVE,'N')='N'                              AND a.institutecode = b.institutecode                              AND a.subjectid = b.subjectid                       and  A.BASKET in ('D','E')       and (a.SUBJECTID,d.studentid) in (select distinct e.subjectid,e.studentid from studentresult e where e.INSTITUTECODE = '"+mInst+"'  and                               e.STUDENTID= '"+mChkMemID+"'  and e.grade NOT IN ('A', 'A+', 'B+','F','X')      AND exists (select 'y'                                                             FROM studentsgpacgpa x                                                             WHERE x.institutecode = '"+mInst+"'                                                              AND  x.cgpa <  "+mMinsem+"                                                             and  x.studentid= e.studentid                                                              and x.semester = "+mMaxsem+"                                                            and ( (x.semester = a.semester)                                                                     or                                                                     (e.subjectid in(select o.subjectid                                                                                      from offersubjecttagging o                                                                                      where o.institutecode ='"+mInst+"'                                                                                     and   o.examcode = '"+mExam+"'                                                                                      and   o.subjectid = e.subjectid                                                   )                                                                     )                                                                    )                                                                            )) ";

			//	out.print(qry1);
					rs=db.getRowset(qry1);

					while(rs.next())
					{



qry2="select FEEAMOUNT from PR#LTPWiseFee a where a.INSTITUTECODE='"+ mInst +"'   AND A.EXAMCODE='"+mExam+"' AND A.MAXCOURSECREDITPOINT="+rs1.getString("coursecreditpoint")+"";
rs1=db.getRowset(qry2);
if(rs1.next())
		{
FeeAmt=rs1.getLong("FEEAMOUNT");

		}



					mTCount++;

					mSno++;
					mColor="White";
					mSemester=rs.getInt("Semester");
					mSemType=rs.getString("SEMESTERTYPE");
					mSubjType=rs.getString("SUBJECTTYPE");
					mSubjId=rs.getString("SUBJECTID");
					mSubjName=rs.getString("Subj");
					mCourseCrPt=rs.getDouble("COURSECREDITPOINT");
					mBasket=rs.getString("BASKET");
					mTotalCrLmtTkn=mTotalCrLmtTkn+mCourseCrPt;
					if(mSubjType.equals("E"))
					{
						int len=0;
						int pos1=0;
						len=mSubjName.length();
						pos1=mSubjName.indexOf("***");
						mElecCode=mSubjName.substring(pos1+3,len);
						mSubjName=mSubjName.substring(0,pos1);
						//out.print(mElecCode+" "+mSubjName);
					}

					mName1="CHK"+String.valueOf(mSno).trim();
					mName2="SEM"+String.valueOf(mSno).trim();
					mName3="SEMTYP"+String.valueOf(mSno).trim();
					mName4="SUBJTYP"+String.valueOf(mSno).trim();
					mName5="SUBJID"+String.valueOf(mSno).trim();
					mName6="SUBJ"+String.valueOf(mSno).trim();
					mName7="CCP"+String.valueOf(mSno).trim();
					mName8="ELCODE"+String.valueOf(mSno).trim();
					mName9="BASKET"+String.valueOf(mSno).trim();
					mName10="CHOICE"+String.valueOf(mSno).trim();
/*getting draft values*/
						qry="Select distinct choice chc from PR#STUDENTSUBJECTCHOICE where INSTITUTECODE='"+mInst+"' ";
						qry=qry+" and EXAMCODE='"+mExam+"' and ACADEMICYEAR='"+mAcad+"' and PROGRAMCODE='"+mProg+"' ";
						qry=qry+" and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mySect+"'  ";
						qry=qry+" and SEMESTERTYPE='GIP' and STUDENTID='"+mChkMemID+"'  ";
						rse1212=db.getRowset(qry);

						//out.println(qry);
						while(rse1212.next())
						{
							mFlagstr1="1";
						}
						//out.println("flag : "+mFlagstr1);

						qry="Select distinct choice chc from PR#STUDENTSUBJECTCHOICE where INSTITUTECODE='"+mInst+"' ";
						qry=qry+" and EXAMCODE='"+mExam+"' and ACADEMICYEAR='"+mAcad+"' and PROGRAMCODE='"+mProg+"' ";
						qry=qry+" and TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mySect+"'  ";
						qry=qry+" and SEMESTERTYPE='GIP' and STUDENTID='"+mChkMemID+"' and SUBJECTID='"+mSubjId+"' ";
						qry=qry+" and SUBJECTTYPE='"+mSubjType+"'";
						rse12=db.getRowset(qry);
						String str1="";
						//out.println(qry);
						if(rse12.next())
						{
						//	out.println("INNNN   "+mSubjId);
							if(mSubjType.equals("C"))
							{

							str1="Checked";
							//mFlagstr1="1";
							mMaxCrLmtAld=mMaxCrLmtAld+mCourseCrPt;
							}else if(mSubjType.equals("E") || mSubjType.equals("F")){
								if(rse12.getInt("chc")<=eee)
								{
									//out.println("hello");
									mMaxCrLmtAld=mMaxCrLmtAld+mCourseCrPt;
									str1="selected";
									choise=rse12.getString("chc");
									value="N";
								}
								else
								{
									str1="selected";
									choise=rse12.getString("chc");
									value="Y";
								}
								//out.println(rse12.getInt("chc")>=eee);
							}
							//out.println(eee+"sss"+choise);
						}
						else
						{
							str1="";
							//mFlagstr1="";
							choise="";
//							out.print(electivecount+"electivecount"+choise);
						}


					 if(mSubjType.equals("E"))
					{
						mSubjTypeDesc="ELECTIVE";
						%><tr bgcolor=""><%
					}
					else if(mSubjType.equals("F"))
					{
						mSubjTypeDesc="FREE ELECTIVE";
						%><tr bgcolor=""><%
					}
					else
					{
						mSubjTypeDesc=" ";
						%><tr bgcolor=""><%
					}

					%>


					<td align=center><Font face=arial size=2><%=mSno%>.</font></td>
					<td align=center><Font face=arial size=2 COLOR=RED>IMPROVEMENT</font></td>
					<%

					if(mSubjType.equals("E"))
					{
						%>
						<td align=center><Font face=arial size=2><%=mSubjTypeDesc%> (<%=mElecCode%>)</font></td>
						<%
					}
					else
					{
						%>
						<td align=center><Font face=arial size=2><%=mSubjTypeDesc%></font></td>
						<%
					}
					%>
					<td><Font face=arial size=2><%=mSubjName%></font></td>
					<td align=center><Font face=arial size=2><%=mCourseCrPt%></font></td>
		<td align=center>
						<input Type=hidden  id='check<%=str1%>' name='<%=mName1%>' value='Y'>
						<input type=hidden name='temp<%=i%>' value="<%=value%>" size=1 id="temp<%=i%>">

						<select name='<%=mName10%>' id='Select<%=i%>' onChange="Clickedsel('<%=mSno%>','<%=mCourseCrPt%>','Select<%=i%>','<%=mBasket%>','<%=electivecount%>')"	style="Width:40">
								<%

									String st1="";
									%><option selected Value=''> </option><%
									for ( m=1;m<=electivecount;m++)
									{
										//out.print(choise+"JJJ"+m);
										if(choise.equals(String.valueOf(m)))
										{
											st1="Selected";
											//mMaxCrLmtAld=mMaxCrLmtAld+mCourseCrPt;
										}
										else
										{
												st1="";
										}

											%>

											<option <%=st1%>  Value=<%=m%>><%=m%></option>
											<%
									}
								%>
								</select>
						<!--<input Type=checkbox <%//=str1%> id='<%//=mName1%>' name='<%//=mName1%>' value='Y' onclick="FunRefresh('<%//=mCourseCrPt%>', '<%//=mSno%>','<%//=mBasket%>')">-->


						</td>
						<%
							i++;
					//}
					%>

					<input Type=HIDDEN id='Improvement<%=mSno%>' name='Improvement<%=mSno%>' value='Y'>

						<input Type=hidden id='FeeAmt<%=mSno%>' name='FeeAmt<%=mSno%>' value='<%=FeeAmt%>'>
					<input Type=hidden id='<%=mName2%>' name='<%=mName2%>' value='<%=mSemester%>'>
					<input Type=hidden id='<%=mName3%>' name='<%=mName3%>' value='GIP'>
					<input Type=hidden id='<%=mName4%>' name='<%=mName4%>' value='<%=mSubjType%>'>
					<input Type=hidden id='<%=mName5%>' name='<%=mName5%>' value='<%=mSubjId%>'>
					<input Type=hidden id='<%=mName6%>' name='<%=mName6%>' value='<%=mSubjName%>'>
					<input Type=hidden id='<%=mName7%>' name='<%=mName7%>' value='<%=mCourseCrPt%>'>
					<input Type=hidden id='<%=mName8%>' name='<%=mName8%>' value='<%=mElecCode%>'>
					<input Type=hidden id='<%=mName9%>' name='<%=mName9%>' value='<%=mBasket%>'>
					<input sType=hidden id='<%=mName10%>' name='<%=mName10%>' value='<%=mChoice%>'>



					</tr>
					<%
						}


				%>

				<input type=hidden name="Count2" id="Count2" value="<%=Count%>">
	<input type=hidden name="no" id="no" value="<%=mMaxCrLmtTkn%>">

		<input type="hidden" name="corecrpoint" value="<%=mMaxCrLmtTkn%>">

				<tr>
				<!-- <td>
<a href="PReStudentRegImprovement.jsp?ExamCode=<%=mExam%>&amp;Studentid=<%=mChkMemID%>" title="Preregistration for Improvement Subjects"
target='NEW'><FONT SIZE="2" COLOR="BLUE"> Improvement Pre-Registration</FONT>   </a>
document.frm1.TotalCCP.value
</td> -->
</tr>

				</tbody>
				<tr><td colspan=6 align=center>
				<input Type=Submit name=btn1 id=btn1 onClick='return finalsave();' Value='&nbsp;Draft Save&nbsp;'></td>
				<input Type=HIDDEN id="TotalCCP" name="TotalCCP" value=<%=mMaxCrLmt%>>
				<input Type=hidden id="TotCrLmtTkn" name="TotCrLmtTkn" value=<%=mTotalCrLmtTkn%>>
				<input Type=HIDDEN id="TotalCCPAld" name="TotalCCPAld" value=<%=mMaxCrLmtAld%>>
				<input Type=hidden id="TotalRec" name="TotalRec" value=<%=mSno%>>
				<input Type=hidden id=PREVENTCODE name=PREVENTCODE value='<%=mPrcode%>'>
				<input Type=hidden id='last' name='last' value='<%=mSno%>'>

	             <input Type=hidden id="TCount" name="TCount" value=<%=mTCount%>>

				<input Type=hidden id='minlimt' name='last' value='<%=mMinCrLmt%>'>

				</td></tr>
				</table>
				</td>
				</tr>
				</form>
				</table>
				<marquee scrolldelay=200 behavior=alternate><font color=red><b>NOTE:-</b>
				<font color=red face=arial>In case you exceed limit of <%=mMaxCrLmt%> then you can edit your choices by <br>unchecking the box of the course you wish to drop and check the box of course you wish to take.

</font></marquee><br>
				<%
			} //closing of else
		   }
		   else
		   {
			%>
			<font color=red>
			<h3><br><img src='../../Images/Error1.jpg'>
			Pre- Registration / Subjects Choices have been already Finalized by HOD! <br>
			<%
		   }
  		}
		else
		{
		%>
		<font color=red>
		<h3>	<br><img src='../../Images/Error1.jpg'>
		Pre- Registration Event has not been declared or Registration completed..</FONT></P>
		 <%
		}
	   }
	   else
	   {
		String mExamDesc="";
		qry="SELECT EXAMCODE FROM EXAMMASTER where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mExam+"' ";
		rsexam=db.getRowset(qry);
			if(rsexam.next())
		   {
				mExamDesc=rsexam.getString("EXAMCODE");
		   }



			String pc="",bc="",sc="";
			qry=" Select distinct  nvl(PROGRAMCODE,' ') PROGRAMCODE,nvl(BRANCHCODE,' ') BRANCHCODE, ";
			qry=qry+" SEMESTER SEMESTER from ";
			qry=qry+" STUDENTREGISTRATION where StudentID='" +mDID+ "' and INSTITUTECODE='"+mInst+"' and examcode='"+mExam+"' and  InstituteCode='" + mInst + "' and nvl(REGALLOW,'N')='Y'  and semestertype <>'GIP' ";
			rs=db.getRowset(qry);
 			//out.print(qry);


			if (rs.next())
			{

				pc=rs.getString("PROGRAMCODE");
				bc=rs.getString("BRANCHCODE");
				sc=rs.getString("SEMESTER");


		%>

		<form name='frm23' method="post" >
			<input type="hidden" name='y' >
		<font face=verdana color=darkbrown size=4><b>EXAM CODE :<%=mExamDesc%></b></font>

		<table  width="70%"  align="center"  border=1 cellspacing=1 cellpadding=1 class="sort-table" id="table-1">
		<tr>
		<br>
		<td >
		<font face=verdana size=2>	<B>Name: </B><%=session.getAttribute("MemberName").toString().trim()%>
		</td>
		<td>
		<font face=verdana size=2><B>Enrollment No.: </B> <%=enc.decode(session.getAttribute("MemberCode").toString().trim())%>
		</tD>
		</tr>
		<input type="hidden" name='studentID' value='<%=mDID%>'>
		<input type="hidden" name='examcode' value='<%=mExam%>'>
		<input type="hidden" name='instituteCode' value='<%=mInst%>'>


		<tr>
		<td>
		<font face=verdana size=2>	<B>Program Code:</B> <%=pc%>
		</td>
		<td>
		<font face=verdana size=2> <B>Branch Code: </B><%=bc%>
		</tD>
		</tr>
		<tr>
		<td>
			<font face=verdana size=2><B>Semester: </B> <%=sc%>
		</td>
		<%
	qry="Select to_char(Sysdate,'dd-mm-yyyy hh:mi PM')date1 from Dual";
		rs=db.getRowset(qry);
 			//out.print(qry);


			if (rs.next())
			{
				%>
				<td><font face=verdana size=2><b> Run Date :</b>  <%=rs.getString("date1")%></td>
				<%
		}
		%>		</tr>

	</table>
				<font color=Green>


			<table border=1 cellspacing=1 cellpadding=1 class="sort-table" id="table-1" >
			<thead>
			<tr bgcolor="#ff8c00" >
			<td><font color=White size=3><b>Sno</b></font></td><td><b><font size=3 color=White>Subject(Subject Code)</b></font></td><td><b><font size=3 color=White>Credit</b></font></td></tr>
		<input type="hidden" name='academicyear' value='<%=mAcad%>'>
		<input type="hidden" name='secbranch' value='<%=mySect%>'>
		<input type="hidden" name='programcode' value='<%=mProg%>'>
		<input type="hidden" name='tag' value='<%=mTag%>'>
		<input type="hidden" name='semester' value='<%=mSem%>'>


		<%
		qry=" SELECT nvl(SUBSECTIONCODE,' ')SUBSECTIONCODE FROM STUDENTMASTER WHERE STUDENTID='"+mChkMemID+"' and Institutecode='"+mInst+"'";
		rs=db.getRowset(qry);
		//out.println(qry);
		if(rs.next())
		{
			mSubSect=rs.getString(1);
		}
				mSemType="REG";
				//out.println(mSubSect+123);
				double sumcrt=0;
				qry="Select  B.Subject||' ('||B.SubjectCode||')' SUBJECT, A.COURSECREDITPOINT COURSECREDITPOINT, a.subjectid subjectid,nvl(subjecttype,'')subjecttype,semester,nvl(A.BASKET,'A')BASKET from PROGRAMSCHEME A,SUBJECTMASTER B";
				qry=qry+" where A.institutecode='"+mInst +"' and A.Academicyear='"+mAcad+"' and A.programcode='"+mProg+"' and A.TAGGINGFOR='"+mTag+"' AND A.SECTIONBRANCH='"+mySect+"' ";
				qry=qry+" and A.semester='"+sc+"' AND A.BASKET='A' AND A.institutecode=B.institutecode and A.subjectID=B.subjectID and b.INSTITUTECODE='"+mInst+"'  order by Subject";
				//out.print(qry);

				rs=db.getRowset(qry);
				//out.print(qry);
				while(rs.next())
				{



qry="Select 'Y' from PR#STUDENTSUBJECTCHOICE where 	 INSTITUTECODE ='"+mInst+"'  and EXAMCODE = '"+mExam+"'  and ACADEMICYEAR= '"+mAcad+"' and PROGRAMCODE = '"+mProg+"' and  TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mSect+"' and SEMESTER='"+rs.getString("semester")+"' and  STUDENTID='"+mDID+"' and  SUBJECTID= '"+rs.getString("subjectid")+"'  and SEMESTERTYPE= '"+mSemType+"'  and CHOICE='"+mChoice+"' and SUBJECTRUNNING='Y' and SUBSECTIONCODE= '"+mSubSect+"' ";
					ResultSet rs45=db.getRowset(qry);
					//out.println(qry);
					if(rs45.next())
				{
					mFlag=1;
				}




					mysno++;
					mSubjName=rs.getString("Subject");
					mCourseCrPt=rs.getDouble("COURSECREDITPOINT");
					%>

					<tr><td><%=mysno%>.</td>
					<td><%=mSubjName%></td>
					<%
						sumcrt=sumcrt+mCourseCrPt;
						%>
					<td><%=mCourseCrPt%></td>
					</tr>
					<%


				}



			%>
			<tr><td colspan=3 align=right ><Font color=green  face=verdana  size=3><B>Total Course Credit Point Taken By You : <%=sumcrt%><b></font></td></tr>
			<tr>
				<%
			qry1="select sum(totalearnedcredit)totalearnedcredit from STUDENTSGPACGPA where INSTITUTECODE='"+mInst+"' and  studentid= '"+mChkMemID+"' ";
				//out.print(qry1);
					rs1=db.getRowset(qry1);
					if(rs1.next())
						{
						%>
						<td colspan=5 align=right><Font color=green face=verdana size=3><B>Total Earned Credit Till Date : <%=rs1.getDouble("totalearnedcredit")%><b></font></td>
						<%

						}
				%>

					</tr>
			<%
						//Examcode check is from companyinstitutetagging current semester
double mTotalCrLmtTknPrevious=0.0;
int msemm=0;
msemm=mSem-1;

	qry="select distinct nvl(A.SUBJECT,' ')||'('||NVL(A.SUBJECTCODE,' ')||')' SUBJECT, ";
	qry=qry+" nvl(b.COURSECREDITPOINT,0)COURSECREDITPOINT, nvl(B.BASKET,'C')BASKET,A.SEMESTER||' ('||A.SEMESTERTYPE||')' sem  ";
	qry=qry+" FROM V#STUDENTSUBJECTTAGGING A, PROGRAMSUBJECTTAGGING B WHERE               ";
	qry=qry+"  A.studentid='"+mChkMemID+"' and B.institutecode='"+mInst+"' and ";
	qry=qry+" nvl(B.deactive,'N')='N' and B.SUBJECTID=A.SUBJECTID AND B.INSTITUTECODE=A.INSTITUTECODE and ";
	qry=qry+" nvl(A.deactive,'N')='N' and B.BASKET=A.BASKET AND A.EXAMCODE=B.EXAMCODE AND A.SEMESTER='"+msemm+"' ";
	//qry=qry+" B.ACADEMICYEAR=A.ACADEMICYEAR AND B.TAGGINGFOR=A.TAGGINGFOR and ";
	//qry=qry+" Group By A.SUBJECT, A.SUBJECTCODE, B.COURSECREDITPOINT, B.BASKET ";
	qry=qry+" order by basket, COURSECREDITPOINT";

	rs1=db.getRowset(qry);
	//out.print(qry);

	while(rs1.next())
	{

		mTotalCrLmtTknPrevious=mTotalCrLmtTknPrevious+Double.parseDouble(rs1.getString("COURSECREDITPOINT"));

	}
%>
<tr><td colspan=5 align=right><Font color=green face=verdana size=3><B>Credits Registered in <%=mSem-1%> Semester :</b> <b><%=mTotalCrLmtTknPrevious%></b></font></td></tr>


		</table>

		<center>
<%
if(mFlag==1)
				{
			%>
			<h3><font face="verdana" size=3> <b> You have already been registered for above Courses
Please press 'Click to Print' button for the copy of Pre-Registered subjects.</b>
<Br>
		<INPUT TYPE="button" name="Print" Value="Click to Print"  onClick="window.print();">
<%
				}
		else
				{
			if(request.getParameter("y")==null)
					{
			%>

		<INPUT TYPE="Submit" name="Save" Value="Click to Freeze" >

		<%
					}
				}
			%>

		</center>
		</form>
			<%

if(request.getParameter("y")!=null)
				{



qry="Select  B.Subject||' ('||B.SubjectCode||')' SUBJECT, A.COURSECREDITPOINT COURSECREDITPOINT, a.subjectid subjectid,nvl(subjecttype,'')subjecttype,semester,nvl(A.BASKET,'A')BASKET from PROGRAMSCHEME A,SUBJECTMASTER B";
				qry=qry+" where A.institutecode='"+mInst +"' and A.Academicyear='"+mAcad+"' and A.programcode='"+mProg+"' and A.TAGGINGFOR='"+mTag+"' AND A.SECTIONBRANCH='"+mySect+"' ";
				qry=qry+" and A.semester='"+sc+"' AND A.BASKET='A' AND A.institutecode=B.institutecode and A.subjectID=B.subjectID and b.INSTITUTECODE='"+mInst+"'  order by Subject";
				//out.print(qry);

				rs=db.getRowset(qry);
				//out.print(qry);
				while(rs.next())
				{

qry="Select 'Y' from PR#STUDENTSUBJECTCHOICE where 	 INSTITUTECODE ='"+mInst+"'  and EXAMCODE = '"+mExam+"'  and ACADEMICYEAR= '"+mAcad+"' and PROGRAMCODE = '"+mProg+"' and  TAGGINGFOR='"+mTag+"' and SECTIONBRANCH='"+mSect+"' and SEMESTER='"+rs.getString("semester")+"' and  STUDENTID='"+mDID+"' and  SUBJECTID= '"+rs.getString("subjectid")+"'  and SEMESTERTYPE= '"+mSemType+"'  and CHOICE='"+mChoice+"' and SUBJECTRUNNING='Y' and SUBSECTIONCODE= '"+mSubSect+"' ";
					ResultSet rs45=db.getRowset(qry);
					//out.println(qry);
					if(!rs45.next())
					{

							//out.println(rs.getString("subjecttype"));
							if(rs.getString("subjecttype")==null)
								aa="C";
							else
								aa=rs.getString("subjecttype");
							qry="INSERT INTO PR#STUDENTSUBJECTCHOICE ( INSTITUTECODE, EXAMCODE, ACADEMICYEAR, PROGRAMCODE,	TAGGINGFOR,";
							qry=qry+" SECTIONBRANCH,SEMESTER, STUDENTID, SUBJECTID, SEMESTERTYPE, ELECTIVECODE, CHOICE,SUBJECTRUNNING, SUBSECTIONCODE, ENTRYDATE,ENTRYBY,SUBJECTTYPE)";
							qry=qry+" VALUES ('"+mInst+"','"+mExam+"','"+mAcad+"','"+mProg+"','"+mTag+"','"+mSect+"','"+rs.getString("semester")+"',";
							qry=qry+" '"+mDID+"','"+rs.getString("subjectid")+"','"+mSemType+"','"+mElecCode+"','"+mChoice+"', 'Y','"+mSubSect+"', sysdate,'"+mDID+"','"+aa+"')";
							 pp=db.update(qry);
							//out.println(qry);
					}

					pp=3;
				}

if(pp>0 )
					{
	%>

<h3><font face="verdana" size=3> <b> You have already been registered for above Courses
Please press 'Click to Print' button for the copy of Pre-Registered subjects.</b>
<Br>
		<INPUT TYPE="button" name="Print" Value="Click to Print"  onClick="window.print();">
	<%
					}


				}



	   }
		else
		   {
			%>
			<font color=red>
	<h3>	<br><img src='../../Images/Error1.jpg'>
		Pre- Registration Event has  been Closed!  </FONT></P>
			<%
		   }
			%>
		<BR>
		</form>
		<%
	   }
	}
	else
	{
	%>
	<font color=red>
	<h3>	<br><img src='../../Images/Error1.jpg'>
		Pre- Registration Event has not been declared or Registration completed  </FONT></P>
	 <%
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
	<h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. <br><br><br>
	</font>
   <%
   }
	  //-----------------------------
}
else
{
%>
<br>
Session timeout! Please <a href="../../index.jsp">Login</a> to continue...
<%
}
}
catch(Exception e)
{
	//out.print(e);
}
%>
<center>
<table align=center><tr><td align=left>
<IMG  src="../../Images/CampusLynx.png">
</td>
<td >
<FONT size =4 style="FONT-FAMILY: ARIal"><b>Campus Lynx</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>
		</td></tr></table>
</body>
</Html>