package bookstore.cart;

import static java.lang.System.out;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Dbconnect {
    
    Connection connect = null;

        public Connection getConnection() {
            return connect;
        }

	public String doConnection() {
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
                        connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore"+"?characterEncoding=UTF-8","root","");
			if(connect != null){
				return "Database Connected.";
			} 			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			 e.printStackTrace();
		}
		
		// Close
		
                return "Database Connect Failed.";
	}
       public String endConnection() {
           try {
			if(connect != null){
				connect.close();
                                return "Connection close";
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
           return null;
       }
	
}


