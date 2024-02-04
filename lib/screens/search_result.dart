import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/screens/movie_view.dart';
import 'package:movie_app/services/api_service.dart';
import 'package:shimmer/shimmer.dart';

class SearchResult extends StatefulWidget {
  SearchResult({super.key, required this.query});
  String query;
  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  ApiServices service = ApiServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade500,
        title: Text(
          widget.query,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: FutureBuilder(
        future: service.searchMovies(widget.query),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<MovieModel>? movies = snapshot.data;

            return ListView.builder(
              itemCount: movies!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MovieView(movie: movies[index]),
                          ));
                    },
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey.shade700),
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            height: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        movies[index].posterPath.toString()))),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movies[index].title.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 17),
                                ),
                                Text(
                                  movies[index].overView.toString(),
                                  maxLines: 2,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  // Start of the rate and star container
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          '${movies[index].voteAverage}',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Shimmer.fromColors(
              baseColor: Colors.grey.shade600,
              highlightColor: Colors.grey.shade300,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  );
                },
              ));
        },
      ),
    );
  }
}
