<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page language="java" import="bookstore.cart.*,java.util.*,java.text.*" %>
<jsp:useBean id="cart" class="bookstore.cart.Cart" scope="session" />
<jsp:useBean id="account" class="bookstore.cart.account" scope="session" />
<jsp:useBean id="db" class="bookstore.cart.Dbconnect" scope="session" />
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Finish Order</title>
    </head>
    <body bgcolor="#FFE7BA">
        <h1><center>  </center></h1
        <%@include  file="template/head.jsp"%>
        <%-------------------------------------------เพิ่มรายการสั่งซื้อ เข้า Database --------------------------------------------------------%>
        <%  request.setCharacterEncoding("UTF-8");
            String name = request.getParameter("firstname");
            String lastname = request.getParameter("lastname");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String road = request.getParameter("street");
            String tumbon = request.getParameter("tumbon");
            String amphur = request.getParameter("amphor");
            String city = request.getParameter("city");
            String zipcode = request.getParameter("zipcode");
            Object total = session.getAttribute("finish_total");
            int idaccount = account.getID();
            int temp_Stock;
            DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
            Date date = new Date();
            String strDate = dateFormat.format(date);
            try {
                db.doConnection();
                Statement s = db.getConnection().createStatement();
                String customer = "INSERT INTO orders "
                        + "(OnDate,Name,Surname,Email,Phone,AddressNo,Street,Tumbol,Amphor,Province,Postal,idaccount,total,Status)"
                        + "VALUES ('" + strDate + "' "
                        + ",'" + name + "','" + lastname + "'"
                        + ",'" + email + "','" + phone + "','" + address + "','" + road + "'"
                        + ",'" + tumbon + "','" + amphur + "','" + city + "','" + zipcode + "','" + idaccount + "','" + total + "','" + "รอการชำระเงิน" + "') ";
        %>ดำเนินการสั่งชื้อสำเร็จ<%
                s.execute(customer);
//----------------------------------------------------------------------------------------------------------------------------------                
            } catch (Exception e) {

            }
//---------------------------------------เพิ่มจำนวนรายการที่สั่งซื้อและตัดสินค้าออก Stock-----------------------------------------------------
            db.doConnection();
            Statement s = db.getConnection().createStatement();
            Statement s2 = db.getConnection().createStatement();
            String sql = "SELECT OrderID FROM Orders WHERE OnDate = '" + strDate + "'";
            ResultSet result = s.executeQuery(sql);
            ResultSet result2;
            if (result.next()) {
                int orderid = result.getInt("OrderID");
                result.close();
                Vector mycart = cart.getCart();
                for (int i = 0; i < mycart.size(); i++) {
                    Item item = (Item) mycart.elementAt(i);
                    StringBuffer order = new StringBuffer("INSERT INTO OrderDetails(OrderID, ProductID, Qty) VALUES(");
                    order.append(orderid);
                    order.append(", " + item.ID);
                    order.append(", " + item.Amount);
                    order.append(")");
                    s.executeUpdate(order.toString());
                    result2 = s2.executeQuery("select * from book where id= '" + item.ID + "'");
                    if (result2.next()) {
                        temp_Stock = result2.getInt("Stock");
                        temp_Stock = temp_Stock - item.Amount;
                        String Stock = "UPDATE book "
                                + "SET Stock = '" + temp_Stock + "' "
                                + " WHERE id = '" + item.ID + "' ";
                        s2.execute(Stock);
                    }
                }
                cart.removeAllItem();
            }
                db.endConnection();
//---------------------------------------------------------------------------------------------------------------------------------
        %>
        <p><a href="index.jsp">หน้าแรก</a></p>    
    </body>
</html>
