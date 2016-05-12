<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" import="bookstore.cart.*,java.util.*,java.text.*" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="account" class="bookstore.cart.account" scope="session" />
<jsp:useBean id="db" class="bookstore.cart.Dbconnect" scope="session" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include  file="template/head.jsp"%>
    </head>
    <body bgcolor="#FFE7BA">
        <% //----------------------------------รายการสั่งซื้อ----------------------------------------------------------------------------- 
            request.setCharacterEncoding("UTF-8");
            db.doConnection();
            PreparedStatement ps = db.getConnection().prepareStatement("SELECT * FROM orders where Status != " + "'ชำระเงินสำเร็จ'" + "");
            ResultSet result = ps.executeQuery();
            ResultSet result2;
            String a = request.getParameter("status");
            int i = 0; %>
        <table id="t0" border="1" width="1000" align="center">
            <tr>
            <th width="150"> <div align="center">หมายเลขสั่งซื้อ </div></th>
            <th width="150"> <div align="center">ชื่อ-นามสกุล </div></th>
            <th width="150"> <div align="center">เวลาสั่งซื้อ </div></th>
            <th width="150"> <div align="center">ราคา </div></th>
            <th width="150"> <div align="center">สถานะการสั่งซื้อ </div></th>
            
        </tr>
        <%while (result.next()) {%>          
        <tr>
        <form method="post" action="Orderedit.jsp">
            <td><div align="center"><%=result.getInt("OrderID")%></div></td>
            <td><%=result.getString("Name")%> <%=result.getString("Surname")%></td>
            <td><%=result.getDate("OnDate")%></td>
            <td><%=result.getFloat("total")%></td>
            <td align="center"><%=result.getString("Status")%></td>
            <td>                  
                <select name="status<%=i%>" size="1" id="status<%=i%>">
                    <option value="รอการชำระเงิน" selected>รอการชำระเงิน</option>
                    <option value="ชำระเงินสำเร็จ">ชำระเงินสำเร็จ</option>
                    <option value="อยู่ระหว่างการจัดส่ง">อยู่ระหว่างการจัดส่ง</option>
                    <option value="รายการถูกยกเลิก">รายการถูกยกเลิก</option>
                </select>
                <input type="submit" name="status" id="status" value="Edit">
            </td>
        </form>
        <%
            Statement s = null;
            db.doConnection();
            s = db.getConnection().createStatement();
            DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
            Date date = new Date();
            String strDate = dateFormat.format(date);
            
            result2 = s.executeQuery("select * from orders where OrderID= '" + result.getInt("OrderID") + "'");
            if (request.getParameter("status" + i) != null) {
                if (result2.next()) {
                    String Status = "UPDATE orders "
                            + "SET Status = '" + request.getParameter("status" + i) + "' "
                            + ", dateconfirm = '" + strDate + "' "
                            + " WHERE OrderID = '" + result.getInt("OrderID") + "' ";
                    s.execute(Status);
        %><META HTTP-EQUIV="refresh" 
              CONTENT="0;URL=Orderedit.jsp"><%
                      }
                  }
                  i++;
                  s.close();
                  result2.close();
        %>
        </tr>

        <%  }
            result.close();
            db.endConnection();
        %>
    </table><br><br><br><br><br><br>
    <style>
    th, td {
        padding: 15px;
        color: black;
    }
    table#t0 tr:nth-child(even) {
        background-color: #eee;
    }
    table#t0 tr:nth-child(odd) {
        background-color:#fff;
    }
    a {
        color: black;
    }
</style>
</body>
</html>
