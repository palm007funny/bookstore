<%@page import="java.util.Vector"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="cart" class="bookstore.cart.Cart" scope="session" />

<html>
<head>
<style>
ul {
    list-style-type: none;
    margin: 0;
    padding: 7px;
    overflow: hidden;
    background-color: #333;
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
      <a href="bookcategory.jsp?category=700"">การ์ตูน</a>
      <a href="bookcategory.jsp?category=800"">วรรณกรรม</a>
    </div>
  </li>
  <li><a href="userdetail.jsp">จัดการบัญชี</a></li>
  <li><a href="report.jsp">จัดการบัญชี</a></li>
  <%Vector numcart = cart.getCart();
    numcart.size();%>
  <ri>จำนวนสินค้าในตระกร้า <%=numcart.size()%></ri>
  <ri><a href="cartlist.jsp"> <img src=image/cart.png width="45" height="40"></a></ri>

</ul>
<script>
/* When the user clicks on the button, 
toggle between hiding and showing the dropdown content */
function myFunction() {
    document.getElementById("myDropdown").classList.toggle("show");
}

// Close the dropdown if the user clicks outside of it
window.onclick = function(e) {
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
