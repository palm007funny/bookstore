<%@ page language="java" import="bookstore.cart.*,java.util.*,java.text.*" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.IOException" %>
<%@ page import="jxl.Workbook" %>
<%@ page import="jxl.write.Label" %>
<%@ page import="jxl.write.WritableSheet" %>
<%@ page import="jxl.write.WritableWorkbook" %>
<%@page import="jxl.Cell"%>
<%@page import="jxl.CellType"%>
<%@page import="jxl.Sheet"%>
<%@page import="jxl.read.biff.BiffException"%>

<%@page contentType="text/html; charset=UTF-8"  %>
<html>
    <head>
        <title>ThaiCreate.Com JSP Tutorial</title>
    </head>
    <body>

        <%
            try {
                String fileName = application.getRealPath("/book.xls");
                File inputWorkbook = new File(fileName);
                Workbook w = Workbook.getWorkbook(inputWorkbook);
                editBook book = new editBook();

                Sheet sheet = w.getSheet(0);
%>   
        <%    for (int j = 0; j <= sheet.getColumns(); j++) {

                    Cell[] cell = sheet.getRow(j);
                    book.Add(cell[1].getContents(), cell[2].getContents(), cell[3].getContents(), cell[4].getContents(), cell[5].getContents()
                            , cell[6].getContents(), cell[7].getContents(), cell[8].getContents(), cell[9].getContents(),cell[10].getContents());

                }
                w.close();

            } catch (Exception e) {
                e.printStackTrace();
            }

        %>
ok
</body>
</html>
