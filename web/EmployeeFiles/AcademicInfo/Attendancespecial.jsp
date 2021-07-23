<%@ page language="java" import="java.sql.*,java.math.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null, rs1=null,rs2=null,rsyy=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="", qry1="",mLTP="";
String mMemberID="", mDMemberID="";
String mMemberType="", mDMemberType="";
String mMemberCode="", mDMemberCode="";
String mMemberName="", mExam="",mSubject="",mexam="",mSubj="",mColor="",mCode="",mES="",mSubj1="";
String mSection="",mSubsection="", mSExam="", mSES="";
String QryExam="",QrySubj="",QryLTP="",QrySecBr="",  QryStID="", QryFSTID="",QrySubj1="";
String mltp1="", mRollno="",mStName="",Student="",ExamCode="",reason="",fromdate="",todate="";
String mInst="",QryType="R", mComp="",mDate1="",mDate2="",mFacultyName="",mFaculty="",QryFaculty="",mREGCONFIRMATIONDATE="",Subject="";
boolean flag = false, flag1 = false;
int Ctr=0, mDiffInDate=0,mSem=0,check=0,seqid=0,days=0;
double QryTotCls=0, QryTotPrs=0, QryPercAtt=0,QryLTCls=0, QryLTPrs=0, QryLTPercAtt=0;
String qrtyy="",qryx="";
String  OldAtt="", NewAtt="";


qry="select to_Char(Sysdate,'dd-mm-yyyy') date1, to_Char((Sysdate-6),'dd-mm-yyyy') date2 from dual";
rs=db.getRowset(qry);
rs.next();
//out.print(qry);
String mCurrDate=rs.getString("date1");
String mPrevDate=rs.getString("date2");
 BigDecimal  QryLTPPercDecimal=new  BigDecimal("0.00");
  BigDecimal  QryPercDecimal=new  BigDecimal("0.00");

	String QrySemType="",mStudentid="",mSpecialApproval="",mstu1="",mStu1="";
			long mPresent=0, mL=0, mT=0, mP=0, mLP=0, mTP=0, mPP=0;

								long mPercL=0,mPercT=0,mPercP=0,mPercLT=0;

String	qry2="",QrySubSec="",QryEmpID="";
ResultSet rsBatchDate=null;
int QrySem=0;
			

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
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}

