/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var len={};
$(document).ready(function() {
    var startdate=new Date();
    var cdate=startdate.getDate();
    var cmonth=startdate.getMonth()+1;
    if(cmonth<9)
    {
        cmonth='0'+cmonth;
    }
    var cyear=startdate.getFullYear();
    $("#startdate").val(cdate+'-'+cmonth+'-'+cyear);
    $("#startdate").datepicker({
        dateFormat: 'dd-mm-yy',
        numberOfMonths: 1,
        maxDate: 0,
        Date:0,
        onSelect: function() {
            $("#startdate").datepicker("option","maxDate")
        }
    });
});

var ParentFeedBackTrans = function() {
    this.url1 = "/rest/IQACFormServices";
    this.typ="get";
    this.contType="application/json";
};


function ReqResforCombo(uri,element)
{ 
    var R = new ParentFeedBackTrans();

    $.ajax({
        url:R.url1+uri,
        type:R.typ,
        contentType:R.contType,
        success:function(e){
            for (var key in e)
            {
                $("#"+element).append("<option selected value='"+key+"'>"+ e[key]+"</option>");
            }
            },

        error : function (e){

            alert(e);
        }

    });
}


function ReqResforstudAcaddetail(uri,program,programcode,yearofAdmi,yearofPass,semester,institute,firstremarks,lastremarks,transdate)
{
    var R = new ParentFeedBackTrans();
    //alert(R.url1+uri+R.typ+R.contType);
    $.ajax({
        url:R.url1+uri,
        type:R.typ,
        contentType:R.contType,
        success:function(e){
            //  alert(e.institute);
            $("#"+programcode).val('');
            $("#"+program).val('');
            $("#"+yearofAdmi).val('');
            $("#"+yearofPass).val('');
            $("#"+semester).val('');
            $("#"+institute).val('');
            $("#"+firstremarks).val('');
            $("#"+lastremarks).val('');
            $("#"+transdate).val('');
            $("#"+programcode).val(e.programcode);
            $("#"+program).val(e.programname);
            $("#"+yearofAdmi).val(e.academicyear);
            $("#"+yearofPass).val(e.passoutyear);
            $("#"+semester).val(e.semester);
            $("#"+institute).val(e.institute);
            $("#"+firstremarks).val(e.firstremarks);
            $("#"+lastremarks).val(e.lastremarks);
      //    alert(e.transdate);
          if(e.transdate!=undefined){
                $("#"+transdate).val(e.transdate);
              //  $("#"+transdate).attr('readonly', true);
                 $("#"+transdate).datepicker().datepicker('disable');
            }else{
                $("#"+transdate).datepicker().datepicker('enable');
               var startdate=new Date();
                var cdate=startdate.getDate();
                var cmonth=startdate.getMonth()+1;
                 if(cmonth<9)
                   {
                    cmonth='0'+cmonth;
                    }
    var cyear=startdate.getFullYear();
               $("#startdate").val(cdate+'-'+cmonth+'-'+cyear);
            }
        },

        error : function (){
            alert("Error in geting student details..");
        }

    });
}

