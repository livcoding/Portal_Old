<html>
<body>
<%
    
String Excel="",Lock="";
if(request.getParameter("ExcelGen")==null)
	Excel="";
else
	Excel=request.getParameter("ExcelGen");
if(request.getParameter("LockEntry")==null)
	Lock="";
else 
	Lock=request.getParameter("LockEntry");

if(!Lock.equals(""))  
{
	//RequestDispatcher rd=request.getRequestDispatcher("ReconProceed2LockMarksEntry.jsp");
	//rd.forward(request,response);
        


}else
{
	RequestDispatcher rd=request.getRequestDispatcher("ReconMarksEntryXLS.jsp");
	rd.forward(request,response);
}

%>
</body>
</html>