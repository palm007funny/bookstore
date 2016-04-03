/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bookstore.cart;

import java.util.Vector;
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
public class CartTest {
    
    public CartTest() {
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
     * Test of addItem method, of class Cart.
     */
    @Test
    public void testAddItem() {
        System.out.println("addItem");
        String id = "15";
        String bookname = "test";
        float price = 150;
        float discount = 12;
        int amount = 1;
        Cart instance = new Cart();
        instance.addItem(id, bookname, price, discount, amount);
        // TODO review the generated test code and remove the default call to fail.
        //fail("The test case is a prototype.");
    }

    /**
     * Test of removeItem method, of class Cart.
     */
    @Test
    public void testRemoveItem() {
        System.out.println("removeItem");
        String id = "";
        Cart instance = new Cart();
        instance.removeItem(id);
        // TODO review the generated test code and remove the default call to fail.
        //fail("The test case is a prototype.");
    }

    /**
     * Test of updateItem method, of class Cart.
     */
    @Test
    public void testUpdateItem() {
        System.out.println("updateItem");
        String id = "";
        int amount = 0;
        Cart instance = new Cart();
        boolean expResult = false;
        boolean result = instance.updateItem(id, amount);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        //fail("The test case is a prototype.");
    }

    /**
     * Test of getCart method, of class Cart.
     */
    @Test
    public void testGetCart() {
        System.out.println("getCart");
        Cart instance = new Cart();
        Vector expResult = instance.this_cart;
        Vector result = instance.getCart();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        //fail("The test case is a prototype.");
    }

    /**
     * Test of removeAllItem method, of class Cart.
     */
    @Test
    public void testRemoveAllItem() {
        System.out.println("removeAllItem");
        Cart instance = new Cart();
        instance.removeAllItem();
        // TODO review the generated test code and remove the default call to fail.
        //fail("The test case is a prototype.");
    }
    
}
