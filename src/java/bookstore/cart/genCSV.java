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
import java.io.FileWriter;
import java.io.IOException;

public class genCSV {

    FileWriter writer;

    public void startGen(String sFileName) throws IOException {
        writer = new FileWriter(sFileName);
        writer.append("type");
        writer.append(',');
        writer.append("amount");
        writer.append('\n');
    }

    public void generateCsvFile(String name, int data) throws IOException {

        writer.append(name);
        writer.append(',');
        writer.append(String.valueOf(data));
        writer.append('\n');
        //generate whatever data you want       
    }
    public void endGen() throws IOException{
        writer.flush();
        writer.close();
    }
}
