
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" import="bookstore.cart.*,java.util.*,java.text.*" %>
<jsp:useBean id="account" class="bookstore.cart.account" scope="session" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Book List</title>
        <h1><center> รายชื่อหนังสือ </center></h1>
    </head>
    <body bgcolor="#FFE7BA">
        <br>
      <% 
       String user = request.getParameter("username");
       String pass = request.getParameter("password");
        if (account.getLogin() == false){
        %>
    <form>
                <table>
                    <tr>
                        <td> Username  : </td><td> <input name="username" size=15 type="text" /> </td> 
                        <td> Password  : </td><td> <input name="password" size=15 type="password" /> </td>                                           
                <td><input type="submit" value="login" /></td>
                </tr>
                </table>   
            </form>
    <%     
       account.Login(user, pass);      
       if (user != null){%>
       <META HTTP-EQUIV="refresh" 
            CONTENT="0;URL=booklist.jsp">
      <% }
       }else { 
        out.print("Welcome  "+account.getUsername()); %>
        <a href="booklist.jsp?logout=<%=1%>">LogOut</a>
        <% if (request.getParameter("logout") != null ){
            account.Logout(true);%>
            <META HTTP-EQUIV="refresh" 
            CONTENT="0;URL=booklist.jsp">
         <%}} %>  

      <table id="t0" border="2" bordercolor="#EEC591" style="width:14%" align="left"> 
          
          <tr><td><center><p><a href="register.jsp">สมัครสมาชิค</a></p></center></td></tr>
          <tr><td><center><p><a href="booklist.jsp">รายชื่อหนังสือ</a></p></center></td></tr>
          <tr><td><center><p><a href="cartlist.jsp">ตะกร้าสินค้า</a></p></center></td></tr>
          <tr><td><center><p><a href="index.jsp">หน้าแรก</a></p></center></td></tr>
          <% if (account.checkAdmin() == 1){ %>
        <tr><td><center><p><a href="addbook.jsp">เพิ่ม-ลบหนังสือ</a></p></td></center></tr>
        <%}%>
      </table>
      <%  int numbook=0;
          int row = 5;
        Dbconnect db = new Dbconnect();
        db.doConnection();
        PreparedStatement ps = db.getConnection().prepareStatement("SELECT * FROM book");
        ResultSet result = ps.executeQuery();%>
        
        <table id="t1" border="0" style="width:85%" align="right">
        <tr><%while (result.next()) {       
                numbook++;
                }%> 
            
        <% result.beforeFirst();
            for(int i = 0; i < (numbook/row);i++){
                for(int j=0;j < row;j++){
            result.next(); %>       
        <th><center> <%out.print(result.getString("bookname"));%></center></th>  
                    </a></td>
        <%}
        out.print("<tr></tr>");
        for(int j=0;j < row;j++){
        result.previous();
        }
        for(int j=0;j < row;j++){
            result.next(); %>       
        <td><center> <a href="bookdetail.jsp?id=<%=result.getString("id")%>">
                <%out.print("<img src=image/"+result.getString("picture"));%> width="230" height="330">   
                    </a></center></td>
        <%}
        out.print("<tr></tr>");

            }
            
       
            for(int k=0; k < (numbook%row);k++){
            result.next(); %>       
        <th><center> <%out.print(result.getString("bookname"));%></center></th>
       <% }%>
        
        <% for(int j=0;j < (numbook%row);j++){
        result.previous();
        }
        out.print("<tr></tr>");
        for(int k=0; k < (numbook%row);k++){
            result.next(); %>   
        <td><center> <a href="bookdetail.jsp?id=<%=result.getString("id")%>">
                <%out.print("<img src=image/"+result.getString("picture"));%> width="230" height="330">   
            </a></center></td>
        <%
            }
        
          result.beforeFirst();
          %>
                
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
</style>
            <% db.endConnection();  %>
</html>
