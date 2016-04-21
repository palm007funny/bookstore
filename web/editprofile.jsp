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
        <%request.setCharacterEncoding("UTF-8");
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
                  CONTENT="1;URL=editprofile.jsp"><%
                              }
                          }
                          result.close();
                          s.close();
                      
                      db.endConnection();%>
    </body>
</html>
