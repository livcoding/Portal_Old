/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


var ctr="";
    window.onload = function() {
      $(".nondecimal").numbernondecimal();
    ctr=document.getElementById("ctr").value;  
     for(var i=0;i<=ctr;i++)
         {
         $("#noOfStudents"+i).prop("disabled", true); 
         }
         for(var i=1;i<=ctr;i++){
             document.getElementById("noLimitRadio"+i).checked = true;    
             } 
         document.getElementById('allocateToAll').checked = true;
         document.getElementById('allocateToSome').disabled = true; 
             document.getElementById('allocateCGPA').disabled = true;
             document.getElementById('allocateRandomly').disabled = true;
     
     
     };
     
     
     function getEnable(textBoxID,val,radioID)
     {
       if(val=='Y')
           {
             for(var i=1;i<=ctr;i++){
             document.getElementById("noLimitRadio"+i).checked = true;    
             } 
             document.getElementById('allocateToSome').checked = false; 
             document.getElementById('allocateCGPA').checked = false; 
             document.getElementById('allocateRandomly').checked = false; 
             document.getElementById('allocateToSome').disabled = true; 
             document.getElementById('allocateCGPA').disabled = true;
             document.getElementById('allocateRandomly').disabled = true;
             for(var i=1;i<=ctr;i++){
              document.getElementById("noOfStudents"+i).value = "";
              document.getElementById("noOfStudents"+i).disabled = true;
           }
            document.getElementById('allocateToAll').disabled = false; 
           }
        if(val=='N')
            {
             for(var i=1;i<=ctr;i++){
             document.getElementById("withLimitRadio"+i).checked = true; 
             if($("#RUNNING"+i).val()=='Y'){
             document.getElementById("noOfStudents"+i).disabled = false;
             }
             }
             document.getElementById('allocateToAll').checked = false;
             document.getElementById('allocateToAll').disabled = true;
             document.getElementById('allocateToSome').disabled = false; 
             document.getElementById('allocateCGPA').disabled = false;
             document.getElementById('allocateRandomly').disabled = false;
            }
            
            
     }
     
      function getValidate(row,id)
     {
      var columnCount="";
      var textBoxValue="";
      columnCount=$("#rowForCount"+row).val(); 
      textBoxValue=$("#noOfStudents"+row).val();
     if(eval(textBoxValue)>eval(columnCount))
      {
      alert("Please enter the number less than or equal to sum of choices.")
      $("#noOfStudents"+row).val(""); 
      return false;
      }
      if(eval(textBoxValue)==0)
          {
           alert("Please enter the number greater than 0.");
            $("#noOfStudents"+row).val(""); 
           return false;
          }
     }
     
     function getValidateForm()
    {
         for(var i=1;i<=ctr;i++){
        if ($('input[name=limit'+ctr+']:checked').length <= 0)
    {
        alert("Please choose No Limit or write the limit in text box.");
        return false;
        break;
    }
         }
        if ($('input[name=allocate]:checked').length <= 0) 
            {
              alert("Please choose one option of allocation.");
             return false;   
            }
          for(var i=1;i<=ctr;i++){
            if($("#noOfStudents"+i).val()=="" || $("#noOfStudents"+i).val()==null)
            {
                if($("#RUNNING"+i).val()=='Y' && document.getElementById("withLimitRadio"+i).checked){
                alert("Please enter the limit of students");
                $("#noOfStudents"+i).focus();
                return false;
                }
            }
          }
          
         var ch= $('input:radio[name=finalized]:checked').val();
         if('<%=subjectIDS.length%>'!='<%=count%>'){
         if(ch=="YES")
             {
              var flag='<%=flag%>';
              if(flag=="false")
                  {
                      alert("Before Finalize assign choices for all subjects");
                  }
             }
             }
         $( "#submitSubjects" ).click(function() {
         $( "#frm1" ).submit();
         });
        
    }
      