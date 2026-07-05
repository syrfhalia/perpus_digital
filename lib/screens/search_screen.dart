import 'package:flutter/material.dart';
import '../data/sample_data.dart';
import '../models/book.dart';
import '../theme/app_theme.dart';
import '../widgets/book_list_tile.dart';
import '../widgets/category_chip.dart';
import '../widgets/section_header.dart';
import 'book_detail_screen.dart';

/// "Cari Buku" tab: search field, categories and popular / recommended books.
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _query = '';
  String _selectedCategory = 'Fiksi';

  List<Book> get _filtered {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return const [];
    return SampleData.books.where((b) {
      return b.title.toLowerCase().contains(q) ||
          b.author.toLowerCase().contains(q) ||
          b.category.toLowerCase().contains(q);
    }).toList();
  }

  void _openBook(Book book) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => BookDetailScreen(book: book)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final searching = _query.trim().isNotEmpty;
    return Scaffold(
      appBar: AppBar(title: const Text('Cari Buku')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        children: [
          _searchField(),
          const SizedBox(height: 20),
          if (searching)
            ..._buildSearchResults()
          else
            ..._buildBrowse(),
        ],
      ),
    );
  }

  Widget _searchField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: TextField(
        onChanged: (v) => setState(() => _query = v),
        decoration: const InputDecoration(
          hintText: 'Judul, Penulis, ISBN...',
          hintStyle: TextStyle(color: AppColors.textFaint),
          prefixIcon: Icon(Icons.search, color: AppColors.textFaint),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  List<Widget> _buildSearchResults() {
    final results = _filtered;
    if (results.isEmpty) {
      return [
        const SizedBox(height: 40),
        const Center(
          child: Column(
            children: [
              Icon(Icons.search_off, size: 56, color: AppColors.textFaint),
              SizedBox(height: 12),
              Text(
                'Buku tidak ditemukan',
                style: TextStyle(color: AppColors.textMuted, fontSize: 15),
              ),
            ],
          ),
        ),
      ];
    }
    return [
      SectionHeader(title: 'Hasil Pencarian (${results.length})'),
      const SizedBox(height: 12),
      ...results.map((b) => BookListTile(book: b, onTap: () => _openBook(b))),
    ];
  }

  List<Widget> _buildBrowse() {
    return [
      const SectionHeader(title: 'Kategori Populer'),
      const SizedBox(height: 12),
      Wrap(
        spacing: 10,
        runSpacing: 10,
        children: SampleData.categories.map((c) {
          return CategoryChip(
            label: c,
            selected: c == _selectedCategory,
            onTap: () => setState(() => _selectedCategory = c),
          );
        }).toList(),
      ),
      const SizedBox(height: 24),
      const SectionHeader(title: 'Buku Populer'),
      const SizedBox(height: 12),
      ..._byCategory(SampleData.popular)
          .map((b) => BookListTile(book: b, onTap: () => _openBook(b))),
      const SizedBox(height: 12),
      const SectionHeader(title: 'Rekomendasi Minggu Ini'),
      const SizedBox(height: 12),
      ...SampleData.recommended
          .map((b) => BookListTile(book: b, onTap: () => _openBook(b))),
    ];
  }

  List<Book> _byCategory(List<Book> source) {
    final inCat =
        source.where((b) => b.category == _selectedCategory).toList();
    return inCat.isNotEmpty ? inCat : source;
  }
}
