package bookstore.cart;

import java.util.*;

public class Cart {
    protected Vector this_cart = new Vector();
    public void addItem(String id,String bookname,float price,float discount,int amount) { 

        if (amount<=0){
           removeItem(id);
        }else
        if (!updateItem(id, amount)){
        this_cart.addElement(new Item(id,bookname,price,discount,amount));
        }
    }
 
    public void removeItem(String id) { 
       Item item;
       for (int i=0;i<this_cart.size();i++) { 
           item = (Item)this_cart.elementAt(i);
           if (item.ID.equals(id)) {
           this_cart.removeElementAt(i);
           }
       }
    }
    
    public boolean updateItem(String id, int amount) {
       Item item;
       for (int i=0;i<this_cart.size();i++) { 
       item = (Item)this_cart.elementAt(i);
       if (item.ID == id) {
       item.Amount= amount;
       return true;
       }
    }
    return false;
   }
    public Vector getCart() {
       return this_cart;
    }
    
    public void removeAllItem() {    
        this_cart.removeAll(this_cart);
   }
}



 