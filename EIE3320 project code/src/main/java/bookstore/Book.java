package bookstore;

public class Book {
    private String isbn;
    private String author;
    private String title;
    private double price;
    private int editionNumber;
    private String publisher;
    private String copyright;
    private int availability;  

    public Book(String isbn, String author, String title, double price, int editionNumber, String publisher, String copyright, int availability) {
        this.isbn = isbn;
        this.author = author;
        this.title = title;
        this.price = price;
        this.editionNumber = editionNumber;
        this.publisher = publisher;
        this.copyright = copyright;
        this.availability = availability;
    }

    public String getIsbn() { return isbn; }
    public String getAuthor() { return author; }
    public String getTitle() { return title; }
    public double getPrice() { return price; }
    public int getEditionNumber() { return editionNumber; }
    public String getPublisher() { return publisher; }
    public String getCopyright() { return copyright; }
    public int getAvailability() { return availability; } 
}
