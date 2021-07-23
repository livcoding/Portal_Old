<html>
<body>
<%
String Excel="",Lock="";
if(request.getParameter("Excel")==null)
	Excel="";
else
	Excel=request.getParameter("Excel");
if(request.getParameter("Lock")==null)
	Lock="";
else
	Lock=request.getParameter("Lock");

if(!Excel.equals(""))
{
	RequestDispatcher rd=request.getRequestDispatcher("MarksEntryXLS.jsp");
	rd.forward(request,response);
}
if(!Lock.equals(""))
{
	RequestDispatcher rd=request.getRequestDispatcher("Proceed2LockMarksEntry.jsp");
	rd.forward(request,response);
}
%>
</body>
</html>
