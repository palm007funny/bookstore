<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language="java" import="bookstore.cart.*,java.util.*,java.text.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer</title>
    </head>
    <body bgcolor="#FFE7BA">
        <form name="customer" method="post" action="checkout.jsp">	
	<table width="600" border="1">
	<th width="140">
    <div align="left">ชื่อ </div></th>
		<td><input type="text" name="firstname" size="20"></td>
	<th width="140">
    <div align="left">นามสกุล </div></th>
		<td><input type="text" name="lastname" size="20"></td>
        <tr>
            <th width="140">
    <div align="left">Email </div></th>
            <td><input type="text" name="email" size="20"></td>

            <th width="140">
    <div align="left">โทรศัพท์ </div></th>
            <td><input type="text" name="phone" size="20"></td>
  </tr>
  <tr>
	<th width="140">
    <div align="left">บ้านเลขที่ </div></th>
		<td><input type="text" name="address" size="20"></td>
        <th width="140">
    <div align="left">ถนน </div></th>
		<td><input type="text" name="road" size="20"></td>
	</tr>
        <th width="140">
    <div align="left">ตำบล </div></th>
		<td><input type="text" name="tumbon" size="20"></td>
        <th width="140">
    <div align="left">อำเภอ </div></th>
		<td><input type="text" name="amphur" size="20"></td>
	</tr>
        <th width="140">
    <div align="left">จังหวัด </div></th>
		<td><input type="text" name="city" size="20"></td>
        <th width="140">
    <div align="left">รหัสไปรษณีย์ </div></th>
		<td><input type="text" name="zipcode" size="20"></td>
	</tr>
         
	</table>
	<input type="submit" value="Add">
	</form> 
    </body>
</html>
