/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bookstore.cart;

import static java.lang.System.out;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class editBook {

    Connection connect = null;
    Statement s = null;

    public String Add(String bookname, String detail, String picture, String price, String discount,
            String booksize, String bookweight, String company, String date,String Stock) {
        try {
            float price1 = Float.valueOf(price);
            float discount1 = Float.valueOf(discount);
            Class.forName("com.mysql.jdbc.Driver");
            connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore" + "?characterEncoding=UTF-8", "root", "");
            s = connect.createStatement();

            String book = "INSERT INTO book "
                    + "(bookname,detail,picture,price,discount,booksize,bookweight,company,date,Stock) "
                    + "VALUES ('" + bookname + "' "
                    + ",'" + detail + "','" + picture + "'"
                    + ",'" + price1 + "','" + discount1 + "','" + booksize
                    + "','" + bookweight + "','" + company + "','" + date + "','" + Stock + "') ";

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

            String sql = "DELETE FROM book "
                    + " WHERE id = '" + bookid + "' ";

            s.execute(sql);

            out.println("ลบออกสำเร็จ");

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
}
