<%-- 
    Document   : register
    Created on : Jan 25, 2016, 2:25:36 PM
    Author     : Palm
--%>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page language="java" import="bookstore.cart.*,java.util.*,java.text.*" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<jsp:useBean id="account" class="bookstore.cart.account" scope="session" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <h1><center> Register </center></h1>
        <%@include  file="template/head.jsp"%>
    </head>
    <body bgcolor="#FFE7BA">

        <form name="frmAdd" method="post">	
            <table style="width:25%" border="2" >  

                <tr>
                    <th width="140">
                        <div align="left">Username </div></th>
                    <td><input type="text" name="username" size="25"></td>
                </tr>
                <tr>
                    <th width="140">
                        <div align="left">Password </div></th>
                    <td><input type="password" name="password" size="25"></td>
                </tr>
                <tr>
                    <th width="140">
                        <div align="left">ComFirmPassword </div></th>
                    <td><input type="password" name="confirmpassword" size="25"></td>
                </tr>  
                <tr>
                    <th width="140">
                        <div align="left">Email </div></th>
                    <td><input type="text" name="Email" size="25"></td>
                </tr>
                <th width="140">
                    <div align="left">ชื่อ </div></th>
                <td><input type="text" name="name" size="25"></td>
                </tr>
                <th width="140">
                    <div align="left">นามสกุล </div></th>
                <td><input type="text" name="lastname" size="25"></td>
                </tr>
                <tr>
                    <th width="150"> <div align="left">เบอร์โทรศัพท์ </div></th>
                    <td><input type="text" name="Phone" size="25" ></td>
                </tr>
                <tr>
                    <th width="150"> <div align="left">บ้านเลขที่ </div></th>
                    <td><input type="text" name="AddressNo" size="25" ></td>
                </tr>
                <tr>
                    <th width="150"> <div align="left">ถนน </div></th>
                    <td><input type="text" name="Street" size="25" ></td>
                </tr>
                <tr>
                    <th width="150"> <div align="left">ตำบล/แขวง </div></th>
                    <td><input type="text" name="Tumbol" size="25" ></td>
                </tr>
                <tr>
                    <th width="150"> <div align="left">อำเภอ/เขต </div></th>
                    <td><input type="text" name="Amphor" size="25" ></td>
                </tr>
                <tr>
                    <th width="150"> <div align="left">จังหวัด </div></th>
                    <td><input type="text" name="Province" size="25" ></td>
                </tr>
                <tr>
                    <th width="150"> <div align="left">รหัสไปรณีย์ </div></th>
                    <td><input type="text" name="Postal" size="25"></td>
                </tr>
            </table>
            <input type="submit" value="สมัครสมาชิก">
        </form>
        <%  request.setCharacterEncoding("UTF-8");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String confirmpassword = request.getParameter("confirmpassword");
            String email = request.getParameter("Email");
            String name = request.getParameter("name");
            String lastname = request.getParameter("lastname");
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
                    out.print(account.register(username, password, email, name, lastname, Phone,
                    AddressNo,Street,Tumbol,Amphor,Province,Postal));
                }
            }
        %>
        <style>
            table, th, td {
                border: 1px solid black;
                border-collapse: collapse;
            }
            th, td {
                padding: 5px;
            }
        </style>
    </body>
</html>
