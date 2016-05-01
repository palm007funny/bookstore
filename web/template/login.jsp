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
            String save = request.getParameter("save");
            if (request.getCookies() != null) {
                String cookieUser = "ck_userLogin";
                String cookiePass = "ck_passLogin";
                Cookie cookies[] = request.getCookies();
                Cookie myCookieUser = null;
                Cookie myCookiePass = null;
                if (cookies != null) {
                    for (int i = 0; i < cookies.length; i++) {
                        if (cookies[i].getName().equals(cookieUser)) {
                            myCookieUser = cookies[i];

                            //break;
                        }
                        if (cookies[i].getName().equals(cookiePass)) {
                            myCookiePass = cookies[i];
                            break;
                        }
                    }
                }
                if (myCookieUser != null && myCookiePass != null) {
                    session.setAttribute("ss_userLogin", myCookieUser.getValue());
                    session.setAttribute("ss_passLogin", myCookiePass.getValue());
                }
            }
            if (account.getLogin() == false) {
        %>  
        <form>
            <table>
                <tr>
                    <td> Username  : </td><td> <input name="username" size=15 type="text" /> </td> 
                    <td> Password  : </td><td> <input name="password" size=15 type="password" /> </td>
                    <td><input type="checkbox" name="save" value="1" />จำค่าล็อกอิน<br /></td>
                    <td><input type="submit" value="login" /></td>
                    </form>               
                    <%
                        account.Login(user, pass);
                        if (user != null) {
                            if (save != null) { //จำค่าล็อกอิน จะเก็บข้อมูลแบบคุ๊กกี้
                                Cookie cc_user = new Cookie("ck_userLogin", account.getUsername());
                                Cookie cc_pass = new Cookie("ck_passLogin", account.getPassword());
                                cc_user.setMaxAge(365 * 24 * 60 * 60);//เก็บค่าล็อกอินไว้ 1 ปี
                                cc_pass.setMaxAge(365 * 24 * 60 * 60);
                                response.addCookie(cc_user);
                                response.addCookie(cc_pass);
                            }

                            session.setAttribute("ss_userLogin", account.getUsername());
                            session.setAttribute("ss_passLogin", account.getPassword());
                            response.setIntHeader("Refresh", 0);
                        }
                        if (session.getAttribute("ss_userLogin") != null && session.getAttribute("ss_passLogin") != null) {
                            user = String.valueOf(session.getAttribute("ss_userLogin"));
                            pass = String.valueOf(session.getAttribute("ss_passLogin"));
                            account.Login(user, pass);
                            response.setIntHeader("Refresh", 0);
                        }
                    } else {
                        out.print("<td>Welcome </td><td> " + account.getUsername() + "</td>");%>                  
                <a href="index.jsp?logout=<%=1%>">LogOut</a>
                <%if (account.checkAdmin() == 1) {  %>                   
                <br><a href="Admin.jsp">ผู้ดูแล</a>
                <%}%>
                <% if (request.getParameter("logout") != null) {
                            account.Logout(true);
                            if (session.getAttribute("ss_userLogin") != null) {
                                session.removeAttribute("ss_userLogin");
                                session.removeAttribute("ss_passLogin");
                            }
                            if (request.getCookies() != null) {//เคลียร์Cookie
                                Cookie cookies[] = request.getCookies();
                                if (cookies != null) {
                                    for (int i = 0; i < cookies.length; i++) {
                                        if (cookies[i].getName().equals("ck_userLogin")) {
                                            cookies[i].setMaxAge(0);
                                            response.addCookie(cookies[i]);
                                        }
                                        if (cookies[i].getName().equals("ck_passLogin")) {
                                            cookies[i].setMaxAge(0);
                                            response.addCookie(cookies[i]);
                                            break;
                                        }
                                    }
                                }
                            }
                            response.setIntHeader("Refresh", 0);
                        }
                    }

                %>
                </tr>
            </table> 
            <br>
            </body>
            </html>
