<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="db" class="bookstore.cart.Dbconnect" scope="session" />
<html>
    <head>
        <title>BookDetail</title>
    </head>
    <body bgcolor="#FFE7BA">
        <h1><center> BookDetail </center></h1>
                <%@include  file="template/head.jsp"%>
                <%
                    String idbook = "";
                    if (request.getParameter("id") != null) {
                        idbook = request.getParameter("id");
                    }

                    Connection connect = null;
                    Statement s = null;

                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");
                        s = connect.createStatement();
                        String sql = "SELECT * FROM  book WHERE id = '" + idbook + "'  ";

                        ResultSet result = s.executeQuery(sql);
                        if (result != null) {
                            result.next();
                %>              
        <table id="t2" border="0" width="250" align="left">
            <td width="230"><%out.print("<img src=image/" + result.getString("picture"));%> width="230" height="330"</td>
            <% if (result.getInt("Stock") == 0) { %>
            <tr><td><center><%out.print("<img src=image/cart.png");%> width="65" height="62">                           
            </center></td></tr>
    <tr><td><center><%out.print(" สินค้าหมด ");%></center></td></tr>
        <% } else {%>
<tr><td><center><a href="cartlist.jsp?id=<%=result.getString("id")%>">
        <%out.print("<img src=image/cart.png");%> width="65" height="62">                           
    </a></center></td></tr>
<tr><td><center><%out.print(" สินค้าคงเหลือ " + result.getInt("Stock"));%></center></td></tr>
    <% }%>
</table>
<table id="t1" border="0" width="800" align="left">

    <tr>
        <th width="100">
            <div align="left">Book ID </div></th>
        <td><%=result.getString("id")%></td>
    </tr>
    <tr>
        <th width="100">
            <div align="left">BookName </div></th>
        <td><%=result.getString("bookname")%></td>
    </tr>
    <tr>
        <th width="100">
            <div align="left">detail </div></th>
        <td><%=result.getString("detail")%></td>
    </tr>

    <tr>
        <th width="100">
            <div align="left">price </div></th>
        <td><%=result.getFloat("price")%> บาท</td>
    </tr>
    <tr>
        <th width="100">
            <div align="left">Discount </div></th>
        <td><%=result.getFloat("discount")%> %</td>
    </tr>
    <tr>
        <th width="100">
            <div align="left">ขนาดหนังสือ </div></th>
        <td><%=result.getString("booksize")%></td>
    </tr>
    <tr>
        <th width="100">
            <div align="left">น้ำหนัก </div></th>
        <td><%=result.getString("bookweight")%></td>
    </tr>
    <tr>
        <th width="100">
            <div align="left">สำนักพิมพ์ </div></th>
        <td><%=result.getString("company")%></td>
    </tr>
    <tr>
        <th width="100">
            <div align="left">ปีที่พิมพ์ </div></th>
        <td><%=result.getString("date")%></td>
    </tr>


</table> 

<% }

    } catch (Exception e) {
        out.println(e.getMessage());
        e.printStackTrace();
    }

    try {
        if (s != null) {
            s.close();
            connect.close();
        }
    } catch (SQLException e) {
        // TODO Auto-generated catch block
        out.println(e.getMessage());
        e.printStackTrace();
    }
    db.endConnection();
%>

<style>
    th, td {
        padding: 12px;
        text-align: left;
        color: black;
    }
    table#t1 tr:nth-child(even) {
        background-color: #eee;
    }
    table#t1 tr:nth-child(odd) {
        background-color:#fff;
    }
    table#t1 th	{
        background-color: #eee;
        color: black;
    }
    table#t0 tr:nth-child(even) {
        background-color: #EEC591;
    }
    table#t0 tr:nth-child(odd) {
        background-color: #EEC591;
    }
</style>
</body>
</html>
