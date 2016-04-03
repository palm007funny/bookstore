<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.lang.NumberFormatException" %>
<%@ page import="java.lang.NullPointerException" %>
<%@ page import="java.util.LinkedList" %>
<%@page contentType="text/html; charset=UTF-8"  %>
<%@ page language="java" import="bookstore.cart.*,java.util.*,java.text.*" %>
<jsp:useBean id="account" class="bookstore.cart.account" scope="session" />
<jsp:useBean id="cart" class="bookstore.cart.Cart" scope="session" />
<jsp:useBean id="db" class="bookstore.cart.Dbconnect" scope="session" />
<script type="text/javascript" src="counter.js"></script>
<html>
    <head>
        <title>BookDetail</title>
    </head>
    <body bgcolor="#FFE7BA">


        <%
            String idbook = "";
            if (request.getParameter("id") != null) {
                idbook = request.getParameter("id");
            }
            try {
                db.doConnection();
                Statement s = db.getConnection().createStatement();
                String sql = "SELECT * FROM  book WHERE id = '" + idbook + "'  ";%>



        <%ResultSet result = s.executeQuery(sql);
                String id, bookname;
                float price, discount;
                if (result != null) {
                    result.next();
                    id = result.getString("id");
                    bookname = result.getString("bookname");
                    price = result.getFloat("price");
                    discount = result.getFloat("discount");
                    cart.addItem(id, bookname, price, discount, 1);

                }
            } catch (Exception e) {
            }

        %>

        <table width="1050" border="1">
            <tr>
            <th width="100"> <div align="center">รหัสสินค้า </div></th>
            <th width="400"> <div align="center">ชื่อหนังสือ </div></th>
            <th width="100"> <div align="center">ราคา </div></th>
            <th width="100"> <div align="center">ส่วนลด(%) </div></th>
            <th width="100"> <div align="center">จำนวน </div></th>
            <th width="100"> <div align="center"></div></th>

        </tr>


        <%            Vector mycart = cart.getCart();
            Item item;
            String amount = "1";
            int value = 1;
            int temp_Stock = 0;
            int disable = 0;
            boolean check = true;
            ResultSet result2;
            Statement s2 = db.getConnection().createStatement();
            float total, finish_total = 0;
            if (mycart.size() > 0) {
                StringBuffer condition = new StringBuffer(" in (");
                for (int i = 0; i < mycart.size(); i++) {
                    item = (Item) mycart.elementAt(i);
                    amount = request.getParameter("Points" + i);
                    if (request.getParameter("Points" + i) != null) {
                        value = Integer.parseInt(amount);
                        cart.updateItem(item.ID, value);
                    }
                    result2 = s2.executeQuery("select * from book where id= '" + item.ID + "'");
                    if (result2.next()) {
                        temp_Stock = result2.getInt("Stock");
                    }
        %>

        <tr>
        <td><div align="center"> <%out.print(item.ID);%></div></td>
        <td><div align="center"><%out.print(item.Bookname);%></div></td>
        <td><div align="center"><%out.print(item.Price);%></div></td>
        <td><div align="center"><%out.print(item.Discount);%></div></td>
        <td align="center"><%out.print(item.Amount);%></td>

        <form>
            <td>                  
                <select name="Points<%=i%>" size="1" id="Points<%=i%>">
                    <option value="1" selected>1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                    <option value="6">6</option>
                    <option value="7">7</option>
                    <option value="8">8</option>
                    <option value="9">9</option>
                </select>

                <input type="submit" name="AddPoints" id="AddPoints" value="Add">
            </td>
        </form>
        <%total = ((item.Price) - (item.Price * (item.Discount / 100))) * (float) item.Amount;
            finish_total += total;%>

        <td align="center"> <a href="cartlist.jsp?del=<%=item.ID%>">Del</a></td>
        <% if (item.Amount > temp_Stock) { %>
        <th width="150"><div align="center"><font color="red"><%out.print("จำนวนสินค้าไม่พอ");%></font></div></th>
                    <% disable--;
                        } else {
                            disable++;
                        }
                        if (disable < i) {
                            check = false;
                        } else {check = true;
                        }%>
    </tr>                                                          
    <%
        String del = request.getParameter("del");
        if (request.getParameter("del") != null) {
            cart.removeItem(del); %>
    <META HTTP-EQUIV="refresh" 
          CONTENT="0;URL=cartlist.jsp">
    <%}%>               
    <% }
        db.endConnection();%>
</table>
<table width="200" border="1">
    <tr>
    <th width="71"> <div align="center"> รวม </div></th>
    <td align="center">
        <%out.print(finish_total);%>          
    </td>
    <td align="center">
        <form name="form" method="post" action="checkout.jsp">
            <input type="submit" <%if (check == false) {%>disabled<%}%> name="Submit" value="Check Out">
        </form>
    </td>
    <%}%>
</tr>	
</table>
<p><a href="index.jsp">เลือกสินค้าต่อ</a></p> 