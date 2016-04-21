<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.lang.NumberFormatException" %>
<%@ page import="java.lang.NullPointerException" %>
<%@ page import="java.util.LinkedList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page language="java" import="bookstore.cart.*,java.util.*,java.text.*" %>
<jsp:useBean id="account" class="bookstore.cart.account" scope="session" />
<jsp:useBean id="db" class="bookstore.cart.Dbconnect" scope="session" />
<script type="text/javascript" src="counter.js"></script>
<html>
    <head>
        <title>BookDetail</title>
        <%@include  file="template/head.jsp"%>
    </head>
    <body bgcolor="#FFE7BA">


        <%
            String idbook = "";
            if (request.getParameter("id") != null) {
                idbook = request.getParameter("id");
                %><META HTTP-EQUIV="refresh" 
          CONTENT="0;URL=cartlist.jsp"><%
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


        <%            Vector mycart = cart.getCart();
            Item item;
            String amount = "1";
            int value = 1;
            int value2 = 1;
            int temp_Stock = 0;
            int disable = 0;
            boolean check = true;
            ResultSet result2;
            Statement s2 = db.getConnection().createStatement();
            float total, finish_total = 0;
            if (mycart.size() > 0) { %>
        <table id="t1" width="1270" border="1">
            <tr>
            <th width="100"> <div align="center">รหัสสินค้า </div></th>
            <th width="400"> <div align="center">ชื่อหนังสือ </div></th>
            <th width="100"> <div align="center">ราคา </div></th>
            <th width="100"> <div align="center">ส่วนลด(%) </div></th>
            <th width="100"> <div align="center">จำนวน </div></th>
            <th width="100"> <div align="center">เลือกจำนวน</div></th>
            <th width="50"> <div align="center"></div></th>
                <% if (cart.getMore() == true) { %>
            <th width="120"> <div align="center"></div></th>
                <%}
                    if (check == false) { %>
            <th width="150"> <div align="center"></div></th>
                <%}%>
        </tr>
        <%  StringBuffer condition = new StringBuffer(" in (");
          for (int i = 0; i < mycart.size(); i++) {
              item = (Item) mycart.elementAt(i);
              if (request.getParameter("Points" + i) != null) {
                  if ((request.getParameter("Points" + i).equals("more"))) {
                      cart.more(true);
                  }
                  if (!(request.getParameter("Points" + i).equals("more"))) {
                      cart.more(false);
                      amount = request.getParameter("Points" + i);
                      value = Integer.parseInt(amount);
                      cart.updateItem(item.ID, value);
                  }
              }
              if (request.getParameter("num" + i) != null) {
                  value2 = Integer.parseInt(request.getParameter("num" + i));
                  cart.updateItem(item.ID, value2);
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
                    <option value="more">more</option>
                </select>
                <input type="submit" name="AddPoints" id="AddPoints" value="Add">
            </td>
        </form>
        <%if (cart.getMore() == true) {
        %>
        <form>
            <td width="100"><input type="text" name="num<%=i%>" size="2">
                <input type="submit" name="num" value="Add"></td>
        </form>
        <%
            }%>

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
                        } else {
                            check = true;
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
<table id="t2" width="200" border="1">
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
<%if (mycart.size() <= 0){%>
ยังไม่มีสินค้าในรายการ
<%}%>
<p><a href="index.jsp">เลือกสินค้าต่อ</a></p> 
<style>
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
    table#t2 th	{
        background-color: #fff;
        color: black;
    }
    table#t2 tr	{
        background-color: #fff;
        color: black;
    }
</style>