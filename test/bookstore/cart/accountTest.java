/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bookstore.cart;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import org.junit.Test;
import static org.junit.Assert.*;

public class accountTest {

    public String username, password;
    Connection connect = null;

    public boolean Login(String user, String pass) throws ClassNotFoundException, SQLException {

        username = user;
        password = pass;
        Class.forName("com.mysql.jdbc.Driver");
        connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore" + "?characterEncoding=UTF-8", "root", "");
        Statement st = connect.createStatement();
        ResultSet rs;
        rs = st.executeQuery("select * from account_test where username='" + username + "' and password='" + password + "'");
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
            String account = "INSERT INTO account_test "
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
            String account = "UPDATE account_test "
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
        rs = st.executeQuery("select * from account_test where username='" + username + "'");
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
        rs = st.executeQuery("select * from account_test where username='" + username + "'");
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
        rs = st.executeQuery("select * from account_test where username='" + username + "'");
        if (rs.next()) {
            id = rs.getInt("idaccount");
        }
        return id;
    }

    /**
     * Test of register method, of class account.
     */
    @Test
    public void testRegister() throws Exception {
        String username_test = "admin";
        String password_test = "1234";
        String email = "mail";
        String name = "thanawat";
        String lastname = "inkeaw";
        String Phone = "0918589993";
        String AddressNo = "address";
        String Street = "street";
        String Tumbol = "tumbol";
        String Amphor = "amphor";
        String Province = "province";
        String Postal = "postal";
        String expResult = "สมัครสมาชิก สำเร็จ";
        String result = register(username_test, password_test, email, name, lastname, Phone, AddressNo, Street, Tumbol, Amphor, Province, Postal);
        assertEquals(expResult, result);
        Class.forName("com.mysql.jdbc.Driver");
        connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore" + "?characterEncoding=UTF-8", "root", "");
        Statement st = connect.createStatement();
        ResultSet rs = st.executeQuery("select * from account_test where username='" + username_test + "'");      
        if (rs.next()) {
                if (!rs.getString("username").equals(username_test)) {
                    fail("username not match");
                }
                if (!rs.getString("email").equals(email)) {
                    fail("email not match");
                }
                if (!rs.getString("name").equals(name)) {
                    fail("name not match");
                }
                if (!rs.getString("lastname").equals(lastname)) {
                    fail("lastname not match");
                }
                if (!rs.getString("Phone").equals(Phone)) {
                    fail("Phone not match");
                }
                if (!rs.getString("Street").equals(Street)) {
                    fail("Street not match");
                }
                if (!rs.getString("Tumbol").equals(Tumbol)) {
                    fail("Tumbol not match");
                }
                if (!rs.getString("Amphor").equals(Amphor)) {
                    fail("Amphor not match");
                }
                if (!rs.getString("Province").equals(Province)) {
                    fail("Province not match");
                }
                if (!rs.getString("Postal").equals(Postal)) {
                    fail("Postal not match");
                }
            }
    }

    @Test
    public void testLogin() throws Exception {
        System.out.println("Login");
        String username_test = "admin";
        String password_test = "1234";
        String email = "mail";
        String name = "thanawat";
        String lastname = "inkeaw";
        String Phone = "0918589993";
        String AddressNo = "address";
        String Street = "street";
        String Tumbol = "tumbol";
        String Amphor = "amphor";
        String Province = "province";
        String Postal = "postal";
        register(username_test, password_test, email, name, lastname, Phone, AddressNo, Street, Tumbol, Amphor, Province, Postal);
   
        String user = "admin";
        String pass = "1234";
        boolean expResult = true;
        boolean result = Login(user, pass);
        assertEquals(expResult, result);
    }

    @Test
    public void testUpdate() throws Exception {
        System.out.println("update");
        Login("admin", "1234");
        String name = "palm";
        String lastname = "last";
        String email = "mail";
        String password_test = "1234";
        String Phone = "number";
        String AddressNo = "no";
        String Street = "st";
        String Tumbol = "tb";
        String Amphor = "ap";
        String Province = "pv";
        String Postal = "pt";
        int idaccount = getID();
        String expResult = "แก้ไขข้อมูล สำเร็จ";
        String result = update(name, lastname, email, password_test, Phone, AddressNo, Street, Tumbol, Amphor, Province, Postal, idaccount);
        System.out.println(getID());
        assertEquals(expResult, result);
        Class.forName("com.mysql.jdbc.Driver");
        connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore" + "?characterEncoding=UTF-8", "root", "");
        Statement st = connect.createStatement();
        ResultSet rs = st.executeQuery("select * from account_test where idaccount='" + idaccount + "'");      
        if (rs.next()) {
                if (!rs.getString("email").equals(email)) {
                    fail("email not match");
                }
                if (!rs.getString("name").equals(name)) {
                    fail("name not match");
                }
                if (!rs.getString("lastname").equals(lastname)) {
                    fail("lastname not match");
                }
                if (!rs.getString("Phone").equals(Phone)) {
                    fail("Phone not match");
                }
                if (!rs.getString("Street").equals(Street)) {
                    fail("Street not match");
                }
                if (!rs.getString("Tumbol").equals(Tumbol)) {
                    fail("Tumbol not match");
                }
                if (!rs.getString("Amphor").equals(Amphor)) {
                    fail("Amphor not match");
                }
                if (!rs.getString("Province").equals(Province)) {
                    fail("Province not match");
                }
                if (!rs.getString("Postal").equals(Postal)) {
                    fail("Postal not match");
                }
            }
            st = connect.createStatement();
            String sql = "DELETE FROM account_test";

            st.execute(sql);
        
    }

    @Test
    public void testGetUsername() throws Exception {
        System.out.println("getUsername");;
        String expResult = "admin";
        Login("admin", "1234");
        String result = getUsername();
        assertEquals(expResult, result);

    }

    /**
     * Test of getLogin method, of class account.
     */
    @Test
    public void testGetLogin() throws Exception {
        System.out.println("getLogin");
        boolean expResult = false;
        boolean result = getLogin();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
    }

    /**
     * Test of checkAdmin method, of class account.
     */
    @Test
    public void testCheckAdmin() throws Exception {
        System.out.println("checkAdmin");
        int expResult = 0;
        int result = checkAdmin();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
    }

    /**
     * Test of getName method, of class account.
     */
    @Test
    public void testGetName() throws Exception {
        System.out.println("getName");
        String expResult = "";
        String result = getName();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
    }

    /**
     * Test of getID method, of class account.
     */
    @Test
    public void testGetID() throws Exception {
        System.out.println("getID");
        int expResult = 0;
        int result = getID();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
    }

    @Test
    public void testLogout() throws Exception {
        System.out.println("Logout");
        Login("admin","1234");
        boolean log = true;
        Logout(true);
        assertEquals(username, null);
    }
}
