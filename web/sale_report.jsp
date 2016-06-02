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
        <h1><center> Sale Report </center></h1>
        <%@include  file="template/head.jsp"%>
    </head>
    
    <body bgcolor="#FFE7BA">
        
        <% //----------------------------------รายการสั่งซื้อ----------------------------------------------------------------------------- 
            request.setCharacterEncoding("UTF-8");
            db.doConnection();
            PreparedStatement ps = db.getConnection().prepareStatement("SELECT * FROM orders where Status= '" + "ชำระเงินสำเร็จ" + "'");
            ResultSet result = ps.executeQuery();
            ResultSet result2;
            String a = request.getParameter("status");
            int i = 1;
            float grandtotal = 0;
            ArrayList date = new ArrayList();
            ArrayList price = new ArrayList();

        %>
        <br>
        <table id="t0" border="1" width="1000" align="center">
            <tr>
            <th width="50"> <div align="center">No. </div></th>
            <th width="50"> <div align="center">หมายเลขสั่งซื้อ </div></th>
            <th width="300"> <div align="center">ชื่อ-นามสกุล </div></th>
            <th width="150"> <div align="center">เวลาชำระเงิน </div></th>
            <th width="150"> <div align="center">ราคา </div></th>                      
        </tr>


        <%String fileName = application.getRealPath("/data.tsv");
            genCSV csv = new genCSV();
            csv.startGen(fileName);
            
            while (result.next()) {%>          
        <tr>
        <form method="post" action="Orderedit.jsp">
            <td><div align="center"><%= i%></div></td>
            <td><div align="center"><%=result.getInt("OrderID")%></div></td>
            <td><div align="center"><%=result.getString("Name")%> <%=result.getString("Surname")%></div></td>
            <td><div align="center"><%=result.getDate("dateconfirm")%></div></td>
            <td><div align="center"><%=result.getFloat("total")%></div></td>
                <%csv.generateCsvFile(String.valueOf(result.getDate("dateconfirm")), result.getFloat("total"));
                    grandtotal += result.getFloat("total");
                    date.add(result.getDate("dateconfirm"));
                    price.add(result.getFloat("total"));
                %>            
        </form>
    </tr>

    <%  i++;
        }
csv.endGen();
        result.close();
        db.endConnection();
        String oldStr = "";
        for (int d = 0; d < date.size(); d++) {
            if (date.get(d).toString().contains("-")) {
                oldStr = date.get(d).toString().replace("-", ",");
                date.set(d, oldStr);
            }
        }
    %>
</table>
<table id="t0" border="1" width="1000" align="center">
    <tr><td>รวม <%=grandtotal%></td></tr>
</table>

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
<script type="text/javascript">
    window.onload = function () {


        var chart = new CanvasJS.Chart("chartContainer",
                {
                    zoomEnabled: true,
                    title: {
                        text: "ข้อมูลการสั่งซื้อ"
                    },
                    animationEnabled: true,
                    axisX: {
                        labelAngle: 30
                    },
                    axisY: {
                        includeZero: false
                    },
                    data: data  // random generator below

                });

        chart.render();
    }
    var limit = <%=date.size()%>;    //increase number of dataPoints by increasing this
    var y = 0;
    var data = [];
    var dataSeries = {type: "line"};
    var dataPoints = [];
    <%for (int s = 0; s < date.size(); s++) {%>
    dataPoints.push({
        x: new Date(<%=date.get(s)%>),
        y: <%=price.get(s)%>
    });
    <%}%>

    dataSeries.dataPoints = dataPoints;
    data.push(dataSeries);

</script>
    
<script type="text/javascript" src="js/canvasjs.min.js"></script></head>
<body>
    <div id="chartContainer" style="height: 300px; width: 50%;position:absolute;left:25%;">
    </div>
</body>
</html>

