import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/movie.dart';
import '../blocs/movies_bloc.dart';
import '../widgets/movie_list_item.dart';


class MovieListPage extends StatefulWidget {
  const MovieListPage({super.key});

  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  List<Movie> listMovies = [];
  String _searchQuery = '';
  String _selectedRating = 'All';
  final List<String> ratings = ['All', 'Bad', 'Good', 'Great', 'Recommend'];

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
    _applySearchAndFilter();
  }

  void _onRatingChanged(String rating) {
    setState(() {
      _selectedRating = rating;
    });
    _applySearchAndFilter();
  }

  void _applySearchAndFilter() {
    context.read<MovieBloc>().add(SearchAndFilterMovies(_searchQuery, _selectedRating));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Wiki Movies',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 5, top:20),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: _onSearchChanged,
            ),
          ),

          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 12, top: 5, bottom: 5),
                  child: Text(
                    'Filter By Rating',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(width: 222),

                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5, right: 12),
                  child: BlocBuilder<MovieBloc, MovieState>(
                    builder: (context, state) {
                      if (state is MovieLoaded) {
                        return Text(
                          'Total = ${state.movies.length}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      } else {
                        return const Text(
                          'Total = 0',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            )

          ),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ratings.map((rating) {
                return Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5, right: 13, left: 13),
                  child: ChoiceChip(
                    showCheckmark: false,
                    label: Text(rating),
                    selected: _selectedRating == rating,
                    onSelected: (selected) {
                      if (selected) {
                        _onRatingChanged(rating);
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0), // Set the radius to make edges curvy
                    ),

                    selectedColor: Colors.lightBlueAccent.withOpacity(0.5),

                  )
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                if (state is MovieLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MovieLoaded) {
                  listMovies = state.movies;

                  return ListView.builder(
                    itemCount: listMovies.length,
                    itemBuilder: (context, index) {
                      return MovieListItem(movie: listMovies[index]);
                    },
                  );
                } else if (state is MovieError) {
                  listMovies = [];
                  return Center(child: Text(state.message));
                }
                return const Center(child: Text('Film tidak ditemukan'));
              },
            ),
          ),
        ],
      ),
    );
  }
}