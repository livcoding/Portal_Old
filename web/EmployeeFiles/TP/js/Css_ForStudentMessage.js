/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
/*   For All Institute selection     */
 function allInst()
    {try
        {var j=0;
        var k=0;
        var inst_option=document.getElementById("all_inst").selected;
       // alert(inst_option);
        if(inst_option==true)
        {var n=document.getElementById("N").value;
            //alert(n);
        
        for(var i=1;i<=n;i++){ k++;
        document.getElementById("insti"+i).selected=true;
   }
   if(k>0)
    {
    return true;
}
    }else{
        var n=document.getElementById("N").value;
        for(var i=1;i<=n;i++){
        if(document.getElementById("insti"+i).selected==true)
        {
            j++;
        }
     }
     if(j==0)
     {
         alert("Please select a institute");
         return false;
    }else
        if(j>0){
        return true;
}

    }

    }
        catch(e)
    {
      //  alert(e);
    }
   }


   /*   For All Academic Year selection     */


    function allAcademic()
    {
       try{ 
            var k=0;
            var j=0;
            var year_option=document.getElementById("all_year").selected;
           // var insti=document.getElementById("inst").selected;
     //   alert(year_option);
       if(year_option==true)
        { 
            var n=document.getElementById("years").value;
            for(var i=1;i<=n;i++){
            document.getElementById("acad_year"+i).selected=true;
            k++;}
    if(k>0)
    {
        return true;
    }

    }else{
        var n=document.getElementById("years").value;
       
        for(var i=1;i<=n;i++){
        if(document.getElementById("acad_year"+i).selected==true)
        { 
            j++;
        }
     }
     if(j==0)
     {
         alert("Please select a academic year");
         return false;
}else{
    return true;
}
}

        
}
        catch(e)
    {
        //alert(e);
    }
   }
/*   For All Program selection     */

    function allProgram()
    {try{var j=0;
         var k=0;
        var prog_option=document.getElementById("all_prog").selected;
   //alert(prog_option);
        if(prog_option==true)
        {var n=document.getElementById("programs").value;
            
            for(var i=1;i<=n;i++)
            {
         document.getElementById("prog"+i).selected=true;
    k++;
    }if(k>0)
        {
        return true;
        }
    }else{
        var n=document.getElementById("programs").value;
        for(var i=1;i<=n;i++){
        if(document.getElementById("prog"+i).selected==true)
        {
            j++;
        }
     }
     if(j==0)
     {
         alert("Please select a program code");
         return false;
}else{
       return true;
}
}
        }catch(e)
    {
      //  alert(e);
    }
   }
/*   For All Branch selection     */

    function allBranch()
    {try{var j=0,k=0;
        var branch_option=document.getElementById("all_branch").selected;
        //alert(branch_option);
        if(branch_option==true)
        {var n=document.getElementById("branches").value;
            for(var i=1;i<=n;i++){k++;
        document.getElementById("branch"+i).selected=true;
        }
        if(k>0)
    {
    return true;
    }
    }else{
        var n=document.getElementById("branches").value;
        for(var i=1;i<=n;i++){
        if(document.getElementById("branch"+i).selected==true)
        {
            j++;
        }
     }
     if(j==0)
     {
         alert("Please select a branch code");
         return false;

     }else{
      return true;
    }
}
        }catch(e)
    {
        //alert(e);
    }
   }

/*for date1 validation*/
function iSValidSubmissionDate1(pDate)
{
//alert(pDate);

//1
//alert(document.getElementById("submissiondate"+slno).value+"sdf");
if(pDate!='' && pDate!='')
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
if ((mDate.substring(0,2).trim()) >= 1 &&
(mDate.substring(0,2).trim()) <=31 &&
(mDate.substring(3, 5).trim()) <= 12 &&
(mDate.substring(3, 5).trim()) >= 1 &&
(mDate.substring(6).trim()) >= 1900 &&
(mDate.substring(6).trim()) <= 3000) { //5
dn = (mDate.substring(0, 2).trim());
mn = (mDate.substring(3,5).trim());
yn = (mDate.substring(6).trim());
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
alert('Please Enter the valid date format in  Display From Date field i.e DD-MM-YYYY.');
document.getElementById("date1").value="";
return false;

}
} //4
else
{
alert('Please Enter the valid date format in Display From Date field i.e DD-MM-YYYY.');
document.getElementById("date1").value="";
return false;
}
} //3
else
{
alert('Please Enter the valid date format in  Display From Date field i.e DD-MM-YYYY.');
document.getElementById("date1").value="";
return false;
}
//   } //2
return (mISValidDate);
}
/*else
{
//alert('Please Enter the valid date format in  Display From Date field i.e DD-MM-YYYY.');
//document.getElementById(pDate).value="";
//return false;

}*/
}

