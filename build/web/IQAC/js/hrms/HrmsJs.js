var formdata={};
var tempdata={};
var jpara = {};

function  onlineHRMS(){
    jQuery("#myiframe",top.document).css('height',$(window).height()+94);
    $( "#tabs" ).tabs().addClass( "ui-tabs-vertical ui-helper-clearfix" );
    $( "#tabs li" ).removeClass( "ui-corner-top" ).addClass( "ui-corner-left" );
    //   $(".number").numeric();
    //    $(".nondecimal").numbernondecimal();
    //    $(".nametext").alphanumeric();

    $('#tabs-1').css('height',$(window).height()-80);
    $('#tabs-2').css('height', $(window).height()-80);
    $('#tabs-3').css('height', $(window).height()-80);
    $('#tabs-4').css('height', $(window).height()-80);
    $('#tabs-5').css('height',$(window).height()-80);
    $('#tabs-6').css('height', $(window).height()-80);
    $('#tabs-7').css('height',$(window).height()-80);
    $('#tabs-8').css('height', $(window).height()-80);
    $('#tabs-9').css('height', $(window).height()-80);
    if($(window).width()<1000){
       $("#tabs").css('width',1082);
       $("#footerId").css('width',1082);
       $("#saveForm").css('margin-left','20%');
       $('#tabs').css( 'overflow','scroll');
   }
    /////////////////////////////////////
    jpara.sid='1001';
    jpara.mname='cCountry';
    jpara.labelname='Select Country';
    $("#cCountry").getServace(jpara);

     $(".addQualificationRow").click('click', function(e) {
        var rowCount = $('#qualificationTable tbody').length;
        if(eval(rowCount)==20){
            alert('Maximum 20 Rows Allowed');
            $('#qualificationTable tbody>tr:last [name=pdtransactionid]').focus();
        }
        else{
            AddQualification();
        }
    });

    $(".addPreviousExperienceRow").click('click', function(e) {
        var rowCount = $('#previousExperienceTable tbody').length;
        if(eval(rowCount)==20){
            alert('Maximum 20 Rows Allowed');
            $('#previousExperienceTable tbody>tr:last [name=pdtransactionid]').focus();
        }
        else{
            AddPreviousExperience();
        }
    });

    $(".addBookPublicationRow").click('click', function(e) {
        var rowCount = $('#bookPublicationTable tbody').length;
        if(eval(rowCount)==20){
            alert('Maximum 20 Rows Allowed');
            $('#bookPublicationTable tbody>tr:last [name=pdtransactionid]').focus();
        }
        else{
            AddBookPublication();
        }
    });


    $(".addPaperPublicationRow").click('click', function(e) {
        var rowCount = $('#paperPublicationTable tbody').length;
        if(eval(rowCount)==20){
            alert('Maximum 20 Rows Allowed');
            $('#paperPublicationTable tbody>tr:last [name=pdtransactionid]').focus();
        }
        else{
            AddPaperPublication();
        }
    });


    $(".addWorkShopRow").click('click', function(e) {
        var rowCount = $('#workShopTable tbody').length;
        if(eval(rowCount)==20){
            alert('Maximum 20 Rows Allowed');
            $('#workShopTable tbody>tr:last [name=pdtransactionid]').focus();
        }
        else{
            AddWorkShop();
        }
    });


    $(".addPresentationRow").click('click', function(e) {
        var rowCount = $('#presentationTable tbody').length;
        if(eval(rowCount)==20){
            alert('Maximum 20 Rows Allowed');
            $('#presentationTable tbody>tr:last [name=pdtransactionid]').focus();
        }
        else{
            AddPaperPresentation();
        }
    });

     $(".dQualificationRow").click('click', function(e) {
        if($('#deleteStatus').val()!='0'){
            if (eval($('.qualificationRow1').length)==1){
              $("#qualification1").val("0");$("#boardUniversity1").val("");$("#institution1").val(""); $("#division1").val("F");$("#percentage1").val("");$("#yearOfPassing1").val("");$("#areaOfQualification1").val("");$("#qRemarks1").val("");
            }
            else{
                $(this).parent().parent().parent().remove();
                 var lR=$(this).attr('id').substring(17);
                 $("#dQualificationRow"+(eval(lR)-1)).show();
            }
        } else{
            alert('No Authority To Delete');
        }
    });

    $(".dPreviousExperienceRow").click('click', function(e) {
        if($('#deleteStatus').val()!='0'){
            if (eval($('.previousExperienceRow1').length)==1){
              $("#prevOrganisation1").val("");$("#postHeld1").val("");$("#pay1").val(""); $("#natureOfJob1").val("");$("#experienceInMonths1").val("");$("#typeOfExperience1").val("");$("#remarks1").val("");$("#fromDate1").val("");$("#toDate1").val("");$("#resonForLeaving1").val("");
            }
            else{
                $(this).parent().parent().parent().remove();
                 var lR=$(this).attr('id').substring(22);
                 $("#dPreviousExperiencerow"+(eval(lR)-1)).show();
            }
        } else{
            alert('No Authority To Delete');
        }
    });


    $(".dBookPublicationRow").click('click', function(e) {
        if($('#deleteStatus').val()!='0'){
            if (eval($('.bookPublicationRow').length)==1){
              $("#bookTitle1").val("");$("#publicationYear1").val("");$("#publisherName1").val(""); $("#coAuthor1").val("");$("#bpRemarks1").val("");
            }
            else{
                $(this).parent().parent().parent().remove();
                 var lR=$(this).attr('id').substring(19);
                 $("#dBookPublicationRow"+(eval(lR)-1)).show();
            }
        } else{
            alert('No Authority To Delete');
        }
    });


    $(".dPaperPublicationRow").click('click', function(e) {
        if($('#deleteStatus').val()!='0'){
            if (eval($('.dPaperPublicationRow').length)==1){
              $("#paperType1").val("N");$("#topic1").val("");$("#nameOfJournal1").val(""); $("#monthYear1").val("");$("#pRemarks1").val("");
            }
            else{
                $(this).parent().parent().parent().remove();
                 var lR=$(this).attr('id').substring(20);
                 $("#dPaperPublicationRow"+(eval(lR)-1)).show();
            }
        } else{
            alert('No Authority To Delete');
        }
    });


    $(".dWorkShopRow").click('click', function(e) {
        if($('#deleteStatus').val()!='0'){
            if (eval($('.dWorkShopRow').length)==1){
              $("#type1").val("S");$("#title1").val("");$("#nameOfInsOrg1").val(""); $("#wMonthYear1").val("");$("#days1").val("");$("#wRemarks1").val("");
            }
            else{
                $(this).parent().parent().parent().remove();
                 var lR=$(this).attr('id').substring(12);
                 $("#dWorkShopRow"+(eval(lR)-1)).show();
            }
        } else{
            alert('No Authority To Delete');
        }
    });

    $(".dPresentationRow").click('click', function(e) {
        if($('#deleteStatus').val()!='0'){
            if (eval($('.dPresentationRow').length)==1){
              $("#pPaperType1").val("N");$("#pTopic1").val("");$("#institute1").val(""); $("#ppMonthYear1").val("");$("#ppRemarks1").val("");
            }
            else{
                $(this).parent().parent().parent().remove();
                 var lR=$(this).attr('id').substring(16);
                 $("#dPresentationRow"+(eval(lR)-1)).show();
            }
        } else{
            alert('No Authority To Delete');
        }
    });

}


