package bookstore.cart;

public class Item implements java.io.Serializable
{
    public String ID;
    public String Bookname;
    public float Price;
    public float Discount;
    public int Amount;
    public Item()
    {
    }

    public Item(String id, String bookname,float price, float discount,int amount)
    {
        ID = id;
        Bookname = bookname;
        Price = price;
        Discount = discount;
        Amount = amount;
    }

    public String getID() { return ID; }
    public void setID(String id) {
        ID = id; }

    public String getBookname() { return Bookname; }
    public void setBookname(String bookname) {
        Bookname = bookname; }

    public float getPrice() { return Price; }
    public void setPrice(float price) { Price = price; }

    public float getDiscount() { return Discount; }
    public void setDiscount(float discount) { Discount = discount; }
    
    public float getAmount() { return Amount; }
    public void setAmount(int amount) { Amount = amount; }
    
}
