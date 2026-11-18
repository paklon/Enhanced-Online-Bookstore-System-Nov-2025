package bookstore;

import java.util.ArrayList;

public class ShoppingCart {
    private ArrayList<Book> items;

    public ShoppingCart() {
        items = new ArrayList<>();
    }

    public void addBook(Book book) {
        items.add(book);
    }

    public void removeAll() {
        items.clear();
    }

    public ArrayList<Book> getItems() {
        return items;
    }

    public int getItemCount() {
        return items.size();
    }

    public double getTotalPrice() {
        double total = 0;
        for (Book book : items) total += book.getPrice();
        return total;
    }
}
