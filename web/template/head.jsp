<%@page import="java.util.Vector"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<html>
    <head>
        <style>
            body {
                background: #555 url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAB9JREFUeNpi/P//PwM6YGLAAuCCmpqacC2MRGsHCDAA+fIHfeQbO8kAAAAASUVORK5CYII=);
                font: 13px 'Lucida sans', Arial, Helvetica;
                color: #eee;
            }
            ul {
                list-style-type: none;
                margin: 0;
                padding: 7px;
                overflow: hidden;
                background-color: #333;
            }
            a {
                color: #eee;
                text-decoration:none
            }
            li {
                float: left;
            }

            li a, .dropbtn {
                display: inline-block;
                color: white;
                text-align: center;
                padding: 20px 16px;
                text-decoration: none;
                font-size:120%
            }

            li a:hover, .dropdown:hover .dropbtn {
                background-color: red;
            }

            li.dropdown {
                display: inline-block;
            }
            ri {
                float: right;
                display: inline-block;
                color: white;
                text-align: center;
                padding: 14px 16px;
                text-decoration: none;
                font-size:120%
            }
            ri a, .dropbtn {
                display: inline-block;
                color: white;
                text-align: center;
            }

            ri a:hover, .dropdown:hover .dropbtn {
                background-color: red;
            }

            ri.dropdown {
                display: inline-block;
            }
            .dropdown-content {
                display: none;
                position: absolute;
                background-color: #f9f9f9;
                min-width: 160px;
                box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            }

            .dropdown-content a {
                color: black;
                padding: 12px 16px;
                text-decoration: none;
                display: block;
                text-align: left;
            }

            .dropdown-content a:hover {background-color: #f1f1f1}

            .show {display:block;}
        </style>
    </head>
    <body>
        <ul>
            <li><a class="active" href="index.jsp">Home</a></li>
            <li><a href="register.jsp">Register</a></li>
            <li class="dropdown">
                <a href="javascript:void(0)" class="dropbtn" onclick="myFunction()">หมวดหมู่</a>
                <div class="dropdown-content" id="myDropdown">
                    <a href="bookcategory.jsp?category=000">ทั่วไป</a>
                    <a href="bookcategory.jsp?category=100">จิตวิทยา</a>
                    <a href="bookcategory.jsp?category=200">ศาสนา</a>
                    <a href="bookcategory.jsp?category=400">ภาษา</a>
                    <a href="bookcategory.jsp?category=500">วิทยาศาสตร์</a>
                    <a href="bookcategory.jsp?category=700"">การ์ตูน</a>
                    <a href="bookcategory.jsp?category=600"">กีฬา/เกม</a>
                    <a href="bookcategory.jsp?category=800"">วรรณกรรม</a>
                </div>
            </li>
            <li class="user">
                <a href="javascript:void(0)" class="dropbtn" onclick="user()">จัดการบัญชี</a>
                <div class="dropdown-content" id="myuser">
                    <a href="editprofile.jsp">แก้ไขข้อมูล</a>
                    <a href="userorder.jsp?order=<%=1%>">รายการสั่งซื้อ</a>

                </div>
            <li><a href="graph.jsp">report</a></li>
            <li><a href="report.jsp">report</a></li>
            <li><a href="sale_report.jsp">sale</a></li>
            <%int cartsize = 0;
            session.setAttribute("cartsize",cartsize);
                if (!session.getAttribute("cartsize").equals(null)){
                    cartsize = Integer.valueOf(String.valueOf(session.getAttribute("cartsize")));
                }
            %>
            <ri>จำนวนสินค้าในตระกร้า <%out.print(cartsize);%></ri>
            <ri><a href="cartlist.jsp"> <img src=image/cart.png width="45" height="40"></a></ri>

        </ul>
        <script>
            /* When the user clicks on the button, 
             toggle between hiding and showing the dropdown content */
            function myFunction() {
                document.getElementById("myDropdown").classList.toggle("show");
            }
            function user() {
                document.getElementById("myuser").classList.toggle("show");
            }

        // Close the dropdown if the user clicks outside of it
            window.onclick = function (e) {
                if (!e.target.matches('.dropbtn')) {

                    var dropdowns = document.getElementsByClassName("dropdown-content");
                    for (var d = 0; d < dropdowns.length; d++) {
                        var openDropdown = dropdowns[d];
                        if (openDropdown.classList.contains('show')) {
                            openDropdown.classList.remove('show');
                        }
                    }
                }
            };
        </script>
    </body>
</html>
