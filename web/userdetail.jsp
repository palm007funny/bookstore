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
        <%@include  file="template/head.jsp"%>
                <%  request.setCharacterEncoding("UTF-8");
                    String user = request.getParameter("username");
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
                      CONTENT="0;URL=userdetail.jsp">
                <% }
                } else {%>                
                <table id="t0" border="2" bordercolor="#EEC591" width="250" align="left"> 

                    <tr><td><center><p><a href="userdetail.jsp?edit=<%=1%>">แก้ไขข้อมูล</a></p></center></td></tr>
                    <tr><td><center><p><a href="userdetail.jsp?order=<%=1%>">รายการสั่งซื้อ</a></p></center></td></tr>                                         
                    <tr><td><center><p><a href="index.jsp">หน้าแรก</a></p></center></td></tr>
                                <% if (account.checkAdmin() == 1) { %>
                    <tr><td><center><p><a href="Admin.jsp">Admin</a></p></td></center></tr>
                                <%}%>
                    <tr><td><center><p><a href="userdetail.jsp?logout=<%=1%>">LogOut</a></p></center></td></tr>
                </table>
                <% if (request.getParameter("logout") != null) {
                        account.Logout(true);%>
                <META HTTP-EQUIV="refresh" 
                      CONTENT="0;URL=index.jsp">
                <%}
                    } %>
                </tr>
            </table> 
            <% //----------------------------------รายการสั่งซื้อ----------------------------------------------------------------------------- 
                if (request.getParameter("order") != null) {
                    Connection connect = null;
                    Statement s = null;
                    db.doConnection();
                    s = db.getConnection().createStatement();
                    ResultSet result = s.executeQuery("select * from orders where idaccount= '" + account.getID() + "'");
                    int orderID;%>
            <table border="0" width="500" align="left">
                <tr><td>
                        <%while (result.next()) {
                        %>

                        <table id="t2" border="1" width="600" align="left">
                            <tr>
                                <th width="150"> <div align="center">หมายเลขสั่งซื้อ </div></th>
                                <th width="150"> <div align="center">เวลาสั่งซื้อ </div></th>
                                <th width="150"> <div align="center">สถานะการสั่งซื้อ </div></th>
                            </tr>
                            <tr>
                                <td><div align="center"><%=result.getInt("OrderID")%></div></td>
                                <td><%=result.getDate("OnDate")%></td>
                                <td align="center"><%=result.getString("Status")%></td>
                                <td align="center"> <a href="userdetail.jsp?orderID=<%=result.getInt("OrderID")%>">รายละเอียดสินค้า</a></td>
                            </tr>
                        </table><br><br><br><br><br><br>
                        <%  }
                } %>
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
                        <table id="t2" border="1" width="750" align="left">
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
                     while (result3.next()){     %>
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
            <%------------------------------------------------------------------------------------------------------------------------------%>
            <%--------------------------------------------แก้ไขข้อมูล--------------------------------------------------------------------------%>
            <% if (request.getParameter("edit") != null) {
                    Connection connect = null;
                    Statement s = null;
                    db.doConnection();
                    s = db.getConnection().createStatement();
                    ResultSet result = s.executeQuery("select * from account where idaccount= '" + account.getID() + "'");
                    if (result.next()) {
            %>
            <form name="frmupdate" method="post">
                <table id="t2" border="1" width="750" align="left">
                    <tr>
                        <th width="150"> <div align="center">ชื่อ </div></th>
                        <td><input type="text" name="name" size="20" value="<%=result.getString("Name")%>"></td>
                    </tr>
                    <tr>
                        <th width="150"> <div align="center">นามสกุล </div></th>
                        <td><input type="text" name="lastName" size="20" value="<%=result.getString("lastName")%>"></td>
                    </tr>
                    <tr>
                        <th width="150"> <div align="center">Email </div></th>
                        <td><input type="text" name="email" size="20" value="<%=result.getString("email")%>"></td>
                    </tr>
                    <tr>
                        <th width="150"> <div align="center">เบอร์โทรศัพท์ </div></th>
                        <td><input type="text" name="Phone" size="20" value="<%=result.getString("Phone")%>"></td>
                    </tr>
                    <tr>
                        <th width="150"> <div align="center">บ้านเลขที่ </div></th>
                        <td><input type="text" name="AddressNo" size="20" value="<%=result.getString("AddressNo")%>"></td>
                    </tr>
                    <tr>
                        <th width="150"> <div align="center">ถนน </div></th>
                        <td><input type="text" name="Street" size="20" value="<%=result.getString("Street")%>"></td>
                    </tr>
                    <tr>
                        <th width="150"> <div align="center">ตำบล/แขวง </div></th>
                        <td><input type="text" name="Tumbol" size="20" value="<%=result.getString("Tumbol")%>"></td>
                    </tr>
                    <tr>
                        <th width="150"> <div align="center">อำเภอ/เขต </div></th>
                        <td><input type="text" name="Amphor" size="20" value="<%=result.getString("Amphor")%>"></td>
                    </tr>
                    <tr>
                        <th width="150"> <div align="center">จังหวัด </div></th>
                        <td><input type="text" name="Province" size="20" value="<%=result.getString("Province")%>"></td>
                    </tr>
                    <tr>
                        <th width="150"> <div align="center">รหัสไปรณีย์ </div></th>
                        <td><input type="text" name="Postal" size="20" value="<%=result.getString("Postal")%>"></td>
                    </tr>
                    <tr>
                        <td>เปลี่ยนรหัสผ่าน</td>
                    </tr>
                    <tr>
                        <th width="150"> <div align="center">new Password </div></th>
                        <td><input type="password" name="password" size="20" value=""></td>
                    </tr>
                    <tr>
                        <th width="150"> <div align="center">Confirm new Password </div></th>
                        <td><input type="password" name="repassword" size="20" value=""></td>
                    </tr>
                    <tr><td></td><td><input type="submit" value="Save"></td></tr>
                </table>
                </td></tr>
                </table>
            </form>
            <%}

                String name = request.getParameter("name");
                String lastname = request.getParameter("lastName");
                String password = request.getParameter("password");
                String confirmpassword = request.getParameter("repassword");
                String email = request.getParameter("email");
                String Phone = request.getParameter("Phone");
                String AddressNo = request.getParameter("AddressNo");
                String Street = request.getParameter("Street");
                String Tumbol = request.getParameter("Tumbol");
                String Amphor = request.getParameter("Amphor");
                String Province = request.getParameter("Province");
                String Postal = request.getParameter("Postal");
                if ((password != null) && (confirmpassword != null)) {
                    if (!password.equals(confirmpassword)) {
                        out.print("กรุณาใส่ password ให้ตรงกัน");
                    } else {
                        request.setCharacterEncoding("UTF-8");
                        out.print(account.update(name, lastname, email, password, Phone, AddressNo, Street, Tumbol, Amphor, Province, Postal, account.getID()));
            %><META HTTP-EQUIV="refresh" 
                  CONTENT="1;URL=userdetail.jsp?edit=1"><%
                              }
                          }
                          result.close();
                          s.close();
                      }
                      db.endConnection();%>
            <%------------------------------------------------------------------------------------------------------------------------------%>
            <style>
                th, td {
                    padding: 5px;
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
