/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bookstore.cart;

/**
 *
 * @author Palm
 */
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

public class genCSV {

BufferedWriter bw;
    public void startGen(String sFileName) throws IOException {
        bw = new BufferedWriter(new FileWriter(sFileName));
        bw.write("date");
        bw.write('\t');
        bw.write("close");
        bw.write('\n');
    }

    public void generateCsvFile(String name, float data) throws IOException {
        
        bw.write(name);
        bw.write('\t');
        bw.write(String.valueOf(data));
        bw.write('\n');
        //generate whatever data you want       
    }
    public void endGen() throws IOException{
        bw.close();
    }
}