function ReqResforMastergrid(uri,element)
{
    var R = new ParentFeedBackTrans();
    //alert(R.url1+uri+R.typ+R.contType);
    $.ajax({
        url:R.url1+uri,
        type:R.typ,
        contentType:R.contType,
        success:function(e){
            $("#"+element).empty();
            var slno=0,sub=0,i=0,d=0;
            var grid="";
            var hid="";
            var phead=[];
            try{
                len.l=e.length;

                for (var k=0;k<e.length;k++)
                {
                   
                    phead.push(e[k].parentheadid);
                }
                for (var k=0;k<e.length;k++)
                {
                    if(e[k].APFEEDBACKITEMREMARKS==undefined)

                    {
                        e[k].APFEEDBACKITEMREMARKS='';
                    }
                    if(e[k].APFEEDBACKRATING==undefined){
                        e[k].APFEEDBACKRATING='';
                    }
                    if(e[k].userremarks==undefined)
                    {
                        e[k].userremarks='';
                    }

                   
                    var heading="N";

                    for(var z=0;z<phead.length;z++){
                        if(e[k].headid==phead[z]){
                           heading="Y";
                          //$("<tr>").bgcolor = "skyblue";
                           hid =e[k].headid;
                        }
                    }
                    if(e[k].parentheadid==hid)
                    {// 
                        sub++;
                    //    $("tr").css("background-color", "skyblue");
                  //   alert("$$$$$"+sub);
                    }else
                    {
                      
                    slno++;
                    sub=0;
                   // alert("#####"+slno);
                    }
                    
                    if(sub>0)

                    {
                        i++;
                   //  alert(i);
                       // alert(k-1);
                        if(sub==1)
                       { $('#row'+(k-1)).css("background-color", "skyblue");}
                   if(sub>1)
                       {
                           d=k;
                           ////alert(k);
                         //  $('#row'+(sub+1)).css("color", "blue");
                           $('#row'+(k-1)).css("color", "blue");}
                   }
                   if(d>sub)
                   {
                        $('#row'+(d)).css("color", "blue");
                   }

                       var required="",strick="";
                            if(e[k].mendatoryques=='Y')
                                {
                                    required="Y";
                                    strick="<font color='red' size='2'>*</font>";
                                    }else
                                {
                                    required="N";
                                    strick="";
                                }

                  //  alert(sub);
                  //
                    grid="<tr id=row"+k+"><td style='width: 5%' align='left'>"+slno+"."+(sub==0?" ":sub)+"</td><td style='width: 45%'  align='left' colspan=2><input type='hidden' name='questid"+k+"' id='questid"+(k+1)+"' value="+e[k].questionid+">"+e[k].questionbody+strick+"</td>";//alert(k+"@@@@@"+e[k].questionbody);
                    

                            grid=grid+"<input type='hidden' name='reqQues"+k+"' id='reqQues"+(k+1)+"' value="+required+">";
//alert(e[k].mendatoryques);
                   if(heading=="N"){

                        if(e[k].subjective=='Y')
                        {  // alert(e[k].userremarks);
                            
                            grid=grid+"<td style='width: 20%' align='left' ><input type='text' class='textbox'  style='width: 80%'   title='rating' name='rating"+k+"' id='ratingtext"+(k+1)+"'  value='"+e[k].userremarks+"'/></td>";
                            grid=grid+"<input type='hidden' name='ratingid"+k+"' id='ratingid"+(k+1)+"' value="+e[k].ratinglist3[l]+">";
                        }
                        else if(e[k].subjective=='N')
                        {
                            var ratingcombo="<select name='rating"+k+"' id='ratingCombo"+(k+1)+"'  class='combo' style='width: 80%'>";
                        ratingcombo=ratingcombo+"<option   value=''>Select Rating</option>";
                            for (var l=0;l<e[k].ratinglist1.length;l++)
                            {//alert(e[k].APFEEDBACKRATING+"#############"+e[k].ratinglist1[l]);
                                if(e[k].APFEEDBACKRATING==e[k].ratinglist1[l])
                                {
                                    ratingcombo=ratingcombo+"<option selected value="+e[k].ratinglist1[l]+">"+e[k].ratinglist2[l]+"</option>";
                                }else{

                                    ratingcombo=ratingcombo+"<option  value="+e[k].ratinglist1[l]+">"+e[k].ratinglist2[l]+"</option>";

                                }
                            }
                            ratingcombo=ratingcombo+"</select>";
                            grid=grid+"<td style='width: 20%' align='left'>"+ratingcombo+"<input type='hidden' name='ratingid"+k+"' id='ratingid"+(k+1)+"' value="+e[k].ratinglist3[l]+"></td>";
                         }  grid=grid+"<!--td style='width: 25%' align='left'><input type='hidden' class='textbox' id='itemRemarks"+(k+1)+"' name='itemRemarks"+(k+1)+"' value='"+e[k].APFEEDBACKITEMREMARKS+"'  style='width: 80%'  title='Item Remarks'></td-->";

                   
                        grid=grid+"</tr>";
                    }else{
                        grid=grid+"<td ></td></tr>";
                       
                    }
                    $("#"+element).append(grid);
                    
                }
                //alert(grid);
                $("#"+element).append("<tr><td colspan='4' align='right' bgcolor='skyblue'><input type='button' id='Savebutton' onClick='return saveData();' class='button' Value='Save'/></td></tr>");
            }catch(e){
                alert(e);
            }

        }
        ,
        error : function (){
            alert("Error in geting master grid..");
        }

    });

}
function saveData(){
    var jdata=[];
    var mdata={};
    var mdata1={};
    mdata1["transdate"]=$("#startdate").val();
    mdata1["feedback"]=$("#feedback").val();
    mdata1["studentid"]=$("#studcodename").val();
    mdata1["acadyear"]=$("#yearofAdmi").val();
    mdata1["yearofPass"]=$("#yearofPass").val();
    mdata1["program"]=$("#program").val();
    mdata1["programcode"]=$("#programcode").val();
    mdata1["semester"]=$("#semester").val();
    mdata1["firstyearremarks"]=$("#firstyearremarks").val();
    mdata1["lastyearremarks"]=$("#lastyearremarks").val();
    mdata1["institute"]=$("#institute").val();

    jdata[0]=mdata1;
    var k=0;
    for(var i=1;i<=eval(len.l);i++){
      


        mdata={};
        mdata["questid"]=$("#questid"+i).val();
        mdata["itemRemarks"]=$("#itemRemarks"+i).val();
        mdata["reqQues"]=$("#reqQues"+i).val();
        mdata["ratingCombo"]=$("#ratingCombo"+i).val();
        mdata["ratingtext"]=$("#ratingtext"+i).val();
        mdata["ratingid"]=$("#ratingid"+i).val();
        jdata[i]=mdata;
      //  alert(mdata["ratingtext"]+"@@@@@"+ mdata["ratingCombo"]);
        if(mdata["reqQues"]=='Y')
        {
            if(mdata["ratingCombo"]==''&&mdata["ratingCombo"]!=undefined){
            alert("Please enter the feedback of all mandatory questions.");
            return  false;
        }
         if(mdata["ratingtext"]==''&&mdata["ratingtext"]!=undefined){
            alert("Please enter the feedback of all mandatory questions.");
            return  false;
        }
        }
    }

$.ajax({
        url:"/rest/IQACFormServices/saverecords?griddata="+JSON.stringify(jdata)+"",
        type:"put",
        contentType:"application/json",
        success:function(e){
            alert(e.msg);
        },
        error : function (){
            alert("Error in  save master grid..");
        }
    });
}