$(function() {
    $( ".date" ).datepicker({
        dateFormat: 'dd/mm/yy',
        changeMonth: true,
        changeYear: true,
        yearRange: '-100:+1'
    });
});
$(function() {
    $( ".datemmyyyy" ).datepicker({
        dateFormat: 'mm/yy',
        changeMonth: true,
        changeYear: true,
        yearRange:  '-100:+1'
    });
});

function formsubmit1(){

    //            $('input').removeAttr("disabled");
    //            $('select').removeAttr("disabled");
    // document.admissionEnquiry.submit();
    alert(formdata.basicInformation.firstName);

}
function basicInformationTab(){
    var basicInformation={};
    basicInformation.initial=$("#initial").val();
    basicInformation.firstName=$("#firstName").val();
    basicInformation.middleName=$("#middleName").val();
    basicInformation.lastName=$("#lastName").val();
    basicInformation.dateofbirth=$("#dateofbirth").val();
    basicInformation.gender='M';
    basicInformation.fatherName=$("#fatherName").val();
    basicInformation.motherName=$("#motherName").val();
    basicInformation.husbandName=$("#husbandName").val();
    basicInformation.minimumSalaryRequired=$("#minimumSalaryRequired").val();
    basicInformation.applicationType=$("#applicationType").val();
    basicInformation.hrappid=$("#hrappid").val();

     basicInformation.companyid='CMP20131200000000005';
     basicInformation.instituteid='NUAGINSD1404A0000002';
     basicInformation.vacancyid='VAC00000000000000001';
     basicInformation.departmentid='NUAGDEPT1312A0000003';
     basicInformation.designationid='NUAGDESG1404A0000002';

    formdata.basicInformation=basicInformation;
}


