<%@page import="java.sql.Statement"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" import="bookstore.cart.*,java.util.*,java.text.*" %>

<html>
    <head>      
        <title>BookStore</title>
    <h1><center> BookStore </center></h1>
    <%@include  file="template/head.jsp"%>
    <%@include  file="template/login.jsp"%>
</head>
<body bgcolor="#FFE7BA">
   
        <%  int numbook = 0;
            int row = 7;
            Dbconnect db = new Dbconnect();
            db.doConnection();
            Statement s = null;
            s = db.getConnection().createStatement();
            String category = request.getParameter("category");
            ResultSet result = s.executeQuery("select * from book where category= '" + category + "'");
            result.afterLast();%>
            <table id="t1" border="0" width="1150" align="center">
                <tr><% 
                    while (result.previous()) {
                    numbook++;                   
                }%> 

                    <% result.afterLast();;
                        for (int i = 0; i < (numbook / row); i++) {
                            for (int j = 0; j < row; j++) {
                            result.previous(); %>       
                    <th><center> <%out.print(result.getString("bookname"));%></center></th>  
                </a></td>
                <%}
                    out.print("<tr></tr>");
                    for (int j = 0; j < row; j++) {
                        result.next();
                    }
                    for (int j = 0; j < row; j++) {
                    result.previous();%>       
                <td><center> <a href="bookdetail.jsp?id=<%=result.getString("id")%>">
                        <%out.print("<img src=image/" + result.getString("picture"));%> width="230" height="330">   
                    </a></center></td>
                    <%}
                            out.print("<tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr>");

                        }

                        for (int k = 0; k < (numbook % row); k++) {
                        result.previous(); %>       
                <th><center> <%out.print(result.getString("bookname"));%></center></th>
                    <% }%>

                <% for (int j = 0; j < (numbook % row); j++) {
                        result.next();
                    }
                    out.print("<tr></tr>");
                    for (int k = 0; k < (numbook % row); k++) {
                    result.previous();%>   
                <td><center> <a href="bookdetail.jsp?id=<%=result.getString("id")%>">
                        <%out.print("<img src=image/" + result.getString("picture"));%> width="230" height="330">   
                    </a></center></td>
                    <%
                        }
                       // result.afterLast();
                    %>
        </div>
    </tr>
</table> 

<style>
    th, td {
        padding: 5px;
        text-align: left;               
    }
    table#t1 tr:nth-child(even) {
        background-color: #eee;
    }
    table#t1 tr:nth-child(odd) {
        background-color:#fff;
    }
    table#t1 th	{
        background-color: black;
        color: white;
    }
    table#t0 tr:nth-child(even) {
        background-color: #EEC591;
    }
    table#t0 tr:nth-child(odd) {
        background-color: #EEC591;
    }
    #section {
        width:250px;
        float:left;
         	 
    }
</style>
<% db.endConnection();%>
</html>
