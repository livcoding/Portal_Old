<html>
<body>
<%
String Excel="",SaveGrade="";
if(request.getParameter("Excel")==null)
	Excel="";
else
	Excel=request.getParameter("Excel");
if(request.getParameter("SaveGrade")==null)
	SaveGrade="";
else
	SaveGrade=request.getParameter("SaveGrade");


if(!Excel.equals(""))
{
	RequestDispatcher rd=request.getRequestDispatcher("GradeCalculationXLS.jsp");
	rd.forward(request,response);
}
if(!SaveGrade.equals(""))
{
	RequestDispatcher rd=request.getRequestDispatcher("SaveGradeCalculation.jsp");
	rd.forward(request,response);
}
%>
</body>
</html>