if (session.getAttribute("MemberID")==null)
{
	mMemberID="";
}
else
{
	mMemberID=session.getAttribute("MemberID").toString().trim();
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
<TITLE>#### <%=mHead%> [ Students Class Attendance in Percentage(%) ] </TITLE>

<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<script language="JavaScript" type ="text/javascript" src="modernizer.js"></script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<script type='text/javascript'>
    /* attach a submit handler to the form */
    
</script>
<script language="JavaScript" type ="text/javascript">
function AlertMe()
		{
			aa.twait1.value='';
		//document.getElementById("twait1").value='';
		}	
</script>

<script type="text/javascript">

function SpecialPercentage()
{

//alert(document.frm.TotalPresent.value +" -- "+document.frm.TotalClass.value );

var TTPresent=(parseFloat(document.frm.TotalPresent.value)+parseFloat(document.frm1.days.value));
var TTClass=(parseFloat(document.frm.TotalClass.value));


var TTPerc=((TTPresent*100)/TTClass);

document.frm1.NewAtt.value=(TTPerc.toFixed(2));
	
if(isNaN(document.getElementById("NewAtt").value))
	{
	document.getElementById("NewAtt").value='';

	}
	else if(document.getElementById("NewAtt").value>100)
		{
	document.getElementById("NewAtt").value='100';
	}
}
     function isNumber(e)
            {
                var unicode=e.charCode? e.charCode : e.keyCode
                if (unicode!=8)
                { //if the key isn't the backspace key (which we should allow)
                        if ((unicode<48||unicode>57) && unicode!=46) //if not a number
                        return false //disable key press
                }
            }

    function getCurrentDateTime()
			{
				var currentDate;
				var retDateTime;
				currentDate = new Date();
                retDateTime=""+currentDate.getDate()+currentDate.getMonth()+currentDate.getFullYear()+currentDate.getHours()+currentDate.getMinutes()+currentDate.getSeconds();
				return retDateTime;
			}

function getDays()
{
var currentTime = new Date()
var month = currentTime.getMonth() + 1
var day = currentTime.getDate()
var year = currentTime.getFullYear()
var date=day+"-"+month+"-"+year;
var fromdate=document.getElementById("fromdate").value;
var todate=document.getElementById("todate").value;
	var arr=fromdate.split("-");
	
	var cdate=todate.split("-");
	//alert(parseInt(arr[0])+"***********"+parseInt(cdate[0])+"&&&&&&"+todate);
	if(parseInt(arr[0])>parseInt(cdate[0])&&parseInt(arr[1])>=parseInt(cdate[1])&&(parseInt(arr[2])>=parseInt(cdate[2])))
	{
	alert("Please fill the valid date");
	document.getElementById("todate").value='';
	document.getElementById("days").value='';
	}
	else
if(parseInt(arr[0])>parseInt(cdate[0])&&(parseInt(arr[1])>parseInt(cdate[1])))
	{
	alert("Please fill the valid date");
	document.getElementById("todate").value='';
	document.getElementById("days").value='';
	}
	
else if(parseInt(arr[1])>parseInt(cdate[1])&&(parseInt(arr[2])>parseInt(cdate[2])))
	{
	alert("Please fill the valid date");
	document.getElementById("todate").value='';
	document.getElementById("days").value='';
	}
	else if(parseInt(arr[2])>parseInt(cdate[2])&&parseInt(arr[0])>parseInt(cdate[0]))
	{
	alert("Please fill the valid date");
	document.getElementById("todate").value='';
	document.getElementById("days").value='';
	}
else if(parseInt(arr[2])>parseInt(cdate[2])||parseInt(arr[1])>parseInt(cdate[1]))
	{
	alert("Please fill the valid date");
	document.getElementById("todate").value='';
	document.getElementById("days").value='';
	}
	else if(fromdate!=''&&todate==''||fromdate==''&&todate!='')
		{
alert("Please fill the valid date range.");
	}else
		{

            document.getElementById("days").focus();
	/*
    var oneDay = 24*60*60*1000; // hours*minutes*seconds*milliseconds
    var firstDate = new Date(arr[2],arr[1],arr[0]);
	var secondDate = new Date(cdate[2],cdate[1],cdate[0]);
	var diffDays = Math.round(Math.abs((firstDate.getTime() - secondDate.getTime())/(oneDay)));
	document.getElementById("days").value=parseInt((diffDays)+1);
	if(isNaN(document.getElementById("days").value))
	{
	document.getElementById("days").value='';
	}*/
	}	
}
</script>



	<script type="text/javascript" src="sh/jquery-1.4.2.min.js"></script>
	<script type="text/javascript" src="sh/jquery.searchabledropdown-1.0.8.min.js"></script>
	<script type="text/javascript">
   
        	$(document).ready(function(){
			$("#Save").click(function(){
             $("#Exam").val();
             $("#Subject").val();
             $("#Student").val();
             $("#fromdate").val();
             $("#todate").val();
        if(this.id=="Save")  {
           $.get("updateconifrm.jsp",{Exam:$("#Exam").val(),Subject:$("#Subject").val(),Student:$("#Student").val(),fromdate:$("#fromdate").val(),todate:$("#todate").val(),dt:getCurrentDateTime()},successfunction5);
            }
		//	alert($("#MemberCode").val()+"...."+$("#DATE1").val());
//
		//$.get("get_DATEANDENROLLMENT.jsp",{member:$("#MemberCode").val(),Date:$("#DATE1").val(),dt:getCurrentDateTime()},successfunction);
            })
});
    function successfunction5(response)
    {try{
		if (response) {
            var x=response.replace(/^\s+|\s+$/gm,'');
			//alert("@@@@@@@@@"+x+"##########");
			$("#Exam").val();
             $("#Subject").val();
             $("#Student").val();
             $("#fromdate").val();
             $("#todate").val();
             $("#reason").val();
             $("#days").val();
             if(x=='N'){

             $.get("insertupdate.jsp",{Exam:$("#Exam").val(),Subject:$("#Subject").val(),Student:$("#Student").val(),fromdate:$("#fromdate").val(),todate:$("#todate").val(),days:$("#days").val(),reason:$("#reason").val(),dt:getCurrentDateTime()},successfunction6);
           //var TestVar = document.getElementById("frm1").submit();
            //            return true;
            }
			else
            {if(document.getElementById("days").value==0)
                    {
                        return false;
                    }

             var con = confirm(" The record is already exist .Do you want to update ?");
		//	alert(con);
            if(con==false)
                    {

                   
                    return false;

                    }
                    else
                    {
            $.get("insertupdate.jsp",{Exam:$("#Exam").val(),Subject:$("#Subject").val(),Student:$("#Student").val(),fromdate:$("#fromdate").val(),todate:$("#todate").val(),days:$("#days").val(),reason:$("#reason").val(),dt:getCurrentDateTime()},successfunction6);
                    }
        }
		}
    }catch(e)
    {
       alert(e);
    }
   }
    function successfunction6(response)
          {
		if (response) {
            var x=response.replace(/^\s+|\s+$/gm,'');
                x=x.split(".");
                x1=x[0];
                x2=x[1];
            //alert("@@@@@"+x1+"####");
           if(x1=="Error."){
                 document.getElementById("errormsg").innerHTML=x1;
                  }
			else
            {
                document.getElementById("successmsg").innerHTML=x1;
                
            }
            document.getElementById("show_table").innerHTML="";
            document.getElementById("show_table").innerHTML=x2;
		}
    }







	//$(document).ready(function() {
	//	$("select").searchable();
	///	});
    	$(document).ready(function(){
			$("#days").click(function(){
             $("#Exam").val();
             $("#Subject").val();
             $("#Student").val();
             $("#fromdate").val();
             $("#todate").val();
        if(this.id=="days")  {
        }
		//	alert($("#MemberCode").val()+"...."+$("#DATE1").val());
$.get("get_Days.jsp",{Exam:$("#Exam").val(),Subject:$("#Subject").val(),Student:$("#Student").val(),fromdate:$("#fromdate").val(),todate:$("#todate").val(),dt:getCurrentDateTime()},successfunction4);
		//$.get("get_DATEANDENROLLMENT.jsp",{member:$("#MemberCode").val(),Date:$("#DATE1").val(),dt:getCurrentDateTime()},successfunction);
            })
});
    function successfunction4(response)
    {
		if (response) {

			var x=response;
			//alert(x);
			if(x==""){
			}
			else{
                document.getElementById("days").value=x;
			}
		}

   }
	
		$(document).ready(function(){		
			$("#value").html($("select#Exam :selected").text() + " (VALUE: " + $("select#Exam").val() + ")");
			$("select").change(function(){
				$("#value").html(this.options[this.selectedIndex].text + " (VALUE: " + this.value + ")");
				
				if(this.id=="Exam"){
				//	alert(this.id+"...."+this.value);
				$.get("getSubject_AttendSpceApproval.jsp",{exam:$("select#Exam").val(),dated:getCurrentDateTime()},successfunction);
				}

				if(this.id=="Subject"){
$.get("getStudent_AttendSpceApproval.jsp",{exam:$("select#Exam").val(),subj:$("select#Subject").val(),dated:getCurrentDateTime()},successfunction2);
				}

			});
		});
 $(document).ready(function(){
 $("#reset").click(function(){
     try{
            $('select#Exam').val('');
            $('select#Subject').val('');
            $('select#Student').val('');
     }catch(e)
     {
         alert(e);
     }

  });
 });

    function successfunction(response)
    {
		if (response) {
			
			var x=response+"";
			//alert(x);
			if(x==""){}
			else{
				var arrayOfStrings = x.split("$");
				$("select#Subject").empty();
				$('select#Subject').append("<option value=\"" + "" + "\">" +"Select"+ "</option>");
				for(var i=0;i<arrayOfStrings.length-1;i++){
					var t=arrayOfStrings[i].split("@");
                  
					$('select#Subject').append("<option value=\"" + t[0] + "\">" + t[1]+ "</option>");
				}
			}
		}
 
   }
   

  function successfunction2(response)
    {
		if (response) {
			var x=response+"";
			//alert(x);
			if(x==""){}
			else{
				var arrayOfStrings = x.split("$");
				$("select#Student").empty();
				$('select#Student').append("<option value=\"" + "" + "\">" +"Select"+ "</option>");
				for(var i=0;i<arrayOfStrings.length-1;i++){
					var t=arrayOfStrings[i].split("@");
                  $('select#Student').append("<option value=\"" + t[0] + "\">" + t[1]+ "</option>");
				}
			}
		}
 
   }
</script>



<script language=javascript>
            
function Validate()
{
	var msg="";
var Exam =document.getElementById("Exam").value;
var Subject=document.getElementById("Subject").value;
var Student=document.getElementById("Student").value;
//alert(Exam+"----"+Subject+"===="+Student);
var c=0;

if(Subject==(""))
	{
	msg=msg+"please select a Subject";
	c=1;
	}

if(Student==(""))
	{
	msg=msg+"\n please select a Student";
	
	c=1;
	}

if(c>0)
	{
	alert(msg);
	return false;
}

}



function Validation()
{
	var msg="";
var Exam =document.getElementById("Exam").value;
var Subject=document.getElementById("Subject").value;
var Student=document.getElementById("Student").value;
var days=document.getElementById("days").value;
var fromdate=document.getElementById("fromdate").value;
var todate=document.getElementById("todate").value;
var c=0;
if(fromdate==(""))
	{
	msg=msg+"please Fill From Date";
	c=1;
	}
if(todate==(""))
	{
	msg=msg+"\n please Fill to Date";
	c=1;
	}


if(Subject==(""))
	{
	msg=msg+"\n please select a Subject";
	c=1;
	}

if(Student==(""))
	{
	msg=msg+"\n please select a Student";
	
	c=1;
	}
if(days==(""))
	{
	msg=msg+"\n please fill the days.";
	
	c=1;
	}
if(c>0)
	{
	alert(msg);
    document.getElementById("days").focus();
    return false;
}
else if(document.getElementById("days").value==0)
    {
    alert(" There is no classes between the selected dates ");
   return false;
   document.getElementById("days").focus();
    }
else{
    return true;
    }

}


<!--
function RefreshContents()
{ 	
	document.frm.x.value='ddd';
	document.frm.submit();
}
//-->
</script>
<script type="text/javascript" src="js/TimePicker.js"></script>

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body onload="return AlertMe();"  aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<form name="aa" id="aa">
<center>
<input style="width:150px;font-size:15px; 
	color:red;font-weight:bold;BORDER-LEFT: c00000 0px solid;BORDER-TOP: c00000 0px solid;
	BORDER-RIGHT: c00000 0px solid;BORDER-BOTTOM: c00000 0px solid ; background-color:transparent;display:none"  name="twait1" readonly id="twait1" type="text" value="Please Wait......." >
</center>
</form>
<%

try
{
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
		qry="Select WEBKIOSK.ShowLink('299','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		//out.print(qry);
	 	RsChk= db.getRowset(qry);

		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{
			//out.print("*********************************");
  //----------------------
			%>
			
			<form name="frm" id="frm" method="post">
			<input id="x" name="x" type=hidden value="x">
			<center><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY:arial">Attendance Special Approval</font></center>
            <%try{%><table id=id2 cellpadding=1 cellspacing=1 align=center rules=groups border=2 width="80%">
			<!--Institute****-->
			<Input Type=hidden name=InstCode Value=<%=mInst%>>
			<tr>
			<td nowrap >
			<FONT color="black" face="Arial" size="2"><b>Exam Code :</b></FONT><font color="red" size="2"><b>*</b></font>
			<%
			
				qry=" Select Exam from (";
				qry+=" Select nvl(EXAMCODE,' ') Exam, EXAMPERIODFROM from EXAMMASTER Where INSTITUTECODE='"+mInst+"' AND nvl(LOCKEXAM,'N')='N' AND ";
            	      qry+=" nvl(Deactive,'N')='N' and nvl(EXCLUDEINATTENDANCE,'N')='N' ";
				qry+=" and examcode in (Select examcode from facultysubjecttagging where fstid in (select fstid from studentattendance))";
	                  //qry+=" and examcode in (select EXAMCODEFORATTENDNACEENTRY from COMPANYINSTITUTETAGGING Where InstituteCode='" + mInst + "' And CompanyCode='" + mComp + "') ";
      	            qry+=" order by EXAMPERIODFROM DESC";
				qry+=") where rownum<8"; 
				//out.print(qry);
				rs=db.getRowset(qry);%>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<Select Name="Exam" tabindex="0" id="Exam">	

                    <OPTION Value ="">Select</option>
					<%if(request.getParameter("x")==null)
                        {
					while(rs.next())
					{
						mExam=rs.getString("Exam");
						if(mExam.equals(request.getParameter("Exam")))
			 			{
							mexam=mExam;
							QryExam=mExam;
							%>
							<OPTION Selected  Value =<%=mExam%>><%=rs.getString("Exam")%></option>
							<%
						}
						else
						{
							%>
							<OPTION Value =<%=mExam%>><%=rs.getString("Exam")%></option>
							<%
						}
					ExamCode=request.getParameter("Exam")==null?"":request.getParameter("Exam");
					}
                    }else
                        {
                    while(rs.next())
					{
						mExam=rs.getString("Exam");
						if(mExam.equals(request.getParameter("Exam")))
			 			{
							mexam=mExam;
							QryExam=mExam;
							%>
							<OPTION Selected  Value =<%=mExam%>><%=rs.getString("Exam")%></option>
							<%
						}
						else
						{
							%>
							<OPTION Value =<%=mExam%>><%=rs.getString("Exam")%></option>
							<%
						}
					ExamCode=request.getParameter("Exam")==null?"":request.getParameter("Exam");
					}
                    }
					%>
					</select>
			<%
						
				
			 rs2=null;
			// out.print("x="+request.getParameter("x"));
			 %>
			
				</td>
				</tr>
				<tr>
				<td nowrap>	
	<FONT color=black face=Arial size=2><b>Subject :</b></FONT><font color="red" size="2"><b>*</b></font>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<Select Id="Subject"  Name="Subject">
 <option value=""><--select--></option>
<% 	qry= "Select  Distinct F.SubjectID SubjectID,S.SUBJECT,S.SUBJECTCODE From  " +
        "FACULTYSUBJECTTAGGING F,SubjectMaster S Where F.INSTITUTECODE =S.INSTITUTECODE And F.SUBJECTID=S.SUBJECTID And F.InstituteCode = '"+mInst+"'  And F.ExamCode = '"+ExamCode+"' and F.EMPLOYEEID='"+mChkMemID+"'  Order By 2";
	//System.out.print(qry);
		rs2=db.getRowset(qry);
		if(request.getParameter("x")!=null )
		{
		while(rs2.next())
					{
					Subject=rs2.getString(1).trim();
					if (Subject.equals(request.getParameter("Subject").trim()))
						{
					%>
						<option selected  value=<%=rs2.getString(1)%>><%=rs2.getString(2)+"-"+rs2.getString(3)%></option>
					<%  }
					else
						{%>
					<option  value=<%=rs2.getString(1)%>><%=rs2.getString(2)+"-"+rs2.getString(3)%></option>
				<%	}
						
					}
		}	
		else
			{%>
            <option value=""><--select--></option>
				<%while(rs2.next())
					{
					Subject=rs2.getString(1);
					if (Subject.equals(request.getParameter("Subject")))
						{
					%>
						<option selected value=<%=rs2.getString(1)%>><%=rs2.getString(2)+"-"+rs2.getString(3)%></option>
					<%  }
					else
						{%>
					<option  value=<%=rs2.getString(1)%> ><%=rs2.getString(2)+"-"+rs2.getString(3)%></option>
				<%	}
						
					}
		
			}
	
		%>
		</select>
		
	</td>
</tr>

<tr>
<td nowrap>
<FONT color=black face=Arial size=2><b>Student :</b></FONT><font color="red" size="2"><b>*</b></font>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<Select Id="Student"  Name="Student">

<option value=""><--select--></option>
<% qry="  Select Distinct StudentId,StudentName,ENROLLMENTNO From V#StudentLTPDetail V  WHERE V.institutecode = '"+mInst+"'   " +
        " and  v.EMPLOYEEID='"+mChkMemID+"' ORDER BY 2 ";
			
		//System.out.print("*******************"+qry);
			rs1=db.getRowset(qry);
	if(request.getParameter("x")!=null)
		{
	
			while(rs1.next())
			
				{
					Student=rs1.getString(1).trim();
					if (Student.equals(request.getParameter("Student").trim()))
						{
					%>
					<option selected value=<%=rs1.getString(1)%>><%=rs1.getString(2)+"-"+rs1.getString(3)%></option>
					<%  }
					else
						{%>
					<option  value=<%=rs1.getString(1)%> ><%=rs1.getString(2)+"-"+rs1.getString(3)%></option>
				<%	}

			}		
			}
			else
			{%> <option value=""><--select--></option>
			<%	while(rs1.next())
				{
					Student=rs1.getString(1);
					if (Student.equals(request.getParameter("Student")))
						{
					%>
						<option  value=<%=rs1.getString(1)%>><%=rs1.getString(2)+"-"+rs1.getString(3)%></option>
					<%  }
					else
						{%>
					<option  value=<%=rs1.getString(1)%> ><%=rs1.getString(2)+"-"+rs1.getString(3)%></option>
				<%	}

				}
		
			}
			Student=request.getParameter("Student")==null?"":request.getParameter("Student");
			%>
			
		</select>
			
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</td>
	</tr>
		<tr>
		<td width="100%" align="center">
		<input type="Submit"   value="Submit" onclick="return Validate();" >
		
        </td>
		</tr>
</table>

	<%}catch(Exception e)
            {
    System.out.print("Gyan1"+e);
    }

		if(request.getParameter("x")!=null ){


Student=request.getParameter("Student")==null?"":request.getParameter("Student");
//out.print(request.getParameter("x")+"@@@@@@@@@@@@@@@@@");

qrtyy="select 'Y' from GRADECALCULATION where EXAMCODE='"+ExamCode+"' and SUBJECTID='"+Subject+"' and institutecode='"+mInst+"' and nvl(STATUS,'N') <> 'A' and  nvl(FINALIZED,'N') <>'Y'  " ;
		rsyy=db.getRowset(qrtyy);
		 //out.print(qrtyy);
//if(rsyy.next())
	if(1==1)

		{
		//out.print(Subject+" --------"+Student+ "-------"+ ExamCode);
		qry="select distinct nvl(SUBJECT,' ') ||' - '|| NVL(SUBJECTCODE,' ') Subject , SUBJECTID,ACADEMICYEAR, SEMESTER, STUDENTID,NVL(SEMESTERTYPE,' ')SEMESTERTYPE ";
		qry=qry+" from V#STUDENTLTPDETAIL A where  NVL(A.DEACTIVE,'N')='N' and nvl(STUDENTDEACTIVE,'N')='N' and A.examcode='"+ExamCode+"' and a.STUDENTID='"+Student+"'  and a.INSTITUTECODE='"+mInst+"' and a.subjectid='"+Subject+"'  ";
		qry=qry+" order by Subject";
	//out.print(qry);
	rs=db.getRowset(qry);
int 	msno=0;
	while(rs.next())
	{
		msno++ ;
		
		QrySemType=rs.getString("SEMESTERTYPE").toString().trim();
		QrySem=rs.getInt("SEMESTER");

		 			qry2=" Select nvl(to_char(REGCONFIRMATIONDATE,'dd-mm-yyyy'),' ') REGCONFIRMATIONDATE ,nvl(SPECIALAPPROVAL,'N')SPECIALAPPROVAL   From StudentRegistration Where INSTITUTECODE='"+mInst+"'";
					qry2=qry2+" AND EXAMCODE='"+ExamCode+"' ";
					//qry2=qry2+" AND SEMESTER='"+rs.getString("SEMESTER")+"' AND NVL(SEMESTERTYPE,' ')='REG' ";
					qry2=qry2+" AND STUDENTID='"+rs.getString("STUDENTID")+"' ";					
					qry2=qry2+" AND ACADEMICYEAR='"+rs.getString("ACADEMICYEAR")+"' ";
//out.print(qry2);
					rsBatchDate=db.getRowset(qry2);
					 if(rsBatchDate.next())
					{
							mSpecialApproval=rsBatchDate.getString("SPECIALAPPROVAL");

						if(rsBatchDate.getString("REGCONFIRMATIONDATE")==null) 
							mREGCONFIRMATIONDATE="";
						else
							mREGCONFIRMATIONDATE=rsBatchDate.getString(1);
					}
					else
					{
						mREGCONFIRMATIONDATE="";
					}


					
//----------------------------------------special case -----------------------------//

if(mSpecialApproval.equals("Y"))
	QrySem=1;
else
	QrySem=QrySem;

//----------------------------------------special case -----------------------------//

//System.out.println(Student+"###################");
// Find total No. of Classes


String mLFSTID="";
String mTFSTID="";
String mPFSTID="";
String prevLFSTID="";
String prevTFSTID="";
String prevPFSTID="";


qry1="select distinct fstid from V#StudentLTPDetail a where SubjectID= '"+rs.getString("SubjectID")+"' and EXAMCODE= '"+ExamCode+"' AND  a.LTP='L' ";
qry1=qry1+" and INSTITUTECODE='"+mInst+"' and a.studentid='"+Student+"' ";
//out.print(qry1);
rs1=db.getRowset(qry1);
	while(rs1.next())
		{
		mLFSTID=rs1.getString("fstid");			
		}

qry1="select distinct fstid from V#StudentLTPDetail a where SubjectID= '"+rs.getString("SubjectID")+"' and EXAMCODE= '"+ExamCode+"' AND  a.LTP='T' ";
qry1=qry1+" and INSTITUTECODE='"+mInst+"' and a.studentid='"+Student+"' ";
//out.println(qry1);
rs1=db.getRowset(qry1);
	while(rs1.next())
		{
		mTFSTID=rs1.getString("fstid");			
		}

		qry1="select distinct fstid from V#StudentLTPDetail a where SubjectID= '"+rs.getString("SubjectID")+"' and EXAMCODE= '"+ExamCode+"' AND  a.LTP='P' ";
qry1=qry1+" and INSTITUTECODE='"+mInst+"' and a.studentid='"+Student+"' ";
rs1=db.getRowset(qry1);
	while(rs1.next())
		{
		mPFSTID=rs1.getString("fstid");			
		}





qry1="select distinct fstid from StudentPrevAttendence a where SubjectID= '"+rs.getString("SubjectID")+"' and EXAMCODE= '"+ExamCode+"' AND  a.LTP='L' ";
qry1=qry1+" and INSTITUTECODE='"+mInst+"' and a.studentid='"+Student+"' and  trunc(attendancedate)=(select max(trunc(attendancedate)) from StudentPrevAttendence a where SubjectID= '"+rs.getString("SubjectID")+"' and EXAMCODE= '"+ExamCode+"'  AND  a.LTP='L' and INSTITUTECODE='"+mInst+"' and a.studentid='"+Student+"' ) ";
rs1=db.getRowset(qry1);
	while(rs1.next())
		{
		prevLFSTID=rs1.getString("fstid");			
		}

qry1="select distinct fstid from StudentPrevAttendence a where SubjectID= '"+rs.getString("SubjectID")+"' and EXAMCODE= '"+ExamCode+"' AND  a.LTP='T' ";
qry1=qry1+" and INSTITUTECODE='"+mInst+"' and a.studentid='"+Student+"' and  trunc(attendancedate)=(select max(trunc(attendancedate)) from StudentPrevAttendence a where SubjectID= '"+rs.getString("SubjectID")+"' and EXAMCODE= '"+ExamCode+"'  AND  a.LTP='T' and INSTITUTECODE='"+mInst+"' and a.studentid='"+Student+"' ) ";
//out.println(qry1);
rs1=db.getRowset(qry1);
	while(rs1.next())
		{
		prevTFSTID=rs1.getString("fstid");			
		}

	qry1="select distinct fstid from StudentPrevAttendence a where SubjectID= '"+rs.getString("SubjectID")+"' and EXAMCODE= '"+ExamCode+"' AND  a.LTP='P' ";
qry1=qry1+" and INSTITUTECODE='"+mInst+"' and a.studentid='"+Student+"' and  trunc(attendancedate)=(select max(trunc(attendancedate)) from StudentPrevAttendence a where SubjectID= '"+rs.getString("SubjectID")+"' and EXAMCODE= '"+ExamCode+"'  AND  a.LTP='P' and INSTITUTECODE='"+mInst+"' and a.studentid='"+Student+"' ) ";
rs1=db.getRowset(qry1);
	while(rs1.next())
		{
		prevPFSTID=rs1.getString("fstid");			
		}

long mNotAttendedAttendance=0;


// Process for L Type
mNotAttendedAttendance=0;
qry=" SELECT distinct nvl(count(pcount ),0)  pcount FROM (select distinct CLASSTIMEFROM Pcount from V#STUDENTATTENDANCE a where SubjectID= '"+rs.getString("SubjectID")+"'  and LTP='L' and EXAMCODE= '"+ExamCode+"'  AND  ( A.FSTID='"+mLFSTID+"'   OR (A.FSTID IN ( SELECT b.mergewithfstid FROM FacultySubjecttagging b where  b.examcode='"+ExamCode+"' and b.institutecode='"+mInst+"' and b.SUBJECTID='"+rs.getString("SubjectID")+"' and  b.LTP='L' and  b.FSTID='"+mLFSTID+"')))  ";                            
qry=qry+" and (("+QrySem+">1)  or ("+QrySem+"=1 and trunc(A.attendancedate) >= trunc(TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))))  and a.studentid<>'"+Student+"' ";
qry=qry+" and trunc(a.classtimefrom)<  nvl((SELECT min(trunc(c.classtimefrom)) from v#STUDENTATTENDANCE c where c.studentid='"+Student+"' and c.SubjectID= '"+rs.getString("SubjectID")+"'  and c.LTP='L' and c.EXAMCODE= '"+ExamCode+"' and c.institutecode='"+mInst+"' ),a.classtimefrom)";
qry=qry+" and INSTITUTECODE='"+mInst+"'   and nvl(DEACTIVE,'N')='N' and trunc(a.classtimefrom)<  nvl((                              SELECT min(trunc(c.classtimefrom)) from STUDENTPREVATTENDENCE c where  c.studentid='"+Student+"' and  c.SubjectID= '"+rs.getString("SubjectID")+"'  and c.LTP='L' and c.EXAMCODE= '"+ExamCode+"' and c.institutecode='"+mInst+"' ),a.classtimefrom) ";
qry=qry+" and (('"+QrySem+"'='1' and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy')) ";
qry=qry+"   or ("+QrySem+">1)        )    )";
//out.print(qry);
rs1=db.getRowset(qry);
 
//out.print("aaa1");
while(rs1.next())
		{
		mNotAttendedAttendance=rs1.getLong("pcount");
			
		}

qry=" select count(distinct CLASSTIMEFROM) tot  from V#StudentAttendance  a where SubjectID= '"+rs.getString("SubjectID")+"'  and LTP='L' and EXAMCODE=  '"+ExamCode+"' ";
qry=qry+"  AND  A.FSTID='"+prevLFSTID+"'   and INSTITUTECODE='"+mInst+"'   and a.studentid <> '"+Student+"' ";
qry=qry+" and not exists (select 1 from STUDENTPREVATTENDENCE c where c.studentid='"+Student+"' and c.SubjectID= '"+rs.getString("SubjectID")+"'  and c.LTP='L' and c.EXAMCODE= '"+ExamCode+"' and c.institutecode='"+mInst+"' and  trunc(c.CLASSTIMEFROM)= trunc(a.CLASSTIMEFROM))";
qry=qry+"  and trunc(a.attendancedate)<(  select min(c.attendancedate)  from STUDENTPREVATTENDENCE c where  c.SubjectID= '"+rs.getString("SubjectID")+"' and c.studentid='"+Student+"' ";
qry=qry+"  and c.LTP='L' and c.EXAMCODE=  '"+ExamCode+"' and c.institutecode='"+mInst+"'   and c.fstid='"+prevLFSTID+"' )";
rs1=db.getRowset(qry);

 
//out.print("aaa1");
while(rs1.next())
		{
		mNotAttendedAttendance=mNotAttendedAttendance+rs1.getLong("tot");
			
		}

 /* change by ankur
qry1="SELECT distinct count(pcount ) pcount FROM (select distinct CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+rs.getString("SubjectID")+"' and EXAMCODE= '"+ExamCode+"'   and a.ltp='L' and a.studentid='"+Student+"'   ";
qry1=qry1+" and INSTITUTECODE='"+mInst+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";
qry1=qry1+" UNION   ";
qry1=qry1+" select  distinct CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE where  subjectid ='"+rs.getString("SubjectID")+"'     AND ltp ='L'    ";
qry1=qry1+" AND examcode =  '"+ExamCode+"'   AND studentid = '"+Student+"'   ";       
qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mInst+"')";  
*/

qry1="SELECT distinct count(pcount ) pcount FROM (select distinct CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+rs.getString("SubjectID")+"' and EXAMCODE= '"+ExamCode+"'   and a.ltp='L' and a.studentid='"+Student+"'   ";
qry1=qry1+" and INSTITUTECODE='"+mInst+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";
qry1=qry1+" UNION   ";
qry1=qry1+" select  distinct CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE where  subjectid ='"+rs.getString("SubjectID")+"'     AND ltp ='L'    ";
qry1=qry1+" AND examcode =  '"+ExamCode+"'   AND studentid = '"+Student+"'   ";       

qry1=qry1+" and   NVL (deactive, 'N') = 'N' and INSTITUTECODE='"+mInst+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ) ";
//out.print(qry1);
 

rs1=db.getRowset(qry1);
while(rs1.next())
		{
		mL=rs1.getLong("pcount");	
		}
mL=mL+mNotAttendedAttendance;

qry1="SELECT distinct count(pcount ) pcount FROM (select distinct CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+rs.getString("SubjectID")+"' and EXAMCODE= '"+ExamCode+"'  and a.ltp='L' and a.studentid='"+Student+"' and nvl(a.present,'N')='Y' ";
qry1=qry1+" and INSTITUTECODE='"+mInst+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";
qry1=qry1+" UNION   ";
qry1=qry1+" select  distinct CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE where  subjectid ='"+rs.getString("SubjectID")+"'     AND ltp ='L'    ";
qry1=qry1+" AND examcode =  '"+ExamCode+"'   AND studentid = '"+Student+"' and nvl(present,'N')='Y' ";       
//qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mInst+"')";       
qry1=qry1+" and   NVL (deactive, 'N') = 'N' and INSTITUTECODE='"+mInst+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ) ";

rs1=db.getRowset(qry1);

while(rs1.next())
		{
		mLP=rs1.getLong("pcount");
			
		}

//-- For T

mNotAttendedAttendance=0;
qry=" SELECT distinct nvl(count(pcount ),0)  pcount FROM (select distinct CLASSTIMEFROM Pcount from V#STUDENTATTENDANCE a where SubjectID= '"+rs.getString("SubjectID")+"'  and LTP='T' and EXAMCODE= '"+ExamCode+"'  AND  ( A.FSTID='"+mTFSTID+"'   OR (A.FSTID IN ( SELECT b.mergewithfstid FROM FacultySubjecttagging b where  b.examcode='"+ExamCode+"' and b.institutecode='"+mInst+"' and b.SUBJECTID='"+rs.getString("SubjectID")+"' and  b.LTP='T' and  b.FSTID='"+mTFSTID+"')))  ";                            
qry=qry+" and (("+QrySem+">1)  or ( "+QrySem+"=1 and trunc(A.attendancedate) >=trunc(TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))))  and a.studentid<>'"+Student+"' ";
 qry=qry+" and trunc(a.classtimefrom)<  nvl((SELECT min(trunc(c.classtimefrom)) from v#STUDENTATTENDANCE c where c.studentid='"+Student+"' and c.SubjectID= '"+rs.getString("SubjectID")+"'  and c.LTP='T' and c.EXAMCODE= '"+ExamCode+"' and c.institutecode='"+mInst+"' ),a.classtimefrom)";
qry=qry+" and INSTITUTECODE='"+mInst+"'   and nvl(DEACTIVE,'N')='N' and trunc(a.classtimefrom)<  nvl((                              SELECT min(trunc(c.classtimefrom)) from STUDENTPREVATTENDENCE c where  c.studentid='"+Student+"' and  c.SubjectID= '"+rs.getString("SubjectID")+"'  and c.LTP='T' and c.EXAMCODE= '"+ExamCode+"' and c.institutecode='"+mInst+"' ),a.classtimefrom) ";
qry=qry+" and (('"+QrySem+"'='1' and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy')) ";
qry=qry+"   or ("+QrySem+">1)        )    )";
rs1=db.getRowset(qry);
//out.print(qry);
//out.print("aaa1");
while(rs1.next())
		{
		mNotAttendedAttendance=rs1.getLong("pcount");
		//out.print("mNotAttendedAttendance  First"+mNotAttendedAttendance);		
		}

 qry=" select count(distinct CLASSTIMEFROM) tot  from V#StudentAttendance  a where SubjectID= '"+rs.getString("SubjectID")+"'  and LTP='T' and EXAMCODE=  '"+ExamCode+"' ";
qry=qry+"  AND  A.FSTID='"+prevTFSTID+"'   and INSTITUTECODE='"+mInst+"'   and a.studentid<>'"+Student+"' ";
 qry=qry+" and not exists (select 1 from STUDENTPREVATTENDENCE c where c.studentid='"+Student+"' and c.SubjectID= '"+rs.getString("SubjectID")+"'  and c.LTP='T' and c.EXAMCODE= '"+ExamCode+"' and c.institutecode='"+mInst+"' and  trunc(c.CLASSTIMEFROM)= trunc(a.CLASSTIMEFROM))";
qry=qry+"  and trunc(a.attendancedate)<(  select min(c.attendancedate)  from STUDENTPREVATTENDENCE c where  c.SubjectID= '"+rs.getString("SubjectID")+"' and c.studentid='"+Student+"' ";
qry=qry+"  and c.LTP='T' and c.EXAMCODE=  '"+ExamCode+"' and c.institutecode='"+mInst+"'   and c.fstid='"+prevTFSTID+"' )";
rs1=db.getRowset(qry);
//out.print(qry);
//out.print("aaa1");
while(rs1.next())
		{
		mNotAttendedAttendance=mNotAttendedAttendance+rs1.getLong("tot");
		//out.print("mNotAttendedAttendance"+mNotAttendedAttendance);	
		}
qry1="SELECT distinct count(pcount ) pcount FROM (select distinct CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+rs.getString("SubjectID")+"' and EXAMCODE= '"+ExamCode+"'   and a.ltp='T' and a.studentid='"+Student+"'   ";
qry1=qry1+" and INSTITUTECODE='"+mInst+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";
qry1=qry1+" UNION   ";
qry1=qry1+" select  distinct CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE where  subjectid ='"+rs.getString("SubjectID")+"'     AND ltp ='T'    ";
qry1=qry1+" AND examcode =  '"+ExamCode+"'   AND studentid = '"+Student+"'   ";       
//qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mInst+"')";       
qry1=qry1+" and   NVL (deactive, 'N') = 'N' and INSTITUTECODE='"+mInst+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ) ";

//out.print(qry1);

rs1=db.getRowset(qry1);
while(rs1.next())
		{
		mT=rs1.getLong("pcount");
		//out.print("MT"+mT);
	}
mT=mT+mNotAttendedAttendance;

qry1="SELECT distinct count(pcount ) pcount FROM (select distinct CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+rs.getString("SubjectID")+"' and EXAMCODE= '"+ExamCode+"'   and a.ltp='T' and a.studentid='"+Student+"' and nvl(a.present,'N')='Y' ";
qry1=qry1+" and INSTITUTECODE='"+mInst+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";
qry1=qry1+" UNION   ";
qry1=qry1+" select  distinct CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE where  subjectid ='"+rs.getString("SubjectID")+"'     AND ltp ='T'    ";
qry1=qry1+" AND examcode =  '"+ExamCode+"'   AND studentid = '"+Student+"' and nvl(present,'N')='Y' ";       
//qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mInst+"')";       
qry1=qry1+" and   NVL (deactive, 'N') = 'N' and INSTITUTECODE='"+mInst+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ) ";


rs1=db.getRowset(qry1);
//out.print(qry1);
while(rs1.next())
		{
		mTP=rs1.getLong("pcount");			
		}

//		For P

mNotAttendedAttendance=0;
qry=" SELECT distinct nvl(count(pcount ),0)  pcount FROM (select distinct CLASSTIMEFROM Pcount from V#STUDENTATTENDANCE a where SubjectID= '"+rs.getString("SubjectID")+"'  and LTP='P' and EXAMCODE= '"+ExamCode+"'  AND  ( A.FSTID='"+mPFSTID+"'   OR (A.FSTID IN ( SELECT b.mergewithfstid FROM FacultySubjecttagging b where  b.examcode='"+ExamCode+"' and b.institutecode='"+mInst+"' and b.SUBJECTID='"+rs.getString("SubjectID")+"' and  b.LTP='P' and b.FSTID='"+mPFSTID+"')))  ";                            
qry=qry+" and ( ("+QrySem+">1)  or ("+QrySem+"=1 and trunc(A.attendancedate) >= trunc(TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))))  and a.studentid<>'"+Student+"' ";
 qry=qry+" and trunc(a.classtimefrom)<  nvl(( SELECT min(trunc(c.classtimefrom)) from v#STUDENTATTENDANCE c where c.studentid='"+Student+"' and c.SubjectID= '"+rs.getString("SubjectID")+"'  and c.LTP='P' and c.EXAMCODE= '"+ExamCode+"' and c.institutecode='"+mInst+"' ),a.classtimefrom)";
qry=qry+" and INSTITUTECODE='"+mInst+"'   and nvl(DEACTIVE,'N')='N' and trunc(a.classtimefrom)< nvl((                              SELECT min(trunc(c.classtimefrom)) from STUDENTPREVATTENDENCE c where  c.studentid='"+Student+"' and  c.SubjectID= '"+rs.getString("SubjectID")+"'  and c.LTP='P' and c.EXAMCODE= '"+ExamCode+"' and c.institutecode='"+mInst+"' ),a.classtimefrom) ";
qry=qry+" and (('"+QrySem+"'='1' and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy')) ";
qry=qry+"   or ("+QrySem+">1)        )    )";
rs1=db.getRowset(qry);
//out.print(qry);
//out.print("aaa1");
while(rs1.next())
		{
		mNotAttendedAttendance=rs1.getLong("pcount");	
		}

 qry=" select count(distinct CLASSTIMEFROM) tot  from V#StudentAttendance  a where SubjectID= '"+rs.getString("SubjectID")+"'  and LTP='P' and EXAMCODE=  '"+ExamCode+"' ";
qry=qry+"  AND  A.FSTID='"+prevPFSTID+"'   and INSTITUTECODE='"+mInst+"'   and a.studentid<>'"+Student+"' ";
qry=qry+" and not exists (select 1 from STUDENTPREVATTENDENCE c where c.studentid='"+Student+"' and c.SubjectID= '"+rs.getString("SubjectID")+"'  and c.LTP='P' and c.EXAMCODE= '"+ExamCode+"' and c.institutecode='"+mInst+"' and  trunc(c.CLASSTIMEFROM)= trunc(a.CLASSTIMEFROM))";
qry=qry+"  and trunc(a.attendancedate)<(  select min(c.attendancedate)  from STUDENTPREVATTENDENCE c where  c.SubjectID= '"+rs.getString("SubjectID")+"' and c.studentid='"+Student+"' ";
qry=qry+"  and c.LTP='P' and c.EXAMCODE=  '"+ExamCode+"' and c.institutecode='"+mInst+"'   and c.fstid='"+prevPFSTID+"' )";
rs1=db.getRowset(qry);
//out.print(qry);
//out.print("aaa1");
while(rs1.next())
		{
		mNotAttendedAttendance=mNotAttendedAttendance+rs1.getLong("tot");
			
		}
qry1="SELECT distinct count(pcount ) pcount FROM (select distinct CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+rs.getString("SubjectID")+"' and EXAMCODE= '"+ExamCode+"'   and a.ltp='P' and a.studentid='"+Student+"'   ";
qry1=qry1+" and INSTITUTECODE='"+mInst+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";
qry1=qry1+" UNION   ";
qry1=qry1+" select  distinct CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE where  subjectid ='"+rs.getString("SubjectID")+"'     AND ltp ='P'    ";
qry1=qry1+" AND examcode =  '"+ExamCode+"'   AND studentid = '"+Student+"'   ";       
//qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mInst+"')";       
qry1=qry1+" and   NVL (deactive, 'N') = 'N' and INSTITUTECODE='"+mInst+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ) ";

//out.print(qry1);


rs1=db.getRowset(qry1);
while(rs1.next())
		{
		mP=rs1.getLong("pcount");
		}
mP=mP+mNotAttendedAttendance;

qry1="SELECT distinct count(pcount ) pcount FROM (select distinct CLASSTIMEFROM pcount from V#STUDENTATTENDANCE a   where SubjectID= '"+rs.getString("SubjectID")+"' and EXAMCODE= '"+ExamCode+"'  and a.ltp='P' and a.studentid='"+Student+"' and nvl(a.present,'N')='Y' ";
qry1=qry1+" and INSTITUTECODE='"+mInst+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ";
qry1=qry1+" UNION   ";
qry1=qry1+" select  distinct CLASSTIMEFROM  pcount from STUDENTPREVATTENDENCE where  subjectid ='"+rs.getString("SubjectID")+"'     AND ltp ='P'    ";
qry1=qry1+" AND examcode =  '"+ExamCode+"'   AND studentid = '"+Student+"' and nvl(present,'N')='Y' ";       
//qry1=qry1+" and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mInst+"')";       
qry1=qry1+" and   NVL (deactive, 'N') = 'N' and INSTITUTECODE='"+mInst+"'  and nvl(DEACTIVE,'N')='N' and ( ("+QrySem+"=1 and trunc(ATTENDANCEDATE)>=TO_Date(nvl('"+mREGCONFIRMATIONDATE+"',ATTENDANCEDATE),'dd-mm-yyyy'))  or  ("+QrySem+">1) ) ) ";


rs1=db.getRowset(qry1);
//out.print(qry1);
while(rs1.next())
		{
		mPP=rs1.getLong("pcount");
		}



if(mL>0)
{
	mPercL=Math.round((mLP*100)/mL);
	mPercLT=Math.round(((mLP+mTP)*100)/(mL+mT));

}
else if(mP>0)
{
		mPercL=Math.round((mPP*100)/mP);		

}

}

	//	out.print(mPercL+" mPercP  mLP--"+mLP +" === ML--"+mL );
		
		long mTot=0,mTotClass=0;
		if(mLP>0)
		{
				mTot=mLP;

				mTotClass=mL;
		}
		else 
		{
				mTot=mPP;

					mTotClass=mP;
		}
		%>

		<input type="hidden" name="TotalPresent" id="TotalPresent" value="<%=mTot%>">

		<input type="hidden" name="TotalClass" id="TotalClass" value="<%=mTotClass%>">
		<input type="hidden" name="ExamCode" id="ExamCode" value="<%=ExamCode%>">
		<input type="hidden" name="Subj" id="Subj" value="<%=Subject%>">
		<input type="hidden" name="Stud" id="Stud" value="<%=Student%>">

