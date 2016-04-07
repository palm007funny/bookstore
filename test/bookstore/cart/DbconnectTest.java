/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bookstore.cart;

import java.sql.Connection;
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
public class DbconnectTest {
    
    public DbconnectTest() {
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
     * Test of getConnection method, of class Dbconnect.
     */
    @Test
    public void testGetConnection() {
        System.out.println("getConnection");
        Dbconnect instance = new Dbconnect();
        Connection expResult = null;
        Connection result = instance.getConnection();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
    }

    /**
     * Test of doConnection method, of class Dbconnect.
     */
    @Test
    public void testDoConnection() {
        System.out.println("doConnection");
        Dbconnect instance = new Dbconnect();
        String expResult = "Database Connected.";
        String result = instance.doConnection();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
    }

    /**
     * Test of endConnection method, of class Dbconnect.
     */
    @Test
    public void testEndConnection() {
        System.out.println("endConnection");
        Dbconnect instance = new Dbconnect();
        String expResult = "Connection close";
        String result = instance.doConnection();
               result = instance.endConnection();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
    }
    
}
