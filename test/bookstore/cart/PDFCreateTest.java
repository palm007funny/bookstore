/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bookstore.cart;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.pdf.BaseFont;
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
public class PDFCreateTest {
    
    public PDFCreateTest() {
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
     * Test of font method, of class PDFCreate.
     */
    @Test
    public void testFont() {
        System.out.println("font");
        int size = 15;
        BaseColor color = BaseColor.BLACK;
        if (size <= 0){
            fail("size wrong");
        }
        if (color == null){
            fail("color wrong");
        }
        PDFCreate instance = new PDFCreate();
        Font result = instance.font(size, color);
        // TODO review the generated test code and remove the default call to fail.
    }

    /**
     * Test of font_BOLD method, of class PDFCreate.
     */
    @Test
    public void testFont_BOLD() {
        System.out.println("font_BOLD");
        int size = 15;
        BaseColor color = BaseColor.BLACK;
        if (size <= 0){
            fail("size wrong");
        }
        if (color == null){
            fail("color wrong");
        }
        PDFCreate instance = new PDFCreate();
        Font result = instance.font_BOLD(size, color);       
        //assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.      
    }

    /**
     * Test of createPdf method, of class PDFCreate.
     */
    @Test
    public void testCreatePdf() throws Exception {
        System.out.println("createPdf");
        int orderID = 0;
        int idaccount = 0;
        PDFCreate instance = new PDFCreate();
        instance.createPdf(orderID, idaccount);
        // TODO review the generated test code and remove the default call to fail.
    }

    /**
     * Test of append method, of class PDFCreate.
     */
    @Test
    public void testAppend() {
        System.out.println("append");
        String[][] a = {};
        String[][] b = {{"A","B","C"},{"1","2","3"}};
        String[][] expResult = {{"A","B","C"},{"1","2","3"}};
        String[][] result = PDFCreate.append(a, b);
        assertArrayEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
    }
    
}
