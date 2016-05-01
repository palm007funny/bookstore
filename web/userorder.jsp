<%@ page language="java" import="bookstore.cart.*,java.util.*,java.text.*" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="account" class="bookstore.cart.account" scope="session" />
<jsp:useBean id="db" class="bookstore.cart.Dbconnect" scope="session" />
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

    </head>
    <body bgcolor="#FFE7BA">
        <h1><center> จัดการบัญชี </center></h1>
        <%@include  file="template/head.jsp"%><br>
        <% //----------------------------------รายการสั่งซื้อ----------------------------------------------------------------------------- 
            if (request.getParameter("order") != null) {
                Connection connect = null;
                Statement s = null;
                db.doConnection();
                s = db.getConnection().createStatement();
                ResultSet result = s.executeQuery("select * from orders where idaccount= '" + account.getID() + "'");
                int orderID;%>
        <table id="t1" border="1" width="600" align="left">
            <tr>
                <th width="150"> <div align="center">หมายเลขสั่งซื้อ </div></th>
                <th width="150"> <div align="center">เวลาสั่งซื้อ </div></th>
                <th width="150"> <div align="center">สถานะการสั่งซื้อ </div></th>
            </tr>

            <%while (result.next()) {
            %>


            <tr>
                <td><div align="center"><%=result.getInt("OrderID")%></div></td>
                <td><%=result.getDate("OnDate")%></td>
                <td align="center"><%=result.getString("Status")%></td>
                <td align="center"> <a href="userorder.jsp?orderID=<%=result.getInt("OrderID")%>">รายละเอียดสินค้า</a></td>
            </tr>

            <%  }
                } %>
        </table>
        <% if (request.getParameter("orderID") != null) {
                Connection connect = null;
                Statement s = null;
                Statement s2 = null;
                db.doConnection();
                s = db.getConnection().createStatement();
                s2 = db.getConnection().createStatement();
                int orderID = Integer.parseInt(request.getParameter("orderID"));
                int bookid = 0;
                int amount = 0;
                ResultSet result = s.executeQuery("select * from orderdetails where OrderID= '" + orderID + "'");
                ResultSet result2 = null;
                ResultSet result3 = null;
        %>
        <table id="t1" border="1" width="750" align="left">
            <tr>
                <th width="150"> <div align="center">รหัสสินค้า </div></th>
                <th width="150"> <div align="center">ชื่อหนังสือ </div></th>
                <th width="150"> <div align="center">ราคา </div></th>
                <th width="150"> <div align="center">จำนวน </div></th>
            </tr>	
            <%while (result.next()) {
                    bookid = result.getInt("ProductID");
                    amount = result.getInt("Qty");
                    result2 = s2.executeQuery("select * from book where id= '" + bookid + "'");
                    while (result2.next()) {%>
            <tr>
                <td><div align="center"><%=result2.getInt("id")%></div></td>
                <td><%=result2.getString("bookname")%></td>
                <td><%=result2.getString("price")%></td>
                <td><%out.print(amount);%></td>
            </tr>
            <%   }
                }
                result3 = s.executeQuery("select * from orders where OrderID= '" + orderID + "'");
                while (result3.next()) {     %>
            <td>รวม</td><td><%out.print(result3.getFloat("total"));%> บาท</td>
            <%}%>
            <tr><td><center><p><a href="pdf.jsp?orderID=<%= orderID%>">Download Invoice</a></p></center></td></tr>
</table>
<% db.endConnection();
        result2.close();
        s.close();
        s2.close();
        result.close();
    }

%>
<style>
    th, td {
        padding: 5px;
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
        background-color: #fff;
        color: black;
    }
    a {
        color: black;
    }

</style>
</body>
</html>