<input type="hidden" name="Subject" id="Subject" value="<%=Subject%>">
		<input type="hidden" name="Student" id="Student" value="<%=Student%>">

	</form>
	<form name="frm1" method="post"> 
		<table id=id2 cellpadding=1 cellspacing=1 align=center rules=groups border=2 width="80%" onclick="return SpecialPercentage();return getDays()">
			<!--Institute****-->
			<Input Type="hidden" name="z" id="z">
               
			<TR>
			<td nowrap > <Input Type="hidden" name="q" id="q" value="<%=request.getParameter("x")%>">
			<FONT color="black" face="Arial" size="2"><b>From Date:</b></FONT>
			<INPUT TYPE="text" NAME=fromdate ID=fromdate size=9 tabindex=1 readonly
	maxlength=10><a href="javascript:NewCal('fromdate','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>
			<%fromdate=request.getParameter("fromdate");%>
			<FONT color="black" face="Arial" size="2"><b>To Date:</b></FONT>
			<input type="hidden" name="Subject" id="Subject" value="<%=Subject%>">
			<input type="hidden" name="Subject" id="Subject" value="<%=Subject%>">
			<INPUT TYPE="text" NAME=todate ID=todate size=9 tabindex=1 readonly
			maxlength=10 onblur="return getDays();"><a href="javascript:NewCal('todate','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date" /></a>
			
			<!-- <input type="date" id="todate" name="todate" size="8" onblur="return getDays();" maxlength=10  > --><FONT color="green" face="Arial" size="1">&nbsp;(DD-MM-YYYY)</FONT>
			<%todate=request.getParameter("todate");%>
			<FONT color="black" face="Arial" size="2"><b>No.of Classes:</b></FONT><font color="red" size="2"><b>*</b></font>
			<input type="number" id="days" readonly name="days"  onkeypress="return isNumber(event)" style="width:50px;" onblur="return SpecialPercentage()" onclick="return getDays()">
			
			</td>
			</TR>
			<tr>
			<td nowrap>
			<FONT color="black" face="Arial" size="2"><b>Old Att.%:</b></FONT>
			&nbsp;&nbsp;<input type="number" id="OldAtt" name="OldAtt" size="2" READONLY VALUE="<%=mPercL%>">
			<% OldAtt=request.getParameter("OldAtt");%>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<FONT color="black" face="Arial" size="2"><b>New Att.%:</b></FONT>
			<input type="number" id="NewAtt" name="NewAtt" size="2">
			<%
				  NewAtt=request.getParameter("NewAtt");     
			
			%>
			</td>
			</tr>
			<tr>


			<td align="LEFT"  valign="top">
			<FONT color="black" face="Arial" size="2"><b>Reason:</b></FONT>
			&nbsp;&nbsp;&nbsp;&nbsp;
           
            <INPUT TYPE="text" NAME="reason" id="reason" value="" style="width:350px;height:60px;">
			<%reason=request.getParameter("reason")==null?"":request.getParameter("reason").toString().trim();
			%>
			</td>		
			
			</tr>
			<tr>
			<td width="100%" align="center" >
			<input type="button" value="Save" id="Save" name="Save" onclick="return Validation();">
			&nbsp;&nbsp;
			<input type="Reset" value="Reset" id="reset" name="reset">
			</td>
			</tr>
	<%
				
			
			%>
		<input type="hidden" name="Exa" id="Exa" value="<%=ExamCode%>">
		<input type="hidden" name="Sub" id="Sub" value="<%=request.getParameter("Subject").trim()%>">
		<input type="hidden" name="Stu" id="Stu" value="<%=Student%>">
		<input type="hidden" name="Subject" id="Subject" value="<%=Subject%>">
		<input type="hidden" name="Student" id="Student" value="<%=Student%>">
		<input type="hidden" name="e" id="e" value="<%=request.getParameter("x")%>">
			</table>
        <br>

