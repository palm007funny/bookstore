/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bookstore.cart;

import static java.lang.System.out;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author Palm
 */
public class editBookTest {

    Connection connect = null;
    Statement s = null;

    public String Add(String bookname, String detail, String picture, String price, String discount,
            String booksize, String bookweight, String company, String date, String Stock, String category) {
        try {
            float price1 = Float.valueOf(price);
            float discount1 = Float.valueOf(discount);
            Class.forName("com.mysql.jdbc.Driver");
            connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore" + "?characterEncoding=UTF-8", "root", "");
            s = connect.createStatement();

            String book = "INSERT INTO book_test "
                    + "(bookname,detail,picture,price,discount,booksize,bookweight,company,date,Stock,category) "
                    + "VALUES ('" + bookname + "' "
                    + ",'" + detail + "','" + picture + "'"
                    + ",'" + price1 + "','" + discount1 + "','" + booksize
                    + "','" + bookweight + "','" + company + "','" + date
                    + "','" + Stock + "','" + category + "') ";

            s.execute(book);
            return "เพิ่มหนังสือ สำเร็จ";

        } catch (Exception e) {
            // TODO Auto-generated catch block
            out.println(e.getMessage());
            e.printStackTrace();
        }

        try {
            if (s != null) {
                s.close();
                connect.close();
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            out.println(e.getMessage());
        }
        return "";
    }

    public String Del(String bookid) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore" + "?characterEncoding=UTF-8", "root", "");
            s = connect.createStatement();
            if (!bookid.equals("") || !bookid.equals(null)) {
                String sql = "DELETE FROM book_test "
                        + " WHERE id = '" + bookid + "' ";

                s.execute(sql);

                return ("ลบออกสำเร็จ");
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            out.println(e.getMessage());
            e.printStackTrace();
        }

        try {
            if (s != null) {
                s.close();
                connect.close();
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            out.println(e.getMessage());
            e.printStackTrace();
        }
        return "";
    }

    @Test
    public void testAdd() throws SQLException {
        System.out.println("Add");
        String bookname = "book";
        String detail = "detail";
        String picture = "pic";
        String price = "100";
        String discount = "10";
        String booksize = "20*20*20";
        String bookweight = "100";
        String company = "palm";
        String date = "3/4/2558";
        String Stock = "1";
        String category = "000";
        String expResult = "เพิ่มหนังสือ สำเร็จ";
        String result = Add(bookname, detail, picture, price, discount, booksize, bookweight, company, date, Stock, category);
        assertEquals(expResult, result);
        connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore" + "?characterEncoding=UTF-8", "root", "");
        Statement st = connect.createStatement();
        ResultSet rs = st.executeQuery("select * from book_test where bookname='" + bookname + "'");
        if (rs.next()) {
            if (!rs.getString("bookname").equals(bookname)) {
                fail("bookname not match");
            }
            if (!rs.getString("detail").equals(detail)) {
                fail("detail not match");
            }
            if (!rs.getString("picture").equals(picture)) {
                fail("picture not match");
            }
            if (!rs.getString("price").equals(price)) {
                fail("price not match");
            }
            if (!rs.getString("discount").equals(discount)) {
                fail("discount not match");
            }
            if (!rs.getString("booksize").equals(booksize)) {
                fail("booksize not match");
            }
            if (!rs.getString("bookweight").equals(bookweight)) {
                fail("bookweight not match");
            }
            if (!rs.getString("company").equals(company)) {
                fail("company not match");
            }
            if (!rs.getString("date").equals(date)) {
                fail("date not match");
            }
            if (!rs.getString("Stock").equals(Stock)) {
                fail("Stock not match");
            }
            if (!rs.getString("category").equals(category)) {
                fail("catetory not match");
            }
        }
        st = connect.createStatement();
        String sql = "DELETE FROM book_test";

        st.execute(sql);

    }

    /**
     * Test of Del method, of class editBook.
     */
    @Test
    public void testDel() throws SQLException {
        String bookname = "book";
        String detail = "detail";
        String picture = "pic";
        String price = "100";
        String discount = "10";
        String booksize = "20*20*20";
        String bookweight = "100";
        String company = "palm";
        String date = "3/4/2558";
        String Stock = "1";
        String category = "000";
        String bookid = "";
        Add(bookname, detail, picture, price, discount, booksize, bookweight, company, date, Stock, category);
        connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore" + "?characterEncoding=UTF-8", "root", "");
        Statement st = connect.createStatement();
        ResultSet rs = st.executeQuery("select * from book_test where bookname='" + bookname + "'");
        if (rs.next()) {
            bookid = rs.getString("id");
        }
        System.out.println("Del");

        String expResult = "ลบออกสำเร็จ";
        String result = Del(bookid);
        assertEquals(expResult, result);
    }

}
