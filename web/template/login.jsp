<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="account" class="bookstore.cart.account" scope="session" />
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>       
        <%
            String user = request.getParameter("username");
            String pass = request.getParameter("password");
            if (account.getLogin() == false) {
        %>  
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
                <%if (account.checkAdmin() == 1){  %>                   
                    <br><a href="Admin.jsp">ผู้ดูแล</a>
                    <%}%>
                <% if (request.getParameter("logout") != null) {
                    account.Logout(true);%>
                <META HTTP-EQUIV="refresh" 
                      CONTENT="0;URL=index.jsp">
                <%}
                }%>
                </tr>
            </table> 
            <br>
            </body>
            </html>
