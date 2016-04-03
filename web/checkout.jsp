<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language="java" import="bookstore.cart.*,java.util.*,java.text.*" %>
<jsp:useBean id="cart" class="bookstore.cart.Cart" scope="session" />
<jsp:useBean id="account" class="bookstore.cart.account" scope="session" />
<jsp:useBean id="db" class="bookstore.cart.Dbconnect" scope="session" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Check Out</title>
    </head>
    <body bgcolor="#FFE7BA">
        <%   String user = request.getParameter("username");
            String pass = request.getParameter("password");
            if (account.getLogin() == false) {
        %>
        คุณยังไม่ได้เข้าสู่ระบบ กรุณาเข้าสู่ระบบ <br>
    <form>
        <table id="t1">
            <tr>
                <td> Username  : </td><td> <input name="username" size=15 type="text" /> </td></tr>
            <tr>
                <td> Password  : </td><td> <input name="password" size=15 type="password" /> </td></tr>                                          
            <tr><td bgcolor="#FFE7BA" ><input type="submit" value="login" /></td>


                </form>
                <%
                    account.Login(user, pass);
                    if (user != null) {%>
            <META HTTP-EQUIV="refresh" 
                  CONTENT="0;URL=checkout.jsp">
            <% }
            } else { %>
            <table width="900" border="1">
                <tr>
                    <th width="100"> <div align="center">รหัสสินค้า </div></th>
                    <th width="400"> <div align="center">ชื่อหนังสือ </div></th>
                    <th width="100"> <div align="center">ราคา </div></th>
                    <th width="100"> <div align="center">ส่วนลด </div></th>
                    <th width="100"> <div align="center">จำนวน </div></th>
                </tr>


                <%         String name = request.getParameter("firstname");
                    String lastname = request.getParameter("lastname");
                    String email = request.getParameter("email");
                    String phone = request.getParameter("phone");
                    String address = request.getParameter("address");
                    String road = request.getParameter("road");
                    String tumbon = request.getParameter("tumbon");
                    String amphur = request.getParameter("amphur");
                    String city = request.getParameter("city");
                    String zipcode = request.getParameter("zipcode");
                    int temp_Stock = 0;
                    Vector mycart = cart.getCart();
                    Item item;
                    String amount = "1";
                    int value = 1;
                    float total, finish_total = 0;
                    Connection connect = null;
                    Statement s = null;
                    db.doConnection();
                    Statement s2 = db.getConnection().createStatement();
                    ResultSet result2;
                    if (mycart.size() > 0) {
                        StringBuffer condition = new StringBuffer(" in (");
                        for (int i = 0; i < mycart.size(); i++) {
                            item = (Item) mycart.elementAt(i);
                            total = ((item.Price) - (item.Price * (item.Discount / 100))) * (float) item.Amount;
                            finish_total += total;
                            result2 = s2.executeQuery("select * from book where id= '" + item.ID + "'");
                            if (result2.next()) {
                                temp_Stock = result2.getInt("Stock");
                                temp_Stock = temp_Stock - item.Amount;
                            }
                %>
                <tr>
                    <td><div align="center"> <%out.print(item.ID);%></div></td>
                    <td><div align="center"><%out.print(item.Bookname);%></div></td>
                    <td><div align="center"><%out.print(item.Price);%></div></td>
                    <td><div align="center"><%out.print(item.Discount);%></div></td>
                    <td align="center"><%out.print(item.Amount);%></td>                            
                </tr>                                                                        
                <% }
                    } %>
            </table>
            <table width="200" border="1">
                <tr>
                    <th width="71"> <div align="center"> รวม </div></th>
                    <td align="center">
                        <%out.print(finish_total);
                            session.setAttribute("finish_total", finish_total);
                        %>       
                    </td>                                    
                </tr>	
            </table>
            <%
                s = db.getConnection().createStatement();
                ResultSet result = s.executeQuery("select * from account where idaccount= '" + account.getID() + "'");
                if (result.next()) {
            %>
            <form name="checkout" method="post" action="finalorder.jsp">
                <table width="540" border="1">
                    <th width="100"> <div align="center">ชื่อ </div></th>
                    <td><input type="text" name="firstname" size="20" value="<%=result.getString("Name")%>"></td>
                    <th width="100"> <div align="center">นามสกุล </div></th>
                    <td><input type="text" name="lastname" size="20" value="<%=result.getString("lastname")%>"></td>
                    <tr>
                        <th width="100"> <div align="center">Email </div></th>
                        <td><input type="text" name="email" size="20" value="<%=result.getString("email")%>"></td>
                        <th width="100"> <div align="center">โทรศัพท์ </div></th>
                        <td><input type="text" name="phone" size="20" value="<%=result.getString("Phone")%>"></td>
                    </tr>
                    <tr>
                        <th width="100"> <div align="center">บ้านเลขที่ </div></th>
                        <td><input type="text" name="address" size="20" value="<%=result.getString("AddressNo")%>"></td>
                        <th width="100"> <div align="center">ถนน </div></th>
                        <td><input type="text" name="street" size="20" value="<%=result.getString("Street")%>"></td>
                    </tr>
                    <tr>
                        <th width="100"> <div align="center">ตำบล </div></th>
                        <td><input type="text" name="tumbon" size="20" value="<%=result.getString("Tumbol")%>"></td>
                        <th width="100"> <div align="center">อำเภอ </div></th>
                        <td><input type="text" name="amphor" size="20" value="<%=result.getString("Amphor")%>"></td>
                    </tr>
                    <tr>
                        <th width="100"> <div align="center">จังหวัด </div></th>
                        <td><input type="text" name="city" size="20" value="<%=result.getString("Province")%>"></td>
                        <th width="100"> <div align="center">รหัสไปรษณีย์ </div></th>
                        <td><input type="text" name="zipcode" size="20" value="<%=result.getString("Postal")%>"></td>
                    </tr>
                    <tr>
                        <td align="center">
                            <input type="submit" name="Submit" value="Confirm">
                            </form> 
                        </td>
                    </tr>
                </table>    
                <%}
                    }%>

                </body>
                </html>