function addressTab(){
    var addressInformation={};
    addressInformation.hrappid=$("#hrappid").val();
    addressInformation.cAddress1=$("#cAddress1").val();
    addressInformation.cCountry=$("#cCountry").val();
    addressInformation.cAddress2=$("#cAddress2").val();
    addressInformation.cState=$("#cState").val();
    addressInformation.cAddress3=$("#cAddress3").val();
    addressInformation.cCity=$("#cCity").val();
    addressInformation.cPin=$("#cPin").val();
    addressInformation.cPhoneNo=$("#cPhoneNo").val();
    addressInformation.pAddress1=$("#pAddress1").val();
    addressInformation.pCountry=$("#pCountry").val();
    addressInformation.pAddress2=$("#pAddress2").val();
    addressInformation.pState=$("#pState").val();
    addressInformation.pAddress3=$("#pAddress3").val();
    addressInformation.pCity=$("#pCity").val();
    addressInformation.pPin=$("#pPin").val();
    addressInformation.pPhoneNo=$("#pPhoneNo").val();
    addressInformation.pEmail=$("#pEmail").val();
    addressInformation.mobileCode=$("#mobileCode").val();
    addressInformation.mobile=$("#mobile").val();
    addressInformation.officePhoneNo=$("#officePhoneNo").val();
    alert(JSON.stringify(addressInformation));
    formdata.addressInformation=addressInformation;
}

function experienceTab(){
    var experience=[];
    var lRow=$('[name="prevOrganisation"]').last().attr('id').substring(16);
    for(var i=1;i<=lRow;i++){
        var experienceInformation={};
        experienceInformation.hrappid=$("#hrappid").val();
        experienceInformation.prevOrganisation=$("#prevOrganisation"+i).val();
        experienceInformation.postHeld=$("#postHeld"+i).val();
        experienceInformation.pay=$("#pay"+i).val();
        experienceInformation.natureOfJob=$("#natureOfJob"+i).val();
        experienceInformation.typeOfExperience=$("#typeOfExperience"+i).val();
        experienceInformation.remarks=$("#remarks"+i).val();
        experienceInformation.fromDate=$("#fromDate"+i).val();
        experienceInformation.toDate=$("#toDate"+i).val();
        experienceInformation.experienceInMonths=$("#experienceInMonths"+i).val();
        experienceInformation.resonForLeaving=$("#resonForLeaving"+i).val();
        experience.push(experienceInformation);
    }
  //  alert(JSON.stringify(experience));

    formdata.experienceInformation=experience;
}

