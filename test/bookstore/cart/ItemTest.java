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
public class ItemTest {
    
    public ItemTest() {
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
     * Test of getID method, of class Item.
     */
    @Test
    public void testGetID() {
        System.out.println("getID");
        String id = "99";
        Item instance = new Item();
        String expResult = "99";
        instance.setID(id);
        String result = instance.getID();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
    }

    /**
     * Test of setID method, of class Item.
     */
    @Test
    public void testSetID() {
        System.out.println("setID");
        String id = "10";
        Item instance = new Item();
        instance.setID(id);
        // TODO review the generated test code and remove the default call to fail.
    }

    /**
     * Test of getBookname method, of class Item.
     */
    @Test
    public void testGetBookname() {
        System.out.println("getBookname");
        Item instance = new Item();
        String expResult = "book";
        instance.setBookname("book");
        String result = instance.getBookname();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
    }

    /**
     * Test of setBookname method, of class Item.
     */
    @Test
    public void testSetBookname() {
        System.out.println("setBookname");
        String bookname = "book";
        Item instance = new Item();
        instance.setBookname(bookname);
        // TODO review the generated test code and remove the default call to fail.
    }

    /**
     * Test of getPrice method, of class Item.
     */
    @Test
    public void testGetPrice() {
        System.out.println("getPrice");
        Item instance = new Item();
        float expResult = 0.0F;
        float result = instance.getPrice();
        assertEquals(expResult, result, 0.0);
        // TODO review the generated test code and remove the default call to fail.
    }

    /**
     * Test of setPrice method, of class Item.
     */
    @Test
    public void testSetPrice() {
        System.out.println("setPrice");
        float price = 0.0F;
        Item instance = new Item();
        instance.setPrice(price);
        // TODO review the generated test code and remove the default call to fail.
    }

    /**
     * Test of getDiscount method, of class Item.
     */
    @Test
    public void testGetDiscount() {
        System.out.println("getDiscount");
        Item instance = new Item();
        float expResult = 0.0F;
        float result = instance.getDiscount();
        assertEquals(expResult, result, 0.0);
        // TODO review the generated test code and remove the default call to fail.
    }

    /**
     * Test of setDiscount method, of class Item.
     */
    @Test
    public void testSetDiscount() {
        System.out.println("setDiscount");
        float discount = 0.0F;
        Item instance = new Item();
        instance.setDiscount(discount);
        // TODO review the generated test code and remove the default call to fail.
    }

    /**
     * Test of getAmount method, of class Item.
     */
    @Test
    public void testGetAmount() {
        System.out.println("getAmount");
        Item instance = new Item();
        float expResult = 0.0F;
        float result = instance.getAmount();
        assertEquals(expResult, result, 0.0);
        // TODO review the generated test code and remove the default call to fail.
    }

    /**
     * Test of setAmount method, of class Item.
     */
    @Test
    public void testSetAmount() {
        System.out.println("setAmount");
        int amount = 0;
        Item instance = new Item();
        instance.setAmount(amount);
        // TODO review the generated test code and remove the default call to fail.
    }
    
}
