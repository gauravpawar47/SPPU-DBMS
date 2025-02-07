db.createCollection('Books');
db.Books.insertMany([
  { 'Title': "Book One",
    'Description': "An exciting adventure.",
    'Author': "Author A",
    'Publisher': "Publisher X",
    'URL': "http://example.com/book1",
    'no_of_likes': 120
  },
  {
    'Title': "Book Two",
    'Description': "A thrilling mystery.",
    'Author': "Author B",
    'Publisher': "Publisher Y",
    'URL': "http://example.com/book2",
    'no_of_likes': 85
  },
  {
    'Title': "Book Three",
    'Description': "A fascinating science fiction.",
    'Author': "Author A",
    'Publisher': "Publisher X",
    'URL': "http://example.com/book3",
    'no_of_likes': 150
  },
  {
    'Title': "Book Four",
    'Description': "A captivating romance.",
    'Author': "Author C",
    'Publisher': "Publisher Z",
    'URL': "http://example.com/book4",
    'no_of_likes': 95
  },
  {
    'Title': "Book Five",
    'Description': "A compelling drama.",
    'Author': "Author B",
    'Publisher': "Publisher Y",
    'URL': "http://example.com/book5",
    'no_of_likes': 100
  }
]);

db.Books.find().pretty();

// Aggregate to count books per publisher
db.Books.aggregate([
  { $group: { _id: "$Publisher", 'book_count': { $sum: 1 } } }
]);

// Aggregate to find the minimum likes per author
db.Books.aggregate([
  { $group: { _id: "$Author", 'min_likes': { $min: "$no_of_likes" } } }
]);

// Aggregate to find the maximum likes per author
db.Books.aggregate([
  { $group: { _id: "$Author", 'max_likes': { $max: "$no_of_likes" } } }
]);