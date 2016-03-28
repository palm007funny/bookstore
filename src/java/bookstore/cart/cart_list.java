package bookstore.cart;


public class cart_list implements java.io.Serializable {
     private static int capacity = 1;
     private static int itemCount = 0;
     private static Item[] cart = new Item[capacity];
     public float total;
     int amount;
    public cart_list(){
        
}


    public void addItem(String id,String bookname,float price,float discount,int amount) {
        Item item = new Item(id,bookname,price,discount,amount);
        cart[itemCount] = item;
        itemCount += 1;
         if(itemCount==capacity){
        increaseSize();
        }
         
        
    }
    public String getID(int i){
            return cart[i].ID;
    }
    
    public String getBookname(int i){
            return cart[i].Bookname;
    }
    public float getPrice(int i){
            return (cart[i].Price);
    }
    public float getDiscount(int i){
            return (cart[i].Discount);
    }
    public int getLength(){
        return cart.length;
    }
    public Item[] getItem(){
        return cart;
    }
    public void setItem(Item[] carts){
        cart = carts;
    }
    public int getAmount(String a){
        int i = Integer.valueOf(a);
        return i;
    }
    
//    public Item[] remove(String i) {
//        int del = Integer.parseInt(i);       
//        int g=0;
//      //  System.arraycopy(cart,del+1,cart,del,cart.length-1-del);
//        Item[] cartnew = new Item[cart.length];
//        for(int j=0 ;j<=cart.length-1;j++){
//            if(j != del){
//                cartnew[g] =cart[j];
//            }
//            g++;
//        }
//        cart = cartnew;
//      return cart;
//    }
        public Item[] remove(String i) {
        int del = Integer.parseInt(i);       
        int g=0;
      //  System.arraycopy(cart,del+1,cart,del,cart.length-1-del);
        Item[] cartnew = new Item[cart.length];
        for(int j=0 ;j<=cart.length-1;j++){
            if(j != del){
                cartnew[g] =cart[j];
            }
            g++;
        }
        cart = cartnew;
      return cart;
    }
    public float calPrice(float price,int amount){
        price = price*amount;
        return price;
    }
    
    
 
    private void increaseSize(){
    Item[] item = new Item[capacity+1];
    for(int i=0; i < capacity; i++){
        item[i] = cart[i];
        }
    cart = item; 
    item = null;
    capacity = cart.length;
}

}
    
