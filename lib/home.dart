import 'package:flutter/material.dart';
import 'package:assignment/movieCard.dart';

class MovieSearchScreen extends StatefulWidget {
  @override
  _MovieSearchScreenState createState() => _MovieSearchScreenState();
}

class _MovieSearchScreenState extends State<MovieSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> _allMovies = [
    {
      'title': 'The Maze Runner',
      'subtitle': 'Action | Thriller | Sci-fi | Mystery',
      'imageUrl': 'assets/img1.jpg',
      'rating': 7.5,
    },
    {
      'title': 'Rampage',
      'subtitle': 'Action | Future | Science',
      'imageUrl': 'assets/img2.jpg',
      'rating': 6.5,
    },
    {
      'title': 'Jurassic World',
      'subtitle': 'Fun | Fantacy | Science',
      'imageUrl': 'assets/img3.jpg',
      'rating': 8.6,
    },
  ];

  List<Map<String, dynamic>> _filteredMovies = [];

  @override
  void initState() {
    super.initState();
    _filteredMovies = _allMovies;
    _searchController.addListener(_filterMovies);
  }

  void _filterMovies() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredMovies = _allMovies
          .where((movie) => movie['title'].toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 50, bottom: 20),
              child: Row(
                children: [
                  Text(
                    'Home',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: const TextStyle(fontFamily: 'Montserrat'),
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _filteredMovies.isEmpty
                  ? const Center(
                      child: Text('No movies found.',
                          style: TextStyle(
                              fontSize: 18, fontFamily: 'Montserrat')),
                    )
                  : ListView.builder(
                      itemCount: _filteredMovies.length,
                      itemBuilder: (context, index) {
                        final movie = _filteredMovies[index];
                        return MovieCard(movie: movie);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