/*for date2 validation*/
function iSValidSubmissionDate2(pDate)
{
//alert(pDate);

//1
//alert(document.getElementById("submissiondate"+slno).value+"sdf");
if(pDate!='' && pDate!='')
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
if ((mDate.substring(0,2).trim()) >= 1 &&
(mDate.substring(0,2).trim()) <=31 &&
(mDate.substring(3, 5).trim()) <= 12 &&
(mDate.substring(3, 5).trim()) >= 1 &&
(mDate.substring(6).trim()) >= 1900 &&
(mDate.substring(6).trim()) <= 3000) { //5
dn = (mDate.substring(0, 2).trim());
mn = (mDate.substring(3,5).trim());
yn = (mDate.substring(6).trim());
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
alert('Please Enter the valid date format in  Display To Date field i.e DD-MM-YYYY.');
document.getElementById("date2").value="";
return false;

}
} //4
else
{
alert('Please Enter the valid date format in Display To Date field i.e DD-MM-YYYY.');
document.getElementById("date2").value="";
return false;
}
} //3
else
{
alert('Please Enter the valid date format in  Display To Date field i.e DD-MM-YYYY.');
document.getElementById("date2").value="";
return false;
}
//   } //2
return (mISValidDate);
}
/*else
{
alert('Please Enter the valid date format in  Display To Date field i.e DD-MM-YYYY.');
document.getElementById(pDate).value="";
return false;

}*/
}
/*For Validate Form*/
   function validate()
   {
       try{
   if(allInst()==true)
   {
  if(allAcademic()==true)
  {
  if(allProgram()==true)
  {
    if(allBranch()==true)
        { // alert("Gyan");
            var j=0;
            var msg=document.getElementById("msg").value;
            var date1=document.getElementById("date1").value;
            var date2=document.getElementById("date2").value;
            var msgLength=$("#msg").val().length;
            if(msg=='')
                {
                    alert("Please fill Message for students");
                    return false;
                }else  if(msgLength>=291)
                {var diff=msgLength-291;
                alert("Message length should be less than or equals to 300!Please adjust the extra or minimize the "+diff+" characters");
                return false;
                }
                else if(date1=='')
                {
                    alert("Please fill display from date");
                    return false;
                }else if(date2=='')
                    {alert("Please fill display to date");
                    return false;
                 }
                 else if(date1!=''&& date2!='')
                     {
                         var fromdate=date1.split("-");
                         date1=fromdate[0]+fromdate[1]+fromdate[2];
                         var todate=date2.split("-");
                         date2=todate[0]+todate[1]+todate[2];
                         if((date2-date1)<0)
                         {
                             alert("From date must be less than to date");
                             document.getElementById("date1").value="";
                             document.getElementById("date2").value="";
                             return false;
                        }
                        else
                        {j++;
                       document.getElementById("j").value=j;
                       document.getElementById("stud_detail").submit();
                       return true;
                    }
                      }
                 
             }
        }
    }
  }
   }catch(e){
  // alert(e);
   }
 }
 

function deleteMsg(msg)
 {try{
     var totalmsg=document.getElementById("msg_no").value;
     //alert(msg);
     var con = confirm("DO you want to delete this message?");
    if (con == true)
    {for(var i=1;i<=totalmsg;i++)
        //alert("Gyan");
        {
            document.getElementById("msgDelete"+i).href="DeleteStudentMessage.jsp?msgContent="+msg+"";
            depeletePopup();
    }
        return true;
    }
     else 
     {
    return false;
    }
 }catch(e)
 {
    // alert(e);
 }
}

$("#Inst").click(function()
{alert($("#Inst").val());});