function documentTab(){}
function resumeTab(){}


function bookPublicationTab(){
        var bookPublication=[];
        var lRow=$('[name="bookTitle"]').last().attr('id').substring(9);
    for(var i=1;i<=lRow;i++){
        var bookPublicationInformation={};
        bookPublicationInformation.hrappid=$("#hrappid").val();
        bookPublicationInformation.bookTitle=$("#bookTitle"+i).val();
        bookPublicationInformation.publicationYear=$("#publicationYear"+i).val();
        bookPublicationInformation.publisherName=$("#publisherName"+i).val();
        bookPublicationInformation.coAuthor=$("#coAuthor"+i).val();
        bookPublicationInformation.remarks=$("#bpRemarks"+i).val();
        bookPublication.push(bookPublicationInformation);
    }
    alert(JSON.stringify(bookPublication));
    formdata.bookPublicationInformation=bookPublication;
}


function paperPublicationTab(){
    var paperPublication=[];
    var lRow=$('[name="paperType"]').last().attr('id').substring(9);
    for(var i=1;i<=lRow;i++){
        var paperPublicationInformation={};
        paperPublicationInformation.hrappid=$("#hrappid").val();
        paperPublicationInformation.paperType=$("#paperType"+i).val();
        paperPublicationInformation.topic=$("#topic"+i).val();
        paperPublicationInformation.nameOfJournal=$("#nameOfJournal"+i).val();
        paperPublicationInformation.monthYear=$("#monthYear"+i).val();
        paperPublicationInformation.pRemarks=$("#pRemarks"+i).val();
        paperPublication.push(paperPublicationInformation);
    }
    alert(JSON.stringify(paperPublication));
    formdata.paperPublicationInformation=paperPublication;
}


function workShopTab(){
    var workShop=[];
    var lRow=$('[name="type"]').last().attr('id').substring(4);
    for(var i=1;i<=lRow;i++){
        var workShopInformation={};
        workShopInformation.hrappid=$("#hrappid").val();
        workShopInformation.type=$("#type"+i).val();
        workShopInformation.title=$("#title"+i).val();
        workShopInformation.nameOfInsOrg=$("#nameOfInsOrg"+i).val();
        workShopInformation.wMonthYear=$("#wMonthYear"+i).val();
        workShopInformation.days=$("#days"+i).val();
        workShopInformation.wRemarks=$("#wRemarks"+i).val();
        workShop.push(workShopInformation);
    }
    alert(JSON.stringify(workShop));
    formdata.workShopInformation=workShop;
}



function presentationTab(){
     var presentation=[];
     var lRow=$('[name="pPaperType"]').last().attr('id').substring(10);
     for(var i=1;i<=lRow;i++){
    var presentationInformation={};
    presentationInformation.hrappid=$("#hrappid").val();
    presentationInformation.pPaperType=$("#pPaperType"+i).val();
    presentationInformation.pTopic=$("#pTopic"+i).val();
    presentationInformation.institute=$("#institute"+i).val();
    presentationInformation.ppMonthYear=$("#ppMonthYear"+i).val();
    presentationInformation.ppRemarks=$("#ppRemarks"+i).val();
    presentation.push(presentationInformation);
     }
    alert(JSON.stringify(presentation));
    formdata.presentationInformation=presentation;
}

