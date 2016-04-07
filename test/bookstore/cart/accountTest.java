/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bookstore.cart;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author Palm
 */
public class accountTest {
    
    public accountTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }
    
    @Before
    public void setUp() {
    }
    
    @After
    public void tearDown() {
    }

    /**
     * Test of Login method, of class account.
     */
    @Test
    public void testLogin() throws Exception {
        System.out.println("Login");
        String user = "admin";
        String pass = "1234";
        account instance = new account();
        boolean expResult = true;
        boolean result = instance.Login(user, pass);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
    }

    /**
     * Test of register method, of class account.
     */
    @Test
    public void testRegister() throws Exception {
        System.out.println("register");
        String username = "";
        String password = "";
        String email = "";
        String name = "";
        String lastname = "";
        String Phone = "";
        String AddressNo = "";
        String Street = "";
        String Tumbol = "";
        String Amphor = "";
        String Province = "";
        String Postal = "";
        account instance = new account();
        String expResult = "";
        String result = instance.register(username, password, email, name, lastname, Phone, AddressNo, Street, Tumbol, Amphor, Province, Postal);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
    }

    /**
     * Test of update method, of class account.
     */
    @Test
    public void testUpdate() throws Exception {
        System.out.println("update");
        String name = "";
        String lastname = "";
        String email = "";
        String password = "";
        String Phone = "";
        String AddressNo = "";
        String Street = "";
        String Tumbol = "";
        String Amphor = "";
        String Province = "";
        String Postal = "";
        int idaccount = 0;
        account instance = new account();
        String expResult = "";
        String result = instance.update(name, lastname, email, password, Phone, AddressNo, Street, Tumbol, Amphor, Province, Postal, idaccount);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
    }

    /**
     * Test of getUsername method, of class account.
     */
    @Test
    public void testGetUsername() throws Exception {
        System.out.println("getUsername");
        account instance = new account();
        String expResult = "admin";
        instance.Login("admin", "1234");
        String result = instance.getUsername();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
    }

    /**
     * Test of getLogin method, of class account.
     */
    @Test
    public void testGetLogin() throws Exception {
        System.out.println("getLogin");
        account instance = new account();
        boolean expResult = false;
        boolean result = instance.getLogin();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
    }

    /**
     * Test of Logout method, of class account.
     */
    @Test
    public void testLogout() throws Exception {
        System.out.println("Logout");
        boolean log = false;
        account instance = new account();
        instance.Logout(log);
        // TODO review the generated test code and remove the default call to fail.
    }

    /**
     * Test of checkAdmin method, of class account.
     */
    @Test
    public void testCheckAdmin() throws Exception {
        System.out.println("checkAdmin");
        account instance = new account();
        int expResult = 0;
        int result = instance.checkAdmin();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
    }

    /**
     * Test of getName method, of class account.
     */
    @Test
    public void testGetName() throws Exception {
        System.out.println("getName");
        account instance = new account();
        String expResult = "";
        String result = instance.getName();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
    }

    /**
     * Test of getID method, of class account.
     */
    @Test
    public void testGetID() throws Exception {
        System.out.println("getID");
        account instance = new account();
        int expResult = 0;
        int result = instance.getID();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
    }
    
}
