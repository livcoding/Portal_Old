 <html>
     <head>
     <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
     <title>JSP Page</title>
     <script type="text/javascript">

      function loadXMLDoc()
      {
        var xmlhttp;
        var config=document.getElementById('configselect').value;
        var url="get_configuration.jsp";
        if (window.XMLHttpRequest)
        {
            xmlhttp=new XMLHttpRequest();
        }
        else
        {
            xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange=function()
        {
            if (xmlhttp.readyState==4 && xmlhttp.status==200)
            {
                document.getElementById("myDiv").innerHTML=xmlhttp.responseText;
            }
        }

        xmlhttp.open("GET", url, true);
        xmlhttp.send();
}
</script>        

</head>

<body>
  <h2 align="center">Saved Configurations</h2>
   Choose a configuration to run: 
  <select name="configselect" width="10" onchange="loadXMLDoc()">
    <option selected value="select">select</option>
    <option value="Config1">config1</option>
    <option value="Config2">config2</option>
    <option value="Config3">config3</option>
  </select> 
  <button type="button" onclick='loadXMLDoc()'> Submit </button>
  <div id="myDiv">
    <h4>Get data here</h4>
  </div>
 </body>
</html>



	
		
		
		if(!mStatus.equals("N"))
		{
			qry="SELECT 'Y' FROM HR#APPLICANTSHORTLISTMASTER WHERE COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND VACANCYCODE='"+mVacCode+"' AND   APPLICANTID='"+ApplicationID+"' AND SHORTLISTSEQNO="+ShortlistSeq+" ";
			out.print(qry);
			rs=db.getRowset(qry);
			if(rs.next())
			{
				 qryupdate="UPDATE HR#APPLICANTSHORTLISTMASTER			SET    STATUS         = '"+mStatus+"',				  SHORTLISTBY    = '"+ mChkMemID+"' ,       SHORTLISTDATE  = sysdate,       REMARKS        = '"+mDeptRemark+"',       ENTRYBY        = '"+ mChkMemID+"',       ENTRYDATE      = sysdate				 ,FINAL='"+mFreeze+"', FINALIZEDBY='"+ mChkMemID+"', FINALIZEDDATE=sysdate					 WHERE  COMPANYCODE    = '"+mComp+"' AND    INSTITUTECODE  = '"+mInst+"' AND    VACANCYCODE    = '"+mVacCode+"' AND    APPLICANTID    = '"+ApplicationID+"' AND    SHORTLISTSEQNO = "+ShortlistSeq+" ";
				// out.print(qryupdate);
				int update=db.update(qryupdate);
				if(update>0)
					mflag=1;
				else
					mflag=0;
			}
			else
			{
				qryinsert="INSERT INTO HR#APPLICANTSHORTLISTMASTER (   COMPANYCODE, INSTITUTECODE, VACANCYCODE,    APPLICANTID, SHORTLISTSEQNO, STATUS,    SHORTLISTBY, SHORTLISTDATE, REMARKS,    DEACTIVE, ENTRYBY, ENTRYDATE,   FINAL ,FINALIZEDBY,FINALIZEDDATE)  VALUES ( '"+mComp+"','"+mInst+"' ,'"+mVacCode+"' ,'"+ApplicationID+"'    ,'"+ShortlistSeq+"' ,'"+mStatus+"' ,'"+ mChkMemID+"' ,sysdate ,'"+mDeptRemark+"' , 'N' , '"+ mChkMemID+"', sysdate ,'"+mFreeze+"','"+ mChkMemID+"',sysdate)";
				System.out.print(qryinsert);
				int insert=db.insertRow(qryinsert)	;
				if(insert>0)
					mflag=1;
				else
					mflag=0;
			}
		}
		else
			{
      mflag=1;
			}
			

			//}

		if (mflag==1)
		{
				out.print("<BR><CENTER><FONT sIZE=4 COLOR=GREEN > <B> Record Saved Successfully... </B></FONT>");
%>
<div id="myDiv">
    <h4><CENTER><FONT sIZE=4 COLOR=GREEN > <B> Record Saved Successfully... </B></FONT></h4>
  </div>


<%
		}