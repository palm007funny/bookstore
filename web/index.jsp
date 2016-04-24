<%@page import="java.sql.Statement"%>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" import="bookstore.cart.*,java.util.*,java.text.*" %>
<jsp:useBean id="db" class="bookstore.cart.Dbconnect" scope="session" />
<html>
    <head>      
        <title>BookStore</title>
    <h1><center> BookStore </center></h1>
            <%request.setCharacterEncoding("UTF-8");%>
            <%@include  file="template/head.jsp"%>
            <%@include  file="template/login.jsp"%>
            <%@include  file="template/searchbox.jsp"%>
</head>
<body bgcolor="#FFE7BA">

    <%
        int numbook = 0;
        int row = 7;
        int maxbook = 0;
        int width = 230 ;
        db.doConnection();
        Statement s = null;
        s = db.getConnection().createStatement();
        PreparedStatement ps = db.getConnection().prepareStatement("SELECT * FROM book");
        ResultSet result = ps.executeQuery();       
        if (request.getParameter("search") != null) {
            ps = db.getConnection().prepareStatement("SELECT * FROM  book WHERE bookname like '%" +  search + "%' " +" ORDER BY id ASC");
            
            result = ps.executeQuery();
        }
        result.afterLast();%>
    <table id="t1" border="0" width="230" align="center">
        <tr><%
            while (result.previous()) {
                numbook++;
            }%> 

            <% maxbook = numbook;
                result.absolute(maxbook + 1);
                for (int i = 0; i < (numbook / row); i++) {
                    for (int j = 0; j < row; j++) {
                        result.previous(); %>       
            <th width="230"><center> <%out.print(result.getString("bookname"));%></center></th>              
            <%}
                out.print("<tr></tr>");
                for (int j = 0; j < row; j++) {
                    result.next();
                }
                for (int j = 0; j < row; j++) {
                    result.previous();%>       
    <td width="230"><center> <a href="bookdetail.jsp?id=<%=result.getString("id")%>">
            <%out.print("<img src=image/" + result.getString("picture"));%> width="230" height="330">   
        </a></center></td>
        <%}
                out.print("<tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr>");

            }

            for (int k = 0; k < (numbook % row); k++) {
                result.previous(); %>       
<th width="230"><center> <%out.print(result.getString("bookname"));%></center></th>
    <% }%>

<% for (int j = 0; j < (numbook % row); j++) {
        result.next();
    }
    out.print("<tr></tr>");
    for (int k = 0; k < (numbook % row); k++) {
        result.previous();%>   
<td width="230"><center> <a href="bookdetail.jsp?id=<%=result.getString("id")%>">
        <%out.print("<img src=image/" + result.getString("picture"));%> width="230" height="330">   
    </a></center></td>
    <%
        }
        ps.close();
        result.close();
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