<%
//out.print("rrrrr"+request.getParameter("Subject").trim());
%>
		
		<!-----   Try Catch Handle  ---->
		<%
		 if(request.getParameter("Exa")==""||request.getParameter("Subject")==""||request.getParameter("Stu")=="")
			{
		out.print("<Center><font color=red size=4>Please Select a Exam Code ,Subject and  Student</font></center>");
		}}else{
		
		out.print(" &nbsp;&nbsp;&nbsp <center><b><br><br><img src='../../Images/Error1.jpg'><font align ='center' size=3 face='Arial' color='Red'> Grade Entry for selected subject and exam code has been approved and finalized. <br>");
		}}
		else if(request.getParameter("z")!=null){
			//out.print(request.getParameter("Exa"));
			//out.print(request.getParameter("Sub"));
			//out.print(request.getParameter("Stu"));	
			todate=request.getParameter("todate")==null?"":request.getParameter("todate").toString().trim();;
			fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate").toString().trim();;
			reason=request.getParameter("reason")==null?"":request.getParameter("reason").toString().trim();
			ExamCode=request.getParameter("Exa");
			Student=request.getParameter("Stu");
			Subject=request.getParameter("Sub");
		//	out.print("@@@@@@@@@ Subject :"+Subject);
		    
		%>    
<table id=id2 cellpadding=1 cellspacing=1 align=center rules=groups border=2 width="80%">
			<!--Institute****-->
			
			<TR>
			<td nowrap >
			<Input Type="hidden" name="f" id="f" value="<%=request.getParameter("e")%>">
			<FONT color="black" face="Arial" size="2"><b>From Date</b></FONT>
			<INPUT TYPE="text" NAME=fromdate ID=fromdate size=9 tabindex=1 readonly
	maxlength=10><a href="javascript:NewCal('fromdate','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>
			<%fromdate=request.getParameter("fromdate");%>
			<FONT color="black" face="Arial" size="2"><b>To Date</b></FONT>
			<INPUT TYPE="text" NAME=todate ID=todate size=9 tabindex=1 readonly
			maxlength=10 onfocus="return getDays();"><a href="javascript:NewCal('todate','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>
			
			<!-- <input type="date" id="todate" name="todate" size="8" onblur="return getDays();" maxlength=10  > --><FONT color="green" face="Arial" size="1">&nbsp;(DD-MM-YYYY)</FONT>
			<%todate=request.getParameter("todate");%>
			<FONT color="black" face="Arial" size="2"><b>No.of Classes:/b></FONT><font color="red" size="2"><b>*</b></font>
			<input type="number" id="days" name="days" readonly style="width:50px;" onblur="return SpecialPercentage(); " onclick="return getDays();" >
			
			</td>
			</TR>
			<tr>
			<td nowrap>
			&nbsp;&nbsp;<FONT color="black" face="Arial" size="2"><b>Old Att.%</b></FONT>
			<input type="number" id="OldAtt" name="OldAtt" size="2" READONLY VALUE="<%=mPercL%>">
			<%  OldAtt=request.getParameter("OldAtt");%>
			
			<FONT color="black" face="Arial" size="2"><b>New Att.%</b></FONT>
			<input type="number" id="NewAtt" name="NewAtt" size="2">
			<%  NewAtt=request.getParameter("NewAtt");%>
			</td>
			</tr>
			<tr>
			<td align="LEFT"  valign="top">
			<FONT color="black" face="Arial" size="2"><b>Reason</b></FONT>
			&nbsp;&nbsp;&nbsp;&nbsp;<INPUT TYPE="text" NAME="reason" id="reason" value="" style="width:400px;height:100px;">
			<%reason=request.getParameter("reason")==null?"":request.getParameter("reason").trim();%>
			</td></tr>
			<tr>
			<td width="100%" align="center" >
			<input type="submit" value="Save" onclick="return Validation(); ">
			&nbsp;&nbsp;
			<input type="Reset" value="Reset" name="reset" id="reset">
			</td>
			</tr>

		<input type="hidden" name="Exa" id="Exa" value="<%=ExamCode%>">
		<input type="hidden" name="Sub" id="Sub" value="<%=Subject%>">
		<input type="hidden" name="Stu" id="Stu" value="<%=Student%>">
		<input type="hidden" name="Subject" id="Subject" value="<%=Subject%>">
		<input type="hidden" name="Student" id="Student" value="<%=Student%>">
			
			</table>

</form>


<%}
	}%><center>
