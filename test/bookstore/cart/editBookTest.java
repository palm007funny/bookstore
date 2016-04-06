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
public class editBookTest {
    
    public editBookTest() {
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
     * Test of Add method, of class editBook.
     */
    @Test
    public void testAdd() {
        System.out.println("Add");
        String bookname = "book";
        String detail = "detail";
        String picture = "pic";
        String price = "100";
        String discount = "10";
        String booksize = "55";
        String bookweight = "55";
        String company = "palm";
        String date = "3/4/2558";
        String Stock = "1";
        editBook instance = new editBook();
        String expResult = "เพิ่มหนังสือ สำเร็จ";
        String result = instance.Add(bookname, detail, picture, price, discount, booksize, bookweight, company, date, Stock);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        //fail("The test case is a prototype.");
    }

    /**
     * Test of Del method, of class editBook.
     */
    @Test
    public void testDel() {
        System.out.println("Del");
        String bookid = "1";
        editBook instance = new editBook();
        String expResult = "";
        String result = instance.Del(bookid);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        //fail("The test case is a prototype.");
    }
    
}
