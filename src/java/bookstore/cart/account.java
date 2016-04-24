package bookstore.cart;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class account {

    public String username, password;
    Connection connect = null;

    public boolean Login(String user, String pass) throws ClassNotFoundException, SQLException {

        username = user;
        password = pass;
        Class.forName("com.mysql.jdbc.Driver");
        connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore" + "?characterEncoding=UTF-8", "root", "");
        Statement st = connect.createStatement();
        ResultSet rs;
        rs = st.executeQuery("select * from account where username='" + username + "' and password='" + password + "'");
        if (rs.next()) {
            if (rs.getString("username").equals(username)) {
                return true;
            }
        }
        return false;
    }

    public String register(String username, String password, String email, String name, String lastname,
            String Phone, String AddressNo, String Street, String Tumbol,
            String Amphor, String Province, String Postal) throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.jdbc.Driver");
        connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore" + "?characterEncoding=UTF-8", "root", "");
        Statement s = connect.createStatement();
        if ((username != "") && (password != "") && (email != "") && (name != "") && (lastname != "")) {
            String account = "INSERT INTO account "
                    + "(username,password,email,name,lastname,admin,Phone,AddressNo,Street,Tumbol,Amphor,Province,Postal) "
                    + "VALUES ('" + username + "' "
                    + ",'" + password + "','" + email + "'"
                    + ",'" + name + "','" + lastname + "','" + 0 + "'"
                    + ",'" + Phone + "','" + AddressNo + "','" + Street + "'"
                    + ",'" + Tumbol + "','" + Amphor + "','" + Province + "'"
                    + ",'" + Postal + "') ";
            s.execute(account);
            return ("สมัครสมาชิก สำเร็จ");
        }
        return ("กรุณากรอกข้อมูลให้ครบ");

    }

    public String update(String name, String lastname, String email, String password,
            String Phone, String AddressNo, String Street, String Tumbol,
            String Amphor, String Province, String Postal, int idaccount) throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.jdbc.Driver");
        connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore" + "?characterEncoding=UTF-8", "root", "");
        Statement s = connect.createStatement();
        if ((password != "") && (email != "") && (name != "") && (lastname != "") && (idaccount != 0)) {
            String account = "UPDATE account "
                    + "SET name = '" + name + "' "
                    + ", lastname = '" + lastname + "' "
                    + ", email = '" + email + "' "
                    + ", Phone = '" + Phone + "' "
                    + ", AddressNo = '" + AddressNo + "' "
                    + ", Street = '" + Street + "' "
                    + ", Tumbol = '" + Tumbol + "' "
                    + ", Amphor = '" + Amphor + "' "
                    + ", Province = '" + Province + "' "
                    + ", Postal = '" + Postal + "' "
                    + " WHERE idaccount = '" + idaccount + "' ";
            s.execute(account);
            return ("แก้ไขข้อมูล สำเร็จ");
        }
        return ("กรุณากรอกข้อมูลให้ครบ");
    }

    public String getUsername() throws ClassNotFoundException, SQLException {
        if (Login(username, password) == true) {
            return username;
        }
        return "Invalid password <a href='index.jsp'>try again</a>";
    }

    public boolean getLogin() throws ClassNotFoundException, SQLException {
        if (Login(username, password) == true) {
            return true;
        }
        return false;
    }

    public void Logout(boolean log) throws ClassNotFoundException, SQLException {
        if (log == true) {
            username = null;
            password = null;
            Login(username, password);
            log = false;
        }
    }

    public int checkAdmin() throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.jdbc.Driver");
        connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore" + "?characterEncoding=UTF-8", "root", "");
        Statement st = connect.createStatement();
        ResultSet rs;
        int result = 0;
        rs = st.executeQuery("select * from account where username='" + username + "'");
        if (rs.next()) {
            result = rs.getInt("admin");
        }
        return result;
    }

    public String getName() throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.jdbc.Driver");
        connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore" + "?characterEncoding=UTF-8", "root", "");
        Statement st = connect.createStatement();
        ResultSet rs;
        String result = "";
        rs = st.executeQuery("select * from account where username='" + username + "'");
        if (rs.next()) {
            result = rs.getString("name");
        }
        return result;
    }

    public int getID() throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.jdbc.Driver");
        connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore" + "?characterEncoding=UTF-8", "root", "");
        Statement st = connect.createStatement();
        ResultSet rs;
        int id = 0;
        rs = st.executeQuery("select * from account where username='" + username + "'");
        if (rs.next()) {
            id = rs.getInt("idaccount");
        }
        return id;
    }
}
