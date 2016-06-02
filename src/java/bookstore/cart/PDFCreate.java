package bookstore.cart;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import java.io.FileOutputStream;
import java.io.IOException;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.GrayColor;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class PDFCreate {

    Connection connect = null;

    public Font font(int size, BaseColor color) {
        Font f = FontFactory.getFont("D:\\micross.ttf",
                BaseFont.IDENTITY_H, BaseFont.EMBEDDED, size, Font.NORMAL, color);
        return f;
    }

    public Font font_BOLD(int size, BaseColor color) {
        Font f = FontFactory.getFont("D:\\micross.ttf",
                BaseFont.IDENTITY_H, BaseFont.EMBEDDED, size, Font.BOLD, color);
        return f;
    }

    public void createPdf(int orderID, int idaccount) throws IOException, DocumentException, ClassNotFoundException, SQLException {
        //-------------------------------- เรียกใช้ Database ---------------------------------------------------
        Class.forName("com.mysql.jdbc.Driver");
        connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore" + "?characterEncoding=UTF-8", "root", "");
        Statement s = connect.createStatement();
        Statement s2 = connect.createStatement();
        Statement s3 = connect.createStatement();
        Statement s4 = connect.createStatement();
        Dbconnect db = new Dbconnect();
        ResultSet result = s.executeQuery("select * from orderdetails where OrderID= '" + orderID + "'");
        ResultSet result2;
        ResultSet result3 = s3.executeQuery("select * from account where idaccount= '" + idaccount + "'");
        ResultSet result4 = s4.executeQuery("select * from orders where OrderID= '" + orderID + "'");
        int bookid;
        int amount;
        String[][] content = {};
        while (result.next()) {
            bookid = result.getInt("ProductID");
            amount = result.getInt("Qty");
            result2 = s2.executeQuery("select * from book where id= '" + bookid + "'");
            while (result2.next()) {
                String[][] data = {{String.valueOf(result2.getInt("id")), result2.getString("bookname"),
                    String.valueOf(result2.getString("price")), String.valueOf(amount)}};
                content = append(content, data);
            }
        }
        //--------------------------------------------------------------------------------------------------------
        Document document = new Document(PageSize.A4);
        String pdfURL = "C:\\Users\\USER\\Documents\\NetBeansProjects\\BookStore\\web\\Invoice.pdf";
        PdfWriter.getInstance(document, new FileOutputStream(pdfURL));
        document.open();

        //----------------------------------Head-----------------------------------------------------------------------------
        Paragraph p = new Paragraph();
        Chunk chunk = new Chunk("Book Company ", font_BOLD(12, BaseColor.BLACK));
        p.add(chunk);
        chunk = new Chunk("                                                          "
                + "Invoice ", font_BOLD(20, BaseColor.BLACK));
        p.add(chunk);
        document.add(p);
        p.removeAll(p);
        chunk = new Chunk("1518 ถนนประชาราษฎร์ 1 แขวงวงศ์สว่าง", font(10, BaseColor.BLACK));
        p.add(chunk);
        while (result4.next()){
        chunk = new Chunk("                                                                               "
                + "Date: "+result4.getDate("OnDate"), font_BOLD(10, BaseColor.BLACK));
        p.add(chunk);
        document.add(p);
        }
        p.removeAll(p);
        chunk = new Chunk("เขตบางซื่อ กรุงเทพมหานคร 10800 ", font(10, BaseColor.BLACK));
        p.add(chunk);
        chunk = new Chunk("                                                                                       "
                + "Invoice # "+orderID, font_BOLD(10, BaseColor.BLACK));
        p.add(chunk);
        document.add(p);
        p.removeAll(p);
        document.add(Chunk.NEWLINE);
        document.add(new Paragraph("รหัสลูกค้า : " + String.valueOf(idaccount), font_BOLD(10, BaseColor.BLACK)));
        document.add(new Paragraph("ชื่อและที่อยู่ : ", font_BOLD(10, BaseColor.BLACK)));
        while (result3.next()) {
            document.add(new Paragraph(result3.getString("name") + " " + result3.getString("lastname"), font(10, BaseColor.BLACK)));
            document.add(new Paragraph("บ้านเลขที่ " + result3.getString("AddressNo") + "  ถนน " + result3.getString("Street"), font(10, BaseColor.BLACK)));
            document.add(new Paragraph("ตำบล/แขวง " + result3.getString("Tumbol") + "  อำเภอ/เขต " + result3.getString("Amphor"), font(10, BaseColor.BLACK)));
            document.add(new Paragraph("จังหวัด " + result3.getString("Province") + "  รหัสไปรณีย์ " + result3.getString("Postal"), font(10, BaseColor.BLACK)));
            document.add(new Paragraph("โทรศัพท์ " + result3.getString("Phone"), font(10, BaseColor.BLACK)));
        }
        document.add(Chunk.NEWLINE);
        //-------------------------------------------------------------------------------------------------------------
        float[] columnWidths = {1, 5, 1, 1};
        PdfPTable table = new PdfPTable(columnWidths);
        table.setWidthPercentage(100);
        table.getDefaultCell().setUseAscender(true);
        table.getDefaultCell().setUseDescender(true);
        PdfPCell cell = new PdfPCell(new Phrase("รายการสินค้า", font(10, GrayColor.GRAYWHITE)));
        cell.setBackgroundColor(GrayColor.GRAYBLACK);
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell.setColspan(4);
        table.addCell(cell);
       // for (int i = 0; i <= 1; i++) {
        PdfPCell cell2 = new PdfPCell(new Phrase("รหัสสินค้า", font(10, GrayColor.GRAYBLACK)));
        cell2.setBackgroundColor(GrayColor.LIGHT_GRAY);
        cell2.setHorizontalAlignment(Element.ALIGN_CENTER);
        
            table.addCell(cell2);
            cell2 = new PdfPCell(new Phrase("ชื่อหนังสือ", font(10, GrayColor.GRAYBLACK)));
            cell2.setBackgroundColor(GrayColor.LIGHT_GRAY);
            cell2.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell2);
            cell2 = new PdfPCell(new Phrase("ราคา", font(10, GrayColor.GRAYBLACK)));
            cell2.setBackgroundColor(GrayColor.LIGHT_GRAY);
            cell2.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell2);
            cell2 = new PdfPCell(new Phrase("จำนวน", font(10, GrayColor.GRAYBLACK)));
            cell2.setBackgroundColor(GrayColor.LIGHT_GRAY);
            cell2.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell2);
            
            cell2 = new PdfPCell(new Phrase("", font(10, GrayColor.GRAYBLACK)));
            cell2.setBackgroundColor(GrayColor.LIGHT_GRAY);
            cell2.setHorizontalAlignment(Element.ALIGN_CENTER);       
            table.addCell(cell2);
            cell2 = new PdfPCell(new Phrase("", font(10, GrayColor.GRAYBLACK)));
            cell2.setBackgroundColor(GrayColor.LIGHT_GRAY);
            cell2.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell2);
            cell2 = new PdfPCell(new Phrase("", font(10, GrayColor.GRAYBLACK)));
            cell2.setBackgroundColor(GrayColor.LIGHT_GRAY);
            cell2.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell2);
            cell2 = new PdfPCell(new Phrase("", font(10, GrayColor.GRAYBLACK)));
            cell2.setBackgroundColor(GrayColor.LIGHT_GRAY);
            cell2.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell2);
        //}
        table.setHeaderRows(3);
        table.setFooterRows(1);
        table.getDefaultCell().setBackgroundColor(GrayColor.GRAYWHITE);
        table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
        for (int i = 0; i < content.length;i++) {
            for (int j = 0; j <= 3; j++) {
                //String text = content1[j];
                
                if (j == 2) {
                    table.addCell(new PdfPCell(new Phrase(content[i][j] + " บาท", font(8, BaseColor.BLACK)))).setHorizontalAlignment(Element.ALIGN_CENTER);
                } else if (j == 0 || j == 3) {
                    table.addCell(new PdfPCell(new Phrase(content[i][j], font(8, BaseColor.BLACK)))).setHorizontalAlignment(Element.ALIGN_CENTER);
                } else {
                    table.addCell(new PdfPCell(new Phrase(content[i][j], font(8, BaseColor.BLACK))));
                }
            }
        }
        
