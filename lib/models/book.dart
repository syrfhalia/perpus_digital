/// A single library book.
class Book {
  final String id;
  final String title;
  final String author;
  final String coverAsset;
  final String category;
  final double rating;
  final int year;
  final int pages;
  final String publisher;
  final String synopsis;
  final bool available;

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.coverAsset,
    required this.category,
    this.rating = 4.5,
    this.year = 2020,
    this.pages = 300,
    this.publisher = 'Gramedia',
    this.synopsis = '',
    this.available = true,
  });
}
