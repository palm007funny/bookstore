<%@ page language="java" import="bookstore.cart.*,java.util.*,java.text.*" %>
<jsp:useBean id="account" class="bookstore.cart.account" scope="session" />
<%@page contentType="text/html; charset=UTF-8"  %>

<html>
    <head>
        <title>ThaiCreate.Com JSP Tutorial</title>
    </head>
    <body>

        <%  
            int orderID = Integer.parseInt(request.getParameter("orderID"));
           int idaccount = account.getID();
           PDFCreate pdf = new PDFCreate();
           pdf.createPdf(orderID,idaccount);
           response.sendRedirect("download.jsp");
        %>
        
        <META HTTP-EQUIV="refresh" 
                      CONTENT="0;URL=userdetail.jsp?orderID=<%= orderID%>">

    </body>
</html>
