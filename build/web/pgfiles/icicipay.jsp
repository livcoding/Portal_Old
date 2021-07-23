<%-- 
    Document   : icicipay
    Created on : 20 Jun, 2020, 2:29:12 PM
    Author     : VIVEK.SONI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*,pgwebkiosk.*,java.io.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
       <%




        String merchantid="121969";
        String amt="20";
        String refno="123456789";
        String key="1202531019601004";

       
        String optional_fields="JIIT12345|REG|JIIT|B.T|CSE";
        String returnurl="http://172.16.5.181:8084/JIIT2020/pgfiles/iciciaction.jsp";
        String ReferenceNo="8001";
        String transaction_amount="20";
        String paymode="9";
        String mandatoryfield=ReferenceNo+"|"+amt;
        String submarchantid="456123";

        jilit.db.Encryptionsss es=new  jilit.db.Encryptionsss();

        String enmandatoryfield=es.encrypt(mandatoryfield, key);
        String dec=es.decrypt(enmandatoryfield, key);
        System.out.println("decrept enmandatoryfield"+dec);
        String enoptional_fields=es.encrypt(optional_fields, key);
        String enreturnurl=es.encrypt(returnurl, key);
        String esubmarchantid=es.encrypt(submarchantid, key);
        String enreferenceno=es.encrypt(ReferenceNo, key);
        String enamount=es.encrypt(amt, key);
        String enpaymode=es.encrypt(paymode, key);

        String url="https://eazypay.icicibank.com/EazyPG??merchantid=121969&mandatory fields="+enmandatoryfield+"&ptional fields="
                +enoptional_fields+"&returnurl="+enreturnurl+"&Reference No"+enreferenceno+"=&submerchantid="+esubmarchantid+
                "=&transaction amount="+enamount+"&&paymode"+enpaymode+"";
        System.out.println("url"+url);

        response.sendRedirect(url);

       
                            
        %>
    </body>
</html>
