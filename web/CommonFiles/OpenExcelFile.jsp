<%@ page language="java" import="java.sql.*,java.io.*,com.jxcell.*,com.jxcell.designer.Designer,tietwebkiosk.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %> 
<html>
<body>
Testing..................
<%
try
{
        View m_view;
        try
        {
            m_view =new View();
            m_view.read(".\DATA_010202022@#.xls");
            GRChart chart = (GRChart)m_view.addObject(com.jxcell.GRObject.eChart, (short)1, (short)9,(short)9, (short)22);
            chart.initData(new RangeRef(0,1,4,7),true);     //Sheet1!$A$2:$E$8
            m_view.write(".\XLTemplate\columnChart.xls",View.eFileExcel);
            chart.setChartType(GRChart.eChartBar);
            m_view.write(".\XLTemplate\barChart.xls",View.eFileExcel);
            chart.setChartType(GRChart.eChartPie);
            m_view.write(".\XLTemplate\pieChart.xls",View.eFileExcel);
            chart.setChartType(GRChart.eChartLine);
            m_view.write(".\XLTemplate\lineChart.xls",View.eFileExcel);
            chart.setChartType(GRChart.eChartArea);
            m_view.write(".\XLTemplate\areaChart.xls",View.eFileExcel);
//            Designer.newDesigner(m_view);
        }
        catch (CellException e)
        {
            e.printStackTrace();
        } catch (IOException e)
        {
            e.printStackTrace();
        }
}
catch(Exception e)
{
out.print(e.getMessage()+"errrp");
}
%>