function getTabStatus(fl){

    var tabvalue = $('#tabno').val();
    switch(tabvalue) {
        case '0':
            basicInformationTab();
            alert((JSON.stringify(tempdata.tempbasicInformation))!=(JSON.stringify(formdata.basicInformation)));
            if((JSON.stringify(tempdata.tempbasicInformation))!=(JSON.stringify(formdata.basicInformation))){
                tempdata.tempbasicInformation=formdata.basicInformation;
                $("#hrappid").saveServace('basicInformationSave', '2001', formdata.basicInformation);
            }
            break;
        case '1':
            alert(""+tabvalue);
            addressTab();
            alert((JSON.stringify(tempdata.addressInformation))!=(JSON.stringify(formdata.addressInformation)));
            if((JSON.stringify(tempdata.addressInformation))!=(JSON.stringify(formdata.addressInformation))){
                tempdata.addressInformation=formdata.addressInformation;
                $("#tempid").saveServace('addressInformationSave', '2002', formdata.addressInformation);
            }
            break;
        case '2':

            break;
        case '3':
            experienceTab();
            alert((JSON.stringify(tempdata.experienceInformation))!=(JSON.stringify(formdata.experienceInformation)));
            if((JSON.stringify(tempdata.experienceInformation))!=(JSON.stringify(formdata.experienceInformation))){
                tempdata.experienceInformation=formdata.experienceInformation;
                $("#tempid").saveServace('experienceInformationSave', '2003', formdata.experienceInformation);
            }
            break;
        case '4':

            break;
        case '5':

            break;
        case '6':
            bookPublicationTab()
            alert((JSON.stringify(tempdata.bookPublicationInformation))!=(JSON.stringify(formdata.bookPublicationInformation)));
            if((JSON.stringify(tempdata.bookPublicationInformation))!=(JSON.stringify(formdata.bookPublicationInformation))){
                tempdata.bookPublicationInformation=formdata.bookPublicationInformation;
                $("#tempid").saveServace('bookPublicationInformationSave', '2006', formdata.bookPublicationInformation);
            }
            break;
        case '7':
            paperPublicationTab()
            alert((JSON.stringify(tempdata.paperPublicationInformation))!=(JSON.stringify(formdata.paperPublicationInformation)));
            if((JSON.stringify(tempdata.paperPublicationInformation))!=(JSON.stringify(formdata.paperPublicationInformation))){
                tempdata.paperPublicationInformation=formdata.paperPublicationInformation;
                $("#tempid").saveServace('paperPublicationInformationSave', '2007', formdata.paperPublicationInformation);
            }
            break;
        case '8':
            workShopTab()
            alert((JSON.stringify(tempdata.workShopInformation))!=(JSON.stringify(formdata.workShopInformation)));
            if((JSON.stringify(tempdata.workShopInformation))!=(JSON.stringify(formdata.workShopInformation))){
                tempdata.workShopInformation=formdata.workShopInformation;
                $("#tempid").saveServace('workShopInformationSave', '2008', formdata.workShopInformation);
            }
            break;
        case '9':
            presentationTab()
            alert((JSON.stringify(tempdata.presentationInformation))!=(JSON.stringify(formdata.presentationInformation)));
            if((JSON.stringify(tempdata.presentationInformation))!=(JSON.stringify(formdata.presentationInformation))){
                tempdata.presentationInformation=formdata.presentationInformation;
                $("#tempid").saveServace('presentationInformationSave', '2009', formdata.presentationInformation);
            }
            break;
    }

    if(fl==0){
        if(tabvalue>0)
        {
            if($('#tab'+eval(eval(tabvalue)-1)).val()!='n'){
                $("#next").removeAttr("disabled");
                $( "#tabs" ).tabs( "option", "active",eval(tabvalue)-1);
                $('#tabno').val(eval(tabvalue)-1);
            }
            else{
                $('#tabno').val(eval(tabvalue)-1);
                if($('#tabno').val()>0){
                    getTabStatus('0');
                }

            }
        }
    }
    if(fl==1){
        if(tabvalue<=9)
        {
            if($('#tab'+eval(eval(tabvalue)+1)).val()!='n'){
                $("#previous").removeAttr("disabled");
                $( "#tabs" ).tabs( "option", "active",eval(tabvalue)+1);
                $('#tabno').val(eval(tabvalue)+1);
            }
            else{
                $('#tabno').val(eval(tabvalue)+1);
                if($('#tabno').val()<7){
                    getTabStatus('1');
                }
            }
        }
    }
    if($('#tabno').val()==0){
        $("#previous").attr("disabled", true);
        $("#next").removeAttr("disabled");
    }
    if($('#tabno').val()==9){
        $("#next").attr("disabled", true);
        $("#previous").removeAttr("disabled");
    }
}

