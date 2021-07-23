<html>
<body>
<form method=post >
<%
String Excel="",finalsave="",MassCutCheck="";
if(request.getParameter("Excel")==null)
	Excel="";
else
	Excel=request.getParameter("Excel");
if(request.getParameter("finalsave")==null)
	finalsave="";
else
	finalsave=request.getParameter("finalsave");


if(request.getParameter("MassCutCheck")==null || request.getParameter("MassCutCheck").equals(" "))
				{
					MassCutCheck="N";
				}
				{
					MassCutCheck=request.getParameter("MassCutCheck");
				}

%>
<input type="HIDDEN" name="MassCutCheck" value=<%=MassCutCheck%>>
<%

if(!Excel.equals(""))
{
	RequestDispatcher rd=request.getRequestDispatcher("StudentGradesXLSJPBS.jsp?MassCutCheck="+MassCutCheck+"");
	rd.forward(request,response);
}
if(!finalsave.equals(""))
{
	RequestDispatcher rd=request.getRequestDispatcher("FinalSaveGradeCalculationJPBS.jsp");
	rd.forward(request,response);
}
%>

</form>
</body>
</html>