<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" import="bookstore.cart.*,java.util.*,java.text.*" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@page contentType="text/html; charset=UTF-8"  %>
<jsp:useBean id="db" class="bookstore.cart.Dbconnect" scope="session" />
<html>
    <head>
        <%
            Connection connect = null;
            Statement s = null;
            db.doConnection();
            s = db.getConnection().createStatement();
            String category = null;
            int[] num = new int[9];
            PreparedStatement ps = db.getConnection().prepareStatement("SELECT * FROM book");
            ResultSet result = ps.executeQuery();
            while (result.next()) {
                category = result.getString("category");
                if (category.equals("000")) {
                    num[0] = num[0] + 1;
                }
                if (category.equals("100")) {
                    num[1] = num[1] + 1;
                }
                if (category.equals("200")) {
                    num[2] = num[2] + 1;
                }
                if (category.equals("300")) {
                    num[3] = num[3] + 1;
                }
                if (category.equals("400")) {
                    num[4] = num[4] + 1;
                }
                if (category.equals("500")) {
                    num[5] = num[5] + 1;
                }
                if (category.equals("600")) {
                    num[6] = num[6] + 1;
                }
                if (category.equals("700")) {
                    num[7] = num[7] + 1;
                }
                if (category.equals("800")) {
                    num[8] = num[8] + 1;
                }
                if (category.equals("900")) {
                    num[9] = num[9] + 1;
                }
            }
        %>
        <script type="text/javascript" src="js/loader.js"></script>
        <script type="text/javascript">
            google.charts.load('current', {'packages': ['corechart']});
            google.charts.setOnLoadCallback(drawChart);
            function drawChart() {
                var x = <%= num[0]%>;
                var data = google.visualization.arrayToDataTable([
                    ['Task', 'amont of book'],
                    ['ทั่วไป', <%= num[0]%>],
                    ['การ์ตูน', <%= num[7]%>],
                    ['วรรณกรรม', <%= num[8]%>]
                ]);

                var options = {
                    title: 'My Daily Activities'
                };

                var chart = new google.visualization.PieChart(document.getElementById('piechart'));

                chart.draw(data, options);
            }
        </script>
    </head>
    <body>
        <div id="piechart" style="width: 900px; height: 500px;"></div>
    </body>
</html>