function AddQualification(){
    var lRow=$('[name="qualification"]').last().attr('id').substring(13);
    var newRow = $('.qualificationRow1:eq(0)').clone(true);
    newRow.insertAfter($('.qualificationRow1:last'));
    $(".qualificationRow1").each(function(rowNumber,currentRow){
        $("*",currentRow).each(function(){
            if(this.id.match(/(\d+)+$/)){
                this.id=this.id.replace(RegExp.$1,rowNumber+1);
            }
            if(currentRow==newRow.get(0))
            {
                switch(this.name)
                {
                    case 'qualification':{
                        $(this).val("0");break;
                    }
                    case 'boardUniversity':{
                        $(this).val("");break;
                    }
                    case 'institution':{
                        $(this).val("");break;
                    }
                    case 'division':{
                        $(this).val("F");break;
                    }
                    case 'percentage':{
                        $(this).val("");break;
                    }
                    case 'yearOfPassing':{
                        $(this).val("");break;
                    }
                    case 'areaOfQualification':{
                        $(this).val("");break;
                    }
                    case 'qRemarks':{
                        $(this).val("");break;
                    }
                }
            }
        });
    });
    $("#tab3no"+(eval(lRow)+1)).html(eval(lRow)+1+".");
    $("#dQualificationRow"+(eval(lRow))).hide();
    $("#dQualificationRow"+(eval(lRow)+1)).show();
    jQuery(".date").removeClass("hasDatepicker").datepicker({
        dateFormat: 'dd/mm/yy',
        changeMonth: true,
        changeYear: true,
        yearRange: '-100:+0'
    });
}


function AddPreviousExperience(){
    var lRow=$('[name="prevOrganisation"]').last().attr('id').substring(16);
    var newRow = $('.previousExperienceRow1:eq(0)').clone(true);
    newRow.insertAfter($('.previousExperienceRow1:last'));
    $(".previousExperienceRow1").each(function(rowNumber,currentRow){
        $("*",currentRow).each(function(){
            if(this.id.match(/(\d+)+$/)){
                this.id=this.id.replace(RegExp.$1,rowNumber+1);
            }
            if(currentRow==newRow.get(0))
            {
                switch(this.name)
                {
                    case 'prevOrganisation':{
                        $(this).val("");break;
                    }
                    case 'postHeld':{
                        $(this).val("");break;
                    }
                    case 'pay':{
                        $(this).val("");break;
                    }
                    case 'natureOfJob':{
                        $(this).val("");break;
                    }
                    case 'experienceInMonths':{
                        $(this).val("");break;
                    }
                    case 'typeOfExperience':{
                        $(this).val("");break;
                    }
                    case 'remarks':{
                        $(this).val("");break;
                    }
                    case 'fromDate':{
                        $(this).val("");break;
                    }
                    case 'toDate':{
                        $(this).val("");break;
                    }
                    case 'resonForLeaving':{
                        $(this).val("");break;
                    }
                }
            }
        });
    });
    $("#tab4no"+(eval(lRow)+1)).html(eval(lRow)+1+".");
    $("#dPreviousExperiencerow"+(eval(lRow))).hide();
    $("#dPreviousExperiencerow"+(eval(lRow)+1)).show();
    jQuery(".date").removeClass("hasDatepicker").datepicker({
        dateFormat: 'dd/mm/yy',
        changeMonth: true,
        changeYear: true,
        yearRange: '-100:+0'
    });
}