//        for (String[] content1 : content) {
//            for (int j = 0; j < content1.length; j++) {
//                String text = content1[j];
//                
//                if (j == 2) {
//                    table.addCell(new PdfPCell(new Phrase(text + " บาท", font(8, BaseColor.BLACK)))).setHorizontalAlignment(Element.ALIGN_CENTER);
//                } else if (j == 0 || j == 3) {
//                    table.addCell(new PdfPCell(new Phrase(text, font(8, BaseColor.BLACK)))).setHorizontalAlignment(Element.ALIGN_CENTER);
//                } else {
//                    table.addCell(new PdfPCell(new Phrase(text, font(8, BaseColor.BLACK))));
//                }
//            }
//        }
        document.add(table);
        document.add(p);
        result4.beforeFirst();
        while (result4.next()) {
            p.setFont(font(10, BaseColor.BLACK));
            p.add("ราคา:         " + result4.getFloat("total") + " บาท");
            p.setAlignment(Element.ALIGN_RIGHT);
            document.add(p);          
        }
        document.close();
    }

    public static String[][] append(String[][] a, String[][] b) {

        String[][] result = new String[a.length + b.length][];
        System.arraycopy(a, 0, result, 0, a.length);
        System.arraycopy(b, 0, result, a.length, b.length);
        return result;

    }
}