$(document).ready(function(){
    var uri='/feedback';
    ReqResforCombo(uri,"feedback");
    uri='/student?studentid='+$("#studentid").val()+'';
    ReqResforCombo(uri,"studcodename");
    //$("#studcodename").change(function(){
        uri='/studAcaddetails?studentid='+$("#studentid").val()+'';
        ReqResforstudAcaddetail(uri,"program","programcode","yearofAdmi","yearofPass","semester","institute","firstyearremarks","lastyearremarks","startdate");
   // });
   // $("#loadForm").click(function(){
     // alert($("#startdate").val(''));
      if($("#startdate").val()=='')
        {
            alert("Please fill  Transaction Date ");
            return false;
        } //
        if($("#feedback").val()=='Select Feedback Code & Name')
        {
            alert("Please choose Feedback Code and Name");
            return false;
        }
      //  alert($("#studcodename").val());
        if($("#studcodename").val()=='Select Student Code & Name')
        {
            alert("Please choose Student code and name");
            return false;
        }
        /*if($("#firstyearremarks").val()=='')
        {
            alert("Please fill first year remarks");
            return false;
        }
        if($("#lastyearremarks").val()=='')
        {
            alert("Please fill last year remarks");
            return false;
        }
*/



        uri='/QuesGridParent?feedback=FEED0000001&studentid='+$("#studentid").val()+'';
        ReqResforMastergrid(uri,"gridbody");
  //  });

});