function AddBookPublication(){
    var lRow=$('[name="bookTitle"]').last().attr('id').substring(9);
    var newRow = $('.bookPublicationRow:eq(0)').clone(true);
    newRow.insertAfter($('.bookPublicationRow:last'));
    $(".bookPublicationRow").each(function(rowNumber,currentRow){
        $("*",currentRow).each(function(){
            if(this.id.match(/(\d+)+$/)){
                this.id=this.id.replace(RegExp.$1,rowNumber+1);
            }
            if(currentRow==newRow.get(0))
            {
                switch(this.name)
                {
                    case 'bookTitle':{
                        $(this).val("");break;
                    }
                    case 'publicationYear':{
                        $(this).val("");break;
                    }
                    case 'publisherName':{
                        $(this).val("");break;
                    }
                    case 'coAuthor':{
                        $(this).val("");break;
                    }
                    case 'remarks':{
                        $(this).val("");break;
                    }

                }
            }
        });
    });
    $("#tab7no"+(eval(lRow)+1)).html(eval(lRow)+1+".");
    $("#dBookPublicationRow"+(eval(lRow))).hide();
    $("#dBookPublicationRow"+(eval(lRow)+1)).show();
    jQuery(".date").removeClass("hasDatepicker").datepicker({
        dateFormat: 'dd/mm/yy',
        changeMonth: true,
        changeYear: true,
        yearRange: '-100:+0'
    });
}


function AddPaperPublication(){
    var lRow=$('[name="paperType"]').last().attr('id').substring(9);
    var newRow = $('.paperPublicationRow:eq(0)').clone(true);
    newRow.insertAfter($('.paperPublicationRow:last'));
    $(".paperPublicationRow").each(function(rowNumber,currentRow){
        $("*",currentRow).each(function(){
            if(this.id.match(/(\d+)+$/)){
                this.id=this.id.replace(RegExp.$1,rowNumber+1);
            }
            if(currentRow==newRow.get(0))
            {
                switch(this.name)
                {
                    case 'paperType':{
                        $(this).val("N");break;
                    }
                    case 'topic':{
                        $(this).val("");break;
                    }
                    case 'nameOfJournal':{
                        $(this).val("");break;
                    }
                    case 'monthYear':{
                        $(this).val("");break;
                    }
                    case 'pRemarks':{
                        $(this).val("");break;
                    }

                }
            }
        });
    });
    $("#tab8no"+(eval(lRow)+1)).html(eval(lRow)+1+".");
    $("#dPaperPublicationRow"+(eval(lRow))).hide();
    $("#dPaperPublicationRow"+(eval(lRow)+1)).show();
    jQuery(".datemmyyyy").removeClass("hasDatepicker").datepicker({
        dateFormat: 'mm/yy',
        changeMonth: true,
        changeYear: true,
        yearRange: '-100:+0'
    });
}


function AddWorkShop(){
    var lRow=$('[name="type"]').last().attr('id').substring(4);
    var newRow = $('.workShopRow:eq(0)').clone(true);
    newRow.insertAfter($('.workShopRow:last'));
    $(".workShopRow").each(function(rowNumber,currentRow){
        $("*",currentRow).each(function(){
            if(this.id.match(/(\d+)+$/)){
                this.id=this.id.replace(RegExp.$1,rowNumber+1);
            }
            if(currentRow==newRow.get(0))
            {
                switch(this.name)
                {
                    case 'type':{
                        $(this).val("S");break;
                    }
                    case 'title':{
                        $(this).val("");break;
                    }
                    case 'nameOfInsOrg':{
                        $(this).val("");break;
                    }
                    case 'wMonthYear':{
                        $(this).val("");break;
                    }
                    case 'days':{
                        $(this).val("");break;
                    }
                    case 'wRemarks':{
                        $(this).val("");break;
                    }

                }
            }
        });
    });
    $("#tab9no"+(eval(lRow)+1)).html(eval(lRow)+1+".");
    $("#dWorkShopRow"+(eval(lRow))).hide();
    $("#dWorkShopRow"+(eval(lRow)+1)).show();
    jQuery(".datemmyyyy").removeClass("hasDatepicker").datepicker({
        dateFormat: 'mm/yy',
        changeMonth: true,
        changeYear: true,
        yearRange: '-100:+0'
    });
}


