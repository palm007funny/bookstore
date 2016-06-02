<%@ page language="java" import="bookstore.cart.*,java.util.*,java.text.*" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@page contentType="text/html;charset=UTF-8" language="java" %>

<html>
    <head>
        <title>Add Book</title>
        
    </head>
    <body bgcolor="#FFE7BA">

        <form name="frmAdd" method="post">	
            เพิ่มหนังสือ
            <%@include  file="template/head.jsp"%>
            <table id="t0" width="374" border="1">
                <tr>
                    <th width="140">
                        <div align="left">ชื่อหนังสือ </div></th>
                    <td><input type="text" name="bookname" size="20"></td>
                </tr>
                <tr>
                    <th width="140">
                        <div align="left">ราคา </div></th>
                    <td><input type="text" name="price" size="20"></td>
                </tr>
                <tr>
                    <th width="140">
                        <div align="left">ส่วนลด </div></th>
                    <td><input type="text" name="discount" size="20"></td>
                </tr>
                <tr>
                    <th width="140">
                        <div align="left">รูป </div></th>
                    <td><input type="text" name="picture" size="20"></td>
                </tr>

                <th width="140">
                    <div align="left">ข้อมูล </div></th>
                <td><input type="text" name="detail" size="20"></td>
                <tr>
                    <th width="140">
                        <div align="left">ขนาดหนังสือ </div></th>
                    <td><input type="text" name="booksize" size="20"></td>
                </tr>
                <tr>
                    <th width="140">
                        <div align="left">น้ำหนัก </div></th>
                    <td><input type="text" name="bookweight" size="20"></td>
                </tr>
                <tr>
                    <th width="140">
                        <div align="left">สำนักพิมพ์ </div></th>
                    <td><input type="text" name="company" size="20"></td>
                </tr>
                <tr>
                    <th width="140">
                        <div align="left">ปีที่พิมพ์ </div></th>
                    <td><input type="text" name="date" size="20"></td>
                </tr>



            </table>
            <input type="submit" value="Add">
        </form> 

        <%          request.setCharacterEncoding("UTF-8");
            editBook book = new editBook();
            String bookname = request.getParameter("bookname");
            String detail = request.getParameter("detail");
            String picture = request.getParameter("picture");
            String price = request.getParameter("price");
            String discount = request.getParameter("discount");
            String booksize = request.getParameter("booksize");
            String bookweight = request.getParameter("bookweight");
            String company = request.getParameter("company");
            String date = request.getParameter("date");
            String Stock = "0";
            String category = "";
            book.Add(bookname, detail, picture, price, discount, booksize, bookweight, company, date,Stock,category);

            try {
                Connection connect = null;
                Statement s = null;

                Dbconnect db = new Dbconnect();
                db.doConnection();
                s = db.getConnection().createStatement();
                String sql = "SELECT * FROM  book ORDER BY id ASC";
                ResultSet result = s.executeQuery(sql);
        %>
        <font size="5"><p><a href="bookdata.jsp">excel</a></p></font>
        <table id="t0"width="600" border="1">
            <tr>
                <th width="91"> <div align="center">Book ID </div></th>
                <th width="98"> <div align="center">Bookname </div></th>
                <th width="71"> <div align="center">price </div></th>
                <th width="71"> <div align="center">discount </div></th>
            </tr>	
            <%while ((result != null) && (result.next())) {%>
            <tr>
                <td><div align="center"><%=result.getString("id")%></div></td>
                <td><%=result.getString("bookname")%></td>
                <td align="right"><%=result.getFloat("price")%></td>
                <td align="right"><%=result.getFloat("discount")%></td>
                <td align="center"> <a href="addbook.jsp?id=<%=result.getString("id")%>">Del</a></td>
            </tr>
            <%}
                } catch (Exception e) {
                }%>
            <%String del = request.getParameter("id");
                if (request.getParameter("id") != null) {
                    book.Del(del); %>
            <META HTTP-EQUIV="refresh" 
                  CONTENT="0;URL=addbook.jsp">
            <%}%>
        </table>      
        <p><a href="index.jsp">หน้าแรก</a></p>

    </body>
</html>

