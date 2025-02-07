db.createCollection('Books');

db.Books.insertMany([
    {
        'Title': "Book One",
        'Description': "An exciting adventure.",
        'Author': "Author A",
        'Publisher': "Publisher X",
        'URL': "/example.com/book1",
        'no_of_likes': 120
    },
    {
        'Title': "Book Two",
        'Description': "A thrilling mystery.",
        'Author': "Author B",
        'Publisher': "Publisher Y",
        'URL': "/example.com/book2",
        'no_of_likes': 85
    },
    {
        'Title': "Book Three",
        'Description': "A fascinating science fiction.",
        'Author': "Author A",
        'Publisher': "Publisher X",
        'URL': "/example.com/book3",
        'no_of_likes': 150
    },
    {
        'Title': "Book Four",
        'Description': "A captivating romance.",
        'Author': "Author C",
        'Publisher': "Publisher Z",
        'URL': "/example.com/book4",
        'no_of_likes': 95
    },
    {
        'Title': "Book Five",
        'Description': "A compelling drama.",
        'Author': "Author B",
        'Publisher': "Publisher Y",
        'URL': "/example.com/book5",
        'no_of_likes': 100
    }
]);

db.Books.find().pretty();

// Count the number of books for each author
db.Books.aggregate([
    { $group: { _id: "$Author", 'book_count': { $sum: 1 } } }
]);

// Calculate the total likes for each author
db.Books.aggregate([
    { $group: { _id: "$Author", 'total_likes': { $sum: "$no_of_likes" } } }
]);

// Calculate the average likes for each author
db.Books.aggregate([
    { $group: { _id: "$Author", 'average_likes': { $avg: "$no_of_likes" } } }
]);