
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" import="bookstore.cart.*,java.util.*,java.text.*" %>
<jsp:useBean id="account" class="bookstore.cart.account" scope="session" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>BookStore</title>
    <h1><center> BookStore </center></h1>
</head>
<body bgcolor="#FFE7BA">
    <%
        String user = request.getParameter("username");
        String pass = request.getParameter("password");
        if (account.getLogin() == false) {
    %>
    7
    <form>
        <table>
            <tr>
                <td> Username  : </td><td> <input name="username" size=15 type="text" /> </td> 
                <td> Password  : </td><td> <input name="password" size=15 type="password" /> </td>                                           
                <td><input type="submit" value="login" /></td>


                </form>               
                <%
                    account.Login(user, pass);
                    if (user != null) {%>
            <META HTTP-EQUIV="refresh" 
                  CONTENT="0;URL=index.jsp">
            <% }
            } else {
                out.print("<td>Welcome </td><td> " + account.getUsername() + "</td>");%>
            <a href="index.jsp?logout=<%=1%>">LogOut</a>
            <% if (request.getParameter("logout") != null) {
                    account.Logout(true);%>
            <META HTTP-EQUIV="refresh" 
                  CONTENT="0;URL=index.jsp">
            <%}
                } %>
            </tr>
        </table> 
        <br>
        <table id="t0" border="2" bordercolor="#EEC591" width="250" align="left"> 

            <tr><td><center><p><a href="register.jsp">สมัครสมาชิค</a></p></center></td></tr>
            <tr><td><center><p><a href="cartlist.jsp">ตะกร้าสินค้า</a></p></center></td></tr>
            <tr><td><center><p><a href="userdetail.jsp">จัดการบัญชี</a></p></center></td></tr>
            <tr><td><center><p><a href="index.jsp">หน้าแรก</a></p></center></td></tr> 

        </table>
        <%  int numbook = 0;
            int row = 5;
            Dbconnect db = new Dbconnect();
            db.doConnection();
            PreparedStatement ps = db.getConnection().prepareStatement("SELECT * FROM book");
            ResultSet result = ps.executeQuery();%>
        <div id="section">
            <table id="t1" border="0" width="1150" align="left">
                <tr><%while (result.next()) {
                    numbook++;
                }%> 

                    <% result.beforeFirst();
                        for (int i = 0; i < (numbook / row); i++) {
                            for (int j = 0; j < row; j++) {
                            result.next(); %>       
                    <th><center> <%out.print(result.getString("bookname"));%></center></th>  
                </a></td>
                <%}
                    out.print("<tr></tr>");
                    for (int j = 0; j < row; j++) {
                        result.previous();
                    }
                    for (int j = 0; j < row; j++) {
                    result.next();%>       
                <td><center> <a href="bookdetail.jsp?id=<%=result.getString("id")%>">
                        <%out.print("<img src=image/" + result.getString("picture"));%> width="230" height="330">   
                    </a></center></td>
                    <%}
                            out.print("<tr></tr>");

                        }

                        for (int k = 0; k < (numbook % row); k++) {
                        result.next(); %>       
                <th><center> <%out.print(result.getString("bookname"));%></center></th>
                    <% }%>

                <% for (int j = 0; j < (numbook % row); j++) {
                        result.previous();
                    }
                    out.print("<tr></tr>");
                    for (int k = 0; k < (numbook % row); k++) {
                    result.next();%>   
                <td><center> <a href="bookdetail.jsp?id=<%=result.getString("id")%>">
                        <%out.print("<img src=image/" + result.getString("picture"));%> width="230" height="330">   
                    </a></center></td>
                    <%
                        }

                        result.beforeFirst();
                    %>
        </div>
    </tr>
</table> 

<style>
    th, td {
        padding: 5px;
        text-align: left;               
    }
    table#t1 tr:nth-child(even) {
        background-color: #eee;
    }
    table#t1 tr:nth-child(odd) {
        background-color:#fff;
    }
    table#t1 th	{
        background-color: black;
        color: white;
    }
    table#t0 tr:nth-child(even) {
        background-color: #EEC591;
    }
    table#t0 tr:nth-child(odd) {
        background-color: #EEC591;
    }
    #section {
        width:250px;
        float:left;
         	 
    }
</style>
<% db.endConnection();%>
</html>