function AddPaperPresentation(){
    var lRow=$('[name="pPaperType"]').last().attr('id').substring(10);
    var newRow = $('.presentationRow:eq(0)').clone(true);
    newRow.insertAfter($('.presentationRow:last'));
    $(".presentationRow").each(function(rowNumber,currentRow){
        $("*",currentRow).each(function(){
            if(this.id.match(/(\d+)+$/)){
                this.id=this.id.replace(RegExp.$1,rowNumber+1);
            }
            if(currentRow==newRow.get(0))
            {
                switch(this.name)
                {
                    case 'pPaperType':{
                        $(this).val("N");break;
                    }
                    case 'pTopic':{
                        $(this).val("");break;
                    }
                    case 'institute':{
                        $(this).val("");break;
                    }
                    case 'ppMonthYear':{
                        $(this).val("");break;
                    }
                    case 'ppRemarks':{
                        $(this).val("");break;
                    }

                }
            }
        });
    });
    $("#tab10no"+(eval(lRow)+1)).html(eval(lRow)+1+".");
    $("#dPresentationRow"+(eval(lRow))).hide();
    $("#dPresentationRow"+(eval(lRow)+1)).show();
    jQuery(".datemmyyyy").removeClass("hasDatepicker").datepicker({
        dateFormat: 'mm/yy',
        changeMonth: true,
        changeYear: true,
        yearRange: '-100:+0'
    });
}

function getSameAddress(){
    var correspondingAddress1=$("#cAddress1").val();
    var correspondingAddress2=$("#cAddress2").val();
    var correspondingAddress3=$("#cAddress3").val();
    var correspondingCountry=$("#cCountry").val();
    var correspondingState=$("#cState").val();
    var pincode=$("#cPin").val();
    var phoneNumber=$("#cPhoneNo").val();
    if ($("input#sameAddress1:checked").length){
        $("#pAddress1").val(correspondingAddress1);
        $("#pAddress2").val(correspondingAddress2);
        $("#pAddress3").val(correspondingAddress3);
        $("#pCountry").val(correspondingCountry);
        $("#pState").val(correspondingState);
        $("#pCity").val($("#cCity").val());
        $("#pPin").val(pincode);
        $("#pPhoneNo").val(phoneNumber);
    }
    if ($("input#sameAddress1:checked").length==0){
        $("#pAddress1").val("");
        $("#pAddress2").val("");
        $("#pAddress3").val("");
        $("#pPin").val("");
        $("#pPhoneNo").val("");
         $("#pCountry").val("0");
        $("#pState").val("0");
        $("#pCity").val("0");
    }
}



function getExperienceInMonth(iid){
    if($("#toDate"+iid).val()!=""){
        $.ajax({
            type:"POST",
            timeout: 30000,
            url:"../CounsellingRequest?sid=22&refor=CounsellingComboService&cid="+$("#cid").val()+"&parameter=N&startdate="+$("#fromDate"+iid).val()+"&enddate="+$("#toDate"+iid).val(),
            success:function(e){
                $("#experienceInMonths"+iid).val(e);
            },
            error:function(){

            }

        })
    }
}


function setCurrentTabPosition(n){
     getTabStatus('N');
    $("#tabno").val(n);
    $("#next").removeAttr("disabled");
    $("#previous").removeAttr("disabled");
    if($('#tabno').val()==0){
        $("#previous").attr("disabled", true);
        $("#next").removeAttr("disabled");
    }
    if($('#tabno').val()==11){
        $("#next").attr("disabled", true);
        $("#previous").removeAttr("disabled");
    }

}
//////////////////////////