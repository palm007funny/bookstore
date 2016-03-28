package bookstore.cart;

import java.awt.Color;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import org.apache.pdfbox.encoding.PdfDocEncoding;
import org.apache.pdfbox.exceptions.COSVisitorException;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.edit.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDFont;
import org.apache.pdfbox.pdmodel.font.PDTrueTypeFont;
import org.apache.pdfbox.pdmodel.font.PDType1Font;

public class CreatePDF {

    Connection connect = null;

    public CreatePDF() {
    }

    public static void drawTable(PDPage pdf, PDPageContentStream contentStream,
            float y, float margin, String[][] content, Color color) throws IOException {
        final int rows = content.length;
        final int cols = content[0].length;
        final float rowHeight = 20f;
        final float tableWidth = pdf.findMediaBox().getWidth() - (2 * margin);
        final float tableHeight = rowHeight * rows;
        final float colWidth = tableWidth / (float) cols;
        final float cellMargin = 5f;

        float nexty = y;
        for (int i = 0; i <= rows; i++) {
            contentStream.drawLine(margin, nexty, margin + tableWidth, nexty);
            nexty -= rowHeight;
        }

        //draw the columns
        float nextx = margin;
        for (int i = 0; i <= cols; i++) {
            contentStream.drawLine(nextx, y, nextx, y - tableHeight);
            nextx += colWidth;
        }

        //now add the text
        contentStream.setFont(PDType1Font.HELVETICA_BOLD, 12);

        float textx = margin + cellMargin;
        float texty = y - 15;
        for (int i = 0; i < content.length; i++) {
            for (int j = 0; j < content[i].length; j++) {
                String text = content[i][j];
                contentStream.beginText();
                contentStream.setNonStrokingColor(color);
                contentStream.moveTextPositionByAmount(textx, texty);

                contentStream.drawString(text);
                contentStream.endText();
                textx += colWidth;
            }
            texty -= rowHeight;
            textx = margin + cellMargin;
        }
    }

    public void drawtext(PDPage pdf, PDPageContentStream contentStream,
            float x, float y, String text, PDFont font, int size, Color color) throws IOException {
        contentStream.setFont(font, size);
        contentStream.setNonStrokingColor(color);
        contentStream.beginText();
        contentStream.moveTextPositionByAmount(x, y);
        contentStream.drawString(text);
        contentStream.endText();
    }

    public void create(int orderID) throws ClassNotFoundException, SQLException, IOException, COSVisitorException {
        Class.forName("com.mysql.jdbc.Driver");
        connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore" + "?characterEncoding=UTF-8", "root", "");
        Statement s = connect.createStatement();
        Statement s2 = connect.createStatement();
        Dbconnect db = new Dbconnect();
        ResultSet result = s.executeQuery("select * from orderdetails where OrderID= '" + orderID + "'");
        ResultSet result2;
        int bookid = 0;
        int amount = 0;
        String[][] content = {
            {"ProductID", "BookName", "Price", "Qty"}
        };
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
        CreatePDF f = new CreatePDF();
        PDDocument doc = new PDDocument();
        PDPage pdf = new PDPage();
        pdf.setMediaBox(PDPage.PAGE_SIZE_A4);
        doc.addPage(pdf);
       // PDFont font = PDType1Font.HELVETICA_BOLD;
         PDFont font = PDTrueTypeFont.loadTTF( doc, new File("C:\\Windows\\Fonts\\verdana.ttf"));   
           font.setFontEncoding(new PdfDocEncoding()); 
        PDPageContentStream contentStream = new PDPageContentStream(doc, pdf);
        while ((result != null) && (result.next())) {
            String[][] data = {
                {"Name", " Time ", "5"},
                {"HTC", "01:25"},
                {"Samsung Tab2", "05:30"}
            };
        }
        String oldString = "avกข12-@";
        String newString = new String(oldString.getBytes("UTF-8"), "UTF-8");
        drawtext(pdf, contentStream, 50, 750, "BookStore", PDType1Font.HELVETICA_BOLD, 12, Color.BLACK);
        drawtext(pdf, contentStream, 500, 750, "INVOICE", PDType1Font.HELVETICA_BOLD, 15, Color.BLUE);
        drawtext(pdf, contentStream, 500, 700, newString, font, 15, Color.BLUE);
        drawTable(pdf, contentStream, 700, 100, content, Color.BLACK);
        contentStream.close();
        doc.save("test.pdf" );
        doc.save("D:\\work\\myPDF.pdf");
        doc.close();
    }

    public static String[][] append(String[][] a, String[][] b) {

        String[][] result = new String[a.length + b.length][];
        System.arraycopy(a, 0, result, 0, a.length);
        System.arraycopy(b, 0, result, a.length, b.length);
        return result;

    }
}
