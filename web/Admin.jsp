<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" import="bookstore.cart.*,java.util.*,java.text.*" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@page contentType="text/html; charset=UTF-8"  %>
<jsp:useBean id="account" class="bookstore.cart.account" scope="session" />
<jsp:useBean id="db" class="bookstore.cart.Dbconnect" scope="session" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>admin</title>
    </head>
    <h1><center> Admin </center></h1>
    <body bgcolor="#FFE7BA">
        <table id="t0" border="2" bordercolor="#EEC591" width="250" align="left"> 

            <tr><td><center><p><a href="Orderedit.jsp">รายการสั่งซื้อ</a></p></center></td></tr>         
                            <% if (account.checkAdmin() == 1) { %>
        <tr><td><center><p><a href="addbook.jsp">เพิ่ม-ลบหนังสือ</a></p></td></center></tr>
                        <%}%>
<tr><td><center><p><a href="index.jsp">หน้าแรก</a></p></center></td></tr>
<tr><td><center><p><a href="userdetail.jsp?logout=<%=1%>">LogOut</a></p></center></td></tr>

</tr>
</table>
<style>
    th, td {
        padding: 15px;
        text-align: left;
    }
    table#t1 tr {
        background-color: #FFE7BA;
    }
    table#t1 th	{
        background-color: black;
        color: white;
    }

    table#t0 tr{
        background-color: #EEC591;
    }
    table#t2 tr{
        background-color: #fff;
    }
</style>
</body>
</html>