<div id="successmsg" name="successmsg" style="color:green"></div>
<div id="errormsg" name="errormsg" style="color:red"></div>

<div id="show_table" style="font-size:2px;">
    <% 
    if((request.getParameter("z")!=null)||(request.getParameter("x")!=null))
        {%>
				<table bgcolor="#fce9c5" class="sort-table" id="table-1" bottommargin="0" rules="groups" topmargin="0" cellspacing="0" cellpadding="0" border="1" align="center" width="80%">
				<thead>
			<tr bgcolor="#ff8c00">

						<td rowspan=2  Title="Sort on Name"><font color="White"><b>Student Name</b></font></td>
						<td rowspan=2  Title="Sort on reason"><font color="White"><b>Exam Code</b></font></td>
						<td rowspan=2  Title="Sort on Subject"><font color="White"><b>Subject Name</b></font></td>
						<td rowspan=2  Title="Sort on from date"><font color="White"><b>From Period</b></font></td>
						<td rowspan=2  Title="Sort on reason"><font color="White"><b>To Period</b></font></td>
						<td rowspan=2  Title="Sort on reason"><font color="White"><b>No.of Classes</b></font></td>
						<td rowspan=2  Title="Sort on reason"><font color="White"><b>Reason</b></font></td>
					</tr>
		</thead>


			<%

qry="SELECT DISTINCT b.seqid seqid,b.examcode examcode,nvl (TO_CHAR(b.fromperiod,'dd-mm-yyyy'),'-') " +
        "fromperiod,nvl (TO_CHAR(b.toperiod,'dd-mm-yyyy'),'-') toperiod, nvl(b.noofdays,0) noofdays," +
        " nvl(b.reasonforapproval,'N/A') reasonforapproval,S.STUDENTNAME,J.SUBJECT FROM " +
        " attendancespecialapproval b,StudentMaster S,SubjectMaster J,FACULTYSUBJECTTAGGING F Where B.STUDENTID=S.STUDENTID " +
        "And B.INSTITUTECODE=s.INSTITUTECODE And B.SUBJECTID=J.SUBJECTID And B.INSTITUTECODE=j.INSTITUTECODE" +
        " and b.examcode='"+ExamCode+"'and f.EMPLOYEEID='"+mChkMemID+"' and b.INSTITUTECODE='"+mInst+"' and  " +
        " B.INSTITUTECODE=f.INSTITUTECODE and b.companycode=f.companycode and b.examcode=f.examcode" +
        " and b.subjectid=f.subjectid order by  SUBJECT,STUDENTNAME";
			//out.print(qry);
			rs=db.getRowset(qry);
			while(rs.next())
					{
				%>
					<tr bgcolor="white">
						<td nowrap><%=rs.getString("StudentName")%></td>
						<td nowrap><%=rs.getString("EXAMCODE")%></td>
						<td nowrap><%=rs.getString("Subject")%></td>
						<td nowrap><%=rs.getString("FROMPERIOD")%></td>
						<td nowrap ><%=rs.getString("TOPERIOD")%></td>
						<td nowrap align='center'><%=rs.getString("NOOFDAYS")%></td>
						<td nowrap><%=rs.getString("REASONFORAPPROVAL").trim()%></td>
					</tr>

<%
			}%>
		</table>
        </div>
</center>
<%	}%>

    <%
	
		
		
	
	}
	}		catch(Exception e)
			{
		System.out.println("Error in main Page"+e);
		}
		
		%>
				</html>