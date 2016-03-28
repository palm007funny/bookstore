<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language="java" import="bookstore.cart.*,java.util.*,java.text.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% Dbconnect db = new Dbconnect(); 
           db.doConnection();        
        %>
    </body>
</html>
